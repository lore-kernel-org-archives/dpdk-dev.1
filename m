Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0C5C982EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 11:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD6F40262;
	Wed, 23 Sep 2026 13:47:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9DFCD4021E;
 Wed, 23 Sep 2026 13:47:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790164059; x=1821700059;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TXmuMTVpqOevl/T/RmVpHbAgq7sza582rKUrY3BcCOs=;
 b=MK+bo4tY0Kd5ZYZBl/ySQ1/qN4k7mH6IssntZqgPuL1l4wopi1gdFR26
 RCxx3Lj/rQga8Q4cyKcGQpj2iEE9H2xYlmFcv56knUOSQnMVV+qGXc8qI
 bwQHrBsvVswSfQsvT+cK/e4HIqHh5TwQLRRqetPc+UbCEg7YyClaLw+dy
 kNk63d/xWeRqQqsUGzTvIB70nOY5qq1SEpxOBAvY5fb6eHY/6x6koEjXG
 750vvvUu7+lkaLpXFQMJvTe3c/i+u4lJhjRDkM4I2hpGC8DIP/k9liFeb
 4nQoFVAtmxSCNIwTqD2gckzBv1Kbsuz/LR3GtBeIfeimveP8e5wXT2Dx6 w==;
X-CSE-ConnectionGUID: R5kRZA5YQoWCbG2MsCHJCw==
X-CSE-MsgGUID: 1Xt92LVKQiqQNQjG/TuRRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89768307"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="89768307"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 04:47:38 -0700
X-CSE-ConnectionGUID: OMsEZgqoR7OlhQGBbQdfpw==
X-CSE-MsgGUID: asMR2YjgT3uFXAldFdG55w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="273750314"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 04:47:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 04:47:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 04:47:37 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 04:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coF1XDIhQlsjfc27+Owh+Cx9jyaLjMCdoxMQtGhtFZShaV0JQrXlyC4Yj5VY/3k/WsKpfaExWpqyDkeFRjpL3qhSwQSO16gVywEj3jAK3P9VYDslZhvOPLAAXtVIY8l4XQgNx4YECUm5PLPZj6GfKs2F5N1x6BSsXNfWXjx7cuAJGVgJeGB7IYQtxpN9zeFkG6qsMd5QOIfxywoPlDG9hjsWgKj7AcBk8aNKplTqBZloDwZEFS+y+Nc2nQn7vGLbyzaicdU6umbLYZTiSZP3fsnT2PXGkCJFEchnmkNAfd1RmW36Jw09mRr193HwYUqcxnMFWvmEhR+Mzz4RKQUi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvVvyx1XTYtdx9Ja67Q0d9ilhVEmWYmlqeHF8A1TypA=;
 b=L2SOaXGddTFaupVnU6B8fdJrsnHqutI/LJ0STPt+vBdPufB10StmYKU2PkfQT3gQKeiD0rgWLDmwcvN2UopjGGW5YPADJRcfB7OxjDKGPb61nRJN3nALIUeO0KKhLMwak2vVwu37mNIrJE58jHCobL9YfJjkbQ7UAFaSrn+C+ES5aOQ7CREWkhO355JaLmHfXrfmR1Osm3al66/J7c/8wbc1VUL1Qus3OXNJTKOdbwomCLaLrOZ3ehcZKsJrQ3rWrfVo+ex+rFarwaAYt0xEGVGOxhj0XXmwOBw6X29tDPXlHHCSqSG/ByL6lVjWBFGYHfzzpywYaKWrYbWhOn7ClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Wed, 23 Sep 2026 11:47:33 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:47:33 +0000
