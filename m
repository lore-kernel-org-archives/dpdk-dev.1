Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB1CCF2D3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 08:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 628FC40297;
	Mon, 19 Oct 2026 10:11:12 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54]) by mails.dpdk.org (Postfix) with ESMTP id 8C6DF40269;
 Mon, 19 Oct 2026 10:11:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9TtekvqE8necKMRd6mzlkCrcpuPwEkwXr3sr1WpUlJqIVKBb2NmFnXWc2+Nr94UlY373c9Nc4XnCG3v9+0bpxl+dYPhUb9Ca5USN8mCrNOleI6WejhAGhLGzXra+oVnoKpHtlVcWS0wiXOr4pJWQe89LH1uy3FOOsFsrKJt2DA4S6IO2inLPWojRr2PXpkdccWBHFHIQyunmB36YsIq/0K26O+7kbWaSzGSvghjR04Nfj9fnWpIibjbxoR6XxwMcaAgMlLjFPUrKqE0zjd4DLzC90yUHJHuLUF2AF3UrU0yeycUTaQXKA9QpVfTbfwbATl02vVCfYZhb2vfk71+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL4ihHgfdkAVuQ32GHoPP+SeHiRSeYsykXCAwdV4sYs=;
 b=soUyqfqHtDxNchQOxf66HYu7e9pZHHjfHd6v2KCuARGPXiBd9UzUxsB2fx7X/N1kjZLBZ0B4qCu2baEeQrD7LMLkigyx+Jq+0lu3d0FiaUuWxPY7zNPNjBtsdvbjWBDRreRxTd5+ymxgN67O54IASQoGXNLJ2BSSippRM3N7MOO3eHE3TSrzsc5bzTm3TmPuwXWFovw5HrSD0WNOKdYTlFCMPhZFVZt7JPveZG5/WsXxPX9FadSthwyH4+KX96Uagp40wFmFNdICisSQ7L35tylIr1PsuMOwg3yYyi0lGtr+wecCazqEm1jegQh7H4R0xGjn+CDU5Z69d0G/Gy+NuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL4ihHgfdkAVuQ32GHoPP+SeHiRSeYsykXCAwdV4sYs=;
 b=lyHHk67ISkxCHaD+bYdmlk0Vf7nLpHmFfrLWjILYYB31h1EZKE2LgMI3fmbpJ53SrRSRcqDTUzLVbctGbFRPqIghb5bhEo1VFf3T/Jr6MKzU+fJSqeIFwDQYmPnEQc6tIOrJ6ifmQ0lRlGv8P8+2jsGnBQIvMlSuEWKpbEs3H6ouuhvpxCWC2vQK9eAxHTQS0vG8Z9j9yZ6A4s4oh6jAJE46xs81KAFEsmeRK/ftbixXLQ3ZXWeH6iewcPjWrcbvAMocjUco/NOtLnjj7xQSCgiMSw2hYDSc3P4X1XCv6OpKXE71u85tqx+frUwLeGBLeT/tKGNBgVbxTxH/7QIUZw==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:11:06 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%4]) with mapi id 15.21.0472.015; Mon, 19 Oct 2026
 08:11:00 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>
