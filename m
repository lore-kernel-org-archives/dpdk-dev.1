Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A72BCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:51:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 509254028A;
	Wed, 27 May 2026 13:51:14 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 50C9940285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:51:13 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gQSbw2z7dzJ468l;
 Wed, 27 May 2026 19:50:20 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 0E4A040569;
 Wed, 27 May 2026 19:51:12 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 27 May 2026 12:51:11 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Wed, 27 May 2026 12:51:11 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: "Ajmera, Megha" <megha.ajmera@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc6QrGN/buU1ph30u0sJvA1Wd0s7YgpxUAgADqPQCAADnO4A==
Date: Wed, 27 May 2026 11:51:11 +0000
Message-ID: <03ab65f8b69a4018aad7afcc88f337e1@huawei.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260526122218.1c29d917@phoenix.local>
 <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
In-Reply-To: <MW4PR11MB5892D90B2AF860214FB57F4D97082@MW4PR11MB5892.namprd11.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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


> >
> > This looks like a third attempt to parse text into rte_flow.
> > Not sure how this fits in and why it would be useful?
>=20
> Thanks for the feedback.
> I wanted to clarify the intent of this patch. The backend support for the=
 PROG
> action already exists in the PMD. This patch is focused on adding the
> corresponding frontend (testpmd) parser support so that users can configu=
re
> and exercise this functionality via CLI.
> The motivation here is to enable configuration of programmable actions th=
at are
> already supported in the backend but cannot currently be invoked through
> testpmd. With this addition, new actions that are exposed through PROG ca=
n be
> configured using the flow command interface.

For my own curiosity: how user can define his own PROG action?
Is it supposed to be programmed and uplodaded to the NIC by some external t=
ool (P4 compiler)?
Or does it refer to the set of some predefined functions that given firmwar=
e supports?
Or ... ?
Sorry for probably naive questions, but I found is nearly zero information =
inside DPDK docs about
how PROG action supposed to work.
Thanks
Konstantin
