Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C4CC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:18:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63DE540151;
	Fri, 28 Aug 2026 12:18:50 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 265A540150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:18:49 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1D2FF4CDDF; Fri, 28 Aug 2026 12:18:49 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1993] CCP cipher keys overflow
Date: Fri, 28 Aug 2026 10:18:49 +0000
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
Message-ID: <bug-1993-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1993

            Bug ID: 1993
           Summary: CCP cipher keys overflow
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
Reported by: pengpeng <pengpeng@iscas.ac.cn>

Hello DPDK maintainers,


I would like to report what appears to be a real current-head overflow in t=
he
`ccp` crypto PMD. I rechecked current upstream head on 2026-03-10 before
writing this report.


The core problem is in `ccp_configure_session_cipher()`:


```c
sess->cipher.key_length =3D cipher_xform->key.length;
rte_memcpy(sess->cipher.key, cipher_xform->key.data,
           cipher_xform->key.length);
...
if (sess->cipher.key_length =3D=3D 16) ...
else if (sess->cipher.key_length =3D=3D 24) ...
else if (sess->cipher.key_length =3D=3D 32) ...
else
    return -1;
```


The destination layout in `struct ccp_session` is:


```c
uint64_t key_length;
uint8_t  key[32];
uint8_t  key_ccp[32];
phys_addr_t key_phys;
uint8_t  nonce[32];
```


So a `40`-byte key already overwrites the adjacent `key_ccp` member before =
the
function reports that the length is invalid.


Why I do not think this is refuted by current-head invariants:


- the generic session setup paths still reach `ccp_set_session_parameters()`
and then `ccp_configure_session_cipher()`
- the function itself performs the copy before its algorithm-specific
accepted-length checks
- this is not a tail-allocation pattern; it is a fixed in-object array foll=
owed
by a live adjacent member
- the issue is not just "unsupported input"; the memory corruption happens
before the `-1` return


I am keeping the claim narrow: this is a PMD session-configuration bug, and=
 the
cleanest reproducer is an oversized AES key such as 40 bytes.


The fix seems straightforward:


1. validate the supported key length before the `rte_memcpy()`
2. add a hard upper bound such as `if (cipher_xform->key.length >
sizeof(sess->cipher.key)) return -1;`

--=20
You are receiving this mail because:
You are the assignee for the bug.=
