Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89B1D47CDE
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 11:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4FFC42DB4;
	Fri, 16 Jan 2026 12:32:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 738714279E
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768563128; x=1800099128;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0BUUrPsgbtcIdeIBcq1kqeD17V46R3aAv+fz8A2i62M=;
 b=eySVDs2BP4Gg++ihpnHcXBBJJu9vwai7Jn4JG8eDyaXkO4bLtHPmmPIP
 CUnaZXMS4z+yxqJLe21kHq6XW9eek4KyMhAVTcc9dm826sVoneTV0GFVL
 /TMNj4c2T6Cc6xGvaYrRBCDzZhjpWHGsBF4NG/Qx5wfF431bMgn/5O9y3
 xOY1cWkmX/a2Y0X21hBGQfN+zuJuQ7VUCjLyHIEf84ZlaYFAAm0k+LavZ
 QH/jBz3WzFdWQmdMyzWxnYEhNCT8r8l4KHAQdn1JgXXr60WvmrOhJdWdg
 sIdUND6BzgyPq/RpX3LlbsGC95QAWRietYUcVvNGRvCESEjGcX40GnKBg g==;
X-CSE-ConnectionGUID: 75Jv/rF/TOqHHkRwOM7tKg==
X-CSE-MsgGUID: +TVSWKpxQz6VU4MHDA8rww==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="92539603"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="92539603"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 03:32:07 -0800
X-CSE-ConnectionGUID: rUt43lz6Rqmly/9+2aDnPQ==
X-CSE-MsgGUID: OqNR/WjJSwqbvSxfKHXDow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; d="scan'208";a="205258188"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2026 03:32:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 03:32:05 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 16 Jan 2026 03:32:05 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 16 Jan 2026 03:32:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLvWJdH8Iwo8+u0m5zwpPYeCVG6UcUCEBwTCcOGJsD3uoivrtcTuQrk8s26XUl32hYPV3CqslnH+DJhh4YLLL+x50kSZdjPaZbxwSgb+GplNyyMhAQjH1zVKi9ZOEZ70OUp6ywXUxsvT4NkRpE9QDufzASYhxduZ8u0UI7zwRQqSMSgtS/5tiA3bpRPiPgWRCjSA2zuRbt8hdj/9kPTZlZQY5faXd11CTPrPEJmQWUI4On3v+ZJEtVKKAbUA80NxMxb3xVXad1EcLJsH4u7qITUfVCJYYVUKsfJ28l2gINYL9biXUQVzUGALYUI8CCUyWKn7lVtPPRwdbATuEHanRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNyKXU++8hcaSKiDBkTIqrykaC5ZZxlOGHPXx+yj4XQ=;
 b=hwmaZgQihppx4LqnY9ZvSgVN66R69vrTwRx+xxP9Wff1bnFnJoVzEaFDkt5k4n5cGz9LdPUv9tH7+Z0biHPnKkMPQwkS+zmIbcxMmFnGh2GLhANZJxQogngRZV48vOYbMznxUKesTVXWzyw4EFdEKP1YH0B+0zQvljCckoFBTLrM0C7W1IVlvUZFW8ecOkSjnrVDghHDZyi8oJj31aJr6i1+DcrNZfSuZuPAi9H3kahwAMtECPV+mGqD+/t2byKCa73ij3Il1lx86TIY6ZLLHrh4zzJaLG2Pr2PkJp9ud1UTbQQVWIZPu2/AQkOo4w8ACiV04dVC68rTILEy/M1bPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 11:32:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 11:32:03 +0000
