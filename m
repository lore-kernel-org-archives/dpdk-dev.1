Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE871CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C566C40267;
	Mon, 18 Aug 2025 10:01:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 975B14013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:01:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755504077; x=1787040077;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=cz/UJpzhF5tP96kRizQQUTDsiS8PIcnx8cfcpZQ/qq0=;
 b=WZ5eAcmEQnxR8nN/s9gd62Dn2j86MR2UWUg8wsrRHNwKgffC9+Ykefzu
 fS0YbHo+yW0sTM0aIieX97z0p0dyP5asuWCCWKWespgTCpNai7cF1x4/Q
 4SwPqlj40pecAQmcTCHPmBMMrOClFzx7icS0ZAYulA45UeIMA8AWYm2hq
 QzKk1votNjrbsdxYeFNyXz/IyH8G9KNGjEnJ5kws0MpKjEfTg3doDWwT0
 qNDgn3DTkMm7kn0MQ1K/9ia7gBsN8aJu9v7GEEQ0TSKv5gP9l78WC63or
 LlWrC2NFiRiWZfz2J9VkK5C065ByplCcEanjHgZK+uIkDqVCrc+GmOvz2 g==;
X-CSE-ConnectionGUID: z+J2Q9LlTS663R7Q/XVyGg==
X-CSE-MsgGUID: WJ7BvgdWRUKKOGRilYiIog==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57436910"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="57436910"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:01:11 -0700
X-CSE-ConnectionGUID: 4iTqI/mcSIqZ1pUmvG7liA==
X-CSE-MsgGUID: /6sw1CR6QuGUod5XZet45Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="167429778"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 01:01:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:01:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 01:01:02 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.51)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 01:01:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErXihoK6U6ic1sioaBDnTkRvYH2O8u2DvSmQzGXYHrEj2SLUj0vH2+FLF3wtBqD9Az1MOssO9xDnjScsyrSiAdYuP35tt2iXEweIFzWYJIQv+db6grKbYS83AowKeBzGLGlCzEd6VBJMBbJdTC5AaMqGMqPIUERye9NU3x4WlV72gTGTrf1pbgT+5EoZvsurseyS18AdUNojHrVfFEE62wg954Ufxuwep2vwx24WzM3ZzLhwkQPklpymNKRrdibMKHHHpLJ4PzZMp9vwo1egnD1uE8Uf2mgskNEh2qcO4bMlNmJt2rPWOsRXmQexjDkGUvN51k6UFVThTSgPnu8erw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKlZ3vM/o+CJp90zsXGaXsWT7pRjBPJSCKJW7TRX0NU=;
 b=TJTL1cgGicvNONYWgnFVz/iJBSUjQ6uqSdG871eI5g+OidcHplz+bM7fDrbo4+9hEQblGOJkuHR8xs8NEpsXEjCy78LKTN1dljX/KiuwYD4UNAWIQfVWmGRVUL4UEBHDSyrGCRbPu4BwOOaFOraWO+KPOkmXBybKE1WWsXMRLOMbh1B0Mj9H8EBcsf8qdXO9LglDSPf2VEequtTJrMVVnsi+d0v/U6uiKnw3XAhJykOiThcYR26t1TUn8R0wOI7BJdwh3sj8RR/bJ6Rqfz6go/fbACuBwFWvPzcidhtCTf/tbZYXtEm+7SqI3Y4dnepBE3K7Faomi7WnGNKSZDukjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 08:00:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 08:00:59 +0000
