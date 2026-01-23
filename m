Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D2D77880
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23EC640269;
	Fri, 23 Jan 2026 17:36:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2D2E74021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:36:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769186199; x=1800722199;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=jaCCMqoUqSiqchUynebilUhSqeMlFKlLSHx72oWPJZc=;
 b=cUEgMdNTIXfR1Pu5odklihKMEQZrOj9sovKtLUvL0IGpfr4gl4Xts/9k
 A/Xrsbt3hYZpL3cqgcSk5DKvP3u3ODNbBiP05s+SZPltbBlgbsdBCHyyp
 jJh0eOG567Qi1AzGf2T7RO5vXPXdGFOo9tktGpfY7xXxgduCcKOEj7yv7
 i44tHX1NBrw/0gOuep/MLmtf/Pnmrgn+rHYeBaZ772q+E5svF2uOYzRd2
 fZqED6vCTraBVQbSejHhkDeFaVN4wayFjkf8AHXGTVNV4hWHinz61Ikyu
 XBQ7YJJ+v9ao4LEZ6RAojsAuUcM0aaJN4yzgqSz29PfYFRmJfGxvGWu/m w==;
X-CSE-ConnectionGUID: zfQFKk9qSPyEpBJcxUOa+A==
X-CSE-MsgGUID: xHp3jrajQYKMogWbo4zITQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70356152"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208,217";a="70356152"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:36:38 -0800
X-CSE-ConnectionGUID: uttZsizQRC+VyLfYGoDmFg==
X-CSE-MsgGUID: 6F2ZFRELTnyz17NjPeBUzA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:36:37 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:36:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 08:36:36 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:36:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIAXI1i0OK3yKMvkVDzfkh9s473L64bKYULqrDiXT13N/IIt/9DA9NTT+giqc/XVJcPKcDU2NeNeSIwD3uBF4zelbnScbpl1nugZOUuvoBCGus3wiSUE+n1TPipxkJbHXp60d6WXip8Kur0Td7ZgwMpjEO3rdQVVuD+VFgHzIh488FiZow5Ez8eOvg4r0YuhdoC1g2F17wwIqi7Tt0hxn4NWvgmSW1n8KWEwgicRaMRCJ0XA2XAo98Im7NniB3wUU8fW/QiVpwGIOufwEZs1Cfy4ilp3c6rjN0c0dC8ubEVEMzWkeueXHHg3hwijgPnYuBRbabz8uDAl4iNhLigYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN8kAsKtYpe48hU5qyCB7cnYKZ+B3Y+h1LbLfgp1mNE=;
 b=frhv3zVzHGVxcjMm3jMTd98cEFYS0jQ5V8J4D4PR6ZpW7jJ1vVklAJsYVYWEdJ7qZg4pROLDHrkLnPuEuvF7+WKTTAmIR1lr64fxt6R612TKsK10M1s6zwtizqUy13TteVx/sBe40CA0EPgVlxUzDzHV1yQODxgoJ2ViZbWl1rcx73QT0W9L8HBfsw4jLJ3YPra1rFzHM5P5Os9ppfWL+pF0LDlCV/hCBuEqYmu49HbP5b9TlJb7FoE7Vabu2KEtMIZQkJ2QXp4moi3i9tMN6A2bPGtLY4hLn7i57guoDlzFesaEeTfgQpLTuvrFeIWe/jJ+p9PMp9EHo4SzpXf+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 16:36:33 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:36:33 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] crypto/openssl: Add support for SHA3 algorithms
