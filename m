Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED9E6BF2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 16:33:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48DD6402AF;
	Fri, 30 Jan 2026 17:33:09 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 53EB940274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 17:33:08 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3E3184A31E; Fri, 30 Jan 2026 17:33:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1875] mlx5: pthread mutex in shared memory missing
 PTHREAD_PROCESS_SHARED
Date: Fri, 30 Jan 2026 16:33:08 +0000
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
Message-ID: <bug-1875-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1875

            Bug ID: 1875
           Summary: mlx5: pthread mutex in shared memory missing
                    PTHREAD_PROCESS_SHARED
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

This is the mlx5 subset of bugzilla 662

The mlx5 specific analysis was:

## MLX5 Driver PTHREAD_PROCESS_SHARED Issue

### Summary

The mlx5 driver has pthread mutexes in shared memory that are initialized
without `PTHREAD_PROCESS_SHARED`, which causes undefined behavior when used
across multiple processes.

### Affected Mutexes

1. **`sh->txpp.mutex`** (`drivers/net/mlx5/mlx5.c`, line 1846)
   - Location: `struct mlx5_dev_txpp` inside `struct mlx5_dev_ctx_shared`
   - Purpose: Pacing create/destroy mutex for Tx packet pacing

2. **`sh->lwm_config_lock`** (`drivers/net/mlx5/mlx5.c`, line 1963)
   - Location: `struct mlx5_dev_ctx_shared`
   - Purpose: Low watermark configuration lock

### Why This Is a Problem

The `mlx5_dev_ctx_shared` structure is allocated via `mlx5_malloc(MLX5_MEM_=
ZERO
| MLX5_MEM_RTE, ...)` which uses hugepage-backed shared memory. This shared
context is accessible by both primary and secondary processes.

While the shared context is only **allocated** in the primary process (enfo=
rced
by assertion at line 1826), secondary processes can obtain a reference to t=
his
shared context and potentially call operations that lock these mutexes.

Per POSIX, mutexes in shared memory accessed by multiple processes must be
initialized with `PTHREAD_PROCESS_SHARED` attribute. Without this,
synchronization between processes is undefined behavior.

### Note

A third mutex, `mlx5_dev_ctx_list_mutex` (line 201), is a static global
variable and is **not affected** since each process has its own copy.

### Suggested Fix

Initialize the mutexes with `PTHREAD_PROCESS_SHARED`:

```c
static void
mlx5_init_shared_mutex(pthread_mutex_t *mutex)
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
pthread_mutex_init(&sh->txpp.mutex, NULL);
pthread_mutex_init(&priv->sh->lwm_config_lock, NULL);
```

With:
```c
mlx5_init_shared_mutex(&sh->txpp.mutex);
mlx5_init_shared_mutex(&priv->sh->lwm_config_lock);
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
