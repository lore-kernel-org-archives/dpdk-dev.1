Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F3BCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:57:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68033402E4;
	Thu, 15 Oct 2026 16:57:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 63F6F4027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:57:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792076238; x=1823612238;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=+3UaLdATUd6Q1TqqH0pHqM/1vJ13dabwDp8QCREXhgI=;
 b=ZTJQ+WCENoYmBtFtAtPIBZRWAH+76seCjbjE9iMnh5tkTKtq0kpp/VV1
 cr9eJLZFowbEe8LqWkTawW0VPwjuOv4baRBIKVl5TRcX2osKYeB9FdAsO
 bAR1OGqaYA6y4HSSXKTlX+jG7rX0+sWh59CNSxqkWV+dLw4schXjQlf/m
 C4T09J4+McsQkpjSW3nVpFVJQkuA/PlvOQrhVTRZtcgWGbye2Iq+PKMUi
 AvUuumCbMmKh7t/SQXBiRjNImI4JWJMmQ4WqU6vxaZsJvh2feEzPhVfGF
 r/mWDFQKYjCFpXivXNEgFO8RYfDOsNFVBvHpfWTw1kju1qY7gA0qQkLdi g==;
X-CSE-ConnectionGUID: QwWxF4aZQ1u3nKWnbVt+sg==
X-CSE-MsgGUID: t8EMT8UXRaWDPhOpNY+5xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="743752"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="743752"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:57:17 -0700
X-CSE-ConnectionGUID: MDBLXX8oQMC5SGIj20CJfA==
X-CSE-MsgGUID: ZT4mehLeTamwBQfkilR+BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="3546256"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:57:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:57:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:57:16 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:57:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXDN2xeuqwwAe/fLIAf3t/Tza39INZhSzViw1roBLiG+XBAR8fRmuuF5fEkr+RIYG3EftAgEh1n4jxwGq+WG60hTY4BV3HXHo29NDuSET0pk7kkBtJG9oPs9CN1MJWsumIr9iorHOMZB7VxJo6VSu6qws2ZN4hcz3UTdCzOyk8aBlu9QkGLc0tmy9UBHbNWb8BF8S3nWjY06ZEXkFWRNTbwTYYVFrbblrouHzmdAOJCzBJVSSA5nSQwjz1m3nfieXvKorDgq8MTuhA0H7Rf2/bL771nMJEj76EHbb9SNopbkSX6z9xSB8BO5I9shyc3qFaule4XkkRhFVvnA531FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i6shPMw4x6evCdT9IKyPmZ4sw5xfl+AnggCNm581PA=;
 b=R8qNvRrgC020SUticJlKW3L2mkFxFwR+GZqhYY75xDe3kWkIvlFNPnr0ZQ3TxFRDJhXlzTZeVDUw5sgsp1DHAF3rL4zM+a7s7jLAFvRiL/wSsU+1orDGWNb4MM/LnurFi1Tr835FDJUDPvJOsuXsxYgFnBYswwoyRh04eguc8qugpCU6jcygkgu0IjnRHdN6429Z75o1QEQBzceqX/6i2UJu8kwN0iixQLBhRP4NuECJ8OVSJXhpMvBiJaz2ZoUISfwJLI9IkaYz72M+0DCZCyNNHLSWQFiLPPXpmXt4+dRXcD1fjWDKhMdgVz1Xl/mXPkHCfgCexT5/fTDBjq79Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by MN6PR11MB8148.namprd11.prod.outlook.com (2603:10b6:208:472::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:56:36 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:56:36 +0000
Message-ID: <8128e56e-6e70-476d-871f-bf6849055f7f@intel.com>
Date: Thu, 15 Oct 2026 15:56:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net/iavf: remove dead code
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <000a4926363e5be631db4f8209bed02d11369912.1792075372.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <000a4926363e5be631db4f8209bed02d11369912.1792075372.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0014.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::19) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|MN6PR11MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ddbd50-ac3a-43cb-a57c-08df2acc8277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: rM2Pdyo51Fw9EpQs565IFMTXfdSD0JdLPYrlKCCfxt9gGvW/A8C9WziCSBM636BAm+6PuWYLMsxG2MTO2pcI91jEVFHPUy5L0EaspYao+wlIQpo7l+zRgwFwYmt1RxDOG5gWsW4NuiJJo4X5yfujFMO+vrGZHCwlsCIOZ17gnsO9pt9Glv+i19nX/DZm0pCKkEyCoU1OSNUOgUDgyGg/1vq41foP1/27HSI+8oFjvCyxQ+1DsWvwsOos8pWN9j08AVrp7wVBBSnwYPZFG0OsGklk1hVYm+Wy0KirHJ9G7abDYKkY3R6aH/zdFK2vXqOkm3NYr4c8bX4NbkVl3Jd+Yy6M/QbELff15br+Jzn+cZJOQSIgno3Rvob9fzbe6drtgjg2Q/Du2Dvrh8i5l6EZOWknRNhJp3yTR5c1eM6s9SNY7o2+36Z2gYHFk9ZqyW5yhKPnhLIzwz2JRCFHB2hZM1DC0HD+MOumW8Fs9zDTBod3D1+p8gDX8Vq1h61yCEbwMfnJjn45v166LfB4dDnL1MmXS/+57fQYnfhq2RueWSlxSIrWq1upg/o+WdYteLSkbuGVL/PAVdPFSPnzLlXkVW7KakOZlwCrkvL6ebonxVGwpbVI7OQK5uLkrzcGaGZwiHguC/x6OaVRU9BvwUwIOvlPmveK2YYPcFILtB44/2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01JbTdvYWNGdkx0OXVzbDNFU254TkVDYkYzbFM3eEYvZ1FEWThUak1hSVFu?=
 =?utf-8?B?US9OOVU1ZXd5MDNCMU01SHgwVjd0TURhWmxMZUdZb0EyR3JIb3plSVBoVHFr?=
 =?utf-8?B?d1RhVnE1K05ob2ZmRnROS2Q2anhyOHdtUmJ1NkdzOTREOW1MT2YrZ1R4TXFY?=
 =?utf-8?B?ZDhydVRQOFpuY25aQlpmK0xxOU1uTUE4emg2QndJVEhUd2NPMThuMDRNaTJO?=
 =?utf-8?B?Q1ZHVkVBZ2NHMXUwN2MyNDkvdmprMHdGM2pwbGVXRWVmU0xpeW51dVdCaS9z?=
 =?utf-8?B?QW52RWhsbk55VGFHQWdtSWgzNE5EWCtVZFJiVkl3RkFkMDhCenFmOHVpRWxk?=
 =?utf-8?B?eXcvazlDTzBYVTU3ejBqVE9sUXdiQVlZcXo3MTVteUpqU3N0dGhQU0s0RmNn?=
 =?utf-8?B?azcxZ2JRM3lJdXBIeVNqdllJSDlrK1ZablA1K1l6K0h6YVN5QzY1RzZJWVdQ?=
 =?utf-8?B?Q2RQZ1ppTllqNUZoN0Y1Nzd5VEwxVUpjUk5pNHFIUUhCY1NPZHkycXR0NlJq?=
 =?utf-8?B?eUc2UnkxdlhobkplOVd1QlFwRUN1UTVtc0FsNEk0c1NOeGF0elcybTNoZEl1?=
 =?utf-8?B?MU0xYU5QMkJQU293UmU5VjNMNlNwRmkyak0xRVNuaG5mWEtGSjR0dVlQeEl6?=
 =?utf-8?B?dy9lSUpqeXVtMGdmQkRtZGhCalhXcU5nUGF4MkgzQzVBeHgwN0lvaE5BbEdt?=
 =?utf-8?B?Z08ySXBtRFlPejNKRlJockhNMlNiSE9LMDMvcmZaa21PRHRsL2k5L2J3ZEEy?=
 =?utf-8?B?SkJ3UFBsS0RlRmJCZGNMenljV0NlKy9oUEwzMHhsbURJNUhnQi9ybXU4V0Vw?=
 =?utf-8?B?WjZ2Si9ydTc0N01zMmNUaDJTeWJOYUREbysza0NLRGdsKzY0ZzgrWGxRT0F6?=
 =?utf-8?B?OXFFbUFubklGMXVMdW9JNWRsY1dEMlJKRTlWS2x6dnp5a0VXVnlTYUM1bTlj?=
 =?utf-8?B?L243cEowT0EzVmlnTFpUMFdkRjVBZFBkOFpGam5zOVJtaUpSd2hRdk9BeFVz?=
 =?utf-8?B?alFETkdlODJSNkVWdmJEeTZmT2Z3RGdjeVVMSVI2QVhNV3dBL1BTblRoZFQ3?=
 =?utf-8?B?eFVwTWp5OC9WVzJUMzgrbS85b0dneXJkVXJCdGZsSVBKbCtpK3ZxMHc0bStx?=
 =?utf-8?B?bTcyMDZFV0wrbDdTczNFZ0MyaVErTXhxcmU5S0V5dlZpd05Ib3FKclBEZTdM?=
 =?utf-8?B?WnZKdzY5QlFpRVc2NVA1NGxZTGhFdkhtajFrbVdXMUFJL3BNMm5JN244MUdl?=
 =?utf-8?B?VmpIRDdsNFkwU1ZKaWNKSFVQclgrUGxTZ1pYRWN6VTlyVURlOXhHRWk0dmpC?=
 =?utf-8?B?RGtDcTMrbkpaMjNDc3ZJdUtLdno4N1hzb0VxR2JMLzFYQTVOOXZBT1VFUFI5?=
 =?utf-8?B?ZVhodGw4U1dPbW5SMDZsUlBlbU41a2hFWlRLT0FFMktMVTM1ZTVVOTNMWWky?=
 =?utf-8?B?ZUxFNm05Q1JGWGx2STArZzdBenJYQWNaSXpGS09VU08yTzEyckFaVCszQ0xQ?=
 =?utf-8?B?dG8vQk12YUExR3FWazNYNnBsZEthMmUvRzlEVDZVdndKTFc3eEY5TStvWVFp?=
 =?utf-8?B?Sk04Y0NJdHJ3bytTckhVUGJXa1MyS1hKN0RBL1Q2MnY4RnJVVENkOHJlQmRz?=
 =?utf-8?B?V2I1UUt4ejViNVVpc0pRMzZWUVlpc1BRTE1XVmJOeUFheU5oZCtqWVZ5SzFP?=
 =?utf-8?B?ZGtBV21uUUI3bHhFZ1grT0U2Y0IxcnhuV2NwMm9xWHpEZ29xTk9XUlZKOC8w?=
 =?utf-8?B?QU8yNjJ0cFRmYTZMcVRvQ1k5R05LYm5jV0VUeGRhNnJsb21QS3Jac2MwVi9F?=
 =?utf-8?B?VnNmRm1DWHcycDg3a24zamp0WkdKMURZcEFOZ3JaaXYrYVcrTGZzdnFlaGxt?=
 =?utf-8?B?ZHZQejZYQ1ovZ3FBajNFeklIV0VZVzBLQ0tDcWJVU3h1eG10T21IVk13R2h0?=
 =?utf-8?B?WlhwUG90WWl5U1R4VXhkNzlUSlNSYWo3ak55RVZLaWhQWGFSUEw4VXNWNzZ4?=
 =?utf-8?B?YUNvVlF3VUlZLzZ0VWNONDM1anFuTDB4TEx6R1JUOVJMcEgraVo2RU55cCt5?=
 =?utf-8?B?bS96YVUweTRROU5CRnVkWWczakQvakR2U3BBNll5OEpMdVlzY3RZMlRLVkVu?=
 =?utf-8?B?TTNGZDNiczJSS2F6TVNkUlBtRmQrZW5hZGVuZyt2MEdiUzRlTW8zSFZKSmZL?=
 =?utf-8?B?ejhrUTF1SXYxcS9xNk5TM0NPL3B2ZTRYaUV6dGpnaEZrdXY1TlpIaStDYjc2?=
 =?utf-8?B?K043SVo5Y01GOUZxVjNpVlBqSjZZTmZ6QURnNGVnbFFpbHBHODF1cm5xdjZ4?=
 =?utf-8?B?S3JUNVhjWUxKR0w0elBnaFBaM0VFaE5lSmJvU09FTjRwZHpCWUtYOHdQbmlt?=
 =?utf-8?Q?wk9LeEqBYps76nvc=3D?=
