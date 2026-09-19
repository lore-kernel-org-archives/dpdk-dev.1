Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328C5C982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:10:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E57E40A6F;
	Sat, 19 Sep 2026 18:10:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 9E8EB40A6E
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834254; x=1821370254;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=R4woSRa7s1NrTqvJxw4s48qehy/QoMzt9XOu3pl29Ac=;
 b=NjxhjgsKWNSvdiCQMpBlWdlAHKnJn3fKoCCBvi/mz/0Pi/0PC63Bavgb
 hnjsYGi9BL4aqUnA+C8WQoVFBf53aSOlh/ouOPETg+BTSzOiBLGvw2Z+9
 WUYWOzbmcDFoUBvvNA+fNHFDzT0aMdYaSy5nCIMXYYrzeCmiOm2hi94yx
 P+QJw00Hcz+UAE5hdHFzIvRfGCZ2tbMYFRpR+ZAnb3qcqeduvlFYcq7/h
 dq788TgelOU6CUhYE+5BtbMmutDSFhS8PLeCMod8hDrxAOYteb4y741TE
 DadS2th0z3IAt0F5D7TrXbfl2l24y0NKoJTLckTr5bUgwm4UvZQbihHwT w==;
X-CSE-ConnectionGUID: S+7p8u0kS4aTxBsL047fFA==
X-CSE-MsgGUID: WckD2ECnRwm9oZBXdB/9KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="871750"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="871750"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:53 -0700
X-CSE-ConnectionGUID: BFfBzlA7TRas/WA+3v2Jqw==
X-CSE-MsgGUID: bs9HLEaqS1a3i/xuE7HiKQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:10:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:10:52 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:10:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlSxE8OKPiys4z+t+To7qiqJK88l9quywB2N6Pf0aPFo8++AP5XfZtn9e3gpiyqane94pv5ZJYIIz+Tqep1U+GRtsnBMIgxIajOQrGobUBNLJJtjs+W21debMfdqvt5r/36NpGUzaz8dyyjL3e1awzmAT+eZCQGa052hQ+ptkvgP1eqzzkzMY2B8T8E9vACoXXai0g56/kSyQX8y7F/ee/lfT8UDxIHNA8vJJuGS+WgMARLhpoaOVAYdxKO/qpXRwwwG37qlwkn5lfgwsbkpLycM6+umW/ZGrfdBlILxWlC9gUqaPLLFVaAwBW5OF9q5NKscG2hE292uUEGpSKMxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSyNaugiX/fSTQaX8fn6lS0UhyuO9yKhLbfgLPzCzTM=;
 b=LmNLIK5oOOoaLoX+arpIqWfwbyMEdPlzc59gqX63agFE/IVgRsgNBrRwcs8wvEACFSSwDO+kVfkOCk8TX3kaUuNxGNR+QLx4Ar8uToLyZo303k6QEzJArSN6M8lV3pkxuhDe1R6aj9XWQqvlbAq8XmEWSr6mvLsocVpJC41u6PeShl/HF0xlYrOKZm2tDiF4Fy1P74XTFCWUNckVweNt4eogVqZiJ+/MpmU0ADpf9ebrQrvPlUraCuCSRZXZPPNxv/EFxpGhKnHhP1/LxtyLoMOv98LTdmFJRbYeqrxWLkra3zgQT+2RSgwRiNdy9wG56J7Lyp0QOCOsWUc+4Gtbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:10:50 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:10:50 +0000
