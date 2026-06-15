Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBEECD98CF
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 19:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D623C40DD5;
	Mon, 15 Jun 2026 21:14:23 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11021079.outbound.protection.outlook.com [52.101.57.79])
 by mails.dpdk.org (Postfix) with ESMTP id 19886400D6
 for <dev@dpdk.org>; Mon, 15 Jun 2026 21:14:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7ZvCW2I6nz0ExhIEXCKqOXuYqqj98Kg1y+fLWD9CeNatDCPszNy2lllcLNGFFL+owBvktwisTYUfQCtA2Mj94pLFHaKSY999lS6S4xGi/tLXuqjONQobSROYMlESZfegq2HPmiwpuVY9Gqny49LVb+OxjXGVbb3lt4YQ7yAbdsAD+5qYbWCY6q3dh0LAjlaPRRcW6XT+KKOi79AJ/aPypJOYwiT9iFnUUaYGfQO2yYygSreuicq+GQcIQLoGNA51ZSmq2CQ+Xs7aSPBuho2TeoIXgOD3DEzVhlXeR+hI9bQrar1NL03Gpa7WX0h1iYfewwqsyORzPDQ42S8IPZ1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afvWn/sPUsDZ5a45nRMZ4LVMJUxR2ZNyKMyzw2uBmJY=;
 b=oGBU6kCSZEngOZCX/7QOCIa10DESgNOFVt7AYBTdVRRhvRE2Mz5U6pR11Ns6yWAdqqGq5zlTtfo13sdghdTdx0N7ApTCbrcSgrBxMuHFlXHmOdpw+gn4tMdwFEBO6K964O4neh2a9Kjq7NP912B0daTRpQdalGWsTJjEMJTXPa5wXKPXNrZG8+LCdg09GDBlQOZhhhihJt7sFuVM0lYOsw68UdB0/tu1KFdxyJdb+HVLSq0ZKcSqqhU0R7KjRlqZ0suuDAbUj0wgeXh/YcuV59TpC6CYT1Cy4ivTbeOjHMjk9zf1/qCi0K0VQ1Bh2SLvjFNXOSU8BKreATatObNhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afvWn/sPUsDZ5a45nRMZ4LVMJUxR2ZNyKMyzw2uBmJY=;
 b=QHuxH4zrMFWxXImrtbFI8QaCQza739iTKouNmyaDR8EFfkCika9gG2/g1AJTqD16E77QRs85gM7N1x5Cupk4pRj/aIQdyIVmHfiC/KBxJgmAeDWrW3e2QUDL9kMtUtn8Pd6RYTmvSR8HZZ/4NT/ekorkS7LL9UL810RfKjBX6y0=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV4PR21MB6750.namprd21.prod.outlook.com (2603:10b6:408:357::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.0; Mon, 15 Jun
 2026 19:14:21 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0139.005; Mon, 15 Jun 2026
 19:14:21 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "fengchengwen@huawei.com"
 <fengchengwen@huawei.com>
Subject: RE: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
Thread-Topic: [EXTERNAL] [PATCH 00/13] Bus cleanup infrastructure and fixes
Thread-Index: AQHc+Ycl4+lgrfhII06D+OlOowiZsrZAAv+g
Date: Mon, 15 Jun 2026 19:14:21 +0000
Message-ID: <SA1PR21MB6683D20ADEE7D476EBE59CC8CEE62@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
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
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV4PR21MB6750:EE_
x-ms-office365-filtering-correlation-id: afe73f20-2ae1-4193-a48c-08decb124df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|11063799006|4133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: D0VyyyuIxXuiC/fbzibZEy39gufxCAKs30Vs1LUz5CPbJ4EwUHzxJ5dkOQC/kPUw9rHEMeVrM4moAi9wQ7p79tAWaMSBusBctdmjiMwu1qSwxHyNfHdW+IjGCtXSQyXIZUKv/FQx8JahKn8QBDeUtIg6Cieny9KZEczQ4qrNpQWXVJHT5/NeaUuCuS7RturClAMHqbbQj5cETOa1iz39ZAKafxtm5TwJUI3CqJ49YTqig6Q3YCpTN0iH8l0iUOMGp7OaXPEmBj5q6puQ1hh0ml3t69XBH+v9YIem+mYO0/6SHiBDX4J/L3XciCoAu2ruzooGR+Fd8mJ7Re6TgQscw+oIrXo4cCo64cn2GbtvVyLkQfxaJbIrxOEq70eoCHPyBJHZJGr7S1vg7jX39iyCYzPppRZ5mJxHj7kJtBppA+4HhnoeOGssD1ekbRVfS/HbOk+DbhI4vDokypSGci0hFqfm6D8XOSscvxbvCEAxUzg/yRR1lU5jCebYPS3Yui22wmGvZkuMktp/5EuNP7zNSRpkL+ECwGs9dFhHw4MU0vGMTQJ1t1pTsL6iJAMKNG6QknC5Uk+HsH6Z9k8txdpfybAZ8IX+wOZxuU7RXzqHKu8ftVeLn8vGtxwa/BHoaZRYQeI3Nllhf+0he2smanIR5PzUltp43XeSRx6f/1Um498VzhkfBqrHMtbIsEd1cq3p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(4133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KIneCxOVGD1Vjqz/EhCcfeoeZJ3Oqqo2tWXd1JX0VbBfrMlfSPsNJWBcngEB?=
 =?us-ascii?Q?SqcilfRMl8ueMP+98apwKcYmDF/JXn1e3QtFhJF0X6jx4oXoeRY8reLFct8w?=
 =?us-ascii?Q?/WVQitH3ccPtp8LNwLDOU9tNYc+Xw2XUCuYGzg4N7khzyTXIabDVBPiU68gw?=
 =?us-ascii?Q?1QbRmRnCMYAN1mOtp5DBoQv62UGjcnEMrSgyoCZ9pexJYpzEHQ/RMBWFD2PQ?=
 =?us-ascii?Q?4doy2lVqWPlKZxy/NXX/ebaybOgoO0zEAFTHejfigIvL5NC5VMfGxb1DabEO?=
 =?us-ascii?Q?yEbuB/knYZHF2/JHb0bNkC2cmKyF6jgzB/XVIsEGW4Z2U6BPOHoN1kz7G+uo?=
 =?us-ascii?Q?hKQSxhOy9meMiwCLuLOuhtp3KPNwccwdLPE6BENItoutbS60X9zf+dzlqaVL?=
 =?us-ascii?Q?9IW39xsDWRf957hPj/a2iW94eXhHOhB78yxFi1iwr1HrhZdZ8KrKCCBGuLW0?=
 =?us-ascii?Q?OFUOZCEt3RRqSVFrQeQ84/0BSZO6jOA1cd6L05gZkS0Q9PJBplsJo+X0hbEb?=
 =?us-ascii?Q?j42BICmm+s13rWyjrpQTIyiS3lasYEw74Z5ZLHGUucK4Ygg+9YGe7WzjB0Z3?=
 =?us-ascii?Q?Pevhc9/sUfNGt5nJ7zOpz5MJAv2Ql4ydZl3DTBUJ6EyKadIr8tB+V2V6hsjw?=
 =?us-ascii?Q?uUWMOgVWujG7MWlw/7LtH79bKvUueggn6zcfKUe+pQbtJf+p/ZPG9yQs8zqN?=
 =?us-ascii?Q?oe0u1gLE2SLN/0ccpOX+EUFdTnGFHnu0upSC/f0Eq8Ls+ZdKxmf1u4l6+xLZ?=
 =?us-ascii?Q?3W/jKWnEgu/54s3cHJwcvffy/ozA4kXZRWhBpuKFXfqm0nAtTYOV+NPwsNMu?=
 =?us-ascii?Q?ijvniI6RA/B2UiNIGraDp2kT+5lLzmCwF+vnp1xSLb3617G67/DgaajNtkb2?=
 =?us-ascii?Q?fP5O9jxRRjgcRdK6d9Diqpi3YP1h5QRQH0Atu3t1zYXUpWLwiLm7YHYAU7Ks?=
 =?us-ascii?Q?600hLPjwm+oRLf9TRyyRx3YV5oLBb7rAACIvunXZ1AfwIPRBNTJ9JieYqrhu?=
 =?us-ascii?Q?DrPSWqaD+xzo6+9Xg9cwsA6qreT2Ca1QAtFdT2cYK1g22Fj9F1FNo3/PKZO7?=
 =?us-ascii?Q?SDM/95ggFFQ73VTp6gXyTtaOAoNG4uugGlUpKuL7ZnsTqfC7Cjqa/fGi5k7b?=
 =?us-ascii?Q?cil8sWM3UNCddu2Z/XnyUWTl/NIu561Y/A/Y4gnteKorxq4iJAEzspDEl6GE?=
 =?us-ascii?Q?ROluP8A4U4ZJYuMM7QYmPaRuXNVCbVQ9Jsv7UmVcAqN90a2AE/g3Z49BTma2?=
 =?us-ascii?Q?zM5z98hcGZGLvl5ASGI41sWX6hEiWYnD7Q+3BqGkBk8QCeWUDNyccTVO0Wg0?=
 =?us-ascii?Q?StyKuglae3EwUyPCz5LykTjFiY8jB68yZWqoQ0PIbPiaYqvAry4TX0e/qoPc?=
 =?us-ascii?Q?Rus1b+QmFuO86wrDjO7g9a4XXp4unZSf8lYHQcnq++4QnBZWH1Zy5L5Z8b4f?=
 =?us-ascii?Q?5ly9WhA3ennPFoLiG25OGPN7SXF8ef6pgbEuqKHpyHdLwdGE9YTr4AxcZRfT?=
 =?us-ascii?Q?SMvOReAz8AT7gH+LzkdlSr7odrUHbFb6nu6MEzu/fFL4/rZepaoLzFGyRCjB?=
 =?us-ascii?Q?Ycxhjdl5R/nph9GCqFgylPu6ZFVb/DxR1+DYWR14okKkgiUR8cJjghSnxdI5?=
 =?us-ascii?Q?wOi0R4zkGtvqEaeBNzuNmlhDZGC5YB3K1X1PtEMlUi68q+ziu5YskZ6x8fVQ?=
 =?us-ascii?Q?ncXI8lalk4v6SFYRD90QhlhsTpRSeE776jyD129n5/1xLeUw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe73f20-2ae1-4193-a48c-08decb124df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 19:14:21.0872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEtvfSjY5196la+OuWSo3jEOcLHZDuyOl7ou5t+tOT35SKCWXVNHmtDbmcga44NZHyxzIolBDhm1tuSA1g0l7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6750
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

> This is a followup of the previous bus refactoring.
> See
> https://inbox.dp/
> dk.org%2Fdev%2FCAJFAV8zvFpLwz8SY8DUUezyJyM43eRZ17Yj30ex808eHC4ZE%
> 3Dg%40mail.gmail.com%2F&data=3D05%7C02%7Clongli%40microsoft.com%7C2b
> fea821d6064273513d08dec79e460d%7C72f988bf86f141af91ab2d7cd011db47%
> 7C1%7C0%7C639167679756696197%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIl
> dUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DwW8q%2FAt1AsVp2OHaK3OCLJrJo
> ar4KrjdKtf78hnDUyY%3D&reserved=3D0.
>
> This series refactors the bus cleanup infrastructure to reduce code dupli=
cation
> and fix resource leaks in several bus drivers.
> It should address the leak Thomas pointed at.
>
> The first part of the series (patches 1-8) addresses several bugs and
> inconsistencies:
> - Documentation and log message inconsistencies from earlier bus
>   refactoring
> - Device list management issues in dma/idxd and bus/vdev
> - Resource leaks in PCI and VMBUS bus cleanup (mappings and interrupts)
> - Simplified device freeing in NXP buses (DPAA and FSLMC)
> - Deferred interrupt allocation to probe time (NXP buses, VMBUS)
>
> The core infrastructure changes (patches 9-10) introduce the generic clea=
nup
> framework:
> - Refactors unplug operations to be the counterpart of probe_device
> - Implements rte_bus_generic_cleanup() to centralize cleanup logic
> - Adds .free_device operation to struct rte_bus
> - Adds compile-time verification that rte_device is at offset 0
>
> The final patches (11-13) convert remaining buses to use the generic clea=
nup
> helper:
> - DPAA bus: add unplug support
> - VMBUS bus: switch to embedded device name and add unplug support

There is a hung on vmbus during device shutdown after applying the series, =
I'm looking into it.

