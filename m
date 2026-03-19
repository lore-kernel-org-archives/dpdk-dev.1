Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B37D108E1FD
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 12:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADD6C402C4;
	Thu, 19 Mar 2026 13:04:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 96BD04025D
 for <dev@dpdk.org>; Thu, 19 Mar 2026 13:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773921855; x=1805457855;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=YKJvKTMFQ0P1bnLHknZZv358k4p9P5/ks00bGw3xrCM=;
 b=CYz5FHc4l6hc38i7AmwA5zFFz98rErXH9/hN/Ac4n9fDDxdcPy1UW1sQ
 2fo+qnsl4kDWM6yov3V4R3Y0c+WaJBiSyKv+1QWwha0Sxr4XJxU1SamSJ
 2ccD0bJ1F3OuodbFvmLJIYP0aWuGteu42hQRJOeGJyeciH7Fu1HdmOpJr
 Uq3SwexAyzBUywEyGnjYMevK8NRfyTU3BHE+oau2DiPwwoXB5NnNvhfAv
 S8dmFRCnzq9RJ84CovQfz3HBT+kE3Cml4hx+JKOYgkl08VX65DaQzRhiV
 GZyY21tBLvdYs2NJVSmGUbcHzDbJKqlPgPevXpkxGN2WtwGrJZX/IFBu5 g==;
X-CSE-ConnectionGUID: Iw/0RV7USHykSVEyPffUNA==
X-CSE-MsgGUID: mCPfnM+lS9aQDH51y6W0cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="86067464"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="86067464"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 05:04:14 -0700
X-CSE-ConnectionGUID: ASIqnXHcQAe9Ttu7vCgr+w==
X-CSE-MsgGUID: kGjRmzvmR/W/dySD695gDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="218856308"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 05:04:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:04:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 05:04:12 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 05:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOvu6MIUaTfXfwcryU2oueKxSCuPgbu4p6sw9ES3FzoqbDex8G0ipA3YU9ICx6PwtKRangEVkSOOKnj2dua8ah1rnsIT2qv3LC+o2o5sIlFBQKTaxTZ+neUCMt9gZtBVbMQpi0DL4E95yyrMw09M1+YoiQTJjFzyEtw/z9J5LBCA9YdXt9ZAs3abLNoVZgHVzEEsKKsSXoME78Ogqu9oJT0G3w++j7EWwczGzBV1FvqCXRZw6UFn6rh0zjfdhlZ+BITmtd1QWhrw26udY7NO704D1u02s9+yac5qDdVAUokoD333jlYDCeSVn20trFKoZpO11gLZ1M4Die0hMR4msQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpXA23EcROG1K5086dErTspUaiUuumLqEKSy71gtFOg=;
 b=DOmOxaRUhBmj51fkJDonSkOsLja01sUpBZYX6HYeinjxVxlH8iJeMb7hOIFaSW6TDwK7aRW9rSEchmPhHPdx1q5eGqFwmBRBR4tp985mOMrapMc62pZr1sjzxqr8ScJn5A3R/ikqDdmGCOpKwdeskS0JlXgWcYwfKJAA8BDx6Q4rYJi7lcepFUBcQlhWltDsf7fIkDMZWrcF9ncWyWbclEy1KXqyT2/hpftGzMIg7LVsht+bJnwIeIDQC7iTcBqWOLz/MkTV1MBaZHj8usGGy+ucJr9L9Ij0uUuocBhEMpv1ehMVpmquDOwm02XHPgOkIi+ixofVT44aJddOO/9hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 12:04:03 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::97aa:4b89:4558:19e1%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 12:04:03 +0000
