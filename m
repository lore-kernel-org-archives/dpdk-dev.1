Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF97CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:14:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90B3C402BE;
	Tue,  9 Jun 2026 15:14:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 94C994025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 15:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781010853; x=1812546853;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=VYXsqiFbv3yQdA9ENvMwx0jnDemDnkf+FpO/sZ5Mg/8=;
 b=gUQF715yyoVXLBZCtAsZ2R7me3m1ucdkWWocTjj/fDCAGsipvCDGG8Cu
 ATZWhnT2Qj1Ce68TWi4IgOmslqFqe4FDgzh9itKl/ow7aPP1RWd8qB580
 NHz8AIuNIb16bF1e5gViaaH4UEJHvbcTUCu5lJTXkoU3qM4kvpmBQdkQq
 ARRERhIROqYAyC8STeY2xZlMPq0h0BnClIaCnUXjyWtn1TmW3161IXqpC
 427SmZP/5JvyXVvB0UbNxI3sMU4MijyOUFZxbu4MX0Hc68uI4xRTgnx3r
 mmRiOnrEAYQsjy0WjBUQOTqdB06CsLseORNjjciJTmDNNTt97bE34JH5Y w==;
X-CSE-ConnectionGUID: 5RqZQ9MPQoiztf+fSJx6Tg==
X-CSE-MsgGUID: vpevqnWtRQ+DAXq25Ri/Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="99346225"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="99346225"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 06:14:11 -0700
X-CSE-ConnectionGUID: /92KWSKlTBOmTzJtoMMsvA==
X-CSE-MsgGUID: zxH4pQGKSDSBwZNBqH5R9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; d="scan'208";a="247722009"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 06:14:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 06:14:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 06:14:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 06:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sth+G9YisDgqCEOCVNuI3X+ZXn+QIFNSKUHhaBjK2ReMA0r2ZS+INo1Bc4Ev7m8DWdarf8QC4bazK7TV7A5ENh0xnfQhylvae9BQKJePcDiR0efEMOrhohsflHhtlQcmm85UQsrUpDbv6LXGj6oOrsQqvrX4BTK5/lM23Kmj1dKrH+8iR0Qyi/65RBolaoxrS25m1AJBAp7JJqlCRrYdabTioqf+pBfCyAkIp+HlushvZL9p4BKL6vm3dclGhAi2TLBeErp9qAhKV5+lVH4nIPmYeirkaCXDD1UZUM51r3n/Ut81khjTgBskdqV7JMRNbiWvNuMepT3KDMHQLpQ9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHkGt+dvpMn2pY0COByLNQpx4eI2p4zHymOj5oeR2Vo=;
 b=ZHO7HPo0n/hcZUkmwx3NMA7fe1PtGx7pYoi2hyLSgYbDIj3Tm6+s1qbPlsmWC4D3H3RKkdYqDxh33PAkZjUjVyX0mKYd5rBgldPsnnLgrUechg0tY455mD338idZn46FQforxIbPjRKIouYPcg+kiuUVyjNvBG/T0qXjALg2fQP7n3xFHwc4+6V80IWrDJPKf/cAkT9ufPXKokNA+Esk9/s8l32BiPy/+GhHBo4OxAEy8vwZliQqVpdmaaJlKknbSmWDwOXwjN9QYlv+4/knG6sphaxmIMxAjj8Bz/jXp1XYW6YtA/YwZmjFhNH2gJKQ2kWTv1y4x1dZBlg3+G4zGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Tue, 9 Jun
 2026 13:14:04 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:14:04 +0000