Message-ID: <0eddf54c-bf1d-42f3-9915-efea15c0917b@intel.com>
Date: Sat, 19 Sep 2026 17:10:47 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 07/19] net/ixgbe: reimplement L2 tunnel parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <d900162f8a32939c4b8c2a3a178abfd35b0851dd.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <d900162f8a32939c4b8c2a3a178abfd35b0851dd.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::25) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3018c4-39d4-4a38-b400-08df16689280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nKHsW81yrDAbGElM7PaZsF12AMatuF/BDiMyi50RLAjpwFLicCzhYElcI/5Teb19z6SJnWwJ9MjagWFikKOS5sYJ7HfQDdmjckn3umFA1buoOUEi2mBtAiZcfA4lN2XuQWSJmHpfpJxnMTWnksoOUa+fTcck1RhrcqS4ygZrRrTsM3ghD0B9+LiAmRb5z4U7MF48KFEcOmF6wG6z4e9LFOjJYg2AX/ZYASvlsc5CUJVCjKVDAZDOrmotKpdkUxKNhsr8N9Txf+P4eXAf+pEuNAT/vrkRX5x4uZFzWyEPUEC45X/EOCCOAFuqbwJISDf/a1ptRpO8A+q/TF53vrqEeP3eeTG/Br4CmacLTGKkCEaS8BsSy7+ACYRwB4SSpxTzgfuLikxJGPXpR/Jn0shSgAjxLn7/rgIuQixNypzH0YqywbphiVkNJtjrPxv+Z8NQlSrIfaVVvkLRox/5le/R706CO4oq+I8BdNo2bYJyPP2c5donnUb48iQa6M19nelKNvy0JZIqD2+GMcVw0FLb5F/gm6PTTIUjfwQuUPAbKHiFLmeuuxth+WDe3f9vgyfCGtNmvCjJrE5udTc+V6YM9oOMHLJoFvBO6dOTuAiUthjmEJ5NbkOcoekUDL/Rp1F09BwNa45e43Hj8M5+VqdYJhIUa2PM5jLj12cbXkFqX0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pTNmJ6TDRuY2JhVFhmcHQ0VXhQcTE2M3ZGZkUwV0t1NFk3akUycWQxY0w0?=
 =?utf-8?B?UG5KQkIzWFI2cXdrRWZQajRrYjNKNkd6SlpVTlQwT1pQbHdZQUNoenJ2bTlV?=
 =?utf-8?B?UmFZV3k2OUJ5VmkzcnlXY05XVFowazNLRk83dzNDdTJUek9aL2xJaFNIbElO?=
 =?utf-8?B?NS9rcjR5eGgwQTZDZFd3K0I5YkFXV1k5Z2t5SkczTytMcFZ2N1IrYWY0R0Zy?=
 =?utf-8?B?Y1k5TnlkcmRidzZzM1E3QTMwOTdjeTU2TDRDeFBwTW5xZFVxd1A0VmlYT09h?=
 =?utf-8?B?Wm1vclZlUmpTZnRYbVl6WEQvdU1wR1pWelpaT3F6a2JqOTU2dkxnRlg5UGxJ?=
 =?utf-8?B?VytERno1dVIvME1oZEtBbkdNQUtjaVZaYVVWQVo5bG0yb2Fza1lreXRwS0Zu?=
 =?utf-8?B?U3YraXRjQ1VJY1FUcUZjOG5ld1JQM0tlbTRpMDRFdjFZS29nbzlVeE54Y1NM?=
 =?utf-8?B?ZzcxVGZjV3gxZk1JdXM4NkhjTEd6cVhxNng0ejh5T3FkVGtkNWVueHQ5Ykx5?=
 =?utf-8?B?WFJQWThTaXpOd0VSRWQ3T0xxektMNEUwVmxxUWlmNzhoelRKcjFhQWN5MjFm?=
 =?utf-8?B?YVdvcFkyNkwvSXFtL3F0UTZVMG9ldmM0U2NyZ0YvWkpXanBwSzVYZGpNOXRs?=
 =?utf-8?B?QWlGQzFJdUM2OUJCZDkzY3d4QS9pZ3BVQUUveXdNd2xxeUpJM2s2cXdVRkpj?=
 =?utf-8?B?QmVsd0xISEhvbTdJZ2U3ZFg2eWhZWGhjeHVrZUUxeDl6dHVoWWNKbmlKNWdV?=
 =?utf-8?B?REVQYi9OTDFPbTAvQ0k4SEhHUUhHVXN0OVUvRTJXbDdyOERYU0YvbUpmYWM4?=
 =?utf-8?B?ZEVETEJyS3dkTjNSTzJHMlVaY0g4SmxFbHVTUlBEU1hpcXdiNmZxMFdIdDFw?=
 =?utf-8?B?R0J5UzVCWGhMQVliaUdGWS9mM1gzUkttZFNGYXB2WUxMWDd5VlRrVXRoM3U4?=
 =?utf-8?B?Zk9KQnJwU0tqVmtRS21IcG1NZFdlZFE2Sm1YOHRFWTNOblh0YzMrR01zMFdX?=
 =?utf-8?B?emlkT09ka3NkUmtWVnh5QXBKNXBDRHd5UGE4dTlLL1RyRjUwc1BWUWJ6dDZi?=
 =?utf-8?B?OGQxU1JxNEhLdzV6TDk5UXBVdEFaWkRiL1QxQUVJVFUvVWxVZW4yaW81QllY?=
 =?utf-8?B?R1B0WUxnWGx5S0x0L1NpTTU5TWdGN05IYng3THN5OHpwVGIwTlRtY1lmK1ZU?=
 =?utf-8?B?MVN5MlowOXZ1TmpqN2k5VDVvbklYKzFDQ2hZZ0x3MFRZamtyNUkvNndhTkxV?=
 =?utf-8?B?RTd1eUZGQzFaOU9OME1pZDZ0TkRMN29WWlNjL3hTelBPdzh6YUdwSG9EMFVh?=
 =?utf-8?B?aUwrYkJtOTcvc2hJaENLUCsrTy9LcElISzI1WXlrMG1KUWJnb1VSY0ErWTJo?=
 =?utf-8?B?NHgwSlFkTjRYcG8zSUhma2J5amhyUUlEeDZwcmtCN2VsY0xQb1JyaHJWZU5h?=
 =?utf-8?B?ZmZCRDUzMm90NStsRXdGb0VMMzlGTW9VMU03SzhPcGVCc2FnRGNqWitRcndN?=
 =?utf-8?B?MG4yM0M5VjVFWk5rcnM2VGVlNyt5VUVmZFZ0bkV6aEFwNks1SWpvMnB0bC9G?=
 =?utf-8?B?MVBoL0RQVkQ5RUdZcFVJTzF2eVh1UFZidVk1QTJWNlRsdGhTcjlodjZ1amE1?=
 =?utf-8?B?MUlTaTNVbVIzM0xLOFNMeVd3TzlLNWZ4YWswQXJTQUJxckZSM01kWldUWDFQ?=
 =?utf-8?B?Mk1tcUFaQjBhQWhEM0QzT3pzRmszZUhpd3FxQ3dqWS9HY1RyWnhvdmlDcDdW?=
 =?utf-8?B?R0E3WWZ0Q0VwQVRjMDI2RytzbVJrSGN6ZThlMFUxV0d4SDc0a2ZXSytnemRD?=
 =?utf-8?B?azVsdGpnZmpRMkpzVHN0SE85NE10TWJXcWVMR2ZETjBPRzRJakQwTWQrTE1V?=
 =?utf-8?B?VnVtOTU0akRWTjhBUnYvcDQ2c3RDaXFObHlKb3BkS3NySHV3QWsvaXZUN3Fu?=
 =?utf-8?B?Y0tEWUJiNVR3UlFQVFJ6MnJtWTYwUG9zYnVKNFY4cXFHL0Y5UHVsUVFMWjlD?=
 =?utf-8?B?dGhvS0lPQTA0OVI5Yy9XcSs3N1cwanRhZnd0dFNBWTB2Uy9ZTm5lNVJSVitw?=
 =?utf-8?B?TkpqS3E0Y1FLcHVrWFg1VnRZNUgxZ095aVZwaVYxakozUUYwblp2cVlEbG9o?=
 =?utf-8?B?U3pmYTZLd2hUbDgyQVY3WkEzNFIzbDFHci9PakJRdElNRmsxK3RLK20zd3hW?=
 =?utf-8?B?RWNRSlBaVW1vUGxFNmlENU9jRXBFbWEvaWFqRjJ6dTdNZW95M3dpVjF2QWox?=
 =?utf-8?B?TENZREI5OWhOTE1EUWw0OVdtUW1ZdEswYmVWODMrcFpnSURoZWpka1lacUdw?=
 =?utf-8?B?TDVTekg3NVYzRTAySGxwSDdaRGFIUHpabk1xR0lLS2I5ZkhrNVdodWdCNzlR?=
 =?utf-8?Q?7AMLI4UUf5FEAKJM=3D?=
