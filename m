Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF04C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 11:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F36B4028B;
	Fri, 11 Sep 2026 13:17:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 2623440264;
 Fri, 11 Sep 2026 13:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789125429; x=1820661429;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hAkgyTwpTskJx9zhyJ3ZyrBNTxHsTH8qOzpT5jNOBP8=;
 b=GLUXr/bYXbRCup8Fl5h3K0GAYNl61F7Jxubz3q7JjK9OU3M+u03r8Wgd
 y5u1zN1a61fAG9rwwZ1g26VrR4ChJwURO96Zz+tOXo4JsO1T+qK9dkom2
 +EibqZN5wjwlirgnNrUGArcXE7mQKURywDpDiRL2jSqwWNsAFMjFUV7qI
 V3N3R05IDY81Yq8KRJB1goj92BaZGDz3KLPB/fknLRoTZlsEic0cqP4iA
 oqaXgI3hiUoY+c/o4AuVvAZGtVarUx5QkSqzCMNEQlnnh7SL+eq1VzIfx
 rRp5Y9HM39T4wZagaMVXnAoPe4Vb+/xlv2w+LsOu7St80x2a/f1n1Na6p g==;
X-CSE-ConnectionGUID: NfxVJ/y5SuKYU8jXW9GPsQ==
X-CSE-MsgGUID: eVvSgzDpQ/Ceh4EUCOx/5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107100463"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="107100463"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:17:07 -0700
X-CSE-ConnectionGUID: mtPGNJjfQAqFiCrru9J3yA==
X-CSE-MsgGUID: v9ROmMALQteAo/h+4sk/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="177247"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:17:08 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 04:17:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 04:17:06 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 04:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiWH34sHO38+s/6TGc44cc7Ck0S8/dKoSmr3T4DRRfDLnRULP2P0lp++ViFfITm9zk4VJBLWmEPP+Re0XiomgaAfBNrWSzEd8q9c7Yy7nSEZaAh59Pq/75yaELiKl3BR4nvXhz5LITkQn4ytMY532ag/ou6rjtPjfwiaDtAwkm6Pc0owfrDZXxdtvYamS31sZHQDQUMY2zTH6VthxS3OQ2kPg9NF1RbcMIIRtKRENNS2WXMxTQf8j2PYsfKdncO3uHHe7BY4GilYQbE5kDTWcXf6y95dV2pe3A7jm7jpsqi6O9n56qIIl8g4saroSzn0ry4HQwOTz8/Cr3NLKWSGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qOi2z8FtqkhKgzxN6nnw3L6ZwCmqIKf8xyXC9/JVrY=;
 b=eGU3OTbcd9s+6G3MFNLezUCf9P4YIjnhxVxNm+KaW/NDrtByDUF3/LKIVVxudXGgHkIlM+mx5VfLFcfa8kg74lyq9sZePU6Rkbf7pq09gmzwfIPueeL5gVVCwxHGuahofRyyFxqVUsGFy7AeWiBTmmzB0BGpgbWbVBSXHkeVzAsNNcKlr7HJDxzGN4qh1zCclqSpM04Mg4dQ7qnYpgaTee/X1t2ws3Z3NBCrQEvnJteRTi4/CjMcmr2JO1bLLHhI0xBlMtHwyC2MqFrT47R8Ts2WUgFqwzeUbnJvHbUT3oH7+6e7reeZugKPh/8KL62FWYw4LkJNrEjPLLgx9A+MkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB7587.namprd11.prod.outlook.com (2603:10b6:510:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 11:17:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 11:17:03 +0000
Message-ID: <d2b9b9da-f238-4207-8f4f-4476afe98014@intel.com>
Date: Fri, 11 Sep 2026 13:16:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/i40e: fix missing error handling for QinQ filter
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20260911094043.1683329-1-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260911094043.1683329-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0266.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 719aca7d-e7f9-418b-d66d-08df0ff6349a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DkK14D2VemzbPwihnIDcEgtP9g+bkJCH07+ff/UbhNeQ19Xz3qcwhrObe/Jhgur3KgTSiaDboQCeCzj4205hDEIhFyPu+BXqNQ2tn18L2Afv3TVOh8FGrCK+1D4/Wek3uDbVMxLnOweHpZUvRVj/3hQYfs9qyC3r79Bw6PCEqacsid/FSVPMkTofumP+YfNSdKzNwAD0kJ7xQ57ExUx4r614zPPF73GKs2roMdZZoLkApmqmV3aMEvGibkuhqrIn5Y744rdTjIxY30f6E1HykV90hO/wQGSwRvlJVirR34LSzh2Q7mUlzihzUo0hTGW7rdgoeikoOcWZvhbAM3c6XmZdxgBTfH6GRiDIackTw4gAWEwum4cbpGQT3pyfFLdKan/K8KmZs+Mq+nDTmHF90PjDjKxBZ7MAY3tAta87kKahN5CIkvlhgsZ947L9aNK3HuEAyPZbLfIcfEJ9wlSlIOOeS8D0UA5KxQCnDbQkFc8RAXuqjSpE4IWuunL5JDElXFvVIkRaPUfifeDwLGVgKcS7HfFpZBTGCDx99dWvlyKkhdFerJxFVezn6A22Pb3nQth9GwT1+rHp06w9Owxcf7dHuzYP2QMfMWmk0YQeuS9b8sePVTJwRGsT84a9p4jbCVKiGBGhdCU8eliXn3jEo1wc6jCiT3xnxisLfLltXfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5pT3lBQXJXbU40TUJmMll3cUNhVkYxRVlmUitaMDB5QWpZNVpTQ1hkeXJL?=
 =?utf-8?B?enpJT3Z4QUVGSWV5UEFMQ1JMcHZqQ2hUMHRabktmRlkzT2Q0ZnA4OFhaK2RY?=
 =?utf-8?B?bUlZcTJDMU40anh0dXIxQ0tNd1JzVHVteDV4a2VuY2lQOGZOQnBPNXFHeGlZ?=
 =?utf-8?B?SHR6dkxqVlVKQmVQcDdOUmszZ1dtVkdHdDNRUU5MbVdqNDBncWFVTVd4SmtL?=
 =?utf-8?B?QzhzWThVRERQazd6YXBUcUFTOFp6V3VPZS9IU1BmMnQ0SGUyMGZqS3RpbmJs?=
 =?utf-8?B?aFJWZGJjTEpNNEsvTitCN0c4RHMvRWV1RDJyWjQ4SHpBS2o1SysvUXFUNFRl?=
 =?utf-8?B?WmhYU2hmUjVaNWRKVmJBaTZvUkJtZllFMmozT3FnL1FtSEdzd0RuLzVUdVF4?=
 =?utf-8?B?cGlnM1pwQmxCVUhKYkhzenA2dy9ZMkR4VFVPM08zS3oweGFETHM5ZSt5Tnl3?=
 =?utf-8?B?TGFZYnpKUGJsSjBQODVVVXlMOFNQMllCTGpKV0tCT25PU2pJaTZPRE1TcTQw?=
 =?utf-8?B?b0hvNEYzNGFmUSsrN2RQNFExcmdJSHllcENuMzIxV3QyeEJmOVp5K2w4RkNj?=
 =?utf-8?B?bitRZWdza25yQ3U2ZjQzaTFkTzc5RFNpSStQOC9BRnRYaUd0czcyc3hrQlBm?=
 =?utf-8?B?cmZNcHpRUVZ4TkIxYVp5WEhUbFVZZEd0azl5NytxTFRNVG00ZU1kREpKUi9i?=
 =?utf-8?B?YUwxSWF2UlNucEpWZGJkL2lMWnVqWVVtSVpuU2NwSEVQeDFvZ3YvUEp4VUt2?=
 =?utf-8?B?WW4zL1NlVXB3MHpzU0pvRy9Jdlh0blNrNHRKMXcweDJwWmlzYldrK3F1Q05m?=
 =?utf-8?B?eHdMNFFsanBvWVdNQWplUko1K0hiblMzck0rb1kzM0hLMElIaDhNL3RxcDdj?=
 =?utf-8?B?VGFnUGU2ZlJUQlRHS2ZkY0NmYU83Y1VmUGdZVWRMeXA4N0hqUVBnYjVYNUMx?=
 =?utf-8?B?aEtLSnVCTEtXUWYvZWZCVzZreVNsNkMzT3JRcndZeC9ORU5BYzdNZjRqNVNn?=
 =?utf-8?B?M2w1dnV2d3Jja2RXTndZOWo4cHBWZkNxVGNUaGg4T29pNDFhcTU2d1paK3c1?=
 =?utf-8?B?MzN6Wm9nQU9vWVdZaTMzdmRpZGtxSUNOYVJZTFozTTY0cVBuVWtwZWREYmhs?=
 =?utf-8?B?UkFWZ0Qzb2hmU0Y0SHFjTFlTU2xjbkhkZTI3dENMNFFielRicExQNEVNcmU3?=
 =?utf-8?B?alhpdjNSOXZOQzBTckZKdGEvakRLQWM1QzUvMXJtb3NGbW93RVF0NWRyQXhP?=
 =?utf-8?B?elg4SlNhOUFwTkJNd0FNSnhFNFVXSUd6b3RBOWxyOHc2YzRkRzdsZDQxazdl?=
 =?utf-8?B?L2ZHUHlZWTVwOHRKLzZzRVVXWHBQb25XWGVYYlc2a1dYL0Z3ak5neS9hVWFG?=
 =?utf-8?B?MzU3NWhBK0xPU1ZyenRBYXRPQm5Ra3IxYUNDVDJZRzU4eFFLbHRIMzY5R0dE?=
 =?utf-8?B?UHMvYlcySTBJOFBRWml4ZXpUK2FoTTZQZlJqZ0tkd3MvZ3RuM0djeW5xVVdH?=
 =?utf-8?B?SGNJYVJqQ1g4RjU0bStGQjEzT0JoekRLWVJCR3dZQUo1YVNKdHllN2hiNDAr?=
 =?utf-8?B?VVpkWGVVV2JySFVrcENLQUF6YU9nWWNFSEk5a3ZhN2UrKzFsalp6M2xRK2dY?=
 =?utf-8?B?TnR6Q2tpdjlrdFBtNkNOakRCdDFaSFkwZFFMU3hmV3prTUFpelUzSDNWbmxC?=
 =?utf-8?B?b0F6Z0hVU3lxZWRkK2ttVHBnbTEyM1czZXQ5ZTc2VGFjQm1NdmF1RnpBRVlq?=
 =?utf-8?B?SENHQXN0bC9nMU9tdEY0SWtiUEdOa2xpL1hrYmVTQit4OXNsT0dySnAwWi9B?=
 =?utf-8?B?NVJ3ZUZiN3hSZjBxcTBCODlsclk0Q0l5dGlCZi8rM0JPMk9xYW5jdkFHMzhL?=
 =?utf-8?B?bDdEUHJUUFNCWFNBZFdIMGJwdk1yZmJhT2xzaXJPcy9LamRuZFV4M2kwZExB?=
 =?utf-8?B?cy96eDdZeG9qM3hXOUV1eGlPL28zMWJYc2kyZjN2ZnFQV3BISyt6dVh2YVhF?=
 =?utf-8?B?MXVNZWJQeDVuMUlFUXowYzgvVitJU3VxMldTakNCVFBOZWp3OGhJUkhyUEVz?=
 =?utf-8?B?K1hyUHhodU5DNE5UeFhCcXpVaXJ5SlNjS0RBM1dqQUxMT0xVek9wZUgvbS9I?=
 =?utf-8?B?QUgrNW11WmhBSmdSK3Y1SFVITkhQUDJEc3hrQlFjYUJraWJiNXVrVi9PVGZO?=
 =?utf-8?B?ejQ2b3dkSms1cFc0S2NVTEdYQXBIYjhzMlZNUGIrbHByc250ekxhdGFnY1lH?=
 =?utf-8?B?Y2hlMXdkV0ZiZXA0WUMrbHhuYUpvWE9kVEwwUHhMNTM2V085ZGdMRDZrYnJ6?=
 =?utf-8?B?WUNmSmcrZmhiY1JDK3BNQVF2Q05ZYmV6aVpVeEtzR3lVcDJGTGNidHNVSm9R?=
 =?utf-8?Q?fkntTt1Z55XWiudg=3D?=
X-Exchange-RoutingPolicyChecked: lM0+Q4A3jd/q7dxslydwiIZUQI4hr4D1K1wTS9ykRRcgETjgRTUpsYakEz4w0me4wB9GcusTEdGBiEx/FycP350BPdn+1WW/z5vTqFST/oXf4V4DqE/JGoYCEcrg/XsLlNoFWvSzSzUbAvL+NlQTtHOiF2EqzP3SF1ajMjzG6/40UadynYPE9qZFFRdoy7Pqirl3ScDiqOCV1kknTvr3UMqXI73eAIedCbKmRMY8hdGAO7HkRaAwz9nKo/65tFui4U/5L99C7CPOgxPI39BIzoV6sG0Evz0WmHD5z7xX0zGN+RgmmicQTyTUBAlNd7C+FkH66wC08x4D/BfcIhqZEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 719aca7d-e7f9-418b-d66d-08df0ff6349a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 11:17:03.0598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LFEkmqEe06ES/D+NGzu283TSdeiLQhbvBIJ61adncb6vvifSeh8V/6JB30zcrChFf+dBDfHsnU5Ee14AxgyjhCL4Hsq/LSq2GrG28Xnuxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7587
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

On 9/11/2026 11:40 AM, Bruce Richardson wrote:
> When installing a QinQ tunnel filter, errors were not properly caught
> leading to the situation where the app got a successful return code even
> though the filter was not properly installed. Add an appropriate log
> message and error return code on error to fix.
> 
> Fixes: 116b7910d641 ("net/i40e: add QinQ filter create function")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
> index b6b2d291ee..c91abe7626 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.c
> +++ b/drivers/net/intel/i40e/i40e_ethdev.c
> @@ -8597,9 +8597,11 @@ i40e_dev_consistent_tunnel_filter_set(struct i40e_pf *pf,
>   	case I40E_TUNNEL_TYPE_QINQ:
>   		if (!pf->qinq_replace_flag) {
>   			ret = i40e_cloud_filter_qinq_create(pf);
> -			if (ret < 0)
> -				PMD_DRV_LOG(DEBUG,
> -					    "QinQ tunnel filter already created.");
> +			if (ret < 0) {
> +				PMD_DRV_LOG(ERR, "Failed to create QinQ tunnel filter.");
> +				/* ret is a raw i40e_status_code, not an errno */
> +				return -ENOTSUP;
> +			}
>   			pf->qinq_replace_flag = 1;
>   		}
>   		/*	Add in the General fields the values of

Returning ENOTSUP unconditionally seemed unwarranted to me, so I dug 
into the code to see what sort of errors we might see. The function in 
question actually mixes return values (default value is `-ENOTSUP` which 
is -95, but most errors from that codepath return `I40E_NOT_SUPPORTED` 
which is -64), but most of them indeed boil down to ENOTSUP (except for 
status returned from call into AQ command).

So, although not ideal, this is probably consistent with current 
implementation

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
