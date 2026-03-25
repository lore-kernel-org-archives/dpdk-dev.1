Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF16106B522
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 12:42:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24327402CE;
	Wed, 25 Mar 2026 13:42:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 089944028E;
 Wed, 25 Mar 2026 13:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774442527; x=1805978527;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BvPXJnOPrSwub3eI8Md2XumShOHriVvP/6V/dvhWopA=;
 b=bDkVqGznxB8aP6LqT8BEp29rYiE956RR3NyaRTMjOTs0C6VVful4W37T
 eGrjR8YIM50CDdItvt7wSfnOopxETNWYBmNwSUqmUFOdhM7i2XADlVN4P
 abxOFjumTxrwFYZaxxrqt1tN1BK2ptoTxscwK6KK/QoE3FR8SEQQsvxqm
 txIf4wiwSWJClnMvaiwQ2zZnSYZRw3AtwsmXxbTyT78jUd77rwcYqPTiB
 j0iuR6ff169BP6Nm+79PQG18sK6is90Vdc8aFtzwfrBK1pqpdyyzUAUqT
 93VeKIgtmakqkrWLLiS9Cp/QffKeRJdymHPEO7kaxpJ7vCrKE8CDx8k64 g==;
X-CSE-ConnectionGUID: 9b+nABkvSbyF8+lFLbR5vw==
X-CSE-MsgGUID: pBVnVvBqRDqjh31QGxfBMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79070896"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="79070896"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:42:06 -0700
X-CSE-ConnectionGUID: 28CeXislQ0aMLMmRK7qobg==
X-CSE-MsgGUID: nHfydCQcSjSCwOXEpPhtkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="219814744"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 05:42:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 05:42:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 05:42:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 05:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0A237iLFNh1jCDCIVvKfGHSQy4pB2YN+3cW8BofCFQpSMljBNBcWuO8RgikOTd3UPq22E14b/UNiVH8jZNojs2WEv1mGdWq/2Fuv8k43S14ENa6QKUB5TefV302OlnAy1BTIJVhcGm4S5bDnjbT0zn6+6DuxTaJKTWShKpnRhYaO9kOIyKbjQzjQx+sqx3qqB6XdIE1CA6BOOwaMqF6ULoXCeGxy1ltzWh8omUDx4QajbVAyX2fGloeSg5L6dSxIt9wgycBUoHPIJs1RPn64J/J9Sqztr+JIVlCBCw+6hIlPHBS1vOtrgkYMSZcYx0YJA8qNilKaGOiVM4R/ucz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlzB3mTcj2WvlP46JtXpVs5aII8X3Fr2pqtBLgedUqw=;
 b=VO8VzQPgHjik7Ga8+btXBBJcBmgot0BJCtX/F6mRhREa4BmdaScTyMLCxaik9eILqceT22OhjlA1WutU0falm3YWA5yt38W7IdgKYRI0eR0MSDGDvFsVyvUZkn8faBa1uSIJFAjYhijHLhytgf60/Vw1wJnwxeELjxK+RUd8ZLISbyf7eJ8WCJoOzRHbiND+06ish6/nE7ZgXjYsyZAfTKxmr00qgHydk8eVwZyOvjx5lkh0cZSgorG14zfIvIXE5j/uoW4MQZk6/PRr/lD1zfG7N7ijaECIS8e+0iD4ilhJp3hC3cPusovsUEUCVAks4PRX995UGcb/82xRwKdy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF183C9380E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::815) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:42:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 12:42:00 +0000
