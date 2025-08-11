Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B5C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 12:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BECD24042E;
	Mon, 11 Aug 2025 14:56:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 249A54013F;
 Mon, 11 Aug 2025 14:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754916967; x=1786452967;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=CHePfNPezXwObJEl8vp1e8kzqYuY/UUsWARC62tGOnY=;
 b=Glz36Aax55Zsuoa5YO8MgZFJLmzYKbzt3gHRIsf/pyGoAqyL8nVOqZk6
 3DFOO9gjpCdInpPleRr38waSl0nDyC7wUuJtt2qx95TD4IRAERPUUeffj
 J7Nn/90YFP3WzmkhUEEC7WcdIzX9oEfhzSBbWm80DxH79LGmxYyjoQRCr
 ob21zcHdJ8gTmJvj1QRX/Uv44ImwHxvVL1z4QWLCsOOY0i9DhPa4C+inP
 32Op0wePmms9JnxkvFiqotii1+i8kKkU7ahs1/cW+Pc5mIJpLkf5dHMaC
 iRRHtmCx3dzTl3H5yAyN+Fl/WYnIkaHRqVkpFaCXidVSwq1HB3P8Jwtnj A==;
X-CSE-ConnectionGUID: 2b5sbS1xQ8izmcvKsQiSPg==
X-CSE-MsgGUID: 9lSeg68SQhmrx7zO2tQeyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56374582"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="56374582"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 05:56:05 -0700
X-CSE-ConnectionGUID: OEviHw50T3S/db3FWQrs5g==
X-CSE-MsgGUID: kb3NWGlOTRiAAsIcjSa4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="166315607"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 05:56:05 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 05:56:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 05:56:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 05:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1rOaaRqhMMqo0Cngv9e3CfwtNbk+YGkmCwDEW1HoXP9gq9uSOqqdl94tcF93k/Lw+Q/qNZ6LzWcG54rnhn54ZqdRD3geYqAF688QDEVdeHB4UO8bQaRWbanvrgxLIpE1T54VWH+LVVObLRdLsuH/E23V9wWj3P0ApmA2JWPPsamAxWSAwTV5Hf8dHNHx+1fExkFripla+ACYg1r7c7qyeCCO76SoQd3YkfObkttVfverFQyUV6qkXLuJ2HoX3oG9BoM7vPF/sPvEPLGIR8IfyIqu693wf2GrRa+F2SKjXPP8B968qOixehEnwAFsmZHk9IsR8GgDM6M37DfHO26tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7p8+h31/eCU3IZTG8Stl7JUpxh5wo/iDDvySEMjaZk=;
 b=IDOjBJYA3tmkadM3WplUbEpNg9ZF4O8ZOFWIIe8QMdSOzdJvNf2VrD3TO6sbjy2RfRW0CxMVMoQIpO95lp2uyErYMQkkpGYgaoTe8v1UsKd0VtdZ5IgsBKw8IGmgma00kfVV/mNjgrjkcJg/j1Mym6iC+b6i9YXC0lVSP/IuvM+0IDdyZLrSFnJwfdK9u4yDdyhnQTetsA2KKy3RZBQzqZHuV1BfD8mJZ8lIK6Q3/7ty/ToxXdsk7Y1/9exPnuZGPDFn+qxS6sIFa4Q1r7tgVIZttJCYJh2Pr8icoWfuXcfclj8WimNJ9mkrx90Gl94QJpYAvcYuSNP8GEwlkZL19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Mon, 11 Aug
 2025 12:56:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:56:02 +0000
Date: Mon, 11 Aug 2025 13:55:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH] net/ice: fix segfault in secondary process by validating
 dev_private pointer
