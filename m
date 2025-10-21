Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2CCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 11:30:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D84B94026A;
	Tue, 21 Oct 2025 13:30:26 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 52309400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 13:30:25 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crVRz00bCz6K6dX;
 Tue, 21 Oct 2025 19:29:02 +0800 (CST)
Received: from dubpeml100002.china.huawei.com (unknown [7.214.144.156])
 by mail.maildlp.com (Postfix) with ESMTPS id 03126140372;
 Tue, 21 Oct 2025 19:30:24 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100002.china.huawei.com (7.214.144.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 12:30:23 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 21 Oct 2025 12:30:23 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: BPF elf examples
Thread-Topic: BPF elf examples
Thread-Index: AQHcQf6Ko95BSpBDZESEHvP+Z95A4bTMd5dA
Date: Tue, 21 Oct 2025 11:30:23 +0000
Message-ID: <bcc95778767444e28a21d2575a41bd9f@huawei.com>
References: <20251020131631.2a6a0de3@phoenix.lan>
In-Reply-To: <20251020131631.2a6a0de3@phoenix.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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


> While looking in more detail at BPF use of VLA, went down a rabbit hole
> because there are no tests and no examples of loading a BPF program using
> the elf_load API's in BPF.
>=20
> Tried using AI to generate tests, and as usual it sort of worked but the
> example code generated won't load or work. Is there anywhere to find work=
ing
> DPDK examples of using BPF load?=20

app/test-pmd/bpf_cmd.c calls rte_bpf_eth_rx_elf_load/ rte_bpf_eth_tx_elf_lo=
ad,
which in turn calls rte_bpf_elf_load().
Though it is a good point, will think can we add a UT for it too.
