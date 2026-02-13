Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA63EDF161
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 13:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6627402C0;
	Fri, 13 Feb 2026 14:31:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1813B402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 14:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770989506; x=1802525506;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=x7pGn8nXyhFehuziscoRQsijwco0SAaZ5SqXE9a2zS0=;
 b=jmGUxkILtgUiOenEreDoPO3ZxpXBg9epm2BUptkT7irZkeFpsNJo355t
 OBwMZcM5bI6eyXYyQSRTrzoXgxz2YwEN4D5KKKDGKjjXnp0plaE5s7U0q
 D8sFeunWcasrq+vJwHMrWiJQB3xCnAZx4XjN/QYBEr3FJJUbDe5cRZZsJ
 VTBK668lyrEIHvl4OEASqIMGmmf/U6gwTwJFlcFGtGzUJh5rE32+nNxRC
 tnqlpLJF85i+A2m0xykSDnOl6Qm8rkkWmwi3y4RAkeYaQyZpK/voXbuIr
 oi3AYzBYSLQnxeVerTN2ORb+zmDklMK+BTODfE1sFX815YnuTRwcM1Nva Q==;
X-CSE-ConnectionGUID: YALFjo0jR+Cz+MI7aQ0K1g==
X-CSE-MsgGUID: 7lnjQopfSDy89x+qTiPnPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72268226"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="72268226"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 05:31:45 -0800
X-CSE-ConnectionGUID: KnyIAKV1RtWNJVCn+RmFlg==
X-CSE-MsgGUID: pCFfbXZgSNCstAOSqnAT0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217893410"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 05:31:45 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 05:31:44 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 05:31:44 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 05:31:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsG1grgUYeVtzJyDtCyZNpRiHZby9N0br5JIhfUlY1l/8VBZ0tQnDLh8xXhk17jP5ZwPe6VP5MxgXBc6B7RhliNpn1R1xQMJqKZnVJBQNOfg4HyN4uVHiAl/QblCi3Iz1tKEKBXCkuU0w3sQwVL6AlEojZnXKh3RcPRhXw8RpyIoWp2htmjJsMonPGOrGhTfa7JSrqxryhSqdhNBuU1x89NN9XswG2+mpOHpbZDVL4rTaMvWOvW3tOACUX0Q2hQJg6L6Tfqge1CdolotiM3C3HElJ49NCDpyht4QFgFDUiZ3udJmsjZRQl/CFJRLLCp0cIJfu66/vfL8rf67ggHJTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EcTCfUSaXjuenmUxUVJmP8fH5Ra4vN4fr0KpkwPopQ=;
 b=jvKzq/wv91I4WO/pliGaOjrX7A4mxM2ccJ+u84xAc3QgwM3DgFwQErtTE9boacn6qdCzf6ljiWc7KFaCOOdvJ6rTKUgMrupr3BcwDH//WkLsoBPzp2qdCf4HybGkVP6vmuvJ+ZQqAM0bWEarbxb3esIiVae/V9gn3VtMdYa242uFWfw4U7/FaAD7BnwaqFK7e0p+zjxJ9iAYH6fFpQE1n+47r3bm+zGK4609MDdO41s8A5fGk3kW7r9eG+HdtO53SazXN4lkdCAzTGTooCMdkLXwtarJjBYwxLbupfr6FLKILj11ENfqJ53cfbDcmivROTEoELHVVJd0v166pXqoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 13:31:42 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:31:41 +0000
