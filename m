Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB630606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qp/qYe8o;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=X1VplUm9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E60E40263;
	Fri, 20 Nov 2026 12:40:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 5EB3340151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 12:40:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795174806; x=1826710806;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wj1laDYOjMAhlTzRUw8YzmgX+P+e7kyPrPlQmmAwnOM=;
 b=Qp/qYe8oP438WLGPCCwTmudVRTVv2IK8Me+UWWPbf8VmgC/Wq4iLDefv
 9tndZczZTjqwsCzObBBKun+c1xzThWqkrJk/7Hh24dBM24mKP5wC662nP
 1RpfQZeGMhMJx9yPkRi62YpMVAuJsk3XojBeP1X/LPltaBsYQbvs6NMzW
 YbcOr6iWbzCx+7D79CiFWKfmpnGajHKLnmULkQiOFf6dOks1U8jESR4J1
 Po2R63Xj8M6ABrWV555/iuAqWlIXxszxXCTghH9Rg5vtAzpLNmRVvCS4j
 4G+TG3L9Yu1OabgEL6oMce/vEUpU1PtWaOEnrtbJjA7A6QX97U0EBem0W Q==;
X-CSE-ConnectionGUID: ZIYhZRGiRMmWL/Z2D74vJQ==
X-CSE-MsgGUID: 1DHuWVBhT+SXR4Bc6ySzlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4038580"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4038580"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:40:04 -0800
X-CSE-ConnectionGUID: yekJ7oSMTNeaLLpTmzvLhg==
X-CSE-MsgGUID: praQ0kIcQfa6RCykx/ynmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="11021020"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 03:40:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:40:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 20 Nov 2026 03:40:03 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 20 Nov 2026 03:40:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ5q5RRNMqAamO/qqTbBU9sfDu2q5qEpVV09rrdkevXlfc5LnCIq0DPO8lQgSTsL0wvIVAAE7cUWNVUagufPLQy9IXzsLa3HR59jbGpEflaOXdmva9t3KGRmaBjbuHfJRCS50Wszu5Wjvr8PkGKSOXRIydArzJC+/07JPnYj7wwN+XbUtruDVOaKbLhWQj1dru30owxK+Hz5pz/Rwodxa4VpgXTW3c9zpFcKImwCNvhEMUwI8w6cfJ0hZrnXKppexv40nfCqx3eYFl8s8rpmPvFMqICNi352pPx3JBq1lcUQuoWjoDGqjDAMBu6TTdF8c6RsBGTXDxF1ijVeDCo+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neHWFyzsjrfWQbPg/12lN4FzMK8+A1h0+miMtvOobcc=;
 b=gJgztGsjWrRNYLjEF4SsvWOI4hZu+HUSlhWxLQKpQnD4IhqF++nhD5xjljBvq9OD+tXI6uoPuP5smVtRfTQAsaLccu+cCj/ckzE8rYBp96yWzViBiFnJX4vufuFuB0e6n21tkP1U/MpSHmtcr+BJVnVg0+ypi6ymyqX/fajZNNQLopCIvkJLBMOvO7NhANVZ/ZsWVQj8ed1L04klWadagslKZXYzQYrQkL1twpc8vnkqwckHz0qRFQmAjH3wwGc7lrQVy6FUvmZ8+VXnvwptq/7PMoQ6g72KtBPFWViCataMCC8pYq9rw6bcTGrZiWrtdYCAwPN3hSmZ7ZOe/C0y1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neHWFyzsjrfWQbPg/12lN4FzMK8+A1h0+miMtvOobcc=;
 b=X1VplUm9nxDFdUlC481FjvxTJLNiQQN7fEgunMS1Bo/vU4PuZGs96uS/FsJ9w8gGVqZnkzkwMcfwE3/qRiJMAQayIyTRLSQHh3XgCgmE0XxMRwvhRLEFF5oWi+PXGUYppzPXCDCIcEvnxxVMAluEd+sRYxsTlalHe32RV5foO70=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 11:39:56 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 11:39:55 +0000
Date: Fri, 20 Nov 2026 11:39:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/ixgbe: fix PTP packet detection
Message-ID: <awAxhrA4bWWf6wFO@bricha3-mobl1.ger.corp.intel.com>
References: <a981e3347f36b5cda348c27448eba3c5d83e98a7.1795170123.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a981e3347f36b5cda348c27448eba3c5d83e98a7.1795170123.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7PR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 99893e3f-3158-445c-7311-08df46faff9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: SaI9FLKvFrDKnfWe2U1TZRcu1J5JKJpoz0ItLXXACmtpC069SgN/VIJNTfMsesyqes39mxT206qAA+31L8h5OOVQMhF0h6gMjhURe6lJzxq/1PJokxwcdtSxM8wp1l19ztN1VaOVRXpb8arzmevXPCLSmq+U4zq4Vvyzc4fLjQ55hgsI/tM/Twtd4P/RNzqm6bXMbssCFF3mr+0KLHFdF8YbHkADABrWw1fflK9Zr4hz77B1QVgXR2YI49R4bFRZ71gMbFZTefXjyzixQ3UNd2h/lVfWt9vdcLYd1+tv4Jv/XfmJN6hkW/ueIXy4yMKAtd2AgVmDVErBWUGMrQ9wLY3uGmGLgMPSsVFqAd8QOjTo+pmuhzr9F9bYvQvGQ6uY8sIEyf3iqIGveduUK8OjTw7hcxmHCSvmBLlLZ+1b4LKVKq7OwYoKbLBxpdzBxAUsaD5AxgZG4tbmORiQMRoqFslA0qTn2f8+H19nKQnCdw9HrqWHoBCbRTBvOUkCbpEtOHHRNnHROSUv6x6Ylgx2zI3xXsKJa8LkDKloOVyoPNrC55qE3fsspkPIqQtvPykenvIOcYFrXDvtvsogMZOkb99M3jvYaI+AQHbK/7NEcHay41UDiVe1WJNu1lNcwY0k5b7HRePklKEH+Trrpl3mgE5D2Bog38rWkx9ld3q67xY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FLcwFL+b49OOiJsMlJVIzF90rIuZKHRvmsgZgTcUfpm4YVA0k70T42tD2peV?=
 =?us-ascii?Q?IRI8SQcpJz1xiTUF+o2tUygZk0tiSp+JIi9CPLTTQid1fYEIJbZlsrHpT6BT?=
 =?us-ascii?Q?mVu46V/Me1m5EaJgCIrUxgAJtIYAvOJ8lUffel8n31TtQW2KgzvTL8wmmOgb?=
 =?us-ascii?Q?/GdajGowgOLU2QUXSQOfnfPH55/ezP4OZOEBeGxOyF7UYGty+QcmnFmf87Ae?=
 =?us-ascii?Q?bQVnndX0H4aeU1f8LccWgpRkpPzGqJUUaXcnyESYrVw1YuDx84g1WhXalQio?=
 =?us-ascii?Q?3caTH5h4aA1oV6UoAdvECjX9TDn7hZcM5JhYJUgOK4KJKzZV/I6R+TSh+6u+?=
 =?us-ascii?Q?WMIPlsw66AQ2ynRL7NU4EkAiYuoXwN9RCXqvncY3gTfHgv/iR8HPFPE3FGVY?=
 =?us-ascii?Q?QlE+Q+3rawrQc3Rp3BYVMm22DbzSPR343D0exusmRl0sKP2/PoAycveDYyQS?=
 =?us-ascii?Q?Nzi6O6sWREi4XofxNvOl7sVCI/EloYEjWuOHPMLXt+9nBcE8iURvvaCg5qW/?=
 =?us-ascii?Q?3+0X4H4yPawCY+WWGwLlyXx+fLt07aHnEHORV5lDoz99GytiOD52UM3r3HkG?=
 =?us-ascii?Q?+h2rNenHiu8dRvEF5HK6G6+BkwJaTf39l4G4EHQ2SavrGLkVOvZt9jPDXxNa?=
 =?us-ascii?Q?bX1Egt3HtDopkaYnjujW0eA8LFkj2mqpwzVp2gmXK/o73dXjnYdsmhGI4syn?=
 =?us-ascii?Q?Ts5uRMSMEgCBaLLM0+LFDaNUddxsKGKiXccnYkpIhLCU3h/c5RZVVGaMDAbw?=
 =?us-ascii?Q?ce0QBz7gvhWI/tGbicmvzTWuwBxHFZqoeEsTh1V9/rF54vgPlMqlcPieIfPD?=
 =?us-ascii?Q?7umAzKlpgzeWv8BxqU7XF5kP0/GHqGeI90tsB8epAE50fUm5eA5MaOANowMj?=
 =?us-ascii?Q?Ny8JFk+p3uevaL7d6MAh2N1LZ1cqOa1H70xX88rzfvqLOvmghjfyEcCS3Mpq?=
 =?us-ascii?Q?0ekO4en/jfhkebU7WK72Qo8OjHxst4IYR1WrclWLpNIQXTPFQ/nK2UTmyqqt?=
 =?us-ascii?Q?SYFgLIq/iQXEIpC9ph/Lx4adeCFeGp+9lxtdb4zcDzTvUh+uODsRfkew7fBC?=
 =?us-ascii?Q?APWUQjN7KgRXgkpSL82XAgu0KrYzMKGY0c7yTGoox+cP1uuZVZjRIbvGSn6S?=
 =?us-ascii?Q?lx7zMsAGw28tFOm0MeWR3CiRy669puWF5GbFCWEYECVcseCOMhPFkMzJ7gff?=
 =?us-ascii?Q?dvvStHkqK/S0dXaWT+yjT2oOrDHMfweBzVc9ii8sYdMhBeilhpaq8FFEl5wE?=
 =?us-ascii?Q?e1NdnkzYRn+BoO+oZ2f2NmDHp6mqLCoqHjJTkaOAYucKSYt2jS/jfZ6ggKkI?=
 =?us-ascii?Q?aItIj7nmsTm3+VZLLZsjhDInGWxorXlqkDXyfbFv90Ela9HSllnGU2N2oL+O?=
 =?us-ascii?Q?1VlSxW3p/gmiJgy6ZPYSGL/5/ZXXOdbjnPyyNn+8aRGHr4bO95Ellztcv9TZ?=
 =?us-ascii?Q?/2EeXXwcQ6rtiRNcLKa3bYRJQaqNNAM3sz1OZiarwXHsTV3ag8LB/xfXAspW?=
 =?us-ascii?Q?elQVjpJXfElH4hPeKraM9dMH8oz8+58/y46xkIpDsp9TyzUuQEH3oozUWf6R?=
 =?us-ascii?Q?FbKqdbXVrXMrvhG1dd26eG3lSSmpDfNkk0hi6R4t+c4fitnlP3kNkFodBUNO?=
 =?us-ascii?Q?O2YbXFurWmmmVYgsWDedRGFMQm+JkHon+Jd7PEglljU85k3rSVZ8f7KkLtuM?=
 =?us-ascii?Q?DtBZt87J43xWeNhhFN+fOFv6lKx7VCAHNkaEIYCukw+euH7SwJJ7mnLIieVj?=
 =?us-ascii?Q?VBiknIbZrNLDuqikF+hzyqBFJ7BZ1zc=3D?=
