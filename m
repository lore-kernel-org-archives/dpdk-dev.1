Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21198606A338
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UCWHSh3A;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FYLnRXku
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCFA9402C3;
	Tue, 17 Nov 2026 18:39:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id 04BCF402CE
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:39:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794937167; x=1826473167;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ddlbzdlW4BMi4cEuqpaf9ge54mQ4nfP2tAX3rIhXf3g=;
 b=UCWHSh3AYZSnkjMO++TCb4ajYmtI3daM/Z/eS1Q+0zeWzjBo1vfEDkAJ
 K3YHVR3z1zfVe2SLM/WXC3sQn4GFl/DsMGzZyApE7MDE5oWef7rTTwQp9
 BuZTaqUMOdZ5UarG0UsFzHZEZwMeiT0DZtJxnbzhHeOFD6F6FekJMr07Z
 EatNP7w8M23GJGXXzw2/Wml5AbPf9gtR5MDbcKKf88Lic3DsKWtPFZtqn
 Ir5mpC57QIn0ldw2uGbP8FdvuBKXG8KtDvltTsIMQmSFS3/Rfds3BEZuL
 cvaH1wdD0hVuDZdAVIW7iT3v2l2tx6rDrUqnukKoanVGhf4odAr+Sg+U4 Q==;
X-CSE-ConnectionGUID: 1bXdRe1yS+6Z0Fxg9nnXOQ==
X-CSE-MsgGUID: 8SQrvF2NSjCoMNK/tQS/Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3620026"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3620026"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 09:39:15 -0800
X-CSE-ConnectionGUID: TAbqT1/oQfSnyZGU5tUDIg==
X-CSE-MsgGUID: Lb3IaPnNQ0yelauNwQ3e7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9795752"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 09:39:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:39:14 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 09:39:14 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 09:39:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdPuyPFB0J1rRfDlFroydZWleMuZa1QUgF6FN1bMWcE9HHeBxt+i2gQWWMv31fcLPh4pTgAi45pas5AvMaTZSNU7XkL7gd9DE2Tesj31cHNBr7NhXmSWkABlZ8EhNrlNkrdYbHYY/a9wKjUUnD1tuoj0K7QBZALWozt52PiVndD1DBz6CHtXTSKTwbVUKVncISBT4Cj3xpQW9eBRWSB8RjDom3hZjPV2Vb98aFZbomJGyz8KWOM6/axCGj4z46WqTWaCi4BoeiGOzoCoPlWJhm1a0p0AW2SZZnlDZ1wQunKFuwQtFQTKKGaBP9DgIJAFlafVOwoAAUlzgKSqeeaO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmIT0uXC535Tqzsv9pFnzE9GYgFyS5gelhAIWWAJuQI=;
 b=SXGyOeEOcl3F0/ic4RKspAA2wxs5fA7QwjC34C1KN+sG4hoTmXwRXVXgHwDKn5Z2kFeZBwAjNqAtoCj5rqYShoHvdcuaq9OIWjjMU/aHE4kOMgdLW42ha4Vl5p7VSROyvdf+3tNJHKrvK886p1p/I8iILZrStE0sFBx5sb8CVFwlTRFOSYntHaIak6EwNoeTEoKZVG0ZuvvPeD03OzzLy+Ny/tm/4rNN+FwBkFOKaZJ/KnW0I2YVyD7t1T+8aNe2A5iJh00VQMcqoJzDjmDANklAfPVkcL9K2TqivLgKu+q2/RYp9cgsxYP06p1BqiDwO7kOswAKPuVJ30dtW4I5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmIT0uXC535Tqzsv9pFnzE9GYgFyS5gelhAIWWAJuQI=;
 b=FYLnRXkua40Tj9IAZEzZZa8izqIpiIqkOKLtgkJgzPaNjfM44khGEY7q7mJi71NqGDV4uJYijv5Xf2PSdkPZgeYdazd85kQJbMC7ewuhB7RWMMpSYNVOw4fw/nOqFGihqE0fw7jE1nJ/0WcXtOZNfQthpt/Y//8vP2FRH8we1Jo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 17:39:10 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 17:39:10 +0000
Date: Tue, 17 Nov 2026 17:39:04 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
CC: Pravin Pathak <pravinpathakdev@gmail.com>,
 <mattias.ronnblom@ericcson.com>, "pravin.pathak.dev@gmail.com"
 <pravin.pathak.dev@gmail.com>, "Sarkar, Tirthendu"
 <tirthendu.sarkar@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "jerinj@marvell.com" <jerinj@marvell.com>, "mike.ximing.chen@intel.com"
 <mike.ximing.chen@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>, "chenbox@nvidia.com"
 <chenbox@nvidia.com>, <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
