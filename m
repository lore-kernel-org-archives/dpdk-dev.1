Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EE3EA810C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:16:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69A7040668;
	Tue, 10 Feb 2026 14:16:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id E65AB40652
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770729398; x=1802265398;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=hKR6Dm1c5AxCziEf5eSjmn15gSsht34fNs1c7WrJCso=;
 b=ZM/b3J6KLKhW6GPMxRWqUHafbIQkPmf26xwBLxM4ciciQxpQZ1TFKz30
 VArtlyjB700ceMi2IXbShd5e95NV2OFvtlBUpP/5VSDFc+Da8gNL/Z/ko
 FAeTXPqg3HBZQbkWcHk93GZ+04mYEEYpj0ymoKGtQPEOpZ/QO9mjV0vRC
 GrZKax4Yu4txV1JhzVl9Y7/Nlx91mtUYxxZ4yhInFlGI0NWys+NlGFs6x
 1p4TSL0bL4IBL2+CBA//hxsqGNnWJZIOzp5sFiMvfsZeu3uLLed4MKcao
 2rytlh59I2ofjESPu5ePe4dy3QtmX9a+HG6PClLk0bw/qAVXU3jN1B+7V A==;
X-CSE-ConnectionGUID: bscWMXnVQ0G/yCQyu/uKHg==
X-CSE-MsgGUID: 7H+VXtnERmy0KBE50B+yjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82960235"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82960235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:16:37 -0800
X-CSE-ConnectionGUID: j43hvM4mQkWlpBrT9E/EAA==
X-CSE-MsgGUID: 7TQG5U/AS7+OJ8fHKJZ8kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="234887339"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 05:16:37 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:16:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 05:16:36 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 05:16:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0RTbRfMTugSzJQNQoEWRp4dSy+2r5+djMnVFieOkbJ10LgdybK4m4rS/nGIJGX0pEwuktgpx2DVBJQF7U2hd9iyc/8S5Eawnu6HIiCjxYaG0g5QKf4dZ5unLCrLZtWrqY6XUtTzG3Duqo9kjffJr//PRgVDCNzerdXH64daynwSms2LvSt+h7Y40tZhTmyY0J1Bm4Rq5AdsY0CmpcHREybPmoWo+FGJ0cNkIVQb37aH5wYkKkWGUCoap6jhMeVFehpf27ebHTDGpJL0eMpBDufYRuQeC/q94GnCH/q1+flubQm8ZPs5rJqI34WRPj4dUjW0L5Fr4m44hZ0e7xf6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezuhoXcxrCCllggqVC8g0VeXMNgGup/HSkWc+RuLcXQ=;
 b=uDcDrMfq6qV7cBH/tWJ31AwxgoJr6GAqlXqHDYtuSm6JeYxRr0HbtjZn0/MEw4Kuz21Y0jSRYP+04SQ3MS0rGNo2/wsQoboqn1KJJ7yanfQDubfrLmdc9gQFqHGAWdcNSgICxn/fZDktrrd2L01HRVgg9tGluklL4qpVI++8I9bDdf+BYE3dIfCiQ/eFiKvIzeBFxQFuAEdzQuj3zz8fPg7msXpOXObxEXsYf1fdBoAgtx8dU2Rpym6PSD2W7HIoQRRJhFu//P7DZEFUQiPkdOEq9rMKoo74a3COn2rJ9kRmwFqlb8txItL4HHuNJAM5Yfk+7SOtL7MuKIWTR4Dn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MN0PR11MB6279.namprd11.prod.outlook.com (2603:10b6:208:3c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:16:29 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:16:29 +0000
