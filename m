Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105EAC88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:52:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EA2040269;
	Fri, 11 Sep 2026 11:52:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
 by mails.dpdk.org (Postfix) with ESMTP id 7261540264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:52:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789120325; x=1820656325;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ehMkKJhwQGEYqgKUi1W0x8sSdSmyzi81YHTum14pO58=;
 b=d4rP6pK3sFmn4ssxLR41pRi6lmLUTbF0gWZWHI9N7iP+pUZMqX1jfhcv
 OQZu56xhY/mqB/+ZcuF6GHGJZ1S0TDqU7ZCCS2YFXeiLT2ZNy88P9hMGa
 jWp4d0WGzxvk0377c7bMcUWMPE9yzNeH6e+URBxrikqkOU4RlqXDgp+sO
 2YLT+sq7syzqq0Wh1vpVfPvfUyZhqK9b2cZWKX9EOg6UPpTaayGOFVoTJ
 EmigXVlOaGPluSGSP4fsU6+SWuYQD4Sg4Jzv44IJYusbkPpxgL1dgfC0r
 nJbLhsj7Jn9v9eL0L5pyT3yTynpbiGu6pU5Rr44BAJjjI5kyrzGeMGH0H g==;
X-CSE-ConnectionGUID: KuDkDP/7QMeTF4W/BJhgvQ==
X-CSE-MsgGUID: 8aXOluclSUWCNcgxigGkjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89876"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89876"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:52:04 -0700
X-CSE-ConnectionGUID: sdAlVXCXTw6tYBmoAd+e/g==
X-CSE-MsgGUID: IcWdjVZyQv22FzHbUsq0TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="170711"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 02:52:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:52:04 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 02:52:04 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 02:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyGt7HzMdn7vs4Ew5JI6sDstfXye6tl3j6ongydxXJ8onlVyYGXu3YCAD60bv/SYEdlO8L8YWwlHZcqaok4UAHgWFwDgqJrBLrID/+w4MrR3y4RmkSn8Mw4jEdyxOGepIERDbH3YNVtAMtZTBMNd9DqRw62OzbUHqN9nWuFd/vKfbjJlrhpnqBy++zlInWPFnNFYAx6szfDrkC89kZEFlyZe25jwCYGRcdIC/9yg8Yht6EaXdP6FbXhHjJ2bsuO1jOpuVKICMpaSEVU64fxr5E4nIEnLAufZ/vepzxTNgO5z35N5iwbObhZoY4wb+BP2EWVyFVxCVpYHQ9/JM6tMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XM0hF6z+xoEC+f0CdHmnRzV/xFBDHcGCvwzNHJcro78=;
 b=WTy5J1UmneWJvDtAlNR8YZV6haY21VzhMAQaP+tsGqy/sBfsLu+cn9EqWxMahCNbIJg+xKoYGV6LtAnAydnMtr+yR1IU1IG7G/DsyRInw5xPpHvIdjPdAyZPNWOK4pidz8dG39BgeHN+3qxqgpkBBXeusjUZE3GbbDpMZv7oqpv+4klWl2SQt9Ok3pBNtGdlM2oN4MHnZL+ceIIOL+2LCee/kiGkBNhDHco7604/anCaG+kq/DNRUIJ+F2+9tSuDy5Ch2QYr9gvlMySl7UbViqoEhV0HRFjWAoXBk6YdBHsrdDQ7xa9QViLfjiC+hY1DE/tJAj9MxL/XGnKnPsK9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:52:01 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 09:52:01 +0000
