Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515A9EA3C4A
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 10:52:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64C244060C;
	Thu,  9 Apr 2026 12:52:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9836E4028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 12:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775731954; x=1807267954;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UTcfMIpZauvbm9M3u/OkhIkFLqTAASGqdx5Q9ocsWCI=;
 b=SoqENdFQxH7GAdudmBjnXCIj7wuBzhpgIlQZXjXjs9tukT2PDg58sxbT
 THP0Z2uMI6S72NdtOa6p0VczvpC8yaOSAnbKZEcIZsb51hAD7PaJDe/o6
 NCqvw8RXiZ/yMW9mphdFgIj+HV69OEJ8YfEQLHVb4UUs1Yp2plxY6SIHu
 ODLwIBnc55mOfpewZ0Eghe2Aqp90Oz3Abb1rx25TOL7CUrzYfELKQTcx9
 xOIFao1iOfKSsM+5md0FPjWtCjXyGMnBsyDoOQ31B0SQGdcsRmGJh1SIe
 fXFhAltDjekv+MYhzXQZqs8H3qxmktI1FiG7mIOCzEx44bMQjOiXgfXIN Q==;
X-CSE-ConnectionGUID: IZV+XQUSQcuKYBDyguEgyQ==
X-CSE-MsgGUID: V2DqVnNZSZy5KbBZA9KkqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76612648"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76612648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:52:33 -0700
X-CSE-ConnectionGUID: NxjDAMlBQfSzqcl+cSfX7A==
X-CSE-MsgGUID: GAhgDXEyTuaUUYLTtpUG7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="228668562"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 03:52:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:52:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 03:52:32 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 03:52:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxmU2Zq20uERWYz/8i+6TNFCdjnb6qpm8WmuYm7s8HJjkUZ5IzNYkK9xlSNc1wrtyRu4zkeA/HXkW8BEeMEwxIchwWJ8Vmyk0Zn2RoioMLCbt2xs++Fl8z8EgAykW/G1kOpkxKfDih3d9WkjRKW0NJEQsKhuH77KtJxteriO/B8yGHqs12Tqcamu/dvHyCuVikVebrs3ovUz6ZsNqKEXWWSDYsB4CnSH5FQOXL1HX/Iu9Y5uKoVsPv7iU8CdQ8qmeobTdQ9+A5NhZXf/4cxwbDvrKxBtGrXh2/WKw+PrWS1cN8UGmz1ilo5ne9rlOtoaxNR+bIq9Fjac7EYggS9IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJqIDwHxi3zUyQQoPZgLnLjNX5pP3qPX0yBJGIkMfI4=;
 b=VJfIno2KlpVHgKpNpwAD+nI+4YIVZ5R2IgFIm7KU+5m2GH1tw5cZBGJQ4+BmlsEKIqbkitEfL0tjmpBrKc85hwemnoZXd4wPw0Kjse1oB69OMIdMI0nCg391B24hf3Bfksk9fJ3lCBb0L97okix8e8jam575NVihCOwmyiX6J4yl/4aqccvgxgIUkjug647f7U19/g5JcF9UJmjG781AManeuJ2saV8oSoWGdEIT++Y28VPYBcJ7X/hMPEWjJOq6oPsscoFjECo7v6Nq/JucCdLK1TglQ4FOX4vNzWhs8Vney+fmx5lC+kaNPz/2CX3ogtsyLUR+YDJKc9aa6R89wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF2F7FC4EE6.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 10:52:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 10:52:28 +0000
Date: Thu, 9 Apr 2026 11:52:23 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH] net/ice: add missing SMAC field mapping in flow input set
Message-ID: <adeE58nk11uiL07W@bricha3-mobl1.ger.corp.intel.com>
References: <20260406081439.3241409-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260406081439.3241409-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU7P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF2F7FC4EE6:EE_
X-MS-Office365-Filtering-Correlation-Id: aa249d00-688c-41bf-a249-08de962617ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: PViHz5yLjP6PIjR7v2KEQ/qOZebKQhEgmB7g2fVgHBLcNIN0lkY0gqG19KOiApsH9OXMUcaMpQBa4Xxk20FDq7eUCwnCwpnEj4x+6lIlnmgE3I9al04ZoyDPxkbqMkzIHDiXyyO7sG/T7uvDesRRJQFysUfOgvSKzocIsKES6YvQ7byG7fJm2mUd8BncCA04YdVJeuoLcdaex+vk83wBYBJfTH6+0I1aGxrglVChTBlwcG/0VuJwFk9uvHln/ZrLHBxWMk1gl1KQV0FzHg58eNClvMBBvrvHjOZBGOvBhkMZPr1C4hC33Aco6Rjv7WndPbn4Q/G8z+76c1kQqMLNwzwYNsRyfr1YfI8D9AF0Bof63WsmwzWZktkZsNZcpEm0MAVLpBdhCB4aOe0rhs7lB69pjXkKaffEbtWHpCK2RPETZJGaujQPryRdnWFIFq6KBMxQ4LojEUkdMWpNPr9HCnUqokspAGgTQVfUFzSG5jNQa7iRqjmrjSjFmPFwZzpjkZ7CiIVwrXHsKZFUKkfNQt3b/nIEX2iJVn0Hoky4DOWvZlT6QVwiibIH/Hjon5J2yAiUdD69WJ7BP026Y4c7pxyMCdqPzA2HZMmNkrIMiK+nJC53ReG5xRqkiTpTdh29IXlnDfOqiKNaokqjKIgQX90CaKOc3pqpF9IlyLyWeQ+rMYgYV2irN1lOvQZNSMiuVsTqASh1NhKTyK29alH7m3go1dCVL1kAEQ/V9axdkLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ac1j/B3Ql51N9z9njzbWkV815W4z9zhhFoRRDkP0Vaql6AV7oV73rWujOhIr?=
 =?us-ascii?Q?9gI4LKE3jFz1Jh7w7AI6R9CB1g+6ntZy0ca/IZLkzjJB1smt2gklRf3r1QHf?=
 =?us-ascii?Q?fBXGcbaGWI9xx4EPw0k8yy+AkLOlEktrEZHNeQWg1P3ILM47jSdheW4Q16Pz?=
 =?us-ascii?Q?LAB10n/SgsqDWSTmUIWkVyxNylKN5IvAobOfPkQl46csyYd+z7Q8BQtK/u1K?=
 =?us-ascii?Q?iNBLS0/DsvKZmM0pcShosprRomrUehQ1yPdP/RoogpBveYszWad/cQjdOAeE?=
 =?us-ascii?Q?90KLC1vrz+9BYyrBz/7vNN9AMRDp0NigOySZ272d/XAUVxAJvEYO+LoNnpyN?=
 =?us-ascii?Q?+5XsH+U8F+eha0CYfxt21/82RIxgvL8vwexcZgaxmieotHC6gSXHETGGbfol?=
 =?us-ascii?Q?Sx9ICukahSs2ERHMeP/5rZXXGrXPxYeT1IGevCL3puD6q2h6JF3qbfu97YAK?=
 =?us-ascii?Q?R65Gy+oObZj2AKI3vjY1/TuEb9vy1bwRu6o7JeQc4tOGFqeM9puapJF6WZTA?=
 =?us-ascii?Q?Tn0Gl3A4w+/Y9/JdrIHyq3o2Po9WYdf/jX3VTsxr6nssOlsUcYyBSmp8kncZ?=
 =?us-ascii?Q?zu2umdas+PGAiSfceDidnMCivU6/rgepDti1E9a+Ya2YkMBPWAr0owZzZwQv?=
 =?us-ascii?Q?c9se8mLuZOdk5L6YEqHMEJMxjT3f35fcbfYDZr00oSTr+D7N338bm4c+laxA?=
 =?us-ascii?Q?6E+qRpoliVo6xY6qtOric5omn2z5jdPvIb/VhTJ5jGZxfqFEZamNosg9z/v2?=
 =?us-ascii?Q?AOJqgT7xigwwwros8kL6d0+E+qZgh9UV4yoCCft3ZAwC8vG88bU+n4SIk0FZ?=
 =?us-ascii?Q?efQMPG9ho3pEUVYjGEwBs5+0AeuQgn3gGvbtQBFbhHQZi3OhCTUw2MpaT0r2?=
 =?us-ascii?Q?4Onna3RCwM8JF/KMBzZdDCmA8MLRjLN8ePF6GVGgcTfG4Q4pAWH5GCzeWZOj?=
 =?us-ascii?Q?ktp4qgH5dOEBg4SoaU7cQc6dWuDkAOflB8P6BAswlLRN39p3fdtHxWjc9pY+?=
 =?us-ascii?Q?iRW/tXRMTMZ7uOqoyn8MUudw6xhntmRluhof4XO0vF4br4V7JAN2QW1oVW8Q?=
 =?us-ascii?Q?BqgWzgch5TdjYHymdFBZcwM8fiqeQLoT9wObVHPb+Wrk37GEybz2D/+XoAgj?=
 =?us-ascii?Q?WcGGdVbxGERomX4s8udrKUy7iYSxEewKJZEjO4x+YHjC5x9lZXeK5uQhDWwm?=
 =?us-ascii?Q?7L+lC7o5pUWIZNeD4btvP7rMdmoes9swmr56g48sS96SbmLg2HitnzeaPsAd?=
 =?us-ascii?Q?eNtVsGlORnNwjbJdxh6BhdANGJw6Ffy4o+v2NIQ3uIgWG4SGKDHng8Z+uh37?=
 =?us-ascii?Q?GR2xW++xpEHrddiwVnsLDPXxE/HSrqNMpPsnNK8iEapjmK7iLtJzwHcjC+Lm?=
 =?us-ascii?Q?DGiq77MAmGylowOOlb6bNnfF1E2ywb59GpJEC9Fg/K3sFzlRJ4uplblJJPlq?=
 =?us-ascii?Q?GuQwP2sH0d8Bj/JfHSgewTvO9kZiaJ9Nno5D2U6udxHMIACIARWUz9ie+09Z?=
 =?us-ascii?Q?ESORTgHoe8J1d/Aq2RFvGAr3e696WJw926ruCmpED/q4u89OK19wyOrl+ug0?=
 =?us-ascii?Q?s2G3Libl+PT5wgK0VPtSMKa6UI8b6Gp6v0Tsznr5QgxXs2xGvZB47yNqTytb?=
 =?us-ascii?Q?8TB544OwFTsRW8Zo/oPf0G8W0r4ID3O9j5BnV6ADuTHcTisuchE61JxaJMTT?=
 =?us-ascii?Q?oe6YZvxdAz4wMgabHzBv7ifHZ0DBpSKaM0RKVv2SStcfMpvzPjS2MIbom7JC?=
 =?us-ascii?Q?9yw8EzEz9eCA32Vsg+l15foVHMdyfE8=3D?=
