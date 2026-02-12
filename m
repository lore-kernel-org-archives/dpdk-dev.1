Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBCFEE3685
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 13:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C58D4027A;
	Thu, 12 Feb 2026 14:57:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4693F40268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 14:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770904670; x=1802440670;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e05ABlPKr29dWE3iS3+AWvHMbEUyGf5esKiGFQ8Hxi0=;
 b=VND/4/uqCo5X+QeHnGrZ0fRe0tkxkLc1cO2LxroVFhYrbaCpObiUEOQ2
 yhU3kZgOPMJUu0QeftLtp8gTwvhjQYukO4SpucbYj/Fn17ZxTHDfy6b9T
 GmOdySweFY1rHUMGNTfpxYv/PwrgZvMuUBvX+/gOnjp+GuF5UZwgXQ4kZ
 CD1TuSELR5xYVb7uqyaH6QaIbmBF3cCwg9tHWy66AG0CE9Ok2uLTfdvU/
 sygVrs4QLQnRpHIuxQXkpJZ+Pi686akverhH2SI7wOTqfhfhpdFzCRuwj
 cCUfP1OvMY+jgVC2daGCuJv5S/ENhG95pEl/RawO+89/SkcKYCUlWA/B2 w==;
X-CSE-ConnectionGUID: QumeVcwNQniooXkkNSBnVg==
X-CSE-MsgGUID: f1Ohh2iSQCabQ1fRZtGz7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71276385"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71276385"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 05:57:49 -0800
X-CSE-ConnectionGUID: Eqp5NXOcQhuDr2JbPP1TbA==
X-CSE-MsgGUID: Y1WCK+PjQKSRImwVqbXJdA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 05:57:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 05:57:48 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 05:57:48 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 05:57:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPu1rpRnkXI1JcBElDcEuE7JCEgF7Gkgtv7B1P6jgfXIVHcbeQUZyHNFRN8KYlUt9IqlkWH7f8uGEtscE9jGD3uTtlh0ekq7ZmWcoE9HENhxqKlBtdD53w8bISM3DLjQrHLXF0tm7AHkq3lOxA6U5k0oVwTcLHS3owh12gOKDg8O+96+gE/F4s3n72QwUVGHs2gofdgcJe5hPHRYk8d0JJG6tUrfSyWhZ12zMT7Kquhe7b7TofwzWB/pqkAxU9Pxfd7dmtfeCcbus1+jLm++m2+qMRaj15adNC/YJHdEE0KaTVFwP7UoPAF6Js2lGCTm7FdUuhWwu/qzDNoRT9nCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+ljfP1+FJFrP2GSStfXaW2uxwral11BhtKPqyUOprU=;
 b=h6K+NHFnhvpWHoYp/GuHHHzk4Qml8KgblPX+PKs8BbqBGe9VP1j4I7yJbNmHAQz7IjhMB/MUfHsFqelFBL5SP+0EzkktMOkG3/K/eMr9Nq/nFlYpl2Lca2Awvdc/WMoyEKVKI+7DMBe1TLqKxm5qqXEP0rxrQK5AdRqcEy6hYYLhuWdElAoOAPiJ4Dh7hJLdtlZxsuUxvPxAoe59WV+z4p8g6aRbxQAqeMJp3VEdYC2fNgA/nUR5FJAjWu0+SFue9Awe9rw38ULNpbLGQsg3fm4mU5diVNvFYMaTSqqkcKorF7bKo6Esj1/CwfsHfJ3DVQzR/sfSaGnosJp2mGAVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW3PR11MB4668.namprd11.prod.outlook.com (2603:10b6:303:54::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.13; Thu, 12 Feb 2026 13:57:46 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 13:57:46 +0000
Message-ID: <39632c4b-10c3-4bdc-b4ea-9010391b4ada@intel.com>
Date: Thu, 12 Feb 2026 14:57:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] eal: support dmabuf
To: Cliff Burdick <cburdick@nvidia.com>, <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
 <20260204155206.2345189-2-cburdick@nvidia.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260204155206.2345189-2-cburdick@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW3PR11MB4668:EE_
