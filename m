Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A549EDF148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:30:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E0AD4060A;
	Fri, 13 Feb 2026 11:30:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3345A402F1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978655; x=1802514655;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=TkaLqgHblhCiGYenKLrXTDNDhVNovQnE/3IMcBBOXfM=;
 b=erkkUw9YPapJmiGGTCYrwnZZPQAqsaz2jNiPe1Dt75vsaLjQim1Od2Yy
 wlZ4YgHKmMCpNe64AUs0L0FfX8T9HpHJkwQ0oOX310iIW6Com9iX4+wdf
 sSMlXCH+mChc3yCTYz8d3vS4aChWo/RE4I8YNLOkO3cFY40z8LTB7d+7o
 dBspSEymPhmz3sdccPxMVvP288gLV0NlszD16Kgj2s0VCYxrycA7BHR4Z
 sOP5AOUhEfa6vNjZpgHzPVZTvtD/fi1VSlAxTY3qoxMp9xP/LwpKQLdGb
 YkBSdfaTcwH91iT7J93WYvXT3zuHpyqEuOfSoqrRKcoT1TefwCQBWEWMV Q==;
X-CSE-ConnectionGUID: JAnK6lMKTSuCx79Fx69nXw==
X-CSE-MsgGUID: MaHSJQCYQK6yM1kjYmWolA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72067157"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="72067157"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:30:54 -0800
X-CSE-ConnectionGUID: GL/6I7TtQtSpWx3MNFBMqQ==
X-CSE-MsgGUID: tAW5NS2ET5ypcOXf7S0wMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217430017"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:30:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:30:53 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 02:30:53 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 02:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEpbnqQnPs5N2SpjD/QuC0Mz9vy3cfS60709/PVK5g56YT7FCfXP4sGNZozf9x7F7BYcncsKSq/qbuzwOujK21Z/G/7fMxtYvTGXstR4S5tQATRHIov9X/Uej5kUBEClKPxK52Uy5o0q4VTdQP3wqTTw7tUeWuhIbjrNNV3pCdZ+rV/3Ab5L8ppSCf6dTYJWFySvKQXmTC5U2nHqqYS/y4um7FCR2A3DaW/cIErLIa1pkmRISrg8MXJyLwdoEllB1+TBLj3Hl39LnNONFAB793gA8FRiEqoXTGrdDzE6dbLAqo2YCv4eAA5cszZMPFfQAXg+Iwc/nbwBHu6KCy8lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqyIWUbpjNP1jZHc+Mny2myf6mdxxPvrGrqk8CLspeY=;
 b=joiXJ3EjBUd54aT9desZB6T8ieF+697NxpO4eqkzaBpAZ7WeUmfKPrh6S+KzZY6W1eTrfzaTjzRpd5ymtgp4hSuMeUi8Sbgibd9Tu9HDbUqrYnFfj0K96mzEdGOzLfF+t7em4ydFwjBOlpNp0kWLHulJwDRZywZIESnOFomuxRmz2zuDcEWmoo983UiqItoJmht7NIxcPn4bnMtVZOg0Og6PgqKFe8i2284T+2bgCV5mMWJHiTJ54NRSPQeAigGkmI7OhWGAQv4qJWH/hjO08JSem4V2y3ZmhWfa+FF/PtLhNqiK9NhvbZKG9+wfA4kXQeHDqTNTjsEUMWNU4X5EIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 10:30:51 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:30:51 +0000
