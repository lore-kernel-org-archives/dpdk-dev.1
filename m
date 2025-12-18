Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9728D64088
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 07:55:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05099402E3;
	Wed, 17 Dec 2025 08:55:40 +0100 (CET)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) by mails.dpdk.org (Postfix) with ESMTP id 8CD7E40275
 for <dev@dpdk.org>; Wed, 17 Dec 2025 08:55:37 +0100 (CET)
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-5e5478f3dedso4224373137.3
 for <dev@dpdk.org>; Tue, 16 Dec 2025 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765958137;
 x=1766562937; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qN57d7UyXs8QFhzjdw5IKCyE3RpQrWCsQnqX9DdnDz0=;
 b=CDNzKAr+DcUL7ducixwVPIH3WJ6shf8IXVoe+OGUFqLDvm246wecjMdLmNHKeMbHs9
 E12Wx0NaPErxaYPiPMbva8Vmhcwu1wJXO9bGTUBz3BBFnMuZg4B1CPlP2+1JrzRn8H0V
 qK25mzVgJ4OlGAs5uqtLsZ5e3yIDz/L1hrCO2vRoAdJguwKKNq3LdEkDwFWMDzGhAJWk
 TOoQAXzu9kJeObqM/qwUQNS5eBBJkP4B/9LP0s3nEq3arNtP26B3JTFcki8+4M59fT1J
 O2iIDqr7ZY9nQya0l/AiFFnkrwWh47yYRvV8BFe40FUdHiP4HiF0InEIasYguwPhMBB8
 1YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765958137; x=1766562937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qN57d7UyXs8QFhzjdw5IKCyE3RpQrWCsQnqX9DdnDz0=;
 b=vewXpiVC0guNQrd1pBsBoQ1YYoX/4AquGNcSTZJUsEYwTKPxP5isjqFfY/PoZWdaeP
 VK8gAeXMyw89acwHrH7XcEH2p/YIwXtS0li4VCPINHXt4WKAmWY/t7LP8f50rvdMe966
 ef8avW4K/KKwwUlrH7U6BF5NL7+T/haqjlefMi4zevUPj8DVFOcqZUYB7DTdMbpeatD9
 2VTapiBnORJVOKeVDzSgAeLBeB4AmIJzFgDzIkL8Ef/55NUFuWgZK8FQg70W5Q5TbAQB
 +2lHx0dbVt1lJmd+2Jp3MLddZpgnpbaFEheVAp99QBwvZjHGa8yDKhU7Vb5hESMWYZNU
 b2gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRXWSQ8I2tcIIUrOVLpeNg/YcPrcZGYkWwElWpBxagJfmI8Qrhek2LomBBO6TuuivUgYk=@dpdk.org
X-Gm-Message-State: AOJu0Yy++30Vb/dRC63dsLFC0LiTRleGEK+mYhewpdaTlPJVw3ILuBEk
 TdCzEz9IUPAVdwNFQUt9ZzhM22TKNOzoU4Yq4NWOGJThynr2iYG0bEgDYCbtOZgLtE+2Y+1uoKP
 ouDcaRBHoVc68QUfKEkMi1O90RuGHSm6aqSa7assh7A==
X-Gm-Gg: AY/fxX7Ws/DZaM09W3Pvo7YmluR04nbtnLD5+amGfgpbtsZY9lCMDyNYKtEhVmKA34l
 oT6nfcdb6nXKBkbOlQWKclAveQxtYEwdbeahSc7O8T13Eun0YB4SWpJd0eR/VNRmXaiFiuFPx50
 0j8YRT394Vc0Hp/T8KN9A/5Pxwrt4pL6osb4RvOBE1no7snvHYRAKSDtN6cWfh4PE4fBVBWuj/L
 oW6e5lHSxM/VUioT5cUPIL8TQGn6k2XC0QTtUuhNrpXusuNvgFYp6ganuTxWTjdGYWJO0Dn2Q==
X-Google-Smtp-Source: AGHT+IF+PZ51thPpSAmGVwX5uWXJU81enmm1G/WJ3XSSikTwCv2nq0cv+lCCM/alTM0lSZoYAllW8RpIk3gw0E2n93I=
X-Received: by 2002:a67:e707:0:b0:5e4:956c:e7ce with SMTP id
 ada2fe7eead31-5e8274881dcmr5824126137.1.1765958136618; Tue, 16 Dec 2025
 23:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251216182036.77869-4-marat.khalili@huawei.com>
