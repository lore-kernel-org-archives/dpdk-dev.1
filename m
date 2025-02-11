Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A963CC0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:41:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE5D340156;
	Tue, 11 Feb 2025 09:41:15 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C3C0940150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:41:14 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ANSX9T032511;
 Tue, 11 Feb 2025 00:41:14 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qu5ngwdp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 00:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFvJqmgncdKVCIOVFKjHgdr02t6UTGwLeiJ3GmZvJel3CKAqrN5iCWNcyBwYokouqGcGDZDYWr/3RP5DGCWu5R/gFu+dANIKw5duNwQ7JY2l5MaCCeVFBnHPWHBfJy/yTnzzj1hYLllMGgODn2U0hLcd8ke0CXaq6LFs0unlv9EIWxbbPmWxDo5b0WjSel6s9hsjifA7Y12bcyqWBFKFdscbopLHpNpWB/hlCXuQ7Fijgy92s7jrpxBGsvNA/v5twne3+ZjpqeyVnO7qmu5SgtDPR1vlywGml0lSXlHm6EFwPBPny08bS92p5yKn9LO1rTLBcamavlPcTG/+2+OrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4E297VQy0LxkPUhwQGYw6IiLzfls6sIQ4au+xPzy9GQ=;
 b=P6qWtm7uw67g1jwfJW4ib/NiZekxQfyJvAGul8+g5w9JegSxx25HahevoEt6FVsOsINW45SQhHy2sEnPLgMozc6QTfMzF9J3wneYhHfmk/M+x1jFi/xY3WB7w/STotN0VywmNCD8MxFpMl2EwmC7sJ8qrHQySJTj9wW95ta12zoa3fAXHKlXNzCZdJbA93FYgOaHtIAvtSqsr45xywQIgC/Z9lGEtREVo9JWvtX/EBiInsOHBwMlJKj3n/SCH/IiBacAacolb3ca7DB2yV4WpsJd5gL23zSPHlArq7EdlyNK2ry5qBX9fSAwHJjIqoFhcO8s84MrpU26sHDc8SlQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4E297VQy0LxkPUhwQGYw6IiLzfls6sIQ4au+xPzy9GQ=;
 b=o/ig4fnuwwaXWnxom1Lh3EeUL/hxocHT7/ociok6gssc/1L51rx/VdZv0aWm90CCAjcb4lfcqmfNuuyKwiUHza+VMS7Gp3SOwxU505+jJgEtJpvBWc6ArtwbbKbFDUuInSvLQl8tu3Vg1xV15Gkxu+kxbOVbSq2Qp58vkoeoS6s=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by PH7PR18MB5283.namprd18.prod.outlook.com (2603:10b6:510:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:41:11 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.021; Tue, 11 Feb 2025
 08:41:11 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
Subject: RE: [EXTERNAL] [PATCH v3 0/6] Trace point framework enhancement for
 dmadev
Thread-Topic: [EXTERNAL] [PATCH v3 0/6] Trace point framework enhancement for
 dmadev
Thread-Index: AQHbe+N79Ik9Xgcr8EeW3s4hMb2KI7NByTsg
Date: Tue, 11 Feb 2025 08:41:11 +0000
Message-ID: <CO6PR18MB38605FFEA6694600AA9CF5C9B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
In-Reply-To: <20250210174424.3364021-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|PH7PR18MB5283:EE_
x-ms-office365-filtering-correlation-id: 6572b975-0b1d-413c-0ae9-08dd4a77d63d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZMceKbx5aHsZ/O6rd9x92Nu6Qo/RQ92Ko7GEKr8bnuaoMLoYdwE1Z5zXOhQK?=
 =?us-ascii?Q?sv6IkTklfic2o+7d5VZyaVYpneavdci909db2dVNk4Wq9Y8S/I2E1y8gyXNO?=
 =?us-ascii?Q?KO53v3LuxpoOgs+CLMEfixX3pgYisUuRT4Fufk0EtOYyKqK7DyJGf7L08aNV?=
 =?us-ascii?Q?Npv1UeZr+3A4hILYRgAO6ZtisGGPFlSSJVeI1QOYBKQWPWKK4eI6flTPYp+F?=
 =?us-ascii?Q?/kmxYRfJuqxNodZ1H4do2HONlv9vbQmJ59QZvtevAKX+orOxCavV6izO4fG4?=
 =?us-ascii?Q?Jq1/ax9J80uouItcb5AGaiFgAbUhJQbKHNwNIKffZRTW70gP70um5hNMk4WB?=
 =?us-ascii?Q?GQcwEJSrVsQ4nfAvXw0lYmIPG8XEGF/t8x1rK/+0sQJGCb1Yg2wNz+dcH6Qe?=
 =?us-ascii?Q?QT0Q2Kckr6SMg2UI6YVJmkvVnabn2rHl0tvfs2H+A8WBiVvVb2cnPkh+SBHc?=
 =?us-ascii?Q?Jvd4L3X3TLkh+uB3Cnd144pjVJ07xpawvuN0BIi1YOOlAOfGpQSuo3mEhMdG?=
 =?us-ascii?Q?nTPdZTIau7JtGeHVqLB+QXy9hdo432JY8IHANeZKxrMA2pUmTZcGpLBQR3ra?=
 =?us-ascii?Q?u+bJ1bEnN+sYJr8UCFZEpygOsfHLEa8jyZ51dekN6qtYOaK67lsLAQE3n2iI?=
 =?us-ascii?Q?laAbIArlcHij6buf9lSsBYpjswmlHOlyPV/ZBiYBulqbrUboMSwYTpgUvfwC?=
 =?us-ascii?Q?8T3BtFg0jkH9ViRK65NtPBjmhM0NPdUZckrHp/bmaJO5AxQykicqT3wXGE4A?=
 =?us-ascii?Q?CzJRy64wAvOt27qMRpUlCDSQ/3r/9B2xzAJihpTPqwCW5AjRyA7oMycSYdzB?=
 =?us-ascii?Q?xsc8g+G8sWN3kL8ba57jrbMcsYrEICY9JH4B1y8AcQJaArwarvu/KpqVJ/TB?=
 =?us-ascii?Q?6KLMeq6rXX/gvqwiP8CAk9MIqQrpwrxurnSsIcVM8gLD5LgJjL15rEkQ1vJ1?=
 =?us-ascii?Q?T+zKz98L1QtHDY+isvPwyLZqcD9Cdu4arfj2j5VRqkxauTqeAUpdQ86SunG/?=
 =?us-ascii?Q?uRXvLraa3wpBKqPuV4hvTKgEyVQYiUkcagoxi/BjPWfZCWlKeKFo6kuXJznu?=
 =?us-ascii?Q?iDPbeu58AOnst9zfUCJ+vw859r8t0KQOe92y7RCuZsOJnKMvmXCtsa+HI72M?=
 =?us-ascii?Q?ua+JvGBesjGxo7GrlyyRbr4NagVurIKQJ9XwrNtTjDoofwf9kFQQJUkM/Eje?=
 =?us-ascii?Q?de6Lu6inUEfa5VoVyVHevyMUEF7+wFhR8ej0m1E4b7wbBMwPU+uow10kWpSE?=
 =?us-ascii?Q?Y3emIcy9RmYi/Fy/pJz5gdSxLNr8cTSO4DcMFtONoHdZjiuSH45V5YTLpAMp?=
 =?us-ascii?Q?H/gOaZz+rUq1x3NCtB3JUSrXcwKJIcl6BVwyV37xVf2RGRWGmSElMJ+XLJvm?=
 =?us-ascii?Q?E0OKi8J80yBDW6CVbDVl1NYE9YhfG9bvj+hNwD/FIg5cKnIpRX7DGnni1VhT?=
 =?us-ascii?Q?SIgX0+G7SFUSpmcdDluYYut1AJrccNhX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6CmlcbAcr9MV+JByKvTrFwDnipNJbVjeAkZZU7Cfx9+7YB+QNO01MzVvQC4q?=
 =?us-ascii?Q?eTcnHBla56KpHgWX3rj0iinh/fh+qcxNxZT5zJELP+Wvd7GPuaWxWP1RK7v4?=
 =?us-ascii?Q?KeCVjf1qfvdxvd9HSkBNb64es6Cmqpd2Qut+kimLG9+XY/bLwXfHdJ2k6ISm?=
 =?us-ascii?Q?Ybaxv6ChCKuIrf95X73aVGOThpVx89OXS91g7tphLhv4i+kRaYxvdE6oYime?=
 =?us-ascii?Q?j26k6FqJvHD4WAI7D4tSh5KB+8z9aKFs9sEgdSEWkV/zseagBXBhyW3yqjXi?=
 =?us-ascii?Q?VOKb5j+sOa7NYWvcAARlN0yLz66eRcuBtEvAr49RdtFKfx7S7qSc1fgqLmTd?=
 =?us-ascii?Q?CHOwxn9st9UW8BAkzxMPPzd8HOmE10/3F9QRVRsKm54p/B495Bq7zjwybRr9?=
 =?us-ascii?Q?JaIsov3YqCZIdi8/NCPQyifHddex82NSmdwRdHU2d9dDgjEoji6AA7ACEYKx?=
 =?us-ascii?Q?wwvPbgG+HPRE9rG9+NLoEoRMEk6gCJdxEefaShklNWZgMVgRfIQXycdx4NQx?=
 =?us-ascii?Q?UJC2savi9NA1Iscjk8BO8jGYcvAZQeF7DkgNj0j595y5u4wWNB972TmCdl0h?=
 =?us-ascii?Q?DTLbdrBwu76pcqP+tzNW89+jnuv5A0sg7aAEBxYD4pPKyzlf1tKXOf3lkZyd?=
 =?us-ascii?Q?P6Ck9cbPx3gFqMp+3p4vOAQb8wdjus14rh5hPTtna6u6urj+4ID9tSg2nWrn?=
 =?us-ascii?Q?DIx+Z1HGp/oOqdTCWVlhCq4J9vSYdX1sfaOk4aPUXPfD1SKa3PfZsiRFpgFA?=
 =?us-ascii?Q?vWmdlnlUvcxN5L+GzTwrzm+tprPscLsvR0BevQFqDPRUg5YWBU/IZkwdLZqn?=
 =?us-ascii?Q?eU2Xn9XJF/CwCzADXl33XM1L7Nkm/u4W2DgUosvm37GJ0gbFsQ11zNx+yPze?=
 =?us-ascii?Q?ua2iZxZLVMpFwj0lBlpCzHhwmyEaJI4Z3GVeGdqxtdDVjwc0YtaZ3SgxwRnJ?=
 =?us-ascii?Q?+P2NWYC0iC2o3B+nkdjmbK71rC93M2ooWrRjo2hO1jmAV1Nw0ghd1+syfKkD?=
 =?us-ascii?Q?Iu/jQlEVDbZHsG05+15DYpQv7VRJjoNcAJeD7UVTYL4ZoBLaxFuTO0ftyndA?=
 =?us-ascii?Q?0F0v8PzDEM+/VICjOMrwd+CI/wYr8tS0qOGKb6kSln7Vh7nk8KKDFM5ojnHs?=
 =?us-ascii?Q?kstBGnirbCjx3/9q5w3hz4sdY/ZCRu9JeSvmxfOGvwyIkar3mab/9YtilpYR?=
 =?us-ascii?Q?822F2eTEfXCLPR1zqdnVrPHiNm5k/dZpJUsnoUcofYU6hMo2NDhnbBxnpwIf?=
 =?us-ascii?Q?x3f8L/SictmVyhS6sQtiuKOP9P5ognPrN0IOZX1G1q6ezsOAkCihccK1Pxs4?=
 =?us-ascii?Q?OvDiUkh1j7MXkLNb9YXvFMc0qHlmH+4YQxniW8QmActOKrWirCS+JttiRXZh?=
 =?us-ascii?Q?htvhwUHaFRj0k4LOomXdnygl6yYZMhRNpGuXBjWdYl5FXrg381MrKbuOHjY9?=
 =?us-ascii?Q?eHotY9XH8Bzh3qwLrJBYPoYigE3bkT0WNT53FkNrq4v8lVG98vPetlcQyyJ0?=
 =?us-ascii?Q?7hawzjMi/xKlXtOa0YId2y3xQ6zzDxsV4JUs2tuptjwfe9azhZTF0TcQod+w?=
 =?us-ascii?Q?KJCeeNcoo7zSzGmV1Rc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6572b975-0b1d-413c-0ae9-08dd4a77d63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 08:41:11.1928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQZ+/FsGSksKZDyRva6EDFbOc7alhLDuzHejXZMd2tP1WJsc7mAcHWZ5mCJeWrTMmuP4708+Iz9mZ6JO6u5+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5283
X-Proofpoint-GUID: ayXkwKzC_I5yOJI10nz-1GYap4tMebyK
X-Proofpoint-ORIG-GUID: ayXkwKzC_I5yOJI10nz-1GYap4tMebyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_03,2025-02-10_01,2024-11-22_01
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

Hi David,

I validated the series and its functional now. Traces are generated properl=
y.

> dmadev trace points have been working around trace point framework
> limitations.
> One of this workaround blocks enabling dmadev on MSVC.
>=20
> Traces files were not checked in CI, so this series also adds a new check=
.
>=20
> --
> David Marchand
>=20
> Changes since v2:
> - added check of traces validity in GHA,
> - split patch 2 and fixed CTF metadata,
>=20
>=20
> David Marchand (6):
>   ci: check traces validity
>   trace: support dereferencing arguments
>   trace: support expression for blob length
>   trace: support dumping binary inside a struct
>   dmadev: avoid copies in tracepoints
>   trace: fix undefined behavior in register
>=20
>  .ci/linux-build.sh                         | 10 +++++
>  .github/workflows/build.yml                |  2 +-
>  lib/dmadev/rte_dmadev_trace.h              | 32 +++------------
>  lib/dmadev/rte_dmadev_trace_fp.h           | 26 ++----------
>  lib/eal/common/eal_common_trace_ctf.c      | 39 ++++++++++++------
>  lib/eal/include/rte_trace_point.h          | 16 +++++---
>  lib/eal/include/rte_trace_point_register.h | 46 +++++++++++++++++++---
>  lib/ethdev/ethdev_trace.h                  | 27 ++++---------
>  8 files changed, 107 insertions(+), 91 deletions(-)
>=20
> --
> 2.48.1