X-Exchange-RoutingPolicyChecked: G7z74Deyau48LnyurlBFpSH79R2+MHmGg9dGEjtSBfPnZOlXOR+86I6gmG1uFOVgvEv3p31gOVvo8TUXRxL+RVn/PFeGTQFvnYL2wnXAQVugK5aK9oALwGRB/UnDGGl46DEfoTcUaNYoAJILqQfjVImj/KeF8bir7szyw1tVcsWOmPv0kCxjN5DUkDaWUORrWD9fJ/Cqh4Xin0O1YVg5VAS3hB17wCE4EgcFRmHbnL+X4HGY8R4yE1ej4rgflPW7+4uf1IpmrEf8tdSx+sa2MTGjwtRaM8+V/274GdEU4uwGas2aPHYjE2Zv5VL0QsoMNGEOZkzev/E5Eyr38vnilg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99893e3f-3158-445c-7311-08df46faff9a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 11:39:55.6720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJMos4UgSahwTgbyZFWJ3HJShJvIZH13NMlk7w5REc3PF6q6AQEromd4oiep8QUdSSclbq4bTflf4yCsZBNDoQrZMonUD3skrTmgBdHJC0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 10:22:09AM +0000, Anatoly Burakov wrote:
> Currently, the Rx path decides whether a packet is a PTP packet by looking
> at which ETQF filter index it was matched against, and it expects the
> 1588 filter to always be at index 3. However, when the Ethertype filter
> table was made dynamic, the 1588 filter started being installed into
> the first free slot instead, so the Rx path may not recognize PTP packets
> and, if that happens, never sets RTE_MBUF_F_RX_IEEE1588_PTP on them.
> 
> Fix it by always reserving the last ETQF slot for the 1588 filter, and
> only allocating the remaining slots dynamically.
> 
> Fixes: 3ba3f96f8f71 ("net/ixgbe: make ethertype filter table dynamic")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c | 33 +++++---------------------
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h |  9 +++----
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c   |  5 ++--
>  3 files changed, 13 insertions(+), 34 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Despite it being late in cycle, after discussion with Anatoly and asking AI
to do a detailed review of this (which came back clean), I'm going to take
this patch.

Applied to dpdk-next-net-intel.
Thanks,
/Bruce

