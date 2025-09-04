Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C44CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 17:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A6744278F;
	Thu,  4 Sep 2025 19:02:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id AE25040275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 19:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757005345; x=1788541345;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eqCN4hNeYU/CrJD2hIfLhUUqlNbH+cFhqiJJTkg1idA=;
 b=ZhAehF1vreJfxW7IMRHrGl/XLwG3LAYQo91tfB9kAOVHH3xsBRfMLwsi
 oJRWcwri74rDGH7yCJvwPiSa+Z6hP/OxYO/j+zeGwR0gvEmuVrScTURug
 /AvkBCsbJQwPGUmdO7ZymXdoO29r6m2f/Q3X/xn8h7FPlnH1PH8vAiv5V
 5G4IAuukBy+at+GiDYBqojkD3UT6noRRZI2sOfIuBP0sc2uTzuKMoCwNG
 SEAO7QWUKT8ngXSHJ7o0pAzA88F4x4g8jX49xwT6+Not2AJ/8DRO1DOaD
 ftdOHBaVtMxrPJ8yi0AEciJoz8rTe4CkVmuNfxZY+U6PnPM/yeJpnskLC g==;
X-CSE-ConnectionGUID: ITdxh9XRSkuQ25zBdoJXmQ==
X-CSE-MsgGUID: +tgyexoxSDibF9K4JHLBWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59293357"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59293357"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 10:00:52 -0700
X-CSE-ConnectionGUID: nGV/mgctQoaWZ3TewuPW7Q==
X-CSE-MsgGUID: 08zASGxcTYGbIqREPWtFWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="202880489"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 10:00:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:00:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 10:00:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.73)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 10:00:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXjyZwTrkRhh0QJ9HD9F0PUpQlIzt8UAx1u54IhNmdnC1eUAYSUlzMtmeXnrc6nupqhg0qtNvQzY2tTkl/QiKrKlA7aY2oCI25E/CllCqQSNR935TWe3bAqDeLoHXZ0H//E8Ym0IGBifMqJS04EW1wLdUz1XnJLRHNl3PUt1Tr0U8FR/w8P8cD8sgLDO5mnEl368a6+GdqGHLWR+COpw7T2AiiTTI35HONIzQl/8xPfKCRoaFPr4orauVMrU1xG9VvwMZDsuUN1SBP9Uc4IIQUMPqH6LKHl8IbGD3/PGv3INCxWCfEo5nlmy1T0sMKcJH3PMUZ8+nzSS+1x1V+K4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWQwis0dyUOUgwMTfrwqgitFZesgS5JYrBiUrqtHcz0=;
 b=l4Q4Ktx2pPURwmoeUccMspoGaYIAeEOvtil0Y6I3PASrIJIyn3lhwVVywbAmdp19NXtoS2tL/uCTWqRYd671s4G0CVVikW8cioqhLSxeUNogeAnYXIS8tvli0v3Cx1bKisJnfheb+fizTNHzqz/O0WsKuamgDqfOmGmtBs/gYvnR/X4aVXRQt+JjPcZw0IV8j+ZAW3GeBApe2erP0FhdnUq6twRgegGGeo/n+zTqWvFUi0rO54ITodxLEDq+EgRMx9ZgaxLeOGHVO7g+12XH/9C52b0oqySxCyb6XmaMAdv88gnlBAgtoC/WEzWR32Vt/rZ0iRbKU4LHlFsHUJX+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB8968.namprd11.prod.outlook.com (2603:10b6:208:57b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Thu, 4 Sep
 2025 17:00:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:00:46 +0000
Date: Thu, 4 Sep 2025 18:00:42 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/3] net/iavf: fix a log during Tx path selection
Message-ID: <aLnFukvLSe0232B_@bricha3-mobl1.ger.corp.intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
 <20250904104440.2167205-3-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904104440.2167205-3-ciara.loftus@intel.com>
