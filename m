Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F7C88E50
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 12:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 955DE4028B;
	Fri, 11 Sep 2026 14:14:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8DDA440264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 14:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789128892; x=1820664892;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=A0dze/D8c6yE1P+ts3zY3Ik6N6ehTOq+2usqIPglM4M=;
 b=FRfieUOAwnQH2l0aMK3hctE4gukqGbBhqkDf8MoVsFgIOJMV5wfXQq8e
 6I+gRwbta6VrW1Nx8Ht98GaBpzIGuD6Xz39UVwyzvwEFR3zeCRntHp+q+
 NTi5gwxNs/UgUfbhsHmtL2A9r0NJ3x+p8USYSt0BHRLkOFqpqYUlG6Eug
 nk657FWGzCl45ALVx8bkb7POtnwG45xpTqO1W8e0t/Y9QvWEDQIZPk20O
 X4eFq1cYR1VsOD+sjo5c6R2IatP1CCn2MwKEE0NOVcW1FbwjYq/YWRdws
 PwLcBHXjzf1tKoUiKiBl4EDPTvCpGRikCUCKqVnO8RXP74afQjtA2/A0S A==;
X-CSE-ConnectionGUID: NynvboMeSAOLzbPizwcjAw==
X-CSE-MsgGUID: Q0t5IFzFTVWM+ZBny4sGCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100253343"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="100253343"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 05:14:50 -0700
X-CSE-ConnectionGUID: RRD/+x1KSJS9NXb2jR13sw==
X-CSE-MsgGUID: W88sXpppSbyuVvT7P7+gJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="276050927"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 05:14:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 05:14:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 05:14:49 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 05:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT/XAUApze1/03Di/WYFjF8S22t/WhsCK3UqX+PrAQ8fs7wZw+745ZonWoboumzK9DLSjhf/I5s8Zb0hs4emjU7OG0nWqH+GQQtrpkdi+vcSI2GF3syc2dBkSV20mbF2wERJxBAjp/ytuaK1UsfEecCKb5nYWgNR9BMwUVWBl/6T5ii03WBZiBd2fsZ/omtU2ltjV4rzdxyrfZv3DRMYk3eLIv49npqdcPCPvwvi5dR2eYeWzU1u57WToF51m3gOcjXVJBt19//Szi7krCmXFvEbSxvm0O7Q8RuCFES0xOzvXypP3r0JRcefR5K7r9W1m1mBWLSp8SnmbmfdjXpBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQHNqE1aau3zV0nfI/7kURoTAFuDce2fbz+pC5KypJk=;
 b=SG5An5IvOxDX5ruIUsZcyfgMUv0JHbs4O/c9enL0LXC8goHAy7VABPt3k+h5VPVhl4StecG1zjtZrQixfydURsK+TY355OmQ39NKsSpP+xbI5eI4L3pobrz/DlNsGhL7dWvEMd/77QkLu1l143hLuVnW6ilKldV9YTCnNDxrzu6jFPfWyIq6q2NG7snsHGegPCEDUlKj+3mswvoNZik9RAJSAmm03t73f/c+za7pO4wkBsy5OoZux5hhf3rQgZANLXhGIHbChoDvmBqLlgADWmWJzK3ZMK7u102ZSBN4a7YTzH1ZEfADe6wMKyX6cjNnTmxmAgBgUAyBeHvQnt7Wlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:14:45 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 12:14:45 +0000
