Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89581C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 06:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A8EF4028B;
	Fri, 31 Jul 2026 08:09:51 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id E1EBB40280
 for <dev@dpdk.org>; Fri, 31 Jul 2026 08:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=7700; q=dns/txt;
 s=iport01; t=1785478190; x=1786687790;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I3PuZyMlxl6j1aELpboPt8IB21mjft/D60pzEATxrXw=;
 b=igt6H9FPQoxeBxirQZecSfkHKQJGWvrVVao1DXXlOaP53uZPYRaHWeTK
 vrHxp1v/OrtYoDbjvjY+kFm4nMCiijhgcBNSoV7jWe6uH02dY9WDq7al0
 /1UgeKN8WG1dUTc1gHkycaqLmnQqKvyF86x9bkrNNcuPfpYNKZ/qFYMZ9
 kt3vwPN3+1b31Hpjt2BcKRGTU+zPOI+/UBZJbhn5xqaAF9RCqIutsWVLU
 AIEcfXNjzAl/6AyBR3JczXF7OSRAnbTFyqwFnI3y6ofOGfQqVEjh/9pLE
 BLRtukHz0nvgKZPw/sDl60AwbRjXsfK1aUkNeHGO3AnfOjY2JVDgwQUzq g==;
X-CSE-ConnectionGUID: wb1ZqadlQ8eNx39u1HA8rA==
X-CSE-MsgGUID: Cm/osMDIRq20m3cTCywckw==
X-IPAS-Result: =?us-ascii?q?A0BrAwAhO2xq/4r/Ja1aHgEBCxIMZYEgC4FuU4IrSYgjA?=
 =?us-ascii?q?4UriHkDnhuBfg8BAQENAlEEAQGFBQKNZgImNAkOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEFAQEBAgEHBYEOE4ZchloBAQEBAxIVEz8MBAIBCBEEAQEfEDEdCAIEA?=
 =?us-ascii?q?Q0FCBqFVQMBAq8eAYE9AooqeIEBM4EB4DcUAYE4hT+DHAEBhDyBIhgBhHwnG?=
 =?us-ascii?q?4FJRIEVQoJpPoRFhBOCMASCIoEMkjVSeBwDWSwBVRMXCwcFgSMQMwMqLy0jS?=
 =?us-ascii?q?wUtHXAMJxIPHRcXHlgbBwUSICpBRCMDQSQLQwWBVQKBdT8jGTZ8gS91SnUta?=
 =?us-ascii?q?QECEBdKOBiDMQKCXwMLbT03Bg4ZAwSBNQWNXyCCPy1OFIFDgQEZkzmzRgqEH?=
 =?us-ascii?q?aIRF6psLphaI6h1AgQCBAUCEAEBBoFoPIFZcBWDIlMZD44tFtIaeT0BAQcCB?=
 =?us-ascii?q?w4DC4FokX4BAQ?=
IronPort-PHdr: A9a23:iOOXSRPre9dpucPYLO0l6nc2WUAX0o4cdiYP4ZYhzrVWfbvmo9LpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:erV/iasi3tK6dEmsjb49IEALg+fnVBJfMUV32f8akzHdYApBsoF/q
 tZmKTjVa/eCNjHxfdB/aIWyoBgDvZSGy4JqSVBorig8Hn4agMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFZTdJ5xYuajhKs/3Y8Es11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw5ewuM3hH+
 fgheD0rfkvSmruW6eKhY7w57igjBJGD0II3oHpsy3TdSP0hW52GG/yM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwxHYH49tL/Aan3XcyxfrlGUoII84nPYy0p6172F3N/9J4XVHZQIxB/Hz
 o7A10/8RRYBEfC+8yPfqnf3jdPkjDzwW51HQdVU8dYv2jV/3Fc7BBAIfVejrfr/jVSxM++zM
 GQO8SYo6Kx3/0uxQ5ylBluzoWWPuVgXXN84//AG1TxhA5H8um6xLmMFVTVGLtchsacLqfYCj
 zdlQ/uB6eRTjYCo
