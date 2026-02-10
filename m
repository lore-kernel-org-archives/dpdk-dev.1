Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53CEA8114
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB65C4066E;
	Tue, 10 Feb 2026 14:22:07 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3AF9B4066E;
 Tue, 10 Feb 2026 14:22:06 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTNZB2972072; Tue, 10 Feb 2026 05:22:05 -0800
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020100.outbound.protection.outlook.com [52.101.201.100])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9ftc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 05:22:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orgJPujREUr1uPSfDIzfdKP7Cz8BPjlGOyeHpsA9eDUkDrCPHmSfK6x6LarMan9i2vsudpuJVX1tq5zt/UYb61iPhllI2U91tzHKRuh4n8ToKesfajfSfNXdtlWGwv3Nj7WKgDvHG8/QIrQpihWU4VsVFBI/4UFsGDattv1+FlpXkVXXFylGit4FStC3DAphDOfia/NPjONU9+0eLZaVDQCX4e4rZY3P6Fs87JoWw2gwaPdcHuLCt+fyrnu21rgutr/ZdmFh5aeOu+Wy1gIm8L5uIEEsNz+rlxr00j87A/ha6Z1NaBqC95N8q0LYNHiD4HM6skouVzYJOMnvzsRq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JniWw+7poNbLSe9XGZH/RWvZ/7TnM5SIc+w9nWj6KYI=;
 b=pgwgvJTOCcV0K/svqrZc2VUSvZL31JnfsK52yty0BJAG1zA7dlovCl9x5avVu5Z45XAjuDIppAVCDFzVMlpRQSsbRsXdnjfy0BYY3/KGDCG3FfvkV7RTqyb4OLwmscOwqbGeENkihq4MYmPMPH6EOK5kCu18llQ3HsQGuy1bDfPu7oyAnErV+nRih8+Hv8N34oOMPVnauIY0pHHS1X4Iv2C4HzJ4u5UjmprUYoAI7hfvWVAOqiW4AO4IXtM5xMgilayNl1dmPQNsJISQNutkawiGMWZhOvw5/xRpPGVJVC0GP3sF2EhdD0ufXsmjg3z5l3C2/m+Z9WxNR+jOkRZrrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JniWw+7poNbLSe9XGZH/RWvZ/7TnM5SIc+w9nWj6KYI=;
 b=QiZU1vSYeAm98iFXEm6Guq/hJm3jl0bjkv/xNVEdB2opmoxC+D/jZwCe5+fCLABV0U3tHCFbFrJjwUcWzyGYrZWzxoL09b6UPVNu/kb77ak7O+wk7kd2aQ4yjLHfJ7cG4g5sgxgWV/JJJ5RLoUs2CXdnRnzjTlCJT0gYWp6JpxY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH0PR18MB5461.namprd18.prod.outlook.com (2603:10b6:610:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:22:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:22:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] test/crypto: fix mbuf sanity check failure
