Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06648CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 11:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C03F2402E3;
	Wed, 24 Sep 2025 13:26:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4F5F2402C1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758713207; x=1790249207;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=hNJ8j7+mhbspeUe9LKcb06sgK2qq2W1oCzUbG+EaPMY=;
 b=c2IVe+t4AkhOQ3DX+ZZ4ehcQ3dwv0e4u+UYe806aNcLOv7ssz+oFFgBy
 ytFm/NoKev2N1bbEJdhdCeRm2PeTe+cBDrb3pI5TRwC1DYYu22o0ZynPw
 0/QKt/L6hsw+Dcq+75duc+wnAQ6rVhY3T8po5za5eGSiYM1wuQxwnmEwJ
 tgOTtf2qNvpPvoj9ztDypHimQZUc03KVIcAhWUuL88MgkvG+6BB2I1oQ1
 03ratWmYpOekTWpEEjMtPnfwUR4clvaZ3PzP+0UqLkToLx76447zM96P1
 J4VBERgvhb3JZ4tn7kdrM8Ec2pdAr7aW+0aVt4csAhdSMkWy7FzBzFAeo g==;
X-CSE-ConnectionGUID: 9IiUMgZBSxyzn3fWx+Ic6Q==
X-CSE-MsgGUID: dnjYC4/HTZqdHUUm+wdhyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="48572625"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="48572625"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 04:26:46 -0700
X-CSE-ConnectionGUID: 3uBxhyVdQGi/oE9gZIdRJQ==
X-CSE-MsgGUID: PYgXVjvDRrS48SXAtfYUew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="176946314"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 04:26:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 04:26:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 04:26:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 04:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeN0fx2Axp5C5IVCjvUv62ZP45BwANWMek525RHEOoxDY+w4g/6YvJRUJUTYLQXCMfJrM5r0fzNxtom0PYpUe8XVSb+sATVo6HfapCgPmX9FV15dXKBFm0OiTTeznPitP0/cK5wI0l1bIu7UeaIlTIb5RMsQhe85kClX6zKVQoWbzbMpMbamBVj6D2iuXh4kaYiS7iHbY8cVkkwk2CbhrikyyzowF0fbsnDaQq/eqWTF7d4KKRIMnp/osLfQ//dnABSDWIZSkyPDIjVXql4cMjdA1MqYmdH3KVzN5cibbeYyoDNy4oW5m4A15PRwJuQQBAd08JkHjVCKS7UFT0vyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42Sg088bd9727EL21HCPKXTzJRRBjkpuLrR7wX2ciQA=;
 b=lRSGXZEDQuYjmrKFajLuSNeWM7pbq+J7/rwtx9E/qdiV4O8ewqThhuQx/xMdimr4CkJXxenxvrDdBsOj+j9BMPMx+TzJrNEtJ73P3lcdznIuYedzjCGbR9K4CDC9DE7y3TK64VEE8OaqNWGStXVzpJt8ip7NZWJiJ2Zaz/i3nnj+cwYwLWyhpRod1jJXirRzOUv0QtwWGFoay0ZhW22UV0Po/l4z0Yw6ixLVx0pThSSd3ds05d+n7NqYen1+hZ+WAqqaYCuX8pWlU3zX4HOxDrh5GDd6lVpeH/7VFiaOQ0qkviOF6uOJ6ua0BIH349VNUmf5M8t19XklFeDjpWDTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 11:26:38 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 11:26:38 +0000
