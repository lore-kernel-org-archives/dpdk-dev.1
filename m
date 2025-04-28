Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AC3C369DC
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 16:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DB24402A9;
	Mon, 28 Apr 2025 18:11:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 277CC4021F
 for <dev@dpdk.org>; Mon, 28 Apr 2025 18:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745856685; x=1777392685;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nHylvBmJ/8mxE2eXL+2VB68MRj53GkpRZB0qVpEBD3w=;
 b=aUSbfyhBZolXROz72/5zGLDSrU9mWwP1B9Pl2th+VgHSpeh7Odu4m6IJ
 rgvfFlXA4vvY+Cm/IKfAe+lJDbS/FNOVSf8nA42plcnt20FBoMKaIaKIp
 fiy6QL2ZWth3DcP2Z+MZ0++VF0yhVX+DAWhUuZDvPfaKDtu4ln+F41eUu
 TDL2Leh5/791BRvBJBboL3k3gfpjkfMI24jo1tpT7NusNXBfQ3vQBHhDe
 AXEm+YvH3fqFpDV1oWkynf7B/F7gT0b/ghUnBteUNQT9PFDqSfxPbgTPD
 +bzQ6vPiR/G8qhAMmYIQLzQ04s6zuorOfApzc64u8Voo1R7sshJRgVZ8/ A==;
X-CSE-ConnectionGUID: 1nFZofPFSXmxSR7Yjby5EA==
X-CSE-MsgGUID: p6q6s3FTQXKRCrQFgRwIEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="51125903"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="51125903"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 09:11:20 -0700
X-CSE-ConnectionGUID: YfJpjtCQTUSieCuAxT3Rwg==
X-CSE-MsgGUID: 7P9L47RSTniVZP4M+ID5rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="134060157"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 09:11:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 28 Apr 2025 09:11:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 28 Apr 2025 09:11:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 28 Apr 2025 09:11:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJiZe2BmLUSD2+oqa9eY2rlQBy9IoahFU+kkGAYSPWbxKEUNX9+1db9IvHPWLr1jDnojm/VEY71H3I0Vt95paczntpIYk339veOzPh9QefMcjvlzaPxI57gpu2WnRnU+BWYtToXFixSz+sbU8bgfg5vgZFEJrr4DwVtnnbhjEsw1P/pzVfck9K5U2ho5U83kWJi/jAJA1nZdLvchEb5DVff4Z7Tt8kRZ7H0/UEUkldfiMlRm5vBCzjXza8u6Vmf7Agr+75j3XQZ/2wR7fxQk7sKrLj9r04ZnzLSJcTVpxMQzIWCNntR70XJiORjtWUnvmwtLiAraDVaYkZlQf2yK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLxb0+irKk3PcJSDRBNYas2gnJCi9V3O7oBba5w3Wbc=;
 b=Kdfv6vbVZpHz6QB7rb9lO9VQOcSPJRbQSPdJv+Xmg0dH9eA0f4OUS44BzGF4y1Jx0z+s53ck4z8TXtHMnY0FR0Yg2bbzEU8ydhlfbZLcF/qI0JEVJUR0p0xrph9K2b0S/Gh2OZgWNsl2D4fMKYDJt2AvbFt5c6QqdqC4fgohmPpgScQ8CVgEKzn3oo7krNg0fZwJHBuAh3FDflTxFB/V/SpAGU6eG29MbAo8QhTUuKI9YgYO+8keSgEdL1Dmk+hHTLPxhdGhVUvSI/9c7Hee2MHMM5JUXCJOHqWBjcDvzfF5Sw7JPVadGBUav+4MY7rYzJQnU81MyDYWxYMyUSL0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6195.namprd11.prod.outlook.com (2603:10b6:208:3e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 16:10:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 16:10:42 +0000
Date: Mon, 28 Apr 2025 17:10:37 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Roger Melton <rmelton@cisco.com>
CC: <vladimir.medvedkin@intel.com>, <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v3] net/ixgbe: support Rx/Tx burst mode info
Message-ID: <aA-ofe1zhRsrokcU@bricha3-mobl1.ger.corp.intel.com>
References: <20250416171111.3094521-1-rmelton@cisco.com>
 <20250416172310.82448-1-rmelton@cisco.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416172310.82448-1-rmelton@cisco.com>