Date: Fri, 11 Sep 2026 10:51:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v2 64/68] pcapng: replace use of rte_memcpy
Message-ID: <aqPPPLvQLHBIxO67@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-65-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-65-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 34264e40-98ed-4678-ba4c-08df0fea53ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a/BuY1/lCkOR+Q8iG2hpBoJGHbk0kTY0ZPQv8bz4y72MN9/8tiC7HVhzTSdN8ZdGy5V+NulOx0zYyT14rtxxsq/qzFYAhhzrQEc0TTzKMcR7RUk0L4GI2ZdYQ7P3Z9P3a946eA+m5/SJuy3FnTK0gb9X3jmLYjmScz9YmcNTGuS3CdwMtzQAKrDdWtj0LtyVEmXmZAaweUdR8pkb+RdZ4MqYEseF9q7Mcwg3UKbsD8xyMF5827Ke/6IU/gKpz9FN8dZanAGZLvxaoO1fwKEPPGHRe62aX5GjV5LHX7kqiHb34Ts9mdNWMRmCH34wRvMdcUU9rEbgtp2vRqxQUt2KO1P3gklRZMTLySjS1cDSx+/xdvrSHQsylFc+ZXXNj3Yanzt1Nq7l08Vfmdnxoex/yytFUBmvmmFefH0gYR4EqB5SJkgBRgtwrzo5mowM5ULjCrInfTSihrwKafFvqCKWeQJihi4gkuu09QOytHy99h0BTHA7dvzstWa8uquyLBnb/9+PJCBDIEsBRAaDafIv4d41KC3ixM9uAb/jCVLgNp5NZSf6AG3XJYJIqgbnW/186o6GIuXQB4kIMbdrxc5kyHcjmsMFF8UwSLkGSfmmSsX0EqZrPDusXd3P0gN+CQeIAAuqQFPSkds65Pm4LJCga4Poobcc/Eo66YkWi6I+uoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1iYJyY29J4ceEzHzMcuPVA1wymI/expBMuJiCmmp4bBa/Ll1sSMog6IMmVq6?=
 =?us-ascii?Q?UvQdnH2PvJGBbBxvzbO2E2nJHMxi+O/aFrTuPtEDFx2hcEeG1GD1a3z6UMj1?=
 =?us-ascii?Q?W7yRaHDSmD6YVG9V0pg8uKdnGv+zJOltjpepEJct3rX8LDLmsy+yQSDJWBmL?=
 =?us-ascii?Q?U2Dm15QvJ+uz2KNbP4IBQ912919QiStc0IY3YWgyYaPaf/D1z9fxHPbw1IxH?=
 =?us-ascii?Q?7MXLsRBghBS2ZTc1ucW3aNeez9PSi8XWmysDjXvZcFD++KdIPEtOSv9reoiQ?=
 =?us-ascii?Q?u6BSvtLqbyAbj9oKdaWvkJI90KduEqd7k7Q1bxt5S/aBSceJPPtBCDnLDVwC?=
 =?us-ascii?Q?Yw+sJJEA7uVmOZiRut3DhedBiwDLKQxwmCTFPShymfJnYHQAG6Zag754u/H2?=
 =?us-ascii?Q?qZRYp1c29+ZL22VPwQCPHuXdpzONcID3dY/jiBaLFC9IzjvTmJ7xVlHAzQWK?=
 =?us-ascii?Q?4qXWEVAB4KOrg8bXB88jTJ7+qD8p7RG7a5Z0XPDNpzR739Fa3AV3xdEky+Jh?=
 =?us-ascii?Q?P2qoYkqXh3JjZSkF0pa341LkXEffrTJ7PH7iBmVpy2JYvGCGco5hA7v4bSqq?=
 =?us-ascii?Q?qUuQ/bpjH2yHv3yLbGc4PAeRvqQsrxGjjRADQkz5xSIwEbz8jnXHR24i+UOJ?=
 =?us-ascii?Q?u6uCfXCkhQgoHUeBYi6YM1TLCkdfbS9UUoEExTYjJctI6GHEV7G5TTGKxEFM?=
 =?us-ascii?Q?PdbGj0ka80df4HqWKqTx8wpwXQ+1nI9ejMaWRIaTnWCR6ol8deNSTwPxcq8Q?=
 =?us-ascii?Q?F0UPCyxW31JpiMt1YCt7iasBXLOT800EFtExf8fOPg60WhZ+YVJ8V1YbsnD6?=
 =?us-ascii?Q?EsjNvXI0SMrW4b+jhGehjv/XZd5sgHlPC5OHdDVFMQTp1OB+45iv0tb3K++Q?=
 =?us-ascii?Q?LorBXcxfIWjDZMd/Ei+kn6QhwwOtCwTM/Ke5Aj2wZ5OIGFIDGLNO43EUw4jp?=
 =?us-ascii?Q?yHMyc/czrNO9qpAFs4VY8BW+ZffTteCJrAYF2hknDsJxEgyOYKuHxt03BAo1?=
 =?us-ascii?Q?5w6dXbBMa2/zDnPtq4l6utMSFmyR9i0uZXmXAI4upi4NT5SOmsDRRo5L8TiO?=
 =?us-ascii?Q?fmyV9PU118Mg+/V3lCTGCIMg2OMxs+nxQk+LD4+Cx7KVVHvVziWIflkZ7T27?=
 =?us-ascii?Q?+0cYKDEFXw7AOyJy2pbDCulYmNLYaM/x5a6bJ6pa0FOoLG3abl9bmbRQoYbx?=
 =?us-ascii?Q?bxiK3+OxSOEGeG8ecpMhpUrVRiT27g+kGKVqtA+7w57EG5arZqmFPPsAKzUi?=
 =?us-ascii?Q?TjQkz+xlDfX7bwfq3K0RAzIe3Zsb6ICXag2w/ErvY8+9wzFJO0snsizWu/EO?=
 =?us-ascii?Q?cWzAU+0u2hUawPNioa/NcJRWUSBZ7kZ2c1d8rt7aL/xDRL430mPkquPa+5DQ?=
 =?us-ascii?Q?AcCPM9Zm8A+D6MrLWPuvmlu1sWdJWsIPXMtehonydo53TAYLnlFzNWfCvLbY?=
 =?us-ascii?Q?CCJdBIXB8N7sH5A25lMY+3I5OUHc8tDI/liqLU7QtVbnwhMeziQExxAkzlLu?=
 =?us-ascii?Q?Gj4FUlPuHNFOomNkVKjxxsfBJ1nF89TgptIvwBzmpBcl8PW1WNUTf8QRb9Fm?=
 =?us-ascii?Q?U+Kt74jtizILtWVe50NX/QCNaID9hQMO7i3POOEDuyVtDqurZ/6WbCFCM+Oy?=
 =?us-ascii?Q?Zw2/lkdgJ2aqqo7Al+9EUd4QEGbs1qaZEOMN2mlMPhz+1Vp+IEwl6kcosGD1?=
 =?us-ascii?Q?yYenJnurPguKZUqXpyQoqsCnZH+WI9JX3AyxVzQoBvdl9iEiFfeQ0pdlmgnB?=
 =?us-ascii?Q?Ft7SpGffBTw2fKJfZJp9ahy/tCPJPMA=3D?=
