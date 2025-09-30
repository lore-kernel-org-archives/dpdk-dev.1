Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46657CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 14:47:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 787204025F;
	Tue, 30 Sep 2025 16:47:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 250C640151
 for <dev@dpdk.org>; Tue, 30 Sep 2025 16:47:09 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBcv0e032149;
 Tue, 30 Sep 2025 07:47:09 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020104.outbound.protection.outlook.com [52.101.201.104])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49geh1rek2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 07:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLv+JKULzQtdgyLRC0tTQbOdl+NqvPlXhkNwMzJSCZPtgBzXvqphNYNC7At6Ie5d7al/vQ1G7viUuoD6va4X++GXZmFllFqXclhiP3W7hZ0h+mEnA/aVx7r85lScfHvCFrqGWQ52ejY6MRxpWsIEQM+TrsDLhKuhu+RJyu6xzFYKO5zRmRJR1QmeWduQvtdhx3Jo+gSiYo3GLlmBiLMeuAgy8bgT4eBuEFVcZTy/lDPQcjwx/jDkVNh5WQh7kN53FQoFfmicY5WeA+PcVNay4lexgwnUayOEU5x2+FMr0LfgrfiAk1mXpuK7VEL1NMY9iyIsw8ZW6BlF9z5ttuL1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlOSTuSG/xKC0tbATDN3F17h4u7DoPTUzDf0prWje6E=;
 b=mw6o8iSS4NVHGTsfQqTH3Q7vOxCX/n+tU3pZ/s8FCiIt70hu6lKNDIVQUQNlKSgD7KX8XBgTwwHjNnGSLgv4SP6fnFRmrpx5QE9VGdARur0Mq0qmBG/fNZwkwT3YG/XW2kO5Tp8ilYz8CP0DI9xRrAAw2IDNlZcr0uPDdI3EZwz8dnpP7/roKlALaiAbOcHjW2CbqYOYDoUuPhtd7knPTwvPRUgIxlhmhXOL45g/8B3/mcb0EHjwE9ZjSOc4wtBNBHFdj2FNq5Fy6gOUgAuEeJbJh+P5ba2KLnqvsHxlwt9fMpTIQR3tj1TNzOxowD2e1lFTCcLQK6KhzCw8nXWaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlOSTuSG/xKC0tbATDN3F17h4u7DoPTUzDf0prWje6E=;
 b=lnJYvHoGwoxZDv6ZTfP1jcxaGrzRBzCa7GskXP0kL2ajgaHBwTFvaQIzsD8Wn3Xy0OwDqBSn3VsEZZxhfeGf1N4srG0x906RzFXg3JzGtMLyOXI3/IL0NB9hMrxG4dFbcohkj+GhINuAUuWzQp2R5CNOYaBuGzQ2LRnKB2EyLsI=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS4PPFD2021F577.namprd18.prod.outlook.com (2603:10b6:f:fc00::ac2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 30 Sep
 2025 14:47:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:47:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [dpdk-dev v9 1/3] cryptodev: add ec points to sm2 op
Thread-Topic: [EXTERNAL] [dpdk-dev v9 1/3] cryptodev: add ec points to sm2 op
Thread-Index: AQHcE1XFJZPUjmKa10KVOEgDeDchwLSsC0uA
Date: Tue, 30 Sep 2025 14:47:01 +0000
Message-ID: <CO6PR18MB4484FF394ED5DFE3FBBF2570D81AA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20241104093610.20426-2-arkadiuszx.kusztal@intel.com>
 <20250822111309.2506329-1-kai.ji@intel.com>
In-Reply-To: <20250822111309.2506329-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS4PPFD2021F577:EE_
x-ms-office365-filtering-correlation-id: 411737a1-45b0-4a8a-9be5-08de003036f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?bG8j9tIiAUPxGWAwm8QswM5zM6le9vq9QtWX4V+ES3rq2MtBo2cBgLRPC0ED?=
 =?us-ascii?Q?iS+9oneJUJrmlG8hLdYlfLpmrckcCYRDQuY0jT2pC481mV2ach77t/StGyly?=
 =?us-ascii?Q?DbExjoGUcza76LqBdMeYbsE66UeMhf8V/DGda+tLZkQmjE2qRp5CxdxHqoBW?=
 =?us-ascii?Q?2D8iGLdJ7c5vCjwoaxGoDj8GuPxvuU5MB2jE74EleP4AU4Cm7zqhDhJukeph?=
 =?us-ascii?Q?ZlQXuSxTFZtV9fCjbBBiAMEwfwPjpCKlH78TajzecvGkoIfGa4LdGC93kR6F?=
 =?us-ascii?Q?fBiU/vqhD4+EHLeSYY4oGt6pmHEQumEBbkOgicMrdL0MKH0iioUPZ69yoo7x?=
 =?us-ascii?Q?S9wEzVAIqN0ZDGR2Fv2XYzKJL+Ana2wTU9FYCYbj3iYcZB65mVEe4e4ZBFFu?=
 =?us-ascii?Q?fD4oghxfYjgMp/L+ENTlG00L2RDD72pUvwD9suIBEhZghSCWOhneUNwHg3dz?=
 =?us-ascii?Q?tGSZB8oG9Cx5eznYiNz/msDU4wYXgGZ8JIN7XJqBk7tE0tIK2B+d28JQQOl0?=
 =?us-ascii?Q?U+V24+dgXs25gvXdN8zxO+IJZlC4KTjcabAc3aBHoYqUAvadb0jD+Cuj11We?=
 =?us-ascii?Q?g05F3TGWP5dPRbcCeR9dDGkb/8GbrVU5uZQNWO/IbgwkqvYb8zHspNOvMd/Z?=
 =?us-ascii?Q?MASK5hIyclyY6GP0VrFVBPfBD4LDZPTEcM8A95+QFAEtpAJ3jzmrHZdngZ0L?=
 =?us-ascii?Q?29qB8jcyOCSxJcPx6ZZsB5G1vumgQK59qXR3qKvekEOjL9YUoW+I24K4lUjh?=
 =?us-ascii?Q?ZImJjI1H5AxNL2GskuN+gYUKbB9Y5xt9MePCFiRC4nK0oKyv0MuIHJ0Jw6Xm?=
 =?us-ascii?Q?el4m7mEJNX0bHkJ9jI2ew6U71+WDZdloFZyP7U3ahAqSwCvNzfqUmad3+CLl?=
 =?us-ascii?Q?P77wN5S0HZCDUFGgQcUBj59SD+ILE40xPWRsQf0HzgiRpAICbTvZUq4xxSmm?=
 =?us-ascii?Q?N7MG1C4kNcK1AU2GYuWg3G2VIydo72/LZaiat6nAw90KU+DLKJ/m22HBfCdi?=
 =?us-ascii?Q?xiwt9P5cyNzhVyGLfvyOjsi4MQzy0cxqSJ6WVmy6OfWw27n14hCf7Y9l6B7/?=
 =?us-ascii?Q?BaTQbZ5j41TqhUCJFp8ilDFrQKm0sr4xEBk71BtfFBtW2Qs2v4gQSkYDwqVt?=
 =?us-ascii?Q?D0F8V9nkykEBHdAeM+zhWGU8envukEAJYmrGEyhSSFPnkm4jphtsK/mfuYVk?=
 =?us-ascii?Q?tmOC60JzgcMr3Zv/vRuRB/oNNfxQHHZVhN+RLqhd57rbdSSgYYdAlN2oLMLa?=
 =?us-ascii?Q?0kIuIFMzu15gyBxcp+Yeec3wDdEEjrOgsLkZ0sBR7Vti/ljevqGYGPMTtJm4?=
 =?us-ascii?Q?hNimkH1tZoy/PV3B1iMxSxkDou4tX8o9u1FA4+G3sVxAWXUD3ruL7mDdNZJR?=
 =?us-ascii?Q?t7eMo6AEmAaNN6BEUPjWnwAj+U3WOgT+XLc+lBHCKWyrw+eI4wKjz4mFbFsF?=
 =?us-ascii?Q?Kwoh48BzzkEyWi9nxqpA1yjPrXs10rbHdNPNzYmjma2co/1ukafiipPPMqei?=
 =?us-ascii?Q?JMmXbxOymne8vip0HAdoJLJxO96PicW1Eu3/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3VxMTGlIg9auw35of+wUXc4Hi9UTvRD/r8p/upHvx4PlkVCOCEjPffMZbBnp?=
 =?us-ascii?Q?2H7TZ2XGUFCvYyv4mn41oqpOdB5nsKPB1I8gJ/NO4EdTsjpWvoag0uxwt/cW?=
 =?us-ascii?Q?QjJEINbkCVu0cz/Zfr5P002RE66mbMyylihBvkhStVbnQkv2veS0v1a3c8dA?=
 =?us-ascii?Q?2DVhbE1D8A46zC5jGg0lZLNzI3atEzs/jYDNQrPipftIlEJiMhQpkuKr5+1W?=
 =?us-ascii?Q?f87B9sT9gD69K4Wou2FJAAN/TeyQs/JKnuWpTLNdWk8v7V13KI7dEYr/gIrr?=
 =?us-ascii?Q?xBwfXzBRuf6l5dZLaIhrPHWSbYdZshs8h98xN0JL/gqE3aN1nM7LkYvl7X1/?=
 =?us-ascii?Q?eGGIvFAgglmmmZrSHUNiWOhA/GrFYX5fBrNYM3A5qp7L5mqCNAmDgJZ2JxX9?=
 =?us-ascii?Q?vYEs4nuLeup/nla4qRBs6RxCPZsqw+/dZQgrhQKdAmm6N1Pn4izQDLVC9cUq?=
 =?us-ascii?Q?F3GRqroMUbk81D6vEESb1g2k37RgqUylcJYuTJM6c/ucVeOLFOccBUd806cu?=
 =?us-ascii?Q?ragpqP9xDEEC5OMDUJLdQboRbzwc3rHNbtVGvn6Dn62MQiis+qVup8uz45vz?=
 =?us-ascii?Q?LLfF69GbEDyTJ0SEvhL8Tph6JUEs+DbSKept200VuUtvs2l82JGECAlmJ5Xg?=
 =?us-ascii?Q?fzDMPrJoGkH0LwQEQezyzauIWUi9eFvDSV1H8BuKW/QjccwmBJ+MKRlSrXwU?=
 =?us-ascii?Q?ZC2rTeiPOn5AxUJucSEUfHyZxnyJHfriB0Pe3Qx20VIKHNMoDd4RPihdjs7o?=
 =?us-ascii?Q?GtRfpzNBai6Nn7YV7GzGt/HAiofWJiXmckrv8+ljNBc81wRmVwF3GgRJidM1?=
 =?us-ascii?Q?vgPNI4m6E6+oKe+iFdla/fakW1LsEdO04up3wQ05TK2cho1CepcYa6zmGFLi?=
 =?us-ascii?Q?xhPH2r5OXVdWHsFaOs98g3vbbQSoqfr4qAYTPporUBnec97Vc4Q28BiSE/i9?=
 =?us-ascii?Q?CoBQJ+TlhZ5S0JOZp+Za6zZeXs5s3uvzswWr/1kXuLnsZ//2Y6EVflzb7IWc?=
 =?us-ascii?Q?gp+5oDfJxxJlJsP565ugsEtLgveHklPJdtalHTbiefrz0jMRgZug6OZMT4+7?=
 =?us-ascii?Q?U/Ty5pXspuloMT+gH/yGG+UEMQMpTtYWyOgkbUQdykQd6vT3NSqpO4Ll1y1y?=
 =?us-ascii?Q?zD19t8jJMOqOKzOcqit/EivCyp9xomX0Zj6GG4/GLJETOLZcb6qM9eD0KcaE?=
 =?us-ascii?Q?poYJtvk/Tzi5bHzGhXHbx2C0yP3NV1dUqhHqId9rw6KwPF+7HK5JRXE5UYVb?=
 =?us-ascii?Q?GsNedC+oVTxpYl19CkNdlTChFmmhn7gcCDkEgw/tq8PrrK4IMKoQI1MPJiS5?=
 =?us-ascii?Q?QO+JeeXzQFkTy9s3IE7skrSKBOFYiYuMWppU4BodazUaD6seRRT7/EYW3rQZ?=
 =?us-ascii?Q?9WIHiT/XLlVw4knJecl+bgBw/fyADe/bjbMu3pbqVXTgmFg6jCmsL9tYgqGW?=
 =?us-ascii?Q?+OH/hOQL8QifHPQBxdT/4R2qi5q+N9ralib4Ko0qJ4Inobvc5TqUDtsgoBoz?=
 =?us-ascii?Q?xel/XC0Vxn2SBVuLmFLFmNg5AJCbj3iUHaN6Ir8fCGINIIUPIAmY7t795RHu?=
 =?us-ascii?Q?FFaBs84dsuIxy59S52A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411737a1-45b0-4a8a-9be5-08de003036f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 14:47:01.3651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: llPco1GRPVFls1jLLseTpnrwsi3kz2OD2qjwPj41k2765kAmz3/N0BZMi1SFmXtWFtkYe39A3uuq+Ukc04aXGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD2021F577
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDEwMyBTYWx0ZWRfX7h3KlsZioiFN
 LAG8eZPhoIFMoe1AlsVq4yKXIgt5/+P+DflZs7R8jFGSDRWj3/GcSzmZp3mXw2Cn5wMuR/co09p
 gnTAnjEe9tQv4OorZxTOaQYXC3CwaXy2G/V1FXahViZmYQbGLoUbehMxKtIBk+uxh2QZq4uuTAN
 5vOJzdeRbXIZtcJfGmeODv7Sig5rMmjSiGqEFjp3q745TWISbTG5aAxepeuWUhA68fnPETy6uRE
 /yJJqn0N5JT+p/Q0mYipmp/IYIqxkZShKjIZlwt6yT89BmQBxnkxef+6I3MSMWoe4Ux9oMlOSWe
 H/HB8TivfgC6T36rlBFkf3dip1XOs195SvSW9orkUyQUOmrO9tCE/ih5sThX5Nvcuubw38DSjCr
 bF4q5bbko6yFp3wAro/x+QRAKmT3RA==
X-Authority-Analysis: v=2.4 cv=VaH6/Vp9 c=1 sm=1 tr=0 ts=68dbed6d cx=c_pps
 a=B7gXSpqx/RQOSxVPsCzpGA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=QyXUC8HyAAAA:8 a=AlYk2rm_vvrnFkEpbTcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: c54oNjXuoRHoMW4uBNQxr0tJ7Ka-Nehm
X-Proofpoint-ORIG-GUID: c54oNjXuoRHoMW4uBNQxr0tJ7Ka-Nehm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
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

> In the case when PMD cannot support the full process of the SM2,
> but elliptic curve computation only, additional fields
> are needed to handle such a case.
>=20
> Points C1, kP therefore were added to the SM2 crypto operation struct.
>=20
> Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
Series applied to dpdk-next-crypto with some tweaks to release notes.

Thanks for the patience.


