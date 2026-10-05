Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9CCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 18:14:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 812FF409FA;
	Mon,  5 Oct 2026 20:14:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3810A40679
 for <dev@dpdk.org>; Mon,  5 Oct 2026 20:14:32 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HL1ju1164901; Mon, 5 Oct 2026 11:14:31 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020133.outbound.protection.outlook.com [52.101.46.133])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h49schwn9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 11:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+2nNYV6dZsyzVCtIQU7kd6D86ldLC3Cbv56EH8kAFQwB0w1ywyS8DA0uu/0TfU1uMe8HUSNa3GrqYA23OnY2wsxn24RisAyZrA6s58Q7/NYQp9Dsh1/1ffVgvhHWta8a4sr68g5pXtBD1mtmwlsGhuuTKBlQ9IyeJ2LnQ3rlo6IA2RkEaoK5DMxC5DVrZBQcGGqQ0rlWK7ldMUDp9Y5VCCU/vhHCUr50tkz6oMWethvzXyASidSinoNo6xAQCpUP8BYXkhJMO6VuB1Y2VWKv3ZXjfgnV5P97JELYQeTZrz0JOHYwrTPhgFlCmYEL6J/m4mc/80q7enZuGiTPKXUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6iOpNCBNSOeCDiACaIVCurETgOtSvMgm4eX3/uoprs=;
 b=SSNqSdPRAJG8aKbSiCgzKXhposk/MdumiNjrJiwjxEvXaLbznXdFGW49dQ8TJV6tOnwOCV3ALsmMbyFHKrKffj6G3P0TBAp5QNgBuAW0sh6dARoiWSjXJZO9fBigqddkj7UxxJQVLKtlDLmimwq3ZkewgV+JCSk/FjJHy0IM0iriBX4LCRPCXsK+Zn5ZAzPGV1FtiNtQSld+mdCbLGgMTXt1WXGL5d/16ygHldgVdk3ApQ87mZhRPjolfukdtu3MKt7lFup2p1FdY0k4XJhlpqS9JKki/sFGLAc/rg9EamLC/viM6ctmiZs/53ihUnpAwaWwHvvZ8zE+wbXR5AKD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6iOpNCBNSOeCDiACaIVCurETgOtSvMgm4eX3/uoprs=;
 b=TPDZCgpbcOeQJH7qd7opPxvl9Se5BMpjpJMb0n+apvYeLpJJOuh+cjqF5xUsHRa2xC8iFV93J8vuqMOGhnSB9aQsxfAXNPBmFp1Gq/TYxVqqNALlSChaYnjx7P2qhqEzJj0iKg5HXOYh7scmyGPGc1GyRtqrj0dMPqM0/Xq+5iE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH0PR18MB5143.namprd18.prod.outlook.com (2603:10b6:510:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 5 Oct
 2026 18:14:27 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 18:14:27 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gagandeep Singh <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v2 6/6] crypto/dpaa2_sec: support AES-GMAC
Thread-Topic: [EXTERNAL] [PATCH v2 6/6] crypto/dpaa2_sec: support AES-GMAC
Thread-Index: AQHdUKp7PWPcOQ06u0Sp2PBIUopjPLbvSMcw
Date: Mon, 5 Oct 2026 18:14:27 +0000
Message-ID: <CO6PR18MB4484EA4567BDD3882AC661F4D8962@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260810112951.2879825-1-g.singh@nxp.com>
 <20260930070809.1929564-1-g.singh@nxp.com>
 <20260930070809.1929564-7-g.singh@nxp.com>
