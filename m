Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1FFCD5BC0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 10:43:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9706240DC9;
	Thu, 13 Nov 2025 11:43:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B551240151;
 Thu, 13 Nov 2025 11:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763030597; x=1794566597;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7HePDLE7JuW7BaFyplDZUI+yrcGPARM0s8rLCPg3PEk=;
 b=H7ByU9yPpsLAnQX4UQKbFtp2NdBmnki1DZd7pIRr2ANao7ETTORO35n1
 gaNJ3kiZvcEN55VX4aYEthNhXUPcx3wXdIxXrydFQ1zlZjf3YoJPQc4Id
 6pIGTVAgxD1gWN277QPJ70775U4jA4+s1phPFBbdxb8KK1w8j4mvvaHq/
 PZkgZ2wxojrguwfyNQww0XkJfXMfwfsFGDCN8pSi/Q3CL5KEBXa0t4+cC
 Z8V+9RncNgY+VGFUmslv9aZ21H2xntJumJqBVCnoI8zp2hgfBCodcmk4p
 IJ/zOgfs/F6xq5uTZfEglikNkdRejlH/RTPAc+eqACPZOdp8K+oUjNxFN A==;
X-CSE-ConnectionGUID: 7vcIchJ3QeyNrNnYTGq3qg==
X-CSE-MsgGUID: PbN6C33hTEekL+BNYwIY4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="65140277"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="65140277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 02:43:15 -0800
X-CSE-ConnectionGUID: R1RK4nI6SqOcfwAcO0wkSA==
X-CSE-MsgGUID: /+/SvuUEQbiiu01+vTHKYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="189120041"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 02:43:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 02:43:15 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 02:43:15 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 02:43:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGhAsfgEru7CiTyem/HEIOdNqRUR5dqu2wH/i1Thog+jkdF9FcHfknB4w5GAYZJfcXn9AhqSEfhYHrRUZQ8ErZAPwDH+JG3hI8DknlHN28BqaKaG5THYbyrQR0YiO8cTSPZy+Je9qLc4meRMyUwyHWo9eDr51fkQLgG9CDqz9O34IdjqwZfTHPWLGLFiKk4JA0HNWqYxXYJ9Qw2gMTldIswxqyJQIy2KfmG7wmiv+w7iOTz47Ybv4sW84RwqpbTGHzusiYxl4XKvji3uOEnRk6oEHHIT21akqHkBokJvAPN632GT3wb+OQrquQfZ9iwbk8JqfXrXiJXjTlcIeUXyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQGk4RZGqA80bwm0aTJ59DEXx/Q4AxQLU7LccJv4waM=;
 b=KAQNjiBD2NyUX2Ial59helmHyeJL8MwmYJtSSsbc/AcR2rIy8gIZyjZw9DovbebOsEDd5nIl0OPxnhQVTm/ylpDuT9Vpz1tDEM9Hh9OTstnj6ttMgBXV0bqke+z7yrOyHFtCyk1hHwUkaY3+ysSkGHkmy77Nov8iJvssyl4dMHRsbjQjDx77sRRlXwm3GF1HUYT3rjrfDJBjeK5qFb8/D7QtVeWfqg6nIDsKfy9TyNKxjCh8ZOd4mW5hJQILvMlCxKcqobsRB0Ik8PImqvx/VK++ULRId5+k9hziUcOWrzoDxTXtW58CFbvcqHgymR0hB4bT5RNucqLeGWL1uVDGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB7663.namprd11.prod.outlook.com (2603:10b6:510:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 10:43:07 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:43:07 +0000
Date: Thu, 13 Nov 2025 10:43:03 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Zhichao Zeng <zhichaox.zeng@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3] net/ice: fix statistics read error
Message-ID: <aRW2N4IB0OaXhAfA@bricha3-mobl1.ger.corp.intel.com>
References: <20251110080514.2506769-1-zhichaox.zeng@intel.com>
 <20251113074710.8251-1-zhichaox.zeng@intel.com>
 <aRWaD_fb2kG4Mxvr@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aRWaD_fb2kG4Mxvr@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aff4ce5-00a9-4b5d-5998-08de22a16ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T6/TqHVf6bAQI8N0u4T6ZezVrfUGJ2J7EiSgn6cYkU5ejonKdFGASxgABi5C?=
 =?us-ascii?Q?07MWWQLhZGuhU9+NqbNbkOw91dKR+09TJSLWKCkG9kZLQcl+DAQS9rynluuI?=
 =?us-ascii?Q?+n9dtGsjzSKSA6M8/Lwhk62tqQCgnELGa/d1ZtO6UeX+Wfj314tuuwH/SkXv?=
 =?us-ascii?Q?vyF7ar7SBYoLxCNL3mXwOzckZAP1g5yaPOGnLA8RJUeUrqxaLJd3dm7jvGZs?=
 =?us-ascii?Q?nIUaGqs7f0/oWJdur4o1wSMCRlIYZtM/Nbi4aIEmd7ldTjtdDp/GVvUcYJSN?=
 =?us-ascii?Q?uZ/rIYxfRdBR90oZoDemX+LVK13esWPtoVnwyedi81D24WLa8U3Dkg9n+yac?=
 =?us-ascii?Q?h1YT8gPRX+UM3elqUDd+jdh9ipnJcOb5YlIVC9PCk40KULoRre0hZaJRlRAh?=
 =?us-ascii?Q?qIJGpK31gde2/ik9fhmttmV13WutMXDhq3+j+npaasodFQYAGqAp9PCvJLek?=
 =?us-ascii?Q?1LFwwyN1vgVleTLbCLPeEJnMsBiopq5W4BbkUwRKJ6w5Ur4NAEhQYWS9EHUo?=
 =?us-ascii?Q?zKwxVIHrIHMOvGlnip961zOw3YqS0gutEuy07yoBJHriHejtpcXPHn/aKjhi?=
 =?us-ascii?Q?5g4/X22i0H7HC9cFw7DOulSAwSgnI12st5/vhUYWkZpTuPR00lstg7g5NKDi?=
 =?us-ascii?Q?6RLmWkspM+2qxC8MF3Ji+NeeUWsQ26ovewOnk+LOYnJq9uyGn81e98HtXeLU?=
 =?us-ascii?Q?58JPdgddI7P4S3lEQiGxmwshGO5/f9tI6mqSVgH7Z0H+EnuzMzzeRoUa5Gs2?=
 =?us-ascii?Q?NfgGrX7KLGEBXOnUqKb9ua98sDeA7iJmv9ZTXHpQiX9BrO/wI8duyan7Idqt?=
 =?us-ascii?Q?WsUeOsb7ax2Vxutuxt/Aygf/a2ppJoDswn0ht2M8ANtUs5JjqflIW2X+LIaJ?=
 =?us-ascii?Q?GXDiiLwTokyKsjW6bFeKL0cWpx4qkBEG+QSEwDB/uxmru+csLA6sNpXfXDYR?=
 =?us-ascii?Q?6PyGMYVLdwFRTr7pzuRCbvONPSyvdnFOigORFLQYDBV9AXkb/0m25D24HN0H?=
 =?us-ascii?Q?ZOwHdp7QdOPyHbUHr3Gwm5AUbjELu4cqDdCWEwjqCYYiWUvUuAfszgSJADHB?=
 =?us-ascii?Q?2UNUicKGmumIVPGGro/1vQQUrK9MUSdZgbS3JiSe7HxNTpjl7BRPdMkW0HSH?=
 =?us-ascii?Q?DZnJzg4BEKozU1EDXcAflHQkqCF2YhtTEUaaQ7zm2O+4MiWZBpFEJpkmgvg0?=
 =?us-ascii?Q?SPbP3jQigUshu9OvnTDG9bwRBefzfjzkAc5CeO1N+dYNXJoV/+omRBMbzDoH?=
 =?us-ascii?Q?XlK/8uEyXBV5meI1szEhCnHbKGNGPU6ejuRqQ9dYisY3OzXuo+qHebr7joDa?=
 =?us-ascii?Q?oEG42bn5y6H++kjqoAfyBGezqqHrdlpz4TPqg9qO5w9zdY3UkL6LfT4CiXM8?=
 =?us-ascii?Q?n2YopEXfjLdTINrKmKD9t6MoPi+1SJblRc9jLnkcEePRbfMXKNmiqj2PDQhf?=
 =?us-ascii?Q?c96dpZdNDmsmXGf2CifnBxHtP6kNKeiM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhOegouBxhTupXHebm08NzaEa8i5op3se98/k4YUUAaFmwPnvUFkquAf29yJ?=
 =?us-ascii?Q?h1AGKw2T/DaQDRSPSzGKoc9rZ/kpaN4Z1G8f/6x8tyOPYnl8TwOTi2LSmX1Y?=
 =?us-ascii?Q?Euo55U7HhPqYPuyo1NC7ZkVopM3OY8RZ2d7rE+V41xFAIQv96wzZ4j5m/o71?=
 =?us-ascii?Q?aoB4wh0TsRex9bBafIlFZw9IGqfI9zh4pdFwCCjH8+Ymgo7fygc5i47ocIl6?=
 =?us-ascii?Q?wtUeWCugfmB+pVAlSc/YmuPHXFh4ohsKsw+y2lPRk370JsL8jtV7L/+P0rX8?=
 =?us-ascii?Q?CHyVFQgdXt6JqZ6paxdx7lYXbBIxmlFYBtiFEpexlasdXMjPwDvi2cR2Tpg/?=
 =?us-ascii?Q?1JR3Fg1gMNqaIev357Rcd7fFtwDV8NhasOGjlMBi+i3WZmrJxwm7b1frPAmS?=
 =?us-ascii?Q?viGpf4zt8JuMelbH06i9DFMdPK0JTZ3M3ud+rCQTxIm/phZiVR5hhddM8lYN?=
 =?us-ascii?Q?u0sCZXg6H1bmhf5rgDdrWVnEPycKRJ4DEQn8m2DOaBDzBS5k6t5nvEn7S/CA?=
 =?us-ascii?Q?xDkRsHwmnrgz704q29eP7heEgqkAqJoOPePEMrtZ8L03n3FF97i1E4JPwR7e?=
 =?us-ascii?Q?6kyqrQfvTGdl4m/5ytw7BFyTcGSuoNz/T9Jn0qoK7tqeKDOwugi6gt3He8a8?=
 =?us-ascii?Q?y1ru5Yb8TunzqUmqzLoi0bMjc9/D9wwTTmW6JDiBZTpQWUSZXLM+0dcVCvwA?=
 =?us-ascii?Q?A70Q2d8JvSSyg7h2d2jHj+dzBR9TTjpWmjIryBhpe7pSjkcvdBiihLcX0Pse?=
 =?us-ascii?Q?oFmlEVcG7GgJqncPAcPKR9ja97T2FYo+asRsQHXZ1jzK6BzAoU6w1rPcuBHF?=
 =?us-ascii?Q?wi6ADtWqzybUWxiCTrrr3YeSh9VPIBIH6ZFxmoim/1BdUcaoYTzj2P3bU0W1?=
 =?us-ascii?Q?5GDYoUnCGP0wbP1FKCTLQiP1LFcV/kkG/GCUGlzesMNPN83W4IKegkOq6Z0f?=
 =?us-ascii?Q?sjysbkFi80SzU6b9EexDjaY4qvpADZZnmKiNMxx7gPLnY/zY0v3XWooeJA7R?=
 =?us-ascii?Q?f24N41w5RLFm8p2ndRwfXb+iRVxGi5KupnWRhCc0Bab6hNVvSJ/FGsBnPaEc?=
 =?us-ascii?Q?8IhN+/PGuYTFFYl9iys/MPISIJyj7O442prrJXvUrChMStksfFRsjeBKYE+F?=
 =?us-ascii?Q?87y8n13rIVF4wMs5YBbctiuO/HY6QjwGAHJcjo9MF90R4o4fgMDe+NT2qViw?=
 =?us-ascii?Q?BqMn4sxE8l/h/paWjg4VddP+aGdxrLbvlEO3UU5AzrZVGwHrWizU4mUQmu7V?=
 =?us-ascii?Q?jM2WXH/oC7p5i3q1u6+GJpSibFY9BRUbP3VbqCeAMOW9S28XLN+Rob9JwYHT?=
 =?us-ascii?Q?eYvLRhbQQzcy5qNarganJPTY/v6Xs9v8mzY5OXTwOvJHVcrtE/dkKGX/ETe0?=
 =?us-ascii?Q?Yygy3U4c07mZ6NZzbp6gYm4O1tszYp3yclmAebZsTDAF9QMlTYS+sY7DSfGu?=
 =?us-ascii?Q?e/vSy8vnesBh1keZuxqa50IkEYKCIa+aTBWFnDDU/m+4CCYeBBWuiFBGfSQL?=
 =?us-ascii?Q?Pdv59QFZBqUB1ooAX0cHeDkarmwEVqL1marnKJDTBacN3znUYiwHW+RvQcOR?=
 =?us-ascii?Q?yj+BupFkr2B0PbMDuD6WAy7asPQNVKXkmIXS7GLfzGY06RJU5G12Crk+a4Of?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aff4ce5-00a9-4b5d-5998-08de22a16ec2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:43:07.7526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSK0dxrUKIMiuTuxyT60yragJt9x7v7kwdAoygA1KMzd5QKnK9cxo+VE/KYAQup6DBd91k/Nk+2EKp6qvskVLrfCUpbdO1l+0vEMUgvexFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7663
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

On Thu, Nov 13, 2025 at 08:42:55AM +0000, Bruce Richardson wrote:
> On Thu, Nov 13, 2025 at 03:47:10PM +0800, Zhichao Zeng wrote:
> > The statistics contain 40 bits. The lower 32 bits are read first, followed
> > by the upper 8 bits.
> > 
> > In some cases, after reading the lower 32 bits, a carry occurs from
> > the lower bits, which causes the final statistics to be incorrect.
> > 
> > This commit fixes this issue.
> > 
> > Fixes: a37bde56314d ("net/ice: support statistics")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel

/Bruce
