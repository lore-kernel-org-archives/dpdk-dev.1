Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45865CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8C8C40289;
	Tue, 16 Jun 2026 14:32:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C803B4026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781613164; x=1813149164;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kmk5LLy3OzrWg3AYWmeknAPQb51EHu4Us8zO/HOxcaA=;
 b=YyIH6m4Q7DeH3VuJkeWCQM+SIwhe/iY6e7rF1u1fy59njBK5mq2a2Pja
 k7DEwQGcW3q4nlKdQ1d1/g6EY5DRveFmSHhUdggjUyVfm+3xbHD4KC2/i
 8SLNAJn6VIr2buU1qjxMquDBjTgV8XjAm1rgfxWKNN6HttwZLb8L9Aj0A
 A3GFL+b3/b6eJQWFFW2cY6skaFESoDFN5w3YOMP+qwEzmNqdg8gY/rXbT
 PoHvppPr/DUyUa7uPXzrxPuUb8bd2adQuH4t5FAY6bMVk/7s23Lq35m9O
 E2giaH3wzXVgtTvCH28JF0IMHWSo3j/epM7eBu/8aSz5RYHfXjVDPejYs w==;
X-CSE-ConnectionGUID: I10G3hLdQUuVzpeWXRUqSQ==
X-CSE-MsgGUID: RQjJktbmQfKKG72P1+tLBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82437988"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="82437988"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 05:32:43 -0700
X-CSE-ConnectionGUID: 9BqOGjwqTJqwGk0VGsWX1Q==
X-CSE-MsgGUID: yIuenxo4QZuInpGq1DuyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; d="scan'208";a="243396425"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 05:32:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 05:32:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 16 Jun 2026 05:32:42 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 16 Jun 2026 05:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRoz6fYTam62U79FdCNLjiLCrZr4hxOpkKGMUTp/T2LP7CAFjr4PFnYIrAuqhGF29inIAOxDTD7HgY4QS060Jz1mdg8jYRISAxC7EsKRkPua1k/T/esqGCEbJIZfpCiFndYLkSamNAY/XIux9JHK6SuovXIRjkyMBANdYngnsfjmtvO0+yFc2wNRLrO2bIL+5c9ha6gu5khB603US5QMCnLFwGsNrkIucgQ3jRO+oQWKh4yfICZJkBvwtNvPHBRxF4V68bXVBUAbAkfq47TyXpId6qbeoyHDD4An9dbWXK8vOF+4EPpBmWci6NYyuq58XIEV0cpwvqaGWoPK8YVo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyXQzvYQLPWd9QDuhxfZRShUa325xuBHerR15rKCOYY=;
 b=S0Nd3GiJ057vN6PcYU6r6/WruOXRS7GB0XXJUfDQK4GKgecuxjklzH3Mq0Z/lBELh9+h/JafANt+j9TMmppxX/3UMZbDu2NihSqyATsK3mHu+3zpM/ximjquVYhwl6zDa46IPgKoRfMLor9dUgsv3UNXfcubtl+aLQJ3qhoh2VV47v7qIfiRuON++eMWVUyL4dyUF5i2GaWkKbDOiIl8xA2oI3Tb7ZOSoGlQ/eduQlHdLs1ipVmCytz3DwW8REnkGrerVwiN3Zr1+PielTQmO+jku2D+uaV1NERocv0Xjy/LYDB1bhrlb3WXcsC0DHhqHzoZu4XPL/FNaImju0tb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:32:34 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 12:32:33 +0000
Date: Tue, 16 Jun 2026 13:32:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC 1/4] telemetry: allow commands to receive file descriptors
Message-ID: <ajFCXCZfikPJTrLH@bricha3-mobl1.ger.corp.intel.com>
References: <20260609210540.768074-1-stephen@networkplumber.org>
 <20260609210540.768074-2-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260609210540.768074-2-stephen@networkplumber.org>
