Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB74C0218D
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 21:57:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F399B4114B;
	Thu, 30 Jan 2025 22:56:08 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 93DF540E37
 for <dev@dpdk.org>; Thu, 30 Jan 2025 22:55:45 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D2E57210C324; Thu, 30 Jan 2025 13:55:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D2E57210C324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738274144;
 bh=IkKYN95gbUOswvp9t91hL9oNVoOQeZT74Fwq/UiuG2A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dtHF4IqeNAR/wdBVEugx14+zsR18jHKS9Kl7LjTmYtMgcQEOUCxY/dmAo0gfyWfyr
 vvDTtKLzEJLIDvZzfPgW+r8SmV/43I/uGh/D7SLqjCIimSkcJ3mU/gINKRuyEj65O2
 4lSte7Ot90phVtepf+fL7Q5JkFyQ7qf4B6zV4i9Q=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v18 25/26] examples: add no_vla_cflag to directories that are
 not VLA-free
Date: Thu, 30 Jan 2025 13:55:34 -0800
Message-Id: <1738274135-2086-26-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
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

The no_vla_cflag is added to meson.build files in directories that
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
index 7d4e440c6c..de14b305cf 100644
--- a/examples/fips_validation/meson.build
+++ b/examples/fips_validation/meson.build
@@ -25,6 +25,8 @@ sources = files(
         'main.c',
 )
 
+cflags += no_vla_cflag
+
 if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
     cflags += '-DUSE_JANSSON'
diff --git a/examples/ip_fragmentation/meson.build b/examples/ip_fragmentation/meson.build
index cd84e9b143..873680079d 100644
--- a/examples/ip_fragmentation/meson.build
+++ b/examples/ip_fragmentation/meson.build
@@ -11,3 +11,4 @@ deps +=  ['ip_frag', 'lpm']
 sources = files(
         'main.c',
 )
+cflags += no_vla_cflag
diff --git a/examples/ipsec-secgw/meson.build b/examples/ipsec-secgw/meson.build
index 023d9cf039..bad48a35b4 100644
--- a/examples/ipsec-secgw/meson.build
+++ b/examples/ipsec-secgw/meson.build
@@ -23,6 +23,9 @@ sources = files(
         'sp4.c',
         'sp6.c',
 )
+
+cflags += no_vla_cflag
+
 app_cflags = ['-Wno-address-of-packed-member']
 foreach flag:app_cflags
     if cc.has_argument(flag)
diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
index bb44c88882..b5c9a6987f 100644
--- a/examples/l2fwd-crypto/meson.build
+++ b/examples/l2fwd-crypto/meson.build
@@ -14,3 +14,4 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
+cflags += no_vla_cflag
diff --git a/examples/l2fwd-jobstats/meson.build b/examples/l2fwd-jobstats/meson.build
index bffcf35e8c..673d3254ea 100644
--- a/examples/l2fwd-jobstats/meson.build
+++ b/examples/l2fwd-jobstats/meson.build
@@ -11,3 +11,4 @@ deps += ['jobstats', 'timer']
 sources = files(
         'main.c',
 )
+cflags += no_vla_cflag
diff --git a/examples/l3fwd-power/meson.build b/examples/l3fwd-power/meson.build
index 624ef5e947..a54cd1df83 100644
--- a/examples/l3fwd-power/meson.build
+++ b/examples/l3fwd-power/meson.build
@@ -12,3 +12,4 @@ sources = files(
         'main.c',
         'perf_core.c',
 )
+cflags += no_vla_cflag
diff --git a/examples/l3fwd/meson.build b/examples/l3fwd/meson.build
index c25de77bba..d981f5566c 100644
--- a/examples/l3fwd/meson.build
+++ b/examples/l3fwd/meson.build
@@ -21,3 +21,4 @@ sources = files(
 if dpdk_conf.has('RTE_LIB_EVENTDEV')
     deps += 'eventdev'
 endif
+cflags += no_vla_cflag
diff --git a/examples/pipeline/meson.build b/examples/pipeline/meson.build
index 50103f2e01..b261022431 100644
--- a/examples/pipeline/meson.build
+++ b/examples/pipeline/meson.build
@@ -20,3 +20,4 @@ sources = files(
         'obj.c',
         'thread.c',
 )
+cflags += no_vla_cflag
diff --git a/examples/qos_sched/meson.build b/examples/qos_sched/meson.build
index dc103e9556..71ebbd8166 100644
--- a/examples/qos_sched/meson.build
+++ b/examples/qos_sched/meson.build
@@ -17,3 +17,4 @@ sources = files(
         'main.c',
         'stats.c',
 )
+cflags += no_vla_cflag
diff --git a/examples/vhost/meson.build b/examples/vhost/meson.build
index 87a637f83f..7dd22f4d0c 100644
--- a/examples/vhost/meson.build
+++ b/examples/vhost/meson.build
@@ -18,3 +18,4 @@ sources = files(
         'main.c',
         'virtio_net.c',
 )
+cflags += no_vla_cflag
-- 
2.47.2.vfs.0.1

