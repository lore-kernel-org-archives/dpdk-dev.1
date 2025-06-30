Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF01C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0139540656;
	Mon, 30 Jun 2025 13:17:42 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9D1F240656
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:17:40 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bW3Wz2SDFz6M4yr;
 Mon, 30 Jun 2025 19:16:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id D35461402F1;
 Mon, 30 Jun 2025 19:17:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 13:17:39 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Mon, 30 Jun 2025 13:17:39 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Nicolas Chautru <nicolas.chautru@intel.com>, Anoob Joseph
 <anoobj@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>, "Ashwin Sekhar
 T K" <asekhar@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>,
 "Nithin Dabilpuram" <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@nxp.com>, Gaetan Rivet <grive@u256.net>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Cristian Dumitrescu
 <cristian.dumitrescu@intel.com>, Harry van Haaren
 <harry.van.haaren@intel.com>, Radu Nicolau <radu.nicolau@intel.com>, "Akhil
 Goyal" <gakhil@marvell.com>, Jingjing Wu <jingjing.wu@intel.com>, "Maxime
 Coquelin" <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, "Kai
 Ji" <kai.ji@intel.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>, "Jerin
 Jacob" <jerinj@marvell.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: RE: [PATCH 2/2] doc: use core lists rather than masks in guides
Thread-Topic: [PATCH 2/2] doc: use core lists rather than masks in guides
Thread-Index: AQHb5Qzar9l69u607EOm7D0pKzQgpbQbluHg
Date: Mon, 30 Jun 2025 11:17:39 +0000
Message-ID: <1dd933136d594571bbf8ae619865e519@huawei.com>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
 <20250624133409.550372-3-bruce.richardson@intel.com>
In-Reply-To: <20250624133409.550372-3-bruce.richardson@intel.com>
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


>=20
> For the guides for applications and examples, use the "-l" flag rather
> than the "-c" flag to pass in core lists rather than core masks. While
> for the trivial examples given, core masks work fine and may be easier;
> in real-world cases, with potentially hundreds of cores, core lists are
> a much better fix, so update the docs to reflect this.
>=20
> Similarly replace instances of "-s <service-coremask>" with
> "-S <service-core-list>".
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

> 2.48.1