X-Exchange-RoutingPolicyChecked: S15c0+8z0o/a7pAD8zbcLhVfkZWTi1YLnmKlZkyaX1Hzm6tw591FKoLZHPWUHwl3Bnh7hNjtfRz9EzousgTXdjtONsIACPC9SMAyQYDnLKrW2OXljLypMWU3gbk9YsJGRd2vmwT6oF0IP1fciVFchtviWJVJU2Bw9vwnNx2mAgdWtbjGkuIJAA9L05Rz8lTapR1cMLdl2DSh9GtgcQKjPhzvqtbmIP0B2Ix3XcKb5HpoEhEAEjru061M9sDhMdzgcJIok1F2qGe1B4pTGODAjtsq7sXaovPEdmvKGIPwMUUBi8v+1IW/045W4gdKgxM8Yq8P7yfMzVnC/GWbuX9o0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ddbd50-ac3a-43cb-a57c-08df2acc8277
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:56:36.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzq1M4Myaum09qRBzim29pW/opA4XaG3CuP5hoNOFKiMBEtgemB6bEhxlWFX7cGPLo1rifKHOq11yqFA7RuGI+ubIS7FbBXaqGjZbgRd23Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8148
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

On 10/15/2026 3:42 PM, Anatoly Burakov wrote:
> When configuring Rx queue interrupts, there is dead code in one of the
> banches. Remove it.
>
> Suggested-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_ethdev.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 6abdabfb94..937b1fdad3 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -901,10 +901,6 @@ static int iavf_config_rx_queues_irqs(struct rte_eth_dev *dev,
>   				       (0 << IAVF_VFINT_DYN_CTLN1_ITR_INDX_SHIFT) |
>   				       IAVF_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
>   				       (2UL << IAVF_VFINT_DYN_CTLN1_INTERVAL_SHIFT));
> -			/* debug - check for success! the return value
> -			 * should be 2, offset is 0x2800
> -			 */
> -			/* IAVF_READ_REG(hw, IAVF_VFINT_ITRN1(0, 0)); */
>   		} else {
>   			/* If no WB_ON_ITR offload flags, need to set
>   			 * interrupt for descriptor write back.

-- 
Regards,
Vladimir

