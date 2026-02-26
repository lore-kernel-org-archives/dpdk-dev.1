Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512BFFD8FD8
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:50:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CE7E40655;
	Thu, 26 Feb 2026 17:50:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D04DB402B2
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772124629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvD7bot5s+LSKPk4XFrRTFlEedCvkupubXBY0ROnjKU=;
 b=h2wERxXEKi691OHT0e8B7aPdxyjCOh2XFjUjswEtoNkkeceEdtqoI0H0RVu3kq3+LUlyvI
 Ly8sKVyLUr7xEuM3N7BCCkZza8YRjYAvsw02+DLaqh4qDINgT9tCtYmkJMyNe8NduRg3Pd
 WzI23yBat63oTpWgKpZH7w23yC4w12Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-bCE0pOS8OEeSGp7DLLQxDQ-1; Thu, 26 Feb 2026 11:50:27 -0500
X-MC-Unique: bCE0pOS8OEeSGp7DLLQxDQ-1
X-Mimecast-MFC-AGG-ID: bCE0pOS8OEeSGp7DLLQxDQ_1772124627
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so11091545e9.3
 for <dev@dpdk.org>; Thu, 26 Feb 2026 08:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124626; x=1772729426;
 h=in-reply-to:references:user-agent:from:cc:subject:to:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=puXqYlr6DLB3KpR+62OB6v6l//l3oOE3XgCpThTWUwI=;
 b=F9A7P40KsFHqpbTSEw5vEyA4p7oWekB1rhnOC0yS2auHkDgvWVwfsYx84GluGwtPSh
 0VV33lTRzZYe7x1UP9PdAgJXQUpujlf6JsbcK5Wq7BO5tycDm4QBBhLygoEhAXI8yG2b
 cDmK5f9xtqmaktwzjt7ia8wWn055TBzH+FTZqotL8JUFu8Dg0KYoe8cfWNLO1qVVcVYL
 lJGyzrgUg9tFcDRaC78viUF7wbtGDlF/Wv+exKcJLW9FWhYaUzpBqR0UI8ZaDLFaAcLr
 PZXDiZLeO2uegMuX+wyRH06fpE6HYK1zsv/cKBN+gZMJ/hjE7bFsu/TGVhUkCWF1Dc2p
 lyWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhZplVun7BDcczXNKKZwTGKzSLlVpzLEAoD3AofDZS4pDFE+n5F4j4wrRI/CJJkEI6Y+0=@dpdk.org
X-Gm-Message-State: AOJu0Yxap0AauMJITlv0kpC7eyuXd9W/oOd7wve/Ux7Z0jbqbuwkG/t5
 +OcQYtMQ55SKEdqbGVoLcfypb0CcCq19y2ftg7eiUNMIVywSFtHvs4nn91xJ3ou5dS8CkCu5Dsn
 IFNdEl45TKMQBkSKk0XrtNNbXHh11VSQmmi4QqdntNFV2
X-Gm-Gg: ATEYQzyGErTs9YzoPptvRCbPSMBXlXh2udngpt/MpMQ9s9stXJDxbwYeMJUYFVMdz7u
 5WrbbIx48MKYZ+xiyYr+IpGJjjFtqWERGFcADPZNC5cMO1vETBrcYeg3E3qNgjKFGaWLbDLskga
 /l9LTPQQF5zG1IUOw7Wkh0OOBg7xNWfW0iF/xWmSjZ2ZBA11uf7PjIllAHefmM0cjRajb0TN0Bd
 48yWoDj5q41LEuvwSL2ghuAps0DKWBbm4yCpmfMOcoI10FxUeIpk7hNr/ULkOmlocwzBimLlSqf
 hNSvs9RBHOIF3v/wvk+X9R2/SAUJZptWbSCIt7uoEbxcpm3TK9sAgYAL0FSNADmdadN4thGEPXT
 lBxvBU1Lsjez/MN6L5XvkjzRXPYrvDN+Q6+KhLyE8571FwuiYw5cpsynp2dNYEoZxC8yl52ErQI
 rtN/jR
X-Received: by 2002:a05:600c:3e0e:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c3db2184mr53746585e9.1.1772124626442; 
 Thu, 26 Feb 2026 08:50:26 -0800 (PST)
X-Received: by 2002:a05:600c:3e0e:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483c3db2184mr53746185e9.1.1772124625881; 
 Thu, 26 Feb 2026 08:50:25 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60e40fsm703694f8f.7.2026.02.26.08.50.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 08:50:25 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 26 Feb 2026 17:50:24 +0100
Message-Id: <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
Cc: "Thomas Monjalon" <thomas@monjalon.net>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>
From: "Robin Jarry" <rjarry@redhat.com>
User-Agent: aerc/0.21.0-98-g3a0874577a2a
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
In-Reply-To: <20260226162057.207202-6-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -S7U-V4iBt4wuDqYQo0TmHo-vh5MA9s2QBgY3Tf3-8o_1772124627
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

David Marchand, Feb 26, 2026 at 17:20:
> Some applications use port hotplug as their primary way for using DPDK
> resources.
> Having a systematic device probing is a problem when not all available
> resources will be used by the application, as such applications won't set
> an explicit allow list at startup.
>
> This is the case for OVS on systems with multiple mlx5 devices:
> one device can be used by the kernel while the other(s) are used by DPDK.
> In such a setup, the kernel used device may get reconfigured in
> unexpected ways and trigger issues like the one described by Kevin
> not so long ago in bugzilla 1873.
>
> Add an EAL option so that we can change the default behavior from
> block-listing to allow-listing.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since RFC v1:
> - changed approach following Bruce suggestion,

Hey David,

thanks for the patch. The idea looks much nicer than some magic PCI bus
value that disables auto probing.

I have a few cosmetic remarks below:

>
> ---
>  app/test/test_eal_flags.c                 |  9 ++++++++
>  devtools/test-null.sh                     |  2 +-
>  doc/guides/linux_gsg/eal_args.include.rst |  6 ++++++
>  lib/eal/common/eal_common_bus.c           | 25 +++++++++++++++++------
>  lib/eal/common/eal_common_options.c       |  3 +++
>  lib/eal/common/eal_option_list.h          |  1 +
>  lib/eal/common/eal_private.h              |  6 ++++++
>  7 files changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
> index b3a8d0ae6f..a58d0b9c06 100644
> --- a/app/test/test_eal_flags.c
> +++ b/app/test/test_eal_flags.c
> @@ -1030,6 +1030,10 @@ test_misc_flags(void)
>  =09const char * const argv28[] =3D {prgname, prefix, mp_flag, eal_debug_=
logs,
>  =09=09=09=09       "--log-color=3Dinvalid" };
> =20
> +=09/* Try running with --allow-explicitly */
> +=09const char * const argv29[] =3D {prgname, prefix, mp_flag, eal_debug_=
logs,
> +=09=09=09=09       "--allow-explicitly" };

I am not convinced by the option name. What do you think of:

=09--no-autoprobe

That would match the Linux sriov_drivers_autoprobe sysfs.

> +
>  =09/* run all tests also applicable to FreeBSD first */
> =20
>  =09if (launch_proc(argv0) =3D=3D 0) {
> @@ -1176,6 +1180,11 @@ test_misc_flags(void)
>  =09=09=09__LINE__);
>  =09=09goto fail;
>  =09}
> +=09if (launch_proc(argv29) !=3D 0) {
> +=09=09printf("Error (line %d) - process did not run ok with --allow-expl=
icitly parameter\n",
> +=09=09=09__LINE__);
> +=09=09goto fail;
> +=09}
> =20
>  =09rmdir(hugepath_dir3);
>  =09rmdir(hugepath_dir2);
> diff --git a/devtools/test-null.sh b/devtools/test-null.sh
> index 8f21189262..37b8760f60 100755
> --- a/devtools/test-null.sh
> +++ b/devtools/test-null.sh
> @@ -30,7 +30,7 @@ logfile=3D$build/test-null.log
>  (sleep 1 && echo stop) |
>  # testpmd only needs 20M, make it x2 (default number of cores) for NUMA =
systems
>  $testpmd -l $corelist --no-huge -m 40 \
> -=09$libs -a 0:0.0 --vdev net_null1 --vdev net_null2 $eal_options -- \
> +=09$libs --allow-explicitly --vdev net_null1 --vdev net_null2 $eal_optio=
ns -- \
>  =09--no-mlockall --total-num-mbufs=3D2048 $testpmd_options -ia | tee $lo=
gfile
> =20
>  # we expect two ports and some traffic is received and transmitted
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux=
_gsg/eal_args.include.rst
> index 4a3c4d9b5f..f6e56468b5 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -101,6 +101,12 @@ Lcore-related options
>  Device-related options
>  ~~~~~~~~~~~~~~~~~~~~~~
> =20
> +*   ``--allow-explicitly``
> +
> +    By default, EAL probes all devices on every available bus, unless so=
me ``-a``/``-b``/``--vdev``
> +    options are passed.
> +    However, when an application relies on hotplug, it may want to plug =
each device explicitly.

Can you reword this to make it explicit what the flag does? E.g.:

=09Disable automatic probing of non-blocked devices.

> +
>  *   ``-b, --block <[domain:]bus:devid.func>``
> =20
>      Skip probing a PCI device to prevent EAL from using it.
> diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_=
bus.c
> index fbe20cfe35..9a29c6a062 100644
> --- a/lib/eal/common/eal_common_bus.c
> +++ b/lib/eal/common/eal_common_bus.c
> @@ -15,6 +15,8 @@
>  #include <eal_export.h>
>  #include "eal_private.h"
> =20
> +static bool allow_explicitly;
> +
>  static struct rte_bus_list rte_bus_list =3D
>  =09TAILQ_HEAD_INITIALIZER(rte_bus_list);
> =20
> @@ -98,6 +100,12 @@ rte_bus_probe(void)
>  =09return 0;
>  }
> =20
> +void
> +eal_bus_set_allow_explicitly(void)
> +{
> +=09allow_explicitly =3D true;
> +}
> +
>  /* Clean up all devices of all buses */
>  int
>  eal_bus_cleanup(void)
> @@ -231,16 +239,21 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_bus_is_ignored_devic=
e)
>  bool
>  rte_bus_is_ignored_device(const struct rte_bus *bus, const struct rte_de=
vargs *devargs)
>  {
> -=09switch (bus->conf.scan_mode) {
> -=09case RTE_BUS_SCAN_ALLOWLIST:
> +=09enum rte_bus_scan_mode scan_mode =3D bus->conf.scan_mode;
> +
> +=09if (scan_mode =3D=3D RTE_BUS_SCAN_UNDEFINED) {
> +=09=09if (allow_explicitly)
> +=09=09=09scan_mode =3D RTE_BUS_SCAN_ALLOWLIST;
> +=09=09else
> +=09=09=09scan_mode =3D RTE_BUS_SCAN_BLOCKLIST;
> +=09}
> +
> +=09if (scan_mode =3D=3D RTE_BUS_SCAN_ALLOWLIST) {
>  =09=09if (devargs && devargs->policy =3D=3D RTE_DEV_ALLOWED)
>  =09=09=09return false;
> -=09=09break;
> -=09case RTE_BUS_SCAN_UNDEFINED:
> -=09case RTE_BUS_SCAN_BLOCKLIST:
> +=09} else {
>  =09=09if (devargs =3D=3D NULL || devargs->policy !=3D RTE_DEV_BLOCKED)
>  =09=09=09return false;
> -=09=09break;
>  =09}
>  =09return true;
>  }
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_com=
mon_options.c
> index aad676a004..3f75f2c436 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -1972,6 +1972,9 @@ eal_parse_args(void)
>  =09=09}
>  =09}
> =20
> +=09if (args.allow_explicitly)
> +=09=09eal_bus_set_allow_explicitly();
> +
>  =09/* device -a/-b/-vdev options*/
>  =09TAILQ_FOREACH(arg, &args.allow, next)
>  =09=09if (eal_option_device_add(RTE_DEVTYPE_ALLOWED, arg->arg) < 0)
> diff --git a/lib/eal/common/eal_option_list.h b/lib/eal/common/eal_option=
_list.h
> index abee16340b..4e02766500 100644
> --- a/lib/eal/common/eal_option_list.h
> +++ b/lib/eal/common/eal_option_list.h
> @@ -32,6 +32,7 @@
>   * Format of each entry: long name, short name, help string, struct memb=
er name.
>   */
>  /* (Alphabetical) List of common options first */
> +BOOL_ARG("--allow-explicitly", NULL, "Change EAL device probing to consi=
der only allowed devices", allow_explicitly)

Depending on what option name we settle on, could you add a short flag
too? E.g.:

BOOL_ARG("--no-autoprobe", "-N", "Disable automatic probing of non-blocked =
devices", no_autoprobe)

Or:

BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of non-blocked =
devices", no_autoprobe)

>  LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to onl=
y use specified devices", allow)
>  STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory=
", base_virtaddr)
>  LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK fro=
m using the device", block)
> diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
> index e032dd10c9..0bad3de56c 100644
> --- a/lib/eal/common/eal_private.h
> +++ b/lib/eal/common/eal_private.h
> @@ -469,6 +469,12 @@ int rte_eal_memory_detach(void);
>   */
>  struct rte_bus *rte_bus_find_by_device_name(const char *str);
> =20
> +/**
> + * Change behavior of rte_bus_probe() from a block-listing approach
> + * to an allow-listing approach.
> + */
> +void eal_bus_set_allow_explicitly(void);
> +
>  /**
>   * For each device on the buses, call the driver-specific function for
>   * device cleanup.

