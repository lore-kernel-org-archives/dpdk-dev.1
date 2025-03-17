Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75616C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 10:22:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A80D7402D1;
	Mon, 17 Mar 2025 11:22:37 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 24ED1402BB;
 Mon, 17 Mar 2025 11:22:35 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9dlct031698;
 Mon, 17 Mar 2025 03:22:35 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45eh9tr20k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Mar 2025 03:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWfE9oODtcNYmU6LZKc0Y9WqSUNj5WJcua36vpqNS1O+7c0k2PA4elUOfDN/pQCsSS5+fRQ0kNO2r1Uys+puzXrqyN1uaLtGfBWD1z2zob+5mXw3vggaE5aEbGdZ44uhCIbqcZLmoMBErGaxVBUvbDrjXTOfAMkqIx15UoS+XBiY4qnTs6vWnE9kQDw1O5jBF/cu7XjJVmEMit2WEtn3AszQdbQBqFHeAhL0Dl1GREkAkRuB9Rp7ME3C645aE/8Uyc+7yUqRT93/8yPUGu2AsNgxlzcCkiRpVLp5nFbxYQeEedgjWVu51r3IsZwqPvurE9Czl7/NT9VNlg5trCD1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dayZKCB2peFcl67TUhLdDmLDXkAQyFUv26MT3MmC8ms=;
 b=sBk6OLRUWkSFRtJKBzkn5diKDRR7GqtDvaROr2hTd+36YnpFu2MA34c2OmoStv8Qh+an8DYACAJO5KVxFSpwYyje3F8rx5tialPdF/0+44DuLDLjtZ/vKJLNgYp5vNvO6NitGMpIdtnsuvQuUMZe/8pgmxn1anqBMFYAgpFHs8IGVBa2cqYC8UK1kjzK48tfEqCII1qj3phKGNWynO/rlVY7bzjQq5pKZFdEi4cUkB+0vyYGkz2MmJIs3r8rYHW8GX0p3HYQZbziEddr4/mCP/Sayc9NTw05GWd27Nmrk42oqylcZ23g4CscaauDgddB6hU/n2uq5KJaYeRNcIx9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dayZKCB2peFcl67TUhLdDmLDXkAQyFUv26MT3MmC8ms=;
 b=LhToUgbDep0BwrFukDoK96suDUKl3q9+F2dGzdUrsiMjaYRUtrDx56AJcFojosuikNkxxAcJkQj8HJst+WHlSZa4XABUOkP+ysh3bN/ZMIIQjW20hnueosRJ0H6J2dXMwWj+7slRHO3T38smKyoFN2kMrC0Ba1nk09GRpCpHLoQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SJ4PPFC91BB56DC.namprd18.prod.outlook.com (2603:10b6:a0f:fc02::f40)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:22:32 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:22:31 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Shani Peretz <shperetz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "suanmingm@nvidia.com" <suanmingm@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Brian Dooley <brian.dooley@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
