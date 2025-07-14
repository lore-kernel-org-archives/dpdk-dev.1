Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6D7C83F21
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 10:32:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94CFC4021F;
	Mon, 14 Jul 2025 12:32:15 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 136F4400D5
 for <dev@dpdk.org>; Mon, 14 Jul 2025 12:32:12 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E63lOF001605;
 Mon, 14 Jul 2025 03:32:11 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2117.outbound.protection.outlook.com [40.107.95.117])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47vv90rf2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 03:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os2JkBMAq1sgR1W7J0WF8WnwXeQZT4P0In0TCe49XcX6dRgdjZqtQnSMbRFG6qv/5Ji7FTV35buuGHfIXktVGDsTza9ockBKgdiVh+q382PQsqBXQbxKmrVLOwmteTupZzfcPjYCVmw6lfN5/3U99ZMF4mKkJCGvzWBeXTYwJGIwe8soscwoHxwLIcumhhIug4wCSUl6w3alFWjQAyuNBThpU8cWnEoTBw8T/OJaNngU1Hre4s/zXfvh669MS2RUjlbRW/CCTCWh9MGrpHMpkAP7fqyVVGnJy2qUcyivg2Lfzst6bZ05OeMz41iJ9YlrM4AIRaXIpwnVYI53a6OEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U/c88GxIFdu6HvjQvXWFuOj4EROFbuD/c5xkaDr6cc=;
 b=qWdXqYslprOc4kW0J+zCPKAuHscDX07ww9AxD9PdDtfT2NhpcnNTYadIG2m/MogMFsiMdVVKAOuzmhi3ADhS81x6z+Tt1soF83+JQovc1Gkj+ElB26MUAloZnJLNUxeRyblg4nAafmYHmgJHHlhtZwfyX829tyQU2yxF50Ddn9l5xk/3zCdlkRN961TIcrb2hRRxlK+N53CRvxDzkkozWzIYeg9VvSF5ZwaD2rL6FPLKNHb8bOYXgaqV1CFb7Kiqyat3vGbagzhKb4dPlbZszXWIL2ItaxA8AFlJv4NGo0Y8WOYNJ4xQusAotVei8x8fjP5vw4LpLlgr4bQS5g4lyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U/c88GxIFdu6HvjQvXWFuOj4EROFbuD/c5xkaDr6cc=;
 b=r+YXsL+p+969J0Y05bgO+Bes0oNDtingp/t9d9EbEZr2ZTwtYpyw0Yil3qqlg8rfaBfzbhUXwQNio+6/jizf48iDqs9yNqYJDhSG0WZID30xRkjdS65+0Gf/cXJaZePaOkdZ4DiJUeiRGZEGVRYf/D4wrk8/qgxvSlCZLjg7iWg=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by MW3PR18MB3514.namprd18.prod.outlook.com
 (2603:10b6:303:2d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 10:32:07 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a%7]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 10:32:07 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
CC: Jerin Jacob <jerinj@marvell.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
Subject: RE: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
Thread-Topic: [PATCH v0 1/1] doc: announce inter-device DMA capability support
 in dmadev
Thread-Index: AQHb8XfRKNMasGVa5k2gdx02sHfpIbQtB0KAgARnEJA=
Date: Mon, 14 Jul 2025 10:32:07 +0000
Message-ID: <SJ4PPFEA6F74CA25D96514419D5C2FABB58A654A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250710085101.1678775-1-vattunuru@marvell.com>
 <SJ4PPFEA6F74CA26994FC5A642907B4680AA64BA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
