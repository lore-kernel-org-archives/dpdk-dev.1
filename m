Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9178DC83F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 16:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7CFA40647;
	Tue, 15 Jul 2025 18:20:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 878754028C;
 Tue, 15 Jul 2025 18:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752596453; x=1784132453;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=+9zsI6epwlQBHnHxTKyUzfQh6kvouTT75qihkL0QGQE=;
 b=Ou20scwEI1edbI9V8s0eOAqkyRmB5cjFIqMp2Z7zhxNLonj05+QZi/QC
 KIpjYt+4GBFrFYPlJuDgTdo3kXe2ycIKHpL7Ec114RMCG+lzdyX9v5N7t
 3LhMlcG96A0QQtiqOnjjnEKwu5cS8gpSASkCNT944tYZLgjm52jrYHams
 ZsbNyL6kCalO3eGpfyY+LE1g7hCyPiVgpmmVnNh/mmQY9nN+X/uYkGkDo
 kClj2slcR3z5KfJkfdCXSoWeudeAGxx5+TclFC+zQ+t74vTTkf8uuMON4
 CM1tQGEiDiyCjtjDYgFg43EyOeLDSW+iOsUzYjvpR5z7IXNSxFVBOIjSF w==;
X-CSE-ConnectionGUID: 3PRfeyZQRdSyxRJwVuySDA==
X-CSE-MsgGUID: xSk5CMSPSq+3PNPc9mp1rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54800308"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54800308"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 09:20:52 -0700
X-CSE-ConnectionGUID: wO0o8un9SeCI5CFVwKfzEw==
X-CSE-MsgGUID: AkYYXHQFRY2EZUMZ+/tnoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="161289222"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 09:20:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:20:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 09:20:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 09:20:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6F5oA4s0eU/aA6ERkJ7lB3MrUmalox9YkqAoG6jCZa5Y6dImNiym/0zbpk1uSw+pyzHJv7/N6ClFvG2idaoYiw/TmK13EBNt6FlztIcJMNLG8aGO5Ie2NDRo6C8pgp4WrwytBT1Lisu4RHzevpw7+thipA29QSp/1Tguq8wt6TxCFSrGZxHrHD708OIVZDhnnrRCuWbYvsSZw4qRCAmUK1g+P9/3l3iKCSKfbKkd4TcSftgG1xt2H3DHTHcILlL/vzU/1xyYDzzvd9IMMY927Xci76MVBbKH9T7E7tTlGpe6VbEuqU4aVtZCf9tfF1l9CxFnMCg561ktBzAy0AkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EneBu+DKXgYbPUB6Ulu2XhUi/hGkoUOgioSEwe/Lq/0=;
 b=BpwOhaeIiW0rcGKXbLrFZj+X5y+f73ZfoXbXCfdoPVRs918RpKgLdfQP0tsvbPyIJmMzE7atMOikzWXpJyYJG/MGC5yD8WOmkVLaOMV33vG7GEty0sCogf3aPkz8jVNiuDSWs87pWFGo/fyfoppjqXKMOh8TthVFOK+tCEBGk5Wt4hMvrwnGRJwqFvjjSUY0WcmlL17MI/zi6auiw8Z0+324Lt5rq9WCgWzBPZPPrm7Es+OP8Wz1Et1shT+eeNJfBKPZ9LJuvi4LgSyj08ekS9P/Uh6cQ3mxnpJm2h/p1rjXQSQOb0sdQeXaM1PinihtN0rN7P17M1IJaAPpKrxwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 15 Jul
 2025 16:20:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 16:20:33 +0000
Date: Tue, 15 Jul 2025 17:20:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Dengdui Huang <huangdengdui@huawei.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>, Patrick Robb
 <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHZ_xZtcrv446hZ7@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB4@smartserver.smartshare.dk>
 <aHU1EJNHLjmynoUs@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDB5@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDB5@smartserver.smartshare.dk>
