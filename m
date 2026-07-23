Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A99FC531CB
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 08:45:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 151464028A;
	Thu, 23 Jul 2026 10:45:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 970074027C
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784796337; x=1816332337;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=DXrOrgfr8PRkymaDRAG1W0bpc6kCZXVyZzKIbbYtTfc=;
 b=WuXvhVMJWEb/WfhJDkOQ3WPXavkgRR0P78mqf84pmmi5pz9MUG9k4vnA
 ISqIBOL8376v3vUXtKdyFhVGy/lX4Imgw+eUEHspljCJiD2JVf8ZJ7D1d
 YWVbIcB4mKsCC7ZWBvrfpk/OxB9IOrj3+xJ9ZL4eSsVNEM7Si6r8hZ9J9
 35PS73V+Yr7g6mo64h2jK1SX0YvmIC9qvawC4fYYLROP5M4V+eO68c/hc
 yP/hOKngOV22WJYlSllKE2Ykxt1lDrSeLdZ69oyalfiVLoKHgU5sUtD9l
 U8nn7Rl31iU1+mdIGgFXP+FJWCWRIb+Zsu8JRLm8hLiRWkayZEoS1JllR g==;
X-CSE-ConnectionGUID: sMhSNrExTsCsOHgK0iZfJA==
X-CSE-MsgGUID: gb6O6LtRQsKCfOub/clbpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85390983"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85390983"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 01:45:36 -0700
X-CSE-ConnectionGUID: /ORJC7Z2RyyCBitimaCAFQ==
X-CSE-MsgGUID: j7ZI6ihPQfKrA/LVWoWroQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="260315743"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 01:45:35 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 01:45:34 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 01:45:34 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 01:45:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnGGbTWlGMsh052zW1kiNwEp6jDFAEcGYrtTd8ZlWpS8Hw4oQON92Kva6/7PEck8wQflr154BEJxv9S0tzNL4tVIAOxbdB0CrI8Fi2NbnWgg8ozHK3GITmPpAl+SuytYYwACSl+5LrTSJr7txxR9kDWX2uX6L93AnT8NTUH7+B0cXaJdGy9jXYzoPQjsaRL+I8KInGX6ydTTAeM+zXuPZqPP0nAhc0OAIxar4+Wu4WXYBH+K0HqYF2yJWn+t+Ud1EG5SQ7NY8ijBJwZm/JkUBJAXcge6FjM4U4Kmwg5DwktQ2GmmuNcbDaNTNOg9W2/BeEyC98ClYbdYdx8H++yXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7kRSKmNEQ57uTOrNF0w/Zjt51XjaD0INIS9etMhx/Y=;
 b=ekDc0qwrEsCKm1Cq1Q9RGYUUNKWXGES6iziUuE0H2YQ3dd91YOWSNcRa/oYTDWeFkXmBXKDLQB0jIOPP9tIPbSH8sg0kvfaYFQGeo5H6p98rc1elp39JArGY9U4je+B6lpNp31nB+zunH9zVENpm3cVntxdr18Wrg59p4+1PmDuCMxDGrZKWtmVD2VDA8Ef2Lv6oBe6Q3qn8Q90HFcu3wkgrbIxQRQfUWX4gg14Yoeu7RWgmRmcYtn06pIdDW5M33t7O0VmNRTYONThJeU8WFAMyuIRphXYQ0bqrHePyZ3yfbDCdcIGMk3EU4YXgDKX3H0Tk+7q2JyVUkKX7fvv7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DM3PPFFCD58DF03.namprd11.prod.outlook.com (2603:10b6:f:fc00::f63)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 08:45:25 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 08:45:25 +0000
Date: Thu, 23 Jul 2026 09:45:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Aaron Conole
 <aconole@redhat.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v2] version: 26.11.0-rc0
Message-ID: <amHUoLNaaNfm_Na_@bricha3-mobl1.ger.corp.intel.com>
References: <20260723062416.1340761-1-david.marchand@redhat.com>
 <20260723081206.2105269-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723081206.2105269-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0049.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::8) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DM3PPFFCD58DF03:EE_