Date: Thu, 19 Mar 2026 12:03:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] doc: remove obsolete mempool creation advice
Message-ID: <abvmHkNQ8s_i38pB@bricha3-mobl1.ger.corp.intel.com>
References: <20260319091300.652853-1-mb@smartsharesystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319091300.652853-1-mb@smartsharesystems.com>
X-ClientProxiedBy: DU7P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|DM4PR11MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: fae6a478-f515-4602-e633-08de85af950e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ki8BuSW4JO5zboiEeJFnacw5l+iAZ0bT+CwOxKRjiutGJzPZUtFoDWoDi9STYVn8jierpuvxJgdLuh86GPO0hyyPONUc+VqdSj8yPTU/jehb1Qhihb/zmtTrhmwIxYxHC6n8LNgclPHmg2HIwQ11bV/Bk4Ae66s76wG7/0+fnzU16PdYeFjX7ScSio4/CgWr/Y7nn3BDl5E/X3Na0K6i40YFrX24a6gAITGrOPs2LGigGrxfCsXMgWxMmO/l1kmzviCKyThnf4ai6Ee4QCzT8us56wY0d1f5E3v/22OW1T4Rle1YCTPcakBhGzgCHX/4o7H2TRn/EwqVYbDljWFMofmt2larZg6d2BQfYfEdxD2e39leTTTmDfGsILUR6s3lu/MQ+GQbIusfBmZ7K6VAxSl74IYiJOrUzl6fykAbXMzDN4KevaWds7ArVs/sfed0xCkdEj5K6aT3G++vH36ZEWduwBsbh0aikCZbHm8Ej7SKVL77rOAeC9cSJdmw4cc00OmwquTYwjDiViYx3mwwf6yyDpFpprQRnGDb5efAvyAZWNDWYnmmJcbQO+e8SXjVH1lRufB8ZB3XCQ2MKs8WVMGFep/i8Il9+bsUMettMlJzJz6AKwQxTbAbBdAHttfatmm06HZCsdi0bR/Eiey3aBJB+V/ArAQHgjBwYQEfHJK918dQSL4RsCUU2g3htHQUO0RoJQIgpygoe6ipkvAoKUvke5L5W1ru/f1YJb91sxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?IBq8AxlI2qX+gfqAu+ecj0zEGclIj9c0R96MzsS+iBL9fzoZ/5cSvBNAG5?=
 =?iso-8859-1?Q?VUgfWy711oI8W5+AXpC7n71Tk3TjcqGZ0nIE6LlSlWcKujlmX5rFqBDefe?=
 =?iso-8859-1?Q?GGc9bdkr7lajO4J//sR5KBMuDkxrK/sZcOpQzq9vjkG52mQ7b/jLGCrz8O?=
 =?iso-8859-1?Q?dvePxuzJG5pzRqIEwPgdMPAGru8BPjt4Lpbp6ykMuZqwGYYWBrgJP1ZEuV?=
 =?iso-8859-1?Q?y12XGhO5FMiiuKsys/ouNwa+WHFvpywCeI/Ssg8f0QoSkg4hZ9QJtS3mCL?=
 =?iso-8859-1?Q?dmLp/GAxD+tZrUWmtFDoug+YUrMJkhyCUSqBmcZXgnwGtTvy4CNqn71MFR?=
 =?iso-8859-1?Q?J0vXzg/mk8P2FW/j+4w7lbDZAZSTqENCACX7xkqyc+RtIl7MWh98iLLmvZ?=
 =?iso-8859-1?Q?xgDs0rDDkYToH4A0CFMSzWUj5XV4TY1Ahn91JzCZyy+rxlC4yUi8cu3IX0?=
 =?iso-8859-1?Q?v6AamqX/UBOkYLSvRpGowGExHgznry10XhQdnCbSr7rxaE104tmFPRKdGm?=
 =?iso-8859-1?Q?NLYNvGco5d/D0zgK6020OpX3tZuta05UdSqTcbWSr/bT34eA0Et9zOILKA?=
 =?iso-8859-1?Q?aJEcwH04IPt6rcyhPJpQpDA+TX9m3xUQRguOkPi31AAGC0cgGgmDMIsGZm?=
 =?iso-8859-1?Q?l7o+k4lEYsJ+ES3obzv1A1NMtVroZZeiGDuQQ4D5owCwSNzFj1FwVgfrtg?=
 =?iso-8859-1?Q?6EAL8JtLiMi2AV2HOAqlD6dnUGlZaXTabu1B3mZ9TFkzaEtuI0vtrEmcff?=
 =?iso-8859-1?Q?vjzjYuak2Ms0Zmv60xQYDjAvkhMowiK7RoKF6GIC2rsUeO8lo2WdDP3Rn5?=
 =?iso-8859-1?Q?/jx2fqHLyBMJQDMFl1Xi/zNHsvJOIM5XiVGhkFnUuKICyx91EwwxVY61yP?=
 =?iso-8859-1?Q?9qblaNHMY0+aIVmu7Zk6U3UyPhZob9OKG/UV0eZ+AbARU0yc0855frJ1sS?=
 =?iso-8859-1?Q?HtmqByyX1WDJQ9dDxWGS4sutlx3U8dmwN5pW1N2s5rYcgy2sDPgRh0troa?=
 =?iso-8859-1?Q?K3kqXGVR43xLs9zJGoFWlxkQ/GMMxDNF+t71KYSI8rholwYBtjusxzA943?=
 =?iso-8859-1?Q?77T8a0j6j/k9BbXmnj3E4VZsZavxqV/Rx2yGfvfpzlKN4yxcmR4QHQZ/1i?=
 =?iso-8859-1?Q?v3cX8BQlPR6EtKLrX26xMQ7i18eCyCgLdZEY7tyE2OzP590TvveGr4qSJ8?=
 =?iso-8859-1?Q?YMA+upH5t3f67AbUIJT1diAYIRioypeJNm6tNRs0BGo8mD44Gwi91woIa2?=
 =?iso-8859-1?Q?mF52F0W8WnKo6K93GEbK2zX3ujhUTR8cx0PVi8fR6mkD4l7HpZjdtEWN9H?=
 =?iso-8859-1?Q?HB6e2/nt8cSICvpJ+fH52kTL9hYWVw6dnZc9EtDZa+Ka2/ToDhF2wEwHGd?=
 =?iso-8859-1?Q?qX8lTH+XwVveaxTxkPV/A2a2UVZxIBYylJTplU6eGtcY9Gw6kORi8VGK9A?=
 =?iso-8859-1?Q?jzzKdv/+et6Cxb5Zr0rRIh6MkBVdwgXGDmepeHiywi8kkSZCvqvYNQIRhx?=
 =?iso-8859-1?Q?mu4RIrCWQJiPRtWKUWNxrkNpjbW5MUrnAjRa69+dEjjDis8pMYl4xaN2H+?=
 =?iso-8859-1?Q?YxfuVCSPiFAobn0kZYKbhpE72vA7CqDMzmmO3VFYzzW12mNUNM71CeLT5Z?=
 =?iso-8859-1?Q?pGkYYDo3hFWZs3nMhV28YKViOT8ArsPSwekbgqydRa+bEGxVr69tx8KNq+?=
 =?iso-8859-1?Q?ElxS68uhX4CQxJXxhHLWVR/MY+aG2sbrQIr5ZPgRLqDqcAy4oxSTlT4pfZ?=
 =?iso-8859-1?Q?tHOf3WH6cxgMEi4ut7rCvr1/bYANeijLz72kU3o8zQh8TK10ReXo8kFOM2?=
 =?iso-8859-1?Q?bToi0/vIbPZu39eZ2fD3AoD07oPcHrQ=3D?=
