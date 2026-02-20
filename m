Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325AEC55178
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 09:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D00C402C6;
	Fri, 20 Feb 2026 10:50:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 776F84026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 10:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771581020; x=1803117020;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=roamKUdzwj2ewb9mpEwIommQVse72HzJqPupWeLFNqQ=;
 b=QOyPMwR6ksR0ZeVt2ko7ZOn6D9pjrUKZODEi5k8QxX1wxgOEmk88BogO
 jKH6FO5UgWzgmaHpqyCg9cImwKqwsS6zZlAKa/C3V841BbWAxeV1tuGS6
 AjHYlgkMkMrMIAu5XEgu8eLG0JiG9aeogd3EdGmrb+c/74Hs+KizdJQ+D
 92a/F7R9EuIjxLXitbyVvyQUgn31iwEHxzF+BxBRUfzMnkUplBD+PPANU
 YV6gW0rIky6DmPqZpZdn5YDswqDn47lTy2LMxHci04/QJnLs1go/t0Y60
 kQ63OgXjuyUjcD+mBuAeRGoX1KtoXn6BRpJ8mI/t9SPOmU6noSXqD7R2r w==;
X-CSE-ConnectionGUID: EtYaGFJGQ2qSUmT55CbSbw==
X-CSE-MsgGUID: qdmXP9QuQ4qyGbDJeVch+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71878553"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="71878553"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 01:50:19 -0800
X-CSE-ConnectionGUID: rIkaNzawSNS4THNGsX/5/w==
X-CSE-MsgGUID: bhHmSsBHRbqtHBixcC5hhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="245387589"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 01:50:19 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:50:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 01:50:18 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.69)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 01:50:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzWJ9ha9yusEnmX6px58do87x1GgmsAzmh8gSn2fu7QBdX9Lr05lQBtsYGw462aSKUYfqXAolRtBJ2aCCzOV5E1IzZ+zGO6Aeuctct94TCo5H/ETs/QAx39d71K1HIn1Onpo7RSG4J+SuuhJPONE/rcVojynwD1rPMQfbKNOwk0ZW2uHr/xrwAWpByMXfEOD4j134ZAda+EEe7AdF2J2b/yOxzUbcCt2SK6YVt8CvP/aQPtfpbsDA1EBpFg9Wp2DZCeIS1PSyepGQmsg3jrP9dLGc3qB5NtXY6tBY0eLwqpczsCDR3lnXBA3G6yD0tBdNEYL848+0tHxIyPyu/cwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgE/3vqgWfnU4knTJCtV9oZkZOMi1PSyNwvv1+Bpaio=;
 b=p16xg6Zm3QkPgdZS+MSiSdy328pPTaDzQ1X7GyIlti2OGgjjck2kBy43FZ6XGFDFOrVZpMkEBg68t//vjhHnMKUwfqaaNYIQ8yI9Wc1zVN1qSu+lUTJ0NeaPSApD847AD4599b92UH8BewQbSyXydbDtXy8Lkkdr13JnyHg2QpV7EZg3u2TWTtdwkIMdQbdeZMtKVA8gSPiZlI86PH9W97L9HwnDjcTuZ0okoaw348AjydM/MDlG23wJaFz4k7h0hUSV+KpVryYqtO7sv0kWsyRSSnbA72RkB9EW2yTd48qWLxwlqb0sreM7GhNInh/0eXMEp1yuXb8luiKCB1fpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB5909.namprd11.prod.outlook.com (2603:10b6:303:168::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Fri, 20 Feb 2026 09:50:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 09:50:15 +0000
