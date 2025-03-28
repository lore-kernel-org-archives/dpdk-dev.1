Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D4C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2854E4065E;
	Fri, 28 Mar 2025 14:08:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 93DC740269;
 Fri, 28 Mar 2025 14:08:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743167295; x=1774703295;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IuSgZHbIvf+4CXg12lGF8X1oFPzumHP6t9vqTT3FGko=;
 b=E183todAr7Rt3kopBu7w/JudYQo4SrgIOKbWPXMjeZBv4VI0id7ZisEK
 vMi1SCmoAWUyKiccbqzmN1THiyeURKScT7kNizdtwdkmglPwCnoUW2TJB
 jxBrg1RR/aATrse3c7iwkjoLTS8EQzDKreerrFuiS2uSdhjX3Pzh8pU2t
 tx/4TXEcNksk/qMFen6n+0jjAB3J79DomQT6O7J0tvEs9Xtk1xJIRZ99s
 u2LFe/L6BO2iHBhX60qDhHhjX4Rg6Y7bHyzfp9IkYHCj/z9mZ8npdPCbk
 u/1ohq6YiXcCkgRfbkd5lwkZwuWsbOs3an0GQceXh+UROrSNad2MPBcmC A==;
X-CSE-ConnectionGUID: yjc3pYTMQ8+0iva9lwbL7g==
X-CSE-MsgGUID: 1i0xCpmZTimATse5viUXpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44634006"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44634006"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:08:13 -0700
X-CSE-ConnectionGUID: 52sd5aNOSVe1Vv+KSrA3OA==
X-CSE-MsgGUID: CuwBK2z8RbKKeqt3TbiuEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125342978"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 06:08:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 06:08:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 06:08:12 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZxNfH0BFbCJc2LzjHNfhX4qEOxeyrxOcoWVZMH0/rkE8bysYI85Y3LJdfPyWGBtOwMZyPv46LSAMMaQGWg/65rvxWlzpdzMn1kzZ+3YmEC+ClRSvfXB4Q3JAl+811D8s+z8hw1eZnjDD7CzPCoJ2oB/8KK7Nn9xuYKx1iSaNqqV71+Ps1fdEC/GD+e5o1oH6P/u6THPOUH5aqafJ4Tw6t14Q7r8jZfvfpT3kCwRffqstqcFLe0xi0BW6Hb5Gkp7bNgLraa1jvIlrN6Yy9KTfTLZ0+7oKZdGOiwbRod62a1pnXQookDS44qpPnfGBaTB/I+IW4uFwVWiyGXT+b/zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNJGK4iKpvrhsWj1iI8b/OAXfaBq1zObms0s+qj/a7U=;
 b=pp/lWkbhrEp/x6L25klcIwt0A/lM2rRcWxVw3SFJoJgphbb8EycKjbCD4uscoNsi03lBVwLSNWWhiWxb8R2TTQYHUJxDAqdepzRgKEwe2oBfFEGa9a+t09N7N5l3YZxWQMFUAvYJ7GgfDrN5RLo4pvrlyGapnVzWtcvoPFAXjIyZWFDrl0EoQfVTn4/4JWQTaZyrM+HouUpJm2Je1QaOi1LBQ/pSaUcHFqJAkZW8j35LGuKpabCCenrvgdN2JQSyZS+eIsbVconb5V0wIE739tjBPrxXLEWiRI6Qed1MSh5I9nt6uNLyngeY+yNSHDRsWdL04ks5gvfTRKUZ2mys3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 13:07:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:07:29 +0000
