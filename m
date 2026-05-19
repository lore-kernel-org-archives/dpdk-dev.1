Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B81CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 10:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9407240296;
	Tue, 19 May 2026 12:25:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E091C4021E
 for <dev@dpdk.org>; Tue, 19 May 2026 12:25:26 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JA6KTe2110606; Tue, 19 May 2026 03:25:20 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023131.outbound.protection.outlook.com
 [40.93.201.131])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e8cfm9jds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 03:25:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDPnzpHKKTtz4WlL2bbEmdCj3P42lxl7rOsvL3S4ET/k79BrOhAsUfEI9LiAN+60K3Pnj2uIi/0CJSn6z55RrHGTyZJ8wIpk8uAmNocC5Erk9nJqyUFjkoaW3Rc881CpUITX/mjR67C6eb9kivTAUMRiyzO5OtTge5m5U59taB9Hd0WoIqK3R5kcKGDkrMl1qw23uG5HEv9V8+urhT7ehixZca4ANkzUBNQwhX288ICSktQYpymhOuRhUI1qdQ/tgH/49eyYlDL2+F9ZZaDRDrdbvbeKR/tbqpR6hBgVuoiSWrgd/XLGDgTPeWNGaKnax87JXkcbaWeDXPGA+JQWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC7m0fGD62Qq/TnigTcNmYGsl34+d0qEkSJ3nCarkjo=;
 b=oHka7jW0aBd0Sme4vniSXT0U3Qqw5WeQ/N+D3EbqSPMHqc6ff2o2QeDizmS1WNvZ2TfPG+Jf1EXwvt3y0hORJWz1EVXvqIT+fc/dtJNHA0Ndnnp5a0+JiVfTGLeL6yl0Ivlsjn/+e9TXgiGQ6DrQlHubHkma4I7quJVVhs5XOFdlgAQfNR+e1NFlAameciQ915PwdyCPJa89MN8uM3NK2M21ox9w8zM8mMGgj3W45QgQbseBazL/zQaxQpSXD8xklloT3IBhuAztZG+Sxeu7t0pDgUCtPk1a3Ecv5lOGjW0nTK2vRhVt8p/iNeE154alZHPTIllaUk86GwchKPK5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC7m0fGD62Qq/TnigTcNmYGsl34+d0qEkSJ3nCarkjo=;
 b=i9QLL2+t7CnzEgvl12dnlbMJ1C4Ig+qV8kewhg4H9MuFElmqvMJlxfDYKlvXEQjhZVcu5s3hMoO3b2Mz/SV/LuSdAtEO/PLXCLlOAv84/mML6hSEFA/UVuw0b4O37CxpRZFVUN8j1DsORuf/gc+FidXVAgjg+A4bPc4eCsiV/jw=
