Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 14:00:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD177402EF;
	Mon, 23 Jun 2025 16:00:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A591240151;
 Mon, 23 Jun 2025 16:00:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750687253; x=1782223253;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VF7/e3Hx1Gd2EnZ52jrvOSAX+vojO6UfAt9ytRNAMUU=;
 b=lKTww1CkY2nds6vxb8kYKtyKE2cc1Bzmqvgn4mde6cF4cRDmS6+rh4Uq
 5NHQl+2suK9LW23fQFS63celCpUbuPEfOLoB+UNffTDQwOoUjzHxyMvRi
 +5pjkWkhcAgOqa+yjhPjq8Rndy+Vqszq0OnbNr7/HVVCPs23Zz2ytihUA
 q0CgAj86vK26DJdYV/K+K2Fp6cRmutBwzMt3Syh3MvL6oTSb5CnMHyUSE
 XoIo6cdYotevN6S/lwCOgU3L/2VhpeMPFC16b/Jty4DXuYLKIV6VZm7xt
 vxWLkQ8DmaX8ijI99L8TxSQOHdKkEl5GEZR5fQAs7hz0BIDv8UL/KoKgX A==;
X-CSE-ConnectionGUID: d98ZoC0FQeWZn8+MEUBUeA==
X-CSE-MsgGUID: hEgUcNsCQzej6ALTBQmL7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70463312"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="70463312"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 07:00:51 -0700
X-CSE-ConnectionGUID: R1HqI6Q/Qze0zPWXXv2nFQ==
X-CSE-MsgGUID: ApNRFY0jRHiZtzEDsYM3hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="156172106"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 07:00:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 07:00:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 07:00:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.43)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 07:00:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cygata3EhTrKQ10/iXAQ0jrFMbJmrkU2ZDSjdBlUv9dIfPnZBEjRV8PlF+IL7RimEOPpzBFLh20+KAG1CQTmEXij+6vY3blcJr3/OEbi1yI1no9yNyLjpwZ0gghGBhdLJKkmcFcDdaIeNVtzG4r8IMlX9Ia7o+S7rfgNuml4ZIEID2bn2Vjnfr11pXU/LS7SEVY7dJainN8sVLIpKP0JSzyAQcQTk+1zuVreNGa6+u281hYkdTksSn6F6t9zxvgzKQW3yFxDToLszIWj/0aCuPixHw/meo/qr6JTcMuy43vvNPsZR8rficovykEgyj0Ye0TDWa1DfXG+GkYW7YnLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fQy6LRbYaW6/P7qCtXPMaVYfhO3xi3J+OeQrgTTTXk=;
 b=P010DyV66e5HELxWLkCvGnzJyY1wjnO7VMHKYSAYF07Q1UmEqpM3jG7VBjMi7wAjfSCH6LQvEBtxBAPqs4vRF9ryGl8oVnatnoTwPSmGCyPA4gv+FjuROnApsuQ8NkzBtjklq3q7baLk8ZNzHWNPDhwLnr5c0yc3J+UBS+XtHefOspHyv9xiGiYQj0y53cWlqJED2AsE4yps9fXRtDZ/d72YDaBr0ptZ2f+fyWUetMdDr11/p9S2CtItqhFCB9Z6svfsB/pOCMvuBhJJ+s06S2Pv8R1nix7l/EV6ohfsahBTqG3N6oLryBAc3pb4ZcGR63M++LoB04kgG56rVNz9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6983.namprd11.prod.outlook.com (2603:10b6:303:226::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 14:00:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:00:38 +0000
Date: Mon, 23 Jun 2025 15:00:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2 05/10] cmdline: fix port list parsing
Message-ID: <aFleAe-WFPZ9hvMY@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250623135242.461965-6-david.marchand@redhat.com>
X-ClientProxiedBy: DUZPR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cf7331-f30f-462e-8a0c-08ddb25e5537
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fh6B7ayARdE2f0T1NzN3sDbpkz3qbFTg5Q8zD9zZmw1Y/mblYEryM7RRy0Gr?=
 =?us-ascii?Q?D15lcccaFEf/g0EStQVNjLt0VoBZvOW1NtfNA5mzVgD4FHkcDuQyrZ2wv5Bh?=
 =?us-ascii?Q?PJoFRHAPV2LBn9Y1ytmGAk6bukN2l2fT7LDuyR8XspU7Rh2SA4V/0OOQ8FbW?=
 =?us-ascii?Q?rtekIjWA99r7eB+CGvhzPMpk3shy0qtYPoyCnZn1wgXM2VL6Rf7xj+RAR2DD?=
 =?us-ascii?Q?ZnKH40tZ1K8dRnEgTqB2Td8Ck5AMdZ4VRS02FQk66X+zdWTeFTm0UGBl6o5i?=
 =?us-ascii?Q?nQfeEFS83y2wWKrW7SIa0kzQeItz1DUNc9UrdUDMNJTkdp5T+iLIzeJ9KBnw?=
 =?us-ascii?Q?8Dy3lR8Rq18q2OPXY3NvR2BH9KhBwhUdela/aT78gAQlnY2Vct5Q4zxXhzJK?=
 =?us-ascii?Q?QePllQyvgtqXtgxI/44IX+vHGOdcEN4/wRXFtuT0YzJPH0B5mEkc8BuSlW9h?=
 =?us-ascii?Q?ePUoVx7kGWIP2k0XCGdBOwVWNwxToZuokVtYivQnqeUPJ+fjEvgBjuW4aCoO?=
 =?us-ascii?Q?ybm9EgYKK3S/XZRi0G+d83cERFq8Pfa87zU+iXD9d1TYTqeQg1cluLiLN9ql?=
 =?us-ascii?Q?KbIYIKvOrLOMWN1V67iR0HjTtIQH3aUrpJe2WOAAaIZ2mwODHZcBuV0D91aw?=
 =?us-ascii?Q?ijbGCUUTBGgdOPY122jDZ/e7Fv+0oRem8OQvtQTjDdwxo6l/jFd9RfyiozRw?=
 =?us-ascii?Q?YMvgCjf0nsWs0MX/aHTTw7qGiUzLgptmRXCcfxKgx3/5zWsOsTw7UwZz/pZf?=
 =?us-ascii?Q?FD21G2OQioeiOrE5kKT1qdeS2ZltBXUIhLAJAZVTnMkT9+wfi8ZjCUvqVT+V?=
 =?us-ascii?Q?NTarsAhCxOZYRMQrMw6BpGlm6xs9LK3ZVgaQLgSoM+Ic1GWCYUsWwPjxe7tF?=
 =?us-ascii?Q?7YqhC1bPQWMCzl0QsTVxlyOHKByhUd+NyVZ6qSzsh44vexDYkmaGv6Cd2ijP?=
 =?us-ascii?Q?dt77gfgtZgVn+N41kjDxacgislzQn1Ha/yDfu/UNs7o76AuRIkX8GRRzccku?=
 =?us-ascii?Q?9gr+MbcdebmDBl6Wl5OdKiDKuJ2YiihkP9gT4xH6v4DcpomW07Fn4wxBqCpz?=
 =?us-ascii?Q?S8CNuzwOL8F925+p+npdHFcLAQdi2s0JYyneRrkzGpC5xvGgOFtvi4Nj9Zdy?=
 =?us-ascii?Q?rdvxkFqWjZYBks9DTFNQH52ZNqulKZBNN2FXaBhd105V1EJt5JxCK2J+JS8Q?=
 =?us-ascii?Q?ULQdrMooHuzwtZ6hgnI+0gORcF1sIL7dfi/Gd0UvX2H7dTVoAxCss93g3Y2I?=
 =?us-ascii?Q?12UjbaEFfuagCvw9LGGZXgPBAat+gNOkuo2mbipvusMLX3OwQrbOfrFUQfuT?=
 =?us-ascii?Q?NU7jy8Q0kfKXgySnU9p9Tnek/zEt1sJrUMgwI2I/J/RpiCJ8anBrZlS2m+pO?=
 =?us-ascii?Q?TE+7qXeV2HS+H3jjrATeIn0NmOa66ptQPxxF35XmP6R1MBdBr6L/39/GdHmt?=
 =?us-ascii?Q?ettINGpNO8U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q73VAxpTTw4Tj2Gj/mciGrEVsZe2dRGXgyEtFgf05KL3Y89MIa5zCWknOCBe?=
 =?us-ascii?Q?Yo4veBdLLzkm3DrP7MIZXSBGTRZqQoDT+YgqagEgPn8utFAi+5ALNHprZb45?=
 =?us-ascii?Q?Z9xbW+fAIKDUuGOh390Gq4xEgd0UHik+tF2BHrKOmIqmxf6Y3rJjHqSdDdP4?=
 =?us-ascii?Q?PK52KwPQmkD0n/6/rF4wNJ0KlcVyfCs0gOgnxTvmv1XgqLsn9bYEAbEI6hO1?=
 =?us-ascii?Q?E7rulDbuZj/pEmzDxdEUfnvFCv9IBYQ8Jy/DGWJUGI8i1JHv1lv9fwcp1ItR?=
 =?us-ascii?Q?MSbH5Hbye4SiurDhcTJ70GH3vk9w4vyqPl6/sKDgP5q87Yi3CoUoqZxC3jBo?=
 =?us-ascii?Q?6oi9wUFn1ZxP4zlnfXihVPw/dOV5mn/VPWdoryIP8+ChIqzWWQ1DZrKq28md?=
 =?us-ascii?Q?8pMh2ZQXp6AnQ7177UxLBGWAwq4lcD7LvqSyesg0osAKKTHkvsrxjKx/3XJr?=
 =?us-ascii?Q?+8F0hTn8jmIrQsgFmLR10ynKkEB3HssCddOTCVvxZhXM2fH8RKu2sHAnGJMy?=
 =?us-ascii?Q?7RO0hDqYZzjc+/BWJFklYtya+ss0zdQXhjlUYioBj5tmN9nD2A/du0nFZQEr?=
 =?us-ascii?Q?r3jqlxfaXc8rOLIoBoVo0CzWun5z5ohAVzMDu89GKrlg0DqcWaZ7auazs0g9?=
 =?us-ascii?Q?wI1QVmLjAIcjBvNbSSNV8quwQ1MHV9hGruHG83ahbufo5Ldha/xcIvR1qc2x?=
 =?us-ascii?Q?g5+9+nZ4oSC49+fGYvuwwdBUbiiQjI8RDFNnNOIvMJqqZ5JVSB76Q3nAvsTg?=
 =?us-ascii?Q?iSmjQYgfxmu5Wi8sp7p6qxTvx6bT4KvNPTa7V3qkqNDriKEgKrbMGzcRRq8u?=
 =?us-ascii?Q?hcikZMtsMMHIkdl2+ArFLziZaCFjAzNGcqo8HYoBa8R5Qc3aQ+v+pXc3anUI?=
 =?us-ascii?Q?POlTT45+SpAfePNp8GOb+0H1XMw5gXaJqHNfzUmCIFgg+nXii2+XrygUDZOl?=
 =?us-ascii?Q?KO37Q89D/OX6y6W5JdPCPF4Jb1XMKNppPbu4AfoIwRDWUxWrrjgTXlvTl4HH?=
 =?us-ascii?Q?STX85sIt6HL8HT3MFGZUV0fGxiPwCeYm3XwJWeekg1b0bf3qUWH+d0FhKT2t?=
 =?us-ascii?Q?9Zq371A42R50R4vSpInMxySUxCHJTUcAqWtqpCob1zulKKMiSc5GwfoN03i/?=
 =?us-ascii?Q?dVWUb4NZMgyns9IDmXgw/Ibm8EqwkWREImkacrVMHqDp/b++cciQjPDv0o93?=
 =?us-ascii?Q?h+aGblEqPgfte+TyLvGRjW67c+Gjaw5v8RbJvaM7WRdloJlxBvZsOkftkSrl?=
 =?us-ascii?Q?+p+oqeuDzDW+W7FRVQx15aBtBMSTSV0uafWbFw35SoRm9qzFaG75lfejGpWg?=
 =?us-ascii?Q?gP50n4jV+8/4ekYwDzXVo6gWjzlKGI2nOTzCqSYgxawN2qjoRoFfatBNmNwS?=
 =?us-ascii?Q?JtYFXEEOx5ri9/8CFU59AXgRFZRguAL/PFRpo+cIu9QXeE3dx+HX0O85SJ7C?=
 =?us-ascii?Q?YerXm6yv67iQDNl3BcOZ+UWUQ0s5uN5tEZvss2kUzmNoGKLS2HD3kf/7XprP?=
 =?us-ascii?Q?k8y3x9bhTyKB5WLhzj85X596aqoBe6cN+Kv6heMlSpZl/zzBIKUNRSxVf07O?=
 =?us-ascii?Q?empJSRJ3Bhev9a3R+QGD+S68AaCkd7xHteO/PQbfVYIwkqGMDSgczE18q9j3?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cf7331-f30f-462e-8a0c-08ddb25e5537
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:00:38.4423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8cnXMb5REC+x4hOxLJuzb9Tqxx68uq+y6jZ2C34EZGCbcRuqA5o3oRvO/a6QNNe4AZg/lpytDx6r4+B1ASW0uL28DbUrFyY9Bd2nmjLVYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6983
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

On Mon, Jun 23, 2025 at 03:52:35PM +0200, David Marchand wrote:
> Doing arithmetics with the NULL pointer is undefined.
> 
> Caught by UBSan:
> 
> ../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
> 	applying non-zero offset 1 to null pointer
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/cmdline/cmdline_parse_portlist.c:40:19 in
> 
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - moved some variable as suggested by Bruce,
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
