Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC3C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 09:47:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F8040DD3;
	Fri, 25 Sep 2026 11:47:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D125C40BA6;
 Fri, 25 Sep 2026 11:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790329648; x=1821865648;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7o9EQ0FueU9ac5hjXYBq30pxXPWyl9VRqK0T4kC0sIY=;
 b=CahDYWGwLW8XkZoH0CkieDEDWARPUQZs24zhAYx7QcZp3YfzeL3HEJZZ
 YVX1Zy/rnfC3WRFcYOlypdJjELhSqK0YHSp1VROA+lDogPPAt9dNDMSZ/
 BYEVMFF9x2BorDTY0ihAOg0QRkqvWA4utY7sGqr2QplHqVZECEVjR7YMA
 m29a+XtnhNUvQvWVdb3mXn5/4ZaiRXzuTy/PowP9ACOVyW8l1c7caxsdj
 SlNugu8L3bWqeJGyIfiimHm2SDcU5Q2Ip5cZasYZ8BK+ZsM7+ZG6NCSO4
 ViHQUyZrk98TugqiT1kPru16SFxZfdjL8b7bmIfDD/HI+6GD8fmhWE/Mg A==;
X-CSE-ConnectionGUID: c9S3zeXfQGqfOnKCxEsRoA==
X-CSE-MsgGUID: yqPw6SbpSoyh7dJ3IJK54g==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="112898701"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="112898701"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:47:27 -0700
X-CSE-ConnectionGUID: GiLhszwXQJa/5+3I5ZufvA==
X-CSE-MsgGUID: JugEH9mKRWqXGRaJdHtq0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="303800565"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:47:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:47:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 02:47:26 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.65)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 02:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPv3LfudNXFWLkZz8skI+DXPxxpsVfN7gjRK7lMUYPzmaNEAczP8S3jVp7bLVMcdff4HGwvBhSbu+YJCGu6l0mlKg2o9TNhc9AdE1BHpY8Lql5mo8wtMt6G2Bq7s6muu68PF7rNaf9eZZ/2jVIzBl8i/oI1B9oBasbbC1pBV+ZQRzFFVnWvt0yxfkTs/5OSDsD16Cg6DvHp3DDlRkYKD4tNhyEtdE4bJGja9hqybHtq5URfPSCLJk9AflwkMB41OBPBdOULsC+9HUvuWdn3Ai8HTje0DrN2D1KhOExnA+Nx0OQVJnUAT95hQa05ZWA20pwaCpVCI3tHTKt4PTl6eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKEWcnuTp6idOvSXQVbYmGS9rSdCevwIShJ2BAfc4Mo=;
 b=fLnHrAwbGh4OAfxPdKNWvs8mui3GlemZdVkvmANn9LsUB5uVo7IoEwNe/VNuj1NBh1VtX3hp+qvMHjMYcDfmXBilfM/9H7d6+wo4B59VV8wdg1Bp2K2Zov2yRDDUIVCTxp13tWwVHrtiTz222PzcfGooSiex8wVkaebtdyldC5U7BHPI7h95vUJjZh2Y02R810vE1ACkgM4QYrFwvE+W4DKGxj1jTBYBjMv31Z2wMxewAQJWCF4DdZkT8hPDN3s7oacPTVYAkUDXLgLtDMTMgwG4D64mIiJGMq1o5JTpUp07PB/QdrqFeRKPAZz/Qgt06XamoVj6xDKc3OkCQk7WLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:47:21 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 09:47:21 +0000
