Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A4F4644C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE8E34025E;
	Mon, 16 Mar 2026 12:16:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id F3103400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 12:16:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773659817; x=1805195817;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=3Nvi/CaA05lhIK4shU9rUDTo9hNYi6wwtvzcDiVMDAs=;
 b=YJC40wkyXR8b/uGMt5O5T+mJkasjjbB/NX90MYpkEH0S5RGsJE6R7XE1
 1g0u/7SJh156gcVgIHicFTPNTUegu4U9z5/tAH/OZj4MJGVOM1qKh+7Hk
 KO+3H2L3sNvOfCDGCs700okUuknAU+dWWQopvBQ3T1Imw7bDxBMRY1Kmy
 C196OBIql6/cWBZWEIBA4GAyESE0q6ndIXtAN20Fd01tmyOi8KDzAL0Mb
 NzwEd54bNj8f0dHO+a/3LqvgnaEYhUc+c1BtXB/yqGNpATUul1a/0LdOs
 DktOYax5kbtK5k9Cm4QTXvCQlSygkCsJuS5XXfZMxo5cyjFXf6BxHMDUd Q==;
X-CSE-ConnectionGUID: jlZW9PDrTLq4Oqz3LKoT3A==
X-CSE-MsgGUID: pkiSxRHqTHOFZfj6D6mcjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="78520608"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78520608"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:16:42 -0700
X-CSE-ConnectionGUID: v6p2IOiASeq7BrG1H6hP4g==
X-CSE-MsgGUID: HOJO8g5nQSalnGdG8hu4jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="220928630"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:16:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:16:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:16:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2GQNw0Hxr/rbuPtVpf75YdDxUGYEBSt744RYZSLjttZW0N7e8IYe9BrjwTDoH1RJLHTVRqygfi8u9x2QkrVFQXccbdZnQ6VFO5PfpfPcu+fqrj0k2V+T70p7xIPCFWyhGZAAoRtayVhALSAv1D6ND2K5UlRHhnulGkxmDVH/Av5sAA/op4MZrn2Pm0Es68bSxhO/897cHUDAm9+xEedWiiQQNqZEWALrIwLSOl2dS39h3Baftu8SN6Er8ZQHzd9mxx9gihn4Yz07RCtn7XgnHEX5erLGK686vgFoZo5BzVYodlxBL3YyUrR/fcMAHGDHSuINV+r03a0YX0eWqLooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9Lrg+SEdt2guWz/drxUxxU/ilhFpYnS6ZB10nTeOX4=;
 b=gslh2Zq31SNWT1juQZZfhFVcTbEWlEJJIds6FP0cHCe03EP1RkcS7rL7F9mCSbL7B8uRs3v/sv5VJ/ICzZQN9fqrFqwn6TqliRboXI4Lym8qO1zyYSOZ2YByiwCuviDSgGWhbWlDVtFEugtnsJZ7g4RAngWMbKtQAyadKRNyOMUuURyVydy0z9d/Cd0XooJpTKZlAw6hulBkb+thrwyyX0Kbaz/rl0RB3zTQMNhqUyG9OBXUrkJ6x6yLet9UpZWyMSUxBMb4tyPpmoLlcmjTm/grCDzObLNlDPMujCVKc3kdOjKHJ4g7kkstqNfQ3sYbY04K+KOfPqPrkJ2jn1oVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 11:16:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:16:38 +0000
