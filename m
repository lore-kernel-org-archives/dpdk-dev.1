Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85441EE368C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 14:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C63F04027A;
	Thu, 12 Feb 2026 15:50:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B090740268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 15:50:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770907837; x=1802443837;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=lLRuqnnt2fnGmxkEnU5lhl8W3iTWj7CN9p7UCzu8tFA=;
 b=T5kaR2+oUC5j3JNtSWstJrBJIUQLGO2trdj/6MaXWUUhgCfTE05sWe1o
 sbEZ/G88pzE/VeTy/nX6v4yQ5EgBaBgIEmcLGDLEWfrI6EDT6CB1TNljz
 UUGSImmI7LKoUQtY6Lzm69T+A8NswikfpqMIZVHIKQ3Mw+GfwVFgeVi7H
 MWMqJei/84gxyOvKIlpFxioFiDRkCteOWBp/gXUwybMCxJUUKgBLAnTHS
 zdZ6IuCN6JPdikTIfuF2i1h6mry9UjyVoSW+k4roMF/XwLo+KkTpJ2LmY
 nu7IQJSnf+cLW4BZcKaHjDwQdSTHugQ6lPfj7WoxjhjjqOxn7coaoOHoP Q==;
X-CSE-ConnectionGUID: dH9q/Wd9SYiyiEGJOTIk+A==
X-CSE-MsgGUID: euWAFd10TOusNtGOip14iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71796188"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71796188"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 06:50:36 -0800
X-CSE-ConnectionGUID: j3ORWPEIRkK5+V9KxSzkFg==
X-CSE-MsgGUID: XMJotj9ZTqeUJIdDJsoIDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="211868045"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 06:50:35 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:50:35 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 06:50:35 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:50:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRObuC+3wtyNKTHAt/LGs+PFCQVNDWZ966mU3vrFHsFmW0mW5HckPKqa7b4he+zDSfFo1QmkO+Etg2qe2x4xukZcvRdf3EumygFRBArJConhBbPr3egEGgadhn6osaTZokF1LYSr40XfWC8XQzgd8USL9diEaAYJpAoi64oBNQ4jYOd3EtZKE+d8E7RUfoBx/6YYvMrKKs0QnfW1YN2guI3egwsG33S+MOpq0TosWUnnhZ8tCiYvpieirrRR8RoDVkEVI8NMQ0nhhBDHr/xru9OCatXb3AY/QfvhxbVyWQRL7+Qh3vNUoIzh/TzZ46es9Nqr5lOnS7ak6lwheTNYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfO41/u/FSRYts4TL5LN7twMhb2UZy4LzyzNi3IWsAE=;
 b=hZkBLeVugRYj+oU6w1tWVNWB17KUDglXOMxUWDGnQuVL0J07bwlUE1mq4od9Iy4WJ9qAlC2WJGqRjSwXzv9zMXWdnazZwLz5sQATEYHN0WhMdbqqSzPG1WSYnokyH61+BUPWt+RMcLl219VqiQIzY8psioEP/o+POiW48V/FKmNNbDZmRa+nsnzEPp+X76NjYJ/ekwi7792Q69503svpiCtPEkIcPKkvUdSdlOTEBQA+DK4NRiTmu/Jl+9urGWPSGBYaCZOTNAneVUKBykTMh0i2qmn9K6ZGPwoziox6oRWOV5LLvIUlFcgact74bJwuIi8WyrinOgZcaS+Q/78eLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Thu, 12 Feb 2026 14:50:32 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 14:50:32 +0000
Message-ID: <987bda2e-d92e-44f2-ae04-2a9dd6143b49@intel.com>
Date: Thu, 12 Feb 2026 15:50:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] net/ixgbe: fix wrong pointer handling in IPsec
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Radu
 Nicolau" <radu.nicolau@intel.com>, Declan Doherty <declan.doherty@intel.com>
