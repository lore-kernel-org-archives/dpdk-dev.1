Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA0CD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:50:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA06F402D3;
	Fri,  5 Jun 2026 16:50:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E1864402BA
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780671023; x=1812207023;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ErHZxuyzaIuelUHMMY4gSqsoE/IMuJC0YHaks/FYXVw=;
 b=AWHNHfCoNs6A56gvTxW+EB5DvBh7hJq0IDERuQebsPI4i7ZUaYDGekma
 NfN3EHX5s5XOHhpwfz5LakhQ0ew6z5Bdyyr3ulS0G3TDL8e0/A+t6vAz+
 pZZ1Wxp9OJGzmnFzafj1dNpuN05DqLT1igLgEqWc1h3+192TMgptxa6lv
 w8GhXoReE6fsm5dlgoyQ5VzXhooQYWZFPpDh1kgdMARsGW5F4erYdkRbY
 NiHMDrv3Argy4QxvATY1Gz2Ep50wjw8IID0EqFeyXhPhEoMsaSkFRU8zO
 UFVsLP/I44SLk+y+IoX59PPLwYlzLd4Zqd5S30N7ehUwgPxPWyeYqidD9 A==;
X-CSE-ConnectionGUID: nzvmIduDRiSr/Nl2l0flZg==
X-CSE-MsgGUID: ygzHsBULRsiI8dt6mlG8sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81484683"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81484683"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:50:22 -0700
X-CSE-ConnectionGUID: OovV+dn9TpuhfshVtSVnmw==
X-CSE-MsgGUID: 8KDVIHR+QyuJnKZ1pmnFZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="244925186"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:50:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:50:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:50:21 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:50:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nP28P5GmQkqvYmsdZg6ianSCE5E3fa8P+0Ab0KdCFrzRBZRSi2zgmqodxpm0fs080Uh3gzoOmCtpdIOA6RGtnP7NgiAPjaCzK1lq4LSPW1vjMLJGKj1g0AOpVyX4wpEITtoGy6nOnZV9MRDJOYUBldIO6XXW/NB9h8M4Tg/IMjUOlKIISgAoUGTJVTAbugGVgQ66ZqANge5kQZ4E8LMfZgTSYXdDmQSkTS7JObGVZu3upEFljASRZWk7tB4zXY8rWROoyLmgnSCFUGjjqRxmJOk5PEKaqsE8OTwztY3lhSHi07VbrhnsxihQfbTI4NRQJrOs5CYKsILpy9LpLBeSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui88mdcT2Z8Te/GYnbPsBpTybo/mUMtiKq/QJJKNwgE=;
 b=U4WfDJrIBWBUVKtHlKDL69WV5l9ZqcHh+t1rky/VAmOXWEp232GFYQRNmF1l+MEgxM6nBHzxtuj3rm6BHX7kiWwXZgHFoYvXszs+OzwH+5ko+DM8eagr3OzE+IwX/036aK7pbPEiPGJnLBQCiENLk/r0OxirP99WLRljAeo6m1BBIn0teL6KtMGCcyapbuS2VvV9J0Jsfhj72Z1GEZzLnYGYng+jQ+wXu+WBfYt33AsxeHJLe1xyjwZahTo3/FUuV5+1EA7vz1+yZ+WOdduvCd8ra1lB/uWhdjlX0WPsPfN/oNA7a3I8HzAagJ+R9F2rl2cDpCj7Qb/zXGCaris72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 14:50:18 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:50:18 +0000
