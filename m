Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D2BCD6E7D
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:59:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC6DA4065C;
	Fri,  5 Jun 2026 16:59:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1FAE540615
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780671542; x=1812207542;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=C0MAx3NiXaIVFL953TC7FDJtbvd1PkY79PfDjS82RPY=;
 b=gX8h6oB8qVdhFw4Y9g5pNOjrBEkgh2UK54erpnXfXjF2FP2YOa6MUhn4
 TrQQ48KD97M3u1VbdHtwYjPX2jyOw1f7McIhdrLjnOLqbqNEtTB4k4avb
 ed3HQdupMtz2nA/7mP9vJhv6ApT2+Uy0XS2QZF/zFv4XXj6KjRanwvTy4
 KHGTjOkydNWpJrla4ZIv9OvEEr4Dn/tjGU7hPah6sqG+OODRveSnsDV9q
 EVDnLW4qUlw/0U8KjFQOJQ8PayNc2LjhFTn0PDmrGrh052LGmnyarYRQJ
 8lyGVSerMTYT62pAl+ZDohuo2KuLFy+fUSYNw6o9iuOUTl6veXwUSQnE/ Q==;
X-CSE-ConnectionGUID: quVwkxCHQPu+mtGh1l8+Hg==
X-CSE-MsgGUID: iE3gEp0xQd6gmBy+V3kheQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="99077993"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="99077993"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:59:01 -0700
X-CSE-ConnectionGUID: 45UWi9/3QeuW/GwxdKuVag==
X-CSE-MsgGUID: IE1lwpAoTjWR/c+VHQLyXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="275098042"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:59:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:59:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 07:59:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 07:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ow3IWY/8U0k7xw8Yfn1khk3zMc1rNZM/au9upbB+8ycC8MdXSHT6S6fujNfXTT/5ve+zcrLzSMd9xN6Lb+uqvrJRErDN4m81d5V7XGuD30fi+GnDPyVq2X/bPLWS2IoN8Xk5e7eu+o0BcMuJdPPOh2hFOBOKcaBYWCJylg4lvC+9vLDUJtj/DDomAjcT7ovN4DPv2t2VXcsNU2wMJZBt153PCJZojrPl3EgSZU1Bni39908GDLMpUneJGGhmR4d7A0IGqKZewAQeVP+Ww0ABCzB8FMa966k3jZNIxXnWY06q/bVIGPAdkOiMlABxHgU5msSmc8G0WkMuZBHJyj4+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T79gn2g6AnR3zhOQOOXz3CnCW3yNDUNXPZ3htu9s4Ww=;
 b=kebKUgt0ySQhYJcYJlnvrSbh6awEhnnVwTesG0Rvx8m3lZrgd6ZdUhmfKe8LxRAKO/5JqxzsX//77nkaWPnO8fY6a+YDOGnZqLBY4ZSfsF9Cp6EyOpCivMUK+Y7UH/f4JDlbnHTRP1EaACGsVvWplHt4Et6WI96bf/a3N34YN13moJ8zjgfsdnE8UsWMYuT5rm84fKnto941NrztysgMIO5HqHtvwyBJqUr8H7cXAmBVhclx41qQlxu1P0UFTiltOw/kKuw0HYp5TvT8byPg4114Z4DraKZqOu6iWRjMl2w5ralN0Znw07Ff5g6aESAhDwu+ad3eU59LKo6oEnJfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 14:58:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:58:52 +0000
Date: Fri, 5 Jun 2026 15:58:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v7 00/27] Add common flow attr/action parsing
 infrastructure to Intel PMD's
