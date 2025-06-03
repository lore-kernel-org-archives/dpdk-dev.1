Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7023C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF5840E64;
	Tue,  3 Jun 2025 18:10:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0AC0C40E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:09:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966999; x=1780502999;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=8jcoveH7xHW/qPlSIa43pYKataiyH5vxSpfhR9wzbuI=;
 b=H2IwdNEyuuJUaS1BbY3dQ2oPfTNtml+HshkFlCHJa7AgwgB/s49iqIAU
 t/MqSjktz0zsLLUdBFTWEPkxFHQC9H3XA+Hk87AEejEKajftAXnwFDi8Z
 OgOjUbgNv8Z9SIZo5jWs8NjQ4q6BMRuM/FTv47FOQ37ZEPYR1q0ljJLx8
 uXo1E7aZMNfvn8esQcjCAP/zYxVkPk1lrt+hyxjVwQzKbSiuJ0BWIfGmK
 mEE8c9c7WodPdbKUMDQlpbf4wLqOQ1CLkvMtaW1B3ZeXoM/8QCvBaxSfK
 ULvrFPQ2RmbHUvqoYYIGHZv4wOzREHhfTMdCdjpD++0rTaTW5w/U72iYW Q==;
X-CSE-ConnectionGUID: +hEcDLC8SPWPmAEoi7a83A==
X-CSE-MsgGUID: zDElMWxvQtGpw6jZmGee/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68451368"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68451368"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:09:37 -0700
X-CSE-ConnectionGUID: SE2WanJoT4yOFTKAow+UOQ==
X-CSE-MsgGUID: 1wQMRZM8So+qGNQ8+lLLMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="144778762"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:09:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:09:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:09:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.79)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeqU5agOCBo0asoZx2JosmDQ1fosFPmjnb1fqdmhSc1bO2FDc4EqrZntpVAtCqDo5AtEgzV4xLRqFW5aoANW4jQIVe8BQ9QAo+pPXGq5t6guoMYyHFIzQrIwyQlxZDo8As62dCo1nM501nyj4V0sKNfh8KWJ4K2yMHlWo2BBJM58jFB6+oRhxO6XZNh9AgfnaOVpoNmpMODf2niA4smiXgMFmB09kPj4xXh7elqqGOFX735YpZyevuGuA1QQAA4HLyLyBLFkf4g+4mN5BUI5UC7g38cI4loKFnaT2/PPMyUsjyYdBZdrSJrRZTGcCywRir+l2/Q63YuGo7htf8h0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM8PJZ3TtVsmtMH4QksU2E4mGXSSmTrUqF0s6bSjQG4=;
 b=kSA3XoK9glx1ido0zdASbhvuklFD19+SnftyHdDLNk70iew4TxueiwXRZGIj/kOf+7zegI6jwKl5FT9OM8tCcDhJYInVpLsTVq94Bsjhn3udahIW2uTF2SzntNkGL+00Yj2DTTd3El0xbUxVfXKRDkLyO7gkxD9WjhHIr8BYk2jIu9iNRaAf4AUr5RxGenfqlnqR7W0kM5c6ymdgyy0pqgUv6hi9T+EMqL0EaNATLv1dm0q3GfqUDeZDXMcY5tgw8e9UZgGOOZcV4rGHe1wkm79QZRrZPxh0CyC1g2sq9uPkF9ulYo7fXyZfvgFHHcruTBXNZ36XR/WURWwMINUtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 16:09:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:09:31 +0000
