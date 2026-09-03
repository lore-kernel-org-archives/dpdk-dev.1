Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F0CC61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:38:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66017402D8;
	Thu,  3 Sep 2026 12:38:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 841D54028D
 for <dev@dpdk.org>; Thu,  3 Sep 2026 12:38:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788431909; x=1819967909;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7iMhqwCkm/+15eHjOfTH23T5Tgif/wFSd4JSnb4nc14=;
 b=R3chpObapRNTQIOL7xJ8W0huN0F2laPmirWDRKHtMzw1pyWk24JyxjAO
 1BQZ6x14zSATF0IQmZ1s/4LpX/jX4Io53pUxLrJxysqWBV4lmCmXIrQDY
 cEjMnBtf9hSrM1YLh9wVDTCxyOKi8VqLNCX5ln/K5q/NfJJY4fylFqnl3
 ik+Bm155giCMRTCV3qRLx80Ya1mkFE3sJHf8l/5sLlRpciEfF2hmMjw2n
 w1iyyICrDRpTgprpnXIjwfe0ZUaC60wBneym75AhbxRTvXAvZvA9MYIWY
 RSSi33cPXg6+oExjOHUoiDFT8V/lhZFf2WRzxgH5iAOLF5GmHvjPjTZL1 g==;
X-CSE-ConnectionGUID: kVx/KlfMTeODgekR71/1Cw==
X-CSE-MsgGUID: LszAmM7wT8+shdBNvwPn9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92731142"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="92731142"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:38:27 -0700
X-CSE-ConnectionGUID: wv0JkgE8Q560Mf21cXHtqA==
X-CSE-MsgGUID: mRB2tiSUTiif3moTKeNIUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; d="scan'208";a="263491847"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 03:38:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:38:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 03:38:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 03:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjNjE9ze4onJaKUGSCwqmhhR0gb0ltMFI9Vc1nePrkm4K/Od8LsxPR0RSgz7T5mYJZHyF0l66IH/+35fgjNg5VYfN7oqx/JmSkWFK6wvDErqBidl9IpHINvjamaRmvx8S9lAj8PPcIUnurXSptd8Q9061dD5cRzWdAE6F0tQDEJGRoS/o19KhQff4b1l7jkcpb3h/xYuae8A68oW3dKyL72K1nnvsBY4qjjTHKINtUYnWUa30M2fexlai34yqw0nMhM0TFw1STy2V/M1vLZfj+6vtgV5iD7wuqxhqKaZCef0Es01VTW8Om9eJ3tD5dMFfa9ixeo9/KoZXBhU5JLJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1IlTcHz4JjPEa7/aqdHvNTNGWOF7dcGhx5xX+LRnNc=;
 b=w5HrLxEe2VJ0NhBXoCQowP6WITo56zIU6ixtAD/XI9/c63XDDo/9Go0+nmmeibSnujog5Jt3gLZ62Tnxv1AigAsk+KFVch9Kvff+pL9MYYsbK2RcAbkBhmWtENGdb8Q6R8xXkHpHkJCi5QkS4BwkPsGsLlGi9HY8Qz+j4ZMwl+cu2tA1vfQQp0JRLc0YVUwiMh4jLWWGgXeo+Ih0qdbAgSbfo349AUqc6pLwq+jOkrRxCu/8dY9lz5sXY1LNdBplb2f6tDHe/Kq2pP+qE/DG2/FgV9ajfaHZbjaKjrJNq1dqH+KJHZZjitkiy9v2y8wNykX4UH7ZKkfN8nIw5Tye8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:38:17 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 10:38:17 +0000
