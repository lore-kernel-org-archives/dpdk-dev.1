Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2317EE4992
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:51:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B885C402A0;
	Tue, 30 Dec 2025 19:51:19 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9A87940267
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:51:18 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 795704713F; Tue, 30 Dec 2025 19:51:18 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1861] rte_memcpy references past end of source
Date: Tue, 30 Dec 2025 18:51:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1861-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1861

            Bug ID: 1861
           Summary: rte_memcpy references past end of source
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

When fips_validation example is compiled with Gcc-16 it generates an array =
out
of bounds warning inside rte_memcpy(). It looks like this because copy sour=
ce
is a 15 byte array and rte_memcpy is using vector instruction that referenc=
es
past that.


In function =E2=80=98get_hash_oid=E2=80=99,
    inlined from =E2=80=98prepare_rsa_xform=E2=80=99 at
../examples/fips_validation/main.c:1607:12:
../examples/fips_validation/main.c:890:20: warning: array subscript
=E2=80=98__m128i_u[0]=E2=80=99 is partly outside array bounds of =E2=80=98u=
int8_t[15]=E2=80=99 {aka =E2=80=98unsigned
char[15]=E2=80=99} [-Warray-bounds=3D]
  890 |                 id =3D id_sha1;
      |                 ~~~^~~~~~~~~
../examples/fips_validation/main.c: In function =E2=80=98prepare_rsa_xform=
=E2=80=99:
../examples/fips_validation/main.c:882:17: note: object =E2=80=98id_sha1=E2=
=80=99 of size 15
  882 |         uint8_t id_sha1[] =3D {0x30, 0x21, 0x30, 0x09, 0x06, 0x05,


Workaround is to just use memcpy() which handles this case correctly.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
