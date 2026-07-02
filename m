Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A37C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 11:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A479402C5;
	Thu,  2 Jul 2026 13:07:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id AC95140265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 13:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782990425; x=1814526425;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lMcoqlLuR31E6TtVQgCj5GARfuZve0p8dLnwZB8KBnM=;
 b=ACpuH/YyX4g7uQbqT+nm3T+uiFnynpZDWIzHqNNXhamOd7BP0tEVb8LI
 v/dLfdew4SWzfPZZC2MgjfXRgGcpzk0Pb/Q2kAMMs0e+buINV0sOoTN0H
 sDJE4cRW4ySrRA2u5L6OOoG2kWyp3VrqA4VxbyjFRU25LGFvVBXu1G236
 aM00sFsqB1RqZBy7g+b6CyeATTOUZu9zYyyOdbQx8BwYWgMZL2m8Jmoi7
 PdEPKNW30oJKjpqwmbpIS5RxNpDTh450Ou2AA1YAqt3k2WjFh+YyIW8jK
 04kPOKufTLhiIcTkSDz7reIYmiaZwH1/CvmAzAvLmtcvoginnTeHqDzbn w==;
X-CSE-ConnectionGUID: bNVq8/S1QymY0OWxfmQmOQ==
X-CSE-MsgGUID: MzhsdFKuS5GNgJSS0Gvo7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83831353"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="83831353"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 04:07:04 -0700
X-CSE-ConnectionGUID: OkorHyg2Tm6jrlVd5/3pLQ==
X-CSE-MsgGUID: Lca15oGqQI6x8Y1CTlUXKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; d="scan'208";a="277158718"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2026 04:07:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 04:07:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 04:07:02 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 04:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vS9D7Vm1xsoi2PmfAjXj8GFNBdaAb8yd/2wpL5HSYl73PlJVl9KAIRjbBN2q9QgbbmOianoyTHOuxHLLs2Nn/s3rgu5WuTgtEErCDV0FqUbUkc6fQ41ogHB/tUPQ0tRkTfpBiHqzrYVKfwtwGNrJ9OSmggvN5jso8zmg+CsYWgoTNNIjSJG5XKXmsMFahmeOm2lXeJxFGfC7ntHpBDQUcsGT/UiWNqgaV4s5PFjQzZmkQX7SSyc34Q03d6Hrxz1C0ItjFNiNAFYqOpds/QLjurHsaVAOgHs/JB7CpmCVfUqNvBU2HczlRo5+17WoYKqRDlEyXRHVqbtkhH4tYyc0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFq2pmQdKjrLAnEKC+kFIpFd5KOmIZPl209DCnesRjw=;
 b=MetQSN0EcWRKqkoQXNLtTCLki/EZtGv4zYAlf5w2iYYKPZmqYqntQqtTPlxCMsppQyHDd99/WNbqTGt/Zv0agRqoeem4YrQLXZmbQLvmni2U+qDoqVVcIPLoM6o4Omd+FBxWKaSaFxn78/195x7KSdraJkl4IY2vfYT4ky2LwXv3Hw+plaw3DXArMHQ6OENeXeHH6qbUl2it71g/eGwxwbCGJi5x7qISJg+cMORIKuThm8pYMjjDbgvRm59nJzWpnNTKuB+CWlxcqtVAsd6h6glr3KqjuqcWalW+teYmIxzHsZyDNJq3Ew8+wg2hgDT9vttA/9I8MdLLPd4O38V99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9)
 by SA1PR11MB300021.namprd11.prod.outlook.com (2603:10b6:806:51a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 11:06:53 +0000
Received: from CY8PR11MB7897.namprd11.prod.outlook.com
 ([fe80::159a:3f92:c266:4ec]) by CY8PR11MB7897.namprd11.prod.outlook.com
 ([fe80::159a:3f92:c266:4ec%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 11:06:53 +0000
Message-ID: <6df97f76-27d7-49f2-8d23-30601c12ca0a@intel.com>
Date: Thu, 2 Jul 2026 12:06:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] examples/l3fwd-power: fix uncore deinit for
 non-legacy
To: Huisong Li <lihuisong@huawei.com>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <john.mcnamara@intel.com>
References: <20260526081138.1434947-1-lihuisong@huawei.com>
 <20260526081138.1434947-2-lihuisong@huawei.com>
Content-Language: en-US
From: "Macnamara, Chris" <chris.macnamara@intel.com>
In-Reply-To: <20260526081138.1434947-2-lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:10:232::17) To CY8PR11MB7897.namprd11.prod.outlook.com
 (2603:10b6:930:7d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7897:EE_|SA1PR11MB300021:EE_
X-MS-Office365-Filtering-Correlation-Id: 0673cc1b-4f84-4ea8-7cd7-08ded82a05f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|4143699003|6133799003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oPwrFkGEwhn9zXRhli/jQMp6ldy8Bgi13WmFcOWAHAM3VJwwKDlQmDw8thy3cH2QOIInJOr+hLeKydGodn5ZC7tssxlnnAa+3ZoGZvEprde8fgodjvMefLU5b+SoGIeqcZr2GfCO16olWe70W1itg1droAKXuPE6hhwhIxKq5y3iBKIauxPO2B1Jt9aJ3TRvh4pGJhOpkCeA2rhCKAKssV9BoAc0hsZkIlgA28vbzZwKTDltSog2CDoHT+tNn+T0GMGZSPEPCeJyzqKRiQgUBF9ggvCYwd1Gj+i40UYJaSSqR7Fkkvt1XSNfVu3e1jxtCbW30GeQ4LuCKlmghUPOCV1QQBmWsOtfybylZMAXm8nwDVtTtu3N/3+00IBgdvn37S11eIRPN4ESCf0YiWtJuWe5guqMcQbyBqz5nDywQXRzjGBWb8rWSCsQjPZdC6AUxnSW6sb2xLLxunPSSHRn+w1/tUug37Ajja9itD5TWS1FCfqHiYO7H0QP1/Bo6zXykxV4vGvveERw1SN/ZwjMb8MO11e4htHlvqLqDgRLMQsP36qryDGRw3ud+UIou6/QKzMlMfJK9Ylxvpe/ZkPjRYabb4TexQSpf0qty/zKZYTxoMoB7X8A/yiOY1Wqiotsmuvq/ntkLASEwxnLR/747TUGP+z0E4OfhwqR+J/O4u4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7897.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(6133799003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3IzY2ltMXpYUlBPejVzelgyaG1OYWRacENUNmhYRWIwRWZscUE4ZkNtaDd4?=
 =?utf-8?B?UFNRR2JCQThWL2JvL1pUYnJ3NHVubFo0elVXSXp4R0tWdjF5MjM5aTdIQXo0?=
 =?utf-8?B?bFIwQlNlUFZ6aXA1UnRUYmp5cCs4c1Z0TlFabjVKZWcvZlo3cDJQTVNtclhr?=
 =?utf-8?B?OU9JV241TUNZTlVZZGk5Zmtxb2RndGRnNThSTGNnT1ZSMVR0LzZpSjVWY2lp?=
 =?utf-8?B?L3BTWVdDL2QvbEdPRDVQZEgxSmgrRmdJSmtsaHIxUlFhU29FWHlpZVQxb21y?=
 =?utf-8?B?andpUjVNMlA4MnBOMWpWN21KYk1mcnFha2kwR3ZVWlYwM1BuUmZDMTUzZ1pu?=
 =?utf-8?B?RC9uOHY2aHNNdngyZTYzN1VBdEZHWVAvNU1mQkUyNTNKRDRxa2U3blB6UEhS?=
 =?utf-8?B?SzB5dHc4VmpRNlpjdERYQXRwUE5QYkF4TTZtSWZ4ZUpnYUZqSXhtV0FZbjRt?=
 =?utf-8?B?VGttdDhwV0ZSajc4angveHdpUXNENzBOckpMalk1dGJhdWxuRDFYUURCMUpq?=
 =?utf-8?B?dG9SeCtTeUlCVEZ0bmFxTDNMS0RlVGdORXNRVGFqTXprb0lHWlFXVVhPWWJn?=
 =?utf-8?B?elUxY05Wa0pBZHA4Y3VJVlBsbGpwR1orakdSdXhpd3dMc1JycFplVmVDbm1k?=
 =?utf-8?B?WU9lWXNsdW5IdytGTE1jYzBhYUQyaTJ3cDdYbS93bXBjYmdFRFFkMXlQUGpW?=
 =?utf-8?B?UEZyWnFENGk1Qy9mc0p5WUN5UmZlSWY0RlJwUTlHQXd5RHNvZ0QvTzNneGRC?=
 =?utf-8?B?QmhoK0FZb3hhNWlocE9lZVI1U2l6dDV6Slk2bTl5REVLYzdPSjlBY3YybFN4?=
 =?utf-8?B?Qml1Mm5Pb25FUmU2SmlpTTQ1SzJTQUNhNWthZUFQVXdibnVtL3lsMWphUlZl?=
 =?utf-8?B?WCtzb2lac2ozYXBoNkw2NS9pcnQrUC9URktnK1VyZ3k3ZUJ3bjloZE5sbHkw?=
 =?utf-8?B?NUhhRjlxbDV3bTRzcG82TG1BR0EybmgxOHY3emYrNGN2ZmtNSUhhSFNHSWxz?=
 =?utf-8?B?SDZCRUM4VWl5UllHenAyYnBDRGFuVDl0MVRmT25qRG03V05GbDdxcWZQTTBh?=
 =?utf-8?B?NDhRK0gxT2JRQzVSMXJHTTZrQ05FRDZUK3VJM21FNzk4YnVkREJvUU93YVpa?=
 =?utf-8?B?QVFpTmFSMUlVRHZNSHN5dlpsRDBBZ09IYU1DYTlQUEx3S2Q5V3RvUlZQTFc5?=
 =?utf-8?B?aXZqeG1ZeFVPR2pxU1JoMWc1SGdlbHhCWXBlemxnNDU4R0Z0L0crNGtleWFs?=
 =?utf-8?B?ejRpQ2RrRWZ6aUpBbGxQZ1B4dG0vckRZc2dXdm5GR3psakZqa0c0cU1Xb3g4?=
 =?utf-8?B?UmNlUmtDem03dmwwQXQyN3BJS29XemhOMUduekg5dWhMWnpvMVY0ZGI3RGE3?=
 =?utf-8?B?bzFVczdqTHE2a3poY2RuekdvTWRTTEVBK3g2bXV4bkpxeSs1SkJ0UlZHaTlQ?=
 =?utf-8?B?cDR1UUw0R3NjeEF2NkJLQ3FZOWlxdGVFZ3hKbjVLbXZKWmJtbWdBMEVTZExI?=
 =?utf-8?B?NVliZ0pNWC9DeHZlc1IxUnhaOE9telQxZ0hKdncrZDJyNmpvMy9GSE92cHJs?=
 =?utf-8?B?ZlBrVktmVHdqa3VJcVRkS2duNFFrK1I1ZTdaVTRLeFI2UEF4SGNmbDU3UWUz?=
 =?utf-8?B?Z0N3bG9GR01HM0dPU2l2NmZPSGxKZmNySC9hR1c1S0I1S3NxYmZRSlhwT2RW?=
 =?utf-8?B?eXB5bjdPeEJ6SEk5WGFQN3BTN2NrY25EWldTOGNnT2lzZlRGaTdqSG0rSlhr?=
 =?utf-8?B?QnluQm1ldFBxVTQvczZHeFNjMk43MTduZWFHWllZc2JhOW5iazl4cmVWUFJ6?=
 =?utf-8?B?YkJZQVVrOXNGOVhJMCtyUWQxMWRXT0d4TmxSdkdkOVVNZ3V5Tmg3WDFHejht?=
 =?utf-8?B?YTNHQi84SHE0RElhTWoydzRON3VnZVg1WS9vYVBzbFBwNFNsaTl2QmdCR3hs?=
 =?utf-8?B?bjZrMGhSZm9zdHZFSWtIeFFsakRGNjlSUFd4Unlyc2s3eGhDTVJBaml5ZFBY?=
 =?utf-8?B?RU1LbjZkQjZtdFdFQlBvSk9Ibm9yMmpRYWRwS2xWTE9TVHdpS2JCV3NpY0ZV?=
 =?utf-8?B?UGVsUC9tTXZxMURLdVpwOFIvL1VzdjNJWnkrVzg4Tk8rVlh0MW5ZNXhyNHJq?=
 =?utf-8?B?UDJwWGZUSEk4a2JTY0t4WDhwVjhiZ2crNlpNS2ZiakJnU2VKTHl5NkovK0c5?=
 =?utf-8?B?T3B6WC8yYVNXSW9hMVNYeE1ySXcveTlhblJjb3RWY1l3S1dHdVAzVDlndFdj?=
 =?utf-8?B?SWJSV3ZxS2RVTmRhendnT29TVlN6cTlTckttdkdqbk92UmxKSG5RNmRrcFJl?=
 =?utf-8?B?WjdVV1hUVSt1VWljbklTS1ZnMFpTVGNlL09qclVMR2VwbFdoaFdwdz09?=
X-Exchange-RoutingPolicyChecked: Oz/v0/L1uGWQPVwLs0Z6ccFq01CP/8gsGV5t4TtAnc3lNzXZLThePpfAWbKNOaMSZ/AeVfBeTW5+scepYRwEETPPb94UV38sfgfjXs2bZW+MK1mdG+mUb9uk/C1l3C9uPlZ42VOazBDnlormjKt64ZmdcQ+XVi8lwfmftDsn23Vd54k40JRlXaG5URTuV7Yvv0zof4wPxZSFPFrODg6pIqIa/I7imtRk7BufkNCA0bSkjbujO2cjFb2O8P9duw+n1DdCDwRmCk6EOtKzr4eNXEufkyIU+tKdkG1oMV9LptI5mSBAY4BWPmqh9QAKRJO34NeJ3AOrOQA27Bw8lRnH3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0673cc1b-4f84-4ea8-7cd7-08ded82a05f3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7897.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:06:53.4865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJfynYel6LdFwI34t4pn5DjLszO0XZvaeCapXreuxZquZuuTNRmxrw/BEfSeUqK6QHP0j/f26320sjKkAqSDg6WamrzCDUHGmzPKtkc9iTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB300021
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

> Uncore resources were not being deinitialized in non-legacy modes (such
> as pmd-mgmt), causing the uncore frequency not to return to its original
> value after the application exited.
>
> The root cause is that uncore initialization can be performed for all
> modes, whereas the deinitialization logic is incorrectly restricted
> to legacy mode only. So do the deinitialization of uncore on all app
> modes.
>
> Fixes: 10db2a5b8724 ("examples/l3fwd-power: add options for uncore frequency")
> Cc: stable@dpdk.org
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>   examples/l3fwd-power/main.c | 66 ++++++++++++++++++++-----------------
>   1 file changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
> index 02ec17d799..1122aeb930 100644
> --- a/examples/l3fwd-power/main.c
> +++ b/examples/l3fwd-power/main.c
> @@ -2271,28 +2271,31 @@ init_power_library(void)
>   	unsigned int lcore_id;
>   	int ret = 0;
>   
> -	RTE_LCORE_FOREACH(lcore_id) {
> -		/* init power management library */
> -		ret = rte_power_init(lcore_id);
> -		if (ret) {
> -			RTE_LOG(ERR, L3FWD_POWER,
> -				"Library initialization failed on core %u\n",
> -				lcore_id);
> -			return ret;
> -		}
> -		/* we're not supporting the VM channel mode */
> -		env = rte_power_get_env();
> -		if (env != PM_ENV_ACPI_CPUFREQ &&
> -				env != PM_ENV_PSTATE_CPUFREQ &&
> -				env != PM_ENV_AMD_PSTATE_CPUFREQ &&
> -				env != PM_ENV_CPPC_CPUFREQ) {
> -			RTE_LOG(ERR, L3FWD_POWER,
> -				"Only ACPI and PSTATE mode are supported\n");
> -			return -1;
> +	/* only legacy mode relies on the initialization of cpufreq library */
> +	if (app_mode == APP_MODE_LEGACY) {
> +		RTE_LCORE_FOREACH(lcore_id) {
> +			/* init power management library */
> +			ret = rte_power_init(lcore_id);
> +			if (ret) {
> +				RTE_LOG(ERR, L3FWD_POWER,
> +					"Library initialization failed on core %u\n",
> +					lcore_id);
> +				return ret;
> +			}
> +			/* we're not supporting the VM channel mode */
> +			env = rte_power_get_env();
> +			if (env != PM_ENV_ACPI_CPUFREQ &&
> +					env != PM_ENV_PSTATE_CPUFREQ &&
> +					env != PM_ENV_AMD_PSTATE_CPUFREQ &&
> +					env != PM_ENV_CPPC_CPUFREQ) {
> +				RTE_LOG(ERR, L3FWD_POWER,
> +					"Only ACPI and PSTATE mode are supported\n");
> +				return -1;
> +			}
>   		}
>   	}
>   
> -	if (cpu_resume_latency != -1) {
> +	if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
>   		RTE_LCORE_FOREACH(lcore_id) {
>   			/* Back old CPU resume latency. */
>   			ret = rte_power_qos_get_cpu_resume_latency(lcore_id);
> @@ -2329,14 +2332,16 @@ deinit_power_library(void)
>   	unsigned int lcore_id, max_pkg, max_die, die, pkg;
>   	int ret = 0;
>   
> -	RTE_LCORE_FOREACH(lcore_id) {
> -		/* deinit power management library */
> -		ret = rte_power_exit(lcore_id);
> -		if (ret) {
> -			RTE_LOG(ERR, L3FWD_POWER,
> -				"Library deinitialization failed on core %u\n",
> -				lcore_id);
> -			return ret;
> +	if (app_mode == APP_MODE_LEGACY) {
> +		RTE_LCORE_FOREACH(lcore_id) {
> +			/* deinit power management library */
> +			ret = rte_power_exit(lcore_id);
> +			if (ret) {
> +				RTE_LOG(ERR, L3FWD_POWER,
> +					"Library deinitialization failed on core %u\n",
> +					lcore_id);
> +				return ret;
> +			}
>   		}
>   	}
>   
> @@ -2360,7 +2365,7 @@ deinit_power_library(void)
>   		}
>   	}
>   
> -	if (cpu_resume_latency != -1) {
> +	if (app_mode == APP_MODE_LEGACY && cpu_resume_latency != -1) {
>   		RTE_LCORE_FOREACH(lcore_id) {
>   			/* Restore the original value. */
>   			rte_power_qos_set_cpu_resume_latency(lcore_id,

Agree there is an issue with uncore deinit.

cpu_resume_latency & init_power_library: After this patch, 
cpu_resume_latency (for C-state PM QoS control) is gated behind 
APP_MODE_LEGACY even though it's orthogonal to the cpufreq library, so 
it's silently ignored in pmd-mgmt/interrupt modes. It’s used for C state 
management which applies in other modes such as interrupt mode.

Also init_power_library() now has both its blocks legacy-guarded 
internally, the newly-unconditional call by removing APP_MODE_LEGACY to 
it is a no-op in non-legacy modes. This leaves the two functions 
inconsistent: init_power_library() does nothing outside legacy mode, 
whereas deinit_power_library() still has real work to do in every mode 
because of the uncore cleanup.

Consider, keep the APP_MODE_LEGACY guard at the init call site as the 
init is truly legacy only or split the uncore teardown into its own 
deinit_uncore() so that deinit_power_library() stays strictly about 
cpufreq.

