Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED274CD98F0
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Jun 2026 08:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAADB4028A;
	Sun, 21 Jun 2026 10:46:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4BFA74027F;
 Sun, 21 Jun 2026 10:46:24 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65L7UZwD2539449; Sun, 21 Jun 2026 01:46:23 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021104.outbound.protection.outlook.com [52.101.57.104])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4exbm982v3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 21 Jun 2026 01:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXEttx+0q6l9OzLYWywbR+qbTC9z3l2fBwVPZOHCedAWhrMHZlBunUfWOQ9Bbb4x/AsDewmancfxuwxBaZ2LZlPKHzD8yitFX1F/ydl4VN6bx7AtaBgVhX+5XyzcsTCFW6odyoswOZWUaF6D2R8LOejuK//SZDQlIA/j0eyym3aEABrm0/KLgUK8TVAGZkAOjLu29/WkZnSvo/Q2LkQs7H/hMOCkRLmnU1KOZK2267jRxzWNxprT24hvYJ100VJJQ1RwRyi+xP9ckrkXYflF075MRLZOWuvS5+UgzI3nGrAU7mLl6VVuXRo9YcL8Ul1Rzu82EG9n6gyvWfBZcLmErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMewPR5UgGiXUMC2C2VyIaLdXWeJROeEWLxAEE/STYQ=;
 b=uDmbO4toFY6aRcVwHJ9u4oLywtjrExaKSXX9PIB1VFUBNkYymUphwtGTQoq3F2i1hqOfv4TR2t4kdFd4FSk89SL/uaAJKkHEdgbO3jGJ3kdNQaiy2l/Pd9l1RK1X4K/tS+k4uNB4uB+uB8ylCFRWBWsoYiPvTsP2tPCM/6e0kOT5cGkAaldeZNEWu8BXfAX2/WFnqo0lXI/7LwC5RLsZ+0Go17hxkip13PSJF1/GGsrw6IL3Rpbx43w5pF6qLbA2SwWbOCD5Np1K8WeGkTyLisOllehFQ4iJ2A9FT/C0uOpUMmLf4sAFO0wYmT5+GaxTRHMA/Ky03YG6LN1Asu34pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMewPR5UgGiXUMC2C2VyIaLdXWeJROeEWLxAEE/STYQ=;
 b=W0mfSRCSvuJ0kMfr82c/9urAqGWwpl52CL9nY8CiozPyPtKggCfqUyBAOsy9xvOVNpOKXzxsEuw2vSU8LYq2iExO5FV9rQyWb77y3qev5qkkvKRtiwn6n0Hkv7jLif9UxRVRr/aqa+Z01AFb0jBb4aVpZ7krIilSGNy7FTR/n5Q=
