Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D28C5DF82
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 09:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B74040150;
	Thu, 20 Aug 2026 11:05:51 +0200 (CEST)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mails.dpdk.org (Postfix) with ESMTP id 44C9D400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 11:05:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1592; q=dns/txt;
 s=iport01; t=1787216749; x=1788426349;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nqEDGhyq4AYE3jJs8PcSJSAYPQBgsaGi3fmt2IpWCrc=;
 b=KOq5uJD6nKXiGRuaVu3plHdGHWLb6/m3VNDowedq7Ln4bR6JGnM9xvOa
 hiaW4g1XILxA1FZvh90GKSoJbmDTP0p7THlndo6E7o1QcYbMty2YPsPtC
 FJi+D5f2Sp5mkDxXtQwVDsgE+k1gbgm70t1vwQg1JAyBN71irA7darVhQ
 yUbL/kaKHQe1fDwXH/7VrZszcaEsQgnvPj1hO/R+BIXMjjkg5rv4J3+6D
 qaS5eQM/DGcQ5ZQQbMLu+M3GSY9vZCHPSxMRpuB1tIMrVe/mHNYGkjKmN
 bvR4Q1Imk+0Mf2MLzI/n6kLcIDPG1poqpQdU8n467la7cJEmgu+xMb2Ns w==;
X-CSE-ConnectionGUID: 8ugy6UFjQaej+g4cRwtzAw==
X-CSE-MsgGUID: flPGdrcLSgy3mkEAu3rNaQ==
X-IPAS-Result: =?us-ascii?q?A0DRBAAewoZq/5AQJK1aHgEBCxIMZYEgC4FuU4IrSYgjA?=
 =?us-ascii?q?4UriHygGQ8BAQENAlEEAQGFBQKNawImNwYOAQIEAwIDAQEBAQEBAQEBAQELA?=
 =?us-ascii?q?QEFAQEBAgEHBYEOE4ZchloBAQEBAycTPwwEAgEIEQQBAR8QMR0IAgQBDQUIh?=
 =?us-ascii?q?W8DAQK4IQKKHHiBATOBAeA5FAGBOIU/gx4BAYQ8gSMZhHwnG4FJRIFXgmk+h?=
 =?us-ascii?q?EWEE4IwBIIigQyTSlJ4HANZLAFVExcLBwWBIxAzAyovLSNLBS0dcAwnEg8dF?=
 =?us-ascii?q?xceWBsGBRIgKkFEIwM+OIEIQQKBdT8jGTZ8gQlegSsqYQECEBdGLhWCCgKCc?=
 =?us-ascii?q?IEoXgIBSUUOCRcLbT03Bg4ZAwSBNQWORyCCS4EOgUTIGQqEHqIRF6psLphaI?=
 =?us-ascii?q?6h1AgQCBAUCEAEBBoF+JoFZcBWDIlMZD948eT0BAQcCBw4DC4FokX4BAQ?=
IronPort-PHdr: A9a23:0puVUxZarO373mfvtyjylwf/LTAchN3EVzX9orIuj7ZIN6O78IunZ
 QrU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+WXU=
IronPort-Data: A9a23:DSkGe6+wtCCZXCp8VEcWDrUDxX+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 WpJDGHQPP7YNDCgLtAlat6y8hsPucLdnIdkGwM5qiFEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mvyyHjEAX9gWAsYjtFs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2lmIIIJpNtZA1hH+
 P5bJ2wGVA+flcuplefTpulE3qzPLeHiOIcZ/3UlxjbDALN+HtbIQr7B4plT2zJYasJmRKmFI
 ZFHL2MxKk2cP3WjOX9PYH46tOe5gX/8cjhwo1OOrq1x6G/WpOB0+Oi0YYOLJI3aHq25mG6Wo
 lrp837yJioVJYeayhes7ym2oOb2yHaTtIU6UefQGuRRqFGe2EQfEBEVE1yhrpGEZlWWUtZbL
 QkQvyEpt6V3rBPtRdjmVBr+q3mB1vIBZ+dt/yQBwFjl4oLf4h2SAS4PSTspVTDsnJZeqeACv
 rNRo+7UOA==