In-Reply-To: <20260930070809.1929564-7-g.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH0PR18MB5143:EE_
x-ms-office365-filtering-correlation-id: 0815c9ca-de08-44a4-c8e0-08df230c7e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|11063799006|4143699003|3023799007|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: hzcyNBjzQ4HyL8AYtJHxDoqIWTG7J9fJx0MknUS91ui+UmYG3b/wScKOx9/gynlpLGRl7K7ERhPPXoXsIQoF8Oxq7N2rk1NmpmGiOXfQk/mMkIffG/q6xAOVw4Nd5oBB+O1JpUvmqMcZkpp/+vx0RskhS9Adfu7jjqyBEI0a9tmRI45mkXaSn55w8yfcX//bHghDexvtHyLH5wrfh2fdfLnrxL8kFtKsCJ7K/OxpvlVAy8Jk0oJ3gC+5ZoZuQzPqNZh3iK2AWeFtzNku/dDybTKWBrKBT3R5MGUkNWiimpXav9r7VdHHNI/16/0/9m79QpB6jufOBjSIW4RVlcymXa0L222sNUXcW9TNN2sTSuwMscv0wA7DUkXENYDw7R8mDICf3VWgcJf4iiAi4eD3OzYmbzPMdbTeose8yfIdcI9cUpr5eagUZz3JbTBtsVKHy2ny4d0qELX9KP2SQZVFSfr36cT5fBz4HhDQoWS+acUTL07Nc117dtcZrnewW+lCv8pwZuat9nt/+xEnI+B42AZh1qVe3VqgJ/0cFRK1rXXYp6JP0fg8jh9wPij30DAoAclboL1Zhb1cOjB+FhYe4ae8DlnNt6QUL90UsJKdL2xoL8hmNaHjeu7uB7Oy1y4t9YM+GVSOW+N+JEfDPoJ7m6gx8RisKLuuKQL7bL1xul02cNMH/d+5dpmBXaneUPK1NrfYkEoCa7yJ6il+AJDiyhV7tBlsIWBX9g+cJhyQOBs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Adm3TaE/sgnYV5Xfr8z4xNbegzxOtecCmUo/YvQJX4uPj031jA/VexFaoUJL?=
 =?us-ascii?Q?EsXecJipQMWTX591NLKNYcZTl9oh1DJ8y/WL3TtVRqkB769ZbMxyrcx3O0le?=
 =?us-ascii?Q?Rjswl+ndfL98eMrYrQ/gBPLTuWaGfGAAUQrv92NROfCQC1hWcgIjN/x/yvEP?=
 =?us-ascii?Q?CcRSRBuGyABcvr0Ny3faxH9H1pC3TFBwfnQKNxVW2GtVvDmJDZngD+xzmHfE?=
 =?us-ascii?Q?c5QVE+HaTmqgFbSMA4ZooGNwpewdZR3IaPASuC36QLmkZnsfrHIIOaSF4plF?=
 =?us-ascii?Q?qlY4LHl/5e+bfcBZfa2WTutK6ZI9VZfdCfK3eCMFEjsf4ziAW097wzQWdXQp?=
 =?us-ascii?Q?t6wjdk4KjHFJ0knQVGhZ+QcozszxaJHn7atsZjOLNu7e4X6BKgNx2v4o10eO?=
 =?us-ascii?Q?roA40vAWZnoJKTIVjJXbBNX8TZ9S0FvjM8BYbOQUo6Fd4KIPhssn2SBgpN/f?=
 =?us-ascii?Q?vvY3hNY/d+MkbHI4Pf2xDPwDLdZ0JqJPjM5y01QPONOmx1gXCb8WW1B+/zYF?=
 =?us-ascii?Q?lBbmcpmPNeFBVGzYzqUYX/4BoCm+t7RykupyFylPhFQLv/EH48bd6sNQ/qN1?=
 =?us-ascii?Q?ghuDjFUN7/vhXvV7SdF11511DgOeDRXVYd6pHD5r3wXNEcRR/47F60QxsE+i?=
 =?us-ascii?Q?xQwF3w4ESfg/zzHUMEdO1PlAS5cd0ou5Lavr7zGFv4r+y7DR1jAnDmKqQDnI?=
 =?us-ascii?Q?sJLDGbz/RyJwosnNmWGJGZKIKZtYOsf2FJz/gAS9ogc9J46kbxZzyrzRGH4v?=
 =?us-ascii?Q?khsp9qcGBHIe6tKmdw1vDTlyEmO5EvlM0YSIeYJ/FNc3Tz6jjIK5uxFzrrmL?=
 =?us-ascii?Q?JKU7hB5wYXoJ5q4j2EBjgaXea8umx3kp8WS5rbo7tN4H1Sw5wi/otCuNM3Kt?=
 =?us-ascii?Q?8P0QplMMgv2hn2MJsksHKy4T9Dc4RKt35M83X1aNt9F4PvlkcBH4PrNmw7M3?=
 =?us-ascii?Q?Vi1yQWmYLLexBIsXYAtCFczJPHQeXJhJZzgagN00kjP9s/YR6jQcze81RywC?=
 =?us-ascii?Q?DHCwR2llectqAcoEPJiokpAUPb2lrwDc7lxNatEgn8YA1nhvcsEZ7XO3cyOY?=
 =?us-ascii?Q?Gy6F9Tcjn5Po7WvVLs2LD2hBQk39mnEYsiHZROjKCBz2kQ3mt55LtYjG9Lhn?=
 =?us-ascii?Q?3bs/ll0co9UlPgjA2soc8DsavugR8yiLoA2U0LhYiDtD5RbzjQr/w2oc0L1k?=
 =?us-ascii?Q?CmFQtKJhc5qDBC4LVOtA78RIfUccpHCJ3mRU+PdIufm/A7QFArKI35VBSY05?=
 =?us-ascii?Q?xNfB3nzJ/MEqVfoPigDyYAKwp8lg8s1TuQSoBZ2xuhakN++LjuUoDOYeTUOZ?=
 =?us-ascii?Q?tc65Vc5aVzu+irPuDHRx9TaqJlLEx8wUDMSY0fy+hoLMRpiajmUgKgnq3pIr?=
 =?us-ascii?Q?gOkoFGE1fAdFqnfSJOvKwNQ/mW7EIC65wJ9mE/XTZYrV/W3s4IMf4rDzq9lf?=
 =?us-ascii?Q?LQ8b717Zz1NLC0w1Yh/Z0R2Rt7S/SuGD2ZkCcMvRWEdnegzroGJqyhgv+PBr?=
 =?us-ascii?Q?4uS3V8UIJpiHnHuiWF7NSnDoFdtJXnXsFAEcaG42tGrKuiPUSvGhXBo2c6OE?=
 =?us-ascii?Q?vhWQdamqYU6FmGmp9LiUK+V6QqFgjHCJS4U5OAfkFxaVFlD/qFdNmep5ctuY?=
 =?us-ascii?Q?ezs17NyXX8CWMaRwqVqpDnEcwH523TsK0xtMWUba+qjhu7hEzPTJo0cW0qNw?=
 =?us-ascii?Q?CYzTMJq4KW7YKGsvTT58bKorcFDTmNdKCLioHchOkq6HUhhp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: APOGDPS+vQQXBzWoDxUGuB/kG+ltOU6FRbiGVH+AloFL/Mz01pClK6/TAg/tk7lswHQqvMvsOdVWJTfJtADwJwKDxY+ffzxrc+FGfd6tBG1btJ0UdTtN6n9Dd0C1Rp6Rc5a0rPc0zVWmmAy0YJjptOvKO79ULup8lpHyfGXI7lkMjHAAijDoxIPEe5bEcdha46Vku14B+VT9bJg4LGgXAaglcdR1W8jXnEURRb1icRwPXaELdiFtHYZsJ8DpLsSbHtrf6V37winWC45BHjvGSV8pOi8ODpJF4gv6Gi+zZjwYZxt1m5sHal/pco8XcJ+m6MlySE8WRahiG1IMfyUZsw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0815c9ca-de08-44a4-c8e0-08df230c7e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 18:14:27.2959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: droQfiQtcHjmwMwIFLWA+Va4CXT2rx2T9iarzfthcgQNYv6Sl3nlIAtcyMgRItTw6rYaNQfp0bKMRwkXcnjq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5143
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfX1hzf4h+DTcp6
 lgL5FU8oxNdtMo3rMGlX6n8vzYrmg+OCkH7M5CEHUoWD0+YPZIQPNjSEBCOtqKIRqLn1uDAHxP6
 rhvrafBhabfMjL0nfp3J4Sjln206eH1R+JYb7nwBT02A5mI6eVY9TWJEIOVFzeUMjhi2+wc7fpJ
 dzvfCuk4OEvosz9zpmd7A8hX5cuDBcMwgQCXPOmtcdMIxOnvdTb9wAHCQpfGPGH/xNsU1er6kou
 BJCqlCPoMsCKe9VQYfUbmr9EyoDMPYcFY61E6F1dNV7pbIdqoGoKvEdzgjPYr4PtHnkXxFsUi7w
 F5uwQWVQW/lOjo2aU7F5FXZWOUeRgp64cMQPGQDEw4OB7BUdtNW+yyrZdTFZwc2R9YUgBCt3IsQ
 4IrdYa+PnUx95Gtj0vEtJSdtRL01u1PexN+R+pQ8iMn/44cFIFaXk8g7DEZIV/ASStDFdny6giI
 /0G/ybpYjQyXeGkYmmg==