Message-ID: <a46db9e8-1513-4e19-b029-2d55e28d42b4@intel.com>
Date: Fri, 25 Sep 2026 11:47:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ixgbe: fix repeated Rx packet buffer shrink for FDIR
To: Zhang Tengfei <zhtfdev@gmail.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
References: <20260916135827.116145-1-zhtfdev@gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260916135827.116145-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM3PPF5217261E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8a94a4-6a23-4565-a4c4-08df1ae9fea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|10067099003|18092099006|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: oMAp42OHbOTMMGBBTnj2RQw3+dLJj7RI+l5Kwhu3rd05J3z7ebk6Bm3DXn4/IDcXVIBtBU+P83Rwp4TUYO+yFzbR5JV4wMxPAAJ/N1YVoaMvaWgS7sxixcxzhLNDL8FfD58jeOaJdgC61W5QvZS9T9ZyRiv9MMfHiUFn+u5VQtIsJPE91V7nQTI0TrIQp3qi3TbyK3NnFsqzeNcncrdGVTQ0LDlkRKxM5iu2OV20cShyOEgA/QHkCkCbrqG2RCgnOWRlgpxGMWJds+sG6wPrdsulw4XaYliR/EVv0e9DMaELlIwtM6cpY4B3gtHyU7RQgitgVHzE2P5c8lm6xKLjH35oV0y3v2CPkZuHWbjVP7YnIGn/B2iGGpzPYVt/vkM+kSy3lTYbx1WzxAgOnw5if6p+9AwwFl9FITEFa7lNgaD/GClVB2I6nK3pYEcJtZgWgkJCQdW/ZooGODk3SHauTJHR0035hXlX3cM2ZgEwlrfTW1xF6/sSGBU9x1TpZTjCYobOD+vq8516/wuClQCTNUAaklvLD+13aXpZtcCzIN+OkNS/57QcBvbDP6YajDtLoKJAOlU1FnpwffYvLNPcbBQsv5gLDlD264WjxcK02OGVmmfYKew9NdyCsbiv1P7xwBt3jGzVutyumMoNpe+p/6O4Ex7X3929byH6g37FFdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(18092099006)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZHTGV4SmRZLzMyYThPQ2FLUW9PRWEwbmpxamczMUtOMVpLRElXaXpYTzBM?=
 =?utf-8?B?TkJVRjVGdUJRM2NDUEpJNk4wM0ExRjlPN2VwQnc4QUJET0NuUVZoVUR3NEd1?=
 =?utf-8?B?b0ZXMUJ3aWdLb1dyOXRtdGZDbmVLZFdnWk8veW1zK1g4V1QvYU1tWUs1Qkw4?=
 =?utf-8?B?TjlWZFRyZVZUWTRtd1lEeGtPaHZGaU5aT1FmSTZ5bVZQY01BdFJ3aWRSd3p5?=
 =?utf-8?B?V1RSdGpSOVB5bVhLQm1jZi8zU0FiZGxYMFhZVHFRVVlURjhkUUw2UXVwQnN4?=
 =?utf-8?B?cUVhV1NpbHEwdEo1ZlpoaGVYOTN1MXM2MURiMkhXZ1RHdTgxS1l6SDlhRWV5?=
 =?utf-8?B?em9pQXBxMmVXYkZxVjdBUzJhVkNMcXlyYytGbS9aZHk5Yld1SGFadHdvT1E4?=
 =?utf-8?B?V2R0OVRBeUVNTTdYNnN2WGd6SkhKOHREMTdDcldncjJ5cGptb2drSkc2NllE?=
 =?utf-8?B?RVEyV29kZVFUKzQwNS9udWNmc2dOU1VFZ1BDOW9IUUJ1aXVRZjBnWWNsSGdI?=
 =?utf-8?B?UGtwc3ZaSXdkSkxSZUN1RUs5ODREOXp6dlBsODJvaEpRM3JuNDdiYnZlK0di?=
 =?utf-8?B?Wm1QTzdVaWxlSHRxWjE1ZVRIcnQ2QWJINCtWN0R1OTJJbmJILzI2SXhLZk05?=
 =?utf-8?B?MkdvUnpXOEhpMUllYXA5RVV1VFdrR0JiMTRxc29na0ZzWkJ3YW1ORVdrNXlp?=
 =?utf-8?B?QTFUSmNYOVRnL1Q5TjhHQkRBTG9uL25qNjZrZVRvQkFpM1FkejNWZS9tOXNo?=
 =?utf-8?B?WG9ldDZDTjhMekhZR3p5SjVCdi84UkZ2RG1LVWRiMVNFYnZKbFlIOFdhT0dX?=
 =?utf-8?B?ZkRRL3VmdzAyNXdxYXJLbGJORzI2YnpwN25PbWNXQVphaDV0TjhFZnV4KzJR?=
 =?utf-8?B?OGJEKzBJaVB4cElTaWp5aWEzSUNvRWZtZHJRS1I5bURyaWNXUldFZ2JydGlG?=
 =?utf-8?B?ejF1T3Nid0tHUnFuTGcveGVISFVFNkZKenBmQlFGQVFQRzMzdVY3UmVpYnBG?=
 =?utf-8?B?SGRNcnJLbzBjQ1F1UEZ1QUpIZjNZeGE1KzNpc0RuRlpjd0UxYTBFNTJvaEta?=
 =?utf-8?B?eHJ3azQ0cEpvQ0dCS3R4N0xsc2NBNTV2ZE9NeGU1ektSQ2s0ZVlBMXdoL3BU?=
 =?utf-8?B?eTVxM3RzbThEa2picWhIV1VENDUwOGZRR2Iwb0diVmUxWkx0SC9ZdkgyWW9w?=
 =?utf-8?B?ZG53SDAxN0RpZU9KV2hCN0NFUzFUd3p3aFdZdm92UkZmSUJqcjlBdVRiOUtk?=
 =?utf-8?B?T3AvT3FpR0FzS1ZpdmtQZmw4NGZlUThNbDlTYm5KcHM1YlBqdWUxSGxBSnBJ?=
 =?utf-8?B?bE80bGxmT3VHcVdNdFIyT2p1VEJ4YjYrUmd0RmJqQ3NSS1gyQmpMakRKbERv?=
 =?utf-8?B?a3NNZ0V0UExETEFGNkFWOVB2MXEwc05FN3ZEdVBqdCs1TDBBTjVLa2VlK2pw?=
 =?utf-8?B?NGxiRGNZN3BtUG5KVnJIV0xGQ2p6LzZIMkYrRUdOQXIyZktQazZYRjdHNGJh?=
 =?utf-8?B?aUdUWHFRY2tZQzdvVGpxcVNnU2k2Wlp1cHdEblhCK00zV1ArQlpLakR3RHJ0?=
 =?utf-8?B?Q1VRNUhkWDFibWVJamRpVEx4MUZkZXd1aU5SeWp6TXNKbUtnaVNURlhBQ0Q3?=
 =?utf-8?B?ZGJqRFRZYmNsUGdYVWFqU3NieXBFWm94Sy9MMjE5N1owYTU5SGlheXdIbDdt?=
 =?utf-8?B?Q2dYeHNlK2lYQ0dPQnBBTm52S015OThkcloxK1c3dXFSeDMrUlZwVjFKMG05?=
 =?utf-8?B?bDB3Sm5jYkdJb09yODloRjlKRENyUUFvcHhpQXhDTlhUNnpKbG9KWWxzaWp2?=
 =?utf-8?B?QWQrNmE2VGg4cnMwdy9aNWY2bjU3Kzk0NVlWMUljWFl5dFRPdjZPQXZ6VXFw?=
 =?utf-8?B?NE43aDYzc3Fhemt1dXRUNWpDOEJkNnZVRGVZTzZuanQycHBHOXRtRXhCZDVD?=
 =?utf-8?B?ZEkyYXo2WlFOK1pMKzBLT0dDQVRRZTdSODVDTTBRanR1amp4Sk1LUW9SbW16?=
 =?utf-8?B?ai9NYVdRTnJxTGVLNnpkL2tMeDBvZmxiMi8zd2tIVG9BMFpWanhoZXJnMVhO?=
 =?utf-8?B?ekxFZStsNUVJb3ErcWJ0VmV2U3RCeFhtTDN5YXV5RjRsRUpLVnQzTGhaU1o3?=
 =?utf-8?B?b1JEdVBMM1B2WEgvcERiNnhGMjZ1MU9icHQ1WTZhQVoyUWs5dWIvTW90cGlJ?=
 =?utf-8?B?VDYwMlZ6SXNjMU5TRjBJVGlaMW5KWVlZRndmU2hnWDkzNXJNRy90UElaWTdL?=
 =?utf-8?B?eHpOYXBVTGM1bEt4R2RkL3E2ZXdpVnhnNkZFQmw2OFZ6NHJSYXljMDBhbzhX?=
 =?utf-8?B?aFhNZlNDY1Fjazl3UzVhbHBKOTZkekdGcmx0OHllQUxtdExlRW1LY0ZWczZZ?=
 =?utf-8?Q?15eEoFvnZgz47HsA=3D?=