X-MS-Office365-Filtering-Correlation-Id: 60db350f-afd4-473d-303f-08de6a3eb37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk1LWEFyQXBpbzVTYmIrQWJqK0w2aXllc3Nod1l0RXdGdVduWHFVL09NanpS?=
 =?utf-8?B?MURmZ0NlN0l0Zzh6Q083NzhLNVVMaVpRSjVUVlQ3OTZMd1VodnlHSUpSSStS?=
 =?utf-8?B?S2IySVdpczFxNWhZMkxvY2w0RVZFRTNnbFUwZ0VlamsvSmNMeENRZ3JNMWwx?=
 =?utf-8?B?dVZ3eU9mdHJ2bFM5VWpOdXhQZGNLVnJab0JIWG41dEtHTzFLMU9OQUxLYXBw?=
 =?utf-8?B?aVk1dFZWeDRJbE5jU2h5dDF6cXhUVFBmOWlYTDBaNkRicjJtcXpsaTBsZlRz?=
 =?utf-8?B?YXYrNnBDOVgxUzhYcEtOdmNFR04veU5YMHh2T243eEc2c2E3eVZkMTJIbFZ5?=
 =?utf-8?B?ZW42Z3ZNdW0rcnkyREJSMGYwVmlQR2JINWI1cWh5TFdGOHpYS05KWDBMcXNW?=
 =?utf-8?B?anJBMnZJZ2oycW9GUng0RkRZMmttaXYwSWNLc1N3dkUwWnkvc2ZwbnZ5a3RW?=
 =?utf-8?B?c05HeU9uMEpwQ3JGU3lscldOVUs2NjJLa1hxOW1KTUNxS3c3Z1dVRlo4QkVG?=
 =?utf-8?B?QmpHU1dNbEdtVnl6MnZpWEtOVWFZVzd0cCtGZGJ4TW8xZTNSSysrdkNLYlVX?=
 =?utf-8?B?eHo1TG9KZ1hUM3RpTklvNlFlRmhCc1J3czVPSEs0cHZxNjlKbjNXR0ZMRTk3?=
 =?utf-8?B?bFlMYUlLRTZMWE9xYXprTTUxS0xZeTMzdEdkdkt6aWs0Y2J6aHh2YWprdFox?=
 =?utf-8?B?N293QzZ3aTFIZ2taOWFDRG9RcUtUQzU1RGNwNERkZFVqYlc4SWR3QWNKbExY?=
 =?utf-8?B?azhzRGNIVWgvR055bFE5VzQ1SWp4SlRtQjNOK21RMUhsQktYNnFyOHIyRjZj?=
 =?utf-8?B?eWtFVW9OSXdGeHVPYUp6SFVxcWRKdDh0ejdoZ2N4THpSRUZzeklyU2xhMzBG?=
 =?utf-8?B?N2Q0VkNkbkRJWHdnbm5TOTFnSHp6eVhRVDU0U0RPRmdmMXl4bUl2Y0UvNE1Q?=
 =?utf-8?B?OWdhZWtQSjg3NnoxM3RCOHBueVQxYkoyZGJveGRONnJyNGlLSDZvdEQ3Q3FE?=
 =?utf-8?B?R0dIemZSalBvOENZR1VycTY0eUxQVElSQVR6OFo1K291TFcvbTVPUjJ2STNz?=
 =?utf-8?B?VEZ1Q0VPODV0dnhpY0pwZ0dENmVrUTRJWXI4MnNPMUZLWjk0c3hoYnRIWGVq?=
 =?utf-8?B?L3d3eWdqZ05HaUNTL04rWHFwM3JwMDF3OE5PWGtsVStqdjdYVHk3d3VBeFZ3?=
 =?utf-8?B?bEx2dGN4cTJ1YlMvUHpOdjJjUHg1bm5kNEFtR0JvVEkvaUIxakJMVEQ0bW5X?=
 =?utf-8?B?R08yNjMreHFXbkROQm5WTCtSR3FuUi95MnE2b2RZZjBxeWRFQW5YWDVpYlZh?=
 =?utf-8?B?azZ3dk0rSmwzaTJEc3d6Q3piMm10dWtVMENJdGFtL3RjNDNaa0U5b2RBVjR0?=
 =?utf-8?B?OVpPZmZuNTduUDcwdWcwa3A5QnRWVGErRy9kUmJZRDM1RXNmekhRcDVOK3p5?=
 =?utf-8?B?NVVnWWNHL0l3TjRXTktVdUZnOFl6ckcya0FCbllkcFArSHRyL1phU0diZ0FZ?=
 =?utf-8?B?bGtlS3BpYmNjczlOUHd2bDF1b01iOHFFL2hwOWJkbjc2NGRaZnNEUEVVeGcx?=
 =?utf-8?B?VlBaeHlZVmdQd1BHOW1RTDVlandacGtzRWZ3WWY3VUxySVhMTytrNHNaR0hx?=
 =?utf-8?B?ellVTjVxS2RlaStrZnZsNUZ1RnVrRUlzQ2RNMjV4azRnUHVpM3pxdUg3KzVl?=
 =?utf-8?B?WlRCZTdKcHlUZkNLMm9vVk9PNEk5T3JHeDE4T2JVVWVsZ0tmaHphMS92YTJO?=
 =?utf-8?B?MlBFUG5IS25tOXBMSXpZZy9yK2piNnJlQnFaUWs0b2JrVS9qbklqVHdPZ2VG?=
 =?utf-8?B?UWZMV05ZVkxJVGR0WkJvbVpOeVozWnZVVW9lSFNEWnRwcmVnT1l1aTFkRExQ?=
 =?utf-8?B?b1Z1c2VjZ2x3d3FqMW9HQlpmMmQycHdYOUxmM2pqUVJFVXUrSkh2dlBGOXI3?=
 =?utf-8?B?Mk8wV3B4M21xbEVHTUhOS3pJTWFySEt3SE51OHdTZjh3VnllVDNWc0lRQ05n?=
 =?utf-8?B?ZCtFTWFnS2p5c2J6TmFFeDZ0V1hQc05jTWV0YlM3R0ZvMlhVdjR2M2EvZmY5?=
 =?utf-8?B?amgxWUpWajhzVm9JQ253aGRFVjFvOTVLQXFZayt2eExFYVF3L0hIODl1alcr?=
 =?utf-8?Q?SHh4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0sxL3RsK3pwQmVGbjVtZVhxRGIzTUh5Zjg0WXRIbHBXL1dOb05aZXlVamk2?=
 =?utf-8?B?Tk1LcTRYVWNwLzBEc3ptdk0yeG1PSTl3RlFnNURpa0xUT1llZDhsOVQ5YWhW?=
 =?utf-8?B?U3JybXhUOXJoOTAySFZYODlXR1l6aVA5YWhqWENKYVdoYzBQTlhjQ0VNT1pZ?=
 =?utf-8?B?VWU3bHAwRmZ2MU00UEE1RVl1bEVWcXRiQkRKV1czS2F5NGpveXphOVVHTldl?=
 =?utf-8?B?SWdMV1loWGw5dDRBazUwK2FBTHlYMzN4NWFJK3plbERhSjVvdmxhbVZGRENr?=
 =?utf-8?B?SzZQMWtFeFhmQ25USVppamthRndDOW00NkR1NSt2SkdNajRQVnJSRjRoT0FW?=
 =?utf-8?B?Q2pzN1hDY0xrdFVEZXNKZ3pERDEvanNwWFpoZ3VuSWIrNGxvWFNmb0NiMlhT?=
 =?utf-8?B?aEk2ZlJtbVZMUmp2UzVKWHZDcXBDWVZocUlTTFNOblVoRDVWays0WEJCUmdG?=
 =?utf-8?B?aUZxUEhtajJiWjJQTWNRc0cvSHdSQXl3ais2R2kxaEtSeWlkeEVIZE1GZDUw?=
 =?utf-8?B?SVA0VUV1UHlwYzJ3Rm0xZFY4Ly9MNjZ1cXpNc2dBbDZjTi9WUml5aXpPV1ZK?=
 =?utf-8?B?d1N1VDdqazN0NitMbjQ1MVNxMlFhSm5iL1lqeTZUektHb1FHREtGU2Z2UGdJ?=
 =?utf-8?B?dlFRUStOa25OblNNOFFKNmpzQUw4MDdGblp1YitYdjduV2ZFeU9yQXdkZnhn?=
 =?utf-8?B?dXdLTmtlNlA0Y1E1UElEaTZYUlV5L29MbUNCVzRWYVM1RkdKcTZEKzEzaW9y?=
 =?utf-8?B?VHVkNnpIelNyYzlMSElrTUVydmRkSTBTcjJvZ25WaDg1MTRwWnlPTWVHYWlq?=
 =?utf-8?B?L1I5c1JYY3hpakFWUk8zZG9WeE1lbXphWW5CT3ZoOXZUSlUvOEZ6akQ3cEFG?=
 =?utf-8?B?dEl2ZVhWdGVYRUFrQ1lrOHZWcGNqOFF6NzZoY3E1RXp6aEhmTTJGQkN0YWsr?=
 =?utf-8?B?NWJMSkx3NVdLaFNmWmVQcjA3ZTJHQTVPejdScTk2N2RRWlorMjgxYlVUK3p6?=
 =?utf-8?B?N09tQzBjYTQrZzl4ZDBUOVEvcWUvaE12dFVBaXpVRkpmcXJpbk9xKzZzOWlO?=
 =?utf-8?B?N01TbUE0YjN0V2NIZ2pUUlJ6RVJLTnkzcWcwczdKRjdrSE0wZkd1RXlDMFZj?=
 =?utf-8?B?LzFidmYzU0kwTWk0NllXemVUMGlCc0FnN2FIOTFmeGpFQzhSM2tTMi8xWEdC?=
 =?utf-8?B?S3ZINzVEdGU0aXY1RDJMNUx6cXZseHN0UXhUbWhZOUpmelNnamJtbVdsMkx4?=
 =?utf-8?B?ckdPWnFpb09DYTdLZjdGeUZUUW9aVnIxbnFEOXdyNW9WOWpoMHAvY1RoRlRk?=
 =?utf-8?B?cFZCNFVwWlpjUWlxSytKUXlBM1BUdjRTSU1INElnQkFRM1orbzJPcHdmVDBj?=
 =?utf-8?B?YzJFdTlQblJRdTVabkpNSDNwSEVtRG1DbU81UUhWdHR1VmpYc05vcHBJTzFG?=
 =?utf-8?B?NHVMcTYzL25QTEpROWJEZUk2LzcwdEVQNGwwbWtSUXVJYjBWUEorcUhGKzkv?=
 =?utf-8?B?eGtYQ3dxZlhhcHlPb1lwbk4xUmlnR2l1QkxjZFpLYXF6UHpPRHM4VUMwd2k4?=
 =?utf-8?B?NGM0TmpJTkVqd0daejRFVyt2QlQwK0FzSWxrMWxBb0dsaGJHdnZUU29rNzRi?=
 =?utf-8?B?NHJZc05rVTUxOTJPc210RXhVeS9QSHQ4Yms5SmM0MjZLUnA5Q0FyaWJQZzkv?=
 =?utf-8?B?K2M4ZlpoY294THltd3ZhYk5oaUdsaFFsbW9TVnZramlQdUJ0UzB3cjMrZm1m?=
 =?utf-8?B?TWhsSXB2WXlITEFzZ2Rxdkt6L3EvY0dTN0NsV3MxUUZyYTRCMjNuOTBvT29i?=
 =?utf-8?B?bWZiOFBoTVUwTlp3MENKYWl1Rzdwd2dnZVorS0l3T0FuSVd4RjdhR3pabUJP?=
 =?utf-8?B?aXMrY3M3N2NHcWo2TWRrNXB6Q1YvL1ZjVk5QZ2FaMncyMTBMWjZNNUhSbVc2?=
 =?utf-8?B?UUtwanAyY1RBd1NLTERLcnZxckwxcFRncThkR0VzbDJYNnJXWjA2U3M3a0xZ?=
 =?utf-8?B?dUpJeEp2Lzg2WE1PcDFDQ1p2RUdVcjU5eGlyeE00aDVieEorZElQU0loMS82?=
 =?utf-8?B?ajdOQUNibGlXRzZqaE1hZ0NCMWlsTUdCeEt1YWpVQ3o5cG02bTNiaWFkNE9C?=
 =?utf-8?B?NjFBWEk0T20rVUZDSGdhL3JqcXBhVEN4R2ErNkhwS0sxUFo5UXhlN243R0ND?=
 =?utf-8?B?RksxU0F2OStPM0ZJSExjYUQ5Zk1ZcVNnRVBwQWI3dGI4RlNId0tEQkMwUkNE?=
 =?utf-8?B?dWRMbGgwcURKUVZOcTBCMkovR2VzNkpOOENCMzdqSFA4MTlEcGI3VU5oQVRR?=
 =?utf-8?B?cEJUT3RaajFrTGR0QTJnd1pzTlJaNnJyUGQ4OURsVDAwd0tVWnR3ZlRRWGNL?=
 =?utf-8?Q?VWZJZUYzOKd/pYis=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60db350f-afd4-473d-303f-08de6a3eb37e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:57:46.6535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qwa1IPqUIBNyJhU5v7fqJ43LBKv0UyNQX2H9mzqwpnYsB1awTngR43ft0wxGI0tiHp2sXwEyLqNj8wJnYD07/OUYG2IdwIp8GvvqulTm6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4668
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

