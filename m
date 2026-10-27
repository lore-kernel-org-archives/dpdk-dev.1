Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D8606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJz+zrxN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99B9840151;
	Tue, 27 Oct 2026 18:17:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTPS id BD7FC400D7;
 Tue, 27 Oct 2026 18:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793121458; x=1824657458;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ey+19adFgTPN8yF6t9ks4egFyDL/FpzllMepUcI4qa0=;
 b=RJz+zrxNMUppCqZc+JPrq38xrvUivTxMj35oAfoJfUekmTThtL3rSQG/
 XexsxFc5q6ShF0kkxtsiaswpJLSpqeD94Nld+FIBd8TF8T8tLeKJOHMfp
 DzHjc5jmY5SkcUXWiA2CeVPr3xgdsD65rEnOO82MhR9xcd11LndBHSCFu
 jXGJ3v+vi1kSUDv2pA2hASOwq0ItkGJRbNIV7zTC5gx9s0RsW99czt2QK
 YEagU7jy/zPuycfH7pbEokozPnfwnZ0lx24xQwyTgPuudJqJig5TJ9Kb/
 bgpk590f9kea1E//ghtNOvRT2E6j+GTmSqDAuy6wqmJBznFm1ezRV7vH1 w==;
X-CSE-ConnectionGUID: fJg6nAhAQK6dgESmdyjCNg==
X-CSE-MsgGUID: u7r5D2wgT5mj25GUWs+bLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1728861"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1728861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:17:36 -0700
X-CSE-ConnectionGUID: 0+RuRb/rQ5KhQvqEvCX0dw==
X-CSE-MsgGUID: uZP6LmjsRxW8Yz5HkVnZ7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4679790"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:17:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:17:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 10:17:35 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 10:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDPgUbgDsKUlCqq10MATmwS8iaj4F76HARODEo81vxaTIcuDusd9HzcWmSkhCIAC2BU+CFK1lCdOPw4A2l1pWsOI/zn11jRdyf1b08hjTxRG9tPFpQdBsKTw56W7vv+GSA+3l1RWS/WXJxL1Z8bBDCh7ar5EGSkg6N5CejLWOY1MVCMhmzoRYozxmQ48BivEdAxE3QFLFGGicjvGFDnV8kRG2n1ay1QzIjYiTtCv1ur0sHTZWxteLAoRRzG5HClCZ0MQOQhPKYRYt0h2PyBNxu2hHtQ0XWc17VYwpHPAki04RAYFVeMf8/cfupaL5WMWyrhPS6/l16j0OUfhxfOGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Q5hVTPUZzDMBKIGXr868tM3sGXGJ+HOlUFrAQ2JbrA=;
 b=Dg3BMoq34tRY90fhDl+DPp1z9BTtMmK4VBwQU0YEHDFiyWoz3NnrOrpDA4UteMoCo2UxR07AviRio7pW1N2epX62b9cbNV/yorpjc2A8T0W0vbg+axTMaIwpSAM/pIYvn+CUDf1cix9vYz8y2r5Dz8MrxITkbfxrVUWMyuSMD/9W//GZe6+JS3KSGUXe2KucxOfMNRbyipf+rdPyaJxmaBmQ2sGoOmop8qmoygS1WMD8xL2zeOuBBjyJm26M1GiHcVYDdDUaNRi75AuuEdbxTZy31jbbTh8FOP0wLsEkafRx+7nZb9gZw5gJcK+gEKQHLPG/iz4R8wBcy+4W7NS6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5216.namprd11.prod.outlook.com (2603:10b6:a03:2db::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:17:26 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 17:17:26 +0000
Date: Tue, 27 Oct 2026 17:17:20 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4] net/intel: fix idpf Tx payload corruption in split
 queue
