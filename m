Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5893C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 21:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1D394026D;
	Fri, 27 Jun 2025 23:07:57 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id C974F400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 23:07:56 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3213309b3a.3
 for <dev@dpdk.org>; Fri, 27 Jun 2025 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751058476;
 x=1751663276; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaPRoh5BFhq7bAFpo3z1BRw4GyZittETPKS9eNlRvWc=;
 b=e12NZPiRYD5qOfd/3dV2U4BB4mHtc1oFnxtW+UiX6tMRSODhWClYDviHjAsAlQJ+kO
 3S5I/r0M+hKD8KTAFL7fB38hotQxp/y2WHZbpK1CW2le0fDzFMmYy+AywU8M+RvwtAec
 40fzGA729D9VxJvGEmOmlyQZ5Or9H+7BFRaSKkpB8/r4VCr4c8YFPT6s67iTZuVjFikB
 Wd3pzUZbejjT/lQ7dIJmXK1u/7dAsClDPXPIuAhb1YE04UE9evxL/T+1EBg+cyLNDPec
 04lA6qp+OdUWwh7H++wNKDfeJQ/RM6NTOSfpzc+ORoi7D4x8Yli/nBa/W2jGPxR3sFgO
 rXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751058476; x=1751663276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaPRoh5BFhq7bAFpo3z1BRw4GyZittETPKS9eNlRvWc=;
 b=xPKAb2pkQgPMkN01RKLs6rX0vfcy53DhzeJTLkGRWbylE19o3eyiGkLZ14SpYFiZA4
 v410Yss5R243Hu2ZS54mUTQBcdqx1jJdBjIa9QRtrbJK14QqqWrnh/FegOHYZmtJdQsJ
 Q7oqzSl0JHCAkeznRLfpMSCxAJw4qUICoZwsCeHBaNHin6y/lFrXsphaJAhx5KrDky0g
 EW7io21dAb+gFFLSD3baGNjCCbElaidMO/DcYCc//nqIM405fg6hWPIBrqlPUk7NYJk1
 DLeX0AvD9ISxhUL5c8ZNpI8KwRb1aWq3SLEECcM8Mv/BoQtdvk/uS1hEk3JhTYX9f7V9
 5yrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBd13ESov4o+lLOpb+LC1a0aFbv5OKVFeZHyQDGv23MBkLPbTZxRCCioKn4B6GJVY484E=@dpdk.org
X-Gm-Message-State: AOJu0Yy3TX5Z9AiEaqCJ4UEL79PLFH6v/lUo57dgk4eV/m/ptuuIbnPp
 EqlpCzzpZJrxRG1D7AOrYoLvvMXxsR22hkTZuW6abvbZsL8n6/vlG0YnDZNz/E4lZX8rkn3qeL4
 ejO5N
X-Gm-Gg: ASbGncvD8qT0Y0ImCkbNpn2DnLBRJPYv9qx2G66jL3GOc0toRkkLsRmC8dxt7vT1q4/
 W638+OwALBfItt/KW/OTLj+6+Rqs/Pt6P98RLLwiplq5VtrwbvjHRv4AmHWL4Vc3uedU5FI0uAj
 HKb1MLyn4x+suB0jc3o0jJ4KBNXAQsjbdU2Nc7bVh/jy7Mrb/RXUN1Ulva5iIVnHHzWz7Awwe2n
 eg0KPATpZkEmI1YrMVlBC6b50stOoH/VTYsHtbesmpEUdz18JdglVT0nN4rZPj68VgvvFfiJEDX
 +ygjvyvJXlgiBfReAq3yXOt5Q8cwvpUUQsl91hqOOEQL2hdlipfqetgE4gheXFu357LvXAMO1Es
 atqFFOo4tdXdeksPRXQvKVytfhqDSUzzORvS6Tm3P96ueZ3X8gw==
X-Google-Smtp-Source: AGHT+IH4FStmXenNu5soNQlPN3787Qq+2Yr0JhkLxcPmd9e5pYxOizmtN/z2SI1+gn1CEgFjYqYY3g==
X-Received: by 2002:a05:6a20:4308:b0:220:2caa:3018 with SMTP id
 adf61e73a8af0-220a16a2187mr8277468637.24.1751058475678; 
 Fri, 27 Jun 2025 14:07:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af57ed353sm2865920b3a.153.2025.06.27.14.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 14:07:55 -0700 (PDT)
Date: Fri, 27 Jun 2025 14:07:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "dimon.zhao" <dimon.zhao@nebula-matrix.com>
Cc: kyo.liu@nebula-matrix.com, dev@dpdk.org
Subject: Re: [PATCH v3 00/16] NBL PMD for Nebulamatrix NICs
Message-ID: <20250627140752.0220aee5@hermes.local>
In-Reply-To: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
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

On Thu, 26 Jun 2025 18:40:06 -0700
"dimon.zhao" <dimon.zhao@nebula-matrix.com> wrote:

