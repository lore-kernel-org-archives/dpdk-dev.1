Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33562CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 15:22:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7647E402DD;
	Tue,  7 Oct 2025 17:22:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 943B4402D1;
 Tue,  7 Oct 2025 17:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759850556; x=1791386556;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0w/l5nqewSUY0Ne6oedRqg0gibaq6uffkaq+pVyon2g=;
 b=O7ELxRWt5sz/76gve0jOE7JROwzjHFTXd0z1c47Oym3QdY9EqYH1QdkA
 V3aHc+kqzf76d4dJuBUTAfy+MkSCtesszCHIjv/aV7AZGdFLfdc6Jb2VP
 IfjYmaahMyP2rp4b2IGI2Rl5yziO6sOIHHUIHd56/p0JuRjn2GiuBktTM
 4hIi/c8N94QRyhBByfIbL+mPnYXRMW7iK0HPeLlNeQ28rDP2/CAa+IMVR
 QW4fUvFEr+IBd/3xqbEPuAnpMBlJuO+qWQh43z7DUIo7q7Z21kq8xt0Gp
 7v1BVO81eS790M4sDfxSuMhTme7mUuHzNqvJwCS+2KkhXQHFV37S7Z+o8 A==;
X-CSE-ConnectionGUID: lHdeV6xLQCaBcHXnXS43xQ==
X-CSE-MsgGUID: xRi0OVCnSiab8vD6NmPRCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79460642"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="79460642"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:22:35 -0700
X-CSE-ConnectionGUID: Es9CH5IcQRGVAyqaQWBD5w==
X-CSE-MsgGUID: mr6/bGjvQfSi/emuVxmQ0w==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2025 08:22:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:22:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 7 Oct 2025 08:22:35 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 7 Oct 2025 08:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE85NYicTbDoLdBns2OqXrZEqoStHsApMrJL7pglUcIPppkk63+DbW+2ZuI/7VetrtZ2mtDiKYeepDStayA4PcwcgeFH8SQVK6OIcdFD46j9erOEIlrHxVNS9TPooifiEJoahJiXFM5pYI7KqZQl0iPZ9PkZquHyh666oYTyWl58fsLlHiJfSUmt934rhClIx6hnjywyPfeYmhTrOKDPjkrPqv0sWA5BpyBsoqxCIK7qRUmCLNMVQvrR/gUztx4CjzDD55IZ0j7hUUcO40kdzLV3sKK8FIgcZ0hhCCruTeZbkdcLL2Ti0YDV1clS+ljkpWXIjDCw9yny2zAVUcgSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOTaBSooc0p8d9S5Ih/ywUbg4mEF3zjRAtIVGFMRnnA=;
 b=uLVU29EXwoI5Daj5vLDkG7gVZhPqsnM0ehijTsxf7tLtTEJHc9wIySdO26WLVoTqpJuz15QGnEb03zjUgGa+7u5OVe+VuIE67Tlcqe0+DuKMXLK/JbZ420OPtLHxXUky1ltwMcrIKTaEfnQWYC0yOUdyt/Irz5eBUHWAPTa6QZlgp3keAoCeAnudqyU8z8Uf6xh/Eribk9xoSRzw612/I4RHBF7cEem240w7X/uw6wvLqYuXRStz16bANiOVv8LREXbhixiNIzAVd1i3InFmDLtw7E3/X4+WS3inSHfL8spQT0WDg87zJqvkG703NA3R9bNLbGi0pbWIkmh4LOCP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 15:22:28 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 15:22:28 +0000
