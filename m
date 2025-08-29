Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEFCA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 10:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1C140263;
	Fri, 29 Aug 2025 12:18:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id BBAC34025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 12:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756462697; x=1787998697;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tRnjKboKlTQpUIGrrEg+odueazCIEVrLHipE4300TRk=;
 b=a3VdxyHzCqSDpDenUYGGQymjLob8lasbuM6XPt+kDJ/L7snCQhwiUcNv
 U+VshJHwMkvDFaH7JR7XVywbKo0IoIdAccEDz6NP+hPIDgQpi+xP/llTD
 X+JyLVkRXswQu0DizSiSx+q/U5kYKGX8XsLisNF+lb4LZcfnr7iJEx5wp
 YltnkZkymyiTvgpyKrZkY8AhmeUy6uPKrItmwNdhBv1s0TOicR/Awg0ZZ
 SId/kpfepjVVCSKhB9hCXXU5p3T/hVmvGySMOk/loodGBvjmJ/ba7CkkP
 /ANz9oKLYCUpG4aqFxQqA3tNAMjV1b4thdVIz7lDLnTyrdcP+RNYvsO3l Q==;
X-CSE-ConnectionGUID: Tid3Z1TFQl+JYZFzsGFkHQ==
X-CSE-MsgGUID: kKZZScAjT+WQ9v7b6r4NLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58811892"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="58811892"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 03:18:16 -0700
X-CSE-ConnectionGUID: k5CYP4e1TSeEDHbCiZxaOQ==
X-CSE-MsgGUID: lKN6nqn7RUqcWH3Dxy/YAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="174703391"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 03:18:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 03:18:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 29 Aug 2025 03:18:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 29 Aug 2025 03:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCKAFRC3ou2wMH1x+o860xAb/avqgmxjGyglm1dvK/3CN0KGsGG13sNNVATQp8or44zfO1eLbLJ+yU41zaKoZHNMvUQypd33DyWO+ysgtW7vD9lgRLWvYpWNTObTbUIF1F3pIBi0tQQdaaIX/LmuGgELY646YOAr/Rz6QR0S4Je/naJ1dECxKd8Qsx041AL7g7ICjsHBsjtOecvtGTPtDkXEzOKKd3M6JqOD16zUbbDMT4qHZzR1p/7H3pjD+O9LIof7EZpo1KHQPc1rIbSujTc8cYnr2dHwarKChUaULLHJ4QnUmYzT9NCZtrNYUFcK0dWvhKjc0sTQWwrp3vaDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRnjKboKlTQpUIGrrEg+odueazCIEVrLHipE4300TRk=;
 b=tCpIf11XGa6wgzpLEFlHoRFWhwbWgLR72BwWbPEJF8mcwZZlukqf4VCjdY2xIUYi/jO56Q1zFty9Avp/GaiiXo0LnKU79B1VUCtYnj4UfrXRz4Ve1NO9QvuLja5wzXKmbXHtgn9snj39mklnzZ/k6UlkVR24JRw0RYYGFRpu0kFNbi64++kvHV7WhE0/SvxMDSKNplMNgPSRJVAEuzYh747kRSm7GKTHzcqvlFGS5S6RY7thQKAp6HYhhPDRDCIzIuRBEmAcEZ2eHDomPK8vavF7ckcBmsEOZpyuCLWUW4dEP3bw4Wgihqh4b3rxC4BeAtTNrpYHrzUW0GT2UsUOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7845.namprd11.prod.outlook.com (2603:10b6:930:72::18)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 10:18:07 +0000
Received: from CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::bf13:a047:3bb3:3cb7]) by CY8PR11MB7845.namprd11.prod.outlook.com
 ([fe80::bf13:a047:3bb3:3cb7%3]) with mapi id 15.20.9052.023; Fri, 29 Aug 2025
 10:18:07 +0000