X-ClientProxiedBy: DU7P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 67381988-7325-4075-aea4-08decba35717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|3023799007|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Hh4+xZXVJ8Fe6c2cdbPEj9JypoMxvutPZn+pfLe6EhukoIk+B1lIqlpKqFAQrwCjeqmW67VLD9z7FlWO2mBsjkUybto4BmwlHWcEi0GJt+L6B0zqaM29yxTe1FtE6Gnj69X5YSseXH2oq88kPT8A1et/9+DOSXyqjsIDAulPY775ZjauMoymM2PMNuauzHnklEUeCVkggeGwPRIcZR8qtOMmOZrfyb/fzBgL/wUYnkHeyk1Y7k8RnRCS0zqlE4gfs5h7ve+hQ85PXe6/C8vz1GKgI90u8FSqHMjxkSxTOrgIGiPdontv7ktdA5aln7PO1zc9Ujr/MOivxCzQzjBTZ59eGeJt2w/H/jzseTSAHat2aAGIOdHioHqnRHRRkU4wHvoQ9pEbXIEswg3B5UGyPQKNoAAOsvwCX45wVrU9x2MAa6k/3EDeejXRZBB9WmSuJVAl7YbeySegy5QaMhDzTpQpWMj7l4C2ObiW+QmVT9XtfYLNA+uORRcAu7l3oFSysM3DO4ldMghpSJYIfX0voJZTcq6M9hzxhNBI1hG1PzUhUcP8wQtQrgwfV8jlki4cnFHRhMd6iYw0za4ar24ISW/9TFsMxjMQdoG45h2J/S7WZJKSn3hn+mUtd9Y7UcqedE3KBpJsf7HnOu/Yd/EeBkonQaM6uIXDlE/9XJHeSwhJDMu7pfHjzeogs9CCRGZA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lOS/uSVDEPALVu7onxgLKYwv6HHSFkvI3h98U8E+jNIGU8VWlKSzkSn8xIn?=
 =?us-ascii?Q?xoDeGX4fYJ8dee7m8Dcg14vs3nqwCUrZ5L4polXl8m+g4xK2c++fWdLgSeLt?=
 =?us-ascii?Q?59KoEJD8TNeTO10fc7TPlrEvbVSfHIcEaHkPFhmYHlrj+huwU1PvYNAg4Cxr?=
 =?us-ascii?Q?Qeiu831OM/QBewODCJVpqqPK5kb0aJnvB5fcq/nTAlX0urbEw7n4dNqTB+xq?=
 =?us-ascii?Q?x4vm6qBO0u93OyTtu4Mhac4LaYSg85wd6+LkdzaSRc/Cb4YV6NWWzSsrDQwk?=
 =?us-ascii?Q?znj4YjqeVE5fxhdvp9NP71PU5LtKS3Ddi02NpNMJAusJP0nTMNKfgdQgk4O3?=
 =?us-ascii?Q?aoBLHe1J58dKQxNOqsJQNjGnRPAxTi80514Tary0yymJuSwq7d4mXnIIxzT4?=
 =?us-ascii?Q?hjdUpRyJPwmhkVt0tVFVAe+74CDIbckOpog+rTCtqKR9ytNSOksdzbh1ZaPu?=
 =?us-ascii?Q?HmVy1f/bsxtsEDVBE2LZe70ZWtYABAPzgnlDQrfP1vgpK3YrErhFy68Qu5md?=
 =?us-ascii?Q?1hjjGWnIC0D7QRkDkQqsKqla7+0Ylle9xcW9cpdSY9JRdnd0FsGyU78FkjHq?=
 =?us-ascii?Q?4EGh8B1K4m9LHWPPa2npDZPesuPEDyzkC7IGWYMWa7+Py2oR0F34OK11atrt?=
 =?us-ascii?Q?vARaqYqmcz6cR0Qnx+z7OORKIh/WDS/8rpTbJu+7vOsAeh4WSJD/DuRs7gKC?=
 =?us-ascii?Q?FvIDuzlEwQ5cMXFsUQ54IAyCAh4qXqQXskEjsIGWzwaVqZp48Gu2M/xyCbHU?=
 =?us-ascii?Q?mXoJAxSgHgQ2FTwmICKqncES+eSObtbnXoghES/n79HbBfXMF8SZCHcyS6gj?=
 =?us-ascii?Q?rcYhs5ALZxkPfCn1zZjMJ66fxwl90AYAkL1Jukm0L8k+g4OmcGKc4wOBbSZO?=
 =?us-ascii?Q?pnHdfYbfMoVWokQuqGVUbrWpNHFS6QuB/EKAM16abHsSUACQ5kVBonoG/NO5?=
 =?us-ascii?Q?m2esghwD70EE1FeQPzOKeQEFgo2Yrnzc2QxJh7Trafnwyz5NwCicTysjmE5t?=
 =?us-ascii?Q?8uY4RiF40vAXXNV6gcoAQan/ovt/N16wMo6ppThJ3KbRWtTzLtFI+uQ7Z93r?=
 =?us-ascii?Q?MBUSe6xDl/0x8zIB9CILqfsFkgIF1LXRjjYX8Pl/44T2aqiHM1SCCnWDw+9R?=
 =?us-ascii?Q?+PAOkaiZTns1WGo+S5C9TyhxSrwG6PLfHRUi86S12iqkPlSqJncFS+DCsBtu?=
 =?us-ascii?Q?At9kIMpebq7ZtON6gJXd3m9xY1l6TkX6+7LhVpGZh0nV2h2cE4Kz5VOisnv8?=
 =?us-ascii?Q?zlvM6KmOBlDGzg5qvKR1Tauog58pze4TWmO0Vuv5GdHlopZJEHuk067Evi6U?=
 =?us-ascii?Q?2oqlR6ZWZVdn79r0J+ctaCXSB5Xtgr3A2JehZ4GQF+cN0CDrrVZwXiUx7VVW?=
 =?us-ascii?Q?2Ewq6m7UDwEPETGu01Ja8ZJGcCqqAqfb+sMF4b6quSq9Cd/3H2Nti2BBMsob?=
 =?us-ascii?Q?wK1nqltUJlRzzBVezN7j7zuzI/99CAnu+P6vZZgW86lvS1F8cnxI0whjaQdX?=
 =?us-ascii?Q?iAyv5SVshO6axGWUFTC7VwhvMRoGb2cRwMrWyLjKBYtZMWrAqdhagH9gtwDf?=
 =?us-ascii?Q?AwcjyFCrlH0WJiCFQydSQiA9pFkEKZKSqWozEBXCjaqopHS57Uw6FnrcP65Z?=
 =?us-ascii?Q?oEoUG+N+FctN4oUHwb/SwBd6uzasPCQz7iFtmbFnv4SpZ6bLNNZOgUj0zCdV?=
 =?us-ascii?Q?XIJ2c8dCi+x3p/BN0M/OwTswhg4ycPbwcwdU5K/tPiPxXBG6yiWEAGGiDj2E?=
 =?us-ascii?Q?dlXyFLi80mqEpc+tKt/6rdH3evLmfbo=3D?=
