Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D51DC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 09:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ECD040151;
	Fri, 28 Aug 2026 11:36:27 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1DEBA40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 11:36:25 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 073B54CC73; Fri, 28 Aug 2026 11:36:24 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1990] cnxk DES3 session key out-of-bounds write
Date: Fri, 28 Aug 2026 09:36:25 +0000
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
Message-ID: <bug-1990-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1990

            Bug ID: 1990
           Summary: cnxk DES3 session key out-of-bounds write
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

Subject: [SECURITY] Potential out-of-bounds write in DPDK cnxk DES3 session=
 key
handling

Hello DPDK Security Team,

I would like to report a potential security vulnerability in DPDK affecting=
 the
`cnxk` crypto driver session configuration path.

Project: DPDK
Component: `drivers/crypto/cnxk` / `drivers/common/cnxk`
Affected path: DES3 session cipher setup in `fill_sess_cipher()` leading to
`roc_se_ciph_key_set()`
Tested current code: tested on the then-current main/master branch as of
2026-03-08
Affected versions: I have confirmed this on current head; I can provide
additional version verification if useful.

The issue appears to be an out-of-bounds write caused by accepting oversized
DES3 keys in the `cnxk` session configuration path and then copying the full
caller-provided length into a fixed-size in-struct key buffer.

Based on the current logic, the DES3 path treats the algorithm as having a
24-byte key, but only rejects keys shorter than 24 bytes. Keys longer than =
24
bytes are forwarded unchanged into the lower-level key setup routine. The s=
ink
then copies the full provided length into the encryption key field inside t=
he
session context.

The relevant destination layout includes adjacent live fields in this order:

* `encr_key[32]`
* `encr_iv[16]`

Based on this logic, a DES3 key longer than 32 bytes overwrites the adjacent
`encr_iv` member.

Why I believe this is a real issue:

* the DES3 path enforces only a lower bound rather than the exact expected =
key
length
* the oversized caller-provided key length is forwarded unchanged into the =
sink
* the destination is a fixed-size in-struct array
* the first adjacent victim is a live semantic field (`encr_iv`)
* the path still returns success after the adjacent overwrite

My current local proof results are:

* `distance_encr_key_to_encr_iv =3D 32`
* `provided_key_len =3D 40`
* `returned =3D 0`
* `overflow_bytes_into_encr_iv =3D 8`
* `encr_iv_prefix_hex =3D 4242424242424242`

These results indicate that a 40-byte DES3 key is accepted by the current p=
ath,
and the first 8 bytes beyond `encr_key[32]` overwrite the adjacent `encr_iv`
field with caller-controlled data.

At a minimum, this appears capable of causing memory corruption or corrupted
crypto session state. I am not claiming code execution.

I would also like to be explicit about the current trust-boundary uncertain=
ty:
I have confirmed the memory corruption condition locally, but I am not maki=
ng a
stronger claim about exploitability beyond the fact that this path accepts
oversized caller-controlled key material and copies it into a fixed-size
in-struct buffer.

Suggested remediation:

* enforce the exact DES3 key length in the session setup path rather than o=
nly
a lower bound
* add a hard upper-bound check in the lower-level key setup routine before
copying into the destination buffer
* review similar key-length validation paths in related crypto session setup
code

I can provide the following in follow-up if helpful:

* a minimal reproducer
* local proof notes / output
* exact tested revision details
* a proposed patch

Please credit the issue to: pengpeng@iscas.ac.cn
Embargo preference: no special embargo requested

--=20
You are receiving this mail because:
You are the assignee for the bug.=
