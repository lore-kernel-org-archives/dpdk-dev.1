Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB69C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C4CB402F2;
	Tue,  6 May 2025 15:38:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A2233402AB
 for <dev@dpdk.org>; Tue,  6 May 2025 15:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746538734; x=1778074734;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UaCkXDoL4nM24ry8sqK49YZl6wX0zBZDcmZORp5gw2w=;
 b=XuNqLuvjefaBLgJeTtHwuLNScyXZjIcUg6arakA+UQTNexZu9pWaEnEK
 xHuQsCV5wdXf+dJeYheiCV0Z1ZCgT200xGkBRMpnfoQ3PjL38U473y67j
 vyI7tLfajFx+avlpR0/wjETOvd6Xidr7a7wuGC4j2bSOy6OQxNsnrJ0tJ
 83XqJaSOyajVC14+5cUXQZ9/tZYcNDCPhGkzlpnmnrTjZ36aX2cgasnzB
 wykz9iq3Op//N9+4YRYOyLN/B1E6ReYx2KIV//BACJnvEMmNzbjfhUQ9S
 urgHnHi8A6eGhLo53iErkiXucZEBJVwGQUzSAzkKF9+lUZOUK3XQO9qL0 w==;
X-CSE-ConnectionGUID: HqyntlPrRvWRjJPm7tUVYw==
X-CSE-MsgGUID: 4B/kHL93S8+WXg/8QUYiEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="73605247"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="73605247"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:38:53 -0700
X-CSE-ConnectionGUID: /2yfod2ZST+kcxYYsgAvQQ==
X-CSE-MsgGUID: Hs8PnqssRb6zopJCvO8IcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="135524889"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:38:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 06:38:52 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 06:38:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 06:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZUxcs8uEgr54IW8D2KtYLtisJmYdNiHhWDV8bYmHqRELwrWPXVPCYJ4EJr8vxC95PSJ/7rAPOs/Db7xm1cxsWgr64WLBowQ9vP5MWAvP7L4Vk+2Y/XVjzBfk5ElKZdiDpDoy8ga0OwrCA6B7lsqlRWlkrFK4fv/ozJPDKT5q1evhwnUZ5X+jom5IKvA1oqskI3kByu2kM1kBmTfqMwgMJMd7CX20+9Fnt4ldREwAOgWj5xZKYzuxpdVMZcesoFRikJ9JOIK/dPNF/S7Z9PT2fZrkv6+GH3Q99RMFBeupQ5NS+vRi5kK2dpizGHST68xbTo5nYwB7EzHDkSXOM02jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiFiVEHNAuRZs+va+XjqxP0ArBSUmLa85oXcy50QDe8=;
 b=ZIRKL8RmhKkeS+wCF1eIMFW53Zx9n9OIhI0qlBfkla6ICnDJEhP+0+ep6/cb5P5Y6JpkOh/mhrW0EkHslp9nRkBmJlaTPsBCWWSGXYUca7h2/1BtY6B4cGzWWEK6XAnUFi2qZA3Gxgvvb3wSu122sDTOXyEsd+ggVJOq+t8aQO37IRvGTzvm4GW6vHb4Tub41ZPopBrnI8LdfVjW2b4F++sTNMVT3Y9VR2KNax/93mCBAxOsXsHqR/H6Sh8GI6ZtoUV/KtzWet49tu4ZwqpoDOZv3W5gyDGSYp3yMEfYiHb4RuKFxSaUobNJ+AWUdLXzVY/natgVf2L+byrE78U6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 13:38:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 13:38:45 +0000
