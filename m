Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188C4C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 15:35:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D4EE4060A;
	Fri,  2 May 2025 17:35:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 710B8402F0
 for <dev@dpdk.org>; Fri,  2 May 2025 17:35:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746200132; x=1777736132;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m8L72/s7OgyC1hGsZ6x92zG6GPae8xOY+cqLE+VExK8=;
 b=To174cdj8KqXBtByLGlmmUfzZ6BOK1vmuDCrD3hE/5DSvQb4Yh4lmQ0n
 dk5LQHLBtvQ9amJavJBk1s5OTAbeMvpl8+/ck/xdMPXfwkHg0oWOwE4S5
 UN5RNe3gwxs6vBGIEy42FJ4dKpeOMCbcGzd7gWRDTPnJWWVhykxyPua4s
 G8Dz0qq5aLpwuJQfKr5EMzw8ryYBTAzFpRS5PjRh+RLQhSuC5kgVC6hRJ
 uvuna9R9n/3mG23SpfNDLLVIWN8/mTMZvhj0Wp32k5vKdTpjwEZKHfOzz
 oWgoFzqo6HvslyILdpcUUJVAyWcpLah4fQUBC+Zm9X9WQYFQpUlg8HAWY g==;
X-CSE-ConnectionGUID: WC9tD8RaQ5u4XQy85WzEeQ==
X-CSE-MsgGUID: MHXAX4pdQb+w91XeHQK1Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="70390731"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="70390731"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:35:31 -0700
X-CSE-ConnectionGUID: 7Paur99VTbGKybUUI9FqUQ==
X-CSE-MsgGUID: BsDTIYL9Q7ys5qlQmxi0LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="139453140"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 08:35:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 2 May 2025 08:35:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 2 May 2025 08:35:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 2 May 2025 08:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOWGgIBKNX4Nx8ol/yWCfBpT9rFCPYIDynwGJWtXABVeXjjhZnOgW5U+Z2eQIQGeto2j4Ue/d4+vV15t3szaS5xS5VhBuJPPQrJECM2SjUo++iWvLWgy+Gb9y+YqI1dtVdg5p41Xup7oTZP2IA+XLkqHz1Mq4TpHSY6XmZeYt3DRpyPZgjwqdUrhojEhT4woBk4YyyB3yRD3+iDPzZckmOUpF4iPWsFyAhnhVY9rLlh3k6ZNyfdAKjpwJXLKs3gYqtBe3peqxxLOFbsTmjofIynLdwcu5XQ5fx3pViwNVB06BA1XQfEtsDXAA7suPKW+ghjAlA2Jm1a3XHiM1tRZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI8Yk/WKQcK7duhfqDlopxPD27G9+Jo5A4QZ1XH/ON4=;
 b=upyoC50bV8E9aX7IDueP+oiaVke8hd1oDOBPTBtZeI23odkUKagYtAeeuoijUJeHVS10picr3ZfyFlxENs8imBjK6d4M7ojv/w7hze7HmfugNPH+cs+rqe+XyF1ZNMKWR3PPz8q2H8tLJCEOWycnNfTrATajo+hs+EU5vh34Q0usTNEhNhFFwEmhV1dsGcKBYtwoEPTkoGTqTECX0uYYlcgBtpTV7/ixEAVLoNBxHCUW5c+BCN0HCbMiDiHqEgvBNRwachM/S0Rebwadhy5s5LFZzvziWsYRwDx2lnVa880OjQIc/SYVzWnGoAsaSn62XtOksqeaZ6wU3eIuipH/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6670.namprd11.prod.outlook.com (2603:10b6:a03:44a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 2 May
 2025 15:34:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 15:34:56 +0000
Date: Fri, 2 May 2025 16:34:51 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Ian Stokes
 <ian.stokes@intel.com>, John McNamara <john.mcnamara@intel.com>
Subject: Re: [PATCH 0/3] improve documentation iavf driver
Message-ID: <aBTmG3faL-2jfze8@bricha3-mobl1.ger.corp.intel.com>
References: <20250224152611.1012935-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224152611.1012935-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU7PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ebc356-f482-4702-1f11-08dd898ee425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dI8ZCbtj5J3YDkJhXXZzmTYyctZcnQsi/jheeS33qvqQz6RSOTmmM0eMGNPM?=
 =?us-ascii?Q?P8QDBUyMKUV0OBEtf/VVNYRle8RldT8011GSR200S5SujH4gVPWxpbzhF5Km?=
 =?us-ascii?Q?ixOI09IFoMW266nREVsYhqQ3++mZ/DB5ebo3gVf9pLIoDPiNxMHkoPKXNzuf?=
 =?us-ascii?Q?3b4RhA7RU46O63i8fs4St7gKUUZtH+UdiWaRGD+UD5YjogaubPH/4wBRo2+c?=
 =?us-ascii?Q?0RsdnNYArLNw3csUUtfbipG/QkWW7RESmlciwtfhdIWRr2lvzBIveyDinyFd?=
 =?us-ascii?Q?pzW3RndhIB0HKpGfVjGR0Hxanh03WGDANKnlpXjSMisdfc5M2FY8xfgfuOvb?=
 =?us-ascii?Q?CtkUIBwTBLTOYbq2cCoHkk7lVvlaKHgQkaP1Cz6FvkHIpWuWAm871wYM4Ok1?=
 =?us-ascii?Q?5oJ9LwRyN6wQHB4zwT981sUGPM9rDS66TJu8/O75Ie8gxebMS+7xoSgQvIel?=
 =?us-ascii?Q?iy0Oae6jL9qyShEMP1/aPlGiY4ezpd3YOKfhtkQWIdFET/dScLRl6WgNdDAC?=
 =?us-ascii?Q?c9QE6IjPVSNtdGAr1eaMxYTX/PeL8KsnNKKlag1+Rfb0adNl6W60QJV73cHe?=
 =?us-ascii?Q?huqq0zZLTcT4my3f7owMOui6UYv/YAOfD2TWQm6mADp/qP3mL3JdOz4IgxTJ?=
 =?us-ascii?Q?/QG9i7rwXZAu3HtOukhgvK+WaQz3wEQZwkk8GUfKkNY3Ymf2sZJl1CvAo7fl?=
 =?us-ascii?Q?UyzSGtXw8onfmP29Lk71Rs0TM3uA88v139OXD5pRt3TUk9uwGyyTEBKf+Cwu?=
 =?us-ascii?Q?cDHhdRnQSDWO5AvRsxnc3gmgVSBtSPEPt3FHtGquOu6K9cafDD5XDSDfu2OR?=
 =?us-ascii?Q?mGpUBQTkKTtgmOMU785+V/3Wcd63GWLG0hdsFkdbjXWFdE8OE/8rBM22Lvn7?=
 =?us-ascii?Q?To6VLKDwjHZAmGKESp3UiIZ1P7zKOXc02LUnVCwEfOstywo3CcZaW6KdcdJg?=
 =?us-ascii?Q?t22od8DJSdNxkwYv4vH4Yt5BLrBTYyb6gb73akw7sZ7g0NIagBeXxD+J40Vg?=
 =?us-ascii?Q?ZjiIRNkb/x4ixs7SIsiqXU0WGUkgCUqYiy4UmiHfkepz2XXLH9oRCInEUv2U?=
 =?us-ascii?Q?ouA+MyPKVAEjKoYbcf/xWbPtRTy2/aql/0H6L2MrYslA+ot8ORuR03vyiyFO?=
 =?us-ascii?Q?DMFk6TrRDdQRqgoT17hNDOXlSmW4GiW8HlJ+prX0Uq5nCU3y6n4A6liIyFCW?=
 =?us-ascii?Q?b1DNJQYSfWus7d4bWB/5vVHCGPp76SeXbagOX1jxyqI29cCpO/DRebJs+73j?=
 =?us-ascii?Q?/9nNrihO7AB/uZmRJjGBKMQy8y5hosSm4i6ceuFaWXLnEaiPDIWLGYc4KAh1?=
 =?us-ascii?Q?1hmslW+b4JSPQf6hNE3oyqjyROVN4XyBaIajPblH5gYOX8JLM8yC3nYqNbo1?=
 =?us-ascii?Q?Eqxa//hhBr8NanKiFmJdTIxeKD5kanq1K8dg5tAQtssfpD1j0+ccXFCqBggq?=
 =?us-ascii?Q?6mYEUSkhkZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?77E1Z5w2L1xke0/e1N3HEcq7fl1BmEV8/dSF1AFarHRY2QakKlX37dpq8KUi?=
 =?us-ascii?Q?IiVjiPlokMkOgfgW9dEqAktGdSZPtUmd3aFttjIGMnuGuszoYtYhpr7pjuow?=
 =?us-ascii?Q?58pglrMZK6OJp4mto/PFOVNtV/xuKrbi+ZEsA3AtYN602CivPT7N1d5OkdC1?=
 =?us-ascii?Q?rbEyybRta+ppnGVpG5A0rikrWgfSyxyB9OYWhjWi8xbgOERIhs0fnwNYL4bd?=
 =?us-ascii?Q?Cvs2HRR705pd/47A1kSGPVtX4Kh0WYWd9u9R1dD59xUEYN2824m+6K4ExWAn?=
 =?us-ascii?Q?Tq+pOq6oIK6K9TFXGSTqcCsgUZJqU5NAcR65uGVrK4xEbXjV3QNuC9xzOKgn?=
 =?us-ascii?Q?mkM1iwGTXNBluBN5IB8MvCw6n125PjqCxkk2LJqXLCgLJoqneA2mYNrbgTQp?=
 =?us-ascii?Q?uohmYKVRh693l/X+zlGOnfEFWfkSURzsjjXkLZn8Ayr0ZZJplaXost+PwjEK?=
 =?us-ascii?Q?0uvPUY0s5FU+5RV9+hBiGQoXWopMlagBwJch0/Fvm8IMDb2Rignw9aJhmwb6?=
 =?us-ascii?Q?4T4Ue1EK3pqH7d0JschXmdf9wCq+eT9iJT9DPdex4xzHBvJcLRjbi/DoP4tr?=
 =?us-ascii?Q?6DGnDE2Gnw3DHWJ36eFLlYAKiYnLfpR+bwH44Tp9vBooroXjru0JSLn2x6zG?=
 =?us-ascii?Q?l+KPHkkj74pimtGbG0gKg+BW4FruGEgpZpXUN20Gg7tAG6ARwQX+aRnQjZsk?=
 =?us-ascii?Q?+tMwuN3GQH2OFlyiJydjAZdVGJO1ePQN7ZtAildqXtBVjCwFY4Rk3cr9w5xx?=
 =?us-ascii?Q?caI/97hwA5Vf9Z7u9ZkAYcDMSM0xlIUH6mvX19xlAvIni6Ewn+SypMrCdZ05?=
 =?us-ascii?Q?iSCHUuBo5eDTC4x+ZU+PPLwqICechO1F087hHcyDtXqcddfNyNlM8qKTsRry?=
 =?us-ascii?Q?pAat0W+Ca4Lmlzy5JZbBJda94nXNMdsJrKYRV10GosNcOIUQRoOSa5wGT3L/?=
 =?us-ascii?Q?FUd32qhubls5yV4j45jqgKliUzYJY5sqcnvjpfQu8NY26QW3G6jSEPg4nK7+?=
 =?us-ascii?Q?Ky4SDQtZsUh4YecbLg7PwdzFGCcGxxZUWhzfoIECSWLuN4NJP6ytr0+bfYVF?=
 =?us-ascii?Q?Zkc6TKV9+UNWsFAr8/dGUFChz68Vs5Fy8p4GcP+27++WVYdJqaGKED4kcmBd?=
 =?us-ascii?Q?gXGxSX18DAjjMpdy9DBisb/MyBQ+xFW9B+7del45Afva33getmmHHgSN65Bh?=
 =?us-ascii?Q?wU1+GiwYZ7krWz188dK3ngr484YxSIWtMKHFJyktntQmBPARFpjYf+Xz13IF?=
 =?us-ascii?Q?39JwhmtVNgR8U7uIk7/8XsKV8R43JuMB6pHIWPHfflMVuyZw3M1qowSetR42?=
 =?us-ascii?Q?mqCqngXigYZUEhBVxFzjksxxm6IWTLgM2obVKD6giiskAD7Sdlg1Hi1ENgY6?=
 =?us-ascii?Q?IZTV9p455SeJ9qWg/fLZ6FpeoUmK88PjRhk8WL4FXW6dIGNvL08olNadQI0A?=
 =?us-ascii?Q?8XKLNwrSs9ZubXWHR/QJdjr45gFnRt39SVrKx1/gujtxD+z79UZ2XCvR2uC/?=
 =?us-ascii?Q?MFR0kn293pkpTDsb43HHPyv8AY52K/pefHJDt3ZPvpqxUzzJsS+/RD2qjatS?=
 =?us-ascii?Q?CZO/1kIKmmjG4eoeSU9i8so988lkv6FI+eRnzDALpc+W9/1X7ZqCjKIyUpcN?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ebc356-f482-4702-1f11-08dd898ee425
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:34:56.3964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl4edERr6XEFJ2Fg9y+L2TjEdtI5XDean2nKh8B+naQSdrdp2U8D8EI3ac8Dgq2caaGa9Ht6LRzLTPOjg2SXXpLZsIUxzGndO+Z3EB5+BEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6670
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

On Mon, Feb 24, 2025 at 03:26:04PM +0000, Bruce Richardson wrote:
> Some small cleanups and reformatting of the iavf driver documentation
> to make it easier to read. Also add an additional note on large VF
> support.
> 
> Bruce Richardson (3):
>   doc/nics: improve structure of Intel VF section
>   doc/nics: rework notes for iavf use
>   doc/nics: document how to create large VFs for iavf
> 
>  doc/guides/nics/intel_vf.rst | 83 +++++++++++++++++++++++-------------
>  1 file changed, 53 insertions(+), 30 deletions(-)
> 
Series applied to dpdk-next-net-intel.

/Bruce
