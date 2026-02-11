Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE62E9E2EC
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 11:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46C7C402B5;
	Wed, 11 Feb 2026 12:51:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id CD5B14026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 12:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770810663; x=1802346663;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YER7kHjaQbTyPvFj+8FQx0e6wJuWC9MjxOTtm5xcfsE=;
 b=D0+91fLbPy9N2ZjTuQ+FcMbcRqkW4m6DWeaXLXS1jbS5k8vSL5JzP/Zl
 Aq+IqyorjFBz+iovG756su/4CDtxGl38vOheMzQQsFOfrLUlRgnJzJ8Vf
 v2G3+XZiDhQmAKbBQAT738Dc+gg1OQXzdrtQw9ehEdx2Pp00H7N2vmz5Q
 a6Lmja4KUECGaadT6SzSH2V77GPJi6QcKUdwQ1dklrhN8y8z4tz1P/WrG
 trtwCBql0F90BRHnuV/3ADldREIK9XlenhxPpJ+Zi9ocoRIcaLv8j4iJ9
 H/TdbJYKyjza49BXMrZIrhKl8laGevwtwzl+WSLFmkJrX8t26sFnJtl6M Q==;
X-CSE-ConnectionGUID: QSeY2G5ySm2VM0m2WtpAuQ==
X-CSE-MsgGUID: +LJ2iYYkS0qlGcUJEbie4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="70977466"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="70977466"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 03:51:02 -0800
X-CSE-ConnectionGUID: sGc/gDxqSf+GXkdJVj8+4w==
X-CSE-MsgGUID: th1UALWHS96qXLLepkInqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216391696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 03:51:02 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 03:51:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 03:51:01 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 03:51:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crx7n6zlgrSh8gOBm6Pq3AhzrFoaT98L30dgfTs4OHMKxds+yeqFeV4E6DjExqUsxO9b5184MxsBb+yBUwxzn1wObH/MBQgdhBGK0nQS45aN1qmGVRhe/PNFYn63iWBOU3XqjLNPhCq9MPYxa1yLgKnqzLVsfZlzP4rt5w7aBn6fC5hSjeIaNfyzAHW96Njy+YgwlU0AY2t8kL8VICf1xAIbe6sOoDqYpcp+RKnIH+RHrFmhXLmUI8x75Y9qFOUslGmDRMjzaymGoVjfvcbCG1tljI9DVTNlFcQMq6BAHq5Ht+hddhdIK+rA08bYe312/gky+7pGgpSrV3UMaXV+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YER7kHjaQbTyPvFj+8FQx0e6wJuWC9MjxOTtm5xcfsE=;
 b=bgxoqKQfaRA2wHQdPwK3QURyH+UDn3fXnoxRIT2esgU+mxWm3Mw/rDsgEmyRJuzSPTsC7ThDAZuRw9wyI140+YSXwoWLCP3O0LUyFRiREr4fpQY6eompOviSRxXV9rQH5UfA50QO1QhQnoEvNGCiXflW9CVcjsB+1dpUwiF1Tz8DKKOEDW5zWv4/nh0RfwaRhp+1b+cx/pZ3++OkEbCBrSx8UgqbtU09Ikx6gjPbwNKXq2nU/tkYvxE2DAmEflJb6cKEr4h0tebquW2xw8b0VDCsDlUViwyJ8vCbFnVQCQ2roSNy+t3nI04d4qsSANBtIPjb716LMsAY6ARmfitATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18)
 by IA1PR11MB9519.namprd11.prod.outlook.com (2603:10b6:208:5d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 11:50:54 +0000
Received: from CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::75d6:4d13:fd04:4171]) by CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::75d6:4d13:fd04:4171%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 11:50:54 +0000
From: "Finn, Emma" <emma.finn@intel.com>
To: Akhil Goyal <gakhil@marvell.com>, "Ji, Kai" <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v3] crypto/openssl: Add support for SHAKE algorithms
Thread-Topic: [EXTERNAL] [v3] crypto/openssl: Add support for SHAKE algorithms
Thread-Index: AQHcj3TR6BNBZmohN0GdI2aiVpFeY7V8H/6AgAFaMgA=
Date: Wed, 11 Feb 2026 11:50:54 +0000
Message-ID: <CY8PR11MB784583360FDC2FCA130703CCEA63A@CY8PR11MB7845.namprd11.prod.outlook.com>
References: <20260108153330.2441799-1-emma.finn@intel.com>
 <20260127100741.3845554-1-emma.finn@intel.com>
 <CO6PR18MB4484F3A23A3D9D7845BF81C2D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
