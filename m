Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA8E81A5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78ED840608;
	Mon, 16 Feb 2026 18:16:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 0907B40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262159; x=1802798159;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LMgvK7GcjfpEvLSzmQmWF1WowFXr9iELRvTPIcaccak=;
 b=N7wW9FVoX00HmUmdlVEJJeVx00UkxoMzgdL/5AasjOWkLJBItKZCnqM5
 YaDOdkSl3eJhwsxNt2k162Zz5xb6bf9Ub4Y0p9QPzvZHI9KvKNjJWUgRQ
 Y+JCyAIh+C1fWGe7LivhgCffz44rLkCZC3Tj995KuJ0y+2fa6LqXOkd0B
 g2/K/BMJZFEs+c3Wd1lXvlik3QDXAbJLFuqge4zhq06eVKXzZ5dOTrKB9
 bcAarpIa9I75HfGJgsR+IojqBi0h68rkSfgguDHGVkTe+fd1dZExa4O50
 uWHO0lvzvE5rOQa4U8ZpIX7wDDHgikEj8pBefahRncWM6893UaYm/FUQF w==;
X-CSE-ConnectionGUID: +erOAxddStWMJfuhKCLaaQ==
X-CSE-MsgGUID: lQYhOB0yR6SUwGCvGlF77g==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="82672961"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="82672961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:59 -0800
X-CSE-ConnectionGUID: c+nCNfdsT7GqKjxLIs4ghg==
X-CSE-MsgGUID: n2wK9UHESNmtHCqQ+iyayQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212758877"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:56 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:15:56 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRFJXRtRwZLRGYZuxoVpbJKR1V0e5V6XbrjsFj2Oaq4Dr6/n745gtkpp/bWjgRNhjdNVeaYM3FP9Pqk1g56yt2c5VUc3KxU+JUtdG3GNGKAbyF5DZqbd+VDoEt2O/llkZtC5iAlhXhbRCS0TAQRE3CuK19FpWXy496xMHmXzm+qnkHJBEVL6CEfe19gPvie+qcK0bm9uxdZQ4CwZ9zsVWSi1BqYGPSZtFX3gNxnJMOcT18Qbh30kWOuhmjx44obbYTUcjwJjlzftouM1TWKFHsFA1QQ0H4B/b0w7Rqmqh7PecQ9Dtj8ndR7BVVqij/54MFpjKfF9LotyEXL3s3Zkpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JQLyYeaj3cyegqiK1O5/agZ2BP534QHaMGzGISNTsk=;
 b=jyEA5suAhr8IF4DCT28gdcCkve7KoOwNbAzeeH6VJ6BHCWXZVO7H4fvhmBexqguYw7Fp6LNb+nU5LDvRFBXIgbMYcTn1q6PaUQJI1rqV/4MOW3NVc731ESiF3FR5Ils343wsGRHoCQCQ9wd9Tj0xIN2hXAehr9d8bYL2TPqXdK5jUTtrDVWuw/sNVuKsRBwiriYrLyRrMuSH08ar00cWp/EkConnWuWqQFaLaaYbLxgcYZoMPHrcYiVfhY5qfvzh1CG7bXe4BiW16zpdh/nqdqzUf2pY/T9zyHxyEvnrsIj3nldc3+U8L02bttTFU8FngpQFUZLFyLsDWwGPpSVtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:15:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:15:54 +0000
