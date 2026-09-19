Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA04C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BFE840655;
	Sat, 19 Sep 2026 18:11:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id F051A40655
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834268; x=1821370268;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=sQGhZfCyq8tVQv7ezFTjM3og5/FpKIGFP9w4s6BYSmo=;
 b=VYjMj617BR+Kgwwq2sS4DFx88D3S+sn7pDPiMMWTeEJ+eixpmgPOdfLu
 YSPOyvFeNAnZ9fSTQhJFJPn8o2m/RIzB/TnJ/N5acadiX3UYU23tRMKVR
 4rhrzok2ZdhVPX89qHZhrbLfujbrVeZ0IvbRpVMpX5eXpr2DIJnIa+EUd
 GP13Hnu443P2rtZocXPKEHsRZccIIXwp01d9dU5U8Dx3BPcExIfW71rlj
 tDpbVRfjA1KG5ct2Wt3QQdg9LBlEELTkV55erB94tQUU+5yScMdidyBiO
 Nzlz/Vv/BEHOZCwnlQ0xVJlajqhGLWT6VxFiEav3blGi3mqzxo9iXZ3RF A==;
X-CSE-ConnectionGUID: X2G/P2mCTde0a1vG5tmKKQ==
X-CSE-MsgGUID: 2VBXmtvMQE+kRkukh3cm0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="101023463"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="101023463"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:07 -0700
X-CSE-ConnectionGUID: rMvnvPSCRDuhhtxQWfxY8Q==
X-CSE-MsgGUID: LsIR0TC+Q5eMigBm3imbjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="271154980"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:11:06 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIv26r8w6oKVQzRq3otunDcBIepzRhAQGqkuk9EA4S4nqdNlhj5glvnKgiGjrW7uhOhjgJjf4dSSIysWO3OXGV4MrHdSazFuemoAs8qwOHrLSMJYf+49oy2Am4/rdDS6leROXFGvBtN65Vqxr+fBsa9Fy4xQyW46W1NLdwEAbpNrsVzEy5PKi3E7U/ovlXT97wcX3YVmwMhNy/lOHgy0jhSJ16QkIa47QB9nDYxvNWy6DG9tQ+3frdgxUjek0fQ44opG68mjSZhtjOal1yYllc1hS0cx+fGVi+r5/AiPPuVpY+UR2egxij+QM9kVdORXx7ri7tXSJon4Zy/ifPW3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9DpZnIG2nsJeDbMxXzMsjidaCdWU7vsfYEbPcdlutQ=;
 b=jGxzCCIid+ycQsL40pLqHc4MO5D7AJn7Gi8d0WkUCDP7BSTXj+lXVLxkWwN/LaXbvE5O2QuJL+RkkRYVTaN9MuPi4/TYl3nLxRisKSqg1/f39s1R7v6OP0EVmE4AQ7E0CBiU2bCOBpM+Di7QFEVgHxdc4bd424QErA5QWhZtMkoF3ybnEDB/BF4su9yOf70kuyh5x8RolDRdEu34Ba0NxG27Cm0WO2cT7AP3xvB9iKRGRkQmijLvE5ib7N2kBYWUwggjxp/VZtXIF4HLJz3CFd9HHAMgwcDAb0sCk//dWGS4f/TJn2buSMFIdxDtM0cgUPnr5ZlbYtZWPQyo8ve8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:11:03 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:11:03 +0000
