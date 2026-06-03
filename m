Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C30CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95880402CC;
	Wed,  3 Jun 2026 17:27:20 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023100.outbound.protection.outlook.com
 [40.107.44.100]) by mails.dpdk.org (Postfix) with ESMTP id DAA9A402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 17:27:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNptPRfd2/ZjCAMWkEY10djvyzwgvLurnKOibNzmBLTz/lts5M38Plu/8YZ7qnEinacDV8ifPGRuP98GMqLMJEAgT3/fMtSxbj4BUJWT/EMHjsKfUTuZ9BoioNiq0aJHb2851BelHrHzQulXRyBSvJ1/vwNl2rhM4YkKjxhcJ7+irvv1Kze9CltuDk6cnhUN1kv5qsLke28Mu1yrrUBIJ42vJU++XfTZyez2uOE+uLnyW2Zp1VtYhLKnwUDnLaejXq59ztgwLpLnI66h9ZtVzN8sR8XxVkN7dZidPiEaMs3gz9p6eTzhKMtiNPf6VDG3/FFXQixUeFFa78DmpiEkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:MIME-Version; 
 bh=eFwX7tZhaPwI4AywAWvhQC//Q4YDiPszgG1BZ0rLb/8=;
 b=lt5nABr3GOHCHt/5Bu6waqfi383SBiC4IZgfT646rNkT/RWn2o/zNEOODEsGYcq2aw3aNs3rYp6SJla1kSl0EZFixe1dPo+2K6ZuJs1BbJnHnTTCWcFgcxO3bUTq/PlpGzIwYfbR0IWgyAN1+PBTgRXwZBr7vbapziDu+fMec/EVJqkSrC3E7gdndfVkzULZ/djLzP5X7af9q7SJgsjKHikbO6Tx5LSmGmEvSUIof3QwVuELOr2MCZzM+3rXBuqXn6KqNmN4l+QfC8rFdR39+flANtk+WhOl2ziD+ZjTyjJaERM4aYR/nqPag19oZQMUWdHPd164/vOyVDGZkcRcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFwX7tZhaPwI4AywAWvhQC//Q4YDiPszgG1BZ0rLb/8=;
 b=GqxBJGvDJsnJosrENMQgcu5E3KE/TxAJc1Z5TWwz8HRmHJsiasBJxzwzkhKmuaIbIalK/b0IuioC/FbRSQC0VrEUN3tOxpKMp65LM1EN02FliLGszAOXtpiG2d8TJUBjR7/UtWcR6hlpWjJP09nvfhBAVDwngxypt7anhmtHDiI=
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM (2603:1096:101:340::5)
 by KUYP153MB2351.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.1; Wed, 3 Jun 2026
 15:27:14 +0000
Received: from SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e]) by SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
 ([fe80::8f4e:575a:4706:a56e%4]) with mapi id 15.21.0113.000; Wed, 3 Jun 2026
 15:27:13 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@linux.microsoft.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] net/mana: add device reset support
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] net/mana: add device reset support
Thread-Index: AQHc73c9EVCxCKMK4UeQ1hF02FMZxrYp8K4AgAMA/9A=
Date: Wed, 3 Jun 2026 15:27:13 +0000
Message-ID: <SE3P153MB1848987B8E80506442A84E0EBB132@SE3P153MB1848.APCP153.PROD.OUTLOOK.COM>
References: <20260529142648.148407-1-weh@linux.microsoft.com>
 <20260529142648.148407-2-weh@linux.microsoft.com>
 <20260601095802.36cec727@phoenix.local>