Date: Wed, 25 Mar 2026 12:41:55 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/i40e: fix raw flow item validation
Message-ID: <acPYE0qdxKTw8p-F@bricha3-mobl1.ger.corp.intel.com>
References: <20260324155627.1849904-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260324155627.1849904-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P195CA0018.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF183C9380E:EE_
X-MS-Office365-Filtering-Correlation-Id: 890c264a-c61b-4211-da2f-08de8a6be896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: oy8p7Hv6u08V3jK5JtoOKMlx69mIkvAjARV2Lq5ViVUpgopCL3GKkQw1YDO2LsDnCL1I9dxwwDpKHdsM83OdbFw/Wx6nT8eXBzsArbjtS7T2Igh7P3Mz3kuDIWduHW2li3qF31YoEGHiO+Za3+hEZa+D5ugNtgeqWZmpSNj4T2hepfLyIRvkzedBHeGePDn8aWwcePXS0nSlSYWd2WWTTpORXj6DvqOKzcmlKGfZMiq+22k8M8ALdTB2Doa7KyMGfc03G8WxuVNH7TbGat7I34f0K8Glfh+vBX6P9Z8LzlTaxUvY2w/V4/n5Eev/bQUGm066Fm9+D7CnQfgUdN0cqUJR/qCxYYCk+2ZahWpJ+Zj5p7DDvT92dgGjF09NznJvoT+DO36/ogS5FnVzElc0WLlurvSG3xkuMPwTCkukhoQDtufHDsSK+vQ+JkBXHEjgIMBdC96OR0vDXAIN7o+uzHkyJmIq1wSHEtEnraHDGIufgVw6i9ttQO87iQaRK8RsMgePojks6Aa1m/6Zng8FLZrUYCLBsg+7U3Z2smU86hmrB3pdWP2SQqZq+ZkMM/GYlvIJtIQ6BKEUUfVwJCrIK3CcsvqEZc6NI+/NZYqZU6wrhYC9oWq1vkxpLJVeUx7tEzBA/hevKuThc+jUeot4v87ABDOzCpCVGw1uccBJWpnm3VvtTphB2r1ymtBy0z19aiHqm5+Kd9boRyXeELhvodBrVSL2Dkr+1b654pXJkZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ErpmlvM1T6wcVLfUi0+BmQiUkmQ55YRfHKOhmy5wpE5sMk6SMcw9cHFdTx+z?=
 =?us-ascii?Q?dWwe0tcAm6keSrwp3xytlks+o0TyHoiwpobOHYaYD3Ga4LP56/ZmQ7sr7MyR?=
 =?us-ascii?Q?8budbbqQjMnQfMYTKolUFpEUFHZ8UbBpUkvt5OdqlgHWhUfgrvj25ZEaZlZN?=
 =?us-ascii?Q?v/WqDFc9u1eLDEBiv7I2T8A7G14V+qhXQmOx0KodkWVdwQFIJqhcAB+1G+Z8?=
 =?us-ascii?Q?CyghtPWzKikWgdunicGAEI/vAD7rX35sO617+hwGsdFn5SLpkRLuZ2VHVlza?=
 =?us-ascii?Q?2w/6aY2MycnyLHxt6bMbQvEljX02tM2cD4I1nCfXi4e/qUhFnFAxaqHDdjIm?=
 =?us-ascii?Q?TLonBRd/+iJ5sOydqONuQcAoQQXbcgc7LgRdEw8WXVTjJ80WNGPUpuigQE+w?=
 =?us-ascii?Q?Vig+IREFhXjvr3UUHhI7ob/ua8ThV/d5VgoaMJP4P6bNnZgn1rt5Gg2MAxU1?=
 =?us-ascii?Q?G6FhlC7flsroJzuuvLGT9Xoko5+uhRvoYZ9NKQDW0oz8hhTOcVXbC1/jUlt4?=
 =?us-ascii?Q?GVk74W+grQKCEn4dTUOGA2+4WZccqSl1ACj96wPvpJw3BGtn/lzvjmYB3ChC?=
 =?us-ascii?Q?7xJ4Cv6wlc4qDEFdTi9qbU3dtcKiIDm66S/lERDh2WG4zXuBnBYVzccEnPTU?=
 =?us-ascii?Q?obTRYzE6q9dor7k60MmjgiImGbLAkmIKXzcjhHz2NydNZdRM2N96KL1SgPNh?=
 =?us-ascii?Q?Ln+I8Zw8Dy7ow3UePJwm08VpbypJr94L/v3aD4XOUPBOsND9zF2xe3/mBVfn?=
 =?us-ascii?Q?XSHijEUl7KxxqubHWbigJqeUgDFwiHs25Q964LI1tCZGAt5U+uAd5b6vJgap?=
 =?us-ascii?Q?nN3XQ0vcslCdoPlYcNqiQndkEUJZsDW7BHIMKGNV4/QA48fbtwnJfEBYDiS3?=
 =?us-ascii?Q?x5/4nSLZ1Ofd1pDz5A4RJe7qfCKwuAQl1sTbFX2ukDm6RNcO9D8dPjl5WHO3?=
 =?us-ascii?Q?aVTpOlnM+sz9fkgBU07DBTSIkmVhiRfiKtYWxJGYon0Xma2fHTKJpqOCKl7X?=
 =?us-ascii?Q?rcxWdd04TRZ9vZqRYh99422TjKF9ILD62+VlokmufgHeBIgEaGcl8/ksfVcO?=
 =?us-ascii?Q?QWGxv9jTJmEmuIhl4hRxL0Bk1fCOhX3J/StnfaiIIWXq+eNIQAnrk40S44n0?=
 =?us-ascii?Q?3HDRGWW4Sh75JpSZRTqH+wL112eO6dq017IjycyT4Zq/9cKzV0DQamGPnna9?=
 =?us-ascii?Q?UsS5r2ukYrV4YpKGPmZwgeVc51DDp8KgxVIFfp+yx/B+VUOWr3GK8CzZlKQ3?=
 =?us-ascii?Q?VX273r6PU1UOpsovaW8uMcFnyKZnLpDXbJgK4Oi/Aq1EkuVRw3kjRa2wDVj3?=
 =?us-ascii?Q?5bECgRuf+0yMbVIa+apVwaEAR8Mgn4XtvgbPT5t5u7X1trtufc+dbNHWctj8?=
 =?us-ascii?Q?+zqw9bNr1iU/QA17mK6pAhF3dOXdB/x00sysQueDiQ/HtcPlTA1BqOib9OhJ?=
 =?us-ascii?Q?H71U89d/UzrfRpTUZ/9O2MXjoN2bXoiriIi9i2oDDDp/QiR0iFIxx4G1HUtU?=
 =?us-ascii?Q?KbJdQ2OTS5pEHDObCgiJIbYmco84vSCLzk2Nm8xt6ZGErUh9cNIBHRs0Brcn?=
 =?us-ascii?Q?p1fg7bbI8pZWAK59jvHgGpvPmcs7xD5XZpu81Yj4uLApRH3J9rF35UZqOQpA?=
 =?us-ascii?Q?JTmSP8VkszF0umMk5myfgNvKWuQXWEqRxP95y9v5TP9BPuh2tqwHHTodv/YL?=
 =?us-ascii?Q?bHRMyO/MjmTLTWNSwoS7HVQMd1qCoLlvArFEPoAYMhv8Gph1gBN5JA/499ze?=
 =?us-ascii?Q?V8dTGDu9V6t+5FlDNUdMhdMOAqFuqvI=3D?=
