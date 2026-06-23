Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0555FCDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 13:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EFB840648;
	Tue, 23 Jun 2026 15:57:58 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C1D72402D5
 for <dev@dpdk.org>; Tue, 23 Jun 2026 15:57:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gl67z3bs4zJ46ZM;
 Tue, 23 Jun 2026 21:57:19 +0800 (CST)
Received: from frapema100002.china.huawei.com (unknown [7.182.19.63])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A4BC40590;
 Tue, 23 Jun 2026 21:57:54 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100002.china.huawei.com (7.182.19.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 15:57:36 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Tue, 23 Jun 2026 15:57:36 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH v3 6/6] test/bpf: check that bpf_convert can be JIT'd
Thread-Topic: [PATCH v3 6/6] test/bpf: check that bpf_convert can be JIT'd
Thread-Index: AQHdAZqcViEEbvJHlUCL5465AG3cnbZMI4AA
Date: Tue, 23 Jun 2026 13:57:35 +0000
Message-ID: <c510bf24a3cd492693fc54f0b558656f@huawei.com>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260621162524.82690-1-stephen@networkplumber.org>
 <20260621162524.82690-7-stephen@networkplumber.org>
In-Reply-To: <20260621162524.82690-7-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

Thank you for working on this, please see some comments inline.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday 21 June 2026 17:24
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH v3 6/6] test/bpf: check that bpf_convert can be JIT'd
>=20
> Add followup in bpf conversion tests to make sure resulting
> code was also run through JIT and that JIT produces
> same results as non-JIT.
>=20
> Reduce log output to make it easier to match which
> expression might be causing issues.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/test_bpf.c | 94 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 79 insertions(+), 15 deletions(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 3a88434c3c..973dd7d659 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -8,6 +8,7 @@
>  #include <inttypes.h>
>  #include <unistd.h>
>=20
> +#include <rte_byteorder.h>
>  #include <rte_memory.h>
>  #include <rte_debug.h>
>  #include <rte_hexdump.h>
> @@ -32,6 +33,7 @@ test_bpf(void)
>  #include <rte_bpf.h>
>  #include <rte_ether.h>
>  #include <rte_ip.h>
> +#include <rte_udp.h>
>=20
>=20
>  /* Tests of most simple BPF programs (no instructions, one instruction e=
tc.) */
> @@ -4529,6 +4531,7 @@ test_bpf_match(pcap_t *pcap, const char *str,
>  	int ret =3D -1;
>  	uint64_t rc;
>=20
> +	printf("%s '%s'\n", __func__, str);
>  	if (pcap_compile(pcap, &fcode, str, 1, PCAP_NETMASK_UNKNOWN)) {
>  		printf("%s@%d: pcap_compile(\"%s\") failed: %s;\n",
>  		       __func__, __LINE__,  str, pcap_geterr(pcap));
> @@ -4550,6 +4553,24 @@ test_bpf_match(pcap_t *pcap, const char *str,
>  	}
>=20
>  	rc =3D rte_bpf_exec(bpf, mb);
> +#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)

We are going to have a few of these lines, I think something like
RTE_BPF_JIT_SUPPORTED is warranted.

> +	{
> +		struct rte_bpf_jit jit;
> +
> +		rte_bpf_get_jit(bpf, &jit);

Out of abundance of caution I would also prefill jit with zeroes and check =
the
return code here.

> +		if (jit.func =3D=3D NULL) {
> +			printf("%s@%d: no JIT generated\n", __func__, __LINE__);
> +			goto error;
> +		}
> +
> +		fflush(stdout);
> +		uint64_t rc_jit =3D jit.func(mb);
> +		if (rc_jit !=3D rc) {
> +			printf("%s@%d: JIT return code does not match\n", __func__, __LINE__)=
;
> +			goto error;
> +		}
> +	}
> +#endif
>  	/* The return code from bpf capture filter is non-zero if matched */
>  	ret =3D (rc =3D=3D 0);
>  error:
> @@ -4560,23 +4581,16 @@ test_bpf_match(pcap_t *pcap, const char *str,
>  	return ret;
>  }
>=20
> -/* Basic sanity test can we match a IP packet */
> -static int
> -test_bpf_filter_sanity(pcap_t *pcap)
> +/* Setup mbuf for filter test */
> +static void
> +dummy_ip_prep(void *data, uint16_t plen)
>  {
> -	const uint32_t plen =3D 100;
> -	struct rte_mbuf mb, *m;
> -	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
>  	struct {
>  		struct rte_ether_hdr eth_hdr;
>  		struct rte_ipv4_hdr ip_hdr;
> -	} *hdr;
> +		struct rte_udp_hdr udp_hdr;
> +	} *hdr =3D data;
>=20
> -	memset(&mb, 0, sizeof(mb));
> -	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
> -	m =3D &mb;
> -
> -	hdr =3D rte_pktmbuf_mtod(m, typeof(hdr));
>  	hdr->eth_hdr =3D (struct rte_ether_hdr) {
>  		.dst_addr.addr_bytes =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
>  		.ether_type =3D rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4),
> @@ -4589,13 +4603,32 @@ test_bpf_filter_sanity(pcap_t *pcap)
>  		.src_addr =3D rte_cpu_to_be_32(RTE_IPV4_LOOPBACK),
>  		.dst_addr =3D rte_cpu_to_be_32(RTE_IPV4_BROADCAST),
>  	};
> +	hdr->udp_hdr =3D (struct rte_udp_hdr) {
> +		.src_port =3D rte_rand_max(UINT16_MAX),
> +		.dst_port =3D rte_cpu_to_be_16(9),	/* discard port */
> +		.dgram_len =3D rte_cpu_to_be_16(plen - sizeof(struct rte_ipv4_hdr)),
> +		.dgram_cksum =3D 0,
> +	};
> +}
> +
> +
> +/* Basic sanity test can we match a IP packet */
> +static int
> +test_bpf_filter_sanity(pcap_t *pcap)
> +{
> +	struct rte_mbuf mb =3D { 0 };
> +	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
> +	const uint32_t plen =3D 100;
> +
> +	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
> +	dummy_ip_prep(rte_pktmbuf_mtod(&mb, void *), plen);
>=20
> -	if (test_bpf_match(pcap, "ip", m) !=3D 0) {
> +	if (test_bpf_match(pcap, "ip", &mb) !=3D 0) {
>  		printf("%s@%d: filter \"ip\" doesn't match test data\n",
>  		       __func__, __LINE__);
>  		return -1;
>  	}
> -	if (test_bpf_match(pcap, "not ip", m) =3D=3D 0) {
> +	if (test_bpf_match(pcap, "not ip", &mb) =3D=3D 0) {

Not a new bug, but this condition should be for non-positive, not just zero=
.

>  		printf("%s@%d: filter \"not ip\" does match test data\n",
>  		       __func__, __LINE__);
>  		return -1;
> @@ -4648,10 +4681,15 @@ static const char * const sample_filters[] =3D {
>  static int
>  test_bpf_filter(pcap_t *pcap, const char *s)
>  {
> +	struct rte_mbuf mb =3D { 0 };
> +	uint8_t tbuf[RTE_MBUF_DEFAULT_BUF_SIZE];
> +	const uint32_t plen =3D 100;
>  	struct bpf_program fcode;
>  	struct rte_bpf_prm *prm =3D NULL;
>  	struct rte_bpf *bpf =3D NULL;
> +	int ret =3D -1;
>=20
> +	printf("%s '%s'\n", __func__, s);
>  	if (pcap_compile(pcap, &fcode, s, 1, PCAP_NETMASK_UNKNOWN)) {
>  		printf("%s@%d: pcap_compile('%s') failed: %s;\n",
>  		       __func__, __LINE__, s, pcap_geterr(pcap));
> @@ -4665,8 +4703,10 @@ test_bpf_filter(pcap_t *pcap, const char *s)
>  		goto error;
>  	}
>=20
> +#ifdef DEBUG
>  	printf("bpf convert for \"%s\" produced:\n", s);
>  	rte_bpf_dump(stdout, prm->ins, prm->nb_ins);
> +#endif
>=20
>  	bpf =3D rte_bpf_load(prm);
>  	if (bpf =3D=3D NULL) {
> @@ -4675,6 +4715,30 @@ test_bpf_filter(pcap_t *pcap, const char *s)
>  		goto error;
>  	}
>=20
> +	dummy_mbuf_prep(&mb, tbuf, sizeof(tbuf), plen);
> +	dummy_ip_prep(rte_pktmbuf_mtod(&mb, void *), plen);
> +
> +	uint64_t rc =3D rte_bpf_exec(bpf, &mb);

Would it be hard to check the result against a known correct answer?

> +#if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_ARM64)
> +	{
> +		struct rte_bpf_jit jit;
> +
> +		rte_bpf_get_jit(bpf, &jit);

Same suggestion regarding zeroing jit and check return code here.

> +		if (jit.func =3D=3D NULL) {
> +			printf("%s@%d: no JIT generated\n", __func__, __LINE__);
> +			goto error;
> +		}
> +
> +		fflush(stdout);
> +		uint64_t rc_jit =3D jit.func(&mb);
> +		if (rc_jit !=3D rc) {
> +			printf("%s@%d: JIT return code does not match\n", __func__, __LINE__)=
;
> +			goto error;
> +		}
> +	}
> +#endif
> +	ret =3D 0;
> +

Are `test_bpf_filter` and `test_bpf_filter_sanity` substantially different =
any
more, or could they just be merged?

>  error:
>  	if (bpf)
>  		rte_bpf_destroy(bpf);
> @@ -4685,7 +4749,7 @@ test_bpf_filter(pcap_t *pcap, const char *s)
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

