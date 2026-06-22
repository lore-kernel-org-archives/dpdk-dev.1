Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB400CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 15:30:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BDF240150;
	Mon, 22 Jun 2026 17:30:06 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 3B71440144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 17:30:05 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30c03b09e02so7813826eec.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782142204;
 x=1782747004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3suTNs8XxoMlL0B7AKHCujrEQ0yop0AHYzYb13p/gw=;
 b=OE+luGTPAZ6NJN389aIp3JZrNziJkPKaL/0+2k5wico6eWPs7sUkrLaHJnrhR3g6Qp
 J62+6UtzNyypCbI9vG7+RXtDwz46jqtfvDFhaZTl7frqvmMK3MtW54npEMNuqGP8M2hP
 nmVbYWpgPmEFvm5T8By9NuCA78GeGVkWtdHBub6ibS8r3QYOvBKU/I9PL2M7LQHUpzds
 xaCKnJp2af+8OAWScpJS30eqF/HQW5Y7zS3lSx1zNF9P9Nq71R23MHngf5upON4vIfxc
 XvJrpyXdg4eyv4xRUUpS4mGEgtpgk5PRfnEs3WiEGEhRbO9E8CPZDX9MkHqs9p3q/CY/
 tOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142204; x=1782747004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3suTNs8XxoMlL0B7AKHCujrEQ0yop0AHYzYb13p/gw=;
 b=a4sqPeFSGfggKjGIXSCCH50A1fC77AgAuSKOXd6kTc0zpnST7mFfNHd1L9I9lgtTx7
 cHzakOCsV3Ib3+8iQbKIcwHvTqSHz2UPeOX+UIfqBSHRWUM/c29J+vljokq3K2FD7meI
 W2S5pncaemyGHgNQzu/pnhYUXcgrv+NxbGFQrprOAoBZe6pzE5ofhItbpxaHth7TUdC2
 /dhJ+W650QDbsxzM2kNYoPV6RSPHEojfopKmFXkbijXE0deTDgl1H5sirkKpvqi1KrBQ
 xZEi+uFAwudx3LK98aCT0z6DS49LpbfQQpLrmV+UOmC3662hCyhijssUOCzKFC8lRUa7
 yfgQ==
X-Gm-Message-State: AOJu0YzMr61xQ40ehz7ubcteh/ZUs158HNj1ca/IOaqQ8UHpcHsoWyyW
 ODhFV7JB3jGW1X9s3qm50pkd9IvZs/p3q2U73DXBi4Ot9GNpPmTCiBYJ02wC1sW5AICpvPpWJSe
 9Ycj8
X-Gm-Gg: AfdE7ckx8At5zCeeaP/YxEOc30+zz/CPsuaEPXHztE98u208Ir28gRAa11WKXjOPmLK
 9VYdvzCyFf4Q3O5P1yYszs1hw9KbomJE1ODJypAVZzqoP0GEfXbYWFAEganfR5FSvOdH+oaL3Ev
 h7zkKf8GwL45BPf1YFaSvgSRhpPEkDBsFUvglxRxvzhKBhsywhOTRrGU0Pp1NHdqxz2w9878wXM
 cek7NytTYEEOXLnGAXhPyWM/snyPUghT0wNwrSUPhqE/sZosucHt02EuuBEp8uRTc+GIbFt1PhM
 Q1rN0XHQ+kB9o/kybOong4QXshsw/KMgJgCDRTn3ePq5XkboydYW+MXMXbuqEHtCcBY4yDZP/5G
 nigZb4JPbDKV+BcMWfYSgf7YPD6L+5e/OeUMKuP9uC4yp08DjBgIZb9VFF6XGDDBRt6v3cCFO3D
 Y2j2cPCVEm7nMeMivxC6oUjIvkuO5eEnfjE7oyGsAv2PXoRZ/LROJy8w==
X-Received: by 2002:a05:7300:5b95:b0:30b:f477:6619 with SMTP id
 5a478bee46e88-30c0cfefd60mr10912243eec.15.1782142203620; 
 Mon, 22 Jun 2026 08:30:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1f14fsm10086731eec.5.2026.06.22.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:30:03 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:30:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 00/21] Wangxun Fixes
Message-ID: <20260622083000.16a572ee@phoenix.local>
In-Reply-To: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260622111111.21024-1-zaiyuwang@trustnetic.com>
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

On Mon, 22 Jun 2026 19:10:48 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
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
>  drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
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
>  drivers/net/txgbe/txgbe_rxtx.c            |  109 +-
>  drivers/net/txgbe/txgbe_rxtx.h            |   36 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
>  26 files changed, 9464 insertions(+), 444 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> 

Applied to next-net, but this driver still has some unprefixed symbols:

 $ nm ./drivers/librte_net_txgbe.a  | grep ' [TD] ' | grep -v ' txgbe'
0000000000000510 T set_fields_e56
0000000000007ca0 T handle_e56_bkp_an73_flow