Received: from PH7PR18MB5078.namprd18.prod.outlook.com (2603:10b6:510:151::20)
 by LV8PR18MB6001.namprd18.prod.outlook.com (2603:10b6:408:220::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 10:25:17 +0000
Received: from PH7PR18MB5078.namprd18.prod.outlook.com
 ([fe80::339:a820:953d:3424]) by PH7PR18MB5078.namprd18.prod.outlook.com
 ([fe80::339:a820:953d:3424%4]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 10:25:17 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, Kiran
 Kumar Kokkilagadda <kirankumark@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Christophe Fontaine
 <cfontain@redhat.com>, David Marchand <david.marchand@redhat.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Maxime Leroy <maxime@leroys.fr>
Subject: RE: [EXTERNAL] [PATCH dpdk] graph: replace circular buffer with
 priority-based bitmap scheduling
Thread-Topic: [EXTERNAL] [PATCH dpdk] graph: replace circular buffer with
 priority-based bitmap scheduling
Thread-Index: AQHc53gUjffSsNNfLU6QTKLoRNr4YLYVIvnQ
Date: Tue, 19 May 2026 10:25:16 +0000
Message-ID: <PH7PR18MB507823DB7B8D54E605C4437CC8002@PH7PR18MB5078.namprd18.prod.outlook.com>
References: <20260519101232.541102-2-rjarry@redhat.com>
In-Reply-To: <20260519101232.541102-2-rjarry@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR18MB5078:EE_|LV8PR18MB6001:EE_
x-ms-office365-filtering-correlation-id: d3d87c35-37da-47dd-c464-08deb590ebbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|11063799006|3023799003|38070700021;
x-microsoft-antispam-message-info: IHtNfK1BkFpwXxYAgP0M/rKV0mdE9guSKsBv3YlfAS35bRC4qzCo54c/wecz1lPsRQYw7tqG5K9IfaVusTN9AiECJbi0tDPqCPkqkpUILCYU2VZWJ01ejFith4Rog1oFrrydRPGpL/0qI/sGV04E5XW7fjdZlUH9jXPML74zbprS1SwdGPCfe9OKcPzroSKUS+JiHYS3iPms2duZ2PImH32qWNXpmJdDoJ8kijEk5J+fdFyHwQYoVRxRO0NVCLPaA09b//gdp98hOl86jAJD366Co8NrT5XtA2UC6tdTq0W072d8Jhq64ZDPygp4MTPTwgfwNkJf0H/NCYGypsPO0UBK9KCk0eiiaUYBZT/CLmR+8NdXjKoiM5LPsvDQGWO8dxFmkXarYQCKxFe9+Gsdzclli6jGfnCltFtqA4R8gSo0S3rSzqr4HVHDO1Yy4MDRQEGmOJZMUpuXOAXr+4Op5JE/WpijqIa2ep+jaKZylIxQGcRTPEL9x70mMGvTs/tiJ5zcEmHerePCFmEQTjtr8bzWObIjelaXsiEkwfPTHcO6DPBMdz1t7MknftRhngZIGUXzq4QzjkAfYxl6bpjkalqbgUhHc1+s0rgaKk3Na7j+tn1ldEJ8obVgobLoHZzochqi682vNpWKnAYQbqepqqpnCdTgtUpA16rHOIEkruQjTgsIHqmQ4mu5xvAjqYhganbL2IQZ0+AETG6mhCtiaoFYIN6EjDrdoAP6ybpquFslLcirwRYmdxW+d8kjRhjm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR18MB5078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(11063799006)(3023799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9yBMAOpuphhLN8YcFfnYtcL/GqxoA4vaVItaybeMi1YLXrbz3gnU8uZH/Wq5?=
 =?us-ascii?Q?JWulTCD8oZ3nFCFIQh3Mw8CI//TfqGoKwXII/pBmbWwrwvSTB/cRvZ5Ti4RC?=
 =?us-ascii?Q?oHo2x4Mdw6qGq2nnOMIYpsyQRtfMs/zaU1q4+7jiDejB7UvSA/p2/WompIoD?=
 =?us-ascii?Q?iwqtb8wXmwx7ZHLupNzNiPA9Vo8aK5KUekCtctr7LRyUzZJDbBsp4OqQOBQc?=
 =?us-ascii?Q?b1CRVpTsdkrU3QOQufJIkegvqzyP9tjpHy1ZLLeWTEAsStz2vcIvy3Y1GKOp?=
 =?us-ascii?Q?we/Giyphm32rKBTUuLIiRK8dlX1V2zUB3Tg1DMQNp7JgtkszXK93r4A7H3uj?=
 =?us-ascii?Q?cusE+Ll/z3PQ6rtUMWcUmSGvCh1pZK7RBtwfyVCMe4n5Ydv/rJkA45LMpITR?=
 =?us-ascii?Q?QMGUdIJgS1KurA6ySti3RONcx4VYpNT8Of3DSfqDABbwtpWUhNXWTU74IoBK?=
 =?us-ascii?Q?J/iPjP8c9aiCXUW7jOVOIHSMO02Ufq4OMcqF7PrvsLHjx8gysDpJVNaJP6Ys?=
 =?us-ascii?Q?8jP/GlWc8cW8EOCjnWWsEf+BqGjI7OUUQqrOa9rM/pNt4jHxKcVlsFLKcp3A?=
 =?us-ascii?Q?7kjMO0f/3Qh9HCFFy2l54ROJPW0qj12ntu0uRh0Dd8JXJOK1PiAxueox1Zbq?=
 =?us-ascii?Q?9NgaRhEAUkI+IdQ/nIjEcP0xyhHy0WbwymECfbo0F6oGeQA9Z46XqbYpIPpO?=
 =?us-ascii?Q?onTG+JFDm3cPq0ySyzsOMO2UdH3UCi2KXckr9nzkgqdbfgSVhbUrh3s508Of?=
 =?us-ascii?Q?CU+ykDjE88StyFLj/DQF5MfNM2QON5MzewGrsjWTsEQQ0Uf8w6JUqimNCu72?=
 =?us-ascii?Q?okKsoqhCmylAcEMi2tev9CsAF+gjhOICtG6dz3L30vZxsfNuH9T22cIm9XqD?=
 =?us-ascii?Q?2u6MaLizbGRdjNSipROpdE9N8aQxTrONNUcDbpJ0m+Ldw9OklIvdS57m4s2S?=
 =?us-ascii?Q?d7HX1ljSdCk0t3QWDNk/1aaq2HUcoLUx+e+kJ6eLLcaUM4u5pUJ8cqIdTbJE?=
 =?us-ascii?Q?Z///Da4gVgnC3Zv5znGMOZ7n37L51+1KO/reiEpwJbdECXFzZB6QikLMVEps?=
 =?us-ascii?Q?NsgxQUgK15uWW1Eb0FTui8LNyBRD9yQSm0BomLYPNnijv7ge7QgI7yiBGYEj?=
 =?us-ascii?Q?pugrDmBIz0fdKg/geTaPXZYJxrQujlRFP+p9ADbXZDicWh/E3Y0wgOTjvRjr?=
 =?us-ascii?Q?RaLath+PKOGNEfelajWqVESwQu8XTwptxWvMm24zaZS5kd9yAsi2dk1NuYLz?=
 =?us-ascii?Q?RZDYr33fLDNPW8LDpNFp/U8TEpJNCV0uAPEjhDHYlEn1UKtslyRLE/ulzqzk?=
 =?us-ascii?Q?o1Mmhefc9quWyYAO8DR+KubaPFePUOzx8bSejFkmxrgziIK1T61ciVrN3J9I?=
 =?us-ascii?Q?82p4umpx9+lzghdRBzRcmIwlfJQUyJaJ8XvNUkYEu5V+KwdFhRDxUXi1jIX1?=
 =?us-ascii?Q?XC/3OL/Rs/FGDI0JQ/3vLYcpgi5ueeE5V2vG1LIuB2TbXRE+4VjLq/UVWITQ?=
 =?us-ascii?Q?ZSp7bAcTRD4Sqw5mBF6MKFhdVqoKbqhW8dOi9tpyMSXcgf3sxBmO7mlrmFlQ?=
 =?us-ascii?Q?BIaV+8lus1BxOdSBDuHsXVUZsJ/N9U8E7J6SoArxRObGqfoldMa3agprH9MN?=
 =?us-ascii?Q?JvlU5FIg5jxB4zC7ElbwEeknxFocQ+Q+yMh2eFelDv8E1U+T7wWQOqg8kfBn?=
 =?us-ascii?Q?KIKNf/DXtrtPUEc5IyWhIdNavzQrwAsJ0ycCirdUjT1KP2sg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L7KliaEaL54XolyrdTpbd0vs/OUPb/bymTa2hcQf6VvYdeeJVM6m0TK6v/i75E3BQ720h3SbShanM7mdfKR2A3OAzHukbNhpXIE+a4C8NpQwXX04bx9BYmc5yjGQSJyAeeBSJPhwhSDbwTZ/DU8G0Wr7bkQT3gLYinbr2SCTi7mGVYN+ulDCON6H9m0WQeraD0NmX7VcGdGmn/7xN6C+wQEKW7p1+vhbBm2jp13gbELDaXQz4dsW597VW33jNqp4oEaljjZ1yGhNjzvodxl5Pai8Ac0yEBtgbQkvYYT/QOR1L4fZBybcMmKQ/bFAxffFGcv2KO1OdLHiMNWO4mEnNA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d87c35-37da-47dd-c464-08deb590ebbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 10:25:16.7617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEMR7P7PeIlI1dSDua9lzYlyettGaOf2AmgWDbmCPcOk9vvqBZK46VyVVf0rhCGH6BKFcBNFEBmQVwX4NOCEUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6001
X-Authority-Analysis: v=2.4 cv=JYuMa0KV c=1 sm=1 tr=0 ts=6a0c3a90 cx=c_pps
 a=toaxmG8YyEc+6C1DZWrQ+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=20KFwNOVAAAA:8
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=Byx-y9mGAAAA:8 a=QyXUC8HyAAAA:8
 a=i0EeH86SAAAA:8 a=hN8Lg-lRjP2HhUna8bsA:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BU_QD3kxKFeRbpwK266WzRNnnLq_Bpd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwMiBTYWx0ZWRfX07oxQ0iI2X9C
 LzYzHIMM37SooRhX5Pd19LLyth2iRDYAmMfaVsm4OfPhsUDaakMBzEt4o4eh/JfoH5pK1F2lS9E
 4eNoDZlxLdQfL60cfJ8QkrO/ygEwE0AsQ+Licv4SZMd7ETY0x3MxJagjjiwz54LS4JLCFyV+Nh5
 teG0++8vVQPeV+NF/1Y2cXBmjRogq7FA08jv32KYgfgQh6fvUXjJE5orYlRGaRtihMFF+ZyXeS2
 kx025QTChKMiOF5L3egbrCudl9TZhr6MgpSfRp7It4e5NjX7+t3FcxOFcqqI/MgyaftpDszesjU
 OL/vwNSlDkigdlmgdDit5ev7BWo6bDaXL3NfCACaDY7OoGiwADm2tfTzpUg7dJqAZMXmyAt1Gt3
 8OB7haqfRmsT/+KfKLp/JprdjzJbDtGALYvLbPmr1YeocOu9AHoAeATO9lo1wPoWguLxQayUQVL
 iQ0uy92B7qjo+JGJ3Cw==
X-Proofpoint-GUID: BU_QD3kxKFeRbpwK266WzRNnnLq_Bpd_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
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
> From: Robin Jarry <rjarry@redhat.com>
> Sent: Tuesday, May 19, 2026 3:43 PM
> To: dev@dpdk.org; Jerin Jacob <jerinj@marvell.com>; Kiran Kumar
> Kokkilagadda <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>; Christophe Fontain=
e
> <cfontain@redhat.com>; David Marchand <david.marchand@redhat.com>;
> Konstantin Ananyev <konstantin.ananyev@huawei.com>; Maxime Leroy
> <maxime@leroys.fr>
> Subject: [EXTERNAL] [PATCH dpdk] graph: replace circular buffer with prio=
rity-
> based bitmap scheduling
>=20
> Replace the FIFO circular buffer used to track pending nodes with a bitma=
p and
> a priority-sorted schedule table. Each node can now have a scheduling pri=
ority
> (int16_t, default 0, lower value means visited first). Source nodes are f=
orced to
> INT16_MIN
> > Replace the FIFO circular buffer used to track pending nodes with
> a bitmap and a priority-sorted schedule table. Each node can now have
> a scheduling priority (int16_t, default 0, lower value means visited
> first). Source nodes are forced to INT16_MIN so they always run first.
>=20
> At graph creation time, nodes are sorted by (priority, id) and assigned
> a bit position (sched_idx). During the walk, a bitmap tracks which nodes
> have pending objects. Scanning from the lowest bit naturally visits
> nodes in priority order.
>=20
> This improves batching in fan-out-then-converge topologies. When
> eth_input classifies packets to both mpls_input and ipv4_input, the old
> FIFO order could process ipv4_input before mpls_input, causing
> ipv4_input to be visited twice (once before and once after the MPLS
> label is popped). With mpls_input at a higher priority (lower value), it
> runs first and its output accumulates in ipv4_input which is then
> visited only once with all packets.
>=20
> The bitmap set operation is idempotent (OR on an already-set bit is
> a no-op) which removes the need for the idx =3D=3D 0 guards that the
> circular buffer required to avoid duplicate enqueue.


Some high-level comments:

1)What will be the performance overhead for graph walk.  Try app/test/test_=
graph_perf.c and l3fwd_graph
2)If priorities are same, Does it have similar performance with existing co=
de?
3)Does it have any effect on packet ordering on egress.i.e for a given flow=
 ingress order !=3D egress order

If there is performance regression we may need to consider new RTE_GRAPH_MO=
DEL_XXXXX to enable this feature


