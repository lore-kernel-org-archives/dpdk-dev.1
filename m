Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD29C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D18040B99;
	Sat, 19 Sep 2026 18:11:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E336740A8A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:11:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834303; x=1821370303;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ZjsX/bUnWiq40y26+Tqq4mQ/uQb9EVZy/QGRl54PWxY=;
 b=llQrcV0yCqSC/zF0hEva33RJdDUFygdDGZ1QW0mXqkBVsZ3bPWhg7QZF
 eVc0iDDUxNjTNdeuo4fOmc35JJkpTDYEwRUHt41mehic5XdIOPRQCGGbl
 UfOA3+Tjx+Av7TIx/Jy9Y7pSVMqXUYYoeJWcUVm66UFQ7aFGELeMfKpmi
 X5JPSYVRK1JGZxN6Uyk0WdC68KjzHeZQGB1yAGZcYEpcXTo8OblKwmghM
 o8o5zTMziGDudnCdBTx6n5+3hDyZmlqqhTIe5pvMH5W/5xByEkWna7g89
 WKLTyncyGGIJ6HoVv8UoMw4e8a6DF42th17ZYNsjOBF8gVil62Fx9ldhB g==;
X-CSE-ConnectionGUID: MpMqg2YESxGdpZOjlA9VXQ==
X-CSE-MsgGUID: HOlMcg/XQFeW/NGygriBLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89287859"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89287859"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:42 -0700
X-CSE-ConnectionGUID: jHbfDtaHTN2QDVQYntIm+Q==
X-CSE-MsgGUID: RaCYkfkBQhWPKir36H+ANg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3326440"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:11:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZU5UDYuO73Ncaick8dV54CGxNHn+Iz5rG8d9ycAPjwgukwBFp189lW/SEP0ieyY/KosAeTlpSW211q0eWkxw1Bj4yk7OxacG1ANpZKiSiigqoW9KsFfMtSNCEDHGW8dl3xQbJbzQ73G+DGPtkStR+GGApjfAYC7yu9nE/uWh5CjHpzMR9UhxOweHT9BifKNdXaUjvvjzRJUM/sc/FWJKjzT+yULH+Qm22DY753tffEovBo5sCfj+9aA0L8j5Pm87H0mV8NV07Z7n9ulcyUNcfrCATSk7nTN5io7F3UhuMSsax9oVvjF/PtQXk2MKFLivlKUZ896jtqb+tBK3kctxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+eaPJ7ecuRlsOWokHGqUs0D65OvPB7behwqBX8mAuU=;
 b=HmAEHCh1H6TJUC0edv//PfbbeCCZzCORKTf4vvJsN4INJ2tQdUov1/HW/JSxeZzKFID+eRHlVl3S/vfCXvsp9XqcJul4cNIeDER868rfYjcvbYgGfCOsHn/EJ6T1QL1z6vsp0Oj8e5WyP5cpPwFY6zb7h8rs+zD+ghrF+50Y+vFXB5VPuhEigPh/ps7ZpRh1Z5oImUn4CcW7YcxiPC2budtWsKapcPR01oYfotZGhzJubyPsro8CB7wNBcPJxjncVzhI6m7xmNLZbytnN7v+88ai06ogGV70iQ6UIus8uuf1gXKNb9KPnaj5pGvjKr5jNUaa1IpyJZbqLSQ59FIPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:11:27 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:11:27 +0000
