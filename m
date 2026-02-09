Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC1E81BA1
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5662C402B0;
	Mon,  9 Feb 2026 12:41:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E49744027F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:41:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770637289; x=1802173289;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WgPHjrXNOUtXU+zguTFl8122VQWljI6VN1deLUnhdnE=;
 b=DWvHFqBxDedO4FotohufoCWf1X/M8sGcynthhRX50sNkIqtT/dt/t46K
 5lbQ1pYL94uBZp5KObXUQrwu/KftvNwY66kYR9EinsYvGBRfDgQGd8Xo3
 mZqzQLgJv8n70+mCR+bK6m/7Zc2UiZ09rjTzAmFMhiS0uohGyhSso7arI
 iGTvMu/E3aBTnhcz7xZ1Uj+PHPQcMa72hSdu5XPwQ1ek/P3swkX/BtwaU
 SJqyicsRxtTv2jAWQ40TzxiykGciPoDfRc7a17+EQRPcB/rexQhQ/Il8x
 XV5uGGxUE8F5wGDlHa2LihTd17QixDBMHZeGZ4tI973KLi5t3tZ/TJDKl g==;
X-CSE-ConnectionGUID: rT2vQz5sQYiYWeCG1YjJNQ==
X-CSE-MsgGUID: ifCSbuqUSP+UF9f2xfAsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71639048"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71639048"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:41:28 -0800
X-CSE-ConnectionGUID: ENNvPJKfRcqxxYkFI9NOzA==
X-CSE-MsgGUID: hxH18rVaTfuHmZfV2Jrylg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211625078"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:41:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:41:27 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 03:41:27 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 03:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP8S3Y7VkvPB3RRy2GqrHkcJ7Tw+8zP6+HL+9k2WNsT74WR594nyfuE6GAhfpl778ox6LrrJo/XQv6+qBnhIQ2UT2FAOi+w8t3Z55OnZOIGCLo0JGgcQ/8i6g5+7AFcPLd3TrrxCkQ9GpHBzQ8by14+raG5o+BfbjhOkILEA2GRpnwrdAKNAlWalhkcj3urf6bDawrOog7ROi3PbLFFJGZ1ljX4wyAByVBT8n0pKyiEJJlDDXHFMPScZXDmOoHZP8eTwyIUZkood5Q6visHSIGrw7xy+RPvImjoElLnWmOAJgHaJ0rLYBy+4UV6fDbz1ZeoJ3MBZG4j+mXv1pJEt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq5R0EKt9nbo83d9giONJtAal9lY0ydwDx1EMjoo90g=;
 b=NbSt2hn/+7+LWjFty9fAeYciQJPXle/cnE+IrZAixAS2YUGhhlz9lBbUuwyqwzMdCNJvib879iFRSJ5DhV3uKeFcBEULU7BvX7dqml3kUeFt3F7c4yswSvBmJpTQmclWs3MwbOxbBtR/4RnBg0yYi9qQDRBtcKsJ/CuK2ilKN0RofxAMDV9Wv8hb99BvdYigHvZSC/YoxOvwCITSMVoUs1qTnXVztVgiNrtmK9KsCCeJ6N0iIzUMHImGoSm8SvSZ4tkY4cVKtfWscPAfyhziBlwJQu4DbMARMmutH0WNbvZutB7KXG01mSvq6Gy0u1YtnEh6DUSYEPEGBVNIGjq57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 11:41:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 11:41:25 +0000
Date: Mon, 9 Feb 2026 11:41:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3 11/36] net/intel: create common checksum Tx offload
 function