> Features:
> ---------
> - MTU update
> - promisc mode set
> - xstats
> - Basic stats=C2=A0
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
> Dimon Zhao (16):
>   net/nbl: add doc and minimum nbl build framework
>   net/nbl: add simple probe/remove and log module
>   net/nbl: add PHY layer definitions and implementation
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
>   net/nbl: add nbl device xstats and stats
>   net/nbl: nbl device support set MTU and promisc
>=20
>  .mailmap                                      |    4 +
>  MAINTAINERS                                   |    9 +
>  doc/guides/nics/features/nbl.ini              |    9 +
>  doc/guides/nics/index.rst                     |    1 +
>  doc/guides/nics/nbl.rst                       |   42 +
>  drivers/net/meson.build                       |    1 +
>  drivers/net/nbl/meson.build                   |   26 +
>  drivers/net/nbl/nbl_common/nbl_common.c       |   47 +
>  drivers/net/nbl/nbl_common/nbl_common.h       |   10 +
>  drivers/net/nbl/nbl_common/nbl_thread.c       |   88 ++
>  drivers/net/nbl/nbl_common/nbl_userdev.c      |  743 ++++++++++
>  drivers/net/nbl/nbl_common/nbl_userdev.h      |   21 +
>  drivers/net/nbl/nbl_core.c                    |  100 ++
>  drivers/net/nbl/nbl_core.h                    |   98 ++
>  drivers/net/nbl/nbl_dev/nbl_dev.c             | 1007 ++++++++++++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h             |   65 +
>  drivers/net/nbl/nbl_dispatch.c                | 1227 +++++++++++++++++
>  drivers/net/nbl/nbl_dispatch.h                |   31 +
>  drivers/net/nbl/nbl_ethdev.c                  |  161 +++
>  drivers/net/nbl/nbl_ethdev.h                  |   32 +
>  drivers/net/nbl/nbl_hw/nbl_channel.c          |  853 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_channel.h          |  127 ++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.c       |  230 +++
>  .../nbl_hw_leonis/nbl_phy_leonis_snic.h       |   53 +
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |  253 ++++
>  .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.h |   10 +
>  drivers/net/nbl/nbl_hw/nbl_phy.h              |   28 +
>  drivers/net/nbl/nbl_hw/nbl_resource.c         |    5 +
>  drivers/net/nbl/nbl_hw/nbl_resource.h         |  153 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx.c             |  907 ++++++++++++
>  drivers/net/nbl/nbl_hw/nbl_txrx.h             |  136 ++
>  drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |   91 ++
>  drivers/net/nbl/nbl_include/nbl_def_channel.h |  434 ++++++
>  drivers/net/nbl/nbl_include/nbl_def_common.h  |  128 ++
>  drivers/net/nbl/nbl_include/nbl_def_dev.h     |  107 ++
>  .../net/nbl/nbl_include/nbl_def_dispatch.h    |   95 ++
>  drivers/net/nbl/nbl_include/nbl_def_phy.h     |   35 +
>  .../net/nbl/nbl_include/nbl_def_resource.h    |   87 ++
>  drivers/net/nbl/nbl_include/nbl_include.h     |  203 +++
>  drivers/net/nbl/nbl_include/nbl_logs.h        |   25 +
>  .../net/nbl/nbl_include/nbl_product_base.h    |   37 +
>  41 files changed, 7719 insertions(+)
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

This submission is too late to make 25.07 release; but here is first
pass review, will do more when you follow up.

The driver compiles and for all variations of compilers, etc
this is good. Doc say 32 bit not supported, but build works
and not flagged by meson build checks.

Saw the following minor things:

There are some checkpatch warnings about unused macro argument.
Ok, to keep but would be better to fix.

The check-git-log scrip flags:
Contributor name/email mismatch with .mailmap:
	dimon.zhao <dimon.zhao@nebula-matrix.com> is unknown in .mailmap
Probably just capitalization in some patch.

You don't say if driver is save from primary secondary process?

The driver has more features like multi-q and jumbo frame which
are not called out in doc_guides/nics/features/nbl.rst

Don't use rte_memcpy (instead just use memcpy).
rte_memcpy should be reserved for variable length copies in the
data path.

The following are more major issues:

Kernel module(s):
You need explicitly mention kernel modules with RTE_PMD_REGISTER_KMOD_DEP(_)
and if it is a not upstream module provide a link to the kernel source.

Control thread.
Adding additional threads can be a problem in embedded systems.
And especially if those threads end up polling.
Even worse since all control threads share a single lcore.
If you need a control thread then figure out a way to make it blocking
using eventfd or pipe? DPDK tries to avoid doing work queue type
things.

The setup of the DPDK ethdev ops is done dynamically via macros.
This is just added confusion and makes the driver different than all
the others without any benefit. Just follow the existing design
pattern. Ops table should be const.

I also look at comparing features in doc vs ethdev ops
and this makes review harder.

