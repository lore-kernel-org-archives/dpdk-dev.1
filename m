Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F4C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 19:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64EFE40661;
	Wed,  2 Jul 2025 21:31:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id B18224064C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 21:31:07 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BWjxq018597;
 Wed, 2 Jul 2025 19:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aeYXfBMRJtmKqImqy46qkmd7
 +DRN7wmvR1Ba4UVWjKw=; b=oL+JZJdTuA1LDW/le1R1dcCu7amhlckYVkkxWEh+
 V9ICEeM8HnbhU6EqbtZbuqAjWugghfPVTZSK4yK/RKIEcc7GI5bWSNZiCVXzf5TW
 2KaJoYAUBvcL/WE5JZi1+JSsPEoJlK/kCLmdyJ5mZalL8Rt6QoFZw+cJOJemBwxX
 e8xPLm7S0pktpMITchn83Gy2+Meen5aRc7Nsh8eay984kQxwkaP4DWXGndENTG4i
 c5n0QOEHIIvJu5EoEyUqJfjqKdK+BrwayujCtgmJqeVuQShmGmdbeKyEUIV9piw0
 T4IP5hreK3eUSX3EZ16sxKBzhthf6b2hOi/BPnl37r7czA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxnwxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Jul 2025 19:30:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqA8w+K6BFpLSuRNJN6YDmIT6sU0qd9jIoH48eC5X5Usvn7BhZfMCetZTwn7EjtoebYjx0fB3kF7P+tdWzt/jVTjrJneG3AwMA7dQRVc/ICRWv3KF/7uiZDuo/3vwkPxkTBL7DhJJrza8nVqD1XtVGWfzDc+eUSUdLfnlq8Z6xx1GRdTnZhcl721Vjg1pNz/Cqp1KPccZMsuA9p4OSnzTxYkWXy8lepxgNgLkmwJzKe5B1UzuZgH/px7nH4X+tz16yCufBXp5t9/69+7wzcdbd5hkfvB+wAyyazWPUtbqml0JlouLyQrr5VtK3DU7zF2Xk7OFWeOeHo6u1WtRMRM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeYXfBMRJtmKqImqy46qkmd7+DRN7wmvR1Ba4UVWjKw=;
 b=BOFrolo1C8PKAazYTrJvvchhEfIR5oy2vOG0lKm8Ny9941TlXq+Ol+7PkOeQFSDutcyLcbO62vtMUL78ADX7FTT1tzbHsHWvAETIbxdawUVVJSS7UhkeRqyPszkIB0FmNDkSmUGFDGqE/HAJEFR99vni5s5pRnh9W9+I3u7wM37oWLZbrnkrydyD+9CnVreSx71iGAlzuBYO8OKKbA5HPRY82uQo17Xc2nDgAi7wdRV28uqX7h9pI40UHBHvG0UwtWlJxAdyXtP6qKdikGohHZ/Y7cGF7U9P2xG3ITC7vSR3DAmc4itsJfLOkBmkf08EvIN8LTCHtC/v4ZnQbMRqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 (2603:10b6:208:509::11) by DS0PR02MB10291.namprd02.prod.outlook.com
 (2603:10b6:8:1bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 19:30:50 +0000
Received: from IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5]) by IA3PR02MB10771.namprd02.prod.outlook.com
 ([fe80::5100:fab6:aac9:83f5%3]) with mapi id 15.20.8880.026; Wed, 2 Jul 2025
 19:30:50 +0000
From: Dylan Schneider <schneide@qti.qualcomm.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Jerin Jacob
 <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Thread-Topic: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Thread-Index: AQHb2YQ73VfknzRgqUKIslHGkPlGlLQXYbIAgAAB7lSABHUkSYAACqwAgAN39S0=
Date: Wed, 2 Jul 2025 19:30:50 +0000
Message-ID: <IA3PR02MB10771C80F1E35014C06F8C9A9E940A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
 <IA3PR02MB107711F11A8681D42D5B911B4E946A@IA3PR02MB10771.namprd02.prod.outlook.com>
 <4485771.rnzLaay6km@thomas>
