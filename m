Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA08F506D1
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 13:36:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AB2B4025E;
	Mon, 16 Mar 2026 14:36:36 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D9107400D5;
 Mon, 16 Mar 2026 14:36:34 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62G0MT5p4130807; Mon, 16 Mar 2026 06:36:34 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020141.outbound.protection.outlook.com [52.101.85.141])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cwux6jahp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 06:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SagzWi+NvjGodqevqydwzbe1JSKwqDhfm+xek48RGPDf5zBJOlF27N2HLBaBHBvRSCtRDx6L9mHIfolBOjk2/yVqdI/hnLHjcmewDUcD/bDIqBe2sJHhJBXst5+6NIqS/wHfod8bKnMVNYD7q7E6A5vmGUYrQTooxwCluULdp4f4R7u830+xyRTRh2fJKS6h+eYWbeE23pcCxRCirL6j8W2gOpqjFiEKdyREpo1O4vsH0FBpXpak1t6oFM9IZAlyNt3BOw1oAmbZdLCVq2cEzufcY0o0cEjfbkR/7gvvxXlY1DDEprccU6AdPP7fEC42PTvehpVsQDb6vGMW+0yDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaR671MHU7VCbzJsTa1UtNpWmieO9aevY2ZSRyLe/Rg=;
 b=whCMLkwmlMfNiLq6zvRf39MhN4FXog/u2zO/V7kIVxMcwRFeBscrr4Mmwtw0llqhR8ifYKTddRqrBgUSyCAyrs11dYzd3Cj3d3A1yu5PdtLhVQOPrL10KzexofzpLBAPRKOzfMSCPCaaMiCEAhoJTa0xPzWYmXDx7HTdedweyyA4/4QTMHs/iduuWbJPSy95iZqZHYgFJ3sHNhb3yzzP4TAk8oE5kdOs/1E+Rj5NoMK1QsboYLo7tOv/ZkbKO63lUNN6QO3BMDZeJwlpfj8asMPDKlw5OaxlhrKVBOzOXbPW88qz8xPYUld9EqYJxrWTfjVmOH2Ogy0V3idWL/VCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaR671MHU7VCbzJsTa1UtNpWmieO9aevY2ZSRyLe/Rg=;
 b=efVf1zMwCKLBkmMPJdzY5fbFNkqxpCNHN9vkiz1TO0d8LfDDDFjnIOx072OB8TQDj2DHiu333+u1rlqWTVemYwHJd4q/i6XSD7Oa92Ccx9Akgeu5n9QXu+RD0L43CGczGil1LLIQpHfPjmELGXUmjS42ut+9jJgVvtVFXGT5D0U=
Received: from DM4PR18MB4255.namprd18.prod.outlook.com (2603:10b6:5:396::17)
 by LV8PR18MB5730.namprd18.prod.outlook.com (2603:10b6:408:1f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Mon, 16 Mar
 2026 13:36:30 +0000
Received: from DM4PR18MB4255.namprd18.prod.outlook.com
 ([fe80::a8d7:81de:a326:2f6c]) by DM4PR18MB4255.namprd18.prod.outlook.com
 ([fe80::a8d7:81de:a326:2f6c%6]) with mapi id 15.20.9700.010; Mon, 16 Mar 2026
 13:36:30 +0000
From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Pawel Wodkowski <pawelwod@gmail.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/1] examples/l2fwd-jobstats: fix timer
 stats display with lock contention
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/1] examples/l2fwd-jobstats: fix timer
 stats display with lock contention
Thread-Index: AQHcqgxbIJhq/RgIVUmrn4ybAeSU3LWbY9AAgBXbqrA=
Date: Mon, 16 Mar 2026 13:36:30 +0000
Message-ID: <DM4PR18MB425513DE057FB7D2B68969F1CF40A@DM4PR18MB4255.namprd18.prod.outlook.com>
References: <20240811155957.576645-1-rkudurumalla@marvell.com>
 <20260302061805.1666176-1-rkudurumalla@marvell.com>
 <20260302074804.40042d55@phoenix.local>
