Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB45C7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 09:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD1D4026D;
	Fri, 27 Jun 2025 11:53:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 4B24B4025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 11:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751018023; x=1782554023;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=H7gJfu3Ayq3vyCRPkb/v2GHdnbiUqVEt9uSOVic7Z+U=;
 b=YNUm8l7/AmSd8qVEjjEYOtnHwkQWFGop9U7lQGUUBygKOIcvKNsy2rZC
 rUW4nN01YEnDt8JN3kGl5UfJDqOk+V+WjHSD9IM8rGdyuyTfBGDTzEZNb
 D1UJL5btSk0sjrbxUJyi3E54jBuEGjXjm1oT9EX7EY6/ocCN6TtI9lw6T
 yi1lNrJv2vznT4OdlTm+8s0tqMpBbdJtoenntS+rv6lwOwIcp9FTxllD6
 xLz1lg0VbLFQVmA/scFkcSB2ZpNtacC38uRyhjT1xrFDkdj01mJZiZ0ud
 NHPo8gqzqVZLwKxjl4f3XAD2uYdWVJ884nZK5L0iXnpwEIPd850MrFlEU A==;
X-CSE-ConnectionGUID: sa53e2+FRPmXBosDBvHquQ==
X-CSE-MsgGUID: A5yoowzbTqiWATm9VkcI6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53476540"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="53476540"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:53:42 -0700
X-CSE-ConnectionGUID: 4ueIa/1aRRCLhAvdAMOojg==
X-CSE-MsgGUID: V1Q8stFjTAyCoZ7S0oetxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; d="scan'208";a="152380446"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2025 02:53:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 02:53:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 27 Jun 2025 02:53:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 27 Jun 2025 02:53:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRmS8+cukQfXHl/k9sTTCeOe9A2ebvfS86BAyGuUW+z/oWRUh6T7eqY09DrD1YOFokf7/pcGjEaQERgHkkfoeLrbGzOMZRIPMxPMS7pPrVfMDFWDwhVsgiDdypHjTaxuIyRwnLfkHAuOTYq5mcnCjTt/Xqczp/G9dw0LV/7OkyPALAvGyqrmQHxZ9BCCf2SGJyofOua0g39gqd+IZkaeN/JLEmgdX7BRtpFFSmWBuamyM9jBehT5uQcBysnSgwYBe4EsVNki/WH2yhw+ZU075cZkamWB/iNrtFta/wGhgWJ67oYc0wUiIYAuzgQsPykOrHaZCR0vfcUIMmsj4Tbevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrPaP4nlEV0n1xoChu7IWTxJEvY3Fv9yquZlHEb97VA=;
 b=Jmvkf3TnUceLARCYaBALJskWtqXnsB+9sRJ8CD9OJFKS2BwzqPZHLVw77ClNf8gLjWjrrAoQYPmHLi/KFqo5jgHfno8NXPf4kJzh1LVtdkT2F1wmbOowZJasoMYzLZQYWBsv0bgX4B0FiRo/pbF7NN0YmSjLOt4Zc8OrF2ALax0WztLLmmvUtUO2631vVXOdOl76znbtLvNh1/k9g0uH5ka5GM3n65gnXpHJF1tZkh7LZblpmSdDD40i4K0LtGN6ZuxyRPRnFcZDEWhZzbLlNETddYxg0TLIrVv5PaQPcdv2WlXa9SH1dlZk1cpAM2o3yarpTfRDSEkxK8QnzXywhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 27 Jun
 2025 09:53:26 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 09:53:26 +0000
