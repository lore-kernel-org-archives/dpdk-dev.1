Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F764C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67BB24064E;
	Tue,  1 Sep 2026 19:09:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5EB304042E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 19:09:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=r3DNkQp2smimg1HaGIO8oN5vIgjX5SEOM1MilWd0VhQ=;
 b=gD0lyrcof0zEohSgUuX5z24piDp6fu4KoBmaZTryPjnaF94R/5rUK4QBHIZ5uimvVgSAeAmDA
 9RovaoW4OOMfjweRUGhc4coQ66sA00Hxy+KWvK4/i8/PmGehvTVa8WTEMJz8iwAT3gaicehwPHo
 +Ps39q8RxWecI5gJwfUK0fw=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hZC4F5BFtzHnH3x;
 Wed,  2 Sep 2026 01:08:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id C547940584;
 Wed,  2 Sep 2026 01:09:15 +0800 (CST)
Received: from dubpemt500001.china.huawei.com (7.214.144.77) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 18:09:15 +0100
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpemt500001.china.huawei.com (7.214.144.77) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Sep 2026 18:09:15 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.045; 
 Tue, 1 Sep 2026 18:09:14 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, "Randy Tice
 (rtice)" <rtice@cisco.com>, "dev@dpdk.org" <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Topic: [RFC] mbuf: add configurable base private size for pktmbuf pools
Thread-Index: AQHdOXCgdP+ENN3UFk+QdyL24xrKUra5fBPQgAB580A=
Date: Tue, 1 Sep 2026 17:09:14 +0000
Message-ID: <f534c0fc423f4b7fa9632b89f9b76c79@huawei.com>
References: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A29@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A29@smartserver.smartshare.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="iso-8859-1"
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


> > Hi,
> > I would like to get feedback on a proposed mbuf change before sending
> patches.
> > Some deployments need a guaranteed private-data reservation in every pa=
cket
> mbuf, across multiple mbuf pools and across different consumers of the mb=
uf
> APIs.
> > Today, each pktmbuf pool can request a private size when the pool is cr=
eated.
> That works when the application owns all pool creation policy directly. H=
owever,
> not all relevant mbuf pools are necessarily created by application code. =
Some
> pools may be created by libraries, drivers, or other components outside d=
irect
> application control.
> > One example already in DPDK is vhost crypto, which creates its own mbuf=
 pool
> and supplies a private size for struct vhost_crypto_data_req. There are a=
lso
> driver-created pktmbuf-style pools, such as cnxk inline meta pools and TA=
P GSO
> context pools. These are examples of pool-creation paths where the applic=
ation
> may not directly control the private-size value used at creation time.
> > A PMD-specific devarg could solve one instance of this problem, such as=
 a single
> driver-created pool, but that seems too narrow if the requirement is not
> inherently PMD-specific. A deployment with multiple drivers, libraries, o=
r other
> pool-creation paths outside application control could need the same base
> private-size adjustment. In that case, configuring the same value indepen=
dently
> through component-specific options would be fragile and easy to get wrong=
.
> > The proposed generic model is to add a configurable base private size f=
or
> pktmbuf pools. The effective private size would be:
> > align(pool_requested_priv_size + application_base_priv_size,
> >       RTE_MBUF_PRIV_ALIGN)
> > The tentative EAL option name is:
> > --mbuf-base-priv-size=3D<size>
> > The intent is:
> > * default behavior remains unchanged when the option is not used;
> > * the configured base size is added to the private size requested by ea=
ch
> pktmbuf pool;
> > * the final effective private size remains aligned to RTE_MBUF_PRIV_ALI=
GN;
> > * pool-specific private-data requests still work as they do today;
> > * DPDK centralizes the policy so pools created outside application cont=
rol can
> reserve the same base private-data space as application-created pools.
> > This is not intended to define ownership or layout of the private area.=
 It only
> ensures that a deployment can reserve a common base amount of private dat=
a
> consistently. Applications, drivers, libraries, or components would still=
 be
> responsible for their own interpretation of the reserved private area.
> > Questions for the list:
> > 1. Is a deployment-wide pktmbuf base private-size reservation something=
 DPDK
