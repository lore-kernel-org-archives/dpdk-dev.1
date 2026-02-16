Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7600EE81A5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D617840296;
	Mon, 16 Feb 2026 18:12:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 11FFB40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261959; x=1802797959;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BaNpYufXGShq8jB4ruGVrxS/t2e7+SY5EIWWRvgjtCc=;
 b=AAeeJs4Z6Evr3AkUDrz8FJC4UOR54OKxJHN/6NhQeUyYp21ikR7IG6c8
 xEeeNZjRVakgOx26zWrelJuPCT4E2dAcVxSoSHabj9LTw7JqmoHXD/R0P
 f2WQ6tPU2L39Q9vlMjAh8WRYWVK3Oeg47P0tHKvzbbwIjRNd2cjg00qSk
 ZhiAuzCb4HPty78OB65Uz6Vu2iOPnR1qcWTfLFtNUX+HphSFFaL7TfXpW
 n/h3XS/hB2ox6SGEkyl+U8Y9tB2VjuvSwUr2sNJSO7En8Zc/l+zoC2V0n
 0hxN/Hsa6SE1Pr+/HJrv6GZc9ONBHvVbS0I7fw2VWbVg5984c3+H6eW+q Q==;
X-CSE-ConnectionGUID: 0ELa+cSbTK6M9sbqullcZg==
X-CSE-MsgGUID: NwTgJ+VmSiG42Bfy0YnMPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83068085"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83068085"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:12:31 -0800
X-CSE-ConnectionGUID: CxcEXa1yRKy6+0I0/v1VSg==
X-CSE-MsgGUID: FOw7P6RLRi6DUoxOXsaO/g==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:12:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:12:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:12:30 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:12:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgacFnHQLj1lqA1WqwMYGbNPqEG7ZiMF+Sr4MsDRIXdePXhA287CUplnKlyFSr5D5TgtwgZEth7dhTjWykOr3yl0CPN1hMtONewgkKoqIiOWhg7Kfnn176ME3x8ea0tqo65WaTlImwqdM1eiSWlQ5BmcO3c1WbMM2SEQJMzKs5AjKat51ksdzXeirAwZcFErKe0rZk4w8S46RHqJjhjM+/CDi0Kai/J0ghmNIkCraLWtjiW4BXUeqBTR1ftWviVJR2OJ75HJkZr3dGrKt0grmWLVTsF/aosi7dIPo4t6L3HV/4Dv4C2ziEE2IdDZw/v4E8qBzE1sGxl6eAARokAB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4It1iexOrImDgjoBB1uC2j/sNZ9EIGP3K36Gx8gM8Y=;
 b=bv8jdcnVmXDgNqfmAhCKBHhqr5p5mOwSLzBBFQ+7CfcvEKTbDmfMS+ZstZeS6X0JVjOB7fnw3yUczKLuH3U1uP3n2gm9uKOGBcj/0xl+9nqCQLAR6np/LMQOX3YgDFgEkYtGx/S9uJ9WAw/QY8T7eujbNkAmNdcDV0KHfalR9CUrcXGxZUTjBRaolADSpb3UDy3XHVYgy+B40LcQrUhF4lDsfzZ+biKa0augFTixM3pOHlXaLuHnVdyuKsXqilGGroajyeY/tBM8raCTMoRAbi491Md/XNBn62P5V7k7qgjVILISEnr4MzWx3DpCbFXnmU3xxufGAr8wbWKYjNa+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:12:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:12:27 +0000
Date: Mon, 16 Feb 2026 17:12:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 14/27] net/i40e: avoid rte malloc in DDP package
 handling
