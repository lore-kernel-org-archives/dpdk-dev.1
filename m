Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C7CDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 07:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51C2D4025E;
	Wed, 24 Jun 2026 09:49:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id B91C040150
 for <dev@dpdk.org>; Wed, 24 Jun 2026 09:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782287349; x=1813823349;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=k2UHpmw3jh1mEyJLuc/4ateESwqKup6/e664UsHOrs8=;
 b=HmIiVB5gmE4aoX2hDjL82WYvRAssxN58/mugaS+39hkkg8xTrr4FWkE9
 5gXe/kFHUrkSUUwnow2TEy+FV5JTbLyrqC06fNXhm7M51u7WkBtuZxhwM
 4AeLL1OsjII2oizoa9ww2MNGzw0ne3tYZUgiZzHviGbM9Z87rL7NxeC6I
 55PnVEx1EGduq/YgR93FoOytqkG7SOnndZOJM8guxsq/dkH6ExiHcBpTa
 RmV6x0In+QaHnury/Qy+v9EQygWFRjuIB6l+bTahVsY4hlswSeAmr1VyG
 JjQsOMLbdVHgDqLKxlaotSKYWfUYgjKdiBVMF0/4pVQlrBR3sqsNkR2/R A==;
X-CSE-ConnectionGUID: WlynHgNCSmmvFzu0KpHw9w==
X-CSE-MsgGUID: tKHRvpb8RjCBkYy95ld14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="108591001"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="108591001"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 00:49:07 -0700
X-CSE-ConnectionGUID: QDivYfOlQQSEg0xEybIZPw==
X-CSE-MsgGUID: zEVgr07CSQSElJSgDIQiSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="253630386"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 00:49:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 00:49:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 00:49:07 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 00:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlHVg8ZyO1V870rtG5ZqdaPaDh+uSDEPGiAfJxG1/xdLgKC+A37V2vphNSD8px6vaDtivH1sBlA9WKpR87fl3JnFPj97sAV8LqQc6Dh6exreI9/rywnAVebBnnLXJlNijSdmVicjG9jAQp/xKDoVeY2X9jaZndnyFcGLe3+FGGMA9avGkiukesSR7nV6TQxqmazUK+GYZjVo3IboDNXzHyzpt71xQIpSteVjOnfz88k12JQNzWK5JlTo0AJKKNowd4fAua15y5LpA1pKr6lN2TPK3vNhkKAZbvJ+9JPe0z7nIFLtENR4521nc9+fipWvGqKU3FphZMi2Zy8Xgtd8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDDGRY8rRABwnUw4IF8hqwcMorkAZzq0KVgWfeGyE0U=;
 b=M6XCI9Fh8TNIEarkwPGMfq5j9sGkm7rPeGa2UNPqmv/N59DPYAxdaKhibqqV/gTL+ohCM6ThpiqaXGZDK+U8xRMoy2lo+pnRcaa1Kzy8hs6L7g9l3jMj4TNrDw8bfEF+1wzDIOLIL0O78jmkLG6WhR2KBG7r0ap24QqVb2O+22B2uHfcpJfYCBC9dATamwRRL1RnsopG8KDDmOatZJlU7ilHrrLqSHdhCJm/U53qzLuEI3+sibPE4d6bKkMKQGcTJHmA5t7qPCMYujgoaiESV7/qk901LJXyLKRQhWh/YfDNQ1jPmNaBCQxMVZPkwVIiRYcIMLgDCnjtSEt9Q8WF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9)
 by DSWPR11MB9739.namprd11.prod.outlook.com (2603:10b6:8:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:49:05 +0000
Received: from IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f]) by IA3PR11MB9421.namprd11.prod.outlook.com
 ([fe80::1b70:3d93:d363:155f%4]) with mapi id 15.21.0159.014; Wed, 24 Jun 2026
 07:49:05 +0000
