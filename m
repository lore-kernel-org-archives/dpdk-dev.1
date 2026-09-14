Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDEEC88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:38:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 813FB40A87;
	Mon, 14 Sep 2026 16:38:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A634B402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789396730; x=1820932730;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iaFjPMWNXOywjVl0hz1GfBLAv6u8QeO0t/BFyE4Z1V8=;
 b=g/4dwbwUeKFbwniUXikwGeIS8fdObyow4i2Oazge4fOonKFY3ISYJwl+
 F1CiIh/6JvqO2C0ipaTsYeRrGKJirLEnh6NQY5l4SHZbUEOAn8CmbIwzq
 K92rG7aNMKfahYYFV+Sttc31FWD+Hv43Xg4qjpix0aObWIa0OrywGQiY6
 uBBv7yZDxaSHQlYZun3kL78dVuf9usxyGBBz8NHTTnrWQXJKVxWudxgGf
 UFo2JF6sTvfT+v4cGGO2UuTTVbwiv5DV7dQhgfJsK0+qwso/vQup6Pvwr
 S7h2Lm5f4wJlUUflGPtOmIk22LaPQdik49UlvEIjcpj0NxHV6bDMs3DW0 g==;
X-CSE-ConnectionGUID: TwfDxRwIQRKUjwJzOsE6sw==
X-CSE-MsgGUID: u5Ujf7s2RVih+d63ZrAS+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89775127"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89775127"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:38:49 -0700
X-CSE-ConnectionGUID: mnGVPjJ7RPaRKlyzis+4IQ==
X-CSE-MsgGUID: CZSas1QoQsiLw8B3ryhlCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266450051"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:38:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:38:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:38:48 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:38:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCOeCYSKb+2HWcmaXnJFLeL8EG8Y0vKxsefdWOe4dRsFM9BMDv+UH7svUqPhIkYBVGpHp9j5hjmygkVYdkTy8zf0jF0CKNIysofqpFh3XOSTUNP3/Iz6yijEN3n3sA6p1HSu848sWUhJh2mnAIKKeps2MH2tadOuNUIHnLQ27f/14Fktm2S/36Zimiiy9WdyMQiZNK1Qu+X4B9v+2jnKD1/DJIGU3YItJpsiabxkcb362Knl+NF2qX24aJUm+MASWjF07kfCPo7X6xGYqZAk9Xh4Shpzx3IBV4HR+lUpPN1mSI4E6C4uSl8T1EIy15aKy9FjRfgaXEFrI258zKSiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaFjPMWNXOywjVl0hz1GfBLAv6u8QeO0t/BFyE4Z1V8=;
 b=NuFZJJ7Kb3aPoM1dIEZb1XO9P6KRbRV0DBbZ/673jPWoA0JntGE4k+aufeOCWZjLuXZfvrgj1GO2AGIpJS0cXrwwt7o7BpCcLZSohuhJzo/dJRk2bGgVvONhRvF3yBm72EXf5PCtd1q6qD29QcqZawsqVuDP/s4DF1EpWaR15IGHFjVwaBHWmAk8E2+fq1MQJtiOfst55YC7QOM+BfHHurQOfpFEDkY4sTky/nAmy2Tuczx+4R/uC4+LkzCen4wsHqB6Gh83xKgCKaE2UuXcUC4fFCtSGUowRUvZvvW8MsX3KAc0mqjuEn6ZFodhn3I7VtHUhnoyaqNJ/IRFBcG87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:38:46 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:38:46 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 09/13] net/intel: move vector Tx paths to common
