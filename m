Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F165C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 09:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63C084025A;
	Fri, 28 Aug 2026 11:28:49 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A62D040150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 11:28:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8F8484BDD9; Fri, 28 Aug 2026 11:28:47 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1988] CCP session cipher configuration
 out-of-bounds write
Date: Fri, 28 Aug 2026 09:28:47 +0000
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
Message-ID: <bug-1988-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1988

            Bug ID: 1988
           Summary: CCP session cipher configuration out-of-bounds write
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

Report date: 2026-03-09
Reported by: =E4=BE=AF=E6=9C=8B=E6=9C=8B <pengpeng@iscas.ac.cn>

Project: DPDK
Component: drivers/crypto/ccp
Affected path: session cipher configuration in ccp_set_session_parameters()=
 /
ccp_configure_session_cipher()
Tested current code: tested on the then-current main/master branch as of
2026-03-08
Affected versions: I have confirmed this on current head; I can provide
additional version verification if useful

The issue appears to be an out-of-bounds write caused by copying a
user-provided cipher key into a fixed-size in-struct buffer before validati=
ng
whether the key length is supported.

In the affected path, the code stores the requested key length and copies t=
he
key material first:

sess->cipher.key_length =3D cipher_xform->key.length;
rte_memcpy(sess->cipher.key, cipher_xform->key.data,
           cipher_xform->key.length);
...
if (sess->cipher.key_length =3D=3D 16) ...
else if (sess->cipher.key_length =3D=3D 24) ...
else if (sess->cipher.key_length =3D=3D 32) ...
else {
    return -1;
}
The relevant object layout in drivers/crypto/ccp/ccp_crypto.h includes adja=
cent
live fields:

uint8_t key[32];
uint8_t key_ccp[32];
phys_addr_t key_phys;
uint8_t nonce[32];
Based on this logic, a key longer than 32 bytes overwrites the adjacent key=
_ccp
member before the function rejects the key length.

Why I believe this is a real issue:

* the key copy occurs before the supported-length validation
* the destination is a fixed-size in-struct array
* the first adjacent victim is a live semantic field (key_ccp)
* the overwrite occurs even when the function later returns -1

My current local proof results are:

distance_key_to_key_ccp =3D 32
requested_key_len =3D 40
returned =3D -1
overflow_bytes_into_key_ccp =3D 8
key_ccp_prefix_hex =3D 4242424242424242

These results indicate that the first 8 bytes beyond key[32] overwrite the
adjacent key_ccp field before the function reports invalid parameters.

At a minimum, this appears capable of causing memory corruption, crash
conditions, or corrupted crypto session state. I am not claiming code
execution.

I would also like to be explicit about the current trust-boundary uncertain=
ty:
I have confirmed the memory corruption condition locally, but I am not maki=
ng a
stronger claim about exploitability beyond the fact that this path copies
caller-controlled key material before validation. If you would like, I can
provide additional analysis regarding the most realistic attacker-controlled
entry conditions in deployed environments.

Suggested remediation:

* validate supported key lengths before copying into sess->cipher.key
* add a hard upper-bound check before the copy, for example rejecting lengt=
hs
greater than sizeof(sess->cipher.key)
* review similar =E9=88=A5=E6=B8=83opy before validate=E9=88=A5=EF=BF=BD pa=
tterns in related crypto session
setup paths

Please credit the issue to: Pengpeng Hou
Embargo preference: no special embargo requested

--=20
You are receiving this mail because:
You are the assignee for the bug.=
