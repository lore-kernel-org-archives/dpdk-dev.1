Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE347606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kt8fKSmr
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECAAD40297;
	Thu, 12 Nov 2026 04:31:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id 884904026A
 for <dev@dpdk.org>; Thu, 12 Nov 2026 04:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794454305; x=1825990305;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gIMnx7UOhpquUczE3mcRAf/GUJNEUU2OB6rSY8q7W4I=;
 b=kt8fKSmrdDrpWVcLecYEm8U3honUzQ8SMp/GDXDUhWirM4WpCLoaVyFC
 QXUrNFGjvvDXqLWS9c6sOsnpJwcBRyYkQpdKTIa4sGp518Ezt/o8kv36A
 PgEo3hpKcGReK8gIvRo3HjNUJ15yh27QHpbjFXzilAkOfcsGR/edO1zoy
 30OG1i2jmEQb+pAlA9G/OvIkfcAtetePfLt6IOF67l7J6O/L2czJMBQYy
 WrZyvNvURZWSgZgKq0yHYxcidwBsh9p8vEjJQqV8UNQwtWwVFBWijvWvz
 8VzqAJGdVwFzuOP9rWl/QGMx2nUlWdQRA9P5ItK3yCB4xdrQC+DToYOR+ w==;
X-CSE-ConnectionGUID: 2T47B/+mSKiOyqogRdz9Vw==
X-CSE-MsgGUID: MKedn7/0Qymu3MAjV4NnNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3110906"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3110906"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 19:31:43 -0800
X-CSE-ConnectionGUID: BLKMyadkTmyyXBNiiBDMzQ==
X-CSE-MsgGUID: wEzI1WBEQMuPz/3FJQ1WoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8887406"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 19:31:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 19:31:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 19:31:42 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 19:31:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6PB9LKZuMzqD1ear361MvUFQykXmMb39NjkhRSPPv+/1wbS9A597Oc+VBWm0W1waP1FyPrTwbiua+LvJtRvJB2wFaYf+PyfB+PINMpRNGPSIdUynZyovgV0A/68vF/0Jzp+QJ74neKajkUZJB+EviIQdtCP1QDrn8Aj5qADXJtTtrX7+G3wmsbOMU/fj6fy0nwBrmlkDgfrCpg7k/UU3BRKYmgOTGNS379sif46J07hxi3dJtJTIo44auck9FKFGM8nTC+jZTYoYDphDKQjw+kl7mhg2XnYZvt9nSkxsinIn6qdkDmtTwX+FZEyRs/mV8+XJ9+y/tZ8D/vRDF2gQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIMnx7UOhpquUczE3mcRAf/GUJNEUU2OB6rSY8q7W4I=;
 b=eR/vzIx15zqjLgh0x5uH71VGGzUGK7vMlJXdcJwyp+b8a6FjSSDb6GE1Q7R5qOePKyz5nXAFHauYS4l9T4w5y54PgdfOtWqH9lMGwHWCrZTZmK8bW3iPHahU4MBMdVd6g4mQLZVA89iQIXBnK2BW2f+v0E78UB7SMDNYPtAvemIFCPMm/An+mFjjlWUcVoGo6N560spRUWO9JgBpftRyxrvMnV4+dU4V0UozDcJe2kcUgCBgGg+gyu2YYc25ccij+VEwogtRLvgUjuGzbYyRnEZDaTN/JrzjePmWS/t9sxJIs7k/YLndxM5uIbDM6eo5imWVbJJtu+A5BFSkm6UAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by LV3PR11MB8532.namprd11.prod.outlook.com (2603:10b6:408:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:31:39 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996%7]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 03:31:39 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>,
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Hosamani,
 Manjunathgouda" <manjunathgouda.hosamani@intel.com>
