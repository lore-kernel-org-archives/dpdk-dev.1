Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69549C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 11:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75F9C40285;
	Thu, 24 Jul 2025 13:05:18 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2147340262
 for <dev@dpdk.org>; Thu, 24 Jul 2025 13:05:15 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OAq1Wt005251;
 Thu, 24 Jul 2025 04:05:15 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2132.outbound.protection.outlook.com [40.107.96.132])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 483keu018g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 04:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1zWK+ajKdSwozdJPV7XOwWvpaPWuSxDBieOhUi2MfmrkxPuFqi8FC/HwAFSNP02G0ECdHt/Xhy3atnmFk/5duaIii2a/ZzpO+ubQvGTwztAJuheBifrOu00kGQ6jif6yiBXfiJNsofhE+o5bNXesovgSGjdNEHrcd/Ze66ns3qv1y/lEmwqvPSbratlAyx1/hWukBU7cU4b7lXF9RCzOTM4DR18AvzdxFxWc0zNwpgJqLCzEzubPC8N4CgbMZzJkvOgYxCv74SToz6wdHKB+yMSbSpXrPm2PPzKfT985bo0EweoecqLruGHGooUX8KaoYWREm+GxZGpqFZViJ2/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a/WQZf6cKKg/MSpVIjkXLbvrThky0mzIwa5Vh/BCMs=;
 b=kF51FjoWVnUuFeIqVCcz6mrdqBCzZXkVAb3sflZKLg39svmqX9sUml5NEH5Gbd8Y6GGsOl682zWYbrJn+RCkDJS+XQQfRZIYai8Ej9mK2+W+1wgSBTE/8g8RJGhHHXsIy9DY/4qyQqtCTaqEF9ojyIYjYeS9sZtVIJ0k6F/zCuxZh0kIOyIv1SFwoaVspX6z6Lr7RZX6PCp+oIw3LmfCNW/yVcewEHyJJ4K5He84m0t/8O7BL9Pixy3F9kgYKZ0U7WY3zjw9oieGcadvuFv71XpbTkDjynRr40ft7lizZAdRykqXbVPUXVwjVCH8YzfMGliawVOpHgPoOyBuEO4FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a/WQZf6cKKg/MSpVIjkXLbvrThky0mzIwa5Vh/BCMs=;
 b=jWcX4LNd4UjWSQNqEaipl9jBUx7CQjEztHXeXOo7NWZUV7w7/KvoU8Ct7qp1qRma3cQeVmmOzt5b2Kz12dwILL5aHl8SPy/EEosz6uBzVzR6c2/fWc7wXBS2jhKktLvXNJuPFL+Olfn97vX0PSi7Tb5o5ovkBwrfXrE4e0encVA=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by SA1PR18MB4678.namprd18.prod.outlook.com (2603:10b6:806:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 11:05:12 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::f458:534:2d1:7afc%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 11:05:11 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: David Christensen <drc@linux.ibm.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Sunil Kumar Kori <skori@marvell.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH] trace: force 8 byte alignment when --no-huge
 is used
Thread-Topic: [EXTERNAL] [PATCH] trace: force 8 byte alignment when --no-huge
 is used