In-Reply-To: <20260302074804.40042d55@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: stephen@networkplumber.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4255:EE_|LV8PR18MB5730:EE_
x-ms-office365-filtering-correlation-id: f678f964-3fc4-4e7f-beab-08de8361081b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: hETRfBfHEZELwaqjexBJJh4fYBKJfXaJorvBC2iFysvO54l2q96gbGcSEZFojTHGz2Ufh2KjEa3gD/+4NiVUVO8w4Bw8tBPMaPkjQsFmobDE/l65KqdQfrN6IQdoMdYXcms0gzAOjkcAqgkhd8XYh+wod62fP4d+huRM+RchaIHfj58fAVn7ySGRqis81DrRhtqsRmWsPU7KJ0oRZ2WkCktaSdRUMprxvqAxnhU4M4J5I9AqDmYKw3/gM07TXvzvIATuimYs7XKIpkqMfqQz+uk2jgXnhVsWCWS1nY/br10BAnMQiebzo1VqVnvJ/H4j1nDjaKBP70Gy+7p9+c3JC5iufFEvSYxczVyqnKzlHbn/cIwpCtdMYhJx5s9vDF1lz8WlE7rqoSp2B7hZXcdz1wvm2be+yB8q1836+Jpe/g4xSdrXQxn9M7F3AN6EmFQYzJq9EC2i6LAfU69IX8Xm6ST5YT4xxcMSv8wdzRKBmjvzj+9/16TxTxyjMmIbZlSRqciZ4wTCIhJLBePV3pYzxMVUciS2I8JVaug7HuAvm2B0/gi1cxQzW6xGaGqMw7WDES8l8LlhpAtxLK/cbJb6bbbDofmlGDKMQgOI1ZkSBZFFePrT1GE3BlbHgaZrBVzoUvPsOtFab6K2ETwcY2DscHd3AgNHBYcG/MsfCW4nn1jMUJDmMqqUtf6lVPcxZg//DNvzOkUf+aHQxZNvlo+CRZ6T9lJbLLf6Cid0T5Wk71hg+Gm6zzWb0VJU1yuk/VjT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR18MB4255.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2hDckNRMm1XNmNtOFBlckxJQnc2cEw4MGx6eFBKUTFuNHNFTzZZLzBMV3J2?=
 =?utf-8?B?TGtGejZoNEV5a0t6NUxSNG40aDRFT3RDT2tyZ21pOVN2eFJWelRKa1JweDVM?=
 =?utf-8?B?djVFNGVuMmd3YmM5ajlHOGNOcVZRdlNpdWJHRVE0eXZTQXYvRTJITW5ybTln?=
 =?utf-8?B?U2hHcENjc0VGZU02L2xDcENoRG1GSG1kNHpjVDNkMVlQNTJpSjg0ZVBKYnox?=
 =?utf-8?B?WFBybnNPbkdRbTNQelB1TnBXNmhCdTJFN1A5b3VHdjg4aVp6UWYxTEJXanQw?=
 =?utf-8?B?TnVZeVMrbHh3cVN1TkFDOFQzYlgvZmVEQmNUdVdQeHBtU0tUeWdzaFNqdHJE?=
 =?utf-8?B?V05wTGFTb2lLeHUzVGNLYWl0T0ZsVlRIYmtmZ3JYb1h3NjJoYXlNM25SWFFC?=
 =?utf-8?B?TUFpZUJmVWtpblNKYmpCRUs0S2tLZ3B5YVVEQjFRMzRlSTY4UG5DYVl6NEI1?=
 =?utf-8?B?WHNNYW8vR1ZKN0c4aWFOR24wQjhvK0JBNktWclI5UEdvRE1TYjQ1UGxxNmM1?=
 =?utf-8?B?dHgxVlhZclRtQXlpanEyRUxYbTc4NW43UkRraWFQaFhocUl5dWY0ODRDZUVv?=
 =?utf-8?B?QWFRazJxVEJFWFZ0Nnh4Wm92dnlSNFE4T2t3WS8yYUtWY1Z2eU5Cck53YkxU?=
 =?utf-8?B?UG1rcDhHWUlGQ0xYMTNqU1Z1OHRvUWtsalRPbHorZlQxbjlqWnp4ckhvY2ZH?=
 =?utf-8?B?amhGektBUm55SHFLL0NNLzZHRzZRcGJ3eWM5ZCs4dGVBbjNqYWQ5aEEvOGFy?=
 =?utf-8?B?K0hOMmkzVTRDaXN1VzE1OXl2NGhaWDhyWEM1VkhNOTBsR01yS25nOWtQZG5z?=
 =?utf-8?B?cyszeEg4bzIzckF2cWVGZ2QrQjdqR3BQMjA3ZkNta0JzaDQ2Y3V6VHdwR2cz?=
 =?utf-8?B?bnVWdXFhRlJHS2ZkWTlaSHdxRE5hcGlYdTRwZUN5S3l4VGlQdXJER214eW5u?=
 =?utf-8?B?QTVuWVI3dlhlUzZ2cW54MG5hbU5PN2Z2Q2R2MjVjRG9iekZFdlU0RGQ4SStN?=
 =?utf-8?B?QTZFQmFQbmI0blVxZjNMb1pCODNBdjc1QU54OHdKR2l6aU5ZV3BzVzR2ZndX?=
 =?utf-8?B?bER3aEN6R2F3Zy80b2IyV01scW4wREsvamtKdzdibm5mQUQ0eXFvU2ZzNW9R?=
 =?utf-8?B?eDdWYWYrNGdYU3MrSmlEYVVhaitNL01KWSsyZWQycUhsZ1VyNUF5S0VPRWUw?=
 =?utf-8?B?N1QzeFB1amlSTy9Wb0JXVE9KVW94RmdmblZMQW9tQkZVR0Z2MjYwd2VZZWNj?=
 =?utf-8?B?NXdUS0pVdXJGbEpPU3d3d0RmSmlyOEt5ekhYbzZkdHJsaHk4YkxvLzVhblVt?=
 =?utf-8?B?ZC8vWU9vNENZY2xxcE5NTkFld2k5MEVPRVZpVkVweTRSaGdJRkRkZWJWcjR4?=
 =?utf-8?B?QTFlcTVVWnM0SXRBb2JkUWttNnJIVWhLYUVRbmRsWW9GQnNzaFErRzdzM2Fn?=
 =?utf-8?B?cHVvNGxzdUQ1V2hMQkRoSHAzUUpQWlNBS0p3dUlOSndVZnJNdU8xOUhSVGlO?=
 =?utf-8?B?b244TzlPOHdab1R4OGRad0QxWXZSZ21FSThpUjV2TW5HRzRiOEkyazN0cTQ4?=
 =?utf-8?B?NnJhT1QwdU8xNEdlbWI5N2NtTDRBa1BlRFNoVWozV3psRFRBTmxkNkwyWnBu?=
 =?utf-8?B?VUNxZGJNT2hPS2N5Q1BDanpZeVdjSkZRQ0Q0SUR6M1ZQakhTNGk1cHF0L2l0?=
 =?utf-8?B?MWJhZnFTeGhCZ0l2SVh2dFFmbDBrN3FyYm5MVXFEQ3A3ZndadTB4a1YwZk4r?=
 =?utf-8?B?cUtiNnUvdnM1OTIxUDlPb3ZQNkg5OVZ1cTdWcTdyZXNEeEZQNFFUKzVUNThH?=
 =?utf-8?B?R282enJFS2ltMlhrc3YwMXEvUm51NG0vR1FNOTFwUldmU2E1cUhtYXhBTEEz?=
 =?utf-8?B?YXd5NklEaHNJSnI1RnZpNTRHckdWSVBKM3lXa0NqTGpGNmZlbndYL0RwSlhG?=
 =?utf-8?B?QkNHaG0xNlladDgwMXBxd2pUdXVJMUNBZ0ZoZ1dkaS9uVEFwU1M1VnVMZkFC?=
 =?utf-8?B?MmVjSzJzMDM5Ny9PcW44N1k3QmNWNlgvem9rMm12eitOM3FCblhrMktrMmlK?=
 =?utf-8?B?U2tIU2hDY2trQTFyTUxHZThrMHZzanRLdWpWbnJTQU1rbU1JUVkvNDdubm9C?=
 =?utf-8?B?d0tzVVZ1ZzhsS09rN1lXaTRrVmdTejR0MnRGL0E3RXBFRGhUcld4Y1kwV1di?=
 =?utf-8?B?OGZVSk9lbTRzbDY3UVJObU9NNlhwV0k5aFVPaVlKdFg1dWdST3kxVGNUVnZF?=
 =?utf-8?B?YmpybGRRb1ltUGRKOUpZRXdjeVVqeTMzeXhFc2xzS3VmamlPTUl0MmJPckx2?=
 =?utf-8?B?Zk84OXl0ZVQ0NUQycXV1QVNQaUxEY3FtOS9WY09vc2JjejRRMzBuQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Qwb+c7motGJjgVvnQb79w8op9MX77fHJFPgj8zH/tWufOiZRjdT2IEK5lHATmi50pRLacv1pLGUt4YAX9hjcmt2swnqf8VMpbwfaQ7qyNqg2nZhAgZLi0bl7WO0drpgHetA8n9l1Cquut+7L0WHBhKuugHXuigV2gh4CgarurmduGlHopNjHXSlgOudexgpSxL4DAV1tPMevBswCozNYhqL4ScHqOdxckrzTybWIMJ076T8XWknSboCQv/9+3h3JPDiU03a6+qNR++1yQwUikj357+VCgJQiXThJSITz1dzCsxe50/DhnFu9zbz8C54d+FlXUptYkH1DMOHKqYIifw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4255.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f678f964-3fc4-4e7f-beab-08de8361081b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 13:36:30.4167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a4xDmY4Lkq9Qu+ZfGd/3SRAhEn1B4kyU1z5h2Eo9DAZUmGH2US5Vr0iCNXDwkAtWyaDGsCy6yb/gOqrtmTJZX243nME+8zNkgT5qA/857+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5730
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwMyBTYWx0ZWRfX9oj7tEZKWOJf
 Qm3El2nkepvtmDVW4Oit2IWpTzujHbH0f4Gegl96aJLfS/ye27PYbZpTzYwrr090EeWPdvnXxS7
 +E8mb+Qk4ZfVdhDCfWBx9OwmXYhOHmL7szZusojHw7Z4oUtldUEgZX2hQ8Ez6z8Xf/B8GRKoBEU
 KKgyNtDbT4UtJDNehofOOyYb7nxItEryPy6Ug9tNZJN16BLlVjqh5ltSea1bVfLy+bQWbZMmwQu
 GG2u4EFnebLy7h8JOUu0C2B3Pq8g5RuOv5RESmOefsDYkyPjTYfHhy27+HvojQSb8MU5vWt8RJ9
 gSG+Y/Wtk+48o+J50tButqbFGfcIBQzFniablze2t7lne3BzABHdAyma5CNPwSehZFqzfN7NNT1
 5V1zBb31u2M3v9GSgQfgrQQ6vO50egOG/RUuhGF3zBBAF9oLYMdNMbiYTA6yQAczcnpJWpSUY3j
 WGj2L2lDazYVSTvv5+A==
