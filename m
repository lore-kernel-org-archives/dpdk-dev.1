Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E85FC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 10:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C4AF4026F;
	Wed, 26 Aug 2026 12:20:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B0E92400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 12:20:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787739648; x=1819275648;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hPor/4EpqT89MfgsP+98F+7QszGs9tpyRptNMoIrsV4=;
 b=hEmB3gmfQl9xRSmNWsVFBwkL0uN8UMuXhSNJRoyZm09MIgoao8+BMSMr
 6H8xmznP2mbLwcM+sawxLCcim5XMaiPrSwVC1W85XDLLAuy/LgMRXkDip
 kYKlL2oiByy/1UbIdPUjn1LORsuHVIZJRD8iYyEXrdHzCS9JAxpcbpuE4
 TZAS4wBIA5IKqHnSvERMTWAMwJ8JfYPhEqK3oMAGKyNrVhTTenM4Tl9qq
 LOfAaFawbjq5xQAhpCMrMUdwl0zpl5IurO51Se3N3gYt0m4KjSKDGsRwv
 nJM/Zpjm0ILhOMzP+Wfa2HwJwoVqXgQ1oMAnTwIRDdBzVAjlzHb/ThwxU w==;
X-CSE-ConnectionGUID: LrjHOqA7Rmu45o5hDtZ8zw==
X-CSE-MsgGUID: vqXWMSWfR1q2nSO5BwiW5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99563827"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="99563827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 03:20:47 -0700
X-CSE-ConnectionGUID: xj2WWNZDSIyr65nprEPV6Q==
X-CSE-MsgGUID: Sn3XJfrxSauum4OgFcTiuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="267560997"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 03:20:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 03:20:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 03:20:46 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 03:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2cU4keRD/I8LWEpcEhakgM/b1COUUQ6aNx8kSgtw0JOeGizyKMY+ryGvuQV8pne/mpM7gOMN2USuP+5m2C+YrWwt9rk9W5QSYkEEZuhdgMtIhvzMVDzdFktrkG3SpTmQL8B1xF3+mRET6aUewXwNI32ENBeg6hzn0dZ3xGWOQHMSggMi4BA+RNcubFUrQDjKHGrQQO0lVrKkIj/hizmS9tvjYRyzlsvJ1mjm41Em5uIyzVdBMF/4HnGq+VaiJ4JYFdq6A1SO2ted2HIcvyXJxueNAPSTeVv9mFiQk2FGaXoHS3A6D8XKgh2UEXJOzHNZfw7povqhJ65AiGDtci6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX+K0I4O4snyUnbiRX7UvTpnvM9rt0d0cSyqoptwbgw=;
 b=hfG86UOiPIFjhqWm0F16nNYIxn+8l6qAAYDwMBGtMJux3QfzB16SE0bEeD68TYj4Mv+bOdBtEkxJhQpe1t8CVzNq6J9IjaOG9RMUIJghyDvzUvzL0/UcEArnoIgQDbwPGwAi0Cw7u18/kF+nH2Yh74r9mgrsYJmvJW/aJYEiuRd7MJ5iAoqfNDZ5D6lTxeSTjYNwuXh/v7v5dVoVvR5LBu6YWdP6m3u/9QO3XDy+PGAcmIyY8UN4Xs1LBAVU575wUywWIR5kM6ldZX9rB0NlrbbRnTwBALtKWdai70/8yszaw9BLsZzEX8VoGsX5Br/kph0UGD+EE9s1BNYqeAtm5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 LV2PR11MB868673.namprd11.prod.outlook.com (2603:10b6:408:422::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 10:20:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 10:20:42 +0000
Message-ID: <64e2bbcc-b77e-4b2c-9997-c99553486d0a@intel.com>
Date: Wed, 26 Aug 2026 12:20:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/21] ethdev: add flow graph API
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Ori Kam <orika@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
References: <3284b12762de6e3b7791f5e3fa63c78b26ed5e6f.1787233987.git.anatoly.burakov@intel.com>
 <DPk1E-kwRJqv9GCxmKhBVg@monjalon.net>
 <dcb80f5b-31e2-4f64-8d92-f4f4783393f4@intel.com>
 <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <nA_0NtHGRc2CE05D7MYfOw@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|LV2PR11MB868673:EE_
