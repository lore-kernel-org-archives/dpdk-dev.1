Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70865C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 14:59:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E41406BC;
	Wed, 28 May 2025 16:59:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 87E0C40156
 for <dev@dpdk.org>; Wed, 28 May 2025 16:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748444358; x=1779980358;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AnvkE5THvdN7XbnF/UI7MHe2gMIuCDZj0xFMekB1KgI=;
 b=Y5oCwApMcVkAkv+IdZ+zJnIStF/I+d0n0WrNmc6aVHBQodZpO3gOllzR
 2dxo9Uf/1X+Mp8bl7bF/9dVIc7XGhkcSPutBpVnAlEk3G/l8AFn181vIK
 MOxKUGKKbmq8VDqy21s1bnzZ1oI8RRoCmj4G/ooMjj/0idkiFvhnG36IH
 V/BpByC0gSqx3wTUx8oyoVh9NMn51+cpFjGJAcmcXgFO9I/24Dnj0KUkF
 k0aamY8fuo+8D7MNzPUhJaXE5MJHOeo9Zx0UsDCCEYS3gikY8apgwe4Iz
 IpEQd26xZSpBxREvikvkz/gQjJJpzOa8dJ6uQ3P2zPgxff9HKmwFuGmmt A==;
X-CSE-ConnectionGUID: baPRNU53RtaxCHDk90HKbw==
X-CSE-MsgGUID: ij3Xn3VESyei8GdNRG1Inw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61134646"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; d="scan'208";a="61134646"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 07:59:17 -0700
X-CSE-ConnectionGUID: IA89OmiLSOaestqg4u4U/w==
X-CSE-MsgGUID: XPuVbkxzRlCHGxUmjIQLOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; d="scan'208";a="143300737"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2025 07:59:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 07:59:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 07:59:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.79)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 07:59:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j743H91ER2iTHuLqCxorPgfIwbkzb3txkZuhmgVVbmsWR4KSzEJkDJ2oXRxE9YqeFTWoHps7a0AN8+KK+bTiVC9/4FyrrGcwMdsltrwJHG3KX8fOpvn4PlNeUfHDgT/5p8kgzLT4oVU5tT0jvo2UQRDSKLZJrr0MIfZzAYqT3P66R7beRzDABi3xpCSJ/Rxmv7HueZOgkHFhIfOaRLOFjbGilfu5CE9KqkvI+Box3OCkBgtHotWxrWmekOQVTl+z60ZEBaQrZ4e5ijVtsmbUKJ/41bqHrhWlia58ln8n8fuS9/arD/7C37asXUPBTPlcwCAtDMpcx9novn5roXX9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B66I2NV0nz+stZS0cMsgl7im+iUvWi6No45X1ONy5y8=;
 b=MjmlAqH4zVJA5VuaL6ce0/9z9XBpX6oP1MMLtlMvDVNmlsNvocbw9GgpEjca3omF8RnNGBJmF7N5HsnbB482AECwDIA0dZGhYk4l/+8eER4yXPj67xiN5n0d3Jvex6UH5qhPpJtVk1LRftO/74vW6CxL/Lwlzw6cU1h0fVrn8Hv/EiOa6c/J9mQO/3OmBuoKGMzQPfT7+tlZZRFvvmMvgSRHWYG8GUm3UBe1o4tI5ybPLe9r3kXWZeHFaEFS42Mnbv0GrFPzdYOLmsbNNgPZDuugyQ94Q71zG0xynQPDGSjoedlwVy8EuLyJxmYBQIaKeaL/Jskn363+V0Wl+PqNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 28 May
 2025 14:59:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 14:59:12 +0000
Date: Wed, 28 May 2025 15:59:06 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dhanya Pillai <dhanya.r.pillai@intel.com>
CC: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Lukasz
 Krakowiak" <lukaszx.krakowiak@intel.com>
