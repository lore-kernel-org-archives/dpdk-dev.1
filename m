Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7BAD1A638
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 14:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F4D840A75;
	Fri,  9 Jan 2026 15:22:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 61C9240A72
 for <dev@dpdk.org>; Fri,  9 Jan 2026 15:22:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767968531; x=1799504531;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UNeVX0Le2wRnRSfDEvDof6YIwGL3czslr5QgkgtQmBA=;
 b=lJZvIbyLUWN0aePABigsF9t0UkqSqMf0e97opxit0CfL4bqq4PfKbDZ6
 QRgZqFehmcdSDsHrpPGixmNuoJppLSPA1ZF7Gmqg5c4FM3cbLqdD9an5Y
 7DQ/+cSyD+fwwz5gGMWdj+rRSWLsrM1zTkiG1vAUMFNq6th0tYsUheFKQ
 BBc3gchf+wDaURK9z6hREN4PakQ1vQ2RbeijjFaaEd6fwURTwfNRFLzNX
 3vlgaI88A6UCHPTlWWTctlSKOZjEF36LRhxDHWgoGE+BHs9eD6dXDI7XW
 BKOOSA9vWyOZ4TZkpKMnMYO8v9MTjpC0yVpSZYt07FWGQYDr9ftYUODIw Q==;
X-CSE-ConnectionGUID: SZlLQiGBQ8a6Uvf1t61dgA==
X-CSE-MsgGUID: 64FJnoLISs68xl+xIBpRog==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69087004"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="69087004"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:22:10 -0800
X-CSE-ConnectionGUID: pXNj6vblQBWwzIoDI+0Unw==
X-CSE-MsgGUID: ZS/qL+nsSb6djx6cTRR4eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; d="scan'208";a="203548029"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 06:22:11 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:22:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 06:22:10 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 06:22:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic3Ld7j8QAwidRaMdA5L1YGRRcfZXaaT3o1/h/znYfL1hsvLE7LbjO5sVMh0bbAr8o7YErFkCs5FJgeRz6m/g7PPQ9KpyQARil4I71BBxr0jwTl7jomHK7dbCNjKFEFnmAnECnLX6dCBy64VfL4V8KjLArYsluHQMe7e5b08gqsWDMHiHG5BT71OBZh7xr96Ray8mHC6+ByALVj5KYLUvP6vWgRRDm6b2nBtE8YBG9ZnW8ggUPDu++OaIAIuevUInbt7FluFy99Fjf4tWmumIaCeMeLepQHwl8oz9HMUL5j5EyXVRdKGXhjFUUI7ZnO4/vI81wYUZhtdXavXZ6npeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xg/0awaYUMT/KhYcCZX7t/0ogB8mcmoRGJBiBYnG7o=;
 b=BVNIUFAfj5tzJ63R4NuZQCGspHXxMcuSj9GENXfDqgbgWApD4pcmufOvP1S4a8Hm5yIeAkJn4oD+SmBSLlrBTMxpCd3VItncDgaTXeeauo7wjE1PwQdzAZ0L/jkJ+NVxbbPVFcfEPLQdXs6GrQuzVAH+v7mwrubmHlZXr+reuMVCmEo7abn4le9ASCXDJgBPAKo9c2e8/O50USQvafTdNz2Qx+02YkRyWHDBMhr8XmonQf1R4SiRiQjgD3Gq0Kvcia+kYA9H4VLSP4WbNDCiL3mNf8WeqgxeepeJFy6IbmpJOM2ymWuO6wvblq34IAfqHL4KNBTWnMtjojLRAX5q1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:22:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:22:08 +0000
Date: Fri, 9 Jan 2026 14:22:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <dev@dpdk.org>, Paul Greenwalt <paul.greenwalt@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Kevin Traynor
 <ktraynor@redhat.com>, <songx.jiale@intel.com>
Subject: Re: [PATCH] net/iavf: negotiate PTP with PF before reporting Rx
 timestamping
