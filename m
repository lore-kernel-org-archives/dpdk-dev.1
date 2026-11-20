Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F076076C71
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 18:17:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19F7F402DF;
	Fri, 20 Nov 2026 19:17:20 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 399B4400D7
 for <dev@dpdk.org>; Fri, 20 Nov 2026 19:17:18 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 21EEA4DE6A; Fri, 20 Nov 2026 19:17:18 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1294] recieve sig 11 when call
 rte_ip_frag_table_create on primary forked process
Date: Fri, 20 Nov 2026 18:17:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-1294-3-1sEvXA3xcH@https.bugs.dpdk.org/>
In-Reply-To: <bug-1294-3@https.bugs.dpdk.org/>
References: <bug-1294-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D1294

Stephen Hemminger (stephen@networkplumber.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
                 CC|                            |stephen@networkplumber.org
         Resolution|---                         |WONTFIX

--- Comment #1 from Stephen Hemminger (stephen@networkplumber.org) ---
The DPDK does not support forking of the primary process after rte_eal_init=
 is
called.
There are many internal parts of DPDK that depend on this.


More detailed AI explanation:
DPDK does not support fork() after rte_eal_init(). The child is
neither a valid primary nor a secondary process.

What breaks:

 - Hugepage memory and the heap/memseg metadata in mem_config are
   MAP_SHARED, so parent and child share the same malloc heap.
   Page mappings, however, are per process.

 - When the child needs more memory it calls alloc_more_mem_on_socket()
   as if it were the primary. It maps new hugepages into its own
   address space only and links the new elements into the shared heap
   free list. The parent and any other child never mapped those pages.
   In normal multi-process this is kept in sync over the mp IPC channel,
   which the forked child does not take part in.

 - The second child inherits a heap whose free list points into pages
   that only the first child had mapped. The first heap walk in
   malloc_elem_insert() dereferences one of them, giving SIGSEGV. That
   matches your backtrace and why the first fork appears to work.

 - Only the calling thread survives fork(). The interrupt thread, mp
   handler thread and lcore workers do not exist in the child, and any
   spinlock in shared memory that was held at fork time stays held.
   Device fds (VFIO, uio, memfd) are also shared with the parent.

Options:

 - Run the business logic as a DPDK secondary process
   (--proc-type=3Dsecondary, started with fork+exec or separately).
   You can restart it as often as you like without disturbing the
   primary.
 - Run it in threads inside the primary.
 - fork() before calling rte_eal_init(), and keep DPDK only in the
   process that initializes EAL.

Closing as not a bug.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
