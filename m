Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A762C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 08:29:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A9AE40668;
	Tue, 29 Jul 2025 10:29:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6988C40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 10:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753777747; x=1785313747;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NkpDHDwgWjyLqgNsiZX7dfFQjnpuzeSg6LZsXD+nCj4=;
 b=eRca9bxubxU779XVNXQMwdwbK7+VZHrUq6U0rfmoneZ1Jbjl+4r4i7l4
 usPrth81zwdkYlCLhjaMnIR5XHWYVuoGMuFCqonjRUqWBfzCIUsI4T5BJ
 BDrXC9s+zHir0hKRvdhyPe4UvVpXSEfypF9D6AWMeEPwjxzR6LYYsFGqz
 hZT48sh0/8NRtORXW+UDDde/iZmMpoAQuy8mhO7y5Uyv6QuoXzlGm7M8B
 0QB5r9Av26zzdmNdNViIsPYJ90qDwKC+O3mC+R+NANxgzioAgVH2g3l9s
 WaCTdi8MkIncR/Se07VCebK3qvUQbGaKIlx7YHavG8YM8jO/F7NhQ74Tu g==;
X-CSE-ConnectionGUID: VxE3h3aNRwqQQDjhRJsYYQ==
X-CSE-MsgGUID: Kg0sJJGHQgKVdYMCXTHltg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67123150"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="67123150"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 01:29:01 -0700
X-CSE-ConnectionGUID: 3Awqe0niQaO24wwnhK+9fA==
X-CSE-MsgGUID: PJZW7jK2T6e5ub+lk/25fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="163420779"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 01:29:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 01:28:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 01:28:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.63)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 01:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y38nuopieiXaJWV9pBAhZ6W8/YsRdJ9vfwM81sabWh/Ry5bzS6RqcgBBQVZrqjb9Q4RVYzQIV5aFj5ooegrmUrvqv1q2vj+GvyNY4s82wxsBmg+29hnxSIRPwyomWjRe9vyKQIdJwsOY4zT+i8P0Bx6CFrfY9Eo9w7trzFfW95IbS+sa128wvKiWp7vHFR6sqs2lFqXl6ssRaiYqZcZdYjSWxmV5vDkHeHhyhgFgjieKGJ6QxH3HfQOecnZKute+kOB2KS7Yep0jjF52sPayMOO29ddG2sjPm9g/PmhAytU43etGwUqi+IRsykmQ6RuHkjPwicMm6ImVQDE/VNYE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwIUJER58439R2QAFnYTD5t76PI9HeM9iAnUSq46/HE=;
 b=UZXgimIrx9ugKxgh2dgEPszgMTKH1ZzNit7GoAxurDM3YB2Gp9TrP7l2u1fh0Xi2RrKI8NZ4KUqJJLO4zd34E2cVSiJg+ue6yjxvBYG4bnT6cY3/jTktl6J5U667q/Pd1RA90+2v0cfTk0jjOHTnfTa6Mopk7yp1VoOehgs+KO2GFn18a9QsBonQSf52iQN1mSaSCawB98ZLTudbu/tv810IVBPjP/BG645/frYJi2WZno6c8owRw9Q/3Y7k6KjQ870cRFu7ULip9DCyzU2vtah3Kk+HvfkXThwWWsnIFjhHakZZUhK+y0tXvCp9F4c1+AZrw9JkgCQXwx/4ThZ4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 08:28:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 08:28:43 +0000
Date: Tue, 29 Jul 2025 09:28:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] app/testpmd: add flag to enable RSS for single-queue
Message-ID: <aIiGN_gi97Q9MGkB@bricha3-mobl1.ger.corp.intel.com>
References: <20250715125330.2127309-1-bruce.richardson@intel.com>
 <20250728211919.75320c85@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250728211919.75320c85@hermes.local>