In-Reply-To: <20260601095802.36cec727@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94d5d674-a489-4d16-b477-52b7d655c3b3;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-03T14:50:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3P153MB1848:EE_|KUYP153MB2351:EE_
x-ms-office365-filtering-correlation-id: 4d164d33-59fb-459c-fc2e-08dec184963d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|366016|38070700021|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: E4leVrp2wAUh18q+bpyYkB/+SBVSm/cTjAukgiIrrPhnba9dpjYMg3T8dupg9Fu/o5/yn9MSSXgwkI7yGBX8u9tfdzaf0M3/rsKcPZe7/NCy71NjfD98EXBxEY13bBDKeCpI+WppV+JwAaeIm2aJGJA/3RC4SGM/e2VilY/9sLcSbOQjTNHuR2B4B5ULQ2A8C3epnNf0HaKGM6Ay4NWzseptYGhnXb2Qh/+mYuRCtQSYsGUjKy1CKQmq0iMkZvxp44N0Mg2aGgcGdhT5pIxTTKSE6Cc12/Bq0sVGiwpuCGh5Wd1m+vdHuZ7KKTzAJelpvI+17E3otXuT1dOyYhrJHZ9qEen0UcrUyruYxxWqcIzNMZNfSaY8ka2D6gT/yvGU6gDZoZLXj3jioLHBX3bTuyWxakwxi/ctmux9jltSTgO5geQFykb7t6E7pCJPz7TIheLizTpfNzKsRtYRiVo7dCQ7GcaaF21q+pfXe1AMKjSNAX0C5kmZ9BMtsrXRgG3spWsSHmdXATvN6R+OGcSxN7A1ll0BJul3hsQZglq/jsvBX78qWqrpSEFr5cEYYWLi5/Y451wu8TCpayWimQKyYt8xBfckM8Pmn5lrmH+Xx6jlgTRmqgkMfRpjod5CX5DIPloJGOrTxCGKZmAk3EuoKysYg96QStmfCsg/A7g9HLJqqQj3/cbV7I36gF52E6TbZZyVaKfYvoZB9Magqsh8Mzp1Gt/MhkOYAKTGlJznhXdOa9IXVpckoG66ySXKkG1q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3P153MB1848.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5/ig0eL5no++ghndb36M1u9cj6x6z/9/GatGll5Xz8PbfeP3K806O5TckqqH?=
 =?us-ascii?Q?gN4oQmeH9CcMzy6RGaAqO23SSgCAGttmPJ9Jwi+h3jNhlJRMzq5hPjsQozCL?=
 =?us-ascii?Q?RkyPTqYVh6kPjzW6lVQCoMWTcEQYbM8F12N6s/KZ4Z9pCnYUWvHkjATpdqk8?=
 =?us-ascii?Q?Ur9/TCzx/PJe5J3pOedQhCQakb10ZBIYtCj03vy6s/XPAqqmuI/TlrRZlBL+?=
 =?us-ascii?Q?jHeeVs1acN+iYvPrhICXCZIhb63mbk/QiCoImB9JBVrA4Db3QmdAxrfEwL3R?=
 =?us-ascii?Q?ilWT4iyFiKrYXjjV6lBxp7k2/cHdIrEQqyVCLTrffDj/dRI4Y3/wTDtQfAp5?=
 =?us-ascii?Q?JK2Jzp7jf21jVvaX71CFqPl11Ehnzayi9H3GinvAp6gmimtwnSFPtFO35Dzp?=
 =?us-ascii?Q?9BosmKPtSAYV8Ofc8BKkQKHPZmjCG0h3uK/adV5WDIu+5FuvnGFjBhExrI/F?=
 =?us-ascii?Q?/GU2gNc2kXvpATKsrXliF2Or3GqrGRj9i+DmodymEy3hrmODYrLSoq97KMcL?=
 =?us-ascii?Q?U/B5zD6BYrMbSjfp39sfE3coB2qRPtZjedKOHkXP7sKlZG1oM52Wa59qdoYe?=
 =?us-ascii?Q?9FUOdyYDg+GuMgIv0k7tW4/091SsiGfANA5refKODhicbgIdi4LNCBBrcQMO?=
 =?us-ascii?Q?sfJ0/z0SLswHkfAfzvwdKiUhDiGVMbujPGidseU7r8qixx4fKIO5k21MbhaY?=
 =?us-ascii?Q?SsjO3WKjqAhAd7fvr1ei55brLdW5z6epy+Y8Dgy5I5sbqyrT8tTV32XoaoiX?=
 =?us-ascii?Q?MwXpzpsvory9/1M7EZU8qR6xrVpAYTUhvbNAZBqq2pcAxCmgWrTUGIywjZ4h?=
 =?us-ascii?Q?DuJigsktdEGthKB1psGCMCFjCPfkSsmaAAaWfw4dG2PnWkqJrmEgoZHsXlWX?=
 =?us-ascii?Q?E800LStGAkzWrPKGrV+wnKacriLuQKv95UjA5AeGmmuz+jUvMhJk7QewuTCg?=
 =?us-ascii?Q?gCjP8AKkRZ0YkWFuGI3gA58LaVfRjChrwbkEiOzlieF6SCTlrtxy2gg8uB5n?=
 =?us-ascii?Q?/af2dbNhthMqM9B0JV2OVGanMR6da0OjZFTlirvejm32loL+LeDmB2P5ZXHD?=
 =?us-ascii?Q?UrBu0pPqaw+gt6+/prgxev5jZBmNTTecD/et5Tin8KQOn5EOnZvlgEQL1Wlr?=
 =?us-ascii?Q?4AYCcI1Il/tAv4uTzFRBn0upDC1tC69p5LrOYKlU10voZUNUp3IFLakcmQid?=
 =?us-ascii?Q?HlqJ5/oW5i1TDaGa62KdygWvu7fqTIsxbY8M8hHbNGQWgGn/VwMAeWvN+bSv?=
 =?us-ascii?Q?oVOPri3cMY4ulN8TsSM1BaVY5Ub3QYC6oPXVNm/efJlsYQwBLKBwansUJnH8?=
 =?us-ascii?Q?g63wUnKyi9/FIV091r/LD+1qBFKFCSf1T0oXjCguiu7glbEsnH9peV4TkA1u?=
 =?us-ascii?Q?fKIxjMXLiG2RXWA/DaBNyZluHhQzCEabV2PP0OAEiGCcAHPSkOt1F1i6A1NK?=
 =?us-ascii?Q?E5m5UsuMasrgF9g8D6PBznU/Cug9sUxP4nLqE+nD7NSygBoVFqDbHS+bXkvg?=
 =?us-ascii?Q?WpsuZeie/jsZOPt3JG4ZZ/IyOj72hMei9El4Tfw/IWWl/QSu/mUvZu103Ov5?=
 =?us-ascii?Q?faaH1tegm2xKdQSM0a5vUu7p2l+bPBUHleBC6HZLNVUSCaUBDEfIa710pqDO?=
 =?us-ascii?Q?qWAetxHNHtQ52rXQxLDTLXyxa5woBmc1JG41r3X6HXK/IO87M5xJYggcq+tV?=
 =?us-ascii?Q?cLD7Ph3HcCRgTT9fSsBwUyvnnAZIDjEneQDpAx7slsCOamOZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3P153MB1848.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d164d33-59fb-459c-fc2e-08dec184963d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 15:27:13.3414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xI1EOk8hXYKgsGZQY0E84a1yZF6srwrmZu8WWUPQ+1HlsbN2Xbjd+IRtJZPlncKlUoVbgBf6loP6ZdeI5jtvRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYP153MB2351
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

Thanks for the review on v5, Stephen.=20

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, June 2, 2026 12:58 AM
> To: Wei Hu <weh@linux.microsoft.com>
> Cc: dev@dpdk.org; Long Li <longli@microsoft.com>; Wei Hu
> <weh@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH v5 1/1] net/mana: add device reset support
>=20
> The RCU use is not really RCU. thread_online/offline are called on every =
rx/tx
> burst, and the "thread" token is the queue index, not a thread. So it is =
a per-
> queue in-use flag paid for on the hottest path, plus a new library depend=
ency,
> to express "wait until no queue is mid-burst" -- which the driver already=
 half
> does by swapping the burst function to mana_*_burst_removed and checking
> dev_state. Please drop the rcu use. If you must drain readers, a per-queu=
e
> atomic flag is lighter and local; the fast path already has the dev_state=
 acquire-
> load it needs.
>=20

I have tested just swapping to mana_*_burst_removed doesn't stop
the application from entering the burst functions. I will add per-queue ato=
mic
flags and spin poll all queue flags in the slower reset path. I think the a=
ctual
fast path cost is nearly identical. However, it does remove the rcu library
dependency. =20

> The data path only needs the atomic, and that part is fine. The lock is
> legitimate for serializing the teardown/rebuild against control ops, but =
the way
> it is used is the problem: it is acquired in mana_intr_handler, released =
in
> mana_reset_enter, re-acquired in mana_reset_thread, and released in
> mana_reset_exit_delay. That cross-function, cross-thread handoff is exact=
ly
> why every function needs __rte_no_thread_safety_analysis.
> Acquire and release the lock in the same function and the annotations all=
 go
> away. Turning off thread-safety analysis needs strong justification and t=
his
> does not have it.

I will remove the __rte_no_thread_safety_analysis from the code. It was add=
ed
when I used spin lock and it caused clang build warnings. Now I have=20
changed it to pthread mutex and clang build is clean without this. =20

> - thread_online is taken at the top of the burst functions but
>   thread_offline is only on some return paths. Any early return that
>   misses it leaves a token non-quiescent and rte_rcu_qsbr_check() in
>   mana_reset_enter spins forever. This is the kind of breakage the per-bu=
rst
>   bracketing invites -- another reason to drop it.
>=20
I have checked mana_rx_burst and mana_tx_burst. There's no actual bug
now -- every return path has thread-offline. Changing rcu to per-queue flag=
s
would still need to reset the flag in every return path. I agree it is kind=
 of
fragile. However, the reset path needs it to make sure there is no thread s=
till
in the fast path before it can start to tear down the resources.=20

I will send out a new revision.

Thanks,
Wei
