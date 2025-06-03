Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B28C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4877240EE7;
	Tue,  3 Jun 2025 18:21:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2216740E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:21:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748967697; x=1780503697;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sSTjwMQ4d7qZdSXbADQfaIgFaD125g57DhyjEoPdpGg=;
 b=C8wYN4PwEifAVJfLlzv+v1WyklGzeX+Vh6E6NpnebUbtcHK7zt/gPdlD
 rcW4rLaY39LIYgnfb14p54a56WPcA1qocFfC6UJ0kKRULe9S65p9rgin/
 V3JoAQOzPt9eKCq/s/BgilMUHd2JPvaCOK2BtFJTnxaE6QDGiBRDemts+
 CNX521X7KrqxMJ57kueYMXeQ8jy6A1d2w4qmYGW6mnZFp138oAKLC8IMD
 9MW0H9NH7VaUMWkEixo2SjJNbttZpBgBTqkXuqu4LzXPEH5WkYFEFDM9P
 exb3coo9c4EVj0FT4m4FB8Ext5JHnLvo51yEIbeWtTYTjBHd1CD1aUhIb w==;
X-CSE-ConnectionGUID: Zaw4YKbrTwamkmsNoVSVhA==
X-CSE-MsgGUID: tLZP5QiVTCCZIaYl591d8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62070676"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="62070676"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:21:36 -0700
X-CSE-ConnectionGUID: 2i7AohmURWK8b7OU9Fbeow==
X-CSE-MsgGUID: rvpxDAe6RiKRwHV9cTg45g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149952493"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:21:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:21:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:21:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.50) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMsTQsWrdcQSDANi4z8NYbKt1qL+ARu1hxDg+NBogpSQ1m9s9elRYCIHl/3J3XGqqZZvr+vnYC1KrBaN6RgVKKJhLMS7LuIPGwx89AV6k5gk0oTPDIRnUsAKLOY5bi9G2q2QOnACPgMmmPbiB7W9FI19+K5hKqJX8mYzqgA5UrhrREhfwu8qn9Cbc09M0nwv2apJWhybvUU51U2O4RDk7tb6OT0HnvhjjEkuMEAebJIsBTLinl3/q5brzADO7y+W8U6AA6GT6zGwMcvdLFdXZrmHztALTl0gGOxAQMOl3Gop7F2Wt0TPOqt0W980VrwBCbwP5lzSzXW+FioHBo50fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZzjNn1D/KxAuArVmNj8Tjm3fFv7wJZNiNaPs9BVHVs=;
 b=F6tYAUk4a5NVdfEALZiaJVuGMgD+QpISwNQTpEVsLtVOtWQpTsfiyGG1E6kgskEMYGxgGlp5MdZlMn8lHlJKAplUnogH06oBtHZhvnM3dMqGtxZpBP0NHDzexocl5//3dv0C6b+DAdNxRP+BoJat9waGN0hR4lEzD2gYMTESpdcM4ehEEuPdtOD2uN4iSxfHUCLxQAu7pyuBwE/yEgEBTSA3Tf+4HbsCXotDpuMNnU9K1mQMQHUfOWrmJLKlBJ1DhlBZG0qj4LKCFupTa99cKyAKfmkmQkUGnHzem6rXWkqtRVH7ziqIDTTnYF9jxhpFGJbGfYjCWVWYYkgR2O+D7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:21:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:21:31 +0000
