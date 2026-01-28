Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3866D46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:48:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDEE340B95;
	Wed, 28 Jan 2026 20:47:41 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id B0DBA406A2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:37 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4327555464cso197681f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629657;
 x=1770234457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PaOAE0DGWeExUghAPClFDCTks0+RFmPsAyAoCZlqLU=;
 b=oP/sSSZngFm+0hq/9T4/cwrgcC+0+E3gSavciKGS7w29EeCHi3iKj/8zjNHOUJabj1
 ieDxXuBWFoe4/MNBdMkO9ggqXzuS5kl41Rdz6d/eSrIhXMyN62QxoXFiFnEEZ2HYNMLP
 3qpNHKHzAUU9v+2K6MAiY2S2ESA+247DtbEq5N5ceIv8LY0CT6uGvl1+ZxejHbZOsqQV
 Fb0IAsqL+kXAr1FVpDXfh10zuro83RmUZP5tTPCI4bPTrGSztUcpeZ2eRJIDZPQkRe+1
 bnJTxTe03jsMWF2Cae4O1uXuou30CFmHbaUXpVmySVxoJQI6W83XmsooioAeQSXvJPm5
 EJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629657; x=1770234457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3PaOAE0DGWeExUghAPClFDCTks0+RFmPsAyAoCZlqLU=;
 b=TJv0QEyOgn7vknHcVx3Xx/6FqWdUNbNg6JmqinNLCMuyFBTBgq7cFczTx2tvwKkhLj
 qfsCnRiRntlvRBooQSnamAsyrlatH1wuwxc4skKUVQwtfM1mzcSAIIMDEs4JyONrk4nB
 0CeS+vyvmH3SD6qhEEztQ1bqGtLUd0T0zzKh3lCpwF5vCwp05MXJcK7HKom9/2WK6lR4
 LmSpgMhclsPNtewdbUC+4WFSQG1xJJK9vXOJ9r4Q0JgsOUw+KolMUm73MNBpifLgClfW
 jnxMLWMaHLg7lYLbBiAgHie8O2cQlECeDRbPnytQ5QE70EAgtia3ySQv8jap/dhUSnRl
 hZuA==
X-Gm-Message-State: AOJu0Yz2k6uj19xo80noLtWpylSHeTeoRm4RHv9FOdTrniiJ3mCnqF3G
 NH4vl2vjWgzzuGi0GQBtpSz9cnIkClF5vCCMPye+9auZLvqfIPBAD6Rt+qTwhoOttXlgoZF5Ssv
 KEjag
X-Gm-Gg: AZuq6aJ5xQBcrytcgb77zN0yeqA1aMlEmbfX1ZHVBqCXKE8391B42a0jdoE5jRyvW1K
 1ny1KWxKQpZAmUuBIn5Y9vntdghmHFSJz4M6YzGTk4LNREWrnxgo+KEV7BAlhcjRxYd5w2CO0Kw
 RYTsZ7c0/yz2PMJ6dcxVlCHqWx6xo6WBXf/Rt9cB0oFclg91HBUQ2BgFnsULxSYwJ24poq9p34a
 r/oP3zKVrDrJNGET2ChC4lSI5aCw1ak2APS0BZ4hvLrsai5rqEXckrWZPD0qRT6L78hlgaXUq1B
 0Ly1jfCYvCgA2uWeu3CNGRTnp47P3HpuWLffeVm/r/jBqgdoP5gaIqj87l8f7aCtWEpL/8TBYoK
 HwLEXVgOggl6jKXQUnrTQCEP4X0JPRD6QV9OorM5IGJHaToZh8OiHtlciJMzP7WEBOeek55hQn7
 5KsMMDNWVGCOUvn+o16BLddT3UlqSS0P8OfP/SriUG6nx0UAYBdWYrFMlnp+JN
X-Received: by 2002:a05:6000:2582:b0:432:851d:35ef with SMTP id
 ffacd0b85a97d-435dd1c1ademr10131389f8f.42.1769629657326; 
 Wed, 28 Jan 2026 11:47:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 6/8] doc: correct grammar and improve clarity in ethdev
 guide
Date: Wed, 28 Jan 2026 11:46:05 -0800
Message-ID: <20260128194722.480862-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

Improve readability and correct minor grammar issues in the ethdev
documentation. Changes include:

- Correct subject-verb agreement and article usage
- Improve sentence structure for better clarity
- Standardize terminology usage throughout
- Remove redundant phrases
- Correct punctuation in lists

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/ethdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index ffe3fb1416..7afcf0956d 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -7,7 +7,7 @@ Poll Mode Driver
 The Data Plane Development Kit (DPDK) supports a wide range of Ethernet speeds,
 from 10 Megabits to 400 Gigabits, depending on hardware capability.
 
-DPDK's Poll Mode Drivers (PMDs) are high-performance, optimized drivers for various
+DPDK Poll Mode Drivers (PMDs) are high-performance, optimized drivers for various
 network interface cards that bypass the traditional kernel network stack to reduce
 latency and improve throughput. They access Rx and Tx descriptors directly in a polling
 mode without relying on interrupts (except for Link Status Change notifications), enabling
-- 
2.51.0

