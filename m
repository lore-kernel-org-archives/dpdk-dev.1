Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F6C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 13:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B56B40269;
	Fri, 14 Aug 2026 15:08:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 19F514013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 15:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786712923; x=1818248923;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Pa7RnD/QshA2ER/+3rsWzgmNOJeUI1SZ72hAtxnB/Ls=;
 b=Y6wmhPwinSvG27vdK0VW9ABvg66+oO2xVJ+iR2egRlC+/vC6oDqPFu0b
 aHsKnTAPyIbPLkDGNCnz4SIHsjmvX/wKEmm2EQF27NkXSbe0kkj7G8ZOg
 VTAG5LL5U2AESitAdQr5BgdFQrunPYxfM/J94QabnK0/gJ4aH/qyk70ZZ
 8BgX7ilmHYD/fQ5duiCB+UJYgCB+eZE8gPSAVsLCaq/COdEtZ1Txw7jF2
 wPc6FfTFp/f1zMnYBrEfw74ZLLhOPSfuZhOY42s2Bj7nsiJOpiIJ+C7jZ
 xSFxUUD5/GZmyVO/jOvATgfJd0r8IpGITy720vaYmEN2P7MntYTT5ygsm g==;
X-CSE-ConnectionGUID: 7Gmup9m8RmytmUh4FvMyuw==
X-CSE-MsgGUID: DRqSKRqyTVqCvmrd+8sUqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87420204"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="87420204"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 06:08:42 -0700
X-CSE-ConnectionGUID: xAuNHvZ7SUetJI6LCjoqqA==
X-CSE-MsgGUID: +itGLru+Qym2T+VGS7CB+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="294153449"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2026 06:08:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 06:08:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 14 Aug 2026 06:08:41 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.33)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 14 Aug 2026 06:08:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/BQ3ka1/pgfZzJHKUKSb0Xa3Itt/qM3PqxpN6Dw2GLvCIVSeZ1guUhFROjiI1iWHEo6OMzqbRxV1Jqwt7ckAEyHtF4n1nq20+2kSL/aPghA0mzL4TpT4t5LUX09KxYS2TSVSY3zVoEcEmCAYR5waGjZu/ptGjRhLpmxFogQLH8aPPAFmSgR2wYEMEoKHfmuxQ6KUFu+Sz4GoB6HP+ANEN80XaQNwLqY3HENVRusjQ30Dj0AQPaiTQMQwXZwhyOmVSuBej5EWXwAH3UEEFKBNO/k+W0Lat6ixpIyqA4o68HM+pTKmUvYJvUMqFGGrR0w8kfkFwZM4JUbSsz2XwkuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jc4yJXBL93RGbRk2PnSSU/NL+WRHLKqMZWAEOk/ye4=;
 b=kidSxA23qsLY9vG6dUlHDYHKfQy1L43a8UtXsQcIH3c6kGmOtvnvWLsmdhGFokMWOAnR7tCW5ceN6JAhq5CMgl01LsOwSjDJCsxTV47JBj6qoyyQCKsDRbbB+Hl2ux3pWTao306oh8Ja+7INyJOjlPbiKSQ/rlfvZhV/hON/PH4V1IT4ikTtwP3q9yB/6JNXNzoZwh+yzP8Eu4E43PYGvfzyTNNHa2pJN+VZe/lgaxB/zORqy5Zt+SiWa4X41T2uH78a6ty0ONLqEtXO22yxFqSXO2Wjef1bRssRJN4+DZwrtlOcK0BOHH97mfWBGs13oh3jETeA5WAjOF3TYofHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 13:08:35 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 13:08:35 +0000