Message-ID: <f453e01b-3cc8-492d-a69e-18fe5982bf4a@intel.com>
Date: Fri, 20 Feb 2026 10:50:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/27] Cleanups for ixgbe, i40e, iavf, and ice PMD's
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <cover.1770646012.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
 <20260219110853.3852de22@phoenix.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260219110853.3852de22@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0189.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 321f9ad3-e754-4227-91c7-08de706572ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVNPNUNacnd3bmNQWUd2RTB0ZGpLdXFiUGJJSXdRYytENFBFV3ZRYnJ2Wkta?=
 =?utf-8?B?cFMvOU90UkhpZ056WTBjU1l6MkJRZ1RNMkJKZk9aNUhOQUI3aWkzRFA0bmtP?=
 =?utf-8?B?cTJZZHY2alNST0VMb0dDSFFOS2ZodVdKTmlGaVZiTFNqZThvdUxpVXJhTDBi?=
 =?utf-8?B?Y3ZBeHowektVOEVvaDRuYnlrWjhOb2wxRzRWTzhLZHZCSkVsMmVMbTlMVEdz?=
 =?utf-8?B?OVBNMkVRRXphLy9JQUozT2hjWWg2QnpBbW5QNlJKSi83Z2F1ZmZ4MVZ0TUJC?=
 =?utf-8?B?STRUVktFc2tFbTRiNE8wRGdYNzZLVzcrbmV3RmJWSEhVbVJITHcvSFo5MFNP?=
 =?utf-8?B?N3V4eERJcnhwVmN2SkZGVGxhUnJRTWIrdy96aEFzN3ZRNllGUGg1TXg2NFlF?=
 =?utf-8?B?RFUzTEhiUXorYVgxOCtFMnlzT2pNUVJvNjFZMElWUTRJYmc2SWdYWmUvclF3?=
 =?utf-8?B?MXYvWlM3S0E1bTV4R2IrU0gwZmlBYmdRMUVoQTI4Q2RMTnlqTXNlVFJMaWhB?=
 =?utf-8?B?Q1NKWUgweG4rVTRhYlV0Y2ZSQWlIM25rdG1zL3dTTU1nNXhvUk1zeG1ybjZY?=
 =?utf-8?B?OW9hU1BGR1ZIQjBDNnEyVmpCOWIzV2VwT1l3ZXRjRFN6YkFZYlRLeXVSdGQx?=
 =?utf-8?B?dkZqYzd3U0ZlNUJQNmI3aExPcER1WVFzSjAzbXBEREtiYnovT004RzNxamNR?=
 =?utf-8?B?cE5ndkFhek1UbmQ1OUtiSXA4Z1BHM1hvQmRtVlZNNyt4dmU3L2dSelNVSDhu?=
 =?utf-8?B?a2ZTb1hmdHl3bnFyV0R4U1hxM0NJelVnNFEzWVM1cndOS0NIZWM5UUI2a3M3?=
 =?utf-8?B?RWlRMVdtamM3ZTJqYVBORHo4NFcwalZ3amQ5L3NlQXg3dEpQQkNxYndrbitz?=
 =?utf-8?B?V3hkMm5DU3VCaDRqSnYrcWRIRFoxelFGUDJSNTdmMDNRYXc1Rk42Mnp2b1RM?=
 =?utf-8?B?Q0NMK2UxOWRNSVZ5bWVTcGR2MkRON1hBNXovWkxUWFdWaUlXWm5PeHZ6a3p4?=
 =?utf-8?B?bjlGOUhQZHRYYW52LzJXWXJiMzA5UkJSbzJWSnFHS1BRYlE2V1pkS3MrRnN4?=
 =?utf-8?B?RE5uRk5zM2I4SndkTEtzZk9BZ0lKUG9jdUxjUVJUNC90eWFSMkRvZldldE9j?=
 =?utf-8?B?VCt0SStUYWVOTXdjbSt6eDBRN0p5WXFtTTduaEU5QUlkQUpMdXFpdTUyRjdV?=
 =?utf-8?B?bFdSQnhubHNXOG1LQ1dKdTNWSDNvTHRoMTc5RG9nZlFiMlVwTVlrNEU1R01U?=
 =?utf-8?B?bkVVOGMwcjdrUjl4enUvWGVQUzROMEVKOHlQS2VSNVBJaGlTUG9pSy9rbGVY?=
 =?utf-8?B?M0I3VFlhQXlndjNMeGtoMDFxVlhuR1FPOVBjYkJOVGp6SkJqbk8vdHVZRU80?=
 =?utf-8?B?bDVjLzJwZ0owc0YydUVheHQ5RURaZkRmaWRmQmcxOHVSMHZlS2lyRWl5SU5P?=
 =?utf-8?B?dDVxcmNvbnE1d1FjUG4xbHpiQTgrWHdWbEJjN251alc5SVpybnFpbzdPdll4?=
 =?utf-8?B?VnNPS005MllnS2JpdExiMmE0Y2NzV3NNQkVyVVBSSldTRFdPYmQrdUk5dHVi?=
 =?utf-8?B?SHBRdkNIbGZrYVVMOUk3TDFIQXQyU0hyYUhqSEliSUxpVnJSRGJVajRyVEtz?=
 =?utf-8?B?dERJeXBPUUhNTERuUXZKVnRBeGtsdmZMZkRUcGxmSVNmcm5MSm8wK1VwMWF5?=
 =?utf-8?B?eStjaVM5MVpzcUo1OUNMUHIwUFZJN0VpMlBvcndjdkEydTRDYVVNMm04bFhv?=
 =?utf-8?B?RG5kbXNsb01IYjh5dDhPeEg5WEs4Tll6cmdMaml2N2U2RUVOdzNSYjFoanJE?=
 =?utf-8?B?TXF4STNJMyt1UHh6SkNNdmtNRlg1WDVrekNlekZsWkFZU3pwcmZFRUJEbHZk?=
 =?utf-8?B?ZC9IQUFDUWVlZmF1MUNzYXcrMDE2STVsY0lwZUpWYkZDcFE0OWtpMXZMYlha?=
 =?utf-8?B?MDdpN0NHWkVLallWbG9EWHJwWmVWV25nZmZROG50M2tHODlpdTNBS3dKeExt?=
 =?utf-8?B?a0JEaXkrSUZiM0psa2QzQ1FUQ3lKZ1ZtWUJQa0c4ZnRFOVo1NnhKSDJqN09W?=
 =?utf-8?B?UEhFRy9Ucy9hbTFkWE1oS2ZUb0E1ZGpwc3JIaGdSTnZHR04yTzgxdjBQdUdN?=
 =?utf-8?Q?4eZo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNXcGpSQUxUSzd3Q0VQVG9TdDY0TzBRR1JXRmpZekdFV2xvS0lCOFdLODJG?=
 =?utf-8?B?Y3ZrV2Q1U3BRZldDc1RiOFl5VmRHSDFjSis3RDVHNzM0OG1BakMxVjJUaTFl?=
 =?utf-8?B?VHpmeExIZHk1R2FEbGdPYlA4bFFwMDVCZVh2c3UyUTBKL2hDTU9EbGdpMjVQ?=
 =?utf-8?B?bTBUOWhvdmZJMFlvQksxUm1vQUNYMzVJR3FDYThCaUhYWnNaRjl4Z1VDeDhq?=
 =?utf-8?B?eE8zRTJYZkd3R3hGTUhFMldVYVZ5RkVrS05lUHNLWHkxdVFnN2VZcTZKWUlX?=
 =?utf-8?B?eTU3aTRIdXltclJ0MFhwRnlLZDYxMWR6d0phSElyc2FzTjAyUzZ3SjZ3ancx?=
 =?utf-8?B?c0pLakRDV1ZSOFhQRmlJbThEWTV0bTNJRk9HMEdpS21MczhQVEI4TERqQTNQ?=
 =?utf-8?B?UHVYUHd3cngyangrVHhSVTlGR1luT3U0QnRtRG9Ic1k0YlF4d1grUnBNQzZ4?=
 =?utf-8?B?L3ZvWlFyMW5UQllKaDg1dWxrSEFDdmlvVkxmSy9rZkljZWVNZ1FKL3FSQ0FJ?=
 =?utf-8?B?R1k2SEZqbEcraGNWdTBUSFFZVEhXSlpkNDJmUzVpVkI2N2t1YkVHdkJscmdz?=
 =?utf-8?B?c2pYaGlnU2IvQUtOM05kbnZmK3VGNlBlSWV6VG9XVFZCZkZHS0N0V3BiNkVJ?=
 =?utf-8?B?WkQyNStVbW9CQ2w3eW1wL3lCRHMwRlE2ekxyMjk0a0duU0dzV3Rxa3RCdktp?=
 =?utf-8?B?cldTSG5LRFR2Y0V6NDRsSFVkdWNHRGxYaGRVYWlxaGg1a2hKODFGVFNqbFZn?=
 =?utf-8?B?d3kxTjQydHZxSXNZYlljUU91ZnEvc003WWpHeXJ5akc4T3hNZDNQRUk1NHJ3?=
 =?utf-8?B?QnVCdzlhRDNWSndqekFiTlRINCtITDdTeGdLbmMrZTMzMjZqWGxERWpMS2xB?=
 =?utf-8?B?dGtSaHBwQjNZTHNYNDRIUHp3UFJ6b0NVSFVQMHRXMmZRRmRDQ0p5MnVEeFVk?=
 =?utf-8?B?aEFrKzljZ0VWSlFWUXJZSkpFSUtyeVlydjdnR0thZ0taMllyRlZTS2hrdG9p?=
 =?utf-8?B?MmlTY3ViM29seFdoQ0h4d2xzdlpVT1VDNDRxalRtTU5tbHVRTlVCbFpCTmpk?=
 =?utf-8?B?elUvdUtLRmxsR1R6djE0Ui9pZmw1dDIrNER6enYxSUFRYVlzT2pNNm45VTJx?=
 =?utf-8?B?alEraERFeXpncDlqQkc5VXpEcjZnelpWNUpKczlDcHI2c0I1OGhXUVRWSmdi?=
 =?utf-8?B?aDYzaUJrUk5aN1IyZ0pHclpjK20wYWR3TllvZG5OM3NMWUIwckY2NjV0Q1Nw?=
 =?utf-8?B?S1FPSVFkVGpSdklPeGpzaTFVMS9IdXRzR0crQWVRbmJ3YlN1NkdxcFNQQi9S?=
 =?utf-8?B?d0pyS24xT3lhLzBSMUhHTktOSVFRT1A5NUFnbExkckxFaFMyOWJJSWhGbmdT?=
 =?utf-8?B?Q1Z6RHB2VjYwc1dvN3Z1M2VLUEFZUnRDTHo0QW9HSnZRYkZLWExPZmtxWHYr?=
 =?utf-8?B?Qjk2bmtWNFBkVmRUZ1hJamtwNlhINXdGTzlERFBnd3hoMXJwbnllUW9YaTVL?=
 =?utf-8?B?ZmlyOWxyODVoZWpvWkp3ellUNUFrMW04bzhseXJFVEhNcnRkWmpTS1hOa2Qy?=
 =?utf-8?B?WnlWdHlWWkYzREI2b2Erbjd2TWQ0VElXYlNBU3pSOXRWVTJIc3lqUndBWFNq?=
 =?utf-8?B?QTI4OFN6YVU0NnFBMElDK1IrWUx6bkI5Mi9tcG5lbGNGYVp6KzYwK2tQc1Zl?=
 =?utf-8?B?dGlSclB0QitZcnJ1UWxIajdNYUdycHRNVG1MaDA4ekg3K2FreXRldklGM0Fl?=
 =?utf-8?B?WlFuZTdQd0tYdEluSWpWdW9YV1VZbjdqcVpNc1hHUEN4ai8rMjhJUFZyWDZy?=
 =?utf-8?B?WWE0NFhSb3hiQjlHUEQ4Z25vMk5tUjBLaW8rd0JZRFoxWlBPeTZod3h0RmpR?=
 =?utf-8?B?TkpWRW04UWl5b2puV2JWU0RwYVZVaE8vczN1d1F4N3Y2YzAvenlTeFMyYmk1?=
 =?utf-8?B?N1JXL2lJckhOeVExelM0RFpEVCtJQnVMd1NQOFhtcUlDZ1UvQU1GZHFhTVB2?=
 =?utf-8?B?b2l0RDJGbnN3bjhOUCt5TVh3QUtFY3pTeGVXMjhrQjdZdDl3dkJMdFYzelZn?=
 =?utf-8?B?d1lPZHdUWExoQmdWejFneXNTL3ZhcXJBUjdCczRXcm1OK0lieFFudkx5SUZh?=
 =?utf-8?B?T3IrOXJqZG9yZVFGaklTZ05XN1Mvei9kem4xSG1IVThZSEc1SWI5WGdVTW9P?=
 =?utf-8?B?aHlwY0RZeDR6c1dzMnNIRXdadFREUDdpM1prUDA4Zmh2ZFl3b3Rtckd3dWs3?=
 =?utf-8?B?U3F5Ym4vMUpGMUNDTFhrYTU0V0FyYTJNZkVCM2pwTVdKcHE0R2NZWlNhUVpt?=
 =?utf-8?B?K2RNc0gwN0VlZlF1T3JGN2l4RnUxV2xhK2dpNGdMZDdMUUlKaHJIM1ExV0tq?=
 =?utf-8?Q?rDb8PajU4hPLdXZI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f9ad3-e754-4227-91c7-08de706572ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:50:15.3611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SYnAQHnHV0sLzNE2oA/9CoFpSLUXYVhwaf9KLWmiXK4AtPJk1wtDGYPwXod8xZVu1h3debGe/ISNL4sIN34iHUfMdVFyTuRQ7ToTNhxJtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5909
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

