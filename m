Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E05E81A5D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F494066A;
	Mon, 16 Feb 2026 18:33:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6C78840668
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771263225; x=1802799225;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TEc9B7yteePOduR1P/I7Ybfl5QwxBuv1XSLpvWU03Nk=;
 b=gJ89CdrT2LOLxBa73xTsLTIlWJEECf4qHNUihlZMB066KUN2D7zYRQrd
 Yuf9jmX3K8L6XGFen7wXTF5R8Z6dlXQoYh6bEnF9CLXYDM3R0wgCIyhWe
 I4gw0V2lz8vUJGAcbR9KDTZ9aB87OqOBxSx0nqYhhUVivl+Jd1Uiu0cyy
 y+I2ryoQXtn9JmkZV744L7V8mHfiEM2Paq6TgV5xdCnmrGSrxv7UnBBfs
 dgJM58rsK5E33a5a13/KtYjfwfXWTv+pkGHksBKpDPP1yUOACksHwJOpl
 5YCq8LRbfPSu4GAT7/gqMAclE8nevj5g5qU33I2i4Y2LgqfaQb29xxSde A==;
X-CSE-ConnectionGUID: V1PCJvbOS8es7OlDvu6gPg==
X-CSE-MsgGUID: LlZOTWoTQj+diOdbGzIrEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83783487"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83783487"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:33:45 -0800
X-CSE-ConnectionGUID: hnW2fD6LQCaBp/BacP83EA==
X-CSE-MsgGUID: hdSIEo6PSku98E6ooUIfmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="213504357"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:33:25 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:33:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:33:24 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:33:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8KRsxRNyQBGAGhbhceYO03puppLcz9iSkP4VMGQGMIK4grYWzycYTdrNMnT9FLRShQVd/7TJxzEW4mqWHDjYWMzty8p+Zq/OsrF312zQEsVXnUfeTOM4Dq3MWmlyakv9wclXCpK3MR0YFQnPvQiWk/6Zw1Hs0eR1DMK2uXcexhQ8dJRIbvyCv354pMOh1I2QGzZ61kornvHGc+L71TNZnzpSX9mIOKszIVaviGd+7D3PYPh1sfV5woIDJfGk3EHsAsanZ72gNKoyeyaz5snqoi0DFklCVDXb6pD3T6Mg/PMWF6kKZsZzg9GCzZKhTtqMSN6hM+87eGO+Iu7W2nOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfsmnrWiN2XquYfJNrt9Oz98aXbM3tSOUeFsQn89wRo=;
 b=nb4kpdH0q/oE+ITKgU6YbNdYN34fy1UHuNKcwpuN0NCUovHv3VEORYKQHnPoQE91Z0q1CxkBmTqj67va2En9BQVt+8SFwUe04JjzuEmgkMabM5eZjRRfjPOzhkAfy/FiBQzJ6iWdD5BXEz81p3iJ1JyPsAXCo6CHx0H9j+lCOuTDweCOBqIIDHiXHxGBj2HEM4neJHMAtTDE5wxdx2eFA0p7EFqz5XHH7ffm8rbnB3ECCcUkqbZLjdYo5kAHGocNQbns+btDPdxYSwkOOKLAtDwdym3FElDQ3w/GAmsVCyJ5/bs18UYehfL2jve8dQiLQW6GQl4ccDe5MfWyEDNeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9452.namprd11.prod.outlook.com (2603:10b6:8:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:33:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:33:21 +0000
Date: Mon, 16 Feb 2026 17:33:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 25/27] net/ice: avoid rte malloc in MAC address
 operations
