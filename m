Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EFC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 14:49:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E6B440E0C;
	Tue,  4 Feb 2025 15:49:00 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E64A240265;
 Tue,  4 Feb 2025 15:48:58 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514B8IBC012340;
 Tue, 4 Feb 2025 06:48:58 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44khrq0b9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 06:48:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/0EGkC83V6eOiczn+FN4VI1EHuM80XrUx1Igb1yG3DzELX7Z41z3G2AuDLxewyfnU2OYm56x9Sr5fdaznvoyW8wo1aR6I8u7+CslqEPS7PeiYC7YxtT4LYQzbRntOuxj+eCKugAvaoH2GAF4fPZA78Hgjd6+HypnwCn+yH4a2ps4fCvlvlotDTk+eiNnQgO/XVNUIDjdkCuFIQWStLFILsn2GhP3p1YtvWJ5NfMceREtWhKseGzRh9qnlF2RbY74fMw6bescEXg8Y3TnPJH+PHcSlOHS7A46cFklJNxI4PLvG9tYEdrNhqYRU+HNeqpKf+cCLi8SZFx0ZQobWeomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejAN7wj0abQ58Hrx2SXAmcWDqj4IitOZb970Dcu6qZg=;
 b=DZ19T1fXgF0JKJ3vLJfjyR/PplthFfyFI7LzGIH3oD4tBTj+EQbO7eXzBn5Gf6laOYcLbagj5ucIXCLfPaX9/PQbP6VimCmzbHvbrHzm8Ai7wazfxzMee8OcQ6bse2Vc7W9zln4dirWKle3xUDF/7OYx6RUsrq6X05pd/+Llu+fr7KQb8lCexKyYdmObtAMMsvTfl1vSJQ4tuUYg+71XhdV1CMPwGXss7j5tha5NM0Rs1l4iSZgnMLBucziPjfK82pjI2lpqRUpq+ME/S1B3gfgcYg8XsjlZilUJRhoSbYov/cpBk4AeQLLZGebzGftqrmyF+ktN7c/ykv5WBkoJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejAN7wj0abQ58Hrx2SXAmcWDqj4IitOZb970Dcu6qZg=;
 b=G/KW6vcGGtDC7hf6+TwGMdxUX8MC7d4SGN2P/X5tPCaZ621oCIdjYeA0goU1NKidlGRSYte53Sybu80ylEBmwMzI5h33Dxb4zYGAW0E2jISQ1I+ymwU/tAnD38MHP8iOqGQCn1oBYcarQwDcD1AD2m85Vg2K/Ub+QLZS7iEiu0c=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by LV8PR18MB5656.namprd18.prod.outlook.com (2603:10b6:408:182::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Feb
 2025 14:48:55 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8398.018; Tue, 4 Feb 2025
 14:48:55 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Pravin Pathak <pravin.pathak@intel.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] event/dlb2: fix event weight handling in SSE
 code path
Thread-Topic: [EXTERNAL] [PATCH] event/dlb2: fix event weight handling in SSE
 code path
