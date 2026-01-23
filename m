Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82357D72361
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 09:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B7AB4026F;
	Fri, 23 Jan 2026 10:06:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 130D040269;
 Fri, 23 Jan 2026 10:06:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769159210; x=1800695210;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7/ffzPDQ2ZsSS7P60IBjOyLm2WIwE9Qz3xG2Fu1aZ1I=;
 b=J3phGz/Ht04xoH3INI+Kx5X44oNw/bYBke4+mpLJFB6cER+lxm4A0iEV
 Aa+z/xQwsxTj4ObhH6ocX4i+ogHivagCT7LesAidb0Wx4gOJ4wgkNNsj1
 igHFnZr+/sEi+gmGhQeQZC9S6ZUCvEQvuLFVzBK+gCO00kAhms3KFBGac
 AyGEY5YW2KYxTiG53CWcjtE3fUdK/mrV5W9gT/6RtS3h+kG7B/jf7g5N2
 Twozk6JezD33PCv2VwrZd75yh5KOPUXsG2h4eUtD+Rc+1Y1fD4PedP9Ss
 iRme1tFmz/J6kNOoXlNAYcNfR5uV9Y70yFrIdsYB31L8mX53NnahY9LFu g==;
X-CSE-ConnectionGUID: X6g5z5y7TDW1702td8qPjg==
X-CSE-MsgGUID: YEj2gWuRTbiBP9NltsNOrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70385805"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70385805"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 01:06:49 -0800
X-CSE-ConnectionGUID: t/3jCW0rSTOG5ZEHa4mQrg==
X-CSE-MsgGUID: 3hL+kGGORFCbwCtVKSTxag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="238236128"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 01:06:49 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 01:06:48 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 01:06:48 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 01:06:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw5Yz/AvVZZbAVmTxXb80YeeJf96/gYf9l0Tii2VVniFBt3Skpi9Xw/9anu9zjEda9j6FPO/HZ7AM1wlTWo102RgoJtv1Ke/eKvhKwfYmUjyx7S0gW0Xb2BFv+qyZNY7cOHEILRWkRyi6awJ56Nwxu+JtYQ6bUUcbdRFEVou/Cs0TGTVfB7KOGz0G6f/QiwlvLaOZeVYHFtQQO7cuZa6mKx3ESV8yCOpuhCrZ4b+junrvyBEYtt9dS5VjNFJAXn/JmUdR4bf4ecUKQzhdRQe9X3rXLeRY8XLiFKk4u5NzzGol8ubTTArGfNivXuvx1mtm6V8SHsNbGCCfvh5dHOo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs3BIQAM7CpPHyINoy5yROwM4EKlri0IdiLoOXhtPhE=;
 b=XQchZXEcfzhGzZ5nV1F+dkAAefdRRQRpS+bQglc2aIX/BNy7bffHzXrcXpQaxGKrI0noDaAysjzHEVpe38TktD5LjmZUxzLXgA4mTubu0LOt19zh3BRpe1ZZJIWQajfO8EMP8+/QTedtLS0xsW6xqKUbq0zx0tXhG99zF4NbpjtxqKynud6GeSLVVmbdxYSOnJj64du3kBgTCb5PwJPawxpbfhhLhG7DvHZxdcpPNsPnrNsC+NIY0MKRCb2z5Q/GbCbPyCSNBm+os2gti1ZFQhebKO+r927ks2Z6t/0uJmblUiD4hMoAOPaBXw1o4C6YSetSS9hj28byhjaef+rpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 09:06:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 09:06:46 +0000
Date: Fri, 23 Jan 2026 09:06:41 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Naga Harish K S V
 <s.v.naga.harish.k@intel.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v3 11/14] test/eventdev: skip test if eventdev driver
 disabled
