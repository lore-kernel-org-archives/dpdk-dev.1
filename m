Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4FEE3698
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90B764025F;
	Thu, 12 Feb 2026 18:19:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1CB1340041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:19:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916761; x=1802452761;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=vszDQPtVb1LSr6a8y/TfEXdGiZiaWA5M7LkY3AwxGDE=;
 b=J8scdgPK8BBt+Mc6LOk7jzOzfUnOKdWdBOXFjy7/T2yAgyumPYQJ9neT
 qDp9LBuASqctRaFx9+xa7sgV2K/qXH3DV+Qt/LOGi4WyjbV5z4/5EM/1N
 ANBuh/oOcpXG9oA3z1VnDpsSQX+wvkqPpLCIFzEMceyf09uXVhszdbdBY
 MsmLgJQOXGVRftCl4G3NfetNqsSo1Op22FYIwVswkJj3zyWJgl0+Oa697
 mpRk9JbcAtjyjKQtzwMk0b3Zfcgo6tlF/xb8UlsSmbCsdgTZ+XJnus68W
 jELlljlkG7dZcC9ZXgH1IcD1l79EWbADMtBz5aUqfZXpw8mo9M8txmbCX Q==;
X-CSE-ConnectionGUID: 4O2NB4AfS7OEW29XHEjbpg==
X-CSE-MsgGUID: fYZeb8CSTCWZjOOUX4D52g==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75719824"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="75719824"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:19:20 -0800
X-CSE-ConnectionGUID: v0XAHiIzQiiqumg2Khw0ew==
X-CSE-MsgGUID: oygZMN1BQ421keSJgYgkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="211904159"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:19:20 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:19:19 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:19:19 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:19:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK3b0v+MzzSLLq9AUi45ue/NtC3U6qgmU4eS6kd6nl+XRF8wXfO07Zb051HL3e0B79JjCgEluU079JqxO5I1cYIj/5/aUZKM1d1IsFvMuFKIK6yMR0j6TqcLOStxp/MNjXamF6iPwqN1a8Zvwdm+RCvnhsAYyM1ElbndIfDuuOxtlwjUcZC939gSPE59g0lBYtprhVU05yWNLuOjUWYcLAVBas5mrSGNz7vPyWsH5SJiMsnjOTGAGhUtH++hZKul6AvF3H2UTJf0f6rK27Vvgl/B88BG/uFAvN36qwmgB0tbMrjBC1yCLVbFBZv85spheEQOJZ/uAGIlsXzorC7HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vszDQPtVb1LSr6a8y/TfEXdGiZiaWA5M7LkY3AwxGDE=;
 b=WbiNfi3DHS58Lj6fJkSoPryy6nojuu731jLEWJrf7ENhMxvpmoTr/ZNmgyZX+XnoQzbBfHA3isxVz1tmBfLu82mkoVTpU4YqQ97PmQxxpsMwr0VjLgfflhuoyg42w6jvOiTTaXFPXv4D5gGoYbNqsGSYCw1H1vx6Cus+UPnLeg7zugouZGFqRQCItzgx82KNiL6+a+8+f/MrQY6SlcbEEVAGHPxPV2RpDsY8HP1v7gm59nT8qnCmLPKeEPPUU6kctn1ofVHndR1QvrFavHdfi4pvm+37zgaK/iWWIJ1dM5Fek6yQW4do61pMC2YszZSW86Dq4eW+uX55EcUXUslyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 17:19:16 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:19:16 +0000
Message-ID: <407bb910-355a-4bee-9599-549e595b2cce@intel.com>
Date: Thu, 12 Feb 2026 17:19:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] net/ixgbe: fix potential null dereference in
 IPsec
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Declan Doherty
 <declan.doherty@intel.com>
