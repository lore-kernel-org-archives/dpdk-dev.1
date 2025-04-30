Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77BBC369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 01:25:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B026E402A7;
	Wed, 30 Apr 2025 03:25:24 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id 0D943402A3
 for <dev@dpdk.org>; Wed, 30 Apr 2025 03:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1400; q=dns/txt;
 s=iport01; t=1745976323; x=1747185923;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vl9HyXSMGh9p+IcWJMdXtQplJIkR90p5EX5ePBmmXuI=;
 b=VdWwT4N3CMgOU21tAIAe+dEAArMYZVWMsJOzbMQzgkEj1pDrgasdK0pk
 iN/M7a4qkLb79SrtHg/fnoFug+ZRCjwohz6DT166gqOJ1wCOAmEXIC7HI
 tjZjUJ9rbA5g5eeK5DSm92MG6RUc8OaevIcqLn+eJTT/6zlxhltY+h050
 GDsDj41voe2htPRoN+lrMeNtCFu0ntvvIQV9sH2ffo13yApk9M7gNdApN
 4lOAN30nXlxcNqVQHEDwWIBL4kO5p1O6hinjSdJg+o9YjHB57FSa/Xc0W
 6VBqEigN1WuatSjAo5Ept9PvmIT2GFlOvE6ihQmFHS9arCS8xsHz5C0eN g==;
X-CSE-ConnectionGUID: yh30f2GYQGaTrdy/+yPY/A==
X-CSE-MsgGUID: WFSCFQSrQuS8AydBybBOMA==
X-IPAS-Result: =?us-ascii?q?A0A6AADKehFo/4r/Ja1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEaBwEBCwGBcVIHdoEcSIRUg0wDhE1fiEkwnhSBJQNWDwEBAQ0BATkLBAEBh?=
 =?us-ascii?q?QcCFosdAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE?=
 =?us-ascii?q?4V7DYZbAQEBAxIREUUQAgEIGAICJgICAi8VEAIEDgUCAQEegmABgmQDARCld?=
 =?us-ascii?q?wGBQAKKK3qBMoEBg28PftsgBoEbLgGITwGBbYN/hHcnG4FJRIEVJwuBdoECP?=
 =?us-ascii?q?oJhAoFgg1uCaQSCLYEWgUeCZIkOhSqCEXyIMQlJexwDWSwBVRMXCwcFZEJDA?=
 =?us-ascii?q?4EPI0sFLh2CEYUhghGBXAMDI4MTdByEZoRQLU+DL4ESAW9oSSNAAgELbT03C?=
 =?us-ascii?q?QsbBj2WJRqDaoE7IoFxHgyTIYN2jBujKAqEG4wZlTUGDwQvhAONCZV9g06Yf?=
 =?us-ascii?q?oJYiy6bBAIEAgQFAhABAQaBZzyBWXAVGiGCMwEBMlIZD5Ihult4PAIHCwEBA?=
 =?us-ascii?q?wmRZQEB?=
IronPort-PHdr: A9a23:EI3GVRQg/njel9aJMD0u5XzoF9pso47LVj580XJvo7tKdqLm+IztI
 wmGo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk09JQ==
IronPort-Data: A9a23:TebaCKtgv284w5cqAoKDcVEi2+fnVBJfMUV32f8akzHdYApBsoF/q
 tZmKWjUaf7cN2r3ftF0bYXlpkpVu8XVxoRlSFQ4/H9jRCtEgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGZTdJ5xYuajhJs/7Z+Us01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw6+YsWW8U2
 s0hBzkxdBySwKGn+IP8Y7w57igjBJGD0II3oHpsy3TdSP0hW52GG/yM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwxHYH49tL/Aan3XaThVrE6So4I84nPYy0p6172F3N/9IYLQFZoMwh/Gz
 o7A11vXOTo0DeeF8Ce+olu9isXelwncfatHQdVU8dYv2jV/3Fc7BBAIfVejrfr/jVSxM++zM
 GQO8SYo6Kx3/0uxQ5ylBluzoWWPuVgXXN84//AG1TxhA5H8um6xLmMFVTVGLtchsacLqfYCj
 zdlQ/uB6eRTjYCo
