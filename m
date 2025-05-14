Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A0C3ABDA
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 07:53:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5214C4025D;
	Wed, 14 May 2025 09:53:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EB1D740041
 for <dev@dpdk.org>; Wed, 14 May 2025 09:53:49 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E5pcWK026104
 for <dev@dpdk.org>; Wed, 14 May 2025 00:53:49 -0700
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mnd806qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 14 May 2025 00:53:48 -0700 (PDT)
Received: from m0431384.ppops.net (m0431384.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54E7nxsY023504
 for <dev@dpdk.org>; Wed, 14 May 2025 00:53:48 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46mnd806qe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 00:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3xc78QZYZ6M8ua5HW5c+AGwdRmhtSoq28oj/eOAYfytV8zXXsFkpYsrw2Cc7dwFVZzrOPIwpSt7Q3kfj8xuez5tYIR1RYy3c/rAWgJ6rz7ztsxVB2jW4c1HkFG9Hb0MjUjqD88SuQRqvnRNVPxguJ0NxgiLYGqM1qKqiR98z4FEcyMW34CvWW1IuBBQfcwM/WSnGVckNLrnogdiVZKXV9TD7qxKUIBF7jdmzhtemCueFc5f1qe9Z7cL7zVd8ozKN/Fh62hvNrt4iLFFGjWj37k/6dIpzfby3ZiQqKBnf7L3HlWgrF/1EPT6RjWFuv2pKI78GdG55OU9AVPYsrnQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBYy+OMRTIoE1buKP7gCAQJl30EroOa1UoLHm+c0z7E=;
 b=y/QNi68ZMjOC8ulhrBTBY93wqDDCBCF0ujbNdlafU1INFagJEYIXZbvspPkHTkLa2F0r/g1TPd6MncdCXrJy6HpBRx5ro6sNz5OI7+TX8ZfjwK6K2X5LzTl7EBZfVPubv2M4gnuFZWvgObtjejEDf4zoNZSG+xm6AmOlipHbDikSv6S+SZi2/x4aueXq2VM2Tsi/50/g6/UaKHiI7/prbJNsW0Jp9vN4iwbW/7lvthhdz0Y/upf3PAt3Zlu/CzQqxvYAaQV8/jAQ7Y7DwiNfUqvuy8LewlRUQtMgDwGNm6Dc4JXUzukVtMwp4+6pGeOLDbvz5obi3lcRVrG7eVTdMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBYy+OMRTIoE1buKP7gCAQJl30EroOa1UoLHm+c0z7E=;
 b=hBurlXfFChPJntYCgViICyMtIBv8X3RoWb5H3mDTngA4yOWRONusCO/RYu4c5O3v4W+XgFSlny/SMoapKvyM+A//d3tMfyEMeQ7Q3ampaghfbdHK/64u6kEGjGHMaARYDHhrfSLcJ1+aBpj/zyLxc86GrrvfAI/n9Nn6TO5eFpo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3563.namprd18.prod.outlook.com (2603:10b6:303:5f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.31; Wed, 14 May 2025 07:53:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:53:46 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hanxiao Li <li.hanxiao@zte.com.cn>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2 0/9] crypto/zsda: add zsda cryptodev driver
Thread-Topic: [EXTERNAL] [PATCH v2 0/9] crypto/zsda: add zsda cryptodev driver
Thread-Index: AQHbjBg5z5AQOAGmAk6k0R/8phi/EbPSMdMQ
Date: Wed, 14 May 2025 07:53:45 +0000
Message-ID: <CO6PR18MB4484D50A064F9FA72EC1D31FD891A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250303031644.1041177-2-li.hanxiao@zte.com.cn>
 <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
In-Reply-To: <20250303082751.1053432-1-li.hanxiao@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3563:EE_
x-ms-office365-filtering-correlation-id: 55956bd2-8ec1-4041-a8ad-08dd92bc7460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHNRK1NYM3A3UkQrNTJ1bkZZN1orVE5ieitNSC9wSzJrVXY0RU1pb0dudE1F?=
 =?utf-8?B?Z202QWE4YlF2c2xJcjBVUDc5cDBtdUtORXFmckpaVWpTcDBGRHV3M3FIWDcv?=
 =?utf-8?B?c0JXOWd6SEtHNXRLZHpMbG52SWx2Yy91NlJVQW9maUMzc3UzM3VhaXl1R2N2?=
 =?utf-8?B?RkxoNjNnQWRicG5aa01xNjFaWlBUcGZYaDE4V09DMEdrZ0dQQW0yUWU1bHFG?=
 =?utf-8?B?elRrbW9LYnRUbnZIV1hyTEh4QmVYbEdUMTR2c1g5aW5ueEZQL1lVTkp4S1hZ?=
 =?utf-8?B?SWFNUGIzLytuYUpSTGplaXZqOFMxbW54VThaNlZwVndCbFBybHFNR2FsYVRO?=
 =?utf-8?B?bjkrcnBnMkRFZWhpMTVCbjhFemYwMnBnY3hiOTREWW84a1RCRWwxa011bUZD?=
 =?utf-8?B?K0Q2NURJVW50a1lDZ1RRdzEvYUZoMVdSQnJrekNHdVM4UmFmcnMwU3d2MVhW?=
 =?utf-8?B?M2ZsRFM5SFA2amk1YzZYb2gycHBINitJbGVDaXdtT3JZOFlHM0JLQzdIek9h?=
 =?utf-8?B?V1J6bFIrTk5CcUFDei9nWWMvQzJoMVJibG05Y2tLVTBFOE1hSUhJZXJLUWpC?=
 =?utf-8?B?eWN2Ry9YUm9uZ0huUjRkS2FuQjZmeElIQ1R5b3prZGwwdU95T05hd0xzbFMv?=
 =?utf-8?B?ZXVGK2FjdjNKLzdSZy9VTjdLeGh1RE9rNE1wb0tLbUxKUE5GdUZBYjhGRkFh?=
 =?utf-8?B?SjY3RzdLQW9nbFBQSndsQXVPd2RSMXNVL1hHRFdBNU9SNEpiS2tXSENRUm5T?=
 =?utf-8?B?M3pOV010OTlQcldPKzVOd2k4OVU3WDRkWEZTSUlBc1h4U2lrbTA5ci9Iemh0?=
 =?utf-8?B?R0lFT1lFOU12YWZyTW0zSElObW1TclpNa21QRHFnWHc3MkluRkVpMHZ5UlAz?=
 =?utf-8?B?cEU4OXJQSGNXT0NVLzV5ZEtEbWp2TkJ4dTRJdVU0Znh3VHpBS3JXNVFOdkJB?=
 =?utf-8?B?OG9UZTRyYzM0dnVLYTNIVmFhU21mMkZpRHA3Zy9lVEFDMjgyd0tuVlVLNCtE?=
 =?utf-8?B?WTdqZWlhMHUzWnN0M2d2MzUxeXBlN09vSDJCN2c5YjRCWFRJZGw5ZnVWQnBK?=
 =?utf-8?B?cFRpSlBOelpQYTh2K0VZYllIWThhVHdyTE9adGVFN2orb2JiTDA0Wm1ibWdH?=
 =?utf-8?B?WlI1a04waGp0emFKY0JtMmJtMlloclJtWkVTdjNhNTZXbHRrcllSVEFrSjZG?=
 =?utf-8?B?dnRIc3RkTVlTZFZVb0oveFBIZ3Q3UUJxZEYzdXVOL2oyc0lNMmZWZ1M4dVho?=
 =?utf-8?B?aERlMUxTZHlXSHlIMUtZQ0FCV0FHWGZIMktpUGowdWt3RUREL2NIeU8zNFR6?=
 =?utf-8?B?QnFqNzZvQmE5dktFVEo1bVZSTExOZStOZENVemlrK2xCbFlMa2JzajR1N05L?=
 =?utf-8?B?RUdraGFaNmtaajdKNEZuZjNkTlJPdGY4Qi9zOEYwNTlkTWF0ZnkwNkZaNTFV?=
 =?utf-8?B?QlZOS3lCOWg1YkNaZFQ0TGQrZk9wTm9ReVFwZXVRZi9OR05PSm9UOTg5WkdT?=
 =?utf-8?B?RnZjL0tFUzhKRVV3SlZEWC9nb0t2cE1ENnhRSWNXMVY3by9sTUZ1dXF3MDUx?=
 =?utf-8?B?SDV6c0phQXZvamxHN2lEUmhnRDlvWmtQVXJPbncxaUJSUFNCQVh6KzVoRDYx?=
 =?utf-8?B?VCtEcHU4VitRS2JveXIrdzQ2emZiRU54MnJYYnZaejh0VkZCRkJEdU8rbUFJ?=
 =?utf-8?B?aGF6RXQxdjYxMkY4Um9NTGoyTWR6Q1R0QXBZSjVpN1JlVE0xMUMvcUVsVVRV?=
 =?utf-8?B?SVdpa1pMNXMrczJwd2EydUlUaGNvUlFGVlpFbWxRR0o1ckR1ck9LOFhZb1Yz?=
 =?utf-8?B?L3dIcjlmNll4emhaU2tPMXhyOVpkRkFlZ0thRHNkYnMrRVBJZ0xCOGNSU3VT?=
 =?utf-8?B?czZkQ0NLOGF3cmF1VjZZL1ZiTURPaGpSUkpEbFlGc0daM3dUMk8ralZIN0Nw?=
 =?utf-8?B?dFBaalJFc1hhbFNibXgyVW9nYzgxT3JYNEFIZFZBMDlubWxZZ2NhQzdycS9y?=
 =?utf-8?B?NGpMOGViQ2dnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXJZU2JEYXRNSjJJYitUeE13R05uZXk4ME8zcFVCMk9ycklNN3ovcFVlRDBF?=
 =?utf-8?B?UURaTE9STklKWFZCRlQ4S0xYaGVlYi8wWTQ5Qm9qTHBJOVpaSHJQakh6SElx?=
 =?utf-8?B?U0plNzJweGMzRkJ6OEdaM3ptQVlSbHlsYlJsSy9UdW5rWG5wZVFZN2lxa3Yr?=
 =?utf-8?B?aERRa0tkTUkwRDBrZ2RyQ0JoTGE0TUFRTWgyNnlCNG5CeEJCSzFHVlh1Qlhp?=
 =?utf-8?B?Vy9UTkhsV1p3RlQ1TzAwbUZUQnA0WWVvcERLQm1yYldrbENVWTVsMVBzOUVl?=
 =?utf-8?B?R1J2TEpEOHFFNC9ML3dHaCtoTFhPcVhmZkZJbWZHellxVGcwL2hFZ1EzaGN2?=
 =?utf-8?B?dFZITUJOTVcxcG91eUxmM2JVcFVwODN3WHdaay9qUGdQN3dlUDAxREtJSWp5?=
 =?utf-8?B?aFFuS0ZvbUk0NHVNNDNnRVJpWkR1YmlMczVhVGFuM1c0ZGZuNUc4OG13NEtY?=
 =?utf-8?B?a0s5NEI3cG9CRHVxdm10K3l5eHY3YXBPdWNVclBxbURaSXM1eGQzelcrRzI5?=
 =?utf-8?B?QlRIQ2xhcXE3RnQzaVBLaGNRTytpcmdISW5EWWwxcjJYd0pXUWNvUms2cGZG?=
 =?utf-8?B?UzNaenlHRVhHS2NhM1lseGNaeTdoUEpwN2JxSktCckpNdlpFT2Y1aVV6cnZz?=
 =?utf-8?B?UnlNSUcwalJaNUVFS25HWk8waDUyOXlxa1VYYTlqY1RxUGREZlpXZC8yQWY4?=
 =?utf-8?B?UVV4cHcvb3ZHV2tYa2dadERKRGFsMzNOYTduT3ZRVHdYRUtOWStzdGdqeUFw?=
 =?utf-8?B?ZFRDN1g2TENOdWdNdmVLdVI2c1E1U24veklRZHJqcitGK2ttNzgrdVZpbSti?=
 =?utf-8?B?ZURyKzZMUFBLazV0anF0b2VTaHN4MDhGSnIyRnUrdXRJZ3kzczNxYitvTFQr?=
 =?utf-8?B?OURjbHBiMmxpRHA2ekdMbUpmSWN5NEhFV1NqVW4vTWJORWIzMzBlQzdsMHEz?=
 =?utf-8?B?THk1OXBNN1E4czE2cEV5Z0UyblJIdnlSdzEydmtyTGZ6Ti9Rb2xPb0JyU0kx?=
 =?utf-8?B?RHdid2pQc2s4NHc1RktpWElTNGRCR0QxV3VqWm9GOFl2MzRWNWNDY0xKQlZK?=
 =?utf-8?B?Q1hJeDdBeHJqWkYvTTBMa3hmY2hRZTJya3pIY09jT0ZhSzhrVXRFdllhZ1RH?=
 =?utf-8?B?V1FUTHh1dDhEc1ZXemFMeEtvOE9lZlJVejlXM0FqdCtrM09QaWJuRDF3elho?=
 =?utf-8?B?S29qOFI5OGpqU3c0VnpFeWErUWkyVlVSaVl5NXlscEZyYVRxYmRlaE1jMlJh?=
 =?utf-8?B?NzNrOVVWcEVoMGcycFFzTHQ2cDdWOHFkKzMyTGxmd2x3M2ZYellMc0RDaVU0?=
 =?utf-8?B?S1pMSWNrU0VUKzhrNmJxVTg3OEpVNWNFcXZhZWZBVFdpL2tFN2ExdW5SdXhv?=
 =?utf-8?B?dElEMEJ0ZVAxekU4bk5QN2VBVDB6VjJlcDA5QURyek9vNVEwcW00YmFDc1Bj?=
 =?utf-8?B?VEdWcnRDWTV3dWdOS1hJTStnK0VSdkVsb051QlJ5WDhyNW05anR2eXF0UXU5?=
 =?utf-8?B?MDltY2FCVjB2Q1RnQnNKckxBWEVaTSsrZEFMVm1ydzdjMU1aYnVMTitkcE0z?=
 =?utf-8?B?eWl6YWtyRHV2NlV3TERsVDR3NmpYZ0k4ODhOUWNwYko1MFRYOEtxZmxOVkpX?=
 =?utf-8?B?K2YvZEJ2ZUhkNnJMSWtHbHNmVlhoN0NvRFhzMkZqekJNNisrckRaZzE2RW12?=
 =?utf-8?B?b2NGc2FHTE1LN3MxVmVFekFvVDltQ1ZTWnpxWFJHUHcwdnJxYVo2bUovd1ZV?=
 =?utf-8?B?QXhrOXI3Y0EyNnFlNTBEVnpBaXhKNXRVKzBHcjBaL1l4bFFlY2dVYmVSMmM0?=
 =?utf-8?B?ekpTNzZrK1llem10QUJQK2hnN1dwK0U3QTFKUFpVNTVlSjVGZEFsbUpKcFpK?=
 =?utf-8?B?MmVFL2Z1Ym42S2psUW9ab2N5a0RYc0NtU3lqNWNwaXVyM2FwSTIyRUJ1WlEr?=
 =?utf-8?B?Y2FiZ01uRENuVzVjb3dwekJIb1lpWWFoWXdXclZrQ250RVVGb0svMkFESXY2?=
 =?utf-8?B?Ry96emZCRlhUbFRxSDE5S1dWNi9OSWV5bzNYZG5veFhObCtnUWxkY0FJMlZS?=
 =?utf-8?B?ZUNPWHByRCtha2grb2xIdVRsQVRxNTRkSEhBWDdkZWh2OUF5RWNNNldGNWpZ?=
 =?utf-8?Q?bj8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55956bd2-8ec1-4041-a8ad-08dd92bc7460
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 07:53:45.9896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExD7lKrZ6yqdZD3iYtMWq2wum0PcPagaenc4PSZO+zCDrwNaQu04Y4s8HpB9WA7O5T4MSNuQP6RYamWAgSX8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3563
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA2NyBTYWx0ZWRfX+ZZVBxJTg1/o
 EKIPmlJ/7e2rX44ZhXc+ZgquXksJdGgZcaByIl1KKKElhUN8PqhXd8RcjpwmfFQ7EqPwcrkt3pE
 zVWlYizr5+eolhclDMY5ozEUUnMiP1l3GcPv5N1KK8qT4v8fzwGzQqmSga0M9XXYsju9h/AA+Dh
 2hMcFC/1yncn8CFpw7RHWzcmHru259eS6htGeEK2oCpVVyo6bS7NWna5H9Y5yaBeQ60x1DP59nb
 /CRnjTFkD2MatAIT/nOi0b8sm5UQY+BdCZPFi2Vpf8K5SQjruOtGxFJnMAIpDGS/7tTaYYJ+RXa
 2wCakK9zhl1L7AYNfo4SUE+xZwP8rfAxa217FJapmPwT0PuLcD/HIMe6cQqjX8ub62R3SBgLYJQ
 Jb1RIQyxFQnXaC5JrODMHT8+MfEj/22jR1iYrRF4lJtjLpITJHA8cVyhoupPCqYM2kJhD4ab
X-Authority-Analysis: v=2.4 cv=FYo3xI+6 c=1 sm=1 tr=0 ts=68244c0c cx=c_pps
 a=1mby/iHf9ieL9308fKykyA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=-AAbraWEqlQA:10 a=NchhL6fwHPwTGSkwpUEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AiXQAa1QkHYFQ6byi7SQn6-6TZ_dlDp8
X-Proofpoint-ORIG-GUID: YMQuJR768b8fqipAK4vyvtTn6TGzHiKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
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

SGkgSGFueGlhbywNCg0KSSBoYXZlIGNvbXBsZXRlZCBteSBmaXJzdCBsZXZlbCByZXZpZXcuDQpQ
bGVhc2UgcmV3b3JrIGFuZCByZWJhc2Ugb24gVE9UIGFuZCBlbnN1cmUgYWxsIHBhdGNoZXMgYXJl
IGdldHRpbmcgY29tcGlsZWQgc2VxdWVudGlhbGx5Lg0KDQpUaGFua3MgZm9yIHlvdXIgcGF0aWVu
Y2UuIFdpbGwgdHJ5IHRvIG1lcmdlIGluIFJDMSBpZiBhbGwgZ29lcyB3ZWxsLg0KDQpSZWdhcmRz
LA0KQWtoaWwNCg0KPiB2MjoNCj4gLSBNb2RpZnkgdGhlIGVycm9ycyBhYm91dCBjcnlwdG9kZXZz
L3pzZGEucnN0Lg0KPiAtIE1vZGlmeSB0aGUgZXJyb3JzIGFib3V0IGF1dGhvci4NCj4gDQo+IHYx
Og0KPiAtIEFkZCB6c2RhIGNyeXB0b2RldiBkcml2ZXIuDQo+IA0KPiANCj4gDQo+IEhhbnhpYW8g
TGkgKDkpOg0KPiAgIGNyeXB0by96c2RhOiBhZGQgc2tlbGV0b24NCj4gICBjcnlwdG8venNkYTog
YWRkIGRldmljZSBvcGVyYXRpb25zDQo+ICAgY3J5cHRvL3pzZGE6IGFkZCBzdGF0aXN0aWNzDQo+
ICAgY3J5cHRvL3pzZGE6IGFkZCBxdWV1ZSBwYWlyIGNvbmZpZ3VyYXRpb24NCj4gICBjcnlwdG8v
enNkYTogYWRkIHNlc3Npb24gY29uZmlndXJhdGlvbg0KPiAgIGNyeXB0by96c2RhOiBhZGQgZW5x
dWV1ZSBkYXRhcGF0aA0KPiAgIGNyeXB0by96c2RhOiBhZGQgZGVxdWV1ZSBkYXRhcGF0aA0KPiAg
IGNyeXB0by96c2RhOiBhZGQgY2FwYWJpbGl0aWVzDQo+ICAgYXBwL3Rlc3Q6IGFkZCB6c2RhIGNy
eXB0b2RldiB0ZXN0DQo+IA0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgNiArDQo+ICBhcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5jICAgICAgICAgICAg
ICAgICAgIHwgICA3ICsNCj4gIGFwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2LmggICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgZG9jL2d1aWRlcy9jb21wcmVzc2RldnMvenNkYS5yc3QgICAgICAg
ICAgICB8ICAxNSArDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvZmVhdHVyZXMvenNkYS5pbmkg
ICAgIHwgIDUxICsrDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvaW5kZXgucnN0ICAgICAgICAg
ICAgIHwgICAxICsNCj4gIGRvYy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdCAgICAgICAgICAg
ICAgfCAgNTAgKysNCj4gIGRvYy9ndWlkZXMvcmVsX25vdGVzL3JlbGVhc2VfMjVfMDMucnN0ICAg
ICAgfCAgIDUgKw0KPiAgZHJpdmVycy9jb21tb24venNkYS9tZXNvbi5idWlsZCAgICAgICAgICAg
ICB8ICAxMiArLQ0KPiAgZHJpdmVycy9jb21tb24venNkYS96c2RhX2RldmljZS5jICAgICAgICAg
ICB8ICAgOSArLQ0KPiAgZHJpdmVycy9jb21tb24venNkYS96c2RhX2RldmljZS5oICAgICAgICAg
ICB8ICAxMCArDQo+ICBkcml2ZXJzL2NvbW1vbi96c2RhL3pzZGFfcXAuYyAgICAgICAgICAgICAg
IHwgICA5ICsNCj4gIGRyaXZlcnMvY29tbW9uL3pzZGEvenNkYV9xcF9jb21tb24uaCAgICAgICAg
fCAgMTcgKy0NCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW0uYyAgICAgICAgICAgICAg
fCAyNzIgKysrKysrKysrKysNCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW0uaCAgICAg
ICAgICAgICAgfCAgNDcgKysNCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fY2FwYWJp
bGl0aWVzLmggfCAxMTEgKysrKysNCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fcG1k
LmMgICAgICAgICAgfCAzNjMgKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEv
enNkYV9zeW1fcG1kLmggICAgICAgICAgfCAgMzcgKysNCj4gIGRyaXZlcnMvY3J5cHRvL3pzZGEv
enNkYV9zeW1fc2Vzc2lvbi5jICAgICAgfCA0OTggKysrKysrKysrKysrKysrKysrKysNCj4gIGRy
aXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fc2Vzc2lvbi5oICAgICAgfCAgODEgKysrKw0KPiAg
MjAgZmlsZXMgY2hhbmdlZCwgMTU5OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy9mZWF0dXJlcy96c2RhLmlu
aQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvYy9ndWlkZXMvY3J5cHRvZGV2cy96c2RhLnJzdA0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW0uYw0KPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW0uaA0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1fY2FwYWJpbGl0aWVz
LmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NyeXB0by96c2RhL3pzZGFfc3ltX3Bt
ZC5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcnlwdG8venNkYS96c2RhX3N5bV9w
bWQuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3J5cHRvL3pzZGEvenNkYV9zeW1f
c2Vzc2lvbi5jDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcnlwdG8venNkYS96c2Rh
X3N5bV9zZXNzaW9uLmgNCj4gDQo+IC0tDQo+IDIuMjcuMA0KDQo=
