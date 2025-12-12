Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93DD4922D
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 14:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 166EC40268;
	Fri, 12 Dec 2025 15:09:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id D4FF7400D6
 for <dev@dpdk.org>; Fri, 12 Dec 2025 15:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765548573; x=1797084573;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=FgODyv77SN7agBpuA2ZxbS4jF8QjG1N7/APJ0BqBrGM=;
 b=aHuyQAtAG4yT46QGDFzg3tWaONV2rDBbR78oWlLafxU4jH8pCdT564Em
 Rs0wFYQLizHVkcIE+DNaZsJha2PMg+NhMQfKu9mhroOb5xszO+r6Ze2Rq
 NSg3HkHlWMjigyLNuTW8v1FCljMfHhZsFsKLoxzSDEFTq3vccVMPI8i2T
 roiFMwhOkmbTXEmVKdC2cQiW5cZ04so0MdOq6kX71e2TMVwbEerjjN4iL
 /2ZHGDQ9Sxy7ORFaRTk+aAy1hjMtI7ykb21XB43vbeJILjvAHhjI/rFvX
 /NicbGnAltq7XNItV0BMiGGNMhuR2NoJ8Sh6Irkn4m5c/+sCfxOOTvveP w==;
X-CSE-ConnectionGUID: q41IGNx4R6GEE0bjTr6pfg==
X-CSE-MsgGUID: 1Oi/CDliSjmlDk02fPg8yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="78188584"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="78188584"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 06:09:31 -0800
X-CSE-ConnectionGUID: xYxUa+NdR6qSgCc5Fdc3rQ==
X-CSE-MsgGUID: 08y/A1jsSz21mg1gGD3zng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="197163160"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 06:09:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 06:09:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 06:09:30 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 06:09:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEw8JqR16R+2Uh/0bNYqx3NzKeICH4D8Oe2bMo9d8O2TY4Q7tJ3sWcVvD1Pw37IQHfWQfYEzjOJ2kmMiPFdH0xX0DHDGMqGahwCzM+AE290sI2yxMXmzVTs57nf5EnBzoz46ueqFegxRGzdLGiuPztOxJKT+AC3u63DfhJxagphPhkG/SkA73un6iW8x2Tup/hyUsRoOCBve8VO1sY3nN9jo7HKt87io+ph/dEC3NvNWKtxZN6y1kRviFioF6AYri56Oq+d0Gpt8c/jN+EZZU7S85Af9pdnsVm/km5C0fUiiwoktJwZjxXMzW6rtxUxTtCQLzvObyH5QJgRXF5h6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA9shpCITfy80kT+XUJYkA/1tzi6RcBbMCDog5VxTlE=;
 b=XZlpTCN4O2C/hoo7iBvKGZscedOEg5efA56epZfwx98ooKVcCcGmqc+EGTZTvP6k3/+cF8XnoKOIux8t3+y+izMPmsaj6AoWgOBcvXN1uVOq8zM6uD4Ht71q1wbAw/5ztXaJj23UrKK0wrN8ITyuukhdhdUtj2oAB7IIUksnFlIY+tl+aRqx0IrmPps/sDikwstYnYTh4m/KpaoOT9Q/NNgXay9JOSnI0xvFtOxgWQecErjBv5w/+ivzpz/Lo4m+0zclQoX3AKE/Y5vbtT75jL8iqh0bOY/3+ji+RQ2Q5jq8WwJROylI25pTrrCeAHG485HRPK7XixmmJjUtlES+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Fri, 12 Dec
 2025 14:09:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 14:09:22 +0000
Date: Fri, 12 Dec 2025 14:09:16 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 03/10] net/iavf: use common Tx path selection
 infrastructure
