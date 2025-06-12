Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FABBC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 17:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 634CF410FB;
	Thu, 12 Jun 2025 19:46:50 +0200 (CEST)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52]) by mails.dpdk.org (Postfix) with ESMTP id E36E6400D6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 19:46:48 +0200 (CEST)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-2ea6dd628a7so604204fac.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749750408;
 x=1750355208; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cih0/TpV4wUZDtt6xl7zezAUGJyk70I4jkvWO+tsaL4=;
 b=mID2XidCQvr9wpxqtKTQS7iwZk3E7O3DRk9GhRg6rMRXHeSz58JirpVKHQgo/rAKMk
 UrsizRZktms2dtnbUkEiqC4aYqtwC3qRWGHqI1CpsoYRC2CfnassYxPm6JNzWdwVIW18
 5fwblYdPfFVp812tyyOoAyGpFz1sjqzrzGIgKB3XfrQEiqdYAu6YcsvOv3hdSYBYlwMX
 mxh9koUXGR12dcAnpPir33UiFmke3bXPqshyTCjv/80qo8iLYnwzll9Ilfbi1jhbk66P
 1ky8T++0qeW1IruqcOgYui/3nrCX/utf9roxKyXYOtEhnfpYkKQWew/pE4DcYKUnjhtt
 J1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749750408; x=1750355208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cih0/TpV4wUZDtt6xl7zezAUGJyk70I4jkvWO+tsaL4=;
 b=c9PTf8gzkfJXmpQVhjTB6o5aSzy9TEVe4gWAjiKZRIdEfJSlEJNS0cz6JnLWxraKSv
 j6e0KzW5y4eNitxYUwYA6fSpWazifG13AdZ4H9xPg+znBuUBkRkiRIWBz5lu2UKoOCm9
 ZhLJDEdm7RSRb3qWZCft3VaeoAbONdHWX5PggNNSBOvAOYsxnaUOEu0KwySJIVjbbOy2
 Uv7mXWTWPDjN+zf1su4SJiJ8nsFL858rz0vuq/L+jicLvy/vhJUBeroUUtWdPwVYFmbR
 qYDBlnjHn0ROrHWcHxBgH75z0hbPogNfK/d6HukNGzsMInZnn574cKebbHKZVVjhBmV+
 E5Yw==
X-Gm-Message-State: AOJu0Yxt/s0gQvAB5XVkABEEDGjgStSswQJHOY2s4eqHy7ApAPfch6qr
 FMoW9kIwb/10N4B88GsycHQ4KGR/6rDllan7Bx4onbreeU/wB13NxknLa7JmJEe19xfnyQMZZLb
 9Kisq
X-Gm-Gg: ASbGnct+zLgxDifSW3K/wxgkJSKBiA5yQV8YkMejkN41zL9rTbC+r8oXHQcc3X/B9Dv
 NWk458hZA523n9XLNAg6BrXseZzoBq/G9X+dxROZbQ5IRrAGyHVfJqkVvxr1ZYdnQjhOjJgtYFp
 yZNKc4yynT8mo+i0Viddxdbxo5hcUX1gDJLxVGHzDNa7VjAl1eHt4cOd7z+Vogx8BiIozX9KPTt
 uEW+UHz7vpIyfFGs1x1+lFs8zzkNvkvqjGSxSt+E6wlIkPyccat6bze9lRhExux7kqLRHWjm/6T
 s2rA4eYLHjmRHmjni1T4TDpDo1987u+73sJMjqHbvkS5LA3ZpiU/I/CRPX0pKNfxYPjlSWpYxpf
 mSfm3KANuNxPrTBicap9i0V6F8NmfhcdhLIblTmz+Xvr6VhXrgg==
X-Google-Smtp-Source: AGHT+IGfCq1tk/atLcHlgkvrs5dM7HXt5BcLLnqce8JhIEt48dM0Ymg+/Uri24xWGz9obEyXAF/NpA==
X-Received: by 2002:a05:622a:1f06:b0:48d:8053:d8ee with SMTP id
 d75a77b69052e-4a72ff12925mr1118281cf.36.1749750391925; 
 Thu, 12 Jun 2025 10:46:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a50145esm6528681cf.70.2025.06.12.10.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:46:31 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:46:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20250612104629.3b281a34@hermes.local>
In-Reply-To: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 12 Jun 2025 08:58:21 +0000
Kyo Liu <kyo.liu@nebula-matrix.com> wrote:

> This nbl PMD (**librte_net_nbl**) provides poll mode driver for=20
> NebulaMatrix serials NICs.
>=20
> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats=20
>=20
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
>=20
>=20
> Kyo Liu (17):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl:=C2=A0 add PHY layer definitions and implementation
>   net/nbl:=C2=A0 add Channel layer definitions and implementation
>   net/nbl:=C2=A0 add Resource layer definitions and implementation
>   net/nbl:=C2=A0 add Dispatch layer definitions and implementation
>   net/nbl:=C2=A0 add Dev layer definitions and implementation
>   net/nbl:=C2=A0 add complete device init and uninit functionality
>   net/nbl:=C2=A0 add uio and vfio mode for nbl
>   net/nbl: =C2=A0bus/pci: introduce get_iova_mode for pci dev
>   net/nbl:=C2=A0 add nbl coexistence mode for nbl
>   net/nbl: add nbl ethdev configuration
>   net/nbl:=C2=A0add nbl device rxtx queue setup and release ops
>   net/nbl: add nbl device start and stop ops
>   net/nbl: add nbl device tx and rx burst
>   net/nbl: add nbl device xstats and stats
>   net/nbl: nbl device support set mtu and promisc
>=20
>  .mailmap                                      |    5 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |    9 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   42 +
>  doc/guides/rel_notes/release_25_07.rst        |    5 +
>  drivers/bus/pci/bus_pci_driver.h              |   11 +
>  drivers/bus/pci/linux/pci.c                   |    2 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_thread.c       |   88 ++
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  758 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  100 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1007 ++++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   65 +
>  drivers/net/nbl/nbl_dispatch.c                | 1226 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  167 +++
>  drivers/net/nbl/nbl_ethdev.h                  |   32 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  853 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  127 ++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.c       |  230 ++++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.h       |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_phy.h              |   28 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  153 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  906 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |  136 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  434 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  128 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |  107 ++
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |   95 ++
>  drivers/net/nbl/nbl_include/nbl_def_phy.h     |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   87 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  212 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   37 +
>  44 files changed, 7766 insertions(+)
>  create mode 100644 doc/guides/nics/features/nbl.ini
>  create mode 100644 doc/guides/nics/nbl.rst
>  create mode 100644 drivers/net/nbl/meson.build
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
>  create mode 100644 drivers/net/nbl/nbl_common/nbl_thread.c
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
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_s=
nic.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_phy_leonis_s=
nic.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_phy.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_resource.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.c
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx.h
>  create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dev.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_dispatch.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_phy.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_def_resource.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_include.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_logs.h
>  create mode 100644 drivers/net/nbl/nbl_include/nbl_product_base.h
>=20

Several spelling errors found by checkpatch should get fixed.


WARNING:TYPO_SPELLING: 'definetions' may be misspelled - perhaps 'definitio=
ns'?
#10:=20
add Channel layer related definetions and nbl_thread
                          ^^^^^^^^^^^


WARNING:TYPO_SPELLING: 'donot' may be misspelled - perhaps 'do not'?
#534: FILE: drivers/net/nbl/nbl_hw/nbl_channel.c:267:
+			NBL_LOG(INFO, "payload_len donot match ack_len!,"
 			                           ^^^^^

WARNING:TYPO_SPELLING: 'indivisual' may be misspelled - perhaps 'individual=
'?
#1054: FILE: drivers/net/nbl/nbl_hw/nbl_channel.h:109:
+ * Every indivisual mgt must have the common mgt as its first member, and =
contains its unique
          ^^^^^^^^^^

WARNING:TYPO_SPELLING: 'definetions' may be misspelled - perhaps 'definitio=
ns'?
#10:=20
add Resource layer related definetions
                           ^^^^^^^^^^^

WARNING:TYPO_SPELLING: 'definetions' may be misspelled - perhaps 'definitio=
ns'?
#10:=20
add Dispatch layer related definetions
                           ^^^^^^^^^^^

WARNING:TYPO_SPELLING: 'definetions' may be misspelled - perhaps 'definitio=
ns'?
#10:=20
add Dev layer related definetions
                      ^^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 432 lines checked

### [PATCH] net/nbl: add nbl device tx and rx burst

WARNING:TYPO_SPELLING: 'donot' may be misspelled - perhaps 'do not'?
#218: FILE: drivers/net/nbl/nbl_dispatch.c:696:
+	/* if donot have res_ops->get_link_state(), default eth is up */
 	      ^^^^^

WARNING:TYPO_SPELLING: 'dumplicate' may be misspelled - perhaps 'duplicate'?
#617: FILE: drivers/net/nbl/nbl_hw/nbl_txrx.c:653:
+	/* BUG on dumplicate pkt free */
 	          ^^^^^^^^^^

total: 0 errors, 2 warnings, 0 checks, 859 lines checked

### [PATCH] net/nbl: nbl device support set mtu and promisc

WARNING:TYPO_SPELLING: 'faild' may be misspelled - perhaps 'failed'?
#176: FILE: drivers/net/nbl/nbl_dispatch.c:867:
+			NBL_LOG(ERR, "userspace send set_promisc_mode ioctl msg faild ret %d", =
ret);
 			                                                        ^^^^^

total: 0 errors, 1 warnings, 0 checks, 265 lines checked
