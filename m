Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA569E9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 08:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A3140299;
	Wed, 18 Feb 2026 09:52:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7E3AA4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:52:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771404742; x=1802940742;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Bk/y+pU+4jOpY7cMNlY/St6ilq4nx4kwM8ykhQybwWk=;
 b=KowHKEZEsnq2p4fUkljiBkQUjMT7B10qRxJflGAsBwtrPaKpGpLANAZJ
 Nqe8SfivWswdF6cog9ntAecVpihmQjDPCDK2Nod5d/OlL7UoQ3WJ8SnC+
 9axztFW5GKQnrwZwuZurjB4I7qa6ctjdhsy75F6DTw6FVq7WhWWymsOyw
 xHPtHj6JpbwdjOPvUT7QStXpY27nWqXhVIn7dJiM66YQncOYimnKwkoh5
 NYDis6ala3ljAygV6VsPuwuoj1MnFzVvQg4hNJptJGZdqBoHKqJQSNaYM
 Z58zkC2H1WisozktlxEPY9NB3c0vCWp0/q68jc71j6TIlyUj6HTHaiVev Q==;
X-CSE-ConnectionGUID: QqNb/kAQTcGVs9zqMl6+Tw==
X-CSE-MsgGUID: roSEVlrURCayz0EqNRVztw==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83584415"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="83584415"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 00:52:21 -0800
X-CSE-ConnectionGUID: OEY8ocsmRiezw9DQGZK2pA==
X-CSE-MsgGUID: Q8Rrqr/uQ7y6s7FcM7Xolw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="219124071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 00:52:20 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 00:52:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 00:52:19 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 00:52:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLw3PWv3Y/3goEeUsDKTO3D8BVA/nEYy6oHrtXP800HUYyAUh4fd7aPoDNac54QCtlaBG3nmzCNZgi1Ud2d4atG6sualg+Q/Lz3ShRhcNVQqSNp3XJWWUNf7gD9BBUG6VZt2oxw/KrMcBH5oPLNpxcTG5ZKWZIzfDEr19r+i/fKea99KWiMaT2TYbJffQG4TOU6bCcay3jcosaP+96ATA0vBQZ91jlgCP9hJpqxtmFwslfHIxeHeWymm8eGJYiLh8Ib57lzjY01W5PooWYnlXW7harlAIr9Vfy9KZNOMY7GK9h1EPoviguAz9A7UvT4kb87zHFrTg/Ppf22xVQf8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDp2koSbwRhS42PyMQWhzV+E24guZsk5zjtz80KkFLo=;
 b=AmajzT7UzkWdP/rq1/GgSi8DgLGEtTFRwT/joRbSMMeE/xoUK8JrguyXxTbH1fEki1hsHCEXW10MmyTBuyhALMl3leW0WRqpYDUeFIsqUUDiysmkIJgZVuyn07i8uxyDwTi/5vvpPbn+kuF/B00clqa2Jnr/FGwin4340YvCRJFKpKGPkiCT3chRYmdH6ou2/RvcpwxPZQU6+GBSANUU4+jjXlyDg7K66TaqVHVUJIeYEMgK76WiNUckM0xB+F5xUkg07sFO103hssmZTe0Y/ghqLngvmpFXi209LYq8wNEh+k8SnlAsjHaaxMQar8cGJElojStUVs39cJFXhQxZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 08:52:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 08:52:16 +0000
