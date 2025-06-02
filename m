Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0406CC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 08:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3042402E6;
	Mon,  2 Jun 2025 10:45:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id F22D94025A;
 Mon,  2 Jun 2025 10:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748853909; x=1780389909;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IN3tgauvEDrEH57murrYS7LKeMf5g/+B2GEvgexQjtw=;
 b=ZUDEnu9O15gRXF3llnBsStalIiTojncd+zfZ+K0L4p+ZF9FoJauFWqKZ
 ysbYw2IwXJCqgvP52iF+m+Y5sfsKn8XMfIJIugS6u9dThjjt7ZWx6C98n
 jGvK5U8Xqx7eOLSWBg3EwJxN1dL9u7jur+drHyw7muAIgD8OgKffP+IBy
 84MrXXbywAvEcPlMYeii76agKzHnRKOlbzAIIgTKzpv9WUaqVVm75MtNr
 C6MVNcn6hNSpwderH7THDHF0zF5HU2krCLQp3I6Ymai+fqKkWryTNxymn
 ovLvinA6EwPgIiowci1E9bSM8/ZN5aqjJLX0xytuYl1YaPG6UmxyB/7jT A==;
X-CSE-ConnectionGUID: mrDLWKcLTw2gVZe3HJ4Lmg==
X-CSE-MsgGUID: pj8abmyaRZeVQOCGPR0KHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50556741"
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; d="scan'208";a="50556741"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 01:45:08 -0700
X-CSE-ConnectionGUID: KtTStL/pQWeje3rzMZm5Ng==
X-CSE-MsgGUID: M4ahXv8UTxC9M2aUb9JCLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; d="scan'208";a="145434882"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 01:45:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 01:45:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 01:45:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.80)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 01:45:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdY/0NyKrtbWIVUkalk256+aRbhNCEAvQ+Q5NHrgDSTNpbjgEJGdTUK6rXqpGngS0peO6VEtgjZJhvEwqqYw37lO+FL3UpLIwKZFZb4Jh+omta5n7r0rZTJE4yE9mNTActqnizQ6JcLR1CC3q5aiYeZwuguy/FW82c1ZP74zjvMhz4g8nQCC8oTtCEpagMVb4Yvt9aq8O4INGV4kc/L4NkfLnL2tNWnNunbkZR0U8a3t2v8WjLtNwsMpjnP1QY8hrJFnp+DMTZfmJEQ5GvEWdzSDGnIspr0Zbktt2Erk8s03YYUw7kvQF+J/RluEwlWn2rxQwg+oz6byskO/oqR4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKfxMlpq5PjXPBKIbAd48sp0ZxR87DcVrE/cyqk87T8=;
 b=to27mzCPNYh7JDOmuVgWqNscXOciOaloCfnGwZHZYxBXacL38mpPD/7DdJzRFX549Z9ARDQ5s4tYrDqY8b3sNUYq0qiNtmFs0c29yAhf59340IWzpHzWNFiKe7OAA++YXoACLf0QBg04cWakeiYRNm4fSpl+ZWEm4M0FhQbhFjck5l+9I3oSn9L7DX2oPLTt0d8/3+Tu6cVy4drp6jpPV62za4QJrH74HiOERxUIO9Do3FmXR8nSnM0NWwq4wNm8hB0F7birKmFxwMwZjlgBdx/6vwCIAJGVx1bJxL+MWUe/0vBlu/buHe6hHtlZpaCjYxbLLyIYsKFbwznzMtVC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.32; Mon, 2 Jun 2025 08:44:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 08:44:50 +0000
