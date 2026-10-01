Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963D3CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 16:11:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 638FA40268;
	Thu,  1 Oct 2026 18:11:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 18D4F400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 18:11:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790871068; x=1822407068;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JYHhnFKu7O3olC83DbxlLAY3jhpM3IPgSRXBvMNIaPk=;
 b=PjTIUERZ2xPbtdn+Ono3iOP+7RrvvAL3tOhdW5uAQ/en/ZovgSUZUnsD
 /F9c/c9SGlM7XK0v8qyw++C3D+3ugILm4JxAgjBT/D0M0/olmjxZDk3a3
 xT3148IKca2UZdBsDXn/eaZRsg/FKRWoVVVOBZbKS2IgFmOkT/zhE//TZ
 GMqe97p9S+t+1//JOLz0GdLbp+pNmF0JzQSsLSdPL9Wvx8tGmnoDFaPQL
 PAZTXZrpvhjRpbIVraG7hNti5M66s5cQgMNda0rPE60c3KfXsnO2mRo6I
 Av7mgcIWGyGibmf5a9EhTnZeEpHUAncBt08PZcyoz7LsSqTe3htcrfiiF w==;
X-CSE-ConnectionGUID: ndGPP6sYRM6/kf68axqsSQ==
X-CSE-MsgGUID: z6c2NIXiTT+kbl9Qdv0sfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94118006"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="94118006"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 09:11:07 -0700
X-CSE-ConnectionGUID: mrYqQVGARxyUxdt6eRBb7w==
X-CSE-MsgGUID: lDk9BWq8QNuS5sbfxIhAPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="276070480"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 09:11:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:11:06 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 09:11:06 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:11:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5cC4fpxcwts21B9RGnuJEPKN9Ko0SRd4AhuT3FZDdokp2e4sGvBmDx4qRaoCuaz6bRjdNCHaufZK4t+lMBjQejylctffcJt4Rq/rE6x3zlhpM91kkRcuHp5rQNPvnhkqWUTNqzcE86ZPV9TzX048xyx/DjEF2N3mrwxA31andxT+JvXoxKir7q4LlB5TMktvTkqRbyPQHszeyUt3vjV7hHBW3UXlnOU6wWUMS8nW2dFXI+aWLb5EyzGsBAxdKmo0xSoMk6/bqTzgHj6PjMGZF5Lr3nPov8ayo1v2mcNf1QJ2+JKmtCVOlakQcjR0/nfvWz8HkKWsROpZWjNY1K8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYoKrEF1tt2yyyiPX8v1VXKIUswtzbhHbZrT4fzf55Y=;
 b=hqkii1E8TY1+RLT0Fi1uy8YDYRvoSBxcksNV8uXBv9wrL+BkAS7AtUR8vX5NLfIutd4Q9Cdg/OYWdpLBil/MequAUU4oU3uosAa7PIdTX5DkcnHCLb8ICaIVCublewLTPeTRRC4MwSxrCX4GCBzQ/62aenJ4NvP2xCYSNAQP/+Hs66+nd7yNWlT40ZyNw73lXsiKsCFEn8f7d5CBEkHJh6Ikd+FtN1VPD0X2CKQXjaKJZYDO811xzJhJ7AgmBpxdGuOZEDI8wA3Ic/pkdcCs07uTzh9ewhreuYgGtgeHkYNK6ctHn8XG2EEmA56jQ5aIyGV7e9e6UJh5U8PCRFjPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA3PR11MB662844.namprd11.prod.outlook.com (2603:10b6:806:538::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 16:11:00 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 16:11:00 +0000
Message-ID: <9df33b27-970c-4f9a-a452-36ba6c6eb92b@intel.com>
Date: Thu, 1 Oct 2026 17:10:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/4] app/crypto-perf: support mldsa
 Sign-Iteration
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20260929122044.1344518-1-psenapati@marvell.com>
 <64d81a94-4578-4362-920d-a049e0207c68@intel.com>
 <LV8PR18MB6078F14394D1B1812C574D15BD8A2@LV8PR18MB6078.namprd18.prod.outlook.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <LV8PR18MB6078F14394D1B1812C574D15BD8A2@LV8PR18MB6078.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::19) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SA3PR11MB662844:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bcc403-cd19-403d-2ce7-08df1fd69575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: omxghzvDA+68ivWGUZAP21APLdAOMXuqRKRn4mMqKPSwszr+obrVz+nIFy5skEh3D33LOO4TEO4iGJpKPMCI8ZXJv5KWSCCe3aLZxqPLPdNSvcShO8RCrea5WEvQq5K2hvrQ5olt/1ZAiaak/W2Be+M8WuE4xiIZJsFPTEUXgxSUqp2NlQe+soPeXFb5xgjHefWyInsIjGL4zjTZnx97ksL0Ny2KQt9ZCFBR7DQHXOeLlC2+xy+gsb5+rmzNPS3uhmLMA9EASNG7ls5t72YIFsr1D4Ns8euSY/wBECw7Fmk+4jKM5ItWPxIYpCcPzfYHkch45wjHPTfPU9/6qA1ICB7e4ZpulVc9K1ovmm3TJ+3ZoeMQYWxBb425Y0yqineHotzjOrCupYByX6LPohAbcmUu0VNRQDTYhJDF7isyzYSxEMf++CaBxe691a8Tet5pdMer8uIMCQVIs7/IicJg6FgalxRE0tfb72t397X/8VvSkJpLuBKn7ILOiu1NztDBTenNezXNbPUgKgz8Fsf5FzYI2l3QB8dmP7cJa/+kP7Da067q6Oy3lkgFrMxzpJClwSX1Qm6vGq1ejOS9fBvNV2/5gmEtZhexpyxTieAftdxFbnw+IDA1tJ8vXBY7IGIUU3brUjfWicf7TjahM9BjUgg6Fi1cDZkDQQGnd8VOzfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVqM3VNQjN2bFQxQ1ZNRERaYmFYUFVGbG5GMFZlbDIrc3NTT0JOd2NucDBO?=
 =?utf-8?B?VnVOeXRyR3ViejU1VjUrMjhJOHNEb3N0Q0Q4Rm9ZRGlVbENCSE9VbUVwNE1G?=
 =?utf-8?B?cTA2Q0k4QW1ybGhCMzBhaC9SZzBvZjczNkM0YnlXemwvd2V0VlYyV3RGYjRX?=
 =?utf-8?B?MFhGdHNIYlVDQUU0Nzd4SDZCKzlpUGc3NjV0by90cWpyT3dVQ1kxcjQ0S3Mv?=
 =?utf-8?B?RnAyNm42Q203cUlFZHY0QUNkZDB6dlBvNFdRUWxtak9BdGU2ckVSS0xnbU8v?=
 =?utf-8?B?RFFndDRQMlBieGZTaFhmd0RpOEhlbDN5d0NCbnBwZlQ4SHVia0hOTlZNMVFh?=
 =?utf-8?B?N1NVcUIyV3I0SmZ1REgyc1ZZRWsrYlVHVHRuT3h6bmJlMWFuM3RERXFwYW52?=
 =?utf-8?B?UWNIaUt6dUdUWnBPamhiQVNpQ0s5WDI2SDhNUm5BbzNrcnNFZVIxZE1yUDVh?=
 =?utf-8?B?RHdmeERIVlRiRzQzWUpJY3RMNmZGNmNmS0NhVURhWEd3ZlEwbEx6bVlROTdX?=
 =?utf-8?B?MFV0aHJ3L0FhTTUxOHlpN2dPM0VwdXVQSFRORXZrcW81bnF2Z0FRcDNzWU1M?=
 =?utf-8?B?RHQzeVBBdTNsc3pvZ2xFeExqdTUyVGl6ODdQSkNma1hiSlVwbVR4cFArMVpD?=
 =?utf-8?B?cEFhWjZtU01STXhWZEpQdFoxSklOTFZUckNhbGJCYi9BTjlFMHVOMTBvNGJv?=
 =?utf-8?B?UlZ4Z1Q2UENnRktBdDhKL1RHcmJHcDZ1R3FnRWJYT0xPbk1wMi9aZGZDWjdC?=
 =?utf-8?B?bTNub2wzb3ZaNFNpdTJWOFJPYW5aK2EvRHRiN094UzBlMVVzaVdsd2NLVDJn?=
 =?utf-8?B?OTZMMG1kZm9ZaFFwRlRrNzBHUnpJYUNQWXREVE9wQ2tFbnF4Mml5WHVscWJQ?=
 =?utf-8?B?Wm1rR09PeDdlRFM3Nm8rVVlqdVhSY3Rlend2SHUvNG5aTzFvRzBMUmFHSElm?=
 =?utf-8?B?SVI4emdCV1VJR1EvTVhxa0JmaHNQblRCM05sb2JVanY0T05wK0RUc21Wb1NZ?=
 =?utf-8?B?RzZpVzlaNXVlMTRpMUN4cFlCWHVCc2VndFVKRVpmWi9MVVU3QmNoMmdhWXN5?=
 =?utf-8?B?cVNKc0prQ0RMUG9QemdRQi95eU1FTFZJUzZJVndDdENLQUJpS0F5bjUvUVA4?=
 =?utf-8?B?WXJKZ29CSFc2TXNLWHBDUm9ZTmUxTTNmMDYzSUQzaUJZMGpMSTFkeFF5bTAr?=
 =?utf-8?B?NXRGY2hFYk5PVzFYQXRqWnp3d1N5ei9GZTFaaHIwZlRtemFFdzR5cnVIMWVh?=
 =?utf-8?B?eFd2SlBZU2pzL0czM2w2cHd1THF0MlIyRjVxMEg3NUVrRUszdTE4VGViLzFx?=
 =?utf-8?B?MHBmdHVuRW50Sit1b25FT3F0M08vcTlZR3MxcW9kQklGbENoaEhJdnR2OXE5?=
 =?utf-8?B?VS8zamVFd3RLZWNxbXpQakk0cmR5MDgyd0NHMWMvLzVTVWw2WWJiZHRZUFhm?=
 =?utf-8?B?bGcyemhEaGFMQkpYcjlTQUI4emtFOFFPb3NOSzMrNDM0YUJpUjVPNjRMR0cx?=
 =?utf-8?B?UzJtcGVWR3NyTzVjWHB3em9VUmtGdDcyVC9EbWt0d1ZYTlErQ2ZDTFV6YUxi?=
 =?utf-8?B?ckNDeWkrUmsxcWxvamQyOS9wL3JYSnQ3a2VXVS94OVphd2o3R3hpQitCOEox?=
 =?utf-8?B?UjhJaG9pdzZ5R1gzSEk3TzhiUlZCbW5vSE5OdXdvSFlXQ00vWC9jenYxUW5m?=
 =?utf-8?B?SWJtRlhXT3ZsbWsyRUFaQXpQOWRSZit1S3RPOVVST1htVUtwNnFuemdkK3JC?=
 =?utf-8?B?alFnb1R2UEs3MGFwN0ZTL0JmaVYvQWNmbmVtRkVzK3VzWkJpWE91WW5OYTFG?=
 =?utf-8?B?TFhzdkhzSE1WTVo1NmhDV1pJaUE4c1VyUDhqOTdISzNub1lJc1EzMzllYVI1?=
 =?utf-8?B?VWx6S3QrNFhWTVlmTXFEVjhaOXVJYmo0dlJYVDJ2TERMa3cwSVNYRXZhUXFj?=
 =?utf-8?B?czN1UE5QWXhtVFJHYnFuYTlycWovR293LzV2WXFhRlp1eVZvaWt0R2NmckV6?=
 =?utf-8?B?ZUtYT0ZEZnlPVFdjeVB6ODFSQUpLMTRnRzJPRlFMTElNczR1TzYyVmZ4QW9O?=
 =?utf-8?B?MFQ2aU53ZnBSeVNrMGJvTXBiNElxcnBHWndEV3JvN2ZoczhmY0w0bEZ3Vm5S?=
 =?utf-8?B?Q0J6U1MrVDFldk1ObjRScGtBeGJHN3F4Sk51dnRsOUQ1ZlJKS05PYk9kNTJC?=
 =?utf-8?B?RzNXMDhMV2xjbEFaN1p2VjJBV2hReHR3dDVKQ09xRFo0dUoycXRoNGdkbVpX?=
 =?utf-8?B?WmF0ZDJxUmV6UDIwUEpTbmkxaWR4Q0RIby92NGNJUFdicUpDZ0lLZVhYMFVy?=
 =?utf-8?B?ZFh6MzJSY09ESUlCeE9FMUFNWUZPUk9GQ29xNDhoZEJVakNpR1B0UT09?=
