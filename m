Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C2EC7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F5340647;
	Mon, 30 Jun 2025 13:15:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 52C5840264;
 Mon, 30 Jun 2025 13:15:24 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW3R83WRKz6L4xS;
 Mon, 30 Jun 2025 19:12:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id CFABC1402EC;
 Mon, 30 Jun 2025 19:15:23 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 13:15:23 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 13:15:23 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "techboard@dpdk.org"
 <techboard@dpdk.org>, Vipin Varghese <vipin.varghese@amd.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [PATCH] eal: deprecate old coremask-based EAL parameters
Thread-Topic: [PATCH] eal: deprecate old coremask-based EAL parameters
Thread-Index: AQHb5Q3NZ0DT7MzfT0e52k+z9udUtbQbljmw
Date: Mon, 30 Jun 2025 11:15:23 +0000
Message-ID: <8c78d94234504755b0b7b4bcd3884e3f@huawei.com>
References: <20250624134139.552315-1-bruce.richardson@intel.com>
In-Reply-To: <20250624134139.552315-1-bruce.richardson@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.141]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Tuesday, June 24, 2025 2:42 PM
> To: dev@dpdk.org
> Cc: david.marchand@redhat.com; thomas@monjalon.net; techboard@dpdk.org; B=
ruce Richardson <bruce.richardson@intel.com>;
> Vipin Varghese <vipin.varghese@amd.com>; Tyler Retzlaff <roretzla@linux.m=
icrosoft.com>
> Subject: [PATCH] eal: deprecate old coremask-based EAL parameters
>=20
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
>=20
> Depends-on: series-35540 ("use core lists not masks in documentation")
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vipin Varghese <vipin.varghese@amd.com>
> ---
>  doc/guides/linux_gsg/build_sample_apps.rst |  7 +++----
>  doc/guides/linux_gsg/eal_args.include.rst  |  9 ---------
>  doc/guides/rel_notes/deprecation.rst       | 10 ++++++++++
>  lib/eal/common/eal_common_options.c        |  6 ++++++
>  lib/eal/include/rte_lcore.h                |  1 -
>  5 files changed, 19 insertions(+), 14 deletions(-)
>=20
> diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linu=
x_gsg/build_sample_apps.rst
> index 8b8026705b..9ce564e881 100644
> --- a/doc/guides/linux_gsg/build_sample_apps.rst
> +++ b/doc/guides/linux_gsg/build_sample_apps.rst
> @@ -126,10 +126,9 @@ and that cores 0-3 are present and are to be used fo=
r running the application)::
>  Logical Core Use by Applications
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> -The coremask (-c 0x0f) or corelist (-l 0-3) parameter is always mandator=
y for DPDK applications.
> -Each bit of the mask corresponds to the equivalent logical core number a=
s reported by Linux. The preferred corelist option is a cleaner
> method to define cores to be used.
> +The corelist (-l/--lcores 0-3) parameter is always mandatory for DPDK ap=
plications.
>  Since these logical core numbers, and their mapping to specific cores on=
 specific NUMA sockets, can vary from platform to platform,
> -it is recommended that the core layout for each platform be considered w=
hen choosing the coremask/corelist to use in each case.
> +it is recommended that the core layout for each platform be considered w=
hen choosing the corelist to use in each case.
>=20
>  On initialization of the EAL layer by a DPDK application, the logical co=
res to be used and their socket location are displayed.
>  This information can also be determined for all cores on the system by e=
xamining the ``/proc/cpuinfo`` file, for example, by running
> cat ``/proc/cpuinfo``.
> @@ -151,7 +150,7 @@ This can be useful when using other processors to und=
erstand the mapping of the
>=20
>  .. warning::
>=20
> -    The logical core layout can change between different board layouts a=
nd should be checked before selecting an application
> coremask/corelist.
> +    The logical core layout can change between different board layouts a=
nd should be checked before selecting an application corelist.
>=20
>  Hugepage Memory Use by Applications
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux=
_gsg/eal_args.include.rst
> index 6ee79877c1..b0cd757569 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -4,10 +4,6 @@
>  Lcore-related options
>  ~~~~~~~~~~~~~~~~~~~~~
>=20
> -*   ``-c <core mask>``
> -
> -    Set the hexadecimal bitmask of the cores to run on.
> -
>  *   ``-l/--lcores <core list>``
>=20
>      List of cores to run on
> @@ -75,15 +71,10 @@ Lcore-related options
>=20
>      Core ID that is used as main.
>=20
> -*   ``-s <service core mask>``
> -
> -    Hexadecimal bitmask of cores to be used as service cores.
> -
>  *   ``-S <service core list>``
>=20
>      List of cores to be used as service cores.
>=20
> -
>  Device-related options
>  ~~~~~~~~~~~~~~~~~~~~~~
>=20
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/=
deprecation.rst
> index 36489f6e68..2ea898ff8a 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -17,6 +17,16 @@ Other API and ABI deprecation notices are to be posted=
 below.
>  Deprecation Notices
>  -------------------
>=20
> +* EAL: The ``-c <coremask>`` commandline parameter is deprecated
> +  and will be removed in a future release.
> +  Use the ``-l <corelist>`` or ``--lcores=3D<corelist>`` parameters inst=
ead
> +  to specify the cores to be used when running a DPDK application.
> +
> +* EAL: The ``-s <service-coremask>`` commandline parameter is deprecated
> +  and will be removed in a future release.
> +  Use the ``-S <service-corelist>`` parameter instead
> +  to specify the cores to be used for background services in DPDK.
> +
>  * build: The ``enable_kmods`` option is deprecated and will be removed i=
n a future release.
>    Setting/clearing the option has no impact on the build.
>    Instead, kernel modules will be always built for OS's where out-of-tre=
e kernel modules
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_com=
mon_options.c
> index 83b6fc7e89..f0a9ddeeb7 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -616,6 +616,9 @@ eal_parse_service_coremask(const char *coremask)
>  	int val;
>  	uint32_t taken_lcore_count =3D 0;
>=20
> +	EAL_LOG(WARNING, "'-s <service-coremask>' is deprecated, and will be re=
moved in a future release.");
> +	EAL_LOG(WARNING, "\tUse '-S <service-corelist>' option instead.");
> +
>  	if (coremask =3D=3D NULL)
>  		return -1;
>  	/* Remove all blank characters ahead and after .
> @@ -779,6 +782,9 @@ rte_eal_parse_coremask(const char *coremask, int *cor=
es)
>  		cores[idx] =3D -1;
>  	idx =3D 0;
>=20
> +	EAL_LOG(WARNING, "'-c <coremask>' option is deprecated, and will be rem=
oved in a future release");
> +	EAL_LOG(WARNING, "\tUse '-l <corelist>' or '--lcores=3D<corelist>' opti=
on instead");
> +
>  	/* Remove all blank characters ahead and after .
>  	 * Remove 0x/0X if exists.
>  	 */
> diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
> index 44959779a1..10f965b4f0 100644
> --- a/lib/eal/include/rte_lcore.h
> +++ b/lib/eal/include/rte_lcore.h
> @@ -102,7 +102,6 @@ unsigned int rte_lcore_count(void);
>   * When option -c or -l is given, the index corresponds
>   * to the order in the list.
>   * For example:
> - * -c 0x30, lcore 4 has index 0, and 5 has index 1.
>   * -l 22,18 lcore 22 has index 0, and 18 has index 1.
>   *
>   * @param lcore_id
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
=20

> 2.48.1

