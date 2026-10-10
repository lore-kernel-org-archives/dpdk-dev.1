Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA34BCA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:39:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03240402DF;
	Sat, 10 Oct 2026 20:39:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id DB8CC400D7
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791657542; x=1823193542;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=R8uinO9o4Cwp1Jhh0K9h5pEBRvn591xkautphup5Sf4=;
 b=bG1dHmVOcJCeqAsM0omWQAKq+S02r9AqCCvTmeeEOlK/5qW+pnCmApbZ
 yxluT3IpnPQ+6H4epyfYiwOQKeHZBbg3eBPsd23tRb7BExqaKolXJzacl
 MM6GDXguhewkvi9mpA1dTx3QIhybe8Jv3X+VDMBSDsypMMdpnkaY+7vCr
 bdGode4FX8Vye37YL2HCl83q6JvaILzIOONpeg2B3tqqhwl/tfL2WhvoR
 ECGJtAYGpz1onO1APw/KArmZ48vZ2BkTjm6wSxEP3UDl2Gk7rzHepEaOr
 GSv461nwc8+pY7Lxupm8bd84Jmw0U7YDDA8B+9tDQhHDqiJu/5S+LLCU5 A==;
X-CSE-ConnectionGUID: HJaYq8LrQ9S1bckdZ0gZ4g==
X-CSE-MsgGUID: FFSihVyySm2VnpQYOgOpOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="435008"
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="435008"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:39:01 -0700
X-CSE-ConnectionGUID: Q+7xdPm6TN2r6eJHg1cfSQ==
X-CSE-MsgGUID: eOmM2RdDQHuy25N+5RE/wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="877813"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2026 11:39:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:39:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 10 Oct 2026 11:39:00 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 10 Oct 2026 11:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q325bQ1YnmzEPbOfU/0GQ+RpX09y791kvibuiOBnGtR3i8+p8tYY/CspqglFaFSUfhB1dDRrkNQMUgNtC8yMq7aT7kkCSSYm4oAcRBQhZSA+6u8J5XfJUOVEDM0vTYaP9T31qjeRNvX+nD0iSBcp+Aj+bZ5hcwisvUp+FwPpEa1zwlfEUEkwRIYaEqzioBVKKABDdsXq2i3IqFy7PqihAfOeiYmuObHLbDRA0wWdLU10iinOmiqKMj8wE7xx3GTYA3L+Ubp0pu1jb8v12M/huNzgOsR+9og/X3rO9/ikMC9o2BcwO4p+j0dQy9bPjAo4oVX4UjxT16+CyNfc0AhV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjOH6aviklrTWmZ5NXsEDZ/l5pPWpg0wSWxM9rUcGk0=;
 b=a01nr3sbj6mhCApT4qcC0enXnCEVXibryAVfU6dNBv6THsyReAfvOR+9ri3ZOizoK2sdn5hnMkT8tXQUM5GiB6KuhtVycSxm39CqvMAcSkvOAagb1uTLHk6I92m+wsYrgPvUIWt2KgbGwdaSk9rcDbQcdsAg8GcSli3H0xmHsZ9MDqrxZ+BzAv3U/VPvo2STroiTXES6JUUQgJqQTQSJHxGSBAWkWdcq+wBXI0yENhVKCOqm62g0fDQk3ilJFIMPD5/E4gfr3JKHPanzCcsInEpSxUyFLffUWX8sNafucT1+bqNAU73WDBF7j6HBFlx9Z8WrcJ5mUkSbr59HS93i3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA2PR11MB5049.namprd11.prod.outlook.com (2603:10b6:806:11b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 18:38:53 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 18:38:53 +0000
Message-ID: <08f0f9a7-ada9-45c0-b23f-6ad164c0b756@intel.com>
Date: Sat, 10 Oct 2026 19:38:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/25] net/ixgbe: reimplement FDIR parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <38cb5d8edad3ec9c0c595d77e95248120689aae1.1791543155.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <38cb5d8edad3ec9c0c595d77e95248120689aae1.1791543155.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::14) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA2PR11MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: bafa7f0a-7e1f-42c2-01a1-08df26fdbbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5aflTVfDOjDQ2ymtD5ustPygi1ySHaivD4lB+TCvsB1IUBok6DoxjaV7WxrGWKLiHHUHTvG3g5edpSHLTSB9Ju2Aa72Vox5GZHCZC7aSNxSQ7Uevvx277Gyd9dOpLYe+UFAg+nTiSpJW70ukG7tH4NW1zUN9vgdxhbEVb9lxc7g+NnnsEh6n6+hrHCQD8fvVZgSiLwpcc9ODQXWbHrCcPL0CrXjMIOBEJE8V8oOGOF1Ntym+pZO35in5QXb4fU7obwSoBmStU1y6x/5lb04jb4RGIAJn79GPpHYRUpLrpQF5LNNFpWMbAgrpWtRxnVY5KPXY6PslVJEz0jrz1SskmigGfQUAGkS6eYworqlpgH1mDKPeIheGMIeUlTOYmtNes6QgEJhuh9WWKxU3h6xWomUBDKwVRHIq1xs7vc2EW/2J2sdWneVM3Kd0O7vTeGoUnlW444FmUPikNNe4YuOV3owCr6Ztl7zcJhwPTBhMdXJFSLb6sv/unnCBe7z6ikEsl61FUGIaph1ZERq1yBoWlhX0AprNIoZb5jHdxW/pY+575rR9qaDlDX0ieFY8ZMSH0IwP5uou7vD3s0Qd1Q04t+TjGqGmn2yPpGY4FoyNTd6QZkboAntPAoDqzB3tnhgr7ywzqBSaKrqFpe3YvZm9jJL5kXXvjEA6YyVF69juNps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0V1U0ptdk5HeXpqaVJjdmU1N3RRWWhqZGtzODRieUxZSlgrQlhtNTg4UUpU?=
 =?utf-8?B?VXpJZGxxdU1NOS9sdGFJMWtoZmhaUkN2aDhNM29jUFp4MUFOaUVWNjVreUtq?=
 =?utf-8?B?VHBjUGtWMm1nRE54MUkwaEtrK25wZ3Z5MGFTWTIrek5aWWNSL0lZYUZQQXBk?=
 =?utf-8?B?ZW51TXJrSkt2bXdDaHFhU0ZiSHdnOC9zRVl6UkxQcnlXbXFhNnA1WXE2dkxz?=
 =?utf-8?B?MGNzL2VnTklsUmRVK1UxaVhoOG5mRFRBU2lBYjNCTkhES2JQN0VGdTJ2M1Nt?=
 =?utf-8?B?d1dPQW1jVnpsSnBPMncvNDE1Nk9GOC9xNW94blJMRmkvOVBnMHAxNGlXMEcw?=
 =?utf-8?B?ZFZoM3ZLT04xcnlwa2R5QTBQSGQzUEh1WW5mMTQxM2kwYy9zM2hZRk9XRUZN?=
 =?utf-8?B?dXpBNDgrM08rbjd6TXloZ1Fob2ZVVzZmZkhIUUdTV3hxNzB0Wmhxd3BEbUtT?=
 =?utf-8?B?T2ZDb0hPcGNaZU1LNXNhSmZLVkEwL1c1dmFhUkMwWVNvdWFBN0JYSFhkME5L?=
 =?utf-8?B?NWxwTkdDVjVlbnUrcW04bzgrTUJaeWdVMk9CVjNFY2ZEQkFHVVgzV0QwTDZV?=
 =?utf-8?B?cnhYNG52LzNicERXYnA0SGplM0Ixa08yOVdKaE1oY0p2UVcrbkhtL3dMUHUv?=
 =?utf-8?B?OEVGc1huVEhibC9PQUxoWVI4djR0SVlOVjVTaGRnL1RPajJVeDdzcnU2Q0U3?=
 =?utf-8?B?U3d3RkkwR1VEVlNKeWxZays2dVRMd0lCOVZwWGg4eUNDRVlaWDhNNkpPZk1B?=
 =?utf-8?B?K0Y5Ylk2QkxrVzZvVkpac1pSblNDeDM1dm51b3lhOU9EWjhHZkhSQnpBL1Ny?=
 =?utf-8?B?NnVZUUJ5YzBDUlJUd0w4TGVSMW1xOXZLQitTWGhyTWozT0xwNU1EMVladTRF?=
 =?utf-8?B?aVY0TVpKbWJiOUZGUzFWV1lNVGxxc3ljZW1KUXN6THRuM1M2ZE9UaHdGaHZv?=
 =?utf-8?B?dVlMem1WT0cyQjdqaUZKR1BYOHpKKzVtRU5LNTdhbDloODlZN1FYTUpqUHdR?=
 =?utf-8?B?ZlhTT3VvRHdPelMzSXhrcW5ySXZ5ankvcjJORE1EbytqK2prVmM4VWMxbVFF?=
 =?utf-8?B?S3l1c3ZtNEtKSXoxNVF4cEovMzJONU9HREpNek5yYXZPVjN6WGRRSTVQem5K?=
 =?utf-8?B?cTI4d1VNRUdzMUpOQlQ1VWdTNktpMWVQaEUyYlllYytPdVc2cHRqSHZsSVRU?=
 =?utf-8?B?MG1pMU5ESVh5OGZPYWJXdXhlWW9tQkF0eVFtRHA3YW5EVVhHY2dPMkVrUzRD?=
 =?utf-8?B?cldoODJHRU5NT3AzZkpvcXU2cWhIdW1HRmo5c3QvQy8vQUxHa21wbTY2aGV3?=
 =?utf-8?B?cVNQNTJvYUdVRjdMRWV6enZBN21ZMjROU1pTUEVIaTFPcDNnQ0xKWDV1MDhV?=
 =?utf-8?B?TXF3NU41U1htT2RKa05rdE5IMGpWMVNQL3BSZ202b3gxOG54MHNaNmplZFFY?=
 =?utf-8?B?THFMTlpIcURNNlh0Q3g1b3kwbW13Tmhvc2hwUkh1Q1ZvdXl3cjFmZHF2M2tx?=
 =?utf-8?B?V3MrdTdKVUN0YTlhUkFyU1ZFTmRqd0I2V2tHS283S0xHdVRVaXJxNVJKSGpy?=
 =?utf-8?B?R1plaTVJcTFJay82cGp4TFkrSElyYlZpeVhBa3hmU0oxQUpmamt6M0lkL21i?=
 =?utf-8?B?SEVlZ1RDVW1laWhYTmh5ckFuRWQwQ3pXT1pISFRBNXViLzdsSTZra2NmV0Rk?=
 =?utf-8?B?cWdmWWpWLzlSL2NQeTlkdkdQMXpSM0ljR21hRzZ6V0M1TlhsMDFzYXlzWjVS?=
 =?utf-8?B?Y1pFMkdOWG5pTzVpWUQxTGFBeWlib3FFemxCTS9WNldXTlltR2gxbUk1aXZK?=
 =?utf-8?B?UzJHV3RQVHN1WXZRQU9MR05vcEN5Ujgyd3gzaTFIcTBWZXBLUUwyR05MaFRC?=
 =?utf-8?B?R0oyS3h4UVpScVI4L3pFQVZvOThZdk1BajZBRm9Ia3c5Nis1OU9RZWpST085?=
 =?utf-8?B?ZnYwOGFiNnZPdFBFOEVLVFg4bTFiQ05uY1Q4OVpLWk9YOE9JZjFkZ3FOSm1S?=
 =?utf-8?B?YXF5Rkt6UEdYeHQ4amoyUy9mTkM1Q3NDRVorQWtpREd6TmFzL2xoZk5DRWRC?=
 =?utf-8?B?b3ZKdTA1Umc4cDhrWmttNkttTnFPL3ZPWkM3UmY5eGIzUU9vcjBwc0kwTDFP?=
 =?utf-8?B?dkRhK2E1OXJaS2E1N2xWZ0JJOWVPeEFCak1pM1hRcXVsMFVXQ0laZVNJbjlN?=
 =?utf-8?B?MWZ3OE5nN0pnSEFmbjZjVXBaRnZGazgzMmYyTnhTekNhbnhaWVc5Zy93ZmhB?=
 =?utf-8?B?QWhGWXlZMVNUZmJPTDlHOEJGV29FTEtVaHhQSEFpMGw2Z255dGRRS2t3ckxh?=
 =?utf-8?B?VzV3aFVUYjR6Z0xwcWtjbzNCZ1pFMjJaVUJXUmk0VWRJVloycGRGN2YrRERo?=
 =?utf-8?Q?CvY4W+MCUVApIrLs=3D?=
