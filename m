Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED45EA810A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:01:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFE00400D7;
	Tue, 10 Feb 2026 14:01:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5567D400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770728470; x=1802264470;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=crUiC8yH00Xz6G5wkLaclK8hgeznQKhWv8l/XgeWkKw=;
 b=neancn/YuxxXj456paneR8TN78izU2KsvTRQBJwDVwNfzNjlDvAjioQ5
 OQppf2QAB4uMbDW4NILxnR/PhO1lWfxG1FEX9TktI4ufoxmoaGTZwP8TV
 j3DxiLw1m6Opwz8w5GCf+M316+NwtfjkzCdxfnfC4nOuFIDPa7ESV/0Su
 8k8L6Io1FrjL4fjOX666CGBDzWoUcF3LpI7V4mzhBPRJRGRAY1eeWk5hP
 2uQuouWwCoVjDwHxpCG4xjvogycRe7y/EJkTxUtKoOmTVH71pzsmr/a/C
 +51bmXKoXnMJz/7L/C9KsI8rHgQ9YIWhnNLTJQD0MXTHBwthgc0+mKd6m w==;
X-CSE-ConnectionGUID: QUlbLCwIR3K3ENcg+I/k8g==
X-CSE-MsgGUID: kpr372mwT02IKfr4t6aDvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71956937"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71956937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:01:08 -0800
X-CSE-ConnectionGUID: 3EUXhpQ2RY+eIuXSj1DrzQ==
X-CSE-MsgGUID: VsgUyIicSrmQHMcPqNU8rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216446334"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:01:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:01:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:01:07 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:01:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv9nswEFgyprOVqB3brGbeAulZeDLqGCiV54nuC3qjnyP8glkPwZBqKHJlSAKL7HnsbTezLCDAW3ksMEim3l45fMtI3PUZ07GG+KKgtXiM4G2hKJUDUH5YLtr3BCAvn9PexuRVB3dFvl35zW8Z3I2LQGPE3eo+sXJLA1cHEZs4V4NZOJvOfZ06Ueus14EEDxKCWUOcHGB+HAiAQDIswkg/o2haZIe/KZ7KHdz91vdG7+0Q9A23mNHy9ueU1ZYENyMrUNc8nJdx3VM0YBsCebIDwjmZlXboji487gvd+cLFovJhxN2mFXDhanSd0QFvrgqYtuCrz5WV6fIcZtc45Ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeMrx3lxocm2h2j6Ks2K3dCwJ12dx+f7yzBODxSmFQY=;
 b=plEDkZxjrNJQtW6QHghi2RXxPGMNOcPVNG/40KmOIzBx4ZiOmoyAhsKNbm6itMajrvYl3LfZlVslTuzxYu3kTgoNIpzdKIADSynX810vPMl+houoq1W09BrODww/ZYVDWWPeC8J8qKn25NjLYtV+A5yAlohU1KXJsWJd2MN4/Mmuu2KQ55wLGe3EAm9aO9eqJVykgNkXS7GE1prPEgTHhUqWbERWDr16QoNiyiQflQGi8nkbEqg3jo8/kHk4QO48IFPBo3gLu5jA1KDCMZx8/+LNz9pA59FNWgn5T4Yuom7eAxSSomXZ2f5L2rFz4YvJommtYu1s4N52r2ZC/mEUJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:01:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:01:03 +0000
