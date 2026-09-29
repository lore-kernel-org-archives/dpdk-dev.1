Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C9C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AE0C40E0A;
	Tue, 29 Sep 2026 18:12:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id AB06B4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790698326; x=1822234326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=/jcVRLcw2O+Dg63BjC1F6LzPgP80FNeFD7Tdnh61Z0M=;
 b=SdXccByKzzgWjUmdFx6+xIBQMOW/X8oJv7YHfAvcsvcWIqTB+Al06EVo
 If2EmavUzN0i7BlfoXazFnpxWFqZ6qtSuMpqWSeIAKBfdMFP/+Oc1ONZW
 eVBB2mdypQB0P15UXbuyyP4Rl7DFEFOWVilI7Fv2UhVJiEx9+8MPWeGhe
 WOkgJJN9kgol73otXFYJUt2uRxQKVWLhLrszAeFM7IMM9nACA4juM0cDp
 pPWScAovJSmj1yN4yoh392VG3P6WITP9h+sL58GMidSpEt30zzLsmyzjx
 nTNOdUvCD8Ejl0UpmUFmRjZdSvP4CEf2bVH9XGaWsaUXCi3TXemxTVIzz Q==;
X-CSE-ConnectionGUID: zJgW8v9pTpSkHx1bHPdaLw==
X-CSE-MsgGUID: YGZ0/YQvTP+N0g9mcFHeyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93912079"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208,217";a="93912079"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 09:12:05 -0700
X-CSE-ConnectionGUID: l+6P9kgZTWux4rFusHf1hw==
X-CSE-MsgGUID: xe1kbjCGT0iqDP4SSxOGNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
 d="scan'208,217";a="304918479"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 09:12:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:12:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 09:12:04 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 09:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThcLrQIpa+Qx7s99Btw+kBTFDFbTl1t9yyd3LPaMJ5RnJkqOmZYdkznk5qKjPuiP2sChuC4eq4MnEysBE0MqZRlh8E1W7iVDhJJm+tsQ1Fa1zlkZ2AyjQan9gEZ81Um6XNqGNcWP74e7bVhB6OuA21qZ3vIAGiGCqtmpUKSBHQKnYuggQfd/vi1Atga5Rm2AYbpmsgtLL7Shfq0K8XvBgut8HdYSmsddAo1Cfm/H6MMWlgBpGWdcMpq00f+Mm5bUuZI2LX+TnR+vmuOO++3ewXUECp7z2THsowE7id6ePJerA/c6GOXmhwr+FDMoqgTzFmX0/gC1+9FchZ/wStw3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jcVRLcw2O+Dg63BjC1F6LzPgP80FNeFD7Tdnh61Z0M=;
 b=DpLEKsb8CE16mZP17H36U8BDK0S6stYLtOBLlD0hbpqzZOICxWIsmpXLto8gTGUASv0Tc2T8mY49FyMvkF70cw/3eJQaxeann1eywNzByF5NsJ7xR/hEY830L+w7589FS8jj3Q7j/LflvTEepu8cJoYBa2I3t4q7WCaVSU3X5GEMlSQfoN9HqaRgo9NOnO8Er/2jUCUrDF0/M4B26yZU8I1DUOSHuwc4tHEpS+004VNrDj3WOljvaqjbM+h0rb/ZF6bEf43VIH1n9GNEPrlQegsraVr4bsKBau03Rpw5fXGO4nTVsnVv4zgFIYe3dZosnxwAQAiVNLHSPexoFNNchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20)
 by PH0PR11MB7167.namprd11.prod.outlook.com (2603:10b6:510:1e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:12:02 +0000
Received: from LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae]) by LV2PR11MB6045.namprd11.prod.outlook.com
 ([fe80::1f72:3d49:b6ba:91ae%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 16:12:01 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, Akhil Goyal <gakhil@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app
Thread-Index: AQHdS2ztqX5wS6X2YkaTStj9V6UhG7bdzPeAgAAFXkyAADPpgIABeb8AgAZBjgc=
Date: Tue, 29 Sep 2026 16:12:01 +0000
Message-ID: <LV2PR11MB604567127AA4D4D950804D13818C2@LV2PR11MB6045.namprd11.prod.outlook.com>
References: <20260923105003.2811322-1-kai.ji@intel.com>
 <LV2PR11MB6045AC38B49432A2FEA9C20281812@LV2PR11MB6045.namprd11.prod.outlook.com>
 <CO6PR18MB4484077A45CBFCF6CB562E20D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
 <Uoji51ajRt-6kVG_ZXgD_Q@monjalon.net>
In-Reply-To: <Uoji51ajRt-6kVG_ZXgD_Q@monjalon.net>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB6045:EE_|PH0PR11MB7167:EE_
x-ms-office365-filtering-correlation-id: 570aaf57-ce9b-4ab0-d23b-08df1e44655d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|366016|42112799006|10067099003|11063799006|56012099006|18002099003|22082099003|4143699003|8096899003|38070700021;
x-microsoft-antispam-message-info: c/hdpZRqs2r76GcRE/oj8FzPj9O1acgfv8VqMnC4ecF7R+ipJERr3R5AC9ntngY3eRb9FFMgn6b83WHBMbwvnzhhxNwNlAWYSZJdrmOEH9M7+cD3pgddrL6nyIXU4P4ULs1AB1YDySV4eAcvi/W1MiJ24yCPvDdOTjzT9DqcN2qtPmrBptfz/L1MOKoR9Vz6ypCjdkx0qN1CUJJHbWxUaUGrCCygo1R4bHnL5F9zW3jLg0BBAu9aduRlk6L5YdQfQaJAe3seOlDA9bkgNvHGIaZpEvHDQE6CogJK3WYR0nUyJHpJqA6KroYh9tAR+4cgvzCKuuE0cadOAdeopxNsRd4/WhVfucdcsMEqL/TmQ5bjhf0Tnhnh1iXLpmfr5ZKZdmHvZf7iUN4KWW/Pas3LUENhopbG2EuQOuMJXEA7bxUctXGsnixTnlCTAXVCCxGwqbUh9UVcNVLxwyBHNuhcc1X/y4AK5rxsG27B0chSpuoycl6JMPjRDSot4izwawLfaSxdumWAua6M0DwgHSqDrCOPWtkOOIxDZf7OFymp04zr5d6J6JTtdXIN6cFiYP4P+HfXsRWd/rXcb56C+reTIbhWXYMrQbfsaNe/uk0aAthNHx9znP5juwuBBgSinvAhPqT2PQsi+Iw5iDvcDTvZrRAebvFwVN9Q34LW4OEDoCVCxNOVFTWULL2jZX6tlkH4cr4HxVHG85KjBhaE1MiEtledFsuL8m5FzQtATqX201Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB6045.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(42112799006)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(4143699003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PmgRTyRI0PE4XSdiBKJPBpSkKau2rR5mm26C8KQYCFOeCJBuBViZWP0I68?=
 =?iso-8859-1?Q?cqS4nhh25Pr9Pgtqb3wTScfhCX1SfGM7bykC0c26x6OZVAAYmTCcd9ANNH?=
 =?iso-8859-1?Q?6vYOlFoEbfCa+hdIpwmABNNBY+TOXX5JuJqfi7We6oOGPi32lONCkSUIAu?=
 =?iso-8859-1?Q?Dfh+IKFS5VVfhTxvfysG6VxbBCFpEcq6rREjY6lw7tYi1Do5kVMi1PzPn1?=
 =?iso-8859-1?Q?p37xfnhQGdeveDeVuvFBiwn2blRYTdERq9lF/4OXbv+5of25lrWQhEQMDe?=
 =?iso-8859-1?Q?LRUso+qyPvNJNxm3YJMNlCTbM3iTQHsTHCAcdmyF31tN550GbHDeHiu4g1?=
 =?iso-8859-1?Q?S5iAJZiDmXpFA+VvUt+ldlJY6SrSGIQpbu4ZT1o3J6gEj8U/GJJWyvLduF?=
 =?iso-8859-1?Q?yzNHJ1opdSQs4gAZVzSOQ7504udMGbICB1dS24gGSG/Zw4/5o7wzUkZeJD?=
 =?iso-8859-1?Q?n3WqGkQsWDe0Fa7cMBqJWUFF74ROh2MrrwTvueJXvcXhkCdwpBjxqUAzNN?=
 =?iso-8859-1?Q?1ekWdJgKGBw1ziofRVAkm314LKlc4Ref1Br5AdMhBDrFYOGWoPeQyyxjKx?=
 =?iso-8859-1?Q?B2YhVIEJpUA+kGXz72s/90A+8Kwkm82gnPBm8RD0ILUdsKehYHYsd0Gv8u?=
 =?iso-8859-1?Q?59FgfUIxT9LGtZ77TGQp0zD2xhrTM+Big9QVTKbdwLMwwb24Q/bPxjhqYL?=
 =?iso-8859-1?Q?LhQt5DUF/75sGQxQ4PtVjEHnmsbjZXLN5HYMLN9eWbDqa08xrC/x92Jq1R?=
 =?iso-8859-1?Q?PK6Jxf4B91eeefCc2jIssgZh16r7DMlOeUmP3FSDBhau4nwPs35+Z4XVNM?=
 =?iso-8859-1?Q?bmag4wh9NpOO1YYyQtw3OHxYgdtUt/0/hgFWvvyDc+p/DcSWyPgXDnllvm?=
 =?iso-8859-1?Q?uqMGCoX2NW5OXvFy53gPkm3PEM9QOAX3JGVipOxiLtMKIWPJmkBBxkXZqU?=
 =?iso-8859-1?Q?JV73nX5XZUX4/511touXvuZp7hqRfIKbWxVuMrzb7ntn9CWDIGiB/MoZCz?=
 =?iso-8859-1?Q?FPo/QQq/2FbJwsHBK+IQFTNw6MbNSO5FSIZneCNIqynsHqPO+qfDvXvN5R?=
 =?iso-8859-1?Q?8VNgBkHvSq1N6vd3sPaUQrZr3BJ/VkQAogIjCbZKAuk+/7BijPgsvSBsnQ?=
 =?iso-8859-1?Q?mtkAHcV1Y2PEe2q7+Z78Re9I04tKP3uMznVwmc6iBKAYKeOqxfaXr8o2ui?=
 =?iso-8859-1?Q?OwJdXc/hJCqs3Ufj3w+s+8n4iEI3jGLga3ijNc+4q7m4GYuzT3XCN1mpjg?=
 =?iso-8859-1?Q?foJ4hMWxK3B7xK0gwHn9w6Nm6KFIr3b/Fb1C48PZ2CLwgoxo085NyBka/9?=
 =?iso-8859-1?Q?Gtx7M5Jj0TiKgxkZlZoqoaUsbbHHCwKNJhkhX9KPLn5vRz2KRV/A9cINRl?=
 =?iso-8859-1?Q?IEjNS7ydmgbk1zFjp30krZfuraQOl5uAeFWH/KwajXOHRFEbKD0KIpB5To?=
 =?iso-8859-1?Q?eWNjTnBUkgjHF0g71flkxLVz8CLeAtFo8K+EAOOf14GalwQl7myMXWi9hI?=
 =?iso-8859-1?Q?8Wivho4fVPqF5W6d/XOx6nedWunB2gQrhxOT2ve6CcVOrTkCbLdsRxNhrv?=
 =?iso-8859-1?Q?Zwt6v+h6vn8do4LvjiXL0EWu92lH3hD9o7H+bbHbcBrpwNwqzrFy31n1LE?=
 =?iso-8859-1?Q?EF+QLiJkA6yXtKdHmPzIt1UqW3XGA7qMhGyG2cpeS3Yro4lt0/irIWG5rm?=
 =?iso-8859-1?Q?Lxe2pXRmkWIEW9l7sVpb716tm4FdPkcQyC87+4ldcUpN75FMPzUjd1kQw8?=
 =?iso-8859-1?Q?WvTQ+jmle9Bkl3ZeJDUHWem2XMb42kt2N+oT4qXVCJqCQhJ/GCspnwigXT?=
 =?iso-8859-1?Q?rcaQQAsE5K6G4HvGgQf/ZogCbUy4xyVCFRDuQOhZ6f1/2n5nhMPs93An4z?=
 =?iso-8859-1?Q?Yn?=
x-ms-exchange-antispam-messagedata-1: IrPdRFixj8Yb8w==
Content-Type: multipart/alternative;
 boundary="_000_LV2PR11MB604567127AA4D4D950804D13818C2LV2PR11MB6045namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CBn9C+/DqcQVcvT5Fd089nDREFADp8u/BNyhDiNtd67E76BXkVFDivCaxDwSu8+tss3zRl3SwtBMFjzKj4CUIp3FVrkmSI4adzpPrASSd/Fpqj6MpCAXtp1wVyHq+6N97eAYwxWnRllnH9VvudgNTUK13B8g596JWf9h3dxFn4dClWubecjinPZ87WFzv/nng+Y/H5V5H6xrbiBAsSCqBCQSIPhQ8ZpvBPHp6gZP6xkGrqOXdK/nivb/Fvmc1bFXUmdjQ6oXn574IJkupMwQAa7uY93+2M46z+u5Vtd5kanqtGCwHN861/VjWeBkcFlP/GX7EFfwbAjN9fzLunnPxA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570aaf57-ce9b-4ab0-d23b-08df1e44655d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 16:12:01.6752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxZmVIGxLOk2JbxcXpmucFY8+mFfP8d6lNvp9x32etPXwTLLf+HelydgXy2gp/FeU/aDRONVQjuCWuwAen0N5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7167
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

--_000_LV2PR11MB604567127AA4D4D950804D13818C2LV2PR11MB6045namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I agree that a single validation framework would make cryptodev validation =
easier to discover, document, and maintain, and could eventually allow some=
 common setup and reporting infrastructure to be shared.
That said, the overlap between the two applications is primarily at the cry=
ptodev API level. Their core purposes are quite different. The FIPS validat=
ion application is focused on CAVP/ACVP workflows, including request/respon=
se processing and conformance testing, whereas Wycheproof is built around e=
xternally maintained JSON test suites with valid/invalid/acceptable result =
classifications and different requirements for asymmetric devices.
While there may be opportunities for code reuse in the future, merging them=
 today would likely introduce additional dispatcher and lifecycle complexit=
y with limited immediate benefit. It could also blur the distinction betwee=
n Wycheproof robustness testing and FIPS conformance validation.
My preference would be to keep them as separate applications for now and re=
visit consolidation if we identify a meaningful amount of shared infrastruc=
ture.
Regards,

Kai


________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Friday, September 25, 2026 17:32
To: Ji, Kai <kai.ji@intel.com>; Akhil Goyal <gakhil@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH v7] examples: add Wycheproof validation app

24/09/2026 20:00, Akhil Goyal:
> > Wycheproof differs somewhat from the existing cryptodev test vectors in=
 that it is
> > an externally maintained collection of JSON test suites covering a larg=
e number of
> > edge cases and negative tests. The intended usage model is to load the =
upstream
> > vector files at runtime rather than embedding them in the DPDK tree.
> > I think the existing examples/fips_validation application follows a sim=
ilar
> > approach, consuming external CAVP/ACVP vector files rather than integra=
ting
> > them into dpdk-test. This patch follows that precedent, with the goal o=
f providing
> > file-driven conformance validation as a standalone example application.
> > I agree that the documentation can be improved. At minimum, the .rst sh=
ould
> > describe where the Wycheproof vectors can be obtained and reference the
> > applicable upstream license, as the current example command may give th=
e
> > impression that the vector files are included in the DPDK source tree w=
hen they
> > are not.
>
> Ok, so in that case did you consider integrating this app into fips_valid=
ation app..
> May be we could rename fips_validation to crypto_validation and internall=
y have 2 modes -
> Fips and Wycheproof? Like what we have for examples/multi_process?

I like this proposal.




--_000_LV2PR11MB604567127AA4D4D950804D13818C2LV2PR11MB6045namp_
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
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
line-height: 20px; margin: 1em 0px; font-family: &quot;IntelOne Text&quot;;=
 font-size: 10pt; color: rgb(0, 0, 0);">
I agree that a single validation framework would make cryptodev validation =
easier to discover, document, and maintain, and could eventually allow some=
 common setup and reporting infrastructure to be shared.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
That said, the overlap between the two applications is primarily at the cry=
ptodev API level. Their core purposes are quite different. The FIPS validat=
ion application is focused on CAVP/ACVP workflows, including request/respon=
se processing and conformance testing,
 whereas Wycheproof is built around externally maintained JSON test suites =
with valid/invalid/acceptable result classifications and different requirem=
ents for asymmetric devices.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
While there may be opportunities for code reuse in the future, merging them=
 today would likely introduce additional dispatcher and lifecycle complexit=
y with limited immediate benefit. It could also blur the distinction betwee=
n Wycheproof robustness testing
 and FIPS conformance validation.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
My preference would be to keep them as separate applications for now and re=
visit consolidation if we identify a meaningful amount of shared infrastruc=
ture.</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"line-height: 20px; margin-top: 1em; =
margin-bottom: 1em; font-family: &quot;IntelOne Text&quot;; font-size: 10pt=
; color: rgb(0, 0, 0);">
<br>
Kai</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px 0px 16px; font-family: &quot;IntelOne Text&quot;; font-size: 10=
pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Sent:</b> Friday, September 25, 2026 17:32<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;; Akhil Goyal &lt;gakhil@marvell=
.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b> Re: [EXTERNAL] [PATCH v7] examples: add Wycheproof validati=
on app
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">24/09/2026 20:00, Akhil Goyal:<br>
&gt; &gt; Wycheproof differs somewhat from the existing cryptodev test vect=
ors in that it is<br>
&gt; &gt; an externally maintained collection of JSON test suites covering =
a large number of<br>
&gt; &gt; edge cases and negative tests. The intended usage model is to loa=
d the upstream<br>
&gt; &gt; vector files at runtime rather than embedding them in the DPDK tr=
ee.<br>
&gt; &gt; I think the existing examples/fips_validation application follows=
 a similar<br>
&gt; &gt; approach, consuming external CAVP/ACVP vector files rather than i=
ntegrating<br>
&gt; &gt; them into dpdk-test. This patch follows that precedent, with the =
goal of providing<br>
&gt; &gt; file-driven conformance validation as a standalone example applic=
ation.<br>
&gt; &gt; I agree that the documentation can be improved. At minimum, the .=
rst should<br>
&gt; &gt; describe where the Wycheproof vectors can be obtained and referen=
ce the<br>
&gt; &gt; applicable upstream license, as the current example command may g=
ive the<br>
&gt; &gt; impression that the vector files are included in the DPDK source =
tree when they<br>
&gt; &gt; are not.<br>
&gt;<br>
&gt; Ok, so in that case did you consider integrating this app into fips_va=
lidation app..<br>
&gt; May be we could rename fips_validation to crypto_validation and intern=
ally have 2 modes -<br>
&gt; Fips and Wycheproof? Like what we have for examples/multi_process?<br>
<br>
I like this proposal.<br>
<br>
<br>
<br>
</div>
</body>
</html>

--_000_LV2PR11MB604567127AA4D4D950804D13818C2LV2PR11MB6045namp_--
