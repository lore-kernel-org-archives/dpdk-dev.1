Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C01CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 09:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34FC540290;
	Mon,  5 Oct 2026 11:47:18 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 014634028E
 for <dev@dpdk.org>; Mon,  5 Oct 2026 11:47:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E03374BFF6; Mon,  5 Oct 2026 11:47:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2049] net/af_packet and other vdevs segfaults when
 created with the global devargs syntax
Date: Mon, 05 Oct 2026 09:47:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: frank@dressler.pro
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2049-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2049

            Bug ID: 2049
           Summary: net/af_packet and other vdevs segfaults when created
                    with the global devargs syntax
           Product: DPDK
           Version: 21.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: frank@dressler.pro
  Target Milestone: ---

DPDK can be crashed (SEGFAULT; `strdup(NULL)`) via unusual devargs.

```
dpdk-testpmd --vdev bus=3Dvdev,name=3Dnet_vhost0
dpdk-testpmd --vdev bus=3Dvdev,name=3Dnet_af_packet0
...
dpdk-testpmd --a bus=3Dvdev,name=3Dnet_vhost0
dpdk-testpmd --a bus=3Dvdev,name=3Dnet_af_packet0
...
```

Bug exists since 2021, commit b344eb5d941a, which added the "global device
syntax" (`bus=3DX,paramX=3Dx/class=3DY,paramY=3Dy/driver=3DZ,paramZ=3Dz`) t=
hat can be used
in `-a`/`-b`,`-vdev`. That change calls the other way "legacy" but is not a
fully-capable replacement since it lacks the ability to intentionally speci=
fy
`struct rte_devargs::args` that many PMDs rely on.

Cause for the crash is that `struct rte_devargs::args` is not set when the
"global device syntax" is used and some PMDs `strdup` it without checking f=
or
`NULL`. The `args` sits in a union with `drv_str` in `struct rte_devargs`.
which can hence be set indirectly via, e.g.:

```
dpdk-testpmd --vdev bus=3Dvdev,name=3Dnet_af_packet0/driver=3Dabc
```

which would prevent the crash because that sets `drv_str` which is in a uni=
on
with the `args` that gets `strdup`ed. An almost working string would then l=
ook
as follows

```
dpdk-testpmd --vdev bus=3Dvdev,name=3Dnet_af_packet0/driver=3Dabc,iface=3Dlo
```

since the AF_PACKET PMD requires the `iface`. But the AF_PACKET PMD would
reject that since `args` is the whole `driver=3Dabc,iface=3Dlo` and `driver=
` is not
among the acceptable keys.

I think the fix might be to add an "anonymous" (or "args") layer and
de`union`ize `args/`dev_str`. This would allow

```
dpdk-testpmd --vdev bus=3Dvdev,name=3Dnet_af_packet0/driver=3Dabc/iface=3Dlo
```

Whatever layer does not start with `bus=3D`, `driver=3D`, or `class=3D` wou=
ld be this
"anonymous"/"args" layer and end up in `struct rte_devargs::args` which cou=
ld
be initialized to the empty string so that the existing code does not crash
when the `args` are not specified.

Alternatively, one could keep using the `driver` layer and either not pass =
down
the `driver=3D...` to the PMD or add `driver` to the list of allowed keys.

I have no idea how to properly fix it.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
