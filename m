Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA2FCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:48:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D41C4065C;
	Wed, 24 Sep 2025 15:48:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 423F540289;
 Wed, 24 Sep 2025 15:48:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758721731; x=1790257731;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rsIUoC3KPppN1nIPlS91vH+VEdfUDcwuHQFlKRF5fBs=;
 b=ICfrDiwS0A7nwYISvHYQlRF2mgqW9MlVc7XwRcEppdxhoR8yQ479fMAi
 SUWLFIhc90PyBnEW1ESuquP+x+uXJ0VkshqDj1jXbfgaQ6wiJXG2nBac1
 MI22me5T8J7K8q1oYebsvnpQE3yC0RLqgHBQfwRZsWra5tHjYyf8Kh8o7
 o2ZRcXojhzTRRVeKy/B2nPlStsQcvDTTC8Me0ElK2whQdHiqc4R8jdrpT
 VAd+3nN1ck8w863pFIoFDvGjl5eXOHhGToUMzRYmnewdeG31JaJ1HcCgM
 4l0h0FQIQTINa55TqrcY9XPEmTukDKu/kVURp2igwjWhGqcuPnzgO7e79 w==;
X-CSE-ConnectionGUID: qFdkxCvhSzWmMRjbbNFL2A==
X-CSE-MsgGUID: /NHmDwjrTfm7fhbNCeB+xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64855507"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="64855507"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:48:50 -0700
X-CSE-ConnectionGUID: dQ4uiUzxTaqScWs6Uy2UrA==
X-CSE-MsgGUID: SluN1+TjT+abaQElyzX5Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="181434693"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:48:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:48:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:48:49 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.60) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJBxxREgmU0aJ0f7UME+h/hlH7v4GgPmC0tZcxkM+gtkhufXNv7JAKpNO/cRUruXRwMmY4P91eD8FaGUKEnvfCoW9h1TRjP4YKq8EA49j8aYUiHxe+STbHzkWDcp6IrMTnV//qzctddEC4DQKYqEmPdIPOoTfaQpcwDWP5gMyeD5Gt7r6mX4ePWnGWaeT2IniIrlSKCnkfyzjMFlbCMlZ1bcns+k8yRT84mWXi4Wurcg9ZAbNJQrzELxMJF9MiHdmRzouyO2N7tAmdhgYa2p+mKrBG0c9AY/j2npJLyA1VchXk9NcTiHnzStXyv0pYwsKE/Emcc5yFnPgje62jhntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+parQoSbxAV2KPtV7eUVzCubJEOybfg0ipL9tGjLWEk=;
 b=V/8g2q2fMcitO97NNTh3ID24ypAoFlEg2vPMZM+H+ngfRg+Ne4qkQ5vRQBaWcsXlf/3psMKrAB22oJ+nqDMYJzeZIn0I092SYMmVInzy2P71a+z2jPn7yGByFrQQfvlOug3jn65wPM/HjNrMhVZf9NPIYbpK2CX2Q7LRi+uEYkTRandN/BeVsfTxIixMg1HeXHGDxfxpvU+05ZjmgH2zcc3XSUorbj5OJ6QZdCLqLmmC02OZjL+DqgmTb386efgBqWxY71xoXg5wIcTMs/NwZNWeCqqMIGmfWBOlnbwqJ//NARYZUmZM1OrCQfBqOBgO0eiSoCc8bK0x2K/skWWjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6189.namprd11.prod.outlook.com (2603:10b6:8:ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 13:48:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:48:45 +0000
