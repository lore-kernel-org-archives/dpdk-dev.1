Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585BCCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 869B4402F2;
	Thu, 15 Oct 2026 13:32:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 85E76402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792063919; x=1823599919;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WvCNIJWu3MHn2wg+g3NIGvtU9VutKPYBAX0YZBLE1qA=;
 b=RDS2syJA+zpnS6lYilH6rxK3kAHj/h8l110c3zofcKlDhuMQpkc0fgBF
 HBNa/FixFNjBUM9rlCNUeSVaiBafmm/zCiJvaKF2GYrEoy7L0SQ3uq9z4
 ErCa/K/zh9sxkJB4/gSj6xa1KgX1ZSPfdMF/tkEuldTGrU00Z0K4c+Q9U
 4R3fUuh29HTLpI2sqL2UWrk0QPokSMe6lOx7dziBGAp3ZvqcH5YyaAdCm
 TOWFlmLRnJiwWQ5OSWVStBLENIMPylTMNPd7i03Okn7ftA5nvYIzr/XFn
 i/dgkeciNIJ4t4JjCmaQUH3L2PIKU8BTNl2lLjmdyhwcCjZH2t5DaAZ9d g==;
X-CSE-ConnectionGUID: t76ldHgqTGSNq/FShGOb7Q==
X-CSE-MsgGUID: 6RkM/JdgQke6MSuC8oai2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="840955"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="840955"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:31:57 -0700
X-CSE-ConnectionGUID: t/9DEUJTTlmBCdQaF4oM1A==
X-CSE-MsgGUID: Nn7w0kZqQ2W16OYndokPSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2107450"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 04:31:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:31:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 04:31:55 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 04:31:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJoOyPdilz3aNYzExiKfOBXMVGUTLqKJE9CZjpd7nL6SB/dofqUgJp6GOlPl0BRJQxcscfeO0YfmprPlQSNMHHVYdnQOpoR3fhZPyz2ZNJe00ixCAbjO7O7kSINiaWXlGDRysZpD2kFscmzNFqsDyhtQVJkJqtCR/8jIlW/gzPWEpJeZL4Bvz/U+JvJkFfhIBNQx/m2O2WP6c9PSPa5arEfx9yYytYVPHIZi5DvdzoRR2MM70Y1pOq2UqaPGsqur76T5oUj2wZyGng/bGHJKeOcdSZPhh1GUKhtqP3udBy0mKurWMUxTGNm3oySTmFIdWGuaF3+BbyHFTGqsXMfpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qiRWUH1BNYyyjeuGHpbnFd7+wGcspKW7bYwbv8R+CA=;
 b=Apla+icjZcRPg7igs0rXzd5LbXd8N8xa0uumzYjNLRhw8qAQdKUd1CB/6O6FOPh8yLe/91+gfpjGEd/8hPeMz4vXunvggcYp/tt5sRupu9Atpm9HEDdPe1baH63kFbTCJroB18P+N6j5DZ8VckUlJdTvPlRnTb0lfwcBntftUHzNLKBYl4FqEK7C0AmmNUs+Fc6YVPefAKdVdG/ukOVWUQVtJw1G3A/dp1uxKg0Eu269+Jevpc2eHydxPhj8deIilaHQs3IJflnBeky5QgdMkQH9JzTyzgI5mjmYaPEqal9YqQQ1oT9ooqH5VJb2ctNQJXbMffcDa6gS8/qxIQHiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 11:31:52 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 11:31:51 +0000
Date: Thu, 15 Oct 2026 12:31:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "David
 Marchand" <david.marchand@redhat.com>
Subject: Re: [PATCH v7 00/25] Building a better rte_flow parser
Message-ID: <atC5owA-q3EEO-XC@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
 <as5n5Gd_ibUFwu8T@bricha3-mobl1.ger.corp.intel.com>
 <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
