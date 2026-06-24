Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F5CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 19:39:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66EEA402C6;
	Wed, 24 Jun 2026 21:39:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6A0FF4027C
 for <dev@dpdk.org>; Wed, 24 Jun 2026 21:39:20 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OEgg1w4100570; Wed, 24 Jun 2026 12:39:19 -0700
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020077.outbound.protection.outlook.com [52.101.46.77])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eyqqhx57q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 12:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsz/mjheHLIwQLlbieZE4psCp8OduDMEPPKlEExOmqAdQKeYOoRDcfHWJixph4EPcmWg7aBRp/sNuiyxImidJacpIyFcoG7hV6ybE5Rh7/I3v02wTRDTtw+l9CP65rq6ZmIRUhs9hIFDf/XtWVf/pg0nZagqzmIOaFPuuPV+uiGXYjjicxcdRVKUpZXBhAywf7NljzguizZOgp2ZMjN+qKI+EomFGNtKc6DD28zS86C9o2pRWdnGZm8Gxvrihq2PlUHcdTL/p+xucZuRGm4EnRFS+NWr3LTcV1saRnBLJEhPgnsjKQIi7gIe9oAmcX4qxynrXxKbWAcDJnZQTLm/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqUBPXwUq+dG9dt3otKJkE8KL2Fg6v00aDTfHM1aBJM=;
 b=FpWs55IuovjN/36MIebofj04Lza9OP/wHPIQ7FZThKi3F6LfwuJDzS3fJ1RVFYaf/u5TWYRBBgVyQizhGIBPzLf9g7XVQdcwvzCglxsQ+CDWsMpMTraFNWEv2rO2K/ngswPdv43MK8DfkM9e02W5LOeUGhdC8pJe9xiedI0n4bgTJ6sD0EiQABLntHNIIAzP0tCu0pZs99E2jRHhrAiMjpdMIr1T1nbyISrPXvHt/Z7xCJAol5jQHL25Su3A78OyRmwCNgslyn+mToFbPYBrxql9mB6QxErz6HH8vMux1XTWaUg0mpUgfQEq4ZBYgyQkQzs/KagIW5+FlDpYF3x+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqUBPXwUq+dG9dt3otKJkE8KL2Fg6v00aDTfHM1aBJM=;
 b=CbW+eqovlAdjicBpA9EM0EAlABQJJzDtnELXrErjYQ0am4BS79vT/Xj2DZHAU1zxhC7xpfg0rnDzEpEJsNvT3Mg3ZdxWlKd/pCVDrW5dPMh058nvFKLoswoLSDtfdzAJNYuIDxzGbVPLR59RHg5TPsNGJVEvn4jPlzcKcdSaADY=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM8PR18MB4519.namprd18.prod.outlook.com (2603:10b6:8:24::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Wed, 24 Jun 2026 19:39:13 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 19:39:12 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "kai.ji@intel.com" <kai.ji@intel.com>
Subject: RE: [PATCH v3 1/2] app/crypto-perf: support ML KEM
Thread-Topic: [PATCH v3 1/2] app/crypto-perf: support ML KEM
Thread-Index: AQHdA6d/IheR0wmjs060Max5zWZNG7ZOGlJw
Date: Wed, 24 Jun 2026 19:39:12 +0000
Message-ID: <CO6PR18MB448437DFCC7394A05B146B9AD8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260609055315.1539233-1-psenapati@marvell.com>
 <20260624070250.1509369-1-psenapati@marvell.com>
In-Reply-To: <20260624070250.1509369-1-psenapati@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM8PR18MB4519:EE_
x-ms-office365-filtering-correlation-id: b88264b2-8422-4eec-2ff3-08ded228449e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: eJjDUxUFEC8+nFXTNueMxwMlIsnLprvfqzcCmEehKke6R2B8lz7dQVxUi16AvgJiHNqeFjCvFo8wiHrmoPgzGueb5uwrUBj8fJdMsekJvtM3bYXvfdWPwIrt81OWc+F7e0mwIZKiK5Q1ztugexuKotNvcXamchlbj66dCNCDIK0dguLKBsGw+/3Ul2fZbOpMaEHR1NDbEsEMEGenqpFu59LfFe3cGm7hh7d6ycOFPYN/8tqBbOR1RwgiISRB+mGXaZ+MXEpv/YU10XLeYrGDlEXt0RFeGPesdQyr4PG6R6OWlm7EbET/c/CjfmTiy69YxtjFCIpPCsHDxkYHIt7LUTzD0aTz+/swOVT5ta55kJE6cd9Uxtn73hkldHPuCW48K881qDzO/fAw9MryK++/6KYQ3/22zXYpytksG2pOxsxJGo8wgnMbRyTXXq1t1Pz88tPRffe0iKQtynpSF71NCInZT5foaf1R0CnIoVQVgD5b1QPTRYLs4ntzLCJxrkgV8ukWcERJz6/803yWFSLm89yWBLI6Bo6ISe1uavvyecn3/gxCyaQQoXkzkdKoViYsJv1Udv1y7b4YLOEj7kvZMVFm5bDhXJ+lgJe5NtpqjQsYQqoFk60df7+Z8OtpQ5xsR0kh19wUjJ1Ile+Duslx+xA94JUpPtEPK/fi37OKO6x06JpsxrZkx66qaZPsJAUiGevFH1kYkdy1UJhw3RNS8eWC3vuS5YM3wbUfQdlWfC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GbA0s0ZYyJuZYRnvj2Ig/SeHtkpuV3NM5zNvzwoORca7hf6fY1iVOYbTk/vw?=
 =?us-ascii?Q?2gXcA8EyCP1LwyZ//d4chkrAFkuOwIRbgLmfre3OVcGjOfl/4IzjnaVGGWZ7?=
 =?us-ascii?Q?rzC9avWX63zTBAGKt7Hq9TsYQUcCgM6QGuqOewywD5LTh/mY0T5GFDjma40/?=
 =?us-ascii?Q?R3HRm1C5vRNfXYq3Ccar01V9Ynfg7wvdevvwtjpMDslCoZhtTM0NFDWUrUQK?=
 =?us-ascii?Q?ZPvbc2a6W85vSdto/+rRh7LHhGVvmQ9md3MRU7dBloZQZuLgIE/DB6aeke0V?=
 =?us-ascii?Q?cAUgz18PH0H66dbpSYke5oVatnTWz7VoAgTaylb+jKVeHVg7MfKMbijFaKAU?=
 =?us-ascii?Q?GObVNwe+UrsHOHtgU6l56h4kgifHk0rnIas7HD2wbuApHbXVuFu8VQdBpvsh?=
 =?us-ascii?Q?JcfeZkx+MgfsHhVLRIsv/RQ2ySKUjhI71OtHJmGtgcDaRkovZ+q/3Ltc6Y1i?=
 =?us-ascii?Q?/T4UoKtcy+zlYI6W4Qe0DJuoaXS8Oz96QppZ/RF2b9EETEmrVebamNuENFU5?=
 =?us-ascii?Q?2B+GUsOD4KUucW183BKMaF9ZtLAIziWh9X2Zlmr6jq3LfERweXsoKZmhPvF6?=
 =?us-ascii?Q?zApwNOkvUZ/iOmZjfJgTxVughKWrvw2N9pkeaALeEg8RaScvwLmyBxETqJB1?=
 =?us-ascii?Q?UMbsw1O5L1VJRou3y9O/Gv17dDkaNoKldd37INLBUbPavgOx4upTK1HbZiWm?=
 =?us-ascii?Q?wsdL1dSWY5//jVhEVZctKooSrCTtZllrrikF+N00KfA5r1yKzNHPIMGSarJl?=
 =?us-ascii?Q?qH+eAYsHZt76O0UCP+DxHDCyzxnW/4ApOEj5dbuPtYP4RbzKT8t8z+KGWqcb?=
 =?us-ascii?Q?R7XGlPbbKOD5R+duBaQvm9zBbXRUreGnayP58cov1wWXoQZSugoJoDRrZ6hR?=
 =?us-ascii?Q?cc+GcEjcIIKUSYULfavjsYTal7Rr2tIrMxwDuefi9Ksaoh4JkLKuQnK0bRhm?=
 =?us-ascii?Q?fYOKkaiNYiCaaPjDsgBhyTQkQBX9b/Hfv6dKT8IRBPo1vbRKUGPf3Hmdbgns?=
 =?us-ascii?Q?JFB5REDaWVO9CE4W/ZBLVowKKmKwC/rcbEJLzpUnLGPUYGcYBUv4ugnWRQfi?=
 =?us-ascii?Q?+3OQNAC9lt9vdKhlFlX3fK4XsTjn5JFuqIJy9hUeBN3dbVVWfvBW+C/4+Zip?=
 =?us-ascii?Q?sGdGgW7Lb+kkHatcz0i4MBMKZRlL6JtIYzsoqVXZ8m+n7/iPZ4sPQTS4pNJa?=
 =?us-ascii?Q?vpKI5RDOanMqljMkD8Wde7KLgskmfRJNthHRLuxJucFMRnvK4K/8YhWAc5Op?=
 =?us-ascii?Q?Ix1bibHZ2veqIrZmys9/jhwTrkO+h/LKAnGxIUFQsRTgePsp3BNTEx0PMnDY?=
 =?us-ascii?Q?PfCJ5N2NTUj1p2qDt56k15cizdmi478m3G82yuiU2vMgNQn+biOkUAIFTMQ3?=
 =?us-ascii?Q?G8CgP+ujCt+OYMSq+hnm6ABWR6hnzMmOiCfXvzAG0gvfPOkkWtPZKvtKLm/i?=
 =?us-ascii?Q?0bEVRtXq0mNrK8Uc5uThk3KkQyb67wGzi0hoUfe0kBhPFpems7SUAbQL2Dl/?=
 =?us-ascii?Q?gugW+fAKwau7ZWqubDBmFW5ER9FDAyCLC2UuNfs6A9GLKGPC+iBR0uqmvC1r?=
 =?us-ascii?Q?mtsWTaEHs9N9P1ajbyHETaqhyI0XpNK3n/GYMj+KF6V8VNSg8L3hkw1LfHpG?=
 =?us-ascii?Q?/Zd3b8aHpEq3N6Od3YOXWJ7yaTEOtnYNd8a4H8qCF/D4iBKcp+ZRdKd834pQ?=
 =?us-ascii?Q?IbByPLpLVI1nsE8B1KfphGg9MqqbR40ePKG/E3S6XGME7j4T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rDQBYrAXYBWlSwP0mfT1LA7keT4kXDJStvkk3UUclXke4/FHIR8phDksiRQuOpS3SFRHAxq0ynn9Sf/kZ+bxzcZjFSEaTlLoPTxuT7stgkEp7FDBBkD7Wxzn2OsCp1jzXmKeMG3UorPyDFjObI4PO58AcoNgaDjE8gITukl0yqR6Qnp6TRznXXvTwZO4NzdMHUNrHU7TsZKoI33o1g+n45nzaOruY2YopZmy3ZajZi813XYu/QeBTnJuwQkFgumMahQu59rNPrCaED2h8lTdLtqaQMWtf5vppNggLaYSGWAsMj1ys/YMZScDNuGRHDFduvZyUMHQJd97ztfRMKGxZg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88264b2-8422-4eec-2ff3-08ded228449e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 19:39:12.4768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRlJgBAJRWuHddsw0TsdWLNDWWmMTR2oBF4I+lX0ZGunHXpmAxqmlurlRHowrwsR0NxTKLbsLIQL3c6XhXPXLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4519
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a3c3265 cx=c_pps
 a=DYlabceQTmKUulxxkwl8KA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=F1w4ETC2J8H0KujVOBwA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 1Lf-0lz87qu1n6dFvnOvpNVkt1Nld8e_
X-Proofpoint-ORIG-GUID: 1Lf-0lz87qu1n6dFvnOvpNVkt1Nld8e_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NCBTYWx0ZWRfX1t9owSBRvNIu
 NufvsAJ6zPpFERophkbl9PJOX3gd3ruNRx3UShHINWTdD2cLo8ZJtjkeeuCce4RnrIUOgwm6/qG
 X8dvH6BS/m712eEhRpOUfVOV6GFn5f4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NCBTYWx0ZWRfX/+AcT+Rwj0/f
 1fJopu/G+Na7A9BmavBmVA854jwBz9Xhbf3o3CNHzQGcLvEii3VZoo7u4jo3oj/bao7979yB0Ny
 zB4hregVdMQQKI+YJHaXEltzLv/kF6qUroMY+OtB2a1SMgKEK6MwBjRLA5BhjDsavZMO6Ah3LZB
 VD89ym9nce1u7sk9laLhthQ86wQAStJOB6S1RvLwuEGR2CMZC7vWlkNdeZfNVs205wcPHWh2QKl
 xIPrAZy60M3oPUHoLThL0+qIv7QoLY1XHfGvqgPz1G/rMy5zS3UkG6dEW3lKr2ZRUKJQ0oyBA9a
 EeqYtTXOTG18Bhr6UBMPDW9dd0ROC33b0zNdu89cD/jIK9nwwhWH/QbX2+4uyd0z1I8Ci35cGnS
 FThrUObQGQodVwQ2MRlHvZnh8j1MyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
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

> Subject: [PATCH v3 1/2] app/crypto-perf: support ML KEM
>=20
> Add ML-KEM512 support to test-crypto-perf.
>=20
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>
> ---
>  app/test-crypto-perf/cperf_ops.c             |  61 +++
>  app/test-crypto-perf/cperf_options.h         |   2 +
>  app/test-crypto-perf/cperf_options_parsing.c |  20 +
>  app/test-crypto-perf/cperf_test_common.c     |   3 +-
>  app/test-crypto-perf/cperf_test_vectors.c    | 470 +++++++++++++++++++
>  app/test-crypto-perf/cperf_test_vectors.h    |  27 ++
>  app/test-crypto-perf/main.c                  |  21 +-
>  doc/guides/tools/cryptoperf.rst              |   1 +
>  8 files changed, 603 insertions(+), 2 deletions(-)

Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto

