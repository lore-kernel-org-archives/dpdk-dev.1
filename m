Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD80FC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 16:46:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6015402DC;
	Wed, 14 May 2025 18:46:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id B8E4A402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 18:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747241169; x=1778777169;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hryI4EKXZsVVXgyRHuayRf76oqHzlcqqZTiN+33UCgQ=;
 b=ddmw3AkHNT5ArnF8V4Fv4VI8V90mKd7zfhj54U9PpLBTaXfDGWM8x5Jr
 zps/L3TkrP0+xm+1jlKeuACX0m5Pq3I4AVfHMxYz43BMu42B4CgKSe4Ur
 RTVaJQdpjSOyW7QK90Oj2B3T3MHho18MV46rh9VEV6eHBJ7uiyCThG8FC
 hqMWFGkkFDbCSfG2fJuqmmF+ZrRAbtOI6xncGFEKkyt/wcPvGlVyExRa2
 T5cgTc8Ald8gOzhNK9SZ0/dBpLwK9E7g4vdGTEeusM3aGMl41qHcDLPoc
 NmjeezDcBy9oKTONJVN2tLxfcMknRKQq+8Qnl3u9WCA9+r+mlKEIuGa+/ Q==;
X-CSE-ConnectionGUID: nr7FR3OQRA6kIapTA72qEA==
X-CSE-MsgGUID: TPzV1t+LQ6iYy7RDoc27yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59376339"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="59376339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:46:05 -0700
X-CSE-ConnectionGUID: jwcvaE24Te66/7VLnnikpQ==
X-CSE-MsgGUID: bCLCqrmfTcSHjacmbDtq+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="169171002"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 09:45:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 09:45:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 09:45:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 09:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ue4RIvgvZOVzTfHFxuWesGPTO+4z7Mu63yAaOox9ZvakMCJoL+GKFwsotEXuDLrgiPoY8TME87zq/8uNXzguTiWvQ3Y4lh4/xfu7MSb/FNbeXlpqVoNZ8Bef67hSpLzOvrhPQMJC08a6eIinQ35TTZPtk+GHKIqIYNiZZtRV3iC3GRY3QBDM0v67Zd2g7JNV/Pvqai4QXe0iJyZp35XtL+GFGbPR5Q1WeKy/yHQ0xi1w3S2oNhpqpVs1+8jGx5LUmkc0Y9JcpIOdooJLhDfRFSk31LXt/s+fZaP8hNannmpYIvlpz0RfSAb3r3bRwRT2Kfu7fRTKcdFS76EHeKvicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YG24BqlGNqeDC1kasoggPd8EiA6xBx9dPsOUHXbdsig=;
 b=U9pEX8FFVsBOYPZb92D0DonTlLsbEou0SaKOdJIdyGwwgTbBDHPll9VqZQIjl/6F6pt+VzvN6PCfDurhvrgYPYBKfXnvXlu8LavYRbFqBcQdUJUqwAMShX44tQ4aOgsVeudCeoO/b72+Cl1buQfNCl6ow1vedl6vHP+kIIyKkjDl8yX+HzbCF/0/3+nM03lul3L59/j4zbegQAf8FDUjWSmYUSos1ERNPwCuvTKufpRyz4XGP5NhFu8vHkMrelKZ9hG9QEM5OK4fDsUnOdjakqUhoELX9t2/+2jH4NpQDlJl3HQcawKC4Zojj0gnGGaM9yjcbB6rwUP0VX2fvQrsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM3PPF2B3CC4BE4.namprd11.prod.outlook.com (2603:10b6:f:fc00::f16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 16:45:49 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 16:45:49 +0000
Date: Wed, 14 May 2025 17:45:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 03/13] net/ixgbe: create common Rx queue structure
Message-ID: <aCTIuNZ_TrG_oHp9@bricha3-mobl1.ger.corp.intel.com>
References: <afcd4013458bdb8b970e7ed57d6a1ede0ee654b8.1747054471.git.anatoly.burakov@intel.com>
 <d7ae19ddd07516f68fc8e2ac7fd92a5aae91fffe.1747054471.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d7ae19ddd07516f68fc8e2ac7fd92a5aae91fffe.1747054471.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P194CA0006.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::15) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM3PPF2B3CC4BE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b4b9bd-293f-4985-31b2-08dd9306c82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CxjGLrZwpCBSBaqSZ133zvIAbfwVI8M2Nz7TX8zyn7xOUXDlY3vMQxZ/H6W8?=
 =?us-ascii?Q?+Au0fAjOCmnE1g+uMHqQDSUUxKc/P2uZdX9uomfWvX+afwNvUDI01/753sy2?=
 =?us-ascii?Q?i4fk0wkaxO6SJPSBTAiGaBYgmZdlf13aR5xjnSU2XhLGrVyMAM/C/KMT/Csv?=
 =?us-ascii?Q?OswrZT9U91Uud54ZgtYmhmhEg6Uu43PC5trNf+XkC/3LX7H+D06GJNugV9PA?=
 =?us-ascii?Q?FO+7jQgkw3b5uPrSiTETxBV5nu4OrJP7nCu6kkXcdja1HOim0+vk97jbdpU5?=
 =?us-ascii?Q?SYVu0EdN2YxoI8N+KKiHKvLdZKbm5Y9PnjdCgAB+54Ot1GCq3C4Xtlhdmkbc?=
 =?us-ascii?Q?MK4qyU7z9YO2Rj3ZESeBYvfoMJY4LmyGhznNqs0nVgG9hJkCeRKSkp19GVfk?=
 =?us-ascii?Q?3Zgu9XWzpmf35kqz0ajHT4A4KLoU3UpTm8m0YHjOva8RZYmWpv4WeifiPqOd?=
 =?us-ascii?Q?I2txMJEXHliYifRMY+UpZRQQ7REtNYm7gyvsCP6ANCM9k5x73+ktwIp+oGwJ?=
 =?us-ascii?Q?I6U+aLITxexfZJjfA1QA6AfcttZiUv33BIoKCXj0LzHdodcrnR3gyINeZgVi?=
 =?us-ascii?Q?szJW1lgTHq1y2yUvVOMQu8ZCfnp0W7nkNttVfQfEiZ+IO/WmJQ7ix6qGCPaa?=
 =?us-ascii?Q?ca1a5nekMtnM1SyIk/4fTf+K8ZUglJ98wcm/OGlWybuml+LHrxlMHjR0LKlV?=
 =?us-ascii?Q?BVSbG0ZL8DSuPPNKn8kO6JiYK5hMHWxqAnE0pjNefkR84r/r8uwIbv5s0iuq?=
 =?us-ascii?Q?HZhfJo3BzrcD1VW859nxAKHEXazuYsxr/HNIR+i9INU6NWL5HyiE1IanI9yK?=
 =?us-ascii?Q?WCM+EVr2kNl1A1iThYjTSXn2MIHbULMpR2Ky+fbGi2e4Mqx2VE2dXEYotYJf?=
 =?us-ascii?Q?yEXldOf6NX9Smx7/f1/qNxU0MIr9IuE84TP7LYQhKgN2iXI4Nhs8c+GkhP3g?=
 =?us-ascii?Q?oT5BJ4Btmk8w0RHJBqkl86NCQ0eiG/R0zMgoGJObSAZfSxNiWN40Su5ZJKEV?=
 =?us-ascii?Q?sSAi4kiQozmr7lgSO9+9XDLkrdEvCl4sq1POepSxuAUwxILjpmW+VEtQXMZI?=
 =?us-ascii?Q?y6obONEDal8GxYfn2xaQwHh6DFeEUVDtaEJWid4J+uXiNVoWZLCuMIFuBOCi?=
 =?us-ascii?Q?9buxupcd6mEW8pgY5hYyGpTmbxImROR2+FYkgduQKnh6CurrVgx81Xp6Y93M?=
 =?us-ascii?Q?Oz3wjyWP5PLioMRsSvEUrEt4fBLoIvRVoJnr0PTLQ91y6wiVwM6toZuVKrZn?=
 =?us-ascii?Q?64ebA6EYOEirIQ83FmdfEV/yfLAYB3JWf2t8dQByIC2SUijkEv3aSuDBTvik?=
 =?us-ascii?Q?AoV+7qc6Hba4GsatCmtqnFJ1W8XIaS6cjWpUCs/9lVNbrhSWf9eJwc9BPmTk?=
 =?us-ascii?Q?f1uE/pWPFNyZvDRUzEzQ1GxKRd/0+/6nPfQh94BQGqtUsCD+lOJmFtOBWrrr?=
 =?us-ascii?Q?i9CzGEDR4PY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tyw0bHCkHTBHIyACcSfM+MrGd/jV6zPuu5vd20awLVyBDRO1k0De46/7y66T?=
 =?us-ascii?Q?iiDUL7W4M+faLSiarlwWs3uoVzlxWGkmzGEBFRdJetH3+Qk538kHAGxB1XZb?=
 =?us-ascii?Q?em2X7MYXrsVN1y6LZYW/bY+JhGYTrgBOuOGnfUfe1qhZnutyxhIWXniOMXti?=
 =?us-ascii?Q?+VO+pX8etR98NNpIsCSgB5KA8PCl9V75V+jxJQbWVgPkhN1ZuHdJo6Kmurjx?=
 =?us-ascii?Q?4Yno7NBb+5r3KzxTYgfWWXg+PU4/n5aDciLo02MbQgj1aCvZJAm50fqXEKnK?=
 =?us-ascii?Q?aTN+3MBkNgCiEyASBRcyvZl7vB3sm6Cv6duyJDsB7BwUWB3cqV2ZJdy+pqhh?=
 =?us-ascii?Q?FpGZ5/eCYbU1ImCIAOJvfH8lIKUV2d1DTonBiL9jad0qK74wCAEcjWcLyvFC?=
 =?us-ascii?Q?rJkhXoF9ZONJQBf8pwRqQrxoHeOL6nk7U8VfkaCCLWLCpx0kF6QbCKoF+B0f?=
 =?us-ascii?Q?hh61NBEwcxL3dDaVxBM86xbbm5mWZ/unk0iPUedRrPju2SQWOOZyXEcuCH/e?=
 =?us-ascii?Q?hIYEb0y6EikH3+3IWVskJs+e4rK9NdSXsLz9qtPWNZGgU3eJf5+MsSUkrlKO?=
 =?us-ascii?Q?R4zWvEAEt/gJVwyt3bNIUG10xJzlhWtuEhn19irhFXEWP16dm7e/ldji9BVG?=
 =?us-ascii?Q?+81QWlN1fXDadNrBsp1T26bcprbN6++yZQjnN3KwLNeS6sAPpjicCEJs29Mi?=
 =?us-ascii?Q?k+409m40rfV2GQe7Yge7mgI/BEMGHH6scJUiVcYgr6XrmtTeQwCsPRmkxlQb?=
 =?us-ascii?Q?UsJpMPSP6vmZ5UEAeDubYD54HYPkJbNbdX8Dhi0LBhAY9QctCgYeiLSDnQYe?=
 =?us-ascii?Q?Us/NA1GqWpNlircPbGqO4mHOrPatPQA9c4VpLwCVl1RhOiD4FS4QrTW9g7WY?=
 =?us-ascii?Q?tepw8LuuDs117eG0SHEvcavB7DpwKAfF0JgoKRApr18zRsxRTlN2mtqdg+L/?=
 =?us-ascii?Q?SqBOLRLR+RRWEhVtkChc2PrTOEzvtbpnNuw86tlPcpfTV7IAW/P+i8IPQmGC?=
 =?us-ascii?Q?qlNGA/wiD4z5Y0ATrO7EgKWuH98aMBb1RsrWkBDRAWy10ek4/363w7uIrpGR?=
 =?us-ascii?Q?zCW+LMy2QRDz33m1HNqwpBat17fBvzcs363HLU4uSh5WzveM80e/2SLgONjh?=
 =?us-ascii?Q?Cwd48cVo3SfkUZjTtQpIt6T1paghdYckZMGHw5CGrBfqdBjuVika3bLazBHP?=
 =?us-ascii?Q?HYmdgoVzzM9BOYv1y8+BZJ9rRI+O+abEvIDaD80CTMqIpSqZkb7p6vqQmHCo?=
 =?us-ascii?Q?UgIwTYM6ktCbs1vEpiNPD+8KMyq1RuGYBT1w2KvH9W2TsXLGSg8Ohx8LP6WQ?=
 =?us-ascii?Q?ZVfiGXkbDE3jMukmX1Iu6fBLySWOlZLBoPfeCe5OB1T6xi6ESDY8i2PKe+a4?=
 =?us-ascii?Q?qQKs/M+OoIcvKHDFBUeUGJK5NXZHrxr+PvkQtNAvwkPppEvqG/Bl79zLxj6X?=
 =?us-ascii?Q?VMgrxKU11lqIWByan7bcQ0BGTjTM7hIhSZk9zUu7k9+9X/yl/806bYdPKrdq?=
 =?us-ascii?Q?0BOlWqYISAkYZjieBABwIOYov3K9mrxEaewOmBXkQ3Puj4HZ+mJ5nN4c7cTE?=
 =?us-ascii?Q?L5v7oaj5yEhO6fivRhIPksgBhCxlRT9ZUwszGq/6Ahne/4v4519ygtlmpTvK?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b4b9bd-293f-4985-31b2-08dd9306c82c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 16:45:49.7674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbtavYuHpzSaST57ip1h7ahZQwEDnaLllSccArT/AVVRvEDbY3kebK/sDdlWbEbQUC9odC/OZnsQEMOmEil44sjZqmDBtAaFhklnkzusI9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2B3CC4BE4
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

On Mon, May 12, 2025 at 01:54:29PM +0100, Anatoly Burakov wrote:
> In preparation for deduplication effort, generalize the Rx queue structure.
> 
> Most of the fields are simply moved to common/rx.h, clarifying the comments
> where necessary. There are some instances where the field is renamed when
> moving, to make it more consistent with the rest of the codebase.
> 
> Specifically, the following fields are renamed:
> 
> - rdt_reg_addr -> qrx_tail (Rx ring tail register address)
> - rx_using_sse -> vector_rx (indicates if vectorized path is enabled)
> - mb_pool -> mp (other drivers use this name)
> 
> Additionally, some per-driver defines are now also moved to aforementioned
> common Rx header, and re-defined in the driver using said common values.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/common/rx.h                 |  62 ++++++++
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   8 +-
>  .../ixgbe/ixgbe_recycle_mbufs_vec_common.c    |   8 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 149 +++++++++---------
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  67 +-------
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   |   4 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c |  22 +--
>  drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  |  22 +--
>  8 files changed, 172 insertions(+), 170 deletions(-)
> 

I think for ease of git history review, I think I'd like this split into
two patches - one for the ixgbe changes to rename the fields, and then a
second patch to just move the structure to common.

/Bruce

