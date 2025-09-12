Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2CCA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 14:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7774D4065E;
	Fri, 12 Sep 2025 16:01:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8C29B4065A
 for <dev@dpdk.org>; Fri, 12 Sep 2025 16:01:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757685699; x=1789221699;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FZkW9P7L+gMU2Hdu6kfCV6pN/m5K+seSAtIQKIO2lWs=;
 b=BlBzys05Ujw202RCl16tf5AVhcBvKO++iZBKLQMbsyRdNdV5XbTiJbjH
 jht/TJnPJXky6gqyC3lcNJmAI+PFWJ2aDF9sQcnRS/fV8v2bUN3Nu+QA1
 2coMk/nUrma5OBqDO69zeLsNtMHBdiraeQts9HulzBxXgwSwBb0uKlC7K
 UHv7byH6ZuybliyOg10h2Pi7uHRupqFHdWVwqNDR6sCGa3RU3xb9J5Op1
 Nfmj4qOpK1egdvqbPxVUUZ40t7mH6jjbrjf3jHQsyhH7hhPuZJ4mnWiJD
 xJTG7ns/K4jiR9aeOeiscn2LAjvtjRU75EKFfZI7sDgaKuTNuCNFeHpaI Q==;
X-CSE-ConnectionGUID: UV2Ao/jPRLe1jHPU93/l0w==
X-CSE-MsgGUID: 4FWn0KmMQA2Wt9WdOZ3CkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="70654577"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="70654577"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 07:01:37 -0700
X-CSE-ConnectionGUID: UVN0M5cxRQ2Xw7bjEb2ruw==
X-CSE-MsgGUID: NTKDD1MHRs+DZI/ewqZAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="173274722"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 07:01:36 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 07:01:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 07:01:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.73)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 07:01:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7hOJGfDLZTS/8MGZqnj6QM+hT2z3R/xOdQOSBUIHfuewiHWOSvCUKTPzwoTyj6YfMFtdn62fZM5xS+me29fDdWsqgf8NvIkS7FMXpTzn0sAjt7WiHtrJ7uZgwdGo+XMkmNqgp+wwsl9rVN9NRBauielusHFWR5Sd50xhQBJylGusMT40ms/fzVzH8C4eDB4L0/vQrI0TsGqYIRfBkcsKnPUrEKZ2LM1SLu601DGb0clk0eXdWZWFGEofqXE+hJjwrxBvHZWbOkOBy+CppFvf6SmsvySJQoMzCWX1R2tBRLEmACbWcL3iammdE6rn3PcWotJI0ZHDYCl3YNu95rfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tdk836xMSgmSsxkZVgIJ/y/zufxl5p4kR5s8XewHCSU=;
 b=VphHxKDYnOSJxC/BlV4ld1x9bmTjH5T28whOypC3AWflzRM3K/Y5zh9YQ2xPQ4eEFuctruoGId4yOBtZJhLMJli2V29LIZ8nmTM1J2sNHO9Z0TnDVOcWX1bTZyea/4ZnqLJbmzYdnOG9SgomEmJpeSW3B5DsPR3KIH5AOkjBdHcx3ftFxiHmsbga1DiUruK39oerVQgvE+QJ4+4BuvWqnMz7wjFhlGcqqEOtU9rx0xrNcxCmVphpUgDFoIFHtYBRxz1NIdKQiOW0El7OV6/ptCl5Uw9wQmsL/kq3dWdEwnkYLXkR990jTXLkk4MzLqszSB5KTTW+6JvJgPXO65V82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH8PR11MB8038.namprd11.prod.outlook.com (2603:10b6:510:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:01:31 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::2962:1efd:f912:a5a3%7]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 14:01:31 +0000
