Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B1AF46453
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4ECD4025E;
	Mon, 16 Mar 2026 12:48:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A83B9400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 12:48:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773661693; x=1805197693;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eyyN1gmFxjmLjJQIqpz50sow8xEWL4NNwl6k59OiGRM=;
 b=g7xpR1CHTw9abl+JtPceAO0gX5MkaAS+3l4gPa/RWbAkgbcy7QWe+vH+
 qVix0CDaWuoDG97ylm6CJcF+nb+LU16HYf02b1gTyRSy1YyooF9PIuREK
 Fs2YAgIn9FTrvZb7Yv36Jdks7Ii+WxnjcWVZpaLJrvuRjE9kq+FP0gedo
 N2CtRRLjwIAifsGgV6dJU2C6dXwMT4G9CUZGYVDA07GssL5DDvSg8UScy
 K7BZzLOokUKF2iYQQ+AXk2SmZ+k+qYWPdj9w/aupX9fclDQidocxUSnIy
 PSdJ+N4Zb0Drc4WMU9x2GuWcZO4KHhNIGCFwO/VAGI9MV9EnhGywyFgAb g==;
X-CSE-ConnectionGUID: FsiF8j4sQsCYOongvNpNqg==
X-CSE-MsgGUID: upWTgX37RIuLm6h59mZJsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85375384"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="85375384"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:48:12 -0700
X-CSE-ConnectionGUID: qT38guVkRKmvnOwQ5Q1Wdw==
X-CSE-MsgGUID: r2C4Xep2QSOTwgEZgYprPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="218159647"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:48:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:48:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:48:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:48:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTe0U2zWtQ4IoVH330uWCe/1NnhgcRji5I/JAIhYnWiwUt2UCwkD0WW0HgUPTo3dsP5Vr4a+3kQWMmlf/AcPl/Vq3xlKHW1lO3tJ7mJ7PWJo1JheKY5nQtklNPYDSVeu7k7SQp0oZ5vXAA8zzs6bl6S0gS/xVwgaQKeKxBJAeMzNHym7V5/7GUojbkrbz/blVLKyzfHRUYZRWDLLjjkLBqogTAQKb/8970pu+p3Iu3Crbw79M/BAxkoynZsflS7cn1gK2N4UCMbbOsT1WwQfy95sFrq+HXMbUa9Qw+iLvFV2wK6QC1TNAug6xn557oOQOQbEh9p6pb9FY5ME1Dgvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F9R1mSlPsDugOsAvrkx+Fi7DHU/hE3LITkvZKiPDXY=;
 b=CwNtCS41NTTMYzkGmwqZ5JWn3URN+8HR6eObykDShGq18+fihQHpM8MoTcDfKuSdBL+gGOC+CShjwT0KhUPfzxJgJPbGWLBYeoVMFtOt5JHh3vF2CygqxZ6FqQEksBrOIUgrpabAAsIeAUxn25sQ/zpUttkAhvu2beehQXw3+wU2moBW+B9boEEz48uygPCEeri9ODhblitZUgeJdtWgk3eHcnHgFivzAOw6AUK6oLVUg2oOAaTxwvSP2bTbUN2hUODqDdyek0hk3S8AuAPIcpCblo/KCzxmz2HEuUOvFUNUse4naqZttn/oGhMMqe46DKzo3MxH6wEyCZYfw84C1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 11:48:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:48:05 +0000
