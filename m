Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29297CD98E4
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 19:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE4C6402B3;
	Sat, 20 Jun 2026 21:21:13 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3D76240151;
 Sat, 20 Jun 2026 21:21:12 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KIqkqE1218452; Sat, 20 Jun 2026 12:21:11 -0700
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022103.outbound.protection.outlook.com [40.107.209.103])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4evtcb5vmr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 12:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufsOQdhu1+10Ui07+aTczQudXfhoZkbGzC1WBjz08zADlVmPHwGmtlyiZ+nJXFSF0yHpKVo453tdJGh1WJk+EGEc2c9PxuE7pG1ktV1n+DmVzbdq/ydONecjdf0X/SWi3l2xWszyqrLFxS5goww/CnhVDhm2gXSlxxEA9oxkeFn4OvZ3M/DFlOtS6yDJr+fMrbshn6Grl0abKi6mKSyLxkWOCk+eyKA0FIULtVlWZkmbIqn3/IfTi5G9wztShUHWGp4TsJf/ekvPON8KaF8Q/YB/myLFvGRG20speTO65+jBV/OJAvE3NLnHqw6LURye3vrNZt0TikarKL2XjOMQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzELOBjx/Ej9zi5bXXETki710B7NTWA6TFlnfYtG4No=;
 b=gTXWZxiAbzZC8U529S2+xfjWSCQ4cHoPVEr7MFbeJ964hdkn7XC/OhxM0kiD40V5jeKlLgR3DQMtSuW5PKls6PU2viTLmYyquzyLaQNC03mBXTXccn8opOXUc7qPSJnelJctOTU2BG4Qcj+vwqSjonvQwEuC2hJJxb+r1boHSgaCOJr1I3QIR4ujAvgwSkMb/2mU0OgTEqkdhZUKTfmWdYb+Nl7KBLLTMkK2nMMH8LjU2psgp21UNRBfHvOdZ1I4v8NwsQctiRmq7PoWfhWry51mtCqjGA5Q9WeYmnz0rXgSSW+hWli1JqUVgjR5KzSjPgaPT0s9QnUjSmQklhtUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzELOBjx/Ej9zi5bXXETki710B7NTWA6TFlnfYtG4No=;
 b=CzDclhnlcmZYc64OHqNeUfH8O2LRNji78RzxdBMNrLRGChjBxbRzMkrkyKy98cMkmu3BGFRxegLKRbw967etYH/XI/6olH+3q1L5FaOSh8dG/5XkypVJsV87g2v09CPvXUXanrowDHS3aJI7LbN/CMAzlI49J9eeb+xLc8GAVFY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3641.namprd18.prod.outlook.com (2603:10b6:303:2e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 19:21:09 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 19:21:09 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] crypto/openssl: fix use-after-free bug and cleanup
