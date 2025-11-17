Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAB5CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 05:22:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63478402CE;
	Mon, 17 Nov 2025 06:22:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D6AC1402A1
 for <dev@dpdk.org>; Mon, 17 Nov 2025 06:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763356952; x=1794892952;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=rHP0P4A7edL/Rq1VjITVWLl0ZVti/Izi3HQ10EOKPkk=;
 b=jO3V8SmBjEtNkrODICaXgKM1eG37f04jCR/vO/RjjlfbvWklSNeLrriv
 pLtFo0aBgtsKX66FaJhv7XrUIPBZqnbzgkI4ASsUQhKAyVc7t2l+9CyEJ
 cRy6xJZtWrR4IB/GRTje22VAij84lBSu6j1c6YvDpQ3JBGxM3IgUmX7/f
 llOsZNi4QJKbdV2pnFJn/qg3z1ORwkseThv3nUYpIOfCQ1E4QcE6XodJf
 2tn4LlTTp0AY/daIKiWRYYpTJFC5NA+zpH1xZMqjlkKd3ZKdo9CXfvRrK
 YPupyV3yDjWnufi/xKoqrOYnSy4r5gpyuv7rraasVeTOYJme0ek+mqsTZ w==;
X-CSE-ConnectionGUID: fA06MEaNQgaAFMC2jmPeMg==
X-CSE-MsgGUID: jvZln0kPTgmSwpzrMzs5DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76451795"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76451795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 21:22:31 -0800
X-CSE-ConnectionGUID: s8rXC0QJQWes5/LNnYrghA==
X-CSE-MsgGUID: l+r/tDqvTJmhojVUPcoV7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="195486916"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 21:22:30 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 21:22:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 21:22:30 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 21:22:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdtSHnPVmEvJkGao+Hjw9drpxJPKTJE/XW0I9l3wda63zaGnD8jVjOkvtr69wPFYVSQ05srWAr+EX3D3NDKVNe7gw2i1DPUd1qAbqe7jn6TcUgxnopQiflVAlVYQJalFC9cx0j6VQL+PJGOMK7myVoNSA7JVYEfjdH88DHd4CHA/88VHeDhzfEEv1ZvvrM9PRKC2MiMqRA8ldXemd94q+2+ADkmF9Vx2pj+MJtx40e+2FgyrFKz2X5hbevUoCzqJsrJj+ax4wZu2pDNr1s44kWses/81cQDR7IdvaPmQ0ZE83iYtr5iwRiKVKLq25UrgjR0LjUp/RL9cVaq2Bmwzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJXJ34qCqXrS85AbpOoG75Slk2ntkbWkd2rXlGkwoLU=;
 b=d7fRrDHT/e+GV1cIij/+oofBU4tRApqEyVDjtG08mfos0MkSdXw0+PIZztCQJjm9KLy8qs7n7iKG57qg0e+qILEJo4SW23faxAE+EU71OB8hR7AAhQ6Y7RiRysm+aqZc+5+lZziLiIAgBdmqqj0c/gznd6cJcycm4OdZz5WG6fyVp7rkKnGVZk1PNApOjQtZ51lGmozPVMkzQzaqrrPmQeDaS9IQJeDY2xEksbMOvt2QerQEHJusAEEG9kwZE1x4h7ssUMGioY2jBwBBpfaAO0f7dddX6v/3/2qhYPpdRoJsUmUiuQxq9v7gWsfvReqP84uKejpQwwd9clrFqm+A6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 05:22:27 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 05:22:27 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Index: AQHcVq02Q5MdAwVwH0eQQbAZdQUWgLT07CkAgAFoL7A=