Date: Mon, 16 Mar 2026 11:47:59 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 08/25] net/pcap: replace stack bounce buffer
Message-ID: <abft721UlzD6W2CD@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-9-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P194CA0006.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 04198e0b-91ce-4e90-17a5-08de8351e2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kTm4tU1xrQdGOm+i30ktIAl2P/GI459QcpgKJ6qciaWEWk3qHsy++keSzwX71qy6yGGH/VCzO/lgM515DELcgYGSKiLoqqH3kKm+82Bx3TcccxTafFJVA+n7Ick0FknDfGzKR79r/ERUdpJ5rKBBBeavv8hHGeHROvz3o7Z3pxf9t+05RQSgedwd7XydUIyLoQvS8fYSTIRt7e0KqU9DB/fZt3SORigJW4pjTC4M/ypFoL6W7vVmRf6KKKeJAH2w0aCis9qGnMUf0BNxkHt6MpBqWmSsYIYr7ith2YVHgVpQgbJKAYkL9fj9tDCKaSdyLwO6y5Xof070IgP6+EkoDutX2VQFmoe2tU6FINZRhvPaasR8e61trrKDBfpfKbJmHy+BCUOheXTYibS5nDgaPcEKcIbW4JaJAeup7e5dC3/n8fRGmtBVlTBFlYMm8AqNQolzK5p2B+HtMibJeICHPpXtFwHn5Ny2kwg6ydH2mCaOhfqNbS4mIJH1vb9tkGzuPb9SVbgS4OSX39ZMSWLXXUtpO7Wacw5c99BgMABfpi2BrxaYfyF05YZhCP99iiic2re9256KZr7ZWWP1oWyvO5d7gQAMPtS4MKqccO8Wo5Mp3n5rnEQh5B7q5eWCTH3F44W1L094EM/z8tt7FBN5bQ+eWdgPWQnuU8rmGpoHS1H+XERjSYLT+9BDhKAtBuEDrMcZAa9ju8q2ZA9zAZUCxa+JijYStj6uriXqQDeglmc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WV8xbKi1Bu126opmIlC0BiDEfux6hdhakYspmG2+ifEN3Z5JoT0iqh6y5mmY?=
 =?us-ascii?Q?cYSvZc23v5JNxD4EffhNK3OIyWcn2apsCz2A8+STt8NWGCGoTQlCs1WS5Ca+?=
 =?us-ascii?Q?qy+cVMxRhtu6OZ8fRdXhvoiTbFEtbMMsmG9cGt9i6YQnjUiSNS6x+icPwdr3?=
 =?us-ascii?Q?e5Qkiq2NBKxXoh8kFptldKVcI9QYWPrPmT5xHLrI65dNl/szWMBQyc80q5SR?=
 =?us-ascii?Q?KQaEdpNwpoRX1wDjtNl0mef7NKu22l28uLAFJ/pjl1bGb/jqhrRugORFVGUB?=
 =?us-ascii?Q?yDFapQ0eT18tFpnL+9qFOLKiIm7XsM183pE7PSNXYkqE5w4fo1iPdCFumpo2?=
 =?us-ascii?Q?K8Jb8OefdGl8MNUCLlnHDsD5rZcYF2wiCYSryuQHAmRonjSk7TneWa6HZMmZ?=
 =?us-ascii?Q?vAXwkXba+czkML5ucW40sxNrQO5ZmAW2HD1YUv6JEVbGjcQtQn3awfJTdrCV?=
 =?us-ascii?Q?FZzkO6zbFh/3Vz3fI/tg3Q7tVvaE1vh2UrDjJxsQGXnmXx9SJo7cfjtm/XgS?=
 =?us-ascii?Q?ElYh5+GRxRPuIMitcK62R9OTc9oBeoxXndk2RA1L+HZmEKyhdrNBUjlqpLst?=
 =?us-ascii?Q?r3qQbLGJxNRaLVtR2QAYFOM3oI9WrCL4uyrWAlt7TPBUvRYKwOUra+5HWzvM?=
 =?us-ascii?Q?rKt8dtr96or2eDeDl7+yiz4nrmQeIfXf6y5R9rMmFaKzCaXQV9te/p18vS9C?=
 =?us-ascii?Q?yQVD8DKk0aw63D0/dPOff5M8ohIqTJZj7/sLLHi1k3ilkVJXJ7rNhjt0UrcH?=
 =?us-ascii?Q?BnWmQ/OXNQhuyE5t7XHm7i67KiT8FDUy+00+nmk+irUXL9nTLaANan0lkvVb?=
 =?us-ascii?Q?OFW5q7CHxMMOCnf4cjpsvZLDogzzwOCsqLUnoRQZXTJ/tqqMEzkVRuCO1mO1?=
 =?us-ascii?Q?Gehp5e0kTXXiy0PetG1YCnChEJ8vnygSG+F47uzCfoX8KPBgvbtNUEIbC52t?=
 =?us-ascii?Q?bCTpyanRWW1r6/1irRtaP5j67qpcvtIr/0drQaE401wmeDoBUNVUVqx/UyE9?=
 =?us-ascii?Q?ZE7VbXYxBrRqAMHRRm7+Qlf5Jo26zc9PMv9k2Tu9gFA/JLdt2fmpJ7vJCmG8?=
 =?us-ascii?Q?CBOjJqCdQRpVibmpnL+ldZfp6WE3DlBzTX1w5REzh/H23EHNwY98VSLju2LX?=
 =?us-ascii?Q?wip0bauwEl+XDG2Xlllp6N7FyCUVqirVrs7DYzq44wM0Z7x0Zi1vkOcLjF4P?=
 =?us-ascii?Q?MG9u6luPQrXVaV1tw9qfCQTtAU9MVt2oHJt9JCjzmE/DSzo2OVJX4KTItovY?=
 =?us-ascii?Q?8SwZEmv9yva1QyhuTo8pwbsMHkXKrKoQO4Gobw3qGNynoXXqjQ1OMcD8wIaU?=
 =?us-ascii?Q?m54Z2idp2OrkItLjG26SnBzqcSFGC1j8co7zvpwySXTFtCRJ0kr4zapRh7Fg?=
 =?us-ascii?Q?Cvd1sfNIArCM25fnfqGf7eXNvvG/7y/+UOlfvipYFHJQTYmDMfZiYeNjjuX8?=
 =?us-ascii?Q?sis9DazpdcSrDdTI8ypBSSf9ZNGr/i5hzA2ldRZP6uvY9HdkhnBT8NshAqmi?=
 =?us-ascii?Q?crMlNOxnv1ozY7NmSymiLQJUXTE8aQLvdozBKtaj2tzIHOJiuApxgZUliFXH?=
 =?us-ascii?Q?pbIox6Xci74RF5Nj/NRs8x8XNAcmcjQ6g630xGYiCfCMwNfU5EW1dQFrGtl5?=
 =?us-ascii?Q?cudqtXlehEymGnOKySqtfUUJxjoOvyUEbsrUHvJvAd/7RXHVRA7Obbouming?=
 =?us-ascii?Q?XYy81g1k1zSMB8uGqVhA3g0trsygsLyiPounaGHn+AJhy7YLPPhLs1gxTKtl?=
 =?us-ascii?Q?XJ/CHrVXrgU7Q5Yomsz10VSa6SFlFac=3D?=