In-Reply-To: <4485771.rnzLaay6km@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR02MB10771:EE_|DS0PR02MB10291:EE_
x-ms-office365-filtering-correlation-id: c3052b63-9932-4eee-a7fd-08ddb99ef3d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?16agkUL407RwvWTQyI3P3wZOI9ZrOBGbWd/++PbGuKABueADoVwUppW20D?=
 =?iso-8859-1?Q?3VHiwzi7CRwTYZ5Rj/2hmZBHdWPhrQAcGN7u0S4+yZPiWNiE/4niUpkkAb?=
 =?iso-8859-1?Q?CelAQlzzYRkG9TxaZ1xVi5OZyrLh8WyjB9Ph89Yc4xYVLySpus3JJ9yWYa?=
 =?iso-8859-1?Q?kV67UYo4vTJdN0BWAHiE5dTihhuYF7sUpWUng2RfOjn19OHCJIqPfe6gD2?=
 =?iso-8859-1?Q?jMxoGPktFdQ6bpfe2gUtOFXPV8k/TjO5NyEI3mRKYmPLGWe8ZM5FAQRiWX?=
 =?iso-8859-1?Q?yp4/aud3yjmSuOXBNhmdaNlvo0Ro7eGCUaWmFbEng33mYI5q38234r/ujn?=
 =?iso-8859-1?Q?dy8UriaOcOdX+PwnzE/sNxrgutWYykfBinRd6FFXhbxZDe8m2bIyxkFTGT?=
 =?iso-8859-1?Q?YXMgKp+9s09TuqwESJRJN/4EuChrhby1pUf1eVAifpR/bFc6mCzmPOqcE7?=
 =?iso-8859-1?Q?uhHAe1JzxDMreSypipi839sqC3ouqAPFspvNjUjS46axbGTwjczS4t3XU0?=
 =?iso-8859-1?Q?hT/pZuV+rh72b668Ixp5N7ERWeUDHDjtIsLBVrfkZp92/KsKF6lGN4B8Xm?=
 =?iso-8859-1?Q?GDBFHk76GC5fluRCrG8RO8tYTMIKHD34CDtrKPr88ltmVkSkRW73vTs9zu?=
 =?iso-8859-1?Q?i8dnJ/3f9eZJH510bkW0uY9QhdkIEG4E5P9WcyItYPg96vWYhehtjL+8kq?=
 =?iso-8859-1?Q?aJL5QkuvjDEg6LQ/9pQaC4wdA3LLI40fXr4fRhBjRbzom1qjv2GSvGP9AZ?=
 =?iso-8859-1?Q?EzwxD2J0eo9U8uouG6mA9HB3MwGXqwdTEvuqy8A1TWWzVaUhkEZTB352Hn?=
 =?iso-8859-1?Q?1W/JVM3MpGRRcQSsAh+uFskduXl7K3fTfa77ZsnTLzdpWoSki4wP0fo1Ul?=
 =?iso-8859-1?Q?eEUQP+HyywqAboCoRBL4Xhy0BMxqdjgX/7OG6EpiE9LuOL5vamdB24F9nB?=
 =?iso-8859-1?Q?9blW8tQoSAGH6UR0593Sp+VG/7eTYPUOqUmOlEOJdMcZFO2yS9y0FIvKsI?=
 =?iso-8859-1?Q?D5W8mSb2i/xf6FfbGl8Uv9h+WI23Qi+HtxBmOE+WNIjcPozP6HCvyE+uGX?=
 =?iso-8859-1?Q?ucfa+G8NNaKhuDSXAOF+F3DPv0qu1DvE6xis0suUvqFuXpYGsYRPh9CNEw?=
 =?iso-8859-1?Q?91s0lVSzF8LDOOeiT0GEuNi1SXE1RifIGkuX8NTyT8eZIYNs6IOgTxFtGf?=
 =?iso-8859-1?Q?7DODQjpjDV2LSNSvIscZfmnsI9/IY5oC7Ea3OS5/aJL5cAYdXfRgY2O78E?=
 =?iso-8859-1?Q?rdnsszOAlxUbpZ60XYgdwzQVmpNZdIZuoHyD/PTxjb2oRTsyUYaYYCl2De?=
 =?iso-8859-1?Q?j1pcTN1ZTrHd00qXdlJS1wnnI6Gavt8ewN5ujoyXfwSyUBe7uXNQR0MKFA?=
 =?iso-8859-1?Q?kMPvDv7bs1bYuIw5bJmy6palQV1u5KYbPLaiA0D/xPd+y9Z2Y9ZRzTpu3v?=
 =?iso-8859-1?Q?5ksTYhO9DZvmM3oZozlhJ2QZGxKUD1yuRBfzrBd2YY48yAnVVyTaAU4quv?=
 =?iso-8859-1?Q?+qqBdvkxvgC3wXqbS/1o6ElRkdVXcbbQfCAWCq5NH5aLrJS0oC0XDC3R49?=
 =?iso-8859-1?Q?UlM/dTo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR02MB10771.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RYnwY3alL8vgIYgfYSoJMEZN7bhBkoAb40RhFMIOrbHTsnChjgIWQi6KtV?=
 =?iso-8859-1?Q?Tq94gCqvWQpce+iPHhivLlq6bdZcDO5p4zfvobgcpJlUEIkE7i+aJ+u+nf?=
 =?iso-8859-1?Q?LCjDaVGJL+CEZyVv915BhJWzKjSq31QPEB5pOLWe/mC8xiIopTCwTguEjp?=
 =?iso-8859-1?Q?HWBcpfNn4XCFlYqcv0fpe2TuPy/FB5SoPmIm29fT2bHY64eHgXVNp4kKct?=
 =?iso-8859-1?Q?C/CPah1HlfGzn5NyOrijUshZwBnAXQMziBFlOdMVMFnYKU3tsPlKuqK9sj?=
 =?iso-8859-1?Q?eq6mRIzbn4WT2PxghL1VEEkaTMWspQTZj/Ss7TLn0lntHzJw5WqZbdVtlU?=
 =?iso-8859-1?Q?hZW+LXho9ackz3Sh1ar1OYvXwL6wT08rNh7W1PBeoTiJxwczRwmtf0d1e3?=
 =?iso-8859-1?Q?Zd6CD9HZpafrHk34Yn1Zc8eG+LwHVyngXOG4yXUZpItuI0TPzf8yZqN+DY?=
 =?iso-8859-1?Q?b9z0QHyQDefecJWApH5uDHUqm8b3PijMGGHjCDsqdwduV6FSDFWq5oW0iK?=
 =?iso-8859-1?Q?kJvNRbGizNccfyFG00MYQMh6DUsvR1KhBbOVmXb+f2a6hXMmDW3nBp6mvZ?=
 =?iso-8859-1?Q?Eqkw+xrWeqRcshz6aahHKgNGRlBAQbP3Ybtq+Yr2XwBAQW3HgqzQFt9O77?=
 =?iso-8859-1?Q?OuAnJq/4O0wTaQIFrIrfQBg+qAqSqRb4Wwnpu4hUuLMSTEsPqMdKXMEbb5?=
 =?iso-8859-1?Q?cNgA2EDMy71kBRYHZj2wihX+8KwpB28Vb3N5W68dZ1mfhzFsIEJfrkvhTL?=
 =?iso-8859-1?Q?jrUrvSEPpRIc0EW8y/2F1LFiw0cd6Di7tv0HPGiZ6jF64L54DmB7pIq57g?=
 =?iso-8859-1?Q?wVoOGC40nuPiYIq1Un8zfafVbdRKB2snVLdtgeaCyHjTUCBDyWfJKGE8JW?=
 =?iso-8859-1?Q?SpGgec1G9uh9zLU5pLooNELTJxzQeT+bEvMoZGe2XB1nxSYyKmUx/dFJQW?=
 =?iso-8859-1?Q?vKWu2gpu307pa+h1OE+WBCyS6R4rL8cenMlPczPXbbgPvnJeJNrFe9qV57?=
 =?iso-8859-1?Q?3oFhOR0rt/ytn8mP2VLzBgdcJwD/bS5BRF6SwlrUJCQCAOkohgig35qmkB?=
 =?iso-8859-1?Q?68/hwRdM/1SX7YRMxLBOanxyglTLiPBSXIypVd7vaaTuy96weCCuSMrclz?=
 =?iso-8859-1?Q?J0iWE2lb3Ji0yDmecD+YQC0rIK/R4PyV0um8AEZCCNAZDeV1CmasahYpf4?=
 =?iso-8859-1?Q?gIh7eDpsWy7Hrsr9nA7RJ9Vjmw2OtNyOstxaJsugjvLmkykPWz2SrNkANZ?=
 =?iso-8859-1?Q?DA30W63mu1Df5hzfMwxQy6BJeINs1BOwvGLmjNqYZkEf88LbWn80+Y07Ex?=
 =?iso-8859-1?Q?AvRvIplUPsruK5VFhuu924HBo9zqwngLwgjD7aQF6y1hQc98WCBL4GvoYe?=
 =?iso-8859-1?Q?JoZDkqTLacGmsBqtOu6J6jWOZr9PwA+tl/ZpnuE3PaQ7JL0sAygWohJPuD?=
 =?iso-8859-1?Q?xkwfzxNCSm+LMJCCm2bQcq9YkNrbwA8J7SSodTRBFCGm7DKGfdlfX2+ymw?=
 =?iso-8859-1?Q?c1JKsqbgx20OK+AX3AQSnMjeOjsRFb7BR71fiQNnhMxCeBffSYhWy7CwA8?=
 =?iso-8859-1?Q?Xi2/dOTAH4P9tcuiKaLq16be+LtELyr2Wyw/dHP2V6AgFElnWV7IKyuhgN?=
 =?iso-8859-1?Q?NeZ2Ks9EqTTd/pTaqhWJ4zWgRYnGtj1ANx?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR02MB10771C80F1E35014C06F8C9A9E940AIA3PR02MB10771na_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 85tlCCkdqmlA1sulAtvtTvc0uQDbfVIjubQ28CIECYTO69T0wag9ku/CX4Cp+Ivmzy/BfxnjgLavSoS8K7YDeHh0Tg/fQ8S88FfDyLxqIZwRgO9y6zTYyRJ0rdXGhQxfYc/A+oE7CR/i1iqG8MYZZIVNVmIhxXttv3sKLonMDkDgDfjJ7trKFwoYHPykEfZse8ST8Fw/VM7TbQ8yO8PcVQ905uP9kb4wRSninm9rlJMzK+3xRCLRGrNs7Zxqvl0AtLR+ol9WXkOXolEq3zJlJ662h5HdwbwDhfXn9WpxoN55tbYmH++TnUrh7prX6EsTGB3ZlUuurDaMcdw+SqUN/35o8Jr0JtNDPJVhWc7e38WneQMN0etMjkUJlBhwbVcbkkixUFnc6Vrfn6C0Qkygq3dBjIrsgz4xtMoJnTt699ICqv2ZtqY2MNhZLtWOP/kwDvs309X8yPZoFHYFJabE6hUhpW8sFEryYQ4lkf4l4Qsj2i7Jyvixn+1fosgEqqZnVRBZTxUU91lZdBpcxTPbEjvfxdbq+zF0C7Erv0f0D4dCW4Okkl7nt91i3oNa2K2fNizArhLqE2H5xBRSOV0jrscmtekcihRkuxMH2QU1f4WfCBnGnr124+9qMHSog2+u
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR02MB10771.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3052b63-9932-4eee-a7fd-08ddb99ef3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 19:30:50.2597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkQS7V8XUDg6ibs7Uy8DVvo9ahfj/GeiYQfNEbk0IJMGiOhEjdUdWZSZN40vFuVoJmSaKz9wv2qpg5kZpiYpBGB50fPj9tKDKy3sE8CoZ/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10291
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE2MCBTYWx0ZWRfXwvEnkAnZzzhW
 5KkcdYt8/9PlIlygAudkiE3F6TlqwPzfkT6s1MBOTgtOAetzZ9oOhY43+AOnGjKwRDyXEF/BwGb
 xk5TV63fy2zssvLe/gDnMmY4PfTmKm9CZRtPHYeN0n5ei3/9s8vkcbgOfh2J0xs8PQc96zwU76e
 IzoTzjwx64HIRFToTFJmBlcd6stLuTwBnWhcyr2w0Daj8c2UYten+LSBHCRE7lGxwPsl8CzSf/J
 MjPXxHjQkDhLqKI4RubTmB1jGOlOqgX3S6Olh/IM6yGr/cWdknffiN0cYQ1ln+em62bBI7ZQuzK
 zM/TM8SogE4U2ZCEUxkWb6OqOtlAZaanndqC53ilBqXjfYSLPIJZNg7ycgk9mmN5bRSG8u3yT1R
 4PGAdqqZxRW3rdoB8lVIZNZjgTUTSixHmxiGyJ1k2pqck0SgdYhPJF7FgYGSZOXSp7/1+GB+