Date: Wed, 24 Sep 2025 14:48:40 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 1/8] net/ice: document support for free Tx mbuf on demand
Message-ID: <aNP2uMxUhqhaDZdR@bricha3-mobl1.ger.corp.intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
 <20250916142113.3485738-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916142113.3485738-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: eab2616f-f7d0-42cd-08a9-08ddfb7114be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SBpoKZFzEkQQJNpVwrEv6hrUS9aVxzyIxsF21cepdajbHYDp/Mr/h5bnv6kY?=
 =?us-ascii?Q?upAuRD2ucnle1qy+X1JyqWdjYotMYy76/6wnm0L4X2tFMsaxfRVLstCNyYX9?=
 =?us-ascii?Q?AoM7LWmg2NkDeC7dGHuxS2zdKuOEQd4vUJsF69l0jvzfnXUeqQpMjMbRK/e3?=
 =?us-ascii?Q?JSjoILFeJ7OzjZLwnRL7vYmz0nfMO0bjFa616Tj7/Rwk1ZFdEbkqOyfE1l8D?=
 =?us-ascii?Q?UKfbLXKak573yo+u+4L2cJY2kzAqlgiN1+86MP7TqewNnR6ojtknJ/apQOCR?=
 =?us-ascii?Q?n133EHqr3sfDJO+fCj2D9AakN7H8pMQD7n4WjHz+GWQqSgUaHpgExMuR3u3p?=
 =?us-ascii?Q?wPMc+a07TkbPBZGAvxFHtura6hjWxAdF3aV0BMitNCZIABgFkMjXLUb4zpKc?=
 =?us-ascii?Q?1g5+fs/t3GD5ckPe35RM9QmgeVzAlbNMaZ1LSOvhASnbyfPst7PFwHPZKTfS?=
 =?us-ascii?Q?LAlmSwbp3Ue0UH2eOGWGVb9XFFjSvpbPtqgso37xfGCfSHZOkqOVNhliAYDm?=
 =?us-ascii?Q?Bnap1kQyKJUzXEXWa26zDEOp3hLqM4osIUEbBnWBEbI3YS3e2U+hxN4E+2LS?=
 =?us-ascii?Q?KRaWacv10fIuFfg/d6MzIbGkFcVc8wtsZin34e30xsrKcgDMdFaH2G8bX/45?=
 =?us-ascii?Q?30SVwkecskaQk1Yho0oI2Q0cJhwvovLyGaidHy2krk39Y5wXc7OU89gmbDE/?=
 =?us-ascii?Q?LAayTCjjjs97c/Z/BrJLj3cV2PF3l2iNM58Ic/rDzj4P3EBRosnQdT3PTqLk?=
 =?us-ascii?Q?3qIzZwa1Oos5Pk2w6gGRuRZk08NZKu3tXx7UhUECRrAFoVM9siI/Ob3yYgUy?=
 =?us-ascii?Q?jtLCAuiJmiXaUqFKKiU8dVaHn+l2zO4L55IMzr0JEukm04CoN1D4wdehOUn5?=
 =?us-ascii?Q?PcueBnFr9elhonMpl2j70FRfesN4ZArOh+sdDeAiHbjwdciifBofX/PaXQVa?=
 =?us-ascii?Q?Eeo2kSqVJjT21ucj5Qj8Gw2EEkByHYPUM4y3+eOcV9Ta891s3T1TBu1sEgUQ?=
 =?us-ascii?Q?4l+QMxe/kMc9r7T9zAYMPvAqzaZyjaaJELVoCWVlEMGTMvDsZOvaP03Yia/a?=
 =?us-ascii?Q?A7rgxne9UkfGZd+Sv612cIirwaEYuhTa2LKGLffEwlXf9m7UvkuNDiYsVsA/?=
 =?us-ascii?Q?+gXnyuXZyhdSrczdJv+8uySGHlcpsduaALKomHeuIqLso3jOPTqad2jjR9sp?=
 =?us-ascii?Q?5hgeMMlZ9GOFoFZqZ7sG8ewJ95G66innylhm0Ny2fwnY/yu2blWoJa25ghwK?=
 =?us-ascii?Q?3Q7idn6UhOHKzcSsobMizC8uJi3ZY1/TfGUF21bOx3bnAGSsgPSpOK2la6wv?=
 =?us-ascii?Q?y111SMpNQmEkIkArRksNnZ0JFPiLoxXWNow/lmiZLoReoQUvfns9eKy9A6sB?=
 =?us-ascii?Q?oqYrQAM078lqTge3pODffl/jRgsQ0PeOBsu98uxSwPzh3zZxF+IT5fiFEmfN?=
 =?us-ascii?Q?y/0EUceEOeA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+VrpMVZXuEbmB8hr/RA6r6L7pq1nmkv9qbYSM6WcV8Yby1xTmHqb3Eor0KOv?=
 =?us-ascii?Q?xlfx9bYhWyvm0FpQhCYto6AzSre2PgQGttgGIZRNPUiuAk9lBJRd+x64SfvK?=
 =?us-ascii?Q?26e+u9wCDkkBKx7Ic0hLac/Osu+k1vmGcgXdM5+zgU0MJ+v64qrxbxCVwTHc?=
 =?us-ascii?Q?kf7L3+K+GBuRsh3xNA09boyYHDTSE0YWF1zEuxXmz1WF/QlDKOUiLhp3m99P?=
 =?us-ascii?Q?wjAHkyokRwR2Aedo0Gnu0/ANYIzyvTP+yMmKJXkAlMIILm/XS5scQgW8/tLE?=
 =?us-ascii?Q?pmhbNYyKDgdU0C05mCswew9ogQgsVWVZk3AhSAvj5mCakHuHL2s6K1l1D2O/?=
 =?us-ascii?Q?PgyiAT5vTCaaMHT+gjGeRoX4V27+6WHVECRXVf2wIN2OgYozt8bTOtxRi/n5?=
 =?us-ascii?Q?JFujBlrmCMMNLXJrpl9pQSQlLXzB0XPtHIvxIa1HwG2ZbIrMebQWuAymDupu?=
 =?us-ascii?Q?jcGUur6XDvCyYYl+M7wXCydRIz9ticaTPQfa9xvDCmefrmBjrhOQElklc2xr?=
 =?us-ascii?Q?NHqY3bbA/6sJRYincYi6UxkHse0JtUaZSdtuZSUYYYnrUBsBJxNTdieY/ie+?=
 =?us-ascii?Q?DeSIpzzbIRTXo3RO0KaJ1Fh1zydCZgZHGoKjsy+YhXEuD/Z9qcviYPK9xvP/?=
 =?us-ascii?Q?0K1fUmQ5eHLkRduY+F+D9vJKEYkvhqJg2BLyR3OBcbp9AKQvV5emXFhwXrV7?=
 =?us-ascii?Q?OrBvtO0YBffvUlh5Ez3yK2ICSI3RtpBIV3kod6H2lUewsrvL2ZLqMER4/wM+?=
 =?us-ascii?Q?2FvBo0NfL7v3V/sZY/zxn77s4lBZ7E/X+bwpD0UPhlrvQs2/qUwJne6yN+4B?=
 =?us-ascii?Q?TOr3ZcuYjRrA7FyMV5AN8eRdGYXbxaUSKsRkKsRz/WoCYPQUCtBEzl9qtNje?=
 =?us-ascii?Q?38Uiq0HOnBHr4ggk+tqWjFICQL4n0jpbPa6NhS2LTp7CRIZId/m9ZRGuHHL8?=
 =?us-ascii?Q?76CD6XMOloR2o5ViX4ZuDLkcQqidelQK2NXFGdZfjd6Mte2zCxR/I+ni2b9k?=
 =?us-ascii?Q?Rl5f+3/pU4I8iiEAIeSaIsCglEIbM0KkCUSu0Rx5pG4SSea/p8uoOIQlwx6O?=
 =?us-ascii?Q?PCt45MjzarNotLGtlZ9nC5pXvNKpizZBmvg6cGRf7MTwyV8LbaECLvY0DP9+?=
 =?us-ascii?Q?zzJGbPnsquoz33L/0orsjXCCdrYIwDF+sV7wdd1tkD3H/bR45d/sg8XMtx1d?=
 =?us-ascii?Q?4zlF4zkwJTWliLXdLgoKn/O2dNzq3L+KtRl8CO0ryaIJpFCWGCMKXSARZy2P?=
 =?us-ascii?Q?UBQqqJjHoklnbY/Qs0H8gkAcOzHENLHWu4C0kfA66KJ71uvZ+8we9pkvx0SD?=
 =?us-ascii?Q?tt9XPoLfGnwFXK4PUw82tE7WeQN8WZ1v4aMNyZZpmV6dBXLGlkE8ijWckqCk?=
 =?us-ascii?Q?OIRjKo20wPFKxSsgKuHBYx+jpVDQ33Y71aijci4vjniTPdC6uMj2+M/T0cao?=
 =?us-ascii?Q?4uDVI6sE+MpJzC9VdfR9F2IovkAqJ4k+lODS0sGhmN79PDOPU3zxDuP3mqmx?=
 =?us-ascii?Q?/oh4CcTtPWO6nD5CmY0KWQChS57AYaQ1sO1LVYQ9mRINc9KU3KX4undUIdHg?=
 =?us-ascii?Q?ECT1iuTugnq45t+OWunlQG6f9nIe/Ez4JnoG8cYy2vX096470oq7uOYHzKeD?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eab2616f-f7d0-42cd-08a9-08ddfb7114be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:48:45.6702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kffkM/Q7M3QfoKHfQ1eoO1wZqjj+Bns9bq/AGOkVNGHrM+n/zYjiTaAU81OW+rpjrSAGofyOz+m6SdN6LoSv3UOWTHs/k03AYWYIJeZZSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6189
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

On Tue, Sep 16, 2025 at 02:21:06PM +0000, Ciara Loftus wrote:
> The free tx mbuf on demand feature has been supported since commit
> ab7cfe1fe3d7 ("net/ice: cleanup Tx buffers"). Update the list of
> supported features to reflect this.
> 
> Fixes: ab7cfe1fe3d7 ("net/ice: cleanup Tx buffers")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/ice.ini | 1 +
>  1 file changed, 1 insertion(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
