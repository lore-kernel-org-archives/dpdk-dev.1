Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47177CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 10:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AC834069F;
	Thu, 25 Sep 2025 12:33:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C438840695;
 Thu, 25 Sep 2025 12:33:57 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OImRs7014294;
 Thu, 25 Sep 2025 03:33:56 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020114.outbound.protection.outlook.com [52.101.85.114])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 499usj3p0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 03:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITRj3rygY2SOy6KqHaXa9HuttY1uA7I6NOCiqHyPMPrTnEVoa7MerkIEDgBzt8DRni3iJpGI4z1jZn4o96sZQU1Iy0908brxAzHfOXPzQwnqoN3e1THJz8+ExPJ/E8rK2+Dx6WvQV9Cjxi8o7mk4GKU/b1Jry3huAhLD26ChQ0dimri6BkOt3+1PLMNyl9tihUxhjRAlVhmLL2p1oI8zXG6Y3p3WbsL30jclMsjJ5kgnkhcwH4eKhagB1htt6TtlCtAIU3mzCsUBz5tD1vQX1/Q59gnjDtHkT+f5rc7ikSW5+7kC6rB2AbulQvEffsIsZ8xQ5zJFRRvrBjnxHy8xDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRHbo+TogH/tuBsWjE6ytCLulpoYhhLhktlBvWpxTaQ=;
 b=l0G0eCyk0Jdn2TrifCE9aAkWBDNgnabN+WdrUdpPh2YM2MYHBRlw8AQ64LsjeSZJDS9U+gmus1kzZLOmC6rCaHK9y0gmtvNytIsmUaYhZBxOmNXwOGifgm+htco52W07MgHsH2Ygi9SIh4zNg69VQuQdwsTzzeM0SSjlkK/Vz1d2jO2IeZjEBBICyI4gEt5aEXYVGhzE28VFNs6p2mbgJPhxlNWB6EJ4dkbbyHaOByX10DyiKomlVIVR9AoG5wYccI8BEfLmVTt6DYd+woea2hKEQFl+lJhMVbBM1MZ5IsIQyQ1ExdXJj0R3csvXpYHAZ7vaJz2x+UJ+iXjNCwxeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRHbo+TogH/tuBsWjE6ytCLulpoYhhLhktlBvWpxTaQ=;
 b=DwZiUj0u0H7QaHPippl4aPG9sLWPzuC9S0FrCfrThMyIQzpvz7d1UKYZrRvKjK9sFnDXCPC/jorw4RCcF7Mr4UDJ/fgToTfq72Ho7JBk2V65aZGlnrOEWSQOncYPfGx1Dd1w87IeqvtSf7llAr6a0pxKl7PO4rHbJNS6yrWwaWs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH7PR18MB5355.namprd18.prod.outlook.com (2603:10b6:510:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Thu, 25 Sep
 2025 10:33:54 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 10:33:52 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, Stephen
 Hemminger <stephen@networkplumber.org>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>, David Marchand <david.marchand@redhat.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Topic: [EXTERNAL] [dpdk-dev v1] cryptodev: introduce constant-time
 memory comparison
Thread-Index: AQHcLgZQ/6HXh4285E6md8tjGyKHk7SjsmQQ
Date: Thu, 25 Sep 2025 10:33:52 +0000
Message-ID: <CO6PR18MB4484264974305D4A6B065A76D81FA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250925102223.145471-1-kai.ji@intel.com>
In-Reply-To: <20250925102223.145471-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH7PR18MB5355:EE_
x-ms-office365-filtering-correlation-id: 05b691e2-87d9-4fc7-cf81-08ddfc1f05b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?LQuU1BrHWzeWTlhCWPYsEh6Td92bQWba3bFdzJqDw0/Iakwg5cUmCLGmoj4U?=
 =?us-ascii?Q?wZW7KprBvU0hX4W81tqm0jNoCrBKRNv9nWVjr/kP5hlLGpj1N26qhrFYQxnq?=
 =?us-ascii?Q?/RolmOBd0gcDa2DjAecxlrTQZ/R1/yKU2McHY28R64dDLFXgdzga6eF0QEA6?=
 =?us-ascii?Q?XHTTYvVeRjxmWwQOt46loQwX8ZNlMUGHZ1LoU7FrVzzlueYn59gpLYAQoV7g?=
 =?us-ascii?Q?JvoXw3K2X7TfQUVWRyKMb0EXxbA0+WQGoQnr2ThHhDK+nl3IoqN4XYEMOOgk?=
 =?us-ascii?Q?07HGPa0nQ3RtLFCGc0dVb0FHG6g0oMsU83qo3qPukKk3j2nJglSVQpC4lbh8?=
 =?us-ascii?Q?4FJAk/4Dy+3cXpSylJtt9GTRW1Sdmxu/LVUgWmsvTyVao2rniQEDNZA0KwE+?=
 =?us-ascii?Q?EYbKYMX5uXarELRVo0CpeJ8NIjU8Ynd/WYUKLp9DAAQfYghgggVF/UOWUoop?=
 =?us-ascii?Q?KwuXmxXu0k/AI2wTf2i/0AmoN6hd+e8JCu+aXV5iqFRkW77lcF8XpIgBJhlS?=
 =?us-ascii?Q?9QdydyxmQdimiNdgFccp6clyItgeZDF1MQwKi8rAEVK7ncSs8ZS7FzppteHN?=
 =?us-ascii?Q?7CEyghrFwhW+kF6LoKUQRUEKyVqeqg+wYRGYfUl+usDidVKdp2COzGuWhvvk?=
 =?us-ascii?Q?5QHB7W3x3TD1zf/4nlcXnJL1M/M1yUGvCAbTEokdR6JDTH4wlkz9wWKQcmKU?=
 =?us-ascii?Q?lUkk2nRsi1NpIVWhzzjaUBL7qQ9Ca8HR/p/PdxNqX1tC5dnSbiGrTnzZCiqR?=
 =?us-ascii?Q?NPWPMo02Ki2V6pxmFEpNwUKqqPTXeNKBPB7lXqrRDiElnEquRsVAf9UrM7Dx?=
 =?us-ascii?Q?DXrDbRtWMmmiLU8xC1A2JQUlmlnnrdemr3y0110nr6q+nxXXihskcrMfhjzv?=
 =?us-ascii?Q?StvIXPcVpF3GSq2xv+RMJN6484I4ih4tlCqaN14dFD8pAoWasYkCqHIU6fcr?=
 =?us-ascii?Q?TRk1O1w6NcHKzkOouI/K68v1yK6FTs++Oq1ONgS+sOw3Suvxfrq4Vm2418BQ?=
 =?us-ascii?Q?uq2tj39CNz36YlqosaMqI2kA1JfwtJfEGrPfCdXe9/EEJbHm3QgJH64bGTse?=
 =?us-ascii?Q?TMskAH9Qn9yvrpazx0v0I2PwfiCym5V3KViVSNYDiDLF3hMKvtZ6tI5WAijk?=
 =?us-ascii?Q?hMg6GFq9tzKTiYmod5+5CWXJmw0q+W1/RPWpp1jltiDmfnUv7/8cBug1leP6?=
 =?us-ascii?Q?xSHZYglcqFeVWSBr1kPBZWdmrRso3GUY2FYxB1doCKIzQ3/PkJnP4fn0vj5J?=
 =?us-ascii?Q?u5C3MMLMOXfhUZUahhlneSh/APoyU1XOg1Q9wWf2kEfXr/3OZeS/5XKZnys7?=
 =?us-ascii?Q?cbsOjQUDmMyrqM6N0a+T0g5HDywc27xxhO8zmRFxY3uKVJey7CCpm7Y9liTK?=
 =?us-ascii?Q?idfbAjv9HXR5AJS/UAmp4WxoZxGMNj8sIAND9d+nhZNM+uvu8AuGu/q58r0S?=
 =?us-ascii?Q?2jla7jvrDFk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?klBsjzu+OzI1zqB8B1L0zhG8DimUl+KZ+QvFSi+xQk6x+BkoKFWf5YOBTypH?=
 =?us-ascii?Q?VM3fnVLk7ZT9Pc+ImHEAObQrfdPEuCTfeSzU+qYeqk6T7CHQY2tj7tohi1Ml?=
 =?us-ascii?Q?v7RDk2zQmQ455DWPjXwO54v1Wq+JSSXfwZ6f0qAfJbYy+IvFTrGzoHG60mMP?=
 =?us-ascii?Q?t1lfKgkVSRvWvyrmhSJ5tF6ATVdA7zDThxpPsr8V1+IUvxxIG+LHzI6E1Yrw?=
 =?us-ascii?Q?JAwlYknFUABMp/4AVfdFzWEdZ46yqujOV3FsL7pnTldr4UvguAMk7aq9rN0D?=
 =?us-ascii?Q?DxsAmVHPDxoXeeJXONPZ8khTSD37a/Lplw0UiUVfNsoPVBiBtPHhx7+vZHbj?=
 =?us-ascii?Q?j6t3Gp46Kkvmj62auFrggSyz0pvNj6m8gg8RqYaftY3kIJvTi3q5fOVK291R?=
 =?us-ascii?Q?4j4DRy2l+6deLmbmbKCybqJuRYzvfhWhf2lXPIpFv/Z4tXvqV4DC46rzY07Y?=
 =?us-ascii?Q?TXF+zV71R5cfas40KHg9R38UzefzQVCvYwGsJ7YI3kqr09zzf+fqUgwzuV74?=
 =?us-ascii?Q?SXggkYUUW/AHCmRi4CqM5wcOdS1ohp3YzhGl7C5kk+URIcQP/157FVTJQ1tx?=
 =?us-ascii?Q?kf7G9KAJO91BmlLBbb90ZEnDYUMmepd2GSYYneHWKS4TgzeWiYK5N5Z4jPMA?=
 =?us-ascii?Q?T6+5ZOHFNMzb84szPsQPytkaLmmVQiR4/TvnXZUzjscXSBb1ERkGLkUwx/Cy?=
 =?us-ascii?Q?7hi0N6KeYUY9Ii5+GqQXzjLWh9xfG8fXnA4aL4nG5LYFT/hPDzAFYtnReeMm?=
 =?us-ascii?Q?jAQEcyRSqUK48aB5WhLiPPoPas/pETw4AWG97xAXoOGBsvAir/Y4GQwB6+NP?=
 =?us-ascii?Q?h32nyrGRyswXHV194Qqe1uH10vlfFmwXY3tcWF+JpLnbh1emILUJimgbBzzr?=
 =?us-ascii?Q?oeDmWc0cfPJkOb6/X7CTWOuK69OQupuOt4+pdrtj2nmMUMxY15JvWkrxCC9c?=
 =?us-ascii?Q?x3SndHdHZqKBIQ+cGBBAMvar7A5yMGR8+W5vOvom3YiZ2rm0aLF17s0ntIM5?=
 =?us-ascii?Q?XcAmA6UbApjinawxarAtiCRqK3PmDFK1vf+Po83H0TFtYC1Us/N5Gx0FBLdo?=
 =?us-ascii?Q?wn9jyomTl3y70KoI9j+8lEQmGSj8lNtJpfkndv4N+hNp2jNu5Gef5RP9q3RL?=
 =?us-ascii?Q?XJL/CVjD0AXk329/7a8H8PNP5y31V8KE2q4ad2TPWngiXLyqbqfRscJr9f9Y?=
 =?us-ascii?Q?3xuBGjnv4AJFpllM19U3rkTSVYwvm7QrrEttusrt4u/rY1fMJmxj0mWZAg6I?=
 =?us-ascii?Q?gmegi+hxPEdt83gw/b1W4HD+mygwhbQUs5TTtikPOB00yntMvawBvjYJoIlr?=
 =?us-ascii?Q?2i0up1gqzu5kIAbXm6BRPd1pRY9Q+BfrMMrXNVk1Sq6RcyP1VddE+QWRfgso?=
 =?us-ascii?Q?2w+Ly39i4oN83xscWPy+Mrp4dOCwJYXnopU4nfXqEsReR7gB7tKJXe0kAkoa?=
 =?us-ascii?Q?O4zFqb2yW1o9Ip2u5Vh6+PlP24Rx+OD25KX9hFbvScJNitfrlk0zM+FYW2Ql?=
 =?us-ascii?Q?OfjdDUkz+QGhOa0XGu7qC+751GyfGxu7KAJJQqRGucotk1L3rfkYscUxxNHj?=
 =?us-ascii?Q?r8BCKwLl/DUJ5Gca8nXrXBitr2P8lA+O2Pjgp9Z/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b691e2-87d9-4fc7-cf81-08ddfc1f05b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 10:33:52.6182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lesEUYzTaSzgbS+4V7xIJvp23P4uMI0tSaEVbyND/t3g7uPwsP6gjHXn7cON+ADM9djhmxC1CbsD+4hrjK+QCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5355
X-Proofpoint-GUID: X6AaJNq5NAmzJIng4nAP7F1iQkRh5fHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDExNCBTYWx0ZWRfXyAkgZCta9qnh
 0tLRL3za/DwIAEHsurNeF2nIIvuujvgQx/Mz4+0deLb0yFg46G62B79sD0QeQ0tnyNibfQBNVOE
 +OTJMIdoNvh7Sj6wUN9WXTiqYziSOxI+IazlYfG9Vs8c5Fx2X0RDMNO7IkiXLCoFz2bmooU2I6k
 E4yPBhx5kG5jc3H9eZmWzFz1PA9be88CLOZD2uFTv09N17bo5Ky+vg2jrTSZQK8qBQ+LYjw/v5I
 RxOh5fKJ+vvlEf3v2dqj/zoLlrF8Uhd/gNVJTEbgQb8Tvz3Lb3/wDGYI9KklfUFl0bSHYyxv4k+
 ij7vzOnmJPZPVCR2d5hSYV1hFzTVOvch2YCNpWVkU+WJRjb1S/THPKx6qJy3kn6YxZ5ITdcDIK0
 Hj6LUfAY
X-Authority-Analysis: v=2.4 cv=auayCTZV c=1 sm=1 tr=0 ts=68d51a94 cx=c_pps
 a=0Uzpqe5Hikn09oORNzbshA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=tdGEB-WsNwf3ucfJ4SwA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: X6AaJNq5NAmzJIng4nAP7F1iQkRh5fHY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
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

> Add rte_consttime_memcmp() to prevent timing attacks in cryptographic
> digest verification operations.
>=20
> Replace memcmp() with rte_consttime_memcmp() in cryptographic
> authentication verification operations across multiple crypto drivers:
>=20
> * ipsec_mb
> * scheduler
>=20
> Note: OpenSSL crypto driver already uses CRYPTO_memcmp() which
> provides equivalent timing attack resistance and is left unchanged.
>=20
> Bugzilla ID: 1773
> Cc: stable@dpdk.org
>=20
> [0] https://bugs.dpdk.org/show_bug.cgi?id=3D1773
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>


> diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.=
h
> index eaf0e50d37..77f10fbf88 100644
> --- a/lib/cryptodev/rte_cryptodev.h
> +++ b/lib/cryptodev/rte_cryptodev.h
> @@ -78,6 +78,29 @@ extern int rte_cryptodev_logtype;
>  #define rte_crypto_op_ctophys_offset(c, o)	\
>  	(rte_iova_t)((c)->phys_addr + (o))
>=20
> +/**
> + * Constant-time memory comparison for cryptographic use.
> + * Returns 0 if the memory regions are equal, nonzero otherwise.
> + * Runs in constant time with respect to the length to prevent timing at=
tacks.
> + *
> + * @param a
> + *   Pointer to the first memory region.
> + * @param b
> + *   Pointer to the second memory region.
> + * @param n
> + *   Number of bytes to compare.
> + * @return
> + *   0 if memory regions are equal, nonzero otherwise.
> + */
> +#define rte_consttime_memcmp(a, b, n) __extension__ ({ \
> +	const volatile uint8_t *__pa =3D (const volatile uint8_t *)(a); \
> +	const volatile uint8_t *__pb =3D (const volatile uint8_t *)(b); \
> +	uint8_t __result =3D 0; \
> +	for (size_t __i =3D 0; __i < (n); __i++) \
> +		__result |=3D __pa[__i] ^ __pb[__i]; \
> +	__result; \
> +})
> +
>  /**
>   * Crypto parameters range description
>   */

I believe this is not the right place to add this define. It should be some=
where in common eal if it is already not there.

++ Thomas, Stephen, Bruce, David.
