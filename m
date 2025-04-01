Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F1C36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 14:08:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7A0A402C8;
	Tue,  1 Apr 2025 16:08:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 926DF40275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 16:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743516482; x=1775052482;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=UxutC/Is5KA5Th8hyS+inQBRJbiKiG+YCuzcy5evr4o=;
 b=OoofWFFGRHF6AZlVa055mRPwdAnV12OZ23HCwr2dEG4MOB7txZiQvgVZ
 4ZW35WVjkY4AuO/hwgR5t45Rp8gW2EvyZGHyttVm0AtZi/xhRyTP9Piho
 QWnJkpte0Cr121Q0k8y9NEGWTQfEVQnqNgjGYLo6/CCGgFyvAELWnwsVA
 ogBwKGhn68V+2lFsbm8BABuRSUh0X2x8oxlU+U3Z8MS+/FLt1/MjvRBvJ
 C+5SOvj4ZwPKE7Ihk8gkUJfQ3xSL1InGg+3TMTkSXsfWdiCos6EXWTQ0k
 MGcpl9QECBKFynyPfjlUb4aRMaRk7nnhnPkzlaFAD5LrpF23HlGwW6+HI Q==;
X-CSE-ConnectionGUID: UxVhG8ZkTGOaTTNEvRIbCQ==
X-CSE-MsgGUID: vDsr1S8+T2KqbvMCkdQuOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="47561369"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="47561369"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 07:07:06 -0700
X-CSE-ConnectionGUID: +pHP9qtBSJm9epNXAM39EA==
X-CSE-MsgGUID: BWyKk7u4Ty25XhiXFV34ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="127293039"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 07:07:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 1 Apr 2025 07:07:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 1 Apr 2025 07:07:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 1 Apr 2025 07:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkTSmWABHfrlHGgj+om/iNuzvLepZzSaXYtaxBnRTBOayyPzbti+O+1jgjZN/lvEvFGz7TsKefM0GWFGqiR3kY8JeNOkjCoR8uKvYvwY0Ec8UWv0YqWNvTrfGW93toB6Rh3MmOYWPNRRT313rZHV/buxXn8Cc/yO+CPo8N1wysg0U2fsj0rURUJuH7OVZNdKkDaOKvy6HAv9azrsdAibA4TWRF5c86mbP9ONIS9lAnGZ0ht9BO9JqGLOix9zzkCuvQiNLOUM+9CpJdJf4nnAtEpsitlQ182JGOe5zbI+wAHEYhz5RlKhzaUNxCViYzKnL7Oma+vq7b79nOq7REA2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGCvi4+vqW9bfzZ5Ca5o3o9z0ZAPyGUqTndgrC9ZF+Q=;
 b=F3jRO60zWBe0+StP2H1qM7ofsEByZSNTWYXkU4mCpzAbKyf+m36+zXFriD7vKx4mUR6wOEQo5zVVgUUrePsX6nKde3Iyx4ZV5euHhPEkjATRcESmQugAhE8Gf0Wo5/poOeUfcQ35AtT5IwV44XpLr2pN6j+UQeDRhLGmWmDmemB1q+dRKyLlbyfGQEAZMF4L+1kyzsg6wJwi8K0gZfFhcpLBPBtubofHYZ1BWQFJ33yl/gSHX5suDLLaGQpubzATe1mJdbcsBFvC2u+ZBBlvjvdFuf2NV6UOeCF1RDjEYjMWr/bk/lKV5m2EV9wW/xVWD9blOiZBV8jqKtPxZXnVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 14:07:02 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 14:07:02 +0000
