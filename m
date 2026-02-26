Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02758FD8FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 18:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF9AD4027F;
	Thu, 26 Feb 2026 19:16:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1E7F8400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 19:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772129809; x=1803665809;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=88ts7oeCfP5Ns+tMeA7weyJLUujrvn9YhlpgtNt827c=;
 b=X4k8MJKYH9SLGANelNrl5VYMzygOkXm2Vs3qYCkklcjvbf7FwsiH4LEE
 S6rdtA4TuRMXhW7HSqza4IHNYsA0IcBMTNLO2jE39CLUSu/HkoQ5W2dnT
 WCQbMT3ndGHnXplP+MHyoAXUpH9Th4SpMHCwW5km9RngfuAMd7oRQzwOG
 utdzZqEBf2DwxCb9T3JdUJqPBDzEBTXi13+CeVwPKsf/oYProOFIcUFFN
 yjzo58PalMc7E2yUHwhkW0E+sWnELAJW5b6jef7CwzpZt1DSpxDAjbZOa
 Oy9fGfs2pctq7aFirl7xnud0nnFz/IgItPdHXSv5sYEHMv2dYB2PYwK2r w==;
X-CSE-ConnectionGUID: gtQ6n4+VQnW2cylNisSRug==
X-CSE-MsgGUID: Cc/hTRjaRQ6xK3NnvRV6+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="90610430"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="90610430"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 10:16:48 -0800
X-CSE-ConnectionGUID: F1Ap03PLSymhmiuDhAvxPg==
X-CSE-MsgGUID: WJlLdtGdTDqU5JFpMrTyJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216775378"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 10:16:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:16:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 10:16:47 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.11) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 10:16:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5j3Bca3JyItGjloQj2/7MOHuhL61jdeljDCjUayzQY6SXTHKeEO37XSbSq38/Pu+RmHks3M9oc8bYOVnGA+CLazyzipMK2mQg/PWYxwWxksP6OoRM0bG9pKVDZ5MqejJx7RLc9+TcxeGD1H9maNxM1J60nQNhO61tba72rZh5wYOcWfYhzw6TleHsXdeGMYZ0YN40DBIg1FB5Tronfxebb/oW5TqPV/11nEkA2av/fB2pHvqAuMKa9WbhI5rvStaf+D1yg25OWdleY51IN4eY/AUYAlSyeqbJHciImMsi7SQJlJ5qwrvZSPdDj+PlLhC6v8Ct3AJRyEu4LPskixng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BkNgJqSBrApUfxo/KGtMvvx24JzJleJKOQOsa8e0nQ=;
 b=jJWSSzqoyhp6YUUBcTnyeI6D/qe0ZFx/QGcS8VQfdwYV51mr37Hhs0m80JAu45MT32xrVF/b2NAW6ch1LxuBMkcoaIFIsz7Rc/Ro6jdGLEZN0jSlihTFnovQy8vzNNFut+ajkvM1VrHk+X1vwqHEVRg+/dv4uD3clZ1acopwS4cAnUWEMXWsLaeazciWwd4ug0cBzw7FB7ltuagBlap0ildVsDzIL6vDugfmrQ4DLtwN63GckCl1ZMifKlHRNPjARiE6gW52NFa0XeHx2UioSvE2XLbC7X0hiboYeetcdf4uIzY9n1yi8UlkFHRsmj3Bi8QIdzIifzdLtsWWaNLbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 18:16:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 18:16:45 +0000
