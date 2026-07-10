Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C5CC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 14:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B36A402AB;
	Fri, 10 Jul 2026 16:16:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B3D8E400D5
 for <dev@dpdk.org>; Fri, 10 Jul 2026 16:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783693004; x=1815229004;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=KUNXPpau6hWKFplv3UkrorMMBJvR6at8O1mLmEiNduY=;
 b=ily+El8nxDvNL5DNUEkeFk/hqYaxiY2Ai9rY785kCKTT40XUnPkLFTO8
 ZW1uAwuX/4aU/ZriZ4LIPVsntFYV5c9x5h21D7KVEu5EsMyVHL8vCsgs/
 JLDqUd+xRwU5AcM0aYBz/JGkwyLlRlWdguh+XOqbyyCI5F0M/7cRvSIgX
 1yhHTtnMmrpep1+i826O2+45ybvfmhNCv54tYj0BqU+dJ5FPG4bK8iMSx
 kVPbk6c+uik1wCVZ8kqbb373nfp8bB6RJwmqfXmeA+9w6cvOu/jU6d15g
 a6k5/gJ/Q+kVQX+VCgqIgJ+JEY15zzGEdVAQqk61/A/XDhX6aYJcpGFJ4 g==;
X-CSE-ConnectionGUID: TSQGQon0SN6nn5oYXxSflw==
X-CSE-MsgGUID: 8Sv+b233Trygax0D3tZJfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88302996"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="88302996"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:16:42 -0700
X-CSE-ConnectionGUID: RttYVDyeSJmMkZ8te7/DNQ==
X-CSE-MsgGUID: km5tC3beQOC4OcH9+sqOrQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 07:16:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:16:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 07:16:42 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 07:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDxLdHP2zv0aiIjxt9dZPnaRxTaCS9w95NXUw4H6aQXkgFYWzMyrxaZM8joIFjoYpyppjDtiOr+WHNt0HKb6xR8AjtrCep9x6JtLqzNDhaqGT6ehca4d2WWenP9SCAXbCdGy5B6lOnd4fjpLZ+k99Jpk52FUIktBHBFjsroe1j3ZdHjH2yZr+yGZ5QsEYgRUu6po0GaOzA2Xsjxw8nyv/siE4As7dj9/drzQjPIbw2duQ0qJ76hw5xsCcWeRF3otb3E99uODZX2yVlfYGcFbmxl/el71U4dNJh3ttoFoQv3t/5cPbAXpHD1BuRwCZh6bLQbhWxO1lwO/SRH0wzKb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDMCWCgAgZgPrKmbLGy6g4jKuaepr0Jg+j2g2zSyyDs=;
 b=vekNRcJmzvj+ALh6qZ+iUe2belRB+9iRDDKnaNb/HNhtVSWOxeTj6puYb9GnKFzqQdf6MPXjs1E29TxoQM07P9dfhZgiBCi1I2N2DxquUy56n/eeoDfyu5SKaRZbg56Bx5vegC0hiIf4Q5FycHwgVE+miqqNWB5N2uWls1UX5qrBh8aYHWJCtn5Y3BLtG6VdSvcDgd5EutsQNGUZBisasvArYaX/0PteJYwfYF8Hxo0aN6AaLZOMVmF+hvk6AtltvFi2/A4D+BR3qN3qa3J9o6Lfpo8NQqOFcIErYUSu86qltpHokQy4t28lBfb4ssUQ3U14UQq9Gwy033DooIwokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 14:16:40 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 14:16:40 +0000