Message-ID: <aXM6IXTjvaUikhbx@bricha3-mobl1.ger.corp.intel.com>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
 <20260122005356.1168221-12-stephen@networkplumber.org>
 <20260122124044.3e13b927@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122124044.3e13b927@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:10:232::31) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2fcb80-4b77-4112-de50-08de5a5ebc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kW23ymEcNTDpXSZJ4tbd+RWqcVKSrlJ4BP/d+z4vO5OD/t4FjMGXl5+kuF7C?=
 =?us-ascii?Q?Zk9v0N7auDNTDmwyZerWeKJPtLIEFuDGIQq4Ex/d/JyzxR5OliGabsZOrtWc?=
 =?us-ascii?Q?1Ug09s0rrqQ+3LE8pRBxeA/T5TGSltaPvANL1CBEYOLa7dK3OJU1CJs1kB7H?=
 =?us-ascii?Q?VtIXv2pvWJ9o0msUcLf+04L2OjshenXDIqONu8/+mM1Rs08vio9Cb7+19prd?=
 =?us-ascii?Q?sXOiWuxPL9qItJ2eTsSLPbI3cQY5u8nmpt+U8sRsEKmOZkQuP1RGVMVsfGVQ?=
 =?us-ascii?Q?IXdOXnnY7zMLzCdJkEFjl5OYbGPEzlIXqlorLTQgvK0L0AZAvbSuDRRnnbVk?=
 =?us-ascii?Q?QO0rQnESzXOX5JfZRLU1GWYvtEVg06h+pBP+svSqbeY1/+473+I+9E5RD/J8?=
 =?us-ascii?Q?sSqhrWdDjJocOBPoNd4WGJsX36sOVU7MVDKuXFfKLSHs+MA2cchwKMjp+F5/?=
 =?us-ascii?Q?8wQhBKM7BooNuLAO5a6AQL0xHK1wu2YgzK+QAGvW5tDdaSp4o+3luzndun4N?=
 =?us-ascii?Q?pquycvYZODQKInVrHeZ+s/b9jBezJVorN9RlAjs6hRcF/sjdsIrpifqOwezV?=
 =?us-ascii?Q?XqvBuZMMUQp+74AYekSb+Jwc6AXtSnb5JFRLKwIsqbFiT70X4mYbybRGxtYx?=
 =?us-ascii?Q?4SmFWOR/r6q88S1jsKi3YnzsE6/LLKN4EW+3RFR83XxRcRC4YvoY1IAyfLS8?=
 =?us-ascii?Q?c0sJiQDCJJSygIYkjKdqEal79XSL9D0zg9CKfPyYAqmXo9VAfPGmck7hhb7k?=
 =?us-ascii?Q?V7a69s4iN0StO0EF58cSVHBX4xe5zvczDnfYOCNS5nxvuXw1siEcApg81cki?=
 =?us-ascii?Q?Z7n17CSyIFnAv2AFmErtLm6dOuwjaU5fE2C7f/yKUSBi5H0wGFiqV6MGBR4u?=
 =?us-ascii?Q?PifcdP/qdsm/FM7yFIeA6BihvBbt4/qeQAXLEWM+uQR6ofc8SXZ4+v/thdfE?=
 =?us-ascii?Q?9FHxDe74Qa2Xri3Pf5hEe8G9s40lItZ91oQco4v/EdQL5obbBWzUgowGDqD7?=
 =?us-ascii?Q?B4Gx9mQD45zezOal0Czew+G8/2V7iFaKmeZ3LjeyCq1Vslptyc14rPdA+tn8?=
 =?us-ascii?Q?cErg2RJTPFWC1A+W211gvL227JjA+2+8+eQoRGRpl1ZU8Cjv4KrgbYFpHpwB?=
 =?us-ascii?Q?mzwPrk0ZU0KVrT9W+sIWHgej6nZk2WQ3OcE5ox1wq5yXBKzLc6qGEjeic02c?=
 =?us-ascii?Q?7OAvQN5S/Hi5pJUblcjH628XrkwYmxE9M6H4AvD2znXYZhFK+SjZOoEdxIxB?=
 =?us-ascii?Q?WNtKIDkNH8h9IPnfUN5qQRKrx7+k4fwhoKjEGerb8RZasaBWtiAIezxHQy4s?=
 =?us-ascii?Q?YYY30rHcDvdQ6S9sPCsdznDpfFHfcTg8huywaFuiEo42obpFzCLjOJB5g8QL?=
 =?us-ascii?Q?HOCK7oo8lWD57iu4FNxOtxLGI9inLQ1wPADY3B4YytDueQ9VU4dtWuOjvu8K?=
 =?us-ascii?Q?J2QYEThxrJWRkYbwYPfEV+FD1VRAmETvn6yGjNjOm2Ti1bqSH4wbetdZJbuh?=
 =?us-ascii?Q?21jJzF1NvzvPZZB6YB/3mK672U3zXAv6xti1GM9NNUfw6NarY3ZESaAfDE/Z?=
 =?us-ascii?Q?n5Xyd0oMtYebRDx6sq8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55vWlSoR1R9x4n7UZE9DD9sA/Bt3c7Jbak3t9Mv/jdftPCADQh/KuE1R1jax?=
 =?us-ascii?Q?i2ywDvKIRMau14dRQ3vcciHjETRon5CUNWDk0XA5lUI9xg9H+pttehTVNcem?=
 =?us-ascii?Q?GKvZwJWI4UHdI6RbsT/Xr077Sdynow3SICA86ajyWExYRNpOzVDk7v7dR3aE?=
 =?us-ascii?Q?28wiDeqB1KPdT91o7qg2J2+TPrwS+BzGa3Wbg3U6POigphrfHDPzciEV7QE/?=
 =?us-ascii?Q?8Du+PP6ql9uQJms+qiqR7W0NuTxavp9Kx7b9/vB2U2/PS9N0uEj3xvPF4Hml?=
 =?us-ascii?Q?IjX5ItO/Vg4EjTV53iP0yiQdRBbHUzKa1ImZjXV9RM0fhwVj+GTW3iANmk7L?=
 =?us-ascii?Q?Z1lBHR4QXMhM6eCB8ULlDKZYlTIO8yGVlBHGP8abYZsgzHDF587VKf3oMLo9?=
 =?us-ascii?Q?R8FyoUDO3efp2a249uscntaD17XCSpbE0ui7EBW6mpRuEoRmPk4Fsqb5pASd?=
 =?us-ascii?Q?NJh8LEbv1qvQjUqNc5PQM14Mz7JptaZ4q0t0CgVmCeYWBai4/JAq6mwxiOCz?=
 =?us-ascii?Q?1bh1Q90CrnSyEa49zXIpC2XA+QjRSjn3It6o35zCNuodvT3LhlE58P9YuC2A?=
 =?us-ascii?Q?2etKItJTffLrYUtfhmD2onTs6uaW1e3/F4ed+SS9u8kC/oYj98c3qUZkwLOX?=
 =?us-ascii?Q?0RRxFMQlN4pWkO+OudJa5njbp4XYTfgX2HzwzSz08KIxKJWkXXU9cxYjwmTN?=
 =?us-ascii?Q?JTVFU5vqqWyyFgN8lgLSY8V9JyN/q7TE2ouEbnD2qVJ1ptPdudV+42a8aDBR?=
 =?us-ascii?Q?XfQZrgaj+2YigMB+VvhvAvZ0b0UvXtu5zNw2dvtejLeau5hFs2T+ZTLxyt6/?=
 =?us-ascii?Q?ozIEAqq6QA1Ub/0HQJl7kV31+yisxRauHaPmN4yTRtjis4IDOiQiWgwiVDR8?=
 =?us-ascii?Q?Hgf6iklLNko+TrIL9k0qFIT8Ovz7IYVoBSEzO6AfpehF5ALmkByXnOOFbkmQ?=
 =?us-ascii?Q?lBsnAclfLIzeXBpRY6pbMLaAULwbyNf/2J5uhN6opqca/64+w2FyvXsL2CFO?=
 =?us-ascii?Q?kSNYbT6EUCHkCtwsBLF9TYe4BUt4efH3ThoCcsj6p9KNw1nnlMX/+nxhjEZR?=
 =?us-ascii?Q?GBs4sVTsYvrwQs4UX3dsyIpsBkCfvj8IDaMrYLD38GivrasH2GXRlz9FxtRC?=
 =?us-ascii?Q?JBxHmOwtkUBPmNp1YW8J5sAYtn7ztYhHUMsPiUzvCXbxZE++EHwUljG+n2/3?=
 =?us-ascii?Q?dGJL5bYv3Jh4TSBMVpzunaR5N2hHabJeJ3ngkFO0dnRDHzevg4OJ30xgYEDr?=
 =?us-ascii?Q?2MD6/LyQM9U6B2wbb3ZjPxLfSMCgn9dsCzoRpWLNVPgJk39WPmNzfb0IoBXE?=
 =?us-ascii?Q?hnSRmXhToeWRGotxwx5dw8KZXBrd31omTFa3RHVBHttFqzGq03wLY6X+dWvg?=
 =?us-ascii?Q?LKt/UUFCjL+victChkOnQWRke9yunBaaXrVrIyVTVT2eAOuoUPrx5MKYfFZR?=
 =?us-ascii?Q?uwEIecAYmJpHtRp8LR8PgCfjuFqCOu1uVsEfbNNXOkfwdYhpUwXTJ4P+LgPE?=
 =?us-ascii?Q?G44znczImaW9K8vT40V92E1z9j82LxwuJMx25XZp+/U6SyjwqWtO2CW256K5?=
 =?us-ascii?Q?3FipdEuHPcGC1dkEISrc8rbz2gH0MlZ4Sw85uPYh9nilC7qoGv1NtF6sedaD?=
 =?us-ascii?Q?fxS5swhfe68//RORCNOayP7GO8WlofpEdVlD/3kHPh9r2KEDwsBgS74i+HA2?=
 =?us-ascii?Q?LmTkkN63HFdMQ1WtHgn7I+qTzI4BRvg7yE/9mqow7EcZZgn15/zbFn0ABFVu?=
 =?us-ascii?Q?1zxhljB9tA97paEsg+X2/vKaVot1Z/I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2fcb80-4b77-4112-de50-08de5a5ebc23
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 09:06:46.4553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ljw7DbSTJTP/vn8lp3UgoQY7i9uhvogVrYRLaI14i9Vir2oFfVYUwSxB6XRM6zvEIhuqiqUwgpKCQyDbuRy7l5O3qwZHF85xwKOebl5W9SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
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

On Thu, Jan 22, 2026 at 12:40:44PM -0800, Stephen Hemminger wrote:
> On Wed, 21 Jan 2026 16:50:27 -0800
> Stephen Hemminger <stephen@networkplumber.org> wrote:
> 
> > If DPDK is build with -Ddisable_drivers=eventdev/* then the
> > test will be unable to create the needed software eventdev device.
> > 
> > Fixes: 50823f30f0c8 ("test: build using per-file dependencies")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> Maybe more needs to be done or handle this in meson build.
> Not sure.

If the code changes in tests to handle this are only a few lines as here,
it's probably not worth doing. Also, this particular case can't be handled
in meson.build, since it has a runtime as well as a build time dependency. For
example, a build could include the DLB2 eventdev driver and so the test
would run on systems with that hardware, but if the SW eventdev fallback is
not built, then it fails to run on hardware without. That sort of
situation, build-time dependencies can't handle.

/Bruce