X-Exchange-RoutingPolicyChecked: HI7QzXywiTNEBxgklQjqz5u4nU/sc2ykpNE5wn8htc83PIq9xMJvAm/8ZeUnRSU0nacxosUoYCSNpnayAKhcCMwjs7jO8qqftHYdoF3gH/BSY4MHtfFiaE4nTqXRw7wZh/bOX5AzG7ZFH4dhHzf14errDDsmrjvBeiIYz9PyB6K0/Svp6OQY10LoWtHU5iCFX+d/sVV1kSfeORAO5bSylbkdwd8pPCCDSsJg0ABAz5cAYHF0fft7xTzWA3l6yp6pQPqEFUppSfTtOwo5q1VNGvyv6vS0NhkKvYVFTcL0p2pb61Nw5CKsSVkZFAVuQ+zGzeiynnJXfilcDhFIdALruQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa249d00-688c-41bf-a249-08de962617ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:52:28.4476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwH52hvrCKm7S97NnjZdoYg3+qUX2FibI0XgWAF/FPrQG7foy+KvQ7vn6rWPcB+6xcUtNn4IPML2vKY7fQpM7RIbKVKg4Zi4B/N1/Ic8cFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F7FC4EE6
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

On Mon, Apr 06, 2026 at 01:44:39PM +0530, Shaiq Wani wrote:
> ice_inset_map[] has no entry for ICE_INSET_SMAC, so source MAC is never
> translated to ICE_FLOW_FIELD_IDX_ETH_SA. flow rules specifying a source
> MAC silently match any source address.
> 
> Add the missing {ICE_INSET_SMAC, ICE_FLOW_FIELD_IDX_ETH_SA} entry.
> 
> Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
> 
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
>  drivers/net/intel/ice/ice_fdir_filter.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce 