Date: Fri, 10 Jul 2026 15:16:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: check for NULL pointer before dereference
Message-ID: <alD-w9Fzz2b6pk3m@bricha3-mobl1.ger.corp.intel.com>
References: <20260710125940.1572978-1-bruce.richardson@intel.com>
 <IA4PR11MB9278059BD42DC2B3CF4470DF8EFD2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB9278059BD42DC2B3CF4470DF8EFD2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SABPR11MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc0d24f-8e24-45e2-9e08-08dede8ddc5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|3023799007|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: i14eC9yO14cgtJcmv2z3FhHIAqkyJZ3xbWeG/UlVIoMx8/ZoNyEOdVGkrXTREXgA/USwFCvGL8dq3kYMCgxs/OT6kGiVgghzNA15SCX/XgE3NegwOCHRtIUnC/Q8iC0D/zpvSm5qPRMXY5Hr/a5IGPAP9KxX+tUQmcfa/Yg9F+KUhlr2oSc8+B/X6Hs6Pck/UT9w6fADc9Ak2plD/T60z/Vk0n+wHJVKuzeOhCYy26FaOHPfm/KD7W8Cp7K3sONPrVQt2QUdovX4I8U3tY54plWEQ+BJAjusn1nwcy57zpliVq0pO0ZVBzKv3UxkYapyuQlJTK44R9tBbPo9Q2OGJb8/ElepN9tiT0gY5NWiPRb5/T74Rx0MwxYgs7lDQuzWRJ7+aNzpwO7STwzB3D6VARu84kQ4wXUQ2kOYfXR3bC54sbVSVHuVhY8jOo9lBnOqhdcWFtr8r+ry7dfpxSZvz0RjIdbnDePlNsUSmvjPiy/ara07t4Epxhda7x8m5a3GsUKr6f0LdUH8OCFxQaDB+PLqh1My2QCXyGEb/j4I8ylhlwSx/atY6DZFCuLZeu6IzhcV0GjjFHf1U5qzUg22baZ19igVAfo82vgJa1KJJOjDWvRYQKymKgCE1Cr7g7+d7a5FuWLVUeHbQRH1sU3S+/T4AbbBtusEFhft0hYIZBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uyZmnPt0ncK3iXrxU51v5FRcAsE9Om7IiXd7Q/m5skGpIOXuhJMtHy7EGnRF?=
 =?us-ascii?Q?Q/E4rSBrVhB+MALfb3crHOGg6jUxl3mL/oSDFVYnMKri7NPKeRHY06ldyN0Y?=
 =?us-ascii?Q?U+7VH1vFjyH21DHnX8gctIQnt08QUWx70wZBmkPyNdfe0DJutRLbV7HV8TAK?=
 =?us-ascii?Q?5Ut9o34OvU9VuEcyNYunIGmCImjsmL2cGnFWDYL1+Fy8WGMpBmTkTy7rWm+d?=
 =?us-ascii?Q?dDsFTUSzc8zJUDFWtKnyc13HCeHQjweoOE8g565OPwQvjWl+w6hL7YNojt+O?=
 =?us-ascii?Q?0koIlJfvjp2rH6/AAdWlyIZEPKvkpgCwRnnCz6anP7X8PEB5vQwlOLHlEHjj?=
 =?us-ascii?Q?nZFsaOWiGIigjlzvuDYPVVu+bQz6DRMTWsowbjT0NTS0TfXcrDv1DmQ6ijNg?=
 =?us-ascii?Q?gdp4/Ydj21smtvS6d8UaHsszwcZJhZpPyqz5Rh0aGi00aLTkvKi/ZsUiZ4tN?=
 =?us-ascii?Q?vDu/oDCd3eL1GDeYQRL+MaJlVZe96Q9MYE1eoOT13OdMBALoIVNfI0NnrrSu?=
 =?us-ascii?Q?gjKtG/0VTTDBiAvGikK/KIPNvJXoGnBo1x7IXZShU/+qwoAGey1p9g6t5VOP?=
 =?us-ascii?Q?ZCCLOfSuxkHHJ38uya4jyX/bqWTAl/3uwh5PjK+kR2q10iuW3T9X1YnEnJkr?=
 =?us-ascii?Q?RL82LJoLI98i7yoOIZoriCHFn2yHZn4W3V/3Oba9+T0Ms74s71dQLXIfDbWO?=
 =?us-ascii?Q?EhE+0gksJu5odMPoOw2OobhRxhmGRxuFjjLj+/VjfyRQIvbkDRJuI67DfFAC?=
 =?us-ascii?Q?WU2KZ7SN3k6IielZ97nVdU/fWRrsJJ300KvM2YNcUqqi64CrmX7mDM6EW42d?=
 =?us-ascii?Q?cKzCyGv5TMISGt5P4kSYtqCYpYEBtR5cdeB2tUIuXrIc62FMtcdBBEMPtI9r?=
 =?us-ascii?Q?VvK42GVGz4iZrAwtnJm9nqDOxnOZ93c50ER8veWXB2Xh34dEO3tdeEXdbNpp?=
 =?us-ascii?Q?3HfJCeYz4Rw5QlGd4Bi3DFJTjWEjQXnYPUFgiZ0JrAnuXecKK9iVczTcqnXc?=
 =?us-ascii?Q?0SYl5bNViMPotdQC3COaM6ShjOEQ1yWRnZd0uJ+wmhrOW5JeN3SgWnetouuc?=
 =?us-ascii?Q?RnRiU8wIbwlF9WnMu1cY8vMu91K2z7v7VDnK+Ztz92NL/j9eS9JvGdAe1q7p?=
 =?us-ascii?Q?0Hg0M5ZMg6KxnclayfeZDPj8+2E1Nt4fbVJ1o0Rf7npFhOcKpbtJw1NKIeWt?=
 =?us-ascii?Q?av8b/2LdNT39/WVSLKtp4glVyibfPUUI3gIpABh4FSjEasa/HuyF+uqC9wYX?=
 =?us-ascii?Q?qBDsPM8UQqs5zGQ7FDdHsqlLUNFbEMS092L+3F5LDu6YAOKPexsxDzHxtvCv?=
 =?us-ascii?Q?xKwNdVNvwmwsT9IPrJtds81a/a82tw0Ks1KK3nhn3ZppFeSuKPnXpFjBmMaP?=
 =?us-ascii?Q?3icQHJyfCa62CbGsrg6cXQ9OHT7aIpaA8rGVgKYxTtA0ABNLu1VdKdlqK6v5?=
 =?us-ascii?Q?/c95tCfzRh+YIppLnVBvjN8HUqjTdtODZebUWj2Syf4TNTze5uiCV62YDAVS?=
 =?us-ascii?Q?Dr5heu7iPqY4g302rK2H6xJEfR0NqIWUJdXr1ICEcKpqSquu8oist+C8AKYS?=
 =?us-ascii?Q?tQ3zAXVP8Dqt4f+iLYB0ueNDHfItpZcb4PbMaDVIoFHat5LRaqUOU7oEGlB1?=
 =?us-ascii?Q?g6LC+wJ7MmHo3P5R7ENAjk2ejZiC+i2uZSJO9JnVpD5TBvNlddag3T3f47ap?=
 =?us-ascii?Q?wJyrWH0EwtkblaZNj5ZnsOXEUkdTxvuiy2diLLeDAD0MA5dfdCXdbDkZVsMN?=
 =?us-ascii?Q?ghX2rXwwWUImGlVEQhSj3yKXUE8dCTY=3D?=