Date: Fri, 14 Aug 2026 14:08:31 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] net/iavf: rename LLDP Tx devarg
Message-ID: <an8TT88vvHUfTjXM@bricha3-mobl1.ger.corp.intel.com>
References: <20260810140354.1869708-1-ciara.loftus@intel.com>
 <20260814123753.2041645-1-ciara.loftus@intel.com>
 <20260814123753.2041645-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260814123753.2041645-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|PH7PR11MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bb9ff0-37c0-4fd4-c853-08defa0525d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|4143699003|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MIiuOSxK4HVegBc0sOoDMygXSXG4oz77GcwjSDrftBSYjCfFmXzH7bYiHWqePL05hh9dJQJAPOOglUTTb1FLjcI2f+9qIQ1vYeNFjjQ9HQUKLSJKP2Akqn1hw8+qkagRI0/wl0gmCdGQBjXMkCwEJVC+VtfjZcXg3NKKiaQropmGRWfboG/5qIAg5ePAuIKo1XNqKhcKYs4LaZu/92ONkmOhoCOYiji5nUTZCG2ahAmw1CIZoZ9Dc0TesurSHLbPfaNsWmPCqwSZeL8NLtCBzNE4AF6ezbgIdY7T2DfWbTDhEdSppDQNOKwk57JhqZ+dQ8SDsiylXGZ5hL0/3MfbfAHOuLj3q8weu5N3vMPFbV3g9qUAcKh8ljJpCShh1TpPcegNMcnzAzi+4uCfNW4FmBDG6NVDSD5GaZq87AOsE0sIFEd0hZBE0yI6+yOKOWcr+Y23EyxhGEkfjCS71PdJkq95KLk1MlGILYDA5bna6atI8CDArW1knmymokO6c07Azppy5M80Amc7/VLUshaEfhWN6/Q8SpJONcsPiP/vlGdjzUAgvZDRTOpOlNiYZeTz3F8y2rGh+qmCPWc1JSLQ4Zk5iICFE07Lb7QaSKVDN8WhjQ1IyjljG5c/F9T09ciGXtUOc4NO6Ff2AAaK6ql7HsW9F8P1nDcxIgfJLctkmU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?diJ/FUyWES9UKchbYvFxbuojiZy740AXrccVmxRdc3KKZ+bKbAPvFNaJHAnd?=
 =?us-ascii?Q?9FVSpXMnsmhKPnrvQwLr/lYfdp+F3PHu00jb0HtVbyuDX+yhJDaaCsP1ArCC?=
 =?us-ascii?Q?Cbx3XpXA5gciMbDCGUNjcR1k6xlT395zGpG6ye8lajZ1QczWhYUrf8V3mUyj?=
 =?us-ascii?Q?CKMMRKrEKIwHJy1kZ4BhlHatyX/fgQ3ucK0IpCTMbGR0aGVoNMrPF56Mxcn7?=
 =?us-ascii?Q?L1tuf2uNwJytZcH8EV0oU1Bkp6YhFPatQ/vH2G0pyQuF8fpEtApv7jK7+29U?=
 =?us-ascii?Q?tK2ERVBGGZu2Rw0azj16O4KNTBm6p9fVQS1TrYQJpvvEne3a5QH2W3USw60D?=
 =?us-ascii?Q?8e8zfQL4Ml1dXdE2y+tCPszPlIw+laBgEGAgBT6TRfZtz9QcG4GucEze4C2/?=
 =?us-ascii?Q?OtXpc1vXzOXRSh+QyjRtlZgPp9Ybfe+wlO/tba5yLMqkrbHI+Z9awpB1nvrs?=
 =?us-ascii?Q?r1Mejr73qGhaez9oo05PnRKk/i0sFcetF5n/fFX1Jk69T2FVJllQsT3v8nGO?=
 =?us-ascii?Q?/3HcPZZepLsCVu4Wir7AMrVMDK8rzZEwKwXcMyBha5aVjPFK6C3TWtHaVFM8?=
 =?us-ascii?Q?0XFmnp9KTh2uQIS2wUKCTKZ69bDPJlzriGynKOloorr9kA4b/1YUZC1S3k8w?=
 =?us-ascii?Q?i2QDkOy/AGF3soCP1mgi1Y3BBqT2oRWWqZdy3P/lRKtI2idr7MfBpIuEsG/n?=
 =?us-ascii?Q?yXnBUA9zuWg3YejT/LCsVeDYH0Pcr+tx1aYf+DjAUJUW3ibUn1RlCp00Xt+I?=
 =?us-ascii?Q?k5kxIdFJsGpUF/n6HhusZDiCbu/aifzYp9W3GrqQ0avxLefciJLWWeJDFPUv?=
 =?us-ascii?Q?ib6DgP7f8/IS5+oVU4PlkX4B/MS5vyuKhpseZvR6LLYn8ocqAoyupm1vcaZ4?=
 =?us-ascii?Q?Q5RM2Bhy6uKdvQ2Zjax3cgZhp8tJm6J0f+LDkHbkr2uXhwmBUnP4/+6Q0qFo?=
 =?us-ascii?Q?yXI0jQuu4CUDxB9kpve1Bi/EF61PDgMKXHoNr+0/4OAUIFbWRG52CQOLM2EF?=
 =?us-ascii?Q?FiojOrZOQQETvQAafj72ka1cbZ2vKTnMagNfQ9lVLfsQ89LJOno1YFgmHTkA?=
 =?us-ascii?Q?WI6euhAEhIZU2nFOFH1T9+z/qgtKkLvqIv8TMdIkvJbZ+lrVA4f0Eqh3dtEs?=
 =?us-ascii?Q?JADbKAUagFhii9UskOBqr2p/ind+BIUwpc6Tthx10BYvJeNwwxIA/Scf3v1P?=
 =?us-ascii?Q?AuCD6D9YQisYKv5pzUYvCB8Wrk3VWa/LYQmZrI/mqHizkjxzAcLy3vjvWWsH?=
 =?us-ascii?Q?+Tem3blMbORwgiP7WY4RjhTNVJbtuzS9dFPVOb1opRDArRSJ6//NWp5ZaQHy?=
 =?us-ascii?Q?M8t+ea7eiFuXgnIvyt2hEBtnnOx4shme8FTj0SlrpzjfqYEFL4nO69GljKwm?=
 =?us-ascii?Q?k0iXlKSTS0jQ0tCFPeRMsaSAmUwyscidAL0pFKwDW1e5h2auTT7s46J/hS1J?=
 =?us-ascii?Q?HG1i+smzviBqeDv4GQOvlsgsnoH/nDze5WfRiMrxBQArZq6yp8iEK7FmYTDb?=
 =?us-ascii?Q?Zk1y5cnjY7p6Y+0zVeybHd++VEY1zs5Kq26KXyyTqgI/o2hovXouaIfaypW9?=
 =?us-ascii?Q?PRH58N/MLRGSdJ0YPbibMaxiC2KefstJlBRszz/bWlYQWu8tSizcvA+6U/41?=
 =?us-ascii?Q?WrQkOHQhdSY4jmJjNlIEhn3RjXk23GIUjuv5vTDfXrnFqJWoPXoJerK9BLwf?=
 =?us-ascii?Q?BW5icGeItHVTDdCE9JMpMN4LvxEakV7aqDVovrIZYb44Nal38KRdDu08xpwy?=
 =?us-ascii?Q?O9FFuv60Vn1QCzovEkoGJv/INMo6rsI=3D?=
