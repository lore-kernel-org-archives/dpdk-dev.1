Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDEE6BF20
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 16:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E5E1402E2;
	Fri, 30 Jan 2026 17:36:39 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 66B8740274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 17:36:38 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1F7154A31E; Fri, 30 Jan 2026 17:36:38 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1876] enic: pthread mutex in shared memory missing
 PTHREAD_PROCESS_SHARED (
Date: Fri, 30 Jan 2026 16:36:38 +0000
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
Message-ID: <bug-1876-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1876

            Bug ID: 1876
           Summary: enic: pthread mutex in shared memory missing
                    PTHREAD_PROCESS_SHARED (
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

This the enic driver portion of existing bug 662

The enic driver has a pthread mutex in shared memory that is initialized
without `PTHREAD_PROCESS_SHARED`, which causes undefined behavior when used
across multiple processes.

### Affected Mutex

1. **`enic->admin_chan_lock`** (`drivers/net/enic/enic_sriov.c`, line 352)
   - Location: `struct enic` (device private data)
   - Purpose: Protects SR-IOV admin channel operations between VF and PF

### Why This Is a Problem

The `struct enic` is the device private data accessed via
`eth_dev->data->dev_private`, which resides in shared memory accessible by =
both
primary and secondary processes.

The mutex is initialized in `enic_enable_vf_admin_chan()`:
```c
pthread_mutex_init(&enic->admin_chan_lock, NULL);
```

And used to protect admin channel operations:
```c
static void lock_admin_chan(struct enic *enic)
{
    pthread_mutex_lock(&enic->admin_chan_lock);
}

static void unlock_admin_chan(struct enic *enic)
{
    pthread_mutex_unlock(&enic->admin_chan_lock);
}
```

Per POSIX, mutexes in shared memory accessed by multiple processes must be
initialized with `PTHREAD_PROCESS_SHARED` attribute. Without this,
synchronization between processes is undefined behavior.

### Suggested Fix

Initialize the mutex with `PTHREAD_PROCESS_SHARED`:

```c
static void
enic_init_shared_mutex(pthread_mutex_t *mutex)
{
    pthread_mutexattr_t attr;

    pthread_mutexattr_init(&attr);
    pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
    pthread_mutex_init(mutex, &attr);
    pthread_mutexattr_destroy(&attr);
}
```

Then replace:
```c
pthread_mutex_init(&enic->admin_chan_lock, NULL);
```

With:
```c
enic_init_shared_mutex(&enic->admin_chan_lock);
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
