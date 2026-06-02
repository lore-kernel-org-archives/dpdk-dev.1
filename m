Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399E4CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A6B6402A9;
	Tue,  2 Jun 2026 17:37:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D9D9640150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 17:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780414632; x=1811950632;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pimVP/IOP3MCEFm11OP2Y3aLZI27LgRHvxt7xFJ/mYo=;
 b=eCzaoNwpc5115Vgt8QWNbTeYcmM9ZpWjqhYoMZdvR1eHPmaClV5kZBDP
 jNBFk60x29ej+nIQlDrUI8W7UVtNKXwWknaB6BvmexsT1NRGZbV0are5T
 THpxgEclIbnFf0wEcmDgJAGDC11ayKW2yLXlouC7GkJgYHJHami++EnBz
 f2vvIcWJteGYXbhaciKwcgTRI9qvA2UXZX5eI/SF84xcJduqL98B3/BFr
 1p+MOKtA/t+aWEr3AGLKSX2Hd9Ir+BD3N0LxAb+0Uu/oXQXsEQIre+YTa
 MUAc1ZoOHIHki5Nq+JA/6JBsgbbT+WKtxL1xy0lCESt7ZefA8xWMBUofm Q==;
X-CSE-ConnectionGUID: LNwaa6BeQlqm0D5aa3GJhg==
X-CSE-MsgGUID: jFLCex3wTFuUl0TNoyXItw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80345586"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="80345586"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 08:37:11 -0700
X-CSE-ConnectionGUID: 0MxjuPtITraWcqfDUlDOvg==
X-CSE-MsgGUID: cKjJaIS8SpSIgJxFkuuZEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; d="scan'208";a="267575701"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 08:37:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 08:37:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 08:37:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 08:37:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU1ub/kdQ/iHVFOVmzRr4tOrXXKAu5dpsFbtVrBohqrftt3V9pZB6t8lVsGaIAvMGF62tgMjd+V7h+1JxGfRtDuwtWlAxY6xgDOTz8DNXcEVLrZrk2otNspauGEsy3b/xsiVqk/7/CcNvF5zZZEFikc1C4TugZ9o8AIfv/EV5W+dXMJDsw6xkwxbtV2iqfTZfu6t+v+Y284hjVkzi58LQ826W2ITxBfmxJBY2rEqWHGCN75SzA/im82WzVGLYCgAdorrxbEgsIFOTF9Nyklmev8WZtqEnRo7mK79yqAgS3NTkyRqLSA91+u32XffKwJV2idnv1xGaFT8tXcDexoXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pZ1dETcl7xv7B2WNXAtqRNtpi7fQsK32DUnGg+YVz0=;
 b=up/8c2UHgRB8lMyhtpAvvoZgS5iMt6X1HTvVcrO5NqTjk1TgKodOlouvAgNek5VTXs6pY8b5Bpw4/7uLrWZxoydFwYIENIOhm7Z4SWptZosfGwckv4j+vHIxK778RZ2ufK4jDlZTWhc1LfEDpV1/ZHoIjGm8/D8NsAcMaymQ4e1yEFgVqbJjgBk01P/tnE9Q3MSdlGWtEd/5Mx9EQelAgtbALMkpeZAhDhf2orhrp1rmIntbHshcA04n68w1tMan2/dGoB294/12r/pfQXmY4s2s+EReEbvSOt/xSrEyDnqe2cZUtWLpIo/0dQ0DheUED5aDfKcbEG2SiudkqH/GnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS3PR11MB9843.namprd11.prod.outlook.com (2603:10b6:8:366::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Tue, 2 Jun 2026
 15:37:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 15:37:03 +0000
Date: Tue, 2 Jun 2026 16:36:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v3] net/intel: optimize for fast-free hint
Message-ID: <ah74mTpWEtIUACtG@bricha3-mobl1.ger.corp.intel.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260519110637.964965-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A17BA228196DB8843D7D6F8E092@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A17BA228196DB8843D7D6F8E092@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0298.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS3PR11MB9843:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d13117-1abf-4704-04a6-08dec0bccafb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: XpA0jTBgavR+XmK47L06lgpll1tPCGZWjTQsFKvVxoMsx/xfcScRt3Xj+TFMM1glG1d5nH+wGCE3hAKUAUUaXawzX90MjRHQDzN+GlfG+ANvRDfkjn9K9236tcat1C2ftZbAhZdWMjlNko7AmNT16cIfuNZiqQfjpe6Ud70XL3zaRtBi8NkU51KT0/rsq5D8us3rWELw0O7592QQrT9WMqfbN30MYAhG8L7x1S1QHk7Sv7AFE76pt3Js03d2lZKf6HwB5cutJ8YJ04Beuenv0s73TD5OLo3XEz0lzgydvCRRhTtfIVSLYf2ps6A8f6UyQvYKVUWHOFBlO9oXNtzcyCaBs/VXt3oV8fti3rfSqDywbhHzapyQRbD6mtTj3V+2MYUyjgUKCV4oRq+GvFVnwpxp5Yks1xz+3RXnG1+xyJi3K3WTxAwYHlXcH1sJ87ZL9ifeQ9KNRG58cKBqYcXnjnHDlkoLGgu7YQ3D0RQ2+lQ4nCsG3Ba2ZqSNpEcJD/rlmU0aKjMtkxKJ8qZmw1uJOiVfZaa6D5j4jG2cajlw1vUU2UGaxW2ZyGpe7dOXHxKcWrpBqtkrm2klWF1WmbCVw6Cw0BZuwTs4r2hZBl6UxFKSmL6L1bIFyyL7J5sXZiQz/gHhQSyo8mxjENz2zz7UDc8fv14bTVUKPn3MZUhOpSf8dMoVZYQbLzuLrm6kHa4j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vbn9LLvavvN1VD2WbXBSTxEfVhHUL4h3Y10lZgWzoT6CBBsDejvdHdsX+60D?=
 =?us-ascii?Q?3q9Ryw0HJwSX51X9fJ4H9p+yfuBbKdiGMejeWUwr8Uw6nbPwZQ5uJO0Y29ag?=
 =?us-ascii?Q?zSsQkFQ79o6PLR8Z1qSg/BX2ewFG58QRdcsO6QGFKXzpqVb6/D6+RLonGMT0?=
 =?us-ascii?Q?UACghmx2gNJC2hhTasU8OWr8SSjw+eYIQIj67RSj1AbN285zkX+2WfPEgzde?=
 =?us-ascii?Q?+HJrFnMKOPKKTVw6FzsqWSxiPG0TNjT21EVz0uRnpQY7LtlbOHjVOH7aSIu8?=
 =?us-ascii?Q?d0jcGjPrtU7W0ZEIsTgxf8BUz6cvYMrozwDfTX+sfhRrqxqvENq5ARdu256O?=
 =?us-ascii?Q?CV2u+ny93z3N2C5Hsn+FlqH1oxBblMY5GD2ZwjM3Pr2VHgZyAVaU9HBcTatd?=
 =?us-ascii?Q?MNOfJUV8gDCqD8hwykWu1BKX1tJNNX3VYkoDsxPJp+HNYG5CFfYni51DApOn?=
 =?us-ascii?Q?TENShQachIkdv5ij21QEP+uSbuUHtM5OTIbdEfcRxGElkvbGGhE3T9eM27BU?=
 =?us-ascii?Q?7ugj2dTAzQhY118231BrRd+ViwJ8+0LjkAWW73b0REwhKZzRIgkInNlF9b1E?=
 =?us-ascii?Q?+vVPYnlNBWCokCAryLTqOj9AGe8pYLUvwTIXikJ6XMVPSrjxlYl9ViIjvsIF?=
 =?us-ascii?Q?k5oyqLK7Awk6bqfU4EBlFTGSA8cJyymqI6mvGncQ+9DKgGjLOm1y3bDY5x5Y?=
 =?us-ascii?Q?bGtTIjmdzFpvhvOclBT41vJXf0uoDq5YAVaAar4hZF+EGtCZuOpjugtW7nN7?=
 =?us-ascii?Q?6dPYw1BXdTzW0AXEV90ZIlFMluYugUrfJxMs5LN2y4df9UMhUAz7dI8snzc+?=
 =?us-ascii?Q?Lz0gdt3HGbtKsrqAXECfZxSGcMNH1XkAJbM5ngCeJJrQ7VUDBVocImhde0A/?=
 =?us-ascii?Q?mLdEXfioPPGBGzK9cI+QHjHmdmQF7lvYzyy/HDYIKzDisLjyma7i6z1ISV63?=
 =?us-ascii?Q?1Wm9xYneAv0S7RxZUCqieblYCicXLlQweimbN0N500WLgabmg0C8ulvYfb16?=
 =?us-ascii?Q?zwg1+oFlvZwlUHfOUELmHQUcZWljstACfQ8lEmwI8nKHyUrcT1E8WauChElK?=
 =?us-ascii?Q?Azt46brES2iZdLsveVbrqMLixwHvoX9JhxDSAv/sdgJ6k3H+4ry7t/kZlk6P?=
 =?us-ascii?Q?+2V1fmZ3eXJM0iDOF+2KB7o92j6FPSlGAGVREWFoWQGYwC1UDSH1Wm6/0LY+?=
 =?us-ascii?Q?p/fLS8gALnUZRY6iCbK4b0EaLCIPYlaDMkoCf4vr7tkW2seCVnLFnxbhm0uF?=
 =?us-ascii?Q?Ii1YlIdaVdwJLlt7+wi70LzoGvl+j85HuP/UkFENpE4X+OVVNR7VrE313Bbo?=
 =?us-ascii?Q?jlvDuJ0Hyk8MeFXSPHT5FQ5Rf4yEj46MuLedWThZlSF3Hw8BOMqnaw0wzJso?=
 =?us-ascii?Q?OnvtxAqkBGzxfZILKMVwDoNtlGq0GwvEOPTPfJR1Y12sSALmKKzJ5AuJ2dBf?=
 =?us-ascii?Q?6F+WSvt2Jp/1TaAx9v9X5MFtvVJjZHFrQPVgXcJ6QYqlspLv68/BnMjQ0C0l?=
 =?us-ascii?Q?LPBj62FCTxOTqAwoPepWj4YSfAFG93COI4btKagUZAWiHOGOAqKugUHuj6g8?=
 =?us-ascii?Q?y6a+aoOjrE6quurn8b7iTprx9cv4uXwKRlDVH/zRQ82KukxfaHWhPXoS5ocO?=
 =?us-ascii?Q?0J9R9Hu9AUijUOGy72NhuxtSF30j0V1rmHQ9sqzw8BSq6F60P1gitSAMO1XQ?=
 =?us-ascii?Q?IG61hbR20YpiPfAfF1PT3HnepcsLzNb1pAfuLZ0Qwt4Y3RZMMBCUF7TAcGEf?=
 =?us-ascii?Q?LRJiVlw1hXp7lYWVyp6Tb3wXDgenPaM=3D?=
