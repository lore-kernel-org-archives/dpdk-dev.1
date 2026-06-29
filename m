Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E319C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 06:42:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F74340299;
	Mon, 29 Jun 2026 08:42:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3EEA34021F;
 Mon, 29 Jun 2026 08:42:23 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2dahm744692; Sun, 28 Jun 2026 23:42:22 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022120.outbound.protection.outlook.com
 [40.107.200.120])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2y98j666-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 28 Jun 2026 23:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxM2WbkalNOxtqBGBJ3uCL0GJnEdw0HV0+6CKxbWFoAOi5aJ+7DZ8kOZ4F+oH5/TwCWi1GJgCeHXMcK58CjTrPCbJN0jxeAGsecucK7+8WErgfVY2NQv0zzcb15UGimK99ySkIahavakx71zQOkfPMjajTKaUqlMp0tIgGeIhdhPV37RdM0sC+pB7UmM/0hqLY0YkMFxEF21A/8+oe3t2VajMCKH34hTrYkn0N1mh5PJe/K+Ug682D+jQtvitkwA8e7u57vpdBCz01PokrvVKYR+XEciERAbYCTOx9hvEVKxIu+IOKg+K/ZnHIYrYGzZZyHLIAfH3cuMTuONsHevQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLX0Ake5O1CkoFaF528b/Lc7E7JVWtTkFYJtJC6B4EE=;
 b=foJvGQpfZwmoVf5Lt7qbAaD5fIkLZ9H1T7Q4azr/E/b6cmu2kS/EkGox064cDze1NaCOP3z/OcXbpdzs7p3V3lj8x2Pz8QyiTt5do7xYT36wjFJtqEfjSaTfxIiwfl+z2fAnf6jTCCy1VStQ9mf0HVEb0/OhDQ3UHynGhiRuu4+7J9wJK028VsS+cnN/nfgEMUxRokjso9juYR3RyKIhJik2uIyT7uSMlrs865nJP2R/Y2Pnfs2CjLpHFfYTnBEFknWwd7wQD0+3olR4gDZivMHyW2DAV+fRiCfye7zMGOOMzFxRuYgmupyLtuhZ25+zWgXuORRLf+zsLGqhxUBIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLX0Ake5O1CkoFaF528b/Lc7E7JVWtTkFYJtJC6B4EE=;
 b=RtV2CcRK+zhwCZVU0wiyb9AqAjPPblBVtLIT8bBd+osTxutIuc8l1BcrldE7rrGXwYYYg131Cjy7DBHv8qVEwraIiNf4Za2BeZdDiwxmGJ0mCIU+owZJspxy/OlTnLkdXcgDCGkKQwuR18378NgleHt3UXGTrm6ieg7/9jRfAR4=
