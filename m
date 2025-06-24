Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB9C77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:49:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B04FC40B91;
	Tue, 24 Jun 2025 15:49:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id BD09A4026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750772955; x=1782308955;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=3nQVlTzEe126c1jO7kiOpw5xxVRU5uDcPp6qqQzMaGc=;
 b=SP7bt0axsQhtbwjFe2585DmE6xY4QdNJwqzTwni8DUNAN1uiLnSIV7Fp
 6CPVi8NJTe2rInIawBWjURJEo4SKw7QL8ohRYt/LPrBSUsBz1l7TMBgp1
 gBWXgs9p5H36yo4D5GdRSTfe3V++wAfdIBVIRksnaYIpJXsdR+cJkAtQf
 P0ob0cTA9itD7OR6uE5me/TOQaXqLEW22VGxFZSVp2bd0f67o2j73AoKY
 0u7CSugnM508YrPqU9QMpGdB6i7g6L1FG6tVepn82S5zTcXtnPjeJ8eES
 lgyXkrNKzz6P1s3AAe9aHIwDUGx8l7+TW2gJFvsyud75gJlT1Zpa8IwJd Q==;
X-CSE-ConnectionGUID: PO3DwXOATeSSMnQaJfPhoQ==
X-CSE-MsgGUID: JrLYPZxlRsKFKoZo1KQqTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53150854"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208,217";a="53150854"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:49:13 -0700
X-CSE-ConnectionGUID: Z1n8u+MdRqG5iCX/CUFgQg==
X-CSE-MsgGUID: fBXUA0V7TaGpnPgJlOcVkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
 d="scan'208,217";a="156206066"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:49:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 06:49:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 06:49:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 06:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITpco+JItzjr+EbPQqcUdAxM4R5Y35Sobxf/9F3Xs+n7LFII04Q1s0cnPZcJz2lC6/vqJuva7faJYs3CXMDQYP8ei0O313+1va7Olyhab8yvIkM3zNpAGxOOGGYTaOz4LqCXUGoOYxGk114gHJ7e2Nn25vlYmrmU8Ez4xqKW1ckt/yQFTcJulzkczwQFGY1srz5ScA/bl9+N4E7u4CFtZXU+9gKupoE9FnKwzgl6m92VwZ/KfHsJu1kjE73EXM092wOOnAtlTUeWhTJdPK2q+XC+sDsXuJabDUeuYoFWLiWT1XHtG/Hub/wYBU7bsvJNhp0J+i6X/Y6MILtCJ1J8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFC8wz/gUAAV7f9Id5GN/zDf+KExYo13Qgy4IpUE/lI=;
 b=KXnukrNeIhpq1lr2rQpEKyxmjTTx9b3wKappfiHs7UF1tUrczNeY+36r2Q79GhC89AIKQ+bCCFaRhA6OGUi3KyxJXOtr56NBZmACzPoTx2Sjy7xwBCely+itrI4pABQNEuHrYGJsHGDa4zpXh7Ip8Zap+oaFCI9WxC2z/XK05XrCC5cfZfsZAzyNqtGblaHeyq9iPKl6W+yKV1CkRI+MAauKFUhnJKfp9Eqvz7RVVZWCN7cDmOI5ERlxFCq/bLN1k5anwrrGl86ylnH7B6w3T2ZZ684oh3/3BMPVHdTQQ+9LsTLE05y7w/28a8p9tqm8b3rLR3OBizfXTRohA0IMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by CO1PR11MB4963.namprd11.prod.outlook.com
 (2603:10b6:303:91::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 24 Jun
 2025 13:48:23 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%7]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:48:23 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-06-24