Date: Tue, 1 Apr 2025 15:06:57 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324173030.3733517-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV3PR11MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d94914e-43bd-43aa-5bbb-08dd71267988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IGIgHJ4L7bJY0mhveMDwgaIbcY/wZgnvA2J/D1p2a/DxmhuCR4zQYGNo/Yc3?=
 =?us-ascii?Q?L55KWLtxmz4mtp0kl1UrmDDALHNH/8Rjch0uhIvZW7OFaGS6WiGwCpTygJrq?=
 =?us-ascii?Q?xkPFLkG7M7fYWMq9dia9p4Be/SKf6pLcRKPR8m3IW4U1sJuiEM4Dmef47E1z?=
 =?us-ascii?Q?A5JK3yg6/Y3xbvKdWfnhrUHOzWKVhvIG+esfgYSwDZj+QtvkzmSNjra5svzi?=
 =?us-ascii?Q?w7isEHTH8fKBDcoTw+cRkRMjJNLjdkwTwk/dsOGKTQxHZz+yL45uUEeLumFf?=
 =?us-ascii?Q?a7eFjJZWSUSvKSyYLdEPyTv+UChZYhETrNO0SLgsFcKy+DwGC98FXhe8I3hk?=
 =?us-ascii?Q?wnet0zFMPSnRVniJTbztj7CwGqOAmnHCS+u5sXGc8RLnEg7ggR3xuSX6oOQY?=
 =?us-ascii?Q?zrM19cULZwhbcLwynajRXdsZ9FdZfBAM6HRMEiJXdVeorRM+usoVhF6YgObr?=
 =?us-ascii?Q?HkFJVlhTm5ASo2ALJCl18E7OBCO9/hF0yaIxfXj/pt+cXfi4GXpyVAuGUv0x?=
 =?us-ascii?Q?2ypxPzaXnlkqgr5jLASF/yw6bqBAD4DLxzPicVceID2cQy0UshrC33mlfSkx?=
 =?us-ascii?Q?aR6+GsggUNoun8ZsFg66ETwiVkNB9RUVH4jYcwyFXjHl2B5EXx2AXZezAg/B?=
 =?us-ascii?Q?Uz0xVl12FIZXXMMmMX1QO7i9PGFEfNdnDVqotIgeaHSEdfEfjMb8VuNC4iWQ?=
 =?us-ascii?Q?ph+XPTyX8Z0Udy9gKlCgpV5FKrGOCe/T+pLm9vGNo9qthTeDKyLILmahKVbb?=
 =?us-ascii?Q?4YGRCFYbLxJz/codHFW/o9M/rTrf2/BdeJgv8Azg6Ol0ndyY9BC3H1y1O2Xz?=
 =?us-ascii?Q?8rMQ/K8VZpqSozvwzYJ7tbkg4yXNJObbn4IVhbzFm9zNFkeobl9Cku4WgI9Z?=
 =?us-ascii?Q?m0FfGQUL42aDFgLNxGSTjUMo/1tSOc26My3zFA86V6KrTzXFvNfGZ2hdatIS?=
 =?us-ascii?Q?D7LFW9W7eHMwXvOMi55Dfro01n2B7KZRKMIFq4nF8/i3HTDqW29W8w/ihCze?=
 =?us-ascii?Q?fA5sS/gNj67VylSHz2Q1k0/253/zCjXj77agcbih6zTtab0d+LGzLKK9/9Rc?=
 =?us-ascii?Q?SNrW2Nq22phqen236cVoY7vdsl3xtWX2L9DNSjT8/UvW0zxt5jbGNb0nwRm/?=
 =?us-ascii?Q?7Y3hYR79YZkyo7wKaeKQABjaeZtfkWSEf+NYXFRigQ5teGTI2tk/M90VeOSk?=
 =?us-ascii?Q?lJn+WKNMccIjNrwmNmjMw5yMXZSXNORmGyqdplAQKDhs0CFHFYV9nOldlxSC?=
 =?us-ascii?Q?Pg08r+h2F72LZOYb9fIIOh9lz3ajkmnPv4aMXS7Ae+5/7TqAgP9LLmwBxnlT?=
 =?us-ascii?Q?5PDRqEbDBlrYEPHZIGnpzb7v2TEyfk6KWgRj28DRoDbu9ps0iIJsX1CWqVpF?=
 =?us-ascii?Q?QAbFDDNZ4EytaKBNTK7DF1EkDbhZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gi96stP4YyAaL7tR63sPDinkCVttU0vtsQFitqs/EJcnY4rjHaNvGBGKI+GX?=
 =?us-ascii?Q?jx3xLv3cDoW1kyozBG8dwRsyJ2vP+rRXiwTwuDxLNbKy2zr0ykJ56t5bhMhl?=
 =?us-ascii?Q?HtY18BxIp5DdExCG5S2hb+vUvbjZavtI/1sxkcGavym5NLGKV3wjyLT0OPX/?=
 =?us-ascii?Q?o8orEE7Z7lDwrN0uD2IuPmjM2pptGF9vILvMZSJiyuVivoJ/t8SyNNmFxKmE?=
 =?us-ascii?Q?4RvawdiKsHjgG1HLN//fhg++CRPy5F/jqtbFbTmRmpSdioji/ecxrCvyxqwm?=
 =?us-ascii?Q?a4rZSZTqaaVHHkbRnWEaUv7jU0htNBGRZEwJ6vPCpfpqdPzxi1FNSJYrPDyv?=
 =?us-ascii?Q?jTBIpbZ79eF/azxR7Y58WAAYTHn2IiH+a54FKzujEsiJQ50REM+dSwh5BZJF?=
 =?us-ascii?Q?j4FF8sTYT6LtJKJHNv8LDJ/UwlneLTGKwwvimObNVSWHM4Tm2edyGXigd8RC?=
 =?us-ascii?Q?3cq7YUMeAWtDYkYY0Do/NLjt+kLvJAghD+7/ywp1fwQoUtay4qinVukZfJh8?=
 =?us-ascii?Q?iyVEgRpFpjp40YhfTMtDangbOGJQ0no/5AkbFE8VgpSXWFDegQSG3PfalBJG?=
 =?us-ascii?Q?sS9PPlYRTkQt1QVfGK+gwJohEckDS5IZpKmDlKUbEkWMppCsrr3JCKKN3z5q?=
 =?us-ascii?Q?ZF4Mw1P+v85i3cxxX4vBf8Tr/u9oeXEjzDtl1EdaPDO3GMQsfs0brJTfeblW?=
 =?us-ascii?Q?qDiPdD3eU/Qgv+QI+hmD5Y8btvyi8WCAKkqo7T9zuAjxGKuLSlJRaIeBPzJb?=
 =?us-ascii?Q?CwGHRUzXGCy9gJLD2o7tKLuqTx9m3ScEBYIWgsOg0bICvaF4+MjMAddpLdxf?=
 =?us-ascii?Q?9R0F+zidlIxc7r9qftomxVFNfF8nyFTToL4c7bPE8r7bTp6Dqa/CUANJgxZj?=
 =?us-ascii?Q?ro4wGEwoQlE3q+7nhr7vKTOot2Goi+rg4taTw4A63DIDh/FBT9fPF6IQlwKu?=
 =?us-ascii?Q?okEqxqx2tkEbVU67kurO3f8k8C4JSWnPUxiQWcV9lOTetoLDtvTOmtXB+XA+?=
 =?us-ascii?Q?sPD152OoKWzE5UyF88iLKTH3K0Cmf+9Qk9wtvdINrVE4ZQgFGqIsVqlUtONL?=
 =?us-ascii?Q?+VXYGBQed3nlIzUm8zeJW4OVaK0xOwnHBDjRrWyrie4yUj6TEoegRBMO2P25?=
 =?us-ascii?Q?K5tnjXgqVWI1tZUPfTfGDURwqQ6X1Z6QeJ/xe7a4L4ldfqFlxFzNYVZi6Y9v?=
 =?us-ascii?Q?CqEjSyi1oLwDEBRgS/hwAn3DxeG7kwKKlG/exR1/mcGRlWPaG5u2C4PeCK6y?=
 =?us-ascii?Q?aKoocJG7o+vyaBSj7j2EmgLUnZopn4n6/Cv9sh405zS80uAbdV3tsyBpFPkX?=
 =?us-ascii?Q?TrENCC+WAXS6Od0mbedzXo8XYjsWSd0LfSfV1SAgWth7cC10GiH00d6xB8g7?=
 =?us-ascii?Q?wMDy8pSACWSRO727g5MTViEmBO5kWaMQpXIvhsJwyd8mZ1jh3Z21etCHNx9C?=
 =?us-ascii?Q?fmq6aBP6vOG0Fv1EnjIgP6V5d7rRXGvC7l3dnIazPZMMvkDJzeBuUhNVdYAs?=
 =?us-ascii?Q?piSwyLfFV6TNNvG7ssaeO6IGxy01hQUHs0h4N2MgPQKbTdX3BN/sIv6mzWa9?=
 =?us-ascii?Q?PPvB2Nf+ku48e3PGdFUyDoEP1wgwY/rwqxEA3m5d+fE6+hei5qPa6ScqCzGT?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d94914e-43bd-43aa-5bbb-08dd71267988
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 14:07:02.1399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lr2NejC5N2TFw4bIJ2L4yyB2fz2VcOU48Af2lQ7Xt454nSwvyrjD2Sdf84/0AHYXnWdI5YWkCAzDlW1+XPeCFQ1Q0JzjKIMulp5SOTjIjdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602
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

