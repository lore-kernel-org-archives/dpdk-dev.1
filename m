Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC28EA811B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C325940666;
	Tue, 10 Feb 2026 15:39:50 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5136B400D6;
 Tue, 10 Feb 2026 15:39:49 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61AC819R530091; Tue, 10 Feb 2026 06:39:48 -0800
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022085.outbound.protection.outlook.com
 [40.107.200.85])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c84cw0a4q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 06:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqM7xf2zk0GzgTq3BXVHej3lbTocoxBX/8hbt3pg0skkQfB0GZHjP6aMkwFpe9MwEsVrZn8g4ZV23UB5o+IApie/YbYZf6itrrTxES6OrSLs6HmBIcIilN6XTS1MSNJ+99U5T/4udWXgJGfYe4PaLKPzn9gD8uNgwsI6Uos1LSyIUWK62Z9CuaH150O3ZbrvTXzm1kQM1y9BXwR5G0f0INBSu8ClNSVtc0eabg29tbuspGRMcZuIR8MyXLWQvkDI/6IW8vB5Y7m+PDvXzh1gZtX7MGqH/IGyn8NoETsNua7gzr06r5wMi7T+DpMioGUSOgRwgyKKOtftu7jhdKtixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5q6KLVkimFmiisIP5GlGG8X8ColZLBsBgPo0HvFJWk=;
 b=Rv9hG2/qyGErnHzCKvIsMZXD5JG1dhERNohWFaBpAjJwjgjAA0Cj4vc+sdgfz8VyYBnw+g0XJhqiUm2/UkmUg1KumrbUraM9Iuat7CNcNd6ukHKDHEzYX33x3dLr5uBiR0fDZ0P+n4cKGkCg6o7AaxuRdfiU+6FxoaQ8oFq4qt6u0vOkOecsyB1PsIdg6aKKHoMY/5mKaLklI2m4ACy/ba2s2Lo9TEZLbBusH5dJT2Dcl9jgaV502gf8p+LXmdX+7COvZ3znETJBg/IW8gjA3PhMQEyFO8EdGTpMXmC8lURC1nxLb1RaPM81sC2EnZagSlMHwE6ZfqaiiKmYraLVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5q6KLVkimFmiisIP5GlGG8X8ColZLBsBgPo0HvFJWk=;
 b=jgWBQTPda7DTaBb1xaVDKUHSkzsOVTeQXOotVpFr6e7JblPv4Kui4nSksz4VQwG9Lh/zOpFFwUuz300QTm541OcdnX4XxD9vSQtwL7W9GowTKtg0a8qgnrlw5OBETbtnItfVY4RVVcLb6+OVIzCsO5DeRnTx77nMYvjaZapbB54=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4169.namprd18.prod.outlook.com (2603:10b6:408:133::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 14:39:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:39:46 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Ashish Gupta <ashishg@marvell.com>, Sameer Vaze <svaze@qti.qualcomm.com>, 
 Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v1] compress/zlib: fix UDC checksum logic
Thread-Topic: [EXTERNAL] [PATCH v1] compress/zlib: fix UDC checksum logic
Thread-Index: AQHcbsNMAOaClNWB60SvwaBJIriverUnA30AgFVU/YA=
Date: Tue, 10 Feb 2026 14:39:46 +0000
Message-ID: <CO6PR18MB448424086423B49E0342C725D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251216193616.373430-1-svaze@qti.qualcomm.com>
 <SJ0PR18MB4495316B3067E67528DC5685B7A8A@SJ0PR18MB4495.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB4495316B3067E67528DC5685B7A8A@SJ0PR18MB4495.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4169:EE_
