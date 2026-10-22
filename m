Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0675606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HWCdtZMR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3808240264;
	Thu, 22 Oct 2026 18:28:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 37FB94003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:28:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792686500; x=1824222500;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TYI4YWOQ0WXLnrWlvrtyFj5sdQt8YhX8bY7C+MEs9Hs=;
 b=HWCdtZMR6gWP8pS9XQcMa4LePdpDFOgZGRtQ56ZOtZ10ptyB/YrTsnXs
 w8CTzbu76DXoVPBDMiaS0oQS6xhnHGncLG6Q+a8CKIfOSSdVOV5Y3TaMQ
 cWjwaBLrxq1u3AdP1WhxO9UB+x3qPH/QX7LyWgdPmqfHYJww7r6sa2gEV
 mVej8b+9h1Kgpii77svmd+GKDvrvX0DT7Vap+zwc4CWsIEOsMBmkzVCWN
 JROOydCqBNUJLIdpxVJAAsP89PPqADkUc+hlIdUY0LrFkje/nCbffY74w
 9HPLTHohiWYNYc0ZdcyYfcHYfsOkoqJL7DddekSxoGSGki5x4lAmM50QA A==;
X-CSE-ConnectionGUID: pzNGw0HKQciKOdsq3UFUqg==
X-CSE-MsgGUID: plsQxGA8QFqaxiv6+DK/pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1454911"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1454911"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:28:19 -0700
X-CSE-ConnectionGUID: eNXD5d7UQbKqYODIvvzGjA==
X-CSE-MsgGUID: 999w0VVETS6RcXFdIkS0aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3278244"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:28:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:28:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 09:28:18 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHe7yR17Ck17EwXY7BD3c44JkFr1kKZKFmZ0ig+Y47UmGnRo0m1N3mhDfAhdmYNLIJhDwXTL/SbNFdepq4ru6C0dTRm/VYBPnYBRR9+H5bqHk0X5kZX5stjczO3S2YkEE8pcFxxtrVXmvAzSLuXOqDQPY1O2oBeI/0z0jkCStKQVxU8JpTA8paHEHvgBz0LX5fGmjlppyf/PVOpm7pDI/rqaGaeF0iKweO+40j83BaizBv/wOD78VpfLj0bSxyxPgLJlcxT7wDN+c6mMJ+5IhvTMotjrpCeZ9aIcXBev11oBbjxKRNs19w9xSrMOiXWl0+5bSjIxjnb9afcuHKxWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qKOYmhe4U/1FlPkMouE9g6tYPvQxwccfisGMMeWiq0=;
 b=EZSfSbSK5z2VLKQECstVxwiJFZs2dn+2XxzfGsGIpMFAi8jSmMww9pwWqKwcX8/0IlYvq6kxwTal0gTLhoIbzr7o84x4hhSb6Q1JBOcUUlmf67Wg38ru+gKauOzc3fLz3Exz1yYToYf98r9tX1IhrepQEfIB2K3+zSJ81MEmNUp9nz4gomi6awG0SB/YVKdBjSzayMKC5cr8+AV5A9hEiUzIFSVtZmq08HjpWG4eDgu3gnTrT5MVmPxkA0v5OHL0c0alqT5daV1CUU2bOvq0DMJYtFuExk5hU+bS+QDzbv7E23gLOJE+wUlD31jvL2r1p+/rI0d5KXH0ordRvGtyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CO1PR11MB5060.namprd11.prod.outlook.com (2603:10b6:303:93::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 22 Oct
 2026 16:28:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 16:28:10 +0000
Date: Thu, 22 Oct 2026 17:28:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v3] net/intel: fix idpf Tx payload corruption in split
 queue
Message-ID: <ato5lCtBr-MSuuv0@bricha3-mobl1.ger.corp.intel.com>
References: <20260930044630.250936-1-shaiq.wani@intel.com>
 <20261022052207.591236-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261022052207.591236-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CO1PR11MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 20165988-93a2-4778-9aba-08df3059760d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021121427099003|261009223327099003|261021123027099003|18002099003|22082099003|10067099003|6133799003|11063799006|261009221227099003|261009220027099003|261009223027099003|4143699003|56012099006|261009221727099003;
