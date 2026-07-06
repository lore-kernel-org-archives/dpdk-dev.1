Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B705C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:34:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5EE40615;
	Mon,  6 Jul 2026 15:34:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BBFFF402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783344879; x=1814880879;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=RuMVZIQr1fkl82qjFmeMAk5atL8aPoMPUMEzxE03nlQ=;
 b=d0p2iXYt1OM8CbRm8KjMm9X1S5K+9exoZSuf8pAiMdDmI3X3MkeVUvYK
 1ft59N1eOA0vQwwwpR8pqddjfXMUfb4VzCKtHvsmtasUG9SX241w+Zxqg
 g+Mtabm+RscwnqhX0d9x7MRGiUhj82KDz6PNdYeQuZ868iiPRtHWqgph4
 vnQtPi7Ehmvynl+M4yrZ0ImrX6RxBgVUmI6P1JvvRRBD7wyarl9KMMTft
 1T2HyNkrvs3mq371d3j6pReK0o3hW9uNK385PZbPCFHN9g94r/2XXaI6u
 VIB85ytJbQIBbkD+j6c6//MVxZM4fcxsZ3FXg0kOpDSxm4sif50kQXU8Y A==;
X-CSE-ConnectionGUID: W3XywC3EQkGj5w6LL//wog==
X-CSE-MsgGUID: hA4y9ip+QjSewdWTG3ZSeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="84030695"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="84030695"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 06:34:37 -0700
X-CSE-ConnectionGUID: Bx/m4gFjQPaOGa1ZSFWgWg==
X-CSE-MsgGUID: 9UxqVtOzQzyB2st7hBJC5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="258045574"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 06:34:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 06:34:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 06:34:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 06:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfP5bT41U9XqgE8nOssQ+d4BlZ1z2TMzU/E7nF/8rePeJzb0eciuo3dl1E7p6ve2nYjGPZYF8lFJMxSoTsqP7zrSZIBMdao0p5EiZ1MOVmjpkYvK42xUHzjCMVuMtNxwYDpiu9S9IYIety6/ot/WJyzoddpObMJhnPdmtn3B2f8I6BFDKVS2iVKcsXNM4FtKH+6ccKercX7SGrNSIvw4sq1eBAameHgzl4qk5aNbPkVpJIXPv9IEgI80MInTSZnYU0cQZpvXoi8OFLENB7bp+Jg4NdF8RCfDbMSqyImbmqb2VUM2u2vTgenGBpLyWfTLM0daoozU0/wrsRO0VWVNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo7joi2JjlWgNYFLDKKjdDo82hU6SpXX4OcFL+oTJj8=;
 b=lVbP60r7XnwQssQCyd0vO3qvoJnqDhWORYAqgMS4BV456xeMZtmKo7m5PPn+nPq6uXgQ5iypcfy8gqrU3A6bPKAa4a3RwxEEVbs7R7mB62PbLOtw3oOWOpRmsDMILpOUL0QmxRqavElYHvso7D8enUFNOEAszEiS1P2t5X6F3WCveyY27gTtDU7GZAg5J1uD3wVX9OOBEH0CEg6+nf3vrImebAfll6KaWT+tF480kU9iyGwDEZ/c0vel+FchEJ7ccocec5s2Zr0KXcp0fF2d3tw13/lIxyQ09xaevBGnrtHShH2byXqWK0rxADZrkaDE8R8zG98UJCK5SMswSSy9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SN7PR11MB6924.namprd11.prod.outlook.com (2603:10b6:806:2ab::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 13:34:27 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 13:34:27 +0000
Date: Mon, 6 Jul 2026 14:34:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH] doc: announce QinQ offloading operations in iavf PMD
Message-ID: <akuu3clsME4VdIVR@bricha3-mobl1.ger.corp.intel.com>
References: <20260704131730.457722-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260704131730.457722-1-anurag.mandal@intel.com>
X-ClientProxiedBy: DU2PR04CA0245.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::10) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SN7PR11MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffdb7cd-9401-48dd-5035-08dedb634cc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: /zkRila2krur8oF+vW/eXNZ10pue3IelYyM77wmTRoc6ON4LLfAf6oJM6pktrYsWnYFZnoWZb/XlRazPBQijGqZvPt+CMCmLg+J0bAbMbf355XGKSbieopRoALVsMT8VHXUXbSIfp4+Er8s2lfFu1WI8SNV0RbWxJ7AFdDgZD+5RjGD6VMF8YGrBvt0uYDAv8w/86xMA2H6QpbCARdW+RjxqfZMQL8cXHip9d5I8bs2g2zqG9r4DcuBttXZSfLS8FD2tEiLtFEdzaejTQk7KUKchyb29mQnQYeoxzfoSXzPoqgTfNDfQvrQ9d71cosJfUShjmWAp6eYGCb+b8ESBsV4VPiF8NGaRvQaY/678H9aYODvVZAH9jSHVMtt7rFzrO1CtOtB0Ns93d+ZpeOHHu/8drb1GPO6N+REH8ueH42nDlLOfaR7euArsqEKNR4aAq/F3vrTMLy/fLXkEqGZ71UeivkZJRMalHmG7V5J8NlpVULTbY9X0Std1SOfUOBYye4u9tEAcHwzSafI9a7Tsd+X2Tk8h9kqEF3GFdoTwKfIFuY+PAg2O5PSzBCHHBtumVrLmhwoGYLPh1lnXTjSLORnNVYortzel6qnv/yNMdiKHZgtasHSdjNw4vo2jtHK9kugLbf0ahO5A4/Q33b2hlrHqQoQAzbWzp7aZ4mC1dyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdY6t72+OvXSlkz9B3oSl0/TbwK/WDkfmg5/mgQnx8uSs85mgLNYjn3nBOK9?=
 =?us-ascii?Q?DYE0ljBcknAaNiUtNhnTyEIwbR3RTIWeQvgIj1LDZ4RRugD4GORlpIP58F30?=
 =?us-ascii?Q?2rwvZBlqtCivO+dvL0E67aGgHZRLhZjBPdAjYd1L2enS8iREE+3efYQq4xvm?=
 =?us-ascii?Q?rqcp6LSzUVMq6SaaFC7HMcTuuCCaM8pjyiT6dQE+9dAa0DkvLhmRi9C8xzCo?=
 =?us-ascii?Q?1WMYQPEkt5rtBccTWcOfVfHTUCNN/RpY+r7DrhL6BDlRXQsxBpw0UkzxRNar?=
 =?us-ascii?Q?8IAUO6yrNFs3KYDXDdzgsJbvxUKLh01SaeMjpmiexsQ8qI+3l96Y82GgjHfa?=
 =?us-ascii?Q?DX9J+kyYly6cHbE1BeQnZWyB5+Ampo9IVyUlnb4hfE9Dd2QVcPfC+5YQL79w?=
 =?us-ascii?Q?0L6IeTy5jdXmutwVR0XFdjyRpraicKonHUOli5fV9KlfSN5++NHSL20J2mXO?=
 =?us-ascii?Q?XVZobKb5g69t+KH8npfXQq+et4By3rXr/yK/6LajFi8AZ6HjfYGIKp1yloxo?=
 =?us-ascii?Q?gE8XKgH8SUODSCyNyE8PdBSiu5Zbis4lFmsTrl8i14L4vP2zAxzIdkqpvVDI?=
 =?us-ascii?Q?JDamgKYgFINYSYDu11nGSHBIKtbebUgzZFiaEGFwzUAG+ePmLMGDeqiFNY/E?=
 =?us-ascii?Q?3eeX3UDdTKVJozmd1SdjK8CIsLJ6h980RUmn3Rhdfcon9TVmpCQxSDKL1MQZ?=
 =?us-ascii?Q?Ern1N71hmpSOcJrhv0G2+dsxCSSGCoUjIOF4KIOGv8AOpCH6Qftdy8x0bFDQ?=
 =?us-ascii?Q?Cv7maMPnQaYAR2qoG5sNxkEUjWfHDoyGDabMhW9EJ8HWR2CZiPl75tYzGkEK?=
 =?us-ascii?Q?b4mvhdpiBxzRyX8ayp+0/2wEs9Pv4Z9n+FS11v7fxN8+62ChyefymeXLm/my?=
 =?us-ascii?Q?iqPDvp+TK2DJ1NCnA+WIYnuTt+FqNN60KdKvR10ljQk41IuJDTd8clOWw5H1?=
 =?us-ascii?Q?3aZCAnoxvhTpPWsNneY2Aq4uKH6V5i7JIj51pr7itVuqDAoGzje10U/IxzaC?=
 =?us-ascii?Q?ACR74GjHplwqlJJChrSjC/7XPVwyGldj5vL41UGNsq+Y1+AM5d+agxEnKUW1?=
 =?us-ascii?Q?ega4GMmgT+e/oXGZEfD/A1BO4V9B+33EbL4QwdA2np/Xj1qB5vtAIhyJIj1u?=
 =?us-ascii?Q?aNdBIWCjnRO44D9rBIHPscaQhMp4aH20IoMMGrDB/qv/1WN0Fkbw85razkH1?=
 =?us-ascii?Q?23tg+I6AD5kAO2EnwzfwA/9Y8ThA6ymiETzmVdZBkrwbiPHD6o2dCiXMdYqf?=
 =?us-ascii?Q?RsLxmpx+LYyBNdcj2NWe/JD4tuwZltxGA2gAOADP310TCrWW8QdffxEO2DgN?=
 =?us-ascii?Q?A0dFy4UkL46w2LdYXY8wE72lidemqHvl0bafnFS8evAhYDr7LQzR+O1ag2zt?=
 =?us-ascii?Q?BeIoolo82N93p2Yjm7fWB1m8aHxNQTa+1Pk9u7ktpyY9uf6Ccswvzjr87Fgk?=
 =?us-ascii?Q?t6yddemWIjOcisSNKrKeE1ea8gJeAAGS4s/ESw+yiYYJ2nKAYyK2hhwkVwwv?=
 =?us-ascii?Q?Ss9B7+qk2ESrF+xFRjNRNYSf33wRggAzT53pef2rqR8GX90ZE5OATFkNgiE4?=
 =?us-ascii?Q?y24j0uUuLiCGWsFlEuTRGrEIleVClyUPaAhvzuLcdk+Y9VYcwPuyyWZ+ldaA?=
 =?us-ascii?Q?pbyZ7f9DgK8ZaCOsZTlbrs/lk/5Ba7bxOZrItJ0Vhw6ni7LcvL0sfNGzNdJG?=
 =?us-ascii?Q?x4burXcz1kSM/VD4tArjPxzjC6yd+SDV60B8OZYcIT5qY2eqGBrkWxQbHCxJ?=
 =?us-ascii?Q?DPm9fLhIJE9vcTpyVSEG2+iWJRjMIfc=3D?=
