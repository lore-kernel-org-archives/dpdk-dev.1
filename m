Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEA3C982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 14:00:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0666A432DC;
	Fri, 18 Sep 2026 16:00:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 28DD340285
 for <dev@dpdk.org>; Fri, 18 Sep 2026 16:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789740002; x=1821276002;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=vuqMi6fsUNHhcywxx7L/OvN8YfjoOoTRqeNA2rKau5w=;
 b=nsl105qVQj1xJStMaT0XKsicZneDp7waTOyai+9eJjDoi+vyObm8B05q
 /WIFjJ8fE6QuuOH5m5fGTnO+BuTJQb9ldXLdEC04EOyrhQE8JzNA1kgxx
 JAD0utp7i0Vii4hShVI7/GD1+DZlkW0RfOEfhDIiNQS0lzwQNq9/PJ82o
 tkToH8VolFPNB88LzF6Tir/Qa4v6s+4ujzSIkdP7Bv0qAWUgaXlMaBp2o
 j1SFc1vCAxjz+vDlceijFGrgxtplaG9sqo++d3rvQJHXSDrXJPaDRrhzI
 zw4oUlSmzuFxgXP7VJOM7HwMuoEvg9eAtfPz/0j0sv9bSlOIogYEcnq4Z A==;
X-CSE-ConnectionGUID: enOn9DGOR6qqrsBoyh09zg==
X-CSE-MsgGUID: fXutWLAIShOQLiPPrg4D7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="107750854"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="107750854"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:59:39 -0700
X-CSE-ConnectionGUID: rkfMRSjRRUGWIZwzRtE8sA==
X-CSE-MsgGUID: UjV6I4znTqeMHSvI+SZmXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2844669"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:59:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:59:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 06:59:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 06:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suvFLyuTlY+NZ+P41VfW5hoQSp+uK3mKWHGVEN4DnFG8hPBf3w+whrofkXFA/HHSXxSVuPrqeuMfnC0fgEWMuNCHaUqSsDc22B+19bd8wHFJHm9DZlWzCQrCJv1Brw5HkIIA/bQTf2ZuImurj52jN3ayVgAfTBt4W6oFbNvZ2tcYhtLWrtjy5+C6/AlDSrIsEsxs1mDFK4ruej7z79VI1IRlffAC9pdi4FNL8UbHW4wFGuwaL+icAOawx+f/pR9zcduhsq6AbMv2NwR7+vKOPjSSeWClQ8iQ/Q3dbB1KbWY7FgMuXkcRv7SUYIlz1qcy9ue3R8eA8Qo5J395++JjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuqMi6fsUNHhcywxx7L/OvN8YfjoOoTRqeNA2rKau5w=;
 b=mYZnYfkfgQYICsOCOc0fp8rvOTOMxH55BGpNvmbEzCNm0tw2tD4Woqx/X9N7tDjqkrTsFyHYYLWVeuS2DTat3KoLfc443itHkyPVviw8RW1R0elMvQXTgP0aUZZTfAaZqnwEMz2IoMo01zH8QS15PueYa/M6mrixhqFdpnqouIxWW9gd0MJ4KvFWrM/c2iNjaO6vkiJb9P00LVBlkaJQrV3bJ7fbOWq3EmHEtHkrvtA9nGyJDKeJovOG6r5cSQm7c2Yr0V/uwLKDF1D4qaz0wMb7tSCpQ6XcqZcoZ9gppgp7qZ0tz4ysOTnKknKNzPOog3mJJKn03M8oNMKZD832Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SABPR11MB9940.namprd11.prod.outlook.com (2603:10b6:806:4ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:59:37 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:59:37 +0000
Message-ID: <c0085431-fed9-400d-844f-02fb0d8bc363@intel.com>
Date: Fri, 18 Sep 2026 14:59:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/iavf: fix resource leak on IPsec init fail
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Qiming Chen
 <chenqiming_huawei@163.com>, Qi Zhang <qi.z.zhang@intel.com>
References: <049b6e36e7303a5f5c9ce96a3bcb116fc8c25af6.1789461413.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <049b6e36e7303a5f5c9ce96a3bcb116fc8c25af6.1789461413.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::20) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SABPR11MB9940:EE_
X-MS-Office365-Filtering-Correlation-Id: ab474687-4cb1-43c3-a347-08df158d1362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aC8r4//mUzSCqoZCnbVrZTSIvU93KKZc00k+53nXzqOR6wIn/8w5pdyWOulXNf6oAZDMkQr25VaFwuxhAQQb/8hju6unHx74v8fsVUDob3/+4JgTbYY5MVNsLP3o8MB+yS6JgkX0ncZeUY9DMVgvlQZ8iWhO9iL/KAD5v3Vh29TZlepXeWbZJ7OC1nkrYKQs2P6PC6uEOatO7Da98gOG8shWs0qvG5v+9WXdvD/FTLfNV0FWAkMhrGB9b8cVNCn8L4q4lfKj2vUoQmI4+xzyjdVma9QEQUxTMbz4PuCOXZSw/vcwsbi67swa7tUhItBF2Sv6Zi8xgm++HAbr9dDkN+Mw181S3OHqh0KlUn7F+NATFKIA6yr2NitC72IBSN0ONv6YhibBdzTkqqBDwQYRvA7zOFA0q9nOLA9lEs5Va5unFDEOqHxCIAqsEH5HLtEoYYOo0y4QuNlFtSeBZAXZVzpvGAaAU9AQT3JH2TFlJ5SKYDFmB3CECldm0ITYcwzMBdQm85tqolVGEAGeEJHEYBVp5tVnp5vv9he24221pknqTUaIMiFiepNqVDDBLeMn9WzjqV74J2K5Hz3SN4TiZIsKAdPsRkvOwHW2nARBBnfzP56NII922BB2ZsqdsXeYv+XaSqGcb6vcWl6tJp/J/jtgfPdRAaq0tL0z6skAT44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c084bVNpN0J3aEwvTGNJcWVTTDBLQUdPQWVFekV1RVlmSW8vSmtkOFlGN2dC?=
 =?utf-8?B?b3hiRUpQbUZrUXZmUVBXa2xsUFFURTNoZGVmUUJwcmcvbENCcXVSQzY3ZzhL?=
 =?utf-8?B?UEhZY25UWU9MU21mWmRKVW5tNVJvaUZtL1lUVFRxQWdFZlAxTzNjcG9odkZ3?=
 =?utf-8?B?anB0TVhVMUQ1dG85MEpiZ0RVZjlDOWdycHBGRWFVQ21kZnBhM09RaWRRVGZT?=
 =?utf-8?B?TWIraEVKRzh4K3BUYzBUZ0dyNVQ0cDFmMDRjcHBPRkRxSFVhQUhwRmNQTDc4?=
 =?utf-8?B?aFJsaEV4RlE5eVIzbUlCT2V0Mlh5VGJxalU4R0JUeXJhdXJoZURia1l6eE5W?=
 =?utf-8?B?cTJKQkhMYTBiTTVCMGIxUWxKQmpTQXZvZVpoUnBEaDdabWtoQ1lmNTQ5MS9q?=
 =?utf-8?B?K0JKUUFSc2xQWkRYSVVLZ0o4N3NPelNyUkFCbDNWaTVEN012K1UybW1PVGdN?=
 =?utf-8?B?SVVseVZKY2FSVVRoT2ZySUh3aVFXZWF5YW1YQ2wvRVVHR0hXM0pjeTlvejhI?=
 =?utf-8?B?VG1aODl6cnE1aTVqOWJteFBjZGcrZVZuNVpoNkpoaDhpa3lZOVNOb3kzUmNV?=
 =?utf-8?B?WTlZbkJUY1pMQnR5UWcyRDFKelZhWnB3eVkxY1lvUnNMWHprbTM2NDNvR1kx?=
 =?utf-8?B?SnIyZkF0Yy8rcEVSOHdRczN1NDZ5emZUYkNTRU56Unl5MFdXUHhqekVZYmZ0?=
 =?utf-8?B?QmkxSlJWUkw4RkloYytndVFqTks4NUZlYW01cllFUjVmdkJpQ3BoOXJCcmxh?=
 =?utf-8?B?RVM3YURkNTE3UmxhNkVqa2dlR0RHbUNtMzBuOXUweGdFaDlNNmRFNDNtUW1s?=
 =?utf-8?B?dXA3NmpiVTd6dDk2MGE4dXFnWW82OHkwRTZ4R1NXQUMyaEJ0ZHZlZkZ0eHJK?=
 =?utf-8?B?b3ZOVW9ucE0xU2hpckw0NlJrUmVudXcxeWVhZWFELzdVVzRFOXdwUWcveFp3?=
 =?utf-8?B?NDJYWFkrNHBVN1dKR1ZocnFkbW5wS00vUC81TjV0V01WRkM1MjJQM3NKYU4w?=
 =?utf-8?B?NW5ud3V4RXo0NWdpeER0dU9NNFlqdzYyTE1xOWhXOGRuUjNNZjUyUUVZRENI?=
 =?utf-8?B?NVRMYmd3LzB2ZFlRYldSNmRld044ay9sVFYxQTBpQUh3Z1dXTElOcGZMRnYw?=
 =?utf-8?B?SXhtT0dyRlYwajI2U2NuQmUrKzZCUzR6czkrejZVaVF1Yk4zM2QrQXNVMDZP?=
 =?utf-8?B?aTdOUlBtcmpsc0RET3Z0U3dJWWtPYmFvUVFmdE00NFBucmJoNVM4RnRobStB?=
 =?utf-8?B?ZWcwQzJXQTlXVkt0amY5akswemZUdCtPSUs0cmtaSUd3TzFHeEFyUk93ckh4?=
 =?utf-8?B?WTJQamQvcXBUaTRWN0tXS1daMHRrZUVOMlF3N21GTk9oelBCNlg2SFJRUll4?=
 =?utf-8?B?MW0rRmxQaFdLeDNpemVndFRjc1FhSUNuMnhIY0pLZFEvVDFpMkNla08zWGc4?=
 =?utf-8?B?dE5WeUtlVmxuNXhqQ0VQVmI3Unh2Y0VMeU90azNPbHpEY0Z3TW5GUnhkQmF2?=
 =?utf-8?B?OHlrYmRVZk1vNFNLYTVqcmFNOG1UdTVqZllNS2dOb1ovWURVWSttamd2Qm15?=
 =?utf-8?B?eTBCYkZYZThXNUxrVnF2RnNQQ1d6NHpaM3RlcjNQdkpQTm9RQTAwTmU1Z21O?=
 =?utf-8?B?RWNvSW81V3djd2JDVDdMc0tYV09hanFDelRuWHhxNCs5cm15ditWSlZnVjVo?=
 =?utf-8?B?OEtJdVdFL0JFSnY2a0Mrbk1FTFM0NHlBZEVJWEVFc0FDUHVvWGJFMXlaUktE?=
 =?utf-8?B?WkdPc2tMTzdvdjd3WUo4SmhVMEZDWkJ5SXVoak5JNmlnbUdYS0pSbnhTbzhX?=
 =?utf-8?B?cElwVzJrTEExMzd6VEx2ZUtTUnZ5VzRhTDhHYW1uZ1VsdEt3OS9yR0E1dExU?=
 =?utf-8?B?dDZNVFZwcmNvbC92eUpJVG1BcmNnaDVvSXo1ck5jZGJEN1RhODF5d293b1d0?=
 =?utf-8?B?TzhYbHBDZ2lYSVR5d3VKakIwbjJIRU43U0kxeTdSMVRUWWI2eEtsRkJLSXJ5?=
 =?utf-8?B?ZlRjZllZRlJEdVhON1VXU1lTcFZ5azhZVC9TSkVmalcxQ2Y4bDM5UGJwS1A0?=
 =?utf-8?B?dCt6YlFIamRhemlQU0RZcjBFdFRvN3IybDBCanF2a2dzaTNBRXVBNWdFcExV?=
 =?utf-8?B?VHZsZ2g2K3RuZHE4MndGaW4rZ2dta3ZaNytleEpTbUd2cTdGaHNmcktsWjh0?=
 =?utf-8?B?M2xTU0pQQmlxd2paU0NvZDVUV0NQVklJWDhqWW5tc1A4S0U0U1k3YVdPbkw4?=
 =?utf-8?B?RFFKbHo5U3lxRjdObndxYVpjaXdHelBWNDlHTUZaT0EzVTBqUzJEZ0pkc3V6?=
 =?utf-8?B?ZmpKbTJFV0VnTFJKbjdyVWFiMjNiVzExZnM5VTFtYlRIc1lXTEFHZz09?=
