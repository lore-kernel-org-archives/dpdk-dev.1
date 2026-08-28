Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BB9C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56D6F40151;
	Fri, 28 Aug 2026 12:32:24 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFF340150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:32:23 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 57CD74C525; Fri, 28 Aug 2026 12:32:23 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1999] cnxk ON common SA 3DES key overflow
Date: Fri, 28 Aug 2026 10:32:23 +0000
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
Message-ID: <bug-1999-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1999

            Bug ID: 1999
           Summary: cnxk ON common SA 3DES key overflow
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
overflow in the `cnxk` ON-family IPsec security-SA creation path. I recheck=
ed
current `main` on 2026-03-10 before writing this report.


The relevant issue is in `drivers/common/cnxk/cnxk_security.c`.


The front-door logic accepts `DES` / `3DES` by setting `enc_type`, but it o=
nly
performs an AES-family key-length switch:


```c
if (cipher_xform !=3D NULL) {
    switch (cipher_xform->cipher.algo) {
    case RTE_CRYPTO_CIPHER_DES_CBC:
        ctl->enc_type =3D ROC_IE_SA_ENC_DES_CBC;
        break;
    case RTE_CRYPTO_CIPHER_3DES_CBC:
        ctl->enc_type =3D ROC_IE_SA_ENC_3DES_CBC;
        break;
    case RTE_CRYPTO_CIPHER_AES_CBC:
    case RTE_CRYPTO_CIPHER_AES_CTR:
        aes_key_len =3D cipher_xform->cipher.key.length;
        break;
    }
}


if (ctl->enc_type =3D=3D ROC_IE_SA_ENC_AES_CBC ||
    ctl->enc_type =3D=3D ROC_IE_SA_ENC_AES_CTR ||
    ctl->enc_type =3D=3D ROC_IE_SA_ENC_AES_GCM ||
    ctl->enc_type =3D=3D ROC_IE_SA_ENC_AES_CCM ||
    ctl->auth_type =3D=3D ROC_IE_SA_AUTH_AES_GMAC) {
    switch (aes_key_len) {
    case 16:
    case 24:
    case 32:
        ...
    default:
        return -EINVAL;
    }
}
```


Later in the same helper, the full runtime key length is copied into a fixed
in-object array with no upper bound:


```c
cipher_key =3D cipher_xform->cipher.key.data;
cipher_key_len =3D cipher_xform->cipher.key.length;
...
if (cipher_key_len !=3D 0)
    memcpy(common_sa->cipher_key, cipher_key, cipher_key_len);
```


The affected object layout is:


```c
struct roc_ie_on_common_sa {
    struct roc_ie_on_sa_ctl ctl;
    uint8_t cipher_key[32];
    union roc_ie_on_bit_perfect_iv iv;
    ...
};
```


So any `DES` / `3DES` key longer than `32` bytes writes past `cipher_key[32=
]`
and into the adjacent live `iv` member.


Why I think this is a real bug and not just a capability-metadata concern:


- the DPDK security core does not enforce cipher key sizes before calling t=
he
driver:


```c
if (instance->ops->session_create(instance->device, conf, sess)) {
    rte_mempool_put(mp, (void *)sess);
    return NULL;
}
```


- the driver contract in `rte_security_driver.h` says invalid or unsupported
transforms should be rejected, not accepted after memory corruption
- the copy sink is on the real current-head caller chain:
  - `rte_security_session_create()`
  - `cn9k_eth_sec_session_create()`
  - `cnxk_on_ipsec_outb_sa_create()`
  - `on_fill_ipsec_common_sa()`
- the path still returns success after the adjacent overwrite


The cleanest concrete case is `RTE_CRYPTO_CIPHER_3DES_CBC` with a `40`-byte
key:


- first `32` bytes fill `cipher_key`
- next `8` bytes overwrite the beginning of adjacent `iv`
- the helper returns `0`


I also prepared a minimal local proof that mirrors the current-head layout =
and
write order. The key outputs are:


- `distance_cipher_key_to_iv=3D32`
- `accepted_des3_key_without_upper_bound=3D1`
- `provided_key_len=3D40`
- `returned=3D0`
- `overflow_bytes_into_iv=3D8`
- `iv_prefix_hex=3D4242424242424242`
- `guard_unchanged=3D1`


That shows the first eight bytes beyond `cipher_key[32]` already corrupt the
live adjacent `iv` member, while the modeled current-head path still returns
success.


Suggested fix:
1. Reject `DES` / `3DES` key lengths that do not match the supported runtime
contract before the copy.
2. Add a defensive check near the sink, e.g. `if (cipher_key_len >
sizeof(common_sa->cipher_key)) return -EINVAL;`.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
