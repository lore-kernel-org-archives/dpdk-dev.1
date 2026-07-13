Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598C4C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 01:51:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16A4840298;
	Mon, 13 Jul 2026 03:51:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9952E4028A
 for <dev@dpdk.org>; Mon, 13 Jul 2026 03:51:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783907491; x=1815443491;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mbIVGTj3xxNGMisk/BQLrm/gxNIVDayGP0fjyrwPK6M=;
 b=U5m3R+EyQ8oK6EALHjoVMJRKeUKr2WeMaMKUlti1pUkPXp11Dm5XPIf4
 E7QGDLl413U4djURLudALE6fzAwu/gjLF+VMQgTHJ9CiUwBdunB191wlX
 LFRY+uIFiesWgEUzCj+lEeIeK8LbS4GN/BkAj09kjwnoyUzrBLTba7xOr
 9zOAVB09SfdasbauN64oIFnAYYslSj2opAlqnv7QOWm8vRjyldwgxYMw5
 gZwRqEI85QPkBxTHwGJiyA38v+lzP/8D7RCrEpXXX9bqBzu5EhpG1XkJW
 kyADovuGYfH2SdAkh5QmyeUrrQdqXBuejgIQSrK5yr2zymqhcT6mQp94Y Q==;
X-CSE-ConnectionGUID: qGEBXllmSvKPHA8HQ15ugg==
X-CSE-MsgGUID: 2DTD4Z/XQ3GVxNsM6xcskw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101938741"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101938741"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 18:51:28 -0700
X-CSE-ConnectionGUID: dxfFW83NQ1+jeMFhO78wkg==
X-CSE-MsgGUID: ZpFDeu2RQ16E9M2O4NmQxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="253671338"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 18:51:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 18:51:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 18:51:27 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 18:51:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y19Aa+oEI5OXr9QrPPKZKfDC27PtoNf65Rtm3H8d2DqTm80/MDzApmKzKOBF4j06Zwie1sCk5u+acKBErCBjVKljdrlADUcrqxE5pJTz9BKkvcY0xqXITn+hrZYhRTmWbpj8AvSRLP5AskYGx0ACgp5BAy+MtZsKK4L0MvNWbxAV6QE1NdIo/UZ3Gae+NxH6TB2H44gTsNDShJvhCvMdtCgkR9d9FyVR7kijpXg5tACNH7PLkrHkFs5gOBnE+2DK261YHJIJLFfqpr7nR8BRgcNZCMhcb+vjtDR5oPPr9F39fVXgjvbu8vFG9T6AOQMjzu2Bqdv/JdcAiVVCbt+dCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbIVGTj3xxNGMisk/BQLrm/gxNIVDayGP0fjyrwPK6M=;
 b=l5EpL+FeQQyRPxUhzdOFI/hEkXlwt9f3wCl4Ii2jhq4xmpx1bONNTOR5iW+boNJPoGZqLmBdZwLxeSlT5jtDLeomATj3DQS0EGDqdCaj22xcx4eX3q7ZdhPQTt4nlIzpWbwFvXGDU6xOhXoKQiXqgFRbeNL9i9lY3LP3w9CVhoAZyZAuPDYud9i1BcW95Cy5lmeSa7ZFUOOCGxwogq+STJiFrAKMooOIPylB86vdJI12euGbSYFaTJC+KTjkznfXGHjyIyo2Sc7XvlUzy3gg67/EfoEzEZB84jwjgZaH8cofN8oKDu+0LyqH6iyzxRA8xzXZOJK/Ak3q6OGm/4z97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by EAYPR11MB9562.namprd11.prod.outlook.com (2603:10b6:303:2bf::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 01:51:24 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::39c3:b214:8d57:23fa%8]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 01:51:24 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>,
 "Hosamani, Manjunathgouda" <manjunathgouda.hosamani@intel.com>, "Puttaswamy,
 Rajesh T" <rajesh.t.puttaswamy@intel.com>
