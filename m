Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605EDC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 17:47:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E15442E46;
	Wed,  4 Jun 2025 19:47:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 52B454025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 19:47:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749059241; x=1780595241;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=Sp5U7+7rhnum8qABvjB3BDNzBvzvKs2VmZR1yRYG8kM=;
 b=f5+5IT2/AxIMfHPpvXHw04EQDrmriEeEcOZszIjgGK+fUTC/xAV+v4qy
 5+FV7ajSyUm5MS50E2j1lVmoVJ5W6qSV87kE4DFpkcK79ApXzPikx8Mgn
 LC1DYfUmlh6jKoCcFxOgMWO4irv+ZtpUljHZYbKPGJJOuVXbS+l/qIyOe
 kl/BVMoARP6USzDKKAFPgFLVjUxo1kAXZIbT6NBRyau1GJWyjx5ZPOyjo
 cYH3ZlKxN1rlKl1n9Uxjp5pcdmaPtdVBe0BEQR9VOHoVcf8GspT8YHtyQ
 3XUwI90VGjpBkh4F6v66yXzEHMI7MtIX21GFhNCqiQjpibUz2oibyJRWg g==;
X-CSE-ConnectionGUID: uxCAFWAKQza7pmu/NPuqTA==
X-CSE-MsgGUID: q/9JqNyhRqa9MKZAZo2QTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61827200"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; d="scan'208,217";a="61827200"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 10:47:19 -0700
X-CSE-ConnectionGUID: 29w4293fTF+i62dxPxpL4A==
X-CSE-MsgGUID: 5LEKSzfRR5S9mVy0dvY6hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
 d="scan'208,217";a="146240972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 10:47:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 10:47:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 10:47:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 10:47:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5pxnGDZvih/LX1Bc38eQveiSXw53uFEfgDJt1D3WkKiTCWA0xMmFTpFwdqAzV31fwm3mpUA2aLdj+g3cYYsy/5l+lLYeBvVA4oDuMBwS+oqPahSoAW5MZq1zRZrszdSCGqmTSLwTj5plLpmtETw2O8y+4/2F0x/0F5vF0l9+nlkw1MxfHEE2rLRTkSfaUhfaoivA+3ydEd4PwjkBAa1HHiANwMbz3jkPebBoDdo7nmdgz+JFZIaiNtxUQFVHcFU7W9GPEbPqaxjJrK1RU5LYlNUnVvPO/wm3nzmALoEQdAsg6s2K0cywk147Jg0V6MrwA0JQ+NLCU0o0bI+Hrb8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rDhodeaVKlROlKwRxvi2ECc9s1WtuEokAtgf2hTwbg=;
 b=E2EvmxXiIvg7HHjPsVwJkd0RMdRcAWqdxurukSR1wTBEW9DGGhf3aYWN6Z9KdP50yokXzbHOPdqNeJKWIUqprMIgpxnjXtqJqHijBbp56Su94opjqhm6LvEoMpBJjQFSYV/gJSJavwqOFnEmKdU1I8Ei45xurRVtjoAxh66QbZgdu40NhFhs6e3ITlZwFHLeNbGz7k5h67jHgON3O/iNttDqD4DoYaskBOdvOTgw74k/9+a3MS5RecLMhgAwsdsMFmZ3FclD7VxxGkV4xfPSd9S05MXacRoT1icvfKuw0xbik4/kWCQGJP23yFelDD75lyG86WDEgH6KsGJyFfMgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Wed, 4 Jun
 2025 17:47:16 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%6]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 17:47:16 +0000
Content-Type: multipart/alternative;
 boundary="------------f1eTtTJdNSWk0eiDZBpFXaH8"
