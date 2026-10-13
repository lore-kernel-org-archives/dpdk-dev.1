Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB973CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:23:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 918994042F;
	Tue, 13 Oct 2026 18:23:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 7C7B140272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 18:22:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791908579; x=1823444579;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TkfZIpAazAyNFu7i33Yr0lNJj+wNX9T6bNJZDeDY2mI=;
 b=DDwAqB4k/WQvx/aOZVN9Y+QHr8lS0fl0bpclEs794sg4iaPosjI5FcHz
 tInuYX3CUKtj6jlb0y2joRbMcxoNTlpG79vq743kecVMA7PeyXTIfX6+g
 wPsb84yRDYY1gd7lEeXCy771ckb1cfLjj+OEtMwHskwxurStFF6A4QaaG
 pY0D3loJcTgjN5s0sqvle9JZtQVUXyRxGXG+LLOd5R4DEN2FqAyCsOm25
 f8EklgR+fZhQ5NDjEAVdq/Y1XYukQG1pLGbItPhUhq6T56+OM3dHgLuaY
 l0kWt/e6/jEUVeOwtyghiim32TdD6X8dRmO8Ymxmh6qBqYdz6U2x2MvFY w==;
X-CSE-ConnectionGUID: o7x9261QQz2CaaTIIf1FyQ==
X-CSE-MsgGUID: 79ZAINpyR7SVJNKN8tsi5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="541348"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="541348"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:22:58 -0700
X-CSE-ConnectionGUID: QalrHo0kSQOfnyCIKtr4vg==
X-CSE-MsgGUID: RvppKIYZTliDj9w0V3cowA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1272290"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 09:22:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:22:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 09:22:57 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 09:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEdGjUzWYUvwE9LP54pCdbKRieA/XQRFH0ywympAYQAafpIcQ52dB19MkPO3NmG9X7wMBuOoAmEeZiCi6oKoQR1Q9Q0AtiCK5i8j3Xnn/7iM8LLpQvyc50Sc1JEbTktLnCXJ4plNaaKiWnC9vhp0zXsyDLZ0w5ke17J4P+jmkxgCQZpLaP9dSZyDTc8ktMHDTrhjeY3zZAaes02nxPdnVOSpaUXOUWIWc9Ju3YumflTb9026jyR9jj6sQ7HABdqQtr0+735nB6HbCuq5RdPAkFSMDBuJkleWlc4QQpVktzNdE3EKLpSprNg+9Js52Rx9rcJQwNmIlgpgWGQGh5UCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9ECRlUQq3bbMRMvcxQYHMWLRMjlnmmtjJOU1lOusqg=;
 b=MZH0TiMRL3SJHqUkjmGQLg9Zz2j1iEANBlRZMRjSekGFI+BoTXZ1VuKbwHYNb/VkJZWWglKmGYVjeV86O8ghaFUVsEUg7Ho1aKQ+rIZfTtsjpm2nhIMG6xsj0O12QlXflNDyiKh+t6C7oLKF5VuYL5HJVN4D2lGe8uM0lSNFk5KJ3Aum5cs5oglnBssn8SU8BjFY4bv42yTPnpiGSFWAk0ZM1ocfxRrAiAt8xn4tS8M5faNMiz1O1x8n4OuBHt9yFm8znPJDG9bvp/AtuJRyOzSePXCcf+6oh5jO8tpaAP0o8OXPaAY1SCx/UYsh3zWQzzBfJwHFU1JVEe0UoxkTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by FT1PR11MB380434.namprd11.prod.outlook.com (2603:10b6:170:b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 16:22:53 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 16:22:53 +0000
Date: Tue, 13 Oct 2026 17:22:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v7 04/25] net/intel/common: add utility functions
Message-ID: <as5a02Ng4qvHe4le@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1791892574.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
 <7f3cb7d9269184f49e91e67bfdcb2e2c1525663f.1791892576.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f3cb7d9269184f49e91e67bfdcb2e2c1525663f.1791892576.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|FT1PR11MB380434:EE_