Message-ID: <8b72d751-84cc-4ee2-9a81-5c4ba6408b02@intel.com>
Date: Fri, 28 Mar 2025 14:07:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] net/i40e/base: fix unused value warnings
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-7-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-7-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: c4879d9b-a185-47be-e293-08dd6df97e29
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGVIaVhJZmlLUHRPc2RuQlhXY3pYZHFScVpSNy9yU3FVR0NlMUtwcitOL3NH?=
 =?utf-8?B?bEdVZWpRTGlSUGlnelhaS3YrQnAwNTZoeGVsdXk3Z0d6K2NpbWViT1oydFBU?=
 =?utf-8?B?VWJHQU16RDFnWWpabkI3OVdKUy9FS3lTb1hWZkx0RGdkQWFUd1VtNjFDRUlq?=
 =?utf-8?B?b0FadWFoVXZWZjl3UVM3NzJzS1RjTmRKbms4bkJmVWxhSXJ5bGxjUHdoaitQ?=
 =?utf-8?B?T0N5Wmw0eERoazBQUUl3WjczakE0SjRXcmR0WkdWeDNkK2NYMUZ5UytkRk9S?=
 =?utf-8?B?UHdBem5FcUM1T3o0TWVjSklxS1NDLzB1RW52M29vYUx4NzBQbnZzVWZ2eU9G?=
 =?utf-8?B?MlBFd2swdzM5N1A5TklSVmpwSUd1d0dOa3ZSR0RJQ2ZHMU5xUGt6WUtsQVVm?=
 =?utf-8?B?VzgzTWlaYVp4anNCVEtVMlV3NGVKZHI4eTJPVC81eUpSbHhLOXBDYys4K0Nr?=
 =?utf-8?B?a3pJWGFwdVRSWEtydHdWZ21iT0JNMHNYSGNaRGpLd1V0LzJSZmhlY1BGaDhC?=
 =?utf-8?B?ZmJTUEFpY3BHb1lkaXlpeTI5ZTR1OGVrclNKQWNEU2xweURrUGNnaUhGdjFI?=
 =?utf-8?B?YVlyaFJ6KzFuL2o1bXUydDV1cWZYckZoRzRFWmJ5ZVJuUFFWTGZYZWdTUitZ?=
 =?utf-8?B?VUlBK1k0U011OWdrSitkKzBOeEVjelhpNGlYWGNTWmhGWFJkeGw4aExPOS9r?=
 =?utf-8?B?aythaDdSdDJkWTRDb1JnK0k0WXUvUjQ5TkNNMEpSaWZRakhLeGR1anA0MVhi?=
 =?utf-8?B?eER3bks4MngxV3ByNFh6T3k5azBFOGUyZytrQzR3MjM3QTdlM1V6bmIwRWFy?=
 =?utf-8?B?YUtPR0lSZUFOWVlObSt3TU0wdXRMd0MxYjN3bTYzeXpRNyt2Qk5YbGhicGNv?=
 =?utf-8?B?OVRrVENNRkp6Qm1uUEZQKy9VSzJha214ci9sejNGYzVabW93c0Z5R0I3MU5Q?=
 =?utf-8?B?V1dIRGIvRklQTmRVcVYwQUJmeDJWdlVqenRkaWRLTWpvbGQvZ1pGQmR3QmJX?=
 =?utf-8?B?ZmdjYVBsRjVGZGwxS25udHVWNXRqOEY4NVQ1RUgwanJFcUd3NG9KVDQ3dFZn?=
 =?utf-8?B?Q1pBOEZOeVlWSkw2K2E1bXQ5ZVpvVzJWNmlxWjZjdTZORlZ3THZPcmorUXJw?=
 =?utf-8?B?MnlPSkVCMHJxYnZPdGtnc0phcDZtRTdKaWtKOTB1OXlQU0FxaUJmTlNrejFv?=
 =?utf-8?B?UzgxaG5mVzJXQzNqVkRQM1cyZWFFZVJqeEgyUld4SjJSdi9vemUwLzVJVkM1?=
 =?utf-8?B?bGNIcVNWUUtTQlB4TnZxWHppZGlsOUY0T2hDVk52Rm9sN05LcnBnck44anZC?=
 =?utf-8?B?eTNmamdYN0haQjhVM1Y2ZVJYdEc3OEkxZmRrRWZNL2twaS9CWk01ZTIyY3hH?=
 =?utf-8?B?N1JkajN6UEVkQ3FFUWtOOExCdU1yREszRXZrSGJ1eW9tMzFYRmJHNkpWVVd6?=
 =?utf-8?B?TGhsNjVGYjNldHdHQXBia0pPWG5WSWtZYUpvNVVWMHhzN3hoTVRUYTJrR1V3?=
 =?utf-8?B?cDVkZVZ6VlBKOXNOckc3THNFcEs0a0pYRE1NMWFVK0lucnBEWnRCSXVwYmxi?=
 =?utf-8?B?OS84MlBnNUhtbkR1dDlBQmpicnN1bnl5bEhjWkR1dFBXdDc0d3c3Q2ZaeG1a?=
 =?utf-8?B?cCtkS21PYUhub21ITVhzNXhnSTMzL2VsT2s2VytOb3M1TWYvYnB6Y3E5VUcx?=
 =?utf-8?B?NkJwTCtGU3dNT3ZxbGRyLzVScGlpRkgzbnBIYkRDSnhTekowOTlOa2tFZTJv?=
 =?utf-8?B?YmxGQkxrc3F0MHltMUhNY2N4ckFhTFRqWGY4WVNkTXUrOGpSNndyM2VLeUs5?=
 =?utf-8?B?NGpKSDYvanZEZ05oRU1FRVZvVXE0VzZZYS96bHFsR3p5aENSeUhZRkFvUSs5?=
 =?utf-8?Q?HUgJCY55gXupl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG16MEVUTzhaRGdXK1BwS08xTENJd2hEQnIwbll5WjZsZ210bzJsTk80emFr?=
 =?utf-8?B?SjduSHV3RVd2R08vbi9YMDVtSVp0WGVUOU82Unk2REprRkc2VXRUUm9tMElO?=
 =?utf-8?B?QTZINHp5TTV3UVgrSUZDNExuUDZSRDBXZy84QVJKUERYbVovQWxWY2pRd2cx?=
 =?utf-8?B?Z2hxb0VoVmpFb2tENVJXZE1vUGlPeVpYR3VENitOYUtBODZKWlBaQ0Yrc2c1?=
 =?utf-8?B?a3d1OEFDSnFid1FBSzBnaU9WdDBYNFpZTlVoSTlETTR4ODNTVUFpRWFWNnVq?=
 =?utf-8?B?bjFPNlg3ZXBDaTAxYVI1L2VlYXhuaGJnaVZhTG85VU9wSWxKZDFXS3RZSVZM?=
 =?utf-8?B?V0gyN2JXcUNlK0FLbFhNUEpxbkR6Wlk4TEl0NWZ3cGxDejY3Y3NKRk0ya1Fv?=
 =?utf-8?B?RFVlaURrbkd4WmxqS25TNFJ0aHBjU0pBcVAyK01JZm9NNS83dlJMMTRrRWF1?=
 =?utf-8?B?UzhDa2xpdWJ4YW9TMWF3QURaWk9NcjcxaUVwSTZCd0ljd3BDZlh3OXdPcnRJ?=
 =?utf-8?B?OEpuclE4bDdhTGRreE9mbUIzam8rb0NkNDBZUnVJRmRGVlhTbWhzSjBkd1ZT?=
 =?utf-8?B?M0VHM1J3UkRPaFIrMm1uRFBWVGdaS2R6RWswYmI3QlE0MHUvZkkxR2ZkOXNX?=
 =?utf-8?B?UndQem56V2txZmNyVDhibnBiRHNZc29WTjM5UnBCbVE3YW0xZThxWUdXTTJE?=
 =?utf-8?B?a01hWE5ZRHZ6SlZKTzgzV3pTRFIxblE1RThLL0swUFJ0a0R0OHhwdjF2OWUy?=
 =?utf-8?B?RTY2ekhlKzdOZldTc0hpc3lweFZNSzdrMGN2RHNhM1dhTVB4RWlsaUtJWlZq?=
 =?utf-8?B?anpIQTNRdHdSNlY5RVJrcTVKa3JYK3FzV0ZpTm5NRzlObGh0aEJjcXVjSlBX?=
 =?utf-8?B?K2IwckdtVnF5bldIYTNHaGcwQUV3bzQzYlFYcGllL0J6UThZSFkyQlJiM3d4?=
 =?utf-8?B?bFBmUVFZK0FTcnhaQ2lpaVZLZHNvU1Z6aDc0WmMwZFJ2cmhOYmhsSTdwZkVj?=
 =?utf-8?B?RVVaZ29ZaHh4bGwvbUlLc29vbDIxZDU5UnhSVjVkaStBclZydHg0bEpidWND?=
 =?utf-8?B?d1ZTbTZxRUhtRGNyR3dxaG1lRnRPbHBXZEtTRUtRRms4WkxlWkNqYnRKL1dl?=
 =?utf-8?B?OFFGcFVFS2J5ZkhibU9yejB2TmN4RlNIZi8wTHlIbnEvYVBtN2grMVZadVFr?=
 =?utf-8?B?WGZYMkx6VUV1RHdzeFdBbjg3YVZpUEtxM2VDVS80WWRmdHNhUy9vUVZsa3ky?=
 =?utf-8?B?czVqTmxZNnlJYUduYlBva3hDR3g2bnlmSVhqUFR4My9PWEVCcnRaYXdPVWFx?=
 =?utf-8?B?QmxJRTVBVHhmYXU1TzRiekxRSzRLUStsSUlNTmVBV1FETGs0T09XZy9GSFc0?=
 =?utf-8?B?aGMrL2xhclczY1lUSFM5N29TQlREZnpSRldKMHFDYyszOWhqUkN4ZjErTFFx?=
 =?utf-8?B?U1E2SzV3aE1BK01ndWUwOWFPRDRCR1dhcG9kRGM1Q2tCTFJrbTRpekRJcEpR?=
 =?utf-8?B?S2JZejh4N3h2cWYxdnFzQXlub0ZyZkIyMmNKTkFSb3pJTy9IN0Z0MDdhTUUr?=
 =?utf-8?B?Y0ZtdkJXUHFPMDFPT2ZpSktwSGlPbXhuR01TcGJBTmVvaklLQUxudkNTRDlk?=
 =?utf-8?B?cEdkVlRkMEE0RG9NVWQ5a0ZBc3JBKzhTQmJ4RW1IVFl0VzFyTGtFbVU0bGFu?=
 =?utf-8?B?Lyt1QmZ1UTJiRlZ6ZjY5RWJuOE5VRjkyejc2MTB1aXhabWVORmtIMU5JZURh?=
 =?utf-8?B?ZXgrbTZtcXYwOVI1TmJ3bTZPbDIrZ1I4RzV6cWt2QTdudytqU01nMlFKVmJp?=
 =?utf-8?B?bnROMk1RTS9PYkdnOHJIVE9oWTVFbDZlckdoby9JOTNXNDl3SXpRRkZMM0dJ?=
 =?utf-8?B?aWRzVTF6aXA3NHcyWkZSWUUza2l3MVc5aWtRNXZyNTlKVXMzcXpWZnlJdUp1?=
 =?utf-8?B?b1lBTzEvSnBhbGVSWFRkd1BVQjdaS05kYXdNN3g2TU1RejErd3EwNUQ0K0ww?=
 =?utf-8?B?YmVYY1J0U29rSGpzYi84dGlMTG5hZlNVME1TQkVyengrWTZlTmhabGhMdnd1?=
 =?utf-8?B?QzFlUmwxMFdDMEdFeDJiVHZmWVJFVXJYM1F4REVZZUE2UWVTY2ZTcDJ4MG52?=
 =?utf-8?B?S05UTFVkeldGY0tXcHpIcGJRRGFFYlBEaEtkdTRYdVZ0VVZmTzdwLytjM0sw?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4879d9b-a185-47be-e293-08dd6df97e29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:07:29.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U83BWRXQkFXXn5x8zTQmJA7IAjRI45rKI677Vs1DkxzZGFpcG2IUSeIXMDlvmPmi2OFTdsgcElxj0Wf7dHKgUWJe4e/4X3DTmm1dsHcloAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> Fix warnings about unused values - parameters, variables, etc., and