X-Exchange-RoutingPolicyChecked: SEnCtpm7tf6+YExd7T/Q66G8rvPG6D3FNX32L31+pePNAUjGrYEgkL1c00FeSU+fY6dqpeqLU850ut7F6r5Ss7zFis89feYnlNpbpNzOt7MdQbj/jZkMc6d5cKvg5Yl1ejEXQ1/DW2iCPjwu6NV7TEKwX3SwEjA+nTBNvQA6EcTVk5Dv/LG7dd74Jfcwq/2g3QY8jXE+P0Loc2iPyECEnyb4UXsk/CuLzsYKIiKGainB0LaU5D7PDsXbinRHA7Sd4fjqvt0m4WsBzVH8WnQKuOjKiBfyqIYk1uR2KbE53vx4Xv5t6P9uMoYmi3uFRcNxPqJg2Q0DN5ZrOIxPJA3oKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bcc403-cd19-403d-2ce7-08df1fd69575
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 16:11:00.3875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FJpHF84J6vzdpHlQsmR2r5zFSQh85cQG14N+Fvr9a0gsgAkF7ewjPBNjNz9NEXxUhNMJrRmf4EYFx1h2HMNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB662844
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


On 01-Oct-26 3:58 PM, Pratik Senapati wrote:
>> Series-tested-by: Radu Nicolau <radu.nicolau@intel.com>
> Hi,
>
> I checked your patch-set, and my patch-set DOES NOT have the following patches:
>
> - ML-DSA sign: non-deterministic, sha3_256, and ext-mu variants for 65 and 87 (6 cases)
> - ML-KEM encap: non-deterministic (random message) variants for 768 and 1024 (2 cases)
>
> My patchset doesn't have the above patches since it was out of scope for our requirements.
>
> To conclude:
>
> We can do the following:
> - I can include your test-cases and add your sign-off.
> - We can accept your patch-set and reject mine.
>
> Please let me know what you'd like to do.
>
> Thanks,
> Pratik
Hi,

The best approach, which includes most of our work, will be:
1. retain my patch for the test app, which covers more test cases.
2. retain your patchset for the crypto-perf app, which has all the 
variants that mine has, and in addition the sign iterations argument.

Regards,
Radu