Thread-Topic: DPDK Release Status Meeting 2025-06-24
Thread-Index: AdvlDpXxS0EiIuRGRjCbHgIiNI6L/w==
Date: Tue, 24 Jun 2025 13:48:23 +0000
Message-ID: <PH3PPF37F43E35DA7F040FB388BB64FBC9BFC78A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|CO1PR11MB4963:EE_
x-ms-office365-filtering-correlation-id: b67c4506-e60b-411c-f6ed-08ddb325c9b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S3YAhnfVoxmzizaloZMsXNZ6xJle3MymUBt08R4Xk++LYyG0ds6DXvQCvKpd?=
 =?us-ascii?Q?5FYd6X3kOVTYnq/oRUbo0966WGilrjNJNgxjCYhqVQg4Ma+yQXkuvo145XW9?=
 =?us-ascii?Q?RDqh+nBMx6f3S328ksxZU4afra7jG2lrgnxVUeDaFdnpb+ebvh+b3YVorx4l?=
 =?us-ascii?Q?QcTqrpUV0L/eO2rtfsjHwZmzjboE0R2Tp0QM16Frbie40XWb1tbXhx4ALm2g?=
 =?us-ascii?Q?773ab9xZ7epUfKAEgb99aoM+0TexI5dfx5aXDGMbE/vLM9xOnKeCOTTcnM3n?=
 =?us-ascii?Q?G6f6X/TtaBTY9zdSVXKbRhwdw1FAeMYiHnCTvM3VafAH6afqAFLId7m3U7aW?=
 =?us-ascii?Q?fsmifw7xq2lDlrBMS+QTHbyc+SfstC6Bhr6c1tr22QvE24DctU+Bbb6HNgDI?=
 =?us-ascii?Q?HgvdxDIfFYPEX6YRjzAEkAtlzOl9hvzBPAxK9h8yD7vdXYqTpvx9a7eMGvsN?=
 =?us-ascii?Q?aB7I7uQ0fKn2RUVMQ9PEdPjFGXLRs3PzAmyP3ppQPRkZcANt+n0JgwO5XLdH?=
 =?us-ascii?Q?+h6PL+FkLWwOdGv0I6RCfgSpS+f1K9P+1YtmXaI8t7naatdxNKkMyKF/dBWJ?=
 =?us-ascii?Q?wroTC4RXHS0z2wO/uQnW/xtgwrbcSoWJg8ZMPEfj0LNXGe+70zSyOC6vUIl7?=
 =?us-ascii?Q?CJsbSNuO0Q+FVzumaIaH/EPgQi/n9BzU0WOatEnbY0KBEUm6Ov+R8cOFOoh9?=
 =?us-ascii?Q?HVsuN9Bv3o+CTpSWzdxn6iqBWO4+cbIsvUbEe9e70lSeytxMYexX0J74lsAr?=
 =?us-ascii?Q?pW6o3h0alDhl+xmOG8BHCBKGXJzQBCJollmL9Na0ScKra+NoimjNSfSkKyiy?=
 =?us-ascii?Q?4/Amr49st+PqhhLfvr+2L6EAGMum8iv9lqbVeCLRSQCIZXmlYMI7J9oM3q00?=
 =?us-ascii?Q?Q6Z9oAiGNq4HZphFVvgXZzxUKGX1Oz3E2D1upY0Ub5tPSUsPfSHd0ieU3SiP?=
 =?us-ascii?Q?rvo7D1MXfSpKItCxN5SbBPKGAQNOqeFWtGdbz3F4RULnwXR5NqKwCbCEbv7W?=
 =?us-ascii?Q?RVzxNw4ZPjqjZQzTKLI7SYjLDS2mHRMoAmfQHZbPddHNt4ZXjhKSU1e4lErr?=
 =?us-ascii?Q?e6W/3jhso1N/zkBL7dfr5pLG1olTzHeAJFLxxeRJECC+K6Hzz793fIxPkoZS?=
 =?us-ascii?Q?q2E5njsLRSkfl74/dyIj+BrBnMiWPRRvcdS5lT0sgcyvLAW7nyFaBMYIP27Z?=
 =?us-ascii?Q?Ez/yHzancRTC21V/+WmPdcM93/Jyt1tfHWvEA+9LeEbDRfQ5J8hSqf8LUwYN?=
 =?us-ascii?Q?0W1zwov+mWSd7x5+U6lpZPKQd8CTWbH0H/qI05sryhHRa1tZjRNIrA9N4Jxh?=
 =?us-ascii?Q?p7oevJDV4JyLVRbQzTzqtjDlN31tFp5eOH1MidmqFava3oZfNlBnIwBT5LlB?=
 =?us-ascii?Q?sjlrIWh+iO0XzTjM6JT7QDawrZJPKsLdjt4Df/WsS8L3R+9ppUAzvnKzLCdK?=
 =?us-ascii?Q?xHtVnZaEAEUBBt9MNI23PczacGZF/g3F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VQg9aX68M2ryjmZCi5L3cwPCNHLdog/XWM5/WrYsq+N5PfeDBZSK7MaP60HH?=
 =?us-ascii?Q?nar3ul94TNchzfQQjcrgYblEM5C1UoR4IeAAibGXrwg8bK+EuCYetvApXQad?=
 =?us-ascii?Q?278qWGn0g9k825daXodYWmx7h8biQqiU80vA8S3pkieRxhhlkbujSv1ersaY?=
 =?us-ascii?Q?73HBXFBRvULwy1CHnouH49TQI+/uy9+hoTo0gnKzrbJOLMGd3SD//6unBh6e?=
 =?us-ascii?Q?OtSCY5DGriUcT2RjC4A03Z/A/VyD++F47mniKXXU0e3XT0l1UL40abryoPu5?=
 =?us-ascii?Q?YEsjNZyP2sAx3rtDU9JyzXKUhIV/F84H9xz+JfyfaLA+SLWd5VnbCe6GxMk5?=
 =?us-ascii?Q?vZAF3o54PVhcluM5l9w61en+0ecVol1gXutOUOBnqT4uZoxXKCyGlt3/CTOG?=
 =?us-ascii?Q?lJ+RKzQ69xd0fzRqeYtu1GQwvQOhwS2ff2TYiZdnjKVbITKUz7wls9ssiKS4?=
 =?us-ascii?Q?ufVoS+nUjfnrOdkKI/JrLJhjFgGJ019I6q4jlObwONmOlugB46mDTm0HgJDP?=
 =?us-ascii?Q?AxUQnYgUrp098bDNKwSYS3L+o5r1q8RtA5qPz2nLykqB2+fNZhad4/bGkiTi?=
 =?us-ascii?Q?85/4XRj3rvHCgDSAaIsiNZYJfkyN4dtetk6lCesNKQ3jpSMaCzrayb2zpP7j?=
 =?us-ascii?Q?xyCM10gq5gfjmgHLiRpVdeZH5d4+FCce8zs9/JW1Tnj1znYFKyDBWoCwwSUo?=
 =?us-ascii?Q?uftAipMcfj53YqHj2A0XzaItfNm+vi/y5tNZEnpxKv/40BLIDlPrDcJHQwrp?=
 =?us-ascii?Q?ghG9KcHfYxO7UEXUUMaSsEMCTkxuuZMPHWDwdwc25vNhf0OICQSzdlQuutM0?=
 =?us-ascii?Q?i+C5PsGo7Gyj2lMavb6KrmHPeR8Az0S1vExHY7Bj4PyROwVZOSIH7C/j7dMj?=
 =?us-ascii?Q?uarnVyOaK8GlYVua78NGNVfReKYR+RHONTe3v+VjYb7J4Bg1PPjmh67LzChA?=
 =?us-ascii?Q?3q2g8PKGph8eBRsGJGoel5zp0tGlMJGmQn3PDRfpL1iD2yad2P7cUFMzBTAX?=
 =?us-ascii?Q?gcs4bB+Hpksb7t+8nYzB4YHS5JGClnaRK4PoTM4wowRPgLHlgFX0QlgT7Izp?=
 =?us-ascii?Q?iP0zvChxmXU00BnOIV2LZzp2vJ0k7oKPU4pW35f1Nr5wGistpxqe2tP8v5mg?=
 =?us-ascii?Q?1JJ44TgKOwPlxag6U0rdzP+9O59AEBM7Ub8x8Wtv8og1mGjZYAVuq/ZZ1Wmg?=
 =?us-ascii?Q?hWTxupwmZTpo4DcfMOkvbOezzrjJ84K0cjEJ8y4DXJUbq7FGnBAip1FvhyiF?=
 =?us-ascii?Q?Hl4eGLOkIzONpRwRMV1raH0ygx7j6TZUTEmnFplJClOAA09Yml2pADNLRuYc?=
 =?us-ascii?Q?Oih8gWC3f5kd02wMxjnE79VDD2IPQzJGmZOPtLJktoTGZbDgyGdIvl5vTakp?=
 =?us-ascii?Q?Y9j4rVCKIO9wqIOO4Ob1X17yCKMZBTY13W54LzRBcCQ8vFCyeF6wrSww5LGJ?=
 =?us-ascii?Q?Q7GB7yIS718/6pAWdJ64S0RLvItvOdNCjxz00C901QrM05KOxpWulN0FqbG8?=
 =?us-ascii?Q?E/6mECM77ua7Tsa9h4QiTU8um8nRxM3QbYm9FJUTFbKDMB/KNb1XKlknsaom?=
 =?us-ascii?Q?IqM5hPxkBK8SjCv7SipnG3LvrEjv2DNJ4bPv4CU3?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DA7F040FB388BB64FBC9BFC78APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67c4506-e60b-411c-f6ed-08ddb325c9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:48:23.5723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ksIl2BNDh7uTw+un9a4tDMyamzLrz43Gq1PnT2KJDVRgtgJmmJe3BsRwxh9KvbdTQqobaGG1yht4rKJ8TaXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
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

