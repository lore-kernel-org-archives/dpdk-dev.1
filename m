Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FC8E68147
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:15:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD3F4402C5;
	Tue, 17 Feb 2026 18:15:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BBDD0400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771348543; x=1802884543;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=c5uuO3sQduDEch57KtEY5aID0ZyEjohrsoDYOMNbLA8=;
 b=ab01gO25Zazvj3QUkp9pjPWE1tecj9YwvHXoRAM6kwo13rXjxbhaDq6H
 fSDa+gnqXqxvWnr/hyWwgDbns+HztPJ3l1CSDFUc6WC0bzxFf6coIYjOY
 Q+1SLPEX06MTIo+grNXMp74bm0RS2gfr+p7OtdtXXJk1cGoHpxM0GUlad
 tuV1kDfNPXJV0ruHAlsc6gLQ97THv6NOM8WMoII9if5HkkX0CRo31QuIy
 3itXsNzgXStHOgohqZYJ5cfxacRXBHf7K1Ilu5iKAtAE+4vRfVQqs69ku
 G2ldFZPCYwM/tkZhvpHM+bF1RwbwOnvEZTI/QWT/ZEkLmAxbCMhllE5Rk Q==;
X-CSE-ConnectionGUID: ukwuLElZSEO4b3FeAGdObg==
X-CSE-MsgGUID: YuCit0xmRBadmoCdBFOBpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="89834572"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="89834572"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:15:41 -0800
X-CSE-ConnectionGUID: orX0ub6ITdWdQHNSZsSbxA==
X-CSE-MsgGUID: dwtQLbDYTSaawpo30CZg0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="242892927"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:15:41 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:15:40 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:15:40 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acJYeU7yTtyoNxJfMV0KouUbtMgZaySmbDO+2KSeJEACguJlH51peiqq+9sqsOXWVbawiN6S9zwU07uYy2oauDQyOrMSwMBq0DwJoQf9PKH/whBNyAjiZWVLRnGmTCIfAKWoo2iTlhvCCQ3ThtkuHgCsq7qb4pqJI8wLeBaV0uBhPI34GfobDYnzu+b7H3W5U0JqWksunitNNjertiA+SjDvHI98Efa03Lpn7bJAtivyQBVSUysl0npM3nZ1MGLawGXpj62Uqy5vAqGtHVRDLukQqzEf3XAZz/AUPCNuYbOTYD4Ho0HNpjuFvcJcTDYRT66i3yzWhq99ZMuUYWlYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKSBMwcK84Z9Ykr+aeyWsDMWz5IXrZT/8K9uks7IsUU=;
 b=T6/DCyBQGy/LaV5uCNdfVvNwsZXVVP6N8ILuNx+aklqzjrmxfApBoJgb1yLrZDKiBciP0QpXVvRnSOLfsJh88WKgt/xcArGO0bbbn7PhPUsT8U79L3U4ehz0J9mclEUnDjbWdXuzKcbz4OEWw4lU+mQOMApUpAJwseFoLFVpBCjOxsREh8Y5NV7CBj3pDrmvJuIYSTaRuJivqE7fZkZZF0gylctrpZa3Hp9qErycNpjNhxiFlSMpoN7UncfjjOVH9S+Adky9mvagWFt+q0aZj43grlcI9/s4yJSIO3snvmGaEHj02wZYyLD7D/RW2qfLW6OIQKaP6KWCtJmYPplTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CH3PR11MB8702.namprd11.prod.outlook.com (2603:10b6:610:1cb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:15:22 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 17:15:20 +0000
Message-ID: <54e59b28-db7e-440c-8a37-00085945b785@intel.com>
Date: Tue, 17 Feb 2026 17:15:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/27] net/i40e: remove global pattern variable
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <8602d4158b18913dc7d1be64224013d11cae9661.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <8602d4158b18913dc7d1be64224013d11cae9661.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0223.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::18) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CH3PR11MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fad95c-cf31-4890-924a-08de6e48210f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2R6RVBQWmhFcit5MzNaNzBzUS9BZ05HRUFEckdlZ2VrZ2dvYWw0ZDdaSnM0?=
 =?utf-8?B?SHRodkdXUHhtZVVxaXFUUHVIb0M5N0NUVXN0cjNSTDVyREdCSC9FZFVTODJY?=
 =?utf-8?B?M3lGSlpRK3lnWTRXVmlTMkNVYXRldDMvYU5UWGlVNFNBQ0JKMml3UTJpQnBq?=
 =?utf-8?B?S0VBaFBOWWUrUk51ZEJPQlliUDRzRkZrYU9IY0IxcFE4TDR2R2lMcTAwWlFK?=
 =?utf-8?B?bnZCZWhEOVNtRFVJd1lvM0M5eVp4MmUraVMyZFdUaXFvV3B3ZDhpalJjV3JH?=
 =?utf-8?B?VW84UVI1VS82ZmEvYlRtb2NHOVJnNE5Ja3RyNHF4MzZsY0JKVFVuaXFrM1lK?=
 =?utf-8?B?aEt3cWhiZmMzNWJNN1o0MTA3WE5UT2xNTFMrRGZQaHJwL281a0FWVGpkZkNN?=
 =?utf-8?B?TTZyZll0Z25KZmlMbXN6ZVE4MVJDS3p0SDlwYTRSWUtSRUcwRFFtVzlONDNV?=
 =?utf-8?B?bWdONExZOXNnWlRoamxwWlZKd2pIZkRYM253OW95S2ZPYXcvTWNyQUNzTTI3?=
 =?utf-8?B?QlBlZjZ4SUZtUC9DWkppWVByOFlYbUFQZjdLcXZDQzlvY21iRDgvd2ZWU21m?=
 =?utf-8?B?RnhDYUQrWHk3VWtLTmFEVlJveWRkbGhlVG1wMG84MFJzQXBFekNKbDZ3SlNu?=
 =?utf-8?B?dkVNRTdPZm9DQUhqMEpCT3pKTnpKSk51SEdoV0pzSko0U0x6Q2hEakpwNkFu?=
 =?utf-8?B?ZmQ1T293UUFML2oweEhLQU1LTmJxd2RsTDErK3NkZTBiVTRDZDl1ZDBYcXEy?=
 =?utf-8?B?dDlBMGc3bDBUTTdRRlR4MVhpWHVWZFRtMS9nNGJnU2t1SDJmUWgrNHp5Z1Jw?=
 =?utf-8?B?bzhLMWNON0h1RGVEU0xkWjVlRVkxUmhIS1BRMldvVGVIU1lwWXhCSkdFZmhC?=
 =?utf-8?B?TDlNYW5ncmZpcmc4OVplK3VORWUvRzRNRGZjOHNtVDNZM3RGdXpPS3piZ2p2?=
 =?utf-8?B?UWdjd2J5cENqbllhMnVVSnFNeUlpMSt3eWVYZFN6WW4zWmcxdExhWjFFQ3lm?=
 =?utf-8?B?bmlXWmdrTlhodmVCczl3K0ZFSnJ3SkRQWEFxRVluZGh2V1hUbktXWWhzVWw4?=
 =?utf-8?B?ZE1XOUljR3NQL3JRY29MM2JzaUNrRndtZHc4VDhwaVlSTGVhditVcVFtTlE1?=
 =?utf-8?B?dDhMdE9XTmRoNXdlQzNyL2dsSDdMNFBldS8rM0dvSXNNVGtLMEdXdXdXNlRX?=
 =?utf-8?B?TndKNnV2ZFpqZHJkMndrMkF1M0FXMlQzUkViNmIrVmJOd2srWlpoMjUwUlB5?=
 =?utf-8?B?bTVEbkZ4YjdyWWxhdGJXV2hHdFBObXRGNFRoYk5TSStuK21pdFBibGZTTnZq?=
 =?utf-8?B?eHBWTVhwdnlXMmFabVh0dEdWL0VSeDdqaHJJSEhITnljcjhqVEpNTk5SOTBQ?=
 =?utf-8?B?Tnc2ZkNMb3AzTFNwc3FxK01hRTNPa0dQNU9pY1pXcTU2WW9iOHFCa3ZCcHRp?=
 =?utf-8?B?S0VhK09ZK0JoMm12NmRHcnJoQ0tKelV4RTA5YUh6T2owZDQvVVgyaGdHekRn?=
 =?utf-8?B?OW91UnI3VmJSb1JJU1VkTndzaEcxQnp3akJ1cEtUaGk0RmRMZmF4ZUc4S2Ez?=
 =?utf-8?B?bnBIMWJZM2R4U3FvejFMUk4yRXoyMTJhcnRNRHRuMDI4b0QwTGY0UHFJTWlR?=
 =?utf-8?B?TTRMeVVrZlpEbnZ0eHlkRjg1NEJiMlhLWWV5OUN2aFJ5eHB4amhrYm9BeUVR?=
 =?utf-8?B?aGw1aldOMFJDN1gra01VRzVWeXh3WGZwbmZlTWdiN1BWa0lyMi8xendRUXBz?=
 =?utf-8?B?QjUyeWIxa201WTRLZXd0Q3J3Yk1wdVB3S0NSck9tVmxOVnkxeWxiSEExSHdw?=
 =?utf-8?B?bWFNU1UwMjJzcE82eTJqWk0rSnRmcWU3ekV0T0pHY29oY1hGUGFxOHdDaWJ2?=
 =?utf-8?B?QjZHVmdNQnhSYkt6NTY5clA3WWZ1WiszVEF2SmlsdUVmVkFlNE8rUzVxNXds?=
 =?utf-8?B?T1NYK3I1VDdpbmRjNUVxcFhQUmx0eHhlWXg1dVhlOElYTVVBMFNMRWowWG1k?=
 =?utf-8?B?SktLTjhJV2FIYnJGUFllRjJBT0t1Nnd5aFBPM0VhVmxHaHpCcHU4MEJoMVN0?=
 =?utf-8?B?c2c4Ui81LzM1bGNOTHVZdjd5eGxETDFuYmthSWViRjFqUDROTnhNa1pXSjVp?=
 =?utf-8?Q?0Blo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmlWSUl3SVlCOGUxTXhwMFdab2gvNm9BL1RGc3lvZHd3UVJxYjFTZFlNb2E2?=
 =?utf-8?B?ZW83dVJaSDJVeHZocEcvYjBtam1vNk1HaytSUUdHanhOUUVmNVVySTZscXBs?=
 =?utf-8?B?T200c1lvQXFCcytGNStZR3l0OEJLa1daT1lxTUFaditpclA1TG9EMFZnYUor?=
 =?utf-8?B?OXJWUHQ0UzRYb3NZYjlDWVIybFM0Snk3M0dGU1hiRGlmT3dHeCtDanZBajlN?=
 =?utf-8?B?MmxseWJYcm9vVjRZZC9FVVFDMU0veVk4V0luM3hSZ3pGSGxya2Y3V3pQL2F0?=
 =?utf-8?B?RklIVTlRNDNuek5TRndJSnp1ZW1kWDdRNTNLbG0xU3JYWTQyTDhhby9tcFF0?=
 =?utf-8?B?SlJnSWZkclpkQ2dkSWJwN2QwRml3YjVkK0dvbHVQVS8yMFpZUjhOQndTbk92?=
 =?utf-8?B?d0IyN3ROT2hSYmlUVzNFaGJuUWxUZnlydWo3a2FpTE5kNlhOblBkWUZTejVM?=
 =?utf-8?B?QWxKZDlDc3Zwa1pweDgrL3RJOGhiY3N5eWRFR3ZTK3ZMNFcyV0xvWDNvR1Aw?=
 =?utf-8?B?SHFNbnpFSEZVelp4MXpYYWY3ems4dUZZYkUyaVE0T0MwVFI1OTZKVmZvUGlQ?=
 =?utf-8?B?aDUzQkRjanJPWHFsbTI1cDlEZWs2RFdwOFIyeDU4d2U1dkI0MDBiRUFMNWc0?=
 =?utf-8?B?K0pxeTRrT0xhbzFPQndaeHVYSjA2RVVuOEJYTnBFNTZVWWFJeGhSblBxdUVX?=
 =?utf-8?B?Rk4yRzFQb3ArdVRUVmxWTWxtV0sxQmw3MUxLd3N4b1hYeWd1NzhUbHNCWEgr?=
 =?utf-8?B?QzZMR0hlVG13RS9YSmhqK0lSRG9DR0k0c3lNWXg3MTZIWHZiUG9oYk9ac2dy?=
 =?utf-8?B?NW9ZUHlPbmxkOGpDS0VFOXFvMUZOMEc0Y3h3T3EyT0wvY3RmTytobXRDRTZ4?=
 =?utf-8?B?M2lyaTVNTEFBVmtRSFIrME9vM2lXRno0VzVaZENMcmhhN3MyYkJyZEtwRmpi?=
 =?utf-8?B?Ky9hckdOdG5rSmhYYXpwTG9SMFRvbThyVEpZTGlOM1VjTmNrQmtaS3RkTjQy?=
 =?utf-8?B?OFhCcEN2KzVGbjFJbE9SMlgzWEJRU1ZpdENPVkNDb3RWcWZRT1oxRndoTjNt?=
 =?utf-8?B?bVBpMWZMZXRVamg1cHBLNnZSc1JVSW1lZjA0RkxPNkFFTUR3SnlpU2gzejlu?=
 =?utf-8?B?ZDFXNk1zaWFFMDBNcXhnRnRGUHc0Y0VQZ0tzdWdmVTYvNWZ1OGpRMjYxVXBx?=
 =?utf-8?B?S2I1UnV1cDArSVZOaGgzOHViVGd1QWlOUXpxMEhRQk9nNFprYU95L2JBVEdI?=
 =?utf-8?B?TWJmaE1WUXh5VGFWYmRXb2MvUEw1YldSZTIwSlh3NnNsUUd2aUoyT3owdlFn?=
 =?utf-8?B?Zys0QnZMN0RETC9CSy85VDFyM01VM1dnSUFQOGpUQjhzL0ZDQ0JBcU96d29o?=
 =?utf-8?B?bjcxUXVnS3VGMlRuK3E0NWY4bEUyUHBVNUlWaFNnUERQUmY5Q05BS1JjVHBz?=
 =?utf-8?B?ZGpyNE42S3E2S0drSlgrVFc2dDl6SndUNTQ4TThXc0VVTExHYis0OTlsaEp5?=
 =?utf-8?B?cGNyVnNCVWt0MlZTK1F4K1ViTjFnSUNFMExPWVhhVzdNQ0l1ZGtkdHlQekVW?=
 =?utf-8?B?M2tXRjkrdFN3cG9UZW15c1cwN1B0elZpRzN5N21VaU5kaExFOGhhV3plZkxp?=
 =?utf-8?B?Mm0xWUtNZTVNRzBCekUyMDFaSVFHSmREMUhtZkQzNmpXSEc3VGk0Umg5c0VM?=
 =?utf-8?B?S3pHVDR1YUMrd1ZKRWo0UFpMMGJVNUJXczd3bndJZGg5V1V2MkpFNHNVNVg2?=
 =?utf-8?B?TDQvckRZRm1PZmI1VFBnM05jQytnRG13SzU4QWNpVUtsMkdaSU1XSGtLRVVU?=
 =?utf-8?B?WlhXM25Lbml0NFh1QU9aTlo5ZWFpMUxCc1VpcGFLSkJVR0lVVUJHbm1DZWJF?=
 =?utf-8?B?UUNuVFB2V1I5Zld3cDJlYzNCNnVrY1pWRENveDFvQUQrQVhOYXBkMUJ6YWNq?=
 =?utf-8?B?UFZMMGhIOWI1aDYxTW9nVG1tTStIc2VSa082akZiRDhYdWE0dTNmWVRVWXl4?=
 =?utf-8?B?TTNrK045UWduYjk3UUpaa2tNbW41WE8rdm1HTFNjWlFiZDJMSnlsY2tNNWpF?=
 =?utf-8?B?MkF5c3IxbFAwdWk5M2loaThZVTRTa05uSHM1N3RoNjZJdHFtNTdaWkoxTlVM?=
 =?utf-8?B?cXFDNE5kREFicUdIOUNJOUQxUzR5MUVHWGlZaHRQOGlaVEhaNm1ZMkhGRkxh?=
 =?utf-8?B?Y3BCaUxDWEcyQWVUcVBsUUhpSVB4alB3YnA4OWRKSEU0MEdCb2FRUVB6NXhZ?=
 =?utf-8?B?WVJ0UnhSczd2djkxY1lOUGk1QnBXTHo0MTFVOHpNVDFtcTBHZTJ6Rm5JUHFk?=
 =?utf-8?B?dndLL0J6eHYzMGljUU1sRHRUb254Y0pBQlN5dXB6K2F4SlBUKzJsT1A2L0xU?=
 =?utf-8?Q?3WO1W/nrugqvIHu0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fad95c-cf31-4890-924a-08de6e48210f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:15:20.7825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blj3V7tbJWTLr5GSOuBrq3tnDQXwsIps/soxUCcoGxiIPw7tfezvhnQZ2Nc7CHdsSYAIWFvbfcpxRutE8EFSTnonXZf3OI6IEwDSgg0nmq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8702
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> When parsing flow patterns, current code cleans up the pattern list by
> removing void flow items, and copies the patterns into an array. That
> array, when dealing with under 32 flow items, is allocated on the stack,
> but when the pattern is big enough, a new list is dynamically allocated.
> This allocated list is a global variable, and is allocated using
> rte_zmalloc call which seems like overkill for this use case.
>
> Remove the global variable, and replace the split behavior with
> unconditional allocation.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_flow.c | 29 +++++++++--------------------
>   1 file changed, 9 insertions(+), 20 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