From: "Finn, Emma" <emma.finn@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4lYAFyVfvK0EK1wLnj+HAwKLR30B4AgAGYqhA=
Date: Fri, 29 Aug 2025 10:18:07 +0000
Message-ID: <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7845:EE_|IA1PR11MB7869:EE_
x-ms-office365-filtering-correlation-id: 879e3c8c-54d8-4761-d51f-08dde6e55929
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dkt0NXFJL0pTRjBjZmhkd2Z4ejMvM2xOMmIxNWRiY2pYeTUxZXp3RDNzZFhm?=
 =?utf-8?B?QXV1bnhxTVExTWFpWHBIUWhJVXVReUJrTS9TaFhQRTI4MmNHd0VtMXhaaW9G?=
 =?utf-8?B?RDB4TSt0WTNONHIybitxT2dlcCtsdlhUQWEzRlQrbHg1WlkxNmlvUDMralFM?=
 =?utf-8?B?Qmp0OEFDMVhwOTNMS1RTTloyTFc1ZU1SV0JwQkFyZ2JCQ0p4dkFhdXRuTGlE?=
 =?utf-8?B?amlKRHB1dGNSY2dhZXF3ZVE2UStWRHBNSzc4TUl5L2xHRHlUakxjZURiMVgr?=
 =?utf-8?B?TmpibTExVzVjYm5uRDJFc0pLS3g5aXdQQk9MSFBSVkV0cUtUY3RSbk00V3V1?=
 =?utf-8?B?U2MzUDNKNkg5T2VUYk85U3dwOU1PMWgreFpiZlU4dG5OR2xpNUR0d2FXamRx?=
 =?utf-8?B?emdBTXVWR3RMQkxmekxudzdxS0NpN0MybHJUdE5JMFpZdCtDS1Y4VUZscFBT?=
 =?utf-8?B?OVBXcktBekQ2YnI0U1Yvb2lmbG5IN0hLRTFnN3luclRjL2tpTlRSUWFuMjl1?=
 =?utf-8?B?R051QlNwQTZuYk9ub1luMXZBeUVRMmZHbndsZlFIQ1V5bVluSjRjbFFqczlx?=
 =?utf-8?B?UkdjSjRkU3dzajZHOU00eFpBR3daUlpUZUpqbmZxM3ZuT1VWOXJGOGVZUE9O?=
 =?utf-8?B?U1NlWmJqNFdOSWNESW9DS0dhbU1HZGk2YVVWdjZONnA4NDJWamlwWWFLMmdN?=
 =?utf-8?B?ZUNhTUJoL2VtTlMzaVIwaXJOUUUvTFB0dE41KzdFQ0l4YytoL0hqSWZJVHRk?=
 =?utf-8?B?TDlxbmZBcjZwb0MvSXNSTXBFZnZJbmpmUVZGbkIvakFBRDJ6VEpHbzVmUnQv?=
 =?utf-8?B?Umt2M0xyUGFDdUhIaHdwbmhha2R0dlV4R25oTEN6OVF3TW1UMXo1bUplaXF6?=
 =?utf-8?B?UWNySEpDK0lXOCtTQXZmQ3VOVHUvS2NwN09ycjZ3ZzVScXdwMDlQckdxSUd5?=
 =?utf-8?B?Q2g3WVNpWlk2WGtjMmRDdU12SzZPUnJybTRyMGpMS0ZwZ3RnYUg2NnJYS0dt?=
 =?utf-8?B?OFlLVFVHRWdjWmhITnptQkFUZGd6Nnpad25zbjBPVVFmdlg1NWNBclU1REl5?=
 =?utf-8?B?ZGMxbXpvejhSVGE0ODkxaXBqS2tuYzhOdWcveUYwOHlzOWhUY1dKNERmS0o1?=
 =?utf-8?B?Qm9Ud3dOMUNCU3NoZFhLRWZZNW1Sc1kyS2pNMXJQb0pwbDU0ZHZqMC96YWFX?=
 =?utf-8?B?ZjdhVzVvZDQ0M25QWVFKWEZPaG9oZVhWU2tOdXpnUEhvSWltQWZwUzJWby93?=
 =?utf-8?B?UVpEK0U5QVU5TlA3b2R1TVJKekRTakRoc0RwbXNXRFJybk1KTk9RVERWZkw3?=
 =?utf-8?B?Q3k0WTFpYlZxcWZtb2ZPNUZybnB3bnBqR2ltUE9XdlBuSUtVYkdEdzExVEJP?=
 =?utf-8?B?RUF1OGdYTmJQSGY4TGF1TEFKNCtUSTEwMm1mTk5wZWkvdk1NdmtYSkNkbzN6?=
 =?utf-8?B?eXBXQUZxUk9iaDVCQ0JUc1BYK3poVERsN2ZseTh6SkxkWDI0ZkZHNFdzeDVR?=
 =?utf-8?B?Zk9MeTdWaG91WFJZZlhNc0owSzZLZEJ0ak55dmlycVBrNkY1OWZKK1dpK0Iv?=
 =?utf-8?B?TVp2eDFWTWIvdXVYTDR5RFozaGcrTnQwdFlKN1VKYkdGZ2VZWndKWndpMTVM?=
 =?utf-8?B?VTk1VksvdGhiR1pTQXdlcDBjL09iczFudlZzMEhoZUwzL2pmck1mdFR0OXQw?=
 =?utf-8?B?NHRESXhLd0FoMkxORVVyamJpbFVIcis4bWlFUnRrWGk4SFNKSjV1SVNoUkxF?=
 =?utf-8?B?bHVZdjhWZnFRWi9CRnUzM3R5VVkxNkJGZytVWVhva1BsS3c5Q0pOWUZuZGov?=
 =?utf-8?B?LzBFbVJ2RUVvWHFYRGtoWW1OMTV4SU84eEFOQWoreHJyQ1I3RVdqK3hoVEg3?=
 =?utf-8?B?MTVrdUYxTVFtN2ZFRlJhdlpTS1hVY2NZTERpaGdwL3JqZzJ5Q0U0RFY2dkg0?=
 =?utf-8?B?SmVXaDFQQnk4cEdxeHpCMWJYTXpMMmtiU051NFlwU0M3cm81YTloVEFsRFpm?=
 =?utf-8?Q?1+Tk4cyNBBET11UhM3zuBTum6vYzX4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7845.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjlaWFArWGsrQkxHNThXOTFsZFJFaFp3VitvYnlwQ3g0bTJzLzU3ODJRb2F2?=
 =?utf-8?B?ZlJQaTkycWVPM0YwdFo4ZXM0clVXcXRsS3E1V01mSmFSbWRkTjhmTEJvb2dZ?=
 =?utf-8?B?M3VNMmtwanJYczFUa09lSFl6d0ZNYXFLb0dkeEo4K0JhZTBJbC8xOFFNTkFC?=
 =?utf-8?B?RTM4QnBQWTI0bWt1VmNQaUc2UHBFbkFSMllrWVRCNnhqNVp4SW1oMEZqdHM4?=
 =?utf-8?B?YkxnQTlsRzJyUG0vNEt5azJwakdkdEJvS0hsdHhaMVQ1eFpWSGxRZ2NZa05n?=
 =?utf-8?B?TjRaNHllTHFPa3lPY1NXeUsyelNOSkpFYmlLNEhaSTVTbFptMzE5YlZYRU0y?=
 =?utf-8?B?Y1BlTllLNTAvc3RWK3ppTXBweVN5Rnc3NlJEREY2Rmc2Sm10WE1RZFJ4bHB4?=
 =?utf-8?B?MnVkbFpEMUVaZjVxblNUU240bmxtRUpoQzBHSzB6MXVlVkJ5NkhnTkg3d0pC?=
 =?utf-8?B?WWJKMTlCNHRjV3l2cENpelRHWTZPOTNkbXVETnJBV2h2ZVlNb3d6am9mUENP?=
 =?utf-8?B?ZlRYWlRBTDFJRnJ0T1hRUXhpZk8wSHNKZGtDMjFLeXFxS24xZTExNDJ6TWNa?=
 =?utf-8?B?ZVR5eVJ6T2RhQ3pCRHFjREtkQnFYWTdTVTd6R0FOcUtCSml2eFZOcVRodXBI?=
 =?utf-8?B?dFpMVUVCMDFMOHQ1cWRZcnlOM3dvTmNENXhyL3FkaFNZekhEcGUyQnNQcng4?=
 =?utf-8?B?YkF4NFp1MUk0NzRhbzNYTjJhdmRXMVUvelE3dU5NWG9ZVWdmYndXc2oxRDRT?=
 =?utf-8?B?QlRmaFo3OHNsT1cxbzBnNUdKZFB0b2d6ZGNGK1hpMTNsK0dMOEVyU2VRZEF0?=
 =?utf-8?B?c25VM0svNENySUNrNnRIY1dGVVZ2NW1RRWNjaUZVTHM3T092MmJMOXpTRkla?=
 =?utf-8?B?NEVGSkFoQndCZU8xQVVNWkliTElQeXRaQitYblg0T0pENXNja3pISVRLSlBL?=
 =?utf-8?B?UXg0cDJSdWhzNXFUaFgxZVhNQVljYW9jd3NlS3l5MitZZmZzUlhMcjRIOWJt?=
 =?utf-8?B?VWV0Ny9WdW5wdDJQTkJqUWEzMStqQ1hYVnI0R2FkMFF1eWF1WmhlOWxLR09G?=
 =?utf-8?B?bTBvZnVsM1YxdXlWaFhHdjlBVFRwOFBIOVZjZkRNSytMNG1PMWhzWDFZRU44?=
 =?utf-8?B?UGVKOXBHRERGU3I4RWtBUFFqUk8xTWlUZVkxalFjYzRHV3FEUU1OWmJXY2VI?=
 =?utf-8?B?eG41TlhZTVp5MXFqNVVXV0RLNitDeUx5NktFVlozelhDWi8xZFVGY1lBUVpT?=
 =?utf-8?B?UXVqQUYrczk0UHF1S1B1WHRTVEpsRW5Ma0I1cXRtN3FuL3ZhL1pCejNUb0xr?=
 =?utf-8?B?UEJUQ0FROXNlRkNaSG1ETWRtMktiM1lscWJyS1lZNHV4UEVTbGZjZUpqUFhz?=
 =?utf-8?B?VytwZ3dxc3QraW40bG1acSs5Q21vQkVDUDFTeXZpRUNCOXcxTjJjOHYzWmY1?=
 =?utf-8?B?aGU2MjFlRmNDZjdMQjZqMW5XblY4elgvaHlBVGdFYjVtbVV0MURwTElBRlFM?=
 =?utf-8?B?MWxXOGVYL1k2Uk5qWEpCWkQ3dFhGbHpZcmhrQXV0MVFDYkpuWjZONHc1Smhl?=
 =?utf-8?B?RzhNeXJ5WmUwblY5aTVqcnNpcndqVFNlRzQ1NUxqTXZHU0FWWVRIWGhMbGhp?=
 =?utf-8?B?ZUJwdHU3Wk41ZE9ua2REOVJtWFhFcmo2bENIT3JETVFNdUN0bjVIeGowcVpp?=
 =?utf-8?B?Z3V6WndJZG40d2V4US9JTHB2dWVPQ0lQVzQvbVdzZCtYNS9TbjhPR2F3dkFG?=
 =?utf-8?B?c2o5OXFzUDhudml4dFVUSExSeThqUGV6eG9YRWxYUkh6Mmx4eFQzNG9KYjNV?=
 =?utf-8?B?SGJoVmhUdk9iRVF6TTg4aGQ2ZTNTeVRaU0FlMnpzdURSM09sV2hjTzZCdzg4?=
 =?utf-8?B?elNBQWczU2xoZE5VSFVSdU9TVUpWSWZFZEhtYjU1Y0JKalE2NjdCTDdjL1A4?=
 =?utf-8?B?bHB0R0hVV2RWNXlZZFFXZHhZL0pDbDQ4TFNlTUhGeEp4Zy9aK1AvU0ptQmlV?=
 =?utf-8?B?YnJ0V2N1QTlzSTZBYUFUMGk1dEQvSmxrN3l5dWd4cFRHdWs2SXpkZlB6WEJN?=
 =?utf-8?B?dlFZMytIUEh1M0J3U2tkWURvZW9JVFE0dWROVlNNUzAweVNSY2hrK0V5b1BP?=
 =?utf-8?Q?gJnbGajbEzCq2OMVSowPnWv04?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7845.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879e3c8c-54d8-4761-d51f-08dde6e55929
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 10:18:07.3982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsNzgtZi4qPhV0F8BvOIOdseMDNhCGQdU0TYZ9o+UHq1Vfob1GAFMelk/dPmiCWgysTCRKRfK0grrxnKv5SE0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHb3dyaXNoYW5rYXIgTXV0aHVr
cmlzaG5hbiA8Z211dGh1a3Jpc2huQG1hcnZlbGwuY29tPg0KPiBTZW50OiBUaHVyc2RheSAyOCBB
dWd1c3QgMjAyNSAxMDo0Mg0KPiBUbzogRmlubiwgRW1tYSA8ZW1tYS5maW5uQGludGVsLmNvbT4N
Cj4gQ2M6IGRldkBkcGRrLm9yZzsgSmksIEthaSA8a2FpLmppQGludGVsLmNvbT4NCj4gU3ViamVj
dDogUkU6IFtFWFRFUk5BTF0gW1BBVENIXSBleGFtcGxlcy9maXBzX3ZhbGlkYXRpb246IGZpeCBk
YW5nbGluZw0KPiBwb2ludGVyIGZvciBTSEEgdGVzdA0KPiANCj4gPiBTZXQgdmVjdG9yIHBvaW50
ZXIgdG8gTlVMTCBhZnRlciBmcmVlIHRvIGF2b2lkIGNhbGxpbmcgcnRlX2ZyZWUoKSBvbg0KPiA+
IHRoZSBzYW1lIHBvaW50ZXIgdHdpY2UgaW4gc29tZSBjYXNlcy4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEVtbWEgRmlubiA8ZW1tYS5maW5uQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZXhh
bXBsZXMvZmlwc192YWxpZGF0aW9uL21haW4uYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZXhh
bXBsZXMvZmlwc192YWxpZGF0aW9uL21haW4uYw0KPiA+IGIvZXhhbXBsZXMvZmlwc192YWxpZGF0
aW9uL21haW4uYyBpbmRleCBmMjE4MjZlOWQ3Li42MGVlOWY4ZGQ0IDEwMDY0NA0KPiA+IC0tLSBh
L2V4YW1wbGVzL2ZpcHNfdmFsaWRhdGlvbi9tYWluLmMNCj4gPiArKysgYi9leGFtcGxlcy9maXBz
X3ZhbGlkYXRpb24vbWFpbi5jDQo+ID4gQEAgLTI2MTIsNyArMjYxMiw3IEBAIGZpcHNfbWN0X3No
YV90ZXN0KHZvaWQpDQo+ID4gIAkJcnRlX2ZyZWUobWRbaV0udmFsKTsNCj4gPg0KPiA+ICAJcnRl
X2ZyZWUodmVjLnB0LnZhbCk7DQo+ID4gLQ0KPiA+ICsJdmVjLnB0LnZhbCA9IE5VTEw7DQo+IA0K
PiBTYW1lIGNvdWxkIGJlIHRoZSBjYXNlIGZvciBmaXBzX21jdF9zaGFrZV90ZXN0IGFsc28uDQo+
IA0KR29vZCBjYXRjaCwgcHJvYmFibHkgdGhlIHNhbWUgY291bGQgaGFwcGVuIHdpdGggc2hha2Uu
IA0KSSBjdXJyZW50bHkgZG9u4oCZdCBoYXZlIGEgd2F5IHRvIHRlc3Qgc2hha2UgYnV0IEknbSBo
YXBweSB0byBtYWtlIHRoZSBjaGFuZ2UgYXMgcGFydCBvZiB0aGlzIHBhdGNoIGlmIHlvdSBjYW4g
dGVzdD8NCg0KVGhhbmtzLCANCkVtbWENCg0KPiBUaGFua3MsDQo+IEdvd3Jpc2hhbmthcg0KPiA+
ICAJcnRlX2ZyZWUodmFsLnZhbCk7DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IC0tDQo+
ID4gMi4zNC4xDQoNCg==
