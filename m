Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4245DCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 09:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B779402E7;
	Thu, 15 Oct 2026 11:21:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 675C8402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 11:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792056110; x=1823592110;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gUgMUUMQvE+LynNQuqIKmbo9ne9BMMVdWWr0qnkt2/s=;
 b=FvVLU9PGOQa8sm/x3Pt7RqpZUEifU92hu+O683x0vdeXisk6XTAvBQw1
 vy3tVr/FnNYJIXagr2km8pFICwlzNFvFUIeIs2ooLyrYEKdaFOzENiCA5
 datSEiLEpt88AnoESauXdKSP6RMTH1nDUOcg1+SdGlJdQkDa0u33nlD9Y
 IPj1knVsvdqeiqZZMfZLqGzhHej70eqen4dPOw9Oxx2DzlDafGMJdmNak
 tLIeZUivXF3o6GolNrtJz70bFHxvoiShRtwrq3vGUImHyJab9DkBBCQWm
 la3tVDSuQ4iQrLA4/6cZuSp3ElqpjS8Sfw4Xzu2EwTnr9DOTSt9TW1Cq5 w==;
X-CSE-ConnectionGUID: 8kZOq6MeTlCVdzpnGD4McQ==
X-CSE-MsgGUID: QBmihTkaRcmumxd612Rs5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="832220"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="832220"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:21:42 -0700
X-CSE-ConnectionGUID: cTeJSL8jQQ2uFTS97fIXdA==
X-CSE-MsgGUID: qcyVdwWCQRyqQG406j3CFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1668628"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 02:21:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:21:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 02:21:41 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.8) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 02:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIoplZa9g2qr/hZY5si6n0oOYbTc7po/FgGbQ740OGy4f/TnugnXhDCSij5b0rd3HGrcRej+kMu/dte3MKoXN+gvOaj4K+YEAMTBzfWz4RDWNes3xMv/0+CwMBj4Qx2t2OzMjcjoH4rgzjwvQHkVhOsV2Chz6ktZLKZwaHZXPIF+u+WxGlkzjg86ugOrGezETd8z5AKzIrPaUxLzaR0d0MngY1/7BDtCDVp5t6UWdR4fPkEgsJ3kJG2tcrLe/4XybC3b8sNi+hqNJ333oEJu2IFqLVMRRJW53PhQsU5XTAbD9Ewp/GCoiWAVVqLNwP7eIe0XLtdR1kN8KkUUVrm8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPBhcD7KYYAl4WpmvnbxtXNpqQK1ZmD3Sr+e0ca7/ps=;
 b=Op+uewZr2NeUU5dhHWmwynYzruegyD9rdcHMsw39w9+rTlo3LRKirurM6ib85NitV6KrLRlfDCQ0lLGekUt4xQXgLeEJXrK5NNISkQBxUyn5P8nYZhQtJLcBsBq5xbIWugOZktK4kAqQU7xFwDQTrtz+h4o+1fPOo3rpqjqyorSbLiLRAjl5joujjKbdMelGTCqa97W9dD8kfAxBtOulPwQmwAoYYgQNaWXydnMxH1z7BwdLDGJYu7OJQMa4yR5/hx3evTqJw/ndtsvRGODS37RCX/+6aA1nrWIeE9GlHwXoY03bJfuOzeH1SokwBbWCaA4Fw5TDpLiuCiiXLBJTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYXPR11MB8691.namprd11.prod.outlook.com (2603:10b6:930:d5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.24; Thu, 15 Oct 2026 09:21:39 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:21:39 +0000
Message-ID: <db6338f6-fc56-4320-9561-475e55e3ee85@intel.com>
Date: Thu, 15 Oct 2026 11:21:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/25] Building a better rte_flow parser
To: Thomas Monjalon <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, David Marchand <david.marchand@redhat.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
 <as5n5Gd_ibUFwu8T@bricha3-mobl1.ger.corp.intel.com>
 <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYXPR11MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e964a17-8a78-466a-ec60-08df2a9db80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bsAkHWF4PtptJoRyczfwmazyuzfUVme8igbHCB0fBifdNUbZlRpLNmXe+ML7hjiKP2+xwZ0slg3yMxBTJHQopo5F1MArrtVhAk/z43zxZdd2HC5REQnkOrWdYGNK0VZZXLp3aqc1mYOXW5t7+0NpM8/U2rLT9d1cb6lB15zdliVdVr/HCkVLxPUcv8LbZQLzEPP1KoMMwp1mnuIsmPlwx8Tu4BelH2h6sfPOZllkFR/Mjqb1vRSRi1gDtJ0XOc5tPK7ZyzuPeob3VVlnVGCtfcQ/GINIlVB/U3Q6kuRW1+fisx7M9bn0YJ0QZx04iHoDBPrjEduEMWOQPI5vYOqxL6vM+Tb0fgYKxmQwWpsddFDdiZj/0UXJcraPpVWQ2oHFEyQwPfpcsuI0b6bHnQgqYRI/8tUpSiP4QJPlQVfjIPit/50T7eBYB+SvyKRd3DLkIVJA88Iyx2K/6HRTig7MS9zu3xCMDIAC5/ePDYEkrE1vnPID5dDvvtKkHZt8S3YFpIr0weJys1o8gih6BC3YcsjXyIYKPrflTyqBQ5iNmuVqnsHzY49bdDNdeF8zc+kHxKBEKIZ2FDRWzT9vdsWdSA6MYGGf9Y1Whac5zXbrG8/fys2yxPp3ClBLu1aos/gY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEdxcVFTVHdGTENQTlloUXBtU2hZNnNjclpZYTE1NjloSko0bnpyUzlSYU02?=
 =?utf-8?B?b0pLTjJwQmVZZno3SjkzbnlJdEhDRGZKeEZZSWtldlU1RE1rQ1pOUGNnUll6?=
 =?utf-8?B?TFBPMWFmTGhOeDdBbXk3cllLbXlldmxEVWl2U2JQN1BzSWVyTWppamI5SXRv?=
 =?utf-8?B?YXRuZmt0Nm1zeUNaY2g2UENsMGMyNVRmQXZ2QVdhTWxRL0kzSnhCZ285empZ?=
 =?utf-8?B?WCtsdWZ0aUVhS3hoS2l2dnNYaFUyY0RGcmJLMWo1L2s4aGZMbVlKSDNwbWxo?=
 =?utf-8?B?MmhOSnRBOEhzYmVLTk1rdlBjT3E2SDhzRzFsZFhXZ0c3b2g2QVQwMUtGSWVh?=
 =?utf-8?B?Z1IyT0ZmN3VVdTd2RTIxTUcvRGRFckpMQitPZU8wNFhUQ3ZBQ0dIU21OdEw4?=
 =?utf-8?B?Q3NNUG93eUVNM3lXcFlKY2szK0RLMm1sUmZKTUxRemZiTlEwU3I0SjZ1Vnc0?=
 =?utf-8?B?cG9CR2xYVUJVMG4vb2dRY3RmWC9MY3hsTW5hM3h0NDA1ZGZvMDc0K0dIQnRC?=
 =?utf-8?B?QU5adFFqNnd2YS9FMmZWU0p6K250bGJvcjNQcXF4SXk0YXAyZmlmcktDZll3?=
 =?utf-8?B?Y0x3QS85MDFLSno5V0tvd1p0REVqajhjSEdGK0hsV0lyYmtYdytDMlpVM2Rv?=
 =?utf-8?B?OVJBbzJPNmRuTzljWUxPOWZ3Mmc5YU9vTEZjbllKQzRIQkJidVZDL295UzZV?=
 =?utf-8?B?TFFLZEphVkpJUDZnei9aNHV1L0xKVWNCNTdVRGtuekdqN1BLSjZHN0orVThR?=
 =?utf-8?B?WlV4dm5LaUszeVNPc2NqYjZRWnpVWkp4WlZJaEp1cHBrMk9scUxFMG9RMzM3?=
 =?utf-8?B?NERiUGs2UitwVytLWWRvaFZ3S0NQb3ZMOFRWZFVFcVptaVUrMENmK0wxcmRo?=
 =?utf-8?B?ZDlvUnZEUUNUWkJIaFJZTTZjMUptWWg4U2QxRWdiL1VJbzFWekFTWEZBMk1C?=
 =?utf-8?B?S2tCbE8yZ3VtOERwdjExeHZ0NDZCQlZqcTNQdkFPRUtjaWpmTEl4Q01lR0Uv?=
 =?utf-8?B?dW9kdHZlMmFsNlV6RG9CaUZEZnpiSWNDVHBlSE5jbmpWSUY2TDBNRHFndklt?=
 =?utf-8?B?dGdHTllVcDhHUVZtMVh2K1dOWVdMS0hjZWs0VVA0clN2aEhSZ1RPSldVVnNV?=
 =?utf-8?B?OHlNYWJ3emdhWnYrUlNoV0svS3RFS0NlTElrZ3NRTS9aQWxmR2Zqazk4Ryts?=
 =?utf-8?B?YWgzQ2trRS9BMG9vQUFwQ3ZuQUhTZG4ydTNpL1ZUQVZkV3VUamZ0cmVFL2Jm?=
 =?utf-8?B?YVE0MDRNR3lxaGNGMHN2RS9NMUwrZUlpcHZ6YXBEa0pIQTRQa25taUEyUUdV?=
 =?utf-8?B?UkFNVzBqMDVRM3VtSk5weHRYbVpMdXBKVHgySXVYWWh4Z0M0ZXdQL3haRC9p?=
 =?utf-8?B?WG1rN0hzSllDTE9hQnJKMGNad2JXSmFmbU5LcUlEMkRNaFlMQklsSlRQdWFm?=
 =?utf-8?B?WVY4Qms5UnJTem5ITFMvY0dQUC91U29sbEJaZVpnMVNXU1RlT0s2QldUWjRj?=
 =?utf-8?B?ellBUE45MkdZdE5KNXMzM2RNcE1Zd094TVlQRmxaTklkMGY5MWZISlUxMWdw?=
 =?utf-8?B?YnVES2xzZWt4b0NERGphaUJMRXR4dlFGOWphMTlodmJKK1BpYTFIRGZMRXFr?=
 =?utf-8?B?bnpDdG5nRW05dWp4Z1BqOExuMmc1K0FOTFR2RlFoS3g4RjVrUC9OQzVQVmpN?=
 =?utf-8?B?bzZqUjBnWSt6RzlSanJiT3l2R1BsYk9HNzR4WmtYWHpyNzlrTytpT1d6ZWtT?=
 =?utf-8?B?bW0rb1lPdmZpdUdsSHowbDdMcjJrc0dXQUNhZ1E0Q2xNRkZPaU5tdU0xTDJE?=
 =?utf-8?B?bkJFMDV2K1ZPSXBWTzcwQXB1M3MvdFRsTURuYzF2TkN5UjYzdHJhT2w4Q2pN?=
 =?utf-8?B?N2x2aldyNllEbWNoQVlKd3dKUnU1SlRQUS8wS0FWWm5kd3hYb0VHRXVyRGJV?=
 =?utf-8?B?ZTlPR2M4S2lHZzVka3U5QkI4dUFXaHB4dFBHNVZ2YlBXWXQ4T242Nk04eXpz?=
 =?utf-8?B?b1hVUUU4YlhCWXBjYk5WTHFVQ0FjSEozTUdtT25lNUxhbmtqRERSRUpESHNm?=
 =?utf-8?B?MEJjZW9UL25kRWdISlcvUUlCY1JaOUhiZldQWmo0Z0RJMlhXQ0wwSjBES21l?=
 =?utf-8?B?cVg5YjVhUU5Wei9leVBnd2RzanRxWWVIejQ1eHBYa1dDQnh3QUxoWkcrK2tI?=
 =?utf-8?B?a2xTYS9PSU41RHZvcmphWFRHMERMTFczRUhnbS9XdXVRcTk3aXdQVzVxMW1B?=
 =?utf-8?B?Skd3SGUwWUxndnl4dU5IZHlwWldWZHM0N0srd1k5Ykx4azF5aEtQaDJTK2x2?=
 =?utf-8?B?UUFRUDVEZG5aeHlMMFRmcHJ2dmFpd3Z4UUFQeW91Z0ZTdVhMT3JBZmxpdU9C?=
 =?utf-8?Q?RuT1ZXyjQ5+xYRFE=3D?=