Date: Thu, 3 Sep 2026 11:38:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v4 05/23] app/testpmd: remove support for flow director
Message-ID: <aplOFHncrBBHJo__@bricha3-mobl1.ger.corp.intel.com>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
 <20260806051004.166778-6-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260806051004.166778-6-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR05CA0026.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::31) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3a9d57-ba02-4b81-54b4-08df09a77702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CSMGWJijgS00nHVt/2JuJBORedk4jCpPFGGiF4+Zp+RKaUKXQRKHf/XrMGKpSosqBZNa7ppx1kIzF24FT/yH0MhXrP7YaKJ463+YJyt3RyHhNwrYbMj9QK/V36UafeJBuXcRZdjIxUcFeAnEoJZlMqj0iRE5EvQnkC7iC5mDgx02Cug3xZ5FEvN+qpx7nGzHGN/ZwdnKyti/HYlWm1AZeKasYjaDvw+3Puc4boVRh+TtyHlLOmqkHHjNdbUv3IZGES9QCzJGzdohhH+KHhITD3RCJQ/pVIshSsBJ3a++pCHguU3zlzeH85gJLD3XIy1PyWtfW+zKwSGNLykbPhXTnErk5f0JRz7iLaKxlqN6hbsKTgxRlPTm+qDQQ7Z1LRQeuCgKWQ2Nbuo+sTJ0f6stjTDLArPHnwGw55q34YH2CGldWe1HV8FXV3i881JvP6WG2Gt8g9aLf3ljgJAiMUckKlTh4ih6dxogGwPxS/ehJxU6j6TLMnpAcNO7DaILKnEStFnHxleAuSje7NZKrXR6/XEs0L8zWAn0FEbAqURgDjV/KTg6IepNGDTbmHr9n3CCnLPqujgdDM8YQORxaLazlK7i+rFcVSfAOBuM/Q/zVhlzU1ckb3cQnjaUKge6DfL0ch2IHcUFgqhflB03Lq6GgLmKmCPPHYay3vF6RDYsvnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U/ho4rNOgEMJwjzrvtliizPpaz2UORNuxCYGga/mQTz6k2f3CN1lT+1+159E?=
 =?us-ascii?Q?RYq+OF/d2nEDkWw+z/8jt2IztUzhcQwZFCPUtkrN/GFGKmihy/UTcWeoE8F+?=
 =?us-ascii?Q?MQI+yVu2+WaC/aL7OSCYmflIp6v2JfAAJNj9KYbfR8+5F9yhbnMItPmqrwM3?=
 =?us-ascii?Q?FotHbQYfQdCWWCxiSIoqtBpLFFAtOVv2pN+IrbhUVN1jNXUieETRvjscXCNr?=
 =?us-ascii?Q?zuRvmJLJowXq1th0PrvJJffRr0oWCgM5uu0D/GDxED4xmmc3De+dbnsvXLl1?=
 =?us-ascii?Q?hzSMiHXLY5RHbqoQv7tGnKCuAFPZLtlK/INYNZnurt9pgvy/mtjlbBiscPVq?=
 =?us-ascii?Q?dpGAtdd9L5SoYnUJHWC5R7jBqp3dQJWMoOUUwCMaRJkFUxD49c9DRCR4ax0+?=
 =?us-ascii?Q?X66sirtX3fyr8KYQFg7jcpQ02bhGV6ekZj440qtSxaAhS2zqY0/CmF4y0lI8?=
 =?us-ascii?Q?9HnEmb61Qtm7ntvWxKB0W/XqGmoPFV1k3GoowFV0HaULpQg0X4l8890mebEq?=
 =?us-ascii?Q?+DQdh0gU8PpwIwfIEY/nYKNFBVbP4i+0zVnNOQQKDJBPpFrZiH8faY3St34q?=
 =?us-ascii?Q?z2dTof7aJG0iTA+WG5vmlpkOkv2s6QqBTJmpCZcRR4fvbZUHoebyqYC1vx3E?=
 =?us-ascii?Q?W4ARJjzC1OH4XjuVo1vJuk83pleOdwWPRouRfzID7jFuOjGMcIvDXr35zqI4?=
 =?us-ascii?Q?tZSwQCGnUzdbKpIyJ5Q02HCowBrCWb50xrpqFpSFMOlL1E5Z5Eb5t+uSovPx?=
 =?us-ascii?Q?nj68Aiwi6E9uzpO7+FI8nPJi472lCpCogI6aLEyUANuHlOBJm8B12QNxEj6F?=
 =?us-ascii?Q?WHEOMyVqWzB4MXg+32VddgsTwyTwm118WzgCiVn5+uGJs4dJarMWfL80g0oV?=
 =?us-ascii?Q?2zJ0T9Wh8VwgZP/HL4NED6HvnOQZwp8QAalgr9wo7tyucFIVPOEJj4O0zGrH?=
 =?us-ascii?Q?JgtkmXsakdwi1isgoE/oz2zjqzYOAkrRAZYZZsBHTVwCsuoeGsVRlrk1XvPt?=
 =?us-ascii?Q?TihVCgtubwnnOHzM3xAwmTKvS8HptpSXsWNFID9HiKXUd6p2Mb/SfwHm1IGg?=
 =?us-ascii?Q?uT601aa0rKATB/kmxUXJxU5oTu5X2KB0mAVo9o/+/MjIvtY5csYHFYhn9SHX?=
 =?us-ascii?Q?xy1QJYhp9jXS1XqdiCwTuh8bof39gVRp6LyGocrRALdtN6f9SIGGaTZVWyT8?=
 =?us-ascii?Q?J1i+FrOC1gvpkUG1FuJC9Wk7pifM7YeBE5xfiGTEtJ0PmYQmKSqAsgReInP3?=
 =?us-ascii?Q?SMdapraN5l6FU5t06oBpLlGEuYfy85Oi6/YOnZc4jaRol1Du9ex8Wq6BrwZh?=
 =?us-ascii?Q?w0GOpILaqUf/bnN5zFGZ97wOfmo/x6V7ZZtFZt7agmR1qnngAlVsjO+fD04y?=
 =?us-ascii?Q?aPEmd7fIUlewo7ndRu36dXyYWUy+r2/AVohotj9MC4Csl8+BQu8JDR0vxRDk?=
 =?us-ascii?Q?UIgJLcdoWgcZCziIw/tLFO79sNkra4GfYGwBPFBKIl2vGcEjzJClY3WpMVk1?=
 =?us-ascii?Q?FzvoIHJxZN6E7Ma08IqK+NWkcnnXq2RnGqajVL6a4yTJlTrLeBudQDpYtcW+?=
 =?us-ascii?Q?LXurq1dgwhJkzv0gRMTO8FV43O6jPWROyV62OqZeu5XZD+723zY05KNClMif?=
 =?us-ascii?Q?jOn6eRR3MzWYfCVq8gTRx/5EXlWwARNpZUK8tmlHP+Y+F2wMaoASXgMr4nV4?=
 =?us-ascii?Q?AGcIUgoXMak6jk9vNWTeM/u/1jG4Pum0YEvVZsOgG3UnhmHVcSXr6k9rGWd9?=
 =?us-ascii?Q?tnMwUFhZF12Rb1jgzCXaLK6p2U8Yyvw=3D?=
