Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58908CC6B2F
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 07:39:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08E7D4025A;
	Thu, 15 Oct 2026 09:39:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B489240041
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792049945; x=1823585945;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=F1PNYOW8JxRyZhrWlgZjivinCjXVMqvtxjMm267y/CM=;
 b=J28ZAfF5Zt3TrDD5qrO3icfX2BDJIM+qAoqbngdFZUzWEThzyguc4tdf
 eqgSoe2FwRp31ah9++HGvaBXA6GZukfRXMoUzxp2u9CYg9DPxW6OQMuEn
 OT/o6o3ahFp0R88sFUwgqr1VnKi/QyT5bXHqhZPbEvK7SahZlAk5hSzaB
 jBAsgHlnGn8JnWHQFEGnpRHwKrUWO4P0RXsEJl3CJLjvaPq6wz5+rmJx7
 V7CNjTSwQExpAz4rq3AzZzM4JOLB0JtYyFzwGf+05dOFoNppebUclS/8i
 VrJ45LyLZ2tKy1PM2xzwlBODsFJch73JrqilaFRqPms5uwV42tdg/uWq9 w==;
X-CSE-ConnectionGUID: MlMN79J7QveaRileIxagVQ==
X-CSE-MsgGUID: sICRrF6pRAq39CG5q4fQpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="820471"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="820471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 00:39:01 -0700
X-CSE-ConnectionGUID: HNh6LiPPS7eKhQ52EIjAGA==
X-CSE-MsgGUID: I4rmZ8xvQuiTea1cVtt3RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1987502"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 00:39:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 00:38:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 00:38:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 00:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTjgynq8zvDsuhwuheOXxjGS1+j/KcLN5VOvTVtMMIbr+Yp4RnYqUmLNrtWaEkFBc9EBvpBsRskYWOWg6ehCjX1R+IRhx7t4QYBF/CdqlDH1Qli+q64RlqD5V3PWeE6QYUh1xqKXcMZwwxn4w4OVEPAAacImccWARUYMbA32cb6zqM1DmCK8OYBkPy3dq+GlUJod2/eBT/asNPvHRyNiEPY9QU+v7xN45Fvr7MJe+DqaQuXTvz1VASNVtSo2oKQfoj0PmDPreIkKEUyY5aCwJfAuk5BVRx4M+9gKmA8O694CJYvfeZXA48hCdOHfYkPQVmiuuPqPFsfMljXwGXYG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Gy2G/wJwVCQqMI1Vz848nsmVRBkjExrKvzCHgoKuK4=;
 b=dEw8RqVYYHHMRxf/tHLlJ1nn9o+ldotjbvwKY8auFlLYWFIx/sSg7KMT16FadAOh2y/VtMJClYJUF9iey2EnKZZ3rsrLz4+no8WXNIBX6DB97XxXwVoNy85FVlnnzOL1GjnLCxIeoR4HXTppZy+zFFTo89YaWppqVfbrOXTpL5CK3doZaiCOnh7YZYkyf6AChEM42OgFCzY7KfYdxaCN1CkNZmYKQfvzsgrBxh8vRju3rx8HlGB4FVW6PQuYKY63O1IuwFfcffAEDq43AGST6B/8ScM+RB6Z0UYyzjVLZJpZ2b1rjaawmF8gzjVtWR0A6eEOv1WcJdof0n+PbvZ+1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 07:38:51 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 07:38:51 +0000
Date: Thu, 15 Oct 2026 08:38:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Robin Jarry <rjarry@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH dpdk 0/2] lib: remove niche libraries from always enabled
 list