Subject: RE: DPDK release candidate 26.11-rc2
Thread-Topic: DPDK release candidate 26.11-rc2
Thread-Index: AQHdavap8WAfqrzzp0GmSplC2y4DArcp1kKA
Date: Thu, 12 Nov 2026 03:31:39 +0000
Message-ID: <DS4PPF00BBED10CCB2D26F7FB9326CB7C4D9F702@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <xr97c_w-SU6AD1Rq8Uh_NQ@monjalon.net>
In-Reply-To: <xr97c_w-SU6AD1Rq8Uh_NQ@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|LV3PR11MB8532:EE_
x-ms-office365-filtering-correlation-id: 12e92abf-4fa6-4d38-b6f8-08df406d767f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|261026121527099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|56012099006|261021135927099003|260925022911599003|38070700021|260925021911599003|260925021311599003|10067099003;
x-microsoft-antispam-message-info: 1pHcsNwztWIQV7pL61vP4T8+W7J+yYd4CAsyock24ay9jrC6LQmCbgOkUKFYUaETKVRCd5AaI/JYMi5VdFq+EUIogHWglYDiGmQ254Pnk3l206OFsc4TpSeVewcd6pYfFTVBVlOYK3HsDJUusbCGRXf1tdigm4APaShPNE7KqgncEY0UUq8XTcq2Ioyiej5ptmWlWcpyLDqGJzvZlQ/zYz8VB7JZoWpuhcv62yc0PpCqflj2MKlOeAlIK3MhV2U26WLqADJ3GAoC+6evWo+0aO9+WRXunMjZnmziXFPI6Y3PxCk/Gl6Ewh+yb+Zg96/2zpJgd1cyVj3Yw4q4016eq4KXXpd3aqSEOLzzv7W7n1zRgGElhS4epcBegOhe0MwKAKKBYttHaQoH5dbrV1/DIKElvCxDaVph/vdIFEatiGPSVxW41M2F1+FHgyW+dMgLAnVheBXIFMYS8u8vw180Nn3iHQwXdgHTR04XUCqTvikEd3qeIuv50UkZcFqADuG3oWCeUw6OSJGcTz07cAvInLf2nIf/lL1ce11cxs/kdeaHcvKryaJKmNd9lRWmT3dqq24kk8ua5aZTNtLblZ5CVnMTwHvJ+Sr+LeBMj5BQ/Esxi2nGtqCtQpBKDDmCj88maDD+BFOOzk05dQyEKVwicmr84bW8H/X1LIAYcSjXS2U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(56012099006)(261021135927099003)(260925022911599003)(38070700021)(260925021911599003)(260925021311599003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkEvRGJvb3NvcHZBU1BMUmdDYXR6aFFaR3M3NzlKZGorR3pvdUwxckVoZlEy?=
 =?utf-8?B?NGVDRXJJOW0yTzlDZkgreHdjR0JnUDdiMk1UUkVUVmpaUE93ZW1DVVhQMi9C?=
 =?utf-8?B?M0wxSDVzY2JaRGE5VUdpYkY0Z3dGUTFMMlVDTnU3Z0FGZXZTckExWmgxMFNk?=
 =?utf-8?B?U3prbXMvMlZKeTE1V3l6WlBndXliUUVoWHRqRTVmUGlsNlhGMXdiVTdSQVZ5?=
 =?utf-8?B?SG9wM3VRNHJKSkRoVVRhVVlnSmJZTmo1NStiRk1XT1MxaXZYWCthZ2FmRUxy?=
 =?utf-8?B?Qm5qaUxQeUoyUks4SFRid0FCbWZpK20vQzlIK0xsOFdtQU1pUkJ2bTlSSWYy?=
 =?utf-8?B?NzhjYVdTT2hnT0JVTng0STE2aXZORjc3MjRQUy8xYVp0WUJIZER4ZU5jdG5q?=
 =?utf-8?B?RDZGQ0JJODZBTmVyTlAxZS9EcWxzVmtMb3B1QWZraGV0Q3lUTzlON3hkeEg5?=
 =?utf-8?B?L3JXVHlGczgwVDZPMEdndmxkdDYvcmtKWldJNi9rVi9ZT2hnamNyWjJNRXBn?=
 =?utf-8?B?YmlmNTIwY2MrM3ZseWlZR2RBeUhFUXE1c1FWUW1VQVlTQzBNK3E5RUxRdVNN?=
 =?utf-8?B?MDYwZFBESmlZMFhZV2NzaWhha05KOVVTVXlRR0lYZ2wvcGFtYXBpdnJQUERO?=
 =?utf-8?B?a0x0cTJwL3YrQ01BdHBtcVBVTFR6SFB0cFpieVdmZXZsVHFoTVJpbUg2Ly9j?=
 =?utf-8?B?MVdVUWpjWXU4M0h1clVMYm5zeVdRTUhCQitXeUxJOExNRTJXdk9ZR2UzMXZM?=
 =?utf-8?B?Qk01TWxBK1BmNDllTmREN2ZUM2x0TjNsYVc4US8vdk1uenNTTjZ3aVRMSmo2?=
 =?utf-8?B?RGg2U3J5THVldS96cThxR2UwaklTNjMwanFIVGZwR1VFUS9XMWsxdkR0am5t?=
 =?utf-8?B?QzJGMy9idjcwMnhEcnpmYjBGMlNveWtKL0lSUG5FR0ZuQ2ZQRGxQVXp6a2NK?=
 =?utf-8?B?SHNVRE43alk2b2dCU2x5YXA4QUJEb3lTc1M5WU5iRXQwN2JxZFQyUjZWM1Q0?=
 =?utf-8?B?Y2ZET0NJLzM3cWpvaVhaaWZkTzQxS2xHWmpIVENoWi9peldzSmdZaFlwbm9h?=
 =?utf-8?B?V25pK1piZTB1M0Q0SG5zSVQ5RytPVTdrWHRSNnppbGdGcG1IalNBV0NQV1Rs?=
 =?utf-8?B?OGdOTm54dTVpUmJ4SEpsMy9sNm9kaCswaGwrTDBSMG1sclpRajFYL2dHTmR3?=
 =?utf-8?B?VTVpVjF5NEpyS2xKOEg2ZHhkSnpXcnEyZFF3azR1dnlSSVVkZkE3Zm1pSmRV?=
 =?utf-8?B?dkMyVzZKQiszaklrZ1MzWnFUZjlHcm5zM3I2VndPTnFrc2dGNEJGRHZ3NlM1?=
 =?utf-8?B?RVZHQmFSOFQ1UUtmbmJKUjh1NmNXSk5xRVd3M1dSYUZPM21aRnBNN0s3MGJW?=
 =?utf-8?B?WWhuK2VEbGVCUWY1MW0wZWREUU0xK0FweFdWT1RLQXR2b05qOGhaajlXcWFW?=
 =?utf-8?B?bFRUOWVYbnJuV3JXOGpJNG9FZExkSkQ2dnVuWmFVUlpVNVZsYUVGd1lCcmMz?=
 =?utf-8?B?Z1lRbEhYWkhHM29LWWphQnEvbks4QjJhMC9pRTBrOFBVaWlFYVczRCtJdWYz?=
 =?utf-8?B?OG1HSTY1WUpOR0tVVzBWRHcvUFV3MHUwNXEvOEwwRUNlRTdFNEh4Snljd3pE?=
 =?utf-8?B?RzJyWjZaSXBkT0VUQ2hXcDNPWWlQdlNyMVA5TlNBMmQyOUprTkc5L0xlNXpI?=
 =?utf-8?B?R3dkK0NqTVVJc1o5NHY0QUJLdVcwVGQzT2srWHJ0cEFXMDA5M1JSSVdhSFh3?=
 =?utf-8?B?ZUNKVmU3c1JUOExBeElkMTNSd1lPc0dwS3E2YjlyR3A1dmptemlkOEhxTzNx?=
 =?utf-8?B?a0V1OFBEWVFLcWtxQmQ3VHFyZkllTEg5R2VxaDdMMGlHMThKNVZxNUdta2FM?=
 =?utf-8?B?T2JhQ3puWmZHcE1RL0REc3h1SFRVWjg0c1REQkx0M3pUQ0ZyM2FoWkdCK3B5?=
 =?utf-8?B?SEFxNzdJYk5ab1NMTUdqTmdKRVlYM01scGY1Y085VlZwWmFLNWlaNXVibEwv?=
 =?utf-8?B?WGFUQ0g4cTlFcmN3b0JSY1RNQitXTHRUOGwxeEhzRWtBL1paa2NrY0dDbmpH?=
 =?utf-8?B?STBOS25Vcjh5Tm9hLy9JWkU4SEN4UXFRZDNYblQzVFNUTFd1QlJyVDl0VEla?=
 =?utf-8?B?Z0ZqRU9ucTF5TW13ZXJtc1FWeVZlRHdwaWxDRnVEb0RVU2p0NHJzbU0za05W?=
 =?utf-8?B?VkVOK012ZWFUeVFVMi9WU1dkM1ZUalBNcHhCb2poRUJMczR0am9rZ25jRGdM?=
 =?utf-8?B?L0V1TTlIYXJkbURhQy9TZXhTRE54NFdpSkJlZ2tOMEVqZWdVeGg1Vm92N2tK?=
 =?utf-8?Q?N1UhymS8LpJMcL1w0q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ynh/zDTvus4Rn+LlWgtNX7TfIAH5llmwhDP9kNa8b3ylUKVnInnJMCh0VblXEOSR8QjWyX2vGDKbPd/mOZK4bKmSpR6sLAyuKugCqB/V8jQDE14fW5H4NYLJZa3ySxulrj+A4y4pyrfAnciG+rMCWSnzZYlEvSP+9Tf4FzAEmorTe5QPFZSQISaVkC0+Z0EnZpfyxnGm9clkoTiSRrC55ox6C8YAEZLmNh+S5VsR9FF8u3KQexsiKTEQlaMiw3eKb8FXXTN8XcSDh9WLgmmyzNfDDWQ0Er1bJ8yJogq6rTRq3d2FnBRrF79NvbsiEBTSNfEED0nCvdYk2wzBy+0/Vg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e92abf-4fa6-4d38-b6f8-08df406d767f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 03:31:39.2619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U92wCPUIQnO2rhwOfYgAVElEXYxD4EGx9EsgDRKzKiMjNi1uYAoNCi9XGaah9RKFCJIjNoKddXVYOy009Hw7pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8532
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDMsIDIwMjYgMjox
OCBBTQ0KPiBUbzogYW5ub3VuY2VAZHBkay5vcmcNCj4gU3ViamVjdDogRFBESyByZWxlYXNlIGNh
bmRpZGF0ZSAyNi4xMS1yYzINCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgaXMg
cmVhZHkgZm9yIHRlc3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/aWQ9
djI2LjExLXJjMg0KPiANCj4gVGhlcmUgYXJlIDM1NyBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNuYXBz
aG90Lg0KPiANCj4gUmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRl
cy9yZWxfbm90ZXMvcmVsZWFzZV8yNl8xMS5odG1sDQo+IA0KPiBUaGVyZSBhcmUgbWFueSBmaXhl
cyBhbmQgZHJpdmVycyBmZWF0dXJlcywgaW5jbHVkaW5nIEFNRCBOVEIuDQo+IA0KPiBQbGVhc2Ug
dGVzdCBhbmQgcmVwb3J0IGlzc3VlcyBvbiBidWdzLmRwZGsub3JnLg0KPiANCj4gUGF0Y2hlcyB0
byBpbXByb3ZlIHRvb2xpbmcsIGV4YW1wbGVzIGFuZCBkb2N1bWVudGF0aW9uIGFyZSB3ZWxjb21l
IGZvciB0aGUNCj4gbmV4dCByZWxlYXNlIGNhbmRpZGF0ZXMuDQo+IA0KPiBXZSdsbCB0cnkgdG8g
Y2xvc2UgLXJjMyBhbmQgLXJjNCBpbiBvbmUgd2VlayBlYWNoLg0KPiANCj4gVGhhbmsgeW91IGV2
ZXJ5b25lDQo+IA0KVXBkYXRlIHRoZSB0ZXN0IHN0YXR1cyBmb3IgSW50ZWwgcGFydC4gZHBkazI2
LjExLXJjMiBhbGwgdmFsaWRhdGlvbiB0ZXN0IGRvbmUuIGZvdW5kIDIgbmV3IGlzc3Vlcy4NCg0K
TmV3IGlzc3VlczoNCiAgMS4gQnVnIDIwOTkgLSBbZHBkazI2LjExLXJjMl0gL2RyaXZlcnMvbmV0
L3hzYyBtZXNvbiBidWlsZCBmYWlsZWQgd2l0aCBFWFRSQV9DRkxBR1M9Jy1PMScgb24gVWJ1bnR1
MjYuMDQJLT4gaGFzIGZpeCBwYXRjaA0KCWh0dHBzOi8vcGF0Y2h3b3JrLmRwZGsub3JnL3Byb2pl
Y3QvZHBkay9wYXRjaC8yMDI2MTExMDAyMTgwMS43NjYzMTUtMS1zdGVwaGVuQG5ldHdvcmtwbHVt
YmVyLm9yZy8NCiAgMi4gW2RwZGsyNi4xMS1yYzJdIGljZSBpYXZmIHZhbGlkYXRlIHJzcyBydWxl
cyBmYWlsZWQJCQkJCQkJCS0+IGhhcyBmaXggcGF0Y2gNCglodHRwczovL3BhdGNoZXMuZHBkay5v
cmcvcHJvamVjdC9kcGRrL3BhdGNoL2FhYThmZTQ5YzYzOGFkY2M0OTMyNjNkZTIwNmRjNWM5Zjlj
MjI4MDMuMTc5MzgwMjM0OC5naXQuYW5hdG9seS5idXJha292QGludGVsLmNvbS8NCg0KKiBCdWls
ZCAmIENGTEFHIGNvbXBpbGU6IGNvdmVyIHRoZSBidWlsZCB0ZXN0IHdpdGggbGF0ZXN0IEdDQy9D
bGFuZyB2ZXJzaW9uIG9uIHRoZSBmb2xsb3dpbmcgT1MoMSBpc3N1ZSkNCiAgLSBVYnVudHUyNC4w
NC41L1VidW50dTI2LjA0LjENCiAgLSBSSEVMMTAvUkhFTDEyDQogIC0gRmVkb3JhNDQNCiAgLSBG
cmVlQlNEMTUuMQ0KICAtIFNVU0UxNg0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0gT3BlbkV1bGVy
MjQuMDQtU1AzDQogIC0gQXp1cmVMaW51eDMuMA0KDQoqIEZ1bmN0aW9uIHRlc3RzOiBBbGwgdGVz
dCBkb25lIGFuZCBmb3VuZCAxIG5ldyBpc3N1ZS4NCiAgLSBJQ0UtKEU4MTAsIEU4MjUsIEU4MzAs
IEU4MzUsIEUyMTAwKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9G
TE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFO
L1JTUy9Td2l0Y2gvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgv
QWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3JpcHRvciwgZXRjLg0KICAtIGk0MEUt
KFhYVjcxMCwgWDcyMikgUEYvVkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVf
RkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExB
Ti9SU1MsIGV0Yy4gDQogIC0gSVhHQkUtKEU2MTAsIFg1NTApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlv
cyBpbmNsdWRpbmcgYmFzaWMvVFNPL0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmls
dGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMuIA0KICAtIElHQy0oaTIyNikgUEY6IHRlc3Qgc2NlbmFy
aW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZs
b2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4NCiAgLSBJUHNlYzogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lwc2VjLWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAt
IFFBVCZTVy9GSUIgbGlicmFyeSwgZXRjLg0KICAtIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQg
cGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNr
L3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdB
UkUgRVNYSSA5LjAsIGV0Yy4NCiAgLSBDcnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGlu
ZyBDcnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwvUUFUL1pMSUIgUE1EIFRl
c3RpbmcvRklQUywgZXRjLg0KICAtIE90aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZf
WERQLCBQb3dlciwgQ0JETUEsIERTQQ0KDQoqIFBlcmZvcm1hbmNlIHRlc3Q6IEFsbCB0ZXN0IGRv
bmUgYW5kIHBhc3NlZA0KICAtIFRob3VnaHB1dCBQZXJmb3JtYW5jZQ0KICAtIENyeXB0b2RldiBM
YXRlbmN5DQogIC0gUEYvVkYgTklDIHNpbmdsZSBjb3JlDQogIC0gRTgxMC9FODI1L0U4MzUvRTIx
MDAgTklDIFBlcmZvcm1hbmNlDQoNCg0KUmVnYXJkcywNClh1LCBIYWlsaW4NCg==