Message-ID: <9ad57494-eabb-43a2-9372-77e8d5b82108@intel.com>
Date: Fri, 5 Jun 2026 16:50:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] net/ice: fix bare L2TPv2 flow rule deletion
To: Shaiq Wani <shaiq.wani@intel.com>, <dev@dpdk.org>,
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
 <20260427023115.1225843-5-shaiq.wani@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260427023115.1225843-5-shaiq.wani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0056.eurprd06.prod.outlook.com
 (2603:10a6:10:120::30) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c550a2f-d1ee-4832-a8af-08dec311c2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6L4nh2xphCQkQlHM7c7PEnpGc307g+Sailw9KYeu+JtoXK3gnN3eKLKJExqQRj7+ffCWQH9Js58P9UYjvg4yemcfM3g8mV2dM5GdJ647L6g3NWlNap0u9jKF3oxPDJlgtfimOGSngTTrvivy3omXytyEJ1hjii5bV/4a94A59ANiW36ZBAvH+v0cUTHGhdwyYf2bylgI5AJrEvRbscwBWgqQDtICGZDSLz/+AnpRZnLmHNhR62xyhacRnOa75ymJiFEg3l+HxsKYm9vZk1B031JsmlfOJ3a737i4fpKukpnMUWYFUVrpEB58V90rrjH/Ap1v3KoZViGMMZXQG5+4+6WaRCO71aXDch3WAQazNPa1AJIdA9bRY4juddgi9/kQOGXftcOvY60KQ9QtPyu74zZxfRQhHA+YG8UBiEJPlGSUwVCqcDFx9BnLTiNwIhl91i6qhI0ctDhszLDmXlPswCiAAwfCva7CpfDQfEg74pZvaYj+1AmV9Xu4IbrXfZNQ2gi2PAo0SHBhfpmcJspuIWYIHSeWTSi19QjhBFuj9dui+mHZzYfoY0mbnDwLtY5vJIXoINfufmJpz+g89ABiD5wdUh/yh1zTVv/WZGvZWxWM29z8+d1igBXkEAROMJ4hNdlAsqMXdIzIaa97z691+Y8QE1ELFuLwjZRL+ilrSi9zTE/zjlZ2VpjKHwwXDJk8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JRUVZNT3ZPWTFLQytRNjBUTXVKZ2owcnVUdHgwVU9FUDArTkVuZ3dsMWNR?=
 =?utf-8?B?Y3lmTGxPcmFRUzhHRFBVR1hvNlFpTnZ1QmREWGdTYlpzdXFKalhhWnhweXFw?=
 =?utf-8?B?eDcrUTRKRDVpTEVvcGtWaldqSDFkZnBtVzI0aXI2c0FVekNyU3UxTTF5QTEw?=
 =?utf-8?B?NCtGQ0tLWGdWdUFJa2dBMzZCZHNGanZKVDZwK1NqQlVHdnF5RFpOc3RITVJt?=
 =?utf-8?B?SjFXLy8wSDVlQzdmS1RCKzdob3BYdHhadk1iTTJGTUJielloejVFb25Hcnhq?=
 =?utf-8?B?aENmL3lMQ3g2eTIweENhMXVkbDBDZUp1MHBPYTFkelJnQ0N4bEVXWjdhTUVo?=
 =?utf-8?B?YmNGMlFqNWpxUTFyeUhIcUx3VXJLb3p1cUhFSkRvYkw2aDZRa1I5RWN2Qy9r?=
 =?utf-8?B?ejdVVHR0aWYveFo1azJzR0k1OVk5Q2dtb2xpeEJmUTg3TWtBRllQRUNQa1p3?=
 =?utf-8?B?OW1jT0c2em43K3pBa3dxcGgrVGx2TWVXaDI5b05qNkF1Qndwd3pQVEJuRTI5?=
 =?utf-8?B?QTJNV2FldGNBcmpXK3d2TDlBWjBGT1hkNnZ2R1drYWEvb3pTRW5BYm8rdk8z?=
 =?utf-8?B?NFBKVmVtbVJCRmRYOEd6blYyQzNpeWk0R2ZYeHVKVzZLWFpWdVgyMVQyRmtM?=
 =?utf-8?B?bDY3NmdjQmx5eEVkYTh0bjVhOW1zOHJ1MGhuTVRlZS9jQlh6N0pySjRSaUJj?=
 =?utf-8?B?U1B1ZDl4VkIwdExqSWdSWW05MEJtTTgvSU5vRnJzZjlkS0l1RjFoS2JrWWND?=
 =?utf-8?B?MGRXcXcvT0lMSVRjYS9kQlV4ejhMeXo1RlIwZCsyc3kyUnBlN0QrVzZpanBp?=
 =?utf-8?B?QWR1OHRiZlRCQ0pxQWlqZlE1ajZmK1FjczRyMEZwbkxWSUxtYk14UDNPMmND?=
 =?utf-8?B?b2thNmZSS2QwdG85VWc5RUY5TjgrTVlpSmZMMm1FV3Y1N1pQaWJUUlAzSWdv?=
 =?utf-8?B?TXA1YWpMTnpmL29UZDhZWXBEbFNWNzBSeUZBTUFWZmJNUTlLSURFWFdQc3U1?=
 =?utf-8?B?aDNpSWQ0RjlROW9WcTBJOEY2b3RxNktXWE5jRzd2YTJxOUxiNFl3ZkI4MVVH?=
 =?utf-8?B?Z2Evemk2Q0F5SERxWVNRWlhKT2ZoU0R2MElTL2ltNndKUVVYaFRHZ3V1MWpF?=
 =?utf-8?B?QVRpOHJZOGhWdmd0TTJIekdPZTgvckhVUHR6NUU2MitTaHhwODJBbWYyK01Y?=
 =?utf-8?B?RGJQTnFzWG5kTVRmT3lyV2JlRFZEV0hKOW1nQjI2eVJYTkUwaGRFNm1mZWxQ?=
 =?utf-8?B?L05VYjRJeEx4T1pQOUY1WEpGU0JReEVQdEsrV2VsWlZEVmluNmFZRjJ0cGFu?=
 =?utf-8?B?K0lQcUcxMStScFZlMG0wdzY3TWJnZHh4TXJEU2oraXl1WFY0TFJmZ1FGdXZM?=
 =?utf-8?B?eXZoNDNGd2ZCRmo2N2RqaFc1TGJHZXVRTDZSRTk4YlZ1L3FJSmNLOHFZMGxq?=
 =?utf-8?B?ajJuVWR1UWtkUzVyTnc4K1dJSDNQWEVieTRKL29qOWwrSjVhajlWcXowRXND?=
 =?utf-8?B?ZkthbkNudUVicm1BR1FCUE9QTnpaaFBpR1N6WjBTVTBVZi9Tem5wVDBKS2k2?=
 =?utf-8?B?aGR0RFh0aDB4NUc1ZVFsNmoxL2JQaDZ2NVRJRHhFWXRNaTBabC9aVjJGQWpP?=
 =?utf-8?B?cmt1ZGFyYllCeEwzTVhUUGZROTU4aFhxaWVsSjNEUk13UE55WGZ4S2RkbmdU?=
 =?utf-8?B?Q0hhVFp2eVllZnJTWXl4b3V2ZnFvY2Q0bDEzQWhnOE5ZZmJmU3h4M2JZVWFU?=
 =?utf-8?B?eXVDM0NCK2F2dmVoZzJYdDQzVGlTSW1XL1VwM3EvQVZHUVBuVy9tS0Jqelhr?=
 =?utf-8?B?WkxvQzdSMS9Qc0VpVUg2YXJjUy9BeWtINTVjdDN6Q3M2R3VJbHhRd1pMV3cw?=
 =?utf-8?B?LytsdjJOZ0lvbVk2eW95dkpiTnZRbjlhdElQRjJXb3FVdDNKZVhqQVphUDBT?=
 =?utf-8?B?Q1FTSXZ0aW1IUml0K0MwcE9lMlhGdjRnS2Z3d0FrMXFFV1BJTXJTdjJpRTBk?=
 =?utf-8?B?NTJyZkpZL1Y1VEZRLzFSeUZGMjJaWGNjMEd4RDU0bFFZYlBRdENFUEp5OVdI?=
 =?utf-8?B?Q0ZDMGRGKzVKNy94ckhjTkNlV0hYU0cwTldyVURBVGpvNzIrdXRhWHRiaGYr?=
 =?utf-8?B?bzV0RjFhb0M0a2VURys2R1ZKK0YzRFZ6eUlJRVpLNEc1R2ozVFVNY0x3eXQw?=
 =?utf-8?B?RFV3N3piTmZmR1JYS25ncGVxQ2N0WmQ4ZnA5bXVVZ2ZzZGVwaHFLNXdVN0Rt?=
 =?utf-8?B?TkhCWS8ycmdWc2t3SW9aTjRNL1ZYR0xXMlBFVDUxMThFeXhabWdWMFBsUmdj?=
 =?utf-8?B?ZUp5T0xXNHB3Uys5aWRmSld5Sno4cjVyeTB1cXJkUC9TWUs2NVk2UWlqOTVp?=
 =?utf-8?Q?xIGlG5k+8ejyXzBI=3D?=
