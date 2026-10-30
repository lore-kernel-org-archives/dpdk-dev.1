Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF7606AC25
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OkDrUnfJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC6A40A72;
	Fri, 30 Oct 2026 12:01:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 8592440A7D
 for <dev@dpdk.org>; Fri, 30 Oct 2026 12:01:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793358113; x=1824894113;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+cB4vgH88bgQ2Et/u7anETUx6MQ/y3YamRWqoM97Zeg=;
 b=OkDrUnfJw3p2VOjaX9aITqAevwXzQHtS7z9IUdyWLAdRJ44Zk0O0Kq9X
 N459q0bt7apvFbTUpnlLm1z/tS6nhDIO8X93h1Xkg30irD8zAsC/CuepS
 vOLkfvNB0cCinDrkw+qRBkDLipIJuo06iKknQm8GlIBSqCvz8vmiwMX6q
 o6wBx9ZMiqEpJkOfRFwkq+cXQk5SWV6rc6diSzkyRNJwbGX/nTSXIVONH
 1dGrb20iauaxPzd0FT/+ijZGvuwjjGCrw/lfuv9ceDTq0bOSWBwk1LyK+
 Zq3/8G2Y9f/ktpKhVpJFWW88/RwiE7SZ2eJPNZ01BEqkX8tONGVa7Q0WX w==;
X-CSE-ConnectionGUID: t8g5eNbMRLekWl5l6wa/lQ==
X-CSE-MsgGUID: z7WN/odQQ2WBB0Q32/GaSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2210157"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2210157"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:01:49 -0700
X-CSE-ConnectionGUID: qHDz3yN/Q0uIRcLN1RKdMQ==
X-CSE-MsgGUID: hgWtjTvAQ7SF7JX7dTeeVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5533507"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2026 04:01:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 04:01:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 04:01:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 04:01:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge1F2TQRm86giorxdEN1i6ZiClqmjCFjJQ/uHZu08iw/oQFXhLtNCuhijIxdHa7MU76SjbZmy7sjFOwJh9m7yS2EOquwQfcf5f3F4j2veq1yzs1c8+yPvpfiivdYfELwK8Xb1IAycdQMrrQqcFlvJbE1mINnYdzdNX+fdC5Lt76oPF6x15sLKUurY7cBHek+a96Y9wg91kPQGarXX0IZ//Z2ZdJNKpvaszG+H0U/g0XTibkVQBAi2YLs4VLVL3P//xKAIUVxD86ZlSB7qrCFFxqtnV/0aUg0Yf6cnNjdFmhJlvktRc9/GGtWiA6u+N/Iyf+QB/vi3LGbZoUxj571Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cB4vgH88bgQ2Et/u7anETUx6MQ/y3YamRWqoM97Zeg=;
 b=NHEJBd+uamjpxP/MxBDOXYNL4HHr5WtSOjYpMWqR25sbEkROwR+UH0PEUSmBl3RD/izFFuBDCeteF6SzKsvak8eBi9lkR3O8RYdikV72vasfO0ULP39NyPcdJOIxlrtfKQVbVYkhzpnHX//VTka5cijTrKmEGa4zcCKQ9wTcEgGk2xyInnhUg9ElX6UpB/Ozj0rlYWGQ5qMRG+peG45vLzYacEHQCDmHAMha5uNFdU4Sqk86JNLagad5cPz/b2/ojhx4xSBx9Y+zi8IeY2848MSadXUKwc7RPF5r2OC+nThvZ9gAe4tTxNWO5GN15Xel6C3UQZnmpt/d4GTaSQQzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by DS0PR11MB6398.namprd11.prod.outlook.com (2603:10b6:8:c9::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.10; Fri, 30 Oct 2026 11:01:45 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::da3d:3782:12da:3996%7]) with mapi id 15.21.0569.007; Fri, 30 Oct 2026
 11:01:45 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dev <dev@dpdk.org>
CC: "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>,
 "Mcnamara, John" <john.mcnamara@intel.com>