Date: Wed, 18 Feb 2026 08:52:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Message-ID: <aZV9vI-17jfQ2MQu@bricha3-mobl1.ger.corp.intel.com>
References: <20260216180011.393782-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65728@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65728@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a51037f-e4c4-4666-e92f-08de6ecb047e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?XQqVB5u+ncVekVkL82FKPR7gfIqcDmaXBlRN13zvXeqkzHXfDZXvwdCM2x?=
 =?iso-8859-1?Q?vf3B1xH0ON5q97DjVYilJjm52zCm1QFrv+JDq1LT3ciBLT6YOU72kH8tyi?=
 =?iso-8859-1?Q?kMVbhzxb9e70Majf+JzJzeD8ITLOfBOV4ZpKzz6hRH821dFCqszpek413j?=
 =?iso-8859-1?Q?fAFXKr4OQ06mv68lteA20SLZPQPh5jQnXLDCjdYKgTpAiB5R9jSImIVwz8?=
 =?iso-8859-1?Q?ki2wbNFTMDwT2fIxa3UVb3LRiL8FZiK669yqnSaafypxHGsZyHphMrswl/?=
 =?iso-8859-1?Q?wfq4VTLY4NYpirtuJG+WGv730U7tUv6GvflCg0Og31Ar3kQyf6r5jI5/ej?=
 =?iso-8859-1?Q?4aG1sTvVRblUnbKrIn0JY3pJ4nmsJlNood5Qdz5oLnQtXNmVCif78qLcsi?=
 =?iso-8859-1?Q?Gr8poNPbhILsQ7FTnx2twHajipBwQdKstgxWLyR34chEfG0icvFRSbSpVy?=
 =?iso-8859-1?Q?+/ZtmOfM6bSnwK06Yg5Lh0zb7okyx8IzkLhwXn2Z0kOggxgXyOMsx1MZnS?=
 =?iso-8859-1?Q?lKRkPDmy2hwr+Jhczpk2h36/0v9Z3vyWzwQkwKrxEbtADv1lFJaYE/7MmI?=
 =?iso-8859-1?Q?wwDcyKnSM5rWWWT//9vlhfOAYFYrsOoxiZm+sN5tnYTRyPHpsq1MDPJGGF?=
 =?iso-8859-1?Q?/bbC+56XWP5+0ys0yZ3geJHKeB9mfPQddHlsBKKLEX86BQeGLvRjgk6ANG?=
 =?iso-8859-1?Q?pBBhBZ+EvhHevi9jkJf465G+sNOw+9HV7RHVXzgHx9GTQC6C+Z+r9UQQ5B?=
 =?iso-8859-1?Q?lcIz5Nj7x4QCXog5ZBGfKwGMQg4jdT2NmKTr4PiqwAYRdUys8L/OYLz5Ef?=
 =?iso-8859-1?Q?8XgQb5pLT3uecMiIre9+gHWYoSu03avoETNFbWFGAiBZMK+2TgBbY+nifT?=
 =?iso-8859-1?Q?oahTpAp4hSQE/MsUsd3Rlv8+k4dG960dba8FdJ4FFfgV74MwUhpKo/cGDL?=
 =?iso-8859-1?Q?62mJmtEJgGeqPHSpXKSufwzLdwims0WNxkiY7a8zOFsYVwvNXQqgTlVwqH?=
 =?iso-8859-1?Q?VCxGnWx9/ns1GhcTe+s2Vx5u65NpaeGFTFrrE0t3HArHRZYkpDfpiQl7gX?=
 =?iso-8859-1?Q?DOaiqaTzv+7IZDhHDfw6kXTsciecHOySLULpmbs+d/hyPMXqj0w72NYRAa?=
 =?iso-8859-1?Q?ocdgoGgnci+6fGHlHdOVVlTyNoXv39w1WzIe5UmWxwXznU2Ej6+8HDKGW4?=
 =?iso-8859-1?Q?wkdwyCSG//nrSZvFYHlDaSGsbud7Z9UNSKTiAtmPZc3tsS/dyHAnSS5HsB?=
 =?iso-8859-1?Q?w/u9LlphUoIVhnTbjcpRYj8NGFp/BfKF+85+e+lofKAwZ/ZqzHEmOnURvf?=
 =?iso-8859-1?Q?yj6ax/39NdDpWt1NZMb8DNgoTxRJn0Lb/mc0b8WNEJMDyB9PCKEBv4hiEs?=
 =?iso-8859-1?Q?/xuwz0M2QzXQAxEqElLprQTffci8xKzf78l3qmzSnYpdrx1fzBz4I9HYe/?=
 =?iso-8859-1?Q?OXWWrQpgn/Wd7NdxBNRIUAhvI2Be/wKMVFmLjx3Z93IM4gM0zJUtA5pY3G?=
 =?iso-8859-1?Q?fjYHzfRhTe8FioHsFBRD3LzNp5hBcGjxKoM6VZ5ARap9YsRaCpouQ+Hzua?=
 =?iso-8859-1?Q?f2/zxfZbQAtUeKZHM8k2tkvl+lHS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?k034lLI5fmPDTPwV8xK2vDJMt0OJc5afet7XzgIwfeSy2wJA7WHRVUguo2?=
 =?iso-8859-1?Q?8LT/00cbEZZbAp+JBDEaiKQjXIuT1uv5RukH6Ho88v7d6zwgFBLBF46aVi?=
 =?iso-8859-1?Q?BQYQPHcP3Wq1M0G3lYInu6qqA4K/drK0QaEJWT10a/Uec2MOxQoJUTet2Z?=
 =?iso-8859-1?Q?0o53GEgcBupJ7XqWfGKe5tjL7cy4eU46oHI1oTSzzt7Loc/mGHKweE63+j?=
 =?iso-8859-1?Q?l0ZdDAcJiHPvjXpH2A4SmIocuXn9v7KnWti+yk3Aq+W/eSeSl1xQoMIHTR?=
 =?iso-8859-1?Q?vpmpL9sNDe6uMTPP4i5YwKc2foMVakmMDJtP17FdbZkRbamJT9NfiIwDYj?=
 =?iso-8859-1?Q?U+KT6YdI8Q/DZAWultZ/zs1NNLh/Hx79mLLUAIhYG1qn5vZaLw6sHgU54d?=
 =?iso-8859-1?Q?jNm3UAwuOJzf4HRwiobuRReLinCUhyGvX5fcSUQ8o5dD/bwL9Ne4YHpNjc?=
 =?iso-8859-1?Q?IMN711pnknx8n4H/vwayXrrA9/kpM5SPPtX7jd3gIdt480qH0oQHCA3vi4?=
 =?iso-8859-1?Q?ZnVhAMqT1DlUgePo8qZh9T+J3Wn5Q1tu4JzZyIMrU/0/XMhx+yZOFOEdpZ?=
 =?iso-8859-1?Q?GMBv5c/SyDgx536VCALadefN2bSRDkaZUGGYvZ/PTSSLRuerdQmUhoz0NX?=
 =?iso-8859-1?Q?kPwgLTh21k88bOte9phZl/8TJZOWcWPlnPHQpg5zpVjD029QVav0w2J+Fm?=
 =?iso-8859-1?Q?GKL3XBUJ5kmr9Lw0+a9Y9VjoFVM0uKYLzzJx0k1+Pwdvp8429xKtnzXZ4a?=
 =?iso-8859-1?Q?M5g038feE3kpqPe8ZUDT7dBwy7wD/DwL5NA0/Rz9oQ9Zztqljs3mCOoSFt?=
 =?iso-8859-1?Q?qbMeuScCVmgUWS/RED8xnQbcfEfBYqqmA3VsClDOiKFrVIXiCszn1yYNgd?=
 =?iso-8859-1?Q?FT12PdiehHmJC2X3V/3Yj2iqpcfjrqRWV2A7HLf1WBPJllzsPaVBJvPzWY?=
 =?iso-8859-1?Q?lsJAw9+ilfY1jK2FVM4Edz28Q+eJjI0jrwqrKro3GOS0CWRAKuMMe0D1wh?=
 =?iso-8859-1?Q?UVItyyymqHw0iV6Vxe8PyiO6x6DhtCITMzZcQJdzFsn/XTA0HWfQnI6ONm?=
 =?iso-8859-1?Q?Z9LYal/LaiAczukMshfP8nI8k13KE+2VZS9u8MTEVmLMG1lVGFhuRmYZ8r?=
 =?iso-8859-1?Q?Qrnpwwdlj2iBFv4r9wVzzHqOVSeBXgAxMQ40geG5BmicpkJ2vhoagdCo8F?=
 =?iso-8859-1?Q?l7PZ7fLnpW3iM18ok1qE+1aINZaOUH+Weeq9fbErt5PUFUDvJYKVevfZU9?=
 =?iso-8859-1?Q?ROHH9cN8JRtus7JZ1blyNepkT8LTmLr17Et+Xr219LDOMMdFdb/xbZp4Rg?=
 =?iso-8859-1?Q?3+dGiq3aDlhX0kcfGoxSYKe5/TgA4IeJ3xTo5N2vLnDKT166D1n2j3bXpj?=
 =?iso-8859-1?Q?La7hrOluSRoZpXmQwOQ3QWkqghzIORGFQ8gMD6NdQMyEo1u4TvqITPLq0w?=
 =?iso-8859-1?Q?Vd37I7fyDm8U9ygAq2r+4Gqeccuq6Dsx2waprOPBtvZn48RQ8BBNA2HiK8?=
 =?iso-8859-1?Q?2V9bKrBl66g9Ld+qk+9Ak1eG0gZA9tvTUI1IrEYaA8v9bL+YwoZ5oSZCAy?=
 =?iso-8859-1?Q?9kdd1T+OZS97lPX/jQftDWBdV3BKrUWmGw71/nmJRYSztkNgwLAzWeoVz/?=
 =?iso-8859-1?Q?13hfCVzBpavFteOiwexvi/L3SjyywzaH+QMZZyQ5/VGjwfC6rOhlHwBpJe?=
 =?iso-8859-1?Q?71LRdSomk1wLXMz5V1VamonPHL65wmM3jkkblTN/0/uispbtHHAl6Pjwmr?=
 =?iso-8859-1?Q?5rOWLP6ZjKzN+s4JbSJPoCn/0ImIre5mka2jZXHyj9nGJFxvJ9LQWd1dZv?=
 =?iso-8859-1?Q?iJ7IdHBMyxAk8EVarQLwfQoeUGulA84=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a51037f-e4c4-4666-e92f-08de6ecb047e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 08:52:16.8340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iAIaRFs73gPfddmhnDQFNprU3ZcsE0eOtrWnUWDkzeqtR9rFY5nb3PlnmNNwy391JOuwWqFi64dO38SwmP3YEDHxkDqPwaJTDHb3srKmOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
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

