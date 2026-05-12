Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D758CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 08:26:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 473954060F;
	Tue, 12 May 2026 10:26:57 +0200 (CEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5BA65400D7
 for <dev@dpdk.org>; Tue, 12 May 2026 10:26:55 +0200 (CEST)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-392445f11c5so52885971fa.1
 for <dev@dpdk.org>; Tue, 12 May 2026 01:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778574415;
 x=1779179215; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKwnRDaRq2TdBnG+0IZY6Khkv01MSnaDFHEA4ABx6U8=;
 b=q1cJfAxI0cq5Pd5nGrcVyoCRlCBJ3sxty2WelCxqwsD/HLXingI+v5tvsN9hZUCEli
 O8da3eVDLddo8PnkTeWaKiSupqW5Vd4nBPEEJW2hfPZxpoh1RdtZfQyRjIMbH2u6/PcK
 kA8ccIKRIj5XwiEC42COMdX4Tm0IFs+/Dqv6pjeOHabeCLgrwtNNhYs3qC5ZEbY/xNHf
 AbZhtKaXLxXySo1WYEQ4l1A2K9rU4J9lSHKBfrb52NrEo35XjD1ppY+fVpwiyEdD45a8
 XOBMDQWiYOGE/ZPRcZZ4HrQx/SEzvpW33ufTljoIV2efUaCqdDs/VMQQHf2bLY3cHDyZ
 q2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778574415; x=1779179215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKwnRDaRq2TdBnG+0IZY6Khkv01MSnaDFHEA4ABx6U8=;
 b=RqIqSrD9ULN1rOkYeyKgQXLRwsDRB0PKp//XgKe0jYSUsMbb4gtBoPFLMp2RHHYzOE
 6Cu+6GGRdcd+AAc5kbizBaBX/TfuNPiHwU4MjesBnIpn3eKiVqx7fYuW9oZJveCsH0RG
 mxdru6au7Vo8F+ewZS/0XjMwOZCDfLyMF8Sg+3IPGq/na5uc9R9ab0FQkqnhgtwn1VH3
 fjJ8RQIFhkfiuGDD2slCfvfNkso/gVDvXsLqtszu6bjvoyyphZoRyoNucu8ob/VuWHvY
 utspSZDa9pbt5C9qkwniB6wDUK6obVYkGBiieI9AEDprACE1b+XjQJQl1eHP/YeJDNWj
 kPdw==
X-Gm-Message-State: AOJu0YzkLHbjpUQZZwMmzAvCKgtk7qWLYqCqu2s5kgslJ5+a6AVYdWhH
 s761Il0YxCrK3zMAPtkfJVvNBacKocP/to+/wX4u0p0nnagEsIokd7VVKIeMVLJw8LDWZ01W5oH
 0CEwV6tmBbQ==
X-Gm-Gg: Acq92OEnou6CTFFYC0Lv8ZedKRI5hpM6FuPRtunydIc503X0JKEOWzJ0TcB59k+cQ7S
 VsECZSKPud8241eMADDvDu3e7pIGztYrRyCS1aX8B69jsDOLme6PaYqPS/mZbB8aAi/KSUjCMPC
 NoVae/gALBLbXVKDe48ftFMOJTkCtBRYTP6PH6c2yjzMWdZBEPSMzRWWlkhScg9f8lAB60yXXH5
 nnyKmgl2SHP3/bv0DnrzHQTNx0/AxCzLSCk/9U9OizK7PWW8TDWZNXcQMRLHWNtIwgeHJjFyB69
 ct3ALeMVR7ScJM3NowuklrhKuKYuLHPX8dSAHKfFK8IuLvLjGJKmkxFgm6kfDVCmLwaPzF2smoW
 8GKo23Peui8pldkfrJc6Bcsf5O6ObMtde1agMGD1hfJ+m96ZJY/vT1vSEBrRXrxgHFEGCEedfgE
 TpsL4+n8w2WbL47KsGqEOgjso8EGnmt4zLW+b/FznNk+LHLReb2xs=
X-Received: by 2002:a2e:2e18:0:b0:38c:c0de:d58f with SMTP id
 38308e7fff4ca-3943865ec55mr6645171fa.14.1778574414736; 
 Tue, 12 May 2026 01:26:54 -0700 (PDT)
Received: from stephen-xps.local ([62.119.255.230])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393f5f3a2afsm32290331fa.13.2026.05.12.01.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 01:26:54 -0700 (PDT)
Date: Tue, 12 May 2026 10:26:51 +0200
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] net/gve: add hardware timestamping support
Message-ID: <20260512102651.643ddb8c@stephen-xps.local>
In-Reply-To: <20260512005404.946979-1-blasko@google.com>
References: <20260512005404.946979-1-blasko@google.com>
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

On Tue, 12 May 2026 00:53:47 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for GVE hardware timestamping on DQO
> queues. To support concurrent access, a mutex lock is introduced to protect
> admin queue operations. A mechanism is then added to periodically synchronize
> the NIC clock via AdminQ, and support is introduced for the read_clock ethdev
> operation. Finally, the RX datapath is updated to reconstruct full 64-bit
> timestamps from the 32-bit values in DQO descriptors.
> 
> Mark Blasko (6):
>   net/gve: add thread safety to admin queue
>   net/gve: add device option support for HW timestamps
>   net/gve: add AdminQ command for NIC timestamps
>   net/gve: add periodic NIC clock synchronization
>   net/gve: support read clock ethdev op
>   net/gve: reconstruct HW timestamps from DQO
> 
>  .mailmap                               |   1 +
>  doc/guides/nics/features/gve.ini       |   1 +
>  doc/guides/nics/gve.rst                |  18 +++
>  doc/guides/rel_notes/release_26_07.rst |   3 +
>  drivers/net/gve/base/gve_adminq.c      | 127 +++++++++++++++++----
>  drivers/net/gve/base/gve_adminq.h      |  29 +++++
>  drivers/net/gve/base/gve_desc_dqo.h    |   8 +-
>  drivers/net/gve/gve_ethdev.c           | 148 ++++++++++++++++++++++++-
>  drivers/net/gve/gve_ethdev.h           |  39 +++++++
>  drivers/net/gve/gve_rx_dqo.c           |  26 +++++
>  10 files changed, 378 insertions(+), 22 deletions(-)
> 

Please rate limit submissions to mailing list to one series per day.
