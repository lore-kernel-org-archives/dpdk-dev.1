Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8365EC83F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 16:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95E1540659;
	Tue, 29 Jul 2025 18:14:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 31C6940658
 for <dev@dpdk.org>; Tue, 29 Jul 2025 18:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753805684; x=1785341684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=nGmnjRz5QSufE74L4jEynFv36A7AT3c6zU7JU4qEJOM=;
 b=a9ay7jdpEEn59KsrcPNFI6eBkDOe8IuPnwjkKQ1RCYJyyZowI5wrRGtD
 46egDHAEhEXEhbtjGNg/evshz017z8kLWCRTC7n5pvkm/XC8vPrEFkYx7
 DeZc5MdKRHoDh7QCAhBDVl7EV0Tu2KtuNu4j1QiYWsWgQdMvSMflW3RII
 X/5xbF1TSoEHEreXHOtB3ZB1OnQ1WaKX+6DWaLafgyCvyxnbpCgf1Mqyt
 6eFOCVExGiRbrHarDMCQWdAmM+kP42M3ypw9mcMa5Rgp8QS+wu7eQVTcU
 Ibla1B8FSBHeYEH6GGK+mLXI57L46AIvia1Is4z1p3bARt3nAQiuek2X5 Q==;
X-CSE-ConnectionGUID: Pc3yv/TaQ2aHtdM248xDOQ==
X-CSE-MsgGUID: soYOnF2LRg+uCtlYB44suw==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="58707231"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208,217";a="58707231"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 09:14:43 -0700
X-CSE-ConnectionGUID: kG/KoVIoRX6vfZtVbeaoWg==
X-CSE-MsgGUID: Dxe5fUsmSxSeDay0ljfnHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
 d="scan'208,217";a="167227924"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 09:14:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 29 Jul 2025 09:14:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 29 Jul 2025 09:14:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.76)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 29 Jul 2025 09:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbfaD4zzTmKy2V4AUoLUVmARphzwTVZrcxWd1SJHkYn+Rx3hE2Y1zv6BU87Nd5YuYzLN7WdaQm1MyRVkoIb4oyFDadQ38aNVmIsRA9r2JBGM3xdq2E54gKwSP5tqfFxvMwSjjdJDW7Vi1sD7fYQsEg2keVzyF3xnY3pTVQ6nuhP3VZr5syYrIVTRfGDJfHrs2O+GE8No4/CIkoloRq9QfgnWZmPNqMXFFJqWpGJWHt1qLxUf/24tIhaWHYePOPA5g5C+iDXFZXma0zoUpfowwB0PJ1CVzqK5YmeBT0hu1hLft1Om+zZcRwrRmjSLw0czobrqPBMkrYykPKgUKRqz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk+6ZxodB0tbopBzlrxGs5/GGQBO9yPjGUoCIvJMq1U=;
 b=bQ0CwRlr3E3XNBm+iR3EradftCbQKREOyDl7bX/inBR02xbV3TcIdFdrqWlLRRSRLVXN1m50tpiAolfYiLroKfYtbxS8PEnBlgbKQI5Gp4VWgE5U0o6kEiCE5Ba+kU4vRnJADdNccdIC8XDdy1mjF7YAvF47+32MAijiKvPffA8xk4b2z1qaaILIb8n/aXGoteA257I7vnG51yFSp+Q/kO/erTYkwLA5Hc6IesYK1eSwhwXHEmAGqAc9ubZG1D48+sA8Q1APJerHRjnH0s5nLxxqZ4I/Gc/5Vsb/1zB9N7lmnetrwdpl/y0TUxHkK8KMa/7Y8skMKuJ7dd5GajsseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by DM4PR11MB6407.namprd11.prod.outlook.com (2603:10b6:8:b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:14:40 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%3]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 16:14:40 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>
Subject: Re: [v2] app/crypto-perf: Only run AEAD decrypt with valid test
 vector file.
Thread-Topic: [v2] app/crypto-perf: Only run AEAD decrypt with valid test
 vector file.
Thread-Index: AQHcAG5O6l2ZzVqyBk6YvWLMOmA20bRJRsKn
Date: Tue, 29 Jul 2025 16:14:40 +0000
Message-ID: <DS0PR11MB7458D995BD8E75CFDA7B95B88125A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250728080621.1241228-1-emma.finn@intel.com>
 <20250729095045.1293981-1-emma.finn@intel.com>
In-Reply-To: <20250729095045.1293981-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|DM4PR11MB6407:EE_
x-ms-office365-filtering-correlation-id: 39187fed-a939-471c-7357-08ddcebb0577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|376014|1800799024|366016|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fEw9zsswE1+T8ltpn2pVuTi+AX+VI6xAw+KvyZM2WgR/k7eMRhfjv82CO8?=
 =?iso-8859-1?Q?gYDqxk/dquJIV+M5W/gO2xb16E+2Z8Nr6RGiXPaqh7KI7Ko3MYa9dyG4eA?=
 =?iso-8859-1?Q?xQTSVC/RdBAVWvplAKD2K6aNcXLSvrpKFBe2scctMeRKP69WKQlh27SFAX?=
 =?iso-8859-1?Q?3K5ewrQMUWsFDlRbVmDeyVbcZh3YfLl70q98LUYhODS2bciZsc5grICKWD?=
 =?iso-8859-1?Q?NAWiHpENaEFOJyLIiW5N3l6kvAc1Nlb2mXAJaTDjvrvZrHW9JBTLK1oEID?=
 =?iso-8859-1?Q?a7HIBb6dZCDaRtKuFaNP9SGmfSN1oE8PW/zh9NCKWQ2ZzhCOFo1PIefrmD?=
 =?iso-8859-1?Q?K4Z9y0uAQqbU5KMIdGJiljRt0zdO9YA0soz4FclK3OeXLCJRPn4i/5sisU?=
 =?iso-8859-1?Q?jgPBfEUaNRoeGLOEndwqbVl4cAVAsWlt2qZFBsjJ6+Qxfm4oLdimQy9wnz?=
 =?iso-8859-1?Q?ytjE1LERf5sa/tnpkGnt89oLDRLot3fnlmZXSmVrl4uPIV0nXl8SIlBA20?=
 =?iso-8859-1?Q?AYI9s5jcnAKABwOfmvwu9CGjCKNymOoP77HHDDvDEI7fNVR2gJfBrl+26C?=
 =?iso-8859-1?Q?2myHOydTSRekCnIAi+n3WMk0YvNlmI0zqfjH5E9bwSmN6UlUXGe5+Nf+yX?=
 =?iso-8859-1?Q?1K4Y/1SV7VfcsHU1SzHEPzKldtcWXBY0eKYABteuGYa/TzSSvm9EHm2Du0?=
 =?iso-8859-1?Q?BVJWE4KFwvlTrWeeY6ttAJ/PnMhocxAkWB9vbGY0nlTsnfDE+5BA2Tzmkv?=
 =?iso-8859-1?Q?X0BsnrV2PZIOpdKs8m5oicq04aiPzhHw6H704WcK442mp0QLf+YOAGDARg?=
 =?iso-8859-1?Q?RtcoA6UhEZC/WE0q1D0ZtpSYHngDWBLXkllJhCUisasH5oiJlf0/GIUpJs?=
 =?iso-8859-1?Q?gJXE7/GgwdxSa3fls/P77HXiUQ/TOPpJ6iWB3MC2eLqNMtoUw+rvt4exnf?=
 =?iso-8859-1?Q?KBX673dyGF5CguXISAaJBGIZMHigN7Yw9tj2TFGr9TN3h2gkH1pCXuZpR5?=
 =?iso-8859-1?Q?YBSiRiFIKRKjX6jZeBSqyjd4m2efO3Tdn7AoM7oxrdfBRXHtR3XX1PWYiJ?=
 =?iso-8859-1?Q?gCu9aHwCYgcGwEIDbixiz4AdsaGv6azcWhAgc6b4qAqqv8UZnKgDG79xQW?=
 =?iso-8859-1?Q?6JdM3ETvf07n/MDAXlOXKdNA402ib5cHAgMiV28a/dQ4XyZipUudf7/iyD?=
 =?iso-8859-1?Q?gItVj2HGuWrqzjqjYzp/mceNzf77q77axOegKmTnM1ysvxosJb19cyvXUF?=
 =?iso-8859-1?Q?M87kcyxPqZHyBOZyTz9Tg1ThHg97lO0Z7RlIJwjDee88y2pxlfgOMGuCP6?=
 =?iso-8859-1?Q?Q+nYTNeJZuhBBk7BOVlGXyGB5Qk85EdupXPJspb/i2LyMpcKeXuheeUwlz?=
 =?iso-8859-1?Q?zgCbqiYJ39NVBOC68xN3z9KR+O1dqA04ar+MEfvwR1IbwJcEgTUixFhKQr?=
 =?iso-8859-1?Q?aNBr7Vt/OdGTRGZvsz0pGiR/kmwM0WkT6+8CBuvx97FvNBvKWXcNBjcZdq?=
 =?iso-8859-1?Q?Lb33mShqpvlXA8AOoyk2Ez6cfXxYXNWC0X/EMbH2Zy/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?etHZz18Y7QO3y/AENxNAjonC3WcrGzORrTKsgnjrwQG5kXCMBcIj3Po7VQ?=
 =?iso-8859-1?Q?Gwfw8hj0rfClRmNCCzIJb0ur2RaFX/VtIPDIVNT+O7kUm3jG/I/fybe1cc?=
 =?iso-8859-1?Q?Lh0B3p65jnTNQg2/2QSQEmKr8FHS+1X6yY7WfbwNpaL/VSTegq0dc2Iup1?=
 =?iso-8859-1?Q?6LyAKoDYpL69hq/2jZojmnZZfv/8sifkBsUI5sah5X1+ehd8uyaAY5Hvrr?=
 =?iso-8859-1?Q?hu3Ej92ZKIq8ToLam9q0gGuofSIvbA3ygBUGl5M+YsN0fI2SRgRqHZNhQO?=
 =?iso-8859-1?Q?PW97+a4hSusYH3BFhQ1XviHLBfKu0VPQSJY9yCxMWjEq99skEjJ1cKC+9e?=
 =?iso-8859-1?Q?lkNoSttWTGQTKxyhPuCMeHm8lTN4TdWr2XJvCYkc2QDXuNYDdRisScROew?=
 =?iso-8859-1?Q?DklslsndNa9z0nfXsfiNG/+pJiCwM+lHul8DwJj5s/9ZhCIs7TZo+Panyy?=
 =?iso-8859-1?Q?CnPukPEsyHV+LD3ULnxRBSLeuE4PcgWsdN6lG4qAL1N+vuEamuYuNHRxib?=
 =?iso-8859-1?Q?lui9bFLn/OMpD7p4HKAhmyDlBmbWlnJx2ptjuJACahI9p7JPynaIuVxgGr?=
 =?iso-8859-1?Q?+w+g9zUE8Fi8xuXVRGn9nVkY2w6h1j0TV3J9MMfqaEThYCvv2Xhn6jKlof?=
 =?iso-8859-1?Q?j6pkblXQZI4VoGXUr078Br2XHMq9GUMecdu4OTgIKsUcPUluSEyhJwV5ge?=
 =?iso-8859-1?Q?7/20843EJqa6nNjluLUlFULXZiewhuYT5eTJdoGb6Vf7KI7Li69bJ34cp3?=
 =?iso-8859-1?Q?7pBXdnn/9WinOaf7ztEc3M6JBJlt0C3lxju2wYbYXzGatxtOAnnE054B78?=
 =?iso-8859-1?Q?XkAbM8uTMei2r/JoCXpQkpiWpMJZw8o1pJ1KsV2WCHkD20Xhbn2XQqXYj8?=
 =?iso-8859-1?Q?JMcnh9rJJAAjwsWbzVJ4AbY4xHo47RFaXoVyxOqssIMN9xPoxdCD5lVmng?=
 =?iso-8859-1?Q?AJK3qDQCn2Wz7Llo7xB6a5JuIuxW+iN5Rz6THCquFKZB54dLP1/pWv9JuK?=
 =?iso-8859-1?Q?nrGWDuoVZmwPxT7hKStO789AAgFlY3QkqZqb7XsNNdASc1yk5XSvoa9teo?=
 =?iso-8859-1?Q?I8yni5RR/uNzI/eTQAD5SFnTgzTPLCwNiIRVu/GV+mm4zG7veBgaIGJIf4?=
 =?iso-8859-1?Q?NG1zFqym5nWeH2va52kTqkKQ/8YIzeVK6PaBDmHFGEuFRlQhIlHDQvBfPH?=
 =?iso-8859-1?Q?M33marGrdJ7xFR5RDyvq2T2HtnvwtboYei6iiSna3EC+GbUubZ+c2nJ5r3?=
 =?iso-8859-1?Q?KjmXu065ChXdTCFd9yjxCwzGNolgkcJBKQ3BoXPKXPqtFomo6tfr7zx8pL?=
 =?iso-8859-1?Q?gylTkxhajLzwcVFJ0LI4omgyblTE44x50qaAs0kLzr4Zpan4ysql8b3l+Q?=
 =?iso-8859-1?Q?5gHtcXJJIBWcoKhM5jYovPWZYjGt9+Flta23TJDoGx2xQgoN8aNwhkvKkh?=
 =?iso-8859-1?Q?gs24oTiwJwyTxaASUnrzQh37tZQj/zufyaQSqWGuPI6aSs8MDMo2OKMbuD?=
 =?iso-8859-1?Q?Pde9/t3/N6mzWag3FtAEz8U1ZyXUenjVPTTUNtdCS59P/0jCTPWqtjPYTg?=
 =?iso-8859-1?Q?czwGCuK3oimhh6ek8I3B1tFUdci2I+LIpFyf47Te3wSFs0EcVIiwD1v7WN?=
 =?iso-8859-1?Q?yW+AAIUQ0EzGE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458D995BD8E75CFDA7B95B88125ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39187fed-a939-471c-7357-08ddcebb0577
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:14:40.2338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLtsQx7nZwGyLFpuncSfgr3E3CT17bNBNw1gfYNNsiWzSmcHd3/NxfNLQaLRPsEd+jM+pJX7LtXj+MVIs50JNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6407
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

