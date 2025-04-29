Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C80C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 16:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 778C9402A3;
	Tue, 29 Apr 2025 18:18:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2D5E640277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 18:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745943524; x=1777479524;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=W5BSCZHYGMoYimujkBw47pZF/RwQuYl1NuoD96eL12Q=;
 b=Ga2PhSEmPbAkgPZh8W3m72an17G+jP5sIMrIwChqsYDnU1Qa5iYsFUK6
 8IxPE223YEYqZdCasRB8FKvXYyd1ghZCW77PiLtBuXO8BlobfcF4I2x4W
 LAP4Mlw00ocNA/9Hr7jKi4r29LAflRHOmqT72C8po8oPhAFoS/KnMrk2C
 ydOSqtO/Ig+5BOxIzGOUknJ7WxOGqMlwsnNjG1iVMyhwR8Lvl3GqjallX
 2uFRkM4b0KupHMtCvpEdFj1a1KiRywvE8OLFLa6KQm9uhdQYQ/9wdOBQU
 Ov9Pvdh0m529mnVJG4zpmIwXIb0qTpRKT6uPtlrg2SteC5Vp/rV/DU7I+ A==;
X-CSE-ConnectionGUID: UNBYHB+RQVm8nL4CLzi4sg==
X-CSE-MsgGUID: xmS9LWJMTGO26e4fHTH6aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51396533"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="51396533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 09:18:43 -0700
X-CSE-ConnectionGUID: t/SJHNdqTdy1CVl9lBEBHA==
X-CSE-MsgGUID: iNXjr6apScKBEoxWEa9WXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; d="scan'208";a="134371831"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2025 09:18:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 29 Apr 2025 09:18:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 29 Apr 2025 09:18:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 29 Apr 2025 09:18:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th5oWhNXDp9+54l936uFDO1WJAUtt2d6b0r+uc/4+gFKGtxjKhQjQs5YGOHJ6y/e55RdNY7PzIxLLBznrN+1+D56Z4ksiGN0TQ5Cr13s3EAdu7563RL/cyTuLLCef7cPNKpsVF9VrN1w+EIIqTesQwerxtDoGvcecwHTwVWJI43H8Waql+HKrP15MOPRgkejEn5jb7bSNKdsg8VhGR8Rb4Di57S2v5dwTwt5nxjlMVGlrnkC5djPvlCr5cBQN2ugoYp+KlWz1skYqeJ5dNhmNKUYHtqkFC4slUJskNk102T2N5WjS4AFdq52+WxJOB1Blc8MCI4LJElT3JaYNXMRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zhu03K3b79OnX1aPuMDEX6jFxUUAfscIzCHACCzWL68=;
 b=jZytR8XcJtwjoILpIicYUKJetwqhAOvzIzCL1v3Y3fRe2H4Ses8MChQZroYa0ISW3nf8icpZK+rDph9qqM4gWVGaKCjQ28+YjTyj8CsVsfDGEqktP7/xBLnpSSeo1Va0os1VC7lzY7aYKGVgwN6FrOTCSWTKjBO4JVI+trhWSg/CPaenW5X/lCMNk7SbjPYAFWlcZDtnZrAHhdYWA/3Sr3oRu8d1fWn7ZlvzfaHBenbvRLwffmHrk5DYm7Wwa4a65cLSVg6jjQ1JrxLedfFIlR4hKYu/y1z4A2Vy7bTmQTS7xWyub4wFe84TPsHgdbhaYHOMbwwdol+xCAn3rB5Lxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF4E874A00C.namprd11.prod.outlook.com (2603:10b6:518:1::d1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 16:18:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 16:18:39 +0000
Date: Tue, 29 Apr 2025 17:18:34 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: spyroot <spyroot@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: 810 VFIO , SRIOV, multi-process stats read DPDK testpmd.
Message-ID: <aBD72tgdGpYA-yqD@bricha3-mobl1.ger.corp.intel.com>
References: <CABsV3rARRuh8Qhm4q+QCDAEmA8WP+6QK241ik4qoLyGJBPFdHg@mail.gmail.com>
 <aBDSliZlrdd1hOst@bricha3-mobl1.ger.corp.intel.com>
 <CABsV3rCS61VvS08yh_g5wXDErV=utD=tYut8P=C1=-BCm0KTLQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABsV3rCS61VvS08yh_g5wXDErV=utD=tYut8P=C1=-BCm0KTLQ@mail.gmail.com>
X-ClientProxiedBy: DBBPR09CA0038.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF4E874A00C:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b382950-165e-4f3b-1025-08dd8739803d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGVMVWtFc1A5OEVYKzlSSVlHWERrZVllMGsrYkprcWtKZ2NUNWR2aGUvWmk0?=
 =?utf-8?B?QTJ5Rzh0NHRMbTc4eHpGT25xbDBqcUJhemgxdHpTMlBacGo1a3pzQ0ZnMkxO?=
 =?utf-8?B?Z3ZNNFRIVjdwbEVWcU5RVGlnR0ZJODlEdWZmRjlEVmdCKzlsZ2wzczRkN3BM?=
 =?utf-8?B?bEVCRHNxNFZzc3VKeVZNRHJ4V2V4RE1SNEo1cmcvTVBNdjBrdXB3aFI0Vm9i?=
 =?utf-8?B?RjRmVXM4OEtkOU1iSXp0cUZoa3BITzBkZG5UNzhaZkRQcmNLRlhmRWdNQzVI?=
 =?utf-8?B?VEplVTNSa3J4bnJURVVwUk5TZ2dhSEM1eDc4TEpCVGh4MXRmb2ZiYVhzTHpQ?=
 =?utf-8?B?Y3RjMnZ1VzRDSkxsS2JGU29LTXFHbEVrenJHdVJ2dVJyWHREN2NnNUlqazRu?=
 =?utf-8?B?c0dCdW9nMEM4WHFXV3drSVB6UnZ0WkpaSFNGUndsb2I5eGx3NVluOFZ3Z3Fz?=
 =?utf-8?B?dWpKeUErMGN1TFRJbEtVZi91a3FDUXY3SXhuT0tnMDJuNEpSc1U3NWZha0xw?=
 =?utf-8?B?cXJhTU0yWCtvSFRqT3VqMit3OFJPVTR5Vy94bFNXS3BYZVBCYnZuT3VYSmM5?=
 =?utf-8?B?Y0VyRVBUdnM5NC9vUkF2OEZ6Zjdieko3aENLeEVIdFdBM0Jkek1Rc2R2VFBu?=
 =?utf-8?B?UG9jdnVZT1BTT0RTc01NTnBtQjZXM2tNM3Z2d2E0Y2p4QzBBSlRlWWRNZHM5?=
 =?utf-8?B?dXlhMVd6WE5lbytiVGNmWWh2UVUwWnp0akwvUTQxK3NSUldDTWQyVUduM0FM?=
 =?utf-8?B?UWhJVEtSYUVwN3RJVWxxbFpMdGNOK0szOXZNQjFYUTlBZk11eFVmYkVOUmxK?=
 =?utf-8?B?YnNLWlZEZGxWbUNqeVpwZUxUSkpuY0gvbm93SE9WOGtYVzdiMW9od2xxM2hj?=
 =?utf-8?B?WEZ5K2tGWDlsRVhIZkpaVkI3QUgrbzdKRHRCbXpoTmdTNndRUjh3aElWTmRY?=
 =?utf-8?B?WkI2WG83cXFGOVRLaDNzYWlONXppeStyTGJoaENZR0dpNjRyUEQrSEZEbUtu?=
 =?utf-8?B?c2w1azE5UndrWkZuSnRmZzhDODc4Y3RwbkQyaUFsUGFHR041UGtCOW9pMzVO?=
 =?utf-8?B?RU1Tc2ZVNG83cHQxUHNTam1XVjRwSHZob0xhUEZDUjgyRFJuOWp3M0N2SUJ4?=
 =?utf-8?B?WjZqTmVnUkhTamEzdnRlRkx6SzRsclJQM0o5ZlVXOFJlcHdGT2x4NjVTT09i?=
 =?utf-8?B?TWsxaDBqN0xBWE9qVXZ4aXhXdjl0dTNQU044dmhsczNWSE5vRVRmcFMrVkZz?=
 =?utf-8?B?Y05TNnQwS1EyMmFkTEtQdVZDOWFDeGJQTVowLzQ5K0FmallWajNURGJsZWta?=
 =?utf-8?B?T1lMWHJGcVFFMGZkSlRzbjVlN0dIUXRHWDRVNHpRQTRjRTdxd3UrbFJINEI5?=
 =?utf-8?B?V3hwazJtSG5GRXZyTnB6SllDZDh2WWxlVU9rVTMyL2R2SGkzRktNd3E3Nktj?=
 =?utf-8?B?U2xlVkdJNVVjVnl2SC9RZklUeFdQMzRyeW4zRENWQXIxc09uQ2hQbTdaQ2tS?=
 =?utf-8?B?RG9JQktvQmRTN1J6azI4ZkI5MU1OcmtHTDYzMnBFNWZMV1J3TkJoRHIvc2FD?=
 =?utf-8?B?YjVGZWxxd2U0R29VOFNnSFpYcGp6Y3hGdlVxNk83a0ljdVVxUzU4Z3lzeHlU?=
 =?utf-8?B?UTJuaWhlQ3ZkaFFoZXVGbStuRzBwdkZIMmhCbTBPWDRVRnVDK1pWeGRlYW5L?=
 =?utf-8?B?K2w0ZGVVaDdPVHkzUnhndjZLZVBucW1tSjA5MVo5eUdaNkcvOFVpOHNMZFps?=
 =?utf-8?B?dWJWeitITWZXQnN6L285L04zOUxQb2VGRjgzMk1VRmRVTVpVVithdWhmbnRE?=
 =?utf-8?B?ditFVll6b1pqd2h2YmZBdFVsaE5ZQ1NIZGdqZ3plVVlQR0k5Y2oxSGl0VnZY?=
 =?utf-8?B?aVAzMFBYSW1wSE1vWDcyeHVRdGhDdlRIcDFDMzRWRmRPdG5VSVd3ZDY4YXlr?=
 =?utf-8?Q?AHVWYlhKH2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNqMzZWaEJXc3h2TWpLL0p0aUIwZEJBZXh5VVM1N3B4Ymg4SHlaM3VuRmpr?=
 =?utf-8?B?VGp0d0NTNm80WFJrbVRjNmJaU3MvUnl0aU1aOWZKbTVkSHRra0Q0Y1pOL2RK?=
 =?utf-8?B?QVVYZUx0eE9oSTFHS2EwNmMvY0VZRkd1RDdMejR5aTgvYk1Qa1ltOWlsWk5x?=
 =?utf-8?B?akxzWkVnVUpwa2xwcUk5R3BlOEdJVUc3ekpHUm5JUkQ5ZVo3UzdGMms4MWxT?=
 =?utf-8?B?NzV1VDNvRWluVjRKVDhXbmZKNC92dk5TR1piUmxtQUo5ak9EdmE4YlBQdmx3?=
 =?utf-8?B?MFA1NUNhTjFzMWRqSmFpRGRoKzhyRHpveEpIZGRHQlExdCtlczc0R285T2pE?=
 =?utf-8?B?UEVjZm5nQ0toanlmUkRGRFBWeXlwRDFsSVBvUVpkNWxxbnp0ZjVydnJCQUVU?=
 =?utf-8?B?aU5ZdkhRay9zUmE4WEJOV0JmNVhaQzUrNmg4SUdNc0s2Zzc5VlE2S0xUai9o?=
 =?utf-8?B?YWVZeUNqYStuTHZjZVNsYlRFZ3o1d2NVZkI0ZTVEeTNJYWhGdTJ1SkhNcC90?=
 =?utf-8?B?ckR4TFJyZ0pFK0l3NGo5RnZHK3VNc0J3OXN2RXh3aUlwWmV6aE5oZ3pua3BW?=
 =?utf-8?B?bUtiRDQwOVdMT3hWOXo5bmRYczVmL3ZpemtWM3QzaXpOMVh4SzE3Vy8vZ2tM?=
 =?utf-8?B?WEc2OC9INWxBK0gvRE5MYXMvNVlPb3NOQnJwb1lCTnAxRkcvZXB4MldreGZk?=
 =?utf-8?B?eHhnTU9zcmFzS2RGSzBwMXdzNm5wN2sxK1NIRlJQczVHUzJ0emRid0ppMlVP?=
 =?utf-8?B?YWxPNjYrUzJXRHR6enQvYUFneFY1RDliR0o5eHdvUFBGZlZ6NEVWZ1FjeHhY?=
 =?utf-8?B?d0xiRko3QlBFOHd5REFTR2pHOU5MNTZJaFl0bTF2T0lJcHpabTZzT21iWExt?=
 =?utf-8?B?N3pqZHhXcmZlNTRSN2xPcUtHU2RxeHBYNXJ5a0lNV1NYeXNVUE5jTElrY2x4?=
 =?utf-8?B?RitVMTVTS2FJRkVybmNQcXFKNzNWRUpTd3BLYkVmZjFuTStGR3pyTzh6Z3Q4?=
 =?utf-8?B?T3Z6eTJydWprLzRSNnZIQTQvNXNSYVlmcURLclB6OVAydUVETlpPdGFVVHNa?=
 =?utf-8?B?Z0xTVC95REMzSFhsVzRQMjZXL2cvOExHM2ovUlJiOUlXUjZkcFhyYkxFaytQ?=
 =?utf-8?B?VUdvaHVUVDdlRW9qL2dwRGxJQjQ1U3FsVHNlUHorSFdzVmpjWWQ1V01ialpV?=
 =?utf-8?B?aXJFVkRCTEFIRDJtLzlDcHJEUmYwM0Vxb281RDhmek9HaUZ6dWh0ZVFEYUc4?=
 =?utf-8?B?WnhyL3pqR0J6aXFCeFZIeU1HSTM4THBiQWZUb09LWENiVElVMkRwWUVlRmhK?=
 =?utf-8?B?T0hvYW5Sd1FwTk4vQklQd0hGZ3Z3UlM1dmxhMXlnQWRUTHA5YlpPZFFJRDF0?=
 =?utf-8?B?S1hIZnlrNmEzMnYwL2E1eDd3TmFlS1BkMlIwWTY5V0h1eHpuZ1YwSkprWjF4?=
 =?utf-8?B?T3l5UmgxM0l0dDhDT09aYlhuenhlYVFXL0k0YmxOdnVWSS83ekZCb0xvdEw0?=
 =?utf-8?B?Uyt5eC9taFdsdXhDbVB5QXRoeE1mYW5yWldaaFA2WjdaVFRFVjFQajV0djJQ?=
 =?utf-8?B?ckdFMUVsL28xTTlMS2NEUjRCcG9VQkhzWnR4dnJnU09nK2x0OHBLSGY5aXVC?=
 =?utf-8?B?RHhhMDhodWJzNzFzL2VwTi9RWEVQbytkQSt2SjJraXlkTFVRTitQbHl5R0xD?=
 =?utf-8?B?ZmEzTnR0UUJwUWFKUkE1MFp0cE5VTU1SVHdGbzFRVWNIeFFlc0poaHVOS0NP?=
 =?utf-8?B?dzVPZGNDbjJYbzFGREtmMk04d3hNUGxEUnBTaGlhS1BqN25WYTMrc0JjOFkv?=
 =?utf-8?B?c2NGdFV4S1Fuc1NDRlU3czBJM1QxRUJCZjJkS1JibmY1Q3FCTG94eWN5LzI1?=
 =?utf-8?B?OG0xUG84R01jL0NrT2NTNWlQS054aVFQSDcvWXorZW9qMXl2QVB4Q1lqMVBh?=
 =?utf-8?B?MWJMM3Z6UFZoL2o0Y0Y2RTQwVHNpTmc5R2pHMW1IWEtVVW5oUDhadFJIVmtV?=
 =?utf-8?B?aTZwY01kdkVSTHh4RjR1SFBwYnFWWitxQ3Q3dUllOHVoZHNKa1JiMTJxNm40?=
 =?utf-8?B?VmNnNnRrcE8rWE9melhXMUxlZ1MzRGFCMUpTVkVEVG02YVhGRUovdlVwL3hM?=
 =?utf-8?B?WThjUXY3YVlLZW9yU3Izdmg4TVB5VjVuS2xacitKTTY5YlY0UWs0QmFWaVZp?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b382950-165e-4f3b-1025-08dd8739803d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:18:39.3840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyySDymERo1X6BcYRlYkcj5bibo7y5k4cmDRHypYffwrgL6SEH/KGplKj/e6pKpZIegbQhl7DJcEX+YpbikRMZbxe+d1rCY37TQ4mhUKdV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF4E874A00C
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

On Tue, Apr 29, 2025 at 08:04:04PM +0400, spyroot wrote:
>    Thank you very much, Bruce, for taking the time.
>    I'm observing odd behavior when PF either does not show stats for some
>    VF
>    or leaks VF stats from one to another.
>    i.e., generator A sent 100 packets to VF A and generator B 100 to VF B;
>    VF A and PF ICEN stats show 200 packets per VF stats.
>    (Note each flow is destined to the corresponding MAC of VF,
>    and prior to a generation, MAC entry is confirmed on the L2 switch, TX
>    VF.
>    So the packets aren't flooded, nor is it an unknown unicast frame).
>    The second condition, PF, shows zero stats for one VFs, but two RX
>    instances of testpmd
>    show correct statistics. (i.e A should see 100, B should see 100, A and
>    B
>    each report 100, but PF reports 0 for either A VF or B VF).
> 
>    The results are the same whether tested on the same node (k8s)
>    i.e lo-locate with TX PODs or on two different k8s nodes.
>    Condition two is observed if you do a single flow (i.e., hash on RX ide
>    land packets to the same RX queue). PF doesn't account for or report
>    correct values if you have two readers (i.e., two DPDK instances).
>    (Note: TX reports correct stats for A and B)
>    i.e. A sent 100, B sent 100
>    switch shows 200.
>    TX - A - VF A -- (L2 switch) -- (RX side) VF A -- testpmd
>    TX - B - VF B - - (L2 switch) -- (RX side) VF B -- testpmd.
>    On the TX side, 3 points of measurement.
>    VF TX stats, PF TX stats, L2 switch (total pkt,ppks etc) TX and
>    outgoing port RX.
>    Kind Regards,
>    Mus

Hi again,

do you see the same results/issue if you use a kernel driver for each VF
rather than a DPDK one? Issues with the stats reported by the PF are not
likely related to the specific driver or PMD using the VF, so I'm not sure
that you are seeing an issue with DPDK itself.

/Bruce

>    On Tue, Apr 29, 2025 at 5:22 PM Bruce Richardson
>    <[1]bruce.richardson@intel.com> wrote:
> 
>      On Mon, Apr 14, 2025 at 07:21:57PM +0400, spyroot wrote:
>      >    Hi Folks,
>      >
>      >    I'm observing some unexpected behavior related to how
>      statistics are
>      >    retrieved from a Physical Function (PF) on an Intel 810 NIC.
>      >
>      >    Scenario: I have two dpdk-testpmd instances running in separate
>      >    Kubernetes pods (same worker node). Each instance uses the -a
>      flag to
>      >    bind to a different VF. (i.e to have consistent port id 0)
>      >
>      >    Questions:
>      >     1. PF Statistics and 64B Line Rate:
>      >        I'm noticing that the RX packet-per-second value reported
>      on the PF
>      >        side for a given VF is higher than the theoretical maximum
>      for
>      >        64-byte packets.
>      >           + Does the Intel 810 PMD apply any kind of optimization,
>      >             offloading, or fast path processing when two VFs
>      (e.g., A and
>      >             B) are on the same PF?
>      This wouldn't be something that the PMD does. The forwarding from VF
>      to VF,
>      or PF to VF would happen internally in the hardware.
>      >     2. Concurrent Stats Polling:
>      >           + When two separate dpdk-testpmd processes are running
>      (in pod A
>      >             and pod B), does the PMD or driver layer support
>      concurrent
>      >             reading of PF statistics?
>      Looking at the iavf PMD, the reading of stats is done by sending an
>      adminq
>      message to the PF and reading the response. Any serialization of
>      stats
>      reading would then be done at the PF or adminq management level. The
>      VF
>      should not need to worry about whether another VF is reading the
>      stats at
>      the same time. [In fact it would be a serious bug if one VF needed
>      to be
>      aware of what other VFs were doing, since different VFs could be
>      attached
>      to different virtual machines which should be isolated from each
>      other]
>      >           + Is there any locking or synchronization mechanism
>      involved
>      >             when multiple testpmd instances attempt to pull stats
>      from the
>      >             same PF simultaneously? ( in essence, does a
>      firmware/OF
>      >             support concurrent read).
>      >
>      See above.
>      /Bruce
>      >    Thank you,
>      > cd /usr/local/bin && dpdk-testpmd \
>      >   --main-lcore \$main -l \$cores -n 4 \
>      >   --socket-mem 2048 \
>      >   --proc-type auto --file-prefix testpmd_rx0 \
>      >   -a \$PCIDEVICE_INTEL_COM_DPDK \
>      >   -- --forward-mode=rxonly --auto-start --stats-period 1'"
>      >
>      > cd /usr/local/bin && dpdk-testpmd \
>      >   --main-lcore \$main -l \$cores -n 4 \
>      >   --socket-mem 2048 \
>      >   --proc-type auto --file-prefix testpmd_rx1 \
>      >   -a \$PCIDEVICE_INTEL_COM_DPDK \
>      >   -- --forward-mode=rxonly --auto-start --stats-period 1'"
> 
> References
> 
>    1. mailto:bruce.richardson@intel.com