Message-ID: <6dcbfe2b-1daa-46b4-840f-419b637369b9@intel.com>
Date: Wed, 23 Sep 2026 13:47:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] net/iavf: fix MAC addresses leak on reset
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <ciara.loftus@intel.com>, <rjarry@redhat.com>, <cfontain@redhat.com>,
 <stable@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 "Lunyuan Cui" <lunyuanx.cui@intel.com>, Jingjing Wu <jingjing.wu@intel.com>,
 "Xiaolong Ye" <xiaolong.ye@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260914081725.1097704-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::7) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 593233c8-52c0-405e-6310-08df1968744c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: nzvbMS1rMHtZhgXMCYr9m8DDz2E5i+5nK81ykkVPHCd1Cxo2JAWHs7ztn8kEsIgjeeYMLoEQl5mPxkXyylqxxIwQcKlNxjPJWu39fpHqTRxU+ORh6y745eVzwztuC2+dvJeYPkwKLwY9UhkXCjLJ0y2hJ9Pctk7y+JDgRtUGiak9axBozE2NTCMjejYpPd62js+qJFvIv9zWVMajZb0yeC+VBaygLu7ZYh/YCusUDWHy9AmL6FOHgdTb15jRfC91SVFHCQo5zkQMOtE+znPqec2ulaXeFmgheFYTQM0+fxUAXTPGkN4AUYTm1jS4gc1FfKPqKXrG8lt6ruLFE/Fw6jtDTp8LzDji/FSAUfvjz0nLsWA6yJbqYkh9bGeJCYvFCCp0yYLbjn7fLa1JZ1z2Y/LFuzGYF0wgoYZB2JolKx5z1GNPqOjLm8yy63jIY9pMp5wEkV6PGyCzjo/8wofYCBmH230jiBQ0IxvLqvHiQgNsNAHPxsVOz6YxFIS7SknxfG3RNHbtxqj4ir8ENxA1fhW2IHE/+EcMMuRz/JWjNruMxwX2TCLlkPz6cL/HfcAf4RWx5tXQiT1rwgiceqPkYccTW7gbqzzk1K2lwlMldnWIJ1WiAlOIDXSmkUCELBL7E/rAdukIejBZgYU4ely1rGD88NutA6Znyp1OLJLdyGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1lVUmpzMy9QTEprQjlMU1JON0RtTTQwQ0VNOS9RK3BJM21iY01KM2pPck0z?=
 =?utf-8?B?SEx2Vk9XZE9zZFpZRGM4TWdOdHMxZGhUUzJ2ZnNReGs1bUVmUXNsc2pPRy9H?=
 =?utf-8?B?eUhmdk9COE8yb0NaanFKM0plNnA4N3JmeGYwSHA2NXc2SjNHTGNpQlFIQ1V4?=
 =?utf-8?B?RDN0WWNUQ1NqR3NOa2QwT1Z0UzBGSWt0a29IQUZhL0g0dnJuamdyYWNQcWUv?=
 =?utf-8?B?Wmd1eFlWNnYzOFFhaUxuai9uTDdEVTM1M283em1VQWc3eGhlZDd6VmJzQUcz?=
 =?utf-8?B?eEJ6N052dEFYbjlFdTZERXd2alo0dkZJN3Q4LzRET1d5dXZpWE01YldrR3F2?=
 =?utf-8?B?Z1l2WmVGK3lmOEVuM1lia3piVUh1WEFnNmwzZmE5Yy9mZGxIckM5VXhZZFNM?=
 =?utf-8?B?M09qQXZhT2RnRVAzQUJuYUZudWd5MzdQRk13WEM5V3oxTGlIQ0p3VmVFSStv?=
 =?utf-8?B?cTlhNzdySEpGcHVIcDg0OXVlOFl6NkhzYVFOdTB0RER6bHNUV1ZrVVM1YnZG?=
 =?utf-8?B?amhkNVVsSi9vMDFTNUpkVzB4N3BjT0lEbXNaU3pKWGM3Kzd1K0svdVVjRGxR?=
 =?utf-8?B?QXR2YmVFOERwZTk5bHFkUFZoV01WaDNjcWNXdVQxNFBpWW9FcEN0djFVWUlq?=
 =?utf-8?B?UzNDcFpJV2MweWRqVXhoYi9GMjUrUXlkbmhPOXBnK0tUZzhnNm95WFBPNmdL?=
 =?utf-8?B?TG9NT1BiWG1rcExVaWx4U000MDlVU0h1OFJVbjdGeUs1eEJoczJsb255U2lo?=
 =?utf-8?B?MGl3K3RjRGdteDdQelVSTG5sZlA2d2cvalVNdUlxS1pUNUkxZ3cyNWo2aElQ?=
 =?utf-8?B?TUZiV1BXQjR3bTNPb0k2cDdnMFp1T0RUTWF6NnhCLzhheGt2SFVweVh3UjBR?=
 =?utf-8?B?b3hmVFovY0pucmp6V2pOaXRrTEZWMm91bkxsdWNITEhSR2pQVWtLcDVrSGZs?=
 =?utf-8?B?S25Yc3Nzb2x0ait0bmFBRER5Z1JhbjNCMGRscDBURThwcmh0Q1YvSm52TkdJ?=
 =?utf-8?B?VWpURUlwMFNZdUdvV0RGdHhVMk16WmdvUk5iNi9EcG5lcmVVcUtvbUE5cW9j?=
 =?utf-8?B?dEFtZThDMEFkem95dkwrUzN3VXNJWDkwNW9XWGI4dEZaUUF2L1FaT0FpZ2l4?=
 =?utf-8?B?b1dKYzNaeXdORFV1VzZza2Y0Q05VaUlVWkdBS1l0RlRLVlN4TGpkbUtxcnJP?=
 =?utf-8?B?MC9MN3hTQ1MySE5NSmEwemx1UUhRSi9MNmU5VmNNdWtveEpPRXQyL2V2RW1U?=
 =?utf-8?B?aUdkcXByYlVOb3lzUlJ3OXRSZy8xS3VCczlEQ2FRSnZzS3hYNFVoN2tpem9R?=
 =?utf-8?B?bTIzQWtxNW94RlNPTVFTNFE2c1RHY3ZCMGlkV0pOQXJDMjBtc2hzQVZYSnpI?=
 =?utf-8?B?N2ovN0N5dWZQWGhzK0c5M0xIOGxJVTh5ZDZWclRIYUJMdEdXcWh5MXJUcjFM?=
 =?utf-8?B?L3RRbU5DVzJwWUczQWhaTTdLS1Z1aVNLcVNOaHl3NktIcVBnZnk0MDBLajdJ?=
 =?utf-8?B?bVJub2RvcDdhLzFmSk5OS25zQkNtUlBOQ3h2eCtyVTF4bmNMR0lVV2VVRDBW?=
 =?utf-8?B?YUVHOThzL01LQ011WW16L24vMW5CTTdvM2k4QVZRZkpvZlNRelI0bWc1elV3?=
 =?utf-8?B?T3BQMjRtSlQ1dzAzdGxkZmJyNERDTVlrUjAvcWZBUzhJSVlzS2lxdStOSk45?=
 =?utf-8?B?TVRkNTlhSGhMdGN3NFZPWEpSOG8xdDN2TDZqai9tdUc3ditkZ0Fxa3R6VlZs?=
 =?utf-8?B?cHA2bnJxUXBERm03cXVmV2tmMnFHVmIrTmx4Y2xZcDA4dU53UFZJcGRRcGJy?=
 =?utf-8?B?Y0xwaTRNWklxOXZOcDh1SDh3a3VaL0ZXMjNybjlZeDRjUU9xTmNLVXJTVUNT?=
 =?utf-8?B?YU9UK3lyYU02QmVPZWdOR1FzZjdiNGxrZ1Mwald6bEhpNE5NTTlUUVdQV1BL?=
 =?utf-8?B?Yzl2dDJ1a1h2T0VHbXljY1hWRjV3K3lCWld2YW9BelJTS0lLQlpGZllUb1Vi?=
 =?utf-8?B?bmtUL1piUm9qNFFxblVKcEZnTmdBRDNXK3hRWk91YnBETDB3Qlo5NEFPbTNv?=
 =?utf-8?B?dVJRMWg2RVVWd0thNnd4bHY2cG1HWWhkekdmRTRacXJLdk1taGRsVWZ5elRt?=
 =?utf-8?B?TmxMYzN2WjZJMFMrRzU0bU04NG9pRmpudXd0QmpLR2NZcU01bG50c0hGNERG?=
 =?utf-8?B?aWxFNFNzOWkwTFFkODJYcHc1b215TDdpejByeEhVcTNqM29kb05Vdy9FakV3?=
 =?utf-8?B?QkQvVWw5b2NZbWthVmFvMjV0cUJVYUVZQ2dtRGZ5WEZZNHlULy9tRHFzdW9h?=
 =?utf-8?B?clFIK3hmaWxZVVlJVzh2Z3Z0TFVEQURQcjZjWUR1RmxlUVA4QUxhU1krSFBQ?=
 =?utf-8?Q?59Jc28O7tohMKgGM=3D?=
