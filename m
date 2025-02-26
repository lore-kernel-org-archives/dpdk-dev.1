Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D10C021A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 04:20:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E9E0402E0;
	Wed, 26 Feb 2025 05:20:44 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9F9EC402E0
 for <dev@dpdk.org>; Wed, 26 Feb 2025 05:20:43 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q3snts024318;
 Tue, 25 Feb 2025 20:20:42 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 451u6f82ah-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 20:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipzeUmLYvoMFb6SiWxXkZY2yhRW/MRWLlMrIuMh1WeMch99qlWFl6iJOrJupeG+BSRnWvShT2YRc0g0sQAf+W5HywGQaTOdU56v8kVuljaXC3EKWpTrZa56s+M5tLWPb2otTfGeHMa31Zt3zUH6ruoDwLz7XyUBTGVOEl84NxLEIH7bwvClYVlKvd5ayoXqnS4el32jSzS+X8Zw+v4as2Ucs731wjutryLPemU7P4s2dnzfP1RQyTrz2WVtxUYshswFHcATLXF+J6XY3FLGsr4Y6rlbBA+zOAgbfIkerRnFm02jOI2uss5lxGCcAjNn5PGgB7Df9nuYoK+blAng9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ux7Wf3vQtOM1Kql6UdYZH+PbT3c274gvLUczsxyICHA=;
 b=q5WjjJF5HUc3x4ZBaIWZT8qQXSRqVbjcQIVwbwulWjBiyjWftl+jrbW/8n2smEkgmyKhZfGkQ/0dh1SakgvKnMHtC4Ymsavucw6O8biS2Rplh1cK8Diqojyq4hWYE8G7tm6rgWXEgTETw2xFtr+fKoee32Euq3ryPgRnarwR2qw1IT/+tqJpNQMeMuPrm/sGqP16R8+oektDS+eQdwaFZEBd4Y2muMnr1VkDOcQecLT5jgx18fOsltRlZgYeTQPSnuLduaPpUzjRnrq9lTC0Mrv/LuIvaIUG9mRUL13tISQlYfJWLt0IwsFIDYUPGF+fyuh1RIyrTXhQhH3gpc3MrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ux7Wf3vQtOM1Kql6UdYZH+PbT3c274gvLUczsxyICHA=;
 b=H5GOoQlgVVzTb/sk/Cc84L6E5AFHS9Z4TKQV2QxCDTMVxYfZPQyo0qfjsJ4OYfxHt44V2Bp/ByzOfApbnngey3ofZm5Zfc/1t8ht3Z/GGIF/+HoNAePNrvRTVPL1a9afvCP8XsIKraPK8ArDwvAMyGdhQYv+QAEmo/yBz3YH894=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CH3PR18MB5860.namprd18.prod.outlook.com (2603:10b6:610:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 04:20:36 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 04:20:36 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>, Shijith Thotton
 <sthotton@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Shijith Thotton <sthotton@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>, Naga Harish K S V
 <s.v.naga.harish.k@intel.com>
Subject: RE: [PATCH] test/event: fix number of queues in eventdev conf
Thread-Topic: [PATCH] test/event: fix number of queues in eventdev conf
Thread-Index: AQHbeKwxzc9ASs76gkKEI/snoGvYfrNYGwwAgAD/EjA=
Date: Wed, 26 Feb 2025 04:20:36 +0000
Message-ID: <BY3PR18MB4785F4EDDA9CEC4E394DE497C8C22@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250206143244.524451-1-sthotton@marvell.com>
 <PH0PR18MB40869C8BC5E4ED5502E6DC19DEC32@PH0PR18MB4086.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB40869C8BC5E4ED5502E6DC19DEC32@PH0PR18MB4086.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CH3PR18MB5860:EE_
x-ms-office365-filtering-correlation-id: 3705e57c-c1ca-42d8-4d68-08dd561ceb6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KY8qIrKcD1sxPGSYiCelAdqwX15VTf3m5tG2R9oo5+3IbyzOxDFvS9+8efg5?=
 =?us-ascii?Q?gxrmydHJj162carDvtKKlckIewA83/cFn1/7MyFkGMb3aR6rB1xI0olyztw3?=
 =?us-ascii?Q?kW2Q67m63jGwwwXJMrmGu5zzcbAFiX5rjYw6YHpRs/nGg0ml6rXDlKjgG8Mc?=
 =?us-ascii?Q?IIuINR6qMAnTHjTosXsyptKLSAQyOwbsrfDen3njpRPZn3QIhZb+njx3KMWH?=
 =?us-ascii?Q?robzhJ1WAcqnLTR/JEYzBYv0SABC22nvAhLDWtDydeZddkvadArWBQaOGXIS?=
 =?us-ascii?Q?W0NvuMIQRPZzzI7f3my9TE0hUKQ3Y63OlsgsW9WJJsuIi0kSWP0MFb0cwwPy?=
 =?us-ascii?Q?McQfBXHCnY/xjjjwX1axQYn1qUqX9gXT6mL0TvgN77ep1JaLP4QJAVyIUvJA?=
 =?us-ascii?Q?8WJWx+IygJgzIopQ1DSdDDArEcvqHVP3BWwi9U4EbVDE093zrQ7E+t1UMR/8?=
 =?us-ascii?Q?Qw4wC86Pw5FSP4kCQCdDi5VIoStmRCQIFXGlRPgD/7VqdqLhgKgO8kPLZJ0/?=
 =?us-ascii?Q?V4z0FSW7zIv20uj65j7dCYE9repTAAjvLt7TlVvAdhT8SrYi+zJaZN0uCMOF?=
 =?us-ascii?Q?tnPQFyxKQyYkget9MNJzA2oQvqRlSnzZFqJgvqWVrwCYo7Kx213pJ0++UrBr?=
 =?us-ascii?Q?UV4pHC9aVIpCVA1oPXbtx1Ksey6DtntM5zzAYXgZ8RVfHPqriv016uhX6KLu?=
 =?us-ascii?Q?bL6zUSWImgMOu5FHc2t65DReG48rLZVvNHmS3KK4RQpDOQE+3HnApGrZ3aKt?=
 =?us-ascii?Q?UJ/jvVwTzNMtGUoDiu3hnJEo0LofdCTtPBMU/+SJ8VmYi0ra6xc67tmeEJ31?=
 =?us-ascii?Q?HdNB0yPdw4Dr2yQaoBEFRg+31MW2C6WlQbEQS2uwQanEL3QYz3dNyMtppQ2g?=
 =?us-ascii?Q?N+XAWmKMrSymNAclc0JZBrSfOaKlKPVZY+hb6E5N+E1w+41KNEl6lOs3M/yL?=
 =?us-ascii?Q?122ouuI2YKYhwNeC9Ygt67Z0J/usJia+fCIhVzZw4GEutXsjWOHbv6FptTQ8?=
 =?us-ascii?Q?ysRjuqNMqaS9qGc1nmJfpt/+f5NjBEeBP+ZaUJ/z6BiOHzErgJRhJX+R9hqi?=
 =?us-ascii?Q?fspaVrCzPSM1ebbr1NWJ7FVPckUuYyIgg/odbPa4q5eaqdw5EFp//Ysplr2/?=
 =?us-ascii?Q?Ns+JiWYCj+aGpnSKE4i4cS9vvtTRrzifD8ma516hAWDgDLwHVKn+nRC0ywgG?=
 =?us-ascii?Q?b+UXF6kdeKrPY1yPjtm+bYWlir7iRby+LWHjdeY5ho0Uj/cH5/rcUGIOrKXN?=
 =?us-ascii?Q?NM1lxHbWOWrw9KicacG2q/rnkZlnxgxB8TJBPCxuyRAJhKygdGT7GKd23Ew/?=
 =?us-ascii?Q?WCH7mLpskbELXAIvKX41/BL5NeMUmliPRb3vIol2e+b6zyhKE+ePPPf1AG2F?=
 =?us-ascii?Q?uHslfXF+YCeD376AmTkO6Xk4lmDlBsTrRlF5D/Tvq5smj5id4y43HjevO2G0?=
 =?us-ascii?Q?ryD774sA8t/Q0WuRdv7coXVmlfwQOfvW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iDQEWvzx3ARmAWiWCJ9NGkZOKqKnlHdpsKsFw00FHnoxNQinvPXLnhYz0DCg?=
 =?us-ascii?Q?sHWI4yN2L/TG6D9Jp5t2tPaLszeEhd90GP1GTtNyG67eO4PVm27wqqnL5g6U?=
 =?us-ascii?Q?odXiWxBslhYxB90nH8PEoqn9Ov5GpRmCuLVlhQvkzjP5JOUu1gjU+BKz2CAO?=
 =?us-ascii?Q?PYBHlIlYaZ1KGQieyPeBdR2/T2ta9NWkCXWSyM5LKRmxC1rU5kQj/w19jGaY?=
 =?us-ascii?Q?WPqCpoffEqW9E+AdUZqqR7lEJUtecMRRkWPr7Pl86ZkG3AD0/lM7lvBcXeap?=
 =?us-ascii?Q?noaxWC17lqGgETbpljG8uiVFAKrPLASQk8FMGgcEwlPGy2lfqMZKXIz6WDdD?=
 =?us-ascii?Q?UgYRnX+fcWRuYVBNdU3fgg89d1S2TLCcfIVcnMZ+aKAkD4ZHiAY4qpjVO+h6?=
 =?us-ascii?Q?zTwZyRC41FGCETuykhR6IoJtawSI1rdOMDXdVEBdionYEGhdWhFjQHjDHYHl?=
 =?us-ascii?Q?7E/ofJmZ5zT8XOTeAu3CcZZt4ssikObxQF8ZhGF2NIqSiKn9xm33vXaAcBqD?=
 =?us-ascii?Q?3VH8fNEmJMmJVAQb2EprlzRCYY/8JN0fY6Bdc90Q59G249S+jIB7+IliAOLL?=
 =?us-ascii?Q?GQyowdrgZaFDUjyAWN1DpFZDpUa3RIizEQA9lQF9yqmbak9rB2dWN1qIQjNB?=
 =?us-ascii?Q?0vrR+dEJMDN4HSYcYktFLu18bPB0AHVjvi2DJp7G5+PeTFjrxs2kElVIKax6?=
 =?us-ascii?Q?+R2SpRz9wMYmFFsJBC6iK97tQppl8s3KD+hx0fK16xk+XZVMY/uYf1uUYRP1?=
 =?us-ascii?Q?j2kBm+W9qzL6GG2OzdhDgcZBSjYZD3O0DfhNO5hW6mRoBJ6798DFnJVLDC0W?=
 =?us-ascii?Q?THWJ5c1lUf0Ren8UMvQlfKvDq1niK8mC5zQmU05t6DYjHqIOsaIetWvybDuA?=
 =?us-ascii?Q?A5Zd/P6GKdRHKMVXCZC4LreTHq/AsY/XLGItCdbGUsXigF3fXJ2KfzF4NnQD?=
 =?us-ascii?Q?myvGPiT9RdGN528ZXwpFIf3onMEh8ZoGGzI6RTZwGtFc0C4TQn795lBogP97?=
 =?us-ascii?Q?0trsrrrILlgjHr9ndBz9l/8xgeK8mACXmXvY1ZvUpi+0pN91LwfNV+JR3UEG?=
 =?us-ascii?Q?i1eX31do6tvNa0SMx2xZvQJQ8VWwnWsTAZbGoDS3ve6oTQbC64rqtIrFJw6u?=
 =?us-ascii?Q?PZhgKoupeQFDrDkgOxZOLHTYGw1EDzDBo41bbHpzSAaN3Cg5jPVLD5LiiGQI?=
 =?us-ascii?Q?O3C3/iseWctivaMKUNN9JFwUZkLRPSXH8LE8Skmi/AJiExpAHMFjLb5gSZSb?=
 =?us-ascii?Q?rSJ+JnylEgiKnJ6dSTWTqW9m8xp/2Uobpl1jfHItBLrMJo/cfTtOCwsc+mSi?=
 =?us-ascii?Q?zodHiBj4OdB5Tpkukht5Ql0lZAKVl8doX8Lmo5cpxt1gk9oAYPAvO1PT74RK?=
 =?us-ascii?Q?ykJ56kgtnyfnuWL3JF44rtGLmcAsPDrj9/nGwcshVfJfzYo2hCDFMmLynKMw?=
 =?us-ascii?Q?Fxz/YgLOWYaT1fgPGwhLEw6KqE0WadSFgSO+0RXW0Htqy0OGqgkoArsElLr2?=
 =?us-ascii?Q?z8NB2NsGt01m/GTFER1cIXTT4rSgOYY+x8ZurNF0Z/mJPwmhf3BnncEzvSKL?=
 =?us-ascii?Q?8ySMDc/OLFRVxUoibJ1gBuqzLis/JcPVZ+Fmic0J?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3705e57c-c1ca-42d8-4d68-08dd561ceb6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 04:20:36.4923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xa2y1GAkG0+hsW34LyMpBlGresQhbdBfp1t3eWK/waLoxSE2wbicxGSgbwYAUTrsyFG6B/AP4mc8CA4XPP+PnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5860
X-Proofpoint-GUID: f3SZ8Mf_oU7yLk8rGtXj-qtqVf3ZSZl7
X-Authority-Analysis: v=2.4 cv=TJu/S0la c=1 sm=1 tr=0 ts=67be969a cx=c_pps
 a=6L7f6dt9FWfToKUQdDsCmg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=WsIZw4YNJ5f5Cvnnf5IA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: f3SZ8Mf_oU7yLk8rGtXj-qtqVf3ZSZl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
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
> From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
> Sent: Tuesday, February 25, 2025 6:37 PM
> To: Shijith Thotton <sthotton@marvell.com>; Jerin Jacob <jerinj@marvell.c=
om>
> Cc: dev@dpdk.org; Shijith Thotton <sthotton@marvell.com>; stable@dpdk.org=
;
> Naga Harish K S V <s.v.naga.harish.k@intel.com>
> Subject: RE: [PATCH] test/event: fix number of queues in eventdev conf
>=20
>=20
>=20
> > -----Original Message-----
> > From: Shijith Thotton <sthotton@marvell.com>
> > Sent: Thursday, February 6, 2025 8:03 PM
> > To: Jerin Jacob <jerinj@marvell.com>
> > Cc: dev@dpdk.org; Pavan Nikhilesh Bhagavatula
> > <pbhagavatula@marvell.com>; Shijith Thotton <sthotton@marvell.com>;
> > stable@dpdk.org; Naga Harish K S V <s.v.naga.harish.k@intel.com>
> > Subject: [PATCH] test/event: fix number of queues in eventdev conf
> >
> > The unit test adapter_pollq_instance_get requires three event queues,
> > but the test suite was only configuring a single queue. This patch
> > updates the test suite setup function to configure max available queues=
.
> >
> > Fixes: a1793ee8aba0 ("eventdev/eth_rx: add adapter instance get API")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied to dpdk-next-eventdev/for-main. Thanks
