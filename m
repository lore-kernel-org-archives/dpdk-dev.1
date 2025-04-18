Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E99C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 11:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71942402DD;
	Fri, 18 Apr 2025 13:40:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E0E514025E
 for <dev@dpdk.org>; Fri, 18 Apr 2025 13:40:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744976415; x=1776512415;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=edMTwIs72gSpI+kwddqifg3pi8CN9yBQiJ62vRkU/ks=;
 b=aklpyq/QmH+wkwMvlHykOO8TzdO/9dEy0ZcymkYxfmCdQV8KmjScz7oY
 /0oOpgYjIzIIgFRoxYBlfIDfjMerPV3DxyXoGr4O3+bcYLfxDYEod1idG
 uiEEG4/58FijDwI9mTcu4i66/GSNH4yucSBmE8Gjb/5IBJmMvUQu+GBup
 triR8VVB6SvIN9Pt6KpZL5M65xSz/J/gHGY+LyIwvgDiY6GLlQkXdyaGg
 /9nITD0/tnkefkNEzXjJLVPXT/1LpgnqE/rfCcoO7w/L8RgL4P8AtKbFY
 vfvEOg3+dUXsI6UBLWdXlXJAR/FNKzEtWFWKpwLGn7afhkQDFqqnf2Vqu A==;
X-CSE-ConnectionGUID: cwl5F79BS7SW2oqfl9vdHg==
X-CSE-MsgGUID: eX85hQycQDq9slKNX9KZuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="34216444"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="34216444"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 04:40:14 -0700
X-CSE-ConnectionGUID: lrRW7omWTi2mTi1MVaqS3w==
X-CSE-MsgGUID: vzSYr6tdRvmmdd28w7ZTMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; d="scan'208";a="154272577"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2025 04:40:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 18 Apr 2025 04:40:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 18 Apr 2025 04:40:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 18 Apr 2025 04:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF82NIi/FS7vHNR4BfzOsyucttZgIpkB3mvlOTsO6Wv/7Yj50JlUZd3GWm92hLuRyrIVF1LfNROk0rfdpYXPyWrv8tStvlkxNGsgonA0xf+DgWY5Z81TyTEewKIfG7qZ1IFwd6iDShDbtr19rSP9DHWWyZAGhBa6Pw/GRWZmSP+z3VX42ICOQF2p4NlqTFKgnPFH5YpAl7jpHT1Up7+GUMpOa7SpiSudGnP55HXL4eRKsDLD/NvVASnrhIc5LKHcckgh3GZM/P2Ch466Sv6IJpKkEepkW8n1g4LIxHfWg1wBeIVR5rziXPHGp2jWBimIcau/T/B6FKXSYbMFzAM36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/VSNmItlNvzFkwUAjnC4hkQ0xPP8uh9uonCQzPrJrU=;
 b=pv261AuSoqCse0QHpIk7EC3FXvj4c4Lut1UcvAqFWV/EDVQP+Po6fQh3r/v71fYCkFkIH57kty52nqz9fq9c3AiLL9w3H1UXrwPql+G1rEYE8O8MBTliLhX0GDBvIbiGphUnZC7ED6mlARGmg8dDs/8BGk4kOElh+Kau4FgxmKy2GGWSzzs2h5NV1hc5Es1j75QRqRxy04tjq7tRLOdXQowwPXoJ8i2QinB2fTi/P1iPyuMpyFr+rUnrxTYOE6TD5RpM46sQR6E13yyUCa9BqBPpOmTBI38qHjg//+rcZ6Autf/iQP2y2K7cIxJOj2+jDwKQor+TFT1u6o2DMOikow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by DM4PR11MB8158.namprd11.prod.outlook.com (2603:10b6:8:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Fri, 18 Apr
 2025 11:40:10 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8632.035; Fri, 18 Apr 2025
 11:40:10 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: "Etelson, Gregory" <getelson@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "owen.hilyard@unh.edu" <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r3ow4K3xJ6vUu8VgAr7QGxzrOoNgYAgAEJ8vU=