Date: Fri, 13 Feb 2026 13:31:37 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/iavf: fix txq flags setting after Tx path selection
Message-ID: <aY8nudNClFDB0OPK@bricha3-mobl1.ger.corp.intel.com>
References: <20260210095045.1901921-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260210095045.1901921-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a300ad-91cd-4879-bc85-08de6b04392b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OOX2+nqCHDVBjxf4CgM2HrMzkKMnXxBgZ0N9bNgl4xJOxUwxMoKZzHIW4jpM?=
 =?us-ascii?Q?P6ap3EziOIcUbSH+Dx+baHHmPCfQQ5aybOJ85lVtRkkG+566az+WxDv/n2SJ?=
 =?us-ascii?Q?lUK2J+S4p3BZ2buujtALVpoKGAx87Cuo6KCw5/JY6vAyoSM2GU9Aaz736iyL?=
 =?us-ascii?Q?RoT1wonowH91rXkla28mcbAfB1wRsPNsuM9bBU1QbDh/rXIDZPzgiHIrKSzA?=
 =?us-ascii?Q?0XjIHn8JwbeX1V7F/Ufmro3Yglf3aI+unYNXTgcsRYPOEkR50Y/TCqGOqIG6?=
 =?us-ascii?Q?aSAfeqHmyVmywzdFPmfFabUeYjyhFDCPPKcmqo+Lx97yJm9QmCOPKAazF2YS?=
 =?us-ascii?Q?4EDWZE0u4Gz8JE4GgcH3xFFGpiUwY5sUcQc6GZ3ydGUY4MEEezxzYOnrBtmZ?=
 =?us-ascii?Q?hdUk5ao0Zkcz5T4TuRa4H9lUxQodTV10OMBRBZU6EeGkhyBCilrqTtok0kxP?=
 =?us-ascii?Q?JQfqHFtAqog1SmICs5bRNiI95DJh3EC4spg44jBaSlJQEmSuKe8Lk0RNPjtH?=
 =?us-ascii?Q?kxwpkyJXZXHn5H7sf3V04V3cFTwY80X8i41qduaV/H8bFWKtb53nBkpNOVaa?=
 =?us-ascii?Q?R7n4kx4JLgVbLpuLmpuE0nS0jfP8L9A4zWqOANdJ23G0yhljJTUCL5dWuoSY?=
 =?us-ascii?Q?IUTiznz0slWcPRKVL27Y2IJXRZEd28s8UssQDc9FyNphLWon+tbr9FyoTksS?=
 =?us-ascii?Q?z6cj1wfGedZtje/4S7Ul7+UpP1Y1nIWu4+5YRr6va+NCRvejtlRVwE34HYTC?=
 =?us-ascii?Q?EIc+JJX5e8ycDs7PKCn+pbtci4M0m80QT3gOskM/W26Vr5GtwcpU2AfTlvvj?=
 =?us-ascii?Q?AGpM1649+ew2fZOOrnrfCOoB5E+9tr3jOND6xTxNW6ta+jmqtGmgMDOI6dKN?=
 =?us-ascii?Q?AEEtcOwWZ2C/b+YoocELUtOzq3l9Q32QewiNhMEWPKRaSyW5pRhr3SLjAM+X?=
 =?us-ascii?Q?otot6wN1UkhDEv/wbNK4ccUpnuIr1QbIdorFekfVkM6t8gRsAXL5OfVZ4jzs?=
 =?us-ascii?Q?5V/Ezxk8nsPGzMbrAJuo6wnVf40ePTD57c/RUKi2MUtf6MkMGo/8cyHZSYEI?=
 =?us-ascii?Q?yTk9KrPmK78XIyjbwlJm5optEwzETN9OMyydINMAomobuEnT9rM+WSwD7vre?=
 =?us-ascii?Q?3IeGSF0yIWzowmX+bv7VAIa0c9EjZjrjoTOsZupZmA3R/cerm6JDhQAe0s2q?=
 =?us-ascii?Q?lqqhdRD9ogjxVrAuIHK6Cg53xrQMAXjS6JTErYDMwZkubQLI47Ao/9XAdjKV?=
 =?us-ascii?Q?i3UZXaqXyMqTP4J9HpR72HUxEfSZbXGFh0TF6PaYNzshEaJeJtb8mUjgY3/i?=
 =?us-ascii?Q?U3Funx461yuqkAD5N2fdI0r5jJb9e2KdoeoxRWNzmg4ObiFfzojd6tL2CCU4?=
 =?us-ascii?Q?s+0/ZvaWmg8uNakFW6aKpwYA+ck28f7gRymRdoBuN9HPhyg4sObRT48y8aCg?=
 =?us-ascii?Q?4qHqyoficFHLTe21wYZQnJS6iNh4cVeX2Oh8z85f7nx1EJT6S33ua0lRW7w9?=
 =?us-ascii?Q?JVrkvn0wFqjNvrgvoLcM+HFj7l83R/vI/YZn1yZAI/ulaUestu6wOJnDSHJI?=
 =?us-ascii?Q?BhcljpxMKDcCtBaCC/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZ4TULflgNVNahqDlr7Df126mexCnHc80DF+aQfb0vzQEYxsAEE9x4M7fNdt?=
 =?us-ascii?Q?TOd/k8acplpvrl4DGd/98WBui9BcqI61KTQBEG/xUdgj3nuZ/SpM6xVRlDLc?=
 =?us-ascii?Q?oN19Dki5LqumiVqZcYLiI5JD7yOpA4EjZvJjvb/KR8ltUL9KM2IbyUi8zQ5f?=
 =?us-ascii?Q?HYdE4QdKoyKAUY1J1+eAHEZYl6O74iyEmS/TM+Oq5WQxpN+tupwDZmdLmZsV?=
 =?us-ascii?Q?sOexlt18tbxiJhK16FYSbT/8dWUVD0DL6+M5NJXv6VpnrerETm9Tbfax7a80?=
 =?us-ascii?Q?5W5C4rLxG82R+/J1xVf0/4y4sMkwIndPxhJNSqlfYOWtqugFOI5ZmZknifmM?=
 =?us-ascii?Q?oAnofnV0ODwEI2qTToJj6v7ml6VJiZa9nVLVGDcliIrzOTjKlzJNluyTRDka?=
 =?us-ascii?Q?OFRQ/D7n+KJlhzp6rsrXsjw3FMgOSwZLZynJu8fXLh4FlxWgROmI03Fqzdf/?=
 =?us-ascii?Q?QIeW6TeDvNddVVjLowJlR9/v3sUFqOdSkpwuJTvNXc+sJQKrotiS9OuTsI9C?=
 =?us-ascii?Q?LL8nRu9aOj5+HeppY5vFRmJ/K7A8p4v1B5ybWgNcov9zt9ZnRZv+yAdy2XRf?=
 =?us-ascii?Q?MdjrfQIqvqJPIapPXeq0sWlrKe+muYDtCPLkeZJXBsFCrwOz3P1WiA09WmyW?=
 =?us-ascii?Q?+W0MPeGZxqI7zLauPO7a+VeKZgfsxmaVfOyW5sino1jEwviWpiyERADBnMO2?=
 =?us-ascii?Q?P4YrcWHvnUA/ft1oXNOysxzM7IFAr5ZvhBUa6a3/JVcm6gMk/77GbMBfgdXx?=
 =?us-ascii?Q?cO75NpCt2YaNGeSsPsnWPqBlNL+EQ+VfCRWJHdrVsO35tyn8bDBPgYiL/nhr?=
 =?us-ascii?Q?iRlbNf8bqb8LYVYVgTqWiM/1RRQ7XxPDbQkXfObkw24O6tgQIqSFYbrGc0SF?=
 =?us-ascii?Q?XyGFmPbVa9sJKVBXjYgIYeK4DG2CmUldxxccdpHTxXdEI2mbQtTYfzWySxbw?=
 =?us-ascii?Q?o91AIBFhAi+JQxwnXR8WoJN/FYJtA7qSd/Ooq5TEw3fpbhQ4yhTEOCgGvu67?=
 =?us-ascii?Q?92JsYqKL9W5h2QsZ77L3NLkHrvznpviEwGP6BjbZ3e3jkoTsLRVPK+wctnhI?=
 =?us-ascii?Q?dU/C4uFnprYMK55XWRKEEl84owgbPuRX24yN3spb64k3So7K4EMAb6MBRasv?=
 =?us-ascii?Q?ZM+NKHIuht4hODm3D347Rv/cJ7xTrnK4xMJ+IdD9ZYbQFWMauCG+fRSGu7aG?=
 =?us-ascii?Q?ukVGklBQYUan0ukAsyJj1CQN2PB4/RY6FIxATFXSiopjYiupMyiFenEA/Lai?=
 =?us-ascii?Q?Yt6Kzu2c51hzZQ40VWtLGIWJeV43dj7lwx+y+RB+VplAXCGKJxkyOYGT6OQK?=
 =?us-ascii?Q?wTkA4W0FRzQSB0KiJX35IVyNlOnY91nYDEMxvQESXR7Mn0nWYRuMV412O22k?=
 =?us-ascii?Q?mJySdN+8riW+zs1Y399L9Br1To8hEonq7hKDcLsenVI3Q+dckTt+j2x3+/ZX?=
 =?us-ascii?Q?UU4bKOXUF3iTA7KFe4ECct3KThgexRwHjmU6snOChy2Fgajoj2Vwasf48Qc2?=
 =?us-ascii?Q?T/nuEdY3KdJwNSjhb4I+woP8NazR8a3TMpP1aN/LBKwkeLCT0D6WUZYv/uXU?=
 =?us-ascii?Q?Gvd/crwL44OmBksM86/dZmUrW+r7+QkFs38aJaaZSbxCTI3fr4ym6rbyWDDi?=
 =?us-ascii?Q?Fe99XMB6DByar6xJbIx3g+Nu9czMlLXLkKOjfTZB79LeEO6oTts5ALrBMWCB?=
 =?us-ascii?Q?FyhDgkJ04wyAAQJ2uMd6Qxi0Ze4EjKJ2399gw5ugszDJpc+0psi1zjknHjO8?=
 =?us-ascii?Q?pirlwOLgmasK9JfraDZ8kfh7SND2D5k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a300ad-91cd-4879-bc85-08de6b04392b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 13:31:41.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKuj2xxIts1qIb/HUpt5SxwM+vX4zehrx+GOv9VUFgND0KJyxiAkB9j3yzBrVCCgJK8gwcriTKSOc3V8Uq+51xrrfPZc/z7HxBF1S4G3y34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
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

