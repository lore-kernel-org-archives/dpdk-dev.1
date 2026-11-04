Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C1606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QXggdTHT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 723DA40B9A;
	Wed,  4 Nov 2026 17:44:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTPS id F30E040281;
 Wed,  4 Nov 2026 17:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793810668; x=1825346668;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sXqt01XzQy4d2dontsMVc4awV7OXBQKocwDGBjUrtPU=;
 b=QXggdTHTveT+CW8ZvszDk2IrxOL13JE/QQnmy8DSM2oj3Gkpn0ZSLkzT
 BTOFl79rYdWDa1t5i3SBhYxfQv3j7QrvVxEdKn3GFTY+wb+llY2LyznvD
 181zCOHj8KXm91rsc49KErycNdtX15rETPLN+WpGGfzPUQCaB5Y3LVgzO
 DwtqZt88tx22OgbFMii3qGQjamBTVa/0tj8GCjl1u+nLor+jCrHO/ub3+
 2IVcAFhncFNtjy0sgru0yEH8P5scjoUZOoPledFYLXoRYsP5OxakioUya
 KoASn1UJxZ81UlvdbEisnl42ifrv8OeSEVjzQAHIrUHCwcgB6xF9Oj3MZ Q==;
X-CSE-ConnectionGUID: 3Cn2sB3MTUup4GlLlKzNQQ==
X-CSE-MsgGUID: D3nqBKQQTCS/t7V8yTUBjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2453592"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2453592"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:44:26 -0800
X-CSE-ConnectionGUID: jZ8fhSlzT/e+pdiV2iaSgw==
X-CSE-MsgGUID: UZ7nnpVzSOmMI4RfjeTvMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7152927"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 08:44:25 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:44:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 08:44:24 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:44:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6KqZpyEwj4eZ+TwZ4s/WxB4WrbMBItFxyw4QktZH/oFsPjAxpWmPXePC/+HJv4p3RGz47Av8AB9bHPL1Hn1AZ/yJC5nsOg8MXmwIzStH6sXwt+FDxJpbNWil46ouj64rpWfExWYUdGHi3DwzSkje9u+2JfYyzYkSFNoTxyHAhYACNlcKuBwrLVsYhF9BGLdcnEQVuY2qNUeT2/Zz/rgHdkkltvZWaJCKFCpoLvPteTLXqZ1HDZdkcgZmO6oky8sEjr+uF3wGvzzCkxuv3HZjVn+ADdEYfEzKn7pLk9KBAop69com1oyING9Z07lcnaC7aTkBVtlIGffbSJCIBmiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMMLgRscqzvKBCKB1E3oLqco3WmveIQ5Q92iMQQCErg=;
 b=eE37IcrhyFQ9NOg9xymslTVaeUmNrt0q0zseuhJjBPI9N8LJb3CD0OEAlZsR+zshPlVD9fXWvAUeEiPYhAWTV++P1E/gJRyRTEGyoDWU4KMUSQ38mLnHUuut+bTU5vO+Ut27+R6kJZqVgzDXVTJCQMhRwcQcwRtddrrLPKdXhdLsrMscmhOsvt7cQXJLOl3AS86vBloHbBR6TbOq13fspQWM2E7zPT73d8K8Q7sVNfuPoqox9NGUw7RE/DP0qFJ4pV9EYAmNoEseBqqcrsmPFtvMTCiLQMTX6QYKmQrls2fWzTS+Lgrt+4TB0pOIU6Sw7RL/hLucZnAoIBtfT/NyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7898.namprd11.prod.outlook.com (2603:10b6:930:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:44:21 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:44:21 +0000
Date: Wed, 4 Nov 2026 16:44:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2 2/7] net/ice: fix resource leaks on port close
Message-ID: <autg4Z0Hb0qPi9ak@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793605751.git.anurag.mandal@intel.com>
 <9180f1bfcb85d3d47bf5cd4bd3b4b393a74404e0.1793605752.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9180f1bfcb85d3d47bf5cd4bd3b4b393a74404e0.1793605752.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: f15bc213-6792-433e-a8db-08df3a92e077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|6133799003|56012099006|11063799006|261021123027099003|4143699003|261021121427099003|261028144727099003|261022113327099003|261102123227099003|261026140227099003|261022105027099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: mp7Z171Acy6T5zna60uE8jbHTVpTF4OSDO/EKbJyWPoHTF+6Q+6PD2zzV9PO+rTi719Ruw+CGDWi67+RcTokUGozdHyqA2rEJ3JBggJf+PfSzUJX2NjSOUY0LVwP5nNrcVufjTsfFz0MEqbrvR3fKFFSYyCPYO/CykfIPl6NYZGpbfJKclUI3k9thfhWBarn243Lm8AT3QkD445ZtTQ/tgtmIEd03TtCjiq1+tca9wKUIgH/wZvMysnCNqzgRcID39I7TQmBkk+IkWeIj31UhNkggY39iwm/G7a8ZapJtyVNzOInm21z5PF2m8EsZ8mrQcsARHQZ9Y7Fk7RdZQNmQts/QSPK/+8TnbL9RKjIO6j8KN9vN3bFFwK1dmjppYqWREn+Vb1H96LRpIzvDxiJJcbQ0qemO/ARA7K0PW4sifIdTCZXkbHVg7guYHCdd4HNqMgcrVM15A9cjGgPJiw8X710yQ0Jkpka6708LEcbAOlSUCHcxq3mQjnMtM10vxw7W0SnbTJ2J2AHtXnF43nMhTnx8g7Wz59pkC0UuuuBfszrGLQODSi6bT8sZCWmSEjD/M0L8vEN6m/H4PHLb8cL2s1VwgmnuBe2WlkbDBQwJExBoTv8Y1fJF4EJ4UvGR4YQ5L9W0eKluA+nA6VsfRrmkmf0QfXQ+jHR9T5JuYp8dT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(261021123027099003)(4143699003)(261021121427099003)(261028144727099003)(261022113327099003)(261102123227099003)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+euP4Ww3RyVSaHGbpSX4v1ZhzUWLHoAn/5g33YL0sJ977/b4BNSRoE06qUr9?=
 =?us-ascii?Q?C+rxZEIsff35BYjvRotRwSOTYsevW1sxUP/sQRX/VE4XNkA7OWlx5Mk0zw2G?=
 =?us-ascii?Q?DJhW+/SQVix0Vs6RM/U5P6S5JzDFV0pW2bNp2ZLCqNk0rIodwDhlzCeDvmWU?=
 =?us-ascii?Q?p9RoEeMNRNgkx1KhitSaQN5Uq6C5UsnJEAiE+QOBfU/MFtYt6VL2FXacAzC1?=
 =?us-ascii?Q?QlSpVJNOySRFbTjKZbKIFSYQVMrVVI8aB1DiuUAJUKBHdfDjA9+8WCRF43Fd?=
 =?us-ascii?Q?oorjIuIlKRmG4mqa7f7NXPHQys1rYRwe0KLlYGzleg33255yWCaW6Gs0jwrq?=
 =?us-ascii?Q?IjVypBN8spoTpnKhZv3CXAr0sWXZAqTKviIUR6gsST+PVn4rm0PufnjUzBPl?=
 =?us-ascii?Q?OUXeIxd2H/r20mIuGEXrCHQUcywsK38OvQsiY7my+PgB8BmqjXLuyP+w5UEM?=
 =?us-ascii?Q?S5zsghyxha44BOFCTrDJp8s+gfuaDJ/e3oK4MdOWSEf/bY0+pEb61IlCRi0Q?=
 =?us-ascii?Q?YVBJpc+GRb25Z+RPP4Olc+e+tWsdmUq0szwOHUdOTfm+/rFntQx3xZo63hUJ?=
 =?us-ascii?Q?tguyxW4+k8NJNHIGqNeRosj6Fe0hMWBx08rNQX8khkVlB59tmXRCRgj1Jcjr?=
 =?us-ascii?Q?/4l+xX1eI8BAkpvnepZcXncZc9qypa7aXjHy71pT7PAeH8j/BOtQOWkmb3yu?=
 =?us-ascii?Q?3Jo/5AuDqprtGwLlB+3bFsI0h8nR7cdHD2XzUxfSQfPK3WdcXP/sgsn3/YOw?=
 =?us-ascii?Q?ykaSTy5FGSpUnkUqMwbFU0TnhQV22H2KNvY1Ln7U8wFPjeqX72o7pyrqI770?=
 =?us-ascii?Q?6IecTRQIvmTgPIB7FS6brg08bJqbRnEgGCBislru/0kzdbeKXMhdziaWvMvU?=
 =?us-ascii?Q?TCcgDrRFBq6L//Mh3g1T1T0asYjWa1JfgPrE+ecDU7GiWV9q96LwmIvmbOGg?=
 =?us-ascii?Q?tQq1Qk55CXINACvZy7y6TWPvs/uu+/a2n7t1pCJMGNx741IKUNv5xTKEdNcW?=
 =?us-ascii?Q?wImGZIOd7Y+RGzplvYZk8wDoGyMKGtq2bFiP4QvPKBo7d1AXGbULiJ66cFxp?=
 =?us-ascii?Q?NXMA8dX2j2riaW3Zo61oX2dIHX3zWSutk78tnnjHoP1mpESiJvqg4n1bdSNU?=
 =?us-ascii?Q?ZiT30zRArHB/SLgtrkGCBvX5Oer3tF9816pG6LM9BfK2sgs7g8tnCPR55vK1?=
 =?us-ascii?Q?tuyk2KJSOLi9UrXtELKG2M5QEg0ORxlrpCcz9ke16+ghnSpxAEQk0U2w48bT?=
 =?us-ascii?Q?/mYsaSyvbENNpaExgi+YPJMdCM2K8x/E2MWHLL16el9oR5fEdb3oVl3rRgfP?=
 =?us-ascii?Q?b8dsSXekkFJqoUmAEwfQ47Gz5P2U5ZVM3x/5uEA2EGlrWxrAsc/h76Zk3n9L?=
 =?us-ascii?Q?ntFszX/MhPR38FnNNndDnd8hpQ8JRxeWpZs+hYRgGZpVB/Che1Ydm1hrkQIM?=
 =?us-ascii?Q?d8Fv8PVhfSXgOBJl6jdvyRlmc1yGNW0Lh4+8hRPCBf2X/rhs/vltUWOv13pe?=
 =?us-ascii?Q?SLgdyAaTLgYX8ra6sz2AQSl98mMq0TuIU03jB67vSVj60PpXCmsdEJC9qKch?=
 =?us-ascii?Q?lVVxgjap1uyw8eomJWZUaWIRExF9qzgiXVLSQz8REvkgMlCFTtZzDQ8XsHRT?=
 =?us-ascii?Q?OWxMYUWc50bqzslorkMoozx3J6ZRcC7mXlWwscTTwnJfPWHrPXnBrO46lho7?=
 =?us-ascii?Q?fxfYVEd+KjPEPl4uN1GSGOJGsul9WDN8ReeLN1lbA4YARSArwfXQnoL66S1n?=
 =?us-ascii?Q?wop9ykiNB6zcz8fqiJJ8kaH4CUamcVU=3D?=