Thread-Topic: [PATCH] test/crypto: fix mbuf sanity check failure
Thread-Index: AQHcjFY95GwcnIioTU2cv1xCOkkGUrV8B11w
Date: Tue, 10 Feb 2026 13:22:01 +0000
Message-ID: <CO6PR18MB448432AF690326D71FA7AFC0D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260123105123.3763725-1-nkaithakadan@marvell.com>
In-Reply-To: <20260123105123.3763725-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH0PR18MB5461:EE_
x-ms-office365-filtering-correlation-id: 7839455f-028a-4935-8710-08de68a76053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?i/lSKANon7uYSbXEZvWhFtDkaNjtzlJLu8eyG6AVQ/QktsF4d74mokF0dueU?=
 =?us-ascii?Q?cxy8bUsbexg9q1YmDmbBPobpF+rBM5eb5aEF/07ZAEIqXe46mnI/vQPqpE7C?=
 =?us-ascii?Q?fZ9VOyUDWwvZbaWOm7+eZcP4k8eIkY56KqmJVwFA4H46DoWVuo3ppoZ6cr5Q?=
 =?us-ascii?Q?4PXVW4X+eXjtQjzTusEiTulaZgLN5JOFQ6nqewaArEfa7tGCsqSEIg49zSJO?=
 =?us-ascii?Q?XPqRq3nuQE2SVm7XNXTRl/hupfSfYwFEH/SYSGJfE1dx/C1TkAVCLhqFKJCL?=
 =?us-ascii?Q?WgOfzGh56EnLpK0TmCY8+NlBuYnsuXbhgHQz3eemItqA61GddAbRpcbs6tog?=
 =?us-ascii?Q?I14mU49JCyyiqqToTUBMH+Uf7ehe9bWq7sQVXCbk8lvQRZ7rRe+x5KeKisBo?=
 =?us-ascii?Q?LlFuWO9aAt5lpGqpxxMOiwRg5p4Q+oTRefSreGE5FwUown9u77z/f993p6EB?=
 =?us-ascii?Q?hULqe2kv9TkBRDqP3FVm7+xtS70OU70rmWfOb5gCjManrO9dB2FLnM8kvy/I?=
 =?us-ascii?Q?tVA4m8geqmFqRDJjxzsHO7xOcTpwm28QgYHbTAyIZVoUuxvDZfOxu6ApGqRv?=
 =?us-ascii?Q?jy1PtXxCELMq3+IDFYHI61XhbhV/1Xe1Ra+Vs917pRfNvGvTfnz06vdVPzeL?=
 =?us-ascii?Q?+H4tn+OuX7WLtyaGc1Hvl4YmeNDEJp+zg/+ZFEfYzSvxttpYhwFFWXITI5X7?=
 =?us-ascii?Q?OjKm+vQaoyWATL9azi7ey5HwdzqaI4+G1hV6c3oLLtd8qDwvPvear+vifhgU?=
 =?us-ascii?Q?cu0y6Ri0sXJA4Y+mHULyYWtbsu5gc64ju+VztCwun/m01G6cg257+55iEKIf?=
 =?us-ascii?Q?l2yRryxt+jlWzxUj+MyfNx1w0gIOOXY4H7fEDQUguuEVBxnPpQbkorRRqrgb?=
 =?us-ascii?Q?qeuo5SdsNF6a09MmnNdP5H2/8XuZTE3BGg2GgBnSeP0jM4qxf6PMZkV1fqsi?=
 =?us-ascii?Q?7Fv5wtm+hRG9z+CR5wOfpHB3w29B6vZzhzKKvBJXFxzhAfSgsKK2V+/dy7Um?=
 =?us-ascii?Q?vN4s+zjMbxf8Caou//EtZRCcj8WlK+Md4qYV+6K9nVDn9peayYfrsSBwwnPY?=
 =?us-ascii?Q?fyKaq9SO8GD17OU1AO2pCWgrA1iMlwHg9GjNDtqBLH6Wp75u0IFF6flgvkLi?=
 =?us-ascii?Q?1CRKHEAjKv49bG5dA+zAvwwpgoiEkYuYUEf6iVxUL8v95+h8bFyWj3AKsISd?=
 =?us-ascii?Q?GjJarmjETr85J/KANO+PCkX8CKgArp+fZJhK8v7jFx3uKlNVcvesWkMdmrnI?=
 =?us-ascii?Q?UPlBS3fGKaK5zToFqYiV5i3MP88Wcsm0TpAdZLVVF0/RxVS9MaoPqdxcghHm?=
 =?us-ascii?Q?hMvIiY+DnZDAAKRbFO3bpY+eMjrMpQWN2W9LeUS0lWRPl3z/tFH9I1AR+PZI?=
 =?us-ascii?Q?Xi4tXyzVIFrG62MIK82C6YUyYzb7GHc/aMaep6EM/yxkFA3fntPKhKbZD6uc?=
 =?us-ascii?Q?GiRCulWMwbwB8GTtSs4JKWQbuzaEDgMFE31nrDJ+4JXvM7bCSesyH/yp6tx0?=
 =?us-ascii?Q?Esrz6wgat53dIHbu/xczfXGSinLKAGOi7vItDJdyHzn0iHnufan3e3m96vpS?=
 =?us-ascii?Q?hDcbxg03Mq1eW0XTCc+WcT77h7ZFuVTc4818JCYwTf3b9vbTKzmbYVy68xNA?=
 =?us-ascii?Q?CR65g9tBNcMD+v3Yz38XSmk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Xh+5Jrm7a9umYcvjAw7bd2CsKhhS0lzSMu0IsBNZwoXfAiCBojZnYa5zfQY/?=
 =?us-ascii?Q?tntfzWHjk1eCaPqfsj9Jcfhp8FF4Y4d369uUW/ZluwMrB2h4nHdBIpbP1ngK?=
 =?us-ascii?Q?anAtxEeFqKZpJXkBNFejSI2SUJSU3pxIdW6BiWYtSHxUq+G4et951+btKHL3?=
 =?us-ascii?Q?G68txAUrT9uLpAaFTlnPGMb2qIZPQnXSnA83PNqm4TbJ1kmWlM/koNyxQVuY?=
 =?us-ascii?Q?4aO/vvNCdDcaM9hQ7wSXp3Ox9pe9HWrS/rMoyhyzLE69NULXHSTksG+oMu9s?=
 =?us-ascii?Q?k8gc0uD3KGSR8pJd1E4pPn3H7E3cd6YNRBLzUu1tjhrrYZ9NqnlcMhP05IfQ?=
 =?us-ascii?Q?W/nnvaYuMBknlHBsT0s43RM+SAWbTsWfS6JpJVD9f6GDU7dQbNc13bOgx6ff?=
 =?us-ascii?Q?a/4SWtcSSJ1VLp3IpbefkpfvIeEc/RLIUn3xQWa2OuHSl2W0/In4l1daGo2H?=
 =?us-ascii?Q?8Bq4CUpBhTl/Ifbg4GXUWSfS36lq8xkSyObrnqsMmGxbc1aIxvhKIDuIAbCx?=
 =?us-ascii?Q?KbDlDc9Df2u1jNpJMaupRY249lDoZ/Z2j0YIifzT6L1FhHbKRpXzUdZIsWLH?=
 =?us-ascii?Q?uUsvJOGghIIHHrFRV9efegCz5vC9OudQEg4RvlxmeUxnIwMyRtNM/0xgCCdC?=
 =?us-ascii?Q?riNCYvAsHOonG6zbQPSMQZp6Ld3AAAa0Py3hwsyF6KYJn6gAuw4NmqmpXR2q?=
 =?us-ascii?Q?6trfG+y5jMlkN+Y/MwscN0wX3aBUMLKtMfmb3+hpHPTZdmE5D9iG2bo01MIL?=
 =?us-ascii?Q?q69/jA7/r76NxMrltqMf36V2ZbG23BVEmIXpcH2ADELSqvLBOADSduUjIA4n?=
 =?us-ascii?Q?caq2IHn6fD/x2cliYKW8WsMMd0kOujveTJgrW5jqwDAm8shKVW94U+2o860P?=
 =?us-ascii?Q?tOY8TBE7qP9SKZru7I0ZUA4IiMnCMigMJDSBC2n2qyn+p+5IcnaV18P4I6sI?=
 =?us-ascii?Q?RVS3M6bV3YReNxv+Bo9cyMhr6nyKU5VIjGqaqgREVKzMfcTUhSafRvrpucsg?=
 =?us-ascii?Q?NMTjnByKQT76JWAnupqhKWf8e2jPqJ8ckWNUjBjS9QiofumxqhTjmuvomWeM?=
 =?us-ascii?Q?2i4Q91LOsfw3L3BueBQNqqrZrinc/fOlg+IuhFrZw0nKdCfJZvdG4AJclyzG?=
 =?us-ascii?Q?cl0pX9RXraXhtItih9uL6UfLode0hrm9gUnqABeUHHHQyXUR8DgWcZiasd6f?=
 =?us-ascii?Q?brBye65P2vUlv2QoDqOGQ7k0r2GrCQH3+f3cVFrRlF13gJuUSxVbHO9xCoZ/?=
 =?us-ascii?Q?VcymBlcwH1DpNfUvMkZjEXjv5xSWOukfjlYBEtZ9udvS0gE6nB3mgreooI7Y?=
 =?us-ascii?Q?9u4BYw6qvfPkQVbLHq9ays0MslBpE1DUTLXl/IqwD3AN7SEH1Pb9x5luVuf8?=
 =?us-ascii?Q?M5R4/q8c2jCWejgRp9tpATj+sb9bVW1dxbfZodBu2gl9E9D8F98swJntW/bZ?=
 =?us-ascii?Q?FSWpI1kmJvw4aPNFv8ImlOTexFp5VXICVlP+8cBOW/WiKyZv+sSZ98ospNEY?=
 =?us-ascii?Q?dB+7k75frSEE0+bDBMO+EStF31xS2A1kf1Kp6kX8HE1rLR/RdnXKzM4e9gFQ?=
 =?us-ascii?Q?bSpmPoGnh0jOAwNm/DCy3G7Zy2amU0OBPyDBQDEhhxZzT6kFgQSWsxlmGNxt?=
 =?us-ascii?Q?ZRCzo34d4yrW11GDQmAiFLshWz+bq2RKmr9LGfPu5iRIEmFkdv7sj1XZ6MaH?=
 =?us-ascii?Q?mJkV9uMHGim7M5OZOJGpcMV1Yr6nBBq6UVs+X8n8JIZM+A47?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7839455f-028a-4935-8710-08de68a76053
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 13:22:01.7894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDI2RIyvEVZ446GT1AYO1o/wPeSghd+fh5m4/BkTwZQkOTK4dc4Km+jUeTWeEihOkbtJt5UH586JEDj8yIkaVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5461
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b30fd cx=c_pps
 a=jBnIPXBCpefHP6rz4AJLnw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=zculpX5ScyP0XoptRm0A:9 a=CjuIK1q_8ugA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfX0f+Ak/I16pbw
 Dj2U3xxybFRWLffSQO32HHBz6mrfLvH4Gm+AlMBkGvm1IUsnXk8bKgh2W+Bh9bzSTqV3IyAzqdL
 lueFVE1ZPHmYmIMDoNiyb+2htdVKURZoyqqKyhDN+6RMsu/McDsCqzVM6oPcWSZSFq8jmxc/Ie+
 kClOPt6jDfPbcYHJ+4TBWC8KoVfFCbBsogNkzPVHW3QIjydXbo2Iazm9aDdz0oVW6Kn5Q132WE5
 PdiTA3x1NhIoi+QgMPwhMu09CjSpkJCH7aEAD39oaQAEvxSjm8QjkHsWMSQOsA8SJPSvtF4UbzQ
 dVdQhorI9xZt5oy1NpKuGIjjLjGJtmGVXZO6pkIOm3RsOgzRsxLziYGH2KvvhK4NvuQ5Nx0seeP
 +utx0epSineuUhEmp/u/4qKQk7mKwGNa/AvNH1d1hV/kkgGb6mTsu7sbtr9p+JDR3mOSnadDxF+
 eg2dDW6KBhyVQMZV0Gg==
X-Proofpoint-GUID: _C9lvmRB1w64fZ7Meg6kLHRHovlP5af3
X-Proofpoint-ORIG-GUID: _C9lvmRB1w64fZ7Meg6kLHRHovlP5af3
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

> Subject: [PATCH] test/crypto: fix mbuf sanity check failure
>=20
> Fix mbuf sanity check failures by updating nb_segs
> field after mbuf allocation. Without this update, the
> append function fails due to incorrect segment count.
>=20
> Fixes: dcdd01691f39 ("test/crypto: add GMAC SGL")
> Fixes: 43220096d66a ("test/crypto: add PDCP cases for scatter gather")
> Fixes: f3dbf94be60c ("app/test: check SGL on QAT")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