References: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::12) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4a8bf3-f04a-4bd9-045e-08de6a461222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmVralEzdm9tb0lXaG0vOHd1U0p3cmdxZXNuUjJ3bEFMazdNT3QrdVRXUk15?=
 =?utf-8?B?VlgvRFlhSm9raGhwV1F0QUxvVHdLdVRBUTB1L1BnV2F5VnZUY2FkQ09nN2tO?=
 =?utf-8?B?UEk3djdqWGR4bElOWE5BOEFmTmxmcUNKby9BZ3pKaVRiWjNMUnFBWjZaTW1E?=
 =?utf-8?B?aHdpc2tYNFgyY1gwbzQvMW43Q3RqKzN3cFVHVDBLQVRGSEt6elUyVzJjc2hN?=
 =?utf-8?B?dGpMNmxWQnRCUWVCUDVxU2tMNVRXNmhGeUZkd0xuVkdFTlJmZFV3eUN0cWZt?=
 =?utf-8?B?U3JWUXlnbnRsbVpPbFZtT0xoMmkvYjFCdHNScWRmckJIYnZXWWkrUmMvNVJo?=
 =?utf-8?B?ZkU5OGxoU1BBTmhlK1BzU2Z0RGxZNFlJR296OFZKNGJLR3liWHR5Qjgvd3Fu?=
 =?utf-8?B?d3J1Y2M5Nm9QazBqdzdHT0ZNNGtJMEoyM2llMjBPNEVreDlPTFhvZDZXeSsz?=
 =?utf-8?B?bFVJS0k5L2FGckJqbDExbVA1YnVLVnh4ZnhhbTVFVUpkZ1EyUFNKcjBTZ3lq?=
 =?utf-8?B?UVcxend4dngzWWdtM3Vab0MxRHRaZ08xNFZRSFBCaEg2M0owa0pmU213TThq?=
 =?utf-8?B?QzhlM0JFdVJpRUpYbkZBUllac0ZtRlBabmd1cVczVTdzcTRjMWd2MzNFdDFr?=
 =?utf-8?B?dnFNeGZMS2d0WFlXcWRIWDFFOW8yRDhPZC9JRm5yeFNaa0tEWFZUK0FwYjND?=
 =?utf-8?B?ODJMaDlRaExFVHc2SnZEam03bFVqazlhdnh0aXVTa0hMc0k0U3lqZXFFdlNy?=
 =?utf-8?B?RzBzcEk3MGJqY0RCQWZleUphSVhIUC9CeUpwVlhNY0N2TXNvelFGNHFUeEFJ?=
 =?utf-8?B?MWd6WFJSRWV2alhqY0U1VzhFdndPcjBZaG8xSmFGQkp4YmdVTUdpWTB1Z2pa?=
 =?utf-8?B?Ty8wNVZYMnpULzBmbG1xNW1xRUJDSTA0UDIyMHRza3VIcmxPeGxERDh0THYr?=
 =?utf-8?B?NnlLdnlQTGdBdUVvQzREaURnWkpSZTZvUjFENDREUUlLc1RUU1JUN294Q1Nu?=
 =?utf-8?B?VElMMXM1Sm9seUgrakFIWks5eFA0dHBBdFZQaUROQUNwbFVQMTB5V2dvMFJW?=
 =?utf-8?B?NFpKTFpoRVlhYXlGclNuV050MUVReDJTYkRQajJlMXR5bmcvZVpqU2MxN2xE?=
 =?utf-8?B?Q0dDNlB3Z2pacFRqbExIRGhaSEYwK0wwVmkvNFdFWlE0ZHhSSlliTVVTNTgw?=
 =?utf-8?B?YWQzZndlWlFMckpqVnBoUkNsZzVRcjN2K0M0MFQwL2ZQOGMyTEt0NEZCb0tp?=
 =?utf-8?B?S1prelZXOG1xN1FrRGFuV3QyMk93ZkhFUXBBN0RyVFE1bTd2NHZVRytoWjFv?=
 =?utf-8?B?Y3RaeWJOc3h1MktLd0lWUHRWWW1McjRyYlFGbFNQTGZxOFNkWWdiK2JQYXBH?=
 =?utf-8?B?bkZsU1F4MVpuYi9lTkova3dHUjJ1VUwrSzZiRFdUcVc4OXZ0TmtUU2sxZUNv?=
 =?utf-8?B?SXlWMzdyL0R0SEp2MGdTN1ZlWDRrVm5JSWgzWGVRWUlsVlR0MXFNSTlQaSt6?=
 =?utf-8?B?blRRbnlFYnJzRHBGZ0FNQVlsa0cvQ0ZCc3JBNFRIbmdqbWYwY3NBc1h2Y2t2?=
 =?utf-8?B?MDA1L29vSXNHcnJJRUo5bFZYVzJRNFZBckdJZmxnZmd3d0JpUHRMTjBZWHNn?=
 =?utf-8?B?VUJzR3Nvc2RJZC9HV01XUGdSdkdSK1krSFRGa1FFVkQzdUxzMGY2MS9FbEJy?=
 =?utf-8?B?dU1sQnNLOWYxRHpqQXRUamRmRmZ4NmI2RGFBYUdML3RGRnpvQjBqZ3VXVWIw?=
 =?utf-8?B?RXBXMS95WWExenh3VDV5Si96V3Q2Q0xpc1kwTFU3SllRZ3o5UjUwMFFUSnpI?=
 =?utf-8?B?aHcxQWJ5azNJV3g2ZE1NTyt6WkZtZFpBZy9sMVBjNTNVVXpPbm42YzVya3lx?=
 =?utf-8?B?THRDSDJFVVdJakFTcGNRTEROY2l5OHJGT1RRd3pmSjdvRTBDWDVvTUVYQ1di?=
 =?utf-8?B?QThPUHdqYVdUcVRsNGkxbk5rVmFOQ1E2QTFZMVg5bDFTbXUvNHhkblEzZkxI?=
 =?utf-8?B?WlRjYWFOSjFZR1pXOEVkRzc3TzhVTi9JbDhlQlAwUkJiMXFlNWxyWVBNeHk4?=
 =?utf-8?B?STZRY05qVUpwTUI3ZW9VcnVsL2FSbnk0UjdacTdNcHo2Q1NSZlYrWkppcTdT?=
 =?utf-8?Q?UnpA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZvUDVhd1RyVm1uK25nT3ZZOUg5dkhLaGZVSEJqQTRuWDREU2ZUc2RmcHZk?=
 =?utf-8?B?MTVRdU15Q3RPVlU4TUNHQXZCNUVqK0g1Ylpkdk9mNkJBK2xVaGIzUlNGT2xS?=
 =?utf-8?B?VUFlNnhGeTNQUkpXeWxNRmRZM3I1YnBFQkdPQjlPWDR5WWNiazVDYU1zRDZ3?=
 =?utf-8?B?bDNCOVNRTURyRkpadnVVTEUwcmQvMHJoM1FPYjhxeW1aR0tCTmxQWnVkckdu?=
 =?utf-8?B?dlN1cjYvMStPLzk2Q2JjM2h2SmpUR2NES1djSmg1bkxWcjc0VUxFR2F1dXcz?=
 =?utf-8?B?bXVCY2tiRW5KVWVTZXQvTXN4SmlubWJqZ3ZtYkF6OGhBOHY4U1lacitoaU1u?=
 =?utf-8?B?aE1xZEVJQVNkWkp3N2xscVd6Smx3WW5pMjAwT2VxZGlxMnEyKzFlZVBiamVi?=
 =?utf-8?B?YitCdVBobUFkeTFTUXg5N2ZwdG1HWDhpQjkvak9OSFZBY1pKQm9DU2N3ZDRh?=
 =?utf-8?B?NzNDbnBOUVFtSEJCcW9LbTBlU2NmSUlKWFhQZXZXcGlPQVoyUmMyUmNZNXc0?=
 =?utf-8?B?Q0o1QVVicElHMjdsUGtkVGNBcDRET3JaZHcySTdUTUtTMHhtdGNXT1lRNFpI?=
 =?utf-8?B?T3BqVnhCQWpnVjU5UXlnZTJMWTBSYTNjUlNYUUVSeFR6MGsveWlaVlpXSlUw?=
 =?utf-8?B?bjNXT0o5N0w2RTJwYkdjMHlwcWlJQ3E5dFdMcGtSZTViaW1vdFZNT3ZLWkNK?=
 =?utf-8?B?bHpyLzYzT01NQXF6VWxnMWFHTHovb2tQOW1XM1B5QXl0dGNKQUR0R3Y5WEQ0?=
 =?utf-8?B?TVYrSmRtSWFtc3JmdFpnZWtXNDFHTmsva0VxaFNHdU9zeXRzSkFwOStPTHJF?=
 =?utf-8?B?RWY2Z0NwNEZ0cENDcmp5R2ZuQ1hHb25wdE9XRHdHbjFWQ0dqNW14bGxGcTBh?=
 =?utf-8?B?U1JMN1Nhb3BPbHdoWCswam5UUzl6RnVYK0ZzVnFoWFJXN3FJSkptOFlUcWt4?=
 =?utf-8?B?VEthTHdVT2hpNHR3NXRqOG0xVHgycnljYTY3dnRhNllzY2pWZWtCL2RnamZI?=
 =?utf-8?B?OStDYUhNNmt6UWlNVEtxWkNPNzFRcXBHcUl6Z0tKQTBLZlpSV1JHK1prdEFR?=
 =?utf-8?B?aEl0WGY1Q2pSczdxMXFzdGk2Z2hPWXh1Mk44THJMRWlCSVM4ZTF0UDNrTUdX?=
 =?utf-8?B?ZkhnL0IvaE9wemQwMHhXM1R6MVQraHlhOXM2RlVnM1loSW9Ock1DSGVXMjB2?=
 =?utf-8?B?V3MxdGVYYVF6cnlwOVQ5blVJWURLWnBHYTNYdzNpNm9SL3pKbGdXQ21oQ21K?=
 =?utf-8?B?UkdOUTR1R2I0QnJoTG1aOE96NWdzT1d0MUVqOGsvSW1nZGxjMlRnTjEvTk8v?=
 =?utf-8?B?Z0dtWXJhU1NGREt0dGJlSXdVYUttN3duZEtGWXJFNVNhc0FzZE5mR3l1c1B3?=
 =?utf-8?B?MGhVVjJCbmN6Zmh1cVEyWWIySzNXS1YrUzBTdUFnTUNpWXp2OXk5QnR1cG5K?=
 =?utf-8?B?eDN6akttU0hoWVhDaHRua29wQ05GcFkrRGNWazdjVXp0eWE1UGZEMFRWTGhC?=
 =?utf-8?B?OFVtL1BZRG1IVW9vcWd1MW1HbFV0U2VKayt3bFAyaU44RmhXR3ErK2R4OE43?=
 =?utf-8?B?QWxJMEFYaDgxaUJvUHk2UFJFeTFVdW82OG5ZdTVmcFJUdVY0V0pQODYvbHlP?=
 =?utf-8?B?YTBBcWpxOTRMUmc5bUNQakhtQ09oNlFQOWhHYVhGWW53eWhDMmxvSFZYVjBD?=
 =?utf-8?B?SERsTW5hOFdybzV5SEZXeVN0L0tCMmFQUGRTbU1sMEQ5T2NPMzQxMmw4SW5I?=
 =?utf-8?B?ZzVZU2hVdlNRRjErSk5aSXVPNVczc2R3OWNNMlJ3VVNHdU1qc2VCWWp3OWZq?=
 =?utf-8?B?bTlpa01QVFZNOGxBbVJsYk8yK2ptVjMyVnJWaEljVHNNemJyV0dHNzhxTUw3?=
 =?utf-8?B?SSt1UWh0US9EWlgzeHNTZGtlNlBLNFBIN2p5dGdWeW16TmlOWjBZUEw2Ui9W?=
 =?utf-8?B?VlZubVBRejNVdkJjRHFQSjhBVnd1QTZwblMvNUp2QjdsTXNDemJRNUl0RUdJ?=
 =?utf-8?B?TDVQWlE2TTFrb0xINzRPUUZPNkIyYlJ2Y1I1NGpVUkdtT3JUczRwbjVsdzdm?=
 =?utf-8?B?WHJOQkxLd3FobEFIazRyN0E3YUErbkJhd05sOVNXWG95UXc5YkFSb1BQUWIw?=
 =?utf-8?B?eXNwZlM5N2N5M2Q2ZUtTZnpmTTlad09xUjdteVNsTWoyb3NKcWVrYVJML0Ir?=
 =?utf-8?B?ODFscDJwQnd0bG9Lc2NRRlNTWDJVWmwvNXJ5TTFmUE9LSmt6Zzd0RDB1QVNK?=
 =?utf-8?B?Qjl1ckFScjhBTnk5OXMyYXJsR1Y0cWcxY1FKQzlKbGw4QmNURzRHcm5TTG9k?=
 =?utf-8?B?U2UweU1hckxldnRTNWZ4SDcwTkxoNVcxRC9LVERvTzZDRFhwZkdIQ0IxdlQ4?=
 =?utf-8?Q?TO4t65AH3lTyCnxI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4a8bf3-f04a-4bd9-045e-08de6a461222
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 14:50:32.3640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thRm4hMj2pmThfRZIy4jBY7NuxxTfuvP0gJBl2guKbAjvDegv9Rx9hPgdV539nIbflEBGQL1HCC601mXgUhXDc2gRxjGzujRPY7wBbTd/QU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
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

