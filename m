Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B0CCAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B0D94066A;
	Wed, 24 Sep 2025 16:18:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C04AC40611
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758723522; x=1790259522;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SNOf+qxuXmGxZW7KU9eKz/c8gnAgGK59qny8nq5Y/zU=;
 b=Evo8J+XI8PnHUDqKYprdjIOxVpCsPynA/Yay7IuRqlsyKlvaiKgG7TEW
 k2a87NzOAWUlcDXx+OzEaEMiooB7lnshOmyEOOeE9HdJaNlObbUvLPndO
 X0aMzQMt/s8XiMC8+DtuQAfS+a2JqogpXGy9BpmOfMMGHVfMUj/RHjM1Y
 vGKXiwvzEuwgmpZiJim57H9dTa+xHzFvymT8+ORSpj1Z2RUdSi0XWSxZV
 DaS5syqU4pOVlhjm+6Q7MBEBScWwuBj4Mgur/YeDKOlenv4LT3qjDwuKc
 OK+u7ygL4fM3sDWkG4g5LPCZ7c0GkmPlFfYhN0xUhBodtzAKAswFdD0xj A==;
X-CSE-ConnectionGUID: ecZizRuITwuBWVI8BBObFg==
X-CSE-MsgGUID: cbT4wcDaRjq0jyiO+GGhBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61191825"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="61191825"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 07:18:41 -0700
X-CSE-ConnectionGUID: 0AmyzRsdT+SegRJunR6QbA==
X-CSE-MsgGUID: ts9PQjZLSKWBJziwjkEWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="181330051"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 07:18:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 07:18:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 07:18:40 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 07:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGN5jg/oraYxI5PDaOFXQ+aX4OI0U6Fg4mmGMg3gm4zsTYAM4foWklozd/k9qc+VCoMbp+tZ6N8gQtMYPWCLp5ZfRTDV2dk9UhqN1PDik9aqHzTOTQeJwWwNbu8NpsMO21fVlDgcikzk5J0Hj1VMofNR1Fdv2VckRip8Z/eRY624NKK/WA30VgaGFSWj6Mm8b/KFkPQVWoorNo8Xo2kGmLDzaATWu7hitHy4MWQMC7/oq2IwzJ9Jfq607/hhaqGWSpflxTgBhWh3E4E/X3tt6Tg1D1tcnE1RqZKAO5zMxBvgu40ElAPran9TyFoZcDCZ+9aBcrBsVpUX4REGwzWB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaLgiO34l5G3Wp77D7bbpEAh5wuNK8EW1WfzukcOMyk=;
 b=MzjbRE6mcnoZS4CdA3QHekk94IqKYph0VMl5Jg8XnjArOUtmyKJaJ6xXVS3CLEIG+ysQREgpazHOadql5Q/4eaHG+LSzITDlI/tt5V6HVlFbPNY+K4/tCFx/Ip4t9A1qSNzz3uRKM2G1Pyo9ZXj/oo6/BbF62JCX4XOHugHUXPVL+woMSADpYBbhhxGogOddTTWJTvdqIuf/RmXB2CIhmIAKoLrFGLjqGuZHhHCl4iVbV6FW+U4U5PBC3fBi5jHRIplxUhDIMX/Sb8o2zx0ZtYefQ8TsZ6n8JJBc1wzI5zWBkMWj+t2K9+0lOGzWz2U/PMi9KaeXth+NsxhXk1kTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF5AD378C3B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 24 Sep
 2025 14:18:37 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 14:18:37 +0000
