Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D85DC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 17:44:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 447D0410FB;
	Thu, 12 Jun 2025 19:44:57 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 35951400D6
 for <dev@dpdk.org>; Thu, 12 Jun 2025 19:44:55 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6fb0eb0f0fbso12369286d6.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749750294;
 x=1750355094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZvADpfQWxce72BcFfekdoIlhJSfSvpvMo582OKi3MDU=;
 b=Q573V5Tlaa7n9eO9PTY0+BT8FOfzsUwHaVZXmdj6sS1+1D+N3+j1L5x90toC2hTwCc
 /FCcEYK0FBmH5rDn6gGzjNJMjHTmbiwzyeJXt4XSypk5WZOffbJS3N7IjQ5kVSUHQUj/
 s4VIBucfRDzXN4llf+A+7ji2Xjgd//T1PxoA6oZBwK5+2p0rbI12bka6mGC8xRxeiAB/
 UOaUyLQAh0o47njiIbL0aUltraf+bZgvitgyQiTaV1F8GaGN+QBuV8vXj2SKhVgffo7H
 2wUIXsxMlWLuELiY1mdncN+sP6e2GKleuE6DojbJyJt7V/g+z4HBUkhKCDEqIq5jGJHJ
 AvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749750294; x=1750355094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZvADpfQWxce72BcFfekdoIlhJSfSvpvMo582OKi3MDU=;
 b=a9uynZ6nK0wmAymloO/Qa7eH6suzAJwsH76QF4RLlNraL4f7EBeyBFhdlHypoXsXnd
 Nj5f/K6JOK6/VHNQmvhKdXRyGu0TveW9BdCggQZuUkMJloGq9WjikVP2g3F36rJy930u
 Q8HSZrtu+O8cH1ShBU7QgrdXtinhGcUdOYmyFS71NIJ4YtP76OI77p6/VunUTZOsCELH
 7pIugV3hA/YjBIfMNwl1IVFyWPB5nzVcl5KneY03N80OpS20Ua20w8Kp+C/8cLjqfNNx
 Xl31nblFIr2NItLrNJ25lrzmaurLUXFDcIrULE+Dl5sVljL41hA+lz/6U9k0QarF/wX0
 cQmA==
X-Gm-Message-State: AOJu0Yz3mAUrYmRx8PBTOyuQERqi7aO9JQlE/w+9NSfE+WSSv0M8P6Mi
 stI2Oi7jHbnrkNqIjdRumKZuKxj5VZvWzEsvVBzDt03sEF7M87qFRU5KOL/MmfTXwKI=
X-Gm-Gg: ASbGncsC9ZoNRAbVoUsrC5XeGvokcuZIY/KpDfSO55dJPZZv7LQqVW4FHKM3a0jwI1K
 IyVZ/nJkt+l5V31G0vtw4goFk2qnZXPuVc8kVPVmRiykbjgQzOmz9ocdX4qLcPG8GbbUnc3qbYC
 wVEfwsRVwLQg0U5bsT96w5Dfii7SW1lDzTO66BQ1RMWZf9V/J91NnMaGeEEZmMdinn8xTjChpLR
 B/Z+/xOlN7WIDJi4K13hLFwaGJ13YJxKCtOadi10hQd/a4LRdSSA0GBSe9aT50gdC4IvkIrTHK5
 E4mjel3lZXXEq7zFYAiXQlNo+mHmkvoykmD9m96frDyKfqpKbJfvOTxf5CBUPYPWaVGUUNEHKvq
 z14SGc7xJqSAD0YYRZ5mrUgzPF5HHc+03BdzMHS0=
X-Google-Smtp-Source: AGHT+IH8JzFiq5YiO9Dt5OzDFrl0Mo1iOdMFZyHKbz34doMcqSkni/afRr8yTC+OoLZYSarTztwpsA==
X-Received: by 2002:ad4:5de1:0:b0:6e6:5b8e:7604 with SMTP id
 6a1803df08f44-6fb3477cb91mr72484846d6.12.1749750294268; 
 Thu, 12 Jun 2025 10:44:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c5812csm12347766d6.93.2025.06.12.10.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 10:44:54 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:44:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kyo Liu <kyo.liu@nebula-matrix.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 00/17] NBL PMD for Nebulamatrix NICs
Message-ID: <20250612104451.4b0dbdd7@hermes.local>
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

The script check-git-log complains about case in several places.
It is not a hard requirement that this be followed, but best to follow it.

Wrong headline prefix:
	net/nbl: =C2=A0bus/pci: introduce get_iova_mode for pci dev
Wrong headline case:
			"net/nbl: nbl device support set mtu and promisc": mtu --> MTU
Wrong headline case:
			"net/nbl: =C2=A0bus/pci: introduce get_iova_mode for pci dev": pci --> P=
CI
Wrong headline case:
			"net/nbl: add nbl device tx and rx burst": rx --> Rx
Wrong headline case:
			"net/nbl: add nbl device tx and rx burst": tx --> Tx
Wrong headline case:
			"net/nbl:=C2=A0 add uio and vfio mode for nbl": vfio --> VFIO
Contributor name/email mismatch with .mailmap:=20
	Kyo Liu <kyo.liu@nebula-matrix.com> is unknown in .mailmap