X-Exchange-RoutingPolicyChecked: smbAUo8/omEg+wHzSubZNAHSOO6tVgNd66VbfCLmCwkPra1mXoRgvN4G+W4+xskbkllufIdK26/b5Pu9t7yyVY+CxH7+qPFI49tph4onggoTM1eCizJVAXT68DY7MF+gQN2U/qv5bpRyk8zLwcPvF7MdfrOn6O0VZk7H62zagoGNHtNWw38jNMvtb0GWY3hMEsk7MvNmQJz/iogBtEzFyFDY5V/U7izFWfIkhof9ificHcpM+s9ytKFMffldaaJ0pjZXTFLAaaOb583Y6sArmChioSagMHYFqQ+9/R0E9Fj8V9kZk+V/sivLJOCuVb9ww4N6l2DajJiad7f4ayOfcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc0d24f-8e24-45e2-9e08-08dede8ddc5c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 14:16:40.3580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms+F56JWrxqeQQAMCIDybDqOuXnRYyVxVvXreGnbM5/Z9vF9oV9MIbpU4sjBUQ0gZo2ktTgyBGuCTES0oYuRseXjhy+ZZgEm9WQD6TsmH5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
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

On Fri, Jul 10, 2026 at 02:19:34PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH] net/iavf: check for NULL pointer before dereference
> 
> check-git-log complains NULL --> null
> 
> > 
> > Static analysis with Coverity flags a possible NULL pointer dereference
> > of "hdr1" when handling IPv4 or IPv6 fragements in
> > iavf_fdir_parse_pattern.  This is likely a false positive, since the
> > flow pattern protocol sequences are checked before this function is
> > called, so all paths leading to a hdr1 dereference start with an
> > ethernet protocol, which sets hdr1 to a non-NULL value.
> > 
> > However, this is a rather brittle situation, so to prevent any future
> > issues if a new set of allowed protocols is added with IP but no
> > Ethernet matching patterns, add explicit NULL checks for hdr1 before
> > it's used each time.
> > 
> > Coverity Id: 503768
> 
> "issue" instead of "id"
> 
Fixed on apply
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 

Applied to dpdk-next-net-intel.

/Bruce
