Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82D8D1F9D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 12:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2054240655;
	Thu,  4 Dec 2025 13:18:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 66EA040144;
 Thu,  4 Dec 2025 13:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764850720; x=1796386720;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=HzygOja2MxUfmOl+znlqXiOrGzD2n5pjgCR0jLPKsfc=;
 b=HdXgg1T7JheQ+jB4V8ZhQ1T3wIRD06C3lQ1X8uExGISHLInVp+iJftgY
 EzVPyYsB3AbtUJ5AZQ6YTG7C6xekwafF4P00nDEsm5dhZHxuRQTrOAHvv
 zdNHHSMWwD/1SnKW+K/Oqf8xXzUMtFqur1E2pi5s9XCQ2PIfAPIUPfgKh
 0BpRq4TwuLwqE1IRWIuc5/SV+Pyq0rqx+AybwfTELvbhc5HKPHRJYlG7O
 aDOdd+U7V5Q3SRTN5bbu7US9Y2+ESkmPLYsgcb3R879ut0ntXyGUR8Z7q
 jwCKWZaJyS+G8qK0J+z74L3V78Ksd4ENEG+vX+SkUZklViJQ7ZWn68BrY A==;
X-CSE-ConnectionGUID: nRncgnLPTtuVuBjZFsV+Lg==
X-CSE-MsgGUID: 2OpNEevRQnarYZMLeVA3hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="65864617"
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; d="scan'208,217";a="65864617"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 04:18:39 -0800
X-CSE-ConnectionGUID: wHpHTLF4SJ2a0664Grr6Ig==
X-CSE-MsgGUID: NgoxLPNZR2SdLL4jGLqLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,248,1758610800"; 
 d="scan'208,217";a="225928254"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2025 04:18:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 04:18:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 4 Dec 2025 04:18:39 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 04:18:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXc6uG8xGx/I9vra6h4SMpg8pJL2gj5aN1BwTbuEtIPdxygScGHsZVafpffY/W6vJKdRi2EQP6dmRas5e6y7qSYFBAI0moeu+25ZapIoC0789IhCH7iaBF0975Sl7of7RV25BzDdavUT73/7HMdGcuAbamD9QAmlu1hyWGr3SMxPCU8zQEbWOQ7gvcoedWrzA7FVGpnrQNlJgpyHzGh4JjWzgCtaq204v44xEraI9zsDXClrc/ET3bVwJCnlKPpAPB+mPso48eiBmGGdwdJKU4zTSY03MSmXXBWioirmPprGPqYN3KUvOYjrTHRY0/ht0guhU0bfivMgu5ogxw9DvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXLKmlE6at072E7EEthzk2y0gPVqPUp4oJnvLXa+Qks=;
 b=yJba2MtaKHZOS4RQT9EuAyCnpImL8HpaL7//0h5XQtvBkrBQgvEryHwLbBBtLd4XQk/oKggL9TSideKkv2fVFICEY+Oyqp71i2kvdnkGBDRlvp7vz0CSshuV+W9dpZ+yXHlc8rJewUvFyTwM80Vf5Ynib+o5R578sxnjBXbIG21RXiMSkK5pnnKIa7IpwVUj+R+rf29T/eFvxtfxGJNyh846bI9XUjN7S6xHE9b8J/TNDr6xcBRIuGw9bX1JT00AYnl5r1ZTmHYl9M0tWFPD1wzE238Xb3B61/gPKnM85rUwWvFMx+xw2pLGNrztD7kv4aIAVJ+T6/VVsUW5MGDZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 12:18:36 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 12:18:36 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] crypto/qat: align the the vector address