On 2/19/2026 8:08 PM, Stephen Hemminger wrote:
> On Thu, 19 Feb 2026 16:22:43 +0000
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> This patchset is an assortment of cleanups for ixgbe, i40e, iavf, and ice PMD.
> 
> AI review had some observations here:

Thanks Stephen!

> 
> Patch 20/27: net/iavf: avoid rte malloc in MAC address operations
> 
> in_args_size is always sizeof(list_req) (full 64-entry struct) regardless of how many addresses are populated. The old code computed an exact-fit length. Probably harmless since num_elements governs PF-side parsing, but worth verifying.
> 

This is intentional.

> Patch 21/27: net/iavf: avoid rte malloc in IPsec operations
> 
> Pre-existing: iavf_ipsec_crypto_status_get() response struct uses struct virtchnl_ipsec_cap but the function reads ipsec_status. The old code had the same mismatch. Since you're refactoring this function, consider fixing the response type to struct virtchnl_ipsec_status.

Since this is a pre-existing bug, we need to fix it and backport it 
separately. Good find!

> 
> Patch 23/27: net/iavf: avoid rte malloc in irq map config
> 
> iavf_config_irq_map_lv_chunk(): double-offset bug. The loop runs for (i = chunk_start; i < chunk_end; i++) but then indexes map_info->qv_maps[i] (should be [i - chunk_start]) and vf->qv_map[chunk_start + i] (should be [i]). For the second chunk, this writes past the local array and reads the wrong qv_map entries.

Good catch, will fix.

> iavf_config_irq_map(): the num_vectors counting via if (vmi > max_vmi) only works if vector IDs are assigned in monotonically increasing order across the queue iteration. If not (e.g., round-robin where a lower vmi appears after a higher one), the count will be too low. The old code simply used vf->nb_msix which is always correct.

That is how it happens. The reason I changed it in the first place is 
because *technically* there is no "max value" we can use here that would 
be suitable to use because nb_msix comes from VF mailbox. We do, 
however, know that vector ID's *are* assigned monotonically and in a 
round-robin fashion, and in fact code comments indicate that this is the 
assumption.

-- 
Thanks,
Anatoly
