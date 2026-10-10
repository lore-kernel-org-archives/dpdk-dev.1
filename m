Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04999CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:39:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43547402DC;
	Sat, 10 Oct 2026 20:39:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 429144026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:39:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657572; x=1823193572;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=qqEcX3jpDxVsvJ4epG6+Udu5FbgcDtN543d/L5xB7ig=;
 b=ZHlb11bvC4uPWZ3JxTmtWuqqyT2t2jNCqyFtCvtLa+IeyaTw4ybH9Iec
 Jq2+AYJ/BYb9cerHyfO2L485TvFBzBkhJUT7Eott12k9A1iZNd/kQF/Um
 cvugwn/Opi+wk/scaE6UWNqG9p4criYCR1MqZS0JiWGILot9JS5Q8gtI/
 jWgHmS/ElnlAualKPKBfP3myF2V52edB0jcPqaKbTfOjHuYz/lAudrt8Z
 A09OBTNH2LxYziwA24LWdCHlwWUxm1Zhv4jWAiGGDgZVjiIcX5sWYx4qI
 Os0uOOTFYvQaEfOrWEp9pl6JNzdxa579mdsyNeXpqWpAAdi7YlOsv6qzm g==;
X-CSE-ConnectionGUID: aNoa4DloT5Kiv8wawZaDBQ==
X-CSE-MsgGUID: 6cBlfnjmSOmel81uis3Gfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="435027"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="435027"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:39:32 -0700
X-CSE-ConnectionGUID: sO7kjhxUQoabOuTunW1s+A==
X-CSE-MsgGUID: NDpFftGdRIGaUFEs6h3oDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="877873"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:39:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:39:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:39:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4Whhn4Ca5D51crB0qhxVBhKQomNcHpH3y5pbPx4YjlBy35gEANjL5TDAsnZUZE/FA83R/mk+UqzjBZxKCAPQ3BpeCkQE13Wsj4WW+u6TjLxD/WoYpcLGXKvwKFgwy2EvI0kHvNpizTGHPpBZfX6eSydJOP70VAl3qQN3AWbT5VaxF2/Ar6l9+ZeV3jGnXK8jCP5B8lVdb25pOSSBzQI17trPERgaVnoFhgCB2+hCjVNikJ1pGK1usIbfCZcV2g+LjWQA0S2x6BLXdqKCOe5Dhw1BoTsV8OmJKIcJqULQuLjlJBgp2bmDE76VMWeteUtmaZtIrwWGsalVuoRnnC8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcZyrsoZOR1tGBzc1I5M0QBuMKsSXJZOMgnEjhR/3jo=;
 b=ZmZah5YphoJUY1954KE/OXrcSg4hOxyR1qBPjUqzDUCbnv49VrIzqnwQ0k49nliEu/etNxrcZdjzkoVsWuA+ys0X5ifmujZ20eL8FO4myMO7Yc8W7JSnnu0Cb3/D9g7PE47c7PelNNFaMjaJCiB8OWy8c0iCrBetTeevQ6BFjYrV+Je27s7vIEO2zBysNq0gvO7P4bRc19XptHc+VO+yWXhJ+FzvSaSVQXupxIMh33pUKpqe1hX+jqbhfgDRigImvffVj+6eusSekQnCKD0ze0Tf7pHmT6d//UJCELbp+vbotydUaUHFri8Pqw68zZhY4DOvC6Ljzf3rEaY4yGXP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:39:29 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:39:29 +0000
