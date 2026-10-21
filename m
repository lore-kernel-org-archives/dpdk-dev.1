Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4F606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RheJSuQU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CE9F40696;
	Wed, 21 Oct 2026 13:08:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 29E1F40041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 13:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792580884; x=1824116884;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pX8MNZMNhEMOGd4JcSAKcixGMOLx9HpyKRXFcFf4Ytc=;
 b=RheJSuQUorS+jXj3xHay4TwL0nBk2/TapqBq7euyeRMLkS3G34Px/us9
 fLg2P5FfP3QFSDEbRj9nRKwSQ46G+4XhfIb44zPbaBu4LHIJvfKDn50tu
 q15CerNzvtUP/zhWyYcKm+b40QfzzqxyjGXHTVhd/XPqQpZViqaLY991z
 zmcVoqZONA0Ftxga36QzhU68zsuCD4LCRHq3nHUXo21ut92CZJ7OlHWAC
 E4JFdsrY+iqtL3C9yMlQMox0FtyzklW92aM4RLSp6eWqI9F9QCMHxWiiH
 ECwD+soknHt6mWdpZOJFf3tCA1FcmEErGYjeeJqwu9EVO2Lrwjzm3PXyt A==;
X-CSE-ConnectionGUID: t7yCUbQRTFuPDhGX6rXYvg==
X-CSE-MsgGUID: BPKNx6wgSeKALlAJUBqkiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1176227"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1176227"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:07:54 -0700
X-CSE-ConnectionGUID: ZN5fcIwoQWioPk2l6h+vkA==
X-CSE-MsgGUID: cGoIG9F8SP2j6FJhf8lCQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3004712"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:07:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:07:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:07:52 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhTGR/VFZOtA8W3AyBAyOaFDShSizRiQYilhb9VSDuL6aLZBuyCrEpOPDZpAvv9eyU5iU1xarrzccWKu1FAq4n6bpq5nrSBzK0M3muU1HSROlQawaB/EfU2uCRVEcapNpo0tvEaBY7hR8Q5D2u0Au/ZvYxhrPPRYRwpfYESPWifDH1nDwrO6O8sKayg1qM4BvuvY948EI0SO4OA2WmW3KUF+sBYIKHaNv+S4khofQ1yR1WEcNc/Ndo+phpGnqymsqFMkwGuD+h6nM1MYtUtgX/JVTpvR1K/9Po7OjpRAlCeqdkuAKZNM33DWSktoAIE+uwlPypy/Ts7tWNLUh8sUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAYsVLWK72fhNkZT80qizlC8CEdpgrCyJYNKhUZhVIs=;
 b=uZkR1Liuh3DzXDAZyuoKyRMJysVYKYesdClsPUx3c01I3j0miZe2GXxpyoPvhNLLe/uasnF/A2pyiOcxO0xJ2xVNJixehZiBGYiJaCAb7IIYYr53Cf56P6DvO5uTPfXleZ23ua/AlFgz4MIZO6sFsl7TTwLmORvsL4fRB/fV5+C6uFyejvVl1xxsCmhwTLGeiJ/CPxqMn3ymuhaS675kY3yrjYJKKc/x6dUxE75o39GZPHpIR2YZbtrxUxWZh6T+8gQe6t2IkmVQG4tFNAL/m3GaBw5O8vEZ46kXuNzzm7+wr0FejyebszWdeAKmFjM3Ohqv6hCAW0UjtFHJrIz72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 11:07:49 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 11:07:49 +0000
