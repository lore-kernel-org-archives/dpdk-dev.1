Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E8AD767FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 13:04:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1804B4026A;
	Fri, 19 Dec 2025 14:04:02 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1865040150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:04:01 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXnlk0LrrzHnGdH;
 Fri, 19 Dec 2025 21:03:30 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 3523D4056B;
 Fri, 19 Dec 2025 21:03:59 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 19 Dec 2025 13:03:58 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 19 Dec 2025 13:03:58 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [PATCH v2 1/2] bpf: add atomic xchg support
Thread-Topic: [PATCH v2 1/2] bpf: add atomic xchg support
Thread-Index: AQHccEFJb7pDn1lviUu63DVy+6TZFrUo7tPA
Date: Fri, 19 Dec 2025 13:03:58 +0000
Message-ID: <6d981cf05ad34f19a0956db69faf99b6@huawei.com>
References: <20251217172037.59170-1-marat.khalili@huawei.com>
 <20251218170914.7737-1-marat.khalili@huawei.com>
 <20251218170914.7737-2-marat.khalili@huawei.com>
In-Reply-To: <20251218170914.7737-2-marat.khalili@huawei.com>
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



> Add support for BPF atomic xchg instruction, and tests for it. This
> instruction can be produced using compiler intrinsics.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/test_bpf.c     | 459 ++++++++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_def.h       |   5 +
>  lib/bpf/bpf_exec.c      |  35 ++-
>  lib/bpf/bpf_jit_arm64.c |  59 ++++--
>  lib/bpf/bpf_jit_x86.c   |  37 +++-
>  lib/bpf/bpf_validate.c  |  22 +-
>  6 files changed, 580 insertions(+), 37 deletions(-)

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.43.0