Thread-Topic: [PATCH v2] crypto/openssl: fix use-after-free bug and cleanup
Thread-Index: AQHc99RAISVj2vu/K0+uh1TAaW+EebZH5Beg
Date: Sat, 20 Jun 2026 19:21:09 +0000
Message-ID: <CO6PR18MB4484174ED7A1ACD0781C3FEAD8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260609055302.1539202-1-psenapati@marvell.com>
In-Reply-To: <20260609055302.1539202-1-psenapati@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3641:EE_
x-ms-office365-filtering-correlation-id: 666231d4-1b28-46d4-daf8-08decf01155a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|3023799007|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: /2V6+WzkCT5972FeI+FyKO69fnuXj9D1lMEnh1Kkl3kak8Y+WCNif+1pqehye3yOnuPoYD8XCYFvR3zLxZYLUMffLoVvJ9Slqdnse7aRu/xU7zzLoQpkPbkYTusftc+CEL8AdAG5yNEyAl/jbnFkiPeC1Y8xzPZo0440hPvI+tUNE30Xe1R6MXU4wWEQVQs6FyLirqA5D0VFzbPVX3f8WO7HSuLoaONqNUA99VTim6BCmUrGxYbvqkle5Er5OzipoI+WBBpuo2hmCT/Yw+Y717EwCNm+j6iXmTomS7IlwrUkybFoMNXujAQsCKA1zgPvUj/PCwBm/4ULNNHWFE6EdvUUw9WkOQrViU5lYAmSQwp/XxieTY42wRyI4ZwwNHNvKHB3pxRiFW4KwnN9XOa0br6slXRKjNyLq2z5Wfnyrc6NOKCc0Qpd6F1R7FGpTUTtkv3XOL5hoaupBzlb393AarVEgYstOOCX5Lqh2bPOFyzEz9s0rmUAH4vfwAnNx5zLHb4ZUusZvQED6Y6GKOZabutblM8hFueN4iyuzOqcBya1Wtjvj2gKyuA0Aoi/0xxRA5+IxG32MXnROwLewPV10hg+cyJdggzSTM583+XsbEiswNYH0ApZEsTzsXBYiLSKVzBHzKDUFZw2IlixHG+s9GwHmhXCOgu8ZQxHfYLhv8necsTgMJ9r3y7t355JT3flqQN4nsPiEmWazEAC9qnFJAq41TANAXG5cl+zj3aAP5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(3023799007)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A99SozkOl+a979X9Cz/lwIBoube5CJIfWQSw30ao+Kxc1aM4W6ORdHDyeyom?=
 =?us-ascii?Q?8DaBK2ztueovecA4WCS2FyJ3DaMv/YszDDS8PvMLT6KZPu4aYHf6uMw9OlAg?=
 =?us-ascii?Q?Wq1kWIbLAlbAPtkVqo3hGtixkRJtoXKUSlHBi+qg4MnGGg5DyWChsSl8XgxX?=
 =?us-ascii?Q?2+KY7QNQfwQGpa6+wGxvrKpmuw6bk5GhLbSVV17Tp8ssb+cVOzUOVgv17T6v?=
 =?us-ascii?Q?6/1MVpvKjJzxMgI3lU2R+syPX2ZPIXELG/zig641Mt6zWi199CQkYuiQmiuF?=
 =?us-ascii?Q?BegZahO3UYjPmaYmStwA0HKYcx1XgeoP0dMbLp3At8JkSMZxEoi872N/KKRO?=
 =?us-ascii?Q?FWXuWq9oFCfMvJX0bv2vezETfYONcj5Ofik+i4DqN0/HKl6vFNjzSIv0BSkT?=
 =?us-ascii?Q?0zY0RV0y1qOiRKBW2T3at4cKAQtyXZNAT83VqM8LBtp5GI4cHVXYq5qbymKP?=
 =?us-ascii?Q?T5V5X//qaSLXj6APFCwlxw4QrV83LANMvtQL8lrtfZXy+C46+/yqL1yIVN/K?=
 =?us-ascii?Q?p+w1T0aAA6OQRm0L/Nl/DJ7SAEboQf8S7kOKKgCCYWssOD0AMN3kdtLKnJXa?=
 =?us-ascii?Q?Ezsiihi1mKJQK+QGf8aQc5kxWa5zb+HadZjo0caA5Wxmk1fN9M/Fz1tpxi7e?=
 =?us-ascii?Q?SXpL9hKye+L+7r2R1bvyve1IYfSuBrxg+zZLC9Uo3V83rdV++7LocsgQskGb?=
 =?us-ascii?Q?BdNFsPcnlwL30rDMEISbw3WTj2v66pHmE/TmDtZ21TgeCsLSDTTMwr+Xku7o?=
 =?us-ascii?Q?1+0nWihN9MqKTOMc2x6qIA+xgbQDq1MCrBIEFCKMac3neRYhwXD1uEnRW1XC?=
 =?us-ascii?Q?UyrwwinnWDPFLISVpYwqolgECZ+hF4DO55YNtwRGv+z0Z/u1dMz4kal32nNb?=
 =?us-ascii?Q?/E/aKtGrAqj7x1uggIgelz2wDIC7tOfk12oIphuo9MbEDMa4snmNOsknI8++?=
 =?us-ascii?Q?q2dXHSzvIvUWTYZbrNH8EukDkLxUVuBO45F/H4yuZ1FjMAlKGtSX/9+7vOh1?=
 =?us-ascii?Q?TXRcKI3ZpCPWfCFCEoIhmUDJrv3FIow/eedKEjR5ywUqY8xBoqXbe7rTRYNd?=
 =?us-ascii?Q?h3gN98H27QcI8r9rQKdGOKEOsSVCT6zargk2V1JcjiYYsiAy9xgRAX03sR9G?=
 =?us-ascii?Q?p8rhTnLieVTu967pGCz8XP+YLVckpJt/1gU/MkWEChjvM8yxe9o6hAr63IdE?=
 =?us-ascii?Q?no2iLtRQr8Ol3qU25FIq8SgaqzmjneToxCyRvpTitL+WMcBtMZ77ZOJHthyF?=
 =?us-ascii?Q?B+e3AgiOhmWN6xWP729zfHXKvmyobOmXFYpSfPP3D3CFAiFZruwdhE0HrGzb?=
 =?us-ascii?Q?Mb5wb5eVWkxdqGL5wOsqF5DuR8kNDdPQWE8x7MBQuJGFCSxNh+d/wkffSaL+?=
 =?us-ascii?Q?nRyWVHGMhQDpkk2OYRX66Wqql1JX8+ratsLuVrYuHVlhnvTUTiwz2iXxAGwI?=
 =?us-ascii?Q?i+d6h73+Y1AYeetev6imVmSidUor6OWIY9i915r5nYlSRt6m66ogSmYGb42H?=
 =?us-ascii?Q?P1ZraamZCk5JG0PHdrueh9VDQ+FPRT0/h+rGG27Ya3N2jL5vTPhFiLTVBmeD?=
 =?us-ascii?Q?+tLCQwtPz+JpU1KyZCddeh9AiypXgMX4ENlB66TZL/XmKDFfn5/ZQG8wkOcD?=
 =?us-ascii?Q?CnhuytlmISJHIYNkqMMf8TLLBvgN67Rw/3W/0dnLIzwYVEWG89TCSzOAodlV?=
 =?us-ascii?Q?xNj6YtSWvY160+6iINTB5glmPXviAM1pQMkLgumvbBuC1F+5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jiRIPSWM0HET/oPw8zpODnlKy18XXqDcE0+Wy65owc/3/Amti+JaGrvw1tRdD8FHCipvFuNhIIwIRn1InISeqqbjkeSZnLgP86XoQiRGzgJ8VCnYeKllUUd+lS4zlhui1ZV9US3OQbDmmm5GxJD+sKcTF3iL8ElIVav9gi86tXr/eSAjMAdnfCak0SNkfvKVL+aUMdszv/vhb5rkFBdrPe6D96pVP6DSeD8wqQq8TbO68uQFBWBUkB9XiDeyCXrl4ZXCRIXUuQAiNpdmBz7xvJOmbw8YSR7yi/uzCw+ka2l8qOOF4QWW8plUJr3ul1MVzWRm4vNia7D6bIx4dJ702w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666231d4-1b28-46d4-daf8-08decf01155a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 19:21:09.3297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1ObtgHVupGH7eqcKzOy4K4If9TZFf7sKc7vc2ELjdfQWd4VuIPKeJAZejKkK/EG6LDHxp9WEAL/fQc9qAEsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3641
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE5NiBTYWx0ZWRfXzBM44VdVxOKE
 cwaQ/q1o5WxjrqKjX0ZBi1c1uIg9yqxjBvms+zEXwWtlVDEJ7PTsugaGtiekJnYpJ4ifGSGJz2S
 fLG+g5U0HkcObkl5uNLYBPsb4A2MxPs=