Thread-Index: AQHb/C7F1DeiguZJMkS6WaCt0h7IhbRBHRng
Date: Thu, 24 Jul 2025 11:05:11 +0000
Message-ID: <BY3PR18MB47852312E4B66F4EC22851DCC85EA@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250724000554.114087-1-drc@linux.ibm.com>
In-Reply-To: <20250724000554.114087-1-drc@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|SA1PR18MB4678:EE_
x-ms-office365-filtering-correlation-id: f6750a53-afc7-4a2b-e600-08ddcaa1f59b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kyLbB4oEp3SWJEJbUflfsY4EZV/i6gUC/+S9Q0aQ/D0OT1puYuog+wiUSrq2?=
 =?us-ascii?Q?0tZw4Ri9pwjPJCm8DPLfkKWe/DGQV5HWoDVRGuE8WNhzt6brDBFDBJ4bmgeU?=
 =?us-ascii?Q?B+NpNKeAtLo2B4F4f/ThvmY4HOmmTlkC1CtDMfNY3cTragRg9SeiTWJwcE0r?=
 =?us-ascii?Q?5Ss0AQ5wYJhrFsBblkW8hnCjCsHuknVuVpoCKIeF2TxoFb1kD77Weymvl8Fz?=
 =?us-ascii?Q?I/ltF8Kg/dFdmLiTfC87yRIFFl92Y/3hl7UdojQURCjZ9dMh76FRsQrZjWZP?=
 =?us-ascii?Q?boliHU51vS1vS4Jf64K44g0fMIBQqLlzFV9GiQGYP5cjkOtIxtmH6q+WbIHi?=
 =?us-ascii?Q?W+2UGFomjyNw1psNLs1AB5HPbCbUbgSbWkfDI4EH1DUVr74eEbLyBdi1YMlA?=
 =?us-ascii?Q?Vq5t8sRoaEw65P/13i1J9To2TD3oBtAyTt2G6JHbN68coH4bTamug9w8IiSV?=
 =?us-ascii?Q?Mfrg85qqyJzuCotau/1qauLnTqBM7EQ6DB6Wn5nWTjIhgGrUX3zSbtPN4K1R?=
 =?us-ascii?Q?ESxwh5rdavxhlRSol270wbB/wTxaSRqvab134TIw/+WqQSxTYPuu48Jtn2TT?=
 =?us-ascii?Q?jEGtCGnMoBzFgYNfFs0gPs3lGflQ24cKz86jnm14PS0UvWllNQ0nHE7wnAWF?=
 =?us-ascii?Q?t4CeSkmXu5Ut7tgEAQ1OX13srC2pW0mUF5nc1bNgUIeDLBJHyKpuAV6g2APU?=
 =?us-ascii?Q?YaTaeaLYyeWviJAxsoOn1ZkD0kWw+ZkIE8nWqtBWXYep7p/n2HfN0KtOOk2N?=
 =?us-ascii?Q?LzwjI9lKbbmWIA12UfVtenrulXDbstRmK/6Qm72ZLEd7cTfs665Ab4qCG0Ra?=
 =?us-ascii?Q?BwcX7BcrOm4zPa13AEDvuaNwacoGsgLnqk4zlsTClZ8JKTBJxlmfgw8eNzlP?=
 =?us-ascii?Q?pxocwyPciN13JY1ApaEbNfY7+LpYq0OykTb8Ho1RqFcD/IMuxQFo+Pw7+7a3?=
 =?us-ascii?Q?0xBQiyUIC9KPF9IfuLYTw7kIE8M3uIXnfrzCbFED0alOXT2R6Lf7j1n3jouk?=
 =?us-ascii?Q?9K40kW39tIF6wwaP0X9+CzzsPYFC02EtUx/8s0CZUL7YNVvAlLdiYjiGsaMn?=
 =?us-ascii?Q?lXaKC3lw/+bzSWKtuktadsSaA9IqBaU2bCBCGz5G9GFgwfi6wGr48euCj9ci?=
 =?us-ascii?Q?7cm6JxFuQ6R0QyH/cJfUjb3EQrIFJ3+tX1BQI+a1XaXIavW623LBTtTHkgr1?=
 =?us-ascii?Q?X+dCHI5t322cebUu26dyk5lChXABYknZMKcDo5hgUi0dkKRIjHhyq9pZus31?=
 =?us-ascii?Q?i87BSTxto+iCfF63rMyEIB4XNe4QBqJD8h8FUpvqD/hh/aJB7ZfsstemsgNu?=
 =?us-ascii?Q?OVER7YjGry2Z8pxNiiptBhH2IPTumgmV/1cz85DI499dVM7iSd3dwt4gt5ar?=
 =?us-ascii?Q?MMt/rJ3LsYj1MJXhLmT4x2ZjMVbIFQc3M3a3ABIga8Uurj33ov9WCwxdvu8k?=
 =?us-ascii?Q?CwT+o+a1p4eiJEVfNMhqpMeEOG9kbvSPigCC43Q1ZGf4A4w4ffQ8nQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dd10ukByoHInilF9C3sevhEpyW5tYdzjxLDXTawUYPxXEu6DOrMqBhI7mlpD?=
 =?us-ascii?Q?2E+3Z4ClrXkLdNUpeh2q6QDl5tezeQsSYYJaakjtiwb+9dNCFIdnrgl/hnu2?=
 =?us-ascii?Q?4oeoRNeZfp03vQUs7XifUgX6RgfkANl0fxpxTPXYd7VMXYpX+f/WM1a+u1kg?=
 =?us-ascii?Q?8yzjYITioiKACN15CCmeYouP4SZINBdwkweB9Ebj3yS1daEWENEBa+xYBkmY?=
 =?us-ascii?Q?VhS5NPWlEYu46nxkt1TlWCTkdjknUZdsGbt4cvCj6ot11Z3+XD7CBRgsr0m0?=
 =?us-ascii?Q?44+HV1QnrRyGZK+VGXL5MYVyAQbmEBIw9lCrv/GUedXmRaqskscvvZLz6qOW?=
 =?us-ascii?Q?dKMTMYDLrmGvREVinYcuicUvH07afgds4OiSB4qW33nnL+uLwJdVlKEAVRw3?=
 =?us-ascii?Q?dDZXhkRznLbLNEudKdn4kgPMb1O5LaAindY2AHyq25rUvX6XE90IVRREj2vu?=
 =?us-ascii?Q?1ClR9kV91ZwmLkfQHgYbd6VoAIowEnISt1Vb6a6kUBbwJxiIhaJh0doyu1Ra?=
 =?us-ascii?Q?snH+QsrwoFDeY7So8h75wuUI08pg5nNXLZDwVPG2EWz07I1WIpJS7ByQLIud?=
 =?us-ascii?Q?QjqQsTSTPBOEX6AkFXI99iBNGlN1oII3bdWqzUQuY0FRJNMc22h+UtETdxxO?=
 =?us-ascii?Q?gEYZvjoK7tfl7MHb9RYt4A6a7O5SKQfxSNPmQTHbUod5l64we6qz+LTLIaGm?=
 =?us-ascii?Q?IZgsNJeXd/pHyASwv62aFHr9opYf5v0C3gYGJtOWKLC+1a7pV19SHb0M3G9j?=
 =?us-ascii?Q?RbHQU+Qw5upebZ+weI8rMzZbbsLTxTUO56BcacDiDl8NDgW6upfcqlvr0qKu?=
 =?us-ascii?Q?gmlkqxUJTrwKSp3oNOJm18/bcZa9a0QZLEjeUtm6tALbjTwaVcYQm3OR5NB5?=
 =?us-ascii?Q?5N9QEVMBlf0szLTJmsDEEkXycweKCuO8OX7rG1YdELUhUgqJapgnLyKVTAfg?=
 =?us-ascii?Q?iM1xNG4ai8Cct8fnoVh4Eyp70nW6deZBxgaaqRLFxtkB033kS85qw/gM3t+D?=
 =?us-ascii?Q?om4hzCHQGOIkzDKnJv2zTsp6uctvRJ7gDE7QPJyNoxXPj8klubX0B64MGNCH?=
 =?us-ascii?Q?1rJyEclsBoVPNoHp8SLoNv4Z36p/LOlcxfp4A+OOH3P2tJO2mn43gbCANnLO?=
 =?us-ascii?Q?rNRbWh1DTfIuOBVptI+HvpyuKPDFfqsJhwT4OMWYDayCcSe/cl5CUH2JIL2S?=
 =?us-ascii?Q?qELPShq2lqBsENObQhYeM6yxkf2P5wJrlaBaTbC9I388rJX8/8kt2Zy6Le/+?=
 =?us-ascii?Q?FNnwGNkPf/qWDGKqxib9g3eC6ikFFCrTbiA770eocAgv8SnGMYwwZS3cjgtY?=
 =?us-ascii?Q?AD4cinF2fzowNIbL2vFul9kNM9dzX3nDfH1eh7EYNBLT1t/UvVye4pREOoSV?=
 =?us-ascii?Q?X1/P32DYICdjt6WmKZgVm0kAhiGInP76zN3nqBBf3zwYCSyXEt9PT5IGdT8i?=
 =?us-ascii?Q?cZcu4+oeJhl3pCkqKfNhq85Gr40KsxQCe6EP1Om/F2TWCXDwqjo4LFeAvdnT?=
 =?us-ascii?Q?gfOJCf2Nqjzz/ZK5/bJcSTxeUoiPK/aNXT81XUtBIOzODZM1M7WBvjA8mHsg?=
 =?us-ascii?Q?TIScVBz9zdf3egQQ7bzlxQ2DM2P6ZtyZsI/Bcf73?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6750a53-afc7-4a2b-e600-08ddcaa1f59b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 11:05:11.4549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PD6SJ4s3HuXuMu69IyeK8UpvWcmNgN2cGqflTtAyeJ8QwPTppaGg/3gqMuNOi1Pkse83Buz+eihmWk3GDcOlug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4678
