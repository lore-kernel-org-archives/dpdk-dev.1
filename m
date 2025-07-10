Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028DCC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6178340E72;
	Thu, 10 Jul 2025 18:43:01 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0516440E40
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:43:00 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a6f0bcdf45so14486041cf.0
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165779;
 x=1752770579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lAqmLj4pdQBJjtlxgWlHUnsk3u1djZ1R01G18ns7eg=;
 b=YiYinYD9LD5/9nSH+SzcvvfUcQjr/mOoOyAzzH399yICcuKpghc5VjpxAIIA1ESKpf
 As2QjhrOjEjnll5/7Jbdz//Kj8CaRJgOXMFXRLjDzZnuvz0b7dzEM7NPCRXCyrnEBvbc
 LDvRiuMOy996l8/qsUXNsCR4uWadOR8n9px4kIZlMoJsmNjbxldW8O+98iLwBTpoERLk
 p+DkA/YbAPk2I3us2ln4oKpUcaXShRxUmnBaS1bQWZPIZ5JOKP9wRNo9xIluIdGTH4Ul
 0woi5pOgWSZcXXyGl40zb3cUbAF+gRnwYc4whydtxy/EeKv5AFgTnzdCsIZWsMi6Zmh1
 aOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165779; x=1752770579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lAqmLj4pdQBJjtlxgWlHUnsk3u1djZ1R01G18ns7eg=;
 b=bX3H5naTtWsctg9T1vZp1K0rDMBtH4wbTAeKA5m9fULO8IVYbwxodhRRsqR9Nep8Z4
 VjRkbbsn5L0SMqey+h2xec/feF2KPQmRf3v1rYYw/EGJUqCWshI03ncjcYBJPQsWg8yJ
 ihOBqOIM4sqzjohZHKnvPjFkPp/5jVBuKse3HBqsJMmfQs7wLcBibfPeEyKzdD2Osr9p
 CqnHyjgQHOsIFoWLLX1wD3hgDNCs73/tLXfDqWLnKOS2GCDDFARWMy6Ilmv20DHKZIyb
 q5HfJVUenbZRPAO+++o3O4+zwoD9XdTPlChr6rw1UmNmWkqH1SEKGFdeBHyUO2AsErL6
 CViA==
X-Gm-Message-State: AOJu0YzQDFzUuUv1vtBTxArWNq40qJ/RBBjOhmE4Fnr5I5A/hTJi37kf
 PiKxp0GELQ6JElZAFUvyZX5a2XCVGUguZuvkMV8Quctn440mndc/c5BB9/fGtHaZldZTJC9FIEK
 UkHXW
X-Gm-Gg: ASbGncsvwxu36zXQWZeO6MBgp9i+b5R89CEy/fPXNNiqr9PX7Np6BnKxmXcL3i7ypQe
 9qftWzI9qYZwXwOO+IoiekTHZlxPqCPgeMzACDN574UsZfQK3D102COlv15sh2azeAvRD78iBEp
 N+qnI0n68kml/O/PtbjF6wQavGRAMA52jwQuNOvdcY4jNBuZYulTEL4vwET/Ny6cJ7ewIQ5IZ7N
 /vVoZHpRyN7QSbAEHQC3YR/PdouFDavKVgukMnJO2YZB2Ty9+hEPpuZ9ptGa9N6EiX6qIXOQWny
 oNGzQop3mQLstE3J7le8Z1ePreMpR5Zfe3VnvS/CR27mMKwFYK4P1/Q0g4c+RpCyySOycXdOXwL
 15JL9cK/nLbjM175lYeKZa/TmQOvcFVrUGOZW
X-Google-Smtp-Source: AGHT+IG6QyL93BbO+/nivaQ0SAFps1t1/OQ/ROcedjsx+3/Q2L3vby7+s65DrfbN3SeSFFLJYGzung==
X-Received: by 2002:a05:6214:224a:b0:702:b4d3:26b4 with SMTP id
 6a1803df08f44-704a38b77b4mr378436d6.25.1752165779149; 
 Thu, 10 Jul 2025 09:42:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 13/13] pdump: mark API and application as deprecated
Date: Thu, 10 Jul 2025 09:16:54 -0700
Message-ID: <20250710164237.8630-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

pdump build deprecated
---
 app/pdump/main.c                     |  3 +++
 app/pdump/meson.build                |  1 +
 app/test-pmd/meson.build             |  1 +
 app/test/meson.build                 |  6 +++++-
 doc/guides/rel_notes/deprecation.rst |  3 +++
 lib/pdump/rte_pdump.h                | 12 +++++++++---
 6 files changed, 22 insertions(+), 4 deletions(-)

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
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index e2d4125308..03a6b2712e 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -152,3 +152,6 @@ Deprecation Notices
 * bus/vmbus: Starting DPDK 25.11, all the vmbus API defined in
   ``drivers/bus/vmbus/rte_bus_vmbus.h`` will become internal to DPDK.
   Those API functions are used internally by DPDK core and netvsc PMD.
+
+* pdump: The pdump API and application have been deprecated and will
+  be removed in a later release.
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

