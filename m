Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2DBD2FEC6
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:41:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AC2340E50;
	Tue, 27 Jan 2026 18:41:52 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2662C40E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:41:50 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 12E604A2F5; Tue, 27 Jan 2026 18:41:50 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1873] eal interrupt: fd error conditions not handled
Date: Tue, 27 Jan 2026 17:41:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1873-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1873

            Bug ID: 1873
           Summary: eal interrupt: fd error conditions not handled
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: ktraynor@redhat.com
  Target Milestone: ---

The DPDK interrupt handling thread enters a busy-loop when epoll error
conditions (EPOLLERR, EPOLLHUP, EPOLLRDHUP) occur on interrupt file
descriptors. This means that the dpdk-intr thread will run at 100% cpu
consumption.

When an interrupt file descriptor enters an error state or experiences a
hangup, the interrupt handling code in eal_intr_process_interrupts() does n=
ot
properly detect or handle these conditions. The epoll events EPOLLERR,
EPOLLHUP, and EPOLLRDHUP indicate critical issues with the file descriptor,=
 but
the current code attempts to read from the fd without first checking for th=
ese
error conditions.=20=20=20=20

This results in:
  1. The interrupt continuing to fire repeatedly
  2. The error condition never being cleared
  3. The interrupt thread entering a busy-loop, consuming 100% CPU on a cor=
e=20

This is generic issue that could happen to any interrupt read directly in t=
he
eal interrupt code or passed to a registered handler for external processin=
g.

I have reproduced this issue in multiple ways such as unbinding a device,
bonding a device,  manually deleting the fd.

To give an example of a normal use case where this might occur:
- A DPDK application starts, eal init and there are some mlx devices probed.
- These devices are not used by DPDK, but later are used to form a linux bo=
nd.
- As part of LAG setup, the mlx5_core kernel driver removes the current dev=
ices
and fd's.
- Removal of the interrupt fd triggers a mlx devx interrupt with EPOLLRDHUP=
 in
DPDK.
- This is passed to the mlx devx interrupt handler, which does a read and g=
ets
an EAGAIN
- As the condition is not cleared, the next epoll_wait returns immediately =
with
the same event and so we loop


This issue can also occur with devices that are used in DPDK, but it would =
not
be expected to unbind a mlx device from the mlx5_core kernel driver when in
use.

Testpmd has some additional handling of RTE_ETH_EVENT_INTR_RMV which in some
cases may break the busy-loop by detaching the device, but this will not wo=
rk
in every case and an application should not have to register for this event=
 and
rely on it triggering in order to resolve the issue.

Example to reproduce:

# dpdk-testpmd -l 8,9 -- -i
EAL: Detected CPU lcores: 56
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
Interactive-mode selected
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 0
testpmd: Flow tunnel offload support might be limited or unavailable on por=
t 1
testpmd: create a new mbuf pool <mb_pool_0>: n=3D155456, size=3D2176, socke=
t=3D0
testpmd: preferred mempool ops selected: ring_mp_mc
testpmd: create a new mbuf pool <mb_pool_1>: n=3D155456, size=3D2176, socke=
t=3D1
testpmd: preferred mempool ops selected: ring_mp_mc
Configuring Port 0 (socket 0)
Port 0: 04:3F:72:C2:07:B8
Configuring Port 1 (socket 0)
Port 1: 04:3F:72:C2:07:B9
Checking link statuses...
Done

testpmd>

# top -H -p $(pidof dpdk-testpmd)
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND=20=20
 164848 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:01.08
dpdk-testpmd=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164849 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-intr=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164850 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-mp-msg=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164851 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-worker9=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164852 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-telemet-v2=20=20=20=20=20=20

testpmd> port stop 0

# top -H -p $(pidof dpdk-testpmd)
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND=20=20
 164848 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:01.08
dpdk-testpmd=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164849 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-intr=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164850 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-mp-msg=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164851 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-worker9=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164852 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-telemet-v2=20=20=20=20=20

# echo "0000:06:00.0" > /sys/bus/pci/drivers/mlx5_core/unbind

# top -H -p $(pidof dpdk-testpmd)
    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND=20=20
 164849 root      20   0  128.5g 434112  75264 R  99.9   0.2   0:07.87
dpdk-intr=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164848 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:01.08
dpdk-testpmd=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164850 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-mp-msg=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164851 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-worker9=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
 164852 root      20   0  128.5g 434112  75264 S   0.0   0.2   0:00.00
dpdk-telemet-v2=20=20=20


# strace -p $(ps -T -p $(pidof dpdk-testpmd) | grep dpdk-intr | awk '{print
$2}')

epoll_wait(6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}],=
 8, -1) =3D 1
read(28, 0x7f1f5c7fc2f0, 40)            =3D -1 EAGAIN (Resource temporarily
unavailable)
epoll_wait(6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}],=
 8, -1) =3D 1
read(28, 0x7f1f5c7fc2f0, 40)            =3D -1 EAGAIN (Resource temporarily
unavailable)
epoll_wait(6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}],=
 8, -1) =3D 1
read(28, 0x7f1f5c7fc2f0, 40)            =3D -1 EAGAIN (Resource temporarily
unavailable)
epoll_wait(6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}],=
 8, -1) =3D 1
read(28, 0x7f1f5c7fc2f0, 40)            =3D -1 EAGAIN (Resource temporarily
unavailable)
epoll_wait(6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}],=
 8, -1) =3D 1
read(28, 0x7f1f5c7fc2f0, 40)            =3D -1 EAGAIN (Resource temporarily
unavailable)
epoll_wait(6, [{events=3DEPOLLIN|EPOLLRDHUP, data=3D{u32=3D28, u64=3D28}}],=
 8, -1) =3D 1
<snip>

I will send shortly an eal patch that will check for (EPOLLERR, EPOLLHUP,
EPOLLRDHUP) in the fd events and remove any interrupts that have these even=
ts,
preventing a busy loop.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