Date: Tue, 9 Jun 2026 14:13:59 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/2] net/intel: fix blocking link wait on device start
Message-ID: <aigRl3bHblKct6G0@bricha3-mobl1.ger.corp.intel.com>
References: <20260603143407.1108527-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603143407.1108527-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0303.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB4907:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1fbadc-5dec-47fd-8119-08dec628fa9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bEOuPuNxDFkzHgwBgjsHuI3amOxEVPCWmq/E0GEnbn/X+ldl0jHGKYD/e/vQr0b+A3vfEUDVuU3cFy1LZ2sejkyO5AbJpp2BvimFzD6RttFbuzybvU/5Xam9u0W3mR2tKImytJ7iQVipCE7MOiEWfBRlcf3U+I4WH+ohAFZ0Fdquzp5/WQVg0VxsCy1ZkATErdxlSe6DsPAZTvR+k+usefiTulbkN2mFMseaZchh43QMlgMsi9B/wm+eZNVZuuoZwvIW/ytIRuwgRrWffXrRcQBbtrkCr+NZlsWCHaQEqwZ/0zkvhsIogLAOFFkJOKheCYm1Q3nHKtIAwAKYpfKj8NOkVnQssIpo8p5y8vVSAy1Io2LZNrK+P+v3B8xw6WDyPTDThj69Z8vwSMfG7PiTyqOP183AW74q0JfTXKgrHiDr78XSjS7tnsN2a8LZbe1NxrMVVryiK+x+Q3l7CdGGkE/lGeXDxrWFlTAPZKpj358Wl2wV1Fk1F4sN/aTWpxGZlXhMJyevmkPu44cDnzqAtdvF2wV/yLyhr9IufxlAT6xxHy2oIukNmZwtnn1JlklnU0lArZ4Lu53CrOVtdCcch2h28jDRk0Unu8vEsmQf8DlqCl97EanHF2D/w8jCeM1MCLkbeL5dw9m5j6uRlHcUCi5Hko/qp2OR/wNncyudSa2rmSD3sVH9M4Lb0boHoo8W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MaOzneu4WnhJ56Px04XzQ63qxxtQQy4QzqhFx9zzCoeMT8l5hPWOFUdMrn6p?=
 =?us-ascii?Q?ts3qjN6qv/9cE6y1l/92RYTEIUQL81AHA67rMU/RfyirSxw8amj6DiXcQHss?=
 =?us-ascii?Q?zBSj8539Zq0RtWyGiaAubLjFA0SlJGHm/PMWT+SvK6q/DWOjhS48U4PE+OM7?=
 =?us-ascii?Q?shwNxY9oj0c3hgXbzDaNFA/u4B/AIG0nChCs/5/MdXTYc0eOmq8q6lxDZY1t?=
 =?us-ascii?Q?xon1iJYWrCl6OnGmmB4WILeUNhvi3C3wtFhEIDF38XE2NMqJbD+OwMjYv4LW?=
 =?us-ascii?Q?BrLRzwfZ1oxXZrBKH3lFV+yvEt1lasYJTvc2Yr4z+LGe9rWqfrafecxOSNiv?=
 =?us-ascii?Q?UllIMQPD50rlEcY2z9lJjKr1cgEFw00HsjuAvzpR5s5WiShxwhSWctis0VP2?=
 =?us-ascii?Q?PQtqFYNIy5gy9FxXeak0DLXma2JKluiFEYxEUjf7i6tDskUcyxrR5X0uyba5?=
 =?us-ascii?Q?btEOl4Eclp4Ne1pR1kslB+e8HDHvZF2/pcO487vnE6zFEXQenuPlMDBtTv93?=
 =?us-ascii?Q?7I4tq79Cr3FTxNyNCgeVrSMCLoqtUS1O3gGXA673bhJ7q+hznxtfFRb3kIbS?=
 =?us-ascii?Q?WibWXicxN8ASPGUHbSEeUAXGJFKmA9iFX7rg7RcT+IvgAatnxNWRO6DvkI7y?=
 =?us-ascii?Q?zpc3Qll+KBFnyMJplG3kcFAW82GhgbcwkzBjO/T62Ep7dhRSGuLGD59pRYGW?=
 =?us-ascii?Q?9u20sXoMtV0HHA4tUaLLC7LhvV49ONRh0SGhgwjXRXFnzhyqi8gKms/QS6DJ?=
 =?us-ascii?Q?V1mA6H1dVm0di2qGYTmJ2Mz41Y5QBdCOUArjCbPl8HLDZo+ZENX14Z56xjmH?=
 =?us-ascii?Q?CTokvRxKVHlsBzpglzu1KeBSWOCtci2O7eM7/uZ1rnHf0iIHQpv3sxi7uxLC?=
 =?us-ascii?Q?cZbj3i+ljbPr825Ur97Mr/G1KaU5/55+vjdnvpNZrDbWMHpNTLDavhMHi/Sg?=
 =?us-ascii?Q?lAr6PYCVP6INb2J1aqvTFxhsrln6NtfYMX8eAAlRkTG9/zjCxuUU8RyCFVTQ?=
 =?us-ascii?Q?g+g5DixYzxq4guoQacD1gy9c0Ildb3gUaH7bXGqRIJzqRw3wNAsBxIba9/be?=
 =?us-ascii?Q?RaM8kobtmeVcKkQE63vdTxYIS+v7gMDaihj4bPGqBH+U2d0fy1hI5DQiozyS?=
 =?us-ascii?Q?QIQirLPYr9WGaU+5cu4CISAngReq8XhUD3Jp/Lq536b8jTl7CIqRugGzUts+?=
 =?us-ascii?Q?p+EDgjVfTHSQ7My6hODrunz8PHh5RzfaH6ZPHpA0u/Q4R0nxzxBwekYbarXo?=
 =?us-ascii?Q?TaZg/tOOZR1I2jxxzmWsH9eCRGv4Uuv/Ve51aiQmSWGW1gOHu2dP6JmEiM8h?=
 =?us-ascii?Q?bQD1QRYUvMrBlHRn/ChJJqw7+Y5FrmEiRFyrGRxb1nEGuWYKEIBGZbrdgur5?=
 =?us-ascii?Q?u9+GU+PUONdwM/Ol2LxBZ9aW1aQJaJgkLcWVud+yYc/eL1h3db5bZsxLDJuc?=
 =?us-ascii?Q?1QyPA6bz0N7A1gpiRnytQXAYBnedmNTwTUv+GbDQoOGB4EVIyc1nCuxrJb2x?=
 =?us-ascii?Q?WseDXtKJcjsQn73dzutvzvLPBGHKpsd9I5irejFdGO0v6a0hgnsPXfVN/WhJ?=
 =?us-ascii?Q?p1sS/QJnDpznS2xFJAbaG07DMP+NYG73yep2Omy4wajVvfhMFB14LU/vZp5b?=
 =?us-ascii?Q?AybOtfAYzTmyziMFyaL+oQifFn/mVdGm6lJu/SAPg396jwRfSt5CHWmcJnyp?=
 =?us-ascii?Q?OAcrB3oo7KQfeGrJ9YNri50aJpUNvj0GsmDLE6mebZyUDrlZvMuuFedYyMef?=
 =?us-ascii?Q?FNQYBgVLHfOzFsSlbBn2ULatrCEwEbU=3D?=
