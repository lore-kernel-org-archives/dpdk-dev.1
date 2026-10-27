Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433F606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 16:07:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A27E3400D7;
	Tue, 27 Oct 2026 17:07:38 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id A826E400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 17:07:37 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9A2D44D3D0; Tue, 27 Oct 2026 17:07:37 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 2080] crypto/openssl: BN_CTX memory grows with
 every modexp and modinv op
Date: Tue, 27 Oct 2026 16:07:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-2080-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2080

            Bug ID: 2080
           Summary: crypto/openssl: BN_CTX memory grows with every modexp
                    and modinv op
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Created attachment 428
  --> https://bugs.dpdk.org/attachment.cgi?id=3D428&action=3Dedit
AI proposed patch

Every modexp and modinv op processed by the `crypto_openssl` PMD permanently
adds two BIGNUMs to the session's `BN_CTX`. A long-lived session therefore
grows the process heap by a fixed amount per op (1124 bytes per 2048-bit
modexp, 628 per modinv) until the session is freed. An application that kee=
ps
one of these sessions and runs many ops on it will eventually see ops compl=
ete
with `RTE_CRYPTO_OP_STATUS_ERROR` once allocation fails inside `BN_mod_exp(=
)`,
or the kernel kills the process if no memory limit is set.

The cause is in `process_openssl_modexp_op()` and `process_openssl_modinv_o=
p()`
in `drivers/crypto/openssl/rte_openssl_pmd.c`. Each calls `BN_CTX_get()` tw=
ice
on the session context without its own `BN_CTX_start()`/`BN_CTX_end()` pair.
The only open frame on that context is the one
`openssl_set_asym_session_parameters()` opens at session creation, and
`openssl_reset_asym_session()` closes it at session release, so every op ta=
kes
two new entries from the pool and none are ever reused. `BN_clear()` only
zeroes the values. The default build is affected, no special input is invol=
ved,
and ASan/LSan report nothing because the memory is released with the sessio=
n.
The attached reproducer runs 2 =C3=97 10000 modexp ops on one session and s=
hows
about 11 MB of growth per batch, nearly all of it returned by
`rte_cryptodev_asym_session_free()`. `dpdk-test-crypto-perf --optype modex
--total-ops 1000000` peaks around 631 MiB RSS for the same reason. The atta=
ched
patch wraps each op in its own nested `BN_CTX_start()`/`BN_CTX_end()` frame,
which brings per-op growth to zero. It would carry `Fixes: 3e9d6bd447fb` and
`Cc: stable`, like the earlier per-op leak fixes in this driver.

This is an ordinary bug, not a security issue: the ops that trigger it are
well-formed, nothing in DPDK lets an
outside party drive modexp or modinv ops on a `crypto_openssl` session, and=
 an
application's own ordinary load hits
it just the same.

## Details

Every modexp or modinv op processed by the `crypto_openssl` PMD takes two
BIGNUMs from the session's `BN_CTX` and
never returns them. The memory is held by the session and grows by a fixed
amount per op until the session is freed.

Commit tested: `9a45341f18a1ab47af7123e63d942b90c1b79f38` (26.11-rc1), defa=
ult
build (`/src/build`), OpenSSL 3.5.5.
A small program creates one `RTE_CRYPTO_ASYM_XFORM_MODEX` session (2048-bit
modulus, exponent 65537), reuses one op
and one result buffer for N successful exponentiations, and reads glibc's
`mallinfo2().uordblks` before the ops,
after them, and after `rte_cryptodev_asym_session_free()`:

| ops on the session | heap growth | returned by freeing the session |
|---|---|---|
| 1000 | 1 127 120 bytes | 1 100 720 bytes |
| 2000 | 2 251 120 bytes | 2 224 720 bytes |
| 20000 | 22 483 120 bytes | 22 456 720 bytes |

That is 1124 bytes per op. The same is visible without any custom code: the
in-tree perf tool run as below peaks at
about 631 MiB RSS, against about 106 MiB with `--total-ops 100000`:

```
/src/build/app/dpdk-test-crypto-perf -l 0-1 --no-huge -m 512 --no-pci --vdev
crypto_openssl -- \
    --devtype crypto_openssl --ptest throughput --optype modex --total-ops
1000000 --silent
```

The ASan build prints nothing for this: the memory stays owned by the sessi=
on
and is released with it, so
LeakSanitizer has nothing to report.

The op handler, `drivers/crypto/openssl/rte_openssl_pmd.c:2263`:

```c
static int
process_openssl_modexp_op(struct rte_crypto_op *cop,
                struct openssl_asym_session *sess)
{
        struct rte_crypto_asym_op *op =3D cop->asym;
        BIGNUM *base =3D BN_CTX_get(sess->u.e.ctx);
        BIGNUM *res =3D BN_CTX_get(sess->u.e.ctx);
        =E2=80=A6
        base =3D BN_bin2bn((const unsigned char *)op->modex.base.data,
                        op->modex.base.length, base);

        if (BN_mod_exp(res, base, sess->u.e.exp,
                                sess->u.e.mod, sess->u.e.ctx)) {
        =E2=80=A6
        BN_clear(res);
        BN_clear(base);

        return 0;
}
```

`BN_CTX_get()` hands out the next unused BIGNUM of the context's pool. A BI=
GNUM
obtained this way becomes reusable
only when `BN_CTX_end()` closes the frame that the enclosing `BN_CTX_start(=
)`
opened. For `sess->u.e.ctx` there is
exactly one such frame, and it spans the whole life of the session:

- `openssl_set_asym_session_parameters()` opens it when the session is crea=
ted
  (`drivers/crypto/openssl/rte_openssl_pmd_ops.c:1475`, and `:1506` for mod=
inv)
and takes the modulus and exponent
  from it;
- `openssl_reset_asym_session()` closes it and frees the context when the
session is cleared
  (`rte_openssl_pmd_ops.c:1937`, `:1943`).

Each op in between runs inside that one open frame.
`openssl_pmd_enqueue_burst()` (`rte_openssl_pmd.c:4113`) calls
`process_asym_op()`, which dispatches to `process_openssl_modexp_op()`
(`:3968`); the two `BN_CTX_get()` calls move the
pool forward by two entries, `BN_bin2bn()` and `BN_mod_exp()` allocate digit
arrays for them, and `BN_clear()` at
the end only zeroes the values. Nothing rewinds the pool, so the next op ge=
ts
two further entries and the pool
allocates a new block of BIGNUMs whenever it runs out. The session ends up
holding two BIGNUMs and their digits for
every op it has ever processed. The same sequence in a stand-alone OpenSSL
program grows by the same 1124 bytes per
iteration, and by 0 once the two `BN_CTX_get()` calls sit between
`BN_CTX_start()` and `BN_CTX_end()`.

`process_openssl_modinv_op()` (`rte_openssl_pmd.c:2231`) is the same code w=
ith
`BN_mod_inverse()` on
`sess->u.m.ctx`; it grows by 628 bytes per op with a 2048-bit modulus.

## Impact

Any application that keeps a modexp or modinv session on `crypto_openssl` a=
nd
runs many ops on it sees its process
memory grow steadily. A session is bound to a modulus (and exponent), so an
application keeps it for as long as that
key or group is in use, and every op on it adds to the process heap for the
life of the session: 1124 bytes per
2048-bit modexp, about 950 000 ops per GiB. How fast that adds up depends on
the exponent: with exponent 65537 the
test program runs about 40 000 ops/s on one core and holds 214 MiB after 200
000 ops (about 5 seconds); with a
2048-bit exponent it runs about 600 ops/s per core, about 0.5 MiB/s. All ops
succeed until memory runs out; then the
allocation fails inside `BN_mod_exp()` and the op comes back
`RTE_CRYPTO_OP_STATUS_ERROR` (under a 1 GiB data limit,
after about 0.9 to 1.1 million ops), or, without a limit, the kernel kills =
the
process. Freeing and recreating the
session is the only way to get the memory back.