X-MS-Office365-Filtering-Correlation-Id: dde5b09f-1866-4009-362f-08df035baef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LRTchoe8KVvRhJLpZ44oPU7YuR7atHFaXh/ILBDBttSQghMVUatiHrwciOQtVeFcOnWsyo+muER25IRcnmkqTaqxasqKFdEgbouyujZxQEWne/S4JSQ03z7LdeHbweuoQJNlMVKVcUGIZLorZxRopOxAismVw90b+LPO813qoPrtY9Ij1u+XXV4E0ahtScua2OLlZ3ry2r/x+FLcQ+CkXJ6HJaq6Q79B+MCpiD4P5egmOwti/eS5pGMJ2O9K8ZkiDJxSmTq+w+8J77OxLIrsfz6V8YnZIO4L1849UagjZguOzeIyOVhgAP0r/Q0AX4TU1WctmNxijmKOVV70PP6t1qN2jRt1cghM/izlVp4WnRpv3XZdmA9cO8fXBZ+KH2TFfia7SKkGPvLWLMYqhRPfHtigkNnGI1jOWGZDGcLBPzh0w5XbI4Gq8yb4kWHP7JHkdYG2t4piS9EicVkS5xfuV2k/CxCxWrHM7h0Cq+VKUzN6LUkFq/ebJN4WC04OmRSi5Dv0gpxLMty5A9s9c5fQhUQcCi9GjPdaZVLVhto/I8qIF6zwDEcPPIihCONECXUZplLC7MDhaZFMzHUmYCSRWfW596sNNVpx1uPJEkDFi8ZJhAl5Ho/UVl23g3yQ8J/tztK6Nerg5LUaj5J77pNmw5xXQXeTWPODZR+OKwWUP8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWU4dThIenREMm96VUhaRk5LcGNOTzdUY1N3cnlNUjlzUTVFbXhEa0o2bmlh?=
 =?utf-8?B?b09nNFBYcEE5ejFZVDNGWHZuaVBGK25XMmR2QS9sR0NwSEo2RGFuU3h6K0F3?=
 =?utf-8?B?QUN5WXlZaVRGZ1NibzMyVENGTnJyKzdPOUpNeTNLK1pYcmNJcUZXVkx3NFk4?=
 =?utf-8?B?MEIzM2R0RW9KeHdMZXdvSWp2ZHNNUjRDT1laVlZPT1YyVjdqanBqaXhHVnFh?=
 =?utf-8?B?VDhrQTlKeTg1RGRJKzNNRFczK2NSRjcxaDZXUWh1R3NnM2FqV25EMWp4OW9p?=
 =?utf-8?B?WnNPTWxhWmZtRjlNSXN5N2k1QTBwVkY3eXBkVlBvRXBCMFlrT0IxQkxUUXNl?=
 =?utf-8?B?MitkZXZtR1dvVUYzaUlsODJSZ2RYVkp2eHlKZExMaDN1b0s4Ym1kVU5RUjA2?=
 =?utf-8?B?ZE9zVkhlMHovR0xiZlErYTFicjV6NUI1RER6WHFPbWJxbEMrZk9WNjI3SkZU?=
 =?utf-8?B?d3UzM3QzeVpPeTF1NUNxQy9iK29uMW9kSnJIbnF4SnJGRXo4VzBXcTIzRllT?=
 =?utf-8?B?UkE2dE16NjRVc0Y5YWhuTXZuN0UwQmdJVUN2V1ozS2JZbFQxaFB3VmtoN0pa?=
 =?utf-8?B?THpFRlpqRUNRTGVEOWgzWGlYRkdPRVlJa21kcFhQeDJqY3VnYWdidVVpZzJS?=
 =?utf-8?B?Zk1aN3pWUnNmMTRHNXBVcjlKeUdFa3pvL2pqVS92cVVqK3lqZDZRcEtmNDZR?=
 =?utf-8?B?dlRPL2hnYmZKNUFqMHZCSXZXaENCci9BQUlLZWQyRThPMmxNMjA3UUpwcnZv?=
 =?utf-8?B?b0ozMFBSUWh2SFVPSnpPZ3hnUVJOZFAwZk03aTVLWENCbHRUL096aW9tUHR4?=
 =?utf-8?B?MXFrNzM2TkRjODhHdjcrU09iUkJPeDZSd0xhdkE2ZnFRVUdNblFHRkRxYUs4?=
 =?utf-8?B?TjVjczR3RjYyUnhkWktTc3gvN0NVSjRITEV1UmR6MG9xNGk2S0RtL0Rvczdx?=
 =?utf-8?B?US9VZm94RWtKT2dod3VQekw5UjFpMGJSS3ZuNkNzLzVqTUVxSlFvcFNuLzA0?=
 =?utf-8?B?Q1VrSGxZRzdCMGE0N2tvcFNqTTFaYzlzTEdReEZGUXZTZ1VBcmhHc09qai9E?=
 =?utf-8?B?a1dGVGdhRDlrNWp0OGJzY3EyVkJ1MnhBMmRWK1hUOWZiYjdzdUNhckl3bkFG?=
 =?utf-8?B?a2VrMWFwblk5cURXcjA5YVVyOFhBZXdZM3ZxaUswOFVWNENCTUVnUEpIRFYy?=
 =?utf-8?B?bFFCeGV3dUpMWjVGV0FnV0w1OUFFTTBZbDNVd2N2T3U4QUZSanZIUTJoMFVk?=
 =?utf-8?B?Y2VlaGdzdFdCM3ZsMmw0RTgwWnp6akNDQ0tFWFFES0JhOUIrd1JwSzBiOVM4?=
 =?utf-8?B?cDdSbTdycUIxR2hac3ZvRjVIYlV2emUyRkhROEt2UDNCUzVpZjlWbG9lTmFK?=
 =?utf-8?B?QXVnNXZKU3NNZysyNW12bkxPK1Bqdno4SnZQRS9Xb0Y2VytuR000aWtCRmVZ?=
 =?utf-8?B?Q2Qxa2U2WnJCVWNtK1VGd2R5UGJtTUtnWWE3Y21qTzEzUURoYnNtWXZvUE9o?=
 =?utf-8?B?MGoydkc2c2NVODF2b1h4ZzU3aGRJbjgzdGNCWmdORjROOWlMUXJ5K1NvSStC?=
 =?utf-8?B?VEV6Tk9iQlZibE1ranlCUW8zYW9KMktMVGJBclk1cXh6M0NkT2VtUnlZKzJl?=
 =?utf-8?B?VEF1bTdiOURaT0U1N1hQTGNTQStnZ0NGNW50cnBVRHc3bUVIQnhNY1JMREYx?=
 =?utf-8?B?UjBMNlNWSFRTTCsrbGU5UTlNc21oTG8wTkNiSy9acks1SVdmQ2hqY3AzTjlF?=
 =?utf-8?B?VS9VZFJOazNkQVNaV0RITmVPNE9qajBzYTkxSEhlUE1OcE53cU1vL3pRN3B3?=
 =?utf-8?B?TTd5R3h2K1k1eHdoQTQ2ZnA0aFVjMmpzY2Q5WDhWTlcrRkZVREkvbW9vbDlE?=
 =?utf-8?B?eUtXaktZT3VrdjNtclhTeENNWjM2TjY1VGE4dG9ZaWduQ3FtaW1WSTNBZDdk?=
 =?utf-8?B?VmdzYWc2SXU1QzRKWndvYXVtUDZuU3BLSTlFU3pWcGNKSjduVmg5ZUcwTGhs?=
 =?utf-8?B?a3NuZWdHcjZ0R0ZqRTZKVDJ1dUcwdzlSSGhKS1l0cmEvZFFBdGxMWjZMSzRH?=
 =?utf-8?B?SUtlekNZSmdqTlRRaDB5TVMySDMwOHk3eG9FUENWRlBOcmE3OXJFZFM5RUVU?=
 =?utf-8?B?Y3RmMTdWTG5QNkY2TDY3UU8zbG1BZWtUdHRpZTNuOUtGS3FZMHFjNUNvemh2?=
 =?utf-8?B?ZXQ2NXd3LzlJNlJpVjhTQVUwYmJUZy9WQUFVY1F2L1BlWGxPMVJLcHEwMHpM?=
 =?utf-8?B?K3hlOFI1NWZlMzBZUDYxU0trOU9XTG1NVkg1WUJFaFZaandTbm91b2dCejIx?=
 =?utf-8?B?UVAwTFhzc1Y1V3k1UVN2d2VxeG1zbG40YzdCSWExVE1GRHVJRWxZeUJDckcr?=
 =?utf-8?Q?wRn/xLJAsTf5qT+M=3D?=