Message-ID: <c1fa0c21-032a-450c-923d-7ac0bad960cb@intel.com>
Date: Sat, 19 Sep 2026 17:11:24 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 10/19] net/ixgbe: reimplement FDIR parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <7a63a0b6cb25f1bdaea06e24ea13f6ff4fef4c13.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <7a63a0b6cb25f1bdaea06e24ea13f6ff4fef4c13.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR06CA0013.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::18) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 233823c2-5211-4283-4e91-08df1668a899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 8ml/eYFDaRtuU8Bdl90OYIieRb2oi4OiTqFbNGNDdhVhLimN/Zseqk3sm9idvxrRswyO+Ys5Y/PTqblymcgafXKxfC4T+pa5aNzymsOrh48ARy2o6QtmxdWZ947DJHDCzjSQGZ0h9rTem8hKV1y/c4e0nfWs2O3scAcmgvdpFHx5oqsFHqGH5VlgHucsof/Qa2zJefroQlN13k3AkFYdoTXXvNUysYS3Rr4WnylMLje05zWxTstSi+x1qYlCyzFiBJgbPTOt/CV0apylvjkpsfrMfxVBFmN53HwzkPksfbud5pUM9rx3ICBoqTcX/XJpm+B7QdQ1uTRZecBKPNJ+piL/dGxT4WjRzMX7Yx/ejzb9/HM6c4+2+tfPlDLnAuRA/Y3rhE6rulTUA268W8yfN7eN5E+5CM9cjyV7hhqRZllSMTzIvNolf4bhN7mtRZ45/vwDmg/gH5y2f3p+AXOlmVkubbYdsfzj1Yuq9ztBdXuMT6fWMtvtccGjQKzIxSgEKU2KvpoUprhJcWB4jnDOPw2nWs1WTzNZFXnmyssPnFoKeI/iH6BniEixpcHedD8Q69MT8ZZehvY26Lev9oWDMZd637W1B1xSuow27s16zv0bO8ik4YPfrrmmsbre1G2zAcX+HsTa2SwLnns/StwzOg/TsMu61Z6Lwhpi3AEFwXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHhKKy9ENW9iRVhZK2ZIT0ovczJwSkJrcnVzMHQ5Q2k4cUoySDFPYXl5VmU1?=
 =?utf-8?B?QVpDbTRnWWg4WUliR0hrOGZmM0VuazZIVFRCZzkxaURha2ZwbDkwQmVxU29z?=
 =?utf-8?B?emJtZ1ZvRHp1NXRpMksvVjNoOUFZOWtuQVcyL2Z0bHI0MEVkQi95dktuT1o3?=
 =?utf-8?B?d3hQWVBSckgxL1hobkJLWkZzTFV0ck5xWlR4MGhRaWIza2FqRzROL21STkQ1?=
 =?utf-8?B?d0JVVmtYa2dzVll2dTBzbFdhSGRhdDI1STQ0bjNlUW00SDZKaDVKekVqN0VF?=
 =?utf-8?B?dG0zTmw3U3hWanYrTDBtaEJ5V2lrS2pxQnRVbGxjblFTUGdhbmc5WFhtNVk2?=
 =?utf-8?B?OE9CSjQ3QzJQVUJ0c2hCVFpaSFc3TnZxMXZ5cE5MblRyRTRIN01acmkvbG5U?=
 =?utf-8?B?Mnp1THM2a0c1ZS9wb2V6dkMwMGIwNWlEYXRrdUg5R3FkclFlbUNxK1lKTmVx?=
 =?utf-8?B?cVk3dVd1c0JZU1ZRcXBEb3Jwd1JqSWZuRkdlWkFPOG9pTzVuMXViczQvcklC?=
 =?utf-8?B?Q1YvZ0NaSkppM2JIRW1RNDFGR0gvbEFqdkc2OE9ERlhhaittTHZxUUNDM3lH?=
 =?utf-8?B?Q2xCQ3pweEVrSkptTlNGemRKRkhIaDFDYnd6ZlYzLzNPald0a0VtTGtjYTBD?=
 =?utf-8?B?d3VBN04wRVdjRmVDdUNsT0RTR2JBU2FZalFNUHdqSXhzYmVHTU05b2ZSaEdE?=
 =?utf-8?B?M0tVYUtjSDFWQkNkMUNKZnpFdnlmRzJyYmJ5OWszNEpKZUt5M1RJSmlHaFM0?=
 =?utf-8?B?NDkveTU4bnEwOGZBZ2UyWkYxWGxrc21ncDVGc2FTMlZ6RHdyNnpTVHdXTVc3?=
 =?utf-8?B?U25BaVRSVmJ1WkJTOFlXUVpKZmpzeHNUMXFuVGdVZ1lGemZzaGtzVXFpQ2Zx?=
 =?utf-8?B?WERVa1hxa1VBcFJJNnFaSjNETllQNG5KWC9OQVRTNlZCb2dQQTlVN3FYQmxa?=
 =?utf-8?B?cnoyT25ZQWZaaStwN3FvZ3R4SlBvVE5WUzBuY1pPZEYwWUIzKzhCQ3pFZFNl?=
 =?utf-8?B?V3l4b0NDL2J1WFByeGUzekNqRUlWTkcxMlBUQ0cra01VNXUweUE2WUVuNVdB?=
 =?utf-8?B?NjBvNzNJZnEyWGJhUllKR0JCc3lmdFdVQjBlOVBvcldEelZhTDJkSmFVOGZQ?=
 =?utf-8?B?eG1qRFM5NDMzdkk4clNCdFRnbk9IV00yQkVHdVdtMjE3RU1VblUyWWtlQVI1?=
 =?utf-8?B?ZVVhTU9yRm9sWkloNFd3UmFKM3krR0hCQWJ5cVU5N0lINHVxODZqSUU3NUNG?=
 =?utf-8?B?WXJKSVNJZlFOTVFCQkQva0RURmpxZUhVQ1J6M1pQQmhwM2o5N1JCTXNsbzNm?=
 =?utf-8?B?cW04ZzJGcEtKblVWVVZVWEZ5eWNYeHFFRExoU1BtNHRFclBxcjc0ZCtWbWYz?=
 =?utf-8?B?ZGdsRHpzUlVLeFk4MTlPT2M2SFkvS0duZTk2YXdnVnlqMjExdDBZZG9UTlRH?=
 =?utf-8?B?Sm04TE50Tm80NWlFeHlnRk5LdGlhU25qeHkrN2t0SnptMXg0L2RTQ3lQTTVL?=
 =?utf-8?B?cG1RbGNSQU1Rb3BsRlRnVlBOVG1YRVdDOXMvWFB1bGw1OXIxa2dCOFYyL2Jt?=
 =?utf-8?B?L2xoTW5Bcmg4Y3c3TlJsb3dOT3RHNjJSL08ydUlNVUxxU0tnOVFpaFk2bXRW?=
 =?utf-8?B?cTZkUWVOcnUzVm1FMGNIVDlDb24vcms0ekRlQmhYZXZsUWhmTXZWUVJTckpY?=
 =?utf-8?B?STVpWGhZaVVZZGsvRFhzSVNvYnZMUjFFQktHcG02VGZoS2owTDg3d1Z6cWVU?=
 =?utf-8?B?ZlV0QzIvOXJUZC9qVlA4N243NGRNN0puTkxZWXczWkdIc0I2S1ZLb2NBdVBF?=
 =?utf-8?B?ZWtYclBjalFVamttbmV2QWw2NUdVc2V4MGlEQWJLSlhSN1VUQnlHM2dXU3c5?=
 =?utf-8?B?ZCtWclhhSkhVc3hydjhJMGZKbGpOTE0reHoybVIrQUtlNlRFb1FleXFKRXM3?=
 =?utf-8?B?VEx5cHBEcnozMmNtZ2xhdHZCQ3dRWEpHZmEwbHd3Wm9tQzlVS0FCSlV2N1Nn?=
 =?utf-8?B?VU56dThxcE9KRWtCclR1dnpIV09UUmhxUmY1RzdjdXlPNWZrZjJoY1YwKytP?=
 =?utf-8?B?YVZscjcrQ3YwVnBGLzFxL3lvcEdvSFFLL2pkQXBTOXRJSFplcG9VRm92dzNU?=
 =?utf-8?B?MGIzcTRIQkxQVlN1TTZHU1llR2JCYmJuOUYwY0hGZjI1QmZCME13S2gxMmJ5?=
 =?utf-8?B?MGY4K052Wlpsai91azg2YXZYdlM0VkovdkZpYnJrQWpOT0RZV1NQNzFZSkVt?=
 =?utf-8?B?bFRjK2p1aWRJTjc1TTFMSWRxVW9wR0dqWDVJZDEydmt1bHR0aVhFQTFOYmN1?=
 =?utf-8?B?cEcwaTkzSjk1d01hSUdJZllEbHZjd0FVT1lBenNYeTlXeFJtUEM0YXN3dkhK?=
 =?utf-8?Q?PXtVdU2Z8PgT73BM=3D?=