X-Microsoft-Antispam-Message-Info: gLh8l1TK2a0s/i3TNWTD6k9MbvF/g2PUARYW+jHX6lQKI5BsPAkkZi4wP49Y0UEVQvDh9NcfFOk5CuVDmr6dyCihALsQu2AtP3tNmhcYK8CQvYKK3S6Pmp4l8lqJlYnckW3VrPwPPxxJei1kanja/W7Bk9E4G5eGnjCv4W8ILDwnYBiEzwOfZfX+xM+DKVczkWYuftQRQhhTtlVV9CjKyus+jGHl8wqwAdDiP/Xn/nuxeKIqUqSfPy9WocD4lbfsBj0UmtDXNLol+dtTjG6Bmhr6oiB9xeyiJH0BMgBoN+Z8oG7QZv6Z2USOyfo8baAvVWGGDqSZbtzST4uNNzbE9iEbHJR5nVpt9RCz/N+8VrwWBRcYTmb8ylIDfCgPE4usJacGIAjX5CzXkF96OI1D+0zuDXLb2jX6ySDpI4bb29KfJ4/2yZ3+UZWf1SBQEQGIxI69gVIJwI7ILRJXaXbXwDg2PDiGrOrEBXbVN5sEGUgXXuL5PSILiaXrm3QIOBN5vbSQazB41vzJ2wBCd14kJZ3byht01M5PM1is/0uelzMBgp8qzA/szxJPpmNGO6rwDVA4sHaRKL0gv1NlRMziVTP4YiD+n40//cuvLJSKSnN9JZdu3XB0OFvvU+breDTNVUqtsrWlUgXyWoGdYOJEtd7XwiMC5BPQPWebxdlo4fw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021121427099003)(261009223327099003)(261021123027099003)(18002099003)(22082099003)(10067099003)(6133799003)(11063799006)(261009221227099003)(261009220027099003)(261009223027099003)(4143699003)(56012099006)(261009221727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yamjGBdiO4dX9frqfwE8ETOpfp5G7OID67YqAC65NtTHFh7/U6tQb38G0TA?=
 =?us-ascii?Q?S8ZmCDYBNtoipTBPpFSpyGNXIPm2EspGEjIpU7aHSkHkm6iio2NIY/E3yYTD?=
 =?us-ascii?Q?lKJ6i5CF22vW10Ipe+z7xN+cz1AtQ+wtm7+RtMf0T2c+z4lxAw1fMVT0FT0U?=
 =?us-ascii?Q?19W36vcOc/OmuW7kL0+km9KYyfVD/V+8TE/uxkJiRDrZFADtd14Avd5ovAHA?=
 =?us-ascii?Q?WZ+90yyphfOwONsw6glX7qFnRUm2mz1JiPDnrm0XBpeihWRMHkyeYUefYSMr?=
 =?us-ascii?Q?VLVkzawTkPxw00Nvljjb48r23H7AFjttWGoWkq4WcAT2SNX+Gjg3Wck6p8cF?=
 =?us-ascii?Q?ZRRNj6aNOO4WhZY4YkcIFbU0bvOtawUSf4QF4krGMTGQgwm18idi/v1/obql?=
 =?us-ascii?Q?QpogIUXz2psSIFbUQUrTo7JN4qXdn4QoxqSaV4WrxDTleJAXQ2jqVMNR2gEW?=
 =?us-ascii?Q?Nj7deP/05DCnHX7ee5P2/cVexMZxGyBTW28cTAcvBVU2EYKj69pbioeYVD00?=
 =?us-ascii?Q?bOgYVeNHI5F03zivGSOg5u23YAZsi5Jt7hAuwbXMlLfyUSl5Gy7uRXnk/IaM?=
 =?us-ascii?Q?nd/KUZ7LZsxZGFS46x/27iLknMmCiRzaSGY0YV/+2B+HZWvfejSFS9toz6z1?=
 =?us-ascii?Q?s4L4y3gzxowv7PZ6LOliQ+CFtgYrwdojY4JW1rVEJ2ScJZt+ueIXoVt2yyvz?=
 =?us-ascii?Q?yG6LcnDyaxBcwpz6n72lfNylUPAcUVbDJ1fiLdFrOa2bB3zXVthYapwCIfZs?=
 =?us-ascii?Q?t1bc95+ASWJ/Qay9YJuMzdJSSwpEkVuiaUFGN6pzNOZ+T5nAo0PM467ajgVv?=
 =?us-ascii?Q?T1oJFGtudA3SDtAZpMWIImZTk9tvUfGJyZhD+3i3uksHb408DBIm0fUoHo2j?=
 =?us-ascii?Q?HSb242IWrIGeGjqIhFYkUx6G/W8pvB82tcrApZ8TTJgJwraV2Xl9NPY8bJpT?=
 =?us-ascii?Q?l7gHQ/lcDhzF5SN1imybI0V5n4TtJL2Hqx6nDD4n4MxygHrRJhM0fVkJcZU6?=
 =?us-ascii?Q?V5HpGSoQD0xcK6FrmHWNtuUmjSD7Kp7LxiTiru4JRVy9o2ccncXNqWbMG/xY?=
 =?us-ascii?Q?FMNk6YEaorZE7kdiotPi/N8GuGzHaAhgmhCW9noP20xVhwPLEHH50JECEIHE?=
 =?us-ascii?Q?bRFSwbA02BOqfmp0pamGlqdhbT8kHODrhwIvUnbIGelGm5oxaaiM4doPR0fX?=
 =?us-ascii?Q?4Auw/2/FXcapNySKa1Uxo8dIIypAXmtw6re4+L8dSiB8T7Sh7oVbtl8YV63C?=
 =?us-ascii?Q?CP4xWGGomfVh61l6I8YoSWNG/cOcYLCiZD7kSt3h4VMdp3IIfJenA7LR2ewq?=
 =?us-ascii?Q?xIP0yyJL5m6Og6QLay0N+sp4ipIzYbvzWqZGQLEHGTRCZ4PCV2tj5s8ahajW?=
 =?us-ascii?Q?zW+uTqDJNd5Pst5HRbSF7Da537Z3YexUe1WmeIcPAxSgTFSVlmXAOIAyuDAc?=
 =?us-ascii?Q?2rxarXqBs0G8QhQrKbIUcPC+drI3AEbqDQiGSorwspmYV2k0Y+wWuBMC3UTY?=
 =?us-ascii?Q?lQ0H+zh+L4h0YlJBwnIYYMaBa0lDbvq22qUEfAnEfinWbldgP/2UFmKerL+U?=
 =?us-ascii?Q?ZSax7NZzNmlXFS0TFss9Cvzmdoy36i/UpjpcF/QC9JGz72V9ZcwOk/DDHWY1?=
 =?us-ascii?Q?5V2dh3vSwJnV2MW6vUFCbMeuVKmGNcyTO/BV1bFkX5pdb6WryxMiPffa8Hp5?=
 =?us-ascii?Q?ylL2B7CF6DiYVP3m5A5CIBboUqq5QAXBAaTg3e8KtghSi230TVDdHKybT/12?=
 =?us-ascii?Q?E2y4sLh/PgamLXGhA7zws5NPt7NRDR4=3D?=