X-ClientProxiedBy: DU2PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:10:234::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: d236e146-b1a4-460b-ce0d-08dd866f3979
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L6HH6KEeGjcG3pQoI/M+2cWpQUyWzu+l9e6jMSBMS54US7wXzpCKXle7Sjgz?=
 =?us-ascii?Q?1KJbecCzz9CI/KMJsqlzlGCpOvtaikoSlXQrSaBoctPdByVe/QTa/xMa2oRF?=
 =?us-ascii?Q?pqtYz3XJvyhaZwWV5qHT+c1g2v7ADKrrZm0tWt/pvZWlDnk3FZdPPx2MlWbu?=
 =?us-ascii?Q?bYTESPM/YQLT3YPzXxjPxWKBDREN0Y21vfk78DGgjEWCyGMeDBkN4TCRZh3D?=
 =?us-ascii?Q?Ep+jJlW3REql9YjOQ6oXjBArbpQOk9larnjvPnlSsDnGWGTFtwkBiHBz8u4P?=
 =?us-ascii?Q?JQMCVHG3Ahn114tyo3MD74dY8gEGg1MNm3G9k3BQm9VYxnxKLit7cpsRrSSh?=
 =?us-ascii?Q?iMqF1axhVQCPm1zLvkvc/td7GrPgmtYaX0k23hAVXjDCeNR7pYGVhPEJgQRM?=
 =?us-ascii?Q?6qMOU/6ps8ptX6bDI1H8hk5/5Na6cXPl6uYYEaMk7DKn88fvRzRn+t+Egbxd?=
 =?us-ascii?Q?D9ivj7Z8Z21XZIdkFXajK70SGN0416vqX/qmIu7sEB2A+dKQxGoDdkWFtfs2?=
 =?us-ascii?Q?iPXmH6Wbul2V/Js2BxDNz5NsPRec6aQAHxv3CRkoCE0/acrIQj43kq4/pOgB?=
 =?us-ascii?Q?TEnvSDz2UjNslT3RwaiNYF05UglukP1h4F9JFWvXPhSEfowvq2XHiBsW8SyA?=
 =?us-ascii?Q?8pG3YpOsh5Tsv67zVvCZF9+OAOQr9CGWIKPSMsqM83aWHPG/HqTV5Jl3RLEf?=
 =?us-ascii?Q?zQzpB0IfhopRPR5NY7tzK9XDkuYc5HbwKhv+/100vG3XlAvd/3NI//TuneR7?=
 =?us-ascii?Q?G6uNqE7JATNepAjMceYzNYmZs65Ic7GnmCJVHuuy3PP8TTNkjfs2nOSWKmtq?=
 =?us-ascii?Q?N58/esjV4+iYS9d5D0TLZoOFx3hUyEVMPum/laer71eJhoEX9CfE2uHyWIGb?=
 =?us-ascii?Q?5Nyl7uwMvXcNlU6bGs9uOjnkYnDwHHvO+V7z2o7jXYnqzsSKjKvNZ9NeSWTF?=
 =?us-ascii?Q?04KPJWlFuwY3+7V63BL7tY3Krx6ihH6jA7I0+eucfTgkWH8tTltlVb05z7a9?=
 =?us-ascii?Q?s0eb4p5vrpOYMDKzjwWS94dmICBEpcqYLS0XxzwTUGouu2skgY8Vne7oBOls?=
 =?us-ascii?Q?WgFr3MFIg46koJ721ZHaONQwvl0DUj15MnWeKPZi+dpIjQ+vpVfWKiejHbT7?=
 =?us-ascii?Q?uWynuvbDE94WxnES6nsNIDBpvtk/PQtG6O/QyJwWOgTB7q/gFNbE5Ou1+qG0?=
 =?us-ascii?Q?mibfYPjGflZWTWJXa8sa0dZGnO/OsLPUagWTc7dLGfVyc3o2OaF1WdRhk+wM?=
 =?us-ascii?Q?nVHFD1cYDq1YacnZo7OwPbRmLgJ1kNjXJfoXhQ2W0a3DzNGMDgwBFIxIGmZE?=
 =?us-ascii?Q?phZwCP2SiYBygGZ7Pa2eufq0+WdDzTmysTI277QWVcvtjLOp4F+TxQrORT+D?=
 =?us-ascii?Q?vVWxh17912XMM84jxjujCwlEaOcPINd5QOkP6NbI2RSWmbSMSVNa2jg8L8UR?=
 =?us-ascii?Q?iFv3oOt5bJE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uD2mh9j92y1hYpUX5YVgVHGweHjNF7mSPMPKyBvCPR+rlEWOOQ5YaIM3jWDD?=
 =?us-ascii?Q?L2jrP4WDog62n79ceok8JQNB0EEH8sfg9OW9+SHJm/OVjnxuZhhCZOOR9jct?=
 =?us-ascii?Q?Aw1gFyLtJBcJTx8/WvzvpUMWPwgfekb19rKrnVLfvG/qV1Xo6fxUbbnLzGF8?=
 =?us-ascii?Q?B8lsAwpiHq+G/gcBg5J6m7Wi7hAEEEDE/3oWpzqxd4VXdzf7XCjqtvldOkyg?=
 =?us-ascii?Q?Td0peuiXYv5DCpio68rvF4ZRB2qlYmMeuatXMiy1yEhscTBCyLnf0CjILt7E?=
 =?us-ascii?Q?zLY2jDjZd8TNfdmVikLTg1gYvo+jOr0iEhee2fYddBtmZOrKFiCekiby94v/?=
 =?us-ascii?Q?YhCeglWgS5Ev9KtV5NR9WH4xcV2efpdyQ4wh9+vtXap3rLNd4L5gz5IfCdPl?=
 =?us-ascii?Q?UDMYZtREih4sUV0Lu8mOjPcdy66B6GhOIHu37TcH9oHf6/mznPbn9Ce9sgtn?=
 =?us-ascii?Q?7P9E0pV7+Ex8ZIgd6nAFmXts5seB4mP6ruxCuqfapnE9caOPVMYrI4DJ604m?=
 =?us-ascii?Q?bGjQVpNCOe99LOhNbdNsdpCsYC5uTZphudEp/t893T1UepaDNE63FTrCyT/N?=
 =?us-ascii?Q?zMBcAuAYkus96VzJUaCIWgSXOKMYNErXwbJhcHzwCljnswvmeqG5VN7HWVjS?=
 =?us-ascii?Q?esquALSMORsvU2n6QQfkxpPP6wpQRBQJygkit/u2qK5ZnfKdL9JqPG0eoXOh?=
 =?us-ascii?Q?NiJS7lwfMN6hpPCuFKdgMwws7OBVnjrXX5APIYe5LVbCXsjCpsv3KnjBExEN?=
 =?us-ascii?Q?FS7Jtxwz9W1Svks3wUoVhMzyi09RT4g7Ujxq+/1Zgl85jhJHUoxJN6hBxB2z?=
 =?us-ascii?Q?aZQrvpiFF8b2reuk+xkX3sGx8HnQAB0BmjeoadMJ3ZBIH/Kwby1uGwIRYkvs?=
 =?us-ascii?Q?Po2rOApOsI5O19xgAP6Wc9XTJdh0tYhVK9Dwti0BH8ccznquzBegJwKmLDkx?=
 =?us-ascii?Q?IiEY33pivqmqSgpOOzMWs2CXK0dTodkiU4vvblJiZr6sr7KDx/5UaKH4cY3H?=
 =?us-ascii?Q?kdVuLHY/jWCNN5JlqSZKMAgsDuQg9+CghuSm14kwFSDNc3y5/QKk5WF8AFmv?=
 =?us-ascii?Q?32J6kNSUo7aGGlwu2icgOnksceBq5kV8ff30V4GvzDtMmv5zzPfe2EK2154b?=
 =?us-ascii?Q?QUjQJRupIJGoNpFchfuThzDahw6waLlWQMPEiG/u20HbfgTswqM5OWfYz6wc?=
 =?us-ascii?Q?vm1wAYsFpAi4wXNFmFSIm3buaIGhIwreMuw7xsAbbnttHF7NCsrC6b2ATuDR?=
 =?us-ascii?Q?YEzqc+V5z7xr6NFJBsjuv8IVQHINU0sxpiPpUKQ1xWb76jH3MeijGYXsmzGD?=
 =?us-ascii?Q?4k4aVX+HFyUSll7kO8OiPZNWlVlWJzpuabY87TW3d/GOv7HJgrvfQWbkVqk7?=
 =?us-ascii?Q?TwifswY52pmqd6cYwWhwkkYYjncT4BNU0uHeulW6CN00lEIZi8Wz9xNKSvj4?=
 =?us-ascii?Q?nANjd8C79vI+agUgpX0SBS8CeNQ4wAALIyB9FAbCOAfwlSpv8Neew9//VgRp?=
 =?us-ascii?Q?H+MeOOd85hb6LiMJpvP9Ju9vgpYNSsD+HHV6iLkPOWyeGCC4Nm7i69Uh58U9?=
 =?us-ascii?Q?1BkTtN6k1wKc+SzsKEV1p8/C3tJWRC/kPSJQcDjpuPvAayOgfLApvtmmhcUb?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d236e146-b1a4-460b-ce0d-08dd866f3979
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 16:10:42.2936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNRaRwSOFJtUoFgOELTXYiTziQlmZLreVC2c6g+x+tuk+e/1DeL09y2ub9Lvt6PoHq+gCSrEu7jkq0jSSbDeQtkwexwVsrU8Wet3QBwcO3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6195
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

