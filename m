Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0005C19F32
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Mar 2025 20:29:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3409B40041;
	Sun,  2 Mar 2025 21:29:50 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 464504003C
 for <dev@dpdk.org>; Sun,  2 Mar 2025 21:29:48 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522JqqGr027877;
 Sun, 2 Mar 2025 12:29:47 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 454qcf8jbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 02 Mar 2025 12:29:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHCjiNS+5BD4xD8C92yjYEU5vme/L6pX3+kD9t4iJlPudDh8gWA0argyB4VpraoLoHMr5J04YZPbJx6Fc6Aj5CH0e8Ivr5XkLmbzRKIOIogAp5ATiVPk5n5OqIBv9CjvSETUtvqS6NVnDr/15ryrfqPBlcO8cCYmy40KqF+nnsh3wVbnuGt5DrlmyZ7VsFBLGD7v1WcYOPxpTUscIah4jwFsdo4l+T7ZXikK/wzr58PlIM+oLZAl54uVg7ZyN27C0ub2i3Z+8BoG/ThTygTxfQUR7a0Dzmd2wMjWO+zY6kPs+Gj/M05n63sQzoc7jmGV0qHlilV/b3vT8uBHaEYdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaFrnDEEPNubKr2swHqkapjOe7Hi+T0cpIDZrIpvK70=;
 b=zRgK6nwmw9ZmuHY5Ojcy0WlYDFxLIHDvsIefoUQ7P4nfZLhK3bCFPQJBeTpOZrylaH8YlgEYaencxTZSihJDnjH20/NAFCLLDflp1RKp9CMm7OKpAhhywnVuI4rMQaOL6LHRrDodqFRFs5aZ2fOcwA1nV25s1L6QoW6f5661nIauB4IIBHQm17zdwTxwFFwub8kZNkdmbcnkHK4HZr/Y+v6LCzAW/6cPx9oLusPhOLPNko0kTGNE05JJlvgECVMPd3Jk+pT7BNHDm9qn9K3Akdk3qKA+IRDb7rNn8t+e7CLvrNNFA235WcAQk6AEeTvsvlrfs5P/TAv4Bhnb5HPygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaFrnDEEPNubKr2swHqkapjOe7Hi+T0cpIDZrIpvK70=;
 b=TuknwNrmXRzt4eOHWeZQlHinq/pISqoMNu0indP+8HTd5gU1ngk05617yZ6w/1shuoNh7rnmV8pgxb5gUEI4Oi9Za6s7c2KrjHBfVVsDYYTawoLmhJPPj6623VYrIEND88zXm97m+fO2J5NoMZ5MrhOaT5nFHtcOBGptgDb4uoM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5525.namprd18.prod.outlook.com (2603:10b6:8:17d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Sun, 2 Mar 2025 20:29:45 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 20:29:45 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Shaokai Zhang <felix.zhang@jaguarmicro.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Joey Xing
 <joey.xing@jaguarmicro.com>
Subject: RE: [EXTERNAL] [PATCH] test/crypto: remove unused variable
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: remove unused variable
Thread-Index: AQHbg5tmj+dmntgmmUihjePMSl2pk7NgXCQw
Date: Sun, 2 Mar 2025 20:29:44 +0000
Message-ID: <CO6PR18MB4484595B4C4E730661129BC4D8CE2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250220132807.2000-1-felix.zhang@jaguarmicro.com>
In-Reply-To: <20250220132807.2000-1-felix.zhang@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5525:EE_
x-ms-office365-filtering-correlation-id: e13cef91-a022-45f8-8e14-08dd59c8f842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1qVRMwDiPZKDpVrJZ5tTZgCY1w9KYlBLLu6VsjdxgyfHgpV5bQJmH2+AkQ3Q?=
 =?us-ascii?Q?n6IkBk/HoVSHCaYCUWJ2oYs+4XGkLuRKsOAbeVfrVuXhTGWt1rJPR/GqjJGE?=
 =?us-ascii?Q?YlZr2gvlRnZRb2/6upWdIjrn6Fq/G94NHgsF1NGBGO41f+324NYgHq/1D+Ve?=
 =?us-ascii?Q?urVIuuxfYkgtPZ9a2zqpKWCXi3fYQc9gPaFk53UZ6/b408geKa0nB/E1JYJL?=
 =?us-ascii?Q?mik/gJJT2aVpZS1uKvHK1EaK7ByJ3J8dJ+eE58FHGDymLoSNXmuQVtvatT66?=
 =?us-ascii?Q?TVBok8Q5AWKPVf3XHW8dCOijn5yjwBWfxcv004w7xBzMplOCibnsuTiZmlSU?=
 =?us-ascii?Q?L2A7xRhsnZDpRvboGfFQxceLs6TY0dk/mM5fv6M4166zaPSP2cpObDh2Lwiy?=
 =?us-ascii?Q?OyZmscELeTnAFrJ6giX/8VVyInKC5zPlIPDaOhcp7SjBK6epk+/1VesBl9Hj?=
 =?us-ascii?Q?1l0QxDun+8ycz6HwXYmmPdzLZYl5Q5h9sixxUFoZOmDF2UobGuBM96xeVHUJ?=
 =?us-ascii?Q?NqqU2KhUPPocwYVFUC0uIalCzptU6AB+FUMR7jw+XbqDLbc9wCNr3k/cdhuZ?=
 =?us-ascii?Q?AgzB/oUal7iHc6hza7cRo55yQ2YJ4T6MNp5EUg8Ji8lGW9MDo99+rZgNrH2K?=
 =?us-ascii?Q?WJcRofjOkgFlQFQkuhsJU4vbNGaeLt80pKQc6vewJ7+gkbX/8ux7poiNSR+u?=
 =?us-ascii?Q?/A5TaKWice/7VNN8OPavWmWMB57G62J3mGdWBpAklAs8XcG3D1bb/t2SeH3F?=
 =?us-ascii?Q?55IHTbOqLKCwQY3m5Ert5CBbkY4PDTdA4awuFx6N2n1Dug8pSLukhD6mYOxA?=
 =?us-ascii?Q?1HQaOzmgypE1+UCniNet4qjuqLNpR6JIy9B1uw4KdN6cEpDg+yrQTnKVY7Ex?=
 =?us-ascii?Q?sbhkUMBI+QLRbI1/1K9gA5fsBoZrPoYOngbAJPdd0KawDrVjQdmN5kTvZkxw?=
 =?us-ascii?Q?Xr0A9lnDocVq9f3UDLad9Yo8keMJLU/E0ofjFM3IHyk6+CSQ9PAKvNdnYsNV?=
 =?us-ascii?Q?mVjAsmaQEEyi49qwcWWbNHenEiwN+Ljpb9v8AKNlzOr/jQXiQJ61BvoETVZn?=
 =?us-ascii?Q?Ws6LW/LlWM/oNV41IAK3LfXswUYzja9LEO5wOiHSVJUguQIppkK3OLd+QbQH?=
 =?us-ascii?Q?55nHUSBNZ2/yH62WAJ0QOxS3xFIH8na2eDT8Fxx2lAhTYDTVh+x796b5jdNI?=
 =?us-ascii?Q?CYYp//vrbFUX1DnSszZT9umNtY2aEs2NKB0TPCVhXa8X9toL4ixE+g6Ah/4z?=
 =?us-ascii?Q?LkaLnaMqaGO+MDbF6p0wT66YUnwWJxhrbkflZa6iMR9Hh3I1tmfcFRfYrCiI?=
 =?us-ascii?Q?7tyE1CQk2HgphZu1QS1yFN52gjGlT+MES08Kbc3B15doAl02XBScXt56W9FP?=
 =?us-ascii?Q?teIK9n3GOuAZO9naw999Q7TNFn9Acimr+3onNvoJTcrQrHiroigrTxwaZHw2?=
 =?us-ascii?Q?Uz572DRIzfwTCXjl2tU4w3a5kAQ7wx4u?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Av+ssJNHYE7QUvPDDNKPQgl5/MxTCM42AsTp623VLffpL0xogk9OlzJ+ttTn?=
 =?us-ascii?Q?YF+4iGV+6sXoPviNFMqvNDH1YnVjW7MlLjvlCCQShf4+/0+cnILdC3ScIGcE?=
 =?us-ascii?Q?T6+hVANCOovmE7cFCeYTcu08WalvdhtQDhAgthUIr0C+fsNBieF074QvzCsn?=
 =?us-ascii?Q?xCmJzu8GjZNasX862H5WiQRvct2nLrh2PlU4pjmOzyzOohcnfoTM8jfKQeld?=
 =?us-ascii?Q?jJGf4u7tdBPxK2FeVy8eXGho9dCz9Bhfb5UpVimnE2ltDkA67dnFk1yTyFfg?=
 =?us-ascii?Q?CSyCiop67ny1U1/p+3rUxAP4K94eDMm+XnJQLXdiAQOBK15rKjlr4NQPtBYv?=
 =?us-ascii?Q?3FfufzT9LqYhigSLwsOgi/tz+Oy7c9j/H485m+7sx0kycX8jktlSp0SXih20?=
 =?us-ascii?Q?BcVvRsin8AJFoyIpZp960Hk1tin/3lk5KUVETj4133ZcYmLJbt9ltErDOOUf?=
 =?us-ascii?Q?ZVfOn5N+Tb+FCh+qt9sCZob/5uGrhkC8+nhawtwkdxXNv0bzoTM6rO8UBkAR?=
 =?us-ascii?Q?Z+DT4Ssd/rKmZ+VSXgx8pIUYcPBHtyoxaesPblFhddMvHu6sbka9Z2NUCU+h?=
 =?us-ascii?Q?13xU5tqwXhQTqqCTluVyeZH3huUEfc7CzrNqv3zwjjFOzlfDJ+nrp4Ftgpge?=
 =?us-ascii?Q?ojxjmj8Ii6Hx9g+1ahWXQMFjXLE4nzTEs/B9A1ItoywY5OXP6oEmXwmxh+is?=
 =?us-ascii?Q?WmeDQmHKKvHxswe2/vb5pPwaECa00cLMLuHimOPekAmpCLzfwORRJLTHNRDG?=
 =?us-ascii?Q?3xK76nPnVef4rtrOw8jXPY06EDXHzzLHi3lMMcvNm4zil7+FU+bONoYCSqYE?=
 =?us-ascii?Q?duwyBGrO1lFQPUtVx0xuJ2PL0pLWajtTG7/jhactzur2x3/v3/cLA4oL4xiK?=
 =?us-ascii?Q?xPJJL/PNSdYdrHHa7QbdRxabP4G2jsCUOZQR9Xl63R/VnUwLQkHbU0ctQ1IP?=
 =?us-ascii?Q?TEQLDGWwxJ+ccilJWy089auYFmBLIfPZFkzlIBQLyzDGxOtUWhPhi7pHY7rp?=
 =?us-ascii?Q?LiShFfcOWBhqUn/Fbgef08fTLDSoAEuX27r8TTY17zftdY9l0DsdbmvLjvmd?=
 =?us-ascii?Q?l14D6KLzoIFn1O7A6P7NM1w2Nom+2aOPgLeWzVnFPaB8oSUOOTwXAvQKqEzZ?=
 =?us-ascii?Q?HQP3+Nl9Mt2X2vWCjC6JqzIgLLtApycxwq3e67vfBNwOftfX6iPtufUpSB//?=
 =?us-ascii?Q?Fhistwobqh1zIP6Xf0veTb+Or78SMkCEO10omRBzjfT7Md+g5jJdWUX/SZqJ?=
 =?us-ascii?Q?N+7zsDbM+HCTXs7wYqI+TJPxwLz82y8Ilz5WBkko0I2Sz4BAEj3bwT+y558O?=
 =?us-ascii?Q?Ze7/IwyXdsj4ERBxxcxrT9iv5W/VAXiDHZIHstW5KO/J/a9waRLukzoU/ljc?=
 =?us-ascii?Q?7YeC+TJ2QPYQI4jIqoCamu9PoYIEhz5ZGv5Hqud2Egnxa4SRcPop5TdZ9ZT0?=
 =?us-ascii?Q?etw+o3HWW03T/PnLMaitwvzsrn12V3bnHI87SXrhB9AmPLz4+m22kUYXavsM?=
 =?us-ascii?Q?bfW6BhhVr4GSxk/OWdNVGErE8FXh9rGO99HLVqyjmIUAdZnqdloEjKLSmOLR?=
 =?us-ascii?Q?rA/dRr6oadaPzIuKadmD+DgKle2oySkII4GaeNLG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13cef91-a022-45f8-8e14-08dd59c8f842
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 20:29:44.9331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ocQ6n1bRgIjV90/fy5m0PKd299fRdHwK1HIimSS2pWmypIvHLkHCQ7uimcWsHYqAbo7dfgeOxgozUwnFVplWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5525
X-Authority-Analysis: v=2.4 cv=VaMNPEp9 c=1 sm=1 tr=0 ts=67c4bfbb cx=c_pps
 a=XlWNgFwcAB8XWrBhwjv7Vg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=yacp4PbrAAAA:8 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=2eGJ06LMyx8aOCX0TG0A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=V3FWeFeR7HlZ9tVNOp1k:22 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: V-ACVfxXhrG8sVLmBsAXhjK6ieuP-y1K
X-Proofpoint-GUID: V-ACVfxXhrG8sVLmBsAXhjK6ieuP-y1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
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

> In the new session framework, each crypto session no longer requires
> the session_priv_mpool, and it is no longer referenced during testsuite
> setup. However, the structure `struct crypto_testsuite_params` still
> contains the session_priv_mpool member, which may lead to
> the misunderstanding that session_priv_mpool still needs initialization.
>=20
> Fixes: bdce2564dbf7 ("cryptodev: rework session framework")
> Fixes: 3f3fc3308bd0 ("security: remove private mempool usage")
>=20
> Signed-off-by: Shaokai Zhang <felix.zhang@jaguarmicro.com>
> Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
Cc: stable@dpdk.org

Acked-by: Akhil Goyal <gakhil@marvell.com>

Updated .mailmap
Applied to dpdk-next-crypto
Thanks.
