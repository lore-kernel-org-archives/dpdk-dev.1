Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F2CCD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 845BC4025A;
	Sat, 20 Jun 2026 20:57:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B574140151;
 Sat, 20 Jun 2026 20:57:21 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KI9ORG2290292; Sat, 20 Jun 2026 11:57:20 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020127.outbound.protection.outlook.com [52.101.85.127])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7h8wyr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhtkTYoeFb3OA+uDpgAF8k/7YbIyDyEqMVSA5alJqhJcQqediOqX1rEt0o1juNP61qlHe08rmxGm9qI4iNq/hIMwFutHzcXcPhCNI5u5Jv6W75nWBK6xn2mgydrUcn1ITBtw8PRHYoE+ej3cAGc4uCzm2WhTBE95+zLUlPe4bz51VNEaHsTP7f/IDjibGyu1dRZIHcY2CjyGWIAj0DDsP4UMnDvsHUBBwbRcQXdtB+ST7ZYSSwBXyW9v49vljaOjDeYwk70eey4shw7t26pE0XMH5TzyPhwxbYqwp73Kcy+OtK/rO+MDXfRVAl674KvWYVjh5IfOh05aq6jWWHILnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGxIFy1AAMwpO43BzjOe5BMFd8B8CIW8Xh4Y0dp0hEs=;
 b=G1qQYG5Gej0QQZzJiyRaI+LFR+CU35KVMwHohM4xtLKNvLiriwAyq5ultPJODu7l2XTz6vrAvryKaBvzXQKsdr8IqYSxInj6hnYCoNuSzr/lzywk4e2YDxIwW9ccU3eR+ob5xU/LMu9YhxFgXSF6qm/VrqhBOO86ckeuvcZsuktNfWkz3Ayp0I6xZpxermkF5N/3I8Fm8XX/NA+ijCtPe97Cg602H68vuCM58z2FQgiNIo4/1c+uCmHYAQTkBZkQqn5IVAMlCrJK3x8INFotP9Z0cpaGA8QCuuqcHeV6ev9kWR9UsrPdEsqcy/gvWrLtdaHR/HanmGpAJRqVCm/p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGxIFy1AAMwpO43BzjOe5BMFd8B8CIW8Xh4Y0dp0hEs=;
 b=JAdE0V0r1OYfKwi+ek9sZFlzwFriE+veF1dPLQOTVItJxhgrNot7j3t4aRlPnHtYLkAj3zJPwqUWwTTOd9K6KRRjbWoMwXDn8AO6IIppXGinzgd5nXlnT9SD/7/kE/+1Add/W2p2rst+NKz0mHaHzh7IstavRE+ZFL4wqoXg/U0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF0F44C6CD2.namprd18.prod.outlook.com (2603:10b6:518:1::c86) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Sat, 20 Jun
 2026 18:57:17 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:57:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>, Radu Nicolau
 <radu.nicolau@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Nithin
 Kumar Dabilpuram <ndabilpuram@marvell.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>, dpdk stable <stable@dpdk.org>