Date: Fri, 18 Apr 2025 11:40:10 +0000
Message-ID: <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
In-Reply-To: <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|DM4PR11MB8158:EE_
x-ms-office365-filtering-correlation-id: 4bdc420e-34b1-4f93-6d77-08dd7e6dc69c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HE37Xu7YNpRTXfrLUSTmXhP+aQg6/oOXX7aXnu2WhlWwocLm1BKJU2wuvo?=
 =?iso-8859-1?Q?i14Ci/k9elr/D7cWbYY7ItAnS6V5QZ+jmpNuRtLUzjg0HNW+tEbmr2SX08?=
 =?iso-8859-1?Q?7ULkwwb+TCy+gbdlzpOY5KlsSAc/RTvHsqJP5y3MJUlMAV41V/cbRZguSU?=
 =?iso-8859-1?Q?jnyaxtjRsjomjwE93UKeN7ZDBs8HMKWSh6IPmsb5+6JEl4eq2t0zJAp1oE?=
 =?iso-8859-1?Q?d49jX57hoVVf6+wvCjQQq+bkgcW5itxiYi5CwG4riK3LAdWumrKBm4vUsx?=
 =?iso-8859-1?Q?DFSUsXm4bHRyES1tReo1vyeBviWULZJcH47bZ9YbrsypqQWT78KQXEPX/Q?=
 =?iso-8859-1?Q?lBDgb0UR+Fx0Zy2zxHnhR2ji1MidJs1347Xw7XIfe/tAvQHhyakOasEys0?=
 =?iso-8859-1?Q?FFQX2ZR9lQExuV2bi8RY/oI+6ACRfdfi+9mSu/nidVeGLavegs+EHVrE1a?=
 =?iso-8859-1?Q?u1wnpvU1CN1l1gJWr6WCLOh0j5433R8CC1T7lyRdecMnez5m9wRFfpn6Jf?=
 =?iso-8859-1?Q?a6OmElAPdVP1obz3JfnajsBWZHj9kkY45dCOWVOKMyamSbm8xSq/pkEhgQ?=
 =?iso-8859-1?Q?iCuMBPifeC7u+SXEzJShbAdlYbr+LEmk7662hDG5haOaKB3HqwZ5q/ClLe?=
 =?iso-8859-1?Q?hRHP26WIc6+5i83fTIWbD92J4KUM09ZJ65P5M+ZwX20B/nlLXbVT0vQOzV?=
 =?iso-8859-1?Q?iJBGr7nYTn4Hbs64wsBLeViqAJv3BdJlUC/C9zi/nBPq9sBY6yJN0445+Y?=
 =?iso-8859-1?Q?mhjeLS9VsK/E5u+x2ShvBQVuhH8wOFdZSrKcmMtLklVY0mpAbWItzUANNG?=
 =?iso-8859-1?Q?gleF1GXLuJvN6bbSPHasX04ArXN9BKlxIjUF3ukossZu5zPlfOSJ7AlUbJ?=
 =?iso-8859-1?Q?hkO8KNkf7NpBbinZFBU/1laN9TOXdEgy/fE0oC3j226iWBSzNWPibVtCO/?=
 =?iso-8859-1?Q?Mrg5gEM2horZZWbDDXClhQMDkLWASarcm9tphFJUo6TuGzOkJUB5mqsJ4x?=
 =?iso-8859-1?Q?BnJmr6PB9vTH7xubpxN10HEAWjKpyUx3x3MBHLjcCZcFmezrPHhmjVypKZ?=
 =?iso-8859-1?Q?G8lsM+nxuxRznwriWyGIlVB6m4Z+U8ZeZ5phwsUEhtqg1y2b9bwfdOVfHA?=
 =?iso-8859-1?Q?PgW3CcIicBU+v4GW++ennfEaFZn/EH8Dt8k2TFCqweoeOqquDAdnFSuQVp?=
 =?iso-8859-1?Q?lPZSc/uNQIJizfpfFs7J/sICXPdPo8OVBbh6FaxBlW5kuSimwMZSmfBiig?=
 =?iso-8859-1?Q?9NjrCs7IOxQW/dgMlLy9w6jWP8cI4oYfm9s+bKce+siJyw8jsHb5BLz5nW?=
 =?iso-8859-1?Q?cXMWdy26J5TgHr/a3760bEW8c/HBbCSQK1SYYPanRvMLE0Rx10Z26azfSk?=
 =?iso-8859-1?Q?8r+QYYWCeT99RYyJOt4q5FBi6LNtAdxg3p6MHRWUSB95Z/WzXO4FxhUg8/?=
 =?iso-8859-1?Q?N4ArRPMbvxInHpXG9X7cK5Z+1T4v8WmoyBlHaI/9g7obTieK1LFepNC0Cc?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mrTD8vWPgAtCCqIBPFqYDdUvKyOoavfnyP30YgHz1+iX/FVvnTVQFKvCs4?=
 =?iso-8859-1?Q?Jr0rvxYIiIOhKXADNMr0xRDKe3FtCSaWkbieKlGyhc1LEC2AJf5HHJGN5u?=
 =?iso-8859-1?Q?5TjvGWJB4zsPM8iVhxKutkNUIlDfP/PZ5sFUOTo13/li8s7PwPfbyKcWVg?=
 =?iso-8859-1?Q?AAjprvXE/amRM05bC7j8EYZ6UnWi826oSgzgz5EzHDfD0zRIMKBLEiRKhx?=
 =?iso-8859-1?Q?h71I6YxRhEflcTCTeHkI4z2l9qwRbIjrbiLar/1SIo7dLBRj7QwlaY5l28?=
 =?iso-8859-1?Q?uOrvuGxJaje0xOdUHdMGXKWPz9EFuNtbENnMaC4dy3NXZOGK8xKBoe/6I1?=
 =?iso-8859-1?Q?t6Og36//31MzQQZ6Ta768RUr2XzavWmSs+C/pLCfdD5rxnL/tLok8irAiz?=
 =?iso-8859-1?Q?KNXRj23Uj4YyqvXRCM6zp3OV6CyT1VsomATy2zyQ5YLFWRSvg5ZgxCXWRI?=
 =?iso-8859-1?Q?rAEOnhznP4xrHC8EokvTaBd4GbVIf43bLQvDT/xNiTlwrlpeciFn8YRmXg?=
 =?iso-8859-1?Q?KjSzj7es0tlL1VXn0A+9BxGX56BT59DD4BBNhyRrsI6nYZQBqsKGEkxKXi?=
 =?iso-8859-1?Q?r1Ei9bYW311eT/d/w5chjEe6CM67t5IdArvvm67q0LGMI2dbIW9eUdXegi?=
 =?iso-8859-1?Q?05YFXI1n4c0iaPL2Lv8RXARH6mwlQHp3ksZRV/oCDPTITuN5XFp/BmENty?=
 =?iso-8859-1?Q?6g32otWZ6YlmaRsuScBqPpW/4GFy3zCKl13ezYmm86R6iNt1xlJaomWQGB?=
 =?iso-8859-1?Q?HJQx701W9OSe3ppR81Pr/0BEWknzLFpIXsD5i1YsUzhdElxl9hjJvuVOHX?=
 =?iso-8859-1?Q?uXWu2fE/A+N8ir9xH3aO0zYsxTfi7vk3gMyFHBet6nuKdXc5ge08FqK+hI?=
 =?iso-8859-1?Q?SeEv3Ls3jSHQkxwhFJxyEynNaR4xeSA08cSjauF1QC7rYOyhVF7vFRPt0Y?=
 =?iso-8859-1?Q?CIy3SJlC9lgW+g3eOviYTOLDPa82f6epJG7xxnYj0/dEszl/UWkSmV8Z8j?=
 =?iso-8859-1?Q?ED75QamOwgC7SBuhVlLkp6dvNFtxqPVCbHnm1ca0fxTzMqJPBvMkOw5sus?=
 =?iso-8859-1?Q?ce9nRhn1c3gqymisl8IHxikT3qk513qCSAYbCNzh8vF4TWOpnDImSI+x6p?=
 =?iso-8859-1?Q?k2v0ZDZzQz0mApnB8yYWJlfRBl4wJgURuefh3gQ2QQpyyctG7vEqiYHsBt?=
 =?iso-8859-1?Q?Yqys6Wr2ALpeuJ8mkUivfNTfCTxAd+4ldjE/hf2mfZCkkUkZBszwzd+GRM?=
 =?iso-8859-1?Q?YAiNHN4tVgw2ArtdK1URPyAXzT+AJHDtMKsRJC55hQ/nA4BaQpY9jMGbsn?=
 =?iso-8859-1?Q?nAdLxRI2sP90STOKxNwK3ua3IqbjUwxj9ndEG1y8ycwLRarCKygiCLDmZV?=
 =?iso-8859-1?Q?KHAcMK0Jq+vKmQhZKyA1nbBgH80cWlYjjw0ls3YC1Hum0+OPPjsows9TYf?=
 =?iso-8859-1?Q?LVYnp0qV7hiro2iBkrvgYKzB9dJVT/YkR30Ege1rQAKszhiwfnt0mKMlbY?=
 =?iso-8859-1?Q?xhMRHxZO7xk4TfgCTIw1V/zNewDX1o5ctVlQorQ3x0A37kRCwMU9h1fXPH?=
 =?iso-8859-1?Q?srCLsKF5IMKPVz5FZYGDpp6mxNzIag1XECE0fogYoVS7YqIi0Xb8MqW6Ev?=
 =?iso-8859-1?Q?VIxv7M95hJ6BP+sOzbzzK06x47trnxs6lm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdc420e-34b1-4f93-6d77-08dd7e6dc69c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 11:40:10.4769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgYzD7eDaAN/p05QodxL7NpFrFg+KmLQ3W+0pvDtsOqLIYspbq3iCHN8RVKy87oUtT0Z9+he8YHagJvomxSzm1sLiYxvUWbz7ZAqfbDTBH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8158
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

