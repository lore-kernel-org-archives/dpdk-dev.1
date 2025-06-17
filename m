Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87C3C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 21:24:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D86AF427A1;
	Tue, 17 Jun 2025 23:24:55 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 76670400D6
 for <dev@dpdk.org>; Tue, 17 Jun 2025 23:24:54 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HCAkvI001670;
 Tue, 17 Jun 2025 14:24:53 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2122.outbound.protection.outlook.com [40.107.220.122])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47b84t9a0y-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 14:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fffik9sH9eICh7dKTMijrKB6KL72ER0MMRMeiHoJcrUqC6rw/8TswhLHON5lOiABkEhoVB+JG64DcckwwhWRudyrXAMmVBw8EnijT/h3pbzB+5onN32ffIVUdq26pV7HM4IkX+YW/75geFfLCmBx2+fQSeo5CEspeBEzRlbHSdQ0ZEcfB2yUN0wssF7Ev5aiiCx2VTKsJFMl9Xt1zdfijI/ObrIJf7O3FQ3DqB67lRomJaLkOyxaRVaM4mQrUWCc/AwN8NEhHqNxewfo+XtGYHdlkOiaVcD0Ug6DtsdXEumRT+lSn4wjv5ruJSjjFaYPii9lP34xh2WwgFUMb7JzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=476oHCjBn0HREnD4M22BLWjoBfuIW6U72seQgGOxg2Q=;
 b=gPQbGxIVEcCVuHTgaRCgmdW7xefz/acZt+ohNdTJVgF0D4bOsczkMoZknJhBNBkOokppij5YRd+S2QXSVt4TmbsC8njWSJR11pkWelkORJKoeOnOw721r+m9wnWp4xYA4Fb8fE1cW4/b//dw70sQ1GiBxX6iVBGk6j/K2Egd6lkEwEvzT1isAb47FGem+/EFX8frQddI0RtyaOXwcSUeeaWP5rF4jdNjJpNjOUse7AVwatWLmjBivbNRyyPQCnwn6upJqmEUzG1BQcbEDbyIMNGx0I4DDWuRYwyW1Rq1oEjGrPvDoJyH8sNDk9yjftkafWvaX8n1jWWSZO/pTtoHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=476oHCjBn0HREnD4M22BLWjoBfuIW6U72seQgGOxg2Q=;
 b=Boa2v0Y0c/aqq/zx/TZZuQzH3LrWII6SrXt+RAR6rberIApoGhBaqsCMXjM/9uDtzNYXVLIGEFR6c7m4RyXXddejedV0S+EaU95/lphkzOQTdzy2mojvv6jOaMgBPyRrC9qAbaodd5ZqEP5NKQVbyoagTx9/TSmJ3Jp188ORGWQ=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB5261.namprd18.prod.outlook.com (2603:10b6:806:2eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 21:24:48 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 21:24:48 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, "fanzhang.oss@gmail.com"
 <fanzhang.oss@gmail.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] app/test: update EdDSA test vector description
