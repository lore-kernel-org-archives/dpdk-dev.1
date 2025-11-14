Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA0CE8D4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93AB340E50;
	Fri, 14 Nov 2025 17:04:07 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 51DA240151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:04:05 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEFpa9M4174669; Fri, 14 Nov 2025 08:03:22 -0800
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020097.outbound.protection.outlook.com
 [52.101.193.97])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ae7ef010m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 08:03:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAoZhIquNLypMrJPPN4PDvMCh7l0g8eh0PlHwg+L5V4/IA0aZye6nPX+eMyBGf0hoXPIjQwoQBcbNurChSRflIIzS177hhtOzGKCmjt59hsJ8D999E8w/945cRktZofvLCqgdptnS0+c3t5Dw1xIiJtzPCQgwX82BjreGvx7Nig5Nn+WTU2I3ieB1BSO4S5iQSrst77qYocf2gdh6rjsqj9SeKT0KwOkAlIqSmxKlp6/nPHQP1887KMlkUcajNdaVAz5XnwNiHwsJRu53r/JRrPzi23H/bHkrFCDLVHLGMXLm8YhN7bTuEPFLtqFlmtTEclIJqjaQDsDg4hgSpnegQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOAPUORaeHV5jM0ihJfE7QV2QMDmArlo2LmuzZZ3W78=;
 b=ZF3CTmfewNEOd7XlkfQn5H+PN3N0FxgOyLcRGNts9uV2Se+xOVzJX48w0diM+gFX0p7kAsKgeG/uePZZFlM5o4gL6Uv3TK6I1fHSR/sjB4rYN8gIyzwPMPHNkSrPKwAE5CSAMdMZKp5Q+AJ2IjXxtbKRttEmYMUBVV76BWqxI6BiEQV/dfzlKzlFEH3jrC3+4jGRZ3uF+DPfcWNRZxlhOE8ohisar97ll9eMSWAFTdh5mAVCtonyBbRQlbxcvlhtLSLwwL2EotgjggzmFcnsnMzWT27qxGSzqBNNE0pkVAFEJtdM4sOlbAjk8HUhDaTC7Cw+nPP1xcDTyka/m2dd9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOAPUORaeHV5jM0ihJfE7QV2QMDmArlo2LmuzZZ3W78=;
 b=JaQceNoqy+fk3W1XRSbqa0X6NGLofH4AhFOureHkyYGCL0f3Av3VyDxQjZVblCAy8NoPhnSU4uqwFWDWkHkbngtmHzJmjG9zljCws0YwEgeFh1JOVM95tBlLvvte/qcI1I6oDek6U1CjasOMPr+uxxxjy6lGlmmC2YLjwHu88J8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4234.namprd18.prod.outlook.com (2603:10b6:408:118::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.18; Fri, 14 Nov 2025 16:03:02 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:03:02 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Radu Nicolau <radu.nicolau@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/ipsec-secgw: add support for SM4-CBC
 cipher and SM3-HMAC auth
Thread-Topic: [EXTERNAL] [PATCH] examples/ipsec-secgw: add support for SM4-CBC
 cipher and SM3-HMAC auth
Thread-Index: AQHcVQiMTTSi5DBvtUimEpSqPCRBx7TyVcqg
Date: Fri, 14 Nov 2025 16:03:02 +0000
Message-ID: <CO6PR18MB4484D5127AB2131E93F2C9B7D8CAA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251114014616.43476-1-sunyang.wu@jaguarmicro.com>
In-Reply-To: <20251114014616.43476-1-sunyang.wu@jaguarmicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4234:EE_
x-ms-office365-filtering-correlation-id: d11fff3b-f6e9-4547-c5cf-08de23974a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z1kwUWiCdCSq+pm2B43V/iCFCL1L+6JFr8ZWOpLj4eLlw0d0M5mjjtRY3vu7?=
 =?us-ascii?Q?nB5xLZt4ctgtCdrMaRV3PQakhmakMTNuNXRDP2+9uhcucGlcNWU3Ce7FLCxk?=
 =?us-ascii?Q?JBxMM7RwGJ5eD90yW3mx++HYb10wrZ3bW68XXR1j2oExfvftIYQ09FcRdkLf?=
 =?us-ascii?Q?NEFuafYj5X/bFz4c8LFt9c+DsbTUMeX0zHrk+GD4dM9kCjkZCYRqq7nCW7yi?=
 =?us-ascii?Q?Mw8rWgPTZs2aLRrZzUlCPbuNUTfI86wuA/dQ0R/OVk1Lk5DEsfL+4kmCPDin?=
 =?us-ascii?Q?DLC83o5i6iZutZgdLLVcGE6hSrU2f4n09hc5OiyzYrvIrW5ZFe4G35tSBAiQ?=
 =?us-ascii?Q?k+zEjTwBDcmWpnXlweHm5X3/EZ7s806FRs+PJC/tUZVjcS5lhysudTleHhR3?=
 =?us-ascii?Q?sKUKYtG33XMJLlA2jOMmi3au9vnhV3E6btp8LoCcY12aM6H3LveNL+z5iZ9B?=
 =?us-ascii?Q?SSFUrF2/YTqU6ynaYiYa5ei+ePjk+CVDoRwr2lTXFk3BQnGUK0kMQ8dme7A5?=
 =?us-ascii?Q?t+ExYjozeY1W0ggvDnjL3SXqNnWudox+N3srIz7+gWwx3aF5C5KFUQZVYPfb?=
 =?us-ascii?Q?C83gJ7Z9AW1CgIP4sovxBnpxXUr9i2CXXeTh0ktPpe8rGjw8l6Ohj2N2AbzN?=
 =?us-ascii?Q?w+rthWpYnyQAcHm8mkkvHVIP247VZcAWKiaNIuQoU6UkryWXCPxtW7+/l22b?=
 =?us-ascii?Q?ZH+M6UhwAoBgH8gbDgkdNQ/dkqbVMcyfDLp6q1cMjC5fSoFA5j8ZY6P22tyo?=
 =?us-ascii?Q?bU873GvFPDIQBGiYuu9VwadQnMFqP3EYDeMsVP6mfeXzZdso/So2aq5uVMr7?=
 =?us-ascii?Q?cnUgtC7LDaS/yG83IU/NRSd89qcI2rn8mOYCKAhxdF3mI2sYPc/voyKOM/3k?=
 =?us-ascii?Q?2xLe2Rn8zm5OxgDnqHjiKaLy9kl+qt3+0yfVvVrFurts5WiPt/9ExjPQP3qm?=
 =?us-ascii?Q?H5a6lGJiznCQILUbOAAhwHV+7EQrUQ1pguGekmxF4XLWyE0NeclWWhQG6Ok9?=
 =?us-ascii?Q?iTjbjdBCCvUvfa66Vp80ttShXc1C9jQAna7fulSVepVJp/1mPN6uWR8DCE7j?=
 =?us-ascii?Q?aCL0yHVUCI6q8Pwirb+vcaLn8vzMGovUcpLVLkBf7735dha7+YhgFlQodmsV?=
 =?us-ascii?Q?HZI9lAHW1MjaxWMBpS6jXmOiJjC02zYd7e+o5j2/kjq+Epau4jwsRU6BSzB9?=
 =?us-ascii?Q?f65Ld7otkLjFMpYwVm2LR1Z7TR9FzHa6JwtdC9AOL7aHS75QyQv0LrOx0C0S?=
 =?us-ascii?Q?JGd2wX8rftSSvCR0rTWi3b4KJ4lUBAyvpaOjBx9aLaHjnIfgG7N5i1ZkG1A/?=
 =?us-ascii?Q?IYk/Gk76V9c78siTIeTuJPFQ9MNQahpgmntzfkiBQxJNXi5OACXntgf00wkj?=
 =?us-ascii?Q?ghfvW9OTdhsn7Kcx5OqQ6g4lMuRlc5kGG2sQ0xnXm9hTUTtEEUx37GKYJW32?=
 =?us-ascii?Q?k7p31V9+mg3ca6W+UUFkpUBR9aTIQOybA6mCJXcUcikHkZ8tckUpV7oorXMu?=
 =?us-ascii?Q?9FLOb2CAOgi5YRwwVjXSkncvB7sMrYbJVJjL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pl9KBYEZ/vsa59I46zHFpJYt7y9gSe1BGZ4lINGhFD6hdIZNjRbO9/xje01e?=
 =?us-ascii?Q?sSWK4wBpDUbrz0nZXkKtKkbRGXiAbfldAXHWvA8p3LzFziIjy/kYa5EPiOGY?=
 =?us-ascii?Q?lcWtpJ5ITsfU1hphzJRj3HWLUBtYTfpDzixZ3ZtI5WeVSYlMbaQliTOhS9XD?=
 =?us-ascii?Q?0MJSeqSf8UjpM1Hmh+RG3tsgK4BFI9iExpm2UMhitEeoMh9fpXaO0wnKxwIi?=
 =?us-ascii?Q?4od+bQEg4SP6Y/kG7s5i+SHSit46iJNe2kAK5j3NNyAEStXqnO6cQMYsvUXQ?=
 =?us-ascii?Q?ZCgz0TNenEOABcbubYKc742WZsKtUal2nfCbf4UdFP7blBqpDlOYlCuZnFFP?=
 =?us-ascii?Q?xW7J3GvqjuHxBuv2RnatDKtE++e7TnhEXphzEpbouUvo4bkqZQ5i2mYIvLSD?=
 =?us-ascii?Q?C+OyOHFxWWWZgSupdnwfkuqNBqxL3DVYVfofNTaedmzS45/FPgKM+9yGoxHE?=
 =?us-ascii?Q?dExSNPa54EcC82Bj6nl0c7uXz+kDHawde6ap88WSGYrQdWk6BuYhFqKcJQ/U?=
 =?us-ascii?Q?Zp8eObr8bvP9sa8oWJF0TCK0Blh1LnkiClH0aNDnqxTptMXEAX3alZLpkL9u?=
 =?us-ascii?Q?ECLbqtHy2BvTFSa2FyX0H8e5K/Iyi8hWhHHk9dYjDHvIoNRXBHrK2jrGFTcf?=
 =?us-ascii?Q?oULD8lgBQ45s1+82/PS53ypLpfsrMjxCB9mjhkPOpI2OX0G5g96LFqeQU/WS?=
 =?us-ascii?Q?bDzZNrfvO9gsKkQ8sTKZy/pv01KtRmjUOSC2X3owGbEXwlCMevO/whW1u9uJ?=
 =?us-ascii?Q?91L3rT6CFq8TG5WZplTqxHGtpa9UrOyLK5j4DE14mBiVHTCdja5ou50jwfzd?=
 =?us-ascii?Q?TzgcHIA/8nUT7p58gM1xFmbOOWPyetWQuaZaEnklNKHXN6025k0CxTuJ63dR?=
 =?us-ascii?Q?kgjYG3fFcCWdNDaeqY3+mQMFE0OyAGCZM6OBzZJ7kgpV4nMBr6VS+gL8dv0b?=
 =?us-ascii?Q?FrngmbWoshF55ClW3yqvEFuAIEL1hHeAuYEOPCUHipnJCoFhwf4GwX3Jg9UM?=
 =?us-ascii?Q?d637zTdNiDoTKyUgtqxU6Io+Ns24gi8gI35cEUIyCeDMGUyn56+3rGIQ4FUO?=
 =?us-ascii?Q?rFDGhI3gRr0eYi3j1WSBjn8AjVpu6plOYzBJ9zXr0EzLbPh1FReeqaKLa058?=
 =?us-ascii?Q?x6NbI/0PHjShc26pOZqLaXfeH/feTPeKugdof8DMeE/+0OsYaHOuai5XK5Wi?=
 =?us-ascii?Q?EsJy9KvODHyYd2W1RGZ8eBqRgomlMdQ8epfJSCHo7pJdTvd3ycTFjEGW0Oih?=
 =?us-ascii?Q?s3+/Y6yU5X3IgYeVESuUrr9UqA2IfhpNR+3k4IvN5b1PF/729QWHLXAaAjCt?=
 =?us-ascii?Q?jTjM5XLtuBZq+EpayJMM2m4ircD5ort1pmATo7vTrsRKa2Cx0LgrJMaz6gUk?=
 =?us-ascii?Q?CAQMM2TsX3HiHT8yiIrqU+xbxPru4n4Z00+TVj5rNdlfhKQ2RGZKMI/OadDy?=
 =?us-ascii?Q?OajZeFL9/Fzcs0f4h5oOWkbg3j7xTCwEg8cpjOECXj2H9bWITt5tf9QMNM0Q?=
 =?us-ascii?Q?A9lDXshChiLlRlgCXUAUxrjenK/wzy0Eo7RKKdgwc8WcHyaDLrojCFHyApk0?=
 =?us-ascii?Q?krVzZetqApAa7IJpamU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11fff3b-f6e9-4547-c5cf-08de23974a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 16:03:02.5030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQIMb81A206kM93QflloLkpdobkHFX0os8HUMKTnN9SV0b6MXkEkhgbmlyCZTlnRdyz8d6dWfhSjmoHSDA/HQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4234
X-Proofpoint-GUID: iq0M_cRBAbHpQZmjrdJiTgjzr9FthFI9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEyOSBTYWx0ZWRfXxNJiDKOedIeE
 FrvTbOIUDi7g+y60aeQKc577iud0GC3YbbixgsrEv9m7UexuOGXSTi5P3oGTFcRJ1l4SSt9m43Y
 kQyfGvfvvXhym5LWk4GHwWxstzZhvBGZVg0OKDRiEZoVl2tMikncpQv2nDveOnjlMgrsIawTzBF
 r/GttOJLrcYk/fpH6CgsvtZw5l1G6X7EQOXnEoBZE88bNDwrQJKsg7K8l3Ef/kDDgHps2zGkgMv
 NT75lD94nUUgZwTKG7rHqTj0yV9a9VR9V0zOr2Sm1KyZ5w3dRhyjVz4YLRAPiwz4q4AmDlymgWh
 GiG+Bcrg4qCU3HUR5BnjhHTGrQboWR8wHb8xky4Zxte8Y4qgba+D4Fcaw+qFQ4AaTVFJ25Kyq8a
 yUt2EFL5pt6v5OVl7Xls8uyPKYe1+Q==
X-Authority-Analysis: v=2.4 cv=Y+r1cxeN c=1 sm=1 tr=0 ts=691752ca cx=c_pps
 a=WuGjf4t6T1Q5vm5Y5Z/RWw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yacp4PbrAAAA:8 a=BnmJLl7sSi1832rNgb8A:9 a=CjuIK1q_8ugA:10 a=ZXulRonScM0A:10
 a=V3FWeFeR7HlZ9tVNOp1k:22
X-Proofpoint-ORIG-GUID: iq0M_cRBAbHpQZmjrdJiTgjzr9FthFI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
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

> This patch adds support for Chinese cryptographic algorithms in the
> IPsec security gateway example application:
>=20
> 1 Add SM4-CBC cipher algorithm support with 16-byte IV and key;
> 2 Add SM3-HMAC authentication algorithm support with 20-byte key;
> 3 Update SA configuration parsing to recognize "sm4-cbc" and "sm3-hmac"
> keywords;
> 4 Implement proper IV handling and authentication offset/length
> configuration.
>=20
> These additions enable the IPsec security gateway to use Chinese
> national cryptographic standards for secure communications.
>=20
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  examples/ipsec-secgw/esp.c |  5 +++++
>  examples/ipsec-secgw/sa.c  | 17 ++++++++++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
please update documentation also
doc/guides/sample_app_ug/ipsec_secgw.rst