X-Exchange-RoutingPolicyChecked: SU/mjpLJFzSz5eCOT9CKwELhZ8q4mw/Et9Jc0XF+zF8DIWy7HXsBdCEYYyNjdbXHmSFZoP1nKfLyTODaJ9usbUpjnXRuYq2QfliOAUALnQmC+JZJlYUYRNU6WDzZHIo6OjZ/bBXWbs9W6s1DlD9IDz/sOs7AkldQGcYE0WQqlkBWSRywk0iqmOhcgO6QE53K6n2IRznPbE1ugVYfEN7v19dBGPj3NCcFqb5RHEEDqTo2e63OMceZX2l6pmwXLjydEcnRmS7zGQ6IgD8azzMxnEcp6k4NiyxyhVjf/6ugoLTWIW9YEbUa6+2GQOqzMpj/8kz0l+PQQJzq5WHOVfyXsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 890c264a-c61b-4211-da2f-08de8a6be896
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:42:00.2634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB3+SbZD7flnf7n4EUaYVviA3nJ/UkmhsyfQ2AlRltPR+i3hoF8m3dLBvVHzHKngL0b7/TGRHaNQpqt9tUr4pdco7MKoLxcB2ECVgxSHpn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183C9380E
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

On Tue, Mar 24, 2026 at 03:56:27PM +0000, Ciara Loftus wrote:
> Commit c138a6c3bd0a ("net/i40e: validate raw flow items before
> dereferencing") rejected raw flow items when spec and mask length
> fields differ, intending to prevent out-of-bounds pattern access.
> 
> This breaks flows using the default rte_flow_item_raw_mask, which
> sets mask.length to 0xffff regardless of the spec pattern size. Remove
> the erroneous check.
> 
> Fixes: c138a6c3bd0a ("net/i40e: validate raw flow items before dereferencing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel,
Thanks,
/Bruce

