Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F2F8D74D
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 14:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C57F440297;
	Thu, 16 Apr 2026 16:06:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 83F0740144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 16:06:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776348390; x=1807884390;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=ylsEC6egtXlHveXV4VGberaloe1By1MrA5jrtPyWFRA=;
 b=QXQF005p8VP6mC/xQpgySQng6sLRix/m/5ITpd7P87uZFUh44W7Hvc5w
 7b8g13xCC1Wx/fhR7UyCnIh24FwbCGpBXr5kOsmHJzIqThvF+q0oNk8Fz
 hC2+LmuxDJWGnVpBQ6RsnmjKMnwWKOXFLLjVqOf4oiR6/m/squS2dhJPj
 20NnOTSR52oXkrywxveOlUtu2KWNS6bcMCkJkv4ugZiFaSihIxXwDCFcs
 T0sejjQ+M41ilWBqOySu0WjmdIN7levGep8glw1f8r9fDEtVUEmE7ouJp
 8bFHwc/yXNeBQPBw41PZbN1g7DJROk7EQrmh12kocpa3fGjOdG6Djls1A A==;
X-CSE-ConnectionGUID: CQEPaJ4ySAWvdyKY+CE2Sg==
X-CSE-MsgGUID: 76rtJnJRSF+AGeFO0kdS0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="64886503"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208,217";a="64886503"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 07:06:09 -0700
X-CSE-ConnectionGUID: zDaRI5r9TbyV6r9gu1EyIQ==
X-CSE-MsgGUID: eM26dK9WRk+DfVrV8Z7eMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
 d="scan'208,217";a="268741488"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 07:06:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 07:06:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 07:06:08 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 07:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFtRCaPPbMu+DRvks4JeJD4HP5R0OjPt/cKsQPDcbRVibOqdxl0vew/fhpZy8K7WSWB9D4du8xqYgWeorfiVXYumcRI+peWeLm5H/lzof+mZ1zcwXXG3+SFtig6hLzKEzVcLZcUZEE0o8kbJWIx3FN6Z5QPHNbgAq6NRaF93l1QxiE0lzvj9Fxru3mekaKT8tQgB5QyV1kKriPT42LLa08ZWrtdFJSw68yS5B4ZNmsj71If//b4UzuSXq8oCcNjR7y65MA8XtRK0fAN75Sh594PY6NW6NhNd9KHquC3b4V0FFfNBTi1TdUIc38ew8DjwpjO20GrCfd7Y/qN3teeeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Rcs16ulRbca6wDdDIIv6/C1mSKjecM7bzZ9g5ZoC2c=;
 b=L1UANmMkc4xYJVvSSa6a9QCl9DUCt+yF7DejbCKoVwECprZ70yGS0AIiY0r4eUQDIVyuyf1qfB7woQTVZlPxVqfbqiDAQa9NpFH+YMy+HsLfm9YfnmQAeFAsRbsAgHXDdEw3juQKWqohcIJQAKDGFi58DdPopS9S+1t43VGmOx6fcEH5izrwUZPlMpZoFe2+CdIMEfeFNNlchMaW0q9kS1mgYbl0FciFrsA/6Hr41crlgarrJly+SdaHV0XARHcTITUS/k9amjFlHknyNjJpcgu9b+Npsnq8FPJBJ+b31K2gyerflwuESUdVlPU1lX5ebIgUeHgRMDenKmmowzltvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 14:05:57 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:05:57 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] common/qat: add asym crypto disable option
