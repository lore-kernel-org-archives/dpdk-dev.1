Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B3EC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 07:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBC634067D;
	Fri,  7 Aug 2026 09:05:39 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
 by mails.dpdk.org (Postfix) with ESMTP id 1CE94402B6
 for <dev@dpdk.org>; Fri,  7 Aug 2026 09:05:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH4qYQtXZDzWLVpyHVbB1L3xbWlc0blr5jkN52QrI+mIN9Kjdkyt4+EaBzAT5wIUR/lh+vqcbpsw65vBNAKif7hSPxlrRQDbeKfbe3q4nodMJWxJ268MLaJKoLwMCEm4vQWPQF+/QwAujotBA65QykXmsfbIWbYP8XOcdaNdsQ9WCK4tIUYtUPX+KwHpJ3G0lbyF7ALMqjbIuPI0/urpIvjvrbdkA9iXim/ncAUPeNynOmt9/T2VTI5BNmWS4CTLjLAk36L8DmT90UzP+WESdHIB3/DtSnDF2fjr31i9C3x4HfuyU9//B/jloIoM8Hc94XqjF9l/HeI9JnOfTLKWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/jq0JRU4mrQBmB2qwWFKKP2t5Nj4vXAXu0yRI8Ds34=;
 b=rsC85e3fnofVqo1X4rjCLU3AwfCtAa9yy9A713Xgmy6AfOAOPWoRXjYOtgfsmuzPzMVzNQWOWkDEEtHCnRAITLztAHEiZHCN/550KJLGMpKkFLOVQGRX5lS9KulBbYcBHhbYBg6tm0X69EC77WrkXiDtUm+62xrJyMiLiWA6BoBZZB354lw0/X6pqff8+BWPYprXKwFvoO7XUZTUQ34NPI/s2DYxoMGnO6wifY4dzSWzy4dB+YSMIf/U8TjWiL+JHQtNqphx72yxA1Jou4uZar/DEePUcSxCUvrwm9r48SUYwfCAYaSmsrxOsGGBgY1dOZ2UUgLL5eE69Lx2jof7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/jq0JRU4mrQBmB2qwWFKKP2t5Nj4vXAXu0yRI8Ds34=;
 b=dcxGTZQvX7wsnLF3oHuos/obt8Mzg9kQN4yWcyMr80PpaRzutFzos1km00nJ4htR68/WhgDHhpT45rnmQJ1SfkI0AxvuHbrpS5ciq1sOIiDSxXuH4DORVLCjhGxULJz2yd9Uk930JS3JSNqlRgOgj6ip2JVcwqTYWzZNngpHJtacE1dJlsRI0/2l8vnOv/jFth9Ux3TlEQYWZqAcZoxusnAvNUbaVt8gNwQO0VKP57pVTIoI1QDFDFNcnZT7jIXR6tnxTYDrI+8NI1O1eD9hpiajRGAtvG5wacFrKAOTUYBIby0oJ6BrljjphZj44j5NeJDUWmaLctmUcLQTHZX32A==
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 (2603:10a6:20b:725::21) by DU2PR04MB8632.eurprd04.prod.outlook.com
 (2603:10a6:10:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 07:05:36 +0000
Received: from AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf]) by AMBPR04MB12281.eurprd04.prod.outlook.com
 ([fe80::7fd7:1292:c69b:6cf%4]) with mapi id 15.21.0292.021; Fri, 7 Aug 2026
 07:05:36 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Prashant Gupta <prashant.gupta_3@nxp.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH 4/4] dma/imx_edma5: add statistics and dump
Thread-Topic: [PATCH 4/4] dma/imx_edma5: add statistics and dump
Thread-Index: AQHdJX+f4j/chj6nAUqHNaZxAO7uU7aRNEkAgAD207A=
Date: Fri, 7 Aug 2026 07:05:36 +0000
Message-ID: <AMBPR04MB1228121D2D6692DF0A870A03AE1D12@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
 <20260806084245.561305-5-g.singh@nxp.com>
 <20260806092132.59cfd375@phoenix.local>
