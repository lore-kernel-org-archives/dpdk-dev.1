Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21866CF8548
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 07:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70E294026F;
	Thu, 20 Nov 2025 08:04:52 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
 by mails.dpdk.org (Postfix) with ESMTP id 8A08240262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:04:51 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+Cy5ITJqfnq17917Xqw7ea/Zx31LuYs2cBrvl7BZD67Ut+gb6tGRVOjhLsr0Adshf+hc1FqeJwYbGktpadQz3SWAD5CPfiNSdCt9WbZmrjEOfDHA549VoCduRacN4OjU56ckzN6DEdX1R7g9yTPLuw+6ninnUdZZAgNmHrgJTuBHC9bE0m2djW7i3n4JBYhRO7B9yrKf5cjLzvrgtohIsj264nRy//PJLz2ykWSoj7SEAq9E1oILqeECvNLZeVpVXstm9kz/pMRgf17kzSmcQ3zIeRnJ5egH4CeTCdnGFBqGMjJwmYz/sJd+G7N+6x1P0nujwCiDZlLn4nS0I08Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1JGpYoAicWiLHfRM1warCDCeodvPMlSf0xJfXoAiio=;
 b=LhA+QL7uQH6h9k80QH/cPSjRD3Jw56XavhkxUm17Ng9Z0UAn/2MOwte/40iJKqiFX6b5XESTdHy1ruU5D0r7PPLnqZjh/7jxvdsHOcqND660kXSfU8b/xrGc+1ZNMXX0bA/YhRwyJFCuUyzE4D8X0wuxEA1VoWrQVQVbBxRD42aX8Rcj0ytQ3ZU6zo100YBA00rvEuPrSLq9cnfmhXtdUNFurWwFDaUGQbrVdARCT1ukKNB9+2IoqldZoaXKbM9fy1KZl3E0yhV8R6pI32keWTDod7QATbT8aTvWEckvqkgi/mdOJqv7rWoKRedx3mDl8mk9rdjbT3PLwbZapLMbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1JGpYoAicWiLHfRM1warCDCeodvPMlSf0xJfXoAiio=;
 b=UFYQNCShCP9Fc2nSelJtZiZ1tDRAz88NBJwNLDJ9fRVw1X1OZi7dN/NcethwtJMiFJ9AyGqAIL4Ms0Jnv04l4l9kfQcBKko/ViXixgcY+ZnqrwUK+1JTdSR/C07e+lOlXGD0nUaI2Sz3X/gnWUmYIW6se6dsYCMWw/jC6fk8un2zJtT+vANBQahf8kaOFVow+i5jTRi28NZRF8P/dHiC8xAFsnASz9LXzOEhcVlkh94AIYarhY5Y9AYOg685fUrTVrULOCky+PRcoekU8wzNZ+AWTpScEaYC3/FB3Kr0nRA8S91KCo1M3uf9wH5gcy0jt6CCCGeivntuQWnDo1TuSw==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:04:49 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:04:49 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, Dimon
 Zhao <dimon.zhao@nebula-matrix.com>, Kyo Liu <kyo.liu@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: RE: [PATCH v5 12/18] vfio: cleanup and refactor
Thread-Topic: [PATCH v5 12/18] vfio: cleanup and refactor
Thread-Index: AQHcWUTkd4ntM96DS0KcMybygc0sybT7JTmA
Date: Thu, 20 Nov 2025 07:04:49 +0000
Message-ID: <PAXPR04MB932810886D9E4E6A8713574C89D4A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
 <ca0826fa3d5260e28771337f5e7a378ff1d13e1a.1763550470.git.anatoly.burakov@intel.com>
