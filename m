Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75997606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UUZ56aH5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5906E40283;
	Tue, 20 Oct 2026 15:50:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id EE56840150
 for <dev@dpdk.org>; Tue, 20 Oct 2026 15:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792504253; x=1824040253;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=aVqJ0y+++SH3wcFkGXbRQepDq4IftEh0rIoj4NJP6qY=;
 b=UUZ56aH5hIynRxBCG/z2nebH0xjhgfJRrMHDkY7pHMtgsQJ+QHMgP25u
 ekCb6gaBjjhv7oGx488fXYGR4I5rlACUiZ7kdLilIvmOORP4KgiV8xIB6
 qNCMUd1rnrmpY8gafx9ulpFSQQC2l8MW6kdVLa24MfcApG3RDuulXFMrt
 ATV5y9XYHV6ax+GxIFntaPh7BJW0o4WgmNyyoV4WB/KIWj/F2U1lFaObR
 +ThNyz4aLdTwxOnkK1w6rmvStnj7e3DlceiUM9py9zVOAFndOJHEKzJwQ
 YGcEHzaxeFuWJ0nPlIVvJ4uw+bfykiTFWWW8blyHAZTqT2vtRWYeW6AnE Q==;
X-CSE-ConnectionGUID: 4GUIriIDTiCBlUTgOhYMQw==
X-CSE-MsgGUID: JtOTT/yRRyWtjjXreQCV3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1213399"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; d="scan'208,217";a="1213399"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:50:52 -0700
X-CSE-ConnectionGUID: ab/rnleJQWe/nShZCb2GhQ==
X-CSE-MsgGUID: ehhSpRo3SlSv2sY3pE91NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; d="scan'208,217";a="3144455"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 06:50:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:50:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 06:50:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 06:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwDO9t/yqt0J6oKBjuO2qZo4Bk3oeD7pKjxgTLjEbucvEwqGeOjdWe89pljzzonLveFA8JhyCXgF7crLTCA/G+RfXVvIT6AvSwAOefnDtJMqoJrm+7rMK7Q/2BtsMXU/tAOTy2rQiO36ORezDGYRis7qKXt9GaOfWIo/PiA3xhwmynyQUvBIFMnAwwJ7AUQaFscUbVMQ0Ar6e3eSXzrpBP3HttOKDSBt3/q1z2D/NYTJC4kB/CXdC48pxDvlzPLN1Dji3Ij92HTBcD+sjP3fwBu9NYLWHPVuJr/FtZnh/cEflOMcDTmVArl+giEX75jCJJcacpEDbRw98f43EbKq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjP45noiapvUh6Yw0BtiytlUpdKXE1rgPNfYFEOTKJg=;
 b=QOLnpU687pVIblRtk9VvHgxuZrwY9kKHV0zb1IiCAdI5thtu+0vgNXmqE9koLLc4dVQ7XDpJS37bVwji3h6OFmGMOMVv5TJY+B52u1ZN3aZObldAEwjNPSbNe2ddygf0jroIuDM14/tdY3iGhLwhZLAv/F3SK0IjulS/5YgULHmT7pSKOusCD1sgGO7cFHv7MMqrcV7seYP83/80zCfQYRo1KCuvK1qugMpA9Ix/a93OXB3QaIvAUEe625ryfjB1NCmq5LEpO+6RPdT8Ta07UwOAvxQlTvO+vVa+/qvrRAFCsiXn5B2y1V09cA4O/rBJrIxYETVsyi+Ja2nheTuPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:50:48 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:50:48 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH v2] crypto/qat: add Gen 6 support
Thread-Topic: [PATCH v2] crypto/qat: add Gen 6 support
Thread-Index: AQHdYIhyqktGIav8cUO2k7sEgJ2SZLcGcsrk
Date: Tue, 20 Oct 2026 13:50:48 +0000
Message-ID: <LV2PR11MB60451368E05BA6CBA9E212D781672@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20261016131152.2298192-1-radu.nicolau@intel.com>
 <20261020114412.2353140-2-radu.nicolau@intel.com>
In-Reply-To: <20261020114412.2353140-2-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|SA1PR11MB5801:EE_
x-ms-office365-filtering-correlation-id: c641bc32-0a40-434b-5cf3-08df2eb125a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|42112799006|376014|10070799003|261009221227099003|260925022911599003|261009223027099003|260925021911599003|260925021311599003|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|8096899003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: hEi8Y27biNiV/5RumUl3XwBWQjpv9/R9wM9clmT6Y/0ST9S7zjE9v01lbKoeTyj/PS0UrkHMx++qIKyMsmScOEVC6UxQziblsJG9yvQcTTp5A2gGkvD2EDPJUNK6e2h1kev//O361X3TtWOW8AGdv/h4wLWd5ZRdtyhS1n8OAfHX+vDnTjfYBdINKSYHIAo2gq80ZbZAR6hV5zmHnEB3LsIUSQ/GLfA0SP3dVD2uLANjcZlx+r/gZZulnTXtsxTgEicN23u0Ori2eVZcwad1RAxUFOpMuGpnezEnZdD7q1RKUwl18bnhm4xkeLrwI0Tje1aUec/z4JS7JeDjjTJCnkdreOJiMyRMlh1Cttj+RbUpSQxZa8uC6d0ZXBLOwmke2qwsWJ9XI19kLwmOx4JQ3izqL7bDlkuNa/D0zO4HMNHQtcTXSagwF1m4kfMiMLqzIat+Ez5P07W1IrN5Gb05FZMeKFcEFQ+xgB0Osy3IDCvB9TXMpWEgg1Av6AYeRETySDZAioXYq46G6ZrOv1BLTwqRiF99Tc4z0a9Kzp7tGBth4Xe+w96yOUJtxjdaQ+JoEUUF8S9Yr8s66QUe5LO+eF+JiufgOGn60jp60wvNFmBbmfja6y/zcS2Zcka8wHMviHmTZM3LYtQdbEa17RMZWXCuIiJ9runCSkf9yM2nOzxflqBH6jjah16ItWfDkDX5VCDztmY3z5XH9cxdPJeVcAeVSk4RPB/reawi3Ezk+aI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(42112799006)(376014)(10070799003)(261009221227099003)(260925022911599003)(261009223027099003)(260925021911599003)(260925021311599003)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(8096899003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yEA7FYEnmaQfWoIKGDyF7/QUDcIhVXAkOBp9r9/srA0WLUVi8FmEF+nvYi?=
 =?iso-8859-1?Q?r4WZ1h0O/oLokO919KcYkQtQfL3ehaDfgfMrQs5oix+GrbZGDLzO7HlFeK?=
 =?iso-8859-1?Q?IoqLGjmK27PA5FxIfJslXmTLu+MyP27AkQsJ93sZSsZMD37V9yYhvCyrir?=
 =?iso-8859-1?Q?nYtJb+Wp0caEu6AYjEIqdL+ltnRUWgBQap5ZSLUM09mYiLhnx4Ykz+9rf3?=
 =?iso-8859-1?Q?FH9mWXJbWSxle5YT2K1g39a34YZ0OpYIyvd4Pi9XtH7NX+IR0h9xyaFUK/?=
 =?iso-8859-1?Q?dl1AWQ0Swxn3VHs4fcJOsak6Y9U3Ks9Ef14W7aOqFQPghNbO1WPsgaUy/g?=
 =?iso-8859-1?Q?myFlz0hBt5635aED4j6SAko55+WKKgESEDP4vP1nqCWv+2KdNbjam/rA/o?=
 =?iso-8859-1?Q?34mpd7VjfmaNi/k2Z+t60GV8ivYu2hQO/heJYFKCxgAjg32Y+g4xbePnH8?=
 =?iso-8859-1?Q?nNAyMDSPmNjPC2qImHWEii259kujhoB3W/cReKml07WXfBSto77xPcZT4i?=
 =?iso-8859-1?Q?hj8arQHiwbBhRnUddpLtF+XnHnFPMV2O1I11kaS/KjjjmZec5KWrXv3AlB?=
 =?iso-8859-1?Q?Z1VDgAK774x32h2NYW6EqriYE2JQzwPd7Chq/ZNeTzeikx91Zmz0ckPYEd?=
 =?iso-8859-1?Q?3G2HDJqvpw3xlw2wq3R6OJDDY2Gli9y+VOyvbZvEjoRFTule2mq0VwrlPV?=
 =?iso-8859-1?Q?vuLqj5SNTvM8vIHi73abJNVy6XtjTuv/32PVRT3l0XZvZzt7IfW39ZFl+y?=
 =?iso-8859-1?Q?++7z2Ym0fup1gpKWciolTjRQ4Oaa/Ita7w7dlVjbgjSE5U3OmYDkk25U1C?=
 =?iso-8859-1?Q?8I8zYIFtzkXeVCrEiL0l/PibvgCdJswCGQMoa+Ka9yNrrEtJ4pe0zsCXbO?=
 =?iso-8859-1?Q?jzMtcXZPIb/LxvQgrbnkPRBXUng+kA1h4rg76OF2dZF7XIUhab0eZ8gjSX?=
 =?iso-8859-1?Q?ZeD1nNxA6cmx3lQvRowY/GwCC0TsdnSfvKoxa7XsRV0GkoHxOjw561EBxR?=
 =?iso-8859-1?Q?MBYO3HoaepFF+7lQv8sLqQnK4IgGwPMIjo3Fl+GepNKt6RhATLp9I5CE9F?=
 =?iso-8859-1?Q?QBM/2PIZ9pHVllFem2BbvuqnDPhLIMTNThPMCOuc4pOUOtqGdaKXpqhrLx?=
 =?iso-8859-1?Q?JqclZ58hYnkX8TMaCQBOFCPMVOAQ0rq5ng9AoIYvTH6kgIeP1JAlw3nAWk?=
 =?iso-8859-1?Q?BbfAUvlFKYenWvoc/7TzncosHtZrnp2qUebntLo6TIYG7gGAtbGq7o0qm6?=
 =?iso-8859-1?Q?UHbW0Z5qyyy7qhUZDwQG8C4NsARb35yACioSor6UyFtETn2+7PtE43LZVu?=
 =?iso-8859-1?Q?j2ocbu5zmZh4Qxl+3Ahlr5aaE6pV3C81YKNETke2YYDYW7inWKvSz1WznS?=
 =?iso-8859-1?Q?CQvwX6vQniOmoQnGsOwiPHYvZlCX1RTXcnHWhiI+wNRjwew9n2t3QmNi8a?=
 =?iso-8859-1?Q?lmrGXBqmP/zTw9ofx5DxpQUlDG5jUzaEgUKjLaMLnJRN3ixCJMH75h3an1?=
 =?iso-8859-1?Q?D14oep3TJtxMiQAWJLUGL3DV/GeLKfy+cjjWEDEMtGeidkpE/4VcjfbgIN?=
 =?iso-8859-1?Q?NX7aXFI4VOjOzC9cJyAdDnYNUzQLpCK9ECn9w7lUuTA2wVekR9VM8+K2o/?=
 =?iso-8859-1?Q?8aTH3T3x/WbwZsGaziC3ar+bOgklLRy3MB/v8hAq3bpFAhjJECC/UMSJxm?=
 =?iso-8859-1?Q?8OFfcXaevKtD9z704l552Gyio9MKFMexsQ4a57xedl/NYzo38V0l707uLZ?=
 =?iso-8859-1?Q?QES3VBZVYxa616+VvlMcz0W4oa8OtLOHP7ymlyBIkqTStDLTsnbFTwBu+I?=
 =?iso-8859-1?Q?VbTLsmAnotWGAvTfgAxMVpQXJ12jqDPEeVNZqFTpVGVYL8bnZCxy?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB60451368E05BA6CBA9E212D781672LV2PR11MB6045namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rowHlxZEfZt7XUXRXBJMY529C5qJvL5yGdyyB5sQNM+lat43gQFtFLrhJJXaurBgW7+jKCohzn0iUN12sT386bg0uWnqiUGpszYX9J3KVLdz8TU3cg+KWtFG0u5pgqBm8XhrWVO7xuHBNZrLFVpyHU0csb9DuLQ52yIkf36aqxM9wFha/VTGfUcusUstaTUikVWp+/imMVN7wH9Spo5cmmZc68MzCjIeDJhJLgCV17CeYZduL//0gQ1IJkxAkjkmlCv+Z7yRHHB7ILnCzEA+7aC3V3wVGqkjAzj51iGyJRzzTgr4D8+uagvU32ksJDKwaO5aTabjU4/ApXSe34xr7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c641bc32-0a40-434b-5cf3-08df2eb125a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 13:50:48.5050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuQsKgJ/CnI93s1V1crk1dcN/m/7LkEoS/XLv8hKg29THbU9p+puhlkH2NyF2xCvqvWgpmmLeq7Kzz1BgX5pLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_LV2PR11MB60451368E05BA6CBA9E212D781672LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>


