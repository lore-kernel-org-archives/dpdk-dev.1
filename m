Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F4FEFCE4F
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 22:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38EAA402EB;
	Wed,  4 Mar 2026 23:50:55 +0100 (CET)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 441EA402E7
 for <dev@dpdk.org>; Wed,  4 Mar 2026 23:50:54 +0100 (CET)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-899e87b04d8so74793586d6.3
 for <dev@dpdk.org>; Wed, 04 Mar 2026 14:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mauricegreenjr.com; s=google; t=1772664653; x=1773269453; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMUzzuLZ4/K6SvcWGuRJjpVCk1S0jHUbtTj/krOgLi0=;
 b=I2qHtsUTrnIqYmxfs/Dkb3YphNMrKN5VlZHh6yVSt0DWJSBU2mn9C0DeWIAR1mDuQS
 jMii5lxhRsDhDlwFBBMSCmNVwbP5ZBaqeBL4DsMHS4I+AVSStTZ60UISORsvRApHvYXm
 aXuEHDfXHGhy+ryru7ygqJgyQb4kgNgCu4/hFwY2TuTam+ThT9YAd9LkHGl0RsKMwIYy
 0mPd2rAfm42CMAXwcg2DerLzrlS1NjhFQurCkQyLcEb/aYaBdekw8nqLubgH9PqBvl7N
 wtzUtx1BBgH+ttXN2M5OS10b5OIirlrZq2LXPDcsDuuxUUlkwgOuTa0AwZdDiC4NOEUM
 vwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772664653; x=1773269453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KMUzzuLZ4/K6SvcWGuRJjpVCk1S0jHUbtTj/krOgLi0=;
 b=WNJHoGQqBq+I6Wfd52buR6y4BIZIszx9sSCFwLjt7SR8J92zjPgR7f4fE0ztSMixXt
 bEeGFFeeXME0DU0sfnXg7F9R6UxH9SibPEVPZXj/U64ul4XtN0XWgWgCuL/t4lagnaXk
 6fcIoQ62h9vctStp3wuhlR1gK7Gmk6k3wH0FBtS7w9L9BTORk1e8tabkvPFQbejVweSn
 nCzeiCw3037hQFpbEefox8LOUMsi8GlDXCBWWCThxvS48k5xvnQh7sYxO1Aa7MePUtrL
 VORWbLcm+j3HiBVqv+qN2Y6GS98tdgGTJOsiFd6Fdk5LPwKztOQp5+sPiw/xOdawlo2a
 VIDw==
X-Gm-Message-State: AOJu0Yw8yAWTTtaoyccQNZYTrI95U6lZRFE3zIHq8A3HIvQ7Uh5pI2WG
 Gx83mZLuqfjgZgQ1gvQ9GN7t2o6XOnjxMhyQ4cmH5BfiqI8Xpe7dBZlauMZP3Y4SR9k=
X-Gm-Gg: ATEYQzwELDrKq2GBI8R4RgmbQMIqAFzw6s9GdaIwuR49YHRbwgMe8+Z/ezEOyT6OCOt
 Fxq1RDxT1o4ai38BEK62HILYk9t6T4vg/WLMlS/R+f6Laar/SOHCDFgNWwMmiHvLB5/FgJvkKsl
 IAL9S+UjFgx/yfyV3Av2oAcCIFSKOKUucB1mdATHuvRT3fB+NU65QOjlX1EstfLN240C80QEl+8
 PyTp9U6vy2AJ85y71TtjDKebzFA9IfxHVHxIsO03HAyoVBcYPz7ZrOK/fAbRH2JsNa7PP6Qr4+y
 eOknuQUpS2qTogPmxoyB3HjYBaqDrpUszSZjuAoxjHAQhuRc7Fd3sjN8+YbdOe55fgK8o0X6ZOI
 dTsZinjJF+c3yp5m6G6Q/a6sQI6ZVgmcOSpvebytFerg5hjJhF+383yS+e0uRyUGdZQbeV96SjW
 06lm6QmvyZ3ZCOxt7voDYg4dhqeBlIxE0+tlpgrTIDZVRdyr1yC0lg/WtcaLoW0SJ6NUanFQ0bd
 jZ3
X-Received: by 2002:a05:6214:5017:b0:89a:181a:80bf with SMTP id
 6a1803df08f44-89a19e44bd7mr45387116d6.54.1772664653466; 
 Wed, 04 Mar 2026 14:50:53 -0800 (PST)
Received: from localhost.localdomain ([2601:152:281:a9e0:2164:d51c:5b80:c83f])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f940fsm1761455785a.23.2026.03.04.14.50.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Mar 2026 14:50:52 -0800 (PST)
From: Maurice Green <maurice.green@mauricegreenjr.com>
To: thomas@monjalon.net
Cc: dev@dpdk.org, eagostini@nvidia.com, getelson@nvidia.com,
 mkashani@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH 7/9] gpu/cuda: extend NVIDIA GPU device ID list
Date: Wed,  4 Mar 2026 17:50:51 -0500
Message-ID: <20260304225051.26238-1-maurice.green@mauricegreenjr.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <6937723.QfHCVqEBuz@thomas>
References: <6937723.QfHCVqEBuz@thomas>
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

> +#define NVIDIA_GPU_GH100      0x2335 /* H200 SXM 141GB */
> 
> As you can see it requires knowledge to get the right name for each ID.
> Not everything is in https://pci-ids.ucw.cz/
> https://github.com/NVIDIA/open-gpu-kernel-modules is a good source but not perfect as well.

Right, the naming is a little tricky since neither source is fully complete.
I wrote a sync script that cross-references the PCI ID DB and OKM repo to 
construct unique macro names. For the few entries with totally identical
descriptions across both sources, the device ID is appended as a fallback. 
Here is an example for the GH100 family:

#define NVIDIA_GPU_GH100_H20                       0x2329  /* H20 */
#define NVIDIA_GPU_GH100_H20_HBM3E                 0x232c  /* H20 HBM3e */
#define NVIDIA_GPU_GH100_H100_SXM5_80GB            0x2330  /* H100 SXM5 80GB */
#define NVIDIA_GPU_GH100_H100_PCIE                 0x2331  /* H100 PCIe */
#define NVIDIA_GPU_GH100_H200_SXM_141GB            0x2335  /* H200 SXM 141GB */
#define NVIDIA_GPU_GH100_H100                      0x2336  /* H100 */


The script also updates pci_id_cuda_map[] in cuda.c and I wrote a
test to verify both files are consistent.