Message-ID: <5aadd945-1ca7-45e6-a48c-06dae343673b@intel.com>
Date: Wed, 4 Jun 2025 18:47:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] add lookup fib nodes in graph library
To: Nitin Saxena <nsaxena16@gmail.com>, =?UTF-8?Q?Morten_Br=C3=B8rup?=
 <mb@smartsharesystems.com>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Nitin Saxena <nsaxena@marvell.com>, Robin Jarry <rjarry@redhat.com>,
 <dev@dpdk.org>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCA9@smartserver.smartshare.dk>
 <CAG6-93zSt1SGRa0XnJnodCtiOKWUMTYBY26A3qy9cE1hd_K3oQ@mail.gmail.com>
 <CAG6-93z3kJeGzxgOTOH-CywFLS2bZz2yuQteyqTZBUm=Kyk4Bg@mail.gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <CAG6-93z3kJeGzxgOTOH-CywFLS2bZz2yuQteyqTZBUm=Kyk4Bg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0176.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::16) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|LV3PR11MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 4249a3b6-f705-42e6-9875-08dda38fd886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2FJWTdKaXhSb2JmUnZvUkNMSzQ2Wk5Bd3dWWHRxcmQ0VVJGK0x4aWcza29O?=
 =?utf-8?B?NmR4ZEFLcHBsbW5KaFZLR3hRSEM3TkNhLzQ0VkhLS3RSakczN2Y2dk9OQ0VE?=
 =?utf-8?B?RkU3RzhBaFdEaTVOWEkxL0QrU1hIZ1p2aS9HR29DUUdWZ3JKZWNkemRsOGNV?=
 =?utf-8?B?RlRqdWdma0VGZUlGeXhYeUgvVW9UNzkxdjJnT0p6TjZ6c2psUzBYcktWcTM2?=
 =?utf-8?B?ZnI3RHc1Uy9GZlZvSnNyUHFFNEdxOUxOa1lKSWxteWcyeFArMWY1SnFDcDdR?=
 =?utf-8?B?RXFUSWJFMGU5K1pnY0hDRXR4bHlneHdiV09sVzFxMzRudnJRc1UvSUJBbjg1?=
 =?utf-8?B?TUZyODVzaWtSWGlGZVZ2ZkpBbVFUM3hZbEg1R210L1pLZGFNZ09VUTBvSllI?=
 =?utf-8?B?eW40VytrUE1QZnUrcVkrS0RQK2dLNmpzNTVLZ2J3a1hMVHY2OHVOaWgzSTBa?=
 =?utf-8?B?bTdpN3h5aEdDQzB3OHRNYUFZL3UrUFlNa2IvaUxtbE0vZXFQTmVZbWNLcjdC?=
 =?utf-8?B?VVg3TDZUSnV2SEErd3R3dWl3S3V2M2RlRFRGODR2M2V4a1NGZG00b1M5eTBT?=
 =?utf-8?B?YURwdzJmYU9tUGFwZlVGOWtXcHNUejR0bkZpMGFyajFvVGpaZTF3WlZLY0dz?=
 =?utf-8?B?d09LTnkxRmsrV1UrUGVtL1c1OEhQUENPSXpnRGRrK1FBM1h5S0RJemMxKzZp?=
 =?utf-8?B?ekhJS2ZQcDk0Y0dFQUxKYUMrekxuRkxsb1VSZ1lQRVpsWGl1d0VDZlN1UllT?=
 =?utf-8?B?ZzZaU0o5WGZhQlQ2empLZU1hdmt4Q1lYeXJmRlVRUUNseldabFFLYzZOamFk?=
 =?utf-8?B?K0FVVk5McmwrU2xGYXN2UmFlRlJIVENhTkJJTTZ4TngrTUc0dm5ER3VLdGdF?=
 =?utf-8?B?akU5ZWJNQW9NYWxkaXd5SGpuTUNDSy9pSFYrMUx0N1RFZk8zWG5ZYlFZUGJV?=
 =?utf-8?B?YXdQMTI0QmRmY3RIUlo3cWtaTUYvVE5FSzZZbkg5OFZBbmtMdFRYME9PeXJz?=
 =?utf-8?B?U1gwUWJoOXR5OExkZVBOUGxuQ2JvMEVxM00rM09RWnI1NGVTQ3pjcit6Nm5r?=
 =?utf-8?B?N1pGSzBTbUNlc0VUZTdyK2xIWldCTlo0YTRuZUpSVVBxVTlTeitmVzRZVnRK?=
 =?utf-8?B?dEtoSTQrVE5SRWJhK2pkb3VHN3NQMWhGU25ZRmpkWGh0S2RwZkswSmR6enF5?=
 =?utf-8?B?RzFMTjBUUndFUXBnMmdWQk5HSks2dkxhZ1N0ay81VXRGY2VEdEJFempJcjdJ?=
 =?utf-8?B?ZnhZMjBTMzJoMEoydlZuY1FOZ28yVFhwMGt0RUE4RlVJNG5WMkd3SUFBQjdy?=
 =?utf-8?B?M1BpNzFsTXN4ZnAzU0wyVUpvWWozb3hiVWE4aEVpUU1FRVBtTU11T2c5K0pX?=
 =?utf-8?B?MWtEc0lZbVJFL293OWZGdWVXRnBXNTVaR0Z0a0NYQWEzcnFtdlFSbTllVmpi?=
 =?utf-8?B?bi9rVmg4bVJrUStUNjEzNWordDl3K2VkVUx2MlA5dW9iOGNlZjY5amx5SUs3?=
 =?utf-8?B?WkU3d1VuKzRyVlYzNzZWUG1CTVdrZkJ6NXREb0RMc0pubFhGaGRWMHh5SlRm?=
 =?utf-8?B?dzFaeGhjUVpxdzJLV3RBVTBPR3BLbFpxYXBlRUI0Sks4TlhwcXI0dGRkYmE2?=
 =?utf-8?B?bFlWQjZOQlA0VWIvMGwyZUZiVGpEd2dxVU94M3FGelRQMzhrekloMUZoZENq?=
 =?utf-8?B?djJ4aE1hbTRtVFdHZWIrYkxNNkFPRHhiNStNSnVpcnhwb1hMK0l1YUgweHM5?=
 =?utf-8?B?bDNUUGtiSjhwbmc5aDh0MFdwRUNsM1JxeXNrMER1Zk56ZWpqR2xyNTFpNXhl?=
 =?utf-8?B?UVcvWm1NNDVzZjlpVW9VRGRzazJhYWNSOVVwNlV6Vy9FYjF3WFk2TnN0QXNU?=
 =?utf-8?B?ZTdNd1A5Z0JNNW5rMXd0TDlRYWdsVzArSnpPSFRhL3ZHcGh2MEtLeHBrSnQ3?=
 =?utf-8?Q?k45AztqXdEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWF5TGhScW5aYll5cjZFYkR0RENBak84bUdhWkx0eXFWb2JIa1pwNk0vZHUy?=
 =?utf-8?B?MlliaUxVMG5oWEZuK1JScGtvL0QzbVpXWThWZnlhcTRyaFI2SU1RaVhCWXNB?=
 =?utf-8?B?Ylo4UnlPdjc1TW5rTHFvY3ZSd1B2UHFXckZNMFRIeWEwVTRZUno4R2xpdXpk?=
 =?utf-8?B?STl4OG1TU3loNmVNUjBIRW9oQ3BKTlRHZWVzQm14YWkvM3JtYWUyOU5ZdGUy?=
 =?utf-8?B?TlVyWlNocDdxcnMyRmFCYXJmYWRCQ0dNeVRtVXByS2ZWcmc2RzNVVVNCc3Q4?=
 =?utf-8?B?aGd3NjNlV3hTRlVNNzdRb0s0aHFxT3A3a2NodUN0RElweHRvUnN2N0dTUnY4?=
 =?utf-8?B?MkhtWFI5TGVKN1o4d2tLbktuYTJBWmdHRUIycE1WRk51Q0c5L1ovZDFiMG82?=
 =?utf-8?B?dFYzemRnK08rc0grdTR4RkpOWWJXNjIzUFBiZWhtbDF1enA2ODJjZEp0eHVQ?=
 =?utf-8?B?WStnUGQ4QzZUU3J2ajJDeFFOZ3M2dkRGS3dkcVR3bDl6bnhCeW5WWS8wZ29B?=
 =?utf-8?B?Y1VTRUo2b1VWM0RCOXM4MWx1WTg2cUkrOExzY2RIWDkxVEV3MXpRZWF4K1Jr?=
 =?utf-8?B?ME1BbHlicEROeHVJYzRHOVFVTGE0YU0vcGJBSGIzYjQ3WEl6R3haQ0pUTkJz?=
 =?utf-8?B?MkhsSm1qSnhvNW42cGx3WDZGdlZnZzhmamFXUW1EUUZkMzZqUzRFNGk4NE85?=
 =?utf-8?B?OSt1KzlzbE5lVkp5SENIWTBGTUl1dmJ5c3oxWlRwRUJZRkpsQmdsRXpVZHBi?=
 =?utf-8?B?bzM5MFlHT1hUa0d4V0wwei8zV2IxUlJZUzVQaTh6U3FLbERzdk56SFdBMDAz?=
 =?utf-8?B?WHd3cHEyaVFlRU84ZkpRZTZOYnNTZUw1VXF4N2xiQm9tUFk4UVE5RmFveDVN?=
 =?utf-8?B?UGMweUNGWjNFNXdJdmRZLzBSZ2tIN2FqVEpNNTJ1WHBMSC9POTBRNG9HV2tQ?=
 =?utf-8?B?RG1kQ2JPNFU1MFY1VktvVmRac3hKc2F1bytwRk1sU1BQSTJwdXE0WUdUbjFl?=
 =?utf-8?B?NisyMDlvMmQzTXJpa2MrZVpPZXNjN2lQWXhNRU0ycE1HYVRaRjc1ZEludkoz?=
 =?utf-8?B?RklCemxoWG1ac3lhQ2FEUUdrRitYa2cyUWhlbFFiVVc5MkR2UHR4WEtCOTNy?=
 =?utf-8?B?QXdCWk5XUmpGZytwWUdwVVpTaEVqV0wrbm5HZmNwRlp2ekJGc3lwazcwbGNT?=
 =?utf-8?B?cW9yTkh6ckVYWHJOUlV0U1Z6STM3MVc5TmJ6QitOZ29uUnZlM1NEbGNSaWZ6?=
 =?utf-8?B?dzFwelFBVnFjQWdCNElNb1l6U2w3d09rZzRkRDRhTjBSQU9GN2kxNXZpejlm?=
 =?utf-8?B?YVY5dlpYa0NXRG1MWjFOUy9zTGFVaW5nUDMvYWkrOXc4cDBjeTlhYmhoUTBo?=
 =?utf-8?B?M1VyTncybEdnL3BmNDF0OWtnUXYrV2dnaTROb1U3NDRTZG9ENVAwRG53d056?=
 =?utf-8?B?YVIvVnhiRXdNTFBYWHh3MlJaTGZ3V3YvYllXODFsR1VGVkdmY0RHYmYxVTU2?=
 =?utf-8?B?UW4ra3BqblE2WE5OMXlwQmpEVE5uaVZMbVRsVXVST3VWWUxTSXkzWlpyS1Iw?=
 =?utf-8?B?ZTBIeGhBcGZaTWhKUlYwa2RqejRrMHlyN1gvdEg4Z09TWWNPYVd6M2tXQXV2?=
 =?utf-8?B?ODlTY21oZXdXQ3o2ckEybTNObjE4MWRpbXdrQi9GaEZDWG9IVmpqUVNadWJl?=
 =?utf-8?B?VUxDRlBQV0cwa1JVMzdWTndPekdRYTlUUlJUdlkxNUVmcmN5L3I0TnFoeDlJ?=
 =?utf-8?B?bXFBOS9ES1pocFMzNGtxcVMzYzJlSkhxNm9VdHNzQ0o4OERxVXI3MmNUbEhE?=
 =?utf-8?B?VU90V3BJQWpMbjBSN1dkaTVxbGtpbEdwN0daMFZqamZ0ZStSR3RUYUlSckVp?=
 =?utf-8?B?dERKalB1NnpxRStDV3RPSlN1alV1b2tlYjVkQW1OK0E4SHJObmNXZlhkZFFu?=
 =?utf-8?B?UXlwL1hwL2pLY2c0Y3I3WCsybmQvWjVRSjFrSWNWdU5oT0pQb3htaXh6Y1NV?=
 =?utf-8?B?Y3lXV1RpU0VldXFCMVUyeWFxOU9jYm9aYXo2djBuV0hTbmkyb0hmWldpQ3RG?=
 =?utf-8?B?UCsxY0Q4VHQ1eVp6NDh6VzNVa0UxWk1MZnlEZTRlZ0RMSkVkVGw2b2ZZOUFH?=
 =?utf-8?B?NHZRdnFoOE1FS1ZUWVhUYzF1VmtGYjNvcy95Z1paMDdYMjREVFdGN1dRamY4?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4249a3b6-f705-42e6-9875-08dda38fd886
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 17:47:16.6740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNqRkjadtv+EbLlUbUWlOeqcle790K8llShAkPeAd0ukcBvLCvruo3aR0ks0JU2pnsy8hZaFSQlvbw+cHIDMu0JTtMpckEiZnmGpUaIOGpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
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

