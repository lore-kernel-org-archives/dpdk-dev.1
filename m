Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CCC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:28:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8D9040151;
	Fri, 28 Aug 2026 12:28:40 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C9AB240150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:28:39 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C4E634CF73; Fri, 28 Aug 2026 12:28:39 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1996] CN20K inline inbound AES-GMAC key overflow
Date: Fri, 28 Aug 2026 10:28:39 +0000
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
Message-ID: <bug-1996-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1996

            Bug ID: 1996
           Summary: CN20K inline inbound AES-GMAC key overflow
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
overflow in the `cn20k` inline inbound IPsec path for `AES_GMAC`. I recheck=
ed
current `main`  on 2026-03-10 before writing this report.


The relevant current-head path is:


```c
cn20k_eth_sec_session_create(...)
{
    ...
    rc =3D cnxk_ow_ipsec_inb_sa_fill(inb_sa_dptr, ipsec, crypto, 0);
    ...
}
```


and the update path reaches the same helper.


The `OW` helper has the same copy-first-then-validate pattern on the `AES_G=
MAC`
path:


```c
case RTE_CRYPTO_AUTH_AES_GMAC:
    w2->s.auth_type =3D ROC_IE_SA_AUTH_AES_GMAC;
    key =3D auth_xfrm->auth.key.data;
    length =3D auth_xfrm->auth.key.length;
    ...
    break;
...
if (key !=3D NULL && length !=3D 0) {
    memcpy(cipher_key, key, length);
}
...
switch (length) {
case 16:
case 24:
case 32:
    break;
default:
    return -EINVAL;
}
```


The destination object on this inbound `cn20k` path is:


```c
struct roc_ow_ipsec_inb_sa {
    ...
    uint8_t cipher_key[ROC_CTX_MAX_CKEY_LEN];
    union {
        struct {
            uint32_t rsvd8;
            uint8_t salt[4];
        } s;
        uint64_t u64;
    } w8;
    ...
};
```


with `ROC_CTX_MAX_CKEY_LEN =3D=3D 32`.


So a `40`-byte `AES_GMAC` key overwrites the adjacent member before the
function reports invalid input:


- bytes `0..31` fill `cipher_key[32]`
- bytes `32..39` overwrite adjacent `w8`
- bytes `36..39` overwrite live `salt[4]`


Why I believe this should be accepted:


- the overwrite is in the real current-head `OW` helper used by inline inbo=
und
session create/update
- the destination is a fixed in-object field followed by a live adjacent me=
mber
- the bug does not depend on a crash or sanitizer output
- later `-EINVAL` does not undo the earlier write


The local proof results for the narrow case are:


- `distance_cipher_key_to_w8=3D32`
- `distance_cipher_key_to_salt=3D36`
- `advertised_aes_gmac_key_max=3D32`
- `provided_key_len=3D40`
- `returned=3D-22`
- `overflow_bytes_into_w8=3D8`
- `overflow_bytes_into_salt=3D4`
- `w8_u64_hex=3D4242424242424242`
- `salt_prefix_hex=3D42424242`
- `guard_unchanged=3D1`


Suggested fix:


1. Enforce `AES_GMAC` key length before `cnxk_ow_ipsec_inb_sa_fill()` is ca=
lled
on the inline path.
2. Add a direct `length <=3D sizeof(cipher_key)` guard before the `memcpy()=
`.
3. Reuse the same crypto-length verification logic across the inline and
non-inline `cnxk` IPsec implementations.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
