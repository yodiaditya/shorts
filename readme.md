# Zero to Viral: Tiktok-style Shorts Recommendation

How do you recommend short videos when all you have is the raw file and no metadata? The explosion of user-generated short videos demands a reinvention in RecSys. Leveraging Generative AI and techniques, it’s possible to create systems delivering both viral hits and hidden gems.

Presentation at Google Dev Fest 2024
https://gdg.community.dev/events/details/google-gdg-jakarta-presents-devfest-jakarta-2024/

Watch 15-minutes Youtube videos of the full explanation 
[http://youtu.be/wN3T5NCTSAY?t=15744s](http://youtu.be/wN3T5NCTSAY?t=15744s)

[![Watch the video](https://img.youtube.com/vi/wN3T5NCTSAY/0.jpg)](https://www.youtube.com/watch?v=wN3T5NCTSAY&t=15744s)

Free free to give star ⭐ for this project.

## Pre-requisites 

I'm using Ubuntu 24.04, Miniforge Python 3.11 and 2 x RTX 4090 for this. 
You can adjust accordingly. Here is the replicate the experiments

1. Google CLI ( https://cloud.google.com/sdk/docs/install#deb )
2. FFMPEG GPU NVIDIA works for Ubuntu 24.04, but issue on 24.10 ( https://docs.nvidia.com/video-technologies/video-codec-sdk/12.0/ffmpeg-with-nvidia-gpu/index.html )
3. Gemini API Key ( https://aistudio.google.com/apikey )

## Preparation 

```
pip install -r requirements.txt
```

### 1. Download Youtube Shorts Datasets
This will require 31GB of spaces.

```
gsutil -m cp -r \
  "gs://shorts-hdr-dataset/videos/sdr" \
  .
```

### 2. Process Raw Videos
Run `convert.sh` in the folder of SDR. This will convert all the movies into compressed and 1 FPS (Frame per second). Reduced into 2.7GB.

### 3. Upload to your GCS (Google Cloud Storage)
Gemini will read the video from GCS 

```
gsutil -m cp -r * gs://YOUR_BUCKET_NAME/small/
```

## Create Recommendation

Open the `shorts_recommendation.ipynb`

The result 

```
file	title	cosine_similarity
2	SDR_Hobby_v4op.mp4	Serene River Flowing Through a Mountain Gorge	1.000000
43	SDR_Hobby_rdby.mp4	Fishing Perch	0.637745
19	SDR_Animal_svq5.mp4	Orange and White Kitten Exploring Grass	0.616769
15	SDR_Hobby_rl1n.mp4	Northern Pike Caught on Lure	0.578450
27	SDR_Health_1p77.mp4	Nature's Consequences	0.573209
```


## Results

You can play around with the `final_df.csv` and load it into ipynb.

## Credits
By @yodiaditya. Happy to connect with you over linkedin and Github!