Date: Tue, 3 Jun 2025 17:21:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 14/25] net/iavf: clean up definitions
Message-ID: <aD8hBXZWvGcM_jvi@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <cb9a7f1a509f4dcbfc12819097ceeab4b9873cb2.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb9a7f1a509f4dcbfc12819097ceeab4b9873cb2.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR09CA0020.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB4830:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cfa4be-0f66-4968-eb96-08dda2bab33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xAv4OM6ObdDGvDWTaW4m8gsDAbfePQf9XShIFMxLN3v9ebvZKay218lBtPFk?=
 =?us-ascii?Q?AqkmPTl1FhAcKN+zE/LdElv1oCdg7E2TcNRnnH1F0rz8klNjeI9183KVlIP+?=
 =?us-ascii?Q?wdHdQUyWk5lCCOANa7EGTmtAQdMqjd7zXRzGoghSPwdwNL4ukJoxfIDWUiv4?=
 =?us-ascii?Q?JANhB1tcFRXfLj44mUQqNs7rfPVyyMKUj8sKkrRl4nNVTOQgJVXxGfLasbXS?=
 =?us-ascii?Q?IeumqNjkAn26p7TdCHKZIvJuoKGsBwALwr+0ufbXwgb4FB58cBMnAcGnZhmQ?=
 =?us-ascii?Q?vHh0PiKDKZ8/RAsYK6pPrDyLof9FZJy4KVKihtjPnH/6Lx6lvHj8vH5EUPbJ?=
 =?us-ascii?Q?OLzVKtl5CW9oaxVzmypkE38VRraAinrueThdIuf/BS5U54hQhCDymelobB9h?=
 =?us-ascii?Q?CYaoJvQusB6jIgRhqadKY4RfMl9IAqq8vR+FxSmjiLLuWEIoEmc6H31pjnR7?=
 =?us-ascii?Q?15oSdTfNYHCbqFhVXpLIriE/FRafz/RlO0+skna2psarCnwkASu9t9wBk0j8?=
 =?us-ascii?Q?jQTv/H29zGsF0GPux5AFk75pidSqkIhc2Q6/lnFSIcHROYwiJJo2hBhvStwb?=
 =?us-ascii?Q?DlqwBnk4u7F1vN+t2WNxhuGEvXeWZLQKgMU3PxjIMIAb4PJWC3mlwd7ZRSOq?=
 =?us-ascii?Q?c0vNAJkOWZOEqe2/Is4yPInxYN2OBltjuFFa/T7iUOnMOvLiLe4JQRKbTLke?=
 =?us-ascii?Q?jbQRkPikokFkfpTJ8If+nR1tc+0Fe5QmzxMRX0wDrhHrtxoDrHRaCTeCUYXe?=
 =?us-ascii?Q?XJiajzc/Xzbw8ngiQUIJ45LVGg/qnRyXMb84fORu88Uk7lQyLjWYnisFBo1p?=
 =?us-ascii?Q?iBgEZybuba8bvNyyYoQ09BSejIGkSVsn9zSSGdbTCADekgEm8BFHjp9YQRuy?=
 =?us-ascii?Q?SFeFLmPa9n1+9ciqSgAy4lCLLvyqNh0D6ql3zueVKzutpLSQF/FxcWyqUaJO?=
 =?us-ascii?Q?4CrKZC6WPsthXwcNCohomYDUbBagx9d8DeiCjP/ZbVZ8cFCrW6CIvn06C9uw?=
 =?us-ascii?Q?2OOryCT0lcBi9h/D7r+5GwD9OKGI+feDW6zYt19MVeYLvXMHhqadh0UnpPMO?=
 =?us-ascii?Q?minJvIJa9lqhWoWr1SoIl7Vgk5XXvgOETMry6TO2YmKSiyz8rQMIJtH7zkE8?=
 =?us-ascii?Q?WNxCM781GnS0rbiDIqAfzeZNYCRCs/dMO6ZLo0ZBycX0YFbWINHrMS83uzKH?=
 =?us-ascii?Q?SyH61wwLkq02ElfSD001FGD/XPfiDqQAyiYu4SUDMGScKiYMmg652jgceycv?=
 =?us-ascii?Q?AVXpRp4jIPiciLxalm1tB+OX21iR/US29xBmBKWdO5R9ItWqo4dC2t4N1fl+?=
 =?us-ascii?Q?uUksJMu2QPscHg1alWw9uJW7CdNFxcMprHccW+03BC+xphgsjXAd87cZgoyZ?=
 =?us-ascii?Q?j7JXEaINyQ1s/yFvQV961tXo92wt5Wh2RqiRSpceEejlox1Sxg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nAkuCQSl5G7c/f/eHdkY1tEWX9Sj2hd1qOxUjjxgyuzoGctztFFy6KwXS59Q?=
 =?us-ascii?Q?xZmegxwxTfK9ik+5aHdss2aT+l1AfXYj+/2h9APn8DOqU4WODYnXETmh6Z8E?=
 =?us-ascii?Q?RwMGEFwoMWvI17qMea/bTEKLpls/p8CKmVsANqUOxNXmwZjYlOVHWynPw9ao?=
 =?us-ascii?Q?j0jvwlHouZ84E7rLVtpl/J60kLnAXJDnwjt5iQDaGVN787/I0A9akPg+d7Xl?=
 =?us-ascii?Q?0ghSe+VPxHJ0bN7K7lgkTDkZZ+V6njdhQw9/8qw+ykttbHVUjUBOIKFcuAyE?=
 =?us-ascii?Q?Wqnkins0TU1vDuSj9h8RWLJfbVuog1JhU8NhDEoDjB/dD4iN9Y3cAI1mtmYq?=
 =?us-ascii?Q?mTnt/w7VdlWZ00zp+pFyN7hee9Du6VtvdisCCo2r27t2tLdcJ/kz/SEtGbbc?=
 =?us-ascii?Q?hIEpswFwyXtEBVlpmji8KH3+FFfswA4IXub8xq6Ng1aWN9uvDXp80eJxjw8T?=
 =?us-ascii?Q?z2srnk4zFoTTeHRKWoJhiyvWPGxvM7HDJZH69vQTklsdMl8SFx1iXq0lAYPS?=
 =?us-ascii?Q?IUhoZYLRoLZshtj1B6GQKwTXy2nZuXpKlIl8S2k13qLl8ZGbPyL/NAuTOVqu?=
 =?us-ascii?Q?R45a9sdUi/WiZTbYbZHc64hrJ1EG8gyx1+L7QARBxN5+MxePDfSrI+UR7HlS?=
 =?us-ascii?Q?Oz9KAwxydgkB/jexytWh/M7vd7Lf+ew6F5y72NxoxlNNjEOYvvC5nPhNx38k?=
 =?us-ascii?Q?Du5fPQx0ie8yzPhQx0NCc+SGETPkZ51PVtwztYRF9rLqXcZ5PHodLJar+kdP?=
 =?us-ascii?Q?31Ocq5FRGTS7M6rWgqJRdrPszDEN8/vCjthMd00T5ULXlrZEv1XZadjn07UV?=
 =?us-ascii?Q?rN4rB0bIPlLQpZ9AhpDp+Ev15DUL6AR9a4IJCsv7g7SsMtWSGRWeA3/njJXD?=
 =?us-ascii?Q?HeUTMTb5YFoScuT3GlVyPkBZb8pOw79jCivxnkxv0ZO2Jy+TQ3lN3caSxdd7?=
 =?us-ascii?Q?JecidPgVtCaDWA1/Bmha6Gp9rhXUKt6K/MQtkBJuNzmVBkNHHBk4ti6/E3Dm?=
 =?us-ascii?Q?KJ4FCrkYMWowzlQH66GDeJhvOh2edkfN8FzZ+9fdsXimoKb23FBwk8ikMJzQ?=
 =?us-ascii?Q?vzogL5iRWCFZXY2Y21fOgk7gJEPx6hMd28CGLZQ1UGbxU+zYIdxmyymUShg/?=
 =?us-ascii?Q?hr5Iu5HebIDcrah1YmOsVLClA+BfDPtErUn4fZCI6lvshY/gk6Pm7BBDGZpL?=
 =?us-ascii?Q?NvgQBwjDc3CA2Dm8ZpsmY6JVlVMs3ncYLP7dRP8ZX7zSUvV9O/upHPnfz1Cb?=
 =?us-ascii?Q?gJ48huCyKgbd/HcWYYzJ1LvNI6PlBOZvtEO8r9m5Wvyl7L6EjJYPGG3KbWgi?=
 =?us-ascii?Q?5CHGqh8YR4F+J3Kg6fT3DjBOD15Z53niKG5aSkb2YMTWVti2A3WdIkvWpSQ8?=
 =?us-ascii?Q?+MJwdX9jW1f62dh9rjc91YXM2+cDoL9fKqteFEmw+uD/kO9R2u6ejor2Pog1?=
 =?us-ascii?Q?hTFqa3RmXQlTjcDumdovDyk0rUD9EaycUlEgfm2HuyXUNfyQOCjvG2kawdvH?=
 =?us-ascii?Q?Eq1iESMzT8NFr39QbLXIFTVSJqr4SDsk/7TdngEykXTkn5N7fFVzD5dwfrff?=
 =?us-ascii?Q?BPZEWswfby22Ydyow5Tw6Lh7nueDD8M2A4j8skSWx2QaWZ2c9DIpLVVhN1xD?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cfa4be-0f66-4968-eb96-08dda2bab33b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:21:31.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqjxFQ36Z+eMsauj84TSgouNrvVL04XDvoolvN6UWOqRLTmAsuN/V/I3AKH2/1RKw/AS0Wk2F6ISBUerfDpdcZsQCjLzzf5RLccJCCvm3eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
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

On Fri, May 30, 2025 at 02:57:10PM +0100, Anatoly Burakov wrote:
> This commit does the following cleanups:
> 
> - Mark vector-PMD related definitions with a special naming convention
> - Create "descriptors per loop" for different vector implementations
>   (regular for SSE, Neon, AltiVec, wide for AVX2, AVX512)
> - Make definitions' names match naming conventions used in other drivers
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