Date: Wed, 21 Oct 2026 12:07:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2 09/12] ethdev: check DCB availability
Message-ID: <atidAP3_6l5Z42bP@bricha3-mobl1.ger.corp.intel.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-10-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021103027.2050351-10-david.marchand@redhat.com>
X-ClientProxiedBy: DU7P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::27) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 6115e14a-d51e-427d-adb5-08df2f638afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /EX6S6eSWfWufBVhQHtTtCmpzPSqW38dtOpkQB6i8v6DXOfQhDdghOmIi5g5yMmVkChyAqXFzbmaHHYckIrNIoRYaTPtbQd9QQtywF/iIaZXkITMOblLugiiB6A3XzPe8axGGPuLZOc41ZcO3zWOmVN2Kjj8dmCU3JHHF+RQUf4SVBPgJdx9rg3IvcENmmM1l/aOSzhFrTAekXpFYJq0kipSKvy4jy3uwB5l3uW2gQd8OKpJsS+jAfL0xmtCdAfEBHmN1raX4Sahojvqono6jXUaOmpAH2DXH9wXzmd6P3juaZlTtnhlZJ5aH3g9arsr+tj21YcXYVln+iwa3U28AiaHokHXq+rdoBHoXACM7l51h04YYRg98eOxWQWZ5vVYiyyQ2nXGGMkNdivwVpsuAVo0Ao5zXsEEvq38FOVzwbHlccLZKFnp7vZdM0Ti1N2ACYz/bWa/jUI3zh1At6CUhqqSSUkXJ+nRCIIhshyOGiIb9gyIIN72Fmgf7WRisVUFEGRwJ0LIH4wt24+cD/k7QR7D8LG9DEH6lcRKxDpXYs5Z8TpM8pMH7ITmtfiP5EwG4JbS5hIUIm3B0+9HDfA6oRddAlq8t/po9TkO20Kqqi9B511qsNvqw+tlxyoZc75kLNoj0yMNKcUym3CWJbNdWr35GxKROzNjgBujUEgOARo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIqhcIGrxLcnsiEaI3juJBa0Q3/o2Og+X9K6N2ZDdBrwxByWVKVYrzTvmh9S?=
 =?us-ascii?Q?0qaszuiP5sxSALpmKExBnlLUXDvgDkoEGXVB68kpW6JVbMC45YTwAzfmCtTO?=
 =?us-ascii?Q?2Wx8Yq1hWz/o7EVo3TpA3+D3fzyzrC1KWTFOv09uwVnfo9jAXKRRvjjG6HXA?=
 =?us-ascii?Q?0g7X3ObTebVsi+O2crbvhZ5B1F5l5FKMPgnQByowxJbl3B14U2TrpVsfPab0?=
 =?us-ascii?Q?gKWDtBZabgfD7OuGrljL6FZ1ciewRy4sMLrCZ7bzaIlQqkWUONSpzqX3rhVz?=
 =?us-ascii?Q?obKpPl3QtUoUO5mgSzos9YoAS0DoppQ5jJATLQqZtiCXm3Oopth4eBFYghDz?=
 =?us-ascii?Q?W5b11x3zHil6vYgJCyLvpL/2NpeCH7iJWqJQNCPoZnRqdFOXVo3OKYr5pjtR?=
 =?us-ascii?Q?voRAorZrmgw7nCxyRFexX/UkHNgPKtnb6d9QphPuqXVYdIvKQe37Q09K/l/p?=
 =?us-ascii?Q?RM3JLZvFIQ2m+C6Wf0xF78DI8XdULE+jnAkbVeYVqHh+eHyr1CdZknFAppMn?=
 =?us-ascii?Q?M9fThuWOIWREQqcZTA8Pgx74NMzYwISxP8iMHHNZvn92TmJ36uOAfW0BRUOs?=
 =?us-ascii?Q?4g68BnQrZR72hCJ19/DdsWlRFO0Hr6utn4XgKzU4RoOTnpVgaI8sj1OHvxXp?=
 =?us-ascii?Q?ijBKIiY6HsZYhniBFENKaveXZL8Z2Tmprnf36kbFPoF1bmeDdpM0EIkvnqII?=
 =?us-ascii?Q?OzUzoZVtaKXNzOxmQDf2ZGaUHZTDAuw/o1RDLVJV/FS+/M7qe12oeIF7cKWh?=
 =?us-ascii?Q?Nts8iJC+tpCF2C8+hnsbuaiToDZCNMubAm16UDeEJuzMGiQZTBBTBft+60kH?=
 =?us-ascii?Q?dw7GCiQsKgBIjoxKuh3U6fINzrzPS9qeqT8UdDsXsYc9SlCCA/k9aOfex9EV?=
 =?us-ascii?Q?HHS6I0o5M9UWxwNsd8/VK4dS3yxYr+2TbBv6Uy/4cRNhlGaB9jPL1ShQ14sD?=
 =?us-ascii?Q?Zrbsw3FBHcRac6H7B3ePBYHxTD8+5avtcx+ANL+RFCaI0SajV2OkGAWJVBSO?=
 =?us-ascii?Q?bJg6hCM7fb4n7p6hR5S/FLQfyxop13Jxj9NX1GSLhP/eCooMiNrjkrj4Qltk?=
 =?us-ascii?Q?7fgjgzRXBI/mgg+0dmph3Hsq1f1D+qHrzvz4JIB86j+h2SG1UBnRWH9lF16J?=
 =?us-ascii?Q?QAyiTHW4qOEtwd5TbHFGfgv5UstpDBENqwikpBVGqT0mhgOZoELP6U9dgVaS?=
 =?us-ascii?Q?n1uccHQZtw4yNFcG4w+NZiz6WkOG4ujDsCtR3lsVWz2QpIdfg9y7YE70hYNr?=
 =?us-ascii?Q?e4fvtdE2sEpmpEZUCuarb4asLne6yx5+Gz5tYrxCIkpGUHeFj+pPqrKHdNO2?=
 =?us-ascii?Q?vPWjCy4PnfpUS52UK38rzIHfBeqca4J+LcXlVk2eES1veQyyA5sME4Kf5J0I?=
 =?us-ascii?Q?do283gHq6BYtRTmB7MtlJbA5xZWliTJGZAyoTVZsEHBOPl6FlNir73US1R9Q?=
 =?us-ascii?Q?TlPJXyl0rHXuCxDn2vAxfqkDI1tADSo7Z7gx8I5qFhzkfM3s03Br2iZIoPav?=
 =?us-ascii?Q?k5UQPzqUZlxEeRZD/byy8/40g6HWsLOnI5JZahSfWY9agbZkkFWgb6NCLYzu?=
 =?us-ascii?Q?nh/JFaTb9p78bjN+NvlBF0uCHs20VlZtATCugrqRNdbg7os7HcUBYi8yjSuQ?=
 =?us-ascii?Q?cBQ75ubOnhFl+kWPcP8FGn2K9IJYex3OWoNRSPaCS3TNeLt0J1PF+tV2FfZd?=
 =?us-ascii?Q?umHxX3/9WpZBI6TEszg4pSiSrcW8f//8qGeCpqtwechcwIlNGSGdvYXYhLR0?=
 =?us-ascii?Q?LZQSnwjh6CMkk/mODr6QA50DqKAHMHQ=3D?=
