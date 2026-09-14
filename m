Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C07C88E73
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:21:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8381C40A87;
	Mon, 14 Sep 2026 16:21:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 21341402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789395691; x=1820931691;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=noxQ52mpIcEROGzskYQbK50nq+PxKPaBTh9kB8xg69E=;
 b=SClsXcMYPpymCk001EMItl56QvD1RbdnGYQiLumZ5IQeJy9PK8tMKfD2
 6chRPhJ/uRuQiROYixibFOb7rwGxCykseWcWjKmk9rnW9rS8y43nBRPHx
 YQWQIIOfQ6TMFxkk2bhTR8uGPkSatE5newTe/uxadCouYjPIGesVa6g6I
 c8rExRhPaVyNrB9D1JKXBPigaK/Ihqj7APIi1oS+6mTc7KGpocGkpo4Aa
 iQTBsjR7T0n5LOuO/68DUiLW0AJ5WqRzsSRLwtf/JejlogCCD2xskjOpN
 vJ+pwjnHwthmeGi+DW+zUmfOonUzMs3+TI4sdckvKE3cIOl3n5wZYIcod g==;
X-CSE-ConnectionGUID: dTDzRDg8QS+j+VtfZOtpHw==
X-CSE-MsgGUID: 2cuEuxSdQFSqDDZDJKU7HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100074861"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100074861"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:21:30 -0700
X-CSE-ConnectionGUID: F64VGFX7Q0iH2TJVSyH8xg==
X-CSE-MsgGUID: XTpVMIwLQm2d7P51JgoTAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276185669"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:21:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:21:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:21:28 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCcsKoLeZyxmmM9Nh5jqGS4CVc1twvZg4JSFI0vzOPKnlb/JkxGGHKIJRVWoWz7Irg5aktGjogUwmzgBS7m7ze47XrJNrdRCDORMuXGCg0nGgxZh9cqNYxR7XPmwnjz64t/6tRhWXYfty6HxqXJWCLRGIcGTx8w0ZQM4WgT7fy246/PMNpbQJsJwkPITmv88kKbbnjtQeKiKb+jzaZxw11V55HcmbkRAnf9Iu3lSJVau5fF14KSQYXA3WeWa2Eq+2XsYQMs4r1PaZWKVMhSSPZPydtQqtWSyjbZiG93r/x1OKasSNxkxvlt+nw4Ac2quqYGDLA65fVfFtVaqqVtnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noxQ52mpIcEROGzskYQbK50nq+PxKPaBTh9kB8xg69E=;
 b=DXpJp6RNO2XHL8Q6B2u5hf9uExtSHfP7eUdoxlQwnkbqr6Ct6rFUDR/YGEciocuVFrUlmGs3VlzzdZKWpvmSrOjx53UDEm7wzGBnZse/8VtFCwuvn4eW7y1A9qdNr+f/1d8C5CSOdG7Y6ZYxOUn6onk7tLYd/Da/lHbc44l2hQGwzPHKvlX32LUvbavzt4F+DJs+ewRYkPmY0GpyfHGO0/f3J5Ggl/tndAZFe32Nut9l0vDRVZeRX0dul0cm+DFm4YwB8/7vK3fPkADtX7lnxranUHtWc3YgbcJm+LCr5guQFWzSsCfGr8K3ifPFlm197Z5ve75H2zcxZWvcDz61HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DM3PPFE9E88246B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:21:26 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:21:25 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: RE: [PATCH 02/13] net/intel: make Tx context flag common
