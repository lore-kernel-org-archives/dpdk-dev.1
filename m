Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AEDC88E75
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65CBA40A87;
	Mon, 14 Sep 2026 16:15:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6B11D402F1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789395313; x=1820931313;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3ALQlgTF/Ju0zuBv59iRb+a5rwQmWqJ2hDaJWKbtKd4=;
 b=j2ZI0Q6/ad3M3D3BJ/fFgjEipruRi1KfVqJnT31fx+JmrfUmZGfw3NmD
 FHg50I2nIGugjhCthQgebwQxfU0X3a1v28HDp5Sb4pEPnNnZzAbzLqLCh
 8rZnHFZl0+/lO8TguroOcD3y1b2aTiEsH4akJG3Qp5PZlsqRzXYJOj4DN
 zFK1GkUg1n2zdW2eJio+I0qkO8uD/vOIT0XUGaK1x+lMxHtiOpxwLPo2J
 h+R+C5ZOPEkzfIqOH/t6Z0OEKF958W4G+yoBC7BIuqWITbaF0NW2OWzU8
 Aq5ued4IWct4LrMgkEVydTdS7CqzQoYlhmJZF57fyPxtEijv+ekzkdG8O g==;
X-CSE-ConnectionGUID: YZrMTp4FRcutgpa03Xw/bA==
X-CSE-MsgGUID: yvSg+E0GTH+aYxoECVqWDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="77307497"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="77307497"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:15:11 -0700
X-CSE-ConnectionGUID: MiNOtLeJSwGmtonZ7icsnA==
X-CSE-MsgGUID: KyDQZ8cLT/GOPhhJs4uFmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271227621"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 07:15:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:15:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:15:10 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/fUGPD0KZipmvKBBqR8lVXK57ZoPxnkNc3Mw1t9O19VaLCwlyfcrBZdBmyJ4WVTuKRgBFc+Bm2dkSnIMZahdR5TOpRmEPNsaz3Bj/N5Z65OHVgB1R7Bbqx7xYxg66C4+rqQKvW0rUHc76icdA/inxa/qAEChE1FHqkLiXu9fCugnCUlE6aTtAPj7rmWTcnjV0kpX01EL4iwoKwSbAfR2gdIJP4BanF8cbDGQQj+NvDCA3cZxUOSam2ChA/PyONHCTzyiFRov3gVA8HLsh48rG1koWijKadVRS4JqTx1CKYdFcMxcMeCkla6/WoedHKQIV9AnFfAK+Ti4x9BUCDmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ALQlgTF/Ju0zuBv59iRb+a5rwQmWqJ2hDaJWKbtKd4=;
 b=GwaBsFYPquun9oO6wduyxrf+nfilhpdczcHEWcHxqd9SKkHDWXE42tn9iSaSqiF4q1gg5OY793/+LkKFsRamUkShzbpG1mJJcPbyknYvkscEaf2LtAR9Mv/qYbxwFg5YEJb0JEtRaNzX/cvT83q35O3xdVMBTFNSJEWqNu7RVbCSQhN020tYKnA1gUroYCkXOc2ttMGpDWShNsL4evgMLkc6JBJJR/7hxuwaW+1W/+K+P0ZlWRTYgw7A3TbGPGLcm+ZlW8ifD0P+yotYaefVuuTuykK4TKMlX4MSbxfnWCUBAI51019mGJyhXah1Y5k2X9edLHEu3Ww4w34o3IgsuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by EA3PR11MB028977.namprd11.prod.outlook.com (2603:10b6:303:2eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:15:05 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:15:05 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: RE: [PATCH 08/13] net/ice: use common descriptor creation functions
Thread-Topic: [PATCH 08/13] net/ice: use common descriptor creation functions
Thread-Index: AQHdQQa8MPROsaoJF0yCJ3xXZ1Uf4bbOJNCw
Date: Mon, 14 Sep 2026 14:15:04 +0000
Message-ID: <IA4PR11MB927882EEB505228A110F5F298EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-9-bruce.richardson@intel.com>
In-Reply-To: <20260903170140.360477-9-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|EA3PR11MB028977:EE_
x-ms-office365-filtering-correlation-id: 919bc3c2-db4c-4435-e0b2-08df126a92f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|6133799003|4143699003|11063799006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: XgNhYai1W14GbYnUUne/QornBJPxwhIrAB39HrCUG9cMdhK00HmcTxM3EHYQ7u4XsPTVHkXnI8igsw1EF96e65hd2SREDntV5hBy7nZfOesvBLIrQal4qha5WxprYabogLL1idrkewsJw0YyNEkLrOdumhEd7543xVBoWjPC2axXjXQK10ZocWCdilHm8yRyOTgAxbSEiPUNkmJ6SPxXg9cW1vkQxau732Z144kwdS7fOBHFfHbcihyiGpyS+iCQwHZZ2ou6AoD9uNWhN/wlrCkT6b+DT+nQYSB2pLBmCuAD/e4YwgVOau2jX5A5kIRUVf3Ef+2wMsQGHvXgkr5WDO1/PhnQSBhQDYknbDUG4fNTMwFe8IyF2/Qyd/D3YwdjxaDgNcWs03efNfrNPdvmDRM+ia/fXtHuR2do6G/znYLRmvjQlxF63Zn6un+msiqzPOj+9IbHZxWW9GZiQbq7BwSahBScYp39Eaa7ubGu5tBO/1Z/AK8d9r+Yzj0fY6keDvGjy7Z2lmev5uorm6dn1e+AMMNw9Tp1O7dSKDZyhOI1bByXck/knlWeO2JidJGfoCmWtVKRJMgAzajJzEjchRBlfr+08TV0xSJlE9+m6pZmRkB+Oo4GnFf5NBN9ibYbwf3e6W5Mq2Up+jLk8Yq8CIsZG/e2CnE6+iRPYvTFWMupB36UEG5A5/8PZkr/GEPpcvznKA/zLcnSvcCRig4rMgSIVo2N8EOBMZOvLdMOMKI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZnd3RGd25XNnpNWnZRNG1tZUcyZ3hRcVBsQldKbjBCZVVPQlR0UnBET3RK?=
 =?utf-8?B?cWJtVlRiYXA0S1JvYUlRYkNiRmpaVkF5N0pLNEhLUFVPRklOMDAreVJ4dk5i?=
 =?utf-8?B?V0hlUmhpanJCV3lqWGcyZWpmL0ZOcmg1OS9GaW10bTJTUGFVRFhLNU0yU1Z1?=
 =?utf-8?B?d25JQWF3V2JKQnE4MHBwazNiVVJVRG51L1o2TktFMWJMOWM2ZVVOL3hEODZr?=
 =?utf-8?B?dndpS1o0SjhQOEptOE4xNEFiTDJ2cnlDV2pwQVdHcmJML2JuZEJ6V0U4ZG01?=
 =?utf-8?B?L1lxcWV5YlRKUUtreTJybXlqRDV2Nk9UZi9HenlpNnl3TUFpTW8wMnJwS0lZ?=
 =?utf-8?B?WkpyQ21Vc0RYWStKNlEwQno4Z3BBcDk1NGZtNXVCT0ZkVWNla0JXZFhKeEtU?=
 =?utf-8?B?eXA0WHkrQzU2Z09oc2Jtd05GYU8rdkJxeUVXcXBNbEoxUXc4VHcxV1UvZFZl?=
 =?utf-8?B?dWlQdU5XY3RycUNtdHByUDZ4WVRXS0pQRHhnSU4xamRROGE1M2poZ0Y5b3Mw?=
 =?utf-8?B?VTU5NExvOUh4Q0ZRZ3pQazZMUnd1dU52eUxrMXN5dVdncEpMaXM0RFMwNVJy?=
 =?utf-8?B?NDlrakEvL1o3WmRqR0E1VXM0SUdWRkJHUnl4MG80T3pOb1BVblVhSjRIRWVz?=
 =?utf-8?B?YkZ2ais2b3NFTnVKKzZRVWFPRlphYUhKSStzVFJkTHd5eHRLNFlibTF1V0FZ?=
 =?utf-8?B?YkpiWFFGaXFvbGg1bEk3SWh2cWExYnpaWUxGSklsUEIvQnhRZXFsS1RLUTdD?=
 =?utf-8?B?TnQ2NWhRUE1EbmZVeGJXMGZ0alluM1BpUTJ4aXBrRWl1dm1nRGtrR1RLam1m?=
 =?utf-8?B?dnlxd0ZuME1UTmpxcXBHYXl2ZUV0V09wcDZWR3ZVTDFYZjkrbFFwNUNOZ3k0?=
 =?utf-8?B?TnUxYjNMU0dvZFVqRjJZaC9FNXdXUFJaT1ZUZkxqK3pCcVhWb0t4SERBUFhq?=
 =?utf-8?B?SFBXVDhZTWtDMEJ2aEJMSGVyeW9xTmZ3NHlJQm4xZlgzZXhOZFF5K0hCSnJZ?=
 =?utf-8?B?UElnU3R5a0IvWDlXTDNzenloaklrQTVRa2xpd09XNGtTQlZYcG92Q20yWk9a?=
 =?utf-8?B?dlhlN2syM1UyNGdPOVIwMWF1MmlZVXJrR0RlVHlQN1VKU1g3T3lOUFVuR0dz?=
 =?utf-8?B?UGxNMXgrdVlFcllxb01wTlRUcEdMOHFGTjdHbVN1RFQ0ekdpclNhdGxQRmEv?=
 =?utf-8?B?OHlrSXBySCt6QzdrV3FWUHJlOUYzK3FZdEZZanRES3EwSSsyYWNvc1JWcHdJ?=
 =?utf-8?B?cytuSjl4OHJDWG1yczVNa1AxLzdyeVFlY012ZFFUdTljcUJyYkRkSUxIdStm?=
 =?utf-8?B?MC8yNHdlODlnRWxmS1BETE00MlVZVmhPa3laRGRNSEZQQXFnRitzWEhVckZa?=
 =?utf-8?B?SFNMeEtHNUF0Uy9xZlJXWi9JNzhZdnBNQk9LUHRkZzdaNGFGY0FEbUc0aGd4?=
 =?utf-8?B?SHJobkxkRUJEOGR6ZFhRQWUxZDVnY0JPeFpVY1F5MWtXWmRLRjQ4YlVGazNh?=
 =?utf-8?B?TGZxV2VrV3BpdXBmSU1mTStVY3A2Rno0NEJnbzB5SSs0SDNNbHptTnhpeE5v?=
 =?utf-8?B?dGE0cVZsaWhrdzhrRnY0QVFMYlp2TDBySDU4akp4NlhFUEpPMWxwcndML2lL?=
 =?utf-8?B?SkRsQUo4NlB0VThZZy92VElaVkNHS3FkbGExMS9FTEphWDA1MU9NWVFTOHBO?=
 =?utf-8?B?dERDSURCTVUyZmgzdWdWVDN1aUdGekdpdjFNVUJVR0pjaS9WTVRmUzE2MnZq?=
 =?utf-8?B?UHRBTXlEMWlTNk9aRlNqbG4vQWo5TVVXUG50c0NIejBvbGowN1VDajNTd201?=
 =?utf-8?B?aWt2dzJzNlBOL0NUdTVxcWpQeWxsN1A1alk5RzY1MkZlNVRVcXBVSU9PS2Fp?=
 =?utf-8?B?RFdZYlFPdWVFTWI4a1J4ZER5QWpVbWZNeXZGOEJWN2YxMy8va1hKMTJrZFJa?=
 =?utf-8?B?Tk9kWURwKzF2cndlMVpteGV6b0U0YnpRMy95SmVEN3dWK0U3NkhLdzlSZ2lT?=
 =?utf-8?B?d3oyQ1BaWlRqRVlIZ1E2WFlUVS9NTldGcm5jSDhPY2xPQmdFcWg1QWs0YUdG?=
 =?utf-8?B?QnAzOW1wQ1pQa25sb0VWS2RXNVdHb005dG9LNERkUXdxSk8wdnpqbUc1VVNm?=
 =?utf-8?B?TDR2N2kwUXNZdFZJV3Rad2FjTVd6aCs4ZXZJdmg2bGNnaytTVUJYSndCbHNR?=
 =?utf-8?B?bmRsNFpDREdVemx5YlEyZUNoV05GQVN3QXZiL25yREg3d25JM1ppclhFZGRU?=
 =?utf-8?B?bU1MRnF1Y0RFUk1KQ0Fsd2dwY0xBdUlLeGhkV1cwVXZxajFtalhqRDFwSjJS?=
 =?utf-8?B?TVVuQUJ5bEJYNGg1cE1sVDhubjc3SngvWmRNWjJ2VnJxRGYvUWtEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4gsI6TZMNdTTu5U11Q8+yDVtVkxH9dLKgwX6nzyTnz3ZTBVVGCYTpTxYPdABiqnwUDzFnbGguSX4ghPlRCRy+7qj+qgY5g9/kXPN4ImLrRmiSpbGIzvwTpCxbCShIR+G5zaJA3G/ZPggFJied5fffDO1y9DIfr+pbL7eJxogRiHVfUzhkifhevbmSDZ0+lzBPb+HVO/SsJ1eRiiiMN//jtnD/EUeE3MsxxXCebRXUKfs0fPlcFqXK3c6mNXm9piVQo65jzNJSjjZ2SyNn9l7qYjkQXDaPs4fUChSattXOa5EXzHftol38uCrtTtLCXNPsNtanbXr83Rd/3LV30TCZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919bc3c2-db4c-4435-e0b2-08df126a92f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 14:15:05.0245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjZuZNuX53DFJNYQQvlFRHQ3Yl4+ggXxtcF2joeYdVvu1gPFMFYM49EnwJMJl2RivEBpoGk4gQOkxp4SyYSCuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR11MB028977
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDgvMTNdIG5ldC9pY2U6IHVzZSBjb21tb24gZGVzY3JpcHRvciBj
cmVhdGlvbiBmdW5jdGlvbnMNCj4gDQo+IFVwZGF0ZSBpY2UgZHJpdmVyIHRvIHVzZSB0aGUgZGVz
Y3JpcHRvciBjcmVhdGlvbiBmdW5jdGlvbnMgZnJvbSBjb21tb24NCj4gcmF0aGVyIHRoYW4gaGF2
aW5nIGl0IG1haW50YWluIGl0cyBvd24gY29waWVzIG9mIHRoZW0uDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX3J4dHhfdmVjX2F2eDIuYyAgIHwgNzMgKyst
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX3J4dHhfdmVj
X2F2eDUxMi5jIHwgNjQgKystLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL25ldC9pbnRlbC9p
Y2UvaWNlX3J4dHhfdmVjX2NvbW1vbi5oIHwgNTkgLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDMgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTg0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2Vfcnh0eF92ZWNfYXZ4Mi5jDQo+IGIv
ZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9yeHR4X3ZlY19hdngyLmMNCj4gaW5kZXggYjcyZjY5
YTQ3Yi4uNjg0MDE1NjBjZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvaW50ZWwvaWNlL2lj
ZV9yeHR4X3ZlY19hdngyLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvaW50ZWwvaWNlL2ljZV9yeHR4
X3ZlY19hdngyLmMNCj4gQEAgLTUsNiArNSw3IEBADQo+ICAjaW5jbHVkZSAiaWNlX3J4dHhfdmVj
X2NvbW1vbi5oIg0KPiANCj4gICNpbmNsdWRlICIuLi9jb21tb24vcnhfdmVjX3g4Ni5oIg0KPiAr
I2luY2x1ZGUgIi4uL2NvbW1vbi90eF92ZWNfeDg2LmgiDQo+IA0KPiAgI2luY2x1ZGUgPHJ0ZV92
ZWN0Lmg+DQo+IA0KPiBAQCAtNzczLDcwICs3NzQsNiBAQCBpY2VfcmVjdl9zY2F0dGVyZWRfcGt0
c192ZWNfYXZ4Ml9vZmZsb2FkKHZvaWQNCj4gKnJ4X3F1ZXVlLA0KPiAgCQkJCQkJICAgICAgIHRy
dWUpOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBfX3J0ZV9hbHdheXNfaW5saW5lIHZvaWQNCj4gLWlj
ZV92dHgxKHZvbGF0aWxlIHN0cnVjdCBjaV90eF9kZXNjICp0eGRwLA0KPiAtCSBzdHJ1Y3QgcnRl
X21idWYgKnBrdCwgdWludDY0X3QgZmxhZ3MsIGJvb2wgb2ZmbG9hZCkNCj4gLXsNCj4gLQl1aW50
NjRfdCBoaWdoX3F3ID0gKENJX1RYX0RFU0NfRFRZUEVfREFUQSB8DQo+IC0JCSAoKHVpbnQ2NF90
KWZsYWdzIDw8IENJX1RYRF9RVzFfQ01EX1MpIHwNCj4gLQkJICgodWludDY0X3QpcGt0LT5kYXRh
X2xlbiA8PCBDSV9UWERfUVcxX1RYX0JVRl9TWl9TKSk7DQo+IC0JaWYgKG9mZmxvYWQpDQo+IC0J
CWljZV90eGRfZW5hYmxlX29mZmxvYWQocGt0LCAmaGlnaF9xdyk7DQo+IC0NCj4gLQlfX20xMjhp
IGRlc2NyaXB0b3IgPSBfbW1fc2V0X2VwaTY0eChoaWdoX3F3LA0KPiBydGVfcGt0bWJ1Zl9pb3Zh
KHBrdCkpOw0KDQpBSSBjYXVnaHQgdGhpcyBmb3IgbWUgb24gcmV2aWV3LCBhbmQgSSB3YXMgYWJs
ZSB0byByZXByb2R1Y2UgaXQ6DQpXaGVuIHlvdSBidWlsZCB3aXRoIC1EZW5hYmxlX2lvdmFfYXNf
cGE9ZmFsc2UgdGhlIGljZSBkcml2ZXIgYnVpbGQgd2lsbCBmYWlsLg0KInJlcXVpcmVfaW92YV9p
bl9tYnVmID0gZmFsc2UiIGlzIHNldCBpbiB0aGUgaWNlIG1lc29uLmJ1aWxkIGZpbGUuIFNvIGVp
dGhlcg0KdGhhdCBuZWVkcyB0byBiZSBmbGlwcGVkIHRvIHRydWUsIG9yIGljZSBuZWVkcyB0byBr
ZWVwIHVzaW5nIHJ0ZV9wa3RtYnVmX2lvdmEuDQoNCj4gLQlfbW1fc3RvcmVfc2kxMjgoUlRFX0NB
U1RfUFRSKF9fbTEyOGkgKiwgdHhkcCksIGRlc2NyaXB0b3IpOw0KPiAtfQ0KPiAtDQo+IC1zdGF0
aWMgX19ydGVfYWx3YXlzX2lubGluZSB2b2lkDQo+IC1pY2VfdnR4KHZvbGF0aWxlIHN0cnVjdCBj
aV90eF9kZXNjICp0eGRwLA0KPiAtCXN0cnVjdCBydGVfbWJ1ZiAqKnBrdCwgdWludDE2X3QgbmJf
cGt0cywgIHVpbnQ2NF90IGZsYWdzLCBib29sIG9mZmxvYWQpDQo+IC17DQoNCg==