X-Exchange-RoutingPolicyChecked: Oj64KWkL1jPxUJqIE20V5TSz/8h5pBjNt+F3a+w7EQmbOyJU+m+QMgFCXKpJ3Tum9ghzWaPZrKK9hD+vgbLl4i0xCV2BFOvOfu8H5+cyGUXI/91tRb8Cx39qkInnrtPWQeOQilGNoPkzBTYucU/re/oShFSYAJROTfzUHSppVBzK4GPRKqd8VZ9ULNddWkNhVTI0Qm6NEfBprAC/UC5z/ySFAY4ZUz62hyYA+BehAwLAZ0fkuwQTMKpPiMbsg1haae7aJq7v4fhDtjTEEna6hy++oSDUAkjviVq6hXQ0T2iNbR17HMVaXC4dfVCeTqwrZ97rTG7ZtQnFGMTWooUVLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d13117-1abf-4704-04a6-08dec0bccafb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 15:37:02.9482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0GF4INVAy5R8/B1fpg0ZjpWHIJNY6N0ex4PFTp8QhAY4WdYpJP16OH2UMvtx+5JgJc5mcOIbHto2nW43Rs8mkEVIeX3gDULmr0H2FxZQdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9843
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

On Thu, May 28, 2026 at 02:23:00PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH v3] net/intel: optimize for fast-free hint
> > 
> 
> snip
> 
> > diff --git a/drivers/net/intel/common/tx_scalar.h
> > b/drivers/net/intel/common/tx_scalar.h
> > index 9fcd2e4733..d27df34dfa 100644
> > --- a/drivers/net/intel/common/tx_scalar.h
> > +++ b/drivers/net/intel/common/tx_scalar.h
> > @@ -197,16 +197,64 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
> >  	const uint16_t rs_idx = (last_desc_cleaned == nb_tx_desc - 1) ?
> >  			0 :
> >  			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> > -	uint16_t desc_to_clean_to = (rs_idx << txq->log2_rs_thresh) + (txq-
> > >tx_rs_thresh - 1);
> > +	const uint16_t dd_idx = txq->rs_last_id[rs_idx];
> > +	const uint16_t first_to_clean = rs_idx << txq->log2_rs_thresh;
> > 
> > -	/* Check if descriptor is done  */
> > -	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> > -			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > -
> > 	rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> > +	/* Check if descriptor is done - all drivers use 0xF as done value in bits
> > 3:0 */
> > +	if ((txd[dd_idx].cmd_type_offset_bsz &
> > rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=
> > +			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> > +		/* Descriptor not yet processed by hardware */
> >  		return -1;
> > 
> > +	/* DD bit is set, descriptors are done. Now free the mbufs. */
> > +	/* Note: nb_tx_desc is guaranteed to be a multiple of tx_rs_thresh,
> > +	 * validated during queue setup. This means cleanup never wraps
> > around
> > +	 * the ring within a single burst (e.g., ring=256, rs_thresh=32 gives
> > +	 * bursts of 0-31, 32-63, ..., 224-255).
> > +	 */
> > +	const uint16_t nb_to_clean = txq->tx_rs_thresh;
> > +	struct ci_tx_entry *sw_ring = txq->sw_ring;
> > +
> > +	/* fast_free_mp is NULL only when the fast free is disabled*/
> > +	if (txq->fast_free_mp != NULL) {
> > +		/* FAST_FREE path: mbufs are already reset, just return to
> > pool */
> > +		struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
> > +		uint16_t nb_free = 0;
> > +
> > +		/* Get cached mempool pointer, or cache it on first use */
> > +		struct rte_mempool *mp =
> > +			likely(txq->fast_free_mp != (void *)UINTPTR_MAX) ?
> > +			txq->fast_free_mp :
> > +			(txq->fast_free_mp = sw_ring[dd_idx].mbuf->pool);
> 
> Is the mbuf you are dereferencing here guaranteed to be non NULL?
> 
Good point. It almost certainly is, but checking through the logic of the
code, the one possible error condition is where we have the last segment of
the packet being a large segment using TSO which is to be split across
multiple data descriptors. In that case (only) the mbuf pointer can be
NULL. In all other cases, it should be valid, because the DD bit can only
be set on a data descriptor.

Rather than trying to fix that issue here on cleanup, I think the better
solution is to adjust the large segment handling so that the last
descriptor of the segment, rather than the first, has the mbuf pointer.
That way we can always know that the descriptor that has DD set on it will
have a valid mbuf. Will implement this as a separate patch in v4.

/Bruce
