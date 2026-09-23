Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F33DC98307
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 11:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C9FD40262;
	Wed, 23 Sep 2026 13:53:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 999C74021E;
 Wed, 23 Sep 2026 13:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790164394; x=1821700394;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SmGFLMBmJR3hkg/91tTb2rFa8jNFgzX8SmQLlY8Gl0A=;
 b=UCcp/iwHn2UpeAVHlUEGMMKpTY0+2OFL9kkXSDdHDKAY1/VmqVsHKkcD
 uMirJz+B6xw20QnlVwgEWzdvXacTM9XB66XCNQg4GWtS4n6c+zsiet69u
 iIm4rJm7uagH2ZFioBgmoUNwegxOVLT6HrQpuurItRc1Ti5SuMHwTm0QB
 KlDXtYXRKJOF5ZEzhKROb0MIgG5s5e7udQmxDtm4N97rmL0pO5mw77vz0
 gEx9IHWGIAyxnacJW1GYv/76PR2nwk21mhF8X8SQYClyyzfwIuV2Ll10m
 fE8xnM9fg/mSq+7Fzdgcsu+8k87ZEGbBP7p7CGyORzEMVNMqqclIIzrk9 w==;
X-CSE-ConnectionGUID: jU5rEMBVTxe6OYkzTJ7Icg==
X-CSE-MsgGUID: 9/wMs7i1Rp2pt40QhGZ5zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90719890"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="90719890"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 04:53:11 -0700
X-CSE-ConnectionGUID: HBf+f5IiTAOeLjwhjpmo8g==
X-CSE-MsgGUID: s7SUH9Y1S1Wlsgv/FV91jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="273050826"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 04:53:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 04:53:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 04:53:11 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 04:53:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guMTANLybSF+FAymLO6ygMpYLW640AUPCJOACEZvyoXBQtXENOoCqWjm9BykN9qxFitLhMsLTDxIn0Y00yVSjA0ybhFCSZz12/s0pWR7ganqQkDgBPPYncEU47B0muWOQbw+OUAi02vHavlJ63e7pxHEIIR1/daG1x+upJYALEMvVAP3ARmanc3zbhTH6fTwcyAu2bffmLr4lfpLinYxS6ZgKC1QEIzUJyAseocYqzEK0jgPSWIlkjnXWsleIJ15nZT6YZdTOSzkQm9eowq6m+oQYXozbhAY8c6kyCi64aGIxdLdGcrKEcc1maVoes8TmNZiwx2p6docqkF4jmN3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXQvrLCzP/qWe+kLpOgM8IRSwM9SX+JO/+aFQWD07Lk=;
 b=hXhEKVqN6US8/yp5kueF2oiZrQjDinLDSZ+eBPfuBY0w1N++XWV2USU8cIsEi0PQ0Un4//mCbajTT/OfiarjUFoIyBopQAJ0ZRQUstdT8wLFlsKTKzSW1fsXwaMQdIGNfZVkR0ZzN/XIOsJULDfZNPaDWLUAdYAj8Q3HB93Ha1S/LocESEkrp3bSdzmentMg7TmsNQ3QQm0RU1AXkXcB6y+TrE2lzs9BJL3QIKL/9HNnW3b2fJF//CyVhCVoob3VZ2nFiYh4dQmMwIAtPY+PDFhxHJWfrqe6+g51anVk/6XXhCShZCEoPMUMySLynJSIpxelYji2QgwSoO9r4BY6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Wed, 23 Sep 2026 11:53:08 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 11:53:08 +0000