X-ClientProxiedBy: DB6PR0301CA0072.eurprd03.prod.outlook.com
 (2603:10a6:6:30::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: bb9ad91f-96a0-4fb7-e531-08ddebd497ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PS9g1mE980uRVW00Uih2CoGKOCSte5yHjI0pEOF9R2wd0/qCjM1uzgG8a5jc?=
 =?us-ascii?Q?UGvtbyXjLfDgwbMMnqqo/Walqcr2tY1TV4bXtihNqqy52VXrBXHmIYZ8g36G?=
 =?us-ascii?Q?OmY3Fp3uFBzNb9l+cMrOa7YMG3vR63Gtfaf+8vFEWd7rwmtNOIeXQctN6NW4?=
 =?us-ascii?Q?Qw9V3cGspfr8aakNli+goteg5gS7CGn7e6wxDNHn0vlnQFSiu8g30dQahiJQ?=
 =?us-ascii?Q?lj+l+EDn9E85Ty22leH1iUPImezVPVnQystUQtWoPP7rPJpF/KANB3x/8xWY?=
 =?us-ascii?Q?KJl9U3+S1d/7wm6tqWoGmpnc/YvxrIyHBnJRxODi+kCkyQygeYQakmzSB4yv?=
 =?us-ascii?Q?cF1mlDF2WGHdtVBzKk+R4JDAupsGBIxV/5jCcVs6cROxk9J2l4aCMgNqAzvH?=
 =?us-ascii?Q?bmUJmzDS/ZRtgzly3u//nTKhpf/L51ybKN1xCiNqVc1D/EiGxPyIYzlEbDuN?=
 =?us-ascii?Q?JXVLQ3kvFq9ldFvBkdePIc3RnrtJf08MwQxqSJA1xe5gbr2obt42wo9kSe5C?=
 =?us-ascii?Q?wPhBAE9uaSlATJyt0bFO3/KDrPRmQJu1IwOyQtgfVw/L7T9ZP0CQ7ihT/c1O?=
 =?us-ascii?Q?kIJe8dYkDbjy27NzKuHcm2HBtQDVq6wdxGXAPzQ1oCC0Gpc7mC36FuTFA9I5?=
 =?us-ascii?Q?F/vVo9s61r9tgREv0x+1+haVqr7sPR2A8PwllT9KATW2tYbf4hVDe7YBq9vL?=
 =?us-ascii?Q?Y6gORLVxvU3l6mi9dqEiNRmoXoB8DBzAJDgAqMyibYOlVuM0q+qD2X4Q3qgW?=
 =?us-ascii?Q?G5l+TMh+XeF1h6ONa6+XPlgb4/jcAgp8mPQ7Rw9k0c2V6FGO9FVTc2Wy3zMh?=
 =?us-ascii?Q?yUFRwtQo4NSfm0pjVkTMlarPmVzQPE1p5eiXvqQbYDhSlSTJYDUnXpXKPTD7?=
 =?us-ascii?Q?AwOaXUWB9CouCxZhN9SoDzN/6Lc+eYrqk97PI+4IBwHulcTExDe79hbHKcME?=
 =?us-ascii?Q?C9TpvT3Sc7hPYTKBoOymO51gLRkW2CElEpsGYOXdVKC9wNO3CePbe9/KAySV?=
 =?us-ascii?Q?ajsrnLrT0aX7IUvjjnHu527L+mj64t5A/Uz5EUegaALaoEraErBDrNPX6Khw?=
 =?us-ascii?Q?6ax45GWvs/Cn6ofFTP+H2piYUc9YK1Sh7nhd4QHI0bTtqmr0kMuESTczXQOQ?=
 =?us-ascii?Q?+Dd5aq6Tr9AOV+63Rh/KUmbYLw0cmkHuYhouj9w3t5yaw6Op55jgm5kEWGbY?=
 =?us-ascii?Q?4KpIDARFB9uBsfCAwgXEQlDAjL2aASO1HE1VUWS1Cxk5mjjkR4bB46H0yhUK?=
 =?us-ascii?Q?v3bb4d4/ChBVxyp1xVH8PfXCdXvoYTc4UOoeShMT5FeH6Wnk7ReKoy3uPIkR?=
 =?us-ascii?Q?RqSLwdMAcZkvP3FiF+vYMKOIWNdPIbZsreV17wvxDpkvVKw0stnripPwRP+r?=
 =?us-ascii?Q?7PUPRodaPKXWFiXRUcW9tslR0yIVXlHrB6o1oIu7GXwRZOsCGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grPsUzoyqwoTzy11DgyiRDnHdwkIV5Xq+YglAJgSW/6ZTF/fqysxUWMTFekS?=
 =?us-ascii?Q?CFicZhvvV3kH0sTNPTQOrW+/OndTQTvl2/kzOUJI5f6VMO5N61rPaT8khT4M?=
 =?us-ascii?Q?koPFMHIjU7Tb/G9avAYJOD9dsA6N+Zk9/syz2BbwjBokvl4y4O0WdbO0lgT8?=
 =?us-ascii?Q?FCLfndTfMp8aOjHqfgwGBR1vTXb1+gQOBXJ+0YjLmacHf4tIoFxrGdnp0BB7?=
 =?us-ascii?Q?wY9cHkC+AACgtbcJ/N4zv/DENpT+Fpi5i6gAznyf3jqyH9uMEkhbY4gQ1hXO?=
 =?us-ascii?Q?XHt8aadzs15Qv6nruNSnWnygt1HGsS6lTYhlxGcIXhVLoKXctQQqjsaoGEgH?=
 =?us-ascii?Q?YXHwAtm5NSgGUzeWI5PNEcC5+EPaPduDGcCN/GIT5wB/4heHOKGIc+IHz03V?=
 =?us-ascii?Q?929qAjd1kiq5G9CBdEesl5NJPrJu76e+NDii5mdrrDrLTmpTTrstMlv4bFck?=
 =?us-ascii?Q?HZPqcU+NNMsC4m4MOOEe74/NDdxSDKXtB2WdA7/9+FXCzKmViwsWSPo+6r16?=
 =?us-ascii?Q?kxYAOX3u8IO5M9anbAwcXPA1+Xdivz2dpPC8nRTF8zw4k7CG6OJV/Zuqiah1?=
 =?us-ascii?Q?rb0jZ0TaPcL6NS+laOUDuvI6bJdWnp3yXXvalkWe+RA3DkcEk2gTaXPWdeGt?=
 =?us-ascii?Q?nC9sljk7I33HziCcWjWsFiK83WBrTYtrnCjgtF6JlyeN27ZCMs46W/w7yvHh?=
 =?us-ascii?Q?qNcGr093bV67Ibo/Kl6ihU5NbDjqU0a0TC6qp7wPp3nf/WkhZjMO8f1lu+is?=
 =?us-ascii?Q?6ubR1YGMPcF+BLAQSiK7hs5QLfpw3zFLgupK5jDDi/2YgEDN6xBJKJaqsta0?=
 =?us-ascii?Q?NP4MisQ5Q/0llhfO5rzTFhJaizp0yOrhRxuWvuTr5m70Sea+VKcmRsMyGgXC?=
 =?us-ascii?Q?TMHMcDPCAieTiksGRDZIXmsZaSArQeaJUe/hoT8wSxy2ClM49Bu+5v9sn0Gn?=
 =?us-ascii?Q?LwuyE/EsGukoEEsvQZzWbE7lhbu4WPOCtFtRHxsX8HBNZft4oO74M3VvP9dG?=
 =?us-ascii?Q?Q7q1SjzynWR5phvXyc2G+peH2RuNfOzzyKysXJC4lIMCVHo/Ir8OAjxnejxD?=
 =?us-ascii?Q?DyBfCW0JaZqyEYE640XkhcYcNbzefme5qePMdGVN5uBIz5NP9pL/4b42ktb/?=
 =?us-ascii?Q?7NlZHmKba89q4J0duk5Gsey9Z4/xNlA9ubXcZiIH8XfJPY1SDB1KWXSF9jqs?=
 =?us-ascii?Q?Vg3Lp6NNjFOuDVACX49242PO5LkJXcP7bfTet2RULWGY1wm4g05lH0zcHkl3?=
 =?us-ascii?Q?dB7vIQ2CJrrr9acxGCLCAfmsX+mBp3knpAZO5EpbdkQnNvLA+4w0N4WaBlAr?=
 =?us-ascii?Q?TBS1HJmAl2SOZuyg8YBAQIfVINCbtDdjMC/q/AO47grydORvbxg74QcrwTc4?=
 =?us-ascii?Q?M9qw85nz/zJlL6x/7keGcQUVgNofhIWANQpx3+Cm93aLmtSuQ/DCtiBXsaKD?=
 =?us-ascii?Q?twdnHuP2L+liffjNt2by3fCeuzBrmLgojFUGtvpPK9n9ALWPAxrK1BFDssGn?=
 =?us-ascii?Q?UoxiN+L8oNT/uA6TV6mU3n+v5DS1dGUPh8cGI2SvEv0GMagAJ/sgaPZwsH5E?=
 =?us-ascii?Q?nQUXnOA2zm11DMkfncOD5Tq8Qx7J+OPvjzWhwQLBfo+hsD4YQTBTxfXgNNsO?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9ad91f-96a0-4fb7-e531-08ddebd497ad
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:00:46.8477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF/Qark/U/uZjKaAdKy2pYDRczzJI4gv7MKubj+GbuR1A/Tl01iInNBjx1J09vI/Wpn3HELkiFbqtwoB3fTEEKXnnd25zk9AVI3fv/k3cXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8968
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

On Thu, Sep 04, 2025 at 10:44:39AM +0000, Ciara Loftus wrote:
> The vector offload context path is now selected for outerchecksum and
> qinq insert offloads. Update logging to reflect this.
> 
> Fixes: abca31f780e1 ("net/iavf: support VLAN insertion for the AVX-512 path")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_rxtx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Will squash into commit on next-net-intel

