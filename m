Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A9BCA5FE2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:30:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06B77402B5;
	Mon,  5 Oct 2026 08:30:24 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id EA3C540290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 08:30:21 +0200 (CEST)
Received: from ar (unknown [42.58.232.122])
 by APP-03 (Coremail) with SMTP id rQCowADn5zX6Q8NqjACoCQ--.27389S2;
 Mon, 05 Oct 2026 14:30:19 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 0/2] lpm: use scalar lookupx4 on RISC-V
Date: Sun,  4 Oct 2026 23:30:16 -0700
Message-ID: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn5zX6Q8NqjACoCQ--.27389S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWUKFy3tF15GF13Cry7GFg_yoWfAFcE9a
 4rZa4DXw47GFyUAayxJr45JrZ5AF4UCF15A3WDJF47JFW3trn8Cr18ArsrXFy5WFy5Gr97
 Aa17trWSyr17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
 W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-Originating-IP: [42.58.232.122]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAALAmrDJI0-XgAAsk
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

The RVV rte_lpm_lookupx4() beats the scalar version only on in-order
cores, and only because it reads the four tbl24 entries up front.
Patch 1 makes the scalar version do the same, patch 2 removes the RVV
version.

lpm_perf_autotest, LookupX4, units differ per machine:

             SpacemiT X60       Sophgo SG2044       SpacemiT X100
             (in-order)         (out-of-order)      (out-of-order)
             rv64gc  rv64gcv    rv64gc  rva23u64    rv64gc  rva23u64
  main       5.5     4.4 (RVV)  2.7     3.2 (RVV)   35.2    54.3 (RVV)
  patched    2.5     2.7-3.2    2.7     2.9         34.6    41.3

Sun Yuechi (2):
  lpm: load tbl24 entries up front in scalar lookupx4
  lpm: use scalar lookupx4 on RISC-V

 lib/lpm/meson.build      |  1 -
 lib/lpm/rte_lpm.h        |  2 --
 lib/lpm/rte_lpm_rvv.h    | 59 ----------------------------------------
 lib/lpm/rte_lpm_scalar.h | 40 +++++++++++++++++++--------
 4 files changed, 29 insertions(+), 73 deletions(-)
 delete mode 100644 lib/lpm/rte_lpm_rvv.h

-- 
2.56.0