IronPort-HdrOrdr: A9a23:BrKmrqmkF9SHFsFWcyIIvuvhU4vpDfMjiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOCUghrYEGgE1/qs/9SAIVyzygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadv/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOlA1G8L4i5ngkpXgbRQaBxghxjWvoFqTgoLSIlyz5DtbdylA74sD3A
 H+/jDR1+GOovu7whjT2yvp6YhKmNzu891HBMadoMkYIDfhh2+TFcVcsru50wwdkaWK0hIHgd
 PMqxAvM4BY8HXKZFy4phPrxk3JzCsuw2WK8y7avVLT5ejCAB4qActIgoxUNjHD7VA7gd162K
 VXm0qEqptsCw/aliiV3amLa/gqrDvwnZMRq59Vs5Vta/pZVFaXl/1HwKphKuZFIMs90vF+LA
 AhNrCG2B8cSyLrU5mQhBgd/DXrZAVyIj62Bm4fp8eSzz9a2Fp9z0ce2Ygju01ozuNmd3GBjN
 60bpiBU9p1P5IrRLM4C+EbTcStDGvRBRrKLWKJOFziULoKInTXtvfMkf4IDcyRCdU1JaEJ6d
 z8eUIdsXR3d1PlCMWI0pEO+hfRQH+lVTCozs1F/ZB2trD1WbKuaES4OR0Tutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIM2wHlQZFdJXQXTcVQsNcmXFCFpN7NN+TRx6bmWeeWIKCoHScvW2v5DH
 dGVD/vJN9Y5kTuQXP8iAi5YQKaRqU+x+MGLEH3xZlm9GFWDPw/juE8syXN2v22
X-Talos-CUID: 9a23:qWMAd2Ebq9DazdjOqmI36UEFRP0LcETUwXWTLBOzM3l1WpSKHAo=
X-Talos-MUID: 9a23:FmWcTwadPW8Pt+BTuTvUqz14P+NT7LX1DUMguIhdoe+NDHkl
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-07.cisco.com ([173.36.16.144])
 by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Aug 2026 09:05:48 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-07.cisco.com (Postfix) with ESMTPS id CE870180001DE
 for <dev@dpdk.org>; Thu, 20 Aug 2026 09:05:47 +0000 (GMT)
X-CSE-ConnectionGUID: euUX5nLZQFSg7Ek/Tbkhdw==
X-CSE-MsgGUID: Frc25ASeS/+J/q6c1QCP2A==
Authentication-Results: alln-opgw-1.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,232,1779148800"; d="scan'208";a="83968430"
Received: from mail-eastus2azon11011047.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.47])
 by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Aug 2026 09:05:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzj14Y+O25s9RbJkYZBTm2vlz7sBFhqFG24Hcp87lxq6zvtI7fR5OnpuOxq4hD9vVLYiGde4JWIMF0rK67JbpU5kRI48n9/rpUuHSFgHJQ22yoWG8Q469dcFklp0ztrzzoupqZEWyjCi6D/1otfWqq0SHgwfu/Keq8hYyGV+bYKoO0OawtmTvxEMCO7jxb0WnlrOV830nZljXXFb/FCJNTi6ziQIYwn4PCo7Qh76LvbPQ7SrL7EbdaJdilSXfaOHTyxrg+5Kda9U53MrxgLIekxlmCxz9ZAJglpkr/4Ca06ko+ZI5Z4MGOhWj48p5UajGopz9NOULodbTy0ni4w+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqEDGhyq4AYE3jJs8PcSJSAYPQBgsaGi3fmt2IpWCrc=;
 b=CS9xgmwpo5SF1btVzCtife9QRy0C5f+7kNOO3uRrbq0yyqKkWBT6ZquvqUR2aDkfCi7Auzaof2thoausOZLhi7tUKQx20XMyEXTmoyXjpobpr5+BxAJbFotPOZFwUXj3k4GMvKMu/xhQn19w4/dzo2Nf01/RZYoIEr/wQIxUTpBrrJ28o3chOXPqqv0qaPS6PKjtzh3tV8XON5yT8JN42zmKJnuae52b45P1x3sfjM+ZNsZw1/+F88knCHLN5Ov9rVnK3LzB7+u2jblJyeM+sX8aCLmp9k55O4sabYpm/oDzv+E8uuu9QgBu8upNCqOBG2FIna+FwuWUjpqSn4byEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by DM4PR11MB5230.namprd11.prod.outlook.com (2603:10b6:5:39a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 09:05:45 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%6]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 09:05:45 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "John Daley (johndale)" <johndale@cisco.com>