Date: Mon, 17 Nov 2025 05:22:27 +0000
Message-ID: <CY5PR11MB61167F082015E76C562C3635E4C9A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251116035749.45922-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65562@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65562@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|CY8PR11MB7747:EE_
x-ms-office365-filtering-correlation-id: 48ba6804-d6e5-4acf-575c-08de25994c76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7eOJ0X/tsHaFkeG/ZwmOaGigqXl+heedkAa1q6K/IA0n4GdexOUHJQ4Png?=
 =?iso-8859-1?Q?Y9EXHjJzHp5w9xcIb3XyeDylLBdCHBXaG4rVhY65cHe1j+M4T16L0ir5kH?=
 =?iso-8859-1?Q?JtVWX81dUkQgl9dKAuuyMuXH8Lne4l13w5GitCFASArSE3ePusnibfrnoL?=
 =?iso-8859-1?Q?fQlYDO/oB4DtQoKLl5T83PjPdH5xPF0YLlwqeefQ75m/yAFWpYr62bLVvm?=
 =?iso-8859-1?Q?pvKHveLMubFa06nf2ZtDWyNU9c6DKeUzCEJGibIA0EJu2OVWLUt50APiDu?=
 =?iso-8859-1?Q?XmAL/HGHhUb6JMmbQduBRdOl9S3n++B/D8MERQ6V9noPhEs32lby04gI9I?=
 =?iso-8859-1?Q?1DfgL87KNLb2aOJNiMO/TjaiJ8XwVO7LUYhswipiTYgAEu6ZRPrL3mt7K3?=
 =?iso-8859-1?Q?Ym/PEkfNODRqStApK6z0QYrXDHw9L0ceaDLm3lYDLZbEWHakXtVP57H/hO?=
 =?iso-8859-1?Q?Fsx0CliTFN/UvdSvqAFGLNgXPtmYyAvwWnGIgyFcJ7skCBvpYd6EHDuzht?=
 =?iso-8859-1?Q?/Zp8HMEFfq7ioDxxKtemYXs04ftjQzScARaZliuX0A9u8KIiWeFpAyddmm?=
 =?iso-8859-1?Q?NNmO4111Lo7iHjunLwwXoA1s1QS2iW/AGEBioEA3DYeUWlc/qpAWQlKalc?=
 =?iso-8859-1?Q?MR18TOx0NFJYSRByWyU6kqEfwsW4XQ4Sd/X+hUqrjFF0gL42akmYuKJg8c?=
 =?iso-8859-1?Q?Hxi7t9gfMaT/MSDpo9RU6OKQu7wCLDrOIQuxPA4w8gLlOb4BSdx49Bvo7R?=
 =?iso-8859-1?Q?EhWmvtatxUnHhgFNFi7ZAJQXds3CBa47z7dQUP4y6AE1NaHs1jSULX0aob?=
 =?iso-8859-1?Q?esBpkgdYRZkrn1HxzAk2Yry+auwXfvL3xduc03BZ+TQjV1EJPs82DbHfxu?=
 =?iso-8859-1?Q?rWzsQAc5BAePBaR2i976qtOoYN8mWmQaNj2hUzd5apqUJ5Q81U65XJDjs+?=
 =?iso-8859-1?Q?5oREMvB4tNqjZEuTjHt8YRBWtDUenoOO1VGb46GkgobxUvvZTuAEc+YwsF?=
 =?iso-8859-1?Q?rHMQUFIBQZGWsCID90lgU0DnicUJx6uNliwrJtC13PC+Hzd+QWxtqD+jfw?=
 =?iso-8859-1?Q?mUg9nuOa06ppLaRC8bQLHF/zcnG/Eo9uX346oKSuMBrPQ7rLbtDVd1rjnx?=
 =?iso-8859-1?Q?oIOKRXWgKyDP/wtmXdvublqa+q0sjSu8uxTAe8O73gPd4ZsWewMtMs4JgO?=
 =?iso-8859-1?Q?8tMW8v0tDY+bzPpNl3aQJR/goYSXr5wc1NdwKOwt3al4I1vIbHEfOFq/MB?=
 =?iso-8859-1?Q?AqF11zKvK9Zm/cK6A2dQUnxjn19YQyUJ98+/xD9iRaeaonYGHs9esm6htW?=
 =?iso-8859-1?Q?eGhKt4Qh/II2O7s/Jd7DfL3fxL6A0BfdeNeJ0A24TYDO3fybZxxmgCGEtK?=
 =?iso-8859-1?Q?GB/mGSgC68R38d3vupS0/mXTsf3zDAbHMwO0+l4fAjXl30q9Hf3Mtav8ET?=
 =?iso-8859-1?Q?RWdBS3ZQip5BnsCe1utHaQmxikp6aK94p4RWowKzGKPQxZmoYPUJ6d239I?=
 =?iso-8859-1?Q?lRFXUptn9Cci8ZXFixOgF4GxtB2c9+dDIhOmifdEx811BFGqYhf+UDmDuU?=
 =?iso-8859-1?Q?dhl0YHN/vByz6gUdO1TWRQlGSFHq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?azz59i4//9TH9/FFXqhcBrqbFkmys+GGVKkXZBHDWX/Y/LyNVA8NffJr75?=
 =?iso-8859-1?Q?UIyJ4bLNBhKLhnyd1H2JZSchOsEG5gts5AzKLT+FOXbbd6Hyy6XEWOWYzK?=
 =?iso-8859-1?Q?2i1CBfWTsBCcFWj5EcyNT+I1KM3gxIBuAUAnaaJwE+J7qr+lqDIEOVOtRG?=
 =?iso-8859-1?Q?ARygMybl9weQaTiA0cFG/k6CcVhjf/NbOxmwnGzsTRPWr1g79X1ZlU9rVC?=
 =?iso-8859-1?Q?13djq+SKYZTUWF4462NLmn1V3vbyXUr5jXguJr5bRp85zjIQsqIi0nXCf0?=
 =?iso-8859-1?Q?1NZG3cInsbeyXLo5fx9fJ2VNijY/8zW+zBAcIxEr10MbE0yA0u+r4goi16?=
 =?iso-8859-1?Q?MGrUPgKB/mYpXmmRFG3OOhIEkGFQI7zyyREGnNlsgjPneKc1t8r6bLXwPf?=
 =?iso-8859-1?Q?2B+WeVJEh8roqr2sNXU+TCOpDy0MektwRSSjk1r3+ER2J2IRmHev/VKj2C?=
 =?iso-8859-1?Q?02GDSPjuz6ve7FOau6P8ynsmBG3rRkFlZnMYsUfeO8+h2AuiMsyRUhKxBO?=
 =?iso-8859-1?Q?P0Zv3e3e/VQmNiWuw14agTc/rgyq/7clx4wXSi8InQkxz6btFXmzLZlANA?=
 =?iso-8859-1?Q?yw1JNmvxISvAsKB+wodrR59BYbMRc1vPbBQVwIkM7yLiS0Yb5q6yqQaQJR?=
 =?iso-8859-1?Q?0fQb/QqgXIbOMSLWsF3EhFXqOxy1VtYSESdeNZ51h1Rr4VFK46nQQ1ahcT?=
 =?iso-8859-1?Q?TegPcN7UyBUwdIzJ3TIK6QAqyj2i6IV3K7YkQATsRqnfx/68B+nA3+I/NC?=
 =?iso-8859-1?Q?ps7HwKsbPnG3rK02b4/PhG0k3g2xOfhVY960clX1ZieXyTil3GR+ysCWIq?=
 =?iso-8859-1?Q?VBlKQiUMfCeQfl9+m6L6hesZQtEpweRaoHAessQx+o8nc4DVAg8LAJ3qI1?=
 =?iso-8859-1?Q?nT8X5+Vimq7k6aQH2Yb1qyQ+maKhIvHRTTOkNuduw/XxOO7X6ZtzuB9THW?=
 =?iso-8859-1?Q?GB+gR2MtAUnj4t6pobMX59ecTitCswf19L5NDqZfsKF3WmgCrmrWpoybbZ?=
 =?iso-8859-1?Q?Q4/A0Hfkbr6FIOxcj3Be8eqMvsZWGKjDcq2jozjow7K2PJIwXWuAm5GiN5?=
 =?iso-8859-1?Q?pJAf88szbRMdngqL/N7cC3QzJfcJdZ9/48kEwWW1Znw6xEU8L51OS97rzb?=
 =?iso-8859-1?Q?5DQ4nMyKYf2zYuemZK333ioKmTV1ZpyK1OXc+eF4UWMax4TzPp9hsWzA6c?=
 =?iso-8859-1?Q?4qeptcYhuOsbUss4i7dGb7+Gdn96PoUueNR67abg7s1qURuAs70sKIljop?=
 =?iso-8859-1?Q?1Jj/7tHq7crph3cQXxXY9skKyazcNTiZ+bfoZtEFeinNIhwy2sUydZ/uT9?=
 =?iso-8859-1?Q?Y94M4PlkZm+uqgcXeSZLAj3/75uxdzQMFpeWiUkOJ1l/nWa6f/yFNH1sON?=
 =?iso-8859-1?Q?OY7MODzBULppN1xP155iEVEM2H03fhz6kWMEe/n5Bt5vdcn2QoNrJ11S+j?=
 =?iso-8859-1?Q?OPcGepew3NpKt4gSwg+xFmo7zM/TlLogZORtOSQBkPCzdSXm4DHXYlrdyD?=
 =?iso-8859-1?Q?qPIFiEMSWdYO8IVWDZKJtXFNqIRckc6Im/y9alRs7wR7Q7LCIUhOqFYMby?=
 =?iso-8859-1?Q?eIlvRZ2zT2qXlu64jn0OBU6d5ugpAvEyfUzRpakeDXR7qK42f4DEs1iVQG?=
 =?iso-8859-1?Q?vNlLXKsdmq3kORY7m/4ikHoRXwS7SOrV54?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ba6804-d6e5-4acf-575c-08de25994c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 05:22:27.5869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPhkcK9oIaI2ay9Wv6mj25MrkljoSyUU/toU4FkmTVL4C5ysT6nbl5ULiNtLbLZG+QbCDPMV/oAD8MGW6yPBow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7747
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

