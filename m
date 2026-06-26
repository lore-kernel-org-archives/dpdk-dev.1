Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A41CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:49:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 067D5402F0;
	Fri, 26 Jun 2026 10:49:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3713B400D6
 for <dev@dpdk.org>; Fri, 26 Jun 2026 10:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782463778; x=1813999778;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RMebVeNRGTe2ny4OhllKtjHZ10u8S1QYbV5bXCpGXjM=;
 b=QObniINrX0RtD9OE6dxidLYrL0q7pgoecr88EzGGAOEpwmkY7m5gW9uV
 AOkKAC/4s6UNlxDoZDEmkXEx5Orpq2EZEtH/MFtVBp7zKB+lO1TuoViYM
 peMKHrWOOE4ssQtvz0OQ78OtJOyq7GMYUBekeHEn67RKBx9R9qBBJuKUS
 VmnmKNxMH2Qm9XzvdjKVuzq/u+lHwttmVnqxLunjSxmLPdrL9vEp/PSaO
 l3eHAm15exsUmXp1+nNEZJyO52kBsHOYEfOaBPiuOmEH/L+vXNx11JZQU
 iNjvVBd9ZjYMTFCB+bpczjPX34UxjG9Ag7PvoFuBv59ZWjUQiSp1qfAXD A==;
X-CSE-ConnectionGUID: 7AZOxS9bT5+xDzhrtC9YsQ==
X-CSE-MsgGUID: cP/IC44MRpmWHwLqHCe5ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87102646"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="87102646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:49:37 -0700
X-CSE-ConnectionGUID: F0sxPrMzQoK3imd/WycJ5g==
X-CSE-MsgGUID: BBJiqO8lSS+TKaa2tAPpWA==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 01:49:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:49:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 01:49:36 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 01:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDvWt2AZ1ztD+IX4Mp8UVbWHnRtrLQWwGF8xF/w4wQ5gWB5Bzd+uIwO1xgdL8RJRYtyUOL1r2L7fF79asNBjdwqqhecatlgpt/2j1Ao0hAvdVWSUyS2JdtgT67/3bo8oXysbrDn+D9BAROhcVig9tLDZ89KvDLVKbp2LjWXjwLym1H4FjxV02gYXDgLFQdcXtalls48DXAlbt8x+95g5M0gs+8pmgoDhBXCSiDPPbkPaH1+UzDuWQ/bD1kAxqMiTJHdWKTtLqokwiar3hW07n6qWNJkeocSm0v8JNkfjSqAaQxPrdyYcKsUJASV/rS4cli50vyga4cUGk11NfMFMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy0mhoDPxX6sIbbwNLDqMAWlsfKdq19UEK9Ne3bPAnQ=;
 b=HT8VQ3TdXIQhXPJmpVe8X/ERxSRwa5R69kCO1+CTI9593CgD5FiXEOtzrfuMviPVMVvbhD1KAuy4xVffIjv7huDaPWjEZntS08Dvipyt5pP7UWsEbIPyM+lNPGE51JVKUp3zj6LLqBcgTC7jUN8/ypv06/P959mks/H1kA9XQO+nka/SDkoSADxJ0OiDY+IbX3G/kyWO4F0L2R+m0gz2rWb9/ZfEWnyojpHwK5GlspQs8jMm8uEYcH5mWePuxblrFhcgtmE5ZPsh1QzDdKkTKhGrsoub7xo7p/BHVtCzMVjsFWDc0cWyuq0mmbh9tEfTQ9VfulIM4z9rBOCn/l1Ajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 08:49:29 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 08:49:29 +0000
