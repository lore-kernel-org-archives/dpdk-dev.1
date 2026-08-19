Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BEFC5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 14:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E109402CE;
	Wed, 19 Aug 2026 16:04:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 11C4E402C4
 for <dev@dpdk.org>; Wed, 19 Aug 2026 16:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787148278; x=1818684278;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mURJA6LsevnWigWXRS2wOhF18FH1JyE9h4KVrmcCe/8=;
 b=Pj6wlNppdL3d9Z7D683rT2oUeGEN6iOGeVgZJJP4CKomCVvRENaA46/t
 QXyC6i7rEB9FZuHKj3Wy03FlTjxmugtQ9D4r/qK/G60W9IZHBTbCh5u+z
 nOHW9dSt/JttC3E51IhDQ+GCrtIhQQCNl56W9PpzwX30057Xt2JRQAQJS
 TiUcp1vwfeGghkX5klmqGdUjmWbVV298DyvjWbDglyhL5rG4GyJfjsaKT
 cATGMuJKRK+FvY4XoGnqRK1uu36etscPDG4DEGr/z/ti9j9nPZ031wAwC
 2U6EKGX5WR1Odj6mna86z7JpM+csKau/MSV0zyO3ECNV5j5KY6IudERR1 A==;
X-CSE-ConnectionGUID: JUAqKi8QTPO8WnezrPYX1Q==
X-CSE-MsgGUID: IuvFP/zjShCNX8iMBBpSjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98330965"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="98330965"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 07:04:37 -0700
X-CSE-ConnectionGUID: 0sj2ZgPpSEGW08I1A3JE/w==
X-CSE-MsgGUID: 8T5ru84mT9uGYwLbjHeDSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="262933065"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 07:04:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:04:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 07:04:36 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 07:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyJIopFt2qx0Xykjrqvsz11290T8hId24UgM033Tp/JXCI1/GHWWLdaBOO5EknSn4MUZYW+SfhMpM64pc+NpS5ytA0stUoCySBu0Re6n7ojCrTEfQ1c9sJBGF6u04oisce0QDuyJMLYLfLUERczYJ622nmTgXErH5t3eLBtlwfW8hEbu64ylcNq4YkIK+tlnfI33rG9pQeYBdYChKYMCw0KpQ6YVJsRpJS5rL0jGCAV86IR+1/0AqvKGTvd9o0NbvLcM6sIZxQ92Ao2itsPZyMYr3f2k5wij9RETgtOwN1XLbsQjoMeQSZvj9AM7Enhd7AaTBBskpvGzMhc5hO5HSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M2Uxr8rKpD0mjQfVAq4ZIha6mdRsIrwgmfqXUJqjUY=;
 b=HPpInIVHGNeexq1YigUzjH7RoScuxVe8Mk8lXc9Zt7zffoz4Bhe4xZ/ShCCYZmGX/a17zJRBXMRA8j6Te8Tf3YH8d2JVEw2pvCzt2m0RDOeK4zEhMvfLNtXMg0PVhEplIEg1mHJhDXxOR2KjD/SayyuEhO/s1sNc1RDIzZOcPkaL5kLvewrSRlEJZgtItFHWISUt/3ZT9LvmPsJ0KmbKpAtc42cFqoFilmZ4a99trkQI9ze15K7iOpOA2IbuirGIhzr97gtSp9krxxPjp5FBt6OH6Vg/zk2fazpfvMlLXQGWxGzaAdMdJ7EaRtKWJnGmjJB58cXFzSB3FPMUDEjTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by SA3PR11MB629882.namprd11.prod.outlook.com (2603:10b6:806:58b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 14:04:34 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 14:04:34 +0000
Date: Wed, 19 Aug 2026 15:04:30 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/7] IXGBE IPsec fixes
Message-ID: <aoW37pfvobo8XK90@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1787059137.git.anatoly.burakov@intel.com>
 <cover.1787142684.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1787142684.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::26) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|SA3PR11MB629882:EE_