Message-ID: <f12d4457-816f-486b-af71-f463b7002432@intel.com>
Date: Wed, 23 Sep 2026 13:53:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
CC: <ciara.loftus@intel.com>, <rjarry@redhat.com>, <cfontain@redhat.com>,
 <stable@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-2-david.marchand@redhat.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260914081725.1097704-2-david.marchand@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e41dedb-82d4-444e-3f6d-08df19693c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Xcyld/+QVoajWeohoQ9ZMnQp9eT38TCmkm251Q3wbUscRwkECSK9NseJRJOn7GM6Oxvq5QUM08dmIqcuKFsIkonEAches9vDp+8DtNiLNjW1xbxiBl84TnJzT0EPwss6FZhG31J3yUYkGWh7ixouD3fNHbWI9hZVMzL38XwRsML9yaUPhhTEgYPtFCHvp90Q+/sla1BlDyZ9DFNHt0fvL4SVIX6k05Ui+aM3Cv6hPYDohD0swEfgjB5Yi0MhJvRcJCZeDviyEnFYIYRM8wOvu2x2BIVDTrNWPHR+1aLfffB2zAVjWbmcqB8uOPxF/EgKwRoNKzDqxE1qK7bFI5KeG+QFLuDVeVesqjcDwQygAuA15aCx6coLWZxOaRKCCFJIunHVk5VFF1BP8J3iYDmHvNObRqVytpSypB2eAk7ThFUTp0/sT4VKgg1jjHZS0zEBJ14XUjfa2eRJaxHA2W3YtHpENMzbeh+liiv/B6Ieh4JTHniUA3w4hjgUM9SzJNYMsp93VySRjo75pmxCMQit63BDqND5PLINHSQtDtzS+W1PXuWi3s8HVhzuhsLhUWEJYakiV8n4h+3LevzFNvXLsgUsRDwu/q9YvszqyB1HtUsN+y4nBA5cHn7jMSFZXrlvAy2Ce+7Eqk0QSIDjTeXPTpYvNh8eCMn+fMlUsCSROnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWY4aGZrMGdkazA4M1A4MXlzR0ZnRE14V2VzOGorTnNXWFVSYmRiT1VWbFY1?=
 =?utf-8?B?REx3WTF2bm8yS1hLUm1NRGRrODNNTGY4bWVDYWkyRkdLanNsUyt0WktNZkNz?=
 =?utf-8?B?YVhvSko3U2RJeDRmdHA1TWdxWldNUlZJV2ZyVGtrOUI0TXZKNUNyM3hJWmVJ?=
 =?utf-8?B?MUNWSTZ2UndVM0FxcDI3UjA1WWZQM2tBbmR6eHowRC9JODY1MHVNNjBWSnc2?=
 =?utf-8?B?MmNqRHdURVpOY1Q4V05Rc1BoN1dmenhlWElZK1ZSM2RqOW81UjJnVE5oVFpW?=
 =?utf-8?B?c1NFMm8wbVFUclNpakppODVCRzdLNUFwMkJjZkE2M1VMSWxFL0RIcDJKS2JL?=
 =?utf-8?B?bDNaRFI4RjVGbVUrU254SGdYL243b2Zxb2RESUdleHBMMjV4U2FiWFJUbXBz?=
 =?utf-8?B?UmJZTVptaURxb1R6cFBOaTFZSWQrTk0yT1oyRTNBd08zWHA2anJXQzlsRjJo?=
 =?utf-8?B?VXN0cnFvV2c3N2FBcTV0ajQ2MVNsbEg1RldWeU0zM0w0MDdCQTd2cFBjSWtU?=
 =?utf-8?B?MEtEbW50NmhxY0JIVVRrYUNJOWRVUVcvYlA3NVRCUkdHcTBZNmI3NzNobU5X?=
 =?utf-8?B?ZExPc3UzOWQ0a2F6MjVTM2txQnJtUXRmeDJxNnVIVWw3MENzcnRUMWFoQVla?=
 =?utf-8?B?M1c4TnUzSElubCt3Sk9jdW1qNnZtTVM0U3ZIeGlFUnhUR0IwdEdjTVJISDRV?=
 =?utf-8?B?UGVBd2RJekg0M2JpeGtIWmY5MnV6S2RMQy9rRE1Ob3Y2aGhxV3BQeUlPNXpC?=
 =?utf-8?B?MHhJRFJzQVgyaVVkMDUzTVNNdGM5aERTaWF3MXF6R09tbjQ0eUNzZG9naHIw?=
 =?utf-8?B?MlJTVnlWUFU2Tjc0dVlzT1Ezb0xyY2F2aTZtR2RDVm9FblRBRmxoZUtCZ1By?=
 =?utf-8?B?SUgvbXllNjZvSlkvOWdXMTg5MHlsazMxNjhvUFZXNC8waWFPUmtVZnhZU2F3?=
 =?utf-8?B?aFRvbDh4NzRudVo2dWhSVGFJTklHb2c0U2FmUG8rRHlvWUFPdnkzRE1PVEM1?=
 =?utf-8?B?WUdJWDNOc3BCSzRWNFN6bVBseWxEcjRrajhObUkrTGVkTU90YmZPc01oR3BG?=
 =?utf-8?B?RHRrWHFYdktSUngvUldENUFrSW1kY2hwdTVDVkdzSzVHSDVFN0EzbTZEanhC?=
 =?utf-8?B?RG8xMm9wZmdmWUk1alJrTWo3YmYzK3M1dXZ6U1VGdmF6bDV1V2ZlS2lnVUpr?=
 =?utf-8?B?Y290TTd6KzcxL21RcUh6bVJ0OXYzNkI1dHBlTkJJZitVOW9BNTJvUi9GUStY?=
 =?utf-8?B?c2NoRjJ2N1hFNjh5ckFmRU5vcEpPK0pKOHNrSTFZbkV4bXgwcTBPcTRiUk5v?=
 =?utf-8?B?ZkMyTnFZKy9UMlZlSGNvUDZQeHI1WEpHR2ZsVkNxUis2UjY0NFNQM1loYzdR?=
 =?utf-8?B?Y1loc0F0eU94SnhuNnQvY2J0VHlpckNFZysxd3lTL1BxVHJhN0NnV2Rzd2pl?=
 =?utf-8?B?bW9MTmdCTlNRVlFmN0RudjNtOVlvUXg1S0IvNGM4MWFaZVJ1dmo0Q0VBdEUx?=
 =?utf-8?B?ek83QzZKTjZsVlRjaU1CdUpBMjl0bWd4aTZyRmhLRE1CVGxIWjZ5bmlDY0RV?=
 =?utf-8?B?RjNZbE90NVF6WmNaMGg4QXZ5QW5SOVRrOTU3YnZML1g4dDhhSld1TEFnOFJa?=
 =?utf-8?B?SVBVUkVHbzkrRjZBOFpmaHpMWG9Md2tJbXVUeUFNYjVFNmk0ZDNkdFZIZXc5?=
 =?utf-8?B?TzJrY05TUE9PeTVEVWpENkM1ZG5ObzhQdDZYU04zSTBWR3lXaCtOT3VGd0tV?=
 =?utf-8?B?Skk4Tzk3RVRCMWl0bElqZWxuWWxaOXZWTHhBQmduOWpVcjZlS1VxSzdKQmU5?=
 =?utf-8?B?QWFISlNveXdGQWlBczc0aDlmbldHQXdwanNRd1RGNFRXU052cklxblFDWlFG?=
 =?utf-8?B?QWc3NHhSY1NIOXkyMFlSWnZpUCtEMWVsUGlWVVJuMEZHQlowamVHM1JlOUpN?=
 =?utf-8?B?MEZ2Z3dweDBiSlB5MHc0MFpwQjVhS2dVRkZVL3E0ckFCT3c0Vzg5NlF3c0JM?=
 =?utf-8?B?QWRFK2ZnZDZEQjY1V2o1M0hqdTNBR0g0OTJUcmxCaTk5WGJjdXQ4RkE0RlFW?=
 =?utf-8?B?ZGRKNVV4V0VoY1FpU0VSNGxaMFpMeklYYi9KdXEvdExoVjZ2YWhmdHBJV3FP?=
 =?utf-8?B?amxuQVlwOWVHSW1MK0FPOGN6WVAxaVVDUUtSMHgwNlhQY1NIbE1TOEI2bC93?=
 =?utf-8?B?S1hzUElUVTI1czh1clFvd0NSaWdpV0JLaXg5Z0dlSUNTRUxRaEtmSWJjaDlI?=
 =?utf-8?B?ckloTTRsa0pNYmw5RUxZOVVtcWNDRUt6QzJOMmxnQ0RQb0szYTdGeEczMDgr?=
 =?utf-8?B?d3p5NGZhRjZCUXRXTUw5eXNmeURlZEoyWWNFUXNGeUVYaGIrSVBoS3QvR2d3?=
 =?utf-8?Q?WoXekWTyMhzbzKHU=3D?=
