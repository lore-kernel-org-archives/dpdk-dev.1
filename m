Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A08C5B543
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 13:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8F14025E;
	Fri, 30 May 2025 15:09:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A0A6E4021E
 for <dev@dpdk.org>; Fri, 30 May 2025 15:09:53 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U9WD8B015331;
 Fri, 30 May 2025 06:09:44 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2127.outbound.protection.outlook.com [40.107.237.127])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46ya4cgavj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 May 2025 06:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n55lJ3HLz4/9oL8fa21n2iqpf5HnRS/pQn2SNUCbLO3zViZhBKNmTvyXoHxNLuQI5Dn6aTR/DPYJsO1/Lc9UkeFV9KlYlIT7tthbGuKVQnTP3ldn/a2PMzxlXipJlPkMYtfMuqSbc5x9nJx5hE77KChKMcVe5owhHnl7owBWW3IKAgN1VcDIXOv1YinYVgBz3U7bAZLSyVxSAZb/KF9+4WkpyQNo7zdYgHz4LijiJwjuZFy4ttZjfLpn5QiGKtFCnmIgRE8N56+z4LDekaT5hMPDp8kmcwT7EpXOHHhKpPyNpijcY5A6znkfU4igW7ZTzy0nIQYugG9RTPnkshDe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/YKEbdqUypcbsNDDSc+zLWGKcSvrFdVCgR0hrZEzoA=;
 b=KmKM9lebd61Y/SBibDjUUoJtU0oeS2B34dfMPnRWkAqJD7Hum/xOTFqF4K4p5pEecKRZO38rLDZSFLxoSJD6wLkF3cQBzf27QpB8OTxwLCTjhgOZSQPu+rnca/7pv/D4unYzdJjOhWznFqQVMmkD8e2g9BMvjzfJPpP1hbg4KMs+7/8RtDumh/bHQ2dYHW4e42H+TgVi7AIISY2B0J/ES/myV4j5vJpJS30R/TE8N+IjhCld+t6pXNdwCKLDm7pJVvJNdWwui0A4IuLM5pHwih8aeCHEIxV+0Pku38P5xSoV6e8/P6WRow8mpe7M65qpkRJZihV0Y0mVXAf3Bm85WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/YKEbdqUypcbsNDDSc+zLWGKcSvrFdVCgR0hrZEzoA=;
 b=alf2PrL9HZgQNxPGMxzYbd6qse1GzfXNxSYNF88wQlp2HdCuT55KkQ4LmCZdXkmBIQNRsrMJqJ8hoJEFsEGeAsfOAONoBwgMFe4zqIFQM8pmGzMMWLfkNgm1+S7P+b0oIRgrzQ2RA29qp8xXvG5fGBLEZ9HbNd64MyzxXbAqchk=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DM6PR18MB3522.namprd18.prod.outlook.com (2603:10b6:5:28e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 13:09:37 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%6]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 13:09:37 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nitin Saxena <nsaxena@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: RE: [PATCH v9 2/5] graph: add feature arc abstraction
