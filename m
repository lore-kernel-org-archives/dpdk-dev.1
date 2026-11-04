Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22A606A32D
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=X9otXEYj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49BD74025A;
	Wed,  4 Nov 2026 11:18:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A41340151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 11:18:03 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A49I7Op2941994 for <dev@dpdk.org>; Wed, 4 Nov 2026 02:18:02 -0800
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023132.outbound.protection.outlook.com
 [40.93.196.132])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hr1y086xu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 04 Nov 2026 02:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njULVEJxHhzRs6RGytI9g5wTypy4MOm7PjrlLb7U9uNfELekFkRkWZ8XddH1fvLfYNQlmGb7clTHwemXC0eSTxlilY1M6mEFpH7oAyaIp+ickIceKf39Q/V1faZD7JJbBXUT3y4KNeyDdl2W/XO9t/7/WUg3evpe6Jf3xqyO9DS4ZZjWVPx523zE8FoZS6khrj+Z2WBnuLuSpxy0wBVnEqNPvthjR3uus7cLvFH830mLGUbFXX47rTKLQ/Pv25YAsNJ2YGvpA106toMep2/WaSsXUahyTLmx1jWCRIZcev/nRDp8oJnzyVTwK0QXnZ0Y7brcFdg4uZbgQxV3Yc8LCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF4mimrKKiehy7hxd0VFaZYzfefeNIbMvYA+z2ZIpfk=;
 b=Zk8RW9Ery6P2Puw5KRDwihHMj2RUhtEkvSZfsBV9Y21LVOsMksKH6Dp0jQDIOD6e24vHTtEQuXFzJQl9v2pC79e8SjwE6zIZ3F4WTLUm24xKaYbEu2KjOJtu14eIcCxlXiixzTqwc1mCtzWEJWOZhs3kXPWOH5nd+7IbiaijcPahRlX2+sVRfT30UCgB34K7GBbx7WnTrnUaQkgEte8WiDJ8qo1tL/jKHLci/UZeAiJNhKnn4kPjxgMJjgs3VansjAP7AcXpCRu8bSlSmOp5rs75lUeZsg+DcNwd8BEd1ApMg894iButqmjgcmtGnp9UiC2SWsjqXqiJ8c08VWOdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF4mimrKKiehy7hxd0VFaZYzfefeNIbMvYA+z2ZIpfk=;
 b=X9otXEYjYwK7dctm87PvPu+2/H/pCHsexhKQmaoGgNq2xKMoG4bAu5Da/6Y79TGuzL9aqkLWIMbPAlfO/SKwaYNxE7LL6Zl4zP31LfUIVv200J6GDVAYN5/juqqkxFsr8vFA9sSQrV0JgTxwj3+XGuJJCmSxeOA6irkeiMgvSNs=
