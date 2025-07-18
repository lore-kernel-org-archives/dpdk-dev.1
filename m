Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5ABC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 10:51:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F5054014F;
	Fri, 18 Jul 2025 12:51:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A76B54013F
 for <dev@dpdk.org>; Fri, 18 Jul 2025 12:51:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752835881; x=1784371881;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Vbgr7XKvgDOGjDb1b5d5Va8UgD8ejJBTIaZ2S6FuszY=;
 b=X1PZhOGLqOhhH5JLTKqExHrMWsbBNe6PCllhyr5yQEZUroXfFCnxWJXU
 sftXeoFiQfhtgxuwRkayuxFnkbLaJDghUn1OH0d5pDk4QhfiOGDCFT12L
 JaJniKCSck8V7KN5HUiOmdZ2zEvXxKWGRT8BhH1iClPO+zRLWDXWAdpT3
 rKJcZpx/fXMQIK3Z+PkVJM/cflWH5kw0Z8iDl5V2qbGoVc/MjndXYAQkV
 68gqOLotFlbzOVHSSG+Z/eQG1MYjXKYJo7s5TDrJR0weFGThztrHDq1PB
 auXmdUiZ6vsxwC9NVUiRrcCpc834Y09H/2+E7jXeBrtNt8cZYsSI4v1Zc Q==;
X-CSE-ConnectionGUID: S6OqKAlcRVuTPWYiqlycxg==
X-CSE-MsgGUID: g2DNtNC1SK25vYtIQwpBTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55282265"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="55282265"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 03:51:19 -0700
X-CSE-ConnectionGUID: BcfIA9uOQoGHs8gwJhZhzg==
X-CSE-MsgGUID: XitIFBkeRs6eubPrtA0CNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="157416738"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 03:51:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 03:51:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 03:51:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 03:51:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNCBKPPW5EGVOsOGeYW6BNu2lw5ij1zEAutxBUt8RrRAkAar2bOyx6qMLMmvYPagozkdZQZCY3g/F5vOQ0eKl/LtAhGuTw8CgjFLEgn8sw+h/Kz73PcYSz2XTf60H/j43uYarNV/D2gnbNWJZJb9OGgpamAmrHUV+Y7WPk7LQ64f1W83D7VZjcdaQQTX3pk4c5WFBQ1Xiwyf8lSpw0iA1jhzRRfpFjd4Io7sA9q6dDF4e+TrPkZEamVqIz8IXGHekjarPEZF9AX430xShyKDgmc1lcy/kuz04C14akWxdSMGJqpo72t1DHNZbYMoEAXE3uJI6LRpaM0+X+S8WRezAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU18X734fWkRrwKwmmtOosOC5e7Z4ME+X8n2xO32cSs=;
 b=OCG5G3/TCLI5N+ZDMIrFd08UmOqUmyQHM8kQvei15K2PvdzC4qmOT8cLBSGzTiKOTTLJD0uC25D84iCWdup+U+3nC9+9PbZdclQU8TtdYUflocV8azPAUqjdB0BzxmHp5pIGnDNdm3J5Eyv8iuKh3UonF/9fJWphPd5nr6WZ2zdgxUTswxpj5XH8CdKt7VyQDvO9CvAy8c2xdhJew2zcdb0lGQMyLux0XyUYqWWieQQ5+14kzhQ7U9erL1Wz0mQFAim1xr0uZWlo7DWgkNjlz+KURfu0XrInQIjQUByEnZsuw6TN24CRiOiiaTF4iB6eSNjki5xlhUCjaudzcZJnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Fri, 18 Jul
 2025 10:51:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 10:51:15 +0000
Date: Fri, 18 Jul 2025 11:51:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <rajesh.t.puttaswamy@intel.com>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1] net/i40e: updated latest recommended matching list
Message-ID: <aHonHqcvpaipUnkZ@bricha3-mobl1.ger.corp.intel.com>
References: <20250717061604.3288049-1-hailinx.xu@intel.com>
 <20250717061604.3288049-2-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250717061604.3288049-2-hailinx.xu@intel.com>
