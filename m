Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196A2C43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 09:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01D534025E;
	Tue, 30 Jun 2026 11:26:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 290E34021E
 for <dev@dpdk.org>; Tue, 30 Jun 2026 11:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782811565; x=1814347565;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2ITHi9S0IPlkAV9kX/rScK5BjillIYkESHie+MOuF5s=;
 b=murRHUWqLIa5h4dol/rvli1QGvJ4pUYSZq+7Z2+qDWA12KF0EoRSEVT5
 Gllda6m0qY03xYUpUGcEmO5UIKJHu2ZKhM3Phqi1RcWiNZF5AAdywQLBk
 x1n0EZCmuRFBbf6EGBJw8VT1rlP+yF8sb3R+PtHB3YPw8lLK+QSt5kUTk
 TnS1y2B4SvcNju6jKPB6ATOkjXO2ax2B2R4u5BdmcLUqN1gS6n2hkITYV
 z2P9pO7AoKIijyCe0B7c+BypcueCc2G0pe71K9DiomR8XBdMkXaJyKd8p
 4XpOFF1aQlLRd3gWB63QsnxMugvbJvom0doM4NXk0NRqV4H8tx4Xgtlxg A==;
X-CSE-ConnectionGUID: +WZedt4+Qu+SxBCz6edCIg==
X-CSE-MsgGUID: gM3nBh7ZSByVQFmCtYtGPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82631739"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="82631739"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:26:03 -0700
X-CSE-ConnectionGUID: ei1DYWdTTHa+4+dEg3iRNw==
X-CSE-MsgGUID: 774NvelgTfiufH0WbYyG8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="254130018"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 02:26:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 02:26:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 02:26:01 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 02:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFbjvPrdnTDkzWYXKC+Q4Pexga1Q6SpnQDJx0B6wjPRSwWRSx75DQf/NtHv5IlBKmyWZfukwMt+O8jzGiMw1N4MDzDF34le2nlMV0ryc7enYhRBHxxYKaaU/YxIEvNjqZf7jwgGlY0xeN/M6NyxspXbxG5sjdVVz8qNsE1ytcXDEI7P51YCOQT5rB1DwR8ekyeUpvltTdDqH1N/HNRHeawrBK6Jw2c3pChe37Sdq7t3MuFk9jqCCkgJ2JqxF4C89OiCfl4XUOHQLEabFMbOfvAMf8guNLSAKUZMrkdbK7IoNFq7s22yqJMg+xUoWtxyUm+hLOe9CNJnsKnHSqGwkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ITHi9S0IPlkAV9kX/rScK5BjillIYkESHie+MOuF5s=;
 b=f5cQDUMRhux5ZNy9mFqT+pkjt4BUhJcmuV1ZfQOFOfQfmVzVj72s7p9d2KWgTReKy6KHD0eDvAUCR7+Dhk3+uEARoYP2IGNvod9+wtJx3/0Zxw0uWjAgC/OzsodIh8NTB0c+2rz9Gtj69wjeZaMpp4XeOj7+vm5LzI0q+OLl1+CHZjWR6ZgASa6kCLiiAkW6Gg5sedgrK7WURa549Xr5cGHzieOzwAQU2394Dax3FWO1q9M0WTSuPVYuNGz8zEvakt0/QkbR80I7p30i641fruzMYVlpLiAevbceKL9KP5n8+SpWwZ+mRp0egH93MR/YaZtd5C77o1VxzgGsJetcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8)
 by MW4PR11MB5798.namprd11.prod.outlook.com (2603:10b6:303:185::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 09:25:58 +0000
Received: from IA0PR11MB7862.namprd11.prod.outlook.com
 ([fe80::3b4e:43a6:6e22:22f]) by IA0PR11MB7862.namprd11.prod.outlook.com
 ([fe80::3b4e:43a6:6e22:22f%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 09:25:58 +0000
From: "Finn, Emma" <emma.finn@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "gakhil@marvell.com"
 <gakhil@marvell.com>, "Ji, Kai" <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v3] crypto/qat: require IPsec MB for HMAC precomputes
Thread-Topic: [EXTERNAL] [v3] crypto/qat: require IPsec MB for HMAC precomputes
Thread-Index: AQHdAhy4T9r9kx+GL0C1lPwOCfP9nbZOJRIAgAd/9oCAATqpsA==
Date: Tue, 30 Jun 2026 09:25:58 +0000
Message-ID: <IA0PR11MB7862DF87FDBAC65E28B924F2EAF72@IA0PR11MB7862.namprd11.prod.outlook.com>
References: <20260619135330.1821985-1-emma.finn@intel.com>
 <20260622075651.1980461-1-emma.finn@intel.com>
 <CO6PR18MB4484479022C9D2E2AEF13363D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
 <460428e2-1508-4712-8457-104a479df80e@app.fastmail.com>
In-Reply-To: <460428e2-1508-4712-8457-104a479df80e@app.fastmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7862:EE_|MW4PR11MB5798:EE_
x-ms-office365-filtering-correlation-id: ccdc9b14-44cf-4da4-63e6-08ded6899824
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|38070700021|6133799003|11063799006|56012099006|4143699003|22082099003;
x-microsoft-antispam-message-info: 5EpnZ2G9Rsp7rhtAyq6uUoghkFUTpNdTS0uLp+UoBWkkq5EQoiMounmTjwzj8YuYvHPougJZ4ywMQI47MSlmmIZsgL+Vux5DZ6VxqyWjXpudm3nXeVEr2GnyW4ziw/rjHaptf1CzQ7fCVyTviF3hGQCWItVpT6zHu1vnYI5HQU+9ayDR1xB49/hptDxsOKwoVJMFK5RJJg+XgpCgnxCakapCoZGrCHSFoBeZeHniJQdSU8w7OLZNXYxRtPnrQ21qDVPic4E7PzQ2tGF05NnJLovXefcyra7qUQ3BhZZ69uHqJtRW9ybmVqMJwDTLZk2vRFIpTaK2yD/mSJLIdYxnilAK4vps06tKvg5FoNmC4i6/nkA/1P4Tx9o+SoXVN1i/5eo3XoVoHmBYZj6rlV0gwEmcIFNyiHtwxLGh+HFFAw925MZusQZOuy5Ng3qwhAUxa4Uhy1gd08Bg46XGR1qkL5hm4YFDAbOW1Wgwwj+LzH1lWv3sXqRGrGpP3NxJS8hch+/06t2/awfYNOeuq+tRlaunUFCoLl2Wa94g3EZifTqwK+gMdDwrnEELisn1Dr3lQFaL675ZAqIikgFKMkbimqt+rWIAfwJs0scK9mXSc9VHftrojDHQDDaVJ40Ny0zqAduJZDicx0mhEfPSJFrTRGid6R4PIPrKfZVgb38Vuyhtm+ZllwrpbUi9NWHYnAadQc1FaOiTpZBBcQeVX0WXNzYRFmI0ekDdR+RbLf5n/R0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7862.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(38070700021)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kzRLVTZ1sIqCwWXF3rag4fFadRgAgUrANDfDzEtfx7LmkP+yXY9CcC4I+qGV?=
 =?us-ascii?Q?IwAyDSACYvn9f/1kmLfcKxdTNSGWtBOZtuFeKPmlCQJx35yQymjSXtMKHjli?=
 =?us-ascii?Q?YkJjT/PIvhN5mVN8wIr/fHL6kStFKx8LG0Xti3NK6DZAjQOV6yDASBpBi/Tx?=
 =?us-ascii?Q?1MN3+6juxX9tu+Xj8Hl7UxUwpro1i9BKiswPHae3fCu73dVD7L6OPksOPvQa?=
 =?us-ascii?Q?IOt0MbbpGbeBtzY93LYVD0stmzJGRjA3BZ7ohnHgj/KmjxqxCeky1aMeVmPY?=
 =?us-ascii?Q?jxv8bNO0LNwAqo99308v3Pgug1b33r5tZbEOSiw2gJbxk3AZ+hdYlTuEg462?=
 =?us-ascii?Q?m9Ljv7RoXGK6gBqkDX5BpaIeUAXSnHd7ie5Xe1ycG/iFsdb6G11Plem3DREa?=
 =?us-ascii?Q?0TcTi6aQBjx1O7oRE6JmON42SD5T90Taz6y/vnt9Bzm8OeZQ+lAU6qtBh4M4?=
 =?us-ascii?Q?YWyA4Z9RIg2vTyu3TyatYUpCqLmoZcDibCGM8tQSRJQO1oNtGith3Dn8xOQf?=
 =?us-ascii?Q?9vu3XW1Gknm76Y2DYIRPEnE2vzchj5mglciykcIWUgow0LrEp897GH9/GUn4?=
 =?us-ascii?Q?ChUOeMfHJkXpqZWyIBcDeILosBoTVG8yqUUyW6zWW/bAXT+UK8ql8fHl+Min?=
 =?us-ascii?Q?8L5GQGABALqwuinvQYMRTkuzofLHCvik6/lLFTC4xwjJWb2wotw8YmzEiKqc?=
 =?us-ascii?Q?FGUN3WMwBBZGciXSA5RLo/mFGmYFmoJqGL2MjWqecG1i4LeaXDKdr/LY10SE?=
 =?us-ascii?Q?957mVTdkUzrhqhg/JSnbYZfK7MgJG3Yj/fe30nUk7lhRavES8DMPNQv7Nw1X?=
 =?us-ascii?Q?azXTmxc07Pg7MOSJiJPwj2DXvrxXPQppJ+diHo4KgC7VgWM0vdAf3puE2v4A?=
 =?us-ascii?Q?lSQyW+c4QvDLqYCwGhxn/X+d5aBgYLWdvmMt6UaN5OLM05jvSAvZcPFEegma?=
 =?us-ascii?Q?8XevsvuhSSDVX8UOk/yY/Tgz3fz+u6ILo1MhoXBRcDLnPYzmriv3VQtqhrJn?=
 =?us-ascii?Q?93R7rlMDDm65ZZFQ7mjciYyFG98HDednFmzRdUUUv6ZzgQ0N1h05MFyZ/1I6?=
 =?us-ascii?Q?Zr44/SjoizedZAZQJGfk/Jda/pQ05QnaIrHPGMoVtOF6mhnjzP2tAhC59n74?=
 =?us-ascii?Q?/Y3oxxJHE/ucF4+iOR3n+PuK9ckKqbhDzYUVdQpxbpKoavVao5H/ykmWVGWp?=
 =?us-ascii?Q?Il+3OL+5r/mVXKNgpJAOj8/TTe66VN07SR4w5mtq5KFxzf+GFznbg0zijm7w?=
 =?us-ascii?Q?YDypJjZKMYQqIalKIGHNSSYiHUjqFaJd0zFxChNEOqxD//YC2L7NEL/nhR7N?=
 =?us-ascii?Q?2fwBeUHDT2Dspir+g5sBeOQP3qD5WckBNQCsutqQJ3QblMuufhD15S8Twe9O?=
 =?us-ascii?Q?+YpyWzjOkxtJXNLK+G3/PexcWx6Xl34HP8leInGBY4xwbAdk2Vp0TfqHIPR9?=
 =?us-ascii?Q?s1IwfxXob0W8SmbxIQ1p3G2t4mBp5M8sWQx2BxxvAhtxEf1WUhadDwSLgBdS?=
 =?us-ascii?Q?km8FcCD6+bf0pjFv5jfQN5ysjfUEMBnU45477LxacVwMJ5DscpUCaEQv2ntd?=
 =?us-ascii?Q?2Ne5ofN6FBiFyRwDW0ic6RZs6OHZPkAn+e1G7K91hcz5upr4/x55yAC1hU1m?=
 =?us-ascii?Q?6CA0GPGEhrqvzJ+4bknl5er4035EVovVD2RcrxU7blL0F2rlLZ/KeEbtdhBM?=
 =?us-ascii?Q?h8KXWBYXYRV46OcZei/DH9cMfyxD5NOMufc/U+Hw8zfAsHtV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JPiRhulZloGYk6UNppt4J4oY+G5kWa12bC2zJDoQYqdrK2JwJA4n9l9IjZ+tFUw0h8KU76hJsGboUiqdXkBTR6f4vODOMfm6rTR1j8UfUwPW6w9/ORz8e0D7CvWzi0R1VlHpC6kA3w25SUdvjezUXDnrnosTMKLHyi+DpRs214y21QaH9Fmo5fXA6SmB7luXDX3ummcO7vftm6fxAr4hFXHCv/KQP9sDOBvm5VLxjuY88I9hc1URCb28wC0UN1PHu/S+t5XbatypWlA+MxwITQzmhEjiIzyzlMaXzf9iHQItSfsPOfxPzs7dWC8ibihtn9//p1lCpqZgKfu02biG3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdc9b14-44cf-4da4-63e6-08ded6899824
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 09:25:58.4147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Mv7jWj37X7HJFEAhSGuKO+mDXS6SGOzelAMXC5C2a8UM4/bNyqbHabd9MECTeIB8a1r0BDpDbK4LEabxiXWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5798
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

> -----Original Message-----
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Monday 29 June 2026 15:36
> To: gakhil@marvell.com; Finn, Emma <emma.finn@intel.com>; Ji, Kai
> <kai.ji@intel.com>
> Cc: dev@dpdk.org
> Subject: Re: [EXTERNAL] [v3] crypto/qat: require IPsec MB for HMAC
> precomputes
> Importance: High
>=20
> >> IPsec MB library (v1.4.0+) is now required for HMAC precomputes as
> >> OpenSSL 3.0 removed SHA*_Transform APIs. OpenSSL remains optional for
> >> DOCSIS BPI cipher fallback via EVP API.
> >>
> >> On x86: IPsec MB required, OpenSSL optional (DOCSIS fallback) On ARM:
> >> IPsec MB required, OpenSSL required (DOCSIS support)
> >>
> >> Signed-off-by: Emma Finn <emma.finn@intel.com>
> >> ---
> >> v2:
> >> * Fix resource leak in ossl_legacy_provider_load()
> >> * Added release note
> >> v3:
> >> * Removed checks for openssl <=3D 3.0
> >> ---
> > Applied to dpdk-next-crypto
>=20
> It does not compile on Arm:
> drivers/crypto/qat/qat_sym_session.h:156:9: error: unknown type name
> 'IMB_MGR'

The header file was missing the IPsec MB include for ARM causing the IMB_MG=
R type=20
to be undefined when the struct field was declared. I will send a patch to =
fix this.=20
