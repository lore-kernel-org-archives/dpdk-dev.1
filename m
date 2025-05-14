Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE087C3ABCC
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 10:03:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8DE44064F;
	Wed, 14 May 2025 12:03:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3AD99402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 12:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747217006; x=1778753006;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LeUblZYZuYP/g9N1qculOpPjxXbBuEwB1Ocjq6FfAx8=;
 b=Brgd5KOzR5Zd1lYYn2R0jUDOttWp3B66YobTY6yh60owJhi3D/03KQ9u
 k2tq+av9Nh8gfpyzIVkuKNCYOLHsSPKuqxcXlnEnLqeLYavzgDCt08sTO
 aOqMqylxrUhcYXUWvNgdTSNet6bkPTkmhnsWMiSln4zqBt9ibkH/5ujfJ
 TPFuWRHFSiJjX8dEG5XKhTemqwTkBd+TnJbcHd/ReKi3bl5MRVsopdFJm
 c9pp6bHJydidopHWDSJd90dPxTIcBU8OyQ0NkU+FgbD3Ses+EuDLLCbcN
 K6cI0u8xE/TP/bOTXIHI/zD0GqTgc4YKKfAJw4GdGDtLuLhg64pv2OwRk A==;
X-CSE-ConnectionGUID: XZ1qOMATQsqwDzaCTK1fFg==
X-CSE-MsgGUID: UTTh1prmQ9yl0kge3QBDtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49084505"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="49084505"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 03:03:14 -0700
X-CSE-ConnectionGUID: jqi771CWR/ypqCUUIGu08g==
X-CSE-MsgGUID: M2ca4vg2TEyaKK/MEtn/3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169090464"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.30])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 03:03:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] examples: remove check for old broken pkg-config
Date: Wed, 14 May 2025 11:03:06 +0100
Message-ID: <20250514100306.11717-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The version of pkg-config shipped with RHEL 7 had issues reporting the
linker flags for DPDK, meaning we couldn't build the examples statically
using it. However, as RHEL 7 is no longer supported by future DPDK
releases, we can drop the check for this condition from all the
Makefiles. More recent pkg-config versions don't have this issue.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/bbdev_app/Makefile                               | 8 --------
 examples/bond/Makefile                                    | 8 --------
 examples/cmdline/Makefile                                 | 8 --------
 examples/distributor/Makefile                             | 8 --------
 examples/dma/Makefile                                     | 8 --------
 examples/ethtool/ethtool-app/Makefile                     | 8 --------
 examples/eventdev_pipeline/Makefile                       | 8 --------
 examples/fips_validation/Makefile                         | 8 --------
 examples/flow_filtering/Makefile                          | 8 --------
 examples/helloworld/Makefile                              | 8 --------
 examples/ip_fragmentation/Makefile                        | 8 --------
 examples/ip_pipeline/Makefile                             | 8 --------
 examples/ip_reassembly/Makefile                           | 8 --------
 examples/ipsec-secgw/Makefile                             | 8 --------
 examples/ipv4_multicast/Makefile                          | 8 --------
 examples/l2fwd-cat/Makefile                               | 8 --------
 examples/l2fwd-crypto/Makefile                            | 8 --------
 examples/l2fwd-event/Makefile                             | 8 --------
 examples/l2fwd-jobstats/Makefile                          | 8 --------
 examples/l2fwd-keepalive/Makefile                         | 8 --------
 examples/l2fwd-keepalive/ka-agent/Makefile                | 8 --------
 examples/l2fwd-macsec/Makefile                            | 8 --------
 examples/l2fwd/Makefile                                   | 8 --------
 examples/l3fwd-graph/Makefile                             | 8 --------
 examples/l3fwd-power/Makefile                             | 8 --------
 examples/l3fwd/Makefile                                   | 8 --------
 examples/link_status_interrupt/Makefile                   | 8 --------
 .../multi_process/client_server_mp/mp_client/Makefile     | 8 --------
 .../multi_process/client_server_mp/mp_server/Makefile     | 8 --------
 examples/multi_process/hotplug_mp/Makefile                | 8 --------
 examples/multi_process/simple_mp/Makefile                 | 8 --------
 examples/multi_process/symmetric_mp/Makefile              | 8 --------
 examples/ntb/Makefile                                     | 8 --------
 examples/packet_ordering/Makefile                         | 8 --------
 examples/pipeline/Makefile                                | 8 --------
 examples/ptpclient/Makefile                               | 8 --------
 examples/qos_meter/Makefile                               | 8 --------
 examples/qos_sched/Makefile                               | 8 --------
 examples/rxtx_callbacks/Makefile                          | 8 --------
 examples/server_node_efd/efd_node/Makefile                | 8 --------
 examples/server_node_efd/efd_server/Makefile              | 8 --------
 examples/service_cores/Makefile                           | 8 --------
 examples/skeleton/Makefile                                | 8 --------
 examples/timer/Makefile                                   | 8 --------
 examples/vdpa/Makefile                                    | 8 --------
 examples/vhost/Makefile                                   | 8 --------
 examples/vhost_blk/Makefile                               | 8 --------
 examples/vhost_crypto/Makefile                            | 8 --------
 examples/vm_power_manager/Makefile                        | 8 --------
 examples/vm_power_manager/guest_cli/Makefile              | 8 --------
 examples/vmdq/Makefile                                    | 8 --------
 examples/vmdq_dcb/Makefile                                | 8 --------
 52 files changed, 416 deletions(-)

