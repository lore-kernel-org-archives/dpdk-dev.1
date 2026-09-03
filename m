Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A57C624D7
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:20:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18666402D8;
	Thu,  3 Sep 2026 12:20:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E04374028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:20:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788430812; x=1819966812;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=gBkLDr9bCkZd7LwRh4Z78Pxhg740OyyaXfnEgYB6HW4=;
 b=SQCrvZNs0VfFKknY5oqAP/NVhvXL5HOtbK4x6L8jlOtoiAMFXooQ0pc+
 LzfoRbr7TDp4HTSHqZj/OKRATW2j7Ny/7wTRymjFrmayvcf71aw1dbfG/
 JUQwNcQCJDYsFYHjG9UPOHa9NZ8gCVorVdAHLXILIsmA4xThJkRlny0Xi
 PnyeSX6h0kMDvQDlQXMvUqI480MCquWnxq6f/ck506S7qGZlKJyjnacYj
 upyiaPbhwjd308QSoq0v+ynfbAp+MxmOq8g/tf/F1oOhVRv2RbbCtg3lS
 lc4KkAqXwBIYzUkL8TIGphdb4fcrmXmdw451ao1FhApeMy+HfK45O6u1Z A==;
X-CSE-ConnectionGUID: A8dxoWybRsaivzavTxvYqQ==
X-CSE-MsgGUID: QjM/syhPQteJd2/BouRxKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88833164"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="88833164"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:20:10 -0700
X-CSE-ConnectionGUID: R7AbGN2nTrKsjqws5fMhFw==
X-CSE-MsgGUID: BhfZG2M0SpidtMXyBJy+fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="265339305"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:20:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:20:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:20:10 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAo4kO5HP5ZOoeHMqU7YmBmFcwkZdqlbwVQ+rTlJ4cOpDQHbcF/s5fk8KGgIcM3m0jHsPpFilYMQ/HgdfM1naPiBEO7Khvsy1udO5MDTCgQse+ORqptMge5a2QLi1WLjVrPFq5J3MWmC7DpdIDUzydfvkM7KArltva9qcLQ8+afHWuKTc2UQae0hYigH/vFFuamLhhertOL0M3ElF/tKnWvzn228VIlweR3iRJqMBfqKqlThkizjtiZRXXGMSKobVgf6Dn9ICX/wwBnFxmiwNyreeCLuD7tmcsTdVLUssqBPwLmajGbasvO9fgKjovDx0FB/oKGgCLP3xtCzJoqtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu/7RPtw54xi4GAcRltuFm2Rm803TShrXjWg1UZpVYQ=;
 b=Km3hEFukvUkSe7cWqrkk7dDJhhViD7fQuLbVzpzz8z8KNnqPo6tcXGIhjJaR/TR8drQiqZs/0gQGWngNIlxzEVZ/Pd5+ocxfUBOfN0TR621MrgQQUfdFa7fyqrCPYMgDmdj25tZroomxQ+4rZIX7fO2n2+opg3IWexBVnFkoGpIi6nsbOn19UkGAFELCWevXPng5B1NPN6xNGZvnAbUyWo99wJejVU4EQaXQAhdH5xVsZEVF72pOY1cNFEEC/UkwZrw49h/m8lsID8IAhtGYKxMSWjjsDsIwW6nfm/rlJrMTRxQ9KV8qpg/wBz/N85P0bhCPpdvd8iG/gOUb69NfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM4PR11MB8203.namprd11.prod.outlook.com (2603:10b6:8:187::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:20:01 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:20:01 +0000
Date: Thu, 3 Sep 2026 11:19:35 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 03/23] net/ixgbe: remove experimental FDIR API
Message-ID: <aplJt9R2EUgcOvGX@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-4-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::11) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM4PR11MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd0e132-5817-432c-91b0-08df09a4e9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|4143699003|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5wxSI/H646wBC8UmsIussYf7RDl0GMFMrRwFKzrHPXJBxD+GTK6iratapmJ2KcGo2Wo+RIL0b6p7oaF9Rbi5OrZxoeQg/jbW/L+/uALUexpj2PIlM/vjsL9kNh2zWkoZ6fOBckTQnluhtRoE0AACuRTvgZQ0UqGmBp/6RwIksdGRn1/L3jj+3GRYl2UjSVoFbF6qtF6phWVfrkVNBrU9evtXFZlSMVCBweByr+8uifE4kn5i9Kr/P2BSDi+3SPPhrKZ48gTGTc7FNZIvgXR+Takni3t/HPxHStxHc1tyJrUWySDbd6XioCRRJ90aJX+45EpAHgKcZjBIO+Q+mfA7HeDPHcIFYlZvWFe+BkWalLmGha85lgLlVentSDzZBVppuwqF/Vlv8QXcGvZv+zsQ5S2UZQUzWhzS1sJ8azAj/XlK03xXHqaU2EvtlB6kAC3vIjATbDu+7RZ1VlFR1eJooTw7jsY/YKrEgN3Ubw0CRN2Xu6HZCmBCJBXANeMbCH96UGOodFBsZ2G+0ml3VFoPQYn+HJwYtnpHCCZju30hoJgYgT9Kp1H/2hVwys3UfTRrJ++TDgT/leTcDdSvOelfLT8jEL0PBBzVn/buzBg4VQQwhjncSObcNkfopfnnaJaqh/sYfDKWr5EDCQVCsts3ncHttlbE3DFc1uSmg724lR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmHavNUkQBv5fopvDwCratUovIKwm9LvLo7TcCV+1EEAqd827ALsqblEL91w?=
 =?us-ascii?Q?k2PK9riuwOekO7aeV3VLh0NOYb3nfXVxNvHHY7Vjsqyctn/Zs9nbjUkUCXhn?=
 =?us-ascii?Q?DYM5l+7lzTnDz369N/HTGWzSdb5rAP+/iSe+LNzCXSc0MFMU8SwEiKrBrgsV?=
 =?us-ascii?Q?A5fZ5OiFQQi7/8OvFc/bHjNdE2pTTSnoQvQBt6TwRxS8xl2oov2vE0va0HVF?=
 =?us-ascii?Q?A4S/t0DRDxPL3JWfPrMbAgsD8WBLDDi0iA3HWlSJlW+i6cxvp4IWAZDEOeJc?=
 =?us-ascii?Q?GveksbQLBLJX2lWTgDNiSVocmLdOInGZxTsBm/MGT+2C6VINGztDKkGOsooH?=
 =?us-ascii?Q?bjv1tMF5LqX0Z2YGjmMqkpFGvhGMKz/+AYlLKxobazki9Ex+Pr2C0WOEjUbH?=
 =?us-ascii?Q?WCVH7ROZeFyCF/eGNFLbtz1rEof16GV0VS6YfvHffBXT/vFg9cSYq3+KjHY9?=
 =?us-ascii?Q?0zPRmk0UsSY3cEds+Y2IGwy6Lo3CMYkiTiG4vjskekB/vJzcAN9uwQbp8NaR?=
 =?us-ascii?Q?JOBZOuhnzvVv0R5V8aPudPr4OiWpF3S2xTM6tqQxr4ZUtxSnf9eqg268PaKs?=
 =?us-ascii?Q?vEcz+6F76YZNcgNh9vE9stOl5kZiMXmhHz+TGVFInfxOOcrR1vyjvmQGGwKQ?=
 =?us-ascii?Q?jDXRduqnaCYr+022e14Py5tnze0/9sByCp/rfPU6wGbC4A4naZTdhJlMJPL3?=
 =?us-ascii?Q?0zZqqF49zXELNLI8ZmE+Nw40f+1iSr2Bu960JAK+uhT19a7/J4hc3TQ6GT0V?=
 =?us-ascii?Q?Vf0f9/gMV24gxLzUcqdHGPlAP3M7R+M1JjwOMVa2Gu/7LSKOozgbvgNdJobz?=
 =?us-ascii?Q?AWdyQ5XFVkvEqGjLyAMXA6KPW3dCCue2otdEb8w6n/SslpNJ15NQAYXbHJS4?=
 =?us-ascii?Q?67DyfaM7oG9/tdP23VGvboJ5RNJfrrX6Dx31FMzliPtikBWecJWV6OY+jfq8?=
 =?us-ascii?Q?EmEuAw2AuDztiWyCXE7vdiuov4Jh6zyYzfpm0kaAqxHh/eVAnsLQvw5Zdas1?=
 =?us-ascii?Q?PJyOfFkgGiaT6S21g4l9Da449VMhgHUghyv6ws6zi+raoS+dbJBX6wvo3ABq?=
 =?us-ascii?Q?YDCRgN8C5l1jMDgovy4l82rfn6yTdFSMR5I3nbRoYw6JZ7KKU4WvayDAN1o+?=
 =?us-ascii?Q?A1JfeoXwk5apwD5oCH22KB7NBqc/iPZPfdERzV2nCmf2RT2zrXvkXyGDVel9?=
 =?us-ascii?Q?qF+mTjo7gXPm2nENCFitsmZEQHgA4/dkv/nbIyhiYuuaODDfgMxdpj1yDSsg?=
 =?us-ascii?Q?S9j/bYQKXi//Dzwq59IC7SuuMm15FUxuO2BOSOB6dCMh45d/ICZfXaW8dn1P?=
 =?us-ascii?Q?2icbUxyJ16BSmNT5RG/EkSpHf7ztH8jIEg7xkpXGmyc+B8Q571LAr6G2RBCJ?=
 =?us-ascii?Q?LGJbAoqzqACBe0VH0cSPl+zaDzJoz9H4u7uYo63v6M1cQ0v+fhUrZBaI5w1i?=
 =?us-ascii?Q?pm86ahBbl73Rhcgr3ok+FTC1ZjF4fGYeHniME9RpSLyIP4GcU12o4sCa9s0G?=
 =?us-ascii?Q?Ise58n395OAAjld054LMmM5vyCzV8OHibgzTfOknQ37Q8TQ5Joera04Flsw4?=
 =?us-ascii?Q?u7Qvlqzm/4H8yx+MnN9OTHBMwdws+sCSL4MJMFgDBvfl3sDypBTjZObvmXjk?=
 =?us-ascii?Q?fX94prwF9oodXbEPYdatjhEzElDDrK8z4YHit9+LHlB8ODevzlSS7kNa3boF?=
 =?us-ascii?Q?eRLm07KiWpcRqkQd51877WE6PkzMhtpiY0sqPtuK40+rtNj6nslu8dhZzgnK?=
 =?us-ascii?Q?Yg+z4+VUSvOHzZDZwnYiBBZY+vzxges=3D?=
X-Exchange-RoutingPolicyChecked: a3as7gIWstyFjkkdBxQeuAKHmOKnAN71JmMTTRY+8Ev5BbYLlv2Gd2kUz4Q9cgqVfY29ivg+7QJQ8JlcTGxvNxUIOgfxnaakq1W7eQGD2eQ/raR/dr2LROi8rQqLHCdTuhAwWJuLmZSSr0276qYCznnbOir25ZALfJGCa8bvuXHlNhtD7W4itQ0U3aiCxT0h6RjrTSTMpQVZmtrlPVF0Jdd+OVau92R6iiSrfB2LWvFbH4BuRc6Fm8HDRoyMKd2EQSFjnLWSKQBYPWgy69RMcr4MoJzYlcTANr16fMeQx6tSf7fVlcxB/twr3jNyZ64seuHSxdyP4uiRD8g/iFv3QA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd0e132-5817-432c-91b0-08df09a4e9a5
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:20:01.1316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWBj7fnJ9A/z32i6zE2FJL8C2uIcknZkezAedRmqBl6vDs+kA8/Ec7qIRzTUvm1bjJn/3gc1PJi5yWtjq2nLi0frkVl+DcQQcWwlT2m3xkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8203
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

On Wed, Aug 05, 2026 at 10:08:57PM -0700, Stephen Hemminger wrote:
> Remove the PMD specific flow director API from ixgbe.
> These APIs are experimental, therefore they can be removed
> without additional warnings.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h  |   5 -
>  drivers/net/intel/ixgbe/ixgbe_fdir.c    | 117 ------------------------
>  drivers/net/intel/ixgbe/rte_pmd_ixgbe.c |  34 -------
>  drivers/net/intel/ixgbe/rte_pmd_ixgbe.h |  32 -------
>  4 files changed, 188 deletions(-)
> 
Yes, they are experimental and can be removed without warning, but that
doesn't mean that they should just be removed. Checking the original commit
that added these, the comment says:

  "There are also several small features which can not be
   implemented in rte_flow. This patch re-implemented these
   features as private API."

Therefore, I think we should keep these two APIs or if we are going to
remove them, we mark them as deprecated for a couple of releases first.
Since these are driver private, and are not part of a common API like
ethdev, I'd view their presence as "mostly harmless".

/Bruce
