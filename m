Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CC2CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 09:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87EE3402A6;
	Wed, 29 Oct 2025 10:32:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id E001F40288
 for <dev@dpdk.org>; Wed, 29 Oct 2025 10:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761730338; x=1793266338;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Dc8913F+UU037BOSHJz5v2IAj9fmnNqrFg45ksfSNYc=;
 b=LnWYweeQbyux6RsDqYS0fnYLX03GwotJ4TuLky+qkt9gIoHFgEJoQX/M
 cWZbGB4hOhBaSMYHcc2QGn2NtqGKxkCaU8F0Txxv05KpR/Br/fdlUQlDW
 ZMXM9yOwR53g+ItQadrwhLElCkOWKkPoPq/SXOLXns3ObSCKBAdOLgdnR
 kyAXqSBGU5zVUYxbvg69m6ZHBPo0kBhcIjq1Zzj8i0FGb/8Ybp3MDRbBV
 aw16vf/K4kgSTBEpczHvGtrHuJRCCI+y54KwBHqm2XDTjp+GERruipj51
 4nYiGtrt7UQbz1OgVYH+/RVcXJqfpngwPP4pG5DiboGS86VTegbFkmiIh Q==;
X-CSE-ConnectionGUID: slwR9V1aTyynkTvlz+Bojg==
X-CSE-MsgGUID: jR6RmxA3TzCHOfg9O9UM7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89315398"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="89315398"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:32:16 -0700
X-CSE-ConnectionGUID: zqGcu9IZR+WJlwLzisvcVw==
X-CSE-MsgGUID: UVDbdWLUTdWx/8AcH11ViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="222821532"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:32:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:32:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 02:32:15 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 02:32:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzkYbrgImefO9gRruCWWG+6AgQjkF+JDdlHHNYb2sGPMvRmIiFxP98a9Cty0Mk2z/BcyskeRYNYdxyZRJ1aCxyTb8sKYMC0LCOwqPLZqTH5fKfQ0TNAIxyXvbEbG8MSCbQbkh0ZGKtowfEUBoajEVpgCZ1DcRr/LrEavvtnEgKDGBmev1gfHZCUXPVmbT6YIpcPzovwr0kqHGNFXlyFgdh8v3VH/e51XUzH9cubqS9v7RnXD1Q9vrJuniL9VidqodXcOxB9lyptsVBOps3DZdsfYQpPVzDHlXImv/Al1VRyWnP+5ECY/56cUt73Xbop8gyofZGgHtZo2kdHglnHYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sS6BT2BR9JvTDh0QzhrlteummBHUXT7+t0ZoM8N4taw=;
 b=oomzyYV0QpKbz5Y8cClY1yKv6tJ9PEE+4FIOg3CZnwJQf7liWCbGmNIl2ljWd/1S5ro3jbr2o5ShPQz6W4hx8+Ms7ezPH0f1nqTPeXULCG2V+XveKZQ9ilhamJL+AswyWSSfeJlFSW7jCsrHtfUrsNFP08ATa+yUiBsXVJ6vFMJhIsoXruQJMTTGJ/mCFvxM3O8RVl0oWzKTzKuT1KJU3C+0mAGvgAZLTILclshDnpTmtSGL27n5SmS+NNibCdUQu3uhRm51UatZZupRZsXbx59pYZZwhLIlwdqZtgSvkZrsEd7a9oWkUWd8xh5gh+UjTeCfBxj1kjgEuFSRej9rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH0PR11MB4888.namprd11.prod.outlook.com
 (2603:10b6:510:32::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 29 Oct
 2025 09:32:14 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 09:32:14 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "mtahhan@redhat.com" <mtahhan@redhat.com>
Subject: RE: [PATCH] doc: update feature matrix for af_xdp
Thread-Topic: [PATCH] doc: update feature matrix for af_xdp
Thread-Index: AQHcRTgH1y+emKuJn0u68lK/119sorTY4xVg
Date: Wed, 29 Oct 2025 09:32:13 +0000
Message-ID: <DM3PPF7D18F34A112529DA8A62EFEDD72648EFAA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251024224612.343720-1-stephen@networkplumber.org>
In-Reply-To: <20251024224612.343720-1-stephen@networkplumber.org>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH0PR11MB4888:EE_
x-ms-office365-filtering-correlation-id: 1c3dab06-e681-4b50-82eb-08de16ce0b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?fzD8JiQHWXCtQ8EB/qSifM1VMWZMmnwOeWdiyqhNyDGXZv5r/Df0TUJkRiiD?=
 =?us-ascii?Q?0Fzwa/b4298pzikORdwBPkI5AINoUz8VlAqMSqsqHf7PfB4I4qcPM+bK8Wq/?=
 =?us-ascii?Q?Hjb21OqQusMoWN0bd+fgICupHfYoGaGbSBka7161+q14EwlQysnO/B80iMN4?=
 =?us-ascii?Q?lDMIm9Jvz3G8JgAVQvM1fsc7YVh3suKehhaUurGbvQ72S18UW9zdlafcKhiW?=
 =?us-ascii?Q?SVvmP21wHQJPecMoLPtvRQxvMkY/pGRHC7eoq/7YLjc1F+7lRMpHyRZLgHUy?=
 =?us-ascii?Q?+giOEQbk7EKcbAiBdHY7XgqLSNTymEuXYNgG/q6VDECsINNe3ItJvuAi4LXo?=
 =?us-ascii?Q?JqIF/lhu2dMU+4CCNw5aG6Re6WCiHfxaojo7VPmaR/Z3SmS1tdhFxE3uqr4U?=
 =?us-ascii?Q?00c1km4SmcuHRZL8OsIGhaVldrWmMhswZVB2dDNJdWx2xkymHHRWfHFx9/q7?=
 =?us-ascii?Q?OU1ZSIJ19cOhpwp4yicHZrVZhMsKQoEnaJFnnD4wYbdOh3RdWdLHtX/it/dz?=
 =?us-ascii?Q?zoB2+/4Lp4dG159xBhYuVyWHO0KGA7/FYFQvjsmcOMHI5AhNzUWQEbbTHpuZ?=
 =?us-ascii?Q?uYIJq8j6GtVQK8K2maRMrOtlvHdEzNHI9Si408b52s3DhUI+q+sFqt+QJHG2?=
 =?us-ascii?Q?btkQnQKY/3y5FGm6xF8YDJDsLDuri80uHQH+ynGKlDgNI4JUQmFsxwYfhXrw?=
 =?us-ascii?Q?kyg5RPMuCmllWYz3G3ZcTjYZsYySoOe09xUVLzC4WKF+MwfT39Rw6YppvhQB?=
 =?us-ascii?Q?QV9d7aZBWAYrxmQ5llDHMMIAgyAZj0GrENdWaqKbAEE/InQwSMhSxcnQ82NU?=
 =?us-ascii?Q?QFHv7wK3muP8JMGsQ6KzTXS/RxDAK2DPSYISreHJoKYgrSlptSexpIrYZNGL?=
 =?us-ascii?Q?xBoBasX/fM4BxiBEaJQ/ix00DnR5v2TUmJ1PIVvOJMzJWfJSXsiBmQ4pjOj3?=
 =?us-ascii?Q?/7eCUvIToqijSXNFRkFEn0IZoT6WEpb1LA6Y7WQB7UhGJrG6GI/q8GAtShK7?=
 =?us-ascii?Q?LTlgcwEagQ3pMJ9T4crikiyRf2BE2pkDC4gkIZgSvgSLFTxJsJ1AMTJiS0nN?=
 =?us-ascii?Q?Mg7+hDHligNuyDm98Cza8wWWPYSWyGVzQz2i9NTGAh9JYeeq1UJ9dvi3CT4/?=
 =?us-ascii?Q?Pp5Aa4C40adhqX4ZW+MalSfNMCHSl3oWVQSixHVgVFhFcFKi7EA7/6vabwsk?=
 =?us-ascii?Q?OTDIvYynwv0IpgE4NYdm91uucguHjbtVWazg1q7KCJThC7xIC4EOJsEJltyr?=
 =?us-ascii?Q?SgXcUpRY2K+v9v2D0r+qnuK6FUOWjx9RSanCxT08Tn+FGZkZA/sgI/UHXKH0?=
 =?us-ascii?Q?OsVpoRc+MK9D7AZ8NAKwUTWqHCII7pkWKbsCdWB+Rlxxrsqa05Qnzpd6Nrb/?=
 =?us-ascii?Q?EN6nvnAvmEDG+FWDRQS0790Es73cosODWwrupi9fQyjAGZjyg85CJNQAG9Ec?=
 =?us-ascii?Q?/TgKMdyOknXevlBnRWFswF9W46u6y4DTLkvWzqxSNEPszH2WJingwhv2p24y?=
 =?us-ascii?Q?xXJoQNfQ29L9s9AC608jqSEvTYtycPGg7/47?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cMLV61QecFPU/r7uMbLHLIqzU2Jo3TYfTlEcK+BlWspdGvuFwZ8SbgXgq6rV?=
 =?us-ascii?Q?ao96cIQ3JYVCrtOubNHqNGoL5/9YXS22zc5w2aw9IInrmXiv4iB03Fsl4rsh?=
 =?us-ascii?Q?qfEdECzC9OpOAnGqvdpjdhyynggDOZO3DP1ZFvebnNY/vBpAdS3SgJGFByK6?=
 =?us-ascii?Q?lYes7+vS+vHxUzZWF44zeIFbHIduT8oHDaiv/peFpC8cJxn9/X2b7sTRU4rE?=
 =?us-ascii?Q?ffnONAjyE0rGoH8LW/Gmx8YZk9awP2KzLt/KwCcBoxLvG3DJ8Oi/f6mTeTjt?=
 =?us-ascii?Q?mQ5BWEmyfVZnPhTvYjIHT0T2R+/MdWatTY5KAXr3lhUkz63SPCoy3f4UC6iR?=
 =?us-ascii?Q?C86uTooGL0ZZGDBnXDwb5OK9qCLjCzG/XbCv87L2nq3CfQ99dh65/CF5j6kS?=
 =?us-ascii?Q?4VvzkxQapje3LlTDhG0tc7OAr0jYMm1Lhp04RkiM/QPjLI14LwkZIJhtVYTs?=
 =?us-ascii?Q?sAlWO0QDoYjmBp54LKI5Yb24tGF6IX34iCDdRWHv6DiyWdHn4tEOe6fiQ4QK?=
 =?us-ascii?Q?aDes3o1VqOfoVMyhou+gbWy12ikU8UtOt3TIA3y37x+4VLdozl185sNZ8u88?=
 =?us-ascii?Q?24PlSVEZ+ipgP01i3K5Bei717OCfkzc2oao/IauX4UX0bdJ5YG4t3sTqGAa0?=
 =?us-ascii?Q?iMmUU9b2KRij3sctHDZ+qZmoWo8sRJN9XtmvUJ8WrIwjJVIyb41n3+ScaMtX?=
 =?us-ascii?Q?VIc38cv5viAMeJDySllPssSr2D/JJZ7EfoHM1tkSPQ0LKpCHprDm9+Ur63QJ?=
 =?us-ascii?Q?0jKU5Nc4F9xcyErNgde/co5gBAaECB8HcZJTGGF3GBbr+20KnuMY5hMTWnjb?=
 =?us-ascii?Q?+jWmMs3bSOSCv/8sI4z8PRcolMKkDmjCwxvf+Xtl2YRtp5TFBbV1dc8tB6Sa?=
 =?us-ascii?Q?G6NtLvnxPy+TTZGMcxDM8JM0EelWZD4c6cCsOsXnEyOn2UXyzBOAZj4yqYpE?=
 =?us-ascii?Q?e0V9qpPdGUY80wWS+U6LNTCqC6f3huoLLEz0GofUVcC13u84CmT29EcEyrVx?=
 =?us-ascii?Q?h1oA9RQtXR4FhviPJfdrRbZo8gxTBCA6/sShOGu1n5KCHQdCvogiTrJgXY/N?=
 =?us-ascii?Q?DMm32hJV6k2UIkSQ+qJNz4uT9lGEPoI73lUkYBdpAsMs2AFezjnvGDNCg+8y?=
 =?us-ascii?Q?teX6krGZp/LBVzyTi9/O7THBAiwc80XHyGlPFWJ1jT+VXY41rqq+Nl+j8j8d?=
 =?us-ascii?Q?73o2VIsUzePn276kTtu7hQe0ovk3guz3gTglLZfeHe8FdhulHgO5JFFOjH8L?=
 =?us-ascii?Q?D5N4IF0wL/eQbz1XqiASNpFawThdsM8nWuLH7YPpLOx/Ld/VV3fCW5/jpgc8?=
 =?us-ascii?Q?HLI9gpTU8FKEVo7b/isu6oyiOFgtj06Mhy4BzJZjCykhddWcAtlgTpHQ6teE?=
 =?us-ascii?Q?5kLf0z8FbaDt/6pPrx/smK5r1Kt02EYr7quhTFfjFur2iE4of8i8Rfg9b+LI?=
 =?us-ascii?Q?jUnop4rzNdUNKjMrd5+bDg7YqtCKCj3QTSXajAprIUjZmXIdNu2CEVqsqdhs?=
 =?us-ascii?Q?smzx9+ThszszbJwaac4wXLG1zb+q+WOdAzxiu80mUS06RTvCcvq7DyFw8+2v?=
 =?us-ascii?Q?h27Qhh6vRqJmgrbYienzeBbuFTV1wQzqiY7bVnva?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3dab06-e681-4b50-82eb-08de16ce0b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 09:32:13.9756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtJBVsVqMbflBLzFWlxfuZ6u7RGueQxlp2Fj4zPjBXC0sIaCVLebDRoDjwsbRjlHCts7qbGjqhsl6ukTFuZd3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
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

> Subject: [PATCH] doc: update feature matrix for af_xdp
>=20
> The driver does provide stats so fill in the feature matrix.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  doc/guides/nics/features/af_xdp.ini | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/doc/guides/nics/features/af_xdp.ini
> b/doc/guides/nics/features/af_xdp.ini
> index 8e7e075aaf..d2461dacfa 100644
> --- a/doc/guides/nics/features/af_xdp.ini
> +++ b/doc/guides/nics/features/af_xdp.ini
> @@ -8,6 +8,7 @@ Link status          =3D Y
>  Power mgmt address monitor =3D Y
>  MTU update           =3D Y
>  Promiscuous mode     =3D Y
> +Basic stats          =3D Y
>  Stats per queue      =3D Y
>  Multiprocess aware   =3D Y
>  x86-64               =3D Y
> --
> 2.51.0

