Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB0C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 09:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB299402B8;
	Thu, 17 Sep 2026 11:11:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 3D307400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 11:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789636294; x=1821172294;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HbAcAwVpF3HJ+Xi2aOUPrIFAiyeFPABukINnXUWioMY=;
 b=nYUw8hAX9Bx4bgY8wJbI8La/Q3+qM9/R1aRF6zUPXfkwZ/zC3POAxdhz
 uuKWy3bez3RxCiqnhQvxyf4Ou2349N7NOhyxJixpdZ/P02YIJB7hEYuM6
 CwP/rq8byPpH3CZQXOdLzhkGyMv08ojVRz3US31kgqf8bohiNQAskqUQ5
 rvEhPtOLw46MpMELtdYC8D3lpnXTDbaNAPNiRoG9d2QY2liajgY9jX+lE
 ml/kGKg2XQqGr9QPWpQUzQOtZxjprYL2F34LMoVgJoXezr2ZFCqFku7Gm
 TCKFYz1+8Bapo9EoP0XjOpUrg86m49KNXDZBAmuJDPFq1duhmMJeuDg15 A==;
X-CSE-ConnectionGUID: bmB/u9DzRCOJW38ARyRglA==
X-CSE-MsgGUID: FMErd4usRTWZ6VsSb11/eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="547249"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="547249"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:11:32 -0700
X-CSE-ConnectionGUID: 3ZutFdrjSZS0KO9xMttzDA==
X-CSE-MsgGUID: eo+CChGXR5WOQ2LiJKSDhQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:11:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:11:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:11:31 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYCcailrBJ0Jc1mfTdOP4d6EzKMbU53K43w6oEeExFzVQUiuP62XMFGWe+z0tg3aAdmKbdCC7ZipdJ2+KlmwyvWnVfZ1d133ntNip8SkKDd67VyfKI6vwg/Bnv3pEA4MRSePJDKIRaRvfNfeTB3rK4RtPnK3DPcBFxcqJR1cyzR92tGUfEgpAQAmqM292yELxCtgz6OAVJg3ITXtUN8c1ZS/HpUrRWPLQpiY0GmcpUzDW4QMOzquVw6AR/4USOnkfvf2pqLF3phSbo4EqXfO6DxfcG4DLjHcJRKcon92qfoEJ2kksR4LpT5lOztiDFpl741x8s0IEn83mj2lA6ejsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu9JHxOEw/9+w6wmsqU10O3gvkCj6jjvZfa6y+2GKds=;
 b=kEDbn7A11H8xjZdTwZ5ePnBfXmWTVXChOUjivlPyYB7+7hX20A9AiuC7hhofEATnphrXVrrzYqA01k6e2T/Au0G9brKvxKYFVQoODY61V1P2Al8ZH7us0f6CRutoz8hEMrwp03lROTgp/liNT17kbyXiagc59vjsolM2KX9ja3gA0EarBBqDtRysqq/Atxfe5bT6fypB5Z44BUfQAaRz+bRiZNOb4Jfjd1rpMkYW2Vg9uzzzXccdVU+4Pg3u8NRYbRrdcZv5x5HWqz4MHzy5ws/jZobleFdPtAcrKtnuO0JsmLMzq8/Yau/EpUHecKHgPehp00zXEj0Rgapal+KSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH0PR11MB5063.namprd11.prod.outlook.com (2603:10b6:510:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:11:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 09:11:22 +0000
Date: Thu, 17 Sep 2026 10:11:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
CC: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>,
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4] net/iavf: add reading PHC time support
Message-ID: <aquutDpDGFKs3zRf@bricha3-mobl1.ger.corp.intel.com>
References: <20260727102444.789833-1-anurag.mandal@intel.com>
 <20260915164231.247037-1-anurag.mandal@intel.com>
 <740d146d-3a67-46bd-b901-438e6b635511@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <740d146d-3a67-46bd-b901-438e6b635511@intel.com>