X-Exchange-RoutingPolicyChecked: 0JAfIJ9bx78nneTvBYPNTkN88EkWqZtEExf5ZH3geqxISXYKyjJ0HwcbB9MqLrIMJCNOuZ+q0El39gV7lqFALCH/t5nz77BJexbL/8/g9g4cSnF4yulRr5YtD4k3G/3qf7Ii2a9BHYh6UsU9a4OWpZSDEuyX5xBs0dNipP1QQOJUWGvgHBrKvCp/qwoi0F2NZ527evesM2qSpdNlXfJVY98PONmdTImzHFA3nZXUFY5yYkcVYaWBVNbGTsDvw55EFc/OJnI6+GKYe7PeqxwAhzErWbZyBjqez7pM27zUtBGbM9e7khgpAZXDYPurHl/e667iyj8nZM8iSz4MzCOW7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8a94a4-6a23-4565-a4c4-08df1ae9fea7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:47:21.3577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/M7pvnHB4qiGagTFG/zFNSc8u+Nidrwq1wabwCO7U87MTFXi8Cnu5z2K2gkKGN6AHHS0t7B8yFQT3015sy6JNrMAupEzjkDRiO6/h2Eqws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
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

On 9/16/2026 3:58 PM, Zhang Tengfei wrote:
> Enabling Flow Director reduces RXPBSIZE to reserve SRAM for the
> filter table. Clearing the last FDIR rule set the mode back to
> none without restoring that buffer, so the next flow create ran
> configure again and subtracted the same amount a second time.
> 
> Keep the FDIR mode after rules are removed, and subtract RXPBSIZE
> only once until the next hardware reset.
> 
> Fixes: 301abd26b118 ("net/ixgbe: reset flow state on clear paths")
> Cc: stable@dpdk.org
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

A general comment: instead of reducing/bringing things back and storing 
a flag noting whether we did, I would rather do the following:

0) store default rx pb size at init
1) on enabling FDIR, recalculate using that value minus FDIR table size
2) on disabling FDIR[*], restore the default
3) similarly, on enable/disable VMDq, recalculate and/or reset

[*] there is no "disable FDIR" call, only fdir flush which just flushes 
the FDIR tables but does not actually disable FDIR. arguably, we should 
convert it to "disable FDIR" by flushing FDIR *and* writing 0 to 
FDIRCTRL *and* restoring rx pb size to defaults. naturally, after 
running fdir disable function, FDIR will need to be reconfigured for 
next FDIR flow and get rx pb size recalculated again.

So, a bit of a refactor, but I think that would make way more sense.

-- 
Thanks,
Anatoly
