Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20331C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 12:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAFF740B9C;
	Thu, 27 Mar 2025 13:25:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1CC23402E6;
 Thu, 27 Mar 2025 13:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743078329; x=1774614329;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=lgoqcq0sk8qyzSl2PtFkzqbO+gHPzNo3mydor1Z3/rM=;
 b=UDQlYIBtumfkMtUwShp1yI6LOhRDhYVQr6c8SzxHa2A3bMofeZJy5GvD
 A870J8NjK67S4/mneS9FP7TTgrkibU5lxzGSqx1fyCRVpqPH1/7VctMW+
 HlMpqdt85uznTgLMhC2y6n9G4fmBkCylHozadDmO9tGMJzXCYT6FRBZPW
 FXbeiDvLpOkz3ZDs+nMxxHCQqmnQeKiPXIkycEtE0mNvLQ3HDeqRT/ZQF
 t5sTNXRhFaHrMrVsGqwY/m0840l6JVpfexxS8U8oMtwy6eSp8qJsgN+Ad
 pEPkjeeFIOSxJoDM8qhy8xRwE/s5YuSAwb3Bs+5k5R+CEKBOCbMQCLCbE w==;
X-CSE-ConnectionGUID: zIWGpmMHTmCdQojy3+Frpg==
X-CSE-MsgGUID: /nlSwkivRTS9mMWoTFJ88A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61800219"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="61800219"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 05:25:22 -0700
X-CSE-ConnectionGUID: MxBYUYetSXOTUMV9UaRsHA==
X-CSE-MsgGUID: RPpEw8eaQ1Wh1EheyKJ0oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125344472"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 05:25:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 05:25:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 05:25:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 05:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1T8MnWXXLM/KPp7LZmffFyj3Pz2umT3tZPZGwnTDCmw7fqXHGLMdP8ZfD1cszM11/r1L5KRAE+T8mxgubxrAbGPeQwekcF4SUs+e5zkezb5a/RFa1CTKdouhZRqRyupmSQBpRvtJzBZ617efKWGLd2Wrk28sCzHYBrRIzn9/dy9fC6nTCvZFCYE3RmLF/PZMUWYOfBK6gwFX3ShNXKoBSSOANimHbzBwvuYGqSBfGB8komkjveFl4zp2T6al3zQKOm2LDNdhs0hta7cxPXKa7djn0gDm5MBVhpzkzYEsSykV97SrSDu2gQvQLAkDLrraB5CY1nBbowRKnC27IOevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfXSky6VAAL/jqStqv8a1d0vse549Myrk4Hn6ksznYU=;
 b=RN2jCxYcUjBz9nKhs8kJphcVs0jdmi+o3y2GqxeFwEcW563dPDegJtnKJrq/4gSuVmZsgGx0jwyHYg1n09dUi77jN07QeDFv1r3eTEdjzyToxv1u2gHZH9e4TAoEawuZJYf2lIeRliAfr7dwL8MR1xIhPNvz/icw3aPjcUbKgYvqc0UCOIz6tkRIRTynz1XlVV/yodB27cifz78M/DCyqP2Mhhuvr/U3/IRkTi7KRZZ4/ouhdfuVApFcyQUxsZFTzOnfDus3NxWRdXgx2KBH/fv/GZNz4T6nP1X5xQUBHg410sf/SEbjFOTnNt8Kd98NoNswjsfSWILg6TTssXs3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB6494.namprd11.prod.outlook.com (2603:10b6:8:c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 12:25:03 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 12:25:03 +0000
Date: Thu, 27 Mar 2025 12:24:58 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, "David
 Marchand" <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "bluca@debian.org" <bluca@debian.org>, "stable@dpdk.org" <stable@dpdk.org>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, David Christensen
 <drc@linux.ibm.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
Message-ID: <Z-VDmvUi-XPYPYtl@bricha3-mobl1.ger.corp.intel.com>
References: <20250326103928.1189243-1-david.marchand@redhat.com>
 <Z-USgmK7lRZsjcIn@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8xLbR_UD3=i_fR3aLzuciuWbbkkV8DgiXYm6Y1C7RXQug@mail.gmail.com>
 <243684416b27483b89f1c5e5ffcc249c@huawei.com>
 <Z-UtrQn9cud4oNA8@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB7B@smartserver.smartshare.dk>
 <cc6776a7e8ad4f519c66d0b204b30f08@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc6776a7e8ad4f519c66d0b204b30f08@huawei.com>
X-ClientProxiedBy: DUZPR01CA0258.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: c12942c8-dab4-46b2-a611-08dd6d2a66bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em9RdTUzUm5MSVZyS1FSMjBabnZSZXlBcXdDWVVDY1ZOQnB1SXZxUTgvYnZ5?=
 =?utf-8?B?OHQxVTR1bkp3NXU0RHFybTBVbFNVUE8rYUpOcUoyNVpKbEdLKy9UdTRkUHRX?=
 =?utf-8?B?VHU5dElNWWg2SzJWT3hVOEVMQUtWTjFYQ3VPYnJsdFl4blEwckhhZG1OclE5?=
 =?utf-8?B?SVRyYUlBUE5QMi9SUHlrNnJiZ0lXNFljQmMzZWtjNHY5L0ZsY2pWaWRyckZx?=
 =?utf-8?B?eWhqSmZ0NmtuQ0hjd1I2czlZZVFiNTYxNXoyME1raGtwQ3BJbjBkRFRtcldJ?=
 =?utf-8?B?WkZqdjdrN0Mydys1TGlQUjhXelY4ZGd0Q1BVRFM5enVTc05VQitYcUN5OTky?=
 =?utf-8?B?Qi9DdkFBREdWSGJDOVdSb1ZPdW5QajEwM0dqcXdQSkdVNFZsQ1FhUEtLMlF6?=
 =?utf-8?B?NlF1OWZlS1FlWGJWNXd0cmdWSWlFeS91RDBNOWZzQUYrQUw0RUNJRzBUVEw3?=
 =?utf-8?B?REh4VDlHU0t3eDY5TGNpL0JDeEJwOVFsYmdLWDhqOGZuQWJkUW1SUWFHSFRD?=
 =?utf-8?B?TlMwWGkwU3FPZEtLZjlqSVQxNTllR0YrNlJWR3UzSUdscG5kOFVsdlZlS3hH?=
 =?utf-8?B?YkJrZmw0cmxiL1I0RkFVVEpNekZ4dTF6dU5PdXNMcWxpZTd1N3o5MXJHdXFT?=
 =?utf-8?B?a1F2TGdjOWZnSllzcm1MYkNRdXE4cjBoaW4vVHVtUGVEM0ZFcThNN0l2QnRm?=
 =?utf-8?B?TFdRSVpCR3dURngrcStuNUtERURCeWNBTnFMeTZrdWViVEpvUVA2RmRwbWZ4?=
 =?utf-8?B?dDJDUjlwK3oxMVN5aUhkT2V2R3RsZlF3MThoWWJUdnM3TllMaVo2aEU0U3Q3?=
 =?utf-8?B?WWJsMkVTeG8weGU3NUEybmtickl5NmhLajl1dWNreGtpRGg0dEg2WkRvZ0xJ?=
 =?utf-8?B?QldhSVRmVmpKSTZmblJmbHprVlZjL28yUGJ5am93NHBoNGhTUnlxTDJERnMr?=
 =?utf-8?B?YWs1azdyVEFEVWxGTWJScWRnS3FIdkg2YnZSaGJkNUxYZG9xTTlKUE9RUkNE?=
 =?utf-8?B?bU85N08vSE43YjRPdlRhR0hKZU4wZm9OTzEvcU82dWRzOXdxZ3ZnckN6VlFj?=
 =?utf-8?B?NHBmTGtmUjRoMDlKRW5wbm5uY2dwMTQvcWFidmUrdzZiajdCSUxlcHF2bExM?=
 =?utf-8?B?OHNtRmZUY0xRcW5TNE9ZSFkzMGU3S3dFczNWZVFaVGljUExpYmQwaisrZ0pm?=
 =?utf-8?B?dHBSQUp5eWtjOWU4OEFUVXhUUlNNYmw4Zko1WEl0QWh6VmpYZHI0K1B2RFMv?=
 =?utf-8?B?NEJUdnB2QnRaT2h3ck9EWll5T29OdlV0elFTN1ppMTVzWThDWURiZXU5eVB0?=
 =?utf-8?B?K1hRSThudGhPaC95S1JJa0RaRDkvSXUyY2hOWllWVGdBdFA4NGF4RU1WeWZC?=
 =?utf-8?B?Rk9HODNsaTd0aDI4bERoeHVzMFY4NnpQei94UkMxcUpxdHZVOUpsT2dMb1hn?=
 =?utf-8?B?OE9pK2lTR0Yzc1oyWGF6Y0gxL3FRcTZxK1lPa2RDdHBINkJYb1JuSFg3ZVFs?=
 =?utf-8?B?VU5KbkhuR2F0alZHVElWSXRwc0M1VERHUDRTL21IQUZ1VUg4bmlXOGxGNkF3?=
 =?utf-8?B?Yk9DL0NHc2hwRzZxb0I4dThibkRQcndGVDdjUkEycThlQWY0SEkzOFRoK0Na?=
 =?utf-8?B?OTl5TmN2RjNwcFUzL2czb25pLzFXaDFDZXpoRHJNd0l0dXBNRDVLQ0dpRnMv?=
 =?utf-8?B?eE5VY3VLckV0MmZIM1BMM0tKQms0N0xWNFdGMUR5VFNZbE5BNzZocDcva1BY?=
 =?utf-8?B?WDBZcVMrbFE1aS9TMnlOdWY3L3RWMXdNNE9jMmxNbW1vMGdzNnJmOFZJTVF2?=
 =?utf-8?B?RERxS1NkcWpuOEVZQ1EwcHFqc0dhVGN2WXR3STNCbVdtaXpta0dpWXpJalVy?=
 =?utf-8?Q?4gLPk0otwi8KT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGludHk3cjJKcEkwZTFqNEZZM1A0R0cvdEU4a2ZlOXBDWTd2NHgyNmdUU3lC?=
 =?utf-8?B?WnZIR3hNZjByUmRqSVI2MUpIejZPd0ZrVzcvRGVmTWl3enVlRzFoTkJCdW9u?=
 =?utf-8?B?cWFPOFo4SnZzN25iVFJ1aTVYOExzRjkwbkxKYTF6UnVrdGNDUkZ2ZVdMd0Vx?=
 =?utf-8?B?N2xXQXZkUVZrT3dPRmpjZjlBTTUwSkZTV3NHOWtNVkNIZW5iZm5lRk1Dbmd6?=
 =?utf-8?B?eXArTHpMNHRPVVFVWWIwdG9CWFN0NzA1M2d0Q2Fyczc3VE1KWHpVcEtpeDI2?=
 =?utf-8?B?OU4ybXBNMlpvL2NqS1hOVTBXbGVIZkJDZlNPV1laT1VYbEh4MDJVT1ZaU2tN?=
 =?utf-8?B?TERqR2FZSTF5VklDWVpacFIrL2ZpdkZxK1ViUmpyamZCZi9BNDFNQ3VualhR?=
 =?utf-8?B?U0VpampBNjFxZUNPOWVaZmtrYVZhVWg5ODhXOWQwWlY2NWpQT0N1SFFTVnJx?=
 =?utf-8?B?LzMrR1lLQ21YbXl1a2ROck1xQm9SWkgxQmdDNGdhTDM4ZWs4R0Y1L3FoZ3pM?=
 =?utf-8?B?KzZtZThuN1hIYVVCd3R0Q3dSdGI0ckxnUTRLWVJNTk1NNTJ0amNYM3VQR1g0?=
 =?utf-8?B?dENFazFJRXpvd3ZrNGI3NU5pY2twSzNOSndwVFk4NUdWaXhhL1lkRXRPTUNo?=
 =?utf-8?B?OFRxN3J1dHNQa3A2cFFTcVN6Szk1QU9RckF1bEp5SVpoRWxTWVBCNUN6Zi9x?=
 =?utf-8?B?VWQ2WWdKbTVBYkY1Mkp2OWVyOVo1OURtR2VpQ0kvYkdYb0p4VVFWSm9PYXNY?=
 =?utf-8?B?c0M4dC9UdWZvR0tQVjhod3BDTjFnVkg5MFRlUVRYSTMzZnBkT0cweFUxMllq?=
 =?utf-8?B?cGtxSjBESUxyOS9xTWJDeWZBTVNCTER2bGtDQzJXaDNYNVkrZmZWOEM1Z2U2?=
 =?utf-8?B?UVhjS2MxYWV4OVZvZC8yNXJTT21ZS3JNa0NkOEJ2R3hEbUJOVkM3dmNxUHEr?=
 =?utf-8?B?MjA3UFQzUmR5RW1wL3FQWmI0ckh6MnkxaEQ3NUZKYmtyWWc2c2Z6N1J2dDJq?=
 =?utf-8?B?c1FZam1lR0FNbDQvTGg0OGwxcVhEM25pakF5T3o3RTdnMkJHNHhwMDRpbTRD?=
 =?utf-8?B?aVBwSFZEUmdKeS9sQWhwNXB3eWtiTHA3Sks4STIvNjByeDdXWDd3UitNTFBl?=
 =?utf-8?B?TmlGMjdidzZ5OTZuYVV4VlhQWE9wV1dlRDF1RUFWY0FTcGlHV2VEKytKNVpL?=
 =?utf-8?B?Q0lEQk51VVVYdGdDcnBrQTZ5S0U4bk9Qdi8wcWY5MGNEUnc2V2hkS0lMc2hi?=
 =?utf-8?B?dE5YKzdVN1pXakhwUXZ4TmNNWkNBUUR2TUJZb2NJOGM0YXo0ajZBOVV0eTBY?=
 =?utf-8?B?RUNUNkJEcHA3NS92VXg2M0wwSm9ZUXN0WmtLM3UyekE3d2xndlB6K0w3dlRG?=
 =?utf-8?B?eUNxaUxVeExPeG1KdTFoSnBEU3krTVprNnd2bkxPbDJmZmIxbTh3YTA0U2Iy?=
 =?utf-8?B?K1cva2tYT0NtWnRlbEVqNnBTMXo3YUEybWVLZVZpeG1HRFJEb0RjbzJDTFFp?=
 =?utf-8?B?aTlMVWlLMGVmdlVUaTZIQmh6QmdZazBvWE50d2tpd0lmL0JSd0Z5ZVpFYVdh?=
 =?utf-8?B?S3dsL0JNclR5ellpVVROdFp2VXl3WkhzN3dnVDRZZm9Yd1k3L3JHTzFKbGxF?=
 =?utf-8?B?T2YrMjc1OHpWNkVoY2JHcG5Mdmcrc3R3TVdsMWhzZ3pNQVlmSk41WVNKSWND?=
 =?utf-8?B?eUxUNjVUdndOUkdnV3VhQ3B2SjBmZmt2aEo4TTh6K2dsdWpndHVQTW0yOEZZ?=
 =?utf-8?B?NjZMa2Y2eDRub25YSG9CUE1UaTE3QUFieEVURFhHNWFabUZ3cFBQRlFkOElz?=
 =?utf-8?B?NlVwVlQ5WW1Cd2ZabU9JckJwbHFaNDJva2U5aStkbTgzRW0vZjBFU3ZqQVFB?=
 =?utf-8?B?cWUwQnBvWWVsZFl0TDVZVmxvVXV3ZHl0VzNvc2xwL1kyQ28xTzBvVWlVYUJn?=
 =?utf-8?B?ODNPd3pERyt3QWsyYWY2SVJVbHVuNnJsaWczZG8yZUllQ3RaRE92MFZ1ZXJR?=
 =?utf-8?B?VVhWTXB4Y0lsMDkzUk5hSUN5RVE2Tk1OYmZ5bG1VWlZhNzluS2tVdVpQVEpy?=
 =?utf-8?B?ZUM1ektBZ2k5cjhya1hIOGdqeTRERWU5c3duL3ZGM1NYVjdMb1dRV21vRGh5?=
 =?utf-8?B?bzRyQTQ1Ukw4SlBvZGhDUEF0Y3lETk1iS3JlU3VsY3ZqN2l5U1I1b2JzeXpj?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12942c8-dab4-46b2-a611-08dd6d2a66bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 12:25:03.8415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDk7uQiID8pcvGqoI8/tXhVhyja7fU2MUil22HAnCM4TAxtw246D/4r6m5Pzjj3l2rjmIqbDWYscEK1ItoHJ27Ix5ir2zZ4wl5JTpaHZQeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6494
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

On Thu, Mar 27, 2025 at 12:10:12PM +0000, Konstantin Ananyev wrote:
> 
> 
> > > >
> > > > > -----Original Message-----
> > > > > From: David Marchand <david.marchand@redhat.com>
> > > > > Sent: Thursday, March 27, 2025 10:37 AM
> > > > > To: Bruce Richardson <bruce.richardson@intel.com>
> > > > > Cc: dev@dpdk.org; bluca@debian.org; stable@dpdk.org; Konstantin
> > > Ananyev <konstantin.v.ananyev@yandex.ru>; David Christensen
> > > > > <drc@linux.ibm.com>; Wathsala Vithanage
> > > <wathsala.vithanage@arm.com>
> > > > > Subject: Re: [PATCH] acl: fix build with GCC 15 on aarch64
> > > > >
> > > > > On Thu, Mar 27, 2025 at 9:55 AM Bruce Richardson
> > > > > <bruce.richardson@intel.com> wrote:
> > > > > >
> > > > > > On Wed, Mar 26, 2025 at 11:39:28AM +0100, David Marchand wrote:
> > > > > > > Caught in OBS for Fedora Rawhide on aarch64:
> > > > > > >
> > > > > > > [  198s] In file included from ../lib/acl/acl_run_neon.h:7,
> > > > > > > [  198s]                  from ../lib/acl/acl_run_neon.c:5:
> > > > > > > [  198s] In function ‘alloc_completion’,
> > > > > > > [  198s]     inlined from ‘acl_start_next_trie’ at
> > > > > > >       ../lib/acl/acl_run.h:140:24,
> > > > > > > [  198s]     inlined from ‘search_neon_4.isra’ at
> > > > > > >       ../lib/acl/acl_run_neon.h:239:20:
> > > > > > > [  198s] ../lib/acl/acl_run.h:93:25: error: ‘cmplt’ may be used
> > > > > > >       uninitialized [-Werror=maybe-uninitialized]
> > > > > > > [  198s]    93 |                 if (p[n].count == 0) {
> > > > > > > [  198s]       |                     ~~~~^~~~~~
> > > > > > > [  198s] ../lib/acl/acl_run_neon.h: In function
> > > ‘search_neon_4.isra’:
> > > > > > > [  198s] ../lib/acl/acl_run_neon.h:230:27: note: ‘cmplt’
> > > declared here
> > > > > > > [  198s]   230 |         struct completion cmplt[4];
> > > > > > > [  198s]       |                           ^~~~~
> > > > > > >
> > > > > > > The code was resetting sequentially cmpl[].count at the exact
> > > index that
> > > > > > > later call to alloc_completion uses.
> > > > > > > While this code seems correct, GCC 15 does not understand this
> > > (probably
> > > > > > > when applying some optimisations).
> > > > > > >
> > > > > > > Instead, reset cmpl[].count all at once in acl_set_flow, and
> > > cleanup the
> > > > > > > various vectorized implementations accordingly.
> > > > > > >
> > > > > > > Bugzilla ID: 1678
> > > > > > > Cc: stable@dpdk.org
> > > > > > >
> > > > > > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > > > > > ---
> > > > > > >  lib/acl/acl_run.h         | 5 +++++
> > > > > > >  lib/acl/acl_run_altivec.h | 8 ++------
> > > > > > >  lib/acl/acl_run_avx2.h    | 4 +---
> > > > > > >  lib/acl/acl_run_neon.h    | 8 ++------
> > > > > > >  lib/acl/acl_run_scalar.c  | 4 +---
> > > > > > >  lib/acl/acl_run_sse.h     | 8 ++------
> > > > > > >  6 files changed, 13 insertions(+), 24 deletions(-)
> > > > > > >
> > > > > > > diff --git a/lib/acl/acl_run.h b/lib/acl/acl_run.h
> > > > > > > index 7f092413cd..9fd3e60021 100644
> > > > > > > --- a/lib/acl/acl_run.h
> > > > > > > +++ b/lib/acl/acl_run.h
> > > > > > > @@ -176,6 +176,8 @@ acl_set_flow(struct acl_flow_data *flows,
> > > struct completion *cmplt,
> > > > > > >       uint32_t cmplt_size, const uint8_t **data, uint32_t
> > > *results,
> > > > > > >       uint32_t data_num, uint32_t categories, const uint64_t
> > > *trans)
> > > > > > >  {
> > > > > > > +     unsigned int i;
> > > > > > > +
> > > > > > >       flows->num_packets = 0;
> > > > > > >       flows->started = 0;
> > > > > > >       flows->trie = 0;
> > > > > > > @@ -187,6 +189,9 @@ acl_set_flow(struct acl_flow_data *flows,
> > > struct completion *cmplt,
> > > > > > >       flows->data = data;
> > > > > > >       flows->results = results;
> > > > > > >       flows->trans = trans;
> > > > > > > +
> > > > > > > +     for (i = 0; i < cmplt_size; i++)
> > > > > > > +             cmplt[i].count = 0;
> > > > > > >  }
> > > > > >
> > > > > > Minor nit, but since we are using c11 standard, is it not better
> > > to declare
> > > > > > "i" inside the "for" statement. Keeps diffs simpler for
> > > adding/removing
> > > > > > code, I think.
> > > > >
> > > > > I still have this (bad) habit but yes, it looks nicer with
> > > declaring
> > > > > in for() itself.
> > > >
> > > > My vote would be to keep it in an old fashioned way.
> > > > Nothing is wrong in defining variable to use at the start of the
> > > function :)
> > > >
> > >
> > > No, there isn't. However, there is also a reason why later GCC
> > > revisions
> > > and modern languages allow use of a temporary variable defined within
> > > the
> > > loop itself. Cognitively, it's easier to have variables defined at
> > > point of
> > > use, as it saves the user having to mentally track them or move up and
> > > down the
> > > code. Furthermore, when debugging or reworking the code, it's far
> > > easier to
> > > have the variable inside the "for" statement as it means that as we
> > > comment/uncomment, or remove/re-add, the code block, the variable
> > > definition
> > > also gets commented/uncommented too, without having to constantly
> > > scroll up
> > > to make changes in two places. Lastly, it makes for smaller git diffs
> > > too.
> 
> I understand that it is probably more convenient, though from my perspective it is also more error prone.
> I saw several times people unintentionally defined new variable (in a local scope) with the same name
> that was already used in an outer scope, especially when function becomes large and clunky.

There is a gcc warning flag to indicate such cases "-Wshadow" or
"-Wshadow-local" [1].

[1] https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

