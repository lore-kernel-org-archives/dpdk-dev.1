Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50907C36017
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 13:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59DF740273;
	Wed,  2 Apr 2025 15:43:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id BAA7140261
 for <dev@dpdk.org>; Wed,  2 Apr 2025 15:43:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743601384; x=1775137384;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=AIOmIrxQx3esnR+sqk8j0dhw0f8+k3OQddaCtXFCnLE=;
 b=S3c91QFwIInuzhGAE8Nk1F9P9K4wio7dt3MJUu6rrWvDJu/hmlnMoExq
 dTShg2lV3C+gAqsAP7Zs/x7pjOwMkfYQhTn63GG4EvsM2up34icpkv7z8
 W5gjBShYtxj5c+QZEVzblrjuWIt1dHro+dupSVIGxrjVTdXzTvCgL+9cR
 XdKzWvrd5YGDJ1Ips5bKBoMMX2jYHxAmLoNG7CDt/vFOz019BhrooD9HZ
 6BeQl35WfzHd1Ww6wnB8nhGNfAdSP8fRKd7gk/9hREjJDFU8ztPt72g7u
 4T4d1g2W7dZQdcnydIfG+UXQCufMRPfkqASbc5BBw/bLQSE81yrgKLMI0 Q==;
X-CSE-ConnectionGUID: D4hM/fQgTkSnLRmwJRcMqg==
X-CSE-MsgGUID: x9cJ1lf5QD+PHucU1O6JBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44976093"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="44976093"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 06:43:03 -0700
X-CSE-ConnectionGUID: 1t5MJanfSXy3U7Fuzc9cmQ==
X-CSE-MsgGUID: WYxbXmi/TSeuf5Mpg2lSlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="126465381"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 06:43:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 06:43:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 06:43:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 06:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6NKN4cHb6YimzduwUQ1FYiv36PYPnpVb59lzyAMmpogK4aY4bYlAzFZJ2CwDv6rZf+krCPZ4Mx4/95u7VD+ldvBfOkWOAsS8UBDRHpViYIeBG956CBF3uVPGs4EahhfF0V+FGBxTtw1PkhYBtAoPTHlRuacBkLhI/hFM4hItqZARVxruP3TRR67Y1fGviZooNEbNy3q4skvNrASX1PEaazmN5Ay9wwgENvPdWEr6PMCVBExi0ijgR2WDJxTHOmB5vDFLaChPuQH+pQa/6hZspXB6MRhTQAp5BMV011tKUgod/wqaQPcBUOGyf46IW8V2CYw6HLj4k+LuXfSQNfwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaNKfw3OT50xGLLczvWSFwrf8z5vw2WWYtMq7q0P2cA=;
 b=NFoGQjmzmqAFh6pTWgTP8a0QTmMosl6ad7wyxE03GTlDp8U8syPgVyuHrvODMLMg0cYL82FpITBx0AcsTHepEAbkEHxzQ5CKBJy8tobp254/yTThyGjzwOfL6iUPQgl3LaAk5g7b8XnfuitzAonZGGaOBH/9U7NVG9j/fuqA2jmRvCLnycHE+vwbdIBVMHIOurOwWiU0ixsZHAD4OcmoH62AhMLw2nVOgULl4aLrWk5URFbWMnYo5Gn1gB9FQmzuTdtv15CeRy5hJbp56dBzVK+zt+rW8YzIX/5IY+ZOAySwqKfMHsoLQvmEmuJkurtZaganCtjcre4M27KtMIHHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 13:42:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 13:42:59 +0000