X-Exchange-RoutingPolicyChecked: vp549kxZWgpsgrEsLExdDDtDJjTfuZZTxwLyuJ7wbK3DKVJIjIRCLDCHxfKN+RGcPGDHIIjDuYIWiAcbM/+TNddurzy4BXDR0ZJnjMzohF5v8Gj8c6WJACpIzeax/p3wIyEd8dbYyHhDvJJYvXCZG4Y/vZXer28Kd2BBGi40yRzPAasoTzf3OP8nvrj7bwSf1RBrxEisbPX81T6tPx14YJ6GTpktbSNM0Iw+Rhiu081N0RvoYsi1W8xhOB53tPmlJ0+n+FYQGZ9Gka/ThW6G15IB0iaVxoKH/otYJUyJBnSIly74bLE5ORRpPjyS/ur0f/uYv6lBTqbcKSp7iOqR1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3a9d57-ba02-4b81-54b4-08df09a77702
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:38:17.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHPPc0lB36GMgU1ELEYSdvwIXmk3SaX8IVFLGzZj6Y3+v3e6e/R8O1dhOj6a7XMUiZVAuzj8qFsvUh4k/LpSUFy42+bI5uXGVgJpc741QBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
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

On Wed, Aug 05, 2026 at 10:08:59PM -0700, Stephen Hemminger wrote:
> The legacy flow director API is deprecated and being removed.
> Drop it from testpmd; the testpmd CLI is not a stable API.
> 
> Removed commands:
>   show port fdir (port_id|all)
>   clear port fdir (port_id|all)
> 
> Also, update documentation of testpmd to not refer to Flow Director.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-pmd/cmdline.c                      |  21 +--
>  app/test-pmd/config.c                       | 163 --------------------
>  app/test-pmd/testpmd.h                      |   3 -
>  doc/guides/testpmd_app_ug/intro.rst         |   4 +-
>  doc/guides/testpmd_app_ug/testpmd_funcs.rst |  56 ++-----
>  5 files changed, 17 insertions(+), 230 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

