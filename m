Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92072C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 12:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 530534014F;
	Thu, 20 Feb 2025 13:27:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1E31E40041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 13:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740054438; x=1771590438;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2FZ8N1vGFMWrs97I+8Kb4G6l8acgBNagViskLObWBi4=;
 b=FzIDdcESTuuqh7vNd9tKo9lUjQ8XB/xNbNBM9tgzlPtI3mlutyIcWC19
 zWanqcJyAOFQX38rvGzxuppNUEQvOp6fIyUA7rD/RnF3DfG+hZpezE6fb
 4gUT9HAtsCNlU4g+yLQPQA4l3T6VrDgBOJfVI7JzcC7QTfh3VGM7ryp/I
 pwoHlh4nvx7zB9NxkDYBanIAUHzvgjOJtTGXmoRkvLyG5yLCH+1Z5myG2
 3VmrBTBg9kDaLEdxFfNnap5r5LL9IIsVAP58O9zrEHqdJ8RHj/HEDrx/R
 zZ8iMzFd1gUfb288qJ2/cYxAHbLpy8hAafWuIwjIEIEVGSPDV4oTifiEu w==;
X-CSE-ConnectionGUID: H1dPtUCjQWCWuKp/QAfgPg==
X-CSE-MsgGUID: ipqdQMnbQ+y3GmdHSCl9sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40018911"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="40018911"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 04:27:17 -0800
X-CSE-ConnectionGUID: Xmr4EeCGSIK4OmJhuSRiNw==
X-CSE-MsgGUID: ixLwBk7kTni7JzWUR9C6fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="115561583"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Feb 2025 04:27:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 04:27:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 04:27:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 04:27:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0o06vppxTr6sAl8LhpQ5E/IC0tfYMOnqa4XFjb700v0DOstQA51YO06yvzL0nWd3PhG4PDisRvZwNGnmcXxUtUvH7D7g4R/BWspFNjCvvLJfGafJb3yr7fhdSTGCKvuANQd9hk/1N0u1StypyzeU+JzLLfNYwlXlnPtlGEcFllHh0/mxnSajzKxpTNkCPWAl52XtV1kfouJAe5+Han2n61tqBNwH87FhKjQulwgp3Vol1medhL+hueb2kmjCStfDPVNCSyzHyiagnMsaYZCWxxdeJcvfF9YQnGBP4NJhp3PHN5KszZqdM221Jt19/mmBQRYMTBkxkYzqe9KFaW1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0o7TQXbecdCZZdQs/KuDbI8woqf6eDDNqm+fTezzk8=;
 b=j9D5MrFlS3fEfRJdDOGxsKFGwlqc60LnDPWLH7IlQ3Lp9TsoiTaZUhOQreLPr6sAujf1uA/wQfjjowjILmkur7bcRacOzkBkEg6pufhYIXuoIY30/y64rQ73Xn8xzaVI6M+ObJHdLCHW4G+7shGVOADj7AIsRClAwctAkJz/BaVFUibJNOPbUzJus+Mo9IJiWc4PyEW9L4Vn3RF1ljO1iuIjF/9R5he2A3N47WBVUhed1+N+LnC6+DntLHEYr4Np2fyLi/edvDpt55cFQEsS2sC0OL4NRn+3GPgclNdGhwxsJIKWtWuWZM8WdSrNfbdxDwADNCgfuB8zXQnmV4FT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CH3PR11MB8494.namprd11.prod.outlook.com (2603:10b6:610:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 12:26:59 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%4]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 12:26:59 +0000