IronPort-HdrOrdr: A9a23:gofLC6oM6FDZ7cnW92qFYooaV5skLNV00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H/BEDhex/hHZ4c2/h2AV7QZniWhILOFvAs0WKC+UytJ8SQzJ8m6U
 4NSdkbNDS0NykEsS+Y2nj3Lz9D+qj7zEnAv463pBkdL3AOV0gj1XYENu/xKDwOeOAyP+tDKH
 Pq3Ls+m9PPQwVxUu2LQlM+c6zoodrNmJj6YRgAKSIGxWC15w+A2frRKTTd+g0RfQ9u7N4ZnF
 TtokjU96+ju/a0xlvm0XPP75NZod3lytFSLs2BgMoYJ1zX+0eVjYJaNIGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg+CxG0Q6g9XaoxV/Y5eDpTjMzDMRMwahDdAHC1kYmtNZglI
 pWwmOisYZNBx+oplW+2zGIbWAuqqOHmwtkrQchtQ0YbWLYUs4JkWUrxjIQLH7HJlOj1GloKp
 g0MCiW3ocnTbrTVQGrgoAo+q3tYl0DWjGbX0MFpsuZlxJSnHx/0g8k4fZ3pAZbyHr4IKM0u9
 gt9c9T5exzZ95TYqRnCOgbR8yrTmTLXBLXKWqXZU/qDacdJhv22tXKCZgOlaiXkaYzvdMPsY
 WEVEkduX85ekroB8HL1JpX8grVSGH4WTj20MlR65Vwp7W5HdPQQGC+YUFrl9Hlr+QUA8XdVf
 r2MJVKA+X7JW+rHYpSxQXxV5RbNHFbWswIvdQwXU6Iv6vwW8fXn/2edOyWKKvmED4iVG+6Cn
 wfXCLrLMEF9UyvUm+QummmZ5osQD2JwXtdKtmvwwFI8vl+CmRliHlhtWiE
X-Talos-CUID: 9a23:QuPtrWHjI7ijWEVAqmJ4/hcmA8kpdkSNwVHAeB6lUEZAGKe8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AK6dnbA9GNmXUovXbsY87yYKQf+xtpKO1LWwsq4x?=
 =?us-ascii?q?c48zfPhBbKiiWjyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Jul 2026 06:09:48 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 5AE25180001EA
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:09:48 +0000 (GMT)
X-CSE-ConnectionGUID: N3XEXq2PR+q8dV9VxKmaHA==
X-CSE-MsgGUID: uupc0W48SZCElogRJLX/0Q==
Authentication-Results: rcdn-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,195,1779148800"; d="scan'208";a="90295669"
Received: from mail-northcentralusazon11010003.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.3])
 by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Jul 2026 06:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syArbuiJcZ8Tt+2DlJXdB7D9PKcyRt/pKoC5HqoVNG5rthETYeH/pfWfP1iTwM4f2XCdUovgDcZ9dHs9tk+w+0+lyscxDLWXBzCh9CJ81KAf8c1Elp3AboxdROgtWLWnLHppo2Q6gRXa3xPcllXpjMXiDf+S3kKysb4gj91VOBdJ5Iw985zL1dBL85S11v88EcCvJYX7NJYlbRyX32rsmxNgY2xTHaL4auC3lmTDlKkTeTsc/donbGMucbJ7GjY7yXn8DMhXHJEfiT8BHYwQRFb6Ar+JuzYcJD54K5dJaLoYR/dMaIcTItx4KDTDxTUdvxCcR/1JCARMx/5Gyb4XMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3PuZyMlxl6j1aELpboPt8IB21mjft/D60pzEATxrXw=;
 b=cMsm2axBqIhH2Px7Eze2IRKJanha4A8+f3FZxSGcv1Hct/u8a1EOju46O5w/Q8xLr/NaXyM3bhYwcaq67gOJP1l/jPL7ar6CxZzqc8f1jOuYreU7fQ+4UAiUOWHcdzr6V3ZEcc7PV2CDuhf9CRMuSr+U+c2A0Z+ybk4mjsZoK+rvPyxEMlAg91q/EMprfHbRilUTWR+e4wk1Z7FAbYW8C93uf1bfa8g+VQBXGRwfkzExAsopGMlc1x3D8TvxeTVxzZiL+fYHFHwvd19M8eA+6ntdUjGg4ywp4ArC35xzlBTLGzwVo10Sc/ACrhHl4DffWB4bfhUqW85i3NO+Q7ECOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by DM3PPFD2F4A0090.namprd11.prod.outlook.com (2603:10b6:f:fc00::f50)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 06:09:45 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:09:45 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "John Daley (johndale)" <johndale@cisco.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v6 06/24] net/enic: do not use deprecated rte_atomic64