X-ClientProxiedBy: DU2PR04CA0328.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::33) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH0PR11MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f4cd92-ec0a-4298-c5e1-08df149ba42f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: posUsUZybyuFGdL3bQBr+n/R4juGa2NS9Hhq219yB2H7nI0GxUtDMe53R3V+ZF9suNe4p7oJRuyDMAcXh+p5fb2eiOLjlL8k6FK3qLm+QQQb8CuEkkJWpVBfpw+8F1Un/wSU44VqUPmCKFBIzdRfWTRJV9/crqcbCHwb7icmiqlGSgsCQnHMl6BxjQbMbwHKssZ1eq6YYVC0iUxylclLRfMyCWIgLfhgc4+YrgFBuu4h61z4XPE9yQJddLmFmiRXEgKw7rs9H30U+7TabmI96nyeCEIVyl86zXeHqU+mhpmDV7J8uzaU2Rnft+zyba2BUVaalh4QnLEZUwc81Gkgo+0MaysPVvzgqwehZddMDDHltcMwUhlx/TdeZjvJWvNnE8Gb5YUL3Q9pcgCxiRxsSTd6KSWrqqLf9rLcILh3r0uOMUTQjyJa6tRsqQ7Eo4KZe3yiZTYG5XlkzEfLwGTpb6ZbZJW+MwYFJS3D1fRvax70z2MF2/miw/o2tUvnsAfX3MXmZbJATV6ghgAXhP01LN1wZmx9ZeyhULYca1N/J5GcHAwDW88wJGHYxkAF4lAQONK4873/BsulIJX7qLgyAKAfGR3nLxg18R+58UBkicEdG7tjBcCaTBlQgREwSxteElz4RXr6LgpDXm+m1+SQGIgzNPZ7kY3XVTzMUaQjjzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GNPA+z4SOr6lls0VcTYcfCEAUh2ULFl7txkRywYx/bkhbrqjgG4fLukivM1u?=
 =?us-ascii?Q?0ikxmD+A8tgC/kQELVTJwgJ2lulrPwjWaZJ5KMrKjQbqzBb18ETq/PW3o+m/?=
 =?us-ascii?Q?bxmu9r3bnmXiXKzeNw9NTuUDGIbP64ZUQDikLKVTJJTLA/H8Bwglak7hRWiI?=
 =?us-ascii?Q?npKtH+YsjsmjIexzlOv3tphAdmgn2p8KORomhEibfkha+/M9V2D91GTdBJ2m?=
 =?us-ascii?Q?Mz4kf5/hi/1FIH/VgziRNHSo6tnJ4Zy/z578V/ae1bIe/sJsYLanO752FyH/?=
 =?us-ascii?Q?LCr0AHMg2dfmKqZDmWLTu5hQ1KcUryobB1rMPMS1wZ2G+5H8jr7jFww39SWo?=
 =?us-ascii?Q?7shOcHYcyqLxH1ZOdWGDr7MHO3VbZ7MTOjCKNkWqs9OkxTk7wt7z5JuePg6U?=
 =?us-ascii?Q?nMo5oR79OYm1ia89kL26OhmygA9/iWg5VCKOEIrLQNSRO11LtmAWQkc0qYqx?=
 =?us-ascii?Q?jUY28PSyukJYSWWNPAdynuPTXgTeTpo0GzbFD1rCfCWnRedrPDK3Nd1Qow3m?=
 =?us-ascii?Q?asxPbvghsDRK2Hngc8zWqHv3+j8Cl4UEV2N+sbJYd7JmtavHxgHXNzVuk+98?=
 =?us-ascii?Q?Jiy59SL/e83q9+HRC5IakUVpzIAAK/pbPkGJ1fOWD0dk1A7s/0QwrJGu6o+S?=
 =?us-ascii?Q?IhvfJwA3UgqMVZrb6iPkpw2g49zaofco7gMqYdFJwTz1HO2Kp+LTRf4bnjht?=
 =?us-ascii?Q?gem9/kaITYX95bdDCKyjJLeHAOp2DrJTMz6QFKGYes7ztlXr91m0Yt5ObKWV?=
 =?us-ascii?Q?/2CGmFxlrwuUj00fobeW+zY7nbFXgA8OhvG646J6behGfqF3aT2/R+Pzfj47?=
 =?us-ascii?Q?5sJb+A0DsULOLauCPx2NZoO7Jn+ONW1VpCKdrvy73QSR2debcgYbGK4l1+xH?=
 =?us-ascii?Q?kiPED3K7shb+OGRlDmwWNGJHjbTqDzeg5lMmloTkFyvZ5SMwh39j9wqGY8GN?=
 =?us-ascii?Q?fUMMvblArGrGD05zbmjCyfD0CUy4AxViwNEr75GvQWf7taJyubD/+tWm0vEn?=
 =?us-ascii?Q?ouY0wJ6d18P0jMx6Gp9jta8Kq57kKtAMG2u0Mqw77xgxmyFhCSXs0WeIISl+?=
 =?us-ascii?Q?4HgaVNtchxKHcWgaz0uySubirAmNUWbvRjTzdkU+16Dd/txWABGQ6eiOHZfJ?=
 =?us-ascii?Q?OtRmgw+1TbPiRtUOjzQk4pdVbEmxeOObvM4KERMF3r3TqDLOaXGGSMsLWxEg?=
 =?us-ascii?Q?iIHQjKkXQek7d8GCNeVaAiL9EPxRw2GraEIMWi28TUhOB9hBMHYYH0B+15jq?=
 =?us-ascii?Q?f68N1Xm3HAsmCeK/SOEXVomGyADbckwH7ojO9Yqw050IJENmLIUgtbDj0300?=
 =?us-ascii?Q?SpgEctAZBL/DYcEYLjrdgP3CsS5FYyASYv2Ct7tTEfQCDv0R2bQJ7bwKJ+Sm?=
 =?us-ascii?Q?C8M73L8e1rukYRV7kJHLiGWt/38+0xh2UbbvVBQAq631xJINMcSnGog//dye?=
 =?us-ascii?Q?CdwAFDmbKUd+DSeJ2IclPBu3bE6qXTWr+5vjtA9i3IUYs0Vz8Bi5ckwW09tJ?=
 =?us-ascii?Q?wDjZOsO+O5ZlAXZ3EtlsYaaqpzIOUAkPY+iX+KeI0+7LNQjYLTyv558/cZEy?=
 =?us-ascii?Q?+nfKzYqYypDdpdsCibelQ6KUFn8IbUxBiF/SNxZgS6qFMspLqPX1hD6CFt5Z?=
 =?us-ascii?Q?GjaQ4h/af6F56BSydnTHcxYDMc8a022klfKZiDruh5FzId0TVqziYfbRtfSr?=
 =?us-ascii?Q?yGNUWW97Sn37VK2OM5o063/PGfrbXbsb7NRhP19ZrxWMrwYADPngxPrLY3wj?=
 =?us-ascii?Q?8uYQW1cvZ0nwqP0GczPAGBO3nivM4KQ=3D?=
