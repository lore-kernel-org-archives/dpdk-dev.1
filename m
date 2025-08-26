Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6851CA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 12:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37B84402A3;
	Tue, 26 Aug 2025 14:05:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 556C84021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 14:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756209935; x=1787745935;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2qnm75dGKfgLq5MwsP4LsIPq01Q4NnVq8qcaHh+o3sE=;
 b=Q8AwC9x/Rjyj0XRdCGQnpyYbO6T6CnXYSZprxNO766Txm5Do6TWdwDKw
 hFFSQlNlP0398h5+EwcGTrIFwxxqPa6bXcQtI4j7WVuy0HC3J0DaraUvT
 WbYTN5MMAh0r1eAFSadIdtl3O2fv6hC8R0CpIWJrRz5NuRp2Z0F+uB+Zl
 un5HQ/ueQmw4rgFIgWSYLdGIEMs1riOhJ3lExyVwyS5CLLt/wPVXg1B3n
 /D91XGI7J+64ksS8Jh9uy6NAg9Ps8CB4/nAYSBQynVfv1UYQxHUINEK4i
 ZBUQkmJW47IQCf4U3EOPFPs/u9Ju8aZ6uzbyEy58xAU2Whud3Luk+ODs3 g==;
X-CSE-ConnectionGUID: P/ipe7cfQZe5LXUgPhjlEw==
X-CSE-MsgGUID: ADaxTQx8TFempDRwM1YFUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58382592"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58382592"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:05:34 -0700
X-CSE-ConnectionGUID: V/mHRaz3T1evZYHJETqYFw==
X-CSE-MsgGUID: q3TB3OdGQka4KLY33di4hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="168831831"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 05:05:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 05:05:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 05:05:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 05:05:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrhQw3po2n33oB2eZQFcHoL++4pffnsM5JxTMuaGqvO7Q+9c/6LGj5pSuvA6Jf4yWnI4ZNFueo2tJQOXtnukrResVrwmHjNtA9xQwHBbmlV8cJ5PUj8n5vjYS5ZGKJJcPwMmQbXfmaT+7dz4D32KGrTpuajPV5/hr3l8wUB562osFTOGdiS9WBl8MfxHw9yEfdceERN0MLX3OPTfw7Jb2RTivQNlbxQlfni8ESF0/dbg2AjJkrbiE1IZWXHPBOG/QmJ28d3uhaSP7qDW7ixz2+Bkix3rrd9vVyt6SwqAoqIBm5GbHUNwBigTHCzyWtGBN/umtuMWuGY964l35qmo4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oa2O9C+MuYNiVoYbNWHjzOg6K8icjAUCazQR4PhWtW0=;
 b=lS0eAuEevwzgsmZ/AFDpaHFJrkJtcrzi9VDK39RcIcLI52vl9HERBsorWcjE0GBh1f/MzrET7SDJ7uagXubI+ON6cQILVVyEGOgAJsUVh0DigMq/1Gw1IL9wxn22Rc1kxEBv36uvnRSo9N4Mr9GAPKYopyq6nUxRpkFFx/kilfUhDS93IcQ4VfJQ8Nx5pAozGIXmQImo6EVfUXr53rtS5MV/NhWta2l9HVJtZwaAJoQaB4ySsDXAZ7quLlVa86hTCrasA+xhjfXrX1K9tMdohBqy4ue6ijASD2YpS8ZkKGe30g88hLWEvwTXNQiv0ZZq80pf+UTWSbxjiVCGgt5mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 12:05:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 12:05:31 +0000