In-Reply-To: <20251216182036.77869-4-marat.khalili@huawei.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 17 Dec 2025 16:54:06 -0800
X-Gm-Features: AQt7F2o0Xzp3QLAwXsU5Lu6l45NHd6k0e6BH-EJVH78HKFNzU7-Dfx--2ZzUXF8
Message-ID: <CAOaVG17N6Qi-Ovk99R9vEQRzVXbeUR6JG6h2smEOAcS8zgUNpQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] bpf: disallow empty program
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev <dev@dpdk.org>,
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006bee490646212bdb"
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

--0000000000006bee490646212bdb
Content-Type: text/plain; charset="UTF-8"

I see no need for docbook style comments for static functions.
Especially in test only code

On Tue, Dec 16, 2025, 10:21 Marat Khalili <marat.khalili@huawei.com> wrote:

> Add tests for some simple cases:
> * Program with no instructions;
> * Program with only EXIT instruction but no return value set;
> * Program with return value set but no EXIT instruction;
> * Minimal valid program with return value set and an EXIT instruction.
>
> Fix found bugs:
> * a program with no instructions was accepted;
> * a program with no EXIT instruction read outside the buffer.
>
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---
>  app/test/test_bpf.c    | 118 +++++++++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_load.c     |   2 +-
>  lib/bpf/bpf_validate.c |  20 +++++--
>  3 files changed, 135 insertions(+), 5 deletions(-)
>
> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index b7c94ba1c7..6ecc49efff 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -34,6 +34,124 @@ test_bpf(void)
>  #include <rte_ip.h>
>
>
> +/* Tests of most simple BPF programs (no instructions, one instruction
> etc.) */
> +
> +/*
> + * Try to load a simple bpf program from the instructions array.
> + *
> + * When `expected_errno` is zero, expect it to load successfully.
> + * When `expected_errno` is non-zero, expect it to fail with this
> `rte_errno`.
> + *
> + * @param nb_ins
> + *   Number of instructions in the `ins` array.
> + * @param ins
> + *   BPF instructions array.
> + * @param expected_errno
> + *   Expected result.
> + * @return
> + *   TEST_SUCCESS on success, error code on failure.
> + */
> +static int
> +bpf_load_test(uint32_t nb_ins, const struct ebpf_insn *ins, int
> expected_errno)
> +{
> +       const struct rte_bpf_prm prm = {
> +               .ins = ins,
> +               .nb_ins = nb_ins,
> +               .prog_arg = {
> +                       .type = RTE_BPF_ARG_RAW,
> +                       .size = sizeof(uint64_t),
> +               },
> +       };
> +
> +       struct rte_bpf *const bpf = rte_bpf_load(&prm);
> +       const int actual_errno = rte_errno;
> +       rte_bpf_destroy(bpf);
> +
> +       if (expected_errno != 0) {
> +               RTE_TEST_ASSERT_EQUAL(bpf, NULL,
> +                       "expect rte_bpf_load() == NULL");
> +               RTE_TEST_ASSERT_EQUAL(actual_errno, expected_errno,
> +                       "expect rte_errno == %d, found %d",
> +                       expected_errno, actual_errno);
> +       } else
> +               RTE_TEST_ASSERT_NOT_EQUAL(bpf, NULL,
> +                       "expect rte_bpf_load() != NULL");
> +
> +       return TEST_SUCCESS;
> +}
> +
> +/*
> + * Try and load completely empty BPF program.
> + * Should fail because there is no EXIT (and also return value is
> undefined).
> + */
> +static int
> +test_no_instructions(void)
> +{
> +       static const struct ebpf_insn ins[] = {};
> +       return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
> +}
> +
> +REGISTER_FAST_TEST(bpf_no_instructions_autotest, true, true,
> test_no_instructions);
> +
> +/*
> + * Try and load a BPF program comprising single EXIT instruction.
> + * Should fail because the return value is undefined.
> + */
> +static int
> +test_exit_only(void)
> +{
> +       static const struct ebpf_insn ins[] = {
> +               {
> +                       .code = (BPF_JMP | EBPF_EXIT),
> +               },
> +       };
> +       return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
> +}
> +
> +REGISTER_FAST_TEST(bpf_exit_only_autotest, true, true, test_exit_only);
> +
> +/*
> + * Try and load a BPF program with no EXIT instruction.
> + * Should fail because of this.
> + */
> +static int
> +test_no_exit(void)
> +{
> +       static const struct ebpf_insn ins[] = {
> +               {
> +                       /* Set return value to the program argument. */
> +                       .code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +                       .src_reg = EBPF_REG_1,
> +                       .dst_reg = EBPF_REG_0,
> +               },
> +       };
> +       return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
> +}
> +
> +REGISTER_FAST_TEST(bpf_no_exit_autotest, true, true, test_no_exit);
> +
> +/*
> + * Try and load smallest possible valid BPF program.
> + */
> +static int
> +test_minimal_working(void)
> +{
> +       static const struct ebpf_insn ins[] = {
> +               {
> +                       /* Set return value to the program argument. */
> +                       .code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
> +                       .src_reg = EBPF_REG_1,
> +                       .dst_reg = EBPF_REG_0,
> +               },
> +               {
> +                       .code = (BPF_JMP | EBPF_EXIT),
> +               },
> +       };
> +       return bpf_load_test(RTE_DIM(ins), ins, 0);
> +}
> +
> +REGISTER_FAST_TEST(bpf_minimal_working_autotest, true, true,
> test_minimal_working);
> +
>  /*
>   * Basic functional tests for librte_bpf.
>   * The main procedure - load eBPF program, execute it and
> diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
> index 556e613762..6983c026af 100644
> --- a/lib/bpf/bpf_load.c
> +++ b/lib/bpf/bpf_load.c
> @@ -88,7 +88,7 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
>         int32_t rc;
>         uint32_t i;
>
> -       if (prm == NULL || prm->ins == NULL ||
> +       if (prm == NULL || prm->ins == NULL || prm->nb_ins == 0 ||
>                         (prm->nb_xsym != 0 && prm->xsym == NULL)) {
>                 rte_errno = EINVAL;
>                 return NULL;
> diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
> index 4f47d6dc7b..23444b3eaa 100644
> --- a/lib/bpf/bpf_validate.c
> +++ b/lib/bpf/bpf_validate.c
> @@ -1827,7 +1827,7 @@ add_edge(struct bpf_verifier *bvf, struct inst_node
> *node, uint32_t nidx)
>  {
>         uint32_t ne;
>
> -       if (nidx > bvf->prm->nb_ins) {
> +       if (nidx >= bvf->prm->nb_ins) {
>                 RTE_BPF_LOG_LINE(ERR,
>                         "%s: program boundary violation at pc: %u, next
> pc: %u",
>                         __func__, get_node_idx(bvf, node), nidx);
> @@ -1886,14 +1886,20 @@ get_prev_node(struct bpf_verifier *bvf, struct
> inst_node *node)
>   * Control Flow Graph (CFG).
>   * Information collected at this path would be used later
>   * to determine is there any loops, and/or unreachable instructions.
> + * PREREQUISITE: there is at least one node.
>   */
>  static void
>  dfs(struct bpf_verifier *bvf)
>  {
>         struct inst_node *next, *node;
>
> -       node = bvf->in;
> -       while (node != NULL) {
> +       RTE_ASSERT(bvf->nb_nodes != 0);
> +       /*
> +        * Since there is at least one node, node with index 0 always
> exists;
> +        * it is our program entry point.
> +        */
> +       node = &bvf->in[0];
> +       do {
>
>                 if (node->colour == WHITE)
>                         set_node_colour(bvf, node, GREY);
> @@ -1923,7 +1929,7 @@ dfs(struct bpf_verifier *bvf)
>                         }
>                 } else
>                         node = NULL;
> -       }
> +       } while (node != NULL);
>  }
>
>  /*
> @@ -2062,6 +2068,12 @@ validate(struct bpf_verifier *bvf)
>         if (rc != 0)
>                 return rc;
>
> +       if (bvf->nb_nodes == 0) {
> +               RTE_BPF_LOG_LINE(ERR, "%s(%p) the program is empty",
> +                       __func__, bvf);
> +               return -EINVAL;
> +       }
> +
>         dfs(bvf);
>
>         RTE_LOG(DEBUG, BPF, "%s(%p) stats:\n"
> --
> 2.43.0
>
>

--0000000000006bee490646212bdb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I see no need for docbook style comments for static funct=
ions.<div dir=3D"auto">Especially in test only code</div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Dec 16, 2025, 10:21 Marat Khalili &lt;<a href=3D"mailto:marat.k=
halili@huawei.com">marat.khalili@huawei.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Add tests for some simple cases:=
<br>
* Program with no instructions;<br>
* Program with only EXIT instruction but no return value set;<br>
* Program with return value set but no EXIT instruction;<br>
* Minimal valid program with return value set and an EXIT instruction.<br>
<br>
Fix found bugs:<br>
* a program with no instructions was accepted;<br>
* a program with no EXIT instruction read outside the buffer.<br>
<br>
Signed-off-by: Marat Khalili &lt;<a href=3D"mailto:marat.khalili@huawei.com=
" target=3D"_blank" rel=3D"noreferrer">marat.khalili@huawei.com</a>&gt;<br>
Acked-by: Konstantin Ananyev &lt;<a href=3D"mailto:konstantin.ananyev@huawe=
i.com" target=3D"_blank" rel=3D"noreferrer">konstantin.ananyev@huawei.com</=
a>&gt;<br>
---<br>
=C2=A0app/test/test_bpf.c=C2=A0 =C2=A0 | 118 ++++++++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0lib/bpf/bpf_load.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0lib/bpf/bpf_validate.c |=C2=A0 20 +++++--<br>
=C2=A03 files changed, 135 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c<br>
index b7c94ba1c7..6ecc49efff 100644<br>
--- a/app/test/test_bpf.c<br>
+++ b/app/test/test_bpf.c<br>
@@ -34,6 +34,124 @@ test_bpf(void)<br>
=C2=A0#include &lt;rte_ip.h&gt;<br>
<br>
<br>
+/* Tests of most simple BPF programs (no instructions, one instruction etc=
.) */<br>
+<br>
+/*<br>
+ * Try to load a simple bpf program from the instructions array.<br>
+ *<br>
+ * When `expected_errno` is zero, expect it to load successfully.<br>
+ * When `expected_errno` is non-zero, expect it to fail with this `rte_err=
no`.<br>
+ *<br>
+ * @param nb_ins<br>
+ *=C2=A0 =C2=A0Number of instructions in the `ins` array.<br>
+ * @param ins<br>
+ *=C2=A0 =C2=A0BPF instructions array.<br>
+ * @param expected_errno<br>
+ *=C2=A0 =C2=A0Expected result.<br>
+ * @return<br>
+ *=C2=A0 =C2=A0TEST_SUCCESS on success, error code on failure.<br>
+ */<br>
+static int<br>
+bpf_load_test(uint32_t nb_ins, const struct ebpf_insn *ins, int expected_e=
rrno)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_bpf_prm prm =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.ins =3D ins,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.nb_ins =3D nb_ins,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.prog_arg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.type =3D RTE_BPF_ARG_RAW,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.size =3D sizeof(uint64_t),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_bpf *const bpf =3D rte_bpf_load(&amp=
;prm);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const int actual_errno =3D rte_errno;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_bpf_destroy(bpf);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (expected_errno !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_TEST_ASSERT_EQU=
AL(bpf, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;expect rte_bpf_load() =3D=3D NULL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_TEST_ASSERT_EQU=
AL(actual_errno, expected_errno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;expect rte_errno =3D=3D %d, found %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0expected_errno, actual_errno);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_TEST_ASSERT_NOT=
_EQUAL(bpf, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;expect rte_bpf_load() !=3D NULL&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return TEST_SUCCESS;<br>
+}<br>
+<br>
+/*<br>
+ * Try and load completely empty BPF program.<br>
+ * Should fail because there is no EXIT (and also return value is undefine=
d).<br>
+ */<br>
+static int<br>
+test_no_instructions(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static const struct ebpf_insn ins[] =3D {};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return bpf_load_test(RTE_DIM(ins), ins, EINVAL)=
;<br>
+}<br>
+<br>
+REGISTER_FAST_TEST(bpf_no_instructions_autotest, true, true, test_no_instr=
uctions);<br>
+<br>
+/*<br>
+ * Try and load a BPF program comprising single EXIT instruction.<br>
+ * Should fail because the return value is undefined.<br>
+ */<br>
+static int<br>
+test_exit_only(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static const struct ebpf_insn ins[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.code =3D (BPF_JMP | EBPF_EXIT),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return bpf_load_test(RTE_DIM(ins), ins, EINVAL)=
;<br>
+}<br>
+<br>
+REGISTER_FAST_TEST(bpf_exit_only_autotest, true, true, test_exit_only);<br=
>
+<br>
+/*<br>
+ * Try and load a BPF program with no EXIT instruction.<br>
+ * Should fail because of this.<br>
+ */<br>
+static int<br>
+test_no_exit(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static const struct ebpf_insn ins[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Set return value to the program argument. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.src_reg =3D EBPF_REG_1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.dst_reg =3D EBPF_REG_0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return bpf_load_test(RTE_DIM(ins), ins, EINVAL)=
;<br>
+}<br>
+<br>
+REGISTER_FAST_TEST(bpf_no_exit_autotest, true, true, test_no_exit);<br>
+<br>
+/*<br>
+ * Try and load smallest possible valid BPF program.<br>
+ */<br>
+static int<br>
+test_minimal_working(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static const struct ebpf_insn ins[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Set return value to the program argument. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.code =3D (EBPF_ALU64 | EBPF_MOV | BPF_X),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.src_reg =3D EBPF_REG_1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.dst_reg =3D EBPF_REG_0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.code =3D (BPF_JMP | EBPF_EXIT),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return bpf_load_test(RTE_DIM(ins), ins, 0);<br>
+}<br>
+<br>
+REGISTER_FAST_TEST(bpf_minimal_working_autotest, true, true, test_minimal_=
working);<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Basic functional tests for librte_bpf.<br>
=C2=A0 * The main procedure - load eBPF program, execute it and<br>
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c<br>
index 556e613762..6983c026af 100644<br>
--- a/lib/bpf/bpf_load.c<br>
+++ b/lib/bpf/bpf_load.c<br>
@@ -88,7 +88,7 @@ rte_bpf_load(const struct rte_bpf_prm *prm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int32_t rc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t i;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (prm =3D=3D NULL || prm-&gt;ins =3D=3D NULL =
||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (prm =3D=3D NULL || prm-&gt;ins =3D=3D NULL =
|| prm-&gt;nb_ins =3D=3D 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (prm-&gt;nb_xsym !=3D 0 &amp;&amp; prm-&gt;xsym =3D=3D NULL)) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_errno =3D EINVA=
L;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c<br>
index 4f47d6dc7b..23444b3eaa 100644<br>
--- a/lib/bpf/bpf_validate.c<br>
+++ b/lib/bpf/bpf_validate.c<br>
@@ -1827,7 +1827,7 @@ add_edge(struct bpf_verifier *bvf, struct inst_node *=
node, uint32_t nidx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t ne;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nidx &gt; bvf-&gt;prm-&gt;nb_ins) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (nidx &gt;=3D bvf-&gt;prm-&gt;nb_ins) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_BPF_LOG_LINE(ER=
R,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;%s: program boundary violation at pc: %u, next pc: %u&quot=
;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 __func__, get_node_idx(bvf, node), nidx);<br>
@@ -1886,14 +1886,20 @@ get_prev_node(struct bpf_verifier *bvf, struct inst=
_node *node)<br>
=C2=A0 * Control Flow Graph (CFG).<br>
=C2=A0 * Information collected at this path would be used later<br>
=C2=A0 * to determine is there any loops, and/or unreachable instructions.<=
br>
+ * PREREQUISITE: there is at least one node.<br>
=C2=A0 */<br>
=C2=A0static void<br>
=C2=A0dfs(struct bpf_verifier *bvf)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct inst_node *next, *node;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D bvf-&gt;in;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (node !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_ASSERT(bvf-&gt;nb_nodes !=3D 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Since there is at least one node, node with =
index 0 always exists;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * it is our program entry point.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0node =3D &amp;bvf-&gt;in[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (node-&gt;colour=
 =3D=3D WHITE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 set_node_colour(bvf, node, GREY);<br>
@@ -1923,7 +1929,7 @@ dfs(struct bpf_verifier *bvf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 node =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} while (node !=3D NULL);<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -2062,6 +2068,12 @@ validate(struct bpf_verifier *bvf)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc !=3D 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bvf-&gt;nb_nodes =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_BPF_LOG_LINE(ER=
R, &quot;%s(%p) the program is empty&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__, bvf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dfs(bvf);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_LOG(DEBUG, BPF, &quot;%s(%p) stats:\n&quot;=
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000006bee490646212bdb--
