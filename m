Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89434CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44E99402C5;
	Thu, 16 Oct 2025 00:04:06 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5C04C40273
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:04:05 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b6a0a7f3a47so21485a12.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760565844;
 x=1761170644; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3Aoq0z81aEDqs2NQRhqKi0Phf1WPTlAb0kjdVpOptA=;
 b=a3fWQt3VNVWd5IxLy6MFFD+idFXEbG/ztqdo+LC3MDNkeT73K0mGCBKh7WoQ/USxgh
 0Qr7U8b8VawJZmiV9njJeWldr/lHVh/CoHHQacq3UJsVqj069BK9RDfLyXa4wjgIJyum
 /9RyL7vf8ZfEFX5hstUW1aoAbIpnv4/+fg843xa5DAq5ARjxIS0X11xk4WnNtrG3Awbi
 YXmeF9bMsd6HUgQ9n3K9f1gkd50YhqfThcYUCNsI7DVgd5+xrrYbKgEoFaLBAN7j77B9
 0qCevj9hf5mhb+CQt4lXhKjwnZP+JV6g1qVzCrF8H3jf0m42kCMJgC7jQtNACOXrnCwV
 pH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760565844; x=1761170644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c3Aoq0z81aEDqs2NQRhqKi0Phf1WPTlAb0kjdVpOptA=;
 b=lQ2oLSvd2mlkxH4da1hWVAXRxHQtLfLODxsgajAEOZfdn+EL4c1Xf+tVJbnYMK7Wg7
 vsz2b0u8Ozoaf/73+TFcCWLOnhAI7hhVcM6xAOCZ9a1wqUq7sLFTQm7X/pUiHv+zaaXS
 AAam1C2SEKow8ivchpXrLAoHB+0JAtJi04by1NbkiyBKM5i+Lx04Lsj+UkQ/b9WQ0Ga3
 mAVBeUyaBlFrpeyQYb7vsHFezLNfL+anX0EyIUNBcvOMDb2kILtvqhAwOioTld5oy+32
 RB5ZkZ58txjgP4474iFO5LES4148eLwqNiROIUdRQ29b5d/cJ/UvkC5tuDfTE/+Z37be
 LkyA==
X-Gm-Message-State: AOJu0YzZJJIhYlFQmIwHwz4C4u0ED2z4jgCY6Lnf52Hf8RFgJy1C5wLK
 ssWvFhXxH3VV7OjeAnc0Mz9nzsj0/cnmNFd5PqLUZFWhqd/raIU7q60b95AWJQavYWFNyTusrIV
 Pu8QbXJ0=
X-Gm-Gg: ASbGncuYV2RHicgrPmzEsID3hpVAi+NNR6SV9c7MN24MHqCc/d4gVVinQXh6/Oq3Ihl
 TK8N49gTaYsiXj7ap64XE3pFZmDFTbNPasH/u1mlwHybOx869VshLQXWg2FlZJZUuKtYk0aU3Yg
 BXSHWgsbiJ8vhvlL096NhVpHfmaCsxDNtG5AS9Rn5q4/ZYdHhSelXZ1HF+i+QLiHEWLvX1qwlbt
 wiZ1x1j3SUojUDkGRXBp5gnpmDWbDnmsRR20PwCFYZdNK+QdrA+RUP/mtbboGcz3OJnmZuQqQL9
 Z1mTQBZMNzCFJlgi3HkKx3s8EzGzIKBkR8sQl4NgXfnkupD7nn+YXAN2d3tHuNPsVxP3BT5Xhze
 zI7mEADOk/TEiCJssgOZSJ4udvKduYfJasnONjg/RxIJFnn8KPaZXHuJuHmens+IjYHb4C9532U
 Bjz4Y9s1W1m5NpqAyEce+HLtgtltYtVDED1UK8+fsQRhJzQPS1kWB3
X-Google-Smtp-Source: AGHT+IFsHQURGc7oOj8wu61AhICELy/TPEcVN6Jrii6+JDAeH2G42uOmsmHcDHni+bX8CzjO3Yx1YA==
X-Received: by 2002:a17:903:2c06:b0:24b:4a9a:703a with SMTP id
 d9443c01a7336-29027373d80mr415476585ad.17.1760565844089; 
 Wed, 15 Oct 2025 15:04:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a3d3sm6867185ad.20.2025.10.15.15.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:04:03 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:04:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/20] Wangxun new NIC support
Message-ID: <20251015150401.60b5cc80@hermes.local>
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
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

On Tue, 30 Sep 2025 17:59:32 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> We have released a new NIC series: Amber-Lite, with two models
> supporting 10G/25G and 40G rates. Due to minimal hardware 
> differences from existing 10G NICs, it remains supported within
> the txgbe driver.
> 
> Zaiyu Wang (20):
>   net/txgbe: add basic information for Amber-Lite 25G/40G NICs
>   net/txgbe: add new SW-FW mailbox interface
>   net/txgbe: add identification support for new SFP/QSFP modules
>   net/txgbe: rename raptor to sp for Sapphire-specific code
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
>   net/txgbe: add support for TX laser enable/disable
>   net/txgbe: add support for TX queue rate limiting
>   net/txgbe: add support for getting PHY ID
>   net/txgbe: add thermal sensor configuration for Amber-Lite NICs
>   net/txgbe: add RSS for Amber-Lite NICs
>   doc: update for txgbe
> 
>  doc/guides/nics/txgbe.rst                 |   8 +-
>  drivers/net/txgbe/base/meson.build        |   2 +
>  drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
>  drivers/net/txgbe/base/txgbe_aml40.c      | 160 +++++++++
>  drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
>  drivers/net/txgbe/base/txgbe_devids.h     |   9 +
>  drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
>  drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
>  drivers/net/txgbe/base/txgbe_hw.c         | 365 ++++++++++++++++----
>  drivers/net/txgbe/base/txgbe_hw.h         |  15 +-
>  drivers/net/txgbe/base/txgbe_mng.c        | 184 +++++++++-
>  drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
>  drivers/net/txgbe/base/txgbe_phy.c        | 127 ++++++-
>  drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
>  drivers/net/txgbe/base/txgbe_regs.h       | 103 +++++-
>  drivers/net/txgbe/base/txgbe_type.h       |  70 +++-
>  drivers/net/txgbe/base/txgbe_vf.c         |   2 +-
>  drivers/net/txgbe/txgbe_ethdev.c          | 390 ++++++++++++++++++++--
>  drivers/net/txgbe/txgbe_ethdev.h          |   2 +-
>  drivers/net/txgbe/txgbe_ethdev_vf.c       |   2 +-
>  drivers/net/txgbe/txgbe_flow.c            |   2 +-
>  drivers/net/txgbe/txgbe_rxtx.c            | 203 ++++++++---
>  drivers/net/txgbe/txgbe_rxtx.h            |   3 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
>  26 files changed, 1937 insertions(+), 202 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h

Please add (as follow on patch) short summary for release notes for 25.11