Subject: RE: [PATCH] examples/ipsec-secgw: drop packets in poll mode
Thread-Topic: [PATCH] examples/ipsec-secgw: drop packets in poll mode
Thread-Index: AQHc8X9LtW05Yz9jQEWj8Lxiwla85rZH6fDA
Date: Sat, 20 Jun 2026 18:57:17 +0000
Message-ID: <CO6PR18MB4484A16FBA47B520ED416EA5D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260601042946.89719-1-rkudurumalla@marvell.com>
In-Reply-To: <20260601042946.89719-1-rkudurumalla@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF0F44C6CD2:EE_
x-ms-office365-filtering-correlation-id: 22f7027c-d351-4abe-adf2-08decefdbfee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|56012099006|6133799003|22082099003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 5FR/QZS5Cm+kKXWAeZqDmFBhfD9i5eJR+1dTA1o9aYPh0mbw1YM7z1Vh4oMkdGfWCchVI5qQ2AthCLL8KuIg8syCy7Ysj8wTfarVqR2SU47/uaubdsbpIECCekhkpONdYhLVOtOPqMsHkQ7lgIrH75pWoWxCH13SEGfzY4Cr8yhG2eX+8GLC98Upk+R3qJCyUxaPA+Wit5yGeRDNe9MRiTsQGn8emKt7dKllH3tZteWywjMGnIefdECySFpeuJWsuSYgiNj3S3oLR/ZjzawhFsXF5ThG9RvP3YUNCaeClV2xDWRgd0jcRSblBX/9yrVe2AFDkQndGLpEilHfT9ieuTuwsvMYz9kaR4CvF2uSgcaUV33gm0QBNWzPjnhyK1y9CpOgkGgDKsI9lDokW6u+wY+2eDEdea0FBqoxSSyXF9bEdyCmkRKn1FspbqL5+hPYn6M8Y6c/Mln9kL8owVuK9dw2YlrTJI85ZrkczONZJ33p9kDMRi/6WRqIsKIQz6+51NnF/hhprPGIbSoGFTcw3iOBdirb0EtMzvxLh7wBBIsXZ24hedTikr2OPYZvBvk6/4Frsa1/EpEHlofsvIy5maYaf1dzqrDGvp4GX9Ns8mIHWdpbfUf/733jWJSJUl/LocqZlAf+RyOQRT/GoTvLXu9q/7wdbXzFmZ9coA1Y0A5XY12l2WLwEdYdKOcZ34EqqRIXmhrplM6f3Bbpq16O9WFrgJeWy31Kx2j0Ztu7+6w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(6133799003)(22082099003)(11063799006)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6CCsnSGHYtK0qz0qMmTm3zKdMW3BRdye06E7T2s+jMTpQS3ehbFXkhqVwJoC?=
 =?us-ascii?Q?/2bToyLbnrdfDmy1GgjPiG0yDEH5aHMFnau5o1lg1X1wf3I6a4qmgkAJbWWb?=
 =?us-ascii?Q?VJKzO+mQPQbBRklxO5+daC8oOgxn4Y1RLrUUexRtvWt5byCrHtUxb1nqKi+e?=
 =?us-ascii?Q?iVX0qpfti29fyEGGgNaXDIDWUZxw6PaMxqQmg1vpNuG8zeAoTrNvN5MFptFI?=
 =?us-ascii?Q?0ALazR6LoZAT6Cb2HJsWfb1O4kHfjIPa/H7l+kk8yDBI2oF5pxDXDXckZOaM?=
 =?us-ascii?Q?qrZRLMVJvJ8mxlD5Kl5QH4Efz4VsbY0/2L5yacSHOHroN3xk0Ke1lDT7qRR7?=
 =?us-ascii?Q?xPPJhUu1ujPt01X0bmU1AHqeA5H3FcCYPChJwCtUd202kpYfAqHMWcluN8dY?=
 =?us-ascii?Q?LMEujipFcV8v5yWhSRBkoeXezHRyaMkZGq7FTSRkCHzT3hFt5gi3lNnrTcDs?=
 =?us-ascii?Q?sgBARMzlVcwD8szSIsyPrZG3qDwTmUgFM9anHjxY9XSashKhzVcdamL+JXYz?=
 =?us-ascii?Q?lnOzW9estC6P1VE3f5ws8IxjzmO/FKGd5cfX7mj1FlINHSAxJ7BNqYqU4oI1?=
 =?us-ascii?Q?YXhNZp7gIZ95hXf92jgz/97RnpOPBmbVzMK38CzNN8zNXhCMO4NNow8MBwhh?=
 =?us-ascii?Q?frIOZpxRI69U2xTlwZAun3cuUMw74Bqnc/nRSusG8UyZ9CV+OaSm3V219WOn?=
 =?us-ascii?Q?p8ykjWOm8mDRHAVV2iIQr4mSvLbZXfTNjttwo8NEs450oUXlEtVJf05dhyua?=
 =?us-ascii?Q?Kro5nVQkxQYTSOzIJpzGLi31b2K2KtjA5lcYXsF21H1gbv17JWvPW9Fx45hf?=
 =?us-ascii?Q?mRBi4XPyjDAsO/pCV55zSyL6OpXm2S5kV425kR3SFdeXnrvHAFVRLKVCUWBK?=
 =?us-ascii?Q?dZBWMYTZhGB2n6a5n6GhALDcyKlI/EtSHwDpsPrOkzziDwn0rgttqwJW4kel?=
 =?us-ascii?Q?Gty7n+7xjtnuyDCYyuYV0Pl0EJYnVRJdvJB/7JDhKDDvGFOKSzLIinqtG/PU?=
 =?us-ascii?Q?aFsjatO53CHGqJ1liLUxlCoZQSfpIZL9EqcJntg3RBJ+zxGjIry5dXyX4qC8?=
 =?us-ascii?Q?FQInkTHLIwE1ILALok/2FxnE0tVyhYCyiKdSrqfR514ZX++/jbyqymTwE+dE?=
 =?us-ascii?Q?AaIQWt26W2KkcTk1szCW1AIN0yLtlTxPEbnyPJzbuQYtdDcSparTuQnDG/ds?=
 =?us-ascii?Q?zWw6vmW7JTOTT1RiAGJrSPsgbgqkO3Dqp+4QObZMfEsLUkGuNGm7gv3M9I32?=
 =?us-ascii?Q?u/hNGu/5uC8wDH9b7Jjg/VxCSJiBhBVuP0Jkw4B6U5Lg6tLtpUudY1CtTRGs?=
 =?us-ascii?Q?3wUfoaKWJDxwDZ+KV7EefV+cFBSqp2Op3L1X1ft73+mpRxaxRVtcmFT6K7Ex?=
 =?us-ascii?Q?lldtME1ROfpc9d5MEQRgsyV1dWV6/uYjsImzXfR5aX8XtzWi6PJ8OSUa8mU2?=
 =?us-ascii?Q?ylut3ut0QolmxtTbYqgqd24NWMJ8MMxZoEqADpJ8+b9dt4HZV1qWS0/74HBs?=
 =?us-ascii?Q?WYjNEcIgh3YItJS6IfFv924fHLUnAim2z0JNbw2DeVtjAQz0pPqax3Hquv4T?=
 =?us-ascii?Q?9N2Qw7Gnk9a+Ik2G4fYV0Cbq8mc5QBYFfbyQ+XvNskJ6KlemGBvn9nFIsWTn?=
 =?us-ascii?Q?OqSmfKU5fwdw98vrVEjhY5Oc4dgNQobZnp9CqmaqnZhtqZmG1z7ANezigpXQ?=
 =?us-ascii?Q?oJUutCYSuJS/+hLWcS3z0hviYCCAmnBcdeFAu8wicpSvPDWV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YaPbVPjpKKD7+ONfXbYadOhIhLO7tTK49kBtRBcFjcl+eGIqUxiTyIT/y0zcG/pakEtBUjb6ICKlhWkNR+lTZ4MILEeF0xdW7V6z4FWHyPjpqQhnyNfJqC544c3KST9ONfX/q98ucPF28P4U/7pcpZ+K/kQdBJeo9A0H+kH84crFdyB6R4tuaFGwQw/mU8avgkafhm610wu/+yDHShc1QzsRauhyBilHX4XzPnNRVm1JT9GUjwWozIlRu+73fGbeJ6Entr3q54zrsgeBLU3RvQiBokfVhufB8UPDjv+quJrIGBGRwWKuw7/rmaqUJSt1y6eFtLZfdcwZ4cttSFtuTA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f7027c-d351-4abe-adf2-08decefdbfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:57:17.5104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxudG5zBpOny14yhmFosbA9eGNfQ89wBB8rK5cbsHsZtTFgtHQDD/6mKZun3F2dBU/asLF2zuhmexxn9T3pWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0F44C6CD2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE5MyBTYWx0ZWRfX44aQFX9rBLJ7
 bNPVjitUk6nxXx/2Q3xNa/QqYF4uvnx/SJ0uxImVv3j9q4ghS05byj+Un2h9vb8D+UJPyEECGE8
 L0gmSGhpUms2Q8hTvY725oSwMzun542w8zxGBQpH9YzRysuntHyfXZ8477X1+h8Zg1Cp32hh2Gs
 Ox8KV1xfosn3iYUxRPa6vnnAI1DsgmjyMXe2fMzLw5884O//StqyPyqElOJBRe6C+D1CrjtFucA
 /FATeG0o5bRLHmGotc26vEyIatHdI7HrSCXLjOVOUXPt0iJ68jNsfMEsqdmV7RpPzb9vo3jfE7E
 Znr71YaP1u7SzNpZ2iJvr16twqn5HjTqAS+l0BUk+9UGhJ5rDONWnaERUwC3LamGti8GjlvDfNj
 1PA4xICIhWoJztaf2wdKFhTKcwh6DuMajRaT/LVbus4r7mlol+fVRHM+brQv/SZTm7MDyedNKGx
 xp26gkI4nvuAryYE7ZA==
X-Proofpoint-ORIG-GUID: x2nkRzmsdtNCJsGS8m392c0aKWqXey3M
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a36e290 cx=c_pps
 a=PGzkYtW+Y2OQBedXY5L5Qw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=BnYZmnwE7SKic4qzTfQA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE5MyBTYWx0ZWRfX8S7I8nPba+GJ
 LNDq6dSc2PKpnNTVrVKYcGVxrne/fUSn2sKqYaDBVTeiacpUF8tZd4R1mV8htx93OXqJ0dLwNmm
 V8IVWlEV/w88kiYAzf5ljBh89m/Xr8o=
X-Proofpoint-GUID: x2nkRzmsdtNCJsGS8m392c0aKWqXey3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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

> Subject: [PATCH] examples/ipsec-secgw: drop packets in poll mode
>=20
> During antireplay test packets are forwarded despite
> errors in poll mode instead of dropping.This patch
> fixes the same.
>=20
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
    Fixes: dcbf9ad5fdf4 ("examples/ipsec-secgw: move fast path helper funct=
ions")
    Cc: stable@dpdk.org

Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