In-Reply-To: <SJ4PPFEA6F74CA26994FC5A642907B4680AA64BA@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|MW3PR18MB3514:EE_
x-ms-office365-filtering-correlation-id: f9887c2d-d3fc-419a-98b8-08ddc2c1aea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bK8zDJ7JEG+RNN3gTQygAlnQ/RffOGnpBQoXXKFe8Y34Wr1mbm9ihfdd8Do3?=
 =?us-ascii?Q?orjvl9ly8SrGA49qfypkkEIen+SWEVL5ojLciSdwi+y0p75rlA16XtxmtQWl?=
 =?us-ascii?Q?WXJXdqCgshLT+g3bEjpFmRe36jtcTlxAJeG+gw13pvB1CWxR9pMSFcbiNigE?=
 =?us-ascii?Q?cRBkP+qRUpci5tybxxBb048hmsIrU3HkrKmVm+e14IARTwqQ8JL0g5vSL9lW?=
 =?us-ascii?Q?AFQIqlThWl/5LlwhDH8xlN8u9Zw//K8YGWiEcdxbYycMTOnGtaunP863BkPA?=
 =?us-ascii?Q?h9f4lGwxQKRETr2i9+E3yrGv/F/yD2YwaX0eLHitJZpmQxESoh5TeEv5hgKQ?=
 =?us-ascii?Q?Wit8r3d3M0+erXyY2095txCYTaya5awoJsBtHD6S/qZPBhqa9n0954XjwCxL?=
 =?us-ascii?Q?uN13S9jqRQYO1uCS78Yrbujc9rwJUOuDmgt2+YeS4vUFME7LELFcBZXfcTVx?=
 =?us-ascii?Q?AMB93m/FjWzfY8vN4lEUtyPKSnCZfuY1UVt7Y6mm7lcC8nNMg/224sUP9I1p?=
 =?us-ascii?Q?42d4daun9Tsf84JFTesTFrg1Ll4rLzcbAJLOb0MHqIpJ19HHhBhTzgp0My7x?=
 =?us-ascii?Q?sLnX2g7qurG/+iS2gZ6L3uz+ORWeryrCGZ/qAL2agIgtjjyBppXCAdA9f7qc?=
 =?us-ascii?Q?DPGd283A36DeFb2n1e8ZGRBeQRgmlTmkmzYuwFiRjgTmF399sQxpb74Fefhk?=
 =?us-ascii?Q?xK/EFwBpb40oqV61R/N+OVsag8axezMH1to9jGcL5LOtapKuPn96zSDAm9wL?=
 =?us-ascii?Q?ti8SL1ilwPoJMSxXwKFjX50o1LQ6RGc+2QStIFHf9vygWVGJEu0eDR5Gk4Z4?=
 =?us-ascii?Q?m+NKDCu9x4ArOXQGJFjOFDEO+YlrpOL19jIo45vwxxgZ4tsPJII3PRiN30Ks?=
 =?us-ascii?Q?wqpWZ7Q1TuCtnmwj/OWz495AIuDrGmkOIcu4HihoDQ4fGtfN1mV6KiY56X+e?=
 =?us-ascii?Q?MregiGGzTxM2uYJ6NmKg4BKF9aF9Z30rFko1IHEnV+ZCOlf4PWWdfSvcFOvk?=
 =?us-ascii?Q?WFPxk0B8M+HYNDuhFvdlNlMkrEFlkdjKr/cXER7Ouwv5Dr0s0SXuF/CRcSP4?=
 =?us-ascii?Q?bccOmmkipC61xPayfhz8Booq6m1cDa7XkHdYMOgNzQPRgrAVueN96j17sYqt?=
 =?us-ascii?Q?UDDrIlmbXRJD35mtcZnENoi+jQ2XhJd+owH/suduUN8GWOYKAXSQuJeNijOq?=
 =?us-ascii?Q?LbVQyHgOnfdhb7fvq/fRG8r/b/v9Db417H7DTaCKbsVmkgloxzJwDRWU9rth?=
 =?us-ascii?Q?DNPou23Qu7K7FjeGBZcvWhdaxLM9dYTRyfAvrKfyGTjakFTWrxDz3BBGy5pW?=
 =?us-ascii?Q?5J/QyZmIMoHbRa1czfqoOckcjWoEXUW1OkFaohB3gfHDlcsU+4Cydnio0/Sl?=
 =?us-ascii?Q?9LnwV/A1xH0g4t4nocOLSoc0tqFrWU1fFMCl4/iollIvTBfH8+NkwMh8x3mZ?=
 =?us-ascii?Q?hDQ7QvgjGgA7aMC9xlyIJAX8SlFq1LZ2khvSdP5SYSs1o/WZudMhGQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ETTDc/Tfi7noEl2ILELxfW4NvWZL+Vc8NV4KNkw7a1LLhcvg7APhsqXEVVw?=
 =?us-ascii?Q?bRMpdKVwvesnEg0oVGf/0TqZYRm5fdU3SArmBtoD8iTjMuWIjtgngrxb/bE/?=
 =?us-ascii?Q?TjcffG1v0FiGdZXP/fa4n9hyZuicCwKEVXt4wNY8dg6AOiBJy2WCqA17uwr0?=
 =?us-ascii?Q?JX12uBBCQs7FeOAPTIhcmQC599HIPj46sO0s+OWTqrW86a7g7G6/jtamFpSn?=
 =?us-ascii?Q?Bd6gnuY+FfqvoFQevE1DYdgJEXDZk1JfiFjobtWqCo1cZSXfrYJt9hd4TGdK?=
 =?us-ascii?Q?/pa9wya2LUACqJr0StYuDqektKSCfG4pSk9O6FY4TQ8BwMbP3bvt9rdQ8nqP?=
 =?us-ascii?Q?PqAYRz6A3LBSC4T/ZrDO/95Ep/a6Zh3qLfQJcdzLui7Ir8TC0Ut+711MrwRn?=
 =?us-ascii?Q?8ONiaDnwqSTEFlDVBBn4SUTJlcaYgf+S2HMKqJCOhXM/oXW/NtgIR9/iqFTp?=
 =?us-ascii?Q?NqI58U4h16B6Agh8rVQWmfNKLJZDrK3J6zQ4sYxDr+4E7laatoJXouT616In?=
 =?us-ascii?Q?pOM8R6hXUoX2IGCTjDOQCUWmSgCTy/DyEl3L0eq1KGpuKwNhKUc0JbwK51Ru?=
 =?us-ascii?Q?qPQ0iYl5vb3kbhb7rqt9lnea4lk9lu7t5kGGZoDrvjSfEgj+oZhavDdvWvgg?=
 =?us-ascii?Q?i/JQDv283g2P832PnFSyaq+S1iz0jtYgDHafCFVuEHtbTHRHkBljbT8pZcbn?=
 =?us-ascii?Q?aDH8/nNPxeYHxlsPm3nBOVnV4/3duPCfSijCVzwn2IFE/250s4HLsWzaBGvA?=
 =?us-ascii?Q?N9TK39hxQJxucOWkokDNfuJ8z+mWhstz0SRbCjAHwpRu2THnO4Q+Lq4E5ui4?=
 =?us-ascii?Q?5jFntDkKMYDlwMQ6SS/txz+3HumkYJe145tiQzWHUeFdCoFyeRLZYFmUePi3?=
 =?us-ascii?Q?X9O+ghQURP4G4qysw+m4OVbPOI01Uwjc/gjNHBjRbn3VVYygaT+9eWC1J8sJ?=
 =?us-ascii?Q?gmLmPbZMSPu7YxggaEvNdD2OkNoX/oZVKmWFJGVLmqH3phvcP0+X6G8aNgwj?=
 =?us-ascii?Q?bV2bbXvy2kWVP246TpiQvNoner0n+hbIKindlPp81PBWiZhuQcGhvl/ez61G?=
 =?us-ascii?Q?xsguzxB/imp6KfYa0Pd6qHAFk5jiDrpE2bIBVNl3wAtLHkhWUusGwLrLjuf7?=
 =?us-ascii?Q?JGjSF4rova3H9Us1ETdAP65UgilZXdLtgGChMx6DW0h9HwJl6CTfij63BmSz?=
 =?us-ascii?Q?hf8LPFPocIZ1RPiYJ3tI93GWchhky7R6iu4e2AxEQqOvHV9PZS94vn/ju72j?=
 =?us-ascii?Q?5fVY5XmiaFRrg0cNvNycO9mYegBVTI9Kcpll7q/1SByhT19KGMKIfATbLQzj?=
 =?us-ascii?Q?5HmSZH07rGlMOdgVhOHx6I1S3upp/xnZle2h8mWkeGwoRTAhTCfQpapbNQRk?=
 =?us-ascii?Q?gR8iYqDcBykqyVQh5/Nu6DbYQy0fTIQJRyWwphq4ys1E1g6/ZX62qKCPGYOc?=
 =?us-ascii?Q?BwkhDbjfo/59fSFToNkczm5n3k5Wsz8cjB+7FGUU4O0DHcfi5NssrM14Qmvq?=
 =?us-ascii?Q?0Vy+FBAU7c3BMeMjoWS8Fgs10xLE5QDMObtchqFUpyY4pb3vKcfgbkLXo8iF?=
 =?us-ascii?Q?IyPj+oHtq79QrHYFjEjUYxvJboxTg43mkhzufT34?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9887c2d-d3fc-419a-98b8-08ddc2c1aea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 10:32:07.0716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGZLXY2XrSsGnabWxy+YK0ciFWLfT1WgYvhPpMXZMSyVVFiH6wiPVyjWyEkU5NRz9rWn4xLZX4btCwrOn7l0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3514
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MSBTYWx0ZWRfX7cjR2G0ISvcj
 vaE0LfOwA8NudANv0uKU3mXpkO6FogcOq5IR/yUDuCcpnUlpMFWIrb2qc4SboJ1q/04zyoSqEIU
 sKfWGIiYdxb1+3ZSYsGqXBcpZbP1wSt1TMcZ7IYgRQQFJgh/B07JpbAU9T5ArfbvsaBAhjM0iuh
 d4jFqA2kfH42FZorkl4yNOKKdeN3ZHVCGIN//W9n8yOO5uNOaapnC8ve0gu04MSyvzpsjpaZ6Qf
 zhrA6cFXwRQj8zTCLBbWjhgo+rR5g6h2ARBupRBN9PLw+O43tXEfQlsc6F0fBXhnwgd535tz8Vt
 /qbuMhDTFj2PCS5/VDm8gcmiXA8rLKOs+0p/Z8WgwU6JV/La/Ox5W+Vemc10aCuUMPH7FQlvC5l
 eN6sCU1opt62XLvfQxfcPmBDa+7wm30XFsXEptWsmlmseULkoPJABz6FL7ZKAKOkvGlhiR/q
