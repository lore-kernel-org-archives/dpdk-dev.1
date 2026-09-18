Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6538FC982DA
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 11:40:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51F6543289;
	Fri, 18 Sep 2026 13:40:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 981F04027C;
 Fri, 18 Sep 2026 13:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789731626; x=1821267626;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nfS6m94i8PAxvn/VliEhYbGrqF1eUD732I7I1eqb5f0=;
 b=RbYPIIgq7dObZDmpVeH9pBof/FlP4354DDwWqiw/0dsotbSvneiXEhla
 qySOuj8cbmYiKY9JYIebaTvnxowaTSRwSu6B42OSYFHK5TPKBkBbsL47t
 PuUH+FtiiNvjXnS5ms8HBkL/Sfct/DsKSVHk3GWqOUnMAAq2hI7MFa2yk
 RwhePqIYvK8AMY56qqw34IOgZkaD0b6B0bv16tmWk+mDtPPmAjuLxSjS5
 3mplNugjkEngqm42w4zQj4T9YKiL9OeH4InQM/lFY07na7udNd6hcpvNA
 h4MVo5R1NNWMwkdvR5C+B9oSqilu257oEdnSv/eaKZeGmVoT7LibwhiIt g==;
X-CSE-ConnectionGUID: Gjkp7jczSaOJPcI+i6TZIA==
X-CSE-MsgGUID: r53xAZZdTZyib/q0drvl8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="90363568"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="90363568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:40:24 -0700
X-CSE-ConnectionGUID: CrwAv60rTae5ZsDshjLBBA==
X-CSE-MsgGUID: X8uHtTPqS9GM+4SueV7XnQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 04:40:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:40:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 04:40:24 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 04:40:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4YXhk3jkEISBfqjQOFazQiy/nobJb2uRHxzeFTjpXwYocRtwm0Y/Qz157uvlpBxCid97jSlX1L0cohOtQCYOmrmbRgNNZIUvEYupH9j6t0156+yDyWTndAXU01VBbntdjJqjxDAcEB1XBzRSQPp0OYpMqCHHhSGQRLHU1jumcVSatckHVyBmvJQWIDrELAQs47X4/QIQmXZdQGNlqfbN4lO9xdZK/BnsOObLJ6lBlhjU6py1qnS0GA1gDYYe8LlwE8CukmKG1WYpEPo/gsi17G23g5D78c9JM/Y+JqFZeM47YDc/y2VVKkSFHSZ6gpNnVpgv2Y8g93yvh6UaLxKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeP8/wdjk72uLR7V1FJrkoWyQCathQ55bAWHyIW2wPk=;
 b=jtHUyXIS1EOU6nmqJFYFoPrIYuxqcrcL+kk1ieLpBsa2Q6ZR4R38QqOBz3eWhoSkAXdKJzmi3j7132nc9ATRJMZdqcOKVdv8BR7nwHI7aMKR7ppEiWCgr42xXAnOPnBw7rrwUQUjj2VZoWV1clzNny+C1md1XbieAVJSqqRCVPLDosVufRDBTT4VJHs+DsyZzs/MCLlzugyTStWuDu/6gC3LyYG76F4Levw1OUF2xWGWsaE/fJ5UsfJ3euzA0o2w/rDPbKkWXVfMwqOa3xgC9qud3eUBzKqLaVXKoTIpEWm77jHcBH80+t/4yGtyca52MM6soNUkcdO3R+hnarWeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 11:40:15 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 11:40:15 +0000