In-Reply-To: <ca0826fa3d5260e28771337f5e7a378ff1d13e1a.1763550470.git.anatoly.burakov@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|AM8PR04MB7809:EE_
x-ms-office365-filtering-correlation-id: 60a0616f-ca69-404e-e861-08de28031852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|19092799006|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?T5N0j2USUSqzGg9HFTCpus4vyTcIhRsc57ZgZV3jyyLwswHQ7w061sVM8Zg+?=
 =?us-ascii?Q?O7VSxZiWXyMQFPvtZ6SdQ9eNy89HTlTAxcpF9Ve4atJfoQcEfBNWYYaKQj06?=
 =?us-ascii?Q?FO+ODlsRKWCzxJD0B0qNrz38wPI1jaxtsfq/CuzHpnGBu/C4neaLB3y+gx8O?=
 =?us-ascii?Q?VZT0BwaQSWKH5sAp+5L1tvgO6rOzbG2jMC9vWQNLY2uwJEByWvZ9BiL7dzh3?=
 =?us-ascii?Q?oj6ijmnyUoXjP6cAQCrGB5dD/PD2UoRPPqEYlxkqNNf7zsVPEATw1+HqnIrD?=
 =?us-ascii?Q?9E4lb00k5MQXysTQhIU/VcxFd41S7h8CWxnQsnVFMNq+awBMySDYmSG9ya93?=
 =?us-ascii?Q?/INw74k4TKKFUYs3j0KnkLv6RkKmYXlbXSCYg5mH3GWy1NQBkUctJgNpg09T?=
 =?us-ascii?Q?VsQoPF/T9v+Pb6E/btnw6+Rv2zT81WjJIH3hoMS6v2QuYAL4LBRPxa4SwoL3?=
 =?us-ascii?Q?LYGRgXmFv4r+riKsg/rlxiwOuyfAhU1xkhqisRDcGAFG7HiaIhjDr9u9Rslq?=
 =?us-ascii?Q?7S8jB+5S6WkRbsO6kqW2nP0S9aYc2Y9Wm8RC7AF0kh6dvPVVpePpHYqdEp1W?=
 =?us-ascii?Q?+TjONhGKFNsLeMBoV+L4ln0obu+PZaCIbrDoUwSaOepaLrEBQZ/sL1i+FeeG?=
 =?us-ascii?Q?zNYhBH3U5Ii8A5bYLqAgXXwayhQ1vV4pv8LBUkBrYEb/QiYnBrjj13OdEmDk?=
 =?us-ascii?Q?/VqFZbf78foaRsydnuKlmrFCSwUMnETQKbJMqqSeXe1EDo7dtbMx7j5fFTve?=
 =?us-ascii?Q?wlRkWiypsxNn6pL/o4UQgjDy+TRs4pN8aWYfdtVVZe7Kurs6waRz9mn+HjGq?=
 =?us-ascii?Q?klYR/Q57rKVSvBLBHmYZXH3Qw7qy7H9ypEOClIkPq114DR9u1Ez+W2t8pHv1?=
 =?us-ascii?Q?7ihvK3Uu5HZ1iQJ8p20cLK2ARrm1q0UcK40PZmLRfXo3m4dvQbOVyL4DP6Cj?=
 =?us-ascii?Q?BgUhN5LXDnWpOlpsLMOYQCW5gcntKZ5u3hMqT4A5bz9ZAsbxBe0YPrf+dXsB?=
 =?us-ascii?Q?JDxCcA5gNRkFNT4Z2LpnOndoyfqRdH42Isgxe4/vrpZfpxd9iG/j+tU7DhcI?=
 =?us-ascii?Q?Fm7+umzqzJIo4dGWTA5b3K+fe/G2C+Q2XDR3WKZq6XqbC4814njsi+ZV0A3s?=
 =?us-ascii?Q?u6BOJbqz9bE9AzXqjSFGjemQdBDDC1lHtGfZQer3bBBbO6gd7dP5EEihLcBu?=
 =?us-ascii?Q?TTnPbA/DdvGU9XrM9qijNirJxGQIcov50mHqxQYS2OuoL4ZckZXGdWyqDnbZ?=
 =?us-ascii?Q?JFBEG9xiFIssDluBsAw0isJtxO6XLMcrWbH1LQKYmW2U7nvLSakn1s+Vdsgm?=
 =?us-ascii?Q?OC5SyffwiK5oS1ifTrrBiaanLoGYTmjN4IAsVKWMuVr8e7FIJXqBhhbYJmkp?=
 =?us-ascii?Q?WhR8ZI32Z+dUoCN+EmURQbTvx0muMDQxYws2kPl9t6tKIug55yfltWUSkdwn?=
 =?us-ascii?Q?8Ob52quGbCTCpnG73vG4AF3XZiawatTc4iEyEsisMlfHAKYguyJlopbcRcfK?=
 =?us-ascii?Q?CwPFK9mnANeoI7HZ6FbcfdA7VRO2u1Ggq/HE19swdndyx8vITF0yJ2Imyg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(19092799006)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cqXvhBe9kx+xnuCQwISGD30Kgn3UUW8dQJh/LNqizmUvaBjKm0grkTCr9SZd?=
 =?us-ascii?Q?Aaqgw8cPdAWYdyKbQ4iaPALWBbDqRzL2PQSlFRjYN3Z6IdTt4AWj49s8HIan?=
 =?us-ascii?Q?hRFwmRMHqYeZo2dllF/t9x3MPTwA1i0ndspNMGmckcTnF6tzqXt/J3P1NUgC?=
 =?us-ascii?Q?kNZWE3bNxQLXtbdueVMXToXiQZ2PHCVfKDr6vAjZxKSwuPHh93wlKUnoaRoR?=
 =?us-ascii?Q?MciQaukeku1sQz+yQZz8K0NTmBo4b/bMMJEWyUkodXgPZZgdh2wAf8qoqlgG?=
 =?us-ascii?Q?SKo5DMa2St0Uq+55CbIl/B6hrE6IeGaakyhuhjJYrjYmcdnRc5dDDFgTsex1?=
 =?us-ascii?Q?FFhDRsQDt7jxQAe4WVhCIvIlmV+QwakrGiRR/PAUYAwO3nQPVDrZU5D+QSe5?=
 =?us-ascii?Q?HtgWkBzAtgMfGYP5+AsYjVwnQHg1XBlN7FZty9OpIRWudAw9djPhnh4jsOtR?=
 =?us-ascii?Q?TZMN1BHIPV3ae/VmRlyqagqYPBTpwnxlsyBr4UniipnsXt3nc4ZQ/17MmPZy?=
 =?us-ascii?Q?/2Xue/c5WfbjYvm07o4VCEOCREXKer7nInBLsiWtmvTby8I0NrHUv0qsojDt?=
 =?us-ascii?Q?gfY46DheJH/jofD/RsTZj5One8+YTHnSAsNPtUtXfT5D/7BeI0oq2Yq2FNg1?=
 =?us-ascii?Q?qUQAUKnjko9TqVHnAj96lusoS0jGHmYGwux5Tnp6OgjbX7i0TxLE6RYYhBQG?=
 =?us-ascii?Q?l57ksp3CAD40s8bYE/cM0vKOg5Q214vDhNu4yr+q62puyGd2X2HWXZlhwMF1?=
 =?us-ascii?Q?mrHAXQmp+1yGP/q+exJSMkS3rE3/N199fzfmgBbp6tuDftfS5eoVjNVe16UR?=
 =?us-ascii?Q?lgORvcnHy3u5xmCXQztHisRO4hH62DQB1VsoqEJLut1atl6WE/fpHUAJk4k9?=
 =?us-ascii?Q?x7cKmT3oyvEwqmiWLjqqIho6poa+e28bgUkqwqECnGGgcOAXR0JjUwW7QSSo?=
 =?us-ascii?Q?BzaUMtZMnS/CyAg8bNxCHE0MYzSr02Da1uIPapAlqvqMMp6IZEr5k9W4Rag6?=
 =?us-ascii?Q?lC5BrvVRBmL6SDVKhzzDdzqbgqYULc8v4D6UGTwhjQQZuIvXxOaXD36rHYs1?=
 =?us-ascii?Q?Pyrbc9PhIEFAeD90mlzlKRCGqiLal1VXLcT46C0WnHgTc22EtMqSMu0AxHXy?=
 =?us-ascii?Q?jzm8sLjulyI8sBXEPMv7sDLROeTLCpfgfuwFL/jAkdx6t5s6BL5cFdcAEJvq?=
 =?us-ascii?Q?f1TqfKRWHnbmaR2aguq+fBn2w5pRYzYFexhztfY+qq+zaV2i5NCwwpRFSbxl?=
 =?us-ascii?Q?lQZXb2nAHJq8d7AgIsR8B7z7DuoIYC5FckHllJxZXZzun38vU4DNYEhTMnf5?=
 =?us-ascii?Q?rDLeOl+b3Tp+KS+/SrfarDxSOOw/GkR0wYdP95InMZCql777ZfQEUWBK8gop?=
 =?us-ascii?Q?rJFBhstpba/gwu/QEXbq7PApKyV6gNdZmf69hguXEDMw4DSKszCk4RpL4gdl?=
 =?us-ascii?Q?N6kAiOOLiyFclBDlWhGhnXv62mRILxaPPdxAuyOsIyHgsGaBySeO9CDv6O6+?=
 =?us-ascii?Q?jsSKS+SNpvnKCnNHQvFRXWx6TiavY+uQ2pr5xqmhT0Vt6hkAplw5qjA5+SNB?=
 =?us-ascii?Q?VbPQiwVXa9Ay6jqditKR09I5Ps0gXZqEPugH54Ml?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a0616f-ca69-404e-e861-08de28031852
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:04:49.1034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLxjOv/ANpXEJbn6+iAwpjsGDgLYpgiz0LGuD4FQS+zqDN5cd6U3JCnnYvRXrpaCLHPdCWzSCUqXApWTKVJjcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
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

> diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfi=
o.c
> index 550d4e0e8d..4b11b38322 100644
> --- a/drivers/bus/fslmc/fslmc_vfio.c
> +++ b/drivers/bus/fslmc/fslmc_vfio.c
> @@ -364,9 +364,9 @@ fslmc_get_group_id(const char *group_name,
>  	/* get group number */
>  	ret =3D rte_vfio_get_group_num(SYSFS_FSL_MC_DEVICES,
>  			group_name, groupid);
> -	if (ret <=3D 0) {
> +	if (ret < 0) {
>  		DPAA2_BUS_ERR("Find %s IOMMU group", group_name);
> -		if (ret < 0)
> +		if (rte_errno !=3D ENODEV)
>  			return ret;
>=20
>  		return -EIO;
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
