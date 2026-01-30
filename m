Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D64E6BF2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 16:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3147B402AF;
	Fri, 30 Jan 2026 17:31:23 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8E52440274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 17:31:21 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f2hMM28pmzJ4692;
 Sat, 31 Jan 2026 00:30:39 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 6363440086;
 Sat, 31 Jan 2026 00:31:20 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 16:31:19 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 30 Jan 2026 16:31:19 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] net: ethernet address comparison optimizations
Thread-Topic: [PATCH 1/2] net: ethernet address comparison optimizations
Thread-Index: AQHckdXFrMGwuQkmLUit6OJs5Ol1WbVq5QUAgAABFICAAAHXYA==
Date: Fri, 30 Jan 2026 16:31:19 +0000
Message-ID: <377cf187e64c4350b7d66300884bd772@huawei.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <20260130082028.1d3ebeb9@phoenix.local>
 <aXzbM3v7pcRecrtd@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aXzbM3v7pcRecrtd@bricha3-mobl1.ger.corp.intel.com>
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



> >
> > > +__rte_pure
> > >  static inline int rte_is_same_ether_addr(const struct rte_ether_addr=
 *ea1,
> > >  				     const struct rte_ether_addr *ea2)
> > >  {
> > > +#if !defined(RTE_ARCH_STRICT_ALIGN)
> > > +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const
> unaligned_uint32_t *)ea2)[0]) |
> > > +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t *)ea2)[2]))
> =3D=3D 0;
> > > +#else
> > >  	const uint16_t *w1 =3D (const uint16_t *)ea1;
> > >  	const uint16_t *w2 =3D (const uint16_t *)ea2;
> > >
> > >  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) =3D=3D=
 0;
> > > +#endif
> > >  }
> > >
> >
> > FYI in Linux:
> >
> > static inline bool ether_addr_equal(const u8 *addr1, const u8 *addr2)
> > {
> > #if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
> > 	u32 fold =3D ((*(const u32 *)addr1) ^ (*(const u32 *)addr2)) |
> > 		   ((*(const u16 *)(addr1 + 4)) ^ (*(const u16 *)(addr2 + 4)));
> >
> > 	return fold =3D=3D 0;
> > #else
> > 	const u16 *a =3D (const u16 *)addr1;
> > 	const u16 *b =3D (const u16 *)addr2;
> >
> > 	return ((a[0] ^ b[0]) | (a[1] ^ b[1]) | (a[2] ^ b[2])) =3D=3D 0;
> > #endif
> > }
> >
> > In FreeBSD kernel, there is no helper they just use memcmp
>=20
> +1 for just memcmp :-)

Same thoughts :)
