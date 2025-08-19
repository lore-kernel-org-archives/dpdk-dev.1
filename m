Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C212DCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 11:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 040EB40267;
	Tue, 19 Aug 2025 13:10:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8996A40144
 for <dev@dpdk.org>; Tue, 19 Aug 2025 13:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755601837; x=1787137837;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=zlPXQnRc2ssyfsEN0bKjtCM5pF9vrT2sSnzs+fAFsKo=;
 b=CmWjg5Qc1gvhVaQI+7ftXkDllguCTEW/B3EqXeX7I/wl2tpyPbkiJPLu
 Ody6dE626C57eRWNRot2XCg8ckI+GSLAm97XgP174cdtsxZCF366pdw72
 xg+An2rNFJYxujswBmvgvziMDvCd87srmFSr/5gjrQKodHX4G6Mos8cOp
 +DIzr0smRLPpD7rB4yTUd3LICy0BOHWuHQIlHHHJstEMb4sxZ3q16qbko
 +O5g7WcVSJsXbgamKqUnFMQimlKVzLbeG6af8bhvH+Dau9ZpgTf2XLVGC
 lUgo0fftEJ8j2/m7SxJFW8kaRD7jqlT8GW+HXpMXic6Gr8JyAf6Z4pBQg w==;
X-CSE-ConnectionGUID: nV2SrsO1RZauxoU7EuLJ7g==
X-CSE-MsgGUID: csJkvSMLTASSEMzM6LaNZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57697823"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="57697823"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 04:10:35 -0700
X-CSE-ConnectionGUID: KjuJbFVzSUGwMTKfqk17qg==
X-CSE-MsgGUID: GWBzR+pPRfu1bW4PPbmHRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="191514892"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2025 04:10:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 04:10:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 04:10:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.80) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 04:10:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf6rWe+VOEa1kUONRob7qeNG9C8VoJlCPxCUlXRCMTKu5yOhg8WD7A0NdFiM722yf6hAAVoon7JJp4B6SGVB9r8GR1deEF0VWErL4FZZKbMKfgroP6bjgeAtlxdwWlZA7S2Ggl8Ifz1QRkSun+BWqQz+oeW1mB7WR84uFcb+YgYXTo/jqSu9FZV8G+0T90S8PAnzWvbdY5QpDhbyFxOoYFm2HRN/MmYcPFMFiunUH5qvvZPQAo1ptm4q4ogl9SIzl+iIwRhEBmEYKyt9QGvFYI8lHk+q5e9cy3We1ZANwVsZzPm9rLoaL2wCzikkUoWPJr7n9I1CXC/eElM0TqGlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1MBvVfs0EFHlmHUr48A+CUrFKynh8cRsDLKPfDR+TY=;
 b=g2FBXiGtvLOC2Hhtl6TDVBiZODyQ+7pqNY3EtZszVYid7jqbIYEGueAGIf8fZEgg1as6+yEqh1AETh1thtnsKjMkkDADFCIc0SwE13pBynedOdmm7vSZZifdcl4elQ/w0LlqVxJNl7XoNNfm+7iaa91JHWXXzqOsKaKjEdSR//87RXiYAHajhK9ywZO2rcXpEM4MVmLfQFDWhdsgNQSHyghTJ3nqvpczFO27Ux9xJSv81eYhITi3GQRTdIFq8WsFHyf759Bt++yHcG8FL+SvTNwvrgbTfGHfz/Q0Badn+OOYFkwT8glY9qjOm9jDgH9+DUs6PKo0A4U3aCLxNvFjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:10:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 11:10:30 +0000
Date: Tue, 19 Aug 2025 12:10:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] build: remove obsolete compiler checks
Message-ID: <aKRboWGOkmZpp7zV@bricha3-mobl1.ger.corp.intel.com>
References: <20250718121402.856265-1-bruce.richardson@intel.com>
 <20250725160730.18354-1-bruce.richardson@intel.com>
 <CAJFAV8xObjjfq5zFce_kT_ZhsPhiXzixXEdT+G-Mi8OV77sssw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8xObjjfq5zFce_kT_ZhsPhiXzixXEdT+G-Mi8OV77sssw@mail.gmail.com>