X-Exchange-RoutingPolicyChecked: O3MHZ+aFHlXa0PVNPZDGzCtY+Ma5WCqMGXY+tVJnGOfLL1EIx3e3Mii8JPqIywOC6bfy1Pq0RGvzCiVWrzF3hFeYKK8xGsejhGpRvUgyjKnKXM0K89IfLo+2Wm9Z8QE/1Nshe31xzy4yAC/Ki/bMNdbB62w7h/qGSC2YUxgqC6FE+NxAn1NRIxt0B35rDBmMimazdVGGwOp984nC0ShfnWpB0uyxiYFCOBEYT81bLZNGFWs3MqqzpYp3Gtmibf+nXIVntsSDi4h/nW8YIGoopxto8DvkssRt2e3Fe+hNNxnA894OGWF6Xg21IcGqlntlM54+4o1YpN8Bboxvevsnaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 20165988-93a2-4778-9aba-08df3059760d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:28:10.3630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CJZfLS6jr+J3qxBnC1Ei8ZZLmPcYZpUxVEcCYGSX11h0GpHUwZUervn6Lqqph4NVj3W7Mpip1CN4abKjT4fYID0w1PkriKHwXoTVewVbEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5060
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:52:07AM +0530, Shaiq Wani wrote:
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
> Fixes: 96cc9b6ea60c ("net/idpf: fix multi-segment mbuf leak in split Tx path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> v3: shrink ci_tx_queue and trim the fast path per review:
> * Drop the redundant tx_pending_size field (always nb_tx_desc).
> * Reuse the now-dead sw_tail slot as tx_next_compl_tag, so the shadow
>   ring adds only one pointer to ci_tx_queue.
> * Remove the dead sw_ring[]/next_id walk from idpf_dp_splitq_xmit_pkts.
> Kept a dedicated shadow ring rather than sw_ring[tag].mbuf: sw_ring is
> indexed by descriptor and drained per-segment, so it cannot track
> per-packet compl_tag ownership of multi-seg chains.
> 
> v2: no mbufs in sw_ring[] (shadow ring is sole owner); stop Tx on a
> pending compl_tag slot; -ENOMEM propagation and cleanup on all paths;
> same compl_tag on all data descs; shadow ring sized to nb_tx_desc.
> ---
>  drivers/net/intel/common/tx.h             |   8 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c        |   6 ++
>  drivers/net/intel/idpf/idpf_common_rxtx.c | 119 ++++++++++++++--------
>  drivers/net/intel/idpf/idpf_common_rxtx.h |   4 +
>  drivers/net/intel/idpf/idpf_rxtx.c        |   5 +
>  5 files changed, 99 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index 2a63cd4330..65e8f3fc59 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -166,7 +166,6 @@ struct ci_tx_queue;
>  struct ci_tx_entry {
>  	struct rte_mbuf *mbuf; /* mbuf associated with TX desc, if any. */
>  	uint16_t next_id; /* Index of next descriptor in ring. */
> -	uint16_t first_id; /* Split-queue: first sw_id of packet at EOP entry. */
>  };
>  
>  /**
> @@ -260,8 +259,13 @@ struct ci_tx_queue {
>  				struct idpf_complq *complq;
>  				uint32_t latch_idx; /* Tx timestamp latch index */
>  				uint16_t sw_nb_desc;
> -				uint16_t sw_tail;
>  				uint16_t rs_compl_count;
> +				/* Split-Tx completion tracking: shadow ring indexed by a
> +				 * rolling compl_tag decouples RS-completion mbuf lifetime
> +				 * from sw_ring[] slot reuse. Sized nb_tx_desc.
> +				 */
> +				struct rte_mbuf **tx_pending_pkts;

From my analysis, as I said in v2 comment, I think this can be put in the
union with sw_ring and sw_ring_vec, since for scalar splitq it replaces
those rings.

AI suggests the following diff on top of your patch to improve the memory
footprint situation, and reports "At 1,024 descriptors, ring storage drops
from 40 KiB to 8 KiB per split queue", which is a reasonable cache
footprint saving. This is untested, but including here to show the scope
of suggested changes.

/Bruce
---

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 65e8f3fc59..00bf90181c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -186,6 +186,8 @@ struct ci_tx_queue {
        union {
                struct ci_tx_entry *sw_ring; /* virtual address of SW ring */
                struct ci_tx_entry_vec *sw_ring_vec;
+               /* IDPF split scalar: packet ownership indexed by completion tag. */
+               struct rte_mbuf **tx_pending_pkts;
        };
        /* Scalar TX path: Array tracking last_id at each RS threshold boundary */
        uint16_t *rs_last_id;
@@ -260,11 +262,6 @@ struct ci_tx_queue {
                                uint32_t latch_idx; /* Tx timestamp latch index */
                                uint16_t sw_nb_desc;
                                uint16_t rs_compl_count;
-                               /* Split-Tx completion tracking: shadow ring indexed by a
-                                * rolling compl_tag decouples RS-completion mbuf lifetime
-                                * from sw_ring[] slot reuse. Sized nb_tx_desc.
-                                */
-                               struct rte_mbuf **tx_pending_pkts;
                                uint16_t tx_next_compl_tag;
                };
        };
diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 0dbe47d336..a358beca23 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -325,12 +325,12 @@ cpfl_tx_queue_release(void *txq)
        q = &cpfl_txq->base;
 
        if (q->complq) {
+               idpf_qc_split_tx_release_mbufs(q);
                rte_memzone_free(q->complq->mz);
                rte_free(q->complq);
-       }
+       } else
+               ci_txq_release_all_mbufs(q, q->use_vec_entry);
 