X-ClientProxiedBy: DB3PR08CA0001.eurprd08.prod.outlook.com (2603:10a6:8::14)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fe209f-406b-48bd-7236-08ddce79ede7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p9RfqxddJYQPY7Fs0/NuCl8nTeB3hUGVRECqtMWvC3yuqbLJUBKLJgILAdUI?=
 =?us-ascii?Q?AkW/jRL/qihwJ9jD0pIdl/INVmc4EGk3FYJDJaHt27ZzeLMZT6PsGIHgEXX1?=
 =?us-ascii?Q?cjcoa6hdchaIW0mW1NE/ygP4iMTavQSd9Yic2Lo7rRupti4ytvdAH60bR+sR?=
 =?us-ascii?Q?jZTLoRP6lo6ZnPtXb2SriIOjE4AocqQyuKc3CmhBXpvwlxRGx/OrPtW4ob07?=
 =?us-ascii?Q?BEQXlebczYMjJE9rKGU0pPBfc6pIp5WfVvqCleqWr9m82RhBYj83LMgxi5B6?=
 =?us-ascii?Q?yCjIpr6BnMzOhv9p2aDfU09vCmCF2mZJSiQJAepC57R/Dmxtky8Z1zX4VhdR?=
 =?us-ascii?Q?IpPdmcPMDEsVSLGSna+j/2WlHtxMxyr7HT5Z72Nyl5pMSHY46FeXjwF+KKtg?=
 =?us-ascii?Q?t9w5C//okOsL0y5LRwxmRoPgbBFZrBypGjZN0ThyDTQTTcz/SjpysFmEdMD1?=
 =?us-ascii?Q?i1Tvjpp8jAllCDmyGIAvlhmwQ6fDYn8tF4bciVNjUHT7iMZBf5XV+rstG6Xv?=
 =?us-ascii?Q?qTnArFietRCZvrKZlmnormn+1qjm7xu+m6lHNv/JQc0gqyjC3yFt3QcIrwOt?=
 =?us-ascii?Q?ibluvcNHi05uEdF+r832aVmSP2pcpwrwt1P9rOhv/QzJsWwuxFiduHrXGDI6?=
 =?us-ascii?Q?1jOeNjfBFlDRZ/GJhLWp33VfVwIGSfQRBePYyezkqfRaRU4xtnYsRmWwBUWX?=
 =?us-ascii?Q?Ye+hgFgFvmdHqKJUIe0MZ8Ww6Mnv+ODUYCYG95e6VKaLfe0vE+MlX4UmqvBh?=
 =?us-ascii?Q?VJ0j6s3xyT2VIUJweg2C2yCSM1noK/a55TY4nyxoq+Q4LMLzfOD7j1thbKAx?=
 =?us-ascii?Q?0mg7gEgjdNH+BErC/3xcrELO7Ya+dScPs1mQrJeR7ASYbJLfxgr5LuDEybg5?=
 =?us-ascii?Q?WmVh7ZHJ5K68BWpcFWDm8hzrSo6KyWU3ucgydm7/HEcc40lXCF/NDwptxn3z?=
 =?us-ascii?Q?ogHZNEGrRa//ZN+P+tCFFTz/xvAxYoYZvns4zVb4bnHdwHwmdr1r8WL6RmMX?=
 =?us-ascii?Q?OO5n4n/jFh+DUAyyPhCQHZpIqhBuAM0iYW9I3uQYslgxkjjw578ITAdbWUaC?=
 =?us-ascii?Q?0mZuiLI1x8QwmRanGbLc0Owl3xtCPfb537KfCmDfxzQEj1BEcdZmRIQF0L7E?=
 =?us-ascii?Q?m4JmQGc8NHynHdcfmwgOd1GZyNQA+id/RZScWCkMh30LyEyNl57iuaL0fa4B?=
 =?us-ascii?Q?vSqk91HgfH7dyn5AmJov5Ya+SMdEB/oNzDtMVMNI1osWSlNVLzBMuEfiBryT?=
 =?us-ascii?Q?KzAFiS0ZRl5WhImWmf5e5d3JBZx2/inF7afcNNtEpNq2OO/kJIjJ5MYBP6Nd?=
 =?us-ascii?Q?rGYeeaKXQRgzwHFATBppO12ISKkWoPUmusBEepC5PawZy9xBNc5U9J7yQH7s?=
 =?us-ascii?Q?1jSgZJAA8ub7WTi4AiVwqV9Ed7FOqQpg7r//XQmR65sUfdrkKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+f5vDZHwa6cfN9dB2H71dnIiUeT2028PLFxZ63Ba5Cmf880ayCtJC2TO7R2/?=
 =?us-ascii?Q?8aWkn/k34r+grCr2PYim6XF5Yg6TEPkbxGhOv5zBBAh9YOx2M78U76dkRciJ?=
 =?us-ascii?Q?13Td6kGbYg2rrkGjB8enue2FULX9J+KFmEg2m8Dut6TrQWKz3AwcW+kFl16V?=
 =?us-ascii?Q?HnE9pdA1mwQViiV/RyJlFbgXCE36lBABOvyJ084pXyAbWFvuEU5IvrImZbWZ?=
 =?us-ascii?Q?QBOcld1RS5k0uAbP9tFi9LnM42wf3ZA3nz3xQvoQGC1XupZRgk9o+ZB1DMS/?=
 =?us-ascii?Q?hk127V3opbz3sRl10LDM5Mw0jB2pzWqnNJ0rt2yrf+ZuMYzxm0Qc/ad9vKJ0?=
 =?us-ascii?Q?E/QM2k0NRvxrrMQvuY0W/zzmasQgrGgBb1Cetrk8PHK6jJ5dtOTsxWyIjpgN?=
 =?us-ascii?Q?mEsFr4AKF3BsVxzOhrphmEhgrzEJO9DK0HziBpFakIk4lU7fkh/Bjf2sM6rv?=
 =?us-ascii?Q?oKhrWpFUk794k8mgeHe4tKJmDV4q5U0Iy7F2/BjS19TRMRH+kjutsmTajvBz?=
 =?us-ascii?Q?B39uvuy5kqDBPvtFcVHbDCoDtkaoSO9dsYeZ6t1Y8MOuwyM1+WWak3Vx0Zvo?=
 =?us-ascii?Q?xpOvRFW4esi8zWbNHfz2BuSWkdtzmz+plpcigfruEvTvB/Tba5zzZCG3FAVQ?=
 =?us-ascii?Q?4bNENw1wO5wlnEksHWQ+TkZZtYvDv/IvMhAeypiywbaxKCvRlcijKQzTYXXD?=
 =?us-ascii?Q?EQSecPK4SCddY/pm6MnXXn8bsvgbKv0tE3uij4T30Q/RDfWyYhqsJJh4tAUq?=
 =?us-ascii?Q?KonHE4fQMKzW0Vy8ifvaEOAMVVwVcQcwEwpEzcHT2Nq+nlYDI803ETGhmn5X?=
 =?us-ascii?Q?jagqZjVhIz0k5hGY5Vb1JYSYy/Ep2e2PrRvcZzOwyifzdzcmrOetqSkAimNX?=
 =?us-ascii?Q?wq/bWGVBajnbIWMgCeWKb6KgEl6gGo1tIWzhEDSHwHzyoygdQaJZqxY9VhFv?=
 =?us-ascii?Q?nec+zr05iQMR/UP//0O0Mq4PhFa74uuQahk02gEWMyk2OI7/F2iU2I5HsGvi?=
 =?us-ascii?Q?7nsbsEcdCsRnf8fiREmoRUliz15C7FFteU78+XXK9hJlc4zM4BHPkHLexzjm?=
 =?us-ascii?Q?HRd3wJnq/ZZUYImdCGJAAiRUrR+hBevx01Trxt7FOMYBF6fiEd2Jh6hKeR7d?=
 =?us-ascii?Q?ATnUXhA5PoQoAtcKskPJz10UJuE7L5C3fJ6qVc8jYCvbSDWop7RdBJfO6eOw?=
 =?us-ascii?Q?gRUNNm+RRVQXY8iwM2RAj50EKnrIcZdcf2JZ4dsEOkIjg/9I5M4lZE8lNSfs?=
 =?us-ascii?Q?SHyTvk2mmz9CgtQQnYQe7upXOdv+r9gTma8x3FJv2ZaSRS1Vo/VcU2ll1BUo?=
 =?us-ascii?Q?8JTd0KR+cDcpSDEAq97eghc1pNNYZleb0fvX+tT0vxAx99xU0q2Qi7Kob7g0?=
 =?us-ascii?Q?u9Kx7M+s+dpX6MX6Tz8Jo+BQaRbvZv3h60RN/wAqRvamjbTSF16fGZDqRnN7?=
 =?us-ascii?Q?yF0VNQlgAIXiz+37lkvQdKrGgRysNuDlghjnfNF/VyHI9y/PeeEQuhQ5zboX?=
 =?us-ascii?Q?BjK6G5AzB8YJtUoN3aWUgE3AzWCeyc0MD74Fu4ekIoXrpjfPMng8Swa56MSo?=
 =?us-ascii?Q?1UpGXt1l2CGFCcpx1HHxVmx1IFAGdFB/BZyvdinQqIVudsxhprW5UZyE3ryl?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fe209f-406b-48bd-7236-08ddce79ede7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 08:28:43.5349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWN2wgNniuisicq7pv4qCb7JdFvOQ8wvzOZRbh5O/iLlgFRkKJt/xZWFMBxXAFL6x/Br032EQbzsfkMT3oaUBul2uQYIUv8hk4AWFp/H1B4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
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

On Mon, Jul 28, 2025 at 09:19:19PM -0700, Stephen Hemminger wrote:
> On Tue, 15 Jul 2025 12:53:30 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > For testing purposes it can be desirable to enable RSS even when only a
> > single queue per port is in use. Add an "enable-rss" flag to testpmd to
> > match the existing "disable-rss" flag.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Applied to next-net.
> Does it need release note? or other documentation changes?

I don't consider it a big enough change to need release note. Just the
testpmd doc command-line guide is enough - a patch which I will now do up
and send because I see I forgot that in this patch. :-(
