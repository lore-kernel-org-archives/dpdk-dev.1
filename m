Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212DCCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 15:44:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B284B4026D;
	Sat,  9 May 2026 17:44:42 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id E16FF4026E
 for <dev@dpdk.org>; Sat,  9 May 2026 17:44:40 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2f3c623322bso4780740eec.0
 for <dev@dpdk.org>; Sat, 09 May 2026 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778341480;
 x=1778946280; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVS3O5vGrO0XxjOoBP50MXFO/cWD2ug+52191dIpi38=;
 b=YT4jXlvAeRXf8VeU91xmHFX/TPNMiXqTbRgqXrQ8M7Yz/6bHB6KWeG5r2UeSPPitAb
 Z29y3GpH6GcXWlfI79ZOXgFQ4u6yrYCSwritjrQuwbCk4f/jz1GpN8HJ2TLhCoEihE7f
 pblezaJ7D6jW5FO5NEoxoKoZoZC9t0Qc0J9igpog3ukvJZAOnAxRMZKEzfQSZ0juXvj/
 rvVK8XQjuLbrIw6cd2Oln6oWmE1NXvts+DCi7LjT7idrcVwqzlS1vHS6sJGhYiTAbOgk
 ROBUFU8HL4pOALTcbUJ+sKaw2Zu0HomIguCQy0CrmIMbnSlclO20lebZ1SfU9i0JGqPm
 45Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778341480; x=1778946280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVS3O5vGrO0XxjOoBP50MXFO/cWD2ug+52191dIpi38=;
 b=cmMPqI5LJrk/u1Gp2acnn676tKDF0lyWzYyRfPuzwYUjBofRuxq6Y7iWl4EuzA8wDs
 +bY2Be1n3+JxVhvGiAH5uUmTf7LpcpkcA3B9C3PxKqKgEKY9OYcWgzz++CZzGL2NsuZf
 l31bTVLUikKwIT+7hxe8rGgboVTZzKpBTuQQW7wJjNITlZORIYUrNFEDcHC15kjTmNMZ
 ERLgC56Uogs5+0Cm38jzxhIwyN4zq2ppYWUk5/apTxJwQb/M7DRyoRahUcI+HAgJpYT7
 6bPMUsrQUhwTu5kHJ8eyT7hTr8W45MPkZFbtFYemhLfcY9LFzFA/UInSKmsZHcMKieb1
 R0Lg==
X-Gm-Message-State: AOJu0YzcINOQtLfzLeyU2GtqG7YvgdavauO9+7gwwv5HUPoSNVbU8Qfh
 ImKQJuiicG/ypiJxiVZ6La/E5l4/GGHCecHHX8JEFfYS47b1EKRe+QsO2RgNDmWOmuQBJRCZTTx
 07wOK
X-Gm-Gg: Acq92OF9D5KEQkqo9joo0+1aSJ9iTTMkcttx4pS0weFr5afd8FEovAqGD6n277qG/H+
 vY/xlmedys+h9GfK1kQuAIh51kXVexUM4g3M5dh1zfYC97e6G6Vog+5vLQtkzS6e4JpNlyRyI6l
 TBoxRi/pFmcf/sZ85hN3CYznw08n4Vq5seDFIsQJTBK5RxETrk39pR0ct/D7SR2L+IE89ATX+yY
 lxhmeFgrnvq4ceCU1jE338+34SfQ60kMJWClmAYuun2Gth9lCV+S4FsiPB6wdi8Eqhd+f0RB6by
 +jYzLxFohkxYm6zK2KYddfDYbHUhit6H92IKpSF2t9bePFVSoZb0cGSIhNXHIVOZZYsTcmHdS3K
 CqP+jrKekZye35ysagYHuyQflFhLuhqjamGOEJg6t1i+mlwx++ht4Nazi/4czdZ5YTxM5+mCa7c
 /hOPLiySybPi9jNDdjtOWgO8pzyu1AXz+jWbU=
X-Received: by 2002:a05:7300:df4b:b0:2be:142f:d499 with SMTP id
 5a478bee46e88-2f54c971297mr7981178eec.16.1778341479514; 
 Sat, 09 May 2026 08:44:39 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e381c9sm6418999eec.26.2026.05.09.08.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 08:44:39 -0700 (PDT)
Date: Sat, 9 May 2026 08:44:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/20] Wangxun Fixes
Message-ID: <20260509084436.1a016049@phoenix.local>
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
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

On Sat,  9 May 2026 19:28:02 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
> ---
> v3:
> - Addressed Stephen's comments
> ---
> v2:
> - Fixed compilation error and code style issues
> ---
> 
> Zaiyu Wang (20):
>   net/txgbe: remove duplicate xstats counters
>   net/ngbe: remove duplicate xstats counters
>   net/ngbe: add missing CDR config for YT PHY
>   net/ngbe: fix VF promiscuous and allmulticast
>   net/txgbe: fix inaccuracy in TX rate limiting
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
>   net/txgbe: fix get eeprom operation
>   net/txgbe: fix to reset Tx write-back pointer
>   net/txgbe: fix to enable Tx desc check
> 
>  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
>  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
>  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
>  drivers/net/txgbe/base/meson.build        |    2 +
>  drivers/net/txgbe/base/txgbe.h            |    2 +
>  drivers/net/txgbe/base/txgbe_aml.c        |  187 +-
>  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
>  drivers/net/txgbe/base/txgbe_aml40.c      |  113 +-
>  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
>  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
>  drivers/net/txgbe/base/txgbe_e56.c        | 3774 +++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56.h        | 1744 ++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2593 ++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.h     |  278 ++
>  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
>  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
>  drivers/net/txgbe/base/txgbe_phy.c        |  360 +-
>  drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
>  drivers/net/txgbe/base/txgbe_regs.h       |   11 +-
>  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
>  drivers/net/txgbe/txgbe_ethdev.c          |  414 ++-
>  drivers/net/txgbe/txgbe_ethdev.h          |    6 +-
>  drivers/net/txgbe/txgbe_rxtx.c            |  102 +-
>  drivers/net/txgbe/txgbe_rxtx.h            |    1 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   14 +-
>  26 files changed, 9350 insertions(+), 434 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> 

Review will be delayed because of DPDK summit this week.
