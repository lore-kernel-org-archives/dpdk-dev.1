Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55283CAC599
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 08:45:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 854CC402D6;
	Mon, 15 Sep 2025 10:45:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B705940262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 10:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757925918; x=1789461918;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oIoioVG1WkQGUbx4ZGpJBNj/Trq7XDz0v0gek7QGl0o=;
 b=YihlrfB45TvRZRS0+kvAYf1Er+dt3jiAAzZxJ2jY7UAobQ7QmrdYh37h
 cZzPFVa25q+IQ048BsAraANIoKny0A/iF/rmA5JG0b3Fa4QJ658pnuvK0
 WmraAuwzdvz7ZLgL0CKVs1WVjUcBHVsbyEJgE8c5s5dDy1duyiep1mKpp
 pPp1giyD8KFbTr5KO7U3zAU/TMFNYIwaabpDH/j/2ORV/TAauUJ24zFf5
 kME7iD+TQ6iMc61mXfHGewyZDzxBVpdkeMtzKYo/irG8dCkXjTfYgH3ex
 ZyqNUqPZS3xpk1WKSVMUIqOP3rUgE/VzH1bU1vBv/h2Pc6zz/PKGuNbb/ g==;
X-CSE-ConnectionGUID: NuytMPcEROatPCH3hM41nA==
X-CSE-MsgGUID: t79Veck9T1mj8YA0QnThJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60230434"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60230434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 01:45:16 -0700
X-CSE-ConnectionGUID: 24OASIYJQPC4MupczmMuAA==
X-CSE-MsgGUID: txYZVWkWRBei2EY25lP/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="174631242"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 01:45:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 01:45:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 01:45:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.86) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 01:45:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL7Hk4EpFWBvvnSs31ksCBdKWk18IPrLPNW8pTt9cFZSaJbTy5taUEyNSWsc0hZq15PYVvux7JD2hRev7g5lZSyc2ziqiQSwjvUpqp6PVd3k9y+JiyMZID4DLhyXz/QpQVMcCYzmUHT1ZfcpQL6/7UFOqDztKjzpOWpYTIWf8xpbDfUR2d0ZFrGn2ZF6n2Z28IOdBi7UlYZL2KdCbX1ksYysmH3Z3RiawYK/y95E/iqroTk/M9xVGBP4jz/sZ4xAlbtZcNjvS66gISdUgalFlRHBOIg9fYOcB9f5qJw/zQMqmyJzirP5H3j4tvAuZxdIkZ1baCI6U2J3yiEPXC1IPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIoioVG1WkQGUbx4ZGpJBNj/Trq7XDz0v0gek7QGl0o=;
 b=tWrMc+SrevxSD+FY/l/rBtktD3VBLlK4wPRc5D96bdb/LoAnqq0hCYj4Augsi7rQOYufALNi/0u0iOfVmwt33hnPbqmy6t24dzf8FenjqfFiRCnvVl+8kKz7hbk+xsDqB9c6GeHQB4GBhI4wlhpBaSzedDIHG0X1HV5gH7UHADJ29a9Emh76ht8J8ufP0221481+LQX62v7a48xtnBFirzCqNsXA21vGINjJ2kZiDwO38YM4f/sT9f05YSmpyPLZfgZKi53mXQB2krBu4Ma8uwa/uxoQROU5pu4Igxdw5aKB7WY9ZKYmnBOyHr7+5pdNqBKOKbRu6wc3iBArbPKlug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ5PPF3A51834D3.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::821) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:45:12 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::e891:61bf:88e7:bd9c%8]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 08:45:12 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Marchand, David" <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v3 10/15] net/ice: remove unsupported Rx offload
