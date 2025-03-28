Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F677C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 10:44:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D1B402CD;
	Fri, 28 Mar 2025 11:44:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id CCEA2402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 11:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743158647; x=1774694647;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GYa/0JrdQwZjZiNKfizIjREadYoSIDq+TPmxZZQPZb8=;
 b=A4dEc3xq7vJrYKamlw0bUwv/KEy11fJWMuSSEhp3X8FsfrJV1lmED/n7
 BskfNqcjdKeUwWuHHCSxkBYly/edzX6++pykjYtfqWCK6TgUXhBfzXqvv
 lM5lwQ7i9Rt9iV0m3aJJilv2ye/RnbSSSe27bOT4Kt6N1avPtP7jdVd5V
 HFW24mMdLZe1jbZpttXtbZ0YYPC9DNfo8tUA8bMfxQqnkdkGaB+C89753
 VIAGxSCcjCEBJIVwRGtKgO9+pHX6xD3KjwR6DwDVRSjJZFSXfd7LBwy70
 J+rqltyL0tG1MU9catWqTq3txVuJP/NFJ4ndsR8RgHoolCqK9nv42ORa3 A==;
X-CSE-ConnectionGUID: Vk6w7nOqQSKKB6qQdDia6A==
X-CSE-MsgGUID: dnWjwGjuTj+MScb87tn36w==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55884785"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="55884785"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 03:44:06 -0700
X-CSE-ConnectionGUID: 6YA7s5ZESyOpMA3MaJmv7g==
X-CSE-MsgGUID: Y/u/EqM4RAmthACllN3ywg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130621805"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 03:43:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 03:43:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 03:43:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 03:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQHTPjpVZOy8EO3TbRHRJv7fHxzDYD3q9LDUmzHtRpMpMB4hG8WNYzUw5aX7iC/mno72uBeWEg/PCpmGbynMnnNxt7x9SFg3MhjnVoV/Tu+1vicTMEojujTHJn0s7kdzGV2+Upy1N97U/ReGCSI9uiyEOVBoAnCb53b+pqpDjxmez/rOKuempDnNkcQkvAGWlHoIe3oJeUnRUWnOnTydp1QbeigeoptB/1IgGcbXhQ1kVVzKLNJqOPydBMAyoggBs1+RYyPNQhV4yfWiQWcJYDcKPBgxwyHcrzl3o2kUYmXf5LDIUE0IG6u3nNjkBH7h++EfYS1EuOvQSfTU5TBd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QR8kuquLHhbiAnV6ttxA6/hruCIYrSCO8UmbMy9vDY=;
 b=ENcMDhLkPAKHGX0zojdQTIvB5gImoF86ZF/MSHCh5ueFG4NFlrvT5eaw/AlSUOa8A3L6I7NRHIT2MQb1/xSRxlc2B11Hdu8qA9DuNj4JUDAZ4F14T6NdIitMUJ6bQWLXA3n9ZF1qaowZAUemtNYambeuYhcNunAUhJqy2L6YxUFwidmTPuUSM597yFkxNs4zhMyR1Fgb4Fg8+Phh8rqyFldAitbEtrF4QQZpzvl3rId2aLWymClSuS9X7mTVVQNPTbn242nydAoHvFsYi7EdBCRb4orBVmbLfyXwxJ/TAhNlM2ILv1EVBDkfSHmxlnAMXqrdABW0VQoqnZEjRhK0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6068.namprd11.prod.outlook.com (2603:10b6:8:64::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 10:43:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:43:53 +0000
Date: Fri, 28 Mar 2025 10:43:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 5/9] net/ixgbe/base: fix lock checker errors
Message-ID: <Z-Z9ZPs8k_lQERpT@bricha3-mobl1.ger.corp.intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
 <20250327145202.2220153-6-bruce.richardson@intel.com>
 <CAJFAV8w8YT=2DVbxrXef=60AquicaU8xehG2fvdHye_9dMi98Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w8YT=2DVbxrXef=60AquicaU8xehG2fvdHye_9dMi98Q@mail.gmail.com>
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6068:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cebae90-ecc7-437e-c6ca-08dd6de56f07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTFqazFNY0xFeTFzU0JPcDZYZUF4d3lPZE5xeDhzTXRscUNSRGRNdGJyNlFC?=
 =?utf-8?B?bFMzcmxZcWV4dTV2ZjN5eFMxZ2lFeTB4dzRwQjIvUW5DRmVSQXJKYVFzVTZi?=
 =?utf-8?B?NDdEZkQ4Nkd4c2J4MFYzWUZIY1NjZ01RMmNtWXd6dU5EY3FlNFRqbnp2Tm4w?=
 =?utf-8?B?Rm9GY1dxYXNUS3ZmY2psQkVxMU4xSUhOYW5jNWhTT0g3MUNpd1hKcXN3TFJI?=
 =?utf-8?B?b2ZaUnRyMGZDZlNIaUFMVTJoc0JiSm16d3luT3FwWVlOUmk0eEx2ckE0SU5w?=
 =?utf-8?B?a2RWdkNSOU8xb05hU3ZJTFRoY0hRVGdvMUVBMld3eW9KellTWXd5dFkwYndj?=
 =?utf-8?B?VFp4MGZ2Vks4aW5RcHRVNHZQQVZLRWJzLzR0L1hZRTgrSnVVVmxBenVjY1FW?=
 =?utf-8?B?L0NiYnhzZnVMZUVFWjlPZGs3Q2x0NDZvNGw5Z0NkRTJOeUhaQlZwMmVwOUly?=
 =?utf-8?B?cjJadkVxTnN1KzZaNC9KMUdmK2xoaDlCaHlmZmc2N3VoaE9NSzZpRitNWmdS?=
 =?utf-8?B?enlXME9LSmxIS2NyNHM0aUorOFo4R0RkN0o3U3laN2hSRDMvV3ZDbVl1elZi?=
 =?utf-8?B?ZGN1VmVwekpIRlV4UlF6bzlDOUF3V01vY2I2WnYrcVJtajN5ZGJnd2t4VitZ?=
 =?utf-8?B?alhUUTN3dXN1OXd5MXNNTWh5Z3hMQWVGayswMUYxakppV3BuUDJ3Wm5SMkow?=
 =?utf-8?B?YVNObGh4SWZJNmN2TUlNYWNaYWp4c2tJNzQxbHJJU1BlVSt5STB1aWtzYU9I?=
 =?utf-8?B?ZTlZdnk5Y1cwR3l1ODd2KzRteXFjcDJLNTNrWVY0QUtnVHJRMHZMb01VWHNu?=
 =?utf-8?B?UmE0L0dSdGZ2N2g0aEhMOXJjTXYzRlZZVUd4eVpGRUVtTjdmNGFaZnRqMk05?=
 =?utf-8?B?b0V6cEFqVmNpZkh4R2RqVnFUZUNDQWRrb3FvYkZESHhBK3FLT2RmcFRDdEMy?=
 =?utf-8?B?REZpcS9LL3kvMUhYNTdZOGZUaWRxN2VSdDBuS0tRNWc0eFcwSE9oellCcllS?=
 =?utf-8?B?SDBVcVNIUjRhMVZLYUpXbHpjVFFLR05zRllvcmNoSW5HYmtNZGM3R3grSDRm?=
 =?utf-8?B?SzdyODNQMjVsR0dHQU9EU25RS2VVUFV6ZDlVNE5PVmlCWkxoQjZicHdGN2sv?=
 =?utf-8?B?NHRFSXpvamxBb1Ztalg2WXVCRkYyVUdFRzRTUUlRbFppcVFMbGUvTEJLaC9Z?=
 =?utf-8?B?ZzdPckRHbDBpdmg2UkJYNWdvdEJSY01ScDBpeXMyNFZaQ1doNlFuVkhRVDN4?=
 =?utf-8?B?bmhGSEg4Q0pwM0NQVE1nWVRyV01yMlNPYmxCTWcyMWRSQThvY1ZUaEZFTGNV?=
 =?utf-8?B?alhtS2wrZm8rUGlFc3d3bXpNd0VuVEU5ODVXVUp3bkJQNWQxR24wcndQY0Nx?=
 =?utf-8?B?QmN2QnVKbVdtYmU4bXBaTDhsNGRtYzhJVnFpdy9zL28rZEtqQjdseXBpOEU0?=
 =?utf-8?B?VTJ1UjRvZTJwWCtjKzBpNkt2b0VQMVIzY0xsTjhFM2F6dThQSitUYnBJT3Zp?=
 =?utf-8?B?czhXZ0wvTXhJV1VyNlhKZUdjaDNWODdkWG5pNUhEN01XL1VDOCsvdHNOVjJ0?=
 =?utf-8?B?M2t3WWhrbDkxZ3BpL3htb0hsN281OWZQaERBNlo2ZTFBcnFiNTVSUHdwMGlU?=
 =?utf-8?B?TFdvVUdZMHc4ZWR6WTlCWVoyN2I0ZWQ5aGVvdGVpd1dNRWlsb1Y5WjNrbG8v?=
 =?utf-8?B?OWx4NTVFc0twbUtZOVBlL3RxcEEyS3JpbmJyWldmYkl5OGRsYXdjZ2VzOVpP?=
 =?utf-8?B?THZ4R2hxRHRaNXhKVkd2NXVWUUhPYUtPSnFLeWtvQ1pTaWg1dGtScm1Kb0VQ?=
 =?utf-8?B?cHVEUGd0cjAyQ2swR0ZIS0NIUVlueU5xV0NEODJ6bGV1YlVYNXJGY1dVb3Jx?=
 =?utf-8?B?V3VUbGJOdUgxdE1tZ3IvME1vSHowNE9OcjZBaDdlNnhmSkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFZeU4vZXVQRnVYdEp5WjVMWmJTK3djYk05SkFrM3NISDdlWHR4NithdVRP?=
 =?utf-8?B?d2xsK1lFSEtEU2NHV3cvVzdnTjhLR1oxNkhIT0hGVjNodDkyQlpIWXZ0dExW?=
 =?utf-8?B?bUlMNkVDRzIrc3EwZkxEdlQwY05sQnBqTFFnOGMvcWl5WkxEN1psbGhVdGxl?=
 =?utf-8?B?allyeEV4SC9uTEhoOC90TThpbnd4cHpGUTJKUGg2RkppWWMzTytrY3ZlblZw?=
 =?utf-8?B?aFdNTHN1M3JXNEZ5VnZ5NmJ6NTdZZUJMdGl6OTA4TE9iVUhlMVZ3N1kzV2JF?=
 =?utf-8?B?QlNuaEpTS2NnUlNQN3dHU3V5VTl5b3RvYVJaZnZPRXQ0VDB5LzVKb2tUVjRi?=
 =?utf-8?B?OElEb21oWGJoWlp4NGdVR3JhUE5rbG9UL0tkSHF6QXJzQWpiS3hJeEJRZzRK?=
 =?utf-8?B?Q1A0eVV6MzRlRndWZEorN1VtbjA3dGZaTytSN1I5VDhIdTRib3lLelB2WUJK?=
 =?utf-8?B?TDNtTi9HY3I0R1FQZnFVVHUvVTRibkMwc3VkU24wcmU4U0VoQytKN3ZnblVh?=
 =?utf-8?B?WEJZWnFlQlVoMXgyTDJZSHFJL0pLSERDbjdGY2VSdVZzaVgxTHJtYnNrUk9z?=
 =?utf-8?B?NUxYa0dOYytubk1TcnRBM2VnbXdZRHh5UldaekRKL05qQStLLzF3SVdBajlG?=
 =?utf-8?B?YlFvTURPRHlHQmg3VUxFZjlHU2lzODFpelYxdGEzNkdYb0RVOHU3MFNCVnNw?=
 =?utf-8?B?TlJydDkwL2lyOXFYUnlKSzVIOUJOYjlMUWtqZzl4K3dVNVc1dTNFVGhCVUo1?=
 =?utf-8?B?VE4xeVNVZWtrUDg2ME4vRDhkNlorVFZST3ZWa3UyTDN1SFhVMXRZcTQ1QnhP?=
 =?utf-8?B?dWpRKzVvUjZUS2JVYnJiL3hFU3RNR0x3ZC9VNlRZemt3MTVuakRjdG14Nk82?=
 =?utf-8?B?aFhETDJzRlZYMVlGU0dxcVZuUU1YNk9ZZDBpcmt5eWhmRC9yZFQzbGFrU0tT?=
 =?utf-8?B?empvdnUzSjduSGs4UjdiSFNvY0c4TjRyUXlyNzRjeGs3WXA0T2hoV1F3UUhD?=
 =?utf-8?B?cmV1OGZvcTFsOC9LbXFtU3FPd05iZUQwdE00eEFxYUNkU3dOY0JpeXZveEow?=
 =?utf-8?B?MFJMS2pWM0hIYitFRklMR1ZReWh2TVpHbjZtQllRdC9QOGgyeEFjcmFBNm1R?=
 =?utf-8?B?K00yaGo1ZTh2TWJYRlhuaE8vRkZCZjVDdGVwaVVBUElRdVJMWUIwOVBJZlVU?=
 =?utf-8?B?YzhxcXg1V09OOUt1ZHdkdExKbGw3eENWeXF2K1FsWlZ4RnBBN1Nnb1E4b3hX?=
 =?utf-8?B?QlhFNDBwSWE5K1JyUHFnSkdVcVdnUXZKZ1VOM0JZc0V2V3lmZ3UvVUdnOWNj?=
 =?utf-8?B?anVQS3ZuMktIRlRqdk9yS1JaT2wvSDg2cW1adGtSMDNyUHdCUm5pdEMyV3FB?=
 =?utf-8?B?VFZEY0gvM0lrOVVDZVYvZThwbGhyOFF0b0pVUGt1ckxqZDY1QVgwZy9vaEpH?=
 =?utf-8?B?NDZKTm5uVVR3eFh4NWlOdEdLZ0M1K2xHMWFGaGgrOGxVODRKU050dldTSVJN?=
 =?utf-8?B?My8za2FFK0IvZUJCeEF4NGRPTjNXazJXakI0MStKKzdidjFzZjd6VXUwWE9M?=
 =?utf-8?B?Mzd1OW1GQU9JejVkQ21SUThTNURhTzQzNVE5cHlCb0RtT1h0MkNyNWczWUl4?=
 =?utf-8?B?MEJkSnNiVE5Va0FhU2lYdWVZQy9MWGw3QUJGcUxmbkpmZ0xicjJNNGhXakU5?=
 =?utf-8?B?VWF6cXJDNlRkNWxFZEZjT0Q4dXFHa2hEQTVoUUdyL1VlREszcWNiOFJFZVhk?=
 =?utf-8?B?RkR1RlM5M3FuQVhSZTBuemg1NjllQTdJSG41WG5rNldwNkpINlB5SXl4ZzU0?=
 =?utf-8?B?bytzYVE5eFBjWS9PdG9TTi84TitkN1BTNzI2YnpLOTV0SVA1QjR6R05WeUUz?=
 =?utf-8?B?VEpYc2hqQ1FLU2drNnA0UytsQmgyY2owZlEwd2Z4RXczUlJ2cE54Zjh5YThQ?=
 =?utf-8?B?NDhtb3RNaXgrS1dydHZwNkg0SGhJV01jRXVVVTNrOEhocHJYYzE2VStJVmdJ?=
 =?utf-8?B?aVVvS3VwdjlTaHZYY091VHpNcHorclUyNXp6aFZXTGJPUEV2b3lLd2tQVVd0?=
 =?utf-8?B?S0Z0WmM2WCtjbGdkd0Zhc1VLbFlvUEo1bmdVMjJ5NWV2QW44OERxZ2xyU0VW?=
 =?utf-8?B?LzNiMHBnd29tbGVBaTMzUXRDS1NKeU0rbEFsRzlTOHBBY3hPcXkwUlIxREVU?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cebae90-ecc7-437e-c6ca-08dd6de56f07
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 10:43:53.6470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llPry1J6u9Ca1wmFXIKSfPekIb73lOWT9tcRx7Dg9rt3FYtxwV68vbtNeBryZrdjVFim9/1oYk0U0dnxZOgdyqYxFzqkMfBzfXUztnjl3GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6068
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

