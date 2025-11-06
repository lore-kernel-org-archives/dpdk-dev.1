Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC08CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 12:14:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6534F4029A;
	Thu,  6 Nov 2025 13:14:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 661674021F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 13:14:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762431265; x=1793967265;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zo3MVoKvQ90V03K/IORVimEZB4cNhJRP1sEZXRZF3gc=;
 b=b26EVnflpWr8SZQcduw8ohweqtwhl3Ns3IZra6NWVa4GB5mg/bY+WTug
 gt9JFnZu13TQZmpgi3/Io3klq4aeXM1N485p1yC3kmUdIGycdvTyW/i5V
 teCB47VsdbB6hhahbk9Y35KPPiKEO01QCJvzKm2wt+rJQ3ACwnPZE5IPz
 RbbC70wYm11M7bS0csR0pGvCj4zZQyRZTOLnRpWkoF89SWstW4R5pUGAG
 gZZmZA0I69MFY2DsDxk7TLdm8wXVTGDABjKt4thZVgIT3ZaUzwOzE8Mn1
 w0QS62Das3wpBGXO9WaS2UsSjHa+WlpTB6tfPumcofJ+TOGDMT88eBYnB Q==;
X-CSE-ConnectionGUID: EXBFD6ePTiCDV4BHM69Nag==
X-CSE-MsgGUID: ySQvowpxRdmG7xob2CZtIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68403095"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="68403095"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 04:14:24 -0800
X-CSE-ConnectionGUID: JPMYM3/JTDeglxYrOnYP2w==
X-CSE-MsgGUID: ATp56OkwQAq0Nc5yMvq3/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="192791568"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 04:14:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 04:14:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 04:14:23 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 04:14:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwLGkrHQtyalbz7aoyhK3jGL9eMlA4iUQ+RWbYlit4naxMARWO/iAEdH0NN/Hn/SZh9e1jC0R3xr0MAHiGIVX41GaEGzLVyKLt2cWIJF3JmEQEDXQgUV637Fmq+/4fJLNKUGrMpXNwhLO4ZMf8l4IyUrd/Ef8S+rY9nykK0cr+FPwwfx18SmaiXZlEUCQU5M3ddAab4ppcPXop9vTB2/7bWXOpfGCLt5XUX2b7s7md+YWGIY5jmYVxVhVakjpKK3cV5Q6IHUjSE009zqZBZaNUvtllU2kg9a6OBa45mlcwE3hKLOXDg1k9nrdJR1p9o1hVu0KRLJm/Asru0EHR3zpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6rXtBHurn6xqy7z/qKQk3YlCgsnyXO6s4hXCQ5peAU=;
 b=hNDZQVEEo30pYx9PqboLM1zqkirZvL3ZoFII8Ypv4gpIU49Yjgz0Kotyxlif+4E1I3UHCYxFDQFQ8iJxsDIU3zvOX4mcOzKDrBhgzhrj7PCvW46bDkS2+Ig6bsW2t/gxjjW/RrbUyfbl9KWOwn/5S2nVumgVw9ZUkbkm7ZKvolowpVNo/HvBYan3F/G5hcp0ZQOcl4JDfPk9xUq/mnK1bm8/eU5tWiGxVPqxtiWy2yFOp9OjxMTl9yrUxiJilkWHIlTQJamUw1wxbQb5kmHkLN43U4iI4Yb0gY0oFQwl5Ja95014cNbWG8VmJo9JwUymT7ml7u2F+QMe0xkwPjxbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 12:14:20 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 12:14:19 +0000
