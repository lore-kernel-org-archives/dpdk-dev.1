Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B38BCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20EB040658;
	Mon,  8 Jun 2026 16:12:02 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7492E40265;
 Mon,  8 Jun 2026 16:12:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM0UGAj+kGUNGii52Pg13keh2I1KR9MHqvVHtxdW28EoWAEh/D0EmZUTaBugVyaQAVeghqtEiuKvVFrzEt0rehrC+UMlrVRkoe3eQefEthZwuQEWeCB5/ZNfh7ZZBzk9fpUk5Y2t353MKBJc7U8TLVp9/oE+mhRKCz12lWbGCc7qXxaIZN+t5W/Q07lwlgTbVKcr5cAJrb3PTBkrD83nMfbhDqNKjcweiu3e3Zfx16QnxPP3+XDHprtOX5XvD2GPK24WCJ+m7QLJLOyYD65kfggD36DBoCOsKVpFj1bwA7H+rm8sKs/06xtAf22GcsbvJK69XieGcmtCW9tPvBmJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGn3Us0rM7ekpIExWtyafk+qDU9L8bVpnoxdNXimSzs=;
 b=OL2uSJxKV+SrL295puU9KXBqCb7w3ut1okJH6M0Xe0r/PaRXwd7bZsWQ6Oi+9ZxHyxQ40BbcRBu0Im7lkYxogAItnxdqH0yWMEkBpKi2oHtZ5ivcRB2oCMO/9e6EFY+u6BN1XL5YtQqFfgaQ1akRzckuB48s4mZRZldTu3NmsU46t0kp/T6gRTJv3FqIxM/tVBi0Gyukipbs+i/LSOJdzCtvj3Zd+5TuafZuro2QOq/K92T7T5STL/G7jvKU8tt6dDYfqQRo5YlBgvwqrIeSW+LWYyxRmpTWJsi35MgAGji9j+AKy/wK1jYlpyiBbHBAKPqO0W2NZ3vaQq4E/P5HJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGn3Us0rM7ekpIExWtyafk+qDU9L8bVpnoxdNXimSzs=;
 b=tJWoCa2JPfMOfWOOfRKFha7nJRmL/joVypHbG2/HaSOMOKZe40UbpvIczFg2uzAtdxZTBBjxXRuNRUkeWAmStryvIsdHJAvYDGsh5x/i4f3FIN8tk607lWTR+n7xipyRRMYMfC8fxZRUXZwuNGZCGNXEyif6zUFhKMs+qhTDiyxZ0ZDyLBFrpfRzGuq+kMd1nq3qxIK7goDG0D7S+MRGJ0jywzHxHMo6m+zhZSYxtBCGt76+FNG6vmVpYOJNaR3OvWbGtmkKPvlUpQ0dFsI6/XGno60EdUtQ3gteTwAgClOWCOkPqRPtgLfsCWJbGBV65fmo/Jhwi6zL7yYKeEy3dQ==
