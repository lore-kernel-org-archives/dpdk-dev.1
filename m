Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EC0C282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 06:29:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6BCB402F0;
	Thu,  6 Mar 2025 07:29:22 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 837ED4025D
 for <dev@dpdk.org>; Thu,  6 Mar 2025 07:29:21 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525BwZCI015461
 for <dev@dpdk.org>; Wed, 5 Mar 2025 22:29:20 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 456f5tk0da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 05 Mar 2025 22:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czo8vZ9LB9638DEqJ44TnLScekfi7yA5UKZMIMfNqVqPNUOSEC503Mmo+IAuwkudIAFm2EwWzKF+Oovq40qpC3fcSRUJ5Po65ARgJIaaAPC5oRKsCSRmzrdun14PEXcIDB++HqobhOv7z1eeAqRzhCGVhTZyYII39tHv47mPjD6aDaW16iJwmONmKEasfp8tpe/i7NkJjqt3zlV8tPkh+meo5TfxL/Bu9MSBRnpTQDSnY98YNa+2x2912DRfMEyOssmV8sV2cmjxR4r/8EosCK6s9kB/iIsuaPRaMuh0o7kX7POyocXfM8sBoLNtX8ykci4GR9pjUA/RkLaxBSDKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OYJPzb6uBSLnTv/7ED9AVR67qJV6Wyy1KvUpGn5Ra0=;
 b=F+9GraTLXmMgiBOidU2Fah3+++EnXnqSh0JX6aSTahL0mnnWFehPuppgXLbetFDVWER/AOrabTc8pGtMCi0yFlE1mdj7WzJGOlYC5UcApFkyHRfBIeNYwBJLP6ijK48dvFA0Q0Ez9ZY7YXyIs5HBGBjvBcWJPU24QCS5zrF3w2B/Ot5w7yc9om9tsmmZMVIyZ1tFtPasxuy4UK8A10CXhiiW1b6We2Hs3Qf27YTTg9QPJOcXXmX9P0G2rGbYNbdG0CLedTSYmbXrKzqMZeOwAl3UhyicC1fVUNhf8WrLdiuDbGzRyoFGijlii46xM7jy7G7h6qH0rjlVWgY9NvpTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OYJPzb6uBSLnTv/7ED9AVR67qJV6Wyy1KvUpGn5Ra0=;
 b=vJCtrcXg5dz0tzU6SQsfKBCLIfchtn1QNkK4EC31jhK7qLChNxsgzr5kwxiK0niLicpYPZTR35/W6kGNR+DO8oZCwBhr01oA726yFb9VW2rOUPqfcxzDUOTKsLIlktfPKATSlVoY8W+2mKzclFIzhT/+B+2szxnjKkBX+hgvfPg=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 BN9PR18MB4217.namprd18.prod.outlook.com (2603:10b6:408:136::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 06:29:18 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 06:29:17 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [v6 0/6] crypto/virtio: enhancements for RSA and vDPA
Thread-Topic: [v6 0/6] crypto/virtio: enhancements for RSA and vDPA
Thread-Index: AQHbjZYiHAPFnVl47EmaijKLQ/UJ6bNlpsTg
Date: Thu, 6 Mar 2025 06:29:17 +0000
Message-ID: <CO6PR18MB4484746560500E4987AF6F34D8CA2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1740595670.git.gmuthukrishn@marvell.com>
 <cover.1741154953.git.gmuthukrishn@marvell.com>
In-Reply-To: <cover.1741154953.git.gmuthukrishn@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|BN9PR18MB4217:EE_
x-ms-office365-filtering-correlation-id: 78d80465-b969-4844-df03-08dd5c78390c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?v38heu8Mytbc3il93pbg5OijcVcAGieN0Topp7GytPMBqhww0SfKTR8QsxFN?=
 =?us-ascii?Q?3FyWKoSdB5x2Fv/I9v/yZ4Y/dPzs3PsIsvopvTJeXom+ZNyz13nFplNCfHrn?=
 =?us-ascii?Q?cmA7HpSjl9MQclbqifUNHcu48lNRHWleGYO59owmd5O63Jb9xBPytMAVja4E?=
 =?us-ascii?Q?uEKcE1FgnRD0Bpmv5D1l5eRjCZBDFSSDGXlm+VZfA/gbt2caTNqQxnhtlGMM?=
 =?us-ascii?Q?wHYadNH6VpVTztkNGS8ljzdWVczo2bW3rjz+QDpV5fzSD9ExV0A01HFiWDF7?=
 =?us-ascii?Q?cMjSEkiUztA0wup8ramG4seV2N0Ix2XgdVqJB8cMW33QtkvvfxkQ5gclnZRs?=
 =?us-ascii?Q?9Ub18rF0TBGR+FKKmvDoa4VgL6VNa2rDreuEg7O1UixkEJ2uX6dX+jjk6Sw+?=
 =?us-ascii?Q?rHZN40GyX/V9ktur2+zQFDvn4gTyhqThGUcxYxP9WgEByr98GtVzO3Dmk08i?=
 =?us-ascii?Q?FN983Og80ysiEI4QsFKlNAKlqnih+n3jhuHpmBLkO2OMM9wf0BfIjDhwIA5S?=
 =?us-ascii?Q?vFi+XYIDSFx77Ir2D73DU00em/L+Xu38AZLG680Kl0gtvlGYBYqMTXzil0Iw?=
 =?us-ascii?Q?TPLDNUBV5Ps/BxZhf1ZDlGU1kcXATFChT9HRQRS81ItMfTpRg0tkXFCSDrWU?=
 =?us-ascii?Q?OU5Q3ysxcJBASVLRwGGfu5D3oIZuZLAwFoaFKGLfk35npIloATAUfRJ5/cbc?=
 =?us-ascii?Q?nr4IzFNXCuHbXmOsTNe0b802g1GHD9VvqlZmFO60smM/Su9ZFXx0l3PvbIXD?=
 =?us-ascii?Q?5wNYrlhOtHacaT2EKBd+Q5maIntZmDjkq7Q6pM9lP/GmnQstpQ+wzVjvDN2B?=
 =?us-ascii?Q?HfaNkWiwCx/dBIg3+XmdguxpwUlbXwX0FkwcxKcSglCfNeVej0x7K4pzLwnH?=
 =?us-ascii?Q?IPG8rZt/FjcpQxeG69G/vyhJgBud/mQViB8qo1OJWTM0kF5VtrSLmXlRigPv?=
 =?us-ascii?Q?/91/aSePIeYv2aNV+AUBgx5JLH/JeO9UvR+oXHAsRo94pmeEASZRuC1HlY9C?=
 =?us-ascii?Q?iULlaBb1jokfcn32opKtsAkvCa6vpB3jIS6+h8x6Fkz6eR44j+m1cXDMobiX?=
 =?us-ascii?Q?vKqe1QEDvUUSX3jOcvbUuKWOADvvP59v9Pnccqu9qR9uijMeutqmoNhMSKkb?=
 =?us-ascii?Q?4CaQ5CyQ81Tz6foGk6kOcGqI26rzXwvxyrorF5Bggdviwn0f3TAgdFj0MxY5?=
 =?us-ascii?Q?HSG6tOPQ3OHKPWN1DS0xb7WbxxByUoIaH2CEXTatqL/uc/g/4Viv553On1oc?=
 =?us-ascii?Q?Po8kauFzu3JlwpEIagRAsgHEVC9+XBgFwdvjFUAHFrYr6ui6LGGZs69PBUeP?=
 =?us-ascii?Q?hFDnRbx3ep//r/KPLg0Htj02nAdO6ZQDha1qZWvO+3s0El9f/SR11jkRBbPf?=
 =?us-ascii?Q?UUr54o+RJcB25eqYcN8LuY2XwsncfhvyJhqPITiw/R90qeHCaJLGeUvrdHSi?=
 =?us-ascii?Q?nfe4KWqTdNOSyo6kl6rLAbxh/OvDcFPl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lodrUXFYLFCOKebH8n90kTGoxePLFgzPguUqr3cw9X8tnACLAxYHWLGji3uz?=
 =?us-ascii?Q?S4yaJnLcPHn0uEAoEAWJ/oKBCLMlU8ZhtIx3vU82MaF6vzkBi0h2fWF58FOP?=
 =?us-ascii?Q?rZup7VRBfksr0b0/AG5n3vZuDJXHFAno8CqAx2A9nd8TMHpXsX1ZUjt8wvK3?=
 =?us-ascii?Q?PeO+hz0G585HH7SFp+Sghi3Fa0tpJlXI6jPi8x9TscJJEer863wHR1UpaKrt?=
 =?us-ascii?Q?EakoLgQW7QRkmHLiMZaLD6GS7zVuC68Bjcons4opGH8KZu/8BgauFDkj+7AG?=
 =?us-ascii?Q?ody9QU7nRDOdmNfiiaQnOyWgZRwsP+ZIl2mUQPmWp8lcqMIh0l5GhXRxG7xF?=
 =?us-ascii?Q?zCMWCIuHtgL0Y6ONCpNavkoF0UhMIVn0qC+rHy7Nzv6w8NckS1ZkyTM+1+Aq?=
 =?us-ascii?Q?XXmHtaw7ywualjVhyQelGoo2N4DVs1ITKeI4p+aOn7hH/EEAQYMlpDQBrNZJ?=
 =?us-ascii?Q?U/rXPaLU1G3XOBOxCxka11YlV7ROp2I59BsbhlcGNXvywZkq5bkP2Ler/bUu?=
 =?us-ascii?Q?hwVN+EcskqirdI23O60SetuB7997sftigmXWFQ4mYO6aaPKeWKRdOyK7Dg5R?=
 =?us-ascii?Q?RAaNK1wj5JPkAVMONEsw7KTU8dYAt1WsmHtU2s6Ba4255+1DgxSYt7pENvR1?=
 =?us-ascii?Q?OrSMOCXpxicBIaJnFEX2T1Wx/dQ5uC5vStYRep6nw1ZaMuwrKTdolI7VikPe?=
 =?us-ascii?Q?D1mclzJk42ssHTnU8Gih3jNyLKeAhUB3y099d7wRD4B0xznbRzsJyMchMX4u?=
 =?us-ascii?Q?wzpxY+wtqmx0/7spVywDi04ua5ddN+iCqsmtmy7bQG5c607lKEU7gcY2/qUg?=
 =?us-ascii?Q?ekK4TVnI+x9/CENQ/e6R3/oDn3sm2HeU0y/bSqozQWnMHT4mtRTccDOEWm+X?=
 =?us-ascii?Q?ytZpr8wCDstin1B35RkRo0d4/1//LTKPItkGMNys8Hovq7zov+J2PM5rzHAV?=
 =?us-ascii?Q?xVJTBOUKFTe8klLUwVfbSQgyR5PP6EI5NKct9BAFDKK7o6bVBJkNJwo6Rhox?=
 =?us-ascii?Q?g5HGrcJoqj76xXyuJ7VZXwk7IzcDOUZFpnA16jsciBEW7804CtaTnj2WZVLa?=
 =?us-ascii?Q?XH3ZOQ6PFRVv4CGo3BaUzxWrPgyHfjCJ5cMM1wbq1ABuyT0xOfsWvOTIjESP?=
 =?us-ascii?Q?vGwClh5RT1EQfJc1ajXxn/8XyJ8NN2cZ7K9YRNPUvUrMWVx4I65JGnb0ci10?=
 =?us-ascii?Q?tFAm+CFpYdZBlSBZFDuhWmlc5aAnAxLskKP8i+1oFcuqKJzDXW4sgjFdEEyv?=
 =?us-ascii?Q?gTcUB33pOMaNVCKtwdeAl01VwU0nLcV34zs46Wkq4ghAUsJlJFnaAqcFtE3i?=
 =?us-ascii?Q?YzV1y3wcn8MrwN1y0MpO98bmSml+ECoJJ9cz5hkxr+W52nrACY7l6AbcE4AB?=
 =?us-ascii?Q?4dDR/diaatdnjYliDWIHRxD/Nn1sAsIHY34o8J5lLelsdnBht2srSIQ05K0J?=
 =?us-ascii?Q?8v4vsUxcuqO/3cNECyGPKE+8mxv/Xf8DB+PBV4R0mIAu3lSES9e/BQMo4VHX?=
 =?us-ascii?Q?RGckcSCxoFG4QfwpJ7KXJRqrXrZrLdOiKx2n/qp7HnyrvFo5UCWzRIrxa5kz?=
 =?us-ascii?Q?+a1O+S5g5hFoi24k/p1U0vvIkXbhKAGDdwmAcLVN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d80465-b969-4844-df03-08dd5c78390c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 06:29:17.8831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVreyXW9d5lWW1AFSv606HplmqI9kRUU6TZInmWtE5yl8tf3piTSJiIgYKZy1pb3QtkcZKViMbkqPnRATiB46A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4217
X-Proofpoint-GUID: N6NDhB7L9rAR59k_fLkj2s8z4HATgx8H
X-Authority-Analysis: v=2.4 cv=JtULrN4C c=1 sm=1 tr=0 ts=67c940c0 cx=c_pps
 a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=M5GUcnROAAAA:8 a=ZiTcCqT_AqG0VOnzby8A:9
 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: N6NDhB7L9rAR59k_fLkj2s8z4HATgx8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
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

> Subject: [v6 0/6] crypto/virtio: enhancements for RSA and vDPA
>=20
> This patch series enhances virtio crypto PMD to:
>  * support RSA
>  * support packed virtio ring
>  * support vDPA backend
>=20
> v6:
>  - patches rebased.
>=20
> Gowrishankar Muthukrishnan (6):
>   crypto/virtio: add asymmetric RSA support
>   crypto/virtio: refactor queue operations
>   crypto/virtio: add packed ring support
>   crypto/virtio: add vDPA backend
>   test/crypto: add asymmetric tests for virtio PMD
>   test/crypto: add tests for virtio user PMD
>=20
>  app/test/test_cryptodev.c                     |    7 +
>  app/test/test_cryptodev.h                     |    1 +
>  app/test/test_cryptodev_asym.c                |   43 +
>  doc/guides/cryptodevs/features/virtio.ini     |    4 +
>  doc/guides/rel_notes/release_25_03.rst        |    4 +
>  drivers/crypto/virtio/meson.build             |    8 +
>  drivers/crypto/virtio/virtio_crypto_algs.h    |    2 +-
>  .../virtio/virtio_crypto_capabilities.h       |   19 +
>  drivers/crypto/virtio/virtio_cryptodev.c      | 1060 +++++++++++------
>  drivers/crypto/virtio/virtio_cryptodev.h      |   18 +-
>  drivers/crypto/virtio/virtio_cvq.c            |  228 ++++
>  drivers/crypto/virtio/virtio_cvq.h            |   33 +
>  drivers/crypto/virtio/virtio_logs.h           |    6 +-
>  drivers/crypto/virtio/virtio_pci.h            |   38 +-
>  drivers/crypto/virtio/virtio_ring.h           |   65 +-
>  drivers/crypto/virtio/virtio_rxtx.c           |  725 ++++++++++-
>  drivers/crypto/virtio/virtio_rxtx.h           |   13 +
>  drivers/crypto/virtio/virtio_user/vhost.h     |   90 ++
>  .../crypto/virtio/virtio_user/vhost_vdpa.c    |  710 +++++++++++
>  .../virtio/virtio_user/virtio_user_dev.c      |  749 ++++++++++++
>  .../virtio/virtio_user/virtio_user_dev.h      |   85 ++
>  drivers/crypto/virtio/virtio_user_cryptodev.c |  575 +++++++++
>  drivers/crypto/virtio/virtqueue.c             |  229 +++-
>  drivers/crypto/virtio/virtqueue.h             |  221 +++-
>  lib/cryptodev/cryptodev_pmd.h                 |    6 +
>  25 files changed, 4447 insertions(+), 492 deletions(-)
>  create mode 100644 drivers/crypto/virtio/virtio_cvq.c
>  create mode 100644 drivers/crypto/virtio/virtio_cvq.h
>  create mode 100644 drivers/crypto/virtio/virtio_rxtx.h
>  create mode 100644 drivers/crypto/virtio/virtio_user/vhost.h
>  create mode 100644 drivers/crypto/virtio/virtio_user/vhost_vdpa.c
>  create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.c
>  create mode 100644 drivers/crypto/virtio/virtio_user/virtio_user_dev.h
>  create mode 100644 drivers/crypto/virtio/virtio_user_cryptodev.c

Series Acked-by: Akhil Goyal <gakhil@marvell.com>

Applied to dpdk-next-crypto

Thanks.