Thread-Topic: [PATCH v3 10/15] net/ice: remove unsupported Rx offload
Thread-Index: AQHcEC84sJuokYiHWUWJdxZs2vE50rSUD+AAgAAJZ2A=
Date: Mon, 15 Sep 2025 08:45:11 +0000
Message-ID: <DM3PPF7D18F34A18F628B6488BAB7ADD7608E15A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
 <20250818105914.169732-11-ciara.loftus@intel.com>
 <CAJFAV8wu3jQh2WAY_aUdS-Y1xFMFFtYrGGh_hgbROmMaEpWcgQ@mail.gmail.com>
In-Reply-To: <CAJFAV8wu3jQh2WAY_aUdS-Y1xFMFFtYrGGh_hgbROmMaEpWcgQ@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ5PPF3A51834D3:EE_
x-ms-office365-filtering-correlation-id: f0d554a1-c1e3-4f7d-05b9-08ddf4342ef3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SmlsVHRJb0lHc28wQkZBZ1ZVV3NkcjFkT0kxOThvZUozUUQyK1FIaGhEdGxG?=
 =?utf-8?B?Tmd5bnlVV1R1eUIrcTdrRkJXWWNiM3pJbERwTGRxT1hiVjg4eVI5Wko0V3Qw?=
 =?utf-8?B?L3l1Q0pVSVc4cHNEakRKUlRVMzY2RWJoeFhldVhiK0RRc3BGbXV0R2toRTNm?=
 =?utf-8?B?czhBOXNlVWV3T0x2amlpbUtHQ3dFOWtpMDRDN3JuRWRFUG56bWVuNGFhNlNt?=
 =?utf-8?B?blk1V2l5ZDFaTk1tRGg3UjhRN2xuVUcwQ2hoaUVOUWZoV0szL1JIT1RoNmpS?=
 =?utf-8?B?RnNmcXNxY3VIRkV3b1lQSkUvbm9Ja2NKaFdSaVRETWlIc3habmNvamVGVncw?=
 =?utf-8?B?TFg0SWlMMGk4ZFpBam5xQVZSeDZLVjQ5c25qaWkzeTVxa1krbno4VG5GcENm?=
 =?utf-8?B?Rk5uR2htT0tqMHRROEF6bUtteXM1UHBtVkp1L1pQdjIxdzhzRlNNWlpmZDhJ?=
 =?utf-8?B?dXJQbVdDV1ZLQlByVFd5cDN0aENYU1MyV3BialRrQ2FiNDdKSXlhT0o1Y2Ry?=
 =?utf-8?B?VHIyYUN5bWUxNFZCR0xHLzFjQzJTbmlEdGV4cklCaDY2VFdJM1dqMUR5YTN1?=
 =?utf-8?B?dUZlS3BtRjVqeHRxaXpLWEhTajJoUk5jL1YwR0wyN21uNVd0VjRYYms2c0M2?=
 =?utf-8?B?RS9JZDhCMG91YnFIYk1nejN5b3RCemNXa3IwVWZ1TitJVVp4RGRmekVpWHpL?=
 =?utf-8?B?VU41c3JGV29CWUhlZkJOdzE3eDFLQ1Q3LzJyNlBORWdiSFRkd1UzejlSdk5y?=
 =?utf-8?B?cXpmSThVeXJTQnRSam9WV25RT3o2K1B6NFY4MnRRWlMrM1VFcWtaQ25mcDBB?=
 =?utf-8?B?WFNrdVBIenIyOGZ6L3pYWEhhdTh4VmV1RkpBYUpjeGl0UnR4MzRqVGxzUXli?=
 =?utf-8?B?Sk81TG12M2JwVlZJRFNmL3BRY0F4UTAzYXRXcHRwTkJkUEFQWnpkTFVMWSsz?=
 =?utf-8?B?a2NUR0diajVQRG8weHVTa3JIMkZJbmhjamdVb0F4bG1hMXVNb3dDSTU3STZw?=
 =?utf-8?B?eU96cy9HT3ZGcTBVUTJUUnlRczV2ZWJCTXhwdjRxRkJyNFNmRlV1RzRFUjYv?=
 =?utf-8?B?SmtNaGI2NjZZa1ZPYmdBWmJqYmNsYjBOQU15UjR1aVNmZ0w3amt2OCsrTEY1?=
 =?utf-8?B?RWZJNTl2Mnh2ZEFDRFFkQ1JjZGcxQVNTMU9hWXlXMGYwR3d3bW5ERVZqNkxK?=
 =?utf-8?B?cllJVm16NVdjWEFrM0ROdWRlL0FXN1NVT3FXaWsrSDJHeW1iR1BEZzhVd3VW?=
 =?utf-8?B?NVd6aFpiL1ZmeWxqZExzSnU2RS9rUVdBRkNrZERFTlNkQTBBQ3MxcWVjQ1Ft?=
 =?utf-8?B?a3pnd0NxRW05K295TEZacXZFbXBncFA1OVY2RWxnN3c1d0dSaS9vSWI2NnR5?=
 =?utf-8?B?WXVaN0ZHd0dWL0JuOHlYTGVWSkliZkZPZ0llRHNwdng5bkZaOUlEY3ZCOEE0?=
 =?utf-8?B?RTVrOEUybzIrSFpGYmZqKzNRbHROV3pzaS9LSEVaODRNS3lLNFhzMDRybzVx?=
 =?utf-8?B?Z3RiU09vVEdKZmM5SVRFY1ZYTlNFUGlCbnZnbVhxVGxFMlRaYzhjcXgzS1hY?=
 =?utf-8?B?b1lSdmdFeDBIN2J3dGc3MkNpaVVJQU9tWHN3M3FJY3hmOUNqU2xKS0t0dFBW?=
 =?utf-8?B?d0hzK2thV1gxcFpoYWIrdFNOQlA2STBjdGtPMTd5OGJNQmxNTi9VZTB1M1Rz?=
 =?utf-8?B?UWV0QWl5MHc2RGoxRGVtb0FGTmwyWGhYTHprU2tWcnhOV3ZSYmRYQjU1TTRx?=
 =?utf-8?B?TnI2WHJmUThwMytINTRIOGRyYzZDcW9vbWtWRmt3WUR1WXlrWVpzVEhDR3A3?=
 =?utf-8?B?Z0w1RUR5bnQvT3ZLRTh3a3FadncvVUQ3RjBialFxdHVER2lKcXRsSDVTdGV0?=
 =?utf-8?B?Snpmbkk2NURFVUx1b2trdHJrdkRNd1Fua0NMNkprTDR5REFMeGlESnViOU81?=
 =?utf-8?B?TUxFcTNXVUVEb2ZDRDhneVpNaE1jOWFUcUJtYTI5RjFLOFNMTmdJeXlxblZM?=
 =?utf-8?Q?9QpFgSeWq3sQCoKNZXU9opYlIaiBCM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE9MTzkrd3ZZK2NtREJWYkFkVm9IWXlxSkE5TGJ1OE1qRFRSbTkvMi9mWTBO?=
 =?utf-8?B?SXpoT1J3SkpUVVJIUnV6bGJKdHE4NHdoSnV2UXpSTUd2bmtGcFI2TWdVYTQ5?=
 =?utf-8?B?RkVQUFZZT0tpKzZuZ0pJVTBOVHdOVmJKSDYvVktzWHUvbVFoRTVkUTduZzJQ?=
 =?utf-8?B?ODc4d3hnMUpOWTZ1SEtTV2p6ZFdoUFI1TFE3UlU3U1hCTHlZZVJLck1tMkVP?=
 =?utf-8?B?T1h0MTJvbWNPUHJOR2Mxemp2aUxMUW5DcHJla1ZycW1yVkZYUTU1ZXlhSEVV?=
 =?utf-8?B?YlF0Qk5BSG9RMTlKVSsrY2lsRC9mUTBlUWIvTnpUMTlVSHd6VGVMRmpSTng5?=
 =?utf-8?B?YTcrMnc3UXNFZ0h3Y3VHNHFLdDM4QkRxbkVXWW8vT3pWNTFMN3U5cTBHVWI1?=
 =?utf-8?B?VlpRNndKclh0aC94eW5MeFNIYWN4YnpRdTN1UEx4cEJ1ZW9oTEZDcDFKUkZP?=
 =?utf-8?B?UTcvZVJFaVdMNVNzVW9xcTRJeEJzNVBEV3krLzEwajU1ZlpCNnhhQ2VSd1JI?=
 =?utf-8?B?bVE1UlQ2Mm9sMHVPQkFiQ3h2M2thKzlqWmlVRWpSSDlUeEprWUcyMlNFZjJ3?=
 =?utf-8?B?TEJNaHZhVTNTUWJHQ2xnUi9sZjhMV1ZXakJHN1ZHcGlwWklMeXowQzQvR1p6?=
 =?utf-8?B?dUJRdWR0czJreHVLMDkxUHFMdThFZHZHNk1VQ0l5RUxnT1JUT0RHaTZWeHBO?=
 =?utf-8?B?TE1yNFk5Tk93aXJ2em9iaWFMaDZwYVNYRjB5ZEx6SWRNL3J2VDNWZklITlVW?=
 =?utf-8?B?T0hVdjFvOGlka2l5R1FndHgxRUJ5NkhkbDlHcm16eGVZRWpicVZNaEZ0TUdo?=
 =?utf-8?B?L3JJRmpCSnpEcDhqWS8rN29UMVp3VEpUVnVxbmFCNVNza1hHU2pNL3M1TThI?=
 =?utf-8?B?SzhvVXNveHFpeEo2eEtTQkF3U1UxWEM5L0tTOVlwVmY3d25HUDVhS28vWFFv?=
 =?utf-8?B?bHBYbVZpbG1QSjhqOG9QdDVKSytXTW93QzhiZFVrSHlZV0pHbDQ1RE9SZ0dY?=
 =?utf-8?B?cnRiZlFtVHBZS0hTdlJNUTBrQnhCOC9taU5MMnJFZ0lLQnB1MXkyYnR1b2da?=
 =?utf-8?B?SFphbEZpSmNmMWo2dlRDeU8xdnBTazJ3S09HR3d6anIrcWZncHcwRlZ3ZUJh?=
 =?utf-8?B?d0dvb2JncCtsT2IzTW1mUW5pd3NMZlpWWUhCdzJkWitqNTFTZWwrQUQzeVdn?=
 =?utf-8?B?dFZBOGlTTm42cC9neU1qN2dGZm1NVkxPWC91VHVYNXVyaEZWTmpLT2hEblQ4?=
 =?utf-8?B?NjlTTXJjbURUYytiQ2V1dGFXUmJGa2tRNXd0VkFvcnFVMC9nNnlsOEZMb3VE?=
 =?utf-8?B?cHE3cjZtUFRCWThXVERVUS9Ld2Nab2h3cXQ2VEJEcEFTRGVyRG5XL1B0cVNX?=
 =?utf-8?B?YkQrdXFqS2gxUGpIb2p3aVBnaDZycG93TUxkYkNMWGZQZ1hiVSsybGp5NGli?=
 =?utf-8?B?THpYV0xiaDY0WFkvVGNzRXhybDVzUmhHcFVmWlNENnUxaDRUamd4TDZ6TW9U?=
 =?utf-8?B?MHJ4RzRoQmFLN2tWM2VXaUVxaEhwSGUyN2pRUW41MFAvdElsMGx0d2EvTXlD?=
 =?utf-8?B?V3BhcU5wc0JnRFBGVTFTcDNERmNBcjFTUHovZFpoYkJqSUxhV3JpNDVsVHdi?=
 =?utf-8?B?WnREQ0hCNTBXWlpBL1Q5Yk9TWHFTcWVQWlpETUlZWUUvZW5ZMERlZDFLeWYw?=
 =?utf-8?B?UnVjWnNubjBQK2hlTFRZRE9IS3dOdS9sY00zUUcwQ3V0Zlo3RSsrRkhoTDVh?=
 =?utf-8?B?SVdiU1pleGdkS0VoU01MV2E0OXdvR3FLUFNheWFOdjJOeGNzUHI1Q0NTQXBB?=
 =?utf-8?B?TE5RZjVYeUlJNXplajJKZyt5RVpNWUc4YmdJUE9uUWkvMlF4Y0g5Wi9aUzRk?=
 =?utf-8?B?MS9kTVVpZm9ZejRrbnI0dElHUHdsVnNxU1R2LzEzM1B5cjR6MFFGbWdmVldx?=
 =?utf-8?B?Y3pNR3JjVWw2U0JNOUpZb2lyb28vZHJPeTRFOFFyNDBpdVVUWml1N1JCVDNZ?=
 =?utf-8?B?VXR1d1Z0ZUprNXBUSlJYaC9JK1ZSbGFQYUIrRlNDNk9yWmVTMmZRNTJMSWds?=
 =?utf-8?B?dmx5ZTR3bjgrM2RDRGg4VWowa1ljTzM1RDJJa1h1RS9adFNvYm4vVzVWK2ph?=
 =?utf-8?Q?eplisiGdZXeCuAuk1742taaiU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d554a1-c1e3-4f7d-05b9-08ddf4342ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 08:45:11.9412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RW1Bona78Amhiec/UQFdi8IyscJgyoDkmnUQGd/dhkR+g/nmvWRYlrQY7nCBufZreINcFUMnXDCEUxk92cPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
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