Message-ID: <aZNP91JbfUNxXXwd@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <75d6a7f7525aaaa4b503697c4be7e5dc16e8cae7.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <75d6a7f7525aaaa4b503697c4be7e5dc16e8cae7.1770817884.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0237.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcf7c36-6ef1-48bd-fb5d-08de6d7e8f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EyqIxjnAZjUZs7nQEyXk7W6g6EGcXe9k4kKnf6J98ii5pZFuD1fhYMPayjDB?=
 =?us-ascii?Q?RTAcwyz1vccbKK72KyyzOLeSAjXv1GO2OcvKYmOwAfxubVaHA7QmAe+2HoLD?=
 =?us-ascii?Q?YkTab3iashDFsLrxe1Opsyc9sjl0YSn2Cw8DHg4SzNZflaNzhRb32paI8kb0?=
 =?us-ascii?Q?bkO6JalQfkSFqdlQpAzoHdkMilgNhX9ork6ooyZ2Y/61wzyXA0UtFg6KkvFn?=
 =?us-ascii?Q?5GpT3RSRyEqBUSX/EDfTUJTuVQPqG6Tp6Dw2Vr6ZZzlBUL+OVMN1MKIjvRZZ?=
 =?us-ascii?Q?Mj2FK4sNFVj+m35ClYK5UfjVB72I5b+05FUPZ483obnfkSEY5YcMxzURSmMK?=
 =?us-ascii?Q?CpB+OmQ/VypHysI28XJjx6OnUhNXYVN7gQtVgdBHNzJ0mxHP+xRvhdd4zBlr?=
 =?us-ascii?Q?rMBULRvxts2dR8wtyUEUNKxmhDcR174uuPbnZRLQxU89bB/Bt1VmBDcFweSk?=
 =?us-ascii?Q?uFBpmnXQXxir3ovYvymeiNmLF6xrBG7IpT46S9TYTr6I1svy80UonhRNPep6?=
 =?us-ascii?Q?nzTj1smsiIqAtfJ2Fq29Y52PBXlJTqo6FW4kbAeXoZp/m+69qXXpXwun7tVs?=
 =?us-ascii?Q?DXFVyhbOq9pWpAQJ9zuSWkJ4OxULGg0NiaCdZ+972l3kOtKgRI8P3gE+zFIh?=
 =?us-ascii?Q?rzU39tAKXV6VrVbZ9oKK+INYooiWPFdBdsH5oEdXt9I2vyI+yqnGiuZriFIs?=
 =?us-ascii?Q?G79BFQ4pa9AzSwBRTdbM2JooNswOPLPXwJc7f6YR2zOlLoHmQs8mvwVz0KCX?=
 =?us-ascii?Q?bPu+xINUxcrHeGrrVGQ2ttqeI1+AuY3hmiztA62+baMeG0QvY8VVFTOj5cQh?=
 =?us-ascii?Q?exDe+MYlGolwM1xmN6uNj0QGtRIortJ1KXVfBQTYFpA9vKOtoDKOxyzFyfOX?=
 =?us-ascii?Q?oAhLJcGTQEjiQwPtb/msOAix91+nX5ZsEWfVPKjbuPKBwNYuMIw9CGAq3Ixu?=
 =?us-ascii?Q?xLrtpkCI/9ljC15jvfYJ5ah/zZ2llljNFgJYe12Y7QSJkyi3+sBqZq2Jd0Ed?=
 =?us-ascii?Q?oHOmj2w/KHNeU8cJaEZAr3UqB3vT+u3Qk4rnQdQ8cAQFZKHwHZKrSVTPI3dN?=
 =?us-ascii?Q?diakfbnt2g1zdvH8yf3cpiIbaQYvfoUB4VyTIdRkpk5CbuBdifAfNTjIFiYI?=
 =?us-ascii?Q?BPQM5jnfkmrliZ15V3xUGHbEem8MXztOLEFbtZM1fT1Qu0EfkOGUXQ1n9cjP?=
 =?us-ascii?Q?WXI/ozf0PTYQCP37T4ocarfTWrhMm/X9dd7HfD2ZBBCUa38R9bQscZ332DHq?=
 =?us-ascii?Q?xI6cyWymA9AfHNv8GtvOIUd8kXFiZcIqe264PI539sheKLaWlrEzBHcuAXaZ?=
 =?us-ascii?Q?nwh0mDN9LJvdXxjSgb8AWSTYPuwGAI2qdIUBxz0pBrM2CbAsNZeiA1h5zrJc?=
 =?us-ascii?Q?gWKKGLpCW5xTx7elD9N86BoHrsPmCUptMyfBUn1fp6nKgv/gxP/9DCWYTf78?=
 =?us-ascii?Q?XdNbf8VPe8AHIEbQOMrLjKP9ZNQoyB4pFX3FR+8wQDc9Ul3OA06TsE4d6aCp?=
 =?us-ascii?Q?kGp/z3Ru5mACX/knJ4t8bA8M3eJlmBUc2hAf1i37WSKdoO+1SG01WtQKvtq7?=
 =?us-ascii?Q?Wf6ViNEhGb832qn/VXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCcBHyPLWVqQf4HhEhYGc+BBZEu09yYkA8kWQMYsLGFz4hRPu6EzLMQee4Ii?=
 =?us-ascii?Q?PUgmo8sKtbh6h5xaY9tSJxmmgDsiQ2Om+6Zv2wVkXjTrc3JU2pUNvQpE1cDq?=
 =?us-ascii?Q?sNhsJJThYc9maE24EBeLE1fO3IZUXTRdIP0s45NEpTXazSaRk2uoeN3hZqW4?=
 =?us-ascii?Q?YCIKlCN0v8pzzoRipa730efO/q6caoxCn8T/PZ4UK4zoI6cW2jfVQO9pApuK?=
 =?us-ascii?Q?AkylGHODqaLHLbz1Z9nB22eBJKTwToJEQC7Ldme8h5em0ZiH75JfhOC97cVO?=
 =?us-ascii?Q?teJrS+WhAsx9odV0j8AuW6X9xFatUBecvRZqsofF4exLpB7akmT9vS4QGqbi?=
 =?us-ascii?Q?Pv8JUggJTzOlrjgXE2+Z4rFjWbiL9LR/1Bu5rwZWP/5I/Y3SeNiDABdNyVxI?=
 =?us-ascii?Q?i10Ptt2R1FCbYx96VR5Sw/zSoo+T4JOWIf+PvH/pKZYWi8VHV9YOhqwVFqIu?=
 =?us-ascii?Q?GB2cA5/+Jnt1Ir8ZZTeOdvQpAvGddSzJof7Et9a0xYwv3wbchXQg8dHL6Tv7?=
 =?us-ascii?Q?bcdvCZUJQ9C6/WaRJmxt0mmolHmnC7AmcHY7WcBsqgeoljSGpCBHsawb2ezE?=
 =?us-ascii?Q?aoZG7KYXe1PCpFrdlAwm8RoccrbVREqPrjsBgw3qyHCI0hxd4CUTY/Wv7htz?=
 =?us-ascii?Q?B9cORI2Ng6Us+zTfpUUg5QOJR8WFFqbRutsKHNlk7IcDbtl+SSBwHgiMcPgB?=
 =?us-ascii?Q?kEtIHzS4x7MX4WP5MhPs7bzWnZxxkeTaTt/9WGh9dH2UpnNjUHCLnP9a1zAF?=
 =?us-ascii?Q?Cxs4nvs4XFpR1c7wOPzsyGHc5vSv6rK1l/T8xNc0HTdZ0MF4xtVsotBYzp5W?=
 =?us-ascii?Q?hzSBlkKcMQYyNVpBSdli/Fd2Za3WoAeMiAt5R1g1E2OBuJvgN0JkLpxTTwPy?=
 =?us-ascii?Q?cjjmN/Q2W7ymt2vCTjKe1gkHprsYn+h90KBy/m2sTA1AXOLu0loPzH8uIzW5?=
 =?us-ascii?Q?RW3M1kRqyXkW8uq8Je/x9QJ/zNDSXKAkV4TnVUSBV+eoEd7NzIX5YFkPmEnZ?=
 =?us-ascii?Q?xroYB7Re/ZiXArNxSQi+cbF5FP1bWm1dhwnC2MKlhK+H+secLHkLh7EsSrG/?=
 =?us-ascii?Q?V6AlKmbBHjcwvhmqFjt7P/cg8wZScpGdFMuXm99Y0gXQrNwTI+oYisOtBmt5?=
 =?us-ascii?Q?x06tGwXvuNupORie3V5mhMSrGE8yEywhN3STF125AiRl5GH+iKlgSBy+Wm2d?=
 =?us-ascii?Q?0YEtvjDAVW6mXjV5jsIRuNitBVCOEVJ0NAXMOuQ76+vd4XR8IiPvTbTE0AUr?=
 =?us-ascii?Q?MuI5ZBANzuV/QUbv4vqcyXcRThy3ySgf8PTpzcUujkRcm7jzSnp23NmgY5QQ?=
 =?us-ascii?Q?ZsWYEq8lTYiyD4axyFHAOUx48gLaZfV88nbJDFKpLs8JDTAXg9YWMyP8rWdB?=
 =?us-ascii?Q?b9YYqwU6DQe46PwxBhVj/0rw+Ur4ICapB3oKj8DnVLrsDdyQi9kQggAuihO0?=
 =?us-ascii?Q?tPPhgJ1h1Ul+BjQVMT2ZRida4P+KNiA2Xfa3R4aWFsSz+/5NuJ0VildSIadj?=
 =?us-ascii?Q?Ls7QK1CstX6gmyh8b9dD4mas9qnRVbQwhCMwV88IgTS0veylDeiVSRKO9roD?=
 =?us-ascii?Q?+wcxyLqBU74sr8A34lTtVwcdsAtV7RLuL6Y7/BgJX7B3HN2Z43XIqk7z2joG?=
 =?us-ascii?Q?q31zDVkWZpMephAOrmwpSO1ef0shWzVkGcERFLdvpVWO024RWCtCblPc+qYD?=
 =?us-ascii?Q?i4W6uIOya5POgrdMmmdFoYssZnqTu5JJ5/aHpX5fvZQ3W8eac3ZzJlk5me+I?=
 =?us-ascii?Q?c/+9H2JIqcLssTR8lb6Yz4zoptxiSY0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcf7c36-6ef1-48bd-fb5d-08de6d7e8f91
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:12:27.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2FbPhD3E9umqeCX2tZfNSzTlPUio472QfnL/8rkUbIaixXSUfBU44aPqpUNobsY1Cp0sAjRGXe2NjcV9JTbsPy/Hb0iGpdbB5qcJbk8wzVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Wed, Feb 11, 2026 at 01:52:56PM +0000, Anatoly Burakov wrote:
> Currently, when processing Dynamic Driver Profile (DDP) packages and
> checking profile information, we are using rte_zmalloc followed by
> immediate rte_free. This is not needed as these buffers are only used
> temporarily, so replace it with stack-allocated structures or regular
> malloc/free where appropriate.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