Subject: RE: DPDK release candidate 26.11-rc1
Thread-Topic: DPDK release candidate 26.11-rc1
Thread-Index: AQHdXRAPwZGjEucLskqjKeUPWhUrSbcWAX1Q
Date: Fri, 30 Oct 2026 11:01:45 +0000
Message-ID: <DS4PPF00BBED10C514CFA02ACC8809DE7D09F6D2@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <MhL9-e6MSdueACnSJljpbA@monjalon.net>
In-Reply-To: <MhL9-e6MSdueACnSJljpbA@monjalon.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|DS0PR11MB6398:EE_
x-ms-office365-filtering-correlation-id: b19d5be7-b91b-4aca-2161-08df36752fda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021135927099003|10067099003|3023799007|6133799003;
x-microsoft-antispam-message-info: 2ZvtdbLXP//v29yGloTgsALggSsGN/HRpROciCLVnzeTXb0OXA6G5F9MQ44f8W523Uay0eo1OxRTFOdXQq+U63xW0qJ8kluKjnc8n4bk7Tpu8NhiOpakimhjRTe6tIzox9RgmSsNxSfDhziDgsD7LnHUxA8aSEyDPi3aJSlbbUTFJPEaBYgmzofvu+MlYAoEMGBfVpvMNYcI0LUyxsmjn+Ts9HidcaPoSGugKoTkIq1Y5Q2JQNVYZLmO/MqOybrC+Ly0j3ZzBnNO9jUEcquMVBxcaXNJDy/A+91ZKNG628ZPIPZQXc2I6Ul9heaNiHleDm4+v65huUzw0NnJA+8ywZbpEUVsRoJGdPNsxCRg1P5mb60ocNUtY+nVZND//rEYFD7sOSKObFrXyTB4qfbOiEm12LFIFxecJomjGEaKSwLucomtnuZizRt5CqLnoVYq9dn4yKwcxuy3EB3miOW1Ib/VKy+rgfA6W7UK1csuv6wsB26cC3jRLJxl85niyTtev0wer//4IJ2J0JUhvepqylUMWb8+zzNS2m/4Wx1crRBUb3Kh3Mx3Px1kUEWbV/YNqfHP2oENWq2BxaazP335eaHFnXnMMS04junuQF4IYfvBUl0kKbNAACEkIj5fqKAbPLFgF25RyfV+/KnzLpxHoEl/1ggjm0d3H6WvP4RlQNQPLokH9S2v6+5PeArZO7mL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021135927099003)(10067099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hLNkUwaVQvbkJoQzZyNTBjaDBGWE80a2dJa0EzL25rQUQvcFE4RzliejJq?=
 =?utf-8?B?RXFoNXN2enV1UFkzVW4wS2tiU0NqZnZkUnpUdHArcWJXVmlKTE9wVWxRYkdo?=
 =?utf-8?B?MXljakhCblltZENuYjZ4WXJPTjBnYk5wQUdRWHFsdzNVeTdvSGdSV2RnWVV1?=
 =?utf-8?B?T2FLNHVzS2FkM0dKZEpNdDNpQmpUUVZtRTlQU3cyUWZnMnBBdDdiM1NzMHRP?=
 =?utf-8?B?bDQ3YzA2RFhrNktWRnpvYlNseW9HQTJyM0prQmZ6YWVRWFJwZ0VaT0d3WFpE?=
 =?utf-8?B?RExNZzVSTmpIeWpEQ0VqaDZsUmxzYVBRT1Jza09ibXFObE1YdXRoM3NoMjJQ?=
 =?utf-8?B?Y0R1NHdybTlJWEhhZ0hsWmIzZWlIMXJIRmRidkU5WTFLL3JEN1gySEhaQ0Vo?=
 =?utf-8?B?Q3cxYW9BNHZSZ2NHMUN3WDd1SmNGRkRFa3NEdWozcEZpb2ZTYWt6NGZ5Tzhl?=
 =?utf-8?B?TmdiaU9CaTNaYlpnaDlDeWFzUnRKSVNYenc2dWJGK0wwRUFsQ001Zk9oNmpO?=
 =?utf-8?B?SklNZ2ljbkFGOWhEcmxqZnZsbmNBRnA4QkJhUE1nMTQxZW1BOU83NVc5YVFn?=
 =?utf-8?B?NFFRRzFIbkM1S0gvVDF5Y2hJVmI0dmg5WmRrdW1mU3BjdmFsY3JVKzhWaUhB?=
 =?utf-8?B?TTZURllPZHl5U0x5OVBVUzc1NU44STkyM1R0QWhLWGZhSmxvOGZMRnh6Q0R4?=
 =?utf-8?B?cnVHN3ZhcVEvUWJBcU95dWljcGNCNm5YUFE5a3lLOFBZVGkxdmJzMWJ0akx3?=
 =?utf-8?B?bjQxd3Q4akQwZHVLVEMwejJEMTdVLzF6YXpTVDgrUlIwc0kvSzJqWTdrVU40?=
 =?utf-8?B?MDRZL0hTVnRDdFlKRzE1cG1xeTgvRWV6RnNoS3dKM2V5VDhMTGFJQ2xsckdQ?=
 =?utf-8?B?ZGR3ZENUUkVnQmlseFJ6ckRDYXhWTzM1SHZVTU1XSU5xdUdmYkNzVzJHN0NW?=
 =?utf-8?B?Ym9LdXk1cEg4aUFJMzIwNy8rcjhGbm1aNldDZXNwZFdpaGRGVzB4TWNGSFRU?=
 =?utf-8?B?TTlzTmRQYWFGVHRTaDNCZ0tGV1pRbzFjeVJDbVE2UzFMVWltcEZqbUpKSW5O?=
 =?utf-8?B?MHJBdkk0MXFsUHNXcjFON05DdVdITCt1aU9hRjV1STZyYWZrY0RmaHhSbDhr?=
 =?utf-8?B?UXR1UXRjTitLMzJPTlVNdDBrVGZ5YXYxOVBsQktCZm5GaFhvUUMvSXZoMU1Z?=
 =?utf-8?B?bENoeFBiUWhiSy9FbUVhL0ZuUEsvbExFUVVHeE9CbDZMNjRzc3k5d0ZKVTNI?=
 =?utf-8?B?dHRQMmo1ZmcxZE11aCtMcVVpQnFWdmNvbEJNOXIzTWQ4WU9Zc3Rya3NDNHlt?=
 =?utf-8?B?STRsUFdTcTFvUU9GK0l3UEF6WUllVGVQYldJZ1BNWFdrN1ZrejlaUzJkdi80?=
 =?utf-8?B?NWR2d29pUDI5QlFaUEtVMEVINVl3eERwaVhuYisvS3ptUWNmR3RERk5SUENB?=
 =?utf-8?B?U0p6N0gyV05EUTBGUWZCUlNtOUpnWDRnMW03S0d2L3M3RkVnSnpsVTlqdVFr?=
 =?utf-8?B?RjZiNG9aMGIwRW9WdHZRcFpxMTlVblZHNjlYcncrK3psTzMvOWxXVDI1QmV5?=
 =?utf-8?B?VXIwL21Ra3ZhZ3h1ODJ2dWhrampmc0Q5TWdibjE1SFRwNjlVYXRmektTRXkx?=
 =?utf-8?B?a3NOUUdyTm9lY21oRXUzT2ZLcEZ1cTlHQ3lITWpsbi9kSDBzVlVNODJ0ZkJ5?=
 =?utf-8?B?QUFtb2wwT1Jqa2d3S2Nwdk51eC85SitKakRRanYxOFhwUmJXSldkSVVVdFdw?=
 =?utf-8?B?cUtqU0ZJMVUxa2tVNWUyL0gwbFFWcXlZTlB1Ym5aalpJQnJzU21HMjlybi9G?=
 =?utf-8?B?dGwyZVl1Sk1xaEN1d1d1QVBodTAraDVmcXpVTElUOU9FcmFZSzc1UWhiOHBT?=
 =?utf-8?B?RWJlVE83T05FM0RoZ2k3S0R2TVlMS2gzaFc0TmRuWW42cFB2ekF5SUVMbUVm?=
 =?utf-8?B?YUxBSWhEVlRoL1V0czNwa21kWHdsdWF3V1JNcjQvMG5jbUdLaW12aDEyYW9l?=
 =?utf-8?B?d3V1V1k1VU9NdHhYaUhhbW96N1hHUzVKdTR3czJqaVpMNGwyd2F1Nll4dWVQ?=
 =?utf-8?B?RGxMZ2xyVGNtVUszSGFCTEVoN2ZiU3hCVXpRZS9EM1pjYjdvNlNEZTBqZHBS?=
 =?utf-8?B?NHZIN05KWjlzVldMMnkzVUgra0xqNEtqdVcrRk5XRXdDUG5xbFJjOWFDYmFM?=
 =?utf-8?B?TU5HYUovbEpSWjVKTE1QVkNTRDM1dXZRNlN1Yzc4eXNiTjFmMmF1U3EySVBp?=
 =?utf-8?B?a2NzUFN0K3FOKzZ1U1crZzlmQklXTlJtREVxd3RpLy9ROWhEaGczODJoSVFU?=
 =?utf-8?Q?jF4uLHf2U+4vW11+nW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: a1auo3WwDeH8DF91ajIxKPAa9JZpug+WHRFaDVxiGV1FYDr9Nxb+T/N5P872EuoQ5mfPNWx6VL77AeRmv0x/gaJG9h9qAe4Zlgc3/J6/kxG1ORpXrBnbfQLubyn18cuuIaB2nxZvRHRpY9mc61GmxCT9Ie9bjJSYizjsTWb8zj4h8nbh7siPC2sh8bEBj6vPy4ETSl3JYJMleAz5JTXj+xRGOh5X8zhAr/pvyoOotSWd7J9YUpQvFSqPTyYwV+i9VfhAOFG4hRbFqPupupVuraWzmP2rm18V4TQbkbk1ok4MUciy9OWbh3xT0hm9sgsrf5pr7gUxPXFrCa2MHfJTmw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19d5be7-b91b-4aca-2161-08df36752fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 11:01:45.1648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtvVL8d6x5ZzBIu7agdFkizYyfLcjd306ogoEZMYBRCG+TCAOQ3c2OKaodB7jkgc1mJt6V9d4iQLuO6CWHTRGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6398
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21hcyBNb25qYWxvbiA8
dGhvbWFzQG1vbmphbG9uLm5ldD4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDE2LCAyMDI2IDk6
NDUgQU0NCj4gVG86IGFubm91bmNlQGRwZGsub3JnDQo+IFN1YmplY3Q6IERQREsgcmVsZWFzZSBj
YW5kaWRhdGUgMjYuMTEtcmMxDQo+IA0KPiBBIG5ldyBEUERLIHJlbGVhc2UgY2FuZGlkYXRlIGlz
IHJlYWR5IGZvciB0ZXN0aW5nOg0KPiAJaHR0cHM6Ly9naXQuZHBkay5vcmcvZHBkay90YWcvP2lk
PXYyNi4xMS1yYzENCj4gDQo+IFRoZXJlIGFyZSA2OTggbmV3IHBhdGNoZXMgaW4gdGhpcyBzbmFw
c2hvdC4NCj4gDQo+IFJlbGVhc2Ugbm90ZXM6DQo+IAlodHRwczovL2RvYy5kcGRrLm9yZy9ndWlk
ZXMvcmVsX25vdGVzL3JlbGVhc2VfMjZfMTEuaHRtbA0KPiANCj4gSGlnaGxpZ2h0cyBvZiAyNi4x
MS1yYzE6DQo+IAktIHBpbGUgc3RhY2stbGlrZSBjb250YWluZXIgYW5kIG1lbXBvb2wgZHJpdmVy
DQo+IAktIGludGVycnVwdCBGRCBsZWFrIGRldGVjdGlvbg0KPiAJLSBWRklPIEFQSSBtYWRlIGlu
dGVybmFsDQo+IAktIFZGSU8gY2hhcmFjdGVyIGRldmljZQ0KPiAJLSBEZXZpY2UgVHJlZSBtYXRj
aGluZyBpbiBwbGF0Zm9ybSBidXMNCj4gCS0gbW9kdWxlIEVFUFJPTSBkZWNvZGluZw0KPiAJLSBm
bG93IGdyYXBoIHBhcnNlciBmb3IgZHJpdmVycw0KPiAJLSBSU0EgY2FwYWJpbGl0eSBwYXJhbWV0
ZXJzDQo+IAktIEFNRCBBRTRETUEgZHJpdmVyDQo+IAktIE5YUCBpLk1YOTUgZURNQTUgZHJpdmVy
DQo+IAktIGJhc2ViYW5kIHN0YXRpc3RpY3MgcGVyIHF1ZXVlDQo+IAktIGF1dG8tZGV0ZWN0aW9u
IG9mIHVuY29yZSBwb3dlciBkcml2ZXINCj4gCS0gZ3JhcGggcHJvZmlsaW5nDQo+IAktIGVCUEYg
dmFsaWRhdGlvbiB0b29sDQo+IAktIHJlbW92YWwgb2YgZGVwcmVjYXRlZCBBUEkNCj4gDQo+IFBs
ZWFzZSB0ZXN0IGFuZCByZXBvcnQgaXNzdWVzIG9uIGJ1Z3MuZHBkay5vcmcuDQo+IA0KPiBXZSds
bCB0cnkgdG8gcmVsZWFzZSAtcmMyIGJlZm9yZSB0aGUgZW5kIG9mIHRoZSBtb250aC4NCj4gVGhh
dCBsZWF2ZXMgdXMgbGVzcyB0aGFuIDIgd2Vla3MgdG8gYWRkIG1vcmUgZHJpdmVyIGZlYXR1cmVz
Lg0KPiBBZGRpbmcgbGlicmFyeSBmZWF0dXJlcyBhZnRlciAtcmMxIHdvdWxkIGJlIGFuIGV4Y2Vw
dGlvbiwgYnV0IGl0J3Mgc3RpbGwgcG9zc2libGUuDQo+IA0KPiBOb3RlOiBTZWN1cml0eSB1cGRh
dGVzIGZvciBzZXZlcmFsIExUUyBicmFuY2hlcyB3ZXJlIHJlbGVhc2VkIHRoaXMgd2Vlay4NCj4g
VG8gcmVjZWl2ZSBhZHZhbmNlIG5vdGljZSBvZiBmdXR1cmUgc2VjdXJpdHkgcmVsZWFzZXMsIHlv
dSBjYW4gcmVxdWVzdCB0byBiZQ0KPiBhZGRlZCB0byBzZWN1cml0eS1wcmVyZWxlYXNlQGRwZGsu
b3JnIGJ5IGVtYWlsaW5nIHRlY2hib2FyZEBkcGRrLm9yZy4NCj4gDQo+IFRoYW5rIHlvdSBldmVy
eW9uZQ0KPiANClVwZGF0ZSB0aGUgdGVzdCBzdGF0dXMgZm9yIEludGVsIHBhcnQuIGRwZGsyNi4x
MS1yYzEgYWxsIHZhbGlkYXRpb24gdGVzdCBkb25lLiBmb3VuZCA0IG5ldyBpc3N1ZXMuDQoNCk5l
dyBpc3N1ZXM6DQogIDEuIEJ1ZyAyMDc0IC0gWzI2LjExXWk0MGU6IG1hY19maWx0ZXIvdGVzdF9h
ZGRfcmVtb3ZlX21hY19hZGRyZXNzLCByZW1vdmVfbWFjIHRoZSBjaGFuZ2UgZGlkIG5vdCB0YWtl
IGVmZmVjdC4NCiAgMi4gQnVnIDIwNzEgLSBbZHBkay0yNi4xMV12c3dpdGNoX3NhbXBsZV9jYmRt
YTogTm8gcmVzcG9uc2UgYXQgYWxsIHdoZW4gcXVpdHRpbmcgdmhvc3QtdXNlciB3aXRoIENUUkwr
Qw0KICAzLiBCdWcgMjA2OSAtIFtkcGRrIDI2LjExLXJjMV0gbXVsdGlwcm9jZXNzL3Rlc3RfbXVs
dGlwcm9jZXNzX3N5bW1ldHJpY19tcF9wYWNrZXQgc2Vjb25kIHByb2Nlc3MgY29yZWR1bXANCiAg
NC4gQnVnIDIwNjcgLSBbZHBkay0yNi4xMV12bTJ2bV92aXJ0aW9fcG1kL3ZtMnZtX3Zob3N0X3Vz
ZXJfdmlydGlvOTVfcG1kX3dpdGhfbWVyZ2VhYmxlX3BhdGhfd2l0aF9wYXlsb2FkX3ZhbGlkX2No
ZWNrOiBzdGFydCBkcGRrLXBkdW1wIGluIFZNIHdpdGggdmlydGlvLTAuOTUgcHJvdG9jb2wgZmFp
bGVkICAgIC0+IGhhcyBmaXggcGF0Y2ggYW5kIG1lcmdlZA0KICAgIGh0dHBzOi8vcGF0Y2h3b3Jr
LmRwZGsub3JnL3Byb2plY3QvZHBkay9wYXRjaC8yMDI2MTAyMjA4MjYxOC4yNzMwNDE3LTEtZGF2
aWQubWFyY2hhbmRAcmVkaGF0LmNvbS8NCg0KKiBCdWlsZCAmIENGTEFHIGNvbXBpbGU6IGNvdmVy
IHRoZSBidWlsZCB0ZXN0IHdpdGggbGF0ZXN0IEdDQy9DbGFuZyB2ZXJzaW9uIG9uIHRoZSBmb2xs
b3dpbmcgT1MoYWxsIHBhc3NlZCkNCiAgLSBVYnVudHUyNC4wNC41L1VidW50dTI2LjA0LjENCiAg
LSBSSEVMMTAvUkhFTDEyDQogIC0gRmVkb3JhNDQNCiAgLSBGcmVlQlNEMTUuMQ0KICAtIFNVU0Ux
Ng0KICAtIE9wZW5Bbm9saXM4LjEwDQogIC0gT3BlbkV1bGVyMjQuMDQtU1AzDQogIC0gQXp1cmVM
aW51eDMuMA0KDQoqIEZ1bmN0aW9uIHRlc3RzOiBBbGwgdGVzdCBkb25lIGFuZCBmb3VuZCA0IGlz
c3Vlcy4NCiAgLSBJQ0UtKEU4MTAsIEU4MjUsIEU4MzAsIEU4MzUsIEUyMTAwKSBQRi9WRjogdGVz
dCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2ljL1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNr
c3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFOL1ZYTEFOL1JTUy9Td2l0Y2gvUGFja2FnZSBNYW5h
Z2VtZW50L0Zsb3cgRGlyZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxl
eGlibGUgRGVzY3JpcHRvciwgZXRjLg0KICAtIGk0MEUtKFhYVjcxMCwgWDcyMikgUEYvVkY6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFtZS9jaGVj
a3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0gSVhHQkUt
KEU2MTAsIFg1NTApIFBGL1ZGOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgYmFzaWMvVFNPL0p1
bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZC9tYWNfZmlsdGVyL1ZMQU4vVlhMQU4vUlNTLCBldGMu
IA0KICAtIElHQy0oaTIyNikgUEY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVf
RkxPVy9UU08vSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExB
Ti9SU1MsIGV0Yy4NCiAgLSBJUHNlYzogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGlwc2VjL2lw
c2VjLWd3L2lwc2VjIGxpYnJhcnkgYmFzaWMgdGVzdCAtIFFBVCZTVy9GSUIgbGlicmFyeSwgZXRj
Lg0KICAtIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292
ZXJlZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3Zp
cnRpby1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA5LjAsIGV0Yy4NCiAgLSBD
cnlwdG9kZXY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRlc3Rpbmcv
Q29tcHJlc3NEZXYgSVNBLUwvUUFUL1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KICAtIE90
aGVyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERTQQ0K
DQoqIFBlcmZvcm1hbmNlIHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KICAtIFRob3Vn
aHB1dCBQZXJmb3JtYW5jZQ0KICAtIENyeXB0b2RldiBMYXRlbmN5DQogIC0gUEYvVkYgTklDIHNp
bmdsZSBjb3JlDQogIC0gRTgxMC9FODI1L0U4MzUvRTIxMDAgTklDIFBlcmZvcm1hbmNlDQoNClJl
Z2FyZHMsDQpYdSwgSGFpbGluDQo=
