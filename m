Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FEC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC1340151;
	Fri, 28 Aug 2026 12:17:16 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED9F740150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:17:14 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CDD124D02E; Fri, 28 Aug 2026 12:17:14 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1992] armv8 PMD HMAC keys overflow
Date: Fri, 28 Aug 2026 10:17:14 +0000
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
Message-ID: <bug-1992-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1992

            Bug ID: 1992
           Summary: armv8 PMD HMAC keys overflow
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
armv8 crypto PMD HMAC setup path. I rechecked current upstream head on
2026-03-10 before writing this report.


The current-head sink appears twice, for SHA1 and SHA256 HMAC setup:


```c
rte_memcpy(sess->auth.hmac.key, xform->auth.key.data,
           xform->auth.key.length);
```


The destination layout is:


```c
struct {
    uint8_t i_key_pad[SHA_BLOCK_MAX];
    uint8_t o_key_pad[SHA_BLOCK_MAX];
    uint8_t key[SHA_BLOCK_MAX];
} hmac;
uint16_t digest_length;
```


So an oversized key first corrupts the adjacent `digest_length` member after
`key[SHA_BLOCK_MAX]`.


I am aware that the capability table advertises the intended HMAC key limit=
s,
but I do not think that kills the claim, because the generic create path st=
ill
directly calls the PMD:


```c
ret =3D dev->dev_ops->sym_session_configure(dev, xforms, sess);
```


The generic core exposes capability-check helpers, but it does not
automatically invoke them before the PMD copy. In other words, the current =
code
still relies on the caller or driver to enforce the bound, and the PMD sink
itself does not.


Why I think this remains a real bug:


- the sink is a literal unchecked `rte_memcpy()` into a fixed field
- there is no in-driver `<=3D sizeof(sess->auth.hmac.key)` guard before the=
 copy
- the next bytes are a real adjacent member of the same session object
- the current generic create path does not automatically protect this PMD


I am intentionally making a narrow claim: this is a PMD session-configurati=
on
bug, not a statement that every application using DPDK hits it automaticall=
y.


The minimal fix is to reject HMAC key lengths larger than
`sizeof(sess->auth.hmac.key)` before the copy.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
