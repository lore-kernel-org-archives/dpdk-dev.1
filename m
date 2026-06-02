Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32701CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 19:28:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9356640651;
	Tue,  2 Jun 2026 21:28:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9752E4060F;
 Tue,  2 Jun 2026 21:28:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652G6eMG1222214; Tue, 2 Jun 2026 12:28:04 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022114.outbound.protection.outlook.com
 [40.107.200.114])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ega3ba392-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 12:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlDVyWdnpM4OaljaAVcVl2SsRTgrcvkGYImCPblusP+FWJ/5yo6pULXi+shATB+Y8m9nhYByJHGS16SgjndwUk/mI489DSxAnGBl4Aw/Hi2Plz4NsBT4ZAVrGOs0Pv4EkT1z5wjGxPG7VBc7phEdDpzDnOhXR67POZEijo8Wt/8KDKDe7hK+oRQhfaExqR0AdF664Icz+mjWVw4lZuGPd9a3cdH6jJSeYgBkoFmgc1F+Dt7PD3htrq8aE1hisAPrLOOX6PN/xJ+UcTSaE1Ff105EAVc0XL/kBwI3P2Pcdjp9qPc8FBh8as4rukKESfi+6KjhVYX18fztceO4hRTihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TTD44P90bG/0Or3sZeGR9uyo9qzz+aqDvAmN3RXjO8=;
 b=LYKyH8bzFFmj/dyi5psCpy9C+7CIEldp0ttuhdKG5FXkmEeaNRSZwqPQsftwN5pDW6s+WUtEpVUBAmgNcdvMXyb/l1zKhzrKmuQZj2VVP5Gk3sNwpH2rNEUNoviZfkoQBC3FNAbabzo8QqtWQaRPDh/mrLhilTDqc9SlKo63iDsGwcS/FTkRcUfjKJOFQIwbsjtQKP7KGDNC0Ihqt1tAg8LnsdCZ2OtFI08YgaLqdVNnRZ3/hGUj0tlLEc4UoHl6zHEuAlULav69GRtyx0YAIyvihai4hIyxcuLzrCDMnywWmJ3Nl+uoUZJt439gGVtX4vmM/KhtbJ4lPGWIbEx0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TTD44P90bG/0Or3sZeGR9uyo9qzz+aqDvAmN3RXjO8=;
 b=UQBVD5niRky7ZH2c/DSPMIlkK/HmW+JDpMa/i0g/iPig6Iix9la5oKsKHIi8pTYf38Xu+qXmQZ3qgxtbBd8IpSmSENKCuISHmLChxn8RK9hBWBZUPyx2AhA6bO+sMoysHc7mSLYJz0KSYEF6EDc48Lz2ie8X8GYMhTnYcH/63bo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB5661.namprd18.prod.outlook.com (2603:10b6:408:1a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 19:28:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:28:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] crypto/scheduler: fix typo
Thread-Topic: [PATCH] crypto/scheduler: fix typo
Thread-Index: AQHczaoXuWs8jska50qMIcusEyTmbLYr8GpQ
Date: Tue, 2 Jun 2026 19:28:01 +0000
Message-ID: <CO6PR18MB44847E7CCE2214AA1F24D552D8122@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260416095739.105062-1-radu.nicolau@intel.com>
 <DS0PR11MB74582F9B2381C12687BB5A0181232@DS0PR11MB7458.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB74582F9B2381C12687BB5A0181232@DS0PR11MB7458.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB5661:EE_
