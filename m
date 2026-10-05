Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A32CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 18:02:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEA3740A7D;
	Mon,  5 Oct 2026 20:02:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9BEEF409FA
 for <dev@dpdk.org>; Mon,  5 Oct 2026 20:02:22 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HKxRO069779; Mon, 5 Oct 2026 11:02:21 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023106.outbound.protection.outlook.com
 [40.93.196.106])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h4f8w8kyd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 11:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drBp5APnafG3soZ9kszVL8IBuPk8UEpXtsBqWOBSfzHUZJk4taqahusaSwfnoAM6VKuCGfNxQL78A9oyQh40Jwq5qOkW3lsGm3oEs9d6NNeU54wbpLOh7+S+705RT098es6W2jB1jUZkV8Vtt6L7PjKE4njFCLLSnr25GVjdsGhOP9rXu0powl1k5Gwef111m9sBUfpixcpgPe4WoYPstR9VtzhV+C+OQRTF9VBvIRxv1tsXSfsw62K0d1ps9Y99q77pnFm5Lx3q/cAn7QCNdAGz2NUs7nhfEzkprutjaUszor8JXOv2jCOPGp+LYD13oZFhcFEN/L7spp8hA5JAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y40cxsIz7Ypgc1PP4CuUJCKel+haO/TEh7iD1iZfvME=;
 b=swyMrM+lhuBidIh+us0nBOl4MQpn8EKtE6vip0SGUErVCayPNEpNWq61rYtAwzc5flxX8n2qxl/OsoL+Cal3KcM0b4LdT31OccefeOgplWPIFEnhXl90zZLJarIruw2SDOO/vkt52TRUtJgptUakjOioyQ+DxkY4G3CFbO0JtVDde7qMPuXy8dBQc9Pa6cNYt+QlYuweyRu8QJtLVZdw9i9KV7yO+8uD50RdLXZrJRLRyj2ZtzauOi+1IGbrWBW+B+KuzI9tp6mIc3rQ1orBiDx1dk0rnnMI89XHYAuwQGj3rzWSoOVUJG/QSVdLyYMXTtkPyPVAm3dP9m4c3U0iUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y40cxsIz7Ypgc1PP4CuUJCKel+haO/TEh7iD1iZfvME=;
 b=PR+BsCHxC7eiVHxm1QJSr/MmM60pX3daOBZsR7+mMYKanVbblsc+lkzcUfzQ1v0xvr1aGy9mQzyLX0JXqjGLDaBfvZ7wnd5PqGyXFC+WAXuhqkH4zYP0uzbykpfQXbIFRToW3Gfc+xymPMkYcXk07ofSpBSEhJ2rvl40V4tibTA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5642.namprd18.prod.outlook.com (2603:10b6:610:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 18:02:17 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 18:02:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "radu.nicolau@intel.com" <radu.nicolau@intel.com>, Gowrishankar
 Muthukrishnan <gmuthukrishn@marvell.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>
Subject: RE: [PATCH v4 1/4] app/crypto-perf: support mldsa Sign-Iteration
Thread-Topic: [PATCH v4 1/4] app/crypto-perf: support mldsa Sign-Iteration
Thread-Index: AQHdUAz69JxKTax9XU6LTexn57SD77bvRsOw
Date: Mon, 5 Oct 2026 18:02:17 +0000
Message-ID: <CO6PR18MB4484CC32D1F56A13957F0C30D8962@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20260929122044.1344518-1-psenapati@marvell.com>
In-Reply-To: <20260929122044.1344518-1-psenapati@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5642:EE_
x-ms-office365-filtering-correlation-id: 17c32f48-444a-4340-bde8-08df230acb23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|10067099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: E1CkZBQAzbZm8QQrc/IRQ1KDRnMIJKQHmZjAi3Hye4VVSP84ArH07C+pGvfXzLCIBcma8de6Ri2syOqckqBhTVvtJDFq+X17iwaXuSbMeg+oGlVlwnvBS9/VRNojzacINf+mJkDJmzkq+/fbBDbxNQUN03Qg8bXKqD4nUIMv376F2/ue828ygVosyUWT5PQuTx2CoIbktU2jOlCdqnJT55OLzelB4FX/NG6ZJtltWlt2t6xsKmi9QWRRvBqSO0fDfeQX8IUsLEiYHf72mX8eODIhT7BqDg8Ej+Iv/cGfpnHH7k9CJYjhqAEOOix6EMmXmS1I/j77wYitfgIx4XHr8kM5f8H2SLs7mGDwFkI0w+j1yf9Yz5vcc+lMwJd+YvdxrtOlA76NSU+uO39mNPMwdla1fP1Qv4GRda0XBT7eNHNx3yu4iq8i9r8sBmi2rGomqvMkP03vPPaYW75j+jOfxzLbeeInfj2JaVnVE8vQ7INx5LQAqpKWYxFLwVX2/arVfCXUTdkAkM1eRPR2RL6VK8yqTai2wtC0xK3h8+QNYtnJ9NUjRSTxIERVKlFhO4VRLTclRI7lJoagqraz7mlpXEjODvpzysDILjN2rcI8ICQPrXF3jkvwHD+jFVvEYKbyCkIgx6GmWW5ECDsLdfhh/uzEx5cDH2viW88QsyKB9/blST2rvNN+EQBts2s8uDkq77X1sRzeZaHYwdCsqrI0OBsvPzc4d6G0TnfyBFB/4lI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1XljLD2Z2L+Vd/h9iAqmhunpIRMRs+6pNxbFbCz0R81UV7M1YdtWaKWlb17?=
 =?us-ascii?Q?OB30Ra2jrxMaMuhS+pYNl2poGO29AzesbOB0mQ6xOfAiFqbeTtMhEVc2St1K?=
 =?us-ascii?Q?alAvbhA4Y5toYSC+t5YSCGcaR8zWwdSbAvpBX3do8P3KdSiR4/e68fZe5hb4?=
 =?us-ascii?Q?10QteSTP7N7CYzSmZDhLkQTHQ5cMpcR/TyI1drd1mNG/dGwwERBBkB7LgIP2?=
 =?us-ascii?Q?ncPTV03OCygFqUIL7liT7BXaNsQrFS1yruIws4PR/p6GZ5y22jJfdR14/t52?=
 =?us-ascii?Q?RTboOHVdmx72JFNtsiDGLeWH6PdR9FNTJbbB7jZlFuKAY9bRz/ghSeqr7giG?=
 =?us-ascii?Q?Fl9HNCO5rahFpOqeDjzskzTHTwV8es50VH51U1K7kSHu4d95Rsr50jmauBUB?=
 =?us-ascii?Q?u8ujhtGRO0JDcD5DxpwaYQIagEgD6bsMPyEB9hXQSvWJK8hQ/p33FtYGoM7i?=
 =?us-ascii?Q?ou60HQaWNC5OMfCB/niHW0USihtTQ62z3pkN2qgqgsnprca/GL1BDIon9JjT?=
 =?us-ascii?Q?dlIHbUp3aEK4p3zbPacTtL1OE7hCJtHQqlWydtJfFT0UE1SnT3UoegoVcVlu?=
 =?us-ascii?Q?DrL8imrsH3qiKCII4etIqLqea+3MngzjaOKAGSD3zS1SmUTj26mLQQDZylHF?=
 =?us-ascii?Q?T7G4KVk0Ug7UMXksZJxbJvnoBVj5naW1yUYQmqs4izTAIneBLnv4/AnQODWK?=
 =?us-ascii?Q?FBbSu4Kcx2YseMjCZF0AEKPCdw5POs7Ozh6EvERIs3lll43c4S4MUAH4jJRb?=
 =?us-ascii?Q?tbC5swBQBCkVLp6oaYiQn/93Clo7u9zYZ92bYzyn4mHHfsrTW0KMaX18FPLr?=
 =?us-ascii?Q?vXxjxQ8zJK4Pfdc11p8tmS+jKXyco5tTSk/qPd1U5Zi+QAoR9zIaeZDgd083?=
 =?us-ascii?Q?wWRKtRPI+qcFUXW6m9WIOKWDihCAlfIJJ06FRFTXl3yGZcNQI31yBWi4OcSn?=
 =?us-ascii?Q?V5dOk+o9pRe0W+2vtk6PUmEMR8s3S0IV7I1K6fOgtce1kXzMHUzUsY1yAFJa?=
 =?us-ascii?Q?D0W44lD391BeVnRAT927c9HxnShiznTDtNNqDLSFnXse92fV/u0NUawUjlfM?=
 =?us-ascii?Q?FzjZvhN6ehtiOoQPv11/klkaGpXybe1UI/h06eLsBgFH9XLPxTQjHbkohiKe?=
 =?us-ascii?Q?dc9WbTo7isqJSkZXbvcQC1CM5qS6ImbCOZmgviV/yODaFGp6eqoCA+fdF7pN?=
 =?us-ascii?Q?8KAshPGp2GLCCfItbJfVjhuAy3zVErS9ojQt2jn3WVpsAx3XpXkGgCOt+CCT?=
 =?us-ascii?Q?4hsD/d0lt9cuH9y5gw/7kjFCDEREaPYq9Biy8mio+xsSnTWD+7Zea0vpbGQK?=
 =?us-ascii?Q?TDVBePwNU/4OyGvKxyz7Wvk8H7wLcH7BH6BVcnH1/DuzLc4Bq4+v4YmovE+d?=
 =?us-ascii?Q?/gj5n6UHvqsl/v9m33MVFdeJuil++8txBFdlCJF88x72SVV4C+sP/YHcoHht?=
 =?us-ascii?Q?6W8Kj0nsdUHvmJnNylDYfHzEupqIN80JWcmPRh1fITHkXfUhGBWuu6do83Ym?=
 =?us-ascii?Q?SMKRH1GjNjJWiO/w15D8ITck+Qr1PGceHEYDtSgrcQVK3uOJmFB1tGBijuZ3?=
 =?us-ascii?Q?I5N+qSr+gcfRA3qlus4h2vpyYit1Omj9cA8Z5i5mZu3JnwV16IPSXJRzzjdN?=
 =?us-ascii?Q?fZhkh0IxIfLoAFxbE+WCAwofLQUeiJ0Polv3DUBv2s/8kC5WcL5S6WdYuEu7?=
 =?us-ascii?Q?dbqi/CVs6UaCc6vCrlyCYbLHj7Wx1KsQztsJkkU1xMWYfzUm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UoVdpVsh+sF5rTNzoykmrBn72VDsJ1irmSPt/Sv2KGp0AGYPdiAP7JqNIizuIMZ1BU+PLKoUkfdDwnKaeefAf7V8j32ZSClDHbh/YSygZcoVqXbiB+mVE29x9yZ9XJwW8KbxTcAPRsHh3JmOW2ru0KbV/rpwsy3Aak+8joD1A4hWU04Sk4fseeIrLpWbnguCeTiKufXTsXj/EmDmJvtkvTJ4qbxupz9pJ88rGVsE5L6IBu36tJDSiUOhcEsYBZqq6c5WwMnc0OxLIwy6zLf+/Q+CU5IA4N0zYiE2M6MG2yUwf1eCsSvIrpfsUuj/aJ3sugpLRsobfwtJZFlxit/OIw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c32f48-444a-4340-bde8-08df230acb23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 18:02:17.4332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9zfqbIm6s+oJWVBfA/oMHbA0HV/1wYGfK4BWZulUxZTpxeYW1YOwB1PQMHaY98I+4BzTRyoxzgAqJUuaP0elQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5642
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MCBTYWx0ZWRfX3Y7VyzEewlRZ
 la8mzoeS/iU89qJutEeAW38TsWOUdmdxs1IvqkypnUGTGqNVSy4SIPCZfMyUALYtvEn81wBT5EW
 6CT2wXhBXhqXXKlkJIBZgrluUwJIPkU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MCBTYWx0ZWRfX7QJ2fCADW7JQ
 pJu+W5zDD5TKM8QnDE7RYI346IHXA/SkTq36OfT9Rn3gAyRt8ISFDcqC+DBJ8TiUa7Vg3Gl+Wsy
 bdiTo45lkK7qXallFe2/c2a5Guf/Bnvnubx27h6E124os2yd5JdUXCEFiLxQepfDhvc0eE6Kcet
 Pg/OpjzCxLPLl7U7RowejKbCFb5xJTw7n0YgAshl4WXNfkuVCuhmqj+fzBcrsYWL5qjdASDOVfi
 5ktP+z/2nzy0pDXLPPDaLsnO3b4hMa3fMHAZ4q95CMRGSlj81l+U9rwHSmsj+SGftIQuPlqZGrs
 d+hyfJXNBDu7iPdeVUWkM5NcZT+htrdFgrSxvdUlgsTlnCAtwcHzQ8sJeC5O08AbeBc9yqCBCou
 zdwyxVqPy7NflQDOqGrgf7Cthh9z4vaWWfOFORDuj8D+Ud3+e1cvHyWh9Wrg5jbYA6Z3iHf+cWA
 KyQvMoC4nGu7SFB9MKg==
X-Authority-Analysis: v=2.4 cv=QYPzLcbv c=1 sm=1 tr=0 ts=6ac3e62d cx=c_pps
 a=glTcUGO0A6QcesvNX5ZrRQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=4Kmlni9rdSFv7rmgyeEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: I4c_MFJcpNrzFNgpLdfwcBWknyEtIQui
X-Proofpoint-GUID: I4c_MFJcpNrzFNgpLdfwcBWknyEtIQui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
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

> Subject: [PATCH v4 1/4] app/crypto-perf: support mldsa Sign-Iteration
>=20
> Add ML-DSA44 Sign-Iteration based test support for
> 1, 5 and 10 iterations to test-crypto-perf.
>=20
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>

Please fix individual patches compilation

../app/test-crypto-perf/cperf_test_vectors.c:6925:33: error: initialization=
 discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
 6925 |                         .data =3D mldsa_44_sign_1_iter,
      |                                 ^~~~~~~~~~~~~~~~~~~~
../app/test-crypto-perf/cperf_test_vectors.c:6945:33: error: initialization=
 discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
 6945 |                         .data =3D mldsa_44_message_5_iter,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~
../app/test-crypto-perf/cperf_test_vectors.c:6949:33: error: initialization=
 discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
 6949 |                         .data =3D mldsa_44_sign_5_iter,
      |                                 ^~~~~~~~~~~~~~~~~~~~
../app/test-crypto-perf/cperf_test_vectors.c:6969:33: error: initialization=
 discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
 6969 |                         .data =3D mldsa_44_message_10_iter,
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
../app/test-crypto-perf/cperf_test_vectors.c:6973:33: error: initialization=
 discards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-q=
ualifiers]
 6973 |                         .data =3D mldsa_44_sign_10_iter,
      |                                 ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