Subject: RE: DPDK release candidate 26.07-rc2
Thread-Topic: DPDK release candidate 26.07-rc2
Thread-Index: AQHdCpfyQIcqSNLCKUSFs2FXH1UOybZqvjgQ
Date: Mon, 13 Jul 2026 01:51:24 +0000
Message-ID: <DS4PPF00BBED10C18C2E27C23D993886FFE9FFA2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <CP3kiV_jTf67aEg8Usilhg@monjalon.net>
In-Reply-To: <CP3kiV_jTf67aEg8Usilhg@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|EAYPR11MB9562:EE_
x-ms-office365-filtering-correlation-id: a254e49b-660e-46e0-8b0b-08dee0813f20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 6Zr0j8JM25oI7WUiG+C02gaBmmS6vGfHdoPoDQCcB4wX6vLVSkKWFaXcpcMgaV1coh0B9d3aoHjaTmJri53+ci12KEGF1UCiMGm2LTtnuCzKfgacDtSEBQ+hj+ktVAV15HemuXRf1dSbc4DZEQ7LHAqZ4UHT4rhORbn6ppLysG39F8FXZizYoVMTQQM3tDByogmY229G7hMk0BiKXkDSzghpFQJqoZ/jNtr39M2tG9Ck/BHSqkiKsjb6g6p4183KUxKiAtvwcRbdpvx1/gjV1+J4lf0fmxMmEfbQ6B33qSDlmGpmt0Pgm3JtcRLbp6mrclzg24QruVXLp3kqg9VRmzCLMOKLyCdK+yk7kpFQvGxpk+SEcwYDk4XB8cUSeyhHOEGJSvh3Kt+3ei4EOwWBBC9rNZpaAaJ1AiXRO2URb59cAIZTQ0Jw9TLsggOXtsH3KRG59EXEujyL9C8YqGVDDA0Et+EabOfstLUHQSoW1nGSPH/2JfDtQjp/2BRNvKAdQXjG6YHexyD5ZBvBHZaP06+ld5D6s8/RfMukq5Pmcfwo/lyxsU0iBHhU98zQ8KaM0/KiyDcu2OyH1ymQ81A/RWY5fvxrheLfjOMWBmT0AydL2SMfuSqm7SmSD/2NIGhEz1x6J9OlPtQwbaJDIQXku3FVFFZpzdzXxEV9j4keJ51yNs8ekhgf//G8cwUo8QS6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzE5VXBMb0R6aFRZaGJtZXNsbnlneWcxUzM1UzFKcEoxNE5XQmNaZ1duNTJS?=
 =?utf-8?B?ZXg2VVBFVWJERFkzek5odFR3YUhSZGIySWtieFV6KzBSaEN4eDdzdTkzdEly?=
 =?utf-8?B?cU1lZHdBT251QXI3SWpZVkxoU1Z1TzJvWGZNcjVQNEE2WTZYcjJObXR2azRF?=
 =?utf-8?B?QWlaNFppR1drYWhsUFdnaGdkMWt5V3BuSmpGUkVwT2NqditsK294bnRlL3Yx?=
 =?utf-8?B?Q24yZ055aVEvd08wY041SmFJeFVtd0xnZHRaVkVSalFzUWwvZUc4WkhnRXB6?=
 =?utf-8?B?Qms5YXJKUnI1cTl6YmhPUjRNOEU2cW80S1hwTE9NMkh2ZUhXblhFM1Rtemg3?=
 =?utf-8?B?Rko2eXNhd2hyTlZFNGJMVkF0d3BEOUdIY3REMll2WnNwaDJmMld6VXEvbUNy?=
 =?utf-8?B?SUE3bnZWZThCaDVyOUdTRmJ3T3Zqd1EzMVBud0svOVdWTGc0WGFnRk1BZUhZ?=
 =?utf-8?B?eGNiMmNHMzBJR3d5THdlczZvaDBSVlh3VmJQRU53Z0JXbHdVaXk0M0laWEFs?=
 =?utf-8?B?Q1BFV2RYK3dHaDJUaVZaOThGQ3AyV0xnejYvN0ZIVVp1TDM5N1NGbVhEZTNu?=
 =?utf-8?B?bHJBN251ME0rb0pIbkh0NmJ3VnptY1RYZ3BoeUpYRmxud2VWamZVK3FvazVi?=
 =?utf-8?B?R2xMamdIUTNrRnVTbnJLVFZIYmdUWnpMRGhUakYxaHNUYWIzREJsUWhMQllq?=
 =?utf-8?B?TGpXYnBOM0NhYU0yWDlIODR3NUtHdkFQajh0a3hJTWRxaGRsNUtZeWp6aU82?=
 =?utf-8?B?SkJ4VHdvZFUvSEgzWnFFYVk0cTQ1NFdRYzRJV1Y2L2VlS1dkcXRDQmIvd3h3?=
 =?utf-8?B?NWtxSld0Qk5Gd1JHZU9uRE5wZ3FkYmgrY0ozVXVhZUxLRjVWVEdGRmtFcEtG?=
 =?utf-8?B?TlF2anQ3QnB5T1JOVTFRRGF2T0h1OWh5eHpCc2RoMlYvRXRVZ3ZHcHA4MkZS?=
 =?utf-8?B?VUk3MlUxNm1Tc1haUEhuamV0MUFGb2NiR2VtMFJSKzBrQTZWYVFiSEJPUFhR?=
 =?utf-8?B?a3VlQjB6SUNSdFBoV056c3h1UWNjN29EYmZBN3dQbHNRMjdxMHZnZlp3RHl3?=
 =?utf-8?B?YVpHbEpYNU5GOHhoS2VNWVdQYmE1NzNCU1JZSG85L0szUkhqbVFkV0Rzb0ZG?=
 =?utf-8?B?Q2c1OTE5RXlsQU00b2c0QW82Z2lETkp5M084aEk1eVlURU54YWg1L3dmRFYv?=
 =?utf-8?B?WE9RbWxibEhpR1VHSkFST3B5cEpSQURUd1ErVGxZNnRYdE0xK2pZc0dZazFQ?=
 =?utf-8?B?dlhsTnZQZFJtcG4zQ0I1K1lqaFlkRnlPMkN3dHVHQS93SW4vN016ZDREOUF2?=
 =?utf-8?B?RkFzeVQrSU9lOU9CZHdlbXBybE5XdURRelVqMTMzR09IVDRRUmp1cjZDY3R3?=
 =?utf-8?B?M0hBdXBNTU80bWo1cTh3MEQxMGhQTm1tSDV1Y2RyeXZjV05DckhWQytwUzB3?=
 =?utf-8?B?MkdlM0tWZkZNWi9XN1VlWTI3UU1OWGdHWnZRY1ZubjFxTGlzeFYrQmY1OWRl?=
 =?utf-8?B?LzZ2SGVwWmZIb3EwYUwxZFFRbXZxYUJORFQ5Z2FteThXYWFaTWpEVWNMMXNt?=
 =?utf-8?B?eXJNTXl5S005bVpManorVzdjbTRIRHdDcnBPWXhIa2lUNTZMc0RRLzh3aS83?=
 =?utf-8?B?VGI1b2dGM0Uzb1JuajJ3NDZDbHVZZHhrV2ppeEFIZmZHYi9wakJNYU9kaENt?=
 =?utf-8?B?aEJsSm9jMkV3c1l3Mmo3VGpSZTFtelZJMytXS3luQ0NHR1ZYYjlmUEV3dEVj?=
 =?utf-8?B?aEpKWG41QXBoNzNpUjBqbnNacklXNytNVGR6QWx4RlQ4TkxpSnd4K2E4WFp4?=
 =?utf-8?B?KzdWRm1kSjdzVDN2STg5TUxZRlBHbmxZeW4zSUNkak53YXYvNjBuNzVkWEE3?=
 =?utf-8?B?a0RhVDMxNWFJc0xJK0ZrWHhNR01yNjNBeHBCUkd5emJDSXYwcGFQS2QrRGZv?=
 =?utf-8?B?LzJuNEl4akEzbncvWDNleUFmYmI3M2dlS3gvWmtnVHIybnRDcGtCTG9qWFZu?=
 =?utf-8?B?L01EZnZhSm5uMWt5R2RNODJNKzNlbG9kb0ttemJvcVl3bkJhM2t3bWdoRGtE?=
 =?utf-8?B?U1BlM3htRnNRUFhPaEFNVDNzMnBsdGxlT2hKMFoveTJUUy9iYWZlNlN3Y3ds?=
 =?utf-8?B?eXNVTTJJL2ZuQlEzSzNPNjdTeHV2SVVZOXAzU0liVm91aGo3dzAyVFRzRE9J?=
 =?utf-8?B?S2M5Y0JOQWduUG9IOHdBMEJ4THY3d21tdzlhK3BiTDVpdXFuYyt2S1pIejdT?=
 =?utf-8?B?Wmt5ZERnckRUcHYzZURVRmIyS2JLQXpKY2RJQXd3aUc2Qk9lS0lUVjJBV0p4?=
 =?utf-8?Q?e2wCmpcyRjyYgcb32z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ai7o8BDxCUG6inXaJpfwjzQjZGiPk2zMA28HhfUtoob+EHBx9speSd4SNHTnfxSgOaUn/WaPVxjRaV2EZxPvsOUqgGBfHVegPyJaKs/KlsSmjS4ZnELO1oN2u/bN2NBLqNNDB3gmKN6jRyFcv4/PR6NRLwoHQPvDiB1pNWzxsVd8ixcJnS3UoTb2qVRXWSKL8kV2+7Pij6cA9ils/77B3WbGhzdRWSn0t37D97Mh7W9+6Rm4jeUNuUqnJPqYuwt9bCHLFl0iT69TBobt3gq/u/ClJSNV5yHwJQVhYseT9vf6gCgBcHA4EDGCfe/9D5hcwZitnlhGbFLDyq0SOGaCbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a254e49b-660e-46e0-8b0b-08dee0813f20
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 01:51:24.7399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuOdGgJeH2YLu2pcQj2wSnpcX2eBb3ITJxEkJ/OeD15SqXHZshlqQU6FLG1dKwKedmYUbhFgJzG+3HfwjOrWFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9562
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAzLCAyMDI2IDEwOjU5IEFN
DQo+IFRvOiBhbm5vdW5jZUBkcGRrLm9yZw0KPiBTdWJqZWN0OiBEUERLIHJlbGVhc2UgY2FuZGlk
YXRlIDI2LjA3LXJjMg0KPiANCj4gQSBuZXcgRFBESyByZWxlYXNlIGNhbmRpZGF0ZSBpcyByZWFk
eSBmb3IgdGVzdGluZzoNCj4gCWh0dHBzOi8vZ2l0LmRwZGsub3JnL2RwZGsvdGFnLz9pZD12MjYu
MDctcmMyDQo+IA0KPiBUaGVyZSBhcmUgMjg5IG5ldyBwYXRjaGVzIGluIHRoaXMgc25hcHNob3Qu
DQo+IA0KPiBSZWxlYXNlIG5vdGVzOg0KPiAJaHR0cHM6Ly9kb2MuZHBkay5vcmcvZ3VpZGVzL3Jl
bF9ub3Rlcy9yZWxlYXNlXzI2XzA3Lmh0bWwNCj4gDQo+IFRoZXJlIGFyZSBtYW55IGZpeGVzIGFu
ZCBuZXcgZHJpdmVycyBmZWF0dXJlcy4NCj4gDQo+IFBsZWFzZSB0ZXN0IGFuZCByZXBvcnQgaXNz
dWVzIG9uIGJ1Z3MuZHBkay5vcmcuDQo+IA0KPiBQYXRjaGVzIHRvIGltcHJvdmUgdG9vbGluZywg
ZXhhbXBsZXMgYW5kIGRvY3VtZW50YXRpb24gYXJlIHdlbGNvbWUuDQo+IA0KPiBUaGFuayB5b3Ug
ZXZlcnlvbmUNCj4gDQpVcGRhdGUgdGhlIHRlc3Qgc3RhdHVzIGZvciBJbnRlbCBwYXJ0LiBkcGRr
MjYuMDctcmMyIGFsbCB2YWxpZGF0aW9uIHRlc3QgZG9uZS4gZm91bmQgNCBuZXcgaXNzdWVzLg0K
DQpOZXcgaXNzdWVzOg0KICAxLiBbZHBkay0yNi4wN10gZGNmX2xpZmVjeWNsZS9oYW5kbGVfYWNs
X2ZpbHRlcl8wMTogaW4gY2VydGFpbiBzaXR1YXRpb25zLCBtYXRjaCBydWxlIHBhY2tldHMgYXJl
IG5vdCBkcm9wcGVkICAgICAgICAgICAgLT4gSW50ZWwgZGV2ZWxvcG1lbnQgaXMgaW52ZXN0aWdh
dGluZw0KICAyLiBbZHBkay0yNi4wN3JjMl12aXJ0aW9fcGVyZl9jcnlwdG9kZXZfZnVuYy92aXJ0
aW9fYWVzX2NiY19zaGExX2htYWM6IEVBTDogRXJyb3I6IEludmFsaWQgbWVtb3J5ICAgICAgLT4g
aGFzIGZpeCBwYXRjaA0KICAgICAgaHR0cHM6Ly9wYXRjaGVzLmRwZGsub3JnL3Byb2plY3QvZHBk
ay9wYXRjaC8yMDI2MDcwNjA5NTc0Ni4yNTg2NzE0LTItcmFkdS5uaWNvbGF1QGludGVsLmNvbS8N
CiAgMy4gQnVnIDE5NjQgLSBbZHBkazI2LjA3LXJjMl0gRFBESyBidWlsZCBmYWlsZWQgd2l0aCBF
WFRSQV9DRkxBR1M9Jy1PMScgb24gVWJ1bnR1MjYuMDQgICAgICAgICAgICAgICAgIC0+IE5vdCB5
ZXQgcmVzb2x2ZWQNCiAgNC4gQnVnIDE5NjMgLSBob3RwbHVnX21wOiBhdHRhY2ggdGhlIHNoYXJl
IGRldmljZSBmYWlsZWQgaW4gc2Vjb25kYXJ5IHByb2Nlc3NlICAgICAgICAgICAgICAgICAgICAg
ICAgIC0+IEZpeGVkDQoNCg0KKiBCdWlsZCAmIENGTEFHIGNvbXBpbGU6IGNvdmVyIHRoZSBidWls
ZCB0ZXN0IHdpdGggbGF0ZXN0IEdDQy9DbGFuZyB2ZXJzaW9uIG9uIHRoZSBmb2xsb3dpbmcgT1Mo
YWxsIHBhc3NlZCkNCiAgLSBVYnVudHUyNS4xMC9VYnVudHUyNi4wNA0KICAtIFJIRUw5LjYvUkhF
TDEwDQogIC0gRmVkb3JhNDMNCiAgLSBGcmVlQlNEMTUuMA0KICAtIFNVU0UxNg0KICAtIE9wZW5B
bm9saXM4LjEwDQogIC0gT3BlbkV1bGVyMjQuMDQtU1AyDQogIC0gQXp1cmVMaW51eDMuMA0KDQoq
IEZ1bmN0aW9uIHRlc3RzOiBBbGwgdGVzdCBkb25lIGFuZCBmb3VuZCA0IGlzc3Vlcy4NCiAgLSBJ
Q0UtKEU4MTAsIEU4MjUsIEU4MzAsIEU4MzUsIEUyMTAwKSBQRi9WRjogdGVzdCBzY2VuYXJpb3Mg
aW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQv
bWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cg
RGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3Jp
cHRvciwgZXRjLg0KICAtIGk0MEUtKFhYVjcxMCwgWDcyMikgUEYvVkY6IHRlc3Qgc2NlbmFyaW9z
IGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2Fk
L21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSVhHQkUtKEU2MTAsIFg1NTAp
IFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvVFNPL0p1bWJvZnJhbWUvY2hl
Y2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuIA0KICAtIElHQy0o
aTIyNikgUEY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVt
Ym9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4N
CiAgLSBJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lwc2Vj
IGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFyeSwgZXRjLg0KICAtIFZpcnRp
bzogYm90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBh
cyBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0y
Vk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA5LjAsIGV0Yy4NCiAgLSBDcnlwdG9kZXY6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYg
SVNBLUwvUUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KICAtIE90aGVyOiB0ZXN0IHNj
ZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERTQQ0KDQoqIFBlcmZvcm1h
bmNlIHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KICAtIFRob3VnaHB1dCBQZXJmb3Jt
YW5jZQ0KICAtIENyeXB0b2RldiBMYXRlbmN5DQogIC0gUEYvVkYgTklDIHNpbmdsZSBjb3JlDQog
IC0gWFhWNzEwL0U4MTAvRTgyNS9FMjEwMCBOSUMgUGVyZm9ybWFuY2UNCg0KDQpSZWdhcmRzLA0K
WHUsIEhhaWxpbg0K