X-Proofpoint-GUID: fFXIA7VHs2uqQdiJZUpZ-BEY_hiUBA9C
X-Proofpoint-ORIG-GUID: fFXIA7VHs2uqQdiJZUpZ-BEY_hiUBA9C
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=686588f3 cx=c_pps
 a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=bt5KbKNvAAAA:8 a=EUspDBNiAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=jZVsG21pAAAA:8 a=M5GUcnROAAAA:8
 a=Byx-y9mGAAAA:8 a=0iV3OJ9aodcmSAQAYg0A:9 a=wPNLvfGTeEIA:10
 a=8aIKZBmP7P4xr94g:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
 a=a-zEBD5cKgE7DNtTSb7C:22 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020160
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

--_000_IA3PR02MB10771C80F1E35014C06F8C9A9E940AIA3PR02MB10771na_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hey Thomas,
I retried a build when libpcap was absent and was able to reproduce the sam=
e errors as you did.

Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-=
gcc/install
Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install
Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gc=
c/install
Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install

These Errors are coming from ABI check: dpdk/devtools/check-abi.sh:49

I see in this function that it is checking for the existence of these libra=
ries, which will be absent when libpcap is absent. Is there a way to have t=
he abi-check skip these libraries if they are not built?
Or better question: How does the abi-check even know about these libraries =
if they are never built?

