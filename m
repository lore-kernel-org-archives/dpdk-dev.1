Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E03C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 05:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62653402D6;
	Tue, 27 May 2025 07:02:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EC015402CD
 for <dev@dpdk.org>; Tue, 27 May 2025 07:02:57 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsH2001051
 for <dev@dpdk.org>; Mon, 26 May 2025 22:02:57 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w2128g3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 22:02:56 -0700 (PDT)
Received: from m0045851.ppops.net (m0045851.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54R51F4X028494
 for <dev@dpdk.org>; Mon, 26 May 2025 22:02:56 -0700
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2093.outbound.protection.outlook.com [40.107.102.93])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w2128g3r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 May 2025 22:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNDtHP8+U6olXzz8d+NiG09Q8s3wa6EzP3b5SqOmPI2Cr35SADI1lvQcTPTDkN3cprI+swFoDz7DGe3uaLQifkiO16cWCax7nWIwZLgUrsw2ZP/mXtDMPCG4iKW7Y36383qrzsJBW4DOKByO4hX/fU1CLiN/Nr0SXpYmpKIQfcSHSWNdyy5QCWrCRYlD6hKzqUl3Z2FtOuIS1S+jvBofzJpRySNs83J3mO+doLZ41vl3JJQAZCYhDvgvNVWHtylZC3siVVLYeLa6azxdP2QH1O/JpSsUKyQGL3SIYiHjHejEpdiw/gpRbGsHysGi7ili3H84Rf4VxAJCec7jvjUWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2BCeRqpv0mt5wlubcfdr+cVfNb36z4GzmMQC7KRFw0=;
 b=BtKlorAPfKiVl7S8jsqqnkEr55f4piw9GIat89LnFOjoQCgBsFKTPg9ZLLDqh7eD7/S6a9wWRXJCmOeyJatbx5/0fN2NKNIEOixW1y79uViEdj4xdtQxTqROme30UJt/wv5j1ceCYUOc7qJRNKd6LQy5q0orYq5olumCXLad3RweGgPsRJPdWtfuCD9sEzBLr8b2kFfz8wIxuXtLp4i2zjZoiHdBDfh1cxdoHDMYFCNzACa98H44zvaalTsJTEF5uin2bTb462suBH83ZN9LIup7aSl24u3zRIAC2d7JAQJ4cHxnLyfBTg1fMPNy4qHXlhRnaDwtcyZ5DkW6TnvkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2BCeRqpv0mt5wlubcfdr+cVfNb36z4GzmMQC7KRFw0=;
 b=gai2i7hn5BkVBOAFrk+fF1GLZn9kNnfRdeNWyL7pkzRuw67vgF5VAJHUtYqbGqInwTSjMxiDrqQ7xJXv2QkMb8DaAFIkxSgyhOiRC1jTiBMPrYG0smpeo/EbaHwRHZMFrm4tTXQ7oX3zivJI0wUVNFxnZ1dgUK1m26H/FeeorUk=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DM4PR18MB5500.namprd18.prod.outlook.com (2603:10b6:8:18a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 05:02:53 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%6]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 05:02:53 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Andre Muezerie <andremue@linux.microsoft.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH] drivers: remove __rte_used from functions for
 compatibility with MSVC
Thread-Topic: [EXTERNAL] [PATCH] drivers: remove __rte_used from functions for
 compatibility with MSVC