X-Exchange-RoutingPolicyChecked: ExHVYD/hephWOPiLmxmhv39Nf3rQRbiH+DKRNJelWtvX/25/TI4xCNI5dlLGpNmfTIZK/dU4vEdoc6EN2kusYntuBk1x6WB86y9qYSu8KuBNHmzwOKeuVOVEHUXpksSb+Srca9ILgNetOXhBaiQ665+0nJYic6K4AASykL5i1spUZOoovS5YOPEHnRH0aOoVSqh9iKjt3FpJpOn1l4SLMfG7NuRfxxlBh0Sb00FiaCAlj89IDkv0cKpox1VevRA/Z2MOyMV8h3QvvyJ2bSPjrabw6Z9lGifgZJBbf5Bxn9u+eqmo0wqGRIfFvPVt/7EYdKSmySF4F3CAdt75x+aCQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1fbadc-5dec-47fd-8119-08dec628fa9d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:14:04.1331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geCqInsKbU7+XL0q4WOsGrj5NaCx+/gawcIXduu56JskCDlDPkxHsycuhYCEWNQ6JEGZQ7itx/FwUxr24SjdRyhUivzMOQFP6TdVBcH+c98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
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

On Wed, Jun 03, 2026 at 02:34:05PM +0000, Ciara Loftus wrote:
> Device start in both ice and i40e has historically blocked for up to
> two seconds waiting for link to come up before returning. This causes
> noticeable startup delay when a link partner is slow to come up or
> absent entirely. This series reverts the wait in ice, and removes the
> wait in i40e while ensuring that the MAC config is applied when the
> link is up which is a requirement for some devices.
> 
> Ciara Loftus (2):
>   net/ice: revert fix link up when starting device
>   net/i40e: fix blocking link wait on device start
> 
>  drivers/net/intel/i40e/i40e_ethdev.c | 25 +++++++++++++++++++++----
>  drivers/net/intel/i40e/i40e_ethdev.h |  2 ++
>  drivers/net/intel/ice/ice_ethdev.c   |  2 +-
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> -- 
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce
