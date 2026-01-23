Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA1D72343
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 07:55:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54AC64027A;
	Fri, 23 Jan 2026 08:55:16 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3F5934026F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 08:55:15 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 63C512071A;
 Fri, 23 Jan 2026 08:55:14 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] test/bpf: skip the BPF ELF load tests if net null missing
Date: Fri, 23 Jan 2026 08:55:09 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65693@smartserver.smartshare.dk>
In-Reply-To: <20260122221728.231962-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] test/bpf: skip the BPF ELF load tests if net null missing
Thread-Index: AdyL7O3OYXfyAT26QdeFO63pyl6aTQAUFhgQ
References: <20260122122354.1820368-2-bruce.richardson@intel.com>
 <20260122221728.231962-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Thursday, 22 January 2026 23.17
>=20
> The BPF filtering tests need NULL PMD vdev to work.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

With or without suggested change,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

> ---
>  app/test/test_bpf.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 0e969f9f13..78998c6194 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -3280,7 +3280,15 @@ test_bpf(void)
>=20
>  REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
>=20
> -#ifdef TEST_BPF_ELF_LOAD
> +/*
> + * The BPF elf load tests needs the BPF programs to be successfully
> + * compiled into generated file bpf_test.h. This means having
> + * clang with BPF target and xxd command to encode object.
> + *
> + * Test also needs the NULL PMD to be able to have something
> + * to insert filter onto.
> + */
> +#if defined(RTE_NET_NULL) && defined(TEST_BPF_ELF_LOAD)

nit:
Consider swapping the order:
#if defined(TEST_BPF_ELF_LOAD) && defined(RTE_NET_NULL)

>=20
>  /*
>   * Helper function to write BPF object data to temporary file.
> @@ -3746,11 +3754,11 @@ test_bpf_elf(void)
>  static int
>  test_bpf_elf(void)
>  {
> -	printf("BPF compile not supported, skipping test\n");
> +	printf("BPF compile or NULL PMD not supported, skipping test\n");
>  	return TEST_SKIPPED;
>  }
>=20
> -#endif /* !TEST_BPF_ELF_LOAD */
> +#endif /* !(TEST_BPF_ELF_LOAD && RTE_NULL) */
>=20
>  REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE_OK, ASAN_OK,
> test_bpf_elf);
>=20
> --
> 2.51.0