________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: Tuesday, October 20, 2026 12:44
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; Bur=
akov, Anatoly <anatoly.burakov@intel.com>
Subject: [PATCH v2] crypto/qat: add Gen 6 support

Add support for Gen 6 QAT devices

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
v2: added handling of OOP Auth

 doc/guides/cryptodevs/qat.rst                |   5 +
 doc/guides/rel_notes/release_26_11.rst       |   4 +
 drivers/common/qat/dev/qat_dev_gen6.c        |  63 ++++
 drivers/common/qat/meson.build               |   2 +
 drivers/common/qat/qat_adf/icp_qat_fw_la.h   |   7 +-
 drivers/common/qat/qat_common.h              |   1 +
 drivers/common/qat/qat_device.c              |   5 +
 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c | 374 +++++++++++++++++++
 drivers/crypto/qat/qat_sym_session.c         |  53 ++-
 drivers/crypto/qat/qat_sym_session.h         |   8 +
 10 files changed, 502 insertions(+), 20 deletions(-)
 create mode 100644 drivers/common/qat/dev/qat_dev_gen6.c
 create mode 100644 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c

diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 6c96c5f88d..27713913ae 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -28,6 +28,7 @@ poll mode crypto driver support for the following hardwar=
e accelerator devices:
 * ``Intel QuickAssist Technology 4xxx``
 * ``Intel QuickAssist Technology 300xx``
 * ``Intel QuickAssist Technology 420xx``
+* ``Intel QuickAssist Technology 6xxx``
 * ``Intel QuickAssist Technology apfxx``


@@ -142,6 +143,7 @@ Limitations
   generations in the same process if planning to use for GCM.
 * The mixed algo feature on GEN2 is not supported by all kernel drivers. C=
heck
   the notes under the Available Kernel Drivers table below for specific de=
tails.
+* Chained cipher and hash operations are not supported on GEN6 devices.
 * Out-of-place is not supported for combined Crypto-CRC DOCSIS security
   protocol.
 * ``RTE_CRYPTO_CIPHER_DES_DOCSISBPI`` is not supported for combined Crypto=
-CRC
@@ -182,6 +184,7 @@ poll mode crypto driver support for the following hardw=
are accelerator devices:
 * ``Intel QuickAssist Technology 401xxx``
 * ``Intel QuickAssist Technology 300xx``
 * ``Intel QuickAssist Technology 420xx``
+* ``Intel QuickAssist Technology 6xxx``

 The QAT ASYM PMD has support for:

@@ -483,6 +486,8 @@ to see the full table)
    +-----+-----+-----+-----+----------+---------------+---------------+---=
---------+--------+------+--------+--------+
    | Yes | Yes | Yes | 5   | 420xx    | linux/6.8+    | qat_420xx     | 42=
0xx      | 4946   | 2    | 4947   | 16     |
    +-----+-----+-----+-----+----------+---------------+---------------+---=
---------+--------+------+--------+--------+
+   | Yes | Yes | No  | 6   | 6xxx     | linux/6.16+   | qat_6xxx      | 6x=
xx       | 4948   | 1    | 4949   | 16     |
+   +-----+-----+-----+-----+----------+---------------+---------------+---=
---------+--------+------+--------+--------+

 * Note: Symmetric mixed crypto algorithms feature on Gen 2 works only with=
 IDZ driver version 4.9.0+

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst
index c8cc86295d..fdcf155e07 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

+* **Updated Intel QuickAssist Technology (QAT) crypto driver.**
+
+  * Added support for Gen 6 QAT devices.
+

 Removed Items
 -------------
diff --git a/drivers/common/qat/dev/qat_dev_gen6.c b/drivers/common/qat/dev=
/qat_dev_gen6.c
new file mode 100644
index 0000000000..e8b9201c04
--- /dev/null
+++ b/drivers/common/qat/dev/qat_dev_gen6.c
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#include <dev_driver.h>
+#include <rte_pci.h>
+
+#include "qat_device.h"
+#include "qat_qp.h"
+#include "adf_pf2vf_msg.h"
+#include "qat_dev_gens.h"
+
+#include <stdint.h>
+
+static struct qat_pf2vf_dev qat_pf2vf_gen6 =3D {
+       .pf2vf_offset =3D ADF_4XXXIOV_PF2VM_OFFSET,
+       .vf2pf_offset =3D ADF_4XXXIOV_VM2PF_OFFSET,
+       .pf2vf_type_shift =3D ADF_PFVF_2X_MSGTYPE_SHIFT,
+       .pf2vf_type_mask =3D ADF_PFVF_2X_MSGTYPE_MASK,
+       .pf2vf_data_shift =3D ADF_PFVF_2X_MSGDATA_SHIFT,
+       .pf2vf_data_mask =3D ADF_PFVF_2X_MSGDATA_MASK,
+};
+
+static struct qat_qp_hw_spec_funcs qat_qp_hw_spec_gen6 =3D {
+       .qat_qp_rings_per_service =3D qat_qp_rings_per_service_gen4,
+       .qat_qp_build_ring_base =3D qat_qp_build_ring_base_gen4,
+       .qat_qp_adf_arb_enable =3D qat_qp_adf_arb_enable_gen4,
+       .qat_qp_adf_arb_disable =3D qat_qp_adf_arb_disable_gen4,
+       .qat_qp_adf_configure_queues =3D qat_qp_adf_configure_queues_gen4,
+       .qat_qp_csr_write_tail =3D qat_qp_csr_write_tail_gen4,
+       .qat_qp_csr_write_head =3D qat_qp_csr_write_head_gen4,
+       .qat_qp_csr_setup =3D qat_qp_csr_setup_gen4,
+       .qat_qp_get_hw_data =3D qat_qp_get_hw_data_gen4,
+};
+
+static int
+qat_dev_get_slice_map_gen6(uint32_t *map,
+       const struct rte_pci_device *pci_dev)
+{
+       if (rte_pci_read_config(pci_dev, map,
+                       ADF1_C4XXXIOV_VFLEGFUSES_LEN,
+                       ADF_C4XXXIOV_VFLEGFUSES_OFFSET) < 0) {
+               return -1;
+       }
+       return 0;
+}
+
+static struct qat_dev_hw_spec_funcs qat_dev_hw_spec_gen6 =3D {
+       .qat_dev_reset_ring_pairs =3D qat_reset_ring_pairs_gen4,
+       .qat_dev_get_transport_bar =3D qat_dev_get_transport_bar_gen4,
+       .qat_dev_get_misc_bar =3D qat_dev_get_misc_bar_gen4,
+       .qat_dev_read_config =3D qat_dev_read_config_gen4,
+       .qat_dev_get_extra_size =3D qat_dev_get_extra_size_gen4,
+       .qat_dev_get_slice_map =3D qat_dev_get_slice_map_gen6,
+};
+
+RTE_INIT(qat_dev_gen_6_init)
+{
+       qat_qp_hw_spec[QAT_GEN6] =3D &qat_qp_hw_spec_gen6;
+       qat_dev_hw_spec[QAT_GEN6] =3D &qat_dev_hw_spec_gen6;
+       qat_gen_config[QAT_GEN6].dev_gen =3D QAT_GEN6;
+       qat_gen_config[QAT_GEN6].pf2vf_dev =3D &qat_pf2vf_gen6;
+}
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.buil=
d
index b946354a42..db792864a2 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -106,6 +106,7 @@ sources +=3D files(
         'dev/qat_dev_gen3.c',
         'dev/qat_dev_gen4.c',
         'dev/qat_dev_gen5.c',
+        'dev/qat_dev_gen6.c',
         'dev/qat_dev_gen_lce.c',
 )
 includes +=3D include_directories(
@@ -138,6 +139,7 @@ if qat_crypto
             'dev/qat_crypto_pmd_gen3.c',
             'dev/qat_crypto_pmd_gen4.c',
             'dev/qat_crypto_pmd_gen5.c',
+            'dev/qat_crypto_pmd_gen6.c',
             'dev/qat_crypto_pmd_gen_lce.c',
         ]
         sources +=3D files(join_paths(qat_crypto_relpath, f))
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_la.h b/drivers/common/qa=
t/qat_adf/icp_qat_fw_la.h
index 735dfb5103..366e1f2252 100644
--- a/drivers/common/qat/qat_adf/icp_qat_fw_la.h
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_la.h
@@ -473,7 +473,12 @@ struct icp_qat_fw_la_cipher_20_req_params {
         uint32_t   spc_aad_sz;
         uint64_t   spc_aad_addr;
         uint64_t   spc_auth_res_addr;
-       uint8_t    reserved[3];
+       union {
+               uint8_t    reserved[3];
+               struct {
+                       uint8_t hmac_sz;
+               };
+       };
         uint8_t    spc_auth_res_sz;
 };

