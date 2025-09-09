Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75678CA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 10:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C031402D3;
	Tue,  9 Sep 2025 12:17:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 39D1340281;
 Tue,  9 Sep 2025 12:17:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757413074; x=1788949074;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+jIGenWSTlKhuJd6oITwNXs+0Pq1nI6Utop2xVsLRyY=;
 b=JTSML/WzDbF4WP4lX8RS4jqjYepCWNe50R66H9L/CWEyFARFz4aZSCNI
 yop4Gts4jWHDUXGAGeEkx4WmDijqYD4y56W4ZDOj6BmhrCXNCu1M81noA
 K9DMUuxwqAFXdxxwCbOWqRIyAVae3vxsWB+zgbor7dbyMPGjX3LutrehK
 Uw/CwLJow4E4M7K09/FYeWnpHzrzYG1LQJtyyv6H8yZjMzC8BSID/Nui3
 Ctgd3AGXlXfHLuuPgrpwfWulOFaqDnkBBenLtvIcM776Q+oT6xf7/RxiE
 cg3b21LPiyE6foRVDacVQKb0KJfLuxw44HY/2azFNzShL37Xw3ID8tJit Q==;
X-CSE-ConnectionGUID: GGYEhNymSl2bOpY3mCJ6Aw==
X-CSE-MsgGUID: tmtKx1tVRaGwVyMK+ezS3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="77146783"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; d="scan'208";a="77146783"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 03:17:51 -0700
X-CSE-ConnectionGUID: o/0TO1O4ROikghYNreUg4Q==
X-CSE-MsgGUID: zymuvUWuTAmqpmJgFgf96g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 03:17:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 03:17:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 9 Sep 2025 03:17:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.79) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 03:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW1fk+c75m0mMNIiWiz5N+yNvMFz3/LDGxWVNIojjFy2ZQzdfg4d5wRd4BKcKmI6H9k0mjrxDb0fYu2QEhJu3epT3rlJFWGdseWZNaGEU6Sg82t4WKxAd43XUG/pt6lGHK9UJ46mZkWxmi40+mz38Sy4U/+RpC/Vm91JeI6apZEUofM80X6mqJJY1cyTD0Gp4cXiPmA5Mq8JlzZCG1lMkqKyJ51HW05YRLeX+0AeC8WE09NqWiVMq2O6OgN0Z+W7xPb1rK0/MI59I6OtKeESQ99Ysj6LA/vxt2X3ANGhiquNfsEDz99OBwSPO4+uoHwzrly/KkrL61FwfnCMoRkoDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sloAqONFAWbGdQEqukI0/c7qGX3UJXZpM8OvwBJ/C/g=;
 b=H0hPPMV+XY2LDVeeIZDl0kgbMjj1mTI9IaP4JvbZj/cDfWJh/Kjp1WF6iKTZLVdzb1lo1bx6Kd5gDvCv/ViU+OPcJ/FyrGpZJwPpzKETq9weaqoXe7I8WLnPpmd/yV/cC81qo94aw7wrVJpdsgduHBZz4QeFyyWsxy6QUjSuL99m7KnjIhxKl7ICzXcc+wJw3TK20wMWwG5WyjVl+CpC6BAw87SqwZZi7cDw0hLd5V3ZBbxH8SgFS2uMM0e9urKohHX0Oqo0hrRo//KCvm4Q7up9tgZyEoeQHRPc+LYpTbMPbXetcvnRBOMyJd6//tvQV19mVUrPJYi/MFn2G4qIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW3PR11MB4553.namprd11.prod.outlook.com (2603:10b6:303:2c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 10:17:47 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 10:17:46 +0000
Message-ID: <c5a7ce8d-2bd4-47c1-b246-f87c8c1d33b1@intel.com>
Date: Tue, 9 Sep 2025 12:17:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eal: fix DMA mask validation inconsistency in IOVA VA
To: Shani Peretz <shperetz@nvidia.com>, <dev@dpdk.org>
CC: <thomas@monjalon.net>, <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Alejandro Lucero
 <alejandro.lucero@netronome.com>