Thread-Index: AQHbpQOlCTBSgeu+6kezU4zOOzeVrbPmPvsw
Date: Tue, 27 May 2025 05:02:53 +0000
Message-ID: <BY3PR18MB4785102E282A25D741443B84C864A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <1743731269-5936-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1743731269-5936-1-git-send-email-andremue@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DM4PR18MB5500:EE_
x-ms-office365-filtering-correlation-id: d9d3f5df-1643-4e96-ae3e-08dd9cdbbcc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?D1I63BelEstSFRiKzlXchrPFQ4s0Ksx+dMwSCaA8P7t1neKg+oz25WVpj5zA?=
 =?us-ascii?Q?rEvxv9jJDfuNaUg/RwNj+rWH/w/Em/AagsZa+8QhrWyAzHnfJRQWRm2Z6kfe?=
 =?us-ascii?Q?Q8r9kRiEQG3LUuT7+ORk+5QHchw5ovT/CLHQlLA1wwL7RtRNasMBldYQNXHX?=
 =?us-ascii?Q?J29LnmFQnFiSgVJT+qzFysrNE1lAPQ9qgI15twWBlaHWhF8CtQklNS2/8ksK?=
 =?us-ascii?Q?WvDIboFx3DJyOZqq3kYaJP6VSusXOwNDnHguvyk5Yx+nOFpjV4UtavT1c8dd?=
 =?us-ascii?Q?xcWH1tcP/L7yfj/pzhe+HhOIvizFOdPjaB4ZAsxgMEdJwdHhqfnIQJX2clQj?=
 =?us-ascii?Q?vsQZ//VsNMiJml8allftnTKjtLOV0cRG+qGLs/hA75cWVVfdw9a2pBNzOR6p?=
 =?us-ascii?Q?7PqKbzXuzpLnF/U6uKSrXg6VxL246VzRrFnArezIAtXoLqHhepd1SKArrZf6?=
 =?us-ascii?Q?YvDh+B2u5VklmcTXW/SCV8JQ7k21CC7EVCy/8A9e/yDUmZFB5JjF9/Rf5y4B?=
 =?us-ascii?Q?zDVW2iweFOSTej27SHTHm0SsW7RGXUbAB3oiDmsO9PUd1N0btygGUWORIqtj?=
 =?us-ascii?Q?MrvICwxAEqlpotwoiHJ1YjwZCSp0qwwI+WfDWPi8D7u47ie1mP54t/MC0WoN?=
 =?us-ascii?Q?uLHDnYOi3JXXH+6se+N59H0Z6ABqJXU7Q9io20tAwrTVXV+quy3sDqB9RNxf?=
 =?us-ascii?Q?OF3UZ0mIjETVxs+xlJTY4L9JOIq7+vjUGVvrPyRIm+sfruNDLdSpyLXZ9A7P?=
 =?us-ascii?Q?iFJD43CN81Ti9S04dVZHqzGv143j9WZSm2HbYQUPRb+pZ6zijgucjYsXqfoi?=
 =?us-ascii?Q?XEaHZBLfC+VSBNXtXQHhiSXUXJb1Hr2xPYbFxM5zLzTq0l7VZSyZOz2FXDgO?=
 =?us-ascii?Q?ibpppYitzy+4vH/TqHjT8l7Wb7k7S3swQxJi0ZVGLYavRsUsfloZKHsnRyud?=
 =?us-ascii?Q?37ofrrt5DKxrHYm1BWB2WnC+O60nOLLOnbKB5/HIkx7WtdHRCyfX0DSw9NSW?=
 =?us-ascii?Q?bcPSvQVSvPJgeNuBswhvsYWfHPpiAYleaMejXznefb+EI3AVdjAKf064rwvL?=
 =?us-ascii?Q?+3wW0e1MYkW0ZOPQjRnGK4L4A86O4+fBUr0ywhLZbjiXHj6E4nZ54h8JM/wf?=
 =?us-ascii?Q?STKCDO/1hGYK9PLGNMgV0C0Z16NdQIN+QLFGKbZc1nEyPZGS4JW8UAqtasVr?=
 =?us-ascii?Q?7cGHLpEBQea4x/unNe50jIZfQQpPGnI00qym+7AY3z2NdjNJlNe/ZMOMug/g?=
 =?us-ascii?Q?wy2bz8Ymx5qVqSVBlpzRVgC5u5EzGyRb81WafXT5UqT6hNIERFRnjuQ25d+Z?=
 =?us-ascii?Q?0lsM00tXS3l6TUXrDF2+BIo72IDRgDn1+idz5i2cc/Yh++pNfVKRFeUlGS8f?=
 =?us-ascii?Q?ktunEzTXFBMCDio7B7PQJR6WjhS5HrUyILcLTAlL+DIahGOkOXYLNHMB3VPt?=
 =?us-ascii?Q?aK6BUIm+qBA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YGfROh5pPVndpypQAb2HfhbDUWmB3JXMVy4toydeAMya/K2yCFNp6xcwX1eB?=
 =?us-ascii?Q?N+pjKkPHPr4FKIqkN7/RwEM4jH7RxRiN2xR767GnxxNTv2zWE/WXCrv9RpL+?=
 =?us-ascii?Q?Uvr0vpHsGlrBwa4Cvp53diVq9ILqXWIs8yfa90QNlQvXs2MN29IAxoxdtU1Q?=
 =?us-ascii?Q?Cp5Uy2mDmu6tOPhwoUklljwMuRSnHup87INYtx6JpxDzCqBweEb7osx7vNLr?=
 =?us-ascii?Q?3Ru+crqd3EFFZfWYxJFvVFh+Yu/eZJoaJgsERyCL+eFvtAjBBYwLfMZKDY13?=
 =?us-ascii?Q?QFIWi5Cv/ABstomKj2WBvzTjo1ybptKiNjXzwUtCCeXJz5RkJCVLkcfIf2Id?=
 =?us-ascii?Q?A+Phv2/CXCxX7QsUe6uZm5oulCO3REF/+OBKmFq96+dIyfY5bLt+ikMHhSiE?=
 =?us-ascii?Q?65f10JTC3lPf5FmBJT6QboawshNnR2j27EvvdY5ATWckMPkzI63JDUC5OTit?=
 =?us-ascii?Q?RyKiuLidMK1SU4yN8jBNDx8ip/hfNIhCblGcfM/gjnFHHJol/IJmC19GcrYR?=
 =?us-ascii?Q?zjxru0B13WZCmXmyKXUPKITe4Lg31aPJZDxz/tK15bTehiC5g9BAqXQ7nuk1?=
 =?us-ascii?Q?nR2SQk0PiyVowE/Y8+IAqUAFkbIBoflsMtFEARRQIRLNBKzV4Pl8WGKMzNuf?=
 =?us-ascii?Q?1viJfDEpoCvIv7KMWSdfuPLiShiYs3MDla49C5auLo2tGroqoTGKPtKu3Sf3?=
 =?us-ascii?Q?+LsM4jdepny+xnfbhsnlAJU+D8HWcl9raqtcW/3EczBShafbKlC5W3gnFJ6t?=
 =?us-ascii?Q?iLDths5URaUShPW3vj+fhfoJAeoI+YBG4zRG0mCD7RdflGrtuVrIYhyBrLMo?=
 =?us-ascii?Q?5W8EvmmpOdzjm+ygarY5dcC1L0NnZ7CSumQ3cR3paEg6PWkU9sG7AstpZmk1?=
 =?us-ascii?Q?4KMI1wXw2QmrbYXYFEqBZM59Lx4alOiXjLk6dY4bu19lRcpHM+WZFn2OaYyd?=
 =?us-ascii?Q?cjoBVBZrT2q3tJyD+gnDsnzGCJ3uDmG06fLddqtcN9Q2ZZb4JLnqAPsxLT9g?=
 =?us-ascii?Q?1QkDsPlN5NDk4LDno7fY3DS4Kn/ApljVFX6nz0dZNvphiGEjdlsYzHageSjA?=
 =?us-ascii?Q?M5ps0HQUcrTncd27T84EnFliFN5q+PxX1AdtC9QhLJyigeYEsHpqItlNRaEC?=
 =?us-ascii?Q?FAxYgJa0D9g6P+/feJjnnCMfPMzv97j0mvQQwkdS5YxR8H8vbYBhXhhlFopn?=
 =?us-ascii?Q?BmG5Q/ja8dZWpePqhDAV1gnWS5Vg6lgrgUWyYPXLSXzmKFBx3TNscpytVeBl?=
 =?us-ascii?Q?uON8LltS+xjOyilVPvMcPY7WcGStDx/5HvP3XH3EY+yueyfyHgmr4Uiydi+V?=
 =?us-ascii?Q?TQ9OdUy/wd3GXmNgTNpz9iWKpLO86iBPtZI2Chg5IQL3tPRdwHp+L/uAbMaF?=
 =?us-ascii?Q?zAaf59Qge+574LszKv+uKDa2xyRAWfAvu/zmjk8IMZFwgP/A5XlMGUF+kzOC?=
 =?us-ascii?Q?WFeE+bqopDNo2ipoC55EioDZ/S3MHBXdI1WjvpnVrw5I83LaCcOgiMHHBM1P?=
 =?us-ascii?Q?6O8pfcQaAc58xmciN/Z+H/v/AP4dW8NQd45FKuX7iNJwtjVXGN5751bRV73H?=
 =?us-ascii?Q?J5NoDkURSK9++JUNivTJYhm3XOR0JJIDN2fx3jx2?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d3f5df-1643-4e96-ae3e-08dd9cdbbcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 05:02:53.4992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aX4ktDy4NN1+ikwZS2Xiy00p84CC3fyPLtFrQgChx5XLGtZNc5+3szLK6LzrfJy3r/GDtVjloedU7l/We6NWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5500
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=68354780 cx=c_pps
 a=7vwyDArvsyb7TjvEEVmE6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=yMhMjlubAAAA:8 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=RpNjiQI2AAAA:8 a=NP9EB6usdDnl2zap_o8A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: q5x2ayIlpa8tRf6X0eBJaipFZInM_BTb
