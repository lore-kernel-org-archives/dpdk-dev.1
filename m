Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC98EEB26F3
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 18:20:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34DC840A6C;
	Tue, 10 Feb 2026 19:20:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 431F940678
 for <dev@dpdk.org>; Tue, 10 Feb 2026 19:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770747618; x=1802283618;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=REzrDcPlWw70LoOTD9ZcJJDIW6fnDDf4bm3M1ouqnac=;
 b=PD3IqHCrwBUVNizVtTG4gZo8mucd87DUrLFKnGnlaPC1lOlsRQQJ45qm
 xtz9dd652Ny8DpVx7qaA3xVe4nR5/F+mOWahukGToNcPWfwIoBN2/t7SJ
 4cS71fu2McAoDNHq7/Pj9+QcYzw0wVmG6nC8xl0krLVLUZ6Qt0C/gqrAD
 rFHBxTAGAvtxKMns2+7lrUFPcJsE7j2lGlAMSURlpIfecqXXrEYkwnIFj
 uzoPrpKK3ds0lxkVSyVAz7mL7Uzhiw8jX2Sf3YedC3duFVI9zxaV9mhCO
 Ve3o8L0gKaHknegy2DAoOT5BI9srdFvh4Tq4kv4nNztRDQ1xjIYR1ZMHD w==;
X-CSE-ConnectionGUID: opKsrZEpSj+WotyOjUYTDQ==
X-CSE-MsgGUID: PpEqkZ51RyeH23zpRN7aDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75730128"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75730128"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 10:20:08 -0800
X-CSE-ConnectionGUID: 1n3Z2PpcSCi6jj+GfLoRpQ==
X-CSE-MsgGUID: B9PV100XQj6ajzlkhPXWIA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 10:20:07 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 10:20:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 10:20:07 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 10:20:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN8Ak0oaTNFDAh+r7WBxfDfMjVs9TTBppAy9i58Q+qxuEiR+6RRTzfp//BznvUmjqsFWJ8XngtEyOP3lNbRacmp8DDkqdJGOIZx5jUYvvrR6wmqP2asRYTTA2wjnqF3jf+LYZAVHCUTaAmnfeB0W3eflyma2KdhJu0DdEwmifVe/mFkZDyvQ7GHcHd+65HbFDIJYydyncEItZBBvnmThhGugT4I378PTgcvrRdf0samEGGPOW8C35McLi6GVYklUAzWe89eH4GTOWiYMeSr4kAwWWvBgKWL+gwPBwo83yTf0G6DKvHek+wICDcznjRBLH8o+SxU3J72/4br/gcVuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdZ5h4utEX4CxjSxi9x3BcaWgD79og7LY/DuyoXbxfQ=;
 b=op68mgzf+7inIamlA5XmD3uePWWcd1q5tKOBBo5rdQ4ClNqoQZIfUJBxoJqOM94lbdWNlmAw655kyYJ+dLxFn3oRG9vdF1tIX6odkuDHCRm8EwOTYlfRS/ADZ18SKSJADyfSjmrtyYFCzQehz8C1sG0xdolAaQnqZ+YPvJfDPEstP9AGwTgtr5/sH07te1eyLm2muLRoFIMzk4+4NzGZmRRlYZMh7KEgSdLT4/XlRK3X4Zvhe92fzHpEcdNB3D4iecBQsNZnzX3tQTD4mvxGqcyek21ziUQWhv+G5sriw+opcQr8rdevGSDXB1YddWUytBW7YB06XNypfM1uy6guVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 18:20:05 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 18:20:05 +0000
Date: Tue, 10 Feb 2026 18:20:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 14/35] net/intel: support configurable VLAN tag
 insertion on Tx
Message-ID: <aYt20BirTtIdIutY@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-15-bruce.richardson@intel.com>
 <6d8f5c9d-c014-4763-bff0-215b43656b9d@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d8f5c9d-c014-4763-bff0-215b43656b9d@intel.com>