x-ms-office365-filtering-correlation-id: ed7a9621-eb37-4c8b-2f8a-08dec0dd0f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: jRzvIO+hkR5KA5VkVbbHJvpEd32gfOa2HnH8xTrhwVMHVH8mCyZwJmyLljgWuU/7bPRYgfSi7WjUagErh/NTTglhy268m/8IX4ASiK7CnhGspP4am98gsHpml36wJmYOgeJqZ6UZ8uFZG3CeTMrMpZ5LP8WCWd3DDFpuevUzFfO9gRvDh6nM6PDdcz+2zvpnyisXXQnK8QJYwoE+lS3sryYsjgpomrEobqDOsbQA+e8KFNJILZcAbRD0Q+hgRO7nV51rthKHNI0YC28lbR72E3gQZdxLDOdLtgm2/LFTfeFFsGti4vQV6XjMc2cO6V2Tsimi10yMM7bazw6y4XCpFpMKD0s/1KrjjLxoqyeFydJamGtcXgo1WCrZgYo1KSEwHxsZI/fRFmDLwO8NUda5BxSinOQrYpiKk5waRaifiDnMwkKxmFiBgq5hQdpbzhgXYheEyMfyMAIvVN50iCrqoS0TUOBo8pfDjhEPc4uDf1p9BMim1OktZ9GM8sAgeygOCDlDGJsnB49gQyT7BKPcb1oD67oxG01KB8X6OVwIToG0DjQFUP7QJcOIhQvPCZoRjUnEOLEB6/l/0gGNgCaJfaCFTYukA4zpmiJEtWM3gfANAFmK30rLkJaURZHMjsYlawtthI/iEWBOw883vHxksFz5EUaFrHvROtJbDvOH9ARwBtCtMQXfLEyoJJD625fcG7q7zEqMJByeJJCgsUZwYY0HEHmDm9CeFhjIwxNZYE4Q9v3Kt8IzpQYtDHmJOIFV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S21pSExWNTNKMEgxWElLUnByQ3N6U2ZYTWFOT2pxK3dMVmxhQ2NzcmMvN2dT?=
 =?utf-8?B?NHdiMnJtL0V6YWJCZm0yM3lXK2xrc1RhVTF3ZjM4RDEzVHI4THJiTy9GR3Ro?=
 =?utf-8?B?ZmVta2dJb3JKdDJ5aWdlYkNHK0s0YjVwTThMUWNZd0I1VVg1OTdVSTRsRzAr?=
 =?utf-8?B?cHczVXVaNXIxRjNqZWh3b0dGMjVUbUNpUmRCRTdueHNnMzAxaFE1VStJbk9C?=
 =?utf-8?B?NG8rbDVRNGtwbmd4RHRNUnNFMVI5ckhMd2FYV0V6UXdPK01qc3VtTk8rOVdD?=
 =?utf-8?B?VWJuRnp5U3NKRzRGMWNjaEdVVlZQNGJ4OWFpaXRGMlptYVM1RmFjcjA3cFRa?=
 =?utf-8?B?aUJzcnJBMVNtTmhmM2dsUDNEekJtWjhNWFBkeTdZaWxWVFVtUWRLVEMvU2ZF?=
 =?utf-8?B?Z1V6MlprTkx1MGVYbGdBV0JQV0tVVS9GU0oxZnhrNWtSeFVENmR1akNjR3Rk?=
 =?utf-8?B?US9WMHJiRUtnay9XOUZYRUh6Zzlydy91R2o2SVJ6TE1TYXRFbXBubStPckRk?=
 =?utf-8?B?TzJwdUdrN2gzak9zU0V2R0I5ZW5TR0hEcjJZVjZrckhZOE9USmE3THYvK1Bx?=
 =?utf-8?B?QVJmbm1DZ0tUNGg4VWFJdEtMOWxKQkVoOXJDM3Rnc0c4cHhPRmRvZzExVTl3?=
 =?utf-8?B?cDg2cFZDMXQ0emFKWXMzTUp0VDIwdVJ1Y1luTU9GWStGL1R0Ymtxekx4VGh2?=
 =?utf-8?B?bjVzYURMby9UWVkwU1VlejVoRjQzcmdBbFdaT0RWMTJVQ3VoTm1CdlkxR0lm?=
 =?utf-8?B?aU15YktXOWVoVFEwVlA0bjJuK1hxbzFISUN6S21qYnRtck01SEpSa1VNbnpS?=
 =?utf-8?B?UDRZVFd2ZzhCSDBhVHdnZlVjRFFEcExCUXRjWnlNWjJlb29UbFE0UnVPOS9T?=
 =?utf-8?B?M0xVdW9vNjk4MXdQOWZKSzFHQjJibzhuQ1JtTmp3MkVSS0hsNFZEYkU0WGhK?=
 =?utf-8?B?djlLZXphNmJXZDRqcUV5YmFZckY4ZGZLeUxIL2RXbEV3alN4dXdscHhNNW0y?=
 =?utf-8?B?aktZYUFRZml2Q2dlbFF0eW1sdDloMXJyWXltSEFiZitHNXdJankzK3RKQzAz?=
 =?utf-8?B?STl4TEo3Z0Y1cks4Qlk1ZEhZSjVNbWxld0t2Z1FBVENKaUVLZFVKRzNUcnhv?=
 =?utf-8?B?ZFpvYndhK2JibTdhOG1rWllJWjgweUEwbldpQkllcS9MQkg1V0RYSEhibWpT?=
 =?utf-8?B?SllDaitLT2ZxM3l2a0NRZWVoemFXdWtCWEFlZm9sRlE1TDZ4S0xXU3FGNW00?=
 =?utf-8?B?a3dKOFJHOWJySUVvbkszcGlLYVkvUUxPYXcvNkdTenhNWkY5aGkxWW9GVC91?=
 =?utf-8?B?Y0NVOWloR2tKZWhpRXBGRy9wYUQ4UFVrUTliTm1ncGhWdjdlT2lTMzlDN0NY?=
 =?utf-8?B?SmxFMjQrWmZiZEdnVllDOVZ4ckxRNDZHYTY1OVpCVStmSlJ5YW5qUitHV2tF?=
 =?utf-8?B?L1pUaGFlNTdlS1JhYmdBdzBRWURUT3lQVnpyb013VnI3VTVEcUtXVWFDblBQ?=
 =?utf-8?B?c05Mc1Jsb3pQL1pKN0kxUGR2NmdsODJvNTRFay9mWkM2a3d0ZGxpK3pOY0V6?=
 =?utf-8?B?dmNJNjJ1U21NOU5MYng2Y0FrZFRuekhDd3UxZ1FYb0NDU0RHWHJpT2RMQXR4?=
 =?utf-8?B?TzNVbE9rTWJDUTEwVmpyQlVPbTVldmsvQ1o1Nmk5RlpuMVFDZ0NxdW9XeHE3?=
 =?utf-8?B?RDJxdkhBTTZsQzM4ZE1rdGxKQXV1WGZobXI1akw0RldjZWFXVGUwSjdlZHho?=
 =?utf-8?B?RUIyeS84OEIvVjBTbzZpTXRNVVNRTFBnUU43VUNoc1FBZCtsZnRqUExsRnQ2?=
 =?utf-8?B?MTBVaVFndWxkLzlRUGZrcUxVYnJHM0NPOVU1S1RBajZtSjFuaG82N3ZkcHVL?=
 =?utf-8?B?ME1RZ0VyMVNOT0lWMVk4eHBIOW1KMlY5a2xnV25kMWdKb1ptaHlaZmQ4L2Fs?=
 =?utf-8?B?MEdZMGp6SnY4aEI2NHByNHpZQnM1SlJSMnJlcEU0ZVplczVpNmxSTUNjb0ZE?=
 =?utf-8?B?cGNTMHk5Qk85L0loMG00ZGxORlRKM3JhOFhQKyt1Q3ZDNGp4TkUvZVM0ZGJI?=
 =?utf-8?B?czhTaCtsOEU5NElPeU95dXZFMTR5NDkxUXowUDlMS1ppWmYrS1p4M2Q0QWFw?=
 =?utf-8?B?K1c4V253UnAydmJKdiswVk1XY1E2Z2w3TEhpbVVsUW5BQU02aEZySWhNRjg4?=
 =?utf-8?B?TFhWT2xRUlhzSzRGbi9pVDBaUTFpN1puZ0ZOVWR2V3VEeXhCZWxvNDlxU2Zj?=
 =?utf-8?B?SVBtV3dEN2JEMFRSUmZmcU5PanFPTmNlS3pLVEVDaDVid3UwbmVkRlhJQ20v?=
 =?utf-8?Q?0v+s7XugrCeSXU/DwO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QLDevSGxyACiQ3eEVEeSZ9Utgzz21oWacAX6Lb7s8kmuIASec5hFikWmfzhHY0LYi6cqMgPUgsvNCute8EJWgkzgWGw/QYV5BY+WYbigDNQ2BvmjfprDPH7EBya6SHlEzC4Uu0SOk6G12fToyZpy0YEXroCuJpqu5+/ZMBy6FjomnDy5Nr3MMEkvZdAYIwnb4mNc+QhxJXYcvOLPazFeFUr95AWcmeHxAN9GRttMTxtj/9ocVnFoayqqYoVnEy8T6tecwZvoKqmc+6PFRb4TZSy3rSS8RgVmJR4WJ0uzX7lQMCzQ8ET92gPM2vaGmYL3AXqUhF7jGh7TqZFxR9FUhg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7a9621-eb37-4c8b-2f8a-08dec0dd0f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 19:28:01.1635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/gwtKqlPLIkcpyEose3gO/2aRVSVM2xnjQNNAgC8Y3KZ4PtU1qefw9uPIAakKi7qcjhJsOk7J10STk0BoTydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5661
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4OCBTYWx0ZWRfX8+PsSJn05bkB
 GJdYQPWVuYyNgPkP3S+/xWVCrn2xqqxE7iXRekO2TVrmqMTRdybPBMs8WbW7/50RsrnTqEnL7Ne
 H49K+nFInyPK4m0KD8q9ujhCfSg51w3nsZEVI1PtBGfLCe10GIjx3Hj9tHHagN1qAg+ZjvLntjc
 z5PPNptIvi5V90M49HHg70lkx/lsdBRzGY5gBd6ZQb6f74zUJ+bgr6yGHElsJfKYN86N6zxUqK3
 5l4DrPR6098F/28+J05Brsva/ujI3qb2nsAB0Lw+0RiJGSs/qdLXliT0Hw2MeHe9fT8lDCC0nio
 I33Lepcof5CW7wCrQpSnLCNNd5/JF37ZltGNzayhIKn2vqPfZEFXtO1gafMcW56+5q51S13kQWf
 MXMWjIslBm69tYwbKz6eWs4sdrdbMC+TAUIIQm4JvUMd2NSPdwt6lMmEi6rvF7/Eshn2ifGfGAM
 5784ZOef80nul/+2jIQ==
