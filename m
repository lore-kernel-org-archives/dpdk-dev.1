Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641AC55184
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 01:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E5E040144;
	Wed,  5 Aug 2026 03:22:41 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11022091.outbound.protection.outlook.com [52.101.43.91])
 by mails.dpdk.org (Postfix) with ESMTP id D6ACB4003C;
 Wed,  5 Aug 2026 03:22:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKvFdyjjy55amcCr8JnA0eC3unOhADxPG4xeGV1zTeVvDE/cCMHSilZnv0HYvcS1u+NssI+5eowT0HsmUtwk4ndVBNzhg0gXT5c5uLlT9NPbGttfYl2ZgvWf5hys7rjAPlHMGkPfwiN7uahflCiK2vnV6HiT+hlZlugZ+gU2rzRijoBFzinq+RXWYECKgK2vcszqPOg8DLhHBgxEEQ4jEvNkvHCxOdluOUn5LS/fMVELAwbXzADN9zg1i2KCjJ+YgLy5yT7Xij6018cFdpFuIabMvB0bK6cQN+I5FuG8J5SGIpyZT55ueRQA9CNUPnncWlFq0UtVi6AaQQi+93dIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zXFNkaPJqobRrS6YPXcNaRlLsT7Btb0jBreNXPP2Bk=;
 b=VLmC17RdSBNk+gZsJyTzjckYzsEoLEbWNbqk+9ksGEFQOi6EHaXsJxebxeSwcrr7hzf07x0ZHdaEpRTUgC0vHgeL3QfQfFCJg2Wxbg5+9qBAVd37qNORmgSUH/OsJzfVnZE0JOLSIHlFuXK3c0bLU/3B/cg82lX+h5Cpuq29PuZRJm8N9BKvMeMsvFPhw/ovI/Xx5TPyEPF8A+E9bEP5mTWWMcIkRXcUaLt+gmAowgi8KR/3z1EcZEQg3X0un2WkCAHyLqUuApnA7rXl7N/NAYDV+khVtWhO0cl6uTzUZCJKyh7Dzj3va8ZXEuyKG+6faqUpUExQtoID141MYPsdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zXFNkaPJqobRrS6YPXcNaRlLsT7Btb0jBreNXPP2Bk=;
 b=XuU1H4f1ZQQ15aFK3CgZbRAsEMCaJhJFIddGhm9EY7vPriwLLLfHsMDPkuQ32aqf022r4Qh4JCyVoojzFTcWEHPwgaA6DBqfpuSvq3jDB46Af9oDpvw9i35NiVBSBR2uK/VYwWBoq8b+Z7xGe3r7xMIYOkY0FRtz8lRbQkdtkNI=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6682.namprd21.prod.outlook.com (2603:10b6:806:4a6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.5; Wed, 5 Aug 2026
 01:22:35 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%6]) with mapi id 15.21.0315.001; Wed, 5 Aug 2026
 01:22:35 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Wei Hu <weh@microsoft.com>
Subject: RE: [EXTERNAL] [RFC 03/32] bus/vmbus: fix ring buffer ordering on
 weakly ordered CPUs
Thread-Topic: [EXTERNAL] [RFC 03/32] bus/vmbus: fix ring buffer ordering on
 weakly ordered CPUs
