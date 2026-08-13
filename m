Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4101EC5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 14:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6ACCB42DA1;
	Thu, 13 Aug 2026 16:36:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 74B8740298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 16:36:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786631790; x=1818167790;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BoLDVeiT1cjBxZyM1FvFm17mywjzsUx//tVqaXN8bT4=;
 b=S+sMZfHmf4xuZGNMmBhnGAg/TVhHyihUFV+u6RDYlkVC0JCEurJ1+HQX
 vK6MxLl3RL37mFBVkDswwtYy/0gpGLKcAfvw/1P195KBA1xypdIhviwq3
 y5kzhKMDIjvbqlVR0cz+xFEQDYSW9xfV0JhLr0CH9OWpPP0T2/ATBetHM
 6DdS9PWOTyHIj0DN1l2LrKbMzT1WyYtI1Eph7xGIamaiX5Y4xPbzPgyjV
 B71JN1ghCrek7XH1H02N3yfziqfPZ9PZSpxXLgPJnwnGxJux11go+gn/a
 DeX2gC8FE8cqRICua38LwhVjXdsXSld9vh84ARTKHrPmqu4uuueJNQvz9 g==;
X-CSE-ConnectionGUID: 4IvXHb5HSIyBEHEFk4V84A==
X-CSE-MsgGUID: 3rx9/l+qRHm2IF7mepjGQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86327120"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="86327120"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:36:28 -0700
X-CSE-ConnectionGUID: YfzVQzHgQfqw0trtTHvRcA==
X-CSE-MsgGUID: TsLJsrWRSpKzs7+wV4aw5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="287399085"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 07:36:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:36:28 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 07:36:28 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 07:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VG29S0NIseH/bb6ttaJxFNvGtjjR9hXelNdolkMLLghgS7BCaNbSDYNiXZ6/4aGyU7yeaqyC1+Uwm22c2hsYlO5OYkLYm063cz0XsVUz7HXxIUQUHPF+aYqQ4reo0V5kJPyfjqQU1TmQrC8JiHR7X/Ro4rP39JiPT0opuU59/YchEjieT248jbTygUiP62Dz0rq3Uwf/Yd4EAPpnLlPeaT8+/vzihZoGkFEGAoBV8CJ4Lq7CrDrZFKKau66zRdLqYT1BdOQVIBiPFobrgEd16TeCc3GWU/0Ixe5FoWMmEIbddXNVXvBqa7kfYEB56Qkv3WbPn4cSx8KrWR/QbZyTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTC7AB6RHCvs+3f+Kaxc1QXCh3RFryN1bKzF7S1lk/g=;
 b=CaJb0ZJyc3QCd/6yPpGF3yDxORYLsslEQnM9HONbLxa9PjX0r/JCryjASK3921UhxtimTTdAkU2YaDYJDJzZBR+89fvr/5YbzHPGm7sqxOMQvZhL2NY6ADKqCZ4LBLnqa8CBw0FMBvwMHBtm7hHaDhjDzS0NsEkOito9yFlBdp25bCMynCEWTV/kpXnS+IdrsfwwBFQB4hi0mcMwCY3X54qNTU8AuHdb5IhZJD3vu10R51can6JX7EOaMe5fR9vRpgGD3JGeZJV/2E66k1hnHxChtqc2YrqgmtFk9wOfGS8cTlfAbyoCWcRtH3CSlW3O9DY+qzP+O9hJ0ekUm/ZDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 14:36:26 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 14:36:25 +0000
Date: Thu, 13 Aug 2026 15:36:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/2] net/iavf: restore promiscuous mode only after VF
 reset