Thread-Topic: [PATCH] common/qat: add asym crypto disable option
Thread-Index: AQHczYtp7xX96gDfz06aMLY8RNFpN7XhuNil
Date: Thu, 16 Apr 2026 14:05:57 +0000
Message-ID: <DS0PR11MB745842CEBFACEDBA05C1CE6181232@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260416102543.133175-1-radu.nicolau@intel.com>
In-Reply-To: <20260416102543.133175-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB7855:EE_
x-ms-office365-filtering-correlation-id: 477a58d6-b4c8-4f3a-f5f2-08de9bc1480e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|8096899003|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 5nP9q+Txkjo8Kx0cQhL2oJttCqa56FRImP9TtPcgYbq+THtQKyleTM2jioUN0Lzje31yAAdacHHfDqI5tp6icrfuapceYZfCw19pq3fQbuiUQCSH2D5Ra36geySAkqxmGMMdryvznOwQ+pw46j/AEMqreBbC20OXQq6Mb/XERKggzM62Mqnq7w9oUeCJ2QwStfwWbhblYFT4Iro2f7WawHm905sRQgwXS3TG/z4Aglr7SJ/KuYxMcke464uQd3x5lzb+uB/Bn8AE33PJDSovQpAKbuylSS/sVck++dhW5r2UUpFuI5qgBy7mVZ7BsprerwKPQkvhSGfNrOQbVKETVDp8j+nSLgCYUJg47vmlGqkbu+9exZLN1RDdRG1iHfsoYDE39BGqsJ2+Ar79CJR+e0hVONcpqGDiWUFWBI3YCYJ6q73xCwnw+ADT+QhIVzOT6Y6whzsRZI4t9/BMFgyOI7IwKMdiF2Xx39KDppN2yW2ws+Z9m70hegzvjd4ymlsvFcHAiX2BJ12B8AC+ARzWaNYBHSAZv4ME4hB/z3Did0R+j+pzr4emi4i3D0RFSCv9bbo5pi6qEuNtRLF9WmwH8hYcu4W7MpdHY/a0RSbO9a7xbUQ0fFnnBUd4Um0mMoZcNC5zwYhz+rpafKZ4WDQVwG10S5dkaRvtNCCfWV00nTlmqeHsPA1Gs49PyzgRoRJv2XNv7/DVyroQPWc7XMrjPgHBKnv+aNUgZRkuLTvW/jSzNEc1b/Nf6MAeswZKqEXp5v8uhfngLznzQmqPyHV9LCVmIBiZwJndmldcVaxvujc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(8096899003)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NXohRF6d4LUmyFC+4ce9L+60ipuobTBoSsRtEnhlR84V6S+4zMjRSzFsXJ6Q?=
 =?us-ascii?Q?gRc3iXJEdR4/fNmWRy0EJOQRbJZQVlRGMKBYyxcC3SnX9ugbSyB8IYe/D06Y?=
 =?us-ascii?Q?UCJMkdrexKCXYLc5vmFkVDanioQP3vRdNSq9wNbL+jlLYXXsHsM5+vAqoIiz?=
 =?us-ascii?Q?uY/Ch7iKz1/+e2pabACJudQ00lac2tToy8FOxIkt6ziWOB9wpWXcAdd5IGHy?=
 =?us-ascii?Q?FHlliEIYUSnMrq4jb2gASg7HPqEb0H4kbYqFWp5u+je7jxCjEwpAM8MnYLxv?=
 =?us-ascii?Q?Pn6+6r08lFIg1cHPkp86Br3r9QTZFGebgSxhwzZjpwcq3opIL01ZTICLD27S?=
 =?us-ascii?Q?ucE+E+xlDNrmYPfPcjmkO9IEbZgyU9bweSICXwpfybIAO5CcWgMTPc7WNt3l?=
 =?us-ascii?Q?dZQWHSnjnvbZ74UtaYeTd+6eeRj+FaEVoQi6xdBzbR9/coYB1+rrK6D7dK7k?=
 =?us-ascii?Q?mo/4lMg95tmC2s0xQDG1ry7oJCUjeXZR551ZrY2YYPXO5yXUNzgkF1HECAos?=
 =?us-ascii?Q?iz5Tr2aIvZ2xT+PzZ7874QpZYfOikCUCKYZyrPcO8YVHemD+wh2Q9We7r+VT?=
 =?us-ascii?Q?M3/PCCVHC0qWUMpr38QRhU4wJ6AmIxnvcNLk0SKXNiOdQTZx0a3f95Egu11a?=
 =?us-ascii?Q?vFFDyajvGozPZwwjqBCyXhXRD2DOUtZx014sq8h0pWgOscx/VsD7BHz1SJig?=
 =?us-ascii?Q?bDqswH6TEm9DVJ95XftmtN9YldOew/+5u5nqNIqPkpSYdJCWhi6HucOdj39t?=
 =?us-ascii?Q?zaiOx19sqo6kcpvuKeM84O8EffHR2OJPb5wMSqVNR4gNsjCE1MT/QLbRrkPN?=
 =?us-ascii?Q?4ItZqerEoMjdIOuc80Le4Gby8RtXHDzw5DrAbjLqOdEOayy0WN+cHa+VaeO3?=
 =?us-ascii?Q?vuFuYMn6mSv4TzB0ToIxzxR0U2vg8tWgUU8twl30cCInfCfl+bzAs5w4JXx+?=
 =?us-ascii?Q?ub1tzVWMifE0j75AIXstu1KbVUWGGJk6NrJKeZmyKhEXqjDpDrNA68A0FTRm?=
 =?us-ascii?Q?iGFZ8phvX6iobISGwB+N8WElUjI4/mO3TCgX+Pimpc/YCgBuwhgXYd/ntpsU?=
 =?us-ascii?Q?gcRXaQcvu+644qrOkup0R76KZ3IL5qfsT1tKRU/AFk7vmpfc3gPMcoaZzdMq?=
 =?us-ascii?Q?Uu1zG4EhYJdp68epN9GWX6ccrWgnTnDQlcgecBz+SdNQLCqbgqtu/1lVsab1?=
 =?us-ascii?Q?V69SjNgpOuhHK0xdc9S4jStAz9qdScm6M5HCtshtR9Pea0RhG/8wx3m+JJIX?=
 =?us-ascii?Q?YCr/WRO/wnpeMzzL6jdU4R2EBHRMCIuBJ9nhv4Ezyj0385NBhNmy3SlFc9TF?=
 =?us-ascii?Q?fboAKfszjlJ1vU4pSTJMDt6kBnmeymyoC9j/iOfOhcCQMRC7KDvw5Yf65q1z?=
 =?us-ascii?Q?+p0bFd5PxcUxzzh3i7i8vK2ZY2DX8B/5unSgcLlWPaQdAcbfl+fw/IceNKKU?=
 =?us-ascii?Q?pxQi5E/MzMoHIVRghTwrsOWY+lIPilQ3ps57knANCuUk+NQzOD0e89L8PiD0?=
 =?us-ascii?Q?0SIoFDbecgLG54orO1ZhNE4VSDDpQkxVnrZmle3V7As51UNQ/Zu4IdPGdyhT?=
 =?us-ascii?Q?tAvqjDbh6/lLhKyyTQu77XYLAGfIUv/R0uXqS0zENAGcTwI2YGPvxGgB01RI?=
 =?us-ascii?Q?7N4SBTbjSgiVcdfcTTsxP7dGf4IWZgayJqBpdRW4uVhknrVCoYFDEupg05fH?=
 =?us-ascii?Q?etih2RH/hjYaTvpXfCsUT6RbNbi7vrW6TCiBc6x37hv1IEgJ?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB745842CEBFACEDBA05C1CE6181232DS0PR11MB7458namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m7l5hWA2qsvQ/AqmEMvtgLvPbpz5dRSSJTzw36Wi0Ix6ScO6pFjN5LG/JjZE9BaPU13y0ZLXIPUFyRPzEZ/1QB1tIj9xpa4FRdR/QtIq0F9fE/t00DgtVbfpMTX9CVt3XahB09vhe95DzWBxSBRuSVLNQCSaY7TP+p0LYpsS55PQ0ub3RwJJ7Dw4OlGi9jhXNU/88N0yeCjyd80Xk2iLnyjh9CPRp/CpUMY6IoQm3sf7Q/bVRJibZZEkBVULKD4fqBc3Fyn9UnRm/z8zChtiyF10cBX3m1GcuY82Wz7S1a9m+tuYjJHm6/f7YxlVZlc7cVySUyyRHMZ6Ky0O4HSPBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477a58d6-b4c8-4f3a-f5f2-08de9bc1480e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 14:05:57.2688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOXqCVPx/PLrj/xCJYlbKwmDXvcJPzQb/7ZWcI2v0JUFct1FqFqgD5nt+Df8IGwnIpOss3DAPfqjzOxeUmCAlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
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

