Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C307DEA811B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDAFD400D7;
	Tue, 10 Feb 2026 14:57:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 49F0A400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770731843; x=1802267843;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=bUotLjH7FjNFHVkPnnPJlRqytTUJPETcwBwEER9ZKrQ=;
 b=e/HJelS9UUb0bG2SiL2k/PdFtc2D5CT2WzMrIR1vMLwMUzso76ez2EAJ
 c5bmKSFsWTitG25pDs7dIWqT31+O2b5fSyeMcNOMkCSkbIo1+DjlMQcjX
 gdj8J+PcVTDSwRxSvM31rEYXPoM104otGwIHJK4/ZmOQCYPYZWMl8a/j6
 Hl9ww2AFZK5tohJqICjWjOjcd0vpE2rrajZdaUJ9YRIvT9Kgfk0d6VVkR
 cZR7swQMQ32Fz5wAjq/UPuwt5lXOHxLUfNDC/ccSQIT+gmh+YfmpT/jQ7
 PobxSQaXMNVWyNvPQw0DhKfn0T67LgT/wgHElVtiMxwMLMFbXrNemKce7 A==;
X-CSE-ConnectionGUID: O54mFBINSdiBIRM4+9nIUg==
X-CSE-MsgGUID: yiM1CAhZSFOFTOAll9aU/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71752613"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71752613"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:57:22 -0800
X-CSE-ConnectionGUID: XMW0HoXQRgCrm1+Jd+HhnQ==
X-CSE-MsgGUID: YT6ULQrTR/CSFPq0gWU45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="234899285"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:57:22 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:57:22 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:57:22 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:57:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ela370sIpgRGy8hhpxlzKNBglb9hxNw9y9yLXFtUNzGADDF6g4RJ0orRSx27G2wLH4drPjOoLRnOt05X8Mt2SXRcOu626NEAOEq7S4Kax/GEJ3dCyBTYJc3gF6ryYlyE6lnSr+ichXXQDM0kxTTtdKUBZtcTQuqN0rugf68Q1xtDUazlhuxzKLFelHKCoah9QhU3S8QwSpbbhHMn8MbJoxuHh1UOHTADYQC42KDNIl0U4Ze2xERWVYeHyswzBTnfrVX7uWQfuIEPz+oASQozaCrr/5ts2403xJoYOBw3XlkRVcZkjHpA+P6aH6oIa7pC3XsdSWhBsNOOnfRNVMGd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIU2elbHiW2BUZ5jV0ZGWhe0vE84fxgjkvxIwhGO5Bo=;
 b=JP0QhWjrhXPOBMyGP6niUJSbSlFZuoXXWRC/hI16JCHtx6MtXHQbeQHBVl+iryluNG8YuJGtPoGD+kxENDx9li8s4jwAWDRr2QjylX0cpNP1+Fqr33jybRKDFgYaRjhwAdeyqjmRzpE8+rmf+OCmOq8nYTTRCKMwRD5UPEifv+jDLxQaHD7fuqAI9pk1dWb52wcw0dGRZtZ4mPYNNqJGMPDxjlIxzFpBwY/yL2caKn2fsbvZ6mTYGOedK/J40O73gevyKTniXZK3xg9FZAo9NC5/aOcZsoCFIvTMJU6XEUzHmP0gj4DJfzIL4IPqF8ehwWEte/1gxWYEdN8q2K38Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB7806.namprd11.prod.outlook.com (2603:10b6:8:db::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 13:57:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:57:18 +0000
Message-ID: <18bec85a-8bc4-42e9-adc1-65b417eadd59@intel.com>
Date: Tue, 10 Feb 2026 14:57:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/35] net/intel: add special handling for single desc
 packets
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-24-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-24-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0287.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: a153d9c2-632f-4bb9-9786-08de68ac4d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXZrODd1MFRmQkNrdHI4dUYzU250STFKd2JkQU93YkxiYllKUEloRk5uWkp4?=
 =?utf-8?B?MXF2T3kzV0RBQVBWM1kxckF6TmtoSTRSN2J0Z092NHFUeklVWkZKWFdxa0hn?=
 =?utf-8?B?VUIzQXp6YlBQaThnVWRYUVcwZHNCOU1xTjZMT01sTWV4NzQ5QStqaVhMbitL?=
 =?utf-8?B?UUFPQVoyTjdQSi9xYWhTUWVwQkx3NUdZdDJYZU1NMENhSjNmbFNWcHdybnNh?=
 =?utf-8?B?dFJvVFJKblhlV0UzY0ZYYXdSTi9XTFNveGdFNWgwY0pQQVlFMW51Y1V5SWNR?=
 =?utf-8?B?OHlWUEhrb3FVcWV1aWl4bERwWFFPL0YrdjJyd3VTclp0U3FzRnNQU2pwMVIy?=
 =?utf-8?B?OFV2K1FRUU9pUGRMOEVEay9nN0t1ODlFdUdvWmd3REtNbHNGV0o1a253a0Ew?=
 =?utf-8?B?dXQ2OEhQVTFpV0taaGh2NFcyaU9PMUlsaVYvTEVjTU5YYm1ZSzV2aEhOSGlt?=
 =?utf-8?B?QnJVUi9mTjZKSnUwTElLYWxKRlhGVm9JMFU0NmpyTi82Rm9vUUE5N3hRaUlJ?=
 =?utf-8?B?SWhDc0tObzRYb1l4azJKQnNTWFhFSzVPcHc3dFRlMzB4NGdBRitOa2FDM2Nz?=
 =?utf-8?B?K21qckdyTGxtTkRXRVlrMFJ6dk5QZ1hQcDBMSURrMjdsRnpqR1cvSlFOekVO?=
 =?utf-8?B?NWhIWEwrcnRpeGt0aHNmNlhmREFiUXFlbHNld3pKTTlYU2R6bnY3b1BJaHMw?=
 =?utf-8?B?K3ZQa0hLZU5WT3liT0dvTEFabVBPTjZ2cjZUQmhmejZvWk15NXh0K21FQngw?=
 =?utf-8?B?WWlscGNmbURoM1Bsb1FUSzYrTXpSSUxGRDVyK0JuN1NiZXhGQldnTUZmRStS?=
 =?utf-8?B?VEttckRDTXhMaUd0a0F2VlJUL3J1NTQ3TkxuZnZkV1ZObzZvS0gwWVNIaFM0?=
 =?utf-8?B?d01DUVFmNzEwTldCZVlSRE5tNHpzM1FkSWRQUDdFU0ZBSmlYZ2hWVDA3algv?=
 =?utf-8?B?alZLSGpBN0RFNTYvWTM2MDhmR1pXVXMvcHRIWmRML0c0QXBnZHNZQ2llQzNI?=
 =?utf-8?B?ZFM4bCtJVTNpVXhyQStlTjZLSTVnZHhrNVNwOTZTMnNLdmRURUU5czE0VG5U?=
 =?utf-8?B?dWtPNVN1VVpCTWtscWtiS2RPS1ZaK2lGQ1JDeEdMQzU4cTZuaDN2ci9TSTQ4?=
 =?utf-8?B?d1RJdzlBUXVLOGVpMjduK3NTZS8wQzRQdnViRStnak1DdnphM1c0Sjh5SG8v?=
 =?utf-8?B?RzEwKzJYWWRZRDJEdkwvQkpUMHBCZnhFaER5YzJxRzhuWnVvb0JEajJUWUY0?=
 =?utf-8?B?QjBBK0pVbjB6cnhwQkVGekZETGhuSXNFK2txNE9ONERJaWpLMXFUd2IxWHBr?=
 =?utf-8?B?MWtsQ2RQVFIraHI0WDZaMFZLWXM3djJKWjJZSGlRUkZaV3RZU2lyTUtkYkZn?=
 =?utf-8?B?azFYaVhFMGtqM0o3U05DcnZLSzFCZmFRTnp4NHNIL05laFVQdXhLaGFnenVz?=
 =?utf-8?B?cXRWZEp5NmtZcWJsSVVRcEdETUcxZkhlTHVOd0liVlZUN3hCYnlSUFF3ZHVY?=
 =?utf-8?B?c3krQzhNVC9Wandyd1MwMzN5Rks0VWZONHdzSDVvNUVSRGc2cnY2TklMeW5W?=
 =?utf-8?B?ZGdrcjdGUWlxN0VsMDRRMXdQTWliWDgxMDdVc1l2RFA4cEcvZDV4THBvYTRn?=
 =?utf-8?B?YzNUQnYxWm9OL0RzTDloTzlDRHR3c1FhNWJ1cGp0S1dQYWVDWlNDWmdPL0Za?=
 =?utf-8?B?VGtlL0hBYkRldGp6Nmova2F6WFB6dzVVNkVGUytxeDNWaVIxNnNCdTdVTkEx?=
 =?utf-8?B?bzdITGo2Z2UyczlRc0hON1ZwT25kUkJIVnFySlNmZW5uTDZ0YXVhUisyODd2?=
 =?utf-8?B?OU90MldSV0YrdXNoeWU0VXpCdkorOXpaaHhLYlRNUHFCMk5CeGJCdWZiM0lj?=
 =?utf-8?B?TkNyVGxKSHVZZElxaU5yKyt6RkovczFFRWxKN0c1NUh3SmQ0bGo3TXMyNUM5?=
 =?utf-8?B?cFNuQ1g1M25mQzRpRGVsKzEva09ITVlpTE10UDVhOFRtV1BzdXZXZDhHb0Q1?=
 =?utf-8?B?bXhGZFB4S3FUc0dlUEJ5RnZtSTY1RTBXakloaTZ6dkxVazBTWmVtbGMyc0lJ?=
 =?utf-8?B?WkFVQTRzZjlkZ2NIMnFWM3BBaVNOc1RZdnVBN1Q4Z2ZrMEtzdEZYQTVOMmRw?=
 =?utf-8?Q?3EKg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVZQUkxdXNEbzZRRUphby9mVXF1OFVWbXVqVktRODhPSmtWMzJQaFJRdnRI?=
 =?utf-8?B?S0wzNFE2cGZEaFRHTldUVm04L2o5R25yOC9oNmJOMmREZ3EwdFU4YmptdVNW?=
 =?utf-8?B?SWlGR0dyYitGbWdYQUFpVDhrRE92ZGRoeThSaWJPSzJ6QkVtVldFT1hXdWto?=
 =?utf-8?B?eDBUUmEyTDdpUWJKSWsvbXlEbkZWbXprZStZN0Nkd0RIdWduU3pYRm56TXdp?=
 =?utf-8?B?S0pjbGRTL1hpL284Uk0zWktPTVhQOFJkbFhIdkFuZFBRQjkzTjN1UzhDQ1Zn?=
 =?utf-8?B?VW9oZ21XZ1llT2YyM1ppVEIwVW9HblFCb3NJdzFiZlQzK3o0TVVvaU9yZEM0?=
 =?utf-8?B?MGZnTFBzVHI0MTZYLzlZc0srUkl1WlkzVmNmK05MR1lNQnFSQmxqTUM0bjBw?=
 =?utf-8?B?SVkvSmhVcXBjODUwZ2Qwa0pnK3haSmxMWmFFcEFyOVFldlVQQ2JybVVzcktu?=
 =?utf-8?B?ZDdWVG5NZUsxK2RSNGYxcStuRzcyRHJjVWpNREpUQ3U3eExoeXZKckRwNENV?=
 =?utf-8?B?QkhWZUVXVWFOeDZHTmVYUzlQaTFkd09YTm85MlliUTlaWW8ySVk2R2JkZVQx?=
 =?utf-8?B?Q1hydmUxekJGbkFPN3NoM29wclpGOERiTUxuZXp0am81YzQzQWErL3lwWTNz?=
 =?utf-8?B?aDVBTjhQV0crN0UvdjlhUmxUaHZIMU1LemIxN3JvSUtXTUNLdFdCVDFNWXZS?=
 =?utf-8?B?ZTJXZHpHRzNyc1ZJNWRTUFlvcVc4eXVZWkxUL1J2T3REWml4eEhscTYxMEtL?=
 =?utf-8?B?ODF2MFBhQUtUSFhHbkd6YkhzeVN2NlJrdEFMb3ZlVGpHTXF2aGJFYUpXQjVB?=
 =?utf-8?B?cEcxSzExNzFuODBhOEI5WHZ0UFI4RlE3MXBRTzBoc2UvV0tSU0UyTVB0Y2tp?=
 =?utf-8?B?bk1LMGFlVUVpS2dFcHlOY2U3V2I5RkVMZmw5cEgzeExZVHYyVjNLaDRPaE4r?=
 =?utf-8?B?VURWYS9ZR1NOeU02Y2picitKU1FCKzJHUVJheXBjRWxRM2JxSmZDTUIzWXEw?=
 =?utf-8?B?YmFheURDWDdTZy9ITTNGVG1zQjdLVFZQcCtFeVpNb1Y1bUxrVGFoRFcvRUwz?=
 =?utf-8?B?cyswQ0EzY0xjTjliTzhPY2ZRWWFBSzQ0WmdManJmOUZaaVcwN1lTLzNQSkFJ?=
 =?utf-8?B?Ri9NYmdTY0xPS1dBc3l6V2oyTTRPQlZobnBBRGV3RGkrSW9KWGFoNHNjUElz?=
 =?utf-8?B?a3k2OUJDNHUvb3RXQUFEYWZ0UHpIckZxR2JTK3VVMmcyNFMvQVM0MGdmU0E3?=
 =?utf-8?B?RGV0NjdYTkhiNytKblBObGhacnROWWQ3Y3NDelF5TEhzQnUvYmJwUnVueHRK?=
 =?utf-8?B?eVFVQ0lMUHV3aGV4bWNLb3cwQjRNYjUvVk9wQ2tJUkEvSnQ0ZDM0NzEzUzg2?=
 =?utf-8?B?RlZQSThDZTBObStJY0QxSWJuUTRsOUw4d3RWa2F5UEMxS3h6NTZjMGJ5SWJ0?=
 =?utf-8?B?SURFcHB1TTE2enFPZEs3V0FDYXFUd2RQc2RCWDhBUkFsT0VQeGxBaXZkVE5D?=
 =?utf-8?B?c2pOQk1hZjlvSEZOUnViTlpENmo2bnU1Z0h6elFjbHF2OFJ5VFdmS2dsWUxT?=
 =?utf-8?B?TVA4S3RUMktnWUVqSDFrMmdGVTdsWWhvVXA2QVNlcDl0K0pmTFE4VXo5Mktu?=
 =?utf-8?B?VlFVRms2cUhENXZ2OXdGcDZKbC9pN1d3bDNwMGUvbjRab0JHKzExOVo3SVp3?=
 =?utf-8?B?aWlYNkZkMEpyWnlMaDF1SWo0R3ZHdDJZbUFqeDhRQU5aN2o1SkN2VTAzcXRQ?=
 =?utf-8?B?NndMRm10S3M3ZjZja0hGQWVnR3pPK1JOZGZlZ3ZpUjUrRXd3b0UyZ0k2enhi?=
 =?utf-8?B?R2l5cFlLRFJTSm1sRHZVMTFwRjBnOGxidUR3ZitIM3BJcVZFRXdmc3kwaWpX?=
 =?utf-8?B?QWdFaktyRGdqZ1pocG1UVnBVMXZ3Wm50RmVGSVIxMVVEUFJRQ045c2Ewd2Z6?=
 =?utf-8?B?TnhpMnUweDY0bzV0aVBXYXZuYnY5YU5wamhJUEU1TytTdHl6ZlM5ZE9QbUxL?=
 =?utf-8?B?R3dxZVRQSVJpK0lIQVViUHFMNDUzbnpDa0NPbXIrUTY0ZlZuSzAzckpwamN2?=
 =?utf-8?B?U3E0VmovbGdSWDE2dE1BZ1o3VDJjQWdNbTRHUXUyUk5CdTlEYVRSc3NHZXlW?=
 =?utf-8?B?alVFQ0l5UVRFV2pCaTFXRUFOc2FGRi9QNUhMV2w4RXI1cjBOOFN2bGhxalBG?=
 =?utf-8?B?T3RuakF4eDdDTjNzenYrYkdqTjFYTFB0T0h1N2FNUXhvVG8xRGhFS1BiNkJt?=
 =?utf-8?B?bXRtdGRORmRqanlXTVFtUS9LdS9URnovVHdzcmVzYzZBL2RZVllVUUpIaEYr?=
 =?utf-8?B?Zyt3ZFR6NzBRQVYrYWtHZ2diNUMvblU3ejNxc3VJT3dZWVg5SUs2dEl6QVhn?=
 =?utf-8?Q?VelJ8IJdk69yndRc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a153d9c2-632f-4bb9-9786-08de68ac4d7e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:57:17.9626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB9t0x9WW0rJgYjQLkUAaZtI2/i/KzZ79Jot3ykxzYGBW0LUwjvDrk0DRDKVBPKh6LwNxgaWPTHIlYM3q/rG7ysG/VrUuZdGmZzUy4C3R6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7806
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Within the scalar packets, add a shortcut path for packets that don't
> use TSO and have only a single data descriptor.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
