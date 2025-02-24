Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE19C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 07:19:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A2E240299;
	Mon, 24 Feb 2025 08:19:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CA2F54025E
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:19:26 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51rUF004594;
 Sun, 23 Feb 2025 23:19:26 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeyku0c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Feb 2025 23:19:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFqg7H+H128vbZp8OxTk7eCGsIWanRb6hG5CgqL0ryB7KYiyZEUeTlcQipFOdKsrRIeZZmW1PiNVNwSCSFNEjZWRLJJclI7hGjf2+yapDqIyhGVxE8DGda5SGyAtBhDgDH40t/asLH52ktBqLqchncwwExXuLY5RqtYliKgPNx2HxRTwCBCAa98sUiuxQC3Xt5ULOQc0Qwkh8pE78/+mnUyqbblS0y9NDvj6nlhGjhrw+ECQqCpkd35raKbhf45bJ7kkheasKUl4mW5J/wGN4P1fxRJkM8AQCthojLbsyJJIDu3KakRwo+U59asLYtPyUBqPcDWYbx/m8zxKeRVj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb/8wNv3LqoLca4ksOKAzGf3f3ATJX1fnREYd3IrXMI=;
 b=E+iVf9IVmiWwmyQr6VsVykmptRHNIR6JwRc7Md2WQKjBhFTZs7JUp81riBPzvyANxrelvzgGEKHzBAFU41fL5GWujgLInHO1A5MHx/00OcGO+hnCwjKME208QM2zT5kAiwcGPWyXGIQi4bMnhElqgE9OllCGBL4k3ARQtGAffy6vN8cEh1akjlhJSr09UJGINDnVHLl9VSUmGorFPAs4dhqWGzshIKzaaaVTUJe5Q60MyjJEkAiyGRGoX//KrPDn6Pj30tJMdNE/Vh0bn+1QdGGkoBo8v3mP2aZzjZn4aq19gNCSnc+Khqfp6S8reNEeT6+hTmkNQ7+98/KKCAI2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb/8wNv3LqoLca4ksOKAzGf3f3ATJX1fnREYd3IrXMI=;
 b=mzUH2/LSHKqW/fqxxh6hnYqMonZylzc1HhpMstqCwwSsXfgPMIOWHjWNAEHljIZqdwW9kRz/2YvT/XGQMVKe+a0zfvDZMzX0ewkQ47wPH9yKEQJDZwiJNhqq8DxLnRr/VHGgB3skM6WVpeFzvyn8ugPNrec2xgo1aqVA/4aXcu8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 07:19:23 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 07:19:23 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v4 5/5] examples/vhost_crypto: support asymmetric crypto
Thread-Topic: [v4 5/5] examples/vhost_crypto: support asymmetric crypto
Thread-Index: AQHbhQVEEhiivWWu+kKdG0bmQFPM2bNWDpYg
Date: Mon, 24 Feb 2025 07:19:23 +0000
Message-ID: <CO6PR18MB448475AAC800BF9A4857291ED8C02@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740212213.git.gmuthukrishn@marvell.com>
 <80ac8ed50df809d22504dd8dd424eef4dc5cb8e1.1740212213.git.gmuthukrishn@marvell.com>