Message-ID: <atCDBq7wWE6p-hP1@bricha3-mobl1.ger.corp.intel.com>
References: <20261014192153.2693883-4-rjarry@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261014192153.2693883-4-rjarry@redhat.com>
X-ClientProxiedBy: DUZPR01CA0233.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a1ba47-0339-4fd1-2db1-08df2a8f5b23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: tNAq28vdRgPFGDuIo8m5ecNMObkLvdE2LaCogT4XhgLRXQjZuZu13ht4EsWAAJNMZohFOcxgevfg4nIWs9kT2gnOv3OQOLwY0eIncodg2KCuEp58LWFJleaqholYckNQtEnSztttJFi721//Uw0quNUFhANAhPkK4uFhxxrd4oEf3HW/8WXd6kUZqKxPGlk0XQkMOSqs7I1ymu86bvbtYQjImmlTFL709ttFHKbAoFF/6Kbzzsd1UhUW3tiAbhZbCtTEY4zsj6zFpcpKxsJZIa1CL7eZ814CSmcNAAbqjwuJTG7eUqQzYaBelmcxVFFUdyocjoWhlm7ux13GCbjvvrgDzxakq/d0regHVCdRA+PW3fVYcrzxmFxWEy4W7XyrFlfimukSTg9H73r7Cbd5JAs0uO+wJKTku2AYPa3BdEaGJHpknyB8ccp3Rs19KNhz8XIss4ona7HOvicPAqaP9JYVLucXTDc/p9MjBBsixhsuhhHWUIXIohYYrB7HQIIVQ/1uy1/pcK6XWmnbVqjwoosTfr0Vwx94A+vqlc8PWgzZTmR8Lcx+8LbYWXyw0Q2DvGF1KvJ01e2C52D2eZKE3HXvfXWhV9LSFUuKuGGq28UiBbd/UMEmbTPVvP+M7gYRIbWotWp9tYY8ZOjgVnn5YTH6zpK/K6GEKwQw2H0OZco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GnScCC6fL4FEV1XUcOvZ0u68emAUBHjBCnB7AV9NhnEOdoAx+pDrVn5AQQbn?=
 =?us-ascii?Q?7Jc7H0B7NJ3xQghoKi4OnbEcqTGnFqKwgc5eEs2kHzgzpQDAFYt078HoGHBw?=
 =?us-ascii?Q?WfZPziQUR4BXIyaWDeqVgYKr+qdZG2Vh8otAI2q3lc/fVU8jTZS+sDH4dy+A?=
 =?us-ascii?Q?vJw/vVmpG4seSnLLo1JkS4zexdB1NXqcNg5jKdEDIufWwevbZo+8CU20W+oC?=
 =?us-ascii?Q?JycT8g+hO0NvIgyOhMlAK12fcJKhnjH4HULuMmRKEJZZhogSKfi+uL5GvxE7?=
 =?us-ascii?Q?z9+uEJCtZ5VYTsHyN4093dmcU7YxQgBv9UZWWB/ZH5OpdoBJ4lIUwPxWxKuv?=
 =?us-ascii?Q?XsRVYMKX/KZBLtQimvlrhFE+BjiJRKlrpE6DCa+t8a1A9fxkM07zS43EgJOT?=
 =?us-ascii?Q?BJKV9yPgl9hnQgAmueaVq1JHef/ePdUMbFxN2rg55iGD0MFN4gttX2QRfQHk?=
 =?us-ascii?Q?FJ5EVNqV8hWg05I6b+1IXaiAFta7kOfvH4IckeZVea2B6idrHoZINgkUs93c?=
 =?us-ascii?Q?rDHD2CuUrbhL+PZ009LRKt/5d32GJ+08fRMoY8OmRT9+bZ3m6P09VJKkFuyA?=
 =?us-ascii?Q?qtQBEydm4v7PNGqq8W/Ca3Kj3m3nyNX8NY/aJtDU/M2Xq4e6F4jcG7NtSrYQ?=
 =?us-ascii?Q?WiTSU5RGpdNBzSaKvdFsNvgfDdUC2i+v30o69gve/MEmq+RHhoynFZK+s9GD?=
 =?us-ascii?Q?fIx5xP6R98s1ysWgNfkdN2USYUM9QrX2JopgynnIQW7BHM4MaMBAc1N6LztF?=
 =?us-ascii?Q?3/+4m51tf/29g6Nqf10TCIR8zlEILSbDoLHbhHZXpcSgiM+mx400HcL6g//C?=
 =?us-ascii?Q?lQ6UaKuf1kRbksbJxELVIUt2R2uaV4Jt+vok8z7rKDtqeN8Z6Imyhd6ZG0QQ?=
 =?us-ascii?Q?2Q3BLr2sd2F6jOMZ/FbSIWxKN4CNi3ugSVZIe/u4qQjaFhLuwIb5CV9ZwmhE?=
 =?us-ascii?Q?YsblHmFfceXfRd2gcCH//yopNdRjbSxH2m0HzJheJHToUc1L9CmCVVyNJaXm?=
 =?us-ascii?Q?TbRaS9alA5qC9A92MEW+MmvTU9mNlhSPim6MJsQ/8rqx6kdeMgJRrZsnjjA1?=
 =?us-ascii?Q?jcGMQUPRjWYC9p+XCNTuqov7O5UWB2v4rC63whJq3xMBBAkiOUrX+cOJI7cl?=
 =?us-ascii?Q?CNEeK275b78eDLio0qxxca5k3oQ9yN+XGaV0389SKUcX/4EymcbmEtMZUamL?=
 =?us-ascii?Q?LVkgpY+4/+pzJvMfvxFyLzFJELTNg45Dn1SfWCY84P04waxb3UveLU/XhtT7?=
 =?us-ascii?Q?mS63OtHDuRKNpazcDa3SFKtl1j97qCoyplyrkYEXASn0SUMX+nHGfpjKSM+Q?=
 =?us-ascii?Q?RE/Bsy51OM8YGJMGi34T/vXpkbvU1Bpz8/ViEjQIyik3t6LWTIC16DzSJpFu?=
 =?us-ascii?Q?EsCYezy6aexu+OUGy9XPiOKMnCVmZdOmEuC9f3Gr+9JzTmOlcL0I7THXWoof?=
 =?us-ascii?Q?4Aq+kgX5vQDzFJqI6aTqDkCuAoAQruPGDK7Q00ldhu6pVGD4FBsWN6b4DZGX?=
 =?us-ascii?Q?2QrQN7+JbHRVEAOGYXy/VFOTe1N8dlMYWFVQVwrd5doBkYRvJCgizCsCilpO?=
 =?us-ascii?Q?AyXjibwvO8TujGUPs5wEE+ILXPirD01cAay7EbmL44IAUREVkTgc0bSIQCYi?=
 =?us-ascii?Q?YuN3Mtx4wbevukpQv7d5i7ZS2SX6UyyJs/7MVoln4sKP3gvr+/E9dzkDBweo?=
 =?us-ascii?Q?8xbJT57mPbJZ1mM5retQgkSy7Mw4xYW1/r/SG14lxOZ6FfzbVwmCUqtO+HWQ?=
 =?us-ascii?Q?uXQyLN9NQUqTqCW1ZNMkuUqri8E+zXY=3D?=