IronPort-HdrOrdr: A9a23:IsqyFa4lZ/O6wZBH4wPXwbWCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICRF4B8btYOCUghrYEGgE1/qi/9SAIVywygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadh/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jAR4J/Nj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVIQdS5zXIIidDqzGxvvM
 jHoh8mMcg2wWjWZHuJrRzk3BSl+Coy6kXl1USTjRLY0InErXMBeo58bLBiA13kAnkbzYhBOW
 VwrjqkXq9sfFT9deLGloP1vl9R5xCJSDEZ4J4uZjRkIPgjgflq3M8iFIc/KuZdIMo8g7pXTd
 WHRqvnlYRrWELfYHbDsmZ1xtuwGnw1AxedW0AH/teYyj5MgRlCvgElLeEk7z89HagGOtJ5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCYhv22tLKyaRw4PvvdI0DzZM0lp
 iEWFREtXQqc0arDcGVxpVE/h3EXW34VzXwzcNV4YR/p9THNffWGDzGTEprn9qrov0ZDMGeU/
 GvOIhOC/umNmfqEZYh5Xy2Z3CTEwhpbCQ4gKdNZ7vVmLO/FmTDjJ2uTMru
X-Talos-CUID: 9a23:p4iISW+XNYpK2Jkgv8qVv18UQZgrKFLs9VjZH1W0GCEqWYWkDnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A8X2uwAw6l3yxM2NQADVZ7ITNVvaaqJuAM2sjqK4?=
 =?us-ascii?q?cgtS/ZQVhNx2Mhh6QZ6Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Apr 2025 01:25:21 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 6AADE180001D9
 for <dev@dpdk.org>; Wed, 30 Apr 2025 01:25:21 +0000 (GMT)
X-CSE-ConnectionGUID: FfK6SMHcTIS7CVPfwiO8xg==
X-CSE-MsgGUID: zjXzuosMQfOLT3XjYJx+mQ==
Authentication-Results: alln-opgw-1.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.15,250,1739836800"; d="scan'208";a="47282342"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
 by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Apr 2025 01:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv4Iv9nlqN+dHY2NbKafHRwwDo/gRPGMinMDVChNtocv8KIZSj2KfkFjSEjntpFDddPFcLmDvieG+/cn1QWJuorkBGgmoQTLdHzaSpeTzlmcEPx2Ph0nvyCp2RKY3+pj92kwK6Kqfu9ZsOqCumdunE4udHXSLgYIn5ZHnqWiDrjyMde4VGWrNyoinpHCiFXlxvADqibYp4IXTD1y4bAdgSY1e+3kTBLEamZTtT/g8rTF1XGKUxEK5/Am0QWFTUv9ShHcn1zZFAPWejiDfNUwHQN3DG++vip7LkRG4VEI7zM04ulZGrr+hO/Mw1C9p1kBBblVFpddGgXXL8XAqmobmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl9HyXSMGh9p+IcWJMdXtQplJIkR90p5EX5ePBmmXuI=;
 b=qFsSaMYnIH6WhWq/SAo7gHs350DjQ6nDdjjKkFFMQ/T3hl8Lz3WcAJUt70ixAORNTSLcRx0zXbwLbfZG5KDfJ7hEWYvO/HE591lK8JHVj3SEd59qokWI3nSHyPM59CXXHfRtPnaFoK/BwyteDZVm5rrIuN1eziiBWS3mJ6gd74BslKV/4qXBfzW4VjhjqQ5LV7bqiEpvvBD8cA1ONW4+85AricrjCQFx0Bqcyv91UqX1CoQDtzAHzPnh00Vn6YZWg/SEg6PyyPOpWwtFqyJN5OEMh7iKil508lhS5z9dEBgNzsak5u55N+JJO7rWouDRL/Yd9SiyaE4r3agd4rudrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) by
 CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 01:25:19 +0000
