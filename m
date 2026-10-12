Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977DBCA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 08:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9044740274;
	Mon, 12 Oct 2026 10:57:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0792940272;
 Mon, 12 Oct 2026 10:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791795425; x=1823331425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yRI50p158YOEaD5yDX/HhoEcKHKHOjMPfbem/Kti21U=;
 b=WBv/jzZBVjEQzEgFKtHq2ROVo+bX4LJ4JmjNfnkyZz8p/WvqmFlhWGnf
 DtSvGEKqIavx8mica6/8UC0ZxyPJpDUNNdkLtkFxPmtfgQfMbkq0+/zRg
 C6WjF9y3K4eyxQyrHK9GsptTr3Zw4Bls6rOQ9KoSLerLeEgRkjGfD/Due
 af0CX1NWVg+vvm49AydlZc8cqzl1gu1kzq6gJ7YgKkO3SeDhnu1F+JL7A
 AK30eq6ev2qgdobtVdFQl/n9yf3SQfIvgVwGDbqI4XZuk67Zlevwd4U4U
 WDjII0NaOZQUKB7rMSLsKHuii+pV7+IE+C80cgL36QBIftby9R/u1bCbw Q==;
X-CSE-ConnectionGUID: s/C0rHU3SS27Q31L16RMNA==
X-CSE-MsgGUID: c3Nd2VuOTnyyPn61STXyeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="505931"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="505931"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:57:04 -0700
X-CSE-ConnectionGUID: 21JQ9bsdRvONKvPHW15jVQ==
X-CSE-MsgGUID: x78AD9TYQqieRcQz4gWqIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="768502"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 01:57:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:57:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 01:57:03 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 01:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JagKP7lpusc67wuL05UL62v164mEpfCfhfsdbYzlsWoIQTo9ZufqoRmgb8UAt+9d5k20Ilbzt6DEG6wlWBzBNJPA7d8bcQtbCzVWrjHJhLXtdQuvBGZ2bUe6vwz03mWHpgH3F2ZpORjJHv3+Hg/LP/UFvKPkEXVmRlZo++U520d7fjYTIabef5YZEMJ15DWGdaiVANCkT8Wdi1eXamuGw7LUSH7a/Rj21dPwSv3+nA8u2DZa2VXe8WxOsKCvNg2xW7zfAzo4ZhtJeBNErAxdq+JTGOx1LSy4Yb5dRvmr8AYRlJcVDUUWKfz+sDJCIk83p5DrL9pSCO59/CmBfUtpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRI50p158YOEaD5yDX/HhoEcKHKHOjMPfbem/Kti21U=;
 b=YERnBKhrW4KpTPAZyGwvqV+cg7VhbHcLQ+SQ8vdcqmdGKP0OHY9uQjZWplSpx/SennsFSrtSId4+Odcesr4w3F72zn763i5Zlnn4H0jMqEbdAuIHO4jxWPikWhRZQyD5hwbURfGHIw309u41u27yPLTsnFqJb+A3lAwPOe1LP/YwAUQky8wnQ9bokgPQqD+YYT4oBtobAIqrwe7UiqQRpZX9PW7lkPsY6AvO7LzreswyTEOh94FF/WjA7BrDshrLPY1pd38qGBwUixOGLp8zNPhLnRivnzY2LG9swQLGyf0ZaRg/JiuSE1LVSozCz+/uallCh5Agyyky2BeOc+aH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB379463.namprd11.prod.outlook.com
 (2603:10b6:408:3b3::21) by DS6PR11MB446913.namprd11.prod.outlook.com
 (2603:10b6:8:49b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 08:57:01 +0000
Received: from LV2PR11MB379463.namprd11.prod.outlook.com
 ([fe80::f034:dc57:3874:5e8c]) by LV2PR11MB379463.namprd11.prod.outlook.com
 ([fe80::f034:dc57:3874:5e8c%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 08:57:01 +0000
From: "Penigalapati, Sandeep" <sandeep.penigalapati@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix max number of descriptors for E830
Thread-Topic: [PATCH] net/ice: fix max number of descriptors for E830
Thread-Index: AQHdVtvy5jWVuaUxD0qsCdMlLM+d6rb06J+AgASQTEA=
Date: Mon, 12 Oct 2026 08:57:01 +0000
Message-ID: <LV2PR11MB379463A9259F60F87321C2F7DA9C9F2@LV2PR11MB379463.namprd11.prod.outlook.com>
References: <20261008111928.43095-1-sandeep.penigalapati@intel.com>
 <CAJFAV8w_=HPgGnVEsnXMh7aUf1z6PJeAgMVYd-3NTan5vT2BZA@mail.gmail.com>
In-Reply-To: <CAJFAV8w_=HPgGnVEsnXMh7aUf1z6PJeAgMVYd-3NTan5vT2BZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB379463:EE_|DS6PR11MB446913:EE_
x-ms-office365-filtering-correlation-id: 04ac7c4e-7e42-428c-6bd1-08df283ec7c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|18002099003|22082099003|38070700021|11063799006|4143699003|261009223027099003|56012099006;
x-microsoft-antispam-message-info: j9LtHP3Wy0fOgTDLBTqNYl+Ktgf6Yh4/jPTSZ7+lPdsvLfvdx8eDpa7bUuyvet+smS6qo5MgPEr3bBjoEuHwADWqGjq8ZuKanEWWoRGYo6Al0evDZuutIMAFTtqQwqRIcjuU3vKtDbygOxyGfvH00HZcxODixN+AjMO6nHoGqrqanFObr12C8CcFbWwsHdT8GFlwzij5ryAvUCbtTU5cpncnCb26nXIfXfP7XhDarKFP0Ttvs4/pa/zFZ5jLRkdSq2OwJJwBdWJNMJWTFVxDAJXqO6vE+3PMJptaVLPuC+ibKLXlN0AoTsLYMB1pwHYpEqzRrFprb2tqzvTWEg8I/iJnaNi9cy8z0WQU5sCSchOIAqjETH69ty3R7RJlH8NUY055ig8YjcwGooZ9LkYTddMVOwCNDiCOGCBMnNJ1n+6B7zsVa/uvHFRwfZpLHdrWOYv20EcMf7SRcpkNwVDNhqz7NN28EWxfOkG0zzgxTnfyzZhn6gBLqZF8wLHU6ptW+1S8ooG28vf90gGQDeii6FxoAG9vXsUUhNdnFc9K6sq7XNU0njc27EsLg4Joo0pCqKja/xP8/lcLRDw+zc6twfy8k5LOal47EOB5w93TOFYztFRE+VhbMiPCflo3e7BHigfKVD2PoROfplgKARZ+z41DrrFyw63PkVah/YYUPDik8+5HgysmxDEmzeqG4DGmB47Z2ZQf9VudkySpD523NagPnv9UsfM2nx7p+Rdaf+Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR11MB379463.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWdyRjVLZGF3YnhYTkQyZzA1L3NoZzN6ZXJka1ZOZTdjVDB0RkgwYnZkVVFC?=
 =?utf-8?B?aFVIV2hqTTJMSkM2Mk9rTmRHWFhFT2hPeDlnMklpZFRoV2lINXUvdkQ2SXpk?=
 =?utf-8?B?VGc5d0MzanpFMGNQR3hHTEFraEdKSHJ0UStocExjZ2JCS0paMjZ6dXhtRW5K?=
 =?utf-8?B?NTdsOG9TOGtNcHFXZVlLUjNwalNucWtzcEx4SWlVZElQY3NEVDh4cjVYYmtY?=
 =?utf-8?B?ZWdPem1sbjR1VzVGTS84dVBqZ2J1VCtMTUJ1TWlKVjk5WFF0U0ZNd1BCck5Y?=
 =?utf-8?B?RmtRR1Bia3dTajNleHJGMzRZVVp1dTVPajVkNTRkWTBRcGVWQzdCRVpQRzBw?=
 =?utf-8?B?T0lXcllGc3F6Mm96eWQrcGl5RkJLY21ucC9FQk8wVEUwQUU4aXk0UDlsYld3?=
 =?utf-8?B?QytxdHZ0YmV5QnF5ZDJxekVxaXVVU1dDV3dtOG1NNFBrOE5Na0F3dStYZVFR?=
 =?utf-8?B?SHgrUkxZL1RFUEk5OURzM1lTb085eUl2K01wRGR3bWxQdC9tbnd5YmZHWG5D?=
 =?utf-8?B?RlpERlljTFVjc3YraGlJT3pacHBJcmQ0T2g5MlNod0lqYWFEMDlLbkhvamhh?=
 =?utf-8?B?NXBXTkEzdDRMbWJVZ1JzOTZBcnhCOXVMQmtwRU5XN2xIQTFYT3h1am9RNENk?=
 =?utf-8?B?WlgxemRVRGZ0QjNQSzVZT0NCV0FZSUtlVGdwZk1NK3ZzV0gwQVJkYmRhV1NT?=
 =?utf-8?B?UjE1N0YvNHZzZFcxVFN4UEhZck5DN3lFWUgyOGI4L3R3eXFRa25Tek9HdGhT?=
 =?utf-8?B?RkI2bENWdUM0dzA5aGUvN0JJR0RGVHRScFkycm41S2tvaHRwcUcwaEQ5eUlW?=
 =?utf-8?B?c2lHeDg4cFJkR0pDdlpadG9acnJEb2JmWjVYT0tXZTFuRVliSHNjaHNWdERD?=
 =?utf-8?B?cm85czAxSEoyZk40cEplZjF5L2FOU2E0Sy9mL1ZhbU53WlJ4MWhoWVVablEv?=
 =?utf-8?B?S3duMWhkZHQ3eDArb3JaTWhyZkhsbFkzRkhGcjBnQWRaeFE1RWV1U0diclRx?=
 =?utf-8?B?aWJySGwzbk1aMkRVOE42OW1Lay9mdm53K04vWUc4R2JEK2xRUzBTSFhDV3pN?=
 =?utf-8?B?S1pxUDhkNlkwYzBKelFCUEYweXI1emg5R1JDaENNeXUzRE9GYTM1K0xHb2ht?=
 =?utf-8?B?T3lGRTRxaEVtaXFOZGl2ODVNK3ZuQVcxVTcyNEJlb3hlTFpnby8rRU5EYnRT?=
 =?utf-8?B?czdlL0dNbmZUemVRVjVJcTNZMGpEQ05rQUxpanU5SmRuT2lUMGg2NzFTZ3BT?=
 =?utf-8?B?VkJ5TEVjZ20zcCtFSkgzNDI3RmJmeERRTVdFNTJva2h1V3h6cnhkQWRqbklk?=
 =?utf-8?B?TzN2U0JRNmYrZzIxWFl2Snl1Umk0dXFZY0MxZmxNcFN2blk5VE5CN3o4dW0r?=
 =?utf-8?B?Y0VSZ0JqalVvTXgyWnM5NS9UUWdvenE3UzByaUtlbEVDVTlkMytrbDBwWm9r?=
 =?utf-8?B?ZHRvRzNDeWtEZzNBcjZsTDg4M2ZDQlJCUVFFK2xRc2ZUWUcrblRibDFtVk1z?=
 =?utf-8?B?bFFXSGZ5NTIwenpXcjR0NDl5NEJ4bHdvZVlPb3ZZTWdkWXQ5WUZ6clNWYWNo?=
 =?utf-8?B?cjcwajNFeFdWQnd1YnV5ZzBSWmFrWVM5QnNLNzBub28zbEkwbmhCT0R4TFow?=
 =?utf-8?B?Qy9md0FFRHRFdHM3djV6MitoU3BaclpvNUlETDBVZlFTSURFU0twWnVHRUlO?=
 =?utf-8?B?WXRkZGtaUlZkMXJJaWt1amtCQjJzY0tZQnMwZGFEQjAzb05JY2c1NDlNa25P?=
 =?utf-8?B?QXhjLzl1VlZJY2kybWpDYU1mcWlzbnRDbFlPMU9WQmdnN1BsNUg0WlpVeTMz?=
 =?utf-8?B?YXJZQytHOEEwS2ZFcEFYQ1VEbXJFdlJVNTBsY2FCM3QwS2gzZWNaZFJlYmlZ?=
 =?utf-8?B?aUxNOVFpUUZ2VDZ6TGYrWlRoL3pRNHlHZTFibWNLTkdEc3gvaEg0Zko2YlRP?=
 =?utf-8?B?V2RlcUx0R1l4REF2THEvbEM5NTVvZndlTnZ6WDVZSnN0TUVwLzlaOFpOM0l0?=
 =?utf-8?B?Vnd4alAvMVREZjlSUnVCTk1EMGY2UzZKVEdUY0U1Mi9ROEF6cmRhc0ZGaTd6?=
 =?utf-8?B?alFVVTREVWZpR2NvOGxmT0V3c3NHblRMNUhvL2ZXWnF6REhsZ3RjbHYvdjZG?=
 =?utf-8?B?WFRkWWJ2U3Ixei90RUdGZGF0NzRCcUhjY2xrOGVJQUZyTHEyT0pRY1lvMTBL?=
 =?utf-8?B?TUZwc256VlZtcDUzS2VlUDRJTzJ6Mlc4b1VNNWdURExFQmptc2xPNVI2bVZE?=
 =?utf-8?B?SXRtS2dlWXpBSGRKQlZ3a29MSmErQWxWRE5UVkdVR091c0F0SmlwMmZIQUF5?=
 =?utf-8?B?K0c3enA3UjFKbVNrOGlCUFM3ck9ZYXNPMUxpcjNFejdFcEFXMDU4ZE1PVHRW?=
 =?utf-8?Q?rVVRxrzg/d58eWD0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iiIqSZn2CyptjvEAVesPW8/3bq3VyEjuWiKetfA0TMdJJ/Pe98Uc+mbjTakQdkb6WbLgyTr6rgRGKmk/tBvlz+tXmON7JSIj1azMeqW0m4W0m8kR21zmXlouizlvI0AX3Je1m9sMVusI+YA6uPvu1L2oxcBESIRU3GLvBn4DMY/Jx7YoExSAKCN/vPpZP+yuDUl6Dslf2vNPCF5CjAVrRNYQF+azSTuZo8L7+aw2YStZaKeoYXamBNq+z65HkQjbunigdo0Es87c69grYXCg0gXM5zYaFjUI+wXVPaHN0Oh+/oPIHAcxlxKxqQr9HyqmjYEKUta5vQ1WXaVD4bvSPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB379463.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ac7c4e-7e42-428c-6bd1-08df283ec7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 08:57:01.4479 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8S2ZGGE3RjAkdkzcVAnYDRo6MZTTIxh+Fo6W6wMSZyAY+D70lEXE012uP1T1ZaRlVD8ufVfxa8DTVglwgyu1dR2bsFpAahosuxVQpNrORU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB446913
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGF2aWQgTWFyY2hhbmQgPGRhdmlk
Lm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+U2VudDogRnJpZGF5LCBPY3RvYmVyIDksIDIwMjYgMjoy
MCBQTQ0KPlRvOiBQZW5pZ2FsYXBhdGksIFNhbmRlZXAgPHNhbmRlZXAucGVuaWdhbGFwYXRpQGlu
dGVsLmNvbT4NCj5DYzogZGV2QGRwZGsub3JnOyBSaWNoYXJkc29uLCBCcnVjZSA8YnJ1Y2Uucmlj
aGFyZHNvbkBpbnRlbC5jb20+Ow0KPkJ1cmFrb3YsIEFuYXRvbHkgPGFuYXRvbHkuYnVyYWtvdkBp
bnRlbC5jb20+OyBIb3JlLCBTb3VteWFkZWVwDQo+PHNvdW15YWRlZXAuaG9yZUBpbnRlbC5jb20+
OyBzdGFibGVAZHBkay5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvaWNlOiBmaXggbWF4
IG51bWJlciBvZiBkZXNjcmlwdG9ycyBmb3IgRTgzMA0KPg0KPk15IHR3byBjZW50cy4NCj4NCj5U
aGVyZSBhcmUgc3RpbGwgc29tZSB1c2VycyBvZiB0aGUgdW5jb25kaXRpb25hbCBtYWNybzoNCj5k
cml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX2RjZl9ldGhkZXYuYzogICAgICAgICAubmJfbWF4ID0g
SUNFX01BWF9SSU5HX0RFU0MsDQo+ZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9kY2ZfZXRoZGV2
LmM6ICAgICAgICAgLm5iX21heCA9IElDRV9NQVhfUklOR19ERVNDLA0KPmRyaXZlcnMvbmV0L2lu
dGVsL2ljZS9pY2VfZGNmX3ZmX3JlcHJlc2VudG9yLmM6ICAgICAgICAgLm5iX21heCA9DQo+SUNF
X01BWF9SSU5HX0RFU0MsDQo+ZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9kY2ZfdmZfcmVwcmVz
ZW50b3IuYzogICAgICAgICAubmJfbWF4ID0NCj5JQ0VfTUFYX1JJTkdfREVTQywNCj4NCj5Ob3Qg
c3VyZSBpdCBpcyBhIHZhbGlkIHByb2JsZW0gaW4gRENGIGNhc2UuDQoNClRoYW5rcyBmb3IgdGhl
IHJldmlldywgRGF2aWQuDQoNCkl0IGlzbid0IGEgdmFsaWQgcHJvYmxlbSBpbiB0aGUgRENGIGNh
c2UgLQ0KSSB2ZXJpZmllZCBvbiBFODMwIChFODM1KSBoYXJkd2FyZTogRENGIGRvZXNuJ3QgYWR2
ZXJ0aXNlDQpSVEVfRVRIX1RYX09GRkxPQURfU0VORF9PTl9USU1FU1RBTVAgKGVuYWJsaW5nIGl0
IGlzIHJlamVjdGVkKSBhbmQgYQ0KbGluZS1yYXRlIHR4b25seSBydW4gc2hvd2VkIG5vIE1ERC4g
VGhvc2UgRENGIHVzZXJzIGFsc28gb3BlcmF0ZSBvbg0Kc3RydWN0IGljZV9kY2ZfaHcsIHdoaWNo
IGhhcyBubyBwaHlfbW9kZWwsIHNvIElDRV9NQVhfTlVNX0RFU0NfQllfTUFDKCkNCmNhbid0IGFw
cGx5IHRoZXJlIGFueXdheS4NCg0KPkF0IGxlYXN0LCBrZWVwaW5nIHRoZSBJQ0VfTUFYX1JJTkdf
REVTQyBkZWZpbmUgc2VlbXMgYSBnb29kIHdheSB0bw0KPmtlZXAvcmVpbnRyb2R1Y2Ugc2ltaWxh
ciBpc3N1ZXMuDQoNCkZhaXIgY29uY2Vybi4gSSBkaWRuJ3QgY2hhbmdlIHRoZSBkZWZpbmUgc2lu
Y2UgODE2MCBpcyBzdGlsbCBjb3JyZWN0IGZvcg0KYWxsIG5vbi1FODMwIE1BQ3MgYW5kIERDRiAo
b25seSBFODMwIG5lZWRzIDgwOTYpIGFuZCBpdCdzIHVzZWQgaW5zaWRlDQpJQ0VfTUFYX05VTV9E
RVNDX0JZX01BQygpIGl0c2VsZi4gdjIgYWRkcyBhIGNvbW1lbnQgb24gaXQgdG8gYXZvaWQNCnJl
aW50cm9kdWN0aW9uLg0KDQpSZWdhcmRzLA0KU2FuZGVlcA0K