X-Exchange-RoutingPolicyChecked: M/8l7HCkmTaHga20kZaXA6g/spO5ECjKejnvRWCNiQjAKFpkJIPS4MD34BF9qPj9d+2N4+MT3XuMTY+y8BUrcQrMLclhP2R4qQ0fPqnlgo75xb12HSHpyKpjkTuVdirvcusk/npOyJLr80KD+gmUcI3YnnzCaiR4AJ7JQ8NTLAjFtOzXT/vXy8mimDR6BjC8sbmcz1J5O4Sv9IfSEexSrxS1n8AYeC7nnE8dTE5hbKij/6DEHY9i1uLlRset5Q6Q4SL3VoyjWMNGa56mHNE3MAPuplRqiqAyfga5P2+ULbXaQpesyvtjnp9J0Lh8jgCbLvA5uZ52BJ6GhGrGcgfxag==
X-MS-Exchange-CrossTenant-Network-Message-Id: dde5b09f-1866-4009-362f-08df035baef7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:20:42.3477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhwOMvrve++ct3Cw/JJU+SbDQcicgFe3zAnkWSmxIpGC8CfaNFf8h79qc0DjneNZGd/duBsisny484DH1PQ+dXfMmI+p39Rp7Cp8xX+Rnvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB868673
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