X-Exchange-RoutingPolicyChecked: IyN8j8q+EPTXjRKJr6Zh4ryFNKtJypOzHHulZ4hGhnhz5/aXls/G+V/hwC7ISkP17DqwmzqOzuf6ILh/Ltk+GG7qYmyF+FVD2nLhexW74crFz155K3OJhOmTEA/f3hssh/510wLqk885GGvKmrS96i91+ZVnbmcbq9dnAhvvocTecY3gFTquY7GU0O7W5bEIUccfoI4UpHSxOtIAwnqxVY0ca6IL4i16fjedQfdv9vEvKODg7Fid/C52I3jc9QIGlmEogd+6r2naJZtNiDBxUHQSfvZbFdDWiWT0HQN9tNrt7Z5apUiKsU/ENfsBObzImWB8PZJBcBtgsyg8Y2GPdA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 67381988-7325-4075-aea4-08decba35717
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:32:33.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOAf6tWdW5DjtYkfQWTAbDrFxkCZ5GbcUk4J8W2mlmN9Jb26y74qWMOLBMW5VHUDQCOW+eKeDRp2vcwezUIZaZoA+Cv72BW7/PtbhnSUt+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6804
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

On Tue, Jun 09, 2026 at 02:02:02PM -0700, Stephen Hemminger wrote:
> Add rte_telemetry_register_cmd_fd_arg() to register a command whose
> callback also receives file descriptors passed by the client as
> SCM_RIGHTS ancillary data. The callback owns the descriptors and must
> close them.
> 
> This lets a client open a file itself and hand the descriptor to the
> primary process, so DPDK never opens the path. That avoids path and
> permission problems and works across container filesystem namespaces.
> 
> Existing commands and clients are unaffected. If unsolicited file
> descriptor is passed, it is closed.
> 

This scheme seems reasonable in general. My only concern is whether the
lack of potential windows support is an issue? For regular telemetry, there
was always the option of a windows implementation using regular
TCP/UDP/SCTP sockets bound to localhost. However, AFAIK there is no windows
implementation of anything that supports file descriptors or handles
between processes.

Some other pieces of feedback inline below.

