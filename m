Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B6606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IG3yYIs8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85948400D7;
	Tue, 27 Oct 2026 16:19:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id C123F400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:19:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793114361; x=1824650361;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Db2gWP1EsVRjMvjkXyKK/34/48SnjpN5jm32Xonrnrk=;
 b=IG3yYIs8Cpua0Uj72AAUWpXfzlTSvQ27oYPVfOA4r2NJWzl6tZNr0lXp
 TszCzRArV4b6BHcuQ5gWnrUjCYmBFNjwUeq+toQDl1y4M+gmLuZPlIeG9
 wAFJLx/KWLGLIgaiHZlsg1OHsJZG/qfzQDuxe7TVZcx2jo22vsVp7uwQY
 FD4S1pUoNO+BLLsGsaCB+/a4/4539UU5iQdvUwdNBri2z5XB9Ahs0oOqf
 UV47KIbiSUrV/kQjNhagDInDXqwec3HK1ZZjvmHcpB3vC45zYS7msOzbA
 e13a0xBczCdsXdijWBfwYjLuL1TeyRLpxhHQjFoYmjhy1jO83dgqsT5RL g==;
X-CSE-ConnectionGUID: xYZMzYtERxmthOKgf7RQxg==
X-CSE-MsgGUID: eNPPLEElRm6Pz9oz1hMeYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1691534"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1691534"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:19:18 -0700
X-CSE-ConnectionGUID: o+4dw61uTwCcXgBiOlukHA==
X-CSE-MsgGUID: eEYnWNhyROuttoKvtgz61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4575661"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:19:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:19:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 08:19:17 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z35T4oP/nLIQlrOdvu2Jy0RxmxeQX7voTEUSDRbiBK61A/U3XJSl+PWnHq5/xiUaBlD7KZH1MKLb6PIqnkqs/eIMsDrWM3e4oUrC7TEtfcC5dW3tlcxJ32J6xTsVscfQYXPoQ5DptoOV6vGvsYp6j4vBsUNoTQTP1a4Qw7xrpslOkVEBSK8PE/yDo1PNfsLPngyMHSIgYftptJF0DqaGTAORsmIPsHSexSIrQnu04/qlv8B7dvebGnboWNOuYE1qGqcPhS1zNw9cexLU0DL/bnPlEzNflm1OUV8rpqnSueB10WKKSwwAQbjtpIvDlhJvaZfCMgHbxd4GP6RpNxUu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO9fN1y4guGNyRn0NGeo7/x6u/uINX859RCudvA92iw=;
 b=ybw5pLebSCwc3Q3i+Y6+lrdgI6HS9DRnWo8ZqDmqCxsUiNVfxhWIlw2Y2VZj0ner08AOXoeZYkQf12z8yF9QmFUwKBOtL1HeOClXxaYxI26OCY1LvzlTotpSZdodnOUQy6JomT+NF34IkqJHIza+7zcVLLGwlNXzfm4JagWf1xBcwC6Xp6N8xByzzTd/qw31Uno9Mj1LMrC35pcPWOp/e1WQt+CrLPeaw2o0DSi/cRe1HwiFJg0FQtcf+Y8BosUsT2Q/BFR3CJ6QEdiEUcdqGP795AGyaavySpGrsSRrg03suxByqYjnKNEWyradVxxsIYRktZ3NO7Rn+Wq1dXUjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:19:15 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 15:19:15 +0000