Message-ID: <579aedec-3595-4297-a0b4-35b058a5daef@intel.com>
Date: Thu, 20 Feb 2025 13:26:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: reword sample application guides
To: Nandini Persad <nandinipersad361@gmail.com>, <dev@dpdk.org>
References: <20250127174743.24713-1-nandinipersad361@gmail.com>
 <20250216230903.124496-1-nandinipersad361@gmail.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250216230903.124496-1-nandinipersad361@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0156.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CH3PR11MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5285bbef-db5c-4114-8872-08dd51a9defe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1FVcDlJRXBodDZQOWt2ZTdkbHVsTTRTbWcyMTc3ckJuL2dSRmttdTEyME9h?=
 =?utf-8?B?NFN3SlJvalNPYnl3NmkrYXNtSVByYk9HbXp1MlMrNFNkUzl3a1l2Ni9xbFVK?=
 =?utf-8?B?bTlJS0trMnlkdHMyQjVHcXNyS0hiZWNUaSt5ZGJCandOaG1QblRiZUF3UC85?=
 =?utf-8?B?eFYzNzUrdGIweC9pMDZqd0JhS1BWQStZc1F0SC85SUtxSEIvYVdyYmFuNkRk?=
 =?utf-8?B?OU9nRU0wancwaTNvM0ZXYm5PZjlBOFpqRlRoMXpHKzJKTlB4bzZtMXV0ZFJh?=
 =?utf-8?B?NlNHQVQwOEtKUmJMeVdrajZyUHd0SjVsNDVKSFZhTmxaRjhKN1hMeHRSUjhk?=
 =?utf-8?B?RTdCNGV0N3FhUjJaQ1VjSG5haEFWZnJ3ZzE3K01HUC9DUnJrd0YvZ2ErTXlk?=
 =?utf-8?B?ejV4QkMra2tqaWp5bm5wQ1h2RWxGeTd3Vk9EemZOT3FCRGtiQjZkN0FKTWo1?=
 =?utf-8?B?M1lxczhMRHZDVnNjVEdHYlNFSUtyQWNhN05MVnU2ZTR2WWs2MFQvbzZWbWhI?=
 =?utf-8?B?OEVWcFZLQit6NDZpVGVMaExNSEtQbS9HSWk2RzBVNnpuUzRFUjBsTldObm1J?=
 =?utf-8?B?Q1lyaWtEZGJndTFqcWovVmNUYTlZN0VhY2FDUnh0cUtqeDNISjlXeW9tQjZa?=
 =?utf-8?B?MnpJRC9aalYyUGtzWXJKYUFMcHVzckIvMlI4RGZweFpqUTJxbDZ6UzhQbjVU?=
 =?utf-8?B?aVpLdnlNQWlZZkFBSVRRS3EvMy93Q0t1bHI0UnM0WGMvRWwvZVpzNXlCYjZq?=
 =?utf-8?B?TUJ1aGloSEhRZ2xIdHcvVitmOFNiclc1ZENUZ0NJdWlaVWxqYWpucnZQcjgr?=
 =?utf-8?B?dzBMNDV5QWJwR0FpQUE4Rm9VRUc4bys5dkNPWjN0SldWb3RPcUpmbTB3NDZK?=
 =?utf-8?B?Y3pDRlhPdUNQRWw0dkN0aDRwTFBuZ2tDTjZ4ZmEyc20yRkJ3anYwTElCYm1S?=
 =?utf-8?B?T3N1TzJUZDFVMDdNNmM2ZFhhWW1DbnBiZk04ak5rbmpFU20vRk9LZWJWSkFN?=
 =?utf-8?B?S0VWVWo3Z2ZabWpVRXRBMTcwUXovOGlia3VsWnlZS3RmdW40Tm1jQVJtZDV5?=
 =?utf-8?B?dUpJdHlPNDFrZTRKZi9zR2kxWHU2VmlPK1VrMngwZ0doMHpuUkt0RHZUdFFt?=
 =?utf-8?B?RE5WUWdVajM1UGxxaHhMT1lodmU2MmFFNEJqaGl5alBHQkszYUl6UHZYYUt0?=
 =?utf-8?B?aCtpMnU2MWt6KzcybDFqSTVpZnNoTkdjSFpZQnIydHJEYkU2K1ByYWluL2lV?=
 =?utf-8?B?VEhVSUJmcXNBZVhhSE1RdUY2K3J1T0VMQ0NieXJ0Q2poQWpqelpYUnJDL3Fv?=
 =?utf-8?B?Rjg3dnVzaVZUUHZzSGxwb3BlWlpMYTc3V3gveFhmU1d4REJ2dUhxYWV3cnRB?=
 =?utf-8?B?VnVzYVlUdEE5OC93cWVaVmFnVnBnRnJwclBsNGRROC91RjhFNmlhbXlvUGo1?=
 =?utf-8?B?bjc3dUFQVzNqcXIwbUY2NFBYTmdCV3FKbzdEZFpLTVJya3ZaZHo1TTVKMGV0?=
 =?utf-8?B?V2N2QzB0SzcrZGsrdTBRRy9XQjhrYURDdHhOYXVuRFBvcVcwRTN4MW5lZ1h0?=
 =?utf-8?B?cS9zZ3JubVhNUmlRcGhwS041c3pXaHByd0RpWUpxMW5VWXV6c01RZzhISDBv?=
 =?utf-8?B?S0s4VWNvcGNzMkI4dUw0cmIyd29XZnkrdS93dUdGWHFIZWN3cVBNc0c2N2Rt?=
 =?utf-8?B?S0t1QWxjSXNhYmpLNmVmeDZqdHdpYjBGdDhNMi83RWZSMm9Lc1hoNnVmTlVK?=
 =?utf-8?B?ZE5HQ082SU53VmFJelpWUmNnRFZQL1Y3WmJiQmhKc1N2YUl5ek83UTJMc1Nw?=
 =?utf-8?B?YjV4NGl1Tm1IRTg3NDZ2UDhzdk5RcVQvdTdkbzhGNFBTakpuc2N3amtncm1M?=
 =?utf-8?Q?oVGjUs07fwA5n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qno5eVJNMVpaQjRETFdFQ00wbzFJT0dLaFdnQWpwUEhLcGgxRnFJTVJ1UWZZ?=
 =?utf-8?B?OGJjcE9LTGtVRUd3RXVWWTU4NDhjRDFrRi95cjVsbjFJVmFsRDFWRFhaeUNR?=
 =?utf-8?B?QXlvSzlCZ3dCUjg3dDlzRTBIaytFYW1oc3d6bGRQSWZDT3ZVWlIxRnJqZU03?=
 =?utf-8?B?UzI1cE13TlpIT3JYVmVxcjg5NFN0TzVCTFNRWVlqUFV2SEp5dXJ2cnBzbzhI?=
 =?utf-8?B?ZFlnaC9Cd2srQU0xTkVkVmx4dVN2TEx3bkR2T3F5b0I5TkZHbW9CbnZ1ck9z?=
 =?utf-8?B?ci92bDBzMDBHdHc5SmwyYWF4MWdITUlEcTVRTVN4UzFTZmJnUVpQZjBxQjhX?=
 =?utf-8?B?am1kclkxL1BQVisydURJd0d6MmxNbWhYbXRjd2NXbUd2TlRYdm9mYlM4YUkw?=
 =?utf-8?B?UlFWUHptNVExODVEUDJKYVMxbHBzYWthREpZbjMxR25vWkZiaU1sM3lPSmtv?=
 =?utf-8?B?Tkg0RFVSU1grUDdheDVVeFFSSDBISUg5dlY4VjBQajh4cFduQXlMdmt3c1dR?=
 =?utf-8?B?S3pFVURuMTV0dFRhbUpJRld1OUc5V09Jbkp5aUFQQ3k2WEdSM2RkZ0puclpE?=
 =?utf-8?B?cmhLZWhadk9xUkpwZkZVWkxra1BNSCt1WWwreStJVHdKb0ZNeE14L0pBMDFJ?=
 =?utf-8?B?QVJNOUs1ejJ6QUtkRkJmSW5QWmEvS20rNzk3bnVWU3Z6M2V5SjFnN2lJMzJD?=
 =?utf-8?B?Y0tTbHVnc1pFUmM3VnpyQlp6OXpSeGNQNExrVFNRVHgyWEpmWS9ScGpxYU5X?=
 =?utf-8?B?M25JbmF1WGxVWlB3a01FamNQSjlUaTcxbEdVejZoSDBIMmF6bm0vYnppWE5L?=
 =?utf-8?B?ZVFJaTBCMUQzd0FTbHAzUElWWTNwdVQ0aVVIY285enBhOUx5ZC9Ga3dzaFEy?=
 =?utf-8?B?UGtrQ0NsdXpiSmllTHNSKzNpbkhvNWRCRUMyc1dyZ0hyTUlHM3RkK0pBUFJX?=
 =?utf-8?B?RTRmYzNpN1NPbTJJV2lhV2FPN3VhSjFOc09Td0lkMVNMTlRPT2NFaXhFSzlz?=
 =?utf-8?B?MjRpNjl6SUJlNjhoQUROdEF2Y0JiKzBCdWNoMWJRRUM4OU0zT2lGa1RaclZK?=
 =?utf-8?B?SU5YWkRmVS9yaE84YXNaalM1ZEgxSm5XL01OcnZzOEp0eXZrYkVtUElxZVdM?=
 =?utf-8?B?Q1BCVkVaeHRVanpKKzA4Um50SGQzT0kyTTFLalhBNXZOU1pVTTlvckFFVWIx?=
 =?utf-8?B?S2QyVFF3MThWOHZtMUE2bEtkZkJBeVFqMEhOWDhocjFWNFllb2RiV1dmbW8x?=
 =?utf-8?B?OHE5ck5Jc0VTUnN2ZitOODRJdzVNNkF0bHNQZGRPZzdQYVo5RFBlUDhxL2Vt?=
 =?utf-8?B?T2ZIUjF6czV3ZlVsWW4rcGRnNHB6UVB6eU9XNDBqOFRPZFF3UzA1WkFET2Va?=
 =?utf-8?B?VE1zaloxbFlOaHdjMXBDbGhnSzBTZW9kb0dzazNLa2Y0S1JyMy9lN0dZbGxQ?=
 =?utf-8?B?SnN2Qm5rYmtyeG1KUnZvWFF4SE9kTGRlVVc4ODJiSStMSWppWGZnSm5zemtM?=
 =?utf-8?B?UUR2UUNNaDRRU0kwekhpQlVMRW9XL0llemZzaG5xenZnLzhCYXhTMklocEJN?=
 =?utf-8?B?VGovUlhYVEtITXU4ejVZZVR5RkJpa2p6dnl6bm1CekZHN2JiMUkwYnJrM3RS?=
 =?utf-8?B?ci9GaE5WaGp2WXpxQzZHUk1uSXFGRmdKdHJCSmNVM0xSTUVsVEQ1MjFzanp4?=
 =?utf-8?B?TzZPcXhWcHRkaThNZFMraXBqN09oZVd0TDFIa1dGQmVTNHcvdTAvSTJDb3ZS?=
 =?utf-8?B?SkQxZ2tPVGovZy94N1N6QlA1eUd0WXU0OGVvWHB2eXpKT3VicThMejMvV2pG?=
 =?utf-8?B?OU5FOFFxbzRLN2FqOGl5YS96Sm5aQXByb2tSMVh1K3p4QnljS3VHT2Fra0Jp?=
 =?utf-8?B?b3lpdkNMZzlKaU9ESUhkbmFUdHlaUmJpZmZtVlNDbmo2aE9PczdkQlJ2WStx?=
 =?utf-8?B?aW1yV3VUZUdvN3NHZnYxNXg0MGlkSjRVN0M2WGFlejBUdkhMbm5obHdISkgz?=
 =?utf-8?B?S0VPSWN2OEc0dTIvck83TGRGUkNaaFFua0dsU3NjSXQyaktVc1kzRjQ5UTVn?=
 =?utf-8?B?K21jSytJUjdkblBYMnk3RVA1a1B5bVVlYUFmb24yUlJ0SjI2QkVuaG91Skpn?=
 =?utf-8?B?UytCalhKWHhhc2VoOUZUWlAwM08yMFFHcHVBMzRSRW56ZFlGd0tKTk1IUERC?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5285bbef-db5c-4114-8872-08dd51a9defe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:26:59.2857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj65jQFByyhMaLsA9jwx4oCnR3QataIS9xmzYHERILEEx/vAUlTudXuM0PHAv1fVOVgpEkE8LPEQrN5DTVGZczGWuHZFlx/uMOy7dwc1obM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8494
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

On 17/02/2025 0:09, Nandini Persad wrote:
> I have revised these sections to suit the template, but also,
> for punctuation, clarity, and removing repetition when necessary.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---

I wonder if this should be split up into individual guides' updates for 
easier review?

-- 
Thanks,
Anatoly
