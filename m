Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF0EB4913
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:19:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 234584042F;
	Thu, 12 Feb 2026 13:19:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 68E974027A
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:19:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770898751; x=1802434751;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=VnQ3od8/vE2KSRcaEwuVb0i4CWzxcKILV/DFZbIzC+Y=;
 b=D2PvcxLYxnbDCgq+/jOJYK3kpeg4srb2Q0BsMJGRuOEDNyfFxGN5E7PL
 mtoSxlTy29Y073wsw27Rf0KCTOqcyiVAxw2Lrtb7e+yiw1pOgskR/Q+EG
 8WyrGTPnnFcUg+R1gw33SDSjD08MOcTGMuKnJV2Nim8s2Ocf3H0wQwvQk
 KKCLthJDRBpa8wuKNPbe2C6QD65JVdVs+u8ibXqBpay4PdcX3YJBRpDBx
 eCVai8oyGjyKBQOnL+DhwieMFBzwjxOfx78E7cqATUTSZOw3wACIFJSHu
 xxg12qFVsBstrZ9QcPaSsp7k7mUCvWE1e9cRMsGhGpetCWcm+1E7CaX6p w==;
X-CSE-ConnectionGUID: 6HxyWoFsRh6bpoRC3SjJwg==
X-CSE-MsgGUID: TQM2SwOWRpisglWEhmJ5pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75912062"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="75912062"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:19:09 -0800
X-CSE-ConnectionGUID: R1QH+cW6ThqQjW8utsvUUQ==
X-CSE-MsgGUID: 9QvUsO1kRTSAGSFW3Dhr7A==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:19:09 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:19:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 04:19:08 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.46) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 04:19:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFTyXP/RT/rYb0jwr/nmd+DfgsoOs9No0hO4utykQZ6AY7CP5rNue7aGv7BFgfhmTgHr5nUqaZ6vX7GP30zEha2OysxEfaZx5cZyyewhKkn4fiU42HPelhB+ubRSPxTAcy2+xOUrrrOBQVAg+Z5bhXcGt5QYy88TFRaJwxA+c2nzB31zAv4DXhfY2uPjS2OpdKeZ2dj1d1si/y09EWcEgPFYh8SOeFqMYtUhfH7L5Iulc4vc73AXv5oXGmYYtgvgj8EN+e5e65xJo8icFIX4kL0Jx9QpL10z3SOeQjgwZE8lkV8DxtY2RO0+njVQfADIlRtmOK2fe8f9wClQo9+ILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgwJHxTk6WlPPQ1YJvhwquEkgzKheVpJyXc9mruiPWg=;
 b=oCv7M74zEgKD3yQxkV8iNm7Lyl2/y0QH+HnSnc3TeD3wVa0jd4jX7zj/aqVNpLP9KVaG5P6hcSF2H4XCiCc5lDOji5A3ZNzsknTXnwJtYzF6Sj2S7LNqFXVMm9eKTbOU//3FUJT6RRlb04G4u8dxx2V8MmNLvdHtikA5eWnXIKBsBCgHksDeEbCqU0h+PeTP6jOerHGywJDX4GJxPKUQPnuExZDZdn6EyJNOsWOarddlxVg8FaE0q3wDdg3qM/0XuWzSNc06Vy+ef+SgnhiryCRnQujOVHtKz7wW9MwW3Zc2NZIU52oeGsZFDFlkB8PwWMxUgpuwPgNo3+ZiErM/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 12:19:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:19:06 +0000