Thread-Topic: [PATCH] crypto/qat: align the the vector address
Thread-Index: AQHcY3p7OzQjlvzS00+vZqzVQ++bhrURaSbr
Date: Thu, 4 Dec 2025 12:18:36 +0000
Message-ID: <DS0PR11MB7458A283A8B07A869A7C1FAF81A6A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20251202105731.851124-1-radu.nicolau@intel.com>
In-Reply-To: <20251202105731.851124-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|IA1PR11MB8098:EE_
x-ms-office365-filtering-correlation-id: 10515e79-c5b6-49cc-5969-08de332f4038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?d4Kk5TEyUuDSbMEVuFlaXKFovc8I+xGrlim6ubKuYJZu7A4Xqiiq2O10Tf?=
 =?iso-8859-1?Q?7QlBYIayNE+Sd602o2vKi/7cSaHokRQkNcrmPC2UWi3+cc0ZD0UibwvE09?=
 =?iso-8859-1?Q?6bdcmhpTfau/77Yr8BANHjTmWpHFuQ1J5WZY2MOlWC4c+R1AoU7WXN9W3z?=
 =?iso-8859-1?Q?2tSTTUINLQuQhJtXOxU3ZtAtt7Bjz3UBqZtTA575WGx0P4yah6WksEttiP?=
 =?iso-8859-1?Q?Jaek2Wq6Otzuj8drKVgUX3ldmUgnPn8J2GA8rnlMIgzjXZ2/TRTq2tiT/4?=
 =?iso-8859-1?Q?UUdGt+dI9WSXhCaDWfes/ynZoUuE2T+asWLvzDdwiknyTLkNn2siGuP0AC?=
 =?iso-8859-1?Q?JudqWLfNC0YogaMqf5iWhscKfYn5Rgih+4PNK8cv2oXV2wOjoJ2vnz2Clm?=
 =?iso-8859-1?Q?sWi1Ramq7Z62MPdmUiZN8CIvS/zO2dUuSlBkeZyY12hC82bhoPXu65+yIh?=
 =?iso-8859-1?Q?dIUw7EyZXz2hifkof3l0c2UZi/VW8cddahEhEm0h8ViFvVSq4REVl+x7XT?=
 =?iso-8859-1?Q?o+5bu6wvakb+INLabG9IVHqafvruSM8IFWqITxOwi3g4g50Vj6LtZMfqT/?=
 =?iso-8859-1?Q?hHDX0zLsuhsB29mWTMl9Ex2F0oJbLexxLAIZxTFTRmEuy9xPYexg6f50IY?=
 =?iso-8859-1?Q?4PGmpV0CmxdcVuDQUzT3y1cMfdWzjl+iBvdmzEhW43tP6b+zleTQE8v4U5?=
 =?iso-8859-1?Q?wamHDNIOlkSbUHJmuVzLJ1yihrnO9SBu4P/ZWoc8RKRFPuHGiBOxJIfHZT?=
 =?iso-8859-1?Q?/Dw6Qsu0GyJaDXQmOlVKgGKypOxOrafikJu0bBoQOPp6+BxwTB4+axB2aj?=
 =?iso-8859-1?Q?NzGZlNhTVe5QjoSp4refi+6fnmRdNbsbXw1sMuj5tlyYKoOayP2hBr+1Dz?=
 =?iso-8859-1?Q?ndwcGkfEntDefaGDKrdLRhUpRDRjSww2aPHsWpzmD1CTYm1ZOueGYzyI4T?=
 =?iso-8859-1?Q?oauEwP5+FZcLNGVUnpWQvLBc4t0RMvb2dBI6vu2og4U5n6ZSirWcN10dlR?=
 =?iso-8859-1?Q?PtXU1gtFOzO4VlQB8oe6xgFhQU3jurFUFg10GmsLpzRTwetMjFjMPwB7LT?=
 =?iso-8859-1?Q?QxLfL/Xm/R3qL+QcCs2wILK82/aDWUYUmyuICT2AOFC3+GHxW5iN/reOcG?=
 =?iso-8859-1?Q?3Vph3jwno9EzpDbZ9xFuRp6Txblkag6zSorZgvSep5Aw5lbtFaM4BpECSj?=
 =?iso-8859-1?Q?XwUHHH7rKPjyi6D/q3SxDTTuHFWjbGQuheJALwx62yXUD3ecDjhbAm56Rg?=
 =?iso-8859-1?Q?ethE6mo11v6NJeHMC4AvcU0n3+Nwqh6caK9MK8bgMIW94YM0DO/bIT3aGY?=
 =?iso-8859-1?Q?CErCxOQO18kOo8k15asaa2SJPLW+sQplJWyLBdV8WcejAguvbGV71hOj4X?=
 =?iso-8859-1?Q?xJNTd5N84/PUdF0P3hcNobXbKn4aGsSyitPvBAmS9+U/2lNuszzvNY9DYt?=
 =?iso-8859-1?Q?uunl5JYXtS56MdvDg1HfNaY6XyNkWOd6RWDPcloIIUdGZtjdmijjR3JSDe?=
 =?iso-8859-1?Q?KqVPH3pActpyHZXzfwmZkxFZ3+qkNCCDTPBmFJEkWjGQOazIFLmN4hF1ux?=
 =?iso-8859-1?Q?Eh+Nf0VegZF5ZSEQ8otmmM00aQdT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nxIxwlJk3p5Yf8jTmvyqA6oqsY7ZpDynGZC2TA27tjXyUQySeAz+Ac+LXl?=
 =?iso-8859-1?Q?CGO8bKw+HpUJABy36woIcZItCMzOW+d164rpWIHY5e8nCB7ojcwWUQeL/H?=
 =?iso-8859-1?Q?SCCiaTd8RqBF9sLVbLoBHPtJZ5id/EFUp4FwKWsEFC1pWJUYvDazvVry8f?=
 =?iso-8859-1?Q?DEqkiSRWy9Z9qbsT9in1lwPCHnlWEx6YCqP+Og+YK2bu1JbmoZvJuxcQ7M?=
 =?iso-8859-1?Q?3m7olPB2oRyOPjW9oRtWJ3Ctvs4ceqUouDl6FJAV0i/+AVyPneXHeFAEGl?=
 =?iso-8859-1?Q?7be1+9O8DuFEZW/mEXxQpl9rD4y3A3uViO8/eovHVCfbjzVWavZT1csCYE?=
 =?iso-8859-1?Q?dRlcMe29yB1aXT0GZN5W1iMNWd1jdwn1Jj7M2WjIW24+Sew7+A7gCgPibo?=
 =?iso-8859-1?Q?PyEn1t+WbRHiyKl8jNA5eNthCeOoO3qrt0WPLpQhu+CGMSduRCgLrqUkA3?=
 =?iso-8859-1?Q?gWK7mprRIFN65/1YpG2gAtqmC6P73SmHge/J0jMTdulb71Rl5Eou5ZAqum?=
 =?iso-8859-1?Q?YBHnwRAkEQIOVBjBBvDoab4oL8IDTebbaNv+So7Xc9Ehfb3k1bSWLn6OQR?=
 =?iso-8859-1?Q?ckKaAHUAFmhqXir8XK09ap3YctoKgml4tPUVGzOO+HlY/snXEJv+gT2xxn?=
 =?iso-8859-1?Q?1JajFR86UIaP5osmOUFI0L4lsYR/vwe3Ni4+0KnjT/dpaPfhlXX6+R9tcX?=
 =?iso-8859-1?Q?lX4JTuy/p72XxjbbHqiEUqO+T+Ut9BlQxPtmO+jQ2LCn2FzpMazLjT3Oaw?=
 =?iso-8859-1?Q?cSz2UE22YXL3LGFo0zPFqGaRul368Ty0KjSTjicOTA6ZlqBlpPXYslu50Q?=
 =?iso-8859-1?Q?M6Se3nOmaqBut7ujr4kGspW73ysQb1+gXH57kDHLZV93QP9hI9+KnA6CPX?=
 =?iso-8859-1?Q?hTJMw2yDzfO2SyPizDxZBkKuyeOK++4JfUQgWCPUCwJuubi1zXhYyM+WXV?=
 =?iso-8859-1?Q?lluRgIt0zl4mwEum5kRXWhRJIbkx3JEBmlmEj1vmgri0mbrjXesKEnASdJ?=
 =?iso-8859-1?Q?jGQli0+W6Cxg0OU0PIxOs0ix//NsWRluzoP4jowztg7GLXb3b0BTIzDV91?=
 =?iso-8859-1?Q?ZSmgU1T+ynD920RVTDMXqO1haBCFhV6oSwSrivOXNf7RWeq2FjNJySnoo1?=
 =?iso-8859-1?Q?2P9nWsnXOAatqFO/MKwlIWSQfNdB7AcmdwMtXU6W14vEVrGTmCqx4UTNCK?=
 =?iso-8859-1?Q?6uaSv3JP+dtGTBen7pi1wuqTCtWmpkyVuAR6BQxmXf0ZTLQQhqbZre/JH8?=
 =?iso-8859-1?Q?BQBUp45MWG+qg1WXUvE7PAh/U55ye1XYA9kqq9zxYxQOyxLPz/YXLhzjdG?=
 =?iso-8859-1?Q?VeHL5KZIkjZIC02LNFXJby/OWXGU6Pi3+RH/E+9Z6/Uu6xwj7fKrDPKtSY?=
 =?iso-8859-1?Q?erMqDaoqg9VKlN3LBI5x1Z/v4pZWOVxc9mvAMGCJGbQVGSU9dxEJmbByIN?=
 =?iso-8859-1?Q?XzQX/SQRTnaVRJkGU3pw/kCrlO+f5PM72E86rocvtr5e+aBhevXmycwgYs?=
 =?iso-8859-1?Q?K0wShrjq3JXMGVfmG5OvE+V1Zh5B6eLN3JfJbZnTYAL2bog/iKOzmiUHhU?=
 =?iso-8859-1?Q?hiwvHF/mXBVVfaWh2lD3mPoXrPspuEi17rrf1Ew6TspmTXvDcJBbhrq/5G?=
 =?iso-8859-1?Q?LGEzC8TpQLyhE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458A283A8B07A869A7C1FAF81A6ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10515e79-c5b6-49cc-5969-08de332f4038
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 12:18:36.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekTY+Ihebh7kkeEakDDNndU0UgeXe/3TDppEeE3CAAC1f2prOauTnpZNP0cEE2hHn1sySL/zr7rfvMliU+Heow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
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

