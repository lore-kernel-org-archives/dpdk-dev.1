Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17EACCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 16:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17E18402BC;
	Wed, 22 Oct 2025 18:34:45 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id D16B540262
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:34:43 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b62e7221351so5965808a12.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 09:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761150883;
 x=1761755683; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xHBdwtNbeZ/Q+phW0xB+c5Yjyb7FQrb1QsJEhx1fwg=;
 b=nZ4MZAQateXQXOHQx50UvHKowpDRIcReBGf96IgwaMsPID++X+ltE7R+Rm3GmUacUe
 TWrVsEEwT8UphvRGyDkTJNZ0/p3zHoMpNQxpFVxqqJcjxR7RbWXZnC76hE1ULcl+KHjS
 bTomeih+sldZ+g+ciMFcLQ+WrmrsfGa49zuTeWnDgF+yNQkqWm2vdB9zwFX7C7JKTYQG
 XNhn/8RRmKy9U0sUBZ3yWAh0GZYNQKjTpJjs9jQLufamIhxiStM9V/9fPpJmSiC3yV6r
 AifFxZNWdNlup6W7rBXKx1xTr/7Otsuv07+JI2B0s3clE3Lr8z5oB2pg6XWhN6NZOJgZ
 Qdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150883; x=1761755683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xHBdwtNbeZ/Q+phW0xB+c5Yjyb7FQrb1QsJEhx1fwg=;
 b=sqURLOkN+xEHtjDWu5E57uwjVYICGtt4KUTrUikFUqJClQ8ToJtUVl+jshXWKCOKwn
 CtdyNyw3HJHBGHbPOGKw/X3Gx4H6w3i7M4X834QaOMSD8/m8ZKxp+KHPkE7lSZw7t+PV
 nvrPPY0SsZliFe7xLRRVmT5K849bnNkNj5BHS60NtD/Tp8qoo1z+u01FILnuy4ouMU54
 H7foDaMpXiD9f70VWIzEO58azXR9/gGoW8iAz17Zhpz+H9LWE7DHbgsDvsglsAd5Qj1J
 tUVyliOpUoJRzDYvLzxAohiwfNPQ+/o6Lsk+y3n4XQ2gvpCNj+gUtIIN+aF6tDr8sn+W
 1tZA==
X-Gm-Message-State: AOJu0Yymy8yD3+40kpvpzdo7IMWcf39mVlk6TH8kkUeC1EwyEsoVwz8j
 af+gQkAWZL6TWlVAIUT27e54bwPbGBefmhIm5iXgXP9PS6/+PQzQfHtlkG+2CcEIEHI=
X-Gm-Gg: ASbGncsTMZPt7KuB2yV/3qJl3GrAm/80G039Lg2PZmTm2JnNPIDyUzMEHgPkFEOeIev
 CJjF5JDI1QYBPykbKcf1UYLlnl16i0i1SAEKSvlJC+8CaqsgMmPxcdwGsieg/yuJP+KlbpkWdZb
 RbnbVBN2XuzQ4j6vHgg9X7EA+p/PgzKGFstocIEEoM0NM42MXcwhXUpgmYV+1a2ep9rnadhWxcz
 nyVSs0RgmnFgAk5KtcVUPrhsvwu0JLII1eriQoMcp41BxXHBphbRasm/73oYTJTPdnpnIXQTPBm
 sH/wrW8jZWLk5+awwY8v5L2eQO6q8pPUiyV8nqtGQ6a6D+bh5HdPXxYsYO5wqy22+Rr0W4snHVU
 A4um7VTOQ2MYSP0JEN+FLM6p3FLMkG6XMbW3WX4dm2hgTqj7a1ohPkejAPT5nBNHDuzGrw/cIh6
 8Q34hYRTc6V6/jI2044FF5Zi/lJQYOjb/ySu2mG5k0ZB8ywxGUGw==
X-Google-Smtp-Source: AGHT+IFf1GnZ5cWmoxyzwtBfUL0sR03n4gzeXEagljmCtaGOFe9snA2Ro89veKRKjaIb1MbWyXe6+g==
X-Received: by 2002:a17:902:c943:b0:26d:d860:3dae with SMTP id
 d9443c01a7336-290c9c93ac6mr260873925ad.3.1761150882763; 
 Wed, 22 Oct 2025 09:34:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33dfb55fda8sm2412386a91.1.2025.10.22.09.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:34:42 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:34:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org
Subject: Re: [v2 00/12] ENETC4 PMD support
Message-ID: <20251022093440.431c4746@phoenix.lan>
In-Reply-To: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251017091929.2723044-1-vanshika.shukla@nxp.com>
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

On Fri, 17 Oct 2025 14:49:17 +0530
vanshika.shukla@nxp.com wrote:

> From: Vanshika Shukla <vanshika.shukla@nxp.com>
> 
> V2 changes:
> - Deferred queue start/stop functionality for ENETC4 driver.
> - Add rxq_info_get and txq_info_get to report queue information
> - Addressed code review comments
> 
> Apeksha Gupta (6):
>   net/enetc: Add initial ENETC4 PMD driver support
>   net/enetc: Add RX and TX queue APIs for ENETC4 PMD
>   net/enetc: Optimize ENETC4 data path
>   net/enetc: Add TX checksum offload and RX checksum validation
>   net/enetc: Add basic statistics
>   net/enetc: Add packet type parsing support
> 
> Vanshika Shukla (6):
>   net/enetc: Add VF to PF messaging support and primary MAC setup
>   net/enetc: Add multicast and promiscuous mode support
>   net/enetc: Add link speed and status support
>   net/enetc: Add link status notification support
>   net/enetc: Add MAC and VLAN filter support
>   net/enetc: Add support for deferred queue and queue info callbacks
> 
>  MAINTAINERS                            |    3 +
>  config/arm/arm64_imx_linux_gcc         |   17 +
>  config/arm/meson.build                 |   14 +
>  doc/guides/nics/enetc4.rst             |   90 ++
>  doc/guides/nics/features/enetc4.ini    |   22 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/rel_notes/release_25_11.rst |    3 +
>  drivers/net/enetc/base/enetc4_hw.h     |  188 ++++
>  drivers/net/enetc/base/enetc_hw.h      |   49 +-
>  drivers/net/enetc/enetc.h              |  245 ++++-
>  drivers/net/enetc/enetc4_ethdev.c      | 1058 ++++++++++++++++++
>  drivers/net/enetc/enetc4_vf.c          | 1364 ++++++++++++++++++++++++
>  drivers/net/enetc/enetc_cbdr.c         |  311 ++++++
>  drivers/net/enetc/enetc_ethdev.c       |    9 +-
>  drivers/net/enetc/enetc_rxtx.c         |  165 ++-
>  drivers/net/enetc/meson.build          |    5 +-
>  drivers/net/enetc/ntmp.h               |  110 ++
>  17 files changed, 3613 insertions(+), 41 deletions(-)
>  create mode 100644 config/arm/arm64_imx_linux_gcc
>  create mode 100644 doc/guides/nics/enetc4.rst
>  create mode 100644 doc/guides/nics/features/enetc4.ini
>  create mode 100644 drivers/net/enetc/base/enetc4_hw.h
>  create mode 100644 drivers/net/enetc/enetc4_ethdev.c
>  create mode 100644 drivers/net/enetc/enetc4_vf.c
>  create mode 100644 drivers/net/enetc/enetc_cbdr.c
>  create mode 100644 drivers/net/enetc/ntmp.h
> 


Added to next-net.
Reworded some of the commit messages to conform to guidelines checked by devtools/check-git-log.sh