Message-ID: <aYnH4HNXOpVGZUoW@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-12-bruce.richardson@intel.com>
 <DM3PPF7D18F34A1D6B3363472AEEF97DA0D8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1D6B3363472AEEF97DA0D8E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0339.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: e1081bf7-4b03-4dba-7256-08de67d0278f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o535O6mm/CUUiw5czpYmcm3N/UkTQzoKTdwr7Wv6Jfu7DQh5eWChTt32Yh/r?=
 =?us-ascii?Q?M6nnh5/RFsfjxDPbegY4YVPZNsDFCuSqxs4fRiRQ3tFxaMx6MBUIakp7KZAd?=
 =?us-ascii?Q?byHMGGwd40qfnx9NV32kgl4qXhQCzCNet7fDOD/HpVsPNGWuMMmJOhx57t+e?=
 =?us-ascii?Q?nEs8ShgzXKu8O+67xhDoAcSqA/pN2X70zJlxQL7Bx8LmM9rBIMzwDuGJgySt?=
 =?us-ascii?Q?dRRhHwidiR+ZCZL5xG0d1UeXvzHcBA+yVUAAvlNENaG/KcbNgiIYmpxuSMCI?=
 =?us-ascii?Q?EP1zAC/ynKPVkJcTdheLKokpeTmBgdFOmEkLRpOH7BfdKEJPS/PQdiPWp+4Z?=
 =?us-ascii?Q?VTLW7mSeGI4miMQwtekoAgweD2RoMSkxAxCUK8+x2dptyT6LrEkDNzmiGEFf?=
 =?us-ascii?Q?gQkpIuNveXR+PnMedsMPSFjoXPpVdlYCw4khvy8YXJ5w+6RS9qZzdmDDmcWn?=
 =?us-ascii?Q?wXBDGwKKZF99C/izJGMIb7a2zNTgEZjRLRSzxfHFFXSXXwTlrNRCOzZgQiTK?=
 =?us-ascii?Q?k2Hf4Xj1sLoPYBG6QT8eZG68e2UELk5eZJSRaVW9nc+Bzgdsim1DjBuzBhhU?=
 =?us-ascii?Q?PPcBgQeInDxzBI3nhoeDUcVXWK9w7q0lwlX+bqkKE3HbCo+6nxjeQhRJRQF+?=
 =?us-ascii?Q?kBW147JpxCc86ChCAFqJogKNfHEIW773jSMmHlXb3QEM2ABpckvJDT0KCnrd?=
 =?us-ascii?Q?/cT1uo8Ez02pUeq1xalff5zOuUPcwI4LxgFyVc9LVCOt1lmAPCMvS0oiyN57?=
 =?us-ascii?Q?ph3T0YaRvcYm1T13o2DHm50tt6iyxFEeYCObgHfASCl7aaA0HMSyI3YSztWK?=
 =?us-ascii?Q?65flFjf454Xzgmz2Lgpx34rHfIypfbO8LsrV0oDd78eCVWvPhsifXupAHzMK?=
 =?us-ascii?Q?H+q1C2L37FezkWCaFTacyA+jPFmqhGQkF6ie23iAQlRMPbG7o6zYT41vzX0Q?=
 =?us-ascii?Q?UqzSiBuzM4SIIjrdH3rOzlU1I8iZQyidjW2MsCMj/5pNwkfJDjVgZE4pJAh+?=
 =?us-ascii?Q?vBtV8v/FTB69Mv1i0WL0XPwRo4zrmylAPEcjTppebVSdeCta+f+EMbtvt3+0?=
 =?us-ascii?Q?zpTXgPpFr+nYwlix6ZyvyKGeKblzlOQVmqGi5nEbjGy/RvJ5+NlNqb+5zmJJ?=
 =?us-ascii?Q?OYvMovXdq7aTEgGWT9vnzsdKlYgrMjKA17TtCcwsINEj3a9B7yp42xQmOrMM?=
 =?us-ascii?Q?y77fiyvZpgEgiYbnRD0au/gy24/51oQ/D5mynmDuLqcZEeosb3tFltIZu/OM?=
 =?us-ascii?Q?QkhwzanaHD5Tx1vRGT3fM/JGepIABCvy/G2ZmT5oUiJQVax1Gz4A8u97GXtN?=
 =?us-ascii?Q?0VJhtZ/0+o5sJeIjypgh/wW58vJTP4ccNdm7tP3+y4w8OPQ0e1XD6sAdmhUx?=
 =?us-ascii?Q?YEs2a6uDTtBcEJ8RHuBL+B7QN1VPvjPG3qB603y4YcW7sIDvu2QBcx98CK0L?=
 =?us-ascii?Q?iZaEzV1S9IHmwCDfpeqxUJ5AXthPXxTgKo+uFZdOE3x86etMEBDrgT1XuQ/5?=
 =?us-ascii?Q?r00ee5U1WAsEOXKyrxwXVRgt6EAUAkN3NBSkkIl7wn9KCwgAvwni0aTNypRa?=
 =?us-ascii?Q?4vm6m0a4TEQmsyc6/P0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6fsxxbDAeJNDBvC5BM6XJY35SG+ThIz5JGcc3rGfyE+0ZbBYpieCzUhqTb5?=
 =?us-ascii?Q?og/x3Ukbe3Thplx5mUrFVpSS2xHV3jF78Xhdc92kgj1xHqfSAqlZ9b38qxOD?=
 =?us-ascii?Q?xHjhT9wU5JS01SNLWvOh0CuUnP6ie0e7lTx93mXF0kjBLIj1iQMb5wimC4Tk?=
 =?us-ascii?Q?bI/aSZ8/D2104p1bgQVFcLkJG+S78ix+kg8EvH8IwdI8767OlYBW3ri8l5jk?=
 =?us-ascii?Q?iwXdr/KXPXUl9OtaI3W5QAH/5ZfuEbkE+PblA3ZFYEpJs2NNsLe6DXEq53cT?=
 =?us-ascii?Q?RYmtY/XNucPxMICN0dW217XusqRh5hY2mKywJnY9TeStBbwfu6qEQLL03eoF?=
 =?us-ascii?Q?w4d7sw0lxwbolNaGnqbqj95QFrWt0DR5GGozIVoqj5e0ngCt6BCYigVd/g0O?=
 =?us-ascii?Q?godBNyoAhFqbUrJmQy05pXqrEwjiFq1MwIvn8TGTHmVPD7tgPOgmPJXECcpW?=
 =?us-ascii?Q?18VR6aQmFr6rTkqB8/UtgYwBvAw7cr3ix2mmmAVAVI+zQ+CY+Kfg+G1Yimus?=
 =?us-ascii?Q?DQEM9umsOQq04mr70Mk3j8FPQQSWLbHZqob9enuTGMoWSBJT829eWbzDrZHk?=
 =?us-ascii?Q?I1x8WLTEbZgzB5nDPhk1W5PeGzhMX4gplaNzVUBbAngvLkZkqm1INHCQ/12j?=
 =?us-ascii?Q?2FYct0gdxuZ2r0nFUCJZjztVAmWZcDPUv+MTED+b1MaKulyxs4Ww+XPjcY0U?=
 =?us-ascii?Q?d2l35+zNF7JCV31oxj4crN9f56oK45KRWqU6qN3YEWPXA8qcA/27S6MU7djc?=
 =?us-ascii?Q?IzgidZXZjzzbkcnPAyhu2gYKct6WZuJUlRtvRKPBVTFnh45i6goRoNc06OWV?=
 =?us-ascii?Q?H8Sgk+x0FpN8g+c5Soz2qnCTHy3rIp0y1QoI0hd+Dd7TNa6KFItIkTJ8Fyg+?=
 =?us-ascii?Q?FrtpUChIj4p9ZSJEX6Hz+N21InnyoCKkmr/FQRs8VGs3ITvamp5rq3hj+ghK?=
 =?us-ascii?Q?bDfIXkEd6fvFb+f/MXearqWAv1VYLoeixOIeamcQc/FeNiZfFWbHd2h666Zi?=
 =?us-ascii?Q?JezGKzTFgZaaRajcqxkyIOyJpNNQJ494wjy3jbH6esY/vHtKpmI8MzLp0qK5?=
 =?us-ascii?Q?yxfGOIbme89erkF5fJNuxkPGrPpL4oK6vFyXJXonGWQhwAWHHGoGDEqiFenS?=
 =?us-ascii?Q?0g1S73YlzU8rNDL0Ud93fXbWSkWqxYjngLgjzwtwecr5FY+yPKaaMPrU5Mn8?=
 =?us-ascii?Q?vc7c7aCv2IMnJTHo/iDfXMRVXX5puRu7AVv9HKVFqaCKDhOjuyq0eSIcM8hu?=
 =?us-ascii?Q?9l2sIL0o8I9j3w8oRVu8K6iEoPZBgLPTcK2vQbEUE0kMUXZWYErCSBka+Q1c?=
 =?us-ascii?Q?E7dnWovHLQbwriz+pmLfEhuN/ZcCjJsy30giXNxcNv0IgYTEnaeqP4a2g/VB?=
 =?us-ascii?Q?mPhhdXwyRzjrahJF6tz8DrfYG5Yf/rNhSKD0ko2jJTsPvEFhUXa+CPju2hfA?=
 =?us-ascii?Q?4UTbsAbo/ilCT/B8SdkdPOyIv0ABRsaJTg/ZZfFPmNH+U+BNvCPX568qH7n5?=
 =?us-ascii?Q?M/PyFmqrABa/JyiD1scqjZUPvJta3IPelrWVlue+RmMlgHTFUzSJs5a2NARN?=
 =?us-ascii?Q?qzeD92Tb/vSCgINlF1cI519jJ0GMu5BWDbJlQOquZWDyQTlQN5PEVHZoBcoI?=
 =?us-ascii?Q?kw1h9DZl83NDxR9t2huCQwB8XUq+gfSKmSvMlQLnpkrq/khr5uWWnBjiDrDx?=
 =?us-ascii?Q?m5GWN1nQIN22K5qZzEpsE+vXZs1nEVMw2qvk+y1Q37v5h1HzDckw+LIsB0ao?=
 =?us-ascii?Q?Y6IeVxzQzwSg4tiiyVL0L1oSR6+vcLo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1081bf7-4b03-4dba-7256-08de67d0278f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 11:41:24.9765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDbKpVgG/IPfJIhaT+YBrh8vjucdgoA2NlSSw+/AT0cpo7kCN+2itG0zEZnhRAOi2+l1BZ/yh1BHgZDcGMK3u07OYCT1yllGnB87v4VYgPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
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

