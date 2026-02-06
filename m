Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96595ECD98B
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 10:07:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EA404029A;
	Fri,  6 Feb 2026 11:07:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id D1CEF40293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 11:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770372457; x=1801908457;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NdUfmkPQmIGVb4FZwm1P1g98idvLPKyezb/Dxa4HV7Y=;
 b=Tf5F7OgiJM8VQfHTbKgMYKjVBC521a6ITg9Ywhie99fMHt4yzIAxBxOh
 yl6DeN0q4RmOkrH1fG++e80+Xq1OgNn5sHlXCiopozZGJQlOHSKzgzv0B
 tLzbqToJ+8WoTetK+rZe/HCH8onfTE5PYHtAm1S48C0jPMqjivTSAmh+B
 RPUMDNv3iQMj+45CfeoQh5DKsWpkEalUjSFblpp6/M+uGx9tRn0Q6DVVB
 tc/MU66G1ESBF/F+GiDpu6iIPggW87p/YFfrXX6Ez+Y2E93CEPuVdO2Ko
 6bzoLs1vfhbdbGyRMzzMBraNihz73PvXv5k2H04m3mWz+3ajmuxyOeR8U Q==;
X-CSE-ConnectionGUID: /1FJtDJYSDKVhF6GtMVC4g==
X-CSE-MsgGUID: WTuhmlAxS26eTu6EZAyieg==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82213080"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="82213080"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:07:36 -0800
X-CSE-ConnectionGUID: po6PPSbOTFKLInkHhApYFQ==
X-CSE-MsgGUID: cE54Vad/RUuFVt/GAf7gjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="210629318"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 02:07:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:07:35 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 02:07:35 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 02:07:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu8PwdwVrU+AZs6D2oq6+fZCLAvY519SogKiOoLr2av1IFb600sx/OiKDbtEzsDnMGqJrTGmGPCCbILVAI/zhVCKAuQ731YnBkH/v8L8ALzNPuFWtVzF64xC8FsdU3bvnH7lbELyo1GnLmttNFdWXsPxSdruupboUsLlHRzV2mQcw1GYm84swTTi9owF51uKsvQ9bNwy2M1ylEsi4e3IzM8fGy7+iq62FzxqL18scEyPWKckJvsyM2cyF0VjTEG6+W0k+SMVLPL2aq3r3pSgYOsslb4l5A/1vrxo9SJ0sTXVP6yT7u2wPwQGWYpvscXX5fpA6p+rcbHVJ/iSnPEnFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qyq1OSiHY0aheZQtLyqVxxSWzlz2LxzVXLtj91vbqRw=;
 b=uIRpmTp14+X0J2BJ89qZctBFBiEuSZHC02z1dits2HJme3fa+uUQ/RBs+aOYrIXEKT2xl2Si1ORke7z0cmhJyCCLkzy22BYbMbAO5317YGoWGGWu6dEmFBeB2+FONpS44e2jO3IteOgJBKgMUBLT+uHQJbc54UU2WBJCoJzHLw2b8oatbAythBohF0fnnBuWZ1jKaoRVeqjEEwHLe8YqAZztxF0JITxcvCF0v5ykhZeUILxoj/kW8EKbdcIhgjQbokrSRHleyFsc9tG+HlPx9pEyV1BrEpNRT9+tMckLti8PrmdnKXRnoJMAf+ZViIFpmBJgxhHshvFALCVkk9CNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by CY8PR11MB6987.namprd11.prod.outlook.com
 (2603:10b6:930:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 10:07:33 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 10:07:32 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>, "Shetty, 
 Praveen" <praveen.shetty@intel.com>
Subject: RE: [PATCH v3 03/36] net/intel: create common post-Tx cleanup function
Thread-Topic: [PATCH v3 03/36] net/intel: create common post-Tx cleanup
 function
Thread-Index: AQHckd2a5OtWGwqPHEK8Vx1gNqGVMLV1ejSw
Date: Fri, 6 Feb 2026 10:07:32 +0000
Message-ID: <DM3PPF7D18F34A19F8116020680DC3EB0788E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-4-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-4-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|CY8PR11MB6987:EE_
x-ms-office365-filtering-correlation-id: f0d32baf-64f9-4fee-7a2f-08de65678b5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p/AVClCAVDjul0C2s7TJFHVKTg5409sBbP+xVjAwMnRUlk2QpTYgj4cZJSqI?=
 =?us-ascii?Q?o2UVdjyJKQh5Oj5O5fCfDRupYVPf6eyTeJvyNNd2oJA0/vkbsskkSdi3pul+?=
 =?us-ascii?Q?m3slo75cNIjRWir4K8C1xw11O9GXo2XudRtaWS4fcblSHE1T+9s5wRXhtLFU?=
 =?us-ascii?Q?iA37yRRbzsGLkaBcz2dq6wJ9tok+Qnr1YBwtyhCZjzDwOYtjbiyclTUfYaYD?=
 =?us-ascii?Q?J44qpfwJsEUjJkPIFxSCZRAZDH3fdo/Zu23FpWNPmHyC3Bnlyj3tvgdv5ofz?=
 =?us-ascii?Q?h2T7ivk6UtW9ag0ldXsuVfzjIfBvjsJB0tXbywz5xX2xsBws6bxkY6s09Vt2?=
 =?us-ascii?Q?xSTcnvjb5FEtrCN/O1nIrmRpdpxN0RaRaGjydh9C8RHiSsY5JE7JhhyiS0lh?=
 =?us-ascii?Q?cjs4X6K1NyJuF4RGRzyfaCfEEVpNH4UaZJyyDbJcn0XHwumsHJWFdT26wnys?=
 =?us-ascii?Q?C5iICLc3tBi7cinuqftUcIEaBmzDhVybXGZ5OciFqOAtUUICpz8Xt0jBwJk9?=
 =?us-ascii?Q?wtj3tKecx4NypwHxyLCWJ5xPgKU0gcjcGYycE+GyEdunULSa1bQ8CCqerCqK?=
 =?us-ascii?Q?6ror2kNQ6nfcwf2M/ADFVhZnAhpYDEdalKkp2q19WwPjH/n9g+ue5k/dfeCh?=
 =?us-ascii?Q?aHSXtEX+nmdf2G+a7aFb1my2zY3hKWjdTl4IQ25CDvBrbo6bqTWmmnscrHWY?=
 =?us-ascii?Q?qb/mgGq19xdc3acUjpc3aPNlOktf26LIvsbcp1FzB2OPmiUE8OvjF8U6Qn/s?=
 =?us-ascii?Q?11RfM9gkoQA6Jx5ZatcvW0qPgtkEb7fN6w/f3q1CSSGfnDPoqKHLv9LUl3Pb?=
 =?us-ascii?Q?jDLHMSK6YNsgQJuKXxv6tgBLFP34S5Bpc6gbLiRyr86ehhPrLN1rwCXcEi5i?=
 =?us-ascii?Q?z/bqaqzBim9TjZ0B/bQzRbuH5xpu7el2zwDYNJpeYkONi4aKET9UZIlqvnvJ?=
 =?us-ascii?Q?I6z2az3hKueE8+5fDV1aPJU7VvQWp3+DBntKomIBe9AUEcn3WgbX0n4oxPQq?=
 =?us-ascii?Q?fUWqvxnQTavaC7CVj8xHKn2eb0JHLzxJkttbFxaaPW9rcUNrqIPmCfBETD/5?=
 =?us-ascii?Q?xh27LjKc3gyEpFNuOjI8uUM2KxfY2DiRiyjDnWgj5vsora77DmIFK9avJinm?=
 =?us-ascii?Q?CDhD5aS5lsQsHcdGqLB1DUiZJHs2+PQYUoGsO9q6wtPA+lRSJsYlZ7Mz+e2u?=
 =?us-ascii?Q?jQDYMGFjlgy4aidtafI93VzfW0c6EJ83nBLAnmXa1YztcscJtk1wSytgnIiZ?=
 =?us-ascii?Q?gGwtIMl2jcNUZndZpMw5gyBI+v7+OPYgMXjwJ3BLFdUFI3hphCOq023EEqN9?=
 =?us-ascii?Q?mAD7agNdilRLV3Z7LYeedqkQPHZ9cNrg3h55FH0rpY1GPt7Y+8xJDC0Lra9n?=
 =?us-ascii?Q?EKottt7aSK/csUjM5PrE6e945dFiLcZz29lkk8P8biq2IY8KSBKIMJTfhIpM?=
 =?us-ascii?Q?FFMmhYEL0k7jXDm6YhGC7+cxq9HiNe0szHoDP2JmhPH3N1e5RG23jtOgd3oS?=
 =?us-ascii?Q?VldLpO80cXef0p9TTjK9t4qarh5yZ2YudwUEvi1E13wEbIGFNg+cXGfWo3s+?=
 =?us-ascii?Q?cBKPT14JvoVj7ybsx+D8HuRTRDlEDwALh5krPsNT3cj2k0k2EpOU8+AxKSVv?=
 =?us-ascii?Q?fiafXCQTcOJJVSOKK4AVYRs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WKPRfblH0hSyzIcybu/lpbptH1LXOGRnhMq6cxntko84Qd8TgBSUGFEStoGF?=
 =?us-ascii?Q?QsEy/VlugIvt2T7VeQzZrwf0uj3xuj6sZfK3njb2GOVJDE+ORcNaEDdI9kuq?=
 =?us-ascii?Q?QtN2kSdOfNIOC7Uv6Z78AhbZJzyH4CTmVQ5V0pkPf8D7wT96tRHiC2/z6xax?=
 =?us-ascii?Q?Wq6fBDMvJd/15gUB6HS/DcI7TASlt3tkT/wUoXxLqWZZWWDWHqn23RplGEFt?=
 =?us-ascii?Q?i2ceAAvEHOI6E3f3jybvEY0JW8Rf93R88h0kmePpN+VXnqX00iLWZ7KC2EZr?=
 =?us-ascii?Q?dDDpMl582jHEecA+ZM/krrvWZYPIpIGbv98JsPaqoxv8Ig4OV7C2MSDC0TmP?=
 =?us-ascii?Q?Miwff44DHaQVIJfgBumckfowk1deyLsnlPSck0qEELUo27VGzzpenYZBEjng?=
 =?us-ascii?Q?7TvWqBZRAqqvghtOfvd/pwZdUgZXVLxsIt4oAFPffA+6WT6Bc629qOOJxO/d?=
 =?us-ascii?Q?YsF18JK5XGHs5wXpZkhCU9uxb1/cO6cjKweSKbW03IEzWAEMb+N3xBv0LaqY?=
 =?us-ascii?Q?G5yuHn7vP/moAylq+BSdxLgR03GFMLLqimWdUcIvOR8V0JHFvqZR1r0Df3zq?=
 =?us-ascii?Q?tjY52q9ZJkrVCBg/5GzMNq1NhPPBiFG6JPbfyrKW2bWkCgOwQ1S7MKMn9zv0?=
 =?us-ascii?Q?9wiluCWq4L4NGotmyZlQjNJrwGnRqDSCDWraMdY5zpxOpSEQQnv5V39bVcIA?=
 =?us-ascii?Q?5TZXbztyDAh2ch1YiqeV0rTeQknC1O/Fvpf05Tmk/b3IuGx0a3XHeIt5RXLY?=
 =?us-ascii?Q?hzHdzqwYQqs3Vf7pA7+dR/Xswpe/07Rfpw7BZdUHdofSZUBPU5w+xe3iOp0s?=
 =?us-ascii?Q?1SFNKzj9Pc0qE/36oN3LX8GfZTtWli5b5/XiY6CZTeYCFZVttc8P4TnJyMGA?=
 =?us-ascii?Q?5dQlh5f/MFwkV/JTBZVUAzo7Z+aPdI7Ob38JnJ2FfaDWkYsl6KiCXi+7h9K6?=
 =?us-ascii?Q?h/el855DojFYgF5C+Yvod4VQ98IZQQMYAvOjgAjaVx9J98hQ/zFxR47datLX?=
 =?us-ascii?Q?f2jXRVxZDiUjK+rJAdWNIek0Ptr6U3clf2V8PZr9N+ovPJ0mlzzSvDMJbkRc?=
 =?us-ascii?Q?bthCFJlbi1/qLAaCPoFdhIJl+W+CfwGXiE/SCOOXTUEiyEVfu1KWjqyq8QVh?=
 =?us-ascii?Q?6uJbthJmHJGTfLJNmfHLHdHdP18Tn9fPxHSJp7nEiyQG8nZ4AWriJWHCL2DP?=
 =?us-ascii?Q?LNxFc1GhA+G5D00PmbAJzHhcAe99XIkc7ZIfuiA78MD6y9Ty/Y62TPlInLaF?=
 =?us-ascii?Q?C6Pz9BFL88H8ErevX+xNDzlCNLbxf/smeudP8mslptPVIhBhOulqZF1YuUkk?=
 =?us-ascii?Q?k6kpPFA1LzcD9SB8KZHm0/4bTm4Tb+7h6+cNfVB24NWXvr7UZ4QYuuWViqby?=
 =?us-ascii?Q?hVbP5e2eDmwhcJ7bnvZnHSc23k+vqaKjiRuD2I+9AXt4bkOp0hx7195iSu97?=
 =?us-ascii?Q?xjb3hhYumNKNn1fZSq5NHWGF3Qh8NqQoESAkgiQa6tDyQfFQZIlZw9VIdz5p?=
 =?us-ascii?Q?5EWJuPIiJVBUQCPEZ7TpGQOENHLlHqJYP7LFKNgBwiy8w+NmItWwiIPNy36E?=
 =?us-ascii?Q?FADMP5MMI2zVZ/0cZsUzp5h6FP2w7X/kJEoBbSSBfFC3DXQzMeQvk5FLkdsx?=
 =?us-ascii?Q?ndZwaXatEo2zLofyMLHXHw7duhs9+z6OV8tLPUZ8VMSkUvlXyvbIhsFSXArp?=
 =?us-ascii?Q?NEVQnDwAgIX/n5timc/vuvV8XzOi//hODLkeKbUpo4aQ/xUj1nOqmJTYzXfd?=
 =?us-ascii?Q?Wj7808eicA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d32baf-64f9-4fee-7a2f-08de65678b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 10:07:32.7071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZXKqrms6o/sJupTLK3ZXJV4Nyv+EUpFNS0zUUG1HqizSd0ffb3o7M3WC9eBL4qRafN1NiWQWYUsqGMZ+dpwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Friday 30 January 2026 11:42
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>; Wu, Jingjing <jingjing.wu@intel.com>; Shetty=
,
> Praveen <praveen.shetty@intel.com>
> Subject: [PATCH v3 03/36] net/intel: create common post-Tx cleanup functi=
on
>=20
> The code used in ice, iavf, idpf and i40e for doing cleanup of mbufs
> after they had been transmitted was identical. Therefore deduplicate it
> by moving to common and remove the driver-specific versions.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx.h             | 53 ++++++++++++++++++++
>  drivers/net/intel/i40e/i40e_rxtx.c        | 49 ++----------------
>  drivers/net/intel/iavf/iavf_rxtx.c        | 50 ++-----------------
>  drivers/net/intel/ice/ice_rxtx.c          | 60 ++---------------------
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 46 ++---------------
>  5 files changed, 71 insertions(+), 187 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index 8cf63e59ab..a89412c195 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -259,6 +259,59 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq,
> ci_desc_done_fn desc_done, bool ctx
>  	return txq->tx_rs_thresh;
>  }
>=20
> +/*
> + * Common transmit descriptor cleanup function for Intel drivers.
> + * Used by ice, i40e, iavf, and idpf drivers.
> + *
> + * Returns:
> + *   0 on success
> + *  -1 if cleanup cannot proceed (descriptors not yet processed by HW)
> + */
> +static __rte_always_inline int
> +ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> +{
> +	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> +	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> +	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> +	uint16_t desc_to_clean_to;
> +	uint16_t nb_tx_to_clean;
> +
> +	/* Determine the last descriptor needing to be cleaned */
> +	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> +	if (desc_to_clean_to >=3D nb_tx_desc)
> +		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> +
> +	/* Check to make sure the last descriptor to clean is done */

This comment is similar to the next one. Maybe merge them?

> +	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> +
> +	/* Check if descriptor is done - all drivers use 0xF as done value in b=
its
> 3:0 */
> +	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> rte_cpu_to_le_64(0xFUL)) !=3D
> +			rte_cpu_to_le_64(0xFUL)) {
> +		/* Descriptor not yet processed by hardware */
> +		return -1;
> +	}
> +
> +	/* Figure out how many descriptors will be cleaned */
> +	if (last_desc_cleaned > desc_to_clean_to)
> +		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> + desc_to_clean_to);
> +	else
> +		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> last_desc_cleaned);
> +
> +	/* The last descriptor to clean is done, so that means all the
> +	 * descriptors from the last descriptor that was cleaned
> +	 * up to the last descriptor with the RS bit set
> +	 * are done. Only reset the threshold descriptor.
> +	 */
> +	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> +
> +	/* Update the txq to reflect the last descriptor that was cleaned */
> +	txq->last_desc_cleaned =3D desc_to_clean_to;
> +	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> +
> +	return 0;
> +}
> +
>  static inline void
>  ci_txq_release_all_mbufs(struct ci_tx_queue *txq, bool use_ctx)
>  {
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index 210fc0201e..2760e76e99 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -384,45 +384,6 @@ i40e_build_ctob(uint32_t td_cmd,
>  			((uint64_t)td_tag  <<
> I40E_TXD_QW1_L2TAG1_SHIFT));
>  }
>=20
> -static inline int
> -i40e_xmit_cleanup(struct ci_tx_queue *txq)
> -{
> -	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> -	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> -	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> -	uint16_t desc_to_clean_to;
> -	uint16_t nb_tx_to_clean;
> -
> -	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> -	if (desc_to_clean_to >=3D nb_tx_desc)
> -		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> -
> -	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> -			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=3D
> -
> 	rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE)) {
> -		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
> -			   "(port=3D%d queue=3D%d)", desc_to_clean_to,
> -			   txq->port_id, txq->queue_id);