Date: Tue, 6 May 2025 14:38:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] cmdline: add floating point support
Message-ID: <aBoQ4Z2EUlNHvoI1@bricha3-mobl1.ger.corp.intel.com>
References: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
 <cc5198a753f4a86242c0135914affba97d7d4d1c.1746536891.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cc5198a753f4a86242c0135914affba97d7d4d1c.1746536891.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB7PR05CA0020.eurprd05.prod.outlook.com
 (2603:10a6:10:36::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d421c3a-e386-4d01-83f6-08dd8ca352da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ftGsIzifUVvJF+M4R997Y/VL5ovm2NnBwy5E38wD2Q/xMpqAV8YqgZJbnnpy?=
 =?us-ascii?Q?0eh+qYF+2Bcu/1xxGi6rM5eDyQta2GWZuFVmj3fT/sqCgNB2p4vxzjR7Z0GU?=
 =?us-ascii?Q?h/vXWPLJPY9NI4nk8eYea47jw+kBK5Q4HagEWnXWtWRJ3pbgCjnWrdst3a/y?=
 =?us-ascii?Q?N5NpDTHzEy//azqXYB4ZDxUX+0g3rLmhUFAejr7kWCWV/pC5qiEAC6qBJvER?=
 =?us-ascii?Q?NO2BijBE/6IKuOD6zru4sosdgLGI4/N0S0XEy6XMVvh75d4vJEnM9Oy43AfE?=
 =?us-ascii?Q?r7eubj17ZGBsqpeelbOxZ3giGrC+MOkd+rGwtUS2Eped7HwL9HeHzyCoYUkh?=
 =?us-ascii?Q?BaB09w0fz7WNv3QCWtDJe3QKEzqY40m0EOChCy8lFv1jouasAz9fWLBXYbuW?=
 =?us-ascii?Q?6SVS47XGvJl1RBluVgbIyTwy8wiL83ReCmidMubPLZrrarunncpOpw9vu9y0?=
 =?us-ascii?Q?kQqz4kVKc1pkvdFugmAJh0MROHmAhzS9W1ntLHduCpZ9QKjeM3p1uc8S3G+5?=
 =?us-ascii?Q?bLgP5VW58mRVIhBwxwE+YO5BKPSz5i+oeaVcaGz81hJAQlQCSSiU6BtCNo54?=
 =?us-ascii?Q?dmRZOdkK/B07bEaMPxaXZV7kE0jtgygvAQTFhh3GHe1AJmx8+tV+KlumGVrX?=
 =?us-ascii?Q?qZQe+OvQYirncsDP1M8B5oOYnpJw+k3jU6qtoPSuIFLVC6WRYujkkmQZOBdd?=
 =?us-ascii?Q?Vfl0mAyK7xJgpczzMYT0bIKVU+NTy4Cm2p65kgMbeIU9I24XvFgeN+F0frWI?=
 =?us-ascii?Q?CLdhdlJ2PQzStoignhw9I2vvmhyCLoNkNxPtQwyhwVicaFTzGoZTaeeO31NJ?=
 =?us-ascii?Q?JE9AG0dM2TC8cdRymXHqSMF7C+8u26dm5Es3gzyK+APCEizRez8571cUYYMa?=
 =?us-ascii?Q?LCJESEL9JWegIo2ebQ/PY/j5qUaR/xR7z8qzZaWUlIyvx94/BYc4jxE0wJXg?=
 =?us-ascii?Q?QtK4PQ4KbPHblrM2q12fVNW8HT34NCogRO2TSbCXzN8ZhgL6eDdc91rJRy+4?=
 =?us-ascii?Q?SCY3gqcpXavl7zWIsQRjYVIGIRGjXpK79WkJRmj9/9UyNUUTE6q67c4TrNFc?=
 =?us-ascii?Q?kDnL5iHU+QLRJiSIOrf34B5z/lK0C+O2m7LwfA539PLfUA2lEfL2V4nKs2UX?=
 =?us-ascii?Q?woYdmP4ijl8oaXy8qn+1pZxTjWHnnqQo+nivZhvloT0pgAfp/zqMq995fyWN?=
 =?us-ascii?Q?KB8Ld44GPgqOGV1k1JbdBZVJhe/hToQupQRBb+kaMdknuo1vklf+Js5OWyzp?=
 =?us-ascii?Q?49Ssc/6wMItcURdjxzrxb91XilRGwQBhst4Gn3MBkOkPb9HrWPXewHDvnZ5s?=
 =?us-ascii?Q?8fmmWk7AtXajMrJZuuvz3DPyNSzaDQBDdUAqABTwFis5Ysh288cScHRQiXns?=
 =?us-ascii?Q?Zany8Mm42sAyxffP//0OUeZWpgUIA7UaezN26c9WFwSgBQWD7JFAKoIukCHO?=
 =?us-ascii?Q?nKdhrGyrqbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wk+GhRmEmDfoij9Z/eSc+Yxiwy+TPNVr6S0f1kRLUEAQ1OsBwyQHW/Odkosa?=
 =?us-ascii?Q?N3Pk4U5SaaJuNJAwrR9d2f/qCg6HyuMVfc4Kj/20BilSqJf/QXtD7NduTaUe?=
 =?us-ascii?Q?ejddw4UOMyxYXQ37AWMHSQtusL31zUxVUSLYUUHTGseCAkW1f6CDJPa6kqQL?=
 =?us-ascii?Q?yC3pcSdlKA3AoZ8qj7pPsWbtyxk9t6G7KSY+VXoIV3+q5vd0Kpq/we50VYIn?=
 =?us-ascii?Q?x+Zxr4QtVX+4JN3I11hkmTKTRx8nx9x2jeolucMmyRHo8RTwfgNzkNDOyjtu?=
 =?us-ascii?Q?sZEN0TFhM/JEjbHZRl0bk2PuhUzMd35ctwZix3VeZ3OmxbViQe/UQA9Ukyv6?=
 =?us-ascii?Q?DMFPOZ8xy9U8glnRPwOXT7o4ZWfheIk6tvhxDtXcyrMlB0QUkDKL2qm3HhWN?=
 =?us-ascii?Q?vidkpm6yVZRqpg+N1P9y98GPnpH1OoiNiQ4ucW1Ld/YYM6Jbr7TOifOmFtAH?=
 =?us-ascii?Q?aVB7NCYkd0CSqReXqCkpTRXmLoEoZt7FBvgJieKuIhjW6KDH3cFSv0Y3yv7g?=
 =?us-ascii?Q?3SaMOQB9uZHzP3QH+nwDXIdkuisPZ1K8p2p0Pz15jlTHwYuox032TUNwTTrI?=
 =?us-ascii?Q?oHJQoGtqVdDIe9eNn743oK7kTKbzMaajfyjxaBx8GSJUwIkeWaGg6xDhzaFr?=
 =?us-ascii?Q?XUr6OMQ33dKSoEEDJeOFcWQXtqNExb+IHHCvJJrnhMUlBO6RYwFjHTzbAatq?=
 =?us-ascii?Q?a006nGCiah5BTXykVvXl+E2xRMXtchyUmOtW70qzqF/vOcfzOqzwjAe9daGt?=
 =?us-ascii?Q?YXGWf3d/rmuP3PAHiyLn5hZsvh9vLySwmQ6wMXCgIAW/JPKgf1QzE0gtOGDX?=
 =?us-ascii?Q?RsFCyphfvwUeL4/AEfe6jsA0FH3/FG3XjDRLV2FBGwKWQoE5GCa4cYP18vKa?=
 =?us-ascii?Q?VUX1Bz8kks/UZ66Gfgz0eg7ryaD7s8SRSnqgwFCbENKZG4UqM4yAIgTv4L8O?=
 =?us-ascii?Q?aJskhfvdOIkib3kSk4xYC9XE9IXzPT/3VrcpiyneunO44wKI2nGhvW/+hzag?=
 =?us-ascii?Q?FrMK85B+UP84kXkg5Xbes2Cj5j7/xA/i2gu2SQ2WzX9vFCpJwrXaCs18Jirr?=
 =?us-ascii?Q?ENA0lehWGclNIOzECiWvUiaFRrw7HVk7f7HkfoCKpFtLS+MpaEbAf2FwDeZq?=
 =?us-ascii?Q?Hnel+4JRC+u+2IgyHOgy+Xyd8xW5shMrpCXls7pbwRMuNJFjf69ZbEYAunY2?=
 =?us-ascii?Q?Tc2vCjPciajKu+oijesRWnSgSrl9F/lPB61HMoIzSyBOCSNr5UjjLa41c58K?=
 =?us-ascii?Q?/23y5wSB4Kc22czwEOHQs8ye18lmTv9Z6EyqIbYkCfYIS5sANY/nkda3lGvR?=
 =?us-ascii?Q?p85dDeaElixYyhiU4PTgaLTF06gH7O2mZsrc/p7C8IoRbv2ne4CnUbGR4Fw5?=
 =?us-ascii?Q?rv7Oz5OwYTnbbKSoQ7s66Y9MCxBckxNHxK0Ixa/EjFf3DB43dVVDTLWM3gQx?=
 =?us-ascii?Q?7XFi90g5Wt4JOf0zNAo8PiAeSMVhiEb/Sa/JSPFQMRKw+rfPktXgokisw4dU?=
 =?us-ascii?Q?jrX1HAgfZwJ4aMgLABERbI/GR/o03fNHnV2neDm1l+Nv6uPqAxvbRPDWv5od?=
 =?us-ascii?Q?gJBQP0DY8E3IwmvUNa5q0sNObgAQlI1cI410DgKgIy+qZNZwMkeq8CrETUQ6?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d421c3a-e386-4d01-83f6-08dd8ca352da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 13:38:45.5339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saZ7Gg8rLEEHTI6ZaQej5/z8pxwd5uYRXyExvEcPruRR9SYhCRhllh/i+INH0AFaJbyGCcw7zFyVr0GKICXMYpRNHtFcl1PqlL3vwj2/82A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
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

On Tue, May 06, 2025 at 02:08:18PM +0100, Anatoly Burakov wrote:
> Add support for parsing floating point numbers in cmdline library, as well
> as unit tests for the new functionality. The parser supports single and
> double precision floats, and will understand decimal fractions as well as
> scientific notation.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  app/test/test_cmdline_num.c     | 201 +++++++++++++++++++++++-
>  lib/cmdline/cmdline_parse_num.c | 261 ++++++++++++++++++++++++++++++++
>  lib/cmdline/cmdline_parse_num.h |   4 +-
>  3 files changed, 462 insertions(+), 4 deletions(-)
> 
This is great to see, thanks. Can you also look to add support to
buildtools/dpdk-cmdline-gen.py script, to make it possible to use this from
a cmdline list file as with many of our sample apps?

/Bruce