Thread-Topic: [PATCH] app/test: update EdDSA test vector description
Thread-Index: AQHb3oiqtlgGOScRj06P26Oz2s/5pLQH3zeQ
Date: Tue, 17 Jun 2025 21:24:47 +0000
Message-ID: <CO6PR18MB448454571BC0FA7D56E8BBFFD873A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250616063350.2507803-1-ssarananaga@marvell.com>
In-Reply-To: <20250616063350.2507803-1-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB5261:EE_
x-ms-office365-filtering-correlation-id: 12d041b9-8fc7-4608-633a-08ddade56338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aqk3JG3dzAoy+3UVbcFqCTlSrWWm7y9/9jrIDmnVanoSMOnEOGgLnc7m/SXM?=
 =?us-ascii?Q?gbflLQkmwFjX+aPioLteeCVz/BViifG5LYdh87WCgSArK126vO+3fsCPwCAt?=
 =?us-ascii?Q?dNl2O3A0xbfBmI9xPpAM7u21GigbrK10UtKjb5aotpzvxE/0Tx69wDLYIJqV?=
 =?us-ascii?Q?J4Na8SLvqhM3d6QCOG2v+uGN9v7aCmwGBeBV7cOU93JGFg/FwvbjYFmk3gB3?=
 =?us-ascii?Q?TMF/Nztl03Mb4sTL1KCKt9YZeNz0V0Zuad/0K2BnII+WeMo9w8jc6lzWeqQP?=
 =?us-ascii?Q?0RembWM/oclSFO45Yhq2ctqDza4QpvHf34fkC9ZH55vnEY8tSSxB47UXDFRE?=
 =?us-ascii?Q?O89viV8nNoemgNEiMawo4HGqh7EH3W4PDpWBgHUS+a+/Usper7v1DhVBT+66?=
 =?us-ascii?Q?vI1WNBjN15XYmQ+7t+WmgJxN2icUxGmpAuYMsHepidMo/cVjeJbyHGHMFcCN?=
 =?us-ascii?Q?F9YRB+7H6kk8soHD/TP7T2r4Z/FYUbF7Wg15Hdm8iMuYWgTK5gFVTC0RYwiE?=
 =?us-ascii?Q?Ev7uBfvf2fcrJM8rX/GGBRy5j+ZNVDTqRCq3ZFjR+eezEEIEMIspAuXZigLP?=
 =?us-ascii?Q?4U1n+dQWzHVkzJ88teQzAO4avvDWwuCwzga4+qzrPrKWoBOT0nblMAAjwYXj?=
 =?us-ascii?Q?sKxLCP/ZygMjz4l6IHNhhORVTm7VH7E7hPp1yt6H/cGPcLpRbaOq00jjct0k?=
 =?us-ascii?Q?t/0fxPDXKoczsdSlywtwlX57dxZfdJYk8iEhneqz7Cbfj2VfWMbb3MnBPdIG?=
 =?us-ascii?Q?SGZusw6wdI7k8n/WuCLq/pXH5wDz5UEAUGAvCyelnbcPzJ3aPsLhJIFzMgKm?=
 =?us-ascii?Q?IKmHtqi3p80DI2pnX/v3s3QcVn4EJbc/5ip6ouFcYxSO2Z8cqHVk+TaIEcbK?=
 =?us-ascii?Q?raYBOHwiNa0zAFfjwYEJG/NvzP0VYZ72dQjE8UOK0EYJRE28rUDQkTpi5p/H?=
 =?us-ascii?Q?N5FiwUSilbTXvh3YAFtpkHnD1O2pkzuP2UUUJ67VPz6Fbh2YYyoDGU0UsiaT?=
 =?us-ascii?Q?CHjcbgMX/vxkMxf0A25gHJvCbWGXjwVAj9pqMQr1WGeB40L374a8LoqSZEy6?=
 =?us-ascii?Q?QGFzm52kbNdVyyUvbNAak0Lkmm/fodxyPkWT4OpoKGJ9D/CWBWbZn6DjJ0Ts?=
 =?us-ascii?Q?Rf4EkhwEBhYbqQl22av2ds+BezzL/XUoZoy99Pb8vp7Ie0GLED7UGvjFiLeU?=
 =?us-ascii?Q?M5AoQvPctO2fL04yDFgFGA6WVQxVkViHtIoYvEU0KBU8uIcU0dqZrFmwq8/y?=
 =?us-ascii?Q?k0d/ZOXeSqo+R+WIK/OvTLrthC/uVIJNEd9w/LUpViRtaHWsX5z7GEV4LDjL?=
 =?us-ascii?Q?brxN31oF4sMn+MJnuqFj4Jnw9MZsC35gIXVng9vkp/aj/BUChf1NqwqJLtd3?=
 =?us-ascii?Q?pvphp3pRT+5Wfu7OuYdrWuBHbam8giIDxpvbkU44LGdxEhRa57kK2dSgQ5Mh?=
 =?us-ascii?Q?syTIqFCnmHON/0pyNYFjaS5ctGUsN0bbrJYAIG9m3geqXF3eP0AO2A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUSMZ0MoyXBumAt2Yc5BC1nQotRWjmXJJME3ZJ1hNdU6q2Pvbr1+naubzi+b?=
 =?us-ascii?Q?tgdFWP8DNTw334TEuq8WpO1ggGo8rWRWgdvVH5Zyeo2qwsDzclNkOA8mrG+o?=
 =?us-ascii?Q?G+WvKZdfkOk2DGTkH8/gZRW9mwmw6CF2a+2lsWRHjsPBsRAJJVIMA09SJFap?=
 =?us-ascii?Q?4AuK48Nh1XdMyT3WdBgy1cXCH7UVDOgXUB4A+25urClZMQNn+S924LZP7Ig8?=
 =?us-ascii?Q?e396z8r+1IGCnK56f7/zNmrPYyXHCGBCIvEtYzHdAvIVUIo+LMEzZbiLukdh?=
 =?us-ascii?Q?06bNpivcKKVY7zYv3Lvb/fzqgmeIKSEV2jSi6n3OhVcNgkwix5gxj1/DZ4dW?=
 =?us-ascii?Q?T3DXpHj6F79n/T1BB3WkyK1vJ/UnUVgDJptjp8zsRy97aU9SfKjvGy02GqrD?=
 =?us-ascii?Q?pBAzcrcMvvKLRdglf5hSOplrRazelVRAFZaY/Y+s5lboC2I3aP3c6nsKyUIn?=
 =?us-ascii?Q?LfYpcsRAhjPgzaXFUworfyBAAwO0vOX1nDu8q8GTnwRQlR8dQFTcWckzf8Tl?=
 =?us-ascii?Q?6MnRktnh9OiM8qwgmIB3e9WSfNtq2d0G9udRRUHp+Eo6tugQGyyAWxcLVys7?=
 =?us-ascii?Q?4Jh1kBkmcfNWqqFsAaxTEvH1W4RVfJsND1fhJRYesWGLq5itmrefBhr3nCOz?=
 =?us-ascii?Q?2VjLqqi1R7Rf32l60A1FoO8mZBydH0qYNPQxo2fGqsLrwes7NR/ShIUzn8tR?=
 =?us-ascii?Q?m82h0csbgj6/jFnHkvZ8Kvc7xWK9Ymx5pDpKWq0tpSo903WcGE93DlxH+eyQ?=
 =?us-ascii?Q?fZpUl2OYdBEXx5+EI7OoxKVjttSUJnlAOqGLxD6gAphWjWaKmTcWg2m1jkqr?=
 =?us-ascii?Q?X0h0yPjLHosEydc8MBR+60MA3Hr+OaZf5Y4mslqh6LbHZolCC3Lt2P9uk+AN?=
 =?us-ascii?Q?poYT7mBURr0ENFINQEGp0V0z5eWlaPVxU/N0nr7NvFEhvUvR4XGaSgJJl5NK?=
 =?us-ascii?Q?r6+BevuSATByAK/SPtjc1pVyh+X8fEbnHW2rvBXgihWYFGLdGcWse/u+cKZq?=
 =?us-ascii?Q?+Fu2DJ/LKBXyy3FKYxGdYx3kWqaj3xn5tqZZrbbs6MY2GkbaMjPQi9pZHtG7?=
 =?us-ascii?Q?hlIYQa++8hkg4WDMJ4dJMWE+ANd+33Lba+bMOWsrxiF32qpSIUV8xAnsNhvb?=
 =?us-ascii?Q?FCckbvTrUiwnFHz5qE+eotCHX5BLsVA+gvilExuKUUEgPGb/PBvj6hSWGAQg?=
 =?us-ascii?Q?opLOVOWuaZkPK3GDuz6qXf7UpAOPEZe0kwuGslL9//s0WCTlt6uspU3E3TVc?=
 =?us-ascii?Q?IGT/hDHsBDlmORtLIzlOTzI2Hgephp7zpkOxF7Vqgyx3XYuY5NfwyvZo4Alv?=
 =?us-ascii?Q?3G5YDUtpwQepNxePPYfdChz/yYeimX4NzM5Itu/dVaAzi7/voKyQ3BpzQD1A?=
 =?us-ascii?Q?cZ+cItRdX24WWmUsDOckkg6MIU/XK0lJDhe4/YwWvl1IGu8dm5ds3pTb/e5L?=
 =?us-ascii?Q?dV1a1RQz2ebIQlpr2p4QKlQFz0x8EQFLFU9TNDYI4ZMpzzt67Pme2XedNktw?=
 =?us-ascii?Q?7Nr+QouVDv2lap/G6zqtuTilrh4fHZrYhfzTu0wXfVvVmiG3Ccz0BXKa4Zvd?=
 =?us-ascii?Q?PkM9QoNJO2LYJicXzQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d041b9-8fc7-4608-633a-08ddade56338
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 21:24:47.9977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KesMSJylG9e7wryHdNmPK+5btMHZcFuF0SaHKMKbl6IpuZgr0xxZF9hiBJpRfQL9FKPCPWKL05kOzqVrIucMwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5261
X-Proofpoint-ORIG-GUID: 1ShKpteTnojcO6Zfqd18izfcATyO0s38
X-Authority-Analysis: v=2.4 cv=H6Lbw/Yi c=1 sm=1 tr=0 ts=6851dd25 cx=c_pps
 a=bdmctD06Qnb36+NfE8b1Jw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=5e4nMFGB6dc_RNdO9JQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE3MiBTYWx0ZWRfX1EhTnjjFVIcc
 4JMa9tFIdCB0kY3P9U+SyLVlFbOHBkwnZvWSAH779trc9xk4n646tGaZwt1I5LmshNVUFZ1KjYa
 h/n7tCkNCedc49uku8KmqfQE1z38jr0zrp+HVvOUHp3RazVReqM+O9ccoRVm6QZZGcYMHAP1xAm
 GWsaYefit4jib3xAUm57+pKFa9fo1jE/KrCU4j3syj+BS9aJzi3I3KqUsgHCAT0c6tVlPnIKmVa
 rIhj8s/avRcqtFzyI+QomR2tmcVfK6D3yqftikyzkURyBLC2ba7eTqdIeQWmozPwy3p2hwiUo+H
 M266l2BtvPtOMtv3uvqjg0+0WOJxoCAS7gUoEgpIADJWnsdD1BY+6jUACOJwjy4uKqVWO2pF4YU
 u6MOD2oN3QBvzTylAmaNx/5GOE8XMqFuv5fVQ34HpT10dE8JHd+iwVb/mGJFaFLZQ+a/AX1u
X-Proofpoint-GUID: 1ShKpteTnojcO6Zfqd18izfcATyO0s38
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
