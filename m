Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1109C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 09:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADCA24028E;
	Thu,  5 Jun 2025 11:22:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 025ED4026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 11:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749115368; x=1780651368;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iVg7Ao5VLZhlC1yFqMZXOE0SRs4/PNlybmgSLTPZEsc=;
 b=lyqKsK3SCurTpq9bE7drTbUEucZbPtSD2nLHUkeU0swYWies4wawV/JY
 QD/Ghn77i8GfM2EMFmgM3eR14t+lJHDiIfQ73In92nVE2nwcvIU4Kt8zJ
 oaCGQCvi8BlNYf2B2Hf3GtitzUAdSs7wPg+MtCu3OHojOADDBYI1vc5CW
 94244AehVyJQ1hJtFjczES/FHykkEe4KWOX8bnqjlVUwAcwOJOayaYwiH
 Aw83hurWXzg1lS7cT/4U+5ol5xVQvt8xHYiQmZPwW5umFw4JQzQLZ1me8
 ak1t6fVfOUNWkeH8h2LFOGvREJoVVz/KwqiUJEt5aEAlXEmGF3TKnnOmu A==;
X-CSE-ConnectionGUID: CHbEavNsQl+JeBiVQOb/aQ==
X-CSE-MsgGUID: sNP+Wt3pTru0cXpjX+fKTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51097200"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="51097200"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:22:47 -0700
X-CSE-ConnectionGUID: yd913iYYQ4my8A8eSBZW/A==
X-CSE-MsgGUID: o5onB4ZHS0iZ2RXiQW7/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="146402028"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 02:22:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 02:22:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 02:22:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 02:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SG3yu01qtC1sVDfXhP40TGgbydWZlH7aoNMQTDcF1Zn7XycQtq7r4kbRyVJT2fCPxM8VG4WQ+aPXZ/r8UWpvZ7s5tCP/kmDCQ+Gav9taEOCoObE6lX/iVQSa48I+KMW16e9zJ+HXyMlSToTysyB/Jv6v+rmuWkfcB3hPjdzvhL3UmumKRsD4/zsoDo8/fRTu0pCXrXF4AbdS+WnUy2lB2sj06PFm7O155NCygcKTeRoZvCx0CvvlAumkm3TFuvHOKGXRO/kTJ5RbGGUMsmafguQVszGXNyVlgQyKhz00MgYUgdRvd8oYYOVrsoB7Hy0LtZt9MFxuJ4BBcZRXgQr8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYu6ToBRrm69IGknK5YVgcJ2E/86jQCoMQcTiIncONw=;
 b=vUe0yvI9lvLNonCUQ1k0F43J1Z0OQAxwFdaVHLfRa6bMxJt46bh87mZGH+EqC+tpu0TcBBUOjsjISL728tUke5GG/wdgvjLJhPU+h+R/cOsu2vJPuUIKWbV5n13sjBzfZFYmXxEac4L2jwWe5W/FPJ1vmwj8EJoienLNi8WJFHxva4aj6qyzuTxDcTTbLx9of2Ygva0iO4UGTNuv+66IfzwHLqkqjr5m1K4Ptp8BOh0UlqZWNpfurgxpGMYTX3LHwkh73tAXHQ0yJC0coA3fTC8poOYlnu6GKFZTdd3yA5p9AE1oCfe/2Kg1HwjyPBwknLJZXTUm21Z19adPeOuZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by PH3PPF6CF64E2E6.namprd11.prod.outlook.com (2603:10b6:518:1::d2b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 5 Jun
 2025 09:22:44 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::999a:425d:a211:5d30%5]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 09:22:44 +0000