--_000_DS0PR11MB7458D995BD8E75CFDA7B95B88125ADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: Tuesday, July 29, 2025 10:50
To: Ji, Kai <kai.ji@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; gakhil@marvell.com <gakhil@marvell.com>; F=
inn, Emma <emma.finn@intel.com>
Subject: [v2] app/crypto-perf: Only run AEAD decrypt with valid test vector=
 file.

The test dummy vector data is incorrect for AEAD decryption, so we should
only run when passed a valid test vector file.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test-crypto-perf/cperf_options_parsing.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto=
-perf/cperf_options_parsing.c
index 0e0dc4fd06..12623e4cfe 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -1482,11 +1482,26 @@ cperf_options_check(struct cperf_options *options)
                 }
         }

-       if (options->test =3D=3D CPERF_TEST_TYPE_THROUGHPUT &&
+       if ((options->test =3D=3D CPERF_TEST_TYPE_THROUGHPUT ||
+           options->test =3D=3D CPERF_TEST_TYPE_LATENCY) &&
             (options->aead_op =3D=3D RTE_CRYPTO_AEAD_OP_DECRYPT ||
              options->auth_op =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY) &&
             !options->out_of_place) {
-               RTE_LOG(ERR, USER1, "Only out-of-place is allowed in throug=
hput decryption.\n");
+               RTE_LOG(ERR, USER1, "Only out-of-place is allowed in throug=
hput and"
+                           " latency decryption.\n");
+               return -EINVAL;
+       }
+
+       if ((options->test =3D=3D CPERF_TEST_TYPE_THROUGHPUT ||
+                options->test =3D=3D CPERF_TEST_TYPE_LATENCY) &&
+           (options->aead_op =3D=3D RTE_CRYPTO_AEAD_OP_DECRYPT ||
+            options->auth_op =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY) &&
+                options->test_name =3D=3D NULL &&
+                options->test_file =3D=3D NULL) {
+               RTE_LOG(ERR, USER1, "Define path to the file with test"
+                               " vectors.\n");
+               RTE_LOG(ERR, USER1, "Define test name to get the correct di=
gest"
+                               " from the test vectors.\n");
                 return -EINVAL;
         }

--
2.34.1


--_000_DS0PR11MB7458D995BD8E75CFDA7B95B88125ADS0PR11MB7458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"margin: 0in; font-family: &quot;IntelOne Text&quot;; font-siz=
e: 10pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Finn, Emma &lt;emma.finn@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, July 29, 2025 10:50<br>
<b>To:</b>&nbsp;Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; gakhil@marvell.com &lt;g=
akhil@marvell.com&gt;; Finn, Emma &lt;emma.finn@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[v2] app/crypto-perf: Only run AEAD decrypt with valid=
 test vector file.
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The test dummy vector data is incorrect for=
 AEAD decryption, so we should<br>
only run when passed a valid test vector file.<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
&nbsp;app/test-crypto-perf/cperf_options_parsing.c | 19 +++++++++++++++++--=
<br>
&nbsp;1 file changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto=
-perf/cperf_options_parsing.c<br>
index 0e0dc4fd06..12623e4cfe 100644<br>
--- a/app/test-crypto-perf/cperf_options_parsing.c<br>
+++ b/app/test-crypto-perf/cperf_options_parsing.c<br>
@@ -1482,11 +1482,26 @@ cperf_options_check(struct cperf_options *options)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (options-&gt;test =3D=3D CPERF_TES=
T_TYPE_THROUGHPUT &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((options-&gt;test =3D=3D CPERF_TE=
ST_TYPE_THROUGHPUT ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; options-&gt;t=
est =3D=3D CPERF_TEST_TYPE_LATENCY) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (o=
ptions-&gt;aead_op =3D=3D RTE_CRYPTO_AEAD_OP_DECRYPT ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; options-&gt;auth_op =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !o=
ptions-&gt;out_of_place) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Only out-of-place is allowed in throug=
hput decryption.\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Only out-of-place is allowed in throug=
hput and&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; &quot; latency decryption.\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((options-&gt;test =3D=3D CPERF_TE=
ST_TYPE_THROUGHPUT ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; options-&gt;test =3D=3D CPERF_TEST_TYPE_LATENCY) &amp;&amp=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (options-&gt;=
aead_op =3D=3D RTE_CRYPTO_AEAD_OP_DECRYPT ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; options=
-&gt;auth_op =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; options-&gt;test_name =3D=3D NULL &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; options-&gt;test_file =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Define path to the file with test&quot=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; vectors.\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_LOG(ERR, USER1, &quot;Define test name to get the correct di=
gest&quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot; from the test vectors.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB7458D995BD8E75CFDA7B95B88125ADS0PR11MB7458namp_--
