Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9543EA8114
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09C4540648;
	Tue, 10 Feb 2026 14:37:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 26416400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:37:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770730625; x=1802266625;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=cQLmBz6dsOwprN6t/0193aDYMzzJRwtVMEaXKmVhmlg=;
 b=VuZP17QVGwFjhnXBprNHr3u7f2HC647srBylnLmSyNYp/VSPr4g8GOWv
 u5FQ88MFW9Q3LBRfcOiD8ZbiTQF0ZDl7K85M211RxV8L6GSL4kgrYRfjf
 CaEulOWabwITTGzAclDYyM41/SuswlzXWwEQCmpVaOF3WyYNgLQF3m3Id
 FgP659AbHvQVS3i1JWSth8yflcOfTgvD8v7tPpLGPGfoZp+uFrC3jawVR
 mOVYzmZ0F1wD0r/wig8kkeOpvvEe/8zTy4rZljR4HxEgMQwMdAaRocfFD
 AJ4n1M+dmkwuUfX/zNXVD449YSKyYUE/4nGI+dTp/UG+hWxILXn+ZJd4i g==;
X-CSE-ConnectionGUID: jQgNlzWSTPam7A+OAB5AYg==
X-CSE-MsgGUID: CZxMJY5sQNme9fmaEWyhxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75703340"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75703340"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:37:04 -0800
X-CSE-ConnectionGUID: Fl3kZr3iTj2Oc47iIxD1GA==
X-CSE-MsgGUID: ObNv/VR+SCWJjP3rKLoWHQ==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:37:04 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:37:03 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:37:03 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:37:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXU7zglDtbiyIqDPpXwGw2c1Fun52hbM/jjh3ehn/TpJIEzV0tjV+zMN/55O2EwTHk3dkTgP5UE8Bjj24HS2Ax4jKvmuOGgAP0yyiwRyJvwjI5d2D5gfa/shHkGBheDAdRHxyokpfqKM4AcFAONVXZQC+yVRjdXxatCAzgYjsBBAu95uDHH0p3lRIBuEEL5+GmImLEB/PPFOQSI5566btTf4uIUJK5DXusqWS0KBrUbKT7Hv8e7ik8GWcBwgiMXdwkcK5pYwSIoAoMM45Ml81Ahn1WPA7rsYwuUdfu/quD2XFHRR4pFcgFuU1KH39/fEfMSCLIgHVVRmKjCYLpUBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoTy0sanwUa2VUkTUXs4EsTydORCoLLlgL1sa7fe+eI=;
 b=MZxskIV/acePPLejinRg8oakqZ+Gg7SMldt7GrF/WoKaRq67JyVAyXDI3p8L0oCJEyA8t4x7aCwhaRgWJ37V6WNz9FRE+D6245i89JQjk2NXmDH7upcl5NCaTZ2L2SWIkFbPo1Dr9ZdVmXcSWQs0yRz3fFNZbVr4oAWmbvRtak71o/2raSVK69shURmjwIKHHOlZsmHKc8Fd+tXRPEmYw80Ncm5IN10tAvtYXsYY9UpxuObNHD6nF9Kq96oc2r+7P+8vGrjWKWAHjsDJ33OKohQg8zfnbje2Lydw1ohZ8KPnSAjBdw5yWOK8TpmG1PiNZ4MimO0FSW4+MgwuhIlnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Tue, 10 Feb 2026 13:37:01 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:37:01 +0000
