Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E91D46BE6
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7085B4014F;
	Wed, 28 Jan 2026 19:27:20 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id CDB484003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:27:18 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso1059925e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769624838;
 x=1770229638; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ECUejSIOSu3Yfqvny89SgrYXTR82QkQT8uk2XNCiRA=;
 b=q16vwlRynwe8mzgd/QlMuzmGwQYLP5n00HLgEDM/3noUr05/n7/2c8itN6b4mBL5W8
 oln4n61QmyRNjQGUi1a6GTfwfg+aZHdTKv/NhP3LYxqs040thr0m06F/BQ1gii1rl0bM
 rMpIZzfk26dZz/ulbpEgJoWJjUSZmDyaQWk9RfqaYWbgAmWube3PYEDHk1Xw8SV+AzlH
 SJPr3ciI3PgAFlH8i6iwCaZ0K2+33k5qihi4DCbXhoCyySIXJaakLgh7AHyuHad3ohlT
 ZDUhoHu7/1iRHIdCDHSWoiY6y/5iXcas3u/dfV/fNtd0xIqPz2s9BAkMtpGTZcy9kNq1
 yF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769624838; x=1770229638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3ECUejSIOSu3Yfqvny89SgrYXTR82QkQT8uk2XNCiRA=;
 b=fSIg7ej3EBOEKSvLVLMJqctV+HNpgbupAUCHVm2W9h3k4/MeORc+nIynShke/Tzw0z
 izM+qHMxL+GBJvQimLLsuN9S63LwaY8fk9xxgk+DcdPJ5YDk8ld5my+YlRCoT/SMw4c3
 qQWJeKrdJy50gz+8NhHpR/ZfSmMjQb3E/lCG1pgYUsD1EBobTUClshF1TUapakITMaZg
 IeD/LIBgPjodFvQSOyOSGz8DAVjTfnP5gRWgRZQjlGEaf5ZaQSpH0zcTzxm09IFMU7NG
 TlCiyKGGbLCPJXf+qGI02hUmeTAOcQVYhR9TsR35hlQxT0ou569e6ljdX846UefG251J
 gIDg==
X-Gm-Message-State: AOJu0Yx1+jKTl721MGwtkem0iepnTJNES0h+9VenjZYr4pnJYMp8bVmL
 6s0RXUv9V6s2KLcUSzqQmrVE2f0mzhkjOGZ30vmKWdfUXLeU88B9nryZBrtbX1QZHVw=
X-Gm-Gg: AZuq6aKhdPdmfB5okOVIT7mTwqZX5u5FGxFc0iIJ2nYZL6OwGxV9ocBo2+C7EkTtm9C
 qs1OP3ZIYabYiql7KjPjzRkJgw3oHmJzANTlf6Y6iiLYnD8pGBdq2DIruGd4c6jiLUwulV1iNnz
 xH+EBrSwKCYtk31jgCq/gjX09ZvGGFazOXkFI95CyAdCLQ+J3anwQHYUtcCIEsT8swMHAN9HRSg
 0F8hNuIq/yAPRWGwWRf2aRJLcPkAj8raRKvAds1SiJ5Dq0WArax1+f109c9xH2aNCARdF6b5K28
 gEH80RouTatR7kaTZD8b5ku5g9v2qrU0SXxrUNNmPIe6tf2FasGnjeO6nhL7iaMhiYmEn5OKrrX
 Vn5yZr3dxeabomkm1Ow7hCXf7lKIkBEZKvzZVQg/K90+O6uTkiP9xoS2KsGoFNOxdRRBverx3tH
 7bWbVv9RA6zbNH8CGwxg8yCoSIUFwth6MsKGoCm3qHBBhMHv7mC/15
X-Received: by 2002:a05:6000:1a86:b0:432:8504:8d5b with SMTP id
 ffacd0b85a97d-435dd1b819bmr9011390f8f.50.1769624838338; 
 Wed, 28 Jan 2026 10:27:18 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132368csm8020425f8f.31.2026.01.28.10.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:27:18 -0800 (PST)
Date: Wed, 28 Jan 2026 10:27:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 4/4] net/af_packet: software checksum
Message-ID: <20260128102710.0b205120@phoenix.local>
In-Reply-To: <20260128093607.62908-5-scott.k.mitch1@gmail.com>
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128093607.62908-5-scott.k.mitch1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 28 Jan 2026 01:36:07 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> Add software checksum offload support and configurable TX poll
> behavior to improve flexibility and performance.
> 
> Add rte_net_ip_udptcp_cksum_mbuf in rte_net.h which is shared
> between rte_eth_tap and rte_eth_af_packet that supports
> IPv4/UDP/TCP checksums in software due to hardware offload
> and context propagation not being supported.
> 
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

This is failing CI build, fix and resubmit