Date: Fri, 26 Jun 2026 09:49:24 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1 4/4] net/iavf: fix potential NULL dereference
Message-ID: <aj49FJuFHatZORQS@bricha3-mobl1.ger.corp.intel.com>
References: <c42d6f4efb83f4962ea096a702ed320a3d0a5eed.1782402484.git.anatoly.burakov@intel.com>
 <1a5ce2f876f5f707fd36eb3117486d326e6ce827.1782402484.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1a5ce2f876f5f707fd36eb3117486d326e6ce827.1782402484.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:10:234::29) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA2PR11MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb4dd0a-886d-48d8-79c6-08ded35fd575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 2wEzIMmqtZAUulUNMrzqJUGcwsZE8S/IqCanE+TLyCWGBg3BVwf52SDt+6ueSokV92tsU+550AukJtYS6Z7mor53Fmt1u2WmSNZ5TXmHugGcWWg3N5iS7s6ArKr7GaSl6ACVrYQ9axq7+CUNG6YAemNNpllaEdpH3RKqqPLXVR49Amg9Bl54zBEM+OIsjQLrVHnIC4OZGh9bEEsCq0GAtVp1muEzZ7Dt8GEPJXlW1/v0p/R2lmNY1/RuAdF+cA4ABvCLRGC1k7xCeQQSSw5sTL56HqK+xU2tPlt5xREZT9JbVT/lWe2zA51YZOfrlk4ESvVGK6Z6788yfU5U/5eCBHWDd76YBLVhXRpxRwhiXqDravE0PYqJZbf60ihjWtT5uIKqT7oFGlPEhOKGQokU+P/P1hfZlGmjD0ivVUmzE1ltz8vDt5xCI/Wutc3Z2VA5wkSgsGdHgvB719+ZbUZ5t5PCvaN8XkGAJHzUrnV69WYRjbrXoeg5GmtOtv1xCjSVubQXHiidikPV1kk4AU8hSM8zYkBCBO4pyf6TMVCgl3E5OrhOqWEHhSNcXCaJQ0tGXr8bnU3SBdxgbYfT2WVk2SI0yeKd3p1w82JvDIfmYzbMRdCIcuBxVW/H4bi6WFIPwxwWeDH7a6UXhoKrlUQfoXfyAejy8WniRILdMTNPR4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQNsLHj2YwKjbfmq7iGxnhUzmL04i/8qDpx8g+K33nmlrX/89SpbCnvHeNih?=
 =?us-ascii?Q?2xkR8mwaxl7HC0jXiDXXT60m4XnisryrRydP4xOQpURBeAWGUxOWwvwhCY8J?=
 =?us-ascii?Q?f2Muu67nmfxCS2MacSFA+tYhf29JczCgppsDDTgHkp9bEKffqm1hgXYK3Bbt?=
 =?us-ascii?Q?T8yj99/rjUPaZIPEFyH63uF6SLy1vliNOGAG97flAXMQ9xstcIEZxouIUvwU?=
 =?us-ascii?Q?I6FgPI/NNxNk6D3Cc7427kXSLA71ll6F48eX59uMxXl0B9qtyBOueE9EnGTG?=
 =?us-ascii?Q?u39FNVVzxkZehSVenY7OH5j+iShyyFrPu+ds+7jkyYkY6ohats4vZlMxI/5a?=
 =?us-ascii?Q?zYxC36V7Bc07d4WPULNMpHMNSy6yAsjmmHj4zuw+SoeZBpVTNn7CAKkvXC1A?=
 =?us-ascii?Q?LQ0knTMBlkGZj/d7GjgdDWhD4L7rRURdKxdwd/A1cP3EpV2Ge2gF6CC9FlWx?=
 =?us-ascii?Q?AZK2FCrrA+9RO2rmSwyd4HhXCsiHCkXpguzy/tYOfCnOFulAhG7QPS0L8zGP?=
 =?us-ascii?Q?n+mUh6LFt1Ji9g4N7cYWlU9jZy3KuO9NbblSh3WZmpKlVgtNZLgh6EGx7lcd?=
 =?us-ascii?Q?s1cFuJGPv0v4JE6ykSBPiriCM9MxToK5Dkl6WDktO2vL/sawrr3AbbsGspP8?=
 =?us-ascii?Q?C1JaWCISbnFrWHgacTLBNa5U5YZhqNTypU0AYLIzfSpztCVUZU4BubFdimGI?=
 =?us-ascii?Q?2BRyCqdOr+hqWZXBureNwnhwVKx0qz3vdU7k3zDQ0YoWKWYdf/ycPV6mY0Yo?=
 =?us-ascii?Q?870F9uha5u2UCC0+fdiA1qez7YReoDGBF4lzkYMEE5ICQPQFn3g4QZRm0bi6?=
 =?us-ascii?Q?rFjpfq0Kc/TXdOgCtF6mG8PuNvyZGOoJHtyD/QjcXxn24XUPAyhiXJJcrBpO?=
 =?us-ascii?Q?Gv9NWt2O59zXhWtjiRtR3VX0rgs6Rf0EBXBP2MBI5ukUl+1VDIZ/tN9ciXI2?=
 =?us-ascii?Q?yZQ5T9shmhXWk0GcpOZIjvuJen9ifyDyIZKV47I3rvEazkYHpdUcXPY+TxD9?=
 =?us-ascii?Q?eY6qkVEvRTZcI1SfMPwp83ReJWrN3lIS4b/tO5WqF4T/+PZ9GGr9MlHQVEt4?=
 =?us-ascii?Q?he6pZpIIB291kkdq+QRrQ3dpY6I4A9xym9B8IzPmDiaoiLMkCi34cLCjbzm3?=
 =?us-ascii?Q?3oRPsEbr4XjtP/hGh0v0GjKglzR0Tzaq7+gPsXBdqWtBcV6heJAJpyE4N1wK?=
 =?us-ascii?Q?j0B0IRSGYejo9FyAPWkmTy4MI1D4tLt6ZYOGWQrt2441gwKFAAmp2jnfF7jZ?=
 =?us-ascii?Q?z54jD0lCJHYapdIj/fcQJC1nySSmJiNY5ZGMKouzcDKrBSDQzR8lPs7VD97c?=
 =?us-ascii?Q?J936r6z1ur4M2MQ829cKJQ6upFXiSX4DfisKbVrZtMgAm/ovPUiIWyyP4VvL?=
 =?us-ascii?Q?coprWZH74MZPHyQzXSW2SMLRQSYwMNWoBmfUPhhJ0zDW0fM7LAwz6tMVua03?=
 =?us-ascii?Q?uptjVC/dyUZkuiah2JI/kmLXwwE1gzyo6g7tjwcYBX7/COjG4apP2eHVD7g1?=
 =?us-ascii?Q?OUheM0XaraqR2y9hy2oy6Ai398NnzM+fRvb8zLGRktk09dwWV+/2Rc17SwUe?=
 =?us-ascii?Q?V4vbwBeZqhcmM4R5774nOK219WZTFW/sI+5zX76jiykWK2UdD5RKuyDkmnek?=
 =?us-ascii?Q?OJyoTnQM1w9rS1xYSpBy7Uz8AFgajUSq09f5GzFFaRYbQ6AkR/baGdEwLtnM?=
 =?us-ascii?Q?jrlSDZeB+S0OSpPD4TlkfTkxMm7RE/A3nUh6o0/FHSvfkePcacBKIc+sC77s?=
 =?us-ascii?Q?hgVOUZHv3dEDmNETojYbVsXN1aHI/hY=3D?=