Date: Fri, 16 Jan 2026 11:31:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Mingjin Ye <mingjinx.ye@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/ice: add devargs to control link update
Message-ID: <aWohrPmPQRCLnscK@bricha3-mobl1.ger.corp.intel.com>
References: <20241118085150.2587595-1-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118085150.2587595-1-mingjinx.ye@intel.com>
X-ClientProxiedBy: LO4P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd14f06-9a7a-406e-20a0-08de54f2dead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW4rS1NLWXdSRUJ3M2Z1SXdVNUZrQnhEMVcwVzFBOEpzelZVanBWR3dIMVZ3?=
 =?utf-8?B?bjluUStXdlh1dnVPZjN5YUkyNzFtTzltRm5aY1FLQ2cyd0F6T0JESy8yV1FX?=
 =?utf-8?B?Ykc2U0tCcjMyUExBRXd1amd1WDBROUFjZlIyWjNTei9acVZqN2lrWUtEcVkw?=
 =?utf-8?B?dE5IZitJNnYwSW9mKy92WW1FZkZSdUF1T05SeU9OSTNRQ1B5Q3YwTE9KK0s0?=
 =?utf-8?B?U3FudU9KUDRvTEtvNTVwT1N0SXVad080NVBPbEFTeDg4OFk5S2RQdDk5aEor?=
 =?utf-8?B?L1JTdlVJSzZMSkdVMS9LRWtyeHZUMU56bXFjSjZjdkE2Rm5oU3ExOGJtVkU2?=
 =?utf-8?B?cHNveTIyMjAyMUEwZmFjS3lwOXdSYTJxMndBYW1aN3hndFZGSUk2azdTRis4?=
 =?utf-8?B?UnNnTVZaYzR6cng0V3kwZXp0TFZjNXAyTmJyMWhSK0FEVDg0bzV0elJ1QUQx?=
 =?utf-8?B?RkF3SFVPUm5JM0hGdWhCbk13ZktOTkFESHZHSExZcmU3U2VsNElsWEVpWWJY?=
 =?utf-8?B?UzljUUFWWi9UUTViZERtcjJ3LzFORDJoLzdEMjJRUFpybWF6TmVvUm93WTNn?=
 =?utf-8?B?d2lzMnp0dm9lUzJobkhpRGhQV1kxNlY1Z1FleW54KzVMTHl0Wi83Y1dpdEc2?=
 =?utf-8?B?UU55blp0SUFKeXZFbFBpOEFMdUErU3M5aFpYT3FGVjFvTFhrb2lCUC9ScUI1?=
 =?utf-8?B?a3RPWFBlblZ6cFBFanhJUFVjZ1dHRGJyZlVYUStjQ08yNDltWldRdGJLTCt6?=
 =?utf-8?B?LzdCY0s5RFNMeHNkRTVuR29jRS9ScEVjMG4xUHQrM0U1bGxucHovbGdsOGtT?=
 =?utf-8?B?NHZHU0hFMXptd1BSUkZJTi9EV2RCRmROV3hyTVcxUFFOb0x3TXNVMFkrRVFM?=
 =?utf-8?B?OW9sNTBVYnpucnlTVUhvcVhYaWVyUkJ1YnJPQVlKU1NFMnNBL2VsMFdoUXM1?=
 =?utf-8?B?RGRzRWRCdDZSRFpRWm40SmpLNC9XVUZ3b09ldnVDRHNaUDFmSXRMYVRFR3Jz?=
 =?utf-8?B?UVRLVUdpcmtpb29Jdndnb1dvczJGejVwVTRJcnJkcldNMXo3cEhpeTYvQlNB?=
 =?utf-8?B?VE9oditmbDc1VEdrSHVvbG1HMXNPUmJFNlcycU9KbHlQTEdUdm9PLzc0ZDdj?=
 =?utf-8?B?Q2xuUHJ2RXFVdHRLV1VxZ0IwTnZFNFhyZEF2UFlEa2FvWTgvZHQ0T1F2S0xH?=
 =?utf-8?B?R0FOOEtMUUZZblJwTTlhL2N6UmNncTlCQnFraGNJdTNVU0xET0xDZUVPZksv?=
 =?utf-8?B?dkdlZnJEYjVseGg2L1JRWXpwREQvdDhqbzVDMUxhenBCMndkc21GZHJCaEtN?=
 =?utf-8?B?NE9Uek00NzRtUE9lQnJ3SHpONUtuQ1NITUlmeDFNRThFRDlrcVd4bndIenFR?=
 =?utf-8?B?bnlTeGtBNzVrUk5rOXcxQ2I3ZWFDNkVSS0pDdTAraGxoZkxTdnlGLzF2NW8v?=
 =?utf-8?B?dEg4Vno0UGNZR0kvZnMrbmpQeUpmaEwxbmR0TFhpSDVIZVE5elZlb0RZZlNh?=
 =?utf-8?B?RTQxNUFMdHpUdjl2dENnZlZpdHhLYmo1aFNHbWpuNDlLQncrOWJlUVVwb3RY?=
 =?utf-8?B?UlBlWldlcnBXcDNZNXZYMG5rcHhtejZWb2dtQzd1R29PZjhlSUNaWENNcU5y?=
 =?utf-8?B?OW90VU94STkzeTZXc29wdTVrVEJoa2NiZUFHaEloLzExaFZaTm55Rk1qQWF2?=
 =?utf-8?B?WWRQQ0xPVmI2VjV0MGRyZTQvbUNtVGZ0M3hSaWhXbG9hTUR0RnJUb2t0NzBX?=
 =?utf-8?B?c2hVTWVmdWFaS2l1WFpBaExzbi9hUWU1MUlmZisweHBKcFVoMDJnZ2ljbnZY?=
 =?utf-8?B?bHhQc09MWFNKY3NwNEFBQUE2QmM0eFZWTWlWMHN3UU93ZjBoQk4vYll2eVBs?=
 =?utf-8?B?SEYybXZKSVNTWElQM0VxUkozWHJUdVo0VkFIeHpxRHdrNGRIK3hlek5HaVlt?=
 =?utf-8?B?NXFIczgwU2pEb0ZRMnhoWmlXUTNlZE0yYWoxSXhCWDBSNFhPTnN0aDVpMksw?=
 =?utf-8?B?YmZRbzRmUnBmS1pBbjV3Z01Jc2NkdFhScFpCa1lyZVVCRE1IMVNkazdaTm9r?=
 =?utf-8?B?Qjg1c0RyQi9EQ0FNaEhpelJoSmJ2UnpnaS9tdEhXSlhiYjgwYWV6THcvMEd3?=
 =?utf-8?Q?tC84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTlQcEpwZVI4Uk16QTgvdXh5Q1gydTF4aXdrVHdGSFJUWXpVK3ExYlNJaDRM?=
 =?utf-8?B?dGZWSVBscDJMdkIrR01wVC80QkR4aG1Rb2dOK0dzSGs4eXdpSi9UVzBJQnps?=
 =?utf-8?B?TXFpbFRDVzhiUWlramF1S2IvakZ1d3RjcXBzTHgyNm1mMXhycjJZdll5Sloy?=
 =?utf-8?B?em1Zd3J2cTQvb1hLNDlocXFmVmtCamxzWWpBZmthOHdlL0lWNVp3OVVOckpO?=
 =?utf-8?B?cnBIRWd1VU1LcGhBMS80S2VkMHZZL0t2OFdDdmQ4UnFGT1p5dE5ad2drM2Nq?=
 =?utf-8?B?L05nVEVnTS85NHJRRWlCUzlveHFzMU5kTGZUQWR6TTBRcEp0Qy9FL2tzb3N3?=
 =?utf-8?B?YVV2ZFplT3NBV1BXMHl6cWl3NW52MitadVpEWFNmN0pyOVladzJRdUlMU2N1?=
 =?utf-8?B?TzJsd2hXRDdJK0dsMjl0Y2syQVY4SjlERzNIaDYrVW0yNmhDWld0d1FwOEhG?=
 =?utf-8?B?WVhqelZ1eXdFeXlsUVIvaXZ0UHlGSktnQWw1cUVqR3R6LzBselJOa2VzNEtW?=
 =?utf-8?B?UjljK0xYaHl4UlppZllJMHZUZXI4Vm5hUFAxMDFvMzZYbFhxdjVEV3Nycm85?=
 =?utf-8?B?TktCRWVBVi92dXg1VzMxVmllbXViaWdMSU9nTDVJc0FKckdUMVYrRXJNaDBp?=
 =?utf-8?B?aGFzRUlYSEtySXVRTWJNdFpUbDlTeWIvV3RyVjdHY2h5akRnU1lweVhIaWY5?=
 =?utf-8?B?SVBZYUtocnZ0N3p3YjlXMzdvRjd3b1I0czl3bmg0S09IUUxOVHVueGFFTklm?=
 =?utf-8?B?dXduaU1CaFFTV3hmdTJsbXhkL3VZN0U1RE5YeWJKWWtyMkxVUWNXcjhwWjBy?=
 =?utf-8?B?WlduSzFlQVJyZ2s5YllNWk9paWFvUWhldzZOdFpOUkpCK3VxcEhSV25LbFl0?=
 =?utf-8?B?V2J4OUV5UWYyMzNLRlRhUVZnY0crbVpMa09KZjZDRWJudVdjTFJpUVZoRnlz?=
 =?utf-8?B?amVwZHVGS0RhR090Ulh1S0twOUwvMjRSMVFnditkaGlOSFNnSkFOMVA1S0Fn?=
 =?utf-8?B?dW1yc3h3bjEzVWg5bG16U3FLUFdjeGFMZUtqenhEQm1lVHBHVHg4eW9IelFO?=
 =?utf-8?B?VVY3U1kyL0ZLMDhGTFk3czBsWmpNUTVRbGRFZDZGcjVaRTN0NHpMMC9CVE1F?=
 =?utf-8?B?K3hlKzY5cHJJVjdFQXJmT1MraTJMTURJNlhPV2RBWUpEWEVOMlNkeWxzRzFv?=
 =?utf-8?B?dk0xRUFrWHNVMm81cW5QUnZuVDFhMmQxUElFaEhGcC9UcHN6Q1Z5cFluUlA1?=
 =?utf-8?B?WkN3Ukg2cmRjMGJabjZma0RBa29oM2NoNFM1MUwwUlZzUTcxSmExWW9mN3pV?=
 =?utf-8?B?alpKYzJLTWdQSUtiSDFwUkFnMnZUZGNUdXBueVM3Y0dVM2VrQjd6UTkxdndw?=
 =?utf-8?B?U0V2MXhETDloUVpNQmtEdlh3NDc1ek1ubnRzN3dvTXlwUy8xbGM1U0NXQTY3?=
 =?utf-8?B?YlNXWkZKOFlxT1lDSllFNEJSUkxSd2dNRWR4N2ovSW1xcW1LWmhJSjF3RFBV?=
 =?utf-8?B?ZG1FUUhxTXpBN1Fnd3Nzb0l1bk5pVFd1bmE2bGRGVFI2RkVxUGdvZmVHbWpu?=
 =?utf-8?B?K3BsWHlkL053cC9aa2hPcW5jY2toQ0NHcWo1b0s2ZVNqelVpVkJSUlYzb0JK?=
 =?utf-8?B?UURMaGVmMUdKUGlqc0kwMExWZGZoNTdUT3FaUjJJTFVxTWthTWh2KzdjZkVy?=
 =?utf-8?B?TWZkUlN3YWdjejZLZlNXbGdGeVRWMU1uVjRUalp6Vk96Sy9QZWJEbUxBbHpz?=
 =?utf-8?B?NUNVbjZPaG5lSGExbXV1Szlwd2IvQ2hGRG9LNjR2SEw2ZnNKdG4zdVBZRlU1?=
 =?utf-8?B?VTNVdjM1KzVoeEZpekJyeitya0ZjaWR4Q1h6TDUzZmFtaXZZL0s5MFZpTFVw?=
 =?utf-8?B?WDNtWnQ3NVh2cUsxcXREa21oRjdHZHkzNzJBcWY0c2JzMUtXcXQwSm5DcCtG?=
 =?utf-8?B?c3Z4MEhjd05LUFFvVllaWmZiY0xoZGs3aVpvT3lYWlVoallZY0t2KzNkTElm?=
 =?utf-8?B?QmRmMUs1aU14SkdjYkRmaVg5U2pFU1E2UmhVRkRpeFNQVWRxMFQyMmRpTWhw?=
 =?utf-8?B?WDJNTmVRVmlGK1JMQlZFdEJnTGl4bVFDVG9sY3pJbVA2YUNLM2U0WDIvNVFE?=
 =?utf-8?B?QTRWR3FEcmI4cUZvb29MejBpVys2Y29ZU0x4UUY2ZjEvL0xuUkVzZEovTTRB?=
 =?utf-8?B?T2pLcVEwZ0twTXc3U09IY3YxRm1YTnZzaExEc01selJ6NEY0T3NHQXozTkZs?=
 =?utf-8?B?dEcrMS9wNzFSNlZoTWNTSXlnQW9ySUFxYS9rbFJneEw2Umg0OGwvNWVRUHRK?=
 =?utf-8?B?RUdYVEcydG52VFo1VUNtaDhFc1lhblNoaFdxZG9jaUw3NE5kSlpPVXkxSU9k?=
 =?utf-8?Q?U344N3gse6FJzLlU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd14f06-9a7a-406e-20a0-08de54f2dead
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 11:32:02.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdD1zqCy7crCbscpxp1UT35ahzt+5jSQUZZhrlRgsJcE5FQoUi9UzMg+j4lX7c9maKCjLf4+gZ3da2G0Fd+zL/wggck65D3XfJjMQ9Mg5dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
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