On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson wrote:
> Traditionally, DPDK has had a direct mapping of internal lcore-ids, to
> the actual core numbers in use. With higher core count servers becoming
> more prevalent the issue becomes one of increasing memory footprint when
> using such a scheme, due to the need to have all arrays dimensioned for
> all cores on the system, whether or not those cores are in use by the
> app.
> 
> Therefore, the decision was made in the past to not expand the
> build-time RTE_MAX_LCORE value beyond 128. Instead, it was recommended
> that users use the "--lcores" EAL parameter to take the high-numbered
> cores they wish to use and map them to lcore-ids within the 0 - 128
> range. While this works, this is a little clunky as it means that
> instead of just passing, for example, "-l 130-139", the user must
> instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> 
> This patchset attempts to simplify the situation by adding a new flag to
> do this mapping automatically. To use cores 130-139 and map them to ids
> 0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-ids",
> or using the shorter "-M" version of the flag: "-Ml 130-139".
> 
> Adding this new parameter required some rework of the existing arg
> parsing code, because in current DPDK the args are parsed and checked in
> the order they appear on the commandline. This means that using the
> example above, the core parameter 130-139 will be rejected immediately
> before the "map-lcore-ids" parameter is seen. To work around this, the
> core (and service core) parameters are not parsed when seen, instead
> they are only saved off and parsed after all arguments are parsed. The
> "-l" and "-c" parameters are converted into "--lcores" arguments, so all
> assigning of lcore ids is done there in all cases.
> 
> RFC->v2:
> * converted printf to DEBUG log
> * added "-M" as shorter version of flag
> * added documentation
> * renamed internal API that was changed to avoid any potential hidden
>   runtime issues.
> 
> Bruce Richardson (3):
>   eal: centralize core parameter parsing
>   eal: convert core masks and lists to core sets
>   eal: allow automatic mapping of high lcore ids
> 
Ping for review.

At a high level, does this feature seem useful to users?

/Bruce
