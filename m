Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6417CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:35:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB01A40264;
	Fri,  7 Nov 2025 18:35:30 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 499814021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 18:35:29 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d35mR5Nt9zJ46C2;
 Sat,  8 Nov 2025 01:35:03 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 790F11400C8;
 Sat,  8 Nov 2025 01:35:28 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 18:35:28 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 7 Nov 2025 18:35:28 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v4 1/5] bpf: add allocation annotations to functions
Thread-Topic: [PATCH v4 1/5] bpf: add allocation annotations to functions
Thread-Index: AQHcTaVtDmx1f/gwcEqeyXFdvhvxi7TnfhJg
Date: Fri, 7 Nov 2025 17:35:28 +0000
Message-ID: <31a36cef247a4219adfa841485b8ab15@huawei.com>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
 <20251104160843.304044-2-stephen@networkplumber.org>
In-Reply-To: <20251104160843.304044-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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
> Sent: Tuesday 4 November 2025 16:07
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>
> Subject: [PATCH v4 1/5] bpf: add allocation annotations to functions
>=20
> In commit 80da7efbb4c4 ("eal: annotate allocation functions")
> helper macros were added to provide compiler information to
> detect misuse of alloc/free combinations. This covered many
> of the functions in DPDK but missed the case of data allocated
> by BPF load functions.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
>  lib/bpf/rte_bpf.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
> index 80ebb0210f..309d84bc51 100644
> --- a/lib/bpf/rte_bpf.h
> +++ b/lib/bpf/rte_bpf.h
> @@ -18,6 +18,7 @@
>=20
>  #include <rte_common.h>
>  #include <rte_mbuf.h>
> +#include <rte_malloc.h>
>  #include <bpf_def.h>
>=20
>  #ifdef __cplusplus
> @@ -128,7 +129,8 @@ rte_bpf_destroy(struct rte_bpf *bpf);
>   *   - ENOMEM - can't reserve enough memory
>   */
>  struct rte_bpf *
> -rte_bpf_load(const struct rte_bpf_prm *prm);
> +rte_bpf_load(const struct rte_bpf_prm *prm)
> +	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
>=20
>  /**
>   * Create a new eBPF execution context and load BPF code from given ELF
> @@ -152,7 +154,9 @@ rte_bpf_load(const struct rte_bpf_prm *prm);
>   */
>  struct rte_bpf *
>  rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
> -		const char *sname);
> +		const char *sname)
> +	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
> +
>  /**
>   * Execute given BPF bytecode.
>   *
> @@ -228,7 +232,8 @@ struct bpf_program;
>   *   - ENOTSUP - operation not supported
>   */
>  struct rte_bpf_prm *
> -rte_bpf_convert(const struct bpf_program *prog);
> +rte_bpf_convert(const struct bpf_program *prog)
> +	__rte_malloc __rte_dealloc_free;
>=20
>  #ifdef __cplusplus
>  }
> --
> 2.51.0

Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