References: <c90dd3517961437012e26f9f1abc5e7fa2d8d935.1770900758.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <c90dd3517961437012e26f9f1abc5e7fa2d8d935.1770900758.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0344.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::9) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SA1PR11MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b2252a-cd0f-4c46-e2b7-08de6a5ad99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1BBZ1dIdnJRS25HK1Y0MjJsMVdsMlJKWFIvN25GcktycVBmUlNDd09IZ1pw?=
 =?utf-8?B?TG5XMWRJTm5HZ3VudE5zUkczNGswUURBZndzS3ZGZThQdndZNFU0c3FpVjd1?=
 =?utf-8?B?OFcvdk9oU3g2YVFjVzhXVGdaVitYVnhVOGdndUllcTBXK3V3TllkTmcweEt2?=
 =?utf-8?B?bkNibTI1ZEJvQnduMHp6UTJSamVMUFllbFJJR1ZEeHUzSjRkVmFDYlpocW9N?=
 =?utf-8?B?ajhtUEs0VG4vMGo3b3NWTU96UWprbDcyRCtSWGE0RTlSL0FyM0VjREdkVzk0?=
 =?utf-8?B?MlA3Q0lQbUw2THJYYXRJOWZEKytnN0I5Ry9QNnU0YkFBT2F2QTI5eDhCWjNj?=
 =?utf-8?B?OUMram5EV2Z1ODJ1VURGZEJyTzhTbkJtRi9ZMkYranBxQ0xxYmx1V1g2SGtR?=
 =?utf-8?B?T1IySkdUeWtsWHVaVVZKemE4Y09XNmVNSEticEdVOXlMak1oWHlBM2IxeWFm?=
 =?utf-8?B?Q0NUWXowQ1VIWHVnckNkVzRnNFdCOU1JRDBUZ1NjblpzRm0rb3Y3OFRxdm9G?=
 =?utf-8?B?bndzSDlNbFpETm11QklUNXJiR2ExaE1tVkVDd2ZhRnNuWDF3amhaYW5jelJx?=
 =?utf-8?B?dkhKSDVBMmQ0Y2MvQmRWMGkrNkU3WVhoSXZpS3dYVjNJQ3NGeGpQMnpJSVdV?=
 =?utf-8?B?MnlBSVNMTkQvOTdsbDB4VjR3Z0wzdS9uOWZ2d2FWSysrZHUyeVZlQll3S3o3?=
 =?utf-8?B?SUNQdm9VVlUrekZsRmlrNUlVS3VSRmVSMXdUWDA2T1ZUbnNLY21zdlRQK0J3?=
 =?utf-8?B?UFNRK0JsZGlkMFpoL1g0akVVSml3YUZXd3FMT21ORlB6L3hGbTFNaGpWM0hx?=
 =?utf-8?B?WVJlaWVsVWkzU09wNUNXaGxXNXk2YlR2WGp3RGpnTi85VEJGbHRkTm5xOEkw?=
 =?utf-8?B?RFdoNnN3T3ZMdDhaTkxXaXE0cml1MzlzYW5GU2d5L3NZY3Q1U2U3azhKUjhw?=
 =?utf-8?B?c2tTTjU1K1NpbTdLdVVwcS9mWkFkdVF0QWd2UWo0U2U4MlByVmhaWDBUdEhv?=
 =?utf-8?B?Ry9xOThmanI3S0k5NzlNZUVPOVZUcU11NUlqUTNzYlhNZmNmcXROQ3FhZERZ?=
 =?utf-8?B?eHg5NnVqd09oRHI4WXc0UlpTNUFZYy92c0NtaGdpeGIrVnJmcXkyeVlLU3Az?=
 =?utf-8?B?UEhlRnFYNjJnekpkVGlSYll3MXpMQVQvRUdad3VMZGRrZjBZRzdQaTExbHhr?=
 =?utf-8?B?bWhYVGFPY2p1OXpxZ1N0cXE0L3hKbytzUWhRL3ZvUDEvRXJjbk5MNWhLR2hI?=
 =?utf-8?B?VkhYMTBoY2pyWnBIdmxGbU1IbUVIcjRUQ1BCeGYwLzNTQzMvTHI5SW5kVkN0?=
 =?utf-8?B?ckRSV0t5RTlaNHZNUXhYdnAzNENnZmZXb2ljWXF1N21WLzFiSnpTd3VsZitI?=
 =?utf-8?B?eU91WUxDYzliNnN4N2trc0VsYWk4R1h2alhjVkpUNHhybC9rU1huTCtwRjhy?=
 =?utf-8?B?R2UyeHZHZmI0amtCcms2Uk5weGRwWXV4YVByTnh0WW5lWnA1aXhTYTZoc3Zk?=
 =?utf-8?B?aW1aOXVSY2V5TlhDQkJUcGRPcHM4Z095VHNNeHVIa2Z6OUFmWjN3YkU0WEV5?=
 =?utf-8?B?VDNLRW5rR0xKSlNRU2xiOWc3Yzl1aFg0cGE0RnFWY2V6MVlGd2pNdFFkZ2I5?=
 =?utf-8?B?UDZVaUZlUTJFR0VaOHRNRVFGK1hSL1NReWhlWmpRZW1kVVNzc2RvdDNBaGlr?=
 =?utf-8?B?ZFdNNUJ5YTUrUUk0S2QyQmw2b1pKdzJ0Q3B3eWJMQ3QweWszNG1TdFpDbzdP?=
 =?utf-8?B?WTZ3aUtuYlV1dGZnU01vSlhHSVdkM0QzR21Fd0FEdmwxK2RLZHR3YXh2OXNR?=
 =?utf-8?B?d1VYQjdvaU9tSUFGRC84a3dZOGFFcEM4WWdvZ01uVk5wTWtQYTFuUXpXa2sx?=
 =?utf-8?B?dndQUFBPZGE2QWx1MU5hS05VQWh2eE1SVFlscGlJUGRVSlR5czVuUEF1d0c4?=
 =?utf-8?B?eWNXQWo2enZnbVdKSTNTSTJoUm1oRkg4VE45L0VROVlEVzhFWG9UYlpjWHBq?=
 =?utf-8?B?dEdTamdWL3FudFhQZ3pWZ3BxQ0IyVWQ3Y1poWUhoT0g5YUM3U21vZXdidVgr?=
 =?utf-8?B?TlpGS1RNYWpZaHZ1cWY5cS94Z3F6MU11ZGx4cTNjdUJtUVJtei9RSkYzMVVs?=
 =?utf-8?Q?ximI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdLWjRVTWJMbXh1UEE3a0ZHemZtcm9RSmk5RVp0bFhJb2JUcTVaUzVTTXNz?=
 =?utf-8?B?M2RITjBmRmI2aEZ5RXlEd0gyNHVWUUJDMFNvb2RVNjN2V1ZoT3VsNlFTWGJ2?=
 =?utf-8?B?YjdiSU5Dekdwc0tTTXFib2U4RktMNGpabHh5WFNjMUpyQXZJTzBmd2NCMFQy?=
 =?utf-8?B?M3JhYU9md24zZmdadldHbm5zUmRMWUFWYStySS81QmtSMkhqY1ZSZUUzQlR4?=
 =?utf-8?B?Tm9aSVNUbTlqejNwc3dVNGo5WWVYSWwzNUpMRk5YaEtDd21ZOTA1NkcxNmdL?=
 =?utf-8?B?Q0syN3JrSUZTTXpxdTZiUENQOGhrRmlmOUdieFQva0dSMGVjOXdaaEEvQXlJ?=
 =?utf-8?B?bmk0YUxDcXMzRThBdCtTMXhSREk1VDNjZmhjKzd0YnlNbStCVjI5SmxwYThB?=
 =?utf-8?B?UUt5bndvMTJBUHVNcGJxZjdjbHdBT0tpY3NQcUIwNVoySmtJZUVzMEF5akxD?=
 =?utf-8?B?cUYzQ2xsblA4a09GRTNLYVJKa2tROGJEQjFCMGVnb3JkMEtaRFpva1AzcFRu?=
 =?utf-8?B?Sy9raGkwSXdTb3hZaE45ak9pbWtXNmF0ekdWODVDeWtsME5WZGlnZGtJSkNp?=
 =?utf-8?B?NDBiQmNiM2VyU2lJUG0rYUZwWnkzSmZHMlFOU0lvWXl3NitIYk1JVDNIVmdl?=
 =?utf-8?B?Qkg2eU5wSVJDZnVPeDdCTTVBZ2JQcmhHK2xoRWNva0V6cElyODllTVgzUVp0?=
 =?utf-8?B?QUxaRGt3SXRSTk9oUXpyWTEzWmJXSFJGaW9xTktNSUdZZ2Z0NVZ3SU1heUtn?=
 =?utf-8?B?SWhBVXJVVmtCQzVUeHJ4RW44M0E2MFdreS9heTdJRFZMa3U0dWZFQzhiMWw3?=
 =?utf-8?B?eUFTNm9OYzFBQUtZMVhvQ01RY0prNHpYMXZUZk91MU1xbWZnalgvRHdrbjdE?=
 =?utf-8?B?cFRIc0FZRHBITytraDMwN2dCR2dBdHp2RUErMllYSG5aYzZRaUVKQTVKc1d0?=
 =?utf-8?B?OTEzV0pTR3MyYkpIUHJVVENYbmtqV3RyLzdaMTArUkE2RFhXWTR6Z0UzaFNo?=
 =?utf-8?B?eUJmby8yUmRrV2ZyTE9KT0tEQXRQb3Zub0J6eEc1T1hLd0VuT3YwL3hXUzRU?=
 =?utf-8?B?ZG9wYWNDNzJBOHhtMFRKcXB6T1lIMjVNcHNkZGJHUE9Bb2t1QytoTXJCWXhh?=
 =?utf-8?B?MGUrWVRpTUx0SUZ6clJOZXY2cXpOdVlCSG9WSC9leU1pNWVDdG8ySWtjZjJr?=
 =?utf-8?B?MWVWL3NoN2hZWkU4VnpsbnR6bnQwaFlnbUxsOTlOZnhHSS9zSlZpWk5oN0dI?=
 =?utf-8?B?SnJuOUtmanFGMUY5VUErWFd1ZEFKS0tjZG54Q2c3OVlRSytsVURRZVA4SE1w?=
 =?utf-8?B?OTlxdXZ4dkpiVDhkRjRabDBqaFlOdXcrYkRsSDZ0RTVTMVc2bTBUWmRhWUFv?=
 =?utf-8?B?RDVwOGRMVDA3VFBrdVVBUW56ZVNtTFR0Y2xRSkFHQkJvWkJza2NPcTV3cUZL?=
 =?utf-8?B?cWhSbEhWWWNCbEo0ekpJWmxMc1NsOXdjZHNoUEptTytXWWZNRHNuVmo2blZC?=
 =?utf-8?B?MDg1WXU3ZkY2blhoTGxoWEN3M3RTbWxlMURwSXQxeTZXMy9XZ29EdEVHbmlN?=
 =?utf-8?B?b29QdDZTM1QzNkR5SW4vRkFPdDg1U3ZUUFRvQ0ZnTHJYRzlHb0NvN0g4VWw0?=
 =?utf-8?B?djdaSzU3Nll4YlZyMUF3bDVKOGpLSWRkN0JTdnJjb0txQ3ZkdWxyUVgydU1K?=
 =?utf-8?B?d0Z4aklkUWhXbHFkSjdRTlZMM3MyVmdONVlTcFN0NW54amRsdVA1aUpXN3RR?=
 =?utf-8?B?OEp0dGR0ZWEyd21FWkNCUVJnZjc2cW8raitUWG5qdHZwZ3VOeWZFRllKd0Yv?=
 =?utf-8?B?eUE1dWhsckJoWEcyczVNNzVRblZCWnpzckU1T1BNbGw4Rms2cWRZZnJRcVJD?=
 =?utf-8?B?RHpvV0VoRmpPMVljTkg5dHBkWnhTNmVWYytTNXRhSHZ2dCtaZnpmZHdnSW1C?=
 =?utf-8?B?VktvMjhSS1dheHlzUjVnZ0Y3OEZYV1dEaWNOdGl3S0pHeThyV1JQcld1MjBm?=
 =?utf-8?B?OG51L2xJTWF3c0F2bENHQm01bC9sS2cweXJlUGgyK0N6a2hJeStUYUwzdTFW?=
 =?utf-8?B?SklhNEJxbVBzZUtVNnJPZWVtU1c4ZDVuMEJCckdteVBhcDNpTW9qdDExRDN1?=
 =?utf-8?B?U3dlakw5UUY3ZTVrNHZhbEpDUStvODZtMDB2SkJjdFlvUGN3MkgzTVFVYXVw?=
 =?utf-8?B?OXVaLzFiWlNFbkFFclNvcVBFb3BQWWxORFdnZEwycnFHTDVoMmw3Y3JQWTY1?=
 =?utf-8?B?RXYwNnJkdUpBZ3BuQ2Zia3Z3amNzTHJBb3I4TllXTnlWSStnTTFZaHgwUjN1?=
 =?utf-8?B?ZU5lQlZYdURoa1BaNS9SalVEOWpuQURSUjVuRVI3UzFuc3JTckVNUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b2252a-cd0f-4c46-e2b7-08de6a5ad99d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:19:16.6205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8y7WFuqyyF3XitZ/KqhGBEtLr9iuW5fWEpy0rjh+xmejX5KIY2FUJZmx4l84AhPI693Kboe3cqKYmXyldLoVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
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


On 12-Feb-26 12:53 PM, Anatoly Burakov wrote:
> Currently, IPsec flow parser will look for IPv4 flow item in the pattern,
> and then pass it to IPsec SA flow function. However, we do not check if the
> spec pointer is actually valid. Fix by adding the check.
>
> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
> Cc: radu.nicolau@intel.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Radu Nicolau <radu.nicolau@intel.com>
