Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B189C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 09:33:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B653640151;
	Fri, 28 Aug 2026 11:33:37 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BCFF540150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 11:33:35 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9F2DA4C987; Fri, 28 Aug 2026 11:33:35 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1989] CN9K inline inbound IPsec HMAC SA creation
 out-of-bounds write
Date: Fri, 28 Aug 2026 09:33:35 +0000
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
Message-ID: <bug-1989-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1989

            Bug ID: 1989
           Summary: CN9K inline inbound IPsec HMAC SA creation
                    out-of-bounds write
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

Hello DPDK Security Team,

I would like to report a potential security vulnerability in DPDK affecting=
 the
CN9K inline inbound IPsec SA creation path.

Project: DPDK
Component: `drivers/common/cnxk` / CN9K inbound inline IPsec
Affected path: inbound SA creation path leading to
`cnxk_on_ipsec_inb_sa_create()`
Tested current code: tested on the then-current main/master branch as of
2026-03-08
Affected versions: I have confirmed this on current head; I can provide
additional version verification if useful.

The issue appears to be an out-of-bounds write caused by copying
caller-provided HMAC keys into fixed-size in-struct arrays without enforcin=
g an
algorithm-appropriate upper bound in the CN9K inbound inline IPsec path.

Based on the current logic, the inbound SA creation code copies the provided
authentication key into fixed internal fields for different HMAC variants. =
The
relevant destination layout includes adjacent live members, and the copy le=
ngth
is based on the provided key length.

The relevant in-struct layout includes cases such as:

* `sha1_or_gcm.hmac_key[48]` followed by `selector`
* `sha2.hmac_key[64]` followed by `hmac_iv[64]` and `selector`

Based on this logic, if the provided key length exceeds the destination arr=
ay
size for the selected algorithm, the copy overwrites adjacent live fields
inside the same object.

Why I believe this is a real issue:

* the inbound CN9K path copies caller-provided authentication key material =
into
fixed-size in-struct arrays
* the first adjacent victims are live semantic fields rather than padding
* in the SHA1 HMAC case, the destination buffer is 48 bytes but a 64-byte k=
ey
can be copied
* the overwrite occurs in a live inbound SA construction path

My current local proof results for the SHA1 HMAC case are:

* `sha1_distance_to_selector =3D 48`
* `sha1_key_len =3D 64`
* `sha1_selector_prefix_hex =3D 4141414141414141`

These results indicate that the bytes beyond `hmac_key[48]` overwrite the
adjacent selector object with caller-controlled data.

At a minimum, this appears capable of causing memory corruption, crash
conditions, or corrupted inbound IPsec SA state. I am not claiming code
execution.

I would also like to be explicit about the current trust-boundary uncertain=
ty:
I have confirmed the memory corruption condition locally, but I am not maki=
ng a
stronger claim about exploitability beyond the fact that this path copies
caller-controlled key material into fixed-size in-struct buffers without a
sufficiently strict upper bound.

Suggested remediation:

* enforce explicit per-algorithm upper bounds before copying authentication
keys
* ensure the inbound CN9K path applies the same effective key-length
constraints as the capability model and verification logic
* review similar authentication-key copy paths in related CNXK IPsec setup =
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
