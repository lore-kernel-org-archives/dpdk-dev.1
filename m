Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B23CD8CAD
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC7AD402BE;
	Tue,  9 Jun 2026 10:04:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 82506402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 10:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780992274; x=1812528274;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ScYbv2tiy4lbi0m5uypYHWpex1QuMbsDpjdq+4GgS4A=;
 b=fRtN/PVcJzNdqpyyT6pMWzUropHecJ0PsBppIxukXJoiQ1sW2WdrBP7B
 j3N8vllbhoqZLF5sRswk2HCAOVADJf+n64j/hWZotLALxxtHdaTzulj2w
 RgFosYb79WDErpAqi37FlEtROt5v+O4PrDxBVVZrqA6jNYqBwRfRBnfw8
 vLV6N3jz9O06zojidwcIlCIs2NonQnw//qKNLISSQw2v5SSh6SqOn6G/y
 jMowMEduEs5Tw/twKIpj2hNp9vGm1Ug5TmAU4N9STUgSf+4bR1r7XI8kw
 LbmG+6qasM7GPK0Re8Dk3m7W7sl28oScTWhJZDT2MALk7OtqPHCkWC5HX w==;
X-CSE-ConnectionGUID: S2CeMDW8SwOTJNoiy8Queg==
X-CSE-MsgGUID: nFua5ZQVRKSNYpV8jKCMfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81857429"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="81857429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:04:32 -0700
X-CSE-ConnectionGUID: YTO/9EbFT1WpkBH6ToZxSw==
X-CSE-MsgGUID: vML3csKNRHm8QYZm9TBSYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="249715941"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 01:04:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:04:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 01:04:31 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 01:04:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPlr9h7wt3sOklJhqBWCxEnmDMQt7vKdAIo+IlLbnxpp1BMwe8AU9dW9mCsaHold4bVAtVZxdIsrZVX7M05Qnmy9ty+u7Z823W7XN84sYVWdnGvHupEt5CcdAUHwwCPoUCQ0Y5yh92Ci8zcNn3AGNUY86CAO1Y/WmXqjWkgqeIxmNgsgx220+XqvdpeMAv3YMVADpssyARMKDRBasz3xppl56SjMj9Dr0AoDKGojy85ZOpEvHgu5LRHn8YV2D+ttfTrwvoLCY9tzgG8l88pBAMNotKh5Hlm9UAHscc3UlQn7B1+S7zX8OM+09U+tNvbzkdkkf5Qny7SbuJ+9eLkHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noNqQ7o1Xc5drAL9CNY4BwXM3ENfxlJMFRYrPFNn/Bg=;
 b=YL/qrRN2VKi5NspR4YYBdt97AUqdYjhXpuSkgfzbuQOsfPHtFD+Ef8ti08vpgDl/WmA5fIZdsCWUIxee2WAz7XXjYxkf7O9L5/0gdFVSe9WiHd9oB6ObxOUrDdZAS9ki3BgnqEcR30mR/IXevS0S66ncK5LbDg6bTCfqN9LOzrlI1trHPj+tXz51ppVgB5Uc1pn/g9Rua+jsdIWIxgSErLCp3w4WbtQGVo3/pznm33P7RcuOR+ScLFSwRYhYiNT8Zh11LMsBCudcWQ7Wf9i8bAp8/1N4PTSOMCn3b3eejUrKiMw5KB6SG+z+nwUS/Jy+eCu6j3+ZTcEG6ipZLBiRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA1PR11MB7812.namprd11.prod.outlook.com (2603:10b6:208:3f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 08:04:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:04:29 +0000
Message-ID: <9f0b651c-13dd-44a1-bf72-860202f8cd99@intel.com>
Date: Tue, 9 Jun 2026 10:04:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] eal: avoid deadlock in async IPC alarm callback
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Jianfeng Tan <jianfeng.tan@intel.com>
References: <c5284e2f5e9fb7d664ab65115cac2634c93aa510.1780669755.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <c5284e2f5e9fb7d664ab65115cac2634c93aa510.1780669755.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0286.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::13) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA1PR11MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e48ffe-59af-487d-1e8d-08dec5fdbb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|6133799003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4Wlj4CPOr8aKwM2qn+a5b4knUTgVHzMHrlAzV7a6/CHBlOLeJk0Z3ZOXgglvbjFtNwwSxXyEICQNZwsx0AzS0c0zMMt/neiiPetKE6An2wqAK7Dn0o8j6s6Can18lc6ETvtrCUVM71EYQr2q8saoXFmwzjKEoEe2Z7KvMBnDBTLkMV2FpEt/wPn9AfL5f8Q5yvIMw3hmjzX+wWYQ3GrHa+TiyqAq1Q3p7H8v91GwQUZo/cJmDFmbAijBma9Gs8fnW9DkoCxXzEazyHP/hDveqoJq1Toz8QR9Xn74elsyOCnVYGczp43J3hKOp30rjVURHdT+Wxh4vJWJBB9balzfxAzyjfyt2L4rdmp6BPbu9LCPYDX+NsAfkbPTmX1MvBiFmF3vsiilx7qrGn1mPbs3QKFoY2NVHym8NF92SndrzGl+lvP65qwdOWSyZhBmbb2OCRPZzXp8wS5/yXBzR4enddBhvy7jh9qRSEcLLfaBf2/6mzLxzkiui4/zD+dh7lu5vr2ztzKFYas0y9Q8cNe99QQXXEtUDlO8q/yu8gnKHZj6iStE5Slmvqw2bWn9y+JuATW7+KQs+lda/6K2kicS5KtteLHHvJXP6DGN2/vhubduHdErK8znYGoFNqe2GT6GTWhsxZoM4U7vK04MCaxR7+AkHzz9bvb+pIcBnCKBoDk9knuDMGCrMmhKTWqylXHG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2tid1Q4aGdab0ZMdmJzZjFIclVQeXNFSlNQS2grKzlTa2xMUloxaWJsT0xN?=
 =?utf-8?B?UWsxUmFPSDNGVkxTMjFFcXk1RWxMYWlRVXpZZldpdnRRYlYySGgxVDJFOEpl?=
 =?utf-8?B?OWhwdzIzWGhSTjRWUk51Mk1CakhHRHo2b1hwckpjRnZVb25xNGhNamU4N2xu?=
 =?utf-8?B?ejVralBXdEdCcncybmhPdmhmMDBCdW90UGRlTmV4eVdTNENFcDM0RjNmOEJa?=
 =?utf-8?B?alMyN01tLzcxallzc2liNjEvRGtuODZJLzI3MmZNdzhaTXlTbTlmTW1Qcyt3?=
 =?utf-8?B?d1lnRUgzN0tzcHkwaGV4bXhjaDZwNzltNEZ0UCt5VnAwaXFVMWUvMDFsR1Yy?=
 =?utf-8?B?aTFWV3JObXdFV0t6UTlOUkFJTHIrUS85dmdkZzJxM3ZHdUFiWXJ2ZWdtWjEz?=
 =?utf-8?B?emFLZ2tLUTI5WHAxQnlGTlZSQkY2VnM5VWtvUW92eG45aDdKOW4zSWc3OGxk?=
 =?utf-8?B?U1poN1c3NVVxK3lNOU4wS0xGM0hHdFMyV2dTQVcwbVV6ZU9kVGpRSkE4V2Uy?=
 =?utf-8?B?Z2l1dHdrS21NTkRKMW9seWxmR2U3akhKa2tZdm5jekNRRmQxbUlLcXAxU09E?=
 =?utf-8?B?Nk92cDYyL0VnWDVldmJpZXUyNmJjaWRadlBZd0p4OUJvU0dyVWJXR1lWNkdl?=
 =?utf-8?B?UHNSMDBTdnkwTHlxOU80bUZkL09hQ01NQ3pvN2tLRkwzWms3eTNaT2xxT0c0?=
 =?utf-8?B?eDRmOTB1eVNVdmJrYVVvc3hvWG9OQ0VVUXZyWm1pSXQxcERiM0k4K080YjZm?=
 =?utf-8?B?TVJWRkhDZFNwampYRU9ad2xDSDhDV29obzAzK1NWUFRad1NVWkZqRHIzSFRS?=
 =?utf-8?B?RHg2TFZwald4VDJZUWVuT1pURTVHQno1a0lGa0tXcWI0QlVwN1dUV2hZcVlu?=
 =?utf-8?B?VUFRWmVDdU9hTWJlS2JyQ0Z0TVhiOWFOZTZPSXBkSkZOU3dpbVhrcHlISnZy?=
 =?utf-8?B?eVByQTJua1pOSmdYeE5JeDNCYmU5ekZPd3NFRVE2bzN3elBIWWNFd1dxZGJy?=
 =?utf-8?B?amZvZWJKeHkrSmdRWEJ0eWF1RGRpWUNLeWtrZndsQWNuTURVRnRYNE8wRFJY?=
 =?utf-8?B?TzlORVpHSmNoSUErU1gxS1hXdUtFTFYwMG8wcEZwVEJ3VCtlcWJpckgvQ0d3?=
 =?utf-8?B?UCttbitIdFBPc2x2TUlEMUVrdEhXcXN5M0NUVVkrdUF1WlZzSlF2dm9JRTNE?=
 =?utf-8?B?VG01R25hcHgwWkJYVG5rbDNpdVFlYUNaeGxRY2NjeS9vYzlDNW52VzFLbHoz?=
 =?utf-8?B?a01YK0JxMmFOd0liRWMzNDhlU21sTEpvODVySitMUnFnNkxudTY3UTE5YUZ6?=
 =?utf-8?B?emFQOVZOaWZycGo3VmZ4ci9McFdVMHlIK2xwWUpOdTN3SnIvY1lDWFVBZitS?=
 =?utf-8?B?MXpTbldReHBocm9wSE0zWit5UWRxN0dldlRQSEN1YW9Dc0hMb3QvVnZlR3pl?=
 =?utf-8?B?R3VLR21GVUJkNzhrUXQzQldCQ2RiTVA2eUZhb0h3UDY1QXUrWE1qUFhzc1Z6?=
 =?utf-8?B?NUcvYnRwUmNTR09aaUtTeFF0bUk4cEZ1WXNoL3pWdWM0QnVFOVM3ekFCb0tD?=
 =?utf-8?B?Tm1iYVErS0pFWWlkTnhxbm9kNW5aNmFWdGVDMHBIK2lia0E0U0NHcFB2UjBw?=
 =?utf-8?B?MFVaNkxONlE0WDV3LzA4eVpWYnRuWU9TNytUZnprOW5HYTh6dUtJb3VzYWZB?=
 =?utf-8?B?a0x6czQxV3NpYUNaQjhvUnpPQVRZK1pJdmF1M2lEZmVuQnpXNkFubHJzY2Yy?=
 =?utf-8?B?dll6c3kzSUFaVUwrOFg3S3d5U0RHQXdnOS9mUzBDaGpsR0VWQ1dWc0R6eXZ6?=
 =?utf-8?B?MEhweGxMVy9ob3BCUk9sSVdRTm12aDR6eFhEV2NNQkFDVjZRTlNPUytuVU1w?=
 =?utf-8?B?eWZPckJBcGFhMDl2OHBERmdZbjc3ZDVZVmNXLzdYWlZVbUJYOTRrbzN1TFky?=
 =?utf-8?B?c1pVWnc2WDAyenNYYnFGWmlSUFJsZHEyV2xqU2hmaGlETkNGTzF3L3cyTnlh?=
 =?utf-8?B?d2svMmhQVEVxYTlVdnhweDRnckxicEwxUFc2bzltQlhuMVQxRERJUzZlVXgv?=
 =?utf-8?B?YzBOOFN0VU5VcjM5RHRwWmJxcHNHTVZkNllteFFpY0UrU3BHaFd5ZDlCNS9Q?=
 =?utf-8?B?MitlWXYvbTJCdSswMkEzREt6UjRScitHVUpVN0JhTDZBKzJXMC9McTFkUnUr?=
 =?utf-8?B?cjNGSXViU2xaYlBDNHRCRFduTkY2emtDQnpRVDE3bUZvdnl4VlBRQ1Q2aFhT?=
 =?utf-8?B?RjZMSnJZWHBPL2NhYm5IQ1lnTXNTbzFkbFhLaG5ncnlxRUFqTVoxcFYxQVJ6?=
 =?utf-8?B?UHIwa2RnRm5iWElzYnExOHJzbDlncFUrZzZnVXcwRWNHR0xCanNNM1RQdDJR?=
 =?utf-8?Q?SJP+xDxTGAvvtLtU=3D?=