On Mon, Nov 18, 2024 at 08:51:49AM +0000, Mingjin Ye wrote:
> This patch adds the ‘link_period’ devargs to adjust the link update
> period (microseconds), when the value is less than or equal to 0
> it will be disabled, by default it is not enabled.
> 

Finally, getting to review this old patch.

Initial comment is that the commit log message does not explain the reason
for the patch. It explains what the patch does - adding a new devarg - but
not the "why" of what problem this new devarg is designed to fix and how
exactly adjusting the link update period fixes that. In next version,
please include the problem description and a bit more detail on how the
patch fixes it.


> This patch is based on DPDK 24.07.0
> [b3485f4293997d35b6daecc3437bb0c183a51fb3], for customer cherry-pick.

Ok to include this info, but please do so below the cut line, i.e. put it
with the v2, v3 delta information, since it won't be part of the commit
log.

> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
> v2: Fix using the wrong variable.
> ---
> v3: Callback only when link state changes.
> ---
>  doc/guides/nics/ice.rst      |   7 +++
>  drivers/net/ice/ice_ethdev.c | 113 ++++++++++++++++++++++++++++++++++-
>  drivers/net/ice/ice_ethdev.h |   4 ++
>  3 files changed, 122 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index ae975d19ad..1f47c81baf 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -273,6 +273,13 @@ Runtime Configuration
>    * ``segment``: Check number of mbuf segments does not exceed HW limits.
>    * ``offload``: Check for use of an unsupported offload flag.
>  
> +- ``Cycle link update`` (default ``not enabled``)
> +
> +  Cyclic link update is enabled when the PMD status changes to STARTED. Setting
> +  the ``devargs`` parameter ``link_period`` adjusts the link update period in
> +  microseconds, and is disabled when the value set is less than or equal to 0.
> +  For example ``-a 81:00.0,link_period=5000`` or ``-a 81:00.0,link_period=0``.
> +