Thread-Index: AQHbbCekgzPWAViE/UCqp+uvyShT4bM3T1Zg
Date: Tue, 4 Feb 2025 14:48:55 +0000
Message-ID: <BY3PR18MB47853A78FE3A852761E61B3AC8F42@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250121171135.2705818-1-bruce.richardson@intel.com>
In-Reply-To: <20250121171135.2705818-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: pravin.pathak@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|LV8PR18MB5656:EE_
x-ms-office365-filtering-correlation-id: 9b2596f1-6bb2-4775-d64d-08dd452b0cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3HSExC07WuDkFyvO1fLgpBnA5sTBEXkoJgTICetjFFQBar/TFgR3WygFwE03?=
 =?us-ascii?Q?9YQEdV4+FF5LwAZJzQhEqykupoSFz/JXc75dqVomDQImXo0O4rUVNjHhh4th?=
 =?us-ascii?Q?gKsxcSqQstbpV8la8IvyW3ckrkow+S+hNOoUn+ApeRfokJnwr5wvOSY1iVm7?=
 =?us-ascii?Q?52PmKP26bVjn3++zUtCySsYUtr+Nr/i8fdaryZYrAQPN4h9fg9YN9TQsI8M2?=
 =?us-ascii?Q?B7UTIujr352unt/Pv12Z/dAgy/n5DxZ1FqGasfGSEz8JJUFl1Ww9L5m0hpOa?=
 =?us-ascii?Q?KIeNdLMaIpzz3bfyF+yA7QjRLhvdqVA90P0oyiEy/jO9VFyjTR9MZ21A6Apt?=
 =?us-ascii?Q?VBKzKx3QOtaquI3+hJOdtk8yUvC+n3atE2BemliX2ERm/hfbjb3HBMXVOLyX?=
 =?us-ascii?Q?NckTe3igCz/brblXjTiQlZrA4jCJZGDJPm97NvHg+pv2oQ+p9aS0HIsIPMOX?=
 =?us-ascii?Q?nBQ2r9HtMSigm07wmnREQ/uWFo6eh+OfPZAj3vkMggUDdI2uuXki1ENoUlAH?=
 =?us-ascii?Q?uF1JKCEwNtMKPNx6XfWrlZtsQjVcXU1B1+IVKoWRdrgOjz4mSn+c1bcpI9w2?=
 =?us-ascii?Q?LLgzxSdUDYunT779+c3Fgp9YmmeQFxZ0OO9pA1auHIA1Lz8ROIRPCmgg9pey?=
 =?us-ascii?Q?Fz5HcNGEJPtfXHTqnP5WAIa/ZL4SlQx8qgiTAsK3szfnBeKNJW2DWd4MWlwU?=
 =?us-ascii?Q?QDmhsRnQ1Nte5j8w0MXY2JBq4jD5I/pcpF73jlCfX+LxIiOd/pHnA02VYKN4?=
 =?us-ascii?Q?QVG2jvxZdN2wPZciSiGAl+RUnIhw1kpMqQ2IPYBBC6KOrSgPsdCv8ln54vaX?=
 =?us-ascii?Q?IuBCRZ+8hT9BDRa92mMgTfdN3FqD0PqH0BbJI4Ip4cDd3NgYO53kikfuv8Wp?=
 =?us-ascii?Q?nbADRCoxWQ0Guqt199iw+usOHmb8G9+EOitRkC4Zrn8YwPLL7vX/UDIqtI1L?=
 =?us-ascii?Q?Houfn7s4FJVgeeyvYGimNpTq6IcfGUH8zfAsuHckDgbPSEOZoeSaq14glqeD?=
 =?us-ascii?Q?hnguM4TKe0xx0xtZKScFdyvjHP5Lq3t2mLFhvetagWcmTK33AfFGbJhByXPd?=
 =?us-ascii?Q?T3z5hTIGBI71dylVbKXc+n5JvwvTE2gS0ueuvyr/8yZSRxFO3MeDO3KEVCyM?=
 =?us-ascii?Q?7SpV6E25Lupj6HD5/Vw8MCspw8VDgaAx9Si7N0tWQ3GxVcqS0L7ykQxXMbAc?=
 =?us-ascii?Q?hSeUnoPpvvSxapJTX3/klMersfHYC1N7wZK9qO1cWI4ah6hiUWoGfvlc7IEV?=
 =?us-ascii?Q?acdHSQqgnjpIbFROrOQgpUUjiDPOtG/z9zoha8IpI0BzUz+6fT0/IKAcfdl/?=
 =?us-ascii?Q?/bqn1etAcNqbL2c4aVFrGS6CjuaYDK51OW9eRW7uvFkNAT9FXbZHhugus+dS?=
 =?us-ascii?Q?NHUU96sI1phpiRgcviyXemxQ93b1bc9PUJbz2quCBtsDFZmFxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqT/QsmKNMA8OsMH1g72/D4wotyy0civbdvuc0dZdOnjb/M86HLd1OofhtfC?=
 =?us-ascii?Q?Uuwq3Uvxs8OJgQEzwtbHEuUCfYtGQv1gcT4Dh2GwGv6WZ4jJbLgEWKU3nQgc?=
 =?us-ascii?Q?AJIvxJSpbn6tqwszBaCueoSUto1aBSIG05Rpkruojv4Y+5JorHJ7smpqVPey?=
 =?us-ascii?Q?W3ZcqqG+t2i645dwnv7D45OdT0ozF2OFCtirfsWCfQkCrlHSalzIajSt9kWl?=
 =?us-ascii?Q?2ITYyYP5kUVf7xOeCGIe4ORH3DVLzxEMPAN/Ax/sJhbPWzC041VvKGty7stA?=
 =?us-ascii?Q?RZe45QGRjmyaYZ697YMSYuljyaMq0fCvYbaUf1ubJHjK5xp/SUPXLmENYc2T?=
 =?us-ascii?Q?quwdg5wc8qgrf8hDpnGzVhrzHk8xeYghb4hgz45LFd3r1YcyfEWqxtF7i/zY?=
 =?us-ascii?Q?JaVZo6/oYbtJhLHSjsC9YDbgZcPKpM5BnNPy5EvE/sXtUglUvKo2bY+IQZzi?=
 =?us-ascii?Q?s4+qTd6kxMX/xnN4BseU5LzNfQOd1o54qmCDok3OeYsDXRJqkb8HBX1GtCPK?=
 =?us-ascii?Q?P03CracnhIdIgByy/neJM1FQwPHKfbvp+E7uaCEN79WuXj2G4V/UO/tofTeu?=
 =?us-ascii?Q?Z/EOWEIKpPOffSho3PiQJG+CUWTNHFfY53Veu4Zs4yLFZ7aJ3f2s/jGHU0n0?=
 =?us-ascii?Q?KTYIrNQbCF1hC2mYWFvY0zM6bHhKTnRKENsVldC8ScfyEO0yxnxLZUIikUgX?=
 =?us-ascii?Q?5kHziCt9nBsMUjV8ZO3niLoNj8aNZaPzMpxRvXp/Z866u0IU+YuKVQYNQAA5?=
 =?us-ascii?Q?K7btSfjlWgvzHODRm/x5j/RS5DYx60lPcK8BHVcAUBOs2lqNvw7JuZgagTJv?=
 =?us-ascii?Q?oKITcRGnE5oMd8ekWRm/Is69SqeNqXLWwk3xdbYhfiK6o1rWWvoPMZp/RxkQ?=
 =?us-ascii?Q?dkbtaCe1XY7rKC2QQg5xesWjG1b32Iu64RoNaMXN6bKFmEHBJjCMUSnp0M4S?=
 =?us-ascii?Q?bKJPC6BMqeU/I6pfJ8S6Y5HF1wpUEGYN+ydvRO7uPU6C7T87ewZMZE9j76sk?=
 =?us-ascii?Q?ZI7y5++lb4jN7AXJVPrytEfCPrZOKUeSszDPVXw8nehpqKWN+tmWMHbsJZ1F?=
 =?us-ascii?Q?pHU3PbuR0j4Qs5/MMKxLmFwULork7cJ7vAqpt13pp4eWkv3toNzD8B1IfoKJ?=
 =?us-ascii?Q?zZafCjiijwrbeD5NEUg/pVCxZKCI5pFz2ujojvwrqt2uhBqvxm2uVLJbJlDj?=
 =?us-ascii?Q?OAlhqtjnX6N4lNgj7NSOcv5sYOK/88rPRF+ADhoYLS3esEvqxlW0jZBrzbTN?=
 =?us-ascii?Q?tztThLA5ZppBb8PyhjhnOTEa9g+Vg2Uf8ea6J4+KRcKgV2efueg2xur0Nucq?=
 =?us-ascii?Q?DwPkIY6+8SdeTzveC3LSejJtyQlKaou4AtvI3Zlvwd9aFHqa0kwlfQwbiEH/?=
 =?us-ascii?Q?m7acGVPGUni7OB3gnkHlCTMRaQJGi8wUvFUjkp+lrn3syqMNw3YsqZxB1Wul?=
 =?us-ascii?Q?OZb+kDsvcDdF9FJSbVpQEySNbpAYXezcEs/ODOP8FtK1XM+8OsTxJCBAvqBo?=
 =?us-ascii?Q?DuCoLE4H7aKtKKbCd1xItlRMzyCZihO+6LIVUpWP2WzWnvtsFnxj0pX8cmBe?=
 =?us-ascii?Q?mgFqCyLwkC2tENIh+vY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2596f1-6bb2-4775-d64d-08dd452b0cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 14:48:55.6542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVXS2yBzqaMmQ6FdLysOtifTU0TK63A9kB/r3kelW5ZjjlDwKX8iy6BA7E9kSxGsVMxez+BzAS2lvfQbOPfrgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5656
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: BxBxKkobn8NuYVMDP_wIjxS5sXZeCpvg
X-Proofpoint-ORIG-GUID: BxBxKkobn8NuYVMDP_wIjxS5sXZeCpvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Tuesday, January 21, 2025 10:42 PM
> To: dev@dpdk.org
> Cc: Pravin Pathak <pravin.pathak@intel.com>; Bruce Richardson
> <bruce.richardson@intel.com>; stable@dpdk.org
> Subject: [EXTERNAL] [PATCH] event/dlb2: fix event weight handling in SSE =
code
> path
>=20
> Commit 6e2e98d6775b ("event/dlb2: support independent enqueue") updated
> the avx512 code path with support for the event, or "qe" weights. However=
, the
> SSE code path looks to have been missed in the update. Update the SSE
> "build_hcws" function=20
> Commit 6e2e98d6775b ("event/dlb2: support independent enqueue") updated
> the avx512 code path with support for the event, or "qe" weights.
> However, the SSE code path looks to have been missed in the update.
> Update the SSE "build_hcws" function to match the changes made to the
> AVX-512 version.
>=20
> Bugzilla ID: 1616
> Fixes: 6e2e98d6775b ("event/dlb2: support independent enqueue")
> Cc: stable@dpdk.org


