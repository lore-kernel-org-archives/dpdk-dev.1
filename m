Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997E5CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 16:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78108402BC;
	Wed, 24 Jun 2026 18:43:12 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 4BA2440293
 for <dev@dpdk.org>; Wed, 24 Jun 2026 18:43:11 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so2618377eec.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782319390;
 x=1782924190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zJ9lMrkDzkXkH1q1wm2sVQZS2tj4u4wR3SEYgwJDNY=;
 b=JI/Sz4BUPFKlZpPKuEPIilfx4pJPnqULHF03KI2JuMVd8GpJz454Wy5k+ZAQxuTTXC
 r4WRnJU6sMGij5FdpsuHEM7fE4fnJeSzyfcO2zDFqQ1HkbZLqU6zQwoj+KPVYeHRHST4
 1rXPJJL5eecQ+jDDBv5XI4WLZVVrpuZXnbTHhfOAo08BFQxn/c61xLjtaSe/VQC4Mj67
 sGbgVq1YvFJsfQVQC0AabR1zUT85XtEiHR2jv4Oop3I2ihq5NRZ+pXcDffQu9TfVo6UC
 N2Sag59IHIScc3k01ZrfVq5JfwKnmHSGdT3u6urEimmZVPRQtfLX6S0SuHcj310P3hbd
 Gy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782319390; x=1782924190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9zJ9lMrkDzkXkH1q1wm2sVQZS2tj4u4wR3SEYgwJDNY=;
 b=XEhWU2Z7iTXD0MiDlLK+Bns9ND/xR3gB5a17ptEF+7cjUYDpQ8ED2xrCXlddEB+ubF
 YLxxBprdKOc34P5OdRzkejJs4bmp/XYQbXCM/xJIiRTIBPthD45yv0JqbO7IND1TFH7G
 hHuYLoOno1m+m3ZshlqSN1e7wO1P+M1HBTUHztcZn1lnK9uprkPDyNpndai7I9ZPmA58
 HZCVvHF5U6eGgMzz/e5bArXXhXVSlhbenI+zGQQe4FMDztt2CRL8ECqNB/mbTDsCLd1y
 WLVHrx/kh/dqNZJt+jFVA0LR8UztxAe6cy8p+XR2TjyPN4fCwXqdwBhb9QRyQJ3k4n+W
 q7Ng==
X-Gm-Message-State: AOJu0YyrV3hZRtb7XWZ5WrJRNt6Fb7oVXlwEtHfsGlu33SJ5uDjI2/Pu
 A3MUdINfTf6I8yGWiEHnX71S1KG/QP1AWwpGsTUSJykCbiMsHMR0zFcAbevMVSp5s7eSLY6dPk1
 nXdmU
X-Gm-Gg: AfdE7cnrZGU29IUbik0LwurvzrUgPsjC2/90FA9pDWYvOQOCmiTmKTwKWtRZ4LbPvt6
 gfzVBMLo2MA1GWwEee8KrwftpadP0YPhEu/ObdlKgsJM4JdXAeQm9taoa7g5lsGb1ekEdxTDROx
 9mDnnNpf/+zgEi9bwcKrnJ5WjeMLTPAj4EgnXiVDI7nWdpub09svpLHUg1kC5gMn3A9EcwH7m3J
 FZtLQRUNSEvRMl6M/8Sk5+ib+bHmShdZsLffQFVy6EA2QHgYO5SCfKlbeHHB9q181FhbRn2rwX9
 8D5Eu8DRmAysMaNoBr0un5lx/GNw9aNlhzY7nFNCKk+PEfhikIOqwmLxEJaNL36LtagVaRa/vrk
 0WLoZRVlwMzzuzpaYP4ijFx2oSSsDflmT2zPTdS1zNfyT2ZkbYYy8ICHNmCSvWqAvASn1ehAorn
 B+P6Wdt6rcdMqTYtVv0OdwBJi3TW+ENgs5gsEqiLsGo+R/lU+lYX2E4JJH3oYLi1m6
X-Received: by 2002:a05:7300:cb83:b0:307:d4e7:b16f with SMTP id
 5a478bee46e88-30c1dc2196amr14132655eec.23.1782319389913; 
 Wed, 24 Jun 2026 09:43:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm360974eec.17.2026.06.24.09.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 09:43:09 -0700 (PDT)
Date: Wed, 24 Jun 2026 09:43:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 00/21] Wangxun Fixes
Message-ID: <20260624094307.6859e60e@phoenix.local>
In-Reply-To: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260624115254.20348-1-zaiyuwang@trustnetic.com>
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

On Wed, 24 Jun 2026 19:52:32 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
> ---
> v10:
> - Fixed compilation error on clang
> - Renamed unprefixed symbols
> ---
> v9:
> - Fixed several checkpatch errors
> ---
> v8:
> - Fixed compilation error by replacing RTE_ETH_DEV_TO_PCI with RTE_CLASS_TO_BUS_DEVICE
> ---
> v7:
> - Fixed inverted semantics of is_flat_mem to match SFF8636
> ---
> v6:
> - Fixed more issues identified by AI review
> ---
> v5:
> - Fixed issues identified by AI review
> ---
> v4:
> - Fixed issues identified by devtools scripts
> ---
> v3:
> - Addressed Stephen's comments
> ---
> v2:
> - Fixed compilation error and code style issues
> ---
> 
> Zaiyu Wang (21):
>   net/txgbe: remove duplicate xstats counters
>   net/ngbe: remove duplicate xstats counters
>   net/ngbe: add missing CDR config for YT PHY
>   net/ngbe: fix VF promiscuous and allmulticast
>   net/txgbe: fix inaccuracy in Tx rate limiting
>   net/txgbe: fix link status check condition
>   net/txgbe: fix Tx desc free logic
>   net/txgbe: fix link flow control registers for Amber-Lite
>   net/txgbe: fix link flow control config for Sapphire
>   net/txgbe: fix a mass of unknown interrupts
>   net/txgbe: fix traffic class priority configuration
>   net/txgbe: fix link stability for 25G NIC
>   net/txgbe: fix link stability for 40G NIC
>   net/txgbe: fix link stability for Amber-Lite backplane mode
>   net/txgbe: fix FEC mode configuration on 25G NIC
>   net/txgbe: fix SFP module identification
>   net/txgbe: fix get module info operation
>   net/txgbe: fix get EEPROM operation
>   net/txgbe: fix to reset Tx write-back pointer
>   net/txgbe: fix to enable Tx desc check
>   net/txgbe: fix temperature track for AML NIC
> 
>  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
>  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
>  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
>  drivers/net/txgbe/base/meson.build        |    2 +
>  drivers/net/txgbe/base/txgbe.h            |    2 +
>  drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
>  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
>  drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
>  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
>  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
>  drivers/net/txgbe/base/txgbe_e56.c        | 3746 +++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56.h        | 1778 ++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
>  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
>  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
>  drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
>  drivers/net/txgbe/base/txgbe_phy.h        |   46 +-
>  drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
>  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
>  drivers/net/txgbe/txgbe_ethdev.c          |  472 ++-
>  drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
>  drivers/net/txgbe/txgbe_rxtx.c            |  111 +-
>  drivers/net/txgbe/txgbe_rxtx.h            |   38 +-
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
>  26 files changed, 9464 insertions(+), 446 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> 


Applied to net-next.
If you want to cleanup some of the checkpatch warnings, I can swap in a new version.