--------------f1eTtTJdNSWk0eiDZBpFXaH8
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Please find answers inline

On 03/06/2025 06:54, Nitin Saxena wrote:
> Hi Morten,
>
> Let me take a stab regarding the VRF question.
> Please find answers inline
>
> Thanks,
> Nitin
>
> On Mon, Jun 2, 2025 at 2:12 PM Morten Brørup<mb@smartsharesystems.com> wrote:
>> +TO: Robin Jarry, might have relevant feedback for such a node
>>
>>> From: Ankur Dwivedi [mailto:adwivedi@marvell.com]
>>> Sent: Monday, 2 June 2025 08.36
>>>
>>> This patch series adds two inbuilt nodes ip4_lookup_fib and
>>> ip6_lookup_fib in graph library. These nodes uses the existing
>>> Forwarding Information Base (FIB) library to create FIB, to do
>>> route addition and route lookup.
>>>
>>> Two new commands (for ipv4 and ipv6) for providing the lookup mode
>>> is added in the dpdk-graph application. fib or lpm can be given as
>>> lookup mode. If these new lookup mode commands are not given, the
>>> dpdk-graph uses lpm (Longest Prefix Match) or lpm6 by default.
>>> If fib is given as lookup mode then the ip4_lookup_fib or
>>> ip6_lookup_fib
>>> nodes are used by the application.
>> @Ankur, @Vladimir, @Jerin,
>>
>> A couple of high level questions...
>>
>> 1. Thread safety:
>> I'm not familiar with the thread safety models of the FIB and Graph libraries.
>> Is the FIB library thread safe, so one thread can invoke the FIB modify operation while other threads invoke the FIB lookup operation?
>> If it isn't, how does the Graph library make its use of the FIB library thread safe?
>>
Yes, as @Ankur previously mentioned, FIB supports RCU to guarantee that 
there is no race condition between readers and the writer.

