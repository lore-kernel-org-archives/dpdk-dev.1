Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E971CC02192
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 01:35:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EF0E40E2E;
	Thu,  6 Feb 2025 02:34:11 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 38C4C40678
 for <dev@dpdk.org>; Thu,  6 Feb 2025 02:33:39 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id B1BB9203F5BD; Wed,  5 Feb 2025 17:33:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1BB9203F5BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738805617;
 bh=aPloZmRzPS81A3gM1BB1XitT4l4LD+nrXd/fISGnZUY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AS16Z5r895oOzhTxlAih4+7XFhFgrLI/6rs/YuBw2KdHRSk/J2sAy/aXEKIgM7Zp6
 WBK3skgCIgDQiYGfNEno8+3WhSVZgh84mwNE5RYvo9L0PAuV+v7b2VaTxjNXxNt5Co
 NmSR6TLqvC2tv0zmoMtoYWSda+gUvZWh+TWibSA0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v22 25/27] examples: add no_wvla_cflag to directories that are
 not VLA-free
Date: Wed,  5 Feb 2025 17:33:28 -0800
Message-Id: <1738805610-17507-26-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738805610-17507-1-git-send-email-andremue@linux.microsoft.com>
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

The no_wvla_cflag is added to meson.build files in directories that
are not yet VLA-free.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 examples/fips_validation/meson.build  | 2 ++
 examples/ip_fragmentation/meson.build | 1 +
 examples/ipsec-secgw/meson.build      | 3 +++
 examples/l2fwd-crypto/meson.build     | 1 +
 examples/l2fwd-jobstats/meson.build   | 1 +
 examples/l3fwd-power/meson.build      | 1 +
 examples/l3fwd/meson.build            | 1 +
 examples/pipeline/meson.build         | 1 +
 examples/qos_sched/meson.build        | 1 +
 examples/vhost/meson.build            | 1 +
 10 files changed, 13 insertions(+)

diff --git a/examples/fips_validation/meson.build b/examples/fips_validation/meson.build
index 7d4e440c6c..6c29b535cb 100644
--- a/examples/fips_validation/meson.build
+++ b/examples/fips_validation/meson.build
@@ -25,6 +25,8 @@ sources = files(
         'main.c',
 )
 
+cflags += no_wvla_cflag
+
 if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
     cflags += '-DUSE_JANSSON'
diff --git a/examples/ip_fragmentation/meson.build b/examples/ip_fragmentation/meson.build
index cd84e9b143..750c3e4149 100644
--- a/examples/ip_fragmentation/meson.build
+++ b/examples/ip_fragmentation/meson.build
@@ -11,3 +11,4 @@ deps +=  ['ip_frag', 'lpm']
 sources = files(
         'main.c',
 )
+cflags += no_wvla_cflag
diff --git a/examples/ipsec-secgw/meson.build b/examples/ipsec-secgw/meson.build
index 023d9cf039..e6a0e18a73 100644
--- a/examples/ipsec-secgw/meson.build
+++ b/examples/ipsec-secgw/meson.build
@@ -23,6 +23,9 @@ sources = files(
         'sp4.c',
         'sp6.c',
 )
+
+cflags += no_wvla_cflag
+
 app_cflags = ['-Wno-address-of-packed-member']
 foreach flag:app_cflags
     if cc.has_argument(flag)
diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
index bb44c88882..c21722b85c 100644
--- a/examples/l2fwd-crypto/meson.build
+++ b/examples/l2fwd-crypto/meson.build
@@ -14,3 +14,4 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
+cflags += no_wvla_cflag
diff --git a/examples/l2fwd-jobstats/meson.build b/examples/l2fwd-jobstats/meson.build
index bffcf35e8c..d59d3d6555 100644
--- a/examples/l2fwd-jobstats/meson.build
+++ b/examples/l2fwd-jobstats/meson.build
@@ -11,3 +11,4 @@ deps += ['jobstats', 'timer']
 sources = files(
         'main.c',
 )
+cflags += no_wvla_cflag
diff --git a/examples/l3fwd-power/meson.build b/examples/l3fwd-power/meson.build
index 624ef5e947..5ff4466cac 100644
--- a/examples/l3fwd-power/meson.build
+++ b/examples/l3fwd-power/meson.build
@@ -12,3 +12,4 @@ sources = files(
         'main.c',
         'perf_core.c',
 )
+cflags += no_wvla_cflag
diff --git a/examples/l3fwd/meson.build b/examples/l3fwd/meson.build
index c25de77bba..74144c7979 100644
--- a/examples/l3fwd/meson.build
+++ b/examples/l3fwd/meson.build
@@ -21,3 +21,4 @@ sources = files(
 if dpdk_conf.has('RTE_LIB_EVENTDEV')
     deps += 'eventdev'
 endif
+cflags += no_wvla_cflag
diff --git a/examples/pipeline/meson.build b/examples/pipeline/meson.build
index 50103f2e01..01f14dc2ae 100644
--- a/examples/pipeline/meson.build
+++ b/examples/pipeline/meson.build
@@ -20,3 +20,4 @@ sources = files(
         'obj.c',
         'thread.c',
 )
+cflags += no_wvla_cflag
diff --git a/examples/qos_sched/meson.build b/examples/qos_sched/meson.build
index dc103e9556..92657ce8a5 100644
--- a/examples/qos_sched/meson.build
+++ b/examples/qos_sched/meson.build
@@ -17,3 +17,4 @@ sources = files(
         'main.c',
         'stats.c',
 )
+cflags += no_wvla_cflag
diff --git a/examples/vhost/meson.build b/examples/vhost/meson.build
index 87a637f83f..e938be8f45 100644
--- a/examples/vhost/meson.build
+++ b/examples/vhost/meson.build
@@ -18,3 +18,4 @@ sources = files(
         'main.c',
         'virtio_net.c',
 )
+cflags += no_wvla_cflag
-- 
2.47.2.vfs.0.1

