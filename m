Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ECBCD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:30:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C58F4064E;
	Tue,  5 May 2026 18:30:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id AF8AF4027F
 for <dev@dpdk.org>; Tue,  5 May 2026 18:30:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777998632; x=1809534632;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RJTtQ+1L4KV+zZmQfwHgkN3+Qa/9y8m/h7FPlQnZi9M=;
 b=AAO/tBeauUePTUdEUBNzhSvami4PXQOtYRz51vokFmI5AMWG0o75VlMc
 l2e9SVCYqSR2LnXkgrMrQKHubOOaO7ojFSsMGeWRTaC+ZgaSSJto8nz8Z
 GJnRZk223fzW+JrwoBsPOMZ0Ecs4F/jazHboDFgxmqqxPqucqWKAzomkI
 PyBE1si92NHQartDHOYuMSGtBjU31o5ML1VpSO28ZUpImrJnRe+WNEb88
 EN28i3qZkn6VyvzSpPO2HDwMWP8anz0pIHMkGeO8bDG1zhO/qMfEGNYXz
 DrKTof6mkYLelm+iO19KOgGvYbquUHyu0wBmkwNdIYHRZxzt69DETHM8i Q==;
X-CSE-ConnectionGUID: hfydk2CHRx2b3wxjti/xCg==
X-CSE-MsgGUID: 4fzgHlUBQte96NLxCakJ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="66402730"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="66402730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:30:28 -0700
X-CSE-ConnectionGUID: vDrJo8PnRPOf04q7jThgrg==
X-CSE-MsgGUID: j+3Z6p8yQ6Cg2O11DW0ubQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="240848669"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:30:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:30:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:30:27 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVBy+Tna4O/O0N9ZMP/m8QGlX3RBHWt3dbaI44YIOcw8c1L5Xc9me6/H9i7ngBQdsS2wmia9DqqkCAKAeR+9Re3dNu0Ps4pUKPdOEuGPZzH+nUjTBvWO6R/EjmxH24RRAd2uL7mZB1BpejVCLWDjGW7J4759Ms2vFGsRA7iGe/N9EClKZ4Y/XMdM7svjWGzSP91AaX3WsCBEWWZO6lT//lG0nlEk2vXv6o0vcX1SIPCrA7cGBFk9qIXqCWt08SCxaiMMN6V0AfJtC39H/E8A+R8ctC7+uaRTptIgjNZb6vU/IM4ysaDBjB40HRmN8e5hFJwCWfGA3RXisAhgjJDTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdHcRjbeCAc/aw5iAgbbvRIlLNJvZsxY56bGrGaBgss=;
 b=CazB6dU5hhUcb4Ii8fqg5FGXTeiil6tKASVEZywJ+vu/ELUGWN4ZXsMI0QNVrqUgkgpoNgAYiHVoz8KqBG1kPHHjhf9ElK+sFU6tETrOnzkcDFwZZR1LTc8IXl3cwgPuhGVKCiviG8s7IE7zPSD1olxBkYBOdTnzOyJX5STA+pol+HfPdQmhJqI+3/86P2qtquc5EMH1I4l6lyExN1v1sz/rE3LTImAVQ5nVBAn8tOCDFtZHUUdboatKEAuYnxiILeUxgVpaCxZt5j6ckcQE02GsbeAMn/FaSLnRh4zJ66Msrj26xthGjq0hDtph19VPHYxj9EbPZyi4Yez0PFaNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8572.namprd11.prod.outlook.com (2603:10b6:510:30a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:30:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:30:21 +0000
Date: Tue, 5 May 2026 17:30:16 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/4] net/ixgbe: implement flow dump
Message-ID: <afobGN8otU7LyYRL@bricha3-mobl1.ger.corp.intel.com>
References: <8885d9b4e9d1290b5340b9eb3da06d7acb2973c2.1777545092.git.anatoly.burakov@intel.com>
 <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P194CA0024.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1ead3c-fb5d-4f61-28d6-08deaac39a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 7IJx0q5FIvsqYE2IYKE05ty9cMnZzuTyaWKwAvmNdRGKeYML4NLHEn6EU3IrLX6xNpO6n6sDkwU32oJ6bnbxefDe/wT2I/6puhQOhrW1W7XqbikBmHCY6YlOousb1hd6ygsw3P590wCW36+LIxMtUXA0eIhocw77DAXg0c9F49p+2bfntEjufRy1SxgT+tNT4fGA4DbEDiZU8Qt5DOY7NdqKNTePqGhVrZH2HAb1BOgdedj/XxokWVEBMwuQoLK2XI4MzVdkwsy/xHcF77HzLBb4giyM7yG2jwTCPMsWDQd8YtcmTicKy4nMaM5ATFL5tYlKWFRNkATLO7K8NTfPqQxzmx7Ay5YZNJuIqL6d6rRj2FVjIj+DrBWuZGwEnRO1s0i28wtyWMEJuXUgeA1UsX8VW0j3DiBO9BMe3Tvds/utqrvz9iKsOZKzydbC0mwV6vgWeeFNPxjzE6rs9dWDGwPWwLhU7z2MYX00oIXXs66LaJxwQ0UDSxvDReoyxhK9b7Dse5sSLqawVMlCwPQqQXXRvkLSyvGraB4AsZvtZtP4/YcgXYeQFWLYCchx8D7WY/+mJFNuUBO9nOhkpHVzizi0IAxPYPhc+UlPxIQN5Ln8lODe9pIeet91DiZVd9rszHBcM9ZmWtVlijO6alB6NqO9faS0CXOtoshaElcc/rjUNdLxwN/Xo+1fAG5xmVaU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q7aZ3ywsq31qiQYlU/R6HQzXz6NmKdi7RyN8iVLsWHLrOcPcydB9+KfwA1+x?=
 =?us-ascii?Q?UtE/thnbi1X8np8UcuAwVoJF5NGzbFhyuF4+GZr+8wSKXQY/RcywhS0kb0MQ?=
 =?us-ascii?Q?BmlL6ofDIG5dm+s7YGC10pSHeVy5LW1PpRACpRBs8PmJ4F4aMBJTRz95wrVD?=
 =?us-ascii?Q?gUgRgEMZhEPJ4GCjF0IvTPJiPvEySil+ANZvUrITaNkrouIBbzua/+/OZq+u?=
 =?us-ascii?Q?bS1nOCDMRToMKP47FZsUD63EAnoq01h35FZMAI0rEuSrtRELWJTURJqQM7uY?=
 =?us-ascii?Q?7xhqZpT5VlvAF7lAt7D31Li5yjR6eSEEfGid0P7mw7D9RxH4PBy3iag/UrDa?=
 =?us-ascii?Q?F4W5yJxTDBCwjjLq235wzk2Vsx/nd2fIo/pn8CF+ICtO1Ur1Nr5GQI+vNci3?=
 =?us-ascii?Q?Wq5W+shdlbtDc1uDUbxLnCwDv6b3snp2QMv6jA1NRKx7KFL02mKgDlG2sVrQ?=
 =?us-ascii?Q?eIudWcZgGa93zXhMbftZMtpPPNkNWryjMqitYGqX4XiOl0sYs3s4R25TKge9?=
 =?us-ascii?Q?z0pCgoZ85sBKIt732kJng56VokpsGMlMJl+yYvkEQyJCvTCtv2iodMkekRra?=
 =?us-ascii?Q?PbhKc5gSonEcq0uaGv6CYb1jWiZKk25SiE5maJqHBw4KdllRj36nzvFDgmBr?=
 =?us-ascii?Q?JAaFlNyQpszcNdRhhUHHBpYtKYxIj+h6l/XuebIZM2tAzygHjF+pv37s+v/u?=
 =?us-ascii?Q?BBbhyajgQQnYM7DEMvkbqfnvQ4dvluf/myexJEkn5800nm+Hlbsng4ZtjuOa?=
 =?us-ascii?Q?TCRql1bDtdHA8QCEqxwjoy0UP79TWmyg6ashIIU7Re6TI87lmgDvAj3HtCIk?=
 =?us-ascii?Q?vo/BhHiR1WodRXb6Gh+3bzq7tN+/i4lmf7aZ6PYatUxXQ4W0YeWKEgHH5EVi?=
 =?us-ascii?Q?MlLCu4M5lzyz4BOloF2NxvJ463Fyv8KGTmpQTHhET2T79tsG38tp8CL2haWc?=
 =?us-ascii?Q?MntBYm9QbPwtuR0LtfrniDOpoy6K2dTNm28YSTVTqEFCECq2+xTgNBVbETWt?=
 =?us-ascii?Q?YIN6UTAD63JuI+O3ULUh0lugjKo9oYwuWr3bni6TEuiTc1CVZ1qWD36YFqZp?=
 =?us-ascii?Q?b7MKTFylLysThDfjtUzWD90WOn4lQWT0WaXXX5t0XGFVyeibt8fz2j7mFopp?=
 =?us-ascii?Q?Y8iwrvGhEOgzF21POECnH5DWkOcDRX15HJ8DbPItB11heCy7APyibpi7/psr?=
 =?us-ascii?Q?jwD0eQ+W/suG/7YdybpsLLkZ0Itt3doLlILWs1ufetmENtUFTg4K6leX6u5t?=
 =?us-ascii?Q?pUPLSAVj9tTo71k0cYtyS8bUw+bJAFOs03QzgMv2Wrpk7cYWjzAnusS2mU4d?=
 =?us-ascii?Q?z/BbqETReTvt1VmcWBY6FdRw1s6bswOERiQ7tAk4qFDS3XTOy2Xg3EcIRbdc?=
 =?us-ascii?Q?POGrSS5MN4VR3m5nNjD8CzFNlV9AdIXDlKydR3r8GB+3jdCAFBHPX2XcVtf/?=
 =?us-ascii?Q?ujCTjZLlse1odSV2NPc/7m1tb1hfE/GUBM0O7uM5nYd3FdIKQ/xbJdyRg/is?=
 =?us-ascii?Q?QHwhlKQl+WIax8tr0CFq0HAE/kIX/6WtcbsvC83S43ejyj5PE3ds4hBrGBEK?=
 =?us-ascii?Q?y5PJJjrecqBcGikUct5NNCqxtzLk0GuEO62ntOLfwYSWtdw0SAF7r3VaJPsG?=
 =?us-ascii?Q?F4N/9+18fC4/wDYD8C4n2rsQcKe/vOQxpWTQcpkbBplh0czFjikDrgyxFZ3t?=
 =?us-ascii?Q?hBvTP1fPmp43Fp3omeerUGKngqYgXNTAVOItbZxVt4kW6/SG/gOlqHdVbreQ?=
 =?us-ascii?Q?3jX/mxGulraS1/DHOPxUmixWhHWvrSA=3D?=
