Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834EFC71136
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 13:54:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5078F42EE7;
	Fri, 13 Jun 2025 15:54:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id F3EB042EDB
 for <dev@dpdk.org>; Fri, 13 Jun 2025 15:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749822849; x=1781358849;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/M5F40E+XshiXvRmOUknFuijL1DYuBteyU9r2cJrZAM=;
 b=LsYlQUAzWxCo72WlMniERESNBq0DCkkkeP3jQzmnw3vm7CuBL5yt7Aih
 c0V9RXqyiF8mnY7I5EWrK1mHgg0ljrp/+hLJpawIhGEHDF5qdovlwUpUr
 ek0NEYEY8V4ONUFOlaTmrlbZbd/dHIqtSHPIVThm1Z97Kblxqz1SJpUC7
 wEn2mqQmmhHQ/9ULaaNl+rj5Tf3Wh+zpvZw+Y3QwY6Vr9CnzpJDyW1yZY
 toHN3phUIOYr3/OCVrDBGbwTj0rdP+Vhp6VZ0gYFLfscv9mcbgzkeXzY7
 CM/wLnupR14KD3A/IPmYLbUnzQVga/gkXckN3rKBkwcd37RlO//ipBjG1 g==;
X-CSE-ConnectionGUID: 0Qi0C55uSISGCfnaFdVKhg==
X-CSE-MsgGUID: ieA6xsyWSMemHeUxl4OJnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51756181"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="51756181"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 06:54:04 -0700
X-CSE-ConnectionGUID: 0Ju+EnzETNysgSCpqEyy2A==
X-CSE-MsgGUID: au5XExgnSVC5Q6DLdP+tDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="148728270"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 06:54:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 06:54:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 06:54:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 06:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTzKAxc7KMlmi4bJ4Gc7yTBFdvVta263YrW24mogvyKToy0a6ynV0nd3V7NDFhGngFs2lox+cIU/RlCjSI3agFcTtZrMu/KWvG4ILtwc/c+Vi3Vu01Rgo86P+1NYWc/Crjj0YtsPTuilZ7htO/ygeM58i/5mpTiMx0tQLr0KuF7MV8F9RPJvYrfoTQxesXEaWnN98uYI/8DtBdmCOew/KXkjkuiWgYr+4H6oWC+fme0QSijdY1bG8h1i5uIGaSLnubWqBVuFkbQ3DF/0UQHFIuocW5z/LRUm5TOsYjYl5pHDb7uRZGZjXGu2Qn2hZCE1vsiGZBcm6QA3CUmK8PqiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhPuJog3iNBWZ4by7HJFjHx/oXA4e4nbsMO3587LTpk=;
 b=FbvXW2b0mmvi+SHwTwcO7EnhFQdFXr3qzgCon36fXRov70SoegHMiGrRafUrceSR4PVEUJ516elgCSWyQiibxfwgCI/ibWVFvVw1oEUhJE+ltENEIePUu8ovGkuhZiZ3KbAIhyWBz+9ZIKSlzPi83u0h8nnlHkX9KLlHmPMTLszUjxKxRc/+WV5lb7Q5H5wC2+YXtncXMOfUqecJIjKDWsXGXpe2OEvFTfIReY+1WYa6PgegSZJ484pC37dKGym0it+/luvUqvT3Or5hWRjjSr7X2F/2VDFNjWEXbFYVtjf32VNJcBKqRIc33jktQMYZ8i/wU3Vc9haPyEgTkzM2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7404.namprd11.prod.outlook.com (2603:10b6:208:430::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 13:53:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 13:53:47 +0000
Date: Fri, 13 Jun 2025 14:53:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v3 1/4] eal: deprecate old coremask-based EAL parameters
Message-ID: <aEwtZhMzZ2QEf52f@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250502151134.536799-1-bruce.richardson@intel.com>
 <20250502151134.536799-2-bruce.richardson@intel.com>
 <20250502085122.2e9db643@hermes.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250502085122.2e9db643@hermes.local>