Message-ID: <aTwiDBEp-m4Ft1iZ@bricha3-mobl1.ger.corp.intel.com>
References: <20251212103323.1481307-1-ciara.loftus@intel.com>
 <20251212110628.1634703-1-ciara.loftus@intel.com>
 <20251212110628.1634703-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251212110628.1634703-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU2PR04CA0344.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e6351e-c4e7-45c9-52c5-08de39880c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qR/4LEY0dP9wg7Uchph2JEVsZpdM7yyDZzed2RB0vTwfTwjSP/JmYDVM6Yuk?=
 =?us-ascii?Q?8h4JTNrLwTcetk4m1XL9J6kkNRmqB1pDfJyo3xwmK9v5I2azy30u57cyI0tB?=
 =?us-ascii?Q?XLw9lkp5ffE8369ny+Frxf9Pi2Zh2YCxeAE5mMd2DjDrd1zG12fgLYzIyync?=
 =?us-ascii?Q?IlaYsitPAxNkx/dfrKLCGXwgmccaNiORks68U2J6DnPq71InxvIkvjDtkViH?=
 =?us-ascii?Q?efC4OQZZYYup1ddjG8Bu7I9LJqEo7d15ViR7634ftSfJtWSiMKum0m2fxGP9?=
 =?us-ascii?Q?a/nrOpn1yO0iSc7kKYG7HcOpE2On6sNk1oojfb2CI1LB1b7WVcrua5O0FS5V?=
 =?us-ascii?Q?QQY2oZBTbuPtOz3ifFcc5BJwZkbzgYHGvi4G9A1ZL78SYPCNTMpPdJ9pa+7y?=
 =?us-ascii?Q?Zz1pFsN1nILRO8FJxhJl3oz7b/eSsqsWVmjiIYEaWtnUZz4A1NrzvlrSpzxv?=
 =?us-ascii?Q?PXnVBLQxZdgACYhWgSoPb4ATstmfA2petZksdybgVT+s+MHyLmNQBMZLRA1n?=
 =?us-ascii?Q?XJiodVka2/FyOX0aWMLK7SdCAh+n8O3DoVA9iVRAGRVt7/KX/DAmzCj/BNp7?=
 =?us-ascii?Q?QuYphtAStKfZ7WM05v7P9fXx/E4CgxEKI2qu2K3+XLJ+bYnYuvMXcS8Vs+AF?=
 =?us-ascii?Q?kT79IImz4GlLh1gPgZq1dNlM5ftJHxQrHjo0v7qwVOMe3pAAEbgTbZnvvTAa?=
 =?us-ascii?Q?npue0k59TrFSQlKlcW8FSQn8ubEz6gslilOB9HQDn+qLxP+K0CRUxxvAlVfk?=
 =?us-ascii?Q?9zFCc19NIZTDb/pJYstUP3xp1v8YXqBGl9q/byLMs6TaiwCMLde36g5izs6I?=
 =?us-ascii?Q?lrnh+4iDGG9vAtgUYUKGFRqTaJpIaDM74fnwytF/wyPf7epz4XwqLydckb4B?=
 =?us-ascii?Q?rW9vzraM1gkVyo5rChGPdcsXy+sY+aqyI/gOyWhNf+IXjb1Iw53VH4e9yiXA?=
 =?us-ascii?Q?vCpZq1SnXTBmTEUd4kPeAPamGbZzX/H2fE/KMru2YyfuGVY1trFkCgG8F044?=
 =?us-ascii?Q?fO/wfUXQRGAZJS7FTcsg/PYm4Erik7sVjRR2SW9zfX7WoG98PdB/8nq+0jlb?=
 =?us-ascii?Q?fjMLBAg9QKkZ8YrPTQoXbD8qKW5H1sm9MN2ZasKsRTAtqdAK9MJ8J+sSxQB4?=
 =?us-ascii?Q?xVOqKqaoRDxiGGDKddaA0WFkoO8XyysMqQNhuM6DOd5jvzb3v+Srl986QJzm?=
 =?us-ascii?Q?OJFv+YhEF+CXSiZhDpNqTRnFbWilUlAptApgDPteHL1zpcsP9HRdEujiudtU?=
 =?us-ascii?Q?usggvib234QsOTyfHwOTme8nvzvAbnR/F8YLDkaiwtedc6HqgGW48YqC/vrL?=
 =?us-ascii?Q?B9X1JTkUg1VCN/JO5dvlWKg7Wp/1ZJSv82UckQv00pITqGIVFMMEm5Jzj9W1?=
 =?us-ascii?Q?pnxaLMEXuw3Rz90x/3zA5s5WkMbOqJLh5L+x55bjvhqOwsW/zrz9VrRrhK1s?=
 =?us-ascii?Q?nD9m+L7MaGBn4p1vhqX5rqWyRGWb4xjb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpvQA6hESWrGy1nOASPZw7ra5io4as6+9zfCJvBtCdx0Qro3w5kxHKgJleOd?=
 =?us-ascii?Q?Op/sukrHiU+YpZh6kvCt4B9EFf7pLhL1aOJ8S+5OczemIYhqfyOlX+Djurs1?=
 =?us-ascii?Q?gfiTwkCr9D/aEcI7f7Jg3uvhNvG3HpZZWCtOjFy2kn90Tb/e2at76XWHaREU?=
 =?us-ascii?Q?NiGHbOFa6bElMfIwQ+StcKnL4PF0NDrzfurU2d4eoAwkxe6+donwWV2cGixy?=
 =?us-ascii?Q?V47vhXjaELmfPJ9ZnPQLZE7d9q6CPzF7BEzvvZOtxAcLVx/AKmZ2v3NPOvD9?=
 =?us-ascii?Q?JF6w8PV+VPs4knyQY0bbrmTZLTCBVW9vfsTa4O029OHPG0qWAk5BlQbC5AvN?=
 =?us-ascii?Q?o++FPGM92qefcVbYVZ0UbYLunA2f7ZiAleavzl+ZhIr/W1K3Hs+T4+8yvV29?=
 =?us-ascii?Q?caSshilL/FKzzheyZgrqdXVxa3wjV/gMragnPc5uw2WB711txipPyu8ChA/D?=
 =?us-ascii?Q?7tXlB1RpmZ17AeJbIPxB7IE6FS1AjDnrGGLmjp2ZCn0RJjdKS/Q5ASilFfbp?=
 =?us-ascii?Q?CaEdqZa/V8CD+Xko3qs9npZhAW7oxHxrAajexave6PFx4zEmZEwDWlZuXuEJ?=
 =?us-ascii?Q?MIsNvqtFUH6WNevnrefUc5yh2rjd2fMA/dg3zH3RVtPaN2QJ5YH14CTcrxlM?=
 =?us-ascii?Q?a9qjkVNQ4ba59T4IJxcCGJxAD1Af1t5146OfY5KWTMO/QgmAGl8M4c2iXWmI?=
 =?us-ascii?Q?EMuUTkmzfXW0f62L+FwiHxYL4C+EIyDPMemCjKEyTC8O84rQuhe4lQbIaock?=
 =?us-ascii?Q?06RvuQ99L1GA6IZha5C8rRtucEhAdtPJABZXPDCwv0Lxj+BO/7CL8aWZl6/i?=
 =?us-ascii?Q?JzOtz+390nX0Zjxzzy6lpnFb2AfuNH4P8j29K39E2ZNMWVzFdcRvKWZt8NtA?=
 =?us-ascii?Q?F5KO7qK4Aj1PCUaNuxrXs2myVwphR4sY5l/ARQUtQPCO2udMCA9bpMqaaXGV?=
 =?us-ascii?Q?C/Fpgs6i2j7zRwwllQaHIOvD4XqtflG1v6Ue87VNMzKibBKuY5u1JMZZ7mex?=
 =?us-ascii?Q?Cq5cntrq2R56GVNPJuaf4kzM1I8W1cyU9Ltk/M4OZfms/GLQarz4TNWNQs/0?=
 =?us-ascii?Q?E99RRKgQ7DRK7i4d/qKVpzZP+smS/84OX9aUTLVgaH6OqLKOAlL/baUJXdEa?=
 =?us-ascii?Q?LM6IfP6eTb+udV3hn15S0KkBlCdw7L0r+Icioo/aSZ5n5cSCNFj3V48SNP2P?=
 =?us-ascii?Q?ydo9W4P65vdyjwpyA7xB2TpDwWbRU28pKXeAK0UpuBwPHoZhRRRT9H8vxEYH?=
 =?us-ascii?Q?sn67qnYRuEoSMFRdrL+O5aWF9PKWg/jTdw5XGaqBb18rDX0XTpdzBqtydq1h?=
 =?us-ascii?Q?ZAEuChMyC5tQccpuEslDcGzMJmZOpncz+KW4rL1FACxOOJOe2nAdMiNgn7vm?=
 =?us-ascii?Q?7cBvNpHw2/jhD53JgjoSs/BKuM2rj3GLAsfPLWUgAra/qbAojOQmvAzsz/kF?=
 =?us-ascii?Q?INKAmYoacIMRtfkXpKn9hQdbaxKcSrNo/ycbzUS6efSy/omOiGwWj0kJTzOU?=
 =?us-ascii?Q?SmKPsNRBeQkJ+tOUfrKqZu0Fqkf+dC9BwdNiPNWkYBOUMX7VIgFBhSCBwx+H?=
 =?us-ascii?Q?WIKlZvt9xf8k1yY/UC1iLFKvb1TKDqtcJe3bhIU0Uwzeaz+IxMhuCh9/IaVU?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e6351e-c4e7-45c9-52c5-08de39880c7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 14:09:22.2859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t346f3A5pxU+IvB2VV4zad4gjgPK5omid8DGF69/DaQuDgXXsDzUSfFAFxDTVg4JhrNol/L4uh95vZ2eSBb0hkfrCaXcgq7v+3LSPKHyDJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844
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

On Fri, Dec 12, 2025 at 11:06:21AM +0000, Ciara Loftus wrote:
> Replace the existing complicated logic with the use of the common
> function. Let the primary process select the Tx path to be used by all
> processes using the given device.
> 
> Introduce two new features "disabled" and "context desc" to the common
> infrastructure which represents whether or not the path is disabled, or
> if it uses a context descriptor.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

