Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE2CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89553402DF;
	Thu, 15 Oct 2026 16:36:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BE3B44027C
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075012; x=1823611012;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zSJb8Ngu0e3K8W2EKsBTlO7/P+b/fGEPWIDe/3LSWA4=;
 b=fDR8Oejio8pThwLhvdCmvjRriMqcrhauoPJKW2QPIZyfL+LAtRx9NhoG
 iciMKF/tblGKgws8JXqNfZXQsnwxndcUD02CMPSGuU5Ww4oOjzqR9Eb4h
 9+djRu5MikAzXVLOOVGN0EtyXVcoXZj01+po4P2xTkB7kHL8x6bFdQkSr
 bkEYn7H/SUEsGbSByq5ZBSDLItzBJwfjaJaV5IOmti21xOKKZCRAXtvLW
 IMfUVxPFb919prCJwTH0jDKSZ2COMqp8wYo3KW7AAAe9/MdD62gLwhQFd
 q5R6cwAE1VPo58BcepsbORQvBEdK74Az4/P49Y2rOeaFmihl/UrUDpDjq Q==;
X-CSE-ConnectionGUID: hK8PofiERIyUgehpjVoUjA==
X-CSE-MsgGUID: 2qbt+QDPTdGiOldbeKduoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="948953"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="948953"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:36:51 -0700
X-CSE-ConnectionGUID: 79xlIQpBQS2TpTgMIkYUYQ==
X-CSE-MsgGUID: HyYhrJ2zQZua7TKWLuoxSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1957505"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:36:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:36:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:36:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:36:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCdEMAm2FVvMqFQogVGKuHnTde1hI5t/uy7pUiuUH7ELyS8e67SRdsUQLitDj/i+w5EvaUX8h51CA0TD+m4Bq1m/KsRXOOEn7bvEO4CwCZf4hrXonLX9l55IM8a4eda47jKs40h5xJCqVJ3Mm4d17usQSmeIh8U/qGiVrEyLT0QaiiNfOcpHWj9kV3+/W2FJRFc1//bRlcmkXbLGrRee4lQHGVffK+xK6zIeeD31kIA/82OyPVVqzBll8yDP6Loipiuvu15+JOuo66Y5InIqIPuSvyKDJ57qW9Ap5WAvMjGVH081spWOEQ1S7kj/s2FZrFJZ2KNnbrrwN3UlyTpQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nLaEHpcR68RDhH6uSOX4J5/+eUGfPAVwkOLksZw8aQ=;
 b=ajPX51Qk6qCB3TirxBwu8qOSAHKfuynQG/4Pd1LPS6Gqxvr3HDYdK6vlh7t5qLiwm7iou2hZMsk5Ax9xfUMT8TrJ0cUpiXwLd6d8/k5ZIm/IPLl7J+bCID5B1O+Mmw+gl9kvDyYQDA9YPpq0W71LHG8CrYSznl/DrsPe3xBRZJMqTf6zVEzeRebwvAIA7HAHUOCgjWhm9XaenO7YBXyuRhfSnERiB51F3xtoGBdcmazZOeanOi2nn/927ZV0zM4zoO163B+4RU8yNcLiUiTUuVCubFUNaFEm4YqZREbwqybD+7egEIUeSjujObZfstMr1Y4al/F5eG9H52zC1qMHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DS4PPF821BFB4AC.namprd11.prod.outlook.com (2603:10b6:f:fc02::37)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 14:36:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:36:10 +0000
Date: Thu, 15 Oct 2026 15:36:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Kevin Liu <kevinx.liu@intel.com>, Qi Zhang
 <qi.z.zhang@intel.com>
