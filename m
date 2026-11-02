Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2E60E6E7C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uh1Na5wB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94DD2402E3;
	Mon,  2 Nov 2026 16:37:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTPS id C68124028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 16:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793633832; x=1825169832;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=22bA9b9EoOL73vo+EErRuToBVCq+MsraaQCtTxbdDzI=;
 b=Uh1Na5wBBmTFGbm6R0ezzmMjopjewdmu7/PTKt3duwtokftRo7aCTDQW
 zl5KGY0KOr1Ot7k1H2+/qYB+wLvjWKQXvJwuY2t6Ip1dKTg0MVUnjdqB0
 quF76i3VqzIXPyp02n3PsZlsuFVOEBTlRFN6bqtF2xCUwoW6OQq5LhJJM
 Qdl32NIIO4Ghr8ajXcDYdS0WHCP/URcaKPvdQmp0vu30F22OS176An+Ns
 oU7zG+YjW48ZVeE2ADcaKDA7HWvVkKiNmv9f/Iz2Gsl9LJrGUYYHbf32y
 LcExSwl/B5bswjq4dBVfNfMNlnHUzEeTHDETOe6FvoPR4hQ4oaLTpQUJQ A==;
X-CSE-ConnectionGUID: 5T6+9lVgS7ykrYdng5w6rQ==
X-CSE-MsgGUID: qZWK11NnSB2PrEjPFTfe8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2211134"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2211134"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:37:10 -0800
X-CSE-ConnectionGUID: IMS7PI8eRMi0XhhcJpknwg==
X-CSE-MsgGUID: DUI7TATrRAepBfam2XktDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6147876"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 07:37:10 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 07:37:09 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 07:37:09 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 07:37:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I897HwXcngA/E125vXiAFFdMW/Ebtvz+H+fAvvxJjtE3ZBi/Km8iXyETOar+69VC4t0e4gm0LpFY/qyPOJCARn31yLuIegg9naOBRCT/z/mbQXBNrUcKJsWhzboJPJnPLBChd2NmTvDIBQzVoF1JWv/SxJGjveK0OIwnhslkZ60WeblkdC8C8wloOXdwpTzLopmSQYLnIKfztbL08vF7m+f9G9qE0H1ZGoo8si5U5x3ho562XtCRJNMMk2f0AP5VPsaBNna1Ul6JfGgq9PNbyOc7P3HgFOtfdc84WS4M6X14bqzKtC9PTOWyzCN1850S7ZXSTpMS53D/yqpHVmVHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ANnX40rtL9pJg+wVBjWJp8i0cJpv/kDo8M0W043mAY=;
 b=I0AjDAG2uAal0i3amd37g677swTFr3yPXu9FUgaMul0/jtvNrILuM09eBGvSkZKLrDDGUsB1lXpVRXv2i8ZRld6twO8idiwFmwuUFeFJ4yURqugvWLYT7q//LNZDhCUNPhU9ZSPAOwv+6+mAWWWgVBRaktq5o7hGuLPcOw4Csp37cwzy+NuMEPgT17tCUxmTRbgfc2mbpY5GIof6Mg0DvWJmkwQa7Pu9J9aayXDQbrshHB3WjRyCRHKKwvamVZIEsYtyZ5ApUiePLs3q/B8pNAdhEjHC8WthkATfK0KyxrTHildcoeSUgKP+a8yRIw7f+YjDacTXMuQzN7Zv3PnLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA1PR11MB5921.namprd11.prod.outlook.com (2603:10b6:806:22a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 15:37:06 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:37:06 +0000
Date: Mon, 2 Nov 2026 15:37:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH] net/ice: add explicit control of link auto-negotiation
Message-ID: <auiuHAy8DjGUbaXm@bricha3-mobl1.ger.corp.intel.com>
References: <20261030132616.2066712-1-bruce.richardson@intel.com>
 <IA4PR11MB927804496D3ED9C0A512C97F8E6A2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB927804496D3ED9C0A512C97F8E6A2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA1PR11MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: b2555cad-43cb-4929-e945-08df38f72672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|261102123227099003|10067099003|22082099003|18002099003|56012099006|5023799004|11063799006|4143699003|261022105027099003|261021135927099003|261021123027099003|261022075727099003|261026140227099003|261021121427099003|261009223027099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: hHHtzuZXucvnBcgksBg3eUtJWvfIB79+DjHNDDqPF0u3FvE2pIN3GghXX/zGh/iL8hkGG4EntSAe2XWKknb1ggjrZkZ0yVFupOaC2QiJxkVKXK30RHOhDm2pQJ+NAkO/7TQc8Kgy2XMkyfjy+ZELaLgdTqffdJ2yv9y0F4tRbe2VxWA490meH1XCwW9rPLgud1GvOysiSsPyQrxC82Nt8H11GX4XJjliCemlDk69KTe0I927qBHytMyp8bNiKdj0EQfQYt3YjQbRExN0cSAxGEy13QC7L6wRSpjfDix6JuLEfZGucLXocsEYE3wVorAfiHRpp5FRwCX7Wj1MMuiy+Hm3ZO0fG2nnm93CRRPmNrb7aVZSi0kS7MBNM+HUdxOWzI6U+r9hqmTdACkZ5LHT9S0pLOnwo0sWeHCuLal8cMDGwPXcoCWM/Fk0VVRTFxW3tcCTgaCo8xuB6zZ5dgVMXt+LavYsCt69rqvIc6HogmTliKzoT9XMYur5RZHjnH8R/iLi3VBuB+8/bV1RKe2WTVn3LgPRUY8EPKxmFD0GI4E6l4TyG19BVkQWBF0W9yCs4kaFt9s4141GeKb7N/IQlkpkmUbn9ryWutXZDHo7FwNhCCtWj10YSQ1EA8Xp6y3J+nDbhQisoeeaM/3VJQQpdccoqsm4BDd6lhAPZuvEcz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(261102123227099003)(10067099003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(4143699003)(261022105027099003)(261021135927099003)(261021123027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261028144727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B44JLw8m+xXu6Pn3m7hpcNoRjDgTosGV/5ym9OHub0huyNbbn8j556InYW7T?=
 =?us-ascii?Q?r6ZHIdBJcMinVQnCPCipMGrdnuUyF9UnKNrLnWAEvdb42yjWxtXsb9cNPDRA?=
 =?us-ascii?Q?Wb1Y/eusFSWlD/YNnfrh36K14q0kItjGI1pR8el3zLOJu/w1QPAIz5tYhe7N?=
 =?us-ascii?Q?fzomvBpaWUsAu1QzbA+4841ENJ1XlC8JbPZE+ijN8oqnbc6Ve1qi+AfG+t6G?=
 =?us-ascii?Q?dRLkJbEPRs5zhxImyrCv+dcN1BF/N4Arr18swkvZ9f/hSF/5AhONqmiCGngL?=
 =?us-ascii?Q?3M4XPBgeTcWeIwjCyNEUzfdal/r74RLDxgBeO/O74rXGrqwXaJdHIsS0fIEG?=
 =?us-ascii?Q?Nd4URQKFi7T1t/4a6V07neiiCTuJRn6l3m1CDK+eOqMECpyzY6XHr/RwEe+b?=
 =?us-ascii?Q?yLcdFjNhBFhrCMuDvYEb3d0hXigycgW2kKxBxCBlCjiq08LRh9cBmoBHc1vS?=
 =?us-ascii?Q?p63dmc++osw8KMtwb6DjRylDcYOb0DtMTTwDNzixCYbZuMR0m37hhgULsioR?=
 =?us-ascii?Q?SYC7ahz+ykKz1U135saSSGBcxeWhg9g0LGzakF1pT6erBfXaRKdhrHBGH2Lf?=
 =?us-ascii?Q?RA5FPakSc3G6Io2ASmIfyZJ/3Gr4ZyHHekXL2FP0OSBHU2p/OFVdBpkDU2ML?=
 =?us-ascii?Q?tBWoiT4pd+bXcITUeasT2IqIVuhRqMPhfmOcHl1iMusKDji9iYpAO8v8LDS5?=
 =?us-ascii?Q?rga9CEwHlkanys6n+06w+Y780Ot7/2JUQegJ4RzIYgd4ZPurVkEEYuwMXdSs?=
 =?us-ascii?Q?cL1l8TdS91erbdJZLCyoeNUntlZsvEzx+iqqMJ3h8eQfBt7CBS5cssKCMpKo?=
 =?us-ascii?Q?QkKfBhmX8TLyn0gJeozUNGdRFPO3Hl0rfF5ThDkrgdtqb6/j46ibASSJUn6A?=
 =?us-ascii?Q?yTjN7XJCH2y3XUvidK2ehn5VFEblnMh7Y3tU00j7FykQnWCG5kIKFTGrCoDN?=
 =?us-ascii?Q?R8E3mKHEMQvH+jvnDk6I56xMS5+A3p5hm+mc2MrrcHYwKWrj9ITmgvDaMr0i?=
 =?us-ascii?Q?3lAZn9I7vv6p5P36OG4OJ5UbzudQMxfxFTz5Hef88PkcWOa2jCPI1rruinKI?=
 =?us-ascii?Q?hQdLLtUIV7f5Ntu0KYtisQ8QcJJW/fzqMheoeXk7/OM73qayD3GhZj2Ou1SY?=
 =?us-ascii?Q?tFW1IABXvoqZC1/7de5di/2ybw2SeKtlnba7xvyV54UBtE/qy1VS57aJNrj3?=
 =?us-ascii?Q?CXr3WoEbpvKAwrszdLZKfeWszU+cm+gF8CBRrrdbtbszD0LxOBxIYCs2d+Rl?=
 =?us-ascii?Q?wBzldPo7lUERnAF4i2OYJDRQPXlXJkwmO10F895aQJTFZMvsuUpIoU5aKmct?=
 =?us-ascii?Q?QpnYC0mWFzxn8zEyPZnlFmykw1xNtUIuViWXBPMiMKWTDgoUAQUOCe/+fTm/?=
 =?us-ascii?Q?vUfZl9ZyqDpTDRequKdGzsg5lDtmuN/eXXGiVRmzzLLB57vNTcv7M/izWY2Y?=
 =?us-ascii?Q?hn0qoflBJZ1ENSHkgjFOChom0XOcKvjJVWHmBXka9cbKbob6ZKLFaxszZgLz?=
 =?us-ascii?Q?rE9nF5zjiGE78sxqjw/b2JFzsy6y/s+QHKoaXlB9LL89cWHTbk+cxa1ssdX1?=
 =?us-ascii?Q?Cn2RpYKl6710iPALf2EsdFgf9Mx6hBxOTml40Hz3W90SD62dVMKpObFHrlOK?=
 =?us-ascii?Q?K/2uXn9ODNvqlmkidH+TiRXHJrSQIgER7BFreziJJ1hTHyE/LQz2fmBuYpM5?=
 =?us-ascii?Q?R4jK/grWFa+a0IfN4JSrvtpRyit3RfpRCKIoMYnNPyWG8b0gwbkYaqgqP73q?=
 =?us-ascii?Q?iNGp5AM7gq60NIF+eAW12AmWx/5R1MU=3D?=
X-Exchange-RoutingPolicyChecked: SgKCr6gkivIlaJoG2yHnRdED9BQxGZq7YDwfti/9EVYba5GrVl+ICgXsoCaMwO7sfA8FyIJWI1D4xGlK6lcRJnlx26AmcPgXpNwrZdj6f1/4q58JR4MXM9nYpijG8E+cxHcuRAj2R4vHG/gAgEPYk4ZwkHZIXXZDrVaCOj9QzGd4O0UC6ggEmvRMQXliKlt59BwATnuBShxggh7OjcgU3bT5XD6IaT6riAl3rMQh3EKRkJJ3hkysranvQGyuPBoUsjwuqLBKuYAdS/I8sGbbnX7HaS2f5rlPEizkH6zO1aP5ZUXPEDz8KG8wt4eXIPzQWxR/NYZlf6SzcRGdV0GzvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2555cad-43cb-4929-e945-08df38f72672
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:37:06.4103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib7jmRgk59ciBbitx+wv/1ZkNoHcv2TtZBq8JY35YSUerUiS2q5ITmKsDTtei3r0tCkoKomKWUT/3AVEOAjlhVsm+P/O2kX1naP70s1gjpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5921
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

On Mon, Nov 02, 2026 at 10:55:43AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH] net/ice: add explicit control of link auto-negotiation
> > 
> > When selecting a fixed speed of the link, whether or not
> > autonegotiation (e.g. AN Clause 37, etc.), needs to be enabled depends
> > on the peer link. While commit 3dc2933866d9 ("net/ice: disable link
> > negotiation for fixed speed selection") would allow link setup when the
> > remote side also has a fixed link without AN37 auto-negotiation, it
> > causes the link to flap up and down when e.g. two ports are connected
> > back to back and only one is set to a fixed speed.
> > 
> > Support both scenarios of auto-negotiation supported or unsupported on
> > the remote end by adding an explicit driver option for disabling
> > auto-negotiation when a fixed speed is selected. If no fixed speed
> > setting, then new option does nothing.
> > 
> > Fixes: 3dc2933866d9 ("net/ice: disable link negotiation for fixed speed
> > selection")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  doc/guides/nics/ice.rst                | 10 ++++++++++
> >  doc/guides/rel_notes/release_26_11.rst |  2 ++
> >  drivers/net/intel/ice/ice_ethdev.c     | 12 +++++++++++-
> >  drivers/net/intel/ice/ice_ethdev.h     |  1 +
> >  4 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> > index ca3a94655b..af36341c9a 100644
> > --- a/doc/guides/nics/ice.rst
> > +++ b/doc/guides/nics/ice.rst
> > @@ -107,6 +107,16 @@ Configuration
> >  Runtime Configuration
> >  ~~~~~~~~~~~~~~~~~~~~~
> > 
> > +``auto_neg_disable`` (default ``0``)
> > +   Control hardware link negotiation when a fixed speed is requested with
> > ``RTE_ETH_LINK_SPEED_FIXED``.
> > +   By default, the firmware's negotiation settings are preserved,
> > +   allowing a fixed-speed link to use negotiation such as Clause 37 when
> > required by its peer.
> > +   Set ``auto_neg_disable=1`` to disable Clause 28, Clause 37 and Clause 73
> > negotiation.
> > +   This option has no effect when automatic speed selection is requested.
> > +   For example::
> > +
> > +      -a 80:00.0,auto_neg_disable=1
> > +
> 
> The approach looks good to me.
> Something my AI review flagged was the setting of "link.link_autoneg"
> in ice_link_update() - your patch doesn't update that setting, and it's still
> just based off the dev_conf.link_speeds value, and doesn't take into account
> the value of the devarg (unlike ice_apply_link_speed() which accounts for
> both). Perhaps it's not necessary, just something to check.
> Once that is addressed or ruled out:
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>

Yes, good catch. That is fixed in v2, but I've dropped your ack as some of
the logic has been moved to a subfunction to avoid copy-pasting too much.
