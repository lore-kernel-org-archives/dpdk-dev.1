Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DDCC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:29:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A968E42EE6;
	Tue, 10 Jun 2025 16:29:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 51F2440672;
 Tue, 10 Jun 2025 16:29:51 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADueXS018049;
 Tue, 10 Jun 2025 07:29:48 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2119.outbound.protection.outlook.com [40.107.212.119])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 476jjp0nnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Jun 2025 07:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHag/AKZsmwlAeS0PO2tTEVRwTmPiW9B1x8hDN/SYMzU9mK3YTSM3nCS6zVRSwfex1ibQX8SxLNsO8F2rUplixqTvF1lUTVJ7trJQiAQewNcIX3iZUubvnOElHzGo5LTGtd9Hfnca0qUyU5O/B/G5n3zC5S5J1Mf+QZ+6AZTB7EAodtQaVvv3EonxhOIbFGH23UgjXKpULjycDejUf0dbUVpBasgaQDICQ+MJMF7QTvASOzcEo6bqYt4atGN8pwpU1DvLsjFZgZAQgf2wykMJW6tPsxPygEkPY9iVptM74mwsSRdtKS5aIe1VUBR73elj97/AumnINliPldCQRtvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fO1c3PQkdMXirev+7fOOi14tPm0QcPJhsN///vRtac=;
 b=WQT3oo9nenfShHRLZSsizn3qgdZO73bbGN+tVzEVFBUxV1L6jlWlWFDvTRYKiSY7IF+i3Q4Whkoa8JuWL9ntDoSex31Ey6/hc8+XGnL63Nf2pT4IMyV4sbtiY9GzVhVgjDgiqGierDDTqd7bkITMQS3xY7d7SrgYnKOctIray12GEjeSn2VAgIvMA5QczZqn94QYREQH43qn+1Q6vY5Wfyp4gO0ynWcCmqmua8yzrb4pslcs72U3Z0ktwjjtAPxLxFrWDdlj3aZKX1SLvXn+4vLXjOQ15uaaBvu2Rd/TImpNDlWjlW9agTWeedoWH8UtdKMiXUit2QIYECE5frdBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fO1c3PQkdMXirev+7fOOi14tPm0QcPJhsN///vRtac=;
 b=Gr0C1TQjsTtMC/7X72hS9K/Gc1LcZS0KvMzCvkyuhhkw+0uZvXhjuW3l9eQkfu17hhumzJUaHCE/gJXZ1MEDMrtuLm1WukB3tZlYZ818mlTCNVloq5JOKvMDVDFBJ8E4XP030xnOPvEr1WZieh55L11Jr0z/Bs5h2AvrVfPnBuQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 BY1PR18MB5989.namprd18.prod.outlook.com (2603:10b6:a03:4a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 14:29:43 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::ed37:4ea0:6359:f717%6]) with mapi id 15.20.8792.039; Tue, 10 Jun 2025
 14:29:43 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>, "david.hunt@intel.com"
 <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>, Akhil Goyal
 <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Ferruh.Yigit@amd.com"
 <Ferruh.Yigit@amd.com>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "haijie1@huawei.com" <haijie1@huawei.com>, 
 "stable@dpdk.org" <stable@dpdk.org>, Venkat Kumar Ande
 <VenkatKumar.Ande@amd.com>, Dengdui Huang <huangdengdui@huawei.com>
Subject: Re: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
Thread-Topic: [EXTERNAL] [PATCH v2] examples/l3fwd: adjust Tx burst size based
 on Rx burst
Thread-Index: AQHb2SU/VjU7LmCj30yRg9jusD2OULP8dXWf
Date: Tue, 10 Jun 2025 14:29:42 +0000
Message-ID: <PH0PR18MB40861D909AD3BC9A0695309ADE6AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250212045416.2393001-1-sivaprasad.tummala@amd.com>
 <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