-       idpf_qc_split_tx_pending_free(q);
-       ci_txq_release_all_mbufs(q, q->use_vec_entry);
        rte_free(q->sw_ring);
        rte_free(q->rs_last_id);
        rte_memzone_free(q->mz);
@@ -539,7 +539,6 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        const struct rte_memzone *mz;
        struct ci_tx_queue *txq;
        uint64_t offloads;
-       uint16_t len;
        bool is_splitq;
        int ret;
 
@@ -584,11 +583,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        txq->offloads = cpfl_tx_offload_convert(offloads);
        txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
-       if (is_splitq)
-               len = 2 * nb_desc;
-       else
-               len = nb_desc;
-       txq->sw_nb_desc = len;
+       txq->sw_nb_desc = nb_desc;
 
        /* Allocate TX hardware ring descriptors. */
        mz = cpfl_dma_zone_reserve(dev, queue_idx, nb_desc, VIRTCHNL2_QUEUE_TYPE_TX,
@@ -600,34 +595,34 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        txq->tx_ring_dma = mz->iova;
        txq->mz = mz;
 
-       txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
-                                         sizeof(struct ci_tx_entry) * len,
-                                         RTE_CACHE_LINE_SIZE, socket_id);
-       if (txq->sw_ring == NULL) {
-               PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
-               ret = -ENOMEM;
-               goto err_sw_ring_alloc;
-       }
+       if (!is_splitq) {
+               txq->sw_ring = rte_zmalloc_socket("cpfl tx sw ring",
+                               sizeof(struct ci_tx_entry) * nb_desc,
+                               RTE_CACHE_LINE_SIZE, socket_id);
+               if (txq->sw_ring == NULL) {
+                       PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
+                       ret = -ENOMEM;
+                       goto err_sw_ring_alloc;
+               }
 
-       /* Allocate RS last_id tracking array */
-       uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
-       txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
-                       sizeof(txq->rs_last_id[0]) * num_rs_buckets,
-                       RTE_CACHE_LINE_SIZE, socket_id);
-       if (txq->rs_last_id == NULL) {
-               PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
-               ret = -ENOMEM;
-               goto err_rs_last_id_alloc;
-       }
+               /* Allocate RS last_id tracking array */
+               const uint16_t num_rs_buckets = nb_desc / tx_rs_thresh;
+               txq->rs_last_id = rte_zmalloc_socket("cpfl tx rs_last_id",
+                               sizeof(txq->rs_last_id[0]) * num_rs_buckets,
+                               RTE_CACHE_LINE_SIZE, socket_id);
+               if (txq->rs_last_id == NULL) {
+                       PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id array");
+                       ret = -ENOMEM;
+                       goto err_rs_last_id_alloc;
+               }
 
