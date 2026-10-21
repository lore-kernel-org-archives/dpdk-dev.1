Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04B606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dJ/BMbzz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E889740679;
	Wed, 21 Oct 2026 13:04:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id EFC8840041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 13:04:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792580656; x=1824116656;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9+lgnhn9ZFEzQrmJJ3BaZRBic57AKTMzHWP6u9H4ZnE=;
 b=dJ/BMbzz9mVRgT1j03NEHEuDbjIP58qqTcZw3GCLuumMOkJejCq2Ijm/
 0h5UdCbZPMeoI24i7eX6K8fREf4wX/e/lSXQj+PpOjISMMGPMH6M3v0W5
 pgKOG5xDIxPPeFPhS/0dTkV7euGqMCIZvevYvgqP3IcYamcDSi4qKDmoD
 XUBqZlyjzd7dPZI3mZq/zOqCqjXVrnNnJkTMWBupGtcYNpnD81pKgyD8j
 6mBl4ql4UbZ3aeJkId2CsAgL2tiMowQl7dl/rO7EW3lPq261/HnDlByQ4
 Y/omUQGw73ZYDBnz2RcsLCVDDANV/3asKBfdLnuavlvPvmFwhEYHWckQ2 g==;
X-CSE-ConnectionGUID: QuJBMo1nQIuyW3UaimeAng==
X-CSE-MsgGUID: UsPxKMboTruJslpqQVIWGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1318850"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1318850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:04:15 -0700
X-CSE-ConnectionGUID: 3cs3wB4xTIepF3JGbuQmWQ==
X-CSE-MsgGUID: c+1mdZkySAKkiCHHSk8Unw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3124744"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 04:04:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:04:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:04:14 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfYgDiaSgyeenAHkRmpXulGk67VnzKHX3ss/0KhGY1y3kg/pRQ9b2FprrgpNXF8+LzpIqu5nvrxlNF7KXNJJARgA/lqRpuJY7A1vGrg9yTitDaT+o5jMIjjVFeBI9o8GYJGXhkjIVwSczQ0iSubt9M9yqFFeZXxOH0rTQOSxWT3XCZ+V79CDdccWUGUXO+kxkT5VlRoeCKaVHwaatk/tEWlh9SnHOLsAqQ0P0V+Nz73eaqBty7I8VEqSievAmsKqKLMvzz2a5GBfNPSvtxmLlin4YwJELf/GIkv3LSFSmX+TGsHngzrht3BsXsTsnKevvkwah4nRV98PW+hqCKObRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZePCbwJBxv3PfZqXYOME0M9Zs2xxF2QcgLkRA1S8eUU=;
 b=TONVaSIhuyCwYRWIFnG1u6IQHRyuMH+mjZsvwMY590NgBrgVlUOrNDMYgvjpr77QS5tDlEW9jhMkUgJJpilIXLG8WRwq4HP31wTkEK9zm+m5fJIxKVoD3e7OP8yAFqRgiEy0ZyJdju218UIUS9VaAqRBnZEPiBLOx4aKH9d9R4MEnjth8+oe4bTu+vCXfRMyCC/BX+d3sm344ZhUqt4zmD9jYZ8KaN0+qIGixBWXXeAL916+uSJC8thkspdfDlRON4KSkvnBRYtFtCALvmKjLQP31a+k4C+yCbXXQNnAYX9EF6gKhhUcIbgxNfsHkNHu5SJCtczzaa2d7hgQv1cLiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 11:04:11 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 11:04:11 +0000
Date: Wed, 21 Oct 2026 12:04:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, Rosen Xu <rosen.xu@altera.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Dan Wei <dan.wei@intel.com>, Andy Pei
 <andy.pei@intel.com>
