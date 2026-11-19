Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E51606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nQwDvNmY;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=StIGxrhq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFE1140151;
	Thu, 19 Nov 2026 15:55:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 5B3D4400D7;
 Thu, 19 Nov 2026 15:55:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795100134; x=1826636134;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oujI2u5gH1nPLJy2a/QPRgFqWdqwuzJzHjd6WroLerE=;
 b=nQwDvNmYBBxZ7G+MeckOlFil58sKpE5xOvfPT8hFRxGuL/8EAB/QUVi2
 EBYKzeMbWTyfq5roqXorol6BMScSK74W/yYLBfNQF/HXe1KdVraBZbrtM
 mlrtnfLWhj+q/CqPmNRIOyrKxEocJYDnuBJwqCALe+y6f6SlPp0/DgFV4
 vfucStSrPla78NGSl0VgInrf8LPddlSW9PE0vbsJC2x9BJu+ix3UgqM6t
 GfY0hRwJRfqSaTD3QPlQ4RR7NScwLSXrFgHdqSNg5r1JInNBH2RablleP
 tmqDXVMAN6hyQJ2iofyFoIK4tNE7avnLwxIYW4SDHx9UE/h8w8j1O5w/l g==;
X-CSE-ConnectionGUID: VOdw8T9ORle6Zl3QxPcYvg==
X-CSE-MsgGUID: AFG0g4g7T+ur3yVX55jjhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3986672"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3986672"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:55:32 -0800
X-CSE-ConnectionGUID: g121ET/NQgGwBz+XgRrUkA==
X-CSE-MsgGUID: o9ymPry+RraL+kNioei1dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10438487"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:55:31 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:55:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 06:55:30 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:55:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsBpYWkqssuYoN6yWyik8iZyJgk5ZCNTek5Z0Lefs5H2RWgMGKxdz0IrfNptVFK1RHJzEmbkWELV/C7QQffmf0IOckGXTKDHy3leVKWUo8/BeTIMVC+xvB8vF3i4KWFoX7NwvqRwzp/2rHZKdilFyBJwSNdzmA7QrsyYisJU0y1VnQRvZgdyIXHa8VH1cXgojKwPG1OcoEHx1ScdWMiN27Wm0APXyeDPccpTApnbVDcxYO3q1KJ2hyMcNaBcU6zRsp3aHq/IH2AXW22CqKxZBijqKvhSh9HNZVI6PBI3eWHfJGpyXaz21+uizhivnDCCDwkB0KG/k6f42KO3AzuJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHySxvNXKmDUACK479AitHfqW37YNhVbN26RVvD89ZM=;
 b=Ro6bkSDrb/Qj30vyY3cIYgZp2eog1zHlEI7hsSXL4EunOnWkMEP4BOiKsOJXBKwQwmix1kRR4WrOfZXstbhQOc702s5RwdAkqtBdTRBcQc3sJ7aaxp83xDkI6F15HcoXEnAcblDGmhzPPlhQDc9KfWm8Ln6CgZx/yshHWySemZMcVBtUg//5HAsPwkXDCVNyW/Kvx+g174PTtGX0mRUdnr5fEFFv6vZU9mR4H08NLvkXevMVXTUIaelDWWHi2tcIlIy7tL+Gekfb8RkfLvCOcZN/qF6AvFqPdRbOojKKOoZ4w9fCt6Z1NrRPCo0tWsbXPjOIQyGJuCJ+9HAWRcZJ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHySxvNXKmDUACK479AitHfqW37YNhVbN26RVvD89ZM=;
 b=StIGxrhq6vWW1SPpARCI3CcaeSbOMQObGOpFxrG6YQtMrYFZSvAH/4005oTdsot0DvJ4p+1VV+oxMRZWu0O+osfkVqVdcnx5OkR7Q9yt6VOcLuvF3pemeEGUSE+sqZ8Rb9UdOPp8g4iMYAHl2YBhR4bAuR3d28IGDKYvESP3y2g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by PH7PR11MB6056.namprd11.prod.outlook.com (2603:10b6:510:1d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:55:23 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:55:23 +0000
Date: Thu, 19 Nov 2026 14:55:18 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] Revert "net/e1000: fix queue number initialization"
Message-ID: <av8N1g7MW7-rpBJs@bricha3-mobl1.ger.corp.intel.com>
References: <20261118102927.2679783-1-bruce.richardson@intel.com>
 <IA4PR11MB9278F10AFB677692B12034738E792@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA4PR11MB9278F10AFB677692B12034738E792@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0283.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|PH7PR11MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 14acb00f-7146-4b4a-45b5-08df464d2362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|10067099003|56012099006|4143699003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: DDMldxhVaXC0EhXcnHcVmDprZCZ1lKUEcLTyIBryHLtYA4IA4MM0UaSGdtokt9r+se6KIwU1ritLWhkYFk9ddqRhCo0loOqFMT8VzG9UZnTgtcBwabJnDx/Fy8KPln3c+cljyvTKPBGd8OzjNPg+vlrGUiRKNs2M20mSmJ9JuV90dScCEI7Zgir9dXDOccqEz6IW/n0nOgELzsLcRxkSrX05MpbACCo0U8pNaFuBM453vpXv6+FLanKE/BwpKlv8ILENgpdG1gpQKZ/a2nO76rRj1jLFmBTyivpz4XuoFvhlx1I2SsKtgeFK4eDG/UpyXePsFAgLTkcKuFl0nhtCJc2q3Ps6fUN8CeD9ByPIwu373hJ01GliMw2cnUL2e0lmUrcDY9v7+Mq+7eqgVf5dmNmOWmlNdqmstq93Nj4DxoKlOe0lzxvLWMYCcnW5bOjBLr4C9eftkJBmkztzbmjgg9/LCfk6RQ0e1GE4vfEAohbpdAPaDRu2Ldtj+6pJYeRtJFzpPZK+tqsGN0V6E35Bpn1jN0mq5erat4NdOWrMG2+z2z5HI5uAPPSzU+WgHFAsIU45MPKDvvJRC8tutcL9S7Zb6OYPhZh6HoGgmSOoQL+iB+GrpB/x8F2fKbK1TIzj7Nlp8zHPiBH2C3wETrFWuAw/wKNnr/rO2UP+XXZKe8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(4143699003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P0rYyTmKb6BHVMSd8tNz+ckl5tYaBOOYudjse37RWoU5QzOSx1R4MJbsbto+?=
 =?us-ascii?Q?df7R9Bf7l7+T8mfs5byZn7BtZ8uoQGnZJmYREJ7gj1kX1fDGuYEG2Zt/oidg?=
 =?us-ascii?Q?tzjVMXxvk1OLy8Tjq0jygEWfAUTebNbD3+5U0Nhf3DUw8Q6EhT8s6+EAfj79?=
 =?us-ascii?Q?mYiDpO4Qse+iMsrZQVmPWhrq5n8APpimYdYZc5wZKlc7yIHH6VK+7li1IZ8y?=
 =?us-ascii?Q?TcyxqUIeWW++4wX/PpNGZgKHUR73pgTlSNwSBYMo0Q5Mi3EJuiyebmDv98HB?=
 =?us-ascii?Q?eslKUvDt0jRVF8kZcRVlTtf+B3h4Z0W5CywuyUZRI+8p+O21kE/0Z2kaXW3/?=
 =?us-ascii?Q?r5HptXgA6qs/TFogjlWHuP+X2OgJmAc57cKMabnMxcIOS+LXKrINTdimJZfc?=
 =?us-ascii?Q?GoP8BBIn87NgbGyZ1IQNlsuZemrIUX5hxj8kzX06wZnBYtoRGejJmP84If0S?=
 =?us-ascii?Q?WrcUPY4oX4+AY8sBd8h/llI1lyKDJCh/ZEyFQqT6la78lg5jlUpg4hVqjkkn?=
 =?us-ascii?Q?CcHYbGzuonQN+mz5v7uDEsz2etyJVL57FgKSOgDvkjcsEQhcCAM0jOi7kCWb?=
 =?us-ascii?Q?I1EjWzoqBAP8h8OSxZ0GAAvjY0scOnSi8K671BZnaH58oa2lgfupIv7YGXo5?=
 =?us-ascii?Q?S6ELPjZdPKW+soq+bCc/dhRYwDbZUNP0OJPgNhsudD6X6LaWltJ8KfFaSMc3?=
 =?us-ascii?Q?2lsRSKH+V7OpeujuOg37/PKoO/Ddi8kQQQEqa2LfA3TY/sCmdHVC7PQ34NeY?=
 =?us-ascii?Q?BU8XY0yr41Y6vBNLjPlDFBgIRuE1KIyFgJ83qwMZB2NwoQrQU/jTjxSfm0n3?=
 =?us-ascii?Q?wqM2Zd9YyaVbD+MH+TBllfCiuLm7m03I3nnCuf2p/oNAgtNWClUL3N/22IyW?=
 =?us-ascii?Q?og3+wTNJLrDUbA3yZOegXo7n59u1TbXN6UsC6AntOF3zDFh0oBlzvA6Q32P5?=
 =?us-ascii?Q?fRzJBNHyqktqfRALHqa1sg7pPn1ANf7LZMEywa78DMNiYSrfc5BpLgb7YBO1?=
 =?us-ascii?Q?pZPpnM6aW8mhrfMuIsLD1Mf1+q1R096MxXtc7a/db53R0zOs58bUTzjKZhVh?=
 =?us-ascii?Q?MOmlFpdOIqUIzcMqToH0VgGWVxsi0CZ6uRC7FIjPeCLse5luAJL/W7KwLWxh?=
 =?us-ascii?Q?QO2kH7XoXgjCaQ/csYOa9A3a+WLY0pMoRbsj9owERwpSwZmpNLdvMn0EHrfh?=
 =?us-ascii?Q?rLZR3nyneZWoY6cAyfj7YdR+zIrOVOL0ZdIp/3Jjq8NnAhZCMdEh7PtbziqI?=
 =?us-ascii?Q?MbYZDLppAojeC7WgnRdfr1UQGyT6QR3VtQ2G5RBJt46E1nme3ukon0E15jBS?=
 =?us-ascii?Q?igbL1gLqpIwxl/UQN5QbhAe9S7IBrZxy09TIvhYoNYxXqVbDtgIOM7kLqpVb?=
 =?us-ascii?Q?sWBgTOs6hN4JJLAiJZymBV3eRqubYu8qXetMMDyhR/USXgMY8ccj94ePlNLB?=
 =?us-ascii?Q?sRQQ30pVU+eY1cPoSRbEX3H5RamZ8y2R4IWkUOQPjCwzIC4xUeqydhUjsqOo?=
 =?us-ascii?Q?VrGIFXmbidzQKQMgAlR4K+rPsQob5LQTHDIPrD5i5CuYTzok5iXbU7uvVlSI?=
 =?us-ascii?Q?XzyuRYiAxyZfJUGlcQh0h1x/6k91cQoF/bEVy7SBcb6wNXZBhl/YT0siV86K?=
 =?us-ascii?Q?ya0YqwPAGCAAYoDr/ESBAKAHrYPIH5Y9dvEWiHrsgF+s8TQNBR81kowD4EKm?=
 =?us-ascii?Q?hhVlk8QT60mONXDH7pd9B9eD1Aovc4jqqNvqywG67dLsS+bFGj5F8yAjEBjn?=
 =?us-ascii?Q?m/hGqQF3aMdWD2AzKO0K7T7RbBuu/VM=3D?=
X-Exchange-RoutingPolicyChecked: bdfAtSoZDjqNxBUw2Us1EQOkxs2z93R9fbnOt/L6RfWMM/IYYmPoJp5dKwru9t9QqNgiWICr6UruyK0Q5m36KeSwO6TsSr6eXZBXM/Cuu52nK0glz31lIw4A1rNsLszh1gfetljFa1Q6NJ9lkKt3KNxMkqew/+fFyhuPlC3yR4sXwaO0cphxSO5oXbthuFvYh7pkefhoDwGPmQKD93/e1magSejmJLJsuV0GNqoO7XLmChVGzpUNvrTvnpkhXSCkuzxfhyWUHgE9UKU9L5WxjLwSiWvvpBGSinlouLT7V/p3Zl/4IF8Y2ETFdIPu50GpPZfoGNN9hB+VKGz0H/iRfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14acb00f-7146-4b4a-45b5-08df464d2362
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:55:23.4047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mrl0lLtejPKeMJFCJpIVni/8Vq7DtLmGqqIqnkVVtOI97bTnoE7BNUwoKKJ9zOqjajjtMsHEecHP/LJE7LKya52vOlOf7h8uQ+31nswqtTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6056
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

On Thu, Nov 19, 2026 at 11:26:49AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] Revert "net/e1000: fix queue number initialization"
> > 
> > This reverts commit c1a42d646472fd3477429bf016f682e0865b77f0.
> > 
> > Although the hardware supported by the driver supports 2 queues, as
> > explained by the comment in the code, in practice only one queue per
> > port is usable. Therefore, revert the change upping the queue count, and
> > aligning the code with the comments in it.
> > 
> > Bugzilla ID: 2147
> > Fixes: c1a42d646472 ("net/e1000: fix queue number initialization")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> 
> > ---
> >  drivers/net/intel/e1000/em_ethdev.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/intel/e1000/em_ethdev.c
> > b/drivers/net/intel/e1000/em_ethdev.c
> > index be830881db..80029aa87b 100644
> > --- a/drivers/net/intel/e1000/em_ethdev.c
> > +++ b/drivers/net/intel/e1000/em_ethdev.c
> > @@ -1220,8 +1220,8 @@ eth_em_infos_get(struct rte_eth_dev *dev, struct
> > rte_eth_dev_info *dev_info)
> >  	 * To avoid it we support just one RX queue for now (no RSS).
> >  	 */
> > 
> > -	dev_info->max_rx_queues = 2;
> > -	dev_info->max_tx_queues = 2;
> > +	dev_info->max_rx_queues = 1;
> > +	dev_info->max_tx_queues = 1;
> > 
> >  	dev_info->rx_queue_offload_capa =
> > em_get_rx_queue_offloads_capa();
> >  	dev_info->rx_offload_capa = em_get_rx_port_offloads_capa() |
> > --

Trivial change, so patch applied to dpdk-next-net-intel for RC4 inclusion.

/Bruce