x-ms-office365-filtering-correlation-id: 74997e79-e839-480a-fac2-08de68b23c91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QmorMjVmcDBTZmliejdxWlV0cU5SbFZEZmhWbWN4N2FrcG1GVHNldDZnemJ3?=
 =?utf-8?B?TzhZdjlzMndtVEJ2RnZSL1J5bmhscG9nZU5CaUc0NXVlMGFLSjlicGR6MlBz?=
 =?utf-8?B?OExZWGg1QldHT3VRbGtvR3E4aGpqSWRuaUtwNHZGb216cjZ1NitVb1JmNC92?=
 =?utf-8?B?RVRXMFdMVXZrbFFUUmtTN255aHN4QjNrS0gxSTg5RFRvU2J5QWp6cHpxREw0?=
 =?utf-8?B?VDY0ajFJN1FWRzBEUnZ4STJVQVF5WTFadGFNbnlaNmdzNHA4eHlLRVpYblBj?=
 =?utf-8?B?cjIvejVDLy9mZk82RUFSdWRQVGZmdDNid2xzQ3pnN2RDT2FEWjZTTzR6bjg0?=
 =?utf-8?B?NGlhNlU3eS9WTjdNOVRtN2dmODRMcjhXYlFUTndyTDFpK2o5QWlvQnRCVVB1?=
 =?utf-8?B?VmpoMjQzVHZhWU1ZS09rdzNUbmZMYkV1NmJCNE1mSlpEWlNxMDdvYmg5cTdh?=
 =?utf-8?B?WmdCM0FNWUtRWFgyRjRqNy9sNXpaeWx1a0dwVHJXaEMxUHE3ajV3SkxXbi9J?=
 =?utf-8?B?RjU3a1hIWEU3bWdVWS9SSkV6b1V6cDc0em41T29pOUJjcGhoU2hrdFRueXRG?=
 =?utf-8?B?U3NaU1VUUDFYOW5PbTBNcGZYSFV4Q05pOUJOQTB0QldDMldyWlEzODloeXVq?=
 =?utf-8?B?VjRkVDNWM0RFM29ha3FnK3A1RDJhejFqdFdydTRSSDlSaGdhVGFDdTVJdFpi?=
 =?utf-8?B?clRuVDVDWkdlb2Z6eUUxVFJobjZmTFdkTCtRY1BSbUVuY1JRREYwY3JxTDV2?=
 =?utf-8?B?MCtrNk5RanR4bWJtVXdJUW9takNuTXZSeWxvZW1KbGV2R1FJeUZTTDhHZndP?=
 =?utf-8?B?YXUvK1FncU4vWTZEdk05WnpObzlKc3BMdVc5enprUmRTRDBid1FWNEJ1RGxY?=
 =?utf-8?B?YzQ4Tkt4NjIwOWIzMm9XTU9vaGVJR3hsMDlFN3RhR0hXTzhLdFlvUCtzcE5J?=
 =?utf-8?B?UHlJMHdmWHFoak5XbTN0VlJ6elRlSlBENXVROCtLZ2ZaM0p5QndrdzcwMkNU?=
 =?utf-8?B?cjloVUpzeHNleTZsVTh0Qmh5UWhSMHNyMmhOLy9MR3E2OGh2OGhBZHdUU1Z5?=
 =?utf-8?B?dE0vUjZ2YlIvWVdNYmFuQXFvL2JnM0JpLzZ3K1JuZ3UyVzhaNDU2MnoxY2hR?=
 =?utf-8?B?aUgreWRmblFJSUtIcExSNFJjbGZWTTk1VUEvdzM4TEJBeFBWcmRKMi9tL3pX?=
 =?utf-8?B?ZmV4OTY5NjczR21nVFdTZFVJRFAxc0pqTkMwODcxeTlvQnlKa1duU0g1ZnBZ?=
 =?utf-8?B?K0ZiRk5YaGRtb0JhcTJiYmptZ29QUlFJbW44YmNzN0crVThlMENlMnFEZy9v?=
 =?utf-8?B?cEdpSDlhUjZZenBCd2ZZUUxiKzZUcnY3eEozNmt0RWpveUdFc1RTbUxyREtt?=
 =?utf-8?B?SHo4dnRGbS9La3l6THk2TFBQNnlMMTRTZ3dNbklaMHF0Y3VBWU1zdWhLUkFU?=
 =?utf-8?B?Nk1zZjN6QTZGazNXY2tKTVg2NC9GOExuaHlVc0Y2L0l2RGNjb3JKTzIraUJ1?=
 =?utf-8?B?cnQ1NnZpNDJjajNDdWZSVlEwUEtBR2pQR1BvbFZ5am9HT1ZwbzRsN3BrUFVM?=
 =?utf-8?B?TVovVDZCZWZYdWNPMVFvcGl2ZThPWmtHbnk3QzBTb2E4TzJ1cnozMnJ2RDJR?=
 =?utf-8?B?MUtBY2VFTkdLVG5iY2c2TE9Sb3ZnYzRHM3NBK2dEMElmUnVZTlE2TGg4WkdO?=
 =?utf-8?B?eVF6Z2N4RmY5c0oxVS9ZTFY0N210aExiSzBXL2oyb29ZOFNvRmFibjkzYk90?=
 =?utf-8?B?eGZsWjJHUDFZRmVhT01WVVJSdUdsRTJOcnErMVlVKzV5QUFwdS9FOGFUVUpZ?=
 =?utf-8?B?SXI4RlVJWXpLSE9OeVZnWFBnc2JIbXlKMWUvc1REMUR5ZFRhWXhianVtU2xN?=
 =?utf-8?B?N3NEMjVkMWZVaHR3aEVscnZKTWxGZjlPQnBpdXRwVzlTSWZVbldxdlhMd1l2?=
 =?utf-8?B?blVBMEJOeElpSEZXSjlScUR1Q3RUbENvUjAwbC9OcXRHUXgrWXo5WHp5REJI?=
 =?utf-8?B?QW1YeWlLQ0VqMFRQV0dSaHRkTUtocGdOblI5MmE3cHFCSGk4Q25VQVNHK2FZ?=
 =?utf-8?B?SWxtUDBjUmYxSS90VldvWFovNEJjbUt3YmdKSFd4dVlMd1JBZmFHZzdaajVL?=
 =?utf-8?B?U2U5c3VxekY0SzV0Ti9Kckp0VXlvL3lTbS80d1hHaGdyU3oydWdoZzlXN01P?=
 =?utf-8?Q?RyeCCzcSa/MJxULXX/wo/Ng=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzdtdFVLUnlnT3VYRDNQMVY0RVpWSEQ5NjE3eVlrUmRMSXhlMDRDOFpZK045?=
 =?utf-8?B?M0lXbXhsYkU1ZXJLOWkyTG9qWm1JSFZYem4rYmY4S1pwVi9FVzJWT1FuU0Rv?=
 =?utf-8?B?b3FEbHRVKzdjK1dTZFVSclNHOGt6Vy90WjU0Z3dqOFNmSmwwMGVtTUZDSnRS?=
 =?utf-8?B?ckU1RUlHYUs3K3IxalNCMC9QNXgrbUhnNHJOTkYwRURDMTFCbXRDRkFjTER1?=
 =?utf-8?B?YVpvelYzT0RVOFMvTXBvckMzSWh1SGVEY3ZXSVlxeVB2Z01Sc3ZkdHNFSHlG?=
 =?utf-8?B?aHZIOUV4dDh1K1RSZEgzRVhyRVBFK3htYmhlYXRad3BjcHNpcFBXM0gzY3VE?=
 =?utf-8?B?SXMrbXBNM3FsSlMxOFNKd3lOUlhwNk5MY0tkWnFoc01LM0MwMTZSZG12bG9Z?=
 =?utf-8?B?bkhWL0p2blFZT2tRZm5JYm82MmdUVDd4djBaYWZPY3lOeEJMd1VzTWs1YjJ2?=
 =?utf-8?B?SmdOcEcyREpNVTg3WWNzNU1GcDRYQUsyTzFoUHJIRHUvZWg1NjBwaFRuNDJo?=
 =?utf-8?B?a250L05iQXg5OU8rR1NUU1BMbFNoTUFZUnhOMnBpa0x0aUZESUpqbWhDSUQ2?=
 =?utf-8?B?c3c5WWxDbTBoeUNwaHdpWlg5eGFRQkR3Ri9JY0cyMG5VNHZ6RWFPZFFmUU5h?=
 =?utf-8?B?dmxpU0NoZUdmZGlXRWVtcHNaTGFxZDJSWXBEVkluaWdIYzhicVFkV1c0SjVt?=
 =?utf-8?B?b0RGRElrNGl3cmxubGpuemxydjVnTjlFUkF1cTk5amFtaGRCditXcmZYeXJj?=
 =?utf-8?B?dmJidWNsOFVjRzBsaWhUaGF1Q1VZelBsbkduSHFTRlZzUCs5bXJlS2RiTDVt?=
 =?utf-8?B?V1VzS0d6Sk9iY0QxWi9kcnM0dUI5S2ZvUDNQb3BpWGRzcXYrQkM5M1BxS1pi?=
 =?utf-8?B?TlAyT1VnaEU3eHNOSGg5MFN6Zlg1L0NPUG1vQ3hlc1llMTRwS3BmekhwMGhH?=
 =?utf-8?B?dXN4alFnd01yS3E1UW5OK21qQ0tIVTZiMjJ4Sk1zdTNkaGoraEJmTUFld1p4?=
 =?utf-8?B?TFl2Q2lvUEI5T294VGZlMjZIb2l5cjhjVjFIUDBsN3R5amswYjVvd3h4SU9B?=
 =?utf-8?B?bTlxaldKRzg2MUx1WENqUHpEMzlwVGhya3FMeFdTc0h6aFlndFdSZlJTMmdv?=
 =?utf-8?B?VEYzMTZHSUQvN3JaSFlUQUMwc3FmOWYwbEk4Y2JmVHRTS053WWx4TFZVbzFa?=
 =?utf-8?B?Y0VmM2Q3ZWVRRFJjc0lVZVlLQW1lRWJ1K0owZGI3blR6RmM4cFVjWEUxcTJ2?=
 =?utf-8?B?bWVqNG1kcklaTXYzZFlyQ3BvRDJVbEpGWVFDWDNqaTJYY3B4NmVOdjNjWGJZ?=
 =?utf-8?B?cGtzczZDc21VOUJrRU8yTERsOE94ajBaWU1FTmN5QUtmMDVnK0ZabFhIczFH?=
 =?utf-8?B?Zmk2djQ1YXZBOWpmZVVqQlJ2cjVRTDF4bk5IcHpmUXF2UkdZWXBtV0QvblRi?=
 =?utf-8?B?MTByVnkvbEJFVkZrcGpSblhpY1JHVVYyR09GcEwyWUlGa0JNeGFyRGZWK2x0?=
 =?utf-8?B?WTh2SDJ6WFVEWlhLaHluUC9ZWUtnZnJueEJQbC9Yc3puVHFqS0EwSXdQb3U5?=
 =?utf-8?B?ZVFZRDFGRGl1SFhqN2NhNmgxSFdjREl3bFlmMjVxNzVDQ0JZeGN2TC9DL1Fm?=
 =?utf-8?B?cE83SW1EQlpxZUluQ1ZGeTZRbjU0cEZUQUxuckp1bGZUamtwbS9xOHljUllU?=
 =?utf-8?B?Rm4yYnUwQmVoeDgzZXcvaVdQWVd3YnZXdVNXK2tEQy9ZWGx6eFVWWkZCS05T?=
 =?utf-8?B?STJ1QXBzRG1KbGFJK2RCRmNObGpnQ1FUZS9sZUtQUzVqd1VhYUtyUE0vYkxB?=
 =?utf-8?B?OW02RW9ySDQ1NnExS0Z3b2xLK2RzZ2tLeklndWJ1ODF6eHVWMitZMENYTC9W?=
 =?utf-8?B?QXJkSzRlQ0lJUjd2Umt3Z09QZlp0NlJJYWdNbndsY2ovZGtBSFB1MFNMaTdN?=
 =?utf-8?B?TFBLK29xSlFiNVQyMHFhcTRvQjlTN1RwaDViOXVWczUxZmUrK2dCM1E5OEZK?=
 =?utf-8?B?ZTk5UlpCOXZCVVFwa1hScmRVQmZqSDFDRFRRcXdZS2E0UlR1QjJ1a2RsS0g5?=
 =?utf-8?B?c3hQMVcwanV4YUJwREdmVTZZWUlaM1dCeDlTVGpqV2tQY29sR0Z0a2Riby9N?=
 =?utf-8?B?bFo4Rlp2eXkwQmFMR0txeXFsUEE2QnRQK29oODRJc0J4cDBoOXZuaTdzbFVp?=
 =?utf-8?B?SnBmR05vS29BTmxkTWs5ZFpvdmRFTVZaRFlXSW9IZE5RSW9DWWplUFBBWGxo?=
 =?utf-8?B?Zm1PL0RNcmJBMWhMUzg2REhhZVdHS0FYTmdjczBPcmdTUjZWdEFGTXMybEVa?=
 =?utf-8?Q?j4vR95kyuxjTGML6N7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74997e79-e839-480a-fac2-08de68b23c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 14:39:46.2774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pgMBuOUC6H8GR7mAUSAEZlsB5AdT0Zban28A5U0Wtk4i9l9C4vzD9nyz/jsg1+H33GRIHPVrAXV/V9aGcvLBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4169
