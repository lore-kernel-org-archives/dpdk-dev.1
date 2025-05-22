Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08418C54756
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 09:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1883F402CA;
	Thu, 22 May 2025 11:06:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id EA4D1402C2
 for <dev@dpdk.org>; Thu, 22 May 2025 11:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747904773; x=1779440773;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0yLGWuI2cEzVcEyjfUwMoqqIVLlNekQOO8M7gmpjTvo=;
 b=AOFxKrjQy58tkeHD85Msui/9j883UVJXT/LOK/zzQEDUuxCFf+Xv07qF
 2KHvgJhNtm1OgSbyzsftMOVohp5ort1iAPDhkTBlR1Z0KzXN92kRLPBrq
 cIgyaDHF8YM6VjafOl04/B5Lm1SRZYUSILkZBOJlAxVbfXFt00MvD0vL4
 tV6Xj95aqhs7uDw4vgCFFtEskxJ0NBCvjPheCovkGCR1oFRqvNH/CTD7z
 rbfcthGPYLjhKk1ULl2Cb0pIa5d24zOXbphCCtJT+KNafgW06KVtVYEDb
 ttSmIhcKJQ9ey2AmxiVY/A6iI8blkPllYZVMhyfoZO2mpt+98s3+Qv6Ev A==;
X-CSE-ConnectionGUID: 0PgsexGZS8Cu9Gx4+mdetw==
X-CSE-MsgGUID: 73Bm/isQRRS5js56A8XbNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53713556"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="53713556"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 02:06:12 -0700
X-CSE-ConnectionGUID: 2RyoOcwoS5Wt6dOgLHrYdA==
X-CSE-MsgGUID: hEXedSvzTQ6lUokSoUDp5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="140577243"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 02:06:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 02:06:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 02:06:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 02:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIUESDQ+eUHqK6NJ/9cJUlxuWnRjCmBmtCyV9Pg9Dx6gaBKPWuYDauJ0E51uqirCEIToJs4EliojQZ+18RCsim9NiK06qZEFSZ19owzVh6mcL2WPx1Bq6pvhxxsrrhyA3xzOqIdOCJPbVMHYLjmp0Fx2Go12netIDjJN0MYeMH/xgggyRynwsqflBxBAy+rlBtocdcvxjnRjpaYMWyHd2TYhnfFgJVTCTwVnuwnGnv1Is54X4vsnjp5wpR3kACb8tIeVNjoaGucCyDAuoWWkLJPfEO3wuhtk+SDGO/OAM6gb3OUwcTZg0vUARA4fCf5eFgsksQmceeFgpR5ycxDmAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE3WCQRK0ZXI5wuSZJf5sZrepoZsXe4e9/36/fb8S5A=;
 b=iumxbQtrFdP5Flvw5krfZqnQ6Ksp2oUd3UBK+Wy8BOBx+jWBK3eA28J4fhBxbk87IJGmABPyJFSIPN0r49RZUuSTsrHxvfn+eMquqYGoQ3/SSN49TFG6FCghcjkzhv/bQaq79+2/XSFTd8bo43Ws1Yn4ae+1BRz4gQPgWUPY4UCNyfo6BFmO6bk8iSSRFwbB03YvOG9RMqg74JyuhI8xDzHPC5/mmr72zcA8jl5o7Juwx4HUwI6BoZVJZze84/AWTl22jyHtx3boxX6VR1+WKxAuUkZspz9wW8UpQ1dM2EajrtLTQTEKbNNQ5vpVDjGxcAEbR4iEKfDUvsYhvo2tBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 09:06:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 09:06:02 +0000