Message-ID: <auDcoAtbWmUzVjSo@bricha3-mobl1.ger.corp.intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
 <20261027061017.1018902-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261027061017.1018902-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DUZPR01CA0339.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 611fc655-657b-44ee-9614-08df344e2bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|261026121527099003|56012099006|4143699003|11063799006|10067099003|261021121427099003|261022105027099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: sjQ8ukxiWg4fGO2fame8oUIa+DHJeuusPqOtNs8cHn/BP4/7Oqi1IsomlmwLNPRY65V9Yar3+LAaTXcRMQyEijp+CZqhz3YgAKn5bmen3OcqP20KbqM/Bc8wp7DrEe4XTUm46amTf1v0N30k9iI/H0bMJJij2joQ02lX1EejAMwue7xEo+iT9P9m6DbFmiiL8/kyKsk9iLM8E4TLBkin2SW7vBRBnPX2LyxZt/QiylmmOsVxn8Bi9ah61QF0CGQAEFZ87PyZ0GMS/h5YVVsQGGaPXCxJHU0uNKc0ek9NUwlWW+f9CJUG5nunLLmT8gaw4ps8/clt8ti3NZ8H4hMgCr8uQKa3QypGXhFtgzbOTXGtVSZOEW1Cv0JQ4uGPdpRkuJrdvWA0Q/JIX+nNuQd6AVXHCnJ/uoq7Ghh8jjlGy8BigfpXc/Mi+LLeMvROJOrT0fvwlFDSQ4m2xwNvw+0S/vBp3TIFFTnB71ynDvA8cPw8pYoSRNI8YJC0kmN4ERmVkwqQNYuYbGPzPjJbfJFX3N3MwF6z/bQkk4UjcjRzXZ+M2jVIs12sPUrQsVtcJfZ6PqfMEtdAXo+MGx5iozPNBGCxlREau9uU90mJDkb9Sl6YZq+4EDBkbZ6BuZnUXwQuxhyFR5U51IrWCMtz3LdZavFIowx2q4112Lz00oVujXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(261026121527099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021121427099003)(261022105027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s3eF9oShOV09u4dOviSvtE/U8Ad6LH4xrQXbV91Q9W7L8ZVXrC+Lxj+FSCD8?=
 =?us-ascii?Q?9TFLJVDxQ34xACOkUikt1+/0Xo4Rzg7sK6FbNWIvPWVVmQ3ndfeGi/1R4208?=
 =?us-ascii?Q?5v1z2p5DIMJ8ByDkXDTgbdLAqcDRFOjvarkYBvNXnAP4Ps08SFGhMSZsAKck?=
 =?us-ascii?Q?zV1cgwzQMlvoiYe/uV/ktjqW0NGEX12ApOXlHb8q1iczczB6BSEUWPMLHyvY?=
 =?us-ascii?Q?tfV8C4heO8x1QvI0PEysTrie/mUrAJm0qgt/fchkqnhYpN26bH4FR8ZjhPOw?=
 =?us-ascii?Q?JZ8Y2uyJbStrqumerbk39//SgOqXRxoK932fhbw6TBNzuFHAHyZIX0JdrqXA?=
 =?us-ascii?Q?grQ3D6XXhrEDNWpcP/o1xjVsoNUDf1uck5WMY5ZyCucEursIVDylToINAc06?=
 =?us-ascii?Q?xHJCLLV/UbT7KzWMfROY02HGmq7TD+wu8bV4j9pTDRa/cKAUZV1e4rwI5Wd9?=
 =?us-ascii?Q?GWbAV1FFm0zSjTa2S5dI6WsHSQ1Mu0Tbyp3rORMcZ0sXths2tM3DZ0lNZvFB?=
 =?us-ascii?Q?BrZPwpy60OOIH1r2gqObX6HmTRlQjg6r6PLkTu/P90Dlqmq/AU+yopGiKvCA?=
 =?us-ascii?Q?ZUjxCXBPTgLPdj3sA6T6m5LwlycHa5iWZ85kks3XIMkfZXI9trnE7q2hTIbl?=
 =?us-ascii?Q?co/Fq76LViCPSAJRAQfPHH2c0MXcZVv+p385HNS+6tadu2rmi961vo6V7GWW?=
 =?us-ascii?Q?iHF4pNEJnHYDbrxYUJvGEjWVcAp3Kz2ecqUpRQaEEeMvQMkt+te8z1oOi2il?=
 =?us-ascii?Q?Fd56iyTyZoNhHak5mrpgZt7juYYTn8bkNZmTsw4eBe9uUKSs8WKPeCFOl6to?=
 =?us-ascii?Q?P+f2aygsvfzpI1hu2m42Z0Pr6jGE6bSSJ00qjTCGoh78y9X6OXKhS0Yq56el?=
 =?us-ascii?Q?QK7yg2UijjPrIizzX5u0PaIKWVgOXCXI+hwEV5yBax5/nJ8WPm20QNFEVQ2/?=
 =?us-ascii?Q?pMLS1TylLJ6bQWZkTajRLcvO9okxMLPtJDrBFu6eVCHoHWMWO1S5IvgxhUfX?=
 =?us-ascii?Q?6UZJL8XgEamN30meDuN/vPEN3XyxkMpXEd1wAE/B5yEdD3Mfa+UktzNtGWaS?=
 =?us-ascii?Q?9e72tiwiXxCXAKnr4p0sQSxK1eRy6iW9p9sJ9/rtuIjaYVEc/ZhYe30NHUC5?=
 =?us-ascii?Q?crBpmIXvDrgmXhHJ1eI8uFPkDxsifsij1ru4kCN6mTRGMQ6PF0mmGekLlOC1?=
 =?us-ascii?Q?Nrvkl+bRf/XSpNbRcTBVhrPN1nkjM80txH69rFdsdbavOSz3bTypYz2AgP5L?=
 =?us-ascii?Q?Ptgd4P3zbqvrUTSnFqrrwbXTyMQscc5FDBZU8DEnRsXb11cE7BqGl4U9+m4M?=
 =?us-ascii?Q?3D3G4mk3TstnSwYJffGkdkTfCkvrKIFn8pXqrwe+FjUv7iLBUQEPnXzzfxtJ?=
 =?us-ascii?Q?JxcbFP/j933R2yZEBJHyrfDbwtyg/HCxfCMVI1z5Xs+nIwN+noUIMnam38cM?=
 =?us-ascii?Q?1atgU6JoWsELYGUJVO9YHEtbZMWyGkQKHLzy3MDV5cdpOHXE62G7HlbTki9x?=
 =?us-ascii?Q?zhlvXwxmFF06jVZeyDdyU1pBw9pM7mJVJIzG9nCw3z5vE6EK1ltUE4Rh7/4a?=
 =?us-ascii?Q?Wb2LIvyadX93RWpM8/19FS0wmw92JMTsb7Y+Qd3qTNPfBQbIUoywrCzI6r/t?=
 =?us-ascii?Q?YVE1lqun+SNXtyc+uxMp9Ln0JVq8TEKRrrL63Vqn6YscS0p+/8SYiMM0T6rE?=
 =?us-ascii?Q?v8BLvjJlXi3Ab4wqS9Hz5ptueXF38mkbAmBpThxk952xRGPgyLGRyP/Dv/nG?=
 =?us-ascii?Q?/OgnyjGIkKZ1SZF+WtM2jcrAClBD5nM=3D?=
X-Exchange-RoutingPolicyChecked: YFwj7uIP4wnTbeTL7U1bif4TqrCUx1WkY+BEmrpuwk1U2VJ38lSPxWZ0kmG5w8b8pxxeHNOFhgOIqbezKEA0TQaAd0nDsJkhXKK98rkoBSpXsr3Ms0amjp7pnn1251XxnzxAj5GYGFRNLKaoGIKkfG9F0oE3oWgg/v7VMoPQHuX0wgXnCEbS2b3bbGLCVtXrp1ZP2wBdufW7OPjdZI1+LSYNQbU2p+msoTbnKT0jwvaPWD2ahvZopgWLjNr3ipnZvMRJu2WKuPaBmE6sJGkloS7Uf8BVkrQ/aKu2+KAR0wyxYyz8b76pU2Qe5yb2lfb5XuIfZXv0+yFHJVFsP0Jn/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 611fc655-657b-44ee-9614-08df344e2bd3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:17:26.1068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLtGniw4RKDYu39FCGHCfgbvvB8EFdVv5VdtYF0aQFNa72yiiTcNhHEruvy3wZ01PBAglc7nMfwNu3Bm6ZBCek68ZFdA+v/uoQyxxVB/+cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5216
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

On Tue, Oct 27, 2026 at 11:40:17AM +0530, Shaiq Wani wrote:
> Observed on ACC while running NVMe traffic tests: under sustained
> high-throughput split-queue Tx, payload bytes on the wire did not
> match what the application submitted, while headers and checksums
> looked valid.
> 
> The RS-completion path freed mbufs by walking sw_ring[] slots between
> first_id and the EOP sw_id. RE reclaims and reuses those slots before
> RS lands, so the walker freed mbufs still in flight for later packets,
> whose buffers were then recycled and overwritten mid-DMA.
> 
> Track completion ownership in a shadow ring indexed by a software-
> defined compl_tag written to all data descriptors of a packet (per the
> IDPF spec) and echoed back by HW on RS. The shadow ring is the sole
> owner of in-flight mbufs, so sw_ring[].mbuf is no longer touched and
> queue stop/release drain only the shadow ring. Size it to nb_tx_desc
> and stop Tx when the next compl_tag slot is still occupied, since RE
> runs ahead of RS and nb_tx_free does not bound pending completions.
> Allocate it at queue setup (failing on -ENOMEM) and free it on all
> setup-error and release paths.
> 
> Remove the now unused ci_tx_entry.first_id field.
> 
> The scalar shadow ring and the vector sw_ring_vec are both nb_tx_desc
> arrays of mbuf pointers and are never used at the same time, so place
> the shadow ring in the sw_ring/sw_ring_vec union and allocate a single
> nb_tx_desc-sized ring for split queues instead of the old
> 2 * nb_tx_desc ci_tx_entry ring. This drops split-queue ring storage
> from 40 KiB to 8 KiB per queue at 1024 descriptors and keeps
> ci_tx_queue from growing. Split-queue mbuf drain now follows
> use_vec_entry: the vector path reclaims via ci_txq_release_all_mbufs(),
> the scalar path drains the shadow ring by completion tag.
> 
> Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> v4: fold in the reviewer's split-queue footprint optimisation:
> * Move tx_pending_pkts into the sw_ring/sw_ring_vec union; for split
>   queues allocate one nb_tx_desc mbuf-pointer ring instead of the
>   2 * nb_tx_desc ci_tx_entry ring (40 KiB -> 8 KiB at 1024 descs).
> * Drop the now-dead sw_ring next_id chain init in descq_reset and the
>   2 * nb_tx_desc sw_ring sizing; split queues no longer allocate the
>   scalar sw_ring/rs_last_id.
> * Set use_vec_entry for split queues and route mbuf drain through it
>   (vector: ci_txq_release_all_mbufs(); scalar: shadow-ring drain).
>   Rename idpf_qc_split_tx_pending_free() to
>   idpf_qc_split_tx_release_mbufs() to reflect it no longer frees the
>   ring (freed once via the union pointer).
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>