Subject: RE: [PATCH 26/61] net/enic: replace use of rte_memcpy
Thread-Topic: [PATCH 26/61] net/enic: replace use of rte_memcpy
Thread-Index: AQHdMGQ4xYM2FSY+60ifNGMumQD8KLampSRw
Date: Thu, 20 Aug 2026 09:05:45 +0000
Message-ID: <IA3PR11MB898770D64F7586E9834217A1BFA42@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260820052251.1453273-27-stephen@networkplumber.org>
In-Reply-To: <20260820052251.1453273-27-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|DM4PR11MB5230:EE_
x-ms-office365-filtering-correlation-id: 152f2a4e-bfbb-45dd-b4b9-08defe9a3832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 25iQdlY7jgxC6PKYUvSwKsQnphwxP/e9DoAsqF2Sxm6qCB2FdovTgolTTYKwc/LtDhs/G4OC5Ufn7ylPqzEPzubIdNaF1TLOufgZQkHbcCNOUoHnUJfj6LwMZcfiCwNXdW9dxTt81wU+8lLrK5IrYzIyZBho8ZY6fONfcetnLbhnXtXLlStbjWksXZOJFFLCwFu7OpJU8gm78Z2f3tPW2wU0977PLaBHeWNN9/U+eyYFlwhPd1J8u8XT9GC1qi6z0bf6ebDxab6x0fKOopHs4MvFj1pa89RoTxTojmVRxfh4onMRt2mFQx4HOFlSvjO+gM4QinDgatt7adcD53WVqVaM81DE6gzyEMD7/7h4NVRvsfUJ8d5x9s5w1jWGbIv12LTZS7Yn03Ge8BexrB+1R3MtofnB8FDmL4j1vWIyrgIuCGPpBunBpOy3SlF3+1PXsBIC5lukx3VJavhWTZ1FO/vjmiy5y/ej/bpjF77zQo355vwBOPne6trOJM/fAKXc/oQa+XtBVr3Fhciv0FsbM+8hAEtJ4kgaD/2A5dmAJLInN96zqDf18LBheHYKIUG1bbJK7ej4nmuXam95SaWExbwCwIdTdDJB1yuRHWNorriMx610lye6SYNBw1LJyQ3J7WzB4fMypixeof0ByTDP9+7Vh6SPMNWuIGXyS+Wz52o20LeL2oU33W6npiHOOo19VP6ZPEhZZaELWDiNWtac3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hnZZEZi6jyxNqTp1vesfav8r25gQKyzZB2AYWpkhdAaaXPejGUSKz3WSEyf7?=
 =?us-ascii?Q?oCgNCvaWD9Lsb3k0MUYCukZ4Yoo3v6iawV8YRNK4pDtj4jlILbOwmLB/bWcn?=
 =?us-ascii?Q?Epdl+Jlr9NqIg8K9DI53SaBhOj4/zGd6oJA8Im/seUFJXaNpoxgpI2Itw5G2?=
 =?us-ascii?Q?BFH9KnMJ3gEmwySDbmrfyCEtbtZupsTGtD6HeBpywHnVLDmdPU/yMiH5qHn3?=
 =?us-ascii?Q?uHIOR2PXwBYTcfsP+zmg77UTaS6a6mgEcpnJIfOHThRxnViO67JyBQUixRHS?=
 =?us-ascii?Q?xnZh485byBYgGuL4nCqQ8QjCpo6blMw5cHdzoYkILRy5a7ZNjSQyULxXZhCV?=
 =?us-ascii?Q?1CR7N9Rebiv9NDPaWzWMLtReEPZ6C8Ak0tvx2fsfQEkfF6Kfl8JelIWGJdDL?=
 =?us-ascii?Q?mO37VTXs5E3FHc6ewRyUIu699yn5mPwqnWJp2wvE89LhJ0KTbRK8t5IpldZG?=
 =?us-ascii?Q?HxztvJ0+r7MAgbIbtRD7RUXr300TL24/yACkpZcfzlHn26U6yc5EfG3hD1r+?=
 =?us-ascii?Q?NcKlqAWUSkEdINoj3wNqViGjxW1bCYcQWIDgvfaUiuGmONruyVtLLXwKUv0T?=
 =?us-ascii?Q?nOgSwkTmef1p27nrI8uwLcu0sg5lv5YOgBCu/PYTYa2yzH8BTq7UyLZEiBLs?=
 =?us-ascii?Q?HeifMlC0psG7gRvE+0qe02WGMDIUS2qUagV+/HfrL/h2HtOupWiXMnXrGzGl?=
 =?us-ascii?Q?GNUrsp7vi8yptHb623uQSZhxtRtZwcXXmN2Lwh/UFcnNJ0eE7RNMbfgfX9qi?=
 =?us-ascii?Q?90shfYVfNOFULpb25u99TMo6NqGXAWCHVLoZ4hIKA6PWSWJTBCWV6YMH9lQ6?=
 =?us-ascii?Q?0klMlFMjmoo71Bl7fGukOcafE0JGox80RKFKrf2kH1JNoVVhdXCeh1V13viW?=
 =?us-ascii?Q?MgxWnw5qwve2NP7wZKS7+DjF5smqlc23dZaj9FNg4WCuIS+Wk7WSwDyhhVGO?=
 =?us-ascii?Q?Zaj4rb5Q7gswkHjjJJt/6gdrsORGudNLllcSZfDbYd1Kx6EFlXPxBYHjMp3g?=
 =?us-ascii?Q?z4M8NLwdBAU1xk6nw7Es5ZXWKV0tktTKasYPx7A+6QzJP4r1pCecGvcH2qch?=
 =?us-ascii?Q?anQOjexskVpPx/r2gpk9pkYpyvlY0buifJof+FEoF0Qvz0Wkdluey/op2buo?=
 =?us-ascii?Q?MF66Wt4ceb/YNdCd/WrH49zdQTm+OQa2NH+QXn7tpCmWmsIlI+VvGuJCu77Z?=
 =?us-ascii?Q?av1H2NPt+8vWMBZLBkB62drJh81Kknq36U5L+oTmuQ3gr1jxrbpE1nRq2+EI?=
 =?us-ascii?Q?C4Yv+NTIRIbotRJA87CG8QNCLv10TXMKlY+9I2/kUJX3y12SPcvduDcDBbUH?=
 =?us-ascii?Q?e5fe51+xY+r5Wl37sAOqGAU7/UAZMzTpjR9H8TWgWjJby6EmTmZ+sOwzEvcy?=
 =?us-ascii?Q?RHvBIFI5SLDKhZuO0rTKw0KEOp6MwVsboRNJjQmURSIS+0Hv/mKMVfJ+EbhE?=
 =?us-ascii?Q?yg2PCs2ZF6+6UqaPa4BEOVf+nwu+IByzksCiNlKCnJmwPVBkDU0OJSweUu2y?=
 =?us-ascii?Q?h8esa+Sso4FNXEuMZ3dvN6XZihfxmszSUWISu/5CY6SKTMIejX6Lf57yhXEV?=
 =?us-ascii?Q?0QlTTEHzUetvMNr9el5ao6GF/7/XrurIycx+fHwsmon8i/KjX0l3G4qI7Wq1?=
 =?us-ascii?Q?uPC3xV5Xk0PXmabMwJ2mPb3pt3TIrR1okVodUm8ZstZ7nnEoLYKOBLWQmI/e?=
 =?us-ascii?Q?uRZ8h4Ubh4M3lYyH8ttEawtQolfHqsUZORtfuUl8KLaPDkYW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rc2iAvjG4yyQL/XWH7xnjCuOmUQxxOVOh258EB+sDFVR0hS5odV15h3+Bg4q1s0kFZ30Zh6HxGwjVKEdbccyKd2SF1cChmg5gu3gwTk3VYSLIQczQosDSysErRGZU0siUROzFUDsuKnAd6GQ+d322HNtYOLuntlIpCRTl/oWdA8LCDg8wRIQCPtCY5cQliyqb9l63yV/vuI64zDKvyNuQZPHHzWGcmgpn6eIg1tZvAlPq1dDjsX++AE3f6vA/4Qv78CsK9q7+SWSNkSpUT/ydSMQqNHtlfUqbK9zB7V8Rm7xoLbYL0BcPbT2UBvFP8/fulEnSBB9XZcB2U2teg5Miw==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152f2a4e-bfbb-45dd-b4b9-08defe9a3832
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 09:05:45.4051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tSV+chPt3IxPiXiG7O7JWhj9eTeOvYw3WWwnEcK4qzUL/t88AEchaZAEpI3YWcUyYhRRoYPEq5xwIxPmZJStw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5230
X-Outbound-Client-TLS: ANONYMOUS; alln-opgw-1.cisco.com [173.37.147.229];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-07.cisco.com
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
> Sent: Thursday, August 20, 2026 2:12 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; John Daley
> (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>
> Subject: [PATCH 26/61] net/enic: replace use of rte_memcpy
>=20
> Don't need rte_memcpy for fixed size value.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/enic/enic_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
> index 2696fa77d4..59a557a38e 100644
> --- a/drivers/net/enic/enic_main.c
> +++ b/drivers/net/enic/enic_main.c
> @@ -1215,8 +1215,8 @@ static int enic_set_rsskey(struct enic *enic, uint8=
_t
> *user_key)
>=20
>  	/* Save for later queries */
>  	if (!err) {
> -		rte_memcpy(&enic->rss_key, rss_key_buf_va,
> -			   sizeof(union vnic_rss_key));
> +		memcpy(&enic->rss_key, rss_key_buf_va,
> +		       sizeof(union vnic_rss_key));
>  	}
>  	enic_free_consistent(enic, sizeof(union vnic_rss_key),
>  		rss_key_buf_va, rss_key_buf_pa);
> @@ -1248,7 +1248,7 @@ int enic_set_rss_reta(struct enic *enic, union
> vnic_rss_cpu *rss_cpu)
>=20
>  	/* Save for later queries */
>  	if (!err)
> -		rte_memcpy(&enic->rss_cpu, rss_cpu, sizeof(union
> vnic_rss_cpu));
> +		memcpy(&enic->rss_cpu, rss_cpu, sizeof(union vnic_rss_cpu));
>  	return err;
>  }
>=20
> --
> 2.53.0

Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

Thanks.
-Hyong