X-Exchange-RoutingPolicyChecked: gUQll2XwDFQswJedkf5oApgqlr/1X52HP/rTxJ0mSzW/+tKk8QSlkZFEofG1DPMc0iqHaptIW3z5rongZ+4o2VwN/8peyHcDd6+3oc8a8GcGMNAI+iPY5JFM+GLjiN9zkb74WDyskWzzpVeTt9i3Mb/EWc6PrYCREV1nbU5YZQvGo6vy5Ht4Gi1qeajAUQGAcBitzqSUXyVWIRa3CTbT5EC6b3XUDEsZ8fj3/k5MTwcNVFA3mz4OrQJTHPk4vs1exLovJ/W8TCMYiKqBw3+su1EISsw+xRI6r4CKJhtApnVoy3YRCY9riOQYoNLkhJd1QYZhRY3QKVgL4Hzglnmr9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c550a2f-d1ee-4832-a8af-08dec311c2e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:50:18.5841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mUDM3HgfzcGiSitqNONI6SCfmySz7FRopQ+3Qv/gA1BLUKlJ2HDzd2chPH3dVcOqAGd2p12GhgwN85lH4ndR6bZdhtDoeigHYBnTmHxSUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
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

On 4/27/2026 4:31 AM, Shaiq Wani wrote:
> Bare L2TPv2 flow rules (no inner PPP) fail on deletion because
> ice_fdir_is_tunnel_profile() forces a 2-segment profile with an empty
> inner segment the NIC cannot remove. Reset tunnel_type to NONE when
> no inner fields are present so a single-segment profile is used.
> 
> Also normalize L2TPv2 flags_version in the SW hash key to only the
> CTRL/LEN/VER bits, preventing delete lookup mismatches when S/O/P
> bits differ from the create path.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

Needs rebase on account of memcpy changes, but easy enough to apply 
manually.

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
