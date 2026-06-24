Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48B3CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 19:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5669402C6;
	Wed, 24 Jun 2026 21:42:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A8CFF4027C
 for <dev@dpdk.org>; Wed, 24 Jun 2026 21:42:57 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEgPfN2664413; Wed, 24 Jun 2026 12:42:56 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022077.outbound.protection.outlook.com [52.101.43.77])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f03u9kcqj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXmc50VdYJ6Fach4a5O1GRx/COakd7LKtC6GoFdD9Efu1ZwVMbuzZaeGGPiJVbdjRQl4r4gmUCaXQ8z1SqxvjFR+PAnqquI2M8/tSgKO1NpZ62RcqP71M9noavezm4VzeAo76jNmh4IwfWift9YduvhNCcScYrjgCzSxRAL6SfEl5236ErtdwFEVTdJKgmjfOOYFIMeQ6RrgefA4pqR0gWfqEBP99LTsErqdfVhM14aiNsK9ZZEfweflSPTiJtAneLYCT4U38v8zgjSwW0plOTZv+nDf73seOtYj6TztQQaUKqDvlTDw+c9M4rDjQ7sOrXpVM/2yzM4iZVU+y7oHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIqWE32IVeYIRY/olUeQtZQRHtxlbbFwo36yS/1WdtU=;
 b=xrBx1U9ja6y2RJLVflqC07SX4u0oAU9BqEhDaItkyceWG7dLAc0n1NhnakqgrfVhLH0L6fdZ5MImNMqNUoFffSUccnmS4JkhK5+5SAvLDwXrK4LBnLNt/+TrYu64L2/83YapMAzvvygm8x2p+GCCLewxQTMyES1RuHKWWkFjRZML48p98yewNjhh5l0pXqEneGdkc+/r32MgVOBCkYoRLsxgYljptYRqEIyyrfV08MFfImXE23Odophphzogcxm+6zieDiojOW/aARBXBuOs1YzkxGeEQnacLYyoYq0WmN7aMCCKYhuecOw8hl/cpgNtIbnm8z3TwfNbnnFJTLEaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIqWE32IVeYIRY/olUeQtZQRHtxlbbFwo36yS/1WdtU=;
 b=LZkgIcp7fCaGEGVh6ALfrwNiGCnX6ajnNezC0u2IhRarfqEmyh2S//GwdL2lsJMc+Zw16T3wx5vL8rANAJGtEt0vfBqGLIHVXHllxZWcwvAyegjc1dcm+Pgk7R+iDXmkaLH2RMhmF55ZL+G2NDk7iyWbafOdCaAryS5USrzRE0I=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA3PR18MB5604.namprd18.prod.outlook.com (2603:10b6:806:39a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 19:42:50 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 19:42:50 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Kiran
 Kumar Kokkilagadda <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Koteswara Rao Kottidi <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Ankur Dwivedi <adwivedi@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v2] crypto/cnxk: add ML crypto support
Thread-Topic: [v2] crypto/cnxk: add ML crypto support
Thread-Index: AQHdAVOayBdm/rAhfU21cbl/MxsTXrZOIGWw
Date: Wed, 24 Jun 2026 19:42:50 +0000
Message-ID: <CO6PR18MB4484FE46667BCEB88F342E44D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260529091330.6308-1-gmuthukrishn@marvell.com>
 <20260621075706.23184-1-gmuthukrishn@marvell.com>