X-Authority-Analysis: v=2.4 cv=YsIChoYX c=1 sm=1 tr=0 ts=698b4334 cx=c_pps
 a=jGG6JRppMrTRDPguzGMrcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8
 a=EUspDBNiAAAA:8 a=M5GUcnROAAAA:8 a=BE2X7mprYcnsShTqAUEA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: uoUseRHWqH7IZKTltjARn3sieDrqKErv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEyMyBTYWx0ZWRfX+Pj3Mn26aiTd
 /o0g8Sb3osE7P+1E3/XDvdoFofky6GHYbaWwWzCLRH4ZyVZ1tcmDHTPJu76q4K1n97LQ45mGzox
 oR1AO84Nd/UxsrdbQwOirgL+7l2yD1WQPp2Idud40HAOnVRwTK/wetKneEBrAopYjwOmJN7qNi/
 kQYMKtPmK5aDw4YQL0VmKUrhWJ9IOnxCsH+o20aGBQMSXixV8sdYIFLRNdq1mgzRl3LHlRE74iX
 Js235PtwJlAY68sdex5/sofYPZodLdOqUXEjyGFI25EcF/zWiAiBTFBQWhTNBucqTB5wgETb5pT
 NTERhAF+8UjVlxsO0tXZzG0ATeTJjeUFMeD/WaBvYKy5O8XDqnvGrk9RKkNZ1pR2Cqc1fSBLHav
 fM5jZZGkqg1wmDAepaa8HYqqiZ3NoYyPqZ1dYeQLbuYxryt0AV5mvS+5oqoDv+gQ++LMIZlahbv
 zhk+yuq8fneHyohoVtg==
X-Proofpoint-ORIG-GUID: uoUseRHWqH7IZKTltjARn3sieDrqKErv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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

PiANCj4gRml4ZXMgYnVncyB3aXRoIGNhc3RpbmcgYW5kIGNoZWNrc3VtIGNhbGN1bGF0aW9uIGZv
cg0KPiBVREMgY2hlY2tzdW0NCj4gDQo+IEZpeGVzOiAwZGMzMTRkZWJiMjIgKCJjb21wcmVzcy96
bGliOiBzdXBwb3J0IGRpY3Rpb25hcmllcyBhbmQgUERDUCBjaGVja3N1bSIpDQo+IENjOiBzdGFi
bGVAZHBkay5vcmcgPG1haWx0bzpzdGFibGVAZHBkay5vcmc+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTYW1lZXIgVmF6ZSA8c3ZhemVAcXRpLnF1YWxjb21tLmNvbQ0KPiA8bWFpbHRvOnN2YXplQHF0
aS5xdWFsY29tbS5jb20+ID4NCiANCj4gQWNrZWQtYnk6IEFzaGlzaCBHdXB0YSA8YXNoaXNoZ0Bt
YXJ2ZWxsLmNvbT4NCkFwcGxpZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KVGhhbmtzLg0K