Date: Mon, 16 Mar 2026 11:16:33 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 03/25] doc: update features for PCAP PMD
Message-ID: <abfmkcni5uRoor9N@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-4-stephen@networkplumber.org>
X-ClientProxiedBy: DUZPR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: ee235937-6b72-4261-c3ed-08de834d7de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ji4IBnZSi9TVzhwFoiIaLw++OaeIunPsBRuSailv5fbTf42HAtOOCy7UcPefCqJqBXvwtVwyoARhZv1tSqJ9COib/NAblk9zy+60MsDsd4KfAbFyp2+vbTmgNwBPF9H6yR8HKxQB5nJQ1E3z+ORXsIFSfQN0KJ6LDysQS6IEASygDdi/OSIK8H0p1ZbH7f0BQYNEc60NriHIl57qv1WOCGFh4rIOB25iw+1jqwQ2wZo6tvbaIe0WYvFlwdd3NiLZ8AU8PsVOqwtURpbF3situYN73Gigzi2/6WWIrsn4BA4V3OqzTcnxQP6a+2ijsVMergdKvld6knqjgpUov8hU/Cl7MCNaw3i3PJGgtD++hTIPvLAjcS2yrqPzHCMV7J1RFfQ67UT+L3ryS4BPaT6Zv9+E551tRDAV/klaH4AJxnjjsh9hiRSABRYiwX13j4Y033JIqF9XrqfEQZy2DOmGd/aOLtUiYp52Q7BFtcFhGESKBIam0mXTL5JVJSpWZHiQB2vBaCMTyo8Z6ZQPej0dHmncEMMXgW5kuP9J7qvIRkD+AA4TCY67CWDzGPfUKuuNAHR2/KaD8af2gAVhBimbtTXVWf4tmhOk1cO4K/h9K2Tukrq209KyYPRKWWIjz0rCtza28Fl52M/hkIBd0z1zjmiAgPc59So7/OL+hYDEJXoUv4f7Mk1f99NvcU9tmGKG3WYTKBNT89VF45yGWcKRLhForTb79ynuCxNbNwX8Bvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXsZMvY5Oo5HbtJwr0Sjmk9UZFJwM9+cTXhRRN61hWgzT9BFPccByOC4WAgk?=
 =?us-ascii?Q?AH9dr6wovOnNp8jPykZ2wZhC+Ax8GLr7rxZrIWyjrXETiI/oR/M9DMTbVFpW?=
 =?us-ascii?Q?DNH6RG8FmHJZPlha776FQpAy537oioUhR+irpOQXBn48XP1EWkwGDW2PM701?=
 =?us-ascii?Q?IcMOMMKXHQic+X/ewe646w0lOeQWi3DQo75GGlqiWMMZj83qlVTH5fk/AQ2u?=
 =?us-ascii?Q?t7F6vAVQwpj9lJ9iy9I+JIk7lgTmB4+CiS9uUEn4ysK7cY8nDpBp0zZ+0vta?=
 =?us-ascii?Q?R04ALleF9r2oohPbD2veSrJFAm6BJNaCzojhsF3FDKe8pn6NuE+GYjOki9Dw?=
 =?us-ascii?Q?f/7qPfKpW7vF2t7PYuKt69+I1BYPtMn+ZCRTIrEFXtrHBSiOGlaqKxH7w2EA?=
 =?us-ascii?Q?hlD2C5QuHovvlFHQv5ofuwQzUN7i3IUUi9nvlXbHqIU+ue862DVIZUMKiJHZ?=
 =?us-ascii?Q?gsySWAwoIDJM7aVvt1B5oly8R/dMglLXl+OfiBnG55CPtZdE61djv7uD5s/O?=
 =?us-ascii?Q?scSJVHqxz4X81axtnAmHc0+lIBmOOIzITE/kZLOZHJ7fNrPy8Iw99Uh38XIJ?=
 =?us-ascii?Q?qKT0O0CzeWMLBQa5/hci0etIF4KBJmZJYHE72TaMqNq020OAcVdAycaZEkH7?=
 =?us-ascii?Q?9Opk+JJFH7pGu29RF+jnz3ULCvQrc/9VmwSrjaG8k4cXJSAN9petx8E1UPge?=
 =?us-ascii?Q?YyVHH5a2fSHo3ISD2j37Slg1qbJKbBf41wOmenHAlLcKV0o3Q7cq3KAjU6eJ?=
 =?us-ascii?Q?D9+9IvzcTBibRQrfGDnEWz0zu3vS1qDrM9Y0zHzke56WZgY74pIqXFv5rJVY?=
 =?us-ascii?Q?1fh2d7+iaFwCDQ5iyuRiTkSUvCtdtI19T4F3JmjfFmdlm1BoTjZGU5+Iadwl?=
 =?us-ascii?Q?znO51pANcCBzkVyfJAVhEOjVuChz6X7/GqyCCwp+yw3J67MBaKg6OHFRIB1s?=
 =?us-ascii?Q?14SlYgoe+JT9a0I77EvOQjyiFr3Dq3UQ5MND9mOO87r9LgcZz8AXo2vHz2SR?=
 =?us-ascii?Q?vwdCkX/LeFRmCS5AkDmqKgnk842fItmxhbj/rJ4JITAlLfFfBuYlS0ncrujs?=
 =?us-ascii?Q?K+3x4fbADQ/q68Y79bdFEhTWoE34XKzigbzzJz2vW7cCmGvBMlXfxvyyMiYj?=
 =?us-ascii?Q?ee311Gjw3n/67WpP7p3DGM+2deJb7jm/3574FENwFO8ulMFbOmVSEEoOuCRz?=
 =?us-ascii?Q?LAz/NDzjlvTigjrSun4h4uCaVWTOA4AqSluZPDNwjg7mOhbYHehxqiunAC2H?=
 =?us-ascii?Q?H3rG6m6+YXwDwdvZ7D6U/sS0FDEAWnfvTEnez4+wNds+TKz3YuiAnjC1Hinm?=
 =?us-ascii?Q?N9Aq+24i8vrt8N2EJfejARGRTxdq3e6aCm46EwGFe8qBIpyn4oJbA1Ji7dtP?=
 =?us-ascii?Q?EJPPkvZkJHuUz4kmO99SElG3nBub6eUSwh5AMJqzmiL65XfU5UoU58vCYLdB?=
 =?us-ascii?Q?3gSy7ibpFf9n2YQsVRzZBuxVIQkjV98eDB/5muunHFfKY/b8/OpQLEnTtcNb?=
 =?us-ascii?Q?SElyKkGRl1ZfTXh4SovFendYEw3B+huR8Yf+yZ3Z42wQoDTFo9nNxZj+9YKV?=
 =?us-ascii?Q?1DPLn0rwMhywi1UQd3ce8dR4O2MtLs+zUoEmvN9+ZbL7+XnjdBzJM47NDWI2?=
 =?us-ascii?Q?L4yzmmsfnOOk2o25qe2nEIdSSxtjBBR5XtGDxpepnGyTWNnVxPQUyKilOV3H?=
 =?us-ascii?Q?+cn/k9UlRIzNdWfFdqYXT9uYAyw3Jfy4LhW/miccfUsbD1jnbjvyz7TnN7jA?=
 =?us-ascii?Q?lSBIMZISr4YPCf/+Q0lm2NESKz02Qac=3D?=