Hi Morten Br=F8rup,

Thanks for your mail and review. PFB my answers.

" This is the same story as with Source Prune.
Please disable source-prune filtering by default, and provide an option to =
enable it.
Also, suggest shortening the devargs name to simply "anti-spoof", like "sou=
rce-prune"; they both operate on MAC basis."

[Ans]: Source prune is disabled by default and option to enable the same ha=
s been already committed:[ https://github.com/DPDK/dpdk/commit/980c840a646a=
2c8ae49a291c17baf20a74f36086].
I also wanted to shorten the name to "anti-spoof" but I found something cal=
led " vsi->vlan_anti_spoof_on" in the same file.=20
Hence, to distinguish between them, used "mac-anti-spoof".

Thank you.

Regards,
Anurag M

-----Original Message-----
From: Morten Br=F8rup <mb@smartsharesystems.com>=20
Sent: 16 November 2025 13:14
To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Richardson, Bru=
ce <bruce.richardson@intel.com>; Burakov, Anatoly <anatoly.burakov@intel.co=
m>; thomas@monjalon.net; andrew.rybchenko@oktetlabs.ru
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option

+TO: Ethdev maintainers, regarding new Ethdev APIs

> From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> Sent: Sunday, 16 November 2025 04.58
>=20
> VRRP advertisement packets are dropped as TX-errors upon transmission=20
> from a vsi of ice PF due to MAC anti-spoof check which is enabled by=20
> default.
> There is no way to disable this check in the Tx direction to avoid=20
> these packets being dropped.
>=20
> This patch introduces devargs "mac-anti-spoof" to allow user to=20
> disable MAC anti-spoof check. Disable MAC Anti-spoof check in the Tx=20
> direction to avoid getting dropped as TX-errors upon packet=20
> transmission when their source MAC address matches one of the MAC=20
> addresses assigned to that same NIC port.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

