Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA96D1039A
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 09:57:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FBDF406BB;
	Wed, 26 Nov 2025 10:57:16 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 27E0B4042F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 10:57:15 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DD632208AE;
 Wed, 26 Nov 2025 10:57:14 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [RFC 1/2] config: add optimal burst size configuration
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Nov 2025 10:57:13 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
In-Reply-To: <20251126082414.91933-1-pbhagavatula@marvell.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC 1/2] config: add optimal burst size configuration
Thread-Index: AdxerhSpT1HJb7w0TCerY3ZyQTjEBgABR+Nw
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 "Jerin Jacob" <jerinj@marvell.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
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

> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>=20
> Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the
> optimal burst size.
>=20
> Set default value to 64 for soc_cn10k and 32 generally.
>=20
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> ---
> This improves performance by 5% on l2fwd, other examples showed
> negligible difference on CN10K.
>

I support the concept of having a recommended mbuf burst size, targeting =
the majority of generic applications.
Making it CPU dependent seems like a good choice.

It should be named differently.
First of all, "optimal" depends on the use case; if targeting low =
latency, shorter bursts are better, so "OPTIMAL" should not be part of =
the name.
Second, I would guess that it only targets mbuf bursts, not also bursts =
of other operations (e.g. hash lookups), so "MBUF" should be part of the =
name.

Suggestion:
/* Recommended burst size for generic applications, striking a balance =
between throughput and latency. */
dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)

<feature creep>
/* Recommended burst size for generic applications targeting low =
latency. */
dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)
</feature creep>

Having these standardized will also allow libraries and drivers to =
optimize for them, e.g. drivers should support bursts sizes all the way =
down to RTE_MBUF_BURST_SIZE_MIN, and can static_assert() that the =
RTE_MBUF_BURST_SIZE_MIN is not lower than supported by the =
driver/hardware.

<more feature creep>
rte_config.h could have "#define RTE_MBUF_BURST_SIZE =
RTE_MBUF_BURST_SIZE_MAX", for the application developer to change to =
RTE_MBUF_BURST_SIZE_MIN for low latency applications.
This will let the libraries and drivers optimize for the specific burst =
size used by the application.
</more feature creep>

<rambling>
Intuitively, I would assume that the optimal burst size essentially =
depends on the CPU's L1D cache size and the application's number of =
non-mbuf cache lines accessed per burst.
Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and each =
burst touches 4 cache lines per packet:
2 cache lines for the mbuf
1 cache line for the packet data
1 cache line per packet for some table lookup/forwarding entry

Then the mbuf burst should be max 512/4 =3D 128.
But local variables also use memory during processing, so using a burst =
of 64 would leave room for that and some more.
</rambling>

>  config/arm/meson.build | 1 +
>  config/meson.build     | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/config/arm/meson.build b/config/arm/meson.build
> index 523b0fc0ed50..fa64c07016b1 100644
> --- a/config/arm/meson.build
> +++ b/config/arm/meson.build
> @@ -481,6 +481,7 @@ soc_cn10k =3D {
>          ['RTE_MAX_LCORE', 24],
>          ['RTE_MAX_NUMA_NODES', 1],
>          ['RTE_MEMPOOL_ALIGN', 128],
> +        ['RTE_OPTIMAL_BURST_SIZE', 64],
>      ],
>      'part_number': '0xd49',
>      'extra_march_features': ['crypto'],
> diff --git a/config/meson.build b/config/meson.build
> index 0cb074ab95b7..95367ae88e2d 100644
> --- a/config/meson.build
> +++ b/config/meson.build
> @@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')
>      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
>  endif
>  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
> +dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)
>=20
>  compile_time_cpuflags =3D []
>  subdir(arch_subdir)
> --
> 2.50.1 (Apple Git-155)