X-ClientProxiedBy: DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 2171a461-1275-42f3-7ff0-08df2aafe851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IPgsgaNwuA1d8jLzbstYKGgzeBTmAcuwdDW+mrGGmDCH0RWJHgQfR2kpzDU3V53o8Q8nsjnSUS2zNvFRan6npvWCCL1oCmK9xE0XCtDGnP2zQ3egAodlusonJfCuloklUGrfEvIqzBaMtb7Jdg3l2g47RPX2QeF0weHC701mmiiVgevGZ+QwOL6OfZmMSDkafiWhjpkBqClPaZc1dt3Jpm1mD7TX0Sr3c/JAYXrEAShYJhstvOMZigB83qGRr6AH+RfJT/Mmc5sg07P8zWKazkApS7UBCU4JQEzml3RwMmsey+BnU9jC4Z+CsayE0yNT91wzpA77+vYekZM6dqTWo/e6ipCeDxcAfX33qm/kQi0s1rOh1/s5hvl/Qi7OTkn9aDfHVKXOPtvfEXtdkBFvHOuIMeBw1FkXWsvgpGDBcO8pGUaLKSr/5c9heabEaucwALKDU8jNLYgD69lMDkbhEOni7m7B9d7v1FTg/nc05Apjq0XIFau5a1R/xK/6W8FYmM/MZTpoYuQJWGE1zOq8pyzRWYc5mpzYTHNKUYLiLwdzcYOndk+gx0LWzKsLm6aAe5tePTp+cfbsvtVklvkibhXEOQfJU6JiuiraMVsVXH1co1QMDNvdfXG2GNXPMKltR4GzjsaWyq91G3VBlDuiwm+yryEbonMsdWv6UolXF+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?azSDxMTUkaQFMgdp7YX+jm9kH1ddBegyq0D/iNDuKqf06hwa8Dt0YQJU8jU3?=
 =?us-ascii?Q?Wob2ib8KGyULzwxOiLz/YxsMOndHZXtxwS2jkIImdTZvMQCtpyXGWimPWoTS?=
 =?us-ascii?Q?iMMtMrFK/5xaw4X/VfsJTGnFMIGGwDyxhcfI0ZSW7wNNpJU2725rw/hCsEUX?=
 =?us-ascii?Q?E30o0lu5Eg6p8ihNWgjltsiQJc1ghXKKrTXgAWmeub0lPHvmZZGgNKifbbPb?=
 =?us-ascii?Q?hMnwUlYSxGklaFdFjhaLZWAqQXF7vsyjeGj6QhnS35EN2FFnNRfvde0EmREQ?=
 =?us-ascii?Q?ajIe2D474PJOG0gJhV3JDAEf7Qz7L1bQfm4be8oGHqqmEdGU/CWgm6yMhRN7?=
 =?us-ascii?Q?oRIe+Waz/OmnPVuqcwDlhJA6rzDNRuLaNa2d+QPLUO9LVoC6Mi2ZzvQWudGl?=
 =?us-ascii?Q?SKq1l3Zi2miRlqo6V11Kj0Aa7qHVkwDZRSwXwcj1U165z8PH4w+SlgDks4RI?=
 =?us-ascii?Q?ST48U8XEPc8xqEa8k2UXkJXcFPUdpGWOZcqP6MFMyJKSXdphch8SgmDJElPE?=
 =?us-ascii?Q?5kNjbQk8AJ1SDCGzSDeb5hb2IPSDzfz3P2wFTmfjhn6PATSBwCYrtgS4tmAS?=
 =?us-ascii?Q?tZFmjbW/6zjPNOKuZgJ37Wgyienia81oJC4GCr2fhtKrl4wumsbi0Y1I7K6G?=
 =?us-ascii?Q?Le5kii9NiTXMG8MOe1oWEPQJEWgW1e6/Wt2eOUnmotoivVbPcY+dygYQevn5?=
 =?us-ascii?Q?+AmbBhw2RAA6idyR+fn0sxy560JHYaYd0cYDOxP5qZXJB8uApaAhMhNnd87E?=
 =?us-ascii?Q?JyR/Riag3E/dchKjIUMobmyM1Phoog5OYW0e48j+1cldYOxCob6UR5p1Wc6T?=
 =?us-ascii?Q?fI4Dz8HNNvq00YlJsfJCbmyISVRMSBEuyyTOXeFxufYlLqyuIt4JHy1/FUnM?=
 =?us-ascii?Q?ShhvND0iYXYcFNG3XGpd6zEYTA0+GoVAJOuKlzbiYtSHU9TqjM/4xedntI/1?=
 =?us-ascii?Q?umo7a47zDYv2k8LTTmxiIJK2+shopcOKb0hpS6L/+X/3GEjjzRCUTpt/DswI?=
 =?us-ascii?Q?c5e3+U5/MjGEgqH1Jw3vMfSjrDTokZZJxjH0EV0IxguKtUHIThwCCBPIfDdj?=
 =?us-ascii?Q?g4TDmKrUor3RernwRPevkIgYRkDFOoopL3qU0Wsgn3ZYx2o8mz7+xqul7fpg?=
 =?us-ascii?Q?OwS/5BseXtPXjZI8MTlAD1coMn4KQd/RdfbsOrAnGLjoOI3C6yXr7LVtGKd0?=
 =?us-ascii?Q?bq7VY8Yv64f/b+jMtW94fEjBUbDB12BOG5CiQ/01iF/pk/T4qMCctrDASQDW?=
 =?us-ascii?Q?r3ZE/L/KJrRSkiftZUgfWFFYg5ffvjg0EVE8plEjgEKjIyF/xIB1WBKMcO1d?=
 =?us-ascii?Q?XQucv4YrvElk+CwCuAtNXir/ot2cN6Owl522U0Y35C67t+9cYz97xkqvigKw?=
 =?us-ascii?Q?rD8r5vmvTVqhI+gyXgGvocy9pbxj9z6qsXwmGq/3w3nVEn+ytCtwedFDj/eY?=
 =?us-ascii?Q?iUfyWlvo15oMf4evu7625HVoiMWOsH8p2p0v2YYkqUehaL0RoQ91IidcOkGX?=
 =?us-ascii?Q?mZ8FXUpaGoQ+PhQRHkiS0JYSA8sJxtXVPUZZcmqhIdlYLaSSU2joOKZhb8yL?=
 =?us-ascii?Q?RXyCOk0TisSbXnSIG5SO5134hoUURVFR9ZwXDZizro5iAg1yMINzraFKZdJg?=
 =?us-ascii?Q?Zwx47x8n5AKDPY5pEQsGPhVbBqp7B3KhfDxyDlOvAKteMBj7HGPOLSM2hBaQ?=
 =?us-ascii?Q?/55AipBsoRn4efDIJhyG7eoCPgrETJU6bMFUfax6J8E1xf9qBOJSMNOH6UGJ?=
 =?us-ascii?Q?yHWaG4MlEGbqU3R2n//0U3SBG4kWluI=3D?=