Subject: RE: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Topic: [EXTERNAL] [PATCH] app/crypto-perf: fix aad offset alignment
Thread-Index: AQHbkmQ4k3jiwngNXU2n+5Mwha/pIrN3Jx6w
Date: Mon, 17 Mar 2025 10:22:31 +0000
Message-ID: <CO6PR18MB44844B0F7C3BA22106DD9620D8DF2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250311090122.121190-1-shperetz@nvidia.com>
In-Reply-To: <20250311090122.121190-1-shperetz@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SJ4PPFC91BB56DC:EE_
x-ms-office365-filtering-correlation-id: 035889c1-9a1d-4647-0027-08dd653da0ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Zf46x4scu8jTZUL8v9kkm+g9pt8pdXWYbRkvvsN1S5aUIt+pxhwo8IGZsfEA?=
 =?us-ascii?Q?lJ7CippBM8Ww/ihRaJAX89DkR4PflkD5pi+RX5JsLIPSzatGGF3i0H7o5Ehh?=
 =?us-ascii?Q?IeNoCHwLmHOBjOBywFMo+Bx1T5dYLW5idbe+Z3xy0uyBvXKWGiwIlwwbYe5A?=
 =?us-ascii?Q?Fg6o4/tHM99ho6HUxdrIuxPzeTjJd5z9Nv6QH6zzESIo4leWlsIUSi/Xpgcq?=
 =?us-ascii?Q?sfdslIBoxI47lyrAjwrbXqJLJZ4Z+sY7/aqjwQSXO4WBE7jdQ0Nj9jjAT7nJ?=
 =?us-ascii?Q?WxFsBDqrWmzcAW9A4nFI7eIHFz4KcpcBEDyOcGm/vhbJVjDW9mqHEZq4kh97?=
 =?us-ascii?Q?3xWY0kD3cRSf03lId2biWvtacXGfpNobR8Dc6IkTZ6UlhNlr9m6ysN2aSL5W?=
 =?us-ascii?Q?PLZ5P7SjzKQoj38ifRNVVTuyS97L3ZxdAsAhfGdanXGS/B1bgNw5+RDMX5ED?=
 =?us-ascii?Q?IzJsVmy7LSiauXtPclW1B0RAXE/yQ1AYE5sSQbILLFgC1PGc8bylR+TYJt0d?=
 =?us-ascii?Q?BydTS3aAiy5XURQw89OzGokyI6xpbh0rdBDwcDess5Uwdz/kM8jAbiuqbvQW?=
 =?us-ascii?Q?HQxikQMPQC4KDipc5snqJxOmI1xAeLHgsV0/EL4p1Gil4i7cooSWRbpgofMO?=
 =?us-ascii?Q?hRcV4myDA+5GMco0vLzGRjSwMcX6vOJlnRfQxY/RjeTESaG0dt9668V0rx4M?=
 =?us-ascii?Q?op9MP4HvF2C6vrJyQQI0pkHt6KMAJYRv67xZ1bE0QW7dsE+Z+pwGe9Yedntr?=
 =?us-ascii?Q?NvNWLfwp+9nGn+AfA6+xD7aXyFzter0X/NEYa/ZyluBRO3ygPBPOB0vL4CZv?=
 =?us-ascii?Q?BVfSKUQusMjb2q4i+EkGyrUobrXJGZzUDAifYMsrJ2jCiGwM2xNHPwEkxrnp?=
 =?us-ascii?Q?80OGeWIC57VQit92FqXNusKNmmwTM4aLgw534udY9f29wJngtPF/QpvPWfvn?=
 =?us-ascii?Q?pjDlkaOfX1onHGF7wCBXlpzNdx4u+YeGnFRdr7V5KtWOdVy/aY7BKCMUFYoL?=
 =?us-ascii?Q?4a7q3SXhm86tq4IMoPRnr76iWFQo3yj+lMDpsP7Y99RStdq7er1MDQqjZMFd?=
 =?us-ascii?Q?5uEgDVBL/ZvgqhWXlWVDDYCU7g1JjCntvNrS3PSB7K3M1apkWZboW6tUZ4qA?=
 =?us-ascii?Q?AOO/1JvuJVwkTqbFt0fOeof3OD+P8vxxI+CUo466/lLqlXyX96rZ+suxNBrB?=
 =?us-ascii?Q?7p7sZif0uZ8CoFRJN7QuZZ9dW1DDOuuOUAhCwM/GL+B1ecsDk8/nvKhdLI4W?=
 =?us-ascii?Q?T4zEfvuoViCaTZEeZ3nv7++2p4Ol6pi4uGhlcQsW5eaTgsm/JJZNmVa9hsG1?=
 =?us-ascii?Q?3dJrFmeG1RY9MWIAN5TinRVKxuQJkwKlvNyF0JrjG7snE4KpqDetkvpRW56K?=
 =?us-ascii?Q?lTTmnrMEInNZ4iTkrmzTHUUzasez7ae38ys5XNKIINj1t6/ZpYgbRGHD1tGi?=
 =?us-ascii?Q?m4ZvJIgZjbShFE1fRasB0FnXLYpNx91P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tdpy2MO3saAllpLUxdcPBXKtPFNiGUsdUXOaqyoMoNRzfa/7eDXXW+9B6+T9?=
 =?us-ascii?Q?WSbA2Qiwdgw0ARWUmhDQtlLMigBaF0Nv8BoqdsUcCfHXNoIPEaSsnUdS8+5D?=
 =?us-ascii?Q?07XIbJi7hGV1+Y/Vp2mOczNFi3hK3bq1dJsld3KwgqS1OkwO2vLKwbDttA7a?=
 =?us-ascii?Q?HyXceV9ROlfW05rsFWkpx8hhk4E2ihi4nbi3JCDjTivy1SpdevCglOAw5MEq?=
 =?us-ascii?Q?Nl3jfDCXVe31waCXDxK03XUnujBv7odSQOrv4e103aK1mcZ1y1ctM/RF77qN?=
 =?us-ascii?Q?648eP/bn0zzHkrmYeYobO3i0RXzotyeD6yXssxOqi5Gj4kaYyuDn89uAOt/K?=
 =?us-ascii?Q?N2DoPYO3RqgxdHWZLdQRLOjtydgaJHMeWo3dkYKFSS6AZSHeZuRP4Bsn9Pk8?=
 =?us-ascii?Q?NUg2kmp9wG2IfKz6N2nBqCLPrsW/60A2RCnUztSZ35WLrYUSrmxGkN9QNRAQ?=
 =?us-ascii?Q?lsUKu4Bl2yP4mkjiHH5sOMD9v+NWllTRM9rXLB0dgUos2FUv7j0Md5LyXJcd?=
 =?us-ascii?Q?a/lme1nh3sCMINOQhv7rcKk6iMstBtPuHXyN44RekNMWoWgtYR9AZluLW8gt?=
 =?us-ascii?Q?kWxwiwH9zTBLE+1kzCV+j2ZYKF3Dy0RNI1J2n2/prGtL08UbP5ajMDt97RbA?=
 =?us-ascii?Q?xbHC2/RW5RdlmIBSZ/V0HFH9co2uHmXtzevhZfC4WBU1gaWLbcdaQ0QkpayG?=
 =?us-ascii?Q?Ra5DLXsCjGRQnF6W3ZP5TBWItKVFLiB3Bbm0fxxtQwFRtdtbIfyTwMRsTWRB?=
 =?us-ascii?Q?Tg6uY8oZD0NuCcq3oZCjxSapLNnVCmvUjUQd4WAaY5Fp4USVVvJeI9/bAwAo?=
 =?us-ascii?Q?W+J5z2Pj8PVRj5yYwewug8kngwDWLvvxp6W1M5NuYr41e7KOidIuoM9QmFoV?=
 =?us-ascii?Q?yEoatVnHqATuppFvshycro6CnANB+majXu8AZFElb0/SQD/3J0JHh/cyPYJX?=
 =?us-ascii?Q?yJmJnrkqTYW77zQlBzsJpioHDmm0td+u0WTWi/NcCufHd7J4SqssgkSGLYzw?=
 =?us-ascii?Q?JFtCE/Qn0jQysUpazoTd+tkdUushzBqR5I3hxvISobkBH70jBqIGUZPtWBxt?=
 =?us-ascii?Q?EhKR+jfGhsZ6h9OBtD5mqWVtALryYVB9zJmCC3m/1m1Cwd4QBq9LoJNEh28R?=
 =?us-ascii?Q?XS1sytb3kjHjyTOhKcyWe48nvAnHfxpBtlhCV4iY10cgLgYLM16YWa19bkos?=
 =?us-ascii?Q?nX7EPig8RKnfFYfbma5Q9bsssKm1iqHiMUddykUtbqCOOMEt14irQV/hyc9m?=
 =?us-ascii?Q?VHqW2J9/qEGE5l3rIxf/IgnRJbahCKHJjelPySWFn025B32wYpYQTJNdnnNl?=
 =?us-ascii?Q?zBJYDbZ083kTFCH0f+NzhhXQjPpbRCiJZgOEThsnWqpFHrUOr8l/A3pcfLCw?=
 =?us-ascii?Q?LfoEPcy0PtnA1rn5UJW55rg3YAnVStqbgCc/nBpqlUc1K/D2jvIxjRjGeBQ9?=
 =?us-ascii?Q?Tj3i0qU4pUV9z4F7UEnTwun5Zxtszw9cbnLoI11zZ6XsS/fQ5amXUyz6Sjsz?=
 =?us-ascii?Q?XMRAUVK6TLpHGIYj7+fSvDBybbaoRGMEKn0Yhsm1xcKtw5J/D1FiOn+qrf8N?=
 =?us-ascii?Q?GONGbw4MzTjaU2O71Gs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035889c1-9a1d-4647-0027-08dd653da0ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 10:22:31.9095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nuv2kZs1GrU8cwfkq7plfHOzHy0ZHgo19cum9kKXgpcTgFeEc4pu4ddsJm+ReBJfcR3UTZ8eIF70RTGkQ6hcIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFC91BB56DC