--_000_DS0PR11MB745842CEBFACEDBA05C1CE6181232DS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>
________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 16 April 2026 11:25
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>
Subject: [PATCH] common/qat: add asym crypto disable option

The Asymmetric crypto QAT PMD can now be disabled independently.

Example:
meson setup build -Ddisable_drivers=3Dcrypto/qat/asym

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/common/qat/meson.build                | 23 ++++++++++++++++---
 drivers/crypto/qat/{ =3D> asym}/qat_asym.c      |  0
 drivers/crypto/qat/{ =3D> asym}/qat_asym.h      |  0
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c    |  2 ++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c  |  2 ++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c  |  2 ++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c  |  6 +++++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c  |  2 ++
 .../crypto/qat/dev/qat_crypto_pmd_gen_lce.c   |  2 ++
 drivers/crypto/qat/qat_crypto.c               |  6 ++++-
 10 files changed, 41 insertions(+), 4 deletions(-)
 rename drivers/crypto/qat/{ =3D> asym}/qat_asym.c (100%)
 rename drivers/crypto/qat/{ =3D> asym}/qat_asym.h (100%)

diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.buil=
d
index 31e06f4376..7f12f2b09d 100644
--- a/drivers/common/qat/meson.build
+++ b/drivers/common/qat/meson.build
@@ -13,6 +13,9 @@ qat_crypto_relpath =3D '../../' + qat_crypto_path
 qat_compress =3D true
 qat_compress_path =3D 'compress/qat'
 qat_compress_relpath =3D '../../' + qat_compress_path