X-Exchange-RoutingPolicyChecked: FYqi+qu8AJooV+yzUqxj2Y2FUWE8Kf/mA64cKI1WZZc7eksoXk+oWvjdMy6XrZupTav61USrT5WuasX4TRdIZc+yesJ+4VO6KcFD5B/Nr1PtAazR+zwcfa+SjgBkKGdsK7xyDy13iVhXXO1NNsYZ8e10ispKTQGXsnYQ8EAivswW2WaQvsA5DQN7QGo/hu07Rn41AEovkQpu+RZiSfaT3KyrZ5K6K8RoJGfCvF+JtZwkE6D4nkp9E7l6nhQTlbjx0mI9oArba+klzJZWdX9t28jcg2zD9vOgqf18vwNsPSLC83mwDsNJAFgq7KUAm0MIFCKEIVtRmP2Q7vfEx+DQ7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bb9ff0-37c0-4fd4-c853-08defa0525d3
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 13:08:35.2173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tln6ZFq6svJ3LkMctlWsYKa1nVbD3UgpV6SfxDpIyWVlRUihIyuJZCXulndD3hEedHe28bcWbGhU6hmmquBJzjIZ3jFtso3cr5WZYC0G2Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
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

On Fri, Aug 14, 2026 at 12:37:53PM +0000, Ciara Loftus wrote:
> Now that the dynamic mbuf field method has been removed, packet type is
> the only mechanism used to detect LLDP packets on the transmit path.
> Using the word 'ptype' in the 'enable_ptype_lldp' devarg is therefore
> unnecessary and an implementation detail that no longer needs to be
> exposed to users.
> 
> Rename the devarg to 'enable_lldp'. The old 'enable_ptype_lldp' name is
> rejected with an error directing the user to the new name. This is
> considered safe because the old devarg name only featured in one
> release.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
> * Hard fail instead of warning when old devarg is used
> ---
>  doc/guides/nics/intel_vf.rst           |  9 +++++++--
>  doc/guides/rel_notes/release_26_11.rst |  7 ++++++-
>  drivers/net/intel/iavf/iavf.h          |  2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c   | 17 +++++++++++++----
>  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