Message-ID: <67090d9c-cb67-443c-81ea-899caed7022c@intel.com>
Date: Tue, 7 Oct 2025 17:22:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net/ice: fix memory leak in raw pattern parse
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>, Junfeng Guo <junfengg@nvidia.com>
CC: <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
References: <200ebf9129483347f6263f130e167ff7fa42e7c3.1759840924.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <200ebf9129483347f6263f130e167ff7fa42e7c3.1759840924.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0009.eurprd04.prod.outlook.com
 (2603:10a6:10:110::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 37db8577-7a8d-4357-1061-08de05b553b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE5yWUlqUlJOQUxoWThGd3p1NW5sNnRqRGRWaFEyQTJsNlBiYUUyaFBCYWdM?=
 =?utf-8?B?Q2tIc1J2THFiZ2d3cXF0elBKaFFxLzVabUk5ZUlzelE4ZUJWMHVKMDNEV1pV?=
 =?utf-8?B?Wll0QWpwUGxYdzlZaStRNHY2enpJSVY2L2pxN2NGRDVhU2ZBcjFEbUZlTU00?=
 =?utf-8?B?MDRxT1lQNm5XREN5ODdCNlhCSEF2bk9uNGE2RkpValJSZ1R2a0RvaFZzbXFr?=
 =?utf-8?B?ODM0YkY5dDUxM3dIcGU1RnhaVXB0NHF4dDlZZGJvbkRvaXB4TUYvaXdtWTJt?=
 =?utf-8?B?ejFGeHFUOXROWm1HT2hveUM0cUlISTJtaEtKU3d2REhNV1EyOUJqb1pBSlhv?=
 =?utf-8?B?bVBmR3BVdzV3SjU2dHhETUpUK0YxVmxzMTZ1WnkvdzVaK000UTVBRVVtQy82?=
 =?utf-8?B?c2o3RERUd29nWWdsc09CTVlidmxldTl3dFpManUybEd3WlpNWVc1SXZLbDdF?=
 =?utf-8?B?YzdhQkJRME5MY2VEQkhzM08xc2duUHQvZEdxMFM3bXhLRGZBTVFLSVJQUHJU?=
 =?utf-8?B?WjU3UUxBTDF0MlF0MVRMQ1AyOXhxT0tLNTh2d1F5dXRCRlRkMy9KM2NLdGNz?=
 =?utf-8?B?Mmd0Mmw4Y1VjZ2VlSWNjTkRiVnc0RGthQWNpWGpYc2gveC9ubHJUZ05VaDg4?=
 =?utf-8?B?ZTN1d2F1ZTZvL2oyRTgyL2ZpQTBudHR3S3pMVTdYWVhJajVnaFVjV242Z25p?=
 =?utf-8?B?dzlIcllGYUxpZ0x4azlMaFFvZmtjN0dtOUxjZE51dEMyYnYrczN5aGpkMlN1?=
 =?utf-8?B?THVyTWQyelM2dnNCb1NuSzZxcEFmY202TEFTckNmd20rZ2xob0lVS3R0a2Jq?=
 =?utf-8?B?Zk81MVExcm1CQVp3aEpyUnZUNk14eGxpc2R1VzhGKzgvMkV3TWhHbEFReG5T?=
 =?utf-8?B?RkVJaEhoMGt0R2FIcTZPZUFucGFBdDZZY0dBTlh0ZnJ1NE1Wc1ZRTVc5c0dE?=
 =?utf-8?B?akwvYWpuMWVISDExM3BFeVliM1pmRVpUTy9oR0FmL1JYMW9DR2tsRnlVWGhD?=
 =?utf-8?B?MlZyRDJZRmx0QUNxajBlRjV0WC9jekRHT1VIRG9BR1ZIU2d1RUtTblAvbkNs?=
 =?utf-8?B?ZWlLRXV0TUdjOGJXbmtzditYQ0F3SUNkKzlVNUoyUmU1Qkdhc1IxQmFEZEh0?=
 =?utf-8?B?WlVuUHdER3RseTZpYWJVMUJtUjRBM2NuUjIrdldKdVlTQ0d0Tk1ZaXpHZDlR?=
 =?utf-8?B?RG5kSkcxcEVXdTN1WDhuMzBLRHNpYTFjS0I4MUc2bzA3NDNJRHArN2d0YjJ1?=
 =?utf-8?B?TlhMaVlQZlY3QTFjZEkzS25sZFI0cUY2SzlWNkZZZ0R5RFVjL0lkOXY5Zkt3?=
 =?utf-8?B?d1F1MnYxNmRJOTRPZE40NWVEUVZYMXNqK1JCZjA4Ui9CRFBqOHdYeDNrUHRD?=
 =?utf-8?B?YUNyMVZBaFZYUWM2NTNIREk1SHJuNTBPb2kwTDRXdTNWWXl5alhSQVV6Mkdo?=
 =?utf-8?B?QkszWkFpS2g3Qm1XTEtYQmxRWldtZzZZOEsvMExWUWJQVGdPZzExR2hhVUYx?=
 =?utf-8?B?T0UwMDE2ajQxcWVCOXkySEJqS09WdzNJRUdvRUNueXBpMWZnRXJoVzJCRFJB?=
 =?utf-8?B?NWVEaVZtVjFBQTVsWEwwSHN6NDRYdkMzalM4WWtFMmE1QSt0eHVCWFBFSFpk?=
 =?utf-8?B?SVM2ZkZ2eXp2dFMvV0I0NHNaYzNPOXFOaWxGMlRibU5JYjZTMWgzR1VZeFhw?=
 =?utf-8?B?M25GYnkxMStvKzhydzFVWGlTNWhjaW4yMnc1WmRuVDFPcDQ1dXZtc3NwQUp1?=
 =?utf-8?B?T3lIb2J4U045OUpmVzloZk1WNVlLYUNLZm5EYnQ4aENSbnJ1ck1JZnlVTDAz?=
 =?utf-8?B?YVhFdzVjb0hEdXJzRElnZDdsQTZvNXNIcWF2ejNBN1l4aCs5VXBIMjI2Kzkx?=
 =?utf-8?B?TkxWTVBHY25rbnFacHEwRG9QMS90Nm04NWt0OFRZOHRFYnkvZ3hDMnRvRldS?=
 =?utf-8?Q?ACCWfO1cJY/ZQyR9k44dcmXGk5N0IPOw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHl5ZHcvOW1TS3VBY2dkNGJFZFBxcGZtd2ZIOEdMNUt6cHNRR2lWODBPTkpL?=
 =?utf-8?B?eVFOdWJneUY5R0k0algrd3dMdHlKN0JyaGxPNXRLL0tpRC9tLzhWU0ZScmVx?=
 =?utf-8?B?WE9LMXB6WVIraVZqNVFyRG1xYzFqZXJNMlRXRVVwaVlvaDZZTkVGdHFibmQ4?=
 =?utf-8?B?NUZzSGd3amRWRnZiNnJPRytaTWpkN044bk11WXIwbmVxN2V3SVlEeGFCblBq?=
 =?utf-8?B?eUIybWpoelJIK0U3enBxUStXREtMYXg0V3NDZW10WHIybzQyQm9ncEw3T0cy?=
 =?utf-8?B?YzQzMlVsK0NNUFRjcUowT3I2RTJSNVIxVnNHUGxHSDBzaVJHeXFJU1RGUVlx?=
 =?utf-8?B?SlZ5YW0ycGZMaStnL3ZwU1VmZmU0NkxaZDRRY0lSZ05HMHltVGYrMzYwQUcx?=
 =?utf-8?B?V3FacitsYTBIQUJ0TzN4M0VhdlRUS01uUkVkYmpUajgrVDIxNDJSRW4yanJU?=
 =?utf-8?B?UklTZ2pBcGxPL3Q5a2ltbTBSTGtiQXBQUWxEOXE4VGNXVXJPN3BxcGszSWNu?=
 =?utf-8?B?Vmtid2g2RnNNZTZ4RFN0TVA4aFNvT204Ry9VaHI2WTBsUGVvZjR2L1JGNFB6?=
 =?utf-8?B?V0JrMVU1bkNkRTczQStoSGJkSVEyR0RFMk5lRGNNNTQ1NXZTNW1iZTg4akZv?=
 =?utf-8?B?UllWUDZWS2VybkVmRWltZDlqV3B2RHYrRm1uMnJsbW1Kdm9ZYld5TDRBdVMx?=
 =?utf-8?B?OFluY1NLOGR2ZU90c1k0MWdQSldNNzUxNHNlcEttZnRmK2xQTHAvTWZGNjc3?=
 =?utf-8?B?YXoxbnFLWE1zQlpuR3pKNTl6Y2piV2lSOGUzeUdlZzdjblRsZERPVHcxNzkv?=
 =?utf-8?B?QnZoaG1ESVNoVWw5MTJvcnIrNy9nL1VVbEhxNFYwNmhqMjZGOTlyU0VhZjY1?=
 =?utf-8?B?d292dTR0UEpzR24xbUZxU0ZzUGg2MmJFWTVVTVpGcEFnUGJwUEpBUVFaSUNy?=
 =?utf-8?B?TGR1dVh6clQrdlRBS0trSnVrWENEdnJZODRJeHZKMnlwZ3NhSHFCT3JMTDFO?=
 =?utf-8?B?aEpSU2wzMklKVWlNZm5jRXZTNUFBd3hsUVFGeGNGQ1BOdy9qY2hDT0NGS01u?=
 =?utf-8?B?a2hRdGNxb2ZKOXp5cG02NktDOXBUV2c0aStubEdZT2hPM01na3phWkNOT21G?=
 =?utf-8?B?bUVmSFBsNjNGTzNQbzNFbkVvN2JnRUpqN2Z6aFFWVUpUeG1WQytLNnNQLzBU?=
 =?utf-8?B?bUxQUGFnVHYvbFUzOWtvZGdrTFNoMzAwcUhQZVJUb2JGeHd5Tkc4aWhjTWp0?=
 =?utf-8?B?L01zSEpOdjd6ckRFaEpoQXJhNVlHMFh6MVZMTmIwMnVsWm9VRGF3Rng5RHNE?=
 =?utf-8?B?Ri8xdWEyNEt6RWJTTmM5UUx2T2xVTDEwZFBTdEVUN3lHUFh2ang5am9GWUFN?=
 =?utf-8?B?cEQ5a2JhT252ejFBUmt0NVZFYlg0TDlNK2RVTUw0RG96UWZVd0lUMWFHSmcy?=
 =?utf-8?B?QU9CYnFnd0g3VEJGY1ZOclY4ZXBHMlFGYWpJM0JXcUFUeG1yTmJ1b2RxU1Bh?=
 =?utf-8?B?MllHU05wN25kalpZQW1ZY0U5U0Y4aDVBVWJBQjFZa0VsandOdGhpa2MxeFRp?=
 =?utf-8?B?RFRIZk1YR2xMeFYveDRyWGNnMEJSaVNvSDQ2MitTYmtyQXJHSUROTWJyd1Zq?=
 =?utf-8?B?TTQ4dlBuaGs4UUd3OFhaVmNOcUNaQzMvQmM5aTIwMll0RjJkVG53ZVY5SXo0?=
 =?utf-8?B?aEV6WHA1NEpxK0dIaHVCalFyclBwbXE1Yk1qYzR4Vk1Gb2RScGhvdVBsWEFN?=
 =?utf-8?B?V1VSNlRoWGtkTjVoR1pKUE91bkNnMDZYc0hZQWo5c04zUHNCTVZ1OVpHTmhY?=
 =?utf-8?B?ZTRMWFlpRTcrZ3ZVWVRISExJQmozZXROeFBUVll0Zy9rNHVvdGh0Uk9TR2oz?=
 =?utf-8?B?bWZpbVJGRVh0VDdWSCs3S2gxdzQ0MlB0bFBtQ0lJTnlRbHh6ekgvMlYrRzZl?=
 =?utf-8?B?RkJCN0pJbExzOVUwdWkrbk9GeHBhV1JxTmtJeXBjdVlsSy93RUR3Zm9IWXpy?=
 =?utf-8?B?YUtzckgybWJnTForUHgvSVNOcXJYU1h3c2dzWUNQZTV2SDh4cUoxSlBWVDZ4?=
 =?utf-8?B?NW9sS3B6QkJkMWt1cHFtbWhPRHFlVFBVOExMT0w4TlpXUU1YaXBaQmNoeHJD?=
 =?utf-8?B?MUFzUFJPVW1oNFN1OGNiQ2JjWTFhKzVNWWVZUW13L0doVmdaVlJhd3dRTm8y?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37db8577-7a8d-4357-1061-08de05b553b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 15:22:28.7391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkPfVa/8I5p2+uXQVWptqhiUh4W4gOMphnS5lqzxgjn83npQ8je+Ko4ANYahosSFQhVrkLI1jmiY2ch+zOSyUttylB7YNaFsN2DIlO5/imk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
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

On 10/7/2025 2:42 PM, Anatoly Burakov wrote:
> Currently, when parsing rte_flow raw type items, we allocate a bunch of
> internal structures, but if errors happen down the line we just quit and
> never free the memory we just allocated. Fix this by adding an error
> cleanup section.
> 
> Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 

Fixline might be incorrect, i need to dig in a little more, as 
rte_malloc calls weren't there in that specific commit.

-- 
Thanks,
Anatoly
