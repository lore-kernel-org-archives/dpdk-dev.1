Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EAFF31E22
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 14:26:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E914F4028D;
	Thu,  9 Apr 2026 16:26:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 28DB240276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 16:26:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775744796; x=1807280796;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r/WxXaLvwA0dWbmhjnhjb3aOhTAjzxqz/VNLes9is6s=;
 b=DLj/IBu8gSTVbXbA4CDm3Orut8ycp3OhYrkY4UEHUhzhRmTyd+5Y0Tin
 3CDPikFW6+sVDAYeoTkLbhL/FRFj+I42lDxeuq8uCex4L2nRUnthmYnrs
 gdKYUbKBLNaM55DOlY6Yt4LRpekCAT0xNxkilK/avQHdwMuqh8xg8q/OS
 +dGes5fbuMkWRSRlbc84NsJn64Sjs9qjVQt3CttuFftcYRAhMiOCfSVDG
 ThCA2dePGRx0p/d8Jf9iiNsNxzaeffyfma4YlLhAMp4nGdKqLtiuxPcT3
 PEDVx8VmT+2wXlEqXQBF0jukat7hUdw8brvB/BE0yM9ZrnLEujo+mFhqB A==;
X-CSE-ConnectionGUID: HvAlxSv0StOmOIQqdyVWqw==
X-CSE-MsgGUID: Ok7lgEVvSoO1aLjuQdhlkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87827448"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="87827448"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 07:26:35 -0700
X-CSE-ConnectionGUID: Qj/kWEV3RfSPq418z2MR+g==
X-CSE-MsgGUID: uBJGMN4nQOmFHtUSN0z0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="227783155"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 07:26:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 07:26:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 07:26:34 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 07:26:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhthnbcOt0yp0kYDK3REXGLeRzycrUgnlIlj5yFjj27/i4iapiagEAqUvFtVXRGdHymRv1x1b7C0nvf5PF60acyG0EJePgBzXFdkbnDgSiKpaKpSxP6ChdTJYoReNrikFPvgwZDMJTmusMMIXXGd3leSqHrwvPOaJSc/hZBcq1rLFUYwR+dix97CmG2xtaNV3e+qh4IJJyF5TDh5pBhCZFt/RwWX7TVWjBzreTB+LPq91rDEQS5gthd2c/WaOMFNu7Lutj81gLl+Q+xWMqmu8OVrIFciNJe03+W0d39I2oVPIy80LSGqSvidB/3LOgUj+P+8bQkJdfsFeqOd2MR5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/WxXaLvwA0dWbmhjnhjb3aOhTAjzxqz/VNLes9is6s=;
 b=irRxqm259Le7nfxPWsRh7Htx7MClxzLm2kM1j2n+kORTldYg0H5HDyhq+Bz8R/+r+eZ5DBe6mH9yZTHoXpDRG9mMa7XRaAY9k2/IlgUkYnCni546qbIJhe9DUxFksQMC2r3LJXlDSoTSYBj9c39zzzHGlbJAG9qJwwQfdJmqrvGHmSLWzuS6KJo5yMOUN3/EcmmUR/eAZNrs7LJHhU+XlIn6CZ7gXv28m47dggiayitvTR9wQwynUOVuP3QFgv5qs3iuzW4wX/EfitcVWFFGnl8KxCyPTylelpJju7Ppno8JSyjQynnWBjxcMtLCCpfUq1rptenbEST6jSiLs8Wn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by DS4PPFBF67129C1.namprd11.prod.outlook.com (2603:10b6:f:fc02::49)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 14:26:31 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:26:30 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH v4] net/iavf: add support for QinQ strip
Thread-Topic: [PATCH v4] net/iavf: add support for QinQ strip
Thread-Index: AQHcyApDTmBZaJXC3UeYbL0DtgLcg7XWyUFQ
Date: Thu, 9 Apr 2026 14:26:30 +0000
Message-ID: <CY5PR11MB611601665F0210CA8FCE97ECE4582@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260216103710.195777-1-anurag.mandal@intel.com>
 <20260409101951.114492-1-anurag.mandal@intel.com>