PiANCj4gT24gTW9uLCAxOCBBdWcgMjAyNSBhdCAxMzowMCwgQ2lhcmEgTG9mdHVzIDxjaWFyYS5s
b2Z0dXNAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBvZmZsb2FkIFJURV9FVEhfUlhf
T0ZGTE9BRF9TQ1RQX0NLU1VNIGlzIG5vdCBzdXBwb3J0ZWQgaW4gdGhlIGljZQ0KPiA+IGRyaXZl
ciBzbyByZW1vdmUgdGhlIG9uZSBlcnJvbmVvdXMgdXNlIG9mIGl0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQ2lhcmEgTG9mdHVzIDxjaWFyYS5sb2Z0dXNAaW50ZWwuY29tPg0KPiA+IEFja2Vk
LWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGludGVsLmNvbT4NCj4gDQo+
IEkganVzdCBub3RpY2VkIHRoaXMgZml4IGluIG1haW4uDQo+IEZpeGVzOiA4MDhhMTdiM2MxZTYg
KCJuZXQvaWNlOiBhZGQgUnggQVZYNTEyIG9mZmxvYWQgcGF0aCIpDQo+IA0KPiBUaGlzIGxvb2tz
IGxpa2Ugc29tZXRoaW5nIHdvcnRoIGZpeGluZyBpbiBMVFMuDQo+IFdhcyBpdCBpbnRlbnRpb25h
bCBub3QgbWFya2luZyBpdCBmb3IgYmFja3BvcnQ/DQoNCkFwb2xvZ2llcywgaXQgd2FzIG5vdCBp
bnRlbnRpb25hbCBub3QgbWFya2luZyBpdCBmb3IgYmFja3BvcnQuIEkgc2hvdWxkIGhhdmUgYWRk
ZWQgdGhhdC4NClNoYWxsIEkgc3VibWl0IGEgbmV3IHBhdGNoIHRvIGJlIGJhY2twb3J0ZWQgb3Ig
Y2FuIHRoaXMgb25lIGJlIHVzZWQ/DQoNCkNpYXJhDQoNCj4gDQo+IA0KPiAtLQ0KPiBEYXZpZCBN
YXJjaGFuZA0KDQo=
