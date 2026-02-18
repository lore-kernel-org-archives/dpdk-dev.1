Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BCE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:41:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBBAD40269;
	Wed, 18 Feb 2026 17:41:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id C64494014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:41:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771432891; x=1802968891;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=mLTBqyu32BC5W6gxjEtM5WS4hEhnVswerR1iP1czzsk=;
 b=isJpvVnJ6f68iV1A+Rn7/CZDYJs42lYyFrzBTBeqF+acTSP+3yI0FKrT
 br2bS1Vf2WA0VJljh7V8SZZhTTz0UEIFg3PNXGeS1LCR/LbJX7yNwGRMr
 O5xcoQYYAhQzRlYkWyet9OK+TfYYad1Vz5c1ymyvPzNNFF5vOfukJ1t0p
 l8ipSfxspthoKlVIVo0a2JmeuHxleGyMQFobqX+0BLEzUo7NIYLI7PwVv
 uCYp5dthRHbIHb42H9tPFz/l7x9SB7PLiWfjj/KvDs6o/zCCVM4NgZRTd
 pMZljcRurptSgsFods3P1EfrJOImiKLV8AftNGKIqEyDVi/eFvFP1jPwo Q==;
X-CSE-ConnectionGUID: ylV05gBcRIGKyAVxr/QAwg==
X-CSE-MsgGUID: FUcjEBAwRUCACW3FykWgZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="95135106"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="95135106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:29 -0800
X-CSE-ConnectionGUID: 10EEyprcQgeZpKTmudUBPg==
X-CSE-MsgGUID: 7I1lzXUYSlucGCcg4H7gLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="212578604"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 08:41:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 08:41:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 08:41:28 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 08:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEk0HfOw/Kyvs/isRFOw3trhKgB1M1M0Mnj3STX+ngZtfTszbL8bvIIdeu5U68d8Vhg8IoXHwgBGgMUDw+YORNgWfGAhH1mll0kSahgmTvU3fonN9mWlvM/VpKx4tbghVcVlrktcmwO+UjzeVwSFHbEpK1k7vZYO135GRBfh8o/R/10ZNfj9jb1FRV2kClLwCVsDKpdEwKUPcwth7EBKdjDb+5yqPCEAyhM97u1a3iFXxf8x9Xx6qfgoCiIwVbVYB1TZW8SIGgd1zC67YSq9NG520MoAZAE+j0P7GwWHPyah/zG9UqngBIGJk9F8eSR7chMtmL7fAqbf6ZBBYg1kHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+sdA0leDrEaUMeDDiitFX5In1HXAcLkbuDOQaCAUjE=;
 b=W0xHFGFYwBzlgFb0icVrENQ5NW1FOLkjPV5aNZqLw5Whwfv9LYCXk9WyUen9pNwONw2BhaHAGZarVPXs2VoI8InjsoePiBGUPSSx2nHLlutLjGbL3xlS0iaPuDc16qaYA1akYfz/lixwXrMc41UQ5Wx0SWQMoT+vmpakSYo2jQ7CjSoC9Pz5ONDLHBAWB8gQBFnu11OrMn4lyZCLI3fHbJD212iKqqWMbsOOI/K95t9TNxHhpylE2v9bCdYsqrvJGyLj/U0zC90Z1fEYMr1J+5b1mR/kOt+bsxdY1wIV5MOxxcCVE8qByvDRFiWTCASxkiOzYYLm8cudvBL5ZYT93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6838.namprd11.prod.outlook.com (2603:10b6:303:213::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Wed, 18 Feb
 2026 16:41:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 16:41:22 +0000
Date: Wed, 18 Feb 2026 16:41:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] doc: improve e1000 driver documentation
Message-ID: <aZXrreVOdlvp_ryd@bricha3-mobl1.ger.corp.intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
X-ClientProxiedBy: DU2PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:10:234::30) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: ec39c37e-f2f9-485b-6901-08de6f0c8c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REg2TDVLQXFSM0ltbUVETWNxLzdrazQwelRLaG5MY0o0QXF4ejhSblJJbmI2?=
 =?utf-8?B?eDNRTFh4aVdzNGZ5Tm1tRWtkRG9TUS9ZQVJZS01ad2o3UmlyV1VpUmJvdzJM?=
 =?utf-8?B?cXFkRlN3NUVIU3ZjeFhhdmtFOGc1bDVXMjAxZzM4dEFyVkt2Wmw3citCWmkz?=
 =?utf-8?B?SlhZSVlXRFRHa2w1RnlkMmZlZko3aitDc2picFo4aG1lTnpZOUZ4V0o0SWpT?=
 =?utf-8?B?TjN0VWFBT0ZKR2dLcXFpcE5LakVkMi94TThQYzdzd1cvNFdDbmNlamJjNEdJ?=
 =?utf-8?B?MHJtZGxRelhmaDcxUXJhNWJ4a0FySERRTFNiVE5DUjRZVHdNRE44cFdWQ1Aw?=
 =?utf-8?B?aUcrQS9ybGVkWi9VSWdtMG5nazBjV1RIa0w0Zk5qV0dUeFlsMDBLbWJVSmhH?=
 =?utf-8?B?b05LVitoMXNpT2o3ZWw3SHZwSDFlSWR1bXBUeHAxQ3NXeEc0YWMweXMzVS9j?=
 =?utf-8?B?NTBIZUM4Qkw0K3FaTzViaUJmTEVmU2JEc0NMalJTNk04OWhsV2VMMUx3emlF?=
 =?utf-8?B?RGNUa2phNE4rdE5XYlRMYnVXeVk0Mm82ajZ5bFlaWUkxYUpBT2dyUDBHOEJn?=
 =?utf-8?B?UGlNWStTQmgxeG1raklTZlprRG50L0tnSWVpQlRDNnZhejI2S1VQV1Avb3Q2?=
 =?utf-8?B?NFh6djZ6R0J4TUw3WWRaVGVuVXM0Q1lIeVQyaXl5bEc4RGJEUDhWWWlHMnhp?=
 =?utf-8?B?a2R6dDd5M21KOXAwTHRYbEF4TTduUU13YnV3bUZ2ZVIrMmNubG5PZGV4MGFi?=
 =?utf-8?B?UWhSMTR5dGhrM0tmVUF0dHhJRzdsVEVFVHNxU3JlOWVhWVIya0NrSHdmTnEz?=
 =?utf-8?B?bW0wVCtWek0zMG9FMysyWG5OblFkQzE4OGc1OVU0bERlT0JaNHFUTGNJSm1M?=
 =?utf-8?B?MDAvenVCdnpnU0JtL2FranpBbnl0VjFxOEkwL0ZzUTFtTW5Ed0V3NUhDVmk4?=
 =?utf-8?B?U3RibkFta3pLWmdHYkc1eGMwRE8rWjFPSk5GNHhyd0t3VDBTYlp5dmNDTnFT?=
 =?utf-8?B?Wm5sdHE2ZG5PMlFVckx6T3BNVHBIUDlrQTJkVlVDNnpLZy9Bd3QyRnlURjZQ?=
 =?utf-8?B?TnUyTTc0cGV6VFdWYVFaczRxbUJ5Uy9ZaG5HZFFFNEpURGJidXVyY1hwelFi?=
 =?utf-8?B?aEVwUmVxZHJKeHJMeVpKR2loaUlMVnkyN2VDWUxSRXhIdTFCV1ZmdFAwV0Q4?=
 =?utf-8?B?Q3lHYm05OVQ1Q0FteU9wd3hqZERzQ2FwdW8vRDRwTUxXRWhSc2NlZDlxRXFp?=
 =?utf-8?B?VHZFKzVTaFFzeG9EY0Q3RXZNWmJtTG1JRG14Snk1cjRYdzgrc1hnQzVHM214?=
 =?utf-8?B?OWNiSTJyZEsrNHBVSkFrUE9Cdmd4c2FqdUpLWnpiK3B1VTlFS0d4a1Y0TStM?=
 =?utf-8?B?SlB5ekdSZTdhNDl1TVNMQlpIL1dKZ2JFblVVTzVLbVVhOE5sYmNPbjJGKzRz?=
 =?utf-8?B?eHFScmsvQVBZRFJ0OTJZbTc5cUFtcjBRQTMzckJCMTFpN0NBTnMydS9PcXVM?=
 =?utf-8?B?SzJUZ0s3MFFxeXp3SGYycG1OUFdzNlJHci9uL0o4M0l5WkJXTFYvZUEvY2V6?=
 =?utf-8?B?REhLTXovclFJMGdtWUxSU0dFTmp0TlU0TUNYZnFWSlF3aGY2YUhRKzJSMlQ0?=
 =?utf-8?B?TU96azRzOE53RjVRZVdJZW9wcUh5Ymw1ejRhcElNV0JlZzhFcnkyd085NURs?=
 =?utf-8?B?QXNkaTJwdkt6VkhiVS9MakdOeUJiZThjV0M4UUdLdXlTbWo2b1ozTkdGM2VM?=
 =?utf-8?B?U2tCU0x0azhMVVhBdmpmMjlkbjFjVU1paUkxck5LVGFlUlMyWDlaRldaZmtp?=
 =?utf-8?B?R1RTRWM2K1U0Tm5neUxVeUpGdjYzNUZDRXRDSWFoQ0NqdXJUaVM5Vk42SkVG?=
 =?utf-8?B?Qys3UkFnQTlhYkZMeHFObldLN05XMkFiSjNPVTVpSSswN2NEcmVuSnFncnJH?=
 =?utf-8?B?SThIUkNHRXNKbG1LdjJTdzIyYzk0UUhhdVBhLzAyREUvTHBweFJHZTBFMUFC?=
 =?utf-8?B?b0oxNlArTlRPemxjZS9GQ24rVVArM0JHWXh3VnRHbmREbFplTkpUeUw3MDda?=
 =?utf-8?B?LzZUdmUvWDdqSEdrTU9IUHBjbEZsRzlMNXRKWWF4a3ZzYm5KemFxRCtseStx?=
 =?utf-8?Q?KQls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2xVbFFDOXNKTjJHaWgzR0k4V2lFZEZRRG9HM3M1WEJDVjE1dDcvdmtJSlAx?=
 =?utf-8?B?ZzdJeG5BVlk5VVltd3Y4U0w4ZHpHbnVEdUFWbzNpMm1jalYvQWhlbHkyUjRS?=
 =?utf-8?B?K0ZBbTBRdS9tTSt3d0lRUExqVFl1MDkyVUdvcG5QUWFnZ3FvTzNCTndIV2ZI?=
 =?utf-8?B?NGJPbG1YVks5aFEyaDRXWXV5clJmand1WUcxTThNREw3TVc0MVRmbi8vc0VY?=
 =?utf-8?B?Q0NpTFNkaENPTSswNFhkcWJPOUYreFl5Zmc3anJJZDgxbnp4L3lTN0RkN2U4?=
 =?utf-8?B?NFdITEpJRnhXMVhXMGNMQVN0Z0lIRldtdmRiTkFHYjVUcVBUSTRxTHVsbVV5?=
 =?utf-8?B?cmxVcmxnVEJobFMydUppbFN6Rkl6YlN4T3dwemNLcGNySDRUM2lPQnM3andv?=
 =?utf-8?B?TDQ4Y2E1QTJHUjRWeDhuN3JpbnF2YUE2ZFh4Mm9LRGJQdUM3d2NIeVJnZGFR?=
 =?utf-8?B?aDh1YS9PbUJ3VmIrcXk4M3ZkSjl4TGRlOHU2aUpDMWN3VkpjSmtnTmx1U1hR?=
 =?utf-8?B?a2RhTTd6UUxNS0hlSEV6VFpZVnVoR1gwYjJZNDkvdnlDd29aUzRaQWJnODM4?=
 =?utf-8?B?WUloc3NqYkVpb2tERmZhY3VMcUp6emN6ZnBCK0poRGdGenhId3EzS2NydHpt?=
 =?utf-8?B?OHdJTVJ6Tm5XcUh2YU9XOVVzNGE5R3RTU0ttem56Ym4zSGhiMzdLcGJSYjAx?=
 =?utf-8?B?SjJHcG9Hd3EwWHJ5VjNlU1ZMUFIrWFVlOHlzKyt2WUxEY3JOOFZCTWhBTW1P?=
 =?utf-8?B?L3o0SHhaNEpIQkJIUnVUN3Z0WUgwdVZhR285NXF0RmowUGFGS3Q2SDR6KzUz?=
 =?utf-8?B?ekd0bnBuVlNlZGxTUXhmeVdEM1FDaCtITVpuS0hvRGJxNGxyT2lDcU92d2Z6?=
 =?utf-8?B?amRlQXBRdzhXSndBbjJnZjhpT3JBMGpZclovM1hVM1FoSUExUFZhcWEwYkdP?=
 =?utf-8?B?cnpKVGI5b3dmMEZNZ3RKb3hRS1hoenZNSVlHYktaYVczYUlZb0liZytoek5I?=
 =?utf-8?B?eDR4ZDFzMTlramZpTGd4RzVDZUE0Z1hFZnJSU1lsQVhQajhVbS80amZrbjhI?=
 =?utf-8?B?ZXV6S3J4S3RQZGRvKzNQUjY5N3pyc0NiODNlaHpIOHlMQUlGeWVDbkYxRHJy?=
 =?utf-8?B?bm9VdVBLK0tLZXlYTkM2QytSaHVHL2lEdnhRSFBXZ2x1ODF1UzAvK3BFS3VJ?=
 =?utf-8?B?Y2prVE1YRUF5SmI1dUVjejZ5RFVqS0JlemR3RUFMUEd0U0ZNVzhtMzk4T0dJ?=
 =?utf-8?B?cE13ZmgzeHZDcVBSeFFZMkh2U2hiZHFnRFZQM0hBcFhLd3E4NG16dllsZ0lp?=
 =?utf-8?B?czNaemZMZ25nd0tDZmNjR3VjOFJBNVk2dW9zUFFlRFBJL0RjU0l0dDF0L2lI?=
 =?utf-8?B?ejZyR0ZXeUVxMmU2L1VoclhlbHE2Q0JTK1lOZUY4QjZwVE9DL2pQNjNsUERD?=
 =?utf-8?B?aEg3TG13dUgxWDdVUkovWHlyWGZXMUg2YUJ0QVVGTG0zYmZxMkFVQVdkSEJs?=
 =?utf-8?B?YzBLdkx0SG1RcjluWFhrSXE0U3cxVDE2U21udUp6R0lxbTZSYWhnOHVuNFRt?=
 =?utf-8?B?cGc4eVRBQjJuSFJRNVRJVk15d1l3bEh4YTdhRVBqVFdLc1ZpVUc3U0NMbDZT?=
 =?utf-8?B?SlhGT01yZXlBb2JHTGdlVjNXS0l6cFpuQmptNVJhZDhKWlJqT0ZYejVybDFB?=
 =?utf-8?B?ZVkvT2pPMlF2aTBIVVJjWkk5QlZ4UXd5RVN5Q2pwdnFVSmxZc2FiQTdrcFpN?=
 =?utf-8?B?bkNmTFo2dERZSlJYNzZpanZRWWVzdk9kSFJXc2hqd2hQaXdqQmRFVElpUXpO?=
 =?utf-8?B?YnhRb2pmRWwyL2JaaUNTNVhlZE5qa3Nqc1JGQ05xcmN2SmkyNXFwMDByLzE4?=
 =?utf-8?B?bHBTbTUwV1grcGRCQXRrc3MwcWROL1dSdVFZUFRFMEpEaEJxQW5kcVU1Y1R1?=
 =?utf-8?B?bmpsOWhWNjRKREVRbUNCcDZISXk3cWR5c0VZRlNrSnhDeU9BNjIxTW5yeEE2?=
 =?utf-8?B?WG9LL013UWovUXVXZ3FCNDVVWk8vK0J5eGRpZituRWI0azFQbCtUZ3RLTTlo?=
 =?utf-8?B?QkhVVy9CTStkZWU4Yy9vVkttbmViMWxKVkFxV290VU4zUkFKaUM2YWRiaCtO?=
 =?utf-8?B?Y3duQ254SFJSajJvTnZUeGR6NGdHRHg5SlJId0dtbFcxQlliMVRuZ0p6RzRE?=
 =?utf-8?B?NXc3K2E5Q1RuTUMwN0JFL0ZPeTJva2daYmE5VTd2cTZKMmZYT24xdE9sMTNH?=
 =?utf-8?B?N241RnBETDNyMHhHK1k2Q0JuaFZUdzF0WTREM0FneGxGc3Bwc2V2ZkVNamN5?=
 =?utf-8?B?TG5DUWxjUVM0Y0I3TnFUM2xwNnlaWDltT3ppWk10Q1ZsRW5TYXBUbXZqLzdU?=
 =?utf-8?Q?tVclqW3Q5JgbC1gI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec39c37e-f2f9-485b-6901-08de6f0c8c83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:41:22.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOC18iKf+scbv29nD3I2afSmgDNXc9ywMjMaWRg7Ta/W72jMW2OK/hta7AyJXfUjKjUlvyUQ9XoNsUDQuoJeoNqAS20TDOeqd31X3gJz4d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6838
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