Thread-Topic: [PATCH] crypto/openssl: Add support for SHA3 algorithms
Thread-Index: AQHcgJ/nj1X7PHpVUUSKEdkZNhcln7VgCxYe
Date: Fri, 23 Jan 2026 16:36:33 +0000
Message-ID: <DS0PR11MB7458A32CDF2F3FE134BB7D958194A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260108130827.2366365-1-emma.finn@intel.com>
In-Reply-To: <20260108130827.2366365-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CH3PR11MB7323:EE_
x-ms-office365-filtering-correlation-id: c119351c-6da9-473b-1e63-08de5a9d91f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|366016|7142099003|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?YBZdgCywucUdcvv1rlReRi/qot8JEyaKooaar/fyiEM3AavYLghaIr+iOK/T?=
 =?us-ascii?Q?u548MhG2wqvTXjHLfF8+YaBqeoz/q3cKAlldl9gF1ki9tP8HM7fQWBlMDlaf?=
 =?us-ascii?Q?gMqHh6kGT2SFc2T0rOAoxKiZWnTu7r2YYibuoJSgs8MNmBNifA6Oto8bDlyT?=
 =?us-ascii?Q?LVjWJOxfgaOtFzZiYOVRQmyjLYKbh83Qi74sZmszqJTeASlWb+CcfWKc471x?=
 =?us-ascii?Q?2CsO2Ul8XFmIA6Zu1Ah1IKgzM8LMvjaN7oDcilKfMVbH7+UK5IwQIO/ODNFr?=
 =?us-ascii?Q?7sEicc8Ut8Tayom59tbP3Brv3Wv//qyk8DYftJ9HySJzqklECyxDbAfNRlSA?=
 =?us-ascii?Q?HNbs8XoKMMgXAImPXKALSQNNknAdem1EV8v/fqJWj9dRMKzPKp6w0p4eteYV?=
 =?us-ascii?Q?z3vr9rxMSBkywYjBbkJJDb5crgs4L8AyNkkzulnW/WMAJMYrxW/Fy4VDseJD?=
 =?us-ascii?Q?Mvtx2M0QY3FjFloxyHDWuPvVqh9g2jzChztQgGXIAaerTooBA/EYGqdOF4LT?=
 =?us-ascii?Q?czALhpUeLkwag30ugJExXBCe6u0tAzjdFYCB0eCWDYZLyRLVTDTzwoKZ6x0D?=
 =?us-ascii?Q?P/GgAsmYg7aR122GIeSnLxcsTdrub6ftCSfqZMbPO/IaW3hG01uK70WKtfiu?=
 =?us-ascii?Q?xjvh8+UkMs876smy3xphQjOVEhBV6rLCX9fdEfcNBApO0wKloHwBQnkYu1hE?=
 =?us-ascii?Q?vIvJTGi6QM4hxVylv3l88NbR7aIbf0U5tHEqbXYXGG9nql7sJdJZUg8UnSdK?=
 =?us-ascii?Q?zxFNNxNxyu36PxQRwq3nr223VY5tSqoqN7nZsI/ACCxoOSAZ5i1PYwbzi6v3?=
 =?us-ascii?Q?iXgUGEH+Fwi0am6XfonWPzfEKOUO+O2R2iyfIR2ISR6vZjbaJ1Nl1KlZeOO9?=
 =?us-ascii?Q?MUnyVi47bBIAyr5aLnGOmMqp2O103erqTZ3TFJ7QE1JEoBQB78Sm9I/Uabi6?=
 =?us-ascii?Q?s2xnRH/d1pvsiCUtWrx8AWwnozzkIMszCa0sDV/kuG3fplo6ooIj4rod5ItG?=
 =?us-ascii?Q?zD5/F3kjwNZ7sZj2hzNgzjSr9NBLsWGGvJX+riCf31VlE0p9fhGBdri+OUkb?=
 =?us-ascii?Q?IPBWZZ4Mq0rs5Do1G/Xsu+ObcwgFNr2mtiPcKX0zh7iOlEDdyuBW3AvdBLWN?=
 =?us-ascii?Q?oCS3ZKsd/UsAcXCO7VlfqTR0r3q9O/dCPXoDPJKSG9egrww4k0oRywcEBYlv?=
 =?us-ascii?Q?2HSxSbUryZXILgFozIYVQoaHXYpbuRcVJDM8XUdxp3k41g+QzItUZTE0MfU/?=
 =?us-ascii?Q?/+TeO3M/3J6ZPxfNyAr4Jzb7nS1q1flG4GPkcWnxURhd9gICGLhWPzv3kevn?=
 =?us-ascii?Q?rZIzlCaCoGXgubO6cti1uvD7xToI8QU3yd2DPbNXVepjAajdMxcQ3vNO3uUI?=
 =?us-ascii?Q?FWdELWtWUC9eGppG7c3Llzxb57mT3nR27BhkI3yZZfhwaKl83kMN4CWs/07X?=
 =?us-ascii?Q?bIOhEeztr01J8FLUfCKx0NsZHlGNELo/c5c8JsFNiJXfB0JPwdZ2OG/4tdN4?=
 =?us-ascii?Q?2NOAhuvSfTHTLcowMXbJk9h4G3bykqqp1GvEgqLsXrx0X6KWBLs2kjwS3Z3w?=
 =?us-ascii?Q?Aj4236vlsOMOjJlxdYP1smuIeKB6Y60CdaxJdinWVs/D/giiLabEE9hcgNtT?=
 =?us-ascii?Q?BDz99rX3O4oq+3xw0wYXueA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(7142099003)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GgjLMwkjmy+bWIwudd8mbKZSYHwYPsdCwf4dPN7+sHdsLpNSuxrfO3uXVbz0?=
 =?us-ascii?Q?nLoRHX2jBC4A8RXZOu/8B6MKyv3wLxYVM4TBateUGziSs7QxY2kWhZTC14ge?=
 =?us-ascii?Q?BZxvBjF7S9iz2UB6U7o7z8VIRPmIGFx5+HWoVXBzV0sai/StWbh+yeZpQTdE?=
 =?us-ascii?Q?XyUL9rpD59rScgTAdXkXYWTkPwdvWsF2Z0oiWiYRy/Tv0pHLP4eQtZmD15Yp?=
 =?us-ascii?Q?kYsNRjS5keXiSqKwzU1NjwkXkWyXL63NEzzIjRC0y0+Q6WkWsCgfl3qezS2z?=
 =?us-ascii?Q?W4oNAJjYufvmtJlBkVYgHYnsc45TXd1GBoQc27Vc/aXgZ8rgDTiWfXQdR8gz?=
 =?us-ascii?Q?bEG0MQfQsTXMcrTNJNUo+xB6rBoOl2nltEbgCuC1kDQT/Tx8TSR5l8k0DPOU?=
 =?us-ascii?Q?ZyeMJJLIm7td52vjWCpylEqrDw+SDNVDSTeEeY2qO1c406GyC7OThcnpfBeW?=
 =?us-ascii?Q?wX2SSxDOYH9UDJgRPNsd4GWQvsWFlachz9a+5Hcd6KSq6C714BJ2H/5EGtMI?=
 =?us-ascii?Q?yEuGYg/Yg62ir1PzidvpXiEeAdmNSS69WJDsqJccPcacpHWCM59Jlt83j0pi?=
 =?us-ascii?Q?kmEpWRaYI+5xWuj0JjyOKeq3vAD29oH9bF4eRPsKGuVvfmF++qeZOI/SgC3m?=
 =?us-ascii?Q?OyyQ2IlyqI6JkAveSRDB9Pfy4LhBIaxmSmx3fZ8jg+NxtOiKGq7KTjgJwYAL?=
 =?us-ascii?Q?SYWMYLni28eLjcUvWXQVWzyTLTcW9Nm02QnXHjgCs3tPzvmJlNc6BTGsjoxI?=
 =?us-ascii?Q?MuQeZo7HxxPRMF2ZzrWatyE7pUaiJFrJT7Klndmkf3LKo0zVTCynfGzfRRca?=
 =?us-ascii?Q?N3CkUW8y/QmaoUIVLIJ8B+fuulPs/+Dfv2kqPHSa2oq0N3T256WIrewVY8Mn?=
 =?us-ascii?Q?io0GrPaXhiFas40F+uRVFv+0/J97sBSkx6QkOGbEjusXO8M7PriibQwYvJTq?=
 =?us-ascii?Q?R3qA0+qX/5ojYRaSyhefytvbiGB54biOz/Y0Yir2MDeco/SGoV7LKUPKiuLc?=
 =?us-ascii?Q?YPP7GnDnXmmtoq0CUoRn50hyjmNgQoXx6shG0Wd6qcE/VcJdXlziPfZZoPcM?=
 =?us-ascii?Q?N8QamELHMChVIawXgxEyfRpBd2H/u053VkACsuOf71REx+CcfaWO+OyPciAN?=
 =?us-ascii?Q?ULnzjQ1fF4cFLKSJQjvJ2WSv9fpNGtmKwx6kUmH/GhVpsuwwrnbMcsEcvkBV?=
 =?us-ascii?Q?/SvTlztDlL2a10g87J5EjVVmAh2Z5bzGbfc/b4Qry7YbmUu9PijztL42Jugw?=
 =?us-ascii?Q?jbGOGCBu4l3kK8BMbIcFc65LlU7cMmnWent0Q6rT/1CSVNXPo7BPT2nKVy9Q?=
 =?us-ascii?Q?WFL6erfZi763qmUQOjTDMEkd7ICwolIhn1cnzz2B2gS7EZM7270JPgkk3CPw?=
 =?us-ascii?Q?1z4xByI4vzJxc5mgqZT2ATrlGklsf2AG8R4viaZoTxYkKRllrP5aMKD/jT8S?=
 =?us-ascii?Q?VRIZhSFt6JOgbZNjFkUdahOUSzYmebKlAivXLcXqHQ2X6s1OwZ4QKPBUcu06?=
 =?us-ascii?Q?3QFyEJCXdbzL38pLiCfY04pAOQ03U3PgK2z43COKpBvmcC4VkLMhSxuluYYM?=
 =?us-ascii?Q?sENMpuSxEkpEQ+h5hKbMQMntplnxkaqzm0FN2buX+c0dsxeAc1dW/Wdj0ZZT?=
 =?us-ascii?Q?8C9II7x2wNXEc0d3PyBxfs/mglGbmI+N52sVH8vDNgk+Ty3LTDBKkh2niSTp?=
 =?us-ascii?Q?GIgTABoaXSVTXLnHl/clzCLaYlgQFOGXTYxBwdF7HA8YWzfD?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458A32CDF2F3FE134BB7D958194ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c119351c-6da9-473b-1e63-08de5a9d91f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 16:36:33.8094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JoeDO0SInFUeMWzn8aasYT2ttiW7nOcT7zLbl9pqO75v43KxvRAoQMlzcpZ/nc8oV2ltOezaN27HNKpWoEgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7323
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

