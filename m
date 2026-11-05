Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B20606A332
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJWf5nMu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7AB940DF8;
	Thu,  5 Nov 2026 15:25:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTPS id DADBA4060F
 for <dev@dpdk.org>; Thu,  5 Nov 2026 15:25:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793888726; x=1825424726;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OzCChspZoRkkUeyJHKnXVu/Qn65BuBvlARWqUGlE+qo=;
 b=ZJWf5nMuCuT8j4zpRpw5FGlzm7o3Vfqo7uuuaEgYxqE7fyI5ZqCfkiCh
 hrvXeCDOa1eH0n0eYn8DlQvD8y1nDEXfzZhfDKOKA/+TCeyEm7VtXvZCB
 nX+SGnRG/4WGo9+GdYWCzD2tYhv/oxIbiwNSE0ABtJ3ErJjPw2fi7WUim
 BU04UN/fx/XWsj9BzZcQ5qUNjFFSa7TeHXvVNNbQc0g8NOPNkNCRQ30HN
 4U33IJP1r/+0EO6GCQv0dgRHx7XuK2ORg8FOAF4bDvWDzvP7Cqt0rNB+S
 fm68CCmPy+GsQHAiDeo+OLLPMGuaPDcJb20GnbsYH8u+wDkr/TD9qUevM A==;
X-CSE-ConnectionGUID: JgLOgEmwTkq6Q0YMtMWP9w==
X-CSE-MsgGUID: RH+niesATZyfNklD5ik01w==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2703366"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2703366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:25:24 -0800
X-CSE-ConnectionGUID: gfcEHDJITy6E9zXp5A4zgQ==
X-CSE-MsgGUID: /rtP0TQ7QjOLaO0CHBHBYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7192887"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:25:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 06:25:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 06:25:22 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 06:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu0Xvjymkqqe3ENsI3hrsKDuNI6HIm9U5aWMqXEFyLTaZ5u+xMnJ7AHPV9DX2myTU4VzmDpbM+JIUeRanJqagsHxU4RMfxN3upbTBtk92NqPA/ohONPLlb3vjL2EALVL5ZX+34DRSMESx758o59oQRVMqB4ODQsuiHzpnUuEkAB5lK4qFzcXgdTQwZQ4RG/KDgWs7i2pqh43Hu7tPjmZm0ZpeX0jcBJsNX2S0Tki1G3E+4Wy2s+vBrDInRTNkHluMFc+glypnHBXVeQz8IPfwDDRO/ERMCnZXiOcehwaPAwG/kuFWjT5xkWYUvjq0BZCayDYdBU+7PLdsf+zha0DiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5Ki7i3cjHvpmfmmgaBBCMXAo6MuvbwJYV3107SmScA=;
 b=hO4/Hbyw89rxHtQINy06b9CLjMByNamPCK0tp2yaasjCn2cy2ktrr8+X0auNNxNYoksAIVzoUUfPTAK7/e2pCNbAchfkwwL4QD6NITq4th/u5MRxgkJxizBjTM+8mQxOlFnC/QQqYUMPsweTBKtkYCl6v6UMwxK4N8dFkDCCAEHRWVAlAUhhk6QiiPbn/Q0j8/+Llkfdyq8QjnXPiB6jWy/CCdtD6ajt9bcBDzHyhqX9gpB/4Y6pPFzEzyrPhwU5WRFEOaIMIef9cl7cnTwO0hIwUccuaiyLp36dA5r+tlZMNRxkGDc7mnKhi9EzJ4v7L7iZsmaOpimAufcXnMgiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 14:25:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 14:25:20 +0000