X-Exchange-RoutingPolicyChecked: r3sSywHVCOot0CGDB/aUrDTJbZbbHU648rEmdPzs/gIwtYVqNdOL87lsxno+2+4FeXPBKcxO++GDIUh0ApYt4SXkCN2oG4XY5tiBXnA9vW9vAQjEpahI85ECSEtAGziB+JswJAVdnOWcev1G7XzE3Be1P6uVwThRFq/KdV728L0sUTqB4lENWFYG1zvhu6gy58nRCJgOfyqvdTQs1YTDTZB8+cUE0i4rvEP75HWsvY9AQYVPeqNaIY2efMKjA2zSazpO0GLRihwb2vdaikbfYKEctYiyC376zR02oaMFYuSwidktb0U7sYjIWjhnoFHgzXzYJAYYfjN5FlR9hoalJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34264e40-98ed-4678-ba4c-08df0fea53ca
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:52:01.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPzAwqRhbjJy01suhzIgLvj2NwVZ5tc4rOv8FUtflZUCg1oJF/9BnVstkOK/bpFfJXnlmR2yVQTRjUXv8V9XxZ3mvUCB4iyOXNdyDSjHzZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
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

On Fri, Aug 21, 2026 at 12:24:59PM -0700, Stephen Hemminger wrote:
> The rte_memcpy is only in the wrapper for Windows where
> writev() is not present. Using memcpy is safer.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/pcapng/rte_pcapng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
