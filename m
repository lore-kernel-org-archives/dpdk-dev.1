Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7854ECAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 13:40:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B71340669;
	Mon, 29 Sep 2025 15:40:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9C40B40668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 15:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759153235; x=1790689235;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jI3QlcOcGMZIM5mtcLqjuwz4tCOnIP3ZIhWRB8A0DHI=;
 b=CctaLo2NGQm36MmZq9au7SBOJ6cmvATeGikhjuyQII4CqSgqb0kkA3uM
 jp9SYLJ0bBrdpfzf+ljzvFF36KTiv2Anhjc2SsSdMbu5hfjK2RMynxNJC
 0Cd3BnTA9jfxo1Iz9IlEYLvgZbMf/h/yJjtZEXm9+VsGzMZt1mnLQiKus
 rPnutMQLmXt9n8UnHu9z1Hncw3BXWQZk6XgHkew0X7YNgwp1QLpfDgVIB
 DFvC1xnpwXcQ2zMyRRo1cG0Igmh89UXcnVipKD1+JFiHCDCq2dY+oX9UA
 lADYhnrFx87g+CJ819/KCRKn4yDetsrOZBC4r4VxeJWaLzBk853TstFP2 g==;
X-CSE-ConnectionGUID: HUfriVgZRG+yBBouyWZNMQ==
X-CSE-MsgGUID: VsmM5e93Trabj1PvZPUXLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65029165"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="65029165"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 06:40:34 -0700
X-CSE-ConnectionGUID: mLHJR8OUTZaog7LWZb75jg==
X-CSE-MsgGUID: v09YbVA1T6ewM2mwQVitJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="182531483"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 06:40:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:40:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:40:33 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1MQUm9bcgiaGgOpAFDmnpJdxUP31cUuhd1CgcpGUBNbZQYs35pDNop2x5rW3fDJ8HsDrNq4JKpD5FsI/59UDOJlFd67+pH6Ys6Yh85vAMiMPVieZZZ/ANu9HY7Al7w+J0v1B3W29OFECd+i8/MAvsPI+1PrlNOKRnjfsCprkuu1epVew8N0PGzbDTX4yTlbG+yS+OcFvPlTTVvTo446qApbV/ovdsO277j67qlBxMJ5IkVOBrVdTwpyjJRzpK4lLP1/OyHW8D6pD3G5OoZ87pXHAzkU6gJe7AL2oxK1UUaLD3DXLGWkZ/RU6mQT4wbYcgFEVt3gDqIzA8XlmOzUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xvqwvWn6v2lYhMfiVDPuPjhkPSd6O5eOn1wnFKJTDo=;
 b=Alh61815hcBMzPXTLMQc45tQdZTxiuGUY6N7ZbBB4FCy23G4vdq/2yB+jxrC3v7nAdSRBBXGrj6YzwdJDzBHJPeu0gAgaw8WnvIAWzNo4MjGbR0ZnPfWTXhZuRDNrUzhSXqhpCJNWTW37nNMwWLSVWcgqxYzkrRErz7Kdbk+rHQ+bBTz+E8n0hhKje+22jtc9zZi+GOL28IZpdSAX7DldRBevariiy0/7HxRvGL6lm0u0xEkA2Kr4vsfG5QkjYWOp9AzLAKdsB/DPPOaFgYecFD4UXwuyLHAd4TvpTths0olSG62qusFqsQsonu3okGJMFc2cnQEetvPEo2v0bekQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB9499.namprd11.prod.outlook.com (2603:10b6:8:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:40:32 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:40:31 +0000
Date: Mon, 29 Sep 2025 14:40:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>, Dhananjay Shukla
 <dhananjay.shukla@intel.com>, Atul Patel <atul.patel@intel.com>
Subject: Re: [PATCH v3 3/4] net/intel: add config queue support to vCPF
Message-ID: <aNqMSu1HDRB8qsvd@bricha3-mobl1.ger.corp.intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-4-praveen.shetty@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923125455.1484992-4-praveen.shetty@intel.com>
X-ClientProxiedBy: DUZP191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c03a459-f0e8-4fa3-bea4-08ddff5dc27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YLywYCAWgrbnpewxp3AQ7CjqsxzxKSXnBtNWv9NLfw0yveDumUiJzVIR4llM?=
 =?us-ascii?Q?GApGDHWMCEZ4B9QpzUectO7XGmUk2jKgIaU/0vjKWQApB1mTnsbkeTg1DnHh?=
 =?us-ascii?Q?+aLNscWXbmazpDwma05Pn7Lxa7qW9LNNdrlUK2EENHss6aEjI9PT74zgbQmR?=
 =?us-ascii?Q?MVRN6EjYYspGIuIr2weNfMJJsJIkQi4XzUc6Ia2kkNlypjI63+ueYB5EP7NO?=
 =?us-ascii?Q?hWGMZkiA23jQqy7rQEnoid9S+AXWvOdONkFYod/E11v3SliHrnfCubskk7Bx?=
 =?us-ascii?Q?1OCskAfUQcnG6j3DcXNgA9w+EJFS38Wiot4cd7JTKQQY798vB6bC/vwMDOUY?=
 =?us-ascii?Q?jB8MJFRrnGJ2S0/bX/iOgz5MLCl/HBptB7d3bt1xcj+U2sxdo4gsrEpCCgQK?=
 =?us-ascii?Q?MwUHw3H9m75PjLD7y5Efphl/zEA5rUTK4pkqa9kwleHlXEe//tKpZDpdVFM3?=
 =?us-ascii?Q?HZOBbrYf/cEfQ2MfOoURfbfD1uhm9FMRG9nT0L80SCv6rZksdgZMBCtjOTLR?=
 =?us-ascii?Q?0biG45UcJQmOX5W2YxdNjPRnMXoGaYzi9A9qY/hRcUg7QJ1+aEBIg0rR0bYh?=
 =?us-ascii?Q?o/2fXLl4ajSpW/18Rv0BFCaXWez5mU3ZInS+maK3q3VgI8Do4GLXZ2BdVqRo?=
 =?us-ascii?Q?Hnk++z4IUaPWx0WZLHWYtesT8yybfwFEPkE4hjFbfvFtrmfI+Un/Uthzp6Ne?=
 =?us-ascii?Q?ePp5jmUNO3CypoEMjex4COQd02rqA6nhYxYYgKQ8eUEJpfTKOq6jBsQ23/gv?=
 =?us-ascii?Q?+coPRvES/IINj2A369rk2110w4MbAEQI/CB6A0sZeyld4XGtxaAH830ztx89?=
 =?us-ascii?Q?ROY6aCWv54iaag9eLf7dgnA7iIUFo0GcRQZi2lbycSU8aokmv4mwEPLFSNoM?=
 =?us-ascii?Q?2XdqPRkh0r6aXEVSmLE7eoec+lxWqBll8fcYpLcgEa15vdT/s73Vz23eQGRl?=
 =?us-ascii?Q?UUUDPGzPGEvKn1AtK7HKnsStZ1VbcnTXrTeqxbkjGi+vdMHVNhc958p3P23n?=
 =?us-ascii?Q?3iVOxo5Nd8HtKSzRw7qpKtoz7fNV3AhjnIAckKdjqew6neWqRjpf8fSi3to5?=
 =?us-ascii?Q?By06kQjXKOAa9XOXn8uk12PPGPHzCgDeCwNUR+NB+3YHUHqmiHzG6lNWle5x?=
 =?us-ascii?Q?14hTlvCBuwwQ0f+nVwOqOJhRIspqew4RHO3x7IROjs6sRzJEsE4xpvrhq2Nu?=
 =?us-ascii?Q?WP3w9Hiup5ZNETHAoXtgWwCt2nmeBRsgPi6UgpwPIhy2s9QjXH+nVNLjzy+1?=
 =?us-ascii?Q?nCW0EtIWfZy4E1dFAPPxyV7wvAxyOToD+lHJcWxeXjySrXxae25wjVPLqnOi?=
 =?us-ascii?Q?fMQBMIrtiCYitnr/LrmpBT5JefEKwuQmZX98jMkKgysGWeivlorImA15I66G?=
 =?us-ascii?Q?m41wKVsvePD+y0kpMEIaJ8MYP7wmawl7HGRz0X0tildKU6W38gADqLRrM0p/?=
 =?us-ascii?Q?xoJfk1PTNsNKf4onMugJXqqmMfEPcIF7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t6+lzZfzFq0s8vWAZz3dRaDkmqylftwxPjqQh0fYwNDW6EFPoF751CKZenxs?=
 =?us-ascii?Q?oZ4eKPXpLj20F6BGsm+103LcQd2TYiQ0o8K+ANb1uezBTYtkVEcbjww0GfU1?=
 =?us-ascii?Q?ikYYx+k8h2GB0R76SrBFwI580BrwJ/zDqEXxLTKgRXxitMIicQDikHj7Lx6L?=
 =?us-ascii?Q?5fN4hsF3S2i3CgTlJo3qpOiQtzenvGHuLxD7R2+f4pKxxqEZCbXI04IsznAK?=
 =?us-ascii?Q?SnSGMuUYewuV1XU2oeSTQ0A9b4+u8im6wtLj5pbRCRmpnhhFidQnW6z36b+f?=
 =?us-ascii?Q?C3fhBfZ7RmIqC83e8humpRvLYOLpFUL6zhxQlBDVXmRO6LVDyRfw/RdF0Zey?=
 =?us-ascii?Q?bB16iuJyIcCMtsDe6OyPG9z/9PI5T0LXEaSNMdUK6XUQA9oliU+kpEePdUbb?=
 =?us-ascii?Q?1e1PJ9kq8qagsO/CATI3mJRX9a0QGGLQd4U+4tPn7yZxaTqsDNbOM+czG35A?=
 =?us-ascii?Q?X1bsYkwAcdbEkyODhukrpx8lFH40SonlSmFdwKH5iisciOuGBCTIP5+zx930?=
 =?us-ascii?Q?Qw2uy+rqTi4o67dlHeez2Y0scwPC/YowJDqG9Lr3AcOvMjyxrp+szc21HEb4?=
 =?us-ascii?Q?dj0lA8/i7DI7SogQb3qXbp7R9y1iViszxlGnWPzQ332J9+LZNBk+cBH7vIDo?=
 =?us-ascii?Q?yWLSXkBkar5ooeI0lnVVBV7yZNtiaKXrCKyH2NJX8Juiw5+vCR081/FiL4pj?=
 =?us-ascii?Q?H3txRkYQu1iyJE17AEH6hOwmh89jYFFWSSAt8m/mvP9Fehke2GHIpCYAigBJ?=
 =?us-ascii?Q?/p8HaPXHFkOfEQPdGcULwp7dFyPlUGDx6e+x/ecHnzjlqST4M6YSKgVOWa/J?=
 =?us-ascii?Q?1BE9V6E7SLrfrhI1PNfDUd7U161s9s0l8NN1xclaL9fnabdt4NlFBLpy10Ql?=
 =?us-ascii?Q?Fuj3dxk26BK1ckG5oehgyQWl6Vw1ClTFppMJQjCDp7AvczBmFxwKMmo0DQ21?=
 =?us-ascii?Q?feq/DxToGV+7o0nk23YOw3KFSAJhjjpNUD7iyHOPl6JjFN94gqJyy9tXwPZG?=
 =?us-ascii?Q?M4bDbZEPm2sFlVC8Hg8TxT3GgNvictd6r1IuH4DDV3wurA3DO+gvHiGZ+fGj?=
 =?us-ascii?Q?obHdVZrHMDUNQlHoWq8nT1j5+zB9t1bxrFAoN0y7rODPB80/NXwZNxlwYa8m?=
 =?us-ascii?Q?HE0Or/rEKt3/UySWpYN7o8ltwSOx5BQCq3F/vbj6z3qk2drRieY+mkXnULAv?=
 =?us-ascii?Q?sblV/zJz4OFKlctsRBcenCblPJys0MadWNXqvtmwzJqY3wJ5au6DSxsT5g0K?=
 =?us-ascii?Q?v/8SSqEcXnexAlwz/TshNqgLj6IgAYrqfvujhQiOuH69A2Z6dJevyBAgA+Gx?=
 =?us-ascii?Q?fXSxZhp3a23ddQ9rcDmNFuY2ZZDiGUUKL5AMrdYQ4baoTZSicvipheH3Fn75?=
 =?us-ascii?Q?wdoLgME/8hjhI/AbEfyVZnLs8iwF+Nd2zS8ISucV1WLA8Hf6LoAxJnC+dcz0?=
 =?us-ascii?Q?E0j2TxUP5fRz8nZyEj6rTyiiSoGre53Y4+GDy4v0osiBP/FMuotzpTrjPXSo?=
 =?us-ascii?Q?tc08rZeM07PHFH/ScWSa08fFTKlDMV64orjnVchVlhtcRwhmKajltO7MuTjJ?=
 =?us-ascii?Q?hB/X8R+k53Z4/89fyx/PLS3PFO/dkWc5cAwY4fJgLetLt4tZfmEg2ylQ4fwM?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03a459-f0e8-4fa3-bea4-08ddff5dc27f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:40:31.9186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+Zh7PvI7fJ+QEg4tGzARO7xAzHycuquti32JtZpuWhFtmmSFEvfnuF6wi+Wgv0wTq1EPU0/+DyUwCU19FrKzMJFWf4o/UqLpJulNNlTKC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9499
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

On Tue, Sep 23, 2025 at 02:54:54PM +0200,  Shetty, Praveen wrote:
> From: Praveen Shetty <praveen.shetty@intel.com>
> 
> A "configuration queue" is a software term to denote
> a hardware mailbox queue dedicated to NSS programming.
> While the hardware does not have a construct of a
> "configuration queue", software does to state clearly
> the distinction between a queue software dedicates to
> regular mailbox processing (e.g. CPChnl or Virtchnl)
> and a queue software dedicates to NSS programming
> (e.g. SEM/LEM rule programming).
> 

Please provide expansions or clarifications for the acronyms used in the
commit message, so that the commit log is understandable for those unaware
of what the NSS is, or what SEM/LEM refers to. As far as I know, these are
not generally known terms in the industry.

Also, you say that the hardware doesn't have a config queue, but software
does -  I think that needs a bit of explanation as to what exactly the
patch is doing/implementing? How is software providing a special config
queue if the facility is not provided by HW.

> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Tested-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> Tested-by: Atul Patel  <atul.patel@intel.com>
> ---

Couple of small comments inline below.

/Bruce

>  drivers/net/intel/cpfl/cpfl_ethdev.c          | 274 +++++++++++++++---
>  drivers/net/intel/cpfl/cpfl_ethdev.h          |  38 ++-
>  drivers/net/intel/cpfl/cpfl_vchnl.c           | 143 ++++++++-
>  drivers/net/intel/idpf/base/idpf_osdep.h      |   3 +
>  drivers/net/intel/idpf/base/virtchnl2.h       |   3 +-
>  drivers/net/intel/idpf/idpf_common_device.h   |   2 +
>  drivers/net/intel/idpf/idpf_common_virtchnl.c |  38 +++
>  drivers/net/intel/idpf/idpf_common_virtchnl.h |   3 +
>  8 files changed, 449 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index d6227c99b5..c411a2a024 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -29,6 +29,9 @@
>  #define CPFL_FLOW_PARSER	"flow_parser"
>  #endif
>  
> +#define VCPF_FID	0
> +#define CPFL_FID	6
> +
>  rte_spinlock_t cpfl_adapter_lock;
>  /* A list for all adapters, one adapter matches one PCI device */
>  struct cpfl_adapter_list cpfl_adapter_list;
> @@ -1699,7 +1702,8 @@ cpfl_handle_vchnl_event_msg(struct cpfl_adapter_ext *adapter, uint8_t *msg, uint
>  	}
>  
>  	/* ignore if it is ctrl vport */
> -	if (adapter->ctrl_vport.base.vport_id == vc_event->vport_id)
> +	if (adapter->base.hw.device_id == IDPF_DEV_ID_CPF &&
> +			adapter->ctrl_vport.base.vport_id == vc_event->vport_id)
>  		return;
>  
>  	vport = cpfl_find_vport(adapter, vc_event->vport_id);
> @@ -1903,18 +1907,30 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
>  {
>  	int i, ret;
>  
> -	for (i = 0; i < CPFL_TX_CFGQ_NUM; i++) {
> -		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, false,
> +	for (i = 0; i < adapter->num_tx_cfgq; i++) {
> +		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
> +			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[0].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, false);
> +		else
> +			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, false,
>  								VIRTCHNL2_QUEUE_TYPE_CONFIG_TX);
> +
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to disable Tx config queue.");
>  			return ret;
>  		}
>  	}
>  
> -	for (i = 0; i < CPFL_RX_CFGQ_NUM; i++) {
> -		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, false,
> -								VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
> +	for (i = 0; i < adapter->num_rx_cfgq; i++) {
> +		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
> +			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[1].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, false);
> +		else
> +			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, false,
> +							VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
> +
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to disable Rx config queue.");
>  			return ret;
> @@ -1922,6 +1938,7 @@ cpfl_stop_cfgqs(struct cpfl_adapter_ext *adapter)
>  	}
>  
>  	return 0;
> +
>  }
>  
>  static int
> @@ -1941,8 +1958,13 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
>  		return ret;
>  	}
>  
> -	for (i = 0; i < CPFL_TX_CFGQ_NUM; i++) {
> -		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, true,
> +	for (i = 0; i < adapter->num_tx_cfgq; i++) {
> +		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
> +			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[0].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_TX, true);
> +		else
> +			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, false, true,
>  								VIRTCHNL2_QUEUE_TYPE_CONFIG_TX);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to enable Tx config queue.");
> @@ -1950,8 +1972,13 @@ cpfl_start_cfgqs(struct cpfl_adapter_ext *adapter)
>  		}
>  	}
>  
> -	for (i = 0; i < CPFL_RX_CFGQ_NUM; i++) {
> -		ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, true,
> +	for (i = 0; i < adapter->num_rx_cfgq; i++) {
> +		if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF)
> +			ret = idpf_vc_ena_dis_one_queue_vcpf(&adapter->base,
> +					adapter->cfgq_info[1].id,
> +					VIRTCHNL2_QUEUE_TYPE_CONFIG_RX, true);
> +		else
> +			ret = idpf_vc_queue_switch(&adapter->ctrl_vport.base, i, true, true,
>  								VIRTCHNL2_QUEUE_TYPE_CONFIG_RX);
>  		if (ret) {
>  			PMD_DRV_LOG(ERR, "Fail to enable Rx config queue.");
> @@ -1971,14 +1998,20 @@ cpfl_remove_cfgqs(struct cpfl_adapter_ext *adapter)
>  
>  	create_cfgq_info = adapter->cfgq_info;
>  
> -	for (i = 0; i < CPFL_CFGQ_NUM; i++) {
> -		if (adapter->ctlqp[i])
> +	for (i = 0; i < adapter->num_cfgq; i++) {
> +		if (adapter->ctlqp[i]) {
>  			cpfl_vport_ctlq_remove(hw, adapter->ctlqp[i]);
> +			adapter->ctlqp[i] = NULL;
> +		}
>  		if (create_cfgq_info[i].ring_mem.va)
>  			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].ring_mem);
>  		if (create_cfgq_info[i].buf_mem.va)
>  			idpf_free_dma_mem(&adapter->base.hw, &create_cfgq_info[i].buf_mem);
>  	}
> +	if (adapter->ctlqp) {
> +		rte_free(adapter->ctlqp);
> +		adapter->ctlqp = NULL;
> +	}
>  }
>  
>  static int
> @@ -1988,7 +2021,16 @@ cpfl_add_cfgqs(struct cpfl_adapter_ext *adapter)
>  	int ret = 0;
>  	int i = 0;
>  
> -	for (i = 0; i < CPFL_CFGQ_NUM; i++) {
> +	adapter->ctlqp = rte_zmalloc("ctlqp", adapter->num_cfgq *
> +				sizeof(struct idpf_ctlq_info *),
> +				RTE_CACHE_LINE_SIZE);
> +
> +	if (!adapter->ctlqp) {
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for control queues");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < adapter->num_cfgq; i++) {
>  		cfg_cq = NULL;
>  		ret = cpfl_vport_ctlq_add((struct idpf_hw *)(&adapter->base.hw),
>  					  &adapter->cfgq_info[i],
> @@ -2007,6 +2049,62 @@ cpfl_add_cfgqs(struct cpfl_adapter_ext *adapter)
>  	return ret;
>  }
>  
> +static
> +int vcpf_save_chunk_in_cfgq(struct cpfl_adapter_ext *adapter)
> +{
> +	struct virtchnl2_add_queues *add_q =
> +		(struct virtchnl2_add_queues *)adapter->addq_recv_info;
> +	struct vcpf_cfg_queue *cfgq;
> +	struct virtchnl2_queue_reg_chunk *q_chnk;
> +	u16 rx, tx, num_chunks, num_q, struct_size;
> +	u32 q_id, q_type;
> +
> +	rx = 0; tx = 0;
> +
> +	cfgq = rte_zmalloc("cfgq", adapter->num_cfgq *
> +				sizeof(struct vcpf_cfg_queue),
> +				RTE_CACHE_LINE_SIZE);
> +

I suspect you can probably fix both sides of the multiply on a single line
here, and still be within 100 chars. That will mak ethe code slightly
easier to read.

> +	if (!cfgq) {
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for cfgq");
> +		return -ENOMEM;
> +	}
> +
> +	struct_size = idpf_struct_size(add_q, chunks.chunks, (add_q->chunks.num_chunks - 1));
> +	adapter->cfgq_in.cfgq_add = rte_zmalloc("config_queues", struct_size, 0);

Missing check for a failed zmalloc call.

> +	rte_memcpy(adapter->cfgq_in.cfgq_add, add_q, struct_size);
> +
> +	num_chunks = add_q->chunks.num_chunks;
> +	for (u16 i = 0; i < num_chunks; i++) {
> +		num_q = add_q->chunks.chunks[i].num_queues;
> +		q_chnk = &add_q->chunks.chunks[i];
> +		for (u16 j = 0; j < num_q; j++) {
> +			if (rx > adapter->num_cfgq || tx > adapter->num_cfgq)
> +				break;
> +			q_id = q_chnk->start_queue_id + j;
> +			q_type = q_chnk->type;
> +			if (q_type == VIRTCHNL2_QUEUE_TYPE_MBX_TX) {
> +				cfgq[0].qid = q_id;
> +				cfgq[0].qtail_reg_start = q_chnk->qtail_reg_start;
> +				cfgq[0].qtail_reg_spacing = q_chnk->qtail_reg_spacing;
> +				q_chnk->type = VIRTCHNL2_QUEUE_TYPE_CONFIG_TX;
> +				tx++;
> +			} else if (q_type == VIRTCHNL2_QUEUE_TYPE_MBX_RX) {
> +				cfgq[1].qid = q_id;
> +				cfgq[1].qtail_reg_start = q_chnk->qtail_reg_start;
> +				cfgq[1].qtail_reg_spacing = q_chnk->qtail_reg_spacing;
> +				q_chnk->type = VIRTCHNL2_QUEUE_TYPE_CONFIG_RX;
> +				rx++;
> +			}
> +		}
> +	}
> +
<snip>
