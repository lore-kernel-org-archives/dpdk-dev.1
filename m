Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C42606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mn2XSOiK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B9E740269;
	Sat, 24 Oct 2026 19:41:27 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 2186F4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 19:41:26 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-35943f55c06so2367094eec.0
 for <dev@dpdk.org>; Sat, 24 Oct 2026 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792863685; x=1793468485; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1dXYAWQjqOtAOG5MT/ocBZzSImbWKU6FUdqmmGV8A9U=;
 b=mn2XSOiK1cC/JErrBQC51lh1Cx2bZIVcEQLQjjYrFdrrjma+F5Phw7GPYRXKcZQYSN
 +rarJzkHnRuN0iyDLb+r3ceo1JnjChjwNvXs8QsjYN5XjTtpsF0hLkx8PCaPlciT5GS/
 ZZU/V/cBv4QF+s7K6pTd/YTcP4Py2/3SMV7zVLY3JZx6hgQ+kEUvTSNr54dTK/EaUXbw
 0o/w624Ytza2pUGk+3uwA+XQWyEdXut262s9aol6lUrvuVRGe1fpAclDxhANTiUBUdax
 FaPx56ddEk48x7+auC9wA9KLj616mOXOgMoQOgVhmojw3JIES98/EThyR+/i669xABo1
 ZdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863685; x=1793468485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1dXYAWQjqOtAOG5MT/ocBZzSImbWKU6FUdqmmGV8A9U=;
 b=Pygc+1QdNh1Sd0u4t7bng3MvLvGmTwdp3G1j8oNoncSvMXcH1fe6QeDTuQKH3rOIDH
 geFyP2968vlDOJGsVrv5tdHwsSO+wa/+IE7E8XwFxbjIhBu/VfKzdHJO4Onvo969z792
 Xf3mmJtODHjxMGcZrT07I9L9PWEPoUaBfLAD7AXtaMhYRcr6nxvq5bY7No4HtH24jPX8
 /vHYyNPDNZt4xh5+gbAEVJSvuU7e0sNDfjSQEj9dXZnXvtx47qAWtLiZ+5xBBYnXdtl+
 peW/GuhMuZs9hrae034hsqGmkgvXc4yTHNKNZQMpVgTTF4CThsqec19kFCYtXaRtMeZx
 WqHA==
X-Gm-Message-State: AFq9FYLFWrrN5Qx8xydB9gGUgEr2L8mfS73W7HXVdGQPEaDE4HeD8wAC
 uCk++LND+c6o6QS9BqarLWetJ88X79121tY7jnoUey/SuRmyCXx0IwPy
X-Gm-Gg: AYBFou0y3XX3HnRG5HTmhwr+CNRboODbzAPV18elFtT8ez0wb598YN0lTKD9vxp55sB
 ds1NJDL7vWeB74Iq5rMmixqTY9nCpA/kCpYSsaYyFK4YFRIrAcrzVpfO6LilQ0rImkKGVnSatuY
 Y2mkHDSRCQa4pJcnfRsVUpd52PgCzwuC22S+ym70E99A3es7jmDI0ogltZFYG5q16BRrOF04YuM
 jeBr+Ub+keHKOfdLwK1y4skXhT0vLw3UAxR3pfhR3MFWCZC6M4MOOCbAXSe/5VufuXkxTGeWfPk
 qJiAytBQ4BXNN8AgI0mMpbrRhwssg65WDV1Tx6wuM4GHs0OZIVlHFvp010K0tH4tVC24h82AiYq
 Wa+0rHOE5LmnygQHaanZW30BpOmEtkrfYiXXr3BSvNLXQHK1d+wx169WyU6HXl0xOmblAJSsQUv
 /blc+dISFgqjmo539kWUG4//6BjdZOmsDtXrzG1vW6pEz1aFArAfqtZ2pqyIIkLobWUnpOEqad8
 Bxjt1U16asznAGi7rjtYzZP4sSJ/2bFuDMW/SsUU0+fDP518Is3+V5+m3N6zrVnYsEwhinP4MVN
 2HXCxqfmdh8=
X-Received: by 2002:a05:693c:4146:10b0:351:2f0a:cb2a with SMTP id
 5a478bee46e88-369e83607admr3921969eec.2.1792863684774; 
 Sat, 24 Oct 2026 10:41:24 -0700 (PDT)
Received: from localhost ([2601:646:9e00:282:47e8:88ea:d50:a914])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369f27d5bf8sm3745996eec.4.2026.10.24.10.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:41:24 -0700 (PDT)
From: Kumar Sanghvi <divinekumar@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org,
	ksanghvi@zscaler.com