Thread-Index: AQHdH4O2JS/iYaFBGkGrr1Ilr4g35raOsq0w
Date: Wed, 5 Aug 2026 01:22:34 +0000
Message-ID: <SA1PR21MB6683A8BB130998008CCD4C88CED32@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-4-stephen@networkplumber.org>
In-Reply-To: <20260729175715.165120-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a175d620-dcd9-4927-90b4-40d670129100;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-05T01:22:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6682:EE_
x-ms-office365-filtering-correlation-id: 873bbcd6-a499-4178-73ea-08def29007a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|7146999003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: AbVgN1qPcpLgsT2prYziKkYs2x6pbCI56tDS02Q12GNiwjnwRgXHUk8VkmIjn12t4vo4TcrPP9LpO6pyO8GSNaiP4SQuRCpB8IH0czO64MHywEX+tc89FLdfGmM2NrLMF+Akc1Ko9muS0rkKXZNaieWSE9Be3UA4ESHMYLJyiglntRHznfMa0yQGTDKaGFuAdlv1m5X/XfoKcQgPusA7gh/9xW3HmAJHJWlNw3JrHqaYpCCOOyy/7pEUbpFEXbfk6G4ghXGYlxPA/FU7zEDTnU5Wlcbx/fIEorcbzrWyeleQDVxzKyr+D/rIyyzNejQ6so7nhqiIm5bZbEMUnqm8+Sl5h+8td4JOz69aWvaBuD0AVoPKJ2Hhinmri3rR2Zo7zNwOd5kbq0pyrfsIJK7kzUFvFav0Oxk+up9MJC2eWSSD+06QV/Hcmj/J7q4qHFzx7GFIlj63Blu/tJM3pga7OJZt8EGORjCfV5xt9B4I5+9nYq8Cat2lNZDMj5thiW7Me1Duahi4OkTOnenDcW5VLU1dO3BUvJr+PrpshUdNEm8qCyOccs6bAQzcUez6p2qhSLtCbQuc1mCJKLPtvEYWySAJD+PW8syQYtOyGAmJuHM0jy7L7uQ+W+qNrSHcznS/VEH5jZuaL/cCN/5VNTKbhVPFY/NFGrgxaly6inR8qea1NXT1BRxQU+ZMeLsqXMFoqYGK7STs4Fv3ON0y5akSDO4gkQ2GaYQWqvkWndwuOxo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR21MB6683.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(7146999003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U/XlfnGRuxHZt0pqxbqSYB8xFAaXxAbHPslX7zgbZU1OqUJcMZ0U+dmKN4Ap?=
 =?us-ascii?Q?mvnsAK5R9mQRGIXM2zoA7RVO1dCDZE11yU52km6YJfIX52gVrsHsUwcmOABE?=
 =?us-ascii?Q?E/jhzjILqarXeFUvLI5hzqlW67RoB78rlZrtQKcpEVWzJ0R0p4ffRPw2Sk30?=
 =?us-ascii?Q?friB5CgCWnidPz0iPR0ofGkM4krxaNHwRCZWTou0/MSRstp3/15+G2hasMqK?=
 =?us-ascii?Q?zyswr80V8lFTp16EoT9Q0NGD8KLVk/lKp69ke5PTyFPq3QFGUiYW7ZkU5Bq6?=
 =?us-ascii?Q?B6ReuYKxKCfqQia71L/VS9KJ4pw7GNFtoCBqzgCeL4xANzKd+PVN17+M8FWX?=
 =?us-ascii?Q?pmciznKCFBEcPYdjcS3IbZurkNAerFB15+tG+1CkAIGTfrXS+Tf3IAKvP/8P?=
 =?us-ascii?Q?Cv5oplul7/aG4Sr0bBCCsOmiaom1C3CINVDtJb2vbP8eKfATy6mnxXZB8cS6?=
 =?us-ascii?Q?NOgLhuHFbJ8FoH3avgsMP8ye0tP3syGiPc12He2PqxoD6mL78SKRN6o3vCk3?=
 =?us-ascii?Q?hepytKFSzm+28OGxhoJWHjTF2xW13SJNk9hwSHSOrkukNLOsshZH+pXgjunp?=
 =?us-ascii?Q?Eb44tevV+AsrXvYVFfC4HAK8wdHbcMM1pF0AGJtfaGOQFIyr9I7klsChzOo0?=
 =?us-ascii?Q?0ezXbrJkfTLCdUfcdcnH1tILfMIOCg/rV31Xsb25Hc6aicqr0E0WCU/ziDou?=
 =?us-ascii?Q?+nTqB8wfL6FB1azxJVKNkgZRykERC/PX34jQ7iDH1hxVfCgtwDl5qDflmN3b?=
 =?us-ascii?Q?zWoKB2nIjGMwhrxZ12h70cthlb/bT6dl4gKPo4blVwIbdRVxE6JMEB47uPcs?=
 =?us-ascii?Q?QQin2bRBoMqP/N3zTXCBS2kRgkxUzWdlOTkWhW5v50D9E0XjRCZeifPpjz85?=
 =?us-ascii?Q?6SnLT441PNHzRgOnWmqt6jcz9qBoQjYwhWAyB9mFaIDsh1v1uOgnJKmEpXSe?=
 =?us-ascii?Q?4FwgnonF3rGV22rBeUSQ+KkNn/BdNdw2vZY39cmhufZmZ0SIBnXdouPWjk2j?=
 =?us-ascii?Q?XGrISnM9d0O6dBz4Kp13+tpqBGZnBeZ+Yak5F18lVHQwRwQNU2JBC5PHc3Cs?=
 =?us-ascii?Q?GkpzUhpiiY9JBCSZWZyouHtdNJMCcR9qLDyuSOVqzg4n/HeobyAjedR43pTW?=
 =?us-ascii?Q?jq8R2r4McMg1YTf8eRQKsejafa0WPvALVyvGxLV3lC7cq/SYeU3vdB2eHh1P?=
 =?us-ascii?Q?PnN32+se8xlmJ9DIRrMJ+ooCOoD13c6y1pTam1Sml2D/zXKzHaPEl+5KTDls?=
 =?us-ascii?Q?zTMcQej6AQJOoPa9Jci+oBE5ifSmqAAHBv67BSLT8CiGE8PA/otuS44NUqHT?=
 =?us-ascii?Q?hlXmjIcSMpBLbxArutagCMToTJv8QjvxC1ZLWU1p2k0u3xdL36A8HQexWaic?=
 =?us-ascii?Q?8McLMGAQqCShj2zyzK1x28aS1qpW2owCjXuNFi4lfUXMWryJj/+9ueRnRzgh?=
 =?us-ascii?Q?0hOJNCa9J5wrm/ZnojqJAmNQa1svLNBoKGFJ0K3K4+GXGzU1kt3DaamC2pfC?=
 =?us-ascii?Q?xq3Budv4IbJzRNSm3+WEgmfFTG4UxNsh81lHKSwIne+2QsOkRHF/N5Y5de6D?=
 =?us-ascii?Q?pdHCh5NQyKNKmM+ZYtbJH0crvVA4ROyMf+HHh1CN87d9uUcwIlt2CUvQoRiY?=
 =?us-ascii?Q?dKV6UvVkO5SZXy8fQbrjxNFm1/HNLGvGsl8tqnXXcBCG8DBGIpxUebAOnmXD?=
 =?us-ascii?Q?p6ise9niSdCCYIZ470CgJmGc2blou6VHmQLfnnPYejbm9z4I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873bbcd6-a499-4178-73ea-08def29007a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2026 01:22:35.0170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHUcZv6h/v8fmM5U6V/Kb+1RSXdpd1WknwG9Id+1FBNaEFFq4MlmpwsCd0Rx3IET6GdXJ4xtxFnBFg2Yuqg60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6682
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

> Subject: [EXTERNAL] [RFC 03/32] bus/vmbus: fix ring buffer ordering on we=
akly
> ordered CPUs
>=20
> The read index update in vmbus_rxbr_read() was only protected by a compil=
er
> barrier. On a weakly ordered architecture the store of rindex can become =
visible
> to the host before the data copy completes, allowing the host to reuse an=
d
> overwrite ring data still being read. Use a release store for the read in=
dex.
>=20
> The barrier in rte_vmbus_chan_signal_tx() must order the earlier ring ind=
ex
> update against the load of the host interrupt mask, and a write barrier d=
oes not
> order stores against loads. Use a full fence, which matches virt_mb() in =
the
> equivalent Linux and FreeBSD code.
>=20
> Neither change affects generated code on x86.
>=20
> Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/bus/vmbus/vmbus_bufring.c | 11 +++++++----
> drivers/bus/vmbus/vmbus_channel.c |  4 ++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/bus/vmbus/vmbus_bufring.c
> b/drivers/bus/vmbus/vmbus_bufring.c
> index fcb97287dc..f622869974 100644
> --- a/drivers/bus/vmbus/vmbus_bufring.c
> +++ b/drivers/bus/vmbus/vmbus_bufring.c
> @@ -237,10 +237,13 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void *data,
> size_t dlen, size_t skip)
>  	 */
>  	rindex =3D vmbus_br_idxinc(rindex, sizeof(uint64_t), br_dsize);
>=20
> -	/* Update the read index _after_ the channel packet is fetched.	 */
> -	rte_compiler_barrier();
> -
> -	vbr->rindex =3D rindex;
> +	/*
> +	 * Update the read index after the channel packet is fetched.
> +	 * Release store ensures the host can not observe the new read
> +	 * index before the data copy is complete.
> +	 */
> +	rte_atomic_store_explicit((volatile uint32_t __rte_atomic *)&vbr-
> >rindex,
> +				  rindex, rte_memory_order_release);
>=20
>  	return 0;
>  }
> diff --git a/drivers/bus/vmbus/vmbus_channel.c
> b/drivers/bus/vmbus/vmbus_channel.c
> index 6887fbad46..2648d8e3fd 100644
> --- a/drivers/bus/vmbus/vmbus_channel.c
> +++ b/drivers/bus/vmbus/vmbus_channel.c
> @@ -104,8 +104,8 @@ rte_vmbus_chan_signal_tx(struct rte_vmbus_device
> *dev, const struct vmbus_channe  {
>  	const struct vmbus_br *tbr =3D &chan->txbr;
>=20
> -	/* Make sure all updates are done before signaling host */
> -	rte_smp_wmb();
> +	/* Order ring index update before reading host interrupt mask */
> +	rte_atomic_thread_fence(rte_memory_order_seq_cst);
>=20
>  	/* If host is ignoring interrupts? */
>  	if (tbr->vbr->imask)
> --
> 2.53.0