Date: Wed, 24 Sep 2025 15:18:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Wani, Shaiq" <shaiq.wani@intel.com>
CC: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 0/5] idpf and cpfl rx path selection simplification
Message-ID: <aNP9uUDCmNfHnR7H@bricha3-mobl1.ger.corp.intel.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250917091731.3632520-1-ciara.loftus@intel.com>
 <IA4PR11MB90343F79AF837A027743E3BB9212A@IA4PR11MB9034.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB90343F79AF837A027743E3BB9212A@IA4PR11MB9034.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU7P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF5AD378C3B:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e5e1ac-a05b-4f1d-b761-08ddfb7540b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oo99FruLkGPKfoJ2e4Z7wUqVsj1BbwOZY2KK4beLbD5vcBrxLBicpEHLh5WM?=
 =?us-ascii?Q?tAN+GwsDaz06SJRpZNH4qR+9jQBnzmHWWSfdS72WZWXEmKDnnEw+x7DIqZ2H?=
 =?us-ascii?Q?DNsQHenQIt25WCYHGE58EMJBi7RoD0J3yV5AdOKvtXbqbY3olD9yWJCbRUut?=
 =?us-ascii?Q?uaWhtpqczr8CvA1BOmNaiQqxGe6vTrq0eDG1cQazjFIHsUOVjJ7wjeaRvHcz?=
 =?us-ascii?Q?Vd/LRogb3zqTzOqcy4oPIv6kVfxT8/VnTOxMDRKVLL++mco3LN960xk0oK5r?=
 =?us-ascii?Q?wpViRCKHzOd0zFxYqkb3R65lt6EYwQTnS75/cgafUn3Dcu8uaLM7fg03wsrM?=
 =?us-ascii?Q?Ot21RvReUghIGVHp+PghtvxpgJ9NB0HKPqsfo34iMRciCwuz5J0zbVx3qA/d?=
 =?us-ascii?Q?1buFlZ5cTJZwBOYSAZwKChx8WvP60gZxNJTu1woYa24Jg8WFAUGCmR8w8aEu?=
 =?us-ascii?Q?F3gR7cHrFqHcmMtdVz0urEwt/eWFaiKROYtU0dTzKzwgWLpTgUt6JQGHCoNY?=
 =?us-ascii?Q?xANnWaoWV3cDm085rimqLmOo4tn8rSaiBEatDmQ8wXH5GSQ3rxhIT1SldBZh?=
 =?us-ascii?Q?jtvl13t2fyaDNLStDy5Tp9wK2FuXD6fuWtbG/pE+KC2ljrMs0XgbtWpB5pD1?=
 =?us-ascii?Q?cJaVvhVIj5AF3nEFSvu8u5iQnA6FE9fZAwoKB0/v2tQ8FsWAtUWkRndN6lId?=
 =?us-ascii?Q?LUl+ng6ugqKzo9w2kmc/SC8Ux3hIRXZwutLIQx5rV3gsQw61SjNSWEuEsUFR?=
 =?us-ascii?Q?ytEzXEX4Q0UDKo+PfoBdoDYtnmC9uimi3WHdmsYJ/pSxS+JOAszQ9Md+uMlr?=
 =?us-ascii?Q?KkZu3RdG/HbWpOBVbtC2mcFdX2bGhMJb3IvX5hYqq4SvbJuMGyeF5vMKI4+B?=
 =?us-ascii?Q?X9IJS5hYoQIc7MFPpDs6bIOmuOl5MBrPWhnSTPpdDKeMlWqtvM+0rT6Q/04j?=
 =?us-ascii?Q?CPHNOHmaIEolr2Fvbz87lBZmDeH3bFNI7cPkKrJEGYOqScySH07K7cD/dpp7?=
 =?us-ascii?Q?PU/E8/9r5i01Gm12npRutOFz5SK9GjvSWMI+WN3hxSpZtSqs0yxVvuPd5x/8?=
 =?us-ascii?Q?ahBmldO9Z5yMsbeEad9Ngl+Z/m9Y3hMshUgYUnyxoQl6tcNQ/LANsmtUNjWl?=
 =?us-ascii?Q?LoF+88UNUBqYj29rJ6eOeb4e96gtpV8QeHODnlYixHDRkaXIT2dh9venUHkE?=
 =?us-ascii?Q?/AA6NbwfOUcdQFUt1mSXGGlsIE3vdflp561UbeARaxBMtKEEw3b3XIxaHUUH?=
 =?us-ascii?Q?1lmD1r7M5pSZfygVNxl6dN/BL0qLEtK9NHZ8nv54nvnkPWUOXv73ftKvM3Sy?=
 =?us-ascii?Q?rPptGRz196ApVQdClPH4PEUTr+yYuU2drVy0fi6yfRCQwC2a6uSgDEbWQ9JT?=
 =?us-ascii?Q?EFv7wbgJi/cqqCSLw9QHdugml3PL0N0GNzg97Z5wECmi+3TtkZtQsvA9EATp?=
 =?us-ascii?Q?giGL0eD2GtQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fmvYx4Z/mNLXSKbq7cXzuGXMPJuaDge43A7dZ+Z6+J7v10kvYq2tuW8BSZfs?=
 =?us-ascii?Q?F80fcS+82qkusHQIKh23pjmimqRJz1wAqXuMOZKZDpw9FCoa8BhvBXrp4T+s?=
 =?us-ascii?Q?JNpc2Z5Hdn/3MxY+0J+Ac0shhciaZzZzGei933BokWT9U8IAx6K9RioQ9Bl2?=
 =?us-ascii?Q?hLpVdDyr1Odzsnu0pMnXpL/vE3/Hs6fzXHxuDDFilI928Q4q3w9lG1fPQbSi?=
 =?us-ascii?Q?ZzWZOtboINHwiIAh4QZAAXrRiY83doWLa1rqQIYHDChxhWnEQwVhN0A6oktq?=
 =?us-ascii?Q?NPi0J5SBf6/I02zWYoRQIe2rcUy0gH8edIiETLgyZ7YbKoR6I9aj3z6e9oy1?=
 =?us-ascii?Q?eDYDjVP6J2zumYtllZtzKnlkiJCBH9YxDdxoVILngULvNT96uX8e14+afS1H?=
 =?us-ascii?Q?FgajU0X3chIPew9YTqZvAIVJVwA4dFDyDaHcu95sFrhmqEWbJ+9ugntXpMxs?=
 =?us-ascii?Q?20jlxbFKbdL3tgq8P1cVwHsIMiF76+RyfJM66WeY1tmhQFPX7By1ZwdfNf0E?=
 =?us-ascii?Q?wecyRIlz10ZJyd2RU1CAaMOXUE/ZRbwKdseDwgBdD/1uxVyMDITD3F+LaZs5?=
 =?us-ascii?Q?khGmc2/cr+O+VLblBtFzmzvXldx+kYgDDe5Rl5YiuULqovd6AD/Xj22F3rDF?=
 =?us-ascii?Q?HGcX65yGEEpJ2jVna6NQvY3U72qC8RlWdi8HhnnqoR+vJHWG0l02DfQgGWd2?=
 =?us-ascii?Q?qUiF3oBOz9nD/0EeVPjBZg35dJyU8pHmFTA8TaB25kb/9BmqmK4eyPBRaJ5C?=
 =?us-ascii?Q?KfG4LUaFcKpm+FQGFapk6jhK3k4F3+I0zG6HI4IEbWTn/POz/axLyCQn8xwM?=
 =?us-ascii?Q?XwYL0yM080eZtqnyHLhQO8S78nab6pb0nxjgqGo0dkMimsuSTlglhnOyqyin?=
 =?us-ascii?Q?XJ/v5itetBVudS2+jdJnmPhDNiW8UBz7CiEYQnMMuWmdFDJLI+rNGhN3TC9R?=
 =?us-ascii?Q?C/+qbf7PJ7arE7vLlzN1QKiMJyAm4f3PGMl5GkTChh4mZjsNWV5HFTJ/e7pJ?=
 =?us-ascii?Q?fFCXJWbMj0bbaafz037E/S44DbDpUp1ePkc+4kgxTEH+YwyjIz2lp6lO36gu?=
 =?us-ascii?Q?KHIBE3P3H8t6IPIPM/545iPgtrt0ug3IJ0pDwcHwGt5wixcB2m4K/X3pcxmp?=
 =?us-ascii?Q?HiPsomui7QjCb1VPWQwslJsVArFBfHoUYj4s4UQtg+IsDkwsrVAeW8qTLbK0?=
 =?us-ascii?Q?fcZqffQSnqHdIYdoYb/kY9j1HwAJq7qEuYXva+kOp8AR1LCPqNxsvmgVMoRj?=
 =?us-ascii?Q?cuifOfhZWJk3JYP2tUo6KpDursSgHbeeoOHcw9cfKeBc2dH6zxbv2q7GGGlH?=
 =?us-ascii?Q?Fk9thQsA+uXBorSSMv1n4XRqDpszgTfMsEz6s51S9Wk2RfHxHYV70DdOXJ2K?=
 =?us-ascii?Q?cmpDwV1vD3Q1NCut6Cxk8F1yhcpNz+WAhFjJpkY47UqdAonlP1wNMZUyVOcK?=
 =?us-ascii?Q?FhkQBmTqaBnYsLOabm0TQH1uIUW+4blgNNmt7n/NukU5Ud3aoJyWMnoCe5kF?=
 =?us-ascii?Q?KyBdMGsn3ALsSskFhpD1MVtql1WyiwlDVbLDsCGARigamSr2kZJ2dyyOtn71?=
 =?us-ascii?Q?ZL/A6Fa/uxxOdySxReIlG6HhRzJN8R46K5ogpdhCaWdVGOAwwCT9Knl4PUxG?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e5e1ac-a05b-4f1d-b761-08ddfb7540b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:18:37.7052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7F/PycSbUMjr1yBAIetfD5BGR+2zCoZ7SkBLTeqYtNGtLgvw3f6B+7ongta+wJKSq39AiqW6boInsn+TbwRcXbpTJR+18bnzl47Jiaf872A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5AD378C3B
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