X-Exchange-RoutingPolicyChecked: Ubp1dI5PhZ6JH6+gd5IWs+hP0cE0+uYclEqiOjsxy+TzUI2FksLA7VG/hp6/VhVIZqQ2h0y6l6pBqBzw5jYJQNcIDdZk5l2r6k1nKsHyviI8EoWMzD933vSgZD5qmpnjI2gz3GNuwTFIk5ptYUjh+Yoc6Bfr8qjlBkSv+XyHDo9xY/aXeQ2Kk3X80+bsot0/bLeea3kvMciIADKfjdzdIjhnL8iXpHXrxm5MKqrWBrC4/B5w8pgT57D6n7UG6g7w9oIT04YhT+YkRWTG5j8Grt/+TJktyGxp8x+8o9jmhzg7b2YZvjRyT8DxmoGA1P3e1pZz98UvsuKdnub0t3EDcQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ead3c-fb5d-4f61-28d6-08deaac39a32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:30:21.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xQlH7KUdKtLgLKLPEUjt7BP7AyElGSNae5uSeP9V9qL9iZDyzP8m4H3Jeosyy50L/HsNpY8C/Fv0tSun9GHhIhwwSWGCELtx7uVHFtvcCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8572
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

On Thu, Apr 30, 2026 at 12:00:44PM +0100, Anatoly Burakov wrote:
> Implement flow dumping API.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
