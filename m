Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85616C982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 13:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5351F4027C;
	Wed, 23 Sep 2026 15:03:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id DEC9040262;
 Wed, 23 Sep 2026 15:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790168588; x=1821704588;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q17XjL02tqWyLvf6BW1u28wbPKvKryGv8ubH9BHgGc0=;
 b=iYgkLuTyxXidlW0jvSFEsN3nfHNVtDKcu6oNjXdN5+JndxSzZ+KAxae9
 3ekiOv7l77CDOfSUZEY/ncwIiiDPeQ/XWZvNuVqEjuPXRt2UnBPCLV8n1
 puHmEOwSy+npXMlMj84SckDXAChylIWh5lBkcgzUJHeOBMfNkeaoG7uAu
 AcndH2JZAN7aG6/YJtEPwnpnoAYYkH7lA7xudExFGNVjKp8p0Wl6vuHLp
 Hl3FPOlKXUwbf1z5M4R6WHJ2Du+ZdGkPCORQEAD1L507jyVaaQJBqmvk7
 1s6tJVZq4zhsF4DkGPbAk0LDYSfN7UWDgUhLK8hn2eGobAXiQr1qvKZkz A==;
X-CSE-ConnectionGUID: VCIoJiG9Rv2B57nV0QdhCA==
X-CSE-MsgGUID: ke0xUMXMQJyowp5VuxOd7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="89994496"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="89994496"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:03:04 -0700
X-CSE-ConnectionGUID: AW5cny7OSquMSPayJhiTKA==
X-CSE-MsgGUID: ymG4+Db3T+agxvHXadprVg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 06:03:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 06:03:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 06:03:00 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 06:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrcih+0mz/yeXSNbwbQtbSxG16NhpPL/UFocG2aCgleA6qgoy4gBmfSGG+nFfLEPWcynr7CI6ehtey3AKqOmQUyfonfzLjUJfLw+tlFsrJwnnv84qa7WsQ1ZK4hkYlLZ3n8y2e6XdmcryAscsOkcJpxOJidt/42tx3pdy8PLXOpL6fs1L18CHZMIm+0dfQOYqXoKdwSQQIdZUMnYen9SR3Utolnp4ra1K+i5a0j/BuD3IPWLyFOb3u9xJB74v+mEq/v5yUauqgmo62xcSXg70pzEkFBjNiK9adW2+wjjU7NiObZEDVRqu4uVWQgfuNP3d55ZivBPW7svZQmw28mLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwN6mQvobdUz6jBJqMFDTTht8oxeFmkAAhi5yE+LTRs=;
 b=HoHKGKc2d3osAP5dd4PM3PhGLL9x0VWJy/XM6dZTr7wqYtgsB1GNijNYDQ/FwgNklhOGE82oZ+dIsveBvJSEJaN7zof32uNNlUDfr23hAa/b0ajj07UaSp8EgqXW/FJIDHyhqq2ojGi7jpq3N/leYmh5sx5GaKYaTyDy1AXBtDfKXwEZqigCenbainF2phjqbLWDvKFz84Sx4w7LNURWpKyTJphSCMF0fLSsaTCeGkJgscW4OCWo5tESWGMc9JZayGWuEG1M2vm42OB1ZN6wFWdKyNJwbpzr92oFfngpuI1K9gTTarRkh65yE1NJ1SKuJMldclq9Q1uKq3MZyv8Hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS6PR11MB400772.namprd11.prod.outlook.com (2603:10b6:8:528::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 13:02:58 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 13:02:58 +0000
Message-ID: <b89b011c-d95f-4458-aca0-fcd4df3cebd1@intel.com>
Date: Wed, 23 Sep 2026 15:02:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "app/testpmd: stop forwarding in secondary
 process"
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <20260507210152.410419-1-stephen@networkplumber.org>
 <20260507210152.410419-2-stephen@networkplumber.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260507210152.410419-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0083.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:345::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS6PR11MB400772:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf58338-5bb3-4cc0-dfd2-08df1972fdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: v11VRhDTzRcyhjD6IiVx+6NEg4zCfNZfKabTkBuSdSXbzTn0I260R7LR+TmEb4a8sngAt/LFOEbHprLCil8vwfdhrDWuNJ65NAQ3lOcTGyEVZVaPTWL2RKQyYS2Kczmjt7lOUuCPjp6ql7XDY97Pvgd8tsu7/O50x4TgH1ye9N0gEp2i3zmTwiJBGb54BoTa5o+NwlpXrjB0eI1xvcGZHIBD8xXEwuA5AMrhzM2xMk5S6v3pZVhYnqewsLCZKkeQmYbSWsYljqt8x9iKf0Ey9WTy9QmFO4Fbk3l2eSoA41G8mok4Ts5mS2n+W0v6mGVomQSUYVg6wE4hIy6Emn08QX7ni5Q64lpXTkeX//hGSCQfC6gl0KTzW7H+3Qbf9d6mzKoQmTyat44vvBf4OSFd/H0nU5aEQSoYivQiYyr9kFPnO/TIWrBMh7nWypJSIRQxKJORA3KHEym0RBOfoLxOr3jsG808wsBDqjusT//jSxaerNbLCInTd7Oki/IWgOZHWWzUQ7EVeCl1JbFvUqzvFBZQOLiNDzgaphFBbiy4bd72ywzSLBBytWCTdoO4AToel6TDK+74KephXNW19ALXl7If305QVOqMhGVsHJnbg5GE5D5FgdP4w+YG7MaTNhQ7DoVfw79flheWdJ5XMjvoRmVkSMrjYwgI6uGRhPhRsYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTkvaWtPdHhvcEIvcnJZcXBMREZyTkYzWWF4NDhzYWM2c3BaVVRCSFFKTmdI?=
 =?utf-8?B?cklhRjBWR1YzUUY0emdHdjZ4Sk95eVJ6WHhRZnl0RXVxNzdzNllEV1dkYWNZ?=
 =?utf-8?B?K2ZNMStydWlqMzhvaWJCZ1lEajhXNDJncHBoeHIyTHgwdDBlZkFWQ3I4eE9H?=
 =?utf-8?B?a2pzZGU5ZmdKWUxwbEZ4S1EvbFk4YklYbWt2Z28wL0F4UkF1Q0g5d1RHR2p5?=
 =?utf-8?B?bExsazdpY2ZDTXJDTFM1QnFpSDFuSXNJcXltNklRQ3lTa09HYWNwTDk0MnVm?=
 =?utf-8?B?ZEFzQnl3dDUyYk9iTnU5WVRHRmpFV1BtSWdqOUgzOFQvc09OZ3JKTEJEbkQ4?=
 =?utf-8?B?Zm5sT01WQVFPLzhsSmxYWXowVHpsQ3ViMUQ2YXNWYkEyYlNYbklhZ3pvbkMz?=
 =?utf-8?B?MU5Ed1NqVFJpdHhJL1c1QWRMcitieDJVNFVMSWhhVmpoUlNUcGYrQkFPaXhD?=
 =?utf-8?B?SmU3RDVOZDRwSEtITGxCY2VIVkZrZDN5ZWlFdURFOU1ycTdqR2N5Y2pRVDRw?=
 =?utf-8?B?RW5ZbE5od1k2MDdkZnJ0OEp0ejNYeEc0elFQWEhwMnF0UlBubFN4MHNJblB4?=
 =?utf-8?B?ZTRNSlNqV2FJQ012VVlQQmFXK3hSQjJNTmRPVEI1OUJHZWRKb2lqTXRoVEd2?=
 =?utf-8?B?QkVXeDVWN1BxSGpFMDRZWU40QytpK1I5S3h5UE5wZlZ0cDk3cTg5dHB1dkRm?=
 =?utf-8?B?amJCL29FMXhtMkluQ1VpYmJndkdxWEF0ZXpnV2ZBVlBraUJBSGJTN3dtWGpV?=
 =?utf-8?B?cVdtczhOWlVNd0U5UmJGWmpEaExHL0xzZEJzUDRqWnBJQjkyYXc3a1NiZ2ky?=
 =?utf-8?B?eTRnZkJxM1RUY2FYMjFkeXdodExmNVcyTDNmN0N6OVA4NFBIU3BucWdpUTVZ?=
 =?utf-8?B?aTRZemJad0RIWkZyK3dOMlUvc2daYUlNeHNWR0RPTXhEUFpPN3hmOFc5TkRC?=
 =?utf-8?B?QXpvWGRaQ3o5eDV5MnRHM2xqcnJmSzI0N0pUbGZRWkVZR1h1V2xMYktSemlI?=
 =?utf-8?B?Z2FXT2l1WUNWUWZxaHNJcEk0ZmM4TkZ4QmljeGg2eGg3SzNKR0R2Q29HaCtz?=
 =?utf-8?B?YjdXcC9nRlFFY1g3dE1xNU5GUVg1V0doZTBKRXdiUTNJWHZ1ZG9HR2toNUlv?=
 =?utf-8?B?R1J4SGV1TjU1MTIrT1VVRlVVSFdYdC9oTHRhTU9oL2pVK0JuQWFReWVwY2NU?=
 =?utf-8?B?d09uTytuZzQ1NFdVZEFkcHZ3SHJWTzhCTEZEUlh4aUtJN1NCcHNKY3pIZEdU?=
 =?utf-8?B?ZzgvMGgrQWZLVEZCWVRWeEcwbExZZUQ0UnNHZDgreFh1NGltZHNVamM2K3Jl?=
 =?utf-8?B?T3cwYmJWYTFUbDRwWWt6QnBDUGZWNitjZG04aFM2YWNodFJROVVXczV0WFNV?=
 =?utf-8?B?QlNWWFRhT3ZjWjBsVlp2Zmx0aUhqeUdhN3AzUTZZSkdWbllGTU5uVjZPY25S?=
 =?utf-8?B?M3hLNDBvVjBRajR0RlJhOW9HVG8yWWNmZlI4Q0hNMSttZktudDJjOGZ6eUh5?=
 =?utf-8?B?bVJHdlJmVzFCM25FZFZYanIyNWxuR3lCcmFUS25uWHBWYk9CZy9TMDJMQmY0?=
 =?utf-8?B?Tkw4UkpsR1hBK0FlMVNGS1VmZ2VoeFU1MVJ3RlY2RGRJRVdsanA4ZFAxK2h3?=
 =?utf-8?B?RGtJMXdlY0xaZjB6TWpmLzVXM3hrNkJqTGhKeVdoQjh2VU5yM2xIL05KR1RC?=
 =?utf-8?B?RmxaOEJtQXJXb0lOSmVhdWJjN0czUDJyVXlva2RDODVWS29QdWR1bG5MbmxE?=
 =?utf-8?B?b3FXV3Q0aE9VWnI0ZkdEUGhxcU11NVBlVCtOa2EvRXV2K3d2SUVvVGxYSnpU?=
 =?utf-8?B?NFRpa3ZkTERSTXF3c2JiRlh3U3hFbC9hUXNIQ1Z2N20zMEtHQldBaCt4SFhG?=
 =?utf-8?B?NFNRbzdYQzhlTkt3VHpmci9Xd2JhNCttcTBVU25xY3dmOHRUOVNlSXZNblVG?=
 =?utf-8?B?ZUlnTjZsblZLcUpHaHRvTW1qZ0xDOHo3Z0ptSDRXaG1VTFVCZS9kT2pST2lh?=
 =?utf-8?B?SDR0M1crYXlrQzFWVWtud0xpL0x1WDI0b2h3ZnJpb1pwWG1jM2ZqZkk5ZjhB?=
 =?utf-8?B?U3EwQ1hKYkFxMzZaYlJGTyt5cEJiRUlnamdMb3RzOUNYYXVKK0JSY1JHY1Jy?=
 =?utf-8?B?REN2OUo1RmxKQnljbjQ2T0dTSlZvaUFDOThaa0k5cFZ4bHBkamF1UEcycmR2?=
 =?utf-8?B?emkyOUpqWXBEMlNiSTdENWdYcEs0dDZOM1o3d2xxT0xjdnQyOHhKQnYyTVhh?=
 =?utf-8?B?a0JHNG93c2hkL0s3azBKTzZGVGl0eHRQQis5NHo4SlJNN1RlcXAyU1JNb1ZU?=
 =?utf-8?B?Y0NHNm16Y3RXd0UwMXY0WHNpRFBsRnVHalJ3TnpHamdEY3V0ZUpuWCs5aUts?=
 =?utf-8?Q?AISu9xYfS4S46zXQ=3D?=
X-Exchange-RoutingPolicyChecked: lktA81sZnaWm1xLifxkLSstHOLq5OXR0uHlA86dyPte2w2HMMBEBUHPPnLPnM9OxGKTirylvzjCf+S09SBvttpqPdEoPX3wr9C16lteGFOehihZsQMs7bUqWGB/gJkfODjohsy2T8mNdA8iKc48oFfhhYzVXY/bNWLie+m+S/yvku1cNwQ64hFO+8t0E/h/52swn99zPomZqLbZ7TYtsEn8U4ysEFHA6bA1hOVjrBzuXbF179ANLlLIT/AwcFlx3ZWg6XssTs/q4VDf1D/fNg3SX5j+cajUKYxbnqJXe50eYAfEQN0sczi9BVeoKFuH5M1XQZWLWkQ8w9GijbQ/TXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf58338-5bb3-4cc0-dfd2-08df1972fdb6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:02:58.5372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bdB1L1jst8bV8vadyQ5UvBt5wKhr3mZLyrKhLgawKyXMNpWTRGtiDC4sOtt/UUYXAlnRL26u3cqNJETKw5UWtWfqTOrSrk19n4t+Bf5BPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB400772
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

On 5/7/2026 10:58 PM, Stephen Hemminger wrote:
> Testpmd must not assume that the secondary process
> is testpmd. The notification needs to be done by EAL.
> 
> This reverts commit f96273c8e9d39e472bb07acc05e493b1e712e51b.
> 
> Bugzilla ID: 1942
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
