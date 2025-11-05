Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7D0CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 13:53:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DDBC406BB;
	Wed,  5 Nov 2025 14:53:55 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2A252406B8
 for <dev@dpdk.org>; Wed,  5 Nov 2025 14:53:54 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A59ujEV004889 for <dev@dpdk.org>; Wed, 5 Nov 2025 05:53:53 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021139.outbound.protection.outlook.com [40.107.208.139])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a70ec82ue-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 05 Nov 2025 05:53:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk6iSXf0zAmAs+aOQvF73LfM74luDV2SPAO5lXYsNAafZQdYpUEMjp9Ah+twrK08MxffGPvRXFAQak17gWVN/3/iII5Wy2UEHRvq0YFb74Am0wEPMr9e1K4F5+ZgXEW+E3C9XlVsWZ0Wt39AUngq8ez18cInHEXGvBZhLyXwjPWYm+o84RiVt/Z+dbiXTtcRIejn+/sIpQ/fQ6HzAR7TTTJRGyHyWWLepfglNmA9n2jnqKir4mY1SHBnL1VD4prAIu+XPNLJrzFe8WQOgck9RacoH3aGXL/hj0NAL9LoughOn6rROj2AcRMqE4qSYW1cm83GtAI5ZB1hxGKW0HGi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A7gBBTMwvi+3+SmWj2F4Ig1GLOhif37SPOiMGBjNS4=;
 b=iNCSXagUExU24podVM6DiiYW7ur0CTJr2vdAdyQNVsTAcWedo81Fuh3vApzHD0bDNuPjK/3ynjkQATlVmktyOwTfG0nsDFj9zN0Mx2Kobc73+teaadWAolzm7JX60hjIuKqKENsOTaSZNHWVNjtsYwWq3XZ9GfkMRaGo8EnuB/aGHiKZ5oCRxFh95Y4HpXW3Q+9xQv1xF2pqZYyWXY0y3OQCqKNts5MQyjSMIJb0Z9AyJf0uMu0rN5irgdMFiL1OuZ2x9XVXAuIP6l++IG9oO4TEMhifkAUeDqYzQNhYZkgtJ8gcWsDV0MJdJVX9GQ02Jcvd/60cDX3JGkENxouNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A7gBBTMwvi+3+SmWj2F4Ig1GLOhif37SPOiMGBjNS4=;
 b=qGURGy1lsYmKjYP5nq+mlVYqd/yP+AEe+NT/UkuHFpMG0LqMW6nQwlzkKQu5H/CLpV+nUy1rpklKmEvS4ZEfCgAnbJUjzdiK6tYvevivrHPrirra0vZvxBn9XFCKlu3XWOTA8OvaHgu6pvkeAadh7dGHeRcGGzSMDHBdAoUhp24=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by BL1PR18MB4295.namprd18.prod.outlook.com (2603:10b6:208:311::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 13:53:50 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 13:53:50 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: RE: [PATCH v3 5/5] drivers: net/cnxk: enable CPT CQ for outbound
 traffic
Thread-Topic: [PATCH v3 5/5] drivers: net/cnxk: enable CPT CQ for outbound
 traffic
Thread-Index: AQHcTiM06o/1ak9kf0qTG2WWIf0nebTkGtlA
Date: Wed, 5 Nov 2025 13:53:49 +0000
Message-ID: <BY3PR18MB478507CEB299ABAFA470D025C8C5A@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20251029130023.1637177-1-rkudurumalla@marvell.com>
 <20251105070932.3569572-1-rkudurumalla@marvell.com>
 <20251105070932.3569572-5-rkudurumalla@marvell.com>
In-Reply-To: <20251105070932.3569572-5-rkudurumalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|BL1PR18MB4295:EE_
x-ms-office365-filtering-correlation-id: c9970cd6-c830-4994-d692-08de1c72bfad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3ff09YXYFxIj1h7dmbb2H+PfCdgsOkR0hgeyzsOItxPhkslDLYVie8+duqsd?=
 =?us-ascii?Q?0tlISxX0xPtkVC07cmEmABQtfNs1dXEg9HRq3l4WTkn8YaFL5J9FowTI/4UG?=
 =?us-ascii?Q?fFVMMIXm+2dDK8MDN699bSbgdr3JQrcL3F3+rgbvfPbnIeXDmNTCKjKWdjXs?=
 =?us-ascii?Q?6UhK6S75mGfYRfSs7wIeKGyQPOSkj+sAwWdNFqg2uNzMoX/CgEUJz/n5hxWT?=
 =?us-ascii?Q?8MgSKsizlABXSV7HOGM4DWuNtBywbFBkS455Hzsl92glcWugGQsQSA/MxN2W?=
 =?us-ascii?Q?x98sjuqaFtVC5N2006EoxPeS7NSGD5GUFk9mBUQwuoAnpabLstN71vUa2yXV?=
 =?us-ascii?Q?7eI4lJM4pqY58VQI0tm6IBXC/z4Q/spTzY/h7wTyaOzXRkM4PFLx5OAS8ep8?=
 =?us-ascii?Q?1ds1J+zATaNmPQXgC1L0rScycgm8Mkk3/DeAReXR4dlUfU6ygbVuinlVHhV4?=
 =?us-ascii?Q?PsezrcPeisKo7sxGgz1JhaAXwP2z9GNgN/kHkRszUsPQeBAZX/YwdJFq5RA6?=
 =?us-ascii?Q?R6uwuG3wsuJiWGbpbtAxrbHkYqEi9+5VuvbIokxDbjQBacMuIqE8s2Jb7lXl?=
 =?us-ascii?Q?TdzzXhly5O9lutZUcO8OZ8/7/xWpv+0JUQPf60JA5+mw84gaDPfLMutnIAkA?=
 =?us-ascii?Q?EvZr/GGprYBJU5NPmeqAi6HjLxzUOCoClNYU/+LjxsH5GVg45HYcMV0pWtk7?=
 =?us-ascii?Q?B1ZSuItPkeab7mEBOBaS6gaKdimKDj6GH7kwO336w4sDe7rDx5Po5sFJnmm2?=
 =?us-ascii?Q?cV4UVpjXo6cYKxy3fiq7His4QSytbfW9Y9Z5xV2FfxMKhZOBRSFveFf47d9a?=
 =?us-ascii?Q?WuAGDzDj5vN4Ac3CAtdovSk8SUB6PH0hnLHpEayT1SrEHlQhqge1GQaBHjFx?=
 =?us-ascii?Q?bobp9aLrqcVQ5J43BYYsLJEeJ7zdI/HBfPeZR7DIfAp6L0bWpq4lq39mALLn?=
 =?us-ascii?Q?Jg+im7sLMP9rLOfwEZjdoF88WNtHq+wd6AD9vlZ+RT/LbWEeXVDyp88kryoj?=
 =?us-ascii?Q?Ri7Xkh39bkhWW4uGgQ5Tvt2SMWpLAd6maUs2Q1meL/RLa23tqpDyZMC8C/HD?=
 =?us-ascii?Q?li6uyu5/yfqUw6cjMwNelhMqEvviMKPAuCfAyQVnBI+bmR+Ziy+pBASCXm6K?=
 =?us-ascii?Q?UAolSHXcxNn3TfL3oM1BpARKbr2CPSNxWGQv4gzTmCfBf9Wqf5q79G8JQXJ9?=
 =?us-ascii?Q?VuvCwW+2EPSqqR/J+bajaottKi854qQFweW8fgC1cBFCYwFvTe2div2sCo9k?=
 =?us-ascii?Q?bNf+j8xBPSnHWPrUi0uq7eI+l/yv+Y0G0XPU5pALL703oG/edrufwUc3xmSt?=
 =?us-ascii?Q?rFP4f3nfP/9nYa0n56y1p3Lkwu3Fp3qkyevTAUG4Ox9ZEWvsuK96O0TaTkix?=
 =?us-ascii?Q?0LhwOCz/ATsnPLTZR3Rb3LVBClaA1JjX1Lnps4k1TmQz5m0q19l8eoErDDCi?=
 =?us-ascii?Q?RmgEon3QGmFhAXLaK7erjZgFfoWxohdNtxKsdEKlyKfa9AfqYiZKvsTP3Kf2?=
 =?us-ascii?Q?6genT3Kaq5D4eXo5hjY13chsX2txmJHan9zS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jKEDLrXGy+1pRLSssU4y8XCyF7wPiFlcn+WgquTBRB0Ad+5DMpR/6XuTDyyx?=
 =?us-ascii?Q?kcW2H8GxyAU3YegZS4Bvy5cPPPOqj+gPGMbRRPT44MjlWAqu7DPQuN5mkq7a?=
 =?us-ascii?Q?8oAZIDwxBx4sg3B5EGj87JHbanuXKPofq3RKL8O1183eor3/7J3ZkZONBfc6?=
 =?us-ascii?Q?FCS0bNy223RmXU6rTGp5nGyQ4B2Cv8kizyGHSPtRpefRkfjN/i07smpTsWjD?=
 =?us-ascii?Q?0DE4pECokBX1yusITfPUE4NCwyaMmzraIlFcIEzpgq3tGHozCQFuVjf6p4WO?=
 =?us-ascii?Q?bQBLXhAFdxsfg9BWcNAFMNmSkXg1cFh5fuha24Mo7savSD19AJZ15DTE+sK7?=
 =?us-ascii?Q?MNExdIQg+bE3AOn1Nj8mAQjZIDyb+Dw2jCuMPQyFGpzZtO9xeT6N+OYRzFj+?=
 =?us-ascii?Q?ThVBa+FqRlbl4agGTxUdYMh8NNcQSFr6Vxcu9RUEPwBJ+Hq+kuIC/iPHRE9W?=
 =?us-ascii?Q?Q80ghuVLrLGWhTUUW0XAqBCxYjzzI39St3YLmj2rkyjEKOMfOEm5mGi9jPiU?=
 =?us-ascii?Q?QdO90I1gKU3H/RFx2YbfRRY9R05NpwzvONaUXJcAk3vyHdl2iXdUOaFGDsaD?=
 =?us-ascii?Q?sJAm+9NS1TrQ2fVI/YMkCJ4BR3B7r7eAgN4SFquGQEPy8vrhatSEuZUzVfbj?=
 =?us-ascii?Q?gPK8qbzFy759fT4TZ2fPMs6JEUkVZvjUAxRwJfjO7hCJ9jCl/HGmmUUvoTl4?=
 =?us-ascii?Q?us9pspHAGEr0iUmlrhwM438/dlf2sFMKBR1XCCHB6GK/zhOPEaCFz1Fi8zm4?=
 =?us-ascii?Q?2e3o+PNntsr2mplcj89+wyqGA53oHbllmbsg/AqM5rfH5A6JGJyuLI+qk6I7?=
 =?us-ascii?Q?WCel+dcjVhLaFbbAlnoUFd16TbukGRYuhYIf5A4L/vZ+Mb6RQhu0A86zyczo?=
 =?us-ascii?Q?NbNQn/aXL+KkGwyCQRLxWvpm8glmzlCGbpFYdbKm8B3TfhZ4wUTcF7HbmLDX?=
 =?us-ascii?Q?xr36VTbhOzJ3WKJ9BV1ovxgO/Dy36uyj62IunBMOS97Zm07kGZm8bjVLAA+P?=
 =?us-ascii?Q?mr8RFVxrRELdwHVi5XVbnFJqlTaTWpDdDlTz70YLc5Ep4ortnfWCL2z8w5GH?=
 =?us-ascii?Q?GBZULFRTJmkpOTt7jjYnqy+fYPsqlWpBk87461ZmRYW9PWneUKTsg49p/rCG?=
 =?us-ascii?Q?QwjFovApJXCLUhUbFNgAuOyWfdVlJULoYj6XLcz6Yg50FIq0kk9/OJVnR2uc?=
 =?us-ascii?Q?RI9OlBY6cHiy4zBZN+qs2I0R3XPHdXIFuk+qEBiNRo+bbKC/5yrKX7SWAiZ9?=
 =?us-ascii?Q?QM6xs8B7rCnhAoV3ihL/A/wbSpnXgdpPxwBmYCtQ33rgT6DtiSYieUJbtAry?=
 =?us-ascii?Q?3zqDR7zbJ7/Q941lanYtUoLjeEtrH0/Fd3JByAx9rvdGhgWBdI9iBj+uSYDD?=
 =?us-ascii?Q?X0jL3pu+HAunYB9Gom+fikrsqIeqzEyXdMaF4rPqQFMI8gqdFs9zPHFoCMtX?=
 =?us-ascii?Q?XC/MILXrP/clDmxCG71N6gLwFWD0y/HG3z0AhrFz6Vw38hqWjBvcks0GZXng?=
 =?us-ascii?Q?XvPkNtUQk/fmeyGrd9ySerrwMlFAyY83CGMQLmZ6uahPevobx7PQR61lDMZp?=
 =?us-ascii?Q?Uc0RUuXczM9Rl6KgNrFQJMhM86cbbaFPk85mSYJE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9970cd6-c830-4994-d692-08de1c72bfad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 13:53:50.0403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Og7CJf5c3PMI0ETKK88FvBX1PcdySsuYE1Zy6X22xHLQefq8BUb83hin6k7Kjx9JJzW3mrLpR99Ys631S3ZBwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEwNCBTYWx0ZWRfXz2BRWImvL/Sk
 igVo5kqiphnAjceHHaFCmRbmDgvone8ogRqfAmvItx5yQ99+4wuF4gVMHngTe5fnu//tpSxmGMD
 Z1ujExGAJ9vcBeQczSqa463CM5fvvV/gQLuOJnNslaA1vZo9vNi5n88ndfG7OF+OxbKNQOarqjD
 oYsZFiGmfSet4vHYirTvcZxgU9ZllJf8fZhGc5xIV8+e2Pp/c68ysrXBLUrUVx/EAVPi8YPJVYY
 0CPzeX3Qr2vnz+pv4hFq8n4ZK++VVghHJKiqU89ts8HdgGDtugZrFlOM/HDi3Nx+5tsRD7qKeR3
 NKcXYq5CZz/UcUfTpMUC4r+Dkf/ECO+3nxP2WekSlKEyXtTw6St8KImsaJWd0s+zw+uBICRnBWO
 0Bblt/534tRZvmsLNFO7ixRnNUMAzQ==
X-Proofpoint-GUID: 58Ma7Jb2cX1eGVE2_JWYW42btR_O4qTc
X-Authority-Analysis: v=2.4 cv=SomdKfO0 c=1 sm=1 tr=0 ts=690b56f1 cx=c_pps
 a=JZ4ed/MQfvNyfgwl2FRQLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=hyzfFt4yzDUfctxBFpcA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: 58Ma7Jb2cX1eGVE2_JWYW42btR_O4qTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_05,2025-11-03_03,2025-10-01_01
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
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> Sent: Wednesday, November 5, 2025 12:40 PM
> To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Sunil Kumar Kori
> <skori@marvell.com>; Satha Koteswara Rao Kottidi
> <skoteshwar@marvell.com>; Harman Kalra <hkalra@marvell.com>
> Cc: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Rakesh Kudurumalla
> <rkudurumalla@marvell.com>
> Subject: [PATCH v3 5/5] drivers: net/cnxk: enable CPT CQ for outbound tra=
ffic
>=20
> enable CPT CQ in cpt instruction to read outbound error packets from CQ
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