X-Exchange-RoutingPolicyChecked: LhS7WnvQ/I3yKAaumxOnGdi3+91qKA4onMbhHewTYieLqfYT6RVmnGo0BTxJs59ozrf+3amFtQ3mOgdRGJsWtqFyd3ViFKgdK/QBt0drxXPs9WlIP7kX9BwabD3DH0v/rhZ5JYoUSwSU9q1VcX57eSxdtIlDUVIqLhiaavxLzVCZmHRmVE3GyNKxseaXr6zrFpd5PQamWqvs2ZRxzz+Sz2Mt5L5gy1fLqKZEUwg5U/bZduwWDU+/fxWaG5ZAV7mcKBngRIZB3kLcnkX/YluP3NKn65u+2P5yH0xrNWLGtgp9/9uN4pqxY0Ao1sXnvTxEc9L/JhWjllGPlOSvJxhqvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04198e0b-91ce-4e90-17a5-08de8351e2ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:48:05.3162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiIK2RbnlaR0gAPh8NxOaeuN25OrCuXcEDQZ2UbmD4KZgIvlsEXssuTyX9fBlLl4rzPG1TrbuXDKgFbv5v9mSKqEUojl2b2sxpBku0lXWQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
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

On Tue, Mar 10, 2026 at 09:09:46AM -0700, Stephen Hemminger wrote:
> Replace the 64K stack-allocated bounce buffer with a per-queue
> buffer allocated from hugepages via rte_malloc at queue setup.
> This is necessary because the buffer may be used in a secondary
> process transmit path where the primary process allocated it.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