X-ClientProxiedBy: DUZPR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5309:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b9248e-c191-4f94-0b89-08de68d1039a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AnN/cSVjNnMmbcsE9KhomnVzVLIxBU3mw/n6leFju3bjoMZZvZJ44SKmwcVm?=
 =?us-ascii?Q?nC92vnkv+4t82AUzXc4F3IAbvez/e1VfRAzsVnr4wRQlPibS3UV566eB1EHP?=
 =?us-ascii?Q?Xi0pvCIFwtggZED/ftubbdkZ68rnJbPI0a2HUaVtCfJ8zI7vX2FMAgBOYKc/?=
 =?us-ascii?Q?SbUjPP/6mdvA5TfXb7/RkS5SgXmQIbalDE8pBNAza0/H2R4CL8reV6Pv38lO?=
 =?us-ascii?Q?PayfevCxzgJWQ4yAaE4HmzClRtVkChBpbJnCoFLRRzmZyGwfB0gLRHiZao6T?=
 =?us-ascii?Q?HzBGRYI8r27gAt2dcVx6OTUy1ximUkHn5OQxeR1prco7TU+ru68/fQbWf+lt?=
 =?us-ascii?Q?EE0QA31J9PS/QN/a+UPPr16St98LmJ5iIioKZpEfDFOFiHDDW2kS+JAcNyQH?=
 =?us-ascii?Q?tPJXUx0tfJht3xz36vaXpHc0OpF0EGOH7LkQbcAM75UM0680ZCbW9l6f8ZDI?=
 =?us-ascii?Q?daHy9F4/apkAt4D/Kx8G/wHT96WQOP76JwbAJ8ujjWrHHZesKvjylEoEXiwq?=
 =?us-ascii?Q?GDuP8zUOCErPt4mNeurRcBrZh+TG6/z0w9eDvuKlca3MqkiwpYrUOa6ZZLNJ?=
 =?us-ascii?Q?2Ov5XfAxaP6GYwx4r3x0ZwTY0roX8tn7ichx5H/RUUKfPrYHm11CvXlu3n4N?=
 =?us-ascii?Q?SvBQERHLzhoHn8wjvi1y+SCXTR104P+RDN3OYfjgH0OCvZV383ZZvxsST95q?=
 =?us-ascii?Q?kxWvqHe/c6+X5ZfBvJdX9XivXI6qku8fWMU+tOWaqc9Ey9zeJiJEE6uvQNZP?=
 =?us-ascii?Q?t91eGsW4IjltVvLu/rrvhslGqCQqE/lYQ8vNkh2/IcWn1nnoxISBtVdNDJHt?=
 =?us-ascii?Q?yykGGEcsDmq+0f7OwMWngHzqLAMGtH7gSMnjzu+Uy53J3eSZxb+W2ZPApZR/?=
 =?us-ascii?Q?dPaR0bgvRnfniwCUJv3GELcmVozbRFGT3j+9XtxlIHw6AuS4hcmj8ok8xsbK?=
 =?us-ascii?Q?xNCIQb3DlbV7eajcUJ9ZFYVwlzUfQ/2bkzTEFxd2D66yUuTVgavshMf9NPai?=
 =?us-ascii?Q?/8tS1Bmgvallzl3jiUGDmW1VzhNTIaY5PCSrnXnfI8FJkuIm0gcqu4ABzEh7?=
 =?us-ascii?Q?kZ7OizZnkk9pfp/vlclaxCfWiQIFfvqmEMNe5SxLcJUZwWOmy5lywFBQRZEe?=
 =?us-ascii?Q?jLPQVAzv/5VPFGZfoyueXyiiKhYjiFt80PvznFDbbTKHV9KMkQzeidTHcl7E?=
 =?us-ascii?Q?SJkGpVjiz52uMIicBsSjscDihAVfSZeiI56GlNmser//qnDDSaWlKzZRt/BE?=
 =?us-ascii?Q?TyF4sEJh8z/q4iTgZt6kzHNiPo1FQAKALOiLaKH/9UiEOT8RL79nlqKoWc45?=
 =?us-ascii?Q?GNHKffRvxAB93rKq6oSi1dk4hEaqGEprdmmno3NuMR6DUyWoDjt0QD+qA0PY?=
 =?us-ascii?Q?UZ0VJ/K3/U714FTybrrI7YnqAaCAVaJYqvAkj+wxllJyA+jU8/D1n94fwd4p?=
 =?us-ascii?Q?L3I5/bLAY6G76z8CyqqENcNpata6/MvwHFDVmJVIAsjU5kaYXDcnESNR4knG?=
 =?us-ascii?Q?ozi5F9TmMXcDGxKnUws7GCKXkPIpoSiKKEY8uO86amcHMgsPS5Dlwl8FCDp5?=
 =?us-ascii?Q?2UZjXXgL9HYoR1u9U2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9A2/oCJAMHO2IXQlCEkJeta2xVyW8dG9ba9Vhsc+5C0Y3aaZHJRsZUe15aH?=
 =?us-ascii?Q?CSyay7quDcKj+HZ0sh2SmvzRvb2X9Z4qjtRPK2ux41jo2vX5FO+fZeOTmalg?=
 =?us-ascii?Q?D8o6s+9DQ6bXuau9Lz012Mtq75WLXbLV+qQnai7B+vIB9BMLd0SICQChBHSR?=
 =?us-ascii?Q?rBgWOWpcorABWKo/PaSv+tU5zpF7dS+4gjaYHbjQD2bP0YJY/5BWMoyz+b0H?=
 =?us-ascii?Q?HhgA8bR+CPPxgOS5WKdozE2bzaF6i7dMSdAWrzVx4wAId8pm0Z5L1Nba7/kD?=
 =?us-ascii?Q?buxBCNUfrAFuvA33Lj7i18YHMQMIJ1JA4JrG7Lqa8Yx04REK5JPa7q/Y/GG8?=
 =?us-ascii?Q?x1JahYGGeDBjbp4IWB+o37tPEcDiSyr6j7eCVHrbyT6HrcLTytMrBNaGhG+r?=
 =?us-ascii?Q?FqfyA01uKzy9/1PxvqrGR3eOzGtYaiFyJIK6UEaHkT8T7eEJDirfrxBv1X3w?=
 =?us-ascii?Q?C2HgUvnMCfIDgPj21k5hb5gzzXOlLpm4p18+ZBtEAogHR4MXykfRQmKzQ0yk?=
 =?us-ascii?Q?ORiMCpw7IAGFYSg5gJdGXDXzN8XDUDBHTYXeHiD8VzKqAqpH2X/x+Zjwy0Ex?=
 =?us-ascii?Q?fVnJyv7ZHbwugQhsonuMJ0+XNBAp0sWUgcr/u65AgRiM2ohSnsnqktRWp6RN?=
 =?us-ascii?Q?Z2q1jPZ2ZNE0Vo37t9aBeI0k+BzxpYfFVOoROAXNjUZ6S37TTcEJhbxGYHvN?=
 =?us-ascii?Q?zxadpxsbtxW6Giaynh/bPf+9Q2FkklNKEmpxfEyRzdl6gSu7jd2ism7gC0Gx?=
 =?us-ascii?Q?tsPCWhS9yf4YL7uAKo1i+pg0CWi6wO4+yJnA3/hcS73nzGnG24lVjfIA5SPV?=
 =?us-ascii?Q?iXVzH+CCNcuktiXfbaPM3+RoB7B/dGaWwW2DdG+0ZFAfq7pj0GQgPoGxPJpB?=
 =?us-ascii?Q?Q7khItMIg9HTmoD8qqMGhHMd1IMLrxoo0HbCpYrmDlR1nNpZRnNxeQlP1kIE?=
 =?us-ascii?Q?809banYrbk5SHWckTrGa7VDCCo7dvwgkmBJWc9tbjGsOVNeqxJmaE7KmBs/j?=
 =?us-ascii?Q?e0WpdIDweAx43Qleq5JaGC5dYbOSA7FkhX8xLNOjDYHsUpaP3e1UdHNelPjL?=
 =?us-ascii?Q?VZWsu6OnS0fpwXuPBzRrzJyyOMd5TrhvOorSBaZIZdBcyMNMMzFIBVS4p1Ix?=
 =?us-ascii?Q?2hKFAn79IzhdUaw94cTzWfnamXQUUSTDxhAhTnbxrOe0L3Yd3hEK6TA/+Jpa?=
 =?us-ascii?Q?2zV6j8szD+dBCa93ZiN0J/Ow2NQK58/21oWacwjr7Las5ueKjKOusM7xFMs7?=
 =?us-ascii?Q?faLEHG78uYB2AI8PdDdcIcTJsG1CHyQqLtFdZxnd63l30ploi/rluEjl6CPy?=
 =?us-ascii?Q?rmULDGUy5IQevMcmxIYNvR0T/yXHycARubPwRac8jgf6zMN9pBaXb2NUc3P+?=
 =?us-ascii?Q?wQd+TGWA4fbktggbkEyMjrY+Ry7S1W/uM9sBCzuv4l4iv0T4aBmk4pgrebCA?=
 =?us-ascii?Q?pilvqFyCdOPN6dTw9qrlQTWqYg/CTg2LpkQmKuvIH9P+7vFATzUPRyNH/4sW?=
 =?us-ascii?Q?+e520qvskg13N5x+3v/+Oz9gaxkCTAWlgXqU2aslNDwmcawan+qAu/3fVhLL?=
 =?us-ascii?Q?vyJ/kunFtOH7bNSNEv3Iag/Sj66S32Sp9ErJHOfJtduLDNB4ZtNnYfjeud3G?=
 =?us-ascii?Q?1k0vjKzgo4of5WNwz1tZX2845+hPFVRywmKsd1SSbvIw92yFDnIArWZKyNWw?=
 =?us-ascii?Q?ATXJEPle6Uo3P5HP9/WdB7bq+RoeBh1+ZMxPE+XDcMnz+kSeQbYaBaOKopSK?=
 =?us-ascii?Q?qpkqX6aDdbro3mQeSYRil/X4zymwS9s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b9248e-c191-4f94-0b89-08de68d1039a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 18:20:05.3480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCjp4MFVssYoa4RviDdgIj7IB74l5Ir+Nz/0pUxKj8gZGThdX0xLSRzSpxlQ7U7/tJqLeV/yu+Ylf72Lbkkq9APr9aq01PYQesxZPbgStE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
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

