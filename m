Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7656C021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 17:06:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0710A427A1;
	Mon, 24 Feb 2025 18:06:05 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D30874279D
 for <dev@dpdk.org>; Mon, 24 Feb 2025 18:06:02 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9uJ2h028287
 for <dev@dpdk.org>; Mon, 24 Feb 2025 09:06:02 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 450pjxgvhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 09:06:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIdLC9lXqjCNw1fi4RB0OJB6tbifycrmfnZa6J64+rJD5UBfQa3Me0LMBXDM8RHKp3hLSP6DRUsC7/tiFvHqv4JeeYrgqBDpc97TX4FkBbNZOdjSUQ4wCdVm0t0U9YbQdlghv6fFJkyfLvU4YaK9+u5IGKA9t+gJMbrEaollKUdl0xCG22s5WxMC5O3BKXSWswMCIKDVIpgu2RViQvBRdrtMXnfHwPa+01biK8kmcsfx3tW/HD9tmEIiZC1ayo+vOH93lAqCupJy12ELgB6gIgxHAQzqX0l7hLqlvesS+R7u/0IWnOzDiy3oBwn7AT02plDWa8fth5HTWR7gVtqxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSgLepS3Q/VlX1/aipMBrOrSoM41+qt9tB4XNrtr44M=;
 b=g099wesUpRpNUGIYH8z02YJjEdGdIM+eLHWv0SHyFmstMMlNGQpbtLoRZ0QN+9LQ3uN00wuGDfhm2cxgM3FaEfU4Sn2+DosDciRYH/weLlYLj3cH9x/xxZAi1lPHTLopjnagZ0SmDJc9897pxX70oIVQ0scjBDqu0k2GZYEXvWIGeS3DtaVMVJUhHBiMCDml3XBNhJHsGmmjAd3QrU7APyZsCLbUK3kruuI7UkUaXz53+k/TcfKcMAM5c8kQKXY5KEKKY4dzbJQT9Ten6HiNenSGfQPNRQc2yKLqYZvfq8ewmuYjVosa3b3bUkGkUzWuhnrVOCCy5cc2jpPbEisSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSgLepS3Q/VlX1/aipMBrOrSoM41+qt9tB4XNrtr44M=;
 b=n/kqf3fFuBezpWxjrXNFt1Cr3y1xY3w4t2udc2mCpH79jPQJX8sjQlJhFo266RvwqQ4BXA0OCb4ChuRvdFV8yIpvcoTo6/j+WQ3nfTa3CrURphMUR0M6AL9h0JsrNJ3RKyg+Xa5XKMJDSPSo4hW8N1cr0DgZYl05gqDwS9ZShsc=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by SN7PR18MB3935.namprd18.prod.outlook.com (2603:10b6:806:10c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 17:05:54 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 17:05:54 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: RE: [PATCH v0 1/1] dma/cnxk: support pending count per HW DMA channel
Thread-Topic: [PATCH v0 1/1] dma/cnxk: support pending count per HW DMA channel
Thread-Index: AQHbfKc0AK4fK8dXbE6Bl3gNmXs+ULNWw1LQ
Date: Mon, 24 Feb 2025 17:05:54 +0000
Message-ID: <BY3PR18MB47851208CAA6D285CEA34B25C8C02@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250211170532.1650221-1-vattunuru@marvell.com>
In-Reply-To: <20250211170532.1650221-1-vattunuru@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|SN7PR18MB3935:EE_
x-ms-office365-filtering-correlation-id: 07e5677f-3465-4b48-3f2b-08dd54f57fcf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aohV8QH+Q96exMAsH/U09PJupGx+GtUBPiE9JamzYEg3Wmp7XN+oG+xMsj0z?=
 =?us-ascii?Q?Mdt+9UFxV/zmcUk83eDlwUjbYCRVqleDLsjrx5KTTvfJdA2+6jHWgTeR7wh4?=
 =?us-ascii?Q?7P2girPGS8c4XVpcDUJxaigM/ANN0mCA/sfmQP6s28pAU17MkjS98KGCDUxL?=
 =?us-ascii?Q?xkohe0hjr/+q0F9JZNx691g/9VhgE+cIn0ATMKpan2r3gv9kwSLKeyWRBVrX?=
 =?us-ascii?Q?a+X7b3B69N1OgTE6O4R6tRBIlzEjJDw0bznAciUir7heWxldz1k4JQeY6mDl?=
 =?us-ascii?Q?z7jW2u2CFrBKWpQTIJXSrMfMeSaSN8d7YophbVKx/9JprvenTTifjGKdd6LA?=
 =?us-ascii?Q?9OZcZnJ1nPBQx8XKrt3ffnTzPFCfsji5HZMNVieESnVVQaPokGeUvLtiUyGa?=
 =?us-ascii?Q?Mw1d9U4919U4PKg3lzFDl3wdo5vfX5LqjN/fN009xVXwmQjRfAdISl6VhkoU?=
 =?us-ascii?Q?gRQCCxMlCtclzf7uqiYB4sZfnIr8SE1ZzIOoqzyC/bEU4C2dLU25xaBb/ljR?=
 =?us-ascii?Q?isEQy4JuLZzgtCY3kc2GsL05f6QFUshkXRiJjyiEvIgZqcX1pVy0vxz+PQj/?=
 =?us-ascii?Q?qR0XhSM5+nvRnqOQWqZ0AAABXVo6nIvVfFeJK7zYATdibfSI5iZ1n1mb2dyS?=
 =?us-ascii?Q?1YEu2O+OJqgE4J6YV/9c74CUlk03AUQxIKhCyZINQdpI5Sj75oArO/1mP/mi?=
 =?us-ascii?Q?5S0cJEGtlKU+Waufn/ULKVTudyQBw75VCpLIaItNMeT1gEkL6v6pR4XFocc3?=
 =?us-ascii?Q?WnwFu8vJwXtdL8d2AC/vAvdl29BaZ9nd9qKGhWiTdLrq9EHDi2ArgoXgNOFW?=
 =?us-ascii?Q?O3nkjaR/+qIbnGbLXKGBPzqOA8+mP2M8jzxKuCDblKxeK+bfkOF9r4LFEWt1?=
 =?us-ascii?Q?mBpibxdy/aqValAAM9WWtHm0KJ/0gdAvXTN37PefujXnbgGlVdLczuhcNDsW?=
 =?us-ascii?Q?Ie2lBTUl8QJ3lupMQtqDJBxeBQcCkvW+WYrEcgsgTyoNPO3/FfkycJjUQUqM?=
 =?us-ascii?Q?3gnAwHlXXU9MBo8bgxaWpqV33kxo5SNR7Xe/olcBwFE2IEKKW+7qeIlNHBdN?=
 =?us-ascii?Q?+HZcBfSYs2K7Hf2E3Lmy9mGCP96L/8Xw9VuBSyYa8YeLShmzW1FLkiRamvT6?=
 =?us-ascii?Q?CEXy6A7SSg2hPt8A1dYH+kRi5vIk0zUP6p/TujymMnsVz006CwgYuSPHm6wM?=
 =?us-ascii?Q?s5Ef1R3GA2XSE4NU2HVE92L5oGOKm2oZ050F1An3ol9SOQUgfeQ7a9HdgvTL?=
 =?us-ascii?Q?0pmyiZRmgnMi7+KNwBy89bRJG1oT7xZ5DhTCw3scXBLygVVg3NABhof+YHFO?=
 =?us-ascii?Q?+F6pu1n7mvejvCqR52enooahyaoQJcL3cJ+5gwf0qEclcYEDxW+J7DUmRAqS?=
 =?us-ascii?Q?m8C9iyRjnGK2VVCv1KNCAx+vVzaqceMvm/j7Sos5akMJ487YGt6PmeXpm9WO?=
 =?us-ascii?Q?ocRpoOeljSCo7zIFYETzac0tm/jZNo2E?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7uOuhWDt1QPWTjV33V/bNsforKPXaxgZPwWGiX/O1drS6QLFgAeZIRrit5iz?=
 =?us-ascii?Q?vLWGA4YvXlpAoNUFPr1Ojj7CD2Rj/MiFeGD2SXQWnDm7wTKpWa2ZklVuG0pQ?=
 =?us-ascii?Q?cteMT2mVppNhow8zJEV70TKUHj4XlPjDJCioXJ+tp1Luan/MXqGIf70ESQEH?=
 =?us-ascii?Q?7cIffBoCDesEXuD3cXSv8aMb+3v+RPF6sflmvbeaQYUHmkciKeF5y2E81hXS?=
 =?us-ascii?Q?LbQsDiuR+xRNU0BLRovjss8NYRf2Uli5xgKWMuKNjtqOPsNLi14OBrzvsTWO?=
 =?us-ascii?Q?Eif7XqFrc39/NShbpiDaAaWOXfmrtzJ+kARvkvj9iRPde6fBXvRoxYidF6pi?=
 =?us-ascii?Q?OIFAbXwcKatQ4NJr1F+iU8KuKrO/AKxW8rVSdP94b+dmDqJhibsbnEpMcScb?=
 =?us-ascii?Q?jGmYblV1seh7WfvMvb0aJefUcnXUKh7032hqZqtN0KQBmBGJ6mzzxDQVPeg+?=
 =?us-ascii?Q?anaEt2Hf/mQeaXuEGEbBNPNAlFSm34PTjVEU+Lm8ERIOoiuY5EzYQ2lDtBOL?=
 =?us-ascii?Q?v3xbAR9zAWEdrIgHwp3WFvCw/oJ4aiZFOcr78oc9DOtxO9GI++qmuy5Lj7p/?=
 =?us-ascii?Q?d5CgCtFjXQgFu6oPJeSO0CkmLdPNmk1zaz+3MpjyhqnU0bOdFi2gZoIDT1gB?=
 =?us-ascii?Q?ZjV7COXg5Nav1JVSevbxFKhmzFJY7yOzxqm7wYN9GtEtiKTvyt0KqfD1CyE1?=
 =?us-ascii?Q?Bw2VyuQwU/8YoJqTbItEPjEagyfAt4KHObsXbQatxwCdepFLxkT8t4BbqjUs?=
 =?us-ascii?Q?YyQxlGPnbdgZO+jBVoY88CAe1/m2VneABx9xKy9XiXGQqCF3W3kFHaw+ReEU?=
 =?us-ascii?Q?WPmFWESY6m9eQcPsosmXz0d/py2hlIeiAkt+kpfLbl4ou+Kf4R/MdT41ACwc?=
 =?us-ascii?Q?1bWwrOj0wbdnxMDLpwsidzcOqfjQWxryqj9BWeK27uUJwHMG+e7XQ3snv0Q4?=
 =?us-ascii?Q?FWY45typqXJwW73xmSesqadZdfiDnrRSVlTwM4/ON7GwoU0pN2McT9YSNBXe?=
 =?us-ascii?Q?7l0ihDcL/pEcZWIvoL7Uim8XYeZB5515FAuaZlRHqwv8ZZIV+QzlASmz9nxx?=
 =?us-ascii?Q?Okr7Amd0TmRoI2o3Kn2bAnGdZgbTIWe2Sn/GXytm+qvh6YsQ+cBmIO68zQUB?=
 =?us-ascii?Q?DuYJ9BtKXLK+4mcjVG4YzGIUAjAYbZ+UTr2T0OO3GjVpb4jmiDYeSR6CWvDe?=
 =?us-ascii?Q?HGkADYJFHK8ACdY7JVOBEeShVukMfBud7UsmOc/SDIlUAwiFIeGKpkegCbnh?=
 =?us-ascii?Q?b6wEFp59XwDhrcSw3aZOni6fvgc1po4JFmP70/wFk9ViDXKMpLABWFyHhSWv?=
 =?us-ascii?Q?CwOkUv02mkQ5T4IfI0dFxC0KykEhtv2dAQzEN9tpo37+bXdkogP4eSScttWZ?=
 =?us-ascii?Q?mylpG+ANvgsf02CxTLQzxM1lQgiCdPE41BowbVJr3NFK7qBmCIHFRf7DiEK7?=
 =?us-ascii?Q?SBZ8EL6UgkFfH+OCvfPrFdqutKM59pfHB8NcnBO7b5CITWMWQe5DKPxnJ9Cz?=
 =?us-ascii?Q?KTzvqA5SrgTkgO7bbQWyq0Ic3kLS6VKSz/qPQsXwNVVVfhyPt3kupsBd03v4?=
 =?us-ascii?Q?u3f/nae2rgdMmcKnRXp8DhpyyURc3aZ3fqvA18lR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e5677f-3465-4b48-3f2b-08dd54f57fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 17:05:54.3869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vz4y51qpZovWRYIvp64QDWP78pPXqOv3VfY6J8EPDbavh5ygdR7gSWXMDIL+Grqw64fbjn8zoGUpJeObmiWkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3935
X-Proofpoint-GUID: cu-KF0mrcGtBgxZ7BcDaC4qxaPkatUgU
X-Proofpoint-ORIG-GUID: cu-KF0mrcGtBgxZ7BcDaC4qxaPkatUgU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
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
> From: Vamsi Krishna <vattunuru@marvell.com>
> Sent: Tuesday, February 11, 2025 10:36 PM
> To: dev@dpdk.org
> Cc: Jerin Jacob <jerinj@marvell.com>; Vamsi Krishna Attunuru
> <vattunuru@marvell.com>
> Subject: [PATCH v0 1/1] dma/cnxk: support pending count per HW DMA
> channel
>=20
> From: Vamsi Attunuru <vattunuru@marvell.com>
>=20
> Adds code changes to maintain pending count per hw dma channel instead of
> per vchan. This enables ringing dbell for exact number of dma commands
> present in the DPI queue.
>=20
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