Thanks!
Dylan


________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Monday, June 30, 2025 8:28 AM
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>; S=
tephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvell.=
com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilpur=
am@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interf=
ace block

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

Sorry I did not investigate, but there is probably a different installation=
 of the pcap library.

I have this in a config file:

pcaparm=3D$deps/libpcap/build-aarch64/install # requires big changes in DPD=
K
#export PKG_CONFIG_PATH=3D$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig

I don't remember what are the big changes required, and why it is disabled.

Checking Meson, libpcap is indeed not found on aarch64:

        Run-time dependency libpcap found: NO (tried pkgconfig)
        Library pcap found: NO

Can you check whether the error can be related to the absence of libpcap?



30/06/2025 15:50, Dylan Schneider:
> Hey Thomas, just wanted to confirm,  I see the ARM build passing in CI. I=
s there a reason it would pass there but not on your dev machine?
>
>
> ________________________________
> From: Dylan Schneider <schneide@qti.qualcomm.com>
> Sent: Friday, June 27, 2025 11:46 AM
> To: Thomas Monjalon <thomas@monjalon.net>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>;=
 Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvel=
l.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilp=
uram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the inte=
rface block
>
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> Hey Thomas,
> Thanks for the reply.
> Can you tell me the build command you're using to produce those errors? I=
 have ran the builds on my test machine and cannot reproduce these. Thanks!
> Dylan
> ________________________________
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Friday, June 27, 2025 11:39 AM
> To: Dylan Schneider <schneide@qti.qualcomm.com>
> Cc: dev@dpdk.org <dev@dpdk.org>; Reshma Pattan <reshma.pattan@intel.com>;=
 Stephen Hemminger <stephen@networkplumber.org>; Jerin Jacob <jerinj@marvel=
l.com>; Kiran Kumar K <kirankumark@marvell.com>; Nithin Dabilpuram <ndabilp=
uram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the inte=
rface block
>
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f any links or attachments, and do not enable macros.
>
> 09/06/2025 23:19, Schneide:
> > From: Dylan Schneider <schneide@qti.qualcomm.com>
> >
> > Allow the user to specify protocol link type when creating pcapng files=
.
> > This change is needed to specify the protocol type in the pcapng file,
> > DLT_EN10MB specifies ethernet packets only. This will allow dissectors
> > for other protocols to be used on files generated by pcapng.
> >
> > Includes a breaking change to rte_pcapng_add_interface to add link_type
> > parameter. Existing calls to the function have been updated to pass
> > DLT_EN10MB for the link type argument.
> >
> > Fixes: d1da6d0d04c7 ("pcapng: require per-interface information")
> > Signed-off-by: Dylan Schneider <schneide@qti.qualcomm.com>
> > Cc: stephen@networkplumber.org
>
> I doesn't pass compilation test on my machine:
>
> Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generi=
c-gcc/install
> Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic=
-gcc/install
> Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-=
gcc/install
> Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic=
-gcc/install
>
>
>
>






