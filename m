Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F78C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E635140151;
	Fri, 28 Aug 2026 12:29:58 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CEAFE40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:29:57 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C97464CF72; Fri, 28 Aug 2026 12:29:57 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1997] CN20K inline IPsec 3DES key overflow
Date: Fri, 28 Aug 2026 10:29:57 +0000
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
Message-ID: <bug-1997-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1997

            Bug ID: 1997
           Summary: CN20K inline IPsec 3DES key overflow
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
`cn20k` inline-IPsec Ethernet security path. I rechecked current `main`
(`8dc80afda7a52a1bd28088fe34102e7c1ba17282`) on 2026-03-10 before writing t=
his
mail.


As on `cn10k`, the DPDK security core forwards the caller-provided
configuration directly into the driver callback:


```c
if (instance->ops->session_create(instance->device, conf, sess)) {
    rte_mempool_put(mp, (void *)sess);
    return NULL;
}
```


For the `cn20k` inline path, current head then calls the `OW` SA fill helpe=
rs
directly:


```c
rc =3D cnxk_ow_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
...
rc =3D cnxk_ow_ipsec_outb_sa_fill(outb_sa_dptr, ipsec, crypto, 0);
```


and again does not first call `cnxk_ipsec_xform_verify()`.


In the shared `OW` helper, `3DES` is accepted by setting `enc_type`, but th=
ere
is no exact `=3D=3D 24` check before the key copy:


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


The same `cn20k` driver publishes exact `24` for `3DES` in its capability
table:


```c
.key_size =3D {
    .min =3D 24,
    .max =3D 24,
    .increment =3D 0
},
```


But the runtime inline path still copies the full user-provided `length` in=
to a
fixed object field.


The destination object is:


```c
struct roc_ow_ipsec_outb_sa {
    ...
    uint8_t cipher_key[ROC_CTX_MAX_CKEY_LEN];
    union roc_ow_ipsec_outb_iv iv;
    ...
};
```


with `ROC_CTX_MAX_CKEY_LEN =3D=3D 32`.


So any `3DES` key longer than `32` bytes writes into the adjacent live `iv`.


The cleanest concrete case is a `40`-byte `RTE_CRYPTO_CIPHER_3DES_CBC` key:


- first `32` bytes fill `cipher_key`
- next `8` bytes overwrite the beginning of `iv`
- the helper returns `0`
- `cn20k_eth_sec_session_create()` proceeds with SA installation


Why I think this should be accepted as a real bug:


- the path is current-head and reachable from the public session-create API
- capability metadata is not a runtime guard in this path
- the runtime code bypasses the verifier that would have enforced exact-len=
gth
constraints
- the sink writes through a fixed in-object array into the next live member
- the corrupted SA is still treated as successfully created


The local proof results for the narrow `40`-byte case are:


- `distance_cipher_key_to_iv=3D32`
- `advertised_3des_key_max=3D24`
- `provided_key_len=3D40`
- `returned=3D0`
- `overflow_bytes_into_iv=3D8`
- `iv_prefix_hex=3D4242424242424242`
- `guard_unchanged=3D1`


Suggested fix:
1. Enforce exact `3DES` key length before `cnxk_ow_ipsec_*_sa_fill()` is ca=
lled
on the inline path.
2. Add a direct upper-bound guard before `memcpy(cipher_key, key, length)`.
3. Reuse the same xform-length verification logic across inline and non-inl=
ine
`cnxk` IPsec paths.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