> Just a nit-pick here, there are two libraries used by rte_graph applications
> - Graph library (lib/graph/*)
> - Node library (lib/node/*)
>
> Questions here are pertaining to "Node library" and not to "Graph library"
>
>> 2. VRF support:
>> This looks like a global route table for the entire graph.
> Correct.
>
>> Shouldn't there be a route table per FIB node?
> Yes when VRF support is added in library, one FIB would support on route table
>
>> Or how are VRFs supported by the Graph library?
>> Or is there no requirement to support VRFs in the Graph library?
>>
> Currently the node library(instead of Graph library) does not support
> VRF. There is an intention to add it in lib/node/ip[4|6]-lookup nodes
> IMO, @Vladimir can correct me, even FIB support for multiple VRF is
> unoptimized because rte_fib_lookup_bulk() function takes single fib
> pointer instead of multiple fib pointers
> For adding VRF support in ip[4|6]-lookup nodes ideally we would like to have
>
> rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips, uint64_t
> next_hops, int n); (OR different new API)
>
> taking an array of fib pointers (or fib index) corresponding to each
> nth packet. It should also avoid fib->lookup() callback for every
> packet.
> We can also add this API as part of "Node library" but we need "static
> inline" version of fib->lookup() in rte_fib header file

Yes, the current FIB implementation implies a single routing table, and 
for VRF support user have to use different FIB, which is not optimal in 
termsofperformance.

Sometimeago, Iwas thinkingaboutVRF support in FIB, and this could be 
implemented with almost no performance drop compared to the current 
version. API will look as follows:

rte_fib_lookup_vrf_bulk(struct rte_fib *fib, uint32_t *ips, uint64_t 
*next_hops, int *vrf_idxes, int n); Thus keeping multiple VRFs inside a 
single struct rte_fib, and adding new VRF-aware API to the FIB library.

I'll try to find some time to implement this idea.

>> -Morten
>>
-- 
Regards,
Vladimir

--------------f1eTtTJdNSWk0eiDZBpFXaH8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p>Hi all,</p>
    <p>Please find answers inline</p>
    <div class=3D"moz-cite-prefix">On 03/06/2025 06:54, Nitin Saxena
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAG6-93z3kJeGzxgOTOH-CywFLS2bZz2y=
uQteyqTZBUm=3DKyk4Bg@mail.gmail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">Hi Morten,

Let me take a stab regarding the VRF question.
Please find answers inline

Thanks,
Nitin

On Mon, Jun 2, 2025 at 2:12=E2=80=AFPM Morten Br=C3=B8rup <a class=3D"moz-t=
xt-link-rfc2396E" href=3D"mailto:mb@smartsharesystems.com">&lt;mb@smartshar=
esystems.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
+TO: Robin Jarry, might have relevant feedback for such a node

</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"" class=3D"moz-quote-pre">From: Ankur Dwivedi [<a cl=
ass=3D"moz-txt-link-freetext" href=3D"mailto:adwivedi@marvell.com">mailto:a=
dwivedi@marvell.com</a>]
Sent: Monday, 2 June 2025 08.36

This patch series adds two inbuilt nodes ip4_lookup_fib and
ip6_lookup_fib in graph library. These nodes uses the existing
Forwarding Information Base (FIB) library to create FIB, to do
route addition and route lookup.

Two new commands (for ipv4 and ipv6) for providing the lookup mode
is added in the dpdk-graph application. fib or lpm can be given as
lookup mode. If these new lookup mode commands are not given, the
dpdk-graph uses lpm (Longest Prefix Match) or lpm6 by default.
If fib is given as lookup mode then the ip4_lookup_fib or
ip6_lookup_fib
nodes are used by the application.
</pre>
        </blockquote>
        <pre wrap=3D"" class=3D"moz-quote-pre">
@Ankur, @Vladimir, @Jerin,

A couple of high level questions...

1. Thread safety:
I'm not familiar with the thread safety models of the FIB and Graph librari=
es.
Is the FIB library thread safe, so one thread can invoke the FIB modify ope=
ration while other threads invoke the FIB lookup operation?
If it isn't, how does the Graph library make its use of the FIB library thr=
ead safe?

</pre>
      </blockquote>
    </blockquote>
    <p>Yes, as @Ankur previously mentioned, FIB supports RCU to
      guarantee that there is no race condition between readers and the
      writer.</p>
    <blockquote type=3D"cite" cite=3D"mid:CAG6-93z3kJeGzxgOTOH-CywFLS2bZz2y=
uQteyqTZBUm=3DKyk4Bg@mail.gmail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
Just a nit-pick here, there are two libraries used by rte_graph application=
s
- Graph library (lib/graph/*)
- Node library (lib/node/*)

Questions here are pertaining to &quot;Node library&quot; and not to &quot;=
Graph library&quot;

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">2. VRF support:
This looks like a global route table for the entire graph.
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">Correct.

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Shouldn't there be a route t=
able per FIB node?
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">Yes when VRF support is added =
in library, one FIB would support on route table

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">Or how are VRFs supported by=
 the Graph library?
Or is there no requirement to support VRFs in the Graph library?

</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">Currently the node library(ins=
tead of Graph library) does not support
VRF. There is an intention to add it in lib/node/ip[4|6]-lookup nodes
IMO, @Vladimir can correct me, even FIB support for multiple VRF is
unoptimized because rte_fib_lookup_bulk() function takes single fib
pointer instead of multiple fib pointers
For adding VRF support in ip[4|6]-lookup nodes ideally we would like to hav=
e

rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips, uint64_t
next_hops, int n); (OR different new API)

taking an array of fib pointers (or fib index) corresponding to each
nth packet. It should also avoid fib-&gt;lookup() callback for every
packet.
We can also add this API as part of &quot;Node library&quot; but we need &q=
uot;static
inline&quot; version of fib-&gt;lookup() in rte_fib header file
</pre>
    </blockquote>
    <p>Yes, the current FIB implementation implies a single routing
      table, and for VRF support user have to use different FIB, which
      is not optimal <span style=3D"white-space: pre-wrap;">in </span><span=
 class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"166:5" style=3D"white-spa=
ce: pre-wrap;">terms</span><span style=3D"white-space: pre-wrap;"> </span><=
span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"172:6" style=3D"white=
-space: pre-wrap;">of</span><span style=3D"white-space: pre-wrap;"> </span>=
<span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"179:18" style=3D"whi=
te-space: pre-wrap;">performance</span><span class=3D"aNeGP0gI0B9AV8JaHPyH"=
 data-src-align=3D"197:1" style=3D"white-space: pre-wrap;">.</span></p>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0:5" style=3D=
"white-space: pre-wrap;">Some</span><span style=3D"white-space: pre-wrap;">=
 </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"9:5" style=
=3D"white-space: pre-wrap;">time</span><span style=3D"white-space: pre-wrap=
;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"15:5" sty=
le=3D"white-space: pre-wrap;">ago</span><span style=3D"white-space: pre-wra=
p;">, </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"21:1" s=
tyle=3D"white-space: pre-wrap;">I</span><span style=3D"white-space: pre-wra=
p;"> was </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"23:5=
" style=3D"white-space: pre-wrap;">thinking</span><span style=3D"white-spac=
e: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=
=3D"29:3" style=3D"white-space: pre-wrap;">about</span><span style=3D"white=
-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-al=
ign=3D"33:10" style=3D"white-space: pre-wrap;">VRF support in FIB, and this=
 could be implemented with almost no performance drop compared to the curre=
nt version. API will look as follows:</span></p>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"33:10" style=
=3D"white-space: pre-wrap;">rte_fib_lookup_vrf_bulk(struct rte_fib *fib, ui=
nt32_t *ips, uint64_t *next_hops, int *vrf_idxes, int n);
Thus keeping multiple VRFs inside a single </span><span class=3D"aNeGP0gI0B=
9AV8JaHPyH" data-src-align=3D"33:10" style=3D"white-space: pre-wrap;">struc=
t rte_fib, and adding new VRF-aware API to the FIB library.</span></p>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"33:10" style=
=3D"white-space: pre-wrap;">I'll try to find some time to implement this id=
ea.</span></p>
    <blockquote type=3D"cite" cite=3D"mid:CAG6-93z3kJeGzxgOTOH-CywFLS2bZz2y=
uQteyqTZBUm=3DKyk4Bg@mail.gmail.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">-Morten

</pre>
      </blockquote>
    </blockquote>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Regards,
Vladimir</pre>
  </body>
</html>

--------------f1eTtTJdNSWk0eiDZBpFXaH8--