Subject: Re: [PATCH v3 04/10] net/ice/base: set speculative execution barrier
Message-ID: <aDckum8YiGEObYUL@bricha3-mobl1.ger.corp.intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
 <20250527131741.7606-5-dhanya.r.pillai@intel.com>
 <aDcKjfSrOShfJE1b@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aDcKjfSrOShfJE1b@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB9PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 22433071-8b69-4672-343b-08dd9df83529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yBkq/6U/gGwh9C7bxqiauvZ05D8xpCKyo7iUrOAPvsMQI78FMoUjtwk3PB6m?=
 =?us-ascii?Q?KVGqjaXKCoSX5BFvucc5wsOMQ5eeDs1HkaHRME1wxQ0RkHr0thLD+clLsV6P?=
 =?us-ascii?Q?K985MEKaxBq6esn+mbPvQJXrg+c4Jml4uP7Uv5Aj+Tcubowp7OV/C0dredM4?=
 =?us-ascii?Q?BkaKuDmdWwMsNmNnu30UjvPTjPTlE0xPJuXWgbQhGQeTnodwPvPT4NFXLWyL?=
 =?us-ascii?Q?ldARux37C/FP3lakzsnoQnekaYgdYZps5wMKQ/Qu7n7HcxKroi56avHkeCme?=
 =?us-ascii?Q?a/eSjsoUKnZvh65NCICljAA+PUKJ1Sgihj0p6d72HdWxqWopl44g4p2SDiL2?=
 =?us-ascii?Q?HPHkLem+7KxuJPscA/LxfGyTVEr5VzeqP86pu2nxMEXWWsjUbMD9vx2lAoZ4?=
 =?us-ascii?Q?xRfzu9Q1ZT68iTlAQadN8s2t76WdJSkWMXZNt7Yxu0yLCVtNzgCpNpO25PRQ?=
 =?us-ascii?Q?ZX412h+EFVJamq8eBRfcB1CKZ2y90OtOHy5hepaxOSinqB2n6pkkhrfICzEl?=
 =?us-ascii?Q?vHeMC6X1RBuSqWoW75lFrM8yFgaJOVi1B9JHyLsGzVfit8vkx8lx3yGCcMmH?=
 =?us-ascii?Q?IBFvC04oRMGdaI/5DvsJSssk2z6ypTV4Vg551olgbWYs+s4f1MhC7kDKSVdU?=
 =?us-ascii?Q?JDo0n4KdO0XQumcsY21hgkh4laLkT7+ma8zlaEHqA4sspyJXW0vX0mWllt33?=
 =?us-ascii?Q?mkkZRTSL05WrUBShiNRjwpRIYJvD0/mbln/CIc9KpEdYTIZOqlxNFQ3BxTqR?=
 =?us-ascii?Q?WanYq9dJgMuNn1akO/pXqR+/l62+B9bwU14CVv5A/KQ3W9eJq6I0Oa1OML50?=
 =?us-ascii?Q?99bSUbPOsRPLllhklJYTPbvW7zqPdqz0T+O3Szr1xFIham/4LRKrc+vpto7S?=
 =?us-ascii?Q?vfwlEKxh+xT6wwPjy3s2rEeUqeUvbtDZjlDluWg6zXC+n6fAFxVGrD//XVsn?=
 =?us-ascii?Q?5SRkX68EWZdehQI30FWXoFpg/mRW08Ze3mtg5p9qu/sH5VM5PA3qdpFOJ3ij?=
 =?us-ascii?Q?9q2vQTEpKeeG7xYCCcVuiFXMvc0XRAWM8KskWiB50GcR6mg8JVfH+mAQI0uF?=
 =?us-ascii?Q?bIBQ+H/1V48YuiXjv4luF/74yvqwB4LgRtxdtmsEweDokQ9vwnU2r8XwBBZo?=
 =?us-ascii?Q?S1VbyQd1uVOXujZ0SScocoVtYLJ/4su053Xta0r4xJig8Afr9Rl7GuduIQUK?=
 =?us-ascii?Q?s4PvOdDqi8hn9qT2GQhDhlc1dErmCQTYLAuQQL+G9AiuW+4sfIE8ujmpXiRP?=
 =?us-ascii?Q?oOixGc4ZOHdkvit35jbtSFEkXkyss+QNXDrpp3xc75lHK7Jcs6dRW1JYGQUu?=
 =?us-ascii?Q?sNpEOu12lMjgFEjNC+ne++uY0/c2OiMUQbi8IWU8p1++/ItSLaEJUOGlD/Ih?=
 =?us-ascii?Q?h6UhwBcgojN7nZ81hhgxJ0O8mhMY9Dgs3agIDv/MTj3Jgc9E6RoBbaLMzNSf?=
 =?us-ascii?Q?T1oeDFgDwdE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1RLM3UKMMYpADTNlTlmeL4gg0CCWnk1nvMliJCmtWivGGEsLJmOkF4/OZN/B?=
 =?us-ascii?Q?0Xc9g2UCFZBQWI/a1bcdJyx1yHSX7ee/K9tEIoVBPOkAE/qz3HgePnfPWJws?=
 =?us-ascii?Q?X+he7U7+7updNDkwAhFrz0TaDZYuzF/wP+DTTJw2bBapGEya2PiSC+5pEtoK?=
 =?us-ascii?Q?VL6WWa1rrc1Ik1CccTjETXPd4MM8wkRDuJU3Rxxr8qdftNUs+TO0x5TQx3Ki?=
 =?us-ascii?Q?IX79HYQWAhLPBrjy/Fp1AsYNrifXb2jGb109FioPaduA5w8q49Z8pKFB9ZS/?=
 =?us-ascii?Q?ZubEEbU3TdvKhgPDL4vIGJs1sNIsTi98If3iyfd0pg3UfCI/OSSi/YqfxjBy?=
 =?us-ascii?Q?EeB64APXcQxyL2MK9ViCvAP8vPndPQt2BP/kATKncsPDbxNPhtHgyKexZDQw?=
 =?us-ascii?Q?HZ0CB5bHjtIL9FnlT7A8lBQ66ovdNixYEHgzb/3QlG6pVWPYaus9k18KGoum?=
 =?us-ascii?Q?SDoXUoC5jI5i6H7jXWXFmQ0/Fy4NaprEpEQR9EbkycGPCUL/O9U8LHEsxPNh?=
 =?us-ascii?Q?NlXWzP/nB6Cs7toUgpzDkLrhi8bHDP13asVn4OMWpQaBSoZOgp7Rw/QuP8Ea?=
 =?us-ascii?Q?M3IQ6ZujWAxS6yD9SoWHf6i+cnOIx0w8HleoSAhYn+Chl0bJ1ogmiDXfkfOy?=
 =?us-ascii?Q?UoEhBaWLixPsdLnQWt3GzrL0hVB3slYaA8BJySqMARoTjvWVas6p62lj633r?=
 =?us-ascii?Q?mZf4dZs84aRveFGhaoeih1lc1PcbDvU2LZashQ5mI9BBUoXoQRpqCaVRL7kh?=
 =?us-ascii?Q?tKOXfYnS+8r69kC7Zft33NzLOjROebH+mpVSrRbilNNhWzUYvT+kpgmza7Di?=
 =?us-ascii?Q?ichQHx6XTowWQNhSjQ00NVpNWpW0npxBES+AkjU9uazNyTI/Lv5EeAKGZ+y/?=
 =?us-ascii?Q?tfeW576Dq8RFDCUC5Xvs2Md8N9CLa8+Adruf+lgPznhjvkPRAkVctUUvnFxz?=
 =?us-ascii?Q?hDx/czTanS4ls5XZpWDLMRw2DJsGY2m2sRqGF/kzuJLuk1izcCrT1GJWCF59?=
 =?us-ascii?Q?q3COWSv9DrjKYeu0CRod2ENG/sVtfEiTxbceMtSe8zAO+IX+v8HEAdRXauoC?=
 =?us-ascii?Q?PbAh9EXWtsad1+f3y+Sep2Od0MyuszIdFjADZrVTKrHRaPB9xayvaLCU5Htl?=
 =?us-ascii?Q?Id7QA7ko2DB/nEYyV5BhtI4xi8B8VlC64O3D1IeS0LspfqD035XReeKUG5XR?=
 =?us-ascii?Q?zXweFCGpl+TZENBcFSglxFys5E2MUBgyGnczMuPXhDBAy/70GZXKOJEkyW/1?=
 =?us-ascii?Q?5pY6Bv0H/cYrDxtFcTgcXvE8K7P+hZd6H5Un74HViBVPzA0Jlo2rWG+OrqpR?=
 =?us-ascii?Q?SMU8yuglnl9MGozhCJ67+oEGCWUbW7OaAhX3CO2/eeoHqNfp3fXyb7QQD+OP?=
 =?us-ascii?Q?gJixdOhHcXo1cmF565VJYJ7SCsCqzSoku6LU1LhKhfg2W1puGVrHczpjg5jY?=
 =?us-ascii?Q?EiiEYi/CwATLzXOZJ2wQf0Yo3DAa7yX469ugkgsX0mX2FeKQO9+VZUDBGwed?=
 =?us-ascii?Q?B9gno82bA9Ift3XYmGSpXewymNDg6I6J15cSZlYtqd8G2F0ya/xgKKUfGgqn?=
 =?us-ascii?Q?CX4b5actMoX4iuCmjhHUxDg1I0wJH/qHYh0UWzY5oU57/oWh/X7pbcRBqvMg?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22433071-8b69-4672-343b-08dd9df83529
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 14:59:12.7956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3ipNmo44ZIcG37IvB+9p03WY61GIQDH+9YE3qsanF5EsRAzD5ly/NZgw6LwJKKICzKY1pjMI6sIfr2wSZKibYe9vH+J0SZBqEugy4decrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
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

