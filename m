Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD7606EE81
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TYJpV9Q+
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7974342DAC;
	Fri,  6 Nov 2026 13:10:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 5946B40671;
 Fri,  6 Nov 2026 13:10:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967003; x=1825503003;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=liNQb+VwsAh2z8midgUR80i2a6j8TWF/yGirCTnD/hw=;
 b=TYJpV9Q+1MyNXUehnx3EGjIplWiHXIELaYLOEVOCd8ABBygQDOyIi15u
 6ycXISUy31Kfr9NpnXwakJ8XfuDZ2jbMxSp+n4ji5QdMCdG19iEZc5Oea
 5uuWwcNjezBVv/mPY+O/6mrylsmPx05tdbrjd2UDgYWi1bM7L/4WDNE6c
 a7I9ctAkDDXRj4IlfmAtvwzFhF/W6Tq2SIJQY+4TlUbCAd30+8FxjW3mA
 Y8F12cTXK+AdfN36RytQSgUUXcH2Wgz3fL3uZ2nxFRmNP4e2vHaLWsDx0
 E+5rZ2Je/lT3fQwTQ6AriApp5AOVdsvPiTym29BjYjqVmYyfZgx8pIL4I A==;
X-CSE-ConnectionGUID: hWMMPQwcQpK+JRH3qQHNrw==
X-CSE-MsgGUID: 49SMrwXlS7y7YTXelprC2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2679510"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2679510"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:10:00 -0800
X-CSE-ConnectionGUID: 07y1md+/QrCduxn0wRJhuA==
X-CSE-MsgGUID: cl9p/jQyTNaDygKB2yRF4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7304310"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:10:01 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:10:00 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 04:10:00 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.10)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:10:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmbZ3MtNNGoosZIcaoJDLZOhqY/EIefM8oD+WKXlnFRO54LQCWP5GliaKvqdp9yEjMIG7S5LLwDtldviH3e3qes0PAY1SE2vHJ4f5Zi96d7CvmexMBXtabHgpzD2MYy9MbOk4wNsnnUSIjExQ9HJRtid6UAAqp5HywejpArRAtRuEfWg1Eb15S7pSdDgiop56OH6dYaypxQGYyxUh53sUqi9o8nsXAWgU0WAxZ01PrvoKxGxzKBPlt2pVSUnM9+hTRWO5RK0nD0p6Ukt2pKNmPZWvP30AYY7WZvRbRFkOPGOEX7r6ZlJm73vVHTFfyzE8iFyZmqpROSZc+Qid1HckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMaegI4QIV17hUo2XDGN2xup/5mjLs8pts1NIIU14pY=;
 b=QoGjd7rdKxal5VDHlyINHFzkM1rC/1G0BMAJQqc+tEPzhT/hMLKOxmLrEqNzWoWWUEKit8qa+kN1PF/4omSazjhoLqgsgPqdLLNqf9+2+vZwc53FXXZZhqkD4gKftgLNe596gOuAmRxmsKxbcI8dcDkY0PeOosi2F3S5BxEgBYr9ULX/r7BMBf3+dI2xSJ6iB16jJSVEBgPlXQDk7+eaxeUP76o4htIBcfjQcnnXwtrdsWm0akTxHfgcIj8IhcRdElPYhJZZcS88TXvPVvvT9Ln62BOz4KmQlTB0uqIgpt2kz5V/gymqwOprWn5D1sO4PJMuexC71wGEKCBdtgBHtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 12:09:58 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 12:09:58 +0000