On 2/4/2026 4:50 PM, Cliff Burdick wrote:
> dmabuf is a modern Linux kernel feature to allow DMA transfers between
> two drivers. Common examples of usage are streaming video devices and
> NIC to GPU transfers. Prior to dmabuf users had to load proprietary
> drivers to expose the DMA mappings. With dmabuf the proprietary drivers
> are no longer required.
> 
> A new api function rte_extmem_register_dmabuf is introduced to create
> the mapping from a dmabuf file descriptor. dmabuf uses a file descriptor
> and an offset that has been pre-opened with the kernel. The kernel uses
> the file descriptor to map to a VA pointer. To avoid ABI changes, a
> static struct is used inside of eal_common_memory.c, and lookups are
> done on this struct rather than from the rte_memseg_list.
> 
> Ideally we would like to add both the dmabuf file descriptor and offset
> to rte_memseg_list, but it's not clear if we can reuse existing fields
> when using the dmabuf API.
> 
> We could rename the external flag to a more generic "properties" flag
> where "external" is the lowest bit, then we can use the second bit to
> indicate the presence of dmabuf. In the presence of the flag for
> dmabuf we could reuse the base_va address field for the dmabuf offset,
> and the socket_id for the file descriptor.
> 
> Signed-off-by: Cliff Burdick <cburdick@nvidia.com>
> ---

Hi,

A few random thoughts about the patchset.

For one, this API is obviously Linux-only. This in itself is not a 
problem (we do have VFIO API...) but I would really like to avoid that 
if possible.

For another, I don't see any support for secondary processes - the 
dmabuf array is process-local, and calling register() from secondary 
process would presumably either fail or create a duplicate segment, 
depending on exactly what you pass into the register call. If this 
scenario isn't supported, it should at least be explicitly disallowed 
and documented to be such.

My biggest concern is that this is creating another type of external 
memory segment and thus segregating the API, but isn't doing it in a way 
that is generic. I can see a valid usecase for this, but what we're 
essentially doing here is storing some metadata together with the 
segment. So, perhaps, this is what we should do? That would seem like a 
cleanest solution for me, and it would extend usefulness of the API to 
other use cases where there may be a requirement to store some 
metadata/fd/whatever with the segment.

You could then build another API on top of this (a library?) that would 
handle things like secondary process synchronization with IPC, so that 
you have all fd's valid in all processes.

Thoughts?
-- 
Thanks,
Anatoly