Message-ID: <114c4b2b-f619-4a12-ac0c-adca09fe6033@intel.com>
Date: Fri, 12 Sep 2025 15:01:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [RFC] lib/cryptodev: update API documentation for
 aux_flags
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
References: <20250827094338.767062-1-radu.nicolau@intel.com>
 <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <CO6PR18MB4484F38CE9989A01F49C8CF7D808A@CO6PR18MB4484.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0213.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::27) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|PH8PR11MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0592d04e-b110-4199-a3ec-08ddf204e004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1FtZnlkUzk5ckdaMHZDcUJ1WXhXUDcwSGY1SDQ4aCtZMERUdStzOEhlVjJy?=
 =?utf-8?B?d1lTVXQvc2Rid0ZDMktZZzFlbGU1OFdveWc0SnVDa3VTZ0c0VW9oWG1idE9i?=
 =?utf-8?B?UEFTR3Vud2Y0OEZVRFRjTTlOUUpYbGN0c21CTUNJRzErbjlhMkljOHViYmc5?=
 =?utf-8?B?Qzl2bzA2TktHOWxWUVF0ZWV6RWE3UHIzaS9oQVZOS1VMY21vNWVKMENUOXNU?=
 =?utf-8?B?dFRxaVRuK2YvdHJPUEsrOE1ISThxcTJZVC80VkhCemV2Q0dZTFZLY1krSWl4?=
 =?utf-8?B?MDB1elhyWlJIa3VSZHoxQ1JqN3kyODZ2M1ZIeEJhdjRMc3VlNWVyWDdyRjdj?=
 =?utf-8?B?c1E1SngrVjVLUmtHMUFJblBrbG1sOEhlWk5scVBmcXVYaTdnSEw0d3VCUUVT?=
 =?utf-8?B?SmdqemJJN2xpcE5zdUVDV0dzR2w4ZndpM3NkWXBTbXBteVB2V3RGMUdzWUZG?=
 =?utf-8?B?U0RsWFU0V055bk1RcjVUMWJVV0ZXZTJOU3hyZytoS2N2b1YyNjhPcXBQUkU1?=
 =?utf-8?B?ZVZFVnVtZ3c4b3F6TmVSSFROSGZTb0t0dEQwTlY1NG1zamJja09RRUxrSHFv?=
 =?utf-8?B?ZVZVZW5PVURYVUtWb0ZwUjg3QThGVW9KMy94SktKRFNETzNmUUJYdU9OdkhW?=
 =?utf-8?B?bEtUalZIY1FpUytpV0dhckVJdmRtdFExejJ2MnJhd3pyNUhWYld0RFpWQmFU?=
 =?utf-8?B?c0pNbTJ3VDlzc1FwdzF1elJXd09IZEYzOFpKcjFtNVhENmFpUXFFTGdFeXgw?=
 =?utf-8?B?cklMaU5DS21sTm5Ob2xKZktwcnJ6UEUxNHVpZUUxQ3ZHZVNXeEhyNy9Idlpz?=
 =?utf-8?B?RGxmLzYvYVBObVBXaUFMUXB1RGlnSGFLRnFOb2xpWVB2MEQvQlEwaUFBcHp6?=
 =?utf-8?B?YjJseHdZaEx3SWdMODB3b2NvLzEyWmdEb21lVnFDRFRCbnZ1U1ZBeW04L3ZU?=
 =?utf-8?B?ejhJNEJxSGlKRnRFVFdOS2JGc2dlbTZkSk1rcVZLdXYyUjBjV2VnR1NRVVhi?=
 =?utf-8?B?a1cvTU5QZlM3TkVQYldNU2tvcWtraDNQQTRmUXNaUE1TRGdnaFdZNVRVTm50?=
 =?utf-8?B?R2pNbGRFbTVYdWozcUNDenZ6OEhwY1FmUXdSUkpmWmhlaUJySHltUDFWQ2Ir?=
 =?utf-8?B?SHErMTh1ckdyZTFTT01FV2VOSXp1OVlwUTZMUnZRckhtZW5jK2dabm5NMTRi?=
 =?utf-8?B?MEF4ZFhRUGt5NzNCakpNbjMwRmdLdnNKR29lSWlGV2xTb093Y1A2bS8rc1NF?=
 =?utf-8?B?UTFwSVMwZXVTT1lzd1lRVjVxSVY5QUxVUUszRGJVMTNESXlsTllyOWhPR0dR?=
 =?utf-8?B?N0NkcWZsS1ZnS0t3V2NmTEpDRWt6ZTVuTURPRk1ZRmJwUUJiM2prTlBJTndh?=
 =?utf-8?B?Y1BubXZRWnBhMlIzdjdVWWh2RllTRHlTcS8wYUxreWM4em10dnNHS3FodDRt?=
 =?utf-8?B?RDNsb1Bqa1V3eHZZYzJhclRaYjBabWl4UlRheFN3eFQ1dk5Na2JqSEFGZUtI?=
 =?utf-8?B?UFhwVHBKdlNlS3JkWVNGK0NtL3VNSFI4WEFDNEE5SDhKK2tsVnI2eUIrdng3?=
 =?utf-8?B?QXhtdWNGbFB5Y1ZITm9GcnMwZDN2TDFMZE5xYUoxNGh1b2FIdGtUYkFXb1JU?=
 =?utf-8?B?ekRtZnlDelFsSWprLytLeUxXUXc3cHhNanl2bXdKdi9oTnR5UW5BSTBnenN5?=
 =?utf-8?B?czh2WVlLeDNOd2ZhQnc5OW1tekYvTHdaa1Zyd3VLSzh2TlR2NmdJcW1tZU9I?=
 =?utf-8?B?TXNBV0cyMjUvY3Y5c05hUkNUU1RoRVNOc21KakJUZk9IOEVlL1FwaFpHNlU1?=
 =?utf-8?B?bmFDRWl4YzN1aTR4UTU0SDE3UUkrckdCVHZzYkIwVmVjNTNnOHFaczhSdnRB?=
 =?utf-8?Q?gK3IDBXtj2NIZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2drUFJ6OTdZdlhZcW00QWsrc0VqbnpGYkRsbklNQkZ1NmJDT25wTTZMQVVT?=
 =?utf-8?B?Y3c1a0dHYnVwM043RzVEeTJqRSttUW5Tc01MYVN5Ym0xTngwYXRPSEpQeUVL?=
 =?utf-8?B?eDdqWTYya0tvOVZFUTRKektzbm9iRXBsMHBxdUxzOVhzZ0RRb2tma1pUSk44?=
 =?utf-8?B?bS9HdXc0eTN1NXdqZ1VDS1doeStsemFaV2RTSk4vdnRrQ1daUlNXMDI4WlVN?=
 =?utf-8?B?RWlhRlFaVnljaUkrd2Z3dHcyWGtaNEVSZkxPVDRTbnlIZ1VXQjAybnZjQnk4?=
 =?utf-8?B?UVhGS1Q5b1h1ZDJUdDF4K2VwU0dkeDJlNzJzaDhBN21zM2w1Q09kS0IxWWZN?=
 =?utf-8?B?Y3JUL3FweUxVMHB0WlUyYXlqY2h0STVLd2F6b29aaFJzSVNJTzFibktkRElu?=
 =?utf-8?B?blNhVkl6TmlBMEp2S1dMdm9nSlJnSk9UejVnL296blp4K0tzSnUrd2Q0Lzgx?=
 =?utf-8?B?c1FMb3V3V1NJUzVhUWdiZXRYVFpyNTNLTWlUNWZCenVWZ3VUQkJxMFBJM2Nh?=
 =?utf-8?B?aGRuNG9jRXBtZXE3aENDK005a0JRb3NWd3VwRkNRZTRBeFAvNmJmMWtTTVhx?=
 =?utf-8?B?dE9QYVFSeDZ0L2RsMDZOcEdsMjhsRHVpUEwwYmw4Nmg1bVczZUorcm9ic0pj?=
 =?utf-8?B?SE54dVpqMEROQVcwSkJxUy9hcXFhcEJHZzdaNEd2ekNpY1dKWEQxMWwrN29u?=
 =?utf-8?B?VGdNODRRTnF2elJTZHNINzBDd3c5Wm1BK3hpNXNrZFNFS0R2SDVvdm9OeWxt?=
 =?utf-8?B?enlJNDgxZThibzR3Q2hTVHBqUER6RDhvRFdDeFkzQmZnaHZiMWhsM2lKcU5x?=
 =?utf-8?B?RkpLcEpyUmEvWE9ab1R3VnUyMmlwdXdML2RQZHpUOFB1YUhJMFJ4cVBhWGNo?=
 =?utf-8?B?Uyt5aGdHQ0NUUFhsbGhkVG9QZUlJSkNUTXp4d1gvNmFhL3BKR25RQlRvblRN?=
 =?utf-8?B?OUZUejVHYng5SStIcGtXbTNIVTJzbE9kSUxLb2FyN2dPR29lZXlNRmZQYncx?=
 =?utf-8?B?QXVBd1o2UmZ3SkNiYVNpbEtrQzdGZVpCVTRaK2sxbVFJNmpBQStXWnFWMVNE?=
 =?utf-8?B?Z1c1WkhBOU8xWC9rTWVkbmdYTDFTU0V2eWw0R1Vxcm9OQVYyaDgvbDRnMUJI?=
 =?utf-8?B?Sm1Rc1ZFWWhpTjJJblVOazRiRjJwZm1tUVpKVFpYc3dDejZJMk4wQlJTQmJp?=
 =?utf-8?B?ajRZT0VRaXczQXpacnNqeDU4SGFVa0R2c25PQmFEbUo5NjlnbFBWMlNGUjJF?=
 =?utf-8?B?WTE4eUVZbmZTNEdQaEU5Q01oNE5NZUI3dndKeHo1NVlOa2d6ekU0L3I5aG40?=
 =?utf-8?B?VEd4bnNSK25Ca3A4SmlNQnoxclZYWGQ1VE1Yb29NbXBranE0OFBBVVRsYkwr?=
 =?utf-8?B?dldMN2hCOGZ3MVUwVnYzd0xuSlRxQnh1RkdCTEhxK05yNy8zenZkOU5xZy9v?=
 =?utf-8?B?eUJIZ0Zndmg1Ympkcm1PVmRUWEM3enJuSVoyNHZjV3lTWGl3V1ltQzVxRWVk?=
 =?utf-8?B?aFFLRWxQL1hWUGVMUTFFeFpzSlA4RFNwRHRCS3pXWFppYS9zejNrL0l1VTVM?=
 =?utf-8?B?YUY5MXdha29MMjR0YWVtbkMzOC9sbGwvNy9IZzFPUVIyNklCbkVtQUQ0aTkw?=
 =?utf-8?B?L2daZnpCcWpNd2k1OEdwamwwZDJ3aTltV1E3ODBWb3ZFaDhHWTF6ck9lSnNy?=
 =?utf-8?B?Wk9LU2pHaVFrYm5YTTZuN1RDNU5qS0FuMkJQd2Z4NFlheE4zRFdlaGxwa3Mw?=
 =?utf-8?B?M2R6a1AxSTZoOXl0VzZaY0o4eW9hU2RIeWJmT0UwN3BLaGNnN1BNNDFxSlVv?=
 =?utf-8?B?TnV4WkxZdUxzajF1bUJVV09DdjczOFVEZkRXc0Q2SUFJZDNKVE00aUY0clhF?=
 =?utf-8?B?NXhRSmF4KzR0MDFZRDdHTEd3WldmdzNRcmdveWNVVDZFYmxURXorc2NGY0V3?=
 =?utf-8?B?bVlZNU4vUXFuWnJzc3hJL1NCTTRjQUpFeUJXQUdaVXQzZFFQZXJKQ0MydUNL?=
 =?utf-8?B?Q21hdG94UVlTUlVXMllRMnRxb2FpMlVkclVXZjBZbU8zUTRyR3cxazk5MkhJ?=
 =?utf-8?B?bWoxbkRGdWNNeTRERjYvdlAwOVVFQVVjbFU2ZW10RmhnaEtNK1dxVGM0bnNH?=
 =?utf-8?B?VE5PK2swQXlUV0VyR2dFdDdUdW5sRW1iZ1ovQ2xOV1hobFFyV2pUeExiQllH?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0592d04e-b110-4199-a3ec-08ddf204e004
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:01:31.0952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YxXS0OKp7XoffVEJAQZzg8tfpj+Wb6L4jHOKR03m0Hzfa68Q2/r50RCtPitONpp5RrN38k5jS8fkLjxkB14ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8038
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

Hi Akhil,

Thanks for looking at this.

On 12-Sep-25 2:05 PM, Akhil Goyal wrote:
> Hi Radu,
>
>> Update the API documentation description of rte_crypto_op field
>> aux_flags as to allow PMDs to define driver-specific flags.
> Can you give examples of the flags that you want to add for driver specific work?
> I believe adding driver specific things here may not be good.
> May be we can discuss the specific flags and define them as common for all PMDs.

The flags we have in mind are very PMD specific i.e. controlling 
specific hardware behavior so they will not be suitable to be added to 
the common flags.

Seeing that aux_flags are not that strongly defined and seeing that they 
are already potentially used for PMD specific values my reasoning was to 
formalize this possibility of usage

aux_flags are used here to potentially carry a value that is not covered 
in the common API aux_flags definitions:

https://git.dpdk.org/dpdk/tree/drivers/crypto/cnxk/cn20k_cryptodev_ops.c#n857


Regards,

Radu