On 2/12/2026 1:53 PM, Anatoly Burakov wrote:
> The original IPsec "add SA from flow" function expected a void* pointer to
> security session as its first argument. However, the actual code was not
> passing that, instead it passed `rte_flow_action_security` which was a
> *container* for security session pointer.
> 
> Fix it by passing correct pointer type, as well as make typing more
> explicit to let compiler catch such bugs in the future.
> 
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

<snip>

> +		const struct ip_spec *spec)
>   {
> -	/**
> -	 * FIXME Updating the session priv data when the session is const.
> -	 * Typecasting done here is wrong and the implementation need to be corrected.
> -	 */
> -	struct ixgbe_crypto_session *ic_session = (void *)(uintptr_t)
> -			((const struct rte_security_session *)sess)->driver_priv_data;
> +	struct ixgbe_crypto_session *ic_session =
> +			RTE_CAST_PTR(struct ixgbe_crypto_session *, sess->driver_priv_data);

Despite being removed, the comment is still true. This is an artifact of 
how we get the crypto session (it comes from security rte_flow action, 
which is const).

I suppose this could be fixed by looking up the security session by 
pointer, but this would quickly get out of hand if we have a lot of 
security sessions, so there's not much choice other than to cast away 
the constness here. Ideas are welcome though!

-- 
Thanks,
Anatoly
