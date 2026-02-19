Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D8DE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 09:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A502402E3;
	Thu, 19 Feb 2026 10:39:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0A8E8402AC
 for <dev@dpdk.org>; Thu, 19 Feb 2026 10:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771493950; x=1803029950;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tRT40G1AEs6DsagWrMQ3yMa6H8R6B9Q9ujsh8Tw07jI=;
 b=cEmXvEPm2Suq7Ff4g3x+j7WyOKJ0E7iTjHWaJs6iljjnf5oTHDShtRfU
 +U0gCpGItTnYfBb8AeHzHPpF1tR5yDQm1jknjBhFGdJDd6dr7TY3tfjPu
 kpC8mCiYSqvtjMhSzBI1obOz2zKyAilMc/Y1XXIFgKtlwGjM3c7rBM8nb
 Nls3UH4V26luHYvcPezHFUXiOojSNUOAIx2GyMzCObSxPSbFatw10c0Iq
 MWxtsOyumX0cLDRuMyOz5tFxDGkRo21sWRC5z/W+hGawuzC9C7gpps9do
 MkjlwSWOCcichJjpBb+So+puxERG/kBcL5qeEodTan5/NhuY64G0WWXfA w==;
X-CSE-ConnectionGUID: 245TMDjpSYaKstkEYyVaow==
X-CSE-MsgGUID: UYlkQybfSGmSY81twjNfBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="89984761"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="89984761"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:39:09 -0800
X-CSE-ConnectionGUID: jEdTA8OYQAqD5KwexvT9Ww==
X-CSE-MsgGUID: wf+FsNi0StmEYJVYj8P8Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="212724994"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 01:39:08 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:39:07 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 01:39:07 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 01:39:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSNNEM/nV8ZOmWRtqQ7Aw2Xo0x6XXMxX/rq8aqnpNRKV/Uj/h5m5vqsVh5jzDveKKNMZku2ELkF4csET20KOjpEBYuHFGJnEZoyQ0nwQRts/T3HVprGgb8tBqZr9PkThn+lpnCID6ppLxPl60ikBK6biXwHFeCNRB/5p2OTvjCzSfyhMiAcngXh0FFAk4srSxz/GF8UGNFp9OfIDqKokdQouTmXFys45rge2gOnRZqNQ/5F/89ObU1iWkaE9Nv/jgl+/zBrFKUbPU0f/Y716n7xeubMnsomCJi8MUZ391HiQ8Tbtn4tUemesbYfUUOZvSC96wYDjCKBfjlUlJP6Haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/dsIqgBWypciGovDfz1SgMKsxiPZb8V9YjvygoDvHc=;
 b=TJEFDy1C6tIaGlMj0aAy8IYhvppsCjYFAA6MSKvH0ydonhC5Hrqxpn+0Bxcqk78lwJ9m11f5Ca2PB4nZHMoSU6dau0tvp//70HOmJJEqsGiELbCi7h797mM/mK1/k3N+YTUZWI6jsr068nklzqIFGFiZwHnv/9DF7Yy92iurE7U2MVQBD2VZ9DoEs2XtWWkeY+2F9Ne2/Jizo3vDibxNtMe08SUbb2DASO8KP+lRVrkYoeiUgdMumFtCaXw7O9UKzavu2/DIAdvulHqZtudjp9JKi7VUDO2iKA+ub+ExKRKXRyzAvx9hw6LGof/wm4wBg2Hec5MTv9u3L2xtaxRjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 09:39:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 09:39:06 +0000
