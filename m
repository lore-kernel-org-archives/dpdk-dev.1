Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3BFCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5DBF40685;
	Wed, 24 Sep 2025 15:55:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 63BDA40672;
 Wed, 24 Sep 2025 15:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758722102; x=1790258102;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=oWg8itBBWxnoGLM75k9T3yuJNlp9Qn5ZGcZbVwB+Ero=;
 b=H+DBzYWb0M2KzChiOXXULhHc+jaDZxLgJMVgftvLUw15zfhXcghBQG4F
 IspE94f2HkFm22q2bWYCWvDUSdAViVke6d/hMR/aAroXMctpyqCDgTUto
 geLqzQsrIcuxWhwM5iN1AYKQS2RjDGeirOEd87qBRKVLfYHqfKvPa4etV
 7GLELrgOtAGhCyVxY1bGv3ozRq9ArsDXRZwqp0fR+BS6W/Xg6gECWYtW+
 lCiquMMm/QReiaSoPt5DLS+V6TLB8wvFbBD/tg2hP984ajR/aXEddyxui
 ZwwR2vZsjsHYmeDzr/QvbQBg0njDtb576VjUQfJp/VBvjTvXGJT65luuA g==;
X-CSE-ConnectionGUID: EEjnlZErRTePc5s388aJ9g==
X-CSE-MsgGUID: zopZCDTuTiavlNyvsXaKyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="48584843"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="48584843"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:55:01 -0700
X-CSE-ConnectionGUID: PiG9dkEsTtK/FmQQjyTOGg==
X-CSE-MsgGUID: wblMUwqGSa+5p9k7aCxF+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="177435997"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:55:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:54:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:54:59 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdYS/WDhIWsxxhHp6aVRDdaSUZ4hr6PyHKw8oDS0jBCi/Awd/cK6Bd6OsAG598RFf4xlHtgbWL+6v20uq0Xj2RReOJ0CD4+bTBScpgXe4AuLEeR1NQ90lIcFRi8665/zhOb4UxjAFxgJUGAG6mbfUNVkD1w0GTj+Lj+T5znmiKkJZwn6/v/7mprRqRV9uMStZf3+okArsXUjZK9IANl5Gn0r23cIGT9FytH+xiZLDYNKEDdIv9D6XJYdhVDspSY/I2Wtb9VQTZ9zvVOBN12cDojHyWz10uThMN0528gcOzF5hTPD/2tyXHmjqlbZTQ/jQIfPg9wS/8QmU0RqWcdArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VT4v3tpT/ISJJ49dT9MOM0Benw743bWTGZm7nfQBYns=;
 b=ch9/JMDYgnQLu5LZqNUFFiCWa47uLWXRLcGstFAbgV15bACVJBXn8JB5EZWzFxWbS5yYvIo8DBlCHVamTGZe0WzO/4Xt7JpPdB8fKjXzFdom6x2E9vYhY0WhtvTjJeREO40/t8Su5kjFiuzGXpTjzpxVVdMRcNvzPzCeZWDT/FogkODu4n4bhgOLnyT6WkniCVq3OdMiVeYJpAONLrZdMPk21AEwFSCvbK+Alg+t178a8TYbga5mWcXVGlDRGXBkbblAzmyjXBG3TbVfk7K3pxqA6lfBTxBoRfvfIzoQ5GeKB5Ucm+vXCHUOSiov5viTPcbkLPG/Xw3jVRI5fkP8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8376.namprd11.prod.outlook.com (2603:10b6:806:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Wed, 24 Sep
 2025 13:54:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:54:56 +0000
Date: Wed, 24 Sep 2025 14:54:52 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 5/8] net/iavf: document support for free Tx mbuf on demand
Message-ID: <aNP4LBHmu5-WmoNQ@bricha3-mobl1.ger.corp.intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
 <20250916142113.3485738-6-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916142113.3485738-6-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0169.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0634f6a6-116a-4500-4a79-08ddfb71f1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uw1o5YNHxpnLOyhJtyRiNtsI4r/5TfaabJMKe80ATvuhzGCVSybBkYMskHjy?=
 =?us-ascii?Q?PO1jGVknLqIVK8unkWXolN+zOVJ4q9fxkRBRWRpzkDdygQYiOOrKAEKFXz+O?=
 =?us-ascii?Q?VkhggQDbpfNEEdrcejBJ0wpQGWzhRGF03WKKX5GZSzKihvRuUHWT2THnp5PX?=
 =?us-ascii?Q?yIiwm+55YHTMF4vksmaVWY+RAYLaUX//NrnF/mLhtckuisLvZ6i0Wn24UwdS?=
 =?us-ascii?Q?3/V3yr+ZRF8BLa1NjKBhz4eOQ7ryduq0ADbt2F8yULmNEopGSWYDNbEbcjrB?=
 =?us-ascii?Q?htIwZm+6+crmhHd90O2X8VZSlVbKG1+JhI4kNKJKUutOYdleqwIOJo59Iie1?=
 =?us-ascii?Q?6CmBiG9UkML1b3oBg/jJDps44aFw0L/0KPmmVTUsC87pS0lY1/UUFUjbC61d?=
 =?us-ascii?Q?U/S4CADURuxYP5sER2Twl/9Gh/zG8I1e8qWHEqoIfD3IzPFaTGTL8xCSTWIe?=
 =?us-ascii?Q?meCTmC0rNGZgCQdOZm3mdqb3PiQiUiGlCvAHuls9MIIDTe15l+7s2r0kG/M8?=
 =?us-ascii?Q?THIZZsMEqmy4rG1CMrBLtHgrrMVLOsiQqNJZ02bbdben08wMS3magaARXp6A?=
 =?us-ascii?Q?MAPs1zJCvcuI+KfPYJqtocrddCWyoLdzcNUluJkSYaJ+TSV+14x23ZaDiNCn?=
 =?us-ascii?Q?qs9jYnLmtkHEMeZl570BaLQRYyuWIq1ncalx484UFMD9oarn8GgzPM6aGVkG?=
 =?us-ascii?Q?VELJPpjsqR6dcZF1FXMZhFA/QLnvh7EvYeONPrpb26YQYL+opT+tviZJ0Tai?=
 =?us-ascii?Q?sgVX4uXM42wKno6pUoLgG2ZsKRymiavEtQPKiacyQQbULrOzYh5gzVY2CK+s?=
 =?us-ascii?Q?UthOoWkhRLrLSQUcR9QBksZp4oVbBbtFtzsw8tcY6XgAELgPs41/9KF5t46q?=
 =?us-ascii?Q?pexrpU26Qjq18DMOB3Sy/NErOdfjCGCFy2V6EGaUyiIi3rTWUzdbRfuJIx5J?=
 =?us-ascii?Q?treDxTjGmZom8J40jyUXCu109W8eP7ZVNLWS1N/+JKVnBVTvr4vh85GX/GC4?=
 =?us-ascii?Q?FIKW35BvCc+V8MILX31tNaq910rnUtif1AkIEa/tX3ZpJa4KkJNiM5YrNTJd?=
 =?us-ascii?Q?m/sSskhv2r7Vqqwjpa4LsH5IqYAQQjXh9uV8RqwL6dctluhe2c1Ze/mRvygh?=
 =?us-ascii?Q?3/iWM3HmVChHR8M1U3B3o6enZ8aDYpzbPEMs8aRcvg+p5NOSNSyHGtpqZYXv?=
 =?us-ascii?Q?EherKhR/GbvwofWRw6mtiZShQnzJhpbVCSlDM604W2+6bD7pNQD2o7dbOGrR?=
 =?us-ascii?Q?n7ynWLvN3I0Wp9XrzkRtF6MhKF42msM5b2GZC+6xZ0PBJdBW3nkn2Ojd4p4X?=
 =?us-ascii?Q?bgzo+HmLNUenhARysyNxdFbdfGaNTTme8+ogeats76CQWhEnvcrWXmHF6BjB?=
 =?us-ascii?Q?TODkFlTxBlSdz75apQLYg/TPrxB69o7Nzvs2Sh7JtOjWtZi1EOONWoVGenIM?=
 =?us-ascii?Q?oNccHZKxgS8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7wZTQyoze9+pyFl7Zw8NRFqP1fpoJVA7+eD2kQy9/umiepX3/v9ibiCFIMp?=
 =?us-ascii?Q?dIlARNJWH5bDH8A6fz03bi6d65+0qtkdf6dkMiznaIITSW5mtXM5Y27FsX94?=
 =?us-ascii?Q?KUBnrgqFHZk+hwdcNTOG4EbNjArcthJCyw3bzizebXLsGOLuSojth0lIvogx?=
 =?us-ascii?Q?ajuj3YPF/3m9XjnWnhRzAVkPGy8mmgjbQ5vSQyI0OimHacpkTAdrlMVT1ie5?=
 =?us-ascii?Q?tYnBYp936amKtKy6xEIzvfh3jPh9bq/J5qBfb0Uo1Y+rwuI89nZ3o3SvV9mk?=
 =?us-ascii?Q?uVwlbsmH/41x3Bq9WoWEqcQsBJPkn51Bk5XTsiEJz68iI4ZynIw3RjZYlaK4?=
 =?us-ascii?Q?/qDvz5jvLUboNfOuYvvZbc0YsG1d2rjf8pWlZ8Pfv3NA3Bkj9KdrLojGV3gx?=
 =?us-ascii?Q?Qw0OeNj1DcQTaHfFeadLvXzEde2tIRJNdqSrCj8bCiiUVO+9SyFxEO/jY/JV?=
 =?us-ascii?Q?HMxUcY/n4hn6MG4Fc4b35aOeZYAi4QT53i9Xgj0WqFFJyRpkfNwU4OP+nppp?=
 =?us-ascii?Q?eNQKx+bd3j57IBRjomwgsTyyOXXlDpkJFwWiPmDFPVDsAVR1JjRobnRxiioc?=
 =?us-ascii?Q?e0OA7PqDZ2E02+qlrGbNcOvfj89d0EcRF7IqZlyLD2U0oGL9zx69S+cL3Z8/?=
 =?us-ascii?Q?5O5IFcFqfS6mY45Zhnlt1hbgY2rWUmVmqQXSz1rHKSx5GQifscyJm449NHAu?=
 =?us-ascii?Q?x2sSq1l6NHomlwj4Z1zjj1RSTM66BnFoLa9pzkYITn1sVU0cYUKlLqR5KvDi?=
 =?us-ascii?Q?2vDlgqlLrocKZ0SwVNqE/RyucsAKzuEl7ytUiiRzq9P4d7rSKbu1CvByP1h6?=
 =?us-ascii?Q?lAxQ2gXlL79f1rBm+/VUCwqeGQNJXbPXOBwj0GUNSCQPwE1uH3sEsPWHX5Em?=
 =?us-ascii?Q?6tRq1RnQm2NQWtE1VfuS6S2GxBeutrbDSHp/D11gN+JD8P0PVijtyKoViYkz?=
 =?us-ascii?Q?p3mxfkbm79y6lNVFt5B9IY5WLwORxEHRuZB74yLcnxAxaPk2deLUJboapJRR?=
 =?us-ascii?Q?dW+8TQPqW5JfJMwCPKl7ooWQg1rA44j6W4I47m3VTcJ6/5pP1bFoilTp7fN+?=
 =?us-ascii?Q?jNECr9bl2vfLGOE4sepnDJ/+X8ZpurZ7otSD82e1q75xOsK0i3uaY/oe4oix?=
 =?us-ascii?Q?Wfh7cbCGCrdeFZPYuSMVTYrGhckVCbEpvxtE4bzN9P36LSttlFgdHlr+ZHR7?=
 =?us-ascii?Q?M475oiSbNwweOqM6hMIzd0wH7KaTRocEGUyL5903ea3ZcpywcnB0WaVrwTd7?=
 =?us-ascii?Q?QF0kDhFwaZZFZQPbfgeO81XO5gM2mzcvWTV6EMPp55K0eX8+p6Pw5MIfybvS?=
 =?us-ascii?Q?wG2Jut9gy8c8o1F1vus0RSM6YEBfHbnPP0b3TBZeWItEFCXwzD+ss4LAJpAF?=
 =?us-ascii?Q?1PZ8M3ExWlXu5/g2velR7DTckhDThVhYQRGe4gp2pjEh5qSs87FqvHblano/?=
 =?us-ascii?Q?x1KNbs1QMki2y03SexzqEYPP3AishSWmwyvJtNtrNA01czgcaZ/jxjkEPxHj?=
 =?us-ascii?Q?rBadVojRhHxCVSn+UP2JdnE/Er2kxWUOY3c+yHJHlJbt8zcl/D7WV8jm9T+5?=
 =?us-ascii?Q?RrBCbF86Vk68R6KBeWUKL3CDaEQlaSr8kGWMhRL/RGbNl3YlTtjLdBrH9gzZ?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0634f6a6-116a-4500-4a79-08ddfb71f1b2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:54:56.2397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWMDRHzdsVKln+97qI4Y3OoijYO6xgM80551LTZ94oYQT61u0UXL1d5vDS7ZuBpklCze+MSUg5vQX4k5Biw8Q34eIC8M4OyLd3fYaqEoHPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8376
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

On Tue, Sep 16, 2025 at 02:21:10PM +0000, Ciara Loftus wrote:
> The free tx mbuf on demand feature has been supported since commit
> 86e44244f95c ("net/iavf: cleanup Tx buffers"). Update the list of
> supported features to reflect this.
> 
> Fixes: 86e44244f95c ("net/iavf: cleanup Tx buffers")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
> index aac27bd706..4e4c5cc817 100644
> --- a/doc/guides/nics/features/iavf.ini
> +++ b/doc/guides/nics/features/iavf.ini
> @@ -10,6 +10,7 @@
>  Link status          = Y
>  Rx interrupt         = Y
>  Fast mbuf free       = P
> +Free Tx mbuf on demand = Y
>  Queue start/stop     = Y
>  Runtime Rx queue setup = Y
>  Runtime Tx queue setup = Y
> -- 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