Message-ID: <aiLkJr7gpTfY1EWz@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770819433.git.anatoly.burakov@intel.com>
 <cover.1780589913.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1780589913.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7PR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 36091dab-273e-40ae-13d8-08dec312f4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: v0VooEE8eVtD3A3HxQF/pSz7xgNlr+XkLgTYyCEyIzwYFfzAXcBaVz7V5+2iGSRX8om3bLZ8WWADwoVwubHvz69Q9K04K0si8mx+zJsFFHLgd932qm3es0uPJ76zJOc6XLzM2jMxxjmnY7WhJl54UlA2j5s9Nl3debt0rCHi2cM2+E9tJBxcanBCPjH/6YYQisXNHKDFTRTMb212d5eLVI5tccJEMqjZakLR3Klr7A/GLTR3aiBrs2SxTjgWSFOQlXVg74nMkWPdGXUPdUKUg6FtndOCGsWqz3Gj6mMyfAqc1rIu1gKHaBLhxcUQWDQAAvPiMeSRRcQOnZNhFEbxW7coPXxCJNob1bOp0cAwK1QD6CJKdAGKRsvguI14i0mpH7DZPQbr7PLomCFRmO1linVDjqWjbfvZ2f2LGXe+xksn+9tKJTgPsdb/H9kZOI6zkjQvQMcgANla9KKj1bzNIs1gRfkIJiDBiF9G5SIMIngftHqpkSK1pYYIHpCfZFkPQhZPVuFP054m1XfIIj/ea5OHGkSdoCwP4EuCqrOcSR2PjV5OCAv9o7DphPrPwibPEMaGtqD/MRMfiDUNcAiYVkVHKc1rb/l9kwed6237dsdRtcz5rsLF5DkY0unHjeieO4mXrV6Z0joNZYABjTwrtZqJCVE8Ot1TPamnlF1nm2OfmrIwKClMdJNDIIzo6Zzo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PamiQuQz8Wh0/A8zvDo3s3j1AKJBzwNrjLlu2RQCNqEPJPJ8zyQMbbAi/EWU?=
 =?us-ascii?Q?FYAlgvpvEEIPtHAOYttb8j2YamFa+LyBLDMKPxszfTiS8s5PJiQ0cul5Z0M9?=
 =?us-ascii?Q?tZJqBFHkaBloXLrRtUCq8kDvYSV4mG3towKvW3ryYcTXj5Q6LQFzzsKi6V/3?=
 =?us-ascii?Q?NJ8kzlYuA+RS0lYs8C1hswL7HXT9BGEczxgCYa8HSsv28p88v849KUI+igz3?=
 =?us-ascii?Q?V5o4jDYJE9Hn89DtVPxHdeCsFGejT43dye6az7lWnzf1SZJqlSsAo+dOd8Z2?=
 =?us-ascii?Q?C+MlgKY/NCFSQEziAeQDp5eU8cLMjK2sqzkFEFLNlqZKDed4UKQjlf0HW9lR?=
 =?us-ascii?Q?aDMRvUY8S78SIGd/bHWVBWwwFVVbNUOihvbkSAf02k/UWEMZYTu70NRicSdI?=
 =?us-ascii?Q?koCh7msODvPsB6n2GLmsvRBsrtDASQB3OfWZKYg/TWfwtFDA15NYMJCzsbtU?=
 =?us-ascii?Q?FeDhiXvf8NzvV4wz6sm4NMOf7pTU/4zC9mqQm3YP293I8CooHSM899RJlHmF?=
 =?us-ascii?Q?6EIeO857IZ4cFx4mNHJywSgc2Je9MunSyDH1gZ714cuP/zSbOiYDdcRsT2T/?=
 =?us-ascii?Q?dLS0D2NGjB+MxjDz+OInWAISshJczzxdQGX4bAt1RBvslSeuSDu0x/DSWIJc?=
 =?us-ascii?Q?RAc8dAG4aWzCrbzCMComZv33Rb/a2p5LZEcPdPvR06H0x93/RqvIOo099koV?=
 =?us-ascii?Q?pnCmFbOn+JwnQNv3cny1SO7m9eVK6QfVhFgPBYB4MCKP1wLhSMnm6WgR/fUx?=
 =?us-ascii?Q?KlkKbRfujvV3o2qFNAu88bLsdvcE0dn6+lkNb/+V23vnQcUwS7zcJkFGjeFo?=
 =?us-ascii?Q?JOalZn7h4Ro4XbJgDAvysj2ZpOyJkJbhWMZGchqQxSnIBwIp0XOyxcuuObPv?=
 =?us-ascii?Q?x3R9IhwBOJMBjmB7FFbejBlms6bbB495szzC+i3etIh/qScqeU+Z19QIbOex?=
 =?us-ascii?Q?JBFSwwwbIu6AJ/d664wqbpromjXNBpBYdkhPjQOwODOpUZfb2QMGNBsXDTSx?=
 =?us-ascii?Q?uxLcqDMZxJ/KGjl55s7iktP63MuBLeZF9D7gKxZOGwoKXsolellIe6hNQ6Jt?=
 =?us-ascii?Q?luxW1HXEqbhZCUNimuIf72Pgagu0GxdnLyXbVZKsRFaN9ffiiNx54IrhlgqT?=
 =?us-ascii?Q?HL+dmK9i74atleh6djoXHHatBJ0/1URXYIgQVYhGie8oFDeIcw0BPGLe5q7X?=
 =?us-ascii?Q?QwSwNP4787/WUWh1UFvJ/JiRByYTn1+GrXPjpwUVKHcLhxYkE5jg45cKB7SB?=
 =?us-ascii?Q?Py6FlcXTF/nlgyxRSYd01r4OzlFOba89xwwhhV0vrSC5qpWn6pgGemkGMoAh?=
 =?us-ascii?Q?Vr9acxG74pB3Gie1+BTgHwyOhhAcJRlPJK2WGObo6CptDThnAqfHRXg/XRJl?=
 =?us-ascii?Q?1gb+g0eAhBRFVn0nfZvchLUrX0rde/MyfMnIV43rGesnJ8YqjfEUSAUYVvnl?=
 =?us-ascii?Q?uOzt+odJxpNsKGdKYQXSNGp9WpuWV7fnulp0vqHwNZCWD+H9y8150RKqEPwx?=
 =?us-ascii?Q?4mgASD0FSrxSDCxZGSr7Fu5xtV+6QcFqi9LGD1RI4oFnEifQwYPdTGtPL6fu?=
 =?us-ascii?Q?hpYbNy6ILbqt2PjrZNyE4BU2Au0dogB2uO71ZvbFAT4xba8FOqD3WlWT4R9E?=
 =?us-ascii?Q?+e868T5IsZLftAEcRHqpukwyaY+k2OJan4/ASFPit0KA1W8EFyCVCaX2yDRw?=
 =?us-ascii?Q?aiof4kfM+LZ2K1GwdfRsFm4DB22SbPi0FY7alNyvfgxMyPEniNTtywTVdU8E?=
 =?us-ascii?Q?PmKL+facSUQVRKLiznzmK087HgBCtFw=3D?=