--_000_DS0PR11MB7458A283A8B07A869A7C1FAF81A6ADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>


________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: Tuesday, December 02, 2025 10:57
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; stable@dpdk.org <stable@dpdk.or=
g>; Ji, Kai <kai.ji@intel.com>
Subject: [PATCH] crypto/qat: align the the vector address

Align the vector address rather than computed source address to
make sure the alignment is properly propagated.

Fixes: 253174309ff7 ("crypto/qat: fix source buffer alignment")
Cc: stable@dpdk.org

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 33 +++++++++-----------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gens.h
index 67dc889b50..22ee0fe4fe 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
@@ -443,6 +443,21 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_r=
eq *req,
                         n_dst > QAT_SYM_SGL_MAX_NUMBER))
                 return -1;

+       /* For crypto API only: try to align the in-place buffers*/
+       if (op !=3D NULL && likely(n_dst =3D=3D 0) && likely(!is_sgl)) {
+               rte_iova_t offset =3D src_vec[0].iova & RTE_CACHE_LINE_MASK=
;
+               if (offset) {
+                       rte_iova_t buff_addr =3D rte_mbuf_iova_get(op->sym-=
>m_src);
+                       /* make sure src_data_start is still within the buf=
fer */
+                       if (src_vec[0].iova - offset >=3D buff_addr) {
+                               src_vec[0].iova -=3D offset;
+                               src_vec[0].len +=3D offset;
+                               ofs->ofs.auth.head +=3D offset;
+                               ofs->ofs.cipher.head +=3D offset;
+                       }
+               }
+       }
+
         if (likely(!is_sgl)) {
                 src_data_start =3D src_vec[0].iova;
                 tl_src =3D total_len_src =3D
@@ -503,24 +518,6 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_r=
eq *req,
                         dst_data_start =3D src_data_start;
         }

