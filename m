Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0871C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 14:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDE6B4064E;
	Wed, 26 Mar 2025 15:17:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 33DC5402E0;
 Wed, 26 Mar 2025 15:17:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742998622; x=1774534622;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=uUwu8KwqDF8cIKBFjXH7h17SRA5SqC7dTQ0giHLdLdA=;
 b=Q/A23beFOtMZ8k7maZe9vqT08RVqbabUDX+HbaRNBIJq6b//O3w9kDAg
 oPGxJXZB1/zZsuJoOhPVTakTefUZ4663X7PuP0koiFMfsvElabPycsii9
 SxkAnHm1pCTnxhw7CshhD9H0QQH1e7K8yQvrASNyirBFDIns1fu7WruOj
 52ufoqm2rZSH7JeSdPnhLEK/nt3j3udbbz/wBLkthOt9+NhRSylGOn6de
 NwZbUkuTKVgz+vMnhkN+mku2YZN0ZOQ3kA6jEgQYtmjzq6T8VYGptUWfS
 CZpqfyhs6hxwaQX/rsIIkHtfEmAGqMDH2smv+Sv05drvA9koiMiDmKD/w w==;
X-CSE-ConnectionGUID: RSV5tMt9RqGHCXBmViknFw==
X-CSE-MsgGUID: Us8i2D9ETZOBpVWEa8E2vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54939866"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54939866"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 07:17:00 -0700
X-CSE-ConnectionGUID: OIhnf42AQWSStvqfm7Ogxw==
X-CSE-MsgGUID: YMj8s2JEQ62Ltl9ccmCylg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="129907956"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 07:16:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 07:16:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 07:16:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 07:16:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xATWTbY+/xRFnsWecHaW1H+0e/t3lkM4hcqkm7wnXh47uBYmURtOLMTSxTSGTBHYRg90UTcCgQ82sl5bQJYS0NYyQ2UcrsFpW6K7CfAIlRT2q+y4dMdWXEO1S6c31MCu6GQjWFcLp/wX49o8BGTerRKFUBhovI/0f9v/W3/OS1v5MapG1n4YuAmQ5Z1WOSo+K0EH/24CUlbvioMZD+T6o4W9YoscnglMubKM0q4zP4ttQuPV9mGa9t2Y6spJmuS1s8mzwmVXCavt18I/A1SJJY4qP/Xzg+Rvot87xgJUPSiOKy+fXtRtVxp+XrZP7FN8lP+Lm2ptBdTovUD660DG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSj4yZ9B0SjSx/ek2PUpZLnW5GeGxLehH5gZCqOUvJw=;
 b=odEIpG7qKifgkMJYjIczWS7UxOe49oWfTk3zcsVx2z7wVYylQd8b3J5i53Ccs2L39JPI9H+YJ2eI484hI+VJ6p+R5GdtvSb5IRYYn9/IOw1xC0hbRBuMVBHxBLG8KYm5k6sL7LFvHKQPfvRNGPPrBoL8VDlAkN4fwSzCFFAQ9TwiWyXFPHQPaE7QBGrfCCyMgHTZWfl2j63nsAh6zMZKBonISH+8kzjYqEk5MkquQo/Fo1AJWOISA7xVeFjXFUw6WRwp1/4zqQwospBqa80ClgXW3NRbXLKKoOsnDltQU5/dC6j1qa2HPAV5ZT9mGHSD75JEClp68d8Dr+3Kl2U0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB5024.namprd11.prod.outlook.com (2603:10b6:a03:2dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 14:16:51 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 14:16:51 +0000
Date: Wed, 26 Mar 2025 14:16:46 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <andremue@linux.microsoft.com>,
 dpdk-techboard <techboard@dpdk.org>
Subject: Re: [RFC v4 0/8] Symbol versioning and export rework
Message-ID: <Z-QMTmiT5y6QJdd1@bricha3-mobl1.ger.corp.intel.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250317154308.2782689-1-david.marchand@redhat.com>
 <CAJFAV8xiZB8r9=5D2tpc9Onrh+7582ZzM8cY_2VHojaQ7xe=BQ@mail.gmail.com>
 <Z-QC4XwlHXSlFBHe@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zQqVFz8ChfgY8MKsy-dBJJEtxHs2vTmvB1L7CDMOkyTg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zQqVFz8ChfgY8MKsy-dBJJEtxHs2vTmvB1L7CDMOkyTg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0326.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: 06cc2514-db69-4786-926e-08dd6c70da85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUord1dFd2xlMWF4WWFxMW1JS080SUU4K1dBeUhQZ1U4Sm1pMnM2UWFPdU5o?=
 =?utf-8?B?K2NtZHVtVTAvNjBaOU5TS1BPSlRIYmhES05Ybm04dWkzS3pnTmk4NWRMNXph?=
 =?utf-8?B?R2Y0aVlOclpwRjVhMGEvVHFZMDVPdVl4bHNHUnZDOXkxQkdiRHZxVkllWVQ1?=
 =?utf-8?B?T1h6TzZtSXBPaTR3UEt5M2htc1Z0RlNUdjV1SFhKdWQ3bnVnVjVSRkFsTENi?=
 =?utf-8?B?WHdUZ01ZZTdpU3ErVFBHYTBHVXFNaFZkbXN1Tks2cnFJMGI3bi9TcERVOTV2?=
 =?utf-8?B?bjNkYTdTV05icHBQZ2JjZ3Q3S0RVdnNpbkZLREZIKysvR3pmMjcyWEV6QVVQ?=
 =?utf-8?B?em1iWWxHMHJVSGQzRzV2M2hhNFkxdEJheittcGZ0VTJMWjdmYnpGbDV0V3Rp?=
 =?utf-8?B?dXBJak5xUExIQjdvdGdTOXJQZHBpSGFaeE1KU1lyZTJ4OW9rNktuMmI0VGwz?=
 =?utf-8?B?Si92OUthNUJTL01QT24yZVF2YUkwZlZnUWhXaDVWTWxUUDVPRUcyUlUwWVRz?=
 =?utf-8?B?dDQ4amJBYnB0dkRrZjc1MDdIaXB5RUpRY3VvUG5VK2cxd0hQbmxrWGhJYTQ5?=
 =?utf-8?B?ZzNxVVdKbk5zT0NaWTE3ZjJ0NGRJRk9EdFlvRk4vOGt5OHJYM2htdG9IcE9n?=
 =?utf-8?B?eTFzU0wvN0hNTjJGODNjeVNOREdMby9yOVJNOHlKVW1nNjVHbGpTWlBDY3BH?=
 =?utf-8?B?MWdwYmppOFVXTW1zcTJmUGlTQUdlaVNmVmJKRTkyRitBUFNMb0p5NHgwdTA5?=
 =?utf-8?B?YjFubE1TYUoyRlV5cXBPUzR5cHdtUm9kZFFLajJuTUczWWZ3QS9YZzUxK0hR?=
 =?utf-8?B?TlRnMERJS0RiVUtYOU5IbDk3TzVSUXdxRjdBM0hzYmNvQ2hkM0ZwN3dYajRW?=
 =?utf-8?B?aTdFRHQvak5YdG00MTFIT3F2Zm4yc0g3bDlDOUVqVWV5RzlmMGlYVGVTVGdk?=
 =?utf-8?B?M2Y1Z2xvU2xRZGR6UThMYkkwckQxdUd4VTJNd2pEOFFuKzNEQ1dUMk1SRW9r?=
 =?utf-8?B?QjRSSndBUlFlSDZYbGNHenhoZ0xXWTJlRGlCTGUzdnY5d0ptUnRKcnc2eFZu?=
 =?utf-8?B?cVRGMEk5YjlwN3lYTm4wV2I4cjcyVTVmRGVIeGtreFZReFVmWCtiYm9iSU1j?=
 =?utf-8?B?MEE4WkxuMUpZUExucXdvMlUxZnVxdXY1eW9WUGdkY2IxOGR3aTVvdzNpc1hy?=
 =?utf-8?B?b3dHRzlHSnhaL3R5eFU5QVNEMFg2cEgrcEFDWFBUT2E2aTkvcWxod2VKUVJx?=
 =?utf-8?B?eEwvTE5VSzhJTW1jOHpBV2RqbUdXbzZzS1lFb3FhY1VTaEFrbUxzbTg1U1NQ?=
 =?utf-8?B?K002NmZJZXdLeVlSTHV4dC9Sclg3YU90VzYvRXpnekZoamVyRG9qRFc4bXpI?=
 =?utf-8?B?clpzcEgvVmZ5cVJNUHUwV252NTR6eUJSTU4xZzZtZTBvMnRCMm9ZbEJlc1Ax?=
 =?utf-8?B?TngvaVN6MVZuSFZvMEVPdGlCV1RaRUFEOXZTdVU0elZkVnJ4NWZ4T2FsNmpl?=
 =?utf-8?B?cjhhWWF1SjNpTEhZMzNDdHJRdHpzVXpTaGh4SEdmTEw3WHBGcjRSOFJxWlRE?=
 =?utf-8?B?Q1RtcDBweWRTSnhXU0I5Uzl6eUw2c2dOcmQxV3IzRkN5TUVEd2NHcEY3MGdH?=
 =?utf-8?B?bVNvcHE2ZzVCRUh5YU1wNjM1WXNXL21Jdm1DV05IbkRDdnk3d1NJd2NGc2xF?=
 =?utf-8?B?WFg0Y1daVmdJZUtIZm4zVXExMHBhc0daSXo5ekxwZlJoUUFRMFhab0N6S3Y0?=
 =?utf-8?B?elFvV1VpQnRlZFBLZWZuN0xaamt6V1FVMDNDMUtPWkw0VzJQVFZ6ZTc5SlJU?=
 =?utf-8?B?NnRZeWFHTkFpSGZmTWlIL1AxdUJKRlVKNnRZNjZLcTB0d0F3RTE4MWg1RlNp?=
 =?utf-8?Q?W4OnJYDu/ylKq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2JPR2FtaDQwZGo2TndVSkMxU2hVZ01JZEY2NXNEZ1lJZWk4cTlzb1R0V2ow?=
 =?utf-8?B?amJ2WVlaV3NsT3R5aWN2QmtkS08yaVl4ZEtJSFl4NE5sLzBnbjZsMzJlQmIv?=
 =?utf-8?B?dVQ0aTh1c2FBVW1oVk1FUEFaY0VUQ09KNFNieGpXYm14U3ZaWkFyZ1JMenVr?=
 =?utf-8?B?UTVDSTNCbXd3OXZDaXlpeEhyaW43N1RPdVR0akc2Nk5CMXR4WFdkK3R2YjBu?=
 =?utf-8?B?RjFTcFVOYXBxTmoyUkxiamdBMXd1V3JQWWwxQllqMFVtcm1yRHNKWlp3V2ph?=
 =?utf-8?B?dTd4MEp2VGR0UEZSUDhVY3dKN3E3NEEvei8vTU9aNVQxcmNCRy9qSHQwaUpT?=
 =?utf-8?B?MHI2Q2MxL21tdjQ4T3laN052N1BlZGZTMDkzNVUwWDZkczVaYnFwcXNTNWxT?=
 =?utf-8?B?eHIxb293YUtvVWtHV29TZjJITnVKZWU1RFFnNXNPc2ZpcmRwbnBwd0VPc3dI?=
 =?utf-8?B?RTQzWWc1T0FERFJnTGN6WCtXVDJvZU5WNU5vM0FXdEhpSGJUeTBreWtGelVF?=
 =?utf-8?B?YkNYdXk0NFBCNUErWFNZdXdxOTh2ZXVJcEpUUmlEbC9XTjA3UjhMaFlVaTRq?=
 =?utf-8?B?VDBvZk9CbjZxbWlqVzdmZFlRbytTdTNaakw0VlE0Z2l0RmVvNlVFZ2JWTFl6?=
 =?utf-8?B?dW5mT0dXVWpPYTZlSEdpTHpxS1dsUTF6Y25UTmpzcUlHMnNYM01uL1hsZnBO?=
 =?utf-8?B?VjB0Skl4ZC80WlBhSjJ6QlVlN2RUNS9icGUyYk9IUWpmY2ZRVDZoRzNVWXhj?=
 =?utf-8?B?UStWNVloQkszMlREeG5LbnA1TXdaaFUyeVdZeTkvcjJ6bm9WaExPc2Y2TDE5?=
 =?utf-8?B?SmFPTnV2MTJVdFBKa2pxcjNGL0REaGplZW1sUFp2bTVnSVFnbi9SQmVkeElG?=
 =?utf-8?B?blhzSzQ4Qldxbm5icXUwZXhJb0srQk0zTkR0M2k4UzV2aXR2WlA4dEJKUy9W?=
 =?utf-8?B?cWFqVTFXdmQ0ZTkvM2RvaWYxT3Fla0dnb3NzSGFOMzl2eUJPUGN3WllGV09V?=
 =?utf-8?B?Q3MxYWFvTzFVb2YvT0FoamU5djVqb25mS3F1MVlMY2tRcmlPRm85dWVJZ0d1?=
 =?utf-8?B?cUpZdnl0V2VGVWEyRG9mUWR5QkFiZ1RtZGVXaFVxU05pU1dFQ0Z1WFdBNGJa?=
 =?utf-8?B?cDNqSWFtMGV3NXFhRGtTbFhuM2s0RW1ab28xTitsWmpndE1QSHJoeFdPRE56?=
 =?utf-8?B?ZVJkY1MxbEU0WnI2eENKQ2F3cUIySDUrMG1lTGZsdExwQUFyNHVsamMzTmZj?=
 =?utf-8?B?SDRkeGZ0VlZjbmFrOTRzMUR6WndkdlQ2cDc1MzZvdWlBdm5uN0lid3ZqS3p1?=
 =?utf-8?B?K3NxOUpuTDNEU2owOVlmT3BYQ1B5aUpYd3I1TS9RZWJrRXV3azRXNHhiUWxU?=
 =?utf-8?B?T1ZoelRPTUJNR2tnSWJiYW9GcWxibXpiTnNRSWc1SHRsNFl6M3RxRUtlYURW?=
 =?utf-8?B?SjZvOUpDMXpnb09iUGJBR250c3ppcERuTE43RVoyQ0o2QWt6OWl2dnRWUmJU?=
 =?utf-8?B?VTM4bUpPOEVQdWNpVXJMSndwdStXSUFXd3VQeEtXekdlaDBHSzlmVHBzZTJp?=
 =?utf-8?B?Z3NiNnFpV1V3WXVuS2tBZnFpMG5iUWZ4b3NMeEpmQ1BXSmVaVU8vWXBzaW4r?=
 =?utf-8?B?U2tjSG5EUHA4Nno3UmR4SkN0RkNrOXl1K1hTZ3FNcXZoczBKQTR0SStwdU15?=
 =?utf-8?B?Zi92TkErR3hDMlE1YkQ5NHV6SnJjOFU0RENDeVZ6M29CRGplbXlPSDB0cXc5?=
 =?utf-8?B?SlVzSStERHlEcnRPZ0hjRmdKaTAwMTBEL2FIdWc3a0FSYkc4WnVKMWpmN2pF?=
 =?utf-8?B?VmU0WWExUnZWR2RWQzNuTDd1d1RucFFOWERwT1l3NWRaakNyMWw1cm9EbTl1?=
 =?utf-8?B?SHVkWDF1Nm1obDRoeUw0KzFRM1djck56RmYyNXJyY0RaMW4zZmNkMmxKeHFC?=
 =?utf-8?B?cnVFaysyREhOV0pwV1RLNm14R3greHZ5WjF1SW5uNkwySlVXNGMzS2FlTEl3?=
 =?utf-8?B?SmFiNGJta1FjdUhnMXdNZjN3d0dOR0toMmhuVU1ncXhlaUphaElUaHl3UGYw?=
 =?utf-8?B?My9JajYwamhYc1ZaOXl0TTJDakFDd1FRd0VpcXpwSEJNUzRIbHJGZnEyaUhj?=
 =?utf-8?B?SDNlUmRBcHAwcUliKzV6blN1OE1BTndSTkptdW1EWEZZSWFsUG50TlUyQlBS?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cc2514-db69-4786-926e-08dd6c70da85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:16:51.7223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VULDi0M8r67kuvF7+W8w2DTe/bvYVqqZo7kvf9lUS9FLzsZwui1ydZAr32WeLfY0TiaxX+j8t/JMHDDE0dzDHqS0iUgPGzXem20GGto/WZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5024
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

On Wed, Mar 26, 2025 at 02:54:32PM +0100, David Marchand wrote:
> On Wed, Mar 26, 2025 2:37 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > > - I am considering making rte_function_versioning.h a non exported
> > > header (precisely, moving it to buildtools/ and maybe renaming it).
> > >
> > > This header contains macros not prefixed with RTE_.
> > > Using it requires some build trick (see use_function_versioning).
> > > And I don't see symbol versioning as a MUST infrastructure that DPDK
> > > needs to provide to datapath applications.
> > >
> > > Yet technically, this change would be an API breakage if some
> > > applications indeed relied on it.
> > >
> >
> > Is it not needed for exporting if an exported library header had versioned
> > symbols is in?
> 
> That could be, though we don't expose such versionned symbols atm (and
> I don't think we ever did in DPDK).
> The only public symbol is always the symbol implemented for the latest
> ABI for newly compiled applications.
>

Ok, that's good. Looking through code and code history I do indeed see that
the use of function versioning in the past seems to have all been done
through the C file. Therefore, no issues with making the header
internal-only and not exported.

/Bruce
 