Date: Fri, 18 Sep 2026 12:40:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhang Tengfei <zhtfdev@gmail.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ixgbe: fix leak of filters on flow create
Message-ID: <aq0jGjFFXkPSH_kX@bricha3-mobl1.ger.corp.intel.com>
References: <20260914133836.14644-1-zhtfdev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260914133836.14644-1-zhtfdev@gmail.com>
X-ClientProxiedBy: DUZP191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::19) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcd9182-e7c4-4ab1-11be-08df15799b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7AHLyjt7fPZ0t9tjB8bQEctRZbY/AXj/shCfoBDB/yyYZmOBPn9Yc0APFJqwOnX7nkLX5cuDUnUVhWqUShkXZQ7pNg6eTzkr9Zzsi6UEsyi+nPu6JoFCGjg/JbQKT2WjNJFjPb3xwURrvO9bYXgdEyeGogAxm1dPUeBlF8kItJBlKfafEKh/3xore0rX3FsMBEOp77YMOlgteHrEYH4NWAAijCZ0Ij5Whq1fkLaza5eBU6ah+RFuDXRseeBpl0SqjJdRsGyCBagY3u6qSf31PLs8Tg/1Lkfm5L2OArOy33jpK8SBLSEVup2X3cTzXzQLQ+lH913Yc0YfsQINSdLGXlTxd4WYajGbRbpAqTbglNmxuFICH41/A5JXm5RKIWU0LSBOW4Ztrz3g0RDwtZ9i0Dxe185v93uMz2QykbsXdKWyN9ic7j+jiH/Qr4nq3ZAFP3ASIHa7GW+u9qN+0YRqvXB7A05HGV08JghqnqEbrKWMKtp7QFXTsvt7VsE7rWdxY/lvgfgrOokMWTGnhD+fdX9s/6n4O7mM2mGAZGb0ZLRzgWN8lOh7MbL01c3Lx8PHnLYRQgiNevu2fQsuGWHbjTbQ/UbrbrJMl+X638uBpEfuTvaSQXru7WJ9FlX+eW6EjOrwdERrxpWGOkwIvQIPJnHOkTYfrdp7Yrl+VggnZ4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtjocXK+fQIzOdfChRr5FQxUv1dPcPz7K7jlQLdafjicoDBsXh85ljHwf631?=
 =?us-ascii?Q?e/svyiPyxL30Q72BY7bszMJgtljgMrdOKI2kwMb18fj04De43VTaEr6cYc8o?=
 =?us-ascii?Q?IO4+dlQbHJGDaFXut5ApwY+ymwF3VgtjgGFhF4utbIq86jmAOl1hiVbP0LU8?=
 =?us-ascii?Q?z16o7i0jldy9jlMR2fltl4Tult6YWcqYjEDHgJ1k2O8OO5n/knsz1XJZOS8J?=
 =?us-ascii?Q?tbcY7K7QG9/XliFdC/ZIXmS51kpmmByOmGBmeXm7Xh6Q+sFaJDZL/zjn55q4?=
 =?us-ascii?Q?NBKodCg2Lbvl3cy6dXRDc7QCH/jlWkNJBit2DLmMPCDUH4HTAYIwaIVi+Xmt?=
 =?us-ascii?Q?0cLKBwGpF4h3lXJKNkPySap6hMvOtGdZtjf6FBJcOdYZSGVpOTpB1wcdF7M2?=
 =?us-ascii?Q?AmnYrmKh/rtWPhCv2TUkS3FWoWR6ivPNcKSItKAgjMwWsc1BNxS9BhXaz9bO?=
 =?us-ascii?Q?sE63E6H8I5G0rZSAfVCpJy2TE6zhxMqILzMdRrAOd94pnENUSiWV8Can1T4B?=
 =?us-ascii?Q?XQ9L6MB+7ZEg3NPYnHMucJ+nQkAAImwGSkG4QxuXCmv/nX56+KBB1fGTNKIg?=
 =?us-ascii?Q?SfRJeAX4Nn3al7gKaL7B/aTF4H5A5cI+USgeLfOFKmsQIprekbJCMOk5SvVH?=
 =?us-ascii?Q?lgaEy20lGi6W/e8W2ngiY155IDlsPvr7NKKW751TVp9ceK3sj0POh+NZ3lHi?=
 =?us-ascii?Q?06Id0mRdre3pZ47f0dvIPjSNw3TY2/+wrJpvqm9+XFfat4CGutvHPVO7q9WK?=
 =?us-ascii?Q?HjqP8vhUfYnj5kXaf9RIG3NPjfjoclyjvIM+qFDOTNJAB1aJQ7nykCQ/102i?=
 =?us-ascii?Q?RE1OH2vW3pgPYijF2kiENSgi6GgdMW1+gUAUguC5zyMN+seuNgHed1KCrVfN?=
 =?us-ascii?Q?wMnwYYOa0PhyNso49zZplrcmum1kN42efoWdy0XHn9LBHECYUTT1hiy+K1/U?=
 =?us-ascii?Q?O80Cj9Kj4Yazyqcbi5Ff5uCbAdfbeQQjONmuy7MSlse2OYPyVX2sOOxDdhWD?=
 =?us-ascii?Q?5mdt+4KdQ66LJ+TW4hfSAkBfmTaofqqJw8kBddIPj6IbrvXHBEltoffdrvBd?=
 =?us-ascii?Q?hq9+5Vb5wc6pHTChijMoQcOYTpn+SdKIkL4NawxOr8vFKOx3x5q3xwLkKgTN?=
 =?us-ascii?Q?lS2Cz5Yutlpo3OQp4RBQdWRw0ZLl9wHBzB9Hj0gqoiTLd38gT1KCiBQTy62x?=
 =?us-ascii?Q?3xBocuA0O4KdJJRTBxhYLWPh2gVgWFqFL71I/tIVxOwqnVHk9+Kc58j6a8EZ?=
 =?us-ascii?Q?pijqhQvUDQIxftP4cA0XGC42sbbXYcUm52UvGT4vI4VXndezfhlGlyyltgcE?=
 =?us-ascii?Q?F76i9XqKmQK7cQ1kRtndfGMRYCUwu+3ugQiUdN7tXo/tCmJMHhz3es4GZT5c?=
 =?us-ascii?Q?UsPIpP9P5EfNKjXfMqojMXUOq+9s59+iHlgoOtNJsFRK7V6bXJmd6YIQGXJd?=
 =?us-ascii?Q?Z8NxkzDK1cqaFX2SYzJd/+6t+enmfNtvpTqjthDhu42XkpgpXjtxWH+OZUKz?=
 =?us-ascii?Q?Uc/8W3b4x5o1sVhsElar/YSezvY7wx96uWECjPUTMM9fv/iPuLXbVhIJT2We?=
 =?us-ascii?Q?PVdzhxiXjVkNRm1yKJuJv2Iew3iSIwMBtp1NK7/VCbTSRGc+b37sezSjqokI?=
 =?us-ascii?Q?PSoSF7zIav/KG6TP5vyqmIqSzkZ4aVcqKp09zfd4KT6kydLgNiqEMngveeMM?=
 =?us-ascii?Q?1euHwlFbm+8rY5aMbphiFPiKP0vlR1xAWTiy2dKAm+n3/DbN2Pzos5EPhFII?=
 =?us-ascii?Q?GGv3Vcqe37UzsVTJJnYFRdb2nGhKbsY=3D?=
