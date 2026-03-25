Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0BE109C028
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 15:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72BFC402CE;
	Wed, 25 Mar 2026 16:22:43 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 3B67F4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 16:22:42 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-89a0d53f3d1so80532206d6.3
 for <dev@dpdk.org>; Wed, 25 Mar 2026 08:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774452161; cv=none;
 d=google.com; s=arc-20240605;
 b=HgBpqbW18P2w9Md+bbMZ7pvlHsBcotsekWvjjhD5c2FGXWueb2t7DzqB7npCTiGCj2
 YONeKQ0NP8TP+HOpYSZusO6d24lXU+wKB2W6Rsx7X+ZXOn709cHHCGvk1AUxvWLZvd4w
 nlSSCb58BzWBSxMU37UaKzJBqzdLuzCUh34iijn7NXj6OwdbihZdHXta+gCXW+Z4OArA
 /wYx4NjEdpssQ4NtIAUkDH3tMXI0yC7f3byAYCUFIxPLqtL1/BEtCNGzX6mrL6GtQjF8
 jwmwHg6ZJ45iLXobDJjh8Zl2pOwzC3Ln0qV09ldZ5iputNaNPqUQHf2szphUIL/cwSZD
 tm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=wamZAhEIYY5IsyFhpMSgmmuPgImUWn7h0S2M0PxKJc8=;
 fh=qtx+rTXMu0jT4NwnisPY8YqyFA3IRvAKA50FaVvbcNg=;
 b=U6mFuclzKTJX4RVJnt+n5YX8fwbjRV7VSIfvEjeEfbaScxc0FrnvOqLGotEJcdmPAI
 NuoEMAESZIEldldQvAREinqeSkD34+h06P0XNjS1h0DQ2QMAoJHdIaSYN2s1iu8Bsv5L
 W6kJ/k0UT462nxPUCAPeqqzaBtVwR9+NIWv1wYEPNye61HFgZqJSobgA00awS5TBHVqg
 BQ7R7ZzNfC4mBKx4soI9Uy3Z9AWSid1fzBKwKslGwkvcDspSRUrb+DDhAGl++6MwMVx7
 wx8nc65oPS8tQTkajjjQsA3z4XEqO7/AnnawYPG/QLeeUfHnclwbiw2FkpzOPY0EC0U3
 /ICw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452161; x=1775056961;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wamZAhEIYY5IsyFhpMSgmmuPgImUWn7h0S2M0PxKJc8=;
 b=pWaWze2iJ6/z8cEfOeQdnz2GdUCY3Oth1ngdD80u6Vvz78+DaMYxVASPKHTbVfcWI9
 HJ6PnJghimFfkpZyT4etq/ybC9b30BlhOmK1MZPBfhU0paH2RIri99vcwNliQMyBxLsV
 KDwiJoryI6kFlqXTw1EvfXz7UlsIP3CEzVXeuQEw+i+Y7s5puHnjk7g8ui1UrY8/PI+b
 LCrhCAw3dD6P0xl3RYGA9jbBcvTjVrGMBDBuKbjFoUz9AKiEvBrpAuI9town48evRZ/b
 3sMruu+lyi6N5aGaVoLnbfxbhIaGuORUzGzmBGIwHvPbR468R4b5pML0mpBHVKv77kmL
 H0yw==
X-Gm-Message-State: AOJu0YxDEk0URjNtlpP9NmduGLO5Vt3uGfdez+9SaeO3d3M7BZOWrh91
 7UMuQZC0dcA4a2JjKpfR+PSwI/FDKaBXtGNxholfDFcPfILVBJpG8H2qrmsXSZHMhrB9Ne7eNWi
 pxj4EEwdDTf2mLOEzonOXvNgkb9Sml9k=
X-Gm-Gg: ATEYQzzvrpVXhBa04wU0/Tz1e05HF/0yb/6jcfccO3YR7x6utQVi7ed1bz9NHUEKIyQ
 pC41jSnyL+w6DObnuexJQ/nhMmSxZhxMeiLXzCAMquzQd+ENHR+sRze6biJuWJumVNwdoUPo6IR
 QV4ma8QHtxZn1TJkn6LTd34iiszHI9v1cdmWE7Z1xDBuRrtuJRf85Kx52Th04dm/MFWpgANpKvr
 iMU7OY/4cdu2sIGqGOBfhMtdfC2O9lG+LSVwSrPRP/WYzMXB+PYwN5LIScZBbjE16rDpQHCO8Qn
 9sqs