Subject: [PATCH] kernel/freebsd: add NUMA domain selection for contigmem
Date: Sat, 24 Oct 2026 10:41:17 -0700
Message-Id: <20261024174117.804304-1-divinekumar@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kumar Sanghvi <ksanghvi@zscaler.com>

On multi-socket systems, DPDK applications pin their threads to cores
on the socket local to the NIC, but the FreeBSD EAL reports all lcores
and all contigmem memory as socket 0, so an application has no way to
ask for local buffers. Physical placement is decided entirely by
contigmem, which allocates its buffers at module load with
contigmalloc(). That uses a round-robin domain policy, so the buffers
can land on a remote domain, and every DMA transfer and packet copy
then crosses the inter-socket interconnect.

Add a hw.contigmem.numa_domain loader tunable. When it is set to a
domain number, every buffer is allocated from that domain with
contigmalloc_domainset(DOMAINSET_FIXED()).

The placement is strict. If the domain cannot provide a buffer, the
module load fails and the requested domain is reported, rather than
buffers being silently placed elsewhere. An out-of-range value also
fails the load. The default, -1, keeps the existing behaviour of
allocating from any domain.

The tunable takes effect only at module load and is exposed read-only
through sysctl. EAL socket reporting is unchanged.

Usage:
  kenv hw.contigmem.numa_domain=1
  kldload contigmem

Tested on FreeBSD 13.2, dual-socket Intel Xeon Gold 6442Y (Sapphire
Rapids, 2 x 24 cores) with Intel E810 25G NICs attached to socket 1.
A DPDK application on socket 1 received packets with a poll-mode
driver and copied them to three packet-processing applications, also
on socket 1, driven by httperf TCP traffic (1000 connections, 128 KB
objects). Measured with Intel PCM (pcm, pcm-memory, pcm-numa) at
steady state, default round-robin placement vs. all buffers in
domain 1:
  - remote memory bandwidth of the poll-mode thread:
    ~1800 MB/s -> ~0 MB/s
  - incoming UPI traffic: 2340 MB/s -> 77 MB/s (-97%)
  - power: 7 W lower (5 W CPU + 2 W DIMM)

Signed-off-by: Kumar Sanghvi <ksanghvi@zscaler.com>
---
 .mailmap                               |  2 +-
 doc/guides/freebsd_gsg/build_dpdk.rst  | 23 +++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  5 ++++
 kernel/freebsd/contigmem/contigmem.c   | 34 +++++++++++++++++++++++---
 4 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..e1c99d2ba7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -915,7 +915,7 @@ Krzysztof Witek <krzysztof.witek@6wind.com>
 Kuan Xu <kuanx.xu@intel.com>
 Kuba Kozak <kubax.kozak@intel.com>
 Kumar Amber <kumar.amber@intel.com>
-Kumar Sanghvi <kumaras@chelsio.com>
+Kumar Sanghvi <ksanghvi@zscaler.com> <kumaras@chelsio.com>
 Kumara Parameshwaran <kumaraparamesh92@gmail.com> <kparameshwar@vmware.com>
 Kyle Larose <klarose@sandvine.com>
 Kyo Liu <kyo.liu@nebula-matrix.com>
diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index 9dafa64e84..509e06a6ac 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -107,6 +107,29 @@ Mapped buffers can be included in core dump using the following tunable::
    Buffers typically hold data processed by the application,
    like network packets, which may contain sensitive information.
 
+On multi-socket systems, the buffers can be allocated from a specific
+NUMA domain using the following tunable::
+
+   hw.contigmem.numa_domain=d
+
+Where d is a domain number from 0 to ``vm.ndomains`` - 1.
+Placing the buffers in the domain local to the NIC and to the cores
+running the DPDK application avoids cross-socket memory traffic.
+The default, -1, allocates buffers from any domain.
+The placement is strict: the module fails to load
+if the requested domain cannot provide all buffers
+or if the value is out of range.
+The tunable takes effect only when the module is loaded.
+The NUMA domain of a device can be found using
+``sysctl dev.<driver>.<unit>.%domain``,
+for example ``sysctl dev.ice.0.%domain``.
+
+.. note::
+
+   The FreeBSD EAL reports all lcores and all contigmem memory as socket 0.
+   This tunable changes only the physical placement of the buffers;
+   applications should keep requesting memory from socket 0 or ``SOCKET_ID_ANY``.
+
 The kernel environment variables can also be specified during boot by placing the
 following in ``/boot/loader.conf``:
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..9e66c6907f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added NUMA domain selection to the FreeBSD contigmem module.**
+
+  Added the ``hw.contigmem.numa_domain`` tunable
+  to allocate contigmem buffers from a chosen NUMA domain.
+
 * **Added division round up macro.**
 
   Added the ``RTE_DIV_ROUND_UP`` macro in ``rte_common.h``
