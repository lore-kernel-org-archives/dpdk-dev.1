Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF47EC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:30:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 049E540151;
	Fri, 28 Aug 2026 12:30:57 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 350C240150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:30:56 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 312014C4E4; Fri, 28 Aug 2026 12:30:56 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1998] CN9K inline inbound AES-XCBC auth key
 overflow
Date: Fri, 28 Aug 2026 10:30:56 +0000
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
Message-ID: <bug-1998-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1998

            Bug ID: 1998
           Summary: CN9K inline inbound AES-XCBC auth key overflow
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


I would like to report what appears to be a real current-head intra-object
overflow in the `cn9k` inline IPsec inbound path for `AES_XCBC_MAC`. I
rechecked current `main` (`8dc80afda7a52a1bd28088fe34102e7c1ba17282`) on
2026-03-10 before writing this report.


The relevant inline caller path is:


```c
cn9k_eth_sec_session_create(...)
{
    ...
    rc =3D cnxk_on_ipsec_inb_sa_create(ipsec, crypto, inb_sa);
    ...
}
```


This inline path does not call `cnxk_ipsec_xform_verify()`.


That matters because the exact-length check for XCBC exists in the reusable
verifier:


```c
if (crypto_xform->auth.algo =3D=3D RTE_CRYPTO_AUTH_AES_XCBC_MAC &&
    keylen =3D=3D ROC_CPT_AES_XCBC_KEY_LENGTH)
    return 0;
```


But the inline inbound path bypasses that verifier and reaches this sink
instead:


```c
case RTE_CRYPTO_AUTH_AES_XCBC_MAC:
    memcpy(in_sa->aes_xcbc.key, auth_key, auth_key_len);
    ctx_len =3D offsetof(struct roc_ie_on_inb_sa, aes_xcbc.selector);
    break;
```


The relevant object layout is:


```c
struct {
    uint8_t key[16];
    uint8_t unused[32];
    struct roc_ie_on_traffic_selector selector;
} aes_xcbc;
```


So the first live adjacent member starts `48` bytes after the beginning of
`aes_xcbc.key`.


The key point here is narrow and specific:


- if the claim is only =E2=80=9Ccopy into `key[16]` without a bound=E2=80=
=9D, then any
`auth.key.length > 16` is already a real overwrite into adjacent in-object
storage
- if the claim is specifically =E2=80=9Ccorrupts the live `selector` member=
=E2=80=9D, then the
clean threshold is `auth.key.length > 48`


This report is about that second, narrower claim.


The same driver advertises `AES_XCBC_MAC` as exact-size only:


```c
.key_size =3D {
    .min =3D 16,
    .max =3D 16,
    .increment =3D 0
},
```


But the runtime inline inbound path still copies the full user-provided len=
gth
into `key[16]`.


The clean concrete case is a `64`-byte `AES_XCBC_MAC` key:


- bytes `0..15` fill `key[16]`
- bytes `16..47` fill `unused[32]`
- bytes `48..63` overwrite the first `16` bytes of live `selector`


The later `roc_aes_xcbc_key_derive()` call does not repair that selector
overwrite, because it only writes derived material into the first `48` byte=
s of
the union region.


The local proof results for this narrow case are:


- `distance_key_to_selector=3D48`
- `advertised_aes_xcbc_key_max=3D16`
- `provided_key_len=3D64`
- `returned_ctx_len=3D120`
- `overflow_bytes_into_selector=3D16`
- `selector_prefix_hex=3D4242424242424242`
- `guard_unchanged=3D1`


Why I think this is a real bug:
- the sink is current-head shared security code
- the caller is a production inline session-create path
- the verifier that would have enforced exact XCBC length exists but is
bypassed here
- the destination is a fixed in-object field, not a flexible array
- the overwritten bytes belong to a live adjacent member, `selector`


Suggested fix:
1. Reject `AES_XCBC_MAC` keys whose length is not exactly `16` before
`cnxk_on_ipsec_inb_sa_create()` is reached on this inline path.
2. Add a local check such as `if (auth_key_len !=3D sizeof(in_sa->aes_xcbc.=
key))
return -EINVAL;` before the `memcpy()`.
3. Reuse the same xform verification logic for inline callers that already
exists for the lookaside path.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