X-ClientProxiedBy: DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e2cb5b-5f0a-4f92-10b5-08ddc5e9047d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IWSkx+sz9SUZawO9MxLP88NUxfWvR0jYjpNzAJVCLFq6apjAg1H+A5TEX/KM?=
 =?us-ascii?Q?nKdqiXkqsbgg0BzS9XFQ3HkZAeNct/Q6Z9KIwy+hIDY7C6C0upAXIwHucEQK?=
 =?us-ascii?Q?opKeHVMPZNros85mdrfvHtCjqG74hi8CwFvgE0rUwkZwOSvrkSJpAvCYUWSH?=
 =?us-ascii?Q?PqFKUwc9mom2AqF6uh7S/qJfACBYUhHcSJIYsYwmaWVdMDdmtDBmDLjhzW9W?=
 =?us-ascii?Q?0GnZiCSFMAMsaTOe3xyVfuh6lafivYr26/Nzvms+u1aCNd1fkLSjoGz0lCzF?=
 =?us-ascii?Q?BLDIp0Ll6u0sgK0OuaTwHXdoQnYXMx67NEMF6SHkBqNeA/VqZC3OTFeK11bx?=
 =?us-ascii?Q?4OhNFzi7B+rbA2eca+wUjeeZiZ/SUK+t8C+1lhTIEdZKeuIW2EiE0kzK+c2j?=
 =?us-ascii?Q?/NJAbocOCx4r7zUutaMNz5lQVNk1CaQmByjmETrdmg6XJGzykQGm7qw/DqkO?=
 =?us-ascii?Q?gejVI/8MYcpAVFr/i28iwHCYECgTCsCs8Q09BJ9sIrQp6vyA3AgDvQAY31WE?=
 =?us-ascii?Q?c+OHAH3fP+IvnViIIEgi5SQ83pwd46tgtChxcI18ECY2OpxlwhCGggWe8Dls?=
 =?us-ascii?Q?DaU4w0TkekyN6zBJh6/7O01gIgogqT4YKxqCrsXTmEW+BLNKCSfoJVNl65Tv?=
 =?us-ascii?Q?QPKthGz8D/6mO11Qy+Xo5CW9SpX/XsoGyJPM6Mp71x3jcr+ASAk5tjQc1TCT?=
 =?us-ascii?Q?Ni1fzlX6U990fHVDwOe8fwA2Y4Bd+R3bvYRXaCnCviG8Co67ilfsOULYu3Tl?=
 =?us-ascii?Q?DyYBMZjrPtVnoneCI2MiNRE4YYKyDXEoE5rot+0bojPzL78+gflscd6lqKAe?=
 =?us-ascii?Q?EcVHWj/RdBJ6sTKr51ZIL0UCcri+WmWc6lFwkV6AuppnfVcee4hTPkmSxEwR?=
 =?us-ascii?Q?N2kuI8FSRhd/TcUTSCZyIqu4AB51cmMfbQyRG/jHpPj4e9TEpNAB8y53SwOc?=
 =?us-ascii?Q?GHOu4Nd+NFDgA1mMzskyUCkalsZ8676+UtNPs87Okji85Ct0/inuNI6Bt8Qu?=
 =?us-ascii?Q?Ol8H11O38YoovLpCNSWiPQvpw24EIrWSrm42jQseBS3Ky9G4V0ii9y2e/iHD?=
 =?us-ascii?Q?WCQZYkw1pd51ADQ8M86EoGuse8vrP47D+sRiifuuJdSOw35rphhv00BZFMj8?=
 =?us-ascii?Q?6DOjN5Ha0ChfqF8dYVjMkD1PQ8VSu4S2RU1DtzO1J7y0I8CnS7cfE8pOefeu?=
 =?us-ascii?Q?1CZvOnd9NA0lKaQYxJKHBL8DHTo+5fI0rGv+c/VVjtCqg18YUCT0Kt6uzqtZ?=
 =?us-ascii?Q?IWgfyf7YhCv5VGlbclhOxLywNrGF2BEeTpi+3wN/2yhXh3dC6QCbfuHsdSWg?=
 =?us-ascii?Q?lUh4uYLeRTMUAIE7vrjhT/XcNQTzcs80to7SobxVz90aMvn9k3NXPECzQE9W?=
 =?us-ascii?Q?KzSZ/eNYoKfhnEYVvqs/c8Z+q6Ng1sh0mKBVA7jBGfeQ5VQ42SVdXmTwuYFk?=
 =?us-ascii?Q?kWpIsMhB80Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CI1B6Ezf7MQtemuLaHS/N7MefPr2oHJgSV78lh3H+wdjiSS4pqsBymAgfSda?=
 =?us-ascii?Q?4fcLQoFzl24JnY3uxiTMeMCNEz07ndRwS9QQW1wqpP9MgcKuxiO0rmK4kbcA?=
 =?us-ascii?Q?dvDY6Im5PhSmDDy0gc5fqlWKzgutPEzfWQ9enhkhlBhxIY7nFI8qJn8HA22U?=
 =?us-ascii?Q?yqvUk+oNq+0Un1j7x1Xfcfhh8C8DL7fr5lm3rpjsYD+lkyMSOAFx6bWeyAHe?=
 =?us-ascii?Q?MlKYGTPBmskT8w2T+9bsBoCB5Te3e7NrBcDw4/wcjvG6zoI+9BGIdHsarhns?=
 =?us-ascii?Q?cTvd8prHtqfExmb1CrZ4fr45HIattyc7IxXHggakOtwQUc7rugNwd2SsDYc9?=
 =?us-ascii?Q?T7ebQ3/wkKMesInUDABkqVC51zQN05A9N6+y3DsbpB7WRi6rPUgNhnski4rr?=
 =?us-ascii?Q?FagSiAj+S9C+Ust3FDoSqbcPL2qjFWQMWwC+lS8v+u49I1lo2zbKBNZKF6x8?=
 =?us-ascii?Q?dNl+wi7QBm+zKIy6m4i1oS50xJRssWwnIc/s/H0CiyJs/U+HfXV0lEeEN9km?=
 =?us-ascii?Q?npye/g4HWwQi6nVw4zQqIos65TftvNCHvsbK03mTphkd8mwy8dpmsteYBEcn?=
 =?us-ascii?Q?T4+fvmNWgM/GiFJVoE61ZCUqKVJMs2OksVuCAhwodTbziwiMaFKDVRDPtHmO?=
 =?us-ascii?Q?bPP5jd8dmGmq9CGDQDPz0TfoH7svzcS+yY//wcM28/s7acQy0wJ7pZZpwNa3?=
 =?us-ascii?Q?DDi/qUJahDWdbbIDI9QL6w9UKpRnzcP4C3o8RL8bJu3grjPT41KW319NIkj4?=
 =?us-ascii?Q?5wPs8z8z6gMA0f2gabJVctQfqDgVj6uA60kt+vwd7JMKtrrLVCSeLj/kt/Ev?=
 =?us-ascii?Q?rDzWQ0i2ULFsX1qGzIwLCZZDv8VfEusLfSCWeXTjmHgSYaqMAI3zvvNr1wdr?=
 =?us-ascii?Q?l+Px7yrD231IkBi6VHGlkkeYFV2/lZKzYkqmpxu9Met99YGT3zXZbSJa1WR4?=
 =?us-ascii?Q?r2q8yxf6XVXpwH5nuYzSykHUkY/D1msUiCF3TxyjDrpP/J0GJL60qwqh7XS9?=
 =?us-ascii?Q?MyAoH4sciS5uKv9r0YI//HI+kpRcK9mNqiZPFgiswNgsdd85fvOKRdulte3L?=
 =?us-ascii?Q?m4Nj/3GnM8isSsNuySyiW+aUAISBwR9Pzv686ixvMJqJ5SD2uLnHz2XNQIOb?=
 =?us-ascii?Q?wZGVbsdaQ+B/8gHv4mTqf5sHbVjB3UKXrq2legHhOxCoujz2qPpYx97I29Zl?=
 =?us-ascii?Q?ET28fsdqpxlSKFiiHbL0igin/dEuHKC2edRzHANe3kFfAXqmokVFlY5ubYPR?=
 =?us-ascii?Q?uKVSE9yiKlDilwIvRGBKIQ5oNw5RhZbCfdmpYkVJxbaPyaZRpXcEpDZBxJqP?=
 =?us-ascii?Q?6c2ygy854HQGublLhnAbfZ2hBBnK6gfBzi2OHEIVdp7XFsOsxN4zQ/FqZ+oY?=
 =?us-ascii?Q?9VW3xBI2X8oXCxfkIWUTABQXiNH5/yg9vzyGjkuqzQyHZSnF7lvginp/5xGc?=
 =?us-ascii?Q?PI8flgAMLdrX3TRSFn70zGJC+lEvvB0vNinr/+qQwkjYwy4fw9rjueKf1+QO?=
 =?us-ascii?Q?XcfOOv4OMDoUh6MYMXE5QbEDUWUFh5sjUYTM4VndUNGg15V7zh0xTueD19vE?=
 =?us-ascii?Q?ZAADiA/IPme0MlontLhqf8P/llz3ixvAWba40KJyqqY1dWbFZglwA/g/uBUK?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e2cb5b-5f0a-4f92-10b5-08ddc5e9047d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 10:51:15.1962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8+9sQagYBCNLQh0OKXfMpCduNXGdYXCixt41gCzDT86D1504baFqyRwicUzxtE4QzRmbjBdT/7spjat5v7wVediTwV+rWBPebW9onwEDQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
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