X-Proofpoint-GUID: dmtaKul10_qktnZyFMtNzqXumeJxLYPE
X-Authority-Analysis: v=2.4 cv=KNtXzVFo c=1 sm=1 tr=0 ts=69b80761 cx=c_pps
 a=g/OBtAqTw1pRpVLcEUWRsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=jZVsG21pAAAA:8
 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8
 a=RpNjiQI2AAAA:8 a=1EdVN6IPxcG1zKFxh-0A:9 a=QEXdDO2ut3YA:10
 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: dmtaKul10_qktnZyFMtNzqXumeJxLYPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
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

SGkgQFN0ZXBoZW4gSGVtbWluZ2VyLA0KDQpZZXMsIHlvdSdyZSBjb3JyZWN0IHRoYXQgdGhlIGFy
Y2hpdGVjdHVyZSBsb29rcyB1bnVzdWFsLiBCdXQgc2luY2UgdGhlIHByaW1hcnkgZ29hbCBoZXJl
IGlzIHRvIHN0cmVzcy10ZXN0IHRoZSBzdGF0cy90aW1lciBzdWJzeXN0ZW0gdW5kZXIgY29udGVu
dGlvbiByYXRoZXIgdGhhbiBwYWNrZXQgZm9yd2FyZGluZywgSSBiZWxpZXZlIHRoZSBjdXJyZW50
IHN0cnVjdHVyZSBzZXJ2ZXMgaXRzIHB1cnBvc2Ugd2VsbC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1
bWJlci5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMiwgMjAyNiA5OjE4IFBNDQo+IFRvOiBS
YWtlc2ggS3VkdXJ1bWFsbGEgPHJrdWR1cnVtYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gQ2M6IFBhd2Vs
IFdvZGtvd3NraSA8cGF3ZWx3b2RAZ21haWwuY29tPjsgUGFibG8gZGUgTGFyYQ0KPiA8cGFibG8u
ZGUubGFyYS5ndWFyY2hAaW50ZWwuY29tPjsgZGV2QGRwZGsub3JnOyBKZXJpbiBKYWNvYg0KPiA8
amVyaW5qQG1hcnZlbGwuY29tPjsgTml0aGluIEt1bWFyIERhYmlscHVyYW0NCj4gPG5kYWJpbHB1
cmFtQG1hcnZlbGwuY29tPjsgc3RhYmxlQGRwZGsub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
UmU6IFtQQVRDSCB2NiAxLzFdIGV4YW1wbGVzL2wyZndkLWpvYnN0YXRzOiBmaXggdGltZXINCj4g
c3RhdHMgZGlzcGxheSB3aXRoIGxvY2sgY29udGVudGlvbg0KPiANCj4gT24gTW9uLCAyIE1hciAy
MDI2IDExOuKAijQ4OuKAijA1ICswNTMwIHJrdWR1cnVtYWxsYQ0KPiA8cmt1ZHVydW1hbGxhQOKA
im1hcnZlbGwu4oCKY29tPiB3cm90ZTogPiBGcm9tOiBSYWtlc2ggS3VkdXJ1bWFsbGENCj4gPHJr
dWR1cnVtYWxsYUDigIptYXJ2ZWxsLuKAimNvbT4gPiA+IFJhY2UgY29uZGl0aW9uIGJldHdlZW4g
am9ic3RhdHMgYW5kIHRpbWUNCj4gbWV0cmljcyA+IGZvciBmb3J3YXJkaW5nIGFuZCBmbHVzaGlu
ZyBaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQgUHJpb3JpdGl6ZQ0KPiBzZWN1cml0eSBmb3IgZXh0
ZXJuYWwgZW1haWxzOg0KPiBDb25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3Jl
IGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcNCj4gYXR0YWNobWVudHMgPGh0dHBzOi8vdXMtcGhp
c2hhbGFybS0NCj4gZXd0LnByb29mcG9pbnQuY29tL0VXVC92MS9DUlZtWGtxVyF0TTNaMWY4VVlu
VzY5RS0NCj4gOFdWeGFiZ0xCbmplblhzLQ0KPiBRN3pabHBORkR0ekVvdnJQZ2JMSVhQVjl5Yl96
aHZpVHlIdXZac0pWWDE3TVNhanR6anUwZ3VPVGskPg0KPiBSZXBvcnQgU3VzcGljaW91cw0KPiAN
Cj4gWmpRY21RUllGcGZwdEJhbm5lckVuZA0KPiBPbiBNb24sIDIgTWFyIDIwMjYgMTE6NDg6MDUg
KzA1MzANCj4gcmt1ZHVydW1hbGxhIDxya3VkdXJ1bWFsbGFAbWFydmVsbC5jb20+IHdyb3RlOg0K
PiANCj4gPiBGcm9tOiBSYWtlc2ggS3VkdXJ1bWFsbGEgPHJrdWR1cnVtYWxsYUBtYXJ2ZWxsLmNv
bT4NCj4gPg0KPiA+IFJhY2UgY29uZGl0aW9uIGJldHdlZW4gam9ic3RhdHMgYW5kIHRpbWUgbWV0
cmljcyBmb3IgZm9yd2FyZGluZyBhbmQNCj4gPiBmbHVzaGluZyBpcyBtYWludGFpbmVkIHVzaW5n
IHNwaW5sb2NrLg0KPiA+IFRpbWVyIG1ldHJpY3MgYXJlIG5vdCBkaXNwbGF5ZWQgcHJvcGVybHkg
ZHVlIHRvIHRoZSBmcmVxdWVudA0KPiA+IHVuYXZhaWxhYmlsaXR5IG9mIHRoZSBsb2NrLg0KPiA+
DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkgaW50cm9kdWNpbmcgYSBkZWxheSBi
ZWZvcmUgYWNxdWlyaW5nIHRoZQ0KPiA+IGxvY2sgaW4gdGhlIGxvb3AuIFRoaXMgZGVsYXkgYWxs
b3dzIGZvciBiZXR0ZXIgYXZhaWxhYmlsaXR5IG9mIHRoZQ0KPiA+IGxvY2ssIGVuc3VyaW5nIHRo
YXQgc2hvd19sY29yZV9zdGF0cygpIGNhbiBwZXJpb2RpY2FsbHkgdXBkYXRlIHRoZQ0KPiA+IHN0
YXRpc3RpY3MgZXZlbiB3aGVuIGZvcndhcmRpbmcgam9icyBhcmUgcnVubmluZy4NCj4gPg0KPiA+
IEZpeGVzOiAyMDQ4OTZmOGQ2NmMgKCJleGFtcGxlcy9sMmZ3ZC1qb2JzdGF0czogYWRkIG5ldyBl
eGFtcGxlIikNCj4gPiBDYzogc3RhYmxlQGRwZGsub3JnDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSYWtlc2ggS3VkdXJ1bWFsbGEgPHJrdWR1cnVtYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gDQo+IFRo
aXMgZG9lcyBmaXggdGhlIHByb2JsZW0sIGJ1dCB0aGlzIHdob2xlIGFwcGxpY2F0aW9uIHNlZW1z
IGxpa2UgaXQgaXMgdXNpbmcgYW4NCj4gdW51c3VhbCBhcmNoaXRlY3R1cmUuIFRoZSBtYWluIGxv
b3AgcGVyIHRocmVhZCBzcGVuZHMgbW9zdCBvZiBpdHMgdGltZQ0KPiB1cGRhdGluZyBqb2Igc3Rh
dHMgYW5kIG9ubHkgcGVyaW9kaWNhbGx5IGNhbGxzIHRoZSBhY3R1YWwgcngvdHggYnVyc3QgZm9y
d2FyZGluZy4NCj4gVGhhdCBpcyB1cHNpZGUgZG93bj8/DQo=
