Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F79CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 14:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB87D402CE;
	Tue, 14 Oct 2025 16:38:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9DEC3402CE
 for <dev@dpdk.org>; Tue, 14 Oct 2025 16:38:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760452733; x=1791988733;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=O9+W3swV/jaE8cGSF3ijnxKqfWdZR6bNhiGsvYaY0MY=;
 b=Q8wnM4eRW9eJBYEIU7wWEtoz2DGXSJ/bqHERCNMZIUIuEYt6PB397c+a
 258d4UixOALP5TP3xEnQ5T5ut5nhiO+NUZLWki+r4VyQPJZtjtkOdCm/S
 UfPvDtlw4TFqXaYoTbjWkHrpph9yqz2kOus7uo/aoemo+gPR4kSjNEDSq
 W3vcMuYYsl2ZYPPaEhdsQ4emWAw/6qWaPkfGHhdvSid+lHDSWwfZGi7HL
 m2zBNSVLzTK96bQaoG3iq+0yk64lAPKlpdBjtbsNO1ZUiKC9CcseslyvT
 ZE8nJK1B/prUSZ5ix33DYc/oQqb5I+I4QqYZFei/SG/ujpm9n0BKXd3dA w==;
X-CSE-ConnectionGUID: yQQDzzNWSY2OqnWFDpT5FA==
X-CSE-MsgGUID: XjSMKQORTMCnP21PSgewVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62523620"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="62523620"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:38:52 -0700
X-CSE-ConnectionGUID: Uw2GSTOFSJuhkmlOMpwDmA==
X-CSE-MsgGUID: qHAsBqsoSg+sROx3ltrvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="181127334"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 07:38:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:38:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 07:38:51 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 07:38:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqNx0P1mgR8ujhE9ezKBgGleoSfJInYewlA1NHZ78p8G9fvjO1S1noBaWy2d0yxGrDqrmyzvOtoslfZOjiuooKuDuyHs6/VvVlyeAC76Sv1sPXL/4OoAr5/lnXJhTEDDXzG70bfFcfditO/Q1y1iyho7elwyEWdvRAHzLfy9lMqtIq1n+/leSjoRXbNL1HYi4ArIEI8PNz9nMC8jlO8oUl0OxuKGwyZHfDRmsw798cG85dw3HQ2yjJhuYHWxY5doXhth97CdveaiIfW/hkvFIczUBy+vbZkdWhkKLADGrLYiMEibEXL9TcQSqgvfuCIHCxJ0PVrM3Etrwa33pEW5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g4CeCvwGgsowu46RskKaDqyWP/7zIbD5BEcP1PINlA=;
 b=lu/SVFn58yX+QFij8X4Mxfo/bFZqqdoau36kkXsGQY4EzdPNPk3Rr7gKYUou82vlBI8mEiHT2lKj7aN/nd9V7VlNDaq5dyDrl8lsjEvDkpG4zXMCz6JrRYZpNw2/JCi7ygWzXvKZLvMQVyRfsMqRpiw99Jz810IEBzwsNbeN3yG6kzZbyAxy9TuE0m2D/gOilNYC7H9jlQRJIGWQW0hxWKd4iZCjYZQKi1GFzneu1G1lH+c+9oPz86KBCpR+lwgyLXxf6w6xq9WpbMHGBatKeudUNWyTUZ0lAqQlBUcTLdbaCWQBwT7GdB152sBclu1vuygJlU3Yplx7akr3Rs55OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 14:38:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:38:49 +0000