On Tue, Feb 10, 2026 at 09:50:44AM +0000, Ciara Loftus wrote:
> Ensure the txq flags "use_ctx" and "vector_tx" are set/unset properly
> after tx path selection. Prior to this commit these flags were only
> configured if a vector path was chosen. Fix this by making their
> configuration unconditional. Also simplify how the "vector_tx" flag is
> set by removing the dedicated function that sets the flag in favour of
> just setting it inline.
> 
> Fixes: ebcfb039afa8 ("net/iavf: use common Tx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>

This patch needs rebase following changes on next-net-intel. Some minor
comments inline below also. You can keep my ack on next version.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> ---
>  drivers/net/intel/iavf/iavf_rxtx.c          | 15 ++++++---------
>  drivers/net/intel/iavf/iavf_rxtx.h          |  1 -
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c |  7 -------
>  3 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
> index 4b763627bc..da8ac488fe 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -4263,15 +4263,12 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
>  
>  out:
>  #ifdef RTE_ARCH_X86
> -	if (iavf_tx_path_infos[adapter->tx_func_type].features.simd_width != 0) {
> -		for (i = 0; i < dev->data->nb_tx_queues; i++) {
> -			txq = dev->data->tx_queues[i];
> -			if (!txq)
> -				continue;
> -			iavf_txq_vec_setup(txq);
> -			txq->use_ctx =
> -				iavf_tx_path_infos[adapter->tx_func_type].features.ctx_desc;
> -		}
> +	for (i = 0; i < dev->data->nb_tx_queues; i++) {
> +		txq = dev->data->tx_queues[i];
> +		if (!txq)
> +			continue;
> +		txq->use_ctx = iavf_tx_path_infos[adapter->tx_func_type].features.ctx_desc;
> +		txq->vector_tx = iavf_tx_path_infos[adapter->tx_func_type].features.simd_width != 0;

With the rename of the vector_tx value, this becomes a long line that needs
splitting. Might be worthwhile getting a pointer to the path info, or the
features within it outside the loop to shorten both the assignment lines.

Also, I'm not sure about the comparison to zero for the simd_width. While
not likely, it's possible in future we might specify e.g. 64 as the width
for scalar ops, so would >= SIMD_128 be safer to use?

>  	}
>  #endif
>  
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
> index e1f78dcde0..d258c1fc1b 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx.h
> @@ -615,7 +615,6 @@ int iavf_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
>  int iavf_rx_vec_dev_check(struct rte_eth_dev *dev);
>  int iavf_tx_vec_dev_check(struct rte_eth_dev *dev);
>  int iavf_rxq_vec_setup(struct ci_rx_queue *rxq);
> -int iavf_txq_vec_setup(struct ci_tx_queue *txq);
>  uint16_t iavf_recv_pkts_vec_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
>  				   uint16_t nb_pkts);
>  uint16_t iavf_recv_pkts_vec_avx512_offload(void *rx_queue,
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> index e29958e0bc..1849af166a 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> @@ -1811,13 +1811,6 @@ iavf_xmit_pkts_vec_avx2_offload(void *tx_queue, struct rte_mbuf **tx_pkts,
>  	return iavf_xmit_pkts_vec_avx2_common(tx_queue, tx_pkts, nb_pkts, true);
>  }
>  
> -int __rte_cold
> -iavf_txq_vec_setup(struct ci_tx_queue *txq)
> -{
> -	txq->vector_tx = true;
> -	return 0;
> -}
> -
>  void __rte_cold
>  iavf_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
>  {
> -- 
> 2.43.0
> 