X-MS-Office365-Filtering-Correlation-Id: e62217cf-c7c7-49dd-92dd-08dee896bd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AIe9fmq9GR2g0W8vG3od2UrA95R2i7Gpw9PZdxywwt6tHaN8p5He5XfD5uz6s0UWbkYaZBichj5IZiq6QGAcTZBc+6s2eudbW5uSd7P+KfqPrAVuvSp04JNqT6RGO4qF66aiUPg3JHmaCK5RdlaaorRvmzAqYzTeaFr0Lpu7v5cBcsWoNYwtA0qFBOv80AYzKbiJypgcvp9IAMhKzkD4S/Sf3sv6tqQL0yc+iV/k+2Js7Fa+vvZjLgG3yyCbZWS6BUPv5mGOZA9Wy4HCEgrbGCbWQ3KoyANxEzST8eYgQSQvCxSFchFqIz+fQ8nzqpQUcfmqh5R8zlQZWUKzGKc6NXvBXXTQmk3Sk+Is6311sFlNO29eoJUpenCZESFxZ1hoF0PlPVnLr8Xp+7ye7hmdAkxMHRfUlbAVey/+AXyIvnpLR1z1pCPgkKE6E5LnHmaeF+RR1lMcvrbgymc1cjFMN936fUiEansqNDHtIbiUgL/RqP6g5E+TIm+OqE1cwe0Awp+ItnnCiLAyC1L37+jR1N7WnpDLwqns2WIWU+4SSz6eNhGjAK51JwuqRVZz+7x93sOKR0vJBfki6+vdX0XZ7/FQgUafqENnbfBzzblM37B7o05t+itsTi7naSZdWz+n/JTydtJ/mLVn3MH2qlFNknrdfero9lqaTgSNA8Vt6i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0qOT+qABPNGYaYCet17GdDKAq8QioPjioGbURr710zcyYLWz8EzWKZUF6XCW?=
 =?us-ascii?Q?V6+R/nXL9TEvUcFM13I9+uUJ/OOb+c4g1fhxUV6C/wW9O5fTFOay0Vtwg7J2?=
 =?us-ascii?Q?ltAWwOT/6yu5Epz6Pz/ZwldDTVxfQy2eHzxpno8gHHbjJSYAhcMhwRjNTLAH?=
 =?us-ascii?Q?RmYXlis6Hz+FGYmccQNKmr2Tpr4pYHNhCDvaqrrxbMQkGIJ9qp1lG/H1yfui?=
 =?us-ascii?Q?7LOX2TpTY660bdf0qMMoCpXgKE8Gqc+5hEeuJvGJcsCki3bG/Zjw9uXPtKFA?=
 =?us-ascii?Q?mAgY3RI52MfEUmJd1OKV5tSeJkZCQuopG28aJ1CdxMrI11HVpChf4fhlxQgh?=
 =?us-ascii?Q?eCKMFtpL9QzXRJhN0V/Z5EJsubQf8jzHXh8dm/HI5vuO6rOV33M6xWwPRXKC?=
 =?us-ascii?Q?Zdp4eschdV3PxtdlCzQJSl2eSN1Oao+8+x5nUrT6nwqqAmis4e9xy8mOTc4D?=
 =?us-ascii?Q?BzECjp0SP0uUfdH6jKXO7UyuBCatuKxwgIyUoaGekfc2SXsTN8nh98DdLN9f?=
 =?us-ascii?Q?Mhaamzmjjg2xBEODvufHSs3RYhy3S8Rs0X7NUWAe7uea0YOFQh/HUE577NsQ?=
 =?us-ascii?Q?q94Iz+/q/H3Aku8lk+sjKmydo+UeAEqjyZyCWbYNNB+AKuYHrIK3r6f6YC+f?=
 =?us-ascii?Q?rR4cP8fTRs3vkF3AyPGrFI40OVR6/B1aLEOy/EwsQE9xReno+KhIU824HMcu?=
 =?us-ascii?Q?dtygF93322UbNtwlqm+g1rCIb4wqTvx7DrAB8HoaNMbOBXD8FyshUjmG9Kau?=
 =?us-ascii?Q?w0HxWD7XEGCXHeorbegnAWI9MV5BPQu1cJN64TxjnH6R4qGDaOcdISZpTCTa?=
 =?us-ascii?Q?YoGOZ/X9YtxyZFr5UsRrQZvBnQ1G0ybpVXHzEjljgSOqxXoHH6cFgRfPkDlk?=
 =?us-ascii?Q?SSCsxFYLMxWgDmqsl40IlN8DPIJRoRACXTCihOT/HzM28p/2iTb5IdKT2kd+?=
 =?us-ascii?Q?cipzhu0nCui9wrni8nevIMv48Mj3dtzmD3zUTEnKqzE8sdWTqYtaxkA/QZEQ?=
 =?us-ascii?Q?TtvqaXD76zDH9mMpMXPGd8iqBd0yh0raia6X4eCVb/lz8izDM+eAA7c7JYw8?=
 =?us-ascii?Q?IJpV6zyVvFPT69hhZ/plEVi7aHs9TvRDtKNKnFNc06ILQ69kHW4/lhEzfFQy?=
 =?us-ascii?Q?H01tx+fOwln9KvlMdDS+pJ7ZkYT4Hax9tJ/67mQXYrWOmUgQHL70PUZE1T2z?=
 =?us-ascii?Q?epa1LNWtl+6IZabrUgpzurlfCzWNAGWMEg7n81U0eiybVm1nlggNy+T65qlM?=
 =?us-ascii?Q?aTu2rUHKvD0awXjxg6iEyrhdcumFR1c0AW7QH8XKPCaQ29qKEU7HyxMypF8z?=
 =?us-ascii?Q?4g2RDG1kjnfBwtuQSIrdFcsikSzY5k7wGeNYxkE3Ri80wWNpa8ePY5Sgey71?=
 =?us-ascii?Q?dQjBMFSeI+H8MAXTYagXOQfU0eypfvJSk4kwkKanFlnxwgxVqidH6T7c5eCf?=
 =?us-ascii?Q?JMA+qVOjGs3lLr605onMpgiXIOwh7cxZ0t7SFQexGzIV5MjPYbMY9VCD/Grv?=
 =?us-ascii?Q?ZHvveQYRmsiBzrfabbchj7taaVf8et3FwUI69BbVK19NWG1uGhbFRAI/R0xT?=
 =?us-ascii?Q?U3c81v/0mKR9VsncxWwYVqvmmW+SK58/vy1slt27/TjOsrGLsQzwczsju4Pg?=
 =?us-ascii?Q?7G3UD8VJZzuTm1x556rk6MYz4qBQgQjp8BQtSpze+UhrV0O4SGCzP8jAEz75?=
 =?us-ascii?Q?8JqAlVvMKOPGkGwgeCYtiXfW776r7F098PqLARtwpzozIV3bXQ9HctXWz/93?=
 =?us-ascii?Q?vIEdIRk811EFWj+6iQSkAugwPo+hWoY=3D?=