Message-ID: <f53e2ff2-b4b0-4502-86bd-4c948b429c3e@intel.com>
Date: Sat, 19 Sep 2026 17:11:01 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 08/19] net/ixgbe: reimplement ntuple parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <b3903b1641bb4cb532c01e6094eed08568f3bc82.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <b3903b1641bb4cb532c01e6094eed08568f3bc82.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0028.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::12) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf4024c-093f-4e92-8bc8-08df16689a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: YOEupf9vC/aUkxMbooCT1lUCWa2/va2KvYFQWb4gTRbhQ2b4jZqRGFlM9HR0ly8KDzQPJBVPA6wprmZV1SNQ0WGxVZRVDQu2S3LtUkvp2muCHDkytixafzfu7aruSIUbTxDth+Yiyo43ZKkwOxAbyDJLalWXx99CCZxalNgRXgL6zypSSFEkuZ9juiyu8wH9ODTwnVzDNqqjhPo3f/ISsmpQuPiwCEHi6s8Ytx1rrynmtm2++KFzkTvGweP7ASM+it7nEsi1J2EszyXmaGgNTIfAIwlyG+pvPTlQhz1+InYxixYhBF8T+iXaz/DEJnRnEbUjEOGw4K3IxKNQSB2SD106KH7J3hitve6PjXR30YiGLntjmhVUbtneBd4rei+7pN4yZFqlnablTK3K6uzZYutGxjqNTViACEx6V0dv459q42/wU1aRJVvenC5fqO4EGV8fJ3DxkeaZEaV02Z9O+PZjrMvIbEaM2qYRkDRXK+ZkP/z6MdBOsDCg5wJkyDm+dEvJ/jPmTt7XLUSm4hMOmFqwkkQgqd2/Du0KqYxVomD/v1//pDVABEJA/KoKhJfyC0NlVPAus0Hnpljiqj8yInjio006WifeQ6VYrnaGF9cs0y1lAKOQ0QmZYYOaujNtfHXHUhXlNl6aPofy/lneZkBcguwkEtTFPICR7jy7mpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVM2K1pGdTcwSkJROXRnSm8wQlEzQ3EzenlJM0M5dXhpUk5DMkIxSEI3VG0v?=
 =?utf-8?B?UVVoVHJvL3FHN05oMWNnYUhXTkNJTjBKUmtHMWtvYXF0WXFGOHUvUElhNkZN?=
 =?utf-8?B?S1Zzbmd4bERmck1aZ1crNnVKUGprem5maVpUSnkrKzY2ZUcwV1Vya3c1Y05O?=
 =?utf-8?B?UkFCcG90Q3MyY1U4RUE1MzRlNndSM29UVVlOS1VMM096a1RzZjdqT2sxTFps?=
 =?utf-8?B?NWJodHpOeVpKZTFSSG1mMG1XYlNOUThuZnNzdk8zcFZQbUdsajJRdlZZTng4?=
 =?utf-8?B?ZmNUT1JkWWVodHJ6b2FETExObG5UbWQxOGxQSVBwVEJLWlkxcnBiYXZjZnNl?=
 =?utf-8?B?T3dSWnVJVyt3T2lXZHdreUg0eHVyWnRjZUJXU2ZKd3F6SERua0cveklJR1A5?=
 =?utf-8?B?d1pTZ2pvMHFMMWdVVFBxaUdmVCtsdnBEUjR1NXBhaUZHd0xvSlB3c3hnVzVt?=
 =?utf-8?B?Z3lYc0tybGhLeE1oZllLUElSQVdCU09XcHMyTjUrTVdTT0ZObEJmM0NqWjlo?=
 =?utf-8?B?RlZyazhCMlREOWJmWDZNOU1iZCtrWDlRUlJsb2tVdVZvOEJoNFRETnVXUnA1?=
 =?utf-8?B?QVRjNk53V3RSWVhndUFpMklWQVVScHh2NUMvNFA4L1dVTGZ1ZGFXL29vSHV0?=
 =?utf-8?B?TnNDdm9EVzhvclZxaVBWTmdwWWY5dEs1cFVDS3IzYmdHQkJMcXhtcnZlUGlI?=
 =?utf-8?B?em5mbFZ2N3VzbFRxaEYxRzBncE1mMnNNVnlwc1A2NzJOOG5MYlRHUHNKMmJ1?=
 =?utf-8?B?NDg5bERvRUhzNGQ3TFdpQk1mck04eWtzWWpPcmxJcVI2NkVFVmdBSW1rWUdV?=
 =?utf-8?B?ZmZ4ZGFCK1BNYnNpQ2NUZGxXTmxPTVZQTHA1WThlU1F5bVcycVNTY2k0b3Q5?=
 =?utf-8?B?WjRzaGxIU3ZaT3NFc1hPR0NhdXFZcnZXLzMxMGx4Q1JLSWdqcGt6V29tNlQx?=
 =?utf-8?B?bG9OZGR0VGFXYXRVTE0vS2cvWFhLRUNZcUVLL1JwRVZkQWVWVGxGbys3eUNh?=
 =?utf-8?B?d1FYTVY5N1lnQ1lnNFVhakJkWVVMUlBFUE5oUU1wK1BxOXpocEVRVFBxZDMr?=
 =?utf-8?B?WjltUjR2cGJuTUJZb3YwdUxWTTVXcFR4N2ZlWjUzVXZQNGxYdWlBWklpQ3ZM?=
 =?utf-8?B?N3V0cFdabnV6QUl1S1JLVXJhVlJPVU9jaXdrV1E0ZE5ndExjK2R4UFJISi9u?=
 =?utf-8?B?dmM1QkZmbE9wNm8xYlFsN3lQaDlCTkdESDF0ZTRwakRERlZBdXlwUjNoVGtI?=
 =?utf-8?B?Um52M3draDBadnlzcDRrSHk1N0NkRVRXc1JtckF4WEJqOUh5VmJ6Rk5MVUts?=
 =?utf-8?B?VGZyYVp0SlJ2V2grMGI2VVNHaFArZE5PQXREenBLdjFVNS9DbFB3dFBvNU8z?=
 =?utf-8?B?SzFKYkI3ZHFNOTZMa3NXdGJZeE9FWThlWE5XN1lBYnpHRmVJZ3doT2VNVlhI?=
 =?utf-8?B?dk1nMnRRcHhESjZYT0pWMWFrSzdtUnZyejFqZVk0VHJUalF5aHpjcFR6TzBh?=
 =?utf-8?B?NGNJRFJzTExqUHhpNDU5dG1vQmdUWXUxMiswZ0RpbHI2L05hVjFsZEdpZ2My?=
 =?utf-8?B?aHZWb2ROeUdYZTgwY0dRRlV3d2M3NDkzWXFNL0psamViYUZwM1Bzc1N4T1J5?=
 =?utf-8?B?UDRmTlBxNFRLS1hPZEo5cTBBTElrb2FsZDgycTVWdmZ6cVlBR244R1NBSjdW?=
 =?utf-8?B?VWlQdDgvWTViU2F1UDhHNXFMQmdGTkNFRGJnSCt4a0hmYUNaY05mVVlkVjMy?=
 =?utf-8?B?UzVOTUFqMmZ0M0Z6OHdENkorNVhLYzZTQ1ZrN1FGK25MWE1MSjBYSkVheHNt?=
 =?utf-8?B?eFBJWk5SejlaQ3RPYXRWUlh3VFZFL1hmVTFTT3B2N2VJdDBhOFVjR1AzUXdI?=
 =?utf-8?B?cUYrdXVkYjdEOFQyWmNhYWk5Z2FNVnNVVnpaSVpmSFpQQmh5Tm9BazlzQ2ZU?=
 =?utf-8?B?SlBaZFd1dzFMZURranhNWUtjZ0dsN1Z3QVJOWmwrYm9mYXBpNnB1QlNkSDFs?=
 =?utf-8?B?Y2VSWjh4V29HOXBLVUduaUF6aUZLOElSNEE3N1R4bTJkSkJKMjFXQkVCeFBQ?=
 =?utf-8?B?aStXVTgrM2xBY1NRcXFoc3E2MlczWDE5L3JtTmNNZFdPMDJlU1N6QnRhbHF0?=
 =?utf-8?B?NFVWaUhoV0tHdXhSZEZlSEtKdkhFMG9wdkN3eldmS2tyTjU4cERRVGx3aXAx?=
 =?utf-8?B?cGloTzY2YW9sYzVTT1RnZmFwQlNERnU4ZHlKZ3BKbmt3aFBxZFNhbU1IWFVx?=
 =?utf-8?B?RjM0cEJPN2svUTFjODd5dlVlQmdqWDF1ZVVuMWlYR3RRSEhMc0lzN0lzMGJx?=
 =?utf-8?B?aTZQdmltWW1FQlhtOSt2Y05hS2lTc0kvcEFIcmcvNEdwSXFuc3c0M1BjZXg3?=
 =?utf-8?Q?rBt86gMLhLY3sF+g=3D?=
