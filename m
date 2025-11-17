Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8ECEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95161402A1;
	Mon, 17 Nov 2025 09:50:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 80CF24026F;
 Mon, 17 Nov 2025 09:50:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763369420; x=1794905420;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=RiDhp4IYrz7L/czKP2kwqzU++i5JDGVKqZtSWivIzo0=;
 b=II1+m6URENydh8SRgvx442R23krEZOo2VMiB0ZKFhD17UXj3aJSs8UQw
 XytY2O9D/xx0Lf0SHpE40JARRrukk5PaLIaoXyP1gAb1AW5sMADhi/rFD
 PTF0NIOMRe4KuI8KEUXa3yS7t1DUSG/fyIZUzHxhsUij8ziULnMhopR1s
 yNEF4998yrji+kK/VR/GCuEB6TxGAZFPXdpviNLb61RG4zlLDZJ8x989F
 25y+5xvBq3zOS1WsA5Yxh/Xo4Ayxtx91vnERdEhI0kUrp+FG+N5k9KN8r
 nuVDx+COO8WsxE0SXPKIqw+dx9LY4T1wp3JMpq4snAdny4/1tiBgIVD0A w==;
X-CSE-ConnectionGUID: Pmvh446OQ5qzDqHywclscQ==
X-CSE-MsgGUID: kWZPbEZfT0q4T/vTiDE+KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65399101"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="65399101"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 00:50:19 -0800
X-CSE-ConnectionGUID: eMplhZtTRGeV5UK7eOCVaQ==
X-CSE-MsgGUID: kQQrAW/tTsaR3pHdv5en3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="189644250"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 00:50:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 00:50:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 00:50:17 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 00:50:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOtqah120UYZnsJmJFQ0CzOP109EwjnlwxA2lvlI627OTiloK8wcLL/4kIKqF7iZQJML8ISQ8CUGt4bsOXdM15JGmYb75eXlujxChLPB+529ISNAXUokeefIeDH5dWChHcHDkMgIPsJKD6aCCJMVm0thXJB+t5NEvxeF9eYOD9ayTlbafnyoHF9glgv/LuM4Iuqa7pwJ6H3uBg2y+GCiHVxBCNayfrHJFVfKlJ2oSZUYmNZhZpv/Ew7SVoTGFN2S1VvYw87JqR61UhVuZAe14MahKSSGZ4iWJiyP4ifvzJDatsGb4bRc9cw8F+XtQQzbaS14/oSyxsKTPtSU1o/eHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnosKbl+FzTjx1birPQjhWCOJ30nf7uUaOd4odYXqyw=;
 b=rgx6tz2Lv1rRv2aK0d8V3kZGuCmr775LqoNS0+vKTllJ9oHOGivPuFicRFCQqyXOdMKBZXdy3jb65Y1rRvha+bCWnCuLggtfVcCOq+eTURbdUoERAw6Tt2/RUHSymlBdUejmpvO4TOdOtQpKX8cdG/koOr+OzFoRDgGn9RBwe34ofDHB6NG7WXgXljSyCrLcMuVq4WAnfkMVK5svCc4a/yAl5As/PexPXlkv2DFFuZlOJV1CMqXxOEi5Vvk5sG76pjjDSSJgxJcS/lwcV7XF/SQ2TxJQpW1QecPUMxUTfNy7Oo4juOQSyZt48HfvfOOLxYGtrOjnXpAOXCDR/z6snQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF0DADD6EFE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 08:50:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 08:50:15 +0000
Date: Mon, 17 Nov 2025 08:50:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3 1/4] examples/server_node_efd: fix format overflow
Message-ID: <aRrhwnnH7MQT7Xs8@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
 <20251115193749.101355-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251115193749.101355-2-stephen@networkplumber.org>
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF0DADD6EFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0897a8a6-b909-4f9f-307b-08de25b65346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjZPMG9GdlplcFlhdGdaa05nV1hIekNvb3hkenpjMEpEQkxOTkhHOXRTSnhD?=
 =?utf-8?B?Rm1UTEpZZU5ML1ROZUVzNDR2T3NwbTJXenJJc2cwTWEwS3JTdExzYmM1Z1lm?=
 =?utf-8?B?K21DaFNqcGJQTEZLbDJSVjBmMnJWd0hMVjFtYWZRSlVyZno4ekhKVWhOZjZB?=
 =?utf-8?B?bmtHWkxDeXpPYUZVYzFuUkJsUzkySEk3eTNhd1JocTZGZEN2MWgzcm5MY2xy?=
 =?utf-8?B?YnB1SXpBN3lLaEhFVDRJMytYc1BXejRjMzhGakwwM0t6V3l5dWV5NlBhdjZT?=
 =?utf-8?B?MmRPNlVjMTRnYWdXY2RaQUNoWnYxVHYwMkZBWW40RXgvUUp6ZGhoZkZTN3dh?=
 =?utf-8?B?dXJ6aDFWUzRlNlZxMWU0U1N1blI4TllMaXhTYnAwa2pDQytNeElWSVovRFhh?=
 =?utf-8?B?R0o1Uk0ydlErMk5VN0oyeUEyR0drUGg2YzJuVGllV1BKQmhxRndUL2Rsb3la?=
 =?utf-8?B?M1lXRFlqWGNST1BIandRR01GMkFlNkR6Tzd6QmFzUnpyOXI0bkZuMWZPbmU4?=
 =?utf-8?B?Q0lBam1xYzFZOHVCeDBjd2drUG85eG5lTm9TWXAwcGV3RVJ5WFRFcUxzaWlE?=
 =?utf-8?B?RDlNVk9XZGh1UWFTZTVHaEVkQmtrcVpCaU5oNHNuaUIzNEV0Uit1MkNsTUVF?=
 =?utf-8?B?TlNXT0RmRWJOVm83cCt3L2U1VVcySVZ4QWZyWUxBNlk2Z1FGNk1lOVlSdEZZ?=
 =?utf-8?B?TnZvVDdVS0F2UklNbjgzVkliRTQxbVZtdWp6d05OZ2VMQkhKVXRXOWdOZ3dJ?=
 =?utf-8?B?MzRVc2dYU3J1VFBzRjYrQm9kclJtMmI5K0gzck93V0dzN1JlMUdQU1ZwWHNw?=
 =?utf-8?B?YzZWUTQvN2RFOUw0Y2FQTTlEN3pzOFFtVVlMUEhXc3RtbVBtRVMzcFJoMEQ0?=
 =?utf-8?B?eldOVlBBcUNDMXpEcmRRVmRkeFBldG1LRmJQbTk4dTgwbi9Ob2tTQ1pkUlBr?=
 =?utf-8?B?Ny82OGc0N1djRVVIZnA1Qjc2Kzl4NUJMNjZOSmdKSHdlREV5bHU0aU1GdXpa?=
 =?utf-8?B?WVJzV25SZ2dzaFRhS2RYRHNqZndUa0FnMlI1b0hLSEF3ancyQmFaVTN4RG0v?=
 =?utf-8?B?UllkQlJCc01uUGYyY1FISzBkb2FWUHZyZzM4eDgxQjJWQVppbkZBWXR3SXFK?=
 =?utf-8?B?ZVhOZTRlejB0MGNJODMxbTB1RFRaRENLd0F4cHlyVnEwMWtZL0ZOeW9aTmZv?=
 =?utf-8?B?dElhWUlGNUVLSkRkZE81WGpHYXZSSUUxYnVVWkdPNzRueVdjNms5NDUvdEFW?=
 =?utf-8?B?Y2NVUGYzS1ZxOGp5RHFhZW1XM2pQZVhGdVV4UXF3MVM2MVRTM01IWDE1N1RS?=
 =?utf-8?B?ekV1cW1rMnlXTTAzeVp4Z0F1Qklod2hVYjYzVHBjM3lndVJZb1J6bnYxTGhH?=
 =?utf-8?B?Z3FGR0tBZlB4UVB1elNidFVrNi9HeG5GSVZIZXhmUENIQXp5TFpKQU15OGox?=
 =?utf-8?B?OGNPMVFWd0dzR3UyNlFwZ2p1cTRtVDNXcFpyRFlUNU1TRGs3VzVCTDVvaktZ?=
 =?utf-8?B?WjFoaXhQRXQrWEVpbXVjZXorKzJ4QUVkZjBWVitLdDAzYkZGSkhuRkFRNGVY?=
 =?utf-8?B?ZWZDdHp3YlJDZjlRMnN1eUdBYTNEM29BQUM4eHRvZkF1ZVJLc0pKMldtVlFU?=
 =?utf-8?B?WEl6YTl4dnZjbFB2aTZpMSs2NGNzNkhVNDBRZ1NrN0ptcmZsVjJUUU9oUnFj?=
 =?utf-8?B?VnZWeWZGREE2K2JiRU1xTmZnZGZVRTBRMWVaOUZ2YWZEaDNUeFlaS0M3Q0RJ?=
 =?utf-8?B?K3U2NlUrWUozTFZOZXNzOXExZXEwN2F2eHJiWVlXZTZlVkZQdDlVMGJLaWRu?=
 =?utf-8?B?akRKS1RrTjdOb1l3ZHk1bW9OVVFaMHFlUkdPZGIzUXhoUmpHYmZ2MmNBTmx0?=
 =?utf-8?B?TmNITHZ0NFllL2h2NmZrb2RNSjNNTjQycE9rQmc3NFlZN2NtYWM4MDcvcXRV?=
 =?utf-8?Q?EQ33Hf0th6lh4o5jRkJSI9t57elsUCsO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TndaOGZ3eUdnZklGK3BCSXFpMmV2WEthWWNnQ3NBMFFZL1k1S1BDcSs3Uncv?=
 =?utf-8?B?WTY2MEd3aE5lMDUwZkRNWVQzb05obEl0VVlFRG1HRHIxVDR0NjBuNG4zaEtv?=
 =?utf-8?B?NFhqT2JJL1NFUWZPT1lrRUl3WGxXbWl5WGRSUkNITWJrUlRqU2Zaazk4Z3FT?=
 =?utf-8?B?dEl6cXl4S1E3Ti9FdTV0OFVBbmRSb3QxZEw0bk5XSzJ5eFFoNWZPODZ5b2d2?=
 =?utf-8?B?VngybkRsYU51dWJ1Umh6cmpreE83UVR5eWlSN2hxV2ppZHo2OEcwTlJ4dm5T?=
 =?utf-8?B?eDMwdTV3Y2dvc3Z4VGdUWGJxdnRDL3pnSGNySHQvTEdxSGhZa0tSVnBOS1FY?=
 =?utf-8?B?UkJIc080V3RaMTlWcFhUT1VueUN3aWI1OWtRaDVpTkxGVElBWTZPOXlWQVQv?=
 =?utf-8?B?U0tFTlRnSFEycVE5VW5pM1dhSmM3RURwLy94aUIzZGx2ZVoydzRrY2htbGVC?=
 =?utf-8?B?eEZOWkQ2VERxZkoxTzF6dHJjbWpmWERkLy9xaC9hSElPSnlDb0dUNWs3VmpI?=
 =?utf-8?B?b3c0UXRpcmJYMG5xd2IyQkhZSDdKckpvd0dCNTByemVESHRBZFB4K2RacDA3?=
 =?utf-8?B?K3dUN1hqOHN2cThRSU1MbkVacHM2QU5xcTdSRXFBWTc4ODM3NzZRV0RzSDRn?=
 =?utf-8?B?VWZndTJFcFg3TGlaRHNDeml0Z3V4c25SVStPWFhyUmt4bUdEV293TUJPYndo?=
 =?utf-8?B?SlhqVmk2VjNac25iQWMxYmRBVDhHWmk2SGZLZ0ZOQ0RWNU54ekxleG9ZQS9s?=
 =?utf-8?B?aW9ZQ3FKODFJTkRFUG03ZVFrMVdzSlhCYzBlZ3dGYWtaeVVwbEo1bVlrdkNn?=
 =?utf-8?B?N3pod2pvT0tOVUgvU3RpT3dKUFovNXJiVW5DMGxPNVd2S21sOXBWVFdManF1?=
 =?utf-8?B?cVJ0TVRFbGp4eng3elRQUHJiSGNBbmN6MFF0bnpYL0dYRHpFVnQza3V1N2lL?=
 =?utf-8?B?MytqZGhmV2NmM1dKenBnZlFUVGo5OVJGK1NMSWZrYzdTcWZaSVM2NjFOcW44?=
 =?utf-8?B?S25VZjZINXR6WW1qT1FTNlphTlJ6OW5sNUhvaVhnMmNRa2NFNGJzRFhqRG9M?=
 =?utf-8?B?aTNiN0M2cGdESHg2WGswcllGK2t6TWhtSlBkUXAvaDdrR08wTEhEVXU0TDQy?=
 =?utf-8?B?VTF6U3BwR0FIS2FhaGk5TWlxaU1xZEZiVndJYTNmM1h6L1Z5VkhXbThkeVpO?=
 =?utf-8?B?NVM4YVBXaEUrT2twWU5ZUGdJSkxWcGpocHA5RHVuVmttRU90VXdDNnI0QWxG?=
 =?utf-8?B?MnV3WitQUldVRi9UdTQxUk1GWjl5SytpWER0dlAzOGthWW80TkQrdnZ5endZ?=
 =?utf-8?B?T3Z4K0NTenRWRFJQODUvWWx0SlJ6WFcrK0p2bFZhbElXSkVXWmxBcHJrZ0pH?=
 =?utf-8?B?RG5KTExPbU5sckIwV0xtdXVKNWFDYTl1T05KeklWeXFTdmxQaDhEZW5PclBy?=
 =?utf-8?B?dEhoME54dWJWQkJpN1JBT2pqN2Z2U1pXaFpFTlRZL1gremF2MThhOXpIMXpq?=
 =?utf-8?B?ejBNL3hOQUVqejFCdmZtY0c5b3djNTFma0tieXFOcExVeEsyYXBtWDV5SExm?=
 =?utf-8?B?UVVIZWYvTk80YmVBYkxBQWUwNGhsOVU1R2UxTmdZR1U2U2pSZVplMTJzUmVr?=
 =?utf-8?B?blF0d3I0UlVrYTVvcnE3T2ZJWXQ5VHhHd1pybytNVWZETVhGc0hDNnNMVmcx?=
 =?utf-8?B?a2pLK09TdkpRc3VkdnZ6SEM1T3ordWNmUm05V0QxMWM0MHVPcDJTanR6RFlq?=
 =?utf-8?B?SlNyUitMM3ArUElJNEoweHdaZHZxMmNSc0JObTdxTjZqbW92V3JqSC94QXQ0?=
 =?utf-8?B?N0Nna1BWemV5QjQzOTBwam1STVdtTEJ4TWozL3Joc24zTWpmdW9jUDRRQXVj?=
 =?utf-8?B?aFhUYlJaVHVNVHBNempXSmRiMWZ2clRBY3AwRDVmWWc0QkQ3cnNrTHIrU3dk?=
 =?utf-8?B?Sm0zcy9ySWQ2M3FsL3NBYzV6bTl4UHRtYlU4Mmpsd0l0SnpOaExnVk1qRnZG?=
 =?utf-8?B?TFZQSVZINlpSdjRscEF4dzBqcks5Qnk4YU5sTHMzSmFLcjRhdTdHWXFxdTh1?=
 =?utf-8?B?YnNiSGRWWnNjTUJaci9pbkoxcmlrRkFEQ2l0MFkzdUg5cCs0MVFXZ1JjRGpk?=
 =?utf-8?B?QWxHOHlBaEg4R1JEbWRUSlZYc2JaOVByTjBKR1BFNUs0UXQ3bEFvbWFETkda?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0897a8a6-b909-4f9f-307b-08de25b65346
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:50:15.1944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w3c8byNxzXdxWatJUqyA8y+3oTq6pVQ6qDDOragMbfQ6KE/HClenUOqC/9H7MKlEFur1G33b+GTYW0m41gVfviUhIPHmZOPYoASusn1ivw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0DADD6EFE
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

On Sat, Nov 15, 2025 at 11:36:36AM -0800, Stephen Hemminger wrote:
> If format-truncation is enabled, the compiler detects a string overflow
> since the snprintf() is putting ethernet address and new line
> in buffer only sized for the address.
> 
> Since get_rx_queue_name() is used to create a ring name.
> The buffer should be sized to be a valid ring name.
> This fixes some format-overflow warnings and also corrects
> for future errors.
> 
> In file included from ../examples/server_node_efd/efd_server/main.c:31:
> In function ‘get_printable_mac_addr’,
>     inlined from ‘do_stats_display’ at ../examples/server_node_efd/efd_server/main.c:136:3:
> ../lib/net/rte_ether.h:248:36: warning: ‘snprintf’ output truncated before the last format character [-Wformat-truncation=]
>   248 | #define RTE_ETHER_ADDR_PRT_FMT     "%02X:%02X:%02X:%02X:%02X:%02X"
>       |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../examples/server_node_efd/efd_server/main.c:86:33: note: in expansion of macro ‘RTE_ETHER_ADDR_PRT_FMT’
>    86 |                                 RTE_ETHER_ADDR_PRT_FMT "\n",
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~
> ../examples/server_node_efd/efd_server/main.c: In function ‘do_stats_display’:
> ../examples/server_node_efd/efd_server/main.c:86:59: note: format string is defined here
>    86 |                                 RTE_ETHER_ADDR_PRT_FMT "\n",
>       |
> 
> Fixes: 39aad0e88c58 ("examples/flow_distributor: new example to demonstrate EFD")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> ---
>  examples/server_node_efd/efd_server/main.c | 2 +-
>  examples/server_node_efd/shared/common.h   | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
> index 75ff0ea532..62c3f4a16d 100644
> --- a/examples/server_node_efd/efd_server/main.c
> +++ b/examples/server_node_efd/efd_server/main.c
> @@ -68,7 +68,7 @@ static const char *
>  get_printable_mac_addr(uint16_t port)
>  {
>  	static const char err_address[] = "00:00:00:00:00:00";
> -	static char addresses[RTE_MAX_ETHPORTS][sizeof(err_address)];
> +	static char addresses[RTE_MAX_ETHPORTS][RTE_ETHER_ADDR_FMT_SIZE + 1];
>  	struct rte_ether_addr mac;
>  	int ret;
>  
> diff --git a/examples/server_node_efd/shared/common.h b/examples/server_node_efd/shared/common.h
> index e1ab7e62b7..6726e2031e 100644
> --- a/examples/server_node_efd/shared/common.h
> +++ b/examples/server_node_efd/shared/common.h
> @@ -58,8 +58,9 @@ get_rx_queue_name(unsigned int id)
>  	/*
>  	 * Buffer for return value. Size calculated by %u being replaced
>  	 * by maximum 3 digits (plus an extra byte for safety)
> +	 * Used as ring name, so upper limit is ring name size.
>  	 */
> -	static char buffer[sizeof(MP_NODE_RXQ_NAME) + 2];
> +	static char buffer[RTE_RING_NAMESIZE];
>  
>  	snprintf(buffer, sizeof(buffer), MP_NODE_RXQ_NAME, id);
>  	return buffer;
> -- 
> 2.51.0
> 
