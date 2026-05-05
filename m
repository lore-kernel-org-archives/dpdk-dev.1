Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63799FF885A
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 06:22:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 909D84064C;
	Tue,  5 May 2026 08:22:45 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id C12C540270
 for <dev@dpdk.org>; Tue,  5 May 2026 08:22:43 +0200 (CEST)
Received: from ar (unknown [119.114.153.107])
 by APP-05 (Coremail) with SMTP id zQCowADHWAyyjPlpNuRwDw--.15157S2;
 Tue, 05 May 2026 14:22:42 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v5 0/2] RISC-V vector extension support
Date: Tue,  5 May 2026 14:21:39 +0800
Message-ID: <20260505062142.575105-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
References: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHWAyyjPlpNuRwDw--.15157S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry5Cr15WF1kuw1DXry8AFb_yoWxuwcEgr
 WI9rWkZ34UJaykAFZ0kan7ArWfCFZ3Gw1qy3WFgFyfuFs5JrWUGF4DtFnIvryS9rWfKw1a
 kr1UtryftFn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
 W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-Originating-IP: [119.114.153.107]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwoSAmn5R7qD8AAAsD
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

v5:
  Rename rte_lpm_lookup_vec to ip4_lookup_rvv_lpm_lookup to avoid the
  rte_lpm_ namespace reserved for the LPM library API.

v4:
  Removed duplicate macro definitions of RTE_LPM_LOOKUP_SUCCESS and
  RTE_LPM_VALID_EXT_ENTRY_BITMASK.
  Split SIMD bitwidth change into separate patch.

Sun Yuechi (2):
  eal/riscv: set default SIMD bitwidth to 128
  node: lookup with RISC-V vector extension

 doc/guides/rel_notes/release_26_03.rst |   4 +
 lib/eal/riscv/include/rte_vect.h       |   2 +-
 lib/node/ip4_lookup.c                  |   5 +-
 lib/node/ip4_lookup_rvv.h              | 164 +++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 2 deletions(-)
 create mode 100644 lib/node/ip4_lookup_rvv.h

-- 
2.54.0