The in-tree users of modexp are `dpdk-test-crypto-perf`, `dpdk-test-eventde=
v`
and the unit tests; vhost-crypto
forwards only RSA requests from a guest, and RSA does not take this path. T=
he
default build is affected; no
configuration beyond using the OpenSSL PMD for these two op types is needed.
The code dates from the introduction of
the asym ops in 3e9d6bd447fb (2018). Earlier per-op leaks in this driver we=
re
fixed in b7b06b3fa4 ("crypto/openssl:
fix memory leak in auth processing") and 9d91c3047d ("crypto/openssl: fix
memory leaks in asym operations").

## Reproducing

`repro` builds `repro.d/modexp_session.c` against the prebuilt default tree
(`/src/build`, no sanitizer) with
`pkg-config`, runs it once with `--vdev crypto_openssl`, and decides from t=
he
heap counters it prints. About
2 seconds.

- `repro.d/modexp_session.c` is the application, the part an ordinary devel=
oper
writes: it configures cryptodev 0
  with one queue pair, creates one `RTE_CRYPTO_ASYM_XFORM_MODEX` session
(modulus 256 bytes of `0xc5`, exponent
  65537), attaches it to one `rte_crypto_op`, and enqueues and dequeues tha=
t op
for two batches of 10000
  modexps, a different base each time. Any op that does not come back
`RTE_CRYPTO_OP_STATUS_SUCCESS` stops it with
  an error. It prints glibc's `mallinfo2().uordblks` before the ops, after =
each
batch, and after
  `rte_cryptodev_asym_session_free()`.
- There is no crafted input: every op is a well-formed modexp. The growth
depends only on how many ops the
  application runs on the session.
- `repro` is the setup and the verdict. It prints the application's four he=
ap
lines, then the growth in each batch
  and how much of the total growth freeing the session gave back. It prints
`BUG` when the second batch still grows
  the heap by at least 512 bytes per op (the digits of the two 2048-bit BIG=
NUMs
that each op takes from the
  session's `BN_CTX`), and freeing the session gives back at least 90 % of =
the
growth, which ties the memory to the
  session.

Expected output on the tested commit:

```
after 0 ops: heap_in_use=3D255920
after 10000 ops: heap_in_use=3D11503216
after 20000 ops: heap_in_use=3D22743216
after session free: heap_in_use=3D285664
OBSERVED first 10000 ops:  heap +11247296 bytes (1125 per op)
OBSERVED second 10000 ops: heap +11240000 bytes (1124 per op)
OBSERVED freeing the session released 22457552 of the 22487296 bytes
BUG
```

With the attached patch applied and `drivers/librte_crypto_openssl.so.27.0`
rebuilt, the same script shows a one-off
growth of 8032 bytes in the first batch, `+0` in the second, and prints `OK=
`.

## Suggested fix

The attached patch changes `process_openssl_modinv_op()` and
`process_openssl_modexp_op()` in
`drivers/crypto/openssl/rte_openssl_pmd.c` so that each op opens its own fr=
ame
on the session context with
`BN_CTX_start()` before taking its two BIGNUMs and closes it with
`BN_CTX_end()` on both the success path and the
`BN_CTX_get()` failure path. OpenSSL frames nest, so the session's own frame
holding the modulus and exponent is
untouched. The patch also replaces the `BN_free()` calls on the failure pat=
h,
which act on BIGNUMs the context owns
(harmless in practice, since a BIGNUM just handed out by the context has
nothing to free), with `BN_CTX_end()`,
which also clears the context's `too_many` flag.

```diff
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -2233,12 +2233,14 @@ process_openssl_modinv_op(struct rte_crypto_op *cop,
                struct openssl_asym_session *sess)
 {
        struct rte_crypto_asym_op *op =3D cop->asym;
-       BIGNUM *base =3D BN_CTX_get(sess->u.m.ctx);
-       BIGNUM *res =3D BN_CTX_get(sess->u.m.ctx);
+       BIGNUM *base, *res;
+
+       BN_CTX_start(sess->u.m.ctx);
+       base =3D BN_CTX_get(sess->u.m.ctx);
+       res =3D BN_CTX_get(sess->u.m.ctx);

        if (unlikely(base =3D=3D NULL || res =3D=3D NULL)) {
-               BN_free(base);
-               BN_free(res);
+               BN_CTX_end(sess->u.m.ctx);
                cop->status =3D RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
                return -1;
        }
@@ -2255,6 +2257,7 @@ process_openssl_modinv_op(struct rte_crypto_op *cop,

        BN_clear(res);
        BN_clear(base);
+       BN_CTX_end(sess->u.m.ctx);

        return 0;
 }
@@ -2265,12 +2268,14 @@ process_openssl_modexp_op(struct rte_crypto_op *cop,
                struct openssl_asym_session *sess)
 {
        struct rte_crypto_asym_op *op =3D cop->asym;
-       BIGNUM *base =3D BN_CTX_get(sess->u.e.ctx);
-       BIGNUM *res =3D BN_CTX_get(sess->u.e.ctx);
+       BIGNUM *base, *res;
+
+       BN_CTX_start(sess->u.e.ctx);
+       base =3D BN_CTX_get(sess->u.e.ctx);
+       res =3D BN_CTX_get(sess->u.e.ctx);

        if (unlikely(base =3D=3D NULL || res =3D=3D NULL)) {
-               BN_free(base);
-               BN_free(res);
+               BN_CTX_end(sess->u.e.ctx);
                cop->status =3D RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
                return -1;
        }
@@ -2288,6 +2293,7 @@ process_openssl_modexp_op(struct rte_crypto_op *cop,

        BN_clear(res);
        BN_clear(base);
+       BN_CTX_end(sess->u.e.ctx);

        return 0;
 }
```

With the patch applied to a clean checkout and the driver rebuilt, the
reproducer prints `OK`, a modinv variant no
longer grows with the op count, and `cryptodev_openssl_asym_autotest` passe=
s.
The patch file is a bare diff; its
commit message should carry:

```
Fixes: 3e9d6bd447fb ("crypto/openssl: add RSA and mod asym operations")
Cc: stable@dpdk.org
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
