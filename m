Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52FEE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F194C4025F;
	Thu, 12 Feb 2026 18:20:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 67B7040041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916809; x=1802452809;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RWiWI+oDwgeKvsFUNBAkW60Pru0bVHt8tLxMQY7dtnE=;
 b=PErBOJCsIrpNZ8VolbeUmvMua1rNlYPpyCTq/r4Lxu8tZ6B3gGbDZ0mm
 FPBMMbCxZJ8kqeYzQsQ8OybJlGkKtqDmwHXPriR8teM6Oc2dxebPiiuXD
 8PMSRMYl2ruV9/CbydKV3K5JysUzgaLXzaCwlmXcv2KNGmJRoCMWZXB/H
 9ANgfP0RjWq/BQ4i7gw/HXpgoiEPnlQM/QT5z6iB1Zlcn7mvE9DTPqBcF
 MK0frxkLMKVvCs0VZCDTZyC0R8FoFfyr9XYorMPO065Oad1hkmvW4Uiv/
 CppbcaLj2uo1WamlCO+spxZ7NDN7ncuFb8qS47qjZkxFii6ezkwcT2Wt4 Q==;
X-CSE-ConnectionGUID: lagCjwvFTXWL2xa4Aikcdg==
X-CSE-MsgGUID: puFA53OiR2yqiVL+UwR1bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82823725"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="82823725"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:20:08 -0800
X-CSE-ConnectionGUID: gE0tf8GGQuqFKfwUh8ObHw==
X-CSE-MsgGUID: wQeglcDhSaC8nljDu+yHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="212765982"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:20:09 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:20:08 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:20:08 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gz9RxVEfKeemKSvreDs6YY2fyEsfL4kXCYHME999/d0u7uzNAQ40LlKI2cnxapc1WXfVBpN58hoN1sSufF/W1C0V4fnrGTpTuDXmfqTrh957IWv9Pr9zN+M3gA4URbTvZ2ujjvKF2GJHIPMkOoMN3HVD8xOdrx5jIHkrNG8j9/jELQ0g1HxPxE6mtOFBuwqTK9M5BEAme3KDtmy9glVANhjEW3uN2Zuk+yKHzbijti/ZqrJlpKgrVz17tVHLzg4opLYs3lGsuBg7wPFSpks710EV5JzlEDELAQFIEb50pTbczfO2YHKuumLszMTww4tuFc+xWubOHDJWJCoPimWBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWiWI+oDwgeKvsFUNBAkW60Pru0bVHt8tLxMQY7dtnE=;
 b=GcU764a/eubKcAXSfQB9aq3JcHO2brOnfEbjAZ6ypbtMIqoJE/a0YmPGs1aBVaAO4qHkN5oBkUGdZO2tuLtVxP+25pcgAO9EcKfchTN6qu/Zui5lMFLe0alcBn0YxBsHQbHxIsV0bPaddCKWEKTMrnW6T7BHPKOX//O/tRqnoIQMGgqbJ4mY9nBTOd7St3gEfy2Mf0smXoqsDNhxFO8ND0+5416d0oEshRfrY4W8LI2DzyTpnEmWWtre51WVFSKMFdeup3W0fVOvYTk6Ar8BB6x8zLntlIG8C5bucCzsV/PrRly0NIvSpAq5vT1BUKMwid7XY1Se5Drc9mS9VhF0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Thu, 12 Feb 2026 17:20:05 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:20:05 +0000