X-Proofpoint-GUID: pC3a_B_Sfia7-CoslsR1cHA2u5zrLn-t
X-Proofpoint-ORIG-GUID: pC3a_B_Sfia7-CoslsR1cHA2u5zrLn-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE5NiBTYWx0ZWRfX21cWsEM5Zbe6
 sCW/IpkUc60TvVD38BXMwMqNOh8bz7w2lxz/rhqEpuS/myDm5Z1sn/RXDOyAQc+cC3OzHf1bbJ1
 Sy6dVdnpCcPv6KxV8nbIP/UkMjmIFebo25nzRWWBz5QGor8K3IU1ohtcRy94iNyTBx1QkqO1cld
 TQBRkdLJXzWaZRsWJgQhemXl9eAH+RhOe11rT8mV31syppFBjenhdQ0JyjNK2wI+opX/TZzNPl0
 ytsgdkAdhDlZCx05+JqQoI4AMm4IbzPscnOM+aBaw5twpYGAFO5cVzlqoHnqgQvr4oc/a7VPACQ
 gZg4kf/aRw/Rkh3Oa3HkzIjJ9S8glv8I94dHffdv/YHP+w8oak3fflTU3SCBxkVH0keaVZmdj50
 slC0YfFrWyB0nsWI/7VYXYzqo7WAcNL7SOYVXICqXibe7S1xPK9GWZx2Qz/Wf8xxO/xLD8yS+Ls
 L8Dp4A8odnTClFKjFjg==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=6a36e827 cx=c_pps
 a=xj9m5St4rme5bLz9Jope3A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=44IVQw4YPgggvKaI_6EA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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
> From: Pratik Senapati <psenapati@marvell.com>
> Sent: Tuesday, June 9, 2026 11:23 AM
> To: dev@dpdk.org
> Cc: Akhil Goyal <gakhil@marvell.com>; kai.ji@intel.com; stable@dpdk.org
> Subject: [PATCH v2] crypto/openssl: fix use-after-free bug and cleanup
>=20
> params is freed before it is used by
> EVP_PKEY_decapsulate_init()
> causing a use-after-free issue.
>=20
> Pass NULL to EVP_PKEY_decapsulate_init()
> instead of params to avoid it.
>=20
> Add resource cleanup for all error paths in the
> ML-KEM decapsulate and encapsulate handlers.
>=20
> Consolidate cleanup into multiple goto labels;
> err_decap, err_pkey, err_params for decap and
> err_encap, err_pkey, err_params for encap.
>=20
> Fixes: 5f761d7b605e ("crypto/openssl: support ML-KEM and ML-DSA")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto
Thanks.