X-Proofpoint-ORIG-GUID: VfWD147E871j50rnqWmsQI8VT_ekYFRZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDAzOCBTYWx0ZWRfX29t7eZdxP6HK
 sYwzLbvDq9gAwUZQd2B0Zo16+7Auu1e8ccXw+iCFv3iVW/spFDDu2xk/dLKy7tQnwnqtdHW//Zu
 C1UHIZAdSs1303OzLvwR36hahPWIKBqdKdPHxAN7k2MqqUEQOXGDuiPtf378p2a8oFQNw7vqChF
 eUQs5uBhVLd/RGL22ySYSUz2L+6y5tdv8D5QzkyghcO0186BN/q/amrWz4rQajMWa3coT8JMy7Q
 AnALCUPuKWVwumjEaAX6sGLJ1SOe2ZWi7SZYWk33f5mNXWQEE3E5xyG1I1iD77wrBYPUcIPEzeu
 VDFQE0OecvgPycaxS/ceqJp8GslwaRa1rzI+PcwmeVyNuIhrGBkEI7GZpl1DU+5uRmFOn0IyVpN
 5geJAQc4eZr5RK3hVvF/d3Hza+kyOckd0PBJoFOUdJ+lOZ4giP8+lJn7EdgGmwvpjXgbWjVw
