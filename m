Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882CBC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C215940A7F;
	Mon, 14 Sep 2026 18:24:53 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022114.outbound.protection.outlook.com [40.107.75.114])
 by mails.dpdk.org (Postfix) with ESMTP id 9C98C40A75;
 Mon, 14 Sep 2026 18:24:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrKIY8bJMp5FM4NlGoXQLJ2/Lhm+6UkamBmJkL65uR6IoQJiXUqNCoSjQsTPnIwnHVAjMRt9KzwDxUbT9w1Jw4pdHk6MNxaCTb/CiO6xxQqePYPC5XZa/iun1GHg/BkCsr1LX0spDYEVTPuKsb+/B3rdaJtzVl7qAXo3nBGYZb8Ol14eRndeeg3VRHnunJopdheXmZvRUV+VWeLmx8j0EtKECrYvDOUulRdrVq6/UjRNZwymbs8essb6otqOGQWmJgVtA4IJXyk7Q5ioMpAVyBedvdpHbrbG/uLqbXzxeMk5LXJkf15LBs55ZxPBGHntG1Vyaeeo3Ap6ZZW621aKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=2LU7xNGx5jiyzcGXTt8iKF9tG1xuYXaxqfNIpTA0JGk=;
 b=g3wNwU+DSWRWVY6gBxg1Flh8IgtV5lyQN4wU2pvBNwgjs1/fK/5VA/efwaf25jmo6UNUhdWgNPlkbXjxilApmsKr8V3SO9nboEPZP2nkNkFUt84gnm6CxCxGXcn5d8BBYRnsKYXgxSafUOCqzBqSbXPA76KHnAg9iNS5JsHm1TOw9qjG/lHF+s66WcWzlaBqzLne6yxmgySKej58AypP9imNZzaBrvQzqU3+iieCiBbt2uCEbAiTJmEAof6Xe5DlJLDS/5d19BjFkZtyFdzJL9X1i1guLSRs8Vxeax2ueontqRW/zT68+GOxrhav2IL1qVsTjW2gpqQf/BMwXTEOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LU7xNGx5jiyzcGXTt8iKF9tG1xuYXaxqfNIpTA0JGk=;
 b=Ta0iv2MOEaLo6DLFmRGfZbmTK7+qke5m/rr3vjeWazy8LLbdaa2QoaYZcNjScjop3O5AHy3G/1NvPo+2Bt8wNP3xT05d5sI2qDQsX1Yi0/iv6SiEt3DaiaJTht71XaevC2xRD87vwbwV9YiGeP0RTUvEHjOtaiKiTWzEk2h8k1M=
