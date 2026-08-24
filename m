Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7D0C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 11:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F4D4027C;
	Mon, 24 Aug 2026 13:09:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A47F840270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 13:09:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787569743; x=1819105743;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=vmlGu2cDfcDCsrsMGxvZBoNYIBdXgRPA8p8I8TmBCDI=;
 b=ZPJzuHnRjyt/eS+sYkd79xXm+U9/LxeklWcZoxjovxEYUSIVWURp3HMb
 MqPEgItBIupbuAq/YN2oi++p3qdBD9snqlyqsc92hdNh/Du29au+Fx83T
 imi2rv9YO43Nx2Qv0hA4VRm1xeFL/a68+UAJ0P9DAx/jxOHzc6kK9Uaiz
 y/9j24ILDTldsYMsNl9OYZ+kIrE7Agz1FWD6XVTmmRpDXrRDILdZUaC40
 hVZSUY30MqFz6mVCHy2EmQPWEQfNfItr/m0/NQa51fTSK73KS7AKnYPIu
 EAuMN9fe0HsAmJGCy014i/cw6UINgjz51tJDboxhFwz3++9qRh5GEOLMr g==;
X-CSE-ConnectionGUID: w/DeMUSNQPaGx6pgFQoCag==
X-CSE-MsgGUID: WNW3wK+jTmCV1HcHbbTeQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87938626"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="87938626"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 04:09:00 -0700
X-CSE-ConnectionGUID: I8Fk1GU2Rh+FJYZRtaZFrg==
X-CSE-MsgGUID: jwBkzGGtSOOZdQwZn1rKLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="267018687"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 04:09:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 04:08:59 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 04:08:59 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 04:08:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9VdlS6RP1UXL7PW1k3lorxcwPDiTc1JHTm9LzxJfTOKSi/hEhk3oOJsMAq+gJNxhQzFzcbKsjtVWmJi9nkysLLjowe0GSC+xR+MLgaVYFN/JjPnmq/1TXHpc+vH/3oM0/q9Gov+g6djB81CaQWVFi8kNEuvKakpmxYH7y0DaPcL2UlU2FYBAzwxIt62DZKj3q2j/zU3dovZ9DfRVNNaxT7/ZD7FqUSRERZY3TEJCF2BtYHk8ZUr9yLIq8gn8sQ8OgvVwlBy4XiM+7WlqGRGNlrB+lhJLC6CkRfO9Ih3Q4PdwsEt/+f9rACmgDL9ju20+FI9bQa5v6EhzE0K6pOW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WsmMmptHX3jQukhftiMt/mQWhzKWfroQpcve1x2OxY=;
 b=s0HxtQIZaLu5MIg+GOojZkCZ6jO7sky6aUuZDNufl/5/OBiHo1xxg9zJxt3eX0y/RXRxO33hU0XK2r0mlBuRxc0kEkZeo2ybWyZwKWl4GTy0F8xorJrVpf7A0+nrytDzW70djIU5rzHnTLr7frk9Sthc+Gfma9a50LkqsX6yXUbBYSG8B4dXkAJIfLxnMdV0Pdp8EJJN0WFCw4K5LCYI1Z1TpAPmTXCzYKu6N2AuQAdU89wGUbvkYYRVSXvM4bs0ZeiCSQ7LE5cbJFJOOiVWq5xH4PL1IS9vfkPdB6Y/Z9HAJryQemRWAvvLMWFiXNphlRveO91OiZzwqG9aJnfrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:08:51 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:08:51 +0000