X-Proofpoint-Banner-Trigger: inbound
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="us-ascii"
X-Proofpoint-Banner-Convert: 7bit mime entity
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_02,2025-05-26_02,2025-03-28_01
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

<!DOCTYPE html>
<!-- BaNnErBlUrFlE-BoDy-start -->
<!-- Preheader Text : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;height:0px;max-height:0p=
x;opacity:0;overflow:hidden;">
&gt; -----Original Message----- &gt; From: Andre Muezerie &lt;andremue@&#82=
02;linux.&#8202;microsoft.&#8202;com&gt; &gt; Sent: Friday, April 4, 2025 7=
:&#8202;18 AM &gt; To: Nithin Kumar Dabilpuram &lt;ndabilpuram@&#8202;marve=
ll.&#8202;com&gt;; Kiran Kumar &gt; Kokkilagadda &lt;kirankumark@&#8202;mar=
vell.&#8202;com&gt;;</div>
<!-- Preheader Text : END -->

<!-- Email Banner : BEGIN -->
<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerStart</div>

<!--[if ((ie)|(mso))]>
  <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" st=
yle=3D"padding: 16px 0px 16px 0px; direction: ltr" lang=3D"en"><tr><td>
    <table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"paddin=
g: 0px 10px 5px 6px; width: 100%; border-radius:4px; border-top:4px solid #=
8d8c8c;background-color:#D2D0D0;"><tr><td valign=3D"top">
      <table align=3D"left" border=3D"0" cellspacing=3D"0" cellpadding=3D"0=
" style=3D"padding: 4px 8px 4px 8px">
	<tr><td style=3D"color:#000000; font-family: 'Arial', sans-serif; font-wei=
ght:bold; font-size:14px; direction: ltr">
	  Prioritize security for external emails:
	</td></tr>
	<tr><td style=3D"color:#000000; font-weight:normal; font-family: 'Arial', =
sans-serif; font-size:12px; direction: ltr">
          Confirm sender and content safety before clicking links or openin=
g attachments
	</td></tr>

      </table>
      <![if ie]><br clear=3D"all"><![endif]>
      <table align=3D"right" border=3D"0" cellspacing=3D"0" cellpadding=3D"=
0" style=3D"padding: 4px 0px 4px 0px"><tr>
	<td style=3D"direction: ltr">&nbsp;&nbsp;<a target=3D"_blank" href=3D"http=
s://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!ui3X2N84rjX7-6H8OTxazm=
Jjo_xUk5sCW4avCIe8HC32Ay7VBUIVjTS6QE0otnV5zt2waJ-2pmAoCKTKqwiWMq3TnhAjUbj0t=
Zr74LH0sCSE4z6SMPjSWmobwfrmrzpLxIm5kZI$" style=3D"mso-padding-alt: 7.5px; p=
adding: 7.5px; border-radius: 2px; border: 1.5px solid #666666; "><strong s=
tyle=3D"font-weight: normal; color: #000000; text-decoration: none; font-fa=
mily: 'Arial', sans-serif; font-size:14px; line-height: 40px; ">&nbsp;&nbsp=
;Report&nbsp;Suspicious&nbsp;&nbsp;</strong></a>&nbsp;&nbsp;&zwnj; </td>
      </tr></table>
    </td></tr></table>
  </td></tr></table>
