Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5229AC88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:27:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF1E542E8D;
	Tue, 15 Sep 2026 21:27:41 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 56DF642E4C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:27:35 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=puKmnutSZ7uccA5TOiMvjzM/Vd6K1WSjXH1+Q5gQSGc=;
 b=MvxRzxt+6+6ooPxUZQYutC8IWmNklfDsDWNSsaYpO+pCVqcg6IIFaEFFfn65Ku/SIg8a4lAwk
 BEXgm3S64Dn258gbXnesilnWSLQEZYYL/u8BXTwt6Pdgi5gv/M15UQ8h+/K7GbCXTGTwv+J9mQK
 aQ+GoyLq5etvQRlrN95emmA=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hksV13kjqzHnGd7;
 Wed, 16 Sep 2026 03:27:21 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 9739A40584;
 Wed, 16 Sep 2026 03:27:34 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 21:27:34 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.046;
 Tue, 15 Sep 2026 21:27:34 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2 0/7] validate-bpf: add standalone validation debug tool
Thread-Topic: [PATCH v2 0/7] validate-bpf: add standalone validation debug tool
Thread-Index: AQHdRFk8/KideuYRIkOw67Dpn3Vs9LbOR12AgAGr9aA=
Date: Tue, 15 Sep 2026 19:27:34 +0000
Message-ID: <905abb0efb254b63b887fb3b66848152@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
 <20260914145418.37353-1-marat.khalili@huawei.com>
 <20260914114229.61d5e94c@phoenix.local>
In-Reply-To: <20260914114229.61d5e94c@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.71.110]
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

Thanks a lot for looking, please see the answers inline below.

> Looks good to me, but AI had some nits to pick.
>=20
> Re: [PATCH v2 0/7] bpf/validate: debug events and validation app
>=20
> Errors
> ------
>=20
> Patch 7/7 (app/validate-bpf: add BPF validation application)
>=20
>   app/validate-bpf/parse_decl.c:
>=20
>     +		arg->value.size *=3D array_length;
>=20
>   array_length comes from take_number() on the --xsym text with no
>   upper bound, and the multiply is not checked for overflow, so a
>   large length silently wraps to a small size that is then reported
>   to the validator as the object size.  Reproduced:
>=20
>     dpdk-validate-bpf --xsym=3D'uint64_t[2305843009213693953] v' \
>         --section=3D.text prog.o
>     Validation succeeded.
>=20
>   8 * 2305843009213693953 wraps to 8, so the tool accepts the
>   declaration and describes an 8-byte object.  Clamp array_length,
>   or check the product, and reject with the usual text error.

Addressed in v3.

> Warnings
> --------
>=20
> Patch 5/7 (bpf/validate: add get current event API)
>=20
>   lib/bpf/bpf_validate_debug.c:
>=20
>     +		return -EINVAL;
>=20
>   in rte_bpf_validate_debug_get_event(), whose return type is
>   enum rte_bpf_validate_debug_event.  Every enumerator in that enum
>   is non-negative, so the compatible type is unsigned and -EINVAL
>   arrives at the caller as 4294967274.  It equals no enumerator,
>   including RTE_BPF_VALIDATE_DEBUG_EVENT_END, so a caller cannot
>   test for it.  Either return
>   RTE_BPF_VALIDATE_DEBUG_EVENT_END for the NULL case and say so in
>   the doc comment, or change the signature to return int with the
>   event in an out-parameter.

Behavior is intentionally not defined and caller is intentionally not requi=
red
to check return value from this API for errors to keep its life easier.
The return value is always valid with the catchpoint callback.

> Patch 7/7
>=20
>   app/validate-bpf/parse_decl.c:
>=20
>     +	void * const val =3D calloc(1, RTE_MAX(1u, arg.value.size));
>     +	RTE_VERIFY(val !=3D 0);
>=20
>   arg.value.size is user-supplied, so an allocation failure driven by
>   the command line aborts with a core dump instead of an error
>   message.  Reproduced:
>=20
>     dpdk-validate-bpf --xsym=3D'uint64_t[18446744073709551615] v' \
>         --section=3D.text prog.o
>     EAL: PANIC in fill_var_xsym():
>     line 427	assert "val !=3D 0" failed
>=20
>   Return an error up through the parse path like the other --xsym
>   failures do.