This is the same story as with Source Prune.
Please disable source-prune filtering by default, and provide an option to =
enable it.
Also, suggest shortening the devargs name to simply "anti-spoof", like "sou=
rce-prune"; they both operate on MAC basis.

Let's make something generic instead, to replace those silly devargs.
We have individual Ethdev APIs to enable/disable various Rx filtering, e.g.=
 "promiscuous", "all multicast".
Obviously, we don't want to introduce new APIs for every semi-exotic filter=
 any NIC may offer, like "source prune" and "anti spoof", but we could intr=
oduce a set of generic Ethdev APIs to support filters such as these, using =
a bitfield enum. E.g.:

/* Enable one or more filters. */
int rte_ethdev_filter_enable(uin16_t port_id, uint64_t filter);

/* Disable one or more filters. */
int rte_ethdev_filter_disable(uin16_t port_id, uint64_t filter);

/* Get bit field of filters enabled. */
int64_t rte_ethdev_filter_get(uin16_t port_id);

/* Get bit field of filters supported by device. */ int64_t rte_ethdev_filt=
er_capa(uin16_t port_id); /**/

/** Destination MAC must match NIC's MAC address.
 * (This is the inverse of Promiscuous.)
 * Default enabled.
 */
#define RTE_ETH_FILTER_RX_NON_PROMISC RTE_BIT64(0)
/** Multicast Hash.
 * (This is the inverse of All Multicast.)
 * Default enabled.
 */
#define RTE_ETH_FILTER_RX_MULTICAST RTE_BIT64(1)
/** Source Prune.
 * [Insert description here.]
 */
#define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(2)
/* Add new Rx filters here, in increasing order. */
/* Add new Tx filters here, in decreasing order. */
/** Anti-Spoof.
 * [Insert description here.]
 */
#define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(62)
/** Used for error return values which are negative. */
#define RTE_ETH_FILTER_ERROR           RTE_BIT64(63)