Received: from SI3P153MB1838.APCP153.PROD.OUTLOOK.COM (2603:1096:4:2a1::5) by
 SI3P153MB1887.APCP153.PROD.OUTLOOK.COM (2603:1096:4:29d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.4; Mon, 14 Sep 2026 16:24:34 +0000
Received: from SI3P153MB1838.APCP153.PROD.OUTLOOK.COM
 ([fe80::64f5:60e6:e32f:e91e]) by SI3P153MB1838.APCP153.PROD.OUTLOOK.COM
 ([fe80::64f5:60e6:e32f:e91e%5]) with mapi id 15.21.0451.003; Mon, 14 Sep 2026
 16:24:33 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Rita Ruvinsky
 <rita.ruvinsky@weka.io>
CC: "dev@dpdk.org" <dev@dpdk.org>, "longli@microsoft.com"
 <longli@microsoft.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue
 free-space unit mismatch
Thread-Topic: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue
 free-space unit mismatch
Thread-Index: AQHdRGQjyi/0gH3GZkWNAKlhNFNT1rbOQZsg
Date: Mon, 14 Sep 2026 16:24:32 +0000
Message-ID: <SI3P153MB18385AC2FAA3AFA6DE465B5DBBBB2@SI3P153MB1838.APCP153.PROD.OUTLOOK.COM>
References: <20260914105809.919580-1-rita.ruvinsky@weka.io>
 <20260914091419.22e3ef6e@phoenix.local>
In-Reply-To: <20260914091419.22e3ef6e@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c5c7e2fc-6954-4a35-a74c-a8a7d5776073;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-14T16:22:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI3P153MB1838:EE_|SI3P153MB1887:EE_
x-ms-office365-filtering-correlation-id: fe369958-c114-4f1f-5895-08df127ca8eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|42112799006|366016|1800799024|38070700021|4143699003|11063799006|56012099006|10067099003|7146999003|18002099003|22082099003;
x-microsoft-antispam-message-info: zZsUEh7mAct3JIMnZUcnwdw+BlRHhU8EIv2oDt+TLXogVj/ZZFLHvLBSJhHKHnItjleMtLeZ5+MjBjc9DQ2pFFmwNH57aTY7Cr4qaKCvbY2vrT5X7MguTaQRXvQYtS5G5ygpMmDUNKOKH3Ieh97IyenrDLAkaNXoyPyK3b424g6IhRlXN239DXD82cR7bA4wqY9Xi2Oiq2Blu3n7nmD6SQRPf43R7u/Si6bolt0c00FJQUEU0CUjaqm+L2rQIrX+pGsvCc3yMTSqSR/jeZffwOWntE7YX1ZWACOkAKx+kyAi6U9gUu5MPvtGcIYuOWLCYU1IdAqGrwTSLAnvCNhxtgqcMHJqV225O4UJNyhT3jP7p1EuOhN0M8gxOXy8rpODkVpZ1RX2maeObgI97ydClpemI8xJ5fgZ0l7+cmKDNWmkGFVCWEsHX3xKVbAuQ6iE1BOQ6oIwa7ZeCz8JxXG4uQuH4IVzzbfXLnzHJOzwQPJFnDj3QQDAUTo696noJ9qg7f5a/DN8+221hLNZykk3dPsmHtMJJZ3rs1uZXrnx6dRYaL/ZldzNIrFbrYOZ3jX2oBL5DNw1wNb2b+E7oVi4PfLoZmM9jeC++x9zToez2KxdkdIbSfg97Y1CxpdfI/ehD1Z9qXJczPfmhoHjxFQ+jt/aBNFZPFCV58dTIpXBjeOaey7b97dqC50Bdd9l+ariJ+uRgKSkZlUgOn39ata4CKH6nr4Yw87Jw9OtCamE5Cc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI3P153MB1838.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(42112799006)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(7146999003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TiONHwlNH0dq8BlR5mpiARDdUodCgZHi1jIexZRATz6eJ/iYq0AQ0eRLo6B6?=
 =?us-ascii?Q?l3z7HVrnCJLNNOtWS5GQQfqBq9U3gSkJwTAeHixahHQdZwNf8DdcXEGIpg0/?=
 =?us-ascii?Q?uFgcO6kQuOOzXD8wa2AGf7Sv0QT2SC4+pJ8bM2qrD6sj+Oy1tjFY8xeAAYAu?=
 =?us-ascii?Q?ORsN/YkxCwFGlgmS4vsKCeI3wbLpnxmRU22TSUSfCjRLlspZrUDk6SCqOh+u?=
 =?us-ascii?Q?NJHbnBpDMc0LgADfLwgBdyJC+e/6xkEdRg81D/SuqFrWgPKqSVlHcZi44qi0?=
 =?us-ascii?Q?JlYDVN/3k8dOnQmWjvponkP49sayMugq7yQWb0f7HoqCECxElIhrIO/BIZv1?=
 =?us-ascii?Q?RoU0eN6GPNRJW9ZxM9XqMWZzTf8zvm1gCZv05O8zry48F7fnyJB563F0fM7P?=
 =?us-ascii?Q?RTV3ghWQGGgtiYuTYo/6OnbFr6aOWlmSLkGbzkTUPAepPc2Y10xEDvTVblfK?=
 =?us-ascii?Q?T6Lz/2aLGup9Y+qx2l1ipNV5BYB00oflaKn75Rd0kcQ8PmzHINKfuasUpasC?=
 =?us-ascii?Q?SnaeYujt8r1NzGlQdjx0EP5mBCImMrRwcMnmzBZpxmiZAxsscuBo7WH5St8k?=
 =?us-ascii?Q?o6MEQ1FhPoWgnbNISOuIf2qe9sJM41mwBQaigOGQi3prSRaXxfh0LBm0lOD1?=
 =?us-ascii?Q?B2gf7gF8g7cYoxrLoylgHMct8/RaujNK8bT2H76OH5Kth9rptZlh4bI9exen?=
 =?us-ascii?Q?8gaAu34d8TzgCr48I4uFfLg77lHYpPDl/a6+XmfPwaYfZN47CWiNFxXwk4wW?=
 =?us-ascii?Q?FtPZGqeeNudTkcnhR1l/7PAt5H5pgpDMgN4aRAkvMA3ZgZGxc4FdLD9bg8QL?=
 =?us-ascii?Q?Tp+w5MzJbJ5NLAVPFDzWvljlvLsGVr/+uMCOXT4WhIsHq6OJzdYqEup2L4R3?=
 =?us-ascii?Q?Ohd7pKxcozhjDb1OmogtEYn0QqrdYC+ClkvFgtpnnjblj2Dm4MuDBYUQtvRk?=
 =?us-ascii?Q?6AbsMAwNap2m2Hr/WFO5sb0hJkVI71+JYVqIj4suKCX9A7aQ6dvZMhLrUK+C?=
 =?us-ascii?Q?cc4RgU1DwSLMymjsjMNn9+/v98dWGDK0fjAKTYqmmxy05kJbND24BZ5ucP+a?=
 =?us-ascii?Q?y9AZA8VwhlfPZnLHFEMycZTDqPoNcUnt6HIxrRzUUXBxyrgHY14sie5CxO4E?=
 =?us-ascii?Q?0hoD7yVTxkIgSit6Gy3mGtBaHJZC6DDI4qi91+zOEDnV1ni0oXpzVDZBdlB6?=
 =?us-ascii?Q?qZzpU/XByfbDS5sQCOakduhDSOx/9IlD6a+LVip2ebZP6Q0JzwiXIN9gwk+Z?=
 =?us-ascii?Q?cnYkUTQupN3aHqX9xF+3caqlKY8Na+YO7X0tW2pqHKq1QWtihIMWZwFjUcSp?=
 =?us-ascii?Q?hzAJOo9ppO549wmLGK5ozQMx0teb+vysdyLP9b5B15hcXesWbFn0+n64Hp6o?=
 =?us-ascii?Q?Lq8kWygJomtehkp2Tg8w63Rx7+GHKQ0816gdCz1fZfeZtOPUhSeRpYf4PG3I?=
 =?us-ascii?Q?wCWE4M/zfHyx58ZR8UxR9RvGrzFGBNLoBofvPCaiBFlDJlxjSqA9ZTMwGR2d?=
 =?us-ascii?Q?0Fsk5Oc701kY2FRFaQhh50tO+gYGIdhxjhlcD4Eqbc6ZbZUsJWlfrEkqgxHe?=
 =?us-ascii?Q?yy6t4i5iekVtzevxhyHEFM5o+6cTNPgFiOX89apwuQbGEdANle1Eh7cDDxfc?=
 =?us-ascii?Q?S9qZUBG2dPp+Igwx7VibcEJ6tWuaLaQiH0ljrgQk8+6P+PMCeCZ13nYUFMDF?=
 =?us-ascii?Q?BYUzRrAeRG+xPSZHRqndiKe8ArN6BDG/LG+fuyLgoNGnKV6R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI3P153MB1838.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe369958-c114-4f1f-5895-08df127ca8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 16:24:32.9118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMW2s2HVzy7+hzgHwxpefl3VTez8KOX48IF78zdWwFMFMHNXhdsOQo09VdcRyezyljf1voS5mgad2PiflfF9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3P153MB1887
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, September 15, 2026 12:14 AM
> To: Rita Ruvinsky <rita.ruvinsky@weka.io>
> Cc: dev@dpdk.org; longli@microsoft.com; Wei Hu <weh@microsoft.com>;
> stable@dpdk.org
> Subject: [EXTERNAL] Re: [PATCH] net/mana: fix Tx stall from send queue fr=
ee-
> space unit mismatch
>=20
> On Mon, 14 Sep 2026 13:58:08 +0300
> Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:
>=20
> > gdma_post_work_request() subtracted a unit count from an entry count:
> >
> >   queue_free_units =3D queue->count - (queue->head - queue->tail);
> >
> > queue->count is in entries, while head and tail are in WQE alignment
> > units. On a 512-entry, 128KB send queue the check saw 512 units of
> > capacity instead of queue->size / GDMA_WQE_ALIGNMENT_UNIT_SIZE =3D
> 4096,
> > and returned -EBUSY with the queue one eighth full. A workload that
> > fills that window faster than it drains makes rte_eth_tx_burst()
> > return
> > 0 for long enough to look like a dead port.
> >
> > Derive the capacity from queue->size, which is also what the ring wrap
> > in gdma_get_wqe_pointer() uses. Rx is unaffected: its WQEs occupy
> > exactly one unit, so entries and units coincide.
> >
> > Fixes: 56dd45c0ce7b ("net/mana: implement hardware layer operations")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
> > ---
>=20
> Applied to next-net
>=20
> The long form AI review had some observations worth including:
>=20
> On Mon, 14 Sep 2026 13:58:08 +0300
> Rita Ruvinsky <rita.ruvinsky@weka.io> wrote:
>=20
> > gdma_post_work_request() subtracted a unit count from an entry count:
>=20
> The unit analysis is right.  head/tail are advanced in alignment units (q=
ueue-
> >head +=3D wqe_size / GDMA_WQE_ALIGNMENT_UNIT_SIZE, and
> gdma_get_wqe_pointer() multiplies head by the same constant), while
> sq_count comes from rdma-core as attr->cap.max_send_wr and sq_size as
> align_hw_size(max_send_wr * get_wqe_size(max_send_sge)).  Deriving the
> capacity from size is the only self-consistent choice, and it is what
> mana_gd_wq_avail_space() in the kernel driver does.
>=20
> Info:
>=20
> 1. The debug line in the -EBUSY path still reports queue->count:
>=20
> 	DP_LOG(DEBUG, "WQE size %u queue count %u head %u tail %u",
> 	       wqe_size, queue->count, queue->head, queue->tail);
>=20
> After this patch count no longer takes part in the decision for the send =
or
> receive queue; only gdma_poll_completion_queue() still uses it, for the C=
Q.
> The one line printed when a post is rejected no longer shows what it was
> rejected against.  Suggest:
>=20
> 	DP_LOG(DEBUG, "WQE size %u queue size %u free %u head %u
> tail %u",
> 	       wqe_size, queue->size, queue_free_units,
> 	       queue->head, queue->tail);
>=20
> 2. The comment describes the old bug rather than the invariant:
>=20
> 	/* head/tail count WQE alignment units, so the capacity they are
> 	 * compared against must too: queue->count is in entries and
> 	 * undercounts the queue, stalling Tx well below capacity.
> 	 */
>=20
> The stall belongs in the commit message, where it already is.  In the sou=
rce the
> invariant is enough:
>=20
> 	/* head and tail are in WQE alignment units, so the capacity must
> 	 * come from the queue size in bytes, not the entry count.
> 	 */
>=20
> 3. Worth a sentence in the commit message that the kernel mana driver
> computes the same limit in mana_gd_wq_avail_space(), in bytes:
>=20
> 	u32 used_space =3D (wq->head - wq->tail) * GDMA_WQE_BU_SIZE;
> 	return wq->queue_size - used_space;
>=20
> It is independent confirmation of the unit convention and tells anyone
> backporting this that the two drivers now agree.

I was about to say the same. The change in DP_LOG and code comments
all make a lot of sense. Thanks for fixing this.=20

Wei