diff --git a/examples/bbdev_app/Makefile b/examples/bbdev_app/Makefile
index 86ac8a4009..942e106ac2 100644
--- a/examples/bbdev_app/Makefile
+++ b/examples/bbdev_app/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/bond/Makefile b/examples/bond/Makefile
index d87c7a32ba..3330de1594 100644
--- a/examples/bond/Makefile
+++ b/examples/bond/Makefile
@@ -32,14 +32,6 @@ LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 build/commands.h: commands.list Makefile
 	dpdk-cmdline-gen.py -o $@ --context-name=main_ctx $<
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build $(SRC-DEPS)
diff --git a/examples/cmdline/Makefile b/examples/cmdline/Makefile
index 8a2d3b4b5a..fd7ae682a4 100644
--- a/examples/cmdline/Makefile
+++ b/examples/cmdline/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/distributor/Makefile b/examples/distributor/Makefile
index d4d43fbfca..ade6df08b3 100644
--- a/examples/distributor/Makefile
+++ b/examples/distributor/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/dma/Makefile b/examples/dma/Makefile
index 59af6478b7..8ff087dc0e 100644
--- a/examples/dma/Makefile
+++ b/examples/dma/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/ethtool/ethtool-app/Makefile b/examples/ethtool/ethtool-app/Makefile
index 5b4f02d4b9..cda3f14252 100644
--- a/examples/ethtool/ethtool-app/Makefile
+++ b/examples/ethtool/ethtool-app/Makefile
@@ -31,14 +31,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED += $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC += $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/eventdev_pipeline/Makefile b/examples/eventdev_pipeline/Makefile
index 962ff96368..faf667a54a 100644
--- a/examples/eventdev_pipeline/Makefile
+++ b/examples/eventdev_pipeline/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/fips_validation/Makefile b/examples/fips_validation/Makefile
index 8ab85688c9..4864966e77 100644
--- a/examples/fips_validation/Makefile
+++ b/examples/fips_validation/Makefile
@@ -45,14 +45,6 @@ LDFLAGS += $(shell $(PKGCONF) --libs jansson)
 CFLAGS += -DUSE_JANSSON
 endif
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/flow_filtering/Makefile b/examples/flow_filtering/Makefile
index 9998ed10b5..13bbafd9e8 100644
--- a/examples/flow_filtering/Makefile
+++ b/examples/flow_filtering/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) $(snippet_objects) Makefile $(PC_FILE) | build
diff --git a/examples/helloworld/Makefile b/examples/helloworld/Makefile
index 2a6a2f1527..b16773a02f 100644
--- a/examples/helloworld/Makefile
+++ b/examples/helloworld/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/ip_fragmentation/Makefile b/examples/ip_fragmentation/Makefile
index 48ac67be5e..47ec774ea9 100644
--- a/examples/ip_fragmentation/Makefile
+++ b/examples/ip_fragmentation/Makefile
@@ -27,14 +27,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/ip_pipeline/Makefile b/examples/ip_pipeline/Makefile
index bc5e0a9f18..438aa6b37f 100644
--- a/examples/ip_pipeline/Makefile
+++ b/examples/ip_pipeline/Makefile
@@ -38,14 +38,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -I. -DALLOW_EXPERIMENTAL_API -D_GNU_SOURCE
 
 OBJS := $(patsubst %.c,build/%.o,$(SRCS-y))