On Thu, Jul 17, 2025 at 02:16:03PM +0800, hailinx wrote:
> Signed-off-by: hailinx <hailinx.xu@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

The tables in this file really need pruning in next release. They stretch
all the way back almost 10 years!

>  doc/guides/nics/i40e.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
> index 234757cd7a..e7db6f2416 100644
> --- a/doc/guides/nics/i40e.rst
> +++ b/doc/guides/nics/i40e.rst
> @@ -104,6 +104,8 @@ For X710/XL710/XXV710,
>     +--------------+-----------------------+------------------+
>     | DPDK version | Kernel driver version | Firmware version |
>     +==============+=======================+==================+
> +   |    25.07     |         2.28.7        |       9.54       |
> +   +--------------+-----------------------+------------------+
>     |    25.03     |         2.27.8        |       9.53       |
>     +--------------+-----------------------+------------------+
>     |    24.11     |         2.26.8        |       9.52       |
> @@ -177,6 +179,8 @@ For X722,
>     +--------------+-----------------------+------------------+
>     | DPDK version | Kernel driver version | Firmware version |
>     +==============+=======================+==================+
> +   |    25.07     |         2.28.7        |       6.50       |
> +   +--------------+-----------------------+------------------+
>     |    25.03     |         2.27.8        |       6.50       |
>     +--------------+-----------------------+------------------+
>     |    24.11     |         2.26.8        |       6.50       |
> -- 
> 2.25.1
> 