In-Reply-To: <CO6PR18MB4484F3A23A3D9D7845BF81C2D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7845:EE_|IA1PR11MB9519:EE_
x-ms-office365-filtering-correlation-id: 0b825c8f-1d8a-4ed0-68bc-08de6963d019
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d3lCZGhrcm9YYWFyWmJRcXFUWnZINGdzTEtJc2x4SGVuT3pvV0d5V0lENEV6?=
 =?utf-8?B?cElCZVptNk1PVzRhWU1PRlgrVnFyZldXOGtndm43WGlqMVgxZzBOeGpiUmlj?=
 =?utf-8?B?Q284bEJHdWs2akQxdS9Ib0J0c2VKR3pPbmpSNlQwQVNhV1B0VElPQ1lqcWZB?=
 =?utf-8?B?QlBwYVgrUXlTMU95MzBVUjh1c0tQY05XUnlZejQvdURYMHpCRlJTNjVSd1V2?=
 =?utf-8?B?NzFoU3o1UmZkTGs1TnlLVVI4ZldKVVJVUUhDNENuZkNSTEVDZ0dMbzNqNzIv?=
 =?utf-8?B?ZlpJcWFzL2Z2Ukk0SEJFeWRSeVMwbjJhRG8yYTkxTnRQVjN6b01uTlVqTDA4?=
 =?utf-8?B?Um9NRW52a3phMmpUdTgvWEIvTU5nN2lkWUd6b0RwMzhHblhwNjZsbE9CSUxk?=
 =?utf-8?B?amdqendjZ1hyTWxvSittclJmWityMU5tMDFQenpyZVJKN0RXTWZpeEM3dmVi?=
 =?utf-8?B?Zkg2QnRiNHUvRjNiNVc5dTAzTHBIbjZjVXpTbVlaRmFQbS84L3Q0NEtVTTFY?=
 =?utf-8?B?OXp6YUVZcEptd0tCQmg5aW5aT2ZJcUM4aiswV2FOZ1ArZGdreUQ3VHVjMDhL?=
 =?utf-8?B?bTRXSDluK3ZaT0xrOWRtK1QvcXBOM0tEZmRqR3BldjdwTW93d0NjMmFMYnlk?=
 =?utf-8?B?Vm9sWUF6WFJXSFUwalBFaHk0SDVLYWgrZ3E1RFFQUXcvK0IzNTBrb3pmOHgz?=
 =?utf-8?B?QW5EbzRZTmFuNnlPR29iT05ZdENEU29zV2hpRkZtZFBSVXNGdWhiQ21Pb290?=
 =?utf-8?B?VG9Lb3BlSDZSek9YWjJySzVLM29ucnoyaVJtdUFUbGJ3TkpvUkxIMG4zQnNo?=
 =?utf-8?B?ZTlRWUt3NHAwZDlLS2pjWU5DOU8zYnhvSDF2cGdwem5tQXZYZ2IzbkxuUXAz?=
 =?utf-8?B?Rnl1ZXluUVV6MmdIdXVTTHZDTi9VTElHVUo0VTZZKzJhZTQ0cmx6NEZzYXl4?=
 =?utf-8?B?cDJnN1Q4NmVDWjJXVXVEV0JJWkNtSW5JSm5DWUxaRGZub0xPZVEzWE54ZGg0?=
 =?utf-8?B?T0NvdFU2SjJXcDA4amM3SC9rSjNtTHZRbjRlYkdaengzb2xMd0UrV0hzVFN0?=
 =?utf-8?B?OUpYYzZhMEVXTWJoV2V4eHZGUUtZQzRKdi9SZnJscHBYYWZDMEVCUm5DM1hQ?=
 =?utf-8?B?Wk5IdURHMXVyUXRSMTVNV0FCbjVGQ1dmYWZ2dTZUNFRENmFPMHQySU12N28y?=
 =?utf-8?B?UmFrOXhjQkdwdk1mdlJwMHdQZ3FieE44elQyemk4WTRXamZtbjhFTFJvZ3Jw?=
 =?utf-8?B?blV3RDhULzRCZXE2MXFjdTc0bkRNaU5PZS8rQ01paCsybVFwbG5NM2VOM2t3?=
 =?utf-8?B?RDgvR29RMWIweG1iWWRpYzBVc2VMUDJZRjZtVUt3bEdmckN3alFUUVNPcUVv?=
 =?utf-8?B?cFR3SlFDYzFYYUNtSlZLRm5DOTZib0FlRzZTUlI2RjBvaldOeDMyaStXdjY4?=
 =?utf-8?B?RTd5eHh5ZDBtbUlDNDROOHowTmhPRXJNbWRtejlJcXA4SG42MDNsZjdsK1Fk?=
 =?utf-8?B?ZWtya3V1eTY0Z3hZYm4rRnlkWjd6TU9lakJxSWhyWUdNZEx0L3BvLzBqdTdh?=
 =?utf-8?B?MmhPcHdjT09VNUtnNFQveUpjZHo4SXRjODNyc3ZUUmpBdWVQcTNoczEwWWRz?=
 =?utf-8?B?SXExUGl2bGt1RFdxNFc3WDNtMUczU2dQQlgyWDkvcDBXUDlObkhvaWNuWGZQ?=
 =?utf-8?B?T2RPbXZWa2J5RDRVa3FjRkxjV3EwTldPZ0lvT2hoQ0h1NnhUbGV6WmhtMkIr?=
 =?utf-8?B?R1Z4S0hoYlRVaXl5UDAvbnYra3FvL1J4amJZb3Ficy9udVk1a1E1c29FUXdT?=
 =?utf-8?B?dE1qWVNrbG5pc3NSYjJ4UEFxVFl5VEVHOEswSFJ5NFVnQ2hpQUpmTlp0Q3h5?=
 =?utf-8?B?cHVVRDdEelNlVk9KUytHVG9CVjIvZGMwMXQzSDJiM0ZvT3dNYWg0TmtHTXpS?=
 =?utf-8?B?VUVXaGRJRkZmRkxVOUQzRXFiMU8vRzc4Skl1SlYzRTYrVzdmMTlBVTBDVkUy?=
 =?utf-8?B?RTc3dVgwRXdDTmRRUmh0SGlGR0EycGRkUys4YVRXaVJRclJXQVhIUjB0dGUv?=
 =?utf-8?B?SWVVb25xQnNadXVObnltMVNDY1BDYnc3VFI2ZHFqVEh6M2NrRlRvWE9IQWMv?=
 =?utf-8?Q?HncbWyKBLy7l2YfXsSxty9HhI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7845.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clk4eEVaK01GK3oxazhNMGoxSXZWZzB3dm4zOUJxODRkdEt0Mm5XMXVFVmF6?=
 =?utf-8?B?YjdLSDhrT1lEdHVxcm5xalI1OVFVK1ZtNW45R0pyditjSGhUY0NERGkrOFRt?=
 =?utf-8?B?Nm04eGwzUWNnMFQ2QXdrZVZmVk1sb3FRY3VlYUN5R0xLVzU4UnY3WmFoUEta?=
 =?utf-8?B?V2V5YlFMK2V4UUNkNVR2VGVqSFJ2SCtFTHZSVFBrZWsyM0IrSlJFeHJsaEtV?=
 =?utf-8?B?NTRhYTd2b3dUWmNBQ2xpS2F6c0I3YUxOUjVzUHM1WTFQVUJVckJxZ0NxcVUx?=
 =?utf-8?B?dHJtR3RTRWQyWDgrRFZPZ0pibWxtRkJSUE85dlYvN2NORll5eGZKOGdRL25C?=
 =?utf-8?B?SVcxaGZXbG1SSWMzV1MrNlRXdVk3UFVNaGtpM29wbWlqMlMwdGpyODFCUGZB?=
 =?utf-8?B?Mm00N3lER0N5dzBJNmVpeXBIUUJYcTlma2FSRHlLUW5aamFFTm1GWmUvaEpx?=
 =?utf-8?B?L2MvaGQ4dkUrSzc3eTlxdytLeVpCTFU1N0FycG1zN2FjbHlPbDB3R09CUnNs?=
 =?utf-8?B?aHlzRmtCcTQ4TjdSM3VIdGFmWlZRVTJiUHZxeGVkVzJSMXpGSTMxZmlmdThL?=
 =?utf-8?B?YThwNkJ6ZW1MajdoVm5mc3VuNklLWTBidXpETU1acCtnTWcwTEw0dFBISWJG?=
 =?utf-8?B?QU8xckpPZzZxUG9QV1dPWWwyUU81TzcxZVlha2pGQVhqRkd6MnYzY1BtcnpU?=
 =?utf-8?B?K1cxalNKenYreldNdzF2Rzk4SEtzRTVpaWFWZHVja1pGa1M3RXNKOFB1U0V1?=
 =?utf-8?B?TUx1azBCck9GdzUrS1FPdWpHaTV4Qy9OQUhaOUJKT0pEZCtEaE45dmpCYTJ0?=
 =?utf-8?B?REZWS05qblZNZTJYSFNDU2lXRWoxUFZ1S3pIVWJFVGc2VzRyMFdHSVQrUmlo?=
 =?utf-8?B?WWNsSG5PN05nbXI4eksvWHpJYkNpeXorNW1RYzlYck9FcXpBbUNVWWJUQkJr?=
 =?utf-8?B?cmFmb2pnWkIzRTNzTStGbGpmY216QzJZMXhzZzRhLzlFeFE2NHJiRHZlUTNV?=
 =?utf-8?B?SlhLdHZVaFZkcW9xNGhVZkRlWXA0S01GbFdxa0duS1FnTThMbWp0SndBY1dQ?=
 =?utf-8?B?b293ejd3VUxZNGVkRElVRnZhVWlFMUgxaW5RdC9rWkE1ZHZDMGxRaUY3Q0xU?=
 =?utf-8?B?MHNkdDM0dHRaa29kVkdSaHFZR0F4c2dMSndPK0ZvMGJoK295SVBnTVRTLzBa?=
 =?utf-8?B?alpKaWpEN0JRY2dVaVQ0UCtmdkpubVZoVkV6dWZZQm1sMXdEZFBpRy81eUhZ?=
 =?utf-8?B?cWZBTjgxRGpPbkIvZzNNWWNNN2tGN0hOUkxHZkpCa2Qxb0l0L3Nldi9RdVBH?=
 =?utf-8?B?SkVDUkRPWm1FUm1DalVHek53YjhSaldYU3ByQmhTalA3QlVUYVZPUGYwUHpY?=
 =?utf-8?B?M3BwZ2xxN1ZSVFl5SXFFaFA2dDRESEdUMXd4TjBrWnNvMmpNaVZRVENuaWRy?=
 =?utf-8?B?TjZRTzRoU1N0Rkw2OXFLV1lJa2VEMlpQNjltenltNHh5VmRSbXd3TjNrd2sy?=
 =?utf-8?B?SzZIUmFEYWFGckNmMXpadFM4ZjVjMUxVeFp4Szk0VnpuK0owRDJIYUp3M09L?=
 =?utf-8?B?bGowNlR5OTV4Z2pMRXExYzc4WkdUTTBScEtYNEhjUXJOa0lob2kwY2NJQWxL?=
 =?utf-8?B?V0pCSkFKaUxYY0gvT0thVWZwV2lUSFI5YXFwSzYyVWw2MzlQTTBpcHNMWmxX?=
 =?utf-8?B?aktyTExVSDRCd09EdHdxMVF1dVIwOVhFY0ZDUlV5ZnZ2QW5QV053Y2oyZlFO?=
 =?utf-8?B?TmlRWnI5QVE1TkZIK2pjR29xc0xyVnhMYVZrZkZTTWxoNDVybDRiblppVUxK?=
 =?utf-8?B?TndiWEpNM0ViYWNERkFMWUVFOGJRZXF6TzBUVStGZ29NVDE3L0RTRHhYaGk4?=
 =?utf-8?B?NFN2KzI0S2x1Y05nVGsxdjhEZDRQUUFCM003YllvWE1uVHBocXZkY1BQVyts?=
 =?utf-8?B?VHhiR1lmNWpzYkYxTDI1RjU2SDFpdTA5MWRld2gzNjIzOFNEUEpjalJnNVdl?=
 =?utf-8?B?cC9mWDZsVDV0THY1OXp1N3JSTklRWENoVG1CYVNCb2kzczhKTjFsZzc3Tk5m?=
 =?utf-8?B?eXhBdE1BdlRKNFF6Zzc1NXk4dlRHbnR4T3B2MFljYXdRNVFIMXlMZTl2SEZ2?=
 =?utf-8?B?L1ZKYjFtUmowdjlDcTh1TEdoMlZhZUhVMG1OYWpVQXZoUms4YVNVRnpTOHNF?=
 =?utf-8?B?cnNDVXNnbDMxbmRKbmdUd3BoV3RteHhyZmZBdkhzOXlnc1Raek9KT0pFL1Jm?=
 =?utf-8?B?OWZqaVRINERwR3VDb1BZOEhsWnRqVW8zdXZjSHU1bC96V2lTemVJREgvWTdY?=
 =?utf-8?Q?9ZMVG6wIqUjS9+fBYW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b825c8f-1d8a-4ed0-68bc-08de6963d019
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 11:50:54.6566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+JwzzJQDOIGV2y/5NiaGfSGad9NpZwyraK7HPCWFNbkFESUW4gQYFvmRW9jGx8HBWZ1dUM+t8R1M57jeiKAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9519
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBa2hpbCBHb3lhbCA8Z2FraGls
QG1hcnZlbGwuY29tPg0KPiBTZW50OiBUdWVzZGF5IDEwIEZlYnJ1YXJ5IDIwMjYgMTU6MTENCj4g
VG86IEZpbm4sIEVtbWEgPGVtbWEuZmlubkBpbnRlbC5jb20+OyBKaSwgS2FpIDxrYWkuamlAaW50
ZWwuY29tPg0KPiBDYzogZGV2QGRwZGsub3JnDQo+IFN1YmplY3Q6IFJFOiBbRVhURVJOQUxdIFt2
M10gY3J5cHRvL29wZW5zc2w6IEFkZCBzdXBwb3J0IGZvciBTSEFLRQ0KPiBhbGdvcml0aG1zDQo+
IEltcG9ydGFuY2U6IEhpZ2gNCj4gDQo+ID4gT3BlblNTTCAzLlggaGFzIHN1cHBvcnQgZm9yIFNI
QUtFLCBIZW5jZSBhZGRpbmcNCj4gPiBTSEFLRS0xMjggYW5kIFNIQUtFLTI1NiBzdXBwb3J0IHRv
IHRoZSBPcGVuU1NMIFBNRC4NCj4gDQo+IFNpbmNlIE9wZW5TU0wgMS4xLjEgaXMgRU9MIChodHRw
czovL29wZW5zc2wtY29ycG9yYXRpb24ub3JnL3Bvc3QvMjAyMy0wOS0NCj4gMTEtZW9sLTExMS8p
DQo+IENhbiB3ZSByZW1vdmUgdGhlIGlmZGVmcyBpbiBmdXR1cmUgZm9yIHZlcnNpb24gY2hlY2tz
IGFuZCB1cGRhdGUgdGhlDQo+IG1pbmltdW0gT3BlblNTTCB2ZXJzaW9uIHN1cHBvcnRlZCBpbiBE
UERLIGFzIDMuMD8NCj4gDQo+IElmIG5vIG9iamVjdGlvbiBjYW4geW91IHNlbmQgZGVwcmVjYXRp
b24gbm90aWNlIGluIHRoaXMgcmVsZWFzZSBhbmQgZG8gdGhlDQo+IGNsZWFudXAgaW4gbmV4dCBy
ZWxlYXNlPw0KDQpUaGFua3MgQWtoaWwuIFN1cmUgSSB3aWxsIHNlbmQgYSBkZXByZWNhdGlvbiBu
b3RpY2Ugbm93IGFuZCBjbGVhbnVwIHRoZSBQTUQgbmV4dCByZWxlYXNlLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogRW1tYSBGaW5uIDxlbW1hLmZpbm5AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+
IHYyOg0KPiA+ICogRml4ZWQgdW51c2VkIGRpZ2VzdF9sZW5ndGggdmFyaWFibGUNCj4gPiB2MzoN
Cj4gPiAqIFVwZGF0ZWQgZG9jdW1lbnRhdGlvbg0KPiA+IC0tLQ0KPiA+ICBkb2MvZ3VpZGVzL2Ny
eXB0b2RldnMvZmVhdHVyZXMvb3BlbnNzbC5pbmkgICB8ICAyICsNCj4gPiAgZG9jL2d1aWRlcy9j
cnlwdG9kZXZzL29wZW5zc2wucnN0ICAgICAgICAgICAgfCAgMiArDQo+ID4gIGRvYy9ndWlkZXMv
cmVsX25vdGVzL3JlbGVhc2VfMjZfMDMucnN0ICAgICAgIHwgIDQgKysNCj4gPiAgZHJpdmVycy9j
cnlwdG8vb3BlbnNzbC9ydGVfb3BlbnNzbF9wbWQuYyAgICAgfCAzNiArKysrKysrKysrKysrKy0t
DQo+ID4gIGRyaXZlcnMvY3J5cHRvL29wZW5zc2wvcnRlX29wZW5zc2xfcG1kX29wcy5jIHwgNDQN
Cj4gPiArKysrKysrKysrKysrKysrKysrKw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDg1IGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gDQo+IEFja2VkLWJ5OiBBa2hpbCBHb3lh
bCA8Z2FraGlsQG1hcnZlbGwuY29tPg0KPiANCj4gQXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRv
DQo=
