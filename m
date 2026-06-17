Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18A6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 18:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24FF540276;
	Wed, 17 Jun 2026 20:14:43 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8782F40268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 20:14:41 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4ggX793qTXzJ46DT;
 Thu, 18 Jun 2026 02:14:13 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id C1CCB40571;
 Thu, 18 Jun 2026 02:14:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 20:14:38 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 17 Jun 2026 20:14:38 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 3/4] test: bpf check that bpf_convert can be JIT'd
Thread-Topic: [PATCH 3/4] test: bpf check that bpf_convert can be JIT'd
Thread-Index: AQHc94YUIomoRvWTX06IrXhcKxFip7ZDGyyQ
Date: Wed, 17 Jun 2026 18:14:38 +0000
Message-ID: <9abf0843912c46b59b6568e80586a0ba@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260608203322.1116296-4-stephen@networkplumber.org>
In-Reply-To: <20260608203322.1116296-4-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.97]
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
> Sent: Monday 8 June 2026 21:29
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH 3/4] test: bpf check that bpf_convert can be JIT'd
>=20
> Add followup in bpf conversion tests to make sure resulting
> code was also run through JIT.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 79d547dc82..f5ab447ff6 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -4569,6 +4569,7 @@ test_bpf_filter(pcap_t *pcap, const char *s)
>  	struct bpf_program fcode;
>  	struct rte_bpf_prm *prm =3D NULL;
>  	struct rte_bpf *bpf =3D NULL;
> +	int ret =3D -1;
>=20
>  	if (pcap_compile(pcap, &fcode, s, 1, PCAP_NETMASK_UNKNOWN)) {
>  		printf("%s@%d: pcap_compile('%s') failed: %s;\n",
> @@ -4592,6 +4593,18 @@ test_bpf_filter(pcap_t *pcap, const char *s)
>  			__func__, __LINE__, rte_errno, strerror(rte_errno));
>  		goto error;
>  	}
> +#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
> +	{
> +		struct rte_bpf_jit jit;
> +
> +		rte_bpf_get_jit(bpf, &jit);
> +		if (jit.func =3D=3D NULL) {
> +			printf("%s@%d: no JIT generated\n", __func__, __LINE__);
> +			goto error;
> +		}
> +	}
> +#endif
> +	ret =3D 0;
>=20
>  error:
>  	if (bpf)
> @@ -4603,7 +4616,7 @@ test_bpf_filter(pcap_t *pcap, const char *s)
>=20
>  	rte_free(prm);
>  	pcap_freecode(&fcode);
> -	return (bpf =3D=3D NULL) ? -1 : 0;
> +	return ret;
>  }
>=20
>  static int
> --
> 2.53.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>

