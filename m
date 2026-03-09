Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF581EFCD93
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 11:17:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C3B40612;
	Mon,  9 Mar 2026 12:17:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 3A52740261;
 Mon,  9 Mar 2026 12:17:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773055056; x=1804591056;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+mAOHfUaOCdTpR6VduCx1qpYYgXWhmz8wbYas+O2xOk=;
 b=U+v5KwEzFSMEfAJuwCZWadeSH3OOzcScz1/u3MWO4AjDA45k0/3TEvsd
 pajAfLulqgbfNauLLp++ya7Z83Qdd5ntlemYMucp+AUOI4grxhKtqxFJT
 rwkPy6djRkOUwdjnXvfiu03OVNSTx487fFdd6fY6qtPXmMKyohd3V6p7b
 BRwPhkB36IER1Z22sgL5lt4df9gpbTx+6QLbJKVq4sw6PURGfThqOwuP5
 PEoF+j0K0m+jQUf2abRH3cT0kHKIk3ytUdiWMJH0jE/GZhACQS3p1ZcJj
 BWK9YyDI9hU7MZqbZZgQ6yH51wrrom9Ms36IfMnUsE4xzX14YfL/MzWXi g==;
X-CSE-ConnectionGUID: SMSUmgs6R5S4SPOAKj4eYw==
X-CSE-MsgGUID: PZRVPtgST6yl+5h5qd2o7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="61643425"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="61643425"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 04:17:34 -0700
X-CSE-ConnectionGUID: C0C727oeS4aS7+c9w8pylQ==
X-CSE-MsgGUID: YfmH7nT9TNq5GbulBeKzzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="224646594"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 04:17:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 04:17:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 04:17:34 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.53)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 04:17:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcgGSnxg/eDi8jTvKEygFX/dCwUNIN+IuDCnYvrUX3zH5WGh7st/seq9E4smuxHSfdncD+4dUuwdNS97b17dIR02KhVTXv0lHHibaKn42s1m2im9TnnZS8+u1WA8FVpWiWUEGNFGiM8KjeTyYHK/CBBtpP4B9C6qKJtkUJHGV8kEgqMKaQw4Qmjom4iX6TNPYSwzc9hHg0HJgX1fOpUMNE5by9WjBEas7QOmIt770nZ7MufrJe9UblOc1mlMZbaQP7yvsJ3IZyiEsZrVbotvd3inp8Hn9E6ZIqEYgmlR/1I8TdNDQZR/Bbvt0J74QQz4T5zolm3K3efbnXv1ozXiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mAOHfUaOCdTpR6VduCx1qpYYgXWhmz8wbYas+O2xOk=;
 b=eZkeMpTO/le1mUHP2v9yKD96X/IL3tb7p2b/Aaqnp6/XrA4Jx/6T52Hm4Z+DwcUnHrAmEQ6srweJr42JsMc0t1VpwNglO/vDKDpBTADrker5we7pGTV4yeb9JMivrfIs/ErR/AGuElvPyjDZneVyLOeXCt33eqa4TfcqpgivDHRZfec0AgME0b9DJELri4ne8fOmtdoaCYHq3n7dXSVioybo56jhZWdRHEi8bDefQvAM37Uyl/J52KiseOzMt41RFROu9r7rl6NZgOf91aQMyWy32e71jwQCCmNRlG6LQ0VXJIn9CMQK2xM7mOrAkA9cObLKnT2m0hsAHceMStLkjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by SA0PR11MB4575.namprd11.prod.outlook.com (2603:10b6:806:9b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 11:17:32 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 11:17:32 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "alex.chapman@arm.com"
 <alex.chapman@arm.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/ice: fix rss simple_xor hash function
Thread-Topic: [PATCH] net/ice: fix rss simple_xor hash function
Thread-Index: AQHcr20qcYFABQ8yxUqOS6BukBTdNrWl/XuAgAAN9fA=
Date: Mon, 9 Mar 2026 11:17:32 +0000
Message-ID: <CY5PR11MB61167F0FA868B64B355F1670E479A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
 <eb020e6c-8298-4041-9b16-fa12948dcf62@intel.com>
In-Reply-To: <eb020e6c-8298-4041-9b16-fa12948dcf62@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|SA0PR11MB4575:EE_
x-ms-office365-filtering-correlation-id: 6ddc5236-97a9-4787-204a-08de7dcd7529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|7053199007|38070700021; 
x-microsoft-antispam-message-info: 4ZY32nKz6reRJinWcvMmou5zmdieZFL59U6B2MItxfBYc/KVMgLFAkoj9OsHRUJGj0M2osBYGPfnnN9eiSuhy2J1c7ugcGbIOVtNUl1WbpLC3Ki53itadoTbwJ8ObTxbkQkYPQMBBaTRo2MUpKqBa+hfb0wIIMOMIVYNO4MVcWEHhhS7npJHfE20dQZJPGgl2xp9L43viXBzVWTdDOsb7JIowilBrC5gWb9L/7dRzCzl1pP3tZz2g4mRRjwOGqOhXRM1SAO8qw7zLK0W8aRhPcomYO3ANsfSSZi652WqUis9xtamJCxId7u6r8/CKYrYCE5KpSusohTSZ64WIHr3Hy35ao9CwQSUrp7Z5+yfRQS31gxjYST4pu70P+Xl4tO2l8+tOy0imD0V8by/eEYtzJtoVEkwRtrduRDNoajaHOquKXF4/NPzgeGz5zr9y4sWlWRT5B4c8oBZTAL6L+G3cMU/adaU8jeCYZtTPCb5SOqZaSab5pibQo9DKEOA4Tia5WFZLomi/8usP+a39KsL4qJCt7+Z8hJIAF/dYxUhAYUhJyQOjkrHEkLI+Ip3GGKnfBLxjTvcgIrYF3MYcXxdFlXFH3e/VBN9pgNYoR9CfjGU6LRIeu4ZY/GOFojx36e4/+KYzyt2gFRoo94JXYLiOto5i+QN25hVlWxxT3DV+e3tJo50pAZkEDEgpm1O8+PKdu/xuZ/yXNLp3Qsp0tsGwbZCnIyjj3PXtAuM6jFW9kavvv55+EjOKDHribaXmVcVzPkGOUn7mii3rN4JcHWQc9TSGAwQenKRFkBPJvvIB7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW1KNVpIb0ZWdElzeXJLaXE2UjlGYmVRZE1wVFlNN0Y0cFR0R3piNDNNd0o5?=
 =?utf-8?B?M0l2dHFhOHcxMVNhVVZGNGx1UnhzTTc1NUNXSGRkRldUWnJVM2hwOTdadFdn?=
 =?utf-8?B?eFk1V09NOTQ4VUl0RkZXWFpRVEI3WXBkTjNBNXo2SHBYaEtiSUFISXZZbU9h?=
 =?utf-8?B?dE1JM2hueDhLWE5XSU9zZEFHM2xTVHIzM1ZabFNHR0ticzM1REI4K2VOYkJV?=
 =?utf-8?B?Zmg5ME83alRKcXFleTJibXdGTFF0ejJSM0xWZWhodTFFTHhyWmRQMGk0eVk0?=
 =?utf-8?B?L0dnQnVOWWZEMjU3VVI0T1NQUHA1T1VRQzhNdEY1OHlZbm1pRGRyM2hZaVEz?=
 =?utf-8?B?V1dQemRHZDRpSy80RkVYY29CM2lhR1NlblVDUEdRT0praW00dzUzMjh3YzNW?=
 =?utf-8?B?YzVGUWQxWWpVdjhjSVlnd2VIalRTZVYvZFh6RWgrWnV5S1dvZE1USWwwcXlI?=
 =?utf-8?B?UTVFdHcyN1pwUTNSdUZoeTF4N1J4elprYkNJT3R6Ynk2S20vNVcrMkd3cjRM?=
 =?utf-8?B?M2ZPeGplMEVlWUZEQ1UzMi83TytGSkM0MUJaM3ptWXViVnB2ZFgyKys3M1ZN?=
 =?utf-8?B?Z3dQYjMvUjNtUHhHVUVFQ2lMVjJjbk9Wb3VSZ05CdDR1Nm90SC9wSVZXZnFN?=
 =?utf-8?B?T1ZGNjFTb1MrekJyNUVJL2lJZGFiTjl6L2dLYTJ4Z2xsclJWYVhBTkoxS2JF?=
 =?utf-8?B?eXp1MXp3TWllemg4Nk50eDFsbHIxUHNzQkNWRzNSQ3pNR2QyVmhkQ2Z3bWlX?=
 =?utf-8?B?cXV3ZzBjS2dFaFQ3Uk1nMnpDalNrOVBxeUt4TEQ2aUdSd1o0dzdnY1kxNmtL?=
 =?utf-8?B?NWNOSko2dGppbzNON29nSk1seEpkWks1UVBWOXg4NjZCMXNIUExuL0Q3czhJ?=
 =?utf-8?B?MXk0M251eFlYVUs0ZDFEWEIyYXYrSnVBUmhyOVo2VXg2NmNIaVZnTjJiWml3?=
 =?utf-8?B?MEVJZW85bWt0cnR6eWk3NlJUcmp4ZEh2cVFuMTNIaVdlYzhGeEJTU3ZxZGpy?=
 =?utf-8?B?QnJtWUx2Mm54TlhDbi9RaVZpZFFpbjhLYW80bHRHWEpXNFlUclFXelRnR0dZ?=
 =?utf-8?B?ZEpIdXhZaTc2cC9oQ0NlYUFpVWxnSnhkSUZ5NXMwc1NBNDNLK1ptR2I1MFhS?=
 =?utf-8?B?dXV1eThNWU5tRm5rRGl5aUtxNUpPM243Mi9Od3B5endqdHpYNkczdlZ3cG5W?=
 =?utf-8?B?Z0N2UXIyRS9YRFlET1NmSUY1cDcyQ2RCc2t5MzJnMzk2MzZ1NlF0dzJQN1gv?=
 =?utf-8?B?WlZoUll4ZFYwSHcrQStmNDBoN0plY21RNmxYRTlqMUc5bFZEcW1Eb3A5N1NK?=
 =?utf-8?B?SitOREhRRFFzb2ZRelVQOGlLT1RxU0I2RDdvdFhKamRES2JMNm5rQTZham4y?=
 =?utf-8?B?RHZqNXhyNEZEVE9tWFNibFg4TTBlWS9CZDVUbjh0emJDSjFrSlpaSllpQ3lY?=
 =?utf-8?B?MUZZQlZuTi9MaDdXL0VQQWFoZUZUVHpzNStHY0JlWCtTZzJWbDEvcWpGaFJ3?=
 =?utf-8?B?VUNJK3QxRE84MWZWQTIxY3RzV2lLeGFOejc2M0s2Qk9FMXBGWHR2LzNCLzVW?=
 =?utf-8?B?QWRyOU9FWXdNdE5Xc1pEMWgyWW1PWElDTDljVnpISlY2N2h3enVab3Y2cmtv?=
 =?utf-8?B?Y3BNL1NjTXNtQnZJTVhMZVRzRTQwWVF6ZjZrNnpwVmV0T3lRVGxROWd4TENE?=
 =?utf-8?B?Vk52bHh1TzFZVnNQL3RXWnRWOEk2REZCVTZDbmFLYTloendpbjMwZSs3SnUy?=
 =?utf-8?B?dURIS0Z1VFJPakZrUjhwWDM2Y2xmd0VkZGk1L0N2a2NsdHhNeElRRXR5SzFm?=
 =?utf-8?B?M3l6UGEvUHFPZkN0MjR2OE1hYUY1S0Vicyt6N255azl2TnVlYjNMd2hyWlY4?=
 =?utf-8?B?a0I3T2hmMzFnSFB5QnhKWXdWU2wrbEhSRlFycDNJM0xSdXRhY0oxV3poVVJZ?=
 =?utf-8?B?VTdyTE52NExUTGR2dmpWUmx3RTBzRmFLT0J2V3lBekVLRUxGVCtkbVdiVnUw?=
 =?utf-8?B?ajl2cUcxWnNQLzRnSU9hTFZQVkZHUWF3Y0NhV09pUit2TEhVc01wbnA3Z1RN?=
 =?utf-8?B?dmQ0MmNXUk1nQksrUzZRMVg1N0FWeVdZbG9FVGZTUENMZEdGaitQUGhzMHAw?=
 =?utf-8?B?dnozcy80eHZkMFc4VVZiRzhsM2NmSndNamovUEt6VGxLNFRITE5zUnBEZjlF?=
 =?utf-8?B?VGdNSVFOSndtbThabHdmaENEL0cyamFJMGpUSUNmSENETGlkNGZNaVlMc0xv?=
 =?utf-8?B?Q1VMTzFkUlZ4anlKSTlnVE83TEhiVHYzaU1scE9IVWZRY3B3emJxVzVGajRz?=
 =?utf-8?B?RHlMd1JmYnZFaUdjeVdoNlowWUdFNURJK1R5K2l3bWtLS0RsakJBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NNeO7ikAKnaYW/JylHNz+pAz1TffQB8EdzslU4s+BwNlhOqn8Ta4redRi7nNr5SAco9wK8KEQZKYSqe5sSY1HAEi+uCHVwRS5Sk/Ag2SwoSmqt1whxveyAq4UbvJCSTVE706CwjdqyzH3s73eRWI2qKUEwJ5s5d8F6EdA5HJZ8BMOPz/4euCEvdihqhFqvCOdsAHA408iujsMqQP0ZmDvprmq/or9r8rcKAF/dUbvrxD46MucRw3+d903i3KpLT7ApxSflpsI8qg3kSeBk2XiteZe3kXVJm7BzfRKEuebjJeiVdePSbWUozphrZ741FiptMBtSGZccP6zT6YDIkDQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddc5236-97a9-4787-204a-08de7dcd7529
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 11:17:32.0270 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zh4cSsEH199pkTIRtmrq/lnQdrPLIadeDAMaVv9nGXEiU3mnwNIWufhePLH++QWnsiYa1d1beI+pfWUibidw/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4575
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJ1cmFrb3YsIEFuYXRvbHkg
PGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb20+DQo+IFNlbnQ6IDA5IE1hcmNoIDIwMjYgMTU6NDkN
Cj4gVG86IE1hbmRhbCwgQW51cmFnIDxhbnVyYWcubWFuZGFsQGludGVsLmNvbT47IGRldkBkcGRr
Lm9yZw0KPiBDYzogUmljaGFyZHNvbiwgQnJ1Y2UgPGJydWNlLnJpY2hhcmRzb25AaW50ZWwuY29t
PjsNCj4gYWxleC5jaGFwbWFuQGFybS5jb207IHN0YWJsZUBkcGRrLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBuZXQvaWNlOiBmaXggcnNzIHNpbXBsZV94b3IgaGFzaCBmdW5jdGlvbg0KPiAN
Cj4gT24gMy85LzIwMjYgMzozMiBBTSwgQW51cmFnIE1hbmRhbCB3cm90ZToNCj4gPiBSU1MgU2lt
cGxlIFhPUiBoYXNoIGZ1bmN0aW9uIGlzIHN1cHBvcnRlZCBieSB0aGUgTklDIGFzIHBlciBkYXRh
c2hlZXQNCj4gPiAmIGFsc28gaW4gSUNFIExpbnV4IEV0aGVybmV0IGtlcm5lbCBkcml2ZXIgYnV0
IHRoZSBzYW1lIGlzIG5vdCBlbmFibGVkDQo+ID4gaW4gSUNFIFBNRCBldmVuIHRob3VnaCBjb2Rl
IHN1cHBvcnQgaXMgYWxyZWFkeSBwcmVzZW50Lg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0
aGUgaXNzdWUgYnkgcmVtb3ZpbmcgdGhlIHNpbXBsZV94b3IgY2hlY2sgJiBhZGRpbmcNCj4gPiBw
cm9wZXIgZXJyb3IgbG9nIGZvciBlbXB0eSBhcmd1bWVudC4NCj4gPg0KPiA+IEJ1Z3ppbGxhIElE
OiAxNTE4DQo+ID4gRml4ZXM6IDBiOTUyNzE0ZTljMSAoIm5ldC9pY2U6IHJlZmFjdG9yIFBGIGhh
c2ggZmxvdyIpDQo+ID4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQW51cmFnIE1hbmRhbCA8YW51cmFnLm1hbmRhbEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+IA0K
PiBIaSwNCj4gDQo+ID4gICBkcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX2hhc2guYyB8IDkgKysr
Ky0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2ludGVsL2ljZS9pY2VfaGFz
aC5jDQo+ID4gYi9kcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX2hhc2guYw0KPiA+IGluZGV4IDc3
ODI5ZTYwN2IuLmQ1N2I1ZWUwZTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvaW50ZWwv
aWNlL2ljZV9oYXNoLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9pbnRlbC9pY2UvaWNlX2hhc2gu
Yw0KPiA+IEBAIC0xMTA5LDEyICsxMTA5LDExIEBAIGljZV9oYXNoX3BhcnNlX2FjdGlvbihzdHJ1
Y3QNCj4gaWNlX3BhdHRlcm5fbWF0Y2hfaXRlbSAqcGF0dGVybl9tYXRjaF9pdGVtLA0KPiA+ICAg
CQkJcnNzX3R5cGUgPSByc3MtPnR5cGVzOw0KPiA+DQo+ID4gICAJCQkvKiBDaGVjayBoYXNoIGZ1
bmN0aW9uIGFuZCBzYXZlIGl0IHRvIHJzc19tZXRhLiAqLw0KPiA+IC0JCQlpZiAocGF0dGVybl9t
YXRjaF9pdGVtLT5wYXR0ZXJuX2xpc3QgIT0NCj4gPiAtCQkJICAgIHBhdHRlcm5fZW1wdHkgJiYg
cnNzLT5mdW5jID09DQo+ID4gLQkJCSAgICBSVEVfRVRIX0hBU0hfRlVOQ1RJT05fU0lNUExFX1hP
Uikgew0KPiA+IC0JCQkJcmV0dXJuIHJ0ZV9mbG93X2Vycm9yX3NldChlcnJvciwgRU5PVFNVUCwN
Cj4gPiArCQkJaWYgKHBhdHRlcm5fbWF0Y2hfaXRlbS0+cGF0dGVybl9saXN0ID09DQo+ID4gKwkJ
CSAgICBwYXR0ZXJuX2VtcHR5KSB7DQo+ID4gKwkJCQlyZXR1cm4gcnRlX2Zsb3dfZXJyb3Jfc2V0
KGVycm9yLCBFSU5WQUwsDQo+ID4gICAJCQkJCVJURV9GTE9XX0VSUk9SX1RZUEVfQUNUSU9OLA0K
PiBhY3Rpb24sDQo+ID4gLQkJCQkJIk5vdCBzdXBwb3J0ZWQgZmxvdyIpOw0KPiA+ICsJCQkJCSJJ
bnZhbGlkIGVtcHR5IGFyZ3VtZW50Iik7DQo+IA0KPiBJIHRoaW5rIHRoaXMgY2hhbmdlcyBleGlz
dGluZyBzZW1hbnRpY3MgYSBsaXR0bGUgdG9vIGZhci4NCj4gDQo+IFRoZSBvcmlnaW5hbCBjb2Rl
IGRpc2FsbG93ZWQgc2ltcGxlIFhPUiBvbmx5IGZvciBjYXNlcyB3aGVyZSBwYXR0ZXJuIHdhc24n
dA0KPiBlbXB0eSAoaWYgaXQgd2FzLCB3ZSBhbGxvd2VkIGl0IC0gaS5lLiBpZiBpdCB3YXMgYSBn
bG9iYWwgUlNTIGNvbmZpZ3VyYXRpb24pLiBUaGUgZml4DQo+IGRpc2FsbG93cyBlbXB0eSBwYXR0
ZXJucyBhbHRvZ2V0aGVyLCB3aGVyZWFzIHdoYXQgaXQgc2hvdWxkJ3ZlIGRvbmUgaW5zdGVhZA0K
PiBpcyByZW1vdmUgdGhpcyBjaGVjaywgYW5kIGluc3RlYWQgbW9kaWZ5IHRoZSBzZWNvbmQgY2hl
Y2sgdG8gbG9vayBmb3IgZW1wdHkNCj4gcGF0dGVybnMgKGJlY2F1c2Ugb3RoZXJ3aXNlIHdlIHdv
dWxkIGdvIHRocm91Z2ggZnVydGhlciBjaGVja3MgZG93biB0aGUNCj4gbGluZSBmb3Igbm9uLWVt
cHR5IHBhdHRlcm5zKS4NCj4gDQo+ID4gICAJCQl9IGVsc2UgaWYgKHJzcy0+ZnVuYyA9PQ0KPiA+
ICAgCQkJCSAgIFJURV9FVEhfSEFTSF9GVU5DVElPTl9TSU1QTEVfWE9SKXsNCj4gPiAgIAkJCQly
c3NfbWV0YS0+aGFzaF9mdW5jdGlvbiA9DQo+IA0KPiANCj4gLS0NCj4gVGhhbmtzLA0KPiBBbmF0
b2x5DQoNCkhpIEFuYXRvbHksDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50cy4NCkkgdW5k
ZXJzdGFuZCB0aGUgY3VycmVudCBjaGFuZ2UgZGlzYWxsb3dzIGFsbCBlbXB0eSBwYXR0ZXJucyBh
bHRvZ2V0aGVyIGFuZCB0aGF0IHNob3VsZCBiZSByZWN0aWZpZWQuDQpNeSBkb3VidCAgaXMgc2hv
dWxkIGJlIGFsbG93IGJvdGggZW1wdHkgYW5kIG5vbiBlbXB0eSBwYXR0ZXJucyB0byBhcHBseSBm
b3Igc2ltcGxlX3hvciBsaWtlIHN5bW1ldHJpYyBUb2VwbGl0eiA/IA0KDQpUaGFua3MsDQpBbnVy
YWcgTQ0KDQo=
