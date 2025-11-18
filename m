Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CCCED27B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 10:37:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A9F140281;
	Tue, 18 Nov 2025 11:37:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8375E40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 11:37:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763462271; x=1794998271;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LCo5HVkFG3wJ4qg7ssc/xPqoEuNU/adsaM5pwaE4N0g=;
 b=ZI93aI0neVf8tgFcfJva6RxcDYba07H/bfT1UUWrgNT+464laPzlb/wE
 U7kDxMo8Pn2A1LfCcu7/XzbTZJ7aA5pcYtK26xnQ3Ekxr3p2ZQKMACd0G
 co9E4qJIZKdB96VJv+lVDgb7+/6yiPKyCxvK/suOLeKTo1ytV6nsPAFRh
 VeGHWtKfhleUCuI9UuQgKewshdhph4EEMaf9v5RG9j6D+nacLmIG/kwDL
 Oc4a09wqenm3uZueJRUNSfH8/MRMgcZgwa32tGUKR8bMtU/hdQClTUgnX
 uvLp4bEChPLS24NAP5MfNC8eN+cMiUeeXA6lpM99qEIrWxpZrHNOPSE9H A==;
X-CSE-ConnectionGUID: 17NrsF9nQLqOEIm2SBpS7Q==
X-CSE-MsgGUID: UNsW9968ReC4EDsKJoEP5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69097042"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="69097042"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 02:37:50 -0800
X-CSE-ConnectionGUID: FWtkuvLBRYWQMkJjk9eFDg==
X-CSE-MsgGUID: goshI0VGQ1KICIi47t0Kyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="214114148"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 02:37:49 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:37:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 02:37:49 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 02:37:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLqo+/6PI2myDIudJVfuRGsjCSsQe97X4wMySddQ2vdjaGi+pKShB83imOIivs5CV26qWxtitAyUQGYuBKydnaAIpcfI+Rl5pqSd8yy3RWpnn0plAc2q8RtbQ9yCX/sHEuHpfOQLoOjkFdlOI2uYdxqLYDZlzsFsBxtYJVGUZjAeXl6nAVs1QNC5dHcva8BcFZhJrdWSbCqw33QN3H2cKSpQs8P5j7t5az8AsEKXMq07+f+y9bzkzGLMwOtSc1ecF/JviUQRbLc6DXHtTbKINpuDKkK5ugvpu508/mg6HfAi8JQHWptZ3cqMlMuKIpDiDiYEczGXdm9FQCoPU+J1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peUKwzEBxbKVaFgo89radJuSbjNn2QI5dYAjslhhe28=;
 b=Eny3d0s+yIMmMk8TxEiFeedZOZvN22DkgXgt8cpz2fIrWbE2s/LcDMRbnLP473JOzTL1Gly92ywVZOsnwyTstaFJ27ZCeS7i75hAS7O8mYJjTcWKtA8cF2VU4i0s5wiN3TFK97Bn7smLnl0rDT9DzgoGm3LnidI2+zsjv1NBUy1LkeaQNAj2lgfCNKyKocfgrmKwv6RDfXO8xQwIFtVWoI2xmxaNXcDNWKu77jsI58maPi5cGhdnGK9rVw4Myplc4R189pU21IoZkVBOjlSkkjtt28L8RdIg9PUIKImQ6Lh4tWzXOtIhzcckZIhzB1KSgpeH5lH1pcGQZ2cNPQxs3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA4PR11MB9202.namprd11.prod.outlook.com (2603:10b6:208:56e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:37:41 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 10:37:41 +0000
Message-ID: <5a1cde28-271b-4841-9668-abdbc852a72f@intel.com>
Date: Tue, 18 Nov 2025 11:37:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/19] vfio: make all functions internal
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Tyler
 Retzlaff" <roretzla@linux.microsoft.com>, Dmitry Kozlyuk
 <dmitry.kozliuk@gmail.com>