Subject: Re: [PATCH v2 08/12] doc: fix DCB capability for some Intel drivers
Message-ID: <aticJT94Qrzg8zv_@bricha3-mobl1.ger.corp.intel.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-9-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021103027.2050351-9-david.marchand@redhat.com>
X-ClientProxiedBy: DB8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::23) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e15815-c85d-4b85-0447-08df2f630928
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SruSeNPtWC/6BKQ28VDwcQmTl3uxbADqjGlKQHjqam69zBGuplz5rNku8xLHOyUFV/hWo9O0dCGBQA6nk4QMgoGV3/gqTBpCPE2s4k9Lssi4FRojpuT/GDcy1ixGA9kWLOtz8vyrOd0Y9Wv/8TbdwnvZugZPFFKRer2z3ouIOXaObV8ZeyShkJjlaclmQBfwjiqTNHM7Mbe0UPmMaKx4Z91vhip8xqdljvJ8htDkEKLS4c4DV+CEIdfkkSvc5ExnIVPOK1LtlU2l/hDN+HnvVyK9/dlpVL66Ycu9u+DM+VhO+OdTAZ8zX3/9jj7r9NMUa6OG3PCtrnIkcYCkpVtqEakbIqoZJ8e2I3d9eyVjmsWVGXUuO0Yj6yFgXqk+bfZTNoJgr9dp9mfIwmTpjD3jryE8CJ5izksYB4TJZHoDFxsVoTxFUDeke5cy3czjJw6y8/0febmBHD5xk6wDeEBtJ3O3fyGOAhTtZsnd4WTO4+Dm6oTENhBmUFGut+IAsYFeMJNt5WnqaFxgczk4EqmL3mzheU4G6EeNdy0quSx3TkQSAuETlL2JSUDJNAvWGa2xj+EzQ8bYQICkSv3l9nKArkKGOzr7gi87+PWaXI8P7+PqYIVw48/rjx42TagEZAaLmVekjxHSwSKSKQ5EkG9OfMKZ5jq1yZvjBC8h++SPpT4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OnnIn3m7PVDZoyy+vwXg2YRHR93nvhXbcms30ev7SspPsoCzruOsrRzVobFk?=
 =?us-ascii?Q?XlPW9Us/bRzw6/HZ60pIe2g6UUIHBcxQP8XOU41WDIrwP3CTcyiTD6SCuLQI?=
 =?us-ascii?Q?LYuRYIMYso3kzRqFaSnPopf/rSYpZEHXSBKORZDFj2NJIDcUeXhPdspBPm7K?=
 =?us-ascii?Q?epf6q04c33Iv0s5WiMc9aB03idDxk7cYygPHobvMFMjPYJJLJDukfv02+bN9?=
 =?us-ascii?Q?TuoQMk+peXZjlzkXx+ND6Yynm/zjkEnO4HxC77RsUvzUkg1lUEwYtDuLmldu?=
 =?us-ascii?Q?kK8pUIX9XPngAv/At19TsgmZsZAxBRRvcGCmfaLOQfAVnR+KkLLg/QVe2tEa?=
 =?us-ascii?Q?pcUIlXMIHSo2z6VotrbAN4VSblT0mpOTDuFylJEF3bRu0lZn+NI/XFLHYPAX?=
 =?us-ascii?Q?eBwCz+bDKjwlGtPBV8P5wvaGl7oxhZRlWiONv6+tNwQkWbKug47/1o6ABZvF?=
 =?us-ascii?Q?LUuZJuvt22X/azydl/0j0GidBZVkgnhiZQ61R8eTaeOQdhQl/Ka2sZ+0IB4G?=
 =?us-ascii?Q?0fyUS/kGE1DeTxp0MvCOzoqVAvb3LdwZL5ndP1UBibqxMBi/jn4IH/R/e6TS?=
 =?us-ascii?Q?ii9K8akz5e4GSnajBKUny2ESufA/zMBTAf4qmMuEnYFz++57VV6gNGHEteco?=
 =?us-ascii?Q?8A39M2wtMQtaTFcCHDO/B8n25GXHyWkg1cja4jmE2Zt/VsdSWLmynCgRwrGA?=
 =?us-ascii?Q?hIC/uSA9Ay2M89Qw6d63pUQqpU0+F++EwqQEkeLRyU5lbOjdOkofkYoJsmQi?=
 =?us-ascii?Q?YxhGNzmLsMagge1DxaYc32uLFsLqZh8m48KCOw+U9T7x8JckS3CHor8Q6GLx?=
 =?us-ascii?Q?UkXn65KogsXCjCdxFWkQ5toWyfacOKyzZJSWD4yoTJma6as6O5DLflBvfXAX?=
 =?us-ascii?Q?q7Lf0I/q0Ml1U+jLOQ6yNxD5UFiMlCYA8/NJtH7O23vwZRKBKwACAtKUDqD7?=
 =?us-ascii?Q?MXyQ4PVvXqoHqLpyjRuDNVEj/iHiwgP8EqxF899ANOf9RM69c9Ywvjl9GVbP?=
 =?us-ascii?Q?OefcdD2Xbmw3x5l2dARoZszT25IRkFCeGscSe1m2gBhT7D0QRqxJ6VYP+V1/?=
 =?us-ascii?Q?1yyZeZKmWBQaOVz9nNMjvqnJ7FPY6R1/fUX9qA/LiGEXYieYjVkWNhw2wM4y?=
 =?us-ascii?Q?dw4XZtPTP8nO5EOL9cvTNuKWT+3ErR9mvZHMI4zkZr+7QJZUQ1sbYZkkK/IM?=
 =?us-ascii?Q?FKZgTmKwxEH430DOb/aZmqs/tEpFYtiU5mXVI11s4RKNXXx83v+TfGTjxb9K?=
 =?us-ascii?Q?nZgXc6alfmAb8IswLEn/nB77i40eOHqO0UDsswZk2vVCdzP3U/MWhaZqRXmS?=
 =?us-ascii?Q?+ilwMvj2BbKEl+3qdAQnRxOSAca46vCXAfzRgCSDHHD/qygwWWcA5Iz4BCx/?=
 =?us-ascii?Q?oGd7JwTBqgPCRVeN6bEjHQnPL5B886OiTuIjpKcj7sp37DgimAXmRmtXlrjL?=
 =?us-ascii?Q?ii2cKKGLokPP70EjYS2yTtx8mswjArzjZ3zGLcxd5AoG9HMUl7k7u/JdFNo7?=
 =?us-ascii?Q?YfxvYJLv2rBJgnyqPiOFzCs5p1J2m9gor344sOEvahzchwKOuekfzpmi+4w8?=
 =?us-ascii?Q?CDfcda0l3ME9+u4UxhxgsUKmw3IP55Gctuk2uZuAI7i8ybwrTvC+qyNZXKak?=
 =?us-ascii?Q?d5AiJFbNpRy6uWPs8zg/iewyOqLkPJu5Bl32SmR9HPy1hZ/aFI+Cu25/f9jy?=
 =?us-ascii?Q?7KwVyZape5520iaIkgGbeuwTJ8iqjXSWl7eVa4tCzhEtGa8bcOt4Nnr5EoP/?=
 =?us-ascii?Q?z7o1CkSilyCbdwQ1wz89F6Md0u27Ayg=3D?=