X-Exchange-RoutingPolicyChecked: BHhNqXtqzHs9jXYV1HTM5+XN+4E4dg/jialY+X8inJ3hn+fnncCb99BtCtS0PAE8Ve2xaAhWad0wAqrHj6l6CmmTsTblBvvYePTrK871lBP78uE58FLU8dR/vu+foSI6BtrqaOPRpns5RJdnL2qS9Ct7MmB1Vla15kRwJnkoETQCoVTUprExiySPqc/qN1oCiyva0qDW0ALRF92UmoTeIq16v7/jn62gCjyIDkMqjoF2ExgSZ2u1Fser4Rs6FGUeCz74RpFgq7FICQyoyVNAX70XrmgPUPmhu58mZJvvqM1VPu14mBdXz2ybldHe5cNu17GZIVLLmSTTaubf5cJTiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 593233c8-52c0-405e-6310-08df1968744c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:47:33.0997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZee1zSUnAfPndSTozCbalx8Nt/d2OhJm9LzgLdQLkCudp0rwh6dQXcENvEPOyXkiY/XBYefpjJyd4WG6l8Bk8uwJ9TMp1ihSrxH/KvPHsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
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

On 9/14/2026 10:17 AM, David Marchand wrote:
> When resetting, calling iavf_dev_uninit + iavf_dev_init results in
> leaking the previous dev->data->mac_addrs array.
> As a consequence, secondary MAC addresses are lost during a VF reset.
> 
> Move the MAC addresses array in the private iavf_info structure, along
> the multicast MAC addresses.
> Set/clear dev->data->mac_addrs in iavf_dev_init/iavf_dev_uninit.
> 
> Consistently use RTE_DIM() to avoid mixing with the multicast addresses
> array.
> 
> Fixes: e74e1bb6280d ("net/iavf: enable port reset")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
