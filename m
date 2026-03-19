Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5271075276
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 08:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDC1C4025D;
	Thu, 19 Mar 2026 09:31:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 85FF34013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 09:31:00 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J4wxX03902199 for <dev@dpdk.org>; Thu, 19 Mar 2026 01:30:59 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020122.outbound.protection.outlook.com [52.101.46.122])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4d07ws8q6c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 19 Mar 2026 01:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAF487hYzeyTc8rqCUxn13rKys9gYbTHYTEebp+yJq7PjL79nKPS9bTzHKSS+bRslgZbk+O4qPlrYvHwd8ryMPXl/E7E6O+Dd+CJK/Oyoe5Z/I/m3+hS9e0GLFFZrkvCx3OhB4R65zrFE3B3AQvrxMHOkLFRRKZS1m77NysumvYLfFpYjNBCRb+d2/P/vKNo/OeS1JSB4jzXtHNhi1iJfsbc1I4rZrBxE4p+Q+5gsYumQaeQbhjPViaumB3jIv6y5/uR43JPXIxzPUEuZH82Cp404QzYAAaQBgY/gvAcn8XKt1AjJh2s8XBrky1I3EUCBIAgeJ0vzrEWL/NzRniNjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwLZMBmQ+V4FhQwfIc7+Mdm/7taFmUM/hXXYwtlB0oE=;
 b=i8IYtepcD+LhqMXG634bfk56QZLw7nD77KmTDYWhWX5jZQq9+lwaxsqtLuTDfk1+1/T5WEOY1pHlLH1WL1fKbIYMdwMOUTDEU06EAhS+mjsMsoUajhfAPMOhqUUq+ohbuT3M0e/KryDDFMLxf523sfs5L4npqZeK/KzBoKSw5RRX4wsM0F9TZVFFQRhJXWkUCngumLqK7o2F9ECMabr1y00LU18IlLhyFFaBkdj3IVbxMk1CCD9NpFpw6zKCmVdekXFgXEetEk0m93wQAU7c1CFzPfq9xECUFuLb9V3wb+UwZWRJ9Ms0aDyYthGep7fTZaLZmcPw8ovfRmMw5QnAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwLZMBmQ+V4FhQwfIc7+Mdm/7taFmUM/hXXYwtlB0oE=;
 b=ptwQe+bT89IOG4ag9xQl1zuEq+hzMWYqeRZHWEhK2m4tGHEZ/bhtygYevR7BAHzVx0oGnmjGHLC+rQ8D3v9fVHpgrVdhm/IJAC/mlP4acOrClTjhMHpohrMYmCf/gA4DZz0eP7gwJWv0mJWvIZesKECNCTB4iV+yF0kPOzZKcuY=