Thread-Topic: [PATCH 09/13] net/intel: move vector Tx paths to common
Thread-Index: AQHdQQa8iW670gC1QkOFensPoinC7rbOK3Aw
Date: Mon, 14 Sep 2026 14:38:46 +0000
Message-ID: <IA4PR11MB92787A037F83861FB557777D8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-10-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-10-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|MN0PR11MB6011:EE_
x-ms-office365-filtering-correlation-id: f07a3e56-a385-4c15-5feb-08df126de236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WGRmF9vzik28msywa5fa3Q7fRkZJ2fCrGE5+NpU0vw+AI0hP/HYhBL0+mqbBajQ87vaTxDaTvBCGI8J2C8bXycNJOb3AGR0HxR7hWVpssHB7EoEx1+SNpmpQ4KJnmUxY0R6rIByoEf++BbwbkMalhnU7SeZgZt2dNilVBKGlm4d+WHlxrpbMN2WfyY1waFyuELt7ng4hA/ADNrxh77huktyyFKgmLqw+sh8vxiP5sYL93HCG8FsJLEBBejfPjYjsnW9GPUpAgrAo5UN+A6CfewXsaeDYZX3RaEgELy34pEEaiGtFPnvekBN39gZXmaZwCFr4z/g9U4h3merDl2LQKGKbip+owIFcr0rUMIW+SN+6IqGLeejk2g2gflbb1MhsRcleNrL8Vj1Rmy13ImLxLtvXjLctL3EAbiLSWgAJ3rqqrUxbmMg/h9Az4ptXqohlvd23/DbbNTkqKETwCVjAsjbbE7zPiD1556atpDHyCxcTTDMO3etfo2oEiEx4jfE9Ivm3A+p/XyO821s6bdLgcaY8XPfEGSrvxn47Nzz1X+jcNL1Oykq2y45Rn/uJ80qx/q1SR59qZcy29QJxVqr2S9s3X1VoG3R2SD5AXIczMHJkXdzqO78TeH3aLcXZJhKISwsX9rcb9xT3SbImoS3Fjbvklq/G+76OtuXEMT3dHur55rgEp8qFWFGntpb7ohrwJfxk8zEYJCMOpRMJ2hjShQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1hjTXdwVS9NL01rUXRGK0FhSThBbzBPVDhTQXB3cGp2Uld6UjdBbzBrWnJB?=
 =?utf-8?B?SzQxYWNvQmdqdENFc3NqTzdFWWxUWXk0TWlnZ0JHKzFWV0RXdVYrQzE4dlo5?=
 =?utf-8?B?aFdKQlhSb2t6UFBHVVV5blo1em9WMVp1NFI1SnE4S3FPOHRDZUhhWTVvaFJF?=
 =?utf-8?B?cXB4ZFhIRVpPYkhuTDljUjlnNXQ1MjN2bFUzb2RZOEYvczc3cWlIbFRJVXJ2?=
 =?utf-8?B?VWtkTStGclFwMDJUWnZqbCtqSTJYNGFkYnMycmFIYWFBNjFWS3NqWFoyWCtV?=
 =?utf-8?B?RlJvakhCRllPRDF1ZEdFK0ZwTkRFenMxVHRiTWNoaS9xbnpwa2UyL3VzQjVR?=
 =?utf-8?B?Qlk5R09XbDVTckYweFpwcXovWHNEb2R5aTZWNmxHWW43NFVJOGl6THlpdFVR?=
 =?utf-8?B?aHZJdWdza0d4T2Y5SU5wSEY0dmtEQXR2dEZ4czc4MVFKcktCZkY4d0Nwdjhx?=
 =?utf-8?B?U1JtTklNdlBuYlcyRG4xaHR4blJxcjVLNExReDl2UWtIM1NmZVFFWVphWlQ5?=
 =?utf-8?B?bWhjMWVlamVNWVE3YnR1ZnBxamRqUVlrYTlVaE5RZWMrTVNEMUljUHE3UHZD?=
 =?utf-8?B?NGVIK3drbzRURGxXOWVPMzFYUVRLNUYvbGhNU0RwakVSNUcvdFlxRWlnb0Uw?=
 =?utf-8?B?NFVUajV5ZUJiNVFkTWlnTXFjM1ltZVJIS1dWdHlDa1hzclVTOEg4TThzYmJX?=
 =?utf-8?B?eG4rZGpsVmtpMmJ3TWo4K3podVZSRmpseWZvOVc2amt2UXc5LzNVMnhWbVN2?=
 =?utf-8?B?QkhIWkphbjFjRFVvTndLd0pvOCtSMzZlUm4zeDBKUjBPcFBoS1pUUkZ0dVBI?=
 =?utf-8?B?VTlMN2xpZjg5aVBaaXcyRi81NDE3S21xUDVhdFNNTWlIOW90Wk8xVFRrRUNK?=
 =?utf-8?B?U0RZRitEM0ducGdVdFlWZnRkQ2pMYWpxM0RPTnBjTkh5WmltaEsvcFhRNFIz?=
 =?utf-8?B?c2FZUXhqdFlCR3hYRGFQUWIrU21laTcyMDVSNTFJV3liTjdTSmJjODVOZ0Uw?=
 =?utf-8?B?bEdMbGJ2TWpCZGNYQkdHaDFBR3llaVJwMG5MaDl5c0dCbnk2Qk4xcjFpaUVI?=
 =?utf-8?B?d0R6YVNDRXdRNDBUelZ3YSttekhXQVhlazRCZG90TCsraE5SZVE3YXFSS2hi?=
 =?utf-8?B?RUFsNi8xVGx6akhzelE5RkptVURCbE1QUVlvQXh4bUI3N0YrSE1ocTZUanJx?=
 =?utf-8?B?eXlEVFhrSThEd3BUd1JMQlBQY2t3SXhuSDR6ZEpIRm1oS1MzZFhONFVQNE8x?=
 =?utf-8?B?VUxlTmRmWmR5SGJBd3ZxeGhLOEEwU2tuZEVZRnFmN3B0dGdzWVpqOWRNWXk0?=
 =?utf-8?B?dFNwTVdKWWZEaVoyalhlbG5NazBNMjVkeVFsZDVDdnpwLzNVL3A0a0M3TWx0?=
 =?utf-8?B?cGFsVFBKTVpyblpYY01sRVpaYm83OGQ2UTJlVTZpQ0FURkxnT1BzOWMvK3pI?=
 =?utf-8?B?bjFhclQzNHVvcXBubGc1dkFQTVJGYU5MYzZmczhFNFNLS3pUNGxway9scC9u?=
 =?utf-8?B?VUdMT3FNS0UxMnhSa0d2bmZqejBET3pzcmtVVGsvUjZmdFpwUUJycWhsR0VY?=
 =?utf-8?B?ejVrMHEwV1VYd3JJUHo0d05qNHVNWjVvTWxRbXlnWFRza0NVVE9rSTU1UHBV?=
 =?utf-8?B?bWZCOGQrZEJOTExTMk1DeG85SXJPZStlQitVOE5RVEtmVGI5VmdUTVdVSmll?=
 =?utf-8?B?MmpJdGpudFdIQ3ZKcURyNGJNNVk4SGR0SjlSNlV0RTdBQWJmeFRyb1QyZnlH?=
 =?utf-8?B?YzBzS0VHby83dlVIem1Uc0IzeWVFOUJjS3RFcW9ZbFoySDhYUGRPRWxoZkxX?=
 =?utf-8?B?Q1lxMUg5d3I3R2RGalg3Q0gwVXRsU2hPV2xtNWU3Y3NXNHRPZjF3TWU4aDAw?=
 =?utf-8?B?Z2YwM3FtamgzdndVVnkzaWhDdmcxNkM1SUl5WGZ0ek9pMHhUbDhnY3pENWNB?=
 =?utf-8?B?MDVDOTdIRi9CUmNmZ1BsZ01uWHRWdEQ3UE53RDlBc0grTkNRdzZCSEFnUlNm?=
 =?utf-8?B?bW9IOWxpUE9Tb1RQUU1DWEZGUDA1b0RQLzM2NUZyUVhGNDFoNlhQOXlRaDBS?=
 =?utf-8?B?WTNIcG1xU3VOQnhTQWpLUmE2NHpPMVpIR3FzNXpZMWpHMVdNL201aDZ4RmxG?=
 =?utf-8?B?dDk3cklCMjMrd2tueE1lNkFuTTRRNFZ6Q1VZTHJMWTBLZ3QrMTVibTlLNG4y?=
 =?utf-8?B?L2YvM3hoSUFLek5ZaEE3YjQ0cHlpTlZ1cWRSTS83aXcxRUpRUFpyQnZVWmxL?=
 =?utf-8?B?L3IwOGp0c0JqSld4SGZzeDhtNFhwOUlZRWFkVWJnM2NYaFVCUTZ5eit6WHkr?=
 =?utf-8?B?VzlYOVpza3ZHUmN3RjljR0RDZU8xSXV2QWRaTjBxaDZJSkxDK3dLdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b25dg97yVUMovS8Aez9meK76BAICSPqvhgGjT4x9IXi5VdUHUsfWcJkPvjmhoZgwCtR118w6oDeN1A3lknC6PreQdf8UtZUfNhaYzCcGzNNv70dhdv1QDT9F26v4ehTvhZJn8lIVThA4ZKuc2DodbLPoGv5pe1q61DAu0dQXod7TkKGRThr5FC3FPJWE8Iy5dSQ4QvAscuMZqQVBLKY4Iths1WXpv0mOY9QZwZX13swiuLFp7tSJU9DI6Gha2ofBc/5bwbkp1xIF2Oq1Wk6I9kF66nVTt6zTI6VCly1+7pECtpT1PU34Iw+phYfhN1jnzritmPZAPKpeHX0HhHhsVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07a3e56-a385-4c15-5feb-08df126de236
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:38:46.5373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8sEsME4VDfLj9lkgQK9LF85g45Va4BcT1Cb/et57jzFHY7JbkU79Lj0XtplUVfYl9sY0YThZrWfEFh2GNH2bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6011
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDkvMTNdIG5ldC9pbnRlbDogbW92ZSB2ZWN0b3IgVHggcGF0aHMg
dG8gY29tbW9uDQo+IA0KPiBUaGUgbWFpbiBsb29wcyBmb3IgdmVjdG9yIFR4LCBib3RoIGF2eDIg
YW5kIGF2eDUxMiBhcmUgYWxtb3N0IGlkZW50aWNhbA0KPiBhY3Jvc3MgYSBjb3VwbGUgb2YgZHJp
dmVycywgc28gbW92ZSB0aGUgaWF2ZiBjb3BpZXMgdG8gY29tbW9uIGZvciBsYXRlcg0KPiByZXVz
ZSBieSBvdGhlciBkcml2ZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFyZHNv
biA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBDaWFyYSBMb2Z0dXMg
PGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9j
b21tb24vdHguaCAgICAgICAgICAgICAgICAgfCAgMTAgKysNCj4gIGRyaXZlcnMvbmV0L2ludGVs
L2NvbW1vbi90eF92ZWNfeDg2LmggICAgICAgICB8IDEyOCArKysrKysrKysrKysrKysrKysNCj4g
IGRyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9yeHR4X3ZlY19hdngyLmMgICB8ICA3NSArLS0t
LS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfcnh0eF92ZWNfYXZ4NTEyLmMg
fCAgNzcgKy0tLS0tLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTQ4IGluc2VydGlvbnMoKyks
IDE0MiBkZWxldGlvbnMoLSkNCj4gDQoNCg==
