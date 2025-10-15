Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF0CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:11:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8250410FD;
	Thu, 16 Oct 2025 00:10:48 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 97CDE40EE6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:47 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-88ed6837e2eso13950585a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566247;
 x=1761171047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA2DP9dapqWLWZHyQ7XRw9Zfx9LdIfcQqnBBeYP/L/o=;
 b=TGqEoDGtrME5p8TceV468bfJOQJ9PeLPBNCB/O5uFh+Bufgck9rs+egxGiqgBdHdBO
 MLfgcGj+dTShTz5Ug1POWNvUEgn3z5fUf+yCHb7OrEw0r+/LCgtzEf28RD1X1mHV1Lq1
 FLUBRiL6+ojbq8kABW8rtw384qCK8XPBbKqSKf/kYINfcm5Jh6ym0q251xs+JTn5Eq1B
 lWqsgobi9aX8HZnVqTgzMVlK+PI1HsN/Yy1phJItI4eeeQIPB+j2JsX0fEdEbAPfni6b
 yeI8J4XqsSOcYxB17LgSfU6CAFU1Po/vTjbs3pl70kLdnNz4fdt5Qqk6UMKx5+4spSnf
 Zu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566247; x=1761171047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA2DP9dapqWLWZHyQ7XRw9Zfx9LdIfcQqnBBeYP/L/o=;
 b=rynwZkb0tlvGixrss2Rz11Cd0DX0C0pppvad/1LKcSvBuB8jGgoiUsBa35BQ24t5fP
 BaPyWXj2PAWCWqe0cWxsGFYJwbSHMf2nu8JsPMJmUUptbEFmYvIR/lw2C7s98HbJBYh4
 35NnUDL2n3EqCvoRXCV/lb2+mtPBaN6L5kR17KFxJg5rLWwhLfOLjlOMI4sysXrkKhUw
 QMdoyqiW6qlg0DRFQE65AqRNzHKa9+vct8hS/YzRqrHDApfgOh3J+RQLltm0OUXyDvgC
 5YPMISfiIEoDsBi8/rr6RAdfUYReMRPPLYpZhbYVTJW91ri47dJ111wfbVF3bE0v54J0
 mBoA==
X-Gm-Message-State: AOJu0YxjVxQahcnOb6UxXtgAGde22laorX6tQ427caQXhjLzaNuD4HQh
 yaqdM9hAX1AIyCdRuDSxLpBtqx5E5MGH4LM0eYVVb7n+HQE4TfsxpxAStCqoB6pqP5o=
X-Gm-Gg: ASbGncu0afeKz9P3CSk3lRAOc3voxAgL0tngz3ad3nasXRHDIOGDkSqZVN+P5JPXCPy
 WmohtFh6/thxlFuIiM6G1pwfe/giKilwiHNlbPFeH17/k7aA/WaRgmbwHRcykTCaiO074UD3s86
 r5hPXbQFWYb1ljW20bbXSZC1gm+ZiqX0hd2kX7mvSBG4XyFN/YKuA+8lK+ZJ3qDYhl2Rnc8XRP4
 4oC5C54G+QMDZQUOQg72nRHfEqViqV+y4aSbs/yBKOVoUINyAZi/034QYVUhd1CIH6t1LXrp8Wy
 sOlW35+QpVPivJ29Z0eOMqQXFJlRq3LGe19iXGFwPAnp8aptSrJx6pZ4pgtNQpJFIngwlx06nVf
 QNtJWIZa5ItLbgIFE+/qxdwj9DgDNAL+WTx2XOVFUQ+Xih9qL0PiNXnQ9oKtQLVb6evQyD/iZ3w
 Ms215UwYRd/a1nVFD06ys4qijWhWFYyGgf/IQfi51YrUUC96DZk2B4R3xy1fMGfjo=
X-Google-Smtp-Source: AGHT+IEE8KcBbhyuiKezyi68mUfd6o4c7/B3TCnd4PqDsqUmBhxmwYMBodpE8SI+nmFe53UYzOKeXA==
X-Received: by 2002:a05:622a:a008:b0:4e6:ebcc:23fd with SMTP id
 d75a77b69052e-4e6ebcc38aemr302725751cf.23.1760566246776; 
 Wed, 15 Oct 2025 15:10:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:46 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:10:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org
Subject: Re: [v1 00/12] ENETC4 PMD support
Message-ID: <20251015151020.643dcef6@hermes.local>
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:21 +0530
vanshika.shukla@nxp.com wrote:

> From: Vanshika Shukla <vanshika.shukla@nxp.com>
> 
> This series introduces a new ENETC4 PMD driver for NXP's new generation
> SoC, enabling basic network operations.
> 
> Apeksha Gupta (6):
>   net/enetc: Add initial ENETC4 PMD driver support
>   net/enetc: Add RX and TX queue APIs for ENETC4 PMD
>   net/enetc: Optimize ENETC4 data path
>   net/enetc: Add TX checksum offload and RX checksum validation
>   net/enetc: Add basic statistics
>   net/enetc: Add packet type parsing support
> 
> Gagandeep Singh (1):
>   net/enetc: Add support for multiple queues with RSS
> 
> Vanshika Shukla (5):
>   net/enetc: Add VF to PF messaging support and primary MAC setup
>   net/enetc: Add multicast and promiscuous mode support
>   net/enetc: Add link speed and status support
>   net/enetc: Add link status notification support
>   net/enetc: Add MAC and VLAN filter support
> 
>  MAINTAINERS                            |    3 +
>  config/arm/arm64_imx_linux_gcc         |   17 +
>  config/arm/meson.build                 |   14 +
>  doc/guides/nics/enetc4.rst             |   92 ++
>  doc/guides/nics/features/enetc4.ini    |   22 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/rel_notes/release_24_11.rst |    4 +
>  drivers/net/enetc/base/enetc4_hw.h     |  186 ++++
>  drivers/net/enetc/base/enetc_hw.h      |   52 +-
>  drivers/net/enetc/enetc.h              |  245 ++++-
>  drivers/net/enetc/enetc4_ethdev.c      | 1002 +++++++++++++++++
>  drivers/net/enetc/enetc4_vf.c          | 1364 ++++++++++++++++++++++++
>  drivers/net/enetc/enetc_cbdr.c         |  311 ++++++
>  drivers/net/enetc/enetc_ethdev.c       |    5 +-
>  drivers/net/enetc/enetc_rxtx.c         |  165 ++-
>  drivers/net/enetc/meson.build          |    5 +-
>  drivers/net/enetc/ntmp.h               |  110 ++
>  17 files changed, 3557 insertions(+), 41 deletions(-)
>  create mode 100644 config/arm/arm64_imx_linux_gcc
>  create mode 100644 doc/guides/nics/enetc4.rst
>  create mode 100644 doc/guides/nics/features/enetc4.ini
>  create mode 100644 drivers/net/enetc/base/enetc4_hw.h
>  create mode 100644 drivers/net/enetc/enetc4_ethdev.c
>  create mode 100644 drivers/net/enetc/enetc4_vf.c
>  create mode 100644 drivers/net/enetc/enetc_cbdr.c
>  create mode 100644 drivers/net/enetc/ntmp.h
> 

Drivers often get statically linked so it is important not to have
visible symbols that can conflict.
$ nm ./drivers/librte_net_enetc.a | grep ' [TDB] ' | grep -v ' enetc'
0000000000000b80 T print_ethaddr
0000000000000520 T netc_free_cbdr
0000000000000000 T ntmp_rsst_query_or_update_entry