diff --git a/examples/ip_reassembly/Makefile b/examples/ip_reassembly/Makefile
index f940cbfd05..28158225a6 100644
--- a/examples/ip_reassembly/Makefile
+++ b/examples/ip_reassembly/Makefile
@@ -27,14 +27,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/ipsec-secgw/Makefile b/examples/ipsec-secgw/Makefile
index 12a2db8596..499e5c91bc 100644
--- a/examples/ipsec-secgw/Makefile
+++ b/examples/ipsec-secgw/Makefile
@@ -41,14 +41,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 CFLAGS += -Wno-address-of-packed-member
 CFLAGS += -I../common
diff --git a/examples/ipv4_multicast/Makefile b/examples/ipv4_multicast/Makefile
index 971fa4ef0c..2f054fe27d 100644
--- a/examples/ipv4_multicast/Makefile
+++ b/examples/ipv4_multicast/Makefile
@@ -27,14 +27,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l2fwd-cat/Makefile b/examples/l2fwd-cat/Makefile
index d06053451a..6e657f0934 100644
--- a/examples/l2fwd-cat/Makefile
+++ b/examples/l2fwd-cat/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 CFLAGS += -D_GNU_SOURCE
 
diff --git a/examples/l2fwd-crypto/Makefile b/examples/l2fwd-crypto/Makefile
index 1657f3c351..09aec4d52d 100644
--- a/examples/l2fwd-crypto/Makefile
+++ b/examples/l2fwd-crypto/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 CONFIG_DEFINES = $(shell $(CC) $(CFLAGS) -dM -E - < /dev/null)
 ifneq ($(findstring RTE_CRYPTO_SCHEDULER,$(CONFIG_DEFINES)),)
diff --git a/examples/l2fwd-event/Makefile b/examples/l2fwd-event/Makefile
index 4d041ba3db..e011e31d1e 100644
--- a/examples/l2fwd-event/Makefile
+++ b/examples/l2fwd-event/Makefile
@@ -32,14 +32,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l2fwd-jobstats/Makefile b/examples/l2fwd-jobstats/Makefile
index ec498169da..9a71c68fa8 100644
--- a/examples/l2fwd-jobstats/Makefile
+++ b/examples/l2fwd-jobstats/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l2fwd-keepalive/Makefile b/examples/l2fwd-keepalive/Makefile
index 5b6e3e3905..ace9b4687e 100644
--- a/examples/l2fwd-keepalive/Makefile
+++ b/examples/l2fwd-keepalive/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l2fwd-keepalive/ka-agent/Makefile b/examples/l2fwd-keepalive/ka-agent/Makefile
index 22aa6af511..00d364fcbf 100644
--- a/examples/l2fwd-keepalive/ka-agent/Makefile
+++ b/examples/l2fwd-keepalive/ka-agent/Makefile
@@ -30,14 +30,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l2fwd-macsec/Makefile b/examples/l2fwd-macsec/Makefile
index f26e8a9846..d8fc5e9918 100644
--- a/examples/l2fwd-macsec/Makefile
+++ b/examples/l2fwd-macsec/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 CONFIG_DEFINES = $(shell $(CC) $(CFLAGS) -dM -E - < /dev/null)
 
diff --git a/examples/l2fwd/Makefile b/examples/l2fwd/Makefile
index 79c9dc0f25..85669a298a 100644
--- a/examples/l2fwd/Makefile
+++ b/examples/l2fwd/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -DALLOW_EXPERIMENTAL_API
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
 	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
 
