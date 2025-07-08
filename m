Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D01C83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 19:44:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE0640649;
	Tue,  8 Jul 2025 21:44:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1961140292
 for <dev@dpdk.org>; Tue,  8 Jul 2025 21:44:15 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568EMr3j030735;
 Tue, 8 Jul 2025 12:44:15 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2135.outbound.protection.outlook.com [40.107.96.135])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47s51t0qy1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Jul 2025 12:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIEgDkswFiQnOt/LjCqZFn6bLQJJ4Hm5++QBEd8nCGtxtuzP7XdyQ4/4MATHFV+6ytPT15rPakab+ba4r9wI9zJtIFfzXIyEQMyDUW20pFOjrTBqsY6rfjdozfAAFHzhFwuhXBUpG1HnxAsEIhn81Wb6LA6u8U+rQomB1Ljg5Fz1W2v2iIikOAnFgN4gnXHtTGVDf14iDqFV1eLtCgf+IIYY/y+OLes0pOZYUJt2RWPgh/xcSTi2gSOk2nFBVd3mWMii4BEjfOwgQKir9uYvXLMAr2tOdE9syfP4yt0SuIhplm0u/eLDZIB2OYlR+IeLhQZfFqvj0oS2sua1O80Juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tomFQttrmaA3+uCcbCmn5Dr+hDIO36YB9xG5ngDeblo=;
 b=NtoVEa3Bogw37o9NZDgkaTTajK6PghHBcqG8YB13v9LPK16UD4IYyoFDsaqNei0r310v2LZvlN9oNWFaSPwImIQvLhfTHSMO/TIdp5wGXF9Hx5C0+kz1H7XTBdin/Hzb25ncmB7ISVkcyU80I06nNex8prmwCumLFGNtUNwYLynquy7eVrz8+2aPkvrJ684vX5qlHh4sJ/KUvPPsJ3rAJn0CVyboTR1483XAVumiCAbCsvTtSgvjD0vCtU/hMxK0qQn99rP6qXhSJLt33jIIpCTlii619HldNXbsFP6gpQvWpmN92u0pUyN/fMeSDGtASEHwWZ9SRVxS70MMDhAajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tomFQttrmaA3+uCcbCmn5Dr+hDIO36YB9xG5ngDeblo=;
 b=Cd+0KakcYSIp+9sCCvmifwd7F+KWG6zT8du6tbvLjz8Cpy080dbxvtVJaDjYDkbA/0S60itF0BLKeqwZx2JJ9K9EdurvgSmFzOJxIA5IsaBSpAvIFWwm/37VJUHNlF+5Qe9YZQM7ypcMkQdo85t5zpQDQa8DbHOK3mQNPe7mS94=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BL1PR18MB4120.namprd18.prod.outlook.com (2603:10b6:208:30a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.27; Tue, 8 Jul 2025 19:44:11 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 19:44:11 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Rajesh Mudimadugula [C]" <rmudimadugul@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>, "Rajesh Mudimadugula
 [C]" <rmudimadugul@marvell.com>
Subject: RE: [PATCH] crypto/virtio: fix virtio desc flags virtq info
Thread-Topic: [PATCH] crypto/virtio: fix virtio desc flags virtq info
Thread-Index: AQHb5ntT7tRuBnQ+tU6kyfzi++857LQotDzQ
Date: Tue, 8 Jul 2025 19:44:11 +0000
Message-ID: <CO6PR18MB448422F77F6E9DF1FA2F7D9FD84EA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250626091842.159016-1-rmudimadugul@marvell.com>
In-Reply-To: <20250626091842.159016-1-rmudimadugul@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BL1PR18MB4120:EE_
x-ms-office365-filtering-correlation-id: 66fd510b-cab5-4877-1410-08ddbe57cfb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9CXGfs1XYMr4UJZuppuFu7NOaKpnRdTLOE9kj3eHle8dVFhxAerI4caPOpoy?=
 =?us-ascii?Q?+DL3Gii/DQfegzsbgwsLlu77VrAk1OvAG1kViCqjMo/sv3AOxpPFdrcp0Bny?=
 =?us-ascii?Q?XB1tFnIU72Cm4fcioidYHuJ2g39oJZJuEDepWRT6P+G959DW4gN8GSXjAJv3?=
 =?us-ascii?Q?h210kHlifxQBRJm4lobKUbtirTPzCpdI39/v1Yri6c9i9bk3LP74p3AYjMXX?=
 =?us-ascii?Q?WrfrdVM9JUzF3D6SHb5SZR7CfXjt56EQ9vtedLe3IySEIGCLPPwO1v9FYf3j?=
 =?us-ascii?Q?5agDl5CUe2Zs6S5zAUdLCJWce/u7hxbDScC6VEpl7pOg1yUucIcIe+8M/dNY?=
 =?us-ascii?Q?L/3ScX7M06PNnhTPcyCpZeSyHDkkgh2yUJpj/XIcuBErDt6YvZjL9PdPm6X9?=
 =?us-ascii?Q?hmuAizaOzKXCSOA51iWtZBOdr3n/lO+Sw4SXfZ2qZFM2cBozWo8Ugoth7391?=
 =?us-ascii?Q?hhZ2p5W20p/u0pIZRfuMeWwHUaj+K9UXAylWLMFTjBnwlU+YqR5UhnF1afgT?=
 =?us-ascii?Q?B1i+KEfgxEwRPn4KNedHCHn1FK/Tt1uRWhUVoWfuhwveUxydeFMUL9XIkkdK?=
 =?us-ascii?Q?GAnOBgJ0h73X4vieQshfWYAh2WVLu+PuUC0R2rJAg0AYftvt6VF7Vzz7+O6Z?=
 =?us-ascii?Q?7Pp4DpW8jCF5rqM6WTN+PTTjgCHCsM8DYkXyTLy6OlxW0iX6AuqByYzm2bLE?=
 =?us-ascii?Q?Ddwc1vUfbHUS8ElMQ7cKtMhnY7EDLnztuQVeOV5RnlRfOrqdyIF55jqpNhqV?=
 =?us-ascii?Q?QK2ghnjPiw2y6rmPWKHDHtzxWUZsQuCtBczRE7YgDeUsW+9DEv1criHRqplM?=
 =?us-ascii?Q?I/qvXfNBsW1mc++XDdk66hjZwV8VGWjGLM1hX1ivE7xo0+rWlMLcSSUypBef?=
 =?us-ascii?Q?U5/mA81+zmMJra1zRkP9w/1SDnSpfrYyOHZgARpDfcykQonOHhlRKI3xx5p6?=
 =?us-ascii?Q?5a+UxNme/rMp2pTuPk/wLDwciyASH+/mZ89uzxaJHBJz/cG7f2VLPw7v6jDL?=
 =?us-ascii?Q?AJdtjiSarrz+Db3C8TOy+6qYKUCryXcl1DC6KIJmnL707vB4Gcy25l6cjpnp?=
 =?us-ascii?Q?1EmAezBYVDJ8U38eumzBjmZpvm2+ptT3mvsTSYw01ju0F6ICnPZK0X4k46IF?=
 =?us-ascii?Q?A3rTFYH/oG8XBSvJAHDsF91FNYAV2HU5EfjLQmd8pVfItVcArfBqdX8w82FE?=
 =?us-ascii?Q?gXr5fKAcOahlvjcp2C+MVmZ4X4+xMWI3bFZhkiWeROAt3cVbcMsbA0UWWe0D?=
 =?us-ascii?Q?BVSHq6WZZhZIIDtTbC0XqKlLNoRiqNfnP/qh9friOf7p3l6uduvGxFU/1bYR?=
 =?us-ascii?Q?BesIWdSr35RvOJ2N/ApA5RWaSMPK0NsQHWMQ2pS7XTaSH2T6BGGiXHF6ZncE?=
 =?us-ascii?Q?KvkpFa5/sl88exT5RZqt6e3IR6ZlGSkCNFLM3gIm010Afsf/Ci8QBLQ4ktHv?=
 =?us-ascii?Q?G5JIkbPEsVbPaEKoSoF8D76BhmNv9fjlqUuZdBOIrE9VY80nMFstMg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zp4q76KHujBFJOFrhbJiZTnFDQ8YAlunXCnabXA47IvgokCKqnZjP+A5v8qN?=
 =?us-ascii?Q?1d1jCnwdk59BikDGLLybM6NRTC/fNCfjwUSvfaGmRGd858to5GLPRYg9R251?=
 =?us-ascii?Q?3y3uSr/BRPlyqDK7RXzrhKAwSiHXqh+nQoO6ogQO9FSfm6tJDfMAyYat5WPX?=
 =?us-ascii?Q?5GZ1qgzV57D8n3PichUMBS2rQ5+/77eLe0Cxbm9HAVKzvZAXutXbpCE2xIvY?=
 =?us-ascii?Q?2LYNVpeaEFlt3LC0JQX73qY3KfNKqZWW+00xUuAyNrW4C5tWH6T3RZ8UbMqO?=
 =?us-ascii?Q?s7sQppCBI1gxiicUNQ4obcjo8QDDpRcl39UItd4CGP99rAtRBWrTxNIzMCqB?=
 =?us-ascii?Q?IkmElmyB9t2HtKBtfUNelgYs4XRFx2QByGxiYhAIR3OLJs86l5bphMTqv1kz?=
 =?us-ascii?Q?+Gow5DvS/QGRdabb2bFIZcWdLc6PdT2gxlalZOZTzTk+qyx9gpTTGDsFxKsF?=
 =?us-ascii?Q?zuFfZEVftU/YhtRZdVjUw/0iQMastV6IeDYTYI6sRagP6J1cWmNalOb30+Js?=
 =?us-ascii?Q?XCUlpRnqZFH4ldrmuhrbGILGA0SOR4GoN6w5EZrBdCVCM5+weGqTO2GBiiGC?=
 =?us-ascii?Q?/WQ2sOodwFzcgm+SqMHDoN7T4ZHbCbNQ59czuiX+nSmSRpsDOzgi0tcBsPGM?=
 =?us-ascii?Q?sZQKzzJR71pltzzRW3GdTT5OabATUfOZLYJNFtNy7FPd8A2x8zdYowIhn8Cb?=
 =?us-ascii?Q?M2BCxBs4EFfR5FGx1yRUQUMluwHeByugcUd0IL17OkHHvl5rit/qDbuO+6zd?=
 =?us-ascii?Q?rikxKhLjD0X9XEOn+ZzKQlwrnCS9IxjGeYA/gfCTmG8MziwyEhupiCFuImQd?=
 =?us-ascii?Q?IlWH3FJahU9px0rr9yPWBzy3jVtLFujncW7+PklWAaf30v+x6nFoGlHe+Kb8?=
 =?us-ascii?Q?LYvEvB1HBbRuNuv9JYziFEder7z/b/d0RtZwQ2van8MBib76v1W4qpYu7xrr?=
 =?us-ascii?Q?jEoidTO/Im48VJ0bydhHelJZr3/w+SabCV38rv+moyseYKEtGIgWFgwGndxk?=
 =?us-ascii?Q?SYLgZNBGQLyD4Eyp88iZpxV+SKORiLDqeKfLywqoHBvHkMBMJV0lnI4tWh8Q?=
 =?us-ascii?Q?zofp/OKH0FinMTZEu0eHIUtb+3f3muD2ODKGDLZpRECU+mUSTsn1wN+jm1yI?=
 =?us-ascii?Q?wK/aUDYyjJ3/EwqSDrMandTWHznc+C+3YooU3Zq9kF3vqFUQbDxgYQMKF7q8?=
 =?us-ascii?Q?/yg5KRZHf04uPS9OUTE72/QBwBjyjSIvZJ7G8vy8+bRs0DNc+ZgO+oqh8RxU?=
 =?us-ascii?Q?Ot/hPHVzEQWvSYF1fk6dqlo3yuzNqkhG4mMaH8sAysUv0Cer2n1tRaUCq4Rz?=
 =?us-ascii?Q?O+/+Fm9qRJj3DWwqrY5MZ7tApGGb+1kV8OXg1m3uKESKIBLtwNTVNSYLPWV0?=
 =?us-ascii?Q?msolHmyUMAW/ub1BiR/n603p5OqiiOEFV5OCLWvf1K/ezkpmdVa7N2fQBdmG?=
 =?us-ascii?Q?2ijhfXp7KDNFSAsAj1mKvY3k8kaAk1AyISOZm6mcXmHo04zce+WdlgSytVO1?=
 =?us-ascii?Q?pDCrVt2LyV3TKaMRpBD+p11q7Sp4+O84wYMuMq5GkCa/6YcSpFC0AKWf+YEt?=
 =?us-ascii?Q?zEcsUO3CSdHAhAB9vXGDn4yQQyTip442vpOiKuKa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fd510b-cab5-4877-1410-08ddbe57cfb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 19:44:11.2086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMEt49nQfj96NhZaE9oKOkFiP9rEfCESY2Y/uXh/WqU6qd8+mfL8AzY5GNuJ4ZTNhnZWhW19hExqipfvY9DREw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4120
X-Authority-Analysis: v=2.4 cv=IIUCChvG c=1 sm=1 tr=0 ts=686d750e cx=c_pps
 a=eKE+ZKqSmEoANtKPiYI0Tw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=i0EeH86SAAAA:8 a=qmR9txZxlrTYmiLs0o4A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: NGhc2MiwF3Gsuc-n4C7C5LPmHZr86peS
X-Proofpoint-GUID: NGhc2MiwF3Gsuc-n4C7C5LPmHZr86peS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE2NiBTYWx0ZWRfX294mY+JJvr9Z
 /iTpR478oaSadhqMGuDkIBFZTbshB5BAd8CcugYR6XiYwbm2o8cboD+U35ek98w+ODP92nvResT
 YuGy/bxXbkc4W7lLoZuOC2jc/lx2Nhc+39+quoAZuLaA+1sX6vYhnLc5aYtf0aNVHBFg1FMzRPd
 Ik6FHhnKS7iHgMTrgdDeg0Wgo59vVuPvLk7cRdYbTREdvrcXkMo0dpOb+d6OJM5zJz96mn+XMX5
 2YSUJ/zY9Smz5HTflBDmfJ+aKObXvPsFJAHoB7oN3PLltq0ejKKVLyK5DMAk40Ft9MZwTr8YPCh
 5FOLMqVPXi5lctlyE2O/ubXCl3jr9w5lcBUwjk8/9opQBt6kOAVrf0A9PX5nea4aU7k0JBxvM1G
 Y8SijL9iHyAQ0/RLUAiNqEtg50dG8p9aKsk6B7+95aD+dHRqlXxFMfQ/bdAljyDAq/FHvf98
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
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
> From: Rajesh Mudimadugula <rmudimadugul@marvell.com>
> Sent: Thursday, June 26, 2025 2:49 PM
> To: dev@dpdk.org
> Cc: jianjay.zhou@huawei.com; Akhil Goyal <gakhil@marvell.com>; Rajesh
> Mudimadugula [C] <rmudimadugul@marvell.com>
> Subject: [PATCH] crypto/virtio: fix virtio desc flags virtq info
>=20
> This patch corrects virtio descriptor flags and updates
> virtqueue metadata.
>=20
> Fixes: 796429e72a6d ("crypto/virtio: add packed ring support")
>=20
> Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
> ---
Acked-by: Akhil Goyal <gakhil@marvell.com>
Applied to dpdk-next-crypto
Thanks.