<![endif]-->

<![if !((ie)|(mso))]>
  <div dir=3D"ltr" lang=3D"en" id=3D"pfptBannerk7commz" style=3D"all: rever=
t !important; display:block !important; text-align: left !important; margin=
:16px 0px 16px 0px !important; padding:8px 16px 8px 16px !important; border=
-radius: 4px !important; min-width: 200px !important; background-color: #D2=
D0D0 !important; background-color: #D2D0D0; border-top: 4px solid #8d8c8c !=
important; border-top: 4px solid #8d8c8c;">
    <div id=3D"pfptBannerk7commz" style=3D"all: unset !important; float:lef=
t !important; display:block !important; margin: 0px 0px 1px 0px !important;=
 max-width: 600px !important;">
      <div id=3D"pfptBannerk7commz" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-family: 'Arial'=
, sans-serif !important; font-family: 'Arial', sans-serif; font-weight:bold=
 !important; font-weight:bold; font-size:14px !important; line-height:18px =
!important; line-height:18px">
	Prioritize security for external emails:
      </div>
      <div id=3D"pfptBannerk7commz" style=3D"all: unset !important; display=
:block !important; visibility: visible !important; background-color: #D2D0D=
0 !important; color:#000000 !important; color:#000000; font-weight:normal; =
font-family: 'Arial', sans-serif !important; font-family: 'Arial', sans-ser=
if; font-size:12px !important; line-height:18px !important; line-height:18p=
x; margin-top:2px !important;">
Confirm sender and content safety before clicking links or opening attachme=
nts
      </div>

    </div>
    <div id=3D"pfptBannerk7commz" style=3D"all: unset !important; float: ri=
ght !important; display: block !important; display: block; margin: 0px 0px =
0px 16px !important; text-align: right !important; width: fit-content !impo=
rtant;">
<a id=3D"pfptBannerk7commz" href=3D"https://us-phishalarm-ewt.proofpoint.co=
m/EWT/v1/CRVmXkqW!ui3X2N84rjX7-6H8OTxazmJjo_xUk5sCW4avCIe8HC32Ay7VBUIVjTS6Q=
E0otnV5zt2waJ-2pmAoCKTKqwiWMq3TnhAjUbj0tZr74LH0sCSE4z6SMPjSWmobwfrmrzpLxIm5=
kZI$"
    style=3D"all: unset !important; display: inline-block !important; text-=
decoration: none">
    <div class=3D"pfptPrimaryButtonk7commz" style=3D"display: inline-block =
!important; display: inline-block; visibility: visible !important; opacity:=
 1 !important; color: #000000 !important; color: #000000; font-family: 'Ari=
al', sans-serif !important; font-family: 'Arial', sans-serif; font-size: 14=
px !important; font-weight: normal !important; text-decoration: none !impor=
tant; border-radius: 2px !important; padding: 7.5px 16px !important; margin=
: 3px 0 3px 16px !important; white-space: nowrap !important; width: fit-con=
tent !important;
	border: 1px solid #666666">
	Report&nbsp;Suspicious
    </div>
</a>
    </div>
    <div style=3D"clear: both !important; display: block !important; visibi=
lity: hidden !important; line-height: 0 !important; font-size: 0.01px !impo=
rtant; height: 0px">&nbsp;</div>
  </div>
<![endif]>

<div style=3D"display:none !important;display:none;visibility:hidden;mso-hi=
de:all;font-size:1px;color:#ffffff;line-height:1px;max-height:0px;opacity:0=
;overflow:hidden;">ZjQcmQRYFpfptBannerEnd</div>
<!-- Email Banner : END -->