X-Exchange-RoutingPolicyChecked: n+KtMelZit71EoS6Qf5D1fEc56Dd2TixuFdiAQZ0qfK+VytaojeXxA01qShP4Ish3sJ9EQCqWw1deBZ7C1XdMf7J2JZiXE6iPDID+j8A8YFt1naiqTsy95xWdU2+uH8VzP2LtLzxZ9PbWbuEZtQ6cusqnUsprEUtHkEWGzjtl3pswR8XP3J4PRkyeqJDG3RwGOgX1SEU14uVx1eWx6xIHDxnxDVAEudeH/ZRvdwuIfjj26GFYRilvV1W+/Fv1ETPr1L5reb5tf7R/MSyRVqg431givdSQKXI4SaJ1KG8aW/OKDadlT3JpYQhV4ctfinHSml1qGK41LjxM3B0HfDm6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffdb7cd-9401-48dd-5035-08dedb634cc6
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:34:27.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39QvA1EpdNjWygaBodCk51ne4WQdLaVDyNbdNG9VQul17fjB5sMEyzBMqAjJUXx5x9+4zCiZ/sJIuBAxow5knXhXERbuIFNiTqS4K8diP1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6924
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

On Sat, Jul 04, 2026 at 01:17:30PM +0000, Anurag Mandal wrote:
> The iavf PMD supports hardware offloading for all QinQ operations.
> QinQ tag stripping and insertion offloads have been added for both
> outer VLAN TPIDs: 0x88a8 (IEEE 802.1ad) & 0x8100 (IEEE 802.1Q).
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini      | 2 +-
>  doc/guides/rel_notes/release_26_07.rst | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
Patch applied to dpdk-next-net-intel.
Thanks,
/Bruce
