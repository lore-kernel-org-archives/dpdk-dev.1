Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243AC9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E7DF40E2B;
	Sun, 18 Jan 2026 20:13:47 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 90ADC40E18
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:45 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-65378ba2ff7so6247416a12.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763625;
 x=1769368425; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gA5SpZ8sHy9vOIYD24+jv6NVlOkHKopN6BQZTjRQ7jw=;
 b=ldma2ofTF4E6cUJ3nJCSxazo+vwVjKvR7uvmgHDPXmK48ky0T4C05QZIHDB5HHkX50
 wlKJjLv2rOuMqd1BIsySamz+JHNLwPv/Xy+LF7z+WR8KILkkJCAXfPQmebAYbWRFUXRU
 OEoEd5Pz+NOdOchOsJqmj5daJiC8YTxyviGjPokxmiMRRazEZ5T/DxLLIngxFTb8rWDJ
 sgiTzIw7qAZtd65fJVmtmIG2EbJHReGQz+t0MSkz1LBfUBt+EknPyin4Knp0JVWZdfpb
 drZ0qOxXb28rwai5XTjnUvGZ2ftbOG6ytNiKzK7BAdCx2Eo9MgXUcLJpY6rGrlTXYHBi
 9C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763625; x=1769368425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gA5SpZ8sHy9vOIYD24+jv6NVlOkHKopN6BQZTjRQ7jw=;
 b=Dt2S42hmSiyCMkKycGn1pzVimirkx8vpODvYSWws2U1BwLuCWeV77DYXJsDzpzN/g3
 i04q44Ij749Qdy6YcEU7RRyxaDQxB/S/hZJelvoHpqdrj6tadGlCmFIc0gcWaT/2dz6O
 AyEL9URLK5FmQcga5RV6sKd9GBEtSQMDuUHJ44b9YWyguSQZcyTbRpyUWBD1MfTvLCPz
 ZUAZBj+g4LpT6YXtsqtZ/yckhFTkPCvv9KJtAiZN33IEUiuZR93kgITkd8CMhGjNnIa5
 eR2INQDPwLNBbT2WFB7LNzsGJ6yHntMFHNaLYEuscmmypFDrhxrluozj9eNu/JCUi4Rz
 k1Og==
X-Gm-Message-State: AOJu0YyEYp2FzjegyUbtJr9+bJQS1WZyLz5HYZBJk8y4/bfsY859hI6B
 8ub2swqAPNNNkavsGJhEnVgwkin5D54s6Y/PjBOemgcMMvSblVWHc5Xv62AjohElUoqXLmbtwcI
 U3BLs
X-Gm-Gg: AY/fxX5zlTShgf1QH3IwgepHGqPg2GGtq6XSJJKEv6bNh9OOGoovWisuF59vnIu4J0B
 O7flIq1bR4y/rH4SnHoQ2sljqvh3fYLYPWxde/2Cgx7uuTrn2D0eJZAdeaRnBW+9C0gN8b+dk23
 Dh4Wd5If1/XFgoglYDJn8fRUUqA18GeI23keW6Hz2Zi714l1pq0UHmXRWc5HRDNoXO5vOhbb3ms
 xzNTrkAQNp07vjwIWZGRIoMnSCIoY++dyrZ9ElcSCJYspPmYcPhAMtApDfnOz1Xrd5a0tAVlpO8
 sb4DPSzIfoT7gid4n+saYcGS9kk9T2XCUj8L7JeatfddcsX8t3CEQmIdw1xskbBC64TlE+GkPc5
 264fBa+upmK20jlAW4CK/LLPqTy9ClJScni3c/1q4pFUo32zIvvuI8lJk0vRjKLNQa6hmRorDQm
 eQVkr2sEhfYKRYn0qtCPpVdLA0p9sSHxLhSePiBlXHN4IDF6A/Ww==
X-Received: by 2002:a17:907:940a:b0:b84:206f:c0c5 with SMTP id
 a640c23a62f3a-b8796aee53emr758345366b.34.1768763625126; 
 Sun, 18 Jan 2026 11:13:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 10/54] doc: correct grammar and typos in bbdev guide
Date: Sun, 18 Jan 2026 11:10:13 -0800
Message-ID: <20260118191323.241013-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Correct several documentation issues:
- Change "Each bbdev devices queue" to "Each bbdev device's queue"
- Change "it's" to "its" for possessive form
- Correct typo "ressampling" to "resampling"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/bbdev.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/bbdev.rst b/doc/guides/prog_guide/bbdev.rst
index 8abb0e9c88..4edcdb967b 100644
--- a/doc/guides/prog_guide/bbdev.rst
+++ b/doc/guides/prog_guide/bbdev.rst
@@ -125,7 +125,7 @@ device, if supported by the driver. Should be called before starting the device.
 Queues Configuration
 ~~~~~~~~~~~~~~~~~~~~
 
-Each bbdev devices queue is individually configured through the
+Each bbdev device's queue is individually configured through the
 ``rte_bbdev_queue_configure()`` API.
 Each queue resources may be allocated on a specified socket.
 
@@ -168,7 +168,7 @@ Logical Cores, Memory and Queues Relationships
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The bbdev poll mode device driver library supports NUMA architecture, in which
-a processor's logical cores and interfaces utilize it's local memory. Therefore
+a processor's logical cores and interfaces utilize its local memory. Therefore
 with baseband operations, the mbuf being operated on should be allocated from memory
 pools created in the local memory. The buffers should, if possible, remain on
 the local processor to obtain the best performance results and buffer
@@ -1232,7 +1232,7 @@ The FFT parameters are set out in the table below.
 +-------------------------+--------------------------------------------------------------+
 |fp16_exp_adjust          |value added to FP16 exponent at conversion from INT16         |
 +-------------------------+--------------------------------------------------------------+
-|freq_resample_mode       |frequency ressampling mode (0:transparent, 1-2: resample)     |
+|freq_resample_mode       |frequency resampling mode (0:transparent, 1-2: resample)      |
 +-------------------------+--------------------------------------------------------------+
 | output_depadded_size    |output depadded size prior to frequency resampling            |
 +-------------------------+--------------------------------------------------------------+
-- 
2.51.0