X-Exchange-RoutingPolicyChecked: U2Btg+Y+nfLj1GDLy1RPFB0rRvHTl26HbI3CbqpvNemljzJaGGtWIu5nWN1khLqjlpKeUDh6GplL/CB/upnYhVLDf5qmBJqPbrjRP0eePMitpl6myCBg8W22LpSGcZ+HVfKdUaZqab/Cj0rAR9OKJXxah0NozE6rE37ffSuyFumEWVY1dIDDzGXyESIVjXJY2turJrIY0QnOEe6tk6JP5OTHfF00hngEiKDeWdaIgU9si4RE1j3b9W6zcdo42b1G2PF9PEd4abnh+3m5Uyjs1PGK4TK4Ss26Z8LpkMKrhcu38ZDlizQfHkxEmI1KNE+9VjtgEoBf57VLP9kwRg9xyw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fae6a478-f515-4602-e633-08de85af950e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:04:03.4931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VofgSGeCqs06b5Mo/ezCqKWa6vVfypmku3uerqsg7oCztNTDUmlbmGgX/ZzG4V4mWR7SOfikk9bBs37n9ncyEOzE8EF1Bxlqg66MpjOJdWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
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

On Thu, Mar 19, 2026 at 09:13:00AM +0000, Morten Brørup wrote:
> The descriptions for the mempool creation functions contained advice for
> choosing the optimum (in terms of memory usage) number of elements and
> cache size.
> The advice was based on implementation details, which was changed long
> ago, making the advice completely irrelevant.
> 
> This obsolete advice was removed.
> 
> Also fixed a copy-paste bug in the rte_mempool_calc_obj_size() function
> description.
> 
> Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