Message-ID: <d4da5ffe-0c64-4c16-8fcc-c2b1fcbe7221@intel.com>
Date: Fri, 11 Sep 2026 14:14:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] net/iavf: accept up to 32k unicast MAC addresses
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260904122804.2256481-1-david.marchand@redhat.com>
 <fa883da6-5491-4b9f-8382-9102045427c8@intel.com>
 <67d60d81-2424-4666-b05f-127647157bc4@intel.com>
 <CAJFAV8xfgJQpa2OedL+aDmaLyEHk8DVr=hVVf-muH-za0UOw+w@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8xfgJQpa2OedL+aDmaLyEHk8DVr=hVVf-muH-za0UOw+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 688c0a47-efcb-4dcd-f2ec-08df0ffe4433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|22082099003|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: XgOxJ14jdMlVggO58ljfNvAKcAIVxjs/tRBKeYMTRaqNd4O6ne5HD0l/XOfpocqZYSdh2ZtELBtnKGihGFfLh3uhiU0c2/ApkPQFCnnSMwkUlDKuC5Gzc4BBVh4frw0qjLzXIEtP5WI76pGiGMcDhMVzzPeUC7HyiKIjVOxDlmp7NZzyhyf4cdfALanEEDbqXJlA7X7V0DA533oPEcCT1W8HhbpSjmPxf+DrRrC+9a3Csf+6vgAOa/OJ3yJrpqxNl755Z6Wuisfc+lxiIQrmcktaZ+0+/28G6QbUEByLhwp4QjE+eHe+whWubuu97gMRP7Nix29JkQQHJinC3YAlKJDYj75bBN8+dwsBYjbHD7CluoCWZnmEb8ChMaZMg+xYs/jUUYc9DsR4Nf2MmUtc/yd+sPpx0+0CTQfZ0t3BYetqEQ3LgExZ7Ht/wmQe77+Hmboef96/9tZSmvxNUHQ5BqqRktjNPsdoF0ZBX94qYAHAeSQt1waPMojn9TG0LuDL43blumDKvACMW8gkjpB2ERexyS8xx+pSvGagy0hdKTZ4kCP6oXOoux7Bj/AEVFE9cIJSYUyEvEQYQRe8YF0hy1Ivqwn4s0GxWsCFFRBD2CaNc3udFRc/cU6Y4a62w0GM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZIeVNkRG05bjR2dTEzMnYvUEMvTEZzd2hReklQMDBOWWVKa3A0RzNtaTBR?=
 =?utf-8?B?cDg1ZkdnNGMzTEtPdFpKYXhTMHcwRnJjMVdHSnlTcVN6alpKQjhoa244Z0Vt?=
 =?utf-8?B?UmRoNDNyV1pBV2ZJcjNURmN4UmpabWgwOVhScm1tRjFDcWphSEJGRStmTlV0?=
 =?utf-8?B?S3dPNGU1Q3B5THZDc0NFeFBHYjBZemJHNzZITGQwajZYTGZlVk02M2JSVC8y?=
 =?utf-8?B?aUl0eFJTSjJTeUxhcjAzaXI2OVhaaVdaRmh6bFg5NW1tTGJnMVBqL1JOeC9q?=
 =?utf-8?B?ZzJacXpXRzZvQVBkeGY5V2lNMC9CWGV2VGtwYlZZbE1JQ1liTHJKSEUyQ25r?=
 =?utf-8?B?K0lvbXIxVUYyVjExNEFSNXhYSk5FdFhTdWNEUEZFM2ZSSU9seWdSRUVYbHpu?=
 =?utf-8?B?RHcvUWJ3T2txNW11eEVGbDE5NHgrd2IvUlBFNmlZTFFBRTlwY2I0NGthTW4w?=
 =?utf-8?B?Zk5vVHAyOU56MFVpTThxWWZsemV3S2tYRFY1MkdTR1JTbU4zTm9ncVdmSitq?=
 =?utf-8?B?TEdZbDVnVjZtVjJWUTdqaldEeUZjWjB0ckw1Tjg3WmZUYlB0RFpYamY0RkJH?=
 =?utf-8?B?bEFLN3pCeGJCcUN6SFpCMTFHVGo4MWNuNk1xY2EvY0dpMXgrWU01dEpONzBS?=
 =?utf-8?B?K1lrT0pwVXZFOFRVaXlXVWdEWnY4UGtoUy83M3NEK1NVa2FIbUVhS2dDU0Jh?=
 =?utf-8?B?NnBYUUJmTnhXUU9jMlFGM0JrVXRtM1VKRm5qLzZzVE80Mk9XeGNpQWZFWTFq?=
 =?utf-8?B?ZTBsSGNUK1BYVXRzUmsyeFE4OVRtNHFPMk5TT1czbElqZEpxK2VnM0dObVBa?=
 =?utf-8?B?akVzTFNHZ0ppNlo2ZUdpbHFjQlc5SmtCa0ZJY25LaEtjcDlzNnRqemJnbHZI?=
 =?utf-8?B?ZXViOXE3MXhDRUtURTdVNFpOQVZmRHdNYm9zZ2NNT1JkK21IOE1MWjRGL1dE?=
 =?utf-8?B?SHhaeEZkU2R0QWZxWnkwRis0cytBQVpvVmd0cU91T1QrS2dIdlRQbStuelNU?=
 =?utf-8?B?MnJVbTVFWnNDb3FCeVY1R0hKOGF3RzUzT3VPNStsZksrQnNtQ2Rnb2gwVExB?=
 =?utf-8?B?T2JOWGdDa05ISHlBeEh6Rk9OK05uZStkdVVBQW9RY0piT0VWam1nTXdVdVNk?=
 =?utf-8?B?SzdqeHFta255Vm1PVGI3L3VDUUtNNUhDUnJQeXVtZm5sK2VuU3l6T2hITGRH?=
 =?utf-8?B?aWZWVnZMell2RHh3eFdsaUIyQWxvcmZRMWpTclQ5SkJ0bU1SclpkcjRuTi8x?=
 =?utf-8?B?S3JISHhqdFFnQjhJMFU1THIvQ0pQNkRPeGpobFRHbDBRSzBXMHVSYW1PeWVx?=
 =?utf-8?B?RDcrREJTbnRmcWV2Z3Vwa0srQzJoVXNYQ3dpL3NTVk01czh1TzFNVm4rcmtZ?=
 =?utf-8?B?TjBnYmsyMXBjbzhLTWx3VDU4NXhoeWY2STMzSVViV2ZneUFnTjZmQlB6RTBk?=
 =?utf-8?B?MTdhUGZjdVJpL1d5VXBlK1ZoWEszc3JMM2VPVXNhQTgzR0FRelBXVHZBQmNv?=
 =?utf-8?B?NUhpM2FnOU1XUGhwQnNhUHoxVVhOYUlTVFBKRzFpZ3RlUUw1ZGtpVFhXbnBX?=
 =?utf-8?B?ekhWUWs4cy9PaUNXOXpvd1I5V0RLQllhNVpHYW1FR2hSTXc2ZFd3SFhSRWZw?=
 =?utf-8?B?WUJoSGMzZWlSVmkvcm5LczZqS2lScjZOVmkzSUJQRHJIQWJyTCsvckU0ZkZR?=
 =?utf-8?B?cVRYaGp3SU5aVUs5VGZnVUVkMFE4dU04a2hINEs2enFrZVdnd1VSYlg2dEkx?=
 =?utf-8?B?K0NKYUsyWmZXUjVndHNPTURUSVJvbStUQkUzS0l5SEJYT0o3dS9hTW5NUVFX?=
 =?utf-8?B?SzBXT2xGT0JTNldDdmliZm5wWTJPYnNPQmpIb0FZcDVtNE44UGFyYVZlakJH?=
 =?utf-8?B?OHJNZjIwMnl0RVY3ajRGZ2pUQTNJY2dzTnk4QlZ2eGdWUldFZ0tEdlZmZUox?=
 =?utf-8?B?SHozVUJac0hjczVHUTRWQWVWNUxwVWtsb1kyY2JQQk9mcGFDa1hFWDF0QlBo?=
 =?utf-8?B?SHU4TEh3bW9DbGxERERDRnJ5RHppR0ROR3hzVFFXMWFGZWZNYVV5QXhuZWRE?=
 =?utf-8?B?YzQxOTFMWXY5bjVIbVE4QjY5STkyNWZtQklPc3ROb25IaVE0MnBNUmh0VWhx?=
 =?utf-8?B?OExqTW85ay9nREdYK21nbHhWbHgwczdxQU0vTDhkQ3JRV2RVVTFxZXVFeUJL?=
 =?utf-8?B?blUyUHgrU3M3ZUs5MFBsS2N1Z3hlOE1pRDUrMWVPMWo1ZzRKbDlxOVpSbFhR?=
 =?utf-8?B?RTBuNkgxV2ZENUdUOWhHN1lOT1FlM3ptNUk2WmRvWTNLVnVpMUdDVFp5K003?=
 =?utf-8?B?NEVFczdzbWd0L2tsZkY4UEpOQnhqYUpOSmJPM01jNVNCbithTGgwNFphc2V6?=
 =?utf-8?Q?2W1fj+doECLMSMuM=3D?=
