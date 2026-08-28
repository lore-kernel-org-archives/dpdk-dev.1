Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35239C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:34:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66EE440151;
	Fri, 28 Aug 2026 12:34:00 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C14E140150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:33:59 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BC3FF4C74D; Fri, 28 Aug 2026 12:33:59 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 2000] OpenSSL PMD SM2 overflow
Date: Fri, 28 Aug 2026 10:33:59 +0000
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
Message-ID: <bug-2000-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2000

            Bug ID: 2000
           Summary: OpenSSL PMD SM2 overflow
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

Hello DPDK maintainers, I would like to report what appears to be a real
current-head overflow in the OpenSSL PMD SM2 setup path. I rechecked current
upstream head on 2026-03-10 before writing this report. The vulnerable code=
 is:
```c uint8_t pubkey[65]; size_t len =3D 0; memset(pubkey, 0, sizeof(pubkey)=
);
pubkey[0] =3D 0x04; len +=3D 1; memcpy(&pubkey[len], xform->ec.q.x.data,
xform->ec.q.x.length); len +=3D xform->ec.q.x.length; memcpy(&pubkey[len],
xform->ec.q.y.data, xform->ec.q.y.length); len +=3D xform->ec.q.y.length; `=
`` The
generic EC point type used here is: ```c struct rte_crypto_ec_point {=20=20=
=20=20
rte_crypto_param x;     rte_crypto_param y; }; typedef struct {     ...=20=
=20=20=20
size_t length; } rte_crypto_param; ``` So at this layer, the coordinate len=
gths
are generic `size_t` values. I do not see a hard current-head type-level
invariant in the generic API that forces both SM2 coordinates to be 32 bytes
before this PMD code runs. I also checked the DPDK core asym session setup
path, and it still directly dispatches to the PMD: ```c ret =3D
dev->dev_ops->asym_session_configure(dev, xforms, sess); ``` That is why I =
do
not think capability tables or helper APIs are enough to refute the bug. The
PMD itself still appends `x` and `y` into a fixed `pubkey[65]` buffer with =
no
local bound such as `1 + xlen + ylen <=3D sizeof(pubkey)`. Why I think this=
 is a
real current-head bug: - fixed stack buffer `pubkey[65]` - unchecked copies
using caller-supplied coordinate lengths - generic create path still reaches
the PMD directly - the overflow occurs before OpenSSL parameter building
completes I am keeping the claim narrow: this is an SM2 PMD parameter-setup
bug, not a claim that the generic API contract itself is invalid. The direct
fix is to reject any coordinate pair where `1 + xform->ec.q.x.length +
xform->ec.q.y.length > sizeof(pubkey)` before the copies.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
