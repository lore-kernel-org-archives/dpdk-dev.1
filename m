Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD28CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D824060B;
	Tue,  4 Nov 2025 18:28:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 675854028C
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762277306; x=1793813306;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=S6K3Z11IO/Qnrq/sWy44mI5VdLR37rhI02W8LyiiWHA=;
 b=KxoIbzTqv5WXfpHiVM9sumIlVl/nvESptjlYDk6S1vv+NtBqCPS1slDM
 K93I5HieudyYw7Ychxttxn6irx8Dfe4SleXhvCyV+0R+hBhXFsnXMvxSg
 HQoYOVdfmZVPATw2UPOuXSqxesnMN+jzTO+wEPVyAaBdTRU5tGR63JrRj
 1BhDXNW6GxfGw4JnTrM+hkT9ZcHdeM3R3HeYfqybHN7gqyKfO4dJQmUy9
 grsxfllWQM8wFnxJM0M4hlwKp8Ae6uup4xL16fi4wlzA2U+hbRE3RjMPp
 dyUixaxk2zPggzGQ4NJDGTPv6FydhhKjNTgxJR9rufMzYMqnn6VAZjOdQ Q==;
X-CSE-ConnectionGUID: xNX6LtMSQQui7QrsyzDZlQ==
X-CSE-MsgGUID: YbOwxrQSQDWsIzhqJmTcqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="66995618"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="66995618"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:28:25 -0800
X-CSE-ConnectionGUID: RutnqDk/QEmNdaQxE7Il4A==
X-CSE-MsgGUID: ZWTiNdCXRi6Ql/HRhtWT7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187662097"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 09:28:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:28:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 4 Nov 2025 09:28:25 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 4 Nov 2025 09:28:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDiJ1o7CGYURMO2aicvXVCyNRROfmOCs6w66/owfklgeqI/mmByXWp7CJna8eNFdw4e/Ncpi6F8PNf9SDIdRo6Q5hrpBg47lxxUvuLYuQjqLz9QnD7eB5nl54S+Ds0wv5dFZALwXPS8pbAUKY8aN/k+uoXF2fC7fY65Grn57h8zsx70PgsHmtCImrDR3ke/aDr9r1WRCdUCPtJ5nai/dyhllcloOTs3bTG+zOIkVUf2dwQhrhWqInea6QR7s6eJSZGDglMG+lznwEZIScI2pJcRXpbHnboxMnRXeVZFF2avR2Fg+/KAKNyPOdJhHmRslVA9aRoJKbeV0MdYGcZJaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRqvKh/PZ6bRObc5Z5rWLKpWaIlbjPLlBy9LDGSpvrE=;
 b=Xr00DZyuRDnzhE3ECqnyZG3wl+JeZvKs78VUOFrYpY05j4zPuNnsWC5KwNNYaid6gjbfIAll6YCATjA75CHzE6diYG/Kcgc3TooqpNw02EwMSC8hGTJqyg+ETTWHkz65DRBeAN1EUNtY1qO/1LHuPMB5y1F72zvroaWJ9CwGqGlQr6XfybqlV7tmVP3y3TT5sRRQpHqX6L8hxbLpKWWQWT52Y9if6Sz5apV83RuFtvFdR52ed8lLloOjC7ghSGock0npLrLT1nSbOcSqPIh0AEhQad8sC6w60npY7B1y3FO/q+w7obMLpvwn/jlfqPkQKoH692zG3Rv/gVhQk3tuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:28:23 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:28:22 +0000