X-Exchange-RoutingPolicyChecked: pvn8CDrtYqDZLZcI4FtsllQfuHLdq+DYVAkdSCc5aQ1ecd8+5uNBrkWkWlH0XuCg2An3DxWa63i7nohZuSydGWQmRqYDvKVS+dOUvpM1L+zVHcMuy0qt+JtqyLp1gNIYnmHbMx3HrvAlioZTIiU3CWfiJPFy4fyi9vz2yEKegJRhWyWoftVYb1EMNWghQ8HZDmz2FmXU+67LeKGh13MZNZA1cug5kiJebCXe9TqEqR+eQHzgSMMh3US5fC41rb7gGiZ9USOVsv/R9l+fUNCjvec3g/UbGQ6X2gG2QtnjiDhO2w7P5xvc4G6qhbCIz89EgrpfsMB++PPcmz/LzwqvZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf4024c-093f-4e92-8bc8-08df16689a7c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:11:03.4868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUC4R+YZKiZR1F/oSaqbqSFKA9mMNsoXzE34jK0b/yter17zZmnyrywqQCeYYLMufF2Dy85yNQ8fh9Z9xTeSrY8o2lJkmfvlBVpfjyuc1us=
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
> flow parser for ntuple.
>
> The 5tuple filter tracking infrastructure is moved completely inside the
> new engine and is removed from the rest of the driver.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +static const struct flow_graph ixgbe_ntuple_graph = {
> +	.nodes = (struct flow_graph_node[]) {
> +		[IXGBE_NTUPLE_NODE_START] = {
> +			.name = "START",
> +		},
> +		[IXGBE_NTUPLE_NODE_ETH] = {
> +			.name = "ETH",
> +			.type = RTE_FLOW_ITEM_TYPE_ETH,
> +			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
legacy code accepts patterns with non null spec/mask containing all 
zeros. Same for VLAN.
> +		},
> +		[IXGBE_NTUPLE_NODE_VLAN] = {
> +			.name = "VLAN",
> +			.type = RTE_FLOW_ITEM_TYPE_VLAN,
> +			.constraints = FLOW_GRAPH_NODE_EXPECT_EMPTY,
> +		},
> +		[IXGBE_NTUPLE_NODE_IPV4] = {
> +			.name = "IPV4",
> +			.type = RTE_FLOW_ITEM_TYPE_IPV4,
> +			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
mask was optional
> +			.validate = ixgbe_validate_ntuple_ipv4,
> +			.process = ixgbe_process_ntuple_ipv4,
> +		},
> +		[IXGBE_NTUPLE_NODE_TCP] = {
> +			.name = "TCP",
> +			.type = RTE_FLOW_ITEM_TYPE_TCP,
> +			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
> +			.validate = ixgbe_validate_ntuple_tcp,
> +			.process = ixgbe_process_ntuple_tcp,
> +		},
> +		[IXGBE_NTUPLE_NODE_UDP] = {
> +			.name = "UDP",
> +			.type = RTE_FLOW_ITEM_TYPE_UDP,
> +			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
spec and mask was optional
> +			.validate = ixgbe_validate_ntuple_udp,
> +			.process = ixgbe_process_ntuple_udp,
> +		},
> +		[IXGBE_NTUPLE_NODE_SCTP] = {
> +			.name = "SCTP",
> +			.type = RTE_FLOW_ITEM_TYPE_SCTP,
> +			.constraints = FLOW_GRAPH_NODE_EXPECT_SPEC_MASK,
> +			.validate = ixgbe_validate_ntuple_sctp,
> +			.process = ixgbe_process_ntuple_sctp,
> +		},
> +		[IXGBE_NTUPLE_NODE_END] = {
> +			.name = "END",
> +			.type = RTE_FLOW_ITEM_TYPE_END,
> +		},
> +	},
<snip>
> +	priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr->priority);
> +	priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
> +	priority += IXGBE_MIN_N_TUPLE_PRIO;
> +	ntuple_ctx->ntuple.priority = priority;

priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO, 
RTE_MAX(IXGBE_MIN_N_TUPLE_PRIO, attr->priority))

otherwise priority 0 maps to 7

> +
> +	/* fixed value for ixgbe */
> +	ntuple_ctx->ntuple.flags = RTE_5TUPLE_FLAGS;
> +
> +	return 0;
> +}
> +
> +static enum ixgbe_5tuple_protocol
> +convert_protocol_type(uint8_t protocol_value)
> +{
> +	if (protocol_value == IPPROTO_TCP)
> +		return IXGBE_FILTER_PROTOCOL_TCP;
> +	else if (protocol_value == IPPROTO_UDP)
> +		return IXGBE_FILTER_PROTOCOL_UDP;
> +	else if (protocol_value == IPPROTO_SCTP)
> +		return IXGBE_FILTER_PROTOCOL_SCTP;
> +	else
> +		return IXGBE_FILTER_PROTOCOL_NONE;
> +}
> +
> +static int
> +ixgbe_flow_ntuple_ctx_to_flow(const struct ci_flow_engine_ctx *ctx,
> +		struct ci_flow *flow,
> +		struct rte_flow_error *error __rte_unused)
> +{
> +	const struct ixgbe_ntuple_ctx *ntuple_ctx = (const struct ixgbe_ntuple_ctx *)ctx;
> +	struct ixgbe_ntuple_flow *ntuple_flow = (struct ixgbe_ntuple_flow *)flow;
> +	const struct rte_eth_ntuple_filter *ntuple = &ntuple_ctx->ntuple;
> +	struct ixgbe_5tuple_filter_info *key = &ntuple_flow->key;
> +
> +	/* mask shape (0 or all-ones) is already guaranteed by the graph */
> +	memset(key, 0, sizeof(*key));
> +
> +	key->dst_ip_mask = ntuple->dst_ip_mask == 0;
> +	key->dst_ip = ntuple->dst_ip;
I'm not sure we need to copy from the flow if the corresponding mask is 
set. For example, in ixgbe_process_ntuple_ipv4(), dst_ip is copied from 
an item independently of the mask. Thus, a user may install two or more 
semantically identical rules with different values in masked-out fields 
and consume all available filters.
> +	key->src_ip_mask = ntuple->src_ip_mask == 0;
> +	key->src_ip = ntuple->src_ip;
> +	key->dst_port_mask = ntuple->dst_port_mask == 0;
> +	key->dst_port = ntuple->dst_port;
> +	key->src_port_mask = ntuple->src_port_mask == 0;
> +	key->src_port = ntuple->src_port;
> +	key->proto_mask = ntuple->proto_mask == 0;
> +	key->proto = convert_protocol_type(ntuple->proto);
> +	key->priority = (uint8_t)ntuple->priority;
> +
> +	ntuple_flow->queue = ntuple->queue;
> +
> +	return 0;
> +}
<snip>

-- 
Regards,
Vladimir