X-ClientProxiedBy: DUZP191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dcc0c4-50a3-413a-afae-08ddaa81b7df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B/jTWuzNwGS2cbAmOTI4BJpXQ6h9n309QMc54DS0JL8/dvPnNlNvyYUVAima?=
 =?us-ascii?Q?BTxc0kUREw5xiEzVErqxVVNGiFMbIKIIyRmo6YzEw8oEXW+7DaJqPns1P3ab?=
 =?us-ascii?Q?FbFI2b3eRxFx8Ghna1WpRFOWgpiShvXQyfjpvYb1SHXMgWAdyMa1ut4DjNpv?=
 =?us-ascii?Q?kedBvwzD6ulMVrx9uyKAoIctIrl3gJ5b5jsP/BbHE4MhF6i2zCRJvjjuu35l?=
 =?us-ascii?Q?9av7ayMiOJCiien6yMaa0CBSMpKdpaBd4ybkjkrYt45Li543avTxKXhRHdhY?=
 =?us-ascii?Q?IUXbHwnx+7NHmDYXoTA3fQf4f9/EruUU0/AbZpv45Zpu1tLKulczMCMn/V46?=
 =?us-ascii?Q?jgFN7MkmlHM3Ls99jRL55HKbOuUVsr93jUfolB6bngPhBL+4OSEG+Z4S/7mR?=
 =?us-ascii?Q?l3loF9SF66XkaXxn6dmNHqlAFHEaBWskV0r0c9n0vWBhBYnG5yN0kyJNOfX8?=
 =?us-ascii?Q?TQxpP8H1hEugr6+PIO4k6XbVictqP79ZE1WxZkIjGewlz6fn/COf6BS5eO7J?=
 =?us-ascii?Q?7z1aFUJZ1HpyzHS1Y+tEVuEWzUoAmOkwS+ORwX8JRW6jPqzoLaC8/vFPr+B3?=
 =?us-ascii?Q?1whWsUZgAxWy+cbFvcVcD4zbMryjav8d6sTP2viSy5FuXo++0oYeleNSbhep?=
 =?us-ascii?Q?EW15uNtecBXYP0iG3hiqHja08TZ0Zdb5LTMgvfvPzKLdnndlmjyuJQy5QvVt?=
 =?us-ascii?Q?/ylEg2kRipDTAc90PBJS2c/M7MXsoF3mevvabkduYcSzmAwfLFO3a5K0WiQG?=
 =?us-ascii?Q?zREMTysahBPbjvXek3jC2wm0VG9nW+UWhr5qQl87FoOm7+AtFeo6W8otnJgM?=
 =?us-ascii?Q?3YG1W0tuBlXpml/J5tu2bJB1gNq990hWGyATy4sxkLXHK3AVyQcb6DLvX6yq?=
 =?us-ascii?Q?MWKoQMKIXJQXGZZb5JV6u9opdOt3ejVeSISYAzIemd3ca5cVCxT8Ykg40c3f?=
 =?us-ascii?Q?2wl9us7/uRqg/iNp3GO8X5tZQvYFWpGrq7Iz4upyGXR7vhYKt+SyggyoQaLD?=
 =?us-ascii?Q?RkHQRYgDJcbV57sjgFMmrDf/nC7K9Ppknq0D9ZuxsV8icdpsvcMpFrJpgBol?=
 =?us-ascii?Q?++IZNNVJeULeSXqmaN8jDYvf/+ewCDwVZKJKrs1ARpSY+ibh5BB+qaEaYtXE?=
 =?us-ascii?Q?23ecFLvhXpP7vzPmkkKtRUtURlYImnjIN09caj+GcfvrbqWca27OdmZ6dvNK?=
 =?us-ascii?Q?GU32eo0pDq+nXLC+LpuF6dY9Fs8u4DfxvVYHH9ru/etNg+BMxkI4pe4X7dME?=
 =?us-ascii?Q?Fx+cwGan5pJxRTi/GlQJpCKwR+uUpTkO8RWGBDirWSOMjNLEKEZVT+SLA7J5?=
 =?us-ascii?Q?6bMLPnNtJ7xZGzwhpbrApMZQTgFbZXwjoIWGZkqjVrJ4G/R7+mqM4u8NrD6H?=
 =?us-ascii?Q?Nsg1PhY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ljtN1mLDdQzixYSRW0eyqA29QmpZcP2kBbvOdOapKYIp14XyMTlePeT8d7T?=
 =?us-ascii?Q?gTu6dvIIa9FVD96pzhwfIVISs7gvv9A6tHXCV7RIqnQiOtbtPpzp8+zlDKcR?=
 =?us-ascii?Q?l1/8zNBHBAfi8hTIdbCcXvTISPrMT51exkiao/EAQvBYD5p8KOe95XS/6I0n?=
 =?us-ascii?Q?azKqxN9tlu5LVntYReHlslfYlhc42E/PTmHVeWnALDj1TEJpOdgEuY3l80Dg?=
 =?us-ascii?Q?MXa3r+kbaFFawWCGK2dtF8dUgD8ienq+Eoh9ZuN0NXmlB9Ie/T4VLkmum/Pk?=
 =?us-ascii?Q?GI2iD621gSsA7ZfgQ9mLZb14647qdrbZd04VOcLdN2qVQUthRela5hzQ+47N?=
 =?us-ascii?Q?y9TMlPb8avEoj5rSbW8qxiVoJgBPUMZeQb7yYeYl5EGKXu5SCid5K/adUtZG?=
 =?us-ascii?Q?m0pHR7jwWimS7xfRWMqP5EwgPW0d5gIh8CCce2vxmtnw7r4xRjB/IXgSP4/n?=
 =?us-ascii?Q?xXkPZTwBQpuzXGv9v+8ly5rBNF4A4uIaRVi6NNrCYgjPyaE4xKroZy7uGwhf?=
 =?us-ascii?Q?HbaZTRBzfx8FirhhaJfIjR5+O6Ib7TgSQ3b6eHLUn/AaGc9y8pfhocflwiWL?=
 =?us-ascii?Q?T5O2cHyJ/f2v9AzVuSmXMeARhQo6/gY5C1Q/kIHmfvXhiecKCfrfkpyerpR5?=
 =?us-ascii?Q?55kltPmfDlMPV4C+EsTfJ9tNbuf78eZOhgNIjgEW8bOa1sX2pBKBUafzny3g?=
 =?us-ascii?Q?BX8YpdTaT0eawXMGRTj2Nbf0Vemo3IFB+41nD1pVsBK69N2zWOGUgsp43wIq?=
 =?us-ascii?Q?vXEantFlBG8A3O+8RoReoaS615r+nlBCI6NR32IzcIZynjF5VtoUabzqcmAY?=
 =?us-ascii?Q?K9W5oYZIXdFr8BLOpN4Ax3qvbhUCn3H+hqwKqm+Nishk0oB4TQ00p33VPh/4?=
 =?us-ascii?Q?V8BO51SpwH1S5zSrjmE+LL86Hi+Gumvn8+2enttGFuEE701cQDPsHqwSgDaA?=
 =?us-ascii?Q?MYxUGJLSKrxyVzmyNNzLQRm7clAT+1F1tLW8M5OUcLqFf+lkde9jiJe0u3ml?=
 =?us-ascii?Q?+Dp07vxaYsDEK1ndsOsEZo61DIdHs5PPDFbqC4RfPObC8JB0yGVYqyUQXt4U?=
 =?us-ascii?Q?lJYViVA33uRvgh/Nj5z6V1D+tlVG00wNPlbrmZm7EJ0N7RMk3BGsDbeb79VD?=
 =?us-ascii?Q?v4SCPXmhtPXJRUvvrhC24qWSXDspZWIsSg0msyd1/Gaqs3B8DZCkyXy8MY5r?=
 =?us-ascii?Q?qTGj/QmZD/0Aek4L1YqsdnxiWeA3srMpd8KJuQvYHIjDQP2r3u3tNT9rmuyJ?=
 =?us-ascii?Q?NhyRXzNIU8F+LYwoxEdFdku6Bhb0Lf2yzgcTy+SW+fpnAcfaZ1Nhv16UC/rO?=
 =?us-ascii?Q?1N1+Q/O+1FXy+4yJsi+p8bMhZxJpDF626Pd97nUMpv8wdaMWsa5km/aJtw+u?=
 =?us-ascii?Q?TGq+FQfmrP+/l20YKtn6BlxBlsFNMRYzqWQve9FYyBEsGMv1YY2DrRJqtH4G?=
 =?us-ascii?Q?/ntjghhwlRFDT96SOQeSiLxRgkTpvTHONn+QkCibw69ZQOM7jGC+t5PegJ54?=
 =?us-ascii?Q?bH+qvFrpmVii7A4qqoiUczOW+S2bpzof+CymFXqVbPxZ1bmeJ0fU3O4qkII3?=
 =?us-ascii?Q?9X7TNb8lw47Ptqdx/kb0kujnS18Ah8imQqLGCcJLErnlpqNLRqw5+7z55IZe?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dcc0c4-50a3-413a-afae-08ddaa81b7df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 13:53:47.1150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnaSoIgIt0JV2pTc/pSJ5X3JNN0Ww01/+l4hrBoIXcTHMmFzPxNyCTtHnlUO5OW0M0RCsFuSyIFlIdwsuIHEdEdZs0A9+3mQNWcD+05GWnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7404
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

On Fri, May 02, 2025 at 08:51:22AM -0700, Stephen Hemminger wrote:
> On Fri,  2 May 2025 16:11:31 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > As the number of cores/cpus on platforms has increased over the years,
> > the use of coremasks rather than core-lists for identifying DPDK cores
> > has become more and more unwieldy. At this point, let's deprecate the
> > coremask-based EAL parameters for future removal, and point users to the
> > core-list based versions instead.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Agree.
> 

Any chance of this agreement being an ack on the v3 patch [1]? :-)

/Bruce

[1] https://patches.dpdk.org/project/dpdk/patch/20250527152913.279011-2-bruce.richardson@intel.com/

