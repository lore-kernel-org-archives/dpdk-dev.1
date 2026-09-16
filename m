Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61859C982C9
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 17:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D26F400D5;
	Wed, 16 Sep 2026 19:46:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B6E754003C
 for <dev@dpdk.org>; Wed, 16 Sep 2026 19:46:53 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeVu72577880; Wed, 16 Sep 2026 10:46:52 -0700
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020099.outbound.protection.outlook.com [52.101.56.99])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gqqujk9v3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SruAtd+sH5goeYNzPKtTeUZuVC/OCxDBLChTG2QmTDsHBO/eXKnsOVrERsLkmUhM0djBGPzaR8VNf8KbHPeK28UUrmnE6kOYg49iR48spU6ifck+yGYkGjz0XbF06+95Yk79L90AKpUU5nwq7WVcUXyx1PnCvjQRrU/dtEWTupUzQXGtKVZtK/2HBzTkdIUGi1iAC+NBXIbXYUG/pJboZS/vfiNbXTuN1tW9F0EW6FDdSPlnltwa8zzvhovWLTKJZPijtnPZ3BZ1hJj2qYawyurODDQn0+SZSOAFedr7TZqfMjLgJpfvJhaee8pwkCGbTAq0Nap7N1GT/qYarJBeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKMawvMhUotsyLepeuXtG4EhZGIHn75V7ec1gTmTnWA=;
 b=cfrjBRyjv/0xl/MAC6n+v1T5X5gPKFd0dd+5rh1PEvXHr/dGx2WTHORNlqqMbUDfVB/ZPkeiNCXDIVCSsok7OvCwTMq+4u6BhXlUAtMm3ch1Uyt4QomjkUWDZsXh2MoFrVRz+TO3C2TdYM57k0eD59o2HMc+zYM20wLkcwetvzjYhvzLT7ymWK0hT8rpDbY0iELfUvXQUZ6cuTcEviGEdaGM/h5i3IJnmK61NV3m3ot3oB9TakbDkURyb+1d5v/IyivFEXSX/KjeDBqHj4e8RdwbKR7TjL3c4IxvrVLmCkqEnb2Vd+5E/yhfb/85DUxlMsaI5hGaxF7q5jWSWa9LXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKMawvMhUotsyLepeuXtG4EhZGIHn75V7ec1gTmTnWA=;
 b=EzpIUus8aaGlXwNDYgzZMXc1ki4Qwa3aWLhLU4QUw+thIRBeCG5IJxHhIwhIcKOqy4ntUzL7tyrz8NNFC9i49xMVOCy4tu2ArYeNm1kiWcHpPKlHo/yViR+TJWyaozJ9bKjOlSy5sOCRNBT+MElTspNOrVYIQuoVeN0btzXhl/Y=
Received: from CO1PR18MB4796.namprd18.prod.outlook.com (2603:10b6:303:ef::23)
 by BL1PPF0A019CCA3.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::d88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:46:38 +0000
Received: from CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7]) by CO1PR18MB4796.namprd18.prod.outlook.com
 ([fe80::d463:1ace:3518:f3b7%5]) with mapi id 15.21.0382.012; Wed, 16 Sep 2026
 17:46:37 +0000
From: Ashwin Sekhar <asekhar@marvell.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Topic: [EXTERNAL] [PATCH v2] common/cnxk: fix NPA pool RANGE interrupt
 handling
Thread-Index: AQHdQ04sGXQ4kNNvFky3nezGJBPtwbbPMj/ggADS4oCAAJvdYIAAFOOAgACf+gCAAABucIAADgCAgAAba0A=
Date: Wed, 16 Sep 2026 17:46:37 +0000
Message-ID: <CO1PR18MB4796B5E30122A7268E284287BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
References: <20260913040800.60274-1-amiyaranjan.mohakud@gmail.com>
 <20260913070428.66628-1-amiyaranjan.mohakud@gmail.com>
 <CO1PR18MB4796E0F85799C486CA837DEFBFBA2@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpO43LNUa-xzH7_AkSjcyo1Ws2-SdVUhvn6ySQY2_2OhgQ@mail.gmail.com>
 <CO1PR18MB4796A90FEE9E4C8246846F11BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpP35KM98KyydV4VBrCroR41-v1dt61E_dxMfx-3W2AQbA@mail.gmail.com>
 <CAL+mCpPOPtvn+Si6PvnvpK5e3rQHp81SV-+WDaiiJADt99V--A@mail.gmail.com>
 <CO1PR18MB47963490DE511C867AC2BB80BFB92@CO1PR18MB4796.namprd18.prod.outlook.com>
 <CAL+mCpPTgpJd+TUTxJDmt9r70ELAQEPvywC=+afuw69hEPavfw@mail.gmail.com>
