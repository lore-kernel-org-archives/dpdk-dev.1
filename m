Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DEBD7876A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 13:04:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 113094029A;
	Fri, 19 Dec 2025 14:04:54 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D92B64026A
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:04:52 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnml1qBYzHnGdH
 for <dev@dpdk.org>; Fri, 19 Dec 2025 21:04:23 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 6863040569
 for <dev@dpdk.org>; Fri, 19 Dec 2025 21:04:52 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 19 Dec 2025 13:04:52 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 19 Dec 2025 13:04:51 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 2/2] bpf: dump additional instructions
Thread-Topic: [PATCH v2 2/2] bpf: dump additional instructions
Thread-Index: AQHccEFPPdE2ivM2tk6seqHWgjjsf7Uo73eA
Date: Fri, 19 Dec 2025 13:04:51 +0000
Message-ID: <fc41314e2dc6481d95b557d83ad4f390@huawei.com>
References: <20251217172037.59170-1-marat.khalili@huawei.com>
 <20251218170914.7737-1-marat.khalili@huawei.com>
 <20251218170914.7737-3-marat.khalili@huawei.com>
In-Reply-To: <20251218170914.7737-3-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.175]
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


> Fix issues with rte_bpf_dump not supporting or printing incorrectly some
> instructions that lib/bpf supports, and add warnings when it doesn't:
>=20
> * Conditional jump with condition between two registers was incorrectly
>   printed by rte_bpf_dump as one with condition between register and
>   immediate. Add missing handling of BPF_X flag.
>=20
> * Call instruction was printed by rte_bpf_dump as conditional jump. Add
>   explicit handling for it.
>=20
> * We only support stx and ldx instructions in BPF_MEM mode, but were not
>   checking the mode in rte_bpf_dump. Check for mode and only print
>   mnemonic if the mode is BPF_MEM, otherwise print an error.
>=20
> * Atomic instructions were not previously supported by rte_bpf_dump. Add
>   necessary handling.
>=20
> * Some instructions have variations with previously unused src_reg or
>   offset fields set to non-zero value. We do not support any of these
>   variations yet, and were printing them as a standard instruction.
>   Print small note after such instructions warning the user that this is
>   a variation.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> --
> 2.43.0

