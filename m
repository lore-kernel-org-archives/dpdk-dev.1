Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31AACCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 02:52:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA965400D6;
	Mon, 10 Nov 2025 03:52:44 +0100 (CET)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
 by mails.dpdk.org (Postfix) with ESMTP id AAB88400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 03:52:41 +0100 (CET)
Received: from ar (unknown [42.57.186.148])
 by APP-05 (Coremail) with SMTP id zQCowABXXG11UxFp16suAA--.8556S2;
 Mon, 10 Nov 2025 10:52:38 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] devtools: add RISC-V vector in meson build test
Date: Mon, 10 Nov 2025 10:52:20 +0800
Message-ID: <20251110025220.3319989-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXXG11UxFp16suAA--.8556S2
X-Coremail-Antispam: 1UD129KBjvdXoWrury5uFyrKFWkuFWUWr48Zwb_yoW3trX_K3
 97AF4xXw13J397tFn3Cr45CFykWw4rtr15trWxWwnxWa4DXw17Za4qkFWDKF1a9rs8CFZa
 ywsYvryxGw47JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbz8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAK
 I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
 xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xII
 jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
 0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
 67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-Originating-IP: [42.57.186.148]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAgCAmkRR1w1EAAAsC
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

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 devtools/test-meson-builds.sh | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.51.2