Date: Thu, 5 Nov 2026 14:25:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH] ethdev/telemetry: fix hide_zero parameter being reset
Message-ID: <auyRyzpa_2GXDbBS@bricha3-mobl1.ger.corp.intel.com>
References: <20261030034157.49080-1-fengchengwen@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030034157.49080-1-fengchengwen@huawei.com>
X-ClientProxiedBy: DUZPR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN2PR11MB4677:EE_
X-MS-Office365-Filtering-Correlation-Id: a06ed7ff-f169-43ca-d0eb-08df3b489f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261021123027099003|261026140227099003|11063799006|56012099006|261028144727099003|261009223027099003|261021121427099003|261022105027099003|10067099003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info: njCaidXjyXpvqFbYTYUuaYFxJFkXToNskbiBAn1fBQlffidCBVZATi2OlGgOy5aZQaA/PFofpiTBjqgEQM2+SRfBVwc9/7+vLo1FBXBM82kLqibNbT8A4KYeVTD2iDypuWLjxlVIAHu+UuVnl1u26pGJhJL0dHMHzMDB38Xfv2JwiVnDpjMGRiQa3zJlzsQxIdEdbZ6ofKZOZVS1kTYDYQussYJL5Fk+hYgkNy3sILS3tZxJcOLfxeSl8FasM92lMa4dvPNkSyslYsgXENU8IZlfGzkB8XGT8ih8OtJTeryrA0Iyber7IHZxa8rqeAYgH3QKQBJGoLOWNIgXAQ+1L711+1Gp/EEqQYzswchVv4vxw+I39w4kIzWlGa6VjF6S6nx9bQqUrpKuc+iCC2+l/pRFPAYtxSFH6WymoXsJ8Z+1CmDALwy45kadjzr1UGAuNTD+8P1EeND6EOkmTc9Rb4RrA9seFMGfyq3x49VlKhFfnJVvI3zk/A8i4S80TvmWwbH2JR+m5t3DtJ6XFcIA1F1xsbUR0/7owtYSpz5Fm40ROj3oU3bA4nMAVxlV1/LqtKI/jDKW9pDJjzCTIzof2XohfJVOgGxO+rCJZ+wSgcyt942pYglrcmlKrHZAoeOZ1dY7yPKF0q/9wmFa/pBXm4nPUfzR/z7La4q6gFABdhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261021123027099003)(261026140227099003)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVxvqePiRdWfr6zBlqBI4CPCXq7iS9RNGcKIXwkKc4KS7naiQWVMcNwfWKU4?=
 =?us-ascii?Q?6gPaBjhAvNfo7aaaJTNfIJnUtY43bRaHGJPU1g+RWQ6WN4z9+KMtOw0HMvO4?=
 =?us-ascii?Q?VFEQzcxY29rK5Yumxrl8JHsACUJe2lPdnORCyJYdZYfDW2e8Cp4mZHv10RQ5?=
 =?us-ascii?Q?O/aXhaXwuEdNPywaBSw/iISBRgYMXAngtl1x4Xw3jDNmGLvptZsb7F0vbchq?=
 =?us-ascii?Q?LmatdFx/wgG5ytRq30dvo1WryT+Ap9WQxPUsgeFNsgdJ6ZGiso4iwBhUlifc?=
 =?us-ascii?Q?TN8RLVpOKcn/diPjbC44KeO//y32j4ulstW6rBqitEF0Waj/AkuVJGE2nSy4?=
 =?us-ascii?Q?q7gAyzm7kMah5sy0dRlztrhUw4FygwnGsoGvFevWQ5VWa7CsAjiOFrpfD2+h?=
 =?us-ascii?Q?be5d50BO+HHDRPbgraU40nRTCcLmBiKFkndpUJ9GnoEKIHK4PZydv2jW6MdZ?=
 =?us-ascii?Q?ywN7yrxuIgm87zNig/kENoq37dTkWG/ZwrBpnuB82KXJ9+irw6E+lpFtKsbU?=
 =?us-ascii?Q?lrQFc6iqWaHVOgT6tBMsx/PpbeNXpW2O4Qp4GkaRWe3JKr1UZNxoEinrZTjx?=
 =?us-ascii?Q?4UGjpfgNGJeVeSnOTyrax3xq5oEIHzSkiMQuySjk2+eyQZLToFjZTnLRISi/?=
 =?us-ascii?Q?U3PgBcgGRh1dA3AVTolvSaoXDglg8RoGqiBWL5m01TXG1gzpUVw4f+syeyea?=
 =?us-ascii?Q?agJRVjkkHNrKG1fZo13RoF2Pl9L9j/p+Lz2/AQuQjpOA+LNTlI48WYxv8hMY?=
 =?us-ascii?Q?9aGmjB+k4j0A1MexKMzX7NbVyrhS+i4pK89bVWetmob7jfSYvWxPQAHA3I2B?=
 =?us-ascii?Q?mwnUAJfDfYTRkoJk1KWO8CD/GgOZR6rIxMwp5SUoBulLSXXrdrpIFZkq7ty6?=
 =?us-ascii?Q?SkYQK2M2JR76yNOz8lCG/jxQQX5hMdCuNfADWb5l5SRgoExR5jS5ZRSR7GL2?=
 =?us-ascii?Q?+sZdCRu2BqSpFHmRQeDyNXomxOuhp/TPprCNm21OhDnvteyRGS/o8EPNlL3s?=
 =?us-ascii?Q?TiFfEf1wkSjhZU8ae2Q7uoewLNrZrjzmazO6hUxZKU3OWoATtuoDGfjexSau?=
 =?us-ascii?Q?NRQNZ7AopyuJte0RqJVbqEwH+toYkybX7drqsVTJiyqXljqCFmicfoeyukqY?=
 =?us-ascii?Q?DmIGeULFQ1fsYtAtEdEOpxkl920lNdkrbgJ+kkTmCES1jJ37nCCmXvcVbuvC?=
 =?us-ascii?Q?mX2yag7SHRueEIuaxwlBWOIrq85F9UlDfTi5dfW+4DtIBzSmny/j44ZjvAwa?=
 =?us-ascii?Q?3MGTzv8L1zbV4lzjd9Ai9QjcYuBHQTzbrZJwR1GtbiJ8QYFPuj1hwjdiGMO1?=
 =?us-ascii?Q?qIgF79+JF+86RZrxEGumQHVeAhdVoeidMW3lMIh6Q7TG44+ibXgjlts7g2KK?=
 =?us-ascii?Q?6DxJkc7ZEkePvg5T9psIcts0EJZ5SGC66qpXv/UweYRoVHO9EgAqHrmajX+z?=
 =?us-ascii?Q?kJPtiC50WiL6XorOUuFBMCy51xEGr0TEtDowLPkWn6PuBFKte5rLZkmzcj7h?=
 =?us-ascii?Q?PJgjJb8IvPVDmLO9xy4xCpZomySYy95/4IztOiXC3bjg3hYIYdz2bvZEVdVz?=
 =?us-ascii?Q?SI1j7cqj6Lruujxh8pkPUaW77tJIx5RStzhmNirHULblFUqfcswRqga6E/dT?=
 =?us-ascii?Q?Elp13jp2XuWYBOFY25TThWlCWywwjrT1RSllg1imPuGlW+vsAqYin6jpSTM+?=
 =?us-ascii?Q?p4+d9LObxdJucCipKCn6NcfI4+g8KsCWpbRDuVFX6u0adgqBZcVLcbBe/l+k?=
 =?us-ascii?Q?Fw+Ia8ER29HyMNNKnPpcHS2hqkNKD4U=3D?=