Subject: RE: [PATCH] net/mlx5: fix HWS meter ASO SQ leak on multi-port init
Thread-Topic: [PATCH] net/mlx5: fix HWS meter ASO SQ leak on multi-port init
Thread-Index: AQHdXt5vuh+cgMTTs06O2QH2lTmD6LcEhNeA
Date: Mon, 19 Oct 2026 08:11:00 +0000
Message-ID: <PH0PR12MB7077CA7DC701D469C44D466AA4982@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20261018085510.8592-1-mkashani@nvidia.com>
In-Reply-To: <20261018085510.8592-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|SA1PR12MB5614:EE_
x-ms-office365-filtering-correlation-id: 41f80a95-c646-4ed5-d1e5-08df2db882d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: fAxIY1l+H15vR/V9IpxIAfojKpIak7bANQ1ZnV1Ehn1+1SN4L2DeNUvMq8Y7z2RDCsxeT3jq/OZxdi2SJo8AJWnAWacwkBrGjPk/BHfGXvkgGjYp3LDLsbh5ViwveiyAGTB9yynmzKV5zi+/PlhnkzpMDtcY4m1euMuJIgqDehwEvcVRthMXQA1I/RtmZK4frT/1GPecfyvkR5vldCKhx8FCaB8gTzMizLCIwFFqHljde1Y734a2BlJ8/DQzkoTy4DCk5LHGD4ysPVlO0320QbxQVaOtsGMc9KMJ0dcfftniB6Hv4SZjCLj9aIlfSNFaox64OF2QPpIQYRQfhQtQ6z8rWC6c8nMOunj04GQOgcsX6uKU9gAX4k36BzDHZBZP/9VidN312o7WaDYVpMst1A+oCxa79gHljCh1Bw67WTurRd6Knxz6WV9DAfj+pTtK4kOYvojLB1w29KKKOXCU9oaKC8JBQhVW22RF3oVAd3SXUKbBFhu+G3SePNjg+4L3rzrdZ8HHo8m/GVoVfUuGbVqTFrw9cJjfJ6304z53dezxofz4ZHi1zOMTp2LN1zxfW8c8QI1Q3KaKgv8SfUaPIpRg9L9n0i/Q9i6n/Fg2uK9QXlkU63CEtQBbgIi9fbQOVvAX8IxSZd4//EKbCzuK9S7sWK/BQ8JTllmtdCPwA9u+3kNTggsKt6Xpj76wCmQZdEI/dUGsQAyDTk9rR7seavk6K2A08C2z2DVX344QQzQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VGlU0qp+yZnk8v9GG+g4OrPc9yXXXMg80XAnljXDgDn5vJXYlyC0ZAqF4bS4?=
 =?us-ascii?Q?PFBHUfVXuXLtk+JrtvHNmSGphe6qzDn3JkKKWD2T/bbnFJ/lWlpHRD9SiLeE?=
 =?us-ascii?Q?DK6Zwc0uXjOpe9xo/LxVpotnihFqRfPiJT4uo7EeVOKSayBoUUn1ZlsPReS9?=
 =?us-ascii?Q?lipJbxz9BqrYwTyOqpMwXomdMafSp4vW6EosDzehR/7rdZuG8DrFkPBOkdpb?=
 =?us-ascii?Q?4WE96Bzbv2hBT6943VEkAfvD+jZ2eRP2MLbLWdjmgKfZX189NDwg/JVLDVMK?=
 =?us-ascii?Q?3wSO6ypSp8+ha96HY1I7DJyeF7qTTvNc8JkMtMQofY95342s++Go4b7uQ8J2?=
 =?us-ascii?Q?nlie8GO+3J7g1iWavtind2Hx2KMYmSuskVxg2y7nywPUG8oqL6TC5+isu2KF?=
 =?us-ascii?Q?4t7la+fVAxQlOq9Nvjl9d3ui/GpVlu9F37NDTmcg/WA8RhLovd6PIBwdecoY?=
 =?us-ascii?Q?bBlEg8iqC2c0kV0/XrHNR0l7DsT3xMsIxGzzXNUvxbX8RtBXuZ2VP0/dq+Ea?=
 =?us-ascii?Q?1kVG/E+S6ulLHNU9hUd9DUVVQS8X9zYa1PNqMcz9e2pgmN3GnAkEPHd8hBzy?=
 =?us-ascii?Q?LG2kCYV0D0+lkkW8pUfDD6K7OJnEy1dSajteYaNOi76EbaRyps3SGbSufNh7?=
 =?us-ascii?Q?5BWkdd8ANWX2eYa4jPuUgc+pA2Qz5K6Yyqrt1N3cXGAJ7tO1YBW+9cuR2V5M?=
 =?us-ascii?Q?cejNrvceS5C0doOvtm5S3NpaewrOZk+1NPKo617dD9fhgIgcNjr69HHhofxT?=
 =?us-ascii?Q?ZnFFsQvvIRZa3+jZNrv5M3UBRfTl5SuupTU7rYo+L945Bwm8n2gdRfJqt5Jk?=
 =?us-ascii?Q?k2tev7eIZfELLSr4njQbpyVVx5tPc2ygvS6i3Z7nWtUTKdEjrdIqEBm/1lwW?=
 =?us-ascii?Q?bxeVcmhqQ/f+roWOGHLjlX9wyNNCU6l2qDPdgcQY/IR5xkIpCcRrdMk5cImY?=
 =?us-ascii?Q?f7R7ukXjAnB7u4bxuLgGzn3KPAFVdIDswEhqoF+T6kmwb71tbMZTW3QmFdWn?=
 =?us-ascii?Q?4pnXoAYwAOu8kSTkm9nHo73bDNmNAVRfB54Jb/3ID8O4BSvOHAhswLOEaySM?=
 =?us-ascii?Q?dHy6QuBYidBD4btMuXT/McBeSSpBc6snxq6vDvbrtYNBJAVEq5ezfynRlx5h?=
 =?us-ascii?Q?dnsKQIDdwd8p2hgMNdriy1RQsxrmIk4z/8PeLkBE2e9obdiT7j01UZZPy4z/?=
 =?us-ascii?Q?gw46xEAkZ0o9mpK7Yn5mkSNUPddM/Q8mxeD8tZJ5m4+agKGxLTI6K5UBvcX1?=
 =?us-ascii?Q?tgsemtcoCTzwEiFYFfPPK+bdmIkj4Z2F+E4EqWvxCAehvncmBGH5CaqstK3m?=
 =?us-ascii?Q?tzUymLolK4R3FnOr5VyA0TZAZYDvJiuO1R3KUjJvajjmh2/ZXeRSo9gRRzOa?=
 =?us-ascii?Q?YLZ8sJSR3uYeziRtSiKaCU19iU9ZVxhq51QZpWRoopZa5f3BJQUda/4rIziG?=
 =?us-ascii?Q?ftjsauFHEGz99hs/g+zadrTIDduph4mir2EwQtOdTg4XmAZIv+W6k6JpApdj?=
 =?us-ascii?Q?XkqXae8lQXBCFUtLlGg3iQJc75xrSwbFXMbJeExEl1B6u1kHV+ZvTfDY1KEk?=
 =?us-ascii?Q?Pa43Z9exIMjxbctJ1UjrTC9Gk5E9tuKoUFF6sRl6mCEYitEEECo76pI+yxcB?=
 =?us-ascii?Q?F6gAhfqzZWd269uVAbxzLZ+jG/DS4x0jq8tQ7FwuhLZmxfc9NV2TYLmyncOX?=
 =?us-ascii?Q?L0/R1tOlEzVzAvoeUeRfbW+1VPRcaoqSpb+FxgTvX/tpFrSWVhAIXCM8s6Wm?=
 =?us-ascii?Q?hoDVjo6/Tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f80a95-c646-4ed5-d1e5-08df2db882d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:11:00.1458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPyk4rU1VnoMf70nYCgwXCy6mFmzx2t400UQv07i+YWIUdcCsmn9Zox8D4Pl5+SCF+8D/FHa4VufVDD3IwuMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614
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
> From: Maayan Kashani <mkashani@nvidia.com>
> Sent: Sunday, October 18, 2026 10:55 AM
> To: dev@dpdk.org
> Cc: Maayan Kashani <mkashani@nvidia.com>; Raslan Darawsheh
> <rasland@nvidia.com>; stable@dpdk.org; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing
> Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; Alexander
> Kozyrev <akozyrev@nvidia.com>
> Subject: [PATCH] net/mlx5: fix HWS meter ASO SQ leak on multi-port init
>=20
> When multiple ports on the same device initialize HWS meters via
> rte_flow_configure(), mlx5_aso_mtr_queue_init() recreates the shared
> pools_mng ASO send queue without destroying the previous one. Each
> additional port with meters configured leaks one SQ/CQ pair until the sha=
red
> device context is torn down.
>=20
> This is observed as steady growth of hugepage allocations (dump socket_me=
m
> count alloc) when repeatedly attaching and detaching a device with multip=
le SF
> representors configured with meters in HWS mode.
>=20
> Create pools_mng.sq only when its DevX object is missing. A send-queue id=
 of
> zero is valid, so sqn cannot be used as the existence check.
>=20
> Do not destroy that queue from mlx5_flow_meter_uninit(). It is shared by =
every
> port on the device, and releasing it when one port closes breaks meters s=
till
> configured on the others. The queue is released with the shared context i=
n
> mlx5_aso_flow_mtrs_mng_close().
>=20
> Fixes: 24865366e495 ("net/mlx5: support flow meter action for HWS")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
