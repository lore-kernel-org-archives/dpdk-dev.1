Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5616EEFCD6E
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 09:29:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A69740281;
	Mon,  9 Mar 2026 10:29:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 04B1840261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 10:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773048559; x=1804584559;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=MiRCXSMpEruJuzEWYxHIemVeBRQW4L26vthyAxx8+Do=;
 b=VHeHpH9+gOfNGuMg/h/dRfeEu02LtDeQzFkQ/zO+nNq8vAhMMEGCJam9
 L5miaWH9alAUdopnBESA1l5toYH0eWGM9UyQ0l0CcxSkFzLZguTadPOqE
 HHtlzT2CWX7G8LaTXdTXST/sTrtzIFPqyMYaxf/71CMilauTTjACM1qFv
 6V3JYVlp4DSX56l9tGJSXEZZ3ECKhYDK4ITML4wM6oSz1lCUUnO7BzDI3
 f+iZewvQOC+58NTTZxxDPoRPf5CPJdeRNpdm+SdX8LdefEdPZ7CKLAeUb
 Z4w8qPfupv+S+/jf6p2QSDb4Fy1/1vDQ1tIdptghTA7xDo8Em9FZ6Xkcn Q==;
X-CSE-ConnectionGUID: x1Yey3Q6Tgav9aZj4Z792g==
X-CSE-MsgGUID: QGGI6GpNSJ2EnvnorAlZHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="99535623"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="99535623"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 02:29:17 -0700
X-CSE-ConnectionGUID: DkQC+rjLTxmQo21jwcxo1g==
X-CSE-MsgGUID: JKT7R1vETOepScNSIND0TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="250163961"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 02:29:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 02:29:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 02:29:16 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 02:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Urj8eAjcNCJp1gGKlZQQRYuUkOnmsAkpoo53WzCGR+ul/jzsaaNswlz7yrnTo+WN3xehHXNc376nzIvIcGc/wRI5EHKYHZ3MGKNGVu7ATq2tpOo+YMZQd+gerPdjxx6EsdfLaPK8mCqvxuqvPJpCSU7rTH5wdxwTgQWLJnDmzmbtjk5ZiMyiqn0jhicys7tEH0NJ+cpt0kbme/GlQ7/rhnOOyu1pFtGzvdETKx90o71JF0CkTQ4h6/Oyu8MQsd4MdzWEX3QGhF/GnwdieMj/kLlxR5bBJff7A1jCTX7E7mcWAjR1pPMvuVyPUN2ioF7eOfXPRIKa/j64GwDRxiMdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4FkFQvlOCBouIMpCN5pg1u/8joTwXRRm/o4dYwBSGM=;
 b=tRnVJSMeK6BdPSHYE3/eq6MO9dUc98ttFDQMXRJMWGUz2ReGqTElDYHW9SRPY8rmkAwrNhZiT+bJnnwYMP1EcvvwOXCxcj4vPUno0eQWp0RnI8QZ5R5YUNB6c+k6U50OyK1IHTl+QkKOb0+sq0w6rANuziXP/8puISBSbqoQ92eTAvy6sRJAMzPd6dmQUFssluzGWLryK4vw/6BO50Zu6tba9w9AStXrw48ZPTVsix4jLTUqz/RWMjiB+NFI6AAmo7C0QW0gD3VAIvq5ocm8xW/3ASl7WerRghs4ucmyLv/drs+noQFl2vU/w4RMze8uc0kQdG/n5jxaj4FEEiPBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6362.namprd11.prod.outlook.com (2603:10b6:208:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:29:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 09:29:08 +0000
Date: Mon, 9 Mar 2026 09:29:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: AKSHATHA S <akshathax.s@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>
Subject: Re: [PATCH v2] net/e1000: align link updates in em igb and igc
Message-ID: <aa6S3VOLUPnAIaNB@bricha3-mobl1.ger.corp.intel.com>
References: <20260305165142.89960-1-akshathax.s@intel.com>
 <20260306233614.11379-1-akshathax.s@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260306233614.11379-1-akshathax.s@intel.com>
X-ClientProxiedBy: DUZPR01CA0200.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::10) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 458719a6-5051-44a3-7136-08de7dbe5057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: F7rpSk8S/xjVwnRQlZb8aEqCo0SU+QqvR2ug5vCn7aXzHXddB/13Tioa7T0xePZ6jv3i3y9tFB5LwVE87DMQEmo9FaXfhZ4RUQDPSBD6dg0CMqhDc5dNEwNJr82/C+cxYWp5Uq+lQbeljmzHWxc6KNgYWEzt3iBVpMS401q1Z524P1CiyhHyUOB/xi+3RzuzCvrnEIAxSg+3K26w7JHbMABP1NWAUHuDv/Y+kDx75+SOTfWV1XxgxWd4WgSYiGGzAhmrfWP4pS81G8EtuOIWXvTHUxxdsjeELcBAPoH8tc+ndWBYlO2Yi9i32j5hVCz0p8+YydPPUOPtDJzFOLp/RpbvTsuJQD7yj/kivfSQU69bssgxS2rimW2czeHnBqT4GWmy+38Kp3KeGkBAHWpr+QwrvNDx7Mt5MSvjNc0m/aXRErcQJCTYyhhp9J0aFq22TVVtmq6nSopaVoIQFOH0c5l3WdHhenZ/Q9D6zSJEuIoUOqIHxi9ticfIN4RHF6lSQ+iNxbXrvx23NfH6lOmAKiuNiT7JONRudzThigouiujkV0Yh8BZSX9raMmETJajuLGTY6zqHxZz3QmIKVvGF2OZ/KwBk2LI8acvTTIXtqiJR1f9EFns780OSIz/7ws66L9JxUrTbQ6uPDko31X62yQmu3LkSxh9nnG9bByE482KQOiBpQjeFg2sjQ7FYgw4wMM+0JNSOV1jbexeVYMp/h28kT0cGjeBbVvWX13RFEo8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbvTfbEQWi0KigRfCJm5BTa/gUHeCZW53dDLXNSJ37gR/NCl+pky00WJ41YV?=
 =?us-ascii?Q?tJNDXS3Ftx5sp7NV+HDKsMcHgPIFndJ9kS56K1yjMJjM7P32ge4rK/AI7l64?=
 =?us-ascii?Q?sPEb9k/05Yl8EkZ3yKNqLB959MLrrfLDmCRvNmXB9LKYATiYzODVOulxPdOa?=
 =?us-ascii?Q?mpN5/ZUwQfzfY+szTKsAojjCs4/QYcKCiY7m8YqPwZ3yW/CVONXqB0az0lfi?=
 =?us-ascii?Q?JQNRkrwi5DdEWpVoIrg35G/cxLtkctXEGsSQ8CYzMVHAyvFWJMP+baZXk1j0?=
 =?us-ascii?Q?StCsYcd/sfiI+vJspCkBkPzfLyu9adIb7CehCMEfJzIrRMXsr8YXRU2IlTGF?=
 =?us-ascii?Q?Hsok03/vMIKU/tmRcCEzKqDonNMaeq/9ZLTAqh2KfbU93hMOEgE6nwts4Oj8?=
 =?us-ascii?Q?iegxtfvxFmzboTywof5Ycs7dCUW6stF7dKIUAcclloRq83XItLTugBnmudO1?=
 =?us-ascii?Q?YuH/Z6Wb+xHVduXtWpUZIInOENKvYDZlHa8QxtOJt+lVU3xrPe5OsIQ53hI/?=
 =?us-ascii?Q?WxKkf12HK9vjwwV2NaSWZSri6QuJyZ4I8IasxDlYHR+TVrCwZjff+9aDX8lM?=
 =?us-ascii?Q?Y6bPJZv8+pP78H5hEsWkKNll+u1qQDgqIJ9rnnQCNOYD3tV2UDV9rBiXbkAa?=
 =?us-ascii?Q?9rSzVuZlKUdQgBoquiLEj20//EHsmxB7hufM/a9pWV6nlpC+D0gee65lJzAs?=
 =?us-ascii?Q?aDZwkzkzkWUqv7CAw0nPXYECQwMEomPpn665KqLiGtGSHneYOEEJif0Nu3aM?=
 =?us-ascii?Q?9sbw+T/a6tuO33DbmjAaHetGXlcoNBJLoHp2f0nOmtZb4dPIjEGN9hqmyDgN?=
 =?us-ascii?Q?u/WMXpL1qpbSSCMchxPuZUjciF7oxOojgv3F9fzuZ6ahNxBRrt21raPregkL?=
 =?us-ascii?Q?FCYeq8iJa0E2MTi0H8LvlcKkUaTIW2w8zs4i9MUqty+1Lw8Jj5Po/aQ3myvW?=
 =?us-ascii?Q?BXRUYzQGbeX3T3zG1WcTFb/CnLs54VN0IO+zPMiwKggMYxmqCe4pOF4e429L?=
 =?us-ascii?Q?TFF7y9TqfnRN8PWExOsBgjeVlPfPwIImYRZY+uZ+CPlEOuAJ+kOE3/5Xz4Qv?=
 =?us-ascii?Q?7ghZsOEnmxjVzSkokmlScUvsd07rbA0m4adUndHEMzraHQWB+UCAiCckwhjw?=
 =?us-ascii?Q?hda4VLlYs9IeAxzXoTvDcHaFm+cn91mZNf7QU17cLeYdpCtapidvbZuyQWWy?=
 =?us-ascii?Q?LkEBLOWROde+OBpSbk7CU1qTem6KnwRVVVR5kk9RbqjE5Xn0It3eqYLTCFB5?=
 =?us-ascii?Q?ln4rlHtQVv2LIg1pijsFa8Ncw7sxM9tWO/fBn78bGIb9W3ka1dPJ7FxwLcUc?=
 =?us-ascii?Q?9nUo7jTsyG4Md+En9+ISqu4bdRU/P4v+SEm7OGsA5FviqliUmNtYEAzFsC6W?=
 =?us-ascii?Q?SV/S8pHpHdCWMLAYZWkXxvb10DyFFd2dwR7CsV94QlTtSM/bCJoMvisRwXef?=
 =?us-ascii?Q?qXB3GJEt2cF14wwy/7q7Uha4dC63JZWjMb45SCZOrvsTKCNmNOCAHk1o2Ywa?=
 =?us-ascii?Q?3aS/Lr4h3XorZqwU0ZBL42vtrGc2XBvDQccvEakUmbLcKeIKlERj2B9jaqws?=
 =?us-ascii?Q?HQA2SaXrRmHkIBApPnk1dBOJmfabYWiDOVuDTTl3ckeSLef4XUB6K/c56GSq?=
 =?us-ascii?Q?aejxv+0YeX0W3B78p74nVwfm+c5+OxT8uCMNEAiy07VJR/yecOSuNoOds40q?=
 =?us-ascii?Q?XQJ97KOtPoWa8k2nsjHK1EFwuAsBfEcRSAvRObhAKgfhbAtj/95qreDgF4dt?=
 =?us-ascii?Q?1CZbpyHOy/IQH45BmzAKhHtZreRwwHc=3D?=