Date: Thu, 22 May 2025 10:05:58 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ali Alnubani <alialnu@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: Addressing git.dpdk.org downtime
Message-ID: <aC7o9q3zGx9d0FG_@bricha3-mobl1.ger.corp.intel.com>
References: <PH7PR12MB91737F14D62A8ADDCAE475CDDA99A@PH7PR12MB9173.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR12MB91737F14D62A8ADDCAE475CDDA99A@PH7PR12MB9173.namprd12.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0232.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9e3231-dc50-42f1-0918-08dd990fe041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFZGbnRUVjAyWURCREN2dmpMNmlaRkdlRDRMNmRBRmdqYnlaMVV4d0pwdzVi?=
 =?utf-8?B?aGRwbEhCckVZVGpRV2RyYVBteG5TRXNBdUVwVVZ1Q0J5ai9tMUhTOHZ3NXlU?=
 =?utf-8?B?K3lxdGdwWGlOR0NpRzF4NUsxU1pXb20zdm1FL0hkRXQ4QmZGRVdzNUcvRGtm?=
 =?utf-8?B?bElxdmNsb2VLZ25IdG8yN0YxdWV4STRXVEpyVXpBM1Nycnk2bmtoTWlOYXgw?=
 =?utf-8?B?RGIrOXQ5bmRmcjFYMGxlVEpmeVhBUGV0RzV0YTdNMUZTZnF2aVRtcmVpZFFN?=
 =?utf-8?B?MWR0RDZMS2szOHh4Zk5VUDdLVENncDhuNXVHM3pvbS9jaFY5ME91QzlFYlVQ?=
 =?utf-8?B?WXdYczRQLzZ3cC83bU5oSmVpSkJoYUlDcGcvVmxJK1gxbXhjQVk0VVh1SjMw?=
 =?utf-8?B?alFZTXhjaFRmakNMbGYwUFdSUkdNSDZZRiszS3EzNUdpbmJ6cHQxR1liaHkx?=
 =?utf-8?B?R3JWMFJWZXUwczAzTm9rSERHRFQwc25Pa0xxZHpROCtVc2tkVlJCQno2bStH?=
 =?utf-8?B?TnFhWFB0ek14UEd5TEtPN1dTY1ovY2U4T1ZHSG45NGh3MVlVRDh2N1pEWFlK?=
 =?utf-8?B?SFJQK3FJQ3AwNHRJbVZqUjAvd21oL3VsYVc0L1FGQUk1UDJJajVBaWV0Slpv?=
 =?utf-8?B?SjYvSUdRTUtwUXpQcm93MjhZdHN2Nlo3S2J2YkJuWUhIbjMydUQ0bnUyK0Zt?=
 =?utf-8?B?a3NPT0Q2V1FUMDBxUFpWMm5XalB5VmtGKzh5WUxEekNiaytNejFJTTAzN3Fr?=
 =?utf-8?B?UU9SNzNTMldmS1JqS0piY2FkRGVnRWdyWFJjVkxEdUI1Y2J3SEpCQ0JGZW1M?=
 =?utf-8?B?V3cwaXVkRGVYenNyYUpnajl6K2hwQmpNblEyMFA5a2xjSDdzL1ordzhxRFZx?=
 =?utf-8?B?WUUybi83azNGQlQ2aWI3Vm11Q1YxU0NlNXNHQ1MzVmRSTnkvNmpOMWNzKzlF?=
 =?utf-8?B?VHE2dVVVeTdnd3pHRURSMUhhaHJFWXBLVTI1WWNBaHQ5aTQyR25JdytDMVhO?=
 =?utf-8?B?NUhDNlczazlqc0psdXNoLzA2VUlMRXE3SElNSlNUS3VDRHdKQXZObERJZ25Q?=
 =?utf-8?B?cGhLR3MzbmJKRkg4emdZRlIrZlBrcktnVnZrTVlkc1ZHSkU0YTk2SHZUZHU5?=
 =?utf-8?B?K3g0QmhYZ3JzcTB2Y1pOYm9CS1UzY2pkUHpTZDhPejlEZXRjRjI0ZGliaEdV?=
 =?utf-8?B?eXB6OEZMbmdLSWtXYVVVN2ZxYmF0RzlGNmhlSjhXSm9NVU5oMDZwS0prYzlx?=
 =?utf-8?B?RkpxcmhhMjN2M2l4QVVhREkvd0FYMzhvbGU4NkhmRm9yVzg0eUVOVDBBMGlQ?=
 =?utf-8?B?S0R5OTJLRE9Wdm9BbVM4MWlySUpGd2c4UzF1TlI2cnlzcjY4cXRoT04rVHlV?=
 =?utf-8?B?U3hTSEJQSXFTczM4c2xEbWYxN1JISkJ4MHNvYkVxR20xVDkrd3NpVC9BVTBk?=
 =?utf-8?B?aGovR25yUWpLdVc2VDNxN1JPWkplRlpGcGpjRVJCRDM2RWprN0hkczl0V1Uv?=
 =?utf-8?B?bCt2Mk8zUHFYQ0NTQzljdzFtK0FCMk5kRXBsaisvMld0czZ2MHROZncxZlRj?=
 =?utf-8?B?THFSQ0RCOWxDdDVMT0xUUERJSEtXRERwVUZMb2ZVK3R0bUVxTVBSWDlsaHhn?=
 =?utf-8?B?bnJVbUNTdEQxR2ZjRVY2V0JLRkRYMHlQMVdTTndxL2tTeGVYMXZ2a3JkZjhJ?=
 =?utf-8?B?Y3RSY0pSTHJlNnpuTHltY1lBUUgxZmc2QzdTempPVzVXUFRzaEdwVkRoaHh1?=
 =?utf-8?B?SVk3blE1OXJjN1M4c3loZjdYY3VHOHN4eHFUWnBHTjlpZ2M3VWhlTDJUdnFs?=
 =?utf-8?B?NVpoR2JadGt1amRZNGZ0RXA3QTdxV2h1eHZONkJHdGl0Tm1xeWs5T3JOWUVX?=
 =?utf-8?Q?ytY1SxfExwAr4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkc0cnJML25UY0M2M1VuMEt3NXNiUkdPOElablcxTEp6NUJ1YWFka1dTck1D?=
 =?utf-8?B?YVN4YWJyN0hqK1pSaGFrM09CZGZkOEtZcGpReTlPVjZmRXBjc0xYeU9mbnFH?=
 =?utf-8?B?Y0RsbjFLckgvSXJ1eVp3cG9XTHNLbE1kQ3puOWtNdGJialh0NDFFQngyMkJV?=
 =?utf-8?B?cTFwYW1RMFhCdmdoQkZBZWVUcEJNVUM4SWRXK1VkWVM2MkZYYk5PMW9uQzl5?=
 =?utf-8?B?ZG0wK3RwK2tZRDRZUTJFNStlcmZ3NklEdXAyNUcxYjlISFpaNk9DRlNRWk9l?=
 =?utf-8?B?TTJSMDA0eVYyUjN1Nkw2UUJHMEpSZUhyNTVXbmtQL1cxb1NyeTlna3Q4SUls?=
 =?utf-8?B?THgxTXR1SHdpeVR4QkRQRys0cXhLdnlKOUlJa2J0RHhadGNzYmRaUzhBdjRa?=
 =?utf-8?B?WFB4SlpseEx2WWlCUEswa3JNSEUyc0pldXF3VC9aNWpxcnc0bzQ1bk9CQlhV?=
 =?utf-8?B?RlRObWtLY1RRM2NLcGpGNHhkaWpEa0RXbXBuVVBLOVliUDQ3MHdEdENIYmYx?=
 =?utf-8?B?ZFdsaE5NMndkekVIUlRFbmE5czd1Y1F5WkM1cjc5K2JPTjloZ3paQjlKNmFM?=
 =?utf-8?B?M0V0NzUyZkJaVVVoNVZTNzJRTGlOeVo0UENnYXdpV21hVktBM2YyRE85YS9u?=
 =?utf-8?B?SzlFWk85c0o2ZGE0WFZpdjNYTVVNWFJKUng5WUx1bFB2Qy93clVxMnVHbWdY?=
 =?utf-8?B?MFVUZGlHd2RQNVFQL2IvTklQV2JBUzRhdEdRNXlQSjBPRFptTVFpYmVPV0dF?=
 =?utf-8?B?NmdWY3dSVWVNS2JkaW01T2Y3Y0RIdllUZVpab3pvMDVjb1dHMENqcERCRHRi?=
 =?utf-8?B?d2tPWmxIMTNCVkZLRU1mdGEyVlVvTUF3WE85ZSswbXZkMloyV29HaExsRFh2?=
 =?utf-8?B?c1U5TDBBTUp0UW9iQTRTakNtZ1JtQ3JjQTd3MURUR0IyQ1F3OTlpZ1JzaUR5?=
 =?utf-8?B?UkdvQjlISGcva0JMWCszS1lwZ2J2WEFVVnkrcFQzMEtMWFJNTFpyRHJxK1h3?=
 =?utf-8?B?ZmRpRlZVV3Zsdkd3VWMwUjFIWnd4ZGtRZ1U3cmYySWNkVVJZb0JIZXk0eThT?=
 =?utf-8?B?VjZmS09GZUNCRDA2OHZoRDdOajBZajNKQ08vcDZIK1BIK0RVdkl0M2FKMGVh?=
 =?utf-8?B?cm15Tkh3dHZxYmtZaXUrUWlvWU0zVnVkTDJtS2NGalE1REp4LzlOU3VnSCs3?=
 =?utf-8?B?YWo1bExUeGVLaTRsU2ZmSjI4djg3QllDMkxTblZ4K3R2OVVqU0VjU3Q4VEho?=
 =?utf-8?B?aWhZcGpVeXF4dFVpRDQxOG1DSEhDNTV0djNUbHgwR0NBcnRuSVN2d1FnTFNI?=
 =?utf-8?B?WDZLRXFhb2V5UHpJeCt6R1VQUkV6UTlWejdxRFFOTm9SMGtZakxCeVVSU2ZG?=
 =?utf-8?B?Z0dON1AzTFZNd2xIU0k1OUpvS0k5ajBvRE0yWnZOZTVIWmNENDI0bUtaWXlk?=
 =?utf-8?B?OEJnUXNaVjY0UW1ZZkp4QzZEMWRLSjA1SFhUcXdhcjB0R24zQ2xDSk54ZzlG?=
 =?utf-8?B?YlNtY1dNa3huRUg0eVE2M25ESTQ5QmREWXg3OVJ5bG15Y1drWG8zZ29CTjRB?=
 =?utf-8?B?V3J6L0FST2RkUy9yQVIwYitJUXZGUVdlTGxUVjRDTlJkRld5ZDBCeGlFdUVl?=
 =?utf-8?B?ZzFQTlcrbnpnbEF4U1MxRUpWSWFKM1lwS00wcW5La1NHRXZsVzk3aXBqTjJL?=
 =?utf-8?B?aFRhYnlNcXNWSW5JLytKZmdIN1V1S3VmdjU0aHYxSWhPaEx3SElFZEpBb3Bs?=
 =?utf-8?B?VmxhMDV5OFpUOU5MMFBPSTdnL0YrcGQ4bkgvMGY0d05odXpGajRUYTBGbFlY?=
 =?utf-8?B?WDludXVYYzFiMWJEekl6dG1qb2ZwSzNna2xQK0g4ZGF1QTZVQ1I2QmhhYUQy?=
 =?utf-8?B?RHU1eWtwcVpwZzhkS244QXpIWXltbHo1aE5mS0pqR1NjRFRmOGFwdS80RG5M?=
 =?utf-8?B?TTkxK0FsYUhnWkNkeFlIbEdwaDJWR3hidmZ1TWRza3FjdVFEVXl2bzhsaE9I?=
 =?utf-8?B?Y2tHeWRSUHpGS2pPWm1jTGdtRHp3dEVwM291REdwSVFGRzdaN0JidFdjK3Zw?=
 =?utf-8?B?cER1alE4Qk5nSURnbkkrNHlGK3RnNURpNkUyamZkT05jWmRaVjNEMWJ5VFR6?=
 =?utf-8?B?djRpeldMM3dSTFRSWkpPM0Z1N1Q5Tk8xSmhGc1gzMnJyTCs2UlpJZ0h4SjZk?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9e3231-dc50-42f1-0918-08dd990fe041
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 09:06:02.4813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9K+E9jMf1j5kzvBenNoUNYG3vgiEuW6B2hFyXdtEPafBHytlHmJ/O4zWUztJ3JBILXkqS5/Vt0ZXHPF7e/zqGzBy/jdOPGz7WDK7xapoVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
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

