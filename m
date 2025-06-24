Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF9DC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8136440B9A;
	Tue, 24 Jun 2025 15:57:29 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id BC7304026B
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:57:27 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NNepPR015008;
 Tue, 24 Jun 2025 06:57:27 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2091.outbound.protection.outlook.com [40.107.236.91])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47fgsqshbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 06:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFMinufZnXMTKGhX2Nm4HkEcHqToCwogbeNAk9QSb8laM88jU8xqLZBu2t3RSEirBXF8LpCb71KnzmhvvqT9EKmk7J+jRgky5e89UzjUIimf1VPQwTmkInBkX3WKFmzC7ojX2AymDez4nnXLXYqYqpnyzBddjo8CYd3KnCikeOFarsc2UPAe7qWrstPBuEsFjs7zURu+mQSt91jEqssRq2Xu4DdmBXlpRIdtYB1jP11MOxAyYhgD4ERQp2/JJISk5ZAYD2MFQ5TYLnZ2Lll9lMHa0qdhaxbBrglamT9it7UkbOX8KQvAGz/FXhjZr44JW4mLsECjGyBErTeXYDEcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF+l9P4ND2tHzUc57w10aXe4uPDTGDd8CNXawEClArs=;
 b=ak15pKPa0D9PwScxt6idd80eXd6OPjaeyZ4xF0/rabeZ3p8OdLVwMIFR/WpGdwKf31UMSR865QgGjD+hR9dQ5/BTfXy0ZfZCmvOv2uTfNx/h4gwf7S9V88yiffDUuCTf7pGpgJfGw1+0zqux3z1kz4PL0j2PCKsjvpcMtOoAj+328Yrv5s9Ht0B8K/iut3QKVcfKAdz54ObjGTM9hBny0mJVMNemzm87cHnfLalWHeCEzGNdYVcJ0Lgq1rOxMNGKi8fQw7MWbmohROgxj81A0awnygg4IFyHmjTdBbNeXdktqtsvvZMLw6koV2+ii6JP56FewXauXOhwYKjsEfS8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF+l9P4ND2tHzUc57w10aXe4uPDTGDd8CNXawEClArs=;
 b=QUrWPjxTCeDKWvdgiZGZToGqPOZza3q+fiqy3oh5AoQ0T6deXRAxLU9mZsx7hhnMnXhvw7OIm1YqkqY8LOsU2bpnxodPutCQlkQ/Oz7q72y5oWz2EtMiMc2OI9ap2gzhZXPObaPs8W2vz6n4536M8p6+Bm/MBsydDH8Jism9X9U=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV8PR18MB6099.namprd18.prod.outlook.com (2603:10b6:408:231::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.30; Tue, 24 Jun 2025 13:57:24 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:57:24 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 2/2] crypto/uadk: use async mode to replace
 sync mode
Thread-Topic: [EXTERNAL] [PATCH v3 2/2] crypto/uadk: use async mode to replace
 sync mode
Thread-Index: AQHb4ZRoLSCyv+ExT0KGFdJ305Ux/LQSXHyw
Date: Tue, 24 Jun 2025 13:57:24 +0000
Message-ID: <CO6PR18MB448446A9CA5B480AAA957421D878A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250620033515.86501-1-zhangfei.gao@linaro.org>
 <20250620033515.86501-3-zhangfei.gao@linaro.org>
