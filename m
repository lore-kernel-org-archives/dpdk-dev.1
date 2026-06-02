Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BE2C5DF71
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:35:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C95B402A9;
	Tue,  2 Jun 2026 09:35:35 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6CB2A40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 09:35:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gV2fC4PBfzHnGf1;
 Tue,  2 Jun 2026 15:34:43 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id B56A34058E;
 Tue,  2 Jun 2026 15:35:32 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 08:35:32 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 2 Jun 2026 08:35:32 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "Ajmera, Megha" <megha.ajmera@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc6QrGN/buU1ph30u0sJvA1Wd0s7YgpxUAgADqPQCAADnO4IAHUa0AgAHSX6A=
Date: Tue, 2 Jun 2026 07:35:32 +0000
Message-ID: <c16b1b4c36184e14bb5dc335a405e557@huawei.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
 <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
 <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
 <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.94]
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



> > For my own curiosity: how user can define his own PROG action?
> > Is it supposed to be programmed and uplodaded to the NIC by some extern=
al
> tool
> > (P4 compiler)?
> > Or does it refer to the set of some predefined functions that given fir=
mware
> > supports?
> > Or ... ?
> > Sorry for probably naive questions, but I found is nearly zero informat=
ion inside
> > DPDK docs about how PROG action supposed to work.
>=20
> PROG in rte_flow is currently a vendor-defined action interface (name +
> arguments), not a generic DPDK programming model by itself.
>=20
> So in practice:
>=20
> 1. DPDK/testpmd does not define or upload user code to NIC on its own.
> 2. testpmd just passes the prog name/argument/payload to the PMD via
> rte_flow.
> 3. What that name/arguments means is NIC/firmware specific.
> 4. Depending on device support, it may map to predefined firmware-exposed
> functions

Ok, so it is predefined by the FW.
Then shouldn't CPFL PG contain a list of supported PROGs and their argument=
s?
Again, some tests/examples for it with testpmd/DTS.
Or that's all will be the next step (patch-series)?  =20
=20
> 5. If the PMD/firmware does not recognize it, flow validate/create will f=
ail.