Addressed in v3.

>=20
>   app/validate-bpf/main.c:
>=20
>     +	RTE_VERIFY(rte_eal_init(eal_init_argc, eal_init_argv) =3D=3D
>     +		eal_init_argc - 1);
>=20
>   rte_eal_init() returns -1 for ordinary environmental failures such
>   as a missing runtime directory or insufficient permissions.  For a
>   command-line tool that should be a message and a non-zero exit, not
>   rte_panic().  Same for
>=20
>     +	RTE_VERIFY(rte_eal_cleanup() =3D=3D 0);

Addressed in v3.

>   app/validate-bpf/eal_init_args.c:
>=20
>     +#define RTE_EAL_INIT_ARG_SIZE_MAX sizeof("--log-level=3Dlib.eal:warn=
ing")
>=20
>   and RTE_EAL_INIT_ARGS / RTE_EAL_INIT_ARGC below it.  The RTE_
>   prefix is reserved for the libraries; an application should not
>   define into it.  Drop the prefix.

Addressed in v3.

> Info
> ----
>=20
> Patch 5/7
>=20
>   debug->current_event is set only in debug_send_event().  A
>   breakpoint callback reached through debug_trigger_breakpoints()
>   therefore sees whatever event fired last.  The doc comment says the
>   value is undefined when no event is being processed, so this is
>   consistent, but a callback shared between a breakpoint and a
>   catchpoint will read a stale event rather than an obviously invalid
>   one.

There is currently no use case for this, and undefined behaviour allows
implementing this in the future.

>   rte_bpf_validate_debug_get_event() is new public experimental API
>   and gets no release note.  7/7 adds a release note, but only for
>   the application.

Technically true, but practically I suspect there are no users of this API
yet, so noise in release notes is kept to the minimum.

> Patch 7/7
>=20
>   In --debug mode the result is printed twice: debug.c prints
>   "Validation succeeded." to stdout from the validation-success
>   catchpoint, and main.c prints it again to stderr.

There is a prompt between them, so the result looks ok.

>   Array declarations are written as "uint64_t[4] v", not the C
>   "uint64_t v[4]".  The C spelling is rejected with
>=20
>     at offset 10: expect '(' or text end
>=20
>   which does not point at the real problem.  Worth either accepting
>   the C form or naming the expected form in the message.  The
>   documented form is in --help, so this is a diagnostics nit.

Yes, this is a documented current limitation, patches are welcome.

>   "uint64_t[0] v" is accepted and yields value.size 0 while calloc
>   still allocates one byte.  Probably worth rejecting a zero length.

Decisions on validity of external symbols are left to the BPF loader.

> Patch 7/7 (app/validate-bpf: add BPF validation application)
>=20
>   app/validate-bpf/parse_decl.c:
>=20
>     +		arg->value.size *=3D array_length;
>=20
>   array_length comes from take_number() on the --xsym text with no
>   upper bound, and the multiply is not checked for overflow, so a
>   large length silently wraps to a small size that is then reported
>   to the validator as the object size.  Reproduced:
>=20
>     dpdk-validate-bpf --xsym=3D'uint64_t[2305843009213693953] v' \
>         --section=3D.text prog.o
>     Validation succeeded.
>=20
>   8 * 2305843009213693953 wraps to 8, so the tool accepts the
>   declaration and describes an 8-byte object.  Clamp array_length,
>   or check the product, and reject with the usual text error.

Addressed in v3.

> Build fails on FreeBSD
// snip
> ../app/validate-bpf/parse_decl.c:392:33: error: 'array_length' may be use=
d uninitialized [-
> Werror=3Dmaybe-uninitialized]

Hopefully addressed in v3.