In-Reply-To: <20260806092132.59cfd375@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR04MB12281:EE_|DU2PR04MB8632:EE_
x-ms-office365-filtering-correlation-id: f1c0de96-c71e-48a2-b857-08def4524826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|18002099003|22082099003|38070700021|6133799003|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: zVBmq9jpss/Kgk+8usJPkPOEact25jT4zbluXW6iyECwcIT2SavgycVF0nfIPgg3ve1c3ihrp+TmSVLBJkXqVAhVCrhHPjemE+CLuxp7Jhq483dd5u9mNWLTkc93OR6bdpV3exaJ/Hui+HDsGvwWULzIoZsxwOv6FK8Hs7nlimImQaudaZiiDtvyhWZLdaBYmPsJWxLAblWH/KG4VQFI6duuqx8z4vv3npawnQyCs4sEXmAnh3D9cqkpxmIdbujSOJH7cKI6HXlEYXXKa+KETaQdw0uKaZBnd63A4w1sYVskRXl6YfwkD+rPBJSkTT+ryFUGOtuDZVo+qhx63mLp6mVyS+KZgNCZI/x+/J1CY70NdMUGvFrZJd80/gO7qf0CeMh1O+mcbZHOS38Rsi/cF+vJQxLSk+H7ZECE764fZzHuL3cD8Zswc9mAr6btgdEfvjQghByEg7c1CYs7vHBEFir2DTtrov3aJkg2xB8I4HAgU1QdZUwvLwJ7o+f+xKNRqNy3OaQSyc+hph18yExBr71Dl9yXbrM18O9Jffv3vssRiCKKNQdi2lEAK7HtVmL6b6r3v5PmRvZ1XfD0ycQb7bDGdixbPDYQMcCp5wDMzKOH8Hj3sP51CVFMcStyoArZIdvy6We/+s2QAoSmMBsZXuuIIelu6wKoHRx4vcPLqH4U//4itu5ke2YeFL1FRR+k2FrhPWFSLcgwOSUGRyj9bJYk8QIwVYllaZ6MK9pSAoM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR04MB12281.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(18002099003)(22082099003)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KAIVVYSiiHFP9ZsBWA8nyV3eKFx2sr5ojR6imtemc++3AkcQ5XBR3FS+DVfY?=
 =?us-ascii?Q?IGnbZTktVFpZkxvcj4Q+eT+R8sLF2sW1jRPCqNFlNtaA/q4bFDulz2DBivfA?=
 =?us-ascii?Q?2XLt7qpJpjd+HK41JKPhgYk8v8LZFfYOP/fg8pwKNdcStPQ1Olj2IBShuHpI?=
 =?us-ascii?Q?3GkUPaGULnX+0lp/SwnlW+G74I1EFTgkXnjXZs862sFC33E92L/ABxIywqb7?=
 =?us-ascii?Q?8GZm5DjWQH9wVSTveJ/YuFyFaUyY7NKpwtr6X4lduWukjvHTL8iHlilRK4D4?=
 =?us-ascii?Q?3TdHnndxLx0/UjcGDs1LtU5c6wnBQtfP2wPm9nfhdDFFypMjWXhUGhOf6L0U?=
 =?us-ascii?Q?J7CEARxQZ+D2PnJvB6+qv4cEZYjyPJVBuTp/xDxx8lgr3Do24xxkOkcEcLOs?=
 =?us-ascii?Q?0f7bqHylUKv6ztVA17AyrP/8Clmdy/hLYqeqwEFN4NDHzKP30r2F3DGJO/hK?=
 =?us-ascii?Q?t7Rp359FjLMTbyPGPBWH3bULm44HGy2hodQhgkQfkI4m2YfEjIX/pgm6OlRV?=
 =?us-ascii?Q?+ZQ/kQx1Q2UOrlsMOSmXP1aW7cnKMIGwT2TdNEl+BOCfI9LQ7pmTAYgvGE+d?=
 =?us-ascii?Q?2KaXPZSVkXLso52jkGOdNhDX7OQduAyiiaAgs8x3D3MJbisC1ywHN7BLOdkb?=
 =?us-ascii?Q?MYSRq2Ab1qf7QQ0s5vPnG3ANDczoLALAu9Zknt+p25y3yI7zg4nHQpKIX075?=
 =?us-ascii?Q?lyIb7SrQJUcegx7LfpFFdGE41ajou0lc2aKSUWjCQiSF/HdDwqGR5fOUMDNk?=
 =?us-ascii?Q?5UbEZM0kU8zGHQWEsCk/sMkhe4H6UraLq2BOr9b1pGeQ7oy6xnzl0RfmVc66?=
 =?us-ascii?Q?PzLE0df6AR9Ksk3LUvZ0bLkw26u6ylglqSfF2s9mquWpjbu8clNu0fcSWyns?=
 =?us-ascii?Q?jgMD75KLIU1ds9VuAHmTsgpCT+TJ08ddbYXkPTDmmg8kRKUjIbb/lKTQHxhd?=
 =?us-ascii?Q?stUaJsG0SP1G79Zo/hhl7yLvuYEqkwC8OgDO6dPeDWnzBByjDcg/dGkb348/?=
 =?us-ascii?Q?KqVMBLKZJTMHy0vc5+OPZqkNaj2HgY60ez/jMoie+Ajy/8z0NaearqPKbUHk?=
 =?us-ascii?Q?noX24r9SOycxO4OPDDyLMQ+NB16amQyi1eE5DVk7yl/gPb5C0H4qQCoCTgHz?=
 =?us-ascii?Q?J0Mv0ywGmit8ZCt1HQK+2ET66gEm+T4i63omv3ELt1dgSTvMCnZu2JUEwc/Q?=
 =?us-ascii?Q?ZijmQHG/D/LMmodiXKwFguUSu/QDQ2GAoaN1vnFx4v6S9/nBZcwWFC3l2D2o?=
 =?us-ascii?Q?5lOkWHjHdzQqFBQKwpKauBNu0Bqj0e4KzbzJWciTzrgAeKDL7wmuLDTV/ZYb?=
 =?us-ascii?Q?HzIK4co/QCNFN3xTRR6KYwwEht3YfbB0Ibm09sXP7PYuZefktLFNnzIbPP2w?=
 =?us-ascii?Q?bbwTJAXd2c6oY0ks7SqcWy4H+Vem2kP/0aC4WkaWmjCXMl5gJ3ISEfTogEg7?=
 =?us-ascii?Q?aNViHHsnqKUFpXy7HM4s68TZPzPUISD0lMV28A8aIxnzLihotQaZWnCWo8LM?=
 =?us-ascii?Q?19/Oik6FP/OfT6ej1PAXAlcYIHC6DYmi0jwr6tR2AWibOi9vv9quTtpGDMsa?=
 =?us-ascii?Q?Dz0Bfi476jshC5V2DN5d56JgD/z42+k/BACL/XLECofF9jPI5jIdCVSrOV5r?=
 =?us-ascii?Q?lcXi9kUj6tRjqOBPmTpNDxqooGKjE0+2DoTOJNZ1wwY6hCVvpsJNTQkp7rqb?=
 =?us-ascii?Q?8GbB7Ep2vRnY0pKrvFm/oaoMPOX7OeCsrlsmftHswMtDc97P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12281.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c0de96-c71e-48a2-b857-08def4524826
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 07:05:36.8026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gSKmzB4XeS12KsaCMmSZYTHxRbxD5szkYsZBU1+IyXFbf4DxAs1k8zoZ61qJUxEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8632
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
> Sent: Thursday, August 6, 2026 9:52 PM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Prashant Gupta <prashant.gupta_3@nxp.com>; Hemant
> Agrawal <hemant.agrawal@nxp.com>
> Subject: Re: [PATCH 4/4] dma/imx_edma5: add statistics and dump
>=20
> On Thu,  6 Aug 2026 14:12:45 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > +	(void)fprintf(f, "  imx_edma5 nb_channels=3D%u nb_vchans=3D%u\n",
> > +		      ed->nb_channels, ed->nb_vchans);
>=20
> Please don't use this style with extra (void) casts.

I missed it in v2, I will send the update in v3.