X-Exchange-RoutingPolicyChecked: rlJOc1shCexVnD1jq/kjXKFm+hhXNdu5O2MjLD3Lde4goJOp3ulFpTtLM1ofRndsbCO8RkafJPwXv3K3LIEbfhapm+NyprE9rpnapzmNm219AoBRjOwF+RKqslJ+Xk9lKYWruUotvHiVoJLDyY/YxUEs0g0b7/ZV4MEgTSmdpc0hQvRNZakg1LuvSUJzKJYFr19Z2bX2wLsdUfk2OzDTPG1OikZ6f1JeQiq2fO7eVLpHRnVc7L9+myUmlO2DEHTreAFq33rjYeneuGEoWF/e6OtKd5+cvA8xzsXk0W7r5l1B5Sq2/4k7fZsbXb/8cM8Na256byusn4kwSqfGVP3yaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd9182-e7c4-4ab1-11be-08df15799b77
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 11:40:15.5828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMRA3fc1WvXRda/i2kL2AFef0hGYimWwU+sJNEOqQfgBCHKvtXQiE0rM+baPJh8Tbjd6wfxZsr4cT3g2oN0Urim3S1hhGUZXVByxU6sxKkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
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

On Mon, Sep 14, 2026 at 09:38:36PM +0800, Zhang Tengfei wrote:
> ixgbe_flow_create() programs ntuple, ethertype, SYN, FDIR, L2 tunnel and
> RSS filters into hardware before allocating the software flow object.
> If that allocation fails, create returns an error but leaves the
> hardware filter installed. The application has no handle to destroy it.
> 
> Allocate the software copy first, then program the hardware. On a
> programming failure, free the copy. Set ENOMEM when allocation fails
> so the error path does not report success.
> 
> L2 tunnel add failures now return immediately instead of falling
> through to RSS parsing, which cannot succeed for a VF/PF E-tag rule
> and overwrote the original error.
> 
> Fixes: 72c135a89f80 ("net/ixgbe: create consistent filter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

This patch needs rebase though. The memcpy calls in the driver have been
replaced by struct assignments. Will try updating on apply.

>  drivers/net/intel/ixgbe/ixgbe_flow.c | 164 +++++++++++++++------------
>  1 file changed, 90 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index 6868893d46..e572a1f21a 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -2858,68 +2858,73 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
>  			actions, &ntuple_filter, error);
>  
>  	if (!ret) {
> +		ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
> +			sizeof(struct ixgbe_ntuple_filter_ele), 0);
> +		if (!ntuple_filter_ptr) {
> +			PMD_DRV_LOG(ERR, "failed to allocate memory");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(&ntuple_filter_ptr->filter_info,
> +			&ntuple_filter,
> +			sizeof(struct rte_eth_ntuple_filter));
>  		ret = ixgbe_add_del_ntuple_filter(adapter, &ntuple_filter, TRUE);
> -		if (!ret) {
> -			ntuple_filter_ptr = rte_zmalloc("ixgbe_ntuple_filter",
> -				sizeof(struct ixgbe_ntuple_filter_ele), 0);
> -			if (!ntuple_filter_ptr) {
> -				PMD_DRV_LOG(ERR, "failed to allocate memory");
> -				goto out;
> -			}
> -			memcpy(&ntuple_filter_ptr->filter_info,
> -				&ntuple_filter,
> -				sizeof(struct rte_eth_ntuple_filter));
> -			flow->rule = ntuple_filter_ptr;
> -			flow->filter_type = RTE_ETH_FILTER_NTUPLE;
> -			return flow;
> +		if (ret) {
> +			rte_free(ntuple_filter_ptr);
> +			goto out;
>  		}
> -		goto out;
> +		flow->rule = ntuple_filter_ptr;
> +		flow->filter_type = RTE_ETH_FILTER_NTUPLE;
> +		return flow;
>  	}
>  
>  	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
>  	ret = ixgbe_parse_ethertype_filter(dev, attr, pattern,
>  				actions, &ethertype_filter, error);
>  	if (!ret) {
> +		ethertype_filter_ptr = rte_zmalloc("ixgbe_ethertype_filter",
> +			sizeof(struct ixgbe_ethertype_filter_ele), 0);
> +		if (!ethertype_filter_ptr) {
> +			PMD_DRV_LOG(ERR, "failed to allocate memory");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(&ethertype_filter_ptr->filter_info,
> +			&ethertype_filter,
> +			sizeof(struct rte_eth_ethertype_filter));
>  		ret = ixgbe_add_del_ethertype_filter(adapter,
>  				&ethertype_filter, TRUE);
> -		if (!ret) {
> -			ethertype_filter_ptr = rte_zmalloc(
> -				"ixgbe_ethertype_filter",
> -				sizeof(struct ixgbe_ethertype_filter_ele), 0);
> -			if (!ethertype_filter_ptr) {
> -				PMD_DRV_LOG(ERR, "failed to allocate memory");
> -				goto out;
> -			}
> -			memcpy(&ethertype_filter_ptr->filter_info,
> -				&ethertype_filter,
> -				sizeof(struct rte_eth_ethertype_filter));
> -			flow->rule = ethertype_filter_ptr;
> -			flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
> -			return flow;
> +		if (ret) {
> +			rte_free(ethertype_filter_ptr);
> +			goto out;
>  		}
> -		goto out;
> +		flow->rule = ethertype_filter_ptr;
> +		flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
> +		return flow;
>  	}
>  
>  	memset(&syn_filter, 0, sizeof(struct rte_eth_syn_filter));
>  	ret = ixgbe_parse_syn_filter(dev, attr, pattern,
>  				actions, &syn_filter, error);
>  	if (!ret) {
> +		syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
> +			sizeof(struct ixgbe_eth_syn_filter_ele), 0);
> +		if (!syn_filter_ptr) {
> +			PMD_DRV_LOG(ERR, "failed to allocate memory");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		memcpy(&syn_filter_ptr->filter_info,
> +			&syn_filter,
> +			sizeof(struct rte_eth_syn_filter));
>  		ret = ixgbe_syn_filter_set(adapter, &syn_filter, TRUE);
> -		if (!ret) {
> -			syn_filter_ptr = rte_zmalloc("ixgbe_syn_filter",
> -				sizeof(struct ixgbe_eth_syn_filter_ele), 0);
> -			if (!syn_filter_ptr) {
> -				PMD_DRV_LOG(ERR, "failed to allocate memory");
> -				goto out;
> -			}
> -			memcpy(&syn_filter_ptr->filter_info,
> -				&syn_filter,
> -				sizeof(struct rte_eth_syn_filter));
> -			flow->rule = syn_filter_ptr;
> -			flow->filter_type = RTE_ETH_FILTER_SYN;
> -			return flow;
> +		if (ret) {
> +			rte_free(syn_filter_ptr);
> +			goto out;
>  		}
> -		goto out;
> +		flow->rule = syn_filter_ptr;
> +		flow->filter_type = RTE_ETH_FILTER_SYN;
> +		return flow;
>  	}
>  
>  	memset(&fdir_rule, 0, sizeof(struct ixgbe_fdir_rule));
> @@ -2929,17 +2934,21 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
>  		struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
>  		bool first_mask = false;
>  
> -		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
> -			&first_mask, error);
> -		if (ret)
> -			goto out;
> -
>  		fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
>  				sizeof(struct ixgbe_fdir_rule_ele), 0);
>  		if (!fdir_rule_ptr) {
>  			PMD_DRV_LOG(ERR, "failed to allocate memory");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
> +			&first_mask, error);
> +		if (ret) {
> +			rte_free(fdir_rule_ptr);
>  			goto out;
>  		}
> +
>  		/* update global state */
>  		if (first_mask) {
>  			fdir_info->mask_added = TRUE;
> @@ -2961,41 +2970,48 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
>  	ret = ixgbe_parse_l2_tn_filter(dev, attr, pattern,
>  					actions, &l2_tn_filter, error);
>  	if (!ret) {
> -		ret = ixgbe_dev_l2_tunnel_filter_add(adapter, &l2_tn_filter, FALSE);
> -		if (!ret) {
> -			l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
> -				sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
> -			if (!l2_tn_filter_ptr) {
> -				PMD_DRV_LOG(ERR, "failed to allocate memory");
> -				goto out;
> -			}
> -			memcpy(&l2_tn_filter_ptr->filter_info,
> -				&l2_tn_filter,
> -				sizeof(struct ixgbe_l2_tunnel_conf));
> -			flow->rule = l2_tn_filter_ptr;
> -			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
> -			return flow;
> +		l2_tn_filter_ptr = rte_zmalloc("ixgbe_l2_tn_filter",
> +			sizeof(struct ixgbe_eth_l2_tunnel_conf_ele), 0);
> +		if (!l2_tn_filter_ptr) {
> +			PMD_DRV_LOG(ERR, "failed to allocate memory");
> +			ret = -ENOMEM;
> +			goto out;
>  		}
> +		memcpy(&l2_tn_filter_ptr->filter_info,
> +			&l2_tn_filter,
> +			sizeof(struct ixgbe_l2_tunnel_conf));
> +		ret = ixgbe_dev_l2_tunnel_filter_add(adapter, &l2_tn_filter,
> +						     FALSE);
> +		if (ret) {
> +			rte_free(l2_tn_filter_ptr);
> +			goto out;
> +		}
> +		flow->rule = l2_tn_filter_ptr;
> +		flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
> +		return flow;
>  	}
>  
>  	memset(&rss_conf, 0, sizeof(struct ixgbe_rte_flow_rss_conf));
>  	ret = ixgbe_parse_rss_filter(dev, attr,
>  					actions, &rss_conf, error);
>  	if (!ret) {
> +		rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
> +			sizeof(struct ixgbe_rss_conf_ele), 0);
> +		if (!rss_filter_ptr) {
> +			PMD_DRV_LOG(ERR, "failed to allocate memory");
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  		ret = ixgbe_config_rss_filter(adapter, &rss_conf, TRUE);
> -		if (!ret) {
> -			rss_filter_ptr = rte_zmalloc("ixgbe_rss_filter",
> -				sizeof(struct ixgbe_rss_conf_ele), 0);
> -			if (!rss_filter_ptr) {
> -				PMD_DRV_LOG(ERR, "failed to allocate memory");
> -				goto out;
> -			}
> -			ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
> -					    &rss_conf.conf);
> -			flow->rule = rss_filter_ptr;
> -			flow->filter_type = RTE_ETH_FILTER_HASH;
> -			return flow;
> +		if (ret) {
> +			rte_free(rss_filter_ptr);
> +			goto out;
>  		}
> +		ixgbe_rss_conf_init(&rss_filter_ptr->filter_info,
> +				    &rss_conf.conf);
> +		flow->rule = rss_filter_ptr;
> +		flow->filter_type = RTE_ETH_FILTER_HASH;
> +		return flow;
>  	}
>  
>  out:
> -- 
> 2.55.0
> 