On Mon, Sep 22, 2025 at 08:24:17AM +0000, Wani, Shaiq wrote:
> 
> 
> > -----Original Message-----
> > From: Ciara Loftus <ciara.loftus@intel.com>
> > Sent: Wednesday, September 17, 2025 2:47 PM
> > To: dev@dpdk.org
> > Cc: Loftus, Ciara <ciara.loftus@intel.com>
> > Subject: [PATCH v2 0/5] idpf and cpfl rx path selection simplification
> > 
> > This series refactors the vector capability detection and Rx path selection code
> > in the idpf and cpfl PMDs to use the common functions provided in
> > drivers/net/intel/common/rx.h.
> > 
> > v2:
> > * Moved AVX512DQ check to common code.
> > * Refactored rx function array definition for better readability.
> > * Restored Rx functions back to their original names.
> > 
> > Ciara Loftus (5):
> >   net/intel: add AVX512DQ flag to AVX-512 checks
> >   net/idpf: use the new common vector capability function
> >   net/idpf: use the common Rx path selection infrastructure
> >   net/cpfl: use the new common vector capability function
> >   net/cpfl: use the common Rx path selection infrastructure
> > 
> Tested-by: <shaiq.wani@intel.com>
>
Series applied to dpdk-next-net-intel.

Thanks,
/Bruce 
