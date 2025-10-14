Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F9CCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 742A5402CC;
	Tue, 14 Oct 2025 14:49:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 47AB8402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760446141; x=1791982141;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xSdbRoPmTSGbXxfx8vNf+4BEpZ1EjH9KA6DgjHMooG8=;
 b=T2C+ktMUU+L3Tm2eekdRiqXBw43LcU8AmuVdshbOxi/uUj/gKbpitBsl
 L2tqBsjriFwW16/mDE0bUMGhsBJgATsr1t/FNdAipL88mdd+/1cfcXEt2
 Z8arIsU7l3NEVeRqY5XwVd1ByijHQwGAoIV8qGoZlwHgJx/mYtkJVuYiI
 Aso+mDnpmSe5C+UuG2KcYj+9Fii8G93v0cOToR1aT9gGniVO0MQIVXowB
 MHLy7o16l/BJQ55XbUZ4DkZg4WEzrm5UFvZliWbSkxUPtBnKPNrOrzQgU
 6zoE+F5GZ3QGO7sh1yyfrQOzjgwZ+uw55gnn3TqluDfjNjJgyJlAABmii g==;
X-CSE-ConnectionGUID: wCt1Dq/XSriF7rqiRJAb0Q==
X-CSE-MsgGUID: eh4HWpgFRueQvZWqHoG2jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62753852"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="62753852"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:49:00 -0700
X-CSE-ConnectionGUID: 4p4n2PCZSwKFB9UGditJ2A==
X-CSE-MsgGUID: gAksa0gYQy2oNTwELJCydQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="219017223"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:48:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:48:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 05:48:59 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkxYNThpM4BOCsloixok+8RFqgyA8kb+UCrvbEpRPHQ7Kpb1R6Zr+TKgj6gCawf1tE6gHyMO/o3dqotPZNr+rf0xyrv5lr3yV3wq0hF6pt2F5xkFm5m2d8kAzdfcNS3p2aNvbLc2EQTdtFRywlp5sLDDXD9/xfRZ2G32sh+7DyxFQXXANjHAaM1YEhhy18v/1IVWDJOSV2Y5XYnTglJ5hSz973HdSgUPUr0QDbOGxNxniIAUv1Ty/MQNJaKRGnnLxgqncaXyvvmDuEdVn0xGSCgzdx0ABfCsbaOwA9SAhKtPgQ4FsYh5rkqKdawRYqgz1AZgx+KgIroVlvJG+jua9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UMxE3/CaLuQ5bN+NuWJwM0/HFJig+y8RfL1wr4mgUs=;
 b=Ze9JillHoPrhvwkFA8Yu+wUJSChfAf0UueMhF48L8E/gAnBTCXPey1yV4NdiTnswFq3cwu+v1glBHYQFDVYp4eJsaAPd+r9Nxcn2l5fMIq6OF1Ef1LVQhCQF8wGrM3FdWrFid2+n46iavqRMWQBD5ZaS/qBogFNdchvyGtcz/Hd20jDxCeTcaX+e642l/2vmD4hMo1KJBFPYduJmqUBUgfPilfR2SzFsm1CDHh3LLevrbQ0/KNJA34rYDDmvxPdldbtOF9u9YcCWY/+7FKIfbnWRrjrfnlOTfdFW1cKimpTKmJK4gT3k8Gtk0TQnX5jv6VRZTD6qC/Mrnw0MlOF/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6820.namprd11.prod.outlook.com (2603:10b6:930:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 12:48:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:48:56 +0000
Date: Tue, 14 Oct 2025 13:48:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <david.marchand@redhat.com>
Subject: Re: [PATCH v7 2/2] net/cpfl: added CPFL devID for MMG
Message-ID: <aO5Gs9gOiTmgBSOW@bricha3-mobl1.ger.corp.intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-3-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014104511.459215-3-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DU2P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: ad34cbd0-f2cf-4689-38c2-08de0b200962
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?459l6IGqeq/i9Ie5EqQjAxuv1/r0psxX/zR9Ks+HVh1AIrg8ciddaO+6b6yl?=
 =?us-ascii?Q?Ao1lQa10B9By0TtjTEzKiDG+66JjfKRB9Cunsp4+5ZLv6AS+Q+K9n2DlS3MZ?=
 =?us-ascii?Q?jTzu4Li7CjOn4PvCOjsx/2SJywKv8NdYkctWJeGF+rQ98RfvPfaKo+cG4LiT?=
 =?us-ascii?Q?OL948J3OeQSjQ+3SQV3AxmzSTxSmM6jkdlY8Zdk9QnjietdHn8ZUZ57M8xKY?=
 =?us-ascii?Q?k4FQ7InPs7dEjVOuh2kckMOnSDmHy795W5MepHi0mWVLXxZsN3QR7u8+9DCf?=
 =?us-ascii?Q?gIehCUNIVoYfSGSDEaWvwj4cohkDfa5OFL4M6yyfUVzzn3FH1GELnjRrFi7H?=
 =?us-ascii?Q?Ppf1cnNbzS2AxeJ8T5Yrgi3fjH/ehsthjAvi12YqEyQMCgB4lLjQ/wn4GPsb?=
 =?us-ascii?Q?q5zvtL45LTb9vJCKOlEW3QMKjQh88UirP09uII2CKaumvErBS0/InqabeSd8?=
 =?us-ascii?Q?tXY9QErxO0K6rv0KNjO0lFvH9EPXzG45DEZwUnddR8uBP0GenotrNi+xKYqi?=
 =?us-ascii?Q?nm9XSLndqQnut1J99WT7kiin3qZEu/E3libOYWqrHgGts/6JC5FlogsNnS0/?=
 =?us-ascii?Q?G/fUjRLWie9Cfy0Q1FIwb72AOZuSK2mMrssGgL7WVveGdY+rlDBrAKDtolXi?=
 =?us-ascii?Q?KUqPeWEb0pkpm/YWyE1e4nV9ARaPVDgxEW2X+IfrmmwEesj9/4jokDAJ4/Ht?=
 =?us-ascii?Q?Bv1bhea6JvcRIpf2bjPWLQVs7tBeaeMzQ8f6UUWUIXDcTRbAiJVYOG1NKn86?=
 =?us-ascii?Q?e10WOpJD1U0ouzv9A20LLQs587532duXgNTB7m/RjEhSSYGPt1wzwjJUDJnk?=
 =?us-ascii?Q?vzOUK0Zs0LP3+w6/RCPCcMtGoBqGzuVaVpfp2RRzlnxG82CgUnqhmv6x4kUC?=
 =?us-ascii?Q?Yel4bIcuVSzqRJpLkrqczvBrV2yg/Kdi6WloSblPYq0YVtnOpwOu5m0DJOTE?=
 =?us-ascii?Q?P+Uu/5RfZZ3YBvNtmDO+GAlaac9EQNPe9vfBPOtlrleghHgOuONH7vdZ7J9b?=
 =?us-ascii?Q?b36Airs5toDF8PU5OrS8bbMQ72dSmzjuv00E7ZS3c4nWl1zGji6YHwgDNPTk?=
 =?us-ascii?Q?z5G+8ldrQl3ULifOYWfII5O2XzyQdxh0arjjSsZ5XI5S9275n68ChMRr6uoP?=
 =?us-ascii?Q?RYtWaCDGGlEmpk0VFOgzgXZ6fDpjvTN0MeB31//taIeMjRaAnfLH68Cz4UHk?=
 =?us-ascii?Q?cmToqyaT9r2J2dEaR6VKF9LEf15cFq1P0jiilJNCb+he+9gxdmJfQSBK3gRf?=
 =?us-ascii?Q?VgxgWniOudXYqDdbdC8KEbuGORtDgoqMdGaH+1DKOXbtYQ92mTiw+OqYmk45?=
 =?us-ascii?Q?BKFme2excw43Mj8Qvljx6pLqtTG/S470g+F/7FyD5oECKNMt9ox/4AJ0kI7S?=
 =?us-ascii?Q?/fImubJ/foDYXzX0xOMmIdwl7acbTVYfKLKS0rgZDuHVNYjoxzImQReHhX01?=
 =?us-ascii?Q?34d8I1xEWKwSVljQdSAY/uoBu1neiXae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jy/BnXY1Z3QEjMT/FD0G0QOL8qSWPrGRG8QLHocW0wSqwJ9jufwFKps5/4/+?=
 =?us-ascii?Q?DNYmfCKxH4MytlyTqO7parOm5S4466kylVqVldFITH2pSuDUXSX35ZHLcnyi?=
 =?us-ascii?Q?ugIlZo3ddz0PWuZNJMf0nBUvKN0czx/KZdsNxk2Lxj54nb5cuejLmSl2so1T?=
 =?us-ascii?Q?gCfwzUlfVUPMXaHs1uae7iNzmjvbdPL6SvfR9ikdwn/ZplZx055KDTbfk8Xq?=
 =?us-ascii?Q?aG/S9qZoIbc0R+o2xNnt2dlBS9PLm4G//DrkqrXnDqoIWRKoIQdgg9a3mx88?=
 =?us-ascii?Q?2gY8IBIQ94OuThPOUMQu/wv+F0SvsEFZI0S9ECPxUuszTJgEOhYGYMJljP+K?=
 =?us-ascii?Q?4UxMrJNUqkirna8RoA2DBLlUu4MblBISznThdT2nMS+479cwxxB21KJs4X2q?=
 =?us-ascii?Q?XioQQ5+F6DSONuQLXnEizEV3g2TFaJU4YuHoaJ0Ai4pA5ZhyNQxt4Y1HHf5G?=
 =?us-ascii?Q?joQzHOMARMmzdAC08iS+rHC+IPaXpU/Irx7ViAjCYRbL2hjK6UKGLXNB4J9n?=
 =?us-ascii?Q?4yKXyBGpSpJ+2CjmSES/esPbelo2eXM9etjs4QP1/6R4ADibfzPYKx3iPyaW?=
 =?us-ascii?Q?hPw5XPTA05vE341BaKVb0kHrQL+AgJa6F5lyXWqU8ah7Df6zRUxLxxGJZJuW?=
 =?us-ascii?Q?m904L344HDRQWQLv3KDTH7dXF4VHQOLIoeITUg3O/bSQ4gc0p6B0lDpYAdV8?=
 =?us-ascii?Q?uqDzlYnUyzVYYXjFkj9XTij2RmlIRAZ26toA6vuHdebjnaNEE6Pg31M62gGU?=
 =?us-ascii?Q?aG/t+UWHlze/I638XFEvzQT49i6VY9XZEysb+i/x1rNk/APxIBXvx2Zm24PX?=
 =?us-ascii?Q?QDQWLIzB58WirH1PadJVX6soLtWxetOWRqSOJZf+UX0/B4jylfKwAdi+9wJ9?=
 =?us-ascii?Q?mkB6ApoakUqQylyNWQyeZ8FNjcxE58xYUzlFxKtijLAPSJ9/fijXB3vWaPut?=
 =?us-ascii?Q?8ivoFSFqk2NzRxDH4m46IhWNX1+NFG1b0Pxcu148ecQFWw2vQbgy5kAj0JJ1?=
 =?us-ascii?Q?MP4yuP62UcUMMCfu85EjEVfMkBOH6NVvP7t4Gv4shqZW02/AWDOtF41dXSS/?=
 =?us-ascii?Q?mni+li9+mQI+9iXkwW1LtRq92CitQXqiVG4TBU5yBngK9Q47xqO8mRmwAZzS?=
 =?us-ascii?Q?/mCr0U4NmZE+vtqmbHVcXP8pCS57Egf/oeLdNs2ehe75fmYzSK1hf4jaEC+h?=
 =?us-ascii?Q?JqqHXwq8GfOTWBcPZElZkNiNGrD9nQONLf0jKAwjjzTu6iZTTnYfSEAy2x9B?=
 =?us-ascii?Q?lIf5HdiPE8MWqYxm7iYRWVXAw5515ba2uiDo1X7jmm2U6bTDyb5cOJu0WOhW?=
 =?us-ascii?Q?YZpY0co8FwjavPnhtV5zze/jYZiKJFW0zBl3nd+JhQiZiDTDRKqpx5OzbjJf?=
 =?us-ascii?Q?+9xdRfmLgfd5rbIfZgbLcj5f/iCXZops8p/2P7Se6fKbzdpTGisiaWaC9i8w?=
 =?us-ascii?Q?HdLXhaS2z7KXXSbCiGWALPGhiPIDd6UU5vwQc3JCobuGwby3PjDMpS7RECP9?=
 =?us-ascii?Q?3Hk0ofRkvc9kt6cckLw4AFxXKxk0qHH6UJtJbdcwU34TS1HMOM21rF47rX7E?=
 =?us-ascii?Q?mR+BMBqDrt2tcugv1oSG8USnTC0NZ58AF8kPfgOkf2PMYOiyzTsNcWaC3fNS?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad34cbd0-f2cf-4689-38c2-08de0b200962
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:48:55.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaj5n5xGwxaTfQxeuCrEH/Lv22S542uD6Qv67riQSQDyfKjZEEL5nilQd/KQad+w0OKqhEG3tRo51p4CnukWl1KdDlsMFQjEO/r2EI7zf08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
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

On Tue, Oct 14, 2025 at 04:15:11PM +0530, Venkatesh Vemula wrote:
> CPFL changes added to new CPFL device id for MMG.
> rebased to next-net-intel-for-next-net and fixed conflict
> and compiler issue.
> changed macro name IDPF_DEVICE_ID_CPF to CPFL_DEV_ID_MEV
> 
> Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  .mailmap                             |  1 +
>  drivers/net/intel/cpfl/cpfl_ethdev.c | 13 +++++++------
>  drivers/net/intel/cpfl/cpfl_ethdev.h |  5 +++--
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 0dcd8fce3a..7c121cf5ba 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1665,6 +1665,7 @@ Venkata Suresh Kumar P <venkata.suresh.kumar.p@intel.com>
>  Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
>  Venkatesh Nuthula <venki497@gmail.com>
>  Venkatesh Srinivas <venkateshs@google.com>
> +Venkatesh Vemula <venkatesh.vemula@intel.com>
>  Venkateshwarlu Nalla <venkatn@marvell.com>
>  Venkat Koppula <venkat.koppula@caviumnetworks.com>
>  Venkat Kumar Ande <venkatkumar.ande@amd.com>

Mailmap change should be in the first patch of the set. I'll probably
change the patch order on apply to fix this.

