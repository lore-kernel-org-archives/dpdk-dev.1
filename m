Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DA4E7C712
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 11:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CCF44029D;
	Tue,  3 Feb 2026 12:56:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E162740261
 for <dev@dpdk.org>; Tue,  3 Feb 2026 12:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770119784; x=1801655784;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5J0ESfJM6X4SjLj2YODGwxM2RcEEHr3kqyRkW+2lBXA=;
 b=F9n7mBmfE+d5lXa2j6RhgmecuOlEjcyW5ljrFUH3rvaUG84J9nMkvh2e
 Fb+RPnzDdEdaKBDyQ3d5taI/QM5hssIAL3DrxWnyCTFtcKOHJHJavHy9q
 uLW3ldoFZH7Le63SqqUY/xA8Putaj3Num68h1NIpL/lYqSOtdldlKdwza
 W7sx16/TYrK7e9s0xhUoET1VDG2HJUrmgKLeLup29MA3s0/vo4ca2DNLt
 gK3mQDGK/rGH1r+HLdZapcDco2PcGK6M0drKJn7qyVbnm2bBC0f/Z1G2n
 MdD47wUHHMet107PLFgmCRzKLuRO2sKS2e7i7IOS+lxsgIn1XMafFgvZ0 Q==;
X-CSE-ConnectionGUID: /K2v7NsGR2Kl/dYPF9VOUA==
X-CSE-MsgGUID: YYpkOCdgQ1mvlZwzhYPdoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82661352"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82661352"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:56:23 -0800
X-CSE-ConnectionGUID: zNN2p/0vSfyoClVcPoghbw==
X-CSE-MsgGUID: zT4CnEbPS+CLLy6jgCnUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="209121639"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 03:56:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 03:56:22 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 03:56:22 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 03:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxZcD2CoXrZjmNdM8fugNtGMCIr/pB2l8hx9E+goZZ4HMnhlwmJS0dE7HgQMAajkbOGpn/uTVKfcMpEQ/TNDbQ4X6ASXVZOelOKa7jtEMaBYjqYGPs7xk9gpOwTE7G7WIhNQuXcmsEE1Lu+00Yf0UQfEVcyLWTZEH3XTrjkEBi8ainAn5dIWqaGIqvzLL/GXeZRBdWffIG1QbP8IzPEV0yjk0TD4eneTSDB6+sEqA5Qyf2fmfdODqo4eXjFVvMINwspvtfZc3JY4J/WyqjfRGT/KtO2XCMO3DOaLMZk39nji1LWPqDQXOcIzEMHzmqp7kuFPJ58Pa2fiSip2MVS3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW5h8Y23SYyDQoAwCSTDriAfgApeDFw/FnAOBJUMCcU=;
 b=L+WV5UOEsajTSG/C4ibRz94+rI5jvYPBq4OfhweSMql/0OQuQ3PkD34uMeFo4WQ25a2EgRoppQL1ur5ucDkMJVXz37elnvvSUzm4j4MoOu+HmctJI8haTKA4FJa8at9hLXPNVs+NYZSh2XAhXDrk8KISNc/AT7bBZjnK2mBjj4/S7Us0/H7tpCiC+noQ76Ujxk5VNW+m/njQZK4KpRKdHqNGLrNp440YboPK1jugE2cDzIXMRRu6XIIGpBf4bl9VCfRfeSVO/vBAjs+zPD/VQBNGZBDMiEYxLeb+AYeniygtFMIRZvO7rkQJJMdEjk2hvyNdNw4Z9RIxd9eRv9dzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8106.namprd11.prod.outlook.com (2603:10b6:510:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Tue, 3 Feb
 2026 11:56:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.010; Tue, 3 Feb 2026
 11:56:20 +0000
Date: Tue, 3 Feb 2026 11:56:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>, Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH v5 1/4] net/idpf: add a new API for PTP support
Message-ID: <aYHiXvVz_f8-m2J3@bricha3-mobl1.ger.corp.intel.com>
References: <20260120191120.137078-4-soumyadeep.hore@intel.com>
 <20260123000449.188008-1-soumyadeep.hore@intel.com>
 <20260123000449.188008-2-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260123000449.188008-2-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU2P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::35) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d00fc03-397c-4900-b6f8-08de631b3ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jd4NDI89haqEZno9SC9Mwd1rjswlC77ldHIjPTAtz30ZnKBcYmo/8Ynf/Kj+?=
 =?us-ascii?Q?wOz9eYixzBP4587+oovVbtwmoJEGkre0dF9GtCKPJyJmpmWWv88ZC3McYqYc?=
 =?us-ascii?Q?EH0onTtEwj7K+FOp+iWm0KylmrhPcDzZnjvkyEvtoMdg8BQff5qxPQ20pDUF?=
 =?us-ascii?Q?1G0L81vlWHckV0F4pLPmZ/syMaIbvt9HV3VJ7VyfIoJsClfxYG26zQNuVwk3?=
 =?us-ascii?Q?xWGPzUthRHQAzSg/Eg24pRGGmnjEw7A038cSVfwLddR6P2qZ5lcFXrS4iHOn?=
 =?us-ascii?Q?j1jwDVLqRgnm5IS7JPXaWyoE3UV2e4Hy6dc/s4Pquesk79B7+ip9w1wkPGGV?=
 =?us-ascii?Q?3VZudWbCJ/dBTYK0VoiteGtQ6My1IYwxnw03zRlxurFxzDLN+UoOW2fDSOj/?=
 =?us-ascii?Q?cFxwJHIcWLq2mPQEKGZ0FVagIt2tXa73BPUZwowDd4u+vpZ4L5mc6dbBmJQR?=
 =?us-ascii?Q?KmVb9Yt8PH7FefSCmk0nQtotHSvmE9slVDaNQ3zaImFxgPyOvm8sn8VZlh8M?=
 =?us-ascii?Q?Qx4LYmFDebO77vB3m3QnLCzQQfOI0EkyZsxo4juy/sHJRx9qzHcH98/l8MwO?=
 =?us-ascii?Q?O23pChKijNS51j5T2p2pB0Bp+l47lno+WxVX1n4nfbDPG6W13CFOFoKKD18y?=
 =?us-ascii?Q?qPKn/HWSQMedhmugNSB/kjTQxjGPSy8okr6961hQIAuMzTPGHsDak3tchQzE?=
 =?us-ascii?Q?UcB6wE9vqL179/DvwvhHgqgfIwcqEVDJqjomE+BanojIOW/Y5PpIQIQJTUhf?=
 =?us-ascii?Q?ApitZXhAjVAI+Mhuaz8FBPu07vGtwY6avD0zd8c0vJ3jCplglOZ1kJx5X89s?=
 =?us-ascii?Q?rl2E44E2nzheRF9epzMujID5p6uYVIbyI3VBKCK4XG+saBDFC+zHhWEuKmqX?=
 =?us-ascii?Q?riuSMmnuIFQ5688LBt93thcdGW/HRjKph2/ks0rH+UV3YHLBKo79ZetQXt03?=
 =?us-ascii?Q?132F8Ffxw0uRF5SUrgFxf8EAbNJ639upr/aWbOs64sdaJZ5galnZbsNbVbEX?=
 =?us-ascii?Q?ANR6qoYX/eb4ojTWzckpqJKVv/bGWd3WuiNABUUpMeqB+z2Dm1oHoLcWCTwt?=
 =?us-ascii?Q?RolbpJ8Qcn721aiiqjXzBIVTMOcMWr21QK7QZdFWN+/GjQ9deEC8c2FxEig6?=
 =?us-ascii?Q?t+JMiaXAJy9qXlbUB3UQUBIALQFk5iCAn9NjLKQjKNuuzXiBBA6zcItgi6tx?=
 =?us-ascii?Q?KOfGC3FZUmcXWbXsRXAsqqRZyP9IRcgCLbs1HX8xccuE2yvIWplkQ+IMTAf+?=
 =?us-ascii?Q?T9dvQ88ynv3rgnpXqOkl3zyhyeuUJhDoqtIBNgH3EmnDDsOV5jpQmK4Hg0B1?=
 =?us-ascii?Q?HJoc/9CDmRAjw8cBRhR33ZUOWVqa9osP7WHIxC3Lbz6NFsaWzGhteHoiND95?=
 =?us-ascii?Q?9kdDmcCTSvl6qR3l6L2FMC1OKg4X/IeDYJ4TZZvN7XzJTXHZpbQXLNGaRW07?=
 =?us-ascii?Q?wGlrCyGoZTAVXOFi47eQD6NbHfEU9i7idBo97GyQm5KEtqfoqL+jmAQMY+cc?=
 =?us-ascii?Q?rUNMxLcj3Zn2YDAmFZsTX4RQ8sooey3BIMahF3HSFJw3c8OIbwBBR1gOJRm5?=
 =?us-ascii?Q?xkrFTsYf7WW7eiaaGQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IhuwsHn/YnNDZuSRqkFRsGcvJeRVa8e8JO6JX4IESnx7FVZMFyC00Wi3kRWF?=
 =?us-ascii?Q?EWK15rc44iS0+fxLC3YX0Rps45rHEx9i1HQFXi12PvdrAx4t3/a1nRUZVf9V?=
 =?us-ascii?Q?tkVqAjoWxAf9+1UA+vHr5eEkANsciNCrtEpS4uZAHD7T3YkJejnC3ePEsCmS?=
 =?us-ascii?Q?9cror+P72K05vyZQO8icPJDozTP+qe6eHtydHIfMt+eD06xmIQRRNBbRfX6r?=
 =?us-ascii?Q?IUb04OuO7tEGkIzoeBWo8s4qEKO+Sc4ICTlVILUYggdFOMLbnx5WZwqs/rAT?=
 =?us-ascii?Q?QxRpew0+Y8eVti58y2LYOg14Kk2IRdBjsjFiFHIzLL24blNgH+x7yCyMluMs?=
 =?us-ascii?Q?MgZmCvL2XVGG8TEsKvYqsVgcRo3/Vga3lItWXSnl8A9JWMNuiRgKivjMlCUL?=
 =?us-ascii?Q?3wFVw8twuhPT731MF/oEA9qsU9NGLlu0Erq1MMaHQlfM/6QKHm3rACZn1353?=
 =?us-ascii?Q?7DyA+qgrGdY5nWVLnzDgJrjoKTSi2BZslJqQyFSzppF3xsalznbrgG7j6G3Y?=
 =?us-ascii?Q?DX0MobKFtSlTr8XrwbtB/mseLtcoRssAnXRamR2Y2imw/CCk1kCNcWiESEmw?=
 =?us-ascii?Q?X7lMIeDROSGysNBYtjmbMIqyaxDZojeS3+7W5x/8Xy4J0pgaID+IIlKi9+CZ?=
 =?us-ascii?Q?6mdKBI4xGIHcrKmiQqOsQkkY3Jo0YwXLcCyCioDM9Nx8VYuguX+bdUS0hPXU?=
 =?us-ascii?Q?R6WF7gJknMz6ijEL/rhx7DagdgsqdgMf83qAVNeB5b3TbHfYVbhgDDdL0DvS?=
 =?us-ascii?Q?O8KuRFctgkHPMKmz7rzbqYem4kLDqhSjb8U6sc/ma1MajblwAFMxiu8Pw4Bb?=
 =?us-ascii?Q?4Zkc8stBpZUP9Mw2+QLgU2SiS10GOWkHjuYQUNiXO15jqLIl2mtQe3jTrUgm?=
 =?us-ascii?Q?OMpsszouvw0KmRUPTT+grnt8+aVb6VCj3kqND6D4S2gVqYJ9b5DRLZH+QySB?=
 =?us-ascii?Q?OWDaYjy/q1ZjGtHHUZD2XdQlNPYc4TqB9NnCzV0TAMrBhV43BeiwafGbQIYy?=
 =?us-ascii?Q?xbAqzmO8RH3T6mJf73dd+RCey8ZyUXHO4+FBlsHSjSSlvNJKSfHAO4un1WTO?=
 =?us-ascii?Q?l/lt1QdOYoavx2JvDd6BlSl/3TtfUxEKAqokbdScIrfgepNplVyfkdS9Zdvw?=
 =?us-ascii?Q?vEOTUU6MQsvoUzdnO74LhVjZnf3l/wmTeQNYODhZodV4QCLBXd2dK3FyhpX0?=
 =?us-ascii?Q?F0JO0PQ45SM2BtWkjYlbyk5q9FMqFdXc7Czen12XnvZtwJXZY/hSQfREfPJt?=
 =?us-ascii?Q?U1Zv6GG9fQt8ZxPshf9s/zmKQhXxSWli5N+BD72U0WP+04/aoYwuBQqhcU0y?=
 =?us-ascii?Q?QfKRe2BkkCZJSkKUNgPPxR53RLrO+0cQLMq+HMNNnhL2br1qa72RVXwkt8vV?=
 =?us-ascii?Q?KJVPJRBSyQntlupleiS+tkV3d8hthOQZYkId68DX2OVEmeeHYFlo6powttXN?=
 =?us-ascii?Q?DNuV1cGjSc09QBz/js6NyU2Izx5AavIqzHWvMaQYqkYywJCyKN3t7OvQ7x03?=
 =?us-ascii?Q?Ex73qykrbqUcz8vBZMkf2wXRj8SVX8ovsFeKfX5aWaXQq6Z+TnTA0o1ypnJp?=
 =?us-ascii?Q?mMzpBu43FHIOuZIQ35SNEvKxtD0UHhr1+pX0iM62d91cNKB5LWJpnqca7cbZ?=
 =?us-ascii?Q?hvRn29hkkRcOupEUVE6s5Zb1Xi7tbcVFX+KKP3uX8vmUXBIDRao2pfxZJTRu?=
 =?us-ascii?Q?cYvxCJ4Hq2fJUdAcCg156FFBtGUF1G0tYVUCgRRsulYHt+oSs714WXFHa6Qc?=
 =?us-ascii?Q?9PlihmYOC4QMoZQFIjPuc2S1LUl70xU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d00fc03-397c-4900-b6f8-08de631b3ea4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:56:20.0816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NW8cNRbl+BFuDE18ouAKC+iMGKvzc+6z0yYcilNPzSgt5GlDDF3juw4dZuSooI0YtYi4pFGggbWdY5ls7N4yxBLO0bq0D0IsVv+8D1byGXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8106
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

Minor nit, subject prefix should be "net/idpf/base"

On Thu, Jan 22, 2026 at 07:04:46PM -0500, Soumyadeep Hore wrote:
> From: Milena Olech <milena.olech@intel.com>
> 
> Add PTP capabilities to determine which PTP features are enabled -
> get/set the time, cross timestamp, adjust the clock and timestamping.
> 
> Create appropriate structures and opcodes to support features introduced by
> capabilities.
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> ---
>  drivers/net/intel/idpf/base/virtchnl2.h | 324 +++++++++++++++++-------
>  1 file changed, 235 insertions(+), 89 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