Message-ID: <3aebbd08-b879-49df-ac87-d050ae825e2d@intel.com>
Date: Fri, 13 Feb 2026 11:30:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/27] net/i40e: use unsigned types for queue
 comparisons
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, <dev@dpdk.org>, 
 Bruce Richardson <bruce.richardson@intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <a2be771c0d9bb6653145c04ba4ff86a49e11e649.1770817884.git.anatoly.burakov@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6570F@smartserver.smartshare.dk>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6570F@smartserver.smartshare.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0201.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::26) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA0PR11MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 746a5594-990a-40d3-7265-08de6aeaf5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE0xSDRPcTYvcHR6MlJyVWhka0EyYlo2eEt5WllSeEFEK1hiZGE5enNJS21w?=
 =?utf-8?B?enV3V3RIZU1jUzVGblFKODB2Sm1mdERxZ0JrMVpBMDVJV3RRNXp0WkJ4NFFD?=
 =?utf-8?B?M1ZGeU55Z1pmWWdXL3BadmRUY3daTnloOGxzNWZaZnA2QmxwM0hnNlpmWXpw?=
 =?utf-8?B?NWhUQWlTem0vTHFRNTBZMFpmNkZQcEtaTVZ4TThoL2tWTHhRQXE1MDdwMklk?=
 =?utf-8?B?U1hTNXlFRzE2WU1RNTdweEtTVktaQTY5WjRvaEdGN1JBNkdkRXRnOFhXSEtJ?=
 =?utf-8?B?ZlNuVXVSeGZ4K1FibjVxS3VuK1BLY2pBZTlNQ2oxcDEyNU51dVg0dDM0Rk9J?=
 =?utf-8?B?VlpEbHVvd05ZZUpIeDJnNzlnMWdPcUJBMTU3Ry9sbWVtUW5lUXFRdi81ajFy?=
 =?utf-8?B?ZVNHdENDTnMzNE8xMGoyMWw0SnpPUDNwb3BIaGhJLzQvcXdldC9TVTJZV3p0?=
 =?utf-8?B?cXRveXptR2I3WGh4ZmtKdjdWZFRCMkZXRy94emo1L0lkZXBqdEdydzdTZ0pj?=
 =?utf-8?B?S2NnZTVmbm5BV1dFdXRBRUdsL0FYeHhPak9SNTR4RVJDdUdoNHFWWUF1ek5V?=
 =?utf-8?B?cCtXSS8zaVp5VDlqZWhzdlJJakQwL2hLbXVsdFhiYWtHNHJYb2xhRnJ0UGJw?=
 =?utf-8?B?ajN6THoxUUVrOUJ5QS9pL3N1blVZTGdVNXdUT1BVY3o2UEpVY2g0U0g1cUI2?=
 =?utf-8?B?TWQzU2RCOHB3MFFWdUlBS2t4UGtrdG1WU1dPWFpWakRFKzJQVmVwN2VNMDBJ?=
 =?utf-8?B?OXVkY2ZaVVJ4aDdocGZ2V1pPZ0N2WXBsbW1VaWpqcjhZSlJsYjRtWHJnaEdw?=
 =?utf-8?B?MmhPbjhBQzZCTFBqa21hUmpUZWd2SnBwVnJQSFJyMlJ0VmN4cjRFNlZRcXIz?=
 =?utf-8?B?M1oxV21tQjE4VDRlSVpPdEVlaHVuaGYvL3RBUVlMUmRDTDlvbGZpMERna1Zi?=
 =?utf-8?B?U2lLN0wraCs4eUlyZGtiZnRjMGNVcndQd3J2cHR1REVGNEhSSEdaT1FrTkwy?=
 =?utf-8?B?dXNHWnQyZ2k2Zzg1VUJac3JQaEd5WWh2bFQ0UUlNZFpjQjgyTThnTGFqOVIy?=
 =?utf-8?B?NjRzSm9VS3RlWDREUjU5MEJXS01HeVNFbkRjeXpMWWcycXlqRUlueU8vU3lu?=
 =?utf-8?B?WHh5WHE2dkYzbGtETjVHVzR5TGQ2YlRndGVFVnVkZDQxRVhDK1JSWXYvNlhO?=
 =?utf-8?B?WTF4bUdOZEc1SEhNbWZJcjBaaU5wS0l5ei92VGJoTU85ZFd5akxOWFJsdzJO?=
 =?utf-8?B?VVlFdG1MZ0N4eUlFN0psZEFURnl0TUtGSUMzbG5BRFlPK0lYKzZEZ0lkV2lK?=
 =?utf-8?B?N2YrOExLNWhmd2NjUEVZUEErdisxNzI5T3hyKzlFd1ErcU91bkxHaGJCd0J1?=
 =?utf-8?B?T1RISjV5RFg4ZFMvdlR3MjBWbElMRVFPWE5HQ2ZKbXVCWjJWek1BTUJxd1FF?=
 =?utf-8?B?TXVVVjM3cjZydjdXYXQvNENlVTRUTTNIdElJUE85aE82cWhib0ZucGtqbVdx?=
 =?utf-8?B?S1VXaWx5T28wSnNYYTY5ZVByS0ppeTJMUlkvcGZLTXhTYUxpR2JsM2w5L3Zo?=
 =?utf-8?B?SGpQOThwaWdDTld2OHVpQ1VmSVJyTXZ3cG5leTROZ0tRUTZORWNHTGtsY2Rq?=
 =?utf-8?B?T1c4SkFzcmY2aUVYNVFYb0lVc2hIWldUSGJMd3hEQWM5eGEvZUdNdzdLZFFp?=
 =?utf-8?B?cFQ1UVhxdldkTkc1NlJOMHZvTy9ieXBTSWxRSlpIaU0zQWJJSXJSbEZvQWpm?=
 =?utf-8?B?STBtRDRkb0JjQkgxUkREd1R5dUNIRHhKZjJwdEgrUFFoL1pKc2JkZnFXUWtO?=
 =?utf-8?B?U3dmL2JqM2NQenBRcGw3N1UrblFyajN1UnlJOGRtZEw2YmNJODBNQXhrMk9h?=
 =?utf-8?B?MGxVamxlRVg5aWVZV1dvZDhLTGtEMEZTY2pyOTgvNTM4S0wwTjVYbW81Ly9V?=
 =?utf-8?B?RXExYmxpMWVsbVpPOTB5eUIxMGZRT0xXelF4Q1FZRWpxdC8zSnJ2QXNwbi8v?=
 =?utf-8?B?VlYzVmc3VFRETzRUcTI4L29rWW5ZV1VHa3ZneFRqRFdXMEFlZnh1SzlKTnNh?=
 =?utf-8?B?VUhEOG8rbEE4Y2FRTTRkNW5rNVpyMW9rV1IwZFM3Ukl2UnBBNDR6L2I1N2VS?=
 =?utf-8?Q?Zwck=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZnVUQ5RjVZZDhFWmFkU1dLMVJyczV5ZmpQaDdHSFJuN3lqd1ZZY0pjaDBt?=
 =?utf-8?B?L01odWhtdkNWN3ZvNmNrV1JWaVpqT3pUVVhUR0RWdlVQeDFmYVNyL1hIWlhR?=
 =?utf-8?B?VlBQRlZBVW9NZmFpbU1DNDN0YlJTanlmT0EyUVhiemFTSTJYbVdmUjdHcEpj?=
 =?utf-8?B?bVBGQitlRWprTXNhY2RLK1hqT29xeHhyb2hyYnRSWFFPd3ZORUE3RW1WZHNj?=
 =?utf-8?B?ZjFqQVBaY0ZwUndOQXpnSUZsa2k3S3pnQ2MvZFA5S2NIeXpaN1NIbjFITk0w?=
 =?utf-8?B?LzlqTmRRbk1XYVNQK0NTeXhMb0p6REJPRHJhM1NJdGJydXdFQ0ExTjV4ZUVC?=
 =?utf-8?B?UlVjcGZwc3VJOHFlemdBUXZDU0lnQk9KVmE0WEdTcXh3MlM2WHNkQnhnVGl0?=
 =?utf-8?B?SVp3QWJFQlo1dmZwNk1yenAvaTZNL0Z5bEM4UVhHaE5CWDJVOUJSUzNNQVQ4?=
 =?utf-8?B?SlRWenBQeVdRSzVJZXFqSkRnR2VnbHdaQlZRMFh4UGNxZFJLNHFDR1daQ1Nk?=
 =?utf-8?B?N3U3b3N3YnBuZ2pjZkhsUzVrc0JMSVlJU0pjeVFEajRoWkVHVHVvdHlkcE5s?=
 =?utf-8?B?cmhKbTRDK3RxYitneGlibFYvak1MNWhYNVFURXRGTkdKWnNDNlNsZEx3emNw?=
 =?utf-8?B?bVRUdlJLWjRWUXVwRFEwUHpsWjRpV0lNWmlKZnRpZ09Ob3NUWDgvZzBhMTFS?=
 =?utf-8?B?QmkrbHBUWjBBQ0xJZXI1Ykw5QjIzdXIvR2FnWGRDTHhNMSt5d3daL3N5dUpB?=
 =?utf-8?B?bVpUTkNYZW1DK3dFQVNNZk4wNWhGc2xkYnJBZk56K0U3bzFHbk5RcTgrUzFQ?=
 =?utf-8?B?RFRiWmF1R1BEQm02RmZDMzc2QmRmdmFDTjBBVnhKeGwxbXh3N3BRVHlMTWFI?=
 =?utf-8?B?Tm8vSWxhcE04SVZIa2tSWkh3ZC9xY2xINmpNTy9mTEtLNlJBbDlDa0o1RFNx?=
 =?utf-8?B?bGIrRmJuRXR4TktxNW1YMit6d2hQd255bVhEOUs1a0ZUT3JFWXRFazFZTVgz?=
 =?utf-8?B?Q0d2Y1drV3lydHA1aFpEWHk0YUNzR1VPRmhlbUZXK2FDdW4zOWd0WVVTdGtP?=
 =?utf-8?B?MFFxenhWREF3eHcyK3E4cjR6TWloc01md212eHUwdzlRY0xIbDlyQ1I0VlN4?=
 =?utf-8?B?RXlSQitoNWtEOXM0WkJ0T3l0b3JxeElzUmxKZWZNN1BIais0T3lvY2N3ZFYv?=
 =?utf-8?B?dm5oZG0rbU5YOGc1M3FacEZmYWhScmVsVGdEUzY2TE9GaTJpdGl6emFERkE5?=
 =?utf-8?B?dnZZaklQbE5TQVNsRWRsNlNnOFI2YzZtRzVZZ09ycitCNlRGcW1RRjBFOGJw?=
 =?utf-8?B?U2tSNnA0ZHA0c05YUGg2LzRGU2UwZS9rSVhYY21yN2VXaUVLdUJFZi9ZNGpI?=
 =?utf-8?B?NzByUThYbEVodStVUEJjeEtpSUIydE5VVldQZXRWQzk1a1ZOb1JOVFdmMTVr?=
 =?utf-8?B?aEJCSmViMG5uUHgydTI2TDN5S1J3bGhmbWpWTUpLU0o5WnlidENKdVNadnlW?=
 =?utf-8?B?Zmp1YXRnaWw4THoxZjJSRzVUOUlaYnZZczZpQm40ODJybzZqUUNGd3BNVnNy?=
 =?utf-8?B?ZDNQVjcvTmlvYXNmdGxsY2lmYVRhSVVUeXJsOU5KbUtQTUNobnBtM2k2dTNw?=
 =?utf-8?B?M0ZGd2E3RjNHbGtacHVZVzBEZFIrdTgwTkh4RWdkb0UvMUV3UklWZGJwbkhQ?=
 =?utf-8?B?cW02QllGMitOOHNiaU43Q2M1RzlPZG14VCtyVnVheTZrSE9HOEk3R1Y2a01T?=
 =?utf-8?B?UFp4M0lJblBtWEtFQTZEVktMeXdLUDh1OVMrSWE0czlnMXBBME1ncFE1TWtU?=
 =?utf-8?B?amVFdGZCcng1WVd3NTJ2cmt1bFpDT21FNkg1eFdxV0NRUVFkdlJHSkY5NlRH?=
 =?utf-8?B?dVFEekZWbGgwdEtkQnAxN1p0VmtpQzhxcFpDa0l1ejhnN3RCekEzQ1h3bHl3?=
 =?utf-8?B?cXhLdDlONGpDbDhFa2kwM2k1WUFMcVQ5bTIzQkJWcGZoY1BBM3I0dVZkNFo2?=
 =?utf-8?B?RnpIQ3N5TTdDRUJQdWZreW8rWnQ4R3VxK1lmMHhKNWhjYzRIWlZMdTk4Rlll?=
 =?utf-8?B?dXM5bVlDRytFczl0dldOYjVVcGhaUFJmanhnR0hkejRkMHk2UkhQOEJqZWxH?=
 =?utf-8?B?RzZwbHFid0dtenhWK3pvN0VtUlRDWkUxVEhJSEpGT3kvV0t5WTFYQ3hnR1FG?=
 =?utf-8?B?dDJiRi9jdmpHQmx3UlRsZ3RyVUIyVWxiTHlvU2hROGtPV3FYVkF6NTFHNXJ1?=
 =?utf-8?B?V2FpRWEvbU9KYnBZeE9ndTRhT3FwWUdiMUFJVWYzK0dBWmZVd2pZKy9jS0tw?=
 =?utf-8?B?UnR5YUwrZFdVeS9UVWxUUS9EaHBKRnJaQ3l3VUNieEdyTDhER3NUcEZpUDBw?=
 =?utf-8?Q?M4G6G0OdlWlwTW40=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 746a5594-990a-40d3-7265-08de6aeaf5c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:30:51.2921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOAeLSmrhw7sP330kyiIbfwYIEAmjlYPk4OHcLTG9caEwFoHljg1u+jfqD5iTvqg4OBEYpHKPFgs0pMdQh4whVXqGhdNufHtth34JKS4c7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8419
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