--_000_DS0PR11MB7458A32CDF2F3FE134BB7D958194ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release  notes doc/guides/rel_notes/ and PMD documentation need to updated =
for the new SHA3 algo
________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: 08 January 2026 13:08
To: Ji, Kai <kai.ji@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [PATCH] crypto/openssl: Add support for SHA3 algorithms

Add SHA3-224, SHA3-256, SHA3-384, and SHA3-512
support to the OpenSSL PMD, including both hash
and HMAC variants.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 drivers/crypto/openssl/rte_openssl_pmd.c     |  36 ++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 168 +++++++++++++++++++
 2 files changed, 204 insertions(+)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c
index 4f171f48cc..8817d7893c 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -92,6 +92,14 @@ digest_name_get(enum rte_crypto_auth_algorithm algo)
                 return OSSL_DIGEST_NAME_SHA2_384;
         case RTE_CRYPTO_AUTH_SHA512_HMAC:
                 return OSSL_DIGEST_NAME_SHA2_512;
+       case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+               return OSSL_DIGEST_NAME_SHA3_224;
+       case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+               return OSSL_DIGEST_NAME_SHA3_256;
+       case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+               return OSSL_DIGEST_NAME_SHA3_384;
+       case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+               return OSSL_DIGEST_NAME_SHA3_512;
         default:
                 return NULL;
         }