Date: Mon, 24 Aug 2026 12:08:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>
Subject: Re: [PATCH] net/cpfl: remove unused macro definition
Message-ID: <aowmPuZLglReyKnW@bricha3-mobl1.ger.corp.intel.com>
References: <20260820080542.3414447-1-bruce.richardson@intel.com>
 <CAJFAV8yg9wgPuMsoZPwQfB=bHo1WD8URb_wtJ=w70Y-j3jeKFg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yg9wgPuMsoZPwQfB=bHo1WD8URb_wtJ=w70Y-j3jeKFg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0122.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::26) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8253beb8-24b0-4953-7f07-08df01d013ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6c5N7DRcb7qcSmdkeWm+sZPVs/9HsVa2XLTtSRHEh0cMszg7SyE+ETdWHz8ml/k6zQNIYkYQ/PSI0GE8L/m4mnkEoK+u8iM9ryd5B7wy/A4eC4+M/5l8MvQRJczwp0LRG7OJLAELZPXQJq7WdOHpk4/7+UoRYRnw4O7Qy4QjwA+M7uIk9TCCYX3z/UNPdqNoLZxyPqK18hLiK6RhmtjtnuXB3eGUSDcCneDKCG+H9cvqhw0LO2K1e1XPr4pikaAb/fYx6ujVEoCvd50ig1CbTo9CIUBFJUcydEigP0ByKCdCWBHTQ1BhBF3lLXcizv6k5zyy3C3Yukt/+kgaRoFx3AS5PE5bAUkipJYz+uKSIMx8Gi0v24V/4ninE0+TBx6loSburyTuJ+UL6kkq2FX8IYF0qDOIuBT6OMSG5lUJCywk5EnPQ2rcldAVjO0F5iZo6EZJa30JpIej2m+FQdqXcKJUtLZwVaQzOuZ8E2vNmlhnyuHrKJbjeHRs+PlRKFR0MLtr7EKOjJkIYhhtB+L5y9/rX/Kz6PuE/IJ7YHLwLPeXYjeidgNX/mqSthIjI4l1hEQjLDYQjAR2/oPZ/qpbK2vue7WsUhcipFTKKGG2Ojn0nPOgOqOSyp8c1B0BVC464felqaMrghEbxL1JxyFcENr8W67Gsg1Mqojzk2T3P7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hHnHd20JzCox8izRkZK1p9xK1FzOkVvRV1IgNGP5j1Ydv3OA3SEClEUaS8Rk?=
 =?us-ascii?Q?YaOy91Yyy0KGQn/YZ66UvYMWcgCaIo+W3AtkDRKexke6MF0DmALIx4cnW26j?=
 =?us-ascii?Q?rSmm0vnFY/wyhnCUbS+rGqZvjH66LHFbLhiD801G+FnJKfh9p4e5b0zkAlPY?=
 =?us-ascii?Q?W/DkKuza0RmAwi1nlO64zTksc68lp2cSPMkyQixwKWQzr/fGYlPs/hC8MjlY?=
 =?us-ascii?Q?Ib6nfwnWnUT0e36OLMAKYxAHNXUjVbekypLyewYzH6Tmf41r9XcSPRFkYMJT?=
 =?us-ascii?Q?N6ThvfwfJ/BS+LdMmcWrx8M+Z925cpbf/6/gKLuIMqx9c+E//kNkPvOyS9wj?=
 =?us-ascii?Q?P1haHi4vT/YTZ9XIwEIyEYXNR3lWd/wK5Oyr3AjF6N2P6FyDwdd1Bpc/KOt9?=
 =?us-ascii?Q?YlRa1hJvQ8WpN07RBEtdikh6gySmnkcAO5TDrXpiu8LnRoH/30rY2hFbW1VJ?=
 =?us-ascii?Q?r54sLVAsAlJL+mWZBPRLD3lTdc5jT5+OccIzG1w/w03izmzgRqCPxWHSBMYF?=
 =?us-ascii?Q?Cln1teCzq1af/+UVjYulelkPeeL6ePvZmMp0/u3nQmP9Z5wemGBkfEs0Focq?=
 =?us-ascii?Q?FaHbYnoWAx9BO3VYytRlvV97htILTuS8hQ/n7tiZJrTbwY1OIiqw22Kzjrl0?=
 =?us-ascii?Q?Cc6Qgdxqg0lmXtVikYbpzTO32Xh5VJuNfrSN/d53s0k7IrnL9c7bPv+iOGxW?=
 =?us-ascii?Q?FMqrx80UGbumtRt9ZFEvdJHV/OOod7UZIzMrRLK/Y55uVfXhNt3ZPp0Xxre3?=
 =?us-ascii?Q?kV++3nvHKsoDj2QoIJVk2jmQCok6omTOrHdukVHeTMmV5QyMJ0IkCXRlV3sv?=
 =?us-ascii?Q?PaK7mPtiVdU6r+KF5fOjV+9+N5qQ8NKi0M737Epiec7DkNZbPqZDmuY6g2lj?=
 =?us-ascii?Q?nSXl7Lz1oNHrlDO15RbpI3Ihsxesnajh6WM24kRZq3BNB0uQeK0LpP9MU2lu?=
 =?us-ascii?Q?v9ZHvtLIalCJy1W64R7NIQaCTFpXEVUF7jjJv+uwfDWqxapUn4pyDIXqNEK4?=
 =?us-ascii?Q?Qvvpvy4dRIIuoNunGkdW8WnJpYSpoRSssSxLKTR/P9RjIBw0z8NjwEY/gGMH?=
 =?us-ascii?Q?VcQX+R+nxrX1NLL5Y/Y8kmVE5J7EISmzqOxkDT4TDQWoWUR83Dp8Ha/vdE6w?=
 =?us-ascii?Q?sABzG7BNOhaqUr26S3EymUWR8qfY5wPkj4rLpiufsP0UXHdxyh0FFAJIpxg0?=
 =?us-ascii?Q?pK2bjDOCGia24dA6VuJ6iXJqRz7jMGaWhX6bSP3kUtTCtLJMhOYzBHkfbfLP?=
 =?us-ascii?Q?HwxIoqUhjsHrfZNdBn+nbZ0QrJ6ZIlNWtySIUtVDcevax4M5bBk76St/Yy7z?=
 =?us-ascii?Q?kgedXnWF4418o9FHAjMYbDfVl6vzLmQn2+49g6+8Om5SkuXq8JvpjxwJHRyF?=
 =?us-ascii?Q?TNb8v/0bhnl7/EOC47AjrtcVz/HA1IknSr3USr24vRb3Y38zRn1HKRfUsDAQ?=
 =?us-ascii?Q?+ydyQ8j9gwAt72QzjQ/lSxJmD9rROpLR8Q0kWZIScWBcVCr+sEYqsS0C8v4a?=
 =?us-ascii?Q?Ar8bT/U0+iFVx6L5qQiZh+V6c/NtvCs/jzAzGUIsHS3hcHDmfEnb2M47dObj?=
 =?us-ascii?Q?ZlV1gFRt8X9MLc5CZQ4AAaTpTgglN1R5D7ru7v+JSAUXMMUIsajy4InIwtOQ?=
 =?us-ascii?Q?i1DpyRFikY2B5GhWOhtlEbiam5BxqeZIDkgM8VRTujsXkkfoQpOUC4eYSWwY?=
 =?us-ascii?Q?6GQtL6hn+w5aKxW34gVGIdJE8tkAl3eC9qIY+ZtxkPrEpum2o1vOaUon4d3v?=
 =?us-ascii?Q?ym644U38QTv02GXbEYF1omnzGcbGMpA=3D?=
