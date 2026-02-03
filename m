Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5290FE8306E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 09:38:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0173402F1;
	Tue,  3 Feb 2026 10:38:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CE797402A2
 for <dev@dpdk.org>; Tue,  3 Feb 2026 10:38:36 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B624A206EC;
 Tue,  3 Feb 2026 10:38:36 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [EXTERNAL] Re: [RFC 1/2] config: add optimal burst size
 configuration
Date: Tue, 3 Feb 2026 10:38:33 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656E7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <PH0PR18MB40867E7E8143DC087E43F42FDE9AA@PH0PR18MB4086.namprd18.prod.outlook.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [EXTERNAL] Re: [RFC 1/2] config: add optimal burst size
 configuration
Thread-Index: AQHcXq4VsKPYWcJQ0Eu6wbp/mlvALLUEuLeAgAJczYCAaH/+4YABhztw
References: <20251126082414.91933-1-pbhagavatula@marvell.com><98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
 <20251127140153.202a38dd@phoenix.local>
 <PH0PR18MB40867E7E8143DC087E43F42FDE9AA@PH0PR18MB4086.namprd18.prod.outlook.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Pavan Nikhilesh Bhagavatula" <pbhagavatula@marvell.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>
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

> >> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >> >
> >> > Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the
> >> > optimal burst size.
> >> >
> >> > Set default value to 64 for soc_cn10k and 32 generally.
> >> >
> >> > Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >> > ---
> >> > This improves performance by 5% on l2fwd, other examples showed
> >> > negligible difference on CN10K.
> >> >
> >>
> >> I support the concept of having a recommended mbuf burst size,
> targeting the majority of generic applications.
> >> Making it CPU dependent seems like a good choice.
> >>
> >> It should be named differently.
> >> First of all, "optimal" depends on the use case; if targeting low
> latency, shorter bursts are better, so "OPTIMAL" should not be part of
> the name.
> >> Second, I would guess that it only targets mbuf bursts, not also
> bursts of other operations (e.g. hash lookups), so "MBUF" should be
> part of the name.
> >>
> >> Suggestion:
> >> /* Recommended burst size for generic applications, striking a
> balance between throughput and latency. */
> >> dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)
> >>
> >> <feature creep>
> >> /* Recommended burst size for generic applications targeting low
> latency. */
> >> dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)
> >> </feature creep>
> >>
> >> Having these standardized will also allow libraries and drivers to
> optimize for them, e.g. drivers should support bursts sizes all the =
way
> down to RTE_MBUF_BURST_SIZE_MIN, and can static_assert() that the
> RTE_MBUF_BURST_SIZE_MIN is not lower than supported by the
> driver/hardware.
> >>
> >> <more feature creep>
> >> rte_config.h could have "#define RTE_MBUF_BURST_SIZE
> RTE_MBUF_BURST_SIZE_MAX", for the application developer to change to
> RTE_MBUF_BURST_SIZE_MIN for low latency applications.
> >> This will let the libraries and drivers optimize for the specific
> burst size used by the application.
> >> </more feature creep>
> >>
> >> <rambling>
> >> Intuitively, I would assume that the optimal burst size essentially
> depends on the CPU's L1D cache size and the application's number of
> non-mbuf cache lines accessed per burst.
> >> Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and =
each
> burst touches 4 cache lines per packet:
> >> 2 cache lines for the mbuf
> >> 1 cache line for the packet data
> >> 1 cache line per packet for some table lookup/forwarding entry
> >>
> >> Then the mbuf burst should be max 512/4 =3D 128.
> >> But local variables also use memory during processing, so using a
> burst of 64 would leave room for that and some more.
> >> </rambling>
> >>
> >> >  config/arm/meson.build | 1 +
> >> >  config/meson.build     | 1 +
> >> >  2 files changed, 2 insertions(+)
> >> >
> >> > diff --git a/config/arm/meson.build b/config/arm/meson.build
> >> > index 523b0fc0ed50..fa64c07016b1 100644
> >> > --- a/config/arm/meson.build
> >> > +++ b/config/arm/meson.build
> >> > @@ -481,6 +481,7 @@ soc_cn10k =3D {
> >> >          ['RTE_MAX_LCORE', 24],
> >> >          ['RTE_MAX_NUMA_NODES', 1],
> >> >          ['RTE_MEMPOOL_ALIGN', 128],
> >> > +        ['RTE_OPTIMAL_BURST_SIZE', 64],
> >> >      ],
> >> >      'part_number': '0xd49',
> >> >      'extra_march_features': ['crypto'],
> >> > diff --git a/config/meson.build b/config/meson.build
> >> > index 0cb074ab95b7..95367ae88e2d 100644
> >> > --- a/config/meson.build
> >> > +++ b/config/meson.build
> >> > @@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')
> >> >      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
> >> >  endif
> >> >  dpdk_conf.set10('RTE_IOVA_IN_MBUF',
> get_option('enable_iova_as_pa'))
> >> > +dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)
> >> >
> >> >  compile_time_cpuflags =3D []
> >> >  subdir(arch_subdir)
> >> > --
> >> > 2.50.1 (Apple Git-155)
> >
> >I understand the motivation, and it make sense for a pure embedded
> system.
> >But then again on an embedded system the application can just set its
> burst size;
> >this config option only impacts performance of testpmd and examples.
> And the
> >performance of testpmd is mostly irrelevant what matters is the real
> application.
> >
>=20
> True, but generally customer engagements start with benchmarking
> testpmd/l3fwd etc.
> berfore moving to custom apps.
> So, having better performance numbers helps.

Good example from real life. :-)

>=20
> >Making it a DPDK config option is a problem for DPDK build in =
distros.
> >The optimal burst size would be driver dependent etc.
> >
>=20
> Since we are not modifying the current default burst size (32) it
> shouldn't be a problem and
> can even benifit SoCs.
>=20
> >Perhaps better off in the existing rx / tx descriptor hints.
> >Most of those device configs really need to be relooked at
> >since they were inherited from how old Intel drivers worked.

Yes, descriptor hints are very incomplete. E.g. they should also =
consider the CPU.

Currently, DPDK applications use a hardcoded default of 32, regardless =
of everything else.
That was probably good for some of the hardware (CPUs and NICs) =
originally used for DPDK.

I think adapting to other environments make sense.

I agree that finding the optimal burst size is a combination of multiple =
parameters, and highly dependent on the application too.
The current alternative, sticking with 32, is clearly not the best =
option.
So I agree with the idea of trying to improve that.

If we make it a common build option, drivers and libs can optimize for =
these values, instead of randomly picking some number to use internally.
E.g. rte_pktmbuf_free_bulk() [1] uses an array of 64 mbufs. It might as =
well have been 32.

Using a common build option also makes it possible to align (regarding =
burst size) the application with the drivers and libs, when built from =
scratch.
And it will not harm the distros, which currently use (more or less =
randomly selected) hardcoded burst sizes.

It may not be the optimal solution, but IMO better than what we have =
today.

[1]: =
https://elixir.bootlin.com/dpdk/v25.11/source/lib/mbuf/rte_mbuf.c#L556

