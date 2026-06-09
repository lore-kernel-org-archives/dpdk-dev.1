Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844BCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D823240689;
	Tue,  9 Jun 2026 12:22:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 36B2F4025E;
 Tue,  9 Jun 2026 12:22:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781000539; x=1812536539;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ccyCOh0dXmSzAYH9AHIj7IKl9hBztN3KrJ75zVGG+CI=;
 b=P60YvgR9teIYNLz5XKyc1VRvn3HxRigfeRpGbYRXuJBNruLoo83iJSGY
 lPztTijWwrFXevqCSuKiQ8qW2Fm+FD3qgZW50+QbnlcosCfDM7w+RUZav
 ueN79nuklWJB0VXWj5vO1HLZyGiAPBPhYJIW4dIL3FtZ4H6LeXBeog3yN
 8kkBBsik1tTkrbqOozVt9EODYnLDSl1oiR/v20f8FNfPvfjUVyvvtxXHl
 pjRfUUQ0MeyHk2gAWoDpc0WqzbhX6845locab90dv4D6h4lfBmPBF0GmI
 immPWFc3+uoOrYOPBTDPcpVVx2moMkp3VhaYCtGa4ZsC6AXJrVUgdRrqx Q==;
X-CSE-ConnectionGUID: 7Tunej3yTxmSGFsqQWMTAw==
X-CSE-MsgGUID: qxzDn7GRQpqvb26t9BKIYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81663216"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="81663216"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:22:18 -0700
X-CSE-ConnectionGUID: 3ou0/8fsSpimRpl2kdxs+A==
X-CSE-MsgGUID: ulxPmZDmRQC+s6f3925/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="250108402"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:22:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:22:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:22:17 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:22:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeez8necFg7I5aHskekP4jA5udwP2lWuHuJ27SFm6ip0KIsrB/n9t0DdiCH1z7G5R+RX5du/DVvYz0l+tLZzkrqED8OIoF09LNNBjphGReV3iykbxm5/G3Ipk2+4IXXWWuUl/CMLp8KMGYzk/vxk1r2WOzI75Lv7cNUEfAHTf22W+bP5Zx/PC63/AmAwiY1bAGhyeVUi9Mr9xTXSUXVXDe9c/fCacKGNrJ/ZvEwhEvlgUh0tTSc68ujlslDDBjrh6VsoDaryZNNX/YM/Kd45VU8QdsfmphF7jK09KqRDQkeMjC7G5zvHtWxgSVswwXwczffol54hLNKbUAYFN6NTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlnvjlJUeC4+AjuuFkGsMepPPBy/z/U1nQSt/IHiVZU=;
 b=Vwe94470PlOqPIU9QivvlQHkmYFSCPWUrXu6sYOWwyawHcHj8EKoO2YV0Ag647NpRtKhXX9ARTtawGFwX9WPt+IrvEY7OCRgSwEjiboNdH7rF7Q80F8tqFZqNCRiaC7hZvcqYRw+SQKp/MuwoTVxHb3tPViTI2CxvNrD1LrzlG7I+movdbI8QLQ7C7BArvSY3vs+dkRXmYAVhoFzw+LuTNoaGd22hqB1/iMK5IVfVpl4IpxYLJKQCWzZBuoGz3i+vPPaNN+KbeLuE46OXKLAAfjc3FbrgeUDtaMZpQ3HhMFp6a8HpH7DNJlY8VnoHlLRlm401ScODMB/oCXpIvfUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:22:10 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:22:10 +0000
