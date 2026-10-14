Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DECC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:12:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3511D402A4;
	Wed, 14 Oct 2026 18:12:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4650240144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791994358; x=1823530358;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=fn2bO5B24GYqYU7OJN7vUyLGqzpHeqbcNyaLevsatfU=;
 b=mLiHxkJRKhDmIZfWBCk9un/kKSo3cGPiQ524gQQiIef2MvuVvUmSYB3Y
 cI2cTTu8pEfhWeEU9kLuv9m1FQKsOz+xKNCbFnZgl3Ic2KgUHE/VZxyCl
 tlXVpnMdvsFChucjOnfyIA2wZaewqkA78sCCTn+WrPws5eXVrm95diPqC
 UvjwmgmfaFobH3YN/5PwCdvr43drKKIcngyk4mNBjAVN+U7hxoJZKh/di
 /3EOmwunptvGZal870qx+MBvf7mSh2ES2JfYp37WURqAq4tbYIBSZZ31Q
 virreKMYrEJnvOcBbWVpC6J8IeLVGFXwNeuQ9RgtsMyiVQk479GfeSnKo A==;
X-CSE-ConnectionGUID: nL3XKXEnQg6LfR0+JpPLXA==
X-CSE-MsgGUID: 3Jp9S+GdSsqDZGul8Yx06A==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="734433"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; d="scan'208,217";a="734433"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:12:36 -0700
X-CSE-ConnectionGUID: Cfry+G4uT9i0Jsxq6j4AFQ==
X-CSE-MsgGUID: cLP70UxGTyeegA1Lx7M3+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; d="scan'208,217";a="1371669"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 09:12:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:12:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 09:12:35 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 09:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhNVcwGymOkg5b0pJrB6ic0FjTCCm1f8EY1l3EadQdftQvJHtpalM7QGY3F+gN3fZRBWYD60gS4jXPJjl9DR78pdaLSoLIeyLJRe4dh99hMA0uyDFx9s3qLsnT28VnqYisTHSJkzFarI55bS6zg8mOJ07YX5fyRFO8IuSK+dM/gCIq2RCt5h5T+7sSUpjpPHE8BbABo7uORcIyHefg57IQ3UYzyetHecWTL8Ceht9lGi1dE3kWZk3O4+m30cSRHIiyUCB3jQXTMwS5lz/m67K5T49vf9Q/Ok2P9VXRERpbgOFjHVICXjz71EwbNfgOaRwvLKAQWqIuUv0TKcst98yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Nz+FxpBzN/PUZD2TdAQtirI/5+lpur3nhgaGguYjmo=;
 b=w2ljUuwNtf+lw0rFEE+ZjJrHJ7mF/1KDYHuqj9X8fDCoPHBTLf89Edx6lGchqUlpAvtb1HtgZrVCvwfyaPbkBv4Hsuq0sVawNTr1GCL1JXOnNWRWd1EccloYq8z04ou91rlIH5nXu8ACSehM4Z3uROWZGPII1kZaa2OjVMtkhD2RvCgM8QP/cHhYCv5LRO+9wXkayMrzm/pTAOzI9ynFnXI3ZoXQ2AjzmGxg3j5w9dp+7m/YGp+fTQvjn3yqyLpTTYk9pq0MKMc+DHdlt1BC6f8TjVII1BjVsEVaMyeBTEZprcxd+HmJI1ypvJVIO1Z2XIlLX2NQClFOssrh6TcCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 16:12:32 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 16:12:32 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Thread-Topic: [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support
Thread-Index: AQHdWvX/WFOAnFWG60OuJYzllw5Ke7b9N5gj
Date: Wed, 14 Oct 2026 16:12:32 +0000
Message-ID: <LV2PR11MB604554ED03EC5E9FF1BAFB56819D2@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261012083506.754857-2-emma.finn@intel.com>
 <20261013093312.817235-1-emma.finn@intel.com>
In-Reply-To: <20261013093312.817235-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|MW3PR11MB4586:EE_
x-ms-office365-filtering-correlation-id: 084dffa2-3d08-4c8c-cc7e-08df2a0df3e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|8096899003|261009223027099003|38070700021|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: Z7GgTVGkO/74Pl0xu8A50v7Awqit0BhLD76lrJzes0lGCTduJBPOwMxjP62WaHQM9grJ2lguNBEU58lTKAYLGkiiNXNLQLJwjo+RAFwqBFj/EIt8Qk45C38xGR2dpuo+Og8ktdYh1jRD6y3up8r1x8OAuNbzHYvrKhMKjpGi1U2D6usLRuedGkqc6+MaakAKgB2xXrw6TZSOo4mMuLivvXWHS7jMn7lTDC+D+M5J9yJTMwZdv1K4vGpAetFhtwrG2iCkpnayOBak4qv3wfQMjaNc2fozN0ijNWEZShL60g62aNn+Ff//nh3KENniR9vLd+cFsgNV6l2PHvCI3ev4tK8csvyaaMiA1PVYnnpa1RWRvWgGMMAn9/JTpwEwUjabibbjYzauoFZR98Eg+m/vfwULOJlWTJZCZrIhvIMzYvmzgNfKdLY/88avNNUcqbyq6ib0jfv8DrjiESGQXlKYSSP32oWVE/YyyQK9eKS4jGBXD99gc8WjWxbZgpM7vB8U7p2s7m14y0dOTpP948uhbJEcxPQReYZaaWO+VNa+bqmyhlfkx524EJrn6LeGoPYOf9JFRLVuo9RPGUs9vu4WglvW0IG43MlY+vyiwOHKnxs5MNTYljUvJRmA4VM7XFjYXXyYSr6t49ZSbgWbvMXFiB1K3vdK9HhEbPM4tTczJVku4R2Tz/Uvy+LTq+IAJsAtaJG4W7kD4BcNqnq+58OaZaqAZkI3L42MY/uiblWKsVA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(8096899003)(261009223027099003)(38070700021)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XGBjI4NKcil2mWjfMIwDOrlBDiiN6EzfDPyziXFkDzfG3l5a3dpgB0gEBH52?=
 =?us-ascii?Q?Yytpy54tqgHD0puRu7CKFVoQ5AX0UBRut4/jKUepWAHfz4DLKadhXXai9ATG?=
 =?us-ascii?Q?t35XHFFTxor3vJ6qIyAqcvyMYItd8z73bCdL7QJ9Htnpx8Vf6kngFYk3yS/i?=
 =?us-ascii?Q?BwnBkoizvPN/83Sd3F5CV78Vm6EpWvKsXHlh+Aso1t4Kui+V7a89WUqX0ith?=
 =?us-ascii?Q?OdBx8bFfHMn+Ovd3H5Ms8F42+NZE0lcsqQ/YAlcjIWJmkRy6wteJgbpy4xem?=
 =?us-ascii?Q?BATEemqDTl6do00F0x+TsIcmrOgeno5VcKjhKb88+fHOiqXBdnvgoTNEPIYZ?=
 =?us-ascii?Q?bTwIFyhYs4eh09VaM3UOUEn9hrDZEvRECwrJSLLNEJwMvl6GsORCspfCS30x?=
 =?us-ascii?Q?zGDa8396HMYtxJWL7qxV11eT9gCzI2DzM58bVR0k4B/1NuupofQsSfS7LNdR?=
 =?us-ascii?Q?53c9dAGqIK8o7z7vxT+YEpVss2aanR301AeMQY5y792e/nTHfxLN+gAMkdp4?=
 =?us-ascii?Q?qxEht1sKEg5LHtKxDgQxQsBqOU7vOC4MGwFoCyGGuad0TgyWJsGkTVlU+q4f?=
 =?us-ascii?Q?wEO1MfYVe7cOJo/sM5nQQkZQPfq7TTqiouGRMqYBbO67DmmWVcjXc5BNA9dr?=
 =?us-ascii?Q?fAZsKJxoVvkd8VawZ++/p3uk3BkgPS6u5ce6zKjBAM5JBOiTUwQEKMgHFp6H?=
 =?us-ascii?Q?fvWfN1VxyB3upl2FVRojjTr3+M4t5oj8TOqmvYGwms6e57qv36by3Tp36Z/F?=
 =?us-ascii?Q?krPkOx+mNIWj3b3C4Yqiv4sA4mF0O1RMNtnEuAM2BYUOzmjybunRCcYWWl/2?=
 =?us-ascii?Q?ls3mJP+YQvonKy4+9OGQ+p3zM0BtoyI1c0tuLrMSbQ5kQ8PAVPGishFKO3dv?=
 =?us-ascii?Q?0r2WDAGx44A1wbAv6AN5B98jOT5vUmtvtHWQCR8sM9va92iUBuKzeLAk2oSt?=
 =?us-ascii?Q?ngZEdYgXwHZJPZj6asG7BY76XuqImoe310iihfM+B8VpJ69+tnvqBt3XhWC+?=
 =?us-ascii?Q?OE2DVnZ86ZQQGP3/Xnlm/uLsAm0GXRx/5sbSs00tZmKjGwLR5+nyzz33TlC5?=
 =?us-ascii?Q?15JUhoae7MJZ3M+EmPiKU7cK8t+lRtl6Hj+hQnGo8LO0yNF4e2S8uTpIJlD2?=
 =?us-ascii?Q?3bWP2G/zn7Th+HcTA4ptFPqW9kHv1Wr/sJDkBr96z8zduIHGYusXJjSLdCS3?=
 =?us-ascii?Q?aZz8nYOOPyIpH9GTat+X+4KFLnDHolworH5f1MVHaVah1842aqcSrXR3mkxA?=
 =?us-ascii?Q?nik8K0nvHcmvhFBPAzR9Vcu9ddzMBzdzpkitvA0KKldX3BqeOfowzOvfQRrO?=
 =?us-ascii?Q?xjxI3mqtZIfVh85Ey4Uw7jWpWM+kzZEenFO5uBGxuopa7yJGFRh3VDHTzQ4J?=
 =?us-ascii?Q?RJ9cvTG7UrZpfHXi/m/pxduGT2ooIZ+PHrdcpKvlrTCCEdwIP3WFpX46hKcv?=
 =?us-ascii?Q?P4pJ3Ud6ZUVCd5wit6gBSJ835iH9lbU2nkR6xEEch0IC/dVSpB58EtyJ5KlT?=
 =?us-ascii?Q?FT3/YLSJrxdt8kKnM8PokQ0xCA2y062PohUMlVXhQJetOJWy6Yyd9mkeNw1Y?=
 =?us-ascii?Q?DviKEv94ILZZlXt8v+sq0IMXutkZfAaxU0r0G7jWIEoTcojH0meWsrApg2FJ?=
 =?us-ascii?Q?4t/RAs/Fe0hHx8FKH7mXFDOZJ/3F6LhUCFRVLStKlAkRoFR1g5UU3EIsTb+o?=
 =?us-ascii?Q?mB5qlS9v2I2gIXfJNnq/EAqC1fSR/au+6ALeeC0RyDev2qZm?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604554ED03EC5E9FF1BAFB56819D2LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2o8EiD7syFEjuXWf0PNh01okZ+Bv4DkONz2ahlI3khEbeflUYdiwkrZzIzwMdon/HpbzbX2lWBUqKWBXUKHtV/JiRUhgfcSPQnG+2QKHLl1SpRAlgrH+S3Hh9VJuZ81hIDCcbrlwWg0Xx2qyjGKQcihwzqBh1jD+CTetZHuj+UHZVEZgzjZjtTG41KnmXWj3soOkaMS6OD8iUcw8g0caEMviAad75TEXzTMSIPGVhWe9CklM27avuUZ48P4RrthJym3wBcaaj9BgMuUGICWvaKxE+E99F3/RLBin1fhujCGQQUaJS7PPSH63qya06tZRywOHhjQabH/9102fSNjLWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084dffa2-3d08-4c8c-cc7e-08df2a0df3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 16:12:32.4286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZ6cwdr3ipKVrsrFprKF+ImTOmKdvO26oj9c4YS87MGNphY+nrG+dctVQ9xOMAjUrcl1jdtCV54Go5SHHmtLZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-OriginatorOrg: intel.com
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

--_000_LV2PR11MB604554ED03EC5E9FF1BAFB56819D2LV2PR11MB6045namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series-acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Emma Finn <emma.finn@intel.com>
Sent: 13 October 2026 10:33
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support

Add SHA3 and SHAKE authentication support to the AESNI_MB PMD using
IPsecMB 3.0.

Emma Finn (2):
  crypto/ipsec_mb: Add SHA3 support.
  crypto/ipsec_mb: Add SHAKE support.

 doc/guides/cryptodevs/aesni_mb.rst          |  10 +
 doc/guides/cryptodevs/features/aesni_mb.ini |  10 +
 doc/guides/rel_notes/release_26_11.rst      |   6 +
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c      |  38 +++
 drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 260 +++++++++++++++++++-
 5 files changed, 318 insertions(+), 6 deletions(-)

--
2.43.0

--_000_LV2PR11MB604554ED03EC5E9FF1BAFB56819D2LV2PR11MB6045namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
Series-acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Emma Finn &lt;emma.fi=
nn@intel.com&gt;<br>
<b>Sent:</b> 13 October 2026 10:33<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [PATCH v3 0/2] crypto/ipsec_mb: Add SHA3 and SHAKE support<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add SHA3 and SHAKE authentication support to the A=
ESNI_MB PMD using<br>
IPsecMB 3.0.<br>
<br>
Emma Finn (2):<br>
&nbsp; crypto/ipsec_mb: Add SHA3 support.<br>
&nbsp; crypto/ipsec_mb: Add SHAKE support.<br>
<br>
&nbsp;doc/guides/cryptodevs/aesni_mb.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 10 +<br>
&nbsp;doc/guides/cryptodevs/features/aesni_mb.ini |&nbsp; 10 +<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 6 +<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 38 +++<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb_priv.h | 260 +++++++++++++++++++=
-<br>
&nbsp;5 files changed, 318 insertions(+), 6 deletions(-)<br>
<br>
-- <br>
2.43.0<br>
</div>
</span></font></div>
</body>
</html>

--_000_LV2PR11MB604554ED03EC5E9FF1BAFB56819D2LV2PR11MB6045namp_--