<!-- BaNnErBlUrFlE-BoDy-end -->
<html>
<head><!-- BaNnErBlUrFlE-HeAdEr-start -->
<style>
  #pfptBannerk7commz { all: revert !important; display: block !important;=20
    visibility: visible !important; opacity: 1 !important;=20
    background-color: #D2D0D0 !important;=20
    max-width: none !important; max-height: none !important }
  .pfptPrimaryButtonk7commz:hover, .pfptPrimaryButtonk7commz:focus {
    background-color: #afaeae !important; }
  .pfptPrimaryButtonk7commz:active {
    background-color: #8d8c8c !important; }
</style>

<!-- BaNnErBlUrFlE-HeAdEr-end -->
</head><body><pre style=3D"font-family: sans-serif; font-size: 100%; white-=
space: pre-wrap; word-wrap: break-word">

&gt; -----Original Message-----
&gt; From: Andre Muezerie &lt;andremue@linux.microsoft.com&gt;
&gt; Sent: Friday, April 4, 2025 7:18 AM
&gt; To: Nithin Kumar Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Kiran Kum=
ar
&gt; Kokkilagadda &lt;kirankumark@marvell.com&gt;; Sunil Kumar Kori
&gt; &lt;skori@marvell.com&gt;; Satha Koteswara Rao Kottidi
&gt; &lt;skoteshwar@marvell.com&gt;; Harman Kalra &lt;hkalra@marvell.com&gt;
&gt; Cc: dev@dpdk.org; Andre Muezerie &lt;andremue@linux.microsoft.com&gt;
&gt; Subject: [EXTERNAL] [PATCH] drivers: remove __rte_used from functions =
for
&gt; compatibility with MSVC
&gt;=20
&gt; With gcc, the macro __rte_used translates to __attribute__((used)). MS=
VC has
&gt; something to the same effect, but harder to use and with some limitati=
ons (one
&gt; being that it cannot be used with "static"). Therefore, it makes sense=
 to avoid
&gt; __rte_used ZjQcmQRYFpfptBannerStart Prioritize security for external e=
mails:
&gt; Confirm sender and content safety before clicking links or opening att=
achments
&gt; &lt;https://us-phishalarm-
&gt; ewt.proofpoint.com/EWT/v1/CRVmXkqW!t83ZtR_UwpW61E99mn37ThGThaB6
&gt; gt7spCdfZvP9Yz5DLa-AKWhfbPLLmgyDnTM_FczAEE3KDso8-
&gt; QC5MEstA0f8Xb8gLd9dJN3BVWrFMpv9DT2-yl2l$&gt;
&gt; Report Suspicious
&gt;=20
&gt; ZjQcmQRYFpfptBannerEnd
&gt; With gcc, the macro __rte_used translates to __attribute__((used)).
&gt; MSVC has something to the same effect, but harder to use and with some
&gt; limitations (one being that it cannot be used with "static"). Therefor=
e, it makes
&gt; sense to avoid __rte_used in some cases.
&gt;=20
&gt; The functions modified in this patch don't really need to use __rte_us=
ed.
&gt; Instead, these functions can be involved in same ifdefs used in the ca=
llers. That
&gt; way, they are only defined when needed (when someone is actually calli=
ng the
&gt; function). Doing so makes the code compatible with MSVC and avoids com=
piler
&gt; warnings about functions being defined but not used.
&gt;=20
&gt; Signed-off-by: Andre Muezerie &lt;andremue@linux.microsoft.com&gt;
&gt; ---
&gt;  drivers/net/cnxk/cn10k_rx_select.c | 6 +++++-
&gt; drivers/net/cnxk/cn10k_tx_select.c | 6 ++++--
&gt; drivers/net/cnxk/cn20k_rx_select.c | 6 +++++-
&gt; drivers/net/cnxk/cn20k_tx_select.c | 6 ++++--
&gt; drivers/net/cnxk/cn9k_rx_select.c  | 6 ++++--
&gt; drivers/net/cnxk/cn9k_tx_select.c  | 6 ++++--
&gt;  6 files changed, 26 insertions(+), 10 deletions(-)
&gt;=20
&gt; diff --git a/drivers/net/cnxk/cn10k_rx_select.c
&gt; b/drivers/net/cnxk/cn10k_rx_select.c
&gt; index fe1f0dda73..658a434d75 100644
&gt; --- a/drivers/net/cnxk/cn10k_rx_select.c
&gt; +++ b/drivers/net/cnxk/cn10k_rx_select.c
&gt; @@ -5,7 +5,9 @@
&gt;  #include "cn10k_ethdev.h"
&gt;  #include "cn10k_rx.h"
&gt;=20
&gt; -static __rte_used void
&gt; +#if defined(RTE_ARCH_ARM64)
&gt; +#if !defined(CNXK_DIS_TMPLT_FUNC)

Please change to #if defined(RTE_ARCH_ARM64) &amp;&amp; !defined(CNXK_DIS_T=
MPLT_FUNC)

</pre></body></html>