-       if (!is_splitq) {
                txq->ci_tx_ring = mz->addr;
                idpf_qc_single_tx_queue_reset(txq);
        } else {
                txq->desc_ring = mz->addr;
                ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
                if (ret != 0)
-                       goto err_pending_alloc;
+                       goto err_sw_ring_alloc;
                idpf_qc_split_tx_descq_reset(txq);
 
                /* Setup tx completion queue if split model */
@@ -646,8 +641,6 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        return 0;
 
 err_complq_setup:
-       idpf_qc_split_tx_pending_free(txq);
-err_pending_alloc:
        rte_free(txq->rs_last_id);
 err_rs_last_id_alloc:
        rte_free(txq->sw_ring);
@@ -1371,8 +1364,8 @@ cpfl_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
        }
 
        txq = &cpfl_txq->base;
-       ci_txq_release_all_mbufs(txq, txq->use_vec_entry);
        if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+               ci_txq_release_all_mbufs(txq, txq->use_vec_entry);
                idpf_qc_single_tx_queue_reset(txq);
        } else {
                if (cpfl_txq->hairpin_info.hairpin_q) {
@@ -1551,14 +1544,12 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
                                        IDPF_TX_DEFAULT,
                                        false);
 
-       /* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
-       if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-               for (i = 0; i < dev->data->nb_tx_queues; i++) {
-                       txq = dev->data->tx_queues[i];
-                       if (txq == NULL)
-                               continue;
-                       txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ);
-               }
+       for (i = 0; i < dev->data->nb_tx_queues; i++) {
+               txq = dev->data->tx_queues[i];
+               if (txq == NULL)
+                       continue;
+               txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ &&
+                               ad->tx_func_type != IDPF_TX_DEFAULT);
        }
 
 out:
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index 496900b697..eb29024547 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -202,9 +202,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_descq_reset)
 void
 idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
-       struct ci_tx_entry *txe;
        uint32_t i, size;
-       uint16_t prev;
 
        if (txq == NULL) {
                DRV_LOG(DEBUG, "Pointer to txq is NULL");
@@ -215,13 +213,7 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
        for (i = 0; i < size; i++)
                ((volatile char *)txq->desc_ring)[i] = 0;
 
-       txe = txq->sw_ring;
-       prev = (uint16_t)(txq->sw_nb_desc - 1);
-       for (i = 0; i < txq->sw_nb_desc; i++) {
-               txe[i].mbuf = NULL;
-               txe[prev].next_id = i;
-               prev = i;
-       }
+       idpf_qc_split_tx_release_mbufs(txq);
 
        txq->tx_tail = 0;
 
@@ -233,14 +225,6 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
        txq->tx_next_dd = txq->tx_rs_thresh - 1;
        txq->tx_next_rs = txq->tx_rs_thresh - 1;
 
-       if (txq->tx_pending_pkts != NULL) {
-               for (i = 0; i < txq->nb_tx_desc; i++) {
-                       if (txq->tx_pending_pkts[i] != NULL) {
-                               rte_pktmbuf_free(txq->tx_pending_pkts[i]);
-                               txq->tx_pending_pkts[i] = NULL;
-                       }
-               }
-       }
        txq->tx_next_compl_tag = 0;
 }
 
@@ -248,7 +232,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_alloc)
 int
 idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id)
 {
-       /* Bounding pending RS to nb_tx_desc keeps the 2 * nb_tx_desc complq from overflowing. */
+       /* Scalar completion tags and vector descriptor indices both use nb_tx_desc pointers. */
        txq->tx_pending_pkts = rte_zmalloc_socket("idpf_tx_pending",
                        sizeof(struct rte_mbuf *) * txq->nb_tx_desc,
                        RTE_CACHE_LINE_SIZE, socket_id);
@@ -261,21 +245,24 @@ idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id)
        return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_pending_free)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_release_mbufs)
 void