On Mon, Feb 16, 2026 at 07:55:04PM +0000, Talluri Chaitanyababu wrote:
> Update e1000 driver docs to cover all Intel 1G devices,
> including emulated e1000 and real hardware,
> and group related drivers (igb, igc) for clarity."
> 

I think this doc needs a lot more work, but this is a good start. See
comments inline below.

/Bruce

> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> ---
>  doc/guides/nics/e1000em.rst | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
> index ed4f57e9c6..b2e09cd673 100644
> --- a/doc/guides/nics/e1000em.rst
> +++ b/doc/guides/nics/e1000em.rst
> @@ -1,6 +1,53 @@
>  ..  SPDX-License-Identifier: BSD-3-Clause
>      Copyright(c) 2010-2014 Intel Corporation.
>  
> +Intel 1G Network Drivers (e1000, igb, igc)
> +==========================================

I don't think you want to have igb and igc in the title here, since they
still have their own sections in the doc. Just use the title "Intel 1G
Network Driver" or perhaps even just "E1000 Poll Mode Driver" which would
match the title of many other sections. Rather than having igb/igc in the
title, you can instead start the section with a NOTE block saying that igb
and igc driver are included in the e1000 driver binary.

When renaming the section, though, one additional thing that needs to be
taken care of, is that you need to move the section in the index list so
that all sections remain in alphabetical order.