X-Exchange-RoutingPolicyChecked: fHQxpaq3wObgcuPEWVw85QnNLzGdjLjrWEudNtmr3eWT4cVOrSvu5C8Kzpxvhqa2Cm4YwW5lOVSo8Prsob/h+O5eB/ChRRA014GIQogBUDDezDuViz4hEPr7x2KMk42uynnhvY8FibQFJhT/lcXAEio9Dkb+/J4A9A65XOS9yQzql3WOM7CBVYNjzZLXn3JVZByGHN2AZTCDDo4if1W0WlfX/WoT33/kLuUaPw5FF1NmTPYCzURVnDgdSdo8FSodBSAihSSfV54+29192QD4wFJyn9E+bL8kkxQPu2pUf6ANU6vc/PWVpT0pdbKBhAc9/FEpEdDXluKTLxa2jhM+pA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 233823c2-5211-4283-4e91-08df1668a899
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:11:27.2415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGelrZei36odXStoXQhvO1M/4KUeOlPCyCYqgXqrokVIEjFVAQk4L+2Ycjwz4OZDw9ZITyPVKF5aO6Le+OVNVm3AJHRFLAjBfVOQd5Vs4CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for flow director.
>
> The FDIR flow tracking is moved inside the new engine, and the FDIR code is
> refactored to not mix software tracking with HW writes.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +		hash_handle = rte_hash_create(&hash_params);
>   
> -	/* drop queue is always fixed */
> -	IXGBE_DEV_FDIR_CONF(eth_dev)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
> +		if (hash_handle == NULL) {
> +			PMD_INIT_LOG(ERR, "Failed to create fdir hash table!");
> +			rte_hash_free(hash_handle);
no need to free NULL
> +			ci_refcount_release(&state->ref);
> +			return NULL;
> +		}
> +
> +		state->hash_handle = hash_handle;
> +		state->mask_conf.mode = RTE_FDIR_MODE_NONE;
> +
> +		/* drop queue is always fixed */
> +		IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter)->drop_queue = IXGBE_FDIR_DROP_QUEUE;
> +	}
>   
> -	return 0;
> +	return state;
>   }
>   
<snip>
> +/* hardware loses its flow director setup across a stop/start cycle 
> */ +void +ixgbe_fdir_hw_invalidate(struct rte_eth_dev *dev) { - int 
> ret; + struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct ixgbe_fdir_state *state = &adapter->fdir_state;
>   
> -	ret = rte_hash_lookup(fdir_info->hash_handle, (const void *)key);
> -	if (ret < 0)
> -		return NULL;
> -
> -	return fdir_info->hash_map[ret];
> +	if (state != NULL) {
nit: can the state be NULL at all?
> +		state->mask_conf.hw_configured = false;
> +		state->mask_conf.mask_programmed = false;
> +	}
>   }
<snip>
> +
> +static int
> +ixgbe_flow_fdir_flow_unregister(struct ci_flow *flow, struct rte_flow_error *error)
> +{
> +	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
> +	struct ixgbe_fdir_priv *priv = flow->engine_priv;
> +	struct ixgbe_fdir_state *state = priv->state;
> +	int ret;
> +
> +	ret = ixgbe_fdir_table_del(state->hash_handle, fdir_flow);
> +	if (ret == -ENOENT) {
> +		return rte_flow_error_set(error, ENOENT,
> +				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +				"Flow director filter is missing from the filter table");
> +	}
> +
> +	ixgbe_fdir_mask_release(&state->mask_conf);
Do we also need to check if there are any other rules and, if there are 
none, reset hw_configured as well as global_fdir_conf->mode, and restore 
all HW state, such as the adjusted packet buffer (pballoc from 
ixgbe_fdir_configure())?

I mean, should we do a similar cleanup to ixgbe_flow_fdir_flow_uninstall()?

We can end up in a situation where ixgbe_fdir_filter_program() fails 
while installing the first flow, after the HW and masks have already 
been configured. Based on the ci_flow_create() logic, if the 
installation fails, only ci_flow_unregister() is called. This leaves us 
in an inconsistent state where we have no flows installed, but FDIR 
remains configured.
> +
> +	return 0;
> +}
> +
> +static int
> +ixgbe_flow_fdir_configure_hw(struct ixgbe_adapter *adapter,
> +		struct ixgbe_fdir_mask_state *mask_state,
> +		struct rte_flow_error *error)
> +{
> +	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
> +	struct rte_eth_fdir_conf local_fdir_conf = *global_fdir_conf;
> +	int ret;
> +
> +	local_fdir_conf.mode = mask_state->mode;
> +
> +	ret = ixgbe_fdir_configure(adapter, &local_fdir_conf, &mask_state->mask);
There is a problem with calling ixgbe_fdir_configure() multiple times. 
This call changes the HW state:

/* ixgbe_fdir.c:ixgbe_fdir_configure() */
IXGBE_WRITE_REG(hw, IXGBE_RXPBSIZE(0),
         (IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(0)) - pbsize));