X-Exchange-RoutingPolicyChecked: aQXB03BGz6cPb8I12Z4ELIn2tPdWiJxn4aZpfNsh1mGI/bO0u9rI77YEeQ/CBNRNQgWo3ylcKpFPMFCZD7FULXFEqYvsM2ALs64ErtyP0w2pFk0L5ZGDiLr27UKxuLCjnutXorm/GX4dB4l32CwKeYXyWDqma62vM1Bv7xC6jO3jY9FUYDndRmSmqTBtiLaIuW8XjbHcNYTZh9n9P0caS6NhZan7dXyXhC1muOpP2OKvriCT94qYBR2b4aYdYi9oXLrRmTt0KnqoZLpoY9UeI1zu7Peve+e0i2ItvMBAxKQjUg89BWpiJHDkcytqgH4ACStLqLSdZKdUOa4Isv59Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36091dab-273e-40ae-13d8-08dec312f4dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:58:52.0244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG3Y/WPa0Vao6gcv75/DHx1nyndhgY4EpCZizEpcE+ACXElulQokX0+oSgAzijySSkUTTp3e12/uMA/nZKElltfzgOU3nawP+z0vkwn+42A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
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

On Thu, Jun 04, 2026 at 05:19:04PM +0100, Anatoly Burakov wrote:
> This patchset introduces common flow attr/action checking infrastructure to
> some Intel PMD's (IXGBE, I40E, IAVF, and ICE). The aim is to reduce code
> duplication, simplify implementation of new parsers/verification of existing
> ones, and make action/attr handling more consistent across drivers.
> 
> v7:
> - Fail on empty action list before calling into user callbacks
> - Remove empty code
> 
Series applied to dpdk-next-net-intel.
Thanks,
/Bruce
