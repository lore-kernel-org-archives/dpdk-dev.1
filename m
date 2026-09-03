Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D94C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BAFC427A4;
	Thu,  3 Sep 2026 12:56:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 234274028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:56:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788432965; x=1819968965;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fg1orb8lp7GFFT+aDm+4BKBIF2uN8n4+oHr5G8PH+yk=;
 b=FVbzpiM/ask1tyHkAfeD960g+GPePEGUU79pWXHGL7Niyu+XSzLc3sDA
 3Bd/gtkN4N0c8J39QuRRWT9r7JloSCM79R77iugqRe/stYWBC7YTSPgYx
 ISKX62yqDUCJPUGv7ZGXY4Dn1PqZKo0Qz6JycALr6JpXxcBD8nBvgrD1j
 G+2IeNk14HfX3vyiYsNisM+7N5fFaQQGpr1wUVkZmhYTpxdnibMldWA7x
 GwQrzOXKz9r3AItIpmzE3yV1DOIHgbymAmWxHRVTLCuW3PUDS72fx1UoJ
 F7cvnJykUDiewJTtSdNwKE+c6IOs3F70WAvXLVSwJRtu99e6WzeDAVFpd w==;
X-CSE-ConnectionGUID: ZEqoeG58Sfe9U/fPkXLUEg==
X-CSE-MsgGUID: cCMEP6YPQzKEGnZHAUelfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="89032489"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="89032489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:56:04 -0700
X-CSE-ConnectionGUID: 7IfGQ19EQ/+RreKmXdth+w==
X-CSE-MsgGUID: TzSZqB9kT9urIwNE0nleYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="293191541"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:56:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:56:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:56:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqBUtsB4bhRTkz0XeC4uWH8Gf8PCcSuksYI9ZM+o0yPwd0BzPS839GxJlsprb9yNqaMCakLqrhpnW431UbzCzrekrS+uGELQl/Tv0inWm6qkevNLsVEurHZY6T+AInNOAY3gdrRgPZ5oNppTotdnq40pYJgyJZcwnaqZzfG+4PKbAEEbrXBjwAyCnZ6ayoXHBmCYi5XxlEcwcAt/QTwIrYEYe3T4qZDQ1kAm2bfOQJNZkdwbPF1VCphm6IVBR8wpZc3CjLrfpxxFQnQZlv9ytUnY28CAbMrOrUcid3yBvDZ0H+e3zUBtjbFuxbhp3x4k8HC7L7ujUmY1y20QAxhzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRAHntlAIDWy9HeVdmtDFOyiFg4rhyee/Mn4HzLYUeE=;
 b=LRJCrU+bkKtwoz37TX1S9YQejhKjhXMhVw9KMeDZAfibluofNv6emTqwl7RhGCkONLw4oLKGnx7rcW5s+HcOuPjO+0kv/a3wHXrWQillmuhJstF4KS2o+MvxKVe7QDFQceqDuzkJjTOfjY+zUNsNhsOAxc+pxEFAg5fhsxSMkPG0fdLsV2simJEN5eAFFNkacP36Npd3B5Mk0jTJQHaeY+MqfVwEidoPaGaQXY9vjEIfOm3D8SDfSsHB0YhcMqUXiJ7UoU53oKBamXvb0+aJUY1tOCIXKy7sNpNEb1v+m9D+tjFLS4wVviFJfaZ28bpmFu0RQb0nz6kGzQZ2tbOkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DS0PR11MB7189.namprd11.prod.outlook.com (2603:10b6:8:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Thu, 3 Sep
 2026 10:55:55 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:55:54 +0000
Date: Thu, 3 Sep 2026 11:55:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 23/23] doc: add release note about rte_ethdev changes
Message-ID: <aplSN50bQAij7IX1@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-24-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-24-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0215.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::9) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DS0PR11MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 223a152d-5502-4c63-f0c1-08df09a9ed64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|4143699003|11063799006|10067099003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: IbeZeOX2aq71olOKjxgviXZR2+X4pPu+5ztJnBkCg3nRGgBDFBwD9NyoY4UKtT7ir7G5CCYBp8jpVI5DtvsbLu3ZcH6903C4Lwsf4V7g3mHP8ff3KL6uemodu1prDoOzbFMlkNiaBA3rmgIGkmbihgAxjYdsLNDE3dtXW5qkz+7w0XqU95Vi6Xrw+52WFiYlyStEPDDHzws8sju01P/GapfZNs+fhWzXK2N+W+sS3rhbsfr+u2B5WWii9SnTxPdvYBADtJKxoY8JgKDmMfUCbtjrvey4DzYreuCvFIzuDQrxrWlNdpX0X4a6528fT6vZCkSySAFkKkgd8+6sAoO5/zkcXXzGoInmEgRuI0Jg4VmpePFyqqx8HLvK6cH8PYYqfReR1ajZPHuGOlqTPQC69iEqckfny3VUqfw3qzSyWpr4HMGr+SK0Q88k5Dq0iynjP5/fZCmVp2wj/A8Di1TlADIlbmtlqcnp3oFd2jwI4MMjaifcyspOZUq0RPVanrtV0UBKnAl+f2WjqiW2cXGKwnQLk0jufi46TriSq+K38PIU9K/fEpLT1UqTt+0Ry4UqMqWjCD6FriMY9+nejTP/itLj/RGLVmMAdbshrQOfiaPGEn6Hqi5CiipPBWpw8j02pjAJuXVesdJa5ILVOyCAsU3R757lXOo/VhADqcpeBKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?03gEOEeJxW/6RhZQxP/xE0M24lLRcgKTzLRP10aX0F096DvgYp6Du0wVqYeq?=
 =?us-ascii?Q?FQ63RCnYQSs+cSXmkElLxTVwl0IWO9h1L8ItYmvEvO19nxfgw26YLeDnt8Ww?=
 =?us-ascii?Q?Q93EkcdRjJ2oST6Mj5oAx+l2+a0kAx7ncYzt3Go8U8dr3BcbzS5fWMikDAQ9?=
 =?us-ascii?Q?cTt8oOBVoL8n8OxDHkbpkeeDH/kJJylkfmygUs3RJL7NkqSs6A/tfIm8KKTN?=
 =?us-ascii?Q?xKPvgT1V5P1knILhZ/Ql4jtEwe2XsDCL0Fk+tC6EJ4shbT2lMhKYf+zkEeI2?=
 =?us-ascii?Q?xk3yHQXu+1MqCA0tjKQSsajm33JqHmldB3QhCu4oMcSxWsA1hDWrxMUxshc8?=
 =?us-ascii?Q?sK1ZNmojh9lDxI2ECq+xUDMYesK50g6j/KBtUKpUdVY7G168SH64Q58QWasu?=
 =?us-ascii?Q?e62qmuNQiEZxjCxfz7AiKaFwaQRMO5ae0uxXIDCDLBkeAgg1UdFhdmT3O+Sf?=
 =?us-ascii?Q?FJbU9kqn2+0MtC94fzAXMScXw/d7EDlB2y+qLehfeC+im3+w6sH9kqjRzkt0?=
 =?us-ascii?Q?O9ayd8hHp7yVB9t3xAJCejFb9YjbOWrfAfpThA/8JZ6mDOoe90UymAhQZWoI?=
 =?us-ascii?Q?iYIEqirAM/xgG9uDFF5h7yeZhn4ymE2E07S/NJwC9t47d9Zlljo+DQFMLUA2?=
 =?us-ascii?Q?8tuHsb05beKWR20nv88J6szH8SuN+1QLXLyC7Pxak808A6PbjFTB7VW9/U9r?=
 =?us-ascii?Q?n9EQTOY8d3SJ5fF5F99U//NluvIq7g45QqyGf/thKbuRkt0HXO7L7wAXdZNd?=
 =?us-ascii?Q?Duo0xnLbXZ1t+2pB/jxR83TgU7IG8acBZDALIdkugbZzLF3/ALozYjoymQ9h?=
 =?us-ascii?Q?dc+x491cU4NzhbYAepA9YsTGJcSrwusuzyBvZ6IGXrrjjTWbjJ7WO4+8+ZVc?=
 =?us-ascii?Q?8I9D3w3nU+wcLVwTSxiiZg7V+YOcMHczjswIe5Sz1QS/5arPgb8A8anwGleP?=
 =?us-ascii?Q?pv09fo+2FsoR0BzL37dgSxXd7KqKxvn3C7jtarJ7Xklb9Ml6q85Qo+GtQz5V?=
 =?us-ascii?Q?I3QKzFbnC/F+isGmzA/fjMvhhQsbwMNx3dYafO41huCQosYfy7WhqQZZBUF2?=
 =?us-ascii?Q?5UsLDnVLRuUZwR/qsoSOfySGv9LfgcSgI1kA/toTNU8D5pm6cRiFeu94TOlM?=
 =?us-ascii?Q?ral64hqUtKX3J4id/r3IJtwjhGKphz0zTqwMs/eoP8Nt62eniMAAXTFUTXYc?=
 =?us-ascii?Q?ji3XZEKcjoZqq+6NpQSLlFX166/g3bWDls/wAo0XEGVWEeHR+7OjN9DvX/3h?=
 =?us-ascii?Q?oD5UKc62e6ZLtEcY8LsSTW4vHxgvGRFs7/CvkaOfNUOPCNGxtiUcfe44ZQ60?=
 =?us-ascii?Q?sBlHO12KWIpcfiC1vEX6Ae/E/l2efUxVEHyIHXbcT+B/yrodgS/zYMF5c6na?=
 =?us-ascii?Q?zb6oZCtZSlSq0D327HTudLw8wN7ST4xIm6nil6ZhP2QqtsYox9kJAqol+BE7?=
 =?us-ascii?Q?Yc3KSWeIv+xovYUzGsII49Lp7iEODUy3qgDMkehHLgVkCJGkZcnv+60aYxIY?=
 =?us-ascii?Q?IU1SrkyEmkzSgLOExHf99ps4RPEBgm6lsKMkT+2CRkrBrxMXKrGg7xWjtX3f?=
 =?us-ascii?Q?hhT4hUfYGTL1VWj+wTJApoa8hnfVR1CrVQ3fzGjMQbEIeKRfeo6h1q7D8beU?=
 =?us-ascii?Q?UJhjeIse10j94pZjjTFzwFUDOMOnvi6j1JqxC6XLp1xjIU6kkXF+XU7rKADC?=
 =?us-ascii?Q?rdRRqx+3R/Ihc8jrmgRveiETdOEIDnBSljseV0DS28sHwVHmUO08hxTMDca+?=
 =?us-ascii?Q?Vnn1/nHW/CKzBWxzIHTu6iZPtN30osI=3D?=