Message-ID: <47bf7bf2-6333-4971-b169-a7b0d13ee499@intel.com>
Date: Sat, 10 Oct 2026 19:39:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/25] net/ixgbe: reimplement hash parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <aa09980eb11587bb2f940f310d60b23d8cc5a14f.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <aa09980eb11587bb2f940f310d60b23d8cc5a14f.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::18) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6832b1-63aa-4eed-32b4-08df26fdd153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y7Sm9N17TReiRZHa1jHonpGifKLF09vh0QWP+wNfZreVLbZj09IlggMcF35H8iwkRNdBKDkPQsYMTcnY6/aywx9gwR5u64v21dDkH7tueKztQXXJFb7t0aZwVdfAcM17ylm7FmicBFkgqirXFnikQ7QvOFshuxZBm1LDW9LKheRzYvtSWLVVMqoUKFrIQN5paBcjJYG6Lx1NchHmNYI/2aOEX/0e6h5zlX9RRr0s0Ddbo0jD0h3aXXqZeVP3VM2WG8Q5oVSaVznBPGXbhbAYReuQv4nyIZfPf8/iJujmrai/r8JG5mERewfShWOzPU4jF034hVQRX2CLwJJ4LREvnue55ExqP+UGeQ532pG90+CAxSC13OYcJfbhT4I5bW5p0ZFsJuX2RK5E5IcCAnd+ALydKpq6qqYDhah9ODqevHEsGBSRkgn82JrCVSld3/+FrxQwLhxdMiz4zwYTE3VREhxyj83suO6GUZmgciaFdqkM4eUngzDOOfZMCSjDxb6U/V766zu8J+rOuO9AghxVuMzGPBZ+ALPge+GNhKHEvzEoU9l5Mn107GNHcpRbCP/qbe+XBx7ScDgcN1YnwcpyzdI+A8R0DXzLlWVt+yYE9ikH/5S4fHjVG30VlbSWZQgO7NmwXPpXY4Gxn+QpEQidh4s6vNwV4ktFXntFne+yMUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Y0dWw0UXFWMm5VR0JOYmIyQzZqWDZUTGtrd0hwRWVLTjVTeWNyMDNDTnRW?=
 =?utf-8?B?SDlYUmdjeUF2WG82TkdDWENnL3pySVU2NTJTZWY3cWh2d2NCUndJM1RIWkVF?=
 =?utf-8?B?aE9OYlp5Y3YrK29UWUpkT1l6MGVrN1BEaEhyRnNiSzRxV3ltRGxQQ3JHNklG?=
 =?utf-8?B?M0lqR3F3ZXl1SWJBWHdINlg4NXBXTHp3dUFDV3E4UHdEUFJMajBheUcxMnBV?=
 =?utf-8?B?M2FwaXVCTVNrUVlKVDZvK3ZGSjd2UEJkWCs0NlFHcFdPeW5BamNZck1XOGx4?=
 =?utf-8?B?RGRWVnU1cW1NWGNNb29MTERtUHIzUis0V0x6Tk5OcjFyUVFMaTJkRUZFNGMz?=
 =?utf-8?B?cUl4US9vdlpkc25tQjg3RHgvcElxSUZFLzlxeTUvTkdIcmRzejBxZ0dJUHcw?=
 =?utf-8?B?TjJpM2RhYVoySDR1WjROOS9lS0UwYjdNTW1YTVdzTllYZjYyTUtSYnBZN3dN?=
 =?utf-8?B?L0hTbEp1dFdJQ0V0UCtRMWFJVjJacnprc3NpZWtRbFBDZy9IQVpxUjJvKzBL?=
 =?utf-8?B?VS9uRklvOGtYWGNxc1lBdktmVVBTWlFoRkhrMk9nblc2dmhWdmJKNFY2YXZ6?=
 =?utf-8?B?Rmg1UUVvb2p6N3V3MXVIR2IwT1FoQ1B0K1B0SGFvYy9Odzd6MXV6anQzMmdC?=
 =?utf-8?B?K3MrcHprYm1ZcTZQOGExdG84TDBLZ2JIa284bVhZVm1JcmdnQ3FCL0pQdFA3?=
 =?utf-8?B?dmhTRmZKNnIzSzV6QlIydEZRcFRGd0tveS92Yjc5MURBOGRsTmlsK1VzWVFm?=
 =?utf-8?B?UzJIYjM0NDVEQlZlZ1ZKcStkSkYvN2hVVk1na1RVRVFiQjJvSERLK1orc1ZE?=
 =?utf-8?B?NXEvamF1cHNJT2JidTNUd0xNZGVXd2xyL2tUSmNyZGxhL1FsQ3dqZUlPMEph?=
 =?utf-8?B?bGJqWVVrK1VvMjJ3dlJBbEtoMXlHNXRpT1Z1U0t4dFRIYkJqM0RMdFRzOVVy?=
 =?utf-8?B?VVo1NlU5SnJ6VjZSZXBmV3JCVHdrZjZxSmRUN0NTRVAraVdKU2l5eCtEREhh?=
 =?utf-8?B?RnNYMUthbzliWEtKcUNvVGZqUFFOSWRYeVdoWThCTE5BQXJYT2VyRjJTRHhx?=
 =?utf-8?B?U005VUFhcG5mNDRYL0lHMTE4eGVBZ3NFN0MyM1V1SGdaOHh4N0E2UUQ3dzAw?=
 =?utf-8?B?TjBnVnlFNVdHbmVzOFZGYnBNZ3c1ODQ0RC9wTStaa0JqNnAxQ2F3OWhEY2hD?=
 =?utf-8?B?TlE3TEttYjhac2FkZThXU3BYaTVHM2ZENjUyU1BNWlQzSnpIS0ZOMCtSS3g2?=
 =?utf-8?B?c090cDJDQUtQeDFCR3QxT2RVWEhtMFQwTWlIMmVOY3ZHMU50NXYzQzJHQjlJ?=
 =?utf-8?B?SjlVdkF1bXNwbTdCY2p1UW1sMnU5MkxkVHR3WU1kNXhEZ1o2SG9yS1JuT3ph?=
 =?utf-8?B?YXM3Yzl4TEpTL0NpSC8rakdQeU41SHQ2SStWSmZFQUY0ZlYvT0JhaHIzNDU3?=
 =?utf-8?B?ZzZiRUVHQkNzZEtxWTZaOGRoQW10Ym1qY0VzSDJzcDByWUpxN0tHSHMwMGhQ?=
 =?utf-8?B?QXZ3azVGSmRSWDlmalV5V1NKc3hEalpWUmhyVFRiTnE3MDNzU2QyaTdtcWJi?=
 =?utf-8?B?MkJZUXpuaGZLZHU0ZTh6dkt0bXRNcXBSS3pIazhXRkk4SDQ2MWtmMUptczNI?=
 =?utf-8?B?ZTJMNkRPNUlmZ1hxbDhXblN3NC9ja2d6bEVibDk1amtyZ1lJMHJiSnBSREFn?=
 =?utf-8?B?OFdzYUZJMUtqcHhHMFRXOTU4QzY4aFJFMEpabmFtc25yTHVPbWtHTGtWanlH?=
 =?utf-8?B?NlpIN2N1SG9DVW9VblJCdXVVM3JkZU83ejhFeW01ZmZUN0svTmY1azhjZE9I?=
 =?utf-8?B?eVpxbU1Lb0V0N1AvMDl4RE16bkVDVmJiQ3d6R0JHWVZNUVZTTFhtZVZHWWM5?=
 =?utf-8?B?bFVhdlY0bGplOFJtVXcweUFIUXlOeXFnVTJPc0tUYkplemJodEdsYjZFWHBT?=
 =?utf-8?B?bDNtbFI1ZXc1YTlEaUVpcFBCWkNjazQyZXkzYm1xYm55MlZTdkRpdDZybERi?=
 =?utf-8?B?V2cwRnZSZlU0RzdBQXc4WnViSU80KytDa3NXVmF3YjNQUXNpRnpqdEpWcWp0?=
 =?utf-8?B?cTM5c2wzN1dWMnI0WDFiZHhuQi9LTUpXNmQ2dkdsSFpRMEZ4UDdRWDIrb1BU?=
 =?utf-8?B?b25Fa1V6V0tuVytJcnNPaDl4eW04dkhwQ2NnbWxGZTJlTXFibk92S25wYTFs?=
 =?utf-8?B?cHIwbEQvR3ZmYWhtTWV4ZDhNVTZpS2FIVWl2Z3JYcThIcGg2eU01VWpGcGRs?=
 =?utf-8?B?M3J3T1YycGljNEk3OWduY0grWnFDYjBISTMzQzM4K2c0MkpRODlxWGJraUZT?=
 =?utf-8?B?ZXVMb21rbWhhSWFOcFdvK0hQOFYzb3Bza1Z3VHZkQ2l3Z2k0c0VLTFAxWnhX?=
 =?utf-8?Q?z12Jg22T/e4ZfexY=3D?=
