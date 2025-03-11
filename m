Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C7DC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 16:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACEDB40263;
	Tue, 11 Mar 2025 17:04:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C3A974014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 17:04:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741709086; x=1773245086;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=czbwL+At3nZM/44bCEwBAKOVQyvN+KR7Vwy4RK4xfow=;
 b=N3DHNsMDfS3a7rWBqmIhcBk1YgBSxS4ldjZe3pBSKYLwvbjwx25/gLyZ
 LRNz9dlviOkaKAbHlCL3CV1X88D8WKwt4Az41LhxXYsLcyrk9Z9sa3qcg
 E9KJjLn8NG+8crSeXLtmUyfLAO/MJkwA8SCCLwhjVvI589imBK3CSjGkD
 6+UI9RMIGrINOhH8OjFJq1ItASd333OT0ecBLWg/1MtKNP+Fy1Zqe9OL0
 KKG2mGJDDDkAV2XAW8L6R4n1abPxxQdCNvMUavyLQNEb9vPVR3t0HaUqt
 lfeHRsuZ38LKEwGDcn9XFHgxikjpG6AyDiY6PHNmSS+kJsm7F6KrfUXZx A==;
X-CSE-ConnectionGUID: faoTUMFKReyeMoH+twoaPA==
X-CSE-MsgGUID: PeR/7MtzTe6ZAPjdtSltWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="54140177"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="54140177"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 09:04:44 -0700
X-CSE-ConnectionGUID: +6sN2n+/QEmB9lFGKFNskA==
X-CSE-MsgGUID: TeW5jYN4Qem9ZDo+mbRAhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="151303488"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Mar 2025 09:04:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 09:04:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 09:04:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 09:04:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrNodzgnGupO4HTBdCQpE0iz6JuuFR1v4VFvinaKdgXo6qWfWcy4OE/oLCulu6NpEimDJ1b3RvSr8fcEeevPYZ2W82kwcHgBwKj2GX55tWjLe930fCkhyPaa9UWQ3rBRuZpvPw7ieLVjFmhvgfT/yIG6vkSaVIr2lQCvbZIV7/06uGWDdd2mKo4BY0yz7ns5tJyIdlBZ5p04+mXta/VRioljjSxkDswFXeNWO+SDqwoJifSP2cj4DkhgzMwLSLXlGCUd/NYkymSXFjvvv3TdmB2QZti8LmNA8v65dae/KNOrjjj8w3+p2qc40Rc81IR4Z+yrBZ9ZWwMF/dHFxA7xHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsurKKp2OHwwmlO/SM4/qobHvWwMQdUnOyEWcflgkAU=;
 b=sc3gxP4Hm4BJt0vfgDPDSWKih5/8LgW8/iZoaoyhasNkF4oW2SQSo4j0V2NkkILqRahLROKDId/XjUKiWoTOfYgdBEXf/dZ7p/E6gx/j6/UWIeEQ+yYcuCZPkaMcEDpQKkShEgTW6DxXS9de3MZEyrCA+WSGVzfgciOa54LbHXXL46EQItxhHiIX/0OY8kCQvZNLRdO4vV9HmgrgQmn02bLZhPk4/oXr33ami+Ya90N/nVL3rwABlh58Cesa7GRLmeaxKRJ723tju91LV/sjzr+CNP0UBHowR6QQaJkMbW53HfwsxnpJZRlr0dwgx8R4nlI5i8rAAXTK4Q5fncOsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB7810.namprd11.prod.outlook.com (2603:10b6:208:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 16:04:36 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:04:36 +0000
Date: Tue, 11 Mar 2025 16:04:31 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/4] more unnecessary function pointer
Message-ID: <Z9BfD7I1kjvYa_en@bricha3-mobl1.ger.corp.intel.com>
References: <20250311155300.13410-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311155300.13410-1-stephen@networkplumber.org>
X-ClientProxiedBy: DBBPR09CA0008.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: 145e7beb-52ef-4a1c-4354-08dd60b66b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z0eO9jhq5JxggnuuivKW4x2eZa0+JfBJE8fPRtebGaO8VojlpVqcrVk4Vhy0?=
 =?us-ascii?Q?Lgx+l8QmxLz0CO629t8Fqyo1RYPKtHcsgybehdAl1jnHsTwULGcXE5JBlmjy?=
 =?us-ascii?Q?UFaicgvFT9HDvVgAvcOlPjSrYh+iC4TthNzQy09iEfxVwbSiWlgJER1GGa7p?=
 =?us-ascii?Q?jFWT9PtaS/sGGQJarC3ZT7M7Evv1xkpylCcPaJOI2mMnD9yllIJyGSNTQM4z?=
 =?us-ascii?Q?9DF+jk3IiDzrBcNLmhxs+SezY5xk5di4hJNYezwG6dbNAqOnw4uLFA+TUF4s?=
 =?us-ascii?Q?xg7WTM6STZenb0dYiSBEdLnUiWSpUCY5Wtgxgq0TIna800LY/dZ2FAGbCVqt?=
 =?us-ascii?Q?bn8Q0gP2bYyQfKxn82Bm2Rxkc0Y+f3qkiIrkolmqrGOkomBqyHgftLH3a5SD?=
 =?us-ascii?Q?dIMhF3aoZRY507zDz2Jv2rgb99I8CqYuhtEmUrsOBswvXK+7hrOFSDPO+36+?=
 =?us-ascii?Q?2vr49K3llXimXaKnk9cjPoQ8kaZwrol2rBmdPqEx3DzAnRNwZql7i7O00C0G?=
 =?us-ascii?Q?0nzIz8kUDAIW0sJQHU1u8SBMyBqmPa00JgmXz6ofQmmLbVehC22jXaIbt+4Y?=
 =?us-ascii?Q?xoSsviLltp3E0/1DeYnaftjIj0WRD0COI3Eab9Eg0HEGgQLzgx6+0Z8aJnN7?=
 =?us-ascii?Q?a0CiW9W8nxxnGMc8+5X2lHTjiyRlrMrj5cT3CFvMunchFpQ0rcvsHOlvcWiK?=
 =?us-ascii?Q?8a6i9XztXxqTXYnnOm8p8EFwNxRg3XXTuYUxJeQ1SjvAwahrlLBPs2mtIXas?=
 =?us-ascii?Q?hwvxEhboVMfZOGl2hi8zxo1Z39mJxD1r03SGACcdYHZ/XdE9z9FPlLpnEM2G?=
 =?us-ascii?Q?75U8K5YIc17rVg/oVcn16PuvODtEKl23WRBCaUEVOkNoxSonWGZNo0rESPsl?=
 =?us-ascii?Q?EFr5cGRDgahT3eo0TZHZxBnHNMsmY6J+iXS30EXSVY+utNm6qAPKphVydpwa?=
 =?us-ascii?Q?UfIyLZlLxY9Gi9BEEm8aX0Bq3uQOGgYLWS+bQqSnlaB2WUWMs4B4KqOXsbD4?=
 =?us-ascii?Q?IW7tjXA1uqS+1qxb3LAlr9PNGo6euB5kbHBjfshqbpx2eVntahZgSlEYzR02?=
 =?us-ascii?Q?hmfP9BoS88ToRvD7Km/xJCKPpk7p62GMlyaBMbsqdv2goIiM4n2SGAhL/qxT?=
 =?us-ascii?Q?wNO7IzyTFF1XG10+AUvqEzxbs7G9woG5qIragYbp7WzBimPiiBcedv567HXc?=
 =?us-ascii?Q?SM8ko4jFdaQBGLGQzPVwPoQ1oKIy6nTtTrzsUDKpNWH8Tm8J++0Ejq+h8gdD?=
 =?us-ascii?Q?GzqNd3fkEZpzV99teywkvIpKNCddO1o1ps7Jq5tYrx3XCgp5MgvQknKE0Ez0?=
 =?us-ascii?Q?+EeZaO1SgzQHwkh1m8HbnogvbvH5EcNklqXTL+U5I8CgHhBTdK6gfIoCqhFi?=
 =?us-ascii?Q?Jwp++tpDLcpLubNSCzlw432I7yk7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/dm3QnNulksXxg5KawrfnK/sTyS3GZgdfKnlqWyQ+0NcCIKz0CANMT7BvmO?=
 =?us-ascii?Q?+GxIRvB2NXYQ5+qWsosJ33n0lAsNcNZYonOS8Rmd9H8C0Mppq0h5duehcUg9?=
 =?us-ascii?Q?c1+Csusgd9LYZ5dm+fDvY4MQ4wwHo4kbXZeRz8+ip6C64591/oJWdzOV5vk9?=
 =?us-ascii?Q?g6VdrP+9BP7HhCNYfYujGf5vqJBrrglHrcbsiDygpLpnT/j3oO+a37UwKpNi?=
 =?us-ascii?Q?kgrNNThcg0N6cWdN9O+04TSrXyIfCPSGTo9U/l8mR8ufdPoj1dyfgnIB1kTZ?=
 =?us-ascii?Q?Dto/+SLB68iLx6lXtL+/kljiRMDWqT5X4tx+vcUnHghxPZC98UemAxNmC3qr?=
 =?us-ascii?Q?CBtl+n4SuDgPmqtIZfsllrNgng/MyTtBt+skMPOAt7rHZVPDiJK9lcdCeBp8?=
 =?us-ascii?Q?SpMnvM4NK+VapoM6Cg9VGWMac2NMqphKc8qFtJCOLUJzUhhiJ/j9dYgmraDt?=
 =?us-ascii?Q?P7LKMybdfC1lctgcmaygHQGGGJeLmhIWH0cXAlCT7STKNAoszeSTJr2x9Lj4?=
 =?us-ascii?Q?y6z/KhuZE/Ngqm0hog5vznkqz/0dogj7vf9EFOuNjdgZKkG5R2AteK3Q3Ezg?=
 =?us-ascii?Q?+8BeNjqC9k1LoaqouuVoLIondUpLeVqSs6pFQ+uwQHZBFWJV4wdJtTIKMLq6?=
 =?us-ascii?Q?mV/BbZYfXC5iUoUXMTkLl9gz9n33Aa/X5QAQQN0ZBt85VK2XtZ08SpV/MV93?=
 =?us-ascii?Q?Mi3efCXukxrrdvTfiKRGwnx9/lou3xNQlzZMR2bGBRE1jvWTysewQ698ld1y?=
 =?us-ascii?Q?Hw29nQSVQ4uc/5Y9m47bVlfMnZngbixSsCfhkorXNF5kcG2JX3kCoBSErDMR?=
 =?us-ascii?Q?kxobZe4fbJnqiHS0ClcwRPEHYh8WQq3jLAwxCl94UQcBDUF1CkOVVwGF7Hog?=
 =?us-ascii?Q?toSE5AOqf10C7uzvwKO/3ZonqdSSL6pkDKCayCUIe7SwrCqUUT10f1exrfxi?=
 =?us-ascii?Q?v0X87w8OlwgZkstJVG5Od8ZGoZA/NoPim6+lnkBF6azMyIVCuzmrGIQpycaD?=
 =?us-ascii?Q?EWlHDpHVkU5CaW0dR7rhxP+R4Elov2TH/ehqBFwBNDFBCKmY4yhuGD7vbzmw?=
 =?us-ascii?Q?3fkXFYPlnoPQISVqShOYF9kklDLO3VTGAxYdhKwMwpQtp11POqJlFTPSdC0F?=
 =?us-ascii?Q?uSLUotQiMNzd6KppBpg7oph06eDjjQ6u3j4tJUBeQgeLF/rmCifumZBFI/h4?=
 =?us-ascii?Q?2xhKrOmFqfdWKHK63hl6dc13CsZfXEVzQb8RQ8qIxfS+SasVKFmOkqD5ZSh3?=
 =?us-ascii?Q?AUK/vJImTDeFJ/wHFFu9lmogZ9TlQTwJi2NYnuQy0xrbhxhJir2jO+npPNoP?=
 =?us-ascii?Q?DI3NElRZq4xZNOOz4kZNU7YdZXQyArNNfsa/cU/qs4pa1Jv1HfVgu564QpLN?=
 =?us-ascii?Q?C1J9AyX4yI4ILFZcViTxzz+/7kTe93QRzuy7QGspUo2ERj5KVl72iAYKQh7Z?=
 =?us-ascii?Q?aE+2Fkpw8SL7+gNyqQd/ffYuf09QMwfVb3QtvTsLrqWikYhlIUvXctINv6x1?=
 =?us-ascii?Q?NpKs/ra4v1hrN6P7cU6ala4FR1WTqU49mfyLYMOireMkZeQhRiTPC5cJ7Y4n?=
 =?us-ascii?Q?wjGxy1tOSASIVQ9hnuJwz3wmgWZzaAYgSIhXvlRHzh4RSLTzt0sBMvVC45Bl?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 145e7beb-52ef-4a1c-4354-08dd60b66b9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:04:36.3415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JL/fHpKwhd/A18sME9febQOiHjmtPN0WPjDJsXFRU53GCVLEfVPT31KyMK2rM5aOHt6kowZ9OpePrThjRc9iTxPyyp4rDTvvMX3TnFKtv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7810
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

On Tue, Mar 11, 2025 at 08:51:28AM -0700, Stephen Hemminger wrote:
> A few more cases where there is unnecessary deref (*) on
> function pointers.
> 
> Stephen Hemminger (4):
>   raw/ifpga: remove unnecessary deref of function pointers
>   crypto/ionic: remove unnecessary deref of function pointer
>   regexdev: another unnecessary deref of function pointers
>   vhost: remove unnecessary deref of function pointers
> 
>  drivers/crypto/ionic/ionic_crypto.h |  2 +-
>  drivers/raw/ifpga/afu_pmd_core.c    | 16 ++++++++--------
>  lib/regexdev/rte_regexdev.h         |  8 ++++----
>  lib/vhost/vhost_user.c              |  4 ++--
>  4 files changed, 15 insertions(+), 15 deletions(-)
>
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>
 