Message-ID: <fbe24b80-d463-4dda-92ec-9c8a8f702a63@intel.com>
Date: Tue, 10 Feb 2026 14:36:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/35] net/intel: mark mid-burst ring cleanup as
 unlikely
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-23-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-23-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0323.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 9716d4c9-c411-47bd-8332-08de68a97826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWJGWjVCRGR5OGRkSUtZYTVDeFpvNlY3V0laalhHYTdrNW1la081M2VLZ1Zo?=
 =?utf-8?B?VE52ZXQvbGVNSUR6dStuSFR6Ujk3QzlLNVBubzhGcU01ajcxZmxKaW1MQUZK?=
 =?utf-8?B?T3RIeGRDUFZrbXpTdTlHTUQrTmM0M2JuNk43QnMxTjRkWm1BYk1aWS9GSlpP?=
 =?utf-8?B?d2swMjFwVVZ3TnpycnUxVzZtSG1Ub1hJNXBCMGlsT3VXWEhUMEJmWlczUWxY?=
 =?utf-8?B?QnoxdXUvMk5sQW9Ja05pbEJxSytTWGc1NXJrZlIydW1RY0lLaUJsV3BqVCs2?=
 =?utf-8?B?cEZFSEVCcDR3bXVBS1hNT1FheVpjQXRQcjNXYis0bXlJTjdLOHozQU9PdkJW?=
 =?utf-8?B?RGJjODg3RVJabVduWC9KMGI5VGMyOVliaE9zaFQrV3VsRXNndEx3TDBqYU5V?=
 =?utf-8?B?d1Y3TnV3VGpQKzRyaUlvNVBaTmtGd1RCVkVuZExSdkJsTE02b25nNHp5cWUr?=
 =?utf-8?B?SWRyRW9jbmRMUytybmtYdEJOc2hLRjdNNCtjM2NkVzhOUFNMUEF3TFduS0lT?=
 =?utf-8?B?Uk51aG53SUttVGVMcGNzbjdObk0xSEJMSXZPZGMwaE54K0c4TWFuZEZtRFdl?=
 =?utf-8?B?dW04YXh6ejBJM2cvWG1iUUtCellzcFEyZ3QxbHJyaDEvTkY1eGhDWXBJMEFD?=
 =?utf-8?B?NlVUU0ROYW9WZllXYXZUMWk2UUhGckx1ektNVjFMZGJ1Y0J1M2NubkJKY1VH?=
 =?utf-8?B?UUdacnpuS1hWSkZsVEVEbitGNWVqQW5TK25OOUMvZDcvOHNYNUtnSHMwTTJu?=
 =?utf-8?B?aEZLTTVXQkVuMlQ0bDNWWW9XQjhrVG1YYUFoL09saStqN0MvY2liV0p6Vmdo?=
 =?utf-8?B?NnpaUW5lSFpiUkFZUGJmVkthSGcwUS9YZmtCOVZEekdnSTVtTDhKS3o1cUF4?=
 =?utf-8?B?YkNPTUprUkJoWkdKYUY5bFV2N3J4a2xPbUgxOHBaWldFdENhVi9ldkdPTnFX?=
 =?utf-8?B?emtZS0FkNFF3N1h1L2Rkc3FLSXFlOEVEUmdJbm9mV0kxUkVhTXNwUFp5akVK?=
 =?utf-8?B?dDM2ZVJXejFsTFk1c1FZcUdmMnMzRXo4VGtRd1N4TzVZMGxISS81SmZrUm1v?=
 =?utf-8?B?bGd3djdwMmVHelFONUIvOWZ6QTh0NGw0NjFIR3dwTStJMXN4djYxYkpzWkor?=
 =?utf-8?B?YkpNUFFUamd6ZDJsOERkQ3gwVlhVVzdMckZUb3UxL3hVMkpueUhEZUUwTEp2?=
 =?utf-8?B?Q2Vhck9Ya21qT2YyVUlFT1R5cEdpTUk5VWN6RjlPMCtWekxyWHVTOWlldXhv?=
 =?utf-8?B?R3ZsV25mVkFTNzhZSTN5TVNxSktOUE9uOGtHUld3cUdwTUYxYk1WQWhwWldX?=
 =?utf-8?B?VDhEd3NoZklDc3d3cTdwZUFQQ2VDeUdUdHl6VmxvZ1BoVzlCQWJWKyszOElS?=
 =?utf-8?B?UHhJNUFDQit3UHNlQ3JtWEhZTjBiRTM4RkMwNmtSU0ZUQlJzU1JzYWRDcmJ4?=
 =?utf-8?B?Qk5pTlpHblUyeGNXSndFbTFQWTY4SGl5cDI4bm9yTEdybUc2TUZ0Nm56bXJj?=
 =?utf-8?B?dVhhS3dSWmJ3TXBZYVppTENnWGFCYjM0aUE5bEluc29YRS9MazM4YlgrdjVj?=
 =?utf-8?B?bDFlNTZFZWZDUjhia0xCWml2Z0ZRYmR0bXNlSVQxQlZ6NlhzT3gzTnZGREpN?=
 =?utf-8?B?dElUaS9wWTcvOHJneGdWd1ZUSGg1N1ZXQWpvbGZlWHp5UnNoeDV4blhEWU1z?=
 =?utf-8?B?VUJ4SkJ2ejhMT1FhQ3pwVmZuY1dTQmZVVm5WeFl3U0FHdkFWaytCNVFwUGhp?=
 =?utf-8?B?VTBidkhTVEh6N1BJdEZoRnJtQlRtZHIvSGpDM2pKRjQ2MTNrbG55MzRnQ3V4?=
 =?utf-8?B?bTRQelNNdVZJWE96RUoySTlsRlhWdFVmOENId2JHRHdudTZTR0lFSm9FR2lD?=
 =?utf-8?B?cGRxa2wzSUhXdjdlaTd6ZEZibEtVdlhKMnM3QWIxeUxvUTlYSFhsRWE3MTF1?=
 =?utf-8?B?ZmM3Y05rS3VxYzhSWEVWU0sxSmdFOE1TRTdLQ3RXWlpBTmxkZSt5UnJLZFho?=
 =?utf-8?B?UGoxY0srK3o4TmJOWHNrS2Jkc2pTdUV4a21NemhHSzRZbTZiQkJTWEJBeUNk?=
 =?utf-8?B?OFdPK2tHb1VvQ1R1ZkZaZThkZG84TGFRUTY4U0dMUDZoNVA4Slp0cnpJRVQ2?=
 =?utf-8?Q?mUcI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5hVnZsVVREVC9MVWxmcjhkeEkwcUlvQXhnSEJRak1GUzRiN0QvQ1IzU0Fh?=
 =?utf-8?B?a0xXYjFLanQ0NmtxSVM4bXJXWEh5V2loYnFMcjFMdGx4VXVhUElSYld6Qmx3?=
 =?utf-8?B?VTZPRndEU3JrdGo1a0pkNlp1RHJYdENwYlcwSGlrbzFZd2JNWE1xZXJ2N3Zm?=
 =?utf-8?B?bE83cDU5cXhsdzFSSzJyN0NvcE0vWFlQcUZoRi9VZFZRcEhCYWFwMDNwZlE4?=
 =?utf-8?B?VmJQZ2RKUEFnckVjcHpwbFBTaVhNSHhSY2U0Z3hlcE1NRVY3NE83bkdwZWda?=
 =?utf-8?B?d3pacTJBOW9veFFXVnlBbVBEYkc1NzNYTEVJaTdoTnNtUU8wUFhQV0J0M0ps?=
 =?utf-8?B?VVdOdFVkaTZIcEwvWjRSK1BzMzgxbWloZlVramVxSC9UZ2FSNkZ6THJBT2xO?=
 =?utf-8?B?czBHNng1NFhXTHQ4M1JhRUtlVGpQcmtiQjd3ek1OZVJ2R3VCSjFpTUxVR1R6?=
 =?utf-8?B?Mi9WV1RDTGpvTlcrb3R0aGxaaHl4S01hQU9venNqMGdMQjFoWHhzWVlwSFpa?=
 =?utf-8?B?WjRoV083UEVxSGJzWDNHRVhyZWJVSVcwR0kveEpVQktwRDlxTXhpVTZmZzNF?=
 =?utf-8?B?dHJHZjNEYWxnVzRBalpQSFhQMTNWeUxwWDFsVWtQMzhwU1ZNcm5WdzRPU1pV?=
 =?utf-8?B?dFdnRGtvNldtVnB2QTgwdWJ6Y0ZTdnVkOTI4cDdnTGZtWTFuMEdhTmkxK0pY?=
 =?utf-8?B?YW1URkY1UHhKd3VBMktuZ0hXbnVHQVVOTTdzcFZIV1RxNmhicG5WWStDNXpQ?=
 =?utf-8?B?RThXV05EaWJScGoyQlA2RldxRG90T1FoZENEZkdyV3ZsamZiMk9YZTA1Mm4y?=
 =?utf-8?B?ZEh5ckl1cnpsMysrUG8vSi9uSTJFZDVXTXBXMTF1ZVVoSytYTE9nUlk4TW56?=
 =?utf-8?B?QzVZVzI2andxVUo5QlFxU1hIdzNtbXFkSkpvRThReGVMblNJUmt5WDdQbjdR?=
 =?utf-8?B?eU1NTERvcFRHZGEvcyszSUtORURWaExEdyt4VFFIRjl1SGhMYWNBSjN0c0Vn?=
 =?utf-8?B?VWxlUGNRd2sxMks3UXNNWllxeCtYcUtOV0d5YksweVZIdFlpSVFVSGR1SFYx?=
 =?utf-8?B?N09peU9MYjkyTlV5d0pRMGpLNDNjdGZxdVlVS0tORERNMi9iWFdlMGNRbHoz?=
 =?utf-8?B?a1ZvNUhOdVJDRFBsYndGRko2Um1IVlU3ZEdybC9WL3ZXRWhFTFBVejZuQll3?=
 =?utf-8?B?VEcrcFZSK2dsQTM2Wms3U3RkMDRScE9FNjFOVlA3K3YxTWFCaWRDQVhDbkt5?=
 =?utf-8?B?WXdZS2tSeEptRGtRNzE3MW5KbUo5RVErWm55b29YOTZ5MjdXWEhVbkZLdmpN?=
 =?utf-8?B?UElUbUh3ekpnOTc3ZjZtQk9BbnNMaXNFMU9uUFcvc0RpSFY3ZDArd1l4b1l0?=
 =?utf-8?B?UGk4cm1LS0F3ekpzb3FaeHhtcUhKSWNGTW5wZ3lEQzNKQjRiQ1Y2SG1aS3cx?=
 =?utf-8?B?UWlPd1hHZ0M5N1hBdXRwSWx6dEkxN3BrSWJ4bGxlc254YnZXRStzblJKS2Iy?=
 =?utf-8?B?dXZXRFhrNEoybWxRemZ4VUNsMTIvVnZhN0x6TjRoeUNTZTFkZ2xKNUliUi84?=
 =?utf-8?B?dzFHek5PajRnNnVyUkVoTnJIUXloZGU5NUpnQXB4dGhQOHZEeHB3TVRpSk9j?=
 =?utf-8?B?bEw4WXJ6MTlNYXVxb21DOERaakhkS2R5SDlSc0ZKQ29MMmx4T2ZqQm5ZQWg0?=
 =?utf-8?B?cG9ZdFNJV0M2eUQrNElXZHVYNGFhTmxWWFFJUS84SkV1dCt6SUU4eDh5c1Bu?=
 =?utf-8?B?ZWRLUHhCdDAxWllJZGsyeGFMREgzWEJxb3hORjEwMjlIRFQyWjcvbmVONVhK?=
 =?utf-8?B?WDZBR1MvOVMvbzBkQlZXMCtseFNLMUtKSEhpNWNRRDc5RC9xOUw3MkdSem1Z?=
 =?utf-8?B?Ykk0UDVYTUsvQXJuV3oyOHpSMXJiUTJvaXkrMEl0dG1ENjZLaXdSb0hvY0JG?=
 =?utf-8?B?OER3LzNlbnludExKNy9EelQrYmxYdW5LSFRNcG1aUHNrZW9jR2d3NjBLODJq?=
 =?utf-8?B?dDQrWGhxQkF0bThGdWFEd1ZsUVNSZXY2WE1JMlJxejV0aWFwcXBqN3NKbkhQ?=
 =?utf-8?B?ZzEvY1Y4V3E3RlhnZ3N2OU91R04rZE1iZEhPQWtIeHZoTkplQ0wybGQvMTlN?=
 =?utf-8?B?Yk5iZndZRUpUVVplY2gxbHkrUmNadHdrd3MxSkpFRGp5azV3eUFmLzh5Kzdr?=
 =?utf-8?B?dVJOeEREYUZ3NmJxWG1WYjV4ZVpmN3ZFUEZWL1JQbDlramtvQy9pV1R2UmNu?=
 =?utf-8?B?blFZbVFGNzFJK05EZ0lVWFFmTXQ0MXNCRTA3YlNwTnJGZll6T2doK21aV1Bt?=
 =?utf-8?B?SGRvU093d01TdEVsbEZKQkl0b0NwOUJmbnNOQlB2K2lWbTRkenNEaHhLMEVu?=
 =?utf-8?Q?I9/6hUcHfODGvePE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9716d4c9-c411-47bd-8332-08de68a97826
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:37:01.0500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cataH0Bau/lN1sAATc/9wa5ozXHOq0EqUGmg6+uK6MgmSE16BRrhgqTdzbZeElNEOBwwe6NNBWvtbtAImEmQ2UQ+Zn8BDe659yNI6MFy3PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> It should rarely be the case that we need to cleanup the descriptor ring
> mid-burst, so mark as unlikely to help performance.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Does it measurably help performance? I'm by no means a performance 
person so this isn't really my wheelhouse, but I remember enough patches 
removing "unlikely() for performance reasons" to get suspicious!

-- 
Thanks,
Anatoly