Received: from PH7PR18MB5177.namprd18.prod.outlook.com (2603:10b6:510:156::9)
 by BY3PR18MB4804.namprd18.prod.outlook.com (2603:10b6:a03:3cf::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Sun, 21 Jun
 2026 08:46:20 +0000
Received: from PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8]) by PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8%6]) with mapi id 15.21.0139.011; Sun, 21 Jun 2026
 08:46:19 +0000
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Daphne Priscilla F <df@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Akhil Goyal <gakhil@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Daphne Priscilla F <df@marvell.com>
Subject: RE: [PATCH] crypto/cnxk: fix out of place AES GCM
Thread-Topic: [PATCH] crypto/cnxk: fix out of place AES GCM
Thread-Index: AQHc+jOWT8nBBsU4FEGtzSc0+1FhTLZIvbFw
Date: Sun, 21 Jun 2026 08:46:19 +0000
Message-ID: <PH7PR18MB5177F3AA522F8CEAF8B25253A8E02@PH7PR18MB5177.namprd18.prod.outlook.com>
References: <20260612062009.3587783-1-df@marvell.com>
In-Reply-To: <20260612062009.3587783-1-df@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5177:EE_|BY3PR18MB4804:EE_
x-ms-office365-filtering-correlation-id: 3dbedc3d-8739-4aa6-546b-08decf7190a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|18002099003|22082099003|3023799007|56012099006|11063799006;
x-microsoft-antispam-message-info: ZsN1tbByAsDpb3135jxVWCf2JVolmEoJZTuy+63zd967UoVhRwfkX24FAPpdhuYWlXmlgfbF6CvdjELRFIXVD8fFz7EX6bROFvtT3orf1TTaAjfAaDQrbYZ6HYbB0N5CW/24x6o+dpXMXboymRcYVncVTLMaRgbTVvN8AknMlmBDdSECvjvIwOpF9JgTbBDxvQMYncg4xOmXUb2rgKF15mRYERcAe351at0xgB9Jv6/F2f3gcXzlTO5hD6hpw5Sg5LpKMXItyhhv+mwrdiTLoaRtRhrOyu96z0ZdWcgHfOWB87iA/b90mpfnEDRQ4XLhkiT42PhgjrjyjYr2nK8dVZbTQB5Y0TDbUCs7Z/4xfOP8BjtkrCBACnE/CuXkfwqHEN5QOTmC29AVznXQcmV1VPFtQtcaov5HFUwyFJ3s2DaaqwkTSWFgtEfdGGVF6Sg3NDH725OJVIZE9YqyHBjn0MsFuqu55oCoKGVff2IKgZo6UvDbE69TscjDnMtkpzYRYLtUWihHKQo8Y8uaD0XYSqMpElKaIXfHauIgm/5jPBHDfAwT9QPymj6TUpXFFHUBs8lBej4V5bQWxUPUi0N1CDpZn9MNBzqmfSgsVntSGbL3zGCR9bt0nf7nO1jGKEzgiq277z2a6DlQM22JtcYHxFVkhCl2doUUdy6zG23GKV3IF1eTXKiHLi60JW8RbBaFHYsjBl5/goONjJMR735QAvgl9AIWHfeylj0n7lBiyH0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5177.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?elTfa9Ffu7HGkf6+IPRHPrJPV+FDXvRA6itHlENSWfhUTx4wzIFc9YTmuJ6n?=
 =?us-ascii?Q?Io67F6sc3XFQU+WICb6Yr7Pa6NTrROVOmilInUTVZvWE734HsLLLDMmWjJbD?=
 =?us-ascii?Q?WKDJbaIYNMMlrSppSGiXthNjbdSOZpzffoPEbFEpQDIjSzAi+Bc+CweqojV5?=
 =?us-ascii?Q?B2Musm/7PXYwduzbhp+pUXYz2qm23pQUhcNYxk2cVcte6Wef8q07rQVn+LSG?=
 =?us-ascii?Q?Vg0TLlymuMvY8V5K4B8waaU8P/2LphH9I6Vo+2HaU0j6qdR1MfqljK4JJ2dF?=
 =?us-ascii?Q?9O8dKTwWV9U4wUf6RnVMjQcZbAM4+cYspJeEaboK32tCNISopq0U3QDG+8Oo?=
 =?us-ascii?Q?pnoWyAQSWicyfVKHx9CyQ6R5jYUb6eBApf7/oJZhoaZ2OVlHDtXvWTZap5lO?=
 =?us-ascii?Q?AUKjaJmscq1VGwMijb/PF0R+qHbepKHMbVbu7b1L5OfRME0JBVi1Qbn7FIkm?=
 =?us-ascii?Q?oRlNWbHSkJcxGdylBkAJK4s96JD2lmJ29/3WNDVkBBQpTp0/m5HiSJ/q7tya?=
 =?us-ascii?Q?jXwOhgA0eJ1Hd2Qby4ylepuPymW/dhtlkvpu1ifipVd1eG82NM0t+xBOGb46?=
 =?us-ascii?Q?vp366YFQmKRbTBg0J72+yuCdPe7qP3t69P/CDa5R9W0DlUvhsjAqC2tOKptX?=
 =?us-ascii?Q?l71lFbyRAaRFaonM873gB6+P/8Fofg7QWYl48fG8+Z/EB3os3jUYfkkKCSOb?=
 =?us-ascii?Q?LaJuoAw0HHTRtJ0KrcNLv/sqE6uOGR0mC6mSXqx97uAwEHH8zGmxJT3feGqn?=
 =?us-ascii?Q?7Uz0iV8IpCoV+VGBUrn9JF66zr/VTXCh5AXkE5LuroAJPCPLGhr1BFJ8MJsT?=
 =?us-ascii?Q?Jd/xgPk1VAsvmCh/G8daMTyWD4v2Qa4ZupdmQ8n0QxtzqBCfB1uzdGuExhp8?=
 =?us-ascii?Q?DglYnkKvvRDJ1KOxxXNYQK5J7O2cxOWvUHcwkr/HddOuXiliDxZ0h65PBtod?=
 =?us-ascii?Q?mCHWfW7GH2kpy1I9G4MGxoPHWi380mLYlTZ1zXo9JZ3q8rgfQa9AHj3PhdcY?=
 =?us-ascii?Q?Sz/tLQT6v7xbU+UH8o/+ZM+8edV3XPWOPFJC2RnC9rZfe6NUy7FFL3/iVJlp?=
 =?us-ascii?Q?OfsS/GEK+qKKOMLXccT6VlYrxJYk7f13jWCBRet013EoeiFrGD689YYbG3XW?=
 =?us-ascii?Q?TBOJh+YQavJHFax8oWEoqcfyl/RQQHxALJT9AoKqcct6XI6qrXQHRQ9cV9Fa?=
 =?us-ascii?Q?XROIN7FNkPgGx8lVjPrUzCe6Za+C99eMQvybEc8u4eZQuGLCgnF6/dkWXl+R?=
 =?us-ascii?Q?a2/2ZM6pgTi+Tefj0oLdSVhftYZRueaqWjmOXui6VEo8F9nkbQcZGgxxNJb/?=
 =?us-ascii?Q?CfQYAbSHbGP0l+EXRfrE7GME4sJA7jHmKKM12ZuZzF6S6nD/euFD7SXoQfd4?=
 =?us-ascii?Q?XdQ9r6pjpXD/5IfeTfdECG1AZhH9sAYmhg+7nTN3fJfsCUXcL7rPyPRYgVvO?=
 =?us-ascii?Q?J25r8xc27DglS7FruxWyS9vkhXU3ZneduRHrnqhdVaJv728DHGbU1TTLYnY0?=
 =?us-ascii?Q?IUQ7xkv+iq2/Y5E3NGAZOpI01rQdygYAHcoAOs1MLL+Crqh4CC8xX+z1F0IX?=
 =?us-ascii?Q?il/558a32j0ABaZ2dYDG6UW4uoivQvHgYtf2IwC9b9jDoJFhHulVuaXzqXZW?=
 =?us-ascii?Q?9buuQlXVAJdSFo+6bZcsTD5mkQAPdy9yMXTdSWpiTD/SI+vp0ymNpgN7DwF4?=
 =?us-ascii?Q?5nCS+zMQ05cRxu8XhmlRF5QGXRKGokRTKkcPbcRvO0a9WVAj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RagbAenOpDsgl924YSZ5gGwyMgVgQAuXxM5tb2vN7uhg8JRXYP2L254uot5YRLH5aFofTbsPDbQ02hBsFqjmtr/jebQ96bAHRwJDjQDvpyAmWa68UVV6ho77JNlcKueDSlEoDoFZLra7R9iDWDkBwA2tKaNb53eqQw+JTCbhaTpq3ApIppxC6qiK0JATf03dUl8cTfAXdOP6Av+9WVIUIpb/aaWPOTETaijcXLn90BnsUdgGERsVrWEowIvxUKT9ixdAjiFjgbVJ3/6yJLmZ48Uz7ac5UEirIVG5VAXB0Fke6T33kY4v+ELMG8+4pFV5L5yt/Wsx8icNVm2UHjeNtg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5177.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbedc3d-8739-4aa6-546b-08decf7190a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2026 08:46:19.7984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyL1SP6QC+nraSqsR5XZhk/47Gthful/0mRJu0si/8zKyUlRBqxtG53VAqc5uu1bwW/u5FFTX9PrrfL+PkvILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4804