Message-ID: <aJnoXIl_2iNqStfC@bricha3-mobl1.ger.corp.intel.com>
References: <20250721105522.1019515-1-14pwcse1224@uetpeshawar.edu.pk>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250721105522.1019515-1-14pwcse1224@uetpeshawar.edu.pk>
X-ClientProxiedBy: DU7P251CA0009.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BN9PR11MB5276:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f5fefe-0761-437e-5e49-08ddd8d66d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1l2HuD9LbynbCq8yflljdurIUdj+rgKRfhWosP2qsWQanyAIMbjK9kEr+cIT?=
 =?us-ascii?Q?QbH4wpHRkBuTNUxPSkjszGP4dFwud9r2/hd/o1yFAnhnPrTgM/AgUui477DM?=
 =?us-ascii?Q?LeByd2JQfWckqVjoreTbP0HOkDy5lyDXW5FCqp1rBHmK7jYKgU5muB4gXVpW?=
 =?us-ascii?Q?+mFjm6FQsG9aeMKnnvfGw8CC+fYipVbEVTwN/QVbtAAAl8LtsE35CWKzLhOu?=
 =?us-ascii?Q?8SY5NTuYm/u5yiG/uO3/IdIqhJ8tQCopXQMEOCQ2f78H0+VbQtVK0fowxDPd?=
 =?us-ascii?Q?Kol29gCNNkS0Y6gLKx5pgkuT6itwCKDIXsHMhjHacMukokr6O1jw1/MPFcrn?=
 =?us-ascii?Q?rQFMGUl4VbbMsLGIOd0M9O7J/RIVoNb+jdbYAIdp8GFDFIWPHe8PxVmte9WZ?=
 =?us-ascii?Q?cfWWWHKtviF8G0/74XKNfFW9qTwY8Z0cl6NATdjCesQtoDjGkelLcPdXs0H9?=
 =?us-ascii?Q?xkPaRM5efw+ByBsUGi2cq7Lus0Ksn+Pj1ea5RYeonV8VSkDEz2ePMpaaoKuN?=
 =?us-ascii?Q?MM5/DbttShJz6SkHUWynYhLEieEkLld1RnJaQncJmU7bE9H4yDWs5D+Rs8MZ?=
 =?us-ascii?Q?HWdw2NHkkH5D8sxuNdEMd3p5nJf95kTr5TtktFSKuXCALB20tj8gCYQCx8vv?=
 =?us-ascii?Q?z3Ml09LXBF9sQhcO00/kqgeAOuHE+3QUJLBeFUj0iYyBQGqNWSxFUGMHXg3l?=
 =?us-ascii?Q?ZYXxCmT53levmWAC+PmF8H1jxiaZICEIGxj8I1NTmQI8tk3DsnmS7No0IyCK?=
 =?us-ascii?Q?zVDdc+czN4h9W1636zRUBUSgwbXP3ujorkaGdhIbqVW6aiPGZ9xzYk+USFem?=
 =?us-ascii?Q?PfQWjYoh71y5QKaMH5kqLMAn9FFe1vLSIskLLt/eeHJwin6KJ4mMxaScsX5c?=
 =?us-ascii?Q?yxmr+6doZyhBeEV+rI2GgWvhrMmoGw3Ro+BB7Ijm3n/E8ccbnqGrtuQAGNXN?=
 =?us-ascii?Q?zyo3XN1w9n3bwiUbLvC9ntafiI9smqvVkLwz7bkKB5FdyStUOJE/qGzcFvyZ?=
 =?us-ascii?Q?7zikifuB2vtqI8rnT64k4R9hWn8uWT4SbVusRr5NVWZeOuZMuyRtiKrgSw6L?=
 =?us-ascii?Q?ALKLh7D6YzsMYDGenCyHrTiOtJSpnQvizWylhMGOB4H/kIP7+/aWB3s2PJh1?=
 =?us-ascii?Q?UItQPa7Kva2tJzSfLL3VSUCRiMdXWNBrHeKES0JorapERQOQqirAg9La+4oT?=
 =?us-ascii?Q?WnLZYd+6snHA2kGzImeBtw7NGSP05IS8egafhpNFM/c/yYyoub19ekCEZ/3f?=
 =?us-ascii?Q?qfeBexjnfpeZxYRhLiigbvMq2Kkym77bERKHrqXxYCI+vkVtIVugrNRT4Z92?=
 =?us-ascii?Q?xjlxj2HFJ3NwBPTivwvFUqPbksayBPP9bt2GiTHhl+ZO5Sp7w3IK3ntOGZlS?=
 =?us-ascii?Q?wVjlMxnDGuwHEXXq+XWv+C1m2lEFpTNCww16m8QUem/WSQYhevLGOm9NaAer?=
 =?us-ascii?Q?lMlCIy736ZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wmgtSx+q4Gri4Dxwwb2RguvGD8vB2+Bx43SR2Qq82DLCydaxYS5buq2eeuNk?=
 =?us-ascii?Q?zGUfTy7Od3aY+lsd9fA/13RuZtBq6R2aRIq6CddAqUCHfXQveTXSlxzGbyVJ?=
 =?us-ascii?Q?u9zVElRd7gN1V+jXQJWpCvPhdBYIazzQpWKQ+baXzEXJTFlRPiP6cJQBm0pW?=
 =?us-ascii?Q?tT4tp44ZpELqyuDH0S24XbzcpBpCiZLKYVZn7AxgU1tYyLTAItHjhLbxihhk?=
 =?us-ascii?Q?VFimxh5YZBHQokwItZ/DBhzcC8RdpTlsw2jvyxGo0UcOldkOAXuZ4R0W5dRm?=
 =?us-ascii?Q?ggx7UBk/BVeceYzJqWLiVdF5HJGNnygCbHAZ2hVHoK7c9NfaGwEHQj9xQeXp?=
 =?us-ascii?Q?SVcU4n05Vn+5CaidgUASlVOxo2z8FFNbUer/3qExjeK5ny/feyxUPIgNqB3g?=
 =?us-ascii?Q?Rms8a8eB/lB3g2XBb5SxrU+OkVjj4pK4z9ah3Zus0MHogukwaNi74UqPMS6Y?=
 =?us-ascii?Q?cAa4pdVsYCcTFVmV/4GUqxtl+42TkFe2couThfMXdyhWKFIjfiiETazVBpTk?=
 =?us-ascii?Q?vhtzKiUumrI30XrydKKDFjQ6tOgktS6awplrk1yrMrPw4OB/JP0bKJyGRLD7?=
 =?us-ascii?Q?vIvXZhBdY/PXlSbGumTz0bcDO0yBYHgYpFxeHC+/CacB7/uPNihCCwCxC5sK?=
 =?us-ascii?Q?chfN2+FVgF1mSBurYPDp5zLfWl3C8xHbAYCYiXNh5XbV6quBq+NNN9mJXIKI?=
 =?us-ascii?Q?c5x3xXTy82bcP1xDH3KUuHzV/Wt30kGnjNVvDptQfrIWs0nI2Z312xbZbJ7Z?=
 =?us-ascii?Q?BunryfseN+QW0XusPJcoQBW8fRTcBb7aEV+4km/pVj1w67F4qFfLEuiOVcsi?=
 =?us-ascii?Q?2omPnvL3lYwlVv+wz/IxPPOJnZ+ulB9RsMNdZNSGuKkFtFnUWUJ9UuSUROG5?=
 =?us-ascii?Q?VA9fMcpUYKlPe2C3eVmjJK4jGiYe63JDxV9XVUqueh1tFrlmbP1V8yP3Mzlh?=
 =?us-ascii?Q?mQ9CI8dq98YvhjfSxZpWZvsh/ZMWiVkgEkK9VdHLItzWiavwOb4ysTi87rlV?=
 =?us-ascii?Q?hlJv3q/EIH1iNJZAE+Oztu3a+m2nG/I/0idHzvyTTyniUv51OBwzqG5QwKw8?=
 =?us-ascii?Q?zS6l03JzfkldMx7Q/cVOj8EaokvCOKCK4tq7J5mEOI4cV4Vh3+JmPBcmrewN?=
 =?us-ascii?Q?hi6+YU45pgOExEP/D6JdcIC4cp6y7rNwsB5/LjQ4ENpRXL/6E08vlrNhQo9g?=
 =?us-ascii?Q?cSzea3GTh+C390jp004aWa6mEesA2SGaYvdFUROrE75qaK4EjUNEqh5yWtB/?=
 =?us-ascii?Q?bRmOSG6lmYxksBWVtX6wjA85a/2YQ4ETtVrvLt607mx1jpLawsm3Lf1sG3Yn?=
 =?us-ascii?Q?G2W05mP7HRAZpeebOS5Hx4uvUZRIpxdBqSEK7Z2Ix/yitWfQeB3On8vF8X0E?=
 =?us-ascii?Q?e8rXF79dzBnrIcRAd8esJJp8MoRT40p4weHlBqxDCGf5aG2hddt2QSYUGMGy?=
 =?us-ascii?Q?xfXZAGlPvo1Clxts1ozTAxFmNHWxfch79WQD6KxewdiDUBZpJu8rUpuFJO56?=
 =?us-ascii?Q?c5Rm7btPYVqc92kzHlzzZkhkcF2Fo3DEB6K4l0OUpVY7K2L8oc+QUruCJPOB?=
 =?us-ascii?Q?GV7sN6NJewf3rgOAv1/XgiE4UV3ibonyV+K7fD2UEKPBZWbMbHBdjWQCqYBk?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f5fefe-0761-437e-5e49-08ddd8d66d50
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:56:02.7110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMKXLDtpJmVyxd01Aqrdp0Koz1AxaP9ej4WYbdBM7Wpn5vKNGMH9Q3UWU1IfbENFBM5NRJfRbZI4mt23j7X/8v2/BT7D7NgqyHcLF/c2+HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5276
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

On Mon, Jul 21, 2025 at 06:55:22AM -0400, Khadem Ullah wrote:
> In secondary processes, accessing 'dev->data->dev_private' directly can
> cause a segmentation fault if the primary process has exited or the
> shared memory is unavailable.
> 
> This patch adds a check for dev/data/dev_private and uses
> rte_mem_virt2phy to ensure the pointer is still valid.
> 
> Fixes: 690175ee51bf ('net/ice: support getting device information')
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> ---
>  drivers/net/intel/ice/ice_ethdev.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
This is not something that drivers should need individual updates for. Once
a general solution (if any) is found, will consider a new patch for ice
driver in that case.

/Bruce
