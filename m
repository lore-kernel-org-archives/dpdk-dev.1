Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C79C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40BE440DD7;
	Tue, 22 Jul 2025 19:36:17 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id F11B440C35
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:14 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e278d8345aso560263885a.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205774;
 x=1753810574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZhFR2poswM6/SvQYIQPoLeSX0qGjfSS4rHMYBq+2Qg=;
 b=oXy1HPOHrv3nt2qEI2WAYiYYVKuCpjojZvffIQSOWzqAOdRGqSj/lAlmz9a2Wbgy/s
 DFKVs6OMXEwjyCwsyMkhPKqv/Wg0Y1CVJuQMMYGWfMv7UNPVnKhDVr9y51v1FSk9TI+w
 gs4v3sCZTyo1J8MFq8aAktYn5iL4/NxnnwznmYaxqHcvQehIrSCKSkfcJk7+m+F6ke/g
 QGifY4VSYZrPL82JYDKvXInR0MYjjEZ+KnB5FmhCzNhkRWEKX2K5zuxbfnJgJW3BeOXA
 hXo2T2Tnn8aY1swuIQIfbdR7kcGDmK2Cqt6zgiFF5Y3Jcz1yiJeHtw1dENLoydeqMw0S
 nj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205774; x=1753810574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZhFR2poswM6/SvQYIQPoLeSX0qGjfSS4rHMYBq+2Qg=;
 b=hh3pqSLM07JOjNwmlQAsJo8DfJSX0CkV04Xmcajq63a+AqVEZbtGLPvzwfE6tzWM8A
 3C3AzuFpRR7XbFsrG23VNU1RgnB+X4tCfL6h51yGHbj8OJ2S4CVtO+BI6az8BR/OsuTC
 /Zc6/0eDZEdAtHX+ILJkDZbjpSDUz5OD/yLdKgQaoZ4Ff7yUZu5ApG2uTDcPc2FPCB8i
 a2A1PvZ8FOzItqFRtzdNJbjI5jKuavGGT57/S3R7L6j4p+GF0af5iytg+tjYhp3Wwd+C
 B/XVeD7Ov9zw4KyWLGoe/3mVqBfzpj9OqoT3/fnphjxEUfvXqZS3Sy43CowN8ltLdp9g
 0yZw==
X-Gm-Message-State: AOJu0YzRTRtb1K1TmEzL3WgFJxAMwiB68EOGpxoqHeO/tHT30tKOjfiX
 l6b9ga5e9vlZAVJEYAdFyIM/LZWdXvgjLjUNOfRJkPwt22yejYpyQ6AsJOUG/YYWKf0nLGn6LEB
 ZtpKF
X-Gm-Gg: ASbGncskwxfGTl5Rdsi1BWh67PWJdMKFxS3YrjWmNvFB8yrCviFy9mB0z62jPocq0W7
 V7f+8U3uGsEELiNREbaxLp8vXB30bKGIXQ8644rJmE4HojXLE0s6XAk4xcn02TPUTZmaZ9I+6FA
 Pe5P7acLfAKy4VerbOiznBTeirozKgpQm/q/aRLLjd3UnRERbuJivMW3uG/KDMaktqkgup9x85D
 K5QHQxNPFztHXOXRN7rro5MB2D6HYI+u7H1J09D90pAmo2neaIcmpR91iJz6Q6gmdC32XT7T2VD
 pGfkkyM1v1J1r0+TrTnk9+/MIvg+icOEL4L7sbrLPnEBTF4fe+gfQEr9RoRwTM+NiueGVLehtiL
 IeOdKb0YVyz/c2H14fVsvNnczACRNkFA3eQ2buCIEElMH3yzBmFkSXYtsF7vR9TrzY8mbutWP
X-Google-Smtp-Source: AGHT+IHBgwz7FQpD1yjrYgPpO65swyY5Uft85VfPr2QXc6zsfuuSGsMyws7uxjOj4YZaBs8F+8OhJA==
X-Received: by 2002:a05:620a:22e7:b0:7e3:46ad:65f9 with SMTP id
 af79cd13be357-7e62a0e15d7mr15865585a.23.1753205773988; 
 Tue, 22 Jul 2025 10:36:13 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:36:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v6 13/13] pdump: mark API and application as deprecated
Date: Tue, 22 Jul 2025 10:34:44 -0700
Message-ID: <20250722173552.184141-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When the pdump application is run print a warning.
Add release note about deprecation and mark the API's
as deprecated.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c                              |  3 +++
 app/pdump/meson.build                         |  1 +
 app/test-pmd/meson.build                      |  1 +
 app/test/meson.build                          |  6 +++++-
 doc/guides/howto/packet_capture_framework.rst | 15 +++++++++------
 doc/guides/nics/bnxt.rst                      |  2 +-
 doc/guides/prog_guide/ethdev/index.rst        |  1 +
 doc/guides/prog_guide/pdump_lib.rst           |  4 ++++
 doc/guides/rel_notes/deprecation.rst          |  3 +++
 doc/guides/tools/pdump.rst                    |  2 ++
 lib/pdump/rte_pdump.h                         | 12 +++++++++---
 11 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..a4e0f4e5ae 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -986,6 +986,9 @@ main(int argc, char **argv)
 	char mp_flag[] = "--proc-type=secondary";
 	char *argp[argc + 2];
 