On Thu, May 22, 2025 at 08:36:28AM +0000, Ali Alnubani wrote:
> Hello everyone,
> 
> We’re aware that https://git.dpdk.org has been experiencing availability 
> issues lately, largely due to abusive bots and crawlers overloading the servers and ignoring traditional controls like robots.txt.
> 
> To address this, we're preparing to deploy Anubis, a traffic-challenging tool, to help ensure reliable and continued access for the community, starting with our cgit instance. This approach has been adopted by several other open-source projects recently to reduce disruptive automated traffic.
> 
> Please reach out if you have questions or encounter issues.
> 
> See: https://github.com/TecharoHQ/anubis
> 
> Thanks,
> Ali

Thanks Ali, (and others involved) for taking action on this.

To everyone else in the community, just a reminder that, rather than
accessing dpdk.org site directly, you can use
"https://github.com/DPDK/dpdk" as a source for getting and browsing the
DPDK source code. The github mirror is always in sync with the main tree,
and, as an added convenience, also has the various "next" trees mirrored to
it too. This means that you don't need to clone multiple trees to get e.g.
next-net tree as well as main tree.

For any companies looking to have internal mirrors of the DPDK repository
for internal use, it's recommended that those mirrors be based on github
rather than on dpdk.org directly. This all helps reduce load on the server.

Thanks,
/Bruce