X-Exchange-RoutingPolicyChecked: gZK317Qr54aDA82acv9IcdOiIPnEhYAga6pU14s0dStk31WQQ9dwpPgQfO57ZJ6Ea+aPrB2kCWnd82EA1O16kDmLV2aumOwenpXthtgpVoo8tP9+W3yC/HGTe8bRep50QSy73F/ndfDD1uQzMxpsKNQIXAihsN3ZESiLGwX07I2GYu0hm3tEXx2zrstfQ231aSozW6jbCUVHQSu7qoDZtHG+mF1k22SDd88QX5jgqd7uO8RZ+VcSSUwsRH8KEu/C1udMJoN9DIxiGYLYdvnHNJkWEzBXMvVwBQ8tYyTnUTrtHqyaWN7AfbPmy7gsnGRFny8WOk7tJy8FJpGjVXtWig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8253beb8-24b0-4953-7f07-08df01d013ef
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:08:51.1436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEVciQoAd/3zksNRjzv6S6g/OyoCXjIKZSAM7Sni4CN4qLCALzXTi/dIIFC/GnZBv41xPa06Y8lieGl6gTFHahXGjRBJrfF4BI69GJ7hGRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
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

On Mon, Aug 24, 2026 at 10:06:54AM +0200, David Marchand wrote:
> On Thu, 20 Aug 2026 at 10:06, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The CC_AVX512_SUPPORT macro was never used in the cpfl source code
> > files, so there is need to define it in the meson.build file.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: David Marchand <david.marchand@redhat.com>
> 
Patch applied to dpdk-next-net-intel.