X-ClientProxiedBy: DUZP191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 021a42c2-d711-4f0a-1f7d-08ddc3bb85e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lIMg4i67Tp2pXTgquJrRs6YpxOom8OpxXKBYRQJMvH6v0bOfTdyOlcKFJk?=
 =?iso-8859-1?Q?AknFrGd/TKjGSeGu6WlPqAQ7PXDFzBruQQW0+qxHrBYXEq4FDLbbALlJNJ?=
 =?iso-8859-1?Q?IZu/AMWobtyXi+q0ySH4xTx2oIMpZJbhsbe7KOdhHnAeRmMQhVf+qw80D4?=
 =?iso-8859-1?Q?v9w17Gj+cHiuFwc/rE7TdxmLhWITmPqopNZVC10d8DeH6NtGYiQexjDLd/?=
 =?iso-8859-1?Q?KKacpxQ8BWjB4Amc4J2RHCkYnvJMB/RWrG03cdaT7KlCqbV0/slz5C5lfM?=
 =?iso-8859-1?Q?KKqGV5gfG0e+vvUFxLWQl8yvQzcBg/Qvmm+yrjaQqSRcA8exUr7t3scgI+?=
 =?iso-8859-1?Q?66wkjVzzZ+jqWw4i9zuOGQPGY0USkGkGCOGddai9Wc8wRAZ1boJ50dNKB7?=
 =?iso-8859-1?Q?ilRVLTTEp0bhnHuQJoTubnXcnAtKnrUYMyaM/PvL+akITV0Nx827vui+AM?=
 =?iso-8859-1?Q?otsnv5c64/+QUovnq8ivZR6lvQ8SW72NvLHuxUPqDYun+AqyCadZY1auV4?=
 =?iso-8859-1?Q?xBC9ZhaRVzpcAXuhOVIl29nHgmeCgqqivqHEwkHlf7CLuCS6lrngkNvEfz?=
 =?iso-8859-1?Q?eGtNT9AjEkvaaT7MbOOH8CDxN40mR50RdLKyjWuQBpq5mYUM+yOKoPjKy7?=
 =?iso-8859-1?Q?z439k0PyTmMkVNl3h/v0lliJYpWi58lOrg28bKhxo6QMvvsZqf3bNwTzvo?=
 =?iso-8859-1?Q?/Eb9HVfu68twCQ9eGnnuNS741Ly/ZhPk8pxfI7j0MbIHe0eVdw4Rsu5z3S?=
 =?iso-8859-1?Q?lGG1/CjfBjiRECqlMuDkMIssyK51DIMmFB54mA2uZ2pVd92vZ/T5Y10ufZ?=
 =?iso-8859-1?Q?is+vvEXmix5tqBy3Y7Hu6kek/HvZ3eBy8tGs0JqkbKfdmOCsSD8azjrvt4?=
 =?iso-8859-1?Q?LZPtaXRzw5FmJAwU9J06OUZ2BApte76NjtR0wwq2yBSprOMAGO7Ddup0JS?=
 =?iso-8859-1?Q?EjOi/7Lk4GgjmXzC6twHhooyGqhO2+ipuDV5tdXBvo+YS613MOuRn2uvtn?=
 =?iso-8859-1?Q?EVFFXK//v94XQpfSPOiSkDABfkXqQs6rcS5beOjGZt9cpOnk0hsCX9/+aJ?=
 =?iso-8859-1?Q?HMv/KXxEJQoeo5K0rIq14U9Q7hvgTDlUcvXbvxVMr/D9UCxxlVCDLzD3bV?=
 =?iso-8859-1?Q?L0CHCTIu9GQ0zX4iUM2RiUU1Hd5hEx/NXkrS6fpoqWV3mLVKQKGnHeoYad?=
 =?iso-8859-1?Q?pnGxkJ1tJ6iCcFukn5G9lbTCg1xvsdc1fU1Pjp3fLv5Kp3fMXoOEQ+Fmjs?=
 =?iso-8859-1?Q?s7NtCgwErsnDnwXgzWrHGi5SxwhzkER7vfz8V6TibgvLD23SGouRPEWZSa?=
 =?iso-8859-1?Q?yD72XEEYX/n1uN0PjcV1PdHa4ByJpBqOtyYizE9Z0eQMXoVce/9VNVTeRw?=
 =?iso-8859-1?Q?S66X0KsQFTCEagR5FQQSSVwi8DgLQoSRSNEncXdT03V4nrOVqrOQh0OLoe?=
 =?iso-8859-1?Q?njeeWtI6XZkocEAk9yyWA6ag1h2QLJyn4jXE2rakyORA2OunQX3vyII9HO?=
 =?iso-8859-1?Q?c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?q5xwqgh9MlpI0CQwPBLw3dW9MQhhZqOIWYwFGznFuuMJ4Xlynn2aPIyilO?=
 =?iso-8859-1?Q?+mZ2qqj3J4IwSdKLgfgBUldwCsgtpKNhk1ARBm51C/7M2BcOYpa01uR5UH?=
 =?iso-8859-1?Q?R4zty2MwPJGvHsSuJ9fstvg/LeYYdbmbTcQV0s5MRRZ617rHpaKlb8sopE?=
 =?iso-8859-1?Q?31TyBo861rg5OtuvMJfhiU8jowCOT0+d0ofIUqTLBtsHmx6ohYrj8SiuLk?=
 =?iso-8859-1?Q?3s1KN+9LUKp2vs1YjPdDHf+/waXRPw14+cH6EfVNhMvuxsGr8i43z//6lh?=
 =?iso-8859-1?Q?mB3vIuUb40RhQ+YYip6BhZaYmLwA5aTOtMKau8WQUyYX8YfYT8hQdKW/N/?=
 =?iso-8859-1?Q?YOxhlNs0EpI8viZCRsv58RM/VWQApR09fL/6+HxmeSV/upr1iVUxzgWrYx?=
 =?iso-8859-1?Q?UnAvbe7B6KjjDFY6PfLVc8dPAZVaPa6mnn1zNJay+9sKGiIRnfASDn6Nl0?=
 =?iso-8859-1?Q?IpQHLH4KQZZrOE2hvaybhRwxXnT9OQlSCwfyOdFt/jRIfo6WaDeQJ3Sl38?=
 =?iso-8859-1?Q?KL0FfAGV9uf5laGD1QBrzD9IVQdQrFOTJ6V/s+XcygQTlbK1fdIFN8TNOc?=
 =?iso-8859-1?Q?tiYlOdoDPpd1oA50VSklF4DGz3BE49zsijMWGHoSoMycxNde63eQMSHg0T?=
 =?iso-8859-1?Q?f1SBOgS/1J8ee1XXizxbQ9n4dBoebgGwzf6op53X53fzuUkzAnGlWWLVLv?=
 =?iso-8859-1?Q?4MiuJ77kUeXZBiI174Mait2jrzu3AqUdgqis1VKUU0uuNdqXWmG20z5jMk?=
 =?iso-8859-1?Q?cjMZ37SpJRVxeGrJvl84uh0Q9kMDgOpAdVgdeShg2x852aOc/ep0Jnujsi?=
 =?iso-8859-1?Q?kaVwJ6LnJEDrXnRkiP6du4DRlfxHS7/yBshs7bEQPm5gbky/2QoNMx8NvH?=
 =?iso-8859-1?Q?6bsf9giTWdIudSOpa4+Fi9czLP/DaDXeBfPRI3UVYKwRbVvT0tUWzt6UBO?=
 =?iso-8859-1?Q?dGGnFRte+1BvzAfaI2IcSDD3/rpxozEdOs0BRcRnchhqazsPw1mIXJUxCg?=
 =?iso-8859-1?Q?Lr1Zug2xqHa33MKBlmhILyDU5v+aUGVlB3qW60msqzPLeV3LxwUOT0BfcQ?=
 =?iso-8859-1?Q?K7j6N0pqwsZFi2FVYcTp2Lv43fg82VOqC/47A3NAWndwZrxZIMTUSTzgJy?=
 =?iso-8859-1?Q?P76AZ69hur0HLaCBlimqx5IPFSTUH3sLRmIFqOW5Slcrkcf3GWpcazQ5Ge?=
 =?iso-8859-1?Q?qX8maAQfyffR0JdAFJRAY9PheTKryzhS3YbayeWJrqYEM1MY0oL812Rltx?=
 =?iso-8859-1?Q?yHrketw9KUyAivo8bZxwMgbgk+6SLTrxBvaYb7ry9CTzeXGEQuz+mNJgBx?=
 =?iso-8859-1?Q?5mueWCRUkGh1FLlEX1GwDlsvMpiSX4kTcyGpEQInBY+zeLHdWv24hb7hW8?=
 =?iso-8859-1?Q?H5Z7dHdbxyjg8VVws/9lQ3oq8UJfovdUCPSQWDgIhZr2aM5MmLo96Ma8ad?=
 =?iso-8859-1?Q?eSSmRAknvSMZPDVsJRaCUzZp2c/5lMXPqYXRQ0AUZxbnMCe2RelxfvFHHy?=
 =?iso-8859-1?Q?JrrMgF27nUBFE25fMlXy7x0TBIdcqYTUWRte1+/4h/8wXErszKSj31WC22?=
 =?iso-8859-1?Q?M+CRGFTZaewmNhDFE/ZyWyHqrINeDOfIA4xIXX1zp4iqRp08yKW36Jgult?=
 =?iso-8859-1?Q?4aRbiSPRwOFTvwNhfpxxL2smJyQS2D2BNLL0FdBVhmwb3C3/nDPeX1Tg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 021a42c2-d711-4f0a-1f7d-08ddc3bb85e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:20:33.7859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IO1nGrAQUjdsPgJEB1xSDeG6YMrTFpN97WxN3Eiby0ErUZSFxbYpAaUrraz2x9HPZVFatRL9LcgnHzBUwHplgG+kP3gOwOs7fdboCtz+x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
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

On Tue, Jul 15, 2025 at 05:04:42PM +0200, Morten Brørup wrote:
> FYI:
> Last time I looked, it seemed like the VLAN/QINQ "tag present" mbuf RX flags were only set along with the RX _STRIPPED flags, i.e. not set when stripping was not enabled.
> Although setting the "tag present" flags (and the vlan_tci/vlan_tci_outer fields) without stripping would be nice to have, I think we should initially focus on stripping behavior.
> 
Yep. Again, it may be that HW doesn't support reporting a tag unless it is
stripped. :-(

/Bruce