Message-ID: <48feb204-95c3-46d3-9ded-19aaefd79bff@intel.com>
Date: Tue, 10 Feb 2026 14:16:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/35] net/intel: add IPsec hooks to common Tx function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-14-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-14-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0327.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::32) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MN0PR11MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 9639dc32-b6b0-4da7-c194-08de68a69a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHFNTnpRWHJKQldOeVNrUXcwUkhPVGFHMkZIQWd3eU9ZSW5xNkVLdlByZzUr?=
 =?utf-8?B?cFVuMzZDdWI2cUtQdlJ3ekdWemN1R05BaXlrUkF6bGZCV2xDSlFpK29VYnZG?=
 =?utf-8?B?eEUrVHpKK3lrckpFZWtxUndheVg4TTl4NldubVRVT0tOQWc0MWVHM21EbXlu?=
 =?utf-8?B?WlE2ZzJ6Y2Izc1JPWmlhK0FjZE40eW04dnpiZEVWclpqR1Y3T1E2Vlk4ZDdi?=
 =?utf-8?B?dkZiU0tYbzg4Tlh1RUVHTmd3aEVCZmwxZ1dWNjNUUWdSMFJNbjJVQjAzYjJ3?=
 =?utf-8?B?S0plSnFnWWtnYXVNS2tQeDdrUXJyaXJxR0U5NjFrV3dINlBWNUV5TW5CcDdL?=
 =?utf-8?B?NDNwbit4ek5DNVVVbzV0dzIvNHk1YTM0d3pkVU9FWEp6ekNZeHVzeTM1TXpR?=
 =?utf-8?B?eUJsVWk1SjJiQVBIZHFzdGFwcGpUTkQ1Nkxua1FLMk1lMnAwamNGTU1jMnh6?=
 =?utf-8?B?MWdPZW8xcXBoTFk1NmhIQjdhRDVKblQwUzFWTk9NWExSTVRiTjcvY1dwS0U2?=
 =?utf-8?B?RVU0Z28zYmJONUhkOFJYczFjTEtCbVNxTUx4ME1Oc3FIcFd1WGcvSk8wTHNR?=
 =?utf-8?B?VVVYQWwwYnl6cGY0Z1RUbW5mMTBNbGh3bjZSa2NFSzJwS2lTTzRUR205QXJO?=
 =?utf-8?B?QllKejltRWVOOE13WnJJT0VLUzY0MEU3cVRQaWx4cHpIUm1WNEVxbU83N08x?=
 =?utf-8?B?WkNianBid0p3MVdLR1Y1aXZnQVFUU1dWdGdyR01YczdNaFM3SVRyZXFQemFS?=
 =?utf-8?B?dlBSODlvaTA1NXNIMVpycjFobzNkdk5QeHV4dlVZd0VkN3orZVpNQjZscXdE?=
 =?utf-8?B?Qkk2OUt0aElKajl0VDZjc2NxT2JQZWoxbEJpVXhtRVpXeTczVjduQ3FmOE4x?=
 =?utf-8?B?aG05TkNwajZ6anVWS0R6OEhYOFo1aHNQejFzcVhmS1NCUjJrLzdoVnJoZWVm?=
 =?utf-8?B?NHNqc2xSZ1Q0Z0lYVmpzL3JVQTluVVFzVldwVkV3dE9mV3NiOE5wTVMrSmh0?=
 =?utf-8?B?djhOanBJNGU4MnZBdGxEMzExb2tURFlsM2NLbjkvZGdmbEFKS2dtdHE2T3gv?=
 =?utf-8?B?Q3pUNHRZVUV3MXplZFRTR2FERmZhR0drM0U2OFNyckFjTFVocWtGVWdRcGI3?=
 =?utf-8?B?bk4yYVE3ZWova1YyNG1UUlA4OEQvSjY2aDU3dDN5RVl5YXI0MTFIY29JRG9Q?=
 =?utf-8?B?RUFTTnpYSTFTY2Fld3FzWHM4d1FJcWtKN0FySzFrWW5uMFJJNmJaRjFJWWdQ?=
 =?utf-8?B?d0J0SklGM01Ldk8vMHJ6SDZEOFlESFpDcWhDcndFVXZ0RFQ3dVVSMFFmT3dK?=
 =?utf-8?B?REtlSC9jb3JmNFp6aGRsM2l0cE1jUk5YWmx6TFFzSlFuRmh3a3ZtQ2Jrb0pn?=
 =?utf-8?B?aWw0bW8yTG94SStOelQ4SDZ5VzcrSDRCSUowQjFXM0toT0JZejBRL0hYOVVh?=
 =?utf-8?B?RWxrMDlVdlYrMkdOd2I3NnFLOFArTklJQWZiVW0yWFNsZDVpVmtKVXlSTlZl?=
 =?utf-8?B?Y2o5SHhSOFZMMkJNWm1rS0xpYjU0QTVKL0h6OFZaMnV2c1JFZDhOYWQwa0dy?=
 =?utf-8?B?aEYzZkRVOTlrT2tBZGo0RVNUeldHOERoaWJiQm5Wclg5NnNFYXFrLzJhQ01R?=
 =?utf-8?B?S0V6a0RJNmZDN2xqckNrV1VuNWlOUEJyODFub3ZZUk9LNVdWMTF4Zy9kTERK?=
 =?utf-8?B?Z0ROeGpKOFZwTk5CN2d1SW80V1Y2SW5OMHBXdkZjSnliY052U0R0eVlYSWFn?=
 =?utf-8?B?Rm9TQUZsLzVCTTh4endpWW9Wak1qNHFYVk9wNkNSQkM4NkR6S0ZzNXRJYTJi?=
 =?utf-8?B?eU9Sc0s1ZTEwVXZaS2RjU2tNa3BQMmVVZEVXK290aVEwMk9rSTZYaUZDbUpm?=
 =?utf-8?B?QlowamxiUUZ1ZlkrandEVmhNc3NjVU1nZ0VjTVorUEVPaXljMW0xSDJnUnJZ?=
 =?utf-8?B?MjdKVUVvNVc2NElsUFJsWkF1c2JNQUFxa2psNGtSdzg0TEtjdmhUYitTOGY5?=
 =?utf-8?B?cy83Z0ZyK2NLZXBvTnIvd3RwVTI2R21FZXNERFgwUWQ5TzIzc0xkMjRuQW5W?=
 =?utf-8?B?a3pCYndTMzgzMngraGNZR1JTb010L2xaOE5sMnpSR2hiMVQvdDdFc2dyZy9T?=
 =?utf-8?Q?A8Dc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdyRkRTSVNCV3FQb0xwZ2M4dEdlaERZVFB5dmZKOE5wR0VHM0ZTRVRXSWU1?=
 =?utf-8?B?NUNoUksyY0J5TGNkNFF0RHNXdzZsWnBQd21OaDRnRXM1MFVFb1dFQlRqQ0NF?=
 =?utf-8?B?c3I2RTEzc1RJbEJkbmx3YVJUdFhKSE9TMldOWlFzdURqdnRDNHA2K01pWGtw?=
 =?utf-8?B?NGVnMFltMzBIMURHVk5KZUtFbS81RzlVZHo3WXpaVm9EMXpURXI0NzhtNUtp?=
 =?utf-8?B?S3QySVZpSklId3BIUWRuK3RUaDJMV1MrVndqbDNHUURJOWJwNWxvU0VNOUZS?=
 =?utf-8?B?eWpiT2d4RWVEb0RRTlJ4bkRQMnNwenU2Y1Z0L2lNMGcrK25RUU10WHphMDFQ?=
 =?utf-8?B?cTk1KzhkdDExVy9iNVVHSllja1dnZzRqV2pDUGxHQnltTno3TFNqZ1pDMlhI?=
 =?utf-8?B?OVpSY21ZVXQ5Z2Mvd1AyUlVYVXZxK1JDYVZsQWMrdFRkd3dQYlROOGpxSkJ3?=
 =?utf-8?B?SUZ2YlUvTzFVVlJyQWFsTW5wYjlyOHkxcVlLZGNOY1J5a1VGU2VzVHBBbzdz?=
 =?utf-8?B?RDI4Zit1WkFPaE04QjBETXNQdS82T2V1enJ1NG9uYThBUWZCd211MWZucStQ?=
 =?utf-8?B?dlVIVmtjNkZhZHV5cjFsS1pQVG95NWVxc2VyOHZCZTBiSktBdkluSmlGUUts?=
 =?utf-8?B?SlpoM0lBVC9JQkdROG5WU1k5VEprVGpqbDF3bWkvUTNIamliRjFobDRFbGxP?=
 =?utf-8?B?d0xNLzRqRWx4U2JqQVpDYlpDRXZRdWZ5R2llTnd0WXR5b3AxNU5IWXU0L3Bo?=
 =?utf-8?B?TGJCdjRVN1REMWdiOVhhaWlGZnNCTzNYS1Q0WUtUWjRZUUJnUUxYbTRnR1Qw?=
 =?utf-8?B?eG1ZZXJYcFloamEvWmgxVjJjZEcvSTIyYmoybSs1LzFvV253MU82YUE5Nk1E?=
 =?utf-8?B?Sm1Ed21uR0FOTlFRRDBReTJtQlJzdytjeU5mUkJnejRoU0FJVWJUcGhpQmw5?=
 =?utf-8?B?VElVZHlVcmNIT3crMWNNb0NJeEJwbjlhTC9lQTNWcmFGWGxxTVRGTTJwMWx4?=
 =?utf-8?B?d1MrN2hGa25ZcFFxVGxETVcrY0d5Ny9aOUtLSkhJS21kVDRLK29xbHg2MzRR?=
 =?utf-8?B?MWZ4UHI1TUI1UlVhUFJwL2ttU0h2NHJxZXFhZnhZbmJEaVQ3c05tcDZQVjBn?=
 =?utf-8?B?bVNKdGM3SnRFQkwyMHFIK0JBWEt4ZXY5ZGN4ZXNMSnQ4N3MzeE96dFpKMnQw?=
 =?utf-8?B?Y1QvRHh4Y1UvdWRoTExqc0pzdHdwNjNTbzdIeElxdUJGclBoSU53Y0wrNzJ1?=
 =?utf-8?B?VFRlaFdsZ3cwSFZBTkJQaEVja3ZvOWtiT2MxcC9XQ2g1VDl0SFlIZTZ0b2pG?=
 =?utf-8?B?b2RxRVBxTDFMZUthSjh5OUk1MDB5TmRkalB6My9YdG5VMzRKK01tbVZPbWhX?=
 =?utf-8?B?VWNHa25GaUVWSndGZXJEbk5pemNWRUNOY1hpSDFWSDh0NlZjNWZkUW40dUFW?=
 =?utf-8?B?VmJSMUJhOFNDT3JQR3NLYVNkcWJENGxiall1UUk4R21CWGxYQzl5bUhpQUN1?=
 =?utf-8?B?YTJYbE1NbnRGL2NWUTZKdWFreDJYaGNkOUhEcHdJZ0VURW13Y0pqUllobUVu?=
 =?utf-8?B?cGIzeHoxekNNZEtwYnJkTmlSc2t5MGJJZyszWXg0VW53cXdobHltcVVRbEFt?=
 =?utf-8?B?UGRMWGxSVVVrWWhsaTZ4dFFsZk9WQVg5S0YvVHd5bEgraUoxNnhSaDRkZE9C?=
 =?utf-8?B?cU5qdlg5LzBZeDN1K0s5OXMyTjN4VnBudkxJN2hVY1VFRm1yYTZBa2xDNG5C?=
 =?utf-8?B?ZWgvYm9wK21hbElwUExsWGhoM3Y1cm8yVS85d3VRTFNTZGxsbDR3c2NuOXFk?=
 =?utf-8?B?ODhEMDI4eTlTKzRTMkVjOVRmeXRWeVA2OU8zN1dQUGgraTZUNyttMzE3WWRZ?=
 =?utf-8?B?akFudGxtcGFRQjNURG9HcDBhcmRMRXl0TVdRRExYYUtoeVZTeUpqVEhrdVVi?=
 =?utf-8?B?MUNGUnZTTVdzK2VFOUEwSlY5VkY0TUtPdjMwUFUyMkRSUTQ0bjZKNFMvSmxC?=
 =?utf-8?B?NXdEZEJxbjdoaGRCbkNBbVJvaW9nR0dScGpsajRobjROQVRiZ0lvdzl3aFlq?=
 =?utf-8?B?MnYwem11VDlRdEszRmRuMjVPZmJQaTU3SXN2MUtSYVA1QVdjbTc3dkVuRVl5?=
 =?utf-8?B?UHM0cVlORW9jeTExL2c2cmt2eUlaVlVhTk4yMGtLeTlLMFkxZmpSRnp5RGlo?=
 =?utf-8?B?WDNySFpwaGNLNGtPdGdXZ3VhclI4K0ZXSFNKdnAxQTNBMzVCaUpUN0padkVT?=
 =?utf-8?B?L1FpTkNIbGFuTngrdjJrZ2ZkYUh2eklmRDc2RndaOVVJTUQ5Wk9lai8yWnJr?=
 =?utf-8?B?bHI2RkF2YlliWDlpRVVXYW9hLzBYbkFhZVdaYTRxcGtMREdBKzBMQ21JVEhn?=
 =?utf-8?Q?hXHTEWbZjMTihwGY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9639dc32-b6b0-4da7-c194-08de68a69a13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:16:29.4320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu2UIXpJr6bLdHtqenPhbi7u0TTYQij+hp00IawuR9pb+DBOgtyU2hTmQmhZjcf5TXdOIrdSOrR4ov9G39ADODf6rQ+al9ODDlce3YGeahI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6279
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
> The iavf driver has IPsec offload support on Tx, so add hooks to the
> common Tx function to support that. Do so in a way that has zero
> performance impact for drivers which do not have IPSec support, by
> passing in compile-time NULL constants for the function pointers, which
> can be optimized away by the compiler.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