Date: Thu, 26 Feb 2026 18:16:39 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v12 2/3] cmdline: add floating point support
Message-ID: <aaCOB1njWkrUzBFk@bricha3-mobl1.ger.corp.intel.com>
References: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <162c8c5bbecaafc97e698196e57b7835d794a83c.1772124281.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF4E874A00C:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f0e87e-51c9-4396-8a99-08de756332f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: mnc9SMqf126OpRCEMW7OrJun7fiMZ0GTLOUn+X+Qv30s2ye9tPDaJ7yZKwUzhTbJa7zsVKBgQy3jgA+k4WhlTlWG0okilsgAX7RlElowHY4oiYsxHsqpVkEGKYpqepX9wM7WSAK5iXblom+YFcD/Lhha5sJXRkqVCDZfDeouhVGA+fuDVsV53RKcgXueSaiDJGWxzMsLabLXhDhNMCtZOMk9kdC7ju2bSthafkds/gGTCWaJNY1tG3mHmiTd4Y2p/O2OdeiAg73UGXxKxgV5D84ecz8zXqpAzD5lVTkUa0RDysr7tGBMkwZSaRo2jDcXEEIvd2sBspnTngDCdCBj4/f83D9kdp1lZBEpNkypJThrA1tjCFJm2wMkYQvjzekFgKzcuW4ru/hiBEYwt+BFF7O1iTolAkHSAeNvTspBHQcy8LIGVI8aSNM5gSgtqLNmG++Cfay448F5Ydnp4918Ji40dEJQ3tTEzbIVOHdfVQqyBxroX93e7qXXDH/f+Rcglu5vX1cucbDW33vXhLneQ0ePYZUVEHNDXHQ4GhLEZOc77VqObhzQ+UIRa/v3yAMvbp/AaaF9JhvZsvJsxsPe9Lfw+UVQe0BIQmb40Rlvu1mLSN07IVMND2RiUSi8ju6tW01nVbZMsAzRH+hoYrKvrM8SgzHeG6PU/UCf39CfhY96Q0tR4+pqAJO9rmDtprzbMlAbWoQ4/2W5jreQr4lDmQB57+s2bAGBF0n5sDYALp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDQySI2D56jd/QAsW6jYvTAq6puT4rv5y5NZfyYaIEqGPGk/woKItAoLal39?=
 =?us-ascii?Q?1Q1R0afY42ZyI/R9SQwcYVeQRUz7M3/+UN5+/LxCHzZwYAss2r39qnnAI25Q?=
 =?us-ascii?Q?kHG2i0/yEBkImXvYGm2Xw3b984ft4e+rpAWYsTzHtXpQ0C5fC1Q99ZK/3RUe?=
 =?us-ascii?Q?mucp+t5kJ3bDijIsBjuNXcoT9Gfp/e+D/SUTXmowi+8jB1G8nEWiMLYAhNFb?=
 =?us-ascii?Q?WpWzo0cbjgZ82Ylmbv8TZjFZ0XfsPkLblJwAQWG2DeTgrH7dlIbUoc96ALq2?=
 =?us-ascii?Q?faTY66j8dAcJLpFbGkuY4p4eS6rFUgld2xHER3sSuj7o9CGrBGk2UT/AgIKM?=
 =?us-ascii?Q?QRFZfsqpkXHoc3bNBLj5sdjv5lwVHssJC2sL6AvDgT1uNPtxXkyBAYF3BmaI?=
 =?us-ascii?Q?WRbdCzuhm5iR5zIfKzeDvA6EtgpoLJCsxjlMwBlml6ksJsMeWgOEz+E2a6rQ?=
 =?us-ascii?Q?tnq6RGiydTMfgK8FJgnJHapijkhN4sikKlQqFpetCOXLFBJwf6Mb42B0VbRJ?=
 =?us-ascii?Q?ObOp0gEyhXjITtcdl1rTBkLCbt3pGjBQtbFd1lB2Gd16eSoTMkGQaxI9tx0I?=
 =?us-ascii?Q?0/bZb2FO84L2MkfO5bIRW7pKXB+XLvlxpHPW9kcTbYFEwsH6V9yVG7W7ZvLn?=
 =?us-ascii?Q?x8YHYmh/+M2uqd4H+db8yjav2hHnhuWX7LWcqQ/s3Cg9zGYvedGMHcOQGXI6?=
 =?us-ascii?Q?L/oFe5ErMuRvNs5ZWpY+t70h0EJFVXhdbQZyoSUW4pdfCHqh8C/NH+fIISD2?=
 =?us-ascii?Q?NFsAQEL+QFsVhrdBSWNAcJjyeI8zMVH2J424v4tGFAzaRwE40sWo8TQFqTYC?=
 =?us-ascii?Q?qOhavt8UyOTD8fU5K8tRoZKrFCNOUfFwkXA/hgsOzNUcvBBibZMk1PphTBr2?=
 =?us-ascii?Q?AxzzK/BTbVED444EpkdxrVtCX/7hsEtLd+2aof3pG6mUou2otKx3BLE5axQw?=
 =?us-ascii?Q?Gwrg3m6k0Q0uV1fUCGn+xIuRc4MkcrbB/pHEW+65bJEvPn0RRW6WCoV6CyjI?=
 =?us-ascii?Q?V63BpcedQPNkNLF2jxFnJAWV0l5W5h6gGwNJlGXJKV0A3hsHo3SRRYNNzQXQ?=
 =?us-ascii?Q?VsD6NAhGmloRlI74CsQSA2tr0hKMev3Pt5aNPYn/YfQq2hYW451ZgJqGP3v7?=
 =?us-ascii?Q?rt7bqtpuA8xuhKVtMMOFCgBH6D2pFPaODwZrJzOoVq/L7uLS3FcXP9IOONPM?=
 =?us-ascii?Q?LtVxIECgZ+xWvm1Oo3eRVT20ALu5BmAjS7kMDWEw0g00AUrXRsH+LH96l3el?=
 =?us-ascii?Q?B/nu8hLXiVe6+65kjt1+odmRKaCwV9maCK579O6ONjushUq3D9ntU2M4aja9?=
 =?us-ascii?Q?us71tBS83rS+P9l0o8O59RbaXbYBuOzaXcnG5NeIoJsAhXs4GVkPEM0edscn?=
 =?us-ascii?Q?ZISq9ZSZqZsFSxW2gjbxhyodiVbrIR5c66yhaOzJXBBnOYsiyNCQMQzsdCf/?=
 =?us-ascii?Q?VohUsPMTeXD7GEwrjpbMEzh9a9AimiHVHgRiFbgaUavS/DayqXShk/sbGk5f?=
 =?us-ascii?Q?CK5K0wuZfxeXp13KzyxQcNZ0psLyrxHRa/E4jjSeOmYpTglvPnqoQ0yUaxYw?=
 =?us-ascii?Q?3+RShhCL7qA5tx3d+nZ8zxgdVGJqOXvjauh+jsMCHWlr5A478wJFj7ov45tn?=
 =?us-ascii?Q?pR3TiUy23fNuDfFPcPfbbBokUWYrhw1o6dKoJ/KRv0JDfxuF9acdr4+dsUHE?=
 =?us-ascii?Q?Gp3Z2f36xqELLoMgN2c8FqEKuUE49pOG+b5mcI/kvwkM+AXmD1CUFponS2zs?=
 =?us-ascii?Q?5Dw7vABrKo3YvwdKoDE5S1O2yGB6BVs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f0e87e-51c9-4396-8a99-08de756332f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:16:45.2239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrUHlfhFVmJHZQB9Q/Jb7aK0tL+o5ku2du468jn+Jo0L7VToDMY5k+FarXlxR6GNi63rmaO/uxj0xaOOArk6k0/eRg/BOAEF3vAOdMdHlXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
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

On Thu, Feb 26, 2026 at 04:44:49PM +0000, Anatoly Burakov wrote:
> Add support for parsing floating point numbers in cmdline library, as well
> as unit tests for the new functionality. Use C library for parsing.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