X-Exchange-RoutingPolicyChecked: oTXBBOPvhVjB5LTViJXoMcGqB750cZvz9PjhQu4JpEc/GePsW5WrAnKwXOriYjBlOB2SzRsmNzRnbrgTvL6t5f8VmgJ5LPyJYrtJ0/Sf7dSws6NeS2CLt9LtWDgURtfSAPvx6b21ZE3to8D45h5K6EfT7eoWeaSjp8yNX0lCEXjWlKfubetsoxFRplHlUyrhS5Lz7IUTmf3jZinzh1lBdDStUG7FMwODR5z6d/ltz15mZbOSbPqpwyARkrxSPOIdTe9kVcZrOtXybD1wRlLcYVFniExBTTGVGAtAmAQyEsO7BiArdsvPYvw66P+c3Z5hVEIW0ntASalAyPxxZuD15A==
X-MS-Exchange-CrossTenant-Network-Message-Id: e62217cf-c7c7-49dd-92dd-08dee896bd47
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 08:45:25.5073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vw8EOxdt/jhmgItmzNC1sh8mhS+yVaUF504bDJBobPLDoLOrJ5VARebD+29kJm+smhCKCLbCcOl/wgZM6rretfV340aLkNqvlYeNRaQTHek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFFCD58DF03
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

On Thu, Jul 23, 2026 at 10:12:05AM +0200, David Marchand wrote:
> Start a new release cycle with empty release notes.
> 
> The ABI version becomes 27.0.
> The ABI exceptions are dropped and CI ABI checks are disabled because
> compatibility is not preserved.
> 
> Note: we need to bump the version for symbol compat in ethdev and net/mlx5
> temporarily. Next commits will drop this compat entirely.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Thomas Monjalon <thomas@monjalon.net>
> ---
> Changes since v1:
> - bumped symbol exports for ethdev and net/mlx5,
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