Date: Tue, 4 Nov 2025 17:28:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] net/iavf: fix single VLAN insertion positioning
Message-ID: <aQo3sVWdZuxxAmgh@bricha3-mobl1.ger.corp.intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251031152250.2441980-3-ciara.loftus@intel.com>
 <aQo2BiGru17VyD_j@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aQo2BiGru17VyD_j@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0229.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::24) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4bd73f-c8bf-4e99-0b30-08de1bc78daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/6zmjGB+C9QmaghmEv1Qxq00lrWaZTYijHVWvK5LELRc9a882tR7VZVbF54?=
 =?us-ascii?Q?KDWAEADycpm5AkIoI5nZfgcpwoWrwUurT8Kdjmk4DFqpDe1TmCGJe1LFdk4U?=
 =?us-ascii?Q?mKNzDGg0br2/4wXu1rOsT68Bp6WlazmARUOpiVdhn8aGok4usGURrijw/nWF?=
 =?us-ascii?Q?PcSqM6bjrRfRdqAA2HgULflw0S10YUalWAN4HNF6PjNXNPn86tN/GaL6AKxb?=
 =?us-ascii?Q?zBSMyhtZyhb3A8WXFRUrEMsEoKC1rTNRqVUIJYWKLxLMiC7rOInET+SG589d?=
 =?us-ascii?Q?cfce/8OwXI8YyihNsjYnZ5lfEQ6JqeUw8eCJ3W/N01nbw4c3AY4Nkyepj9g7?=
 =?us-ascii?Q?HHtpTR047Tr7CqevxFLmwVJVO5LNZRLj+qNA8frJXDEZO7T9Xq3YPWM22DOs?=
 =?us-ascii?Q?ukyNfFkatMSBCjNWsfDuXJ74wJ1hC8oGN+KP3EhWSU1TSSQ34gn3jlZDNaXZ?=
 =?us-ascii?Q?/yQuKrjHEK/8jPTFZWGTjZx9mpuqhHhalb5g3hoDE+XTjreMk5JixD4glwpu?=
 =?us-ascii?Q?e1E8beFjbPH6zgFN03AMcMHyC/fSxfQQs8lKAZ9UsSAWJPhbFyMPozShhbQC?=
 =?us-ascii?Q?K/y4FkEz51cQWQ7a8VzIX0AJyWlYJD7mvVa6+rA8nL9rMCLNTEczN5GhsbdT?=
 =?us-ascii?Q?05/ZlWGqUFMziSlgFf0LPqqRykSZCK0VRoXHr+7X7yNBCTyvrkBl5VRCYvJL?=
 =?us-ascii?Q?EcEp+gF1k+BYI7xdKf9DUS4TRa6McKIOOwxSaqONmJhWQ2miYe1XTyFjz6bC?=
 =?us-ascii?Q?xg4lTAtUYUEsOKDKBNhgx/xJ/SZ4GJB8C/O1AzQW1zoIMqq/plJPKy9rhDlO?=
 =?us-ascii?Q?N7zwuTr5/K4XlYl0IFsBDc/TeT+gdYIubPAJgwDdy1yJyljdwISclJ2EuM5i?=
 =?us-ascii?Q?XizGQwT8fEtKQjS0XQeFn0MuiTNa4X7+pVut/HDztm4DmIbqVyQd4mAD5iOb?=
 =?us-ascii?Q?721243BgntdTNmgB9oxzXs0kj/5Gv0khV/DdtzxlsGT14uYqSBr0BU8+NsEC?=
 =?us-ascii?Q?rc+u5ki0bTEJG9a242nqX/eRmLZh5SkbScIDTF+igDn/4AsDRiHjP23nmKuC?=
 =?us-ascii?Q?LvDQ4IUDFlIgjHJZeYUf4DsSAgM4GGUJZkiJ8LsdrtXL//xiOJR3Yr2fegae?=
 =?us-ascii?Q?5GwqUTThHjghL3OsACkDwFKU9vnhEy+rs7bXo6Ai/OdXgUfq7JKEFkF+VIFz?=
 =?us-ascii?Q?ru9yjGWuXZ3EHWwTReMbWiruwqcvIPNFhuyr8RJP3jEEUQlS0bkaQdA8TTS9?=
 =?us-ascii?Q?taQ13QjUSS8l25OOUcJoNb54ooNBAAsozPUMKx7NFOvC4ceOww8bTIjEW+CD?=
 =?us-ascii?Q?IK0s+9ooi76dgshCAZDRB7XGqLOJBEI+IwD0eTgCRR1wDJPht/mhOOOLu9rX?=
 =?us-ascii?Q?lIgKGgdfI3DsUP3+bIMMYBZbfzDQfpnYPyzvkWkJwQI6SsnX1QsLT0qJlc5i?=
 =?us-ascii?Q?VKCAzbkYeX0tkSe8Mjn9fts7fuW83pKo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zkeog6ziGAFMW55uGzkJnW4I+8AjkWqv3asXcLWGzVwH2LLB+bCDJNDbr/uV?=
 =?us-ascii?Q?o9Y5trw4K+jmAOBrXiW1iOKJyh/fK6pnzH014Ww9CSgyBe9t5CKSuJAt91fX?=
 =?us-ascii?Q?SKjFSk69EbQ4u5QorH/8cgf8wS9Z5/Ndil+1zWHUe22LMg0TCmr+k2K7vHMS?=
 =?us-ascii?Q?uuzjA0VE/EOCcQ3DMnYtSy+iYIR6diRFOdCXmrEMwIIQvz1OYZl9/IB5les+?=
 =?us-ascii?Q?zJA3fawQL0INOqSnXf49ecaoEoDGlnQUL1sx5nxS4jRgbrH2qVbD0XjdEplu?=
 =?us-ascii?Q?1I3/grSOkoGT8qFSrvB9eMRNYBbLaT0NgirJhwnDaPKEDNuBqaOI9KB/2Khq?=
 =?us-ascii?Q?LmN0e8NCWr1ncamOn+93Gez0drZy76bZsu3h7LdtdDPk/6dIdiBkRMMg/Se0?=
 =?us-ascii?Q?axmc1fdOvpN40/BK/Rw2A4MQzutqWo6FkpDiYYBag+RnwMBjLimrwQOoe41F?=
 =?us-ascii?Q?IQeFWkLmXrXTq0pkX12eyGbg9/NbP9jnmWsL7MGpqY/A+Q5BRxQhuOyYiTXn?=
 =?us-ascii?Q?ZKzI3PLJjlmP9BI6QUOt0SJ/Tynjk0OQvTVW3uuTWp8epWc1fegyJ2JWyT97?=
 =?us-ascii?Q?42EPE9RNgfqIlU4jxtLOTZGdtbC6oMAa0GNyBwEh5XZnOp0Neaszk97SQckz?=
 =?us-ascii?Q?9WChcCN9lv3PGrogpE2d24QgvviZXInvQ07tQqUVkXudUveORsmVnk0g25dh?=
 =?us-ascii?Q?fox2DKVj/GecHv/G3ry4BRGToDJlHqbP38h8fwfFdkmHS6/yHHfmf2jY0dXv?=
 =?us-ascii?Q?RY2ixKg7NApDEyuE+eKe6nCnhICU7sg2n0pVnioW9EB5+rvVEtboXy+LmuCo?=
 =?us-ascii?Q?MGDOCYS/I4LuAxMaCoWV8hEUlwVbQxzS4bViTjv4ft60PO5F0XN6o1i+h3wi?=
 =?us-ascii?Q?7vOEzWvSm8pSRNhcVcR6QsuubuBwTWmYrmXACkqvtDFBSn61D3jXB9MSQCaa?=
 =?us-ascii?Q?D7RnTR4TMgx5SPyKo3vC3q+hxrEkRqanQOJdeNo24nD5DK7FY+JYlW2Gtn45?=
 =?us-ascii?Q?O+aRLQw8qolpEMU/oWWyWBO+FYqhSlYD4xJ4OTB5G5aItahLCVL5DDBlWP+z?=
 =?us-ascii?Q?wpx3XVsU6yCRprWGXHk5OV/3kbLMDRzd/Jx+H8EMPl07Wa715GWtfY/8Jsnf?=
 =?us-ascii?Q?hjvFf+1wwVbDf+mbOdM8EUoIgc/vwN0PTGAeyYIJbRuE1t/be7mQIgI433zc?=
 =?us-ascii?Q?Kgy9rEh44g82v2LYRzH2UMNEtucV8lD78n0NfctI0mqdE/ZOOUdTeEkiujYy?=
 =?us-ascii?Q?rnOxsbtH6+txZin4vYqiqZmpuLsxPEdEXPRvmYEK98epcHCFgVD4ufV0outg?=
 =?us-ascii?Q?nYd5/gCTbwr8iZy22fAgX7y2Dy8KFXTEJL8PA43wTpO+aeWodvkWoa3IHcYj?=
 =?us-ascii?Q?zc6xtKBCY/6le1Ugy1CbOvuPzsRoFXF69mt/5H6ypG8hCvoCD2RgudnW31jj?=
 =?us-ascii?Q?9+st6WEowBhQk5Jx+l1OPwUwOk+U8kbLRk3hqQz2Tlwmp/6sOJYP9hHO6r4V?=
 =?us-ascii?Q?13O9r5n1MjPNKkQ3LMNxxyQTEqAPnWtmcTyUqViPvWiNYJHUPMIcafJo9V3T?=
 =?us-ascii?Q?RgRtgbL8HKtG3BZaQiaMRqJSlXXTv0Bdiyej37KvfG/Pp2mWoDqOs8NoNua3?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4bd73f-c8bf-4e99-0b30-08de1bc78daf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:28:22.6231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GTZHScrCKWn3G5yKTaZSnjFINsBV3RiXBHNFvEOzlsFdydPulELsM2yqJoVWPeoY3Lhuwam/0T2GSLBQvk5sYm8DG+8gXNvfyw+/LlWmGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
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