X-ClientProxiedBy: DU2PR04CA0251.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: c278745b-7556-4304-a49d-08dddf110244
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2s5QmVzRi9wNzJIYWt0Z2dRTTRnVDNtYjBzOG9JcWZrd2FtQXp5bmtQRERW?=
 =?utf-8?B?ZWFOUXRJblI2djY0MzBwNjhmaHI0Wlc0dFV5bk5sTXZObXI0c1FkbVc4NkxC?=
 =?utf-8?B?NlVMd0ttclA2cjBvbDVtTlJwbitBM1ROU01vRGZjeUZRSW41UTZSUzdMd2xs?=
 =?utf-8?B?RFF6OWdYY25VTHpYNmo5Q3pLc2lsRTQ5NHBOWFpGUG8yWjNYa0pDdk5xUURI?=
 =?utf-8?B?WERWNnNkOXRvazlYdjAzUE5zZDFMZXhhQVg2MjU5ZmZxU3dJMW9OeDNuRDBJ?=
 =?utf-8?B?L2x5cjFyeHVKbzBHMkxRR29RTWw3ak8raFpKdEFXd3ZxRlNLK3AveXV0QVJ5?=
 =?utf-8?B?NDRmWk1rTXFxMW1jSTM3dDVhaXVlRDJ1dlcxV1ZUaEtlSldMWGlwdVFLOERX?=
 =?utf-8?B?YmxjU1JGWWtnemhCQ3Z1TFFrelZPTTcrbEZ0TU0zNU0wVEtiRm9RRkYwQmh0?=
 =?utf-8?B?OEwyZzNZUW45UDhsYWR2QmZpY1BEaG1McU1aZERwc3RyeFNSNXkxZ0ZoWHRO?=
 =?utf-8?B?bGFHRzZHWE1VQzJCSklENWV5dzJZOStWVk9mODBueVk2eXBSOVh6Rk15QnBr?=
 =?utf-8?B?SmVReWpzb0ZXN2FsWWdtdzNmTS82Y1J0eU1kOTlnUWlFRm02c1dKUC9CRkox?=
 =?utf-8?B?VWNTWlNtbjg4Y3R1bDBhZUdYc3ZoS216YmJpNE5Gd0ZWMVV1Y2lqY2xsdFJ3?=
 =?utf-8?B?Wk9MeHJWOXdBN3NBcmQ5ZTdLWlAyYWtDQWhrdGJWTWhwVEpWcjZMMUdOOVBZ?=
 =?utf-8?B?T0lUQnRVWWExQ2ZCQXhqRmcycFJtdjd6N2NDd3JTZ3ByY3JRM2pMZnplWXpF?=
 =?utf-8?B?UjRoN1JBWFlVUm5jZkVJSUlpckpSdDFnWkdSeitOblh5cUN5c1NPdk01RWRS?=
 =?utf-8?B?NjZTS3NnYlQrMjZsSEZMcjAwV0RGZndyOUZPaytDb1cxdmdLOFBaOHliRmQy?=
 =?utf-8?B?ZkpnUzlVMVlYMnBYNW1XWUpZY1h3UWhqTzVJSjh4UmFUSXBkN3NzRzExOWVz?=
 =?utf-8?B?bFRZSzhpZFdhSlV0VnU4Y2w3NVhiNzREQ1lReWlQc2xlbFg0OWl2dkltTi9r?=
 =?utf-8?B?SFRXZkU1NzFSaVNBeDR4b1hyNVV3OHVQemJDNFRtcndZSjVDUEl6VXRZZVQw?=
 =?utf-8?B?ZHB5dnBweVFBdlBaTWNDU3B3UHc4UDFBV2JxbVhXbDJBeThSZWR4SzRPcFpS?=
 =?utf-8?B?MnNENktqM2FFeS9aSWIyR25xV3BKRHMzbEROd01PY3FlL2VHdnNUR2lJeE9M?=
 =?utf-8?B?Y2QzT25hOFR3WmlIR011N2JUTmxPdjZwSWlnMUFTZHpsMmtRVVcrMGVWbUlS?=
 =?utf-8?B?Ny9oNS9xWHB1dGsza1kwaSt0TmFjVTMzL3d2V1E1clhJaFpJd2R5cHY2eko3?=
 =?utf-8?B?RGU4Y0t5My9BbEE2Z2VQVE1qaElQNHRtM0RBdkQ1VXVNSlcySEw4ditoK3li?=
 =?utf-8?B?QzBhcytuRGgxS1FtSEdJaTB0b0hVQXd5ZlRyQUJ0NlVhdzdnSzM1TFR3dTRh?=
 =?utf-8?B?dmNIQklYVjYyN0tiYTNNRjVxZlRaYnNsbnluRzZvUWd0VVZkVC9ZWGdScm1V?=
 =?utf-8?B?UWRTUFpZY0VYeDR2WFpocXVZZkxWR1FBWGtmdklqemIrbzB5SEJQS1RGRHpn?=
 =?utf-8?B?Y0pJbnVLcHIrTEZkeVZoWlVsblMySWxIcVFjbnBDaUxzY0xrZDVJWjFtNFdj?=
 =?utf-8?B?MGtOWkZrTUZmQk5nWEZ6VW1veTQrTUF2d083TmU2b0JMdjRjTW1WSDZEVGdC?=
 =?utf-8?B?ZWljdTNMR1BFbE9qMDZaY3RkaGpkVGp6TVZmOFpBS2R0NzFzUFpkckRkVzgz?=
 =?utf-8?B?ZkF2MkJwQ0dQVzFISGR3L3U2MFNlU2pnWkgxRnlyeUVCdC9lTjQ1YW10Z2dW?=
 =?utf-8?B?WU1ZR0tEays1SnRPTGxwbkJjUHpBcnptN01rL1Fmbi94V0xMOGZMNm5WUElx?=
 =?utf-8?Q?TxCpLtY7FEE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFQYi8xY1RvYTNqOC9pWFNqdGMvem1NMzNjcW1BWGQwckVlV1ZuK1NNcDRW?=
 =?utf-8?B?VGVTNnNnUU9OTU1EZmR6aWg5M3lnUUEydkJzcU1JaXl0aHJqR0VMVFQrNlNL?=
 =?utf-8?B?WnJpWlNxTlBXV0dRUzBiTTdZbWhOU3cwOHU1cXRtZmM1VUJzTnhEQ0lnM2xs?=
 =?utf-8?B?ZjhlVnRTUzMvQWt4b3dNK1BKbTlSdlBZdU9hblBKR3pMQVh2ZVEzcldDNjYr?=
 =?utf-8?B?bVJXMHoraXN5eUlmZCtsVjZ0Tm92cGFZeHJyY0xKZ1ZWSXY3Y1NLUFVnakN6?=
 =?utf-8?B?OCtzUm9GWGlxb3NOUmNORHF6L09tb0JHZFRsRzhFdE0rN29oVmFjM2xOclhS?=
 =?utf-8?B?SkhqMW9nM1BLR2s0UkVMSFNub3p3NWVLemxZbHoyM0kxSHhZWVVsNjhEZmsy?=
 =?utf-8?B?OU1JV3Q5L1RYTnVCaE1aNllwOVdudUJhNjM2UDJMNjhlR3A4ZE9jWVJ3SU42?=
 =?utf-8?B?TFZFelllVStSZFI1WURka3lrTlU4RWJhb1k1MEZ6WkhKNXVvWURoc1FlbDJS?=
 =?utf-8?B?VzJCYjJ6WGxLeFF2YWd2bEpGSDlSRThRSHFKbVlVazZ0dFNDMWJUWXdtN3o2?=
 =?utf-8?B?ckpFMTVwZ1ViRGFHdXlFNm43WVJGZkZzcG1Ub01yRzZ1NlBJVG1UQXpzaDBB?=
 =?utf-8?B?bVBLdzloWE5paTltVkZIY2t4MWpwY0prRjVKajJDWkUxYVRJY3dzSzg2cm9W?=
 =?utf-8?B?N20zbU5oQndvNEZvQXZNMisvSThzN3NpdVI5MmJOeWt4cityeE5Db1hOOGZ3?=
 =?utf-8?B?TDBIM1MxazZMNHVPU0h1UlRRaEM3UW1wQ3RLc3QyWWNUdG8vdmVzRUxxcDJX?=
 =?utf-8?B?L1k1U3hxbURJc1JJd3Bjb2UyVUN4aklLU3VkMkQzcjJOTTFaMld3b3ZNRUVQ?=
 =?utf-8?B?djRzbmhoWENkbjBMRFBnQzZUcUgrUG12aXJ0RG5yZ3FncU1nNWJScnhRaXZF?=
 =?utf-8?B?dUQzOVdPRFJHTDlzMGc1OWhWN0tTSkMrYWdyZGdwdzBFWnNGcm9KcXoyMzRG?=
 =?utf-8?B?amRGbWYrQnhVRXlzYnB0MVZoVWRPYWZOOFNINmZJdkpTdFlzV0hyVjBQMmRa?=
 =?utf-8?B?K0VHWmxLcmpINW8wNTAzMEoxTFc0bVU3ZkMwVWxLVlRRNjNxWFJyVTJNa1VY?=
 =?utf-8?B?T1E4OW10aXM3QTdJMkEyWWNBL2NNa1A4U1RGUWd1VURUODJLSTc1UytoQ1No?=
 =?utf-8?B?V2poelBlTWlqOEhtWmEyMjR2dURxeWZ3djJxK2s5clZ3N09sM1hla2JGVXZM?=
 =?utf-8?B?cVN1eU9HNFd6d3Z5S21xdVcyK1FhVitXb1dpVXNCOWJyRjFjbG9laXYwLy9n?=
 =?utf-8?B?czBNSW1oYnArRmFjYkRudnFHTXlteHR6dkZMZy9tSndQZ2E2VC9ZU0w0Qjhy?=
 =?utf-8?B?eWo3M25iM2ZQNUdlUE9MdFBhR2p1Z1ZvelRmRTU5d2lCWm9KbnFGbW9uY0U3?=
 =?utf-8?B?RW1EaFY4SVIzaGhxVytIbndIYjNHSml3SFo4MjA1SDU3VGV2T2lOc3VZcStO?=
 =?utf-8?B?bDdmS0pKb0hXUWRWS1lRaEUxTEpIclZLTStIamFpWFBPbFVPR21aY2hoSFFX?=
 =?utf-8?B?QTJVSnI3QmRmWUpKYlIrYytNQnNUTk9YTmZHQmdDU1RWNWk0L0NucFBPd21F?=
 =?utf-8?B?VTRyQW1zZ1JtL0tWbDE0SnpDL2ZrbUpKRmVQYlROQ2hVRE5sM2RWSjdwV21Z?=
 =?utf-8?B?d3VQZWsxOE84enZHajBDYlpJaTZVRmQwQTYrZkR6OG1Ha2RHVkU4THQ5ZjFs?=
 =?utf-8?B?WjdFVjdiK3RVOE8ydlNvM21NS2dBMVFlWWlTL0UyYTZTTWRlb0djbVpCeWtj?=
 =?utf-8?B?Z2hoM1FBSkc1MEo3eWxRdXJTRHNGQVhHTXh6RVhwMzdIQ05mcUU2NzlJenFk?=
 =?utf-8?B?Z1k0cXJpdEFicWxpNHR3ZXh5cjU4STdmaS9yM1dCRGMwWUtCTmxKUDR5ZzZI?=
 =?utf-8?B?eWlhU2FpeUloUnpjVy92UXRGZUxhTUZFN3BIUTdmVWJ0UFE4dEtWZEo2cUxj?=
 =?utf-8?B?TE5lNlI2Z3VYaThtZ3ZNNllSRE16bEsycGsrQnE5Q21xMjZwNWZ1QXd2a0NK?=
 =?utf-8?B?TTVQMTJVYlNpZHVQYnVOOFBNUUZMRlk0aGFNQW9zNUtzUTBNZTM4NUZIanVP?=
 =?utf-8?B?cmN6VkV1d08wQi9KTStVWUtNOVljNWh1L2dTUlFPYUhYVkNZS0RkMVpjdGcx?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c278745b-7556-4304-a49d-08dddf110244
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:10:30.4051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ApAUKs4bl+4Nn5TyPhfYWXhOGR/01gNiCdkLDKQq+N80D2weGMlDQ6gY3wFwz2gCr9jizsLqpgd1Mn0DCQFlsRzOMn93PN0D58WyYOQ77Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
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