X-Exchange-RoutingPolicyChecked: p/JrU2xN8bxpx5NDi/y6MI9uON82hii0zczk3jhF+YowlE0fWoJqAB0jDypASxf9HQYUl0diUUYNAynOkv+I6AudORYoWi62g1+/PC8SXtJRI6sLWIwzjEXkY2kMlSzO6bmGhXRB2PpPvB7eBpXtTovvlvmaFoQAvfh1+NBRHomsjBylGOhPi8IFI0IGeUZz2LzfwPgtcvAJNXF1Yk9XmRdtNuMjPOm86ecpSONrHGpojWavGKhhMCgDeAyrHrwJly8sYXbVAX4Cqe1mCB0jGJ3tOjKK1X2N+qm2EUZ0+ifYQ7ody+lb3jZd95vlx2gOf75NNtAOWhtpnvW1AIe4Ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: f15bc213-6792-433e-a8db-08df3a92e077
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:44:21.6902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VfWAJ1umAS0nVRlMOQP1pD2kPBZ5m68FWXck0QoW6X9p5HucE3gQpzT5D83/gNFRJzbbVoXKbGoAtZu1KHYqtJVE86Z+k6a85ou/PvCb+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7898
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

On Mon, Nov 02, 2026 at 08:10:32AM +0000, Anurag Mandal wrote:
> ice_dev_close() tears down the hardware state rather than with
> ice_deinit_hw(), and misses part of it.
> The switch filter management structures, the DDP package copy
> and any remaining VSI contexts are never freed, and the flow
> director counter block, allocated by ice_init_hw(), is never
> given back to the firmware.
> As ice_dev_reset() is a close followed by an init, the memory
> also leaks on every port reset.
> 
> Call ice_deinit_hw() instead.
> 
> Fixes: f9cf4f864150 ("net/ice: support device initialization")
> Fixes: 9c4f15901ada ("net/ice: free memory with matching allocator")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
