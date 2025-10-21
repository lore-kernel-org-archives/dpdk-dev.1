Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A48CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 16:17:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB012402E8;
	Tue, 21 Oct 2025 18:17:10 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 30629402A1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 18:17:10 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2897522a1dfso57880415ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761063429;
 x=1761668229; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ws6UUrVl1kkwZGxFFHX8zeI5mbNg4MCOV2QTpwZ9gyY=;
 b=jQVugyIymNbRTsg1V/SIxQyyYLIkioHy341oeSHi7c7iZA1vwqZvu2eydAgScbhrBz
 TpOcotgaVzZA/PTDE/pufBMufGar5o9kg0tKC+6EwDlhoa93Evq0JM5Sjv615DuWFFln
 g+IeIwuHOH17EIaLO73QRsINmnaNh9fzNrgEprAbW4Sj3oVo6X1F7NjPpaddJ6jajoQY
 nhQdtV/mip4AXfzqAD8UUWXkRiuaXAY6FJXyf7CKYRy32YM57EexxfTJZobM2r+r7tB/
 zTFH4BJQUdzLZgdT1brzHHILoU1KoO0YrxvX8EDXJATxY9xbJkl9vN8iZiW8ROesGaKh
 NELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063429; x=1761668229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ws6UUrVl1kkwZGxFFHX8zeI5mbNg4MCOV2QTpwZ9gyY=;
 b=hHo6u7Gu3kegleBP7TrkyIZWA7MmaXvyy6MYuJf3fl88Q+PClqWqODkG+0WZkx2Q2g
 IKxGai0lIDW/AL/eye7+ELpOW/pgQ04ygUpreugsLeL+s1AiU4dDS+39gS05Pac6bAYS
 ic4QjqjAA4zP0uqPrBtFrQDvEhLDu9Cjn7GSZw07X+Y0bmMQqmiyAVRpridUJFkkhgu+
 SoG/Qwi/yVv653sFreHAjSCkLJSwAnvot2nR9ZskThv2G+VRY1r5Pl0RRTCkOOo8UdM2
 mSnrAPorsDa6FHUu2SmzoeNqKl7USj8BQWuoqX92EkeO0ylBUk25SghFlEtqRH3Swan5
 6tLA==
X-Gm-Message-State: AOJu0Yw1i783/OhyvT5u8oI8Pky8Vwkbrqsv5L0z2ui9XzMgUumE2mjB
 CfEQ3bfkhaWZJnaCysN2CL4o09uFPIR1eVzpe2CEFe6MLtw5KzfzTyTlym6CB5P4xv7HlWKF7dT
 gnjPObgI=
X-Gm-Gg: ASbGnctZrEmv/e68C53NnpjBfIy/AbNM9bLgwc2hrFYoZG7UtApWUWYgW/e6L6WVkhr
 t9/7J2Gi3H1f3ogZK7pPcF7R0aTbb8otyQDsoQArDxXNOBDPEstOc6wRv61H6PcjkshkQVWkKWG
 FD6nlA8KkOlMAGB2dHUUchlH0kjJMDkI4YxqRCMByzRGt2s3Lp4TXH1OuCesNb5/Sc4mdGdiQrH
 R5r30L4Uzi+fps2CtEVZU0UqrR9JaDlw8Gi7s/pApb3O3dP0qtoAbYj5kXWyRfS8dY1WfYPXXCV
 ufsmdT+yL3Gpkn3eo6uE20OKsRtAcML9yvi0FiwhIcw/i6MFqznAGUyVTE208iNFnXc8/TgBr6F
 2a2wVz52RIc80pCDKyCNnwLdMF4pd2u3k7j/Be0CK3ut2IuBzwArtOAByIEYjtEoNdB0AnCLtNc
 fhY79dfaEkgeS7MNLknYFK8jhIowIPmU6WLVZg0K2y7ldePrN/dw==
X-Google-Smtp-Source: AGHT+IE2hmKHGaMmwPGSkO6dFM71W8TDyDITA1EeQHaYaYxmQQZ+0dD3nFJqkRJ6Y31gHCDsqWli4A==
X-Received: by 2002:a17:902:cf42:b0:270:ced4:911a with SMTP id
 d9443c01a7336-290c9c8a840mr215783865ad.9.1761063428951; 
 Tue, 21 Oct 2025 09:17:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471fed21sm113230715ad.80.2025.10.21.09.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:17:08 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:17:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 00/21] Wangxun new NIC support
Message-ID: <20251021091706.49182f32@phoenix.lan>
In-Reply-To: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20251016111736.25372-1-zaiyuwang@trustnetic.com>
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

On Thu, 16 Oct 2025 19:17:14 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> We have released a new NIC series: Amber-Lite, with two models
> supporting 10G/25G and 40G rates. Due to minimal hardware differences
> from existing 10G NICs, it remains supported within the txgbe driver.
> 
> ---
> v5:
>  - update txgbe guides, add more usage instructions
>  - add a short summary into 25.11 release notes
> ---
> 
> Zaiyu Wang (21):
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
>   doc: update for txgbe guides
>   doc: update release notes for Wangxun txgbe driver
> 
>  doc/guides/nics/txgbe.rst                 |  31 +-
>  doc/guides/rel_notes/release_25_11.rst    |   7 +
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
>  27 files changed, 1967 insertions(+), 202 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
> 


Put this version in next-net