@@ -270,6 +278,22 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
                 case RTE_CRYPTO_AUTH_SHA512_HMAC:
                         *algo =3D EVP_sha512();
                         break;
+               case RTE_CRYPTO_AUTH_SHA3_224:
+               case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+                       *algo =3D EVP_sha3_224();
+                       break;
+               case RTE_CRYPTO_AUTH_SHA3_256:
+               case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+                       *algo =3D EVP_sha3_256();
+                       break;
+               case RTE_CRYPTO_AUTH_SHA3_384:
+               case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+                       *algo =3D EVP_sha3_384();
+                       break;
+               case RTE_CRYPTO_AUTH_SHA3_512:
+               case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
+                       *algo =3D EVP_sha3_512();
+                       break;
                 default:
                         res =3D -EINVAL;
                         break;
@@ -659,6 +683,10 @@ openssl_set_session_auth_parameters(struct openssl_ses=
sion *sess,
         case RTE_CRYPTO_AUTH_SHA256:
         case RTE_CRYPTO_AUTH_SHA384:
         case RTE_CRYPTO_AUTH_SHA512:
+       case RTE_CRYPTO_AUTH_SHA3_224:
+       case RTE_CRYPTO_AUTH_SHA3_256:
+       case RTE_CRYPTO_AUTH_SHA3_384:
+       case RTE_CRYPTO_AUTH_SHA3_512:
                 sess->auth.mode =3D OPENSSL_AUTH_AS_AUTH;
                 if (get_auth_algo(xform->auth.algo,
                                 &sess->auth.auth.evp_algo) !=3D 0)
@@ -714,6 +742,10 @@ openssl_set_session_auth_parameters(struct openssl_ses=
sion *sess,
         case RTE_CRYPTO_AUTH_SHA256_HMAC:
         case RTE_CRYPTO_AUTH_SHA384_HMAC:
         case RTE_CRYPTO_AUTH_SHA512_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
                 sess->auth.mode =3D OPENSSL_AUTH_AS_HMAC;

                 algo =3D digest_name_get(xform->auth.algo);
@@ -744,6 +776,10 @@ openssl_set_session_auth_parameters(struct openssl_ses=
sion *sess,
         case RTE_CRYPTO_AUTH_SHA256_HMAC:
         case RTE_CRYPTO_AUTH_SHA384_HMAC:
         case RTE_CRYPTO_AUTH_SHA512_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_224_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_256_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_384_HMAC:
+       case RTE_CRYPTO_AUTH_SHA3_512_HMAC:
                 sess->auth.mode =3D OPENSSL_AUTH_AS_HMAC;
                 sess->auth.hmac.ctx =3D HMAC_CTX_new();
                 if (get_auth_algo(xform->auth.algo,
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..8d6ae346a8 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,174 @@ static const struct rte_cryptodev_capabilities openss=
l_pmd_capabilities[] =3D {
                         }, }
                 }, }
         },
+       {       /* SHA3_224 HMAC */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_224_HMAC,
+                               .block_size =3D 144,
+                               .key_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 144,
+                                       .increment =3D 1
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 28,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_224 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_224,
+                               .block_size =3D 144,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 28,
+                                       .max =3D 28,
+                                       .increment =3D 0
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_256 HMAC */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_256_HMAC,
+                               .block_size =3D 136,
+                               .key_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 136,
+                                       .increment =3D 1
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 32,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_256 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_256,
+                               .block_size =3D 136,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 32,
+                                       .max =3D 32,
+                                       .increment =3D 0
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_384 HMAC */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_384_HMAC,
+                               .block_size =3D 104,
+                               .key_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 104,
+                                       .increment =3D 1
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 48,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_384 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_384,
+                               .block_size =3D 104,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 48,
+                                       .max =3D 48,
+                                       .increment =3D 0
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_512 HMAC */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_512_HMAC,
+                               .block_size =3D 72,
+                               .key_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 72,
+                                       .increment =3D 1
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 64,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {       /* SHA3_512 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHA3_512,
+                               .block_size =3D 72,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 64,
+                                       .max =3D 64,
+                                       .increment =3D 0
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
         {       /* AES CBC */
                 .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
                 {.sym =3D {
--
2.43.0


--_000_DS0PR11MB7458A32CDF2F3FE134BB7D958194ADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Release&nbsp; notes doc/guides/rel_notes/ and PMD documentation need to upd=
ated for the new SHA3 algo&nbsp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Finn, Emma &lt;emma.f=
inn@intel.com&gt;<br>
<b>Sent:</b> 08 January 2026 13:08<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [PATCH] crypto/openssl: Add support for SHA3 algorithms</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add SHA3-224, SHA3-256, SHA3-384, and SHA3-512<br>
support to the OpenSSL PMD, including both hash<br>
and HMAC variants.<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd.c&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp; 36 ++++<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd_ops.c | 168 ++++++++++++++++++=
+<br>
&nbsp;2 files changed, 204 insertions(+)<br>
<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c<br>
index 4f171f48cc..8817d7893c 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c<br>
@@ -92,6 +92,14 @@ digest_name_get(enum rte_crypto_auth_algorithm algo)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return OSSL_DIGEST_NAME_SHA2_384;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA51=
2_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return OSSL_DIGEST_NAME_SHA2_512;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_224_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return OSSL_DIGEST_NAME_SHA3_224;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_256_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return OSSL_DIGEST_NAME_SHA3_256;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_384_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return OSSL_DIGEST_NAME_SHA3_384;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_512_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return OSSL_DIGEST_NAME_SHA3_512;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -270,6 +278,22 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA512_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo=
 =3D EVP_sha512();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_224:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_224_HMAC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo =3D EVP_sh=
a3_224();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_256:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_256_HMAC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo =3D EVP_sh=
a3_256();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_384:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_384_HMAC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo =3D EVP_sh=
a3_384();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_512:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_512_HMAC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo =3D EVP_sh=
a3_512();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =
=3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -659,6 +683,10 @@ openssl_set_session_auth_parameters(struct openssl_ses=
sion *sess,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA25=
6:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA38=
4:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA51=
2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_224:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_256:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_384:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_512:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;auth.mode =3D OPENSSL_AUTH_AS_AUTH;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (get_auth_algo(xform-&gt;auth.algo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sess-&gt;auth.auth.evp_algo=
) !=3D 0)<br>
@@ -714,6 +742,10 @@ openssl_set_session_auth_parameters(struct openssl_ses=
sion *sess,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA25=
6_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA38=
4_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA51=
2_HMAC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_224_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_256_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_384_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_512_HMAC:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;auth.mode =3D OPENSSL_AUTH_AS_HMAC;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; algo =3D digest_name_get(xform-&gt;auth.algo);<br>
@@ -744,6 +776,10 @@ openssl_set_session_auth_parameters(struct openssl_ses=
sion *sess,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA25=
6_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA38=
4_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA51=
2_HMAC:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_224_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_256_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_384_HMAC:<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA3_512_HMAC:<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;auth.mode =3D OPENSSL_AUTH_AS_HMAC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;auth.hmac.ctx =3D HMAC_CTX_new();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (get_auth_algo(xform-&gt;auth.algo,<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c<br>
index 5095e6cbea..8d6ae346a8 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
@@ -269,6 +269,174 @@ static const struct rte_cryptodev_capabilities openss=
l_pmd_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }, }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_224 HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_224_HMAC,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 144,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 144,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 28,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_224 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_224,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 144,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 28,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 28,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_256 HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_256_HMAC,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 136,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 136,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_256 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 136,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 32,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_384 HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_384_HMAC,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 104,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 104,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 48,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_384 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_384,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 104,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 48,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 48,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_512 HMAC */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_512_HMAC,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 72,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 72,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* SHA3_512 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHA3_512,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 72,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 64,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* AES CBC */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {.sym =3D {<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB7458A32CDF2F3FE134BB7D958194ADS0PR11MB7458namp_--