Subject: Re: [PATCH v2 3/3] net/ice: do not include private headers in testpmd
Message-ID: <atDk1fSEoCYA8ZZd@bricha3-mobl1.ger.corp.intel.com>
References: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
 <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff393eb2eef43c9ab3d27824badda9743e717a98.1792074055.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB8PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:10:110::13) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DS4PPF821BFB4AC:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac92b03-188b-44ca-a8f6-08df2ac9a7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|10067099003|260925021911599003|3023799007|260925022911599003|260925021311599003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 18AudlsX8ZnoCysJt1roZcqLoRVSYOa7fwj34IWQseGkbGFEvkerbfs4KORxzxzTkSpSZLz2koPX5Fll1LvAgkOc7TI6IT7qMMGFE33TzoBt6esYKIArEXPkUm3HloNgNO9mU6B3vC4ce54aR0vRhuNfx+swXFAxB1kNXmfMlLMO94D+mT92yJ9X/04ioAyedkhSkS8kyRNAZT0tg3doTdCISHzdt9kcZjOR3lh//lDdugwiNhparsr189mfzugiuspGfkZu39GbRjxk515kGZyAlqrEnqqPS7jt/GStK3G53f6WRhwu7XsyKvLJwn+0h/PALCt9b+3ajrMgJA3P2cMK6ZVoJKqQGQfqXE6x/IO2eifXu8PC4V4Uw39C+FVyAMNoE9OlY8rBSsHM3gNKZOR2q9hOzO3M4hRZp+CMnP+KG3NTHrBHeT086qTT7mf6KQ+N06EPVAB7Z3PYymXXihbZJWNtQ+xC3l9jwlUdnh5Pau8nnde2PywX8rTw898yrFaqaA/FQf2a+vDtmxbqYV6UsSC9ThkLvkbUXCWegNbUm+Di7W0Mr5fhLGf/VFpUjnS4pgEPG+yJuiF1Dr4eZvo4TkIKI2vW4iwi8XWA8eE3jNRg/eJWGvkoHN3ld6xIUqI1Z0OJ3vmj+ZZ60jiXeOkoAyjkjGagPyoOfwkh3tE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(260925021911599003)(3023799007)(260925022911599003)(260925021311599003)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6iBNWINfBAV4QHgDCjSpvD27UsK2gPcaJ7FTZR7EwpVuMJyyG1ifgSR08Z+W?=
 =?us-ascii?Q?fG1ZtfGWiOVLkZ0Wjt+7wcPlCcWZy4ONh+TNg8XchL0XXE0KPQ2iZXUgCLrJ?=
 =?us-ascii?Q?Ih4+M0TCUmkxNJlrSobbCAOWDOSJ7inQNlfH3gD/bT9j81ZBVMt1Dn2rOcZ6?=
 =?us-ascii?Q?dqLvJCfbfzFl8T7XxbE3hdP+GCcvzKLES2NFZfhtIZx7xN3T8vnrmwNhKif2?=
 =?us-ascii?Q?40c2rBQaYsx+MI9qIGDR2KFbdUwsDXjsTMdFzJXGrMk5CZdwylOxq8g9UcI1?=
 =?us-ascii?Q?jhmdFs9U74IGSKkv79LcMBiBQEDxDI5BBmUth4kuHFp/9OAjaI//Ti8EvnxU?=
 =?us-ascii?Q?2CLa9ssGt12F57lboijGbaX4/giQm3wzPtQ0z+1cfXqNkTLmOcsHgvj1r+ug?=
 =?us-ascii?Q?aH3aZHTEWkfZFi3Oy8D2ivbhDlopxrwBIoTqiAn6aNp3sZrTd/vpdmTXVRLc?=
 =?us-ascii?Q?tXqyZ39Kaw3DUYpmZTGQ47LXnGnqlOHDEXItC/F4epdFMHuUzAasMpwzAqbY?=
 =?us-ascii?Q?SU7lqrh/KTl9Im3YJk/hSd+6l0o7go7Zcxsc2agQnh/KJSaxneaj318lW6Ja?=
 =?us-ascii?Q?AYqxxOFI6oSMNYskEWTNx/TlsxRbY4WslEUJCj2PyFQUzZ4fNYI7u2PNQANI?=
 =?us-ascii?Q?s7zTurtUyDBVZln0F0PrmuKXS4qJBlmRnQea87JoDWhDFPWCREM/WP7r4Flp?=
 =?us-ascii?Q?zfOQ3kmW7ykxP6w6MqSJY5NMqiNnOWGvAwlFTAknuGbu+UIplz7K9IXWbFmv?=
 =?us-ascii?Q?maExk77xqRebBGxlS5/Ji+nygyZwXRDiL1Jy9b7igqx+x3sdFDAoaE2whPgS?=
 =?us-ascii?Q?ADEjgI579M0DlPq5Qd8lCATdpAkKKMKkptELN2d6Va5fCvNSydSliOWVd7Bm?=
 =?us-ascii?Q?Nh+WqZiNsk3q0jPfU3i6dX/s4z6EIr5UF+qSViytM+0ikZNE2b6RSdsvfUf/?=
 =?us-ascii?Q?FMFtJJ/KbIJgsTb4qYJAQeH6uP1sTD2dJsn+GB7l69F55YnZJ+RdFv8duMgK?=
 =?us-ascii?Q?QF69femGHi33cSa5D77a2Hb96zDZMC4PdE4a/x0F+W7t2eriiUUvAf3mNkC3?=
 =?us-ascii?Q?9N9/Kzh91mdD8TFFwbzncFfoHvQwEkvZn9cacfabm7eHtk5YDxH/H04T/+Il?=
 =?us-ascii?Q?sPXiSAEQH16AgYGKPU0ZZdAMTKUA1EMhabiE2q7Wp25RvT4X5p4J6lSGbuSI?=
 =?us-ascii?Q?1iJMbimw7/pxfO6bSlXhu0Keua7ZmxbjrQggVidg8nXH1alTtcHY9gMaLbB4?=
 =?us-ascii?Q?6+q0mLcLTgeP+IgRjRb17NIn8/0ANCVjf9Bp0ZEScED2Go9+dsIge5qkXUvi?=
 =?us-ascii?Q?SsH677Otmoy2WDbBCrkhXV/KKbdHUA3YTSb3W66ybu8DbkPNGd821qAUWpeV?=
 =?us-ascii?Q?zzci7B5JTV5nGqc+09mwX/Pwyhfo4PtVQxeUf7G53aGWISwWAv3tLtYr+Uki?=
 =?us-ascii?Q?5SSVqMmA4ERtIQg6xdNEuPsPQJM1CmPbANTwmD3m9CRjpqV3CLlJrxv9YwQa?=
 =?us-ascii?Q?AmvIlhOfyuxYowz6yNAeoaMybInbwvGmfyrg/IjjP3cmgxI7A+zRMt6aAGEW?=
 =?us-ascii?Q?c8kO7DjL5w2WoemLaLbRu4vVZtr2u3vcaSjRhzjad4iICq6SRNw8fjg4s90X?=
 =?us-ascii?Q?wqz41Etf0yAhfGl/x9MMRv4l+LucOI4X8aUlCX+KNjPamG0ZZ/2TrpKgIhJZ?=
 =?us-ascii?Q?QZTbqNW193yyOl3YkzZDp2SokHlwIB1bnhvjcEk+KHVuIvJlc0UlloRowT0L?=
 =?us-ascii?Q?ATMJ/LXoBugpkTEGvBo+UrnGPzHfnRY=3D?=