These logs are lost in each of the drivers. I'm not sure if they're terribl=
y
helpful though so I think it's fine that they're dropped.

> -		return -1;
> -	}
> -
> -	if (last_desc_cleaned > desc_to_clean_to)
> -		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> +
> -							desc_to_clean_to);
> -	else
> -		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> -					last_desc_cleaned);
> -
> -	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> -
> -	txq->last_desc_cleaned =3D desc_to_clean_to;
> -	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> -
> -	return 0;
> -}
> -
>  static inline int
>  #ifdef RTE_LIBRTE_I40E_RX_ALLOW_BULK_ALLOC
>  check_rx_burst_bulk_alloc_preconditions(struct ci_rx_queue *rxq)
> @@ -1118,7 +1079,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
> -		(void)i40e_xmit_cleanup(txq);
> +		(void)ci_tx_xmit_cleanup(txq);
>=20
>  	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
>  		td_cmd =3D 0;
> @@ -1159,14 +1120,14 @@ i40e_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  			tx_last =3D (uint16_t)(tx_last - txq->nb_tx_desc);
>=20
>  		if (nb_used > txq->nb_tx_free) {
> -			if (i40e_xmit_cleanup(txq) !=3D 0) {
> +			if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  				if (nb_tx =3D=3D 0)
>  					return 0;
>  				goto end_of_tx;
>  			}
>  			if (unlikely(nb_used > txq->tx_rs_thresh)) {
>  				while (nb_used > txq->nb_tx_free) {
> -					if (i40e_xmit_cleanup(txq) !=3D 0) {
> +					if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  						if (nb_tx =3D=3D 0)
>  							return 0;
>  						goto end_of_tx;
> @@ -2808,7 +2769,7 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue
> *txq,
>  	tx_last =3D txq->tx_tail;
>  	tx_id  =3D swr_ring[tx_last].next_id;
>=20
> -	if (txq->nb_tx_free =3D=3D 0 && i40e_xmit_cleanup(txq))
> +	if (txq->nb_tx_free =3D=3D 0 && ci_tx_xmit_cleanup(txq))
>  		return 0;
>=20
>  	nb_tx_to_clean =3D txq->nb_tx_free;
> @@ -2842,7 +2803,7 @@ i40e_tx_done_cleanup_full(struct ci_tx_queue
> *txq,
>  			break;
>=20
>  		if (pkt_cnt < free_cnt) {
> -			if (i40e_xmit_cleanup(txq))
> +			if (ci_tx_xmit_cleanup(txq))
>  				break;
>=20
>  			nb_tx_to_clean =3D txq->nb_tx_free - nb_tx_free_last;
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 807bc92a45..560abfc1ef 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -2324,46 +2324,6 @@ iavf_recv_pkts_bulk_alloc(void *rx_queue,
>  	return nb_rx;
>  }
>=20
> -static inline int
> -iavf_xmit_cleanup(struct ci_tx_queue *txq)
> -{
> -	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> -	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> -	uint16_t desc_to_clean_to;
> -	uint16_t nb_tx_to_clean;
> -
> -	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> -
> -	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> -	if (desc_to_clean_to >=3D nb_tx_desc)
> -		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> -
> -	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> -			rte_cpu_to_le_64(IAVF_TXD_QW1_DTYPE_MASK)) !=3D
> -
> 	rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE)) {
> -		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
> -			   "(port=3D%d queue=3D%d)", desc_to_clean_to,
> -			   txq->port_id, txq->queue_id);
> -		return -1;
> -	}
> -
> -	if (last_desc_cleaned > desc_to_clean_to)
> -		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> +
> -							desc_to_clean_to);
> -	else
> -		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> -					last_desc_cleaned);
> -
> -	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> -
> -	txq->last_desc_cleaned =3D desc_to_clean_to;
> -	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> -
> -	return 0;
> -}
> -
>  /* Check if the context descriptor is needed for TX offloading */
>  static inline uint16_t
>  iavf_calc_context_desc(struct rte_mbuf *mb, uint8_t vlan_flag)
> @@ -2768,7 +2728,7 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
> -		iavf_xmit_cleanup(txq);
> +		ci_tx_xmit_cleanup(txq);
>=20
>  	desc_idx =3D txq->tx_tail;
>  	txe =3D &txe_ring[desc_idx];
> @@ -2823,14 +2783,14 @@ iavf_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  			txq->port_id, txq->queue_id, desc_idx, desc_idx_last);
>=20
>  		if (nb_desc_required > txq->nb_tx_free) {
> -			if (iavf_xmit_cleanup(txq)) {
> +			if (ci_tx_xmit_cleanup(txq)) {
>  				if (idx =3D=3D 0)
>  					return 0;
>  				goto end_of_tx;
>  			}
>  			if (unlikely(nb_desc_required > txq->tx_rs_thresh)) {
>  				while (nb_desc_required > txq->nb_tx_free) {
> -					if (iavf_xmit_cleanup(txq)) {
> +					if (ci_tx_xmit_cleanup(txq)) {
>  						if (idx =3D=3D 0)
>  							return 0;
>  						goto end_of_tx;
> @@ -4300,7 +4260,7 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
>  	tx_id =3D txq->tx_tail;
>  	tx_last =3D tx_id;
>=20
> -	if (txq->nb_tx_free =3D=3D 0 && iavf_xmit_cleanup(txq))
> +	if (txq->nb_tx_free =3D=3D 0 && ci_tx_xmit_cleanup(txq))
>  		return 0;
>=20
>  	nb_tx_to_clean =3D txq->nb_tx_free;
> @@ -4332,7 +4292,7 @@ iavf_tx_done_cleanup_full(struct ci_tx_queue *txq,
>  			break;
>=20
>  		if (pkt_cnt < free_cnt) {
> -			if (iavf_xmit_cleanup(txq))
> +			if (ci_tx_xmit_cleanup(txq))
>  				break;
>=20
>  			nb_tx_to_clean =3D txq->nb_tx_free - nb_tx_free_last;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index e3ffbdb587..7a33e1e980 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3023,56 +3023,6 @@ ice_txd_enable_checksum(uint64_t ol_flags,
>  	}
>  }
>=20
> -static inline int
> -ice_xmit_cleanup(struct ci_tx_queue *txq)
> -{
> -	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> -	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> -	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> -	uint16_t desc_to_clean_to;
> -	uint16_t nb_tx_to_clean;
> -
> -	/* Determine the last descriptor needing to be cleaned */
> -	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> -	if (desc_to_clean_to >=3D nb_tx_desc)
> -		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> -
> -	/* Check to make sure the last descriptor to clean is done */
> -	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -	if (!(txd[desc_to_clean_to].cmd_type_offset_bsz &
> -	    rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE))) {
> -		PMD_TX_LOG(DEBUG, "TX descriptor %4u is not done "
> -			   "(port=3D%d queue=3D%d) value=3D0x%"PRIx64,
> -			   desc_to_clean_to,
> -			   txq->port_id, txq->queue_id,
> -			   txd[desc_to_clean_to].cmd_type_offset_bsz);
> -		/* Failed to clean any descriptors */
> -		return -1;
> -	}
> -
> -	/* Figure out how many descriptors will be cleaned */
> -	if (last_desc_cleaned > desc_to_clean_to)
> -		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> +
> -					    desc_to_clean_to);
> -	else
> -		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> -					    last_desc_cleaned);
> -
> -	/* The last descriptor to clean is done, so that means all the
> -	 * descriptors from the last descriptor that was cleaned
> -	 * up to the last descriptor with the RS bit set
> -	 * are done. Only reset the threshold descriptor.
> -	 */
> -	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> -
> -	/* Update the txq to reflect the last descriptor that was cleaned */
> -	txq->last_desc_cleaned =3D desc_to_clean_to;
> -	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> -
> -	return 0;
> -}
> -
>  /* Construct the tx flags */
>  static inline uint64_t
>  ice_build_ctob(uint32_t td_cmd,
> @@ -3180,7 +3130,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
> -		(void)ice_xmit_cleanup(txq);
> +		(void)ci_tx_xmit_cleanup(txq);
>=20
>  	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
>  		tx_pkt =3D *tx_pkts++;
> @@ -3217,14 +3167,14 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  			tx_last =3D (uint16_t)(tx_last - txq->nb_tx_desc);
>=20
>  		if (nb_used > txq->nb_tx_free) {
> -			if (ice_xmit_cleanup(txq) !=3D 0) {
> +			if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  				if (nb_tx =3D=3D 0)
>  					return 0;
>  				goto end_of_tx;
>  			}
>  			if (unlikely(nb_used > txq->tx_rs_thresh)) {
>  				while (nb_used > txq->nb_tx_free) {
> -					if (ice_xmit_cleanup(txq) !=3D 0) {
> +					if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  						if (nb_tx =3D=3D 0)
>  							return 0;
>  						goto end_of_tx;
> @@ -3459,7 +3409,7 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
>  	tx_last =3D txq->tx_tail;
>  	tx_id  =3D swr_ring[tx_last].next_id;
>=20
> -	if (txq->nb_tx_free =3D=3D 0 && ice_xmit_cleanup(txq))
> +	if (txq->nb_tx_free =3D=3D 0 && ci_tx_xmit_cleanup(txq))
>  		return 0;
>=20
>  	nb_tx_to_clean =3D txq->nb_tx_free;
> @@ -3493,7 +3443,7 @@ ice_tx_done_cleanup_full(struct ci_tx_queue *txq,
>  			break;
>=20
>  		if (pkt_cnt < free_cnt) {
> -			if (ice_xmit_cleanup(txq))
> +			if (ci_tx_xmit_cleanup(txq))
>  				break;
>=20
>  			nb_tx_to_clean =3D txq->nb_tx_free - nb_tx_free_last;
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
> b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 51074bda3a..23666539ab 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -1326,46 +1326,6 @@ idpf_dp_singleq_recv_scatter_pkts(void
> *rx_queue, struct rte_mbuf **rx_pkts,
>  	return nb_rx;
>  }
>=20
> -static inline int
> -idpf_xmit_cleanup(struct ci_tx_queue *txq)
> -{
> -	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> -	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> -	uint16_t desc_to_clean_to;
> -	uint16_t nb_tx_to_clean;
> -
> -	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> -
> -	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
> -	if (desc_to_clean_to >=3D nb_tx_desc)
> -		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> -
> -	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> -	     rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) !=3D
> -	    rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE)) {
> -		TX_LOG(DEBUG, "TX descriptor %4u is not done "
> -		       "(port=3D%d queue=3D%d)", desc_to_clean_to,
> -		       txq->port_id, txq->queue_id);
> -		return -1;
> -	}
> -
> -	if (last_desc_cleaned > desc_to_clean_to)
> -		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc - last_desc_cleaned)
> +
> -					    desc_to_clean_to);
> -	else
> -		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> -					    last_desc_cleaned);
> -
> -	txd[desc_to_clean_to].cmd_type_offset_bsz =3D 0;
> -
> -	txq->last_desc_cleaned =3D desc_to_clean_to;
> -	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> -
> -	return 0;
> -}
> -
>  /* TX function */
>  RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts)
>  uint16_t
> @@ -1404,7 +1364,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>=20
>  	/* Check if the descriptor ring needs to be cleaned. */
>  	if (txq->nb_tx_free < txq->tx_free_thresh)
> -		(void)idpf_xmit_cleanup(txq);
> +		(void)ci_tx_xmit_cleanup(txq);
>=20
>  	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
>  		td_cmd =3D 0;
> @@ -1437,14 +1397,14 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		       txq->port_id, txq->queue_id, tx_id, tx_last);
>=20
>  		if (nb_used > txq->nb_tx_free) {
> -			if (idpf_xmit_cleanup(txq) !=3D 0) {
> +			if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  				if (nb_tx =3D=3D 0)
>  					return 0;
>  				goto end_of_tx;
>  			}
>  			if (unlikely(nb_used > txq->tx_rs_thresh)) {
>  				while (nb_used > txq->nb_tx_free) {
> -					if (idpf_xmit_cleanup(txq) !=3D 0) {
> +					if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  						if (nb_tx =3D=3D 0)
>  							return 0;
>  						goto end_of_tx;
> --
> 2.51.0