X-Proofpoint-ORIG-GUID: jW9UB-yrjqLFTpOuutMLJJ7TG5mHzqR9
X-Proofpoint-GUID: jW9UB-yrjqLFTpOuutMLJJ7TG5mHzqR9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA4OCBTYWx0ZWRfX1urQi6MXXNG5
 7Wb59ou5KztneYyShKoESNJVsayn6FYqGvm/44EN85NLBR4NNrPjpVhhrmkkeW+ps4xY35R0HSK
 2/1EFARXL2so8YrSYKY1wWwqZOietIA=
X-Authority-Analysis: v=2.4 cv=BLiDalQG c=1 sm=1 tr=0 ts=6a37a4df cx=c_pps
 a=qAO2aVrDdLyRlaU/jZBZ7Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=KgxZQTYqAAAA:8 a=OehhG7u43CpzCFBL8QMA:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=J70gtpi9w7iKWgri9Xi8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA4OCBTYWx0ZWRfX0dP261l6XcC3
 rFV4npIIn1sHLwFZ/dL1rVqXhvhtiARvQ8tsdi5T6X5ehyUNhvkJlhr14r29AAHtR4SSETv0SBI
 WXhyrMkUnK9athla1q82vXncrcWflwwaKfQSJiBCntyMjMaf/hes01RxGyfeURT+lkTh1RWStc1
 d8qaxIKaPEx7BXhtKIkYOirLLzwzIpTQE7X9JczZS8fM3mXLzPX09P5nKD9XrAdaa1mdK4Oh5jO
 iTgDaIPtwZYCUy7VQhv5ucC55aShmliYNWc2dNsWSn6Duz7Pe6sLtvaH43dPzZ2E2hC7uhJapeq
 mtqbQGbFrG98beaRx73ujswpMMbG/7T098S330KTXUjSG1++IeGVmuVNdkZzEb3GBKew54vTwlL
 5rKzB+3TxYz2E1rZqBN5TV4hqimyNR8jy9segH+hlKPZ8/rqn7eC8oXTECaNNQ/2CxaRx+Nvpdw
 KsfB+A9T3jOJDl3KGAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
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

