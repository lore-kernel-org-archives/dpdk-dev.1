Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCFE606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JapyelqI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D1040270;
	Tue, 20 Oct 2026 11:33:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 98E8B40144;
 Tue, 20 Oct 2026 11:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792488832; x=1824024832;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=skG4iuwMCPP7tWScXnVuNjATV5kbtvDcm4N4utYs2zQ=;
 b=JapyelqIYCGLNQp2pC5DIsSL2+FZT7lqg4vL9a2OdzJsncMB3YaNjKHS
 o937iyW7E9OWocoy506yp8m208l+G6LiuObDpmge1AGwXnTirs1AwWxor
 uDGDIpqdbkopwpt4aO2EIx1Fqn7kIdgLVWIPJkpzxYyWxk3Mz7IUsfixn
 wS+0O4pq21p6FG+e30QpGBqMifYk6YAr0dSqiPWcpWdvuMsvMt3mtGjNH
 mM9l7deFPAmmeAU4d3viyuouvvrigwqc5WrHnuSw/opYYo9v70Digrtrr
 IYFMapJnp25m6eZ82ylTF/VizeM7GF7VfjyTfoxG/UiJI3OvRf7B/X4c2 Q==;
X-CSE-ConnectionGUID: GFGsQRlPQvSR2BzgXATXZg==
X-CSE-MsgGUID: KjkwMx92RhKwHK9uo2hXVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1287209"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1287209"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:33:51 -0700
X-CSE-ConnectionGUID: 3+FH5Kw8QLOpPkEbJjLl/g==
X-CSE-MsgGUID: l5IwDx4FRNOVzW18uaQZHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2721806"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:33:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:33:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 02:33:50 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 02:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKyvKGYEmhoFqY5+tCgJhroj19iApK2/NU3hpJ8LbC0JicXfgOSYMHfwcjctpowTwDQkFxbsZjtNruJOPXLWCtIaGMVEQoUlbvDmG28kKUaPyB87EHpm99DF0SJqN5JFn5yrQnCI6fIYuC4RMdxtKncagvDuP7ew/jC5Xq9cO+KdJ/nNY6dfhM6cEggV70QL6p/MbPjsxDEX/cX/en2zifRWR/EcCsmNg5BDmPETmyYNqXrwpY3PSz8HIsstIRoI7QZh8cnH8xoDAyUM8H/WOlJtNkGLd5h+AHcGo7TiZZPWbTzGypl7a0WS99VRy5wOxaMPFfPpxYg91YLrH9O7YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14llNozN58cAA43zCmwM/phltqbOTyLvexfUUVkpS6M=;
 b=kq11Er8NTtCSPhfKkMvz5NewJquFXwP4z/nziEhlSbyE4SZ8hlZqfdQpLS5e9McBARKK03qCb/EIhgAoqbpx9ehgXHt/b9CM8s6B5OpjYAvI15Nu2P1X366AClHd19c72NFMrb6XkP1TZqljU8OFB44P6Mv0zHB3a3dBLcO5jRrdPgo7KhY8/34LkdK34dtmEQ7v4yU1Z566UZb0t3jSIm4fRekQzmaBnlRowG1FxlNq6JFiiCD6hg6EO81b2PntC+90HI+KaGyHnDbxVqT5NvOvkMidJCEUkJYsLdzwPkdjPURVkpovMHSf5F75iDYpTa2IEcp3zYYe1govoUVHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ5PPFF8B526086.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::862) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:33:48 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 09:33:47 +0000
Date: Tue, 20 Oct 2026 10:33:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <anatoly.burakov@intel.com>, <marek.kasiewicz@intel.com>, <stable@dpdk.org>,
 Qi Zhang <qi.z.zhang@intel.com>, Wenjun Wu <wenjun1.wu@intel.com>, Ting Xu
 <ting.xu@intel.com>
