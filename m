Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214151061B2B
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F09C402D4;
	Tue, 31 Mar 2026 05:11:44 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id C90484025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:11:41 +0200 (CEST)
Received: from ar (unknown [42.177.178.249])
 by APP-03 (Coremail) with SMTP id rQCowACHqN9sO8tpaKliDA--.54784S2;
 Tue, 31 Mar 2026 11:11:40 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v4 0/2] RISC-V vector extension support
Date: Tue, 31 Mar 2026 11:10:57 +0800
Message-ID: <20260331031059.2621971-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHqN9sO8tpaKliDA--.54784S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5M7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
 6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
 kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
 cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87
 Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
 zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
 8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
 xwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
 1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij
 64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
 0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbWCJPUUUUU==
X-Originating-IP: [42.177.178.249]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAgDAmnLGIuK-QAAsD
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

v4:
- Removed duplicate macro definitions of RTE_LPM_LOOKUP_SUCCESS and
  RTE_LPM_VALID_EXT_ENTRY_BITMASK
- Split SIMD bitwidth change into separate patch

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
2.53.0