Received: from MW5PR18MB5176.namprd18.prod.outlook.com (2603:10b6:303:1ca::8)
 by SA1PR18MB5903.namprd18.prod.outlook.com (2603:10b6:806:3ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 10:18:00 +0000
Received: from MW5PR18MB5176.namprd18.prod.outlook.com
 ([fe80::37e6:71e9:977a:b9f4]) by MW5PR18MB5176.namprd18.prod.outlook.com
 ([fe80::37e6:71e9:977a:b9f4%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 10:17:59 +0000
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Akhil Goyal
 <gakhil@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
Thread-Topic: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
Thread-Index: AQHdYuNeHHli1Iwk502VIUJZ31Oyh7cdxQkg
Date: Wed, 4 Nov 2026 10:17:59 +0000
Message-ID: <MW5PR18MB51768FC72DA623A72AB78F92A8682@MW5PR18MB5176.namprd18.prod.outlook.com>
References: <20261023114050.2939835-1-nkaithakadan@marvell.com>
In-Reply-To: <20261023114050.2939835-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR18MB5176:EE_|SA1PR18MB5903:EE_
x-ms-office365-filtering-correlation-id: 6703760a-c810-48c0-5e73-08df3a5ce716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|38070700021|11063799006|56012099006|261021135927099003|261021123027099003|261021121427099003|261021133027099003|261021130227099003|261009223027099003|261102123227099003|261022105027099003|261026130827099003|261022113327099003|261028144727099003|261022115727099003|261026135527099003|261022075727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: /Ovz3F7JeCe6bunQB0PPQSEYePh8H3526DxJqkWM6Xu6mCevkuKhvpymSjVVhyirc6Ewvlaw1tjC1zPeiIBIzQBqi/z6VP8rXDWZD84c6MQ3hLhVrU2dozASZZ/FVnzkaP1+OKYbC9+ANhGZhT0Y1AU4Te4AJpbNVGRAOZdiUED7n2ixFG4GbUcaBfwvRxqtO/GvrO+40kYvs2p7eFz8Rk1tLdrFi1syqI20BKsSF/2Z20FVbey84gJOPNnyhIJsQpLLHXYjfxfSLw2pjnzOhojVQIhPXR3bmsj9eY9S13kdfoW9pJ7+QpXXQkSjMLk8tgk6x/Qo1Qwn+lJcnGJ3TxBdQban1ybn/AIv/eA9np9l0Xr/QtzBSb+Ah1F3NK5OwehTjyBttZSpJdW9ANkcctrtOoQavR7PWkq9RalEdmhRehCWA+i2BIqJnytmHyZCXRd59it8TlUHD0FkW7YxK2wSDuJ5GIZwdhVPTCOthWv6E8kgeqEQ23OF8tSLMZAfytTjDeYI8tGS5lOV25/8eSg72lrUFcbsJZWWcnoL0xYVP4sMh0cERxYgTX3H7bOY40b+UNvPjVHXbI3v61J+P7v3IvcyGa/qe1I5yu4+6LsNA8oJpqEprtPD9jk2f4fbrCadxY0eEDyq/kSnWydodLOd9AdWBY84S7Cr2k4EhQ68gvUoOuWZU5Tvu6SwHrFMPOUTJZcvlOxQOzC8W16wIHZZn7Ty1sfohYA070wlc5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR18MB5176.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261021133027099003)(261021130227099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026130827099003)(261022113327099003)(261028144727099003)(261022115727099003)(261026135527099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AvCj06po+RZiSsStV7mQ+wAC4Db4lFlqn4iSyUufKIMW2GgT8n729+oH9orE?=
 =?us-ascii?Q?+e/U5zv6xcr8nkVK1TZNrqpStrJlwBDNX98/7iUSkOVWA4X2NGSLw9K+yWJd?=
 =?us-ascii?Q?a019rgpkbkCrJ70LMOoCL4h+04rqVsqJvKdurWNpWTBMs1BmHXNV/bAKgEYQ?=
 =?us-ascii?Q?oV3COAAg+2TlFt4HWxmbjRSo194Vd8uPczMH3yoCog2GfDi42aYkYFPvffOJ?=
 =?us-ascii?Q?5sLBVbrJjv8+TMah1NakF+kBgbbXQ28VVIrV5ZOL2W19gpfuhgQmpVE2dK28?=
 =?us-ascii?Q?XzuOYdggWedwTCkWW/mu/qaNU9qTBWHBKUm9fDXZRcS05GnMg5D7ud1X2deF?=
 =?us-ascii?Q?Qk20c6KvhWphwtkezff4LL2lMENaWpVv6ui83lNEBFOVhuuUHSb60Djg4kUh?=
 =?us-ascii?Q?bVbYEMseO2nmp7C+knAWlIBS/YQa8r72srGFUi6gb6QHtbkWh7zcPthb8sGb?=
 =?us-ascii?Q?Se+/bGMT8NpV/M6m3wPjaxPtIufe095xZoTubKBOdHqFnu8bfjagDFOxFqa3?=
 =?us-ascii?Q?K1sYnvvoEkvr+WG8VK2vlXK7+yMhL+fjKVoJqx7a/8gK+UKkvirlKZHN6V+E?=
 =?us-ascii?Q?tnz3S4pMpaqzLX6yHuh7mcnzXEdNOX/E6Jo0+Ff7BA9uqOJDoCZ+8QanpKY2?=
 =?us-ascii?Q?tihRiwRAhRWvZvj0gkewmbTaUOZKuENPtKTFwNS73RcGQDdgAJfP2OQYvYfK?=
 =?us-ascii?Q?ysdSE/TK2aLZw4m3XTgEcmXTb+Po/KIKdCD7belHVFbhO+xRKDKDRrAfjj5s?=
 =?us-ascii?Q?oHiyADNiNtvvMvTvSaNh+ujkKNroW9sy/xE6oEnMPQO+YtdriqrFEAtGUmZ6?=
 =?us-ascii?Q?3An+APFUk1/qxSk622IZbOZmJP0LZK+8eeYW5HtE1a38T0/GNc9vPDRpU/1D?=
 =?us-ascii?Q?9asZxhql/G1lgen4Mw9snyaLpDmfFZ4WNG4IxCyULz+PTYS5l0tcm5zza2dF?=
 =?us-ascii?Q?Ok0mWqa1+uUa9vlam+e+TJDvAnZLF4BtzpbVufS3owmdjrxtOY0UWVV7kBJ7?=
 =?us-ascii?Q?YR64od+SmiwdXQg/+rj9zxI1P2aMh4qPRy+axskaGF8b8JSgHzoSWYN17GSM?=
 =?us-ascii?Q?xrUcHM7m/75z7264excZ2CC394ICflS9Uty1WfuMjACmQeCC5SoFoFROlgho?=
 =?us-ascii?Q?pn5ox9pywgFWNKVIf88xInCVBy923MU/WDd/ShT14a3aNH8SbA8KIw1HsEff?=
 =?us-ascii?Q?539XA7HJeqfPpj0g5I/INvDuMqmuhdBR75JbaZxjyHP1rDHXt3/9pC27N946?=
 =?us-ascii?Q?KAK0podXYcCEcyHgXT08/DDfbFDKSFd523CKikyzFkzDoUU7uyi0hqpYm9es?=
 =?us-ascii?Q?hQjkwoAl1jAoLZkpmBF2ksaXh16tSlM6E/6+jJqB6z82CDo2bRuN7Mb8rdNZ?=
 =?us-ascii?Q?FPkiPXb4Mh8Ssve+0+UH1lWJaM2SkZBrHkJlxZCvreOt8Fj65Jed3pyYTZ4x?=
 =?us-ascii?Q?h9SHz1T1mIEdY4cERvG5gpwTcCSF+ezSqsMqfqHtEnVsWe21Ag4iitr19xbA?=
 =?us-ascii?Q?4E6/37GhcgLKt6gs3pPfs5jAF3ZozVIM7zRVQO6VaydqajpnCANUbRdIlnlx?=
 =?us-ascii?Q?tzsHZkFpT7Ip6VnjqYf05xyYPJQXPeeSOIHyR36+ssXwqjclyl84dMgrUoXf?=
 =?us-ascii?Q?dnGFfyh84rq5bTWJxzzzzMGqOwcWbp6wUCFn2wjNn9dvXtU1vtO2DYsnL7kw?=
 =?us-ascii?Q?LUCkK2EPGkO1qBl7DMgkNr73hkAEGUNyuhbs+STYtdmLSA1RIFS065BAzmjf?=
 =?us-ascii?Q?9hIry/6m9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PKnTk/rbzv+LoVETcphXGj0coLX9IWs1y3+pKTboITac7Nw5LrRj+kDxo/BnuszyPNjkS40k0z+UEaH5UNtp9W6ybT/ymqhPWDcnbbL10/Y/pqdB0o5yETX6Ong76Rpgy7t8A1p782zi5gunbnlSD88HG/VDeWnMjpkVrGzcg/p6ANNCv+niY47IRcZpzwMFfxRnQEx/xWbZpHW5AYd6kqf6rBnC6G3m0DqBVti3RnqRIS1a4n16WSE/+/g+BWp5VjD0Pf6akoQFMgV3gyNc1yJtO5b5aVl1y5w8+WZLAJc5DupP0nj2I0d1qKDUa2cvYVf7IhYQ0yTdWwJjp0AnTg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR18MB5176.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6703760a-c810-48c0-5e73-08df3a5ce716
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 10:17:59.7916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9y54U3H+R4pJkUnGgF5gdq2IfENPC63sQKsNmyJDLGb0OrcYP4VAhYKfifc0p+9ssX/8fiT97rMbpk5jx7x+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5903
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0MCBTYWx0ZWRfX9hLhpDSR0WdM
 CHLsgrzj4k+jWV0L7eR1x7WmfDOU0DpUSN/2DFtNX4FSEICkghN2kOtvnqTNb3yzJCl0Cb0ZilW
 u9LScHpUCkXWqSGi2T1cmN6tadIC+sY=
X-Proofpoint-GUID: vZGNaS1axCK59a5lPoNF2x5pj1ebO8NM
X-Proofpoint-ORIG-GUID: vZGNaS1axCK59a5lPoNF2x5pj1ebO8NM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0MCBTYWx0ZWRfX0oPgIpcSm76b
 6NTwcwrACzk40CJ8BKq7QNcGSXbY/JMsM3pWbEqS8DI1UC79gH6UQBO3YjdXoyKSanx+hG2yClR
 Ml8DujGCVuWacpDson/gO4GrFVRpX/M2L+/ZT3SR3BxS+TRTH6kN4TxpSXgiNJ3nB3DVGCgDfzb
 yGqgKolVvR4lC/sItizzrrel5prlLCe9KK/OvfrHlsFcVhiLwnG2mszZVqZfNvlTe/1DcieebuB
 Aa59z+Bn4eZ41Newf3nyORRXxxAx2vBrpZCp8bNsKmKYD7T5dyUIvqJ/3qvOpWBkjRCdFGhrBeP
 MGFCwFQ9FnvzyixHo1dPw30WOPnrUNozQy6FUBj8BUvE5vzWeXODwq+FEUtV9gt6S1ti5/dmYHA
 vWwsR91rzk+HhuNr20WYd/YPiYRzcnsJeFZ9ID2Ui+XhVzyLFvGEliZDc5hsZbuyuCdN0ooImWZ
 I8vbX1snXGN6/HwDZQQ==
X-Authority-Analysis: v=2.4 cv=E/VYNqdl c=1 sm=1 tr=0 ts=6aeb0659 cx=c_pps
 a=LH/tFbq2k+kQ3xVriB62Mw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=gHLDrgb6qCsLqu57MooA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Acked-by: Tejasree Kondoj <ktejasree@marvell.com>

> -----Original Message-----
> From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> Sent: Friday, October 23, 2026 5:11 PM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Vidya Sagar Velumuri
> <vvelumuri@marvell.com>; Tejasree Kondoj <ktejasree@marvell.com>;
> dev@dpdk.org
> Subject: [PATCH] crypto/cnxk: changes to align with zuc256 v2 auth
>=20
> This patch add changes to align with ZUC 256 V2 authentication microcode
> support.
>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> ---
>  drivers/common/cnxk/roc_se.c                      | 5 +++++
>  drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c | 5 ++++-
>  drivers/crypto/cnxk/cnxk_cryptodev_ops.c          | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/common/cnxk/roc_se.c b/drivers/common/cnxk/roc_se.c
> index 1cec536169..ce0e7fe84a 100644
> --- a/drivers/common/cnxk/roc_se.c
> +++ b/drivers/common/cnxk/roc_se.c
> @@ -255,6 +255,11 @@ cpt_pdcp_chain_key_type_get(uint16_t key_len)
> static void  cpt_zuc_const_update(uint8_t *zuc_const, int key_len, int
> mac_len)  {
> +	if (key_len =3D=3D 32 && roc_model_is_cn20k()) {
> +		memcpy(zuc_const, zuc_key256_v2, 16);
> +		return;
> +	}
> +
>  	if (key_len =3D=3D 16) {
>  		memcpy(zuc_const, zuc_key128, 32);
>  	} else if (key_len =3D=3D 32) {
> diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
> b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
> index 577f080ba7..b941567015 100644
> --- a/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
> +++ b/drivers/crypto/cnxk/cnxk_cryptodev_capabilities.c
> @@ -2091,7 +2091,10 @@ cn10k_20k_crypto_caps_update(struct
> rte_cryptodev_capabilities cnxk_caps[])
>  			caps->sym.auth.key_size.increment =3D 16;
>  			caps->sym.auth.digest_size.max =3D 16;
>  			caps->sym.auth.digest_size.increment =3D 4;
> -			caps->sym.auth.iv_size.max =3D 25;
> +			if (roc_model_is_cn20k())
> +				caps->sym.auth.iv_size.max =3D 16;
> +			else
> +				caps->sym.auth.iv_size.max =3D 25;
>  			caps->sym.auth.iv_size.increment =3D 1;
>  		}
>  	}
> diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> index a5b8aff146..14a4b0fff9 100644
> --- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> +++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
> @@ -672,8 +672,8 @@ cnxk_sess_fill(struct roc_cpt *roc_cpt, struct
> rte_crypto_sym_xform *xform,
>  	bool ciph_then_auth =3D false;
>=20
>  	if (roc_model_is_cn20k()) {
> -		sess->roc_se_ctx->pdcp_iv_len =3D 40;
>  		sess->roc_se_ctx->pdcp_iv_offset =3D 16;
> +		sess->roc_se_ctx->pdcp_iv_len =3D 32;
>  	} else if (roc_cpt->hw_caps[CPT_ENG_TYPE_SE].pdcp_chain_zuc256) {
>  		sess->roc_se_ctx->pdcp_iv_offset =3D 24;
>  		sess->roc_se_ctx->pdcp_iv_len =3D 48;
> --
> 2.34.1