diff --git a/examples/l3fwd-graph/Makefile b/examples/l3fwd-graph/Makefile
index f64ccc6d59..c6da021ffa 100644
--- a/examples/l3fwd-graph/Makefile
+++ b/examples/l3fwd-graph/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l3fwd-power/Makefile b/examples/l3fwd-power/Makefile
index 0a6aa5a3a4..d1eb10e6e1 100644
--- a/examples/l3fwd-power/Makefile
+++ b/examples/l3fwd-power/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/l3fwd/Makefile b/examples/l3fwd/Makefile
index e802f037be..a06480a19e 100644
--- a/examples/l3fwd/Makefile
+++ b/examples/l3fwd/Makefile
@@ -29,14 +29,6 @@ CFLAGS += -DALLOW_EXPERIMENTAL_API
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -I../common
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/link_status_interrupt/Makefile b/examples/link_status_interrupt/Makefile
index c892d828d5..c5c342d8e5 100644
--- a/examples/link_status_interrupt/Makefile
+++ b/examples/link_status_interrupt/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/multi_process/client_server_mp/mp_client/Makefile b/examples/multi_process/client_server_mp/mp_client/Makefile
index 26e774fd5c..e694b5659e 100644
--- a/examples/multi_process/client_server_mp/mp_client/Makefile
+++ b/examples/multi_process/client_server_mp/mp_client/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/multi_process/client_server_mp/mp_server/Makefile b/examples/multi_process/client_server_mp/mp_server/Makefile
index c564286d4b..39c481171a 100644
--- a/examples/multi_process/client_server_mp/mp_server/Makefile
+++ b/examples/multi_process/client_server_mp/mp_server/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/multi_process/hotplug_mp/Makefile b/examples/multi_process/hotplug_mp/Makefile
index 18d949f315..5b48a9ba8b 100644
--- a/examples/multi_process/hotplug_mp/Makefile
+++ b/examples/multi_process/hotplug_mp/Makefile
@@ -30,14 +30,6 @@ LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 build/commands.h: commands.list Makefile
 	dpdk-cmdline-gen.py -o $@ --context-name=main_ctx $<
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build $(SRC-DEPS)
diff --git a/examples/multi_process/simple_mp/Makefile b/examples/multi_process/simple_mp/Makefile
index 9de7c25f78..2dbf40dcca 100644
--- a/examples/multi_process/simple_mp/Makefile
+++ b/examples/multi_process/simple_mp/Makefile
@@ -30,14 +30,6 @@ LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 build/commands.h: commands.list Makefile
 	dpdk-cmdline-gen.py -o $@ --context-name=simple_mp_ctx $<
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build $(SRC-DEPS)
diff --git a/examples/multi_process/symmetric_mp/Makefile b/examples/multi_process/symmetric_mp/Makefile
index e76acb89b2..8dc6f56857 100644
--- a/examples/multi_process/symmetric_mp/Makefile
+++ b/examples/multi_process/symmetric_mp/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/ntb/Makefile b/examples/ntb/Makefile
index f5b3405c47..8f6c325f3a 100644
--- a/examples/ntb/Makefile
+++ b/examples/ntb/Makefile
@@ -33,14 +33,6 @@ LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 build/commands.h: commands.list Makefile
 	dpdk-cmdline-gen.py -o $@ --context-name=main_ctx $<
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build $(SRC-DEPS)
diff --git a/examples/packet_ordering/Makefile b/examples/packet_ordering/Makefile
index 47b64888ef..de1a8b9b47 100644
--- a/examples/packet_ordering/Makefile
+++ b/examples/packet_ordering/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/pipeline/Makefile b/examples/pipeline/Makefile
index c19df3a489..86bcc00bd2 100644
--- a/examples/pipeline/Makefile
+++ b/examples/pipeline/Makefile
@@ -30,14 +30,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -I. -DALLOW_EXPERIMENTAL_API -D_GNU_SOURCE
 
 OBJS := $(patsubst %.c,build/%.o,$(SRCS-y))
