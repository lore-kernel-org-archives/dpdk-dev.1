Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A570AC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68304402D2;
	Thu,  2 Jul 2026 10:36:19 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 61703402C5
 for <dev@dpdk.org>; Thu,  2 Jul 2026 10:36:18 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4grVZP1bQPzJ468l;
 Thu,  2 Jul 2026 16:35:25 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id C835C40577;
 Thu,  2 Jul 2026 16:36:14 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 10:36:14 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 2 Jul 2026 10:36:14 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 2/2] bpf: silence noisy message
Thread-Topic: [PATCH 2/2] bpf: silence noisy message
Thread-Index: AQHdCandYp+v290kCEWKJzoRjLjBlbZZ5vuQ
Date: Thu, 2 Jul 2026 08:36:14 +0000
Message-ID: <75fa182ed2b64f88bdb0c6c8a729aaea@huawei.com>
References: <20260701223453.104660-1-stephen@networkplumber.org>
 <20260701223453.104660-2-stephen@networkplumber.org>
In-Reply-To: <20260701223453.104660-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.148]
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 1 July 2026 23:35
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH 2/2] bpf: silence noisy message
>=20
> The recent loader change causes a log message every time BPF
> is used. For example, running dpdk-dumpcap cause:
>  BPF: rte_bpf_load_ex(): successfully creates ...
>=20
> This is a debug message and should not normally be needed.
>=20
> Fixes: 55192fe168b9 ("bpf: introduce extensible load API")

The commit message and Fixes tag are not 100% accurate, this message existe=
d before:
https://github.com/DPDK/dpdk/blob/09e4f37ddd0f7d5cc7c696741f31f1582c73a716/=
lib/bpf/bpf_load_elf.c#L331-L333

(In fact I tried to eliminate it, but had to but back at the insistence of =
AI reviewer
and even broke the build in the process...)

So naturally I support downgrading this message. With the commit message co=
rrected,

Acked-by: Marat Khalili <marat.khalili@huawei.com>

>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf_load.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
> index 2fd0ee0720..36f6556fd5 100644
> --- a/lib/bpf/bpf_load.c
> +++ b/lib/bpf/bpf_load.c
> @@ -286,7 +286,7 @@ rte_bpf_load_ex(const struct rte_bpf_prm_ex *prm)
>  		return NULL;
>  	}
>=20
> -	RTE_BPF_LOG_FUNC_LINE(INFO, "successfully creates %p(jit=3D{.func=3D%p,=
.sz=3D%zu});",
> +	RTE_BPF_LOG_FUNC_LINE(DEBUG, "successfully creates %p(jit=3D{.func=3D%p=
,.sz=3D%zu});",
>  		load.bpf, load.bpf->jit.raw, load.bpf->jit.sz);
>  	return load.bpf;
>  }
> --
> 2.53.0