On Tue, Aug 19, 2025 at 10:10:21AM +0200, David Marchand wrote:
> Hello Bruce,
> 
> On Fri, Jul 25, 2025 at 6:07 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
> > index d3caa3a3b4..a9ff87e863 100644
> > --- a/drivers/net/virtio/meson.build
> > +++ b/drivers/net/virtio/meson.build
> > @@ -31,7 +31,7 @@ if arch_subdir == 'x86'
> >          sources_avx512 += files('virtio_rxtx_packed.c')
> >          if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
> >              cflags += '-DVIRTIO_GCC_UNROLL_PRAGMA'
> > -        elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
> > +        elif (toolchain == 'clang')
> >              cflags += '-DVIRTIO_CLANG_UNROLL_PRAGMA'
> >          endif
> >      endif
> 
> [snip]
> 
> > diff --git a/lib/vhost/meson.build b/lib/vhost/meson.build
> > index 9c6325aa0e..a74d0cff7c 100644
> > --- a/lib/vhost/meson.build
> > +++ b/lib/vhost/meson.build
> > @@ -8,9 +8,9 @@ endif
> >  if has_libnuma
> >      dpdk_conf.set10('RTE_LIBRTE_VHOST_NUMA', true)
> >  endif
> > -if (toolchain == 'gcc' and cc.version().version_compare('>=8.3.0'))
> > +if (toolchain == 'gcc')
> >      cflags += '-DVHOST_GCC_UNROLL_PRAGMA'
> > -elif (toolchain == 'clang' and cc.version().version_compare('>=3.7.0'))
> > +elif (toolchain == 'clang')
> >      cflags += '-DVHOST_CLANG_UNROLL_PRAGMA'
> >  endif
> >  dpdk_conf.set('RTE_LIBRTE_VHOST_POSTCOPY', cc.has_header('linux/userfaultfd.h'))
> 
> Sorry, I did not notice in the v1, but lib/vhost and
> drivers/net/virtio have the same construct, yet only lib/vhost gets
> updated on the gcc version check in this patch.
> Is this intentional?
> 
> Since GCC 8.0+ is recommended, I would keep the version check in both
> vhost and net/virtio.
> 

Checking quickly with Godbolt, the pragma seems to be recognised by GCC 8.1
in the same way as with GCC 8.3. Therefore removing the version check looks
the correct option to me.

However, a better cleanup is to remove these defines from the meson.build
file completely, and instead just check for GCC and clang directly in the
header file.

/Bruce
