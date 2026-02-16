Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD8E81A32
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:11:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2CFB40296;
	Mon, 16 Feb 2026 18:11:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id B326E40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771261904; x=1802797904;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=XqHR4PLOcg+PKi9IMIhX0j9Qq+Wu4ziroDVJqWs5uSM=;
 b=g3jRgEiadmVmmpa5YNyo7oqmpCzr4NiXvn6YcWkSJutK4LRPlBQLITaR
 bmVO93RzAqa2YGdnaR3jVQotashDhDYS6LnZ8faOjW2Uqpjqqom+PJUct
 xK+kdx7D+x1iDKaSU3/ZPirFhMrF/5uIGde2Una2CNzmFfduubVls6HWN
 9HrqlT+e3t8prA40qMoSAAoDoAqF96sBT9MyrEZZaxhGTwr9Lni2eyhUP
 wOBEfMyMcItl1r78qrYj2M6U3FNltRvUQxO8cHXeniFnbhSgbJnuVKyUN
 2G4yrmkeDFaPpurUGOCyQg6fiC/4/HkZ6er2bj104vWy5j5TkHjPggB3K w==;
X-CSE-ConnectionGUID: lJF4/x/GScqe6zng1cPBwA==
X-CSE-MsgGUID: R7FI2gwyQZ2GCcNGYf3jaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="82975023"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="82975023"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:11:43 -0800
X-CSE-ConnectionGUID: Nq6nw75RRpuk2lFcr/azsA==
X-CSE-MsgGUID: PrD8d5amTzyW1ZuUXIXE3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="218190705"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:11:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:11:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:11:42 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:11:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAeDQezF+qfXu3XcFS0pik10HDbDyhg2LsKT2x0PO4DJT0w4r6dJY7KPhZmfbfP7p2q/15J+azsWxCOuICLV92Mfy8leJnsV6Sm/p+TaOj/+Oxj+JXCqliLfxzXL/ghEHUrzt/kAiJeQXD0ByT4oB/sUd6ZMtkTlRBRAIsHoQNMXxLa201/BFbD2tMOML5fxz21wnAjbeLaw5H8hZuELb7YZNivhz1Ec8sarbv+GwzTSzf63QtSx27ThjXTxU6T1MoKPoqje0/RxWGCRkjUUsjzQhPleQKjK0LYgky3INXWVgUQsY/8xkIkj0Ks1VuYf+2orqRQW6wLSZFgpdAGVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdfI1EJUIpH9WT6SMmJVAllKxdga0Uw/0nwC9OVHuY8=;
 b=csoGq1oPtHfANbnsGD3E8/DIYExkaYBzliLsyuEw8YU56jTM50JbH6dB6l9CCbucyDu2MUd0dtZnedFnlHdW6AdXRYD4DtNs6gE5nqDRSJEWBxczJBc6QmJ53wOgfQ87gicf5/IFK5rGXJc/WuSN1/OXN9ZZSJ42tlIWm7DldkSamyniUpN+hacmMFLWappvXOdJHHuw4M+M3N70t8RvCCqkwVe8vtxTfDhgQCZP9TNmXfLwlKH90Kj3Oho9V3flKdQhphE2YW+608Dg2ZboLffBeRbno0AbybCK0D8gnsEwiZCb7wHBZ0NR6fI40/wfV2holWVb/Yy0/3zrPwxVKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ5PPF7CF5FEA5F.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::838) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:11:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:11:40 +0000