X-Exchange-RoutingPolicyChecked: pt1elvKuiqy2jr8hqwIsxRWz/wv6PbLET93frGPgI4ugtF0P7hj5DBxkAxboyPmDlHRfWPl9/ewxnbCeR6Ws5kxGusKfUDSgcFNBBjectNfNSB6tNdaEyLC8J/uoTdgNfi5+BLkQzbn4rZpwyylOIKs/iUCAKl8waaY+ZRxIWF4TMQRDOUklJZVi3Ks0owTo45w48vn8BQVC2l3vuU+YZN1rk8ze9TK768CEaMcnNF8ktW4U+1XdnXzEKJOS9f4wfld6fUo5HBno835gKUYLLcox130yUiiER6qHIkJVxBqUq5BEn+If+0od4UKpQ4M9dOQ8RE7al6i8AzQZJVwn5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 458719a6-5051-44a3-7136-08de7dbe5057
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:29:08.3491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8Q65mgCJ9IdtzSuiiwtlDyjIITFsrjLajTC9jZTG0+VbK8rr24yNdwcF0EXuyS3nWprIwLTxIwYgJlBBlTR/XO26WIG8QUDTZ03crbiRkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6362
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

On Fri, Mar 06, 2026 at 11:36:14PM +0000, AKSHATHA S wrote:
> The em, igb, and igc PMDs currently update the auto-neg status only
> during specific link transitions. Updated the auto-neg status regardless
> of link transition so that it is consistent with ixgbe, i40e, and iavf
> drivers.
> 
> Signed-off-by: AKSHATHA S <akshathax.s@intel.com>
>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks 