X-Exchange-RoutingPolicyChecked: AgXsCyiCqFV1QHigkrScsHpHPJioD7WgXwpEfOqD9OWyN6qvz9JggIVg1WlLf77qiRD8BsbaltLHtuYyubRPG3A+b/NrcFX8Ga2xlfIfuQ/ueToaSUIQIcGyUFf6ePqAzWlZjoddN1DyZgyQXm1IhoyhAxc9XCT4eKTUi78mevYcPZuDXrkwx20w7DiHYISd8sK/YwN6wwgq56MQVvu3DknfxIuAx7gLw/QBdb3sZzqI7n9PY0MeG6qoU4RJcdDRT7Q4aZQ71DBT0OpmXmDDTFthTC82KbxBmQbmWFENGUvxTHmUdZDeP2UJ9fJ2II8E/KBUHuT/DJp+q2EC8fdGpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac92b03-188b-44ca-a8f6-08df2ac9a7ad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:36:10.3245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nzz8MN2wsWIJSXwaDECSArbKk9Y/EQ5nrU3xgE/WINVna2Q3nPmqt2pxwpg2dACTe9eJkBFsJr9nlHPNIY+Yecink6EsgahZup8LTHAlpFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF821BFB4AC
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

On Thu, Oct 15, 2026 at 03:21:04PM +0100, Anatoly Burakov wrote:
> Currently, the `ice_testpmd.c` file includes headers that are only
> available to driver itself, but should not be available to applications,
> including testpmd. Instead, testpmd should access them through public PMD
> specific API.
> 
> The ice driver does not have one (even though it offers a testpmd file), so
> add the public PMD-specific API header, move all function definitions
> into that file, and get rid of driver-private includes in testpmd file.
> 
> Fixes: df539aaf35cb ("net/ice: refactor flex descriptor protocol field extraction")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  doc/guides/nics/ice.rst                |  3 +
>  doc/guides/rel_notes/release_26_11.rst |  2 +
>  drivers/net/intel/ice/ice_diagnose.c   |  1 +
>  drivers/net/intel/ice/ice_ethdev.h     |  9 ---
>  drivers/net/intel/ice/ice_testpmd.c    |  7 ++-
>  drivers/net/intel/ice/meson.build      |  1 +
>  drivers/net/intel/ice/rte_pmd_ice.h    | 76 ++++++++++++++++++++++++++
>  7 files changed, 88 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/net/intel/ice/rte_pmd_ice.h
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Given where we are, this is probably a reasonable solution. However, I'm
also thinking that maybe we should have a discussion as to whether testpmd
- which is, after all, for testing PMDs - should be limited to the public
APIs. Is there not a case to be made for allowing the per-driver testpmd
files to access the internals of the driver for testing purposes?


> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index ba598742c5..e4dd87649b 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -1021,6 +1021,9 @@ To start ``testpmd``, and add vlan 10 to port 0:
>  Diagnostic Utilities
>  --------------------
>  
> +The diagnostic dump functions are also available to applications through
> +the public ``rte_pmd_ice.h`` header.
> +
>  Dump DDP Package
>  ~~~~~~~~~~~~~~~~
>  
> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
> index a4f44e5ebd..f3c820a72a 100644
> --- a/doc/guides/rel_notes/release_26_11.rst
> +++ b/doc/guides/rel_notes/release_26_11.rst
> @@ -118,6 +118,8 @@ New Features
>      enabling QinQ tag insertion and outer IPv4/UDP checksum offloads on those paths.
>    * Added support for getting and setting link (802.3x) flow control.
>    * Added support for Tx rate limiting per queue.
> +  * Made the existing diagnostic dump functions available through
> +    the public ``rte_pmd_ice.h`` header.
>  
>  * **Updated Intel ixgbe driver.**
>  
> diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
> index 4946ace7ae..ecfcdf5559 100644
> --- a/drivers/net/intel/ice/ice_diagnose.c
> +++ b/drivers/net/intel/ice/ice_diagnose.c
> @@ -13,6 +13,7 @@
>  
>  #include "ice_ethdev.h"
>  #include "ice_rxtx.h"
> +#include "rte_pmd_ice.h"
>  
>  #define ICE_BLK_MAX_COUNT          512
>  #define ICE_BUFF_SEG_HEADER_FLAG   0x1
> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index 8d5e17e2df..08c2b61519 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -821,15 +821,6 @@ ice_align_floor(int n)
>  	((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8_AOC_ACC) || \
>  	((phy_type) & ICE_PHY_TYPE_HIGH_200G_AUI8))
>  
> -__rte_experimental
> -int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size);
> -
> -__rte_experimental
> -int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
> -
> -__rte_experimental
> -int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
> -
>  int
>  ice_tm_setup_txq_node(struct ice_pf *pf, struct ice_hw *hw, uint16_t qid, uint32_t node_teid);
>  
> diff --git a/drivers/net/intel/ice/ice_testpmd.c b/drivers/net/intel/ice/ice_testpmd.c
> index 98c02d68c6..0c135d79a3 100644
> --- a/drivers/net/intel/ice/ice_testpmd.c
> +++ b/drivers/net/intel/ice/ice_testpmd.c
> @@ -2,14 +2,17 @@
>   * Copyright(c) 2022 Intel Corporation.
>   */
>  
> -#include <stdlib.h>
> +#include <errno.h>
>  #include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <rte_pmd_ice.h>
>  
>  #include <cmdline_parse_num.h>
>  #include <cmdline_parse_string.h>
>  
>  #include "testpmd.h"
> -#include "ice_ethdev.h"
>  
>  /* Fixed size for ICE ddp runtime configure */
>  #define ICE_BUFF_SIZE	0x000c9000
> diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
> index 322d9597d2..00077be30a 100644
> --- a/drivers/net/intel/ice/meson.build
> +++ b/drivers/net/intel/ice/meson.build
> @@ -19,6 +19,7 @@ sources = files(
>  )
>  
>  testpmd_sources = files('ice_testpmd.c')
> +headers = files('rte_pmd_ice.h')
>  
>  deps += ['hash', 'net']
>  
> diff --git a/drivers/net/intel/ice/rte_pmd_ice.h b/drivers/net/intel/ice/rte_pmd_ice.h
> new file mode 100644
> index 0000000000..dccfdcd5f4
> --- /dev/null
> +++ b/drivers/net/intel/ice/rte_pmd_ice.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Intel Corporation
> + */
> +
> +#ifndef _RTE_PMD_ICE_H_
> +#define _RTE_PMD_ICE_H_
> +
> +/**
> + * @file rte_pmd_ice.h
> + *
> + * ICE PMD specific diagnostic functions.
> + */
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +
> +#include <rte_compat.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/**
> + * Dump the runtime DDP package configuration.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param buff
> + *   Pointer to an allocated buffer. On success, it may be replaced by a
> + *   newly allocated buffer; the caller must free the resulting buffer.
> + * @param size
> + *   Input buffer size in bytes; receives the size of the dump on success.
> + * @return
> + *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non-ICE port,
> + *   or a negative error code on failure.
> + */
> +__rte_experimental
> +int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size);
> +
> +/**
> + * Dump the runtime switch configuration.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param buff
> + *   Pointer to a caller-allocated output buffer.
> + * @param size
> + *   Input buffer size in bytes; receives the size of the dump on success.
> + * @return
> + *   0 on success, -ENODEV for an invalid port, -ENOTSUP for a non-ICE port,
> + *   or a negative error code on failure.
> + */
> +__rte_experimental
> +int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size);
> +
> +/**
> + * Dump the Tx scheduling tree to a stream in DOT format.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @param detail
> + *   Include node configuration parameters when true.
> + * @param stream
> + *   Output stream opened by the caller.
> + * @return
> + *   0 on success, -ENODEV for an invalid port, or -ENOTSUP for a non-ICE port.
> + */
> +__rte_experimental
> +int rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_PMD_ICE_H_ */
> -- 
> 2.52.0
> 
