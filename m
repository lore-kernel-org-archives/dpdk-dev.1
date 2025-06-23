Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092F2C77B7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 16:13:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35B31402AE;
	Mon, 23 Jun 2025 18:13:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0E75440151
 for <dev@dpdk.org>; Mon, 23 Jun 2025 18:13:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750695192; x=1782231192;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hbNwtG3tB8QsBaouZFWmw8Tl3ixCiK/e04HWa1IiqaM=;
 b=oCOAEzJhV7gEr6jMOZ2de/V1ibbKKz14KmezRJ5VbDlbYOAPxpoEUY8G
 MJNwG1Txsy4dyI3nlFq7BuFYgGmfJb9j+dwGvI6ch395L216tFkg3qUPG
 xq7r7MK60YB+yWWddKTQO6ofI7iEyH4kqO7BxSKhHDM8TQefLjjT+KKgC
 z7YhulcnWJPobkotwjhtEa9OMxN2tIj41GBaMmDJOamRWvSm4WEDmUNBM
 yYD4n7WwxXGaVaZZhWOVH/etdFo9utUz70Ecr4iui7xWSY2iEV1ew0jFl
 Kz96HsLDUppMRXc2PBK08dm7EVIXKDrS0paEgeysN0XdchcK7pFo0xrt2 A==;
X-CSE-ConnectionGUID: QYakXYRmS0ilXjW3r6jecw==
X-CSE-MsgGUID: tYFqHEHhSo6n667tWuynVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="55546150"
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; d="scan'208";a="55546150"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 09:13:11 -0700
X-CSE-ConnectionGUID: 5sdLiKmQRPm7P8ymeRv3+A==
X-CSE-MsgGUID: tG1+zunhRPqCq4GXlSxnFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,259,1744095600"; d="scan'208";a="157133908"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 09:13:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 09:13:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 09:13:10 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 09:13:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVZqG/5LuzPiZ26lR2+l1odtp+J1BUKr4NTnLsxPweaaTcuplyGzTkswEw71Pyn83AznMcRzajYA3GAdQ545Pf2iwWn5+0I6iKjUmZ0i9Vt4hgm7dLh9lgjx7+FJRmXKDE9bgXhfitw/M6RupOgtQGQiicS4vrw1ZBGF6OKXwVn0NfdWCQcxFZ4gOupT7B7lwDjKPFSTrLijFKlN4Hh2mG5YodpS9MF5qOuwLhHYGMtlGGWRjOsmCJAqXfwU8Z1Da3WyRxbZTmFR7qBjA+xnKQ60c6eNMQcaD94q4Ybxzw2OMdNQ3zrLfN1FmQ/GgrIc7NeEBxrnGrhCFrX0/JxQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXwGo3+9mkmFRGksGaPDzUtOZq+lvG7heGNKmVZyv4I=;
 b=s5D4o8N44ft3eiIrYupGrFOlrI5ha1KKWxmLEImIUXnpVzx7E8oq2TF7DQCRAwizEPnCPN+Ns7Ay1ixKXIIdN7UJSFeOwb4ISesusQT2pMcS0nBhHwpSUKowsej4NO30fjpgpiZDsKal819VK2oJ3X+DS40gwsp1nL+NxHibgTaJSadm3yXHSmWj5HubOPX3AxmpMiiBDR6d5j3eOHX0IFpmhK/McnJ5PSy7EUPm0KokEJe1h4OFJv68OzFvyZ9y1Ii7BgI+aIHBab8vVysVBYWUWfEHAkwLsA1bvm5JbWULvucTqekEjRToPJR6hlWQsfO57k7TUZdM6LUySYrm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 16:12:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 16:12:47 +0000
Date: Mon, 23 Jun 2025 17:12:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 1/3] eal: deprecate old coremask-based EAL parameters
Message-ID: <aFl8-3IuF9WU_YAe@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250527152913.279011-1-bruce.richardson@intel.com>
 <20250527152913.279011-2-bruce.richardson@intel.com>
 <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zpV=KUDha1tknK0cgv0cboG0htvJZ1kujtx=EJ7hXQHw@mail.gmail.com>
X-ClientProxiedBy: DB7PR05CA0001.eurprd05.prod.outlook.com
 (2603:10a6:10:36::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH0PR11MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: d0adf5f3-5b15-472c-2c81-08ddb270cb75
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djVSMEEzNFViYWE3T2pPTCt3anNoNkpEaGRVTzQxL3hLaUdhKzVHQmhYMks0?=
 =?utf-8?B?UENhb1oySmYwTTVIWWdmbXY5N3NTVEFnREFqL3BVUXVLVy9LYlVUdEtJUUZv?=
 =?utf-8?B?MEJTSW0xN282OEtVQnJEY2JpcFp6a0VwM2pia3lpc3hKUkVzTjJSbnBzNXpz?=
 =?utf-8?B?RGRVbWp3RXR4MUZOQXFNSjJKR1RmRittSS91N1lIZnFLTWZGeVpqTjNHYno2?=
 =?utf-8?B?U1FvNmt5eDVuSkc2Z1hkRXNjYW5TMEgrRGJoT0NCelFyaHAyand6bzRXWHZi?=
 =?utf-8?B?dkFzTGFsY1k4ZTBXamdUSTQ0amNxRG9pQlNvajJlaEVONzRmRUhnVmJvMUxZ?=
 =?utf-8?B?ZmJUSko5WlZvSWdIR2JXczVPTC80UFVNQVdpZnBodmYxSkg5N1J2aE9GVWNR?=
 =?utf-8?B?cE5QWXB0Sm9nMjJrREtneUt0bGtoM1h0b2ZROHdibE16RGJkY1RSZElUQm8w?=
 =?utf-8?B?TEtSelFlbWdJNmMwNUZlSkwyVkt6VEQ3MWRiMnQrWVU3cGdpeGtiQ2k0aUR2?=
 =?utf-8?B?djBtNTFaMEszNG5naXMxelV4dnp5MDArYVErZXd2aFNIRkwyS0RVRlc3NUJP?=
 =?utf-8?B?ZXd1K25LZk1HNS8vc05lYXZWeVBEOEtQbjZBRm43dHJvTTdLRGJnQTF5Ky9w?=
 =?utf-8?B?K1hVQlFTd3Y1Zk8xQVZObGI4dHpQTFdMaGpHOVE1SEpGZlE2MDlsZkx5cy9v?=
 =?utf-8?B?aWE4ODUydThWYkQ0a0JOSXAxTmhDbUVSUktZSkZrUFdDU0ZOcTdVK0tXK29W?=
 =?utf-8?B?RkVRWjJ0a01pMjB1MHBVKzliTklBbmpxVm14ZTA5ejEwbXNVTGNaWVhXTjRq?=
 =?utf-8?B?bGtISHhaYzgxa1RVZ3VCeWN2SlJaZUt1QmpSRmJaOHd0R2ozeWUvbDIzd0I3?=
 =?utf-8?B?WkZmT21yb3JpOGo4YjN6MmkwU1FiSTNmQVMwaUVkcS94MEdENHVhSjg2b2dG?=
 =?utf-8?B?TXNNK1YyZnBLb3RyN1k5ZDdVaExyaVE4YlA0UlgxdWdJNlZzanRqemRIRnpK?=
 =?utf-8?B?V2FiVEc1enJHaHc1OG16NGpBTGlvMGdDVVBzVFFwN2hjc2cySnhVVFZQSXlp?=
 =?utf-8?B?cXJ1UnY2SVlxN3lUYVhQVFNqNXoxVFpIZWh6L0krTmUzemVsUnF6ZHo4d004?=
 =?utf-8?B?aHBCc0czdW56aFBqeWtaQXpwSjd3b3pGMXpxOWhZdGhHRWYzQVBybElZcTFp?=
 =?utf-8?B?d09IdFFxNFlmTS90Y1R5US9xMW9wNFBhVmhWZHRUZlVwRjhrcTM5Q2ZVQ3h5?=
 =?utf-8?B?MU5DdWpQOU10a1lYM1g1b0NIODhhYmJIUUJXTUY0NG1YdEV4TXNLbU90a2Vm?=
 =?utf-8?B?L3JDZ0lLb2Q1bGY3YnBwOFhmT1hwN1A1VmhEYUVTMWE3Y2ZCRFBFOXl6dTVY?=
 =?utf-8?B?SHhlNWNsRFdsRHArWm51L3BNWHR4bUpaOU5pckxsUVA0WnhDemRvV1VoTytl?=
 =?utf-8?B?VFJRb1cxa0txZjhIcFQ0Ui9iOU1kdExyUzc1Zlhobnh1Uks5Z1ZKd2N0VUZZ?=
 =?utf-8?B?cko3YWJBSEVCekNEU0F1bVBsaC9yVVZETEFYNVBpRFFEb09mWnN6aDVlVWVs?=
 =?utf-8?B?THNtS2ZIaDFsSWU3NkdQVnRlVDM1R28xN0Z6L3E3UmRvVDZ0ODlZaFowbDM0?=
 =?utf-8?B?VGJobkFXdXpHOFdSdFdDZjBwRk1YZk5WeUJvc0VTSDlGZ3BlNHdXNmpjSHdK?=
 =?utf-8?B?MjZVL0cvdjVkV09XVG1RRWp2eER5VlplRnBlclFDWDlHcXlzRGFnRHQxMkkz?=
 =?utf-8?B?V3lJVnQ5Yms1MlIxQjJsT1VoUk5aMTR5cUcwUTIxRGsyWFlicUlSdHNSNFNy?=
 =?utf-8?B?OEF4RThCUjFGWHJudkNLbVR6L2M3WnJ6STU3RFpxRzNGOXliRnMwdU0xbmdE?=
 =?utf-8?B?WVg1TDdpNU1yekJWME0zckNEOWpiQWZKUktrV1ZtR0F5QzVaMjkyd1YwMUtV?=
 =?utf-8?Q?kDeKMMDR6Bc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnBDMGh0MytVQk5sRVlrQnk3MFZScHIvYytESGplaEgvM3dYY1kvM000Ti85?=
 =?utf-8?B?cU1zMUk3NVpPS3hlTVBPSlRWOFBBc1dMaWNRd0ZabHNSSDY3YWRHYUozWnFo?=
 =?utf-8?B?UjZ0R1dMSmNiU2tQZm1mVjU0RmFXQ2h3S1VLdUZYTWM3TXc0T05xcno1V2oz?=
 =?utf-8?B?NDVJbWNmdHoyNnE2V1ZEaysrWjhtZUZvbGtUbGRNMmhBS2t2ZXlJNElGWGpI?=
 =?utf-8?B?aUxkTllTdGZUdm1TZ2lWZlhmZHpwQkRiaWQrVGJlR0JyNWtDVkhLbDYxdm1y?=
 =?utf-8?B?UnNtUXE3UEo4M3hUTXBjOEpLWVhyaXEzZXl4N25mZ3ZFN21Sc2M1eUpLWFcw?=
 =?utf-8?B?YlZCclY4YmJmK2dRY1pJZFQvTTR2SnRrVGNVcGl3d3orenh6K0VCWDZSSWcw?=
 =?utf-8?B?c2hrc2ZrNThMM2puWkVuVUlTWVZXdUh0Wm5uNDhVK1F3NW1vT1hyTnd1Y2oz?=
 =?utf-8?B?SlJ0dyt2a1VQWkxMMzl3endzRVJBcDBTNy9DZlc3ZVJmR3VveXlmcHJvWTZr?=
 =?utf-8?B?MnhIK2REL0txSXQwWVdWREFGNDNyM1NVVFFEd0l3eVBsbWJTd0k4OVhEU2RQ?=
 =?utf-8?B?SEtHR2s0T2NDajhvU0F2WnA5ck9tSllyeGhzbnhzRlBvbUY4ZG1OTWNWeTBS?=
 =?utf-8?B?eFBGR05yMytKNjVQWVZtekZYWTJCclJVQUtnOWIrWjFTVmNBa3h6dHZYMkJD?=
 =?utf-8?B?Nmswb1RvcGFwM3FjUmpRNWpyVjgxRzdDSVgyc0l6bTFGeG5TaXZ3UUs5QXJZ?=
 =?utf-8?B?cjE4bmx3RTFEL1packgxUXMyNGtsUG9WRHpwQ0dNV0pQVHNqNkZKaXljSnZ1?=
 =?utf-8?B?NTRnbzlYUmxmdktwZk14MXhya2gxVWRFeGdBOS9LK1JSZWlnWEYrUzkraXU5?=
 =?utf-8?B?cFRNMUVsb1BvRGZ3b0UwOTdqMnd3cjRTanhDNFVQRUlCSlA3QmRHT3dxdFd0?=
 =?utf-8?B?RFRuYmE4SStBNUdrUEx3ME8wUS9OR3krZWxTWW12ZXlmSnVSbmZYdHo5bXI5?=
 =?utf-8?B?Y1BnQnBZQUlrdVBQemxUOUt1OWlyT0tJVUhjK0YyTlFzUy9VSGF2aEpUNUow?=
 =?utf-8?B?L29rR3I2TUE4TEtRdW1zUFFKUTBZeXdMY2Mxd2phdFJpcUVNaUxocDFrbUtm?=
 =?utf-8?B?T2poSnNnYURYd3IrQVczeC8zL3BrUEIrdmo4K2p1WFBtaWVabVZTQ090N0Ux?=
 =?utf-8?B?Z1RLY3hQa09iZ2RFU00wTlR5SnJyRUJtL0I3Q2M5Uy9obkRhZkhlQmk3RmtO?=
 =?utf-8?B?SmtzUE1NUEhERFNNTUJRMG9RMFpsSjA1alJXYzhYUW5oTUNuMEtqb3ovMHhl?=
 =?utf-8?B?MTNaUWJ2VjdPWTRyblJ5SUgraHdUNTNOUVdWMzhsNE1idkp0TWRUVUpRTkJS?=
 =?utf-8?B?M0p0cVFWUi8wYnNOM1FqeHQ2dTEvMlpUQUp1UER1cWtVLzZqckZJMVdJa052?=
 =?utf-8?B?Z0UzN3F4bExnZUdPeGFOdnkrRGZYMGxHemJVbE0rRVRYYXhPbEhNMnQ4UE1s?=
 =?utf-8?B?dUVPQlIzVGs1RUZJRCtJbUg4aUtrMlM0RnJndWZmVG5lQzkrYUNiNDY0TmpJ?=
 =?utf-8?B?b2I3bCtXUWc0WmpoSWZNODRmWW8zaVNhVUppc2hCL1JqL0FuTzVSVmtYcElh?=
 =?utf-8?B?WjhHTjBSdDdudU5qVEYzS0h3VEFlenpjWTlONUhxZ2creEZ6YlNDYlRmL1Ji?=
 =?utf-8?B?NkYxZFVNTkgwTnB3K2RyUjdZcE5nYXRqeEZuTWhWazUxOElyWmNwbFhZWWcx?=
 =?utf-8?B?dWZCZVZndWg4UGcxVUdFSjZwWFZSN0d0RlhVQ3VzVXRPMHNnQUhQUTh2MHkw?=
 =?utf-8?B?aDRSMzh0Tk1keDk2a2RFc1Vxd01IZVVyRmpaOU8vK0ZYbDM4c3h5dWNLODV5?=
 =?utf-8?B?Uk0ydEJicHhaN3NMcU9aKzVpeWFEaWcwTXdoTWYvVVNCMFU2OFJPWWVzNHdH?=
 =?utf-8?B?a0dyRVIxbzRJMC9uTHZUaDg2RWFoalVDcG5jVE5pbGlqVzhrd3UzMjZySXBU?=
 =?utf-8?B?d1AvTkZoVEFLK2V4VHEwaENjeDFGaHlmV2prd0FQNVNSWlUxOGcxUmpNM0Vp?=
 =?utf-8?B?WU83OUJaa2lkUWV2UFpVaU1scjJGSld2ZWgxRkhTaEhManY0RCtTS09HTTdi?=
 =?utf-8?B?VVpUKzJPR3pwY3dmanpqYkdPMURoMEJkTU03N2d1aEhhVnRaNjdST01HaXl2?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0adf5f3-5b15-472c-2c81-08ddb270cb75
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:12:47.8100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP8F+g9z6omCb4/U+QUbE9L7eRPw3oI7Mc+PWe2r1Cx8TI6owjw1oOjd6xVHohd0qk92qc8kgpGzKcKL8TPLA9z96KwXMZlT6+FopkwbWOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5249
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

On Mon, Jun 23, 2025 at 06:01:00PM +0200, David Marchand wrote:
> On Tue, May 27, 2025 at 5:29 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > As the number of cores/cpus on platforms has increased over the years,
> > the use of coremasks rather than core-lists for identifying DPDK cores
> > has become more and more unwieldy. At this point, let's deprecate the
> > coremask-based EAL parameters for future removal, and point users to the
> > core-list based versions instead.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  doc/guides/eventdevs/dlb2.rst                |  6 +++---
> >  doc/guides/faq/faq.rst                       |  8 +++-----
> >  doc/guides/linux_gsg/build_sample_apps.rst   |  7 +++----
> >  doc/guides/linux_gsg/eal_args.include.rst    |  8 ++------
> >  doc/guides/prog_guide/meson_ut.rst           |  2 +-
> >  doc/guides/prog_guide/multi_proc_support.rst |  2 +-
> >  doc/guides/prog_guide/service_cores.rst      |  8 ++++----
> >  doc/guides/rel_notes/deprecation.rst         | 10 ++++++++++
> >  doc/guides/sample_app_ug/ip_frag.rst         |  7 +------
> >  doc/guides/sample_app_ug/ip_reassembly.rst   |  7 +------
> >  doc/guides/sample_app_ug/multi_process.rst   | 14 +++++---------
> >  doc/guides/sample_app_ug/qos_scheduler.rst   |  2 +-
> >  doc/guides/sample_app_ug/test_pipeline.rst   |  2 +-
> >  doc/guides/tools/testbbdev.rst               |  2 +-
> >  lib/eal/common/eal_common_options.c          |  6 ++++++
> >  15 files changed, 43 insertions(+), 48 deletions(-)
> 
> This patch will need some rebase.
> 
> I see you fixed a few docs, but there are quite some misses in
> copy/pasted blocks:
> 
I'll take a look and respin this.

I'm think of separating it into two patches: first patch with the doc
updates to remove use of -c flag. This should happen independent of the
deprecation, I think, and second patch just the deprecation notice. Does
that sound reasonable?

/Bruce