X-Received: by 2002:a05:6214:23cf:b0:89c:ac72:2f6e with SMTP id
 6a1803df08f44-89cc4aa6a4emr62245506d6.43.1774452161350; Wed, 25 Mar 2026
 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105306.1531689-1-david.marchand@redhat.com>
In-Reply-To: <20260323105306.1531689-1-david.marchand@redhat.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Wed, 25 Mar 2026 16:22:29 +0100
X-Gm-Features: AQROBzCPlq7SziDpci60trvbya-6fySQYfQte7R1YkW1homlIUIS2vaRdU5ytQc
Message-ID: <CAHHRULUfdPm33sE7MDSpwLGCzHGJySp9=u+DBwTg3YXhioSNkA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Rework device probing
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Hi David,

On Mon, Mar 23, 2026 at 11:53=E2=80=AFAM David Marchand
<david.marchand@redhat.com> wrote:
>
> Applications relying on device hotplug don't work well with the default
> probing of all available resources.
> This series proposes to change this behavior via a new EAL option.

On my side, the whole series works fine with Grout on NXP CPUs.
I can add DPDK ports, send/receive traffic, delete ports, recreate them, et=
c.

>
>
> --
> David Marchand
>
> Changes since RFC v3:
> - removed per bus scan mode,
>
> Changes since RFC v2:
> - went one step further and reworked devargs lookup in buses following
>   Bruce comment (see patch 4 which is cosmetic, and patch 5),
> - updated device selection helper accordingly and
>   changed API to be device name based,
> - renamed option, added check on -b presence, updated doc in the last
>   patch,
>
> Changes since RFC v1:
> - reviewed bus probe() and cleaned up NXP drivers,
> - changed approach following Bruce comment,
>
> David Marchand (8):
>   devtools: check packet forwarding in null test
>   bus/fslmc: fix bus cleanup
>   drivers/bus: require probe function for NXP drivers
>   drivers: cleanup devargs lookup in bus scan
>   bus: factorize devargs lookup
>   bus: factorize device selection
>   bus: remove per bus scan mode
>   eal: configure initial device probing
>
>  app/test/test_eal_flags.c                    | 63 +++++++++++++++++
>  devtools/test-null.sh                        | 10 ++-
>  doc/guides/linux_gsg/eal_args.include.rst    | 13 ++++
>  drivers/bus/auxiliary/auxiliary_common.c     | 33 +--------
>  drivers/bus/auxiliary/bus_auxiliary_driver.h |  2 -
>  drivers/bus/auxiliary/linux/auxiliary.c      |  2 +-
>  drivers/bus/auxiliary/private.h              |  6 --
>  drivers/bus/cdx/cdx.c                        | 34 +---------
>  drivers/bus/dpaa/dpaa_bus.c                  | 71 +++++++++-----------
>  drivers/bus/fslmc/fslmc_bus.c                | 69 ++++++++-----------
>  drivers/bus/fslmc/fslmc_vfio.c               | 21 ++----
>  drivers/bus/ifpga/bus_ifpga_driver.h         |  2 -
>  drivers/bus/ifpga/ifpga_bus.c                |  4 +-
>  drivers/bus/pci/bsd/pci.c                    |  5 +-
>  drivers/bus/pci/linux/pci.c                  |  2 +-
>  drivers/bus/pci/pci_common.c                 | 51 ++++----------
>  drivers/bus/pci/private.h                    | 11 ---
>  drivers/bus/pci/windows/pci.c                |  4 +-
>  drivers/bus/platform/platform.c              | 43 +-----------
>  drivers/bus/uacce/uacce.c                    | 39 +----------
>  drivers/bus/vdev/vdev.c                      |  2 +-
>  drivers/bus/vmbus/linux/vmbus_bus.c          |  2 +-
>  drivers/bus/vmbus/private.h                  |  3 -
>  drivers/bus/vmbus/vmbus_common.c             | 45 +++----------
>  drivers/dma/idxd/idxd_bus.c                  | 18 +----
>  drivers/raw/ifpga/ifpga_rawdev.c             |  2 +-
>  lib/eal/common/eal_common_bus.c              | 62 +++++++++++++++++
>  lib/eal/common/eal_common_devargs.c          |  8 +--
>  lib/eal/common/eal_common_options.c          | 10 +++
>  lib/eal/common/eal_internal_cfg.h            |  1 +
>  lib/eal/common/eal_option_list.h             |  2 +
>  lib/eal/common/eal_private.h                 | 31 +++++++++
>  lib/eal/include/bus_driver.h                 | 55 ++++++++++-----
>  33 files changed, 338 insertions(+), 388 deletions(-)
>
> --
> 2.53.0
>

Best regards,

Maxime Leroy
