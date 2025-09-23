Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF66CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 15:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5620040615;
	Tue, 23 Sep 2025 17:07:56 +0200 (CEST)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
 by mails.dpdk.org (Postfix) with ESMTP id D5764402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 17:07:54 +0200 (CEST)
Received: from ar (unknown [42.177.188.38])
 by APP-05 (Coremail) with SMTP id zQCowAAHqBHGt9JoEL6EBA--.60298S2;
 Tue, 23 Sep 2025 23:07:51 +0800 (CST)
From: sunyuechi@iscas.ac.cn
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] config/riscv: add rv64gcv cross compilation target
Date: Tue, 23 Sep 2025 23:07:34 +0800
Message-ID: <20250923150734.2208125-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHqBHGt9JoEL6EBA--.60298S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDKF47tF47CF4xJr4xZwb_yoW5Cr4kpF
 WrCr1UCry8XFn3GrsrKFy8GF4fJw4kuw15X34kAry5AFZ0yrWDZF90ga1xtwsrXa10ya1F
 kFZ5uFyYkr1UJ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjRVbDUUUUU==
X-Originating-IP: [42.177.188.38]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgsOAmjStocEwAAAsO
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

From: Sun Yuechi <sunyuechi@iscas.ac.cn>

Add a cross file for rv64gcv, enable it in devtools/test-meson-builds.sh,
and update the RISC-V cross-build guide to support the vector extension.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 config/riscv/meson.build                        |  3 ++-
 config/riscv/riscv64_rv64gcv_linux_gcc          | 17 +++++++++++++++++
 devtools/test-meson-builds.sh                   |  4 ++++
 .../linux_gsg/cross_build_dpdk_for_riscv.rst    |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 config/riscv/riscv64_rv64gcv_linux_gcc

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index f3daea0c0e..a06429a1e2 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -43,7 +43,8 @@ vendor_generic = {
         ['RTE_MAX_NUMA_NODES', 2]
     ],
     'arch_config': {
-        'generic': {'machine_args': ['-march=rv64gc']}
+        'generic': {'machine_args': ['-march=rv64gc']},
+        'rv64gcv': {'machine_args': ['-march=rv64gcv']},
     }
 }
 
diff --git a/config/riscv/riscv64_rv64gcv_linux_gcc b/config/riscv/riscv64_rv64gcv_linux_gcc
new file mode 100644
index 0000000000..ccc5115dec
--- /dev/null
+++ b/config/riscv/riscv64_rv64gcv_linux_gcc
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
+cpu = 'rv64gcv'
+endian = 'little'
+
+[properties]
+vendor_id = 'generic'
+arch_id = 'rv64gcv'
+pkg_config_libdir = '/usr/lib/riscv64-linux-gnu/pkgconfig'
diff --git a/devtools/test-meson-builds.sh b/devtools/test-meson-builds.sh
index 4fff1f7177..4f07f84eb0 100755
--- a/devtools/test-meson-builds.sh
+++ b/devtools/test-meson-builds.sh
@@ -290,6 +290,10 @@ build build-ppc64-power8-gcc $f ABI $use_shared
 f=$srcdir/config/riscv/riscv64_linux_gcc
 build build-riscv64-generic-gcc $f ABI $use_shared
 
+# RISC-V vector (rv64gcv)
+f=$srcdir/config/riscv/riscv64_rv64gcv_linux_gcc
+build build-riscv64_rv64gcv_gcc $f ABI $use_shared
+
 # Test installation of the x86-generic target, to be used for checking
 # the sample apps build using the pkg-config file for cflags and libs
 load_env cc
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
index 7d7f7ac72b..bcba12a604 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
@@ -108,6 +108,8 @@ Currently the following targets are supported:
 
 * Generic rv64gc ISA: ``config/riscv/riscv64_linux_gcc``
 
+* RV64GCV ISA: ``config/riscv/riscv64_rv64gcv_linux_gcc``
+
 * SiFive U740 SoC: ``config/riscv/riscv64_sifive_u740_linux_gcc``
 
 To add a new target support, ``config/riscv/meson.build`` has to be modified by
-- 
2.51.0