+qat_crypto_asym =3D true
+qat_crypto_asym_path =3D 'crypto/qat/asym'
+qat_crypto_asym_relpath =3D '../../' + qat_crypto_asym_path

 if disable_drivers.contains(qat_crypto_path)
     qat_crypto =3D false
@@ -26,6 +29,12 @@ if disable_drivers.contains(qat_compress_path)
     set_variable('drv_' + qat_compress_path.underscorify() + '_disable_rea=
son',
             'Explicitly disabled via build config')
 endif
+if disable_drivers.contains(qat_crypto_asym_path)
+    qat_crypto_asym =3D false
+    dpdk_drvs_disabled +=3D qat_crypto_asym_path
+    set_variable('drv_' + qat_crypto_asym_path.underscorify() + '_disable_=
reason',
+            'Explicitly disabled via build config')
+endif

 libcrypto =3D dependency('libcrypto', required: false, method: 'pkg-config=
')

@@ -88,6 +97,7 @@ sources +=3D files(
 includes +=3D include_directories(
         'qat_adf',
         qat_crypto_relpath,
+        qat_crypto_asym_relpath,
         qat_compress_relpath,
 )

@@ -108,9 +118,8 @@ cflags +=3D no_shadow_cflag

 if qat_crypto
     foreach f: ['qat_sym.c', 'qat_sym_session.c',
-            'qat_asym.c', 'qat_crypto.c',
+            'qat_crypto.c',
             'dev/qat_sym_pmd_gen1.c',
-            'dev/qat_asym_pmd_gen1.c',
             'dev/qat_crypto_pmd_gen2.c',
             'dev/qat_crypto_pmd_gen3.c',
             'dev/qat_crypto_pmd_gen4.c',
@@ -119,6 +128,14 @@ if qat_crypto
         ]
         sources +=3D files(join_paths(qat_crypto_relpath, f))
     endforeach
+    cflags +=3D '-DBUILD_QAT_SYM'
+    if qat_crypto_asym
+        foreach f: ['asym/qat_asym.c',
+                    'dev/qat_asym_pmd_gen1.c',
+            ]
+            sources +=3D files(join_paths(qat_crypto_relpath, f))
+        endforeach
+        cflags +=3D '-DBUILD_QAT_ASYM'
+    endif
     deps +=3D ['security']
-    cflags +=3D ['-DBUILD_QAT_SYM', '-DBUILD_QAT_ASYM']
 endif
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/asym/qat_as=
ym.c
similarity index 100%
rename from drivers/crypto/qat/qat_asym.c
rename to drivers/crypto/qat/asym/qat_asym.c
diff --git a/drivers/crypto/qat/qat_asym.h b/drivers/crypto/qat/asym/qat_as=
ym.h
similarity index 100%
rename from drivers/crypto/qat/qat_asym.h
rename to drivers/crypto/qat/asym/qat_asym.h
diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qa=
t/dev/qat_asym_pmd_gen1.c
index 20001bd1cc..c96608dd37 100644
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
@@ -112,6 +112,7 @@ qat_asym_crypto_set_session_gen1(void *cdev __rte_unuse=
d,
         return 0;
 }

+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen1_init)
 {
         qat_asym_gen_dev_ops[QAT_GEN1].cryptodev_ops =3D
@@ -121,3 +122,4 @@ RTE_INIT(qat_asym_crypto_gen1_init)
         qat_asym_gen_dev_ops[QAT_GEN1].get_feature_flags =3D
                         qat_asym_crypto_feature_flags_get_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen2.c
index f20d367404..89c51c8f80 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c
@@ -336,6 +336,7 @@ RTE_INIT(qat_sym_crypto_gen2_init)
                         qat_sym_create_security_gen1;
 }

+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen2_init)
 {
         qat_asym_gen_dev_ops[QAT_GEN2].cryptodev_ops =3D
@@ -347,3 +348,4 @@ RTE_INIT(qat_asym_crypto_gen2_init)
         qat_asym_gen_dev_ops[QAT_GEN2].set_session =3D
                         qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c
index c196cf3cdb..91546046f1 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -800,6 +800,7 @@ RTE_INIT(qat_sym_crypto_gen3_init)
                         qat_sym_create_security_gen1;
 }

