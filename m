Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0B3C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 11:34:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85FBE4270A;
	Wed, 12 Aug 2026 13:33:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 93B0F4068E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 13:33:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7F66722820;
 Wed, 12 Aug 2026 13:33:45 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [PATCH] lib: fix mempool name prefixes
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 13:33:43 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F659D7@smartserver.smartshare.dk>
In-Reply-To: <20260812110258.1128632-1-anurag.mandal@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lib: fix mempool name prefixes
Thread-Index: Ad0qSkUTllPZIxmFT8SaZOZ7LV6QawAAZjng
References: <20260812110258.1128632-1-anurag.mandal@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Anurag Mandal" <anurag.mandal@intel.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	<vladimir.medvedkin@intel.com>
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

> From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> Sent: Wednesday, 12 August 2026 13.03
>=20
> The RIB library named the mempool holding its nodes "MP_<name>".
> That prefix is the one the mempool library itself prepends to
> the backing memzone, so the memzone ended up named
> "MP_MP_<name>" which is improper.
>=20
> The FIB library passed its own name unchanged to the underlying
> RIB and did not add a prefix to the RIB name.
>=20
> This patch makes name each object after its owner.
> The node mempool of a RIB is now "RIB_<name>" or "RIB6_<name>",
> and the RIB owned by a FIB is now "FIB_<name>" or "FIB6_<name>".
>=20
> A mempool name is limited to RTE_MEMPOOL_NAMESIZE, which is much
> shorter than RTE_RIB_NAMESIZE.
> The name was passed down silently and an oversized one surfaced
> as an opaque rte_mempool_create() failure, so check the derived
> name up front and return ENAMETOOLONG instead. B
> ecause the prefixes now stack, a name is limited to 21 characters
> for a RIB, 20 for a RIB6, 17 for a FIB and 15 for a FIB6.
> Hence, shortening  the names used by the graph nodes, the l3fwd
> example and the unit tests accordingly.
>=20
> Bugzilla ID: 1981 1982
> Fixes: 5a5793a5ffa2 ("rib: add RIB library")
> Fixes: f7e861e21c46 ("rib: support IPv6")
> Fixes: 39e927248416 ("fib: add FIB library")
> Fixes: 40d41a8a7b34 ("fib: support IPv6")

This patch reduces how long a FIB/RIB name can be, which is an API =
break.
I don't think it should be backported.

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Some comments inline below.
With those comments addressed,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

[...]

> diff --git a/doc/guides/rel_notes/release_26_11.rst
> b/doc/guides/rel_notes/release_26_11.rst
> index c8cc86295d..043ce8fc2d 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -93,6 +93,11 @@ API Changes
>     Also, make sure to start the actual text at the margin.
>     =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>=20
> +* rib: The node mempool created by ``rte_rib_create()`` and
> ``rte_rib6_create()``
> +  is now named ``RIB_<name>`` and ``RIB6_<name>`` instead of
> ``MP_<name>``.
> +
> +* fib: The RIB created by ``rte_fib_create()`` and
> ``rte_fib6_create()``
> +  is now named ``FIB_<name>`` and ``FIB6_<name>``.

Please mention in the release notes how long the RIB, RIB6, FIB and FIB6 =
names are now allowed to be.

[...]

> diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
> index 184210f380..e032eca91d 100644
> --- a/lib/fib/rte_fib.c
> +++ b/lib/fib/rte_fib.c
> @@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib_tailq)
>  #define FIB_RETURN_IF_TRUE(cond, retval)
>  #endif
>=20
> +/* Prefix used for the memory objects owned by a FIB. */
> +#define FIB_MEM_PREFIX		"FIB_"
> +
>  struct rte_fib {
>  	char			name[RTE_FIB_NAMESIZE];
>  	enum rte_fib_type	type;	/**< Type of FIB struct */
> @@ -173,14 +176,16 @@ rte_fib_create(const char *name, int socket_id,
> struct rte_fib_conf *conf)
>  	rib_conf.ext_sz =3D conf->rib_ext_sz;
>  	rib_conf.max_nodes =3D conf->max_routes * 2;
>=20
> -	rib =3D rte_rib_create(name, socket_id, &rib_conf);
> +	/* Add FIB Prefix to its mempool name */
> +	snprintf(mem_name, sizeof(mem_name), FIB_MEM_PREFIX "%s", name);

Please add check for snprintf() return value, to ensure mem_name has =
0-termination at the end.
Something like (untested):

ret =3D snprintf(mem_name, sizeof(mem_name), FIB_MEM_PREFIX "%s", name);
if (unlikely(ret < 0 || ret >=3D sizeof(mem_name))) {
	rte_errno =3D ENAMETOOLONG;
	return NULL;
}

This check was already missing, so adding it is an improvement.

> +
> +	rib =3D rte_rib_create(mem_name, socket_id, &rib_conf);
>  	if (rib =3D=3D NULL) {
>  		FIB_LOG(ERR,
> -			"Can not allocate RIB %s", name);
> +			"Can not allocate RIB %s", mem_name);
>  		return NULL;
>  	}
>=20
> -	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
>  	fib_list =3D RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
>=20
>  	rte_mcfg_tailq_write_lock();
> diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
> index 770becdb61..dbe88fa25c 100644
> --- a/lib/fib/rte_fib6.c
> +++ b/lib/fib/rte_fib6.c
> @@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib6_tailq)
>  #define FIB6_RETURN_IF_TRUE(cond, retval)
>  #endif
>=20
> +/* Prefix used for the memory objects owned by a FIB6. */
> +#define FIB6_MEM_PREFIX		"FIB6_"
> +
>  struct rte_fib6 {
>  	char			name[RTE_FIB6_NAMESIZE];
>  	enum rte_fib6_type	type;	/**< Type of FIB struct */
> @@ -172,14 +175,16 @@ rte_fib6_create(const char *name, int socket_id,
> struct rte_fib6_conf *conf)
>  	rib_conf.ext_sz =3D conf->rib_ext_sz;
>  	rib_conf.max_nodes =3D conf->max_routes * 2;
>=20
> -	rib =3D rte_rib6_create(name, socket_id, &rib_conf);
> +	/* Add FIB6 Prefix to its mempool name */
> +	snprintf(mem_name, sizeof(mem_name), FIB6_MEM_PREFIX "%s", name);

Also here:
Please add check for snprintf() return value, to ensure mem_name has =
0-termination at the end.


