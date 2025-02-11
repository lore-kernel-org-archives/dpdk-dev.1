Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D37C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFAB64069F;
	Tue, 11 Feb 2025 18:06:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 02EA84067B;
 Tue, 11 Feb 2025 18:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739293615; x=1770829615;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=b1rohkBFpXWrfFnYIrYuzQEslVV50dPmlFpaTmlgvE8=;
 b=MR9Y62Qy7tp0ekfUpsK/WmXRQqR3AlnAtdDoaOePpYe7Lh3cCNZKPSun
 sK3BOSUe4OpTDN959TncpF4KtZoDI7zS+UAQ5EvvYQ0n9zmV80k3F2zD0
 b/immd74z5UPicF6pj0f/hXZmykUKi7/h3/55Khl97D5GTMjnZ+fRz8hF
 IKsmUAzB4cuM9taTrzBBKClqLMPMJpvZExtPEtk6R1zYJKRN2abXDTwd7
 CBtt8df4oVWTLbODfd6v989PK6wAs/G4Lq4dSPtLtKrUL6wNAzmp12Wo0
 UFYvY6829SzxT0vpRHNVoGJ4bToGkmMYcjFjOeTiDXBpYPMsJTduFh+Ty A==;
X-CSE-ConnectionGUID: naNXyG/+QIKk2dg6uJEj9Q==
X-CSE-MsgGUID: 4mUWpUEiRWaXyZ8a/Ahj4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="65279238"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; d="scan'208";a="65279238"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 09:05:08 -0800
X-CSE-ConnectionGUID: MBMq5DSKRnqM/oTASgE3YQ==
X-CSE-MsgGUID: IAU8fgWsT0mbaCdRC1ltUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="117496916"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 09:05:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 09:05:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 09:05:07 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 09:05:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeRniL+x6579nMIRjb/+5reeMPDmfjPGmLEWgd1P4JTuGFKUdbp4foPWi+XM3v8pQjtgRmGJqYSwR+rrEdK2U9rS2EnX3IO8CPwyH0sU3ek/+51f598kuohYzp0JEkuKqUOFtvbCVft5oD7Fk8OmPfCQ5XGOZ6lljJic82eOBrlEN6khsLpVnQAV8aUxTE+It34iuHzvLR+rJeeSqoyyYTI2BB33fQEIKpk7mCL0a3wC4u7bnG4HMizTscAhF+psmCogDaLgId8cHXTbKSkcrPGf/feLPXC3mzxNXFys8TS9Y//b/cuDOHG1FD5Mz/RYrn7HUuYOlpc9ucZ78uTQoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W46g3FAOci9zkybjCgJuvBEZRc6JgRwIg3+4iE6+iM0=;
 b=dUj5TtssDc8FL9ZqCEvedhtDbo91qCuctS3T5G3YuD/cV+cz4G1ApAOvzoqw5UHIeSu1YpRNiEBuLr5FzIj2NKvb2i00VqElBBtrAZmZmRmV3O33tN57B052xXdxnIC7HlTrFPkbKaKudCuPlxWguTKJXrb02+wUFtqKZU2J5BgPY68ZuQDp5NLHfsFOg2vR+wMfBHINSuiakVW5kdF3R2nfxL0Kk5EDiliDaFfRFAZmYcEP4o5LYdfm6GViYb4tcwTZhb9nZ6hVDtUZC4TvcbhIa9qK8by5+UlZeMVZme6NGwr82EEbGSShk/jvd8YfynEjzedomNaaL3bKESf28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6078.namprd11.prod.outlook.com (2603:10b6:8:86::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.18; Tue, 11 Feb 2025 17:05:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 17:05:03 +0000
Date: Tue, 11 Feb 2025 17:04:57 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shani Peretz <shperetz@nvidia.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <stable@dpdk.org>, "Chenbo
 Xia" <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Gaetan Rivet
 <grive@u256.net>
Subject: Re: [PATCH v6 1/4] bus/pci: fix registration of PCI device
Message-ID: <Z6uDOf-Isx5iRh9X@bricha3-mobl1.ger.corp.intel.com>
References: <20250206000838.23428-5-shperetz@nvidia.com>
 <20250206105428.237346-1-shperetz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206105428.237346-1-shperetz@nvidia.com>
X-ClientProxiedBy: DU2PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:10:232::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f0e1ff-506f-4300-c3e7-08dd4abe39c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?siEOiDiMpDWorL6NcIMo8Vkq+A+UZ4RQWLFv+7tEitUtMZ0iEFDJZfWsaI8G?=
 =?us-ascii?Q?kt2WjnCttsMuEo6fZEDjbP9rRPCFCNevMxGQxbEkc5dDm9T+UOrzh70QnyZ7?=
 =?us-ascii?Q?toah/Sc8Mk5eZfiHIZgWhv0rmPGZ1aqwqXwSv35I3Iji9sIwpqjjZvng2141?=
 =?us-ascii?Q?68kAIMgMT9TmsFUZFtqMtg16tVdCcQbRAl5yI21SH3/oN9XfAeg5v+z8lDWm?=
 =?us-ascii?Q?KLgWsRnQX5TkhAYL7ADa/7V0mrC9uMuOV+hsfKCJ73/Jf6B7zeU+cX703Pmn?=
 =?us-ascii?Q?4qlO2Go5zbhRrOeJhZW7LWtrmSjOCgQecAv0LufO5eovjvzdchI3ytovHII8?=
 =?us-ascii?Q?YsLs6gVzsGXL0k+1ET4CFP7BAAzemcUQaw9+HOXqqWainzSzrL0hyBpNxgaX?=
 =?us-ascii?Q?2rL+pPHxeqg3mbAiATWvetOMfBIhg4Dri6oVFwRE/bBk1P3RS8YnuAFpk1Lr?=
 =?us-ascii?Q?sM+oapatk7iucPsCh763nwMD8KrrVR87XQ8mL2QgoIs6/SEDuBK0ez03hTvA?=
 =?us-ascii?Q?yBzt9F6XOWbYTqIFPkRwxzBL6m2c5B6xhYlyadb40KSM0cksMiuLlqsHGUVN?=
 =?us-ascii?Q?LIXzOhW81Ft1Avc7ILKMkP70mwT771TB9eHJXdN6xkyGnPXvITuQ+5cSi6mr?=
 =?us-ascii?Q?uF85TQhOzkwOJH26u86Tf+EFFUYEdXFjd1Ag/ZNYuZ03BSpxqz5jscuHxicZ?=
 =?us-ascii?Q?67bp1MtV0ontwL2a5b6dTzY9chVCCtblE1zRA1n2MZpB0wlHC7PkVZ8v8/7Z?=
 =?us-ascii?Q?zi2lCmzqZMnKyfdgNJUUG+byudYU8a0LpkdyCy44nv++pl/ndL+auCMqzGkG?=
 =?us-ascii?Q?aKh+zGFk4OGDAeO0Ra9aQiRQUPsXn2s0s7vA9Hu5pBHAbRe6EaizwQWhjHQq?=
 =?us-ascii?Q?Bw/e31838yVVbX2Qsz1ChSzg7/b5wTuJYKazmrgwZOnOX4VCLzCb2H390M+D?=
 =?us-ascii?Q?WSEzxJkmWDRJgTeFr9ULkDIWcjnF2oK6nXpipgqno4d531KECs42diFej2B7?=
 =?us-ascii?Q?nhPLQeJLU5XE40v293qeKdtzizhSLHr5NRGi5jwmbZzweECorfL9h/lE/Sym?=
 =?us-ascii?Q?oLiB+fqdaDb2DDOVxcjraW4jaCyu2N3VsdIZB4aKF4DI2TPjh1kRyCi02WmD?=
 =?us-ascii?Q?JHSEZvu6LyXO3xWPGqtsf8ZSk8FDuZb7lK2oPA03XqydUxmG+vSKO6/KBPwF?=
 =?us-ascii?Q?jjpG9qUhkf0V9NhYpM8VxbNHMon30AENwmeDSZOb4i0Oj1LRHLP3OdrSPwj7?=
 =?us-ascii?Q?1Yk9VFNQYh9TjMEkRjZnDeP7OqxzEp0jgX0BDWa03c/avNCcUyLtK2xQhEoO?=
 =?us-ascii?Q?SWZsmFVJrus1XSLaj8fUr7JXQ7Aouejc/seXIn6wGVq/fQq6TQazVtqkbubw?=
 =?us-ascii?Q?JzNpUTTqGvn9UJhABvUsJCEWtNXh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Of42dyOOCC/ukDw1EmsdS8ApAa0/ktnk19HaCob/4lX7MIPtguR+juWMO2jG?=
 =?us-ascii?Q?Z4Ln8ciOCDn0W4xvNIB2DNg0/uPhnbNZRspuxaMs8DsdVL+qMkYM+lyDzFn4?=
 =?us-ascii?Q?cj8Dhae79kbO+KkRWbX/2ycDgWZje/t+fIcx9JDlXA7h+2MQIXWeZOMPRe+a?=
 =?us-ascii?Q?LiAbm3CNpGNbEAlb89ryH14wAHD/9aYuMsDcOHywZswsF5CiA5F0jBEViIbC?=
 =?us-ascii?Q?5bFowAz4WI6V/NMMhSiWieVegwWJrYU1V/NzEgJx9nVpKj2BBqW25YLv5eiI?=
 =?us-ascii?Q?SUsG50034fD9Kr6Y97QMJteXjSQPcgoFJ83Kca7s53J+sj8AtQ7QP1bhiD5x?=
 =?us-ascii?Q?MELf0hlVLU1PQwH2N9LhRh3/dsfNiG103FXsRg6imzpedg6ijgbMz1WCdrV2?=
 =?us-ascii?Q?qqY6UiZFhSuhB6Uo9M8PHfu7odL7I1Al5Krii+6IeyqzARI8oF2amova88Ln?=
 =?us-ascii?Q?uKTtlX8fD+fAfK764xwqK0V5xQgKL36TtBcDjptChtWHzvGlPMOkGbVMRm81?=
 =?us-ascii?Q?b3ixOYSC51LaZzzNcuYUoS0hea+vLOn6d9AvO7nKOroqnGwIHAgxB+nMySEI?=
 =?us-ascii?Q?/xE9jU1CshuXgcz6WKo91RAAxKTOlhB0DGBkXJXF1WC80BhwumIwjlfiNeMS?=
 =?us-ascii?Q?tuaDEdMJTihMCHKsNNlSKZsOYAq2n+IXDKnBMv50xOh4Az4cUFy4dxXPkvlB?=
 =?us-ascii?Q?Kqh8brMCwy3YXL/M1VZnR1ZaepvQaOVIMSQnnsmemhbKOCVSKJs6/7D1dl7X?=
 =?us-ascii?Q?FSnQC7CwQ0bG6DPmw/N0xlSUwowDKzEXK7JG87R0wNGd3LkKu+R/EebCXgM5?=
 =?us-ascii?Q?j7QNCu+6XbkmK1l5pjxdBCRJ534cT+pkePXVDpJo/I3tHDvateyCPwzLFU+W?=
 =?us-ascii?Q?2ajHd7LmHp0r2JgVYq4hd+4Ociz0+hEVi+ELyNElfT1j6TaVxsEK8Fn6kjeA?=
 =?us-ascii?Q?qImp2yoMdHAB7Lk8+UUeKLVfYB/L/GeAPj4oetzRJZo7beUD4s36Rp3d5ZSF?=
 =?us-ascii?Q?P4q51yCyLJZj3JAYUDXoGeLTms0H6qJoTkBMD2Paqv6ldmaztKHLp727srz6?=
 =?us-ascii?Q?SrQgnRz8TlyenhI/GnF3mml5YZUQENfPnInnUhrrzfOHFf3akIxY9cDmTqJ8?=
 =?us-ascii?Q?PUXvf+eoW/whHW2GSQ6M00Bp3VMm6wYFQKl+542DFr1GwyR24dpDrmHR0gkA?=
 =?us-ascii?Q?07yZitwQ2DBlj+QqQCoWgxpPec8MNujUdvlzonovdZQ6qHdD3xg/A9f1NGav?=
 =?us-ascii?Q?tkAQungqzoyYe2whmWPwWSygQNYpGT+AH/u1Dy8Cq5TBUuqQME4jegF1Iruv?=
 =?us-ascii?Q?K1bUrE5ECWfmfcPxHU8MxFg/4xOOHuZALjyNW+wbxFifXOsmYXLt28K5OQCp?=
 =?us-ascii?Q?aE9LhK+OzZJGZf+mzr0oTztGIAXqUzuNrV4T0DWZItDCOszYBX7+0O1TOmdd?=
 =?us-ascii?Q?eH0V3B45S1Ggs/i2Iz9RBFvgJHhgGq1ehwzTyGJxcnkuHjHHrcThsWIokZij?=
 =?us-ascii?Q?582N0vWzohkYDrFtBatWH2UB4NnWBmOJtBoNUFhjq6BJRGkvAtq08vReKcsT?=
 =?us-ascii?Q?Ycw3baPzOFDMtc3Kgmww/Uk/RYRj2jBj7J80gH4eFoBkInfCbP+QoOS0sEUZ?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f0e1ff-506f-4300-c3e7-08dd4abe39c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 17:05:03.2210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lkb+X4gacucPnfLoti4qaKNrvlQDOO7Kc69yPC/aA/9AmPi/anv6ajgGgA0416OBFgn1zA4YnY2JSwCV/UWdyKlwhXrq+SPrPLBadu6I7z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6078
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

On Thu, Feb 06, 2025 at 12:54:24PM +0200, Shani Peretz wrote:
> When registering a new PCI device, the device->name field stored
> the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
> This approach led to inconsistencies when registering new devices.
> 
> This patch fix this issue by saving the parsed PCI in device->name,
> so when a new PCI device is registering the name displayed in the device
> list will be the parsed version.
> 
> Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")
> 
> Cc: stable@dpdk.org
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  drivers/bus/pci/pci_common.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
Tested-by: Bruce Richardson <bruce.richardson@intel.com>

Tested with running testpmd using -a 27:00.0 -a 27:00.1 and then using
dpdk-proc-info with the same ports prefixed with 0000:. Without this patch,
that gave an error. With this patch, output was the same with and without
the extra prefix.
Also tested the reverse case, running testpmd with the domain prefix, and
proc-info without, that too worked in testing.

/Bruce