The section heading should match the name of the argument, otherwise it
becomes hard for the user to find documentation on the argument by looking
at the doc index.

I'm also unclear on what is being referred to here, the argument is called
"link_period", but the first line of the description talks about the PMD
transitioning to started, when I expected some description of the link
coming up. I think a short description of what is meant by the "link update
period" would be helpful too.

>  Driver compilation and testing
>  ------------------------------
>  
> diff --git a/drivers/net/ice/ice_ethdev.c b/drivers/net/ice/ice_ethdev.c
> index 304f959b7e..7e332e74bc 100644
> --- a/drivers/net/ice/ice_ethdev.c
> +++ b/drivers/net/ice/ice_ethdev.c
> @@ -13,6 +13,7 @@
>  
>  #include <rte_tailq.h>
>  #include <rte_os_shim.h>
> +#include <rte_alarm.h>
>  
>  #include "eal_firmware.h"
>  
> @@ -36,6 +37,7 @@
>  #define ICE_ONE_PPS_OUT_ARG       "pps_out"
>  #define ICE_RX_LOW_LATENCY_ARG    "rx_low_latency"
>  #define ICE_MBUF_CHECK_ARG       "mbuf_check"
> +#define ICE_LINK_UPDATE_ARG       "link_period"
>  
>  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
>  
> @@ -52,6 +54,7 @@ static const char * const ice_valid_args[] = {
>  	ICE_RX_LOW_LATENCY_ARG,
>  	ICE_DEFAULT_MAC_DISABLE,
>  	ICE_MBUF_CHECK_ARG,
> +	ICE_LINK_UPDATE_ARG,
>  	NULL
>  };
>  
> @@ -1385,6 +1388,70 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>  }
>  #endif
>  
> +static void
> +ice_link_cycle_update(void *cb_arg)
> +{
> +	int ret;
> +	struct timespec sys_time;
> +	struct rte_eth_dev *dev = cb_arg;
> +	struct ice_adapter *adapter =
> +		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +
> +	ret = ice_link_update(dev, 0);
> +	if (!ret && adapter->link_status != dev->data->dev_link.link_status) {
> +		clock_gettime(CLOCK_REALTIME, &sys_time);
> +		PMD_DRV_LOG(INFO, "Current SYS Time: %.24s %.9ld ns",
> +				ctime(&sys_time.tv_sec), sys_time.tv_nsec);
> +
> +		rte_eth_dev_callback_process
> +			(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
> +
> +		adapter->link_status = dev->data->dev_link.link_status;
> +	}
> +
> +	/* re-alarm link update */
> +	if (rte_eal_alarm_set(adapter->devargs.link_update_period,
> +				&ice_link_cycle_update, cb_arg))
> +		PMD_DRV_LOG(ERR, "Failed to enable cycle link update");

If I understand this correctly, when this feature is enabled, rather than
handling explicit link status update messages, we periodically use the
interrupt thread to poll the link status and update it that way.

> +}
> +
> +static void
> +ice_link_cycle_update_init(struct rte_eth_dev *dev)
> +{
> +	struct ice_adapter *adapter =
> +		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +
> +	if (adapter->link_cycle_update)
> +		return;
> +
> +	adapter->link_cycle_update = true;

What is the need for this link_cycle_update variable? Its name seems to
imply that it indicates that we should use link_cycle_update but then it's
not disabled when the feature is disabled. Is it just indicating whether or
not the cycle update is already configured? Is that necessary to track, can
we just use the update_period to determine if we should cancel the callback
on uninit?

Also, should this function not return an int rather than void, so we can
return error if the configuration fails? If the user requests the feature
but we can't enable it, we should fail the overall init, IMHO.

> +
> +	if (adapter->devargs.link_update_period <= 0) {
> +		PMD_DRV_LOG(INFO, "Device cycle link update is disabled");
> +	} else {
> +		PMD_DRV_LOG(INFO, "Enabling cycle link update, period is %dμs",
> +					adapter->devargs.link_update_period);
> +		if (rte_eal_alarm_set(adapter->devargs.link_update_period,
> +					&ice_link_cycle_update, (void *)dev)) {
> +			PMD_DRV_LOG(ERR, "Failed to enable cycle link update");
> +			adapter->link_cycle_update = false;
> +		}
> +	}
> +}
> +
> +static void
> +ice_link_cycle_update_uninit(struct rte_eth_dev *dev)
> +{
> +	struct ice_adapter *adapter =
> +	ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +
> +	adapter->link_cycle_update = false;
> +
> +	if (rte_eal_alarm_cancel(&ice_link_cycle_update, (void *)dev))
> +		PMD_DRV_LOG(ERR, "Failed to cancel cycle link update");
> +
> +	PMD_DRV_LOG(INFO, "Cancel cycle link update");
> +}
>  /**
>   * Interrupt handler triggered by NIC for handling
>   * specific interrupt.
> @@ -1401,6 +1468,8 @@ static void
>  ice_interrupt_handler(void *param)
>  {
>  	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
> +	struct ice_adapter *adapter =
> +		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>  	uint32_t oicr;
>  	uint32_t reg;
> @@ -1411,6 +1480,7 @@ ice_interrupt_handler(void *param)
>  #ifdef ICE_LSE_SPT
>  	uint32_t int_fw_ctl;
>  #endif
> +	struct timespec sys_time;
>  
>  	/* Disable interrupt */
>  	ice_pf_disable_irq0(hw);
> @@ -1433,12 +1503,20 @@ ice_interrupt_handler(void *param)
>  		ice_handle_aq_msg(dev);
>  	}
>  #else
> -	if (oicr & PFINT_OICR_LINK_STAT_CHANGE_M) {
> +	if (oicr & PFINT_OICR_LINK_STAT_CHANGE_M &&
> +	    adapter->devargs.link_update_period <= 0) {

I have a slight concern here. For the link coming UP, I don't think its an
issue to not handle the interrupt and use the delayed processing. However,
for a link coming DOWN, I think it can be problematic to use delayed
processing and taht we should always handle the update immediately.

>  		PMD_DRV_LOG(INFO, "OICR: link state change event");
>  		ret = ice_link_update(dev, 0);
> -		if (!ret)
> +		if (!ret && adapter->link_status != dev->data->dev_link.link_status) {
> +			clock_gettime(CLOCK_REALTIME, &sys_time);
> +			PMD_DRV_LOG(INFO, "Current SYS Time: %.24s %.9ld ns",
> +					ctime(&sys_time.tv_sec), sys_time.tv_nsec);
> +
>  			rte_eth_dev_callback_process
>  				(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
> +			adapter->link_status = dev->data->dev_link.link_status;
> +		}
> +
>  	}
>  #endif
>  
> @@ -2153,6 +2231,27 @@ ice_parse_mbuf_check(__rte_unused const char *key, const char *value, void *args
>  	return ret;
>  }
>  
> +static int
> +ice_parse_clean_subtask_period(__rte_unused const char *key,
> +		const char *value, void *args)
> +{
> +	int *num = (int *)args;
> +	int tmp;
> +
> +	errno = 0;
> +	tmp = strtoul(value, NULL, 10);
> +	if (errno == EINVAL || errno == ERANGE ||
> +		tmp == 0) {

Nit: the indent is wrong here, since it lines up with the body of the
block. However, rather than fixing the indent, you can just put the whole
condition on one line.

I wonder though about disallowing "0" as a value. I think it's good to
allow this as an explicit disable if that is what the user wants. To detect
bad input, I'd recommend allowing zero, but replacing the NULL with an
actual pointer value that you can use to verify that the end of parsing
results in a '\0', i.e. whole string was parsed.

> +		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not greater than or equal to zero",
> +						key, value);
> +		return -1;
> +	}
> +
> +	*num = tmp;
> +
> +	return 0;
> +}
> +
>  static int ice_parse_devargs(struct rte_eth_dev *dev)
>  {
>  	struct ice_adapter *ad =
> @@ -2214,6 +2313,12 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
>  	if (ret)
>  		goto bail;
>  
> +	ret = rte_kvargs_process(kvlist, ICE_LINK_UPDATE_ARG,
> +				 &ice_parse_clean_subtask_period,
> +				 &ad->devargs.link_update_period);
> +	if (ret)
> +		goto bail;
> +
>  	ret = rte_kvargs_process(kvlist, ICE_RX_LOW_LATENCY_ARG,
>  				 &parse_bool, &ad->devargs.rx_low_latency);
>  
> @@ -2525,6 +2630,8 @@ ice_dev_init(struct rte_eth_dev *dev)
>  	/* reset all stats of the device, including pf and main vsi */
>  	ice_stats_reset(dev);
>  
> +	ice_link_cycle_update_init(dev);
> +
>  	return 0;
>  
>  err_flow_init:
> @@ -2676,6 +2783,7 @@ ice_dev_close(struct rte_eth_dev *dev)
>  					  ice_interrupt_handler, dev);
>  
>  	ret = ice_dev_stop(dev);
> +	ice_link_cycle_update_uninit(dev);
>  
>  	if (!ad->is_safe_mode)
>  		ice_flow_uninit(ad);
> @@ -3864,6 +3972,7 @@ ice_dev_start(struct rte_eth_dev *dev)
>  
>  	/* Call get_link_info aq command to enable/disable LSE */
>  	ice_link_update(dev, 1);
> +	ad->link_status = dev->data->dev_link.link_status;
>  
>  	pf->adapter_stopped = false;
>  
> diff --git a/drivers/net/ice/ice_ethdev.h b/drivers/net/ice/ice_ethdev.h
> index 3ea9f37dc8..d0230b839d 100644
> --- a/drivers/net/ice/ice_ethdev.h
> +++ b/drivers/net/ice/ice_ethdev.h
> @@ -568,6 +568,7 @@ struct ice_devargs {
>  	/* Name of the field. */
>  	char xtr_field_name[RTE_MBUF_DYN_NAMESIZE];
>  	uint64_t mbuf_check;
> +	uint32_t link_update_period;
>  };
>  
>  /**
> @@ -618,6 +619,9 @@ struct ice_adapter {
>  	uint64_t time_hw;
>  	struct ice_fdir_prof_info fdir_prof_info[ICE_MAX_PTGS];
>  	struct ice_rss_prof_info rss_prof_info[ICE_MAX_PTGS];
> +	/* cache link status */
> +	bool link_status;
> +	bool link_cycle_update;
>  	/* True if DCF state of the associated PF is on */
>  	RTE_ATOMIC(bool) dcf_state_on;
>  	/* Set bit if the engine is disabled */
> -- 
> 2.25.1
> 