X-Exchange-RoutingPolicyChecked: BUJ0OUt4qNBe6tjiXQWw14YtSQuqCef8FZyD9BBP/CKTAyeW/0ktynOHArvIO3a44SyT2zMyduDTuKS8uBg2DG7KDF/OYha7hd82V5sph5Dh7QJ/zgZ3/Mh9EmLCVj9944YMcOH649ifVZOlKc43Y4ppfgYe/vDauRfEV5rYhMzkIKpr5f6wTDh6oOPn4DFTGmsGIzVaKovXCu632zw4GR4LTwyFmN/aCI6vLTVu1OOt9EPvVEk/2xB8N9KIq0zlqX+c/2Y3GlVMqLnkkchlWRLX3+Xya7Bvihu5G5c17xMNBzZldi84fHTQIr3wqeltQRjrHHbqVR78/5q6CNdZLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e48ffe-59af-487d-1e8d-08dec5fdbb00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:04:29.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXcT/K4qt0moM1eq3XmzPjV/CMU8kb3mmietdbRSF9WtKkp+OJURYdhFAxElKmV8kreA4LlzNxf+NS7dwsDAgTvsy5MTktZzC/Kb95YjikI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7812
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

On 6/5/2026 4:29 PM, Anatoly Burakov wrote:
> async_reply_handle_thread_unsafe() can run while holding
> pending_requests.lock and currently calls rte_eal_alarm_cancel().
> 
> rte_eal_alarm_cancel() may spin-wait for an executing callback, which can
> deadlock if that callback is blocked on the same lock.
> 
> Remove callback-side alarm cancellation. It is safe to do so, because any
> callback triggered without a pending request becomes a noop.
> 
> Fixes: daf9bfca717e ("ipc: remove thread for async requests")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Okay, the AI review seems to keep flagging issues that are technically 
true in the patches, but are intentional and do get better once the 
complete patchset is applied.

Looks like I need to merge some of the patches or rethink the order in 
which the fixes are applied to avoid these issues.

-- 
Thanks,
Anatoly
