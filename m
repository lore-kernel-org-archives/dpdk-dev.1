Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD4C83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 11:46:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DF13402D7;
	Thu, 17 Jul 2025 13:46:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 06E9A400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 13:46:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752752781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HC1A7NRUlKUw2t5d2+3RbnoPWbVVbGdYmFik2mN396o=;
 b=aRoWh5LNX9qKQNUCVlLc6QpS8DrHQxTzaXIvUtp98Y9Z2SIuFvg2rVXdDC8ePEQ6aD8o/X
 4QSBn3Ja/dKgmDOabRUaboo9kWgBZLWWFRH26Sl+gopBQrNqx/a6puRija0P1Vg1xN7vqh
 hIC8k0UfbyvpcAxyeSd8eBCU29ZA/04=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-XZcm-1yUN5ir4RFYDfNOaQ-1; Thu,
 17 Jul 2025 07:46:18 -0400
X-MC-Unique: XZcm-1yUN5ir4RFYDfNOaQ-1
X-Mimecast-MFC-AGG-ID: XZcm-1yUN5ir4RFYDfNOaQ_1752752777
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB39F195608B; Thu, 17 Jul 2025 11:46:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D61D195608D; Thu, 17 Jul 2025 11:46:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	bruce.richardson@intel.com
Subject: [PATCH 2/2] doc: use common description of EAL parameters
Date: Thu, 17 Jul 2025 13:46:04 +0200
Message-ID: <20250717114604.2285791-2-david.marchand@redhat.com>
In-Reply-To: <20250717114604.2285791-1-david.marchand@redhat.com>
References: <20250717114604.2285791-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ct8aiRSUXeI5A0kFPsyhvuAVra6TSOZbMy8QYtaw0M_1752752777
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Rather than have a subset of the EAL parameters described in the sample
apps documentation, prefer referring to the full list.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/freebsd_gsg/build_sample_apps.rst | 33 +--------
 doc/guides/linux_gsg/build_sample_apps.rst   | 75 +-------------------
 2 files changed, 2 insertions(+), 106 deletions(-)

diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index 5212c1a0b4..db01b16e18 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -57,38 +57,7 @@ Running a Sample Application
     Abstraction Layer (EAL) library, which provides some options that are generic
     to every DPDK application.
 
-A large number of options can be given to the EAL when running an
-application. A full list of options can be got by passing `--help` to a
-DPDK application. Some of the EAL options for FreeBSD are as follows:
-
-*   ``-l CORELIST``:
-    A comma-separated list of the cores, or ranges of cores to run on.
-    For example, ``-l 0,1,4-6`` will run on cores 0, 1, 4, 5 and 6.
-    Note that core numbering can change between platforms and should be determined beforehand.
-
-*   ``-b <domain:bus:devid.func>``:
-    Blocklisting of ports; prevent EAL from using specified PCI device
-    (multiple ``-b`` options are allowed).
-
-*   ``-v``:
-    Display version information on startup.
-
-*   ``-m MB``:
-    Memory to allocate from hugepages, regardless of processor socket.
-
-Other options, specific to Linux and are not supported under FreeBSD are as follows:
-
-*   ``socket-mem``:
-    Memory to allocate from hugepages on specific sockets.
-
-*   ``--huge-dir``:
-    The directory where hugetlbfs is mounted.
-
-*   ``--mbuf-pool-ops-name``:
-    Pool ops name for mbuf to use.
-
-*   ``--file-prefix``:
-    The prefix text used for hugepage filenames.
+You can refer to :doc:`freebsd_eal_parameters` for the list of EAL options.
 
 .. _running_non_root:
 
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index aed184fc33..49f88357da 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -29,80 +29,7 @@ Running a Sample Application
 The application is linked with the DPDK target environment's Environmental Abstraction Layer (EAL) library,
 which provides some options that are generic to every DPDK application.
 
-The following is the list of options that can be given to the EAL:
-
-.. code-block:: console
-
-    ./rte-app [-l CORELIST] [-n NUM] [-b <domain:bus:devid.func>] \
-              [--numa-mem=MB,...] [-d LIB.so|DIR] [-m MB] [-r NUM] [-v] [--file-prefix] \
-	      [--proc-type <primary|secondary|auto>]
-
-The EAL options are as follows:
-
-* ``-l CORELIST``:
-  A comma-separated list of the cores, or ranges of cores to run on.
-  For example, ``-l 0,1,4-6`` will run on cores 0, 1, 4, 5 and 6.
-  Note that core numbering can change between platforms and should be determined beforehand.
-
-* ``-n NUM``:
-  Number of memory channels per processor socket.
-
-* ``-b <domain:bus:devid.func>``:
-  Blocklisting of ports; prevent EAL from using specified PCI device
-  (multiple ``-b`` options are allowed).
-
-* ``--numa-mem``:
-  Memory to allocate from hugepages on specific sockets. In dynamic memory mode,
-  this memory will also be pinned (i.e. not released back to the system until
-  application closes).
-
-* ``--numa-limit``:
-  Limit maximum memory available for allocation on each socket. Does not support
-  legacy memory mode.
-
-* ``-d``:
-  Add a driver or driver directory to be loaded.
-  The application should use this option to load the PMDs
-  that are built as shared libraries.
-
-* ``-m MB``:
-  Memory to allocate from hugepages, regardless of processor socket. It is
-  recommended that ``--numa-mem`` be used instead of this option.
-
-* ``-r NUM``:
-  Number of memory ranks.
-
-* ``-v``:
-  Display version information on startup.
-
-* ``--huge-dir``:
-  The directory where hugetlbfs is mounted.
-
-* ``--mbuf-pool-ops-name``:
-  Pool ops name for mbuf to use.
-
-* ``--file-prefix``:
-  The prefix text used for hugepage filenames.
-
-* ``--proc-type``:
-  The type of process instance.
-
-* ``--vmware-tsc-map``:
-  Use VMware TSC map instead of native RDTSC.
-
-* ``--base-virtaddr``:
-  Specify base virtual address.
-
-* ``--vfio-intr``:
-  Specify interrupt type to be used by VFIO (has no effect if VFIO is not used).
-
-* ``--legacy-mem``:
-  Run DPDK in legacy memory mode (disable memory reserve/unreserve at runtime,
-  but provide more IOVA-contiguous memory).
-
-* ``--single-file-segments``:
-  Store memory segments in fewer files (dynamic memory mode only - does not
-  affect legacy memory mode).
+You can refer to :doc:`linux_eal_parameters` for the list of EAL options.
 
 Copy the DPDK application binary to your target, then run the application as follows
 (assuming the platform has four memory channels per processor socket,
-- 
2.50.0