Message-ID: <an3WZTpLrMmS7IFh@bricha3-mobl1.ger.corp.intel.com>
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
 <20260805125735.3900483-1-ciara.loftus@intel.com>
 <20260805125735.3900483-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260805125735.3900483-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0066.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::9) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|CYYPR11MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 430a9a9c-b386-4ef4-4f7e-08def94840f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kusv94ijX5cSPQmahzwtuAKZtUiANTwI/KMyB+C1KGMVwoZ9wQmVOUjYJRfwXX8Rk/kMIglviajw8Bdax8ENPsXsWCwdc4Xnn5JwJWRbV/T96hfdOsyP90pEqz3sZOXFWspIcLfVoOENkDFpbO/n8U4IjMTuOCm1wXvcOr912iLvF853+Oh3P47NSUC0sFbCP42PdLOZPkoM3TAyzuyhngj6lZUS3h5kkuvCjSG+0jGeKdwVm1qvcXXkiRlw/XBU3u5ijopYWPdgDHtXynAPBoRqptN8UOLx6uAAs2YZ1V7NKv5snV4+X3VkkwNsKBWacfWHgCwuvzrJ73EDVW8lpLOhji/ew6jeHZV/Mz0lG3PPXCScu0oLfoWb2kz/uPwhqLM0KPYspmEbSYp7pC7/BA1NKM1IqEjjcuX6Jb3q4sB7JCo65RWOi6T6VUJacAUk/bTPd8CcJ8uBF4EM6GygNlaX5cfPRRWQaDM7uOQixV2gayk5BHQ+kRNnScITfktVgs9XWNS7onACqWHxypy7XhqtqljpsNnatZVQDEdrwzTuxr4a8uKJfZPNLJbwwudAscofS1NuYsesA2YoUcRe6DldXx/MDDf76KhDWNU805Mlt2up0A8s2Tn8sbKQFGoFMxBpizAj3tGpto2gFDilsLgnJreFER8KY3qMO7EkeQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sp1Z77n4VJ7WKPdRVbXkWGy3rWdPT0RL30jpgIanYnIOj36smUeIqaiBKLFO?=
 =?us-ascii?Q?iogIP1o59SRYwFsk4pM5pThEjdGiggfJWmOvZJ7U/1ZzTdU9b5xLnIBkVip0?=
 =?us-ascii?Q?10jD150HAb5I5XkN+nuWuNbG6i1Jl2HE1qWKMzgjA7gAgQDnU2+dWCyYlaHq?=
 =?us-ascii?Q?tiWwXYsAwFjX//BQR04EL8XsuDSthexQUNbrzc+/lye4B4fw87ULsUnQwN73?=
 =?us-ascii?Q?Tws6B1/Gjdllf0rniOsd011XICnRpWPrdgpWfrBUkUYTKa81PsDsGHAY0G4S?=
 =?us-ascii?Q?IuKyh/Dvi6j5u9TqcsGg2aoc+uwagbuomRhwK1fUfuqsyX9BlL2DjheiPiZb?=
 =?us-ascii?Q?wJUPzCzlndv0PdmpRR+rVzP5Mwprm0mN/TeG6JgKgi8KBWYAPzy/7erh8SVd?=
 =?us-ascii?Q?irX3/VN4H5xLUoicuPik/Nlp2SL3ZZU/XNo2GnE5HzvC/3nsLN6mCu8zAsta?=
 =?us-ascii?Q?rcG1PC+yz2iqvregKpaZUIY2iTTIqhpHYBgDB+BHckm8D9CIACVIsT9M+Fij?=
 =?us-ascii?Q?LGdWecQJMMJGj9gieuViNW3hKpoSdwsko0fNLvnYoSLnZVNDWTZDwSIArx1g?=
 =?us-ascii?Q?sGw6uQ4IYd7Jeqg4wndD0a2He4PL6M3SDRZu2PXCyvv2Ed/nyupSrP0wRW6t?=
 =?us-ascii?Q?UwGJReRc50bbi627Efa7VQjBS1UchJx0/KyDrzuCAZe3c5tgxvvai5UZOAek?=
 =?us-ascii?Q?1QYRIIo0nDt4Rqt/fD9h19JPEF2Obdujj/oAK1wdKlRwO5sdsWjeIb8a0i1z?=
 =?us-ascii?Q?xJWP+6axdi0AuFpJjBHFClKwWAEVDMQoHv/ikmMvSlGbiCU3+oZ/iiTAIdSf?=
 =?us-ascii?Q?eJ66IHsvTB+NFLjqQ68WeqFUfhd1gP3P++pR87fEqwXv89IEF8NYcfMh9Ejb?=
 =?us-ascii?Q?r7VhqTEk58BDycu4QlAoBxyWLGHiwj6PdPgaalbOZEHE36mKRiwcc77SwBXQ?=
 =?us-ascii?Q?70m3T83m5YDNi6JLPz5KJi1Inb6sONMwGCRpr5kOYE2BOve7SnxI4wD3Yej1?=
 =?us-ascii?Q?lrPbLqEeYzTH1NUpVpcvKbtlMalo3QuqLveW8cqZfcNfBjvi7mdd7iV1Ih69?=
 =?us-ascii?Q?GPPr6ejVpeIxMzKO0Tfr9+GWwU4eyjqXblaiK+rbYaJNitRU0GdZvqojUSFo?=
 =?us-ascii?Q?lRSFRd7zkRWeTEkvHsjyZfoodXF22qG25ArTB3PiN/n6ww8B40v8rAYzKK3n?=
 =?us-ascii?Q?ssOtB2v38OYWS2oYgcAh6xiiq2Eg6GYkYRcBadmxDXy0V48M290Idk37/1K2?=
 =?us-ascii?Q?Kv+SV+/gLAuPVjswvJd0D0pOcgM26CLP60w684GvV2NQ/nMCbDXQqGzFN+sv?=
 =?us-ascii?Q?WD7TkJvnQpwYTmMPXam+W7u41RHC7d+UdLA5l3JjUbR7FaqtKoIouwvEu4vG?=
 =?us-ascii?Q?/vIPxhtjFLQaRYe7RU4ejxua3B7/PUuGW5Ei2kKHLLiYW0vf1Kjlxy6CcuLp?=
 =?us-ascii?Q?D8GylC2tnQgY0P1PzWUQahkozTYIUAH6JYv0EPCN1xrWN+3olxTaBcANZsGs?=
 =?us-ascii?Q?kkKCcr+Vwa9MaBHbffThMuNpXj29rihKsyFtDVh1iOFhj2K4XYQ9wvlZOHHc?=
 =?us-ascii?Q?imfci86cH+fdJh2SnTvVs0dkFa6I8F0rYicc0WTexlIknwGLmb+1VL6TceRk?=
 =?us-ascii?Q?IhVVNha5uQ2pcZgEUO/1K8zaW0ptqesSpCS/qkn0Szfu8calxDHPt7oPQoAV?=
 =?us-ascii?Q?7XjStsO7saeB/uA+ATerqMJ1jXctof4EkbWqCSC95U4RiiuYx/kiEtfoA1Yy?=
 =?us-ascii?Q?vM+fYOnWtVkOcseuJ5uVweYI80An1/g=3D?=