+
+	fprintf(stderr, "%s: is deprecated use dpdk-dumpcap instead\n", argv[0]);
+
 	/* catch ctrl-c so we can cleanup on exit */
 	sigemptyset(&action.sa_mask);
 	sigaction(SIGTERM, &action, NULL);
diff --git a/app/pdump/meson.build b/app/pdump/meson.build
index a4c7dd44e7..1fe034fcb8 100644
--- a/app/pdump/meson.build
+++ b/app/pdump/meson.build
@@ -11,3 +11,4 @@ sources = files('main.c')
 deps += ['ethdev', 'kvargs', 'pdump']
 
 cflags += no_wvla_cflag
+cflags += '-Wno-deprecated-declarations'
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index e67665028f..3ab8280ce7 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -60,6 +60,7 @@ if dpdk_conf.has('RTE_LIB_METRICS')
 endif
 if dpdk_conf.has('RTE_LIB_PDUMP')
     deps += 'pdump'
+    cflags += '-Wno-deprecated-declarations'
 endif
 if dpdk_conf.has('RTE_NET_BNXT')
     deps += 'net_bnxt'
diff --git a/app/test/meson.build b/app/test/meson.build
index 07bc00148d..45ece2179c 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -138,7 +138,6 @@ source_file_deps = {
     'test_net_ip6.c': ['net'],
     'test_pcapng.c': ['ethdev', 'net', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
-    'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
     'test_per_lcore.c': [],
     'test_pflock.c': [],
     'test_pie.c': ['sched'],
@@ -217,6 +216,11 @@ source_file_ext_deps = {
     'test_pcapng.c': ['pcap'],
 }
 
+if dpdk_conf.has('RTE_LIB_PDUMP')
+    source_file_deps += { 'test_pdump.c': ['pdump'] + sample_packet_forward_deps, }
+    cflags += '-Wno-deprecated-declarations'
+endif
+
 def_lib = get_option('default_library')
 foreach f, f_deps : source_file_deps
     has_deps = true
diff --git a/doc/guides/howto/packet_capture_framework.rst b/doc/guides/howto/packet_capture_framework.rst
index 4099c419aa..995d0fc1ce 100644
--- a/doc/guides/howto/packet_capture_framework.rst
+++ b/doc/guides/howto/packet_capture_framework.rst
@@ -10,11 +10,11 @@ for users of DPDK who want to know more about the Packet Capture feature and
 for those who want to monitor traffic on DPDK-controlled devices.
 
 The DPDK packet capture framework was introduced in DPDK v16.07
-and enhanced in 21.11.
+and enhanced in 21.11, and deprecated in 25.11. It is superseded
+by the new port mirroring facility of ethdev.
+
 The DPDK packet capture framework consists of the libraries
-for collecting packets ``librte_pdump``
-and writing packets to a file ``librte_pcapng``.
-There are two sample applications: ``dpdk-dumpcap`` and older ``dpdk-pdump``.
+for collecting packets ``librte_pdump`` and an application ``dpdk-pdump``.
 
 Introduction
 ------------
@@ -49,10 +49,13 @@ and then to the Pcapng file.
 
 Some things to note:
 
-* All tools using ``librte_pdump`` can only be used in conjunction with a primary
+* The ``dpdk-dumpcap`` tool used the ethdev port mirror functionality
+  to transparently mirror packets to an internal ring device.
+
+* Older tools using ``librte_pdump`` can only be used in conjunction with a primary
   application which has the packet capture framework initialized already. In
   dpdk, only ``testpmd`` is modified to initialize packet capture framework,
-  other applications remain untouched. So, if the ``dpdk-dumpcap`` tool has to
+  other applications remain untouched. So, if the ``dpdk-pdump`` tool has to
   be used with any application other than the testpmd, the user needs to
   explicitly modify that application to call the packet capture framework
   initialization code. Refer to the ``app/test-pmd/testpmd.c`` code and look
diff --git a/doc/guides/nics/bnxt.rst b/doc/guides/nics/bnxt.rst
index 370931fbb0..9534214286 100644
--- a/doc/guides/nics/bnxt.rst
+++ b/doc/guides/nics/bnxt.rst
@@ -723,7 +723,7 @@ Note that the applications cannot update the firmware using BNXT PMD.
 Multiple Processes
 ~~~~~~~~~~~~~~~~~~
 
-When two or more DPDK applications (e.g., testpmd and dpdk-pdump) share a single
+When two or more DPDK applications (e.g., testpmd and dpdk-dumpcap) share a single
 instance of DPDK, the BNXT PMD supports a single primary application and one or
 more secondary applications. Note that the DPDK-layer (not the PMD) ensures
 there is only one primary application.
diff --git a/doc/guides/prog_guide/ethdev/index.rst b/doc/guides/prog_guide/ethdev/index.rst
index 392ced0a2e..49c41b5c94 100644
--- a/doc/guides/prog_guide/ethdev/index.rst
+++ b/doc/guides/prog_guide/ethdev/index.rst
@@ -10,6 +10,7 @@ Ethernet Device Library
     ethdev
     switch_representation
     flow_offload
+    port_mirroring
     traffic_metering_and_policing
     traffic_management
     qos_framework
diff --git a/doc/guides/prog_guide/pdump_lib.rst b/doc/guides/prog_guide/pdump_lib.rst
index 07b9f39d09..eb1ae25fae 100644
--- a/doc/guides/prog_guide/pdump_lib.rst
+++ b/doc/guides/prog_guide/pdump_lib.rst
@@ -9,6 +9,10 @@ The library does the complete copy of the Rx and Tx mbufs to a new mempool and
 hence it slows down the performance of the applications, so it is recommended
 to use this library for debugging purposes.
 
+The pdump functionality will not work if secondary process sends and receives
+packets. This is not easily fixable therefore this library is now deprecated
+and replace by port mirroring functionality of ethdev.
+
 The library uses a generic multi process channel to facilitate communication
 between primary and secondary process for enabling/disabling packet capture on
 ports.
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index c91207cab2..6c775eb605 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -175,3 +175,6 @@ Deprecation Notices
   without relying on flow API.
   Currently there is no alternative API
   providing the same functionality as with ``repr_matching_en`` set to 0.
+
+* pdump: The pdump API and application have been deprecated and will
+  be removed in a later release.
diff --git a/doc/guides/tools/pdump.rst b/doc/guides/tools/pdump.rst
index 6f9bd77ab1..ffb8bde192 100644
--- a/doc/guides/tools/pdump.rst
+++ b/doc/guides/tools/pdump.rst
@@ -10,6 +10,8 @@ The ``dpdk-pdump`` tool is a Data Plane Development Kit (DPDK) tool that runs as
 a DPDK secondary process and is capable of enabling packet capture on dpdk ports.
 
    .. Note::
+      * The ``dpdk-pdump`` is deprecated, use ``dpdk-dumpcap`` instead.
+
       * The ``dpdk-pdump`` tool can only be used in conjunction with a primary
         application which has the packet capture framework initialized already.
         In dpdk, only the ``testpmd`` is modified to initialize packet capture
diff --git a/lib/pdump/rte_pdump.h b/lib/pdump/rte_pdump.h
index 1e32d46097..bfea7c560d 100644
--- a/lib/pdump/rte_pdump.h
+++ b/lib/pdump/rte_pdump.h
@@ -39,6 +39,7 @@ enum {
  * @return
  *    0 on success, -1 on error
  */
+__rte_deprecated
 int
 rte_pdump_init(void);
 
@@ -50,6 +51,7 @@ rte_pdump_init(void);
  * @return
  *    0 on success, -1 on error
  */
+__rte_deprecated
 int
 rte_pdump_uninit(void);
 
@@ -75,7 +77,7 @@ rte_pdump_uninit(void);
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
-
+__rte_deprecated
 int
 rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
 		struct rte_ring *ring,
@@ -106,6 +108,7 @@ rte_pdump_enable(uint16_t port, uint16_t queue, uint32_t flags,
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
+__rte_deprecated
 int
 rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue,
 		     uint32_t flags, uint32_t snaplen,
@@ -129,7 +132,7 @@ rte_pdump_enable_bpf(uint16_t port_id, uint16_t queue,
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
-
+__rte_deprecated
 int
 rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags);
 
@@ -156,7 +159,7 @@ rte_pdump_disable(uint16_t port, uint16_t queue, uint32_t flags);
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
-
+__rte_deprecated
 int
 rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
 				uint32_t flags,
@@ -189,6 +192,7 @@ rte_pdump_enable_by_deviceid(char *device_id, uint16_t queue,
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
+__rte_deprecated
 int
 rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
 				 uint32_t flags, uint32_t snaplen,
@@ -215,6 +219,7 @@ rte_pdump_enable_bpf_by_deviceid(const char *device_id, uint16_t queue,
  * @return
  *    0 on success, -1 on error, rte_errno is set accordingly.
  */
+__rte_deprecated
 int
 rte_pdump_disable_by_deviceid(char *device_id, uint16_t queue,
 				uint32_t flags);
@@ -243,6 +248,7 @@ struct rte_pdump_stats {
  * @return
  *   Zero if successful. -1 on error and rte_errno is set.
  */
+__rte_deprecated
 int
 rte_pdump_stats(uint16_t port_id, struct rte_pdump_stats *stats);
 
-- 
2.47.2

