Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33518606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A69eEvhu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81EC740297;
	Mon, 19 Oct 2026 19:07:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4901D4021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 19:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792429622; x=1823965622;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GIzV6l/RyLU3EpnH5bQxI5pfO1pbANJ1I94jGxfowco=;
 b=A69eEvhuoZXR7cJcbe7GnXKPAwR/8wobDZrxfZ5UL/qqj2tp67BZE5IV
 uDugGJVFZZ5/IkhvRMGIyW13KIIvytwIR3g+xMoAvLLrmIq3t6vjh3Nbn
 oqiV+W9uOxe3/NniiSiki4ahHC2t03r47QuH6JKZa6xIM4geZ3uLcYnns
 m8u9ZNQejBfxZx8OvEVk3kc3sYgrm8NKfbvro2/l/8AOHLSUSaYiTaO08
 kKJuwZISDRC6HSxr7TmUNOzdj0tGy9EOQkoWKicPMp3KecqoE2n23vOsJ
 /PW4LSmkVWblsag3EFI90l5/EE0wQHx2Ynj+Loh9RsL05sxmdA69p7GRK g==;
X-CSE-ConnectionGUID: z/AoCB05R0Gs14aA7j/3IQ==
X-CSE-MsgGUID: IgR9+swSRz2uMZB8jmxNow==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1003682"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1003682"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 10:06:58 -0700
X-CSE-ConnectionGUID: PITv2ccuQVGJwBeJ8bOJIg==
X-CSE-MsgGUID: SX6U24G+TGuQzzQ8w+gOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2985846"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 10:06:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:06:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 10:06:57 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:06:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEBHMmO65qUL5Vncs+4tEoNVuBOf27RoxZOh00jp5DxkuS+BoReu7VhBopt24balRZ2FARBYjt13FFwGX4sxxt4YFkFJOPWNQZUMz7KBTixi6pOUDzTqXxpRzBNbFxoAwfcJi8HhOOiGyNts86n0Mf4qYkzKp9eHRX/uayIA/D5ottrLmtF9k0Qx3Y5oIBcqemcPiIQce4zGSB5X1+YqxMSHoymtTFpIZyaRc3aWNQ3m80pFgDcHzE8ep7K3J5jWD4Fb5a8jBqLEwxF2N3ahXl4GDkvT4pb+5IscbX6JMKySQUcGGuD/lvQ+S+RDksy1LnX5iLNZbIqRR41pkkSmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Blh/+VKzi/FVBbeyEAdvXH+sLVNoaiB6jyRJqcwfLQ=;
 b=kOVtVYZdkU5zToOFoLncHpf2RN3+e0272awvFEcdWXv8q+jlZ0o2DJEd/KCSL6jkFrfoH4mkaT6L5Q5zJ931y+umdQHH6PixPo+rmJU7PFYlMZ3ILrQ45TLx58sOwFO406nyY2jiWzEOXFOG1nd9V52zsK22vscVm5Bdnq/6oHc5PUqxO/e84yofhRWsogTpQ0HxYkmiyNm37fu1Cppc8uJYECX+0pGI72x5WmJlfROG022vsqs7rJU+EINRw45cu0HlaDzLqYKEuXZelXRIQyNBKcLoBih88PUYF4wVeOBR+XH2gbUHqWEwR+DxvKNrM3ak8IVt0llPPC+MxOMkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SJ0PR11MB5867.namprd11.prod.outlook.com (2603:10b6:a03:42a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:06:54 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 17:06:54 +0000
Date: Mon, 19 Oct 2026 18:06:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dawid Wesierski <dawid.wesierski@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <anatoly.burakov@intel.com>, <marek.kasiewicz@intel.com>
Subject: Re: [PATCH 1/3] net/iavf: fix invalid free of queue TC map
Message-ID: <atZOKGtUlpulSC11@bricha3-mobl1.ger.corp.intel.com>
References: <20261014122419.631288-1-dawid.wesierski@intel.com>
 <20261014122419.631288-2-dawid.wesierski@intel.com>
 <atZJlMewvnJu781L@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atZJlMewvnJu781L@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SJ0PR11MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f62b57a-aa42-4208-9a06-08df2e035fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|4143699003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: KnhPt1N7Z2HR7nhVWNpspf8MsKewRgGVMF2Zcz6JSfoqRd0GSvpdh1lNPdVf4rvKBWgUGFpNmjkb9wW28gXnkxc6yHqWHVRfiY0TUA6zwBCtPULNeXYfLpIwdd/ULZor6x3Hb/l9PcMWnpsS8xEzb3X9vJlSmsMzx3dVb68ccCU0NgoWEavkR4oSzXarL8xRYcPCCUT/ppOdMhsUkN3wz/Xbz1Gqyf41+9n+fBETPpnShOBH8XwAoPrxClSUMN3TLQRwXTi3pzE56lJW1KGvI98abBtChDwZFdrO/RZLhN0uxHFhwSEg0rTjNSiD/5Zl+7bQfWgIkNAqVchT8eRS6BWU76H7bmDrcmeFj8dEIU3ZBe9guFmqiicKwvXNXTL7ygQCjUUUceaFZaAzE9ENXV3S1k105lme/AUkxGU0Mnvjr9c22Us3DVtCcQTU6zk+flIaoPzWbGewuUwFywE5Hn/TxzIrd5UojkorvFr4cQ+mBAZGuvV/rZJsjCjMAY9HR4weKqfolfT+Ap5sbvFgVZnaOAuh86g/gG72mb2V7KG9hYAIXiUa2u8hysy40bwyi8u1zMIr86ZBBzFswwy7oI+pE7+TNb9PGyjhuiMrbcwmhimVQfFAFP2zlMm3rlzMT0SKgd4aTq9F3xKPngd5nes72TbJ+dgQrT87L79dBFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQAdzqWMtut8MdCyFkSjeKbZkVHQcv9QKHKsDeGEqUfSF4P0nde7XfiMiIre?=
 =?us-ascii?Q?RXlgKPhH60x9L1zUJFk1TA7LSjl8S/OJOl6Kcf8mQTb3VVl/gseeCYzrh2+O?=
 =?us-ascii?Q?nxH90vwl64sxQky9rNf1sIH3aGzDnI4KhNatklqDor9gO9M0e14GnW9O+p43?=
 =?us-ascii?Q?XOehaa/U3YslPc1sbQT3D49zbyM04O8Iwn3tJYhMEeacKDwZUquPQNVlzp6Y?=
 =?us-ascii?Q?XW/eLVREQohDLBSpjrzdE+Fie+vdhpAPL2WFHkIphlxkpaPZTb8unDsTY1EW?=
 =?us-ascii?Q?hHcZwtH1f8CUwqDU4ntj1gTAURg3xp4HEe07dIQLNSggvJMUVwu+JCbsXw2B?=
 =?us-ascii?Q?CDN069YSOyRzb6jAcY3ceAkAiFfCELyL1AhPz3lQX3xxmyeXrrCWhgIGlz1G?=
 =?us-ascii?Q?FoI6KSm7w+o65Hm/qNV6Buo9gubbeXMkY/JNYZ1pG6DdDeTZukjdx7prslci?=
 =?us-ascii?Q?Lu5qMGA3xWr4EHgjmQT5lYZbwKEN/JPOuzajhb//8C+IgjuWicv3/5VwtttL?=
 =?us-ascii?Q?Acxv/m9JHvZgvAdQKfpQshqmBx/6C2zbd6j9fjqslGflM7ii44ESGCe2QPan?=
 =?us-ascii?Q?MvUmN/MdqxbrY0F+vvJaw9gkAwPjmly0GHbSEnG0huaNbKczYT5NbGTkXAcK?=
 =?us-ascii?Q?OtqFcIfrrAXmJRbDRIBgVGbCoVV0rYJu9jq+S/D2mOw2YBrWdN6gXIOsNI2R?=
 =?us-ascii?Q?bY39ct32PCcK/yP5AkidQjjrPZCDKOTy1uAjRg5FoQaTU/ffYdm5+70SQR1Z?=
 =?us-ascii?Q?/zK4AU0ZL/6IKF4fftwtGBxHuXTE2+MpFliDtJU28V+JQ0auguoSkIT5+mJR?=
 =?us-ascii?Q?Qq8LFbtn1H8/b9JYi5k6cw2eLVG44xxEbanyUkZ3beEK0nFI8MDaAUdRlIl9?=
 =?us-ascii?Q?576trEmAlk7DnCWn3rHcLJrZ6vF0ELwpsmGBnNyWumBRbRnQbjdOdUEXo9MP?=
 =?us-ascii?Q?b/XSBLf1uAA2+CgYK2kdw/72pMpwhd8iVJRLDtb0nb4A3zNQhfhAsiMFGhZo?=
 =?us-ascii?Q?jTcp2h+X90Y7czo30QzTOwl4Ru5kp8P7g9Dvi6S6/Y/+Zq9C7YwafB8dzITb?=
 =?us-ascii?Q?RmPN8mnVqLeanipbNxj0LSQdn9m84fox4GqbmcEJN2QdnHcs31PBPBz+qcsB?=
 =?us-ascii?Q?RA1ht6f1qyFDZWLNTj83Lhn0PsEtaUOnOJPKUvyDcpkuN6PzH7U4b4Gnr6x1?=
 =?us-ascii?Q?aCUl0ThVuSYN/T4czytVd6L7KaeqdBIMZmSvVgwOo4IhdxHYgDPEw5T2uHiU?=
 =?us-ascii?Q?xvVDgA6wPMFR2uag1SheMcH3FvrzZWQhdyr3WRIIkqtnrXe++Juhv79UEw2e?=
 =?us-ascii?Q?15hB/mFgLfmC1QJiOqfccpR4tXpPH9L4ZsvEbdNRpAHk2wmkyGNg34/+xkmo?=
 =?us-ascii?Q?IF94ZKvQpcCm4lTDy5Fz9O0BkOpq5BuaeJ722120Ra2ZGEYZhJqaz2/Xv/8k?=
 =?us-ascii?Q?EHA66CXfIMcechK2thV6c6n8RcZtEqQbPQYISV9aNFoPunqzed8zDv2kX1qZ?=
 =?us-ascii?Q?NSNaEk0X6ZCJdm0cQco7FupjwFErAXbiY0ahPMeQqru61n1ZtGl7m7uxoQpa?=
 =?us-ascii?Q?bQWS9JmvSuemT7TJRKAyVRlyhPK/tz0D5Al/miGphd4t6WVJe31Ad5NFS6mf?=
 =?us-ascii?Q?nKh8koaY9Tos1ze1z8V/z86HbZCUTmUiAdZXRugExyOVEfixMz2CBWFOPCv0?=
 =?us-ascii?Q?8CimsJuw7jjYBdUOB2VW56Fc4OGaaRRuPd6S6zWjhXqb0sQo8D6mYCGt+FfI?=
 =?us-ascii?Q?F3CU9SsCBYpakJc3BvAnKeut4KDpA5A=3D?=
X-Exchange-RoutingPolicyChecked: D2HJV/+3IK1QN21LmqjUzjW/V3SMkeg8FZLLI2ab5aazW2G5enzV9QlPP+vzt/H69mrQBlZTDNvfidVl/aKpAcJaXwru8krolMaIas6r8NOKofXHkW+1ED7O0FzIl97mHnPm9AP2F1iakPU9VT2JNc/UBwqfYlNbJ3vaEAHMBj+YA9MB+cYdLozK4PEG6dHc3mnYVVYyv7cRePo7hBcaoV+gjqYVyQVJvnwm+XXqKYjUA3O2rKTrS5zRzySOjP0xgo0xWEk6+k5NKi9H+ymmt+TJfr9/U5VapoxWUIH/SQtucWt78OYsR5GZRi2ZMl8V9C2EAIAhLbHVUq0dgarYFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f62b57a-aa42-4208-9a06-08df2e035fd0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:06:53.9597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tywuhK10Tv5Nmn8UDQdCCYodFscyCjA2wlURerDAkxbf5Td4E1t8NLG0voZq+OSMlk05DF7KGyfWkDZSLHz8upBc3poNvp3Az6tD1vJtdXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5867
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 05:47:16PM +0100, Bruce Richardson wrote:
> On Wed, Oct 14, 2026 at 12:24:16PM +0000, Dawid Wesierski wrote:
> > iavf_hierarchy_commit() allocates the queue TC map with calloc(), and
> > it frees the previous map with free(old_qtc_map) after a successful
> > commit. A later change added rte_free(vf->qtc_map) in front of that
> > free(), because it was written for a tree that still leaked the map.
> > 
> > After the first commit, rte_free() gets a pointer from the libc
> > heap, and free() then releases the same pointer a second time.
> > rte_free() reads a malloc_elem header in the bytes in front of the
> > pointer. It usually logs "Invalid memory" and returns, but the result
> > depends on the contents of the libc heap.
> > 
> > Remove the rte_free() call. free(old_qtc_map) releases the old map.
> > 
> > Fixes: f6e33f09f766 ("net/iavf: disable runtime queue setup when rate limiting")

AI review flags the fact that this commit also introduces an erroneous
rte_free call in iavf_uninit_vf() in iavf_ethdev.c. While the call is
harmless (and earler free is done and the pointer is set to NULL making
rte_free a no-op) it would be good to remove that too.

> > 
> > Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> >  drivers/net/intel/iavf/iavf_tm.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
> > index fc84bf7e6b..603da09bb5 100644
> > --- a/drivers/net/intel/iavf/iavf_tm.c
> > +++ b/drivers/net/intel/iavf/iavf_tm.c
> > @@ -913,7 +913,6 @@ static int iavf_hierarchy_commit(struct rte_eth_dev *dev,
> >  		goto fail_clear;
> >  
> >  	/* replace the previously committed mapping, if any */
> > -	rte_free(vf->qtc_map);
> >  	vf->qtc_map = qtc_map;
> >  	free(old_qtc_map);
> >  	if (adapter->stopped == 1)
> > -- 
> > 2.43.0
> > 