Date: Tue, 3 Jun 2025 17:09:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 09/25] net/ixgbe: simplify vector PMD compilation
Message-ID: <aD8eNieO1XIts-ig@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <8c721805cbf413ef8fd3272698f5c650420fa2eb.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c721805cbf413ef8fd3272698f5c650420fa2eb.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 088be7c1-88ac-49e0-7d19-08dda2b90645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HtYn0KnjSopXHR2+lRwA0Rnnbw/9+Kj72mGOQmFO/D24MrL5ENdDU9pbvfjx?=
 =?us-ascii?Q?DMz92oE1AciSvqQvu0NbiLHeC+n/7ufBANMT9LQZC9IoSx6kIjbdLhrsUFA6?=
 =?us-ascii?Q?dNqsNtToUtfIUCcbBOFcClO+D/nDsMFS3qEO5UkYzLRzKfAPeFouatXLJPJf?=
 =?us-ascii?Q?2REqfVzUs4JvIyBg2Sv+1QJLEt1NCVolenr8UBzqvL2LedSKgbmaoCoLVOv+?=
 =?us-ascii?Q?q/DTKvTDcahkIvD41mN1qltCRlHdv0AG/ww8LeRBVagueuofenmzDzEcWV4S?=
 =?us-ascii?Q?6P3dWtIwvmdF3F15CPuzGvtBVRE/lHTAGX4+RkYp4ba5noY0eCcA4kzP8c6N?=
 =?us-ascii?Q?18R4QvDnSgamfMRYgrTSuApnx3zWWgrzHiwLMYgnCYSxCAt1K9dFP6ciGjCz?=
 =?us-ascii?Q?ViStIVMuYQn2Z8VHnQnn6J/ro26JfpbXlMGw2oz5oCbOewiafBsWyWO3I14w?=
 =?us-ascii?Q?+gheOYWrhRvQSCdjSt+8vCcU6r+ZrGYcu+j0fGe7demON3VyaQGzi/NvFml4?=
 =?us-ascii?Q?gv8heiY3CnfS5toZHuOBIX3XhD7NGaR0v4EF1xnplqNYBocyJeVNNI6+6ZyL?=
 =?us-ascii?Q?8JPkK3umlbWNP4KwPkUpRygwYHdNrk+chyiUnQdwX9QVwMP9cn5aLWsHjfCL?=
 =?us-ascii?Q?bf6rLIujX8z1FIefNqfJjd6+aS7oHxRC+9dZBoorEV+OM+2W5wG7TtGsdvMl?=
 =?us-ascii?Q?8xqRvVv/ecoSBwHMdrh6/B46g7PYFSZBSfHlilP2SuDbo+Ww+LUw5WTpFcJr?=
 =?us-ascii?Q?b4hFY0ABSWdNGaPika9vZRfNLQGHSEWqRhoUtzXRpL/58/C9jjRva8xZTjfC?=
 =?us-ascii?Q?pWxXL3CNep/MDNIfhRwRRcegqfgxrdWEPMAeglAvgsvs5ETnvrmXONWL0c4z?=
 =?us-ascii?Q?yebU6GWvZsEXd4OVMdp7vKRiBDLGA83JbFvpmu6TqZck7QbFsdsA4m7MHrzY?=
 =?us-ascii?Q?4wcL2K+Mz7rMTh87k7qeOKisfBlDJExVSCSHmYRhdAO6xqtLOzNDrYZBMWRo?=
 =?us-ascii?Q?3FK6LAlHFvNdubR1w9l2Z1jQawVK526YRV8RF6tOHCO6rWJ2NfZ5lZQBjTQV?=
 =?us-ascii?Q?iH9CBOIOYND67jyxx1u2mmg2lJCCr7FK1CCPMHWSCY5oQPXEoV8mW43P/3pC?=
 =?us-ascii?Q?qPS5/PS7sexLzVd/f7b4b2/CDtvAH4X/w9Cg82cnOCoHf1Khwq0IFd9Z/iNl?=
 =?us-ascii?Q?mf2FFez0Aoq1yyGdeVJ/z+saXnAy2mGQSVDcmkompboIiUbal42eLsSvPeZh?=
 =?us-ascii?Q?Kv9vC08sKiSYz5PztUap57MX0ngGQH3IfwvDApaxbDEAzYv4vOjA33cEmeiI?=
 =?us-ascii?Q?b+JFNohr7/lexHcRhPDaG1o87f6LOaqAZ+nazKyTqRtMZ8zi7s2kz3bEys4T?=
 =?us-ascii?Q?a/80NgcElKpowW27o1y1stTY2QoHjJJOLkGjzSU5+j66SrmgTo28Pflpu8KI?=
 =?us-ascii?Q?ZRre0WiCcnU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bODQYkJpbdUfO1pGUgt2P9YdUoo8nKVl+zL3nqeHi6QmFf1+5Ev6vl6n1Oy?=
 =?us-ascii?Q?4h03GvXHIs4A4HpNHFMNm1QoHoCImBomVq59n+2OcAEiMfTuqJlVJNal8Ss5?=
 =?us-ascii?Q?GekjqOGfSXzqAF46NKYz8olvFV7SRN0JtFkc3UewoRe+UnyLfu0eDWoXX3s9?=
 =?us-ascii?Q?v6oIe0PukUqxQo7UfdVt4qI/XX9kocTjKUW9o7aBswC5yWK1Vhtz9RKaqMR+?=
 =?us-ascii?Q?61WLPwsGosZs8SZ3Tk/4X3x59H0CttKEH3vJLY8fs5yJfK4wP2EUyzmJDS/N?=
 =?us-ascii?Q?3AL6qKQC9SAiil15yV+cPFiz6XUKPTNu00hOgf+yvicJuxm16M60rIGTuCZQ?=
 =?us-ascii?Q?Ub8chW1xmDEb4qpfWkNs0AuCHCKjbi5hL+cpMwWtlDWCo7BpWTNeNNFpkjfh?=
 =?us-ascii?Q?Gc70tG/zppXzEwn54lwfeGur4sprQVx++dMNlJg4M2eRetxa9nO0VWSMGLp0?=
 =?us-ascii?Q?Tn2apeqsPfbSoHbiZi1iXGzWdH8i2fgQFAOxWu2JqRmeBo+Zf2s8yy87vkgn?=
 =?us-ascii?Q?NMsDbEZlixVlRLzqsdJVeo7vGqTdc+3Zlrur/AfZS1tjKzhJmmMxLekDGaws?=
 =?us-ascii?Q?fo7QlGdcETM9F3VYVF1DIT9f/Yvpm+XKBaXxbR2l6d1tCp5iRfiZjL/P3vj6?=
 =?us-ascii?Q?zRpZChjsEb7ERipmB1VFvSDsLRlb08fOQoOlgytVEIn393PW3z8L2xDZArxA?=
 =?us-ascii?Q?Fr4WeyWw6Own1WuseOXQCRuMpJHwJnv/BKNDCK3G1y8F9C6Q888X3hqdbKEP?=
 =?us-ascii?Q?gZhpVxAmqbaJIrBcciWPDhjPdA8bR8OCRh2k1XjjJLeX22+LVr2r+p/CcNu9?=
 =?us-ascii?Q?h9WwKz9REaXt+/2aHI/9nd1/WevhlKl6xMvuzh4Pk4WIWVylAZhbwjuMY4gB?=
 =?us-ascii?Q?fc0SPpCtZKbFq3h7wLhxaBq8ZcSpfH/i8qxVQv0XwMHgOK1a3ijsuWDgPQWt?=
 =?us-ascii?Q?Fls4OljuI+YZpIObek1MeCLuq8bZqQPA+s6EL2DV6SDYvh1N2MKhvIsfP3rU?=
 =?us-ascii?Q?FXQkd+0RwnFqCKmkMzYC87jz5S6cC7kPf7B4bLIrd3guHD2nLgI9iPsE6AyY?=
 =?us-ascii?Q?1DBcyHDsqqQPsmqCkd1Wipk7EhlMssljSxqnik0qYnoUkdn3lUfUkqvCxWYW?=
 =?us-ascii?Q?1B2LVu7TSVzC8b7mVYcSGSjN8juziUya2z357/BWQ9BJyMP96J56OKdTKZtA?=
 =?us-ascii?Q?omOqqeDv3UDuKqDOly8cHCgS/wfHAN/zcpUmCIaXEWu4VZwMGXPTXAwjypdn?=
 =?us-ascii?Q?7G0LJZgFRLR3PDNg/wHSe1ThEJZm3NMclRwjSx/OmhNxdamM7tehlYCIWwM6?=
 =?us-ascii?Q?Y8xB/m8sftK2g4+A5fxyBpOL/Es7vid1yELDwHmWaYGoAvS+A+UfrkS/YjWy?=
 =?us-ascii?Q?VovBufSGbWovvUiFY8L/T6T4l2zaocIHoTbOZXTp0amVij/kxxZAhMC0Auk6?=
 =?us-ascii?Q?PcJQHujc8G7nHCm61zJeYDuYsz8v+7cnPYJFn5m7GL4FZl/CADzqIa/tGvao?=
 =?us-ascii?Q?pdptK56EO03vZrKrHU8D5EMQF/aEVCGGUgwSuYY+bgUhmy/NVCGEPtMr8fLj?=
 =?us-ascii?Q?1HYY1M0XSzj5jlJReQpXJV25kyYk/CI8FBRxEYeIimVyJQO5aJ1gRkkdpyWd?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 088be7c1-88ac-49e0-7d19-08dda2b90645
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:09:31.6585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iqecoxixqm0wCKkVnFSi6KXDvwcWdSeo0kzIQUeBTLKv8WLaYnwVMdG37KZaXJMxtpHTc445WoH05oliDQPaNZ6ncr41E8MGBIWR+68e3NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
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

On Fri, May 30, 2025 at 02:57:05PM +0100, Anatoly Burakov wrote:
> Currently, there's a bunch of vector PMD-related stuff that's being
> compiled based on what architecture the code is being compiled for.
> 
> Simplify it by removing necessary #ifdef's and have it so that vector PMD

"removing necessary #ifdefs" seems weird...

> compilation is controlled in one place - using a compile flag from the
> build file.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