X-Exchange-RoutingPolicyChecked: HtalecnmzHjkvuI1G0CG/rkM0d2mzf/gBSRIwn1IfTLV+KvpXti6EZeN+ZYyEEmNiNGvhiBgGa/+IzBrLi/tIoTxvpsjjRplWqaQMw2cK8OvoJ9AGpFSIYafauSdlqhNxypJPFPwknl2eDMASQRlrLOA1+25c08x2TRp2ZEPVElQaOrn5jOnDONTEmAuecEb03ROG2daovX5Zuq3znaMktcucO+d0D14/XseTA52oplceuCYZnNADFXgmfHdVg6rR5gaoNYBkbnS4HMKJ2KEX4BI3HGqMR91w+BRMnzRoIfXuWfG/K/u69RIOMxYfaujRENAdSlp4xiGVEK8v2od0A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e41dedb-82d4-444e-3f6d-08df19693c24
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 11:53:08.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VEQeF8MlrSUBN0lH0j2d4LoLMlHPFRoGOhQpLZn0E7Qnvg8ljuFmqR49vzIboBr4tIODF3lYrkjM/5RmjWAa1Fh7un+ti+9w1JNZwZ2+Tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
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

On 9/14/2026 10:17 AM, David Marchand wrote:
> On port restart, all MAC addresses get pushed *twice* to the hardware,
> once by the driver and once by the eth_dev_mac_restore() in ethdev.
> 
> On the other hand, MAC address filters are reset in the hardware
> by the PF only when a VF reset is triggered.
> 
> Strictly speaking, the mac restore on port (re)start is unneeded,
> if no VF reset happened, so we can announce to ethdev that no mac
> restoration is needed via a get_restore_flags callback.
> 
> Then, move the mac restoration to the VF reset handler.
> 
> Fixes: 3d42086def30 ("net/iavf: preserve MAC address with i40e PF Linux driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

(with Ciara's suggested fix)

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