Date: Wed, 24 Sep 2025 12:26:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: remove unused Tx struct member
Message-ID: <aNPVarHVtPCTBtS0@bricha3-mobl1.ger.corp.intel.com>
References: <20250910080616.892711-1-bruce.richardson@intel.com>
 <DM3PPF7D18F34A19FFE77AEF41CA5280A638E14A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A19FFE77AEF41CA5280A638E14A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY5PR11MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3909ad-a1b9-4f52-a9b5-08ddfb5d3a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1xKknqevL9RuZL/IoS2xPHqwVGCMXWTAFTaWiM8VA7wJIdx0Xfliq/8lrNvS?=
 =?us-ascii?Q?YtG8PK6eNshvlkMxRFy8y7jwTMPMaI4HQtny/YkVQkvn0eURtRdOsY308v2g?=
 =?us-ascii?Q?A4J5l/mS5XFoTngfrl30xp4uVGfERD6cfxo5osKAPuPZ9DWPXEENvJiDawZn?=
 =?us-ascii?Q?BBUJT2ZKJEPP6QtRnaPh8PZIni+gIc5W3lG5sCKAuRIs6a1RmBAepHJkuaHb?=
 =?us-ascii?Q?1bdSECf84K2RmLBM/6QVrb/eh8TdtaDxIpObpffDqsP5z/7uAvWQzctqPC0r?=
 =?us-ascii?Q?ClqDQR990VMidabsQA9D+i1hRr8PWHnozzB3PiFOe79MkUU0PeoyDSkjGogn?=
 =?us-ascii?Q?3M3ToKVmtJIuw5yMrVBRgzPhCUOkRCyhpRl6jpXTmOgJ2FOcE+qCtTQvob5r?=
 =?us-ascii?Q?uan8d+rPJAYyS4RjCryxoBQeLRli7Jx5i/Zu/zzte2sCoek0ctTqwXFRRv8s?=
 =?us-ascii?Q?jF89P0gtb1NVR8krJ+zTLhyPhIIFRkXhY14iHfkJMK6EGno+7uNVSdVidbTK?=
 =?us-ascii?Q?cWH7HkwMYmgVaL8JHUlJh3/tciQyr2S8+EIrrvgOoe95hiwvX6+SuajG+nXO?=
 =?us-ascii?Q?HspvzTaRG1JH+HHMCvQNzbmSt7DaStHMVcWlpjaHhswo8IgKxBUlkGpqgPjQ?=
 =?us-ascii?Q?FPpCoZ8qdB6/mEvNM1AaPq4JUBgK1GaBKOdse/R6QpiYkW3/Z4HHkZMpTkwI?=
 =?us-ascii?Q?DSznR72O9n/abKvrGgIGQ8i3mL4oYtPlgw81ZJ5shkCPdCUTs8KQW8o1UmoG?=
 =?us-ascii?Q?CSebpXwXuwkMksr2Gg4+pLV81umzqKuSKaQbU0/sdYOZR+aNsu/ZPUhMLkyE?=
 =?us-ascii?Q?2+SjomQmc59uN1gms4/ebyPOIwdKO+bcP24BuIkrzuGDBlUJ0WEXUV9Di7wL?=
 =?us-ascii?Q?/DNurYXdUlO4+h8msXZ5QUXIk517o+muIMxR3pNUhPBArU5/0u0EXOCZXFol?=
 =?us-ascii?Q?5XZd/S3gsAhWk+xz5G52MjEVmGPpbqkaQd575KMFQRRzatW9p5N+tut0PWaL?=
 =?us-ascii?Q?cvgIwd1upHmIao+yS+077TMPhCS2NqsBjAkKdJBGiOsib7uNWd9rVvVhlr/J?=
 =?us-ascii?Q?OsMZsNXukXCrkWIO+KcxPv8SttZONBeJN2s50ttZ89FJO8RjdcEXqzesHWyf?=
 =?us-ascii?Q?NZTqe+MP+dy1rhUtkl09XQn/StDlJK5CvslBclT3Jy6+UUTzJ1B+98YSZDfF?=
 =?us-ascii?Q?jX19EA8rF5EirU71rBwXbHaEcysgE+8C4GDmNUjMj/S5+jTGhTl1QhuSzB1y?=
 =?us-ascii?Q?v57cxo+Ei2YVUytvkCqHZejI1sfttlSfuPLBw7HXv44Wze6bDpZywHB+jIWD?=
 =?us-ascii?Q?uXMsB7CD8B8dXa6cnfL/oQR0E+kKCvlF1qNQoZQ7DsE3GIi8GN6N9u6JW327?=
 =?us-ascii?Q?cPDcyIjyd1f/nDXPovsAuDb/tJ4+Ha2bHesEatCt4lmr0lmywhKVWweJ+Em+?=
 =?us-ascii?Q?3s40yRpo/YQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tcj/dOxSKXk2/YuAQibkwi8SK38CRUgGrhjrvfXNufUZ0uggYT8zU2VCx/nR?=
 =?us-ascii?Q?uDPWJhSt0HID/9EanB2gk+wKeaBBK7KCvL+w72bKb/bHixM3dt2My7ZjF6au?=
 =?us-ascii?Q?xKuuoCpN9jzFrgrlN+WfUTMVTUj9xiC6dkw7dsfy1zNjd7GXAcq96CPLQpKU?=
 =?us-ascii?Q?TWnxhyjQxbbUJrB6MwTXeYD6GRrbhWe0zWC0vgQIndnEo8wZYlZhTAeimpMC?=
 =?us-ascii?Q?kVMLfHslmGJRCmtTnV7xq2vhPB7SSV7kQ8LTaxqds5XJGe6nUqvEL/c84n5c?=
 =?us-ascii?Q?YJ1u696zkN709RSfZfAfxkQTsG04k7qul4ef0cLYrdTvoLdxWEoRJmJOkU6b?=
 =?us-ascii?Q?tX6Z9GZ93KUo3rvC7lmoQeXzYVj1fTl3eBQY3EZeESHeiEVkT9lajTY8divG?=
 =?us-ascii?Q?nkCsg/XuTrv8+CqN34umTS7jwD8qdEoOBnI+ORUy62K0QtwwOPVg9Duiu2+8?=
 =?us-ascii?Q?OJiT+s/vMuVGoVMXed5K2e6Fqe7+nNvenW64udJaMUhU1QT2NJzzQA6qOUDE?=
 =?us-ascii?Q?YsaJ3wEXYs4fgGqbvwhJ4v1oRyuYqr6KqN99FtdjD/lyYrpqLYb3iuQNBs5l?=
 =?us-ascii?Q?VnJpVuirfgrJb54REDgQfbZ056EKqIfuTRHKeL4yBYPv6grCALlJymRgc/qd?=
 =?us-ascii?Q?OuIUcGNdQBJ7F1PXRquBeZ/mqQtgQ8ASkqkKNIPKHyttp+GJ0dhJECOJEpkD?=
 =?us-ascii?Q?RY8oKdqyIjQ6RiXd0gp2q2TIQwJkhMy9FS4Ghvfwvt9SruImxAXfvvGSbQoi?=
 =?us-ascii?Q?icxeBlQqlypTLE2/F1MlzGqRRAT+MNHgcMM2jpMVN78K0kOSzy2qJIuV2iwJ?=
 =?us-ascii?Q?emWlbDeYDQk5UqFunD35eZgMHdGd8KkZGEw7e1Hhqf5fh9iPDGDdvTiy6eRv?=
 =?us-ascii?Q?/V/ibYNwMW2e2TMJdUrNgQoXad8sSZOD/Y/K+6O6m3Voa3oNjgxLo4nLDMa/?=
 =?us-ascii?Q?INg1h4+gCPqygFPAC2VpDdFT7zMN4qu7bj+2IFd+rzrkF8gVievOVbxWI02U?=
 =?us-ascii?Q?EYQA6SGYgPoRZoogggh1jiulkre6Od09mBhCabAiyo/wkK049NKAQSZASDLS?=
 =?us-ascii?Q?9eyCT1XWT80Pae3Uyv8455uZdGKVDwxivPnmd5f02IPvZHbdDlqHf3pBUveb?=
 =?us-ascii?Q?DIKi0NEA2pbYIryc/fPC+tf7iwkHg1wrRBSo9cbQcBfy0obAFR1/qTU4Ce7u?=
 =?us-ascii?Q?k9J6xHtl4pHNqEi3z0G9ZctfT7Yqpd9rKXkQ1XYvnglLfnlVugj9uTp8J0bi?=
 =?us-ascii?Q?zJ592zMa4tO5uZqhIRkf7k4M7ZwFbAEiSv+xiqaQDOXDnunbxOc9txSI/3oA?=
 =?us-ascii?Q?kts3s5jf6V2v1FQKuVf9LLCbGsW5smSiFut6bMM8TCluN153XoNR881iQmv4?=
 =?us-ascii?Q?FG1wA2GXVHSJdrLCqbXFe9+/52CcCA7Y6sDaqibEZW9PTZNv2Ah+U0Wap5O+?=
 =?us-ascii?Q?xExfHuRhMN8j3xzm/Zsar7WihrdVcC7ZrwtbQxzQrUsyMhK/yZQtcV0WJcX0?=
 =?us-ascii?Q?umrWmIDsQm6U5qKUa3JspqZh5eM9U4vBOf4l4fppaHfPVCKKp1IiKpIre6io?=
 =?us-ascii?Q?leotMQ+TyUYFF9gL5y16bsJgiL24YbsNCm5nRQMx7SPUfEPZIv+w/O3SoU3W?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3909ad-a1b9-4f52-a9b5-08ddfb5d3a4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 11:26:38.7796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIH+H8oUomzghedXZDcNyYM3xeKDmvqQRyQdxZxn9VKKbwHYt1u0VlGztVR6Xas0K5ZmJ14GnkSQXE/w4B18HQxZvbvjD5NqzieiFQl2wBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6308
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

On Tue, Sep 16, 2025 at 03:25:15PM +0100, Loftus, Ciara wrote:
> > 
> > The rel_mbufs_type value for tracking the Tx cleanup function is no
> > longer used in the iavf code. Therefore it can be removed.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
>
Applied to next-net-intel

/Bruce 