Date: Tue, 14 Oct 2025 15:38:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 5/6] net/i40e: reformat the Rx path infos array
Message-ID: <aO5gdY4vdmgkx_Ee@bricha3-mobl1.ger.corp.intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251014084517.1407407-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014084517.1407407-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0239.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: d30b27ff-6c27-4b8f-c8e9-08de0b2f6397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d6BGQwDC27ur0AGB79naiGN5YepYU4jmg+rUFKt4PxhFTX4tWHawJj/aZNnJ?=
 =?us-ascii?Q?wRIVrUlqp6IRy2n66ZVked47nQN1SkCFFVKuzDmqvH9Fir8W+IzyUr5HIwe/?=
 =?us-ascii?Q?3gDtzXca8wcYKKOuBh1MoNa3ASc7mMKwoeKv2U2fnwbe/zS5fpHReXRM1D5E?=
 =?us-ascii?Q?JUC7RrzB1tHAiipxChqK2Yn+UdeI5a76GoI8qHlQsY6xsD84GnrgwvpeCg7k?=
 =?us-ascii?Q?/1Bg1BbUKEG/Odvtq71rghjL43tJbTNGQkgcWYZDTt/p7u75pbgI/5hQY/s8?=
 =?us-ascii?Q?KmXEKa4OHAxYDvYv09nSRYjngYF+iH7DeHH4vLIsNBRkzrlf65bCTW73WV/S?=
 =?us-ascii?Q?dIzoeIaenXcv78ypSjxsSMWSrTeaDfBcnFyXmt14DexUL14/rtux93McKn7m?=
 =?us-ascii?Q?q2MLHcRqTgR9pu+3Gt4T9mNlGsAjyLqRWAIPlyObUxUJBbESlKkEqLvJATEv?=
 =?us-ascii?Q?aXRK8++PFxpAzBWZMUgQRwH3Sjv1zflyWWKHx1cxQ6QaLkgoJ4FfGkbi7IRb?=
 =?us-ascii?Q?917r1vcZ6Es4mjjeOYrTzc+dQ/Vl/1kPeIu2RXB/bKArmgqRub6CJsVYFutP?=
 =?us-ascii?Q?Qug7U7oDgUQo6WTGUjxCc9vR26I1EU7XchqA3x7ulotHYYfh4ilgixt0bkYK?=
 =?us-ascii?Q?Pwwa5t4PrjhJotBNQKmVKbt47MENO6TJsB5SZjGUp8IBmN0DplzUyuGZmWRO?=
 =?us-ascii?Q?rhWUuWP5vBx60ICiCe2Qd0tlOs3GIaGnKGlK3BnCNmPUyg9BLJ5qZLqDI3LU?=
 =?us-ascii?Q?Y6VcVRAxV/Y6OJdicUr7rOwBXmmwCzmdP4+4Bk9JJbm6bqDsp/yj/sXqU0Ey?=
 =?us-ascii?Q?UXNaC3yxqpZqgu6x9CydyRcn/e6WiCrp5jd+3elK16YGgZkG8lG31P9otRHW?=
 =?us-ascii?Q?aUiS2qB6i6OFgn5MYYCfXHmcNByAf06EvPp1gdZEYcEqK9ImsSmZszCYFK6x?=
 =?us-ascii?Q?3iKLWBUMzYlI2eslimspCTvQGHU6PJagLbvY3R31isqSikw44yE68/Q717Mp?=
 =?us-ascii?Q?nOiavpLUhW8OfMD1UUqE+CO8QT/M43L+M73j7TjNZSmssf40KpxDnIEO/1wA?=
 =?us-ascii?Q?Okit/tLvENz/SlWJaH6cBdD2o6kLmYW8oMdqve02v9fvVa4iZuC6waUQ1ZQl?=
 =?us-ascii?Q?UGqbKA24YFII/FgX0Ijjd/Meba0dJdcBFGPCJ4Yov5HdXf3PvzqW53l1jYcF?=
 =?us-ascii?Q?yw376aRU6X5KX1ATap9ptySBfnlMnBfFWCN9ovW6Pwwcc14i4HZ+E573KQ8+?=
 =?us-ascii?Q?QypobO/+p8rVisxqU9oozCde9i6bSzH1ov9BKu1pUVqiYJgjganzUBxOYrlE?=
 =?us-ascii?Q?Mgsw4ziYTjIuygzM7uR+CaiL4rs9tOqqbhQJtERps0vtDGZppAoqMnsVfiOI?=
 =?us-ascii?Q?MsO8dCOnuLympG50D3jLKf0MOFheeNkFa2sZXjQy6a3RTypk1rFXSaqVpEbG?=
 =?us-ascii?Q?J8OlOBn7ta79m/3rZ64HGWbO6ggZdG2v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXyGwSnc0UUTmy19AOnZgShkLArIN5H5oRBkpuf6r7ipN/22e6ydi23prbxK?=
 =?us-ascii?Q?3ogaaHicj7C8ZAmIb6gmSmYZalNr33ThvO3WyVo2AFB64qzJrAV88RCeVOYi?=
 =?us-ascii?Q?vK6Mv2yWdS95wCn/4bS7ZxrFQ6wmmj2zkzEGtpCxQIVFhaKjbp0xAMQYio6P?=
 =?us-ascii?Q?qEUy2M+uWIjaUIxFvkhkImC/3Igm8QNgBO9T+ZUXwcGB7bUoIr0Z8YseECWK?=
 =?us-ascii?Q?oaH1QzfVCYLmKjFVD6DzIkSBK//Cb1AInKbV0CKJP/vsrG6UmmUuwH6kyDKF?=
 =?us-ascii?Q?zt6mFatIqTjsD4GuULO0hd9zCTCMEh2FxF5BaNj9AT91w/6qMyMsmhiB4k1R?=
 =?us-ascii?Q?aBB1jjfjGUdXD9RQ4S1m2INmqXyOakVcS8oTJUZHjP2cwJuDieeKDveclqGX?=
 =?us-ascii?Q?TlDqK8nX+xMbLUBA3Ma4YVzFzNiTw1tWTnIk9qj2uRzRRNRo1LlvtE1uEV9l?=
 =?us-ascii?Q?Kca2RySvUvedUHiIMYsQ+75pX61mBnN/xgzm47drcYMuVsOnSMV+3ORP3sgr?=
 =?us-ascii?Q?iE8VNO1JM7tb1A9jnr+Susgfh83liqBxS7e5Rwuvph4shv6TJDncSAzBvTbJ?=
 =?us-ascii?Q?WawNUafpKggf2xxjRIazGv0nz7wDBRPbVm2fDgAe+jk5uJjl4kwEcRCx5NmH?=
 =?us-ascii?Q?iQ2zgzbTqhKVYQSa0CIU8G7mjscoQRwHdUtgXsM0aSYC4qjTMEUtk0VAMy0W?=
 =?us-ascii?Q?bNLM+VqUNCKhgoZk27bomqgLAS4Dqci39QBBTLLIU0RkAWBFZG6BOFjSy6es?=
 =?us-ascii?Q?+o/kp/YbaWsggLTNOdq06zKncTtwQC9dZfGNYVvkJhr2jMWFS0Pggz90FrR3?=
 =?us-ascii?Q?2NhtP4BflXraaWaJbSq4j1zhRDvbxhbxgZUCkin4VAKWiAaGEbHKfsEY8YuJ?=
 =?us-ascii?Q?PYh7xyBW0yRyLq+L8QsnZt9EyQr37afWw4CQZAdkI7utS7FwuHldP/8vO/uc?=
 =?us-ascii?Q?aa22V2PWoCzVuwqyazPQNjJCY2PqxBwPONUa1yW2L07d3ypjmdLHiF6CkTJH?=
 =?us-ascii?Q?14PNOgsv7E4o87S1A0GpQUBAjlJkAH9RWBlU1SLHHZHtGLGA5EPz3IfzfIyE?=
 =?us-ascii?Q?ogM+mHvl07J47gY0zihGauNEdyz+It3Ue2/SGO8nuXcTkvOEyTAH4z/D/TsR?=
 =?us-ascii?Q?r+wor8zhV7Icnqvj8X50ZHsqROAfoNJ7huLdQzf9upOIkHVWhtEt3YKwe96K?=
 =?us-ascii?Q?Uc5Ysptc/lG9Ztcc74zaCNOx5sfI/fUrkuG3zi/B7T7/Sf/VQAYv8u4uoJcz?=
 =?us-ascii?Q?xetyHjGVphfRBl1Zdi9+PCJpwu/5OWRMtfoqFlEuUkXXvYhd2YFc/t37LdBW?=
 =?us-ascii?Q?aS1JYFmX1xD0YQQ+79vyXxW63/IHwihc1vE3sKFbUA0CCOtzxrG7r0Ddoyvq?=
 =?us-ascii?Q?mGMs05PmhtyhXI2+MfIFgHan4KEEKtuN+iy3TO7UOn6Mk4IeLqnHsEe3XKFX?=
 =?us-ascii?Q?IAQp7nC67kg0FVNWMXuso+oaW29S31LTsr1EbOqKs0s527Z6ZROyEyw5xzfU?=
 =?us-ascii?Q?9CuSjkFi5LhdOkBaoD5gYkcM83fclsyweaC5Mj0M2N00bTaygn2q9beT1hj4?=
 =?us-ascii?Q?iCBnLDTh0ChPZT3R0Earb+9AClLRZZKPSR7dONRzA/ncWx70ATrmJ9Rw0aUz?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b27ff-6c27-4b8f-c8e9-08de0b2f6397
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:38:49.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x6VA5k2UZfbCYyNl2Ksj4SfGtsYYHxlm3hhe1dFtegLit7qzWhsZWs7ESUxfXv5/da4iABztlr2vt/IpyFT6PbSoZbPBi4zAYMw0hh4xGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7945
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

On Tue, Oct 14, 2025 at 08:45:16AM +0000, Ciara Loftus wrote:
> In order to improve readability, reformat the rx path infos array.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx.c | 126 ++++++++++++++++++++++-------
>  1 file changed, 95 insertions(+), 31 deletions(-)
> 
Any comments from previous patch would also apply here too.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

