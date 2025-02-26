Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8443EC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:13:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA70540665;
	Wed, 26 Feb 2025 10:13:36 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by mails.dpdk.org (Postfix) with ESMTP id 717264065F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:13:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfNk+3Dx7TCrqrmu2svXhQoHHTd3qd5zimsgk7OGHChJstfoDRPKJElX/NYD/vPMY/FVw3lbvdzSN/yrKVwGFXoDjIbIwI495hzCTVXHW/d4JEc6Aiw0mlGD270yTVR/To83dc79PpqEBOUstsUIPXs3yJnNWz8LdmFSagUTwITEdIDtFoe15BUX72Y3jOK6Tcn3H4EgjPV0ZUIhE0M3YhK2HyTEYCa+xsqjT73ksuJgmJtmnsamMwBe+KTWL63gJCAa6vsZZui/E6WcX7sbPcue8tzTgk8e3HSVXPYK2QpKVkSk/Ci86G+pZNhiDDMlRqsdqwIgSJezUePOBlUihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2H4+z5WFnE/C/ETSt0I46+np+2u4gVzRBaGU4PtKHU=;
 b=o/HmhzyofHm2R/TApk4w4tOQYk+Dymt05cDD7HneVrjTEU2hUU4OAX33Y3odInD/+Um08VQckq1xntnC6P4dzQzrXKgqOKGnxVbUqfuqY5QD/pID9G9BU/2EUsJobTKvk2JJp46aSEKWd6nVJb9VGrzawP4jDBHak3ih7lJAmTxLggYxg5WQB5NxfsDcRVN0Zlqe0oURmqPw8BI+sQJB9QATULMn0Qnr42pRsfs3EREP/X8J2UCct15MMSbcB07AQ3GtbIdxmbsJJP1s6ZX18ga/2aNNBhWfTVpJXdaYku9eYbki9riN432LWd/WSiDmxU8VfIjTxNLVIG8JqG+34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2H4+z5WFnE/C/ETSt0I46+np+2u4gVzRBaGU4PtKHU=;
 b=cDdBms8dLT56YKxkQC4t7p8Ufrhoq87wIoG6RWClNf6LTPVibhsXMwI02XN9yw9f1h6OeJQlbaFr1t47gj8N/vnJD0FOPdryTF+83Fa57DE8c+iS/DxiP0EHHUr8LOYL5kaHHb7W0fDdAKbMtg3r/BbzudGCGEMeIBPfEkEENFQZfCKAmKidwyc2HHFKnJBPXFBy7jMr/YJjDHmGVz2XKSez1z3FFkZPE6kls40Lh5+Jqj/ACmPim+66yMCVHdfw8Tz1Xdjvi1CsnqX2WRlGdqK69Y80wfG50xBLOT46vNik4hNH2NAq2MDikcRrCGhGoQPmjvCqNKxYCA5kHaFQjQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:13:30 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 09:13:30 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH V2 4/4] net/mlx5/hws: allow different types in miss
 validation
Thread-Topic: [PATCH V2 4/4] net/mlx5/hws: allow different types in miss
 validation
Thread-Index: AQHbiCoHWeajv2DKBEKm9R6GEVE4JLNZTQrg
Date: Wed, 26 Feb 2025 09:13:30 +0000
Message-ID: <CH3PR12MB84603DE009591A06F30AC974A4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
 <20250226083846.4023622-5-ophirmu@nvidia.com>