Message-ID: <6786f643-9ab7-4ee4-9678-36c2117c2917@intel.com>
Date: Thu, 5 Jun 2025 11:22:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/25] net/ixgbe: use common Rx rearm code
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <94bf598f2c12704cc60e4201bc670c70c2795227.1748612804.git.anatoly.burakov@intel.com>
 <aEAUf_Zqbz8FopFQ@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aEAUf_Zqbz8FopFQ@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::20) To BL3PR11MB6481.namprd11.prod.outlook.com
 (2603:10b6:208:3bc::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|PH3PPF6CF64E2E6:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b864f2-4e73-49b1-b60d-08dda4128615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUVUeDRXNG1FbTdTYm9tVi9WZ09IMGt3NnpaZGlhVGZUaWJQL0ppZFNXd2Iv?=
 =?utf-8?B?dE01Q0UwTW5DM29jN2ZlYThDeW1adXZZME5nZXlHR3cwY2o0elVpeTFWVHFO?=
 =?utf-8?B?K1BPT2VnbW9hRjFwUWNTYlZyNlBjR1lwKzYzRFpKa3U0Q0VWbENtSmJ2TDhW?=
 =?utf-8?B?K0RGOWJTcEJzbGUrLzlQN1B0NWQxazRPbVM0d1U4QUFKZXJETjlnMTlpU0tv?=
 =?utf-8?B?aWtnb01TR1A0UU9KUUFTR1lNVWFzbmtnc29TUXNKbjVvYWpkQVFvT2dhM2ll?=
 =?utf-8?B?NXc5VnYzT2l4Nys1QS9ZVlRObDlzV21ic0ptRi9HeGJYTjVWd0loWmRIMllp?=
 =?utf-8?B?YkdrYk5MZkl5ZFJKZDdVWVdrTWQxWDB4VDdXcldoMFdYOG9rcUhRajhNODhi?=
 =?utf-8?B?bzZMeGE2N0g0dk5uQ2RZRHlwV3ZKNU5aK1diSndOVkx2ZTU0SGtDZkJ5Tm9s?=
 =?utf-8?B?aDBoNDhTbWEwWUkxUmRtaXlNbFN4clc2QURwZ0ZjNmQvbEoyLzlsL3NNYnlK?=
 =?utf-8?B?SXhSRmtGMm1wSllrRDJ1US9oS0RrR2ljRFBGNGdDK0VDc3RtcUI5cEtqOG1p?=
 =?utf-8?B?eEVOUVgvd1EyQy9KR1pPc2E2YUg2Uy8rZ0E0QUNsakpkNkNkbjlkWkZvK1g5?=
 =?utf-8?B?eUVxa1cyMjJPcytxM2ZZYTl3Q1QyS2ZidmtOVjdOM0hUaDZvMmxSL05xazN2?=
 =?utf-8?B?SStNMms3U1R6Q09CSFp1b01vU0tkUXhDQWpoY1dNaDJ1YXhqQUVkMVVZa0tq?=
 =?utf-8?B?WmEwOHlLY01jU2ZSWXFISkFzRjIwYURJcGttSWUvZDJNVFJyY3JKOHRwSmlu?=
 =?utf-8?B?dVZCeG85MTlqNmswOFgrekNxS0x1cVdyS0RMY2ZRa29rRy9RU1BPSTVuUndy?=
 =?utf-8?B?NkR2MENXWjZRb0daakQyTDNNcVltNm5PdFo0YjErNU15VlZDQzRhdDJLOFpt?=
 =?utf-8?B?dVBrWTVNSmJzdUcwNEh3aElZYnl3d0F4SGEzd1V1SHpyQ21VdDgzWlN1YWo3?=
 =?utf-8?B?Yjd4aVV4OEJBSkE4dWo0TTBBVUUrbzlibWVFRXNnczJrdHlmK3UwaXZxSExI?=
 =?utf-8?B?YlExRFNjRHBQQi9hd29EZ1pUQmFzVFZYa0FpejNuN0wvdlFVUDAybmdSSUZv?=
 =?utf-8?B?Y3VIYlBZNnY4UG4zNjBFZjJqQVJOaUxKM0F4QXJLblpjQlRMellNYTBpZldw?=
 =?utf-8?B?bWV1M0FQOXVWZkR2SjZhM0E0NGxmeFpnVDhaNEFsWlJQMEtJRHNQTktwNy9D?=
 =?utf-8?B?MURZVE9sNTlsMUdQdElSZ2lBd1hsMzhKMG9MTSsxbTJrM0lOcGxUNzZGQzA4?=
 =?utf-8?B?ZkJuWDJ0LythOGxjcmdzL09hR2t2aW93NlFlUDdzQ3llb0R5aHA0aFU5S3Vk?=
 =?utf-8?B?aWluTk4ydTMrRjB5V2NzbDRIV1JZQW9zN0dSQncrTWxFZXlhNU5aYjRoT0JP?=
 =?utf-8?B?aFRiZFpRM2Zod3dvbXMvaVU4dk92a0JPNG9GRjVxNno3UWVPZ1VIc0dDTlpU?=
 =?utf-8?B?eUJXNDdYLzkrK2RzNlFKV1lmYmFCUDFmMkhMRDUyU3Q3RXV6WW1ENVR5Vm9N?=
 =?utf-8?B?NDU1ZGEwZGtJVnZzeEp3bStDZmJhZnAxNGhqcEdlVXE3T2V0eU9nZjMrWU1V?=
 =?utf-8?B?QkVKZm5MMWpad2RvaHRsWGhFdTNGdWdLK0wxMWd6dElCZ1VZSGM1QytYWFJn?=
 =?utf-8?B?ZThZKy9vS1dXRFFsSk9EaExqVzNDTjdxMzBEaVFETXl4SmRDTFp5Ui9LbXlU?=
 =?utf-8?B?L25lREZjTHFoQjlDWEF2TlhWZkRtZmpEZENmb2JiRTRieFJ4Qkk4NGNTQ0xF?=
 =?utf-8?B?TGs3d20zSXl2ckhIMHRjUHlvb0xKRHNkZmlpZWlwempzd3gzVzljdDA2NENR?=
 =?utf-8?B?Nk9LVnROMXJxM1lhSS9SbDdJcExCb1V3K1hZNm1XTmd5Q3dIZ0pZdDRYYmdk?=
 =?utf-8?Q?p93y7utbwbY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6498.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmtnSXdOYzVESkNLeWx6WXpSZFV2aXVFZW9mb2dwSDY1elB5R21LSG1GejUx?=
 =?utf-8?B?VFRINVRTZStEeHB0Y0luNml0WkVLaGRPTDFicDFQV1VEc0IrUWx6S3g3OW43?=
 =?utf-8?B?OFJFOUl5TTQxRTcxM1FnR3lrb0doK1RoOGprWWgxYzRDWWl0NnVmYlc4RXNk?=
 =?utf-8?B?a1JmYjY5SmpYb2V1RGxRUnJ3NkMvY3JGak1GdjlOWkZqVXhCUzh4eFdxRVh6?=
 =?utf-8?B?ZDJKUzBwOEZYN3RwN21iMHd6czljVDRsWGZEVkhKeXB4NFNyL2NyclpHeWRw?=
 =?utf-8?B?TXRDbnJ3eEpwWGFHVnVRSHJUL3ZjVjNaYTdsa2lWd2xsK2VEWndCMUVRdldR?=
 =?utf-8?B?Y3FkZWl5Y21RZmg4NnA1K3JjS1VYUDBjR0xFU3Vob0RaYXNoN1pvTVBlaWI1?=
 =?utf-8?B?azFXYk5KSUJwK0NDRzEvL2pBWDAyUjlJWUZmMXYxeG5PQnlWYXpvRDZYN28x?=
 =?utf-8?B?SG1pQVlkWGN5YWNLN3BVYTRUNXQxWGR5dnpEeFIvQ21SSWlwWFFZMmNJMnF4?=
 =?utf-8?B?cTBuMkRBQWI5MXJmSVlodlZZY1ZMcDd0ZHF4dC9GY1JEQU00ZUIxUm1ZTXNz?=
 =?utf-8?B?UVhRYzJNZUdTSXhSdXdaNWorQzZXTVBKVlorRDc5SjdQci9RamV5bWU2aHhJ?=
 =?utf-8?B?SkFKY3hDL3ZlVGx3OGhNU2tkUm1ick4vRWxHQzVXbk9jbURPRE1OOWV6RVFB?=
 =?utf-8?B?YW9XUzZHaUdsYjU4bFpFM0JqKzcvWitxeEZxT0MvalBQYXp6UXRqRC95VzVz?=
 =?utf-8?B?YUhEY3pYWExtL29TNVR4M1BhRXhkditjZVBrVFh3d2x2TnN3c2Naai94NGEv?=
 =?utf-8?B?cmk0ZHFTZ2g5TTdFcGlzOWt2ZHJwR0FaSFdJdVkvci9YS0srTnd1SkIyUW1Z?=
 =?utf-8?B?MEp5VENsL2I5cUhCRGVQbjRhcGMxTVR3WG1zU1RDZnhaSjdSMG5UVUNwN0Zm?=
 =?utf-8?B?VGNJMWFsS2IvdCsvSjdYaHIxa1k2YlBodytMajU1YU5HaFFGVXV0WVBwM1hQ?=
 =?utf-8?B?dGZocUd2eFNGbWZzQWhSdE9YZjRiK0ZNK05XNS85cHdsRjV0Sm5ndXZtV1pO?=
 =?utf-8?B?SEI5M1BvK3FESW1mdHN3d3hkeWh5OXFMZ2o5d0JBM1JZT3R3bElHclNDU1VQ?=
 =?utf-8?B?ci9taXVtZ3NOamhLY2ZHRkNJTnFBVXRNZFh2a1lzaGxCNEErK3VUTWVQOU81?=
 =?utf-8?B?UUFQc1VqaTdDRzhSUXk4eldRQkd1NXFJSVF6SHJrNVQ2M3hlK1dGdHR0ajgz?=
 =?utf-8?B?TzV0UkZYeWc1VVllRkloZ0k0QmxuTFhxd0tjWVZtUEdxd2Uxb295c2VzWGM0?=
 =?utf-8?B?TVpBbnZUeGcwdGhSeTdBQlFkNG9DcE1IcmRaaGFQUmdYbVNMSW5jdGFzTG5E?=
 =?utf-8?B?czZRNUNMZEx6Q0VpdTl0WXZ3bUxjNENvVlJaZWVpRHZ5MFYxUFFxQ2pRRW11?=
 =?utf-8?B?QWZDRzVzZTR4RzhWaEVCWUYyZUpLWkgweFVyaHcyRVlyc3pDelM3cGlPVXda?=
 =?utf-8?B?SU1KSTVwQjRQV2JxV3VRdGZndU0xcjMya0JGUHVoMW5WUmYySC8wK1NId1NM?=
 =?utf-8?B?Q0JNbk1vaFRLSHZQSHNPdWJndGJyV0g2eWFwZnNYTGxzOHhWRktmS0lpYjBF?=
 =?utf-8?B?dkhYMmRuR2k0ZkhTcTV5OVZVNU4yUEpWeHIyM1dqeTBScUdROG9YT1NzNG9v?=
 =?utf-8?B?L1hlbERZdU5FaG5hdFVGSitVQVVPL0d2L3dJTzRpQVMzUDUxNHpRUzRKR2Ru?=
 =?utf-8?B?Wk90QnNyQlFZVU54R0lWRnVJSE1FOWdxSmlpQkpwQzRWbVNmb0lMQmFzbXA5?=
 =?utf-8?B?UDkrNkxoSFErNEVpVE5tY1Uxa0VyZ1JaYS91VWptOFk4UUhibVRzRklwbk1U?=
 =?utf-8?B?eEhvQzhXWEJySjZrOWpkQzVuS1hDeU95VGZPVld3MnFucGNWU0dibVQydzRn?=
 =?utf-8?B?OG82OTFoNk5UVWY0cGhiUWdTeWZCd2NHaWkrTzV0eWFCK3hESFk3dE4zSENS?=
 =?utf-8?B?VTQwd3ZlaTYzOUVjQ3NFdUlWVkZ4Z0hGSE9CbVoxclV0MWlWYUdpMWxKR0FM?=
 =?utf-8?B?Wm02TEhwNzc1WGM2NWNwOU91TGxNajQ0a3FoT3F5VlBBM3QwTmJ3ZDBMVFo4?=
 =?utf-8?B?M0hicE4vc0JpKzJlWkJYYzA1QkdwTEJpN1k4QXptaXlsV2NQbUc5aGxCWjFN?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b864f2-4e73-49b1-b60d-08dda4128615
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:22:44.3563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ7YrPxrtPwdz8twboypYP2bEYsAYYvEzTVzvS9N2tj9MtGsW8CXLbuTqQmO6kWgnr+/UvNcZR8wUfRMEt0aZKF5bRaL2zuYrZhlmi/BH88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6CF64E2E6
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

On 6/4/2025 11:40 AM, Bruce Richardson wrote:
> On Fri, May 30, 2025 at 02:57:18PM +0100, Anatoly Burakov wrote:
>> The ixgbe driver has implementations of vectorized mbuf rearm code that
>> is identical to the ones in the common code, so just use those.
>>
>> Since ixgbe Rx descriptors are always 16-byte wide, force using 16-byte
>> definitions in the common headers with a define flag.
>>
>> While we're at it, also make sure to use common definitions for things like
>> burst size, rearm threshold, and descriptors per loop, which is currently
>> defined separately in each driver.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>
>> Notes:
>>      v3 -> v4:
>>      - Use the common descriptor format instead of constant propagation
>>      - Use some definitional hackery to work around IXGBE descriptors always being 16-byte
>>      - Use the new unified definitions for burst size, rearm threshold, and descriptors per loop
>>
>>   drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 21 ++++-
>>   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 67 +---------------
>>   drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 76 +------------------
>>   3 files changed, 26 insertions(+), 138 deletions(-)
>>
>> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
>> index d1847a33dd..0640336156 100644
>> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
>> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
>> @@ -5,9 +5,24 @@
>>   #ifndef _IXGBE_RXTX_H_
>>   #define _IXGBE_RXTX_H_
>>   
>> +/*
>> + * For IXGBE, descriptor size is always 16 bytes, so in order to have all
>> + * vectorized and common code building correctly and with proper offsets, force
>> + * the common parts to consider IXGBE descriptors to be 16-bytes in size.
>> + */
>> +#ifndef RTE_NET_INTEL_USE_16BYTE_DESC
>> +#define IXGBE_FORCE_16BYTE_DESC
>> +#define RTE_NET_INTEL_USE_16BYTE_DESC
>> +#endif
>> +
>>   #include "../common/rx.h"
>>   #include "../common/tx.h"
>>   
>> +#ifdef IXGBE_FORCE_16BYTE_DESC
>> +#undef RTE_NET_INTEL_USE_16BYTE_DESC
>> +#undef IXGBE_FORCE_16BYTE_DESC
>> +#endif
>> +
> 
> Is there a reason why we need to track the forced nature of the define and
> #undef it afterwards, or is it just for code hygiene?
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 

It's the latter, no other reason.

-- 
Thanks,
Anatoly
