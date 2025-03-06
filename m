Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42553C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 10:24:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06A534060A;
	Thu,  6 Mar 2025 11:24:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5C9F04029E
 for <dev@dpdk.org>; Thu,  6 Mar 2025 11:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741256644; x=1772792644;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=6SE0jq2dpe/KZJ7XuPBUFxSLQk4qu9yv8kV/aQ7T+Q4=;
 b=CYbgDaUcNvMUl4UVT/OmonKA0u1yHDsnHEaO03n9c7umopAD0rKkM/IV
 3dJj4A2IoFXzi5bw1mNXOefhEMjLAM/5jMSP37uhJbEPb5HXOuA4vQzUi
 2uGQZWugJSLrkn0qRHpHlUbDGpWC2cvhqlW2BcwLOR73UYvxeHoPo2a9I
 fDkjeVkoERpt+0+8hKstoIqe4+5GWkY7scb+7Q3YMuu7tQAIOUC+GKl7i
 3ia3IaYx9qFSxMqjcOR75Mb8AzDGV5KMN61oM1WhoEd7qptcjGVK5fIPQ
 XZof9GjEE6/RFc989vse2Dh2wvwgeJHzaq9cqx8yX0FqPzdZrLYLZoTHk Q==;
X-CSE-ConnectionGUID: KmlHQSaVQJas2EqNV7098Q==
X-CSE-MsgGUID: 2IVRozfsTQCnmZQgQTi0ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42146866"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; d="scan'208";a="42146866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 02:24:03 -0800
X-CSE-ConnectionGUID: Tp+3QFqLQ8SjzIjniUTTPA==
X-CSE-MsgGUID: 5l+01AKBRt+af0UzRFgYlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; d="scan'208";a="123997837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 02:24:04 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 02:24:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 02:24:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 02:24:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHthZPywSsMncFLxPo0JPMJuabT7abB1gkGYrCfDvZlUqG1/cW+3CSJjJKV0YX0L0Ma/BoX8T3JclgTF6a1D14lQcqUOdy0dbsYk0xJllHMwo32pIg4MAI/ml5cNWDLRi4qETbBjefm+9o1ETyib/f45VBdxJNjaVazZJa/ZUpOcPbnEypFhTkaeF7ixAzEyI0GI3yzrADR3wZHOT1i3zspj7spiVaN+C0XRdtu7IXdPUSHJYv2+Ci3bdcv9Up+06C5PvqoQMlR1MogCyqQJ+bD3lzj+eV1CV3o5i9OuPMy5KJJ8rOBUqZqNmEHubOwqVIc8jVE32qRLkm3MSXyo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4X10Szktged0V8ckOyq6bmTbtAUKP3lWsvv4A9uXnw=;
 b=zQGCyr5a2lh3sUAbNPQXtTZ5/bCtaBD3ERB7Fzj6pG7X2r/QzPgGBqyLljcYdd9A6tsKzlgUpX/eE2eW2XACBhVQRmwYOCDYYxoQOwcZAkN5myjJ+OGuxbxlSwK/Vr0xSoJ9/8do/7ZUEVyShjl/qBln3cpk0BjYWEUFBnCk+KbzlQe14PyXbVGWSTS54hKP5XSJvtsa5lf4KX+v6S6xqC9UuHTmpOyxRphhUi6m8X697gIgd//Yh6tObCLdiWErUSsvoKgP0E2GCeaoltOkEfu9thcB1/7u5DKIXmcckFYeEmTK3Iz0kqjNzq8LtIfoRRo6iaPDNi2Gmk4nop75ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 10:23:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:23:14 +0000
Date: Thu, 6 Mar 2025 10:23:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <andremue@linux.microsoft.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, Jasvinder Singh
 <jasvinder.singh@intel.com>