-idpf_qc_split_tx_pending_free(struct ci_tx_queue *txq)
+idpf_qc_split_tx_release_mbufs(struct ci_tx_queue *txq)
 {
-       uint32_t i;
-
        if (txq->tx_pending_pkts == NULL)
                return;
 
-       for (i = 0; i < txq->nb_tx_desc; i++) {
+       if (txq->use_vec_entry) {
+               ci_txq_release_all_mbufs(txq, false);
+               return;
+       }
+
+       /* Scalar completion tags can outlive descriptor reuse, so drain every slot. */
+       for (uint16_t i = 0; i < txq->nb_tx_desc; i++) {
                if (txq->tx_pending_pkts[i] != NULL)
                        rte_pktmbuf_free(txq->tx_pending_pkts[i]);
+               txq->tx_pending_pkts[i] = NULL;
        }
-       rte_free(txq->tx_pending_pkts);
-       txq->tx_pending_pkts = NULL;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
@@ -426,12 +413,12 @@ idpf_qc_tx_queue_release(void *txq)
                return;
 
        if (q->complq) {
+               idpf_qc_split_tx_release_mbufs(q);
                rte_memzone_free(q->complq->mz);
                rte_free(q->complq);
-       }
+       } else
+               ci_txq_release_all_mbufs(q, false);
 
-       idpf_qc_split_tx_pending_free(q);
-       ci_txq_release_all_mbufs(q, false);
        rte_free(q->rs_last_id);
        rte_free(q->sw_ring);
        rte_memzone_free(q->mz);
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/idpf/idpf_common_rxtx.h
index 3365631d80..a4843c9f69 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -218,7 +218,7 @@ void idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq);
 __rte_internal
 int idpf_qc_split_tx_pending_alloc(struct ci_tx_queue *txq, unsigned int socket_id);
 __rte_internal
-void idpf_qc_split_tx_pending_free(struct ci_tx_queue *txq);
+void idpf_qc_split_tx_release_mbufs(struct ci_tx_queue *txq);
 __rte_internal
 void idpf_qc_split_tx_complq_reset(struct idpf_complq *cq);
 __rte_internal
diff --git a/drivers/net/intel/idpf/idpf_rxtx.c b/drivers/net/intel/idpf/idpf_rxtx.c
index 0d41cd87eb..3bee388c17 100644
--- a/drivers/net/intel/idpf/idpf_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_rxtx.c
@@ -413,7 +413,6 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        const struct rte_memzone *mz;
        struct ci_tx_queue *txq;
        uint64_t offloads;
-       uint16_t len;
        bool is_splitq;
        int ret;
 