> remove the warning disable flags for them. Although modifying the
> base-code files is not ideal, the changes required are minor, and only
> affect two files from the imported base code.
> 
> Fixes: 8db9e2a1b232 ("i40e: base driver")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/i40e/base/i40e_nvm.c   |  2 +-
>   drivers/net/intel/i40e/base/i40e_osdep.h |  4 ++--
>   drivers/net/intel/i40e/base/i40e_type.h  | 14 +++++++++-----
>   drivers/net/intel/i40e/base/meson.build  |  3 ---
>   drivers/net/intel/i40e/i40e_ethdev.c     |  1 +
>   5 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/intel/i40e/base/i40e_nvm.c b/drivers/net/intel/i40e/base/i40e_nvm.c
> index 3e16a0d997..56dc4d9279 100644
> --- a/drivers/net/intel/i40e/base/i40e_nvm.c
> +++ b/drivers/net/intel/i40e/base/i40e_nvm.c
> @@ -1743,7 +1743,7 @@ STATIC enum i40e_status_code i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
>    **/
>   STATIC enum i40e_status_code i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
>   						    struct i40e_nvm_access *cmd,
> -						    u8 *bytes, int *perrno)
> +						    u8 *bytes, __rte_unused int *perrno)

I don't think we should be adding __rte_unused to base code, there's 
probably a macro for it in osdep? If not, maybe add 
UNREFERENCED_1PARAMETER in code?

For other parts,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