Date: Fri, 27 Jun 2025 10:53:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH 0/3] argparse: improve handling of multi-instance args
Message-ID: <aF5qECJgWupF4Er7@bricha3-mobl1.ger.corp.intel.com>
References: <20250616104944.3425929-1-bruce.richardson@intel.com>
 <aFUfX05kEUNz5k2S@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aFUfX05kEUNz5k2S@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZP191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a79cdd-a709-4a36-00ca-08ddb5607603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jw2mfF/z2819RRr2mjlRtSDBOwOCiL6vhuin8wemHd3yPlp/FQlf3+L5vTaU?=
 =?us-ascii?Q?NMgfHTZynA4PHQA384KkR9/SLkOnRFelELq8RPQMhYO98e3GAOlZPKXU9g2B?=
 =?us-ascii?Q?2iKh5nDo1SmSGufHGacJ27HHCSDGG66qNl0FVCDF2iO/p6T2ekNQoaXyPYml?=
 =?us-ascii?Q?Fa2m3F+3iCCJLKfUD5KTmX3awmQke7PuiZIYWuv6bTP7/b7tFEDhqaKbWeGU?=
 =?us-ascii?Q?fNlZKvDzPQwNkjqQXZbWBB6OvUFPvDdOIHI80QXnysT8yVkcN5vqm0OpN2L5?=
 =?us-ascii?Q?mUTJoJsS32cxdby00QDaWuMq3vZr9lziTDkd4p1DsDK0Et3bqihABFo/rHyR?=
 =?us-ascii?Q?64pJrPqXIBIs+VvijgsVlZU6BQtKYCA7qlIu1KSogFxSWcrA8iqEQAFsR+7s?=
 =?us-ascii?Q?cTA8oGiAblehzM1PZqqyQ2LHfIshGGv5Zz0dzhJegTZP1k/XyPNOnFzpGRGm?=
 =?us-ascii?Q?ee8idW3xFkUdQu2hepOzSqk2Aa8VhmuYqp2Ga/Se6xZbeXdvNz/7F0zlyyqE?=
 =?us-ascii?Q?DtaYeH2Q3DQUh1OUKDDzAKfF0XloimKd7EXG26ta4DuSD83UIbL4vLlaeVsN?=
 =?us-ascii?Q?Kne8K1ulFxnZPt5C9vndofuTRZh1TRK0KtdBaD2RLXvKAnQSOMyZ6vk7S4gI?=
 =?us-ascii?Q?Hjc43jsG/NGi/ChOsD76N4tcNWqYMgVyc9p73tJ1fiKrGaBFrXuszAuhRy2X?=
 =?us-ascii?Q?B3XlPa8wo97AqI+n0Z0jn6Z6MMxWCSPheJkoHnLrbBFL1QHSrMU6CO4z1dGz?=
 =?us-ascii?Q?idxQSP1yqEBYPkar8wr+bYlHiIXLEsh63txFV+qnEKZJM7wC23z5Fo6R+Ixm?=
 =?us-ascii?Q?YoksIyowO8vwyewypypzapXloreSMBObQZguyUQvLEiJh3FfnsTOONw3aqw3?=
 =?us-ascii?Q?L2wq2bBRh0+UQp8xXcUovUe/XtXhdqmv4lTiqX9PQXsFQC6iuZppX87iftdf?=
 =?us-ascii?Q?kkHoZ1IjpNtjJ9w5tk3fw+vxxS86ehFT7BnJHY25L+aaxcjTMmkgBvUmiv8B?=
 =?us-ascii?Q?VSTFBcrgdCG+gH/sewi10jShDkNCZXOZbRHGdRewQv4ked5gLGZMsY6B/GLU?=
 =?us-ascii?Q?AQikIR+wbPVv2flcpoPf9hCLatjtMfpbPDoCmgtr5dd7IdFFLFoCfQL/V03D?=
 =?us-ascii?Q?AVbmIUif22ou3VWmbG8MXLNg7QhhYaKoDfajevFRHo7nNtXxDDzBa61ToqDx?=
 =?us-ascii?Q?1MYmEYV9K+jF76eTc1mtXe7eUdzF9IeE7J2MaMAaZAsfenHxdXkCCP7wLpGC?=
 =?us-ascii?Q?zSosoYEFw5HUqLKY0rONYf2NzWy7KPqgwIPa3OZxEbQy1ICRfEAU0fXagr8C?=
 =?us-ascii?Q?mU9oUSGH7iILTaIMyxvuVXpckZadtmDTkJgqL0lUa8zoFQcS+18evOWncSv1?=
 =?us-ascii?Q?EPpGBspCm0eXwdsPhCW/TJPhMywCgnfPibup4mCzPoONJqeitgL3jHPmyFut?=
 =?us-ascii?Q?7ESFIMxZUDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JH/ukXk/3KSA6UBYAynPiu4imjNYTUz4afTElpznDqV84xVG3bqddVx2H2Ut?=
 =?us-ascii?Q?DWSq1Xdur3px+kamYOzon+U537STVa1oomG/J1ghO+AUVpWWq9yPBGZ3C4ZH?=
 =?us-ascii?Q?f2xCKYps+P9p1enWG9/gX+WZFiRU5UDI1ey43gQ2jLpkfatwKxtIH+Z+pMw6?=
 =?us-ascii?Q?BqfNmpha7J3ygSh1fGhtDlUgShesQ2yOIEwQyWJ5sCc8xWhbsBrsTOSR5+wN?=
 =?us-ascii?Q?19UnP/P96waBdvHryLzoxA6WWPD6cwJ7Q0H+F6QoICWhFcc7ox/P98YDEQsf?=
 =?us-ascii?Q?bKA4G8wVx2PjPDQ/K6ZDkv1VE96cVmaBq1GMfhqezfsjTA22OXWJoPtD/6aB?=
 =?us-ascii?Q?iDYHiF6/f+ugsTJiirmdRpCM/JU0gCH4ZRd8ucKQkC9zvsKLebZ7cyM41hFz?=
 =?us-ascii?Q?DjAZMcP18g/BYX3BfTry5mvY+JLWrF9qFTMX4kGIQxRBsJIUgFh3RqdXfF0g?=
 =?us-ascii?Q?iJef+KfXC5rDAYkzzrYoQI5M4R+SIwLtpJGgtiwcOxRyhVO2rWbh6Lx43IsU?=
 =?us-ascii?Q?wD6Y7TFVC1nRhdHAv1Tos3v6KaBFCDnXgHgsbFPuHSB6VPrSnNu/K321wyN9?=
 =?us-ascii?Q?/iLWl75pt6TMhCBQLPSwWYKRq4LNwo0ZAFDh/+tYFcGRBhB3Bw3LpHOFR2E3?=
 =?us-ascii?Q?lZAtSUlszqJqzSt2OVTut0cbau/uT0yW2JCdoLA54qRyZCH4sHh0nWbxJtJD?=
 =?us-ascii?Q?f24UoqsjJpdV5JHdMc17+pcwjGMHHDkXdbtM6dCIf8i0e1Tq8Jib6zkxs4LH?=
 =?us-ascii?Q?FyH37DdH6Ab7Aij4QkbWFehISsBcIok5M5b3yg4AM46OKp211EnacSL52J3u?=
 =?us-ascii?Q?ri85rE9pRS0HR/QFmdX/0jb9KDPSYPTH711YhXVBw4w+TuOo5W0A+OG+Wbro?=
 =?us-ascii?Q?Y+UvPSF4c5r16SCE9hjl6Jf/dT4BLA6vgFse3ieezVwzMTGoVsEz+Fxgg+Q0?=
 =?us-ascii?Q?QYiltONutmKYxMULehMpPWAC5uXRV5YgLd3wtvm4Bne9n4IBVcfcK5KXap14?=
 =?us-ascii?Q?c3IGQ4X/4OpPd0T/e5iYqhHLDHQJD1SieUonNn85DfielZzN6oEug6d2Mgk2?=
 =?us-ascii?Q?T0jhluSixsU3pJFIRXqWD8FJ/JLsyoILOGcogSNthkyTSMTr4PTS5QU4ibUT?=
 =?us-ascii?Q?bEDi7xrVuBtWbsjMEfB/FObPqZ+OhlVIhmQvD7JltFD4mD28ga5ZKOhZRDgs?=
 =?us-ascii?Q?xH4xzw+9ha9RTUzZ773z5Wo9/CPaVfbmtT9fqRNSV0hwHjIQUHZ7shtcS5HA?=
 =?us-ascii?Q?Ki1pMFnOUNeGRDlFhuGVcfBgBTCifHVqcpuC73F3kb+WsIEurSknNHLX4NdQ?=
 =?us-ascii?Q?QZENzkPEBLFAPWnYYYWdDEIzOfdbTI1OtKmZKhHP0Su/3PWHntJ+oVq9/9aL?=
 =?us-ascii?Q?QdI/9B6ieEdQtNgNU+jNGg0wI/Lye0IB8XmmiMzRdAKtjOpCvnjk+2cQ3esf?=
 =?us-ascii?Q?ln3SkQU9zkZPJ0GBPs1YblMD4po3OgNDuOmx6se0fQ6HcOPl8j+c8pYubGdq?=
 =?us-ascii?Q?yiIlC36xirCmKkCtuiyP1kgr6jQS6IAyP3SLDFQmw+qYALQvuYBGXU9SNQqy?=
 =?us-ascii?Q?qi3ty4tNjFyOudYjUJMBLqWZVeN7cALCkZzkuCFj4uuzFwrP+ekD/JfKF0Pu?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a79cdd-a709-4a36-00ca-08ddb5607603
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:53:26.0812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+8HR1QuvrQSlPa6dIutOo8xpyK37RuE5IeD6788mHZcoKz65+ig3Ec1Ul0NeLDYS7BiCnpzVvz+14nML7uJeCoMx51XfBwd8K0gWhoicOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
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