In-Reply-To: <20260621075706.23184-1-gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA3PR18MB5604:EE_
x-ms-office365-filtering-correlation-id: 7c5c9e9a-deab-49cf-fe47-08ded228c66a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|921020|38070700021|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: rLQJR5mPREhODFrO+RL77nyGjgo+dI0J868tclFdaOBUDcxe0P2aVh3wTcZ/ONiVGcXTz1HStC0+f/EVAUVRCPCnrhCbIQ9oIGOWosrxX/xPhZlRdZGVBCxrRCrIFmQ++gGp58o+BwkehOe1U2dbfwws3exIUZO8vwTh8c0W6h7R7ZdtE46Ewx8vC50NYS14fLK4ESTGAYeifHg+dkd7D7TLbxKYYRlGV+rlEPTCuk1BTpVx9GKWEJ0OJic2dvrCC592Dku4xZ7DkVRIDR8Vo7TVwFh/2nacTgXRyKf/UZ3vDqmj0L9qU6JnyAboQyODJp9g63UkZ4FJ6OdDQJrDciBM7wUhGAKiRvcSO+AKHHRJ7spxeV7VerrDMFbeh2dGRSEbxyNFK9+/0OfIUjvuxAEVJdTQ5HNV50xkzqC0QQJ8uu/1JfwS4juBXrCA95q1J/NdWw3Ftywbmi9OoqSelApVyLTbe35C+kikxIcOHzRj6SqPEyLjhaVbMVKd4NFCFz9JUWew8Shs6VM3bUol1DtYC15JymZxPeQRLEB6YpU9St+zLs1Dnn+NRB1JqErydgPt7ZAJpeR/Z/VymLc0xpH19Gn3KXQOTB2vDPOGN8IcH4eSmsQ8NdjMsYq0S5b8TSitCFPG1C678pmnVyPMsxuMYbIFmvduKu9Vu9wjILwTPIBOQ0AyHLkCpzZGCWxpzULdO3CDXriOyX1aJu/NB9w8wS1KwkmoIRJpJSODFKfo29QS0DlpbiEZo6HjSv3I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(921020)(38070700021)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m3Cd/wooST8clcjZ8H+mbnrhsX1hn+PjYkcudxJAvfa4m7K1khXCR4x6pzUh?=
 =?us-ascii?Q?hT5MEcVWiAeDQwO5fjG6mT1qflvDvbtScfegD9npRuBO86rQkYTaFD/iE4o7?=
 =?us-ascii?Q?1dv1Uo27QtaQ0IN2N+OphPu+IMPHDDYwV6dzmFIEjJs/znwLujwAa+Lhp8nd?=
 =?us-ascii?Q?LhT9r2u6Q2JP16JSldE18tWF56FKpdxYTeq7SrEqHRfcvwWpG3hc+VhB1grB?=
 =?us-ascii?Q?RNFE0ANND9r3ohlEzC/medJD0gOgKTgMvrkyZJ6lZjB4zErKy4vRqk8qKbMd?=
 =?us-ascii?Q?p5C5e1CLPDz0DxuC6U5y36Ej8vK51TN5mAFqrAYsXDqv2uYoXcd5pPcLCVSl?=
 =?us-ascii?Q?5JS88LSSxgkwBBOFzLAOBD6sQx5s+dt/4YtijG6lxv631zswPqzUa1uzcus+?=
 =?us-ascii?Q?0S04HVE/klsruXKpqHbAKgJBjqnb54WG+yWDxDvQ9so6MlbXJNQl2yl5qpIM?=
 =?us-ascii?Q?oqWRXlbGj4Yfy4PCyafMFQo4mSyN5kMNSzVT14l68raUGQ8cHnMn9VqVDBpW?=
 =?us-ascii?Q?6Ko4uhgv2olot8Sz0l5TYO96LgzvWrxXc7PXwdiycaiDvVfglFImf7rPHKZU?=
 =?us-ascii?Q?wBzoOShX4uqdBOJVpRSucCRmw5D31wSMHP9jCXjpt5k9jan5ENhm6C2PfXVW?=
 =?us-ascii?Q?lTmD44hdZTnBfNtLkeqj/IekPrYw18OhmZfuCgo0AmjBDWI74sKTSkW6PjPe?=
 =?us-ascii?Q?PODbxLWzlASywDWgDumkKrbEt5kfF7tfKMEKUBxis+g/u/2xZ7TqbERGU0Ic?=
 =?us-ascii?Q?oTElk5bUzI+liLTrrmu/uK5g9/xEfxOhk4rxWYEvx+Yblf10KRj1mHy7tbAV?=
 =?us-ascii?Q?nWD+BJwCVFyci3wjUZoxAvNFc9CWmSs2BVgLro1rdVcjkXNE+6Na3K23Dfgt?=
 =?us-ascii?Q?6LIoyLvw16HpI5uv9cQl+/WZhyngWsXAb0MZQ4h22Jqwbr+7NYz3FAHi/EFi?=
 =?us-ascii?Q?W8RAaYCi3JzZIJiDVKaV1XpO6qoNR6Q/dGYi7m/Tf00BJZa2AgpgAIhJaVwj?=
 =?us-ascii?Q?k9ly1mK6AKyQd8p9hKVa6z9pwcWERKF+y78P+o6gXYJv8xpI+uG9nLUuFzCw?=
 =?us-ascii?Q?+8zQZ/5UFl3HS+cAucqPK30SRnvLSLWWLEXJze3p1SPlkiUL3DOQW/WW2kMF?=
 =?us-ascii?Q?vQO5VXNiUB5tjnzVk1zymGJ4hm+TEprQu4MRos7BP80SeXtI5JjiYfT5PcKY?=
 =?us-ascii?Q?mKggJ/RyU7f+NCBYCBJoT5qff86xBTBn8ctFbbydW+jiK1TsgaJZjFrfgdS+?=
 =?us-ascii?Q?+Cb1QmplCZxe45ocZLJHCDM4/NNbXzCfFZSwAOUgL9iwtT4aWKUt7/1RXtlz?=
 =?us-ascii?Q?TLGgpOuGMHuaI2oiI6D52eqF86uo/R7QHWCg49PGL/kJAGkBPUtsIpliVXg7?=
 =?us-ascii?Q?fEX0opznRPPFVsxwB9kVqCL59ctfi6Csoa1PequwT1fdGIyQr2gTVsf3m3Y+?=
 =?us-ascii?Q?7VbJemrDtMyV6r/KcGWhMaOcG6ZVmERVKadOnDwasBWZnmGDlnckHCqOlQAI?=
 =?us-ascii?Q?6sHCEFyt7j+7cdZLQNwXdBepNsn2n9ptLHhyIe4z0QP8eGIYtQ3MByGSdpi4?=
 =?us-ascii?Q?2l8+NfHaqVcm1lJ7gOTrGqXL519SBlSGH5y0UgxJTr4Xswbr4plr3lyPjfuT?=
 =?us-ascii?Q?mYdFDy1DfHdnSlj62dA+l/6II85jjL43qMtOwqkW9PCjGsXBPTUKr8pVN5j+?=
 =?us-ascii?Q?iKnwxxC8Nb6iQ2YqTSE/Qqzodunc7hELxkYFoGOpK8/Ul8zS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CzTQnIy1weo99ablz9ogqPVU12QdsnP9MX/AgAgZKJymfZXICioF/R13WxvWNQnrvixJSzs+X+Lovd1uUts4NLDlONQ5VSxXr8gmucP/9FdVBR7lEYX+pS+QZmDJbfP6muOCO2CCcMf5N8S2RW6hIcBEy1xsj6pGczqflXuzXwbhAqIo7eFoEe2focL4stCxDgSuWr6tfr6f8ju7yFX8qIkggPONW33cHXWyh6EXnJLQlQ/1bTlC9Fmdxml1aN1a0DsaEMNU2vam7wKIBQ0EM4GfcR/B7iSj8xVFlgTuKG/spg25DzwsIvF+FUSBxqxONWeJiVgbyY71HQ4Qg2XbJw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5c9e9a-deab-49cf-fe47-08ded228c66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 19:42:50.2343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EmIa4yKmemDgorYH7h4lHciJ41mqO0e8+ZQZKyCBHsJ9vYIdvHJHVlm3MWxGm9mg5rCj7j0MH1dvDbwUnnVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5604
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NSBTYWx0ZWRfX1+bZLevVNZ7+
 YTpbi/3HQ3J6cU6QiwYpasbqjxsZb61Ww85Rc2Y0D3crZ4lMYOj7dpGEC3N4A/muRlBIthdGfcC
 X3t41N25J5lkha5M9T4EA3LH2EF80mfbTaYA5t5mYHGHwW2TQg8WGtc6Q+/rMBl6sGhCLzndIZz
 N1d/Ii99irpurnwxf/WxeHKTO7rdfN7XYfJ0ZSvnGpQxxEaFUbGAmsgct3qLmAqR/xiroJegHNp
 itsq8uKXp8nxekJ1lZBLoiDXcn+3R+WFNxdBcZRwaM4ROIzTe7qVR7FuWfbfc9OcdSZT1D2fVLd
 bw/OxIkpOXmtl4iy1bnMxGYLmTLUbANLmJFsSwxKRFLl0hfZAfLO8O8lsr9OkaNMqkg9oc6tRgR
 yssqIKnANZNKukIMt87zSFhbEMAONA==