Message-ID: <avyROPrxuK4BPY56@bricha3-mobl1.ger.corp.intel.com>
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
 <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
 <CALBAE1N77y7PkK9o09JwJ=e1GDin9jxyN7VfjvDgY2oFEr9prw@mail.gmail.com>
 <SA1PR11MB680680CA639972DE92DB11B390712@SA1PR11MB6806.namprd11.prod.outlook.com>
 <CAPbG5O8uWmOcsWrY1DJ5MzNgeFZkAXBdMPvRcN7QBs4byoU2Ng@mail.gmail.com>
 <CALBAE1M22ZcTG0ofhE1-_G6_SoukoHRGc03vP3Fm55AA122axg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALBAE1M22ZcTG0ofhE1-_G6_SoukoHRGc03vP3Fm55AA122axg@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::24) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SA3PR11MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e338b8-acca-4041-86e1-08df44d1afe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|261026140227099003|261028144727099003|261022075727099003|261009223027099003|10067099003|261021121427099003|261102123227099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 35IYUi72jxCPVpYCofebconzXjBhx9SWKRCb89BEK3S+Ag6xHF0Xg2+tSCRMZkqbL2AL2sHGxt2uT0PlGuyBmveMwmbxV9/EL0fISknIdSBTx2c/ElUHY3zOvp3yCUxCgooUV85vlYAerMhi6EN1/fI4TNy1ALW1fKcpprH1dnyaoW36m/7a8ol+8ogp+bzj57nVmf4/7857YY2xO0mh77UnDb2Sg/QRQVZH84YUgOnReoA3liOOAqD1BmXIyeY0Sifw7mNyqgmjdnGQhPcVWptaYnZSM4yA50vPUCQmfZA/mwIvYHJE126POaex+OZuPX0j313MP6cKZ90LXDv6Dc8i1DraEfamJTlQcC/9wSEJkSlDbaVI2atvWYwEOAHMk3XLgBuPeQldDExCEWRJ6B+owqXbdWJE/j7Zm6LFKjcO1j0hI5K94yx8HM0+pI57Kgg0y7/Nk9w3Xne2cL9r2da7Zfa0GCm7d8+eWy38uTpq/fvEG3mN3m44/ofwpcfbSWAhx6ASmVDdeXmwaL+unYqCtaYObey3sLJqwaHglu/7vY0i06P9W6eQfS4tpYrJZalP3zwUlULW3XbHpFXhnQPYntsPIRguo6uYt/NPbEvPvItPLIMjXAoWcpoUlKQW7i1Rs1BsNRiMEZ4RPcfEmS/7Wu7MZ1q6B99/x6+Cs04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261022075727099003)(261009223027099003)(10067099003)(261021121427099003)(261102123227099003)(261026121527099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNTS1BpRmpLWjE3T3hjWVM3TXQ1QzJEQ1JZOEt0cmVVVGgzNVZCN1c1SHJ2?=
 =?utf-8?B?THhhNUFYeGlLU0ZrRnBsVDZ0Mzl3YldhSXFvMzRuQ3piaExiNmk5M2gyb2ZS?=
 =?utf-8?B?QjBWdWNiZExoMnk5Y0Y3NURTWkh3dGxuYzFaSkhVUzFxbW8xRUhraGZCYnRY?=
 =?utf-8?B?Z0hmUVZlZzAxWFZMaSs1WWZlSFZrY2lWTDlQRXhYdjJ0NjhFNXNVM0xzcHVO?=
 =?utf-8?B?V2ZCNkFHSHVFMmlBa0V3eHZiUnJBMlVCRjdVWTFFak1DWU1leGlwT0IramYy?=
 =?utf-8?B?K0h5dHJLVml6N1JhaHdBZjRSdllrU3BXRVNCbVMvVGlWYktYS3MzeXpYclQr?=
 =?utf-8?B?OGV0SXI2N0JsSVI0LzMrVjNEVERodXJVbXhZMTR2enpKODFpd0xPZlVncEVh?=
 =?utf-8?B?TXZSa0ZZM1BiY2tyOVE4WW1qbXA1WVZpMVdVU2UxYXcxdlpGWGVmbXVpbFpJ?=
 =?utf-8?B?SjFrU3pSYm5zMkdVZ0E3SXpJZy95UmdCaElrN1MwWHNGQkszdlhTWkl0clpk?=
 =?utf-8?B?TEVqQ1ZSWDRqYVhUZ3JlWnhxM1hGVnhXQklZS1J4SWJRbEJwL3l0NHZ3K2hY?=
 =?utf-8?B?YXFrZzlYdW1rRENRa3BjQkxsOFNYYzlPNGxLd216NG5WektiYWZ5RmIzR2Ns?=
 =?utf-8?B?dW5iOUxwUGhDVEJSRkMyd2JKYnVCQ1Zuc1Q2Qlp2TTRQSklacDIwdFkxcjYr?=
 =?utf-8?B?TVFqdUpNSVpyK09KRHYyVFBQUHRtMGJRVUZidmZqTGpwUkRWVDdPL2E5MkND?=
 =?utf-8?B?RFV1bWl2blRvS0tHK3Qxb0pGaEVod0RzbjZQU0hLd05peHNpck44R2JZT2lD?=
 =?utf-8?B?MGtMM1pFbFRkQ0M0TWE1RzhpbGZqL2s3N2h3SnlvbkNEc05KK2hWSnhLK1pC?=
 =?utf-8?B?L3ZUZDRHVkVTSmVhUGk3RmwvSHYwSlo2aUNscVlKTEtmU3ZDM1lIM0RjeGQ4?=
 =?utf-8?B?NjIxRWZvNi9LZytkTitEMUMxaFFEY3d6U3F1YkI5Sm00a2hMRWpyOG8rZEJt?=
 =?utf-8?B?Umo2Z2lkK3VHd3BUOE1BMlIxUnZoT1dOd2NvN09YNUVjbEs2ZXluWnphUzVT?=
 =?utf-8?B?UmtKS2w1T2dmMlR6ZGU5eGQyNnlzSTZnVG1OcjBTRDJiZ0tkSDhyZ0pORHFG?=
 =?utf-8?B?Vkxpc25yTVdhaHUyWnI4S2R3V215cVlPaUdYc1pZeEsvdk90dXFoeDhmaTBF?=
 =?utf-8?B?amZrRDRzY1RKMDRsYnNkQmYrZ0cwbmtmOU1YL0xmbnArdFJJajYwaE9JN0ti?=
 =?utf-8?B?ZnpSSTBuQXUwKzFITGZTeHhLMVRBVC96YUNvaWdRS2Q1M2FiaTY4bjVDcDBL?=
 =?utf-8?B?RGtGRVVucnQ5ZVIxWWwxS2dFSUY0eVp1Y3JVMEplNFdrRVZDMmh6a3RDTjJZ?=
 =?utf-8?B?aEpjT0VvbWc2ZFIvcEpCZVF6U29kVG90TktTWGwwamJTMWNNRUN1Yyt1VUZL?=
 =?utf-8?B?dVVCTHV5OWdxVkFHRDQ0VVlwMGpDaG1ka0NqNVJ2eEhkOE9NOUJDL2wySXNG?=
 =?utf-8?B?S01odzFwMUw5VEhoYndYc1lkTWFXTStwS3ZLbHRvaXRPSkFIRllDU25HeWpD?=
 =?utf-8?B?c3J4MW1vV2Z5QWlRMC9pVE16Nk5weWloSU9FNE9LYVU4Qmdnc09jNVNkOWx0?=
 =?utf-8?B?UXE0djdqRllLRnlqSFJ4elpPOTRHRGx1ajFvZ1FVVm4xajJJOG1SVGtrbDRE?=
 =?utf-8?B?Mk1sQnNQcTRDR3d4dkdhL0U5YUlLRWJLd3BtNndIdGtGRDZodmdKVDRldWhV?=
 =?utf-8?B?b2ZOdHFOb0MrTDBmZHFhTThUdUJkSm9OZmJVUXJKN255NjlFV2FYcUYzcUoy?=
 =?utf-8?B?b0h5d3IzMCtIRW0vVGtMalNRY2J2cTBwRFI2RVEycEdvTExDU3EvQUxIejNV?=
 =?utf-8?B?czVaUkJJQWl5dVovUll6SVhuMWFkQW1odjd3TVd4V042c2QwYWdJRUhCOFdC?=
 =?utf-8?B?UGJLRnh1Q2c3eHRSUjNPbHl6ckUwVm9pWWZJR3NVMkVzV25BamRucnpHWTN0?=
 =?utf-8?B?d0toOFZLeDNJRmJuRmVxNXRGWnUyMWI5a2NOSDNFVEVhUTRTRkR6cmZGbjBp?=
 =?utf-8?B?Ti9oOEo5V1NTQnNXek9wOTRkbzlYb1l5aDM4ZFBjS0xFOW9OTzlaT1lvYlhC?=
 =?utf-8?B?dVhvdHRaQkFYamhybUtodXZsaFpoRHlLcVpZYXJiVkVCUmFqWmNURCtpYmRx?=
 =?utf-8?B?Vy8rY2dHL0VpTnQveU1JYkEvWDVqUjlQb1FnQklWUENKV01ESFZ1cWJJZzFI?=
 =?utf-8?B?S1NQNGNXOEJuYTJUSFN3TFZmeFhOb3AxdEJucGJBQTFLMWpkbmNWTC92SmtP?=
 =?utf-8?B?V1MrQ0c4SVZqSjVYOTlNSCsxVFZhdkVZd2JXWDI1cm1BK0E5YmxuYTRWUEVq?=
 =?utf-8?Q?HHFmcsFsYYTavlwY=3D?=
X-Exchange-RoutingPolicyChecked: l8xr4JJ+3PTAyv7kKV9FIHmYrbK3ZnLsWNZfSUNmJlcxrXB2yRZPt0WYTjLF5P/9Z27gN5/CZabhJSUZExqWxhf2unUmHL78QFODhhZru5yJUrBvZfoxSmnqrKQE4OE3UVJSOYWjYAVwkY5oUW2X4Zh6GaqzkC4qPSA2T/OBG9KVDZi9qGGovHapv0iFJ2A7YS/NVxHj/9b61ycgxzN3R9z32f23EjoJKHTAayPkYV7Wu18m1ZrjqoA7XG+qDOQaZIbHOdyCM/N2zGS9d7SArAMD64chFzMblMbwzrpAIhVWYhFfi6/QwAz0p81QgNrpJ7uJZ0aEOYfaK5Ubyg3ZWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e338b8-acca-4041-86e1-08df44d1afe7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:39:10.2042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSof5C3npKCP0WME4FuYJe0LbAMkf0r/iS/PSejE/ou13F0wAQTRSpVmnkdpszUjO5c9mVQ04FoiaRp4L7n0Idbpdnrj9cKtjy+7KIF9198=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 10:55:12PM +0530, Jerin Jacob wrote:
> On Tue, Nov 17, 2026 at 10:39 PM Pravin Pathak
> <pravinpathakdev@gmail.com> wrote:
> >
> > On Wed, Nov 11, 2026 at 9:22 AM Sarkar, Tirthendu
> > <tirthendu.sarkar@intel.com> wrote:
> > >
> > > On Mon, Nov 9, 2026 at 6:25 PM Jerin Jacob <jerinjacobk@gmail.com> wrote:
> > > > Lets get the performance  numbers for SLB vs DSW based on same test
> > > > case so  that we can decide.
> > > > Performance and scalability will be the aspect to decide the usage of
> > > > YET ANOTHER SW driver.
> > >
> > > Hi Pravin,
> > >
> > > A few points on top of Stephen's review, plus some early numbers since
> > > Jerin asked for SLB vs DSW data.
> > >
> > > +1 to Stephen's two Errors in patch 2 (reorder slot reuse when RELEASE
> > > returns credits before the slot drains, and the lost wakeup in
> > > slb_reorder_drain()) and to the credit-threshold issue in patch 1.
> > > Those look like the ones that can lose or strand events.
> > >
> > > Additional comments:
> > >
> > > 1. slb_event.c, slb_event_enqueue_burst_generic(): the return value of
> > >    rte_event_ring_enqueue_burst() is ignored on every path and the
> > >    function always returns events_len. Correctness then depends
> > >    entirely on credits guaranteeing ring space. If that ever fails
> > >    (e.g. the credit-threshold or reorder issues above, or application
> > >    misuse), events are silently dropped and their credits leak. At
> > >    minimum, check the return value and report a short enqueue.
> > >    Because the burst is sorted by destination queue before enqueue,
> > >    a clean prefix count isn't possible after a partial failure, so
> > >    this probably needs a space check up front or an explicit design
> > >    statement that rings can never fill.
> > >
> > > 2. RTE_VERIFY(num_forward + num_release <= cur_pending) in the
> > >    enqueue fast path aborts the whole process on application misuse
> > >    (forwarding more events than were dequeued on that port). Please
> > >    fail the enqueue and set rte_errno instead.
> > >
> > > 3. slb_configure(): max_inflight = RTE_MAX(nb_events_limit,
> > >    nb_ports * SLB_PORT_MAX_CREDITS), so the device can hold more
> > >    events than the application configured via nb_events_limit. If
> > >    that is intended (to avoid credit-cache deadlock), please document
> > >    it in slb.rst.
> > >
> > > 4. slb_queue_setup() ignores queue_conf->priority; priority comes only
> > >    from the link priority, yet dev_info reports
> > >    max_event_queue_priority_levels = 2. Either honour queue priority or
> > >    report 1 and document that priority is per link.
> > >
> > > Performance
> > > -----------
> > > Preliminary data from dpdk-test-eventdev perf_queue, series applied on
> > > v26.11-rc2, release build, Xeon 6505P (2x12C), physical cores only,
> > > turbo on, default device settings, worker_deq_depth 16, 1024 flows.
> > > Mpps, 1 synthetic producer, workers on socket 0:
> > >
> > >   stlist   driver   1w     2w     4w     8w
> > >   p          slb       79.7   71.5   44.5   34.0
> > >   p          dsw     50.1   46.3   45.1   41.9
> > >   a          slb       54.3   65.3   57.0   43.9
> > >   a          dsw     50.3   47.3   46.7   40.5
> > >   a,a,a    slb      20.8    16.9   22.9   26.7
> > >   a,a,a    dsw    20.8    18.4   20.1   18.2
> > >   o          slb      61.7    29.5   36.6   27.4
> > >   o          sw        7.7    10.0   11.7   13.7
> > >   o,a       slb      36.0    19.5   28.3   28.9
> > >   o,a       sw       3.8       5.7     7.5      7.2
> > >
> > > (event_dsw does not support ordered queues, so ordered rows are
> > > against event_sw.)
> > >
> > > Observations:
> > > - SLB is ahead at low worker counts but loses throughput faster as
> > >   workers are added on single-stage parallel/atomic queues, which is
> > >   consistent with all workers contending on one MP/MC ring per queue.
> > > - Ordered queues are well ahead of event_sw (the only other SW PMD with
> > >   ordered support), but SLB ordered throughput halves going from 1 to
> > >   2 workers (61.7 -> 29.5 Mpps, reproduced), so the "close to
> > >   parallel" claim only holds for a single worker (parallel: 79.7 ->
> > >   71.5). This looks like the serialized reorder drain.
> > > - With workers spanning both sockets (16/20 workers) all drivers drop
> > >   sharply; SLB falls to 5-10 Mpps vs DSW 3-14 depending on stlist.
> > > - Note that with multiple producers perf_queue creates a separate
> > >   queue set per producer, which splits SLB's per-queue contention; SLB
> > >   scales very well in that mode (4 producers, 8 workers, atomic:
> > >   ~235 Mpps vs ~158 for DSW at worker_deq_depth 16), but that does not
> > >   reflect a pipeline where all traffic shares one atomic queue.
> > > - order_queue passes with up to 16 workers. In that test SLB slows down
> > >   as workers are added: with 8 workers it sustained ~1.0 M events/s vs
> > >   ~2.5 M events/s for event_sw (steady-state rate from the progress
> > >   counter, 20M events); with 1-2 workers SLB was faster than event_sw
> > >   (rough end-to-end timings, ~3.2 vs ~1.6-2.1 M events/s).
> > >
> > > These are untuned runs. In the 1-producer table the SLB/DSW atomic and
> > > a,a,a rows, DSW parallel and SLB ordered were run twice and agreed
> > > within ~5%; the other rows are single runs. Treat them as indicative.
> > > It would help if v2 included your own perf_queue/pipeline numbers with
> > > the exact command lines, ideally including a shared-queue case and
> > > workers on more than one socket.
> > >
> > > Thanks,
> > > Tirthendu
> >
> > Thanks Tirtha for the readings and comments. The main intention of introducing
> > SLB is to bridge the current gap where there is no distributed
> > software eventdev
> > supporting ordered queues and priorities. Current event_sw has a limitation of
> > single core scheduling limit. You can see it clearly from below
> > performance tests
> > where event_sw saturates early.
> 
> 
> In that case (And looking at the performance numbers), I am OK to have
> this new driver.  @mattias.ronnblom@ericcson.com  @Richardson, Bruce
> any objections.
> 
> @pravin.pathak.dev@gmail.com  If there is any common code between
> Event SW PMDs THEN please think about have some place for common code
> at driver/common/.../
> 
No objections from me. Is this something that could completely replace the
event/sw driver in future, once it has stabilized?

/Bruce
