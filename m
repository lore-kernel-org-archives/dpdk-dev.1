Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D4C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 09:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B5A4402C6;
	Thu, 20 Feb 2025 10:18:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2408240041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 10:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740043085; x=1771579085;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=UA05Cf6+1QOO8O2AjvvfFfympHUGgfxMff5tapZ97mQ=;
 b=KsE/MbUPMZQBT5eW+ct7+RLGmYxggOmu+sC5dQGmdtxjni6jH+3P27Fk
 oFSpYR+zVWMapnmkVrAEqwnNpBYFDLelHNSpn9q1msrC8v/Pw50tgQpAB
 SrVnHGuCbNQz/hEnLizf32h7b1FHTsJst95pBDFMyj81hXlltsb2P0jT9
 EoeVmMShmq4IMDDOCkZvUZ4/Wem1OGMEZ/3AyuzmOB0lOi/fvoNIxDOtC
 WCXm+wCHq3oiUinkG+k6XyI6zhfCgMZAWfpuWmcFudNqSHrUvaQsDVV/e
 d4vL72jOJFFr/38qF8W/zlmQpBOfxI+c1Wz5FokfbVfPtrKU0SGDO+aC+ A==;
X-CSE-ConnectionGUID: fwGdAjD8SDGE7A852TqnXA==
X-CSE-MsgGUID: mrVjkEp0S86jzfKiaeeBZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="28407860"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="28407860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 01:18:04 -0800
X-CSE-ConnectionGUID: tdD+SLM+TDCmfgaevXUy6A==
X-CSE-MsgGUID: JyV6Ba6mSe+jzv18wJ6reA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; d="scan'208";a="119604582"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 01:18:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 01:18:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 01:18:03 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 01:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6UFV5YwHeVW+5ZFyvy9QGHjxzN3hvnb1NK17K6fHEEEM4JcGZGML5LBf6dYmCr1HxsT2B/ZZ8ual6lb6QRNub8anmvwWGLPRZIsLRx5pdqkrpJdQo7mp2lPziIB+IYDEcRbUfk3QZ+gJ7oe2JXRrV/DsInHo+IxV96zRXsagmDIdYrIeKd3UXZZPtrhWN77H2+Kdl0WfHOWVEZSvir4SCO/LsIGzlABo5uXC06uh+6o3QXPdYjNLTv+lp/lR+WwgHSjnu8NuZ//NSL9vJtA0GZZ3SkRr5iDzrWSfL8JX4g3iVPftMb1icMcwR3f1geaKMNcGyOYop8Kj9zepZAWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/U8Cxsk+u+O3c+F5mbGWACbHrjrGY2yMRJyjU9xOSk=;
 b=wXv/bAZTZLkmLEDAJDksswNkDts4teaEZIB/XeZ4SSPZyJ4DfF/QgIxgA9y7fntZl9oswBxidINBn/Zj/RqmielHUa3nMUuku+CjeP4KrJlb3tSTseXxvfI58LjlA1A70Bt43rEoKW6ML6+4KXzS/fJqSdEdXmyQlz2GIPm03jPZNVYFwiEwUT9G0v/RLfFJrGRtiDFjjkUX+VZuO0Vb4L4SO7v8k6LJC0gS89HZR1Mj7GXC3ALEBTZ7Os0TZt2cdxWyCAqe3t8wXmlFFU3yrQdy4bIDZxkLXCHTAou0PJ4B5ilbEFyXlBwAYF6raJaWHeFudNq4glrD20Y9p1Zhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 09:17:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 09:17:17 +0000
Date: Thu, 20 Feb 2025 09:17:12 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/14] Remove unnecessary function pointer deref
Message-ID: <Z7bzGJqiVq0U1sEN@bricha3-mobl1.ger.corp.intel.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: cacdf1e9-5bd4-4b29-4ad0-08dd518f5f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/W1ootKUnOpfCup9OcHrrhzwm7+lJj30Qx2BvddYcwuU4o7AK/Y8FbLexgzW?=
 =?us-ascii?Q?NAU561yoJfYPulQhNH8/F8jfYh+QNC5MaFcaAfKJkvWRiuXM2vZ6isV/ztNb?=
 =?us-ascii?Q?NaYgP1ij7+qnWImS7uUBjFGg9XU73wX9/jtAyGG9+hopE+6R9MiJgsxcH2Vg?=
 =?us-ascii?Q?lXrPZs8xDS1D10eDdi6i8mrdXRcLuze8usQCzNOoiwuwTnV68JD5FWr0VVwm?=
 =?us-ascii?Q?AaLqtPgvTDS16IttR9bWdOPERZfBqXAPnhyBPOzLbirMB//TEreOD6SBAgNv?=
 =?us-ascii?Q?VtDWLshHnVN0oPwmusVOCy1YhnditHKoOFAk3R18O65ij9FYHCOnv3/FH1Pl?=
 =?us-ascii?Q?Lu0vixQX0MvHUHMXziv/5pBVtiljx+eYV28vvRVM0fjhwrK2jODHp0QPn8Ie?=
 =?us-ascii?Q?XwPpuMnbGSrdQSdO297Ufb+UgOdveA5kquQw/egMM8UCKEkgB1onsN0g/L1E?=
 =?us-ascii?Q?2qSwVJhzpTNWrB2Z+3CQnDIrXRpUkZNzyuCxqIYO333WGDrXC7gFWL2QLPsA?=
 =?us-ascii?Q?78lF0Gevp9gX5wrX47DdsiMRDbH8yejQyASUAzSxUQrd6sCLvx6XuQXpdDUz?=
 =?us-ascii?Q?pF0ScFdF5Ro4osKCFJwKx6oFF5lGKkPd2BV1WMckBED4ArNshIUi295J/rEA?=
 =?us-ascii?Q?bDszYaKIjtbyYVnsD4C8CG+k5an0qwwfe6wSr1QKhLPph9cB/YiggxpYJIrr?=
 =?us-ascii?Q?HlDkUwh9Y6tJ/IVPTl89MRy0AhwR/npCgbc3CIo0BfpbM3K3obG3w4Fgyh7H?=
 =?us-ascii?Q?ljPwqxk17dG25F9eLspmMmAN1B1T3cUjKtxrkTQFFFeeiNOY7Ry4DrTuhw3+?=
 =?us-ascii?Q?V/ceIg5n6IIh0ajOJQ0RTHvQgm6yFxz4RTg8Djb6SH3IMRT3iT5dy6rElIG9?=
 =?us-ascii?Q?1evBh7sA5WDzhIuNPoMLbN8ZvIy7EalJeBxM4AGPIFO802OH3HM8lGAiG8n9?=
 =?us-ascii?Q?fJjjHAVXI1BAJ1LoWlJ5idFOj1QCsmaNoefjX2IHnfPpOeQrxJlsieoopa5j?=
 =?us-ascii?Q?tTEMOofYk1eAj5cIxiwP+tWh3WC45BmBHf+bg/FzKeaHEJBu5pOM8cubEhLz?=
 =?us-ascii?Q?JTksGHVFdamSbWQ4c23Pvi/mfhS9Iz36xRIE8cQx64qyCDuMrC/9QG7WV3a9?=
 =?us-ascii?Q?8V7Nmy8HrXabhbUcEOOfasq3osQ050vfuY0b0QVuXgTEF8X6jlM4d6nfnBoU?=
 =?us-ascii?Q?uUwqCDDfOrxULMh0cgjbdJY8xbj9qW6EEgasqxhH/sO971A7taIZCAWj69nj?=
 =?us-ascii?Q?wPWAglypll0KeM8cRH5rKsbeEekhWZC6BqWMdbpcWMoLVXwuh4cwL9imtStm?=
 =?us-ascii?Q?w31OjaFRgiRhgTa37OgWTKex?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAW9JijWsA3TgqFgyADQVkZSwN/Ey5Ds8ayIs7SMeinooZx/k/naQdf0oEK9?=
 =?us-ascii?Q?jXqie2v1bIqSUPZv/+fxd13whWodSDTlNF+C6//wnVu+STr5Swy8wbJqmhRa?=
 =?us-ascii?Q?zw5lmpTdrjzovN9TWeme92uS98zmWEEbEkEd2UmHngGtgbpruPKSRd7HtZYq?=
 =?us-ascii?Q?R9gowLNKoCxxpY5oO6kuWHk1Z0y43zmI5R3p92P3Tbd8NZgspDaxhQ73zlgT?=
 =?us-ascii?Q?wXqWpPJ9GtGPPiNAXw25jowXl/fd9ZKjs2N7Q1RhE2PiMVzZ2T1lG81H8tQX?=
 =?us-ascii?Q?FvXo/9vmI26Mgf0vseHfXVYluCZy9v6FmQSOWg70QE9Qmem1lkNPBdLLO7bB?=
 =?us-ascii?Q?SdiwhV8ETaLstFaWx4JP7wFfN+xOrIQn6rkCrivDzX0vduCLqWUKLu2XsUj3?=
 =?us-ascii?Q?DoktuG7gogLX8LObelUiRYslwNE+aLt0ukLimFhuyeo52u95DrDRR6yAwUXf?=
 =?us-ascii?Q?p1sgutOokeMXIYPKNUSN3W4H2c8vgKeuNgw4giZZruadG7L4lWLlTsImlBZ8?=
 =?us-ascii?Q?snM9kt4VX2exvbNfTqXCg+oyzoGtV+KvIdBjxqfP3NRX2kYGs9CQxlKeRgbJ?=
 =?us-ascii?Q?kCSkdAtQtISMTwE9a6sU5efRyF6Rc17fA9V+yfiUZ3VAGWrm13Ffe5twhwcK?=
 =?us-ascii?Q?6kZ49zsaMgOa1NRAvokIxlD3MQi+VDJ8wQiaZynCh2/D9eOdcY16KTkwHHji?=
 =?us-ascii?Q?pGbOB6nGuju7iOz+H+1QD6I38PC43rIq6lcnq4z+8kArZx6utuvp7YjVXe5M?=
 =?us-ascii?Q?iAgJUBL9DLb1J4Phg7D9SoundYokBLNYBxKhoarvv44LlTBU4sLfAb+sMTH6?=
 =?us-ascii?Q?wuJ61cQMY/oZPRlMgCTC4OkQLEhli6qnmYmBDkeDBA1PkIIMIF0W2pSQjtR3?=
 =?us-ascii?Q?3cVkGoCuj7xC/1w4tyCjSY8/v5kf2qCXZ7BLQoIfmBUEVGZJeYTZ/veB0sol?=
 =?us-ascii?Q?59xcdPJCdKj9OZULjJkadYOqNTwBeZzKRXTjb9LW+Rbl/8iN0UOzseXKB9IU?=
 =?us-ascii?Q?T2UGqu//8uxPD8jahwJz96rHahBUiev5h/TadTWRgZAL2XM9MPT31lbqIq8N?=
 =?us-ascii?Q?nkDrn+0/n8yMwRpvyhLjzIPcRjA0lU6TGJT7BF2k0eHJSuOLBckHpUb4/wov?=
 =?us-ascii?Q?epNmTu4Z8gR1EsTGSJESpcIAuQYyi7DZPIELXpe3eEYkIH7LTLAUbdbhHmpG?=
 =?us-ascii?Q?W/g8CgzE5bSoZXDYEGuU0ShKfxR6eMi0PbzAx5cLOn+QspCITvDYUVtIpm1z?=
 =?us-ascii?Q?npE/Kbv/H69l6mE9QJ8vTg1mlhbjJpyYS+Jo1AIODlk+hPcyp/2D6FZFVHn5?=
 =?us-ascii?Q?b2nki/aNC94WdZrNUGOoRRbj7+lEc9eedhsfvqwTwVPBxZvIuQHOnZm+FInk?=
 =?us-ascii?Q?0Il3F4IzcZ+a5qsSrWQKgJgBCezvWrh5BXQoxCuqs1T8mwDPOqYPc5k1bX3C?=
 =?us-ascii?Q?CuDb34nRJjzhD/n3BcKYrvTmvt39r361Xb1YpdCT94Wpmm2phj7HE+OOgmpA?=
 =?us-ascii?Q?6+iYpav3iw8bx9nchCYwjXnXmdB+bFzV0eEArGDCWVjjIy6yKKt5C4h+YJdO?=
 =?us-ascii?Q?+ejxzFVm1VQDlNRftstNvSKoxkLxZ9kGF3D8mB5OMxk8pLxoYtN26ROvIETc?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cacdf1e9-5bd4-4b29-4ad0-08dd518f5f52
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:17:17.9089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErcdiRJB+EqwJdmtDE6u197CQjjMJlJ5ZblaxhnaHmhh2xX+rCmsA5kc/K8PETPR5DMdGPUqd+T5E/zbkrSi08ZmeZrkH/j+jKg4MOLAg6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
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