X-Proofpoint-GUID: Z1vJYG9YJ70LRxJwFr9UYteaVN1KmpPz
X-Proofpoint-ORIG-GUID: Z1vJYG9YJ70LRxJwFr9UYteaVN1KmpPz
X-Authority-Analysis: v=2.4 cv=Mapsu4/f c=1 sm=1 tr=0 ts=67d7f7ea cx=c_pps
 a=FmV7mXqD6UovpQmy5PTGeA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=-AAbraWEqlQA:10 a=8rWy6zfcAAAA:8
 a=Ikd4Dj_1AAAA:8 a=kwJlfhEpvtK-lPX-SU0A:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
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

Hi,
> AAD offset in AES-GCM crypto test was calculated by adding
> 16-byte alignment after the IV, which is only needed in AES-CCM.

Agreed that CCM has a requirement for 16B alignment.
But for GCM, does it break any protocol? Can we not align to byte boundary =
for performance?
This is a performance application which mainly focus on getting the best th=
roughput.
Did you check if it is having some performance degradation?

>=20
> The patch correct the AAD offset calculation in AES-GCM algorithm tests.
>=20
> Fixes: 0b242422d385 ("app/crypto-perf: set AAD after the crypto operation=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  app/test-crypto-perf/cperf_ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cper=
f_ops.c
> index 6d5f510220..f9be51e17f 100644
> --- a/app/test-crypto-perf/cperf_ops.c
> +++ b/app/test-crypto-perf/cperf_ops.c
> @@ -688,7 +688,9 @@ cperf_set_ops_aead(struct rte_crypto_op **ops,
>  	uint16_t i;
>  	/* AAD is placed after the IV */
>  	uint16_t aad_offset =3D iv_offset +
> -			RTE_ALIGN_CEIL(test_vector->aead_iv.length, 16);
> +			((options->aead_algo =3D=3D RTE_CRYPTO_AEAD_AES_CCM)
> ?
> +			RTE_ALIGN_CEIL(test_vector->aead_iv.length, 16) :
> +			test_vector->aead_iv.length);
>=20
>  	for (i =3D 0; i < nb_ops; i++) {
>  		struct rte_crypto_sym_op *sym_op =3D ops[i]->sym;
> --
> 2.25.1