X-Exchange-RoutingPolicyChecked: JEQY2cNt/PihVVw+a/HryoZktefMe9KpccygaLrfz/gkUYIuWxx9+Fx4qkm4Z1bEHT0EhVw3QEvYapm0tqMIJoxyKTdD5Peoy9TGByoPiHSQOpIF/7JWHI/qwk6hMnlgXeGskkifmYInw2RsbjJgwimhmBAiRwJ8RtUrFQDaBt/aKBNvNwZ9RLBLgM+iSCyYRuYrvNs6Bnff+Robg7KbnDCymG2/zN4yZslm8lSU5oWr024Mya/DMxNL1jbanqvtFmhiTAYPs5aepyxOXIqqirvr1kHnzemW6uHzZ9JdsXRMDs6I3uIj4sCmw4tQE1nYXlAj2x479knrOyJS9jJb/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f4cd92-ec0a-4298-c5e1-08df149ba42f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:11:21.8895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQMAfRDOuTA6OR7vugAE3byvV85fRqsuQp2904p4Co6y2Z+CSMe2ysgWgtDW9kMqIClhGu50XQI9B13rJ5wEzchveKcTkgkq3M5qvCKxdU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5063
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

On Thu, Sep 17, 2026 at 01:34:12PM +0530, Kumar, Rajesh wrote:
> LGTM.
> 
> Reviewed-by: Rajesh Kumar <rajesh3.kumar@intel.com>
> 
Applied to dpdk-next-net-intel.
Thanks,
/Bruce