Thread-Topic: [PATCH v6 06/24] net/enic: do not use deprecated rte_atomic64
Thread-Index: AQHdIKl1kSdVMLq1dk6S66aBZPlha7aHJNuQ
Date: Fri, 31 Jul 2026 06:09:45 +0000
Message-ID: <IA3PR11MB8987CB41FEACCDBF2E17B2F0BFC82@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
 <20260731045948.769926-7-stephen@networkplumber.org>
In-Reply-To: <20260731045948.769926-7-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|DM3PPFD2F4A0090:EE_
x-ms-office365-filtering-correlation-id: 943c4589-3496-4816-6c55-08deeeca51d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|38070700021|56012099006|11063799006|4143699003|6133799003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: BwmPwX0XV47ZoPHt3E7YKmiuLotmrAh9HDKJVjU5kJnpK8PSn7mX12D4ZzGh+M5L3m8Zn4gve4BHZWxb94ecbZsOlcAdnI2Ud0GWPUgWUQgbhC6dqfmsQeFnR99fXr9h0ivwHCb7++L3XLhDMq8RRu2875jCgg5UHOy+oLtxaHT7YtJXHecNyELnMgBII4E2QHki/OlNgIf2O/zzzF/RkGz92jZbX2YHDBhpzLgKLwuKVz/Lnal6Ny1xexmEaeQP4ePqkBrjx6oXn37gV8XnosIv08aFlCeoDD4gNxO9pUsHPxXtDJI9UEN6O2s+UXnBBV8elkpnOm2Bgd9RsVeUpxDxYSO1IhBRQSi8cAP0AngL+jO7MWTf6PfSEXHLK9bRVK03+Wqb24mqb4hO5TwMNIxtlgzYlgyuA0fR+f95AsVyNgE3xj/nE5A44oC9z+wKFqDZ8LRU2BvEhudFspqmZOIqa4eEMouzmH8ktTs0KwggE9MA0KzXyAyrrlexNvvla/YZtEwIb8X1kLsQPSFOwRyiMq0cT30JHkSIWpgXQZ96cVfu+mUzm+M2F1DL2g1KtH4QDFaFynPbp6eQJPsfsEZfndE51us2H+E1TeAWKOL0+0nm/iolpj/zn7YiTlWyI6NPr1k4Uhdhws885zL0btHNqm/pmL2jWy98dCxYv7OkHqSfMIyIELCjV2KGytOohpPv4OnYSq1jJ6T4qn+Qxl+XECGsOabusOtny/Chtr0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PqKC6NqbbrD7p4mWqjamWlTN4ENYT55NVIvW5J1WopEy8yf45e6/BP97kez4?=
 =?us-ascii?Q?GJKhtkCYXxZjJuEzhnOmJXd5/RbqGC+kwPzoGIFYHZATwKrIf9TkxWNI10qC?=
 =?us-ascii?Q?X6AS8zPVrwCPQIMwBltHgXng3INc5+NxxnyNLrqbPi093T+WD3CQxZRVlk0R?=
 =?us-ascii?Q?RotBtndjEhM3ERHhHxYHzb1OHIhPuBBe3N6/Fa403wjMiMJG9BAwzL478iZZ?=
 =?us-ascii?Q?Bgm9oLdG8bRft5qvt/9raoJrmzaNrGJAakEZQI3iNdUVUmW5NPXSppIpynfK?=
 =?us-ascii?Q?n4LDx3RwCEHpf1vPeXyyJzEIeqku1PW8/XoUaRKHTLN+8HLVJ5JTZQByvDk/?=
 =?us-ascii?Q?mDiqxeDSxA/NYl2c59URXc1qSws6CH6Ox7kbuHosS8fFya5dThEoS3RbuJbC?=
 =?us-ascii?Q?6P/WMQE9Va88webmHgqjAg1w0QybWic9C5vD8OFWdzhoQQI2Niazz/XF0m/a?=
 =?us-ascii?Q?RVMzUlx+I51SLlS0SLtHiEin/LpkYMne01jk0RIVIDudt60raapnY6KfOguV?=
 =?us-ascii?Q?gXqemojadsYL1ae8OFABLWS3k/cOI9Eow+2UO30KghfUrCMocrHlCc3P0j7T?=
 =?us-ascii?Q?4JMErejz9mLYQUSeA80XJu+Du9Do/J3aqAY/6k5qRuMD2IyNl/1+9l7SK0G0?=
 =?us-ascii?Q?TAvFVM9R4jlbGTVHgao79HexXDayknYNd0ju/HbAW6lo2PD6t4m/5uK1isIV?=
 =?us-ascii?Q?zS5AEi034LEpO0+xI7TjFr0TpYMyHXOR+hd8AuNVzxqT5eBetnPC+HS5rm4b?=
 =?us-ascii?Q?RpKe8ti7R/w9SQPrimXgih+CE71iRQ6NIV0NUUoWRtnUm+aMWjjob2hFyoey?=
 =?us-ascii?Q?ixEVv2a2hKRhA7svwXF2WldAtyESl13QSEUvvlJL1JE41d0w9jBi6EOIT/f1?=
 =?us-ascii?Q?0clo0cE9dQdm9NLSsMaES+zI9mTwcV0ShfIkermyEVcphUeBAEXCpsZWxMzM?=
 =?us-ascii?Q?IYWhWn6GVzBk/Og3nOC+hxDK8Xca3qSwQP+q/eBgXamQLPggBEaTBz4Fj7P9?=
 =?us-ascii?Q?E26CMbsZlzvUzDpOUtsyqBjKdnE+2WzZiT9/Qi00KINgMPxTeqW6U8rlMjmI?=
 =?us-ascii?Q?oaF1vPNheYMSg6+gf86p6hCku+Nf4iXntuTFvV7LvJtzV2lbCfroZGVbxoOn?=
 =?us-ascii?Q?S0RLnj53eV9xHHBw7VJbb8O7ZzxZts2yAHNj8xxdJQ5vF3Zc0/NPdOSpsYV8?=
 =?us-ascii?Q?1QyKPtHdxatkr43+f1wdIgCAiEAsozNOXzd1ZeYZlKU4S77E5EHslpHHP4vw?=
 =?us-ascii?Q?LDtC/jQ6kOBY1uMdtB58Z9tBrppEF7LDhsHGWG3QZyEg6opkv2SutcD5rXEe?=
 =?us-ascii?Q?xb8jdeb3k+dtEa4XxQ3Inz2UoDUl9TGJEjPWpO9QL9CjuGMgoYHf7RaORZAF?=
 =?us-ascii?Q?Wf/+LxwrnEY4fx/dmOm4zaeY9vFObrkmrv1hfozckRETg+jGv6CrRmquKnRZ?=
 =?us-ascii?Q?xIE2v5FkAJ8lCuDSUi2eOdrZyLWqOOR4A9DYJdjkln3CG7XaVtmYpFdpgkfL?=
 =?us-ascii?Q?pe9XqBPpWkkbiV0p1Msgoc8fkzSpNSaq2y0OB2n27l4e4BjdXRUhVpH1aXty?=
 =?us-ascii?Q?R869gXE5hHq9mmjChVlooCLR8aoaeDcRs8KjZNE4vhk+CRdZP8no7OCh8l+i?=
 =?us-ascii?Q?136gYOgzCK0HG2gTxAoltFEvE1hMobFhBbpcVbdwnlHZm12yVERCihJHRgLt?=
 =?us-ascii?Q?JQBqZLSIQCzTDbDr9IyLiMNi2KEemZNGxtA6XPCozB0a09/zAubBT1XEw+37?=
 =?us-ascii?Q?A44PuenxYmYMBH7HQSPvOZ3PbvIfWGGOfYuXas3qwcKWzfORce2j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bqhMNE9tv5fYMv8tbfJ6Y/RWKX77Vg8lYToJbCHACe3q1jwP+cvosoHIOsrmCdX5IfTSV8AlN1GbsC9WXMCq5EJqS2XyqDmLX9hX4lRDN60KhikDm/WjQJ9hF27qzWY9TOjchBOW1EuRLroOrUrREbjo/NIa8dW5n0p6yjiBrbkNGaqA77NbBNOECBo/wZiyQ88g8XNlfzxQepKpcCARCnCmu9ikeEeI8Hr7r9zjpRU8SVvtJw//poj0Coe2DYPgmtYvlVC7sqxqJ+7FPucO2QykwHskpHsOWtitAiWqlXoJs4QTXzXVtuHEC9r0RZ5uvnoU+crp90f/5vSioPFRqg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943c4589-3496-4816-6c55-08deeeca51d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 06:09:45.6791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkfjPP7ZvqdikpZFQB3H+Ib+1rQTk4nmVDDFk4aeOj+C4/qJ4phptVrDqxk+U0S6mouWGOx/OgxPBZ6SBcK4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD2F4A0090
