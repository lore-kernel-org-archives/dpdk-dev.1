Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D372CED27B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 10:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C8440281;
	Tue, 18 Nov 2025 11:40:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id C50CD40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 11:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763462404; x=1794998404;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=fZANkN/XitQpN8WR6KAf4/xaMXmmO6c6Y+AkSYC22Js=;
 b=BqoGbGkmqjwsGsdmHomXYtlo8f0HLE/YFLzY39TbO3CQoyaU+J7VWpE+
 hn/iBvG2o2ZptUAYlonT0cSmBVXvgYKLPuyjRN22jvDTlmLLFjtT3Wtn6
 UvnVFn9cq+Yl8AUgob+J0KsBVVjtjKHJe5C/uOrX/oVerflSi5WbIzMXn
 dudmnnb60loX17cvmf9Krovpaxn+6i9pLHg8c2HmRfPaJ/sDXbmHw73ji
 5F6Qv0iQg8o4T4Eqg+11R3kIw6m0yxpjwBUyPWxHcmzkhK3cdZhNtmelq
 lFE5K146s2V+oMl7CnVKCTkX1hZ0C80r3je90oafD2UmPvAi7Uj+nwJWQ g==;
X-CSE-ConnectionGUID: JW1vtn6vT32wSEYyB5UzyA==
X-CSE-MsgGUID: ovE79FHcRZugC3gN5rmTjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="64480805"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="64480805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 02:40:03 -0800
X-CSE-ConnectionGUID: 556IE1PwQK2RV2xZWEJPLA==
X-CSE-MsgGUID: QPimR/u1TGqHRjv3DzZcIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190518861"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 02:40:03 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:40:02 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 02:40:02 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:40:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYV+534hpBfAtruP2/n6Sx4cC+gztpfM3WzH5J8GNhwjCKADTvB9N8kb0aHRA+pZ1FO4q9EH5rREfjKLfxayh0HZGWxIS6I2kY471w1jtO078ZzdDBFwMKW177pTjUbAm5FObglHiR90gHsl9Aa/gu75IlNowydekFapAU4lIybN62ggTX7QwBoSvPqYmHJQ6zRm44PW9OTBJx+f/BmQNyUCi/+JO+nKcYzTkcYZ/z103MXJJS56WKJYmwNe5zECN5gAmFpIXcI7JGMgzw8u62alNCnZU5kmDnXvqQN7v84ho78Dz2wpcbq4xrdd39Ax/qOYFdUxSC7kkJ2GuMeWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1RyIYgnnBWo87OTRbi1xqugnoilbjKKaOxN2fz0cH0=;
 b=rRbKxb08RV90D99BUda0rymCycHiZrJg9k+/sVrJq2Z409Pq309ARzYxNksQZmDmrHe4S+7s6aoz7XZGSOjdmH6Nh1b9KDTJt8h2nZheTeluCa/k2vnZf0psyqIWM9AEV0RYP9Ofeiik6S6Qm+TxFCTys2/cLD+CebyITEy1H7N05WgXHtLu29Dsrfo1BTqrTHK6Q794FL+zGdvFDQpBt3l/EjTRjv+ecfCT3wZ8KG5mFvCu4Y3UzmVxGwRWlmL9e77JCEvm0XuOHYoUotbT3IDK+UZ1GcSyxEEuVvPnCdZLgG1Xa9In2FvOFUtUi2E6+Y5U4igGR2d4/F1VCixeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9202.namprd11.prod.outlook.com (2603:10b6:208:56e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:40:00 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 10:40:00 +0000
Message-ID: <c055d2ec-81c4-454e-adfa-f664ad533c9b@intel.com>
Date: Tue, 18 Nov 2025 11:39:53 +0100
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSCB2MiAwNy8xOV0gbmV0L25ibDogZG8g?=
 =?UTF-8?Q?not_use_VFIO_group_bind_API?=
To: Dimon <dimon.zhao@nebula-matrix.com>, dev <dev@dpdk.org>, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon <leon.yu@nebula-matrix.com>, Sam
 <sam.chen@nebula-matrix.com>, Alvin <alvin.wang@nebula-matrix.com>
References: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
 <c0f24f340813d2e95f28044a535023d18a02cf00.1763142008.git.anatoly.burakov@intel.com>
 <c6d8e973-e365-4254-965e-ceec2eff6fb6.dimon.zhao@nebula-matrix.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <c6d8e973-e365-4254-965e-ceec2eff6fb6.dimon.zhao@nebula-matrix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: b95ae803-168f-417f-d3fa-08de268ed2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWpiNGdLdFhLc202L1FoS2xldW45M0FjaHBpVUI3WVhsUUxXbEpnMjVsT0g5?=
 =?utf-8?B?em1NTVVJeXBsVTNYZGtLQzNkNzJUU25ncVp0SXNxM0tGN0wvTkZHdGZOZlg0?=
 =?utf-8?B?MElqWTN3ZitVbjZrcVRHbDQ5ajVkRUozRnI0Y0FuMnNYZjQxdmgra0laaENH?=
 =?utf-8?B?ZXJ3WTBJOUlwVUFRRVdEU0QvOXFWQlA4eVVuemMybk4zaG9HelNtUUZpckZi?=
 =?utf-8?B?cEdiaGtqTlE5TkNFQ3NPVjR4cHl5WmFvbDZMaXJ2WWJRVDNCNUJaNjJ2ZXhz?=
 =?utf-8?B?dHFYdFZ6Yms5UFlIb2tnREpHNy9CbG1pUUhDNlRiYXFNeThveWxlMWF1RUs2?=
 =?utf-8?B?aUlZUWw4USthdUp2dHFNdk5Vb3NSVDU4Z1U4bk1nYk5KSk5aNndaTGdGRGYy?=
 =?utf-8?B?SUtscEZFZ3VqWTNIREI4VEduQTZBWGVpWGxrcTIxUUFSd2FsbGJCUkxpaEIr?=
 =?utf-8?B?MzhEZUl4UTI4KzJBSk52bGwwOGtOTy84VjFDUjF3UmV6ZWlCcTZCc3o5Nmtp?=
 =?utf-8?B?dU5VYlNCUE0vMk9sSDcxQ2NueFhyTThRRitKck9aeFowL3g1dVIzNTZLR3J3?=
 =?utf-8?B?MENXalpEVU1FN0tSSkFDM2gxWkpZVHJ6UVJWbXhxU29VR1plaEdjUXlhV2g1?=
 =?utf-8?B?c3RGd1p4UjdaMUg4aTZrdk5uaUticXVSajRvNnYxeDl2a25XbjlFay9Ba2pi?=
 =?utf-8?B?citEamdiazhvWG5DUkUyc3hudHJXT09QM3F2S2pmOWpYNDBMT1hVTzlQTkxH?=
 =?utf-8?B?YkdEdllTUlZzazlHWDJUSE1yVDVqTFlkYWVTdHk3b1ZNc2JCQlJpcG5LS3Qr?=
 =?utf-8?B?QzRod01ETk1BZFBVRk5PSzYzd1c0ZjliK2Vpdy9GeVdWelFlMFR0MFcrM2w1?=
 =?utf-8?B?VkdRL3BzZmFmTlNWUjNPYTE0UUJpK095ajdIQUhza2lhNEF6dUxtWEw3NzYv?=
 =?utf-8?B?dS95OHZRNXRxcHo3UmU1cTdSVUtEOEZEN0ltZ0FUTExiY1R1ZHUrUk1tWmd5?=
 =?utf-8?B?dmxiNk43Qk51S3FrWmM5RGh2cjk1KzdXbjgvdjNGYXJkV0pOUGJma1JNQ0Yw?=
 =?utf-8?B?aENSZSt6Tld0c2dmR1FvNUNFajZhVGQrcWlzMVV4dHo5a056NWtqUFJxWEdF?=
 =?utf-8?B?ZDdYUWZIK1h2bE9ZUFl2Tzc3RDgxaXRNV01oRmR1VnZLcGE0cGFhS1lJR0xO?=
 =?utf-8?B?UGRycEF6SHNZWjM4ZU95djdYM3VZbG91ejlsU1BFNFhpc09ycDJJRjBpUnJq?=
 =?utf-8?B?Mk8xQ1VNVngxZzE5bWhPRjI4Wityd3lEOHlzZk9xWE5XdXZJOXAzUUMySUNY?=
 =?utf-8?B?RkVtU1pDRWtnb0dqN2ExMHJEaUlnL2xSMG5FMW1oc1hNK2xNSzM3VWJNcElO?=
 =?utf-8?B?aTdKemE0L1hSbDhZTGdHVjJCRmxzNHF2clRvL3RHN0FyVGxtcU1zdE9ucUZ3?=
 =?utf-8?B?YVphenhWb0ZrWVh5bE9SMlQzNjd1SWFIMFhIWVpxTy9RdE1UcFM1dDIxMlRN?=
 =?utf-8?B?eU1ORGkxQ0VxV2x1MWFZZ0tyWlNLdHB3Q25MeDBJbU5BZXFFUzRoTU9XQmxv?=
 =?utf-8?B?N1BxY1lCeldtUCtvUkMvUGxlTUxrc1lQUXQzb0dUbWVjNDJDZG5KTGtET3NX?=
 =?utf-8?B?anJRdEhkcFNRMTArdmpZLzExVExraWRCWkwxQ09oWGRoSzV5MHExZEN2OS83?=
 =?utf-8?B?VHllSC81eWErN05oQU1SdHVPR0pKdDFhMFc4N2szWGovNFRHa0p1M3FqMlRj?=
 =?utf-8?B?RjF0OTdWL1UxZERUNGhIZUdNN3dKcGN3bVVMenlZUnhicXJBMk0vWWF4VHlZ?=
 =?utf-8?B?U29wa3Avb3VRT2RJUlNqYmpjd2NSdW1LZktKK0IydEJSSkZSbXhRQzZBelB3?=
 =?utf-8?B?c3l3d2l3c25FaUNBdzNUZVFpTFdGeXkyVEpGdEhMelNSU3lGM3JGUXVrbDcw?=
 =?utf-8?Q?8HCJO5fPocsyDbwReQHcvmGNAMQmUqhO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdnaVpCcDJIeVhhZkZvMFlDT25rQ1JXZWFZcVNYQmdVK0xML2hGeVgrZXJT?=
 =?utf-8?B?bW9wZW10SSs4VFpxNEkrUm9oK0tNWU9ic04yOXA0a1dDL0lJVVgyRzJzTVhK?=
 =?utf-8?B?UTRxcEZlQjdMcUJaQ09ZWlZ5WmFZMXp5RXRHdFZoQjhVQ3Nuc1ZNeFh4QTdu?=
 =?utf-8?B?Wlgrdjl3QjRwYkxsQVgxNk8zdmJ1dmt4Ymh1SVlac3RJSWNpVzkzSFZnT2sr?=
 =?utf-8?B?OFpJTUdDWk5ONVJpWTJWbG1OaWFMeTF0T2xLSGM3c3pYQ21ubTlMOWlvdW1u?=
 =?utf-8?B?ODZhUG1IZDRySGQ2RVd4WXlSKzFFM05YRGxCOVlsMi9ZLzBBN2NUU1NKY0xQ?=
 =?utf-8?B?aTNaWnozQ1BncUxETzdFRVd2SzRBYUJXaHh1NTNMNGU3cjFKK0hMMU5heXRo?=
 =?utf-8?B?aGVqVGt0b0U0bmZRenROblRVMXYrQkZKcGRnajZONDZDNW9hZkNDc3JMOC9l?=
 =?utf-8?B?YitUTzRtVm1pRjV2TDhLeWZFenpxeDA2SjQ2bTNYWVVPV0lTZDRPRGVkUWRV?=
 =?utf-8?B?Vlc3TStnOURYeUJFdWNvdFk1NlQrcEsvNWU5MTYwRXdSbWV5L1BQWndtVVdO?=
 =?utf-8?B?LzNKODUrUWF2NkdBam9WNjU4MDMydVZqNlNSdG9XaWMzUW8wRzVaTzhYcTBV?=
 =?utf-8?B?OXpzKzRpVGZJQ0hPU2RUTy9zRFMzWWZCaCs4cHkramY5cHZ4VCtVcy8vNEpI?=
 =?utf-8?B?ZDhZRnBROXFGWG45aGxKa29makFXblZ5UFN1S016YWUvNjRJczRWaVBhaENQ?=
 =?utf-8?B?K2p6cEVtcmFMZExxaDhrUTBDY1lWZ0tVSHI0WHdzM1NWRGJNMDNqMFdBalVK?=
 =?utf-8?B?d202OWVNb2p1cWVTQ0JsWUpWUytCNmk0bWYvMDE4a2s4Tk51bEt2ZkFlS3RV?=
 =?utf-8?B?MDI0YkswcFk2dndyZ1lLR25mZ0ZKL2ZMQ2htRGlnS2dMOVFVRDZQYXZFR09N?=
 =?utf-8?B?MWQ4dklEWi9yL0Jramcrei84SThDd1hYQytlMk40ekJDckNMRFB1MHg2bEFG?=
 =?utf-8?B?WmFKREZEZSt6YUNhcElkREVveVU0RUdRK2xac3Y4d01PbVFpZmJYVTlrMzdF?=
 =?utf-8?B?bnlGQVdrT04xVjhFMS9mWjZUeGFsQ01IaHNxR2NpSmgxRjBlYWF2aUQ0RFdU?=
 =?utf-8?B?Y3ZkRlMyYXR5U3pQS3ZwN08vK0JpRWl0aktxUDFET2pRajRpUmNLL29KUCta?=
 =?utf-8?B?amJibWRqTytub2huZE5DYmhTQUVHTllabzlRN29FN1o3ZnpQWWRreDBiaXlH?=
 =?utf-8?B?NUsxZTdyODE3NTN3WWVHN0ZNRkhORURHSFVRbXdjQkNjbUtzMTllSnk5Q1Ux?=
 =?utf-8?B?UjRjVkh0RTRWKzZXeHJCNTNLb0JZayt4UVdrMWFqOXhyR1E5YXFpSWNqTE1R?=
 =?utf-8?B?dEsvNlE5Yk51d1BRN28wMm96dmxBdm11Q0IrWFF4cUdLZHhTNjNaN0JmdE9w?=
 =?utf-8?B?UGtsUFpWT2FQcEhQajlwL0xqdVpiZWF6V09EbXNiZjZodnZKdnQxTHhKRGlo?=
 =?utf-8?B?YTEzVy9CZTJYSllkcXhCbk9tQ0U1azM3WWxhSU5Ka2xCMkM3ZVdkQ0FiYXJw?=
 =?utf-8?B?WGlIcmdnSDdocFhiQUhvRmtObTZteklOZE91cVUzYWMvRk9MbitndFMrd2hC?=
 =?utf-8?B?MWJkMiszaWpwekRnbVhFTEtla0RJZXdhMTVGVzdVNEx5bUIyejgrYWxwbSs0?=
 =?utf-8?B?WGg1a1pWZ1I3T3VSdjZxNTVKMHJvYTlyalRUNkRLMmpvL3Bxb1NpcHA3YjFP?=
 =?utf-8?B?MWxpbGpjSzc0eVFxR3dlSi9CTGdNd0pDQlpzdUZ5emJaSUFkNUR3ZVFQbnhV?=
 =?utf-8?B?eXpBVjN1SHIxZkhLR1BFL2QwWVBlRXV4b0ZMMTdhVUhZcG5jcjNYMnBhU2Ez?=
 =?utf-8?B?MnVKcWE0aS9OenR5ZWx5dy9UbXF5NWF2Y1VyY0ZOWVQzaU5ndXNWc0Y4amti?=
 =?utf-8?B?akJKcXY4cFVFblcrck1OQ21pS1VWOUF6OFR3QXNuRjFBakdqelg3dnh5d0Vr?=
 =?utf-8?B?Ulh6OWtHb1UvWGV5dVVJcTNqZmRHSGlIekxqbTF3M1ZoaFFhVkNsSjRjVEd2?=
 =?utf-8?B?S1pUL0hTcmJ1R1hCZEtTMUtkYlRyOXFyaENVb1NxVGhjWi9mcUQwOGR0M2ZZ?=
 =?utf-8?B?RTZOeE95Z2ZGMHBPcloxakpVVkM0QzI2RVNaWTVNUXBuWVNaOHBVSTFkUGx6?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b95ae803-168f-417f-d3fa-08de268ed2a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:40:00.1970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBjWrelVt0Q/8CYWcnOP0Vkax3sM+sGq6s6SmccWMWE2ITonirpwH8DWH91nFI3ewHLhxRUUP446kqEzcNFfDLTdoWXUGfQ4tLf1LDgSXRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9202
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

On 11/15/2025 9:31 AM, Dimon wrote:
> Hi Anatoly,
> 
> I feel there might be a point that needs attention.
> 
> The old rte_vfio_get_group_num function returns <= 0 to indicate failure,
> while the new rte_vfio_get_group_num function returns < 0 to indicate 
> failure.
> Therefore, all DPDK code that checks the return value of the 
> rte_vfio_get_group_num function should be modified.
> 
> For example, in the nbl net driver, there is the following code:
> ret = rte_vfio_get_group_num(pathname, dev_name, &common->iommu_group_num);
> if (ret <= 0) {
>      NBL_LOG(ERR, "nbl vfio group number failed");
>      return -1;
> }
> 
> It should be modified to:
> ret = rte_vfio_get_group_num(pathname, dev_name, &common->iommu_group_num);
> if (ret < 0) {
>      NBL_LOG(ERR, "nbl vfio group number failed");
>      return -1;
> }
> 

Hi,

Thanks for the review. You're right, I should be more careful with 
return values from this API, will be fixed in v3.

-- 
Thanks,
Anatoly