On 2/11/2026 10:03 PM, Morten Brørup wrote:
>> Currently, when we compare queue numbers against maximum traffic class
>> value of 64, we do not use unsigned values, which results in compiler
>> warning when attempting to compare `I40E_MAX_Q_PER_TC` to an unsigned
>> value. Make it unsigned, and adjust callers to use correct types. As a
>> consequence, `i40e_align_floor` now returns unsigned value as well -
>> this
>> is correct, because nothing about that function implies signed usage
>> being
>> a valid use case.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/i40e/i40e_ethdev.c | 2 +-
>>   drivers/net/intel/i40e/i40e_ethdev.h | 6 +++---
>>   drivers/net/intel/i40e/i40e_hash.c   | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c
>> b/drivers/net/intel/i40e/i40e_ethdev.c
>> index 2deb87b01b..d5c61cd577 100644
>> --- a/drivers/net/intel/i40e/i40e_ethdev.c
>> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
>> @@ -9058,7 +9058,7 @@ i40e_pf_reset_rss_reta(struct i40e_pf *pf)
>>   	struct i40e_hw *hw = &pf->adapter->hw;
>>   	uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512];
>>   	uint32_t i;
>> -	int num;
>> +	size_t num;
> 
> Why not just unsigned int? size_t seems weird when not counting bytes.
> 
> Or uint16_t, considering its use.
> 


>>   	struct i40e_pf *pf;
>>   	struct i40e_hw *hw;
>>   	uint16_t i;
>> -	int max_queue;
>> +	size_t max_queue;
> 
> Why not just unsigned int? size_t seems weird when not counting bytes.
> 
> Or uint16_t, like rss_act->queue[i].
> But then I40E_MAX_Q_PER_TC should maybe also be defined as UINT16_C(64), and maybe more should be uint16_t too.

Good points. Missed this in v4 respin so will address in v5. Thanks for 
the review!

-- 
Thanks,
Anatoly