On Wed, Feb 19, 2025 at 06:32:04PM -0800, Stephen Hemminger wrote:
> A common pattern in DPDK internals is to have an array of function
> pointers. When using these pointers an unnecessary derefence is done;
> this is allowed in C because of a historical quirk but unnecessary.
> 
> This fixes all instances of PVS Studio checker warning:
>  https://pvs-studio.com/en/docs/warnings/v516/
> 
> This leads to a large number of warnings marked as High severity.
> This patchset simplifies the source and gets rid of these warnings.
> 
> Stephen Hemminger (14):
>   ethdev: remove unnecessary deref on function pointers
>   eventdev: remover unnecessary deref on function pointers
>   net/bonding: remove unnecessary deref of function pointers
>   net/ixgbe: remove unnecessary dereference
>   net/ipn3ke: remove unnecessary dereference
>   net/memif: remove unnecessary deref of function pointers
>   cryptodev: remove unnecessary deref of function pointers
>   crypto/scheduler: remove unnecessary dereference
>   compressdev: remove unnecessary deref of function pointers
>   dmadev: remove unnecessary deref of function pointers
>   rawdev: remove unnecessary deref of function pointers
>   mldev: remove unnecessary deref of function pointers
>   regexdev: remove unnecessary deref of function pointers
>   security: remove unnecessary dereference
> 
Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