X-Exchange-RoutingPolicyChecked: nAkLTmVZhojmprElo2RR7NbAbzAggzzdfmIFvJRq2/TgMrB59b9dj/1Fs/pRqqDq1uaArXJjOy3lgt8mlv1qJTbuKsSDrWAafWTRbTmFYUYFgdB5NzyHv8LHMsrxretileM1atiWx9I8CsIqfcT74Rn6HKRKVVcyN+K94lGSi4yY5G9RRsZIyN6aRgq6sKxEIzLiRyt1RVa/EAW/Me6L7szSinmtPLh9TTAkt3gvLUheGrBYgGzCi4J4qcHAG5tFNizOad8Gt6PrwSqLlynOTxtHAthbrmCIwPyEQMSC9UaRWYAcYBm+gA4lTxjoeVSGTpLNMrkAj37qH04kQbqJsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bafa7f0a-7e1f-42c2-01a1-08df26fdbbd7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 18:38:53.1832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXst6Mfst0F5DqAPb4qzgVHi6nECHeGJRsuu0+5VKlHbYTl2sMcE/B+lQVy7+GYEHLn5v31wX6xfA40NhZKl5weNEqObRmFnL7ftELfWEAU=
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
> flow parser for flow director.
>
> The FDIR flow tracking is moved inside the new engine, and the FDIR code is
> refactored to not mix software tracking with HW writes, remove redundant
> state and configuration stages, and structure the state storage better.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   

-- 
Regards,
Vladimir

