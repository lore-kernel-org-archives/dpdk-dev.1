Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FFCCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D2CA40395;
	Tue, 14 Oct 2025 10:56:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 441C1402A8;
 Tue, 14 Oct 2025 10:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760432207; x=1791968207;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zVgc/IrLyjwEEsB3FOmZ88OkvNM954stRBVbjFwahnI=;
 b=UUXmprNuhbVzFjIIvbGaRX/tm6ZO5n8mfg6NDBO3WzF61XnM4a8uGp/G
 SUh8pe63apwRl5oqgGRqiJgxoymtCuWfQ4xq5gkCIPoh/m71S45l528lK
 sAWnucvTkhj7pnOTz6JZod/asCt8mYeg9ZOT5Pv39oV3g1mO0FY2zc48b
 H87WnNZYRlvNJoEjTL7AaMLZu73jqkSgMC8uZ3RmcgJ/Iewerr3Psm03b
 kUh4nr1EOWzlFR9SedkYWQ3RO93e1HSAeyF+fcm/CNTibysXJ2nF8JTyH
 5sJjYp4dSUA3x4bg9vObaxOTg0oWVvPCmUmJEkOsvpS6sQaJj1/cHq1Dd Q==;
X-CSE-ConnectionGUID: Mm+jlvDtQoud+hSEyt4MVw==
X-CSE-MsgGUID: NxU6/kZ6TMKbONY6jZtOAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62483122"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="62483122"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:56:45 -0700
X-CSE-ConnectionGUID: 8i1EejLHRuO2LOJ/lkNyGA==
X-CSE-MsgGUID: M9X4V8F8QYe5m4fZqKSbyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="205525819"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:56:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 01:56:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 01:56:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 01:56:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe/3FpqYyUH5CQVKWUgXWdO3NGTvy83bgxVovd5aNd7fjmMVM+V+aLIsdJp489OjkFtcpKYkOFQ4FDgTONRafUordL7EukCtImQ0z0s8LeBsAOaU03H49E6CRBMkHNOOMxNt0rdzMzdqdUM9IEGFkpbOc85H6xmdqfpNQ7uSd+C/qDXbXee6/bagtGn2h887gWgc3TWrWvlezpqnC7gpMwnerpCNFjLVy41qbKT2CPSABqoKOir+CHb1esZF77lq9Svzwqq/nmblg+duGeTLL3RlwFZTuHTh61OKld657edLJmOSRNou99b/FB4+X2HOi1CxYTSQZTBq+YAqVz/bXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K8YGdM8sy0rlEastjF8vZzTZbRn8MLttlzY280Igr8=;
 b=ZD+246Df6upwpHsqwLbkaQFBSP81z/Und/u0M1TZ4ilKdV48HxJixp+rxgfOIaUvvaMIW8VdDd5zoIznaKVEDfeFlDUQbShR2mjSUBnq4tcFcfeSYV3x0Rdhv0ZWclynWmShLwY6vijBr/cFi5P+NCUzEo39i6vuKFx2WmAqBychORG2XbPAvbBhg7Zl0SYhOfhOLmzmU7CZkocP6axgOcYNJmNxihSDH68ixx39j65pumaNyqcOKM/Zu/KrynvCs7I0LsE/M+3Cv0cSoyhdpPrly8IwnbAitMWyzcR09izU08NA8PshcADV6rdaxR6a3c2XdNB95iCIPOWzUMaAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB4806.namprd11.prod.outlook.com (2603:10b6:510:31::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Tue, 14 Oct 2025 08:56:35 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 08:56:35 +0000
Message-ID: <39c5c720-4c30-435b-ac28-96b2cd10afb3@intel.com>
Date: Tue, 14 Oct 2025 10:56:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] eal/x86: enable timeout in AMD power monitor
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, <david.hunt@intel.com>,
 <jerinj@marvell.com>, <radu.nicolau@intel.com>, <gakhil@marvell.com>,
 <cristian.dumitrescu@intel.com>, <ferruh.yigit@amd.com>,
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
References: <20251013031619.2988915-1-sivaprasad.tummala@amd.com>
 <20251013055158.3037400-1-sivaprasad.tummala@amd.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20251013055158.3037400-1-sivaprasad.tummala@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0019.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::24) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8ebaa5-f1cd-4d19-d50b-08de0aff93ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkNZUTVJY3ZwQmtUeVZLRU1IZGFuT003L2RsNHZiZDZjcnpaRkN6U2pUSUlS?=
 =?utf-8?B?ZWJadDdLNFFQbTdHRUZLS2lpeGwwVU54Q1g0MUExbzVwb0tuTW1lYnFkQlQ1?=
 =?utf-8?B?WVJLTFo0L0dmdEFWdi9RejNJdDMzY0MvcmFsc3RzR1hTdGZoUWkyU3U4Q080?=
 =?utf-8?B?eHJybjNrU2pYY3Y4UHlTdDNOM0FNZUpBaWYrWk5UMGgrbXBqYjBKQzNpQysz?=
 =?utf-8?B?WFl3ZW9LenF5ZjduT3NPeVp4WDVDZXJsZWEvZVZRQndwaGdSYU5KVHdRSVRt?=
 =?utf-8?B?ZDJDcDRSR3dKL2JqVS80U1NYbklLNElEN2RYS2YyNnU1THNHRytkOVJSUEls?=
 =?utf-8?B?eUprcmJ0eC9qaFNLcHFjelBrRWVlTWMzTXZmSmxrY1J0eXZHQTVSWTE3UnEw?=
 =?utf-8?B?MGJZeVpSOWJoaUt6bHkyaUFZcDVBZnVGUllHQ3BiaE5DRW9Vb2ZldlZXT1lj?=
 =?utf-8?B?MytvaTRXK05PTU1pc3lQZmhVdDRObkcxV09pNUtWZEJDVmRBOStyOGthZzln?=
 =?utf-8?B?cFV1OS9ONXVrVTVOVi8wVjVseE04VE02RzdOUERZVUhZd1J0LzVEWGx4SE4z?=
 =?utf-8?B?MFJpWGsyL2FOWU5DbE50WkZyOGJwTld6d0FtN0U2OThKTXJaTkJHaXRzSjR6?=
 =?utf-8?B?OXRkejBrQ29ldDMwYlI4bGkvWDlyaEJ5cUQ3VWpoREFPWEdQNFUzV0l5eWhF?=
 =?utf-8?B?QW9JdkJjanBxdk9mMEQyV0RrU3pXNEIxaDJhTnNXcjdFd0puWFBSdnJHQ3hC?=
 =?utf-8?B?YVhzN0drazk4TloxM0hxQWNvTWJCMENGVmJmZ1JBQSt1ZGNiNGREZUFQelRG?=
 =?utf-8?B?Ulc4THdiRHV4LzdVSHZHVTQ2Rk9GRWs2em5DektrRzhDNWtNenJ2US9MV1F5?=
 =?utf-8?B?TmNYMUk2WDNqcDRXM1orWUF3VC8rS0tZSENHSVM0VlNXNFdKRWU1MUVuVW5n?=
 =?utf-8?B?R3JBY1FoSEVPU1p6WVA1WnVienR1UUtseHVuSVNreWR2bmVDcVpZNmVPVjBm?=
 =?utf-8?B?SzczMitQWDY2YS9nQU1jUXZ2aUlaU2VCbm93Z3BWUDFBdkxMbGVXdDlEeUwx?=
 =?utf-8?B?QUdpZGt1V3lnbEwrNmxPd1Y3VDVIYWtLNXBQZWRaRGlVcFlaSHBjVkhSdmRk?=
 =?utf-8?B?Kzg4QU9DcHRHUVA1ZnhSVDNxTS9BajhkT1NEb3RqaHRKd0hnQWxRc0ZkUHlr?=
 =?utf-8?B?MUVYVXcxNmlEZ1JWSVZCZVNHdzBYSzRPQU9OTjdUT0R4ZW04ZExndHh2cldy?=
 =?utf-8?B?VTBDVUhGOHJDVGpzNFlSaUR3TkFtb1haYmxXU1pXMnVxR3hDMXprbFE0UHdj?=
 =?utf-8?B?ZVJSVUEvOWNoY2RMdlZIYmp2MnFEKzVCbHBnZHY0dXRnWHE2MVpSN2Q2OE1K?=
 =?utf-8?B?bG9YbnB6cGpZYjNGbHoxT0NUNnhXbHdwaEg5cENsdGsrMFFkV3owQlBqYjJN?=
 =?utf-8?B?dVRyQW1WaVJEWUMxdFl6bjIycUFpY0FUV1Q4TnlURDF2UlBRS2xqNjFJRS9I?=
 =?utf-8?B?dlNrY2FlNm5STlptK3ljYjVSd2ZyYnZLcUQvVDczbzlCWlZPOFV1TVFXbExx?=
 =?utf-8?B?bHRCWnVGOFAxTDU2dnJqL2c1MTZhQ2dSTkNNaGVVdjFZNFVoc05kVFAyUHBX?=
 =?utf-8?B?ZmRPanpFQU5FeTVGS21pTk5MZ29IMzJOblZ2N3Q4cS8ydGRhZko0Z3FKTlZC?=
 =?utf-8?B?emJkWHJ6eWpxcFZianU1NERhS0YyTTNibEZySGxYTEZ0dSs5b1NMTExaaXlT?=
 =?utf-8?B?R3JlQ09wV0JqY3Y4dHZ5bkhhQmFjdEgwbWgxdmMwZTZpMUE4eFZXZVNrMkJy?=
 =?utf-8?B?N1NVekxPanQyYndoVE9oSXlLdWkyU01aU0dESWhNUWI2dld4YUgycnk1U0R4?=
 =?utf-8?B?dVcyWjJGQStxMU1udmFHK0xsT2hQSFdyMmdFSlQ4a3JOSGMxdmZpVjZTZEwx?=
 =?utf-8?Q?ScBqP9wUCYY6hV4fvCXBX2NCaFA1ZxEu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTRhRkVqdjVDMFNyaG5CdVJWZE9NVWNsYjFESzc5RjFEOHF2THVxcU5IeE5K?=
 =?utf-8?B?dlI4TGwyZW5DK2tPcnVURjJRcEt1cFIwY2tVTTlVaHRaMnc4VXNlczM3cmQ2?=
 =?utf-8?B?cHBMQ3VzNitmK01lNEZBdDFYVHhFQnFqQnh3bzgrQ20yQ01TQUsyNEVzMndP?=
 =?utf-8?B?RnBlN0ljSVhtYUZJMW5LM09FQytOcm1SNUpWS3ZQSVpHd0U0d1ZXbFdoWW13?=
 =?utf-8?B?OEVHNjE1eUh0eGNBZ1pTeDRDTzZHclVCWEVZbHBsa1oxanRpWU9KVUZsbnFP?=
 =?utf-8?B?YjNBR2dwcEtvUkpxZTROT0FmRDcrdGp5cUZ1NlUzRWJ0WG12QStPT1RhMlFG?=
 =?utf-8?B?OTJJVHpzbkQrbTNaaWlSMEgrcXN5Z0Q4akZlOHpJRkpDRmJjaXV0Z0FUR1VG?=
 =?utf-8?B?SXlTRC9pblRGZXV5dG1ZU1FmNzVtL09TSVZpVERQNTgwdTdxSTAycE8xVVZn?=
 =?utf-8?B?elEzQnM2VngwZVdTRnM0UUVQSTVzeGg0UUpkdXRoREtiaXppMU5xNmtvN2dr?=
 =?utf-8?B?Qmw3Zlppd2NNNGZ6UGRGL0o2c1Job2RzaEljYnR1V0pHY0FXNHhOdEpsZHND?=
 =?utf-8?B?R2I4a2phRjIxNzlKTzBhbytqRHFMZ2dWT0N5V1RzTGdBYWxlSVIxRHJyMzZV?=
 =?utf-8?B?Ny94OVBmTWNYbmNtWnI2aFhWR2JxemYrc2ZrbkljVXR5ZVdKUkJTQmM0MVUr?=
 =?utf-8?B?bTZRVllUWHRxa1VmQ3crNzVZUDRtWXI0K01KWDV0R0RucHBCU1FobEhhQmc1?=
 =?utf-8?B?QTVYcCsrQTZvUjRXN0lpYjlCZHhDY0FvOCtUR3prcThBTmVGajErdThZNFVE?=
 =?utf-8?B?ZjMzcmxIUWJ1SEJSemJjcElxSUdoN1RUNE9pYnEvYTBreTRXaW9pdElTWWF4?=
 =?utf-8?B?L3Y4aHdwS2J6cmpLc0tVN0FJSDlCdFI0M3paQmNDRllsRmpYVXREbnhJbERB?=
 =?utf-8?B?N3lnZnAzTUg2S0xGMFhZdGtmMURqN0c1cEpUSW1KYmM3a3VMbThZSk9nRlY1?=
 =?utf-8?B?YzlmZlpMOElnZXpkeW42NGZ6aVovWGpHYStYUnhlUjFYdkY2OXorekk5RnVW?=
 =?utf-8?B?MkgyUThIbGdydVpmMHU0UUYvUHV2bDR4OVl0RDJ2eGdaWXVlSVV6K3gyMytZ?=
 =?utf-8?B?emprQ1hhQk9RZCtROGZPdG5WTVExbGRmRDE4OGxzOGowaU81N2MzVyt0cExE?=
 =?utf-8?B?b0JURnlwUThVcCtTVWh6MmRRc0tmY1JsSEorcDNKZlpqOGx3L0lOWDBGRUJV?=
 =?utf-8?B?V2V4SXlvZUFxaVJraEdiQ0Q0M1NCMm0xUzNzL2w1Q25kWEdzL0xPVzh2WkFq?=
 =?utf-8?B?Qk9wckpQVFprY0wzMVRERXRhNEtrTXBiWHdUWDI2S1dUUDkyTVFFRVd3VjYr?=
 =?utf-8?B?UVF2RlMvMWRWZ0FIQ2xMZnM4dklRLzJVRHBya296UFdnOW4yYmpWVSswQW5s?=
 =?utf-8?B?NnI2N1hIbzROT21kTUxLMHJaZ1JRVEJXc3BEWGMzVDUrOTAwZFhBc0d5aEpj?=
 =?utf-8?B?NklWODgrMmRVTC94aE5wQW42ck5HQ2FuUTcrWS85dXRicFd1UXhBeUVtNkRw?=
 =?utf-8?B?WWREd1RSZWRtU1lKK3pjVFhBNS9HWmhkNEZNK1FNeU0zek8xVTR2Q1pLai9S?=
 =?utf-8?B?UklYRTNoWnJxWmRINTJ6MklqWHVzcmh6VVJIV1FkZVoyblhpdGdFR1U4MEZ1?=
 =?utf-8?B?eWJQTktDclNUTGwyV2xTNlVxSzBaaUxtcm5BMzdEMGROSmFLczZ0NjZ3T2tB?=
 =?utf-8?B?Q3U2a2E4Tm15aHdhMGFXaGM0eUZiVlRmQkZ6TjhBb0hUMHNZT3pBQWFsaTM5?=
 =?utf-8?B?U0RLWUxMNlBTdHRydnlYTGxXNkR3cTI3LzFGODMzOEp0MVVzNmk4MitMSzJJ?=
 =?utf-8?B?ai9HQ0NpRDc1MmswNHVydU9oQmVsN0xuVlZUTXhpWUh2TGhZVUJmY1ZVU3RG?=
 =?utf-8?B?MkZnMnhKcEt0Zzg4enV2a0NWWFlWdEx4blFxQ0NzWnh4WkpsSHBpSmZqY1kx?=
 =?utf-8?B?cE53YW9Ga0xOVHFIT1dDMjFKbnRTUERPdWJyNHdQUVE2c3VobmlNa29XaWtt?=
 =?utf-8?B?U1hYZGdNMjc3YnMzaTZMcXd0RDI3NHhWVHNpME5qWElkcHVYMEV3b1ZocEpJ?=
 =?utf-8?B?cXhQY251VnZ1Vk1DZk9SbE1yY0ZKYUdWcjVTYm8wZ3ZiemdiLzR4bXdhMDh5?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8ebaa5-f1cd-4d19-d50b-08de0aff93ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 08:56:35.6124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P16R180ATMsk4hqpmc6vNsJN1i0V1JpHHJajvLfyT4amsMpxPqG0GMr17Qi3hymLnY6SnKGut49ELBgU1hHjS5pP0m4zXY1Ittxj8sutcGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4806
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