Date: Tue, 9 Jun 2026 11:22:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 2/2] net/i40e: fix blocking link wait on device start
Message-ID: <aifpTgJ4SH9riumb@bricha3-mobl1.ger.corp.intel.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
 <20260603143407.1108527-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603143407.1108527-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ca2ae9-3cc8-434e-ee34-08dec610f751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: wWium5F6Jer6UXCud+ly7reH6IORiVW73M/G3pY2rPlllUbh4kKX+HqCCcuys7Be+8U5R9c0g9cOAqlcObchCFQGJ6/H7uEnyf4BqdX7ysr1ExEk/mqyGJynCclF5UDVM4lsUBvKvBYW/Db+s2nMf8lql1J2etBq9VL7UuJamDV/iGARwuzmlCIQhl2qcdpwNoDotFdb3e4dbM/SkE+aRKeQs/m3qKlHaYevLQvJRbiQnW3rS1bRjVgajDjr0FrTydS522emktZSBtptasORsqG9c/HLihbEsI/+UCODJ8erOC5K5G6MDIqngxugRaO3wHZcwFvcB6sMZHCjBwu55UbhjlSuXvtS2iMXL8VGBv1I5XX1Vf6iyvJIEXZqCvlicRMxiA9NVnCI4hf8VDN7Go7XarJICQm32PcbE883ev7r0wszURIg98V6p9YhenLGRygtn88zjNc+cWQiEsCOlww5ogepdv2pU+XyvqpweOLpWehrFv/VzN7yPBwueQ4l+OvPig5kMNNnAGgai44u0u7y+0Wxp/TGBPHfFTAIGOhFA8XTI8QNDqVXjWS5NW23hy36WEJJrcZYPS2mTJOKJP9hbqDV1WtXQtUv+C97YmJnr73iHRPrAu/U5nXzQlbcbpaPIgWYvBXcS9mh0pVEzqX2RIZYwbvlJz2E3YMrB+c32cqyzn65MATawqFZ4h8g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pqcLWwvZAOX4rfQw9H/SRYORRR9f3PpTcdjhqze3SsSSYih+k7yvs+gcWe7J?=
 =?us-ascii?Q?uyCObDSxMahL9dMv5NCpYC+KOUP/tY0yUiXys+VkPwyZ0PgxDOoQTo1jtnSJ?=
 =?us-ascii?Q?J4Cq3gbKAJGj5ey5dgRCaHKd8rd/8XEYm/36FA35XcgqkrRFBc+3sMehmnPh?=
 =?us-ascii?Q?XV3mpuoutjfKWzfjJ52ShxcsdJkxJH4c/G29iaew7buyrbJjVo49al79j8+X?=
 =?us-ascii?Q?3XCAHTVuCTbdVbBbGsXPZr12oiKB0Ssqv05paOyirXc5DJozGF8SOWVlduz2?=
 =?us-ascii?Q?1a/wRp5iZ2g30wLGUdYSmWMFSL7dAylAARubcpvzMoVhJfqL6kybos6Nl3/B?=
 =?us-ascii?Q?1tZIOR3IK3sD/yGJp3ntOnnNqvnHzeqqaA9nS6+StV6Q0pOpiHyidbeC3Uav?=
 =?us-ascii?Q?pwaXnvbyDqJGNtjxp19pN5FD5o+c0zN4b8S49EH/YMpGlJOvrP+r82yyV7tK?=
 =?us-ascii?Q?sgB8gLCoQOrPK5uo0fncR/ZCifTJGSgLgpDbOT6H2GfyBDYk4q0jix+1+dmc?=
 =?us-ascii?Q?zj06oiJS0Xfah7oQ9izZtuhRGxWkD6Z/2buhsZ7D5XfdWlfJZAMlbL4PnNTB?=
 =?us-ascii?Q?n6+qms7CKYBdQ0BB3uaSjzJlVws4VVJgPd4i/+O/+M0mFJKNytUCkv+dJc/I?=
 =?us-ascii?Q?560LJx7x0G4hdYQUMiPSZJrEb8nl0Mlc1TG5B63rxP3TluKdmFEEZnmv7lZY?=
 =?us-ascii?Q?+DjmT4Kl6wInYqB9Q8YObJoLaAMWVc98+/lKY6h1PejLNb0nYSoFVSdXykLY?=
 =?us-ascii?Q?Q3q8UNRwYeNa8BuENm/PMi7SuQZRIRgdSupRHsaASEVyiiFxjAl4VBEM0wWm?=
 =?us-ascii?Q?AFiK888UhxLXXVl/sU7YTJ/bSwthr1F9FGJfgpePwv1qfGiq8BaJgQf3ts6F?=
 =?us-ascii?Q?4TOb6fkehmKOyIN8hFpCZhUWw956ivpAj4agcTdQOXo1zVTGhumxos/Q8i0M?=
 =?us-ascii?Q?70URqrkzVmVVqsDjlry+arhNA1QzMnGZ8hXXVsT+E7RzQq2c40Z5A2DzjjnQ?=
 =?us-ascii?Q?/fbVRSH9sIpvD9vXU5R2dN0I9b6vxupM1bIpnIcr/IabowZvchtHKFL4NHbU?=
 =?us-ascii?Q?ZwL7jZ4Am5bOtblxLhbSD+NWYpZR4n/pMuwHkSCEjpq/03xEmCjTxEOawW7y?=
 =?us-ascii?Q?yD4a38U6jBt3/rr88bx33RQYOCFVH/MUDXUC1P0DZcADmcoMd536obpbFFre?=
 =?us-ascii?Q?2IGfBK3Z4WuBffItC4ndnVjIf/x0O0qf/ZOJk9E5VjbTn0sYaIYHx8wLbyYu?=
 =?us-ascii?Q?rGRkpf5EQNHtmhD/mbcpFuhg87L81j31oolTYYeNHjthVeLuILcvIU5LlOBj?=
 =?us-ascii?Q?B9748M6+x3DHdntIoO5oEtHsESSifbSplFjZxFn64AjWkKKlUhmthAGVcGPo?=
 =?us-ascii?Q?riX38XQpqGZ6Zn4Vlludu6tfK6YDh9QgKlzI3siEa9syo3IDwhuQjsh+jd7T?=
 =?us-ascii?Q?2gZsHJqcY4mQksWQEiA0WYsZFiYFRPM3w/EqGxc9gvEx3C0BXNUPMqpVG0xM?=
 =?us-ascii?Q?UNZR9unTx2rZKTOyWklineB86SWNY1Y1u+cGThoxigaIBwi97vKxmevpjihx?=
 =?us-ascii?Q?EqR4ign3I+EsK/3CqSUfvRI2HnaGpxdcPXRhsG8Kg3zeGauXTg0McElqd4Hf?=
 =?us-ascii?Q?e5b2IuknOkb5CDz350gAg65MCAuj6ktHJcJpdsN//4uTRgbb1bk8LpFzWLDM?=
 =?us-ascii?Q?Ac7JJz+MQFKvaK9gZe2ZURy7p9epOg0bWaTfpDJGdTkjwRAGISyLeWnT0fCx?=
 =?us-ascii?Q?mjPrI0nGbNmiehScRCye5GEMwLiqlXs=3D?=