-       /* For crypto API only try to align the in-place buffers*/
-       if (op !=3D NULL && likely(n_dst =3D=3D 0)) {
-               uint16_t offset =3D src_data_start & RTE_CACHE_LINE_MASK;
-               if (offset) {
-                       rte_iova_t buff_addr =3D rte_mbuf_iova_get(op->sym-=
>m_src);
-                       /* make sure src_data_start is still within the buf=
fer */
-                       if (src_data_start - offset >=3D buff_addr) {
-                               src_data_start -=3D offset;
-                               dst_data_start =3D src_data_start;
-                               ofs->ofs.auth.head +=3D offset;
-                               ofs->ofs.cipher.head +=3D offset;
-                               tl_src +=3D offset;
-                               total_len_src =3D tl_src;
-                               total_len_dst =3D tl_src;
-                       }
-               }
-       }
-
         req->comn_mid.src_data_addr =3D src_data_start;
         req->comn_mid.dest_data_addr =3D dst_data_start;
         req->comn_mid.src_length =3D total_len_src;
--
2.50.1


--_000_DS0PR11MB7458A283A8B07A869A7C1FAF81A6ADS0PR11MB7458namp_
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
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof"><span style=3D"font-family: &quot;IntelOne Te=
xt&quot;; font-size: 10pt; color: rgb(0, 0, 0);"></span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Nicolau, Radu &lt;radu.nicolau@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, December 02, 2025 10:57<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; stable@dpdk.o=
rg &lt;stable@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] crypto/qat: align the the vector address </div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Align the vector address rather than comput=
ed source address to<br>
make sure the alignment is properly propagated.<br>
<br>
Fixes: 253174309ff7 (&quot;crypto/qat: fix source buffer alignment&quot;)<b=
r>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 33 +++++++++----------=
-<br>
&nbsp;1 file changed, 15 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gens.h<br>
index 67dc889b50..22ee0fe4fe 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h<br>
@@ -443,6 +443,21 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_r=
eq *req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n_dst=
 &gt; QAT_SYM_SGL_MAX_NUMBER))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For crypto API only: try to align =