X-Exchange-RoutingPolicyChecked: eOeE9brVqFTrgQXkdYkF1ItZaXlcBModaYrWm4zXT/trSJgC87Zk+D+VeRdGnT8d3x9kEj34MPgN07hZphN3Q599A4OJ/jUX8IQ23VpCGGsxWYDEzVTFIepdGKrVj6i5Ye36rDwx1vI6LzPeS9xJi0knR7i3mo6q91q9PHf4I8OZMlN0yqQD7szC78NBYiXxk6Ah1fHFngS8ZCn+JP1T3vXOftk40UOXOw6q7/N1TDvugOwr8AVy/PVpDl68byVDNsxuJk0/NJQ/XHwJ6e+tc0ISUeaVeN0dvRlnwkzjOpW9tQEMNzodNJ+jG4o+QL9g/IrK404Freo3h/5DMkIuTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6115e14a-d51e-427d-adb5-08df2f638afc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:07:49.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9/sDcL2VQF7mY/N5rKJDXysjf3FISBKoUEQ1BtqmhVwEupNYIgzN19p81Rw5VRUX/6LVnO63NsJdfg4wKvFmPFlckx5XTeDYO72YOGIiHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 12:30:23PM +0200, David Marchand wrote:
> Add DCB capability check in rte_eth_dev_configure() using
> dev->dev_ops->get_dcb_info.
> 
> When NULL, reject Rx modes with RTE_ETH_MQ_RX_DCB_FLAG and
> Tx modes RTE_ETH_MQ_TX_DCB and RTE_ETH_MQ_TX_VMDQ_DCB.
> Remove redundant DCB checks from drivers.
> 
> Check that documentation is aligned with driver code.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