/Bruce

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_07.rst |   5 ++
>  lib/telemetry/rte_telemetry.h          |  66 ++++++++++++++
>  lib/telemetry/telemetry.c              | 115 ++++++++++++++++++++++---
>  3 files changed, 174 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
> index b5285af5fe..d7a2df88c1 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -141,6 +141,11 @@ New Features
>    Added AGENTS.md file for AI review
>    and supporting scripts to review patches and documentation.
>  
> +* **Added telemetry support for passing file descriptors.**
> +
> +  Add experimental telemetry callback ``rte_telemetry_register_cmd_fd_arg()``
> +  to allow command to receive file descriptors passed by client.
> +
>  
>  Removed Items
>  -------------
> diff --git a/lib/telemetry/rte_telemetry.h b/lib/telemetry/rte_telemetry.h
> index 0a58e518f7..3e32d2902b 100644
> --- a/lib/telemetry/rte_telemetry.h
> +++ b/lib/telemetry/rte_telemetry.h
> @@ -325,6 +325,37 @@ typedef int (*telemetry_cb)(const char *cmd, const char *params,
>  typedef int (*telemetry_arg_cb)(const char *cmd, const char *params, void *arg,
>  		struct rte_tel_data *info);
>  
> +/**
> + * This telemetry callback is used when registering a telemetry command with
> + * rte_telemetry_register_cmd_fd_arg().
> + *
> + * It behaves like telemetry_arg_cb, but additionally receives any file
> + * descriptors the client passed alongside the command as SCM_RIGHTS ancillary
> + * data. The callback takes ownership of these descriptors and is responsible
> + * for closing them.
> + *
> + * @param cmd
> + *   The cmd that was requested by the client.
> + * @param params
> + *   Contains data required by the callback function.
> + * @param arg
> + *   The opaque value that was passed to rte_telemetry_register_cmd_fd_arg().
> + * @param fds
> + *   Array of file descriptors received from the client. May be NULL when
> + *   n_fds is zero.
> + * @param n_fds
> + *   Number of file descriptors in the fds array.
> + * @param info
> + *   The information to be returned to the caller.
> + *
> + * @return
> + *   Length of buffer used on success.
> + * @return
> + *   Negative integer on error.
> + */
> +typedef int (*telemetry_fd_cb)(const char *cmd, const char *params, void *arg,
> +		const int *fds, unsigned int n_fds, struct rte_tel_data *info);
> +

Do we anticipate in future having callbacks taking more than one FD? Would
it not be simpler just to a single fd parameter (which is -1 on no fd
passed).

>  /**
>   * Used when registering a command and callback function with telemetry.
>   *
> @@ -368,6 +399,41 @@ __rte_experimental
>  int
>  rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help);
>  
> +/**
> + * Register a command and a file-descriptor-aware callback with telemetry.
> + *
> + * The callback is invoked like rte_telemetry_register_cmd_arg(), but also
> + * receives any file descriptors the client passed alongside the command as
> + * SCM_RIGHTS ancillary data. This lets a client open a file (for example a
> + * capture output file) itself and hand the descriptor to the DPDK process,
> + * which never opens the path - avoiding path and permission concerns and
> + * working across container filesystem namespaces.
> + *
> + * Descriptors sent to a command registered with rte_telemetry_register_cmd()
> + * or rte_telemetry_register_cmd_arg() are rejected and the connection is
> + * closed.
> + *
> + * @param cmd
> + *   The command to register with telemetry.
> + * @param fn
> + *   Callback function to be called when the command is requested.
> + * @param arg
> + *   An opaque value that will be passed to the callback function.
> + * @param help
> + *   Help text for the command.
> + *
> + * @return
> + *   0 on success.
> + * @return
> + *   -EINVAL for invalid parameters failure.
> + * @return
> + *   -ENOMEM for mem allocation failure.
> + */
> +__rte_experimental
> +int
> +rte_telemetry_register_cmd_fd_arg(const char *cmd, telemetry_fd_cb fn, void *arg,
> +		const char *help);
> +

Do we want to make this experimental for later stabilization, or is this an
API that is best kept as internal-only? I'd tend towards keeping it
internal-only, rather than allowing apps to define callbacks which take
FDs.

>  /**
>   * @internal
>   * Free a container that has memory allocated.
> diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
> index b109d076d4..30d3ae3a13 100644
> --- a/lib/telemetry/telemetry.c
> +++ b/lib/telemetry/telemetry.c
> @@ -29,6 +29,8 @@
>  #define MAX_CMD_LEN 56
>  #define MAX_OUTPUT_LEN (1024 * 16)
>  #define MAX_CONNECTIONS 10
> +/* Maximum number of file descriptors a client may pass with one command. */
> +#define MAX_FDS 8
>  

As above, do we really need multiple FDs?

>  #ifndef RTE_EXEC_ENV_WINDOWS
>  static void *
> @@ -39,6 +41,7 @@ struct cmd_callback {
>  	char cmd[MAX_CMD_LEN];
>  	telemetry_cb fn;
>  	telemetry_arg_cb fn_arg;
> +	telemetry_fd_cb fn_fd;
>  	void *arg;
>  	char help[RTE_TEL_MAX_STRING_LEN];
>  };
> @@ -72,15 +75,15 @@ static RTE_ATOMIC(uint16_t) v2_clients;
>  #endif /* !RTE_EXEC_ENV_WINDOWS */
>  
>  static int
> -register_cmd(const char *cmd, const char *help,
> -	     telemetry_cb fn, telemetry_arg_cb fn_arg, void *arg)
> +register_cmd(const char *cmd, const char *help, telemetry_cb fn,
> +	     telemetry_arg_cb fn_arg, telemetry_fd_cb fn_fd, void *arg)
>  {
>  	struct cmd_callback *new_callbacks;
>  	const char *cmdp = cmd;
>  	int i = 0;
>  
> -	if (strlen(cmd) >= MAX_CMD_LEN || (fn == NULL && fn_arg == NULL) || cmd[0] != '/'
> -			|| strlen(help) >= RTE_TEL_MAX_STRING_LEN)
> +	if (strlen(cmd) >= MAX_CMD_LEN || (fn == NULL && fn_arg == NULL && fn_fd == NULL)
> +			|| cmd[0] != '/' || strlen(help) >= RTE_TEL_MAX_STRING_LEN)
>  		return -EINVAL;
>  
>  	while (*cmdp != '\0') {
> @@ -107,6 +110,7 @@ register_cmd(const char *cmd, const char *help,
>  	strlcpy(callbacks[i].cmd, cmd, MAX_CMD_LEN);
>  	callbacks[i].fn = fn;
>  	callbacks[i].fn_arg = fn_arg;
> +	callbacks[i].fn_fd = fn_fd;
>  	callbacks[i].arg = arg;
>  	strlcpy(callbacks[i].help, help, RTE_TEL_MAX_STRING_LEN);
>  	num_callbacks++;
> @@ -119,14 +123,22 @@ RTE_EXPORT_SYMBOL(rte_telemetry_register_cmd)
>  int
>  rte_telemetry_register_cmd(const char *cmd, telemetry_cb fn, const char *help)
>  {
> -	return register_cmd(cmd, help, fn, NULL, NULL);
> +	return register_cmd(cmd, help, fn, NULL, NULL, NULL);
>  }
>  
>  RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_arg, 24.11)
>  int
>  rte_telemetry_register_cmd_arg(const char *cmd, telemetry_arg_cb fn, void *arg, const char *help)
>  {
> -	return register_cmd(cmd, help, NULL, fn, arg);
> +	return register_cmd(cmd, help, NULL, fn, NULL, arg);
> +}
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_telemetry_register_cmd_fd_arg, 26.07)
> +int
> +rte_telemetry_register_cmd_fd_arg(const char *cmd, telemetry_fd_cb fn, void *arg,
> +		const char *help)
> +{
> +	return register_cmd(cmd, help, NULL, NULL, fn, arg);
>  }
>  
>  #ifndef RTE_EXEC_ENV_WINDOWS
> @@ -368,13 +380,70 @@ output_json(const char *cmd, const struct rte_tel_data *d, int s)
>  		TMTY_LOG_LINE(ERR, "Error writing to socket: %s", strerror(errno));
>  }
>  
> +/*
> + * Receive a command and any file descriptors the client passed alongside it
> + * as SCM_RIGHTS ancillary data. The payload length is returned (0 if the
> + * client sent an empty message or closed the connection, negative on error).
> + * Descriptors that arrive are returned in fds[]/n_fds and are owned by the
> + * caller. MSG_CTRUNC means more descriptors were sent than the control buffer
> + * could hold; *ctrunc is set so the caller can reject the command, but the
> + * descriptors that did fit are still returned so they can be closed rather
> + * than leaked.
> + */
> +static int
> +recv_with_fds(int s, char *buf, size_t buf_len, int *fds, unsigned int *n_fds,
> +	      bool *ctrunc)
> +{
> +	char cmsgbuf[CMSG_SPACE(sizeof(int) * MAX_FDS)];
> +	struct iovec iov = { .iov_base = buf, .iov_len = buf_len };
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +		.msg_control = cmsgbuf,
> +		.msg_controllen = sizeof(cmsgbuf),
> +	};
> +	struct cmsghdr *cmsg;
> +	int bytes;
> +
> +	*n_fds = 0;
> +	*ctrunc = false;
> +
> +	bytes = recvmsg(s, &msg, 0);
> +	if (bytes < 0)
> +		return bytes;
> +
> +	if (msg.msg_flags & MSG_CTRUNC)
> +		*ctrunc = true;
> +
> +	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +		if (cmsg->cmsg_level != SOL_SOCKET || cmsg->cmsg_type != SCM_RIGHTS)
> +			continue;
> +		*n_fds = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
> +		memcpy(fds, CMSG_DATA(cmsg), *n_fds * sizeof(int));
> +		break;
> +	}
> +	return bytes;
> +}
> +
>  static void
> -perform_command(const struct cmd_callback *cb, const char *cmd, const char *param, int s)
> +close_fds(const int *fds, unsigned int n_fds)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < n_fds; i++)
> +		close(fds[i]);
> +}
> +
> +static void
> +perform_command(const struct cmd_callback *cb, const char *cmd, const char *param,
> +		const int *fds, unsigned int n_fds, int s)
>  {
>  	struct rte_tel_data data = {0};
>  	int ret;
>  
> -	if (cb->fn_arg != NULL)
> +	if (cb->fn_fd != NULL)
> +		ret = cb->fn_fd(cmd, param, cb->arg, fds, n_fds, &data);
> +	else if (cb->fn_arg != NULL)
>  		ret = cb->fn_arg(cmd, param, cb->arg, &data);
>  	else
>  		ret = cb->fn(cmd, param, &data);
> @@ -412,8 +481,11 @@ client_handler(void *sock_id)
>  	}
>  
>  	/* receive data is not null terminated */
> -	int bytes = read(s, buffer, sizeof(buffer) - 1);
> -	while (bytes > 0) {
> +	int fds[MAX_FDS];
> +	unsigned int n_fds = 0;
> +	bool ctrunc = false;
> +	int bytes = recv_with_fds(s, buffer, sizeof(buffer) - 1, fds, &n_fds, &ctrunc);
> +	while (bytes > 0 || (bytes == 0 && n_fds > 0)) {
>  		buffer[bytes] = 0;
>  		const char *cmd = strtok(buffer, ",");
>  		const char *param = strtok(NULL, "\0");
> @@ -429,9 +501,28 @@ client_handler(void *sock_id)
>  				}
>  			rte_spinlock_unlock(&callback_sl);
>  		}
> -		perform_command(&cb, cmd, param, s);
>  
> -		bytes = read(s, buffer, sizeof(buffer) - 1);
> +		/*
> +		 * File descriptors go only to a command that registered to
> +		 * receive them. A command that did not, or a truncated control
> +		 * message, is a client error: close the descriptors and drop the
> +		 * connection rather than silently discarding them.
> +		 */
> +		if (n_fds > 0 && (cb.fn_fd == NULL || ctrunc)) {
> +			TMTY_LOG_LINE(ERR,
> +				"Closing connection: %u file descriptor(s) passed to '%s'%s",
> +				n_fds, cmd ? cmd : "(none)",
> +				ctrunc ? " (truncated)" : " which does not accept them");
> +			close_fds(fds, n_fds);
> +			break;
> +		}
> +
> +		/* an fd-aware callback takes ownership of the descriptors */
> +		perform_command(&cb, cmd, param, fds, n_fds, s);
> +
> +		n_fds = 0;
> +		ctrunc = false;

the receive function always resets this to false anyway, so you may be able
to omit this line (assuming compiler doesn't complain).

> +		bytes = recv_with_fds(s, buffer, sizeof(buffer) - 1, fds, &n_fds, &ctrunc);
>  	}
>  exit:
>  	close(s);
> -- 
> 2.53.0
> 