X-Proofpoint-ORIG-GUID: hZmrYgPV1iASyFtSp-TciPrVz2xKeOuz
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ac3e907 cx=c_pps
 a=/64aUU06laRl6xO2iYKDkw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=8AirrxEcAAAA:8
 a=bctEG0ypv6W1IAfbjU4A:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3MSBTYWx0ZWRfXyu/hDwZvxxCA
 mCDz6fgogojJ865+ZFSdnqdyRx+6/C6Jx8CGlZuYuDbs7nIs1wiOk3Gkhn76igbAALDTmqmkQDr
 kiO703TsoADLdx9N/gIb1mRd2RRPoNQ=
X-Proofpoint-GUID: hZmrYgPV1iASyFtSp-TciPrVz2xKeOuz
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

> Add AES-GMAC (RTE_CRYPTO_AUTH_AES_GMAC) support to the dpaa2_sec
> driver
> for both symmetric auth-only and IPsec lookaside protocol paths.
>=20
> For the auth-only path, AES-GMAC uses the GCM shared descriptor
> (cnstr_shdsc_gcm_encap/decap) with per-packet IV and data supplied
> via sym_op->auth.{iv,data,digest}.
>=20
> For the IPsec lookaside protocol path, AES-GMAC maps to
> OP_PCL_IPSEC_AES_NULL_WITH_GMAC.  The SEC hardware protocol word
> treats this as a cipher type, so the GMAC key and algtype are placed
> in cipherdata rather than authdata.  This is handled in
> dpaa2_sec_ipsec_proto_init() by overriding cipherdata with the auth
> key and setting authdata algtype to HMAC_NULL.
>=20
> Also add AES-GMAC to dpaa2_sec_capabilities[] as an AUTH xform.
>=20
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>  doc/guides/cryptodevs/dpaa2_sec.rst          |  1 +
>  doc/guides/cryptodevs/features/dpaa2_sec.ini |  3 ++
>  drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c  | 43 +++++++++++++++++++-
>  drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    | 28 ++++++++++++-
>  4 files changed, 73 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst
> b/doc/guides/cryptodevs/dpaa2_sec.rst
> index 925d3371bf..d9a661c272 100644
> --- a/doc/guides/cryptodevs/dpaa2_sec.rst
> +++ b/doc/guides/cryptodevs/dpaa2_sec.rst
> @@ -125,6 +125,7 @@ Hash algorithms:
>  * ``RTE_CRYPTO_AUTH_MD5_HMAC``
>  * ``RTE_CRYPTO_AUTH_AES_XCBC_MAC``
>  * ``RTE_CRYPTO_AUTH_AES_CMAC``
> +* ``RTE_CRYPTO_AUTH_AES_GMAC``
>=20
>  AEAD algorithms:
>=20
> diff --git a/doc/guides/cryptodevs/features/dpaa2_sec.ini
> b/doc/guides/cryptodevs/features/dpaa2_sec.ini
> index a280c7b51b..49434739f0 100644
> --- a/doc/guides/cryptodevs/features/dpaa2_sec.ini
> +++ b/doc/guides/cryptodevs/features/dpaa2_sec.ini
> @@ -48,6 +48,9 @@ SHA384 HMAC  =3D Y
>  SHA512       =3D Y
>  SHA512 HMAC  =3D Y
>  SNOW3G UIA2  =3D Y
> +AES GMAC (128) =3D Y
> +AES GMAC (192) =3D Y
> +AES GMAC (256) =3D Y
>  AES XCBC MAC =3D Y
>  ZUC EIA3     =3D Y
>  AES CMAC (128) =3D Y
Please fix=20
Warning generate_overview_table(): Unknown feature 'AES GMAC (128)' in 'dpa=
a2_sec.ini'