X-Authority-Analysis: v=2.4 cv=FeE3xI+6 c=1 sm=1 tr=0 ts=6882136b cx=c_pps
 a=yodC8llpXeqgnE7wIkxqLw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-AAbraWEqlQA:10 a=VnNF1IyMAAAA:8 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=yMhMjlubAAAA:8 a=5xfSEHOhs6neUiEGH1wA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WpfQ9b4O4JeEveX0ormwZifhrdl2Sp8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MyBTYWx0ZWRfX9caMUW8cOJzK
 mhzk5nPZrfd1gOiA5c7mJTHAtTKm9VGCLTtMYVDthFLl/zq+ImGVUoVAIhcmAAyPNNk50UMsuXN
 E9M/IGIQxfcoVSpVO1TF40FmcjXN7D0qqy/Lfj1Mz0xc1SA2J7zTZZMdBvMz+CO39p6vk9EIxtF
 CEnR/mJ/PlbiOvMRTE3mDXZNf6Tgk6E8oLemMIPv9zJySoVwGgVKzms6WrRa2+MV7grz8sr4YtO
 ZBzthHELaAxhlWJDvAo8KGK1O4Ezbv8MzBtRYdG9AOtdh+DqDp8JNf3MbVTttz1IXZ0blALge1B
 +LkFrAMPyOG2AP8izHvxByLBECbXhIqpG4IOE9S3KHh8FLgojBqGD8qqsAxSoHjj50DR1KCaE7f
 UfTS2ccIytb8/LGtMnyqIT8bVpbRLIAS4kDjta8RviJv/8CbhyxA0ifWSz9dk1G0L0D0whmh