On 8/26/2026 11:21 AM, Thomas Monjalon wrote:
> 26/08/2026 10:58, Burakov, Anatoly:
>> On 8/25/2026 3:55 PM, Thomas Monjalon wrote:
>>> 20/08/2026 16:00, Anatoly Burakov:
>>>> This commit adds a flow graph parsing API. This is a helper API intended to
>>>> help ethdev drivers implement rte_flow parsers, as common usages map to
>>>> graph traversal problem very well.
>>>>
>>>> Features provided by the API:
>>>> - Flow graph, edge, and node definitions
>>>> - Graph traversal logic
>>>> - Declarative validation against common flow item types
>>>> - Per-node validation and state processing callbacks
>>> [...]
>>>>    lib/ethdev/rte_flow_graph.h                 | 532 ++++++++++++++
>>>
>>> Are we sure about the name? Why not "parsing" instead of "graph"?
>>>
>>
>> Because it is intended to help build *protocol graphs*, not *generic
>> flow parsing*. I.e. only things that lend themselves to be represented
>> by a graph would work with this - things like conntrack wouldn't. So, I
>> feel like "graph" is a more accurate name for this, because this is only
>> for enabling the protocol graph walk, not for full flow parsing.
> 
> OK
> 
>>> Is it only for drivers? In this case, no need to make it a public API.
>>
>> Yes, it is for drivers. It is not a public API, it is not installed into
>> public headers. If there is anything I forgot to do to remove it from
>> being public, please let me know.
> 
> You should not use the rte_ prefix for files which are not public.
> I know this convention is not well followed for historical reason,
> like rte_flow_driver.h should be flow_driver.h
> 
> 

The fact that it didn't look like there was no convention was why I 
picked rte_ prefix. I'll happily use a non-rte prefix for these. Maybe 
use eth_ prefix for both flow_graph and flow_driver? Or does flow_graph 
work fine?

[on a separate note: should rte_vfio follow suit and be renamed? it is 
no longer a public API following my patchset. renaming it to `vfio` 
would probably cause conflicts with Linux headers, so maybe something 
like vfio_driver like flow_driver?]

-- 
Thanks,
Anatoly
