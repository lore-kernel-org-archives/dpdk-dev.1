Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CDFC44512
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 18:35:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDCB64028C;
	Thu, 16 Jul 2026 20:35:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6E3014028B
 for <dev@dpdk.org>; Thu, 16 Jul 2026 20:35:02 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GGUAL31879503; Thu, 16 Jul 2026 11:35:01 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020118.outbound.protection.outlook.com
 [52.101.193.118])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4feddnmhmb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 11:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjUveFeo2DpAOJz8xWLxo4WoLhLEDRGJz4qWXpN6NMH9mXPz/3p61j5kLKL1+YlkdoSFgUE20eTAI2XDeBLyj6Gu3Wt59UzK3uPp2xCOxScUyv7ZWtu64cRJ1HDH1DNxE6iSzIp17LorCZzivn0RriIf9XGlMsgQ2B38V7XSfkoi5ALoXr9L0E1ml2TYpi+2Gwxrs1fYFLEdKKu+mNBhycGYccxfVJvqqQF48gzMqAzQ9qI45ocM07vYxHKhiC3dUQiybvq3hkfk51BOmW5VaLojj8WOtXlizEgS/ir8o8hdcqQLVPcbB4L9gWIMgung0rLPBQrTJr1dpZQeoFsNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mj5b8wd2d0Z2uwAUM/2OdCdt8McbZ8DipfBJhOGHBu0=;
 b=h1lWncyMetuKomqC7jpCX4twZlR4LOiRIF2GR0U307DjyaEYnJA86/cLWJHpavSyI9ZDz5kqGc2+5G0FhruqJ8PrA4+7tGwaRZ2jH78sosfiWf7CEoS7MKPTD/ykjr07JQD7HBWiuwPNRAcVcGnxr/iUnpSgxgPjF0YKYuGtQgOHfbwQVW7VAeSoP4s4sCrcDCCQ9Kgr+eZ9H9OX602H6ngIkduosZZ2X1R9d1Ilxi5hzYvHwJUJpwFQf3OFqk5/6+y3qCUdD2CcT3kDiy0J7dasfR7g3qXOTpCBkVmjH/gOvDSrYCU43B8J6v6xUtO5aRp1G/KcXYgDXv0z/wDFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mj5b8wd2d0Z2uwAUM/2OdCdt8McbZ8DipfBJhOGHBu0=;
 b=TMFATAOIiGZGJB9v2oh+JFIfCerMArmOBDqsJrXWV2AUuLkWu5GI9oIklTeoDtL7kEfkjrUXFUARrZPT4XP/AXHqsb391Um81p8p0SrZ1h3v+NDWRoJ2I/TnCZoODZ9GSSTQ8kQadt75CNLk0sMtcoUtDAWqi6cawjxF3aRb6Qk=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CO1PR18MB4571.namprd18.prod.outlook.com (2603:10b6:303:fe::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Thu, 16 Jul 2026 18:34:58 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 18:34:58 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>, "Jiang, YuX"
 <yux.jiang@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [PATCH v2] crypto/virtio: cookies are allocated from mempool
Thread-Topic: [PATCH v2] crypto/virtio: cookies are allocated from mempool
Thread-Index: AQHdFETclOK5gOTlLkWfRUTPG9iwp7ZwesPQ
Date: Thu, 16 Jul 2026 18:34:58 +0000
Message-ID: <CO6PR18MB4484282A7F2C577F358170FBD8C72@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260703144931.2541180-1-radu.nicolau@intel.com>
 <20260706095746.2586714-2-radu.nicolau@intel.com>
 <LV2PR11MB6045F2B5B35E1448045B866781F82@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB6045F2B5B35E1448045B866781F82@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CO1PR18MB4571:EE_
x-ms-office365-filtering-correlation-id: ea9af9cf-3bc4-4d3e-b1ab-08dee368f099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003|10067099003|38070700021;
x-microsoft-antispam-message-info: 70d1hZJP7MUV6YlG5FLhFqpxVW7JcJVsFhBL9yrqQce3yfJztC2M5FdlKr+WT1wQ4DlJlnA81D+DlvQJHFiTZpLPnH8hMQRl15Wa3/85nfT5aeZmJ38N9jpLBTD4e69AO/s0iNwvTNdq2ncc/LtfzMNsOpRXiuOKd0VfB9MnWgnwmtLshFdMialaIsrudGbvmEkX6H0CLOwIs9P32MfXyW1P/GpLG4Wm6uNKHpN5e0c22WswlpTb4CI+643/G/E/o6JxYrYanHmaARUP4arsPnYxh9AoMXLCq3upqpMcBLCYGf7ZsR1Q9ShnT3gf0dVrFDfFYW6pMk4XI1yyEp3+K/2vwR+9/gjBuGy6Pw3fgZvk/SZEgi0I4s7GDfdZ72zgG3huYiMinLtkSk9JR/VcgUWNXn0qkmP4iReQn4e3KT4P3R39znY38lGUhCJ0FTmdUc5AmwDLjsURR+0nm6EwJ15RzRMMpWg4BX76X5gZ6fhcLAIVeXK1AcyvwZUXktQONsjtEqfFLEX7v4vO04+6ArluYoP35cS1y4HzrV/O/w60qOuu/ky7+mOk/0q8cWt1zVpgiTe1kX9iR3OqwKCuACLexUUx1MtfyB8al5PvVb6MDzV8QorqwsPR41nrDEvuVzj9RIV7uinWR95PTXAtG6ZgRS2hMhBzbWRiHWGXZy5kRw2GHTweCEXHrvqXl4nB3oOlsIqTAQP78SZfzlwLsTLaMsqi8WpL22k34HWo6/4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gONPKjWdu3Poka3QbxQiAAPbIrjdgDH1rn0QVywZd4I7ho1RMNIgIXxdx8l6?=
 =?us-ascii?Q?GMOYtBWqS9mdPzCa28FqNMbIN31AAbC980UEcMEwH3u/xrn25CrecngRcxtc?=
 =?us-ascii?Q?wle5dIT6SDm5vjHlaWfDuu/5uA0ovQUtlCTjlm9Ulxz63BB9pP2F9aQNMtsN?=
 =?us-ascii?Q?0RhLR50ClNCRDxVwvQB18rQWNDqayMyhwk35fVyYktmyKkpcvcn0HoNUcrqW?=
 =?us-ascii?Q?gLZqOY+rjFVTNKQcf8efMIh8TqLt71K1YIh8M8lI8x8+qiFFKryqfR5NJRiN?=
 =?us-ascii?Q?iiiXkKeXjY1Uycdyu2czuASVortV3sP768l5lEeWAQpCl/SpHjLUYibRUFPh?=
 =?us-ascii?Q?R3Dw4pL0BrU2czJoXqgwYzbRRpj7aEA7DH3C/8NUiIWX1P9opuqXBsu4uhzh?=
 =?us-ascii?Q?pqIwgNE7CPG0jaUZA+NfcjSRlndet/DRZFhgiAXLlO7IqTaTXhi6Qghw++HP?=
 =?us-ascii?Q?87t3rFqPnAoZFGNwkKLO+aELuWwR5mS2JDK1RhTJgbtSxKav5Yb+liX0cL3K?=
 =?us-ascii?Q?olPX793LfgrhaiJzVGk7wDrTcCPesY90VLKsZc6cp2Q7ZkwrS47plkoiVw7W?=
 =?us-ascii?Q?wGmGlj+F7l3rDslXLyzdUPx2Lijngl422jUNwHCI1xmTiIBpoNozneHr/nHE?=
 =?us-ascii?Q?GG6cYxXEimIv+IIsqb9e2Q0iRjti4wwogTzmG8kaX5JyiRg1459I6SoQ7X60?=
 =?us-ascii?Q?rz/kzsmbNv5d9t8rhfEn8ndxrMorJmNTkWWdwweOkX6eRydd/ysx3tzAYjmn?=
 =?us-ascii?Q?e2AFRi+/dGTgkXypGNXFS3/qBOfVfkJCPVcKS1g7pFKbakXLMVc8GciFADpM?=
 =?us-ascii?Q?xICFsMymOW2FQQEHmS8CpW9kA8227fjCE3ekydTL+prbWlfCfshqxDYJxpnJ?=
 =?us-ascii?Q?dvWSuz54UgqNL3WVSjwDmexvaYS81dCCkamqhNSmm9XJaBzTrky9uyLgUoL2?=
 =?us-ascii?Q?NhXNFJF5b29hz0SoamhfiA0MVxqzDfmklwQ7xNd9EklICMDT+idwOwKzlk2r?=
 =?us-ascii?Q?T88syIIZJqR29acuhgnfqd+aMdTHxAx/itQFF/wXWjG8H6oOGslDyCDG/LQd?=
 =?us-ascii?Q?Y97f5mcmQ1pGV+pCnHFzVqs3q05O0yCi7CRbBr41gmj/eYs1cM9WVmDtPFMp?=
 =?us-ascii?Q?DtzT/oIPfvixtGtKjOUU47CGyBJJxR+ivILngnpWs17fBhNqG0WqEvl+qVfq?=
 =?us-ascii?Q?GXm0Gq6w4YcthW7hdSbUiC0sfTsmOp4Wa1ywYZJhhjLJiOoTZYPRSUqkBYC/?=
 =?us-ascii?Q?XAmDE9iPE5rW6ywgaSGD91sO4wXzeypUftTgNdq06B8cEuD0x8OpFdYZiBgr?=
 =?us-ascii?Q?MzSbT5dSErf4ZCR2r1EjTqzgja8vA1LiL8O0WTMIadPkcvDgiaTAGwyFb3mx?=
 =?us-ascii?Q?O64pA0OWEI3TrWrpXSWFxpuaqH0eFJD37P0HETwzZEopF+jmKdKmqisyNb6V?=
 =?us-ascii?Q?gypX9Qz4ZrH3KFUXl4E08Hvh1HWDoEIvQX9P75jTaYdwO1zBbHOacpP2EAVl?=
 =?us-ascii?Q?eXs4/4P+wTYqvlCjHEMJXcXFvu577soUyEIfGNtfw8mqATwxTxmPQ60MMjQd?=
 =?us-ascii?Q?elvVxSX7Sk57EfB0Y8OyQ3C19GQCQBVm6uSsaAKewDq6mmyOC2jrsTXCXH/l?=
 =?us-ascii?Q?mjjvEtAesnNxKtSdicY2XdVpV+EFZWnzSk6wPVoZYXczIvPI2w5IXSrGnYmD?=
 =?us-ascii?Q?PctOXihrW/iKGrFqXTFWNVlDLvjwcdpIibtdvn48vZ+fTmHs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S+qRQ5VBR4sFULnRsF6KqCNRkyDWb90iLPcaWYx1zdoRkVRKvgk/p8qL/T3jledQ6MrkB51FZ2eoG82C2aBrHzVKkbcaBbgbovaJI/n4X/EBmJgRJQ03OGluDTTh3Y9ASIcSjazCk1m5XhYw4+HtlonhY/ubWcj1kH6GBfigiqAwxE/nUMXdVTog2T5GmnttLCG9SdDWPlsBDMkBdfJ99EyLlzsHtJ0qrxOe8UmAYsaoftpnTF1MwQc1a6+W9o0oDd3mpw2dv6YSb4Ok6XwkVB99RdOK3m0ICpBOJQqUjhJ29ilcbRo4zbJYcVq6ZLsLQek6eBlLXHvK4HEkiajIHg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9af9cf-3bc4-4d3e-b1ab-08dee368f099
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 18:34:58.5316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MSnwTLowqOQMO5DeMPhr3N2tr906qgYwknSOC0vR59/DcxbWBvLUPo0Y3ViLaEjY6gY2iCbAU7aEhtaEOkhDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4571
X-Proofpoint-ORIG-GUID: _1365xRQT51GKE8IXCZ4drxEFZPwxYmE
X-Proofpoint-GUID: _1365xRQT51GKE8IXCZ4drxEFZPwxYmE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE5MCBTYWx0ZWRfXzNjMfWCQMIZp
 zva1G6nx6qbSlrzzCk2U8JBzN8ZShfK3Cum6ZoB275cpPrf0ZqDT1/k9gu+hwU0v2tTHjdAXTj+
 p6XyGof/QG2h/X/7NrMR9slnDA/xmOk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE5MCBTYWx0ZWRfX6SLgPbN8SN1d
 zqgfoCATBVmposWnHLYdfS0lBZwDW04mtDBZP1KGUOkxUyfyDy1YVxBy4zoarjURFFG/gXGDKWT
 1N7UIAKRY+LGAfE3izHame9v+lbNlvMt2mCu6AXW0hsNaZOL5pf4fut6vFkHioU9bKYFxVxX7lQ
 ShBxVM/M6vR491+oxQMTPBdOkP26ni268xL+VQ57f0+9i0UE8SRB02w0eGMb+SJ4Y9SfkShKDvH
 UJkUdZvgxsGx6y5PN8kzelL1Sx3e6hE/EwHv5nr6QCXGH38IYmIOZuVTX77NbG44oEtETboMwe3
 eASOYMb/Ey+Yi31b7DoToCHdg52HFOmeuGCA22JSmNAA3DaCH/XSZJCY59zimuLBakzKVSJVDaE
 loeERgFpQUZIqtixQ1xoI7mSYQsJ2FowSgEzXGp3tWvVHcUg5WpJwlGjXSigQxABhWrc+I+Itfb
 wLeeM7fuNnlROAPDZcQ==
X-Authority-Analysis: v=2.4 cv=a5AAM0SF c=1 sm=1 tr=0 ts=6a592455 cx=c_pps
 a=+94yW41P0wWqy8Q+CvkqwQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=i0EeH86SAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=xh46NqrKPTztj0298CkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_06,2026-07-15_02,2025-10-01_01
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

> The Rx/Tx functions allocate cookies as needed, no need to
> allocate and free from heap.
>=20
> Fixes: 6f0175ff53e0 ("crypto/virtio: support basic PMD ops")
> Cc: jianjay.zhou@huawei.com
>=20
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> Tested-by: Yu Jiang <yux.jiang@intel.com>
> Acked-by: Kai Ji <kai.ji@intel.com>
> Reviewed-by: David Marchand <david.marchand@redhat.com>
Applied to dpdk-next-crypto
Thanks.