Date: Fri, 6 Nov 2026 12:09:53 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH 6/8] net/ice: fix DCF TM config leak on close
Message-ID: <au3DkQtHz9fqQSIX@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793871697.git.anurag.mandal@intel.com>
 <bfdadcc397cf1d1569dc23ec99317f910c66a8bb.1793871697.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bfdadcc397cf1d1569dc23ec99317f910c66a8bb.1793871697.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: a05de3af-9784-4ac1-2626-08df3bfee02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261022113327099003|261022105027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: v/9epjeTRi7O8Ke/N0+S3REu3T6DC8CdmtdtDqv1oMj3LzWZt2JfsaJqlzT+YOZxQ0NgRBg++52DQ6rqKcHlDSP5ikWy4+1VnInvV46zb4xjCjVauy5af9f3+WBQ+ASTVBSxD2qPpAusa5Ut6Q4Ps/BRs7e/Oso+Jy7RBrWOPlR+a5SzXMR8D29ZHtUHXxHxB5MiE+Mlx5rDX9kXnomb4WZPO/ItqjK5uvWRZfHV3iKdkwLahd16nDLEWFA/zxANI2aEopC+BbiZxJAaQ0YarjeEKqVF7m+PYP5uJwHNN0MOazB7TOibYBcn0V8I/FrtuFw+pDKIfRVVLipMFHuVLXYks5PYUysifxcnCYR/BS5z8tKIDN7ArubYSdNXqBw+z4Mx9ItaCRo1gklurZ3wr6vW/MjgU9GGAHQLiHieRvsiTOHaGsMkuxAsTLyBpAG80t/ePVrDZVaWWpbZAHG7SsSELpvXAl9DWJXVyj2XHSAwYCc5/yT/rUeGpbi9bXsmgjeyD86NcMk50L2Ls5KcZY/aLkq3MinLEZUUAeKxzuMhXG7N180FaJMWJsKhqRoHd2MmHcplydRfRAPMdIR7NwAoq2pY9KHKqp40fzt3YejtS8Q8NYEZSRoSBYMsaa5JoBHMiK86gU8E/wG6IKp9AUMP6YdviWDnSd00/j60y4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022113327099003)(261022105027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89c9NakkIH3XGdaYygfcgn1Ry2ZtcLi1WzP9VTiykC4zXzsnZ0JrPfq2VsbN?=
 =?us-ascii?Q?Qla/ndquL/wISLcTaGEZ711NSLIXDfkOiMoMHkFle0iSs4UDZKiBE8Q78fzo?=
 =?us-ascii?Q?AbhaOX80oCuBwf3ZMrGkGFpkgYZ5gmJrt0NtIshw0nGR0IPgVLzjVQwSd2fB?=
 =?us-ascii?Q?35UHE+DIV6PDqKknKHZdse5kExuvc3n0KlnEMh+3kM5RuVV2hMhnGjmgjkJi?=
 =?us-ascii?Q?COsEczHv4r6qKRiYahRWxcJd2T8bD5NZIzitfbOVUTNYIp4ZIP9v1xClBi6z?=
 =?us-ascii?Q?g/+OAFRz2F8uxXjjPPk6apDnMjD7DyOoyNEwWceBmppMB/RrQJpM7zsiZgJl?=
 =?us-ascii?Q?MUNLWHclD3K5t8cdE47hEQZg7NjbLPXIjwMYg/mEAlgfd2lYRfOqV62HIyRx?=
 =?us-ascii?Q?IxLxYvl0VF849b6XNaYadJNZM0Hzph/8oThik1xj3DQtUx3pUWvXSRRjPSdY?=
 =?us-ascii?Q?2cB6hyAVlSNxkHk65A2ZWMTvfL0cUTKUtP2aJ/2bz7kuWil1eW2oMf9NozJ1?=
 =?us-ascii?Q?wQabog3aNCZr41ubFBcECnyTuOAh6g/KyVZbaJ9uKYtZ1cPiyaBlpxZJh+uk?=
 =?us-ascii?Q?9B9hspKF45LMBuAbeJv+cOdaoHZ8s+ROS+tSNAUORRPY7IZ146y4iEFqXBti?=
 =?us-ascii?Q?tjm5j41A2KtXizBSSUtH3mlKfcOdMDmXQ/suYoOavt/Cp0Xfn4XPIwgnXarI?=
 =?us-ascii?Q?nOdNMm/T+WUSxOiXkTlXdG7kBA/+dhlU06TbQ/p4OKhUMDOD8f758my3pVA0?=
 =?us-ascii?Q?sPqR3qqR4ZsNtk3gNF/vQ2pqPzRdv3bUOqk6Us1Gi/F8gbEKDNLmdP6CE1p9?=
 =?us-ascii?Q?+j8mbRXnRRa94CAxxp7JQA4UfSSx8JgGjTrsq9KFyofJBUZgfUD059bZyBh6?=
 =?us-ascii?Q?nDkr/jwvY7r8FLYtxooFGQ9rjL50E2xFrKRwdufGIk3997MOEbiUSUy9Y2gj?=
 =?us-ascii?Q?SLBwBsHr1rNvijBkuBdfr9dO0daMdlV55KUgnyB8FdCLEtRN0iWt5b5LFIqa?=
 =?us-ascii?Q?Mw13BMwC51TU3hJ7YB/h/HvBcNZ0txV1BlgXA0ymZSP4yhCdO20BeKA55aF8?=
 =?us-ascii?Q?pWn5ZHiTumkpOOZc3+zXZDzoSjwuGpaif9/7KwiwT+RtIqlnJC5Ri/u3HBtL?=
 =?us-ascii?Q?tsPSU6NbP2LgbGcMsHBh5TmtLNByqsGJRQOVvhAXPuI7ggJcqyyh+2ut6YsD?=
 =?us-ascii?Q?FolYLWNhDQG47yQZgf+fGhW6t+4GePerVP1oi5Xlt97wZdb/DgaUUbwJF+1+?=
 =?us-ascii?Q?Hp12ROfWGzegspQPw2PxqgqM/UfNheYwBVsyd5Ut4CAuOr68KgZEjBCJQSRx?=
 =?us-ascii?Q?i9HOehq7X3A/dTYp0FJ+wmKebMFE69tRTSFjXzYYYOh0bD0cFB1HJjEAvCS8?=
 =?us-ascii?Q?yKvlnj6UjZN+Ivn2HlFlS87npvTFeBn3/+NGHBoDQGLvKmLdcKwtm5EYPXm6?=
 =?us-ascii?Q?1V4ykcA4JAVdBcAW8Zugb2iMwU/MU+FUhBod41muob4WpmcsG9aV+TtSaify?=
 =?us-ascii?Q?RUE1bV42vVGrtsmB6VObWzbzGzNYs2zK6q/nCxpi44dydY8lEw+X4Zk4tb6S?=
 =?us-ascii?Q?D9M8/ZHwDJYniQUNFkTV8TWKKxi/s2T46rpy14Rk1hiAL6c0o0z8uj9Aavye?=
 =?us-ascii?Q?dmI+L1SkJ3F41P8HJ+1atxlP7pfdk1xT+bvBbUCml8oVV/Jias0/x8VtSqX6?=
 =?us-ascii?Q?K8cy0yEec0iuX6MsP1HWkUJfsRbVVG/rp26o/MHazfsS3nQm6JX+jGjxXeMJ?=
 =?us-ascii?Q?bE8XjxtezoWWke/Td8MkaoInY2xy10A=3D?=
X-Exchange-RoutingPolicyChecked: HYg1YWMK4Nk7TU8/5dTBJ7YGRCYccum5TnXfUydJ8SwDGtGfLCK9C7eM8EtqrU54Xw+rJz6Mopk4oS5vb1HV/1FIIVRIcZLw7ltDA6uPYw2sVInLemRu34jqkzBQpqvb8ntJccQ5afKWeLRHTlZZq3vyHMG2LaBjaxIdtcpo3b6zHn+rCCq5l6U80Jln17OBvs+xBYJ1vgwOtEwsZlToaE4LJHOwmTbI4DHFoF/0Y32H6mZqw+CAbAQ/H/w6ZHDBDuE4AhdAAlS2D7NPVzstlVd6flidAWkG9GcmxE+/m8qzPkOPA4SJlgBDOasUU4HwSPbF070p9HC5o9KbeIe7qQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a05de3af-9784-4ac1-2626-08df3bfee02e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:09:57.9903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7khVCz1mMZIr9H4eTZO6lQXbm5zJv+/VgoJ2GAZdd4LAH3jCVdJQD+MIkJ9tl3S84pqQAEtB255mLXruvdbhimgeT3MTREdhhYPhp2QiFzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
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

On Thu, Nov 05, 2026 at 09:47:23AM +0000, Anurag Mandal wrote:
> ice_dcf_uninit_hw() releases the TM nodes and shaper profiles only
> when the hierarchy gets committed.
> If the application adds nodes or profiles but never commits them,
> or the commit fails without clearing them, they leak on close and
> reset.
> 
> Only clearing the bandwidth needs a committed hierarchy,
> so releasing the TM config whenever QoS is supported.
> 
> Fixes: 775a25a372f5 ("net/ice: clear QoS bandwidth on DCF close")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