+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen3_init)
 {
         qat_asym_gen_dev_ops[QAT_GEN3].cryptodev_ops =3D
@@ -811,3 +812,4 @@ RTE_INIT(qat_asym_crypto_gen3_init)
         qat_asym_gen_dev_ops[QAT_GEN3].set_session =3D
                         qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c
index 52577f6907..41cad29142 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -115,6 +115,7 @@ static struct rte_cryptodev_capabilities qat_sym_crypto=
_caps_gen4[] =3D {
         RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };

+#ifdef BUILD_QAT_ASYM
 static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] =3D {
         QAT_ASYM_CAP(MODEX,
                 0, 1, 512, 1),
@@ -159,6 +160,7 @@ static struct rte_cryptodev_capabilities qat_asym_crypt=
o_caps_gen4[] =3D {
                         64, 512, 64),
         RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
+#endif

 static int
 qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
@@ -202,6 +204,7 @@ qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_privat=
e *internals,
         return 0;
 }

+#ifdef BUILD_QAT_ASYM
 static int
 qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,
                         const char *capa_memz_name,
@@ -239,6 +242,7 @@ qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_priva=
te *internals,

         return 0;
 }
+#endif

 static __rte_always_inline void
 enqueue_one_aead_job_gen4(struct qat_sym_session *ctx,
@@ -622,6 +626,7 @@ RTE_INIT(qat_sym_crypto_gen4_init)
                         qat_sym_create_security_gen1;
 }

+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen4_init)
 {
         qat_asym_gen_dev_ops[QAT_VQAT].cryptodev_ops =3D
@@ -637,3 +642,4 @@ RTE_INIT(qat_asym_crypto_gen4_init)
                 qat_asym_gen_dev_ops[QAT_GEN4].set_session =3D
                         qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen5.c
index 5714420e1e..2680116d6e 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -224,6 +224,7 @@ RTE_INIT(qat_sym_crypto_gen5_init)
                         qat_sym_create_security_gen1;
 }

+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen5_init)
 {
         qat_asym_gen_dev_ops[QAT_GEN5].cryptodev_ops =3D
@@ -235,3 +236,4 @@ RTE_INIT(qat_asym_crypto_gen5_init)
         qat_asym_gen_dev_ops[QAT_GEN5].set_session =3D
                         qat_asym_crypto_set_session_gen1;
 }
+#endif
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c b/drivers/cryp=
to/qat/dev/qat_crypto_pmd_gen_lce.c
index 7298916f2a..ec075bbf68 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c
@@ -301,6 +301,7 @@ RTE_INIT(qat_sym_crypto_gen_lce_init)
         qat_sym_gen_dev_ops[QAT_GEN_LCE].get_feature_flags =3D qat_sym_cry=
pto_feature_flags_get_gen1;
 }

+#ifdef BUILD_QAT_ASYM
 RTE_INIT(qat_asym_crypto_gen_lce_init)
 {
         qat_asym_gen_dev_ops[QAT_GEN_LCE].cryptodev_ops =3D NULL;
@@ -308,3 +309,4 @@ RTE_INIT(qat_asym_crypto_gen_lce_init)
         qat_asym_gen_dev_ops[QAT_GEN_LCE].get_feature_flags =3D NULL;
         qat_asym_gen_dev_ops[QAT_GEN_LCE].set_session =3D NULL;
 }