In-Reply-To: <20250620033515.86501-3-zhangfei.gao@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV8PR18MB6099:EE_
x-ms-office365-filtering-correlation-id: 835bf07b-10e3-46aa-8207-08ddb3270c31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ozYoLnO7AgZxuzfzEc8GOHFM2lMqhRy/o4Xbskz80+EV9MjB7serV37Dov1l?=
 =?us-ascii?Q?MDvRz10wA3A46clXqfQhmrp8Z00TgrnEP+yrLJE24RND6uNx+9CTWd1oRfbL?=
 =?us-ascii?Q?wKrdubKmb+9T5IT8FDWzf1StIzlceXeYJtfB4nYNKJCjLNNTJ6t1dd0vIjap?=
 =?us-ascii?Q?Igj93+e/vmrLZgG5ghWTVPDsC6VICQOeAaJ4+zcCbVEkExUPKQT17EnoWL/k?=
 =?us-ascii?Q?OEowO8P4ap1yNEOc/YY0qwQ7vCv/g0BVmXbY07HKLpdlYh5+YIPmrZJs34Km?=
 =?us-ascii?Q?n5ZJgEUXeWRLq7uHql+t+oW4Fyb7EHOaxkqWkEDMC3jTvlWYmbSr9NNxSYfb?=
 =?us-ascii?Q?4Q7A3izgnxRDDpW0gYjEP1YFAiUZLThfCmnMUmOl+yX0+mAT6eYa9rTp2E7u?=
 =?us-ascii?Q?rbTaI7mCqzgRV4wMJwqbzE+AnYwPo6aq3bFuI+XY0oif63dB8HGDLl5qQXo0?=
 =?us-ascii?Q?IcHlQOYhkEyM0zserfSOl2c3m6BKNKRBt5zFsB7qkIbZ08YOcNjH3ilVUaAq?=
 =?us-ascii?Q?qFrNXmDJVHKb3CElo2/zQwDkdhm2mAD4aYHAytS5PKVWKDJ+Zxq2DgQZ86NM?=
 =?us-ascii?Q?OYhETKQvJIyS9LtQ/zROLidRDaS75a2hrWS+lGv4KNG+L7pMVk8WoEdn4PNR?=
 =?us-ascii?Q?89y59W720usVMzOMjroQWLbxjbCUOZJhdHTwWESmGxdpT63rSi6PoC91tsKo?=
 =?us-ascii?Q?y2HlB/4EXriAk/mTF79Es6CS4hzgNiLNbhGpfLNYDkrBd685Xd7BBSNGM6qA?=
 =?us-ascii?Q?xLaxVTKd92u0NoLuRGbA7ia162LzowKs3LcFEmo2E2HxOoSuAS77qO6bPgvf?=
 =?us-ascii?Q?0/p0FEXvzl82f7tc6cF4u77lHQe5x2knauu7cEpkX8Re3W5rQrN3EXbg2u9M?=
 =?us-ascii?Q?sEmQ8eD13DZLPuA3LKowjTr/Ioi2tUSOnVhTOG5+eXVdQJm6eLiPLusSDJMz?=
 =?us-ascii?Q?kORSOIjH7N5hFYrWF+pN6OQL3v2eQ8ajNOhDXika7+Y/JfwEauiqFGN6hrMp?=
 =?us-ascii?Q?wmX09cDPr0ppzZvgpp5jKLFuSgsYs1fgxxfW5eyxpnymcL01FiWEfs7kOosC?=
 =?us-ascii?Q?EQPNIIOPoZU3oDfgGr0FUTT1+b085jCQILeWbXbefrBQjKrbD1bQJTry9gUP?=
 =?us-ascii?Q?t6KRWyDwrQPfzrL+eHrA7DQEWcy1URYR/2qvevyIIJFuXVYgWZjoehmaiAKx?=
 =?us-ascii?Q?jnOFz2C1rt1yeM4X/Pyg3Fvk2vRMurz+u4yB/73FvesELbNQACN/JpEuNnPY?=
 =?us-ascii?Q?dreQfUWTyMR14EUs6vh3sn0elsnuvcSjU1NavCOMZ8o1WiUT0ik+ZLvOp1lK?=
 =?us-ascii?Q?mPUFpqGA0zg/Obty4uTZHd9k5yQkXg7lTaHm/nic0hNxq0vDR8BzygP5o3zu?=
 =?us-ascii?Q?6zrFID1+fDQr4FrBw+wJhOWBj2NIQtL+W/uIbXqHNbCMbMBKwOvV19HsgJks?=
 =?us-ascii?Q?+vmSfbICxn/JCzV+DmOLhDjqYd6oCVWSFetA2Vu3ZrTqul9RiVMbFzci9+Pm?=
 =?us-ascii?Q?gry/kRjvST28+E0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+4I6IeR9xSAYd046JXgYP3sLQZGF+Pm3Uvsf4ykCsTyOeigCqAcwG79705Ln?=
 =?us-ascii?Q?4jfkbfGpJXwUw0+yUgohBNt1ZCVypIfowc0/EMCeFucSPzzGcKOgYNrz75GA?=
 =?us-ascii?Q?iHUi68ul4JhzxzkEcvpEjbgcWMGOaoUL6N/Z+5VH9uAqvdHwbPri9HIKy28U?=
 =?us-ascii?Q?ELIuZo4hlZ9rF0pkfofl/93nosgPzynaJFr5UuVrMlD4VdtfJ6L6PTefN2Qg?=
 =?us-ascii?Q?9XDrYqb24Dx8yexyViixmK5Hl9BN965JloUn9vkMfxmM5i4zB/kzpK+W1mc3?=
 =?us-ascii?Q?XAQln7tY6P8nUz/XdrIfyAx3nFpvUsHSBFyG1VilZHkbEmmajfAwiMrPZ0B6?=
 =?us-ascii?Q?KRHr91zxoqTAFnBhhD4jPUfh+hMUP+/EjQGU5dHkJSOOgbIo73LuyzDVZQnP?=
 =?us-ascii?Q?mX0AOUOzT5ObZdv8XExKZ1m8pUSx2zGs2OIQDpfUyqSEUb+tHZd5gydsU9aD?=
 =?us-ascii?Q?BzCUIDVQld6mFKVpvmkVt8vXBnGkoonjOTr8mhqt0fItigQwWyQrf2yn5Sos?=
 =?us-ascii?Q?frCev5wRuxusKrFV60AP2DhqUFrruEDByNawxZgYrn4QqQ/o5ssn0AP+p4S1?=
 =?us-ascii?Q?+0Ri8PJYlugdRKRHlKo67p79R5bv5f38v6Aj5xzSdjscH1HKWHZ3dyjPvjQ+?=
 =?us-ascii?Q?RXGjQgE/Ye6jodjJ06Po/w3jEcgom6sbWPsioz14k1jOrpcXdeQ/srjQN21C?=
 =?us-ascii?Q?wbgNT/W+mkSzmOHULb2XdMI1kfAdDtGkDkkQIqRjdHORw2FpVAWzhSHFpHeW?=
 =?us-ascii?Q?SAH9TDU6lUAuU1orNk7fU+zVA4ndT03payWmo4DDdRtIWF4IGsFzbs0E+/o1?=
 =?us-ascii?Q?L7qWJmQQR+8+npeTnM7DvmIy7nEbnv1MmH9+G/L/jOhT44BSCYjMnG/VGk4n?=
 =?us-ascii?Q?bdtb7bAMeb5MKE6AkP/r94ii3NKAn+CRz3R+9dK6GHxlz/5KRN4oQ3HNfhtN?=
 =?us-ascii?Q?q9C9WH31U7Chp8E7WhOPLWJ/PvYFQNys11G84zf7/D6tGdLld+owzfheYjxi?=
 =?us-ascii?Q?1fxtgZpDRXNz4J8RXoSksOuAhjj2mIT+OIxkkFmd1mlxVDS7zHf00llxAi2l?=
 =?us-ascii?Q?GBbEqTJDe2lIAI4rf4FSwaB22vA9xB6h6Iufk2nnUfdZtu8/FZai9ESFNOhJ?=
 =?us-ascii?Q?B2pr74vmSTHdinNcYMBju5NrrYBU38XKEfbYRvdbnbukGe6z0ZHcrHYaOZB8?=
 =?us-ascii?Q?5CzhEPMEVbmmOZA/PVYdWGMJbPSghDDIVeVhZS1YM7C9KLtLmM8IFWAFpq8o?=
 =?us-ascii?Q?X23PGHaO/rOb4t3jgjnlYhLdzKWL/ToaZy1z1tvZj5RH6B2J5SKVOEjwf8hj?=
 =?us-ascii?Q?DxLS/VUiLSrZFp66xPSUAc7vwzT2BaLnPbW6uLGoC4+G1xRsqYd+2bg5exuM?=
 =?us-ascii?Q?nfWcnF/2FXWYI9I11KdhpLKMMxCgmMoWocJnS0qt0iUo/Rr8ksStqiST4GyQ?=
 =?us-ascii?Q?QuM1iREmQoQww4OazSAPZW4RmZEG2Na6/QOU2Qzk8eFMGCyhkM3qf3ELoRG0?=
 =?us-ascii?Q?uC1YVGrsNc3pAD9bJH0SlYlPJJa+kCpVv2phgm5tBssULY6ngf1QI85t96jY?=
 =?us-ascii?Q?PBTw0CMMJ18OOZchuPvwiWR9QMXM2n1PII1JZNyZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835bf07b-10e3-46aa-8207-08ddb3270c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:57:24.5754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XydRtJwcsKGakqeyfJuYNqseX/82zgvFwJ58lXqWwWdffqSDcpc6bQIDbkwKtWGqAmx5wYCMARRX/jnHW0KS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6099