On Fri, Jun 20, 2025 at 09:44:15AM +0100, Bruce Richardson wrote:
> On Mon, Jun 16, 2025 at 11:49:40AM +0100, Bruce Richardson wrote:
> > Coverity (correctly) identified an issue[1] where, after the recent
> > rework[2], the internal flag, used by argparse to track what arguments
> > were previously encountered or not, was out of range for the type and no
> > longer having any effect. Fixing this flag to be back into range then,
> > somewhat surprisingly, caused a number of unit test failures to occur.
> > 
> > The reason for these failures is that the tracking of args encountered
> > is done via setting an internal flag on the user-passed arguments
> > object. In the unit tests, this caused issues where the flags field was
> > not getting properly reset between calls to the parse operation. [This
> > is only an issue after the rework, because previously information like
> > param type and optionality was encoded in the flags, so they were more
> > often reset during testing].
> > 
> > Rather than fixing the tests directly to always reset the flags, which
> > is simply working around the issue IMHO, this patchset instead fixes the
> > issue in a more user-friendly way by changing the library to never
> > modify the user-passed structure - making it completely safe to reuse
> > across multiple calls. This is done in the first two patches.
> > 
> > The final, third patch, adds an additional unit test to check that the
> > tracking of flags being seen or not, and the handling of the
> > "RTE_ARGPARSE_FLAG_SUPPORT_MULTI" flag is correct. This closes a gap in
> > testing, since the original issue of the flag being out-of-range should
> > have been caught in testing, rather than having to rely on coverity.
> > 
> > [1] Coverity Issue: 470190
> > [2] https://github.com/DPDK/dpdk/commit/04acc21beeeb78477b15a3f497d3628fd70a6a9f
> > 
> > Bruce Richardson (3):
> >   argparse: track parsed arguments internally
> >   argparse: mark parameter struct as const
> >   test/argparse: add test for repeated arguments
> > 
> Hi Chengwen,
> 
> ping for review. I think this bug should be fixed for RC2.
> 

Second ping! This patchset (indirectly) fixes an issue in the library, so
should be included in the release. Can you please review?

Thanks,
/Bruce