the in-place buffers*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op !=3D NULL &amp;&amp; likely(n_=
dst =3D=3D 0) &amp;&amp; likely(!is_sgl)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rte_iova_t offset =3D src_vec[0].iova &amp; RTE_CACHE_LINE_MASK;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (offset) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_iova_t buff_=
addr =3D rte_mbuf_iova_get(op-&gt;sym-&gt;m_src);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* make sure src=
_data_start is still within the buffer */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (src_vec[0].i=
ova - offset &gt;=3D buff_addr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_vec[0].iova -=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_vec[0].len +=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs-&gt;ofs.auth.head +=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs-&gt;ofs.cipher.head +=3D offset;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(!is_sgl)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; src_data_start =3D src_vec[0].iova;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tl_src =3D total_len_src =3D<br>
@@ -503,24 +518,6 @@ qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_r=
eq *req,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_d=
ata_start =3D src_data_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For crypto API only try to align t=
he in-place buffers*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (op !=3D NULL &amp;&amp; likely(n_=
dst =3D=3D 0)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint16_t offset =3D src_data_start &amp; RTE_CACHE_LINE_MASK;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (offset) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_iova_t buff_=
addr =3D rte_mbuf_iova_get(op-&gt;sym-&gt;m_src);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* make sure src=
_data_start is still within the buffer */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (src_data_sta=
rt - offset &gt;=3D buff_addr) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_data_start -=3D offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_data_start =3D src_data_start;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs-&gt;ofs.auth.head +=3D offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ofs-&gt;ofs.cipher.head +=3D offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tl_src +=3D offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len_src =3D tl_src;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_len_dst =3D tl_src;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_mid.src_data_=
addr =3D src_data_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_mid.dest_data=
_addr =3D dst_data_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; req-&gt;comn_mid.src_lengt=
h =3D total_len_src;<br>
--<br>
2.50.1<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB7458A283A8B07A869A7C1FAF81A6ADS0PR11MB7458namp_--