In-Reply-To: <20250609095827.4174387-1-sivaprasad.tummala@amd.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|BY1PR18MB5989:EE_
x-ms-office365-filtering-correlation-id: f1fd33ee-0c5a-4b21-94aa-08dda82b3dc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xojznkQ14DVrMH9K28xwMcjVpn5o27N4FPtJFOU0LqgwLHTaPsXysW/o9o?=
 =?iso-8859-1?Q?+ys3ByAPb+5Bb8BqwXfBbUX5Q6j4YSbjsCcY0SnfZlsuideul/G1dnbFjK?=
 =?iso-8859-1?Q?qbGeCwVUyEPSHwEZkTlyO83dntd5PbJCoH0uFkPyQh6QMgbN86H64DV5C6?=
 =?iso-8859-1?Q?Ys8Tdz3eu0lkkcLqr7hZIcaTdFUwBB9pHDvU+6V3+bvaq6acB29QNXnJ7L?=
 =?iso-8859-1?Q?xnSSvZH5naxCXxXGJN6Xs8yaOvQ8TBtD9k65YLR4SZuf7Bs1aDA4tz0ZXL?=
 =?iso-8859-1?Q?kkYC29eOVIbiBsANDHZam8TH29XhjpU3an8qPPSR1UwbAg3ZkYMctE2rTw?=
 =?iso-8859-1?Q?dXXkLt1HhzLJHt/D1I6CnO3RZC3lizGVSE7bwcKXAi65VbCpAjGiQ+gQUQ?=
 =?iso-8859-1?Q?JRtviGuhjqYnG7tS4kZD1je77J/RpQATSYfzCS27fkUxC5qax01Ebg493+?=
 =?iso-8859-1?Q?yFpQIrDGtCvlJ+5mI4t77JZNy0zJHqQC8+GnaXJ1thIV7JRQRGz8bKF4Dr?=
 =?iso-8859-1?Q?gL/204KTMtcHtR7LH7fX1sNzCl9u6CwXx3m2IrwCjV5dcDu2QQz6RQVAPc?=
 =?iso-8859-1?Q?Z7gTocCvFv2aKgWk0FmlRN83V2mqFCoJZfZzz6NdBH4jfyq3WvQhFBxZ9Y?=
 =?iso-8859-1?Q?gx5MVVcySVtmBZptd6pLi9DWq2zXdYe8BYRmwhiall7DV0vCLBhBFzE9Wp?=
 =?iso-8859-1?Q?6H+fKBtRzE4bvdR5hANh0Z8XDsyx7PbtuYkDGpDfK94uJXPIOmWW8J8CR1?=
 =?iso-8859-1?Q?yjvHOSBZ04lgMX6pb/chYzD2u8/oz9kUu8mNBlNb8cVmeZBLWcFGzPnwLb?=
 =?iso-8859-1?Q?fUQWQm85egB/fe6K3Ko2AvVe+Z1cSGJCoC2C7dr4VBRvK3jtfo+UEkVUfJ?=
 =?iso-8859-1?Q?FBqti/PHniyjAMK7bC89zaB2COwWMCI0ysc5jqgbUMUoMbTzGkVW2hc+//?=
 =?iso-8859-1?Q?3n0RfFk4COfvn7pDTf99Jw/CgIK4mqYPIctjdxoFqmJhYOQ1J3pvmy/eq/?=
 =?iso-8859-1?Q?AHYN4zRlFJNCMMxrAjOPG780NCbXn8WoiZZ2/VasviOgFIa7q0xBIxMOAy?=
 =?iso-8859-1?Q?6GF/fXytgRRTLrQvFuXAPGxYhnDxGxoSpGgt/jSTrftLbxjnaZTQG7Pf77?=
 =?iso-8859-1?Q?E8dhqIdkSlYFoqftpPYnys657RSFln5M4BZYuMhydge+5sh4WHriDCoc4q?=
 =?iso-8859-1?Q?i7YFJ3tELpOv7uAGohCis2q9ezQVwqri2OMUmZBIte5SHeccG8kDoubqx0?=
 =?iso-8859-1?Q?wB5Xua0D1FZ/sEqHrKThbQdCKzRVUiEfAKLF9nRufCf4wH7rbRnQVBNQJs?=
 =?iso-8859-1?Q?T+LcF8/X+pYkTaAr7H3PVn8mzOI/2D3cB+bnGFFVVhKFM3Gaiha/4NiDTg?=
 =?iso-8859-1?Q?rwyBn57+LfG+YY0CWuGmpPwerT5lBHTybbRb+QSwJsQg9mtgWS78aKbQyz?=
 =?iso-8859-1?Q?x2FqaGsZQMTTXIrI6aBkvf0FiysWGQaVPTjDFVggfKQ0fiwg6Dd4GFOH1t?=
 =?iso-8859-1?Q?1UpswswLSXog75Ld/XPf2Hizc8ugzbo7RLo1B97JMyOtNlr7nvqngSgSa2?=
 =?iso-8859-1?Q?Oa2mxjM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dZI5kKRrOr4e1TBD4YdOnUj3dFAXdxn9EcOXTnWU2xDOwUoNOBTJZd528k?=
 =?iso-8859-1?Q?KL9GdEpVieHLcnOTaqqdC7JGYfjjtfSYFSRB1krFMFjkJGhI7vO88xoDYz?=
 =?iso-8859-1?Q?WQA2ocpkIjQYO9EG2xo+Y/0B9qd+ovCCRuSVIE9yVz5U9Lai0Smi4Dj3Bo?=
 =?iso-8859-1?Q?tgT4WhQuIEG78NPwEHVYZqc9j7A+RThypwMctTslk/qNpxkcnmzjczBJUa?=
 =?iso-8859-1?Q?fC58Cssn4XfbQzyhR7JpG1vRUCtZ8CbLaq7mpLd6z8gs4Z/bnIx8EnK8VW?=
 =?iso-8859-1?Q?v4gvQLaPpl+qN0KaamOfSFLAa3T/km3ayIBGEZnXUidhQUne+4PEe41ltW?=
 =?iso-8859-1?Q?0zPfQ9tC5M3HLD2Q2Vg5DscsipUzlc+4ngn+q7b/iai48VID3uKNaOlrp9?=
 =?iso-8859-1?Q?B6Ga2uygPfq6GpbFOUaG5vJz0WvDK3Ly7nMq4xW211f36IPBAXY+qg7Wwt?=
 =?iso-8859-1?Q?2ddnselfLb2OH958Qt2oRQ57X2OOVqB7pVAK3PTI0AiSIzIGAt29JKf1ox?=
 =?iso-8859-1?Q?7et82CcGhPJPgP94guHmOuHQF4Ykv5cT/LBT+fPk9khrUY3DcsjbtkPs0Q?=
 =?iso-8859-1?Q?a8yETK/LnRnL12iQ3xvcWpTC/LGkKXNbobxckvhTcdEpP287/0rcdE6mq6?=
 =?iso-8859-1?Q?M+NICxbmbPyb0eHxOkRjR3het+3DAP/zEnsAaDbE/MbwAumJ+xd1Uiy3OB?=
 =?iso-8859-1?Q?CWX+XeESIDPOW27TE/FPtAfZpjZwg1p4HtLDSAdqsLdpo0RMlEbKJ7HO8b?=
 =?iso-8859-1?Q?O81159FHp7KBwoZ+imCdLRkMfM1M2r79mHMx342AA5nzPxsxYWacJFvf64?=
 =?iso-8859-1?Q?fgrjDCk0QaS+0ewHHUc7NTc74wQ1Tky8YL41NQQ9jFgMv7kcfOrTbIsqCg?=
 =?iso-8859-1?Q?iFrHeT25Z4u8F4HbsOoqEh4SlhdPlUaa82w/QGyZCV88ajTA1Rdbtzsz68?=
 =?iso-8859-1?Q?hjhysxgcySWq1WN6LshsBBqlsKRiob60Wq/Z7Efc7oxHjrA+OWYSKYWFYY?=
 =?iso-8859-1?Q?tacmLQASu0ZrbYOWDbaWw+mrZcg4Tgq9v9R31zbUbKTQIAXxMNVNM5ji5e?=
 =?iso-8859-1?Q?wQcn66D7LSsGzO6X+RzHFelu95r7tBConHhmVUigbX5jfpfTtX+UaQN0gF?=
 =?iso-8859-1?Q?z4Y12QP78rYrQvN/xGxRqaJqr00Ks9i9+GCiNaKh4+xapjQRcYQC5CPTuV?=
 =?iso-8859-1?Q?fnHgDpsyJ7rUNp7Dq4m85wMt8O8lYKR/qljdKESbr3z+8tps2gqElRSVbo?=
 =?iso-8859-1?Q?IYXki+81ne1+mRftFKB1eOq/P+jB1n/xArijLm/JpfgiQvDnqAYAmMSsVg?=
 =?iso-8859-1?Q?KSRmWOMeDxEeJC0uVED9TOzJPOAiLFEFPhzFhUGshz/bDFFmH+8tCfEagx?=
 =?iso-8859-1?Q?rskUzL66q1ONgEVJAMOoT5XHiup+iDCdQO/XVuCwtjh9/hdBkPbktqIEvY?=
 =?iso-8859-1?Q?1IU+J1Q7Z7brhUrw6MHR08OXIdijuc3E5LPLWE29XNhiOWyYYwbJs14Lk1?=
 =?iso-8859-1?Q?B+Xu42n4Cut8r6Z+4Lgcv5mnH3WTa3s4U/fpAOxz8q4/5DuM6DORBW4pQ9?=
 =?iso-8859-1?Q?CpttkVDL8+qQjTRcmPejNo4errs7Ta406iw+HssDs5MDWZoEw+2nsl2/OR?=
 =?iso-8859-1?Q?Q9KwbD9PoZs7HW7e/sar7lOHiIOla5F7a6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fd33ee-0c5a-4b21-94aa-08dda82b3dc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 14:29:42.9768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0i/ef4N+KbHUlFeqD4gtHpaARj+Fe/PruAtzF0FbMkoI2DEILzPPr8rYnSD8XNLshSwFlYjV2VYNv2lO0WRUlt8ffMbBHG9rn682HBsP7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5989