X-Authority-Analysis: v=2.4 cv=P6M6hjAu c=1 sm=1 tr=0 ts=6874dcab cx=c_pps
 a=UN2V1A1b7VmuLnaSqJaWyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=i0EeH86SAAAA:8 a=QyXUC8HyAAAA:8 a=n02bokGJAAAA:8 a=bt5KbKNvAAAA:8
 a=XPMsIyPJAxqLADsJhmgA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
 a=rszdq1ld3peujIA30KyE:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-GUID: ELWtwPyCVX5Mv7Je16Yaa5yNr3ZteOGp
X-Proofpoint-ORIG-GUID: ELWtwPyCVX5Mv7Je16Yaa5yNr3ZteOGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
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

Hi Feng,

Kindly review below.

Regards
Vamsi

>-----Original Message-----
>From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
>Sent: Friday, July 11, 2025 8:35 PM
>To: Vamsi Krishna Attunuru <vattunuru@marvell.com>; dev@dpdk.org;
>fengchengwen@huawei.com; Pavan Nikhilesh Bhagavatula
><pbhagavatula@marvell.com>; kevin.laatz@intel.com;
>bruce.richardson@intel.com; mb@smartsharesystems.com
>Cc: Jerin Jacob <jerinj@marvell.com>; thomas@monjalon.net
>Subject: RE: [PATCH v0 1/1] doc: announce inter-device DMA capability
>support in dmadev
>
>Hi,
>
>Gentle ping for reviews.
>
>>-----Original Message-----
>>From: Vamsi Krishna <vattunuru@marvell.com>
>>Sent: Thursday, July 10, 2025 2:21 PM
>>To: dev@dpdk.org; fengchengwen@huawei.com; Pavan Nikhilesh
>Bhagavatula
>><pbhagavatula@marvell.com>; kevin.laatz@intel.com;
>>bruce.richardson@intel.com; mb@smartsharesystems.com
>>Cc: Jerin Jacob <jerinj@marvell.com>; thomas@monjalon.net; Vamsi
>>Krishna Attunuru <vattunuru@marvell.com>
>>Subject: [PATCH v0 1/1] doc: announce inter-device DMA capability
>>support in dmadev
>>
>>From: Vamsi Attunuru <vattunuru@marvell.com>
>>
>>Modern DMA hardware supports data transfer between multiple DMA
>>devices, enabling data communication across isolated domains or container=
s.
>>To facilitate this, the ``dmadev`` library requires changes to allow
>>devices to register with or unregisters from DMA groups for inter-device
>communication.
>>This feature is planned for inclusion in DPDK 25.11.
>>
>>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>>---
>> doc/guides/rel_notes/deprecation.rst | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>
>>diff --git a/doc/guides/rel_notes/deprecation.rst
>>b/doc/guides/rel_notes/deprecation.rst
>>index e2d4125308..46836244dd 100644
>>--- a/doc/guides/rel_notes/deprecation.rst
>>+++ b/doc/guides/rel_notes/deprecation.rst
>>@@ -152,3 +152,10 @@ Deprecation Notices
>> * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
>>   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
>>   Those API functions are used internally by DPDK core and netvsc PMD.
>>+
>>+* dmadev: a new capability flag ``RTE_DMA_CAPA_INTER_DEV`` will be
>>+added
>>+  to advertise DMA device's inter-device DMA copy capability. To
>>+enable
>>+  this functionality, a few dmadev APIs will be added to configure the
>>+DMA
>>+  access groups, facilitating coordinated data communication between
>>devices.
>>+  A new ``dev_idx`` field will be added to the ``struct
>>+rte_dma_vchan_conf``
>>+  structure to configure a vchan for data transfers between any two
>>+DMA
>>devices.
>>--
>>2.34.1