X-Exchange-RoutingPolicyChecked: N4JHO5d+3itbnUbJ0Kzzwshq+URMOL6HOdrnVsoYfv0rxC8U+rdw1CKGNLOVkvRO8PAbIsF1Dlx3lkbnDjv7jxYMrFRX2zzg1zQxlH2GxG7WHTnMCpTUyaBPgas4CWDELvf6caejIBQ4eHQjr82LpJsg5qi3QepDOnu5cNoKKzP0sG4jpZWT86oV2I2EsTgCzVnWlj5ckgaa8pBEZS7UkRBFAAeF9T1d+8j0IxNQrPGa7OFJ9GowVTx4oKzbJms30XHYrJN+fZi0bGqtHO3TqwHt+Q6qtg3N7+v578VDk2QLlv0uvFbnQzger6NBb8BexKCzXcCv7ZKHjeObpbnGrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ca2ae9-3cc8-434e-ee34-08dec610f751
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:22:10.6059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPS5NPWArPayTFREFpWWwG6aucDYL036OyVhdghZcS0zUEPap/ID9M3nNabOlBF5sg+JnjdzaZgl6RLJ7q765ozaOkuZmOkHn1A3+xC7zKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
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

On Wed, Jun 03, 2026 at 02:34:07PM +0000, Ciara Loftus wrote:
> Currently, device start performs a synchronous link status update,
> blocking for up to one second if the link is not yet up. This causes
> unnecessary startup delay in scenarios where the link partner is slow to
> come up or unavailable.
> 
> The wait was introduced alongside the maximum frame size MAC config
> command. Some devices require the link to be up before issuing that
> command, so the solution was to block at device start until link was
> established.
> 
> To address the issue, remove the unconditional blocking wait. Take note
> if the link was down at the time of the MAC config command during device
> start and if it was, re-issue the command upon notification of the first
> link-up event.
> 
> In the case where all interrupt vectors are consumed by Rx queues, no
> interrupt or alarm handler is available to process link-up events. The
> blocking wait is retained for this narrow case to preserve correctness.
> 
> Fixes: 82fcf20d039c ("net/i40e: fix maximum frame size configuration")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