diff --git a/examples/ptpclient/Makefile b/examples/ptpclient/Makefile
index 909bb65257..37c32ff873 100644
--- a/examples/ptpclient/Makefile
+++ b/examples/ptpclient/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/qos_meter/Makefile b/examples/qos_meter/Makefile
index de5b435166..5558ba939a 100644
--- a/examples/qos_meter/Makefile
+++ b/examples/qos_meter/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/qos_sched/Makefile b/examples/qos_sched/Makefile
index 346d66d41e..0a748f5277 100644
--- a/examples/qos_sched/Makefile
+++ b/examples/qos_sched/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/rxtx_callbacks/Makefile b/examples/rxtx_callbacks/Makefile
index f980b033cb..d11e0b4153 100644
--- a/examples/rxtx_callbacks/Makefile
+++ b/examples/rxtx_callbacks/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/server_node_efd/efd_node/Makefile b/examples/server_node_efd/efd_node/Makefile
index 115e2da7a0..2c93872e5b 100644
--- a/examples/server_node_efd/efd_node/Makefile
+++ b/examples/server_node_efd/efd_node/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/server_node_efd/efd_server/Makefile b/examples/server_node_efd/efd_server/Makefile
index 8eb75fe352..f51ef134dc 100644
--- a/examples/server_node_efd/efd_server/Makefile
+++ b/examples/server_node_efd/efd_server/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/service_cores/Makefile b/examples/service_cores/Makefile
index 8cc00cf02c..2054677f96 100644
--- a/examples/service_cores/Makefile
+++ b/examples/service_cores/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/skeleton/Makefile b/examples/skeleton/Makefile
index 026ee48a88..4be77631ee 100644
--- a/examples/skeleton/Makefile
+++ b/examples/skeleton/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/timer/Makefile b/examples/timer/Makefile
index a74f3c3254..1c8b8f294e 100644
--- a/examples/timer/Makefile
+++ b/examples/timer/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/vdpa/Makefile b/examples/vdpa/Makefile
index aa60a000cf..304a90969f 100644
--- a/examples/vdpa/Makefile
+++ b/examples/vdpa/Makefile
@@ -31,14 +31,6 @@ LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 build/commands.h: commands.list Makefile
 	dpdk-cmdline-gen.py -o $@ --context-name=main_ctx $<
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build $(SRC-DEPS)
 	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
 
diff --git a/examples/vhost/Makefile b/examples/vhost/Makefile
index ea64f02bb0..5b3cea0778 100644
--- a/examples/vhost/Makefile
+++ b/examples/vhost/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/vhost_blk/Makefile b/examples/vhost_blk/Makefile
index 79fcee6131..c6a1f76633 100644
--- a/examples/vhost_blk/Makefile
+++ b/examples/vhost_blk/Makefile
@@ -28,14 +28,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/vhost_crypto/Makefile b/examples/vhost_crypto/Makefile
index 84de8431a6..cc7f2abb90 100644
--- a/examples/vhost_crypto/Makefile
+++ b/examples/vhost_crypto/Makefile
@@ -27,14 +27,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
 	$(CC) $(CFLAGS) $(SRCS-y) -o $@ $(LDFLAGS) $(LDFLAGS_SHARED)
 
diff --git a/examples/vm_power_manager/Makefile b/examples/vm_power_manager/Makefile
index d2f83f0da1..c462f49fcf 100644
--- a/examples/vm_power_manager/Makefile
+++ b/examples/vm_power_manager/Makefile
@@ -32,14 +32,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 ifneq ($(shell $(PKGCONF) --atleast-version=0.9.3 libvirt; echo $$?), 0)
diff --git a/examples/vm_power_manager/guest_cli/Makefile b/examples/vm_power_manager/guest_cli/Makefile
index 17b52f23b8..751ca6e185 100644
--- a/examples/vm_power_manager/guest_cli/Makefile
+++ b/examples/vm_power_manager/guest_cli/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/vmdq/Makefile b/examples/vmdq/Makefile
index 34c7778ec0..cc976384fa 100644
--- a/examples/vmdq/Makefile
+++ b/examples/vmdq/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
diff --git a/examples/vmdq_dcb/Makefile b/examples/vmdq_dcb/Makefile
index d784586f6a..a34e7e36d4 100644
--- a/examples/vmdq_dcb/Makefile
+++ b/examples/vmdq_dcb/Makefile
@@ -26,14 +26,6 @@ CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk)
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
-ifeq ($(MAKECMDGOALS),static)
-# check for broken pkg-config
-ifeq ($(shell echo $(LDFLAGS_STATIC) | grep 'whole-archive.*l:lib.*no-whole-archive'),)
-$(warning "pkg-config output list does not contain drivers between 'whole-archive'/'no-whole-archive' flags.")
-$(error "Cannot generate statically-linked binaries with this version of pkg-config")
-endif
-endif
-
 CFLAGS += -DALLOW_EXPERIMENTAL_API
 
 build/$(APP)-shared: $(SRCS-y) Makefile $(PC_FILE) | build
-- 
2.48.1

