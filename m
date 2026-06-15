Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32527CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 23:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E79E340285;
	Tue, 16 Jun 2026 01:55:41 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11020126.outbound.protection.outlook.com [52.101.61.126])
 by mails.dpdk.org (Postfix) with ESMTP id 246464013F
 for <dev@dpdk.org>; Tue, 16 Jun 2026 01:55:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBNQq3qTMiRCRFIdfz4Rrf8Guh9fTtUSX7AZ7sApGH+mUwbhh+Va9sc4Va6ORi4pKN66oLqQR9yot5Gu/pR6M1wNNpSz55ztGxpQ7FmJt+bQaN3lrbVdNuk4w4bEzzvO+O1rMWEm4nPaa/ub9S8lvIuJVE/qq7XCJSpwbUDEn0NI9vNVmTdqp/Su2w9pJAq4E+GR8eM+u1HJjAysvuvXzvaUpw5FxO+Ba+rFniH1H2TSc6tg5IrWuhYTN4JtrVO+GwOBOreFbt/2SHBfBbqbzkX88q+x50MLfMdlfAqE8/rq8XegHHryhXQlAAXz/RjoY64DtwEPaj2jobRRdNW10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nU3zt4+ZmShk9a4a09O5WP6++h8AL7tNnL1yD3p+7ig=;
 b=t1VK5Qqw3hSqrv7DiSkWTOV1pMFYChWQaGe3SGdJK2UMgjOX+rVhSzi8mBTCVM/h3hJ8mM5VtptMKvCD6w4y5y++TyuxaKPnqoU5eKQlIBPWoPx/o1HQsPGu+6WxsiuhVK9TzkoUDhwS2B8WakL1XeegBK4R5TbFzYW9Ns7uEP0r+xO9soJ4wxgJtA4BcAN3TRyz3jeGJT+tE9CBWwYkNlnrZHvo7/RWKT6QJIu2Oot4ARuu+jAtTARQh96NrsYVlsFxAerH29aTzSrHLOKmJ88quIoMqhbyJMFU5LHh0HuI46ufgyv5+AY+OrhWjDKabWTIT6VqcdCxe8Zoe8wFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nU3zt4+ZmShk9a4a09O5WP6++h8AL7tNnL1yD3p+7ig=;
 b=BuihbbEAwncHKRnnI+qLH5RNTAWFmsxiQwizyw5Ngep+pX2n1y0CKNFWorIURrXgy+sxnk+unzF73bKn6Qn7zmsZre/lNqSbe910wCyVm44Fag63Nxf+7g/qCnp2eNG6w+aIkNt8OmpCO63XudxLvAIOBj/i0TsmOhovh5zGyG4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6584.namprd21.prod.outlook.com (2603:10b6:806:4a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.6; Mon, 15 Jun
 2026 23:55:37 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0139.005; Mon, 15 Jun 2026
 23:55:37 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
Subject: RE: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
Thread-Topic: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
Thread-Index: AQHc+Ycl4+lgrfhII06D+OlOowiZsrZAAv+ggABOhdA=
Date: Mon, 15 Jun 2026 23:55:37 +0000
Message-ID: <SA1PR21MB6683AEB004DF96D48ACDAD51CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6f0342d7-0460-48c2-be7a-94a02ac0027a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-15T19:13:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6584:EE_
x-ms-office365-filtering-correlation-id: 93bdcee3-038e-48df-4ad8-08decb39990b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|18002099003|4143699003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: Q5TIFlT5uQvuf2QhhR9X5Df7qu3u7CJ1XHYj84hoVbxDExKqNk2CaXkC7v4uVD4Ol40meRCt9XerIjLU/jzUKtE6xvMgQ3wHyqogUEJBGGJX0g2OABtDs7FK2WLd+aiLKBvCoqTYeoqkf34//xNgmJiAGeCgCMiAzIj+SihgnveqnqqRj8Ng0yUz0ixwUhbaH1Ecc8VnidwI1DQCkKnnM8fZ59mtohKxRrFuVJG7nTtiyr7d3B1EMnQpSFT8qnjVB2xTJ/nWh1AySgcP0mlEpxpUw2uwBXqYpbO+tN3dVo2dslsf7Xp2gKZ960uYgS/fZJWPzAOE1KFu7b27n3uvsX06Pj8xClhiLJRsLJK60mfs8dZrVuaL+RWerKjp0tSgHjViC62pjuziqi0GECyo/8V1Iudv/WV9PNIiBJALm+8BYKEGHUjiOz48bYrxUEv3wPSObyS7w60n91Prp7uEvwylO45+aaP8GbLndE1gHeKJlgSnh1Ws3csPbo2kySKWQrTXJDDbthBUfWfmsfeeQ8n4EKExVv1hEQeBDswgCWZkvPHwex+D1IZk4dBbLMX1fHW110gLlC0n+ZZGdeXzliJaLh4FhU+Uf7K9b6Vl1Nb037TOjO7HOuEXuOmE0+OCCHdIwoJu9mDqw1IVnTc7lsQZ4+ESFytwV7Bx52L8ikFTSsSOs91NCsMOLD8fE/v/wkpffMJ8aSMed9BPf1j4UgvXHvHAw1wAoD+Q7+R2n2JUa2Xz/5y/1ZI8KlDq7qjg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(18002099003)(4143699003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QpeX/iqfwwkx0rfTWk6S6O3PjczUAzB/9V1IoQYLybNE7SbdYG88NPykFB9b?=
 =?us-ascii?Q?BW7FRL9UAbVYnYALKs1zU84VHflFlXudPuMC9oP11Ven/r7tfzUi2LF8jtNv?=
 =?us-ascii?Q?6h9UV8W/7u+j7z4ZyY35x7+DrviKoun1Cn3wz1mRylW4bxjRLwnHu2O9QVYv?=
 =?us-ascii?Q?TcPi2Rsgjk3zPFkD6MZESJcVv8dO3epUGojr0Z8+N01iiH1JSXKyMnjzWXS+?=
 =?us-ascii?Q?xX220oK0QIM/jk4I3fQElru9FHV4QDjswplDddhjL5vLtsQoJWuuCsoGmU5O?=
 =?us-ascii?Q?Ws4RNrBXvV3bWYQvtwKcB4Vs6Q74iDshOvnNSZNrIa3XJipaPLExwHsWmwOR?=
 =?us-ascii?Q?5CAan4ZkvB9u5757FzdxajmRHotDMkBe3caKQb470i0gp6zebX0Dzli0N1zK?=
 =?us-ascii?Q?BTCFsDsFuYTqb3AGkbOpeZ1g8RUSc8jYjJ2gu2PX73st+JpdDLyFuHcndpu3?=
 =?us-ascii?Q?Ahm5vsefBVaTrGJbukT6hFGQh9E00WmGLjXtM88jG8iMIyqUPLEK41nsqOag?=
 =?us-ascii?Q?ZDfQ3DLJKCYfH3W5JGT+4j5nfnSmm/0WadMmR+sQSWudLBlfTYfQBdXmvIDk?=
 =?us-ascii?Q?JGBc6dQ49lU0x3W/SUHy+LLki7BK51rd0d6F/mOgLd9h3uJFzudjHteilSwM?=
 =?us-ascii?Q?EDzRRzaQi931Q/cfmx62ZQi8BKoJ92osezXEp9aAv/EZgm4Vcd6q4mZ8KlXK?=
 =?us-ascii?Q?CXBQhHSckHHPEhPK02ehOaKyltoRkImhf8gLKcBNfH18uWCNwWKoejvElimQ?=
 =?us-ascii?Q?/qAPgGeyQm56oQMQhe+/52lYs6lq3mS5C0e1RkBCQUnkV3qAtNBq8jxiz5ok?=
 =?us-ascii?Q?L2ySilifSs2/QedtPfnwTOIfVerE4/0sQFCEy+curaWTnyCzpA7GQ5Skf8jE?=
 =?us-ascii?Q?2c+YVwKnixmWpmAd8mz8GU5k2AmsGKVxV7lSDMViCDAtcQAm3rvwAaxN44F2?=
 =?us-ascii?Q?YrRcmsUxUBtcUSs0QkCvRJ+KENLWXOLggbmcU7eMTu3aJOhCXeOq/f2afCAX?=
 =?us-ascii?Q?FlXwnwdViHhs6/X2KbE10+WoGAKEiqUdEdYIu1g3RIkqM/0+nhsAssPxgwkp?=
 =?us-ascii?Q?NbK17ez6iLbzHlm/MOhsUku0LaIM/oexGDqaNohFG43v86eaiy0uNaGSPwXY?=
 =?us-ascii?Q?CajtFOFBMh86Bitf8BXnc2kl5fC/xyyiCvnXI353vFMs1s96Maer1bka9++E?=
 =?us-ascii?Q?KFfrijppzjGW1YD3KuULTOI++VFIFGfhXMJz5xUAwgdqxkYXNxqcFK1rej+6?=
 =?us-ascii?Q?42Mp8OuqA4q4Ujdb5qUoT2wce/Ppmx06xFDLMieuk6WkElLe0XyA2NJTwKlz?=
 =?us-ascii?Q?YtISRWdwY7fL9Vy9+qmL5g+0CAG4t5HCvmb6peKY1rMSrQd6HKO4VoRSXpP+?=
 =?us-ascii?Q?fx44QlWNnIZLN769aAx5Ih0qbHAnAhjrQyMOEPzsU3lVHyuOI4OovCaRMWYp?=
 =?us-ascii?Q?tdKXbcmK4OVdqMJI9Kxw9UMANTQJmLq0FdIclg0wwv6O9b/7IvJ13qIVn55Q?=
 =?us-ascii?Q?l7w8JIzHw9BEb31d6JCXSQnLz0eRSOVZ4Fa3vSFhMBVC042EGvCz1K2HJFpo?=
 =?us-ascii?Q?am73A4WJweMry8pwI/tTKW++/T3fDjjomWiRt6biwHdkY7cgtVYvW84wjObg?=
 =?us-ascii?Q?eV9S1GLT7QrAcjg151bEvVMy2v3JQ+8b7eWmWTqFM+NTkPk+ONn7SVT8rpjC?=
 =?us-ascii?Q?BWBYQCwytBh0RDeJlZToQCYW3XAE1Ttpg3pGj2B+7qb8qHsa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bdcee3-038e-48df-4ad8-08decb39990b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 23:55:37.3825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKcTGdWQJD467J2Rfl42e59xU9jKCup3PgJqkBCuowmi90k5iv4hlQ7LJlPo5JVmAwjFp0kQjrRywK6AX0bY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6584
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

>
> > This series refactors the bus cleanup infrastructure to reduce code
> > duplication and fix resource leaks in several bus drivers.
> > It should address the leak Thomas pointed at.
> >
> > The first part of the series (patches 1-8) addresses several bugs and
> > inconsistencies:
> > - Documentation and log message inconsistencies from earlier bus
> >   refactoring
> > - Device list management issues in dma/idxd and bus/vdev
> > - Resource leaks in PCI and VMBUS bus cleanup (mappings and
> > interrupts)
> > - Simplified device freeing in NXP buses (DPAA and FSLMC)
> > - Deferred interrupt allocation to probe time (NXP buses, VMBUS)
> >
> > The core infrastructure changes (patches 9-10) introduce the generic
> > cleanup
> > framework:
> > - Refactors unplug operations to be the counterpart of probe_device
> > - Implements rte_bus_generic_cleanup() to centralize cleanup logic
> > - Adds .free_device operation to struct rte_bus
> > - Adds compile-time verification that rte_device is at offset 0
> >
> > The final patches (11-13) convert remaining buses to use the generic
> > cleanup
> > helper:
> > - DPAA bus: add unplug support
> > - VMBUS bus: switch to embedded device name and add unplug support
>=20
> There is a hung on vmbus during device shutdown after applying the series=
, I'm
> looking into it.

Turned out to be a test issue. Please see my comments on patch 08, the patc=
h set tested well after that fix.

Long
