Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B9CD64092
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 08:39:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D547240275;
	Wed, 17 Dec 2025 09:39:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 528074026C;
 Wed, 17 Dec 2025 09:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765960749; x=1797496749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MObTsnQB12++XSYEMTwO8ZqeCqS0PDwP0lnj+qpe9mw=;
 b=Sy4SvcqxCpQAHNTNXaceJDPfxAGkTFKfZG+GuP9UCa2dPxgZ/RM8WBSl
 DN5C/Mt+kxlT+wdDpHkJ55q/jjwPwofdHIhao2RoICIUScYTly5K6P290
 hAtelXB14wxagctTkSLISN24ssA1f/8teDWx1Rtl00gogABsc1r7KSFSj
 f4QXepchX+ri1Pq7agv+LU1n2zz6anGdg47Fh5geIH0BqJxSvy8eKAUDl
 44RYZbT9qhOIf0dCKQnBzVdST2gogPDpjaiBuRsF0t4o4XGQAMjAZe6Bk
 t1kGbMQucVTElVBGECjzysK/V09L2/YW9oviP88lOth6mYJEs+BwVAp2x A==;
X-CSE-ConnectionGUID: TMsneJtsQXiin6DZj51+CA==
X-CSE-MsgGUID: CefIWE3KRn2qK9ubHMWgtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="67086498"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="67086498"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 00:39:07 -0800
X-CSE-ConnectionGUID: NlzrxsrkR8CQYepeCqXcNw==
X-CSE-MsgGUID: n8NO5ZweRWaO0N0/nxECtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="198511664"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 00:39:06 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 00:39:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 00:39:05 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 00:39:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+HDsePDAWLlF39e1eIR3666TgC/dU38sY5MeYxr9kCBEbJSgPK2Dz/0DZJUnODjmYDCzYMH4jMeFoGCKdV3RDcWo2TkRzkydFbKMwRMaSkjv9umlUfriPqsgm7vbyjJJfxBTcYJcFESAodj0dm88Ec89olQ2GG2hucuHLQ7YZBniA9v+RcmcFmKedvAMd5O13OtDDavmFxUr2h9gdGOSwuux7Qfj3MY7C5b4ZzxoYpmy716FF1tEn25Mi1lcKF13uREiRO9z79T+TvTwlkklNT0CYlLkS4XmO0C6H6damHiDqiqpdAUjMaxnJB1Nf+9SHYqW9qE4nzWFW1u6wp2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MObTsnQB12++XSYEMTwO8ZqeCqS0PDwP0lnj+qpe9mw=;
 b=QAXmE2ncW+UTDilfnfjbi/o5X8ck4jZKHK8/A8k/Hb69xkvj10r4aEmmLVeGN+qJ3GNCqvS9mSSnuNFrsrADFMnRlPGaU+ySJwvojoLg6xhYm6IzHu7ScSeQlXyQhp2vafDWvQ9U6iGNVHyD89YpX8e45hDIhFdFTmU1Mlasn+lOA1D9mIYKEqI8tkwAVrcchZbesf+wi3Ox7MZiLYDCZSblGnyTVFUo5WxSkpECinurnLLdOeJMvZkFoaRZ3+rdvXkqo4zLz/yzIEfLmAMNUODI6Zj24Cufeth5AwRWrwpMu/k9UpL/TR49dmgND4PnfZDQ3LWOP/gzKpTScX/KQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::806) by DS0PR11MB7406.namprd11.prod.outlook.com
 (2603:10b6:8:136::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:39:00 +0000
Received: from SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::6fef:19a1:45d0:d051]) by SJ5PPF04AA7285F.namprd11.prod.outlook.com
 ([fe80::6fef:19a1:45d0:d051%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 08:39:00 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Kevin Traynor <ktraynor@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Abhishek Marathe
 <Abhishek.Marathe@microsoft.com>, Ali Alnubani <alialnu@nvidia.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>, "Mcnamara, John"
 <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, "Luca
 Boccassi" <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, "Raslan
 Darawsheh" <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
Subject: RE: 24.11.4 patches review and test
Thread-Topic: 24.11.4 patches review and test
Thread-Index: AQHcZc4Cr27PCHOFY0qSpAUzyRUPW7UllFEg
Date: Wed, 17 Dec 2025 08:39:00 +0000
Message-ID: <SJ5PPF04AA7285FC7C77D1EEC605C92DE989FABA@SJ5PPF04AA7285F.namprd11.prod.outlook.com>
References: <20251205095931.160577-1-ktraynor@redhat.com>
In-Reply-To: <20251205095931.160577-1-ktraynor@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF04AA7285F:EE_|DS0PR11MB7406:EE_
x-ms-office365-filtering-correlation-id: c413fc1d-163d-4f8c-8fcd-08de3d47ba0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?bTJ3SEUzT3hjcnlZcE9hQ1FUdVVkK2pocEdVZnBTZ3B1Ulp0N0xHSUZ3NVZT?=
 =?utf-8?B?dEduRGd6S0JjM2MwcUR6cVhrd01XMUxFUXVHSDgwTFYrT2tOSHNOV1drakdz?=
 =?utf-8?B?QUhtMFhrQUt2anRkbEdnVVlkQlFLNkkzK3BRZitGNFpDajV1MnMrYldBejFq?=
 =?utf-8?B?SnJkR2xFN2kvbXJLbFNnSUtMMjBDUUx3amZkUm9HUFpTZ3kvM1NGNk1DYzdC?=
 =?utf-8?B?TUhhaGVhd1FDNW5HazVXSHhncWU3V1p6OGdQRlZncE81L2JTSjIveHorZW5I?=
 =?utf-8?B?L2Z1YkxEYUt1amdBeXUzcFE2QU04NzF0eTZOLzdISloxc2Z3MlQ4Y0tGVmJi?=
 =?utf-8?B?STZVVFJJWFNjaitjN1FSOHlNZ0paeFNlMEdkREt1cnlHN0ZuNkk4aTBJRDZD?=
 =?utf-8?B?MDh6NVErdVA2RGVXKzNZQVhTNXZzSE9EQXY2ZStsMG4vbEUreG9nUkxjRzdO?=
 =?utf-8?B?WjJsMkliMEhsVy83dVF2a0JGazlnb3hFZlJHaEZMWmpVU1Nhc0toallrUkQx?=
 =?utf-8?B?dmF6VTI0TGMvWFNWSWdRSU9XYVdrdFJxRWp0QWpTQ25BR01ubzIzL2FuVHVo?=
 =?utf-8?B?REZ5a0Q4L3k4dDRaV1dEbXZlS2F4aWJaTU5YVVltbE9jb0F0YWpMd0FCUWpH?=
 =?utf-8?B?WHRjR3pCcHBPTTErbDBmNnp5WGEwSkZuVXZlRFZaUDdYRlVmUXN2dHBvL1da?=
 =?utf-8?B?MGt6NWEzT1Z1a0hXTkROVXZNK2ZlRUM4NE9MQXB4d05yR3dwd2Q4Y2kwQmRo?=
 =?utf-8?B?VjFCRG1vZmlwSkplNlVZQ25xQmdXVnVBV0FlT3Q1cnFGSERXMCt2ZUZ4Y0NG?=
 =?utf-8?B?VzBvU1BNWXYxTCsvT2ZnaEw2YVMwZUROUkZPWURJaFRxOHF4cHgwd0ZzRVVB?=
 =?utf-8?B?MlBkUzB6L2x4QytKTHJsL1RsWUpXYW85bUQvVDBNejdLZlQ4bGh2OHNVc0NL?=
 =?utf-8?B?UkZLMktNZVdDMFo0d0c5K3VBTkF3eWJWandwMXhJd0pWTlV0MXlpZkJuTDhL?=
 =?utf-8?B?UzJCM3pHbk9rbVk0bEVFbmp5Ly9Vd1ByV3BLaUd6Skl6TGxGZWVUVXFLM1E2?=
 =?utf-8?B?MUtWQ0NpaHpXTFBHRlovSmI1TWM4MHpJaGRMc0lzSlZXYlJEbCtqc2hKSVo3?=
 =?utf-8?B?dElyRnhCdjF3aGN0dVJlNHB1OHV2VzBHVzdnd3g1bGIwNnNkVm1QbTJUREJH?=
 =?utf-8?B?cktqYkJiRHo5YXFCZk54d25hbDFRVmc3WDQ5OThuR3BvWHpuYUJxeFJBUlJE?=
 =?utf-8?B?TWFscG16SlZqdHFQMUxnNlB6Rm94aFFveXMrR3VtNVRaRjFCL053WU4vczh0?=
 =?utf-8?B?MXZFeVdGZGt6WW9lK2dlUnlaYlQ5ckdYcHRJcExJOFE1ZkZxb1J6allkMFky?=
 =?utf-8?B?UUhhL2k0UkZ4cVNBQTNOeUxqTTMxVUFXYVFGUmpyN3c4UExWK29QSUhZbDY2?=
 =?utf-8?B?S2RaNWx1SzhmcVN1NzAwMnpTcVVudXVKekhoVDE5TG9YM1B2RXNrc3BDdTQ5?=
 =?utf-8?B?RDNSbkhnV2JzZjVWZFNHUG1EVlhvck1SZ2RLVmVrZW9yMExiNHhtOFh3MU0v?=
 =?utf-8?B?ekVBSmgrc1p5Q2IwNmE4TTgreHQzLytEZTUzQmg5bkpETFlCK3dEYlFLMC9X?=
 =?utf-8?B?cUl0MVpUT2R4WkhtY2dxczI2ZEIwYjUvN3haMENtUVlpY2NtVFJSbmxvVXZh?=
 =?utf-8?B?VHhHN2FlVnhkdHlYNno4UWhoOGM2VHBjM3dFRjJnKzN4d1RJUFdHcVlOR0l3?=
 =?utf-8?B?OEV6ZWdSWFBMTk1pNkZHYXo4WDhsbFhlQ3VNb3FicHJ4UmFaaWJMVHJlTDZL?=
 =?utf-8?B?U2o1ZkdNQ0VDYVlsSGZLLzFseG9VeEJBZmJ2MkhhNzlaM081YnpPend5NlFH?=
 =?utf-8?B?RlJPWXorZjRXZ1RKcHEzQ21pUFdmb1FNYlVQbk5YVTR4REVteDRaTXA2SXR6?=
 =?utf-8?B?WEhlUi8vSzUyM2E4a2cwODIwemptUWo5UnBsMmZVM1RTbXB1cHAwanRzbFdU?=
 =?utf-8?B?VjUwZ1gxYTJoa2p0MlNhTURXUmJNRGlWeXhrNXdGeUxDL0dqbGpUbzM5VUcz?=
 =?utf-8?B?Q0t2Rm52UE8xMXd0RGFFcGswNklrMEdrRHF6dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF04AA7285F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTljV2x1aUp6aldUVzNuK0RQZnFUVUVIc0kvZW9jdVAxWlBEaUhRbUxjbzFw?=
 =?utf-8?B?ZHpyQmUwcjRBVDl1eGV5NDRRK3VvOGZlbzBGVFZOTXZkNUVnNHZ3QVZHeUZD?=
 =?utf-8?B?dlNpUTM5dkNINWxxUTRYSGJMRG9heGU1OGphay9ydUNxUlRxdXFtNjN6b2c5?=
 =?utf-8?B?Q08xQmN1OGhqaDFtNmdUeE81OVFMdVE1b0dFd0pPbXNwVC9uWjAwOWVIWHRj?=
 =?utf-8?B?MFlBMFZwc1RIa3pZQTNyTlBXQ0hhUG9LUFFOS25nL2xtSlpzdTZtdHdnWHVG?=
 =?utf-8?B?cGdQS0VidzJOc0JGR0RKM000THVSYXJQWkx0YXdqVnZDWGIvdlZiVFJBOXdT?=
 =?utf-8?B?K2lWSnN6bUl6NFE1T29xVTNUVWZvZVJHQkRWM1ZJVjhKWVdIUEV1OW81Q3JG?=
 =?utf-8?B?R2JRRFJZM0RFdWVjTDYvT3BiNTVITjd6Sjk0ZE4zYzdaWUszZk0xNzBzR0Vv?=
 =?utf-8?B?RmViamQ5ak5UU0Y0QUZFVUMxZ2x2aG81SWc1aGdYNWJYL1dGQndtT2ZBdU5E?=
 =?utf-8?B?d21mbGNYZDJOZjgxaVlBZlpnZWRUU2ZKNzJSMWxzVGk2WEZHb09zQnlOTzhK?=
 =?utf-8?B?ZmxFTUcweWYvR1hIamcvanQ1bXUvS3NuWWVPTW53YzR2eEVWdnpoUTJqaVZw?=
 =?utf-8?B?VHFDc0JvQ3J4OEY5eGprdFMwNS85VWg2VU5lMFZrbU5MVGZ2Vnh5SDFNckNN?=
 =?utf-8?B?bFJ4N29oWGFhTG40OUdmRUd2R2dYRndYYldyUjJiSnZWT2YyMytkWW51RUdR?=
 =?utf-8?B?dm5OMnhlLytGNk8wcGRZb2hyTC9hSDJHV29NRWhVYlZCTjI3dSt0NU1ITndF?=
 =?utf-8?B?NXNQeTZNanRNdVVuUzVPdEJEdUdFYmg5R1BSaXp3SVFJS3I3eFlDYmtyRjFM?=
 =?utf-8?B?TVM4TTE1MkRxeU5JdVlFYVFKWFRUT3lBU0U0ZWk1WStLejljMlBzUUYveHo2?=
 =?utf-8?B?WVFMYzFqb25qenoraUdjdjJQVFNCVlhZNi8yQjRvU2luZG9ZblloYnNFeEho?=
 =?utf-8?B?QjVabFB1bVh3TFBoTG41MVRlNnF1ek5EK0NQOTRYbmxFZCt5Z0pZTGpOTkIv?=
 =?utf-8?B?SmJ1dlJrUjNTbVF6b3E0UDF2VytUa2s0cGdsUVBmbFdldVcwVWJUWUU1ZlA5?=
 =?utf-8?B?dEpUZzJXZWM4MGsvWWVjak14TjlJZ3FUWEpIRGJwUE84cG9PRVNEVHEyN0J1?=
 =?utf-8?B?R3J2cVk5UXBPOUpwQlBCM0RhS1djalg4NDAxb24rVXNyRWp1SVQ1eklwaWox?=
 =?utf-8?B?aCsvbVpLdTNoVllQMTY2TjQ0YUxwU3ZaZExvUXVNYUl2eG5MVjhqbmkzZ09w?=
 =?utf-8?B?czhjMkFScE9VSUdQU05hT0w2RmVKcEpCTGg1Z2diT3U2N3ZGcEZ0djdNTWtW?=
 =?utf-8?B?WUduYktaV2lETDdTRURpb1o2aCs1WkZqV3J2Y0QwUnNkeThPT2N4NGZ4cXAw?=
 =?utf-8?B?WjVUS0J3SGZGYzFYclJQdG4rTWsyeE1vQTVGcWpPR3crRUFBU2QyZFAxbzVD?=
 =?utf-8?B?amhHYWJpTTNWeXJmaXBhUURTaG01YkhUM2NYOERDb1F5c05CVHdTeU9zVENW?=
 =?utf-8?B?Y25ISnRPVmptOFZnb3hONnpkb3JZK0JlVSszOXhlUWdWTUd5TnREV0Q0ZHIw?=
 =?utf-8?B?RXZRQmh6Sm1DbDNiaFRhQk9GaDdoSlhKQUFhS1RKWUVPZW8rdUpsOHFFNVlt?=
 =?utf-8?B?L2NlQ1A5cWhVcVMxVllJaHFHUVc1eExySkM4b2lDOWJLdzUzNkdGNnYzWjFy?=
 =?utf-8?B?R0FWTDJxTXB5RFdtbUtyTTYwOW5yYWRUQ1R3alFCTGM4RTQ4cTQrNnUyVTNt?=
 =?utf-8?B?bWRuVVNlYm9pclhaTFJRQ2VFQ09namF3RkNIR2ZJVUhYUjZ2Z21OK1Iyb2FH?=
 =?utf-8?B?Z0VHd0kwUUVNSWprdHZFMHdTbElydU5mZFJqbXU2UGREWWgySEZBNUJLd0dD?=
 =?utf-8?B?eWtDcnlJbmVHWHRnSllqbXhFL3kvQ09CSjd0NHI3WS9LMjJpOVR5bm9mVC9D?=
 =?utf-8?B?eE1WK01hbjVEcHQvUmk4U0h0TFI2d1ZhbS9GMmZ5Q0dTQXAvdFVWUjBjTFdL?=
 =?utf-8?B?dlZwcENCR0xCNjBHc3dlYStCZEx6QmtlZ0FyRnIyaVJERE9nRVhhQ0J3YmFj?=
 =?utf-8?Q?Ckv3UPQL5AOdB34Gmv9uf0aeB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF04AA7285F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c413fc1d-163d-4f8c-8fcd-08de3d47ba0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 08:39:00.5973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74kmzqrqZo4zNH/Tun52zvvOVLoc1mEfvb61S9/leu41zICvA2ByWGdcHX59iLxlCiIPWnluml/UMgQXmdvaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7406
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZXZpbiBUcmF5bm9yIDxrdHJh
eW5vckByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDUsIDIwMjUgNTo1OSBQ
TQ0KPiBUbzogc3RhYmxlQGRwZGsub3JnDQo+IENjOiBkZXZAZHBkay5vcmc7IEFiaGlzaGVrIE1h
cmF0aGUgPEFiaGlzaGVrLk1hcmF0aGVAbWljcm9zb2Z0LmNvbT47DQo+IEFsaSBBbG51YmFuaSA8
YWxpYWxudUBudmlkaWEuY29tPjsgRGF2aWQgQ2hyaXN0ZW5zZW4NCj4gPGRyY0BsaW51eC52bmV0
LmlibS5jb20+OyBIZW1hbnQgQWdyYXdhbCA8aGVtYW50LmFncmF3YWxAbnhwLmNvbT47DQo+IEpl
cmluIEphY29iIDxqZXJpbmpAbWFydmVsbC5jb20+OyBNY25hbWFyYSwgSm9obg0KPiA8am9obi5t
Y25hbWFyYUBpbnRlbC5jb20+OyBKdS1IeW91bmcgTGVlIDxqdWhsZWVAbWljcm9zb2Z0LmNvbT47
IEtldmluDQo+IFRyYXlub3IgPGt0cmF5bm9yQHJlZGhhdC5jb20+OyBMdWNhIEJvY2Nhc3NpIDxi
bHVjYUBkZWJpYW4ub3JnPjsgUGVpDQo+IFpoYW5nIDxwZXpoYW5nQHJlZGhhdC5jb20+OyBSYXNs
YW4gRGFyYXdzaGVoIDxyYXNsYW5kQG52aWRpYS5jb20+Ow0KPiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+OyB5YW5naGxpdUByZWRoYXQuY29tDQo+IFN1YmplY3Q6IDI0LjEx
LjQgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gDQo+IEhpIGFsbCwNCj4gDQo+IEhlcmUgaXMg
YSBsaXN0IG9mIHBhdGNoZXMgdGFyZ2V0ZWQgZm9yIHN0YWJsZSByZWxlYXNlIDI0LjExLjQuDQo+
IA0KPiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVsZWFzZSBpcyAxOHRoIERlY2Vt
YmVyLg0KPiANCj4gUGxlYXNlIGhlbHAgd2l0aCB0ZXN0aW5nIGFuZCB2YWxpZGF0aW9uIG9mIHlv
dXIgdXNlIGNhc2VzIGFuZCByZXBvcnQgYW55DQo+IGlzc3Vlcy9yZXN1bHRzIHdpdGggcmVwbHkt
YWxsIHRvIHRoaXMgbWFpbC4gRm9yIHRoZSBmaW5hbCByZWxlYXNlIHRoZSBmaXhlcyBhbmQNCj4g
cmVwb3J0ZWQgdmFsaWRhdGlvbnMgd2lsbCBiZSBhZGRlZCB0byB0aGUgcmVsZWFzZSBub3Rlcy4N
Cj4gDQo+IEEgcmVsZWFzZSBjYW5kaWRhdGUgdGFyYmFsbCBjYW4gYmUgZm91bmQgYXQ6DQo+IA0K
PiAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvdGFnLz9pZD12MjQuMTEu
NC1yYzENCj4gDQo+IFRoZXNlIHBhdGNoZXMgYXJlIGxvY2F0ZWQgYXQgYnJhbmNoIDI0LjExIG9m
IGRwZGstc3RhYmxlIHJlcG86DQo+ICAgICBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0
YWJsZS8NCj4gDQo+IFRoYW5rcy4NCj4gDQo+IEtldmluDQo+IA0KPiAtLS0NClVwZGF0ZSB0aGUg
dGVzdCBzdGF0dXMgZm9yIEludGVsIHBhcnQuIGRwZGsyNC4xMS40LXJjMSBhbGwgdmFsaWRhdGlv
biB0ZXN0IGRvbmUuIGZvdW5kIHR3byBuZXcgaXNzdWVzLg0KDQpOZXcgaXNzdWVzOg0KICAxLiB2
aXJ0aW9faXBzZWNfY3J5cHRvZGV2X2Z1bmMvdGVzdF92aXJ0aW9fYWVzX2NiY19zaGExX2htYWM6
IHZob3N0LXVzZXIgbWVldCBTZWdtZW50YXRpb24gZmF1bHQgYWZ0ZXIgc2VuZGluZyBwYWNrYWdl
DQogIDIuIEJ1ZyAxODQ5IC0gW2RwZGstMjIuMTEuMTFyYzFdIHZpcnRpb19wZXJmX2NyeXB0b2Rl
dl9mdW5jL3Rlc3RfdmlydGlvX2Flc19jYmNfc2hhMV9obWFjOiBkcGRrLXRlc3QtY3J5cHRvLXBl
cmYgRUFMOiBFcnJvcjogSW52YWxpZCBtZW1vcnkNCg0Ka25vd24gaXNzdWU6DQogIDEuIExpbmt2
aWxsZSB2ZnMgY2FuJ3QgZm9yd2FyZCBwYWNrZXRzIC0uIGhhcyB0d28gZml4IHBhdGNoIG5vdCBt
ZXJnZSBpbnRvIDI0LjExIExUUyANCiAgICAgLSBoYXMgZml4IHBhdGNoZXM6IGh0dHBzOi8vcGF0
Y2hlcy5kcGRrLm9yZy9wcm9qZWN0L2RwZGsvbGlzdC8/c2VyaWVzPTM0OTM5JmFyY2hpdmU9Ym90
aCZzdGF0ZT0qDQoNCiogQnVpbGQgJiBDRkxBRyBjb21waWxlOiBjb3ZlciB0aGUgYnVpbGQgdGVz
dCB3aXRoIGxhdGVzdCBHQ0MvQ2xhbmcgdmVyc2lvbiBvbiB0aGUgZm9sbG93aW5nIE9TKGFsbCBw
YXNzZWQpDQogIC0gVWJ1bnR1MjUuMDQvVWJ1bnR1MjQuMDQuMw0KICAtIFJIRUw5LjYvUkhFTDEw
DQogIC0gRmVkb3JhNDINCiAgLSBGcmVlQlNEMTQuMw0KICAtIFNVU0UxNS42DQogIC0gT3BlbkFu
b2xpczguMTANCiAgLSBPcGVuRXVsZXIyNC4wNC1TUDINCiAgLSBBenVyZUxpbnV4My4wDQoNCiog
RnVuY3Rpb24gdGVzdHM6IEFsbCB0ZXN0IGRvbmUgYW5kIHRoZXJlIGFyZSBvbmUga25vd24gaXNz
dWUgYW5kIGZvdW5kIHR3byBuZXcgaXNzdWVzLg0KICAtIGk0MEUtKFhYVjcxMCwgWDcyMikgUEYv
VkY6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBiYXNpYy9SVEVfRkxPVy9UU08vSnVtYm9mcmFt
ZS9jaGVja3N1bSBvZmZsb2FkL21hY19maWx0ZXIvVkxBTi9WWExBTi9SU1MsIGV0Yy4gDQogIC0g
SVhHQkUtKDgyNTk5LCBFNjEwKSBQRi9WRjogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIGJhc2lj
L1JURV9GTE9XL1RTTy9KdW1ib2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvbWFjX2ZpbHRlci9WTEFO
L1ZYTEFOL1JTUywgZXRjLiANCiAgLSBJQ0UtKEU4MTAsIEUyMTAwKSBQRi9WRjogdGVzdCBzY2Vu
YXJpb3MgaW5jbHVkaW5nIGJhc2ljL1N3aXRjaC9QYWNrYWdlIE1hbmFnZW1lbnQvRmxvdyBEaXJl
Y3Rvci9BZHZhbmNlZCBUeC9BZHZhbmNlZCBSU1MvQUNML0RDRi9GbGV4aWJsZSBEZXNjcmlwdG9y
LCBldGMuDQogIC0gSVBzZWM6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBpcHNlYy9pcHNlYy1n
dy9pcHNlYyBsaWJyYXJ5IGJhc2ljIHRlc3QgLSBRQVQmU1cvRklCIGxpYnJhcnksIGV0Yy4NCiAg
LSBWaXJ0aW86IGJvdGggZnVuY3Rpb24gYW5kIHBlcmZvcm1hbmNlIHRlc3QgYXJlIGNvdmVyZWQu
IFN1Y2ggYXMgUFZQL1ZpcnRpb19sb29wYmFjay92aXJ0aW8tdXNlciBsb29wYmFjay92aXJ0aW8t
bmV0IFZNMlZNIHBlcmYgdGVzdGluZy9WTUFXQVJFIEVTWEkgOC4wLCBldGMuDQogIC0gQ3J5cHRv
ZGV2OiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcgQ3J5cHRvZGV2IEFQSSB0ZXN0aW5nL0NvbXBy
ZXNzRGV2IElTQS1ML1FBVC9aTElCIFBNRCBUZXN0aW5nL0ZJUFMsIGV0Yy4NCiAgLSBETEI6IHRl
c3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBETEIyLjAgYW5kIERMQjIuNQ0KICAtIE90aGVyOiB0ZXN0
IHNjZW5hcmlvcyBpbmNsdWRpbmcgQUZfWERQLCBQb3dlciwgQ0JETUEsIERTQQ0KDQoqIFBlcmZv
cm1hbmNlIHRlc3Q6IEFsbCB0ZXN0IGRvbmUgYW5kIHBhc3NlZA0KICAtIFRob3VnaHB1dCBQZXJm
b3JtYW5jZQ0KICAtIENyeXB0b2RldiBMYXRlbmN5DQogIC0gUEYvVkYgTklDIHNpbmdsZSBjb3Jl
DQogIC0gWFhWNzEwL0U4MTAgTklDIFBlcmZvcm1hbmNlDQo=