In-Reply-To: <CAL+mCpPTgpJd+TUTxJDmt9r70ELAQEPvywC=+afuw69hEPavfw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4796:EE_|BL1PPF0A019CCA3:EE_
x-ms-office365-filtering-correlation-id: 5603d939-cdcc-4dc5-2bcb-08df141a7535
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: W4AupjfXt3LTqjGKq8+cBhb0aQj3kN5gR2dAG2U5d9H+hpYANLYw0saFyA5M4K6Gv/BiB+B2avqAL6JYmXo9VEowrkyPl+sx8u3krqw1jGDW1Q8iugIBWQB5PXAgG768hrU+GivaEl/xDmFxp6TIak/lAIUVp46syOfBRuE3PMirKvQUB9ySrtOLIHxFwrxY37mj1M7bLpTYR8J5CZ2PQVeIlSpwEZWKs8imPCLTBCJJRmnyQODy26eBlW/vU8Kcn4JfepF7/czIHyYoSWRbCOuK2dATeUM5AXEl8Ba3tjMbY4EOELhLqSgsWRqt84tJG0KNKQvjwefRk/1nZf0BU7xwyAGnO8f10RzlxX3wXULUL9YZ1PtcE7/chBVOQaCVBIeKaRfU0pC78tQCV59IoPLOMsl5XY/eAZarht+2akMU1+si5fnjJCrhsMJLaKqeMzT9nFCG1aq2qBGlyxHtWH6p3hMTd9whfR1J+v+ZsIWtNPcZrd9r+WEN3wptd0twFa5Zmb/JKIqQ7HvqLQ7Wa1zEzM5yBbcV30tdQY0I/shMvjyNiyXPQ11MdVjRbsYEY2Cyy1qKyFSRA4VGz6cGj6FCRYm6pjwpt/+XHLTnB9PNXiToY1eewRRtGEcjVzC6KVwSeZRE+wlpDNdrola4PQEsloh4/YFskEUwpAGpZlkmdIHDMO506A3061zTg1Z3zZ0LFA6ABiGi1GK+Ec8jZ8ImgzbOmIywW7M4vYJOumc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR18MB4796.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHMvb1hBUzJPTit0R2hZLzZxU3hqY2JWNUFLVkdySWFUYnJNelBjUDEwbzN1?=
 =?utf-8?B?Qkl2c0diQlhpajRiMjE3TGZtdVFsdGJaNDVXdGlPRlc3Z2Q2SGNramdSejhI?=
 =?utf-8?B?SEZ5cXNGditzUlVaZHpGTEVjR1RQN1E5SytmVSs5Zmc3a29pTjYrL0tEdTZk?=
 =?utf-8?B?eTNEMW9ldU1uMVpGSGp2b0Q4N1h3RnY0OFZDOFdsVU8wYXBKK3BYbmtwbG80?=
 =?utf-8?B?UmFHajFhOElMSHpLb0VSWXVTUm4yRS9NemV3RzVKNUljOE5xRVJ3dlpWUTg0?=
 =?utf-8?B?R0d2b1ZGdkt3QXNJbVZrQi9udnlDb2t3STF1WmlzSWtnSytyYUJIUFlpbG5y?=
 =?utf-8?B?aW5nV2J3b0doNEJ2T0pxYTJydjVYc3oxVGN1SEhISmJKdmpqUThQZDNkeTZj?=
 =?utf-8?B?ZWVsWDBrUUpwZ1M0WW1tQkZLUytidy9kTkwxQ0h2TG53UXU4bGl4cUM1UVl5?=
 =?utf-8?B?NnVGeC9QeCtLdExSSEZNUkFFK1JCOW9UaU5DQzRqSHZCbkV6ZHdUZ3Vaci9F?=
 =?utf-8?B?R2JURmdJZExuUWRidkp2bWo4aTRXZnRkWU5lV2tKcmJ5ZXV3V2MyTDJFR3FC?=
 =?utf-8?B?SE1vMVFRWS8yVGVCTmZCc1NrVHd2eWsvaC9lbW9zaEpHVlg5emRmbmRjN0hZ?=
 =?utf-8?B?YjBnaXN0OG5icURKSXlOdCtuNzRueHdiR3VDMks2Wk0zVFcxd1h3VW1GeHQv?=
 =?utf-8?B?dFBCcjI2bWc5c2FYMTZLMzJIcWFPUGtxS2d3ajVINHpqVFVSQ1l3eHFjU01s?=
 =?utf-8?B?ajBPVlJScGxhdlJacHkzVEtkTlQ5S0dhVjNDUFVUV1hOdEJXaHFlOW14c2F3?=
 =?utf-8?B?NE81bjVuMWRLQ3BMWVQ1U3JHRUlVYTFWR21TTUsyeTNjSkJMTkY4SHNFbEpU?=
 =?utf-8?B?ZktVNjhNZ3JCRHR2MzRBSk4zTGpIZmdSbHd3WHRPSklZZGR4bDVIeU1yKzhF?=
 =?utf-8?B?TXpEamVRbDB5alZYbG9qcU51R3YreXN0WG80ZENWaTEwZnMreHpmR01nWjNj?=
 =?utf-8?B?L0NMUkQ2SE9kSlJkVU9CazFnVFFtK2w4a3crUTIzWktBTGJNc3dCQkNVRkc3?=
 =?utf-8?B?QW1EOCtTcVRyUUl1cU42U05EaElmQ0hjbThyanZkRzloVEdDa2p2dHo1NTJM?=
 =?utf-8?B?bEQ0NjdpeVJuNWxBVlE3MVk3WkwxNHpLM0RFZkIxYUVwa2pSbmN3L2NhOXl3?=
 =?utf-8?B?MW5VYUJRQ0Jla3hHVGJQSDFVb0JrK2xxc2dpQ1JXMVAwTEV4YXNjMWcrTFNx?=
 =?utf-8?B?dXZ0OXA2QWc2TGJsTmdlY0lNMTdKdVFBdmZEZm1CeS9XaUxJZ3FDWDRCeW5N?=
 =?utf-8?B?RGV6SEJBNXhGcFZUQUs1QU9HOVJ3eWtEWGZJTk1WQ1puL2dMWFhQZWVXZUNI?=
 =?utf-8?B?ZkJYQ2RlRFovL245WHFmcEdXTlUrdWlpZGlETW1vd25KdlJRZW5XRHRNcmMx?=
 =?utf-8?B?MmhENjBOdGhKbEZsRkJoc3hvR08vNHh1Q1VtTHhEVHlRTGdQUHZEazVTK3Mr?=
 =?utf-8?B?RVkzajFQSGpLeFdsTXd0RFRQb2VEa3N1VGFMbWFtZWtCMm9YV2lLNG9mMVo0?=
 =?utf-8?B?VGViWmVEZDhINmp1SWFFM0dYSGxQUzNjb3Rkb3JFUmdqUlg0MDEwTXNOUndJ?=
 =?utf-8?B?UUxXQkhRVWpwOVpNMmZvTHJkK0s4YlZhRkZ1NDZZOXgrenptK0pUd2VSdDBM?=
 =?utf-8?B?VWxKblJQQmwxVDJPTkhGYnBmQk9pOGh0T080SFFUQk5FeWhJemtBNm9MaFd0?=
 =?utf-8?B?TkRxT2NQa2twZ2NYTnlwcENVSU51Znlpb1czZDNuZUIyNmI2QUhiSlRGaE8w?=
 =?utf-8?B?RWN4dFZWWUN6UFdoclBCKzljQUNvRGdXN09KYXA5N3E2RWFjL1ZMMzdaMzlz?=
 =?utf-8?B?UWNCUExsVXZXb21tckpBWDZHSnMwRXNETm9BYjdacE5qQlFxWTRrcStxS0N6?=
 =?utf-8?B?SHJzWjgwRjdJUlpvMmlTR0duM0M5cnRRN1FpTklsdDZNYUg4OHUxTkdYbzRC?=
 =?utf-8?B?WEM4S0l4M3dQcENwWEZLdll2bUxqeGp2Z1lYaGYzRk1acHZQWXpDeTBycVZh?=
 =?utf-8?B?d0JJWHMvaUVha1lxRURsL1VkQUdWUXBvSnlNRTZ4UXZhekdFa3JTZG1xbGY4?=
 =?utf-8?B?eUVlRkdXMGdYamtvK1VFM2xXVU5MRXhxUDRZUUFRSnozN3N6aXcvb2R4UHBp?=
 =?utf-8?B?RTBlVldTTkFJZndzcE1kYjE3TlBRczJ1TE95L2ZFUVRWYXN4NHViT21QMnNP?=
 =?utf-8?B?UVA4QlFFMWlldEhnMFB4QmlpcGdZc21CQUtJMVAwVGhaN3VScU41WmdOTEZW?=
 =?utf-8?Q?Ou2x1zltMhv3A1g/sb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IhA9NpDdumJtEPZbDtMXhZCky1whQiaB/hkvZy8Uw3N7G46OSgL9UxL6W3b56jxO8vv7pbK+wITs6pH9xQaEVjrGGImElTe04NiiE77NYrtGThQ8aA8JGVUS5G77+EHF24kXJXAhWoB43IeEHD4NDFib8HnT1MnFfHFRE9sl2frRFnBcFR/3lgJRRHtNZsGaqdXVtHGqVZbcrbaH+bKsQn6YtL4V28XHR4zIj9WXrjUjB4zUxkR+hcGYSYs716PpTPBjw636G8aqDzjBCbFrb0lfMaU1qlkP51GpkIvgxmcKuX2vJtyOVCYbqG24I0GdzCYCsRQGVqxVgk3UEjMBkA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4796.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5603d939-cdcc-4dc5-2bcb-08df141a7535
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 17:46:37.7962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNyYUJCOiqxgI7wCE7jCULLQhouuYrIuUp+lAJvO+3X5DBZTruztQpEA7ivAeyLsXwPGCKxKhHjOJ4AcLOVafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPF0A019CCA3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI0MyBTYWx0ZWRfXzrrnJaJ2HwtW
 peokPptSFenD65yHCbUuLq8XSTzy8VZTwvnnylKXitQHd0hqnLix+7mwUxrTUVeBkDBUOa9a026
 Th9l/LYq0CTdsgEIFs2dNCgix3Bn099hHwhuy7rghYwrfT8B/SH8BUrVB6JLr8ojGU2cpayzhlX
 F+UnRlLEBiFirVRaYQ3HIpnbJazk232lqdlrsqYIz4mDbFrz6f3BCvuA6cGnRT1Odo5hn/LuGqB
 j54MR5oRI0R24vSaCVdDidgGa6/U/7roXDgJRKDDXhTtIRHeVYTMFlpgPwF2/3CbQ8Am+8SoPTg
 DLLlca2EQLIgZK6FB/a9+oBL7gBkFl2I9grOpCDbSlSNFNpLIRtRlWiRm9C+785bJPGsRrf7cXq
 aizvXG454IiTgfkVBdznSvv83aB+6ys1Jda2A7f7Jnl6K/ASk5s0cB8p+grDOBkmHWAjsVxmrlP
 0jJuIYyvzRtPimuFo9g==
