Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B9C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 14:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6260C40685;
	Wed,  2 Jul 2025 16:57:00 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id BED4C40285
 for <dev@dpdk.org>; Wed,  2 Jul 2025 16:56:58 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a58c2430edso73051721cf.1
 for <dev@dpdk.org>; Wed, 02 Jul 2025 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751468218;
 x=1752073018; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tpPHT23ns7em+y1WDchrB6nwNq+HbHOjeoZHs98IWU=;
 b=NQgC/4dm1zzI67UdiDchUL5SDUo9CpmepO6DnR+Lt6sYlwSxCT7jgAhWdO8Q8INsch
 o+QX6IjsdZb306uOwaTenK9ZrdU0YhZjpxthpTBNKNkAJuXjCAqegi0a1/Q1iKAmmty0
 VV7JWBJbmAfo/onxcja8GaA93lieIK3hxzjDwOZsDNMkCQfRxCKRneMKwKS4gBaWPkTI
 4WnRR3rorWgDmPBIcZbd3GAHT7kFtXKhdsoR++3iemfZh4qRvtr8vfZbEi3X0frV6SVP
 vNqx7DDEnuKLOJfxySTiOfl7yOC0aWYNY+eFhvwlOohC3RRWVU6fZcJuS5pFW7G6RB9A
 uT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468218; x=1752073018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tpPHT23ns7em+y1WDchrB6nwNq+HbHOjeoZHs98IWU=;
 b=MAkuU4dDy3nNQylPGLFPXz/9VcsUl6fCw0XF4K3tf6tFmxZb6bEjvzopZxvcqqZACn
 TddXctwFCUjDfZ7YI8SiIaDcfBnqqENOyee6y4cAVycpH6eTkesho84uEMqMp5Izsg0e
 UUfyFR4q7xl5mYWVze2s5c7WYXMfnzCsH63jN2dXs9FVFlAxqp6cKbeBs8sHTSpXHpi1
 vGJ4YVgEbTICmEbZvbzZfQonpiHN93L8PcBoyKm2I6bpxrmGmKe2eVEwFoffFxNmRm3G
 nGCpdCLIWkXldC8UmxWzN/G+oyxVEg4RIaUTKeQ1pU6Fy65uVYhmKJYeNYONAEmGcOqF
 WczA==
X-Gm-Message-State: AOJu0YyXTbhV6WzoC/ckrku4AxnOXgfcU7Mn+EC7oAH8abOKqoyVnHax
 P9XqiWJYU3DbA2Ue3S2eILsAenQgCfxEazJfk00cnmILjiCzVOIVeM/QWht4YFSTf3Jf3M01eGH
 HYL9v
X-Gm-Gg: ASbGncvnqk6Ea7rLsPUXdOuZOwy0C1W/KFFj5UPhmjkxAsFQjRHIDuN6QpeGjj3o1Zi
 cwFfwlZno0KRRgGBOk/WcmlQZUZXdWZ83YPDi3ZmDokOMvf6i27HBWpE3fOkjrKFQHn2Y3yD1jG
 TY+SeY7sqfirA9SLaK0ssXV2CX2mQjY/swLVTXwEi89OjdX3pxB+EYal7YVHrwnpyp1Da4ekygF
 5vEq2aRTISvMe+8Z2j0XLcMzBps6e32DtLyxZtyGgatIav2sa2bKT+ELicPSSWj2CQNuN+MNOwg
 NR4Eqqj/Tqd1YxjXEKSdFX1fZvZddqc/pTwnNpJsyuPHEc4I1pGSoetIvkPT/2pmWlRx7vWePn7
 DMyqcH2AUp9FnAy+6dOiX0opjAzycrVQwMC838ys=
X-Google-Smtp-Source: AGHT+IFlerx4tVz1E8j4RWAspBmE3m6dZETlBbvjXviuwO3fbWETxW9XciLUvuXK4XYrYGQ2HRDV6A==
X-Received: by 2002:a05:622a:1b06:b0:4a7:fbe9:4d69 with SMTP id
 d75a77b69052e-4a978111c95mr47038491cf.14.1751468217785; 
 Wed, 02 Jul 2025 07:56:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc57ab7csm92886861cf.56.2025.07.02.07.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 07:56:57 -0700 (PDT)
Date: Wed, 2 Jul 2025 07:56:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org
Subject: Re: [v6 0/8] DPAA specific fixes
Message-ID: <20250702075654.789b1a9f@hermes.local>
In-Reply-To: <20250702101026.3301762-1-vanshika.shukla@nxp.com>
References: <20250701113707.2793004-1-vanshika.shukla@nxp.com>
 <20250702101026.3301762-1-vanshika.shukla@nxp.com>
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

On Wed,  2 Jul 2025 15:40:18 +0530
vanshika.shukla@nxp.com wrote:

> From: Vanshika Shukla <vanshika.shukla@nxp.com>
> 
> This series includes fixes for NXP DPAA drivers.
> 
> V6:
> Removed the "add Tx rate limiting DPAA PMD API" patch.
> Handled comments by the reviewer.
> 
> V5:
> Fixed comments by the reviewer.
> 
> V4:
> Fixed compilation errors in the "bus/dpaa: optimize qman enqueue check" patch
> on Ubuntu 22.04.
> - Ensured buffer bounds are respected and added validation for buffer count
> extracted from mcr->verb.
> 
> V3:
> Fixed compilation errors for "bus/dpaa: optimize qman enqueue check" patch.
> 
> V2:
> Handled review comments and checkpatch warnings
> 
> Gagandeep Singh (1):
>   bus/dpaa: improve DPAA cleanup
> 
> Hemant Agrawal (1):
>   bus/dpaa: optimize qman enqueue check
> 
> Jun Yang (5):
>   bus/dpaa: add FMan node
>   bus/dpaa: enhance DPAA SoC version
>   bus/dpaa: optimize bman acquire/release
>   mempool/dpaa: fast acquire and release
>   mempool/dpaa: adjust pool element for LS1043A errata
> 
> Vanshika Shukla (1):
>   net/dpaa: add devargs for enabling err packets on main queue
> 
>  doc/guides/nics/dpaa.rst                  |   4 +
>  drivers/bus/dpaa/base/fman/fman.c         | 279 ++++++++++++---------
>  drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
>  drivers/bus/dpaa/base/qbman/bman.c        | 147 +++++++++--
>  drivers/bus/dpaa/base/qbman/qman.c        |  50 ++--
>  drivers/bus/dpaa/base/qbman/qman_driver.c |   2 -
>  drivers/bus/dpaa/bus_dpaa_driver.h        |   9 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 123 +++++++--
>  drivers/bus/dpaa/include/fman.h           |  40 +--
>  drivers/bus/dpaa/include/fsl_bman.h       |  20 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |   2 +-
>  drivers/bus/dpaa/include/netcfg.h         |  14 --
>  drivers/mempool/dpaa/dpaa_mempool.c       | 229 +++++++++++++----
>  drivers/mempool/dpaa/dpaa_mempool.h       |  13 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 291 +++++++++++++++-------
>  drivers/net/dpaa/dpaa_ptp.c               |  12 +-
>  drivers/net/dpaa/dpaa_rxtx.c              |   4 +-
>  17 files changed, 856 insertions(+), 391 deletions(-)
> 

The change destructor is not building correctly on all platforms.
Likely missing some include.