Thread-Topic: [PATCH v9 2/5] graph: add feature arc abstraction
Thread-Index: AQHbstCDDgx+vLRpnUGCCEJl0MvjgbPrW1Xg
Date: Fri, 30 May 2025 13:09:37 +0000
Message-ID: <BY3PR18MB4785A878550F3A7524A0BC22C861A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-3-nsaxena@marvell.com>
In-Reply-To: <20250421151718.2172470-3-nsaxena@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DM6PR18MB3522:EE_
x-ms-office365-filtering-correlation-id: 706c39bf-decb-48dc-beb7-08dd9f7b3b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KdN3K7GK8lNxc2j2wi1uFJqqvpGYT8gTvGkJyYTTkIrig5YRnPPPxJnRcoPL?=
 =?us-ascii?Q?hJ1OCZOOmHmTL/CYFdv8mK51ldq6qZXJ6VTD8JDfMwWinP7v5MQG5v4wFExD?=
 =?us-ascii?Q?LyumBwcF3qZkXrIC5csCcvYsJrN6nHfk8vgABtCUytXUWTachd9dWVCFXywW?=
 =?us-ascii?Q?2iRs10JxqShwzBm/ZNHPuQMhoBpxM4jN30QQBsEr24+4x2YYHCizHjHsz64V?=
 =?us-ascii?Q?3uXm80+rC8JF+VLUtg4whT15FNJNuzbRpiQqPgEysRw0Z/UysFsEPtJ60KIO?=
 =?us-ascii?Q?xA5TaQO/+8QhqltZhZHORF6KWpxA71xJIhxDLfxKSxiB0a5iK/Jab6cMAV2L?=
 =?us-ascii?Q?nkjq6416Me3pP90Yk9PrVghs9TmTFLLZBAY5Et8+HpfQsNoCMxP11fdDb76J?=
 =?us-ascii?Q?EEE4AZAxCcZEhXhQkcgC/mpnB5+TF0cRDR6svDG8cPcO+U2rFBmhYZXUnOds?=
 =?us-ascii?Q?Xbd8r8WGcbnRF6b65RJyqmc4DgOhSAAYFngMrpD5ktqzADC4v7baFtI20qyK?=
 =?us-ascii?Q?OPac5ylJ9aAswUo/0drwd8y4H4EtFyt22932JIZCZtuebaAOJOymW6MIFRRs?=
 =?us-ascii?Q?3avgAdWjvnzr4IOAxLyRyynvMZ1tM3DL3lcXja5Cldf4iy9aYqVGH3aQ0yp3?=
 =?us-ascii?Q?0xMCQtoP7E8CJ2ZrFFQZ1vNGKje91STFWufE9pChUaR/g+xBRKp052m4OmuF?=
 =?us-ascii?Q?9Yetc9TToeF7huDhBUtcFI4VTVy9t6q2LbWqhOzGPR3jfW0sgJ7jy/GxtJNR?=
 =?us-ascii?Q?kXgCATPJ5b0sHzt87oY6apJoYJf4F3uulPv7l6zx84lb2x5p+GOCI/rv0q5a?=
 =?us-ascii?Q?gz7qrX6LaM4x1/n7dt/jSDfqub+zlDhSfSa63yyOsZmycLAe9Ep49ZSrN6T+?=
 =?us-ascii?Q?RBwzjQ90ZVVgEdzC7ATBABO2oi1pUpywrUdvptlK3n1UUwbotKGatpBIrvL9?=
 =?us-ascii?Q?dzhS3dMg3Y5H15u/Voh8rkYl/mWAy7BJ3loJSLVA8HcnMEl1mH5uLSiskjgn?=
 =?us-ascii?Q?vLgwAbOIkphUZDCirSsjDfIsBM3HcsjEy4HnFL45T9N9Mv9MQTV1IrpimLQB?=
 =?us-ascii?Q?6Fv9/r6QFgZQd/2IDLBTm91tJsOvPKQdDqmaV0Ncxjzvsypaj3f61IIudX45?=
 =?us-ascii?Q?jBg9edXflLeSdY32aZ74DEr4wUE28OqlYW3n+rRI96lBSPo9PeZ6bdmTLGuO?=
 =?us-ascii?Q?Rw2B1/g93SDPrOjbtGeN8mZ0qDBYpUiIG5VhRnVGqoUHYi95bEr8sWLJpNgh?=
 =?us-ascii?Q?xN5bauZA48j9Gt2qvOU72Y2dl4ZDFG8pbU/yF08WDV1Ar5lKajTyBowHAdoT?=
 =?us-ascii?Q?IpKEUG0I42ZqSgQ4aGALoNKh1+GP80GPa1iOpkg261w+Q85IK5SjsxAbfinN?=
 =?us-ascii?Q?je6cbmzS2E0LNoqP+8sKFQDL+LIRBV9+mAgMtZ3G575zVv9O6GLQOHxR5s+A?=
 =?us-ascii?Q?sVYyZXXcdkc9wvYj+IKBoZgFYyZSgeMgSD49hC4Y18VRYBjiydJd3ef53NH1?=
 =?us-ascii?Q?oLDIjPsIxAkvM0Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gqLbmBthZFxHkC16xbT9DGj8D4yk2hA5AaYNzazI29jmfwKvWpbPqvFdaBD9?=
 =?us-ascii?Q?UvphXRPJpboEbsy3xcJEbNrIZB0gxBOdVFA21/gd5zEXfKyMoGpIldoCpyPW?=
 =?us-ascii?Q?63v82AmqRybULoG36k2ZFPvdFV1mTBemn778sRPipaIzk7Yx8Enxyp7ss3GI?=
 =?us-ascii?Q?cvpA51w4SRwsU9mQ0CAvcksK4J7i7ZoU9sgJBg4svZl0UFzAFeiZksWyPrhJ?=
 =?us-ascii?Q?a2jZOBtWBiWp3ojrcJfwBjiLA3DNHLBq7Fosha86b0Bi25ewVnEOH5F3J+qH?=
 =?us-ascii?Q?G5uVXDJ3+7DgDyCVU6HY1E/oohzgLEhBp4U9ueSJxtCH6ojE4WtwNleFFbdC?=
 =?us-ascii?Q?ZNKt4u94O9ALeNyqfu31CIOTMgI6KlyXUvYNgMk6sn5JxrDPtehvTq+f49jw?=
 =?us-ascii?Q?8i5Ljzl8I/q+8WF49a3YGJQ29nevIB1QqY2ScJa2ZllzmlGGvP09EsfGV0Yd?=
 =?us-ascii?Q?vnp5uYdun36BHSvHWKUmDY1A0gEAZxIzug34tOtIeAyvE2MQtHxkjzPp4QiH?=
 =?us-ascii?Q?54AtStz4c1woDRpNUzSTm9xEr0m+cN9Qfnl8BxK/kXNeA8hujts1w4i+rpxj?=
 =?us-ascii?Q?x6tFH7ItL5VuGQKv3OaecdHO6pVE300QS370n39Fy5F7S+5mfGp94ZLhEIzJ?=
 =?us-ascii?Q?95gYh02DBf2N+VJxh2iCXZk+q804u5/1rD0uXIBoX6sXbxq6jKliOszJ6j80?=
 =?us-ascii?Q?tfdJOGJzXOYN588mVFJ2V4rEoCdzQOVRo6N5QdeaC+WSeIjaH/Zzgq2lplYF?=
 =?us-ascii?Q?oft7kJaur0zbQfQ523pYGu43xUiQgdu83Tko+9bBrPimttGG/XkvjDppmb2h?=
 =?us-ascii?Q?i1e7lMusBqj54gLTXlZG1g5QzaAWXTsFpXtou72wBK5ZOwsWcvBsz7kn5HGq?=
 =?us-ascii?Q?b7rAkTDawmmWFKeopYjs3C1t2ZiYISFCSAWWiUEqvCzz75y7rVm2osh24Xie?=
 =?us-ascii?Q?7NBhWe/Arb5ap7iMgmTogHKfK3Dh10GzVhitCkEEmZ/6nWT19jDA1YhLV/xn?=
 =?us-ascii?Q?f/mX0vcgdAW44H5RBhVpK+AcNNUJgKK/BPSBA5yfrjLqUrc2Wu1kmLmujPeQ?=
 =?us-ascii?Q?on8pMpOepi0c+dDtq+f6HNDooIx7UAoex6oBHWYyXWVgzt/HbD1Koh4PZFPr?=
 =?us-ascii?Q?SMZosfSf7V6qJUUuruOln/3cFRwIKfa5Du97TRRyoIyGZxsMG9DnXcbgrjfc?=
 =?us-ascii?Q?Ttv3eWG8hQO/ATHuDp5Myucjesjy/dsd287ViKaeeNWae6jZioFdo1SZtyW4?=
 =?us-ascii?Q?Dy9BVZvsmN/Hg0ZGR+Gy985hKrcIhyVzQxdH6LuGrBaIka5oJzV8MkBaViL9?=
 =?us-ascii?Q?obRO3ZWSbrsXybEOA0bZYPMvm1HN9FYItqz4Ulx1VlWVEmbAjJuan0V3Hmlu?=
 =?us-ascii?Q?WcSc+0BZTnMGCnn6VVdIhEUPTh+I0Q1keamxyeSCfmLEL/d5g9u4Re/ZB0Qe?=
 =?us-ascii?Q?AFOfjlTXgNCDEp23KzZB0jcdbkDyJDFCpG0K8hNihcDETmRk8qy2lN2MA2WR?=
 =?us-ascii?Q?qLSZkzRb1KdtM2KCw3uCPCrOWmqRb7qTKdI4Q2WcXpjHMBNPTURxbliOk14Z?=
 =?us-ascii?Q?O5+FR6yDHD1dnV4N0PyVebmtsjqSaUg7y/aP97ui?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706c39bf-decb-48dc-beb7-08dd9f7b3b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 13:09:37.5994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJpW1P64W6mWJsZCxnt+j87tS33v6oLHEDCPV512IQRI85jqXWj5mlQmqkYdb0yFFaLo9k57vTKYh6q63w+reg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3522
X-Proofpoint-ORIG-GUID: I4gigzrCAsKGF5V5BSZHKvcCuepEn0oe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDExNSBTYWx0ZWRfX+EAWuA52pUPX
 b5T8froWgqSDOuOg1tp+zya+sAzfKJYCi3V0z8l5cngkKElta82u8eNUb//IQLVjwyvPtlSaXPg
 mryFUTLy6Y7QcWKyw0l6tEsMUg942Ij6u5JKM85FE3FrmH26PJ8Nz1FxX2cVHC4AxXfumc5BI0O
 85OI9W4cde+3pcBuTWmQy6b/AhVLxcrrTIPtaoQn+8yErxm8RPP0CYm3GYxtBTne08qczVut+sS
 8/iua0J5agYPqwEtqXBoBBLKoclhh7p17AwGMCrvFl2cHqbWmzHvtMDHUoRIbOI+4/XUpC9H6DX
 otcMEXqqRTw7H3WEFzNHOUhwYRBdHawharnWegdqHJpRiW7qTgRuA0GGet2OnxIxau1sczIFGDh
 bKrd5MQwT/ND3M4Y3uOorLVy3tUSfAjZSlddU52OB91qAJeEgST1ts6GZ4L6cOM6iAinHPgq
