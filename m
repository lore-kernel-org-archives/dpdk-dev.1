Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0097C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D14F640151;
	Fri, 28 Aug 2026 12:27:20 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 74D7C40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:27:19 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5C22D4CF73; Fri, 28 Aug 2026 12:27:19 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1995] CN10K inline IPsec 3DES keys overflow
Date: Fri, 28 Aug 2026 10:27:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thomas@monjalon.net
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-1995-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1995

            Bug ID: 1995
           Summary: CN10K inline IPsec 3DES keys overflow
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: thomas@monjalon.net
  Target Milestone: ---
             Group: security

Report date: 2026-03-11
Reported by: =E4=BE=AF=E6=9C=8B=E6=9C=8B <pengpeng@iscas.ac.cn>

Hello DPDK maintainers,


I am reporting what looks like a real current-head intra-object overflow in=
 the
`cn10k` inline-IPsec Ethernet security path. I rechecked current `main`
(`8dc80afda7a52a1bd28088fe34102e7c1ba17282`) on 2026-03-10 before writing t=
his
mail.


The important point is that the public DPDK security API forwards the
configuration directly into the driver callback:


```c
if (instance->ops->session_create(instance->device, conf, sess)) {
    rte_mempool_put(mp, (void *)sess);
    return NULL;
}
```


For `cn10k`, the inline Ethernet path then goes straight into the SA fill
helpers:


```c
rc =3D cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
...
rc =3D cnxk_ot_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
```


and does not first call `cnxk_ipsec_xform_verify()`.


In the shared helper, `3DES` is accepted by setting `enc_type`, but there i=
s no
exact `=3D=3D 24` runtime check before the copy:


```c
case RTE_CRYPTO_CIPHER_3DES_CBC:
    w2->s.enc_type =3D ROC_IE_SA_ENC_3DES_CBC;
    break;
...
key =3D cipher_xfrm->cipher.key.data;
length =3D cipher_xfrm->cipher.key.length;
...
if (key !=3D NULL && length !=3D 0) {
    memcpy(cipher_key, key, length);
    ...
}
```


The capability table for this same path advertises `3DES` as exact-size onl=
y:


```c
.key_size =3D {
    .min =3D 24,
    .max =3D 24,
    .increment =3D 0
},
```


But the runtime inline path above does not enforce that before the copy.


The destination object is:


```c
struct roc_ot_ipsec_outb_sa {
    ...
    uint8_t cipher_key[ROC_CTX_MAX_CKEY_LEN];
    union roc_ot_ipsec_outb_iv iv;
    ...
};
```


with `ROC_CTX_MAX_CKEY_LEN =3D=3D 32`.


So any `3DES` key longer than `32` bytes writes through `cipher_key[32]` and
into the adjacent live `iv`.


The cleanest current-head case is a `40`-byte `RTE_CRYPTO_CIPHER_3DES_CBC` =
key:


- first `32` bytes fill `cipher_key`
- next `8` bytes overwrite the beginning of `iv`
- the helper still returns `0`
- the session-create path proceeds with SA installation


This is why I think this is a strong bug:


- the caller chain is current-head and production, not test code
- the exact-size constraint is published by the driver itself
- the runtime path bypasses the verifier that would have enforced it
- the sink writes attacker-controlled data into a fixed in-object array
- the overwrite reaches a live adjacent member and the path still succeeds


I also prepared a local proof mirroring the current-head layout and write
order. The key outputs are:


- `distance_cipher_key_to_iv=3D32`
- `advertised_3des_key_max=3D24`
- `provided_key_len=3D40`
- `returned=3D0`
- `overflow_bytes_into_iv=3D8`
- `iv_prefix_hex=3D4242424242424242`
- `guard_unchanged=3D1`


Suggested fix:
1. Enforce exact `3DES` length before `cnxk_ot_ipsec_*_sa_fill()` is reache=
d on
the inline path.
2. Add a local `length <=3D sizeof(cipher_key)` guard inside the helper bef=
ore
`memcpy()`.
3. Reuse the same xform verification logic on this inline path that already
exists elsewhere in the `cnxk` IPsec stack.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