References: <cover.1763142007.git.anatoly.burakov@intel.com>
 <c32da3e93a0e093e4aaf2f7ec68202cdbb2140c4.1763142008.git.anatoly.burakov@intel.com>
 <20251114101813.453550ac@phoenix>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20251114101813.453550ac@phoenix>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA4PR11MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3719b2-958d-4054-81ea-08de268e805c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzkzdldKNUtDSldLbW1YRTZqUWNkYjFlRm11QWFZOTRFMUovWnJTaERpNzlm?=
 =?utf-8?B?UGMzUzhNVkhzYklvQXA3alJPaTgzSFpRenJKcVhWYmZVYURIU3h5NzcyNUpz?=
 =?utf-8?B?VEhMajdMZXMrVWM3SXhZbHNVcU9JMU44L096YWNKUFFEaVJZVlQvVFNucGor?=
 =?utf-8?B?N0hzSjVWYTUzYkVoMENodkQvTU5Ta1UwWnJ3eEROeFdxZWVlOXRqS3JBdEpE?=
 =?utf-8?B?T3VXTlA3WG4vRlNDcVNBQk93WmV0c2JNQ0VMaGdTdCtXc0hWeVNIT2dlcyto?=
 =?utf-8?B?L1c3OEhYNnpNVWVMWXNDNVRPR0lXMDBRZTJvREtuVzYyUitMSEtjbXUwNlA5?=
 =?utf-8?B?QzlYTDhwM2QvVDB6M2Q2Y0RodDUyY3c1V3BJZ3FPd211MXcyUHVKMlowUWdI?=
 =?utf-8?B?WnlJa3h3MjNUcENBSGhoS284cDlJU09XVFNBQTJkSXJWbjJHWnZKWDNxN1JP?=
 =?utf-8?B?ajF3eDRQeWxraHpUM2oyZmIxdnVGTTdVa1RaVzdwOFU4ZUQxWEdnWEJKZkFa?=
 =?utf-8?B?QUYyU0pEYWFhaHp4cm45bGdBNGVSS3BkRmNIM01DYklMd3FtSkN3aVFSdnp4?=
 =?utf-8?B?azc2QkZwekFWZDhHeWd6dUFRYU90cjhXMWo5UmNXSHhBVmNqdVNPQUxiejNt?=
 =?utf-8?B?VjBySDJmdXJ0ZGZBQjFOMmJzUS9DeENFVEx4V01sSnFCRDErYjRQUk1iRGZL?=
 =?utf-8?B?aUtHVDhvTGtzV05KUlpwQko4Y2JSV0RwS3FibGtyVHNsU1h1bzZLTUlLRkxV?=
 =?utf-8?B?ZzUrTjF5OGxFcmdlcllqakJ5WUtOZVQvcUNHZUwvOGZ4Q2t3MlVyS243NGMv?=
 =?utf-8?B?cmtwdkdyVWphQ0k4QlBDaXBiV2JtaU03Qmxmamd3ZWRzcFpCRUJkUGdybXp1?=
 =?utf-8?B?SHBEdzc0ZHBsT1ZwNTcxS3RPdVFQTldUZUM3YmM4K0tMSUdHSzRYS2o2TkJy?=
 =?utf-8?B?SUVsbVJmdVNmTlhTNXp6ODJOOFR4ZytReENCcVJXQ084NlV3Q2lPUllqZmFX?=
 =?utf-8?B?ZG4wOUx3MzNVZlRSYVRtb05yR1pOMW4wK0xmNnh2YVp6MnNncWV0Ui96ME9u?=
 =?utf-8?B?cTQyK29xRVdtU1JPSGQxb3JMN3RUUHhZUlVRWWk5dlkwMEVQSmVFdDhNYVh4?=
 =?utf-8?B?RDEvQzBKQmVqZ3c1bWhOOE9VeEUwUmQ3VkxEZ1hRSHpTVlRBRlNkdEEyblBO?=
 =?utf-8?B?WUNvcGhQaWVkVmk1aGZaSUcwYmE1ZkFYMHBDL2o0ZHhMTXpuck0zd1RoSVJj?=
 =?utf-8?B?d0tuczdkUk91QjdGcWEyZ3lzU2tOSEtjaTE3YTFXR1ZOUlh4VlI2czNPZWxp?=
 =?utf-8?B?eGFUTXhjWUpYRlJOdXFENGwwSzFOa0grVUlaMVh1VzhaYVVHMmdPeUhrd0o3?=
 =?utf-8?B?MHhYWlA5WWg5MGoyOUFOakhYTEJWU0xwSU1ydWdBOHV1SlBwZkIyQ0t3eEN5?=
 =?utf-8?B?YWdWMXFMSy93MHlabnZUb1JpK2N0TnI5ZHZ5MnlKYzNLYlcxMjNDL1pRRmV4?=
 =?utf-8?B?M0ErbHo0SEdBdDA3cjlMYzlBRHFsWU0weHpOUllveWZxYUlCNU16d1BNK3I5?=
 =?utf-8?B?Ny9FWTdUamp1QVQrbGJ2eHZGWkRmK09DbDBpSktOeC8vYmVjVkpZY1NiNHlV?=
 =?utf-8?B?ZGRxNkIrZ21haVVlUXA0Z0REdVRUQndTSTNxQkVQUVhxcmZ2SWQ0MndnemVO?=
 =?utf-8?B?Z2RSSFdFT1A3YW4yVklDZ2lLZlhIMWV4M2VNMTEyZjRhNWxUQndKWGdOV3Y2?=
 =?utf-8?B?RVZ6bkpzTHJPWHYxWHBtUnhtUHQzSWpBUVhtMVcvd3BDNGNNYlhHak5ObWU4?=
 =?utf-8?B?RFpzcnB2bkZpaHkvSnNCSmFmcE1VbGJvNWhuUWQrOUFHNXBzQWZTWTlna0NN?=
 =?utf-8?B?cDEyTXpBQmVVL0VLRloycktiaFhMc25obFFWYVB2NUZhbkZtRmJJWU5nOFFO?=
 =?utf-8?Q?y4NLLDSdirAJalC2uj42GerWX+yIgrZR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZBckdtK2hNcGI3V3JxMXVBcmZLY0toYlR6K0FXQkVrUEFzOTFwYzFhVzN6?=
 =?utf-8?B?cG1iajJHZlFma1Vjb29LdWRuWUVtYVBPdmFBd3V1RGpteFJFMmY5Rmg0Z3Vx?=
 =?utf-8?B?VVcvdzhOUjZUQlNHR21abEppWG42M0p0aHpDN0l2SzYzSDU0b21YaVEvMGlE?=
 =?utf-8?B?R09Dc25jaDB5K2NRWUV5QTNNa3VPaHZHZlRPbWhiUUtEYlBST1IwNG1wTDFr?=
 =?utf-8?B?SmkvR1lBUjBrbzZxSlN1QUV1VDB3UkhQUkVuNTdSaGRtdkZWN2lXcVR0NEd5?=
 =?utf-8?B?TWh0MXU4aUtqRTdSR2J6K1llL3VCaTVDR21yOGIrOXJ0WXJBc0pUM0tqamZF?=
 =?utf-8?B?bjlEYjN1QUxJay92SG9LaDdRYldwMVdweC9GQmJqOXoybmpiNTZoZEVqY29V?=
 =?utf-8?B?NDFSTUZDRmZ3U2VHTWxkTmVOYXB0WHBmTDV6YmxjendjOENWbG9naXZKWGZw?=
 =?utf-8?B?MFhqVHhMb2lObWwxMGZiS3ZPdHdvMUZzMFpQcS9RTE01MWhsaWtnV0NGQ3F1?=
 =?utf-8?B?SlcyTEpZRzE3UzVLZTZTeXdjeWZReHIvejNzaXovYTQyVkhUR3g5SE5wbHB6?=
 =?utf-8?B?OTVSUzRyNzJoZEVGTTRQREpVWUViRStCSTdiMXY2NHJENHVBRDh2U24vMlk5?=
 =?utf-8?B?REpraXlzZ2xlNjdEdklTc2duK2hjMmxLdndmTG1oQ2NUOU5qcFhzMHgvYWU5?=
 =?utf-8?B?a1gweUJRNFpFeU02T3pZQzRVL21NTGtKempBNTlHYWlKODF3bDhMeHRhRkhZ?=
 =?utf-8?B?WG1uNXI5VXYxOVY0bExHM3ZMMWlySXdvUERaVUcyUDF4azBOdjVrWGt3dFhQ?=
 =?utf-8?B?NzJvMWM3N3RXZll4ajFDQWNXdDJvQ2dTdmZuUnpUSVZQd2lkdWxhNndjdHBF?=
 =?utf-8?B?Qkd0MXdCRExUWHM1ai9vWWZjb2FCc0w0MlNraDhTNTg1WEpxMU9PN29zK2tX?=
 =?utf-8?B?dklQVUFKZzFpbFd1WFdaUEt0bnlIazhuOTBicUlBYnJIaTJyT0RXY0Qxc3BE?=
 =?utf-8?B?TmE0QTVxY0RxWEhSVU15Y2pKdENRSVFHTXQ0bmFjd1JKM1JXT21BaitCVkRt?=
 =?utf-8?B?WHZVZFp0Wit4MHpVRS9iQnZ3TGdEWmZDUkpTOXNvbXRwcGIyU1dvTitwaHE3?=
 =?utf-8?B?akVrbVpISVliNWpOSlRjeU9EY3ZOMk1iaTJ1eFdCbTdZdWxtcW1mTnV2MXFY?=
 =?utf-8?B?N3FFWE9HU3U1dWtMRDlOZUtNVTc2RWFCQ0I2NG16WW91OXoraXh1SkJkSmQ2?=
 =?utf-8?B?M2dXeGgwWWdkL3pRSkUwWWI5b041ZWZrZDgzR1JvV3dnYkM4SlRod3QreFhG?=
 =?utf-8?B?UmdTUFFpbUxoaDRFSWFCSGRXbStCZkhjSlJieTdhTFU0Y1JSQ2huRGhqK3N3?=
 =?utf-8?B?UkJqbE1qY1ZlajZQcm44b3U5aTU3WWp3ZG16YlpLeHF0NVI4SzFHREZOVGhU?=
 =?utf-8?B?NkwxQ1VFYW5OaUtJLzJ1K25ydW1EUU53aUZjVTBVNWZzNU9Hc3B2WTVWajFj?=
 =?utf-8?B?cVFTYkZvVmp5T2RkZkZrUTEzYkhCbTBkc25sZ3dBSllTNUl0bTFsdEltL2ky?=
 =?utf-8?B?QVczWXZkTFpvQmxzMGJnQWtxWlFTUVBJSmJxMXVmSmYwbUoxRU5ETEswTWdl?=
 =?utf-8?B?V1FkN1lxQjc5WlRlSm1zbVAzTW9LRnZhT3pHMU9hSFhwajAyZEptWG9DSmhq?=
 =?utf-8?B?dHlFQ0wxZlR0b1UyK2dSRllzdUYwTzg3TkRtY0d1eklHY0svRVhUMnQrSkdE?=
 =?utf-8?B?WXpBbVN2YnVUSUJLVW9DSjFuRzBOTVpOaXBTK3huOWpPejZ4OEw2MUdUMmU1?=
 =?utf-8?B?bDZkc2R3a0EwUVR0WWNoNUdLYzRmQkRLdXB2alYwbjBLNmJFcS9GVG9UTjMx?=
 =?utf-8?B?NUZXbnFwczV5MkNCc3l5Ni92S1NqdTJNVXFTMTh1Q0wrNGJMU1JwZzRYYWxT?=
 =?utf-8?B?NFpIUzUrS2dINVVyekV6anpBZ1lSSHduR1FKWW1xVFJaUHFUZFpKRmU5SkZw?=
 =?utf-8?B?eVFQY053bnBLTy9LMXMxeXZHaXRoQW5lYis0Y1E1OUovYnRTZDluL09uNUEx?=
 =?utf-8?B?Z200Ti9rQlNVb052bGRlRVUrVXJtbHJXUjkxbEEvQUQ2d2NEREtwQXYxUEta?=
 =?utf-8?B?UnUwa2dYbGJCT0JZdDJMZ1lGYkNDRGw5N0RaL29PUjZoWm1DSGYrSFVHZ2V2?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3719b2-958d-4054-81ea-08de268e805c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:37:41.6307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lrkg7GiRLQ/5GQe9ntZY4GSKrs1gkm2EA9C4gVBIrS7cggKT/w++3JCBvK2HAr73JVks5qCS5OFFKCBBY1y75sKXNeAMjarXY5PLcVBdzWw=
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

On 11/14/2025 7:18 PM, Stephen Hemminger wrote:
> On Fri, 14 Nov 2025 17:40:14 +0000
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> The VFIO API is an externally exported API because the original intent was
>> to offer DMA mapping facilities to applications. However, practical usage
>> of this API seems to be centered around drivers, so keeping this API
>> exported to applications only creates needless API/ABI stability surface
>> that has no added value.
>>
>> Make the entire VFIO API internal-only and visible only to drivers.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
> 
> Rename the functions maybe to avoid issues?

It's extra churn for not a lot of gain IMO, the functions are well-named 
already. Perhaps they can be moved under `rte_eal_vfio_*` namespace but 
honestly I think they're fine as they are.

-- 
Thanks,
Anatoly