Subject: Re: [PATCH 2/3] net/iavf: fix bandwidth config of unshaped queues
Message-ID: <atc1dgrGiIpn3APl@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <20261014122419.631288-3-dawid.wesierski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014122419.631288-3-dawid.wesierski@intel.com>
X-ClientProxiedBy: DUZP191CA0057.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::8) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ5PPFF8B526086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5488dfa0-8d82-427d-9d72-08df2e8d3e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261009223027099003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: GcbyTRbCDRe003clsK8NeIghIPPy7S3gak5QfV+T5gZegpSF3dU0SVcOUf4w0x0GiZXFLvLe85RV97jdqlhXLCp+Uap9xkxFzuqRKIwD9wKsF3RD9vZgX7DvuspiHruaH8Eu9wSuZpLenNPm+0bbhGkkviY6nhuywr3LoI194SMc541mMh2709eCSbM9ato6FY943EFr6MlCOtVg6PPtdD4NO2JstO/8Rqo4uqblIREHpAO90acLtb2p3GBi4nZU9bp4WBIT3XGKK+kZyH6Cze7jhsDOd9V8J/ibTjXMwnORs5o5WTbdvsUhVLSbHc9AqoT8JRch2J23U60OY0ihUkyr+uETztqRdCXjcefI9tyJuInCpIQXgzZ429IIDwUfdv7bWHJxc+xIDQzBUiU1se4Vz8ONIg3e+d7bR0+Dn/Ygh5M1BI/FXtDl9StdnrK0F45k44syq+5hX2thxnJuvbhiJJ6z6NO4jfcs6g/jkBGl30ie7kh2DjJ8SMEpPIC7Ru5sn5UrtehXX7qT6YnXPZvVO4qscG/wO8+UUH3LSf3kNipIVjUX1WrlJqU4wmHrAKaeA7NdOP9NZLbvn2MeMWFlRAE2yprYn1ISht+OS7axq3y0CfPjCBd+p+HvG0eJG4jH5xx0hc9h3OJdgc8p3152oM4IBMyWtypN6BuAat8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WgYwvGskqs1YFroqoLq2ouOeWlUTyxtsSmfSBgCmi8uwDcl+Gu7dJNNV1vta?=
 =?us-ascii?Q?oH89/Sj79egWGlrbDC2YnrDGW32yh1cZb126Aow6LIjbH7rt7ntxn3sdeIYa?=
 =?us-ascii?Q?1Fgp1aTER9rUoi6lm2B0WB2p9QnS1M/t7hIffqt0YgL+1Ju1EWsQkuTxci+f?=
 =?us-ascii?Q?GqJTbbRhnMa3X23LP3fArCs1xndrHUA9UOeIPxUNtMXOwUef1NIOjdBMav6h?=
 =?us-ascii?Q?GZ26NkIX4H0wQ7u1dA5y+msU/cRNXc5AjfrPuMXY/ctbXv/0kr1TaJG/aWfi?=
 =?us-ascii?Q?zf1XGscebnTNSbsPSWQ0GiJ0Jg/F7mNGIsnr9Xmw34xQZqxmVViVFMye+aR7?=
 =?us-ascii?Q?2N+/uTShkLSgTX8lvxiMTFLIzkdoNfPuZB8fHRKCOlWsMBK7ktyPmxNRFTcJ?=
 =?us-ascii?Q?38qU/hJw0sREbgkdy1E1uugeaO7qwv7Ra6hpTvS//NquRNDF0it8mM+6HMcf?=
 =?us-ascii?Q?GkS21gc71ShCsG0dC4dkuXzdwSBpbBhABEz3rm5i8G9kQMU0PKhqOn9hevNY?=
 =?us-ascii?Q?BX6B3BXdB1O1HXeYH1otiPDDl1AzqM3RsPiHJdOVDv0odMrytPNv+f0cQhUw?=
 =?us-ascii?Q?+rSYy4CS0l1cyYeGfmziJpDR/hCnAU4Vg8XBSzexGfDi53C7u74CzwcJ7xZP?=
 =?us-ascii?Q?bGGlExSaajDhjJ+tHTs7RgUF81lPqU5H0NZ/MFxjW7BELdMxEPz46QfJ3Ott?=
 =?us-ascii?Q?bwQ/aTmaowv3ALy4+1d7utcGh845Ilggd0x8ztLooOr6dHdgPGCtRY9ABMR/?=
 =?us-ascii?Q?baAvg3i76cQ/CO+u9HDA//IzW9mUcLu6+PtxEHGLHCX1Q+umC/BHQwooTx8L?=
 =?us-ascii?Q?FyoQglOIBqE0ad1cAY4BGm/td7oJ9DyBgx//Qblxn7g3fZSWutp+Ck9Y5fKR?=
 =?us-ascii?Q?QNm+ukN2T4zrDPEhmFNXfSpHaB61TswtTWJvJ4JT02lNPJbGWYvqVBFEp2LX?=
 =?us-ascii?Q?K2FYOm51FL/ql0b+bTNGIFMOvxOND/kEtWvyoioI6mytqNjK72sOZJV0Nkmx?=
 =?us-ascii?Q?XRH6Uiuf0P6foguAnzKucYfuElxxuYa5s1y8SxnIWvWCh5XbQ8KZY9wfEijk?=
 =?us-ascii?Q?1fFD4iVhdkpqaeWAv9o1izPQaCRFkRfLwzmwGJYh6vZtzSz7cGwblEylpEdi?=
 =?us-ascii?Q?gjz98XhP3rqjNJpNZ3hE7voQyNDLFItc4FLeyMGgrug2KkdzWD8ReCzz76rA?=
 =?us-ascii?Q?5LS/z1oNFaYizeO86Sh8GsKHEwwTqvNdywtArQpp+ule1ymEKZ6tWKNAXRcW?=
 =?us-ascii?Q?VH+N4ceRKeUhY+sTDCE9U+vWnVrkg/qEN6tepybKylLpgoELm1O9msEn/WvP?=
 =?us-ascii?Q?kQFfUcWPLo+RMu/8evG/Di5fu81I/DXaJ55s6hophYsjwRfBOyDKXQpR5N+s?=
 =?us-ascii?Q?Z3fZPUAQewFl+Wv9aR9qmo3PwkvFkQTiZh+O1UMe86koitBpeI9C610WHOvn?=
 =?us-ascii?Q?xhOkh9XE+t4/c+szNMeMbuQH46lVPLbA8cZFumKH3jSpxwSJzVpHgsVKwSXh?=
 =?us-ascii?Q?sJMxNnl7BTtRt+76GtTFJCuDn2h9+NC68HHTnSEno4dRTqedQCX2AnzmPX1S?=
 =?us-ascii?Q?lDjGA6TOtYhTlY4c0y9QVocEJ789UXivCfo99BSUhOi2d6D/BUfND7JDbwC+?=
 =?us-ascii?Q?qQCck7UDLMGPZQaTZEvfMSmcdgxMadV4F1bF3gWNLaFYFLMr7GnpxGenmbLd?=
 =?us-ascii?Q?OlUa6peTVGtLwMkIN791NQie8lrxK3jrASA2g7Ld6kHj3ur9ntzCGEc705MM?=
 =?us-ascii?Q?VNZnxOMOmbKuSHJdt26+WGzlaVaDBIo=3D?=
