Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CACC61DF0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:31:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58E8440651;
	Sun, 22 Feb 2026 16:30:50 +0100 (CET)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170]) by mails.dpdk.org (Postfix) with ESMTP id EB5D9402EE
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:40 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Td5h3PZUg50sXDxN88qT63/+xCEU82ppynz4tO3vk3I=;
 b=BtvFArEJkRRZ3/jTdIIBpD5oRfjh2RUZSCoNgsaQFHmIeoP3g7wt5qFKPgoKdwKf0Wxg8M
 MYQoIyZM7mMR6cyDNva6z4LsTc/7BcV5AabQk3Xj2Ua2wT+4OQnP4Fwy+gOKook9dkN6kn
 KW46jwPn2yAPOUwvSrsbZog2yB4NFTo=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>
Subject: [PATCH v4 04/10] config/riscv: add qemu crossbuild target
Date: Sun, 22 Feb 2026 16:29:58 +0100
Message-ID: <836a033963c60bc426899954ddd667548958fe78.1771772598.git.code@danielg0.com>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Daniel Gregory <daniel.gregory@bytedance.com>

A new cross-compilation target that has extensions that DPDK uses and
QEMU supports. This includes the vector extension V for ... and the Zbc
extension for hardware CRC support.

Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
---
 config/riscv/meson.build                        |  1 +
 config/riscv/riscv64_qemu_linux_gcc             | 17 +++++++++++++++++
 .../linux_gsg/cross_build_dpdk_for_riscv.rst    |  5 +++++
 3 files changed, 23 insertions(+)
 create mode 100644 config/riscv/riscv64_qemu_linux_gcc

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index 65ab4b7347..3580d71bf3 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -45,6 +45,7 @@ vendor_generic = {
     'arch_config': {
         'generic': {'machine_args': ['-march=rv64gc']},
         'rv64gcv': {'machine_args': ['-march=rv64gcv']},
+        'qemu': {'machine_args': ['-march=rv64gcv_zbc']},
     }
 }
 
diff --git a/config/riscv/riscv64_qemu_linux_gcc b/config/riscv/riscv64_qemu_linux_gcc
new file mode 100644
index 0000000000..f1298af8f0
--- /dev/null
+++ b/config/riscv/riscv64_qemu_linux_gcc
@@ -0,0 +1,17 @@
+[binaries]
+c = ['ccache', 'riscv64-linux-gnu-gcc']
+cpp = ['ccache', 'riscv64-linux-gnu-g++']
+ar = 'riscv64-linux-gnu-ar'
+strip = 'riscv64-linux-gnu-strip'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'riscv64'
+cpu = 'rv64gcv_zbc'
+endian = 'little'
+
+[properties]
+vendor_id = 'generic'
+arch_id = 'qemu'
+pkg_config_libdir = '/usr/lib/riscv64-linux-gnu/pkgconfig'
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
index bcba12a604..1767e7398c 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
@@ -112,6 +112,11 @@ Currently the following targets are supported:
 
 * SiFive U740 SoC: ``config/riscv/riscv64_sifive_u740_linux_gcc``
 
+* QEMU: ``config/riscv/riscv64_qemu_linux_gcc``
+
+  * A target with all the extensions that QEMU supports that DPDK has a use for
+    (currently ``rv64gcv_zbc``). Requires QEMU version 7.0.0 or newer.
+
 To add a new target support, ``config/riscv/meson.build`` has to be modified by
 adding a new vendor/architecture id and a corresponding cross-file has to be
 added to ``config/riscv`` directory.
-- 
2.53.0

