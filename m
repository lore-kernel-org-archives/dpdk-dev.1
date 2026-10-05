Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF4CA5FE2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 07:04:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B0C9402B5;
	Mon,  5 Oct 2026 09:04:49 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id DD6974028D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 09:04:47 +0200 (CEST)
Received: from ar (unknown [42.58.232.122])
 by APP-03 (Coremail) with SMTP id rQCowAB3fTsOTMNq8bGoCQ--.771S2;
 Mon, 05 Oct 2026 15:04:46 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 0/2] fib: fix and speed up RVV lookup
Date: Mon,  5 Oct 2026 00:04:44 -0700
Message-ID: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAB3fTsOTMNq8bGoCQ--.771S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1kCw47CFykCFyfZFy5Jwb_yoWfXrbE9F
 WIkFyDGw4DXF9rKFy2yr1FvryxCrWUur1xZF4qyrW0qrWxZrsxAws5Ar4DXr1UuFW5Jryr
 Aws5XrW8Z34jqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbwAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
 W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
 rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-Originating-IP: [42.58.232.122]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBgELAmrDIz1MaQABsd
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

Patch 1 fixes wrong next hops from a FIB created with
RTE_FIB_F_LOOKUP_NETWORK_ORDER on RISC-V: the vector lookup read the
addresses in host order.

Patch 2 removes a register spill from the vector lookup loop by
gathering the entries at the width they are stored with.

Patch 2, ns per lookup, standalone benchmark, tables in cache, -O3:

                    1B     2B     4B     8B
  SpacemiT X60
    before         31.1   32.1   30.6   29.7
    after          27.2   27.9   27.6   26.4
  Sophgo SG2044
    before          5.6    5.7    5.9    7.5
    after           4.4    4.1    5.0    6.0
  SpacemiT X100
    before          4.7    4.8    4.8    5.9
    after           4.1    4.2    4.3    5.1

fib_perf_autotest, whose addresses miss the cache, gains 0 to 14%.

Sun Yuechi (2):
  fib: fix lookup in network order with RVV
  fib: gather entries at their own width with RVV

 lib/fib/dir24_8.c     |  4 +-
 lib/fib/dir24_8_rvv.c | 85 ++++++++++++++++++++++++-------------------
 2 files changed, 49 insertions(+), 40 deletions(-)

-- 
2.56.0