X-Exchange-RoutingPolicyChecked: H7fA00bus8iZYoHi4b3XCR0urjzmd4REsMVQ6CH2DvuTC8hE+eVpTW4v8xHZ1dCMBd4AQx7Z8ph0uTnCG/9Q0/MDHa0zj/24to9MbWdY9TALTMNxfftzaFi01eUoD+K9TWV7u7/DiaFrjWrbvedPkA4d5AN7uyv12fq2UKmj/bprpjlpKZLOZ+mXfBApPvOLsu6Mnm6ejk/l9Tzfr+jgJrHlHlHuKwHB2unE1JJszbZ33e6+EOa+v3pXcC2+8KyodmZajxJxBVXw+Hv0mFZIKY4Oiu4c2IvFDKSPDiWn5ix90XpNZ1PxRpZsGykiElGbj3fEW2fnX3G9WIz2c8ZXHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee235937-6b72-4261-c3ed-08de834d7de5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:16:38.3337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf6u0ZUNtaLsI3pUNDG7v2uTYRwLY+tocEO1kwA3ilVbHyb1/E7MYrvgDMvX8Y2k8jlj0dQ+HahcSugY+0ixoMPk1h3xEoEk5Mq+Qc+Ktlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5326
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

On Tue, Mar 10, 2026 at 09:09:41AM -0700, Stephen Hemminger wrote:
> The PCAP PMD supports more features that were not flagged
> in the feature matrix.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

With one item below fixed:

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  doc/guides/nics/features/pcap.ini | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
> index 7fd22b190e..c4f0360a06 100644
> --- a/doc/guides/nics/features/pcap.ini
> +++ b/doc/guides/nics/features/pcap.ini
> @@ -4,8 +4,15 @@
>  ; Refer to default.ini for the full list of available PMD features.
>  ;
>  [Features]
> +Link status          = Y
> +Queue start/stop     = Y
> +Timestamp offload    = Y

I'd omit this or put it as partial. There is no support for Timestamps on
Tx, so you can't use this for PTP, for example, as you can't get the exact
time a packet was transmitted.

>  Basic stats          = Y
> +Stats per queue      = Y
>  Multiprocess aware   = Y
> +FreeBSD              = Y
> +Linux                = Y
> +Windows              = Y
>  ARMv7                = Y
>  ARMv8                = Y
>  Power8               = Y
> -- 
> 2.51.0
> 
