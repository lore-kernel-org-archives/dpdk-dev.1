Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F354CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:53:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1129A402B6;
	Wed,  3 Jun 2026 08:53:20 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 96E77402AB
 for <dev@dpdk.org>; Wed,  3 Jun 2026 08:53:18 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gVdgw29qnzJ468N;
 Wed,  3 Jun 2026 14:53:16 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id C65954058D;
 Wed,  3 Jun 2026 14:53:17 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jun 2026 07:53:17 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 3 Jun 2026 07:53:17 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "Ajmera, Megha" <megha.ajmera@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc6QrGN/buU1ph30u0sJvA1Wd0s7YgpxUAgADqPQCAADnO4IAHUa0AgAHSX6CAAJPEgIAA8wBw
Date: Wed, 3 Jun 2026 06:53:17 +0000
Message-ID: <a1300904e3844ab382e4d5d6a9786ee4@huawei.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
 <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
 <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
 <MW4PR11MB589273F3A331E94D0876900D97152@MW4PR11MB5892.namprd11.prod.outlook.com>
 <c16b1b4c36184e14bb5dc335a405e557@huawei.com>
 <MW4PR11MB589283F734826ED3A83EBC9B97122@MW4PR11MB5892.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB589283F734826ED3A83EBC9B97122@MW4PR11MB5892.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.148.184]
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



> > Ok, so it is predefined by the FW.
> > Then shouldn't CPFL PG contain a list of supported PROGs and their argu=
ments?
> > Again, some tests/examples for it with testpmd/DTS.
> > Or that's all will be the next step (patch-series)?
> >
> For now, this can be independent patch since it only enable parsing in te=
st-pmd.
> With this change one can use and test PROG actions for PMDs.

Well, right now there is simply no way for the user to test/try this functi=
onality.
Usual requirement for introducing new HW/SW feature for DPDK:
1) provide at least one implementation (exist, cpfl)
2) provide some test cases for it (app/test-pmd,  app/test, ...)
3) document it properly - what prog/args are supported for each HW, etc.
#2 and #3 are missing completely - which means that for DPDK community
that functionality is sort of dead code.
TBH, I think it shouldn't be accepted at all at first place in such incompl=
ete stage.
Konstantin