On Wed, Apr 16, 2025 at 01:23:11PM -0400, Roger Melton wrote:
> Return burst mode according to the selected Rx/Tx burst
> function name.
> Update 25.07 release notes with this information.
> 
> Signed-off-by: Roger Melton <rmelton@cisco.com>
> ---

Generally looks good. Couple of nits/suggestions inline below. If you are
happy with the suggestions I can change them on apply for you [otherwise
please do a v4].

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  doc/guides/rel_notes/release_25_07.rst        |  3 +
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  4 ++
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  4 ++
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 70 +++++++++++++++++++
>  drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  4 ++
>  .../net/intel/ixgbe/ixgbe_vf_representor.c    |  4 +-
>  6 files changed, 87 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..30bc9622ee 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,9 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Updated Intel ixgbe driver.**
> +
> +  * Added support for rx_burst_mode_get and tx_burst_mode_get.
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> index 0fa4898aba..f1fd271a0a 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
> @@ -532,6 +532,8 @@ static const struct eth_dev_ops ixgbe_eth_dev_ops = {
>  	.rx_queue_release     = ixgbe_dev_rx_queue_release,
>  	.tx_queue_setup       = ixgbe_dev_tx_queue_setup,
>  	.tx_queue_release     = ixgbe_dev_tx_queue_release,
> +	.rx_burst_mode_get    = ixgbe_rx_burst_mode_get,
> +	.tx_burst_mode_get    = ixgbe_tx_burst_mode_get,
>  	.dev_led_on           = ixgbe_dev_led_on,
>  	.dev_led_off          = ixgbe_dev_led_off,
>  	.flow_ctrl_get        = ixgbe_flow_ctrl_get,
> @@ -605,6 +607,8 @@ static const struct eth_dev_ops ixgbevf_eth_dev_ops = {
>  	.tx_queue_release     = ixgbe_dev_tx_queue_release,
>  	.rx_queue_intr_enable = ixgbevf_dev_rx_queue_intr_enable,
>  	.rx_queue_intr_disable = ixgbevf_dev_rx_queue_intr_disable,
> +	.rx_burst_mode_get    = ixgbe_rx_burst_mode_get,
> +	.tx_burst_mode_get    = ixgbe_tx_burst_mode_get,
>  	.mac_addr_add         = ixgbevf_add_mac_addr,
>  	.mac_addr_remove      = ixgbevf_remove_mac_addr,
>  	.set_mc_addr_list     = ixgbe_dev_set_mc_addr_list,
> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> index 8ad841ea2c..7b1cfe0ea4 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
> @@ -523,6 +523,10 @@ struct ixgbe_vf_representor {
>  
>  int ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params);
>  int ixgbe_vf_representor_uninit(struct rte_eth_dev *ethdev);
> +uint16_t ixgbe_vf_representor_rx_burst(__rte_unused void *rx_queue,
> +	__rte_unused struct rte_mbuf **rx_pkts, __rte_unused uint16_t nb_pkts);
> +uint16_t ixgbe_vf_representor_tx_burst(__rte_unused void *tx_queue,
> +	__rte_unused struct rte_mbuf **tx_pkts, __rte_unused uint16_t nb_pkts);
>  

The __rte_unused should not be necessary in the header file definition, its
use in the C file is enough. Removing the unused attributes allows these
prototypes to all fit on one line, as they are exactly 100 characters.

>  #define IXGBE_DEV_FDIR_CONF(dev) \
>  	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> index 77773d56ef..209dbe6685 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
> @@ -2626,6 +2626,39 @@ static const struct ixgbe_txq_ops def_txq_ops = {
>  	.reset = ixgbe_reset_tx_queue,
>  };
>  
> +static const struct {
> +	eth_tx_burst_t pkt_burst;
> +	const char *info;
> +} ixgbe_tx_burst_info[] = {
> +	{	ixgbe_xmit_pkts, "Scalar"},
> +	{	ixgbe_xmit_pkts_simple, "Scalar simple"},
> +	{       ixgbe_vf_representor_tx_burst, "Scalar representor"},
> +#ifdef RTE_ARCH_X86
> +	{	ixgbe_xmit_pkts_vec, "Vector SSE"},
> +#elif defined(RTE_ARCH_ARM)
> +	{	ixgbe_xmit_pkts_vec, "Vector NEON"},
> +#endif
> +};
> +
> +int
> +ixgbe_tx_burst_mode_get(struct rte_eth_dev *dev,
> +				__rte_unused uint16_t queue_id,
> +				struct rte_eth_burst_mode *mode)
> +{
> +	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
> +	size_t i;
> +
> +	for (i = 0; i < RTE_DIM(ixgbe_tx_burst_info); i++) {
> +		if (pkt_burst == ixgbe_tx_burst_info[i].pkt_burst) {
> +			snprintf(mode->info, sizeof(mode->info), "%s",
> +				 ixgbe_tx_burst_info[i].info);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /* Takes an ethdev and a queue and sets up the tx function to be used based on
>   * the queue parameters. Used in tx_queue_setup by primary process and then
>   * in dev_init by secondary process when attaching to an existing ethdev.
> @@ -4939,6 +4972,43 @@ ixgbe_set_ivar(struct rte_eth_dev *dev, u8 entry, u8 vector, s8 type)
>  	}
>  }
>  
> +static const struct {
> +	eth_rx_burst_t pkt_burst;
> +	const char *info;
> +} ixgbe_rx_burst_info[] = {
> +	{	ixgbe_recv_pkts, "Scalar"},
> +	{	ixgbe_recv_pkts_bulk_alloc, "Scalar bulk allod"},

typo: s/allod/alloc/

> +	{	ixgbe_recv_pkts_lro_bulk_alloc, "Scalar LRO bulk alloc"},
> +	{	ixgbe_recv_pkts_lro_single_alloc, "Scalar LRO single alloc"},
> +	{       ixgbe_vf_representor_rx_burst, "Scalar representor"},
> +#ifdef RTE_ARCH_X86
> +	{	ixgbe_recv_pkts_vec, "Vector SSE"},
> +	{	ixgbe_recv_scattered_pkts_vec, "Vector SSE scattered"},
> +#elif defined(RTE_ARCH_ARM)
> +	{	ixgbe_recv_pkts_vec, "Vector NEON"},
> +	{	ixgbe_recv_scattered_pkts_vec, "Vector NEON scattered"},
> +#endif
> +};
> +
> +int
> +ixgbe_rx_burst_mode_get(struct rte_eth_dev *dev,
> +				__rte_unused uint16_t queue_id,
> +				struct rte_eth_burst_mode *mode)
> +{
> +	eth_tx_burst_t pkt_burst = dev->rx_pkt_burst;
> +	size_t i;
> +
> +	for (i = 0; i < RTE_DIM(ixgbe_rx_burst_info); i++) {
> +		if (pkt_burst == ixgbe_rx_burst_info[i].pkt_burst) {
> +			snprintf(mode->info, sizeof(mode->info), "%s",
> +				 ixgbe_rx_burst_info[i].info);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  void __rte_cold
>  ixgbe_set_rx_function(struct rte_eth_dev *dev)
>  {
> diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> index 54569c7ade..3487073d30 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> +++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
> @@ -204,6 +204,8 @@ struct ixgbe_txq_ops {
>   * in dev_init by secondary process when attaching to an existing ethdev.
>   */
>  void ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq);
> +int ixgbe_tx_burst_mode_get(struct rte_eth_dev *dev,
> +		__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
>  
>  /**
>   * Sets the rx_pkt_burst callback in the ixgbe rte_eth_dev instance.
> @@ -220,6 +222,8 @@ void ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq);
>   * @dev rte_eth_dev handle
>   */
>  void ixgbe_set_rx_function(struct rte_eth_dev *dev);
> +int ixgbe_rx_burst_mode_get(struct rte_eth_dev *dev,
> +		__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
>  

__rte_unused does not need to be used in these prototypes either. Sadly,
however, it does not lead to shortening of the prototype to a single line
in this case. :-(

>  int ixgbe_check_supported_loopback_mode(struct rte_eth_dev *dev);
>  uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
> diff --git a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
> index bd528ff346..901d80e406 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
> @@ -157,14 +157,14 @@ static const struct eth_dev_ops ixgbe_vf_representor_dev_ops = {
>  	.mac_addr_set		= ixgbe_vf_representor_mac_addr_set,
>  };
>  
> -static uint16_t
> +uint16_t
>  ixgbe_vf_representor_rx_burst(__rte_unused void *rx_queue,
>  	__rte_unused struct rte_mbuf **rx_pkts, __rte_unused uint16_t nb_pkts)
>  {
>  	return 0;
>  }
>  
> -static uint16_t
> +uint16_t
>  ixgbe_vf_representor_tx_burst(__rte_unused void *tx_queue,
>  	__rte_unused struct rte_mbuf **tx_pkts, __rte_unused uint16_t nb_pkts)
>  {
> -- 
> 2.35.6
> 
