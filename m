Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C1D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:52:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5FD0402E4;
	Mon,  1 Dec 2025 23:52:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 084BF4021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:51:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764629519; x=1796165519;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hcJGc6xyVedpW9Lh04Ps79XjO9AP47131B1+Q0nbsmA=;
 b=je8iRo/orTAS3AW3hRzNm7PSAHOpWsNb3Y/dixgW83heCB/Tzt6/Tdd2
 +Koz7tg3AHXQC8w9bHDmUtmM5NZr4aBqK3yAp41g5bM5/wGzE7U3Nwx+E
 Q04sfUF87s6GSYckahlqczvvtGAaHI5gnGbcPZMVKUwvzfpF8NP/m812b
 AF8h6SrAAFaQvpNbU7wX6rcfzlNKkb91yPD+w5yraeaFn4d9ELQ5yuZQX
 2tnrNfn0QXEFmFJsNMKoYYOAdOn2/46dfO5+hQr7H9JNrnhSUE6L+Y7Rk
 9c0rxz6SiMGpEzlTBv2b2AaftKhIaLDVQ5wog+HhmGoV8+tOg+ikAIb6G A==;
X-CSE-ConnectionGUID: bDYC0IuXRCCIc2VU4uYa6w==
X-CSE-MsgGUID: lVeZhARBQtaauNseccwHtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66748214"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; d="scan'208";a="66748214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 14:51:58 -0800
X-CSE-ConnectionGUID: 38RC/k2hRHunQlmVcyC+kg==
X-CSE-MsgGUID: PKlwRRlsTWq5VHfqzRkcVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; d="scan'208";a="194029039"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 14:51:58 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:51:57 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 1 Dec 2025 14:51:57 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 1 Dec 2025 14:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r62tbzyJeVtqdVy/b3930hVQCZdY2d4wjK9da7YNSneGJdopW8Wv98y7cQkww6gBL3V0CHhyfNnwMJ+dFBNQTojk35rHhlRsZ1IWZgBr1m0DmCdwQNwn27fGigB87mLIxk6eaHuuej2AAC3UhR9sqvN6QGDXukEznS6tbYatd7a3+94q/ZtSA35/dzqzv7pLYVAOKoN44JBh7PrS0NC4VTFAmG8YvD/8R/LYVUeQB7302xm+V3fUZ1UFiNQ4o3j1/olPvOdvVmd/BvlkPpOAIcH3RcHobqE2Aqk0x35DTbi+rdmmRLMgH4n+6K+9sT8Tcu39X64PihBPw4GN1Kjedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcJGc6xyVedpW9Lh04Ps79XjO9AP47131B1+Q0nbsmA=;
 b=WFT8SU0b+tHQ2X8VO5iRW1zUsedS+z+eVnZ2G28WQwXdQ7C9bl7hITKZgPYqtLfMCE5fRdoDcNtsw/ZNjJq4y6rnh1+hZaCau26gbVDPCo6fKbCszSYVUfT6/2yJtodL3cTXxbodc4TePmtcPU58E0Vuw0E1I2eGlAZE9/5YjivFZ8VkUX6Vl68IVUlYwEQHj71shCOP5Gii/kAdKziBtHQoEONz3GwtOH+sy6Wx10RwkiSeleec2CocqbyLXTZzlUFgj31wQTZezQQQmBWTdWCYeL82Rm0C0ICIvgs251gYMB8UwaOR5qtf+B4N6Yma9vgwNyby1XS2ZbSIYtQ9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB4992.namprd11.prod.outlook.com (2603:10b6:a03:2d4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 22:51:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 22:51:55 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Hore, Soumyadeep"
 <soumyadeep.hore@intel.com>
Subject: RE: [PATCH] Revert "net/iavf: fix check for PF Rx timestamp support"
Thread-Topic: [PATCH] Revert "net/iavf: fix check for PF Rx timestamp support"
Thread-Index: AQHcXvYaRgSlB+JW3Eym0AUQTIxRHbUGQZSAgAGrqICABX778A==
Date: Mon, 1 Dec 2025 22:51:55 +0000
Message-ID: <CO1PR11MB5089B6E1F71F2726FACED400D6DBA@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20251126165943.1536164-1-bruce.richardson@intel.com>
 <CY8PR11MB7747612256CC34D33443EEABF9DFA@CY8PR11MB7747.namprd11.prod.outlook.com>
 <3833052.e9J7NaK4W3@thomas>
In-Reply-To: <3833052.e9J7NaK4W3@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|SJ0PR11MB4992:EE_
x-ms-office365-filtering-correlation-id: 3bd5420b-46be-4e53-ceb6-08de312c3a33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?YXlFWVhuSTE3QVBVVkNVcW1BbDVSbkJBb3NPTk82WnM1SHMzL3I2bzhJWTR0?=
 =?utf-8?B?dWZwRGk2RmplRmh0L2prdG5UV1VUbzZ1aWVQWU1LcFJlS2RVYm9HQkQ3bktP?=
 =?utf-8?B?QUloYmRxZUFUbVVwNnJ5Rnc1clhieUpFVWNMRlRIRWtWUEtIenZlclloOURj?=
 =?utf-8?B?eTIzUWs2M2xPOFRCWVdWUjlMV0FEQkt1NXQ0bnhFRXJSMi8zbXJlZ3RHWW9T?=
 =?utf-8?B?bXV3QnVIV3oxR0R1Z1FSK051cllZRzdCL0QvSjIvQlB5TytkNXBkM1RRL2Ey?=
 =?utf-8?B?OFpWbEMydHkyZ2pJRERLWEtNWUNpZW9mRU9SRWJQcUJQRllvVEhTRi9wVVk1?=
 =?utf-8?B?RVBzTlROcUFCa2NmZFdxcHY2NXpZN3RlM2t4eWZQZUhpWlQ3QzhiYlB4ZGJE?=
 =?utf-8?B?NVNWN2szdndXQ2h4bjFvMUEwbmd6RGxYOEZNclcvK05hWnRqb3ZBVnQ4b0pr?=
 =?utf-8?B?b0EzWk1EMzhqeWIvVjNFUzAxcjJZSmlDRDFpRTdMMW5ZWWpYWkE1VW5Ta2dM?=
 =?utf-8?B?Q2x3ME9KeVY5VjBYazZwOVpKUE1WTHpDRFlPekQvSUlhTmJzbGNSRTkvdUpF?=
 =?utf-8?B?VERKTFE4aUsrZHptS2g4U1N0MWo2bnM5T1d6RysrbWMzQjJ6QThDQkVlOThM?=
 =?utf-8?B?bVFGQXc1dmlDTjlhWE1SL0NEcXVqbjdxRlgxUFgzL3FleEJDZ2pkQUQyOCs1?=
 =?utf-8?B?d3c5aktWdTZ6MDhZMS9RWFZBNWxHanpJVmJFL0laajZpM0JxdGhRL3NYc1Mz?=
 =?utf-8?B?UDl0SUk1dlNjamt1NGRyMnJOWXpsSWptakwwczVKZGVCNXZhV2g5K0ZRbEVH?=
 =?utf-8?B?U1dFalovSEI0ZFJPV2taOWhhaFFuNFZiNTFhSEdHb1hORlF5Yk04TGUvbVhu?=
 =?utf-8?B?Q1VzeFlCUmMzKy9taEJhV1pEb2VhUnZSWWFmWHo4ZUZaR2FycDdEazNxNm55?=
 =?utf-8?B?ZkxXT1VjUUF1OE1IZVlKekNlaWVZbGRzN0RiTzZOQUlDNVN0U0M0WWN2VmRG?=
 =?utf-8?B?NnF6TUFPRFA3UHQ3L2Y5VlF1SlpwK0VKREd4R0RHWHFuZm5VMHJHR1N2N3I0?=
 =?utf-8?B?QlM0a0d0SVA0L2wzanRyZTZEWGJaTHlkVnFXV0ZnMmQ0U25waXptRjE4TklD?=
 =?utf-8?B?N0Z4aXRHWGdZRmR2V0YvOTAwSzVzNDJNRm9qYVQyVDlJVi9KaGQ4MTVTVW1Z?=
 =?utf-8?B?SVNKTW9GcktaL0RVM2V1SlhCa0VWcTFhVmp4dDlVdXhxWUc3ajJoVTgzLzds?=
 =?utf-8?B?MHNCajVaSHhBQ2RjVGg4NVk5RzcyNmRwVkhkU0l3YlRReWg3K2Z1cjhqbnBt?=
 =?utf-8?B?dnRLTVZvb2JZaHRkcjJoMGgySkt5SUZxWXFZZWNvZUgyellhd1N3WVoyVm91?=
 =?utf-8?B?SFNtWVJ2RnB0b3VGbGEwbUlxbnh2YWxpeU5tcSt5R3FxdDRLampoZGFlRE0x?=
 =?utf-8?B?M3BGaWs4YXFNaTJlaG1US2JKL0xlTmtSK1hzQTdpMkNOL0JrU012dnRJOVRD?=
 =?utf-8?B?T0pOUlUzUW0rTTBQSERpTzloSlFIWVZGT2xLTkRGaHhPOHI5R1A0a2cxTC9a?=
 =?utf-8?B?a2Z5cnNnODdWc20yZjltODcwNmFjOXV6TEY4dVgzWWt6TmZHb2RiNnh4dE9Z?=
 =?utf-8?B?c0I4SVFyRm0wUytTdlNDcmJjK1hKYUtoUXdDdXlmL0ZpL21aM1MvN0pnd0pn?=
 =?utf-8?B?bHBFb0xtUno2c1BiNjFNYXZldTE2M0F0UXJ3TWdqdFQ5VFNxRTZBbzlrejZm?=
 =?utf-8?B?b0FJUkpGeWcrSnRUWnRFVUo1NHlVcWQ4UERsME9XUUJHbng5NXBYY3ZDM3Jp?=
 =?utf-8?B?OFo1MTlpN2dHUXU1VncyeWRXZVVoMXEvZU1PVkFjRDY0Z2JEd2RBZXJ5RVlv?=
 =?utf-8?B?RlVPSDhSSGFteXpWZ0ZsMThUS25EeXphckxOWWpzeHdDY1dzUU5seWlwYWtH?=
 =?utf-8?B?UTNnQnFiUWVYckZHYnhkVTBOUW04NnZoVXkxSEZ3bEpLaTQ1ZDFsUjlPbGYr?=
 =?utf-8?B?YzlKVGV4MDlPZnZ5M2VzTkdtcEgxVDIwTjY5MzM4R3VoRG41bkFlZmhhTE44?=
 =?utf-8?Q?Pb7C4v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5089.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVFacEhsMzE4SWZvR2VHYy9NUTdPT1V3MTFTa1FvUjFXSUttaGtnWEdxYTBL?=
 =?utf-8?B?WG01ektRZDdmODZQME1HY0lCMjFmZk1hNDdnRjRiQmF2ejNITEhSUWVrSGl5?=
 =?utf-8?B?c0pEVlZ4eDFKSHNKT2tOc2NjaUNIODU4MENBeWcvYWdmRVgzZUhQNkl2bnR2?=
 =?utf-8?B?S1lmNFYzdHp4UWhqMUhUbnB5SWQ0anF4Qm5OZ0ZsUlRMMUU0RCtId2JTWDZj?=
 =?utf-8?B?eUw1Z2NHQUhiMmREMnY4SVI0NUkvL1VRc0ZrMVFxU3R0R0x4K0pOd1VZVHJn?=
 =?utf-8?B?bnlBRzJaVFZKMnBMTXpPNThTTmR1ZTFoZy9rc0tzc1R1aWs2SmJXZDVIS0Vs?=
 =?utf-8?B?WUQ4ZVArSXFUUjduYmNTaWNFUUtUUkE1U1VVWkN5TlVrbnZOVFYyZUFncE1L?=
 =?utf-8?B?c2RiMGNHMTRLTWRGZ2pGbFpQWE9IeGs1TWNtbml0WGoxc2JjKy8xN0xlYXgz?=
 =?utf-8?B?RUlkUUZkRXhWNW9YRnRVRmMxZVBhQTBpN3ZTQXdrYndvTVh0ZGN4VzJoQ21G?=
 =?utf-8?B?MnlOSHNTNkJMeDhOUkg5VURJYjBoU3ljeFg0MCs4UEI4ejFUekdZcFFYRk5X?=
 =?utf-8?B?R0RqL1FPZkc2Nm5RZjNyZFpLL2tCSXpLRGxZYldCK2pqOUpEUGxSNGZGUXRD?=
 =?utf-8?B?MmZQdVZYVmRKLzh5SUl0ZmoxZTNRMWJvWXVXY2dPQ1VibEJnR1Z6WnNkYVdj?=
 =?utf-8?B?WW5zQ05zK1ZPZmtBYnAveS9KVDg2YmJwdHZFbXcrZ2lQU1dnM3ZvYysrUGkw?=
 =?utf-8?B?L2U3OXRQcUpHQkp1RnpPVVkzV05qcUpzZnE3QzVRYUZWYVgrSHcyWXNBN05T?=
 =?utf-8?B?aWhidmVMK1RPYXFyTmFpblNhZGhVekZaUEg5Rk14Q1c0dXpzdnN3Z1RpVmFE?=
 =?utf-8?B?NVVkTCtoOVh0YVN1emZ2a3VaVVJYMHkrU09XZ1p3Q0ZvaFB5YzZ2M29GZktk?=
 =?utf-8?B?QUZ2akl6a2VXR250d21MR1VBcy80TTRyRWcyeVlGMzlaeHh3c0pwaWFhTVZE?=
 =?utf-8?B?MDhURHVPcnFVQWtIRXBNZm1HRDZFNXZpVWV5U1hNRW1aOUY0bTFiSFRhbTla?=
 =?utf-8?B?OUxVRDkwQzdGL0tFaHlVaXJMWE1SWlJMM2EzbnBPWkRqSlhnSFYyRmd2OTJy?=
 =?utf-8?B?Y2dNRVJZWUhKa1FRb204ZDI5T1hnazJYMER4RzRkdEx6a2xIN3lrYzFhTHlD?=
 =?utf-8?B?T3duMStKUzF1OU1RaWg3aUhnZTA2c05uVFR4NkkzaWN6dDZIVys5dEZVelJ0?=
 =?utf-8?B?RjZEOGtYall5ZWNNYTZZRFVPcmFKWlowaExUT0Rab3EzU3hpdVphMUhkaFgx?=
 =?utf-8?B?TytKWVNJMmozdFBxejVMbmkxcFp6NGEzWkc4STQ3VmtJOXZqQ0VML0p3dFQ5?=
 =?utf-8?B?Sm5LYUJHa25tWUpqMEc0VlBZWi9oWDdLNWNNQ3NDNWtVQmxPMU9BVkRQNmEz?=
 =?utf-8?B?aTV5dXJvK2Z2U01sQXhkcVAzT1U1VVhMVWt0TGJrNzRyNFo0bHA1VmVrKy91?=
 =?utf-8?B?T1IrYThqRlVXZ212cEdEMnByQ2V1Y1lkVGl1aTdid3NrdjZ2OWVUVlNVbXg5?=
 =?utf-8?B?cVB2ODl2cWRjd2EwZjZWRmxBYmdiRGxIQ2JuNXN6aUFBOXJTK2s0VUt3Q0Vu?=
 =?utf-8?B?L3c3ZGtMQ1d2ZkhQMzl4aXpFakV6Z0wvT1hXODhQZDlhOUI1eTlhdllwOWx2?=
 =?utf-8?B?MFV0ZEZHSVI0alBmN09EQktiZUZ5SDQ0Zm84bXpOUlFJaGx1ZnZqU1ovR096?=
 =?utf-8?B?WWpCM3RoQks0aUhrcHRqdllndFd5cFlSeXpLOGx0ckszNUZVYU0zVHJvVnJV?=
 =?utf-8?B?THMxVDVrbkNXUXUwbXpDdlVicVgrNHA3QjNNYTd5NFJBazNmbUFza3J0T0F5?=
 =?utf-8?B?QW1kNnVsNGhOZ0RTcExOc0V0dXF3S2hkZ0hSdkpYVGwxeXd4Mi93RHJUeTVS?=
 =?utf-8?B?eUVxTGgwQWlrUTlrRTVJZkUwazc0NXhtN0JHcnkzOEJsNUhGTlFkSk9FdFJy?=
 =?utf-8?B?b1h1QlBXN2hTRHdUaXFWSEZFUzE2bzFNNzQvVk0xWUN0dlQvaUk1NGFQem5u?=
 =?utf-8?B?Q2FlS2RpWXBtOWtDN0U0b2IvUXNJcVpLczgyc0JrQUV2QTNyVkQwK3ZFSURD?=
 =?utf-8?Q?z01DMCc5SCli1fyJQ9l+09G47?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd5420b-46be-4e53-ceb6-08de312c3a33
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 22:51:55.7588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Au0alKxaBiX1W1Sc/1epGF0CQkGaxaEvmgjwgAUaQDp1EgDofD1H+6uICXXoFQUuIDCDT0Eru28cyEXC+dAMfBpKXxvxkQRl+zFN4MU0voY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4992
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI4LCAyMDI1
IDI6NTYgQU0NCj4gVG86IFJpY2hhcmRzb24sIEJydWNlIDxicnVjZS5yaWNoYXJkc29uQGludGVs
LmNvbT4NCj4gQ2M6IGRldkBkcGRrLm9yZzsgS2VsbGVyLCBKYWNvYiBFIDxqYWNvYi5lLmtlbGxl
ckBpbnRlbC5jb20+OyBIb3JlLCBTb3VteWFkZWVwDQo+IDxzb3VteWFkZWVwLmhvcmVAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgIm5ldC9pYXZmOiBmaXggY2hlY2sg
Zm9yIFBGIFJ4IHRpbWVzdGFtcCBzdXBwb3J0Ig0KPiANCj4gMjcvMTEvMjAyNSAxMDoyNSwgSG9y
ZSwgU291bXlhZGVlcDoNCj4gPiBUaGlzIHJldmVydHMgY29tbWl0IGQyMWMyZmU2ZTVhMWVmMWU3
Y2M5NDkwZjU0ZjM1OWRiMWNmZDUyODMuDQo+ID4gV2hpbGUgZml4aW5nIGFuIGlzc3VlIHdpdGgg
ZW5hYmxpbmcgUnggdGltZXN0YW1waW5nIG9uIFBGcyB3aGljaCBkb24ndCByZXBvcnQNCj4gUngg
dGltZXN0YW1waW5nLCB0aGUgb2ZmZW5kaW5nIGNvbW1pdCBicm9rZSBQRnMgd2hpY2ggZG8gc3Vw
cG9ydCBSeA0KPiB0aW1lc3RhbXBpbmcuDQo+ID4NCj4gPiBGaXhlczogZDIxYzJmZTZlNWExICgi
bmV0L2lhdmY6IGZpeCBjaGVjayBmb3IgUEYgUnggdGltZXN0YW1wIHN1cHBvcnQiKQ0KPiA+DQo+
ID4gU3VnZ2VzdGVkLWJ5OiBKYWNvYiBLZWxsZXIgPGphY29iLmUua2VsbGVyQGludGVsLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBCcnVjZSBSaWNoYXJkc29uIDxicnVjZS5yaWNoYXJkc29uQGlu
dGVsLmNvbT4NCj4gPg0KPiA+IEFja2VkLWJ5OiBTb3VteWFkZWVwIEhvcmUgPHNvdW15YWRlZXAu
aG9yZUBpbnRlbC5jb20+DQo+IA0KPiBBcHBsaWVkLCB0aGFua3MuDQo+IA0KDQpUaGFua3MhDQo=
