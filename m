Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F7C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2FA540DCA;
	Wed, 25 Jun 2025 13:44:24 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1D72840677
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:44:23 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9TkF1006743
 for <dev@dpdk.org>; Wed, 25 Jun 2025 04:44:22 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2133.outbound.protection.outlook.com [40.107.220.133])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g5r91941-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 25 Jun 2025 04:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d28eZXBYdj/D5/36YZ5defA3wSy3uknIqK5BHz3sjFId7klc28I7kMWahuAA7RSwLoYNW6HYHCKRSaBTaJH3vFsU+2nuJptpKiXsQvZYJ52oVx9atLv8oSY6i8ewzpkxNmTAmrX7PGRtxG//4tKD+i9Wzuos3XduotglDXB5KRVamYVtKDNfIOSckZJc4u+ML+EonlQt4KL/CFyn1ZawYtu3Z9mjB956Te6kQBqc/Cpwe4ArS8WMx1UGA8wMnpk6x1ZF5v1O+LCbUihms5XKI1S598g306hPmJCIoAZNVUORCnrPwaMp7YmbaoXZtckOSFEMYHzCdgs5XXj//fONHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fvwyS5ebTLNgIuRXHMQBNBMja61mIYIC6D9oj1O8HY=;
 b=GV+K6LL4Bp8ruSv2bsbehoHQ8ZxAZ3vOeoOcM0WgK27CplvdvYCtp8VRYI8aaTR5R4FIPfZa75OXKx47ujx1gxkQOsAlO/2F8gpxSooST2VR88cfRsk6HSCvQG87J77i+47wc0em/gXi5cf6Anz2yKzwMVIdX9CC19Tm3w6TQdFaM+977er8O70/4i9gcp6ijL0DqoSEJ/uSfoakvSYjmVq/GXt4sV26TWBRIp9T4g4wE+IBVEgpaW80L8I4EQOLpn4puw0pZ7lO0LOcom61pYqKHy5GuE4TU4WhWkkXHOSfMQIOoMcRsX68CI/AXPe/v7HdweIk6lOUze037nHYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fvwyS5ebTLNgIuRXHMQBNBMja61mIYIC6D9oj1O8HY=;
 b=v5udRz8VHL22D6ourldzd2ZNX/iKN5jU61pgWIzDX1IjJC1TaT+LColTe7nuUAHFMa8rv4wFwnk37IHQHOzfB3S4fFSeLVuDoz9eq3Vp/fNvkOtWUyz6P1Uqy/5Fo5lVrczb1AGPEzgHJR1X0H8sjAYR3+gFv57JHoRhJczkgWM=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM4PR18MB5051.namprd18.prod.outlook.com (2603:10b6:8:43::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.27; Wed, 25 Jun 2025 11:44:17 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:44:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Pavan Nikhilesh Bhagavatula
 <pbhagavatula@marvell.com>
Subject: RE: [PATCH v3 0/2] add crypto adapter support in cn20k
Thread-Topic: [PATCH v3 0/2] add crypto adapter support in cn20k
Thread-Index: AQHb4CwoA1Asvm/lw02LLx/vMCSXxbQTzH5A
Date: Wed, 25 Jun 2025 11:44:17 +0000
Message-ID: <CO6PR18MB448442BCC5969C73D937BB2AD87BA@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20250618083651.637234-1-nkaithakadan@marvell.com>
In-Reply-To: <20250618083651.637234-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM4PR18MB5051:EE_
x-ms-office365-filtering-correlation-id: 013c1bb9-cc1e-48ab-d4e8-08ddb3dd9dab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LtjylyAOEZthFmqX8l8qLTmX+jYrCNXpw2JPzrZeClrp7nbSThoqlaGCEIrr?=
 =?us-ascii?Q?UliXEre3AfaIQ4wfMiE7fzN6AHazynmd2tDJjtwPlleF/gfz5RaY7SWje8In?=
 =?us-ascii?Q?gnTvEY6FpiSCiL2lL0bGIX8W08M2hXShZuzUKbpxKdj8I1zUBmmVwVXW8ti1?=
 =?us-ascii?Q?9EC6Ol3BSMRwjj0AUeRhHW7vYWkpFoYKCjVMjRvX/IEBfg/XNqA2D0dpohCF?=
 =?us-ascii?Q?XwR+SMFtzRJCWkZQVpdFAhj+rG5pWgOL0X5YvZ+MisXSA3wxqIQPgH1vvQWF?=
 =?us-ascii?Q?7Pfyr7te92CRyZHU+T29ajZxq32XeUtTgPejFMRwB6BOwG4Ru8gmQ3bqP3C9?=
 =?us-ascii?Q?Jdx6hHK4y6E+arwqy+ReRHK4Z2xwkeJuObQJ8OYvwrCLqmvVf8w4CoUtJ5yA?=
 =?us-ascii?Q?kUb3XxnM/NFndM15ZUzf9TionV6GvYOVLI4RU+ZVQT8RUwoyM9LBUGR2Xvfl?=
 =?us-ascii?Q?z3+H561WAa5DcN3ZiF554dDypAs/TKx+EmwP+TpkbQFSJQG67H0yt6cGtBzL?=
 =?us-ascii?Q?JioRIrbgX4iNr/3J48lMmPNEfk95CdUxaHChe+oMzlOKgQYI5HJo4EJ6XCZa?=
 =?us-ascii?Q?WaQ9ybyKuKadsyl/oZrswSPHl8OtrZ70mnh73r93EbtoHx9S0yfu3gvDrwhK?=
 =?us-ascii?Q?bsspZO8QYjNEvR6hnODkHJPTVSugFFmYBoUcu6Rz1HTInpNzIGfMfktcjRex?=
 =?us-ascii?Q?1dutywKsITGgzQuXYHXc6IdNlL1ZQEh/roqWI4J7CHo2osEhoXdA1EsWx9Lg?=
 =?us-ascii?Q?r3AHfPEn3Iqr7bXeNOSDCm/9xjocB7gTYAwtyk1oT0okKZbZH+8Jz9pWAxQI?=
 =?us-ascii?Q?RFpeEimBPeKfyY6Zrhz+vJQ8VgrMHQ+wKe9O5I+92qdvxFnqwmccIBuZjbcd?=
 =?us-ascii?Q?uyQYWZPUWtqa4PFCtTtqFv2/XHoT8j9ca8jckFb0BWAvES2FLkKQfEOO9iT+?=
 =?us-ascii?Q?eZYFDRO5sXy3y7zzOCNKFn8YO8aG+r9GesnFuMbJejYQPylOKHGC5NWfpLmi?=
 =?us-ascii?Q?y/w6Vgr0n2PMHER/IbkYd1Wtlk2q9ecWDipk8+zqkYoihUnOAPaPz7vNapIO?=
 =?us-ascii?Q?eaIGrDPcyT87ygd/4BlUOAYeu7pxesIy3CEFBuJ8HDmmP7CIqOxQjler0oDL?=
 =?us-ascii?Q?1zZ0oymtTUiDBBRlkTz+pjokPtFQHiEXLLKITgNdgaLlzxYs/vYq6k8WlBIw?=
 =?us-ascii?Q?+Q5X6vmFt8rMCExxmZSpDSMEqH6NaPFP8FMXvjq3kGTCXjQfi0MBuRvNcTn6?=
 =?us-ascii?Q?a7onPCEW3+tajckj6xVY14raCOeJAxO0QboFWEjYOySX0JXn9txtn/YEALNj?=
 =?us-ascii?Q?bu3+96bIAaRkIJ361l5oUu+lHL61McY2cGL0MghRwxJ5bInNpQqze5ufn6CU?=
 =?us-ascii?Q?NBwvw852cs9orjPAlN2MOB+r53Rqu7NekK798Pv9zffkuAedcPBHI9YAYHBy?=
 =?us-ascii?Q?NMkDXkhHkga/kfHJqxI4JjSTQvMa5qvO5WG6V4oA7f4OQaWLu3W35PchglNy?=
 =?us-ascii?Q?Bxao/VhUTBo6Q28=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdxeDmkOZyyTcWCGGKpWBhYkP7wpKK94E5de3vRTpkx5gxdfC2ZYtP9yc7zJ?=
 =?us-ascii?Q?uXig0m+ThzmUfIeabKz6AMzJNAk7KcSBONCzYSS5pAxMLxhjeoKH2OZa3eKa?=
 =?us-ascii?Q?0l3ei6LO7tnNM8NGkJfwb+6ALzjyej/sIay8T8UBYv3t8p6DdBaEkVQfh3f2?=
 =?us-ascii?Q?FgO8b6ucHO5krKgi9tgtsOTZSBo6xjYG/9BmOVdwHJJcA7e5wpDiMAVp+yjJ?=
 =?us-ascii?Q?yh/BQBdBBdL2TfFZAt/HqMPtZy4KvFDrBgjfN66rm+SGBbOpfhf+Z+2pK3+4?=
 =?us-ascii?Q?P+t7Efy/zxlN52NQNcidiVSfQZAqKRCdeMtAe73WQNzhHQxNAhMYTR83yFxS?=
 =?us-ascii?Q?KV0dIqecD4n/4ApzCEUnZJoRiZhl5FcMs8W5k9E87VCLEevvW33naadM+Gky?=
 =?us-ascii?Q?souvoaOiYYNkxKG5cp1RWkAA4JPXSzWuKS2OY664JqzAZD+bXi8QEYzcmqkU?=
 =?us-ascii?Q?zNRtPxkrBxM0ZjgOBUZ1glwW16RRglkFdn3Qr6nY/f2a5XJytRoc2GQkNlMF?=
 =?us-ascii?Q?SFM7O0+HM49SOdJn64rMZN9P7P3yN91NIPO6YU9qrfhlByrcCLclAfi3p1Sd?=
 =?us-ascii?Q?ROLQ3jaBM1LxTYFqsex3Up7yDz4pAk51lITZXT5S9VON5z27SZLaEQHXa82D?=
 =?us-ascii?Q?PrfMjo/RkAPNq2Wrl0J7PPrmbxgi3FSWbMkruVLOXfGi3fS1nskqU+hKCMI4?=
 =?us-ascii?Q?C4cqtOTjE6B2EmMGb7Go5JTQdT/BAgvuyHjCH2wQnEhLuZ73kF63Gs2cpDRA?=
 =?us-ascii?Q?YAO5EErACHpjxLTbfuFrqtjxY2M1hYeypLuiLD7fDlJUEQJNnkC0IPurxZpg?=
 =?us-ascii?Q?DGq1F8m3HYDZELCGvEADavKn0ge4n4Vj/ZUGrRgKV7+CFJdBcv9r83ZU0JKe?=
 =?us-ascii?Q?EVyGpYZrAnexk3TgF6cVy50ZQBhotGKwoNT44ojrMOo6n201hPnHX0NfwTBe?=
 =?us-ascii?Q?DSqGPsYgDMIOgLTQvNABy2h2s1xYcbaRdAe65nmtvRTjyWBj2m5Opq//MhmM?=
 =?us-ascii?Q?zSb83QtN8y7OCJKcTxoLRXVIJapakL/AIdCa2GUsumYJko6IvlSdnWZpvtVz?=
 =?us-ascii?Q?prWVbX/jTnabNznw/FkV7S2KgLTzORouqpBDLQgq1OWcVrZJXTq4nn4k/9qI?=
 =?us-ascii?Q?yQIdfNz3Gfp9OyIRBEzUbAImaCv0Jk0P35CmrJ/AV+4usCHBoOjlUQd+U9WM?=
 =?us-ascii?Q?z4Lb/MC2QpV+sngEZg/AWqh5y35fa3P+UDLddFdelDDJXdSOoKz2Ny1vCnHz?=
 =?us-ascii?Q?34Dptkk8Jj4U90CcJ+/n1Sz4I30FspROLtB1Vg5Pg/Mm8jNvJYS8xGQDkkIN?=
 =?us-ascii?Q?Kt91qkfyFL4OQRowS/yy1EY0cq+o9kAtwIYxsoeHUOaMf8QmdDAQ+wxEEeHq?=
 =?us-ascii?Q?MNBw0ag5wDW7n8JeErvQnf2Etsta4zy7Tjk21HQzP8A2RYAAM4dc3ZuGESwE?=
 =?us-ascii?Q?s1utaaGOEfj8JbleHf7dKtOSzTBDRO84skVwjWtobonGF1kAhn4hIt+VBK+v?=
 =?us-ascii?Q?gE69RYUBMhuBEnwd+oerf7T6Qy13MuWHW9O5ClUyQiEsgrl642zMxgj415go?=
 =?us-ascii?Q?aAxkjdmUv/t18BjnRLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013c1bb9-cc1e-48ab-d4e8-08ddb3dd9dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:44:17.0745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hMzAThAb5rEe3ivg6NuO+4vxe/3IHDpjIYYutFtD/ajpii+viqf6LQkUmqzgzLOzIJLKmqO/w8AMVKY0iHx27g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5051
X-Proofpoint-GUID: NbeqBC8cAxY1urKvOhX93xLE4nhWoQ3x
X-Authority-Analysis: v=2.4 cv=GYMXnRXL c=1 sm=1 tr=0 ts=685be116 cx=c_pps
 a=jIshG2S7E8nEleq52+39Ug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=X1SgGoTIM7eazQTVWNEA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: NbeqBC8cAxY1urKvOhX93xLE4nhWoQ3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NyBTYWx0ZWRfX20cV5KbAd1qt
 O2yp6feAahl1VHZEQyuy9jQkHBeVi5ghzeWZ1fIsX5Vkeq77Ymy2EsflOlhGzBvfplNyik6htVX
 2xR7eG+LhZ31ZbpCQx4+NRu6suxVY+mKktNM511f2qER8RW4p7Foh6xxA7C3Gu8kmcrbcKEmZgy
 uG74Qrgg3Ra6Lj9/x1dcSLPN3CcyL3M1CyotdRv5rv9UptTatxN46gHmqe9t7gtAU5hmsbiSGv+
 5j7iURZoRW6gWfxyp1bV3eH/YLM1L5qEdodb3+Z5M9O22zdS37eUEDrpZm+BfIikciRHvW4BpaF
 yfJyJ6Lvsvkal09ZWW48EsJQ5UGh/JvxlW/ZMtM4ZPLQkbq8shv3x9pjQLbiJpfXByYotbkFdiy
 kcv1CjT0SfCeXNxFw7HLBOtPO3LGUhxCl/Gb8L0kdmvg+h38IAXDbtAPzoPTuSm8NZAbkNj+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
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
> From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
> Sent: Wednesday, June 18, 2025 2:07 PM
> To: dev@dpdk.org
> Cc: Ankur Dwivedi <adwivedi@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; Tejasree Kondoj <ktejasree@marvell.com>; Akhil Goya=
l
> <gakhil@marvell.com>; Pavan Nikhilesh Bhagavatula
> <pbhagavatula@marvell.com>
> Subject: [PATCH v3 0/2] add crypto adapter support in cn20k
>=20
> This series introduces support for the crypto adapter in
> CN20K and incorporates sessionless asymmetric changes.
>=20
> v2:
> - fix compilation failures
>=20
> v3:
> - add dependent patch
>=20
> Nithinsen Kaithakadan (2):
>   crypto/cnxk: add crypto adapter for cn20k
>   crypto/cnxk: add sessionless asym cn20k support
>=20
>  doc/guides/cryptodevs/features/cn20k.ini      |   1 +
>  .../crypto/cnxk/cn20k_cryptodev_event_dp.h    |  14 +
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.c     | 675 +++++++++++++++++-
>  drivers/crypto/cnxk/cn20k_cryptodev_ops.h     |   4 +
>  drivers/event/cnxk/cn20k_eventdev.c           |  69 ++
>  drivers/event/cnxk/cn20k_worker.h             |   7 +-
>  6 files changed, 754 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/crypto/cnxk/cn20k_cryptodev_event_dp.h
>=20
Series Applied to dpdk-next-crypto
Thanks.