References: <20250908163456.420268-1-shperetz@nvidia.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250908163456.420268-1-shperetz@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::22) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW3PR11MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af415ba-841b-4d2b-e644-08ddef8a1f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlJtczUxVGRKQ2FZbG1KUDVmeFVhZ0tqbzVLa3BJU3I4dEZyOFJwY2RBZEpD?=
 =?utf-8?B?L1FOaitBcWI0aSt3MDVaSy9jckZpY3pDY0xPTFNBZ2dOV2ZOYmd5ZGdCWG5H?=
 =?utf-8?B?aXJRRllzcml0WjhadnUxeVAyV09BZXd0NUl1Y094MFJnVTViekNONHhFUEQ2?=
 =?utf-8?B?bHQwLzNMYkZYQjZxVnFGOFMwejBXQzhHMC9lVER3TzdlbHdsWElFdkRXMDV6?=
 =?utf-8?B?czJ2MEZER2JHeWpkT1NBdUF6cnczQ2xSYWptY2xtQ3g4VW9rUVp2cmRtbVN6?=
 =?utf-8?B?SWExbzlGNWh1RkFnVnEyOEdOSCsrTU5aUlp4dFJCT25PYjJLN2gySldhUXRB?=
 =?utf-8?B?cDlyRjM3eFRwNmNqbSs4S1BhQzQvTVRKSnhLdTJSVkpIaXNwbkNlVnRicFhn?=
 =?utf-8?B?cHRkOWpQeXRXblpzNUFXamZEZVZiTVVYNTZYMEZSVEhHOS94ZnIwR1FoYzA2?=
 =?utf-8?B?a3RReXBOUVNhN25ZUUVwYWorb2s4dzEvQTRqWjZIQ0NQOWNEZ3k3a0RnOTR0?=
 =?utf-8?B?TUJ4NU9zNXFBYlpiUXNZazlxU1dHTXhyNmtHSnRWY1BLMTlFUzVmVlVuZUVm?=
 =?utf-8?B?VE9UcWVQMnJFU3pLNkRPRlpMbVhBUllvaVc2UEl3T0ROSER5aTFvSkZ4Kzll?=
 =?utf-8?B?YTJwYUdQZS9ZMkVsVDFJQ21NTzNQQTZiS05lelpWZmVTdmxoZS81MXdScDdZ?=
 =?utf-8?B?RU00MEdPaXhJOG9SNCtMbFViN2hsSnBIUUV5T0YyRHVqaXEvNnJTbkw1V2l4?=
 =?utf-8?B?QWVIT1k1TzZwMjZxTUIwbndwUUg3M1dwaUJtQytteElyZjNrMjdOYjRscUJp?=
 =?utf-8?B?ZG9OM2piWHlJSzlwNndtNURiV2MzZ0t6ME56bE1YbXVJZm0zMFlqcEpuVFkx?=
 =?utf-8?B?anA2SUNxQ2IrK1NyVm8yUmtkM2d1cjhNUEYvYk9wZnJ0cHJrTVk1NzUzM250?=
 =?utf-8?B?M1hJTnJ6WkEwcDV2Q2JmaElIK0JiN2l5UExBV0s5UHJXNjhXMWRzNXkwSWpX?=
 =?utf-8?B?UHhxb1pPQms5OTlJeXRlYkgraXNnQ01kWUdFNzF1dnR3OE1zMjhnZmltTjF6?=
 =?utf-8?B?c2pBUzB0SnhsbGFySkVGaXJDVFpVaW5tekJHcVBXY1hrQXlINTUxRDZWUGVo?=
 =?utf-8?B?N0NYTXE5aVNRWDVkdHZGelBwc2QyMTlXQk1jVkZwUGNxMCtUU0Y5UW03QjRI?=
 =?utf-8?B?ZmRNeXdwT2I4c3VxS2ZVVlVqdWJyM1VkOG0vbGh2RnNpWFJXK3hQOHMyRnBC?=
 =?utf-8?B?VXY3aVh4dG5CaEFjejA2bll3aHZWUWZTbWp0MS9lTDNYc0h3bjMwK0RKS1BU?=
 =?utf-8?B?dUh4aEpjenkwL0RqSjJVZ2lBeno0cGVLcEpRTE4zTGp3c2Vwc0VrTGY1ZVJt?=
 =?utf-8?B?QU83TzRXaWEzbmtla3FlSTQxZjl0SEloUjBFSXMvbE0wOHA2eXJYQWhxTEVi?=
 =?utf-8?B?bGpsT1BjTnJQa0VYSDBSanRZalpZOG9ZZ2ZBV2o5T1psV2V5b1RMT01SSFI5?=
 =?utf-8?B?eHNRZnlLdnhHRWxVc2xKZE53YithRXZubEE4ME9wZGdOSTZJSFJnL1NQZ01M?=
 =?utf-8?B?RGlGZmZoYVl0c0UrWHZPelBXVlh1ci9QQjhDdlJ1RnlxRmJXZnIrK0Z0UEFZ?=
 =?utf-8?B?aTJuMzY5WFlJelNNakdxQm5oVitvVllXcFZvUFVoTTRnMThPV0R3MEt6eGNO?=
 =?utf-8?B?eWVqR28wU2FWUlQyQWpQekVSclhrNDlwaHlZekQrdjFmaU00c3JPcHlrcWlP?=
 =?utf-8?B?Wk1yYWV5NGJYVWZJVW4rNTZmWkhIVVBOU3VBVWpDNkdLa3A1VGMyUS9pc2hI?=
 =?utf-8?B?NVJ3MzE0c3Bnb1ZuekRpakV3eWdDRmxBb1Z0alVPSThNRnd0Q3FDNG1QSjh2?=
 =?utf-8?B?WXFPT1JUT0RLbzlnTUdjMTV0RXRrTHVrZFN3WlRaRTNmUlpxK1dWWklxTVhN?=
 =?utf-8?Q?6wBocOny/vg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2xxOHc3dUE2VzJKTStsQlg2Q0ZDR0ZXdFlJVmo2NlpTRUNGbktPR3g4eEdH?=
 =?utf-8?B?dFhSK1NCNGt4cUdyNi90VXVOVW1TMHI3WTZxeGJSUG9iMXFPcHBaY3JhVW9u?=
 =?utf-8?B?b095UVNrSUtUeWRJaTNtUk1PbEN2K3JmSFRoK0dqQ0huN0xzQ0Nxam11Qjhi?=
 =?utf-8?B?MGYxRDZGS0wwbjYyVlkzUVcyb2lDaHQ5dnZOejB1VGY2NjkxQW5OWlJVb3dN?=
 =?utf-8?B?VFpBZVlMczFmYmppV2hvbmFWaVg1elU1UWgyZ0gwc2FUemNKZnd6aS91VWJm?=
 =?utf-8?B?d3Z6bi9hQldhVTh2SkRNSlN5OEF4TWppSUJQZ2lDNnhlbFNJODZ0NHNETldj?=
 =?utf-8?B?Sklsb1hnRGxrMGd3K0daNG5RQXNHTkFnWU1sNGdyR2N3cXdialR0MVV6c2Nu?=
 =?utf-8?B?azFEWHh1eUtMME00MGVPbldCckE5ekhYMFNpSWhhb0VmaU0weWhxTXFCKzhY?=
 =?utf-8?B?K2VBRms4a1ZxMk1kemwrT2dEYkJJc2tuOGE4VGRJeFJXZTFNNkJsY295Y1BM?=
 =?utf-8?B?Sk54SjNRckd5SjdUVHZYM0Q1d1F6NXg1czlJU1gvd3N0TC8yK1kxWmdnVWxL?=
 =?utf-8?B?bk5qTDh0RHZwcGJydWVqZWdiajBreGgvdXVqZkRqQmRhUGFKSVAwbGdqK2kz?=
 =?utf-8?B?Mi9kMzhiTGhxVlVUMGorWXBzZnFFaFpmUWpDdFRKaitsb3VlV09hakh1ZW1G?=
 =?utf-8?B?YVBUQjRGaXRuODVybGNDYjVrZHpRMGRxT0VjQlNQQVhMSjUyYURwYTFaY1dZ?=
 =?utf-8?B?TzFRZTQyNzhZZ3pCaDlMeHhKRVRyU2hUY0xwSEV6dlhDMUQ2cTZHdUVBMWJY?=
 =?utf-8?B?TjFrVnJOSERWT3k1ZUJRQmRpU3FRWUpxbmd1M3ZCT1ZHMlQ3M3JwaWQzNk5s?=
 =?utf-8?B?SGo1MHZqd253cWdnSVBxT2lUbHVodzRZajlMRGYxUnVVYVNnQ0lkVWNoakdE?=
 =?utf-8?B?SDM2Qitha3F2OHhnZTdKc3ZzekVPUmNxV09NV2dTa0svN2JOWWJ6RG5QcW5I?=
 =?utf-8?B?T0lXcDdXM2VoT3FBbHNPTjE0YS9KTmx5dTlSLzRhem9OYVlmMzFmUk01VGxi?=
 =?utf-8?B?K1hSdDBTaEEzbEpLWVUvaWJxWEpIaXo4OUpWMlNoWFhncmsyNW1OZVJtRUlw?=
 =?utf-8?B?MTBtL1pqYmlFUXBRQ1ZRenptUHFRbTIxaTk2VnhhSEpCeE9laVJ6ZXkvTmV6?=
 =?utf-8?B?ZDI5dGNzcWorbkQ3a0lqWG9xN0pmc21zTnhwaE05S0FyNkxkVXZCMHF1MFZa?=
 =?utf-8?B?cVB3ZnowSE0vTlZtVFd0dlNlQm9FdW90eTE4T254T0lKL1VMTlVSalZZZXJC?=
 =?utf-8?B?MGlNLzdCZlJvM0ZUQktFOXg3TGlERUhQdWQ4OE1nRlE4UTZjWks5WjduZGx6?=
 =?utf-8?B?dmhnbHdKNzN6QnVPbm1wNFBDWmJkTHBldjZld3h5OFRaTEJNNUVZbDdkZHFk?=
 =?utf-8?B?Rzg4Wm1aVGhlZDhpd25Hcy9aNGdsQ0JQYTFBWC9RekFTaUh4bXBEL2hYNnJ5?=
 =?utf-8?B?S3lWSjFSb01MQTdrWmdlRDRPeTdHeUVwZXZNQXRNMTQyTnVxUHhrdnlFRFlD?=
 =?utf-8?B?RUlpWDVhak40R3RLRCsyTWVoRWE1ZDdFVnlHTlA1S25pUlNYSVIvTXBaTitj?=
 =?utf-8?B?RUU5Z1I3bU1WYkJBeDdrRk5FVUx4WnZ2dSt5YUloRmpiVTRlaDdoRERuTXB1?=
 =?utf-8?B?NGtxckhsckZuN3gxUHp1Tk04NWNRYTk5SFZvRDV4VnorNlpnVWJQeERHd3dp?=
 =?utf-8?B?QVVGUFlNc0oyaDZCR0k2UFlmVDJNODg2UDRGa01vWmJ2bmNhd1lwRGRpODlK?=
 =?utf-8?B?WnNjcHU5U0NQM0Z4SW83NHhralUyUC9NU0E0NDRpdjErQnNjV2dkd2ZJbW9B?=
 =?utf-8?B?S1F4ek96NGpiTkg5c1pRc05KYmN0bll3TGZ4dkJsenBnTUw4V3l1QU9rY1NK?=
 =?utf-8?B?N1daakFRbkYxY3ZRYkJFczhUaG00NlVETm9QejB1d0pXRUxzY0NrQVBRS0tY?=
 =?utf-8?B?ZDFYUUY4UklZaXVjYWoxL0hwWEhYZU1yVUYzVkd1OC9OeVNiQ1Y0L3NDTjU3?=
 =?utf-8?B?MGk2ZHlvUXczZklYOUc5NTBKaFJ5aFJlalE5SWU3Q2toTDA5KzdUNmZLL2hK?=
 =?utf-8?B?TmR1Y1ZUTC9iNW9kMkJuVS9FRGhheStJcmFRcGhWYzdKTVVnWTNZSWVHUFlO?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af415ba-841b-4d2b-e644-08ddef8a1f36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 10:17:46.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NKMsqEhs11e6lVtV2O0KBo/sdb9fdVfCurEeHkBVUtqxyixB4XQzFzOAHbx2dBENg0cQ8DLZquyC7cTjevVYiXHLgxln5bLGwisOvShaz54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4553
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

On 9/8/2025 6:34 PM, Shani Peretz wrote:
> When --iova-mode is explicitly specified in command line, DMA mask
> constraints were not being validated, leading to potential runtime
> failures when device DMA capabilities are exceeded.
> 
> The issue occurred because rte_bus_get_iommu_class() was only called
> during IOVA mode auto-detection, but this function has the important
> side effect of triggering DMA mask detection (e.g., Intel IOMMU
> address width checking via pci_device_iommu_support_va()).
> 
> This created an inconsistency, when choosing explicit mode,
> the DMA checks are bypassed, but when choosing auto-detection mode,
> the constraints are checked and enforced.
> 
> The fix moves rte_bus_get_iommu_class() outside the conditional logic
> to ensure it's always called during EAL initialization.
> 
> Fixes: 4374ebc24bc1 ("malloc: modify error message for DMA mask check")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
