Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DA7C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 07:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D60784021E;
	Tue, 15 Jul 2025 09:47:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 051224013F;
 Tue, 15 Jul 2025 09:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752565657; x=1784101657;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=wKQTlT/HVBa1gF95XFwZN3HWU5SsLTcfS8VT8FBqBIw=;
 b=LxpIn+t5/SFL1H1OZENsAqLmyJmCtDtJ0EjkdUdw6K1uhehBi/W86n+5
 LNPICxeg6d0qVhh+DCOk0ewLgBzeOGuuXW0K1A34ebztx/YB3ZJnAzZha
 y6MWV4xmH8Vx9u3iaPqpKlHTYlX1iSASV7mb39DAQKaQYz3wCIu3uIjOQ
 F+au/TkoPrguqVio9wvshUVrXIHqiYJsdSjHHwVsfEfKPWItOUuL2HJPb
 nOeFxtH+02hwcdhe/r3AjMMQasqZs7M/yLHM8XnpzCmpLTqB3VAvGZt5v
 gES1NcGJ7VMoRZufX6B3dGE0o3NIDNMDUTyhN6Gwc1k/4k2JgjMwo6q1n g==;
X-CSE-ConnectionGUID: YBRneyxlQhaGuFyTzcJYGA==
X-CSE-MsgGUID: 4BjghNSlSa+LVywsf9wRYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54862036"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54862036"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:47:36 -0700
X-CSE-ConnectionGUID: SyMY99mpR9yAlwvkR0PuKQ==
X-CSE-MsgGUID: +w6re/0KRW2lRhpt61Rdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="161463524"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 00:47:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 00:47:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 00:47:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 00:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEJdo5k94Fd+agx2INIHKWXkEhKO0YotNOJAhj/ka3sJtEH9mZKGR/qfKafEBY7kTIWP3KH+ayNCxpEGKcyXKyNhNMKlXZkHJFxmVsxAhMOqRPky+ajJR0LDUDGLWDQRIyCrz7L9dTVGPV6xvi5AvTuIo219lszh9P23RPW8hDdPbes7rHOF/mMAfRCr/rnnbcvoNa80su9L4ODltvSAKFf4Q0uHV4h2iz2+5mRdVrtvZl5mSN9XDUqH0O+tFos6tkK99FMf8O7lGg4RMBOQWXv3DLLqSLDlvPMU9gWKhg4fgnNhn8XLqLnL4yuig5DOPssOtrjO92GlpzUziWVCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkdODYbLWd7MMlsooWrA9gbhFUfn/XRxtDoxuqCWbPU=;
 b=SsL/8a5NsvjKQvOQ4I0u3Bp5h47AKB4fMHOHseKEdTQwiKSpPO9LxWXZEiGQTxjyqUZYEPa5PKiatYxnGgUzrvoxeBaSSdhyRf7CEhBeRBH9E/Y3n0hIh7S7WNT69YOguMwnd416PhfYNaqaZqQw/jpJijn/5nxZEbf7IYu4EYnVexnUwV2hgP7Gpnmj4FwwskBwsMoHvIAiuRi+lCpN7+2ul+459LfMeYPaZ/9RGdiC4HT3kZffDBMQRHhTEgkbYBDVEgK4VoY8Hp1z2cRPdwIDPzw7Nnc1lWx83x6vwkfBkfwYYrn7JWpUDY5uJpZPHZ9IrPnQOqadAv8dh2jx/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPFCF54B2894.namprd11.prod.outlook.com (2603:10b6:518:1::d4e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 07:47:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 07:47:32 +0000
Date: Tue, 15 Jul 2025 08:47:27 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Dean Marx <dmarx@iol.unh.edu>
CC: <dev@dpdk.org>, <techboard@dpdk.org>
Subject: Re: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Message-ID: <aHYHj9vtdXm8MgY_@bricha3-mobl1.ger.corp.intel.com>
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
X-ClientProxiedBy: DB3PR06CA0036.eurprd06.prod.outlook.com (2603:10a6:8:1::49)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPFCF54B2894:EE_
X-MS-Office365-Filtering-Correlation-Id: 754c1bde-e538-4fdc-26d7-08ddc373db4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm93WFJuQnEyblUyZmUvRDJES3hwaHFZSUk1bWdCd3pxMVNTS1dEV3FzV2Ra?=
 =?utf-8?B?UUhKVFdaMElOdlRFNndUR2w5a2NJelh3OHBJSXJ5Q0xrSmRLN0xpS202Zmdx?=
 =?utf-8?B?U2dEd0M1bzg2ZDBDUS85UnVqOCt6YUM4RHhrMjh3cUlwTVk0U2RxM0Z1UkJa?=
 =?utf-8?B?b0hhZE5DbHlEdGVxN1VJckNQWEp2a3FBaWNRY2Q0T0NIRHpJQzNLaHlCbFh6?=
 =?utf-8?B?c2tLbUhTYnpXYkxmTnVaMU5vbHNBWmJZWUhQUVdOZmtKRnRxS0xvY203NTBM?=
 =?utf-8?B?QWJ2aXNIdit3L2xFUUFMZVpYeWFpc0gzQk1xWkY0QVpUS2JFZSt6OUd5ajRr?=
 =?utf-8?B?MGJIY0JmVlF1RHF1Skp5VXBYR2JqS2x2QzNaOWREd1NrT1lzYTJBTk9NVUdB?=
 =?utf-8?B?T05ReFBlY2dxdWhIUm10SkZoNUNieStQOXh1OW9LRWZjMGJJR3BqeW5pM1FQ?=
 =?utf-8?B?b2FxcGQrbG54T0FIUEdrNGhyZWczRlBTZGQrZE5WWjZHajZObEZSbWI3NEl0?=
 =?utf-8?B?N2d4bjA3N296bE83NCtjbFl4RVBSNk5FV1JiengxUS9xOWZGNXI0dFlSSUFu?=
 =?utf-8?B?dVFGUEY1WTk5TnBaME5qeTF2ZUlVNm5HV1RmSU1DWlRVTXZnc3pMTzBpZnli?=
 =?utf-8?B?amVtd1YvZ1B4dnR6THl2MnN4b2pIQlhWdTVPSm1sUlBLRVVuckd2eFNONjZ0?=
 =?utf-8?B?Y20rUURjVG5jVjZjT2M0MEczeTFyRVZ4a0IvQkM5UWkweWlDL1lhRFg5cVRR?=
 =?utf-8?B?K2RQalBXTzVUZFgvYmtGNnI2ZWhWR0V0ckF6KzB1RlhOVW1DVDUza0RuSjI5?=
 =?utf-8?B?aXVSN0ZrSjZyZ1FJajdHTHFxNmQvWHhkOWJrVzJ0RzUzamVmVktSVXdMU2NN?=
 =?utf-8?B?SEw4b2lGa2VWMHkrSDFJeERNa28ycmUrRmZiQ3pWN0E5WXJCdjlYcld0WnNB?=
 =?utf-8?B?OXRCMENPdnp2RG80UytZdUN0eXNpK0FUYUF0SnZ4bFQ1dU9rZ1UzSG9Cbm12?=
 =?utf-8?B?ZU9Yb011bUtXMHF0Mkh1RzlBSTgzRWZ3cldTcXJDTEI4LzJLOHd1d1FvMVkr?=
 =?utf-8?B?TkxiZUVqWkxaTWVZWGk1VU1vbDJFUE50SXM4V0kyOUtqNEk5RkxGVkJIbXVD?=
 =?utf-8?B?MGtWZnVOV1NEVW5CaVdZNUdndjdaZ1lCSUZYaHJkdDBoTnY5dVdMMDVsanJn?=
 =?utf-8?B?cFVZWXpZZGtZUW5qUi9vTjZ4VTYyLzcybExOU1dKbTN2MVZ6S2pvcFVuRHdI?=
 =?utf-8?B?RThkT1MrUFIrTGZHenY2RkIxdnEzUXc2Yk5LdnVCMVl3MEFVOHNicUJEYUZU?=
 =?utf-8?B?c2JLZ3pjRTBFYU5qUEtUVFM1UUhtYU5rM0xuY0ZUbXlUTEVoa2xncWtUOXZY?=
 =?utf-8?B?TkZXTWNER08xbVJaN3k5eWZkVUlQVzBqbThwMFJqaDA5THpwVDBRczlaTUk4?=
 =?utf-8?B?c2V0dldUM1gxUVo3a0ZzVVZEd3F6cTVNR3VyTk9Vdkxha0h2b3BPRXhzeTh0?=
 =?utf-8?B?bDgzUDFpOW9PS1hGdm9HQ0U1VmpCeVlvblg5Vlp3Wk1xanZRajBUL0NzRVhq?=
 =?utf-8?B?cVR6YW1TT1RoTzlWOUxiSm91bEFuQU5nU2hrZDk4YkJNZkEydTZtT0tqNkZS?=
 =?utf-8?B?N0VWUEZEZ0g5OWMwUkpBbnRueVJVTVdjbTFtYjI2cXpMU1MvT29YKzZlWjZn?=
 =?utf-8?B?MGtMdWQ4bUdwalFuWXVQQXhPNVRjb1VoZUlPWmtCb2lqUXVkYUo2aFNhUFdQ?=
 =?utf-8?B?aWs2Qk9OMzlZYU4vcHhOQ3V1SDRhMG5NZWV5TGltdHBQRVpTRjNxc2VBbWhJ?=
 =?utf-8?B?UVBGYUp0NUN4WHBkclYyUi9waldxOURETlBOT1g0VGVnME5QVW9BN2Jkc1hJ?=
 =?utf-8?B?elh6STBxNUYxYVlaNTRRRHNMeTg0eWpxL1BnMnVsSnpnU1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmw5bUpxSHlWVE56ZmdCSUp2WEpPVHFVQXMrOGxmTUdlUksvaE92RXVEQWow?=
 =?utf-8?B?bmpXd2lVK0lia0lENmp4ZnltdzBsYThYUTNPWUp2QkwvQXdqd0VXR3Qwa3RY?=
 =?utf-8?B?TWV6cEZDdVJweEVhUjYzWW93RitPd2k5Z2Yyd0FKbEFlc1ZsWlRZM096SWs2?=
 =?utf-8?B?WU0rbEdkMGF3MkJBUVhSNDN0L3U4WHpLWE9kNjdoelNXdzRLZTBjRTd2UEZx?=
 =?utf-8?B?Zm9aclZJOEZWblRCem5jdzhEdXo5Yk5ZNlh0Y2xFU0h1VXBJN1hhdFppQ21D?=
 =?utf-8?B?TGxNalRPQm5TN0k1YXZyQ1M4S2pPU0wzWVp4bVZSekFWSVdRd252NEhTTVlS?=
 =?utf-8?B?RjYra1EyWTQvaDk3bmNEWnliWnUyZFI0VEo0emlSTm5SUHpRdkFZbFBqem1X?=
 =?utf-8?B?WHF0bENMdHRMQkFmQXRKZjZDSWxHM1J1TVVXcTArc1dkb0RsdlNLNU4rWEdp?=
 =?utf-8?B?WmNwaTVSakE5eTVGZ29XSXJkbktyaDdMbXBzMGxoSzU3RmhFVEZZWEFUQlQy?=
 =?utf-8?B?SzQvVWJsdUFndXN0YmhBeFZ5NG1xNzVMT0M1ZDQrUFJtMHo3dUpKdVZ3TDNT?=
 =?utf-8?B?U1lha0ZDZG5FZ3dMS3RJakp1eFZGRDdkc3BSVmZSdjBMNWxKSjRpMU1kNGNN?=
 =?utf-8?B?MEZFbEVNZHBiQkI2WlcrdGZUWVgvWHEwSG1nOHk1SjVFS3JPZVBiZllLWDBJ?=
 =?utf-8?B?d2NablVtV09YL0c1Q1hIVWFpK1pycXczRjhmY2Fqc29LZ3hiRHlJbm5vYU9S?=
 =?utf-8?B?a0xUNlRmY2owaThTZEEzbUNReFpzSWJWQkxxS093cU1BNzlWZzg5UDNOYWUv?=
 =?utf-8?B?R3hLeGxHeTJiL1BnbFNyeCszblNRYll3TllGbkNWOTY1Sk1YTU5MdXlzZDNm?=
 =?utf-8?B?c09JbzhUbXFmaUZMenQ1OHVJbk5WYW5NeG5ub0k5am1Ma3JUZkpLMy8wejdo?=
 =?utf-8?B?Qys5dmtBaGF3TzRCVmY0WGU3UVNqY1V4UzRtNDRBeTF4ZThHNVNUWXhFcWlC?=
 =?utf-8?B?Y3hYc0h2QVIxTnNDWmVDTmJBcTNBVE5pdjNOemlJRklmcXNrRGpCdDJHQm40?=
 =?utf-8?B?alovcFFWeXM5QkNISWJUREIwcnZBa1l0a0d6bEFiamJRUVZIVUI4Y1VRejZP?=
 =?utf-8?B?V0FPTm9kZmxGUExIQUNSSlQ1Q2VCa1hEWFkwOTRiQzFaR2UweVBsajFxZG9i?=
 =?utf-8?B?eXhmUUtoNSs1VVppd0JsV3M1SzdGb0ZYSmdYbnF6ZkRYeFFvNVRjdHZsSDZJ?=
 =?utf-8?B?Mk1QV0RXMUNPT29xNUcwaUtUaXpjUzI3TVlKRnBGdTNZdDhKYjRpRWtnN3pY?=
 =?utf-8?B?cFVRNFRSY0hwOXpQbGw3cFJJejZ6VzNqMnc1NG1UYTNaMXJPemt6MjkzaXZm?=
 =?utf-8?B?U1k0Y0pITHhxSHpKYXdqei9oM1dJMEJsaEtmYVlvMWdud2dqYU5Ka0ZQZzVo?=
 =?utf-8?B?d2FyazBBeHhERGt1aWo3ODhuZnp5SVFwUzZ5UkRDQ1FRZ3FvV0k2T1JMc3hy?=
 =?utf-8?B?bVVwRm41UDZDUXl5UmpmZFIvVTBJbTB1Rk96bS9NMjUrZVVwU3NWdDVKYkhO?=
 =?utf-8?B?WjZRektqcTQxdjlrMGo1WHNoTVVYNnJ5NEVPUWpQT2o4YXBXMlVzVDRoenpW?=
 =?utf-8?B?U2tCM1IxYXA5UU5WSDJsNVpLRG9iWnFoWGhOTXVTcUF0MFRrREhoSGlTdVlS?=
 =?utf-8?B?eTBMZ2t0dWhOa1dlY2p6d1BoSzVtUk1vV2xTL00zREtVQy9RRXFXYnBzbEh2?=
 =?utf-8?B?d3d0T0N5ZWc5SklXUktJQlJkeXJXMS9PSUU4Y3VCRkFXRzAyUEFlcEhzNDh4?=
 =?utf-8?B?TWtrZkw2ZjM2eGI4Yk9JeVJZakxIK0ZRblJBQTljZnNOQnJ1WjZyb3Frendn?=
 =?utf-8?B?eDFrMXFKVE43dGlsdEJmRDVNYjhEeVRDWFdOTkx2a2lZQzQ3bEx2b2cyYVpy?=
 =?utf-8?B?ZHdTVVY5aEFGTjl2SnJHampTOVBGZzdnc1R1ZHk2aWpsdXlZMlpqT21BM2hz?=
 =?utf-8?B?cXhHRjcxL0pGYnJKdi8wb1dUZVpwQ3o3ai9JVGRVQjlhLzBYamx2dWFMUHRi?=
 =?utf-8?B?N0tCOUFuY1lHeUEwZlRFNWRpT0dRWEVlaVp3Sisrd3NsUVBmT0lDRWlNREE0?=
 =?utf-8?B?U2VlTXNPZUlQZWcrVnYyWitRMTJ5aVhSY0ZYQ2pLTnhvcUVLOEhkaDhKOEVS?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 754c1bde-e538-4fdc-26d7-08ddc373db4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:47:32.7007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mr9Et5K8CaLn+nZobwgczyglBFLoZ/ZxbB7j+s7dhx7meFYc0ncDvtiAkbFJMBEbuVzDXGKzjPxYB5zJ5xSKhwxzhp29blE+FtcIt1r3XwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFCF54B2894
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

On Mon, Jul 14, 2025 at 04:09:11PM -0400, Dean Marx wrote:
> On Mon, Jul 14, 2025 at 9:30 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The behaviour of VLAN tag stripping Rx offloads is unclear in DPDK, and
> > not very well documented. Even the documentation that does exist appears
> > contradictory.
> >
> > For example, the doxygen docs for the mbuf flag
> > RTE_MBUF_F_RX_QINQ_STRIPPED says:
> >
> >   "If RTE_MBUF_F_RX_QINQ_STRIPPED is set and RTE_MBUF_F_RX_VLAN_STRIPPED
> >   is unset, only the outer VLAN is removed from packet data,..."
> >
> > but the docs for RTE_MBUF_F_RX_QINQ says:
> >
> >   "If the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs
> >   headers have been stripped from mbuf data, ..."
> >
> > Without a good definition of what the correct behaviour is, it's not
> > possible to assess and ensure conformance across drivers. Update the
> > documentation for NIC features, ethdev and mbuf library to all report
> > the same information: that VLAN strip feature is stripping one flag, and
> > QinQ strip feature is removing two.
> 
> I'm working on testing QinQ/VLAN stripping features across PMDs, and
> so far I've found that our Intel devices are capable of QinQ
> stripping, while our Mellanox/Broadcom devices are not. When QinQ
> stripping is enabled on an Intel PMD, the test packet is received with
> its outer VLAN layer stripped, but the inner VLAN layer remains
> intact. Thus, the doxygen example is more accurate for what is
> currently supported. I'm also running some tests on VLAN stripping
> behavior, I'll update this thread with the results once these are
> finished.

Thanks. Let me know how the testing otherwise goes. If only Intel NICs are
supporting QinQ, then it can't be that widely used a feature yet, so we may
be able to tweak things a bit if it diverges from what is expected.

I also wonder if the definition of expected behaviour is preventing other
NICs from implementing the feature?

Can you also check with VLAN stripping enabled? My biggest issue with the
behaviour description of QinQ strip only removing outer tag is that it
implies for QinQ traffoc that VLAN strip alone should strip inner tag without
removing outer. That doesn't make sense to me - and I'm not sure if NIC
hardware supports such features of removing inner headers while leaving
outer.

/Bruce
