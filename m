Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDAFCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 18:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FDD940698;
	Fri, 26 Sep 2025 20:18:47 +0200 (CEST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49]) by mails.dpdk.org (Postfix) with ESMTP id 34E0140277
 for <dev@dpdk.org>; Fri, 26 Sep 2025 20:18:45 +0200 (CEST)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-62f4a8dfadcso4368540a12.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758910725;
 x=1759515525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6NAaAseFSOnZ5IVj4b2zixmdjpPdIK8MnO5uml8N+c=;
 b=eh1fKC7HBaRckHvfAodPJ1xEyjD4W0Xzi7TzNxwV1eq+LjUTt8GBkM7uhBWPOt6em3
 uupX22j3dD5DWsjU6pS6LjIXuAOdUC0rw5MDJ+j2tORRShJRUyAnWURs8x+mCsBDxGQ9
 0fLnQZHAr1Fw7KVUz7hQulTJp/ktPm7L3NBFY1qK/wYyYHqrgIL+WDG51mRj6zl5nntH
 7SjHGOSYpVvBQgnD/MwEGqcm6XS8BN2dODx+uzMLgd73KrHhhZ+MlMSFSTU2kvXiYbq+
 P9QaU0Kvmm3VVENc+RzrGzBwqO7udgW/tRlssfg9qbXDml2m9jBbnjNH/OTTKd31Urcg
 ZOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758910725; x=1759515525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6NAaAseFSOnZ5IVj4b2zixmdjpPdIK8MnO5uml8N+c=;
 b=WQUYdMWzL7pgDvCZlMBOnnWwl70UmNcrf14jNwhVmEjJ2rTz4reDi0hYuMQibkJy3F
 47BiCHh0vWA+6ZNHrkODcR00lUTfVc+2glF0nCUCUJnVwQg7tDTt+fSCFvtagpKRWDTZ
 1hrw3UU5/6Z3NFxnTk1l6HNduALKu10wG7r6bnGRUnsKlo/jp05dqq5PbzsUH8xNTJOv
 vw6fS7tfTQOFGqCoiykMv1BfbeCdnRS5LBBCOl1rPl/5GrziQ42J+KHJOGu9QRaaFM++
 xpiWBeGLIVdsIhSXyVuJkz31eIFyV86XwlkGIozSMaG39KjFL7BMA0Qe4XM6Gc8aiseL
 vCOA==
X-Gm-Message-State: AOJu0YzY1ehB3JkK+vou/Ion8mmlLFFh9WTfSDgfOxvI1kz2mtMUBPrf
 Ja684gg5vZVsPj0oi5FEGHriV7aBHOp2eiE1/trL32ET+RBlXh8TT4Z7uFDZxcvc6jdeurZz8ov
 FIrDTkKY=
X-Gm-Gg: ASbGncuOty5m+Xy5YW4BjVmrF1/Yk9QgLSPxfoDbBp9NvVN+ZgIDBudPx0aeVWEey/Z
 oFxtkpdHNudoFy70G0+4dVQxfYS+MY2bFaEUDLYmeKXrLx14dx0aplU6Ds8bpjPM2Yk29M3QD7q
 DArYarI+RTcA1qOg9f3Nutrxv+WhDpqT1Cp9Z57APE7n0IjGBVn1OGY4VQEViGLcRdBgm9F842M
 FluSy9VrYXeHhhaocD1XIw+R1XeAC3kDnn0i7M1UDpj7wXmq+6gCzEJ1pXr5xA9iSbMtsww1thV
 Dc01KI9dJMYhCGTGTb9FxDLIPApQRHWWL8BWQs9MNH1KX9z+ZR76A+Qj4yH2goXuVKsvM63aX80
 0dtTBdR3dDVXfHg+x8cG5YN3Q2srq9/Qy4j9+HMdeukkcupxbZom+S6Nzy5iuTCEnVxlAVJVGFJ
 eFUVIkI2rR+g==
X-Google-Smtp-Source: AGHT+IHvEA+JXrDKO9MUX0TT9XbSDAnTYpWQq/MnRS7lMWyQ7RXZOaMndvzhACAtph+OYKPhsvCqFQ==
X-Received: by 2002:a05:6402:1616:b0:62f:608e:bbe5 with SMTP id
 4fb4d7f45d1cf-6349f9ed713mr5478496a12.11.1758910724617; 
 Fri, 26 Sep 2025 11:18:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634a362993esm3222984a12.4.2025.09.26.11.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:18:44 -0700 (PDT)
Date: Fri, 26 Sep 2025 11:18:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20250926111839.788ae5d4@hermes.local>
In-Reply-To: <20250926072602.3030541-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250926072602.3030541-1-dimon.zhao@nebula-matrix.com>
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

On Fri, 26 Sep 2025 00:25:45 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats 
> 
> Support NICs:
> -------------
> - S1205CQ-A00CHT
> - S1105AS-A00CHT
> - S1055AS-A00CHT
> - S1052AS-A00CHT
> - S1051AS-A00CHT
> - S1045XS-A00CHT
> - S1205CQ-A00CSP
> - S1055AS-A00CSP
> - S1052AS-A00CSP
> 
> Dimon Zhao (17):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl: add HW layer definitions and implementation
>   net/nbl: add Channel layer definitions and implementation
>   net/nbl: add Resource layer definitions and implementation
>   net/nbl: add Dispatch layer definitions and implementation
>   net/nbl: add Dev layer definitions and implementation
>   net/nbl: add complete device init and uninit functionality
>   net/nbl: add UIO and VFIO mode for nbl
>   net/nbl: add nbl coexistence mode for nbl
>   net/nbl: add nbl ethdev configuration
>   net/nbl: add nbl device rxtx queue setup and release ops
>   net/nbl: add nbl device start and stop ops
>   net/nbl: add nbl device Tx and Rx burst
>   net/nbl: add nbl ethdev infos get
>   net/nbl: add nbl device xstats and stats
>   net/nbl: add nbl device set MTU and promisc
> 
>  .mailmap                                      |    4 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |   31 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   87 ++
>  doc/guides/rel_notes/release_25_11.rst        |    4 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  761 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  105 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1074 ++++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   89 ++
>  drivers/net/nbl/nbl_dispatch.c                | 1318 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  138 ++
>  drivers/net/nbl/nbl_ethdev.h                  |   31 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  977 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  132 ++
>  drivers/net/nbl/nbl_hw/nbl_hw.h               |   28 +
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c |  228 +++
>  .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  249 ++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  908 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |   40 +
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  459 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  120 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |   26 +
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |  100 ++
>  drivers/net/nbl/nbl_include/nbl_def_hw.h      |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   92 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  201 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   31 +
>  41 files changed, 7949 insertions(+)
>  create mode 100644 doc/guides/nics/features/nbl.ini
>  create mode 100644 doc/guides/nics/nbl.rst
>  create mode 100644 drivers/net/nbl/meson.build
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_userdev.h
>  create mode 100644 drivers/net/nbl/nbl_core.c
>  create mode 100644 drivers/net/nbl/nbl_core.h
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.c
>  create mode 100644 drivers/net/nbl/nbl_dev/nbl_dev.h
>  create mode 100644 drivers/net/nbl/nbl_dispatch.c
>  create mode 100644 drivers/net/nbl/nbl_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_ethdev.c
>  create mode 100644 drivers/net/nbl/nbl_ethdev.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
> 		    nbl_hw_leonis_snic.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/
> 		    nbl_hw_leonis_snic.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_hw.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h
> 

Queued to next-net
