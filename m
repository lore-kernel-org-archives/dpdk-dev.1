Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2317CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E99D1402AE;
	Tue, 14 Oct 2025 15:26:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A2A74402A8;
 Tue, 14 Oct 2025 15:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760448395; x=1791984395;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sISzLyhAf8k67VAHYIYYOqpeSaJpbiC46il0gGLLRZ0=;
 b=RBZZ4LhPLV65DcVjZpH2WVMC9o8G5POOBaAJMC0Edfpunpg8kM0CRN/9
 zMCjJ9QuMu3/Aeul6MF/G/oZkLwHfckR5Vk6BWrfwO0CB4EJk3QD3T92r
 jx7TiZrtE2a2J+QvCixVB6scd0IJkweXhpPzffUAtvYq6whLdZXtvLzzL
 NU13djLcK8UPVfisyoylj2tMmx9/Hw5aO/8uTXXw1DXt4k0HWlAmdgtsq
 Do8lEYSe6LPqOaMKFDA1DLXqNJIKIDdAfMO/ielG2zktwXfNpZQq2HXdn
 X6n1lWjqJOopI3QLC7P7vAY5dQykjSGyoFpqhJ/q6sAtRky+z27r+k4/m A==;
X-CSE-ConnectionGUID: Jgbf5qIPT7StEVhS0QzNgA==
X-CSE-MsgGUID: VkajKkc0TCeaBqiNTHjztw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61642524"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="61642524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 06:26:34 -0700
X-CSE-ConnectionGUID: 1HtXvvNxRkSygGNRxTp6Fw==
X-CSE-MsgGUID: 172YoZErT4mxMxnPgGpfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="187183561"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 06:26:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:26:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 06:26:33 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 06:26:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpHr2TIkQ5nUE1eV/RUvVyc4JwqQaC9eHHfBS8t8y8UJqzjMJHoFpGWv1g7Qeb+6XDlY53eatGY/veC+euOUN1eD5BIwIHJMqC7TwZBxwqi9/2NOvSh5D+claAivGCAZcocPbd85xAUUWD3g5/crJLJVszmCCnlZOa8mjSqiUYdDaLoeOplQ9KcXsTM7QqTaWqM4gavPIdttqqBuodFUZ8x7GJV0NIPdbBMrm18pImqOu3jXtUr0/WYNgX7b+SwMpL7rrc7i9DNUoPEpAywO6Gk1y22to1SsnmYUwTENJHP7Z/cmWhVuTMuSBBRgSPCWdzQoSj1FZoU2ctZZYNsSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sISzLyhAf8k67VAHYIYYOqpeSaJpbiC46il0gGLLRZ0=;
 b=JghtAbcfjJmRCxVoyjkka5rDlsRZHF2K7Mptrp+C+3FnoHAGO/wItBWhxyZp0wtiSdyI/d+SCinnUvRtXY2QqVm4KM+Jpz2Xv+cWrNLSVSfDucKmCIVok0IbKF3AYpW97oIQn7nsYKgIWVOEYpIUgAZ7dduO/ZgYTV+hvIRPZtXPf9L0u/YBvnwHlUr5d5zoXMJebOtb8PrtCiXHSwRm3xunXPyjxSoUHlDIfgioix/J2IXxY4X90l7MwzlHQWu8tY57VG2ZRG6jlUQl5AdFOmXJbWQE8DqkR1NItqqR+A9I2HvjiTY88B5D6j3IiLyS1Aey6cGnMbnNxXWONWHqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by MW5PR11MB5858.namprd11.prod.outlook.com
 (2603:10b6:303:193::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 13:26:26 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::1160:23e3:5599:988c%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 13:26:25 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: RE: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Topic: [PATCH 1/2] net/iavf: support VF initiated resets
Thread-Index: AQHcMU3AqHIGIyG6mU6GyIhfLzcII7SrcJsAgAGJkoCAA0L78IAH2KkAgAGWzBCAAEs9AIABffxQgAZB9ICAAABZMA==
Date: Tue, 14 Oct 2025 13:26:25 +0000
Message-ID: <DM3PPF7D18F34A11187D26E532A3554CCE08EEBA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <2774555.irdbgypaU6@thomas>
 <IA3PR11MB8986D47057F5DE567C811B548EEFA@IA3PR11MB8986.namprd11.prod.outlook.com>
 <16117372.JCcGWNJJiE@thomas>
In-Reply-To: <16117372.JCcGWNJJiE@thomas>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|MW5PR11MB5858:EE_
x-ms-office365-filtering-correlation-id: 841a4873-abdc-452f-451d-08de0b254692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Uy9YaEc2QW9KQ0hpMlo3WEtlMEFxWTBnbWdETDc4ZUFlbUVCdFRMOTJrT0Qy?=
 =?utf-8?B?V3N5YnkyTDhGMUdHcmpkZU4rWlREbExVMG54VmJJcFZDeTQ4a3QrWjQ1cmpz?=
 =?utf-8?B?bVdOckdzSjQ3SDFHTGtEWndCYm9GMFRBa2FoakluTnhoV05ONUpLS3BiQ1FM?=
 =?utf-8?B?UWdvUWtGMkl2Rkd0TG5qRW43VEdXQjV3cnNLWkN3Nk9nTW03dkFZc2FFU0dE?=
 =?utf-8?B?NXlRUlhWdXVoNUQzVmpIcXNrVlp2ZTFvTEo5a2xNeG9TODByME5sam5nU2VZ?=
 =?utf-8?B?R0FwZG84S1lCOVlyZ3ZKeWpDNlV4TjlzOG1MaEhxRkRPTGhmYTdTd0JuTUt2?=
 =?utf-8?B?UGxMbXNKZVN3ZWpTZS9YaU1XZ0h2OWhZRmhMRjNwTE5MREZqVmllVzg4aGJs?=
 =?utf-8?B?Q2xwUm1Ba0VnYWxISWV5MHAyUld6ekp6TlNoRHhaRTVKQ25GUi9RVXVyQklE?=
 =?utf-8?B?UmVYelFDTTNlZXZKWEZKeW5USTRkYWZXdEI4WXRGZzNXS0NhQVk2NjRvbnVp?=
 =?utf-8?B?bjdxT0xBeW9HRXYwQ0JTelJ3TmVubXJCNG1ZU3UvaTRrK3BQSmNlVjdrMERO?=
 =?utf-8?B?Tzg4bjBpZXYxYlVLaktxaWtUYTM2WWpXY2pMMlFvZ2VyMFk5dEhGRzl3RndO?=
 =?utf-8?B?VjdXcXB1L2l4cW0rSURWb3Z6QUhhQnRZOGIyL3FFOXpKUDBBcGFMbkRGYXJL?=
 =?utf-8?B?NHNxM3hXaUM3aEtEWW1rQ0NrZ1h5Z1E1ZHJrTFBGa3RXMzlEYWZGK25VbnZY?=
 =?utf-8?B?NXlkeFJRUVcxaWEzZG54UHE4Y3B2bUt4Qmwxc3pGTjdVY1d6akd5RnRsY1FB?=
 =?utf-8?B?emJ3R3NZaFhTcFJldytuR085T1ordTVCdGVLRlRjaWFUMHI4U0FUVENqS1hS?=
 =?utf-8?B?d0phbnJ5UzdkMWhobE56MWJ4QTJ0VFY3YkVJVEs1Tm5uN3VLRkFvbTl2MTJ2?=
 =?utf-8?B?ajRsV0R6SDAwZnFtaXM0MnlrU1BpeUx3TWtXOTJjMUlHNTMrT1I5Y3p5Nm10?=
 =?utf-8?B?VjJqWE1SL0NiWGpYSXRJSzNqaTdiNVU1NEMvdkNoMVdqcE1DUnVwMFAwU2Rn?=
 =?utf-8?B?eWdUQXBLOVRMUG96TzhUeVJmMnA1YXZ4ZnNJYXVVQTVEM2hPbjh3ZllXMEwx?=
 =?utf-8?B?SVgxSWtIQVprM2J5SDJVb3R0N3E2clk4eFUvVm94QzBuQkFDZnJUNGRHUFA0?=
 =?utf-8?B?TFRqVEM5OWh5SnN1bXhNMzA4bkpGTmhyTmdnTDNrakRDZWdTeXBIaE5lRjJY?=
 =?utf-8?B?T2lWUEVVSEJ0amVVcXRYNnkrdHlkVXhBWGFzY1BqMlMvZkxiVXpld2pMTVpj?=
 =?utf-8?B?RjNEVGtYelRweDdDQzRKSnJNc0ZTb29xMVBLU29ib2k1U01Ma2gxMmRwUDRR?=
 =?utf-8?B?aGNpQ3dHZzBySXN1SDlpK3VsRFd4SDd1SERFZmxYWVdTc2k3dWVwaTBma3FZ?=
 =?utf-8?B?UU1zdThkcGpCcktoTlF4RDJ2cWNucVVoN0tFRC9xeFgvcmhKYU1vSVlaM1Av?=
 =?utf-8?B?MzRPRG1qV2NtVGwvaEJ5RVNIaXdoUmgySldYTHJsR0JHWTdqUlRSUms3YzR5?=
 =?utf-8?B?dTZSOURtME9wZXpWNmYvNXlGd1pzTUNzdjZEcC83RDRsdCthUDNDc3JlRVIv?=
 =?utf-8?B?R0lNbzRLVEpQaUtYYlV0MUJLK2tFZ0JLVjVBOXA4OVFNK00wRnRBVnR6MmhB?=
 =?utf-8?B?K01TZTdwdmpJV3RONk10TFhFdzlVdC9tMHJrVWdYYTRyQ0ROSjEwa2s1dnBK?=
 =?utf-8?B?VGpGaER2MlBzSGJGRTFjQXQ0QXBJVVlmam1jdFpZVlA5S0YzNzhYOVFkSjVu?=
 =?utf-8?B?TS9Lc0VFUDFqRDRhZVNrUDhwam5Yckl6K3NXQ09HNmMwcTVENmdhRjB2bFhx?=
 =?utf-8?B?d0ZSQVJERmliSVhWZm5ZclNYdUtYZEtqUWhVdXo3cG9mZS9JZk9ROXBHOHQ3?=
 =?utf-8?B?TTVYeEdIUUxPek9aeEtNeUNidlFncXQvTjVRUVYrbUxxMmhDTU9nK3gyMFUz?=
 =?utf-8?B?NG4zQ21RQXh4QmM5RURkaTBtMXI4NkZ0ZTdYa2thQy9RVTdyemdRUmJINEo3?=
 =?utf-8?Q?onOKvl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzY3TkFWcmNjckYyTDVrT3lzN0hVVHBzR0JVODBheUgrNUV5eFEraEhEWU5N?=
 =?utf-8?B?NlozUDRoREZ5eCtxUWdCcktmSVQrZit1ZjcxZjBlcWJMUlBxbkI3YmJaazhh?=
 =?utf-8?B?U2plSU4wMyt3cUNnRXlNV3Y1MDRpdFJsYWZBM3BlcUtZM0c2WlI3bU9LZUcz?=
 =?utf-8?B?OUFialFZbm9RMG8rK1ljVFI4djJFdS9FRmNyZ2RuTEhxZFdDalJlSU5VVmpN?=
 =?utf-8?B?R29GT01vZEdmVElHZ2RqdmNHTThRYWpWK1krcEMrSS9BUFN4T1hjZlJCRDJ3?=
 =?utf-8?B?ZzVHZERPK2VXUTlaZGR0MGJnQWp6N09TeTZBUHNpMVdTb0RWRGl2aXRFdGF3?=
 =?utf-8?B?bDM5SEdhV2FVdGdGd3lBODFOUUt3a0dzK0FVeFhzeGlRenJraW9najlicHpT?=
 =?utf-8?B?a2RLays3dUJLeW9aTElOalA3b3VUVFpVUWd5MkRoYUJCTTZMSkVSTEtzRWJs?=
 =?utf-8?B?VGFNM3FjYlV0RnpQNnJ2TzlydjIzcW15NGRMNHQxOUFlZGNzdWw2NGh0U1lm?=
 =?utf-8?B?UkZnOGJ6bEpUcEg1U0tFNjQxTUtaM3RFSC9jdWFieFpGbUFyZFZMK2RrY0lF?=
 =?utf-8?B?M2xtYnpPeWlmOXVsS3V5bGFpUGRYN2FCSEJDQW9MdU02am0xR2x1ZEN5eFhl?=
 =?utf-8?B?aGN4V1NCTzVsNHJtRE9FZ3pQSThzL0pTT25UVkp0NnNibytxekNFUU81Ymsv?=
 =?utf-8?B?OXRqdjVhdFFONGpkajlaVGwrZlJZZmRES1JYck85QjhWL29zc1c3MUhpTWQ2?=
 =?utf-8?B?QzRYbFdzU09vS0J0dkxVZitjTGxsMGVHbDlKY3JOWlhEUFIrWFVPUlFBOEVp?=
 =?utf-8?B?NEVWT3UzYVoyK1R0NVF6eGJRbGx3cHEvd3dPQlZNdUNDVk42R3JsMEJFcitP?=
 =?utf-8?B?Wm9rRlFmU1RuR2FycFF1eXVzOE56UHI4ayszTUZSak41ZC9MWTl3S1ZMdUM4?=
 =?utf-8?B?L0xnR1lWOS9RSzNNSTQyOG5JWHI1Mml1T3hyYmFDWTJQVFFrb0xrTXJpVDZU?=
 =?utf-8?B?aVpYTy81NXJra1lFc3BiZkdMMGt5WjJFSEVUalIzY2ErenEwNVRmbzgzSTc1?=
 =?utf-8?B?S1l2UnE2OSt5WGtBRFRkV05zZlQvd1BOWkViV3pBSUZ4VTJjNHZGRkVVeWpZ?=
 =?utf-8?B?TForeTdFM1d6SEtmZEFNbVQwMVA0dnFRaTJ4eGxRY05WM0l5SGpqbWtVU09R?=
 =?utf-8?B?VHovSEZEMVIxK05GemdOVzhkTUREK2tNRFM2Q2VaVnh5TE5lNHdicytzQjFB?=
 =?utf-8?B?NkhBN0RCL3lhaUpSSE5ONTdWSFZSUWUwU3h1MjZ4UjVTbTdLN1JreUhTS1VY?=
 =?utf-8?B?a1drWktzQTdFbnF6U2NWL3lWZzBkTkRGcWtPQmVJM1IrVDMrRTBXclpsMkJp?=
 =?utf-8?B?RVZvYnFpVUcweVV1RitBclgyL21UVWlId0IrOUw3aDdFcEZBd3QyenJMc09L?=
 =?utf-8?B?MU1jcWNtSmhCRFQvcGl5ZTFMZjhqYzcvSkh3YWd1R3AzMTJncmxrSDdpUGky?=
 =?utf-8?B?TERpMUJUaXlZUDBBSTJuQ1JWd2lMSm1wZXFSdCtxV2c0T1pncU9lR1FIOGlZ?=
 =?utf-8?B?UUFrK3ByZHpYN2JBRk56cTA5ZmhKak1pK0dyUVBnalU4azJaWmZyVXJJK2dj?=
 =?utf-8?B?dFhGZ2E2MXBXaWdXN29UOXZIVU9saFcxbzc2T1BKWXFScGErSWFLb2xjdkpu?=
 =?utf-8?B?Uk5NM0RLYWZlWTQ2RFpOeTBJSURJQ0RpOFd0c1ROalJjSkFVK3UvbUVIdmdH?=
 =?utf-8?B?MjBidGFHVnNmTngvU1ZYNEtib3hZWi9NOE5sa01ES3FObzB4eEI1cUJOMWpW?=
 =?utf-8?B?UVovQmgybEtJNkZ4bEp0V1NqRnVLdGl5ZTgzWXByeldhZnZIOXdST0UyY1VG?=
 =?utf-8?B?dFJYZ2d5NDJERHo2dEtkR2ZDbWhhN29pSFZ4emhhT3g2cXp0SG1jczUwcm5F?=
 =?utf-8?B?SGNvbmorTEpza0dnWmZZczlnL1o2anJkTVRZSnhrTUorNVMxUDFoVUFwS0RL?=
 =?utf-8?B?YjFqSGNNMTE5MTRrMjVlVExCeldmMUQzSUIxVHRSc1U5amI1djJvcEdHRlB4?=
 =?utf-8?B?OEZncjBWblBlWHdzNHYxdDB6Y1JUdXVQVHhwWlFEMHkrWEkyTVFYeGJFeGF0?=
 =?utf-8?Q?ZJC57OErMzv5qKBkUisaHSJpy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a4873-abdc-452f-451d-08de0b254692
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 13:26:25.8423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLUR8Hq//zCT/u5D461Jcuu5OMsaVSxL0H/2OdgWyB/2TMrxLtzprI7AjoJigJ7weN5O/9gXqnfXaaF8o2KPHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
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

PiANCj4gMTAvMTAvMjAyNSAxNTo0OCwgTG9mdHVzLCBDaWFyYToNCj4gPiA+DQo+ID4gPiAwOS8x
MC8yMDI1IDEyOjMwLCBMb2Z0dXMsIENpYXJhOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gMDMvMTAv
MjAyNSAxMjoyOSwgTG9mdHVzLCBDaWFyYToNCj4gPiA+ID4gPiA+ID4gPiA+IEludHJvZHVjZSBh
IGZ1bmN0aW9uIHRoYXQgYWxsb3dzIGEgVkYgdG8gcmVxdWVzdCB0aGUgUEYgdG8gcmVzZXQNCj4g
PiA+IGl0c2VsZi4NCj4gPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMgdXNlZnVsIGZvciBleGFtcGxl
IHdoZW4gdGhlIGFwcGxpY2F0aW9uIGRldGVjdHMgdGhhdCBvbmUNCj4gb2YNCj4gPiA+IHRoZQ0K
PiA+ID4gPiA+ID4gPiA+ID4gcXVldWVzIGhhdmUgaHVuZyBvciBhbnkgZXZlbnQgd2hlcmUgYSBy
ZXNldCBpcyByZXF1aXJlZCBhbmQgdGhlDQo+IFBGDQo+ID4gPiBpcw0KPiA+ID4gPiA+ID4gPiA+
ID4gdW5saWtlbHkgdG8gdHJpZ2dlciBpdC4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
Wy4uLl0NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEluIGdlbmVyYWwsIEknbSBu
b3QgYSBodWdlIGZhbiBvZiBhZGRpbmcgZHJpdmVyLXNwZWNpZmljIGZ1bmN0aW9ucw0KPiBhbmQg
SQ0KPiA+ID4gPiA+ID4gPiA+IGZlZWwgbGlrZSB0aGlzIHNob3VsZCBmaXQgdW5kZXIgdGhlIGV4
aXN0aW5nIHJlc2V0IEFQSXMgaW4gc29tZSB3YXkuDQo+IFRoYXQNCj4gPiA+ID4gPiA+ID4gPiBz
aG91bGQgYXZvaWQgdGhlIG5lZWQgdG8gdXBkYXRlIChvciBzdWNoIGEgYmlnIHVwZGF0ZSkgdG8N
Cj4gdGVzdHBtZCwNCj4gPiA+IGZvcg0KPiA+ID4gPiA+ID4gPiA+IGV4YW1wbGUuDQo+ID4gPiA+
ID4gPiA+ID4gU29tZSB0aG91Z2h0cyBoZXJlOg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gMS4gd2UgY291bGQgYWRkIGEgZGV2YXJnIHRvIHRoZSBkcml2ZXIgdG8gYWRqdXN0IHdo
ZXRoZXIgcmVzZXQNCj4gZG9lcyBhDQo+ID4gPiA+ID4gPiA+ID4gICAgInNvZnRlciIgcmVzZXQg
b2YgdGhlIFZGIGp1c3QgcmVzZXR0aW5nIGl0c2VsZiwgb3IgYSAiaGFyZCIgcmVzZXQNCj4gd2hl
cmUNCj4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ICAgIFBGIGRvZXMgYSBmdWxsZXIgcmVzZXQg
b2YgdGhlIFZGLg0KPiA+ID4gPiA+ID4gPiA+IDIuIHJhdGhlciB0aGFuIGEgZGV2YXJnLCB3b3Vs
ZCBkbyB1c2UgYSBkcml2ZXItc3BlY2lmaWMgZnVuY3Rpb24gdG8NCj4gPiA+IGFkanVzdA0KPiA+
ID4gPiA+ID4gPiA+ICAgIHRoaXMgYmVoYXZpb3VyLiBUaGUgZGlmZmVyZW5jZSBoZXJlIHdvdWxk
IGJlIHRoYXQgdGhlIGRyaXZlci0NCj4gc3BlY2lmaWMNCj4gPiA+ID4gPiA+ID4gPiAgICBmdW5j
dGlvbiB3b3VsZCBiZSBhbiBpbml0LXRpbWUgb25lIHJhdGhlciB0aGFuIHJ1bnRpbWUsIHNvIHRo
ZQ0KPiA+ID4gcnVudGltZQ0KPiA+ID4gPiA+IG9mDQo+ID4gPiA+ID4gPiA+ID4gICAgdGhlIGFw
cCwgbGlrZSB0ZXN0cG1kLCB3b3VsZCBiZSBnZW5lcmljLg0KPiA+ID4gPiA+ID4gPiA+IDMuIHRo
ZSBtb3N0IGdlbmVyaWMgc29sdXRpb24gd291bGQgYmUgdG8gYWRkIGFuIGFkZGl0aW9uYWwNCj4g
cGFyYW1ldGVyDQo+ID4gPiB0bw0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiA+ICAgIHJl
c2V0KCkgZnVuY3Rpb24gaXRzZWxmIHRvIHNwZWNpZnkgYSBoYXJkIG9yIHNvZnQgcmVzZXQuIFRo
aXMgd291bGQNCj4gPiA+IG1lYW4NCj4gPiA+ID4gPiA+ID4gPiAgICB1cGRhdGluZyBhbGwgZHJp
dmVycyB0byBoYW5kbGUgdGhlIG5ldyBwYXJhbWV0ZXIgKHNob3VsZG4ndCBiZQ0KPiBoYXJkLA0K
PiA+ID4gPiA+IHNpbmNlDQo+ID4gPiA+ID4gPiA+ID4gICAgaXQgd291bGQgYmUgX19ydGVfdW51
c2VkIGluIGFsbCBjYXNlcyBieSBkZWZhdWx0KS4gVGhpcyBhbHNvIG9wZW5zDQo+IHVwDQo+ID4g
PiA+ID4gPiA+ID4gICAgdGhlIHBvc3NpYmlsaXR5IG9mIG90aGVyIGRyaXZlcnMgLSBlc3BlY2lh
bGx5IFZGcyAtIHVzaW5nIGl0IGluIHRoZQ0KPiBzYW1lDQo+ID4gPiA+ID4gPiA+ID4gICAgd2F5
LiBXZSBjb3VsZCBhY3R1YWxseSBkb2N1bWVudCB0aGF0IHRoZSAiaGFyZCIgb3B0aW9uICJtYXkg
YmUNCj4gPiA+IHVzZWQNCj4gPiA+ID4gPiBieQ0KPiA+ID4gPiA+ID4gPiBWRg0KPiA+ID4gPiA+
ID4gPiA+ICAgIGRyaXZlcnMgdG8gcmVxdWVzdCBhIGZ1bGwgcmVzZXQgb2YgdGhlIFZGIGJ5IHRo
ZSBQRiIuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhpIEJydWNlLA0KPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiBJIGRpZCBub3QgbWFrZSBpdCBjbGVhciBpbiBteSBjb21taXQg
bWVzc2FnZXMgdGhlIGZ1bGwgcHVycG9zZSBvZg0KPiB0aGlzDQo+ID4gPiBuZXcNCj4gPiA+ID4g
PiBBUEkuDQo+ID4gPiA+ID4gPiA+IEFsb25nIHdpdGggcmVzZXR0aW5nIHRoZSBWRiwgdGhlIFZG
IGlzIGFsc28gcmVjb25maWd1cmVkIGFuZCByZXN0YXJ0ZWQNCj4gPiA+ID4gPiA+ID4gdHJhbnNw
YXJlbnRseSwgdXNpbmcgdGhlIGV4aXN0aW5nIGlhdmZfaGFuZGxlX2h3X3Jlc2V0DQo+IGltcGxl
bWVudGF0aW9uLg0KPiA+ID4gPiA+ID4gPiBXaGlsZSB0aGVyZSBpcyBwcm9iYWJseSBtZXJpdCBp
biBleHRlbmRpbmcgdGhlIHJlc2V0IEFQSSB0byBpbmNsdWRlIGENCj4gPiA+ID4gPiBzb2Z0L2hh
cmQNCj4gPiA+ID4gPiA+ID4gcmVzZXQgZmxhZywgSSB3b3VsZCBzdGlsbCBuZWVkIHRoaXMgbmV3
IEFQSSB0byBmdWxmaWwgdGhlIHB1cnBvc2UNCj4gZGVzY3JpYmVkDQo+ID4gPiA+ID4gYWJvdmUu
DQo+ID4gPiA+ID4gPiA+IElmIHdlIHdhbnRlZCB0byBtYWtlIHRoaXMgZ2VuZXJpYyBJIHNlZSB0
d28gb3B0aW9uczoNCj4gPiA+ID4gPiA+ID4gMS4gZXh0ZW5kIHRoZSByZXNldCBBUEkgdG8gb3B0
aW9uYWxseSByZWNvbmZpZ3VyZSBhbmQgcmVzdGFydA0KPiA+ID4gPiA+ID4gPiAyLiBpbnRyb2R1
Y2UgYSBuZXcgZ2VuZXJpYyBBUEkgdGhhdCBwZXJmb3JtcyBhIHJlc2V0IGZvbGxvd2VkIGJ5IGEN
Cj4gPiA+ID4gPiByZWNvbmZpZ3VyZQ0KPiA+ID4gPiA+ID4gPiBhbmQgcmVzdGFydC4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBJJ3ZlIHN1Ym1pdHRlZCBhIHYyIGFuZCByZW5hbWVkIHRoZSBm
dW5jdGlvbiB0byAicmVzdG9yZSIgaW5zdGVhZCBvZg0KPiA+ID4gInJlc2V0Ig0KPiA+ID4gPiA+
IHRvDQo+ID4gPiA+ID4gPiBiZXR0ZXIgZGVzY3JpYmUgdGhlIGJlaGF2aW91ciBvZiB0aGUgZnVu
Y3Rpb24gLSBub3QganVzdCByZXNldHRpbmcsIGJ1dA0KPiBhbHNvDQo+ID4gPiA+ID4gPiByZXN0
b3JpbmcgY29uZmlndXJhdGlvbiBhZnRlcndhcmRzIGFuZCByZXN0YXJ0aW5nIHRoZSBkZXZpY2Uu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSSBhZ3JlZSB0aGF0IGl0IHdvdWxkIGJlIGJlc3Qg
dG8gYXZvaWQgYSBkcml2ZXItc3BlY2lmaWMgZnVuY3Rpb24gbGlrZQ0KPiB0aGlzLg0KPiA+ID4g
QWZ0ZXINCj4gPiA+ID4gPiBzb21lDQo+ID4gPiA+ID4gPiB0aG91Z2h0IEkgZG9uJ3QgdGhpbmsg
d2UgY2FuIGV4dGVuZCB0aGUgcmVzZXQgQVBJIHRvIGluY2x1ZGUgdGhpcw0KPiA+ID4gYmVoYXZp
b3VyLA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gcmVzZXQgQVBJIHNob3VsZCBwcm9iYWJs
eSBsZWF2ZSB0aGUgZGV2aWNlIGluIGEgcmVzZXQgc3RhdGUuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gSSdtIHdvbmRlcmluZyBpZiB0aGUgY29tbXVuaXR5IHdvdWxkIGJlIGluIGZhdm91ciBv
ZiBjcmVhdGluZyBhIG5ldw0KPiA+ID4gZXRoZGV2DQo+ID4gPiA+ID4gQVBJDQo+ID4gPiA+ID4g
PiBmb3IgcmVzdG9yaW5nL3JlaW5pdGlhbGlzaW5nIGEgZGV2aWNlLiBJdCB3b3VsZCBlc3NlbnRp
YWxseSBjb21wcmlzZSBvZg0KPiByZXNldCwNCj4gPiA+ID4gPiA+IHJlY29uZmlndXJlIGFuZCBx
dWV1ZSBzZXR1cCwgYW5kIG9wdGlvbmFsbHkgZGV2aWNlIHN0YXJ0Pw0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSXQgaXMgY29uZnVzaW5nIHRvIGFkZCBhbiBBUEkgaWYgaXQgaXMgYSBwZXJmZWN0IG92
ZXJsYXANCj4gPiA+ID4gPiBvZiB3aGF0IGV4aXN0cyBhbHJlYWR5Lg0KPiA+ID4gPiA+IElmIHlv
dSB3YW50IHRvIGFkZCBhIG5ldyBBUEksIHlvdSBuZWVkIHRvIGV4cGxhaW4gaG93IGl0IGlzIGRp
ZmZlcmVudA0KPiA+ID4gPiA+IG9mIGEgY29tYmluYXRpb24gb2YgcmVzZXQvY29uZmlndXJlL3N0
YXJ0Lg0KPiA+ID4gPg0KPiA+ID4gPiBBcG9sb2dpZXMgZm9yIGFueSBjb25mdXNpb24uDQo+ID4g
PiA+IFRoZSBuZXcgQVBJIHdvdWxkIHBlcmZvcm0gb25seSB0aGUgbmVjZXNzYXJ5IHJlY29uZmln
dXJhdGlvbg0KPiA+ID4gPiBhbmQgc2V0dXAgc3RlcHMgdW5kZXItdGhlLWhvb2QgYW5kIHVzZSB0
aGUgZXhpc3RpbmcgZGV2aWNlDQo+ID4gPiA+IGNvbmZpZ3VyYXRpb24uIFRoaXMgd291bGQgZGlm
ZmVyIGZyb20gYSBjb21iaW5hdGlvbiBvZg0KPiA+ID4gPiByZXNldC9yZWNvbmZpZ3VyZS9zdGFy
dCBpbiB0d28gd2F5czoNCj4gPiA+ID4gMS4gSW4gc29tZSBjYXNlcyAoYXQgbGVhc3QgaW4gdGhl
IGNhc2Ugb2YgdGhlIGlhdmYgZHJpdmVyKSwgYQ0KPiA+ID4gPiBmdWxsIHJ0ZV9ldGhfZGV2X2Nv
bmZpZ3VyZSBpcyBub3QgcmVxdWlyZWQgYWZ0ZXIgYW4gcnRlX2V0aF9kZXZfcmVzZXQuDQo+ID4g
PiA+IFNvIHRoZSBuZXcgQVBJIGNvdWxkIGp1c3QgY2FsbCB0aGUgZGV2aWNlIGNhbGxiYWNrcyBm
b3IgdGhvc2UgZnVuY3Rpb25zLA0KPiA+ID4gPiByYXRoZXIgdGhhbiBmb3JjaW5nIHRoZSB1c2Vy
IHRvIGNhbGwgdGhlIGV0aGRldiBmdW5jdGlvbnMgYW5kIHBlcmZvcm0NCj4gPiA+ID4gc29tZSB1
bm5lY2Vzc2FyeSByZWNvbmZpZ3VyYXRpb24gc3RlcHMuDQo+ID4gPiA+IDIuIEl0IHRha2VzIHRo
ZSBidXJkZW4gb2ZmIHRoZSB1c2VyIHRvIGJ1aWxkIHVwIHRoZSBkZXZpY2UgY29uZmlndXJhdGlv
bg0KPiA+ID4gPiBhZ2FpbiBhZnRlciB0aGUgcmVzZXQuIEFueSBwZXJ0aW5lbnQgY29uZmlndXJh
dGlvbiBjYW4gYmUgc3RvcmVkIGJlZm9yZQ0KPiA+ID4gPiB0aGUgcmVzZXQgYW5kIHVzZWQgdG8g
cmVjb25maWd1cmUgdGhlIGRldmljZSB0cmFuc3BhcmVudGx5LiBBbGwgdGhlIHVzZXINCj4gPiA+
ID4gbmVlZHMgdG8gc3VwcGx5IGlzIHRoZSBwb3J0IGlkLg0KPiA+ID4gPg0KPiA+ID4gPiBBbnl3
YXksIEkndmUgc3VibWl0dGVkIGEgdjMgb2YgdGhlIG5vbi1nZW5lcmljIHZlcnNpb24gb2YgdGhp
cyBmb3IgdGhlDQo+ID4gPiA+IGlhdmYgZHJpdmVyLCBzbyBpZiB0aGVyZSBpcyBubyBhcHBldGl0
ZSBmb3IgdGhlIGdlbmVyaWMgYXBwcm9hY2ggSSdsbA0KPiA+ID4gPiBjb250aW51ZSB0byBwdXJz
dWUgdGhlIGRyaXZlci1zcGVjaWZpYyBvbmUuDQo+ID4gPg0KPiA+ID4gQSBnZW5lcmljIEFQSSBp
cyB3YXkgYmV0dGVyLg0KPiA+ID4NCj4gPiA+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB3aGF0
IGlzIG1pc3NpbmcgaW4gdGhlIGN1cnJlbnQgQVBJLg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgd2hh
dCB5b3Ugd2FudCB0byBhY2hpZXZlIGlzDQo+ID4gPiBSVEVfRVRIX0VSUk9SX0hBTkRMRV9NT0RF
X1BST0FDVElWRS4NCj4gPiA+IFdoYXQgaXMgbWlzc2luZyBleGFjdGx5IHRvIGltcGxlbWVudCBp
dCB3aXRoIHRoZSBnZW5lcmljIEFQST8NCj4gPiA+DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBy
ZWNvbW1lbmRhdGlvbiwgSSB0aGluayB0aGVyZSBpcyBwcm9iYWJseSBhIHBsYWNlIGluIHRoZQ0K
PiA+IGlhdmYgZHJpdmVyIGZvciBSVEVfRVRIX0VSUk9SX0hBTkRMRV9NT0RFX1BST0FDVElWRSB3
aGVuIHdlDQo+ID4gZGV0ZWN0IGEgUEYtdG8tVkYgcmVzZXQuIEhvd2V2ZXIgSSBkb24ndCB0aGlu
ayBpdCBsZW5kcyBpdHNlbGYgdG8gdGhpcw0KPiA+IHByb2JsZW0uDQo+ID4NCj4gPiBXaGF0IGlz
IG1pc3NpbmcgaXMgdGhlIHRyaWdnZXIgZm9yIHRoZSBzZXF1ZW5jZSB0byBzdGFydC4NCj4gPiBS
VEVfRVRIX0VSUk9SX0hBTkRMRV9NT0RFX1BST0FDVElWRSBzZWVtcyB0byBiZSBjb25jZXJuZWQN
Cj4gPiB3aXRoIHJlY292ZXJpbmcgZnJvbSBoYXJkd2FyZSBlcnJvcnMgZGV0ZWN0ZWQgYnkgdGhl
IFBNRC4gVGhlcmUNCj4gPiBkb2Vzbid0IHNlZW0gdG8gYmUgYSB3YXkgdG8gYXNrIHRoZSBQTUQg
dG8gZW50ZXIgdGhlIHJlY292ZXJ5IG1vZGUsDQo+ID4geW91IG11c3Qgd2FpdCBmb3IgYSBkZXRl
Y3RlZCBlcnJvciAtIHBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQo+ID4NCj4gPiBX
aGF0IEkgYW0gbG9va2luZyB0byBpbXBsZW1lbnQgaXMgYW4gQVBJIHRoYXQgd2lsbCBhbGxvdyB0
aGUgdXNlciB0bw0KPiA+IHRyaWdnZXIgdGhlIFBNRCB0byBwZXJmb3JtIGEgcmVzZXQgZm9sbG93
ZWQgYnkgcmVjb3ZlcnkgKGNvbmZpZ3VyZSwNCj4gPiBzZXR1cCBhbmQgZGV2aWNlIHN0YXJ0KS4g
WWVzIHRoaXMgY2FuIGJlIGRvbmUgdXNpbmcgZXhpc3RpbmcgQVBJczoNCj4gPiBydGVfZXRoX2Rl
dl9yZXNldA0KPiA+IHJ0ZV9ldGhfZGV2X2NvbmZpZ3VyZQ0KPiA+IHJ0ZV9ldGhfcnhfcXVldWVf
c2V0dXANCj4gPiBydGVfZXRoX3R4X3F1ZXVlX3NldHVwDQo+ID4gcnRlX2V0aF9kZXZfc3RhcnQN
Cj4gPg0KPiA+IEJ1dCB0aGF0IGludm9sdmVzIHBvdGVudGlhbGx5IHVubmVjZXNzYXJ5IHJlY29u
ZmlndXJhdGlvbiBhbmQgbW9yZQ0KPiA+IGJ1cmRlbiBvbiB0aGUgdXNlciBpbiBidWlsZGluZyB1
cCB0aGUgZGV2aWNlIGNvbmYsIHZlcnN1cyBhbiBBUEkgdGhhdA0KPiA+IGp1c3QgYWNjZXB0cyB0
aGUgcG9ydF9pZC4NCj4gPg0KPiA+IFRoZSB1c2VyIG1heSB3YW50IHRvIHRlYXIgZG93biB0aGUg
ZGV2aWNlIGFuZCBicmluZyBpdCBzdHJhaWdodCBiYWNrDQo+ID4gdXAgYWdhaW4gaW4gY2FzZXMg
d2hlcmUgc29tZXRoaW5nIGhhcyBnb25lIHdyb25nIGVnLiBhIHF1ZXVlDQo+ID4gYXBwZWFycyB0
byBiZSBodW5nLCBhbmQgcmVzZXR0aW5nIGl0IG1heSBoZWxwIHJlc29sdmUgdGhlIGlzc3VlLg0K
PiANCj4gT0sgeW91ciBkZXNjcmlwdGlvbiBtYWtlcyBzZW5zZS4NCj4gDQo+IFBsZWFzZSBkcmFm
dCBhIFJGQyBvZiB0aGUgQVBJIHdpdGggYWxsIHRoZSBuZWVkZWQgZXhwbGFuYXRpb25zLA0KPiBz
byB3ZSBjYW4gZGlzY3VzcyBpdCBpbiBtb3JlIGRldGFpbHMuDQo+IE9yIGFyZSB5b3UgYXNraW5n
IHRoZSB0ZWNoYm9hcmQgdG8gZGlzY3VzcyBpdCBiZWZvcmUgdGhlIGRyYWZ0Pw0KDQpJJ2xsIHN1
Ym1pdCBhIGRyYWZ0LCBJIHRoaW5rIGl0J3MgdGhlIGJlc3Qgd2F5IHRvIHByb2NlZWQuIFRoYW5r
cw0KZm9yIHlvdXIgaW5wdXQuDQo=
