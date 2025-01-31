Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D0C0218D
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 11:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D952E40281;
	Fri, 31 Jan 2025 12:22:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 54EED400D7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 12:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738322529; x=1769858529;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Equv7Jhp0VO2CSszMS72o6TXGscD88lni5Cw8/x2eSc=;
 b=YglEkJOF/YUmVSqL+NiBWZBpjrS/Q0OgnuxU3B31nKdclfPtwcUeL5xQ
 sraHEafj3dMccN2bW0Nu8LuXnrVUm4MmCIg0P5EpiNKbYfmOh/9XZhzaw
 LtUa/58KMGTG0Jg4kogAqDQSsC6xBsDXymxYi3wDpDxJJsd6eX4QAs2+5
 YKpBuM7h+7oeaa2y2A9H1NLteXaiKiSNoONOnxsGOuWcukO35apU5heRe
 g35iMYUusOdSuvrL2LUe4NO2VCkXQSThhv5kkts0o8Z0ejcZ063170dvR
 TKx+xOOnUHWRpEbxBUm7lTyT5K0Usj0MFQA3Zd89X8Jk/Cxo3PlEnS5GI A==;
X-CSE-ConnectionGUID: UWeuNZUFQFa7KK+FplggeQ==
X-CSE-MsgGUID: MptkN1JJRaiYGUZKH+UgMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38593469"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; d="scan'208";a="38593469"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 03:22:07 -0800
X-CSE-ConnectionGUID: wSO6ISZ6RBSuHTYd2zPEWQ==
X-CSE-MsgGUID: Zca42sfVS+GeV0IQWTfVsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140487824"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Jan 2025 03:22:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 03:22:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 03:22:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 03:22:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egeR7rlQyu01BSRVy2NNVebefD7gvpsdMDRn/xYQ3kzD3CKpv2HwRwdqMXItlyGOo4iMIRyxn88Nqjgi1zMHj0iKysOOcIJbQAp3oBQDomX4W57SFGRLqAyqaXTHO9qirzpSRYZk7FHwnrxvN5kj70YTWBVgDUEsBusWWMVe5XH3gATnnCSjHUGdhTgyqzuP2iVsSNK9lWO0nnIU/gcrvBGibykV3S1ycUZbuYhz1pISDartB20dyoCEViZeGYlzn+oNaCzX+UbLyY6DoLDakGsY7tRaCh6wEcUpVo3vdCUMUYkFUJt2jItUh939wjyykJ9k0hl6rJ3/iInMCm0Z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpwuEsPdN6LAqzfGzxEGvtP1eTDQARF7G1bzTDhK8dw=;
 b=PToQHKxFq6wEGFw/eIQhzhAD4w8Ziu84KC/Yk5Z/8QxY1RAld6zhO9+sjTHZFQ2p6o0RP0PA/DlcSk7bgvCBKupaZOUAx32aHOYLlJGOBVMRRQXQcq397E69WFbE/0qGx4ErybRuvWTA9wDBWR0xMX0mdwN7QNBSKZqfk7R6f/6KXZcOzqaIXWt5ItntMzdXAJDS52hUAZ3C7rAkVZA1CAkXHjt+hQsqBZhOeeuj4tAistMI31WxK9hrXU74nO4wfvnuz5kmhvGp3KlyQSEmZXsRt4e9oYtHrSryzykBfjU3dofw+rOpt7rdGkrUQs/OY19h3GvhsYkCgdctsyZfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SA0PR11MB4606.namprd11.prod.outlook.com (2603:10b6:806:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 11:21:21 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 11:21:21 +0000
Date: Fri, 31 Jan 2025 11:21:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, <dev@dpdk.org>,
 <anatoly.burakov@intel.com>, <andremue@linux.microsoft.com>
Subject: Re: [PATCH] net/ice: fix segmentation fault Rx function
Message-ID: <Z5yyJhkN0K9wwU-U@bricha3-mobl1.ger.corp.intel.com>
References: <20250130192617.2744705-1-vladimir.medvedkin@intel.com>
 <CAJFAV8xckXp6mrLcJ=0nCEtygf=s69wSFYUhA+62zvDozN-rJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xckXp6mrLcJ=0nCEtygf=s69wSFYUhA+62zvDozN-rJA@mail.gmail.com>
X-ClientProxiedBy: DB9PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::24) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SA0PR11MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 9563c014-93b0-4723-3842-08dd41e963c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkxHV05TSFV5clFnWGl0WnNVbWQ0bUtXZ3dJaGZuN0FrbklLbWxEVERoZ0Js?=
 =?utf-8?B?MVArL3BNeXZpMWJDOVdPZkNPQjE1K2Ird1k5OVJLMkdza2J6TW9HV016NnBm?=
 =?utf-8?B?c1Rha2FKc25TVmNmNjVjTzMrQ2pyaFhIWEowdkFWQmY0K1RMKzlTSXhSRVhu?=
 =?utf-8?B?TlF3WWV0SjNPTytUNDJEZG5PVklxdXMyelgxdnkya3Ywd0lVcFNLMzUwRWVM?=
 =?utf-8?B?UDA3M0QzY3Z0L2lJdzZqL1lmcFRqVmg3dHpnaXFIallWNHQwWlF1U2RmdE9v?=
 =?utf-8?B?alY1ZzBJUWw0aG1PZWxHbU9tL1lsNDNZN1h3c1B2RU9LWFRrZWg1UUxDQ1c4?=
 =?utf-8?B?K0YrSDQ0RlQ2Y1ZHUnhZbnM0QkJHZVFzRTRoZkhuOTFvNkZxRlArck16STBs?=
 =?utf-8?B?Y1NQdGFYRjh5NHR1TnIwZ0VKbkoweEp0eFErR21LLzRDVjdsQldyU1RkTTFv?=
 =?utf-8?B?ZEhIeFNFQ1l0Nm45MjhZSlNlTVVqQjFmK2hmdldDTmRGem9VRTFoYnRyaXhI?=
 =?utf-8?B?L0VCY2RpcjZXQWJVdWt6aFlTdHlKcFhTWmFJeG8xM0ZYTkNWTW4vOVVWSmgr?=
 =?utf-8?B?V1greitCU1UxWnZrbnRFaEdwb1dibGdMVUdGbk5TTnVGcC9XMTRIeUlXMDEv?=
 =?utf-8?B?bHNFSU9VOUdpVjVqYkt5bjR0ejJoUVpNZ1dDNmxhTEc3bG9LaVNTak9jdGlR?=
 =?utf-8?B?dnEvcnZ1OTc1LytGdFV1SEtMbjBBdU1ESWVXZENqUW45TWE5c2lmcWFqZFNJ?=
 =?utf-8?B?WlpZSFBnamJ3NE9GSzNrN3FyUUd3VkkyUXA5d2NTM3VDTXkzOVhESGJ5Vncx?=
 =?utf-8?B?N1NZWUs4eGhBY0VJNk9UNERLR09ML2JRMEFjanVvUko1L2xRSW01ZU5HVjR6?=
 =?utf-8?B?NFJoSzZTZ1E0S3ZjNmxBVHNwWldQY3AzSEVZd04zUnBhT0tpZmNWRVRGQTE5?=
 =?utf-8?B?ZVdoY2Z2SmFwZ3luTllmczVvN1hoZXFMMjNmajFwcHlqRGtGR2VjRDl2bGhZ?=
 =?utf-8?B?U2xDdGt1d0oycHJYR2s2blNVRnlqMjBJWlQ0bWt4SWN4UEc1YmdYQzdaaFd1?=
 =?utf-8?B?ektTZUxqQkxMSXM3cVFZbTUzWUhOVkY5V3JUdDg0Zm81WXZwUFVVbjRwUDRV?=
 =?utf-8?B?elJlZzIzWnJBQTJ0VDJXbjFmWEdKaTlydU02dDY1L3NOUG9ieFlUdDdUb3lZ?=
 =?utf-8?B?dFEyeXlxMnp6SjNHdk4wcmhmYjR0L25qMHlzOS9UdTNnY1Y0OHByUnBhZFRL?=
 =?utf-8?B?UUhYVWxZV3BOa3IwWXdIVGxkc2tUK1hKNExFYXRzcUJkcVNCZGI2QzNxWjkw?=
 =?utf-8?B?Z0hreTdjbVUrZXlPTEtCQWowQURQbG9qUFZVN1BvOUxMTHphTnRJRWlGbm93?=
 =?utf-8?B?dm9lMEpReHN1cTF4S1Q2Wm1hMmhQQS9lbGNHbENWNThDMVE1QjltakhScm5H?=
 =?utf-8?B?dEFjeDZVUkdRMklMV3lrSFYwVWpqb25ndUFmM09vb3JUQkFYNGh2M241YVpO?=
 =?utf-8?B?YWhaVU5uTElUeVlPZmhPRjkrait0Wm9tdFdIVHRKaWxlcngyYTlNN2NrMjJK?=
 =?utf-8?B?bVJWaGhqSVlxdFpXUWZYZmcyNlJodWxscGt4NEJvOHlaTERxMkdUOVpjbERK?=
 =?utf-8?B?dUtBV0pESm84RDUxVGZBbDJnUU51MVhQVkQ3a2FCTUhZcUJ2NTlKZVoyTVFw?=
 =?utf-8?B?d3RVVXJxN29tNGhodkloOWpOYlVoakgwbm9KNk96Z0QwNXFQUnlHcUdLVlA1?=
 =?utf-8?B?YXZIUy9WMUlJbExSQmVJL0pMMVRzMzhGMklwekZUOHBpSk04VEFxemx1eFds?=
 =?utf-8?B?SEtPbEZ5bFREY1c0Ny9wczdwUXFEenJyOEZVOFpOQ3BNckpsajJqMUI1Z1dE?=
 =?utf-8?Q?yxxhdgGf00zX5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S21zMDhJM0Z0bGM4MlF4RFp3bkJRaFN6dWlBc0s3M3pkOVBqWHFQdFNKRmta?=
 =?utf-8?B?MGtwZUF5SkRLVTJFOHp3eFhZZS9MeDdha2NFMVdkU2VMdjZEOTlJajliOFhM?=
 =?utf-8?B?bzZCWnk2Q3RiMmRHNVRDeVNUZUZNb0c3MVpreVAxMmcvdzg2QWd4NGlMVUIz?=
 =?utf-8?B?czNERWc3RlJjM2loVVJyLzRkeU1DTXpzS3pMYWczb1dmOWIwNDI1eW5iM1l2?=
 =?utf-8?B?SlRma3pYcG55ZnF3cndPNU44VzkzdHl1NjFqUnoxTDdtOVhvSklMSXdCZGR1?=
 =?utf-8?B?cXpac2I5L3RsemQyVVV1Qi9oQ05EZ3BrbVdlZ1pCMDhWZmE1b3lYcFJKeGI3?=
 =?utf-8?B?M3BiaGYrVEhPS2RFL1hGT3pLaG4zdXY2NDRVK0N5TFhhYlArajd2Rm96Mm5l?=
 =?utf-8?B?bnpaUWFZOCtEdDkrdlR5RzdmT1F1Zkx6eGw2Rm1GMUkrb3FzVVpLYVY1eXla?=
 =?utf-8?B?NXVOaVlSaVJ4ZW0zV2Q4MDN5OUxHektNMkpxenV5cDA0cnVzWXh5QlFJTXRh?=
 =?utf-8?B?UHR6WjN2MVFlZkFYZXpXN2cwUDIxcDRld3VMZXhqbU8rMkE1WFJCa0wzRCs0?=
 =?utf-8?B?Zm1UbnJQZVl0N2VDeWlocXgvc2liaWpZRkdEK0xid1BUWUwvS1I4S2tZTm43?=
 =?utf-8?B?YkIvSUsxVjU3bEdhS2VpeDl0T2M4T2xFN3pKc3VUTXMrU2pxOTRncGZxZHJC?=
 =?utf-8?B?aGpLanFsZjRlZDlXVXM0Q3FMMDBhQnkzU0hmb1VaTzZWMFcwN3BONHhCM0tD?=
 =?utf-8?B?bEhTM1NmYUZmN2YvQnpLUTJVZ2FQUlJ4eWJka3ZvSGZTc0VQR3VOdlkvUlFl?=
 =?utf-8?B?MHdiUFNpNm5ManhBY0pwVXl1RHk0cGZ4KzNCVVRGSmVlT3FnQitYRC90WUJV?=
 =?utf-8?B?VE9ZOEgzdzhySXRvNkhJZEYxN21HZ3piR0R3Mzl2MGlVL3RGL3Qzckd4N0RN?=
 =?utf-8?B?TG03YUgzcGplYkUrL0hEU0ZOV0h4VzhLY3k2a2NuZFc1VDFKdkN2YzBIRGZx?=
 =?utf-8?B?Y09SUHI5M3d5cklHRWc0dmVNc2hpRG51NTRSUXg4cUhPL2VtS2lnWm9zYUJh?=
 =?utf-8?B?MWQwVmZVOEhmWXhtVVJxMmpMSFV6STZrd0JFd1ZFdzlEdlg0cTRMT0VtOXNm?=
 =?utf-8?B?UFhlS0ZtY3hBcGF4VUpkeE9KWXFkZTY1clZkYXBUclV6SVpkWVArQmxEYitY?=
 =?utf-8?B?QlpkdVVMNUZMeGVqL2I0SkNYazcxRG5kSEdkNDhyWUFhZEdacGRxR2lYY0Jj?=
 =?utf-8?B?OUd2dmMvVHRVV0VzbVVQbGlrbzNBc1RReXg2UWZKcEQxaFR0NFhsVlJiM1d4?=
 =?utf-8?B?ejAwdHVjMEZOY0F3eUZyQlZ4ditxM21iZDB1dTlsdlRhakJvSUc3b2VUN01I?=
 =?utf-8?B?OGFXQXcrQ01kTGpGM01WSU84TDJJb2wxdXRzUmk3NDkxdmJ1K3IxWFhYQXlM?=
 =?utf-8?B?a3Nicnp0WW91Um1vV0czYno5eUt3bFltS1JweU50NVRBRlZGRldHcTJveUYz?=
 =?utf-8?B?Y2h6ck1BdHVUQ2JFUVpERVNiYnByUUlMKzI1THF3VmpDUTlSeFZLdVgzS3hy?=
 =?utf-8?B?VjQ0aWtNaUdIQituUHBVc3Q0Vm0yYzRVV01DcEl2eTV1K3FtWDNaanFHWGtW?=
 =?utf-8?B?MnBkRWpDUFBRNEh6dVdJaEVwR1poZ0dHZTdMSmpLMDUxUEZpdjdYMTJxcjUz?=
 =?utf-8?B?SkhuN2ppRyt2M2JVWW9ORVpucEFCcjJPamlSL2tmOEsvLzU2ZzRoMGFXU3ly?=
 =?utf-8?B?OUc0MHAvdWJ1aGxUNEE3OFhyaU1zUzJXTis0SmpiS2gyV1FHMDNRbVdsSzd5?=
 =?utf-8?B?Rm4xdVI1NzQvQnIrZ1dIMExPQm5NUGZESU54U0lnaUQyUEM4RGtadHVON2N0?=
 =?utf-8?B?TmQzSDMyc0NyQkJHdy9vdGhuUnl2RjJNTjh2Q05VekUwUVhrNkN6L2I4YmN5?=
 =?utf-8?B?YTdMeWY0MjZtbVdybzUwN0htOFdFTEJ1cmFqSmR3SXZtcWIyZGphVEY5VmF0?=
 =?utf-8?B?Q2JGWi9ncDZBY0EyRDEvY3VPZ04yUnd1RmFmVWRlclo1SFNaQ3NTVUdVMnAz?=
 =?utf-8?B?cGZsNTh5MjRCMVpwSUhSdWthMWxkV2o0OGtuVVk4QWtpN0JxOFpvSGpNaDN5?=
 =?utf-8?B?ekF2SXdsbnE4ald0UngxN2prM0htTXBxdWlCNkQySmJQenM4VWFUOGpVcXVk?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9563c014-93b0-4723-3842-08dd41e963c2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 11:21:21.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVh58VrVIyTEl6Rf7o9cV/98b+p8XA0IG8lHQdFHmliLQrWrWFht3E/r+bxtZPNlQE889MskxOblxnAkVC+MGQhn06bhO9Ee67001A31heY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4606
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

On Fri, Jan 31, 2025 at 11:43:53AM +0100, David Marchand wrote:
> On Thu, Jan 30, 2025 at 8:26 PM Vladimir Medvedkin
> <vladimir.medvedkin@intel.com> wrote:
> >
> > Fix a typo in avx512 rx function, where accidentally the _mm_load_si128
> > argument was passed by value instead of a pointer.
> >
> > Fixes: 43fd3624fdfe ("drivers: replace GCC pragma with cast")
> >
> > Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> Indeed, it looks like a typo.
> Sad that the CI did not catch it.
> 
> Reviewed-by: David Marchand <david.marchand@redhat.com>
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel
Thanks,
/Bruce