Date: Wed, 24 Jun 2026 08:49:01 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 00/17] drivers: replace strncpy with strlcpy
Message-ID: <ajuL7abo4gXYabyw@bricha3-mobl1.ger.corp.intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260623103309.50529876@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623103309.50529876@phoenix.local>
X-ClientProxiedBy: DB8PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:10:110::13) To IA3PR11MB9421.namprd11.prod.outlook.com
 (2603:10b6:208:578::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR11MB9421:EE_|DSWPR11MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a87d15-c2ff-4b15-9a39-08ded1c510a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: emSIg1feFO51qwEWoO7VJfm1+vEl7QX41JCvaWSQOEHbB4AF5DlitT1c7PwqjsiW9c8EWvIA33YTi83FkFKDMNweuqz5TpmJnGVxQh7gFY06vmR9ZxsycFUKccM+ERLW8j6Y22hoUSO/rn0ilNDh4K3i9e50oirecMde0ekyIxkobXW21ZB5678CZ96CyOU8MiDuR4wMdiaCkt60jUUpk6se9Ff2RHLABQulxLSuLhiFq0WqWbl9h16Hk1KHKUFUFFnLhdWRiVKEOH40DfLDJJfbfOm6g9hnrm4ywkOsKzfd6W+lBtDEnGlMrtfIEXGVmsg5GHAZCFPmUrEfcyGrk6WVN1yyWyOjYPeelfW5lXH0/5Ehi9HzWwammv7iiHyJIh/MjKRLSj279ts0qA2ojSG4totFL0DuioA+BkgyqbAfQDzfHnB++lrEyZVjvIqTKZtJbVkc6TzTI+LJv5yxmRWU2VT+Nbe42/XD2NLGFpMRA3htGgezd4bu9POEX54Tqk62C2/PpyuY1bwJHwme2Ae5Af2gHslLfF0URd8mVhTKK+UPZyvc7I9Jxa3ZGT44ADQEKnu9emU2NyCi7Rjt0PFUjQ816+inWaU5mkeangQk14dgpAkeP65iQ7hc8AU48o4Oc/cwnXl7nCY+JTYtnmfR66XeuKMQ9oG1/SirEB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9421.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svbJXTyCyX08cGOUb8vRFZXuH3PNwDdP+Ltb05R2edjiK4/DiiVR94Mwqne7?=
 =?us-ascii?Q?KuJKbWOhsK4StPWgcCZVYphQCvTn31mLXFZt8EaqiKWYBVyg85HTH1GbhdEP?=
 =?us-ascii?Q?bc0yb/W7anIyUmkQh2jfK8lSbEEEtbmmtaJmgm6ArjZy3iBp9TBYSunSortF?=
 =?us-ascii?Q?Cof8e4y6bAVJO6RGfz9CJZ9yV83/2IrZcWC4EQqzvlE59VZt/rDYPgJvzdSj?=
 =?us-ascii?Q?GENzNupy7mpkAU0FqPNjoF7qdSINPvxVl+86GvU/IDhXe3m28+mc1mnSCsPI?=
 =?us-ascii?Q?poqlqcXgsSLFVlv6YnPscLjEL/7zdgALAYvbfMXsS5fxxylC62RV9IIIkziP?=
 =?us-ascii?Q?kX6PqaUw/rEhkUaGyu1vCzUndUVw/Tz3coISGy1bttlFbE50x4o+glLvOwRX?=
 =?us-ascii?Q?WffenDsTx2YTagOmUNFYSxyq8JQZ2/80/VDAe8bdvyaHRx3XLvcyfOJxf6IZ?=
 =?us-ascii?Q?5Ty8PrSSdJ2I3rmGH0aNwKIMLZIMckyeRYQv2PizCjqGqxtkWSI0Pz0zsfLN?=
 =?us-ascii?Q?U+XQLrzhwTrzvyp6/qatYKJgyH6hH0uhbsX/J4RGLwIJgSlyZoxstbkHTpKd?=
 =?us-ascii?Q?ym9cn6rg3SVtmZetLNHx9G8Xc0i/n+VH4fj8se0wCnJewUa6ICU9ygnIn9zM?=
 =?us-ascii?Q?+qmGjU3LYQB03I4qDeSgFj2qkBzo5ik0bRVhVF+9ibyO9bXWSCwqumNEm44I?=
 =?us-ascii?Q?szPto3heUtIB2emfY2yVQVsR9NhqANlbFAEbxz8ZiGt2pMO3ZEDtUBv0DMIS?=
 =?us-ascii?Q?2VArumNpnFBy8SEbhWVvNwKQU8US+8CSVnQeU7bDfL34knbdR7MR6VNQTQyu?=
 =?us-ascii?Q?reSLws6Jw8gtWI1obQGUykvVBDIZNfwW8mqrYejSq7dfHYD3chZymmhze/D9?=
 =?us-ascii?Q?MAa0emszN0xxi40jZlB76O/m/bXSpy72NviVXKTxQYYqpY+QMz4UmZpA3VJQ?=
 =?us-ascii?Q?blTL3CNRCYNLzR0udxBPoIGqPt6RPW8MgLfejhBcEVJWAofiuM1RcVwUH5bF?=
 =?us-ascii?Q?SZeoTU1dyn/alwo7FN36sdil46VXYfASNLqvezjddNkCthU1/uGGli33ny/b?=
 =?us-ascii?Q?MVYHCuktjDr8mz3hV8lZvIw+cZosedLX+98aJElquonp1pazi3pd/0CW4FR7?=
 =?us-ascii?Q?LMChKd13oQ4E9p+suwcBbX/ENeL4d9X7i1ZbNDDxdapYnfCpzXyG3o5uRHbU?=
 =?us-ascii?Q?Hb5sn51bJk7ofU1fhUJf01psuo1iX4Nqtm/rKmIkKpYTV85ucuo+gVmS3Avv?=
 =?us-ascii?Q?x/zCQJdW5MwZ5RL/WrvzPlJitYJiYFE2HgGnOtmhAS8ps+B87eznQZpUzo+X?=
 =?us-ascii?Q?MIYZrIOZWuOG5wJSMbVrqNvjG7/QrrZe3TaxHEBWAjr+BN0eTbI6C90N9g65?=
 =?us-ascii?Q?F8GTjkZJr8RwxsGEzrHzAqP88aYplR/TmQmzCnZ+cd8017mqgLVvE7vyQR0z?=
 =?us-ascii?Q?qgjVxLYRRWagTY739bnowC1XPWR6UVgRR7FniaKab0CHyWafqjemgBUzdq4i?=
 =?us-ascii?Q?vAoIT/bS0zOoVHLIEzwz3EUVpzM+gFI0ApnBIu9wNBczqbgzN8hUsEpGzX3X?=
 =?us-ascii?Q?aRrP0BA7tGvCQrEGCWD/UInhRPIGqCNiB9QLDUA6bxoLnUaErnh1LySkWLtB?=
 =?us-ascii?Q?mDibUXy5xblR3rb3QCHGGe0B8BH0cdk7pGLqTw77rvgqtViI0Pts7TDttPMk?=
 =?us-ascii?Q?qyuNrgwoGnjXqhNDOCI5V/wfdLTd+fzMWOk/wHK1vQFAKCjB3BA8QmOduCfA?=
 =?us-ascii?Q?dgTij3U6CyELwGPipqfQoHpD5MfWnA4=3D?=
X-Exchange-RoutingPolicyChecked: ZSWoaW4HjGtMyF3cWxPH2Ba4Fxk3NWBQLAD4Q1aEokJYKT8aynCRD+4fDcHt+xLy21eD8r0EJoxWqVMkILhEbe7iTcp+J8XXvE+8avmMx/e19vvFzVOky6xYNRAJ/XvBcshP66wNPcUXM89OnYA14Cb598PSYXfA1UAT1cuT5n5SJ52rfTfw8fbuWOwH1/6JGT7ToJgWKTihTen4t9JY0s3gxpWOHSQ0PJoRqWl/ipHdjHZHbj4sqnxO5mYHjNzd4jOQxRQGmhzG2DJD23vIyuAgIayIoClbpo5O6pc/bfdUztCiiWbc5zDgqcwYvXLGUrlyKP6M/WmUAuwBGZwt9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a87d15-c2ff-4b15-9a39-08ded1c510a8
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9421.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:49:05.2774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro6roIi2sVhesSbt5FVtIU9eUO1xKrsGrwEM6NTVjaJwYuj7QM3yQIQYfeoH0+7EBRUIzjjbKkwrcYF6EI4jL48NoBT+XlOKNCTpKYcToR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9739
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

On Tue, Jun 23, 2026 at 10:33:09AM -0700, Stephen Hemminger wrote:
> On Tue, 23 Jun 2026 17:51:30 +0100
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > Many uses of strncpy in DPDK drivers can be directly replaced by
> > a call to strlcpy instead, which is safer in that it always null-
> > terminates the string. This AI assisted patchset makes those
> > simple replacements, adjusting lengths as appropriate.
> > 
> > After this set, there are still a number of drivers with strncpy calls
> > in them, but those are not simple strncpy->strlcpy replacements, so
> > left for later rework.
> 
> Maybe a coccinelle script?

Don't think it's worth it.

a) All trivial replacements are already done by this set and the other
patches I've posted.
b) AI does a better job of handling this anyway, since it's able to
properly analyse the context and spot cases of using a length parameter one
short when calling strncpy, or when code is improved by using sizeof() as
the length parameter.

What probably is needed in scripting though, is a checkpatch check for new
strncpy additions. Are you still working on that python replacement?

/Bruce
