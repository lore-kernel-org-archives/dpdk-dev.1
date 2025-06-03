Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83346C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D72CB40E64;
	Tue,  3 Jun 2025 18:17:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 4A66640E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:17:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748967471; x=1780503471;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qh9wEeDI2XKcY7KFgWNvVqlUTAa5r9o6yKyoBmnIsSU=;
 b=BZ/BiPPZCfZ7C0AVynAhjz9Tu02uC9oTEjFzr3eK2RQySviZaRrTFGF8
 Dg+0riFzYYZ0i5XJYkkB17qNB36cpTm8uUnjwBg6oIRATDryq+stHlmiH
 aIMQV/RPHupLBSN6ym+/19NsmwjVwzsqY9V/NDLoGA1ooGxZiJaLAcX6D
 W4lJIE2yALuNwa3HrlTL3c49ulpx0AC+t+q9nzklr/Xjl2skz4PugFeMo
 ReJ4HlVF5g7bQ3TEiL3VvPibjtEdA2T+gwCmRbPctKaTW1iBDZrkgXiuz
 bNz5G0sNY2YEV4YcZB1MBlEzJsuwseUrotzdIdHVIUuc3POJr91/LbmZN Q==;
X-CSE-ConnectionGUID: JYbFXvgLT6y0DdlfjyyQ5g==
X-CSE-MsgGUID: iaIE4ql4QOCbjcUx/4w6rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68570532"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68570532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:17:50 -0700
X-CSE-ConnectionGUID: DaDXyKL5SEqDvcMgya3LIw==
X-CSE-MsgGUID: qfjRQx7cRJWaNwLSH7W+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="182080695"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:17:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:17:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:17:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.77) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8W91KMRInWcFkvWbMTQJKEQoUDDKQ2GGCQZ6GcxkDMtFmc6/es4ssXgDxNY9ugc3KoJ+NSjYobfu7ljQBHFfm08ZbCd/Lh9TwKNV8k6xw8EvoLFjd0pqliUHVwDzWmqcIX/tJyfkrvW/opKBYcNlzS6OPoPZ0hDC5gpIr757JS3o4091uqHjTVtUXUrDNB0mY86U58dEUN3h0+n4kofX7JqH5MPiuhRz6vy3tgPLbbRkVhsBPWNiIhdbR9vsTHGVqaU1m4+1ohg3CsQ8ZeWSNrOpTu6fPov/4sPNj81HQG+S7wi8m56xV3tMAF8duTyjhba+yI7SDzrejSUE5/ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=139UlpQNd4da7tCJqM+tSZWe6/XiM5EK/6p3Q9mFZf4=;
 b=DKCIpDPHGkDCrRYTVqfuV378UAZcMZqysTpNxqfkvMCTyHuE/TTnInjh2AMp2Jw+DcnpZU9jJ9VWpoutUNDCeNHtLJN2w2H+h13DIQraZOYvOWpKslaO2SWiyuOm5CQjK+IjvA3nP0ZWu/3FXXVWG9xRLVNfmkkT93L7A87CU4gMqyAiSMVt0Zn5XG4JLppHQgNlkVbbJZPXBAUpAmTHzr/7bHFrZCuD/E0EmhBc6nBAddiueGg0QMFS7nuelgeZigp10+OiG31OA6LtSAcdqQ+5FrzWb63xw080qcOMsWdDkkfhXZVikT83zy+Hf43Yhf7foCxsjSy81wrGpDcdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS4PPFEDAA4523C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 3 Jun
 2025 16:17:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:17:47 +0000