In-Reply-To: <20250226083846.4023622-5-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH2PR12MB9520:EE_
x-ms-office365-filtering-correlation-id: 3b3f7058-887b-4d7b-202e-08dd5645d643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Uyw3a1LZ9Mt58fuct8zPLoD1y6Vobc5xUHFlxZHCpslqXTZmR1RwmVOBZmgs?=
 =?us-ascii?Q?dJ88gqyhXyiHUMZeEJhkCupZrB6QtPXpqWOPfVkx/9KjuMtUysimFOnAITkS?=
 =?us-ascii?Q?0dYNdvclCyoVx1cqbipxdMq3B3E1KopJ8/ni2m9Cw2c759cvQk9SoXyPaDaZ?=
 =?us-ascii?Q?LVoWu8PlwAlWXpQaKM/MMo+WCqYyoAwdDWCMcZwZZ2YklVFNHSgaSWkmdYj/?=
 =?us-ascii?Q?+0QA5sGZeK0VzV2y9yot/+LLZe47GyQ6b6gNNL/ifzW8meJNUg4nbtG/1w59?=
 =?us-ascii?Q?uSO2KfvORyiaWCwURQ1EOAag/NHmFPllZztcvD3oxevPDfjTJ/pPHiRdjixx?=
 =?us-ascii?Q?iuc5HXwgdwe2oeAgRfyi0ActBawDDKCWhBCmZG2+KT+dHEOm6UEMbLswP3s7?=
 =?us-ascii?Q?HOhO9a8edW+pzR+VpX+55gKPQj9Z5SqhtLEeRV+UiBmV6t78RKmbOBUe/P/B?=
 =?us-ascii?Q?mkDSQVoqwIthTcJaYy8q8FyBjLFoBtFRbJZO2bjkcv3HKUp1CuunsPO9FZ4L?=
 =?us-ascii?Q?wRpdR+33p+Eee18jLSOtSis7N0zm4FxYuaWZDUt2GvP8r/+pjpCqW6WBifYe?=
 =?us-ascii?Q?Y4MfH4Z45FPqbJYLi7czJgmJ1yRcJE+ffokyPFvH64X8PohWeKN93OPMyrJI?=
 =?us-ascii?Q?eNm+TOzCyLwOMBUhnVCo7WNKt/7bta/LL4kg9eHEm8sVgJAOn7fMRuBtnplJ?=
 =?us-ascii?Q?HTmIewZhpT1ZLD9A368O7haFHzSKe5uUvpMGXlFYYasSojJLt69eyQjxa6xl?=
 =?us-ascii?Q?fVJWpHc8WssHiVx+2caGfAWcz/FkZLHQVMAJbi7tIbEh60zDbQePIJ3fTB/u?=
 =?us-ascii?Q?5l8AipJ+GXj5ja4gugX5T+phg1sKkcJK9YXDKUofrUsqlOipG9cWJZCFkIse?=
 =?us-ascii?Q?fNrJTNitYxJzveqBKLXiIOLXQjKKEJe1uSM0NnN2n9YPuH9jeWhumRPVFEza?=
 =?us-ascii?Q?TaRDiRrwsJ3gM6KbyS5dLDQ6FgxqHjzTDUgVct0aoeYYBrWyyxghRl5gQQyF?=
 =?us-ascii?Q?aL/ja+UZaFFeL8W7ZfPnGLqyA9XjmG9U/5a1Fgo4wIcxGvb10vKy557a4DFg?=
 =?us-ascii?Q?51qfHcXV50aQ7lxiZCPc008qoOfROUwmCK/8MEc1cCgLSsT8m4C+H6tfM9EX?=
 =?us-ascii?Q?VnVVgQMH4Bs3lGcN4EkPSbICLXFjLsH2LBpD1aaIzwnOgVC1BAYm2QNcQjDI?=
 =?us-ascii?Q?d1kdbjnWNNYDKwRl4G9Gp+muoyxz15dCVVZXer7+10CoJz4H3VhMfnba/fUF?=
 =?us-ascii?Q?tvg9dE5bZuSg42Cx3ZeeBk9SNeKQda9wIRdKiIYIHmIykhEAT5En4f4JYxeS?=
 =?us-ascii?Q?oPnI+L2TpZ+nfm270lGQFRtDxMLjVUO1UiqmrvLo/m5HaNaeMWk8Mrobn+RL?=
 =?us-ascii?Q?DBvpePynwk0lE18Zsuy/zNVDjwggQNpfVJA5BCgmo/PUqWNU/4/T8rFb5SL9?=
 =?us-ascii?Q?IczgkrhGpb9KUDCXxTfMM3MgT4huGaO2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvRAzn6pFblmkz+JWl7XeCbojb63ZKjUatARrhwCfUPRQTVbrDC1ibMs95YS?=
 =?us-ascii?Q?TAgeaIv8LX/mmTJUu0KYgMcOBpky7L168W+7LFeLsAK2SikbBr+f/stZ+eK8?=
 =?us-ascii?Q?32uaEHGJBlHn7IZEuKFyHoSX4a8qhG8INf86sIREQMLoJtFbv5FeiNG0eW6f?=
 =?us-ascii?Q?Y3Idww3WSQLhJXZ2Hu5b4pdKkHG1G6F1vOH2/idwNbDOiyz0NiJhzqZXzx+I?=
 =?us-ascii?Q?Csr+3vz8zC2B+NXgBk8y0m4BDeXergrjQbWoNhxBkkrB6I58jbLphUDK6Tad?=
 =?us-ascii?Q?J8LjwsaJqHdbGhUjkk5gIw/FH4iaWjPfTRpcocB0aGfykop5xxgnCj5ZLwoX?=
 =?us-ascii?Q?buhD+dN27tMkobs4Jsc1Qt8RscVChWeMd7mPBFaj5+S3sqYiFj3GQMWTgwWg?=
 =?us-ascii?Q?JKDcxBTjojfzxz3BspMrdx5HdCsJgUj683yQoaYfm0Lv+BbFu9hx1iCiAhC9?=
 =?us-ascii?Q?v9HOqW+9Km1IpeJyC9ExxEZL6zAlbYBYmFYJS/tzycFHU8AfB5lr0/i1vszo?=
 =?us-ascii?Q?YwOv4VULLgEtp55neQmBL3xmebw71YY/H58RL2T9R3NWXJv4R4wxqG/ogF4Z?=
 =?us-ascii?Q?aWBvRk3co2mox/gBVR67FBXXu6fyq3KEM5YAKpMqmAjrirhLbZATxWAr8b83?=
 =?us-ascii?Q?MToEBKh98Q5s76/uwZad5EsohiZ6lVuITDVg9sti/owmqJaBKSiSeghMGJ1A?=
 =?us-ascii?Q?dhqlBf9XkmkCGIZLwgS5nZJkNLduQlO14nYZGwnhBDsIkTxL1h8VVXAoN/lW?=
 =?us-ascii?Q?2BGebtHjQycL35mwdhcpek2Xd1dtyhFmdvA/3xHKi7/hq2ujzfp2TZGvOf0P?=
 =?us-ascii?Q?5Xx7kF7eSAu9o8I9VJQAQouwZCO+m4zvgAZD72vV1R278ZiRn/gNFI+rAXuF?=
 =?us-ascii?Q?0HEo5RBtcLLAN06CUbLZSke2STqZEK5n8jh1H4IuunCpoMSmIFBOyAoFve35?=
 =?us-ascii?Q?mxMiyBeQeAxHX6CtNi+O20yU2rUc3nXFTn9tUAeFhCGvvtuwy3cErXh79XR6?=
 =?us-ascii?Q?Bm/W4PiCXXmyMEtZaUQnsjnUn/4/djVkgFo3Z0PBhg78METjSq8icNmtw98j?=
 =?us-ascii?Q?XdzaUDbUTG39kFpju+Iczok6aOgXT61qYTWudjVKWqs3ywKQeJP2VhMry7RI?=
 =?us-ascii?Q?brBLFtTdmStb4x53rrm4izAlayZs7W3LXvDI7hfgyDYWOO+khn3Wky6+jlxY?=
 =?us-ascii?Q?ID7pHhjlnH7usBmbdIklb9JpJI0hW70jTOfmPWjyWhxKFcQajNsV0coIZ4H8?=
 =?us-ascii?Q?FOlnUGT+Oj1dP6MWOcjjBGgDfjhcfXGOvXzfnXzUCXPJO5lmjBTJs1291E6H?=
 =?us-ascii?Q?K6Ldkpbs2pnUsmWceqpVzDkRDRMUP9bKeCjABJFQZNGVRybB+r7RDzkXdWcq?=
 =?us-ascii?Q?Hi/9aR6nzwG9fBasGVEC/hHQ8B9Le7WUJY7XRMMZYquip4Yqt8x6MBFDtQbD?=
 =?us-ascii?Q?BeN0/YzUvG2uh/1eV3RVNHe2x83p572y+FBT/E4/BgkGksT9BzmiRshAcbKU?=
 =?us-ascii?Q?UD86W/w1WdB/qpEMWZggA/alOhx61coWPxblgPbE93UROtjhoP1UXsK699+8?=
 =?us-ascii?Q?/PirN8xSiKg1BABf0D1S7MKEIY+A8DNsLV0HvQjv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3f7058-887b-4d7b-202e-08dd5645d643
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:13:30.3394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3AmCSkrVbPsyNlh1/YNBwrvA2ZLUw+/ek/TPSDkPlgPeXoFB9eAePVcwd7bBWQGFHl5YPkhb4/UMrIWy/i1YzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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
> From: Ophir Munk <ophirmu@nvidia.com>
> Sent: Wednesday, February 26, 2025 9:39 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH V2 4/4] net/mlx5/hws: allow different types in miss valid=
ation
>=20
> In validating Jump from group A to default miss group B DPDK requests tha=
t both
> groups types will be identical. In practice jumping from FDB_UNIFIED to F=
DB_RX
> or FDB_TX group types (or vice versa) is allowed.
> This commit enables this jumping between the different types.
>=20
> Fixes: b81f95ca770d ("net/mlx5/hws: support default miss table")
>=20
> Signed-off-by: Ophir Munk <ophirmu@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