Message-ID: <a9aa62aa-d6b9-4215-8ee1-1d99297d487e@intel.com>
Date: Mon, 2 Jun 2025 10:44:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] net/ice/base: fix typo in media type check
To: Dhanya Pillai <dhanya.r.pillai@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Ian Stokes <ian.stokes@intel.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Alice Michael
 <alice.michael@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-3-dhanya.r.pillai@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250527131741.7606-3-dhanya.r.pillai@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:10:234::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: b6323813-3284-4e98-c5b1-08dda1b1bcba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akc2TVdGVlZ0MTR3QTU0V05yaXdGWldyb1NXZ3lWa0NvSGtPTE5obDhQWWoz?=
 =?utf-8?B?RGo0bGJoMWpNcEtjU3hpTlNWUUlxcGdFNzMyTXc5cDArQWxUeFVuV09HcFAz?=
 =?utf-8?B?QVE2NW9tTEJJOEp6cVRjdG9nYU1za3lrckx0L0VBbm51WHBLZHh6c2d2Z2ZD?=
 =?utf-8?B?L0xDeW5tYmtiT0oyaGc4Qkk2UHU3N2s3QU1OaGw3SzBhN1J0YkREbHJobXc2?=
 =?utf-8?B?ZUdnaXdua1gvQ3V4VUs3bmpud3kyYUR4WmZOVlE3MzRVOEFNWWc5cDZDZDgv?=
 =?utf-8?B?dGhYcW9pbHZacVhZUzNRNzZBcWg4QUxvSklQZGRJeFlyRlpUZFJEK3NNVjEx?=
 =?utf-8?B?N3VrUVZmMzhlMWttQnlvU1ZSQVVKeFJja3hUOEhoNEh5WVNWYXQ4OFYvR3NJ?=
 =?utf-8?B?cUkvNGdZNi9iUUwzVkZISUhrY3pwZ3lkK1g5ZzdVSEU0Um52UWkyWnk3cTZx?=
 =?utf-8?B?S045Z095YVZ1OGR4QVVSOFRNY2R2ei9PY0hxU0FaczZpOFdWUEQrakNQV0tE?=
 =?utf-8?B?am9hc1ZSQktNVjdHNWNGVUZxRGRJTG9aQ3hmYStpRC94amU1bllkSGVjbHcv?=
 =?utf-8?B?VllXY050aHQ3eU9zWDZjMS9XOEJZYmk3cHRHelhTc0o3RUNuS3I3YWRGekVm?=
 =?utf-8?B?UVoyM1FZcCtvMkJ5TWVKU1o3OVJrV25QYU5XR0R3UXZlbDgyWGFjMVNUcnYx?=
 =?utf-8?B?aHArd0VlUXFMQXhsbVJuNHRhaGJ0Z1NBazlVeTlBQ2c3QTR5SnpFU1JBNlNO?=
 =?utf-8?B?ZVBrdDZsVzdqclBnOERFNWd5Y3cybXIxTXVST1lSQ3RvZXZuQmM2NUMvL3JQ?=
 =?utf-8?B?OEhBL0wxczdUZWpRZWpwNHJick9odkpRZENnckhsdHpKQ1crUUtPdGtuamtE?=
 =?utf-8?B?eG52WVhKTXVURURsdGRNaFh3eXBPM2h4eWdpZEIrTFN3a2dSVG9NendiWldH?=
 =?utf-8?B?NUlHbjJnemJqa0dvNDRlanNuZTF1TlluVUtDMk9qQVBZTzlQdnV1cXZoZ1Z6?=
 =?utf-8?B?SXZZYmZHQ1Q0b0wzQlJ5bmhtQzl4VitDeU5BQWM2YlI1WEJLMnFna0hEeWlC?=
 =?utf-8?B?ZHJlS2pYYUh4c0l1NHQwV1ZrV29GWUc0L3Zwbk8xaHNNdllVazcxcHlzR0ZG?=
 =?utf-8?B?OElQNmxCc3FzcWVGWU1CcEhmK0dYSXVNakNWUDB4OExRaENWbVowYUd2VFlU?=
 =?utf-8?B?ZWpYVmxVN2kyYmJiRUNZZ2RQSmZ0TnhsQWVHQ1ZCbVEyeUlzMk1nQjhEOURE?=
 =?utf-8?B?NkNmYklReFhrVjEzOUxmMnh6WGErbzM0bXdpR2ZiRHdXS2lkWVhwN0hYbWdC?=
 =?utf-8?B?a2c1dWJwbEF6SUEzRFM0N2dJd0RFSkNaMDMxdFg0dnNzeHJicjd6cy9ic1dS?=
 =?utf-8?B?STcyQmhvbnBQdkNjVEVGdktmMDJGenJacHVtY1crYzQ3QURsTTlTVXRtSWNZ?=
 =?utf-8?B?Q01OdFZ5czNxWlYzTXNVY3VYaExxYUphbWlFSFo0Smp3U05TM0c0RUh3bWJj?=
 =?utf-8?B?blhXZGd3ZXhqMmo0RVlhd2NIaEZ1amh6WXBPQjRBY2Fmc2huM296dGVDTHl6?=
 =?utf-8?B?YTk2MU5TMU1OemRaN1dEM3JiSzlLblRidkxEY2t3L0czL2Q4Mi9EdFRySUtm?=
 =?utf-8?B?V0ZNN2dDWEovUkRGV3hnN3o5MmxvMmxQcE1TelBiUjBzMk4wWEV1SVdwR2tx?=
 =?utf-8?B?dmN6L1pCUzhJbmE2QzdkcUxYY1VTSjVqZVg1Q2VxVE1QMGFQcUpBa1hMMUZ1?=
 =?utf-8?B?aUZkSWFwQzJlSllCNDVaM1FuL1VPWCt2c0JGb25UK2NkekZoSjk2UXJHd3Bn?=
 =?utf-8?B?dE40L3MvaWE4WkVCd1RsdVFoVU9zSUQ4NGxDZVVMQjd6Mmg3SzVjaDcwRXQ1?=
 =?utf-8?B?VmczLzFMbVV4VGNPSk4zcmliNEswYkV1U09NTzZVOFdkckV3WCtmeS8rNXNH?=
 =?utf-8?Q?lTBs8waadMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWxzcnp1eC9xRWgwbC9OcmxXY1BQenBVc3hhWHhmakdPS0pwSjlZemR4WU5k?=
 =?utf-8?B?TkhLby8rMUMydDRzWFE5cHpYZW5DVU1mK3E2aG1BTTlySzhmcXJld3dUQ29u?=
 =?utf-8?B?N1lMSEI4Q28rUkZDdHFTN1pmcFB1TzEra241RmlrcEozOE43MTV5V3BRdXY5?=
 =?utf-8?B?OGxxZkdsSEdZanFJQzdSK0p5VzhwaThKcDArZXpxUXIwUWxJWGZyWTg1WUdv?=
 =?utf-8?B?a2M1TmlXRFo2Z1kzbGVSU1NsRXo1cGk4Wlp4MVF2aVQ3VU1sOXhiU1pOMFdH?=
 =?utf-8?B?a1R4TVczL2pnckJURHRwRmEwSllHUUpoVzg3YUEvYjNFakhLYXhBN1hoRTB0?=
 =?utf-8?B?OHZyTW52U0VnbXJ5eFYreDZva29rVEltSjR1WW5NYTlYNlY0N09GZ1lkWlpV?=
 =?utf-8?B?ZmwzQnFaZlBuN1NWVGRQOE55ZmQ4ODdQZk1IWk5WTjhVaEoxZ01HUE9pSUlJ?=
 =?utf-8?B?V2p0azgweWs0VVBmN0hra05TUGZOV2dlR2NVYzF3Q3IvZ1BCcllPV2hRdlZS?=
 =?utf-8?B?c1hTaDBhNzNLcU9XRnlDRWkwUko2SGs5RzdFUHBtY3VYeWt4bllnVld1WjBo?=
 =?utf-8?B?TnBuQ2VGL1NUc3dLdVhSTkJrM2JlTlhScDNVSE9NbFlUa0RDOEttTnpzUzMr?=
 =?utf-8?B?dFYvMERWZm9pcTlxeG9EZk5BYkZQV0owZjlZN3NjN1RIN0JmRzNBUTVaZnNo?=
 =?utf-8?B?MmJ0NUFtc05Hbmt0Q3FiL2Q3Lzd6Ty9uL1ZDQzhubFhxZVE3clhBQXhGUVFr?=
 =?utf-8?B?OUZyM1dFeVkwME0xSjEvaTZXNXcvVi90OEcwaWl6TFpHeFQreTNTSFdxNDNY?=
 =?utf-8?B?Zm1FVzY2TEdPNlp4Y3NyQkU0Vm5zbnB6QUFkM2tiOU1sWXNNdnkyRHVsUDl0?=
 =?utf-8?B?QjhJTWxNMHlkT1JzVjRkWjdHK0ZRdUtKRkVENC84dEZrYnBocXFlOFVqUi9Y?=
 =?utf-8?B?TkI1UFNGOWQyTnF4ZkxERG1FRnNwcWp5RUQ2ZWRodFh2TmlwM2pQcXAzZmhj?=
 =?utf-8?B?OE45K1hEVUwxMFVNWll0bXJwWm11cC9iK1ZaaDJwamVDaTlzMzdkR0x4eE94?=
 =?utf-8?B?NC9CS0VDSk9VZ0lmci8rc0x5MzlVZnhJOWRiZi9Lby9pQnVYZmZJa3gxN05n?=
 =?utf-8?B?VUtvRXMvOFRUR0dKdHovenFOOHZCc21lRldrZFBXRmVEaENYWVMyQTFQWWkv?=
 =?utf-8?B?djcraXQybFN3WmlXbTVtZ0VnR241TVc3SlZQMU1tNUU2azg0QWZwcUt2NzMx?=
 =?utf-8?B?NGs0djVzUVpRcXhiQjVYVWZsa0FOSU1MdlN6VlZ0WTR1OXM4bzlFQ0Y0MDJV?=
 =?utf-8?B?ODk2dENWUTNPWGNBYXdRZzhRWVhNTGxBaURYQ0ViSDc4YTlWSnk0bWpVQVVo?=
 =?utf-8?B?Q3dPTVNveSthUURoSHVNL1NYeGVDZUdWNDR5ZSszR3dWQ2dzZXlCaGQzTlIw?=
 =?utf-8?B?TjZHR1NzZnpvVS9SQkZOSCtLMjdXTFh3eWtTMXhyS0h6OXlmYmZYSFBtNmZ0?=
 =?utf-8?B?RmdSeUpHVTczNnpyYWMvSE96RnZodzZYWjEySHNVRzlCQkNwMWFvN0pETVpB?=
 =?utf-8?B?cTBVZjNkUXdwbklaa1ZuRXZHVzBYOFV1MTRHK2pLZUpoNi82ams4ODVseE5O?=
 =?utf-8?B?TW5WYmV0cHBHTy9ha2M0UGdCWVk4VzNtemIxSzcxTkVqOWtuRk5EZk1CMm5G?=
 =?utf-8?B?S1MzTVBMcUZDNE95eG5NNmY5L21zUWc1OW9tZFE2ZXhiOUxXVTRZYnpQRFlv?=
 =?utf-8?B?cHNVUnY2VEo2b3VuNEx2bVppYklZUVFNTVM5YkdFQXBvcGRaMkk3dzZtOUU2?=
 =?utf-8?B?MW1ORENBQlk1MjFCSldUNm5kYXRQc29iUE83RW1vOFNWNGhRNStzWkw5NlVD?=
 =?utf-8?B?aFcvNU5tS2Z5WjJiQUZwQ09tWGpoamkyQUtGOFVtbVZ6Z0Irdnl5Q0REcWdZ?=
 =?utf-8?B?TXVoaDh1MS9GbEpkRnlDWW84TkFTUkhDd3JQZFFvNHZacUpvVGxaa2hsQ0ZI?=
 =?utf-8?B?ZEZDZEc0MFhjYVRvazJqRFpOdzhtclhDcXlzS0JGK0tQSDNMTUltNHlrYzcx?=
 =?utf-8?B?eDdQeGY5amVmbzJsK3gwd28zT25pNDhyM090bHFCbUZ5NTA1WTVJbzdKdmRE?=
 =?utf-8?B?ci9NZlpoWHM3czZ1ZWwwb3R6U2VSMk9VOFhRNlZCWDRhQUFtQUxISDE4UVhZ?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6323813-3284-4e98-c5b1-08dda1b1bcba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 08:44:50.7906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPq2jbssh0W9r74xnEJiBIL+DCm+z4ZYnMhYysMJXMFe8a5azrhBtS7K/ixxUPddRzGpz46uVwA6vMwQLCBHeRploISHs1zfP7IKWR+lfBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
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

On 5/27/2025 3:17 PM, Dhanya Pillai wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Found a typo in original implementation of ice_set_media_type,
> where one of the checks for FIBER checks for C2C media type
> instead of C2M. This results in failure of this check for some
> AOC devices, consequently setting  the media type as AUI.
> Bug was found in ethtool.

I don't think mentioning ethtool is necessary here, we can leave that 
out of the commit message.

> 
> Fixes: e7bd7d54a26b ("net/ice/base: improve PHY media capabilities handling")
> Cc: stable@dpdk.org
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> ---

-- 
Thanks,
Anatoly