X-Exchange-RoutingPolicyChecked: CJFDP8LmmPxzO3qwIcdZAIrDRu5jXjr2I1jGChgM6g4RCrSFcyWFU92fxe4GxlHSQ82XHAe/9iYk43oVxNWVPPTmycSaAo2gh61R+PGeTryuMCbG8PaIKM9BgciW1mUOjXxuIgtxjGaTZQm6tsHTlKxbnWo89v7D43KpL0GHs+y0OExlzBKCti5hg5wuNGPSxr39RrdVpwJhyKKwi5FubUUxHrkFoFRe6JASjy0mcYuL5gHFD+gy16VRpQ0jCZ2hYwCnL5gAlYxejryaKfpQmOp6srfwyyNVJMlZiQQSsYPNEPPIGsehjJIpGEkGGWI8XBOfCkaoCp7lmmEDYg9mLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a9a9c-b386-4ef4-4f7e-08def94840f1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 14:36:25.8227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZFEJ2JwLW35YvtkxN0f/7CIl/mBEroxFf+O1zTP7nMbBhW8CZcz91lZWMksnENQBePeQm9Ws5mL6aa34gXNww8uZjoVMQeFG9YJf6NZQ+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
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

On Wed, Aug 05, 2026 at 12:57:35PM +0000, Ciara Loftus wrote:
> The promiscuous and all-multicast settings persist in hardware across
> a port stop/start and are only cleared by a VF reset. Despite this,
> the ethdev start path re-applied them on every `dev_start` through the
> config restore logic. Together with the driver's own restore after a
> reset, a reset followed by a start reprogrammed them twice and issued
> redundant requests to the PF.
> 
> Implement the `get_restore_flags` callback to clear
> `RTE_ETH_RESTORE_PROMISC` and `RTE_ETH_RESTORE_ALLMULTI` so ethdev
> skips them on start; the driver restores them only after a VF reset.
> A queue reconfiguration in `iavf_dev_configure` also triggers a reset,
> so the states are re-applied there too, except during reset recovery
> where the reset handler already restores them once.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