Message-ID: <ba9adf46-f8b2-46a5-89ae-d64b01e39400@intel.com>
Date: Thu, 12 Feb 2026 13:19:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/35] net/i40e: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-9-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260211181309.2838042-9-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0337.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c310f8-a131-43c4-9163-08de6a30eaed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTA5Qzhjc2U4dGV4a2FOQUlscHpNSU16QmlSV3lGOGVoWXQyM1RuNFdXZncy?=
 =?utf-8?B?S0EvZHZJT0ZFbWRyNE90cjJNVzZmTHhkYTllTVE0VWUzVEgvWXJxZy9JZmI4?=
 =?utf-8?B?cUx1YVVJb0tZUXpRUmovczE2Vlp4Uk9KRlF3eDVvZGFqU2JjdlR0N0xVRmpa?=
 =?utf-8?B?MkxwQUJxRlplM1NzM1hxT1psU2N0MFpUL1Z2RW9ac3RwL0JoT0xsd3VJeDhY?=
 =?utf-8?B?cER4SEJEaDIzVnFRYkYreHFBbS9FTDN3bTM1Smk4OHpTcy9tdmpwU3lvNEVF?=
 =?utf-8?B?OU9uR0NVaDVuZDA1WWlPdlh4SEp3a0IwS2xyaktLQTJEUXh6K2sxVnJVZGN5?=
 =?utf-8?B?ZmhudmxOOG9uVTBmbkc3bk5TRkhhNEptZHJCS0dwQUdqa2I5WmJsMXRWdlp3?=
 =?utf-8?B?U0dTclhmWnBOVlkrbDR4VmtOemF2VXY0SHY5b2xtTU5ZYnUvSUhiSnlZaWFQ?=
 =?utf-8?B?UUIvcjFlYXlWOW1CemZzQW1KaEtBUmJ2UUJqbWZDZlo2Z21IR0lrYWQyNkRt?=
 =?utf-8?B?aVVOaE9BK2tkSlVFKys3Rk8ydmtCUDlVYjNvY3F3SUM1U1JYMG1oYXBNeWVq?=
 =?utf-8?B?RzQ1L1lRZDdRd3V2MjRSVVRWdWpmb1JrcGlGalJGTGd2ZUN6UU4raHpLVStJ?=
 =?utf-8?B?VS80U2s5akl4UXFxNHBPUEVpbS9KamNpS09RdEVTWFhrcFdzcjZRd3FCVTNP?=
 =?utf-8?B?cW1VNnFqSFRXNHhOeXBnMzRqVTh1bzhyQVFMbFBuN2xMWU12MnczZXYrM3Vw?=
 =?utf-8?B?OTREUUNLb3JUU0I2bUx5cSt1bDFmaVNUQTVjMlhpdEpVYkl0dDlwK0pBWHBM?=
 =?utf-8?B?aFBvWWFuYjkzMlBIMVNuQWx5YXJxOTZjNTNvVDVmOWQ5R05DeGRHdGh5TVNw?=
 =?utf-8?B?S0hUZzUrdHRUT2R4ZEtzS2dxWjUyWFVjLzJvZWR3a1dJM214T1lXUjQrWW1H?=
 =?utf-8?B?SVlza1hxcUJQbmZDQ3dHdnhMc1BoRzhWY1FHMUwwSXlJY084VFk2WTU5Sjlr?=
 =?utf-8?B?d25NV0tnYlIrUFd2V1o2L2lqTDgzZ1Bpa3k0VHVEUmN6Ujl3MDl5aDJEekVl?=
 =?utf-8?B?Mml4UXlnRTQwMlVVdUZlWmFFQ09QemtheWR2MmF1RlpzaGxlQ0FzVmM0b1hZ?=
 =?utf-8?B?V3hpVDkzN0FLd21JSzFsakJ4aDdJQWlKeDhiQ3Q5cm43RjRHWUJ5RnZwQnc4?=
 =?utf-8?B?bUxJSnZHcElqcUZlMHNHTU5hVnk2NmpaRUpQendQdmhOaUVicFpZaGtyTTFV?=
 =?utf-8?B?clZSS0pxVnpnQnpCQUdEV25oWjlRTU1JK1ZjOVNXc25Sb3dXbzlVS0N3ZzNh?=
 =?utf-8?B?WWhGVFNnTFlWOHVjbHgrb0tSRHNxMEM5enNFK1duNGZoMkZnK1U2YU9CT3Ev?=
 =?utf-8?B?cGUyeWh1RmNxNFBnbnJWMDBiV0FVZVhGY2U1UitaWC9XcDlrYW80U04yM1Qw?=
 =?utf-8?B?TFJLdGJXT3cyMTBwV1ZtMnFGZXV2c3J0bzRwS1R0T21zdThKMTg5cjJkcC9U?=
 =?utf-8?B?RUN2WFd6Q2RTdjBDRWY1ZDRoN2FjVnZIRGxuRzM1eHBJT1hjQjVDU0ZKTGZu?=
 =?utf-8?B?V0ViSHEybW1pNEJEWUtZMGRXUzcyZEowVFd6blBYaEQ4OFpKT2FnNFJIL3Fz?=
 =?utf-8?B?YS9Jc0grV3BmbjZrbnNPZDdmMDYvVVRhMGxyNWdmMTBzbExNTHdLdytmM1hS?=
 =?utf-8?B?WCs0dVJJbmNUSjV4WThYdFhYY2NKT1V3L3F6ZEhDcHhrbi9pczE2ZU92bDV4?=
 =?utf-8?B?WGxFYjI4YVJ2Nkc0M0pMQ0dqaU5yOUZMaDQ5WXp1aWZacTNEdEtjR3FFVVF4?=
 =?utf-8?B?MWg5SEVEL3ZOekR6dG9zazFDWXprTTYxY2U5dHIwSTFMbzVLOG43QXlhTUZ2?=
 =?utf-8?B?QlJDY1h0dlR4aDIzQzB3QnZ3cGxrT3dBamg4b1BZOEtpWU5uNDI5OEJEMWtW?=
 =?utf-8?B?b2RPeWpaOFlOUnVqWVBDNm9sOVlWVzZjbm14NWZqVkxqNXR0YUliZXpXQ2xn?=
 =?utf-8?B?dVdrVHpYbWFLV3VMZVJVb0J1VndjVWhEanFCQ2k3YVdtSXlYWU5kbnVtSXVv?=
 =?utf-8?B?WGdXTDZxVk1WSGN5N2hZNlAvVUNhbGFTVTZ1dmp2dWkwaHhPNEp5aCsrQXll?=
 =?utf-8?Q?Y0kY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlNDVUZkZlBqbEYxeGdIRHpLTjZ4VHg2OXRpaTJod0UzdHlubkczVnRCaTk1?=
 =?utf-8?B?RGtTWnJ6WlFLVnlZY1F1R09vZlJPS0JlTW1LVlNNc1Q5V2FWd3VHRUhqZjdK?=
 =?utf-8?B?MFhqR0hNZ0tkNGloc1BranoyUWxvL045ZUVISGNkdnpEYWpwVW55clRVa0RM?=
 =?utf-8?B?Q0piejNxTThYQlRCcVYveFcwUWdreEZFWHRDMGJqNExWSktvd3o1NzNEVWxD?=
 =?utf-8?B?d3ZNZ0hHMTFOMG1nTGVqMUdEZUpNU1lrYkk3bmtHT0QyZkM3d3l6aXBHVzZC?=
 =?utf-8?B?V1R1THdQQzdFSUdENDlxcUxqcHpscFZ3VFhDcy9EUDg3VzNMN1RLaHkvR1dq?=
 =?utf-8?B?RWZPTUZ5TFJaTDNUT3VwdWV1S3E1MjVYWDlQRzUrV0ZQYi9RSXl3RzV0ODIw?=
 =?utf-8?B?Tk5DQUpCcWtKYnM3RmxoUDI0NllHdWowSDlaS094aFo0cFhIN2QrN3RoL1hP?=
 =?utf-8?B?ckFrWkdRM3RMT2x6MU82ZDZJOUFFOHFsdjdkTGczRDZlVnBrRDZoQ0RNY3RB?=
 =?utf-8?B?VWt4S2E5WEphcDZGZmxEYW05akE0aVorK1o3cDdUdHFKVHpFamNpMkhOaHN0?=
 =?utf-8?B?aHhYeDcwZ2czQVdWbjF0U0k1aE9GblZ4d2Q3RlJXdEMrbWRIWlA4Z0tiNVJF?=
 =?utf-8?B?amZpWUVCWkZsa1UzcnZ6ZUQ2UzhJRUJmeU1ZQXpZOTN6dEVmcy9TWGU5ME01?=
 =?utf-8?B?UC9Va2hpODR0V0xpR2FmU1JOVXVNUjgyS0Vvckl5VzdtZlIrR1B5WkJnMndn?=
 =?utf-8?B?cGVYLzJIQU5nVFQvMk9UQm1GL1lmSFZtVGlUS0dURUhMeXNUdERQVmR0bE5L?=
 =?utf-8?B?TlJNT29VMVEwa1FNMDYrMXdaVksySTJ6MTRNZ2ZOYVFvdkFCOFgyY3R0Tll3?=
 =?utf-8?B?c3luTUJ2QnNpWWxwd0dITXlXTjRISy9RL1phYkFCYkFOK2dicy9LVEJxakZ4?=
 =?utf-8?B?MEFmWXZPMjJqRm1UVG5UOUZ3MG10b2dqc0daY3ZEYlN1dHpPUE51R0FaY3lp?=
 =?utf-8?B?dWtZRThBZEJvKy9UZENlcWJ6Zi92M3NVcXVDM212NVVaQlVBd3lJSzl3dHVs?=
 =?utf-8?B?UHplZThLSDhFVS9JVGlHdy93VkhsOEdYTFdyVmlZZVptWkFGWDVjeGFiTUla?=
 =?utf-8?B?ZXNTa1ZISHQrcjI5bHE1RXBNU00zeTVvaWJyNkJpTk1EZDNwRlR4cm51WDF1?=
 =?utf-8?B?YUMwNmQwaG1STXB2V3EyaGdvcDVtbkZsTm9GVCtPZktVdHVaemh2M3lwaTVt?=
 =?utf-8?B?R3VxTjhUeXA4c0grZFlTaDFDdHRJR3ZkR1pIaDFicFFnUVhkcTFLdVdjVDI4?=
 =?utf-8?B?dnF5WmdxcnJwRjZobGdDRjYwQ0RHZHYzVnZXOVVCcmdtQmtqSkJjRmhHamJ5?=
 =?utf-8?B?ekRQRS9sc3ZSRGNyL3o4bkp4b2M1ZWQxY2tBY1R6a2dTYWdSM0JHOFpTaHBz?=
 =?utf-8?B?U1lVRDd3bFhNcExsSWtSZHNPbXZoOXpNQzVCQzI3RHIrNDhWOXdmTGZ5VHU1?=
 =?utf-8?B?bmI2TVNQdUowRkhXdzlzeGJUM0VqdURGaUJUd1F3QXNXRTdCN0s4ZkRScS96?=
 =?utf-8?B?SHBOS3VLYmM5TUFNT2E5Tjh3YkhDZHhvRnFaL0RtbC9nb1Y4Yk9EY093elI3?=
 =?utf-8?B?OVp2cGRMeEhDY2FuT1RsQklqQUdPWDNxbGNBcUlOQ29FNG9JN1NjdUhWOWNq?=
 =?utf-8?B?aGhZWXJtNy9kRGEvY293ZmtNZS9kOG50Wk9RUkdTUWhwbEdBU3hybTNLZkFv?=
 =?utf-8?B?di9kNlJvNnFDMDEzdzZMcWNHN0o3dFJjdGxXekZ1U1htdHJRZzBOZjNGbW96?=
 =?utf-8?B?cUpVbW9DYzFhaVdXMmVMbWZaRlRUNy92cnUwSzBoWW1iMVBaTUdpVldBQW9x?=
 =?utf-8?B?MXNldnYrSE5RYlptaTZlaFhTR0dXQW0xWk9pSUc4dUdxNFZSMkpvTTR5NFBm?=
 =?utf-8?B?Rk56VHY3a2RLTklHdWM2QWNGcUwvcVRsSktwcVd1dit4ZmF1U2RqS3BDN3Vx?=
 =?utf-8?B?amhKZ3pXbWE0THg1TWpaaHFrb2NXV0s3T1Z2TW5jUVY5YUp5NHpwbEFNTGlp?=
 =?utf-8?B?U2ZVZ3QxRFZ1bC85cHFnZENuYzJvZllqeC9pMzJRemdTQnJkS1dkaVMyWmJV?=
 =?utf-8?B?cmZYYVJFM2UzZnV4RCt4S04xSmR4MUIyTHV6VG4vY05LdDdqdHJpbFJud3pL?=
 =?utf-8?B?dzhlWFoyVm54ZmxoTWlJOHVvd05pK0hVcnpBd2RjRzUxZnZ6R1hYZG8vRDl4?=
 =?utf-8?B?UWJ1RzJONnQvUElOcjFoWnJWNnJCM3IvQU9UTDZaLzluNVVPN1BDWHEwRjFH?=
 =?utf-8?B?amFIYmw1YjlGbmRnUEhOTGlpcTNVdHA5R2puNVZhSmJxVFRCTldwdjZESXhE?=
 =?utf-8?Q?uov3fCOd66h7jQps=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c310f8-a131-43c4-9163-08de6a30eaed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:19:06.8110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFFEakDAlNyNDOznZ+ciaj7YVjip7e9w11BgZ2jY3VdmeFFmugOUTa6Ha8q9OSTH5AfnAekdw74EsbPGfCBSPhZUpUeO6fQj1JhEdV+8hJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
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

On 2/11/2026 7:12 PM, Bruce Richardson wrote:
> Move all context descriptor handling to a single function, as with the
> ice driver, and use the same function signature as that driver.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