X-Exchange-RoutingPolicyChecked: Y2CsQIqcG1Oq9YueqQzWIJA4qzJE9kG5H2E7AVrZARqQkWD+b2clUoZG7tmQXu9YW72mMcBkavGraqcUgBFR6kMW6jN4A/OBg/d1/0KEAGrqnXltHing/iNqDBBvHFJhLNxkwOh/tJqSDvAR22lpsVPwaxHG0cI6x3sWpIa/8NKuJqnEA0voLw4Map990bloC9aoCNCDi4JbRuYkRAWbIRzKAZOFZnFyRCvrj3JNDZJfA0Ww6bbO8T4BkLa0rpPvjneJwpttd563XC6HE2eaW+HUCGG1OCQuWbB/ump+/pIEAXsCUXweM/Sg1HC9YYLfK0wUnLnY7STeo7p9EJNbvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab474687-4cb1-43c3-a347-08df158d1362
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:59:37.2211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yboZK5EpPoWEEd/FbbvTgaFw+wAgEP2fDxcYEl4o2SqJDGAEOltfkAs/x4gBdw4ck5nMNNU9iYfF/A+h4E/iDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9940
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


On 15-Sep-26 9:37 AM, Anatoly Burakov wrote:
> Currently, during `dev_init`, we try to create a security context. At that
> point we have already initialized the rte_flow engines, so any subsequent
> failures must trigger flow engines uninit. However, if we fail to create a
> security context (or if its initialization fails), we do not uninit the
> rte_flow engines. Fix the code to do so on failure.
>
> Fixes: 45570d7e4439 ("net/iavf: fix resource leak on probing failure")
> Cc: chenqiming_huawei@163.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