Message-ID: <aZNU3BbQ3hupVMXL@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <692fa26644ea85b6ab848e5d8d88155c4ba49925.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <692fa26644ea85b6ab848e5d8d88155c4ba49925.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0244.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1f66dd-fcc4-45c4-1bfa-08de6d817a9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pp/BhFdAwTp/iy6yKNPVYumiH5ukX1SSVTvC7nW23O91JFdccQZYXkbq52oe?=
 =?us-ascii?Q?mAuIQTI1YLn5YRD77wrY6tevcndNDQy2po3v6a79m9Q5RPNurMU02oGXFcbX?=
 =?us-ascii?Q?ancQiRnp51xLMDm13bJ3wxVBWnS/34OADTnLHziTBMrXe0ZNDqKid3dhdbCb?=
 =?us-ascii?Q?U1gedmF9kLtF4fqto6vfGkPfOriFld/79L7IkrSXJ1FYzyM6W0areHKqHwHk?=
 =?us-ascii?Q?towTtN+sdAPkiHOGh/Huih4Xh+Av8nz81Y5WWzmwYHm2kDarXTXnNg4GCM6E?=
 =?us-ascii?Q?lROKhQbZ4d1PMY9Xy5W1g320viCt3Q7vL9WgmfhMBM1s99oSDeQ6gmdUj49m?=
 =?us-ascii?Q?ltcjSaeAn3dX6yU2m2CrvL6WA8Q0+n7igkOlq3Wiq8cFR4RLyV5wjCHmtQi/?=
 =?us-ascii?Q?5op4fn8AmII93i/+ZTgYNGown7p/l2EYAh30wBH8y5qa6mj1BUVt2lD8bZf0?=
 =?us-ascii?Q?YePtxHjGT9hxi9dk7T89ObDO8QGJum2GabxMX7maW+2E/DmCv0UV5/8gMEQX?=
 =?us-ascii?Q?irOgALpL+DcmrQdu5L7M44h5+nQG299u2aBkHeaPb3hH1uciVE+63RTr+7HJ?=
 =?us-ascii?Q?fWxN7HrEnt2OhYgJ3mA2R8EEdMxLF2a4vDOHQClKGomuFWcXUcnyRme1tvBD?=
 =?us-ascii?Q?0tXOYJ1/yMIlVOcPNGlbBPukLIwydVLsupIPKVzJqL620eMtAT8r343QD5D8?=
 =?us-ascii?Q?eJGm1PjtR1oAePIyywIKKMLNDiw7Qt/XlKqCR6BLWPWQX6BHEoW+Nx+LPv85?=
 =?us-ascii?Q?w/LSNjFoUXSs3HepZ/UQB5SsjwuVYKHgQvcN+G3TuhiAJFEQ0nNRwohMg2Z2?=
 =?us-ascii?Q?7t+sBge5Rv6rKEYsb8n7KbRs1r1+2HtVKP90ovvxGM2jD8Sn5r3MkHgMN4hc?=
 =?us-ascii?Q?Dtx8ZPXQkMkd6E9dm84/ASPrpqjEqSj9L3hR7FjBAKnXVZmu/CHWdVIJ08qf?=
 =?us-ascii?Q?5y5IgxOHiLh8oThVv6HkhK/NwUsVZZSTAIAdwho5lAbUhWx5Vb3CGnDCWQ6m?=
 =?us-ascii?Q?PmgXY0m5SwzaOIfp8dAhutPLrsSkYZ7rty1dtlCFotcvRreG46JPuG2YYVmi?=
 =?us-ascii?Q?iOp2gijhhqsiMo1HBPI5jp0IKfsvNq5QkjgQXdy172KXcuPYqwH6zfXxx8nN?=
 =?us-ascii?Q?7ktTzxXxLVEvoOh68hVW9jaR2uUHZvcIA+EmK6xOfOnYRlGXvMIcygImHyat?=
 =?us-ascii?Q?arBGo81N2S1jiLacRHlqMa1qYYI71nOSWsqL+qbeRF0gaCkVmkK1PUUkwpWR?=
 =?us-ascii?Q?/CqtpM2wYU3hOyZHdF0kZzrxVRfAQcgG46bckklH0nh/PmOPIjAgOQWDj+ZV?=
 =?us-ascii?Q?4hya9imgNVqjWYZVNKpEwDhtmXzxn0WpainZ0vQhl9SbDhuuE28xk9J1J6Gg?=
 =?us-ascii?Q?uTffZTxMyPPVHgFPXS+yMqfWEB3WNHfckaoSuUBfCzoOYW6W6/07d+dcsurH?=
 =?us-ascii?Q?fleALJcUQVHpuDmZ0STHS4NHKzF3GrSqqKZOivul4jLWiHgg07E2NTDFrwFV?=
 =?us-ascii?Q?q3dTknePVs1I0e1Rg/vKxNxAmJIEPxaSP4AD9ZebP4lms/Uu01Kx/cnsGWIE?=
 =?us-ascii?Q?t7OTdBeUPpPHqe2ti1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QSKekpURKyR5eDDSq67GxJDzA9T5ZB1uQUQY3YlcaFDi7swxk40jiuHmErU?=
 =?us-ascii?Q?GAYsEzQ9Dd/kLKS0conS/mK/K7zulOg5oMN2e9nR5+9Ld/h7u+sys6QKONW5?=
 =?us-ascii?Q?zoaVab/vms1a4WFpD7FXkRoo2b62g2DeQXXDZkAsrRD3qktIx7jVTuS1OlkA?=
 =?us-ascii?Q?JtfOgt786Ykp4+yozgH5q3yHATYMo2AJtkBzUEhcvnXQ++BjPAnZ1ZjuzPjm?=
 =?us-ascii?Q?izyLmHxWEMAlCK0YsfVkRemaYzxjc947+uXqmULR6w0zTeI6Dsf89an095CY?=
 =?us-ascii?Q?l7dS9039YBuZHQKWHg7EXLMy9VvXmm+8UcfHorGGYRCSEemzelY/jqC5pIXu?=
 =?us-ascii?Q?ce80KBMYPQWWU/yyvzNT6takUO614YE0dZ9+WQDLiHOlAAbM2PmUpVcGBrEo?=
 =?us-ascii?Q?e0m4WujztzmB9TvGbElPl+Gwr0BYMBmvAg7a+9khagr0+9itjbcs6QH8x8te?=
 =?us-ascii?Q?xPhcs+v+ScLIqYKuwYJaDEO5kM4Mj/Jp3AhK8C/nuDYqbuOPiZx/u3s7zNPk?=
 =?us-ascii?Q?tIHfIxXOevWVCTxsajwv3i8HxbqRjO2OXwt72EOEVWWXZDrYvKnTN4AjMaBI?=
 =?us-ascii?Q?4gRIXZqSgGmPTW5TS3psEWnbyGKnhgV4H73MzOmICx20sCgj5DGr7o2E3aXS?=
 =?us-ascii?Q?EdEjhIrdGHOMHlTD8oI1wyfTvB8JCXrkYcvKtWmjF/NsXNg2ywx9hYgnVHUp?=
 =?us-ascii?Q?wPns8x7Sw6CnTEuYMCAn2v2rpwgSV6b951XbTpT+j14I+UoAsqWC6B5WU+7t?=
 =?us-ascii?Q?bSiTlDAHSl9po8ghn4vfoTGk5rZHa4wmNA12kU5Sw+5Hg01RZ7ZD5g/QoyyP?=
 =?us-ascii?Q?32f/d8yMx3h3LCKFtPaPAWn6rQ4wYAfDK37VHvYEMQ/d8p38QVQyGe1dBmOy?=
 =?us-ascii?Q?wWJPttS005dkW3pUsFBHS3Q379oiDpxkVETWoZ9Bg9xZnO3K098yFQNCYX9C?=
 =?us-ascii?Q?TeEgz+c8vwABii0BYl4NcX2ghorvoflPBUbB9FUbm77jWkc3Bw5FYwNrtC8u?=
 =?us-ascii?Q?DmO3NcVfcdrAyzpA2KW9iIjqTV6zd+IMbw6fx430304OVkBI3FlCC3j1Tu5e?=
 =?us-ascii?Q?qObzFesM0gK8+n3lmXDl6SzDlXgszmj++Dnl83GTDK7uTEqKtGhCXoTk1qoQ?=
 =?us-ascii?Q?JAQZ3Dr+bACUFTh4IgP0tJaTCyigBDYX3osTtmZP3Jow/gzimipuqWwIc70/?=
 =?us-ascii?Q?N4Fa/PjRYFt7Gad8lc8lg1HwsgcHJvkz4higJBnbZKyOEEhbtyGhC2WxRn4X?=
 =?us-ascii?Q?YwFRShfrDqdvdfp3wFs3zgLwjwlCYe8Dc0IKPp+6BCXZLqFlC5nbjf35Dr1y?=
 =?us-ascii?Q?rswicgn7GFgEm8ayblp/ZC6k8jRB6ajvl7yoGOf9LfXbRVDnPAIVCvrYHbG7?=
 =?us-ascii?Q?mrPgWvPZkIfn2OJz1XvyHmi1dpb+C4oqAFOTUQUHoNhSoBv05Bfz4eTJO7Yk?=
 =?us-ascii?Q?8cMyFgxGEjtWIcJLXm2aw8OSGjXgIeSc1eXhiCckf6w8mWzu8TunpiCt8Dsf?=
 =?us-ascii?Q?3sZt8LnekSuu4HZ6J1NLncvvHjCXwwUu3JWIYtOhHEWH6WA8YQyT5KqJuDit?=
 =?us-ascii?Q?UcWKxZbs8Y22kywEZsFOKDnd8BlxCKry6P7zXoaq7GDQUGd7E/kFDErc1oSL?=
 =?us-ascii?Q?xYEhvxyQoNv9M76wcymI0dKWFvVT30xPA6Lea/kvVkcI7wOcnXXwZZQl5/lm?=
 =?us-ascii?Q?TrsqLgXBeh70OtRQxtDoLCV5v9pI+HacXyhNEdX2kQGoNuzOsy3ewHbutTq5?=
 =?us-ascii?Q?7aRbGTQIZFgTlyTDdq5dpTzCsLxLRlA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1f66dd-fcc4-45c4-1bfa-08de6d817a9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:33:20.9517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BV8NXS84VbzYhbjxKsL+ZaZqGtPaMwamMDeZGgyrVgPjktm79tusapoAuajodJJZrN6H7w7aw5KMFskeL2nggC2/OXuAiNvwOGDJ4RLYfo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9452
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

On Fri, Feb 13, 2026 at 10:26:36AM +0000, Anatoly Burakov wrote:
> Currently, when adding or deleting MAC addresses, we are using
> rte_zmalloc followed by an immediate rte_free. This is not needed as this
> memory is not being stored anywhere, so replace it with regular
> calloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/ice_dcf_ethdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

