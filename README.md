Improving Mobile Device Astrophotography

Author: Kevin Sorto  
Institution: George Mason University  
Contact: ksorto3@gmu.edu

## Project Overview

This project explores the effectiveness of mobile phone astrophotography, specifically leveraging the **iPhone 13 Pro’s Night Mode** in combination with a custom **image enhancement pipeline**. The goal is to create sharper, clearer images of celestial objects using a consumer-grade mobile device.

## Abstract

Modern mobile phones struggle with low-light photography due to hardware limitations. However, companies like Apple have made significant improvements in this area. This research combines iPhone 13's Night Mode with a 4-step image processing pipeline to enhance images of the night sky.

## Key Features

- 📷 Use of iPhone 13 Pro for astrophotography
- 🧪 4-step custom image enhancement pipeline:
  1. **LIME** – Low-Light Image Enhancement via Illumination Map Estimation
  2. **Exposure Fusion** – Combines original and enhanced images for high dynamic range
  3. **Dehazing** – Reduces haze and fog using Dark Channel Prior
  4. **Global Tone Mapping** – Increases contrast and sharpness
- 📂 Comparison with older devices (iPhone 11)
- ☁️ Performance tested under different conditions (clear skies, clouds, motion blur)

## 🔬 Methodology

### 1. Image Collection

- Captured over several days to account for atmospheric variance.
- Photographed various celestial bodies including stars, the moon, and the sun at different times.
- iPhone 13's native camera app outperformed specialized astrophotography apps.

### 2. Image Processing Pipeline

| Step | Technique | Purpose |
|------|-----------|---------|
| 1️⃣ | [LIME](https://ieeexplore.ieee.org/document/7791161) | Enhances illumination in low-light conditions |
| 2️⃣ | [Exposure Fusion](https://ieeexplore.ieee.org/document/4376067) | Balances brightness and contrast |
| 3️⃣ | [Dark Channel Prior](https://ieeexplore.ieee.org/document/5540225) | Removes haze and fog |
| 4️⃣ | Global Tone Mapping (MATLAB built-in) | Improves final image contrast and detail |

## 📊 Results

- **Moon & Stars**: Pipeline significantly enhanced brightness and detail.
- **Cloudy Skies**: Stars previously hidden became visible post-processing.
- **Motion Blur**: Night mode handled shake reasonably; further stacking methods may improve results.
- **Device Comparison**: Newer iPhone hardware clearly superior; iPhone 11 results contained substantial noise.

> See `figures/` for full image examples.

## ⚠️ Limitations

- Only iPhone 13 was tested.
- Limited availability of celestial bodies due to weather and location.
- Exposure Fusion algorithm introduced some glare and noise.

## 🔭 Future Work

- Compare across multiple mobile devices (e.g., Android, newer iPhones).
- Test alternative HDR and tone mapping techniques.
- Experiment with burst mode and stacking under motion.

## 🧾 References

1. [Guo et al., LIME: Low-Light Image Enhancement](https://ieeexplore.ieee.org/document/7791161)  
2. [Mertens et al., Exposure Fusion](https://ieeexplore.ieee.org/document/4376067)  
3. [He et al., Dark Channel Prior for Haze Removal](https://ieeexplore.ieee.org/document/5540225)  
4. [Gupta et al., Star Identification via Mobile Phones](https://ieeexplore.ieee.org/document/9774242)  
5. [Astrophotography for Beginners – Space.com](https://www.space.com/astrophotography-for-beginners-guide)  

## 📂 Repository Structure
📁 improving-mobile-astrophotography/
 - ├── images/ # Raw and processed astrophotography images
 - ├── scripts/ # MATLAB scripts for each pipeline stage
 - ├── figures/ # Figures from report for easy viewing
 - ├── final_report.pdf # Full write-up of the project
 - └── README.md # You are here



 

