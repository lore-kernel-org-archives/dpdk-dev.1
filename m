Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D00CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 19:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FDFE40650;
	Tue,  2 Jun 2026 21:28:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 237FC402A9;
 Tue,  2 Jun 2026 21:28:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652Fsfsl1194256; Tue, 2 Jun 2026 12:28:53 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020081.outbound.protection.outlook.com [52.101.46.81])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3ba3k4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 12:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDrPB7KbBtOt/CqzmQCNXw1B75iJ5yZAMRr0P8n58FaiYG0SUnMflLbYQE42rxDc7Ag8cyHoCoJ7Efxv0yUU7w5UGYJVsqUL2c7IvA+AhaEbMskvHk8QWcgq8ZeOzuCPo8cz+glHLDpW2d3Vc2d2HQ5uvLt21pcaCn8F4CuxKyg7E52caikxtXvuaK3pb+OpYvzlQAVaXULSmGekqqkOOV3rZr6eeP+8ZZJwFowMsgdKPhQh3N37ftEuxikppcGEA6Esh3RkeiNQJwNpD+5tRiQca+R3CtLqocVwpL83PmObzJoJO47Xhv4SHk65bhdO7f+b5sSCBnBIGhGQHJzccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVub31iYIxP1lBnZUEwi1f8DEJeHWhNqJEgPuF1HBD0=;
 b=Cngg4AsSFXzoh9iQj0aZHMyRAn6m5PPQQT4G2JyZWZxCx2zXjX0S3ZmPi9OPS+Lpnh40YFeYRi/bzvhD4HBSG4jYDXQqxZ01ym/qV++CttPgugoKwb/QhRl7VSnAKekM4iOxuOiVV3+lKKSALqLdbI+A+LPIZzDppeWL3c8dWhrl8qeOFC7c1kq5W7PxU0bBomtHl/LTecfSAHmr1NE4v/6uO9VDd+fz40FPU1nIzYPbngw9fJiT4V+8NH3fxT9+SRBC4CAJ7jhNK9FjxQu5PglsQrCBUlweeQkNhZHb5hgPakNClYdu8i6uN54s80Mn3MtqwWN/5GfHMDXMs2tJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVub31iYIxP1lBnZUEwi1f8DEJeHWhNqJEgPuF1HBD0=;
 b=FXUHcnfreot3iO2wsbiOFEmpfWImwbs5qAoHaPOQzdUjr1UCWH7nwiYNqZoNQmlqVBsEpN+QCxGbFTACwce/wu64AplqZZvIOnHID76jLVUpHyctohEIdBWYQ6k4oT67rlf9fNXecx5hYepAvgpWtehaH9eYvt3RE8SdjE/Oi7A=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BY3PR18MB4721.namprd18.prod.outlook.com (2603:10b6:a03:3c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:28:49 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:28:49 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Fan Zhang <fanzhang.oss@gmail.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [v2] crypto: update asym xform strings array
Thread-Topic: [v2] crypto: update asym xform strings array
Thread-Index: AQHc7Y8r+LWLIf+rBkmjbUUmiX3PpbYrsMog
Date: Tue, 2 Jun 2026 19:28:49 +0000
Message-ID: <CO6PR18MB4484F395D9B9440C4EA472E4D8122@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260430120533.2004-1-gmuthukrishn@marvell.com>
 <20260527041312.1801-1-gmuthukrishn@marvell.com>
In-Reply-To: <20260527041312.1801-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BY3PR18MB4721:EE_
x-ms-office365-filtering-correlation-id: 9d455205-205d-4def-40b0-08dec0dd2c55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: c5xvmCObtXSWYnl5RTCvK7aDLYh+bLbG2DKWcqKtE1PIktJEHFFaH7nUtcSks7ulSZpU0LX+eKzof0JniPxFuvTssXOaGZgm0rbcfEkpKPc1+fBz4XLSb2SQQExSHTJ25a51CMBbKM6xnjdDtVJOuzzEy1ON7sTaz3H+zyZd5WIEzADclS5myk5dcw2sW9glAGgBHMg5EjDGqYe4Q/C1ycGB1/Nbaiu/jj7WrTYIFsG2BOYUlMiqwm8WKy7r4TXf2KDh35RB48JiHGsMFpmBjIghmVLcr2TxuIYekQ4pxvCvpcO5MA2fjrxpMS0/E0ai9gSgG4AcV37PbLrGui+4iEpWMt2c1yuOpzceaUf+KklKfuzXu3zAwVAj+AMOvPwLPtWgED8l075GLa0paGDeOClkEq7stHEfwjzuQ14y8T/uAKKHA2wv4yyubclXjJvDRB9a+Wv+VuOcDuS8oA+BteI5kpTh2e+hOwX3jHmnZOJf0gDiXueAhbb0l++aUfvHNU5q2EvADY1ZraGeJTlP6g4dJn4B5yGFd5UW1WjydTzM5Pp09tNXFeyZhtFHFnmE1zcj76+QY71KuyTUlQsp4GeS74m9Gik8kCQbODULg4SpmVGScP3wtJ6FHLsTZtD5Pgtaq17POSYLwlJDkqtfsgo7cF95vggCBcEmHABEdcXoc+PlD6NW/VXiW4r1F77jZVzdaZe85c/b19XLsSSorUSy1ACxfhoEvp0Y3vCvmSvt0Qpxai7nTppNeAhsGKp/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6uBpGdwkrFBOyQ7MJvwspkk7TZ7iJ03Pf7Xgo6liv1KbN+spm5LCUtYkRhB3?=
 =?us-ascii?Q?8HZRhboRKdxCgWfooRmSdajvVKT69YxgRl24YcCr31JOMedjryb/5xmBDe04?=
 =?us-ascii?Q?eLXole3Cq6WMUpk/YdarUpoO5SoFH+kv4wA8U+3i4unuGCO/xx+FNKemAWk5?=
 =?us-ascii?Q?CUJKlRYVyiYSoTgNepIiUtys7eQl6h+ddLcPCkYR67USV6Ig/aYBpohr+zfh?=
 =?us-ascii?Q?sUEpdntqVaDLp4wvrfApuQBh4ndWev+eAhL1X8JAPC/3nP2J/efxCNIkM/8F?=
 =?us-ascii?Q?qqwca43clsnNS++mdpVmN1sWrwBLJKw91tKq/E0XoKg6RaOK8cbwwtqshGzY?=
 =?us-ascii?Q?Qc3loJZKZ2lBgHS0Dk9yKa0pPM2q/JMdJ45y51eskO0JacbceOutOgXrYHqu?=
 =?us-ascii?Q?WwQVyPhTfOl8s75xfgak7gw9/pc4HfUULHnDC3fDAp404neE1zSggdUlflFH?=
 =?us-ascii?Q?jZSmUYxKRnto4dIBaBTm0aNjcWsOAc3JUgm4oRSxAukkyXs8ObFnAqLSJX8B?=
 =?us-ascii?Q?k72yyC9IHc2tYaPNDWlzOwdKndO6xjpUDYFACC5KLeEt5PCEnFEZzAIdS+pG?=
 =?us-ascii?Q?xSyyFpz/rn6eZMkdtJyl8Ys1JsFcefbP3jKPByFUPHbDr3sVfXf6c4pW79Qv?=
 =?us-ascii?Q?Rrg/u/MbA7vAk/SMb3VRiP8BHVnSHec8W25oZG8w8zs7eoZZBdv0bFYC7nOZ?=
 =?us-ascii?Q?/A9z4BaJzvjjVRNWgxPjG9PPOi2r1F+5eOcyaF5bwqhDxYJShLpQi30JP88C?=
 =?us-ascii?Q?xOotvREnL8D/+AcouxHP3Yc4mlDy2gExvxQdcG072T7gMfcjvrPVOza/HPTJ?=
 =?us-ascii?Q?SduXituSHbEWKylOel2CknFsDi6/1UMBeV4mKmBCGVME/9mVoYao1cN3bsiL?=
 =?us-ascii?Q?u8Qf5vyeqL4xVXmsrIivg3/UfjSRMWCYuMNo14D1sBx0oLVb+MzTp2Oe9zlC?=
 =?us-ascii?Q?7LBSHvILyqOYU9NwpFHFlzxJmsJROU80FWSMnwrgedAjmo+EiPOJPSX5GMDC?=
 =?us-ascii?Q?1VRxRmbzJUciqRDIv/FHtn08yx+W0fKe8IhP3j9ZNueVklK4CsgQUcP1uopO?=
 =?us-ascii?Q?yRysVUW4qRCjGzVow03XVxllaugDkkfZHVZ1oRSV1BGC6bR3ivH0NWNbKd9Y?=
 =?us-ascii?Q?RyUURKMnNqcqF10VoyDPWg0yhZbYVby6ul5BCpY/x47oTZQv/g0NVmcCsoNi?=
 =?us-ascii?Q?pGRW2D94irEekf1Bv+dXxZ17UbwCMdxNnaHqF9h0SIz/X7qB074TCgLCKRI9?=
 =?us-ascii?Q?AuVYvOwgN9aruVy2a3ZSKqt50PLeXHgWt8z+EMrBwuk5uJclRuqp7NphMtw2?=
 =?us-ascii?Q?Zc9bKfw8m+hD2lL34aWTI2I71KMWQ67aydYWFe6UJymHc8038On6WuJZT+w3?=
 =?us-ascii?Q?snkgJi6IPbcZD95oAhAOKWVcSYH6ejorwqizI7DGJtKq0FLh+mDuBSVUE9e+?=
 =?us-ascii?Q?X/AL4B9LRx0j/3yNllG3qcHuDN9kPn91AelPbNUJHpsaRbsXMXo7E9N4XQtL?=
 =?us-ascii?Q?MBG0WR6JW4P3siE+vXKnxoNZdS4jFUkdWikaMY78simpu+M4eslS1VbqLU4Y?=
 =?us-ascii?Q?BHaa37QGQxkpJ4w1GQ68EN6vvxWikoHMspHtz3fCWRwUzjGP8shzgw6sRTt8?=
 =?us-ascii?Q?22r5Vqdi8E+2l/eE+5dv+V5ExdaMYfCKgkUAY1Njh8F6eSPCVOGr0TQRuVve?=
 =?us-ascii?Q?hvwNTItxXDZWN4dsMVAUxc6eJoBDM6HHIksar/P8hyzokHaP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rL9pIxV6nTwWu1TUnMvozYiQjVZ20CDCKDe6cEEylYtAvpg7roO22FAk86Ofx+ykCHdefD9+entqXqL/Ggi4d+IeNxeHtiV1tS/LyinhLpZdMixm8+9jHED82ETE0fh+anOovVXGkAz+QLkDcV0X2h4EYPQjJgtJgga9z2wFRB5ZaZVKXSKAJzXfA8K3FyUD5reI7zXWPSfewbyQ4ZTxnu1OXcLghCuqx8WksXLXfUdeJ6IfSSUAbSNWcN3tENAo8w2jxqcDtsxS7gAZMCc1G5ZAeLveLYl6rUyCcoh5Fgqe4aAyumidKJBOAL2HdnnYGq2GHwGx5e3k8VR/NByegw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d455205-205d-4def-40b0-08dec0dd2c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 19:28:49.7121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oF84fR60hQ8d3bYfdaL6/DJB72BZzyPZfA/0dp7RR19xsZ1M2sBqM9q5PL/dsH7fdjVATHzR81lHPtK4iZuOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4721
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4OSBTYWx0ZWRfX1QLLkhUPEUjj
 ct5qS83WsF/IBBf6aFdirw7XkLmH15KRLZt/VGoB7SSEAB+yyZfxoVUNJcGWIWskAiWq8Q33TuX
 VIMm0ReV8rliCpeJ9eoK+7XdrAyb+cfpmFkVdlsJ8qPXO5cwQPPvpJMjnmFY+C0vBZl7Q5KNtLO
 DuCCjakZXcBsflstYoI9BSzb2wpOya7/rG/Cxpeg+uXn5tvoB/iQRY9KI5O8XgL/cvmJh237tEy
 bKrbSLQzn3Rg+gpXyRdIRiQxyG2Y3dPHofT98X+r2Rt/4xqkboabhNKaVg0ZK5VfzS2YcYMF8Sv
 oW+l+cx5TYgzS1R2jMLM8OcX8J3KZzh7QLxJBMMfCSizJh52spg9eBpQZgk6/znFjUC/HdGR2OR
 aI3IBqfiLsAhPI4zRtSIb24GYNyADNRyaq4TK0lqqnXHgteEOdS1N+pWirgoQXSmZiJOTM4MJch
 ZDR9ZG4hZZirXqHR9+Q==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1f2ef5 cx=c_pps
 a=Sq8Pev+jtt5PqluhJgCvtQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=O7nmYSS8aj-IHI7UogYA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: 7zI6CNZ-EzoVfOA9BE0BjYQQokXSatXc
X-Proofpoint-GUID: 7zI6CNZ-EzoVfOA9BE0BjYQQokXSatXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
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
> From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> Sent: Wednesday, May 27, 2026 9:43 AM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Fan Zhang
> <fanzhang.oss@gmail.com>; Gowrishankar Muthukrishnan
> <gmuthukrishn@marvell.com>
> Cc: stable@dpdk.org
> Subject: [v2] crypto: update asym xform strings array
>=20
> Update xform strings array for missing algorithms.
>=20
> Fixes: bd3745e29065 ("cryptodev: add PQC ML algorithms")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.

