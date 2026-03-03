Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E842CE67A9C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 08:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF43A402AB;
	Tue,  3 Mar 2026 09:52:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9C2E340288
 for <dev@dpdk.org>; Tue,  3 Mar 2026 09:52:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772527957; x=1804063957;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IFobX1uEsAIB09TPHc+MSVdpTCCDJkctnCZOMyP9dhU=;
 b=TP5zfPb1rK0S2O2EtpL0qMbSVQwJ/8ET4CIjIw/QWgT8mzXOIakmijEW
 Kk62aw6R9ipiwlXjrucKaXpbM6PtBqVOfRHsmLPueh2Lh4/RO79CDhayO
 ugDWwUSEd58JXViXNxJSvCYdA7+cdD9a2ThV1ZCM9FKGgj12rPcvJpnS9
 r/QCPX2ZySy7bcXhHyalqCaivkY3gytoVwsay4x0ud6cfQOxbUATt+j4y
 PcpYbThkq7ZMvYh0s+7MIxPtsj2yZj6TJkThXUUfsXrdQAyDmeDeYVH2q
 PI+G8mUF/AByYQw7s/WA+zfCurM3r4jZKSktv1de7pI4xu1ZZvF69ecIP w==;
X-CSE-ConnectionGUID: TfpjeJdkTjeJqpMbczT+rw==
X-CSE-MsgGUID: kyNQNdPfRpiDPk4UMtZvYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90953460"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="90953460"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 00:52:34 -0800
X-CSE-ConnectionGUID: 3Eq0lYR4Rh20+QdwulafRw==
X-CSE-MsgGUID: Igs3WF9/RiCiZZ9cZ+MceQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; d="scan'208";a="217920844"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2026 00:52:34 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 00:52:33 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 3 Mar 2026 00:52:33 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 3 Mar 2026 00:52:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk4TmB/TCHhrNIHNEfO7nWHlzw+RdWP7231AyNPsrGF7/P0u9JP98MoqNPcbvptem9NSsuHf1SEamWNS9riFj80sEVHYsFobf9i7Q9xOxNDoY3MlIU5/W+nQzEd09bBkWE4IAJ/opr+7z+XnaE+1Pv8AgQIyvE9bD0on1bAOkAFTxRW6BpAuU1T4A/DARhclSfbZM88s4pBG9pxdpVOw3BYLQwVbnf5eVL7aKnf+21TRBRukFBDZsp3eQjS9wxQ0SQVX66/RBHzQvM2WePXGVtB/NEl9GRjW+Gp9aCqMHPo2YM87Nid25Fu2zxVnw1CVLi9ZcX+eyIiR8whW55ukyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+DCi5/rfAfWJlf/OUm8mRQPaeCWnQhNDwgAlVvV2DY=;
 b=VkXIDRxX4lzoKeumJknVOY0n4GDesh2wUftZsaMiUGSz6OKy8xeb1ee9Nbqu6MQViNmHbLYt/So9jf2wxleNPsYJ2bNXLE1MgodbxPqruxmnkKMyF1G0/MQWaT/qU9aa8lg/IhU4IsWBXIVKPaimWQg0L9udHHgXZt36KNgR737qN8tff2guxn3yn1xlty/SKNcucdjfnhlllPlU5GenfnGxmV8ZDSs6FtDECrMfJ4Dq/ixJWwWIv8bVlilDjBZtTIzIb+E+EUT7jljAZMCI+mnbmGoI9zWQEY3I1Q2dJq1PF4F37nCHwVhaB1idWkXx7uWSAVm/qnTAWoR7lWAPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 08:52:26 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 08:52:26 +0000