On Wed, Feb 18, 2026 at 09:48:04AM +0100, Morten Brørup wrote:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Monday, 16 February 2026 19.00
> > 
> > The documentation for rte_eth_tx_burst() uses the word "sent" to
> > describe the return value, which is misleading. Packets returned as
> > consumed may not have been transmitted yet; they have been accepted
> > by the driver and are no longer the caller's responsibility.
> > 
> > This matters because the common usage pattern is:
> > 
> >     n = rte_eth_tx_burst(port, txq, mbufs, nb_pkts);
> >     for (i = n; i < nb_pkts; i++)
> >         rte_pktmbuf_free(mbufs[i]);
> > 
> > For this to work correctly, the contract must be:
> >  - tx_pkts[0..n-1]: ownership transferred to the driver.
> >  - tx_pkts[n..nb_pkts-1]: untouched, still owned by the caller.
> > 
> > Several drivers (and AI-assisted reviews) misinterpret the current
> > wording and treat packets with errors as unconsumed, returning a
> > short count. This causes callers to retry those packets indefinitely.
> > The correct behavior is that the driver must consume (and free)
> > erroneous packets, counting them via tx_errors.
> > 
> > Replace "sent" with "consumed" in the return value description,
> > spell out the mbuf ownership contract, clarify the error handling
> > expectation, and update the @return block to match.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/ethdev/rte_ethdev.h | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> > index 0d8e2d0236..9e49c4a945 100644
> > --- a/lib/ethdev/rte_ethdev.h
> > +++ b/lib/ethdev/rte_ethdev.h
> > @@ -6639,13 +6639,24 @@ uint16_t rte_eth_call_tx_callbacks(uint16_t
> > port_id, uint16_t queue_id,
> >   * of the ring.
> >   *
> >   * The rte_eth_tx_burst() function returns the number of packets it
> > - * actually sent. A return value equal to *nb_pkts* means that all
> > packets
> > - * have been sent, and this is likely to signify that other output
> > packets
> > + * has consumed from the *tx_pkts* array. The driver takes ownership
> > of
> > + * the mbufs for all consumed packets (tx_pkts[0] to tx_pkts[n-1]);
> > + * the caller must not access them afterward. The remaining packets
> > + * (tx_pkts[n] to tx_pkts[nb_pkts-1]) are not modified and remain the
> > + * caller's responsibility.
> > + *
> > + * A return value equal to *nb_pkts* means that all packets have been
> > + * consumed, and this is likely to signify that other output packets
> >   * could be immediately transmitted again. Applications that implement
> > a
> >   * "send as many packets to transmit as possible" policy can check
> > this
> >   * specific case and keep invoking the rte_eth_tx_burst() function
> > until
> >   * a value less than *nb_pkts* is returned.
> >   *
> > + * If a packet cannot be transmitted due to an error (for example, an
> > + * invalid offload flag), the driver must still consume it and free
> > the
> > + * mbuf, rather than stopping at that point. Such packets should be
> > + * counted in the *tx_errors* port statistic.
> 
> The above paragraph is driver centric, it should be application centric.
> Suggest rephrasing as:
> 
> If a packet cannot be transmitted due to an error (for example, an invalid offload flag), the rte_eth_tx_burst() function will still consume it, rather than stopping at that point.
> Such packets are counted in the *oerrors* port statistic.
> 
> NB: In struct rte_eth_stats [1], the error counter is named "oerrors", not "tx_errors".
> 
> [1]: https://elixir.bootlin.com/dpdk/v25.11/source/lib/ethdev/rte_ethdev.h#L273
> 
> While discussing details...
> Let's say a packet has 4 segments, and the driver only has 2 descriptors remaining available.
> In that case, I think the driver should not consume the packet, but leave it for the application to either drop it or retry transmitting it later.
> Do we want to mention this case too, or is it a semi-obvious case of the descriptor ring having no more room?
> 
I would tend towards it being covered by the descriptor ring not having
room. If we try to cover all edge cases here the documentation will get too
long and therefore less likely to be read.

/Bruce