In-Reply-To: <20260409101951.114492-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|DS4PPFBF67129C1:EE_
x-ms-office365-filtering-correlation-id: 939dba64-bcbb-483d-0025-08de9643fe4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: +VnkpChUy5gil97yYqZShU30XzoZn2GxG2ZGS2BRoCtB9LJpclksuwvIDjMlQUAdWn881sJuGtOajQ1Llb4HrKlM4WclOFPL3Cgu/RbpiaaHOMz3mrZhk/2dw9q0QFAF/FWTFVNP1L6Kq6L9HSXWXCxkLwEBEfPUKY+JjeIs3Hn48yEa1B7T+40uZOj9dmWEpkdPOIh1mXA3CWjFWisZrirm/L5VV3oRGHzCJI0TKYHJy5zYTP60uaNHYQwi/YR7CB09qCxpR5mBm7hjAT20c2Jtk/V5tpOrsQoJfmMqzI+KS88Q+bHWOeZa/31bdcWsc9rTtDDZDsNsxq570+IObwYvs8fqHsp9sMS/jTU0YI5HGgj1sxpgWRr4tODG18lTn/f74xDN+k+g4+ZKABolog3orypqShkmWkDH6zWwsw+rTuDFI7iB7kYdOR3NH/08dUEaxegFE8lSub7wTgYYSTXrGs7vuri55XTv6f52PPlKexrsL2FvFuBXgRtPQXdOypdSOQKo44STec2ikMv6kMU3wa6NZNzR/1eht/Cg3RfX978yTOxuzR2mFwqMhHnPQyfQnl239c46TI4KcZVNjUBln1fRF9d7/lSDY5ejW1uBq8NxvK04QxeOM1R+Z760n/hPH5FK+9RewLK4tSQk9SGncwg9NFNpOM9s5tthMcpi3YdqgVkZEXC2tWGh8+nxDIYIp5mhtDg28sQNdFkKrs61eFhOirBubcyX6XRtSCRNUH6zBJAVQYlqZcdjP/r25WUbibXsFZqygmBTFUxv9DaeFRmH2nVjGGFM3czu+5U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2KF8tDOX1XbBStmwomY9P/ky2tUjwYXcbAZK95FJHoQbZ9RQ7hjbEDoCBjev?=
 =?us-ascii?Q?3hmwYU2uzGmRwVOL1wSNzTXhY0RyEutiqIXIGvKn6A077tU+7E13wWsvOrZy?=
 =?us-ascii?Q?Vq41KwxcGslv1mZVPhMgFTJRbCeBh+rxCgtn5+pgNroNH9pXdoGdpxLY6Fb9?=
 =?us-ascii?Q?yt+Oi5THXnXWOSHMXgl+fW4Wy+f161JvlQnFNb/x+HbPSl/YDUk+bafj/ZAF?=
 =?us-ascii?Q?H6H5akhv0rzD/tm7fIBtoVEZnMUU4OKuiZFBfzGrZLMiLUhld7o6EGAzJe5B?=
 =?us-ascii?Q?PpKBSwB1I8JOFNn+QYv95GmnpW9iRG8YZ2skl3l0qDY0Oc4VIV7Nx3pCiMpQ?=
 =?us-ascii?Q?HR6UT8YQt99/myQ1SNng2SmZFw3vPcvJeez+GG86koF4/qmqmUxA0VAJQDmJ?=
 =?us-ascii?Q?Ho7x8WJ36E+rQfe2awVoqFaS2zeVE0zKsR/OvIgjv2ydeYmSHAcHW0YhzY/a?=
 =?us-ascii?Q?WdvXeat/ECqMDKsrNgANK96PDBS8aj3rPqAvY6BTsZlKojNLreKvD+8QAj6S?=
 =?us-ascii?Q?NGCzfXabcV9eiutEv9tACmIevIiBste01YLE7OdBD8ltTey0qKeJKrfpT/O1?=
 =?us-ascii?Q?s3OG/wDTWhAUhx0Vq5IRLqDPjtWRMUdWkjdIp7anqPFXEMHEzLDoClg2eiHE?=
 =?us-ascii?Q?IHDO35bZuZ10yXaOpFVzBtXhpenwCu/zTmY8sQb7ceN2j3+xR1xztzpypLgt?=
 =?us-ascii?Q?brdXajA7kKy7FThw/R2MSOk3E4DV6rElqGPHpdxp13TYNGbX5YCmnF2A30rd?=
 =?us-ascii?Q?wW0BczoI1oujsdgVKBiDzTWn31jYlj1Sh4YPG9KOZvFUULrUnCTfskSoJGKK?=
 =?us-ascii?Q?nUaG74FvclqnhakMUlBX54ym/a8LtSQX6DRN/t2rb8rsGJ6vKX0TrT7xLrSZ?=
 =?us-ascii?Q?xM0R6wPs9lYFn26MAI0WjhZVn9VVNYg8ovKessXWfTCZGy/xYPL/EsYb96dU?=
 =?us-ascii?Q?c0l3pmyGnK2fqvrO3WszbNzmWm+N6J2qt9CzUDu8KZkhY3ctzkd0iUsMFYQX?=
 =?us-ascii?Q?kb0lETEoi7HA3qFujYbiU1+9H8ES0IsWoFnW49t8ta2pWy4MNyC85tls3u1+?=
 =?us-ascii?Q?dnoxQnvVoHB97+bGeblbsYqgIH05cmmWI6hs3epZuMFR5wm/VBy4AyeUu4NG?=
 =?us-ascii?Q?tWE+QgWGq47D4to2DmyZsUCZOAkGg4BFYYbK9KhFmHG2HG0L/qDvJNShBf9u?=
 =?us-ascii?Q?vWnrYZGnsXohGMTfDj2wJkJiY42dr01StoDM44i1SrSPO8LJpzfcME+7Zsm2?=
 =?us-ascii?Q?1Rf/qWI2wW2+9O30sstlaTgYknrqbl5e0gYCjAXlPt5yMKXpqz78W7bBRA/R?=
 =?us-ascii?Q?SYzI0y4J0NnrN71RlPbVZZCLVFFVvVAZltX5SuhcFZYEvZLJ9cwMAKzk/1tX?=
 =?us-ascii?Q?i96pNSNnje0ugE18C362UPa7ce6NIfaKQe5lPBRZX6uCC9FLDEkuP5uIJOyq?=
 =?us-ascii?Q?tbEdt7c9Hpfos1LTEfv18dLKNlWgfY6Pn5SuRgMR3WWFJXjPixmhB4QdhZnd?=
 =?us-ascii?Q?99Oa6L4hxy9f1WwZLhD3e90K/tj0DNoB446po/zSHAUDFultBnIeAUlGn74p?=
 =?us-ascii?Q?63NpdR263vByoPbABEmaz9qWCInMVp9bSSbnXnJuH1wld6qBgzxaQAVGi6WD?=
 =?us-ascii?Q?4lbZ7raBycOhWf1ebiNqfl7CULzhccZjS4oh0Q4Mos14/3QNBrg2EFbV81xv?=
 =?us-ascii?Q?DMnqPblyhGMbkXl3Zv5tPzkNvGuMe/P66KHEuvRnu6nkREv4djMHmm4Huct/?=
 =?us-ascii?Q?xgYr3iJW8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dp/tfJJh0sx2U6k+KNH0GUNKm8chbMcF1GKKS9k09zl78xo3XoUKgTE5aiKkuPbdt7N8L1/RXjfbwx12olcFxQrzTd6x1IY/lBojFmhQN3e6Pt7FxxjmGRmrqglwceRDfZojYTFjXdxz7h+ooDAbf/iyTab+HmzObqRMB6S94P0hfci3bVPNHh+vAQ12UTn6qpwtSFkJx3n9xIpUcAdUtgEs/zS9KtD2STEw+Nz+S/oHfFpFRc4+YFgWDkMa5YMCsPm9MW+EagY03FuP6Urvj3WyabzwCF3ypLVMjc6xuvCiHi2J1d6c/ri1xq74bt+MW3Eg6XdKRiBZNA99kvpXvw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939dba64-bcbb-483d-0025-08de9643fe4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 14:26:30.6245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0tEQ6giL5AGmKUYn1fFxjezrX2SmSfsTnRQIfDYorH4MeI1JYiSHEAFFybBcQWhJ3Nh+ekq+DXvbwOr7QRz/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFBF67129C1
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

Recheck-request: github-robot: build