+#endif
diff --git a/drivers/crypto/qat/qat_crypto.c b/drivers/crypto/qat/qat_crypt=
o.c
index 861679373b..daa36c5eed 100644
--- a/drivers/crypto/qat/qat_crypto.c
+++ b/drivers/crypto/qat/qat_crypto.c
@@ -53,9 +53,11 @@ qat_cryptodev_info_get(struct rte_cryptodev *dev,
                         qat_qps_per_service(qat_dev, service_type);
                 info->feature_flags =3D dev->feature_flags;
                 info->capabilities =3D qat_private->qat_dev_capabilities;
+
+#ifdef BUILD_QAT_ASYM
                 if (service_type =3D=3D QAT_SERVICE_ASYMMETRIC)
                         info->driver_id =3D qat_asym_driver_id;
-
+#endif
                 if (service_type =3D=3D QAT_SERVICE_SYMMETRIC)
                         info->driver_id =3D qat_sym_driver_id;
                 /* No limit of number of sessions */
@@ -168,8 +170,10 @@ qat_cryptodev_qp_setup(struct rte_cryptodev *dev, uint=
16_t qp_id,
         for (i =3D 0; i < qp->nb_descriptors; i++) {
                 if (service_type =3D=3D QAT_SERVICE_SYMMETRIC)
                         qat_sym_init_op_cookie(qp->op_cookies[i]);
+#ifdef BUILD_QAT_ASYM
                 else
                         qat_asym_init_op_cookie(qp->op_cookies[i]);
+#endif
         }

         if (qat_private->cipher_crc_offload_enable) {
--
2.52.0


--_000_DS0PR11MB745842CEBFACEDBA05C1CE6181232DS0PR11MB7458namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 16 April 2026 11:25<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Ji, Kai &lt;kai.ji=
@intel.com&gt;<br>
<b>Subject:</b> [PATCH] common/qat: add asym crypto disable option</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The Asymmetric crypto QAT PMD can now be disabled =
independently.<br>
<br>
Example:<br>
meson setup build -Ddisable_drivers=3Dcrypto/qat/asym<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/common/qat/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 23 ++++++++++++++++--=
-<br>
&nbsp;drivers/crypto/qat/{ =3D&gt; asym}/qat_asym.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 0<br>
&nbsp;drivers/crypto/qat/{ =3D&gt; asym}/qat_asym.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 0<br>
&nbsp;drivers/crypto/qat/dev/qat_asym_pmd_gen1.c&nbsp;&nbsp;&nbsp; |&nbsp; =
2 ++<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c&nbsp; |&nbsp; 2 ++<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c&nbsp; |&nbsp; 2 ++<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c&nbsp; |&nbsp; 6 +++++<br=
>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c&nbsp; |&nbsp; 2 ++<br>
&nbsp;.../crypto/qat/dev/qat_crypto_pmd_gen_lce.c&nbsp;&nbsp; |&nbsp; 2 ++<=
br>
&nbsp;drivers/crypto/qat/qat_crypto.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++++-<br>
&nbsp;10 files changed, 41 insertions(+), 4 deletions(-)<br>
&nbsp;rename drivers/crypto/qat/{ =3D&gt; asym}/qat_asym.c (100%)<br>
&nbsp;rename drivers/crypto/qat/{ =3D&gt; asym}/qat_asym.h (100%)<br>
<br>
diff --git a/drivers/common/qat/meson.build b/drivers/common/qat/meson.buil=
d<br>
index 31e06f4376..7f12f2b09d 100644<br>
--- a/drivers/common/qat/meson.build<br>
+++ b/drivers/common/qat/meson.build<br>
@@ -13,6 +13,9 @@ qat_crypto_relpath =3D '../../' + qat_crypto_path<br>
&nbsp;qat_compress =3D true<br>
&nbsp;qat_compress_path =3D 'compress/qat'<br>
&nbsp;qat_compress_relpath =3D '../../' + qat_compress_path<br>
+qat_crypto_asym =3D true<br>
+qat_crypto_asym_path =3D 'crypto/qat/asym'<br>
+qat_crypto_asym_relpath =3D '../../' + qat_crypto_asym_path<br>
&nbsp;<br>
&nbsp;if disable_drivers.contains(qat_crypto_path)<br>
&nbsp;&nbsp;&nbsp;&nbsp; qat_crypto =3D false<br>
@@ -26,6 +29,12 @@ if disable_drivers.contains(qat_compress_path)<br>
&nbsp;&nbsp;&nbsp;&nbsp; set_variable('drv_' + qat_compress_path.underscori=
fy() + '_disable_reason',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'E=
xplicitly disabled via build config')<br>
&nbsp;endif<br>
+if disable_drivers.contains(qat_crypto_asym_path)<br>
+&nbsp;&nbsp;&nbsp; qat_crypto_asym =3D false<br>
+&nbsp;&nbsp;&nbsp; dpdk_drvs_disabled +=3D qat_crypto_asym_path<br>
+&nbsp;&nbsp;&nbsp; set_variable('drv_' + qat_crypto_asym_path.underscorify=
() + '_disable_reason',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'Explic=
itly disabled via build config')<br>
+endif<br>
&nbsp;<br>
&nbsp;libcrypto =3D dependency('libcrypto', required: false, method: 'pkg-c=
onfig')<br>
&nbsp;<br>
@@ -88,6 +97,7 @@ sources +=3D files(<br>
&nbsp;includes +=3D include_directories(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'qat_adf',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_crypto_relpath,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_crypto_asym_relpath,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_compress_relpath,<br>
&nbsp;)<br>
&nbsp;<br>
@@ -108,9 +118,8 @@ cflags +=3D no_shadow_cflag<br>
&nbsp;<br>
&nbsp;if qat_crypto<br>
&nbsp;&nbsp;&nbsp;&nbsp; foreach f: ['qat_sym.c', 'qat_sym_session.c',<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'qat_as=
ym.c', 'qat_crypto.c',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'qat_cr=
ypto.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_sym_pmd_gen1.c',<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qa=
t_asym_pmd_gen1.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen2.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen3.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'd=
ev/qat_crypto_pmd_gen4.c',<br>
@@ -119,6 +128,14 @@ if qat_crypto<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sources +=3D files(join_pa=
ths(qat_crypto_relpath, f))<br>
&nbsp;&nbsp;&nbsp;&nbsp; endforeach<br>
+&nbsp;&nbsp;&nbsp; cflags +=3D '-DBUILD_QAT_SYM'<br>
+&nbsp;&nbsp;&nbsp; if qat_crypto_asym<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; foreach f: ['asym/qat_asym.c',<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'dev/qat_asym_pmd_gen1.c',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sources=
 +=3D files(join_paths(qat_crypto_relpath, f))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; endforeach<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cflags +=3D '-DBUILD_QAT_ASYM'<=
br>
+&nbsp;&nbsp;&nbsp; endif<br>
&nbsp;&nbsp;&nbsp;&nbsp; deps +=3D ['security']<br>
-&nbsp;&nbsp;&nbsp; cflags +=3D ['-DBUILD_QAT_SYM', '-DBUILD_QAT_ASYM']<br>
&nbsp;endif<br>
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/asym/qat_as=
ym.c<br>
similarity index 100%<br>
rename from drivers/crypto/qat/qat_asym.c<br>
rename to drivers/crypto/qat/asym/qat_asym.c<br>
diff --git a/drivers/crypto/qat/qat_asym.h b/drivers/crypto/qat/asym/qat_as=
ym.h<br>
similarity index 100%<br>
rename from drivers/crypto/qat/qat_asym.h<br>
rename to drivers/crypto/qat/asym/qat_asym.h<br>
diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qa=
t/dev/qat_asym_pmd_gen1.c<br>
index 20001bd1cc..c96608dd37 100644<br>
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c<br>
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c<br>
@@ -112,6 +112,7 @@ qat_asym_crypto_set_session_gen1(void *cdev __rte_unuse=
d,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;RTE_INIT(qat_asym_crypto_gen1_init)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN1].cryptodev_ops =3D<br>
@@ -121,3 +122,4 @@ RTE_INIT(qat_asym_crypto_gen1_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN1].get_feature_flags =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_a=
sym_crypto_feature_flags_get_gen1;<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen2.c<br>
index f20d367404..89c51c8f80 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen2.c<br>
@@ -336,6 +336,7 @@ RTE_INIT(qat_sym_crypto_gen2_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_create_security_gen1;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;RTE_INIT(qat_asym_crypto_gen2_init)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN2].cryptodev_ops =3D<br>
@@ -347,3 +348,4 @@ RTE_INIT(qat_asym_crypto_gen2_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN2].set_session =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_a=
sym_crypto_set_session_gen1;<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c<br>
index c196cf3cdb..91546046f1 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
@@ -800,6 +800,7 @@ RTE_INIT(qat_sym_crypto_gen3_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_create_security_gen1;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;RTE_INIT(qat_asym_crypto_gen3_init)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN3].cryptodev_ops =3D<br>
@@ -811,3 +812,4 @@ RTE_INIT(qat_asym_crypto_gen3_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN3].set_session =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_a=
sym_crypto_set_session_gen1;<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c<br>
index 52577f6907..41cad29142 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c<br>
@@ -115,6 +115,7 @@ static struct rte_cryptodev_capabilities qat_sym_crypto=
_caps_gen4[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_END_OF_CAPAB=
ILITIES_LIST()<br>
&nbsp;};<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;static struct rte_cryptodev_capabilities qat_asym_crypto_caps_gen4[] =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_ASYM_CAP(MODEX,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0, 1, 512, 1),<br>
@@ -159,6 +160,7 @@ static struct rte_cryptodev_capabilities qat_asym_crypt=
o_caps_gen4[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64, 5=
12, 64),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_END_OF_CAPAB=
ILITIES_LIST()<br>
&nbsp;};<br>
+#endif<br>
&nbsp;<br>
&nbsp;static int<br>
&nbsp;qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,<=
br>
@@ -202,6 +204,7 @@ qat_sym_crypto_cap_get_gen4(struct qat_cryptodev_privat=
e *internals,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;static int<br>
&nbsp;qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_private *internals,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const=
 char *capa_memz_name,<br>
@@ -239,6 +242,7 @@ qat_asym_crypto_cap_get_gen4(struct qat_cryptodev_priva=
te *internals,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
+#endif<br>
&nbsp;<br>
&nbsp;static __rte_always_inline void<br>
&nbsp;enqueue_one_aead_job_gen4(struct qat_sym_session *ctx,<br>
@@ -622,6 +626,7 @@ RTE_INIT(qat_sym_crypto_gen4_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_create_security_gen1;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;RTE_INIT(qat_asym_crypto_gen4_init)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_V=
QAT].cryptodev_ops =3D<br>
@@ -637,3 +642,4 @@ RTE_INIT(qat_asym_crypto_gen4_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_GEN4].set_session =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_a=
sym_crypto_set_session_gen1;<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen5.c<br>
index 5714420e1e..2680116d6e 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c<br>
@@ -224,6 +224,7 @@ RTE_INIT(qat_sym_crypto_gen5_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_create_security_gen1;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;RTE_INIT(qat_asym_crypto_gen5_init)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN5].cryptodev_ops =3D<br>
@@ -235,3 +236,4 @@ RTE_INIT(qat_asym_crypto_gen5_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN5].set_session =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_a=
sym_crypto_set_session_gen1;<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c b/drivers/cryp=
to/qat/dev/qat_crypto_pmd_gen_lce.c<br>
index 7298916f2a..ec075bbf68 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen_lce.c<br>
@@ -301,6 +301,7 @@ RTE_INIT(qat_sym_crypto_gen_lce_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_sym_gen_dev_ops[QAT_GE=
N_LCE].get_feature_flags =3D qat_sym_crypto_feature_flags_get_gen1;<br>
&nbsp;}<br>
&nbsp;<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;RTE_INIT(qat_asym_crypto_gen_lce_init)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN_LCE].cryptodev_ops =3D NULL;<br>
@@ -308,3 +309,4 @@ RTE_INIT(qat_asym_crypto_gen_lce_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN_LCE].get_feature_flags =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_asym_gen_dev_ops[QAT_G=
EN_LCE].set_session =3D NULL;<br>
&nbsp;}<br>
+#endif<br>
diff --git a/drivers/crypto/qat/qat_crypto.c b/drivers/crypto/qat/qat_crypt=
o.c<br>
index 861679373b..daa36c5eed 100644<br>
--- a/drivers/crypto/qat/qat_crypto.c<br>
+++ b/drivers/crypto/qat/qat_crypto.c<br>
@@ -53,9 +53,11 @@ qat_cryptodev_info_get(struct rte_cryptodev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_q=
ps_per_service(qat_dev, service_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info-&gt;feature_flags =3D dev-&gt;feature_flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; info-&gt;capabilities =3D qat_private-&gt;qat_dev_cap=
abilities;<br>
+<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (service_type =3D=3D QAT_SERVICE_ASYMMETRIC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-=
&gt;driver_id =3D qat_asym_driver_id;<br>
-<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (service_type =3D=3D QAT_SERVICE_SYMMETRIC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-=
&gt;driver_id =3D qat_sym_driver_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* No limit of number of sessions */<br>
@@ -168,8 +170,10 @@ qat_cryptodev_qp_setup(struct rte_cryptodev *dev, uint=
16_t qp_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; qp-&g=
t;nb_descriptors; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (service_type =3D=3D QAT_SERVICE_SYMMETRIC)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_s=
ym_init_op_cookie(qp-&gt;op_cookies[i]);<br>
+#ifdef BUILD_QAT_ASYM<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qat_a=
sym_init_op_cookie(qp-&gt;op_cookies[i]);<br>
+#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qat_private-&gt;cipher=
_crc_offload_enable) {<br>
-- <br>
2.52.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB745842CEBFACEDBA05C1CE6181232DS0PR11MB7458namp_--