Message-ID: <14348d08-c054-49a7-a02a-aa8b5d2dc21e@intel.com>
Date: Tue, 10 Feb 2026 14:00:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/35] net/intel: consolidate checksum mask definition
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-10-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-10-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ1PR11MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f66619d-be91-4776-3a62-08de68a471c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elBydDEyMmFud1UveTZxMG1WNnEyMVZZWHNDcmZ2MkFlaTFaMCszSUxPdHRC?=
 =?utf-8?B?NTdTb25EdnZxRTlMNFRpbEtoQWRaSHpJY3k2VUFBRERTcnhXaG9pcUdRL1ND?=
 =?utf-8?B?YVFjUTdxajRuclpjT0d4TTJhOWpxQWlSZ3RTcGN0WmNXd2IxSjh4U0R3MEpH?=
 =?utf-8?B?YzFzYWFXL1ozNGppN09GeUZYU3pUNVkzWVF4V3BtT1NhMFNta0ZJc3ljNkxo?=
 =?utf-8?B?ejd0NmFtdHFPL3Z2TGJUSk9JU3R0YkJkQW9EaFdFaEVuQVJKdVlIdGlYUWRY?=
 =?utf-8?B?L0U2OUI5dENpTWVjMEVpc3RiQ0xxSDJlM1hKcDFVT2dWYmhxR1pDMDhIaGpz?=
 =?utf-8?B?aXdYTDQzZ2w5WTB0SGtKQm9SRXhWT1lxTDdzMnYyT1I4b1hGVFhZV0haMTFI?=
 =?utf-8?B?eERESjlVeXFReDVqYjh6TzF5dFEzNjdvRFFvbEJEalpWd0I4alRaTVJicEF2?=
 =?utf-8?B?Qy9FNHR0SFI1Mi9HNWlLMHpweFN5cElSTHVGUkpybVM3RXAxWVc2R0FYMVRB?=
 =?utf-8?B?azFYM2oxaEZMODV2Q2tWMDJ6Ym1ESmtLeEQzTXQ1ZWpSbTlGQmVOeGdzYVIr?=
 =?utf-8?B?OTk0TGN3cGFNeTVRaXI2QXNjQ0dURXRWYUYwNHRPMmRZaEt1MWNBRG90dC9V?=
 =?utf-8?B?WnBJcURMZ0wwbmdhWmZrTno0dFBRYUM5REZZSjhBSEFxYk0zRDlOTnkvQzJ4?=
 =?utf-8?B?eXRVcjFKZFpUUDJSbmU5VWxNS050KzExSExGQW5YWm9xTGt4NUVaL3NVZXE1?=
 =?utf-8?B?b3N3S092RGJ6UTBTaUFXZ2ZJVmsvM0ovNnFKb3B6MjJTS2VWMnNoaWc4c2pU?=
 =?utf-8?B?MDhWOUVmbTd0WDNsd2ZVeitqV0xUUkU5S0tmeUR0VUc0QVpZa1Q4SVZFUWU4?=
 =?utf-8?B?Nkw4Zm8zdzUyL0w2dithZDdicURaNDdtNC9ORW1rWmpuNnVib3NOZzkreTRm?=
 =?utf-8?B?d3pPK0lIcmwyeEIrYzRMdklLM09qRHlmaGt3UWQ4THRRMmtrQ1VNcUVoUVhm?=
 =?utf-8?B?SnZNZFc1WG40bm02NGNaUjRKaE8xV2R0TXdoVkJWZ1lXbnk0R2oycXliNFZY?=
 =?utf-8?B?UzVPYXJqeTIzelpibUc1OCtaT0c3RGNDbDMxZWZ3b3UxWGpDcmVHWGljQjRX?=
 =?utf-8?B?L0FIWHB2RzlXUHVkRWNCR05rK0gyZVdMSGVIZWlvYXllWiszVDFPbTVuVmJ5?=
 =?utf-8?B?RHRpUnpLZVRtR1MzZ0FVSm96UXM4Q1B1NXhPOUhlNEFPZ2FEZmFoN3RLbnlr?=
 =?utf-8?B?M2llakhkOVdobXlnZU1mOHNjSDF3N2VCODVHZ3A1VnBUS1B2cTlGY2VTQUZI?=
 =?utf-8?B?UHZHUWYwVWhlTlY4MEJLMy9xVFlaNFg5WnRhanFSUWFDdmg5L3FlaE9xaXpy?=
 =?utf-8?B?SmVWeHkwZ1lpMDVYd0dDdVQwdXFJb2FlY0pDRktHM3UvRURrWG9LSzBicFFB?=
 =?utf-8?B?ZVM2N2t3VktkbGxtYzJjbkNQemVkN2FPYlRCcVpTcW1XbjZnSE8zdE5INE9P?=
 =?utf-8?B?Q3NOT05HOXhHZitseWQrQ2pwV2JNTGdkNjJWK0YrWGlHTlJVenJ5YlN5cXY1?=
 =?utf-8?B?L3hiMG5mdXdSTGM0NGQzVWFhSy9qenRpQjJTWUxvZzVqL3dObzVId3F5TGhi?=
 =?utf-8?B?b3VuVTc2WndBR0pIeGdHSWVKalhFSFpFUENoSDJjK3RxOVJqdkVKY3UrbGl4?=
 =?utf-8?B?ellYVXlpN0J0YmNXSldoQTF6cVd0SXpJaXRzSXFVZjN6bFBNZTJUNVYwRWx6?=
 =?utf-8?B?MnUzVGIxSmpDZklMQnFsenh0Vkx0bTVBVVkvR3JSMzNIZW1XTGdCTDIva1oy?=
 =?utf-8?B?bjBEUVA4bThCUnp2NWNiTC92SUY1eXV0ZmlxbUpzeG4wTTV1MVdybThod3Iz?=
 =?utf-8?B?dnFOMDd2SkxzSThLSEoreVdqWkR5MTJyQ2ladGlpeWNXdUdDWHhsaTR0cDEr?=
 =?utf-8?B?SS95YXJpRzVxVVdudTN2dHBJOWhTQUtCSnZyYU00b01MZ3BmbGtua0FFWXl5?=
 =?utf-8?B?M0ZzWjV6SmVnTW82bDVXNVV1dHpEMUJQaEIrOENyTnMwL3RYaTlteEdvN016?=
 =?utf-8?B?NldpVzhOVWlERXBFWm1qeFI2REs5UktPQm4xVlZGenArTEVXQ2dPZ2xUWkxU?=
 =?utf-8?Q?DiFA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDd5ZTd4Q3VyTnJzVGJEc2tJNjlMdWkwODBtQXNENHNuQjlIcGFlZWsvYnlU?=
 =?utf-8?B?NkdXNERjNkIzNDFhSE5BWTI1N2RxMThPTzhjbEhrcytlQ1hkOXpkQTlxbGw3?=
 =?utf-8?B?SDVja0FXT3h2VHJWMUlmSU9XeXpZK21JMEtpc1NYa0FHajJOdDE0bnBkQTNu?=
 =?utf-8?B?SW9maHlnV3FxWjhrUzNqNmVwb05pc1ExVHVFaEpwUUMrajJ3NytFSUpybDlq?=
 =?utf-8?B?Qk9iTDFhQmZIUXp0R0IvNFJDbVdTNEVzUXkvVUdZTS9MZkNNS04rMlFNNEtD?=
 =?utf-8?B?RFpvcHNXZUlVK0U3R1NXSklqNkVBUnpIekk5dU5kWS9aSWM3YnZxN2txOHNS?=
 =?utf-8?B?dXVHdjd3YnBqNEoxWFluVmI1MUpCS0dNRWNXSUhMRVU2K1RWY2p5ZXB2OUhv?=
 =?utf-8?B?UXU3QnFTNHMyd2lQRHhxbnhxYmJwMFBFYktrUUplejlzWG1aYnVid1Mra2Uw?=
 =?utf-8?B?N2xjUldVSXlQcllaNUR6VWkwK3pwQ016RXQ1QWNRQVgzcHdWandvTGlIalZ0?=
 =?utf-8?B?RkdKdzFWbGhVTHNSTVo4NmpEbmF6R1lXUVJhK1pjM3hSZXcybzB0R1BvNXlk?=
 =?utf-8?B?TWx1enNodGMxRTNjZVZTekYyK1JRZW9ZeUdMRldEYSs0RjJpVmQ5V3lZQmFI?=
 =?utf-8?B?eUllbkZoN3BKTkJ1Wis3MkViaDZwb1hHR2RXZVV3bmNrZS9KTFUxUVkwcis5?=
 =?utf-8?B?SU1DRTMyZFJITE1PTzRkY3NGb2N0QzJQRmdTV1Y1U1FJRXhqY29kVVBKaWw2?=
 =?utf-8?B?Yzc4SElVR2FkMnp4d0hxRTFnOEFkOTlPdStLOE9ZYkxmK3JybUxyYzUzcnNk?=
 =?utf-8?B?bEREZzltTUx4OW10S2xGa3Q4NkhnbkZCaWF2b1g3VGFtc3BlMGdiVGdvU0Y0?=
 =?utf-8?B?dXdONjkzRnFUMGxQNlBMTHpXb0ZmMmk3T1hqWnpMNUxGVmhtUDVDN1VCS000?=
 =?utf-8?B?WEk2NHhPUXBxZ2RHdVdzMFAwV1RCa2poR1g2YzJTTE05SExVQ0lJZ3hMbytj?=
 =?utf-8?B?dG1aWFJZalFGZU9oc2FOOHRMcVNGVUtXVWlsRHZIajcrVG5IN3RVVnFXSEN2?=
 =?utf-8?B?K2JVanY1dElzN3Q2S3RPZXhXY0Y0Rm9GR3IrTms0UVJoaTVucjNDOGZud1pm?=
 =?utf-8?B?eWVBS0hvc1BVd0Vzb05uRkU4MDlYKzZrYktzVG1hUW4xdngydUpLeUE5NEVN?=
 =?utf-8?B?dFRmMXE4L3hUb0dyNGo4K2hVQVhsVVF1aVkxTnhUZzFhUURvRWNSS1hsSkhs?=
 =?utf-8?B?NmpZWEVTUkN4SC8yK1l0U1NwMldmd3phUHpNeU0xZjRWRDRlZmJJK3NqV1cv?=
 =?utf-8?B?UTcxVnZSQytvMTBza1BMdENnSzRRM2xCVDZYR3ZpTkQ2MG9vQ2ZWUmFUa0Ro?=
 =?utf-8?B?VXNqSENhOGVkL1dUNVZmM2hqNEZ0OEswQVNuNWJGc3d3c1VZamt1V3NFSkdu?=
 =?utf-8?B?TUtoSDZ4Um95RVIzcU54U3BVSEFoeTYwVUNhbTB0Z3dueGVGeGtpVUh6RUc1?=
 =?utf-8?B?MFNpOEErTGJMRThNbE9EMnowdVNzVit4aWQrc21tUlBnblFIMmQ0aDE0T2NU?=
 =?utf-8?B?M2xkWjNUcTcrMCsyZFNTL2NEaGpXSWJITFN1ZnM2bS9VR1ZDNlE0RzZocFo0?=
 =?utf-8?B?bE9HMXA2cVFXdEZCTWdSb0RMc0VEbEM3MEdicU1ZYStKWFA3cFl2UlJkK0Jw?=
 =?utf-8?B?ZTZoYnVaa2VJcjRzZTJWNlpZTXpxUlhIeXR0SDZUWWZMRmxIN2w1NThkNytU?=
 =?utf-8?B?VERPejZIYVlNT2ZZa0hCMXdQTHNRRFNCRFBza2J3TGFremdZamdRaW9RYjBq?=
 =?utf-8?B?bnhoVm1mVkJub09zVnBuV24rWUJkck1qc2RzRzhIOU9IT2h2c0dqamxyM2c4?=
 =?utf-8?B?aWVSdDg0OWdoaTlEb3hWNnBzRytBS1lvbmowVGdVLzhQeXJUSHlHbFUyL3Na?=
 =?utf-8?B?K0ZoMHZYejJrbmhhZGVJeGltTmZybnRXVi9ISVVuMG15OXQ1QjVKTE93a2JI?=
 =?utf-8?B?Ri93a0ZlK2RyU0x5Y1prQnBaSlQzTitxOFFXbmN3anhhUkxoYzd4UzcvbHU3?=
 =?utf-8?B?T3N1RStRYlFnanEwcE4yODFMbDZtbDZ1dSs4NGpIRUxna0hPU3R4N3lVOVlE?=
 =?utf-8?B?L0J3S1F5MnhCblVWS294Wi9tcURnb01Jay9RWDhzVmlyd2J2QTNUUUxHbVlR?=
 =?utf-8?B?SEFIbmtOc3Y5Y2JrclNZSWRUUGxWWHFyY1QrSnBTK0hzbGZ6MFVmbGg5QVRD?=
 =?utf-8?B?dFFlc0tONXNOSUVQeHJ2MW5lc21qNERYcjlCZ0hvWjFDRnZqOHcySHpBaWpV?=
 =?utf-8?B?dTF2Y1ZkSGRHdjNta1RFcEZuVGVhcDhOazhXdXM3UFVPcG5FeHFMVW1xdmJo?=
 =?utf-8?Q?src1zYMvS4NSexTQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f66619d-be91-4776-3a62-08de68a471c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:01:02.8665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcyxzeUANmGISeLyo69vSnE57pHhjy3TizpTkB14GSecqJRwLTgfFtHe44SgMW7AKiI+a5m1rK43e17fp2yoLGwJaMYMjqwDwyRgxeoNJ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
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
> Create a common definition for checksum masks across iavf, idpf, i40e
> and ice drivers.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