On Fri, Feb 06, 2026 at 11:37:07AM +0000, Loftus, Ciara wrote:
> > Subject: [PATCH v3 11/36] net/intel: create common checksum Tx offload
> > function
> > 
> > Since i40e and ice have the same checksum offload logic, merge their
> > functions into one. Future rework should enable this to be used by more
> > drivers also.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/common/tx_scalar_fns.h | 58
> > +++++++++++++++++++++++
> >  drivers/net/intel/i40e/i40e_rxtx.c       | 52 +-------------------
> >  drivers/net/intel/ice/ice_rxtx.c         | 60 +-----------------------
> >  3 files changed, 60 insertions(+), 110 deletions(-)
> > 
> 
> <snip> 
> 
> > -
> >  /* Construct the tx flags */
> >  static inline uint64_t
> >  i40e_build_ctob(uint32_t td_cmd,
> > @@ -1167,7 +1117,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf
> > **tx_pkts, uint16_t nb_pkts)
> > 
> >  		/* Enable checksum offloading */
> >  		if (ol_flags & CI_TX_CKSUM_OFFLOAD_MASK)
> > -			i40e_txd_enable_checksum(ol_flags, &td_cmd,
> > +			ci_txd_enable_checksum(ol_flags, &td_cmd,
> >  						 &td_offset, tx_offload);
> 
> Now that it uses the common function which handles
> RTE_MBUF_F_TX_UDP_SEG this means the scalar path now supports the
> offload RTE_ETH_TX_OFFLOAD_UDP_TSO so I think it should be added to
> the I40E_TX_SCALAR_OFFLOADS. It seems to be missing from the device
> capabilities too. Same for ice.
> 
Ack.
