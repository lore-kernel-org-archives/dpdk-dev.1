Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0333FC02199
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 18:04:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9BE2402BC;
	Thu,  6 Feb 2025 19:04:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 587E34026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 19:04:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738865085; x=1770401085;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=c2eGXhe7j5CH5QJgbpYg4KohLEK07SVamdw+efmACYo=;
 b=C8opZKN9YVqDiFUtkG6Ta0ofimSz2yeClmYbvHRxoA6z4b1KKkBLTipq
 z/iy8Dadi2ex6GmRQ0wKuTUd/wAaQ8uvIesJubekSGIJFXa3Sme3S7S5p
 DF9WAw3ahAthFqX5meMqgftsORuok0Sw3gMBN6nz+cMOfC0aqtAxX8zR1
 SSTxP4mGNxF/YesEGHn4r/bk0rpO3aFKTNKjJBtF5XfrvdV7L3AWAQzyh
 z5gudVc4jWTzaJklM+lTx5ARKJhT24G8aXBjJI5kovbRL3HcM1PLkytSQ
 iTPAytpkbaRh+J60VIm3tJyJ1ngaB9atZNschmLpGn5tg3a1/X0RnEjz9 Q==;
X-CSE-ConnectionGUID: Y6wlhppFTsyN0DgS1u3D+w==
X-CSE-MsgGUID: 7lrYQJ2zQGGrmrLiI51OJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42324426"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="42324426"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 10:04:43 -0800
X-CSE-ConnectionGUID: cwzVAbiRSTuheSqO7WHYQg==
X-CSE-MsgGUID: mY7SwVzGQlOJoPxGUh4coA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="116316507"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Feb 2025 10:04:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 10:04:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 10:04:42 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 10:04:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4tTDDp7nUGCzDp3sYuTvkq7mdFY2ctf7eYdYvg7SiFlDM1H2JFF5tE2GiSZKyGFpWBkhXlOh/X7Yr+YgCEnkzpgNjEfv/mEqXMJmjdUvZygQkgIJ7swwQg2k1WkhPCRldN01HAmCfMd7fiO1V5Sa/vUlF1no7fsLo1u2fIrWNrg1p20XGBsLeg4jpiUGuI0OeMpQwVTTW5EiASa5sYsnDzdbxTUNykZ22xPAsDVBw/oGszG1TjobWIaQgzh68laEYo7EUDmcuggCoZGFe16Wr4y5C0Knjbym80tAy0LP5/mr2T9NEtEpbY9DUdvOM98KNvLES5bR5LLErbiARwJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11ldtVP4c4O4qNqO4AP+WB6mTTjPIefhGeP4jGx0WAo=;
 b=PaDVRDrA8qID8r5Rp+St64bwlx5CRdYsVefqDjnandlSnPD5Z2F7l0JsfGXq2KyvupiF4eSQzm9gHMnPOwUfV1eyuOdesp7rw0IJqITJTl9Cx4CCF64G6/+gAsBmGLdmR3AW47lYgY+r0PJodH13ldDEUcbHxdeww7Z2rNNfOUxBigZiKGK0qd4xkFifEaA94sO8LymN7owx4hItL7JTnWY1W8ZIOds1ejCdeG/9yRcesCzImwMR1VdL0qTgOh8mBELoPoidKSKpFRR/0BB3edyNqmgAvr6UI8k7B2dxMHgZx7Pp7FR1U+fb0u/Rsy8OIo/JbInAC6cMAJANZdmvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5169.namprd11.prod.outlook.com (2603:10b6:303:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 18:03:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 18:03:54 +0000
Date: Thu, 6 Feb 2025 18:03:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v1 00/24] Fixes for igc and e1000
Message-ID: <Z6T5hprFhZdm7YEQ@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0282.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fb4705-348c-43b7-a78f-08dd46d89e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KRlTA9Z4D2M6hrjPaX5EUQId4lLxSjZpNBbAH9xiwX7lKG8PiptAXqhCdagn?=
 =?us-ascii?Q?jUM4DrHfwdBMlqhC1j0/+Y62Cp6WxRK34vcdhxVivNBxX9snSKID9qRiMCBG?=
 =?us-ascii?Q?O/kHJGoYYP9BDnBS29MzA+xBXBj5PWvY6ksIBIJoWrH28/zcwooTURIjg3U7?=
 =?us-ascii?Q?MCpH1JggSeneyY0c2uxCtKpqNFM6mCQPDmaPDI9obLPItXTA+rJYUM5Ddpeu?=
 =?us-ascii?Q?0drzUBmw4qM4uhEteg0QGr253iMnuB9/DnN8F3RDskZvoRN/B+21AUTJWl5i?=
 =?us-ascii?Q?77ehGOxfiRKSeMLrklZrfuMswTGgP3GShXb7cBGJ0qR4Flc/667vN8CRu5wG?=
 =?us-ascii?Q?/p8psHwNLbs1sUxHZGBCq6kY9eHDM1MzRa2ctedSPIZ5Pkhg5u2IyyLrND1S?=
 =?us-ascii?Q?abACi8Qq0B/c/5ENCmWs7PBLjJsga62GHFmfsAx89coqkJFTMNlS2UzdJF8b?=
 =?us-ascii?Q?aPMV38CKsA+fS6ss+MUGS3ODnUxpnDo9EZCbLOAgaqnjtxSc9EL86p9q+tpt?=
 =?us-ascii?Q?T/k8X92rCVwYaOBWZ638Ia3ouNhNd/EPiUeUQ030xa6OxsUxvGMr31sGU8ai?=
 =?us-ascii?Q?cjUeQhwqN2t5dclxVv0Pug8f6jcroIlaamoofBcOEIQDSxpaMYVdxrQULeZI?=
 =?us-ascii?Q?b97E2WYyit25aXC0SGBQB9XgQDKGrqcFyj1s0Z5t4hhahr/Y+ZOF3t7D/3dT?=
 =?us-ascii?Q?Rrpkq3Ovl92ww228yuAb5tMmCY7kfYF8OVEKYA074xCphNUwA8ViO2CzHBUU?=
 =?us-ascii?Q?a7FRGuORw8TPWWEDum1DhfD61deBgr3D84KipKB4xUiJIY8x6lD2gfHjE2fR?=
 =?us-ascii?Q?/FoJYrRfhXhFQP6d3phUEWTKeCaX6zZ7zgFp3pj3Htc6LLugZq9/3Pj0/Tie?=
 =?us-ascii?Q?Ce9y8cvcQA/cnH/MKU1O3NiFkga/na5iGzCA5CZbAYPbQ5aZdnxe++3mgyGI?=
 =?us-ascii?Q?b96ltrj7RSRUU2znKkGG7mVgzvMZloCa7uvMjMyhxpDnAOHx9qzW/bNMSUv4?=
 =?us-ascii?Q?ygDyFmX572W8yMmXdi4eDOM5iaiboQyC2A2cPJZDAyINEgSea1KwXYks7/tz?=
 =?us-ascii?Q?p42MXNvgW6vCjxa51IkGtg+8O2iSxrcmEBP7+R8C8rmSqO1oQ2oGi1BUBhvP?=
 =?us-ascii?Q?Vr5A746azDmVzIo1XLV2BiDcm3SlVscUdyP4+DU/zwEQRRj0dThy0kJ3sPFZ?=
 =?us-ascii?Q?kUNj5XrynHPw9jg4TsT1zgyR8o0ZHFDitJIvcKl9RNYwtKO15UpAaPvQCHY2?=
 =?us-ascii?Q?iBRk+Aok9cWy+goQ04EAgeinOMwLvPyLVTJk96OrAs+vkIwVk6O5rueqeSBN?=
 =?us-ascii?Q?tvrSAW0SLqRdlZK6PjX7JU3T/NI36YDO9MhY7gkmfnJYww=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+MjqAs9rLE3y01SDmK875OS3T6WuE2jrAqAgE8DEudFbANlho6N7dQK0wIA?=
 =?us-ascii?Q?kx7TX9DMgAxFujP+tvANLjto5brHjr2W/u96RbHd/F3W7cmQD8986rcFJZMU?=
 =?us-ascii?Q?Rt1qomV0e8r+Ogm9E26zPbLWG7a+OgbBl04ydOHip7CGbyGtbsgWQUhvWtUx?=
 =?us-ascii?Q?zMw1Z9tZAsbQT/KPwwbgF2uczBu5WrARnkdgYgv6zfZR1+PKOs++s7k9d7Vh?=
 =?us-ascii?Q?FZAZhvpBylwEjqyNHblsxtI2Z1VmtiGYwKMuGVn+xy60/MKdN2uProYxcypj?=
 =?us-ascii?Q?aiNaCq05WjAD/ux9Slc5MatgPXlldD/XVctVPQ+DDPwbD5TP20Ex+eJhl8+C?=
 =?us-ascii?Q?IUgPdtKNhN/BDVJD0wN2hHVZbrZhZCcqhoNPkHwVOD6dup4rHM0xhpYHYoVs?=
 =?us-ascii?Q?oaEj/1LTo1eEq4Acsc1IfdXcMbjgvUVFyDipl5kySvW93xhRO7NaCYfkn7Yw?=
 =?us-ascii?Q?DNdj+t8zfPr14aZcVVTADrhepMBA2ZtTu190s/O/zuPz+YCW+gc974ipvG0a?=
 =?us-ascii?Q?jZWLVq/zKOV0M951a2+DteKy0vuEmqd213w5kyjHWkXL7bOoVg3l2c85Thzg?=
 =?us-ascii?Q?z1QZa/+W6j/dg0VMO4yMO6HG3dwXWkli/7r9rBfbH2FQtGNNaD9FsGNYvRBQ?=
 =?us-ascii?Q?nRwyHo6RQGPuZDh0hpfOjU3p5pnNwN6wT/Qr8D9G5cIPuPgQjWtuEi5ORyHW?=
 =?us-ascii?Q?h1utQi5JizeEZZeyqCPxNQlK6nFhnf6+qChLx+w4lgHVGP9qCh7XUuufEhdx?=
 =?us-ascii?Q?zqgDPr3Fu2NYmCTmipjJu+oMPJhIlefRpK2RQfsfisAvvYNPmt+plTP0ABva?=
 =?us-ascii?Q?D8YSwaPW67KqmpKu0vgdwb3A9OC8ofRwGeTayMdu7y8Zvgi4sP3k1TWSiFuk?=
 =?us-ascii?Q?hnIpxSLHs64yHEUTmbhQV1FheB8eFopx6sjMq6Lb3wCYICvIPlj9++mmycyK?=
 =?us-ascii?Q?Kism54wQtWctS3Ur/znyIXiO70+prRRajcHhKXCUNH6vdOst/I36uNVkJvBp?=
 =?us-ascii?Q?VGeMvDfZVBWKGd7y0u9u+Gx3Is7BX+Dg3AGFZwRnXiEaglZIuCAHrRbnt2se?=
 =?us-ascii?Q?NNzdxRrzsrs91yDdIF5qFyW0/BTEgJRBwvMtElfZdUKnpWYN2WgKhuzaOkCf?=
 =?us-ascii?Q?aZhlq8L9Q0jdjsEbRiNZ4JfA18kVUMPLvr3ArTym3zQpfDxL8OSbOVu7C9Xe?=
 =?us-ascii?Q?ol2+8VOs2jXi05iT3BCsGUbPVTcA3bZrBSG/kpOm47wbieFwmolMY8Sjsohe?=
 =?us-ascii?Q?k3IwYENElFXU9oaZGD4S7AMPDH/MeAOG5xPorgsYWRWxN6FXKnirQ8JZrh6M?=
 =?us-ascii?Q?8qU/hVH9tP3/L1xmPfH/buXGmfWk2Jg3bXo1mLpQU9EvAJg5S7BMfgPCe5Gn?=
 =?us-ascii?Q?9UAxYt90zt4OlP7Bw4+5KNFAypfbuTZQGsppfFutE0yo3OH/yKy0DLK1M3X3?=
 =?us-ascii?Q?/6YOjU6RaSIBB88qJgJ4pouDj+BGNuNNuhtpjzBUCu5P2qoN6JsE+UBIyAUO?=
 =?us-ascii?Q?cttjHXLW8I6Q3Q5TLboZv3YQlj0SQlHoYDm1lDLWyVJ65lWE8CRRSYLX+NJY?=
 =?us-ascii?Q?nVMmdYAiTfBIplGZlTrJGYwKqkIfbn45I7LdpF9Y+eAICVWwIyZMX6njkubn?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fb4705-348c-43b7-a78f-08dd46d89e6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:03:54.3505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5HLnhnx8Gr7KOv1s426a6UeqN9DA2/JyEJdCLP+8biC5dOd2uuUkOsU93aEkaL+ibSpYy/7VTH+YgZnioXhuQJUytU77i+o9nlp5KzJYkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5169
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

On Thu, Feb 06, 2025 at 04:08:23PM +0000, Anatoly Burakov wrote:
> This patchset is taken out of recent e1000/igc driver update [1].
> 
> [1] https://inbox.dpdk.org/dev/cover.1738681725.git.anatoly.burakov@intel.com/
>

Thanks Anatoly. All the patches for e1000 and igc will be easier to work on
in two sets rather than one huge one, and it should make it easier to
backport all these fixes too.

/Bruce
