Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E350CC7115C
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 13:38:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ACE242F04;
	Fri, 20 Jun 2025 15:38:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 14032402F2
 for <dev@dpdk.org>; Fri, 20 Jun 2025 15:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750426682; x=1781962682;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GvyT3rtR6c4IuP6WX2MLI/sKx69CDYrT6n2m+ofzZ0s=;
 b=GfBiRJgL2hjzr5e+xmz0PRvK4GMiXwbCMH7+oSsfyC6LJKG5mmRBeElB
 DsCvRozvCH457EKv8Juk1n9VS31ezVs0VlkZAh3ihpmZnwMwo1MBzRsBg
 sK0AgjJfdzUCUBEKsjf87c8Ge5zLbH8OM6XMjWtFFH8oAa8LFp+Vnnl4m
 zvZ27337hLFKWrjRWvvwrAXAnr4XY1voqyrVG5AvKzea6o1KOy7YDK6vt
 xeQPE+SW8+C8iNUEjR1iJpCvIKKgowobLerRxf+sP/7aftb9+YkRfTNGz
 PwZrIhyd1jo5vUfJQQthBBauvQpLcUHPOVhJZORYUWmaccvahPaDCCWNe A==;
X-CSE-ConnectionGUID: x/KOup70Ss6heg3yrdyXEA==
X-CSE-MsgGUID: /NtAu2saRFmoeTZAX/klsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63296202"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="63296202"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 06:38:01 -0700
X-CSE-ConnectionGUID: NUWE+PVZSleMy/j09wH1gw==
X-CSE-MsgGUID: BbY8mbR3RUWgPDjHxejBoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="155466464"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 06:38:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 06:38:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 06:38:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 06:37:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNfB9uD6RFjJdZYZJQ1JlVSkNWUq+qpY8bBnFWnwL/sRcgPZVaHFPHNXxW7pU6FhZmoMo+2Gu2TXvro2FtjPn5ffADeYCN1c7P/6McyQC4T/qtXyvflbbBW/+WbFTuCrbBwWQ9KtykrKCFnAV9jabYw2UxPwPVEVUMUmD9UscB7VH8BNKuWLirqgN5Jkl7NolbJl9O0eBze95WCwCGEwbgXr5yGmlnqaDM/28YDTIrR9vfDkdwjqO51+dlYkJ56RsbeQwUn0P/7mkcoIz9Ig9XN7TNjkNNNgbDfbY6LBX138Pp83TeBn702zhvM7P4o5Cn5+ZaHD1iJ+bvdx3fA8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPQkqR3Pfn598HVkRza53nbQo6Ru5WZuLF9HTGnFBe8=;
 b=mtWC0wjR3dF2ehFvyJj4ZCOpd/vXk3CcucWYQJhEBuI3gi5nF/fBM8AcDA5FYqGDEh0MVS3P1oSQztbHiGn1wezWz5zGE37UdEKs+KUWf5LI/YLbbOD0EsJczcIXWsh7d9Ja8WflB0XCm5VarZh2G/X2q5yxTWWRNKwumTu+Lmi+O5tCsTNwCoGg0+0x+dzqpwGEMtKoJO5gWogMJ9p89ul4t1OXRa1OVZKizLVo4YYBAMkAChVPkJ6EOMOzs/D8nCFaK74MFRYiomolLC6A9B0IYk+nwQKonPI6UXP2j7k8NCrqK4LV4TtWqAZn6jBVkEZ97KeaiIdXUcXUblPLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6509.namprd11.prod.outlook.com (2603:10b6:930:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.31; Fri, 20 Jun
 2025 13:37:58 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 13:37:57 +0000
Date: Fri, 20 Jun 2025 14:37:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] memory: handle invalid socket ID's when allocating
Message-ID: <aFVkMQ6jc27mTJG2@bricha3-mobl1.ger.corp.intel.com>
References: <4e785f17154922f775c56558947b2f967f25b23c.1750426216.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4e785f17154922f775c56558947b2f967f25b23c.1750426216.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abe37bb-eb07-4e69-e21c-08ddafffab03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e6gNTVGM+mQLA45nuOJtADpYcz64wCwcVBzBBq2vPUkQnLXQtAtwTFoAb+VY?=
 =?us-ascii?Q?6OsGimx1ejGGClR+oWxzUME/erpX5VTZ57NOfwZIlguw8xneCKuQFbRNtGsS?=
 =?us-ascii?Q?ZLT7IdQe0v1+DC5dZrffvlf/NxApznGvKk9gH5uWK+2bTJkF8xhCnApneMhu?=
 =?us-ascii?Q?S+biTrgIczfd76FPqKQRv1smmz39+UDeZ2pn3G2CSAlFIyoGJdGGqiHON9rm?=
 =?us-ascii?Q?tvlj2Y8ZKQjqrE6lU/5BP2x5sAleT4nN7kNmp9cut3zhjL+MG3IRbqzSU82W?=
 =?us-ascii?Q?bO+GioFMcc6TVu5iuOVOgzDBhNfoIEVcpZldDKWaNf4OrPQ/lnq72yR2jO0d?=
 =?us-ascii?Q?C6KMBT19C1igBRdeMJ/0V3q8x6kgzL1es09I6jwKE+UshWgfsRZMODWwZJZ/?=
 =?us-ascii?Q?o8F2ClCQrWES4iNDUblYTihxclq/F+S2FBAsU0y0C7w4IPk36uskQzV1u0r7?=
 =?us-ascii?Q?QPDo1VzDTTBxNxrG3TxTRUrhokcaHdz6s5pP5gvxkWxDvb0n+ZPvH6NAZuML?=
 =?us-ascii?Q?7qmg2QJF7rzkODxU/ZrE4E98t4+WKGSUz2jmgXpwjvf/AddvkCEOoGlPvUFh?=
 =?us-ascii?Q?bWwD0WCW/h+GfIegRn+XKqccQ07Ov0DTmODu3bI3inBsJ6VvWQXYEvFYwCSP?=
 =?us-ascii?Q?gE4xZq4Os9JghCZ1WPE7iw+33+qJOogq3KMRlSDha0Vh//TxuLeEVG9pG9wT?=
 =?us-ascii?Q?LJ9FzG16uwWdLH5h8XqwONzZ2rvwkWKlSy1jg5nfkpHEJwwz5twMLTBYjg8b?=
 =?us-ascii?Q?HuieF00v4Acr/tLkVvZVIwrvA8ObUczu3YdT01UKkDqqIzqg5TTAY40fEp8D?=
 =?us-ascii?Q?Qmlm/QUlDd7dSGdTXP/1mjVafdB6+Z1T8pVZuv3l/iQfPkPGkdCeNv+cF8Gc?=
 =?us-ascii?Q?HReHdYu/IiJtIpvJZgaYUQm68EoCexP3YkkZ/3D+E1Yjot+omYJDv94Xs4q+?=
 =?us-ascii?Q?09uUVieaBpMNS9gnPNZtk6R2hn7t8ylienxAkXmVTIfEBbRnMUsvTnbjePix?=
 =?us-ascii?Q?ARXHJF3rIK2stuYk/5cr80j9LerRAKlR26lpe89zNstiVsKa4qNjLF/IbHsA?=
 =?us-ascii?Q?SbFlbzGo43tkgZAd8+bT5HiYt8/UNhNuqUbMw5MDJ7EvOdrT74f015gKSYBr?=
 =?us-ascii?Q?ITqWWBH5nDIIa5kLWnMbDIwqazE+B7amZr0Lwf9W4k7dX+OCsyyikhSJWdCH?=
 =?us-ascii?Q?TMq0TepF3U1RHuILdsGVeFTRu71XdyTqgnu+rcJI4Nncg3ww7EEWWu+49Y87?=
 =?us-ascii?Q?duxJHwp1bRJc81rN5NuN2tIivmcQFzBEXuGuDt84femgXk06OnoH+2ACv1Pz?=
 =?us-ascii?Q?gjcJapLB/GeuOfHPeg2ovq6qPHlYYehCJonhr1WS49WH6Mc3M8yq4g+gw2TN?=
 =?us-ascii?Q?C1xt41Q6xeKdGRM7gMyNfszeZEqcbogWNhbM5nqjXowIe7dYrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dVLKoKQDLKxy45o4LGvBwGZmDKxtOwFuf+ht/VSeo0rWW6e6deFBtYQri0Lh?=
 =?us-ascii?Q?U8hs5eZzxHcs2+s73IVEBdHJ9ZFps8/bMJErGVt+5AX1G+oezKtHWeySBpl2?=
 =?us-ascii?Q?qd6v4gBDw+E2jdA2s/Diz6c4/ha0jDlKEX2e3VWh0JQMRU4eoK5AVpG6ji7S?=
 =?us-ascii?Q?pefbpSmvqJDA9I8nJVAtklPC5BQ2IlnRxoENBgjv6kDuEIaYc9q+PizB8F7n?=
 =?us-ascii?Q?gIMWxyf02UpAoGCM/Dsg9dKduEefPTHGgSiy9d49JUyXmuNTSXmNZewonLPX?=
 =?us-ascii?Q?9zFGTbTXwRjrCCyiNY1GgT16sxvfj6rr3Qer39FEM30f80iGiAcMo8MteJ2f?=
 =?us-ascii?Q?x/leBbgVqIb0htt7sxIQx5pidZRIeV1vm+WMF+KPzamVda6ZUeg/asc9yxOe?=
 =?us-ascii?Q?eKZuIcHYQIxY8NFrCy3Y1/71OK4sVkMrDxlKyg2VkU4tJNV4MPQtTtWawmfd?=
 =?us-ascii?Q?aGNqEZKIgi3OrFB9LsIm0rLLANu9wjs0w6xkmqv1SDIwPL9+JojJI/7vPkiv?=
 =?us-ascii?Q?q4edUq9qtDrc/U2XDjGbnNr8TVIo0yFpsHURrWtWMOoUMqphM5BfKsvpxezt?=
 =?us-ascii?Q?NsMB2L/GeL8ofPVYFjZPcbP2iZh1WMZ2/MmA9IT1Qf3OWDhpLYGljliTxlMs?=
 =?us-ascii?Q?5NIG9/cgH1OsHdeMdHJolhs/xK9YEwnnTMEtb640B2I8H8Vp/jcF4umDIFo7?=
 =?us-ascii?Q?L0eBHYKmEnSGEEuWEjmM0wtsM2BLjgXMS9LwbsmmMlGT8Rt12bTOmhK71Aqt?=
 =?us-ascii?Q?rIjhfcgB8DcnGhQPSa98yjnMvU7Nv2VIsX+InyZVl0f/150zE/AJLeNrfmQy?=
 =?us-ascii?Q?icQTG07X8V0KzGdzJg0mCjeGN0TnHVhMf/yFuoIt0ERq0xZY/zt0CtrWrafd?=
 =?us-ascii?Q?Fw9AkeaCjYwo58f+Q/PP/Gr4JQ8KM7ay6SowhQLKaT6ySCFoIrDHvdipYrGP?=
 =?us-ascii?Q?3arY9Z+YiFLBtgwtQ09LqR5Zb9CQRJtLatYasfNQQc6EWW5Y5+wFIPRUcOd1?=
 =?us-ascii?Q?Ezv0d/y9dTEueNFv/kQnwGARQ66BWSY93I6zg1Q6/zsiPX0rnBBnxYdWHgLF?=
 =?us-ascii?Q?pt3Rzzv2g0+I8gzYNmjaw6GI9yPMIN4BYcJzAQEhCA0vqsNRiqi6CkD+d9oK?=
 =?us-ascii?Q?mB3SVyhVtyKvaqzz1U2j41Pw6EgsvdJx86+obTh3u86rP0hfggz4LmN9xltJ?=
 =?us-ascii?Q?C7ebbBmbxzOQMvOxqvS5+NTEbqsVPFXXwJ4G1XwgVTWlO8Fx3Cm0fG4fEhTV?=
 =?us-ascii?Q?3iH1X+dBYic01H9XWdviQjSzmyEIhYsVfbd4u/5HPIBdvJBS2Nezz3TPu/TT?=
 =?us-ascii?Q?k412bTjf9thqTK2MMuR1qRvGhyTG+OiqHG8Zi7+4B+tdsRsMeh6v+VP1ih/W?=
 =?us-ascii?Q?lPxzib5KWkccKgvcfh6JLPgEky7v3x00stwxukAHXssM4D6yNc7Q6I0KBV7M?=
 =?us-ascii?Q?+yYs6aDMidw6a1McHQt6WvY8LAgQLqEx+7KLsIFMRRqRhtoDd3niSrNYYIL1?=
 =?us-ascii?Q?FFZXejP/VH32ieBlA6JJF4AsruURhAADE3+OOkhhI3XT02a+4MGJQgnSOhWR?=
 =?us-ascii?Q?XgAu8ZWNxQwvhK6ouW2/PXgDE1QL+V50GkDT1V4VShLCGKLd/iasCFcumbPu?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abe37bb-eb07-4e69-e21c-08ddafffab03
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:37:57.9000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kna263h+SsypK+1X+n7Gh0VADzpPIVtV06Z8PeKnNL7PBJh3o0vTOjrbCfTJS4iXB6xZ0Bo/qtoO10SFebOkv/TAJg99KPmjkUeFz2e9H3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6509
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

On Fri, Jun 20, 2025 at 02:30:23PM +0100, Anatoly Burakov wrote:
> This issue was reported by static analysis. It is a false positive,
> because both `rte_socket_count` and `rte_socket_id_by_idx` only report
> information about physical sockets, and these specific calls are made
> during EAL initialization, so no other sockets (i.e. external) could have
> been available, so it is pretty much impossible to get invalid return here.
> 
> Still, to avoid future false positives, we can fix it here.
> 
> Coverity issue: 470131
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