--_000_IA3PR02MB10771C80F1E35014C06F8C9A9E940AIA3PR02MB10771na_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hey Thomas,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I retried a build when libpcap was absent and was able to reproduce the sam=
e errors as you did.</div>
<pre class=3D"elementToProof" style=3D"margin: 0px 0px 10px; padding: 9.5px=
; border-radius: 0px; display: block;"><div class=3D"elementToProof" style=
=3D"text-align: left; text-indent: 0px; line-height: normal; font-family: A=
ptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-ser=
if; font-size: 11pt; color: rgb(0, 0, 0);">Error: cannot find librte_pcapng=
.so.25.1 in dpdk-build/build-arm64-generic-gcc/install=0A=
Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install=0A=
Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gc=
c/install=0A=
Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-g=
cc/install</div></pre>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
These Errors are coming from ABI check: dpdk/devtools/check-abi.sh:49</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I see in this function that it is checking for the existence of these libra=
ries, which will be absent when libpcap is absent. Is there a way to have t=
he abi-check skip these libraries if they are not built?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Or better question: How does the abi-check even know about these libraries =
if they are never built?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks!</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Dylan</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
<b>Sent:</b>&nbsp;Monday, June 30, 2025 8:28 AM<br>
<b>To:</b>&nbsp;Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma=
.pattan@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;=
; Jerin Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@mar=
vell.com&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan
 &lt;yanzhirun_163@163.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2] pcapng: allow any protocol link type fo=
r the interface block</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">WARNING: This email originated from outside=
 of Qualcomm. Please be wary of any links or attachments, and do not enable=
 macros.<br>
<br>
Sorry I did not investigate, but there is probably a different installation=
 of the pcap library.<br>