X-MS-Office365-Filtering-Correlation-Id: c661fcbd-2af0-4b7e-2cd0-08defdfacc44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: /ISaD0cgeuooqt7Jco5RtnpsH7wflXj+J90dW87j8/sXyVvoAoO1lqZa1CROwpwIPvu+4oEiuW+tIZ9t0cGka+3wuH86VXDOHjm5U3joE2E3FHxwKAWFIMnc8tZH9RmC7hy5c19VRBAj9aNEUobR2nSDK72n/z+xnHy+t+D7vjRx1eGdvm8GBNb3ld3SQOSUmscDJ70YsCLevAeH9zQI+4ohB1SCxtjs7D0UGSYijtT0u+VsF4IQ+UyKVWbWEBkjC5BW0dH3hr66iV3ZunA9CnMWeA0ECyy/Mnd8nWM5Ho/SMIx9ovKiOnoq8COB6xahwKlOWPPmTDd51BKXb8dSPNJyO1PTlyDj4Xd0d5AMgn5rjMeSmoriwRlpYN1Vuyj/OK7aDockhDlIZ7SgNUUo4OeTBEsAly0HVwGrHaYGPKPkwuVhvB2+/qf/9OKZQo1JWZNPEJNIc7hWJ2oQFXfVmiH/UswqvN3bkGFszojzR6VkkUSd9nvuPdwQdTwSvlM2RydS56gBs9wA/9FWNf3RsHTnqskrWA3Z3qYxCR6F1XCr4GeasAhWh4vnbyzAqIZnXdge2m2mrTDndX2PRKb4IsZ9JgwXfoqg+rkdypaPb7391EmmH/hjyJQSXKnjBj7nH4/HtAk8TvwyCAjcbSL3Qab7ZtQrqVk6PVug4QsLXis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JGxm4+Y0RGFjD7F5e2+d1TNEE0OVVseTQV2PcrwqlE5gEBwJ++KNxvJe/42s?=
 =?us-ascii?Q?C++p0AWADr+vXF9yXyt/+oCGj7tg+Lhkp6GifczakQZsjt+JMownaZDQeE/4?=
 =?us-ascii?Q?GA6GYNmVonVGIlhRPohVeqDaD1yTsKIB+FsBVd+KB/dMc2zWBtiEKUCJOwMi?=
 =?us-ascii?Q?V43jcmrB2fkpkdFw3yiYldwao5Zu0jKKrA9lj7ryOciq7JolmLgm8kkhwSwC?=
 =?us-ascii?Q?zuUO6hWW3Zz2VuTvzuXxhKZdBPo92NciWU67QWbPGsp5YRwi1oZnvfLxBh4M?=
 =?us-ascii?Q?ji0XWZOCOl2MPVoVqjCBDYpFCJNlV6Wk5e9ZRAnMQuNEL5h91i36v8Uu9/Bu?=
 =?us-ascii?Q?/MdushwFmISE1r85d3iaetb326Ft//d82hDighOlzB8CJ2RWVeOtcZ8O3BFK?=
 =?us-ascii?Q?p9wbe2m5vdONRfRpXyBQaPAprmqUJmujQ247gZR4rS3SbWiQdr7NN6EpHotA?=
 =?us-ascii?Q?RF5NAWl958e0avzKPoLPpHTJX9tnteodEihQ79UpoRKxckdjj4Qt70bfN7aI?=
 =?us-ascii?Q?zvjMaxFSJsaBNpCxbI1nkwvg1A/PwGWD7v4sRUK/X0ouZvvU8TnOZxY8rndW?=
 =?us-ascii?Q?itQ4sm5IcyrM6vZ04qqnMrSnv1daFot3kIJmGlJJLWQfBK/CM2kdFipBSdAM?=
 =?us-ascii?Q?LwfgL0qV3P+snEqceNP0RgI+NoW/66jDhepEC5ypURc/EZwQfC3M1ChROkkt?=
 =?us-ascii?Q?9xUuwQ31dKfw28NYteTLl3Q3OFtCGcGgs/2jhimW2JimdiQHEC1fnGWG76cp?=
 =?us-ascii?Q?6yVWDHxiNiVOIROKiNuSh5bN7CCNwTb3SWFUzY5k8AyswjlzO50TsDC2tT50?=
 =?us-ascii?Q?UyYugDqgt+ekuJohiurHtnD33J2E6p/jxBiA9QgpzWuDG1gmZw5nNrmoN0Up?=
 =?us-ascii?Q?j4K/6n7t2PUETKW39cZHGgg8ZXSh4KIzAhAGRwP+hFAXf64OSmWtiNviwInr?=
 =?us-ascii?Q?g4ibsl15d879EERVgKzlAf2CsBSmwnPUFb/dJYF4oSo1wsl/1ntKh8ZdPW9J?=
 =?us-ascii?Q?Mvw7ZHVqOblSzdccQ7rvxLxo2mzdx2lKN+ORbUc4ILDVo7fW8ehCw+bhSDo6?=
 =?us-ascii?Q?wxm8Uf2RhZ4+thtKFZwCzQZ/BD0TBLvd8YM3sWRuhtix624aN8CiLxb4qG7g?=
 =?us-ascii?Q?4JE60b+hezj8d/wuEjBTaFtoqBwg4Hf1SvByTsMYxPXn2NXmvI3J6DwtPwHh?=
 =?us-ascii?Q?cRZ5hqBYM7dLUOKVmqwfrFJg90xMfMzrwy4Q4AYrhmM/RDSnwRS0W0J3czda?=
 =?us-ascii?Q?EqwGHx/7+T43BxhGfHk+cIy5SfjDMtJbdlnxAYDoqPe45Yg/H+38AjLBD0D9?=
 =?us-ascii?Q?kxrFbOikRX39Mg/TH4t/em1KkdZ+YGAwz++HfxNB3DOA+MR7N/VRSjDXiMU4?=
 =?us-ascii?Q?qrmty4klIscdLFawMDAoUHZgEnsYSR+RsaMykiKah70v+dnbqaRucMEzHvRl?=
 =?us-ascii?Q?XP8CIrWUiUJ25aE2Ziq7mluLtN42vpWBdnFbduL9KNFx5YkaDPg+dMYslvjn?=
 =?us-ascii?Q?IHYA9pkmcRf6ahQAPhNYvjFdW/xOYgXC+u9feo48CaPAhImF64ppzKnn93iU?=
 =?us-ascii?Q?LUlWKaUaMh4JmYeOdF46YRLlSsAwYN7vNUj0uz5yRNo7KcNBhoCaJeofzGrj?=
 =?us-ascii?Q?tXXBbbT3YeQaWa0K4rjHIWy7u2m8N39nSvauTHEAjrfnBmtFsedu70yATYpY?=
 =?us-ascii?Q?BD0g9Vh/H5Wh8rVp8OUxY3gcn5GsEpoLjuzphTO85AksVycHwrTV0B0jhVY5?=
 =?us-ascii?Q?ta53azWhl1xS6C6qeXsPgYsFomrKXxs=3D?=
