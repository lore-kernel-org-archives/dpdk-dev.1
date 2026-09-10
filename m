Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB60C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 12:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 298AE410DC;
	Thu, 10 Sep 2026 14:30:00 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B97E94028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 14:29:58 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A93344D070; Thu, 10 Sep 2026 14:29:58 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/eventdev Bug 2034] eventdev: dangling pointer on error path in
 rxa_sw_add()
Date: Thu, 10 Sep 2026 12:29:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: eventdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yangshuaisong@h-partners.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2034-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2034

            Bug ID: 2034
           Summary: eventdev: dangling pointer on error path in
                    rxa_sw_add()
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: eventdev
          Assignee: dev@dpdk.org
          Reporter: yangshuaisong@h-partners.com
  Target Milestone: ---

[Overview]
A code quality / dangling pointer issue was identified via static analysis =
in
the eventdev library. In `rxa_sw_add()`, a newly allocated buffer is attach=
ed
to a structure pointer before all resource allocations succeed. If a subseq=
uent
allocation fails, the buffer memory is freed, but the structure pointer is =
not
cleared, leaving a dangling pointer (`queue_info->event_buf`).

[Location]
- File: lib/eventdev/rte_event_eth_rx_adapter.c
- Function: `rxa_sw_add()`
- Lines: 2175, 2181-2187 (or adjacent lines depending on version)

[Environment & Build]
- DPDK Version: [26.03]
- OS / Kernel: Generic
- Tool: Identified via static code analysis / code audit.

[Vulnerability Logic & Analysis]
Looking at the implementation of `rxa_sw_add()`:
1. At line 2175, the newly allocated event buffer `new_rx_buf` is assigned =
to
the queue information structure:
   ```c
   queue_info->event_buf =3D new_rx_buf;
   ```
2. Subsequently, at lines 2181-2187, the function attempts to allocate memo=
ry
for `stats`. If `stats =3D=3D NULL` (allocation failure), it rolls back by =
freeing
the sub-elements and the buffer itself:
   ```c
   if (stats =3D=3D NULL) {
       rte_free(new_rx_buf->events);
       rte_free(new_rx_buf);
       RTE_EDEV_LOG_ERR(...);
       return -ENOMEM;
   }
   ```
3. However, during this error path and cleanup, `queue_info->event_buf` is
never reset to `NULL`. It retains the memory address of `new_rx_buf` which =
has
already been freed via `rte_free(new_rx_buf)`.

[Actual Results]
Currently, this does not immediately trigger an exploitable Use-After-Free
(UAF) because the queue is rolled back and not marked as "active/added" in =
this
specific lifecycle phase. However, leaving a dangling pointer is a classic
anti-pattern that severely damages code robustness. If `queue_info` is reus=
ed
or retried in the future, it might lead to a latent Use-After-Free.

[Expected Results]
Pointers should always be safely cleared when the memory they reference is
freed, or resource attachments should only happen after all potential
allocation failures have been safely cleared.

[Suggested Fix]
Option A: Simply reset the pointer to NULL immediately after freeing the me=
mory
in the error block:
```c
if (stats =3D=3D NULL) {
    rte_free(new_rx_buf->events);
    rte_free(new_rx_buf);
    queue_info->event_buf =3D NULL; /* Avoid dangling pointer */
    ...
    return -ENOMEM;
}
```

Option B (Preferred): Postpone the pointer assignment until all allocations
(including stats) have fully succeeded:
```c
/* Move this assignment down, after the stats NULL check */
queue_info->event_buf =3D new_rx_buf;
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
