Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DAAC88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:06:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A182340269;
	Fri, 11 Sep 2026 12:06:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E48A140264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 12:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789121174; x=1820657174;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wp/FHAdUOx7nlO3hWme/pMu95izb8QtzH2vFbzn3F08=;
 b=YCwtf1nMm3xKGmexSdJKBB7oScj296sdGmyWcR82m3j7hAOd8c2DtroG
 Qv6rSnjntH3c5zVFfYd1f0Nk3pQo90cOV+aqY6GZofZfJq00mh+UGwc5m
 twYuc4EX12rvxDa61Gk7GtZa/Y8TGrRzzlEXcCL6dxjDDS79sxYMWD6j2
 R+iUaupZQVEJkUrjlHCOG9dAwHqBQQDP3SCmySJsS7GbF4X4porNuuL/S
 5tEYtosGEFKIzpOmzlZyj6JHcBGxNSrP1TgfIJIpvJwYcfmfAx9B3mRxh
 mTIwNgYlLDV2+JNtsntOr3LW9WkzE7Y4VWwK8YHKfR0cY33/nn/CdvNjd g==;
X-CSE-ConnectionGUID: kQgV2yRvT/2gVwkel506jA==
X-CSE-MsgGUID: PK4h3j4KSGeDY16HuVgnqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88526628"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="88526628"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 03:06:13 -0700
X-CSE-ConnectionGUID: yVDqvObPQQ6BUD4nb8Iqqw==
X-CSE-MsgGUID: 5IeId0WTQ0WOqDEqfFiumA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="171986"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 03:06:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 03:06:12 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 03:06:12 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 03:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfhPzJpHT/EA7RVDJdZRompte31Oz0ZffnsulzJFVAtfb9iZ5JihKYgBRWHKt7F8D4B23PS6j6smio2BvrtgnPiY7G9JTD2zUiQ34TE5QWF4ul2KWOF1YopRYhc13XzicMRcZF9ToDMf2EVQQJXZSpm3DXlnNxLyTw3m73o3DQ8gjNXqncCqq5gQud+5vnv7xmw2Suz5F8OxE7FvVRBJXNJgayAfQaaJg9pNiBHSABAGs9H9HZrMK3WXGloCZRcGDz/PpmeOmgRxnlt8bSZPivxljmTeYVdM6uP5gZ+j7PDKpgz2uF8hFbalmkPt8KfHMVJZKcNXc9oarqGOWD3A4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZHJKXoRkjdA7eVBkzZBALA7kBq7NkyIQIeLKxRMgzU=;
 b=MMaoaAuTG8ZS6k+M47B4fB5AOc4CBGr1mYrDkZaareagOyyDxG3z82KXIODUBcUrJCfAm8M0Rlvcxzhb25QsOFC8v6KKo4fEYiOCQq4p7BuQxdxzs8tHfGIgO7fnYdDlXu8NS3kTujzSp2+72Rr8Hz2KgbzeQdkIP2trTqP4AiY7J+DcXtbMZOeATkVXXNi8iIP9rDveWfOIShdH4xbGFYVkSmQ3V6UzreesN9YNsjIpta8WuzfYuKQLSaKR6UH3KH7NhF3TQ0EKXotHKvXB7oe3Tasg/pkcSdLwswzPM+aEe5VqckDeKcU/hu3i9YXoX/zYnKSwWidRuSQqfvs/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CY8PR11MB7730.namprd11.prod.outlook.com (2603:10b6:930:74::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 10:06:09 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 10:06:09 +0000
Date: Fri, 11 Sep 2026 11:06:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/68] reduce use of rte_memcpy
Message-ID: <aqPSjAonmnLRwr5-@bricha3-mobl1.ger.corp.intel.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
X-ClientProxiedBy: DU6P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CY8PR11MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: c5dcd29a-865e-497f-ee68-08df0fec4d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sOpBkPZvD8TtqEhuhQ06BKDZQ4TbqsIGfCMRF69QABAVXc5YnNPv6DMtzHEZGIuswVfO81olkNKaDS4rB5d5/LN+6C6ctQUWplVx1dKmsJNA0ybVdI6urHG75HzgSx3ZNaO5HTEMkicFqjzNcTN+gULRoWVhPf9sbw/CFIKsZEjabnrgONytVHQpKZdQnT6x3qfQJJHVhyxILGwv+WkwWv314KDcGHpT9XKBCbzdRYXL8FiteTtcCtHsFvK0W+6YTbxFeF0nzy5VnVrwcnXntjDifVJljszeRmzgKtwHb+mwZXC9Sptxl+M4c6bTj3EPfboA3ezd2Yjev4qOqQEXCIZEGwxJ+7egcYbfZ9+vdy1dc1PI2Y1JuwhZhE3Ym1qZKPNr0/G91CJ6yXKMB4Y17SoI25074PNrzN5h/5Dxz2di1yJ0U5CNTCuwooXvusAkX/LCJPd2Q76pKiKGSUyI7Np8xIZCaUhE4isveL1+zhJvaxYFycIR5cUbPns4kxe013M5UV19ppA7Kcj9C4EpJCjaYbR5WoiulQD76dLblbz/mCnC4mJ5n30LPOFNLcicOArpADfkaQ1E5bRIL3AFcHuVvaR1xZKJ98D1+2cb8okbVqjHXRzE3aJBXSeNi0XeM1k84zT6OOabWu2IDQ0rhzU9we/r+pRbzpT4jJ00xRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6tnsMNIbRphQipYeDennDsxE8QgiSqeBbZgciRNZpQOjTDral7P7SgDPsmRq?=
 =?us-ascii?Q?q+RRpMGipZjzf8ghJzmHXPNfo86p4u+8QeV2jgxsVEdka38hWK418A4bDDBV?=
 =?us-ascii?Q?yolj1GQMKFNcKehMWJ4h12oyOOIchIj5C1R+nvCuuN9n6zz4uxSJNt/3MOqQ?=
 =?us-ascii?Q?KmWzFj6ZRCDUc/swoENFJcc58NDkw+hKbSZE7x1dnCbPdRGtoXpEHnDEXhIZ?=
 =?us-ascii?Q?QPupmi+XSPlDnZ63ZjZZuecvLgI/E4+gcuduTePkkeuuzW14Ttj+l4ESqP09?=
 =?us-ascii?Q?RqKdcMnPUdCnh64p8OM/g3Ja+LBgHH+f8xLl0G0pvPp0TVZNfjXcdeQ2C3ke?=
 =?us-ascii?Q?p4yy/os0h0Ws8FHlr1rVLTuLnJxdZO4hAvLTi23uIT/irDikHNv+Fg1zrhRh?=
 =?us-ascii?Q?uLF/vKwzBW+wsvPXmrlqwMVL8Bpo3PubILJw78sgB/8rM+HZ6uBsRuEvFcST?=
 =?us-ascii?Q?JuMN9m4aHMfKr6ajxfkDHoA1jOOS+lXe1htLqk+DJ91YXuZnwQJoqXBM9DDu?=
 =?us-ascii?Q?TxslaMSU8JlTDLmOYSExkQTvr9O9H4WCvy3YbUuLeXFh5ULUgxq39QOpwWnE?=
 =?us-ascii?Q?iGONDUIfMwPOT8NYAv1K3S/3QydnRWaGfw4JY7I8TxbHV4eUURZC07PDXFUI?=
 =?us-ascii?Q?X7YYCz8ovNV6xqPy8lCEHu1RgCCKzWwry9fVUwLcnM1kq/PJzpbHF2aM3twr?=
 =?us-ascii?Q?kSpn6qatNQG+ekBwv0uKq3efBI8I6vTjLzMF9nBOkDkVUFe0RF9fx8bbNwU3?=
 =?us-ascii?Q?tr+el21YqMMFvTFL7aS0ugqfJps2+flYBpX9OLbVabj4I9ABH7FhBdi0tOwq?=
 =?us-ascii?Q?1+CwPTXYPk5Fk8qf8wEdTltcFIl3X7FmTGaYaIiSIeCV+UmnIw78PxZQfuTZ?=
 =?us-ascii?Q?+6/KGBfOwt80BVbsT/qbNOg2EdPtGF5ezTuK/H62ZHXFjd8xZEYjd7GIYLYe?=
 =?us-ascii?Q?SkIZbp6Pdr8yNqe44h3sfRaSJntfh4q3J2wcBrUDIoo9rUVtmV+kVGTzI4s7?=
 =?us-ascii?Q?PoKarJ+eFqIMUYz3XQS5htP9C6RCfh7uhm3+b7OvYeFDvdnX+HiYS82MGl8Y?=
 =?us-ascii?Q?juGhjVFssLnjFvqniAZcPZ+pEN4YdIkFGr6F1qga4pqM2yj02CS35JGhFfLL?=
 =?us-ascii?Q?6M+dNhcjoiSY/C9jBV+zZREMbKBBgGbnAnqH5VC0Qlj0s4EQMXhcJ75W5tir?=
 =?us-ascii?Q?TRMRFLdaNICp/gW8shU86nRvuBXGEZV6663gEdzo0zaf9K+2bAlmBVb5DCvD?=
 =?us-ascii?Q?RXBp1zKtnfrpskaidId3+RPJ3jBnLheMHxuexnLdtHuETqXi8PUi0YR34cek?=
 =?us-ascii?Q?VJn/0Jheel6EtG0KTSIx1qOIW6Hm7lPhtjObr2VS9Zf7Qg6VJgQ3k1rkVong?=
 =?us-ascii?Q?IbOizfFpVAX8LxKCUv8FB7vF0FQgbXVlaDSP+lf1uXRVbG/L4Np/rVK9/HWU?=
 =?us-ascii?Q?NoDll7I4WVM9XeXQYIbRZSBylkvDULvltnoUJq9OzgftpHdy14KYMrxk0Y2F?=
 =?us-ascii?Q?KCAyQyb+/9EzNvGKIPNZUuHIP5YC2QDQCxBDFUxDf44AJJSB91dDAUSAGjGY?=
 =?us-ascii?Q?c/jMJSsTklExuD0HxxtLC1A03Nq3Zx50ppTC1A0FBWnfnL/3GnkK6pwNkcL4?=
 =?us-ascii?Q?OPXHzxcRab2NSV2vyrZ+jG1+OYtcFBn+cKuarK+UUr7NjIUDTIgSnoOZbTMO?=
 =?us-ascii?Q?m09yn1QedNx8BARpfmtWdVC/gzJbhKUOy1NMxMch+hJVdc6BAo3S0EHUIk1u?=
 =?us-ascii?Q?r4nbhMlda4ZBjy8YC9AccbRI8F2zz/U=3D?=