Message-ID: <e75dea36-d3c0-4a1a-abaa-4c44e46f0ac7@intel.com>
Date: Thu, 19 Feb 2026 10:39:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address
 operations
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
 <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
 <88f7b829-83aa-48b0-9de4-fbdcf5633603@intel.com>
 <aZbYBIoAonxgBpiD@bricha3-mobl1.ger.corp.intel.com>
 <aZbYqwhkGM1R-7_S@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZbYqwhkGM1R-7_S@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA2PR11MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d7c969-8c05-4db2-b8c6-08de6f9ab945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWVqRmRmaU1FbEdzdnYwdk5MbGZENnVDbWtPcHcvaHJyZnNoRFVKSWtsZ3Fo?=
 =?utf-8?B?MU8zZ1NjL3dRQndFckpsZ2tSUFBTMExLNUFHN1BHUGJ5Y2RUT1p3MUNBQ2ox?=
 =?utf-8?B?SzV5dU5qN2M4S3JteWlGR1FKUFBGdjV4Yms1cDUydldFejZHU3Qra29ZQUdz?=
 =?utf-8?B?dzZNOW0wbTZYR0grckdkYlE0dlA2NlRBTXQxUG9VOFU1aHM2QllTNnFOblJ0?=
 =?utf-8?B?MXVWNEFNSThlZUFERDQwQXpMWEJtZS83TkZ4cVV6NUsvVXZxWnR5d0ZPNUlW?=
 =?utf-8?B?ays4QUcveTVwL0lMSG9hbE5ic3FhYmxGTDdiRVdUSWdpK0pQUjFSZXYzbkhJ?=
 =?utf-8?B?M0sxSWJwNmtuaGJSRDJvRUVFU2pjSit6WHBhdXZvR1lwYmxHWUViV3NLVXRF?=
 =?utf-8?B?bzJEcXpTQVBzMVhFeC90MU10SDkza3gzQ2YxVVEwa3VKVWhsYkF0bm44MnRX?=
 =?utf-8?B?ZFdDUkczU3hFRTZScFord2w4bjNWdm9ZMUoyRjNkVzI5T2hEU2pxSlV4VEZ2?=
 =?utf-8?B?TU0yVkRRYmpvYUFsSWRHYWhsdUVqdHRlQmlJVHdMUGhvTWpVaFpKdVZielFs?=
 =?utf-8?B?Z3NOY0RWWjREVUJzZWp6Q1l1MDdrOS9TOVhGdjBjL2lVbnpBUzNNc3Qzc2tz?=
 =?utf-8?B?SzNNWjB5Y24yNXJ1VW5XY2UraURNU1ltbStPSGs5VENpZFNLSW1BcVJ1aUJH?=
 =?utf-8?B?TFYrb2JlVzBtV0g1RUNDekdnM3cwWXRlR0EwMlprUHZNYVNnRSt2dUd0ckFs?=
 =?utf-8?B?blZJcVVwY1NaelRSSmJsVDA0bUgyZWFHQ1JvTHphS3IrMG95bFcrWEpMR3M4?=
 =?utf-8?B?MVBtbFZjRkE0bFQ0cHhON1M2QWxQR1prSUtScytxNW1iM1A0eldPaFZZSFlX?=
 =?utf-8?B?RlMyc00ySDA3d2FVQW1SYUc2aFI3SnZzNHZ3bW03bnhyZE9wb3ptbzVsOUl0?=
 =?utf-8?B?WTNiU1luRHdyRyt0SnVHWUMxeGlIME9XbzB6MURMbXlOY09HMjlKeEZiakRX?=
 =?utf-8?B?M25qYkR5UndTWE01MUV5NzR2dzgwNDl5aVZMOGYyVnh1NGhhTWNGaCtlT2Y0?=
 =?utf-8?B?OGxOSm9iSkVISmZZYTJMRitQMVFmdWdkUWFUWlZyUll6K2pNNVJPQzRlaWF3?=
 =?utf-8?B?TWNxcHlSb0JlUWp0MENyT202cXY0ZkNrZTlTT1FOUUNLUUpPOTgvLzI0ODdl?=
 =?utf-8?B?VnhUK2lSVnNrUEVSVVFLakZRWmtjZTZLdjI3YVRuV1ZpNkl0anZxSXlYYXZT?=
 =?utf-8?B?dWNoRWp1bGdESnNpS24zbXZiWU42S0svbVh4VFpKVks2bWdZMExOU3BIcm1U?=
 =?utf-8?B?aTlURW5OejRpcGJDTVRlcDFxSzB1dU9HWnRUOVEzejVsaU9hWTV0ZHpmbmpa?=
 =?utf-8?B?TXBCWno2NEh5VU1wdHVXMHlibFlRZGJ1eTZYNy8wQmdZaDEvUmkzYWNWVC9M?=
 =?utf-8?B?NUVLYWMrcmZJNjJ6Z1k5QjIzeWJZcEkvMzdaSGpEWTVrci9WUUtKdWlDZnhk?=
 =?utf-8?B?d0hic20yM1hucGI2Y3RNRWFidzI2S2NCZG12b2p4bk5pRTliRzZxaHpwOVhT?=
 =?utf-8?B?U1RBKytKMTc4bVI0d1dNK2ozcHNBQWMvdm1nQ1pxODJmL1BoeHdBdG1mR21n?=
 =?utf-8?B?NHg5c0VGMklMMXczMElkMEgxUUhmeUpOb0ZYVnJodHR0T0RkSUJWSjFpdEFz?=
 =?utf-8?B?R20yRS9qK3ZXOEhtU3dnczFNMlczSU5zQVBHZXZxSlVuK2VqcDBVa0JhdEtQ?=
 =?utf-8?B?Vjh2QVNqWGdlQ1FXZ2luUGxMYmswT0FaNkVEbUszbnA2VDRmdllXNEdhSUxi?=
 =?utf-8?B?eDlWVTBSbHQxNlEvQ2tOeGUrcnlMejZlN1pXN3RsOVl0L1Z6c2pQZFQ1ZXc0?=
 =?utf-8?B?SFBLS2JwQzlrN1pjUVJMeGRucUViVTFkTmZXaERpZjlrb2JBK2wvcVpsa3U4?=
 =?utf-8?B?RHNNeWZaR2YvY2taQlpGb2J6bVNIWjRHcUVTUTdrV3Z6ekhSYTJrVTExclZw?=
 =?utf-8?B?SUdOTGYzY2lqWkFESjF3dnh4U3crM2JRMlBqMGJOa1E0N3pocGNra0gxZ2FI?=
 =?utf-8?B?VFcxZldqU2N3UlpDODRJUnhNUFpZQVBNczN0WWxxOUxxUzRjdmthUm1XV1FG?=
 =?utf-8?Q?YUvw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTA0U1c0RkZQKzdDZmVtcTBEUlhkL2Jtd1lqUWxpTjlpTDc4dkRxVTR5TG5r?=
 =?utf-8?B?THd1bHpON25xWnB0Q2Voa3lNMWMwNUVRdVRZM3k4K25RZ1lNQXgvNGF5UDdW?=
 =?utf-8?B?WWxEanFYWGw4WlpTemorbVJsUEJUcUdxYW1MQ21lbjZTUDJsV21vYjl5NnYr?=
 =?utf-8?B?WjhBazRhMytvWFJYNTZuVjZEajF5eGx5aTdFczFsYmpkaEZucitqdzlFd01k?=
 =?utf-8?B?T3BDQVZJRGVLdy9oSm5OYWx5TmJ0bWtsUjZLSnN2SVU1cTZxWXo5WVBxdmxX?=
 =?utf-8?B?WGpIRkRZYXJhUSs2TWFhZWJWcG1vSnh6OTNVb1g2alJ1Q0xxZm10QXVHSkNS?=
 =?utf-8?B?WjJRT2hvQXFTSy91RXgzeVlxek9rcHFWMEpMWnFWc0xyVC9vNTZIY2RudGtZ?=
 =?utf-8?B?d1BWUCtVMnBIUk15UkloNThocEVQQUdWMFBHYXdWMmIwOGlxN2lvOUNMTHZv?=
 =?utf-8?B?T2pZbjYxV3ZxZVF1Y0lJLzJsWkN3djBOVHZGaW8xaGdMdlcwYmlLN0dmaGdh?=
 =?utf-8?B?STI2QnJZOFJRS3BhZlJxTy8ya2YyWjVXL1phMkRuSnJhVGI4dFhhMVFpZlJz?=
 =?utf-8?B?dXBSOXUzYTNETTdJdXlvKy9ydUZLcnpJWFhsZHVqZE02MitGN3ZOd1cxNU4r?=
 =?utf-8?B?UGFTNnNoWENqUStpR2psUzlCY1JWaFZIRHN5NVJtMkd5Mmh6eENLYlozSDF2?=
 =?utf-8?B?eXZocmtPS2I5SDRmNzlCQnl2T1luSVlLNUo0T0V0NHNnS0NYaFo2eURYanBi?=
 =?utf-8?B?eFlKZ2VCMDJFNktmRW5UaXVhME05WFBhTmpzbE1EbXhLTlArYnVGT0VMZ011?=
 =?utf-8?B?S1RjUlBHOUpIVWlTenhqaDlGMi8xUmVJbFBFMit0T2VhUERHQm4rbmt5T1h1?=
 =?utf-8?B?NmIwK0VLZnR1ZWRuaDRMZ3JuNEpybEZKUERnNXpZNzFhWHpKM0dPREZibmRh?=
 =?utf-8?B?VzkxZ0ZrOTdMS3FrbzZvY0RsMmtoZFNWOWlUZzhtWUJJd3VzeDErVnV1VnBN?=
 =?utf-8?B?SzkzZUVVQys2M2dTYk1vZWtiZHdBbHNQamNWc1R1YUFrQVVxd2lucjhNVlNY?=
 =?utf-8?B?QWRqM2JoK3B2dXpRUCtjNzBjLzNKZktRL1d1OTJ4eVkzaWx2dEFkVWxzZ1BF?=
 =?utf-8?B?NWpXTTQzQU9WRzZBaHpqcHpZbWI5TjlYWGVMQ3J6SWVqczQwQWVacVpPdEo1?=
 =?utf-8?B?VmlLd3FjQ2xyUWtvcjl6aEZhaXBtNFBoMWFiTzFUTDJVbEdMSDVIdTcxVmhy?=
 =?utf-8?B?YVdxeFFOQzJFdTdDaGNiMkljcUtOQWN6VGMyZzBtd0dyV1FtZEVWZFUzOENu?=
 =?utf-8?B?WTZKTjlzVW90QzdWd2ZEd3h4SVZkb0lrUXBrK1FFL0dRVFlycS94YnpRakJx?=
 =?utf-8?B?Wi9TeGU2QkZaK1phY1d4MlAwQkpsMFdyQkoxcU4yUU8zTTlFay85SEFYanc1?=
 =?utf-8?B?UDJDOVdrOXdkZ0Yrd0ZFVXgwUUI4T1dRbnF1WHBDamZBY1k5UEF1dUVpYTZM?=
 =?utf-8?B?RlVYL0lPeTR5WFFDQ3FoVm5WU0gyUXcyN2tzUFljQXZ0czJ5YnZsN2JFaXJO?=
 =?utf-8?B?cXl6UHM2MVJtb214QVVMeHNRTE5ZYVdBYyt1aU5HdWxwck90L1RoUUtQam53?=
 =?utf-8?B?OVlJbTNFWlBaczFISEorRHdOM1RyNmI1azZQV2VJL0I0REZwRGh6VjJ0NTBQ?=
 =?utf-8?B?SDBJU0tUdHFydVFLSHhCRDd2VjRMWE5yM0Y5a3RrREp3QnN0SGRZanJwR1Fi?=
 =?utf-8?B?N1ZMR0wyQSt5UnMwN3RtZXhSZXBVYlZucUNuUE1aMUdFajk2YXFEenQwUm9S?=
 =?utf-8?B?aWMvMktSWDhPSmFNSG5ocUFxODJ5WTJwdWgrYlcrNmtXZ3E0RlFkazUyZW5o?=
 =?utf-8?B?R1kxUTB6L1BGOW9abHdXbXNBWk1JajRlMkNWUTREcThEZVlIYklqOFNRZm1y?=
 =?utf-8?B?cVNkOTJ1Q0c1RG9yM2krYUpHNmx5NXlQSHVUWlA4Z09IbjdUNVQxWVcydFk3?=
 =?utf-8?B?bmhFdGQwVDgzcHBYUzdmeStiemNzd2hYOEJPalZ5U1pFQkxoem9nTm9oU1M5?=
 =?utf-8?B?Uk5TUjhzcTJMUTNMOXlPMVgzZE84YjNhSnNqNnlKQkk1enZWbWhrWXlyNUVZ?=
 =?utf-8?B?cjkwVng2YjhTWEl4cFRsbnZDN0lBMGZnTEZCNDhNOHQ2b1NKSlVnTzBHblpI?=
 =?utf-8?B?U3doR3JUWWxHWkxlcHhOcnU0Wmhkd0JpMFM1eTNnRkUxWEVlc1FIZ3crdGdR?=
 =?utf-8?B?c0MzVTlvdHI2SU9HUnBHcHhKRnc0YnJaYUFzYmFZdmxJOTE2RUt6Y2trdXQw?=
 =?utf-8?B?bHg0SHV3U0drcisyMjZ6ZklIRXdERmNjWHNIby9RVW1aSUlwY1RtM01yK2Ru?=
 =?utf-8?Q?OANxwK7EiPr/JOoQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d7c969-8c05-4db2-b8c6-08de6f9ab945
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 09:39:06.0246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UST5mMuA72HxoImwX5U1qfmBg0V3bHnTMlCDDxPS4Iu3GADJvrlAe+X8rLTHqGBcxYleEmOztdEkA7r3Yf1CLu4z754wCCpoIrgDGatVx+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
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