Received: from PH7PR18MB5177.namprd18.prod.outlook.com (2603:10b6:510:156::9)
 by CO6PR18MB4420.namprd18.prod.outlook.com (2603:10b6:303:139::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 06:42:20 +0000
Received: from PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8]) by PH7PR18MB5177.namprd18.prod.outlook.com
 ([fe80::2781:49f8:1d96:14d8%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 06:42:19 +0000
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH 5/5] crypto/cnxk: use timing-safe digest
 comparison
Thread-Topic: [EXTERNAL] [PATCH 5/5] crypto/cnxk: use timing-safe digest
 comparison
Thread-Index: AQHdBLwRjWxKsvjBTUmaWT2YW9/AKbZVGpow
Date: Mon, 29 Jun 2026 06:42:19 +0000
Message-ID: <PH7PR18MB51771826FC266C92BFABA85FA8E82@PH7PR18MB5177.namprd18.prod.outlook.com>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260625160200.24170-6-stephen@networkplumber.org>
In-Reply-To: <20260625160200.24170-6-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5177:EE_|CO6PR18MB4420:EE_
x-ms-office365-filtering-correlation-id: 4301353d-0e79-4656-6e55-08ded5a99128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 9ipOLhj1vQLOdNgBVPtY78uJAn+wo8B7YGBbElVsN0XqAqOzr5spLwGSKZaVLpVS9w+XdUGLO3OZ+Ad9H00vyuG57vS+CEFqem9DiWaNwG6xKrxhYO9YOjJkKoFKgwT/dO2cULnSPm1G6/lBtgf2cewcc3p20DIjywTtPdG/FuIuheqfjlZsW+9D9PXWCkrs7QO1X2rTqtRKjhggmsXL2Qy0Y5XJgNSPmOq+m4Fr3tZq9dgOkz3cuL4Zg2fwTtGUIF3nZv8tnscg6ZHL7CY8TF5Bn3xM7hDccbhRQLWSB6W4+4Uy7oBcfOj9Y3Zj+HQKsppK+DnJepcfaqouCSEqXSny+ywOxGhvePpj+pvVaqseYUt6ZeaxfHU8iKloomD/ME6wKGAoCY/2vnBC1fQDgUJFWHVnGf31+fzodumAFpxuNngZmsBOQz/4Yzz9kT8BmH2rdHmD4Bsa7OkPklLvnDvW6v6JfVfwDcxhfQdN+av1JdjChG0ZUm+OMjZUNCPWNWADJxF5uRHedhodxx6F2xHiDbzDBzsrIf5OO6TF/J2ptHnHeKEBt11eTdSZSO0U+6bOGuuZLc6gzZlsfI0+BalJXKDAF4JovlrqkVREx10m5VADm3LKQE1gupKipbgQ0JeR8EK2k+WvaKb1lQDUpDBxDfn6A0Atls6V6pQJcLaeol47vz1wLwMcmqbgHoGyM6jMZbBFzBe3N6TrsyRaDYmv/nSjsgf7tPnUl3penV0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5177.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5znYPlUsLC857L93xwZV2wDZKvCGWsyWkSNLo95TDod8DpbGeHTzCXmz2US7?=
 =?us-ascii?Q?/t+CObbPKw9QFm9tf7UvuK+8HkXHkexhUp5FPKGjrQ64fGqn7PsAPbzp5tbI?=
 =?us-ascii?Q?GCXeI+ytEeHq5xE3586s3IwSgLYfw4BUDJqGAhaDt3fFgEaDKfLE5+ZCz+/n?=
 =?us-ascii?Q?qptundoduJQ2huTmoQ85cnoKnA8k+AnZilbRFtoYfN+AQHgzXH+dCJC2m+UZ?=
 =?us-ascii?Q?moHDEVs0sAM2R9npFW7l6kQ1rRRR+aV7J3O5lzGp3/jWfPWPaTlNJqtNqUHv?=
 =?us-ascii?Q?Jmz9NcgQlFBAD+GRYbpsuyikmgl4sq6DDw9YPWK8/ryxwkfRbLWaOBNLVs0J?=
 =?us-ascii?Q?MO8/PXfyXv1XlXmu4I0lwDBBRfvedU1gi0Kuo+hc013Y9av7c++F0swsTPLT?=
 =?us-ascii?Q?ACJ7zftaY9ELhgTwWhV9LH/XQvZdMlYvzfxKY7RKPw9su1x9pk5kf+TgV09t?=
 =?us-ascii?Q?/UmP4yc14BV+n+bSkc9T0VaiHEB8KnxdolPS4NnW6yaJQ5pLQo1hoypGaT/A?=
 =?us-ascii?Q?L77n5InDhzV7XFaYhB1wHvtQ/1agbECqLjbK0Mzhwu1nX5Y2GLeWU9WzEUOQ?=
 =?us-ascii?Q?R6ZTJAoEKMQePEjWcNIoxVHy2g1kWnN7RFkL1FoAUCJ8vwwuKowOypAeXOls?=
 =?us-ascii?Q?l3I9zq+Mj4O6nlO1/s6/KiwvKCecqvRWV6b+kbMaReSm1tmh6fKaYZC9Y3f2?=
 =?us-ascii?Q?cvOubuPhf1ZljEWf4TnPKMiGVoPdK1qE9iPFJ8GzPfBn3BasCtmLkN+G/46U?=
 =?us-ascii?Q?caR0oT5spttVek7f94ZiDp6t4xggnzNcKm+EAlM3FdDAm8EutSPy2FxkItQS?=
 =?us-ascii?Q?bkHdp9GAjlMA9Gl/uXenE6gRDdMapd72cdPU1KNsIVnAD+cWEc8hXtixJm/w?=
 =?us-ascii?Q?IdGPPDsD7T6QlxEcAv8ubKn3/Gd2BHYmDLVkESvQQOIPZfxeaweiYVfWzPSj?=
 =?us-ascii?Q?nTHdZeArYJxumHGEcTjz9aZT9H9y1oSfiy/+otML+9dOw98y6vLBnBRTB5fm?=
 =?us-ascii?Q?nCkcCdwiY1mZZdTyN+NusOUVUKIBC3Cg2x7bsGWo4RYeYB1wngaAO4ZRFy0b?=
 =?us-ascii?Q?gNpXS5OFimuNMORHG3Vqlo2qV8ns6PBKPwj/2MqxpCUJixZKhs4CB4uBZ9F3?=
 =?us-ascii?Q?oyXnw+kBRSdQXLl3+RMzU01ybewsT7pNOAsE+weqBbDoGyOiysTOCSz3LAEN?=
 =?us-ascii?Q?VSb1j26qh8APpQlzqAml7Ad2OUM2ZBQzthP7CyCYk1lbqtytk4Vul26/Z8KL?=
 =?us-ascii?Q?jIYTZFEYSbADhFUNp260LWL6I4g7RvrHi1NXgp0Gx7KEsFYJpLyUl8J12vH2?=
 =?us-ascii?Q?wmhjSgLXlL8ydPbIZ/6C6jLsUG8iPlQ55QjKoqT8fHQZJEbQ1XNNivkfhG/k?=
 =?us-ascii?Q?S1eY90CGJxufGaYe7j2tzwdvdidR2qwT+jJF8M5Bc6eodEhWRLhjDB111oyh?=
 =?us-ascii?Q?xBqlAogAGtSljXhV3QTFgziZbt+/jT2YflraNh9YnwyiCjN2WJ1smFBIKOjE?=
 =?us-ascii?Q?nV0GrSSmGV3gN6Wqr/FGFoCOa1HAmcMxzf9UpT7nLWSfCOs6h1jgEXmb5jii?=
 =?us-ascii?Q?Rf+H15LfVUTrGkGdfnHeEb5y8MctqjAgO3zwLHHV7A3N7n3cUMj7zxiys2yh?=
 =?us-ascii?Q?bb/cs/hoS39x55DHvNTdkk6JRFtMQtcfYcUf8t/RJy1K0aDHI1F5Fe0i1D+F?=
 =?us-ascii?Q?pQuywHsN1C6YegpmOtjvBwWS8695VhYl0kAZmMdWAw3oKbdQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IcdKfZgNJZOGnBL+NNrQ3DB/j5R/kr/1hEfaSxrNHPsvh53+zM8Mt5/ei6kG3aEEt/g7bH1mXd4qkVc6FOLfGtR9za9LfOArGydpfI9ZSKSc3Y8017ujpYSQ4UwPoceNLnKY6GF1YHu8vDvnvfjQM3wlxu3mszL6vqJ75HLCbBVh3ZgiKfnqxNZsA/6LtFCMSUtIfqCOiL7yBr62Vbugb86qww8GpU91rWz9La3/izSFdoPVO5yAmhcwv/gxUWchb9xj+qaoTmvwke6Issu5vDU09Qi25UZa0yc3P1m0Em/AmQoG7ANjoOI66CJ7dRmYI8ddBEzR7xR9eG5IWBV8jQ==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5177.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4301353d-0e79-4656-6e55-08ded5a99128
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 06:42:19.4201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZylybvicQJuSPcCJu3YyiVpdDkDqgsfP6WFozeOMjqfA0rUQo6DiFh7mjb128Qvt/6rjeFtyKyQtjPVaZaEA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4420
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=6a4213ce cx=c_pps
 a=3SCk7X9PwWHtu4c5+rqWlQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=YYLevoB7ecaSIo6S508A:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=3Sh2lD0sZASs_lUdrUhf:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: P2qHvmoKQB3cEjgrSNCKHeO9xVIbcsFy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1NSBTYWx0ZWRfX4KIle7TYEsnl
 4v9eW4g6Qphxd5dLXr3N4C0XWOVLCGjbGElSa/9Rht14yg7K3+5R+WCTn7N8a4rVLBPaejYXHEU
 WeulQicL9pC8Pyl4gyyup4ZcDC0Ng5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1NSBTYWx0ZWRfX+wqBBciTe7wm
 KUPzxqxh3P9T7gURGdErC2ZgO4HER+YNedMZQUoqgP2K+4+a1QxZMOb1AsfkODWi4T7Ale2gS3E
 SMIJJvhDVdsmh02PY/alSI10+8zeCrW9cLDdGybCy1SFvyz4OLhn+tZjFLVErHHSokJpx4Bph88
 cNXx3E0CuhlVOxNl0nzeZDzHlLULhwpKc7xivvdsUytmPpsTvffVIP6jyyZHv6xN3yYj0U3SCCX
 yvssfy62g6NuwEQiyD0qEeh6uL6pORz7gCPX6JmEl6YNbgnGlkil3j9/EERsMyTKzBLrzSG0rs4
 Y/yXJTAhHjdz9OzGsX0ORGylHi63oPAfX3d3XVQpBLC2OLCJSocbN47QM348DH9ndu1Juc9MidD
 ybMB+mL/G9H2sFwZvNSNo2OiFItdGDpmkErRSkk+FPtjbbh76IHocidO+fa96fPHv/xF+WtQ0li
 9y6OK3ucWOy9Nsd8epA==
X-Proofpoint-ORIG-GUID: P2qHvmoKQB3cEjgrSNCKHeO9xVIbcsFy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
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

Acked-by: Tejasree Kondoj <ktejasree@marvell.com>

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, June 25, 2026 9:27 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; stable@dpdk.org
> Subject: [EXTERNAL] [PATCH 5/5] crypto/cnxk: use timing-safe digest
> comparison
>=20
> compl_auth_verify() compared the generated and received MAC with
> memcmp(), which returns early on the first differing byte and leaks the
> number of matching leading bytes through timing.
>=20
> Use rte_memeq_timingsafe() for the verify comparison.
>=20
> Bugzilla ID: 1773
> Fixes: 786963fdcf3e ("crypto/cnxk: add digest support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/crypto/cnxk/cnxk_se.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.=
h
> index 8dbf3e73c7..d2306a9daf 100644
> --- a/drivers/crypto/cnxk/cnxk_se.h
> +++ b/drivers/crypto/cnxk/cnxk_se.h
> @@ -3282,7 +3282,7 @@ compl_auth_verify(struct rte_crypto_op *op,
> uint8_t *gen_mac, uint64_t mac_len)
>  		return;
>  	}
>=20
> -	if (memcmp(mac, gen_mac, mac_len))
> +	if (!rte_memeq_timingsafe(mac, gen_mac, mac_len))
>  		op->status =3D RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
>  	else
>  		op->status =3D RTE_CRYPTO_OP_STATUS_SUCCESS;
> --
> 2.53.0

