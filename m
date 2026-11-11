Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE2606A327
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EQjSnqfZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA53940297;
	Wed, 11 Nov 2026 15:22:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 4019D4026A
 for <dev@dpdk.org>; Wed, 11 Nov 2026 15:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794406930; x=1825942930;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZiYyfz1bdO2pUwD/nJwgm87MJlu3+qgAOP7HJEEmFtY=;
 b=EQjSnqfZlrQU+R0/oKCG8/pPBGS/rlLVqTKWL5c0cQx7ZtP6XWa9DflV
 93RFzjU2y7idkVgM8pPtpMBQWrTo+fxvhJNpLLv0J2hWwAecWojXBeFNu
 xr6Fg0pRkTPyzCHyIT6L8DpDnccx8RmGmuRMss4pFbLvTBgwR9IJN36om
 vi1iwu9wiG4uzOptqbe7J2dx6Dk17wzS7Jvj1ICv//FPltV+vfC8dXdnU
 DQFRlLOF/5ZuYmDDk0+oByUqEbL/rCrRne8ceoVWsslqq6Y9ASBXnSxvQ
 WH2Jlk6EblRlfPn7++DBBb6ZOOPmR+fzdV6m4ea2blFOuGzh5o5i01uk9 Q==;
X-CSE-ConnectionGUID: 1XxvERLTQeuRN4ERdA/DpA==
X-CSE-MsgGUID: InIhbRY5RSSIs7rvfotqvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3058901"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3058901"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 06:22:07 -0800
X-CSE-ConnectionGUID: 1JP6QGaJTqS5oXGvKFLysg==
X-CSE-MsgGUID: QdgyApyIR0qD7Aga+w3v3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8605414"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 06:22:07 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 06:22:06 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 06:22:06 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 06:22:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV/Zl1L+v97rk7NaE0n+lC4aZ09HrEW+ExJGxVte1Qrix4mEb51br17bfES8Dpzh82cnrtc0YhLhKMaK3aCmcydCdv0siQwaezRTXhXS7jcz2uNCtNoSe0hpgSt6aJdb+sXEtG49eKz4uL0mG3j/txbBVUuv8MnWtKAR6zIL1VDHnReZDXKkW2WEY2ju79HcNUyCFdMpGslPDryeyjPi7V5103Cd6q6hUKvQeaXaL7BPwjc9sy6F+qCXle6S5osAPgF/P15BbVOZ1OUpFH25tk9HXh0SS+QLMWw5uHlB4NTWqdhFolC9rVfBfygCpLgM7nkK77Tw2+pJjBUFmzhFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiYyfz1bdO2pUwD/nJwgm87MJlu3+qgAOP7HJEEmFtY=;
 b=YWmh3NKuioFObxpTB03BWM+QqvVC05vGaftXpFrdnNjxNbsgMV3PUBIXU/CpEVXH3WAV8Ebk1+y2HNKl+kY3/OmbvF/CPf1eKmQ1V8ZoJSAboJ1XFax3Gy8UZDWoBf9kRmQlAXjS7qRLAJ+ibza+h5AgCwBeQJlcWkKnGBCaxxokk5FHyw4QNXhhAQqZDDhBlHU5SmpxLwq0dxA0+NmIC83cL/EAWtqyT3bbb2vxwa5vYUixK85nX2GFWibHJKUum+1s7s15gInJThj4cIDW/qwTdHAtGe8tRKQMobVk5M1mcoeRcO35vL+ZSCipNjHBxpyaLeQImNr++QyH85/IXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 14:22:04 +0000