Subject: Re: [RFC] eal: add new function versioning macros
Message-ID: <Z8l3jMSAeTGN7UrW@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305212349.2036410-1-david.marchand@redhat.com>
X-ClientProxiedBy: DU2PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a8d106-4e62-43e9-3b45-08dd5c98e714
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7J1HhGyjsoAAy6SdvTD2sR5Bm7E9QUDcIDyxUVf6dFBc9yz+fUL0eip0sTuR?=
 =?us-ascii?Q?0ovK0JoUQpHNHabxKi4vbD9diVbYT+2yeqvVuJNp1+Mygd1ZT9sOOtsVT1vK?=
 =?us-ascii?Q?j4O3N7/BwlEGU7zQCJQATWvJOR6qC3bVuyKCUAw8aY9w46oVql241D57z0bd?=
 =?us-ascii?Q?QWtmggCSnv/5eUjMb3M4O6hvmRWSZbIrH6W6oOiDFL9ehkhkyLHdrGH71ELQ?=
 =?us-ascii?Q?YNL/ayEe+Xw/f/OqbTAn5qxWe/RwU73MCOFdKwrtM1DYqePibcnK3XV+fVCc?=
 =?us-ascii?Q?N78+zffp6XJkxluc32rhp1Wd2auBI/p9R4yZu38Ihx2nuP19mGFO3VoagDUg?=
 =?us-ascii?Q?fho5gYsFWXRdK4JJVe0gH9CJbHg+vxmycCpwgfFcyEI8yze0KXmiRvxLyjCh?=
 =?us-ascii?Q?PCuTcaWjxQyNO7CtvWo/qaGjQhGTyNsANNf78aaVQmYBFcvUOXrgMFV7fA/W?=
 =?us-ascii?Q?/sCqTcnSmBfurSAQkstUDosTGDhLXaV1ZqtFZsNU0hK/AMwvi6/vQ2RtRu45?=
 =?us-ascii?Q?lW8ZWv1EKLquvLuWfLd15RdRhi8j57NLzsji/XdbKvke/zd4KG1mBztKT58G?=
 =?us-ascii?Q?PY5wIJ5WB6wz/v7KZk2qBcPmRky0De47UI2hzL2zHt0dwa4soNSOiOLatxgi?=
 =?us-ascii?Q?9qguSPdhkUQdl60ozQugOYHAdaTVBFF4/AnlG+1mVcV20/dnr+39zBQKOg7l?=
 =?us-ascii?Q?hEt7m1/xJYwUPgn6Cv92hw0KgVJgCFm0RFGkMflZyazRGRR+l9x+oBPPicfj?=
 =?us-ascii?Q?YCLyXI88CMoXWLMuYofIb5TIrSU3aDETIKatuhFqJSLlRyoOz4NrGAnpvViW?=
 =?us-ascii?Q?zdW9O8daE+yXoLJcSXrUinzfGHpJUN/P7qW/VRgbbJeV+/gQSeNCWVyY+Gu6?=
 =?us-ascii?Q?UEUq+RSpcO+Xhz3Ww2PTtL1S121HjXiXzHWnRPtWpE+58w3xafb2Rfa9TPdm?=
 =?us-ascii?Q?rIuyjXWcmdXfPM43K+lxW5TfIR5lrHwcJ29GNgAAVxonrt8gk0ucXQgTwzOT?=
 =?us-ascii?Q?uI/nlHi2RTV9+xDJXSlTyYgYAGYO0IGCh1NoooMSExganS/BeMiodyCwhTTO?=
 =?us-ascii?Q?aPmADPwGF1y6H34weyif1jilo+JrrwP4Co+/w2eAwmu674ScaYtIQ8/M5oDk?=
 =?us-ascii?Q?hbi1yHn0mKWjnoBoJPgiqgHqy+pK3zNI4kzpcXxJjdS6QtZl4PjL12wfvbpi?=
 =?us-ascii?Q?F+em7i594Yvcsz+IOT+9/IIExiBN9Le+F8BRcTFJVeRKU0GV41ug85oi+cHg?=
 =?us-ascii?Q?o/mUCmkQ5K1t6y9ZbNrM5hcqAmCdHiFAhtmvsDfUK/EvzpENSFleai96M77x?=
 =?us-ascii?Q?s3xfJrmsfiL+ZwAhy/TH9zo7tocFzJK2KyyURNEaoHy+4BilXG0Gd3Z3x4dB?=
 =?us-ascii?Q?b9A+V11eQHTz0LgB2XpdSSJBYYYj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aGNrmxVgKtaA2yH87ItfNOfE/pGYjL/5BbGSX/hmnC1nw6F5pdevvv6CpGG2?=
 =?us-ascii?Q?BmD3ZA+yjhWw1UOmX8W3/r1X47f5aFk3mDi3Fb+9cFf/x0Ic33MzpERxUpI8?=
 =?us-ascii?Q?moWmX1tXQpQoRLqQpz21lNAlRF5vzK8C6NirUnuJVnHH270XM+UdBl4x1p0/?=
 =?us-ascii?Q?CaHhmQ4oXGqizC2DLeZLTH1/sJQ6Mo9m65d2LAYd3jOZxWaDTmo1e4dIdQ8y?=
 =?us-ascii?Q?D7Zg/hdHUoOkYFp6KpzKIvieDqjyPzOFwZ7MMZWrC3pXUtnsuJfzP/M6/0R0?=
 =?us-ascii?Q?9P5K6+50x8Tfi5vaFD++Qq2g7YcgoAggZXzoLGzrX4cuy2ZFENgv9N2FGzdF?=
 =?us-ascii?Q?X08ggRFnDgdNv71wnI3Ku6BjUc3k0VwWYFe/MKgiLoRA6ViIFn550g6JRDRr?=
 =?us-ascii?Q?50A0R0wz7KCwEP/QKIMQ6wuX4XQKq5CMt/K6A2kjRlyexcPda2lV/1kWaRvy?=
 =?us-ascii?Q?ekYCg5Jhzh9wgBiBOJrJ0MKpdYEC2VlppOrqAi7oxXytQ1qlyUtX/QluIUb1?=
 =?us-ascii?Q?ARBn9QbxikeHHC2gzsCLgXuJVGEJKcIdCcC61ZF+Xf2aL4c4jjutO0MPkUHY?=
 =?us-ascii?Q?LwvL3kDrguLXE+yiJBzQdrS2hB5OKNpK8nle7sFyvgpkI00+t03MFjdBHq2x?=
 =?us-ascii?Q?8QCI38jFxv76si/kw64UPVO+214fTJx7YoCsNpl3ZaP+klAVzAchJx+t9JUb?=
 =?us-ascii?Q?29+7TViIcJCWgTIF0kUpV9OxE2vWC/Ng9HixTdt3dUUQmfr4zJVeH1XAv964?=
 =?us-ascii?Q?jW9EJ6OutC7KaJNHcvDVWaFOnNajyaAJc1Ndp7w/pfWUk+3GzCtEujppNARV?=
 =?us-ascii?Q?6VEzdoZ0qEcbDDJoEAmUEXaFZPalel+Si1ijLirSKLsBcYh9nJVStFdCS4RY?=
 =?us-ascii?Q?GotRxJD+hHgtaWqQYXDtT1E5cGZWFCMnZ6MuTa/Z1hV9LS1vXLg4+BIVlDso?=
 =?us-ascii?Q?deR44nQDCq11vT4Wmh1S4wYDkntcFzKKG3n9uep7/S7hVN5ekukmlcWXUg2M?=
 =?us-ascii?Q?epxtjWnXOkrgpzEAnICqxw43OVcNSMRTnW7PRosf8jJgrv0Yu71W4ZM9J96I?=
 =?us-ascii?Q?7hdfa5mw05FBmYIrX8AfaPAe8/SzOlFueNroYWdb+emzeaoCBsS7Th3OjRMl?=
 =?us-ascii?Q?atq4WPgpBQ8QWlu0pYBaWKk/lV0oM2E1PH9+MLlo9KHMFir+W9fW2M8jm5hZ?=
 =?us-ascii?Q?29szNhqiDWYDxML1xzJTm6TjHG+ovQQevCmH4gkif+JoYFRj/deI93z28Fd8?=
 =?us-ascii?Q?wGvtGtlfjoDIVWJuc+RaP33+Eq3kPp9P/Kc+PM73vrlJK38kvgMh6es6H7iG?=
 =?us-ascii?Q?1tsiwfNIQ7MKHE1bfhLdBcaNq/vCESYencZwlfAlBybIGl+8kuXWh76eoy4g?=
 =?us-ascii?Q?9wnCdhyUvxK/G+UyoGK1bBGkPVAJtp8b8q9EFBnz9ojkGM51j1wQRiw06jda?=
 =?us-ascii?Q?Zr8bCYwcsigYkJwMlty3rEpEt0GH0gj86FApbV2mTJAAuTaPn4ZFPCxeodp3?=
 =?us-ascii?Q?3cgUjebdEeuhCnJlvW3hm0n7ZoplTc5nHY4V62hl0glVrgx/yxRwAhnm0cbR?=
 =?us-ascii?Q?F77S/MfArFsdZOTZteqatxqJAQ+2+myuBozmevnfPWdpU7zIxKSdXfrqahrS?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a8d106-4e62-43e9-3b45-08dd5c98e714
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:23:13.9578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sKjJTcEQzpuIfDMYeUjO5onkoXvItayErno7djARRHoSCrttYPCJNDL6Hg8Tri1slVVKR0GNpQ2fftf4aotOmEdmZAf/gInxX8Ss0hNoVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
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

On Wed, Mar 05, 2025 at 10:23:49PM +0100, David Marchand wrote:
> For versioning symbols:
> - MSVC uses pragmas on the function symbol,
> - GNU linker uses special asm directives,
> 
> To accommodate both GNU linker and MSVC linker, introduce new macros for
> versioning functions that will surround the whole function.
> 
> This has the advantage of hiding all the ugly details in the macros.
> Now versioning a function is just a call to a single macro:
> - VERSION_FUNCTION (resp. VERSION_FUNCTION_EXPERIMENTAL), for keeping an
>   old implementation code under a versioned function,
> - DEFAULT_FUNCTION, for declaring the new default versioned function,
>   and handling the static link special case, instead of
>   BIND_DEFAULT_SYMBOL + MAP_STATIC_SYMBOL,
> 
> Documentation has been updated though it needs some polishing.
> The experimental macro has not been tested.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
This looks a nice improvement to me, thanks.