With every invocation, IXGBE_RXPBSIZE(0) is decreased by pbsize.

Could we configure FDIR only once during device start, without 
configuring it with the first rule? Instead, for the first rule, we 
could just call ixgbe_fdir_set_input_mask() / ixgbe_set_fdir_flex_conf().
> +	if (ret != 0) {
> +		return rte_flow_error_set(error, -ret,
> +			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +			"Failed to configure flow director");
> +	}
> +
> +	global_fdir_conf->mode = mask_state->mode;
> +	mask_state->hw_configured = true;
> +
> +	return 0;
> +}
> +
> +static int
> +ixgbe_flow_fdir_program_mask(struct ixgbe_adapter *adapter,
> +		struct ixgbe_fdir_mask_state *mask_state,
> +		struct rte_flow_error *error)
> +{
> +	struct ixgbe_hw_fdir_info *global_fdir_info = IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
> +	int ret;
> +
> +	if (mask_state->mask.flex_bytes_mask != 0) {
> +		ret = ixgbe_fdir_set_flexbytes_offset(adapter, mask_state->flex_bytes_offset);
> +		if (ret != 0) {
> +			return rte_flow_error_set(error, -ret,
> +				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +				"Failed to set flex bytes offset");
> +		}
> +	}
> +
> +	ret = ixgbe_fdir_set_input_mask(adapter, &mask_state->mask, mask_state->mode);
> +	if (ret != 0) {
> +		return rte_flow_error_set(error, -ret,
> +			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +			"Failed to set input mask");
> +	}
> +
> +	/* record what is now in hardware for ixgbe_fdir_info_get() */
> +	global_fdir_info->mask = mask_state->mask;
> +	global_fdir_info->flex_bytes_offset = mask_state->flex_bytes_offset;
> +	mask_state->mask_programmed = true;
> +
> +	return 0;
> +}
> +
> +static int
> +ixgbe_flow_fdir_flow_install(struct ci_flow *flow,
> +		struct rte_flow_error *error)
> +{
> +	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
> +	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
> +	struct ixgbe_fdir_priv *priv = flow->engine_priv;
> +	struct ixgbe_fdir_mask_state *mask_conf = &priv->state->mask_conf;
> +	int ret;
> +
> +	if (!mask_conf->hw_configured) {
> +		ret = ixgbe_flow_fdir_configure_hw(adapter, mask_conf, error);
> +		if (ret != 0)
> +			return ret;
return rte_flow_error_set() instead?
> +	}
> +
> +	if (!mask_conf->mask_programmed) {
the previous invocation of the ixgbe_flow_fdir_configure_hw() have 
already programmed mask 
(->ixgbe_fdir_configure->ixgbe_fdir_set_input_mask). Do we really need 
to do this one more time?
> +		ret = ixgbe_flow_fdir_program_mask(adapter, mask_conf, error);
> +		if (ret != 0)
do we need to call ixgbe_fdir_hw_invalidate() on failure?
> +			return ret;
> +	}
> +
> +	ret = ixgbe_fdir_filter_program(adapter, &fdir_flow->rule, fdir_flow->queue,
> +			fdir_flow->fdircmd_flags, fdir_flow->fdirhash);
> +	if (ret != 0) {
> +		return rte_flow_error_set(error, -ret,
> +			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +			"Failed to program flow director filter");
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +ixgbe_flow_fdir_flow_uninstall(struct ci_flow *flow,
> +		struct rte_flow_error *error)
> +{
> +	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(flow->dev_data->dev_private);
> +	struct rte_eth_fdir_conf *global_fdir_conf = IXGBE_DEV_PRIVATE_TO_FDIR_CONF(adapter);
> +	struct ixgbe_fdir_flow *fdir_flow = (struct ixgbe_fdir_flow *)flow;
> +	struct ixgbe_fdir_priv *priv = flow->engine_priv;
> +	struct ixgbe_fdir_mask_state *mask_conf = &priv->state->mask_conf;
> +	int ret;
> +
> +	ret = ixgbe_fdir_filter_clear(adapter, fdir_flow->fdirhash);
> +	if (ret != 0) {
> +		return rte_flow_error_set(error, -ret,
> +			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +			"Failed to remove flow director filter");
> +	}
> +
> +	/* unregister has not run yet, so this filter is still counted */
> +	if (mask_conf->ref.count > 1)
> +		return 0;
> +
> +	mask_conf->hw_configured = false;
> +	mask_conf->mask_programmed = false;
> +	global_fdir_conf->mode = RTE_FDIR_MODE_NONE;
> +
> +	ret = ixgbe_fdir_reset_tables(adapter);
> +	if (ret != 0) {
> +		return rte_flow_error_set(error, -ret,
> +			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
> +			"Failed to reset flow director tables");
Would it be worth doing this in a separate function, such as 
ixgbe_flow_fdir_configure_hw(), and also resetting the masks to their 
defaults?
> +	}
> +
> +	return 0;
> +}
<snip>

-- 
Regards,
Vladimir