X-Proofpoint-GUID: I4gigzrCAsKGF5V5BSZHKvcCuepEn0oe
X-Authority-Analysis: v=2.4 cv=Hpp2G1TS c=1 sm=1 tr=0 ts=6839ae18 cx=c_pps
 a=MJlwP/pY7jdh0k4YB6prAg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8
 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=rgjWaBcmjqooIFHQp68A:9
 a=Vbi4mO3dQ8bIl38f:21 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-30_01,2025-03-28_01
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
> From: Nitin Saxena <nsaxena@marvell.com>
> Sent: Monday, April 21, 2025 8:47 PM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>; Robin
> Jarry <rjarry@redhat.com>; Christophe Fontaine <cfontain@redhat.com>
> Cc: dev@dpdk.org; Nitin Saxena <nsaxena16@gmail.com>
> Subject: [PATCH v9 2/5] graph: add feature arc abstraction
>=20
> Feature arc abstraction allows rte_graph based applications to
> - Allow control plane to runtime enable/disable feature nodes.
>   Fast path APIs helps to steer packets across enabled feature nodes
> - Feature enable/disable based on indexes. Index can be interface index,
>   route index, etc
> - More than one feature nodes can be added to an arc and also provide
>   mechanism to control features sequencing order in fast path.
> - Does not require stopping of workers for control plane updates. RCU
>   mechanism also provided
> - Once DPDK inbuilt nodes adopts feature arc abstraction, out-of-tree
>   nodes can also be hooked (with no custom changes in DPDK in-built
>   nodes)
>=20
> Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
> ---
>  doc/api/doxy-api-index.md                |    2 +

Programming guide is missing. Also, mention this feature is optional in the=
 guide



>       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> +* **Added feature arc abstraction in graph library.**
> +
> +  Feature arc abstraction helps ``rte_graph`` based applications to stee=
r
> +  packets across different node path(s) based on the features (or protoc=
ols)
> +  enabled on interfaces. Different feature node paths can be enabled/dis=
abled
> +  at runtime on some or on all interfaces. This abstraction also help
> +  applications to hook ``out-of-tree nodes`` in DPDK in-built node paths=
 in a
> +  generic manner.
> +
> +  * Added ``ip4_output`` feature arc processing in ``ip4_rewrite`` node.

Move the doc changes related to node to the relevant patch.


>=20
>  Removed Items
>  -------------
> diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.=
c
> new file mode 100644
> index 0000000000..1c94246f4a
> --- /dev/null
> +++ b/lib/graph/graph_feature_arc.c
> @@ -0,0 +1,2050 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#include "graph_private.h"

Move private headers file after public ones