X-Exchange-RoutingPolicyChecked: SEANaGoZ/NBGdKhQfOmVFNi79A535wAOM7eZlIFw2lSvT84suJdanSNpGtjsHt0hZgo1XhksnZwoiB6TH3cbfKTLMOn3QCg9fqTP807IM88L/RaEwM28UtkfUCLml8sQ/P3yAsp/j/sTvErsWvk5rHofXXpxj4BxSsGBv2W8De30qmbTd3pjsC2uz/PaMy5XQP2PK6j+2BP2SRaWIBp1AVXz+plFjL6fNn+F6RR4WQWYboS+mmlM8cXBh08ztIe8HjQpl5oL3HFsIPLU9R9wzqfieufmALz4LkFHCqf2Ya6Pn1BTuP3KNQp1g/kFRLdxI+nFVEB3Ca6fAf6Byii1Dw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a06ed7ff-f169-43ca-d0eb-08df3b489f0a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:25:20.4401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9WI0KuBSmYp2vPg0oaNgr9GpU7DhNS6LfNRfETuwaCgEAkTFL6gkReh1lLzjKf03o8llZv1tyfXykviGrCrxLrsq6DDBq9WUF4o8MGjlQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:41:57AM +0800, Chengwen Feng wrote:
> When the "hide_zero" parameter is parsed successfully in the ethdev
> telemetry regs command, the else branch unconditionally resets
> hide_zero back to false, discarding the parsed value. As a result the
> hide_zero option is silently ignored.
> 
> Remove the unnecessary reset so the parsed hide_zero value is retained
> and passed to eth_dev_get_port_regs().
> 
> Fixes: ba4d57bd849d ("ethdev: support hide zero in registers telemetry")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  lib/ethdev/rte_ethdev_telemetry.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
