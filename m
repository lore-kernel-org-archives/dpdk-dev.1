Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A56DCCFA13
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 01:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 929864026D;
	Tue, 11 Nov 2025 02:48:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8F30F4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 02:48:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762825696; x=1794361696;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qCJfjOCRCOfQt4flIDwCWDjYWja6i3r1CpmwSAlmJN8=;
 b=WrrbSGXbV6osk5HWT7rIe53xpOPdVPCL851m9zTiS893zRQlxUjju9/e
 H8BfXf9V7hf1n5hPtSPQTBeTc5g4OSKSsAWTdwcJvP/CetpDpkjEFZ1mY
 3KBohY5bScFy3WLQYT4eq2c2v5TexHQG/U8wgdQKwmiX2TsWAmbUOn7QF
 MbYMxkzXiScAuROgYsgetgQS2oZl+ty+25n9kNAW0C+nqcN8z2m97MGCL
 BuiPMP1DwtsBf+4SUnd5HYGGmh0QDmd6uYsu00klf2Z6/1e/ZiDZydMEQ
 ovxM+UoJvNyEq8qdTN5fom3RHtUx/Aidsf5netXfhybcZ2RkJS60BPD4W Q==;
X-CSE-ConnectionGUID: /Qv8jD1FRRicm1KCKphqBQ==
X-CSE-MsgGUID: 9uGcJGgGTMKm2trDydM6dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76231724"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; d="scan'208";a="76231724"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 17:48:12 -0800
X-CSE-ConnectionGUID: YCJxhAtOSzOyK6SGFbCKog==
X-CSE-MsgGUID: uhHi0+M/TQCTrKNQwK6Htg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; d="scan'208";a="193082335"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 17:48:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:48:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 17:48:11 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 17:48:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHmMYopgSuB9v8UzfzLybct6HKnVKGOZDO1WccAjnxxsr/Vt4i0pmU/mP5wRpbJpovwvLcuhB8GdRL7qHkT34+c2AJujKzavn4QBiwZUeudv7YqC53/UjVCakmMPIKqfxn8lfoe2G17aQywd8LSDfQoGij5kKv0Jfq5B9DB3IlX/RRoSLIYdDc44syxnmz5oxzxilIDf3RUXhj0op9uELjvR/nDozExZBSs1q6PSk/K67SMB7xD4lqj+8EkeIXfYg68TSS/Pyd2ZQq692sYN3Pzf1xVMt+kNbODMGhwiz1P/GG+7DYCPS1sx1U/srPV8Om5NzVVm5y2FoPkANSIFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCJfjOCRCOfQt4flIDwCWDjYWja6i3r1CpmwSAlmJN8=;
 b=LSghRm6vOsz4AfJeLOaXIPKyCDp+n7PmIXlqyjNumB87vij0fgc3UdJzUWFhY/pTGab3Ja0JQm9FOtPW7fjJlv3GPtF/6SA4ly7F+eFeJpHCn24gLTsMCKPwQKTly46jBcsYHHkN3pD2CBqsngg4SLBlYsixTZ+nVQ9wMGfLuUStughSoZIwgqIfamnepI3RIf9KIEXBdkkiPVMxgQKHj8eai57xMftpICQlSzq8FRp8a144KPezjNKDJiPhbHP1nhmPAj5+jpertmePf607+g02DngFtpPgrSke8S5ecLJ4D2lg4ljjICl6UjzZmqOdjQLt+uL9X/a9GA71VzesuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9040.namprd11.prod.outlook.com (2603:10b6:208:576::9)
 by CH3PR11MB7938.namprd11.prod.outlook.com (2603:10b6:610:12f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:48:07 +0000
Received: from IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f]) by IA3PR11MB9040.namprd11.prod.outlook.com
 ([fe80::fe96:7382:73de:942f%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:48:01 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: "skori@marvell.com" <skori@marvell.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] net/ice: set pkt prepare to dummy instead of NULL
Thread-Topic: [PATCH] net/ice: set pkt prepare to dummy instead of NULL
Thread-Index: AQHcUj03CkIY61fNCU29xWuwTcKRArTstc7g
Date: Tue, 11 Nov 2025 01:48:01 +0000
Message-ID: <IA3PR11MB9040359D3E6719465C88155F9FCFA@IA3PR11MB9040.namprd11.prod.outlook.com>
References: <20251110122457.2575615-1-skori@marvell.com>
In-Reply-To: <20251110122457.2575615-1-skori@marvell.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9040:EE_|CH3PR11MB7938:EE_
x-ms-office365-filtering-correlation-id: 92e132e8-42bf-48ef-9b35-08de20c4591c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xSjA7LHrIAd5ClZSURa0BuW9UXYHTFMBcub+5hPq8L+OAJJ/H9FH4yt5AAbA?=
 =?us-ascii?Q?1x4R8h9qyz5vDhcjp3S1DtpeRxBQyLAE+0FIVg+7s48qm+Za6/VlTN9ecBt/?=
 =?us-ascii?Q?w52i0BvyBTMSsUzpDBWeO8uhO9JckeKYJJQta74NU8Cn1idY90/HTr4SPZMj?=
 =?us-ascii?Q?8xwVdirjOkJCrDhjO2vita1n4xoI1q0xtgKF03T9GDXDBgHGKNK/xV6dImvS?=
 =?us-ascii?Q?n6CgcHStigkAHvkFBjwmyLZmB1e97JY70Q4wFqdP6qsS3YdBY2Oq6iQ/W+GP?=
 =?us-ascii?Q?rS/3HKo0ZSassduBwF/9hFSWZBZynLgFVvjfpBYpqcSY4FpfO/SRCsOM2usP?=
 =?us-ascii?Q?/vDZH59n2oxYN02XoSreTz1Y6II6bbDL2pP92vxZaW/rlLANXOnBAQrM28e6?=
 =?us-ascii?Q?0QX/+tbPg1pU02Z0oTLdrDObnYGbKwEd12qBVC39nQoQ6odma+gStkbbqTLj?=
 =?us-ascii?Q?5uoSrHoYFGnCygM+TvUZdKx/pNti7ETaW0WfAm6EgClK5fpxV59XAvK9HIW+?=
 =?us-ascii?Q?GCJQBWDo7mdsHLtmMtuytsMqWspz40rrwOEFrnAi+RKOsrOmaZokk1ckIJYP?=
 =?us-ascii?Q?regS1s24zRAHNvpEVewUmRF/XhhtTgm9W5THNvAdB3QAApuPoOtQKMM4DKY/?=
 =?us-ascii?Q?ZrzqMfbJCvutSenF+eirOkhXLS5i8x/ChZEEIaD6AX7Lo9P3GAfGhS6qB7W9?=
 =?us-ascii?Q?Vlh9yvHVFs/ybjW5quyoUNFNZrKAneuok9G5aevOx+R2ks+VS20dYgHECBkP?=
 =?us-ascii?Q?30NQuPeuPiVyXUyokZKdxkfekL783ugk0Vy1H96LVT22hqJOLGajwEdM14Up?=
 =?us-ascii?Q?ZH6yIuHvIeQNQXFzBpAY9GXB3aB+pud1icQH0XmNSqVJtdY+s6AqsicwWbJ3?=
 =?us-ascii?Q?l64eij9mqn4/ZV618vHc0sZPnb1Wr8GxI7nxMjPMQUeSoHQYISCTUSpCD7EH?=
 =?us-ascii?Q?EqgU9vA2iR/B+lCzBxwXpQlK0N7nA2lOZMsC/TlIPrYnJIHk4iEEgf6PCoFa?=
 =?us-ascii?Q?KFtbZnRo+w5Pd5S0QQoBFFwGPOm6dOfkZ4gu8bhth0othgfWthL43PdDbh6d?=
 =?us-ascii?Q?MTbiUWuuNuDuTB/yHB37Aafq7bwcMDI4pVwGSGjMGuwWE4FS4RRclqKTWLeK?=
 =?us-ascii?Q?zm3hgX1tfsVwsLnUg+CUerVmcRmsrqpFuN2wu1ak0JZI7HwbtfNIewuXrgp5?=
 =?us-ascii?Q?U6JEHK51as1dcIRmmLxW7TmohfvenBEuFEli9+ELfh3hquqKt8/ErDRDhYFB?=
 =?us-ascii?Q?48tsxqiEj54ucEp0BGq0yK2YegP9Sw11Na+btBgYey8KeshsJKBbgBwMzx1L?=
 =?us-ascii?Q?wC4xmLeK6mVaRxEePN67S6zAX0Al7neN8lQLlMV4KCEnH8OsciTlS3S0yf3C?=
 =?us-ascii?Q?m+oqqdZDWy3bIg+eweWtxQlZmSt5i7tVYhlJ+x3uLzI7yfEL5lwjrop/Adou?=
 =?us-ascii?Q?QSwxgVkj2pzCq/FX5WhgPZalO3WZAhrvfUkQ71fz3WlAfYvWOWvNNTs271J0?=
 =?us-ascii?Q?wb/Wq8RKh9sSoTcC7BG+jpApY91EpBmfDOkY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q5mOT9c3m5LU1mkhNzMqVK4VPXnR/va6oGYqg/Ruz8fQgQMvwYs+H2T8RQ8n?=
 =?us-ascii?Q?Mr1RhxMsA1Bdn6TAoveIQ8idHzFbi/f77EJAuek3sbQoy/ejih6Z3FrDwtNQ?=
 =?us-ascii?Q?pgtJW/Oh2XZryDGcBTWjrc2Nbp6tNlq855CNMWQ1zcVxLeY97IktP5Qwn8lJ?=
 =?us-ascii?Q?ew9HG8+4JsXUq72i12m7tLZpgaUyhuQWDZpPyNM3HcAAs4G6E9rPsOP1eowM?=
 =?us-ascii?Q?74YSN4ulgt9N85Mx3qTXV4xHou7OzQfnKPOYmdMZd3F0cNRGgK/2ItTS+WRO?=
 =?us-ascii?Q?uqUamjP9AQ893A+sKkPM0l6cWFuHY/+/MdBk4lFDF6RebgK2JMrJPtj5b63V?=
 =?us-ascii?Q?v6LUXPUnCqiT7q+TAVZS6mLsyQbZiM6THDJR4pbfe1lQcqQlN1lRLDeTUI+m?=
 =?us-ascii?Q?EhDyPOTlGpfxq8Sm/90XDp/XjHIryG58cPUDbkuPiRlKSJm4uO23bdMRpdX3?=
 =?us-ascii?Q?QMZtP4xeyxan9L37vKhwny5kDv3nj3diVLi5xrUr+yiuO9Xh+dLoyco0mtD1?=
 =?us-ascii?Q?Pnafd6ZeucCCkewnnSmkNJpJZfl7l6qXh73VC9ANjWMwA5G7rw1AFaQVbU0B?=
 =?us-ascii?Q?q07r9/xYbkIGT+my+1R73di3MXfF4qAhHJCnQkQxA8T0aE9QyrDU9YYBp2Zn?=
 =?us-ascii?Q?zTnr9N5K+PefHvRXg8lc6sH/u6qjmY+Qtxi+0sa+Ibo5hdi9xfxBStdYAQxZ?=
 =?us-ascii?Q?S0ARxNrR5+uGBU0DMm297v8mKVXcH2XuIUCDaTVzSQAk11ghMEHEbmz0jAx+?=
 =?us-ascii?Q?eRvh/FKX5l/1YYGheUzgEgpqavqGRvRD+bQ2hKLPmb4E9b/CW1BQjUFssAJb?=
 =?us-ascii?Q?miRJyV4fkJQR0FSeGW509ap1KfHCy9Nuhyl8mUarldBl1V62Yd7qRV07TRH/?=
 =?us-ascii?Q?nwzBMVWLEAVxOrGyvkqnWUV+3CUpTiv30SRvpvamon6HueeQlvGUKfpAaHxy?=
 =?us-ascii?Q?1lPLWpV8Iar+Y1CG51AsZHAET1Gyhb7kwT+sGCGTGYgrOePJM2YVsMD890D+?=
 =?us-ascii?Q?FVYkD1bFNJFgp7IX7KAyjOznxWmLHLvcSA0+gFsi6pGKSzhthANukKduQn1s?=
 =?us-ascii?Q?gO/g6uVYhFPAsSvYCbL5hPro7Wp2BP3mLnsOse/20gioaYcxJQTjLrxTZwOp?=
 =?us-ascii?Q?xNV1dz61UGj8PnImSRYwjxKMuFSdkexKE4+uj7BI9VTNPhf865e5HQ28P5In?=
 =?us-ascii?Q?2qJHh/fFx0lo5p7DKaZbIVh1Z8iUvvurNNid8KTzhHCGWj9TeAW+TTyX3Wqy?=
 =?us-ascii?Q?SQxf5Vv851cLq3lWiNwbWx+i9a9u/mAgSrDbUppXAmG/E7wCF8t6dk4La5tF?=
 =?us-ascii?Q?wW9NejrLL/tydUK3mk63yWvZen1mL7tNFOU2IOEy4GmZBzUM82UBfh6yzA5S?=
 =?us-ascii?Q?36Pr5dDt54Vz2R3DKrY21cSDs8si8+ormFt0h+Id3LfYri012IOqxBF7bUhc?=
 =?us-ascii?Q?sD/uoP2b3LcWv+MJV2yoIY3GpLAY4WM3YhJmDLbCuMTxGmvMB2eT4qPvm0Gu?=
 =?us-ascii?Q?BjmP4n3qnhr1PmvqDxxipbog3IqfGg1OEMj33mo3oWW5gu64l9iY6E6ulgP+?=
 =?us-ascii?Q?DY0K0XyoG2+4aIpv16QDJ7oYs/xD2G09JwNQyQM3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e132e8-42bf-48ef-9b35-08de20c4591c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:48:01.3758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7n25q9605KWGnVtDJsG/r+Gd050MF6vLEyiY9H5bGYl+W2WtkiqiQQ5Lk4ZAxj3iU0Z+VHuwVLlscSL0y3sx0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7938
X-OriginatorOrg: intel.com
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

> -----Original Message-----
> From: skori@marvell.com <skori@marvell.com>
> Sent: Monday, November 10, 2025 8:25 PM
> To: Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Cc: dev@dpdk.org; Sunil Kumar Kori <skori@marvell.com>
> Subject: [PATCH] net/ice: set pkt prepare to dummy instead of NULL
>=20
> From: Sunil Kumar Kori <skori@marvell.com>
>=20
> As per recent change by the following commit:
>=20
> commit 066f3d9cc21c ("ethdev: remove callback checks from fast path")
>=20
> framework unconditionally invokes dev->tx_pkt_prepare.
> Due to this, ICE driver gets crashed as tx_pkt_prepare was set to NULL du=
ring
> initialization.
>=20
> Ensure dev->tx_pkt_prepare is not NULL when vector or simple TX paths are
> selected, by assigning rte_eth_tx_pkt_prepare_dummy.
>=20
> This aligns with expectations with above mentioned commit.
>=20
> Bugzilla ID: 1795
>=20
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
Tested-by: Xu, HailinX <hailinx.xu@intel.com>
