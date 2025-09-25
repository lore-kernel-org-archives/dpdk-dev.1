Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37858CAC5B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 16:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B04E40663;
	Thu, 25 Sep 2025 18:52:43 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 4DD664065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 18:52:42 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-62f0702ef0dso4849664a12.1
 for <dev@dpdk.org>; Thu, 25 Sep 2025 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758819162;
 x=1759423962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KiRVKzVXRS0V4ZXHUiZ98AgOhwifrC2l9CaIZwmAQRo=;
 b=uRLkxfr+s89H9P4zGe/kn7QgMJ741K7ngLZr37KG8hYnxoZc73HiqUUpgS5jj1VXu4
 aAzhAGtVS5uw+y/hXUKe887lfigvJxKFfU6Gv0FekfBEXFjaZpZBJV0rh0061GXTI9zk
 shjkTiCZQuBfRE9q4ORdMEQQzYcJlGayb0s4fV1LLkjzHvBZ7bP8OFYeyehuwxqOzaQU
 AfcSyf5sBQKfy8O6a9akrMdywFqseAvae+57s73edVLBwZzhXltKLfy3BMzfHMEcfbYc
 qTlKKKoQJ+DjbtezwjCczh8zqx96cK2OoUd98pDRVQ2xnPKX9ElVagnhfhk+Xl2Esm1a
 vekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758819162; x=1759423962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiRVKzVXRS0V4ZXHUiZ98AgOhwifrC2l9CaIZwmAQRo=;
 b=seB4rZv5JQPJTFVHCkxPPbJSN3ixRpIEYhMeex7/oIEDTty/1YCra4YdPrcgyjNViJ
 3m9HgRVpNYA6++Z0QZrB+tp+DdYFeiuA1/Dle10z+4EvwfHbPN6spFuBUF+PzXWT5b+6
 BdcmVoiBhopWq4wCMnK6PlqY8aJ4xf8mjko94CSSrENHzg1Uh+XAo1RPLCF5cLrgzent
 zVTiHpfsC73/M7PU75R8nVba+pOIoGlsLGfJ9ovryrVRFOB6RCnRjL3za37OITQ8zmWt
 pdNp89ZyXej0AOkqBUiYsNv9+5lxM76PFtds6tvMPru++1Pd365jxH2QL8HHyijVOI+a
 5NFA==
X-Gm-Message-State: AOJu0YzwMVvXaITkab8TgVGcPf0LA9jQM+TQjBwza5GTmCnDD+OEbfnS
 uaY2PoExNnqtmkB6oR1zaAVddpmMfqVt9+2ripV9CAPcEafn9+UAH2HI+XPfUIJO+fev/ak5TAv
 I3i50
X-Gm-Gg: ASbGncuvDWl1jyIds+nSw+5sGMU58ZD4gSzNl98WK0TH8Oes1dUgOgszykCCvK+Lq+y
 x8jsNV56QBKETy8/E8KuIGRbtFhVt6YSilOyRpdWJmO/DTvx0k/tHTKToB1RoK89I8aaxwX5Ycr
 SDjhgJEfg9+iONpQ3M4+EOoRtY+g8s5CHCXX5oA9cTLMUZ79OiLlJG7yMy67L2KqyrzIqE1Wcdb
 74wvvT7PSBeliqXb/S+3nmN+H6Gzc89xsJEYabkdKMD3c9d5oxF6/Xysf45AT2UNF3tmMj16+YO
 4OowB+fwpdP9rdyAYHwk0xNZhnQSaRLQTdf4ga5esy8aXzm/ZwihD9bN5mNyPlKeOhvc9t8YT9E
 TYXmjW2iILyE1f4QvAKbyiYMvDRnj8cEHH9SY2GpawMAStrl8BlbEzr3fUn099SJ68zmqXYcE+f
 w=
X-Google-Smtp-Source: AGHT+IH81WIX6XE5rhPvvTECW1ycdEqOObUxFhfVNh6Bjjd77kOa+ona3ieFjEt3dVtZNRpJai0MlA==
X-Received: by 2002:a17:907:3e93:b0:b10:ecc6:5d8d with SMTP id
 a640c23a62f3a-b354de2c4a9mr365516266b.26.1758819161619; 
 Thu, 25 Sep 2025 09:52:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3545c851f3sm194424766b.109.2025.09.25.09.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 09:52:41 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:52:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20250925095236.1ac9ad9b@hermes.local>
In-Reply-To: <20250925065854.2907820-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250925065854.2907820-1-dimon.zhao@nebula-matrix.com>
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

On Wed, 24 Sep 2025 23:58:37 -0700
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

There are still some globally visible symbols that are not prefixed
with "nbl_".  This risks potential conflict with some other code
when statically linked, so the policy is that drivers need to be
consistent in symbol naming.

~/DPDK/review/nbl $ nm build/drivers/librte_net_nbl.a | grep ' [TBD] ' | grep -v ' nbl_'
0000000000000040 D chan_ops
0000000000000000 D userdev_ops
0000000000000000 D hw_ops

Please change the names, and retest then resubmit.
Really close to getting merged.