On 2/19/2026 10:32 AM, Bruce Richardson wrote:
> On Thu, Feb 19, 2026 at 09:29:40AM +0000, Bruce Richardson wrote:
>> On Thu, Feb 19, 2026 at 10:22:24AM +0100, Burakov, Anatoly wrote:
>>> On 2/16/2026 6:27 PM, Bruce Richardson wrote:
>>>> On Fri, Feb 13, 2026 at 10:26:31AM +0000, Anatoly Burakov wrote:
>>>>> Currently, when adding or deleting MAC addresses, we are using
>>>>> rte_zmalloc followed by an immediate rte_free. This is not needed as this
>>>>> memory is not being stored anywhere, so replace it with regular
>>>>> malloc/free.
>>>>>
>>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>>> ---
>>>>>    drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
>>>>> index 55986ef909..19dce17612 100644
>>>>> --- a/drivers/net/intel/iavf/iavf_vchnl.c
>>>>> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
>>>>> @@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>>>>>    			}
>>>>>    		}
>>>>> -		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
>>>>> +		list = calloc(1, len);
>>>>
>>>> Given the loop above has a threshold set for IAVF_AQ_BUF_SZ, maybe a static
>>>> buffer of that fixed size might be better?
>>>
>>> That size is 4 kilobytes, so I agree that we can use one buffer rather than
>>> constantly allocating/deallocating things, it'll still have to be
>>> dynamically allocated.
>>>
>> I still would use a stack variable myself. 4k really isn't that big
>> nowadays.
>>
> 4k is also PATH_MAX, and we use stack arrays of PATH_MAX size everywhere in
> DPDK, so I think we can assume that it's an ok size to use as a stack
> variable.
> 
> /Bruce

Ack. While attempting to figure out this code I just uncovered a whole 
bunch of other places where we could replace things with a stack 
allocation :/

(not submitting them in this patchset, but there's gonna be more rework 
like this in the future)

-- 
Thanks,
Anatoly