X-Exchange-RoutingPolicyChecked: NgCpbQGVilGvkIH+VRtEWR5/XpYrkuEj9YDEXKQkQLBfEtUyoP3kn7pXYVtUfwoIRJ5zHJ4eRxasXCVC+iNXr6SPaojl96Nf+PLn/4M9YysCW6VjXyetYRkzemrvQjEOTEHewj+UbXvl/QG/D8cPMN/o3W/XaeF1XGXoqnkJVJX41E1LrcG5M14/6p9hBZCtvstkQ8W4N91DGNZL+RqLivlZ57DwwSwdqfx9tBjrOICROl4pQ2TiUEVGFFTLvPT2Sbku/wAY4HmL4PMpsgV66PV5GE0cb11iN+3UMqLtC7CQATPAd4VfholX9zJdhF7PP+fyRxdtlPVrw2dIYZ27Eg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e964a17-8a78-466a-ec60-08df2a9db80b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 09:21:39.7178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzQCqUIISb58CmNjpJ4sAKjYohIXaq+0fGcp1SNbbYWylQ7d3sRnrIeranfqRr4nYPxNwoTKWlRtcxnVPYunN/ta6sSH1AYpUaDQTjrG79U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8691
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

On 10/14/2026 10:50 PM, Thomas Monjalon wrote:
> 13/10/2026 19:18, Bruce Richardson:
>> Patchset applied to dpdk-next-net-intel.
>>
>> As well as the arm build issue, I also fixed a number of checkpatch issues,
>> since there were a large number on this set. Most I kept unfixed, since I
>> felt the exceptions were reasonable, but please check what was applied in
>> case some issue was introduced with the checkpatch changes I made on apply.
> 
> Unfortunately it fails compiling on my FreeBSD,
> because of an internal API included in a header included in testpmd.
> 
> You can make it fail reliably with Clang on Linux with this patch:
> https://patches.dpdk.org/project/dpdk/patch/20261014201627.571496-1-thomas@monjalon.net/
> 
> And you can fix the problem with this patch:
> https://patches.dpdk.org/project/dpdk/patch/20261014203435.583064-1-thomas@monjalon.net/
> 
> Please review them.
> 
> In the meantime I cannot pull this series in main,
> except the first 2 patches for ethdev API.

Done and done!

I wonder if some of that could've been avoided if the CI was better at 
applying patches on top of other trees instead of always trying main. I 
remember trying to do it with VFIO patchset, and I don't think I 
succeeded in getting it to apply/build on top of next-net even though I 
did the recheck requests and everything. I couldn't really get this 
patchset building through CI so some Arm compile issues have slipped by 
me as Bruce mentioned.

-- 
Thanks,
Anatoly