@Pravin Pathak Please review and ack to merge for rc1.

>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/event/dlb2/dlb2_sse.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/event/dlb2/dlb2_sse.c b/drivers/event/dlb2/dlb2_sse.=
c index
> 248d7519d5..f2e1f9fb7e 100644
> --- a/drivers/event/dlb2/dlb2_sse.c
> +++ b/drivers/event/dlb2/dlb2_sse.c
> @@ -190,11 +190,11 @@ dlb2_event_build_hcws(struct dlb2_port *qm_port,
>  		qe[3].data =3D ev[3].u64;
>=20
>  		/* will only be set for DLB 2.5 + */
> -		if (qm_port->cq_weight) {
> -			qe[0].weight =3D ev[0].impl_opaque & 3;
> -			qe[1].weight =3D ev[1].impl_opaque & 3;
> -			qe[2].weight =3D ev[2].impl_opaque & 3;
> -			qe[3].weight =3D ev[3].impl_opaque & 3;
> +		if (qm_port->dlb2->enable_cq_weight) {
> +			qe[0].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[0]);
> +			qe[1].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[1]);
> +			qe[2].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[2]);
> +			qe[3].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[3]);
>  		}
>=20
>  		break;
> @@ -205,6 +205,7 @@ dlb2_event_build_hcws(struct dlb2_port *qm_port,
>  			qe[i].cmd_byte =3D
>  				cmd_byte_map[qm_port-
> >is_directed][ev[i].op];
>  			qe[i].sched_type =3D sched_type[i];
> +			qe[i].weight =3D
> RTE_PMD_DLB2_GET_QE_WEIGHT(&ev[i]);
>  			qe[i].data =3D ev[i].u64;
>  			qe[i].qid =3D queue_id[i];
>  			qe[i].priority =3D EV_TO_DLB2_PRIO(ev[i].priority);
> --
> 2.43.0