Message-ID: <aWEPCYv6W0z4slAQ@bricha3-mobl1.ger.corp.intel.com>
References: <20251210-jk-dpdk-iavf-rx-timestamping-fix-v1-1-ff5913717295@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251210-jk-dpdk-iavf-rx-timestamping-fix-v1-1-ff5913717295@intel.com>
X-ClientProxiedBy: VI1P195CA0055.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::44) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 196de420-6dd9-4825-16ca-08de4f8a786e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PSbF++iXFGT3+zWIpdIMxxlqvKVE8dhboHCH3RxVw167r7TwsP2mqIb53OB4?=
 =?us-ascii?Q?MTPd4qIv9ndM2KjqzkGRBYwphH2iogOmjCOgfSO1JbkNzl5Wjad0DewD4Bj+?=
 =?us-ascii?Q?Q5xh166L9eLclmEO6zLVefYFgnPiGOPIzGCCQ+wNNUuvkYfeoJ87/ESkz4Qo?=
 =?us-ascii?Q?E565uuBuEuAy3Suyn/3nVhKg27rc1RC03vqmTuyM69K/eM6IjYgiuiIfWI97?=
 =?us-ascii?Q?PuxLzENm/kqmWh8JfGgfFuQCfconES6n5C1FILRynDDooiQqh5O2qS84h/jh?=
 =?us-ascii?Q?U16+THO7pyJ6gdbtoOajgpkBGewqYryzXc43700NDb+/b4rOfcFG0fJdLM7Q?=
 =?us-ascii?Q?u/bYJuWIFCJR+Y0i8Ek4qPcFAma1BICVB3sLogPD4y1h15eQ53oANPHigGcT?=
 =?us-ascii?Q?kCVtR31UdtVK9qSdwZuEzrg1h62uCODR0fM6Zb1uynEjuV5rA5DMAhYPixGk?=
 =?us-ascii?Q?FuN8Blq9ljpmw43cxPu9E9F7xzlRJaiaXOW2LrkkAWf80kZV8TmWqvdHroUX?=
 =?us-ascii?Q?rKsjg0RyuZYg4PwkqSPdCis1M6uTMqEB1SSwxlyfzIbllAaVQVWM6ESH2Rhk?=
 =?us-ascii?Q?9zOCJqNUGJWoO6vWmSloAp+zFy2faHhUWJulHdQ+pcgY91gST/JM3JF1BGEW?=
 =?us-ascii?Q?aSDOznMl0WsNM/cf1fIIvMql6i+FbiSg8VdTEkiXDsbfZzNFssDPdG5lG/Vh?=
 =?us-ascii?Q?GdcHSTym0sebxZPoKIa1p4XsGKme2v6Lidx31Gv4sieXAEsoSv/WBDK86cOy?=
 =?us-ascii?Q?ojdClAvMKnUNDYH2BLZyUw5P6f1+F9whFhyUA127RCz5kSARxADJghX/juW4?=
 =?us-ascii?Q?lCMX8nbBgTaGaqRhye6cqc5ZNuAlf6etNMcba7WHcOvmW8QTLnAPZrNZMlHI?=
 =?us-ascii?Q?48w82YmnDKPFq+pSYUdDFeHWho72ZDQEGQRaNwJqYcGN8r8Ai3WxKWoMRm4+?=
 =?us-ascii?Q?ncREmKr8yp4WuxQC1FAxYLe+gzEeaW82AMfYl9heBCxg5RpS/7eJCK8CHrXw?=
 =?us-ascii?Q?O8FphZmxPY2RFDndeCxx+/3r4+EHJd3CxLE3TUEOxw8/cuJRdV8vBKMWpScc?=
 =?us-ascii?Q?SefKdXiM5aq7JNKpAX/sDBzL0dAka3un0lZI2y6nKPFIlPQvRZxWVGrvqUOU?=
 =?us-ascii?Q?L7KomgSuLheFmqjr6zkHKHBB74kPVvYh69q6f7JRa70J65O2uGKOCBv0InvQ?=
 =?us-ascii?Q?kFe75kYtxpRtVOUecc6jElUfsNk/tFuudGtPvAUp6LjKIO/PP2gf69rs0Cnb?=
 =?us-ascii?Q?0D405FHPJkeqyEwtq4rT2Ec7WBS9CnlirbQYHGHzQdsyaSAKsZuA7WUgw3Kc?=
 =?us-ascii?Q?eAxh6AFvO/fMega8QCYQyGZMSEsbY0wdai/5lNTDAFe1bhCENk01HnEJgURe?=
 =?us-ascii?Q?s9FizLrIYNSef/u5dNO1qF2T3FHdUb3zeDKpHK65zWaS1mGKPn8vBVFJetZf?=
 =?us-ascii?Q?gV8YI3jV8sisH7oU8dcy/JQRyu5zFDRZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kmdpp9PVJXXWyDEf272stcBQcWlxmeXHJYf7iHpmd6in9QEhx6N6+1XpZfBE?=
 =?us-ascii?Q?Nr20/4ALZ1C/fvhU3aj7diHnZRrZDBzl6410Gsaa7UcZr4GIrWoI/HjnxWlj?=
 =?us-ascii?Q?yc/cOFQYL8Vm3k9DidiAmdlL19frsWFWL9nM4cP2DPZ2einKSg+5g/P9dFlO?=
 =?us-ascii?Q?M57N25DCG6/ibQ3Wa2QgVxYKwWrKudpOb3wsxZZB5twhfBabECDyCTFWW1L1?=
 =?us-ascii?Q?3RupR+zj4VCh2iTOGRBTqmCwbH7IwvRvkXmGVjmTc/o407CP1h3v7WhjpYUK?=
 =?us-ascii?Q?0YGdiRADxb9DRAFq/k8zW1DWWZWV5BcpPtBbu6C5zToUck0Grtd7A9yEG5uu?=
 =?us-ascii?Q?rnt9da15iKtQTkL/vgIus7Ei2A3QN5Un85syniu9JuVoGo34LXOPTWq5wfmA?=
 =?us-ascii?Q?WC1K990235X52LkPlP4ejqRGwkXbEEH2C8ZOQKVu2ItmKFBsF8h0YazSrkJI?=
 =?us-ascii?Q?X8l2yykP5kjcKMyNRM/TYaX62IZOCEGEQrvlQZM4ytuRjqc2KAe8GKwOrJXF?=
 =?us-ascii?Q?Mioto7Hf18d8wd/LnhTkU3CgsP9DsgIQXBriFBmLBdrNgbn6hiZNGNfdb04u?=
 =?us-ascii?Q?rKTorKtyrDowun1jv4+DfbMVJJAbOLPvMwdUm90P3z+dhY5rQ/psbKhboTEI?=
 =?us-ascii?Q?P4tlcVZj8+hkzMbEMinM3eQRzCI1HOH3uxUYVFrXQQ6+iQqwwkkIbGVEiAY0?=
 =?us-ascii?Q?1kAWX4rB02H7mmmY0zc8FSOKLIn85WINKpG/NygFisDTpoLA91E/JngJ8bqP?=
 =?us-ascii?Q?Dsu92WIEjT8L4L1YomcGJwdtNf0tiLrzueJ6WPx3gnVbiuTvf7EybKzqgEz1?=
 =?us-ascii?Q?7sBQQ1ZkodXm4ycfPSuVh7cOMAyVl0m6dejFBttsiczK/Uvq+uOEp2BAT852?=
 =?us-ascii?Q?FXNj4GbavpWDo2v9xFpEEC52mvnvWA8Ncag+D9CtTiJIqYKWS0IO8UMUQNOf?=
 =?us-ascii?Q?JQFyv6mpQSOm8R+8k7I6k7EOC/3WqiFtq1mUYQ2eOQblgroHzEMcvtP79AOJ?=
 =?us-ascii?Q?ZJvAT9LcsXxk7P1Wwq4hzctrFdzScVhEe3LEKyrfW0ubrfQuPd9OMRcIGWM/?=
 =?us-ascii?Q?bP0k+lXe2sIV5uGpL8PgqBXy/PdlbPD7v12U/wwFnHmhF4evl7h7z3O4Wzkx?=
 =?us-ascii?Q?acNO0CyXz7Bpv74434zJXOkJPD7HASOXfT29hYGm0Pb7LAznZcxpCwYBX4kM?=
 =?us-ascii?Q?+9Bd7Pn9wl044p1+4yPYP40MU3+ML0c1mKO7LknFEFyPmJTyL3vuFF/QnXby?=
 =?us-ascii?Q?pGpbWZSSO7dBstrTM1oYYCVoKB04CbMUs9R0wqPGs4zxWLmjymoDsfuhvtli?=
 =?us-ascii?Q?D2MuKd+MjF3QC9URHXlH6hF/0IlzjvdgoasLApfudeXZvG5aeCD4jbnolz2u?=
 =?us-ascii?Q?WxFLPFItt14XFsk6rbykDj563pDTSChDEC0AmafAVEB2tTpCu7VLbcJg5THw?=
 =?us-ascii?Q?3kbragigv5ziecwTelgypgWJicAAuiiOGueUmh2UkKGR7RMkdCa2WE8BUF5z?=
 =?us-ascii?Q?TqpdmQxVsIsMiNfE+m87urQtfQLxCcy/qdyr2XTEhmyVCD4/4js70ZpGGP+d?=
 =?us-ascii?Q?AHgyd2fMmZdYMjMTFKb0PwBRFvJg5m9spmRaKLww3v1FOW3Q+2W1aAqZwQQa?=
 =?us-ascii?Q?nu9yfXWeHeA5wd3QMjuaoQpodBn+3T5miogZxcNYmrcAiveU2FkYDodqG9kO?=
 =?us-ascii?Q?07YhLMTgEQyO/mWja3A3SSgbbW+5bKkrKCMzi+Tag4lGFEOdILvKRuRYXNnY?=
 =?us-ascii?Q?TFawITRXsnzEsUtxHwk6UkSwHPrbNvc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 196de420-6dd9-4825-16ca-08de4f8a786e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:22:08.1105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWdqXErwlbFNRuwHH6G3EE/RDLAwjdkhtz1urs0LXvCjrk/IenCoXQMOH44MI0z6n1/B3FjvyJUnezLPeIoYmo9k7uJpNr1f1d3/4WfpRx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5140
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