X-Exchange-RoutingPolicyChecked: FUun6E92elA1H071vEBj3tkl1edi1R5G0t6k58c4uQSHyJZkJaPRx+cX35dPjBZV0ppM3roLxVH6zcVCRfwURS3ZBGm6UC9TTtXFFEhNTVUTaKCpXF3KxSW/g4xjc6309hj/RPw/TDTldVqxLvHmWPnpvGDqtKRbKRE/W1TjP2zAkKjALOFzTgTx/vvTlvtte+nDjsGJVbmRgHk+9g3qR2hiHjDOBnKxu9P59tyAwqTUd16/cceRppnf1krjN8UF/GVx/6h09wOBYuFE3A+v1d56Yh6nxDuiOaSHIarCV5M5kKF7damnP7wfTrOMrc38m7+Oi+520/7ySpQr3Khv1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 223a152d-5502-4c63-f0c1-08df09a9ed64
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:55:54.8927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFloSMSWAIdx4sDFNvQkpwiUTIFuiO/FprBXQ5FpE8d0BLwLB28A7HIv1HGof7O74ZbbgALooMHcYW7OJRVUvWLDMNns4F9Yl7sHbQAwWXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7189
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

On Wed, Aug 05, 2026 at 10:09:17PM -0700, Stephen Hemminger wrote:
> The changes to rte_ethdev are visible to applications,
> which may need to include some network headers directly.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index c8cc86295d..3749cbd456 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -77,6 +77,21 @@ Removed Items
>      ``rte_rib6_is_equal``
>    * table: ``RTE_LPM_IPV6_ADDR_SIZE``
>  
> +* Removed legacy flow director related API and files.
> +
> +  * Removed experimental APIs in:
> +
> +    * ixgbe: ``rte_pmd_ixgbe_get_fdir_info``, ``rte_pmd_ixgbe_get_fdir_stats``
> +    * i40e: ``rte_pmd_i40e_get_fdir_info``, ``rte_pmd_i40e_get_fdir_stats``
> +

Some concerns about this. I'd rather see them deprecated and then removed
in a later release next year.

> +  * Removed testpmd commands:
> +
> +    The ``fdir`` option in ``show port`` and ``clear port`` were removed.
> +
> +  * Removed file ``rte_eth_ctrl.h``.
> +    Drivers that still require FDIR related structures now use ``ethdev_fdir.h``
> +    in driver SDK.
> +

Fine with this removal.

>  API Changes
>  -----------
> @@ -93,6 +108,15 @@ API Changes
>     Also, make sure to start the actual text at the margin.
>     =======================================================
>  
> +* **Changed ethdev include files.**
> +
> +  * Dropped inclusion of ``rte_flow.h`` in ``rte_ethdev.h``.
> +    Applications using flow API should include it directly.
> +  * Network headers ``rte_ip.h``, ``rte_udp.h``, ``rte_tcp.h`` and ``rte_sctp.h``
> +    are no longer indirectly included by ``rte_ethdev.h``.
> +    Applications should include network headers as needed.
> +  * Legacy flow director definitions are no longer included by ``rte_ethdev.h``.
> +
>  
>  ABI Changes
>  -----------
> -- 
> 2.53.0
> 