X-Exchange-RoutingPolicyChecked: ch9w9LDB/5jreiXF6eTHMbv5+uiP9Fau88KJ2p8tDILn11i2sPLPHrUMJbiOCUB9NuOHQo5AG9lSZGz8CtH6Nu/F2sfzvYw0VO38tTTd94crYOPmV9yozktG2DLZy5QfvtEq7XgB/8qW6tTD3sVbyxlra2VDSz+l7TBD50h3m3uZF9La4IvEzyIspU8GEodCHOvizFR+OP1tfs9fCm5F3Oda/iSIxE/A4J9w51qcwCchmepST3pi14UgB/l9ORVspTVESHI2WgkC6phvLPbZQVp2ESMLlQOzQrbK8Ql/KQxlXrBY00RM6uaaEGQJW31LXP/tqzjwQWuVjCW8pR5beg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb4dd0a-886d-48d8-79c6-08ded35fd575
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 08:49:29.0894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqaewVWgJWkr+GPLDIQFjol0PMR49eq4W3mL783bQjc55Qp7fd6tQMfllM/YyUx6R/BYji8Gl2bs/j/ti6op0fgxS2dSwBGhPove6AVarNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
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

On Thu, Jun 25, 2026 at 04:48:13PM +0100, Anatoly Burakov wrote:
> Static analysis reports that a rule might have a valid engine but invalid
> rule pointer while having a valid rule size. This should not happen in
> normal operation, but it's a good defensive check, so fix the potential
> issue by checking for the problematic condition before dumping flow memory.
> 
> Coverity issue: 503764
> 
> Fixes: 32251f047e92 ("net/iavf: support flow dump")
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
