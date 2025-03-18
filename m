Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82415C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 09:44:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36670402C4;
	Tue, 18 Mar 2025 10:44:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AABE240291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 10:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742291096; x=1773827096;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5QsDXw8ZsU+6dXCMURS0u+Tj5Kwy2o4kTGuEw2cNblk=;
 b=DHV6yQq9fRPETprf5GfszxaLkHctxQ5g2fpq9PUDw9Fr3l8cejqR4oNb
 8bOW5S7IIv45RxpZi0TXXUhIUWZbheVMNEvSLmYeDnYFGn/PhBVuZgvgP
 smuOzF+NcqnffH2WeQlPZAm7AZQO65mMRjk7oiHLWJFprYqym411HnFK2
 CWAaldXhJ0u4QPHQytK7H7DSo13V0CjAJ5IDaWJ9fBNm/wVwCSVz8LLiO
 GNDTLCAar4qAjqM3k1yjKrjl+iNp+Xi/rEh/ljITIuCGORIRuB1CGL+tG
 PqjTDJ2UG12Z+HzDxXqvsMvc/i71xziyONruyS6SfgJERH7MBILciuYgZ w==;
X-CSE-ConnectionGUID: rcoI3NiSQVWvHPKxm2xzmA==
X-CSE-MsgGUID: HnG1eJNrR/uvmzkIYIqQLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43556023"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="43556023"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 02:44:54 -0700
X-CSE-ConnectionGUID: OhVKWdoMQii7n/vRxcti7w==
X-CSE-MsgGUID: X9DJsdcYR86u6PxGDwK5lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="122706396"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 02:44:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 02:44:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 02:44:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 02:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdvpY40dE96tzj/lTEw6km+2z28SMpaYwUZaYYckowHDYYbb2CH20dqxVcg/ia7bzMMvItvyEUucjFlzCYATDlzTas78FuQzSM6okHFei4HlTm3S+o4BfgpjL12Uamkfab6LIzUSTvC5SMnfK/hmiGm6r+dVtTB4BdY1RqtzR6FwEiHuklTa1/G6V/s1pU9BLsIxfSsIH0hvVSnAdW1NzVy32JKv71yCm9KcyPhXkQ/M0jptDqIHDrvoejhcLSiB41lyaAxtYbC2/4XEGoLcoqEk5HVD0PIPPQdcoNiCCfNEBPdmzuf7bTmZXvjdSL/lny+hPRZhpIhJsi0RBDK5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QsDXw8ZsU+6dXCMURS0u+Tj5Kwy2o4kTGuEw2cNblk=;
 b=wafQFnrjVMLQtCv+MDTHENZyogh50twcCiycjishBhW4Xg+8OSIXoUeNnNRCh7uscskSssDm/FQpa/NRWJCEii9tI1O8ns9V+/H0GvMjwD0zzyCNJMUuLqMZ80BlmN0aSrMcSnEwNZ3MUCTRXQlUnG9g5dB4lMTOhoVIGDeZK/zlwZf3cg/QlBQAEZF3TaK0MtAjqzYXD+zFjYWwnuItv/RlZxIy/xZ0OJXRZ0aj/tUZjjzZALFBGLG4HxnguAFf5RmWr8fuSUoFxRoY48HyGeuBcMEfrJB1aVKkB7x891A9mwl45hXbz1PpAI+lGLiYzDyVRZTM8dFH28ZnIC6ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5912.namprd11.prod.outlook.com (2603:10b6:303:18a::20)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:44:51 +0000
