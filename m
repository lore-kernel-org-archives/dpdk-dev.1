Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A92CC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:42:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B55840DD7;
	Wed, 25 Jun 2025 13:42:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1881840BA0
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:42:28 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9joco011110;
 Wed, 25 Jun 2025 04:42:27 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47geryg6e5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 04:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgXm/K5dym4qOqSyqy1J9t5C57EJPNVePvV52Fk+mvUaO/MSn8IhhBBDug1uCgnyrWHM5AmG4g4qwARkb1wjgzv6H6WTZOOuD5ch7ddoEdDPLJ5kxPywipmLMUICSUjtX41YO+NG8tPPVwTLFjvrh5jIv37a5LFYVWm98NyKSHvpTCws9PJ1y7ZQzLNtOvUBD82+1DsHjBKFvySyM9Yry+orGKHTPyH3tJ7gTH9b2Sh/BLIKtWmd9t8O0+vTTCHsED4/02DSY+LFUR/Ds/2EWiPM6Kdofv9tM+lRZq3MiS77px5wLP/g1aBVJ7EqgKncya3N53wSluLQ1cRlw7GMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcPOBy8j00t4+PkUTPeVjRWcQZfjq7DmkGeebPwKcBE=;
 b=bU7eyV7pN1fdU0/+KpZ6fr864eFQV3hxC/rzwY+2VEoIFf7VTm4wXuKwD9d5M+VrDJda6wM4J+QeyZthJw1ow4d+19+vNxR6fZEstmXcgK2cLQmjvDIAwVtYVWjGKim7GMn/mAbaxBZ4OYn1AuluyFvafHJlwb2esNS9jCHbUxz1BvSVHVze6FuzeMN4MwDzVqdHAMwHBNVjhJb+hQlZo6B+3dV/K/3sD36kee014LRyXitZqKYpRZ5Pb5/xIIVtIcUXFAz7GLnq3IsIkz62AbvXEd5gBJgyUzj4jRCeeJUbMPDeYk7ymisoEMAeWK1HLO71pnuH24bG1e8lGcsaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcPOBy8j00t4+PkUTPeVjRWcQZfjq7DmkGeebPwKcBE=;
 b=TcgEQciLppsJUzRaz7NchFbw2awp75ae8CDqhbXlxNuXpp1JIe6O+eSLbXgIpiaTbErqwG+nuxqma6TOaLGrAtpTD4cLaonz1HrbjDUN1xQj/fFvrKlUzt4lH/U54hQqiKyABYp2y2OGU5Eaog0v+lwCQVhKWv2lPvdXRhhcBK0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB5223.namprd18.prod.outlook.com (2603:10b6:510:165::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 11:42:21 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:42:21 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>, Volodymyr Fialko <vfialko@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>, dpdk stable <stable@dpdk.org>
Subject: RE: [PATCH v2 1/1] examples/ipsec-secgw: resolve segfault for IPsec
 packets
Thread-Topic: [PATCH v2 1/1] examples/ipsec-secgw: resolve segfault for IPsec
 packets
Thread-Index: AQHb4Cs7l1t9lkuIK0WTgqZQFQNOZrQTy4lA
Date: Wed, 25 Jun 2025 11:42:21 +0000
Message-ID: <CO6PR18MB4484CCBFD68B3411CEB5C25FD87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250407072155.1255817-1-rkudurumalla@marvell.com>
 <20250618083006.1679656-1-rkudurumalla@marvell.com>
In-Reply-To: <20250618083006.1679656-1-rkudurumalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB5223:EE_
x-ms-office365-filtering-correlation-id: 69fc5f11-9780-43a7-e648-08ddb3dd58b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mvo4aiBNwzmQ0DOwTITVfe4Zazj7SNFSkFpDmot0eWfaGKjK5LYt2HI8w1fk?=
 =?us-ascii?Q?SQfM5c3bsg+K19GZH3+iDpYoh6dp70KIKNvUSBA09iAWISRJJQPSTBlTjGDu?=
 =?us-ascii?Q?QSBZhwOq/D0dlaaJnvtJjh7S7V+t3/lnkk3ZMjcmGJ2gVGSVE1WPqeCWUFNX?=
 =?us-ascii?Q?DHhhwibZTQV9x/EUHGbK3K/JyADPwFW2dAaF+574dn0APQRV1T/oKcTeGjTa?=
 =?us-ascii?Q?TuxOIdYkDPab8g0ZXg5nD/pKavha2iJpU+bIiOFzoTf67OPPcRVS9lzXOsF3?=
 =?us-ascii?Q?jXaqVHqChUL9a8aftj+c8JJgGLq6mWudKfBXjnnit63TCGsw3WOAcnCBNIAv?=
 =?us-ascii?Q?ZR7jFNb0NMI0UixC3CYzsosNFi8KWBk3VRgLjysteVY9rgNEpqHJh5OStwZc?=
 =?us-ascii?Q?Fa96EuIkYkiKW61T0Y5Mr/vDdKrvoQdT3dznb4A9wPPK4Mgomzytxy8ORjL3?=
 =?us-ascii?Q?9oFttOl+qS+odG1B3xvt8GvaIJ90Fx4hkfKTi1I7TvNOUPoRPpUfsgCz880R?=
 =?us-ascii?Q?rt7ikKj7BO4bM8qKjyMxioYwMiiteUig3cZlc8QHNZqIYFbu87lD/FkRUKhM?=
 =?us-ascii?Q?GS/bdsoW+kpM9gygYuSJFnBXovaxsSSHj6rtw6P5MOBHM9oV1kKdNuhS7uQQ?=
 =?us-ascii?Q?b36H1Lt9ZfNpf4fd6LXG6IdQH4ZV3stcZShtqAD3M3oXkB6oqbuNVkNvXraz?=
 =?us-ascii?Q?dbAQ7t4lm6TuJtrlpId8tPRcMB4QbERHUd5Zk7KpH3ZAghiEzd80+bthvSqD?=
 =?us-ascii?Q?vfsKIsfawARXlhIT1lg/cRJ++Tz3uEx3QlI7901+dJ+xOsOn+Ink1iAw8+sj?=
 =?us-ascii?Q?yTRKSJYE7respMDvP+XIXIcSpWtiH9O8QYnALvh0Necx4VTvBiPFIi3usVID?=
 =?us-ascii?Q?+a12/bAeb1m8OBxZSHZvzZbtzTURyvuq6JXhkKZSmC2HfIMZ1YBiuDBAMtH1?=
 =?us-ascii?Q?NtDb1Ooyy1c2NXOXeoe3cp/qmrIwR2Fqy/ezau2AGcT9PnOlfZcOTIcaFHdl?=
 =?us-ascii?Q?bZ76567r+Itkg+0IQ38PMAsNHbejXH2BYjcaYQ4Vafa4QhQ86nwZStDzQakM?=
 =?us-ascii?Q?v7MguqjOFBoz/+ptfpELKqSKNiLkBDFIfIiX/bKGP0jGkbrL7SZqdqm0ANN1?=
 =?us-ascii?Q?Jvwh7FIxu70dRUSFpK24PFDjkJywgl8BPI3+QXy3SxWobFPwvUf29L1QFtF5?=
 =?us-ascii?Q?qpaALHDWrA4j4GhC2C97HGWENNLjAVJvOkkRIAtMi/Fc+z6MGZYLfo28LID9?=
 =?us-ascii?Q?kuKAedR7YtSAoyqKqEHBS33xeVtOTiJTPkUD6XhzQ/G8aQHcP5y+oOUFI01Q?=
 =?us-ascii?Q?6iYge+CP12ulE75yIBiKV6iq4Kiv7tkbIR/z9ARgYGFoBARfvmdRKUJeIAms?=
 =?us-ascii?Q?pR3UMb8hHgbLS5Bz1x74a8IKV1yDU/92+mBX3ZlAC0bVu9yTFKPCVOKtyl+2?=
 =?us-ascii?Q?bi9liQqPk/OqI1xyAzflo/a1GlA2LpC/mtMo5CocRMePybRoLxqIONoIPTdN?=
 =?us-ascii?Q?RRoY6aQs2+xYuR4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DJlU5NBg7hlpUrK8TLXIeLacqa5l5lA0rPKDQnMTdNTQTdnPCFoIMm24y41G?=
 =?us-ascii?Q?mrgrTH+MzjpGjLnYK5KZ7tCRFJnEMgl0R1oZvaaxWghs/qdCXkGZdqmc/ZAz?=
 =?us-ascii?Q?Z2FApJmTB0rl65yNAyTfKCgcDYAtuY4OZ/HOiTiRteom6Dvp9xaDdXH8F8zw?=
 =?us-ascii?Q?x0xk8nP/lyCCvGoORdgzx5Oxo8UoEWauaxFZDh9DoLQyTk/CDcswDLa3RcQE?=
 =?us-ascii?Q?jBW++oosSxKHe0wu5FbSMAHFkkMdi47i4cxNzE6jGlCSgMMri+jD0/LYWkqC?=
 =?us-ascii?Q?HIzhCQqMBNYTQ7NDXC4aT4tX07Go451otJRdtJuTLiHw2PKXE2SC3uQlBdyV?=
 =?us-ascii?Q?el+JYC/7TfOQEUifvX6UIJGgFEV/ezRe2LG0t1llypfVWnNXm849K1kKqeIR?=
 =?us-ascii?Q?jmWDKOfXSUU13mwJLFpQ55Yn4kXaFYiVc2QGwYxme2ES07QjuhI1YfUkNTl+?=
 =?us-ascii?Q?4AlKTB8Jgz/J+7j9ja+bEL3h9typ1TazSP9Cp8EWEMuK9/RYjkeXMtEM6lVt?=
 =?us-ascii?Q?jK9LTUE4Kb77BKzQxAlyEV8FjIHq2wF3fR7a1oa6rXyMyiYW1xOSZIVT9Iba?=
 =?us-ascii?Q?5EI39QA/R09MoALRpHAvU7V8boQ99OqAAWf1xfPA40JORcSkfZG0jrGStWkv?=
 =?us-ascii?Q?goSKgvwkSsnurucZafpVDdj2y8P+o1OcfbrQl/GMrrqXTiog0PKXF4kwiPpe?=
 =?us-ascii?Q?Ur3RIcT2YjIFMZlRvbBPZSjXvxH4v5MU3RoA76GcjDrbWcTgUhw3wrV+HPKs?=
 =?us-ascii?Q?cfHM7sMwFjZyBjfBcIcXey4yycJ32Gwk94frDn7fQft8+lB+1aVvELghc20F?=
 =?us-ascii?Q?7J9uHj3MXIrDEkaZEz9+2DLoReq74DZlnM9plQ+8gojINqGlBkhBftG8O9mB?=
 =?us-ascii?Q?XR3gWJYG8oyfGeD2jPNh9SU3ddNvIZPNOUHa4NwfqpJaEO7dSTyPmP5qNvuo?=
 =?us-ascii?Q?ehikta3fVtSO1QftvDaJj9r2RDZdsIGtaa6wsy1IXXa9bAW/2D95AuXECnTj?=
 =?us-ascii?Q?Irdg9TXDFDGBeWeFt6FR0To+0LZX5ak5t0bezrzdPMYiwDEsmLykR0KFwRhT?=
 =?us-ascii?Q?kS0WuX+jUGVoX34lSQ/tR0LW5KNG1b/uCwDCyHXZ5wvMX0s96Hq1/1LVa5hl?=
 =?us-ascii?Q?WSZ/2x5WsjSuIYV24Ie8sKeMxOWu407pLIB5K0LXuDTVJeT6oDJasuSWFA24?=
 =?us-ascii?Q?2hKkQ4APpLWvyYm62qAPty/shrZfamw536IjmLZ0Ip0VUPzTQdIMWgRnZ8Oy?=
 =?us-ascii?Q?eiSMCU816XVUOo3xt64/ojUoCJfv/KES1yx8aa/sUm5VCt1uKiKZIwErLU5o?=
 =?us-ascii?Q?baIv3bo9OBrl/guhJcqLAf6nhl/Ya3v7TAKWPMyWvEbR0cLQws0R4Dy5NZRU?=
 =?us-ascii?Q?t8k7REfvrYqAibfPxgmNu4gmIvcWKH5hom+dOEcj4FpgsDNMcERaI8vNGLJc?=
 =?us-ascii?Q?6xu9S6qnzXx/xgCGfWCumafVdxobtLkbDX9UDjv5s1vYma2z8zM6FZMoMI4j?=
 =?us-ascii?Q?rHXSTG6OJK7fIqKsDHqPnuHjXZYRtJizgw9H0KCExbG0iRM61wigTodB2Y98?=
 =?us-ascii?Q?2/GvLuvRp+wqbtHjpm8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fc5f11-9780-43a7-e648-08ddb3dd58b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:42:21.3950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBSPIvK8JncGEPRdO4fffKR8ZwJSxHyPvJoN0/rQhG9PtHHKlczKXpIon2n9pPle/CHczRo9j9KG32zDD6jjdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5223
X-Proofpoint-GUID: Nq3a96IEo-kgCsqIcxeQEPA-bgChXSbd
X-Authority-Analysis: v=2.4 cv=d9D1yQjE c=1 sm=1 tr=0 ts=685be0a3 cx=c_pps
 a=d9O6Qe6TXxnQzadaDx2t5w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=lin3GrxmDHjbJz18y88A:9 a=CjuIK1q_8ugA:10 a=YjdVzJdQTyZRADMV7wFX:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Nq3a96IEo-kgCsqIcxeQEPA-bgChXSbd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NyBTYWx0ZWRfX73yAZoaFa/7o
 lUTizzhi1Oy7L0WHH2p5VdPqMXwR+TY58RCGoJKnS/X+nDNFTmgFYUbX3nPVsmkbvM96E9HGlgU
 mFdvQSXUT20ttX1CtpMzMLNnJFPLaASVdVVhLdlGlYhxlgXKIETX5TNP86DEDBcsHazofMDluo7
 IdhIN/KegRh8gw25UwiKO5AgsPRiiSW3jw06pYdQEAbHwEqvn/NlOzgNzpjL6Tz3HIEkfYfop96
 rOASxZqrU6d4ereypx585n3nv0qXSTNKkOgPVVclpaCNONz3b89GBl/otnrxfj7xQ4+dJHJczuD
 rgz2DTJuSxT1anFWduGoBWPkRdTEtOBrvLGCpkbRGGDw0OMGaWBmEbwJ4bZlIyWQoRyk6noA9cG
 Av0+HdUoaeqOJWDhnb33V+P1MDH7FiFtE3HRdsjv5YVdDwRofeV8VKHc2zN7Z59BOiGN+BYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
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

> Subject: [PATCH v2 1/1] examples/ipsec-secgw: resolve segfault for IPsec =
packets
>=20
> launching ipsec-segw application in event vector mode
> after traffic has started results in segfault because
> we are receiving few IPSEC packet and application is trying
> to decrypt IPSEC packets using lookaside protocol.
> This contradicts inline event mode.This patch fixes the same
> by freeing IPSEC packets and processing only plain packets.
>=20
> Fixes: 1d5078c6cf19 ("examples/ipsec-secgw: support event vector in looka=
side
> mode")
Cc: stable@dpdk.org
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Applied to dpdk-next-crypto
Thanks.