> would consider acceptable?
> > 2. Is --mbuf-base-priv-size=3D<size> a reasonable name, or would anothe=
r name
> better describe the intent?
> > 3. Should DPDK expose the effective-size calculation as a helper so poo=
l-
> creation paths outside application control can apply the same rule?
> > 4. Would maintainers prefer consumer updates in the same series as exam=
ple
> users, or as follow-up patches after the generic mbuf/EAL change is accep=
ted?
> > 5. Would maintainers prefer this to remain component-specific, even if =
more
> than one driver, library, or pool-creation path may need to apply the sam=
e base
> reservation?
> > The main goal is to avoid downstream mbuf layout changes and avoid
> component-specific configuration drift, while still allowing deployments =
to
> reserve a consistent private-data area across all packet mbuf pools, incl=
uding
> pools created outside direct application control.
> > Thanks,
> > Randy
>=20
> DPDK already has Dynamic Mbuf Fields for run-time management of private d=
ata
> across all mbuf pools.
> DPDK also has the Private Data Area (priv_size), but that is individual t=
o each
> mbuf pool, which does not fit your use case.
>=20
> Dynamic Mbuf Fields is the perfect fit for the use case you are describin=
g.
>=20
> Currently, it only manages a few small memory areas inside the rte_mbuf
> structure itself, the dynfield1 array and the dynfield2 field.
> But it could easily manage one more memory area associated with the rte_m=
buf
> structure.
>=20
> If we want this to be build-time configurable, it should be relatively si=
mple to
> add:
>=20
> In config/rte_common.h:
> +#define RTE_MBUF_DYN_EXTRA_SIZE 128
>=20
> In lib/mbuf/rte_mbuf_core.h:
> 	/** Size of the application private data. In case of an indirect
> 	 * mbuf, it stores the direct mbuf private data size.
> 	 */
> 	uint16_t priv_size;
>=20
> 	/** Timesync flags for use with IEEE1588. */
> 	uint16_t timesync;
>=20
> 	uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
> +
> +#if RTE_MBUF_DYN_EXTRA_SIZE
> +	/** Extra dynamic fields. */
> +	uint32_t dynfield3[RTE_MBUF_DYN_EXTRA_SIZE / sizeof(uint32_t)];
> +#endif
> };

Please don't.
Lets keep core mbuf size with constant size and layout.=20

> In lib/mbuf/rte_mbuf_dyn.h:
> +static_assert(RTE_MBUF_DYN_EXTRA_SIZE % RTE_CACHE_LINE_SIZE =3D=3D 0,
> +	"RTE_MBUF_DYN_EXTRA_SIZE must be multiple of cache line size.");
>=20
> And some associated additions in lib/mbuf/rte_mbuf_dyn.c.
>=20
> <feature creep>
>=20
> There may also be considerations about what happens to the extra data whe=
n:
> - Copying an mbuf.
> - Attaching an mbuf to another mbuf.
> - Detaching an mbuf from another mbuf.
> - Cloning an mbuf.
>=20
> (The considerations apply to both the packet mbuf itself, and for the non=
-first
> segments of a segmented packet mbuf.)
>=20
> The developer of the Dynamic Mbuf Fields library was foreseeable enough t=
o add
> a "flags" parameter for dynamic mbuf field creation.
> This could be used to specify what happens to each registered dynamic fie=
ld in
> the events enumerated above.
>=20
> </feature creep>
>=20
> IMO, the extended size of Dynamic Mbuf Fields should be build-time
> configurable.
>=20
> If the community wants the extended size of Dynamic Mbuf Fields run-time
> configurable, the size should be an EAL startup parameter.
> It could be named: --mbuf-dyn-extra-size=3D<size>.
> The major difference in implementation is that the space for the extra dy=
nfields
> must be dynamically allocated with the mbufs at mbuf pool creation.
> Notice that the memory for the extra dynfields should be positioned betwe=
en the
> mbuf structure and the private data area, so their offsets remain the sam=
e, also
> for two mbuf pools having different Private Data Area sizes.
>=20
> -Morten