X-Exchange-RoutingPolicyChecked: KDZ7W7RIWbjCice4htIjGjfAKR5s4ejEqq7oVGjQzmzLyJz2NQv0cMNdEFN7Z6COssj9MDr2dBkRqg2PLQhy92pJN0tB2uqPiROfDQ5cu2Y3bNaqlU9l5smpu1KIxh5qeeMA6TcFyeu3KK3BEj8awWkuUiw9Si9wxHnoTewsz+hbaeO72HY9lqW3Jn6Vor3DWwBF3QKs/OhdDx0mPRM47yELpxzfsX0RrdC+1L4ktd3hkJztWyKGo8xq0/ybHzwaNfvNAEuFUkKPlzHEeKfzGsWeXijdJQboWC7KAJ70r1ELU1YdBfbVkpJj63Q38KdZT9pMjzRPL8V9VYpiX0jL2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3018c4-39d4-4a38-b400-08df16689280
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:10:50.1864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCi1yE1E21Jj9x6V1EEo7TUGC23UkEVthyfhDiE4aY3Nn2lp8o5x97rwWzUHBixDc5nLoLwnRmYfdZeDOoM424ajvIvo9zYaMib1eJ1eKRc=
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

one nit below, apart from it,
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for L2 tunnel.
>
> There are two L2-tag-related features in the driver: the global per-port
> one, and the one that can direct traffic to specific queues (the one the
> engine targets). The former is left completely untouched, while the latter
> one is migrated to use engine infrastructure and use internal tracking.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 248 +---------------
>   drivers/net/intel/ixgbe/ixgbe_ethdev.h     |  26 +-
>   drivers/net/intel/ixgbe/ixgbe_flow.c       | 206 +------------
>   drivers/net/intel/ixgbe/ixgbe_flow.h       |   1 +
>   drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c | 317 +++++++++++++++++++++
>   drivers/net/intel/ixgbe/meson.build        |   1 +
>   6 files changed, 326 insertions(+), 473 deletions(-)
>   create mode 100644 drivers/net/intel/ixgbe/ixgbe_flow_l2tun.c
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 00ba6f32fa9..3923a00c284 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -149,7 +149,6 @@ static int eth_ixgbe_dev_uninit(struct rte_eth_dev *eth_dev);
>   static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
>   static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
>   static int ixgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev);
> -static int ixgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev);
>   static int ixgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev);
>   static int ixgbe_dev_configure(struct rte_eth_dev *dev);
>   static int ixgbe_dev_start(struct rte_eth_dev *dev);
> @@ -1392,7 +1391,6 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
>   	return 0;
>   
>   err_flow_engine_conf_init:
> -	ixgbe_l2_tn_filter_uninit(eth_dev);
remove "err_flow_engine_conf_init:" label too?
>   err_l2_tn_filter_init:
>   	ixgbe_fdir_filter_uninit(eth_dev);
>   err_fdir_filter_init:
> @@ -1462,25 +1460,6 @@ static int ixgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
>   	return 0;
>   }
>   
<snip>

-- 
Regards,
Vladimir