In-Reply-To: <80ac8ed50df809d22504dd8dd424eef4dc5cb8e1.1740212213.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB6379:EE_
x-ms-office365-filtering-correlation-id: 03e62a57-d6c0-4a10-75dc-08dd54a3901a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ci+NithM5xDmV2x9bsVaemFCqNTphnMe7qbveANeoFag20+1m5ptd3plNWvV?=
 =?us-ascii?Q?aiEGqrqoSv5LR3q/sBoKLDQP+l6+B9Bf3yO+zgqw8V0d1m+m4vlKFvPPSkWo?=
 =?us-ascii?Q?PTJfLuiJpAgNMmMeHsnR6icma/GEgH+1c7S6mo9j/2/KjbVFVkl8KjIi+q2i?=
 =?us-ascii?Q?IX9eO0vZ4ARHdO5FFzx5Vju9Q5VEOZodUKwoN8GP1kjEItpA44KqI0FNHJeo?=
 =?us-ascii?Q?hjWBMESSBenhm/lpddN/nNHv7uzw1XEx7C5OYZl6KNNWt22M2esbY3ShsEj4?=
 =?us-ascii?Q?74INhIqoxAFHmTMJMoD3i5lpvHFnE1LWMI5f+we0EYgIR39GBFtMLLSP6q+N?=
 =?us-ascii?Q?B3ona4tL98/GTlEFtr0UdQkGe3uzOxHQULiASqLsN3ramfP+tG/HhI/ZTADc?=
 =?us-ascii?Q?l4Lo0eHIf5BG+Pg/Pycq9GNj7y96SfIHaMwsHRkDxHmDFJBVhTaPpkxlWnaR?=
 =?us-ascii?Q?2f9S+gzNpBPibNCI8fpjZicrilyLv6Jfz5mI1Xnk8+ezl82b+mJ3RgXrFkIY?=
 =?us-ascii?Q?WtYrVBy9b4YEJZWvuaLAs4hRKSJb4KBi9KKLuaAXPE+89if4iZ0XklgH6E8m?=
 =?us-ascii?Q?sMto/Tt4XAg7CggWuHJVbuRyZH14UXvu6l3ak6GjfmUNrKH3/uLTYLd1G48s?=
 =?us-ascii?Q?ZDHoeVtipdCqYM8B/ZX39WFEyu8uQVvWjhAQZJTAl7apabjCucbBW7en/EYK?=
 =?us-ascii?Q?KzyEz1Ef5MKE6NtA5UiL0xN50zO1dfUUK14OKEo6A4b/DN2Tsdj/k4A8AEmn?=
 =?us-ascii?Q?RuRdX5K3pQSuXKgsm18Ss5X8X1YLv5nzd6V3HDbZwBOIGDDQ+NhipB17/UKp?=
 =?us-ascii?Q?GObI1AhJCeQawqH1LUAmLqtTOJJMUa4medxY3eVU0wWpB65zrK3yyhLf2fwQ?=
 =?us-ascii?Q?AfX6ziVKQwMI3Gq7M1ZrJMTc7/h36oBqzCxpMdGBSRsgLKzY8nbMVhXFdalT?=
 =?us-ascii?Q?pT7o3aXk3S8vKP+cmZgTEwlvWtWYRqyF7PymR9++TBk4viVBRdIAoDUR5TmZ?=
 =?us-ascii?Q?a22afg/ARwzFAstjXP4Nx6XzwcULl9QgExz6jvVoAyQ9RQJC1VP5suFjqQDI?=
 =?us-ascii?Q?fItX6QnpEUP0k4hqTKLm1fxHU3rAZdVK+Jyz/KwoVmmse4QgB1CffTxjD2GH?=
 =?us-ascii?Q?xoJRuam6wZBSCrscOOs23EmprE5s6wnIGypv+HRthoUXS/Plk0Do4p9lauJR?=
 =?us-ascii?Q?8iwDHpNc/GXfouaHXHbWxLeUI8usXhJ2fOApgjAnKfA4y9msOMsAlpsCCiS0?=
 =?us-ascii?Q?DAvhvyCNPIPpZimJxyZi0lNenHrl1UEjs1kn1hXGTQXswvAwK3N6rjiK00I5?=
 =?us-ascii?Q?pi2IWrvqCT7DEEdStP9W+QEfF8dBnpucKEXmoSzTIryaVlNReS5LJTWSyQoP?=
 =?us-ascii?Q?st2sdQZfW+MF1jLHFh1KudZyMNlNBgGXMIPLwmtPlvVt5OcT1hrLDAru+h+H?=
 =?us-ascii?Q?BHZ+pBeXfpvtDOr34eM6V/2O2TMlaXwi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0iK2SKtW/yUJ8KAD6VOcMrGHWRlq86pPY+sGOpBYq9BMjpEKls9s/o+uHnBj?=
 =?us-ascii?Q?Oa3X49iW+joJY7JM2GK0DJLgXuHNJhoZLAqBYvqAL5kCHos45AnRBw0sCZjo?=
 =?us-ascii?Q?/ypXdxhFWAV+r6wa8nUR5qrW9JqAMh2GqjCl4g7IVzBPEr95BhMIrTVf4v5c?=
 =?us-ascii?Q?mcqpe2V3pA3lNTkUgdo1V1Gar4I3DGD6PKYsllubHubCK80EXO7J7hUDRWeH?=
 =?us-ascii?Q?COjWntI/+xhyz+mkZv/4olAiIXuNHIFc8FYMYEY0tTZgzrE31LOk5Cb9+HyR?=
 =?us-ascii?Q?ShaMfma+ZXD/lCQlrg2JDmVv5HL6NyJTbRW69DW/wQiIUMJBOafhq2FyjMLz?=
 =?us-ascii?Q?DjUAgLT2JsWAWciNGqszKmJC3B/4NzZH6E5X78RWWOXDsXCGR+bRvmswyMVL?=
 =?us-ascii?Q?0NKxE3ojo3Zxm7F37UEyZCAyJqArKMImfhTrFlcSlXw/nE2J37PcmlTVVjVt?=
 =?us-ascii?Q?Amz1nyskSdEemvJJo8fHDSMqMWihH8YPINtWKgV7MTIbjEDlqMHB8d+kBnDd?=
 =?us-ascii?Q?J/P4WwYmWlz0YsTV6khJqhoHkpY3a2tTofgySDVeZ1TD+QNG1EgxhJXcBHuq?=
 =?us-ascii?Q?P/dPOuk8/po1t9b9r0CwDwLmCanuIJSmZi0CMKM+ndSj/tL/Yb5LAGKd5JKo?=
 =?us-ascii?Q?X9gTUum+GyA4YaZvcKOT2U7SVMR/EDMo+ab2HTAetx8F0d8T9y5j3Upjd34z?=
 =?us-ascii?Q?6C/bBxOAazUQZh8w9LMBypKkJ4/98eMFNP+91/EJLSx48zE/I1voRuEx7mUg?=
 =?us-ascii?Q?5EddQ9DN3cFbt90rYPdhwRf643mFAzorQh6IWqeiqIOiqoMK7Gc/D4N2ieft?=
 =?us-ascii?Q?7N6jJ6YTjs8oLicX7EfWc/63V0a4PF9pXL8HHTJl8yxjrO2X2FozyUmS3Bn6?=
 =?us-ascii?Q?f7Fp3HLRu7RO7q5PrkZAsrZ5efya4OrvN7URHbDXhxGf0dqY2/trazKAKq5H?=
 =?us-ascii?Q?KN7pyvgFIQBC4vL/rVfOE9cB2rOZ+UZdmGo/emvJLCddrffvSQrwHvs2CGh8?=
 =?us-ascii?Q?PS4D2PpjsON4iIUnEWrHISagl9/wykSjnW6hWz5mOIG7drFchBqqB2Nq48rh?=
 =?us-ascii?Q?RZxpsB/1fecJ9LNjHmPlAGk0pclDuqKvxkCXxhpoX2k1pdTPeKHcXV+XcRXO?=
 =?us-ascii?Q?MOAHDWnHtWv888xK/gT+nKbmLhDx39jxw014D+Rv/rMniRmrmNn9Fg+d3UhM?=
 =?us-ascii?Q?ojTCzzFBwMq6P+n0ov9tzi1aWjlJQ3f2fMJdBn2Tnht/RzSSDjXh4yd9p2RE?=
 =?us-ascii?Q?cK74/CsOdhZ0XReRfCl3EAWMazWJFvEtKf6V1hN+tdL4Ce6hk+B7HcA89X1H?=
 =?us-ascii?Q?ARxp/25JOmdO2peYMRrF6iBSqvdK0O2PxdjtVppw7FqMvUEh9JvVO7ISYMkd?=
 =?us-ascii?Q?GYm1d9Nrf0xxx1vZ+/HYcOAdKOvgnFDQS1DnZLjD5k6sCXLGVpXaVYk1RJ3F?=
 =?us-ascii?Q?8gpAXEFfNJJRc+HlL39hyuEwlmeITs3jMofruA6EeBZ5maS2SD1nM//fmP1x?=
 =?us-ascii?Q?Lux0KB/X5IG4Vskewj0iF0pYRDVB34KzoLMBZFC+soEWiRVO7BD0h0Xew725?=
 =?us-ascii?Q?A0TdV7q0zYfIjneSCPrDlHAFSeSmmzHB2TrvKXXU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e62a57-d6c0-4a10-75dc-08dd54a3901a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:19:23.0231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4D2Ios4Zblw85QOshhvfKXVfWVAFYByJWZ13EDZBRaViYregCtfA3wXKxDBVWzXRvnUXZgt1hZTFeyN+yHgJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6379
X-Proofpoint-ORIG-GUID: 5rdTrEzQW7Wc_DOBnBJjE_9rRjfO91kQ
X-Proofpoint-GUID: 5rdTrEzQW7Wc_DOBnBJjE_9rRjfO91kQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_03,2025-02-20_02,2024-11-22_01
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

> Subject: [v4 5/5] examples/vhost_crypto: support asymmetric crypto
>=20
> Support asymmetric crypto operations.
>=20
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
Update documentation for newly added parameter.
Apart from that.
Acked-by: Akhil Goyal <gakhil@marvell.com>