X-Proofpoint-GUID: YQ7XTdsIDIPd6pJpVajt6WcdFdZC0yfw
X-Authority-Analysis: v=2.4 cv=DOqP4zNb c=1 sm=1 tr=0 ts=685aaec7 cx=c_pps
 a=vI7cwuzHBtkooc9oao+6fQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=7hZwttbINYQSABtof1EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: YQ7XTdsIDIPd6pJpVajt6WcdFdZC0yfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExNyBTYWx0ZWRfX79l9XCHztfLJ
 5U/ET7B952bW4steIKbFfFjQnSiSpOHLajwZKKPo4LLMtY52rLk+QWUlklgQRLAzhCoxhvzVUvv
 +HEsu5tU6Lo9jihUUu6veivoCClCGMAx+/yZMfYc42L9wbIKHvCnLJ4uS6rHDO0hg7aDKfmK6Jw
 1MCLeWEgAWQeILLY6s0mT4OE0spowDClxfJrN9/NWkgMVztPOI4uupsgQV6spmIksfxFcud/dFh
 pb3AqsxOLBugbaf8sV9UjP0vMWQD7xDADGgEd2dynHFRCxfMyvhC1hZz/9RN5RJE2x33lFwW8JV
 t2EE2aXudIrw+QGWQvK3Cx+RPEuKtO3YsCPqhgBQY2PXRme0EZLKXRHsRM37uJMLIyMP7ElfZJ2
 kkez4tw0XUJiqHdHEPWCsOLkO605l9P3qn1WVroiDBBmcCgbnoa0ooETZ3riiH2vet7EPpl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
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

Recheck-request: rebase=3Dmain, iol-unit-amd64-testing, iol-compile-amd64-t=
esting