diff --git a/kernel/freebsd/contigmem/contigmem.c b/kernel/freebsd/contigmem/contigmem.c
index cb9298c9c6..441ce51644 100644
--- a/kernel/freebsd/contigmem/contigmem.c
+++ b/kernel/freebsd/contigmem/contigmem.c
@@ -20,6 +20,7 @@ __FBSDID("$FreeBSD$");
 #include <sys/sysctl.h>
 #include <sys/vmmeter.h>
 #include <sys/eventhandler.h>
+#include <sys/domainset.h>
 
 #include <machine/bus.h>
 
@@ -59,10 +60,14 @@ static struct contigmem_buffer contigmem_buffers[RTE_CONTIGMEM_MAX_NUM_BUFS];
 static struct cdev     *contigmem_cdev = NULL;
 static int              contigmem_refcnt;
 
+/* -1 = any domain (default) */
+static int contigmem_numa_domain = -1;
+
 TUNABLE_INT("hw.contigmem.num_buffers", &contigmem_num_buffers);
 TUNABLE_QUAD("hw.contigmem.buffer_size", &contigmem_buffer_size);
 TUNABLE_QUAD("hw.contigmem.buffer_size_MB", &contigmem_buffer_size_MB);
 TUNABLE_BOOL("hw.contigmem.coredump_enable", &contigmem_coredump_enable);
+TUNABLE_INT("hw.contigmem.numa_domain", &contigmem_numa_domain);
 
 static SYSCTL_NODE(_hw, OID_AUTO, contigmem, CTLFLAG_RD, 0, "contigmem");
 
@@ -77,6 +82,9 @@ SYSCTL_INT(_hw_contigmem, OID_AUTO, num_references, CTLFLAG_RD,
 	&contigmem_refcnt, 0, "Number of references to contigmem");
 SYSCTL_BOOL(_hw_contigmem, OID_AUTO, coredump_enable, CTLFLAG_RD,
 	&contigmem_coredump_enable, 0, "Include mapped buffers in core dump");
+SYSCTL_INT(_hw_contigmem, OID_AUTO, numa_domain, CTLFLAG_RD,
+	&contigmem_numa_domain, 0,
+	"NUMA domain for buffer allocation (-1 = any domain)");
 
 static SYSCTL_NODE(_hw_contigmem, OID_AUTO, physaddr, CTLFLAG_RD, 0,
 	"physaddr");
@@ -150,11 +158,31 @@ contigmem_load(void)
 		goto error;
 	}
 
+	if (contigmem_numa_domain < -1 ||
+			contigmem_numa_domain >= vm_ndomains) {
+		printf("contigmem: invalid numa_domain %d (valid: -1 to %d)\n",
+				contigmem_numa_domain, vm_ndomains - 1);
+		error = EINVAL;
+		goto error;
+	}
+
 	for (i = 0; i < contigmem_num_buffers; i++) {
-		addr = contigmalloc(contigmem_buffer_size, M_CONTIGMEM, M_ZERO,
-			0, BUS_SPACE_MAXADDR, contigmem_buffer_size, 0);
+		if (contigmem_numa_domain >= 0)
+			addr = contigmalloc_domainset(contigmem_buffer_size,
+				M_CONTIGMEM,
+				DOMAINSET_FIXED(contigmem_numa_domain),
+				M_ZERO, 0, BUS_SPACE_MAXADDR,
+				contigmem_buffer_size, 0);
+		else
+			addr = contigmalloc(contigmem_buffer_size, M_CONTIGMEM,
+				M_ZERO, 0, BUS_SPACE_MAXADDR,
+				contigmem_buffer_size, 0);
 		if (addr == NULL) {
-			printf("contigmalloc failed for buffer %d\n", i);
+			if (contigmem_numa_domain >= 0)
+				printf("contigmem: buffer %d: no contiguous memory in NUMA domain %d\n",
+						i, contigmem_numa_domain);
+			else
+				printf("contigmalloc failed for buffer %d\n", i);
 			error = ENOMEM;
 			goto error;
 		}
-- 
2.50.1 (Apple Git-155)