X-Outbound-Client-TLS: ANONYMOUS; rcdn-opgw-4.cisco.com [72.163.7.165]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Friday, July 31, 2026 1:58 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; John Daley
> (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>; Bruce Richardson <bruce.richardson@intel.com>;
> Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Subject: [PATCH v6 06/24] net/enic: do not use deprecated rte_atomic64
>=20
> The rte_atomic64 datatype and functions are deprecated.
> This driver was only using it for error statistics where atomic
> is not necessary. The DPDK PMD model is that statistics do
> not have to be exact in face of contention.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/enic/enic.h               |  6 +++---
>  drivers/net/enic/enic_compat.h        |  1 -
>  drivers/net/enic/enic_main.c          | 17 +++++++----------
>  drivers/net/enic/enic_rxtx.c          | 14 ++++++--------
>  drivers/net/enic/enic_rxtx_vec_avx2.c |  4 ++--
>  5 files changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
> index 87f6b35fcd..0a8d4a29ca 100644
> --- a/drivers/net/enic/enic.h
> +++ b/drivers/net/enic/enic.h
> @@ -59,9 +59,9 @@
>  #define ENICPMD_RXQ_INTR_OFFSET 1
>=20
>  struct enic_soft_stats {
> -	rte_atomic64_t rx_nombuf;
> -	rte_atomic64_t rx_packet_errors;
> -	rte_atomic64_t tx_oversized;
> +	uint64_t rx_nombuf;
> +	uint64_t rx_packet_errors;
> +	uint64_t tx_oversized;
>  };
>=20
>  struct enic_memzone_entry {
> diff --git a/drivers/net/enic/enic_compat.h b/drivers/net/enic/enic_compa=
t.h
> index 7cff6831b9..3ce4299e81 100644
> --- a/drivers/net/enic/enic_compat.h
> +++ b/drivers/net/enic/enic_compat.h
> @@ -9,7 +9,6 @@
>  #include <stdio.h>
>  #include <unistd.h>
>=20
> -#include <rte_atomic.h>
>  #include <rte_malloc.h>
>  #include <rte_log.h>
>  #include <rte_io.h>
> diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
> index 2696fa77d4..fb9a5754c9 100644
> --- a/drivers/net/enic/enic_main.c
> +++ b/drivers/net/enic/enic_main.c
> @@ -83,17 +83,15 @@ static void enic_log_q_error(struct enic *enic)
>  static void enic_clear_soft_stats(struct enic *enic)
>  {
>  	struct enic_soft_stats *soft_stats =3D &enic->soft_stats;
> -	rte_atomic64_clear(&soft_stats->rx_nombuf);
> -	rte_atomic64_clear(&soft_stats->rx_packet_errors);
> -	rte_atomic64_clear(&soft_stats->tx_oversized);
> +
> +	memset(soft_stats, 0, sizeof(*soft_stats));
>  }
>=20
>  static void enic_init_soft_stats(struct enic *enic)
>  {
>  	struct enic_soft_stats *soft_stats =3D &enic->soft_stats;
> -	rte_atomic64_init(&soft_stats->rx_nombuf);
> -	rte_atomic64_init(&soft_stats->rx_packet_errors);
> -	rte_atomic64_init(&soft_stats->tx_oversized);
> +
> +	memset(soft_stats, 0, sizeof(*soft_stats));
>  	enic_clear_soft_stats(enic);
>  }
>=20
> @@ -132,7 +130,7 @@ int enic_dev_stats_get(struct enic *enic, struct
> rte_eth_stats *r_stats,
>  	 * counted in ibytes even though truncated packets are dropped
>  	 * which can make ibytes be slightly higher than it should be.
>  	 */
> -	rx_packet_errors =3D rte_atomic64_read(&soft_stats->rx_packet_errors);
> +	rx_packet_errors =3D soft_stats->rx_packet_errors;
>  	rx_truncated =3D rx_packet_errors - stats->rx.rx_errors;
>=20
>  	r_stats->ipackets =3D stats->rx.rx_frames_ok - rx_truncated;
> @@ -142,12 +140,11 @@ int enic_dev_stats_get(struct enic *enic, struct
> rte_eth_stats *r_stats,
>  	r_stats->obytes =3D stats->tx.tx_bytes_ok;
>=20
>  	r_stats->ierrors =3D stats->rx.rx_errors + stats->rx.rx_drop;
> -	r_stats->oerrors =3D stats->tx.tx_errors
> -			   + rte_atomic64_read(&soft_stats->tx_oversized);
> +	r_stats->oerrors =3D stats->tx.tx_errors + soft_stats->tx_oversized;
>=20
>  	r_stats->imissed =3D stats->rx.rx_no_bufs + rx_truncated;
>=20
> -	r_stats->rx_nombuf =3D rte_atomic64_read(&soft_stats->rx_nombuf);
> +	r_stats->rx_nombuf =3D soft_stats->rx_nombuf;
>  	return 0;
>  }
>=20
> diff --git a/drivers/net/enic/enic_rxtx.c b/drivers/net/enic/enic_rxtx.c
> index 549a153332..c87d947b93 100644
> --- a/drivers/net/enic/enic_rxtx.c
> +++ b/drivers/net/enic/enic_rxtx.c
> @@ -112,7 +112,7 @@ enic_recv_pkts_common(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  		/* allocate a new mbuf */
>  		nmb =3D rte_mbuf_raw_alloc(rq->mp);
>  		if (nmb =3D=3D NULL) {
> -			rte_atomic64_inc(&enic->soft_stats.rx_nombuf);
> +			++enic->soft_stats.rx_nombuf;
>  			break;
>  		}
>=20
> @@ -185,7 +185,7 @@ enic_recv_pkts_common(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  		}
>  		if (unlikely(packet_error)) {
>  			rte_pktmbuf_free(first_seg);
> -			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
> +			++enic->soft_stats.rx_packet_errors;
>  			continue;
>  		}
>=20
> @@ -303,7 +303,7 @@ enic_noscatter_recv_pkts(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  		if (unlikely(cqd->bytes_written_flags &
>  			     CQ_ENET_RQ_DESC_FLAGS_TRUNCATED)) {
>  			rte_pktmbuf_free(*rxmb++);
> -			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
> +			++enic->soft_stats.rx_packet_errors;
>  			cqd++;
>  			continue;
>  		}
> @@ -505,14 +505,12 @@ uint16_t enic_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  	uint8_t offload_mode;
>  	uint16_t header_len;
>  	uint64_t tso;
> -	rte_atomic64_t *tx_oversized;
>=20
>  	enic_cleanup_wq(enic, wq);
>  	wq_desc_avail =3D vnic_wq_desc_avail(wq);
>  	head_idx =3D wq->head_idx;
>  	desc_count =3D wq->ring.desc_count;
>  	ol_flags_mask =3D RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_IP_CKSUM
> | RTE_MBUF_F_TX_L4_MASK;
> -	tx_oversized =3D &enic->soft_stats.tx_oversized;
>=20
>  	nb_pkts =3D RTE_MIN(nb_pkts, ENIC_TX_XMIT_MAX);
>=20
> @@ -527,7 +525,7 @@ uint16_t enic_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  		/* drop packet if it's too big to send */
>  		if (unlikely(!tso && pkt_len > ENIC_TX_MAX_PKT_SIZE)) {
>  			rte_pktmbuf_free(tx_pkt);
> -			rte_atomic64_inc(tx_oversized);
> +			++enic->soft_stats.tx_oversized;
>  			continue;
>  		}
>=20
> @@ -558,7 +556,7 @@ uint16_t enic_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  			if (unlikely(header_len =3D=3D 0 || ((tx_pkt->tso_segsz +
>  			    header_len) > ENIC_TX_MAX_PKT_SIZE))) {
>  				rte_pktmbuf_free(tx_pkt);
> -				rte_atomic64_inc(tx_oversized);
> +				++enic->soft_stats.tx_oversized;
>  				continue;
>  			}
>=20
> @@ -681,7 +679,7 @@ static void enqueue_simple_pkts(struct rte_mbuf
> **pkts,
>  		 */
>  		if (unlikely(p->pkt_len > ENIC_TX_MAX_PKT_SIZE)) {
>  			desc->length =3D ENIC_TX_MAX_PKT_SIZE;
> -			rte_atomic64_inc(&enic->soft_stats.tx_oversized);
> +			++enic->soft_stats.tx_oversized;
>  		}
>  		desc++;
>  	}
> diff --git a/drivers/net/enic/enic_rxtx_vec_avx2.c
> b/drivers/net/enic/enic_rxtx_vec_avx2.c
> index 600efff270..53589ab788 100644
> --- a/drivers/net/enic/enic_rxtx_vec_avx2.c
> +++ b/drivers/net/enic/enic_rxtx_vec_avx2.c
> @@ -81,7 +81,7 @@ enic_noscatter_vec_recv_pkts(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  		if (unlikely(cqd->bytes_written_flags &
>  			     CQ_ENET_RQ_DESC_FLAGS_TRUNCATED)) {
>  			rte_pktmbuf_free(*rxmb++);
> -			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
> +			++enic->soft_stats.rx_packet_errors;
>  		} else {
>  			*rx++ =3D rx_one(cqd, *rxmb++, enic);
>  		}
> @@ -761,7 +761,7 @@ enic_noscatter_vec_recv_pkts(void *rx_queue, struct
> rte_mbuf **rx_pkts,
>  		if (unlikely(cqd->bytes_written_flags &
>  			     CQ_ENET_RQ_DESC_FLAGS_TRUNCATED)) {
>  			rte_pktmbuf_free(*rxmb++);
> -			rte_atomic64_inc(&enic->soft_stats.rx_packet_errors);
> +			++enic->soft_stats.rx_packet_errors;
>  		} else {
>  			*rx++ =3D rx_one(cqd, *rxmb++, enic);
>  		}
> --
> 2.53.0

Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

Thanks.
-Hyong