On Fri, Mar 28, 2025 at 09:20:16AM +0100, David Marchand wrote:
> On Thu, Mar 27, 2025 at 3:53 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > When building on FreeBSD, errors are reported in the base code by the
> > lock checker (-Wthread-safety). For example:
> >
> > ../drivers/net/intel/ixgbe/base/ixgbe_osdep.c:42:1: error: mutex 'lock->mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
> >    42 | }
> >       | ^
> >
> > These errors are due to the checker not recognising the lock wrapper
> > functions. We can avoid these errors by converting these functions into
> > macros.
> >
> > Fixes: 30b19d1b5c43 ("net/ixgbe/base: add definitions for E610")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> This is the best solution, given that FreeBSD pthread is instrumented
> with clang thread safety annotations.
> 
> As a sidenote, I don't see much value with the remaining
> malloc/calloc/free wrappers in this osdep.c file.
> I suspect this makes some other annotations non working.
> 
Yes, I would tend to agree. Question is whether it is better to convert
them to macros or just move them to the header file as static inlines. I'd
tend towards the latter, because otherwise we'd need to use "," syntax to
avoid potentially introducing other warnings for unused "hw" variable.

Here are two option examples, WDYT of each?

static inline void *
ixgbe_malloc(struct ixgbe_hw __rte_unused *hw, size_t s) { return malloc(s); }

or

#define ixgbe_malloc(hw, s) ((void)hw, malloc(s))

/Bruce