X-Exchange-RoutingPolicyChecked: p5UidNBpoT/8WHxg0HWpa1azVU48QpMR2gtTNZuJKWtqRYLWNpYmmQrj47269y6jmVyRLXbJ59iHBsEy2rTH3iVTRR/YZGIlQjJnRs5X6MSjR6d4P6hurMzA7u0TRueww4Fcfkb1K5sUqU4J44s2urh46wTw2OcmZmWeuC0J/f33MjBx6BU6mKDpqj/+wk85IoUMlOjATBnlU4Aa3w31n8CYMMO13/f0Ar+Uv8BiRun49GzQb+MfgyVdcZT56WO1gwPGBmt7N1QggNzZN7emEMudEgBQBMGdg61ixV1fvDgHJOF3Gjb1tOAwEWT5x743CIWyaKQIs7vO9/NuyKS6Aw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 688c0a47-efcb-4dcd-f2ec-08df0ffe4433
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:14:45.1417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlf9o71WgDUTqp9sLMxczuS0O6y3DrHf8mV3B/1H4hXmLx867woBWhEMShfGD9Sim/UdcZuz1WCRvbZAe9mSefXln3Y7x+3HBVBWU4PjkJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
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

On 9/11/2026 1:52 PM, David Marchand wrote:
> On Fri, 11 Sept 2026 at 11:37, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>> I would have preferred it if the caller managed the chunking, not the
>>> "add_del_addr_bulk" function. There is precedent for this style of
>>> refactor already [1], and I would like to keep things consistent - keep
>>> the loop simple (without memsets etc.), and make the caller manage how
>>> many addresses are being sent at once.
>>>
>>> [1] https://patches.dpdk.org/project/dpdk/
>>> patch/5e6a55afa2b45e3ee5ec17af7a6c548c96e9698b.1771945933.git.anatoly.burakov@intel.com/
>>>
>>> This specific refactor is more about removing rte_malloc, but it does
>>> also reorganize the loop in a way that I find to be more readable.
>>>
>>
>> I tried prototyping a loop, and realized that the fact that MAC address
>> list has holes in it is making things a little difficult, but here's
>> what I came up with as an alternative implementation, I think it's a
>> little clearer:
>>
>> ```
>> #define IAVF_ETH_ADDR_PER_REQ \
>>          ((IAVF_AQ_BUF_SZ - sizeof(struct virtchnl_ether_addr_list)) / \
>>           sizeof(struct virtchnl_ether_addr))
>>
>> struct iavf_eth_addr_cmd {
>>          struct virtchnl_ether_addr_list list;
>>          struct virtchnl_ether_addr extra[IAVF_ETH_ADDR_PER_REQ];
>> };
>>
>> static int
>> iavf_send_uc_addr_list(struct iavf_adapter *adapter,
>>                         struct virtchnl_ether_addr_list *list, bool add)
> 
> Passing the list object means the function *assumes* that the mac
> addresses array follows right after.
> Idem, the sending function now assumes the size of the passed object.
> 
> If the filling happens at the caller, then I'd rather pass the full
> object and its size.

Yes, agreed, although `list` will have information about list size so 
IMO just passing the full object is enough.

> 
> 
>> {
>>          const char *opname = add ? "VIRTCHNL_OP_ADD_ETH_ADDR" :
>> "VIRTCHNL_OP_DEL_ETH_ADDR";
>>          uint8_t msg_buf[IAVF_AQ_BUF_SZ] = {0};
>>          struct iavf_cmd_info args = {0};
>>          int err;
>>
>>          args.ops = add ? VIRTCHNL_OP_ADD_ETH_ADDR : VIRTCHNL_OP_DEL_ETH_ADDR;
>>          args.in_args = (uint8_t *)list;
>>          args.in_args_size = sizeof(struct virtchnl_ether_addr_list) +
>>                  sizeof(struct virtchnl_ether_addr) * list->num_elements;
>>          args.out_buffer = msg_buf;
>>          args.out_size = IAVF_AQ_BUF_SZ;
>>
>>          err = iavf_execute_vf_cmd_safe(adapter, &args);
>>          if (err != 0)
>>                  PMD_DRV_LOG(ERR, "fail to execute command %s for %u macs",
>>                          opname, list->num_elements);
>>          else
>>                  PMD_DRV_LOG(DEBUG, "executed command %s for %u macs",
>>                          opname, list->num_elements);
>>
>>          return err;
>> }
>>
>> void
>> iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>> {
>>          struct rte_ether_addr *addrs = adapter->dev_data->mac_addrs;
>>          struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
>>          uint32_t idx = 1;
>>
>>          /* Handle primary address (index 0) separately */
>>          if (!rte_is_zero_ether_addr(&addrs[0]))
>>                  iavf_add_del_eth_addr(adapter, &addrs[0], add,
>>                          VIRTCHNL_ETHER_ADDR_PRIMARY);
>>
>>          /* the secondary address list is sparse, so gather it into full batches */
>>          while (idx < IAVF_UC_MACADDR_MAX) {
>>                  struct iavf_eth_addr_cmd cmd = {0};
>>                  uint16_t nb_addrs = 0;
>>
>>                  for (; idx < IAVF_UC_MACADDR_MAX && nb_addrs < IAVF_ETH_ADDR_PER_REQ;
>> idx++) {
>>                          if (rte_is_zero_ether_addr(&addrs[idx]))
>>                                  continue;
>>
>>                          memcpy(cmd.list.list[nb_addrs].addr, addrs[idx].addr_bytes,
>>                                  sizeof(cmd.list.list[nb_addrs].addr));
>>                          cmd.list.list[nb_addrs].type = VIRTCHNL_ETHER_ADDR_EXTRA;
>>                          nb_addrs++;
>>                  }
>>
>>                  if (nb_addrs == 0)
>>                          break;
>>
>>                  cmd.list.vsi_id = vf->vsi_res->vsi_id;
>>                  cmd.list.num_elements = nb_addrs;
>>                  if (iavf_send_uc_addr_list(adapter, &cmd.list, add) != 0)
>>                          break;
>>          }
>> }
>> ```
> 
> Well, if we go with such a refactoring, I am not a fan of the nested
> loops, but I get the idea.
> I'll have a try.
> 
I would argue that nested loop doing compaction is idiomatic - it's 
naturally a nested loop operation, so we're going to have nested loops 
either way. However, the control flow is IMO much cleaner that way, 
because there is no special casing inside the "send the list" function, 
and additionally, such an approach lends itself to much fewer virtchnl 
calls - with your code, in a degenerate "valid addr in every other 
slot", you'd essentially be spamming virtchnl on every addr, while with 
a nested loop like mine, you'd just compact it into a list straight away 
and get away with far fewer virtchnl call-ins. So, I'd really like to 
keep this kind of flow, if you don't mind :)

-- 
Thanks,
Anatoly