Date: Mon, 16 Feb 2026 17:11:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 13/27] net/i40e: avoid rte malloc in adminq operations
Message-ID: <aZNPx2urdQ79WwvG@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
 <a2d5f396ca602dc6d510542b8014306529fc87bb.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a2d5f396ca602dc6d510542b8014306529fc87bb.1770817884.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU6P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ5PPF7CF5FEA5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b71e12-1efd-4ef4-cc2a-08de6d7e7363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d4eBrCjzin90mIYXNGTEk2nVjPFcNExf5BtMrr2VydyPzn3cmwEFV9/uB8u9?=
 =?us-ascii?Q?AIiUEEmpfz3u8oiLSjBk3lL+krgQISiAkV1UpoY1diGBDJN5tdpM55WDVDCA?=
 =?us-ascii?Q?v2nbqrcLhmV1cjAq4luc4W6SqYWxq3tvAlVslb1/bwFePipFDKh8mBHVV/OJ?=
 =?us-ascii?Q?iOgAv793/97mQhBW9u9KUxXGCwVsvyCvl7bCkOkSJlFqAv0Jg2IaOCrBZplB?=
 =?us-ascii?Q?i35LcwP3L2oy1qJivQnabFCzN3P1qIdo/EO3kEKnDIms7l3wx+LnvfcnAWvq?=
 =?us-ascii?Q?XauFti1qdHxI8gdwNgVjJOLgJ7cB6LF1TINn0cdtZR17NGomJC+CUYOQnqsQ?=
 =?us-ascii?Q?6s8FevWM+eSouWeu5x6GIsiWjSe0ot6Pl+PXXpcxxf3YmSNW5SG85CyKd5gD?=
 =?us-ascii?Q?RALi0N5a8E4Mol+YkTEtsZ6igaRyZoOOr/spMvhzlMJiqZ6/Tdek8Wd62UQd?=
 =?us-ascii?Q?OXz9hjRctBAUXbGSAhbMM2+jwn8AnBScVzSP+0bPAu/YhDAifwLdaD6fcq9U?=
 =?us-ascii?Q?r9BTg8pLq23Xi+u/f3PvCT8zAS/HM4OAsqaH8I27bp1E6GRoLcJyda+PiMOb?=
 =?us-ascii?Q?QXQ1KF54Nn3xbK/uASKJDohFAifpYHrkRqLafQIFo+fpot/nCXXt7du1JHiw?=
 =?us-ascii?Q?PgNAe+dXGxK2O5R4Vz3ixOcBEXr3RUAFgmyESGMG71VxybtfSIBk5Ve62OMD?=
 =?us-ascii?Q?J7AHHsL0rXNSWApFEp0AFcOO2763gmMrizEZ1jlqk2zKTdVvvZJLcmagZtOw?=
 =?us-ascii?Q?DqccMFPsmi7d01Hz7/i/DjxJBVUt+nkMzM5sFU5sbhOYf31TpxTYYKZAlISN?=
 =?us-ascii?Q?ULTETCeGDpkPzvLG1pUVwD65Kxe96tNzE2M6dWobxGTLhGYOQOIb0mind5lo?=
 =?us-ascii?Q?Lj07BncucP7WItsI+/QpKVlZ15Muqdj405LyxcKBKPMMhgYvjUnqb4WTUPOJ?=
 =?us-ascii?Q?zeTMpYL3PvkgkwZzsbiASCYBBFiAMwqrA6udPAa6/TawhrYkXn7Cfu5u1Slc?=
 =?us-ascii?Q?JoDB9FblKZayIeA4hwvPH9BwERPOHnT3f5K71YQv2rgRVBIzUUEV4n1zTxR1?=
 =?us-ascii?Q?VM7f7EH9ZZs5gRUDQDeTTRtbLAHtO5AUTF0/72+pR/cGPR0TMOLZ+pp4AISo?=
 =?us-ascii?Q?+RmjsGCTq3Bek7sgJ8yn6aOdy7TFGVVW6X/yj8zjj3a/zSXu/p/qSnGTeit/?=
 =?us-ascii?Q?2qSOPBE0mAgovzAqEmCLCGkkTaV9Jliw+7T7bLn3MRNarVpheYLFuEb/F2Rg?=
 =?us-ascii?Q?TOoyRlzkB0Ie/w/CLVR1bFrlrW8lMaSYgLF48lzrH3Usp/muXTdIvZ9ODT7m?=
 =?us-ascii?Q?ZZAvjfLofyNiW9fLSFQsRZStxkQ8BDcdNi7TxIUPlfn2AfD5NTWB43qr6rQh?=
 =?us-ascii?Q?SFddP3juQ8Ry8Rkw2ycE2c+g7ZmDQ3DZPyS9w5Rup7VruzfK4VSXjHPoK82/?=
 =?us-ascii?Q?AZZZhKaaQlt/oF0bjkg9yk7a2QfomUlYoNSPr+OoGGA1aIBpgTj1uXuGNt6p?=
 =?us-ascii?Q?L2HbjZ0l2rSO/kSjn8dRkPtrdW3rImNvnFglrLu+99PPpcJk9GC0vQyasdEy?=
 =?us-ascii?Q?Xg17o+Zq3W6WDw+dl34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xpDipXpZO4IcW3dL/BPJTE1t4IP0gSZwB/vOzEDDNt1fDS3My5jPnnFI8pe0?=
 =?us-ascii?Q?aSoG7RbIi0tcZt92d93IMrUfqvRJQdvvdwkHthg2WnN7DpVRajjzBshlMZ4B?=
 =?us-ascii?Q?GTdVGQsSDzI3ikYVseiKlCM7JFuBM/Xvk7Jq+/qBYeqV0AMQnocobXLaleMi?=
 =?us-ascii?Q?rtorDf7NsbP5DRycxcgrnEeh7E12Bwc0eSZgAL3T4LDLfBhX7jg1fP0W0n2A?=
 =?us-ascii?Q?XMiXrsNqwoLqXmsNTbD8BNBxzcFnm2KQepPVDgBy6vf9NUQdYi3LMqWUpT/C?=
 =?us-ascii?Q?qKQHxoUf5VLbJh1LQLHfyC0LuBpwmnm+z2pp7J/A9VtgyOPzhaf9MFgmZyr2?=
 =?us-ascii?Q?hkGTyjIwzJOFl5DeZ/fOT4xSYx2p5tjq3gC1h5FUiVRdgUOEV20bVbmRoHAB?=
 =?us-ascii?Q?FrbsPxLDQCkS6LLAVc1Kn0plhI4YtT3uiGS+Ow3Z2PMITJlJ1IKIn4f0M8pL?=
 =?us-ascii?Q?4/kp3x5vjnOawMHccuf0ozh7VXRh7ZPk0DoHELYXwJeDRwVdbuPEVGhEpN/j?=
 =?us-ascii?Q?Ki4Cwv3HpInAXFzFGv8tH6Iq+mQopWvi8COHAiI1Qt2tqlTuI7eZcVxB5D25?=
 =?us-ascii?Q?12mWiiHjdsxjuWJyJyYcKfjiA9m4X+LijXceidN7AKGc4kVu9oYtAM/tz/jY?=
 =?us-ascii?Q?kC2HAK0ZueoVP9YiUUNjxiRcdtgH22LJ2+TURfqtAWWYOM5L/1YBvQRmW3ks?=
 =?us-ascii?Q?jNYhsoKKBw1/NEuzdXgHhsukerS6KHOK7zK6MsKWAgg/zUhsEbHiCSppuglp?=
 =?us-ascii?Q?dKzVmFXVWfmNFgXoQ8HZ/ujkjdQMnRqP6KLM9puFXXza4eO88WQ8HuW8hjPM?=
 =?us-ascii?Q?9GMHdRU+d2khSNsna2b0NMFnQlKM9TkvqUs/m5DR8nLBuxy0Nh8GU83KQPcD?=
 =?us-ascii?Q?vXaXZwmOKypD5Hd6rrPzFR2a3cbQlLDElAgnVI6Wq6bmYU3BimTdWlapzTzd?=
 =?us-ascii?Q?aTtsP0xhB98YoDw6dZsw7algjOub43WSkmW1aHmZ3PNntcJICQk41PFJD3qX?=
 =?us-ascii?Q?Pg86AsL0ayJwz8TkGpQZnSMhciZ/5vXLSKO2Wjq1tzHcUzkGLG08V7/qhwly?=
 =?us-ascii?Q?yrem5SL9Y2D7RQqt/+FbnL+j/5vW4G2YZa44pSBLj+Sbt2iuvDogZZnuzqPW?=
 =?us-ascii?Q?dnKc6Ct/fXzXuY2RACPpKw+bevOxhSDDPG1qXRjVpy0BWBgM3PlqWck908c9?=
 =?us-ascii?Q?ozYTgjrYkpProAE7YmnTo5NF3a4Rkbe+PONUoCCGbaVY6lrfLXR9y/1hdS+J?=
 =?us-ascii?Q?094wrjxjCOczThtjqRRJx8EcjE+Jv1L8q14KrebD+hQTPpR0RcIeyhsr84D1?=
 =?us-ascii?Q?FQMejmAeXOBiKMVhJBPadgsWi6HGUKFWlNJKhvCs2MfiMt3URYV+kqaKuGBD?=
 =?us-ascii?Q?3e5Ucx/Hk9Iy+DBJ9VzCZDrWVAKXhpWaURPaXIgY9I6EkKRahluoQ5Y/Xusi?=
 =?us-ascii?Q?ubAwvmq89rjzWNWzCKbOPmyt1apqy0rvOD55i0Tcc9G0qnEvb5c7M+Mo5AEv?=
 =?us-ascii?Q?tids3AkAci6MqAmPXu0CsmrpY9a6n9GT99jyeQxLgkqiJKLkcKm5ZAfcuBbF?=
 =?us-ascii?Q?HV9H7kF/Fg1dxeilcNYIgJxzU6tWWesMqF2pZXhnH5ARFV5JhZjATUd2sIH9?=
 =?us-ascii?Q?VUDJHAwN9t0O3TxSsycWC5zDqxhLLkaOaNNXYK6mQywU2m4D2+aSk4UeNTzp?=
 =?us-ascii?Q?9W4TkXaV4XeTHV+huBqn2nZ/Hnugs1k7/ZQ5Vcp52HJPclvXz5JFJsrppPwo?=
 =?us-ascii?Q?R3ZimFmc9f6x7XkHaNF32LjTZDkhiEY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b71e12-1efd-4ef4-cc2a-08de6d7e7363
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:11:40.3226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy6YhIoAlcCzFB1TGu7VABpvdOn0nkt+MZHZZy19qTFI7Bh16OeCnBYRJ0BkieWT3kUJzhqb+zdk0VWWTmJA7kWLpbhKqdLBIdEcA5aG0M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7CF5FEA5F
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

On Wed, Feb 11, 2026 at 01:52:55PM +0000, Anatoly Burakov wrote:
> Currently, when processing admin queue messages, we are using rte_zmalloc
> followed by an immediate rte_free. This is not needed as the message
> buffer is only used temporarily within the function scope, so replace it
> with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