Date: Mon, 16 Feb 2026 17:15:49 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Message-ID: <aZNQxWD9nQm1nVWF@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ceda6030af950283c4c6eed39b8d14266b68b04b.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ceda6030af950283c4c6eed39b8d14266b68b04b.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0297.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: d28f1b1d-d113-4b6c-c038-08de6d7f0aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C0S6G1DTgcCplfuY0BKOdz1MUJywEa3AfdF1loHDtb8aaa74GqWw56oSzBz3?=
 =?us-ascii?Q?0wo0BWKl2rVL2ANrdlRDLBE9IrDJq2eOldNi/bGlr7QzIS8kbg3qNlhvW/LM?=
 =?us-ascii?Q?u514in/xBrXxxBg+saASx1hOW6ONvR1AWn27asXk4TXfQhifXy2/zBxNMimQ?=
 =?us-ascii?Q?QFNr+LNs8itn32TofqZ3T6LimAjqxztDpUO+Gv6D1KXdbdeNppqrhMjeB6wX?=
 =?us-ascii?Q?NlGUSmdwYCivW/tuwo0v2A4S+Kg2XDqf+yICa1DwLw8zkp0+zA7OsastKufZ?=
 =?us-ascii?Q?La/ChPVq8501lE8wYrYJVIr3wIFjsFxa38QBmUsJUqI3IG+aH8WmO3UDVsb3?=
 =?us-ascii?Q?lxegDUGgiTwynxdIiIGSu6DsfeWP7mKmQqQQ7PX8JW8SZi3+NIMpKo1/6KUs?=
 =?us-ascii?Q?F69i5LSOyz2hzfpFXMSGYpZWjqFgTbw2W2tzlZI1RN3y6hJTy4UhBpyp0zMA?=
 =?us-ascii?Q?BgppNaoedxhBCu4xiFbf1YNqWNNgXOij/7Da6zm7vGDliXPSX4PqlrV7Fdbm?=
 =?us-ascii?Q?GbhwTMA965ULnZln3fVGmKIcw4y6ucNOjhOXm7ClTn46maBmtgzig4dYqveX?=
 =?us-ascii?Q?7cy2itLW5NrbD6vOQLxlhyCmhM8UMtPQbVF4NWuCdmZCfK17pL4BcKj473TG?=
 =?us-ascii?Q?/XtZjfXmVd7VXNUsCAuBK0bHOHocnEepWPK2rChm0ojRZt06tRAE+MyQqFvL?=
 =?us-ascii?Q?KptPY3an9qokYbySQ5TxgjpxOFlpFOuYyu9zqmHv0CnpmAej3NsXihFiZ/xg?=
 =?us-ascii?Q?rih5svEFeeEgO3p7ejD+dNNGT4VQV8mVKMp/CG9UQ9vz3Knddep+/OLaDFZ1?=
 =?us-ascii?Q?nLzfpk+Pgwswt6i9JJoDiNfqiZmotkEoo6TtStoeXYKtcqT3HW9PF77xJqLw?=
 =?us-ascii?Q?XCgM3jNgDP8IJaGEV8cDfnhO6K9Cn+wrYO5Kzeihsblm2x0g47TCWUgZA9IH?=
 =?us-ascii?Q?wIXWF075nI8tTfqldibP8TyAMcn931z3JQyDA7iXzFJyhoPkp9IZiCOzgY2S?=
 =?us-ascii?Q?vuenaMJXQfOB5DhTd6RWdjxVB2K0M8l1zwOqAYjFVoFRVjMMT8m13ARKr6U5?=
 =?us-ascii?Q?U4OYLicZQZl0sTj9zzHLeQE4g2fGULmoBs2Zbr1bTRsQY7z+sEL0ZTkvqrrF?=
 =?us-ascii?Q?A0aFpkEeQeJLScImwKrRJOTyXcY5RQy+ELxQDOLvoZtncYrl1Q0KxlgfnWAK?=
 =?us-ascii?Q?jxnLCBFJJ3IlViiEzgGxQB510F9fQkOwcCtbpAGy29359xyDnzbPlU6O12KZ?=
 =?us-ascii?Q?kjdhcqBHDO/e48mcQ1RvCjZk89dgsfreS9Bk88nomxAkI6OkXGFuP/k9ola1?=
 =?us-ascii?Q?lL0PTHzYz8JdEO9qVWShXcGn1rVvPGGl92YUrJUH15LCwE6nrnrBEGE1M36Z?=
 =?us-ascii?Q?Es/D2Ys1aYjl0V/NKoe0NZqSFcGaiIM1gweXU5RG4HlC1Nilqrh++6RtvKeW?=
 =?us-ascii?Q?MWZEV/MO8RZbBIkMVBrGa3l043/506cWOIbNs0UYZEByv4C9UQYFJA0t/oQ3?=
 =?us-ascii?Q?AyYHtn0xencwnBZHAVzbmlPnKgq0J7rUhyDee8nGHEfGZg6Uxs+/gNz8Sw2M?=
 =?us-ascii?Q?+HF3ojPB1rqp40k11Tg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5a7UTILBOUZEKpEnC93Ybd/D6xhzIBFdxUyHraZBOaopkjWRHdUMGqjwf4P?=
 =?us-ascii?Q?KUZxQd0tQ4d5MmVkjAbs833O0xKlT5t/h2Y9tolmHE47GJzZFYhRZpxW2TdL?=
 =?us-ascii?Q?JWu9zZC2BkFVGKYceeCX/V4UyFEtO/9baam4kbf9BSGNA8BAcJbBLYutcrZc?=
 =?us-ascii?Q?4+KS/pPkeIG1gc+Qvy/2ff5rqrGK28noMelVLQjNNhnp1nb6TXFhEXTstVTU?=
 =?us-ascii?Q?mJfEUzY8fWDGq+xIKyBY2J7MzHWcOxzsvX/G7NkzwiHwEUkm3vtlANutI3xK?=
 =?us-ascii?Q?+ojlPDvQlFD7tvYEbD6zVm15GSWq2xXVRh3w4+TB0ZWZUTdHf3DAt0SxvTrY?=
 =?us-ascii?Q?O4fKuPxDmC3gjFTyBHA2bq3IqlgNTtg6CphpDw34PqB3hecjd2TXe4n7K9Za?=
 =?us-ascii?Q?uq3YoD8CW0QcgWAZgKls1YTiYLlzVQEXIVr7DgyEA7oUqu7G+CDsj4WIo/1C?=
 =?us-ascii?Q?qMRu64qtMWRtNhc0wPZmI2P8U6pgwPaP4jBNWv0+fW3SzJzs/T7/6aN5Svas?=
 =?us-ascii?Q?xRRzA7OQqmYfWD9u50TzYfgpmWzzHqqQY7sMa3iRU7Zn34wBzc4rOzIThTdM?=
 =?us-ascii?Q?FmPtf4MZmPWG+XLz9T5GykyBQmrpC00Ho0aYK6GJvsTl5qDhaFkBwPEq2Utj?=
 =?us-ascii?Q?OoHX049jIOD7QtcHXBG34wkUm6ac8Bp+LJwfQUSAbozqKqlDl+HEwXORYT1D?=
 =?us-ascii?Q?ASUfRX/nm74sjXyt6iAYUoxVWqjxJrmszDckeRbay1/KwNsdQAav3roR0SzD?=
 =?us-ascii?Q?8bWu9ea05tm8zNA72ae8gGIB+jb8w+cLE1WqXfj0h7snr1DjlPgY1C79uxLR?=
 =?us-ascii?Q?K5PYNnQD97GMLp/7emt7X0f4ObDhmeitm1XpYLoiJtsSyVP0hi7yd2fom8e2?=
 =?us-ascii?Q?dFlL9Fmh5qmTtrNc4ijZTunPcthgPb9jt4Du/6SZ69I4Ijmk7Y2j/bKI2xUe?=
 =?us-ascii?Q?tWOzv06TM1ZwdHvBFUVQcwVWqH6v7f2okiDY99ajpskM60+QH5vXELWZ/ENS?=
 =?us-ascii?Q?6deaETIdejdk7cv+yluq9o7yMXu/WYqIaNAnMnNUEnMULKpKS9YPu7ba2dTq?=
 =?us-ascii?Q?6OqgiU3+17ObZThltjYH5z/AqCm/8VrScLNAATFFwH41eRXFo9Jf9bc2MwOf?=
 =?us-ascii?Q?PGjPwiVETriqnMp5KKZE9q8074PJIG29wtkJdksGt4LaNULMUnPWCym5cUnY?=
 =?us-ascii?Q?7fB8gsKvIQMeSa3VuUEYOhiwjaJDH6FOiElmDObnKPXNzyalHU+hrZ9VRBDa?=
 =?us-ascii?Q?GUrcCrDw/8XyMezvltHjhdWQAUDoaNzf1UZIDn4gM7y61SUUp2gjTOUcceH6?=
 =?us-ascii?Q?ByJF4vj79S/wqqIzrztgUuZ6xSQ1zH1qxffBOEkHz56xFRyR0PUCPMh1lEQT?=
 =?us-ascii?Q?p/XTTzCfw8oyVbxS/0fPytICHjttR5U4I6QWKGsw9KCax7OvZfm15bpTlJDh?=
 =?us-ascii?Q?irXNENOdBWNo9kO6UxzmUPvIOC0FP2cFRUHeuXwdY+mBTeIU33tN/kA1Wrb2?=
 =?us-ascii?Q?p8jAmlp5aJWM6cwZ4m5j6K6M7Pq2XjjutmPWMZtZKQAGRHcJoNhbHxGPLNxq?=
 =?us-ascii?Q?daAGLXQxPp+4Pq4DRSk7NDc/Z/xAxYvr/BlK0VpLJ4SHiQ0qt+lvFIEy+hlW?=
 =?us-ascii?Q?ykRSefz2NDQ1ZyA21RyDVl6E96nqhl9oa9T/YmVEAKyMJAFq5/aF6bOEOBMG?=
 =?us-ascii?Q?op0VTs4Sit5FN+/pfQb9eT2C+WHyOAzlzwlQX5llKL0D9Hpf4LB6JFj6s8tD?=
 =?us-ascii?Q?34DTfaL4Kae18slUUb9SIA2LrBif28w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d28f1b1d-d113-4b6c-c038-08de6d7f0aeb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:15:54.6110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/HQVbENkdURy/pZXhjWsrhNsR8FtvO7m+TThBxijsuHlD0qPjPRoiNn4PxKA9v75rMeQkz/ZDiR5vDRthVzDI6NK57h0Zwdy8DlWmCztz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Fri, Feb 13, 2026 at 10:26:26AM +0000, Anatoly Burakov wrote:
> Currently, when updating customized protocol and packet type information
> via DDP packages, we are using rte_zmalloc followed by immediate rte_free.
> This is not needed as these buffers are only used temporarily within
> the function scope, so replace it with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
As done on v3:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