Date: Tue, 3 Jun 2025 17:17:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 11/25] net/ixgbe: clean up definitions
Message-ID: <aD8gJmgTE7_NOhUI@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <8351f332545959ce99ad31c062fbacf413cb4f08.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8351f332545959ce99ad31c062fbacf413cb4f08.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS4PPFEDAA4523C:EE_
X-MS-Office365-Filtering-Correlation-Id: ed73ad34-27b2-4a64-7a8c-08dda2ba2d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MdFnOh4bUrgtcUfQJg0O4//rKvPKAbL9KSInkBKJQBze4omMAHPJLhKS9s2a?=
 =?us-ascii?Q?Sw8N1wqhoLOHWMA9R3q78ZJLdWi3pqA+lG2MmaW0Kv6e7kT/WiwkZNzq8Z+1?=
 =?us-ascii?Q?PxSGL76HN0XQH1iPgWqNYF7SWyylSmVkwz+3uhA8T04hjO3s3+9q7hXk282h?=
 =?us-ascii?Q?SJeaF8A2982wdrwllPmfJcQnEX0jFSW3tIj3j00xW0pjZU7cBzEHagzWAlAt?=
 =?us-ascii?Q?wzncYmy9RBQuTjpnkNvJqKbL/I9jLX4AgafJPxL0eFOD+vGciioT8U9as92h?=
 =?us-ascii?Q?TKKBGGl3Wh/Dnx1makiwnAdgajdfu1EuNRwj749m+saw0isj0csdHf/ZyC4O?=
 =?us-ascii?Q?uPP81bXnj5fIYS71V5QiimlvK0B+mLkAy55m5IkkS7/6xNbulAiUU2/xwp3d?=
 =?us-ascii?Q?n5XxQUG9/NdghZPXlVWNQInGj/Z7D87C4E+i9/fop+utJcjsJnabfIpIrLAh?=
 =?us-ascii?Q?G1WR96GPQPEuvmIVgUTGEMdqxc9kMvKxq2voOfhxeY4FZ9mRYgZMt4r2t/bB?=
 =?us-ascii?Q?E29yAcGc4KxOwBwqi20qeh8FjZ9a9AKIWUJ4B3ecvzR5YHSlHzwGmIl/CUtJ?=
 =?us-ascii?Q?BS89j+k72mdyBVhJjGXSeWmg/8o4FszG2fBMS9MoI3MgreF/h9+8ARETtOFY?=
 =?us-ascii?Q?2fCBB2LBM5jdzhM6djl8BPcWMPbmk+GRRFpJm0xh1igkC7u5srWQcwETtmGj?=
 =?us-ascii?Q?uMXyzYzzGCbiNnnLdzMtAyTUky0d21xESPotBt0r90D2vApibJWgSAJkZIlS?=
 =?us-ascii?Q?FOOZqBm3z6pa3+GPybh9+VQAhH5NvcrW1JySN7+E2TDgrM/mJajghXh+zBOM?=
 =?us-ascii?Q?nGC3vgoiCHNX7qNZzKCWG2PNgDT+pfrxP+Al+e6k9q3vZV1OGSx8MJS8I2n9?=
 =?us-ascii?Q?bG/aLHRK+hN5plqtSwZekZqMyZrTqXqjX2Rxrx9zRnoy0cD8bw3AzijISmYu?=
 =?us-ascii?Q?OyHrc4hpO25dEvSEUNZj4ccgFDVuPlq+H9ZrS5JmOV1sWA2oqFYKkHWTdt00?=
 =?us-ascii?Q?dWUFzt3JxBTOmqX5afdvJAUKUNZ5wWSm3mDgPRbG4TT5mIYGPE7xAFxJCnqR?=
 =?us-ascii?Q?FMh4nY0EdrsMiwrMoFb5LRcAJrGMsGZq8MY1UOAvqHcbHqHuU9qG/dzDT8N9?=
 =?us-ascii?Q?Nhq60v7GeQup/khrpEDtfnfF32sTSh2eXdwWPclIGGhCWhEwe9TsNbtULjMz?=
 =?us-ascii?Q?61mI3pKz1x0FojTtf5/fCyBt95RDS05OoHjfdg+FAfXXV2F2yAARTyHpNq3v?=
 =?us-ascii?Q?hV+akkTjSmlvdolgUYvcFxz6lzIinKl8PM2hdQU9B1PWzCMmjqVLSUTgNIET?=
 =?us-ascii?Q?CVbmz1rvRr2poMRpZPDN9RkUeo4m8GMBRMQLO9mJq7z1Y9IZEu/jLwXfGOvq?=
 =?us-ascii?Q?OqB5ZC1JZPh+IamYYnpdI4zBcl9uWE/6gQhJLhI0jNLBH6EpNUFM9eqdO1xx?=
 =?us-ascii?Q?CCPzSjBaIM4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LyvgJ7HrkJ5pqVbDEKhIHkPdNjbkMuhybTE6NCXPJq7LJgZh7QfXt3X6dCok?=
 =?us-ascii?Q?1D75FatpRr6OEUxXluW1XEH92l3qQtXm/OCEihdeBeTGUKFU56G6LTvDcT50?=
 =?us-ascii?Q?yO3XiK66RRD4tzFdeyLMB4O3hsJC+qpB0ts666+eYwPB5+CPYYS+7AjGVzhH?=
 =?us-ascii?Q?ZYKt8pR5QlgAU4sxM8T12qwfjmBxx67lCs0modwMk2caAydBZD5K/IquLmgy?=
 =?us-ascii?Q?iNM91oqvqk7qsBLEFNAZd9yrTcs6bfemem5PieUmc3kE4XvLljonm36gPrBd?=
 =?us-ascii?Q?Ud2TSy2jsPCmWaH30KL96WPaBGu1IlBiQhRij9hEyW3bVlA1bYnIV6+1zEfh?=
 =?us-ascii?Q?TwRP6b2GduDekIMZQ0wXskztay6OHbg2F5+Fre8ah7KWeguwRGdD030Q6G1W?=
 =?us-ascii?Q?r2qWnd1VEkQJj7ge7K4aPEHgiRp4igaMOYFF4f7VVeps226acWi8azjwW0/n?=
 =?us-ascii?Q?1NevYncjOdBeGZsOJLAzFXrR9rOQS9YkACm5/FRwPoixgAIca5Gle/xRJWIW?=
 =?us-ascii?Q?6FqraFEmYkeu5t/+F26dgMUQCXMbitaLjQoPga7VzdbJu4u8EzaTMdxXMcJm?=
 =?us-ascii?Q?jCI1G97KhZXbHolJnq2G81T80ZU9DTllT+QcjQLKpi5gPO+UGdFBnPNtiyeL?=
 =?us-ascii?Q?RTbsb68kj+3AVNqyNfIzUmEZxG75Fm1tYKh3f0kS7k+aGszlPlXUq7lefV1W?=
 =?us-ascii?Q?kqyMmg2bfNc8UfvdWSzW6Ql+g2Emy0/PlBAQvlqRhr5Hx0o0CffUnIxm7EQv?=
 =?us-ascii?Q?C7UXvcq6vUwAyP3/GZcjOm7RrktVNHSgUmpKpL4DB+VYqAoI8d6xiWPn9SE6?=
 =?us-ascii?Q?Wco30cfKNZUP0fjiDhpqBhUKrNh4E/86PZHEGqeAQwB35PVPdlNyulgW6SL3?=
 =?us-ascii?Q?ImmXzixcxW8M0gBu3wJ3UpYNZTlwXNODzYx3QUKbst3LNnJ91IYaspjx4w4a?=
 =?us-ascii?Q?Ka2fxvzwJ/8P4e6YcBxoWeRUfQX4xW0aPSojSHD/gVPQcwRCoXU6w/66lZ+E?=
 =?us-ascii?Q?rvsYPN61DA+tM7CQPk+GDhLQwUSgs2WPIGdavZvKwnhp0+WaFWT8haGCSpJH?=
 =?us-ascii?Q?ESHY2hia1h0eFU5FkCIbdouGoTtkkx8ioGVS7vF36F02iDfyMZ+hHMbbGCj9?=
 =?us-ascii?Q?5oGrbwQmK5pHbJVXvXT/5lRWSQFT1ACeQG8b8iekh3GGLhOq9c5bQKNSDVbv?=
 =?us-ascii?Q?1QPhRpDQHtMdlyclCoRwuur0D1yw5pxpT4sBGtxJf2N2cSqQPLzkJEwTwzMS?=
 =?us-ascii?Q?P6JKOkF5tN95doiQ+DQl5lC4o2t7lIEfolWWKyO+cK5WPJegbWev1ZY5fCOD?=
 =?us-ascii?Q?1BZwouuCRpplF+Bm/JQztBeuHpwC+ZDauLvGUHqxbHtV+6etNsws/LwAB1LF?=
 =?us-ascii?Q?WBRWVQh1c3nbSqsgSCK+IhXZPeE8zwnCjM4T3v3EmmDcus5Svrt1FEOS0UPd?=
 =?us-ascii?Q?DGOLuZicXynWxVQPIri7rLABMsr2ajFgQ9KpxDJvKkjxDHJda5IdbN8GMlZB?=
 =?us-ascii?Q?1dxoGJr3IK3M38yO4ob0/NhnXxb9rJyZNzmA7dQEmjT9bonk6i6h3wiBJ+Jq?=
 =?us-ascii?Q?yvstM7a+rneu1mpBPCCc96fk4elu3HbziYxoS9FU7ul8E3qhqaEFpbsbzOkX?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed73ad34-27b2-4a64-7a8c-08dda2ba2d91
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:17:47.0576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBolnbDM1YKXTSAe9sk9X2KMZvkr0ZcVS+jWV8Xqa81Jb9O/qPy/a4JHFyJ212oXauwwLiPJtoqu/tYS5Ggvrmb1tihzUbgJZ0x2eR06jyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEDAA4523C
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

On Fri, May 30, 2025 at 02:57:07PM +0100, Anatoly Burakov wrote:
> This patch does the following cleanups:
> 
> - Remove RTE_ prefix from internal definitions
> - Mark vector-PMD related definitions with a special naming convention
    "IXGBE_VPMD_"

> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

