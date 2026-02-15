Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E114CE63F07
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 18:02:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D07940274;
	Sun, 15 Feb 2026 19:02:17 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 005E340269
 for <dev@dpdk.org>; Sun, 15 Feb 2026 19:02:16 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EFAA84A639; Sun, 15 Feb 2026 19:02:15 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1881] tap: leaks in error paths
Date: Sun, 15 Feb 2026 18:02:16 +0000
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
Message-ID: <bug-1881-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1881

            Bug ID: 1881
           Summary: tap: leaks in error paths
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

AI found these leaks

Error =E2=80=94 Correctness Bugs:

    eth_dev_tap_create() error path leaks process_private (rte_eth_tap.c:22=
16)
=E2=80=94 The error_exit label frees nlsk_fd, ka_fd, intr_handle, and relea=
ses the
port, but never calls free(dev->process_private). Every failed creation past
the malloc leaks that allocation.
    eth_dev_tap_create() leaks ethdev port on process_private malloc failure
(rte_eth_tap.c:2031) =E2=80=94 Does return -1 directly instead of jumping t=
o a cleanup
label, so the dev from rte_eth_vdev_allocate() is never released.
    Secondary process probe has 4 leaking error paths (rte_eth_tap.c:2509=
=E2=80=932545)
=E2=80=94 If rte_eal_primary_proc_alive() fails, process_private malloc fai=
ls,
tap_mp_attach_queues() fails, or rte_mp_action_register() fails, the functi=
on
returns -1 without freeing process_private or releasing eth_dev.
    tap_mp_attach_queues() leaks IPC reply buffer (rte_eth_tap.c:2425) =E2=
=80=94 When
q_count !=3D num_fds, returns -1 without calling free(reply). The
rte_mp_request_sync() API requires the caller to free replies.msgs.
    Use-after-free in tap_flow_create() (tap_flow.c:1284/1333) =E2=80=94 fl=
ow is
inserted into pmd->flows at line 1284. If remote flow creation then fails, =
goto
fail calls tap_flow_free() which frees the memory but never calls
LIST_REMOVE(). The dangling pointer stays in the list and will be dereferen=
ced
by tap_flow_flush().
    tap_flow_implicit_create() leaks remote_flow on EEXIST (tap_flow.c:1622=
) =E2=80=94
When the kernel returns EEXIST (rule already exists), the code jumps to suc=
cess
returning 0, but the remote_flow allocated at line 1567 is neither freed nor
inserted into the list.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