Received: from MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21]) by MW4PR11MB5912.namprd11.prod.outlook.com
 ([fe80::7a4b:e159:c4b0:7c21%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:44:51 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Kovacevic, Marko" <marko.kovacevic@intel.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, "Richardson, Bruce" <bruce.richardson@intel.com>,
 Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: release candidate 25.03-rc2
Thread-Topic: release candidate 25.03-rc2
Thread-Index: AQHbjr8/1ArlPegqbUW32c8XxcuODLN4tJkw
Date: Tue, 18 Mar 2025 09:44:51 +0000
Message-ID: <MW4PR11MB5912C7B4E1F37937781195459FDE2@MW4PR11MB5912.namprd11.prod.outlook.com>
References: <4098448.yKrmzQ4Hd0@thomas>
In-Reply-To: <4098448.yKrmzQ4Hd0@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5912:EE_|LV8PR11MB8461:EE_
x-ms-office365-filtering-correlation-id: e2997d56-9650-4424-a364-08dd66018791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eDQwbGFCWEp3OTlZTTlFb3QwenczNkxGazN5MlJzeVFWR1FIWkhBU3lrWTRu?=
 =?utf-8?B?a29yTDZQdGE2dW1JUlhPUU4yR01qd1loRUJhSEFCY2VwNFp3alFoZDBuSDN4?=
 =?utf-8?B?UmRvaEc3QzcwNG9kUEdnRW5MUFVndmJQejRyUzFjZW84RTM4NHZTeDNPbDRs?=
 =?utf-8?B?NmxYWDc0N3czVUZYVXNTbEtuTFVlNWFMWkx6M2xFeEtEazcvZ3dmOXZ0T0JW?=
 =?utf-8?B?Sjl0SUEyV0tBVDk1SzJSYVIrMGl2aytTTFBBZTJ4Z1pFYjZjY2xkeC9hZG1L?=
 =?utf-8?B?WCtsVEc1Nnk3ZXduanRFSi9yQUg4SHRmamYyOFVoaVdBWFpkemR6UkZYUlFO?=
 =?utf-8?B?YUFFY0lSYTRIeUdMK2hzY2MvbU1QelUySFo5R1VpWkdmcWg3SmNsUHA5ZnVX?=
 =?utf-8?B?MUovK2ZkWVdvM05pNzRiUGM4UFlTNEl6ZmF2TUpYdDVGdHZTOXI0TW5KODJL?=
 =?utf-8?B?REtYZ3lrdExXZ1hDeGVGWGszcTlHcXlaa2pUVkY1bnZWbHpFUlhkaUlFNjNi?=
 =?utf-8?B?a3pZMThZRHpwZ3ovRVNZUU1zQkN1eFlsV0t5OGJqakVXbEh4dHA5ZURBbCtj?=
 =?utf-8?B?cUtDcDRVbmRVRTJaRDVwdUlQenpMRUtVN0NhZ2o3bDRScHQ4S0MySGVyOHFj?=
 =?utf-8?B?OEl1bTRKTHczTVVHS2NzOWovWWwrbE1ZN0hldzBOSEVTbG5nWWVvTEdDZVlL?=
 =?utf-8?B?NW9MMG9Jd0lEdkFWaGIxSnFST1NocDZNSTdZNzMrdTdtdFdFaUY1YXB2SE5F?=
 =?utf-8?B?amp3WU04QUtoUkVhSE1id3VONjVjeHlhSzZXbG0vWXpjYVBZWUpONnBHTVlD?=
 =?utf-8?B?NWtvYWMwSDFET0Z3VDdSRXByK0lqSE1RUWNZSlNiN01WdzcraERGSGQ3akJm?=
 =?utf-8?B?WHJ1L2cvby9VbjMvSlovUWZ6M1g1TlZLYXo3RlczQmdUNkc5OTNUQnF0NE51?=
 =?utf-8?B?U3YxOE8vc3NzS0k2RWVzenNudWlpd1RBUmJ6M2dwTEFoRUg5UmQ0bTUrQ00y?=
 =?utf-8?B?MHU0aHpSTjNXSlhuRGFMUEdWdzd5VU5lOWRoTFV3dTRZWUJwY1BZNVMzbWE3?=
 =?utf-8?B?MVM1TlpQMXRRUldSbVB6SWVuc3hPRG9Qamp2dy81K29GQkdUVTlRYk9HaFN2?=
 =?utf-8?B?NHc4WkFDYk9PTzdoeSt3NmpHRUI4UXQvT3JHbXdFOXpFSEVKZThGRWpjbnJX?=
 =?utf-8?B?SjJkRGZJNFMrZmQ4UnMrMHY2dVZaV0dyL05DVE5yUEZUT25qb1V5OFN4V1Vu?=
 =?utf-8?B?R0tRYmp0ZE5KN0UvcVNrU2JrdFlLZ3ZTQXl5NWM5akl1azFsSUlwNlAzQ3Nr?=
 =?utf-8?B?dnJHTjdUWmFQN2swNWZVdWRJL2VvejJnMHRxUHg2NEE2ZFR3Tm1SV3NlNFR4?=
 =?utf-8?B?WnR2dGtmZHhSTXZJOFNnQnpOS1BabjVLblQ2bWJoRDhYNzNzaCtmMXo1aElZ?=
 =?utf-8?B?eVRkNXJ6QkJRem5NbzZHVzBCU2IyU1lhNlVtTkdsVHczeGdJNlhST3Fja0dx?=
 =?utf-8?B?YW1EUzQ5Z0dUTTdrcHVHMWFaRzVPelpXcVFuMW4wdCtYaXdTMWNsbmwrZDZp?=
 =?utf-8?B?VklINFZwbk95dmJ4ODhqemxjOU56UnVsWmZrb3BhODFhQi8xajBoMndmNGlq?=
 =?utf-8?B?bHRTM0o0cXowN1RibWY2Z0tNM1Z0Q052ZTV0QnNmNzk0NmNBK21kTlhuMU51?=
 =?utf-8?B?dGUvSzBQNzc5U2N3SjlITVBDZmZTaHBWU2xQQlh0bkoxL0RhYVNyWGFGVlkv?=
 =?utf-8?B?TDM1aXBXL3djYS9WWmJ1UmVLMjM4NnVnU2RLcU0vS0ZkU2xKZmpnVXZJTWt0?=
 =?utf-8?B?UHU4R1YwSFpRUURyLzJrQVhTZGZ5bmNFNFVkU1FvM3BwTW1hMU9hYmVzUWlZ?=
 =?utf-8?B?UUZLTzVsbXVpUXF5ajZmNlowK0pTeUhFQnNuZUtqTDIyRGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5912.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVRGVlF5VmNRRzNTdU9JK2hydTZZejU1MUc1RGVQRU91NFhSVG5QTjNyQzBQ?=
 =?utf-8?B?NncyQnIwM1hjQmJlTHFPNmpLK2xBQ3lwc0hYU3g4SkEwazVienNCYUdzYzU3?=
 =?utf-8?B?VCtqZ2RxMUZzS3ZEMERUeTlDNE43d2oyTlhGVmtGRGJQazY2dUg5amRYUnZw?=
 =?utf-8?B?WW1IQm5RL1k2V29NRWsyek5qZW9qSS9kYTJSdll5UmRPQnZ5dkh0WE9ya0li?=
 =?utf-8?B?eFNPaWdqSTNSb2k0WkpGVE4weGFUTmVqOEtWOUxEdCszU0pyNmpYbGJWOWFW?=
 =?utf-8?B?Z3Vsem5qdmoraUZXaW1PRFF1Q09IZE8xTGtEMUhTUzVkK0g5c3oySHRYZzMz?=
 =?utf-8?B?MmZMT2ZPNmRwRjV3cTQwQ3crY0dWMkhmdGRhYVFyWEpyMmhBNVlpOFZBRDBq?=
 =?utf-8?B?V0xJMHYxTnk5bERyVTIwS3Y5cXpHc3Vid1RsVnpRL2RJVWNtWjJ3RWw4VkxT?=
 =?utf-8?B?em9lRFV1azJkYU04Z0ZWQjN1a1FRejh0YXY3MHpUQ0p0TnpJQ2piWmZidVBS?=
 =?utf-8?B?b2lqTThCZ2NOU0JzZzJqSjh3Y1ZCM3NmZllaVVdjQzhiVVRpUi9lRTRSWkJG?=
 =?utf-8?B?eVBkYm9wSWthMXBBU29uNFhGNjBId2pKZkw1QXIzZW8rTkE5L2w4VDQyblFi?=
 =?utf-8?B?UHNzQ1BJZGxHditpZXY4bXZjZ1JaQ0hiNUU0TldiSHRhcTZGaEUxSVJQUXdD?=
 =?utf-8?B?bzUrcTZjRHQyZ0xCdDNEWFhNeEhqM2M3T1lsSDduYUx5dExlalJrOUI1Uk9k?=
 =?utf-8?B?WXdJSkJZY1VYMGJWcUYrYStZaG9SbGVJUWdCZDVFNzJNa25uOUVWaWZ4bWZY?=
 =?utf-8?B?UkQ4Q0NTV1ZnU1IxMzlNVEV4RFcrekpiczFhbzBxMXJoNW9ydFk3NnFDbmNU?=
 =?utf-8?B?QzBJUTBHVDNpbGdxU252VVN5WG1POXZUUm9LTTZtN2JsL3Fqcm5ORmgzWXhL?=
 =?utf-8?B?VUovR1hCNzJiNWtyZ1JJMnJWR2J2SFhtNk4wRDFBckEyeUsrNnVld3VvTFFu?=
 =?utf-8?B?UWJsb1dTQVI3emVXbENCNStoSmpBd2xVK08vWlF2TmNtL28rbkt1SlRCS1p2?=
 =?utf-8?B?dVZFQkh2TTFLQXFLZGpKRDNjYmJSN1NTVVlDM2JNRmRScUdpNitCUGhEcFBT?=
 =?utf-8?B?QmZ4TnE5ZmhzTnVlUkZyZXJScks5L0ZqVXJScHJZcC9nVlhsL2pZZ0M2UzhC?=
 =?utf-8?B?MmFnTnZiRGdyd2k0SG10OHRsMmovV3k2YXZNeHB6MmdySGl4MjhNVC8yRFI0?=
 =?utf-8?B?VUNFN0ptZGJoT0lWY2tkK3ZGeXBGNVdNVzRwNDcvbkxoVVZZYXYrSmZHM2xp?=
 =?utf-8?B?aThzVUljd0N1ampNSW9URGVoNUE1YmxEdlFPU3d4WXZDLzROYXgreEVGSTZu?=
 =?utf-8?B?eklabCtUTGQrOE5xWlF5T1BqVHViUkI4M3dQeDJ4NG1UNVNEQm11cWFpWHNw?=
 =?utf-8?B?Y1VHOThnK1BSRWpueUJDeUdxVG9CTzdxR2Fma3BneElRNkkrZWFSeVpvNi9X?=
 =?utf-8?B?VG03RUZPNTNXdElYTExkem9qVjVBRUE5L2VXYTlYb2VsR0RjT29meTRPUWZz?=
 =?utf-8?B?YWlicjJCNm9XQXZYMDdyNGg3clRIUGxYclZZdkorR3EwQ1k4eWpiQUtBN292?=
 =?utf-8?B?aXptQ2NBNCtyNHgzb1gwZ2FSMStWT3RDK04vMkFtU3MreCs1TlFvNkpwNyt0?=
 =?utf-8?B?NUtiVjc4VndJVUV2bGxpZ2U3YUdSclRNRGVSM3pQMy9xZ0dYNWNMbk1kSElx?=
 =?utf-8?B?eCszSE9qN1NvamtYcldteGZSU0hXKzNDWEZPUlNia1dzNnVSM2s3NmUyY2hX?=
 =?utf-8?B?NDdKTVFFNEMzZzg5NGZqR0MzWmFweEdzVHIySGNCQ3MyNnBZeEZUY0dLT3F4?=
 =?utf-8?B?VVhnUlJOQzFrZzg2cVMwY2RYOE5sTzB5bXJHeU8xZWNwN2xHQ2E0UVBCQ2Zq?=
 =?utf-8?B?TnRueGZPaVZXbVgwR1BHbEwrNEJyTm1FcEY5bFBmNTNzS0N5MFVtVVRuRDln?=
 =?utf-8?B?ekNCcGkxRlI0aGVjTW5CSlBsOXBnM0lJTFhwZEJBOE1BaUczOGE3VTNHZURj?=
 =?utf-8?B?RmhDZlh5YVVjYlpid3FYcjFWeTFuY0JiQVVYb1ozbkV0L1ZGN1V0cS9WUnU5?=
 =?utf-8?Q?ooZyp1ayYf2uSivJgUNUJaO4O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5912.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2997d56-9650-4424-a364-08dd66018791
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 09:44:51.1374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3cxfAXs5w2ihRBeOzHWWLKXni4PxH3PVtCdvjwwSSqU5sua2xtvQMn3KxiyaGa1St+LLhxmGjhRVuw0WFSJ2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
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
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggNywgMjAyNSAxOjQyIEFN
DQo+IFRvOiBhbm5vdW5jZUBkcGRrLm9yZw0KPiBTdWJqZWN0OiByZWxlYXNlIGNhbmRpZGF0ZSAy
NS4wMy1yYzINCj4gDQo+IEEgbmV3IERQREsgcmVsZWFzZSBjYW5kaWRhdGUgaXMgcmVhZHkgZm9y
IHRlc3Rpbmc6DQo+IAlodHRwczovL2dpdC5kcGRrLm9yZy9kcGRrL3RhZy8/aWQ9djI1LjAzLXJj
Mg0KPiANCj4gVGhlcmUgYXJlIDI1MSBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNuYXBzaG90Lg0KPiAN
Cj4gUmVsZWFzZSBub3RlczoNCj4gCWh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRlcy9yZWxfbm90
ZXMvcmVsZWFzZV8yNV8wMy5odG1sDQo+IA0KPiBNb3N0IHNpZ25pZmljYW50IGNoYW5nZXMgYXJl
IGluIG11bHRpcGxlIGRyaXZlcnMuDQo+IA0KPiBQbGVhc2UgdGVzdCBhbmQgcmVwb3J0IG5ldyBp
c3N1ZXMgb24gaHR0cHM6Ly9idWdzLmRwZGsub3JnDQo+IA0KPiBEUERLIDI1LjAzLXJjMyBpcyBl
eHBlY3RlZCBpbiBvbmUgd2Vlay4NCj4gQXMgaXQgaXMgYSBzbWFsbCByZWxlYXNlLCB3ZSBtYXkg
dHJ5IHRvIGNsb3NlIHRoaXMgY3ljbGUgaW4gYWR2YW5jZS4NCj4gDQo+IFRoYW5rIHlvdSBldmVy
eW9uZQ0KPiANClVwZGF0ZSB0aGUgdGVzdCBzdGF0dXMgZm9yIEludGVsIHBhcnQuIGRwZGsyNS4w
My1yYzIgYWxsIHRlc3QgaXMgZG9uZS4gZm91bmQgZWlnaHQgbmV3IGlzc3VlcyBhbmQgbm90IGZv
dW5kIA0KDQpOZXcgaXNzdWVzOg0KMS4gQnVnIDE2NzEtbG9vcGJhY2tfdmlydGlvX3VzZXJfc2Vy
dmVyX21vZGU6IGZhaWxlZCB0byBsYXVuY2ggZHBkay1wZHVtcAktLSBub3QgZml4IHlldA0KMi4g
cGZfc21va2U6cGZfanVtYm9fZnJhbWVzOiBtYXggbXR1IHR4IGVycm9yIGZvciBFODEwCQktLSBJ
bnRlbCBkZXYgaXMgdW5kZXIgaW52ZXN0aWdhdGluZyAgICAgICAgICAgICAgICAgDQozLiB1bml0
X3Rlc3RzX2NyeXB0b2Rldl9mdW5jL2NyeXB0b2Rldl9xYXRfcmF3X2FwaV9hdXRvdGVzdDogdGVz
dCBmYWlsaW5nCS0tIEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQo0LiBCdWcgMTY3
Mi12Zl9vZmZsb2FkL2NoZWNrc3VtX29mZmxvYWRfdHVubmVsX2VuYWJsZTogZ3RwdSBwYWNrZXQg
Y2hlY2tzdW0gZXJyb3IgcGFja2V0CQktLSAtLSBub3QgZml4IHlldA0KNS4gW21ldl0gY3BmbF92
Zl9yZXByZXNlbnRvcl9ydGVfZmxvdy9wb3J0X3JlcHJlc2VudG9yX3Byb2JlX3NjYW46IHBvcnQg
YXR0YWNoIGZhaWxlZAkJLS0gSW50ZWwgZGV2IGlzIHVuZGVyIGludmVzdGlnYXRpbmcNCjYuIGxv
b3BiYWNrX211bHRpX3BhdGhzX3BvcnRfcmVzdGFydDogY29yZSBkdW1wZWQgb2NjdXJyZWQgd2hl
biBleGl0aW5nIHRlc3RwbWQJCS0tIEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQo3
LiB2aG9zdF92aXJ0aW9fZnV6emluZy90c29fZm9yd2FyZF9wa3Q6IGFkZHJlc3NTYW5pdGl6ZXIg
ZXJyb3Igb2NjdXJyZWQgd2hlbiBleGl0aW5nIHRlc3RwbWQJCS0tIEludGVsIGRldiBpcyB1bmRl
ciBpbnZlc3RpZ2F0aW5nDQo4LiBQdHBDbGllbnQ6IHRpbWUgc3luY2hyb25vdXMgZXJyb3IJCS0t
IEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQoNCiMgQmFzaWMgSW50ZWwoUikgTklD
IHRlc3RpbmcNCiogQnVpbGQgb3IgY29tcGlsZTogIA0KICpCdWlsZDogY292ZXIgdGhlIGJ1aWxk
IHRlc3QgY29tYmluYXRpb24gd2l0aCBsYXRlc3QgR0NDL0NsYW5nIHZlcnNpb24gYW5kIHRoZSBw
b3B1bGFyIE9TIHJldmlzaW9uIHN1Y2ggYXMgVWJ1bnR1MjQuMTAsIFVidW50dTI0LjA0LjEsIEZl
ZG9yYTQxLCBSSEVMMTAsIFJIRUw5LjQsIFJIRUw5LjUtUlQsIEZyZWVCU0QxNC4yLCBTVVNFMTUu
NiwgT3BlbkFub2xpczguOSwgQXp1cmVMaW51eDMuMCBldGMuDQogIC0gQWxsIHRlc3QgcGFzc2Vk
Lg0KICpDb21waWxlOiBjb3ZlciB0aGUgQ0ZMQUdFUyhPMC9PMS9PMi9PMykgd2l0aCBwb3B1bGFy
IE9TIHN1Y2ggYXMgVWJ1bnR1MjQuMDQuMSBhbmQgUkhFTDkuNC4NCiAgLSBBbGwgdGVzdCBwYXNz
ZWQgd2l0aCBsYXRlc3QgZHBkay4NCiogUEYvVkYoaTQwZSwgaXhnYmUsIGlnYiZpZ2MpOiB0ZXN0
IHNjZW5hcmlvcyBpbmNsdWRpbmcgUEYvVkYtUlRFX0ZMT1cvVFNPL0p1bWJvZnJhbWUvY2hlY2tz
dW0gb2ZmbG9hZC9WTEFOL1ZYTEFOLCBldGMuIA0KCS0gQWxsIHRlc3QgY2FzZSBpcyBkb25lLiBm
b3VuZCB0aGUgNiBpc3N1ZS4NCiogUEYvVkYoaWNlKTogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5n
IFN3aXRjaCBmZWF0dXJlcy9QYWNrYWdlIE1hbmFnZW1lbnQvRmxvdyBEaXJlY3Rvci9BZHZhbmNl
ZCBUeC9BZHZhbmNlZCBSU1MvQUNML0RDRi9GbGV4aWJsZSBEZXNjcmlwdG9yLCBldGMuDQoJLSBF
eGVjdXRpb24gcmF0ZSBpcyBkb25lLiBmb3VuZCB0aGUgMiw0LDYgaXNzdWVzLg0KKiBQRi9WRihh
cGZpL2NwZmkpOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgY3BmaV9ydGVfZmxvdy9UU08vTVRV
L0p1bWJvZnJhbWUvY2hlY2tzdW0gb2ZmbG9hZCwgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUgaXMg
ZG9uZS4gZm91bmQgdGhlIDUgaXNzdWVzLg0KKiBJbnRlbCBOSUMgc2luZ2xlIGNvcmUvTklDIHBl
cmZvcm1hbmNlOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgUEYvVkYgc2luZ2xlIGNvcmUgcGVy
Zm9ybWFuY2UgdGVzdCwgUkZDMjU0NCBaZXJvIHBhY2tldCBsb3NzIHBlcmZvcm1hbmNlIHRlc3Qs
IGV0Yy4NCgktIEV4ZWN1dGlvbiByYXRlIGlzIGRvbmUuIE5vIG5ldyBpc3N1ZSBpcyBmb3VuZC4N
CiogUG93ZXIgYW5kIElQc2VjOiANCiAqIFBvd2VyOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcg
YmktZGlyZWN0aW9uL1RlbGVtZXRyeS9FbXB0eSBQb2xsIExpYi9Qcmlvcml0eSBCYXNlIEZyZXF1
ZW5jeSwgZXRjLiANCgktIEV4ZWN1dGlvbiByYXRlIGlzIGRvbmUuIE5vIG5ldyBpc3N1ZSBpcyBm
b3VuZC4NCiAqIElQc2VjOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgaXBzZWMvaXBzZWMtZ3cv
aXBzZWMgbGlicmFyeSBiYXNpYyB0ZXN0IC0gUUFUJlNXL0ZJQiBsaWJyYXJ5LCBldGMuDQoJLSBF
eGVjdXRpb24gcmF0ZSBpcyBkb25lLiBObyBuZXcgaXNzdWUgaXMgZm91bmQuIA0KIyBCYXNpYyBj
cnlwdG9kZXYgYW5kIHZpcnRpbyB0ZXN0aW5nDQoqIFZpcnRpbzogYm90aCBmdW5jdGlvbiBhbmQg
cGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcyBQVlAvVmlydGlvX2xvb3BiYWNr
L3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0gcGVyZiB0ZXN0aW5nL1ZNQVdB
UkUgRVNYSSA4LjBVMSwgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUgaXMgZG9uZS4gZm91bmQgdGhl
IDEsMyBpc3N1ZXMuDQoqIENyeXB0b2RldjogDQogKkZ1bmN0aW9uIHRlc3Q6IHRlc3Qgc2NlbmFy
aW9zIGluY2x1ZGluZyBDcnlwdG9kZXYgQVBJIHRlc3RpbmcvQ29tcHJlc3NEZXYgSVNBLUwvUUFU
L1pMSUIgUE1EIFRlc3RpbmcvRklQUywgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUgaXMgZG9uZS4g
Tm8gbmV3IGlzc3VlIGlzIGZvdW5kLg0KICpQZXJmb3JtYW5jZSB0ZXN0OiB0ZXN0IHNjZW5hcmlv
cyBpbmNsdWRpbmcgVGhyb3VnaHB1dCBQZXJmb3JtYW5jZSAvQ3J5cHRvZGV2IExhdGVuY3ksIGV0
Yy4NCgktIEV4ZWN1dGlvbiByYXRlIGlzIGRvbmUuIE5vIHBlcmZvcm1hbmNlIGRyb3AuDQoNClJl
Z2FyZHMsDQpYdSwgSGFpbGluDQo=