On Tue, Feb 10, 2026 at 02:21:49PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Make the VLAN tag insertion logic configurable in the common code, as to
> > where inner/outer tags get placed.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> Hi Bruce,
> I might be missing something obvious, but...
> 
> > -		/* Descriptor based VLAN insertion */
> > -		if (ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
> > +		/* Descriptor based VLAN/QinQ insertion */
> > +		/* for single vlan offload, only insert in data desc with VLAN_IN_L2TAG1 is set
> > +		 * for qinq offload, we always put inner tag in L2Tag1
> > +		 */
> > +		if (((ol_flags & RTE_MBUF_F_TX_VLAN) && l2tag1_field == CI_VLAN_IN_L2TAG1) ||
> > +				(ol_flags & RTE_MBUF_F_TX_QINQ)) {
> >   			td_cmd |= CI_TX_DESC_CMD_IL2TAG1;
> >   			td_tag = tx_pkt->vlan_tci;
> >   		}
> 
> I can see that we insert VLAN tag on TX_VLAN and VLAN_IN_TAG1. But then...
> 
> 
> > @@ -1004,8 +1004,7 @@ get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> >   	/* TX context descriptor based double VLAN insert */
> >   	if (ol_flags & RTE_MBUF_F_TX_QINQ) {
> >   		cd_l2tag2 = tx_pkt->vlan_tci_outer;
> > -		cd_type_cmd_tso_mss |=
> > -				((uint64_t)I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
> > +		cd_type_cmd_tso_mss |= (I40E_TX_CTX_DESC_IL2TAG2 << I40E_TXD_CTX_QW1_CMD_SHIFT);
> 
> this logic is only triggered for QinQ. Meaning, there's nowhere we insert
> VLAN tag on TX_VLAN and VLAN_IN_TAG2?
> 
For VLAN_IN_L2TAG2 the vlan tag goes in the context descriptor, and
creating the context descriptor is the responsibility of each individual
driver. The two drivers using this common path, i40e and ice both put the
tag in the TAG1 slot, so don't have a path to add it to the TAG2 slot. We
make it configurable in this patch so that in the next patches we can add
in support for the iavf driver - which does support putting the VLAN tag in
the Tag2 slot, in it's context descriptor function.

/Bruce