Date: Wed, 2 Apr 2025 14:42:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
Subject: Re: [PATCH 04/10] net/intel: use common base code build handling
Message-ID: <Z-0-3UmZi4m1_8ba@bricha3-mobl1.ger.corp.intel.com>
References: <20250331161000.9886-1-bruce.richardson@intel.com>
 <20250331161000.9886-6-bruce.richardson@intel.com>
 <CAJFAV8yOLW2SiTDg6QdyDmZJN29aV=Mtu0OBWP=0mRwOuerZiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8yOLW2SiTDg6QdyDmZJN29aV=Mtu0OBWP=0mRwOuerZiA@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0330.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::35) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcc35d6-5818-421c-0833-08dd71ec47b5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2dKOWpxS3ZaZmE4MUljektkdC9vRk44bFNBMkdxL2Q2VUtRalFhbkpRYm9J?=
 =?utf-8?B?b2pleDFuY2hzQVNDMDFQd1cvVmVWWGFQTUlZL0hQcUxvRjFHSm1YMG8wOHox?=
 =?utf-8?B?a2Q1YkswYlFDNkw5Y3FxUW1HNVpBcHVQSFJ4MkdxakhPaDN6RUk2djA3L1Bw?=
 =?utf-8?B?OE9BVS84U25kMFNBNENOSHdvZGxKbzZhbnNVUk1mdUFCaFY3MFdnNFVjMm40?=
 =?utf-8?B?UWpJakROb2M2RnRtVnNxNmlYSzZ0QkRGQWR4OEU4VnRyanZMTGx4TTNpaHV0?=
 =?utf-8?B?cGZqTDJKdEQrUWQybjlGRkJmTkZsK1VJZlQ4TVdtMURYWUtrZE5OV3dUc2Qv?=
 =?utf-8?B?UVRubGtIR2c4VXowa1daYUNNK2hmWER0eGVrNE9BR1Bya0lXZmJQS3ovRG41?=
 =?utf-8?B?VlBpZzNsNW02dmFPajNQQi9PQ0Z3YjRRejRsWGNSR1hFdEtvdFlyMk1ERkVC?=
 =?utf-8?B?S09YSC9Hbkl3T2NTWHFGdVI0VUsxNFJzRGRENWtYQXpUR2hXdGJrWncyd3Bw?=
 =?utf-8?B?SHl4MnIwbzVVWVM1dmtYd3pUMEp5cG4zU1ZlanplVmswOWVzRVV0cnc2L21W?=
 =?utf-8?B?ZkpPRHc2U1A3dlF3eVdQalFzTmRxZDFQOS9TNjJnaGc3eDZPQkFid0NPS1JD?=
 =?utf-8?B?R0lscnBUTGdoYXRjOFZDNFdtSzRPcmpKUE1LOGg1SWVXNTF1VDFSS2ZITlFk?=
 =?utf-8?B?eXZNektaUEVzcXI2QWZvcFFUUzhyQXJSb1ZoTUFHdjJiYVdqQVU3QWEwNGpz?=
 =?utf-8?B?VVlrYU1PY0xRc1hBc21XQ2o4S01LZWFoa2RFUlhqaUtHUzQwZFdoeWNJajV4?=
 =?utf-8?B?OXBwaTZud2ZGMVJoM292SWlaQXM2ZlQ3TzYzY1RLd0s0VVdSekZlcE5wY3ZB?=
 =?utf-8?B?TFcrUnYrdWMxT2JJQkhXUzFidnB3azVXWXVLbngrb1FSVFMxdi9XYkpyc3VY?=
 =?utf-8?B?V0dJUG9ILzRBMHlrU2ZMYlIvS2p3Qi9hdUFnM1ZteFB0aUttaW00YUVLTCtw?=
 =?utf-8?B?THJ6V3czYWpFTWZXSTlRa1A2MzczZnBjQlhPOU9KelFyNDhxM20xYzR2eDJB?=
 =?utf-8?B?Zk5OVFZ1aG1xM29MSnV3ZTVtcXNjMmNjbEV1YVN4bEVuYXFSZlU4a3NhNHoy?=
 =?utf-8?B?MHUrWGt1SFVwYVlaM2QrOUVkVC9xSERRelVVS1ZtSUxiQ21Wbk1hejJmeXM2?=
 =?utf-8?B?N0FFZzFhVUVjbVZBamJNSSt1V0tkSnBUdUEzaG5VQ3BvTE04M0Y5V1BJZE51?=
 =?utf-8?B?bFRid1ZQTFE4YkdnL2Q3aFRHSHhTWEd3M2RyOFpUQlJhckRkVkFVN25ycG5m?=
 =?utf-8?B?azlOQW1Yd1B1SzkrbnhxY2pvbFl0K09BMU1vMWNtZEVBZmRsOTlFNXVMQ1BX?=
 =?utf-8?B?SEhhRjRiMytUOHhTamJMbVE5a2ZTQjVCVHQ4REo4cTJObDZ2cjczOHlLdzNB?=
 =?utf-8?B?ckFST2lmZXYwY2x0cUtLUnBkcWUvM1RMVHpKbU1POTI2L0U3SzF5a3lZdW9x?=
 =?utf-8?B?ZVFKOXB3d2Y2dUFudmM5RkdYRW0vSHJIRm9pRW5uU0hTYml2VmYrbGNUaXBa?=
 =?utf-8?B?RFBPeEpNSWtPNnFCQ1NLZW5BZ0Q1bjNaT2VsdDIzZ3dqTWZxQ1g4b1Y5SkM3?=
 =?utf-8?B?ZmFRUFN6VUZXeW5kNHEreXBQdFJpU0pwYXNId3hoZUdNUjFMQ3dVU01NL05G?=
 =?utf-8?B?cDdMZTg1Ti9QREpPUDNXZjZyL3RWNzZCMkQ4TlVLclpGZDhpSG43RnFET1I0?=
 =?utf-8?B?a1ZacWg1ZkF1Mnh2TDBGQm1SZjBXdE92UXNwV29XcWhRN2NTOFhzbERLbWhV?=
 =?utf-8?B?cnlGMDZlNWFLcDA5UXV3OStoRTdwbkR3QWo0Y2laVFAwKzRtelpFUTFRWitW?=
 =?utf-8?Q?gliDfinik+21A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlSUEZkcGt6NTBJSDZiVkphemlZRXFEc0dLQ2x1U0FjVXFaQnE3cDBodHIy?=
 =?utf-8?B?S0d5QWoyOVRsVG5hdWNpMHE4cGNLQ0tSZkF4bmpHb0E4bFNiQitNM1EwckZM?=
 =?utf-8?B?S0ZBdUVrL3hIKzg1dzdRTDNSZVdna3BWUU1pMHFWT25RSUlDb21vOVdhL3dw?=
 =?utf-8?B?Z28zYXh3S0p2MnE1U0o0YWFQajh1N2xSTkVmTkRyYm9XY0p6SmozM1VRVWZi?=
 =?utf-8?B?eTdCMHZobEhLNFBvRE0zTVU1ZldOclUzVjZ0aUhsN2RObUVCcmRJNFd1Rjl4?=
 =?utf-8?B?WnNIVC85RW5wUVN5TXhBYyt3VmxSc05hMnNOblR2VlprVnhMNDh0TGdUM2Qr?=
 =?utf-8?B?YmxoQjUrRDRweDI4YVNSOGdCSWhCSXZLNUdEdUlrVGJhRXNhb1pPbWJVeDVW?=
 =?utf-8?B?clZQYTF2TEwxemdKajk4MWl4SWhhQWNrd29ydFFUd3c3YTEvSWllQlhNRnNW?=
 =?utf-8?B?RTdJVnpVdlRkdkhRZnROODc4Tzg5MW00eTl0YWJqMStIUm5KUlREUkRXMEha?=
 =?utf-8?B?MTdkeTNlUktEZTJNZUZQZ1JNQkZJa0N2N2lTa2pGZjFjbzIyYUpUa3NRcXlp?=
 =?utf-8?B?MEpPT05VcGMrMmNsWUlDMmJNWUVqdFhiQ1UzNk9EaCtjOEpoS0tMZi9rbUhV?=
 =?utf-8?B?NEdyQTg1UEw2NWZSRk9LSHZnbnpMc3Q3SE1UTDMrbzkxR1B2MjJvRVM4bVhJ?=
 =?utf-8?B?NjhDQ3BMWW0wcnlJRXJYcm5VZndJd0pLdXdEV2NJYnp6UlkxaDZqQW90OFhw?=
 =?utf-8?B?dytTT0oxSVpjN3k5R3gvckdMOE9pREhHRGUrWm1wUk9ZSkVJUVgwdFRGeGtY?=
 =?utf-8?B?NGMwK0h3ZWc4VGhleVdEOHZxRXdadEFZTGFZLzVONFJLRjZlNWtld0JGYWV4?=
 =?utf-8?B?MjFIY1Q4ZktOZktPSUhOY1FtbVdQM1paRm5jZ3dYNTFhaEhicEVwelFCZ21M?=
 =?utf-8?B?bkRaTS9vMFZaSDFTb0ptZWRFcXV5U0s0bkRVVXc1RTRkYzd2cm0zOUZsVHV4?=
 =?utf-8?B?bHd1UlpULzVLRW1YK3NSMWRFc3hKVmhFN3pMYWJxM1E2Rk1Ua1g3SEF2bzRO?=
 =?utf-8?B?bmRFMkZGb3pUcEZhL0o1VHJUaUNXbXh4bDYwK05vREcyQXpjbjQ1ZGNYb2Np?=
 =?utf-8?B?V3VIelcvcktiNXBMUXpOS1pLWGxRTzArUFprOFFHTDNaL2tZeUNwZ1ludzRB?=
 =?utf-8?B?Ukd0bzdHTXpQRHRoVVJCc3VON3IyMG1HcDNRYU9yWldBbU9zWUhjeGsxazRP?=
 =?utf-8?B?Y1VZK2VZQTlrVkl5UGNuOG92K0crOWZXYkdkcE5hZ0ZxREVPN3VSUmljeHlE?=
 =?utf-8?B?RFpRNFlTRUdOZDFsbmZXWWdRekFEN2YvRFZNYTM4cTlzM290RzRBL0w3OXQ0?=
 =?utf-8?B?aE5ITkt3RENoa3U2azdEOTBUdWUxZmlrcmNkRlhHS2ZKazByYWxqNG9TV1Nw?=
 =?utf-8?B?S2tGcjlBbm5QL2UvekdlNVlvNEd4MFU4enJZOWdkSEZuV3ZjNFZXRW4zM0hS?=
 =?utf-8?B?YzV4NXZqUklvY2FRWE0wUmJiQnZkNEE3SmsxWE82d0crNlduMGt1RE5vR0M4?=
 =?utf-8?B?VDVBQzBvSTBQcHExdks4akVzaXRJOWVLU3ZUdEpBVy9jNFpHY2xJRVduUDVB?=
 =?utf-8?B?VFBxWXhnT2daN1hkRUg0M0h5YXRUZU53SkRXaytlYzlyL0dyUnJwc2tMUXhK?=
 =?utf-8?B?b1RCcXdCeVJ3OXBGbDh1WmQ2L1FQcEFuQVd1dGF0TGIzaFF0cEVCcndwQlh2?=
 =?utf-8?B?MUowbE9NUXNzc2REOVA0aGpSYjIzMmJkcjBlRk0yNkZrc1phNEpydVBKVjJv?=
 =?utf-8?B?a1A5bG5Gb3pzbk9qaFVVYmVDMDRKaUZnY2pCenJzY1Q3eTJSV3VKdFN2VGFN?=
 =?utf-8?B?VkFuanNnZ0NXOGdhM2tTdWpzaHgxMW9EeDZxYkg2ZThDeFNzSlY3aldXemFq?=
 =?utf-8?B?S3dqcTJtZnN5bHEwVWo5cjcwdVBrNDlwSUk3K2NIQjBMWXpwNnFzblB1a0Iz?=
 =?utf-8?B?bUpKcUE3WlJzTGdVenhJbFZpM0hEaDVYYzdnTjZOa3hRekpyTno4dDRUVllG?=
 =?utf-8?B?V0lVWEh0VTN5Q3B3WFA2UXQrQ3I0RkROTlZSaFlvQktETlNickQvWGcrRzlW?=
 =?utf-8?B?SXhSRlFVY1hHUW00UVNqbVlLZzZLZFAzYXlCUFlhT3NSOVB5QVNQTnFXVVNF?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc35d6-5818-421c-0833-08dd71ec47b5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:42:59.1175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGKT3L+RTPWv5rDfUq6WA6nM1Mu97X+6F/A7eu3DYHCO4y/GbwIJl1IefsZRQaO7CkRY7/XIuiTSyCZYdu0TqVgOcYz6AQWCQZ1zsqvfC3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
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

On Wed, Apr 02, 2025 at 03:05:07PM +0200, David Marchand wrote:
> On Mon, Mar 31, 2025 at 6:10 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/intel/ice/base/meson.build b/drivers/net/intel/ice/base/meson.build
> > index e7ba9c34bc..f453005a1d 100644
> > --- a/drivers/net/intel/ice/base/meson.build
> > +++ b/drivers/net/intel/ice/base/meson.build
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: BSD-3-Clause
> >  # Copyright(c) 2018-2021 Intel Corporation
> >
> > -sources = [
> > +base_sources = files(
> >          'ice_controlq.c',
> >          'ice_common.c',
> >          'ice_sched.c',
> > @@ -29,7 +29,7 @@ sources = [
> >          'ice_ddp.c',
> >          'ice_fwlog.c',
> >          'ice_vf_mbx.c',
> > -]
> > +)
> >
> >  if is_ms_compiler
> >      error_cflags = [
> > @@ -41,22 +41,14 @@ else
> >              '-Wno-unused-but-set-variable',
> >              '-Wno-unused-parameter',
> >      ]
> > +    # Bugzilla ID: 678
> > +    #if (toolchain == 'gcc' and cc.version().version_compare('>=11.0.0'))
> > +    #    error_cflags += ['-Wno-array-bounds']
> > +    #endif
> 
> Why keep it commented?
> 
> 
This was an accidental change added in. In my testing with gcc 14, I
discovered that the warning flag was not necessary. However, I assume it is
still necessary for GCC 11 as originally added. I have not tested with a
range of GCC versions to be sure. Therefore, I'll just drop this diff in
next patch revision.

/Bruce