Date: Mon, 18 Aug 2025 09:00:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
Message-ID: <aKLdtBllWu1DkeF6@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814212901.88863-3-stephen@networkplumber.org>
X-ClientProxiedBy: DB8PR03CA0016.eurprd03.prod.outlook.com
 (2603:10a6:10:be::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6218f6-8d31-4fcc-75e6-08ddde2d5e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nzPRO9+PRZ5twJSmOFeZNT0mPb12wUNK7WbNW8wV6/Abv6tJOmuQgHx2I4Ig?=
 =?us-ascii?Q?pa5slonJ7ccWFO4+oRrQEpckrzimKJKGGlzvzx8h7k4TIvV+xYD9XxyZpVrJ?=
 =?us-ascii?Q?YPDCqvXLB5f5zFt7u67RcM9LxKRyQV4maT7ykL8CWKiG9MZFz8d9MK0cW842?=
 =?us-ascii?Q?eGJ+LtJ3DRZWmum5sYZMwkdtRgKD2PdFheGjIEAT6y8IHSeRWwX24481+3Iz?=
 =?us-ascii?Q?2kYgEBu5Nt+AbB9WqNouBuoGJ1k0FFpg6BDM7abFN62jfCOgfxnWvs9Dc8Yt?=
 =?us-ascii?Q?HpazTGYpXSn+au1/lslD8P6xEnyqzv0QcXylCtNWn68k2KWZgIqoM1MlutH7?=
 =?us-ascii?Q?AKdW8RfM9jBbHOIx7M+T7893dQksOzNAUiMqF2wrN/xqsELxPaxo8FvcCGJ2?=
 =?us-ascii?Q?iYudVOO0LTKrbWGWNA40yFbEYu3ei6tU8maN46AmjWsbNL8lEQjrH3TupFD7?=
 =?us-ascii?Q?7zf4A7UTakq2RXxK/falA6BSBsexgRiOPUOxljgXjm4UrhtslLwbmD27N9VU?=
 =?us-ascii?Q?QXIPMdqbjAMBzuUGpVvjv90zRaeNLyROiZ6/PyVmVxeSvaBAA48SOL28/bTI?=
 =?us-ascii?Q?ktW0RGfRYPxA2+jozopgLTqpJiCuokLA+SxeKt0r03lSGDwSQCx5+0omiGEg?=
 =?us-ascii?Q?u4Ci9qTACI90v1CYAlehqiF0K8Y1cy1boZzLWySoj2M/FoVo1nRrTG3R/ea/?=
 =?us-ascii?Q?ttzvMhXGniQhAsoCrC6DnjQ2o1/0lzebOaBtUEaTDONo7fLpnade2/SG0Tey?=
 =?us-ascii?Q?yDuvp95kwlz1XkBhP/Xwx3GastgSMGYvs8M5f72882CENab0faUzeDMaFn+R?=
 =?us-ascii?Q?iX8EXYk6sa93gyzsy5+6v6c0iNIQI+KH9nP0q9DwcoKpoXB0j3RDOHnF/EYc?=
 =?us-ascii?Q?vprwL7pElyLSQBzbKYXOM5iI+HwAE3QqUy28YfP6JGTnSSsj9MJdoI0l+OrD?=
 =?us-ascii?Q?eG46OKZECu3q8ybEqydh7c1qInDjRoK4Nzw2y49MRqFPXZkilVjqObXfHxAl?=
 =?us-ascii?Q?VPLtDLw4NGsg16SutVt7AJIoU43YpMp+a1Bs2vVfcHwWvrTN8N/jPIQ/lXGK?=
 =?us-ascii?Q?5lN+ygrbaIOYyjS3hpKeiqhIpiblXN+pTXRdxQv4kQiKgKEB9wszEhJrhbW4?=
 =?us-ascii?Q?ZU3D8B7Z5vqvvOxYv0UtUp7WLvICKVjPjPDw37SYnDrlnyHy7OqOdqTrvY57?=
 =?us-ascii?Q?LpwqV7EssONQDFYNzoklKbIwAv50Y9zQLJP9ORl3ekXhfXVQmA3xOSTK2xc5?=
 =?us-ascii?Q?0pmyHvCaJ1BpQk0P2k31V1g719ykD4mavx+Ktpf11HDvrzoBUCbvmsIExt0n?=
 =?us-ascii?Q?qfkSUMSTG7qy79GooqP1ExrOFOt/wGp4eZhIQIbUvJ+PEcdrMDDyanm439xt?=
 =?us-ascii?Q?5ntKTJ/LDhtBTbvnrPKOWB4/b8VXPyC4AIUHrIVGIFUhbPTN5zKezXhmPR0z?=
 =?us-ascii?Q?ZqQwAj5Sxz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1wo//nc4z/E12gel+8Kdg0DNPOpf/HFL57xJxdPMV4GpS/h2ooQMTXbkZShh?=
 =?us-ascii?Q?bo0hFjK0aoolcbeumY3Bc3h2PnjFFNGLEbK0lR5WN/lNm0a2tloN+7SW/C7p?=
 =?us-ascii?Q?QRT/pG8RXsVD4WHqNQtd/cSXQATibNBzJE7lvqTZsFi79fEC7N1doCr80X6V?=
 =?us-ascii?Q?5XSGjjRnOOkHNeYINTHkNSSb9oM8TS5j40jw6SS1onEdGOpvUfM0GwivtAIX?=
 =?us-ascii?Q?+ZlNn8UgTCn7QNlXLk0rO8M1xx0zNy+EhkuWDIKSeAdsIGikmo3chG3PSjo/?=
 =?us-ascii?Q?HhnNuGhzHHgrVIO73QQZJhWT1QwQIuku0rKbuTMH7IFd+b4h2UNGw2sxG7nq?=
 =?us-ascii?Q?49m6TFr1yVx5V6eQB9VLQmhk9PJN7aP4yCQZutwPTQL39OtSoJ0PJa8IJlH1?=
 =?us-ascii?Q?Zzz2FdHhMYbsaSlnYH988g997cRqPQgnoXhTipZFNi+YF/AbhlgYFKKJCU+Z?=
 =?us-ascii?Q?0QFvfkUIs2bOZo9RKV4FsNbRqjfoJnQYef3tecSgfvpPiWgkEkrqMBPExidh?=
 =?us-ascii?Q?8amJVSQO4Yd5u0MZmaQNqn14DCL2qhUY0FJS9Zno8JWsguEXlihxgrYHgSmi?=
 =?us-ascii?Q?jk4biXkJwKpWMN4wVoHS5jn9J/ULFwKNfr25cD7NZnN8WSUQ2h9V4cBFJh2i?=
 =?us-ascii?Q?rQtN5zElSI3wPBgHwa4A2sciBEl1I6yMzFFhv0gMD8YM2zOwvzPk7c5fnYfI?=
 =?us-ascii?Q?7+DHVWPO8LN5Krxtqkf8ejfFPFD77eOAW5JKWGngZIuQB+KNKE/lb8vVLPWW?=
 =?us-ascii?Q?ygnwgBDgqw5kiUOjFxXHZeotCEDw7NUfqUsqAQawck1jL+7IjIx0Brx+4pxm?=
 =?us-ascii?Q?pzw0CsoVrjenbxZaCpNo995gXlKHtgHK+W4Vungvj7CalSgXMrwEETfc2b15?=
 =?us-ascii?Q?GITvMvUwcvsvWIL15KB9OsLualsDSJyiUohB54IGMuF2FWlrtT+SnEXxezMn?=
 =?us-ascii?Q?QkBIxfge6vBcFC7DU9kX+6AR7gXLHNuk+fZB5KzUy9ec+J/si1lg1QzXLhcK?=
 =?us-ascii?Q?Os6rDDFJ0mByIeYXJxr86ilBH/FgoululZLeIMzuWhez/m/PgbVxk3vKtgni?=
 =?us-ascii?Q?1YzjUu0RDYCUDAVOrWR9QYrJ9diqwLvX3aLT1bxpcW3o7l7r20MP08qJCPGI?=
 =?us-ascii?Q?IW04QINy82tK1RH8Yl289lFPfKl9LXZkHQoHnDYm84LTuzghFQ7yNDCUEpKh?=
 =?us-ascii?Q?7hLDzgqXnLH94ifH/Zkex/IF7yEJfSa02VKHFli1iGZ5aunqGvUb4imhPbSG?=
 =?us-ascii?Q?NVTgSfVYXSBZ/uQaRjyfOG3Ky1BLQb44fiiKwkF9JGbAh6VRyHpbkPN42dLV?=
 =?us-ascii?Q?1AMxvtJzQMdHfBDVe+ruYj0BUUoK+B3xNnFF0lZPjyWVL51/AZiQYFyn1SfJ?=
 =?us-ascii?Q?ujm3h5wFt8FZ8fowh3r4XstZ9zMQQZzXmfcg8gv/G8fpSLWWuWdV+9nbV6ue?=
 =?us-ascii?Q?VXT25lUVz5Vqg3eQEsMu/qQ4upCgO64bR/2Xm+JPdCQeaNFq2lB1gTfuWuHH?=
 =?us-ascii?Q?TpC9YNfot51ee/uW/DKQN8FCitt068dectwANMY0xHpylabVvoU/OJi12b2O?=
 =?us-ascii?Q?1qahyaR0COfJKrXgYPVWUgysfCF5f6f2bV7USii4FqTWUILSqA7ke2k3qaZF?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6218f6-8d31-4fcc-75e6-08ddde2d5e1f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 08:00:59.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzBmQO959ITpeeK2Lve3I3vD/tNUUgONrUWZe7Uwx/LtptFXBeWRWdhS1wTi5sV4W0DolEGy0k3YnoacRUW3Kr0UDNlTBODj8+ISZUvcJfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
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

On Thu, Aug 14, 2025 at 02:28:48PM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/ipsec/misc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
> index fd4d3f5256..54dc5c2d4d 100644
> --- a/lib/ipsec/misc.h
> +++ b/lib/ipsec/misc.h
> @@ -126,7 +126,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
>  
>  	const uint32_t vnum = RTE_DIM(vec);
>  
> -	j = 0, n = 0;
> +	j = 0;
> +	n = 0;
>  	vofs = 0;
>  	for (i = 0; i != num; i++) {
>  

A better fix here is to move the assignments up to where the variables are
defined just 9 lines earlier, rather than wasting code lines by assigning
to zero later on!