X-Exchange-RoutingPolicyChecked: eprjLUxcPsoC18cnbzfudVAEgS5HgvnBC1+JPWlr/0C6Zf8yK05ryQFzvsbY2e6Ustr5X9LAvzLVg6zyvAKU2oQR0N2kMJz9Qio8dRBTi7sbOwmoBVmAQd1HLAMIEl8LtAskDjPcF4ADgfeZjVGZv8f4z9zpNJIdS6gaXQTbtO6CV1f/Tq6kyIlwiVVMSzb2+p/3A/uzk6jHFas7FG7LnLdEga3SPqk+BNIVTi2j/P4qrtTvZ9RICtNpnEdoHoYr0uL57tN0PcEBIhCBFhjJIcn4U2d+qUtO53/CR8h6YlJVnC4cJSal42P9eyX5oV65tv1uvFL/xO3RLyPvmXyQXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6832b1-63aa-4eed-32b4-08df26fdd153
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:39:29.2071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLgd9LzBMKOo5JmeDBCgPf30O67xgWD36J0SSK86PBumQA6a5PXcPy0Lm0MRzySRftO65ulrl0VhpOMtuZ0/wRH5CiY7kOT00aW7umvQK54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5049
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/9/2026 11:59 AM, Anatoly Burakov wrote:
> Use the new flow graph API and the common parsing framework to implement
> flow parser for RSS configuration.
>
> RSS flow parser doesn't really parse any "flows", it was completely
> ignoring the flow patterns and was only looking at actions. It will
> therefore not specify a pattern graph and will match NULL pattern, empty
> patterns (START -> END), and ANY patterns (START -> ANY -> END).
>
> RSS was the last engine using "filter list", so that is now removed. The
> RSS engine filter tracking was also moved completely into the new engine,
> and all of the "filter list" infrastructure is removed for good.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>
-- 
Regards,
Vladimir