X-MS-Office365-Filtering-Correlation-Id: e2232ecd-94b2-4398-8ba8-08df29463831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: BLQ1mDKzFvPowR1hjaoIdmDVRFtjsKMDmRg7qS4vwho8VQDfCkd/H99qGyJ63cX6AB73XMeGFhLOzTFmPwrpocx3156X/7hXz7QlJF0JI8NEeHpC5M+lQ/sa392PCTHlYnEm7FsK93zUl/C5vq0Wfz+Lp+izjU+GL8JPPQLaRQHdSrSiNmVZe2iZPN4wHvIeBLYlCT8hW/O5YfqoZlhLxfpwQqPJ0PcL3T1mBdujL/aGoBZU6rbBDbjHiPcPftvPdOoSly5SqqR1S6Fb5b87nfolZW/uPOSyyLeFhXCQdpjYvISLUNnn2Q0Cfb10mcwQUlK1XB3ej27Sbr+yv4Q/jg4ExCihBh5k9EMoPCR6OuEEMrZ2CmmI8QJiJOzVHAV4CHzqI+Jbx0mFkMs9urL7IXdlAwQlUA+9mi36sq57vFq8YzDitAEt8k9rx6jEgG6JuecmansAlZpxnw0oZTOcOblNU6lf1Q3C25OBDtGidPj0795Jtw2VUS8ivNrN2DHUqzilO0LRr7GW8qk0WGppIMJNHhn7Tive2DF3TAMg8IAE6aAJBwDS+JLq67xOer/rpIwiXtMYOoI7vBwNw+ujbb5SNjwOxMR4PpffHSuzDr0ueeImxGdkX9trtpbnMRa4B9KtYF6je/FB+TVDoaQoGwIAI8er9ATRwDGlISqYCcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FRjnbLgGRg4ykSswiCslY6GuMMArXb71i230CfuFVIaww4Jsddgyhm3i5Qlb?=
 =?us-ascii?Q?9A2hgToL4HgV2mfVUWPG35p14VbV2WrkcD5yt0PoOGqKTkJabsRn34KlANhj?=
 =?us-ascii?Q?MRIQih3YGcKDWhqNiS/mK+7dX2/P8Rl+5dKvrg05+c/niRIOlFCZTpDwAW4E?=
 =?us-ascii?Q?hNSEs4+A35p2qVk3ea5nKgZoDXkvt3JPmENzPelQLC4HVX1sF0sG+t10E194?=
 =?us-ascii?Q?Bq1+iTA44ahBNPbDZDbmyDvm4T41qT9xDPThHMFNEaRDDVmr+V/1KttwIB30?=
 =?us-ascii?Q?PuxEp0tTgbTBuOTHS131jXCfcYI8XlBNCvNLeA63PttV91tZE6ABoKe0D90W?=
 =?us-ascii?Q?B80RMrw8r2Y+TdnRG5mGuzYdiUjydg3r0eaeSaZhj8FQoye/B+FZTmhoPaal?=
 =?us-ascii?Q?wC8hE89L8pB1XmjByvMgaHZIPA00vpTQJ8QUMqLBfQfQgu4UxNmOHGlUtdyf?=
 =?us-ascii?Q?ePBy2wsxNMAJmrscPaewzPxP/Jhn0Ye2bGLCeXIaojpnu88LmmDWxGc58nZv?=
 =?us-ascii?Q?KX0JZKy9Kpz7L1k9Je+Q4L3z6GRp6U39u7xduTTYD+ijdS+HOapLQxD9f6rI?=
 =?us-ascii?Q?PKpkT1wNziyb/ueUTCCQ0dTF8PJtMU9YBn+gBfqVrrkqq4NbUe5N7ZPg+hQ6?=
 =?us-ascii?Q?wladVjTME6jEyesRqiuLbbjnbhZggEaYOeUhEeB6UenkYKXPYUkMMU+30vSp?=
 =?us-ascii?Q?PBeG+mX+mWNA+pYRZwtXGsDP9il007D8nETln1cCZSpWkuUKAdBIc8Gpa4Jn?=
 =?us-ascii?Q?Af0uHWfqtqI6EQm07PV6X1oDobS4Etdo8+3W6CMuvKQFqrXLxsRbHB/Bnk/v?=
 =?us-ascii?Q?7dVtOEfIoBoxlc92WVnEul8qqcYwzTDIFJ8Ow+ndaPzSFDS0e/uXApdodp/M?=
 =?us-ascii?Q?o1HmPz5deZS/WuMOSgvGTLAsO59oBOKqN4kNNzc5FomQYk+fHWmawxH0LSlR?=
 =?us-ascii?Q?5ZSweMxr9IaeyuQ/5yIKQEQAZDj9Vc6iq1hqcVlUWlkko5FXr2Qv1R3DRqua?=
 =?us-ascii?Q?sfFuknpHmUn1vxFmospEAm9F53cUqwMKOpk5WVP4RP+T2khuMZNwbv9FpOet?=
 =?us-ascii?Q?2deeTEWx+i02eJrtfb/rCsPwO5OqHeZlbij13sARceccogpwh26hZOXIiNE9?=
 =?us-ascii?Q?fJyI3E8kLtIuRrJwlMrOx+YHJ2iO3yLVzvM471s4vFYx5lxVSEzcBNki/ti0?=
 =?us-ascii?Q?zMFMZWQleYAhoiqLBwn2hapkublwGgRn45Stz9QqQcXZ1ZZnuMgSdqJzDBab?=
 =?us-ascii?Q?nCLGIhRW4a6VchBRZxffFOKnIzdfL3xsD2oi8yxlodl1613JmnBU27pfIxet?=
 =?us-ascii?Q?JmAJQU6udjERZqyGiDSZn88d+xcpagcOtjVJkZDBAPblj7P86ZdHUf24EhqD?=
 =?us-ascii?Q?QBFNX7nchGdHDpX4UhKhOqMuL/CkastJgyBNXhe6y6Z1DpkHKIpAOezFNguy?=
 =?us-ascii?Q?86B6nUYYgx7d5C7Q0z6g6t5bMTw3DUppPsAE199Reuez4odGe4I71OSFCjtJ?=
 =?us-ascii?Q?piKgZTf56opumhge9QRDjhQFgAfUUFu1AlaYsLw3AoPE/0s0JtZbVZh8HkUi?=
 =?us-ascii?Q?t1wysxVSZlrK9+o4mpvgLvGEk+oAxr+VSsI79KJasdj00LGoaJSNm9oKA1Ln?=
 =?us-ascii?Q?g9JRxKDxCOTBGG0kuOScOZTKnkxxTCtgO3kcMebj8+J3FCiiOtk4uQ0a/E0L?=
 =?us-ascii?Q?ZwjJQ3E8sAhMCbUFrNMqYjvURq13p8SjzEd9+KAclho1dkXt+a7eUQLIrX6B?=
 =?us-ascii?Q?O6DD7oB0ngj6X1exZHTh0Jldss+KBpw=3D?=
X-Exchange-RoutingPolicyChecked: jvq1eXjQwnW/Egg6m0swvMeOcg3iLFAfm07bBOLUQGJti31pdd2eqqr0X+hqTNbnpL6jPgiqNjZGcSLzMi3x9pIJD+ddng12DNkiLNR0VBsmD0S88ghVqpb7cHiurvJpIajzf7RSHl249L/0eulpzIo7dwmaHrF7+eSXu9xFGmZiiJqWCrkP/etuMBivywAcA8Kv+Q243AXjrevGotSmKCKgp8UGRad/vwTWdqG5bJuMYAXKexK/tDV9FavB8IDggI9qqIyLFZ2bJEyac7q5B/T3DmURPrUs4GL6KfD2y8flcq3brhqa9TCcUIHrNAwtEq4cbJsFZAG3GxMBOXnWEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2232ecd-94b2-4398-8ba8-08df29463831
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:22:53.0707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qaqx63gCSX/wD9nCnlG25KzdhLvsey11k22AAvRro4DkPBTJV1c/e4NbpaLd4IFqSu+aziWrkNwGJmXLtQ2rEiVneetaU+x4+8e6UVAQ3SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR11MB380434
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

On Tue, Oct 13, 2026 at 01:03:02PM +0100, Anatoly Burakov wrote:
> A lot of parsers will rely on doing the same things over and over, so
> create a header with utility functions to aid in writing parsers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---
>  drivers/net/intel/common/flow_util.h | 263 +++++++++++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100644 drivers/net/intel/common/flow_util.h
> 
> diff --git a/drivers/net/intel/common/flow_util.h b/drivers/net/intel/common/flow_util.h
> new file mode 100644
> index 00000000000..96493ba7631
> --- /dev/null
> +++ b/drivers/net/intel/common/flow_util.h
> @@ -0,0 +1,263 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2025 Intel Corporation
> + */
> +
> +#ifndef _COMMON_INTEL_FLOW_UTIL_H_
> +#define _COMMON_INTEL_FLOW_UTIL_H_
> +
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +
> +#include <rte_debug.h>
> +#include <rte_flow.h>
> +
> +/*
> + * Utility functions primarily intended for flow parsers.
> + */
> +
> +/**
> + * Get the effective mask of a flow item.
> + *
> + * @param item
> + *   Flow item.
> + * @return
> + *   - NULL if spec is NULL
> + *   - item->mask if mask is not NULL
> + *   - default mask for the item type if mask is NULL
> + *   - NULL if the item type has no default mask
> + */
> +static inline const void *
> +ci_flow_item_mask(const struct rte_flow_item *item)
> +{
> +	const void *mask;
> +
> +	if (item->spec == NULL)
> +		return NULL;
> +	if (item->mask != NULL)
> +		return item->mask;
> +	if (rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_DEFAULT_MASK_PTR, &mask, sizeof(mask),
> +			(const void *)(uintptr_t)item->type, NULL) < 0)
> +		return NULL;
> +	return mask;
> +}
> +
> +/*
> + * Simplistic usage counter. Not thread-safe, not atomic.
> + */
> +typedef uint32_t ci_usage_count_t;
> +
> +/**
> + * Claim a usage. Returns true if this is the first usage.
> + *
> + * @param counter
> + *   Usage counter to claim.
> + * @return
> + *   true if this is the first usage, false otherwise.
> + */
> +static inline bool
> +ci_usage_count_claim(ci_usage_count_t *counter)
> +{
> +#ifdef CI_DEBUG
> +	if (*counter == UINT32_MAX)
> +		rte_panic("ci usage counter overflow\n");
> +#endif
> +	return (*counter)++ == 0;
> +}
> +
> +/**
> + * Release a usage. Returns true if this was the last usage.
> + *
> + * @param counter
> + *   Usage counter to release.
> + * @return
> + *   true if this was the last usage, false otherwise.
> + */
> +static inline bool
> +ci_usage_count_release(ci_usage_count_t *counter)
> +{
> +#ifdef CI_DEBUG
> +	if (*counter == 0)
> +		rte_panic("ci usage counter underflow\n");
> +#endif
> +	return --(*counter) == 0;
> +}

Checkpatches is complaining (rightly) about this rte_panic, but since it's
contained inside special debug ifdefs, I'm going to let it go.

/Bruce

