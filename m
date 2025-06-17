Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD1C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:26:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1693B4279C;
	Tue, 17 Jun 2025 23:26:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E59AE400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:26:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HINmUG010327
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:26:37 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2100.outbound.protection.outlook.com [40.107.220.100])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47aw1kthka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 17 Jun 2025 14:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/wmHVd14zNEMVEfpFWwxhF2eclxA2YLdjb/ZNLkrdvtOtd21yDJz295UZcy1imZYj0pFdHG/R8AM+p65RIhXeFRv8bENRmpi1bsQnSRyzSGG+JAlbDLakeCQaUfCldxO5BCvZc347pNettNtDQxBTNFOBcyPD7d95ntBYeAtyr419aUu2R2ciDccopUJa76HJgv/v9jwyJ+45snJiV1KpNwPgQlVdOGaLJ8S5IwPeBKECaVZbEkXLoKCiYLwrrjgKHnLsMU/SAZMXVzSZxllik3z2pWUrUJV2TKFoRhJDHX5PwV35MMqHi136f7Hf7g6AV4qPoxWbIs2HvVErS3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=476oHCjBn0HREnD4M22BLWjoBfuIW6U72seQgGOxg2Q=;
 b=QoBJRN3zz8k4PiZCFmcTZs5yUcTjG2WrgdCkYAJo2K8aZgcIXzmkOJL7qbWqydResXp66UADDIY0ajfpfdwWF/R4deDj6K5U6ARfDhgow0S1AdlYuPriJtIM6171lMGAntB0zEdgECYGpaRqfCxMwfGULTz/Bh83yjVIxmr8hQu+dDFwlcBcd/tRT80MiLIcDpp3g2GH8glzwE260MPFybWzvEzdaN21LFyvgk/NIRUxEzHegLupGB618QJYQYR5w/p5NiZgWjXtkPPpjflQQ1uq+u9dsEA6ksgXqET5ygtuXYCv5I8+hrF/J8sMaxchY5+Vphy7+SIR9UE38LGcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=476oHCjBn0HREnD4M22BLWjoBfuIW6U72seQgGOxg2Q=;
 b=QCWNXLFhR21n5Y4zdSO3sgUdAWi7hnc2yr+aWYvCpDZn7RG3LplDRG8TKzg9vmo1eLYR1uzWAkYWUFZFgHRK1+cern9wPiu9gb3EE4/SjFvX5xupJ5hZQUaRw6BojbqAviCWfvfUp5lN/S9ceUvtAAu57FsgI5ICW2t+qDIOKC0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB5261.namprd18.prod.outlook.com (2603:10b6:806:2eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 21:26:33 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:26:33 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>
Subject: RE: [PATCH v2] crypto/cnxk: add crypto adapter for cn20k
Thread-Topic: [PATCH v2] crypto/cnxk: add crypto adapter for cn20k
Thread-Index: AQHb34y/pFz+Iqah1U6wRNKkp5lqTLQH3cWQ
Date: Tue, 17 Jun 2025 21:26:33 +0000
Message-ID: <CO6PR18MB4484E854A10886B575A0C7D2D873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250617105823.105906-1-nkaithakadan@marvell.com>
 <20250617133545.175869-1-nkaithakadan@marvell.com>
In-Reply-To: <20250617133545.175869-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB5261:EE_
x-ms-office365-filtering-correlation-id: cb6f2ea1-7373-4606-8d3e-08ddade5a22e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KHFHRlzgBu/Ji7Gynq/Pq6Yv0l41S4UT6PgTrY7XIUJdtnTfJ4b+AhOjvpvp?=
 =?us-ascii?Q?8QEXElVZKLxDh7wlc7X6GTwJlNYA3L13iwwb1CPMpGoRciJtuSadvbCWzcEz?=
 =?us-ascii?Q?dp2/6SJd8RkDJPrNPtj6q7xdPeXMFK0ITx5zN7up8HH4x75JahY7PZm03e6z?=
 =?us-ascii?Q?ERbBmIOiqv5zLcxrKQ0Bx+rcn3b4E2KgWS9BX8MztPT83ra0LihJFawhpTHE?=
 =?us-ascii?Q?IQpqgVqaRgOW0AP+aV1JleuYefUAqBYhBY8j4mUsZ4Q+FSBg0e+Ev3tMheKR?=
 =?us-ascii?Q?49SEW2M+lECdSbmavWmim3Oflv2IbqfpB1FXxvIA09H7O+eVNM2Em3GPps8q?=
 =?us-ascii?Q?nbvmqMcTMODWvZQMTBeLQ1tnpcXuJM/GufPReF5zRQOMLvit9DN1hFjwmexP?=
 =?us-ascii?Q?YjRcMdH44DbYLpBzZbhpfNosUg8L99hJaSJWYl2mtrAmrTqN8R2uSlDdW3zZ?=
 =?us-ascii?Q?WCkdWcwx4HHaa/Fr0JHPGwJWrEcjXh3TY0c7abXg1pWDeG6Qr6yH2cevjYe+?=
 =?us-ascii?Q?225EPEXlMEBfaajVUKURXRzf+uobSdifQai62xqh0DMHQaeoyYNEO4Chu3W+?=
 =?us-ascii?Q?RLKxHcl4gpEz+GTTMhTunpEdNYFRdrUiby+m6B/OqqK43u1gW9/K5Z+Q3Y3r?=
 =?us-ascii?Q?B0Uz03LDt1Tkp8HFdhxCffj3d+2lFJcP/YrCAecE0nf26btZ2SZk294RL4sj?=
 =?us-ascii?Q?6y6mEtshv4c95Micw9NSnkgaAMHgzHaxhTPB//qDM6mM8FdJot8qjvGa1IhZ?=
 =?us-ascii?Q?EoD18nyYUIQ2g/Dvx5dVYmr4jqf0CQ3sH3xzPCYqEQDK99Zsd6/9hGCWM3Ql?=
 =?us-ascii?Q?wpjGqBnM21K9jHi6Cwb0WlIzx4Yf67MBrdliURlT4qBxitgZxepdvzBV1sj7?=
 =?us-ascii?Q?AijAc3+a+2jc68EA0vCTtr1BIYks8zS7mjAWJXo9fm29KlAMLKlADPAjSsZE?=
 =?us-ascii?Q?+kV6E54wgFGy+4to54CvFQa5YWSG/ChzGI5S3JzttsoTrOQn1B6CsEzTBZ+a?=
 =?us-ascii?Q?TcDPr8PsGrEfxSoaNUeBX/5Wj1hJPJB19WC/Ty4wmBvxPcgZo4v7DZdw64YH?=
 =?us-ascii?Q?/qOnKiJCcXNFd9Dzed2SszRUMBoSqcgjRt5pH3tqVxBHIDRdQbkLMTPkI9TB?=
 =?us-ascii?Q?NEavrUJzuh/RDjWgqeAht6+/VXvKWn0gd+UXOUiRQbSuk2WavTKd22shsRcQ?=
 =?us-ascii?Q?MBl5FCPCIYzdIJr0vPQ13EGmiiHMZeERaY9UjgxogiRCeIT/Q8rEhJ6yBQ1s?=
 =?us-ascii?Q?+z+bYfqJy5Lfj180d1RM1i14eE1RCwKBjzf74jH4yVhGtJ3ET3TDylDBsNkx?=
 =?us-ascii?Q?RelLJHJoxvg1CokKSPAj/C8JDmbVOWyvL6ao+HCls/kMEyZpdEALOxJFjo7S?=
 =?us-ascii?Q?wzLI+NgKqIgkmBBpt8aQaOzkT1qCgJV1ix0fb18VFawGtbb+RLJwmZUWP5ij?=
 =?us-ascii?Q?/par3V4RS2ZfXd3CZGwUJtk3J0/fltUTYMm49ReCkJGT9eQcng2ddQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nVQJ/67o7M5+VVlB+WV9KQNqFvnXlbmTm3XxLP27cobv3ZQ4F8XlGIpZeiJJ?=
 =?us-ascii?Q?qiZqHMcGf1CfRBFzemtjY+W8yLHkRQoSOBQrMpjpGEoObuiLf4ZVe5eHgGnO?=
 =?us-ascii?Q?7RW7IziLLuT/c8N2xt8WKYeVfYfYW1S5X3vj/cJT0k2nDDtV/F8rJzT/UILP?=
 =?us-ascii?Q?dIk8tShDh68KxqobEC1Br+8ivGul7dfAepRqemGtdurb4dmvXSB4g3aH0tDO?=
 =?us-ascii?Q?pv3BbxL4apykfGeF2fS7vOL5DCvFbNz4YbrcFrYcY57rABbgSRlKJrDQfAX5?=
 =?us-ascii?Q?UXLzlmPY6KfN2Fi01YRFJhUp+oNqa+/3ApEvW4L8Aybc8Hj8+YafjI1eilvc?=
 =?us-ascii?Q?icru2rag0JlGpByOJ0L7zIarFoCcmSZJnQHrUJsnQbMPf2bFPdBHiBdCNaaJ?=
 =?us-ascii?Q?Gi9TngTKOIEq5neBkBjXfTA2voIbXdkm6Lp0NlsxeBVO4ysrCAArdEp3z5IJ?=
 =?us-ascii?Q?yC2svRuBa73TXkWHIvh0s0NEEgQpUkMLz9MQjsPvh7defGupG9+IEQkW+HAa?=
 =?us-ascii?Q?GeelieW+XLzKzq9DjNSlytGeInG7dwZm3iUcRUxe95UeKCUmxyKC30a8tFlW?=
 =?us-ascii?Q?1KhYPaFqbtnaw1pVJ2g1Q4d8xdeMxREyhIe4eQMDFE4VhWnwSNzWCuwXjMqy?=
 =?us-ascii?Q?bqMzdDvCXymS+KoYoJaYd7y5kXTSCvC4OvtEIyXLVtiHp+R0JGRA788Ds8SL?=
 =?us-ascii?Q?T0mxwZKv/+KijW8AmCd8gxRkttSNUc/cljNJlhlg2lI4sW8D/HlGsP4u7CWL?=
 =?us-ascii?Q?I2+/JWXsyeo/+7Y/8HpfsgVJTVIKO2U3p+FmKbkDbjimJ22+/Izv2a8uQe29?=
 =?us-ascii?Q?nyjQxIHrvpeoAXjjSf2E0IU5Umq20As899rY+ed4H2DlTUXjIa95CE6emNT4?=
 =?us-ascii?Q?Sc66tJs9GgahpHk6KEqSfWk/lldIH9Z9yTiVEqfj9630V0ZvgYPZPH4VbaOH?=
 =?us-ascii?Q?6wQLvG1BxnFCmFcERWVsu5YnSJFsD0096cRpwAudek5XsvtVlitdvhL8qvGA?=
 =?us-ascii?Q?GBXkFWE208fPJpBZkNTeiRv0Nfy/4EaGm9XmBDMNxn6W3d4imqQyL/Hsq4TE?=
 =?us-ascii?Q?q4qCncskCt1P/JzkJT7htf72tQKgY4sPmfnKD8T2zbG/4mibAL9e4E39l0in?=
 =?us-ascii?Q?CtRN3ju7C23qi4Qf34+d+bnh75uwakLrqKQt3bV2i3p1Ba40EtiandHH9xf8?=
 =?us-ascii?Q?PkgCaJ9qWO2lseK+wYQs1pp5/H4Nss6nzZzXUn62UoHhraHLH1mrYo67U38g?=
 =?us-ascii?Q?qJcpAZNlxzTXMoTkPUh69Er765My+wO2MjB+7pJQBa4P975k1zyTsUS0BpEq?=
 =?us-ascii?Q?WxxLFRLiP6v5sFKmsus+vE2g2FxueTMwXGkFoKUIvM7X2OhJ5UoGnfXkjgTl?=
 =?us-ascii?Q?8wJnYZIet01d7ttBNO3wQ2fccSGJbrSEPlxgpH8IHHw3hP1TsgoAOZcxAW8Z?=
 =?us-ascii?Q?oPeMq5ARro4R8t4egn1dzo/SGEKsaMBb/JHGOFY0LkT+FGxv3HPhhgfOo0m/?=
 =?us-ascii?Q?5z1/iGVqTHpbdSYqPi08Ik2q52cPcHgYbRSsVKprWIPakCejJRQbJfVsP5jY?=
 =?us-ascii?Q?D6je8ZhxZlzor9oe72d/K+aOXdC+h+tvdmqU522d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6f2ea1-7373-4606-8d3e-08ddade5a22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:26:33.6421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKxY4EBwCImgwOlzeQMBunHlJfByYtUisif1wScHP5EEaZi0UBQiph5SZIOm/jwHuvzKBlYoK5sT8KYSNCFMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5261
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MiBTYWx0ZWRfX7ZJP1b9Qt23A
 xg2t2zOX5FHa/hUzO34m/3jgdyMtS0XjVRHTZO0mRQ1Pf/2FXVUC1FVoNGQDrTbkehj+zsoxRPm
 6AFuZGT3DxpES0fqHCQWXIsifwSwpOKBE5rhoTHLxGoh6Xc0WuuqfmKtGvyXgtS/BG8QJRVNS6r
 s9c4bvM319zP6/XweBFD70x7Fpcksdk3S2DQsxCtn3yrqR/kdT0S3Dby1LvRT1I8jkvM0CgM8LZ
 udMe4bTYPdyJYF9zgkatH4feb2g62L8ntvTgZGO/Aw04p3E5eqrGayXtYIkCsI6BlOfbFHzuBhM
 mMAe6/FXBXNJgMnvCPAjP9y27MO6Va2aTEC5XqwotcPbaqvVYsdMhkXnnyHFczbXfpPprUqoFaT
 D98e5cFeZdVmSxjEzjwJQpGBQ/bBnwVGjWqSorQcGbtIyJR67vvznCA7XUxewLntT9Vkairx
X-Proofpoint-GUID: SMNIXb155GJp4PJpk3qx5Xy4osrNGxK7
X-Proofpoint-ORIG-GUID: SMNIXb155GJp4PJpk3qx5Xy4osrNGxK7
X-Authority-Analysis: v=2.4 cv=VM7dn8PX c=1 sm=1 tr=0 ts=6851dd8d cx=c_pps
 a=pYsK+mYEJ70NhtUmOafHWg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=5e4nMFGB6dc_RNdO9JQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
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

Recheck-request: iol-compile-amd64-testing