--_000_PH3PPF37F43E35DA7F040FB388BB64FBC9BFC78APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-06-24
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* ARM
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.07:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 4 June 2025
- PMD features freeze (-rc2): 25 June 2025 - Moving to June 27
- Builtin applications features freeze (-rc3): 2 July 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * Backlog cleared.

* next-net-intel
  * More or less ready for RC2.
  * ~40 patches.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some patches in progress for RC2.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * PR sent.

* next-virtio
  * PR sent.

* next-crypto
  * Some patches merged for RC2.
  * 14 patches in backlog.

* next-dts
  * 3 series being reworked.
  * Should all be merged this week.

* main
  * RC2 in progress.
  * Merged fixes for Windows build.
  * Submitted patch for UBSan.
  * Looking for a new maintainer for eth_dev
  * RC2 moving to Friday June 27

  * DPDK Bay Area Summit - Santa Clara, CA
    https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.2
* 23.11.4
* 22.11.8


See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35DA7F040FB388BB64FBC9BFC78APH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-06-24<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.07:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 4 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 25 June 2025 - Moving to June 27<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 2 July 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 11 J=
uly 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Backlo=
g cleared.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * More o=
r less ready for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~40 pa=
tches.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches in progress for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR sen=
t.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches merged for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 14 pat=
ches in backlog.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 3 seri=
es being reworked.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Should=
 all be merged this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC2 in=
 progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Merged=
 fixes for Windows build.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Submit=
ted patch for UBSan.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g for a new maintainer for eth_dev<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC2 mo=
ving to Friday June 27<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * DPDK B=
ay Area Summit &#8211; Santa Clara, CA<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.4<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.8<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35DA7F040FB388BB64FBC9BFC78APH3PPF37F43E35D_--