Received: from DS0PR18MB5270.namprd18.prod.outlook.com (2603:10b6:8:121::22)
 by DS4PPFE545525B3.namprd18.prod.outlook.com (2603:10b6:f:fc00::aca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.36; Thu, 19 Mar
 2026 08:30:56 +0000
Received: from DS0PR18MB5270.namprd18.prod.outlook.com
 ([fe80::c600:8d39:803d:d08c]) by DS0PR18MB5270.namprd18.prod.outlook.com
 ([fe80::c600:8d39:803d:d08c%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 08:30:56 +0000
From: Nawal Kishor <nkishor@marvell.com>
To: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: Jerin Jacob <jerinj@marvell.com>, Ashwin Sekhar T K <asekhar@marvell.com>
Subject: Re: [PATCH v2] common/cnxk: add NPA diagnostic and performance
 counter apis
Thread-Topic: [PATCH v2] common/cnxk: add NPA diagnostic and performance
 counter apis
Thread-Index: AQHctQ34fPqef3B3zE6827j5HZCe9rW1isNx
Date: Thu, 19 Mar 2026 08:30:56 +0000
Message-ID: <DS0PR18MB527043A961B565998B9D139CB24FA@DS0PR18MB5270.namprd18.prod.outlook.com>
References: <20260316055057.4174060-1-nkishor@marvell.com>
 <20260316062720.4181631-1-nkishor@marvell.com>
In-Reply-To: <20260316062720.4181631-1-nkishor@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5270:EE_|DS4PPFE545525B3:EE_
x-ms-office365-filtering-correlation-id: 7aa33e93-067a-4b12-5fa5-08de8591d737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003|8096899003;
x-microsoft-antispam-message-info: QlXELzNwibGDg/AhOdj4hNJ00Eo24OZFIdsAssp0HFiLeAHj+bC+PhNzTTU3zrRzR1ADDS0Y865BOzO5PFS7atD9jpYcaJxJrWWUupOkU878AyfeLhC9+PTIiKpGcaf4Cd8wVRIqV8SUv+3HEz27A1z/HtPevepPJ6hLX9r+tnfx+WZ8xNxA8Ol9bkFnExovzMAm1Suj4od5WQNy9f6AFQf6E2ogNQI8ERDwkFQSg0i3Pvf20hVnZdAYBzN++w0iE2nv6VMurTI/DiV+JFLnouNqn+niinHhqPnnRagdQk9leQEh6ILnRnOe69ATOpoirCRdrGsnt8CTast1JrwOWSgRHD5BzFIK1Aes4V4xvZ+9xkZllmzL9Mm/CovkIgVsvIh4V6iFdBYovRxQ8h7GAbWdSSEXk+AVB2ijnOXQHEvAkcbfLK8Ho45Nabk1s5KFu/sOrBiOQENxWGicMq4t9+5lHpaUGm2GCIapOy/jp5KibEP2IR7CTpJVcJFIIzLHnRRFoIJU228uCJ4unfr9VzwFXTSLhSHWeHG+lradWZy2fuGQrsTVwSmhfjO0sT583YHtdNL1J+fyXR8w+x/VfTxbae/Y0jKMTu3sCjSZTc6+twTJdbF55pLK/9Dco+9PPme1x4iXNRU2ig8NHwDxqEPRQ476nT9gixR7VPWjB/FRlxE8ZdpZQ/tNjfwoeML8F+oc9vIU7420bCGnVMrsVFOmFq2KCX0cUK/7VbslBYTIWPL2WxpAIqTb7xUuAFHfhMH+Ewdq1lrwA1XbjaPfHGJCwRtb+4RpfVhNk/8T/Rc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5270.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pRD+z9UsDFwlK/DTvOnq7ryIBaUWKum4CMIZt8mZq1fibF4Cont7tARFhosG?=
 =?us-ascii?Q?zbVS7T7IsnBLsjt3V2tefZwwJbQO0IxtCYig7gvuLqJNx7+pqAYk7EN4tvUB?=
 =?us-ascii?Q?xwuCS2IPuxxf16VTe0NMnCOCBHjE0quwTReFQeGzDGtgNVIyEnU/2zRsC2uU?=
 =?us-ascii?Q?4v0+TuHYlVuiRZTpLrZG8vd7/Wh4yHf4XFEFzSpgQYaVzMrlrFwb+QrLiXth?=
 =?us-ascii?Q?CsyyhDzHCpR76PbDIunUTOZnxZVuoY3T4f3cKxy/EX1AYyGfd3gnJLPNjExs?=
 =?us-ascii?Q?gFE+RqxMcqgKWgHaGB+2HcqfWD3wXiQ6zrg0s7VxGvhRfmUGTwPZUuXUamRI?=
 =?us-ascii?Q?lyp35H8kXd/q3Vy+6Ry7qpxq0I/SG082vQupFACcNlcP29EjN84q0piU6jo8?=
 =?us-ascii?Q?/BM/tgfe7uLIefU+iO4HG5rzA3jUks1j4kDwf68sdXZLSHptj38OpOU0yd6N?=
 =?us-ascii?Q?5Jmt/Nn38EsVFwilcRAdnnZhZmC7MMVxiFDDsCcvZV8zn+cf22IA4AqRCZvJ?=
 =?us-ascii?Q?LY00mmbX0Q53oH5uQCyXuu19cytpM8ubszOGMM2SbpitgxYAj3uV1++m3Ee0?=
 =?us-ascii?Q?pQ3rZzt3DdPNyUspwopcZ88L0Q19J9YSKggifuhemVVjUw8MD4LXEwCmcH/O?=
 =?us-ascii?Q?UV3MyNntiIVW6GYofz2iNG+DJCDEJkw2bf/bBh+KOyA4N78+kyobfqBV6x2P?=
 =?us-ascii?Q?j9lnjuvf+1ew/8O+SRu1LbkVZkzC+kDvEMZ975jqCa7hT1yXfDuSlnpkoFRn?=
 =?us-ascii?Q?93JLdWC+wTgH6TICqp6+rVHQDULicnxsgMaHVEXi+/W1T1dupCjZOy4XdzQa?=
 =?us-ascii?Q?9vvCiPDqAxSbprY8PuaKr4k0ZWdnOirr7WWLBGHdGJYCorGoitMQuEtheIAy?=
 =?us-ascii?Q?cKSTFzNbvQiBAqHdvCG8Zh/lQTLOqIQcIptA2QW+ZwDd9dwe1PRAX989w05R?=
 =?us-ascii?Q?8mQhHC6Hq+L2A3qsKaQOyDmLuMGEPTYF5FY82IMIF+tvMolsy9uchIEHuIs0?=
 =?us-ascii?Q?9eMM1hw9OaNjFGirh8D3zmUSKREa9BjcbLLgqnECOYJfE1DU+KmqePXoFR4M?=
 =?us-ascii?Q?V2T2jF1QsK/YQZufEN6WC6N68UeO/xwwhos26QKiBDqgShdID26zGSjmpbHI?=
 =?us-ascii?Q?AXRCNe4FZiOoYiXNH+xDdZOatfY3DiBozz278L6tyq1vURO66JhbPYvFI9lO?=
 =?us-ascii?Q?wszDb9eUuyM+MX3H9RcPNz9PnSqBDYCz+LOLcDpNEav88eDHU7MXaIRjxPGx?=
 =?us-ascii?Q?YoUUiyY5SI0Sp7R0AmGTXztFFDtK6gu1olT61/CROUnSBUNHR7Tpxnlja4bb?=
 =?us-ascii?Q?M+3hQ4BlhXwl0uCGrkhWtD71zUzNEqFYc8wuC59vEH/J1gRTSwa9fnItYbp7?=
 =?us-ascii?Q?sASzrYIbac2/UfoAydqxyw+U8MX5AmYVQCncblJIggQX2UrB1Mr9wYxQ0Vph?=
 =?us-ascii?Q?fGLLF5MpVD/rz695I7feX5gdG6/1CfOS8EU3f033c0zEB6vGckBkTp/z7Nne?=
 =?us-ascii?Q?pjUFEhI4obG6H7R1FAyYBuTm7MVuqsJObh/C0NUYzPZrd6i5E4gTYxgeRfM3?=
 =?us-ascii?Q?Q1fvYuBTXEgs5QHAeptinddciwRNj19YPoJJvSe7ysQC1nC/l5Kv1rRiUwXT?=
 =?us-ascii?Q?aXmTutW1BL8dJbtsW0/hY7SphEFrf5RLezOZrjcS+2Kvc6ZkUAPyrTEcIImd?=
 =?us-ascii?Q?aGBXZVWpCtzeASn8hOzV9AbvWznwLxtAuQvm7i16xAC8kMl4jRKe2z1r4M9q?=
 =?us-ascii?Q?Em2bVNHG/bYCzSL/734o9VfR3DnzL/Y=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR18MB527043A961B565998B9D139CB24FADS0PR18MB5270namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qYXmQfmIlxFjE6ybFrnO5O8MQ7OvV1VDUGznQc1E7IHfeNY5cDaRYPzePgpPrZcAL7LTaKAPwRy1ucmK5/cbqWyR5Xb6m50v+MJIGZmVayZUYDgjEK7QuxKsba/IP+DMVqS/+bLnlKzwZ12MPN8x5cF57McoqC2xRTzWNJ0ehiLXK/B5nbYn7zY5dlBu7C+eZ6geqYmEhE8nfqPWOBZIw5todNlMZ/CLy4h3NeRZe4lf0mw+j2xDp2e0N7ICsxlwiAt+4GVcu0hZZVovSIw/cdrELWWLF3R4eAoProDid5OkP3FTgzcrYMN2PuQC0UWIA4ZFNLErFJBkL0Hn0ZxDnw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5270.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa33e93-067a-4b12-5fa5-08de8591d737
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:30:56.0318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1cGDSQT60JI04L6O8ay9MK7/SjFcJaiI+FHYBQXYDbxz3Ydi9b07n3A6kFWwWrTYkj8596yNx2Ur+Ngbx+tfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE545525B3
X-Proofpoint-GUID: 4D-II2dN9DBq2p-mAqoKZh1MPsCbzj5A
X-Proofpoint-ORIG-GUID: 4D-II2dN9DBq2p-mAqoKZh1MPsCbzj5A
X-Authority-Analysis: v=2.4 cv=Wrgm8Nfv c=1 sm=1 tr=0 ts=69bbb443 cx=c_pps
 a=Ov5XJGn/dQMl/+TwTE/lXw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=5W7IHyGpymY4uLb6zvAA:9 a=CjuIK1q_8ugA:10
 a=l9qecpKRrcOf3WzlyJwA:9 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA2NiBTYWx0ZWRfX79oYal3Q3mRK
 gSKMtb7mJqHVAK3pX0qCgdtELrroV6bYyY0p8nfWsHxKspTVOPpTk2UluFQkj5D1z8aoe7/KJl0
 xXgnPuLJiqseFwU30YNTbxKZF/+0TYYRIPy/zh2LNNsXB61V+6alZEDgZm8TGpIj2Q43Q0o6Qtg
 WDRDc7QYfZOY78H/Ut+l/bIzIZVDuzwG82IgU87NilyVQPfBjJxBuIBrVfAve2CMQg46VnzU/i9
 5HN6T5OEanx+4Y8KyK80acn3zCk/zgXF/NVbWvpWiUHzEdKvAKrn/yIpJPGZY0OOzVOoJj6RQhK
 /K+sNSEpdLgmw5J0tOyi9Re5DnswnURvmO2Vj5IOnDoZG5kXi272hrhMDhWR95/ebG7DrxcsGxS
 mNRSQZaX+VPHQaBSmvu20eaMzaOmU1yfZ5x4CPo49kPEW89du0wbLOkHaGlt6Y44jxpGSQ4Bm2U
 FQLB5IaKy/g5lfGwIBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
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

--_000_DS0PR18MB527043A961B565998B9D139CB24FADS0PR18MB5270namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-unit-arm64-testing

--_000_DS0PR18MB527043A961B565998B9D139CB24FADS0PR18MB5270namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"direction: ltr; color: rgb(0, 0, 0);"><span style=3D"font-fam=
ily: Aptos, Arial, Helvetica, sans-serif; font-size: 11pt;">Recheck-request=
:
</span><span style=3D"font-family: -webkit-standard; font-size: 12pt; text-=
transform: none;">iol-unit-arm64-testing</span><span style=3D"font-family: =
Aptos, Arial, Helvetica, sans-serif; font-size: 11pt;">
</span></div>
</body>
</html>

--_000_DS0PR18MB527043A961B565998B9D139CB24FADS0PR18MB5270namp_--