X-Authority-Analysis: v=2.4 cv=cLjQdFeN c=1 sm=1 tr=0 ts=6a1f2ec3 cx=c_pps
 a=sDpZAeY8NpNE74Aw/ijzBA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=M5GUcnROAAAA:8 a=tHhF_kez16Hrd9fCOkgA:9
 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Unlp40a1E2d4PUYXvlBlmTj7yxLbKlSb
X-Proofpoint-GUID: Unlp40a1E2d4PUYXvlBlmTj7yxLbKlSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
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

PiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiANCj4gRnJvbTogTmljb2xhdSwgUmFkdSA8cmFkdS5uaWNvbGF1
QGludGVsLmNvbT4NCj4gU2VudDogMTYgQXByaWwgMjAyNiAxMDo1Nw0KPiBUbzogZGV2QGRwZGsu
b3JnIDxkZXZAZHBkay5vcmc+DQo+IENjOiBOaWNvbGF1LCBSYWR1IDxyYWR1Lm5pY29sYXVAaW50
ZWwuY29tPjsgZmFuemhhbmcub3NzQGdtYWlsLmNvbQ0KPiA8ZmFuemhhbmcub3NzQGdtYWlsLmNv
bT47IHN0YWJsZUBkcGRrLm9yZyA8c3RhYmxlQGRwZGsub3JnPjsgSmksIEthaQ0KPiA8a2FpLmpp
QGludGVsLmNvbT47IEFraGlsIEdveWFsIDxnYWtoaWxAbWFydmVsbC5jb20+DQo+IFN1YmplY3Q6
IFtQQVRDSF0gY3J5cHRvL3NjaGVkdWxlcjogZml4IHR5cG8NCj4gDQo+IFNtYWxsIHR5cG8sIHBl
bmRpbmdfZGVxX29wcyB1c2VkIGluc3RlYWQgb2YgcGVuZGluZ19lbnFfb3BzLg0KPiANCj4gQnVn
emlsbGEgSUQ6IDE1MzcNCj4gDQo+IEZpeGVzOiA2ODEyYjliZjQ3MGUgKCJjcnlwdG8vc2NoZWR1
bGVyOiB1c2UgdW5pZmllZCBzZXNzaW9uIikNCj4gQ2M6IGZhbnpoYW5nLm9zc0BnbWFpbC5jb20N
Cj4gQ2M6IHN0YWJsZUBkcGRrLm9yZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1
IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KQXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQpU
aGFua3MuDQo=