X-Exchange-RoutingPolicyChecked: Eueae3F1VqidALO5XCYJm3YQtNirppKoq49n8aduVRwVr6FRBosQh29cVLfuAof5Z1Arh4Hx/XOeZAVZdGwB2yoTTM/RSpXoYvPEw13Fzrx7gOgaeBstN914of2aa48zK2B0P3Q6GOtlFcup+wf4OsNGq8u7NffqXY/qirDQ7A9WVw8gP6PLYoe9q8bv4sP5T6/dhMgPIBatqSePSEIMW1EkZCaN92gi9swP07lqwWdruzww21RpryKFepKpgs7jPsyrofROybyi+uqBXp53+2/HzPU93rN3xHv//wdtTopPWtfwZo7K/ipim8RZMH57xtOZREgu4NZA6VrY5Y/1VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e15815-c85d-4b85-0447-08df2f630928
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:04:11.5130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwEkcHuq67n/CyH9N2EWQnUmOab4Kp2UorGZXKyttcCiEHri/T/wPAIbmPdP/qFl5fApCIwubYG7Ar2Z+EbPSWTB1FFVL1z41Tz41q5iYKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 12:30:22PM +0200, David Marchand wrote:
> Those drivers never supported DCB.
> 
> Fixes: 83a4a15404ef ("doc: fill nics features matrix for e1000/igb and ixgbe")
> Fixes: c01c748e4ae6 ("net/ipn3ke: add new driver")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
