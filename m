Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E1FC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 14:20:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 972C740A6C;
	Mon,  7 Apr 2025 16:20:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7F8A640156
 for <dev@dpdk.org>; Mon,  7 Apr 2025 16:20:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 04B2720ADB;
 Mon,  7 Apr 2025 16:20:02 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] doc: provide examples of using lcores EAL parameter
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 7 Apr 2025 16:19:58 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FBA1@smartserver.smartshare.dk>
In-Reply-To: <20250407132451.1101691-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc: provide examples of using lcores EAL parameter
Thread-Index: AdunwHz8RdGk7AIaQkeancexjjFbowABc1+g
References: <20250407132451.1101691-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Monday, 7 April 2025 15.25
>=20
> The "--lcores" EAL parameter has a very powerful syntax that can be
> used
> to provide precise control over lcore mappings. The docs however, only
> provided a minimal description of what it can do. Augment the docs by
> providing some examples of use of the option, and what the resulting
> core mappings would be.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/linux_gsg/eal_args.include.rst | 25 =
+++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst
> b/doc/guides/linux_gsg/eal_args.include.rst
> index 9cfbf7de84..081f09d353 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -29,6 +29,31 @@ Lcore-related options
>      The grouping ``()`` can be omitted for single element group.
>      The ``@`` can be omitted if cpus and lcores have the same value.
>=20
> +    Examples:
> +
> +    ``--lcores=3D1-3``: Run threads on physical CPUs 1, 2 and 3,
> +    with each thread having the same lcore id as the physical CPU id.
> +
> +    ``--lcores=3D1@(1,2)``: Run a single thread with lcore id 1,
> +    but with that thread bound to both physical CPUs 1 and 2,
> +    so it can run on either, as determined by the operating system.
> +
> +    ``--lcores=3D'1@31,2@32,3@33'``: Run threads having internal =
lcore
> ids of 1, 2 and 3,
> +    but with the threads being bound to physical CPUs 31, 32 and 33.

Maybe add "respectively": "[...] bound to respectively physical CPUs =
[...]".

> +
> +    ``--lcores=3D'(1-3)@(31-33)'``: Run three threads with lcore ids =
1,
> 2 and 3.
> +    Unlike the previous example above,
> +    each of these threads is not bound to one specific lcore,

lcore -> physical CPU

> +    but rather, all three threads are instead bound to the three
> physical cores 31, 32 and 33.

cores -> CPUs

> +
> +    ``--lcores=3D(1-3)@20``: Run three threads, with lcore ids 1, 2 =
and
> 3,
> +    where all three threads are bound to (can only run on) physical
> CPU 20.
> +
> +.. Note::
> +    Binding multiple DPDK lcores can cause problems with poor
> performance or deadlock when using

"[...] multiple DPDK lcores can cause problems [...]" ->
"[...] multiple DPDK lcores to the same physical CPU can cause problems =
[...]"

> +    DPDK rings or memory pools or spinlocks.
> +    Such a configuration should only be used with care.
> +
>  .. Note::
>      At a given instance only one core option ``--lcores``, ``-l`` or
> ``-c`` can
>      be used.
> --
> 2.45.2

With above changes,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