Received: from DS0PR11MB8020.namprd11.prod.outlook.com
 ([fe80::e344:845b:323a:6592]) by DS0PR11MB8020.namprd11.prod.outlook.com
 ([fe80::e344:845b:323a:6592%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 01:25:19 +0000
From: "Roger Melton (rmelton)" <rmelton@cisco.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/e1000: support Rx/Tx burst mode info
Thread-Topic: [PATCH] net/e1000: support Rx/Tx burst mode info
Thread-Index: AQHbrvVkFqBihvcqqUKkH1s7K9Yg3rO6zUmAgACyQwA=
Date: Wed, 30 Apr 2025 01:25:19 +0000
Message-ID: <6b1e8381-7c09-4062-879a-2068bdbc95bb@cisco.com>
References: <20250416173057.372482-1-rmelton@cisco.com>
 <aBDmdRekgks8RqUT@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aBDmdRekgks8RqUT@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8020:EE_|CH3PR11MB8703:EE_
x-ms-office365-filtering-correlation-id: d34ad3a2-6bb7-4f8d-3805-08dd8785dea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WTNyL2JFREVpOUdoNkpkdTlXYzFOOVVwUjE4SGhuMmtTK2c0VHFjdWhoaEdF?=
 =?utf-8?B?T3hiY0hsa21DZjJ2QlJKdXBLWFJMUDBDYzlLVHRDRDNqTFJqaXowRDZCaTN2?=
 =?utf-8?B?aFFaWGNnb1dVUnFxU3NlRVI4dWRDcmZZaWRENmNYMW1IUEpnRlQ0Y2F2MTlP?=
 =?utf-8?B?aHIycURZZ3d6Y21WL3hqME53Wk9UZ0krYzNWdjg5SGszc2JlaXlHUUxIK1dZ?=
 =?utf-8?B?cVVESFN3YU9PeDRpT05hTnAya0R4OEh2TGk5Z2RUSTFja2JsNjVCRmJULzFt?=
 =?utf-8?B?ZiszRTJJV3dkbzFEN3cvMTl4d3FQYnFLaFE0RWlleUhtZUh6TXY5cjJiTStt?=
 =?utf-8?B?TXRlSmtweFhLR3V2S21ieEorMG5VbjZ6a3VmcHllRDFZMkYwQjhhOGUvQzJt?=
 =?utf-8?B?T1FWTzgrSW9HeFJxOG5HMytmb1JYcXJKMXNvMDIvbWRQeUd0NEMvM0dPYldH?=
 =?utf-8?B?TnB0MGl4U3pVNVpGVFJvSjdTMkdVMzBEL3h2U2daUjJNeGF3L2duMVJIeDNH?=
 =?utf-8?B?M2xBTURQeWc5L2RQSVhvOGxpSi9oaFpxL3BPOVoyTENlR3pKTEkxazNMazV1?=
 =?utf-8?B?dmZvUnV6NnhVRGY3bnBwUEJiU3VabFVlbStZMWNsVzBqU0VQUTQxcDVmeDNu?=
 =?utf-8?B?ZlVHMEZpbm5reEw2Ym8zWThGQWRQSHFEalBnMTlCd2FyeFJSZ0JDWWNrSm5x?=
 =?utf-8?B?eXBmMXNHWllHOTdwbFJSUlNWUHVPT2o3Mk01cEYwdmxiRU9yMXFvMlY1UWVo?=
 =?utf-8?B?a1FXaFF5QkVOZm5MT0Z5YkhUSWtNRnYyQ1VueXhyUDU0ejFtZEtYdU1Mb0hH?=
 =?utf-8?B?WW9IeEFXcDFHQ0loNXdpaVVCdmw5M1lvRXFGeTByVS9HWUJVb1owUkxVMlds?=
 =?utf-8?B?a0lCK3FRZnBraWxSWTJTTHVaMWNCSkF0SzNna01NdzdyTWNZOVVtR0hmenNX?=
 =?utf-8?B?TG1GRXIrS0pGOSsrYjdsUjIyRGlzQWE4dVNmYjU5ZW5xTDNhcVcvMktjTThr?=
 =?utf-8?B?dmVhSDRRd0t1dXlQSHI3VG5jdmE1N0NTSExqakZFeXdRNjBIS0t2TTF6NUFD?=
 =?utf-8?B?dDVydk9TZXlEZ0N3R0FicGhzd29NMzhneHRTTzRZSXFXUElaQ2NyRkpWZzls?=
 =?utf-8?B?S3pXbmgxMzllc1hDUVhONm0ySlVnYmNTbjlpOEdsL3hIZTg2ME92TUJKdDJ6?=
 =?utf-8?B?UEdYYStUNzcrRmRtbGpNaytWL0NCWXVkdURQTlhqTENaemRiMDZMYXljWTZu?=
 =?utf-8?B?NUZ5dnlLODRUcEgzRm50SDV5eWdUSnJYSlVyR01qSzJLQnlMSW9LZEVIVWUr?=
 =?utf-8?B?R1JxNUN4bE51Q1RKMVZJZC9KcmNlZDhJSk40SGRvdmJVckNodXpXc1dJVnNo?=
 =?utf-8?B?czViQzJrVFd5M2Z1WWpmbCtHL1k0Z3NaVHVCOGpVZkppTEZZcm1VVjgyMENn?=
 =?utf-8?B?V1NqK3hjRDVGUUVxKzN4dzZuRGtCeU5ZbU96UzFTamdLL0hXcFhsVDlOdVI3?=
 =?utf-8?B?dVZZdm9EVEhDQzlJT1Ntd2pLcHBmcSs1UnRLRmFHRTMycG1haVNRQXIrY0da?=
 =?utf-8?B?MlZiRHo4UnAwT3AxSlluYkNVTFJJeFlxc0dMWkExQXFjZ3FqVnBKdTNUVjA3?=
 =?utf-8?B?QjNxa2tSanBmMzV4UWdjSnYvbEdFenFrbHdOWmdVdU5HYmxLMGNSYjdMdGQ0?=
 =?utf-8?B?RnlEZDJ4cGhGcitmWnRQcXQvUEtTWXZUR3hFeUlNemtTYkwvUk5rMG1LaUxZ?=
 =?utf-8?B?M0phK2hsNExWekg0MkVxRHpDZUJPYkJrT211aXhCVDFteXdLSGJjZjd6YmVq?=
 =?utf-8?B?ZjY4bHQ5dVZ2TzNTQmwxY1V5N2NZQnJUUkJtcThsZW92UjNMaFNoZS9kbmk0?=
 =?utf-8?B?NUJhbjJrMGlHY1JOa2VTcXhZZ21UcEgxTkMrTW1SVXFKdkNqUEk0VGpJQXBh?=
 =?utf-8?B?UzF2RUZYSk14Yk5OaVZVRVh5RUNObnB2N29EV3poQTVWY1EzekN5eUE3Snps?=
 =?utf-8?Q?39m4qhTgSDWmq+TkJtRESGQ6a04wzs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8020.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVhMd3dhYzJnQXV4eEE4NjZwb1NLa29pN1ZBQlJyVTFUeGJIeEUwVmQ0bkpD?=
 =?utf-8?B?QXJObENCWFI2eHFVWmRVOHRleXlwc0QveVBOcTBGRlRjSWsxWnJQeXZaODhY?=
 =?utf-8?B?ampnMkZvUzBJMThReDUwTEVuWlp0SDhiaEZHMEtxd0dJQUMzMGxjekoxSU52?=
 =?utf-8?B?azFzNXhZVDMvYjJ1Tk5kTktzSkFPNG5iQjB1aTZiSHk2aUNrMmEyNWhNNEFZ?=
 =?utf-8?B?Qjc1UzFnR0lPK2ZHbUdxaXlkVGRjNUY4cEdKcHpyZ09HRXBBZ0dYMUZGaTho?=
 =?utf-8?B?aGRGWnlKNFM0SzFUVENvS29wNlRBVnE2SmsxM2JxVzZhVUF5SGZVTkhHVncx?=
 =?utf-8?B?OFRlZGRoWUNlelJGeW5WdkxRRS9ZWmFjRlZrbUpjRUMwNi9ycTJQZWRvYVBJ?=
 =?utf-8?B?UjVxS0JsVlhYWGZyVGdaUWh6T09rbmhuRjBZSVJDYTdodFBnU1lFWnFHN2hW?=
 =?utf-8?B?KzJ6SThqdFpYMlZuV3NnT0RsUTkvbGQyeUlrTUdyZk5XM21jeGZ6RlkrQ0ds?=
 =?utf-8?B?U1VHZUYwaGVZVU8yLzl3TU5LeDZZc1hPZnlwdkRxcGQ5RDhONWVNR1YzV1I3?=
 =?utf-8?B?QkRjVEhsUUZSNWN3QWg3c2FPQ01PZ0NRbVlGblpSTEh3aTNlS0NGeFQwQWNQ?=
 =?utf-8?B?VGZib1ZldlJESkVHYy9aeEpDVXh5ejBZSnRkbCtrRDY2OTB3WW9NYU83VkJF?=
 =?utf-8?B?b0hFN3k4Q0xSckRWbjF3UFpyVzFyV2tLdzVZaFdFTkxwaFhDaUZha3BlMlkx?=
 =?utf-8?B?R0JXWkdCTkFjSHFCSy9VbXZ3SE44d1J2dEtDbnhvem00RWR0WmtDU1VFTkNu?=
 =?utf-8?B?Z2JhSEl5UW5RM3pkUEpudkRBNWphSEpUb0g3UHZXZ1gzaFZVLzViWjN1NWFS?=
 =?utf-8?B?dTR2dlhwSlBtUFlhZGUwZm00eU9jM2NOSTRBa1orYzNMZVU2MXAxUy9rRWVS?=
 =?utf-8?B?TDQyYUlOMlh1YTVGWmdnM3hGVm9hR2pjQmlXOFM3NnFuR0ZRc1J1N094S1dX?=
 =?utf-8?B?Wm5TaXRWTDNFMHNBV0E1NDVQWXc1R1J1TnM1dm5nVlprS0RySkdUM2l2SXJB?=
 =?utf-8?B?Y2l3Qk80RnNzSUoySGoydEx3dVFRb3pNbk12UkFNVk1nZlo5b2VRUTVuSkJ1?=
 =?utf-8?B?UzZ3TlByc21xQU14dFlTb1VMYUZrbFFaOFpFYlR0dXhTVVBDTmhUblB6KzlN?=
 =?utf-8?B?VUR6RGRtRVRRSUJZanphaGtWODhSNE5kM1djR2ltR0FmNWxZb1o0WGtXQkdE?=
 =?utf-8?B?dzRmbkl0aDFFWnRSNjN3RXpzM0Q1UlBIdVNrZmI5QUVILzVJUXAyYmhHdGZ5?=
 =?utf-8?B?ZE1WaHNZQWdUV2JCZEd1ZHMxTXZLMVIzNkFta1d3QUhtaDhqU1NJUkE4c05W?=
 =?utf-8?B?ZzdoaWF6OEx6elJjR0tkTnJGemdMcy9NdWE1REVjZ1RaQ2E2NU5TN1grT08r?=
 =?utf-8?B?dm9YZktIZGQ2eHc2L0ZlZFA4TDNWNXczcndidm85aExLeXJLOWJxR09qd05I?=
 =?utf-8?B?YUhzNVF6OHQyQXV2K09JMVdWNUd3TElMNFp0SGZ3bUtFeEFQaUpUdkIwR3pP?=
 =?utf-8?B?Q1NRRHhmUW05MXJlbnl0b29ORVN0YVc0VjhVbmlHYWFGWHJqSE1HYVNpNzlG?=
 =?utf-8?B?RmEvbmttYUs1Y2NHcW1tMERSMXNPOElKNGM1N29rbDlwWkxhSzlKNUl4UTkz?=
 =?utf-8?B?TjRzcHUxOUFZcTZMdTNralYwZ080NEROY0ZEeDJjYzNEYVB6aFZQMUpOZmJF?=
 =?utf-8?B?T25LYW10dktFNU1mSll2Nms1NmFiZjBVOUE1dEh1Qm5UMUthMlJaaHpIWk1M?=
 =?utf-8?B?YXBLTEpQRFNET2lHZDcrRmgzZ3RHeUNhZmtXbHJ4MXhVVEhQVTNkdDNHVnBM?=
 =?utf-8?B?WW03TkNuOWQwc3BMbU1oMEE0czE5ZExPWnN5aHRjSWVKbW8zNkxsN01vcERQ?=
 =?utf-8?B?OUhDNmZxUWEzZzMrcE1STW9hbExLek9VZXlYUW5rNFoyN3ZTSDVWa1Z4alJl?=
 =?utf-8?B?b0JFZnl2WkhCWm0xTWUwcUhqVk9zM09sVmZWYURhZy8zZlBEQXRtK3Zha1h1?=
 =?utf-8?B?a2hINUZOT21lU0t2TjlZemFRdWZVYUNrU2ZoRHZZOUYwOXhoeU10cm4wdEFi?=
 =?utf-8?Q?R5iLPYK5JuJpwbR8p8nmsoWor?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB93F52D38F6A64295D8C633328E327C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34ad3a2-6bb7-4f8d-3805-08dd8785dea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 01:25:19.1420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5v2MNFEwEXZWMN4WdIFTAnFwrR2LnwvOQZFZg3wKTkdtftTM9D7dQepLB8IaG8mK79MwLYAelgYleFYgPdbfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
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

T24gNC8yOS8yNSAxMDo0NyBBTSwgQnJ1Y2UgUmljaGFyZHNvbiB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMTYsIDIwMjUgYXQgMDE6MzA6NTdQTSAtMDQwMCwgUm9nZXIgTWVsdG9uIHdyb3RlOg0KPj4g
UmV0dXJuIGJ1cnN0IG1vZGUgYWNjb3JkaW5nIHRvIHRoZSBzZWxlY3RlZCBSeC9UeCBidXJzdA0K
Pj4gZnVuY3Rpb24gbmFtZS4NCj4+IFVwZGF0ZSAyNS4wNyByZWxlYXNlIG5vdGVzIHdpdGggdGhp
cyBpbmZvcm1hdGlvbi4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBNZWx0b24gPHJtZWx0
b25AY2lzY28uY29tPg0KPj4gLS0tDQo+IEFja2VkLWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVj
ZS5yaWNoYXJkc29uQGludGVsLmNvbT4NCj4NCj4gQXBwbGllZCB0aGlzIHBhdGNoIHRvIGRwZGst
bmV4dC1uZXQtaW50ZWwuDQo+DQo+IEZvciB0aGUgcmVsZWFzZSBub3RlIHVwZGF0ZSwgSSByZXdv
cmtlZCB0aGUgY2hhbmdlIHRvIGVmZmVjdGl2ZWx5IG1lcmdlIHRoZQ0KPiB1cGRhdGVzIGZvciBh
bGwgMyBpbnRlbCBkcml2ZXJzIGludG8gb25lLiBUaGlzIHBhdGNoIGFkZHMgdGhlIHRpdGxlIGZv
ciB0aGUNCj4gY2hhbmdlLCBhbmQgc3RhcnRzIGEgbGlzdCBvZiBJbnRlbCBkcml2ZXJzIHdpdGgg
dGhlIHVwZGF0ZS4gVGhlIGl4Z2JlIGFuZA0KPiBpYXZmIHBhdGNoZXMgdGhlcmVhZnRlciBqdXN0
IGFkZCBhIHNpbmdsZSBsaW5lIHRvIHRoZSBsaXN0LiBQbGVhc2UgcmV2aWV3DQo+IGF0IFsxXSBh
bmQgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGlzc3VlcyB3aXRoIHRoaXMsIHNvIHdlIGNh
biByZXdvcmsNCj4gYmVmb3JlIGJyYW5jaCBpcyBwdWxsZWQgdG8gbWFpbi4NCj4NCj4gL0JydWNl
DQo+DQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vRFBESy9kcGRrL2NvbW1pdHMvbmV4dC1uZXQt
aW50ZWwtZm9yLW5leHQtbmV0Lw0KPg0KPg0KUGVyZmVjdCBCcnVjZSwgbXVjaCBiZXR0ZXIgdG8g
aGFuZGxlIHRoZSByZWxlYXNlIG5vdGVzIHRoYXQgd2F5Lg0KDQpSZWdhcmRzDQotUg0KDQo=