On Wed, Dec 10, 2025 at 01:45:52PM -0800, Jacob Keller wrote:
> The iavf driver has support for hardware Rx timestamps since commit h
> b5cd735132f6 ("net/iavf: enable Rx timestamp on flex descriptor").
> 
> To enable this, the VF must first negotiate PTP capabilities with the PF
> by sending the VIRTCHNL_OP_1588_PTP_GET_CAPS command, with the requested
> capabilities. The PF will respond with the actually supported subset of
> capabilities.
> 
> The PF may not actually enable Rx timestamping, even if it reports the
> overall PTP capability support. If this happens, the iavf driver logic
> will incorrectly report that Rx timestamps can be enabled despite being
> rejected by the PF.
> 
> This should be unlikely in practice, as most PFs which support the
> VIRTCHNL_VF_CAP_PTP will support Rx timestamping. However, there are
> some cases where this may not be true. In particular, there is an
> unfortunate issue with some versions of the ice PF using a different
> structure layout that prevents the PF from enabling Rx timestamping.
> 
> To prevent this, the DPDK driver should check the capabilities and
> confirm that the PF did enable Rx timestamping, instead of assuming it
> will be enabled by all PFs that support the VIRTCHNL_CAP_PTP feature.
> This prevents the DPDK application from attempting to enable Rx
> timestamps when the PF will not support it.
> 
> Currently, the DPDK driver only negotiates PTP capabilities when the
> device is started. First, check the capabilities during iavf_dev_init()
> so that the iavf_dev_info_get() function has the required knowledge.
> Then, only set RTE_ETH_RX_OFFLOAD_TIMESTAMP when the PF has informed
> that it enabled support.
> 
> Continue to re-check the PTP capabilities in iavf_dev_start(), as it is
> important to renegotiate after device reset.
> 
> Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> This is a new version of the fix to prevent enabling Rx timestamps on PFs
> which do not enable it when negotiating capabilities. It combines the
> original fix along with the additional requirement of negotiating the PTP
> capabilities during iavf_dev_init().
> ---
> 
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,

Thanks,
/Bruce