X-Proofpoint-GUID: WpfQ9b4O4JeEveX0ormwZifhrdl2Sp8X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
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
> From: David Christensen <drc@linux.ibm.com>
> Sent: Thursday, July 24, 2025 5:36 AM
> To: dev@dpdk.org
> Cc: David Christensen <drc@linux.ibm.com>; Jerin Jacob <jerinj@marvell.co=
m>;
> Sunil Kumar Kori <skori@marvell.com>; Tyler Retzlaff
> <roretzla@linux.microsoft.com>
> Subject: [EXTERNAL] [PATCH] trace: force 8 byte alignment when --no-huge =
is
> used
>=20
> Current code in eal_trace_init() specifies 8 byte alignment for CTF gener=
ation,
> but fallback code in __rte_trace_mem_per_thread() does not enforce simila=
r
> requirements when calling malloc(). Modify fallback heap requests to use
> posix_memalign()
> Current code in eal_trace_init() specifies 8 byte alignment for CTF gener=
ation,
> but fallback code in __rte_trace_mem_per_thread() does not enforce simila=
r
> requirements when calling malloc(). Modify fallback heap requests to use
> posix_memalign() with proper alignment.
>=20
> Signed-off-by: David Christensen <drc@linux.ibm.com>


Acked-by: Jerin Jacob <jerinj@marvell.com>



> Bugzilla-ID: 1715
> ---
>  lib/eal/common/eal_common_trace.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/eal/common/eal_common_trace.c
> b/lib/eal/common/eal_common_trace.c
> index be1f78a68d..3dadd58e3e 100644
> --- a/lib/eal/common/eal_common_trace.c
> +++ b/lib/eal/common/eal_common_trace.c
> @@ -363,8 +363,11 @@ __rte_trace_mem_per_thread_alloc(void)
>  		goto found;
>  	}
>=20
> -	/* Second attempt from heap */
> -	header =3D malloc(trace_mem_sz(trace->buff_len));
> +	/* Second attempt from heap with proper alignment*/
> +        size_t mem_size =3D trace_mem_sz(trace->buff_len);
> +        void *aligned_ptr =3D NULL;
> +        int ret =3D posix_memalign(&aligned_ptr, 8, mem_size);
> +        header =3D (ret =3D=3D 0) ? aligned_ptr : NULL;
>  	if (header =3D=3D NULL) {
>  		trace_crit("trace mem malloc attempt failed");
>  		header =3D NULL;
> --
> 2.43.5