Acked-by: Tejasree Kondoj <ktejasree@marvell.com>

> -----Original Message-----
> From: Daphne Priscilla <df@marvell.com>
> Sent: Friday, June 12, 2026 11:50 AM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Tejasree Kondoj
> <ktejasree@marvell.com>; Anoob Joseph <anoobj@marvell.com>; Daphne
> Priscilla F <df@marvell.com>
> Subject: [PATCH] crypto/cnxk: fix out of place AES GCM
>=20
> For AES-GCM out of place, when AAD is present in inbuf before the data, i=
t is
> treated as passthrough data. This results in AAD being present in outbuf
> header, but test expects outbuf header to remain zero. Passthrough data i=
s
> now diverted to metabuf so outbuf header remains zero.
>=20
> Fixes: 7c19abdd0cf1 ("common/cnxk: support 103XX CPT")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Daphne Priscilla <df@marvell.com>
> ---
>  .mailmap                                 |  1 +
>  drivers/common/cnxk/roc_se.h             |  2 +-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c |  3 +
>  drivers/crypto/cnxk/cnxk_se.h            | 96 ++++++++++++++++++++++--
>  4 files changed, 93 insertions(+), 9 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 118dfa0ff9..1191afbf0b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -334,6 +334,7 @@ Danny Patel <dannyp@marvell.com>  Danny Zhou
> <danny.zhou@intel.com>  Danylo Vodopianov <dvo-plv@napatech.com>
> Dapeng Yu <dapengx.yu@intel.com>
> +Daphne Priscilla <df@marvell.com>
>  Darek Stojaczyk <dariusz.stojaczyk@intel.com>  Daria Kolistratova
> <daria.kolistratova@intel.com>  Dariusz Chaberski
> <dariuszx.chaberski@intel.com> diff --git a/drivers/common/cnxk/roc_se.h
> b/drivers/common/cnxk/roc_se.h index 499e71ce85..d3ad61ca04 100644
> --- a/drivers/common/cnxk/roc_se.h
> +++ b/drivers/common/cnxk/roc_se.h
> @@ -26,7 +26,7 @@
>  #define ROC_SE_MISC_MINOR_OP_DUMMY	 0x04ULL
>  #define ROC_SE_MISC_MINOR_OP_HW_SUPPORT	 0x08ULL
>=20
> -#define ROC_SE_MAX_AAD_SIZE 64
> +#define ROC_SE_MAX_AAD_SIZE 1024
>  #define ROC_SE_MAX_MAC_LEN  64
>=20
>  #define ROC_SE_OFF_CTRL_LEN 8
> diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> index 2f9eb322dc..5e59f1d7bd 100644
> --- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> +++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> @@ -82,6 +82,9 @@ cnxk_cpt_get_mlen(void)
>  			       (RTE_ALIGN_CEIL(ROC_MAX_SG_IN_OUT_CNT, 4)
> >> 2) * ROC_SG_ENTRY_SIZE),
>  			      8);
>=20
> +	/* Space for discarding AAD bytes from output stream in GCM OOP */
> +	len +=3D ROC_SE_MAX_AAD_SIZE;
> +
>  	return len;
>  }
>=20
> diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.=
h
> index 8dbf3e73c7..09d9d1e0e3 100644
> --- a/drivers/crypto/cnxk/cnxk_se.h
> +++ b/drivers/crypto/cnxk/cnxk_se.h
> @@ -407,8 +407,28 @@ sg_inst_prep(struct roc_se_fc_params *params,
> struct cpt_inst_s *inst, uint64_t
>  			if (unlikely(req_flags &
> ROC_SE_SINGLE_BUF_INPLACE)) {
>  				i =3D
> fill_sg_comp_from_buf_min(scatter_comp, i, params->bufs, &size);
>  			} else {
> -				i =3D fill_sg_comp_from_iov(scatter_comp, i,
> params->dst_iov, 0,
> -							  &size, aad_buf,
> aad_offset);
> +				uint32_t dst_offset =3D 0;
> +
> +				if (passthrough_len) {
> +					if (unlikely(passthrough_len >
> ROC_SE_MAX_AAD_SIZE)) {
> +						plt_dp_err(
> +							"Passthrough length
> %u exceeds reserved space %u",
> +							passthrough_len,
> ROC_SE_MAX_AAD_SIZE);
> +						return -1;
> +					}
> +					uint64_t meta_passthrough =3D
> +						(uint64_t)params-
> >meta_buf.vaddr +
> +						params->meta_buf.size -
> ROC_SE_MAX_AAD_SIZE;
> +					i =3D fill_sg_comp(scatter_comp, i,
> meta_passthrough,
> +							 passthrough_len);
> +					size -=3D passthrough_len;
> +					dst_offset =3D passthrough_len;
> +					aad_offset =3D 0;
> +				}
> +				if (size)
> +					i =3D
> fill_sg_comp_from_iov(scatter_comp, i, params->dst_iov,
> +								  dst_offset,
> &size, aad_buf,
> +								  aad_offset);
>  			}
>  			if (unlikely(size)) {
>  				plt_dp_err("Insufficient buffer space,"
> @@ -430,8 +450,28 @@ sg_inst_prep(struct roc_se_fc_params *params,
> struct cpt_inst_s *inst, uint64_t
>  			if (unlikely(req_flags &
> ROC_SE_SINGLE_BUF_INPLACE)) {
>  				i =3D
> fill_sg_comp_from_buf_min(scatter_comp, i, params->bufs, &size);
>  			} else {
> -				i =3D fill_sg_comp_from_iov(scatter_comp, i,
> params->dst_iov, 0,
> -							  &size, aad_buf,
> aad_offset);
> +				uint32_t dst_offset =3D 0;
> +
> +				if (passthrough_len) {
> +					if (unlikely(passthrough_len >
> ROC_SE_MAX_AAD_SIZE)) {
> +						plt_dp_err(
> +							"Passthrough length
> %u exceeds reserved space %u",
> +							passthrough_len,
> ROC_SE_MAX_AAD_SIZE);
> +						return -1;
> +					}
> +					uint64_t meta_passthrough =3D
> +						(uint64_t)params-
> >meta_buf.vaddr +
> +						params->meta_buf.size -
> ROC_SE_MAX_AAD_SIZE;
> +					i =3D fill_sg_comp(scatter_comp, i,
> meta_passthrough,
> +							 passthrough_len);
> +					size -=3D passthrough_len;
> +					dst_offset =3D passthrough_len;
> +					aad_offset =3D 0;
> +				}
> +				if (size)
> +					i =3D
> fill_sg_comp_from_iov(scatter_comp, i, params->dst_iov,
> +								  dst_offset,
> &size, aad_buf,
> +								  aad_offset);
>  			}
>=20
>  			if (unlikely(size)) {
> @@ -606,8 +646,28 @@ sg2_inst_prep(struct roc_se_fc_params *params,
> struct cpt_inst_s *inst, uint64_t
>  				i =3D
> fill_sg2_comp_from_buf_min(scatter_comp, i, params->bufs,
>  							       &size);
>  			} else {
> -				i =3D fill_sg2_comp_from_iov(scatter_comp, i,
> params->dst_iov, 0,
> -							   &size, aad_buf,
> aad_offset);
> +				uint32_t dst_offset =3D 0;
> +
> +				if (passthrough_len) {
> +					if (unlikely(passthrough_len >
> ROC_SE_MAX_AAD_SIZE)) {
> +						plt_dp_err(
> +							"Passthrough length
> %u exceeds reserved space %u",
> +							passthrough_len,
> ROC_SE_MAX_AAD_SIZE);
> +						return -1;
> +					}
> +					uint64_t meta_passthrough =3D
> +						(uint64_t)params-
> >meta_buf.vaddr +
> +						params->meta_buf.size -
> ROC_SE_MAX_AAD_SIZE;
> +					i =3D fill_sg2_comp(scatter_comp, i,
> meta_passthrough,
> +							  passthrough_len);
> +					size -=3D passthrough_len;
> +					dst_offset =3D passthrough_len;
> +					aad_offset =3D 0;
> +				}
> +				if (size)
> +					i =3D
> fill_sg2_comp_from_iov(scatter_comp, i, params->dst_iov,
> +								   dst_offset,
> &size, aad_buf,
> +								   aad_offset);
>  			}
>  			if (unlikely(size)) {
>  				plt_dp_err("Insufficient buffer space,"
> @@ -632,8 +692,28 @@ sg2_inst_prep(struct roc_se_fc_params *params,
> struct cpt_inst_s *inst, uint64_t
>  				i =3D
> fill_sg2_comp_from_buf_min(scatter_comp, i, params->bufs,
>  							       &size);
>  			} else {
> -				i =3D fill_sg2_comp_from_iov(scatter_comp, i,
> params->dst_iov, 0,
> -							   &size, aad_buf,
> aad_offset);
> +				uint32_t dst_offset =3D 0;
> +
> +				if (passthrough_len) {
> +					if (unlikely(passthrough_len >
> ROC_SE_MAX_AAD_SIZE)) {
> +						plt_dp_err(
> +							"Passthrough length
> %u exceeds reserved space %u",
> +							passthrough_len,
> ROC_SE_MAX_AAD_SIZE);
> +						return -1;
> +					}
> +					uint64_t meta_passthrough =3D
> +						(uint64_t)params-
> >meta_buf.vaddr +
> +						params->meta_buf.size -
> ROC_SE_MAX_AAD_SIZE;
> +					i =3D fill_sg2_comp(scatter_comp, i,
> meta_passthrough,
> +							  passthrough_len);
> +					size -=3D passthrough_len;
> +					dst_offset =3D passthrough_len;
> +					aad_offset =3D 0;
> +				}
> +				if (size)
> +					i =3D
> fill_sg2_comp_from_iov(scatter_comp, i, params->dst_iov,
> +								   dst_offset,
> &size, aad_buf,
> +								   aad_offset);
>  			}
>=20
>  			if (unlikely(size)) {
> --
> 2.43.0