<br>
I have this in a config file:<br>
<br>
pcaparm=3D$deps/libpcap/build-aarch64/install # requires big changes in DPD=
K<br>
#export PKG_CONFIG_PATH=3D$PKG_CONFIG_PATH:$pcaparm/lib/pkgconfig<br>
<br>
I don't remember what are the big changes required, and why it is disabled.=
<br>
<br>
Checking Meson, libpcap is indeed not found on aarch64:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Run-time dependency libpcap foun=
d: NO (tried pkgconfig)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Library pcap found: NO<br>
<br>
Can you check whether the error can be related to the absence of libpcap?<b=
r>
<br>
<br>
<br>
30/06/2025 15:50, Dylan Schneider:<br>
&gt; Hey Thomas, just wanted to confirm,&nbsp; I see the ARM build passing =
in CI. Is there a reason it would pass there but not on your dev machine?<b=
r>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; Sent: Friday, June 27, 2025 11:46 AM<br>
&gt; To: Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
&gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.pattan=
@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Jerin=
 Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marvell.co=
m&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;ya=
nzhirun_163@163.com&gt;<br>
&gt; Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the i=
nterface block<br>
&gt;<br>
&gt;<br>
&gt; WARNING: This email originated from outside of Qualcomm. Please be war=
y of any links or attachments, and do not enable macros.<br>
&gt;<br>
&gt; Hey Thomas,<br>
&gt; Thanks for the reply.<br>
&gt; Can you tell me the build command you're using to produce those errors=
? I have ran the builds on my test machine and cannot reproduce these. Than=
ks!<br>
&gt; Dylan<br>
&gt; ________________________________<br>
&gt; From: Thomas Monjalon &lt;thomas@monjalon.net&gt;<br>
&gt; Sent: Friday, June 27, 2025 11:39 AM<br>
&gt; To: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; Cc: dev@dpdk.org &lt;dev@dpdk.org&gt;; Reshma Pattan &lt;reshma.pattan=
@intel.com&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;; Jerin=
 Jacob &lt;jerinj@marvell.com&gt;; Kiran Kumar K &lt;kirankumark@marvell.co=
m&gt;; Nithin Dabilpuram &lt;ndabilpuram@marvell.com&gt;; Zhirun Yan &lt;ya=
nzhirun_163@163.com&gt;<br>
&gt; Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the i=
nterface block<br>
&gt;<br>
&gt; WARNING: This email originated from outside of Qualcomm. Please be war=
y of any links or attachments, and do not enable macros.<br>
&gt;<br>
&gt; 09/06/2025 23:19, Schneide:<br>
&gt; &gt; From: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<br>
&gt; &gt;<br>
&gt; &gt; Allow the user to specify protocol link type when creating pcapng=
 files.<br>
&gt; &gt; This change is needed to specify the protocol type in the pcapng =
file,<br>
&gt; &gt; DLT_EN10MB specifies ethernet packets only. This will allow disse=
ctors<br>
&gt; &gt; for other protocols to be used on files generated by pcapng.<br>
&gt; &gt;<br>
&gt; &gt; Includes a breaking change to rte_pcapng_add_interface to add lin=
k_type<br>
&gt; &gt; parameter. Existing calls to the function have been updated to pa=
ss<br>
&gt; &gt; DLT_EN10MB for the link type argument.<br>
&gt; &gt;<br>
&gt; &gt; Fixes: d1da6d0d04c7 (&quot;pcapng: require per-interface informat=
ion&quot;)<br>
&gt; &gt; Signed-off-by: Dylan Schneider &lt;schneide@qti.qualcomm.com&gt;<=
br>
&gt; &gt; Cc: stephen@networkplumber.org<br>
&gt;<br>
&gt; I doesn't pass compilation test on my machine:<br>
&gt;<br>
&gt; Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-gen=
eric-gcc/install<br>
&gt; Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-gene=
ric-gcc/install<br>
&gt; Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-gener=
ic-gcc/install<br>
&gt; Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-gene=
ric-gcc/install<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
<br>
<br>
<br>
</div>
</body>
</html>

--_000_IA3PR02MB10771C80F1E35014C06F8C9A9E940AIA3PR02MB10771na_--
