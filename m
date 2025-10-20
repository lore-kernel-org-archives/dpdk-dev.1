Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEABCCCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 14:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B109C40276;
	Mon, 20 Oct 2025 16:53:10 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 82E60400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 16:53:09 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cqyyH2msJz6L4t4;
 Mon, 20 Oct 2025 22:49:59 +0800 (CST)
Received: from dubpeml500002.china.huawei.com (unknown [7.214.145.83])
 by mail.maildlp.com (Postfix) with ESMTPS id 92816140373;
 Mon, 20 Oct 2025 22:53:06 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500002.china.huawei.com (7.214.145.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 15:53:06 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Mon, 20 Oct 2025 15:53:06 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 1/2] bpf: add allocation annotations to functions
Thread-Topic: [PATCH v2 1/2] bpf: add allocation annotations to functions
Thread-Index: AQHcQTi8yUX2a4ubQkeic/7SNBg8NLTLH+Yw
Date: Mon, 20 Oct 2025 14:53:06 +0000
Message-ID: <ccddf99e58ff48a1bf44a6308a6595ea@huawei.com>
References: <20251019170040.166372-1-stephen@networkplumber.org>
 <20251019204106.29043-1-stephen@networkplumber.org>
 <20251019204106.29043-2-stephen@networkplumber.org>
In-Reply-To: <20251019204106.29043-2-stephen@networkplumber.org>
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



> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday, October 19, 2025 9:40 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev
> <konstantin.ananyev@huawei.com>
> Subject: [PATCH v2 1/2] bpf: add allocation annotations to functions
>=20
> In commit 80da7efbb4c4 ("eal: annotate allocation functions")
> helper macros were added to provide compiler information to
> detect misuse of alloc/free combinations. This covered many
> of the functions in DPDK but missed the case of data allocated
> by BPF load functions.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.51.0