X-Exchange-RoutingPolicyChecked: EVkVz42c3FDBSInjVt8p32866+WqlY02dRLOXRvptCrMjZAAFhqq1Q8bnFbk+WPQAyU5l6hq1eMRTQ6A3aSnm9ZzS6MbzsHZ2KPrn/bvY5uJmsNhLXtjzDkRfyRjMK8+J+T8bI2JOO4pF9BA0h3nimYq/LzUwud6qPEosXSE8FnyrQ2t9dmhOOMpU6jAAr9S6JDkelmv1yBVJZ0WypuCNXS9JcVDVPy8XufMC3L4lPGHC2zZtrTtkj1FZT0NJU3sexQZBKFXXq+5hS1QokXs/LnFINTkR8Br1tM+O5x2f9LQJWyL1tEL+L6whudvV/bZYwagu69bN8pZq10MaIJxQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2171a461-1275-42f3-7ff0-08df2aafe851
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:31:51.7794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifg+3XkDdmLX1KKIFUTjDZ/MafBP5waW1FLb+YvdZ2k8bzj0jFOiEfkIteG0i8N0gsBpOM5/OvIFWMsX1zDB7Jn+WCNemEdhRcYSdDBAsHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
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

On Wed, Oct 14, 2026 at 10:50:19PM +0200, Thomas Monjalon wrote:
> 13/10/2026 19:18, Bruce Richardson:
> > Patchset applied to dpdk-next-net-intel.
> > 
> > As well as the arm build issue, I also fixed a number of checkpatch issues,
> > since there were a large number on this set. Most I kept unfixed, since I
> > felt the exceptions were reasonable, but please check what was applied in
> > case some issue was introduced with the checkpatch changes I made on apply.
> 
> Unfortunately it fails compiling on my FreeBSD,
> because of an internal API included in a header included in testpmd.
> 
How are you building for BSD to see this error? The next-net-intel tree
is building fine for me on BSD, both as release and debug builds.

/Bruce
