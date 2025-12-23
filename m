Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE69E748FC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 22:18:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED6A740265;
	Tue, 23 Dec 2025 23:18:45 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EF8814025A
 for <dev@dpdk.org>; Tue, 23 Dec 2025 23:18:44 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CBA48470D4; Tue, 23 Dec 2025 23:18:44 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1859] common/cnxk: out of bounds access
Date: Tue, 23 Dec 2025 22:18:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
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
Message-ID: <bug-1859-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1859

            Bug ID: 1859
           Summary: common/cnxk: out of bounds access
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Gcc 16 detects out of bounds array access:

In function =E2=80=98nix_inl_selftest_work_cb=E2=80=99,
    inlined from =E2=80=98inl_outb_soft_exp_poll=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl_dev.c:1173:4,
    inlined from =E2=80=98nix_inl_outb_poll_thread=E2=80=99 at
../drivers/common/cnxk/roc_nix_inl_dev.c:1201:6:
../drivers/common/cnxk/roc_nix_inl_dev.c:43:19: warning: array subscript 1 =
is
outside array bounds of =E2=80=98uint64_t[1]=E2=80=99 {aka =E2=80=98long un=
signed int[1]=E2=80=99}
[-Warray-bounds=3D]
   43 |         uintptr_t work =3D gw[1];
      |                   ^~~~
../drivers/common/cnxk/roc_nix_inl_dev.c: In function
=E2=80=98nix_inl_outb_poll_thread=E2=80=99:
../drivers/common/cnxk/roc_nix_inl_dev.c:1172:34: note: at offset 8 into ob=
ject
=E2=80=98tmp=E2=80=99 of size 8
 1172 |                         uint64_t tmp =3D ~(uint32_t)0x0;
      |                                  ^~~

The code in question is:

static void
inl_outb_soft_exp_poll(struct nix_inl_dev *inl_dev, uint32_t ring_idx)
{
...             if (sa !=3D NULL) {
                        uint64_t tmp =3D ~(uint32_t)0x0;
                        inl_dev->work_cb(&tmp, sa, NIX_INL_SOFT_EXPIRY_THRD,
NULL, port_id);

...
static void
nix_inl_selftest_work_cb(uint64_t *gw, void *args, enum nix_inl_event_type
type, void *cq_s,
                         uint32_t port_id)
{
        uintptr_t work =3D gw[1];

        (void)type;
        (void)cq_s;
        (void)port_id;
        *((uintptr_t *)args + (gw[0] & 0x1)) =3D work;

        plt_atomic_thread_fence(__ATOMIC_ACQ_REL);
}

I.e tmp is 64 bits, and work_cb is referencing outside of that.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
