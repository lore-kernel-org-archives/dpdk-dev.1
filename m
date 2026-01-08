Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC64D185C6
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 11:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54D764028C;
	Thu,  8 Jan 2026 12:10:35 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 75AC740261;
 Thu,  8 Jan 2026 12:10:34 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn2J421vDzJ46jD;
 Thu,  8 Jan 2026 19:10:28 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 05E8D40086;
 Thu,  8 Jan 2026 19:10:33 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 11:10:32 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 8 Jan 2026 11:10:32 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "jerinjacobk@gmail.com"
 <jerinjacobk@gmail.com>, "mb@smartsharesystems.com"
 <mb@smartsharesystems.com>, Ferruh Yigit <ferruh.yigit@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3 6/6] bpf: fix BPF validation w/ conditional jump first
Thread-Topic: [PATCH v3 6/6] bpf: fix BPF validation w/ conditional jump first
Thread-Index: AQHcb39t4yasOFGQY02plUyv3FTVYLVIP5GA
Date: Thu, 8 Jan 2026 11:10:32 +0000
Message-ID: <cb639605b9ae44f58ec9dc2254465b18@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
 <20251217180141.60227-7-marat.khalili@huawei.com>
In-Reply-To: <20251217180141.60227-7-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.123]
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



> When the BPF program was starting with a conditional jump only one
> (true) execution branch of the program was evaluated. Any instructions
> jumped over were not evaluated and could contain invalid operations.
> The root cause was using zero instruction index as a signal for ending
> evaluation when backtracking.
>=20
> Switch from using previous instruction index for tracking execution
> history to a previous instruction pointer. First instruction will not
> have it set, and therefore backtracking _from_ it will end evaluation,
> not backtracking _to_ it like before.
>=20
> Add two tests demonstrating the problem:
> * test_jump_over_invalid_first: loads BPF program with
>   conditional jump over the invalid operation, should not succeed;
> * test_jump_over_invalid_non_first: same program with one extra
>   instruction at the start to demonstrate that it is indeed invalid
>   (and also guard against another kind of regression);
>=20
> Fixes: 6e12ec4c4d6d ("bpf: add more checks")
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

> --
> 2.43.0