Date: Tue, 26 Aug 2025 13:05:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
CC: Ciara Loftus <ciara.loftus@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 3/4] net/ice: remove SSE vector path
Message-ID: <aK2jBtI5qY4tnKEO@bricha3-mobl1.ger.corp.intel.com>
References: <20250825123548.1177090-1-ciara.loftus@intel.com>
 <20250825123548.1177090-4-ciara.loftus@intel.com>
 <CA++2-x4mGrxvu7vxRgvQLbtGkS3bMBnLt+1NLpqa9P-GQobsAA@mail.gmail.com>
 <aK1oNgPbHGeJdgUp@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x5j0hH3XweLL+=O7-GJOnGSuN8zoFURs13mgFiVh1MD3Q@mail.gmail.com>
 <aK2Rajd8rypPr7lT@bricha3-mobl1.ger.corp.intel.com>
 <CA++2-x4kcTQwBRKKvhqwjqMBQ2OAmiGtuagqSQ+6Tw74PRGRbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++2-x4kcTQwBRKKvhqwjqMBQ2OAmiGtuagqSQ+6Tw74PRGRbg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0252.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: 185118e0-7922-4f56-f08f-08dde498da8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE52VERHbGpPVy9QRHJGQUZDWkt6Smt0NFBYN2RhNFJuV1diSUZDK0M3YkZj?=
 =?utf-8?B?R2dkL3VuM0J2T0c5UFQ4ZVoyclJXK0hPd1JIWGp1K09wY0xuek9LUFZncjQx?=
 =?utf-8?B?eWJzL2pKRG9icmpLTmxlWmFIbVppTDdubXcyVXd3TUFndkxZL05IUXhmc0E3?=
 =?utf-8?B?ajBCeEtsbmtrY09iMkxvZXgzZ0ZKWllxUkhHdXViOUcxY0Q4NStPdk5OQk40?=
 =?utf-8?B?ZDhIeHFQOXU2U2t1dTNTK1JBYXRITkMzczhQbTkvNi91WTAyRjJTS3dNNFNY?=
 =?utf-8?B?V2xRa1RybVZxbDl2aXFRaUwxMTRDWWtwdGdEaUNQYnViNElUWDBWRWI5WDFY?=
 =?utf-8?B?TklPbTlSbXE3SWppN3pzU2hlVitmVmthWHByUzQwS05MeU8xTWVwTHUzLzly?=
 =?utf-8?B?QW5HaGxET0xUTEFUVmlMWW5kbHE4L2FnSnFtdkN5dkhXYk9mS244Y2QzM0xu?=
 =?utf-8?B?Z2RGb0Ztb1RTdEpRNm96VzlMWG1iYyt0dmxnYmxwalRrMTRtOG9Lak9XMGJt?=
 =?utf-8?B?ZDREckdiTEwrWm8zT1A4TW9ya3dRL0p0TmJzRGpURVAzR3NTS0NaZEM5amFU?=
 =?utf-8?B?SDZyeHl3aEpvbTlkcnVjMmdZR2ZhdmNId0hnYXpod2tqR1RudlN3S3daV2h0?=
 =?utf-8?B?VWhsdlpUMHlhUFdtTUtONXpzL1l0c2RXcmROVU1IbnZ3c2JGRi9vQmVaK3BW?=
 =?utf-8?B?QUV0SWJncTdDa1lsOXB6SmxTYkNhQTNDT3JZWENwRStIcXBMU2lqbHI2V1pw?=
 =?utf-8?B?aFJTQ1dxdDZmREJuZmZTOU9jN0d6UmUwKzdvcmt6cVJpTGpZOHkyVFJYUzBN?=
 =?utf-8?B?ekhGWHd3MktyMkZjVS9mcnBEN2hNbmNkcEZjaE5UMXZQOFBsd2owQjRMaEZD?=
 =?utf-8?B?VFIwRGt1RUtBa3p5UUsydUs2TGVlQmFaL3NCeUhpdzJrcTd3YjR1YllWMGtM?=
 =?utf-8?B?YktaL3pEc0dMQlU1cFRLRW1WS1lWZGhxbm9wMzgzb0Zla2hoRW9PU3JLSEtV?=
 =?utf-8?B?Vm8wUnBWMFVJL25Mc0g2Mko4M1dJNEVaaDl2ckUybCtXNUJ1dXZRZWt3Qld6?=
 =?utf-8?B?TkxmS0t5NVZneGFpT01RVzZtYi9EN3N2ZjRwdXZRMThTRU5JOVdnZEFzbjJE?=
 =?utf-8?B?QStSNUhZaVpUNldTblZzejhiZXBJSUgwSStIUkdQTkEwTHpUV0h6T2gvVElW?=
 =?utf-8?B?TjFwUWlwd1FjeEJLdkJrOWZUUkZ2Z3R2eFFGekxIbGtmbDZ2VzZ4L0JZa2kz?=
 =?utf-8?B?cVpqc0x1S05qYXpUcGEvcFB6YXozdCtIWHppbkJRUHFHUExta1h6SXZWSnBP?=
 =?utf-8?B?RnVLMk5CaVNqZEZFQTBIMW5JWDJpNDdzZFV2Y1VQNkZORmFEU1VPQmdvUDFF?=
 =?utf-8?B?UGl0ZUwvZXdRQXFJRE4zS0hwNlpVTnRZclBDWllxbTZtS2t3Ylh2WVFReG12?=
 =?utf-8?B?UEVhaWtRd0xQK3lGMWxCb3hCdnZNOWliUkQ2VzkwcnlmY2dCeXExNGx0NTl5?=
 =?utf-8?B?a2hhN2t6aHJ0ckhzMzJwaXZSNHNlSWl1dUZFVzdzMXkwVUg1VnVjcXlMWUt1?=
 =?utf-8?B?U0Nxd1hZY29EK3oyOTgrQnRRLzNaOWZORXFqWTJScCtXZUxoVVNINklHQ25X?=
 =?utf-8?B?UWdxMHBidU1xVlVhZXc0WjZ5eE93NXA1RGZzaTZ2a09mdkNuRFhkRUt2aGxU?=
 =?utf-8?B?eFJJbnl0WmRpakhjOGh6WUNRVUxmTkN5MTB5cE9HN011bGl2NHhEN0ZmZ3NH?=
 =?utf-8?B?UklvV3RiMmJCZW0xS0hSOURnQmJ1ZkZza3dWaDdWSnFQTTRsNER3QjZoT1dJ?=
 =?utf-8?B?Yk5wRHRQZzI4Y1F6dVl5akd1WXEvUEYxanRUMkpUTDNzVjVvSVlvNEVaa293?=
 =?utf-8?B?VzU0YndDR2FLb2VVVlQ1ZjNxWWVzdWtwajVnS0pJOTQ2b0FWa1NqVDVMTHM4?=
 =?utf-8?Q?+Q2rDzcsc4Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJpN0l6alNVZkJTNEpBdHJXMzVFZ3crbzRxWjBjdndOZE5vSkw5VHR3TkJo?=
 =?utf-8?B?NlRINUVScmxlQXVHbmRNU05GTm92NThjSDh2K3ZUUmRPeE93RDhXVVdRRmxB?=
 =?utf-8?B?NEwxM211OGs1NW4yQTIzYWl1clZ3YjFBZDU5WktaVytmY0hRNDVpRlNWMk1H?=
 =?utf-8?B?b0wyZ3dSQ3Z5aWJqbjdMK01ibURMNG10aTFuRUtnRDFTN2JrN3hFMkdOS2lW?=
 =?utf-8?B?RmJlekwxUVdrZHVWcCtLd2IyMkZOM3dSSVZTVmZReE1UODlCd2FQczdzZis1?=
 =?utf-8?B?SDNHV09kTEl1V0R3bnM2U1MwMXJ1bEdGMlJCeGt4WmZEbS9JZHVYZTRpSDdX?=
 =?utf-8?B?OXNjVkRndTRCY1FlZFkvOVhSUWZqTURtV2d0YUNjV3FUQUNXRTREZ1FDSld3?=
 =?utf-8?B?amlZdzlsbEhnQjBnZXh3WTRNMWNnUEp4d2dEY0lVZUtWeWtFTThrUGZwNGVm?=
 =?utf-8?B?bWJrOFgzNm9nSjh3bytVTGpReTdpZmxjdmpRZnJVbmdEZkR0TDJLWWR1TmE0?=
 =?utf-8?B?bnM1NUFUc3ZQeGk5WkNyUCtNQ1F5RkpYRVl2Ylp1T1FnSEtOQjM1KzdMNGYr?=
 =?utf-8?B?QVV5TVNzQ2FvQUZyWUZpMUtreEduT1dLS0syU2ZIODZVTER1TGJQbUFqREhr?=
 =?utf-8?B?b0ZFWnc3QUZoWWhtTTRWVTRIYk1tQ3dpaDNpL0I5OFhEcnlXT3I4SnRKeG9P?=
 =?utf-8?B?OGdkUk1mM3hCajVYYnd0RzViZ1BKb0U5Y2QzcWVyeVRHUFZGa1VMb0hUL3VQ?=
 =?utf-8?B?U0lsYzBleTdHYWIwTDBGbnJQSVRPclZrWklYbUxTaENqMXlCZWhZblVBUEIw?=
 =?utf-8?B?TzAwOXc3TzNsOWZHMGQ4dG5TdzFqV2U4WVJyblNPZUxiaWdvVzVyTkpHdEtr?=
 =?utf-8?B?T09FelkxWWI1Q0F0S0Q4RnJUZkkrZkorbTVvQjRUN0R1SStMcUhxL2NYbFJx?=
 =?utf-8?B?UjllVmtmbGs1NkM3aGU2RUUxaE1pV20yd05OM016MVU0dUVuK3lyZ1JyZnlS?=
 =?utf-8?B?RGpMbW9BUE5IMEN2N2MxTDNPZ3ZqTmg4RjI4bkV1L21ERVJObm5ZWVliT21H?=
 =?utf-8?B?eHI5NFhFKy95cERNeUljM0xwZm5VbXA2NVhURklMSWE0MTU3TFVpeWdKZUhF?=
 =?utf-8?B?U2IvMTNuLzA1SkV0M2VNenpMNktCN25FdkJacHEyN0RTRFJxc0wvbFdFaklV?=
 =?utf-8?B?am5OUFdBclZtalVPTlhrVTh5SU44SXBuQ0VNc3RwVnRFcXJNWTRYRmZ1QVFi?=
 =?utf-8?B?aVloNHRlN2RpcXFpYU0vRnJIaG01MjZwYnlNY0J1ZVMwVktyZEtLNFo1Z0Ux?=
 =?utf-8?B?L2R0aGR6S0VJbnhRMEkvR25idC9kelNENCtHSEZ6VFdyK2psTFNUdWlPLzky?=
 =?utf-8?B?VXZGNVc2a2tDMDAxbnBkc1dYdTZhZzVXdE1uQUJUNjZoeWtWZGtuaUN6OHJE?=
 =?utf-8?B?eU1CY01EUWQ5dDZzUkJlSnU3VFYyajNUYkIwQzRGRmpFNW1rVWduWmx5R3VF?=
 =?utf-8?B?ZzNGeXlNcDlnalc0TzZmbEt2bEJNdGMxajN1K0dEcVpnS3hOSVJuQlBFdGMz?=
 =?utf-8?B?ZWVGYTFKOC9PZ2V6QzI0M1FzM2hqcXlaekk2NmJBUE85SzgzVWt3SmJxb2Vl?=
 =?utf-8?B?R05uZDdCQy8xNVE5cHQvMnFUa1lEbDZXUkYvRHVXa0lhaTR4TkJQeEpPNi9P?=
 =?utf-8?B?NlBETEM0NVAvaU4xaDZyQTh2R05nOTFSOXp0UTlvaGZSZ24rTE93MDZWWUl3?=
 =?utf-8?B?cDFvN3RBWk5iMTZlRElwcTBiUmltcmJKdDJJYXpES0Z1YzR1QzNHaWJqdWtx?=
 =?utf-8?B?ciswWndCWmNSWkVZQlJYRTBPT2k3YW5haEZNL3VqRWRrMTM0LzBRUG56WEg1?=
 =?utf-8?B?TFprZHdGMU5iazV0L1dwaFdYV3NVR2FhZUNvMGZaNjVPUmZ4SlVDcVFtTFE5?=
 =?utf-8?B?ejViWDZUckxuL0lNRFZpZ3hhNWlEZkVRMFI3Z3hYMTJ5Rm9jV2xRdTZ0Tkx1?=
 =?utf-8?B?UHhWWTl6RS92aEl4YkdCWVIxODhaUThyRTJ3YWp5Q1g3Rzl2enRWTElwUkFH?=
 =?utf-8?B?cnZyNTJ6WXVkc2doZ3lqU2JIMVVwNHhScDhxczZBRzhjeXdaZmlrQytnc0RR?=
 =?utf-8?B?UWRVWFBuc1l2YU1wK053ZGlselEwWE9iMjBROTJCUTRSRHd2aGUvUWNyODRP?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 185118e0-7922-4f56-f08f-08dde498da8d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 12:05:31.0970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoRNcMCS9YgX4SOGF4e9FQPmunPQOtqf0uZFPu6zr3sdkc6yYKRUecBCaaXufa7m+JvQnljYqYa/TRG3ysLcj/tBkv+iC3K7tjmbwJXKQsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5013
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