X-Exchange-RoutingPolicyChecked: HmpcnE/LNJJqHWPivNJN/oIz7yWQmcem8REiq/e0TmG3ANZz15B8K+CfrCK35pEqlbXJGVj2CosLr9PjQHUyE2SIX91sm/5xHHRYnkFmuetRQjGlMpKyoUG0BfHQweTG38jFXr3NLy++fSqbmSoSYiuUXjbvX/eb3bueVW2sUXAyUsnGgOXuVHGyQx3o1GTgS8NGFzc8VSZ3tKaJpGEPtpSXLgM23uPI/q4fGlzpBgXxjD9yIoKduI1la/Bh0G0n3MNB5YqzEGfUblnS/Xj8iwrpoDE3N6rgTye2PbX+t1ruz9COo5ryuCQwrihVY1b7oF+I7dT8REPIT/dMbRnJaw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c661fcbd-2af0-4b7e-2cd0-08defdfacc44
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 14:04:34.5548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2b82mPX+YCeulsYaByIqYyqt5buPMZkfBuzhYVlnxiEtl521j0FCUOGd9VfGF5GwPppzz8WcVK6UFXW1eBPC6OyjRFb+h5kHbJl1FvX81A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB629882
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

On Wed, Aug 19, 2026 at 01:32:32PM +0100, Anatoly Burakov wrote:
> Small array of fixes and refactors for IXGBE IPsec implementation.
> 
> v1 -> v2:
> - Added rte_memzero_explicit calls on account of AI review
> - Added a small patch fixing wrong variable usage
> - Reworked patch 7 (was 6) to not perform SPI byteswap until register writes
> 
> Anatoly Burakov (7):
>   net/ixgbe: add key length check in IPsec
>   net/ixgbe: remove unnecessary dev pointer
>   net/ixgbe: harmonize return values in IPsec
>   net/ixgbe: get rid of unnecessary malloc in IPsec
>   net/ixgbe: use correct index variable in IPsec
>   net/ixgbe: fix missing HW write in IPsec
>   net/ixgbe: refactor IPsec code
> 
>  drivers/net/intel/ixgbe/ixgbe_ipsec.c | 355 ++++++++++++--------------
>  drivers/net/intel/ixgbe/ixgbe_ipsec.h |   1 +
>  2 files changed, 163 insertions(+), 193 deletions(-)
> 
Series applied to next-net-intel.
Thanks,
/Bruce