X-Exchange-RoutingPolicyChecked: iJliIjRnYTIQUo83uB/rwayAbdQtempe4adsPSNNWurYZRqD79Urt1SY/3jHeu6Er9sG4t94yPnvceeg+uilUesSRHATY/OxdHn9+NT8oqfVYurR9JsPamIR9RlVrbaNcftnLDwWRniCEZAPXGTSc1FWP+Z+wFaHtlElrwhVUycxy1Sp/BwjlmpxmmiHhrTWOfymgc0tru7bNt6iD+731x3fZ4fdJ/DdiqeTu+dHneqFjVbKSeuNrqEX8W3WSOVnNF4RFltGAPR7tztXM4xQpujtlY15g6cN5KtdJS1YQ3ial3ShNOXdNBiJEFGZ/c9/qVYIB4PZergRBczM1/wnaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5488dfa0-8d82-427d-9d72-08df2e8d3e05
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:33:47.8307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYfNF0a8qVb111l/L5gGsND+JZwfMlW8cyHR7j3Bg+TSvZvRwsNACF+PhCBWT4owRXsxs+yjsGJEu8emqZ3qiheEjMFNiX0U+QcbNeEUUyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF8B526086
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 14, 2026 at 12:24:17PM +0000, Dawid Wesierski wrote:
> iavf_hierarchy_commit() sends one virtchnl_queue_bw entry for each queue
> node, but it sets queue_id and tc only for a node that has a shaper
> profile. The entry of a node without a profile keeps queue_id 0 and
> tc 0. The PF then applies the default bandwidth to queue 0 once for
> each such entry, and the queue that the node describes keeps its old
> rate limit.
> 
> The ice PF keeps the queue rate limits of a VF and applies them again
> at each queue enable, also for a later process on the same VF. Thus an
> application cannot remove the rate limits of an earlier process with a
> commit of queue nodes without shaper profiles.
> 
> Set queue_id and tc for each queue node. A node without a shaper
> profile now gives the default bandwidth to its own queue.
> 
> Fixes: 5779a8894d15 ("net/iavf: support queue rate limit configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_tm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I find the commit log of this patch a bit confusing to read and understand.
I asked AI to try and make things clearer and it suggests this as a
rewording, which I personally find clearer. WDYT?

  When configuring queue bandwidth via virtchnl in iavf_hierarchy_commit(),
  an entry in the bandwidth configuration array is allocated for each queue
  node. However, the driver only populated queue_id and tc for nodes that
  had an active shaper profile.
  
  Because the configuration buffer is zero-initialized with calloc(), any
  unshaped queue node left its entry with queue_id 0, tc 0, and zero rate
  limits. Consequently, the PF interpreted each unshaped queue entry as a
  request to reset queue 0 to default bandwidth, leaving the actual target
  queue untouched on the PF. Any previously configured rate limit on that
  queue remained active, even across subsequent queue enables or process
  restarts.
  
  Fix this by setting queue_id and tc for every queue node, ensuring
  unshaped queues properly send zeroed shaper rates for their own queue ID
  so the PF restores their default bandwidth.
  


> diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
> index 603da09bb5..57075ee5b8 100644
> --- a/drivers/net/intel/iavf/iavf_tm.c
> +++ b/drivers/net/intel/iavf/iavf_tm.c
> @@ -867,15 +867,15 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
>  		}
>  		q_tc_mapping->tc[tm_node->tc].req.queue_count++;
>  
> +		q_bw->cfg[node_committed].queue_id = tm_node->id;
> +		q_bw->cfg[node_committed].tc = tm_node->tc;
>  		if (tm_node->shaper_profile) {
> -			q_bw->cfg[node_committed].queue_id = tm_node->id;
>  			q_bw->cfg[node_committed].shaper.peak =
>  			tm_node->shaper_profile->profile.peak.rate /
>  			1000 * IAVF_BITS_PER_BYTE;
>  			q_bw->cfg[node_committed].shaper.committed =
>  			tm_node->shaper_profile->profile.committed.rate /
>  			1000 * IAVF_BITS_PER_BYTE;
> -			q_bw->cfg[node_committed].tc = tm_node->tc;
>  		}
>  
>  		node_committed++;
> -- 
> 2.43.0
> 