Date: Tue, 27 Oct 2026 15:19:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 6/7] net/ice: fix FDIR resource leak on setup failure
Message-ID: <auDA7B5QIiCdBuWh@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <1c65a7b85cc16fb3286db9eb022521e177c4e241.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c65a7b85cc16fb3286db9eb022521e177c4e241.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DB9PR05CA0024.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa49704-6037-41ac-6633-08df343da8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|18002099003|22082099003|261026140227099003|261021121427099003|56012099006|11063799006|261021123027099003|10067099003|261009223027099003|261022105027099003|261022113327099003|261022075727099003|261026121527099003|4143699003;
X-Microsoft-Antispam-Message-Info: snRPODGEqUNyufdupcibv/INEdyYmUKpAhjLJV1d6ER+Oaw8QsgE6FDZf9exAFHRe3ikDcYICYM4JaydnR1pt+Yj8v3jzj9BrodUe04LbCC6dis1OQQe4TTsu4P+f3rWuitLi4cLJQ/9gUZl7P/6CVyU/IQhMqs9MdKs5CtStwHzsOZ83rBsX39ZCQefx6XpOcqx8lnVYPpIT6fOh2P+9G+cYWG18vez/otShMbQXs2PzxmRXAnPEj0OneIQNmg3msnEscuAuCYx9vaooLxhB/LFlEMn0S7J79BM1jsZj5nV9xzMGsum8dkZLUqk/LfBjDMAHT+YtIsMEex3YRTT7v4COt5PnRWXosKqrnhFhKj0db8h5rcyX2PgASop2UV1igVNOMnGe/0eta+UteqaCWTTZKd1p1uezj1U6Z37zoYYEAJIMbl6k4XYCu2Pz4l7lTvOqGXmlVDloageNtIWvNi9hUkdDVayEWvQ6oZ9yH7g0EpYo5QI4Y9pO/Nl1ZVI0+TGv4OBVlV1cKo6fo5fQnMK+BkbYPDEKdxzV0sKrNb2P8eX2hIy2s/MwP+gdtXM3Hu5/eU3G+fhWVJgI9NjzVi2vNFzRzlNBMOB2yeyrgpCsTqoQRozJqMVAGw1jAVtRNF14bggukWMO0GpQ7W2xIyM3VhBU3afkfvVCxENDmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(261026140227099003)(261021121427099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026121527099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r6PbDZ+4uMOgjqzbGLT/dQ5vyWPlc3fMMeO9U8lpGgmwIYl0XhCQIWLt+/Yl?=
 =?us-ascii?Q?CQDEVRwKdvpEgkewkXrUbPWr4aq24huPLq80J5AWxgx3Qw4oBoJrW+LRTwAL?=
 =?us-ascii?Q?EIHVf9U5eH0JBmQNqUqmAPZFkrlQmCbWJO/QoFwzrntLspPyq3z2aVMKSnlc?=
 =?us-ascii?Q?yRJ1phpiGfriyLghT+sykhnN4BvKJHFdsqVTc0XjM84fSb7WTRG7tyJE9hYR?=
 =?us-ascii?Q?I0P9bxbNBhuWXaV1aVRNO7FbbgIOzJVgyjYdACs3rZDZovXRxXsTQHFjfboZ?=
 =?us-ascii?Q?5c3zyCqOdHufF9STL2rtLKGUsXO7yil1O5Hr2yPcBjCD8abcyRvcE4uGHZhP?=
 =?us-ascii?Q?s2kZUfmkOASBo1VtLLIHcAEHXSvm1+C0s8z7gCfsfs2a0iA4HNTLMG6o38uJ?=
 =?us-ascii?Q?f4f9ADOM6sgHZTmJugwxxSISLP3fTywSU7LlUX9qmKwKjJdOtyCay9OOHDCD?=
 =?us-ascii?Q?W1p4cIXj3f2ld/RPNa/We8RRESvexXo4ohshIiUYoZATeCEevgC9wWKxy+4V?=
 =?us-ascii?Q?JKh4g3Od2A3sq08KCv+YERamu4Cn5cvAemREZ9+kmufG9tnz4Mu39pMnLskP?=
 =?us-ascii?Q?i1O25MJAktQv8D8+Ris8Kr2pEFak3MtLbRZqGGt9KHUsiK/A4Wf2ue+Kgk/0?=
 =?us-ascii?Q?aX6EniuSddiWYNnoh/ZcGDpoQF4WgPacyj0dQi0sZ+PqTkaWVXhuntAjlr1R?=
 =?us-ascii?Q?rmarW1cwzMIXJ1MkvDxM2U16PHoTiaR1jFVEm6A6rHIPJE4IMQlqflEbEVJl?=
 =?us-ascii?Q?Jltjj009n04vEF+Maa8KQSG+wQFGwElukzs3ao6L50wW0NtPbZRYQrJ/BI0V?=
 =?us-ascii?Q?fP1yRdE6OY94zfheBuEp+1hVVixt8v96dN27WZKlYyapPSnKASEgoNZb0MIa?=
 =?us-ascii?Q?g+Fh0LiM0DiBFcQBDAQtz7FnM560H++0Lwv3oHUgTr6vhOb3XX2p1XtqJu6E?=
 =?us-ascii?Q?glCGtYOILDJp1SYdmy9jCwYmIlvvQcIlOs6FbOLlQmJmU2WhRNoJrXzZ3rJ2?=
 =?us-ascii?Q?BtMv9rS1GukAhmg8mkZB3fHZ9LTM29Ns+lr9tGj0UL+1iJGRPY/bZ6Q7GJEw?=
 =?us-ascii?Q?QZJotD2j5q3Ag8VqXUW84CH3e/F+N/EJP1NDmYyM+FU1fx3h5BQJE0AvvPDH?=
 =?us-ascii?Q?c+iC/e/hxp7SGOOyJRciVK931qsHTkLaGUiwOgXUmA1ngPMbvHkL8ywl2v7y?=
 =?us-ascii?Q?SCJb7Tfy7zRfWXhvoB+7+BoRp5xWZbTT9HLr2OTr7ne2svdoKfyUh3KMVrVw?=
 =?us-ascii?Q?0jW/ta9aL8lfv5STK3ljGlx0CQIHZHBdtXhAPdOV9vIdaVkNq4XEOSmtmaEy?=
 =?us-ascii?Q?mqG47ES1blqjUYdbS0eFy9XSWMc4NvfShx3Ptgy22zEetojYgGIi18I9SvND?=
 =?us-ascii?Q?5joGf/NTza/QwIex5kVdIP6TLMDX785Nz3yvp1Z9MQYFdyXPL9og/9grB9TT?=
 =?us-ascii?Q?TpkivVptMI4ynDWjaj8wR3Q0vAcWB1MbpHfKdzV6Ym2I/4gBqOtxQFhA+Wnx?=
 =?us-ascii?Q?BcSPwOXKbE77Co42ZUd+o9Uen1L2flAclo+jgmQ06f/v7c9q1bDUplFlp2vg?=
 =?us-ascii?Q?F/N5Z6AIRaLkBeP2yphp1uA19zWysDU1FoYW7XO6VjEyUfZHALqfsUDWl6s4?=
 =?us-ascii?Q?I1U4EVuhddZNd6w2MB0eRaGkPDw2S0CLK7PUS6yEeXcoGe12d4Zzm0nATrjN?=
 =?us-ascii?Q?9NYBayYXL95hc9i0igk8Oqg8lH5IiLKJSY20y2YdJEjrXNGscdVqdAMS76QX?=
 =?us-ascii?Q?3JFCU9LIw8WSluymJsyrLLRGVElAw7w=3D?=
X-Exchange-RoutingPolicyChecked: BBiCJII/ZwqlORk6NWP/181Ise8TWG/EHo0euPbnMJmomhM0Y/Yq5bj3V9DX0qzA8UqhoK5eEWcU9ulV4Y7NR8odVv3ZUKUt4FJjNhsAoRfXsr1M7l/J2vESAkrH+PvqoDzOkOAQxRcbRUzMr3SuFeAzOj7Sb8dCD3i3o3zsxDEzCqifhabW+eXQxRis02PgK4yjelUXdvfb5jAJKJ5hcliAoM/JpvAOfCa43D8BnwZak4I4LBSvwHTjSep2v3+i+WqDofwsqSaW6+xI1B6PP08moc7HQLGKDn+MJssN3Vpph3H9y40AUR4+XaupezNmV2hM11sQe8mBlTZATS9fKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa49704-6037-41ac-6633-08df343da8ab
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:19:13.8476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rARfUARfousn9gJbG4/ANtQj81HYD7d44wxyjXyNztLXSdp1XIQ/5S1mxC0cRa8Pz0erv7cK/a9dcW/076U8P4ZebaCssibF3awfh0VC9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:36AM +0000, Anurag Mandal wrote:
> ice_fdir_setup() returns directly when the filter list or counter
> initialization fails, leaking the FDIR VSI, plus the filter hash table
> and map in the counter case. Its other error paths release the queues
> and the VSI, but not the hash table, hash map or counter pools.
> 
> As fdir_vsi is reset on failure, ice_fdir_teardown() cannot release
> them later either. The hash table name also stays registered, so the
> next FDIR setup for the device fails.
> 
> Release everything set up so far on all error paths.
> 
> Fixes: 1a2fc1799f09 ("net/ice: reject duplicated flow for flow director")
> Fixes: 0f880c3df192 ("net/ice: add flow director counter resource init/release")
> Fixes: 84dc7a95a2d3 ("net/ice: enable flow director engine")
Cc: stable@dpdk.org

> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