X-Proofpoint-ORIG-GUID: uhpJYXIWrXe62JRhWUm0QeqeEB6ATizj
X-Authority-Analysis: v=2.4 cv=LuOSymdc c=1 sm=1 tr=0 ts=6848415c cx=c_pps
 a=VgCnPMcDAuiUJD6B7vVpTg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=i0EeH86SAAAA:8 a=8rWy6zfcAAAA:8
 a=zd2uoN0lAAAA:8 a=M5GUcnROAAAA:8 a=_5BSIg8XzENoBcZS56wA:9 a=wPNLvfGTeEIA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: uhpJYXIWrXe62JRhWUm0QeqeEB6ATizj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDExNSBTYWx0ZWRfX9xUfVOtX2INW
 masdPKvtzymjJKDsteh1xfUOS9IbiQM/zjjdZGMEUM5XzE1ttgdEWcLc74CaCRjBGABiJgnY8rF
 PcngOlFWVA2bbNsLfBSOmQ3lN03WZJN3z6TOSsN1hl+IdXEF/v1Sm8Lb7smpV0+RU7VxaoJ3l2y
 HD/blvoAgZM65RwvE4NLidzVyRj9E2+GRWi/DJKeGJDVlsh47BPSyxRuEJoHzS528PaASL5sKCa
 aGAn/GjmPh4UWcjEaQnitbhLlyxA8WrHurJ3p3EImYXjKe9wViNolsHbUa5I4NP4StnklzZUOv2
 PvjLmOooTiDvw8505FCsgXK5j79Qy2bt1i/9CS1BoPTLDsI9UdevqnC6qtB2HeYVQrDX+TOybbm
 OmCvsjF6RbT8w3zCJPXgbirC69tgvmZQv510O1inSHsCp4euab+NhjQ8THMlSwVjDpyfCKLn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01
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

>Previously, the TX burst size was fixed at 256, leading to performance=0A=
>degradation in certain scenarios.=0A=
>=0A=
>This patch introduces logic to set the TX burst size to match the=0A=
>configured RX burst size (--burst option, default 32, max 512)=0A=
>for better efficiency.=0A=
>=0A=
>Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")=0A=
>Cc: haijie1@huawei.com=0A=
>Cc: stable@dpdk.org=0A=
>=0A=
>Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>=0A=
>Tested-by: Venkat Kumar Ande <VenkatKumar.Ande@amd.com>=0A=
>Tested-by: Dengdui Huang <huangdengdui@huawei.com>=0A=
=0A=
It would be good if the selected burst sizes of Rx and Tx are logged.=0A=
On CN10K platform we see upto 5% improvement, and upto 30% improvement on C=
N9K.=0A=
=0A=
Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
=0A=
>---=0A=
> examples/l3fwd/l3fwd.h        |  8 ++------=0A=
> examples/l3fwd/l3fwd_common.h | 11 +++++++----=0A=
> examples/l3fwd/main.c         |  2 ++=0A=
> 3 files changed, 11 insertions(+), 10 deletions(-)=0A=
=0A=