X-Exchange-RoutingPolicyChecked: FZPTn/yNnLLzm03Necotjt+puSu9O2B99wX5LgGDEFvui9u9QtGFmXxryE394ZUdkDwbIwK8fl9vEbTE6U6peiPCc/GMHqdPJlOnz/i0VWFzRLvNsKNhDM5kE3lTFqG/ELON/nyRUu/uVKMSENKp/32wXN8UGnkrXO+WgHF7YscT1hiL5IF+HfavMx6ZZE3taL3ACboPSIXVxLFmpGaRxpd+vieaPrUj/+Igcs2dOFsGb254UhZxeVuW/pTE5lT60Mh4diXMXgR3lsikEM/fiNfL1trK08pAq2B2r7pYU7osmUtNXTkbzHa0o0DeVxkmO1H2Ky/DE+f6XiASb7SaHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a1ba47-0339-4fd1-2db1-08df2a8f5b23
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:38:51.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNp48eXK56dmRVBt39IzTH6thRS29zfNOABGQPE5MzvGqavukXOuNF5ey/svqaty2Q1LdkNAVzn/3AContQrkbroE2t+S24JljAwDgzmVmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
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

On Wed, Oct 14, 2026 at 09:21:53PM +0200, Robin Jarry wrote:
> Some libraries are only used either for internal apps/examples (cmdline)
> or by a specific mempool driver (stack).
> 
> Everywhere they are used, an explicit dependency is already recorded in
> meson. There is no reason to always enable them.
> 
No objection to this, however, I actually have a more complete RFC almost
ready to send for the next release, which goes even further than this by
doing initial dependency analysis on all components and using that to
compute the minimum set to enable. Specifically, if we assume the minimal
set is EAL + whatever is needed to build the always needed basic
infrastructure drivers, the RFC finishes by computing the lib
"always_enable" set as being the dependencies of
"bus/pci,bus/vdev,mempool/ring". [As for why that set of minimal drivers -
if we omit them, lots of things in DPDK won't function, and we cannot
guarantee that any other components selected will depend on them. For
example, nothing else depends on mempool/ring so if we want working
mempools we have to have it in the enable list]

I'll try and get the RFC out this week to at least get the conversation
started in advance of 27.03 opening up.

/Bruce
