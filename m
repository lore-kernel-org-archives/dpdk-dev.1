Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E400C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 19:40:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8226C402B1;
	Mon, 30 Jun 2025 21:40:36 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5E3344025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 21:40:35 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-236377f00easo28986635ad.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751312434;
 x=1751917234; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzCB0VaIN6dSz2k5GAvUgU7KuOC/bIBj8UInZdKzP3U=;
 b=PPj5i3zLOe8roru6+8YstaAApvwf49MZ0E5ZPdwWEOxWO+QSLC/Ly82HxuJg5a+8sN
 LO8FQcye1VotQkiRKaIBrMpGHWpKjvFj9JGrCg1PqCsMMui8HR9tb9FqRPAN1zGsKc3c
 LaID8Qd3D4bbL/thlE0VmU4IL8ENAFaavURu62MLFgaF/D/eGK56ULD0/3xEHfYzF60c
 eTPH0PN0fq9QBtaT7IGPvfDhrEGHZTEclVJ2OIA6fwNAz7RzfiPq5DdY3II9YVus+vpd
 LiL9RBH7T3Q5uFg5RVHHo2i3mkUuuZGl2mCuDE+hJ/jCTn8eNgqnZqaGMDbfXfkBs3kd
 3eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751312434; x=1751917234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzCB0VaIN6dSz2k5GAvUgU7KuOC/bIBj8UInZdKzP3U=;
 b=hSRTLHYtrgPQzwhWx4wtUt+qWKUCsdKcouTvmGMVzomEUPtkL3KhlAX/IlKWSJKetC
 q9sX8vEcDXENSsIhCwfQ0pl0qQHnzue5FwVX979rOAoXAkl2UElu43X+pbaAtnAbaRkN
 CMHOFmtLBJT3Z1xVJd5a8qMtX3c5m//IHwj6PXzvMqOtNKXfMj0kRS2zymMT3p1A+zyi
 1iH/ExB5rZhQKxObzN6zECibvb8/pZx4YSucKtNMbCUPrtRAe4brAPGHwxU9V1aVTdU2
 /xlJoN8skh0p1FWhi15HEjpiYLNVJ0kSMtcr44l/W70qFHUJgb7IYCUdHMFvfOncRYSU
 IG6w==
X-Gm-Message-State: AOJu0Yxc/1fALvvZJQEKvF1KwX8ihfLcGZIvSbScIU35S93TDoXvxDqt
 gMLClTAgWQtMRYTL7crvWQHFfTbVpp3sShy/i9UAcislbyGlqn2NFLg25VCIc5GLTNRQeDntzlr
 Ds1jp
X-Gm-Gg: ASbGncvcrx0vp/KqE8dwoHr/Lm/6svNXDdfZ2dHMoDhDg9x7bJ+U6eaepmbVUP638G4
 33ZAVlb8nSwX3Fqypkl9JPaJDfHky3oTfXhRi8gcgz07VJt2IswGkRT3Tw7xPLLUh1y8MdnE2Pc
 sYWfB0GGvFPW9PqgayUNn4Gf7Zcaao7CG2+ZdyVa1190TNdy4j71hBDcB1ivrk3Ja/2cjp2kVbv
 hmF5CFIrA3o7rQlALn+bWnxuTwd5jR9C58ViW8HcWAifCiDw9ZjZ+a5sWZMEVLYfRNeYJ+qsWYo
 7ELQKrVM2ubMbOU5KPOOtbHUzqB9oWnP/zzGtEafQJLLfhAIZqUrlVriwKmfv9m425nGq2oWlmj
 US8v7vU+H4c3X6x8HW+c7lQzxMij7FZ1klToPf4btsmDus8OURw==
X-Google-Smtp-Source: AGHT+IFJI/rGkKWdJKvwfHqHxE4KOndJjY34EIxHamsMXSiEUCJ9KVnW8XjNW+eEKKilXUYGCj5/4g==
X-Received: by 2002:a17:902:e80e:b0:234:9092:9dda with SMTP id
 d9443c01a7336-23ac4605c4amr285237995ad.24.1751312434152; 
 Mon, 30 Jun 2025 12:40:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f3541sm92128205ad.88.2025.06.30.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 12:40:33 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:40:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/15] Wangxun new NIC support
Message-ID: <20250630124032.328edb00@hermes.local>
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
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

On Thu, 26 Jun 2025 16:02:05 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> We have released a new NIC series: Amber-Lite, with two models
> supporting 10G/25G and 40G rates. Due to minimal hardware 
> differences from existing 10G NICs, it remains supported within
> the txgbe driver.
> 
> ---
> v2:
> - split patch into 15 functional subpatches
> - replace PHY configuration with mailbox cmd to firmware
> ---
> v3:
> - fix compilation errors and documentation formatting
> ---
> 
> Zaiyu Wang (15):
>   net/txgbe: add basic information for Amber-Lite 25G/40G NICs
>   net/txgbe: add new SW-FW mailbox interface
>   net/txgbe: add identification support for new SFP/QSFP modules
>   net/txgbe: add basic link configuration for Amber-Lite NICs
>   net/txgbe: add support for PHY configuration via SW-FW mailbox
>   net/txgbe: add RX&TX support for Amber-Lite NICs
>   net/txgbe: add hardware reset change for Amber-Lite NICs
>   net/txgbe: add MAC reconfiguration to avoid packet loss
>   net/txgbe: add TX head Write-Back mode for Amber-Lite NICs
>   net/txgbe: add RX desc merge mode for Amber-Lite NICs
>   net/txgbe: add FEC support for Amber-Lite 25G NICs
>   net/txgbe: add GPIO configuration
>   net/txgbe: disable unstable features
>   net/txgbe: add other hardware-related changes
>   doc: update for txgbe
> 
>  doc/guides/nics/txgbe.rst                 |   8 +-
>  drivers/net/txgbe/base/meson.build        |   2 +
>  drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
>  drivers/net/txgbe/base/txgbe_aml40.c      | 160 ++++++++++
>  drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
>  drivers/net/txgbe/base/txgbe_devids.h     |   9 +
>  drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
>  drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
>  drivers/net/txgbe/base/txgbe_hw.c         | 357 ++++++++++++++++++---
>  drivers/net/txgbe/base/txgbe_hw.h         |  16 +-
>  drivers/net/txgbe/base/txgbe_mng.c        | 252 +++++++++++----
>  drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
>  drivers/net/txgbe/base/txgbe_phy.c        | 127 +++++++-
>  drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
>  drivers/net/txgbe/base/txgbe_regs.h       |  95 +++++-
>  drivers/net/txgbe/base/txgbe_type.h       |  66 ++++
>  drivers/net/txgbe/txgbe_ethdev.c          | 373 ++++++++++++++++++++--
>  drivers/net/txgbe/txgbe_rxtx.c            | 201 +++++++++---
>  drivers/net/txgbe/txgbe_rxtx.h            |   3 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
>  22 files changed, 1946 insertions(+), 215 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
> 

Haven't looked at this in detail, but it is too late to get
this new NIC into 25.07 release, will put it early in queue of 25.11 reviews.