X-Proofpoint-GUID: N7U19oPM4Q6-L2_zdaHoIVJ_ukAHwmEt
X-Proofpoint-ORIG-GUID: N7U19oPM4Q6-L2_zdaHoIVJ_ukAHwmEt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NSBTYWx0ZWRfX+9YNAUdFmLj8
 eLgN/L2pOT1dbr0zl5HVPrCXBa0rTetVmbSfLLOzCcwo5soH8u3BGR9cSwSp7VXvL9L5U3tv04b
 6x9nKpy0raW4ROYQ+XYxvRqmQppQoi0=
X-Authority-Analysis: v=2.4 cv=LMdWhpW9 c=1 sm=1 tr=0 ts=6a3c333f cx=c_pps
 a=7Kp79o39qosEjZWU4lqIzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=pc2GyZVw0M3PzUr7JpgA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
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

> Subject: [v2] crypto/cnxk: add ML crypto support
>=20
> Add ML-KEM and ML-DSA support.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
> v2:
>  - Addressed comments from v1.
> ---
>  doc/guides/cryptodevs/features/cn20k.ini      |   3 +
>  doc/guides/cryptodevs/features/default.ini    |   1 +
>  doc/guides/rel_notes/release_26_07.rst        |   3 +
>  drivers/common/cnxk/hw/cpt.h                  |   1 +
>  drivers/common/cnxk/meson.build               |   1 +
>  drivers/common/cnxk/roc_cpt.c                 |   4 +
>  drivers/common/cnxk/roc_platform.h            |   5 +
>  .../common/cnxk/roc_platform_base_symbols.c   |   2 +
>  drivers/common/cnxk/roc_re.h                  |  31 ++
>  drivers/common/cnxk/roc_re_ml_tables.c        | 248 +++++++++++
>  drivers/common/cnxk/roc_re_ml_tables.h        |  19 +
>  drivers/crypto/cnxk/cnxk_ae.h                 | 399 +++++++++++++++++-
>  drivers/crypto/cnxk/cnxk_cryptodev.c          |  11 +
>  drivers/crypto/cnxk/cnxk_cryptodev.h          |   4 +-
>  .../crypto/cnxk/cnxk_cryptodev_capabilities.c |  62 ++-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  45 +-
>  16 files changed, 817 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/common/cnxk/roc_re.h
>  create mode 100644 drivers/common/cnxk/roc_re_ml_tables.c
>  create mode 100644 drivers/common/cnxk/roc_re_ml_tables.h
Acked-by: Akhil Goyal <gakhil@marvell.com>
Applied to dpdk-next-crypto