Received: from CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 14:11:52 +0000
Received: from CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837]) by CH2PR12MB9541.namprd12.prod.outlook.com
 ([fe80::1085:eeb0:9e9d:837%7]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 14:11:52 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Linhu Li <lilinhu618@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/mlx5: fix counter TAILQ race between free and
 query callback
Thread-Topic: [PATCH v2] net/mlx5: fix counter TAILQ race between free and
 query callback
Thread-Index: AQHc90pfIIRKRRRutEaqMOOvHZEdGbY0ssVQ
Date: Mon, 8 Jun 2026 14:11:52 +0000
Message-ID: <CH2PR12MB954156F425E21E8BB4C1B187A41C2@CH2PR12MB9541.namprd12.prod.outlook.com>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
 <20260608132555.31439-1-lilinhu618@gmail.com>
In-Reply-To: <20260608132555.31439-1-lilinhu618@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB9541:EE_|SJ1PR12MB6146:EE_
x-ms-office365-filtering-correlation-id: b771aa05-22a4-4eb0-ea85-08dec567e38a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: bEvt6SRC+VYepGGIM62grqRXE8t7+GOjWj/WFRFmZz5KggPb3MDx40n1A8zuwlNiv1eyA/r/PAQYC2KiO2gYGz62+ZZDhf00PQrCyZ+6s0VJb4NFCZjcyNUUST18Ztg05cvdTWKI+fGTb9nEZbBVgMde4OjLXUo+6JCTGFe9VPRLI9yYRxRa+raByFCiUoZgQvb+ph3eqWpSkT3rtFQ7m3V0op1w9k8bRyRf4o2uRoOY730SZpL4UpDHX98O77xoiBUpUAhCDO9QQ7O7GGdV+scrqij6d5ZN27pxiNDvmNuFyz6d/vxzkuNpBN1jRzW65psLsIyPu5GIjk9wlOAbOt7X1HMONLKE5TZiZFU//5JefYB1Ts+HTUBZOFl8jMiXWmo3I5Y2uPQfW7j+KqGAh7kN1FkqnqUjkC9hrI1rIdoVIOC5ZjNFFxw/tDyrWUNc7/eDNPFxqnkjb7XweUDO/MNUWoFX1PFUMYUUg1Di47fxdYycetGz68SYd5zIlPNN/SMoeMJdD4R7seWuw/80NqkRWyuKOOZfiG2F+udxq7gLSGNq2mDsz2Ie41ubz8958QIZKAFGIiZ2bgbMmhtJtI7/ZT9NzOCkZWMovl+PnsHjsIpwkf3PgeqFZxW/MtBcHacKP0AAQzneDnM5OKbaYqMUZkyU5yCsQaI23h3rBWNx3RNCWlkHh7AUVqUwenV8yJ68f7LLWZuXaH7ZZs3Wh6uJBMhTwCElucfMx3+N4DTa6aRv0h9BWQvK2BG9hiYL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9541.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uFEshwVXbiNV0wO71KptSoBuaWiTl+26vr+yFJ/LfC/niMUX6ijIFqJZlymH?=
 =?us-ascii?Q?3643hil8T45XEuu/WqZFIMYJcyrXlDPH2EP4ukdYKxT/Pi1Ob7mbIOO1DxYp?=
 =?us-ascii?Q?il7/Vl0zxAXi5jZI2sGH2ULgM8dCMZAZJ25kdRj205o2r5fqRmhqhaApTnl5?=
 =?us-ascii?Q?RJGR7YoCTlKNCKdQkldgHDkNRxiZUxGM3p4MsPIDaVtrohJqODXaUrXhsObZ?=
 =?us-ascii?Q?l7JSC8Avva4SFnAD+X7OA/4MULy8BFFLveVNriza2JX3N4PdEpVLYVCR/5ap?=
 =?us-ascii?Q?L8pSh/k0WkPt1yTKoNTgWLe2MaBtrts0Smvb4pWkssDF6Q4K1FaUltrT69eZ?=
 =?us-ascii?Q?Tmn4TnwSoR6EQU+Hrvyp86TskOjaqFkXwDoPePTtb1DEd4Wc54uOqW2UkxPu?=
 =?us-ascii?Q?eYZvZqgWwViDgUU+TfIcs3B/VcPzkj1TaGbr/saEXrrC7VsjfVKrHqRRtIGq?=
 =?us-ascii?Q?p0Ue+vWtlGKIgKnw7Lg3ErpLH+JryeeP2+jbmshhdIjRO2DgrUq7fZpLeYdu?=
 =?us-ascii?Q?yNEIWUkX1cL/FFG+AV8nx4efrIOV3ndaR91S/Ibzos94IMnihT9Kz+nWxjvK?=
 =?us-ascii?Q?DecfD70qlcWsEs4DPJPWHJgilw2errUhFlhY0FUVW1xCgzLRlnrC2HLn80QA?=
 =?us-ascii?Q?wC+QVMX9FgBoaDsLE5pFGciDj2KuBhVIPDlymfSaXr31/k6w1JbuJlPIziH0?=
 =?us-ascii?Q?NlW8sNo9eMwpnwZCYNHsaG3ZgxjF0jeTV3frkNBWgBah1FdvdONry0eZDowF?=
 =?us-ascii?Q?1NXWVrWto8pNBDy4jLnJfyyKsdf2lfkyvKs4xZUvEoTjWzz0QqoNFX7WA2sq?=
 =?us-ascii?Q?hOAOwXZqNSltTEqJmL3/ixbmGEStlHTMwV6xl1YfJlG+SVtUqchqt3m+GV9J?=
 =?us-ascii?Q?7JWxDm4BJJoHVSPUKVPKXG7AjtHHKB6xFiRUR2fTbKuOtI6fHFfYGNoq2Dh/?=
 =?us-ascii?Q?4x4dB3s6jEjeelbE1PMLk/f+saBck5I8XwqweU+xeSfa5EdG8WR4AUkgqO7d?=
 =?us-ascii?Q?aMJBnHNfqGj1iE3keND3SCzM0ufiYLk0dGhV5rz1e1IsoYyeL1JHftfZTESY?=
 =?us-ascii?Q?vVFGZWxqhH9SB+3ONsB4WFNBybLrdWIFlLufiQrJfu0cRTR4nDEaDXXpG8aB?=
 =?us-ascii?Q?ArNZm8LWFpld3brEt37nX0ZMibP3vHuOK8A9CTzuCkbx0s3okw4WhqcHDUwk?=
 =?us-ascii?Q?EHKdRML94O+aEnGOiDKwn4ayYecmAI7VOC0KQBETtVqZePL1pDLH9TE18fQb?=
 =?us-ascii?Q?wnWO77RLFuGy1yhZkG2NhAKuzmGnvYdPNp51Gfb55Uxjax5uaB3gH3SRLDQR?=
 =?us-ascii?Q?gcInDW7lYSZtt5i6o5JsaXziepMwfwi0aw1IIO5kqA5mWontM4MgMKmApYD2?=
 =?us-ascii?Q?5RCWC/CxI22RHne9aXU9aBoC6coSTO/HKm2yfSh7oyeQtWdcOzpuYYgSxLC4?=
 =?us-ascii?Q?HN3yUISbguaSt8VEbLOMvrudNhN0cJGnkZAlW2S8YdZi+DLx5kOcL7fMq1zO?=
 =?us-ascii?Q?mBUn10RBgsCmVUyO9rz+kTN+5giiGZty8YVS9GavlsI4ogT6nTCY8INPGl7S?=
 =?us-ascii?Q?6WP1PX111tJUPhgCSA1OmQmnX1/qBEZGb8gJeSMR/7ul5bmvM+nIJNuF8+Cs?=
 =?us-ascii?Q?Ksnl3U8o7pTbRAhgJj9NibUB87B03zPsmESjfuI+bS7+yfnzQOr4wRxkfYKO?=
 =?us-ascii?Q?tEc4C+LQAEMqkmHJqZDV8taqg3Y1tyUqJlfjyVnqmlvkl5dX0GnM7riJrZNx?=
 =?us-ascii?Q?qmSkuwlE1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b771aa05-22a4-4eb0-ea85-08dec567e38a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 14:11:52.2392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+dnEdj7UdWwSIN9xGmxPUmdC5mcbLFEhS+90jK1aoo59jl8GWTf49bWYbSAplRFgc61rDK/nKIFuDLk+LC0qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
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
> From: Linhu Li <lilinhu618@gmail.com>
> Sent: Monday, June 8, 2026 3:26 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Dariusz Sosnowski <dsosnowski@nvidia.com>; Linhu Li
> <lilinhu618@gmail.com>
> Subject: [PATCH v2] net/mlx5: fix counter TAILQ race between free and que=
ry
> callback
>=20
> flow_dv_counter_free() inserts counters into
> pool->counters[pool->query_gen] under pool->csl. Meanwhile,
> mlx5_flow_async_pool_query_handle() moves counters from
> pool->counters[query_gen ^ 1] to the global free list via
> TAILQ_CONCAT while holding only cmng->csl, not pool->csl.
>=20
> The comment in flow_dv_counter_free() claims the lock is not needed
> because the query callback and the release function operate on different =
lists.
> That holds only if the free path always observes the up-to-date query_gen=
. It
> can be violated:
>=20
> 1. A counter free thread (non-PMD, e.g. OVS offload thread) reads
>    pool->query_gen =3D=3D 0 and is about to insert into counters[0].
> 2. The free thread is preempted by the OS scheduler; it is a regular
>    pthread, not pinned to a core.
> 3. The eal-intr-thread alarm fires: query_gen++ (now 1) and the async
>    query is sent.
> 4. Hardware completes the query and the callback runs TAILQ_CONCAT on
>    counters[0] (=3D query_gen ^ 1).
> 5. The free thread resumes and runs TAILQ_INSERT_TAIL on counters[0]
>    concurrently with step 4 on another core.
>=20
> Because the two paths take different locks, TAILQ_INSERT_TAIL and
> TAILQ_CONCAT run concurrently on the same list with no synchronization an=
d
> corrupt it: the pool-local list ends up with a NULL head but a dangling
> tqh_last, and the global free list tail no longer points to the real tail=
. The just-
> freed counter and every counter inserted afterwards become unreachable
> and are leaked.
>=20
> Non-PMD threads can be preempted for hundreds of microseconds under
> CPU pressure, which is well within the async query round-trip time, so th=
e
> window is reachable in practice.
>=20
> Fix it by taking pool->csl in the query completion callback before operat=
ing on
> pool->counters[query_gen], serializing the CONCAT with any concurrent
> INSERT. The lock is taken once per pool per query completion in the eal-i=
ntr-
> thread context, not on the datapath, so the cost is negligible. Lock orde=
r is
> pool->csl then cmng->csl, matching all other sites.
>=20
> Also handle the error path: previously the counters accumulated in
> pool->counters[query_gen] were abandoned when a query failed. Move
> them back to the global free list to avoid a leak on persistent query fai=
lures.
>=20
> Fixes: ac79183dc6f7 ("net/mlx5: optimize free counter lookup")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Linhu Li <lilinhu618@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