Date: Tue, 3 Mar 2026 08:52:21 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 1/1] net/iavf: remove global adminq response buffer
Message-ID: <aaahRWK81GDdfNxz@bricha3-mobl1.ger.corp.intel.com>
References: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
 <ef84dd9e25d0daad648a9b1ba63f8dadf203bdf5.1772102450.git.anatoly.burakov@intel.com>
 <aaF44TuE9CMusRA-@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aaF44TuE9CMusRA-@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU2PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:10:232::13) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|BL3PR11MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5058f77b-33f0-4841-edaf-08de7902318e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: XoFQlshfrYQgnDEVskpMeLllNd1S9IfMBYevsxR2FTmzq6vGVIH+2IjC3gsz4fhkPTEe7kSjo7h78bFKWA+v4V7xGey9XZf5kNHgivrnDIvboKfd8UD+bhivgSQkkOSoz6qQBWzIdiyWOzycRVDzUB/7b5P5MaNZ0bP7U7KQvbEoeffeYD1etLJsPW9dFhTfhlsFauwWuvjYseAINxYz51DaTEQDIsCC5hYdx+Xma2gZ2nw63ONvZHKbE7wDEuE06dyjX9RjFANlYLeKyz4Jw7fYXAME/8aK6+GiwdoAw5ATrfd4uuhu40phGSX7TCSKPkfzwiTnZzp7AW1KPxHXVy2ID2lImAvMjtGvc1dhiAqFm2iF1FxU4c3+uPFsv75wU1M6kdhu8IbJb2zT9tpcfbnzrWhnsEVvO1zQo8DUl2vqZ4P0pwI2rhsjP/7YMV+CKm8P2n0IASIfXX2nRfhQd+B7juUO8z0Q6Pm8uGXS4npIGKL8dnykZgr5hZO4kxPDx3V0fsQqDQWYwt3FpXjVC4Xkfyhlu7n8k80krCKY+TBfOngSYLbhMHBujooJXaOFnQtUMxeN6cFS0HoLurAQODd4VhIJHyvY+rxGqcl1CTNIsYYp6kjqCuOTSaeZ3M45tD1EMAZvt6BgZctaXeBId7RveimlDVJRuD9ONonhITazstqgZqYUFiUyj8OGnAsE5sIeFGXad4L9ckFjxAZIWwRVhWgQa8hLnY/cZNlRF+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NVC90NostFlQTbFCuDETsR3SP0wssyGOJzIaYHiQmcSC1P2DJjig1GdWN0R?=
 =?us-ascii?Q?3WaECnrGfMZGyiRPD7qwBT/A4heEFs1hTZHlKSmj51OrNfJ0EJOXM+MAU306?=
 =?us-ascii?Q?pCKsTstWgjyqCrSh+HNEy8uTLGcFP3qz8Eaa+NxGLst+ZbRPLEjfXOZb3exA?=
 =?us-ascii?Q?WW9U+yrasgIWv15KmZFxoYbT26b6+3/h+cdWO3eYoW1PRdDfpZRcuSN8XUKF?=
 =?us-ascii?Q?ccvCuf6Ep6Fc59JgR1GqnnTu4d/fDNwZBXaISwABeoO9XuAOOi9xGfZbxNFl?=
 =?us-ascii?Q?2glVhDaHvGS2dqasAwJNIEOgQ2UJiUYaS03OuQddySiqUGuIdiD5sYLRjo/6?=
 =?us-ascii?Q?CA+U4BvC1CIX+YnT2ilkgN/D+4VG2UVVUkKkLbIx0Fqpl4WMWCoTdrKBfArv?=
 =?us-ascii?Q?9zazEqGpktuJAwiPbsa3ziju3geajzF6lbfVs9JhuHnB+jXfnXvvGuDAKfRO?=
 =?us-ascii?Q?lXxf/5FtjvGz0dBvulsBoTAongW2ZJgWqfaXGZfbdsPkhW6W460fHehDRYam?=
 =?us-ascii?Q?wJpouLKm8ibop7a6blKDkULKHIz1nERqXC5x91VjCp/ExIzyWLcAiXDncWmq?=
 =?us-ascii?Q?9qGLHYJ+C4kHPvETXhR+1a0vk36oc0UeHvaIzoQ9KzNwsKjMsgeeGjpR5SlU?=
 =?us-ascii?Q?xnrcG2CetpHXjZ/BWTVc1YyWUTaz/iJea4HQNnqmcrIcx11RVlEw2Iut3Q1y?=
 =?us-ascii?Q?Vnuz4IfisJrx8gOKvYnesFLakHFeStGTkPn5eWRKyt3mlYNObodhUKoOzQc5?=
 =?us-ascii?Q?OO33VMtVM+1LUZFbpxJIYMzfRv6BTkN+7ksMQbKEERHTWx9S+ANejLYODd9S?=
 =?us-ascii?Q?X3tf/RghCK4q7jnM13P3R1Q+hYCaLQ4M7B0pPV5/lAOA8/+AuRSZ7pT1YVCO?=
 =?us-ascii?Q?P+VJsoMBqtLbPLI+sKcTDyTHlkW5jJ8Bg4c/AdV9KVCi7Y5zYFJrNI+a6/iB?=
 =?us-ascii?Q?8owHlwdD4jqERygqinfRhtfEhllwXuq/91bobBLON6iQ+UD3mr6qjUQsGcuK?=
 =?us-ascii?Q?HKwAfPgCrpFcrORLr495h9XLLupa4801Wfsi8/u8GPLsSuf2WWWO51nqGnEw?=
 =?us-ascii?Q?8nkbM7YqWGrVkuFCnuyumy07ZC5ZAl1AKGbR+xwbSP+qKHrVummerp+71ogP?=
 =?us-ascii?Q?3ulZthTe4PMpRGW6OKzVd237ne9jW7ouq/iu9/Bg1K6U2RAYulV74/NnS+/b?=
 =?us-ascii?Q?C2iLCeHki15Q0ysTK2k7XkooHTpGr4TN04a61TAWlHwetxcnAqquvuVmpCSu?=
 =?us-ascii?Q?BAWLCqY9WORZfXltTjF0rBeM4c1e03pLvOcht50kqgr/AsXkBNNYnMwFz8bp?=
 =?us-ascii?Q?+EuHWlImnuWKyMD0bKobPTRyZn4gEIbuv3SJ8Up1Iw7OT6lwtDiXaxsWTgdD?=
 =?us-ascii?Q?N7alHiXB0Sa6EPln8p/H8VVZejJVL4aCRjLdETeDhKuvWF53Edd1p+SWoheD?=
 =?us-ascii?Q?sMVtXRiTkGCsGs6CBX5aVa+2c2pjnyuDu+QHC1hpRrU7Zeabk7C9VVr5gBzm?=
 =?us-ascii?Q?3+wyduW1rphAQBpZAqb76aDCpHjw1HOtRyzuOYg/Mhl2YJn5ogK3Xy14lWLk?=
 =?us-ascii?Q?28oqQYE9hH7ZdEX3cy5VFO2iKf/pCYHq3XBNppLLFCvV8Xx6SGxYD8aqM7/R?=
 =?us-ascii?Q?72HBOWeeErl1m87qtkefXV5qCnQlfeVJGL0b5l+iVGqOQvmT7oxVvdQtaCon?=
 =?us-ascii?Q?N0/LtrIRU3Y8e5do7loRhrukfW8znmosjbnF/vlg1rKvf/09Wk3IMrNcYj2D?=
 =?us-ascii?Q?GASQ0lJpBUa+2XBqq/qzYQZVfGNqfFQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5058f77b-33f0-4841-edaf-08de7902318e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 08:52:26.3894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wo0prBgkzbbjxRTskS/3aJeLECFFLdLEnFzQgr195n2Ub7QFMT1op5eLFG5lbOjTaNTUpF+zSUtMtun6tkSAt2ZOeGxiJsemul5S5tGIV0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
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

On Fri, Feb 27, 2026 at 10:58:41AM +0000, Bruce Richardson wrote:
> On Thu, Feb 26, 2026 at 10:41:02AM +0000, Anatoly Burakov wrote:
> > In many places where we are calling down into virtchnl, we are using a
> > globally allocated adminq response buffer. This is unnecessary, so replace
> > with adminq buffers allocated on stack.
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Applied to dpdk-next-net-intel.

I've actually removed this patch from next-net-intel as we are seeing
failures in Intel CI on next-net-intel branch and this patch has been
identified as the culprit. Please investigate and resubmit a new patch for
26.07.

Thanks,
/Bruce