Message-ID: <71d23a8b-7d7c-4cad-9ef2-7dbf80719069@intel.com>
Date: Thu, 12 Feb 2026 17:19:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] net/ixgbe: fix memory leak in security flows
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>
References: <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <25cd42dbf99da44057b6e48cb04f61bd406db3f2.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::19) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7dfb19-1875-4fbf-6217-08de6a5af673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3l3OGRQUVAya0YxajhBUjJjWFViOW9XcW1NMDJzeHBMeCtKcnE4dnkyOGxK?=
 =?utf-8?B?aGtTdnozSUl5blpJeUE3T3JJWFpWMDBEMzA5Wklqb0ZaSG56OHFqN0VnN2JF?=
 =?utf-8?B?VU5ZU2lQSThUSTlQTjgyME5wN0dRTUZQWjl4enZqTmlZWXJ4NVlrbFR3emJw?=
 =?utf-8?B?cGtIRVU1UUIyWGRCY0RkeTVFdnlWZmoyMlNUQVRna1FVeTNwZjVld1hoN2FG?=
 =?utf-8?B?U2Z4b3hjbWpHc2ZwOWVIWHd4SHRwT05kc3pYUWQyL1NZaklwSGlxeUxWSlk0?=
 =?utf-8?B?VGp2SlZjZTRnYWx6VWl4b2E5QUtsYWlsZEVuRmhiYWJGbTQzbXJNalE0aDhp?=
 =?utf-8?B?MWZ4MDFuZWNTWmk2akcydlJsNkhRMkRRWS9KTFk4Y2VjV3FqRlhYWjVzOENn?=
 =?utf-8?B?NUIvVGV4cXJncHoxdDNKL1M2QWh5YWZKM3VhTGlPZ0pTbWY2OHpRcUZNeGZ4?=
 =?utf-8?B?SVN5TFNlVzlNZmdmK0JnVWFsVGlCYk5OdzI3aUpqVXpFVkpYbVlicGVQRDdQ?=
 =?utf-8?B?SVJ1Z2dWeXVablJ5OTFLaGZZRnhsMmhvWk0weG4zM2w3SE5JbU9EQ2JoL1h5?=
 =?utf-8?B?NXpjNDBuTmJhV2tjOFExNDlZUVhyWXFMMVNtZytqSDJEY2l0ZXpJMkhmc3V4?=
 =?utf-8?B?Vzl1QUF6aFJPM0pmVGprQThzM0JtK0tUb08zeXJScHFUdjB3eDJPK2doTDMw?=
 =?utf-8?B?c2daTUlCR3FsZERyLzNlQ3JtY1lpSXN1WlFMajgyUXhFbXVxZzBoRnZIYThq?=
 =?utf-8?B?VTdyWGkrMGYxNUQvTDdvaWlSMTdFT29aL3ZoYzFHaFA1UUY5dkNSL0NhQ3pu?=
 =?utf-8?B?S1d4OFVxV3h1NVo5WGozK3laNnRPajNHYTFBWktLNXVWMHQ2V3lZTGxoeTVq?=
 =?utf-8?B?bHpHMmxJN3JOamlTeFdqeVAvcDJYZGtETi9QaHZSbks5Y1FKS0hSR3BQM2Yr?=
 =?utf-8?B?cktmVHhXUXExSjVaaHRmNGhIbFJhc203emRtQmtiTUdwR01ReUFPZVhxcGtO?=
 =?utf-8?B?REYzWGxCSVlFaC8xS0R6VW0vanBNbWRzUmZpSzA3SGZXd1YyM3loVmZ0WWor?=
 =?utf-8?B?bmtzVzU1aURQd3cyVE8yMm9rc3lkd1Z2R1dSZ0prWXpkVlFqb1JoWWFPaDFZ?=
 =?utf-8?B?d2xaRG1MMVdhNWljcWR6OGJjelZmSC9OQTRrcW0rTERHOHRvbVJFT3dyaGhK?=
 =?utf-8?B?cEFSZ1g4N3hPc1Jla0E4L050RXlEZ2lHSXlGem80S2V5OUJzVTNjdllyZlp2?=
 =?utf-8?B?Y3F0QzIrZFJvYStmYStVKzZxa3l5L0VvbmlDNDVsYTU0c0NVZ20vN0l3NVlt?=
 =?utf-8?B?MnRuaVRqcWJFSURKYjVzKzAwdWdDM1ZiNk83OHlGL2VhRmpDZDM4VnVrdmZn?=
 =?utf-8?B?LzRENTZwS0pLcEU4Vll4cnFKMjdDSWlBOWtYNDhRKzNFdkFhV2lVSHlNWFFW?=
 =?utf-8?B?eUt6ZGcwR3ZNam13NFJVR1FNUjFnUHFjdVFMaGQwakM4SzdwRFpJemFJQlNO?=
 =?utf-8?B?dXptbUxvOGdGOFlpNDJkNnlZWmsxbXQ0a29oa3hVVWNYMTUvVngzWWJjek1V?=
 =?utf-8?B?dEx5TGFadDByeGFDQm9CQmNyNmxjMVBZZEdSU2k4RGh4d2N1N3VCQ1c4eEtW?=
 =?utf-8?B?TzJxSTJPVmtjN1RQNkJqVFQzSU5RR1lpLzNWbzNwNHAxY1ByQTByckY1ZWRO?=
 =?utf-8?B?UjM0Tlh2c1pQWHViZitydS9zMEJwbHRUcDQ3RElPNTZZa0N5bVJSSlQrUFJn?=
 =?utf-8?B?WFF5OHF4cWJmdmoyWFBxSjVFc2RCb1YrWS9oRHpLUE1VaFV3eGFaVndERGhw?=
 =?utf-8?B?MTRKVVQxN2pqT3VVUnIrYjBzdkU1N0kwQUI0b2VTaXFsemZKV0Vkb0JKTG44?=
 =?utf-8?B?NnpEQjNxaVlnRWtwR0FFdDlGTi9sTXYxeFRsN2FYS1RHVWJML1pKb09jSHRC?=
 =?utf-8?B?YTVLRDNmSk1MZXAxUS9kZ2xacmluR1UyZzd0Y0xIZE1vRS9keU5HeWQ1K2JP?=
 =?utf-8?B?NUtqdWVMQmNmUHAvMFhDdHN4MzVxdERlUUpKZVpNcDZnQ01xeGFjUmZKQjZl?=
 =?utf-8?B?QlFKa3cvcDNMQXdIVTh6blNzdEZnSVVQZ2t6S01URHpBbmNkR3k5Rm56RmE1?=
 =?utf-8?Q?E0IE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y243OStvTTJtRFRva3NzWlFqNThXUUlLRmJoNnA2VTlCS0o3T3dsREY2Rkp6?=
 =?utf-8?B?MEdadkxpTC9EYjA1Y0Y2R0ZFVXU5eEhZakNvd054ZTlnUHB3VXFSWmVjUUFj?=
 =?utf-8?B?WUtZdVZiTEx0NG90Wjc2MHBwTHRBSVhmK05DMFJ4MW5sZEExdjlma3pERHc5?=
 =?utf-8?B?QnEzSExtS3l1QlNCcEl6Y2hRUVpybnZKSEpXbUtvNCtHRlNXYmZJMGpoQmli?=
 =?utf-8?B?b0dtTXJtdjFVbUhRclRtTktDaWo5MTVpOWJvbDhvSENWM1I4OE14V3VWOWR1?=
 =?utf-8?B?dHlQMVJEL2NhdHhlR0R4bGdnc3RJNUh0Zi9IYm5RSEZ1bVMxd1FSWGJuUVA4?=
 =?utf-8?B?SHlZM21iNEt6M3c3RkFSMHpGSTFaUW9veEhjWjlWRFFNcEppRzlhNjNjL2Nj?=
 =?utf-8?B?WVZmMDN1NEVETUVlUGhaRTZZRTZNeU5UZ3hTR09Kc1o2TVdJTkVmVjRMdGxO?=
 =?utf-8?B?WHllcnBaaG92M2Z4Wk1rTnJaK1k4K3pTa2Z1U3lzNEVYTVhzOHhpVVlITlBT?=
 =?utf-8?B?dGxKQTFLZ0tkNmFPcjJkN2w4Mi9qTVU4aElFT2F0VStHWnJKbFJvbUpqUVFy?=
 =?utf-8?B?b280eTZFVVFjN1d4S2RpNkpIenQ5bkhzZERrbFF1VWFCVEhNS05MVFlEYzkz?=
 =?utf-8?B?MXRndlprcGZPY1NRYlk0aEJkY1Nka3QrYlZESHZUTVNzcVk3bFlsb0JiTUxT?=
 =?utf-8?B?NVZHVExNNU1oNCt5QnJOemluR3MrNC9zbVc2M2gybmI1NlJKd0xVckJKYy8w?=
 =?utf-8?B?MnhuMG55TStXczYyczVVbE9BNFAvUWptcVRwUXFwbFFRaW9vYWdIREd1aHh4?=
 =?utf-8?B?azNSSG8rdzdRM296b2NkdWtiRTZWNG1vanpLMkFOelZCUHhBd0dMZUVSWFJr?=
 =?utf-8?B?dExXVjVMLzdTdGlzRzVtcVN0eXdmajlpNWNSK2NjTGxKcWw4eWtSUmNPSVJk?=
 =?utf-8?B?aG9MODA0bTNJYk56K3dySzI3MmF1YVZ1NVNRTDVHTUw4Nkk0Z29kWCtaa1dO?=
 =?utf-8?B?VnJ4TDNrRldXQ0h1cVptSkluMVlicWhaQStyY3ZSY2s3dTdGS2J1ZU16aXVl?=
 =?utf-8?B?MFFFTzAzbHNpeEw5TG8zMGJJMUFGRlJzc2pGYkREOFdkaXdLQUhGZFN0ZTY0?=
 =?utf-8?B?Z0N5aVNMZ29GZmpVdnNuTzBLdldKQks1L3ZSVm5WTXNOK3gvcFByeUo2V1o5?=
 =?utf-8?B?Z2k1QmpmRDRNZ1Vqb0xDZEFsRE9WOEQvZ05TU3k5TGt1eDZjZHRnK3ZZSUln?=
 =?utf-8?B?QjlJbEZPK1JwcDlmUXJTSmxpZHRROE9qS0lUTW1vbEFFNmI0V0NLU2UwbHps?=
 =?utf-8?B?cVdqS2NMOERJWEh6MUxqaHYvS1hwdUgrbGtKV2dIcXVVdUcreWhnNUlsWUNy?=
 =?utf-8?B?MXVPUWlENjRnWDFJT3BxdjVJWUo5VlRWTlVwOFpwRkZoYVAyMWZUUUNPRjNm?=
 =?utf-8?B?MVAwQ2hjWTVFQ0ZXU0h1eDdObDJFUytpTE5jclZBRDcrK1c2MHRGTWwyTTAz?=
 =?utf-8?B?SmpLbWtTRFVYcnl2cWJzUzNIcU1wQkRVQWxNR0JQbGFVc2RHU1g1OU93Vkc0?=
 =?utf-8?B?YjI1Vk5Mb1RHdW9oQnlYNnJpaWF0MkZHb1hqMlBGN29QRDRySWRBeGJPSWNJ?=
 =?utf-8?B?RlZ4ZWxDbWVKbkUwZkpOa2ViQXdiTlNEZHhKOUM0VjRBSEVNWHlYMmpVZnB1?=
 =?utf-8?B?dFpPY3pMQlp4NWxwbVlzK2pkZU9qdndIRDFyNW05TXowaXE2RWdtdmdKSWt3?=
 =?utf-8?B?TWtKNFFCSFcwK0tlb0pmSzdoS0IzUzZBaVh2WlpPQktpV2NHc1hucUFaSjVQ?=
 =?utf-8?B?QUFrUDdEMjdhQjRvYmF4V0NZZ2Rhajh4RE9qKzZxb1p4YWFuaWhlV0YwVGNV?=
 =?utf-8?B?Vm1zcXNFQXpvdG9hcGw0M1hDZ1I3d1ptOUJQU2NFV3RRRll4b3k0cG5peFAr?=
 =?utf-8?B?ZkFNb2pqY1JrYzUramVtSldJVTBvSGp1M3ZzZTR5YlNZd0pOL01uajl0dGlX?=
 =?utf-8?B?T0VJTG8xamtIaEx2K0pGL2Rxd0FEQ1pXQWtaM054TjV3UmtOOXZ3UGFlZk5S?=
 =?utf-8?B?WTNqUk1nQXM5QzJBeFpUaWlQU0JuWHo0TnJaZmNHbUFJL2cvMStDSXFXMFJh?=
 =?utf-8?B?dWNETFpESmNaREYyNlpTbUpVazcvdkdSUFRLcndTdU5udnZPcWV5N2xwMWZQ?=
 =?utf-8?B?YTJIb0JFcTJ2RkNBb2FYNkJVS2Fac0xwcGtYNFZOL05SUWxuaTlpeFE5THF6?=
 =?utf-8?B?OFhNZTFZN21udk9GcXdZcStHM0dYOVZqUW1Xd2NQV3QxeTY2ajk2Z2tpemdK?=
 =?utf-8?B?bzdxS3BrK0grVFIzZVY0djVtSU81ZWVMakE5YS9QV1J5bDhuRTNydz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7dfb19-1875-4fbf-6217-08de6a5af673
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:20:04.9442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGUycOiyD6kgfwaXRyBaRIAC1qUHJXGu+BNi6VzooVmydjBeBKiUyTl96/+m43W5Kaihtt92HTJ1xXHElkW0YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
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


On 12-Feb-26 12:53 PM, Anatoly Burakov wrote:
> Currently, security flows are implemented as a special case and do not go
> through the normal flow create/destroy infrastructure. However, because of
> that, it is impossible to destroy such flows once created. Fix it by adding
> a flag to rte_flow indicating that it is a security flow, so that it can be
> destroyed later.
>
> Additionally, security flows return pointer to allocated `rte_flow` struct
> unconditionally, even though the underlying call to ipsec code might have
> failed. Fix that by checking the return value from the filter function
> before returning.
>
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