Date: Thu, 6 Nov 2025 12:14:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v3 0/4] Update TxPP feature
Message-ID: <aQyRFwvvC1-k8qM3@bricha3-mobl1.ger.corp.intel.com>
References: <20251030173304.260209-3-soumyadeep.hore@intel.com>
 <20251106064638.23020-1-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106064638.23020-1-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DU7P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f2b779-9bd2-4395-34b8-08de1d2e0361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MRHGYpQn9px83sC8Qe8lTYXEs8Abp5RL+X+2qK4LCBZhdCDuhj09e/Dyj7RZ?=
 =?us-ascii?Q?kq8PbDALwNMv9164sLInRhJYSMs0DginLC6/lCkitA1j+USnY3H5BRWjwamb?=
 =?us-ascii?Q?ogyaC31UuVXp0Qi5K1Rphl3PXYEWgWKu+PEe5DdhoneFdB6j2EGBmX30yoBl?=
 =?us-ascii?Q?hzq8nNWGmSkfz5PHCUl2kurPFqsAtTYGVZyQMdVXWmPFIBYbkbCVUO3E2hbS?=
 =?us-ascii?Q?QPKX86jLmLNZ547wv7mNAMI7ekW61+aus+EYIJZSaIjv+dZ/OFAnmFKM4qB7?=
 =?us-ascii?Q?gcf7BUKR1vIcLaki2UsHq1suiRqkTTcIBbYD1ASqu4X7SzpYtqUlaB90k4Fx?=
 =?us-ascii?Q?sXpAhNWVukhFtaDgwFHzvP/ZZmDFuzki3BYT4+aXYqogcl+NroHgJTm9Nk4V?=
 =?us-ascii?Q?TUenbL5anEF4SfXHHauqXuTBZ7IOSWuIRX3tovCjAZxoahbNWz4SMvTX7dDN?=
 =?us-ascii?Q?r+SOupDWGwFI3VSMkNDsa7NzPsz0F82IOMuKe18Y7ZTa9fn+uCskKchp8vDe?=
 =?us-ascii?Q?QBRWZo1KfcZJFrKbxo1wwBJC3i5xzHUS4HWw2HILDMhd01/mg2H/zgIdavFV?=
 =?us-ascii?Q?1FpBvPDkz/gSZilHSEluWpDjxBhsZapKM+wa4tdw7cFjYEp2DnyzouWawULb?=
 =?us-ascii?Q?g4TtuHiCgrmONM5lEFQu1BP2Fi+l8xAeuAsWrsKE5tD7Rn54vuZoDzDFqL3m?=
 =?us-ascii?Q?2h1hw9jW2QoWgR7qri73RZF89gbIWUozVm0c8wUvcXBYu89jC6t+x3K9Fr6s?=
 =?us-ascii?Q?zC8UXPGMlkfqj2HeXXx674FbpOT8YSUA3M30DFJdR/pQw6L9qzJCO+8mOtHZ?=
 =?us-ascii?Q?XLGrvho4imbOhAu5gWV2mkWzN9kItJhRCNJpp4blU9T9UOL/Tx4XIKWbyhd6?=
 =?us-ascii?Q?MIXP9HlLwNtCGWjM4cU78hqRzMO4caXAKqAk2Ffkzh9Eo0Z/uoF7JsjkTXZB?=
 =?us-ascii?Q?lIkOgdGGYLprU+o+pSx2Djz+XMSJQc2ZxhKAHbI6y+NjyuSdlSVbDt+YUKWr?=
 =?us-ascii?Q?Xf0Robhm4a7e72ll9fTPHVHQkeKtru1OTfyckCxdviCPkAvdJ48yEkNH2x+s?=
 =?us-ascii?Q?/2XveS0k5/ubGu78+7RhvEVwJWmz1GimlvYmAHOQ887U4Fc/kqClFH1Y3m+q?=
 =?us-ascii?Q?8FJ9Gt8V+bDTOKjKnTWw4O6OLJ59asIWFF5TTeRnx1ZaeRjOCOHvzCglpJhJ?=
 =?us-ascii?Q?Hl82HTcNV9Pa/a4BngitnYgf0h0shx59wHGxH4sjhFQUnvFzr5qew2V9ISee?=
 =?us-ascii?Q?5lildO6k1IYNb0paES3ZI9c+Rt+IFbMK/vSOtVgJjQUPkxU87aSIlocJ8Z2k?=
 =?us-ascii?Q?qMP0HvJGm0qUvQdQrd5AOugJSBMq/4l9hVAc7Zm9zb/MBKmI6G0KUiWl9iMq?=
 =?us-ascii?Q?GDRXUJj/I0EH/zMYv3gA5ayVZAsyelmcmc/e/4U/Wf4axkt+KV7Kbehy264k?=
 =?us-ascii?Q?JKAeVjCQStGVve6HAEqGZThL8oQB3t/T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrztFJ6R/VAH528CtqFmmdFJRkpC14SfzABHsdFXeH2+lOIfooUak9JTk4kM?=
 =?us-ascii?Q?k+bmx7pitYHplt2KwCHHD2kvOQDQ9HELWNUfYfoxSAVxtvUil3X+PVKo+myA?=
 =?us-ascii?Q?Bgi01UIDNDeqDnQZx2nquH4UCpOVehDe8jWmNvypD5kdI/AgHirs53POFe7L?=
 =?us-ascii?Q?fWv056wywXJ9qCN5asnFPW9RDOwajEzPQ6nkXaBkUljTHUNzBFrXm4cUgjBX?=
 =?us-ascii?Q?o6FvsYnxgSgNTVlY7XCZRymYbQxy86wvhy+KsZptcFLdlNqBrppnrRo1tYeP?=
 =?us-ascii?Q?Na6kQFNksPdxaHjRv3a+LT97wJZ1f062liQ6WDz3ptn3b4WkPvZncR560afv?=
 =?us-ascii?Q?TLvhxcDSW6koyZnPsL8JrmcChbz4TBROQYTAmrxZFTt1uMFJ9rIRWJ25C7yb?=
 =?us-ascii?Q?UEC1Vb81H1P2ctpDPFzNpEAAvavpg9Rp+lr2pPIo+84VS8SYh2wecPmi/L+2?=
 =?us-ascii?Q?w33H3tpGohK+3b/WqQ3lRZbWX1ZwcCEf/KAtw220JXJhW9FrkpMe1ZacyPwM?=
 =?us-ascii?Q?7TfD9v2++R+ht2DytbR0zsb6z96tSqHVbJL0ZrRIq2FB71/axc12yXuJsPcD?=
 =?us-ascii?Q?3U4jrCJmzzAzTznHx+lm9bZGYbu0RAo8LySsNHhfEkn9Tl+EomVQu1GiCHff?=
 =?us-ascii?Q?QB5Wglg+LN3hLFoc30xTo3L9OcSI/AkQVBWhuJ1Htyi14k2srOX09yTbOYyn?=
 =?us-ascii?Q?r0i4ydXCr1ijst+olv9zZXAD1FB7Z+ffv+ZUfQF63Ah/UHRA+l53sSuIRC9m?=
 =?us-ascii?Q?13SspNslSidD8xs7u2DOEcbJY73oG8/cfWz0qFaRZnOa6KSZ9Yvs5/coF3Ao?=
 =?us-ascii?Q?VCQ2yWNtxVMtLPjsm8s2SWOzfGzlCEBWKSnSA6grKPdYpDa9p8FJ/xHklOHE?=
 =?us-ascii?Q?fr8MaJ6idia8Fx2P8qSQcevMfVWzXuyfRWARFprcF0CeP3+LhdNeZp5Lsvdf?=
 =?us-ascii?Q?Phqf1bMlr7dTqa/mZ5Pk76x5TjtH2pxQ1yH+XCyNwiOxUKdUfTJwCIUFK3gr?=
 =?us-ascii?Q?s8YoMB4ZqmOjWkbb2gCKzbvOSOUgYw4C/JEMNzjJ6/05c8IBittbpfoIuEQT?=
 =?us-ascii?Q?ZMy7x304SaIqjL1P+GP4BuJ77KFBG2qUjzHxDIRRvszJGKx4TtixU4a52viH?=
 =?us-ascii?Q?O4QF/7bvIaChKiwSeFzJfW1V5RQywcjffNHUh9wOOt2wA4ek8l3Yb/FhDaRV?=
 =?us-ascii?Q?xvN3gXg5m1TzDKiiUj0fWwwfB5bc7BBJ8tp9Tm1Dl7xM+ZzM/wXBIJVcl4hd?=
 =?us-ascii?Q?+l3fvoxZ1YubbKZyoYjnEtgvJWMo50snE9i7HEbj+rjEq1y6xgGL28LTwoSc?=
 =?us-ascii?Q?inx/fNLIUT5S8uVbCKFBEJ1WIKS0iBgNadsF4bhrOGNZ+dC/9mpTEdLVCINv?=
 =?us-ascii?Q?ypC4UWXig2hA5ejcx/eBuvPrAUGEkzyxCCJbXpTrQCG/1rcrDCg+/jPYdmu5?=
 =?us-ascii?Q?ySm+okIm5O4HauUVeGNy4K/z4y2D/hH6SmO2swaJl1ijB6ifR1WtR4p33MiC?=
 =?us-ascii?Q?RGA7+98LfWbXZ2GsyCsc/QYjCGmDG/Hzp6ty/JOnosIYfedQgAyYPJL/ZUJI?=
 =?us-ascii?Q?u0QTPWbCDlh88bx8R44QTbOpxYQ3knJEYvuEMmCVdDPaP86cUOBQ06pROkvo?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f2b779-9bd2-4395-34b8-08de1d2e0361
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:14:19.7926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uveRGXTyMg4OISBGW+ypggP+jVSRSAtzFGErnMPpz9SLC54GX8zo6b2q7w9+OOORlqGDMR/hth6Z0xI3OwBmoOoXH2RP0rCF7H+4z0iRuN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
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

On Thu, Nov 06, 2025 at 01:46:33AM -0500, Soumyadeep Hore wrote:
> Fix bugs in TxPP implementation and update the documentation
> for the same.
> 
> ---
> v3:
> - Addressed Bruce's comments
> - Enabled ieee1588 fwd with TxPP
> ---
> v2:
> - Addressed Ciara's comments
> ---
> Soumyadeep Hore (4):
>   net/ice: restrict ice PMD to scalar path for TxPP
>   net/ice: fix PTP clock corruption with TxPP
>   net/ice: enable PTP packet forward with TxPP
>   doc: update TxPP documentation
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

/Bruce