X-Proofpoint-GUID: kVsysCJ6bURj8Vo2oVTvtgqVYivOl2MP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI0MyBTYWx0ZWRfX2gMs3aeSzXJ6
 o24nDWr5ANV9r5BZhdYIHu1p62SBZYsb+FGgRtsuwxafSZaPb/JVE7CN+cchRkHF8sAxQH+w+X6
 xdQXPvINQRymgk4w3lRxyDFRSpKjKuQ=
X-Authority-Analysis: v=2.4 cv=F6LC5ahN c=1 sm=1 tr=0 ts=6aaad60c cx=c_pps
 a=gw0jr/XWmcdhwQv4PjOuaQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=ZGsNL-sPnIbzrSyfrhEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kVsysCJ6bURj8Vo2oVTvtgqVYivOl2MP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
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

DQo+IE9uIEFRIEluaXQsIHRoZSBjb250ZXh0IGlzIGZpcnN0IGFsbG9jYXRlZCBpbiB0aGUgY2Fj
aGUuIC0+IERvZXMgdGhlIGhhcmR3YXJlIHRha2UgY2FyZSBvZiBpdD8gQmVmb3JlIHdyaXRpbmcg
dG8gbWVtb3J5LCBpdCB3cml0ZXMgdG8gTkRDIGZpcnN0Pw0KWWVzLiBUaGUgaGFyZHdhcmUgdGFr
ZXMgY2FyZS4NCg0KIA0K