X-Exchange-RoutingPolicyChecked: ANc3/a9GUDk62N5HOcchTbXaWu0+H8a8CiJsnhM03NVoVInG7tII/XW7lslUN0RS+FE13ZgTzk3vyRGpWOzVHV/UybBkahquHMG8QGY/gjeqzSLht6tVttLfpCCO1AXBUcxPddBS8//v9hGqM9FDeU4HtJy7tvQX7efkquNktumYudB1kWJjAlHF8++k1mC8sGqCjr13x8NwgJLj5ddBYZSLKD8hgp3Gp01EycQRjgIj7kKe5/izXXDPCJoy+LB3xAweVi8OezQ3p8uVj/vakqRq/fCHb+K01aurpHR5oelJoSlu9/WtiZsNFZ6gEZR3Vh7rqwmkLTnX7KXW/TO0Jg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5dcd29a-865e-497f-ee68-08df0fec4d1f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:06:09.1796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7C8ioYDbIHCuJNnA2nfE1K24Iukf+36WBPdPBFvh32psyl92SAQrfcVwl9kHD9FHSGLZIRN+N9QO5drc4EMma9Zk6czXCO1ZUXqSsMH37Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7730
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

On Fri, Aug 21, 2026 at 12:23:55PM -0700, Stephen Hemminger wrote:
> The DPDK function rte_memcpy() only exists as an optimization
> for shortcomings in performance of libc memcpy() on some platforms.
> Many platforms have no special rte_memcpy() and just use memcpy().
> 
> But many analysis and test tools know that memcpy() is a special
> case and check for overwrite, bounds errors etc. Therefore memcpy()
> should be preferred where ever possible.
> 
> This patch series introduces a coccinelle script to find
> calls to rte_memcpy() where size is fixed, and change them to
> regular memcpy(). Many of the patch series is just the results
> of that script.
> 
> There is also some cleanups to include rte_memcpy.h where it
> was not being done before; the include was happening by some other header.
> And also removal of rte_memcpy.h where no longer needed.
> 
> The result is a 45% reduction in use of rte_memcpy (1008 call
> sites down to 551). The leftover cases are places where rte_memcpy
> is used in data path; and test code for rte_memcpy.
> 
> v2:
>   - reorder the series so it bisects cleanly: the patches adding
>     the missing includes of rte_memcpy.h now come first, before
>     any patch that removes an include or replaces a call. In v1
>     those were at the end of the series, so intermediate commits
>     could fail to build.
>   - move the documentation patch describing when to use
>     rte_memcpy() to the front of the series, so the rationale for
>     the rest of the changes is established first.
> 

I like this series, and the rework of the order in v2 is ok, but I actually
think the patchset should be split - at least into 2, if not more.

The patches removing the unnecessary include of rte_memcpy from C files
should be split out into a separate patchset. There are a number of these
in the series, and many have an incorrect patch title and description, a
couple of which I flagged (I was working backward through the patchset -
don't ask why, cos I don't know!). That patchset is a trivial review and
merge case, since if it builds it's fine.

That then cuts down the rest of the set by a bit, making it more trackable.
If possible, I'd actually like to see another patchset separated out to
cover the case where you replace all constant-sized rte_memcpy calls, which
use sizeof, with regular memcpy. Having all patches doing the same thing
again makes it trivial to review and ack.

That would then leave the rest of the changes which require more
examination - where we are replacing a non-constant copy using rte_memcpy
with a memcpy. That's where the focus needs to be for review.

Just my 2c. I think having a 68-patch set in one is too big.

/Bruce