> From: Etelson, Gregory=0A=
> Sent: Thursday, April 17, 2025 7:58 PM=0A=
> To: Van Haaren, Harry=0A=
> Cc: dev@dpdk.org; getelson@nvidia.com; Richardson, Bruce; owen.hilyard@un=
h.edu=0A=
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq=
=0A=
> =0A=
> Hello Harry,=0A=
> =0A=
> Thank you for sharing the API.=0A=
> Please check out my comments below.=0A=
=0A=
Thanks for reading & discussion!=0A=
=0A=
<snip>=0A=
=0A=
> > +=0A=
> > +            pub fn start(&mut self) -> (Vec<RxqHandle>, Vec<TxqHandle>=
) {=0A=
> > +                // call rte_eth_dev_start() here, then give ownership =
of Rxq/Txq to app=0A=
> =0A=
> After a call to Port::start, Rx and Tx queues are detached from it's port=
.=0A=
> With that model how rte_eth_dev_stop() and subsequent rte_eth_dev_start()=
=0A=
> DPDK calls can be implemented ?=0A=
=0A=
Correct, the RxqHandle and TxqHandle don't have a "back reference" to the p=
ort.=0A=
There are a number of ways to ensure eth_dev_stop() cannot be called withou=
t the=0A=
Rxq/Txqs being "returned" to the Port instance first.=0A=
=0A=
Eg: Use an Arc<T>. The port instance "owns" the Arc<T>, which means it is g=
oing to keep=0A=
   the Arc alive. Now give each Rxq/Txq a clone of this Arc. When the Drop =
impl of the=0A=
   Rxq/Txq runs, it will decrement the Arc. So just letting the Rxq/Txq go =
out of scope=0A=
   will be enough to have the Port understand that handle is now gone.=0A=
   =0A=
   The port itself can use Arc::into_inner function[1], which returns Optio=
n<T>. If the=0A=
   Some(T) is returned, then all instances of RxqHandle/TxqHandle have been=
 dropped,=0A=
   meaning it is safe to eth_dev_stop(), as it is impossible to poll RXQs i=
f there's no Rxq :)=0A=
   [1] https://doc.rust-lang.org/std/sync/struct.Arc.html#method.into_inner=
=0A=
=0A=
// Pseudo-code here:=0A=
Dpdk::Eth::Port::stop(&mut self) -> Result<(), Error> {=0A=
    let handles_dropped =3D self.handle_arc.into_inner(); // returns "T" if=
 its the only reference to the Arc=0A=
    if handles_dropped.is_none() {=0A=
        return Err("an Rxq or Txq handle remains alive, cannot safely stop =
this port");=0A=
    }=0A=
}=0A=
=0A=
There's probably a few others, but that's "idiomatic Rust" solution.=0A=
We'd have to pass the Arc from the RxqHandle into the Rxq instance itself t=
oo,=0A=
but that's fine.=0A=
=0A=
<snip>=0A=
=0A=
> > +fn main() {=0A=
> > +    let mut dpdk =3D dpdk::Eal::init().expect("dpdk must init ok");=0A=
> > +    let rx_mempool =3D dpdk::Mempool::new(4096);=0A=
> > +=0A=
> > +    let mut ports =3D dpdk.take_eth_ports().expect("take eth ports ok"=
);=0A=
> =0A=
> Eal::take_eth_ports() resets EAL ports.=0A=
=0A=
I don't think it "resets" here. The "take eth ports" removes the Port insta=
nces from=0A=
the dpdk::Eal struct, but there's no "reset" behaviour.=0A=
=0A=
> A call to rte_dev_probe() will ether fail, because Eal::eth_ports is None=
=0A=
> or create another port-0, depending on implementation.=0A=
=0A=
I don't see how or why rte_dev_probe() would be called. The idea is not to =
allow Rust=0A=
apps call DPDK C APIs "when they want". The safe Rust API provides the requ=
ired abstraction.=0A=
So its not possible to have another call to rte_dev_probe(), after the 1st =
time under eal_init().=0A=
=0A=
Similar topic: Hotplug. I have experience with designing C APIs around hotp=
lug=0A=
use-cases (Music/DJ software, from before my DPDK/networking days!). I thin=
k DPDK has=0A=
an interesting "push hotplug" approach (aka, App makes a function call to "=
request" the device).=0A=
Then on successful return, we can call rte_eth_dev_get_port_by_name() to ge=
t the u16 port_id,=0A=
and build the Port instance from that. Outline API:=0A=
=0A=
enum EalHotplugDev {=0A=
    EthDev(Dpdk::Eth::Port), // enums can have contents in Rust :)=0A=
    CryptoDev(Dpdk::Crypto),=0A=
    // Etc=0A=
}=0A=
=0A=
Eal::hotplug_add(bus: String, dev: String, args: String) -> Result<EalHotpl=
ugDev, Error> {=0A=
    // TODO: call rte_eal_hotplug_add()=0A=
    // TODO: identify how to know if its an Eth, Crypto, Dma, or other dev =
type?=0A=
    match (dev_type) {=0A=
        "eth" =3D> {=0A=
	    let port_id =3D rte_eth_dev_get_port_by_name(dev);=0A=
	    EalHotplugDev::EthDev( Dpdk::Eth::Port::new(port_id) )=0A=
        }=0A=
    }=0A=
}=0A=
=0A=
Applications could then do:=0A=
  let Ok(dev) =3D eal.hotplug_add("pci", "02:00.0", "dev_option=3Dtrue") el=
se {=0A=
      // failed to hotplug, log error?=0A=
      return;=0A=
  }=0A=
  match (dev) {=0A=
      EthDev =3D> {=0A=
          // handle the dev here, e.g. configure & spawn thread to poll Rxq=
 like before.=0A=
      }=0A=
  }=0A=
=0A=
I like having an outline of difficult to "bolt on" features (hotplug is typ=
ically hard to add later..)=0A=
but I recommend we focus on getting core APIs and such running before more =
detail/time/implementation here.=0A=
=0A=
=0A=
Regards, -Harry=