> diff --git a/lib/graph/meson.build b/lib/graph/meson.build
> index 0cb15442ab..5d137d326e 100644
> --- a/lib/graph/meson.build
> +++ b/lib/graph/meson.build
> @@ -15,14 +15,16 @@ sources =3D files(
>          'graph_stats.c',
>          'graph_populate.c',
>          'graph_pcap.c',
> +        'graph_feature_arc.c',
>          'rte_graph_worker.c',
>          'rte_graph_model_mcore_dispatch.c',
>  )
>  headers =3D files('rte_graph.h', 'rte_graph_worker.h')
> +headers +=3D files('rte_graph_feature_arc.h', 'rte_graph_feature_arc_wor=
ker.h')
>  indirect_headers +=3D files(
>          'rte_graph_model_mcore_dispatch.h',
>          'rte_graph_model_rtc.h',
>          'rte_graph_worker_common.h',
>  )
>=20
> -deps +=3D ['eal', 'pcapng', 'mempool', 'ring']
> +deps +=3D ['eal', 'pcapng', 'mempool', 'ring', 'rcu']
> diff --git a/lib/graph/rte_graph_feature_arc.h
> b/lib/graph/rte_graph_feature_arc.h
> new file mode 100644
> index 0000000000..d603063def
> --- /dev/null
> +++ b/lib/graph/rte_graph_feature_arc.h
> @@ -0,0 +1,634 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef _RTE_GRAPH_FEATURE_ARC_H_
> +#define _RTE_GRAPH_FEATURE_ARC_H_
> +
> +#include <assert.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <rte_common.h>
> +#include <rte_compat.h>
> +#include <rte_debug.h>
> +#include <rte_graph.h>
> +#include <rte_rcu_qsbr.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * @file
> + *
> + * rte_graph_feature_arc.h
> + *
> + * Define APIs and structures/variables with respect to feature arc
> + *
> + * - Feature arc(s)
> + * - Feature(s)
> + *
> + * In a typical network stack, often a protocol must be first enabled in
> + * control plane before any packet is steered for its processing in the
> + * dataplane. For eg: incoming IPv4 packets are routed only after a vali=
d IPv4
> + * address is assigned to the received interface. In other words, often =
packets
> + * received on an interface need to be steered to protocol not based on =
the
> + * packet content but based on whether the protocol is configured on the
> + * interface or not.
> + *
> + * Protocols can be enabled/disabled multiple times at runtime in the co=
ntrol
> + * plane. Protocols enabled on one interface may not be enabled on anoth=
er
> + * interface.
> + *
> + * When more than one protocols are present at a networking layer (say I=
Pv4,
> + * IPtables, IPsec etc), it becomes imperative to steer packets (in data=
plane)

IP tables ?

> + * across each protocol processing in a defined sequential order. In ing=
ress
> + * direction, stack decides to perform IPsec decryption first before IP
> + * validation while in egress direction IPsec encryption is performed af=
ter IP
> + * forwarding. In the case of IPtables, users can enable rules in any

IP tables

> + * protocol order i.e. pre-routing or post-routing etc. This implies tha=
t
> + * protocols are configured differently at each networking layer and in =
each
> + * traffic direction.
> + *
> + * A feature arc represents an ordered list of features/protocols nodes =
at the
> + * given networking layer and in a given direction. It provides a high l=
evel
> + * abstraction to enable/disable features on an index at runtime and pro=
vide a
> + * mechanism to steer packets across these feature nodes in a generic ma=
nner.
> + * Here index corresponds to either interface index, route index, flow i=
ndex or
> + * classification index etc. as it is deemed suitable to configure proto=
cols at
> + * the networking layer. Some typical examples of protocols which are
> + * configured based on
> + *
> + * - Interface Index (like IPv4 VRF, Port mirroring, Port based IPsec et=
c)
> + * - Routes Index (like Route based IPsec etc)
> + * - Flow index (like SDN)
> + * - Classification Index (like ACL based protocol steering)
> + *
> + * Feature arc also provides a way to steer packets from in-built DPDK *=
feature
> + * nodes* to out-of-tree *feature nodes* and vice-versa without any code
> + * changes required in DPDK in-built node's fast path functions. This wa=
y it
> + * allows application to override default packet path defined by in-buil=
t DPDK
> + * nodes.
> + *
> + * Features enabled on one index may not be enabled on another index hen=
ce
> + * packets received on an interface "X" should be treated independently =
from
> + * packets received on interface "Y".
> + *
> + * A given feature might consume packet (if it's configured to consume) =
or may
> + * forward it to next enabled feature. For instance, "IPsec input" featu=
re may
> + * consume/drop all packets with "Protect" policy action while all packe=
ts with
> + * policy action as "Bypass" may be forwarded to next enabled feature (w=
ith in
> + * same feature arc)
> + *
> + * A feature arc in a graph is represented via *start_node* and *end_nod=
e*.
> + * Feature nodes are added between start_node and end_node. Packets ente=
r
> + * feature arc traversal via start_node while they exits from end_node. =
Packets
> + * steering from start_node to feature nodes are controlled in control p=
lane
> + * via rte_graph_feature_enable()/rte_graph_feature_disable().
> + *
> + * This library facilitates rte graph based applications to implement st=
ack
> + * functionaloties described above by providing "edge" to the next enabl=
ed

 functionalities

> + * feature node in fast path
> + *
> + * In order to use feature-arc APIs, applications needs to do following =
in
> + * control plane:
> + * - Create feature arc object using RTE_GRAPH_FEATURE_ARC_REGISTER()
> + * - New feature nodes (In-built/Out-of-tree) can be added to an arc via
> + *   RTE_GRAPH_FEATURE_REGISTER(). RTE_GRAPH_FEATURE_REGISTER() has
> + *   "runs_after" and "runs_before" fields to specify protocol ordering
> + *   constraints.
> + * - Before calling rte_graph_create(), rte_graph_feature_arc_init() API=
 must
> + *   be called. If rte_graph_feature_arc_init() is not called by applica=
tion,
> + *   feature arc library has no affect.
> + * - Features can be enabled/disabled on any index at runtime via
> + *   rte_graph_feature_enable()/rte_graph_feature_disable()
> + * - Feature arc can be destroyed via rte_graph_feature_arc_destroy()
> + *
> + * If a given feature likes to control number of indexes (which is highe=
r than
> + * RTE_GRAPH_FEATURE_ARC_REGISTER::max_indexes) it can do so by using
> + * RTE_GRAPH_FEATURE_REGISTER():override_index_cb(). As part of
> + * rte_graph_feature_arc_init(), all feature's override_index_cb(), if s=
et, are
> + * called and with maximum value returned by any of the feature is used =
for
> + * rte_graph_feature_arc_create()
> + *
> + * Before enabling a feature, control plane might allocate certain resou=
rces
> + * (like VRF table for IP lookup or IPsec SA for inbound policy etc). A
> + * reference of allocated resource can be passed from control plane to
> + * dataplane via *app_cookie* argument in @ref rte_graph_feature_enable(=
).
> A
> + * corresponding dataplane API @ref
> rte_graph_feature_data_app_cookie_get() can
> + * be used to retrieve same cookie in fast path.
> + *
> + * When a feature is disabled, resources allocated during feature enable=
 can be
> + * safely released via registering a callback in
> + * RTE_GRAPH_FEATURE_REGISTER::notifier_cb(). See fast path
> synchronization
> + * section below for more details.
> + *
> + * While *app_cookie* can be known corresponding to current feature node
> via
> + * @ref rte_graph_feature_data_app_cookie_get(), however if current feat=
ure
> + * node is not consuming packet it might want to send it to next enabled
> + * feature using, it can do if current feature node is a:
> + * - start_node (via @ref rte_graph_feature_data_first_feature_get())
> + * - feature nodes added between start_node and end_node (via @ref
> + *   rte_graph_feature_data_next_feature_get())
> + * - end node (must not call any feature arc steering APIs) as from this=
 node
> + *   packet exits feature arc
> + *
> + * Above APIs deals with fast path object: feature_data(struct
> + * rte_graph_feature_data), which is unique for every index per feature =
with in
> + * a feature arc. It holds three data fields: next node edge, next enabl=
ed
> + * feature data and app_cookie.
> + *
> + * rte_mbuf carries [feature_data] into feature arc specific mbuf dynami=
c
> + * field
> + *
> + * Fast path synchronization
> + * -------------------------
> + * Any feature enable/disable in control plane does not require stopping=
 of
> + * worker cores. rte_graph_feature_enable()/rte_graph_feature_disable() =
APIs
> + * are almost thread-safe avoiding any RCU usage. Only condition when ra=
ce
> + * condition could occur is when application is trying to enable/disable
> + * feature very fast for [feature, index] combination. In that case,
> + * application should use rte_graph_feature_enable()/disable() APIs with=
 RCU
> + * argument
> + *
> + * RCU synchronization may also be required when application needs to fr=
ee
> + * resources (using RTE_GRAPH_FEATURE_REGISTER:notifier_cb()) which it
> may have
> + * allocated during feature enable. Resources can be freed only when no
> worker
> + * core is not acting on it.
> + *
> + * If RCU argument to rte_graph_feature_enable()/disable() is non-NULL:
> + *  - rte_rcu_qsbr_synchronize(rte_rcu_qsbr *) to synchronize all worker=
 cores
> + *  - Calls RTE_GRAPH_FEATURE_REGISTER()->notifier_cb((), if set, and he=
lps
> + *  application to safely release resources associated with [feature, in=
dex]
> + *
> + * It is application responsibility to pass valid RCU argument to APIs
> + *
> + * Constraints
> + * -----------
> + *  - rte_graph_feature_arc_init(), rte_graph_feature_create() and
> + *  rte_graph_feature_add() must be called before rte_graph_create().
> + *  rte_graph_feature_enable()/rte_graph_feature_disable() should be cal=
led
> + *  after rte_graph_create()
> + *  - Not more than 63 features can be added to a feature arc. There is =
no
> + *  limit to number of feature arcs i.e. number of
> + *  RTE_GRAPH_FEATURE_ARC_REGISTER()
> + *  - There is also no limit for number of indexes
> (RTE_GRAPH_FEATURE_ARC_REGISTER():
> + *  max_indexes). There is also a provision for each
> + *  RTE_GRAPH_FEATURE_REGISTER() to override number of indexes via
> + *  override_index_cb()
> + *  - A feature node cannot be part of more than one arc due to
> + *  performance reason.
> + */
> +
> +/** Length of feature arc name */
> +#define RTE_GRAPH_FEATURE_ARC_NAMELEN RTE_NODE_NAMESIZE
> +
> +/** Initializer values for ARC, Feature, Feature data */
> +#define RTE_GRAPH_FEATURE_ARC_INITIALIZER
> ((rte_graph_feature_arc_t)UINT16_MAX)
> +#define RTE_GRAPH_FEATURE_DATA_INVALID
> ((rte_graph_feature_data_t)UINT32_MAX)
> +#define RTE_GRAPH_FEATURE_INVALID  ((rte_graph_feature_t)UINT8_MAX)
> +
> +/** rte_graph feature arc object */
> +typedef uint16_t rte_graph_feature_arc_t;
> +
> +/** rte_graph feature object */
> +typedef uint8_t rte_graph_feature_t;
> +
> +/** rte_graph feature data object */
> +typedef uint32_t rte_graph_feature_data_t;
> +
> +/** feature notifier callback called when feature is enabled/disabled */
> +typedef void (*rte_graph_feature_change_notifier_cb_t)(const char
> *arc_name,
> +						       const char *feature_name,
> +						       rte_node_t
> feature_node_id,
> +						       uint32_t index,
> +						       bool enable_disable,
> +						       uint16_t app_cookie);
> +
> +/** cb for overriding arc->max_indexes via RTE_GRAPH_FEATURE_REGISTER()
> */
> +typedef uint16_t (*rte_graph_feature_override_index_cb_t)(void);
> +
> +/**
> + *  Feature registration structure provided to
> + *  RTE_GRAPH_FEATURE_REGISTER()
> + */
> +struct rte_graph_feature_register {
> +	STAILQ_ENTRY(rte_graph_feature_register) next_feature;

Doxygen comment for this

> +
> +	/** Name of the arc which is registered either via
> +	 * RTE_GRAPH_FEATURE_ARC_REGISTER() or via
> +	 * rte_graph_feature_arc_create()
> +	 */
> +	const char *arc_name;
> +
> +	/* Name of the feature */
> +	const char *feature_name;
> +
> +	/**
> +	 * Node id of feature_node.
> +	 *
> +	 * Setting this field can be skipped if registering feature via
> +	 * RTE_GRAPH_FEATURE_REGISTER()
> +	 */
> +	rte_node_t feature_node_id;
> +
> +	/**
> +	 * Feature node process() function calling feature fast path APIs.
> +	 *
> +	 * If application calls rte_graph_feature_arc_init(), node->process()
> +	 * provided in RTE_NODE_REGISTER() is overwritten by this
> +	 * function.
> +	 */
> +	rte_node_process_t feature_process_fn;
> +
> +	/*
> +	 * Pointer to Feature node registration
> +	 *
> +	 * Used when features are registered via
> +	 * RTE_GRAPH_FEATURE_REGISTER().
> +	 */
> +	struct rte_node_register *feature_node;
> +
> +	/** Feature ordering constraints
> +	 * runs_after: Name of the feature which must run before "this feature"
> +	 * runs_before: Name of the feature which must run after "this feature"
> +	 */
> +	const char *runs_after;
> +	const char *runs_before;
> +
> +	/*
> +	 * Allow each feature registration to override arc->max_indexes
> +	 *
> +	 * If set, struct rte_graph_feature_arc_register::max_indexes is
> +	 * calculated as follows (before calling rte_graph_feature_arc_create()=
)
> +	 *
> +	 * max_indexes =3D rte_graph_feature_arc_register:max_indexes
> +	 * FOR_EACH_FEATURE_REGISTER(arc, feat) {
> +	 *   rte_graph_feature_arc_register:max_indexes =3D max(feat-
> >override_index_cb(),
> +	 *                                                    max_indexes)
> +	 */
> +	rte_graph_feature_override_index_cb_t override_index_cb;
> +
> +	/**
> +	 * Callback for notifying any change in feature enable/disable state
> +	 */
> +	rte_graph_feature_change_notifier_cb_t notifier_cb;
> +};
> +
> +/** Feature arc registration structure */
> +struct rte_graph_feature_arc_register {
> +	STAILQ_ENTRY(rte_graph_feature_arc_register) next_arc;
> +
> +	/** Name of the feature arc */
> +	const char *arc_name;
> +
> +	/**
> +	 * Maximum number of features supported in this feature arc.
> +	 *
> +	 * This field can be skipped for feature arc registration via
> +	 * RTE_GRAPH_FEATURE_ARC_REGISTER().
> +	 *
> +	 * API internally sets this field by calculating number of
> +	 * RTE_GRAPH_FEATURE_REGISTER() for every arc registration via
> +	 * RTE_GRAPH_FEATURE_ARC_REGISTER()
> +	 */
> +	uint16_t max_features;
> +
> +	/**
> +	 * Maximum number of indexes supported in this feature arc
> +	 * Memory is allocated based on this field
> +	 */
> +	uint16_t max_indexes;
> +
> +	/** Start node of this arc */
> +	struct rte_node_register *start_node;
> +
> +	/**
> +	 * Feature arc specific process() function for Start node.
> +	 * If application calls rte_graph_feature_arc_init(),
> +	 * start_node->process() is replaced by this function
> +	 */
> +	rte_node_process_t start_node_feature_process_fn;
> +
> +	/** End feature node registration */
> +	struct rte_graph_feature_register *end_feature;
> +};
> +
> +/** constructor to register feature to an arc */
> +#define RTE_GRAPH_FEATURE_REGISTER(reg)                                 =
                \
> +	RTE_INIT(__rte_graph_feature_register_##reg)                           =
         \
> +	{                                                                      =
         \
> +		__rte_graph_feature_register(&reg, __func__, __LINE__);
> \
> +	}
> +
> +/** constructor to register a feature arc */
> +#define RTE_GRAPH_FEATURE_ARC_REGISTER(reg)                             =
                \
> +	RTE_INIT(__rte_graph_feature_arc_register_##reg)                       =
         \
> +	{                                                                      =
         \
> +		__rte_graph_feature_arc_register(&reg, __func__, __LINE__);
> \
> +	}
> +/**
> + * Initialize feature arc subsystem
> + *
> + * This API
> + * - Initializes feature arc module and alloc associated memory
> + * - creates feature arc for every RTE_GRAPH_FEATURE_ARC_REGISTER()
> + * - Add feature node to a feature arc for every
> RTE_GRAPH_FEATURE_REGISTER()
> + * - Replaces all RTE_NODE_REGISTER()->process() functions for
> + *   - Every start_node/end_node provided in arc registration
> + *   - Every feature node provided in feature registration
> + *
> + * @param num_feature_arcs
> + *  Number of feature arcs that application wants to create by explicitl=
y using
> + *  "rte_graph_feature_arc_create()" API.
> + *
> + *  Number of RTE_GRAPH_FEATURE_ARC_REGISTER() should be excluded
> from this
> + *  count as API internally calculates number of
> + *  RTE_GRAPH_FEATURE_ARC_REGISTER().
> + *
> + *  So,
> + *  total number of supported arcs =3D num_feature_arcs +
> + *                                   NUMBER_OF(RTE_GRAPH_FEATURE_ARC_REG=
ISTER())
> + *
> + *  @return
> + *   0: Success
> + *   <0: Failure
> + *
> + *  rte_graph_feature_arc_init(0) is valid call which will accommodates
> + *  constructor based arc registration
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_init(uint16_t num_feature_arcs);
> +
> +/**
> + * Create a feature arc.
> + *
> + * This API can be skipped if RTE_GRAPH_FEATURE_ARC_REGISTER() is used
> + *
> + * @param reg
> + *   Pointer to struct rte_graph_feature_arc_register
> + * @param[out] _arc
> + *  Feature arc object
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_create(struct rte_graph_feature_arc_register *=
reg,
> +				 rte_graph_feature_arc_t *_arc);
> +
> +/**
> + * Get feature arc object with name
> + *
> + * @param arc_name
> + *   Feature arc name provided to successful @ref
> rte_graph_feature_arc_create
> + * @param[out] _arc
> + *   Feature arc object returned. Valid only when API returns SUCCESS
> + *
> + * @return
> + *  0: Success
> + * <0: Failure.
> + */
> +__rte_experimental
> +int rte_graph_feature_arc_lookup_by_name(const char *arc_name,
> rte_graph_feature_arc_t *_arc);
> +
> +/**
> + * Add a feature to already created feature arc.
> + *
> + * This API is not required in case RTE_GRAPH_FEATURE_REGISTER() is used
> + *
> + * @param feat_reg
> + * Pointer to struct rte_graph_feature_register
> + *
> + * <I> Must be called before rte_graph_create() </I>
> + * <I> rte_graph_feature_add() is not allowed after call to
> + * rte_graph_feature_enable() so all features must be added before they =
can
> be
> + * enabled </I>
> + * <I> When called by application, then feature_node_id should be
> appropriately set as
> + *     freg->feature_node_id =3D freg->feature_node->id;
> + * </I>
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_add(struct rte_graph_feature_register *feat_reg);
> +
> +/**
> + * Enable feature within a feature arc
> + *
> + * Must be called after @b rte_graph_create().
> + *
> + * @param _arc
> + *   Feature arc object returned by @ref rte_graph_feature_arc_create or=
 @ref
> + *   rte_graph_feature_arc_lookup_by_name
> + * @param index
> + *   Application specific index. Can be corresponding to interface_id/po=
rt_id etc
> + * @param feature_name
> + *   Name of the node which is already added via @ref rte_graph_feature_=
add
> + * @param app_cookie
> + *   Application specific data which is retrieved in fast path
> + * @param qsbr
> + *   RCU QSBR object.  After enabling feature, API calls
> + *   rte_rcu_qsbr_synchronize() followed by call to struct
> + *   rte_graph_feature_register::notifier_cb(), if it is set, to notify =
feature
> + *   caller This object can be passed NULL as well if no RCU synchroniza=
tion is
> + *   required
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_enable(rte_graph_feature_arc_t _arc, uint32_t inde=
x,
> const
> +			     char *feature_name, uint16_t app_cookie,
> +			     struct rte_rcu_qsbr *qsbr);
> +
> +/**
> + * Disable already enabled feature within a feature arc
> + *
> + * Must be called after @b rte_graph_create(). API is *NOT* Thread-safe
> + *
> + * @param _arc
> + *   Feature arc object returned by @ref rte_graph_feature_arc_create or=
 @ref
> + *   rte_graph_feature_arc_lookup_by_name
> + * @param index
> + *   Application specific index. Can be corresponding to interface_id/po=
rt_id etc
> + * @param feature_name
> + *   Name of the node which is already added via @ref rte_graph_feature_=
add
> + * @param qsbr
> + *   RCU QSBR object.  After disabling feature, API calls
> + *   rte_rcu_qsbr_synchronize() followed by call to struct
> + *   RTE_GRAPH_FEATURE_ARC_REGISTER::notifier_cb(), if it is set, to not=
ify
> feature
> + *   caller. This object can be passed NULL as well if no RCU synchroniz=
ation is
> + *   required
> + *
> + * @return
> + *  0: Success
> + * <0: Failure
> + */
> +__rte_experimental
> +int rte_graph_feature_disable(rte_graph_feature_arc_t _arc, uint32_t ind=
ex,
> +			      const char *feature_name, struct rte_rcu_qsbr
> *qsbr);
> +
> +/**
> + * Get rte_graph_feature_t object from feature name
> +#endif
> +
> +#endif
> diff --git a/lib/graph/rte_graph_feature_arc_worker.h
> b/lib/graph/rte_graph_feature_arc_worker.h
> new file mode 100644
> index 0000000000..57aeaff01a
> --- /dev/null
> +++ b/lib/graph/rte_graph_feature_arc_worker.h
> @@ -0,0 +1,607 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell International Ltd.
> + */
> +
> +#ifndef _RTE_GRAPH_FEATURE_ARC_WORKER_H_
> +#define _RTE_GRAPH_FEATURE_ARC_WORKER_H_
> +
> +#include <stddef.h>
> +#include <rte_graph_feature_arc.h>
> +#include <rte_bitops.h>
> +#include <rte_mbuf.h>
> +#include <rte_mbuf_dyn.h>
> +
> +/**
> + * @file
> + *
> + * rte_graph_feature_arc_worker.h
> + *
> + * Defines fast path structure for feature arc
> + */
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * @internal
> + *
> + * Slow path feature node info list
> + */
> +struct rte_graph_feature_node_list {
> +	/** Next feature */
> +	STAILQ_ENTRY(rte_graph_feature_node_list) next_feature;
> +
> +	char feature_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
> +
> +	/** node id representing feature */
> +	rte_node_t feature_node_id;
> +
> +	/** How many indexes/interfaces using this feature */
> +	int32_t ref_count;
> +
> +	/**
> +	 * feature arc process function overrides to feature node's original
> +	 * process function
> +	 */
> +	rte_node_process_t feature_node_process_fn;
> +
> +	/** Callback for freeing application resources when */
> +	rte_graph_feature_change_notifier_cb_t notifier_cb;
> +
> +	/* finfo_index in list. same as rte_graph_feature_t */
> +	uint32_t finfo_index;
> +
> +	/** Back pointer to feature arc */
> +	void *feature_arc;
> +
> +	/** rte_edge_t to this feature node from feature_arc->start_node */
> +	rte_edge_t edge_to_this_feature;
> +
> +	/* rte_edge_t from this feature node to last feature node */
> +	rte_edge_t edge_to_last_feature;
> +};
> +
> +/**
> + * rte_graph Feature arc object
> + *
> + * Feature arc object holds control plane and fast path information for =
all
> + * features and all interface index information for steering packets acr=
oss
> + * feature nodes
> + *
> + * Within a feature arc, only RTE_GRAPH_FEATURE_MAX_PER_ARC features
> can be
> + * added. If more features needs to be added, another feature arc can be
> + * created
> + *
> + * In fast path, rte_graph_feature_arc_t can be translated to (struct
> + * rte_graph_feature_arc *) via rte_graph_feature_arc_get(). Later is ne=
eded to
> + * add as an input argument to all fast path feature arc APIs
> + */
> +struct __rte_cache_aligned rte_graph_feature_arc {
> +	/** Slow path variables follows*/
> +	RTE_MARKER slow_path_variables;
> +
> +	/** All feature lists */
> +	STAILQ_HEAD(, rte_graph_feature_node_list) all_features;
> +
> +	/** feature arc name */
> +	char feature_arc_name[RTE_GRAPH_FEATURE_ARC_NAMELEN];
> +
> +	/** control plane counter to track enabled features */
> +	uint32_t runtime_enabled_features;
> +
> +	/** maximum number of features supported by this arc
> +	 *  Immutable during fast path
> +	 */
> +	uint16_t max_features;
> +
> +	/** index in feature_arc_main */
> +	rte_graph_feature_arc_t feature_arc_index;
> +
> +	/** Back pointer to feature_arc_main */
> +	void *feature_arc_main;
> +
> +	/** Arc's start/end node */
> +	struct rte_node_register *start_node;
> +	struct rte_graph_feature_register end_feature;
> +
> +	/* arc start process function */
> +	rte_node_process_t arc_start_process;
> +
> +	/* total arc_size allocated */
> +	size_t arc_size;
> +
> +	/* slow path: feature data array maintained per [feature, index] */
> +	rte_graph_feature_data_t *feature_data_by_index;
> +
> +	/**
> +	 * Size of all feature data for each feature
> +	 * ALIGN(sizeof(struct rte_graph_feature_data) * arc->max_indexes)
> +	 * Not used in fastpath
> +	 */
> +	uint32_t feature_size;
> +
> +	/** Slow path bit mask per feature per index */
> +	uint64_t *feature_bit_mask_by_index;
> +
> +	/** Cache aligned fast path variables */
> +	alignas(RTE_CACHE_LINE_SIZE) RTE_MARKER fast_path_variables;
> +
> +	/**
> +	 * Quick fast path bitmask indicating if any feature enabled. Each bit
> +	 * corresponds to single feature. Helps in optimally process packets fo=
r
> +	 * the case when features are added but not enabled
> +	 */
> +	RTE_ATOMIC(uint64_t) fp_feature_enable_bitmask;
> +
> +	/**
> +	 * Number of added features. <=3D max_features
> +	 */
> +	uint16_t num_added_features;
> +	/** maximum number of index supported by this arc
> +	 *  Immutable during fast path
> +	 */
> +	uint16_t max_indexes;
> +
> +	/** first feature offset in fast path
> +	 * Immutable during fast path
> +	 */
> +	uint16_t fp_first_feature_offset;
> +
> +	/** arc + fp_feature_data_arr_offset
> +	 * Immutable during fast path
> +	 */
> +	uint16_t fp_feature_data_offset;
> +
> +	/*
> +	 * mbuf dynamic offset saved for faster access
> +	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
> +	 */
> +	int mbuf_dyn_offset;
> +
> +	/**
> +	 * Arc specific fast path data
> +	 * It accommodates:

Generated doxygen html is coming properly for this block. See generated htm=
l documentation

> +	 *
> +	 * 1. first enabled feature data for every index
> +	 * rte_graph_feature_data_t (fdata as shown below)
> +	 *
> +	 * +--------------------------------------------------------------+ <- =
cache_aligned
> +	 * |  0th Index    | 1st Index   |  ... | max_index - 1           |
> +	 * +--------------------------------------------------------------+
> +	 * |  Startfdata0  | Startfdata1 |  ... | Startfdata(max_index-1) |
> +	 * +--------------------------------------------------------------+
> +	 *
> +	 * 2. struct rte_graph_feature_data per index per feature
> +	 *
> +	 * Start (Reserved) ->   +----------------------------------------+ ^ <=
-
> cache_aligned
> +	 * (feature_enable)      |  struct rte_graph_feature_data[Index0] | |
> +	 *                       +----------------------------------------+ | f=
eature_size
> +	 *                       |  struct rte_graph_feature_data[Index1] | |
> +	 * Feature-0 ->          +----------------------------------------+ ^ <=
-
> cache_aligned
> +	 *                       |  struct rte_graph_feature_data[Index0] | |
> +	 *                       +----------------------------------------+ | f=
eature_size
> +	 *                       |  struct rte_graph_feature_data[Index1] | |
> +	 * Feature-1 ->          +----------------------------------------+ v <=
- cache
> aligned
> +	 *                       |  struct rte_graph_feature_data[Index0] | ^
> +	 *                       +----------------------------------------+ | f=
eature_size
> +	 *                       |  struct rte_graph_feature_data[Index1] | |
> +	 *                       +----------------------------------------+ v
> +	 *                                 ...            ....
> +	 *                                 ...            ....
> +	 * Feature(index - 1) -> +----------------------------------------+ v <=
- cache
> aligned
> +	 *                       |  struct rte_graph_feature_data[Index0] | ^
> +	 *                       +----------------------------------------+ | f=
eature_size
> +	 *                       |  struct rte_graph_feature_data[Index1] | |
> +	 * Extra (Reserved) ->   +----------------------------------------+ v <=
- cache
> aligned
> +	 * (feature_disable)     |  struct rte_graph_feature_data[Index0] | ^
> +	 *                       +----------------------------------------+ | f=
eature_size
> +	 *                       |  struct rte_graph_feature_data[Index1] | |
> +	 *                       +----------------------------------------+ v
> +	 */
> +	RTE_MARKER8 fp_arc_data;
> +};
> +
> +/**
> + * Feature arc main object
> + *
> + * Holds all feature arcs created by application
> + */
> +typedef struct rte_feature_arc_main {
> +	/** number of feature arcs created by application */
> +	uint32_t num_feature_arcs;
> +
> +	/** max features arcs allowed */
> +	uint32_t max_feature_arcs;
> +
> +	/* arc_mbuf_dyn_offset for saving feature arc specific
> +	 * mbuf dynfield offset.
> +	 *
> +	 * See rte_graph_feature_arc_mbuf_dynfields_get() for more details
> +	 */
> +	int arc_mbuf_dyn_offset;
> +
> +	/** Pointer to all feature arcs */
> +	uintptr_t feature_arcs[];
> +} rte_graph_feature_arc_main_t;
> +
> +/**
> + *  Fast path feature data object
> + *
> + *  Used by fast path inline feature arc APIs
> + *  Corresponding to rte_graph_feature_data_t
> + *  It holds
> + *  - edge to reach to next feature node
> + *  - next_feature_data corresponding to next enabled feature
> + *  - app_cookie set by application in rte_graph_feature_enable()
> + */
> +struct rte_graph_feature_data {
> +	/** edge from this feature node to next enabled feature node */
> +	RTE_ATOMIC(rte_edge_t) next_edge;
> +
> +	/**
> +	 * app_cookie set by application in rte_graph_feature_enable() for
> +	 * current feature data
> +	 */
> +	RTE_ATOMIC(uint16_t) app_cookie;
> +
> +	/** Next feature data from this feature data */
> +	RTE_ATOMIC(rte_graph_feature_data_t) next_feature_data;
> +};
> +
> +/** feature arc specific mbuf dynfield structure. */
> +struct rte_graph_feature_arc_mbuf_dynfields {
> +	/** each mbuf carries feature data */
> +	rte_graph_feature_data_t feature_data;
> +};
> +
> +/** Name of dynamic mbuf field offset registered in
> rte_graph_feature_arc_init() */
> +#define RTE_GRAPH_FEATURE_ARC_DYNFIELD_NAME
> "__rte_graph_feature_arc_mbuf_dynfield"
> +
> +/** log2(sizeof (struct rte_graph_feature_data)) */
> +#define RTE_GRAPH_FEATURE_DATA_SIZE_LOG2	3
> +
> +/** Number of struct rte_graph_feature_data per feature*/
> +#define RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc)
> 		\
> +	(arc->feature_size >> RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)
> +
> +/** Get rte_graph_feature_data_t from rte_graph_feature_t */
> +#define RTE_GRAPH_FEATURE_TO_FEATURE_DATA(arc, feature, index)
> 		\
> +		((rte_graph_feature_data_t)
> 	\
> +		 ((RTE_GRAPH_FEATURE_DATA_NUM_PER_FEATURE(arc) *
> (feature)) + (index)))
> +
> +/**
> + * @internal macro
> + */
> +#define GRAPH_FEATURE_ARC_PTR_INITIALIZER  ((uintptr_t)UINTPTR_MAX)
> +
> +/** extern variables */
> +extern rte_graph_feature_arc_main_t *__rte_graph_feature_arc_main;
> +
> +/**
> + * Get dynfield offset to feature arc specific fields in mbuf
> + *
> + * Feature arc mbuf dynamic field is separate to utilize mbuf->dynfield2
> + * instead of dynfield1
> + *
> + * This arc specific dynamic offset is registered as part of
> + * rte_graph_feature_arc_init() and copied in each arc for fast path acc=
ess.
> + * This avoids node maintaining dynamic offset for feature arc and if we=
 are
> + * lucky, field would be allocated from mbuf->dynfield2. Otherwise each =
node
> + * has to maintain at least two dynamic offset in fast path
> + *
> + * @param mbuf
> + *  Pointer to mbuf
> + * @param dyn_offset
> + *  Retrieved from arc->mbuf_dyn_offset
> + *
> + * @return
> + *  NULL: On Failure
> + *  Non-NULL pointer on Success
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_arc_mbuf_dynfields *
> +rte_graph_feature_arc_mbuf_dynfields_get(struct rte_mbuf *mbuf,
> +					 const int dyn_offset)
> +{
> +	return RTE_MBUF_DYNFIELD(mbuf, dyn_offset,
> +				 struct rte_graph_feature_arc_mbuf_dynfields
> *);
> +}
> +
> +/**
> + * API to know if feature is valid or not
> + *
> + * @param feature
> + *  rte_graph_feature_t
> + *
> + * @return
> + *  1: If feature is valid
> + *  0: If feature is invalid
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_is_valid(rte_graph_feature_t feature)
> +{
> +	return (feature !=3D RTE_GRAPH_FEATURE_INVALID);
> +}
> +
> +/**
> + * API to know if feature data is valid or not
> + *
> + * @param feature_data
> + *  rte_graph_feature_data_t
> + *
> + * @return
> + *  1: If feature data is valid
> + *  0: If feature data is invalid
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_data_is_valid(rte_graph_feature_data_t feature_data)
> +{
> +	return (feature_data !=3D RTE_GRAPH_FEATURE_DATA_INVALID);
> +}
> +
> +/**
> + * Get pointer to feature arc object from rte_graph_feature_arc_t
> + *
> + * @param arc
> + *  feature arc
> + *
> + * @return
> + *  NULL: On Failure
> + *  Non-NULL pointer on Success
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_arc *
> +rte_graph_feature_arc_get(rte_graph_feature_arc_t arc)
> +{
> +	uintptr_t fa =3D GRAPH_FEATURE_ARC_PTR_INITIALIZER;
> +	rte_graph_feature_arc_main_t *fm =3D NULL;
> +
> +	fm =3D __rte_graph_feature_arc_main;
> +
> +	if (likely((fm !=3D NULL) && (arc < fm->max_feature_arcs)))
> +		fa =3D fm->feature_arcs[arc];
> +
> +	return (fa =3D=3D GRAPH_FEATURE_ARC_PTR_INITIALIZER) ?
> +		NULL : (struct rte_graph_feature_arc *)fa;
> +}
> +
> +/**
> + * Get rte_graph_feature_t from feature arc object without any checks
> + *
> + * @param arc
> + *  feature arc
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *   Pointer to feature data object
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_data*
> +__rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
> +			     rte_graph_feature_data_t fdata)
> +{
> +	return ((struct rte_graph_feature_data *) ((uint8_t *)arc + arc-
> >fp_feature_data_offset +
> +						   (fdata <<
> RTE_GRAPH_FEATURE_DATA_SIZE_LOG2)));
> +}
> +
> +/**
> + * Get next edge from feature data pointer, without any check
> + *
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  next edge
> + */
> +__rte_experimental
> +static __rte_always_inline rte_edge_t
> +__rte_graph_feature_data_edge_get(struct rte_graph_feature_data *fdata)
> +{
> +	return rte_atomic_load_explicit(&fdata->next_edge,
> rte_memory_order_relaxed);
> +}
> +
> +/**
> + * Get app_cookie from feature data pointer, without any check
> + *
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  app_cookie set by caller in rte_graph_feature_enable() API
> + */
> +__rte_experimental
> +static __rte_always_inline uint16_t
> +__rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_data
> *fdata)
> +{
> +	return rte_atomic_load_explicit(&fdata->app_cookie,
> rte_memory_order_relaxed);
> +}
> +
> +/**
> + * Get next_enabled_feature_data from pointer to feature data, without a=
ny
> check
> + *
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  next enabled feature data from this feature data
> + */
> +__rte_experimental
> +static __rte_always_inline rte_graph_feature_data_t
> +__rte_graph_feature_data_next_feature_get(struct rte_graph_feature_data
> *fdata)
> +{
> +	return rte_atomic_load_explicit(&fdata->next_feature_data,
> rte_memory_order_relaxed);
> +}
> +
> +/**
> + * Get app_cookie from feature data object with checks
> + *
> + * @param arc
> + *  feature arc
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *  app_cookie set by caller in rte_graph_feature_enable() API
> + */
> +__rte_experimental
> +static __rte_always_inline uint16_t
> +rte_graph_feature_data_app_cookie_get(struct rte_graph_feature_arc *arc,
> +				      rte_graph_feature_data_t fdata)
> +{
> +	struct rte_graph_feature_data *fdata_obj =3D
> __rte_graph_feature_data_get(arc, fdata);
> +
> +	return __rte_graph_feature_data_app_cookie_get(fdata_obj);
> +}
> +
> +/**
> + * Get next_enabled_feature_data from current feature data object with
> checks
> + *
> + * @param arc
> + *  feature arc
> + * @param fdata
> + *  Pointer to feature data object
> + * @param[out] next_edge
> + *  next_edge from current feature to next enabled feature
> + *
> + * @return
> + *  1: if next feature enabled on index
> + *  0: if no feature is enabled on index
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_data_next_feature_get(struct rte_graph_feature_arc *ar=
c,
> +					rte_graph_feature_data_t *fdata,
> +					rte_edge_t *next_edge)
> +{
> +	struct rte_graph_feature_data *fdata_obj =3D
> __rte_graph_feature_data_get(arc, *fdata);
> +
> +	*fdata =3D __rte_graph_feature_data_next_feature_get(fdata_obj);
> +	*next_edge =3D __rte_graph_feature_data_edge_get(fdata_obj);
> +
> +	return rte_graph_feature_data_is_valid(*fdata);
> +}
> +
> +/**
> + * Get struct rte_graph_feature_data from rte_graph_feature_dat_t
> + *
> + * @param arc
> + *   feature arc
> + * @param fdata
> + *  feature data object
> + *
> + * @return
> + *   NULL: On Failure
> + *   Non-NULL pointer on Success
> + */
> +__rte_experimental
> +static __rte_always_inline struct rte_graph_feature_data*
> +rte_graph_feature_data_get(struct rte_graph_feature_arc *arc,
> +			   rte_graph_feature_data_t fdata)
> +{
> +	if (rte_graph_feature_data_is_valid(fdata))
> +		return __rte_graph_feature_data_get(arc, fdata);
> +	else
> +		return NULL;
> +}
> +
> +/**
> + * Get feature data corresponding to first enabled feature on index
> + * @param arc
> + *   feature arc
> + * @param index
> + *   Interface index
> + * @param[out] fdata
> + *  feature data object
> + * @param[out] edge
> + *  rte_edge object
> + *
> + * @return
> + *  1: if any feature enabled on index, return corresponding valid featu=
re data
> + *  0: if no feature is enabled on index
> + */
> +__rte_experimental
> +static __rte_always_inline int
> +rte_graph_feature_data_first_feature_get(struct rte_graph_feature_arc *a=
rc,
> +					 uint32_t index,
> +					 rte_graph_feature_data_t *fdata,
> +					 rte_edge_t *edge)
> +{
> +	struct rte_graph_feature_data *fdata_obj =3D NULL;
> +	rte_graph_feature_data_t *fd;
> +
> +	fd =3D (rte_graph_feature_data_t *)((uint8_t *)arc + arc-
> >fp_first_feature_offset +
> +					  (sizeof(rte_graph_feature_data_t) *
> index));
> +
> +	if (unlikely(rte_graph_feature_data_is_valid(*fd))) {
> +		fdata_obj =3D __rte_graph_feature_data_get(arc, *fd);
> +		*edge =3D __rte_graph_feature_data_edge_get(fdata_obj);
> +		*fdata =3D
> __rte_graph_feature_data_next_feature_get(fdata_obj);
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Fast path API to check if any feature enabled on a feature arc
> + * Typically from arc->start_node process function
> + *
> + * @param arc
> + *   Feature arc object
> + *
> + * @return
> + *  0: If no feature enabled
> + *  Non-Zero: Bitmask of features enabled.
> + *
> + */
> +__rte_experimental
> +static __rte_always_inline uint64_t
> +rte_graph_feature_arc_is_any_feature_enabled(struct rte_graph_feature_ar=
c
> *arc)
> +{
> +	if (unlikely(arc =3D=3D NULL))
> +		return 0;
> +
> +	return (rte_atomic_load_explicit(&arc->fp_feature_enable_bitmask,
> +					 rte_memory_order_relaxed));
> +}
> +
> +/**
> + * Prefetch feature arc fast path cache line
> + *
> + * @param arc
> + *   RTE_GRAPH feature arc object
> + */
> +__rte_experimental
> +static __rte_always_inline void
> +rte_graph_feature_arc_prefetch(struct rte_graph_feature_arc *arc)
> +{
> +	rte_prefetch0((void *)arc->fast_path_variables);
> +}
> +
> +/**
> + * Prefetch feature data related fast path cache line
> + *
> + * @param arc
> + *   RTE_GRAPH feature arc object
> + * @param fdata
> + *   Pointer to feature data object
> + */
> +__rte_experimental
> +static __rte_always_inline void
> +rte_graph_feature_arc_feature_data_prefetch(struct rte_graph_feature_arc
> *arc,
> +					    rte_graph_feature_data_t fdata)
> +{
> +	if (unlikely(fdata =3D=3D RTE_GRAPH_FEATURE_DATA_INVALID))
> +		return;
> +
> +	rte_prefetch0((void *)__rte_graph_feature_data_get(arc, fdata));
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +#endif
> --
> 2.43.0