Thread-Topic: [PATCH 02/13] net/intel: make Tx context flag common
Thread-Index: AQHdQQXpInqtpp7emUqnEyK7/fEflLbOJphQ
Date: Mon, 14 Sep 2026 14:21:25 +0000
Message-ID: <IA4PR11MB9278F832C94CFDE96DA9417B8EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-3-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-3-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DM3PPFE9E88246B:EE_
x-ms-office365-filtering-correlation-id: 1bdb9d11-0749-4e83-7ebd-08df126b75ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: aW/Wpb/vMH8ABOpMAfOXqmBs0RMveQ+88InCgKxnKRBNeoIzhb3Bmc+VqSbeBhGwykfw5BUSVQuhO7VaYzJ1Md5ShyvNQo+o48bJ4OWEM8CjTPxDC702Hqid2FP+LiXYcbmKR4BSJggos6/8DnLuB+tMCPjTOrFbpJ/5n/TdIY3uGcFD+uWZqvWT5XerIawjubImfBpla7YIBkMkhuRIHQ6bzIdoibWb33LvvVNC+WIOPYLJ0t3YST281MY9UOd2P4rjkwMvxSkZi+MwsDpUepm7/GEaqUQokfLvN2pDgiT2tm5Oxddyo8BJGepp+At27dyK/ayVO0nFxZFnH+mKphZPQsIiQ3Y7zGRr+XQIPwMLYL1gT6sTYDDq9z41TIFXOnNQeCGCFFnJxeDsEmLvTwHyGlNMAjBg1pCbxSiiUNnfUoz+WXpfS3rIWxTj9W9W5YprO8tZ2w1DGoI3+siiM9STna8P6h45/Evl/pY6ykKIiKank4m2GHxmjBeygMxSYa/riA3kOnCTwmG2DJtXavn+VzRsLgQLtKYZGGa+jEbNTibDqW4PHVopTLtaoIH4Pszk2p5/NvokNfMF9q+6d5W8Z7SSjelW5kBc19VDeDVqfforfcRL1T77y4zj1aAkpSDw+eb09YVHrRUe9tvjEiQhgpl7n0e++GHu+6LISNMv8yZkua9rv4173a+e+G8uBOPCGfmwsu5qYtne9cXkyYxhYw0g//oFCkFrHoWQWrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERRZGE1cDZDMlAveGxJdlRNWXBKTVNDMWJnNllyWFJaamNpNEZDTldGNXpr?=
 =?utf-8?B?YU9Zc3JiNytIL1Q4bTZpaUJuTUd1N25GdWdnNFpTbUdmSEtHK1dGYWl2em5T?=
 =?utf-8?B?SXRjaHpRUU9KbG5zYmdLU3ArV2pwN0Qxam5pdGN0bGQvOEtkSWpSU0RZNWRE?=
 =?utf-8?B?bVJrcGtxMHRvb1pKSWwrSUtmaHkveENycnc1V2dMUEJvUFNWcGtlTXZhM0JW?=
 =?utf-8?B?UUpQMXJ4dm1PbjVjQ1FvM3NaNVpzQnYwOUJxNTF0VjVDM29LN2NyK3JvT01U?=
 =?utf-8?B?ZVdnZUxWYmRnSHB3WG8zYU55cy82NnQzNnZySTVsMzlPZzl6VjZ0Z3Fac3g4?=
 =?utf-8?B?VnlkV0JtdFhmcjhINHYxUGV0SjBDSkg2L3RvUkxQc3BYL0JrTVI3UWpaM0Ey?=
 =?utf-8?B?MkhBdzhwUkdRa1RIQjlNeWpoZTFzazBibUpOUm5Sc00wZmRUNUFoWCs5bEx6?=
 =?utf-8?B?U2JHZHlPLyt4Q21naEcxU1NLajJFU0VmZ0U5eWJXdGswM3VxWDFVbFhsbUtN?=
 =?utf-8?B?eWZoanYrVkdmTGRQRXkrNUlSTlppeHFYT0xGRWphcUUyV1phZ2tvUy9GaXIv?=
 =?utf-8?B?WktnaG5qMEdSNE5BN3prSUdOVVBQcnZNRTZPNmY5UnhFMDBzTkRGSHRwYnBF?=
 =?utf-8?B?K3B3VTZoVmRraXNMeXJSN1RjV3pLZmVyR04rKzQ2ZTloc21PTHNkcGEyb2NK?=
 =?utf-8?B?V1JCQy9vbUtuQWFmem93UXdWRisyTkgyT2o0dkc0MTVoMmhsb1VPK05KMHh1?=
 =?utf-8?B?bDhKeTRkNzZMWEQydE1MQk1IazBlODVHajd4V0dIMUFNeTM1K05DV1BOTmIy?=
 =?utf-8?B?U3FuN093M1JVSkNvNW5oVXhHMnRweFMrZzlpQk51eVN2NHZJcGVtSnFyQUZ2?=
 =?utf-8?B?cG5JeWdQcktLS1hvUDd4RGkyU2xlcml1dTRHMVM5TTk2TkRHamNVMEJLRVZV?=
 =?utf-8?B?Nm1sMndoTS9FSzBVOUh2R1ZXRnZhNmhadTkrWTZPK0VTblgxdlJRRjNLVzlx?=
 =?utf-8?B?ZU1ha3hIa0VRdlJicm95TTRzbHhPZ2I1bFJJV3VUTDU3OUQxanI2QWd6bEw0?=
 =?utf-8?B?M2hxUjA2TDYrb01oU2Q2ejlaVVpFU1VjcjUyanVSaS8zNlUzdkVqMGhLUTJm?=
 =?utf-8?B?cGVXdGdWRlRQL2VCRFlOZ2dPZk1hRDYzbnV0TUI5amZZRkVSTmlpTFJqT29J?=
 =?utf-8?B?QWtBWnlVUTFEcFVDTU84Y0dQbk9MRFYvaDR0TnhuQVBmM0NVMmZSRWh4S0pJ?=
 =?utf-8?B?bGJxMzlybEZCcUI3clJuYUdxN3VPeC94dDV6YkJBNUhWakRZKzJvMURJcXhm?=
 =?utf-8?B?UVNZS0hBRkFKeC8rU1dhVnhKUHhhWnc0ZU1FR2N5V3RzQ0trRUtXR1FzZ2RF?=
 =?utf-8?B?OWZiNCs2VmEvRFp4dzF5N3pTK3pwWTFGSGtJUFdCdmU1Y0wveWZqZkE0OWdV?=
 =?utf-8?B?cW9qaG9CMDFoWlBiZlorcXRWNlVTMEd1MzhvZ1NxUDlJZ3d5c3UzYStmSG1J?=
 =?utf-8?B?SUFpd0dUcllCNHlGYnIwdkliQkliVXAwc1JzK1dnZkZjMlppSmFQS0t6ekNB?=
 =?utf-8?B?dkhhcjVnT2JQNVZtaUxTSTFOdHlCdzJOaklIR2hxSzdjeDhEeU1iWlByWGJN?=
 =?utf-8?B?S2RmVTRxQThCMExzS2Jya0tZYjhnR2FSNGpvdktSalF4dytUMGZJK2dldjFw?=
 =?utf-8?B?MmVUekhteTN3c1ZGNkFCb3BNY2toVjJkdFVINGFObHlhOUVudHpSQW1BREF0?=
 =?utf-8?B?YzFJY3FUTDZvOXV5NTRZQlZpTkF5M3ZyYmMvTVpkak1oaWd0UEdtMnNCK0kz?=
 =?utf-8?B?SGFjbnF3YkZ6eWUrUWV4STFlUVV0QzdqUCs5RWtxQTUrazRZY2lXWWtMbWtQ?=
 =?utf-8?B?TlVEWmJkb2ZSd1krc0x0NDJsN2NHby84RHBlT3lXdXlzNTlSUktOVENwaGlp?=
 =?utf-8?B?d2Jxd3FoNGRCRGU1WXFJZG4wTkNCUXBhR1hnbk9iWVhGdEE2YlJ5N2dETzlZ?=
 =?utf-8?B?aVdNL3JGZmx4akdnRlFIR0ZZb3VJRlE0WnRFMzRFZFlkZGdZY2ZuQis4ai9s?=
 =?utf-8?B?UWp0M0hxbzFBcnM5YlkrYUNUbW1sQ3JRZnZZUzlHWG9zRGxCUDBGYTd0SXZF?=
 =?utf-8?B?bStQaE91TTkxb29HcFRvTE45MkJUbXJSYXBwaXYxcVE1dHIrWHRLYUh3ODhv?=
 =?utf-8?B?YnFzMFNWenE2a2RnS2F1LzRJbHJVZWt6ODAzVllOKzVZd01nb0MyVUc4eHJQ?=
 =?utf-8?B?a2hhckZBMXhPOFluTk1UVExYek5XaEVqQkROTU0xa2Z3elZuYUtYNkUxT29F?=
 =?utf-8?Q?ekMfd41Z18XeUVgBO9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bWvURninfjfCzpPSopCoY9v1VdNcTwXP9kKmAF//FBYHZ4MWVLLHga/8dQ144+UD8QcHsyBSIQssQiI5Oj3fzwhaA1JG/I2Jpk4S4CtQDXOy1f8I+TG12Qqk73/uokBZTt4zcoTAJcQOazlN0Prd623yDKwFO7Ta9Tdktf8aEeL305+H2ai1wuXmZ9h8eDJA/RnYteE/AVz1II8Jf7e1+h7gpZBa9RxWeIlQCtOe0l3u/wU9uMbSte8eDQvxIqWTMivIL4PuVjNMnavD1HYvAXrE1BiT0PTi+rhpJ4tx+tqflj6YeBdfFsrjvRj5rDP4j+1uwhmEWi/0uunpvbpI/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdb9d11-0749-4e83-7ebd-08df126b75ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:21:25.8090 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9U/seeiRuQQ0Jv1VQYWJw6yI9Jbx1R4JzjiWtUkRtxMBnylta5yqMerbQrVH/yPNTmGKNGP0/mZU86rctKcD+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9E88246B
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDIvMTNdIG5ldC9pbnRlbDogbWFrZSBUeCBjb250ZXh0IGZsYWcg
Y29tbW9uDQo+IA0KPiBUaGUgZmxhZyBmb3IgZW5hYmxpbmcgY29udGV4dCBkZXNjcmlwdG9ycyBp
biB0aGUgdmVjdG9yIHBhdGhzIHNob3VsZCBub3QNCj4gYmUgbGltaXRlZCB0byBqdXN0IHRoZSBp
YXZmIGRyaXZlciwgYXMgb3RoZXIgZHJpdmVycyBtYXkgdXNlIGNvbnRleHQNCj4gcGF0aHMgaW4g
ZnV0dXJlIGFsc28uIFRoZXJlZm9yZSBtb3ZlIHRoZSBmbGFnIG91dCBvZiB0aGUgaWF2Zi1zcGVj
aWZpYw0KPiBwYXJ0IG9mIHRoZSBUeCBxdWV1ZSBzdHJ1Y3R1cmUsIHRvIHB1dCB3aXRoIG90aGVy
IHN0YW5kYXJkIHF1ZXVlIGZsYWdzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQnJ1Y2UgUmljaGFy
ZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQoNCkFja2VkLWJ5OiBDaWFyYSBMb2Z0
dXMgPGNpYXJhLmxvZnR1c0BpbnRlbC5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRl
bC9jb21tb24vdHguaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2ludGVsL2NvbW1v
bi90eC5oIGIvZHJpdmVycy9uZXQvaW50ZWwvY29tbW9uL3R4LmgNCj4gaW5kZXggMmQ0YThiNWQz
Yy4uZmI1MjY4Yzk3MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvaW50ZWwvY29tbW9uL3R4
LmgNCj4gKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvY29tbW9uL3R4LmgNCj4gQEAgLTE3Myw2ICsx
NzMsNyBAQCBzdHJ1Y3QgY2lfdHhfcXVldWUgew0KPiAgCWJvb2wgdHhfZGVmZXJyZWRfc3RhcnQ7
IC8qIGRvbid0IHN0YXJ0IHRoaXMgcXVldWUgaW4gZGV2IHN0YXJ0ICovDQo+ICAJYm9vbCBxX3Nl
dDsgICAgICAgICAgICAgLyogaW5kaWNhdGUgaWYgdHggcXVldWUgaGFzIGJlZW4gY29uZmlndXJl
ZCAqLw0KPiAgCWJvb2wgdXNlX3ZlY19lbnRyeTsgICAgIC8qIHVzZSBzd19yaW5nX3ZlYyAodHJ1
ZSBmb3IgdmVjdG9yIGFuZCBzaW1wbGUNCj4gcGF0aHMpICovDQo+ICsJYm9vbCB1c2VfY3R4OyAg
ICAgICAgICAgLyogd2l0aCBjdHggaW5mbywgZWFjaCBwa3QgbmVlZHMgdHdvIGRlc2MgaW4gdmVj
DQo+IHBhdGhzICovDQo+ICAJdW5pb24geyAgICAgICAgICAgICAgICAgIC8qIHRoZSBWU0kgdGhp
cyBxdWV1ZSBiZWxvbmdzIHRvICovDQo+ICAJCXN0cnVjdCBpNDBlX3ZzaSAqaTQwZV92c2k7DQo+
ICAJCXN0cnVjdCBpYXZmX3ZzaSAqaWF2Zl92c2k7DQo+IEBAIC0xOTQsNyArMTk1LDYgQEAgc3Ry
dWN0IGNpX3R4X3F1ZXVlIHsNCj4gICNkZWZpbmUgSUFWRl9UWF9GTEFHU19WTEFOX1RBR19MT0Nf
TDJUQUcyIEJJVCgxKQ0KPiAgCQkJdWludDhfdCB2bGFuX2ZsYWc7DQo+ICAJCQl1aW50OF90IHRj
Ow0KPiAtCQkJYm9vbCB1c2VfY3R4OyAgLyogd2l0aCBjdHggaW5mbywgZWFjaCBwa3QgbmVlZHMg
dHdvDQo+IGRlc2NyaXB0b3JzICovDQo+ICAJCQlib29sIGxsZHBfZW5hYmxlZDsNCj4gIAkJfTsN
Cj4gIAkJc3RydWN0IHsgLyogaXhnYmUgc3BlY2lmaWMgdmFsdWVzICovDQo=