@@ -456,11 +455,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        txq->offloads = idpf_tx_offload_convert(offloads);
        txq->tx_deferred_start = tx_conf->tx_deferred_start;
 
-       if (is_splitq)
-               len = 2 * nb_desc;
-       else
-               len = nb_desc;
-       txq->sw_nb_desc = len;
+       txq->sw_nb_desc = nb_desc;
 
        /* Allocate TX hardware ring descriptors. */
        mz = idpf_dma_zone_reserve(dev, queue_idx, nb_desc, VIRTCHNL2_QUEUE_TYPE_TX,
@@ -472,32 +467,32 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        txq->tx_ring_dma = mz->iova;
        txq->mz = mz;
 
-       txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
-                                         sizeof(struct ci_tx_entry) * len,
-                                         RTE_CACHE_LINE_SIZE, socket_id);
-       if (txq->sw_ring == NULL) {
-               PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
-               ret = -ENOMEM;
-               goto err_sw_ring_alloc;
-       }
+       if (!is_splitq) {
+               txq->sw_ring = rte_zmalloc_socket("idpf tx sw ring",
+                               sizeof(struct ci_tx_entry) * nb_desc,
+                               RTE_CACHE_LINE_SIZE, socket_id);
+               if (txq->sw_ring == NULL) {
+                       PMD_INIT_LOG(ERR, "Failed to allocate memory for SW TX ring");
+                       ret = -ENOMEM;
+                       goto err_sw_ring_alloc;
+               }
 
-       txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
-                       sizeof(txq->rs_last_id[0]) * (nb_desc >> txq->log2_rs_thresh),
-                       RTE_CACHE_LINE_SIZE, socket_id);
-       if (txq->rs_last_id == NULL) {
-               PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS tracking");
-               ret = -ENOMEM;
-               goto err_rs_last_id_alloc;
-       }
+               txq->rs_last_id = rte_zmalloc_socket("idpf tx rs_last_id",
+                               sizeof(txq->rs_last_id[0]) * (nb_desc >> txq->log2_rs_thresh),
+                               RTE_CACHE_LINE_SIZE, socket_id);
+               if (txq->rs_last_id == NULL) {
+                       PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS tracking");
+                       ret = -ENOMEM;
+                       goto err_rs_last_id_alloc;
+               }
 
-       if (!is_splitq) {
                txq->ci_tx_ring = mz->addr;
                idpf_qc_single_tx_queue_reset(txq);
        } else {
                txq->desc_ring = mz->addr;
                ret = idpf_qc_split_tx_pending_alloc(txq, socket_id);
                if (ret != 0)
-                       goto err_pending_alloc;
+                       goto err_sw_ring_alloc;
                idpf_qc_split_tx_descq_reset(txq);
 
                /* Setup tx completion queue if split model */
@@ -515,8 +510,6 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
        return 0;
 
 err_complq_setup:
-       idpf_qc_split_tx_pending_free(txq);
-err_pending_alloc:
        rte_free(txq->rs_last_id);
 err_rs_last_id_alloc:
        rte_free(txq->sw_ring);
@@ -738,8 +731,8 @@ idpf_tx_queue_stop(struct rte_eth_dev *dev, uint16_t tx_queue_id)
        }
 
        txq = dev->data->tx_queues[tx_queue_id];
-       ci_txq_release_all_mbufs(txq, false);
        if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
+               ci_txq_release_all_mbufs(txq, false);
                idpf_qc_single_tx_queue_reset(txq);
        } else {
                idpf_qc_split_tx_descq_reset(txq);
@@ -895,14 +888,12 @@ idpf_set_tx_function(struct rte_eth_dev *dev)
                                        IDPF_TX_DEFAULT,
                                        false);
 
-       /* Set use_vec_entry for single queue mode - only IDPF_TX_SINGLEQ uses regular entries */
-       if (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE) {
-               for (i = 0; i < dev->data->nb_tx_queues; i++) {
-                       txq = dev->data->tx_queues[i];
-                       if (txq == NULL)
-                               continue;
-                       txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ);
-               }
+       for (i = 0; i < dev->data->nb_tx_queues; i++) {
+               txq = dev->data->tx_queues[i];
+               if (txq == NULL)
+                       continue;
+               txq->use_vec_entry = (ad->tx_func_type != IDPF_TX_SINGLEQ &&
+                               ad->tx_func_type != IDPF_TX_DEFAULT);
        }
 
 out:
