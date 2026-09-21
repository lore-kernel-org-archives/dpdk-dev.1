Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4838BC982E1
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5649A4029B;
	Mon, 21 Sep 2026 11:32:25 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1B7C940BA4
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:32:23 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RTbJRqA1hLtKcgzBeJB/BrgrVr4x/U+Go2mZvS8jBFE=;
 b=fzCJXxlrM/uZVrJgzBIvCSB1kcI7cGofp6xnvm8x0V7L+LxZy4wZ31YVby7w+/CwW6lrWN+Ed
 uUo3wwE9jAe+fydVdpFF9BBd6J++8UvIeWp1NJlXZ1sBEcJ87zmNUpKRuas3jRnAGTpeZcaNjzX
 8kb1uG48dmRhDF8UMif5ykI=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hpJ0F2cBCzHnGh7;
 Mon, 21 Sep 2026 17:31:57 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id 926C240571;
 Mon, 21 Sep 2026 17:32:21 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 10:32:21 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Mon, 21 Sep 2026 10:32:20 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>, "dev@dpdk.org" <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [PATCH 1/1] test/bpf: remove redundant library guard
Thread-Topic: [PATCH 1/1] test/bpf: remove redundant library guard
Thread-Index: AQHdJLmOb94WkMm5rUKWhsnt77MuKLbY4lmAgAAsGMA=
Date: Mon, 21 Sep 2026 09:32:20 +0000
Message-ID: <a4b3ff913c894845996b91a03c1cb88b@huawei.com>
References: <20260805090350.37661-1-marat.khalili@huawei.com>
 <40f46de2e8374938bb36eb428f45153f@huawei.com>
In-Reply-To: <40f46de2e8374938bb36eb428f45153f@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.144.44]
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



> The app/test/meson.build already adds 'bpf' as a dependency to test_bpf.c=
.
> If the bpf library is disabled, the test source file is excluded from
> the build entirely.
>=20
> Therefore, the RTE_LIB_BPF guard is dead code and can be removed.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  app/test/test_bpf.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 3205afaa63..88ee8ec224 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -15,24 +15,12 @@
>  #include <rte_random.h>
>  #include <rte_byteorder.h>
>  #include <rte_errno.h>
> -
> -#include "test.h"
> -
> -#if !defined(RTE_LIB_BPF)
> -
> -static int
> -test_bpf(void)
> -{
> -	printf("BPF not supported, skipping test\n");
> -	return TEST_SKIPPED;
> -}
> -
> -#else
> -
>  #include <rte_bpf.h>
>  #include <rte_ether.h>
>  #include <rte_ip.h>
>=20
> +#include "test.h"
> +
>=20
>  /* Tests of most simple BPF programs (no instructions, one instruction e=
tc.) */
>=20
> @@ -3744,7 +3732,6 @@ test_bpf(void)
>  	return rc;
>  }
>=20
> -#endif /* !RTE_LIB_BPF */
>=20
>  REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
>=20
> --
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> 2.43.0

