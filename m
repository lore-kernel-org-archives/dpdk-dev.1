Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD392C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:37:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5671640E39;
	Wed,  9 Jul 2025 19:36:32 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id E9AEF40E1D
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:26 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-235ef62066eso2604405ad.3
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082586;
 x=1752687386; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lAqmLj4pdQBJjtlxgWlHUnsk3u1djZ1R01G18ns7eg=;
 b=Y0/I5CO/OX25FHnGzh0cITa63xewxoAYUDaivb4o/F8EKO2CiOKyxfKpUMtxmzHqOz
 ZRg2IZ40+qr8Jd//vzLtJeImik68J7WxLxf4YqlqE3mTAZ+a2SIGXM60ko1LijBvY/aD
 4BjK86TNsxVrXIt1anxv2HY8n97cAQk3u7fP4MBuY88LmNyxpoZzVQXHM5XpmwDlpfrZ
 r22DaqiJzaxwkHnTxsdi5nztAqqQJF3+oBF7G2+OGYNkVAcLN/BP6eRCFAWSFiD/X72o
 vVzWwolVzhnysgba+UqA1TnFexSoee//xaQm5pcTR8SB5rDUYTxtqjiy4rqC3kqvTduU
 HU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082586; x=1752687386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lAqmLj4pdQBJjtlxgWlHUnsk3u1djZ1R01G18ns7eg=;
 b=ub7sfdn/BMgS1kkden+u36LAlmT7lWIHmAF7/60sTVKb3cp8twFBd+t/AXlklvLAxQ
 Z70tEHKlsMQnD4xj3q3YEdBb5FUi7zyqGmXUblrGC8gwJUtHGYWvn5YaPBZsh0fxA8gW
 t1mRek9WBB+YS8snjWW1Grs9XvacmUBy3ftjSYYaZdkJ1rkkYp7tgNZBcwA/bnTlsUw9
 55vcdl9dLwgwbKAtEwGDU+HOBv4Bg+6zPPIfzg2RJidahnaFpQJNrW46V6X/wYraV0Xj
 Y+oN0wn8aYKSAWCllcVJVbgHLTzqLSdO/ByAR3UzpXpUMnVuvbM8ZrLg7bCK0LZ3MJxr
 V6KA==
X-Gm-Message-State: AOJu0Yw++N5fiI6dLb8FkMiFn+lYY6pjycmxdxx7TveUPcHQPTIZQg6S
 VZbfOvdHFcKeAGM3A8UOYCBzQ8ffmGNN6ZVAjqnDdaULigUyUVOcAeMnf1uH9vh1cmXQS7YzRJH
 HCppp
X-Gm-Gg: ASbGncuKyp+KwpANm/CsPYJGPUEYGiziGLDPWWy4pHMyfkPkhhsNvxtjNzbILNmhbPC
 z+iqQjlWwsj6joL7x6+fpahMHxKFKJbOHA8HeMI7/qoODRP/j1rxJ8aPXZIAu+4wVhRuKTP/MEX
 fhyhrd0s/utZvIATQzZ/74blrc4uYsi9W1xDWnBL+AjZFjwmpV0fiisutA0LZcLUClC8dG4JzoP
 oEUWeCbUS3eFPPZqRNNz91/XufhhliO45xLNAUj/5b/W7jo4Cs8OmW4Q760lpQByQkv4kzkbx/+
 Hm0yZ2uROPXKrTmqLecJg05CFzjmspAEGKOiSiuAUV7T09Ih2Pvqbc7Q/nOkBJ/J5t55saFVAuR
 gyGeD3a8iPmjHnmHfoFml/55xGoNgR3cqlGy9
X-Google-Smtp-Source: AGHT+IE/4oveTi6RStEa+4rwvIGnQEEqkW99PBqDhhoN0OH1El95P9YCSNFBMeC6cAymG23F50U0qw==
X-Received: by 2002:a17:903:1b30:b0:237:f76f:ce34 with SMTP id
 d9443c01a7336-23ddb1a4dbdmr51758405ad.15.1752082586040; 
 Wed, 09 Jul 2025 10:36:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC v2 12/12] pdump: mark API and application as deprecated
Date: Wed,  9 Jul 2025 10:33:38 -0700
Message-ID: <20250709173611.6390-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