On Wed, May 28, 2025 at 02:07:25PM +0100, Bruce Richardson wrote:
> On Tue, May 27, 2025 at 01:17:23PM +0000, Dhanya Pillai wrote:
> > From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> > 
> > Fix issues related to SPECULATIVE_EXECUTION_DATA_LEAK.
> > This changes set speculative execution barrier to functions:
> > 
> > * ice_sched_add_vsi_child_nodes,
> > * ice_sched_add_vsi_support_nodes,
> > * ice_sched_move_vsi_to_agg,
> > * ice_prof_has_mask_idx,
> > * ice_alloc_prof_mask.
> > 
> > Also, Added memfence definitions.
> > 
> > Signed-off-by: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>
> > Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
> > ---
> >  drivers/net/intel/ice/base/ice_flex_pipe.c | 2 ++
> >  drivers/net/intel/ice/base/ice_osdep.h     | 6 ++++++
> >  drivers/net/intel/ice/base/ice_sched.c     | 3 +++
> >  3 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/net/intel/ice/base/ice_flex_pipe.c b/drivers/net/intel/ice/base/ice_flex_pipe.c
> > index 6dd5588f85..dc8c92e203 100644
> > --- a/drivers/net/intel/ice/base/ice_flex_pipe.c
> > +++ b/drivers/net/intel/ice/base/ice_flex_pipe.c
> > @@ -1280,6 +1280,7 @@ ice_prof_has_mask_idx(struct ice_hw *hw, enum ice_block blk, u8 prof, u16 idx,
> >  			if (hw->blk[blk].masks.masks[i].in_use &&
> >  			    hw->blk[blk].masks.masks[i].idx == idx) {
> >  				found = true;
> > +				ice_memfence_read();
> >  				if (hw->blk[blk].masks.masks[i].mask == mask)
> >  					match = true;
> >  				break;
> > @@ -1648,6 +1649,7 @@ ice_alloc_prof_mask(struct ice_hw *hw, enum ice_block blk, u16 idx, u16 mask,
> >  			/* if mask is in use and it exactly duplicates the
> >  			 * desired mask and index, then in can be reused
> >  			 */
> > +			ice_memfence_read();
> >  			if (hw->blk[blk].masks.masks[i].mask == mask &&
> >  			    hw->blk[blk].masks.masks[i].idx == idx) {
> >  				found_copy = true;
> > diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
> > index ad6cde9896..7588ad3dbc 100644
> > --- a/drivers/net/intel/ice/base/ice_osdep.h
> > +++ b/drivers/net/intel/ice/base/ice_osdep.h
> > @@ -203,6 +203,12 @@ struct __rte_packed_begin ice_virt_mem {
> >  #define ice_memset(a, b, c, d) memset((a), (b), (c))
> >  #define ice_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
> >  
> > +/* Memory fence barrier */
> > +#define ice_memfence_read()
> > +#define ice_memfence_read_write()
> > +#define ice_memfence_write()
> > +
> 
> I suspect rather than removing this, they would be better defined as
> rte_smp_* barriers. As in:
> 
> #define ice_memfence_read() rte_smp_rmb()
> 
Correcting my own suggestion - since this is a NIC driver, we probably want
to use rte_io_* barriers, not the rte_smp_* ones.

/Bruce