On Tue, Aug 26, 2025 at 04:54:53PM +0500, Khadem Ullah wrote:
>    On Tue, Aug 26, 2025 at 3:50 PM Bruce Richardson
>    <[1]bruce.richardson@intel.com> wrote:
> 
>    > No problem.
>    > BTW: Please don't top-post in replying - it's best practice to put
>    > the reply below the text you are replying to. Thanks.
>    Ohh, I got it :)
>    I was triming the quotes when replying but in top-post format,
> 
>      will always try to avoid top-post in replying in future!
> 
> 
>    > AVX2 was first available in systems starting in 2013, (and AMD
>    systems
>    > since 2015), so at this point it's been around a long time. The SSE
>    code
>    > paths in the drivers will only be used by systems which do not have
>    AVX2 on
>    > them - which should be relatively rare, I hope, at this point. There
>    are no
>    > features in the SSE driver that are not available in the AVX2 one,
>    so, I'm
>    > not aware of any reason why one would need to use the SSE code path
>    in a
>    > deployment of DPDK.
>    Yes, I think all feaures in SSE do already exists in AVX2 paths.
>    > Even without this patch, there will be no features added to the SSE
>    code
>    > paths in the drivers. Any new additions would just be to the AVX2 and
>    > AVX-512 code paths. Even for systems without AVX2, if the SSE path is
>    > removed the driver will fall-back to the scalar paths, which have far
>    more
>    > features available in them than the SSE codepaths, which were
>    simplified for
>    > performance reasons.
>    Thanks for the update. I could not exaclty got the meaning of fall-back
>    to the scalar path.
>    Does that means that the driver automatically switches to the scalar
>    path ?
>    which is slower but includes all the necessary features that were
>    simplified in the AVX2 path.
>    I believe AVX2 provides an average performance much better for small
>    frame or packet size (about 14 Gbps).

Yes, AXV2 and AVX-512 code paths have far higher performance than the
scalar paths. However, that performance comes at the cost of not supporting
all features. What the drivers then do at initialization time, is they
check the offloads requested by the app, and then select the highest
performance code path that can support those requested offloads.
The whole process should be transparent to the user - they just get the
best performance possible for their running conditions...

/Bruce