Received: from SA1PR11MB6806.namprd11.prod.outlook.com
 ([fe80::a2bd:fe68:c55f:a803]) by SA1PR11MB6806.namprd11.prod.outlook.com
 ([fe80::a2bd:fe68:c55f:a803%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 14:22:04 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: Jerin Jacob <jerinjacobk@gmail.com>, Pravin Pathak
 <pravinpathakdev@gmail.com>
CC: "mattias.ronnblom@ericcson.com" <mattias.ronnblom@ericcson.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>, "Richardson,
 Bruce" <bruce.richardson@intel.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "chenbox@nvidia.com" <chenbox@nvidia.com>
Subject: RE: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
Thread-Topic: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
Thread-Index: AQHdbleco6/ghPYAYU23wEKAW9i8srciNrYAgALRIgCAAK6egIADB/cw
Date: Wed, 11 Nov 2026 14:22:03 +0000
Message-ID: <SA1PR11MB680680CA639972DE92DB11B390712@SA1PR11MB6806.namprd11.prod.outlook.com>
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
 <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
 <CALBAE1N77y7PkK9o09JwJ=e1GDin9jxyN7VfjvDgY2oFEr9prw@mail.gmail.com>
In-Reply-To: <CALBAE1N77y7PkK9o09JwJ=e1GDin9jxyN7VfjvDgY2oFEr9prw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6806:EE_|DM4PR11MB7208:EE_
x-ms-office365-filtering-correlation-id: 86a67ff2-11e3-4abc-d242-08df3fff288f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|10067099003|4143699003|11063799006|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261021121427099003|56012099006|261022075727099003|261022105027099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: GP+U7FKXMILVjvL8Tg5uT8wBW2ujwHjcACA7MrO8Doc136B7FvpRKXMDWyJFgaEfrSLcn1RXFXnePrlNzjdJOdMCjqRW2uKv0VeaDyt2CUY1y2d5E2lZxsvsc3LfXSHhKyU1sbEQScE0BIvPf2BRLNbCx4keToECUjWJC5bLWO1wCcwG6QrW7gyl6rKD8Zl5tVLu2DOEDiBbfZOSEE/mheQeJ6cU5aeHEqHSV9st1fw4Jhm4ViD3n1zmSayPmSuflouvKeMBwSMTUkfQOgdekDECZOk0KniWw4knG0A35wAFNuc2Gc4BlswTsjM2+ftSNZkCExb4xEtQQX/SPoV/iA8dJVWtY+vhjFI7hexkDWQ78nlhKK/AeVu0MOrptrwehoNFaQz8Kj4yeS2yDRhqjcbO2qQk4PNdon44JOMVQ+BxJNF2TRFkhuldf0zxKD+8OKd5erADv0WBo3KC4VS3KyoVxPR4ELICao0DR6iQqXeD3b7ooYLV7KOjkTaPByB9llNQALNwP7eEXonw1YagfVyNbwq60X2O2ZYN449KtxPQPkS2M17WDkBpAYvKM63GGGLoBjosOpDtmihadP+umX42a8NpxY6FTJnyQNw/PP3ujo4DCBpwg0NgLm6eAnnNZsjRJ71/c6Zou8GBpCKtlAiF5/o9XLMVxq7Ej9nBXIwNdc9+GohehaMQRr9OfvyaWaHuQV17LSV55AI830X/UjOKovNVNxE00odKjBjYhZI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6806.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhKSStFN3hocGNPZTlERE5TamhUZ2VteThHRXdWRENsRGMwZ09kYTNlY1BD?=
 =?utf-8?B?YUM1OEh4ajdxM2tYOEhsL0ppNVZuUTQxRG5TVUxqUWhPSkYveXZGU3c5V0k2?=
 =?utf-8?B?MG1ZbjJVYnZVSFJwRWpvWFMzenNKWjA5VUYrMlhCQVNOVGxyajRxNGZUNzNJ?=
 =?utf-8?B?RTJ3NnVlQ3FXa0lWdGxrTUtUckVuVWUyM0ZrTUhsS3FBZGMrRXpHN2hRK2J6?=
 =?utf-8?B?eFQvK1ZFVkorMFJ3U2N6NENjaWQyL2NQaXk3Z2pNcGR0aFRKNzRpZVBUTlZJ?=
 =?utf-8?B?TkZTTXg3MENLeWxhY29BMERFVmhmUEI5YUV4c1MwWDZGS3l1NUdNMXp2Mjk3?=
 =?utf-8?B?MzdZeXFGSDg5dndGTVRCNGx5b0oySGI3dy85aGFBbm13bHNnclpESDV3Mk1s?=
 =?utf-8?B?SUdxdkdSSjYzRjFuUHIzdXA1U0ZrdmJiMDZzSngxV2Mwd1BValBGaEdKaGNB?=
 =?utf-8?B?WU10WW03NDcxUkVmcmNhcmN6S09CSDk3MFJJR1Blb3IrT0MvMUFpdkxteEJY?=
 =?utf-8?B?OU1kZHpRRWFlek9ySFNQVzdvTGlycHJlL2Evd0lRL2RYeEd1NVFHcjBwdVIv?=
 =?utf-8?B?NENHbFpWVUZweWpsNUQxV3FGMnBUaDd6bW1PaDlvckJsUk5URXNLY3JzSFFl?=
 =?utf-8?B?Nlc2a1dRMmh1Tko4cHN3RG5VRDlCcTFZNkg0NkxtSFVDOTYrS3hjK2g0RWlm?=
 =?utf-8?B?UG9tem5sWndQN21RVXc4NEt3d0FPekV2cTA5cmk0Ukc3VCtCYUthQzBJRGpC?=
 =?utf-8?B?ZHFxdEJ6YUNKUEhIcGtnQUFJbklVRkxGdm0zd3ZtSzhEZTljSDEzWjIyZ1dV?=
 =?utf-8?B?WEtiLzJmWTNnZTNqS1hPamRZVW5sQnduK25pV0dFR0UzUFI0TmpBc2ZKSm1o?=
 =?utf-8?B?Q0pneWVIbWcwUVp6RHg3OG5jcVZWOVA5OEhLNmVDSmRIeFhiUVRvL2xnYndr?=
 =?utf-8?B?MlQ4dkg0K2tHQ2xrc2R0TXZJODFsRFh0ZTFFT2hWN2d6ZlZ4M3VoZHBrQ1dj?=
 =?utf-8?B?ellpUDg2VGZMK2VCYWpsd2h3TzUvb2hqRi9LOGNSU0hydWJ2VWc1bks2aG82?=
 =?utf-8?B?Zm5WUUhMTHV0Q0toSTQ3dkY5MHZvVFlGMmMyeFdMUC9PRGlKTG1pQmx5clNO?=
 =?utf-8?B?SzlUMFg3YW5yM294bkN2MDh6OUpLc1k4bWxXWHg0WFNpZjdhYjJqZ1BNa2JH?=
 =?utf-8?B?ajZyTXI2bnFkdTZ1M05FSGhhTnpHMElLU3Z6dGlZOXRwb0o5UVhOclptNThC?=
 =?utf-8?B?RUthNTkwcXE0TGJHRVpXSUR3cDdSaUw1eWZwYk05eklWNDA3VGhBdmhGTk1k?=
 =?utf-8?B?MStrMU1yblI5cXhQd2JQQUlndnFJNDZBeStGczZTQ1VuWE1rSFNwMUxoaFpv?=
 =?utf-8?B?Wm1PY2ZVSjRFdG5mUlJNRW9BZTdCTk85VzJScmZMQnJ2QlpuK01ILzJ3THB3?=
 =?utf-8?B?YXFXUVJFZXM5OUhPTzNITGdGVWtGL3FtbkJTNlVaeTJWNVhXNm9mSy9pS1k4?=
 =?utf-8?B?U3hPcnZjU2FnUUhHSy85ZE9aTDY4ZWxwWVBnaWMyL0c3bklFRkdxT3JzMlpo?=
 =?utf-8?B?UlAyRlF1VEJBVHlMMXBYVk9kS1ZpL0NnajlneXYzU3VrUDJickNTeWtNbm84?=
 =?utf-8?B?M1l0Snhjc1hHbjRURmJXMThlZ0VjYU1Na05wYXdSaFdkeVlmMTZ3d3p0VHhr?=
 =?utf-8?B?VkQ2VlVRdzcwNmFGdUdEb09UOUIvZTVuZzJ1ZFJCTDN4dWhQamRod0pZUVlH?=
 =?utf-8?B?U2RIcWZlWFFGT3ZQdTFlQkcveVZtWDdLTlZITjF0ZjBqbmZ4UTRRMllCS1hD?=
 =?utf-8?B?RWhKb3lJV1RyVEltL0tmbFVReGdOUEdwRVJGQ3duZ1hoVkdtUXN4dUtZTXFL?=
 =?utf-8?B?alNyYkJRSjBIc09iNDgxK2xDY1k2dW9uTWNHWWxNMnNHZTFTMWtnazd6K1kx?=
 =?utf-8?B?bFRvOVNqdFB5L3V5SXRKWGhHVzlvbFdiUU9PNEhkUEpMamlBczl5WEVRZThD?=
 =?utf-8?B?OUZpemNlZ3phT0VEc3c2M0lZSmVYVGk0NjNhb0hkMXYrbHcwTmFOanNTNmNo?=
 =?utf-8?B?MVI2NGhPNU1KL1FabmdCbEZtNUxsV3RvMUZTdVRrTC9BMzBjdVk0aVV3RkJR?=
 =?utf-8?B?ekF0ZnZpZVgwa0JKT3I4MFExc0Yza0RQSmVSNzVYNmJXekFyYkkreXJBUHk0?=
 =?utf-8?B?NGJsRGZaYlZ2dmtheG5hRTVxZmtSM1djYmo5a2ZMQVV6cU1ZRnNBY1RtaDFv?=
 =?utf-8?B?TXpZU3FsQnJFTTNUWnB5b0NjejFOQnVBTlgzQzV5cElBSlI5UDNmbG1nb3Qz?=
 =?utf-8?B?di9iNTlDTEhJVDNqQnl4S0FxZVdBQzExUnVRdkV1MXA4ZDMweW1OUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DO9HJKYNhxCvzc1qPxQ9H5koHAB5E4C6GB0L9e0erSBDBMXylEGHZQexOQqi32R0zgiFiFn9emWTsq0mRBC7ejUV4bAd2uCnBxbY5XwGlaWVGeLacjFyJU+Jp36dAObwhwHUpkx37Cv5xjqWJliCcwvvMTS2BlG8RZbmyHuWoAR3wEtO+iVoS7wDWtgrtZ5uvykqNxqsdNmCVji9ZHAvHW1pLuW4XKukfGQ9nv+jzN1AiwNniuogE784SxF2my7phNk/nqLpruXuue7hjv7xe0FbsIoV16Kb8wzfxLnitcexCeiWHwr4h84y+urUiMXLCeDhlUdQnY/EQqsPAu0w2Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a67ff2-11e3-4abc-d242-08df3fff288f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 14:22:03.8783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDt5XckLrGL+4/qXXYu3wQTIjYLLBNPQtV0aWBoZiKYIaPwZTZaXPdJl0eynvWkjmd/g5BZ0mIcK6DSHM37cz2ZnOjgLqo4uVBSWOD84vmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
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

T24gTW9uLCBOb3YgOSwgMjAyNiBhdCA2OjI1IFBNIEplcmluIEphY29iIDxqZXJpbmphY29ia0Bn
bWFpbC5jb20+IHdyb3RlOg0KPiBMZXRzIGdldCB0aGUgcGVyZm9ybWFuY2UgIG51bWJlcnMgZm9y
IFNMQiB2cyBEU1cgYmFzZWQgb24gc2FtZSB0ZXN0DQo+IGNhc2Ugc28gIHRoYXQgd2UgY2FuIGRl
Y2lkZS4NCj4gUGVyZm9ybWFuY2UgYW5kIHNjYWxhYmlsaXR5IHdpbGwgYmUgdGhlIGFzcGVjdCB0
byBkZWNpZGUgdGhlIHVzYWdlIG9mDQo+IFlFVCBBTk9USEVSIFNXIGRyaXZlci4NCg0KSGkgUHJh
dmluLA0KDQpBIGZldyBwb2ludHMgb24gdG9wIG9mIFN0ZXBoZW4ncyByZXZpZXcsIHBsdXMgc29t
ZSBlYXJseSBudW1iZXJzIHNpbmNlDQpKZXJpbiBhc2tlZCBmb3IgU0xCIHZzIERTVyBkYXRhLg0K
DQorMSB0byBTdGVwaGVuJ3MgdHdvIEVycm9ycyBpbiBwYXRjaCAyIChyZW9yZGVyIHNsb3QgcmV1
c2Ugd2hlbiBSRUxFQVNFDQpyZXR1cm5zIGNyZWRpdHMgYmVmb3JlIHRoZSBzbG90IGRyYWlucywg
YW5kIHRoZSBsb3N0IHdha2V1cCBpbg0Kc2xiX3Jlb3JkZXJfZHJhaW4oKSkgYW5kIHRvIHRoZSBj
cmVkaXQtdGhyZXNob2xkIGlzc3VlIGluIHBhdGNoIDEuDQpUaG9zZSBsb29rIGxpa2UgdGhlIG9u
ZXMgdGhhdCBjYW4gbG9zZSBvciBzdHJhbmQgZXZlbnRzLg0KDQpBZGRpdGlvbmFsIGNvbW1lbnRz
Og0KDQoxLiBzbGJfZXZlbnQuYywgc2xiX2V2ZW50X2VucXVldWVfYnVyc3RfZ2VuZXJpYygpOiB0
aGUgcmV0dXJuIHZhbHVlIG9mDQogICBydGVfZXZlbnRfcmluZ19lbnF1ZXVlX2J1cnN0KCkgaXMg
aWdub3JlZCBvbiBldmVyeSBwYXRoIGFuZCB0aGUNCiAgIGZ1bmN0aW9uIGFsd2F5cyByZXR1cm5z
IGV2ZW50c19sZW4uIENvcnJlY3RuZXNzIHRoZW4gZGVwZW5kcw0KICAgZW50aXJlbHkgb24gY3Jl
ZGl0cyBndWFyYW50ZWVpbmcgcmluZyBzcGFjZS4gSWYgdGhhdCBldmVyIGZhaWxzDQogICAoZS5n
LiB0aGUgY3JlZGl0LXRocmVzaG9sZCBvciByZW9yZGVyIGlzc3VlcyBhYm92ZSwgb3IgYXBwbGlj
YXRpb24NCiAgIG1pc3VzZSksIGV2ZW50cyBhcmUgc2lsZW50bHkgZHJvcHBlZCBhbmQgdGhlaXIg
Y3JlZGl0cyBsZWFrLiBBdA0KICAgbWluaW11bSwgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBhbmQg
cmVwb3J0IGEgc2hvcnQgZW5xdWV1ZS4NCiAgIEJlY2F1c2UgdGhlIGJ1cnN0IGlzIHNvcnRlZCBi
eSBkZXN0aW5hdGlvbiBxdWV1ZSBiZWZvcmUgZW5xdWV1ZSwNCiAgIGEgY2xlYW4gcHJlZml4IGNv
dW50IGlzbid0IHBvc3NpYmxlIGFmdGVyIGEgcGFydGlhbCBmYWlsdXJlLCBzbw0KICAgdGhpcyBw
cm9iYWJseSBuZWVkcyBhIHNwYWNlIGNoZWNrIHVwIGZyb250IG9yIGFuIGV4cGxpY2l0IGRlc2ln
bg0KICAgc3RhdGVtZW50IHRoYXQgcmluZ3MgY2FuIG5ldmVyIGZpbGwuDQoNCjIuIFJURV9WRVJJ
RlkobnVtX2ZvcndhcmQgKyBudW1fcmVsZWFzZSA8PSBjdXJfcGVuZGluZykgaW4gdGhlDQogICBl
bnF1ZXVlIGZhc3QgcGF0aCBhYm9ydHMgdGhlIHdob2xlIHByb2Nlc3Mgb24gYXBwbGljYXRpb24g
bWlzdXNlDQogICAoZm9yd2FyZGluZyBtb3JlIGV2ZW50cyB0aGFuIHdlcmUgZGVxdWV1ZWQgb24g
dGhhdCBwb3J0KS4gUGxlYXNlDQogICBmYWlsIHRoZSBlbnF1ZXVlIGFuZCBzZXQgcnRlX2Vycm5v
IGluc3RlYWQuDQoNCjMuIHNsYl9jb25maWd1cmUoKTogbWF4X2luZmxpZ2h0ID0gUlRFX01BWChu
Yl9ldmVudHNfbGltaXQsDQogICBuYl9wb3J0cyAqIFNMQl9QT1JUX01BWF9DUkVESVRTKSwgc28g
dGhlIGRldmljZSBjYW4gaG9sZCBtb3JlDQogICBldmVudHMgdGhhbiB0aGUgYXBwbGljYXRpb24g
Y29uZmlndXJlZCB2aWEgbmJfZXZlbnRzX2xpbWl0LiBJZg0KICAgdGhhdCBpcyBpbnRlbmRlZCAo
dG8gYXZvaWQgY3JlZGl0LWNhY2hlIGRlYWRsb2NrKSwgcGxlYXNlIGRvY3VtZW50DQogICBpdCBp
biBzbGIucnN0Lg0KDQo0LiBzbGJfcXVldWVfc2V0dXAoKSBpZ25vcmVzIHF1ZXVlX2NvbmYtPnBy
aW9yaXR5OyBwcmlvcml0eSBjb21lcyBvbmx5DQogICBmcm9tIHRoZSBsaW5rIHByaW9yaXR5LCB5
ZXQgZGV2X2luZm8gcmVwb3J0cw0KICAgbWF4X2V2ZW50X3F1ZXVlX3ByaW9yaXR5X2xldmVscyA9
IDIuIEVpdGhlciBob25vdXIgcXVldWUgcHJpb3JpdHkgb3INCiAgIHJlcG9ydCAxIGFuZCBkb2N1
bWVudCB0aGF0IHByaW9yaXR5IGlzIHBlciBsaW5rLg0KDQpQZXJmb3JtYW5jZQ0KLS0tLS0tLS0t
LS0NClByZWxpbWluYXJ5IGRhdGEgZnJvbSBkcGRrLXRlc3QtZXZlbnRkZXYgcGVyZl9xdWV1ZSwg
c2VyaWVzIGFwcGxpZWQgb24NCnYyNi4xMS1yYzIsIHJlbGVhc2UgYnVpbGQsIFhlb24gNjUwNVAg
KDJ4MTJDKSwgcGh5c2ljYWwgY29yZXMgb25seSwNCnR1cmJvIG9uLCBkZWZhdWx0IGRldmljZSBz
ZXR0aW5ncywgd29ya2VyX2RlcV9kZXB0aCAxNiwgMTAyNCBmbG93cy4NCk1wcHMsIDEgc3ludGhl
dGljIHByb2R1Y2VyLCB3b3JrZXJzIG9uIHNvY2tldCAwOg0KDQogIHN0bGlzdCAgIGRyaXZlciAg
IDF3ICAgICAydyAgICAgNHcgICAgIDh3DQogIHAgICAgICAgICAgc2xiICAgICAgIDc5LjcgICA3
MS41ICAgNDQuNSAgIDM0LjANCiAgcCAgICAgICAgICBkc3cgICAgIDUwLjEgICA0Ni4zICAgNDUu
MSAgIDQxLjkNCiAgYSAgICAgICAgICBzbGIgICAgICAgNTQuMyAgIDY1LjMgICA1Ny4wICAgNDMu
OQ0KICBhICAgICAgICAgIGRzdyAgICAgNTAuMyAgIDQ3LjMgICA0Ni43ICAgNDAuNQ0KICBhLGEs
YSAgICBzbGIgICAgICAyMC44ICAgIDE2LjkgICAyMi45ICAgMjYuNw0KICBhLGEsYSAgICBkc3cg
ICAgMjAuOCAgICAxOC40ICAgMjAuMSAgIDE4LjINCiAgbyAgICAgICAgICBzbGIgICAgICA2MS43
ICAgIDI5LjUgICAzNi42ICAgMjcuNA0KICBvICAgICAgICAgIHN3ICAgICAgICA3LjcgICAgMTAu
MCAgIDExLjcgICAxMy43DQogIG8sYSAgICAgICBzbGIgICAgICAzNi4wICAgIDE5LjUgICAyOC4z
ICAgMjguOQ0KICBvLGEgICAgICAgc3cgICAgICAgMy44ICAgICAgIDUuNyAgICAgNy41ICAgICAg
Ny4yDQoNCihldmVudF9kc3cgZG9lcyBub3Qgc3VwcG9ydCBvcmRlcmVkIHF1ZXVlcywgc28gb3Jk
ZXJlZCByb3dzIGFyZQ0KYWdhaW5zdCBldmVudF9zdy4pDQoNCk9ic2VydmF0aW9uczoNCi0gU0xC
IGlzIGFoZWFkIGF0IGxvdyB3b3JrZXIgY291bnRzIGJ1dCBsb3NlcyB0aHJvdWdocHV0IGZhc3Rl
ciBhcw0KICB3b3JrZXJzIGFyZSBhZGRlZCBvbiBzaW5nbGUtc3RhZ2UgcGFyYWxsZWwvYXRvbWlj
IHF1ZXVlcywgd2hpY2ggaXMNCiAgY29uc2lzdGVudCB3aXRoIGFsbCB3b3JrZXJzIGNvbnRlbmRp
bmcgb24gb25lIE1QL01DIHJpbmcgcGVyIHF1ZXVlLg0KLSBPcmRlcmVkIHF1ZXVlcyBhcmUgd2Vs
bCBhaGVhZCBvZiBldmVudF9zdyAodGhlIG9ubHkgb3RoZXIgU1cgUE1EIHdpdGgNCiAgb3JkZXJl
ZCBzdXBwb3J0KSwgYnV0IFNMQiBvcmRlcmVkIHRocm91Z2hwdXQgaGFsdmVzIGdvaW5nIGZyb20g
MSB0bw0KICAyIHdvcmtlcnMgKDYxLjcgLT4gMjkuNSBNcHBzLCByZXByb2R1Y2VkKSwgc28gdGhl
ICJjbG9zZSB0bw0KICBwYXJhbGxlbCIgY2xhaW0gb25seSBob2xkcyBmb3IgYSBzaW5nbGUgd29y
a2VyIChwYXJhbGxlbDogNzkuNyAtPg0KICA3MS41KS4gVGhpcyBsb29rcyBsaWtlIHRoZSBzZXJp
YWxpemVkIHJlb3JkZXIgZHJhaW4uDQotIFdpdGggd29ya2VycyBzcGFubmluZyBib3RoIHNvY2tl
dHMgKDE2LzIwIHdvcmtlcnMpIGFsbCBkcml2ZXJzIGRyb3ANCiAgc2hhcnBseTsgU0xCIGZhbGxz
IHRvIDUtMTAgTXBwcyB2cyBEU1cgMy0xNCBkZXBlbmRpbmcgb24gc3RsaXN0Lg0KLSBOb3RlIHRo
YXQgd2l0aCBtdWx0aXBsZSBwcm9kdWNlcnMgcGVyZl9xdWV1ZSBjcmVhdGVzIGEgc2VwYXJhdGUN
CiAgcXVldWUgc2V0IHBlciBwcm9kdWNlciwgd2hpY2ggc3BsaXRzIFNMQidzIHBlci1xdWV1ZSBj
b250ZW50aW9uOyBTTEINCiAgc2NhbGVzIHZlcnkgd2VsbCBpbiB0aGF0IG1vZGUgKDQgcHJvZHVj
ZXJzLCA4IHdvcmtlcnMsIGF0b21pYzoNCiAgfjIzNSBNcHBzIHZzIH4xNTggZm9yIERTVyBhdCB3
b3JrZXJfZGVxX2RlcHRoIDE2KSwgYnV0IHRoYXQgZG9lcyBub3QNCiAgcmVmbGVjdCBhIHBpcGVs
aW5lIHdoZXJlIGFsbCB0cmFmZmljIHNoYXJlcyBvbmUgYXRvbWljIHF1ZXVlLg0KLSBvcmRlcl9x
dWV1ZSBwYXNzZXMgd2l0aCB1cCB0byAxNiB3b3JrZXJzLiBJbiB0aGF0IHRlc3QgU0xCIHNsb3dz
IGRvd24NCiAgYXMgd29ya2VycyBhcmUgYWRkZWQ6IHdpdGggOCB3b3JrZXJzIGl0IHN1c3RhaW5l
ZCB+MS4wIE0gZXZlbnRzL3MgdnMNCiAgfjIuNSBNIGV2ZW50cy9zIGZvciBldmVudF9zdyAoc3Rl
YWR5LXN0YXRlIHJhdGUgZnJvbSB0aGUgcHJvZ3Jlc3MNCiAgY291bnRlciwgMjBNIGV2ZW50cyk7
IHdpdGggMS0yIHdvcmtlcnMgU0xCIHdhcyBmYXN0ZXIgdGhhbiBldmVudF9zdw0KICAocm91Z2gg
ZW5kLXRvLWVuZCB0aW1pbmdzLCB+My4yIHZzIH4xLjYtMi4xIE0gZXZlbnRzL3MpLg0KDQpUaGVz
ZSBhcmUgdW50dW5lZCBydW5zLiBJbiB0aGUgMS1wcm9kdWNlciB0YWJsZSB0aGUgU0xCL0RTVyBh
dG9taWMgYW5kDQphLGEsYSByb3dzLCBEU1cgcGFyYWxsZWwgYW5kIFNMQiBvcmRlcmVkIHdlcmUg
cnVuIHR3aWNlIGFuZCBhZ3JlZWQNCndpdGhpbiB+NSU7IHRoZSBvdGhlciByb3dzIGFyZSBzaW5n
bGUgcnVucy4gVHJlYXQgdGhlbSBhcyBpbmRpY2F0aXZlLg0KSXQgd291bGQgaGVscCBpZiB2MiBp
bmNsdWRlZCB5b3VyIG93biBwZXJmX3F1ZXVlL3BpcGVsaW5lIG51bWJlcnMgd2l0aA0KdGhlIGV4
YWN0IGNvbW1hbmQgbGluZXMsIGlkZWFsbHkgaW5jbHVkaW5nIGEgc2hhcmVkLXF1ZXVlIGNhc2Ug
YW5kDQp3b3JrZXJzIG9uIG1vcmUgdGhhbiBvbmUgc29ja2V0Lg0KDQpUaGFua3MsDQpUaXJ0aGVu
ZHUNCg==