On Tue, Nov 04, 2025 at 05:21:10PM +0000, Bruce Richardson wrote:
> On Fri, Oct 31, 2025 at 03:22:50PM +0000, Ciara Loftus wrote:
> > Commit fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar
> > Tx") broke single VLAN insertion offload in cases where the v2 offload
> > capability and both inner and outer insertion were supported because it
> > caused inner VLAN tags to be inserted instead of outer.
> > 
> > When an iavf tx queue is being set up, if v2 offload capability is
> > supported, the driver queries the insertion capabilities and takes note
> > of where VLAN tags should be placed in the transmit and/or context
> > descriptors for insertion offload. In the offending commit, when both
> > inner and outer insertion was reported as supported, the flag
> > "vlan_flag" was changed to hold the location for inner VLAN tags.
> > However this caused inner VLAN tags to be inserted in the case of single
> > VLAN offload which is incorrect behaviour for this use case.
> > 
> > To fix this, revert the "vlan_flag" back to holding the location for
> > outer VLAN tags and update the datapath code accordingly.
> > 
> > Fixes: fdc37964c2bf ("net/iavf: support QinQ insertion offload in scalar Tx")
> > 
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> 
> One suggestion inline below.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> 
> > ---
> >  drivers/net/intel/iavf/iavf_rxtx.c            | 50 +++++++------------
> >  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 24 ++++-----
> >  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  5 +-
> >  3 files changed, 32 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> > index a3ef13c791..66f718424a 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > @@ -799,32 +799,17 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
> >  			&adapter->vf.vlan_v2_caps.offloads.insertion_support;
> >  		uint32_t insertion_cap;
> >  
> > -		if (insertion_support->outer == VIRTCHNL_VLAN_UNSUPPORTED ||
> > -				insertion_support->inner == VIRTCHNL_VLAN_UNSUPPORTED) {
> > -			/* Only one insertion is supported. */
> > -			if (insertion_support->outer)
> > -				insertion_cap = insertion_support->outer;
> > -			else
> > -				insertion_cap = insertion_support->inner;
> > -
> > -			if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> > -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > -				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
> > -			} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> > -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> > -				PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
> > -			}
> > -		} else {
> > -			 /* Both outer and inner insertion supported. */
> > -			if (insertion_support->inner & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> > -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > -				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG1");
> > -				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG2");
> > -			} else {
> > -				txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> > -				PMD_INIT_LOG(DEBUG, "Inner VLAN insertion_cap: L2TAG2");
> > -				PMD_INIT_LOG(DEBUG, "Outer VLAN insertion_cap: L2TAG1");
> > -			}
> > +		if (insertion_support->outer)
> > +			insertion_cap = insertion_support->outer;
> > +		else
> > +			insertion_cap = insertion_support->inner;
> > +
> > +		if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG1) {
> > +			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > +			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG1");
> > +		} else if (insertion_cap & VIRTCHNL_VLAN_TAG_LOCATION_L2TAG2) {
> > +			txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2;
> > +			PMD_INIT_LOG(DEBUG, "VLAN insertion_cap: L2TAG2");
> >  		}
> >  	} else {
> >  		txq->vlan_flag = IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1;
> > @@ -2600,12 +2585,11 @@ iavf_fill_context_desc(volatile struct iavf_tx_context_desc *desc,
> >  	desc_qws->qw0 = rte_cpu_to_le_64(desc_qws->qw0);
> >  	desc_qws->qw1 = rte_cpu_to_le_64(desc_qws->qw1);
> >  
> > +	/* vlan_flag specifies VLAN tag location for VLAN, and outer tag location for QinQ. */
> >  	if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2)
> > +		desc->l2tag2 = m->ol_flags & RTE_MBUF_F_TX_QINQ ? m->vlan_tci_outer : m->vlan_tci;
> > +	else if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
> >  		desc->l2tag2 = m->vlan_tci;
> 
> Minor issue, but the expression of the logic here is different to how its
> worked in the previous patch code. There we check the QINQ or VLAN tag
> first, and then have a condition based on the L2TAG* flag. Here we check
> the L2TAG? first then switch on the QINQ flag. Can you maybe rework to have
> all conditional checks for this consistent?
> 
> > -
> > -	if (m->ol_flags & RTE_MBUF_F_TX_QINQ)
> > -		desc->l2tag2 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 ? m->vlan_tci :
> > -										m->vlan_tci_outer;
> >  }
> >  
> >  
> > @@ -2660,11 +2644,11 @@ iavf_build_data_desc_cmd_offset_fields(volatile uint64_t *qw1,
> >  		l2tag1 |= m->vlan_tci;
> >  	}
> >  
> > -	/* Descriptor based QinQ insertion */
> > +	/* Descriptor based QinQ insertion. vlan_flag specifies outer tag location. */
> >  	if (m->ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  		command |= (uint64_t)IAVF_TX_DESC_CMD_IL2TAG1;
> > -		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci :
> > -									m->vlan_tci_outer;
> > +		l2tag1 = vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1 ? m->vlan_tci_outer :
> > +									m->vlan_tci;
> >  	}
> >  
> >  	if ((m->ol_flags &
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> > index c800ae29e1..6f150cb1c1 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> > @@ -2136,17 +2136,17 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
> >  		if (pkt[1]->ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  			hi_ctx_qw1 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > -				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> > -				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
> > -							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > -				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
> > -							IAVF_TXD_QW1_L2TAG1_SHIFT;
> > -			} else {
> >  				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
> >  				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
> >  							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> >  				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
> >  							IAVF_TXD_QW1_L2TAG1_SHIFT;
> > +			} else {
> > +				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> > +				low_ctx_qw1 |= (uint64_t)pkt[1]->vlan_tci <<
> > +							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > +				hi_data_qw1 |= (uint64_t)pkt[1]->vlan_tci_outer <<
> > +							IAVF_TXD_QW1_L2TAG1_SHIFT;
> >  			}
> >  		} else if (pkt[1]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > @@ -2166,17 +2166,17 @@ ctx_vtx(volatile struct iavf_tx_desc *txdp,
> >  		if (pkt[0]->ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  			hi_ctx_qw0 |= IAVF_TX_CTX_DESC_IL2TAG2 << IAVF_TXD_CTX_QW1_CMD_SHIFT;
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {
> > -				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> > -				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
> > -							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > -				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
> > -							IAVF_TXD_QW1_L2TAG1_SHIFT;
> > -			} else {
> >  				/* Outer tag at L2TAG2, inner tag at L2TAG1. */
> >  				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
> >  							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> >  				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
> >  							IAVF_TXD_QW1_L2TAG1_SHIFT;
> > +			} else {
> > +				/* Inner tag at L2TAG2, outer tag at L2TAG1. */
> > +				low_ctx_qw0 |= (uint64_t)pkt[0]->vlan_tci <<
> > +							IAVF_TXD_CTX_QW0_L2TAG2_PARAM;
> > +				hi_data_qw0 |= (uint64_t)pkt[0]->vlan_tci_outer <<
> > +							IAVF_TXD_QW1_L2TAG1_SHIFT;
> >  			}
> >  		} else if (pkt[0]->ol_flags & RTE_MBUF_F_TX_VLAN) {
> >  			if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2) {

On first review, I missed the fact that you were also changing the logic in
the AVX512 code paths too. Since I don't see the update to the ctx_vtx1
function I assume that the previous patch updated that correctly the first
time, and that this patch corrects the ctx_vtx function only. Is that
correct?

In that case, I'd suggest that this patch should come first (or else be
split and put this AVX-512 bit first), so that we correct the ctx_vtx bulk
before adding the new and correct ctx_vtx1 implementation. As it now
stands, after patch 1 we have the two different ctx_vtx functions in the AVX512
path behaving in reversed fashion, which is rather strange.

/Bruce

> > diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> > index bf8faf3632..86523a7d2b 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> > +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> > @@ -227,11 +227,12 @@ iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
> >  #ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
> >  	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
> >  		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> > +		/* vlan_flag specifies outer tag location for QinQ. */
> >  		if (vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1)
> > -			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> > +			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
> >  					IAVF_TXD_QW1_L2TAG1_SHIFT);
> >  		else
> > -			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci_outer <<
> > +			*txd_hi |= ((uint64_t)tx_pkt->vlan_tci <<
> >  					IAVF_TXD_QW1_L2TAG1_SHIFT);
> >  	} else if (ol_flags & RTE_MBUF_F_TX_VLAN && vlan_flag & IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG1) {
> >  		td_cmd |= IAVF_TX_DESC_CMD_IL2TAG1;
> > -- 
> > 2.34.1
> > 