> +
> +Overview
> +--------
> +
> +DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit
> +Ethernet controller families. These include:
> +
> +*   e1000 – Intel 8254x family devices, including QEMU e1000 emulation.
> +*   e1000e – Intel PRO/1000 PCI‑Express family (82563/6/7, 82571/2/3/4/7/8/9,
> +             82583 and I217/I218/I219-based adapters).
> +
> +These drivers follow similar design principles and capabilities and are grouped
> +here for clarity.

When doing up the documentation, rather than wrapping lines at an 80 or 100
characters, it's recommended to wrap lines at punctuation marks, even if it
means longer lines. Each sentence should start on a new line - the rst
processing to html will rejoin the lines properly into paragraphs.

> +
> +Supported Hardware
> +------------------
> +
> +E1000 Devices
> +~~~~~~~~~~~~~
> +
> +The e1000 Linux base driver supports the Intel® PRO/1000 PCI and PCI‑X
> +family of Gigabit Ethernet controllers. Supported devices include:
> +
> +*   Intel 82540, 82541, 82545, 82546
> +*   QEMU ``e1000`` emulated NIC
> +
> +E1000e Devices
> +~~~~~~~~~~~~~~
> +
> +The e1000e Linux base driver supports the Intel PRO/1000 PCI‑Express family
> +including:
> +
> +*   82563/82566/82567 series
> +*   82571/82572/82573/82574/82577/82578/82579 series
> +*   82583-based adapters
> +*   I217, I218 and I219 Gigabit Network Connections
> +

I don't think we need these 2 sections, it repeats information given in the
overview section above.

> +Driver Notes
> +~~~~~~~~~~~~
> +
> +*   e1000 – supports PCI/PCI‑X Gigabit adapters.
> +*   e1000e – supports PCI‑Express Gigabit adapters.
> +
> +Both drivers are widely used across physical and virtualized environments.
> +

Probably unnecessary also.

>  Driver for VM Emulated Devices
>  ==============================
>  

> -- 
> 2.43.0
> 