diff --git a/drivers/common/qat/qat_common.h b/drivers/common/qat/qat_commo=
n.h
index 51d20267bd..133a81c856 100644
--- a/drivers/common/qat/qat_common.h
+++ b/drivers/common/qat/qat_common.h
@@ -34,6 +34,7 @@ enum qat_device_gen {
         QAT_GEN3,
         QAT_GEN4,
         QAT_GEN5,
+       QAT_GEN6,
         QAT_GEN_LCE,
         QAT_VQAT,
         QAT_N_GENS
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_devic=
e.c
index 07a8b19583..f0ed115b30 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -70,6 +70,9 @@ static const struct rte_pci_id pci_id_qat_map[] =3D {
                 {
                         RTE_PCI_DEVICE(0x8086, 0x4947),
                 },
+               {
+                       RTE_PCI_DEVICE(0x8086, 0x4949),
+               },
                 {
                         RTE_PCI_DEVICE(0x8086, 0x1454),
                 },
@@ -152,6 +155,8 @@ pick_gen(const struct rte_pci_device *pci_dev)
                 return QAT_GEN4;
         case 0x4947:
                 return QAT_GEN5;
+       case 0x4949:
+               return QAT_GEN6;
         case 0x1454:
                 return QAT_GEN_LCE;
         case 0x0da5:
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen6.c
new file mode 100644
index 0000000000..7f810cfcc1
--- /dev/null
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c
@@ -0,0 +1,374 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Intel Corporation
+ */
+
+#include <rte_cryptodev.h>
+#include <cryptodev_pmd.h>
+#include "qat_sym_session.h"
+#include "qat_sym.h"
+#include "qat_asym.h"
+#include "qat_crypto.h"
+#include "qat_crypto_pmd_gens.h"
+
+
+static struct rte_cryptodev_capabilities qat_sym_crypto_legacy_caps_gen6[]=
 =3D {
+       QAT_SYM_PLAIN_AUTH_CAP(SHA1,
+               CAP_SET(block_size, 64),
+               CAP_RNG(digest_size, 1, 20, 1)),
+       QAT_SYM_AUTH_CAP(SHA224,
+               CAP_SET(block_size, 64),
+               CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 28, 1),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+};
+
+static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen6[] =3D {
+       QAT_SYM_AUTH_CAP(SHA256_HMAC,
+               CAP_SET(block_size, 64),
+               CAP_RNG(key_size, 1, 64, 1), CAP_RNG(digest_size, 1, 32, 1)=
,
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_AUTH_CAP(SHA384_HMAC,
+               CAP_SET(block_size, 128),
+               CAP_RNG(key_size, 1, 128, 1), CAP_RNG(digest_size, 1, 48, 1=
),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_AUTH_CAP(SHA512_HMAC,
+               CAP_SET(block_size, 128),
+               CAP_RNG(key_size, 1, 128, 1), CAP_RNG(digest_size, 1, 64, 1=
),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_AUTH_CAP(NULL,
+               CAP_SET(block_size, 1),
+               CAP_RNG_ZERO(key_size), CAP_RNG_ZERO(digest_size),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_CIPHER_CAP(NULL,
+               CAP_SET(block_size, 1),
+               CAP_RNG_ZERO(key_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_AUTH_CAP(SHA256,
+               CAP_SET(block_size, 64),
+               CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 32, 1),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_AUTH_CAP(SHA384,
+               CAP_SET(block_size, 128),
+               CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 48, 1),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_AUTH_CAP(SHA512,
+               CAP_SET(block_size, 128),
+               CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 64, 1),
+               CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),
+       QAT_SYM_CIPHER_CAP(AES_CTR,
+               CAP_SET(block_size, 16),
+               CAP_RNG(key_size, 16, 32, 16), CAP_RNG(iv_size, 16, 16, 0))=
,
+       QAT_SYM_AEAD_CAP(AES_GCM,
+               CAP_SET(block_size, 16),
+               CAP_RNG(key_size, 16, 32, 16), CAP_RNG(digest_size, 8, 16, =
4),
+               CAP_RNG(aad_size, 0, 240, 1), CAP_RNG(iv_size, 12, 12, 12))=
,
+       QAT_SYM_AEAD_CAP(CHACHA20_POLY1305,
+               CAP_SET(block_size, 64),
+               CAP_RNG(key_size, 32, 32, 0),
+               CAP_RNG(digest_size, 16, 16, 0),
+               CAP_RNG(aad_size, 0, 240, 1), CAP_RNG(iv_size, 12, 12, 0)),
+       RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
+};
+
+static int
+qat_sym_crypto_cap_get_gen6(struct qat_cryptodev_private *internals,
+                       const char *capa_memz_name,
+                       const uint16_t __rte_unused slice_map)
+{
+       uint32_t caps_size =3D sizeof(qat_sym_crypto_caps_gen6);
+       uint32_t legacy_caps_size =3D sizeof(qat_sym_crypto_legacy_caps_gen=
6);
+       uint32_t size =3D caps_size;
+       uintptr_t cp_addr;
+
+       if (internals->qat_dev->options.legacy_alg)
+               size =3D size + legacy_caps_size;
+
+       internals->capa_mz =3D rte_memzone_lookup(capa_memz_name);
+       if (internals->capa_mz =3D=3D NULL) {
+               internals->capa_mz =3D rte_memzone_reserve(capa_memz_name,
+                               size, rte_socket_id(), 0);
+               if (internals->capa_mz =3D=3D NULL) {
+                       QAT_LOG(DEBUG,
+                               "Error allocating memzone for capabilities"=
);
+                       return -1;
+               }
+       }
+       cp_addr =3D (uintptr_t)(internals->capa_mz->addr);
+
+       if (internals->qat_dev->options.legacy_alg) {
+               memcpy((void *)cp_addr, qat_sym_crypto_legacy_caps_gen6, le=
gacy_caps_size);
+               cp_addr +=3D legacy_caps_size;
+       }
+
+       memcpy((void *)cp_addr, qat_sym_crypto_caps_gen6, caps_size);
+       internals->qat_dev_capabilities =3D internals->capa_mz->addr;
+
+       return 0;
+}
+
+static int get_block_size(enum icp_qat_hw_auth_algo qat_hash_alg)
+{
+       switch (qat_hash_alg) {
+       case ICP_QAT_HW_AUTH_ALGO_SHA1:
+       case ICP_QAT_HW_AUTH_ALGO_SHA224:
+       case ICP_QAT_HW_AUTH_ALGO_SHA256:
+               return QAT_SHA_CBLOCK;
+       case ICP_QAT_HW_AUTH_ALGO_SHA384:
+       case ICP_QAT_HW_AUTH_ALGO_SHA512:
+               return QAT_SHA512_CBLOCK;
+       default:
+               return -EFAULT;
+       };
+       return -EFAULT;
+}
+
+int
+qat_sym_cd_auth_set_gen6(struct qat_sym_session *cdesc,
+               const uint8_t *authkey,
+               uint32_t authkeylen,
+               uint32_t aad_length __rte_unused,
+               uint32_t digestsize,
+               unsigned int operation)
+{
+       struct icp_qat_hw_auth_setup *hash =3D NULL;
+       struct icp_qat_fw_la_bulk_req *req_tmpl =3D &cdesc->fw_req;
+       struct icp_qat_fw_comn_req_hdr_cd_pars *cd_pars =3D &req_tmpl->cd_p=
ars;
+       void *ptr =3D &req_tmpl->cd_ctrl;
+       struct icp_qat_fw_auth_cd_ctrl_hdr *hash_cd_ctrl =3D ptr;
+       struct icp_qat_fw_la_auth_req_params *auth_param =3D
+               (struct icp_qat_fw_la_auth_req_params *)
+               ((char *)&req_tmpl->serv_specif_rqpars +
+               ICP_QAT_FW_HASH_REQUEST_PARAMETERS_OFFSET);
+       enum icp_qat_hw_auth_mode auth_mode =3D
+                       (cdesc->auth_mode =3D=3D ICP_QAT_HW_AUTH_MODE0) ?
+                       ICP_QAT_HW_AUTH_MODE0 : ICP_QAT_HW_AUTH_MODE2;
+       uint16_t state1_size =3D 0, state2_size =3D 0, cd_extra_size =3D 0;
+       uint16_t hash_offset;
+
+       if (cdesc->qat_cmd =3D=3D ICP_QAT_FW_LA_CMD_AUTH) {
+               ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,
+                                       ICP_QAT_FW_SLICE_AUTH);
+               cdesc->cd_cur_ptr =3D (uint8_t *)&cdesc->cd;
+       } else if (cdesc->qat_cmd !=3D ICP_QAT_FW_LA_CMD_CIPHER_HASH) {
+               QAT_LOG(ERR, "Invalid param, must be a hash command.");
+               return -EFAULT;
+       }
+
+       if (operation =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY)
+               cdesc->auth_op =3D ICP_QAT_HW_AUTH_VERIFY;
+       else
+               cdesc->auth_op =3D ICP_QAT_HW_AUTH_GENERATE;
+
+       /*
+        * Setup the inner hash config
+        */
+       hash_offset =3D cdesc->cd_cur_ptr-((uint8_t *)&cdesc->cd);
+       hash =3D (struct icp_qat_hw_auth_setup *)cdesc->cd_cur_ptr;
+       hash->auth_config.reserved =3D 0;
+       if (cdesc->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_NULL)
+               hash->auth_config.config =3D
+                       ICP_QAT_HW_AUTH_CONFIG_BUILD(auth_mode,
+                               cdesc->qat_hash_alg, 4);
+       else
+               hash->auth_config.config =3D
+                       ICP_QAT_HW_AUTH_CONFIG_BUILD(auth_mode,
+                               cdesc->qat_hash_alg, digestsize);
+
+       if (cdesc->auth_mode =3D=3D ICP_QAT_HW_AUTH_MODE0) {
+               hash->auth_counter.counter =3D 0;
+       } else {
+               int block_size =3D get_block_size(cdesc->qat_hash_alg);
+               if (block_size < 0)
+                       return block_size;
+               hash->auth_counter.counter =3D rte_bswap32(block_size);
+       }
+
+       hash_cd_ctrl->hash_cfg_offset =3D hash_offset >> 3;
+       cdesc->cd_cur_ptr +=3D sizeof(struct icp_qat_hw_auth_setup);
+       switch (cdesc->qat_hash_alg) {
+       case ICP_QAT_HW_AUTH_ALGO_SHA1:
+       case ICP_QAT_HW_AUTH_ALGO_SHA224:
+               break;
+       case ICP_QAT_HW_AUTH_ALGO_SHA256:
+               /* HMAC */
+               if (cdesc->auth_mode !=3D ICP_QAT_HW_AUTH_MODE0) {
+                       struct icp_qat_fw_la_cipher_20_req_params *cipher_p=
aram_20 =3D
+                               (void *)&req_tmpl->serv_specif_rqpars;
+                       rte_memcpy(cdesc->cd_cur_ptr, authkey, authkeylen);
+                       state2_size =3D 0;
+                       state1_size =3D authkeylen;
+                       ICP_QAT_FW_HASH_FLAG_MODE2_SET(
+                               hash_cd_ctrl->hash_flags, QAT_FW_LA_MODE2);
+                       cipher_param_20->spc_aad_addr =3D cdesc->cd_paddr +
+                               (cdesc->cd_cur_ptr - (uint8_t *)&cdesc->cd)=
;
+                       cipher_param_20->hmac_sz =3D ICP_QAT_HW_SHA256_STAT=
E2_SZ * 2;
+               }
+               break;
+       case ICP_QAT_HW_AUTH_ALGO_SHA384:
+               /* HMAC */
+               if (cdesc->auth_mode !=3D ICP_QAT_HW_AUTH_MODE0) {
+                       struct icp_qat_fw_la_cipher_20_req_params *cipher_p=
aram_20 =3D
+                               (void *)&req_tmpl->serv_specif_rqpars;
+                       rte_memcpy(cdesc->cd_cur_ptr, authkey, authkeylen);
+                       state2_size =3D 0;
+                       state1_size =3D authkeylen;
+                       ICP_QAT_FW_HASH_FLAG_MODE2_SET(
+                               hash_cd_ctrl->hash_flags, QAT_FW_LA_MODE2);
+                       cipher_param_20->spc_aad_addr =3D cdesc->cd_paddr +
+                               (cdesc->cd_cur_ptr - (uint8_t *)&cdesc->cd)=
;
+                       cipher_param_20->hmac_sz =3D ICP_QAT_HW_SHA384_STAT=
E2_SZ * 2;
+               }
+               break;
+       case ICP_QAT_HW_AUTH_ALGO_SHA512:
+               /* HMAC */
+               if (cdesc->auth_mode !=3D ICP_QAT_HW_AUTH_MODE0) {
+                       struct icp_qat_fw_la_cipher_20_req_params *cipher_p=
aram_20 =3D
+                               (void *)&req_tmpl->serv_specif_rqpars;
+                       rte_memcpy(cdesc->cd_cur_ptr, authkey, authkeylen);
+                       state2_size =3D 0;
+                       state1_size =3D authkeylen;
+                       ICP_QAT_FW_HASH_FLAG_MODE2_SET(
+                               hash_cd_ctrl->hash_flags, QAT_FW_LA_MODE2);
+                       cipher_param_20->spc_aad_addr =3D cdesc->cd_paddr +
+                               (cdesc->cd_cur_ptr - (uint8_t *)&cdesc->cd)=
;
+                       cipher_param_20->hmac_sz =3D ICP_QAT_HW_SHA512_STAT=
E2_SZ * 2;
+               }
+               break;
+       case ICP_QAT_HW_AUTH_ALGO_NULL:
+               break;
+       default:
+               QAT_LOG(ERR, "Invalid HASH alg %u", cdesc->qat_hash_alg);
+               return -EFAULT;
+       }
+
+       /* Auth CD config setup */
+       hash_cd_ctrl->hash_flags |=3D ICP_QAT_FW_AUTH_HDR_FLAG_NO_NESTED;
+       hash_cd_ctrl->inner_state1_sz =3D state1_size;
+       if (cdesc->qat_hash_alg =3D=3D ICP_QAT_HW_AUTH_ALGO_NULL) {
+               hash_cd_ctrl->inner_res_sz =3D 4;
+               hash_cd_ctrl->final_sz =3D 4;
+               auth_param->auth_res_sz =3D 4;
+       } else {
+               hash_cd_ctrl->inner_res_sz =3D digestsize;
+               hash_cd_ctrl->final_sz =3D digestsize;
+               auth_param->auth_res_sz =3D digestsize;
+       }
+
+       hash_cd_ctrl->inner_state2_sz  =3D state2_size;
+       hash_cd_ctrl->inner_state2_offset =3D hash_cd_ctrl->hash_cfg_offset=
 +
+                       ((sizeof(struct icp_qat_hw_auth_setup) +
+                        RTE_ALIGN_CEIL(hash_cd_ctrl->inner_state1_sz, 8))
+                                       >> 3);
+       cdesc->cd_cur_ptr +=3D state1_size + state2_size + cd_extra_size;
+       cd_pars->u.s.content_desc_addr =3D cdesc->cd_paddr;
+       cd_pars->u.s.content_desc_params_sz =3D 1;
+       return 0;
+}
+
+static int
+qat_sym_build_op_auth_gen6(void *in_op, struct qat_sym_session *ctx,
+       uint8_t *out_msg, void *op_cookie)
+{
+       struct rte_crypto_op *op =3D in_op;
+       if (unlikely(op->sym->m_dst !=3D NULL &&
+               op->sym->m_dst !=3D op->sym->m_src)) {
+               op->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+               return -EINVAL;
+       }
+       return qat_sym_build_op_auth_gen1(in_op, ctx, out_msg, op_cookie);
+}
+
+static int
+qat_sym_crypto_set_session_gen6(void *cdev, void *session)
+{
+       struct qat_sym_session *ctx =3D session;
+       enum rte_proc_type_t proc_type =3D rte_eal_process_type();
+       int ret;
+
+       if (proc_type =3D=3D RTE_PROC_AUTO || proc_type =3D=3D RTE_PROC_INV=
ALID)
+               return -EINVAL;
+
+       ret =3D qat_sym_crypto_set_session_gen4(cdev, session);
+
+       if (ret =3D=3D 0) {
+               if (ctx->build_request[proc_type] =3D=3D
+                       qat_sym_build_op_chain_gen1) {
+                       /* Gen 6 does not support chaining of symmetric cry=
pto ops. */
+                       QAT_LOG(ERR, "Chained ops not supported");
+                       return -ENOTSUP;
+               } else if (ctx->build_request[proc_type] =3D=3D
+                       qat_sym_build_op_auth_gen1) {
+                       /* Gen 6 does not support OOP auth ops. */
+                       ctx->build_request[proc_type] =3D qat_sym_build_op_=
auth_gen6;
+               }
+       }
+
+       return ret;
+}
+
+static uint32_t
+qat_sym_dp_enqueue_auth_jobs_gen6(void *qp_data, uint8_t *drv_ctx,
+               struct rte_crypto_sym_vec *vec, union rte_crypto_sym_ofs of=
s,
+               void *user_data[], int *status)
+{
+       if (vec->dest_sgl !=3D NULL) {
+               qat_sym_dp_fill_vec_status(vec->status, ENOTSUP, vec->num);
+               *status =3D 0;
+               return 0;
+       }
+
+       return qat_sym_dp_enqueue_auth_jobs_gen1(qp_data, drv_ctx, vec, ofs=
,
+                       user_data, status);
+}
+
+static int
+qat_sym_configure_raw_dp_ctx_gen6(void *raw_dp_ctx, void *ctx)
+{
+       struct qat_sym_session *session =3D ctx;
+       struct rte_crypto_raw_dp_ctx *raw_ctx =3D raw_dp_ctx;
+       int ret;
+
+       ret =3D qat_sym_configure_raw_dp_ctx_gen4(raw_dp_ctx, ctx);
+       if (ret !=3D 0)
+               return ret;
+
+       if (session->qat_cmd =3D=3D ICP_QAT_FW_LA_CMD_AUTH)
+               raw_ctx->enqueue_burst =3D qat_sym_dp_enqueue_auth_jobs_gen=
6;
+
+       return 0;
+}
+
+static uint64_t
+qat_sym_crypto_feature_flags_get_gen6(struct qat_pci_device *qat_dev)
+{
+       /* Gen 6 does not support chaining of symmetric crypto ops. */
+       return qat_sym_crypto_feature_flags_get_gen1(qat_dev) &
+                               ~RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING;
+}
+
+RTE_INIT(qat_sym_crypto_gen6_init)
+{
+       qat_sym_gen_dev_ops[QAT_GEN6].cryptodev_ops =3D &qat_sym_crypto_ops=
_gen1;
+       qat_sym_gen_dev_ops[QAT_GEN6].get_capabilities =3D
+                       qat_sym_crypto_cap_get_gen6;
+       qat_sym_gen_dev_ops[QAT_GEN6].set_session =3D
+                       qat_sym_crypto_set_session_gen6;
+       qat_sym_gen_dev_ops[QAT_GEN6].set_raw_dp_ctx =3D
+                       qat_sym_configure_raw_dp_ctx_gen6;
+       qat_sym_gen_dev_ops[QAT_GEN6].get_feature_flags =3D
+                       qat_sym_crypto_feature_flags_get_gen6;
+       qat_sym_gen_dev_ops[QAT_GEN6].create_security_ctx =3D
+                       qat_sym_create_security_gen1;
+}
+
+#ifdef BUILD_QAT_ASYM
+RTE_INIT(qat_asym_crypto_gen6_init)
+{
+       qat_asym_gen_dev_ops[QAT_GEN6].cryptodev_ops =3D
+                       &qat_asym_crypto_ops_gen1;
+       qat_asym_gen_dev_ops[QAT_GEN6].get_capabilities =3D
+                       qat_asym_crypto_cap_get_gen1;
+       qat_asym_gen_dev_ops[QAT_GEN6].get_feature_flags =3D
+                       qat_asym_crypto_feature_flags_get_gen1;
+       qat_asym_gen_dev_ops[QAT_GEN6].set_session =3D
+                       qat_asym_crypto_set_session_gen1;
+}
+#endif
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c
index d89c20cad6..e6d158f777 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -378,6 +378,15 @@ qat_get_cipher_xform(struct rte_crypto_sym_xform *xfor=
m)
         return NULL;
 }

+static inline uint8_t qat_check_ucs(enum qat_device_gen qat_dev_gen)
+{
+       return (qat_dev_gen =3D=3D QAT_GEN4 ||
+                       qat_dev_gen =3D=3D QAT_GEN5 ||
+                       qat_dev_gen =3D=3D QAT_GEN6 ||
+                       qat_dev_gen =3D=3D QAT_VQAT);
+}
+
+
 int
 qat_sym_session_configure_cipher(struct rte_cryptodev *dev,
                 struct rte_crypto_sym_xform *xform,
@@ -416,9 +425,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *=
dev,
                         goto error_out;
                 }
                 session->qat_mode =3D ICP_QAT_HW_CIPHER_CTR_MODE;
-               if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_G=
EN5 ||
-                               qat_dev_gen =3D=3D QAT_VQAT)
-                       session->is_ucs =3D 1;
+               session->is_ucs =3D qat_check_ucs(qat_dev_gen);
                 break;
         case RTE_CRYPTO_CIPHER_SNOW3G_UEA2:
                 if (qat_sym_validate_snow3g_key(cipher_xform->key.length,
@@ -968,8 +975,7 @@ qat_sym_session_configure_auth(struct rte_cryptodev *de=
v,
                         session->auth_iv.length =3D AES_GCM_J0_LEN;
                 else
                         session->is_iv12B =3D 1;
-               if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_G=
EN5 ||
-                               qat_dev_gen =3D=3D QAT_VQAT) {
+               if (qat_check_ucs(qat_dev_gen)) {
                         session->is_cnt_zero =3D 1;
                         session->is_ucs =3D 1;
                 }
@@ -1133,10 +1139,7 @@ qat_sym_session_configure_aead(struct rte_cryptodev =
*dev,
                 }
                 session->qat_mode =3D ICP_QAT_HW_CIPHER_CTR_MODE;
                 session->qat_hash_alg =3D ICP_QAT_HW_AUTH_ALGO_GALOIS_128;
-
-               if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_G=
EN5 ||
-                               qat_dev_gen =3D=3D QAT_VQAT)
-                       session->is_ucs =3D 1;
+               session->is_ucs =3D qat_check_ucs(qat_dev_gen);
                 if (session->cipher_iv.length =3D=3D 0) {
                         session->cipher_iv.length =3D AES_GCM_J0_LEN;
                         break;
@@ -1155,16 +1158,12 @@ qat_sym_session_configure_aead(struct rte_cryptodev=
 *dev,
                 }
                 session->qat_mode =3D ICP_QAT_HW_CIPHER_CTR_MODE;
                 session->qat_hash_alg =3D ICP_QAT_HW_AUTH_ALGO_AES_CBC_MAC=
;
-               if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_G=
EN5 ||
-                               qat_dev_gen =3D=3D QAT_VQAT)
-                       session->is_ucs =3D 1;
+               session->is_ucs =3D qat_check_ucs(qat_dev_gen);
                 break;
         case RTE_CRYPTO_AEAD_CHACHA20_POLY1305:
                 if (aead_xform->key.length !=3D ICP_QAT_HW_CHACHAPOLY_KEY_=
SZ)
                         return -EINVAL;
-               if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_G=
EN5 ||
-                               qat_dev_gen =3D=3D QAT_VQAT)
-                       session->is_ucs =3D 1;
+               session->is_ucs =3D qat_check_ucs(qat_dev_gen);
                 session->qat_cipher_alg =3D
                                 ICP_QAT_HW_CIPHER_ALGO_CHACHA20_POLY1305;
                 qat_sym_session_handle_single_pass(session,
@@ -2006,7 +2005,7 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cde=
sc,
         return 0;
 }

-static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
+static int qat_sym_cd_auth_set_gen1(struct qat_sym_session *cdesc,
                 const uint8_t *authkey,
                 uint32_t authkeylen,
                 uint32_t aad_length,
@@ -2037,7 +2036,7 @@ static int qat_sym_cd_auth_set(struct qat_sym_session=
 *cdesc,
                 ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,
                                         ICP_QAT_FW_SLICE_AUTH);
                 ICP_QAT_FW_COMN_NEXT_ID_SET(hash_cd_ctrl,
-                                       ICP_QAT_FW_SLICE_DRAM_WR);
+                               ICP_QAT_FW_SLICE_DRAM_WR);
                 cdesc->cd_cur_ptr =3D (uint8_t *)&cdesc->cd;
         } else if (cdesc->qat_cmd =3D=3D ICP_QAT_FW_LA_CMD_HASH_CIPHER) {
                 ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,
@@ -2135,8 +2134,7 @@ static int qat_sym_cd_auth_set(struct qat_sym_session=
 *cdesc,
                         qat_hash_get_block_size(cdesc->qat_hash_alg);
                 auth_param->hash_state_sz =3D (hash_cd_ctrl->outer_prefix_=
sz +
                         auth_param->u2.inner_prefix_sz) >> 3;
-               if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_G=
EN5 ||
-                               qat_dev_gen =3D=3D QAT_VQAT) {
+               if (qat_check_ucs(qat_dev_gen)) {
                         ICP_QAT_FW_HASH_FLAG_MODE2_SET(
                                 hash_cd_ctrl->hash_flags,
                                 QAT_FW_LA_MODE2);
@@ -2459,6 +2457,22 @@ static int qat_sym_cd_auth_set(struct qat_sym_sessio=
n *cdesc,
         return 0;
 }

+static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
+               const uint8_t *authkey,
+               uint32_t authkeylen,
+               uint32_t aad_length,
+               uint32_t digestsize,
+               unsigned int operation,
+               enum qat_device_gen qat_dev_gen)
+{
+       if (qat_dev_gen =3D=3D QAT_GEN6)
+               return qat_sym_cd_auth_set_gen6(cdesc, authkey, authkeylen,
+                               aad_length, digestsize, operation);
+
+       return qat_sym_cd_auth_set_gen1(cdesc, authkey, authkeylen,
+                       aad_length, digestsize, operation, qat_dev_gen);
+}
+
 int qat_sym_validate_aes_key(int key_len, enum icp_qat_hw_cipher_algo *alg=
)
 {
         switch (key_len) {
@@ -2653,6 +2667,7 @@ qat_sym_cd_crc_set(struct qat_sym_session *cdesc,
                 break;
         case QAT_GEN4:
         case QAT_GEN5:
+       case QAT_GEN6:
                 crc_cfg.mode =3D ICP_QAT_HW_CIPHER_ECB_MODE;
                 crc_cfg.algo =3D ICP_QAT_HW_CIPHER_ALGO_NULL;
                 crc_cfg.hash_cmp_val =3D 0;
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_=
sym_session.h
index b18673a1f7..e4fb5cacc6 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -204,6 +204,14 @@ qat_sym_sesssion_init_common_hdr(struct qat_sym_sessio=
n *session,
                                         struct icp_qat_fw_comn_req_hdr *he=
ader,
                                         enum qat_sym_proto_flag proto_flag=
s);

+int
+qat_sym_cd_auth_set_gen6(struct qat_sym_session *cdesc,
+               const uint8_t *authkey,
+               uint32_t authkeylen,
+               uint32_t aad_length,
+               uint32_t digestsize,
+               unsigned int operation);
+
 int
 qat_sym_validate_aes_key(int key_len, enum icp_qat_hw_cipher_algo *alg);
 int
--
2.52.0


--_000_LV2PR11MB60451368E05BA6CBA9E212D781672LV2PR11MB6045namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;<br>
<b>Sent:</b> Tuesday, October 20, 2026 12:44<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Ji, Kai &lt;kai.ji=
@intel.com&gt;; Burakov, Anatoly &lt;anatoly.burakov@intel.com&gt;<br>
<b>Subject:</b> [PATCH v2] crypto/qat: add Gen 6 support </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Add support for Gen 6 QAT devices<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
v2: added handling of OOP Auth<br>
<br>
&nbsp;doc/guides/cryptodevs/qat.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +<br>
&nbsp;doc/guides/rel_notes/release_26_11.rst&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp; 4 +<br>
&nbsp;drivers/common/qat/dev/qat_dev_gen6.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 63 ++++<br>
&nbsp;drivers/common/qat/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;drivers/common/qat/qat_adf/icp_qat_fw_la.h&nbsp;&nbsp; |&nbsp;&nbsp; =
7 +-<br>
&nbsp;drivers/common/qat/qat_common.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/common/qat/qat_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 5 +<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c | 374 ++++++++++++++++++=
+<br>
&nbsp;drivers/crypto/qat/qat_sym_session.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 53 ++-<br>
&nbsp;drivers/crypto/qat/qat_sym_session.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp;&nbsp; 8 +<br>
&nbsp;10 files changed, 502 insertions(+), 20 deletions(-)<br>
&nbsp;create mode 100644 drivers/common/qat/dev/qat_dev_gen6.c<br>
&nbsp;create mode 100644 drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c<br>
<br>
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst<=
br>
index 6c96c5f88d..27713913ae 100644<br>
--- a/doc/guides/cryptodevs/qat.rst<br>
+++ b/doc/guides/cryptodevs/qat.rst<br>
@@ -28,6 +28,7 @@ poll mode crypto driver support for the following hardwar=
e accelerator devices:<br>
&nbsp;* ``Intel QuickAssist Technology 4xxx``<br>
&nbsp;* ``Intel QuickAssist Technology 300xx``<br>
&nbsp;* ``Intel QuickAssist Technology 420xx``<br>
+* ``Intel QuickAssist Technology 6xxx``<br>
&nbsp;* ``Intel QuickAssist Technology apfxx``<br>
&nbsp;<br>
&nbsp;<br>
@@ -142,6 +143,7 @@ Limitations<br>
&nbsp;&nbsp; generations in the same process if planning to use for GCM.<br=
>
&nbsp;* The mixed algo feature on GEN2 is not supported by all kernel drive=
rs. Check<br>
&nbsp;&nbsp; the notes under the Available Kernel Drivers table below for s=
pecific details.<br>
+* Chained cipher and hash operations are not supported on GEN6 devices.<br=
>
&nbsp;* Out-of-place is not supported for combined Crypto-CRC DOCSIS securi=
ty<br>
&nbsp;&nbsp; protocol.<br>
&nbsp;* ``RTE_CRYPTO_CIPHER_DES_DOCSISBPI`` is not supported for combined C=
rypto-CRC<br>
@@ -182,6 +184,7 @@ poll mode crypto driver support for the following hardw=
are accelerator devices:<br>
&nbsp;* ``Intel QuickAssist Technology 401xxx``<br>
&nbsp;* ``Intel QuickAssist Technology 300xx``<br>
&nbsp;* ``Intel QuickAssist Technology 420xx``<br>
+* ``Intel QuickAssist Technology 6xxx``<br>
&nbsp;<br>
&nbsp;The QAT ASYM PMD has support for:<br>
&nbsp;<br>
@@ -483,6 +486,8 @@ to see the full table)<br>
&nbsp;&nbsp;&nbsp; +-----+-----+-----+-----+----------+---------------+----=
-----------+------------+--------+------+--------+--------+<br>
&nbsp;&nbsp;&nbsp; | Yes | Yes | Yes | 5&nbsp;&nbsp; | 420xx&nbsp;&nbsp;&nb=
sp; | linux/6.8+&nbsp;&nbsp;&nbsp; | qat_420xx&nbsp;&nbsp;&nbsp;&nbsp; | 42=
0xx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4946&nbsp;&nbsp; | 2&nbsp;&nbsp;&nbsp; =
| 4947&nbsp;&nbsp; | 16&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&nbsp;&nbsp;&nbsp; +-----+-----+-----+-----+----------+---------------+----=
-----------+------------+--------+------+--------+--------+<br>
+&nbsp;&nbsp; | Yes | Yes | No&nbsp; | 6&nbsp;&nbsp; | 6xxx&nbsp;&nbsp;&nbs=
p;&nbsp; | linux/6.16+&nbsp;&nbsp; | qat_6xxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 | 6xxx&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 4948&nbsp;&nbsp; | 1&nbsp;&nb=
sp;&nbsp; | 4949&nbsp;&nbsp; | 16&nbsp;&nbsp;&nbsp;&nbsp; |<br>
+&nbsp;&nbsp; +-----+-----+-----+-----+----------+---------------+---------=
------+------------+--------+------+--------+--------+<br>
&nbsp;<br>
&nbsp;* Note: Symmetric mixed crypto algorithms feature on Gen 2 works only=
 with IDZ driver version 4.9.0+<br>
&nbsp;<br>
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst<br>
index c8cc86295d..fdcf155e07 100644<br>
--- a/doc/guides/rel_notes/release_26_11.rst<br>
+++ b/doc/guides/rel_notes/release_26_11.rst<br>
@@ -55,6 +55,10 @@ New Features<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Also, make sure to start the actual text at =
the margin.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&nbsp;<br>
+* **Updated Intel QuickAssist Technology (QAT) crypto driver.**<br>
+<br>
+&nbsp; * Added support for Gen 6 QAT devices.<br>
+<br>
&nbsp;<br>
&nbsp;Removed Items<br>
&nbsp;-------------<br>
diff --git a/drivers/common/qat/dev/qat_dev_gen6.c b/drivers/common/qat/dev=
/qat_dev_gen6.c<br>
new file mode 100644<br>
index 0000000000..e8b9201c04<br>
--- /dev/null<br>
+++ b/drivers/common/qat/dev/qat_dev_gen6.c<br>
@@ -0,0 +1,63 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2024 Intel Corporation<br>
+ */<br>
+<br>
+#include &lt;dev_driver.h&gt;<br>
+#include &lt;rte_pci.h&gt;<br>
+<br>
+#include &quot;qat_device.h&quot;<br>
+#include &quot;qat_qp.h&quot;<br>
+#include &quot;adf_pf2vf_msg.h&quot;<br>
+#include &quot;qat_dev_gens.h&quot;<br>
+<br>
+#include &lt;stdint.h&gt;<br>
+<br>
+static struct qat_pf2vf_dev qat_pf2vf_gen6 =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pf2vf_offset =3D ADF_4XXXIOV_PF2VM_O=
FFSET,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vf2pf_offset =3D ADF_4XXXIOV_VM2PF_O=
FFSET,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pf2vf_type_shift =3D ADF_PFVF_2X_MSG=
TYPE_SHIFT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pf2vf_type_mask =3D ADF_PFVF_2X_MSGT=
YPE_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pf2vf_data_shift =3D ADF_PFVF_2X_MSG=
DATA_SHIFT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pf2vf_data_mask =3D ADF_PFVF_2X_MSGD=
ATA_MASK,<br>
+};<br>
+<br>
+static struct qat_qp_hw_spec_funcs qat_qp_hw_spec_gen6 =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_rings_per_service =3D qat_qp_=
rings_per_service_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_build_ring_base =3D qat_qp_bu=
ild_ring_base_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_adf_arb_enable =3D qat_qp_adf=
_arb_enable_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_adf_arb_disable =3D qat_qp_ad=
f_arb_disable_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_adf_configure_queues =3D qat_=
qp_adf_configure_queues_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_csr_write_tail =3D qat_qp_csr=
_write_tail_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_csr_write_head =3D qat_qp_csr=
_write_head_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_csr_setup =3D qat_qp_csr_setu=
p_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_qp_get_hw_data =3D qat_qp_get_hw=
_data_gen4,<br>
+};<br>
+<br>
+static int<br>
+qat_dev_get_slice_map_gen6(uint32_t *map,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_pci_device *pci_dev)=
<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rte_pci_read_config(pci_dev, map,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADF1_C4XXXIOV_VF=
LEGFUSES_LEN,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADF_C4XXXIOV_VFL=
EGFUSES_OFFSET) &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static struct qat_dev_hw_spec_funcs qat_dev_hw_spec_gen6 =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_dev_reset_ring_pairs =3D qat_res=
et_ring_pairs_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_dev_get_transport_bar =3D qat_de=
v_get_transport_bar_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_dev_get_misc_bar =3D qat_dev_get=
_misc_bar_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_dev_read_config =3D qat_dev_read=
_config_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_dev_get_extra_size =3D qat_dev_g=
et_extra_size_gen4,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .qat_dev_get_slice_map =3D qat_dev_ge=
t_slice_map_gen6,<br>
+};<br>
+<br>
+RTE_INIT(qat_dev_gen_6_init)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_qp_hw_spec[QAT_GEN6] =3D &amp;qat=
_qp_hw_spec_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_hw_spec[QAT_GEN6] =3D &amp;qa=
t_dev_hw_spec_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_gen_config[QAT_GEN6].dev_gen =3D =
QAT_GEN6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_gen_config[QAT_GEN6].pf2vf_dev =
=3D &amp;qat_pf2vf_gen6;<br>
+}<br>
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.buil=
d<br>
index b946354a42..db792864a2 100644<br>
--- a/drivers/common/qat/meson.build<br>
+++ b/drivers/common/qat/meson.build<br>
@@ -106,6 +106,7 @@ sources +=3D files(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qat_dev_gen3.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qat_dev_gen4.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qat_dev_gen5.c',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qat_dev_gen6.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qat_dev_gen_lce.c',<b=
r>
&nbsp;)<br>
&nbsp;includes +=3D include_directories(<br>
@@ -138,6 +139,7 @@ if qat_crypto<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen3.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen4.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen5.c',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qa=
t_crypto_pmd_gen6.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen_lce.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sources +=3D files(join_pa=
ths(qat_crypto_relpath, f))<br>
diff --git a/drivers/common/qat/qat_adf/icp_qat_fw_la.h b/drivers/common/qa=
t/qat_adf/icp_qat_fw_la.h<br>
index 735dfb5103..366e1f2252 100644<br>
--- a/drivers/common/qat/qat_adf/icp_qat_fw_la.h<br>
+++ b/drivers/common/qat/qat_adf/icp_qat_fw_la.h<br>
@@ -473,7 +473,12 @@ struct icp_qat_fw_la_cipher_20_req_params {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp; spc_a=
ad_sz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp; spc_a=
ad_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp; spc_a=
uth_res_addr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp; reserved[3]=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp; reserved[3];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t hmac_sz;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp; =
spc_auth_res_sz;<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/common/qat/qat_common.h b/drivers/common/qat/qat_commo=
n.h<br>
index 51d20267bd..133a81c856 100644<br>
--- a/drivers/common/qat/qat_common.h<br>
+++ b/drivers/common/qat/qat_common.h<br>
@@ -34,6 +34,7 @@ enum qat_device_gen {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_GEN3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_GEN4,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_GEN5,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_GEN6,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_GEN_LCE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_VQAT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_N_GENS<br>
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_devic=
e.c<br>
index 07a8b19583..f0ed115b30 100644<br>
--- a/drivers/common/qat/qat_device.c<br>
+++ b/drivers/common/qat/qat_device.c<br>
@@ -70,6 +70,9 @@ static const struct rte_pci_id pci_id_qat_map[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_P=
CI_DEVICE(0x8086, 0x4947),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_PCI_DEVICE(0=
x8086, 0x4949),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_P=
CI_DEVICE(0x8086, 0x1454),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; },<br>
@@ -152,6 +155,8 @@ pick_gen(const struct rte_pci_device *pci_dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return QAT_GEN4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x4947:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return QAT_GEN5;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x4949:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return QAT_GEN6;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x1454:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return QAT_GEN_LCE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0x0da5:<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen6.c<br>
new file mode 100644<br>
index 0000000000..7f810cfcc1<br>
--- /dev/null<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen6.c<br>
@@ -0,0 +1,374 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2024 Intel Corporation<br>
+ */<br>
+<br>
+#include &lt;rte_cryptodev.h&gt;<br>
+#include &lt;cryptodev_pmd.h&gt;<br>
+#include &quot;qat_sym_session.h&quot;<br>
+#include &quot;qat_sym.h&quot;<br>
+#include &quot;qat_asym.h&quot;<br>
+#include &quot;qat_crypto.h&quot;<br>
+#include &quot;qat_crypto_pmd_gens.h&quot;<br>
+<br>
+<br>
+static struct rte_cryptodev_capabilities qat_sym_crypto_legacy_caps_gen6[]=
 =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_PLAIN_AUTH_CAP(SHA1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 64),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(digest_size, 1, 20, 1)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA224,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 64),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 28, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+};<br>
+<br>
+static struct rte_cryptodev_capabilities qat_sym_crypto_caps_gen6[] =3D {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA256_HMAC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 64),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 1, 64, 1), CAP_RNG(digest_size, 1, 32, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA384_HMAC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 128),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 1, 128, 1), CAP_RNG(digest_size, 1, 48, 1),<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA512_HMAC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 128),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 1, 128, 1), CAP_RNG(digest_size, 1, 64, 1),<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(key_size), CAP_RNG_ZERO(digest_size),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_CIPHER_CAP(NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(key_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 64),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 32, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA384,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 128),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 48, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AUTH_CAP(SHA512,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 128),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(key_size), CAP_RNG(digest_size, 1, 64, 1),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG_ZERO(aad_size), CAP_RNG_ZERO(iv_size)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_CIPHER_CAP(AES_CTR,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 16),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 16, 32, 16), CAP_RNG(iv_size, 16, 16, 0)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AEAD_CAP(AES_GCM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 16),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 16, 32, 16), CAP_RNG(digest_size, 8, 16, 4),<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(aad_size, 0, 240, 1), CAP_RNG(iv_size, 12, 12, 12)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_SYM_AEAD_CAP(CHACHA20_POLY1305,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_SET(block_size, 64),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(key_size, 32, 32, 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(digest_size, 16, 16, 0),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; CAP_RNG(aad_size, 0, 240, 1), CAP_RNG(iv_size, 12, 12, 0)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_END_OF_CAPABILITIES_LIS=
T()<br>
+};<br>
+<br>
+static int<br>
+qat_sym_crypto_cap_get_gen6(struct qat_cryptodev_private *internals,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *capa=
_memz_name,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint16_t _=
_rte_unused slice_map)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t caps_size =3D sizeof(qat_sym=
_crypto_caps_gen6);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t legacy_caps_size =3D sizeof(=
qat_sym_crypto_legacy_caps_gen6);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size =3D caps_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t cp_addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (internals-&gt;qat_dev-&gt;options=
.legacy_alg)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D size + legacy_caps_size;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; internals-&gt;capa_mz =3D rte_memzone=
_lookup(capa_memz_name);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (internals-&gt;capa_mz =3D=3D NULL=
) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; internals-&gt;capa_mz =3D rte_memzone_reserve(capa_memz_name,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size, rte_socket_id(), 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (internals-&gt;capa_mz =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_LOG(DEBUG,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Error allocating memzone for capabili=
ties&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_addr =3D (uintptr_t)(internals-&gt=
;capa_mz-&gt;addr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (internals-&gt;qat_dev-&gt;options=
.legacy_alg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy((void *)cp_addr, qat_sym_crypto_legacy_caps_gen6, legacy_=
caps_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cp_addr +=3D legacy_caps_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy((void *)cp_addr, qat_sym_crypt=
o_caps_gen6, caps_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; internals-&gt;qat_dev_capabilities =
=3D internals-&gt;capa_mz-&gt;addr;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int get_block_size(enum icp_qat_hw_auth_algo qat_hash_alg)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (qat_hash_alg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA224:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA256:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return QAT_SHA_CBLOCK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA384:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA512:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return QAT_SHA512_CBLOCK;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EFAULT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;<br>
+}<br>
+<br>
+int<br>
+qat_sym_cd_auth_set_gen6(struct qat_sym_session *cdesc,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint8_t *authkey,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t authkeylen,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t aad_length __rte_unused,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t digestsize,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int operation)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_hw_auth_setup *hash =
=3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_fw_la_bulk_req *req_tm=
pl =3D &amp;cdesc-&gt;fw_req;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_fw_comn_req_hdr_cd_par=
s *cd_pars =3D &amp;req_tmpl-&gt;cd_pars;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr =3D &amp;req_tmpl-&gt;cd_ct=
rl;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_fw_auth_cd_ctrl_hdr *h=
ash_cd_ctrl =3D ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_fw_la_auth_req_params =
*auth_param =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct icp_qat_fw_la_auth_req_params *)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((char *)&amp;req_tmpl-&gt;serv_specif_rqpars +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ICP_QAT_FW_HASH_REQUEST_PARAMETERS_OFFSET);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum icp_qat_hw_auth_mode auth_mode =
=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cdesc-&gt;auth_=
mode =3D=3D ICP_QAT_HW_AUTH_MODE0) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_AUTH_=
MODE0 : ICP_QAT_HW_AUTH_MODE2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t state1_size =3D 0, state2_si=
ze =3D 0, cd_extra_size =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t hash_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cdesc-&gt;qat_cmd =3D=3D ICP_QAT_=
FW_LA_CMD_AUTH) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ICP_QAT_FW_SLICE_AUTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cdesc-&gt;cd_cur_ptr =3D (uint8_t *)&amp;cdesc-&gt;cd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (cdesc-&gt;qat_cmd !=3D ICP=
_QAT_FW_LA_CMD_CIPHER_HASH) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; QAT_LOG(ERR, &quot;Invalid param, must be a hash command.&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EFAULT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (operation =3D=3D RTE_CRYPTO_AUTH_=
OP_VERIFY)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cdesc-&gt;auth_op =3D ICP_QAT_HW_AUTH_VERIFY;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cdesc-&gt;auth_op =3D ICP_QAT_HW_AUTH_GENERATE;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Setup the inner hash config<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_offset =3D cdesc-&gt;cd_cur_ptr-=
((uint8_t *)&amp;cdesc-&gt;cd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash =3D (struct icp_qat_hw_auth_setu=
p *)cdesc-&gt;cd_cur_ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash-&gt;auth_config.reserved =3D 0;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cdesc-&gt;qat_hash_alg =3D=3D ICP=
_QAT_HW_AUTH_ALGO_NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash-&gt;auth_config.config =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_AUTH_=
CONFIG_BUILD(auth_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cdesc-&gt;qat_hash_alg, 4);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash-&gt;auth_config.config =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_AUTH_=
CONFIG_BUILD(auth_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cdesc-&gt;qat_hash_alg, digestsize);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cdesc-&gt;auth_mode =3D=3D ICP_QA=
T_HW_AUTH_MODE0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash-&gt;auth_counter.counter =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int block_size =3D get_block_size(cdesc-&gt;qat_hash_alg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (block_size &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return block_siz=
e;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash-&gt;auth_counter.counter =3D rte_bswap32(block_size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;hash_cfg_offset =3D =
hash_offset &gt;&gt; 3;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cdesc-&gt;cd_cur_ptr +=3D sizeof(stru=
ct icp_qat_hw_auth_setup);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (cdesc-&gt;qat_hash_alg) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA224:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA256:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cdesc-&gt;auth_mode !=3D ICP_QAT_HW_AUTH_MODE0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_f=
w_la_cipher_20_req_params *cipher_param_20 =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;req_tmpl-&gt;serv_specif_rqpar=
s;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memcpy(cdesc=
-&gt;cd_cur_ptr, authkey, authkeylen);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state2_size =3D =
0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state1_size =3D =
authkeylen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_HASH_=
FLAG_MODE2_SET(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;hash_flags, QAT_FW_LA_MODE=
2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_param_20-=
&gt;spc_aad_addr =3D cdesc-&gt;cd_paddr +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cdesc-&gt;cd_cur_ptr - (uint8_t *)&amp;cde=
sc-&gt;cd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_param_20-=
&gt;hmac_sz =3D ICP_QAT_HW_SHA256_STATE2_SZ * 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA384:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cdesc-&gt;auth_mode !=3D ICP_QAT_HW_AUTH_MODE0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_f=
w_la_cipher_20_req_params *cipher_param_20 =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;req_tmpl-&gt;serv_specif_rqpar=
s;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memcpy(cdesc=
-&gt;cd_cur_ptr, authkey, authkeylen);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state2_size =3D =
0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state1_size =3D =
authkeylen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_HASH_=
FLAG_MODE2_SET(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;hash_flags, QAT_FW_LA_MODE=
2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_param_20-=
&gt;spc_aad_addr =3D cdesc-&gt;cd_paddr +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cdesc-&gt;cd_cur_ptr - (uint8_t *)&amp;cde=
sc-&gt;cd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_param_20-=
&gt;hmac_sz =3D ICP_QAT_HW_SHA384_STATE2_SZ * 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_SHA512:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cdesc-&gt;auth_mode !=3D ICP_QAT_HW_AUTH_MODE0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct icp_qat_f=
w_la_cipher_20_req_params *cipher_param_20 =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void *)&amp;req_tmpl-&gt;serv_specif_rqpar=
s;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memcpy(cdesc=
-&gt;cd_cur_ptr, authkey, authkeylen);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state2_size =3D =
0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state1_size =3D =
authkeylen;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_HASH_=
FLAG_MODE2_SET(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;hash_flags, QAT_FW_LA_MODE=
2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_param_20-=
&gt;spc_aad_addr =3D cdesc-&gt;cd_paddr +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cdesc-&gt;cd_cur_ptr - (uint8_t *)&amp;cde=
sc-&gt;cd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_param_20-=
&gt;hmac_sz =3D ICP_QAT_HW_SHA512_STATE2_SZ * 2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case ICP_QAT_HW_AUTH_ALGO_NULL:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; QAT_LOG(ERR, &quot;Invalid HASH alg %u&quot;, cdesc-&gt;qat_hash=
_alg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EFAULT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Auth CD config setup */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;hash_flags |=3D ICP_=
QAT_FW_AUTH_HDR_FLAG_NO_NESTED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;inner_state1_sz =3D =
state1_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cdesc-&gt;qat_hash_alg =3D=3D ICP=
_QAT_HW_AUTH_ALGO_NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash_cd_ctrl-&gt;inner_res_sz =3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash_cd_ctrl-&gt;final_sz =3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; auth_param-&gt;auth_res_sz =3D 4;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash_cd_ctrl-&gt;inner_res_sz =3D digestsize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hash_cd_ctrl-&gt;final_sz =3D digestsize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; auth_param-&gt;auth_res_sz =3D digestsize;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;inner_state2_sz&nbsp=
; =3D state2_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;inner_state2_offset =
=3D hash_cd_ctrl-&gt;hash_cfg_offset +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((sizeof(struct =
icp_qat_hw_auth_setup) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_ALIGN_=
CEIL(hash_cd_ctrl-&gt;inner_state1_sz, 8))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &gt;&gt; 3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cdesc-&gt;cd_cur_ptr +=3D state1_size=
 + state2_size + cd_extra_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cd_pars-&gt;u.s.content_desc_addr =3D=
 cdesc-&gt;cd_paddr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cd_pars-&gt;u.s.content_desc_params_s=
z =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int<br>
+qat_sym_build_op_auth_gen6(void *in_op, struct qat_sym_session *ctx,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *out_msg, void *op_cookie)<br=
>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_crypto_op *op =3D in_op;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(op-&gt;sym-&gt;m_dst !=
=3D NULL &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; op-&gt;sym-&gt;m_dst !=3D op-&gt;sym-&gt;m_src)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; op-&gt;status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return qat_sym_build_op_auth_gen1(in_=
op, ctx, out_msg, op_cookie);<br>
+}<br>
+<br>
+static int<br>
+qat_sym_crypto_set_session_gen6(void *cdev, void *session)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qat_sym_session *ctx =3D sessi=
on;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum rte_proc_type_t proc_type =3D rt=
e_eal_process_type();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (proc_type =3D=3D RTE_PROC_AUTO ||=
 proc_type =3D=3D RTE_PROC_INVALID)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D qat_sym_crypto_set_session_ge=
n4(cdev, session);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ctx-&gt;build_request[proc_type] =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_build_op=
_chain_gen1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Gen 6 does no=
t support chaining of symmetric crypto ops. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_LOG(ERR, &qu=
ot;Chained ops not supported&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUP;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (ctx-&gt;build_request[proc_type] =3D=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_build_op=
_auth_gen1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Gen 6 does no=
t support OOP auth ops. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;build_re=
quest[proc_type] =3D qat_sym_build_op_auth_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static uint32_t<br>
+qat_sym_dp_enqueue_auth_jobs_gen6(void *qp_data, uint8_t *drv_ctx,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_crypto_sym_vec *vec, union rte_crypto_sym_ofs ofs,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; void *user_data[], int *status)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vec-&gt;dest_sgl !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qat_sym_dp_fill_vec_status(vec-&gt;status, ENOTSUP, vec-&gt;num)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *status =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return qat_sym_dp_enqueue_auth_jobs_g=
en1(qp_data, drv_ctx, vec, ofs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_data, statu=
s);<br>
+}<br>
+<br>
+static int<br>
+qat_sym_configure_raw_dp_ctx_gen6(void *raw_dp_ctx, void *ctx)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct qat_sym_session *session =3D c=
tx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_crypto_raw_dp_ctx *raw_ctx=
 =3D raw_dp_ctx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D qat_sym_configure_raw_dp_ctx_=
gen4(raw_dp_ctx, ctx);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret !=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (session-&gt;qat_cmd =3D=3D ICP_QA=
T_FW_LA_CMD_AUTH)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; raw_ctx-&gt;enqueue_burst =3D qat_sym_dp_enqueue_auth_jobs_gen6;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static uint64_t<br>
+qat_sym_crypto_feature_flags_get_gen6(struct qat_pci_device *qat_dev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Gen 6 does not support chaining of=
 symmetric crypto ops. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return qat_sym_crypto_feature_flags_g=
et_gen1(qat_dev) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~RTE_CRYPTODEV_FF_SYM_OPERATION_CHAINING;<b=
r>
+}<br>
+<br>
+RTE_INIT(qat_sym_crypto_gen6_init)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GEN6].cryptod=
ev_ops =3D &amp;qat_sym_crypto_ops_gen1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GEN6].get_cap=
abilities =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_crypto_c=
ap_get_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GEN6].set_ses=
sion =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_crypto_s=
et_session_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GEN6].set_raw=
_dp_ctx =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_configur=
e_raw_dp_ctx_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GEN6].get_fea=
ture_flags =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_crypto_f=
eature_flags_get_gen6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GEN6].create_=
security_ctx =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_create_s=
ecurity_gen1;<br>
+}<br>
+<br>
+#ifdef BUILD_QAT_ASYM<br>
+RTE_INIT(qat_asym_crypto_gen6_init)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_GEN6].crypto=
dev_ops =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;qat_asym_cr=
ypto_ops_gen1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_GEN6].get_ca=
pabilities =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_crypto_=
cap_get_gen1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_GEN6].get_fe=
ature_flags =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_crypto_=
feature_flags_get_gen1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_GEN6].set_se=
ssion =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_crypto_=
set_session_gen1;<br>
+}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c<br>
index d89c20cad6..e6d158f777 100644<br>
--- a/drivers/crypto/qat/qat_sym_session.c<br>
+++ b/drivers/crypto/qat/qat_sym_session.c<br>
@@ -378,6 +378,15 @@ qat_get_cipher_xform(struct rte_crypto_sym_xform *xfor=
m)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;<br>
+static inline uint8_t qat_check_ucs(enum qat_device_gen qat_dev_gen)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (qat_dev_gen =3D=3D QAT_GEN4 |=
|<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=
=3D QAT_GEN5 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=
=3D QAT_GEN6 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=
=3D QAT_VQAT);<br>
+}<br>
+<br>
+<br>
&nbsp;int<br>
&nbsp;qat_sym_session_configure_cipher(struct rte_cryptodev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct rte_crypto_sym_xform *xform,<br>
@@ -416,9 +425,7 @@ qat_sym_session_configure_cipher(struct rte_cryptodev *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
error_out;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_mode =3D ICP_QAT_HW_CIPHER_CTR_MODE;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_GEN5 |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=3D QAT_VQAT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;is_u=
cs =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; session-&gt;is_ucs =3D qat_check_ucs(qat_dev_gen);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_CIPHER_SNO=
W3G_UEA2:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (qat_sym_validate_snow3g_key(cipher_xform-&gt;key.=
length,<br>
@@ -968,8 +975,7 @@ qat_sym_session_configure_auth(struct rte_cryptodev *de=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;auth_iv.length =3D AES_GCM_J0_LEN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;is_iv12B =3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_GEN5 |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=3D QAT_VQAT) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_check_ucs(qat_dev_gen)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;is_cnt_zero =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;is_ucs =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
@@ -1133,10 +1139,7 @@ qat_sym_session_configure_aead(struct rte_cryptodev =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_mode =3D ICP_QAT_HW_CIPHER_CTR_MODE;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_hash_alg =3D ICP_QAT_HW_AUTH_ALGO_GAL=
OIS_128;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_GEN5 |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=3D QAT_VQAT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;is_u=
cs =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; session-&gt;is_ucs =3D qat_check_ucs(qat_dev_gen);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (session-&gt;cipher_iv.length =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sessi=
on-&gt;cipher_iv.length =3D AES_GCM_J0_LEN;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -1155,16 +1158,12 @@ qat_sym_session_configure_aead(struct rte_cryptodev=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_mode =3D ICP_QAT_HW_CIPHER_CTR_MODE;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_hash_alg =3D ICP_QAT_HW_AUTH_ALGO_AES=
_CBC_MAC;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_GEN5 |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=3D QAT_VQAT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;is_u=
cs =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; session-&gt;is_ucs =3D qat_check_ucs(qat_dev_gen);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AEAD_CHACH=
A20_POLY1305:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (aead_xform-&gt;key.length !=3D ICP_QAT_HW_CHACHAP=
OLY_KEY_SZ)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_GEN5 |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=3D QAT_VQAT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;is_u=
cs =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; session-&gt;is_ucs =3D qat_check_ucs(qat_dev_gen);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_cipher_alg =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_HW_CIPHER_ALGO_CHACHA20_=
POLY1305;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qat_sym_session_handle_single_pass(session,<br>
@@ -2006,7 +2005,7 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cde=
sc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,<br>
+static int qat_sym_cd_auth_set_gen1(struct qat_sym_session *cdesc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const uint8_t *authkey,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t authkeylen,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t aad_length,<br>
@@ -2037,7 +2036,7 @@ static int qat_sym_cd_auth_set(struct qat_sym_session=
 *cdesc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ICP_QAT_FW_SLICE_AUTH);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_COMN_NEXT_ID_SET(hash_cd_ctrl,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ICP_QAT_FW_SLICE_DRAM_WR);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_SLICE_DRAM_WR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cdesc-&gt;cd_cur_ptr =3D (uint8_t *)&amp;cdesc-&gt;cd=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (cdesc-&gt;qat_c=
md =3D=3D ICP_QAT_FW_LA_CMD_HASH_CIPHER) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ICP_QAT_FW_COMN_CURR_ID_SET(hash_cd_ctrl,<br>
@@ -2135,8 +2134,7 @@ static int qat_sym_cd_auth_set(struct qat_sym_session=
 *cdesc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_h=
ash_get_block_size(cdesc-&gt;qat_hash_alg);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_param-&gt;hash_state_sz =3D (hash_cd_ctrl-&gt;ou=
ter_prefix_sz +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth_=
param-&gt;u2.inner_prefix_sz) &gt;&gt; 3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN4 || qat_dev_gen =3D=3D QAT_GEN5 |=
|<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_dev_gen =3D=3D QAT_VQAT) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (qat_check_ucs(qat_dev_gen)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICP_Q=
AT_FW_HASH_FLAG_MODE2_SET(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_cd_ctrl-&gt;hash_flags,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_FW_LA_MODE2);<br>
@@ -2459,6 +2457,22 @@ static int qat_sym_cd_auth_set(struct qat_sym_sessio=
n *cdesc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint8_t *authkey,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t authkeylen,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t aad_length,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t digestsize,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int operation,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum qat_device_gen qat_dev_gen)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qat_dev_gen =3D=3D QAT_GEN6)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return qat_sym_cd_auth_set_gen6(cdesc, authkey, authkeylen,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aad_length, digestsize, operation);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return qat_sym_cd_auth_set_gen1(cdesc=
, authkey, authkeylen,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aad_length, dige=
stsize, operation, qat_dev_gen);<br>
+}<br>
+<br>
&nbsp;int qat_sym_validate_aes_key(int key_len, enum icp_qat_hw_cipher_algo=
 *alg)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (key_len) {<br>
@@ -2653,6 +2667,7 @@ qat_sym_cd_crc_set(struct qat_sym_session *cdesc,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case QAT_GEN4:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case QAT_GEN5:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case QAT_GEN6:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; crc_cfg.mode =3D ICP_QAT_HW_CIPHER_ECB_MODE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; crc_cfg.algo =3D ICP_QAT_HW_CIPHER_ALGO_NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; crc_cfg.hash_cmp_val =3D 0;<br>
diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_=
sym_session.h<br>
index b18673a1f7..e4fb5cacc6 100644<br>
--- a/drivers/crypto/qat/qat_sym_session.h<br>
+++ b/drivers/crypto/qat/qat_sym_session.h<br>
@@ -204,6 +204,14 @@ qat_sym_sesssion_init_common_hdr(struct qat_sym_sessio=
n *session,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct icp_qat_fw_comn_req_hdr *header,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum qat_sym_proto_flag proto_flags);<br>
&nbsp;<br>
+int<br>
+qat_sym_cd_auth_set_gen6(struct qat_sym_session *cdesc,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; const uint8_t *authkey,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t authkeylen,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t aad_length,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t digestsize,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned int operation);<br>
+<br>
&nbsp;int<br>
&nbsp;qat_sym_validate_aes_key(int key_len, enum icp_qat_hw_cipher_algo *al=
g);<br>
&nbsp;int<br>
--<br>
2.52.0<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB60451368E05BA6CBA9E212D781672LV2PR11MB6045namp_--