On 10/13/2025 7:51 AM, Sivaprasad Tummala wrote:
> Previously, the AMD power monitor implementation did not enable the
> timeout, causing the lcore to remain in a wait state until an external
> monitoring event occurred or an interrupt was received.
> 
> This patch enables the timeout-based exit condition, allowing
> the lcore to automatically wake up after the specified period.
> The maximum supported timeout value is 2^32 - 1.
> 
> Fixes: c7ed1ce04704 ("eal/x86: add power intrinsics for AMD")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> 
> v2:
> 1. fixed asm compilation error.
> ---
>   lib/eal/x86/rte_power_intrinsics.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/eal/x86/rte_power_intrinsics.c b/lib/eal/x86/rte_power_intrinsics.c
> index 489ad3983f..8a5f222aea 100644
> --- a/lib/eal/x86/rte_power_intrinsics.c
> +++ b/lib/eal/x86/rte_power_intrinsics.c
> @@ -89,14 +89,14 @@ static void amd_monitorx(volatile void *addr)
>   
>   static void amd_mwaitx(const uint64_t timeout)
>   {
> -	RTE_SET_USED(timeout);
>   #if defined(RTE_TOOLCHAIN_MSVC) || defined(__MWAITX__)
> -	_mm_mwaitx(0, 0, 0);
> +	_mm_mwaitx(2, 0, (uint32_t)timeout);
>   #else
>   	asm volatile(".byte 0x0f, 0x01, 0xfb;"
>   			: /* ignore rflags */
>   			: "a"(0), /* enter C1 */
> -			"c"(0)); /* no time-out */
> +			"b"((uint32_t)timeout),
> +			"c"(2)); /* enable time-out */
>   #endif
>   }
>   

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
