Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4373AC61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3702F406FF;
	Mon, 31 Aug 2026 04:44:42 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id D042040A80
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:44:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckCW6pRqBNqjBg--.24723S2;
 Mon, 31 Aug 2026 10:44:38 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 37/47] net/sxe2: use primary VSI ID for representor VSI
Date: Mon, 31 Aug 2026 10:44:38 +0800
Message-ID: <20260831024438.3231358-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckCW6pRqBNqjBg--.24723S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18Xr4xXF4kXw4xXw1DWrg_yoW8Jw1rpr
 WkWF43ZF4kGFnxX3WDW3WkuF15Kw1Fq340gF4Fv3WfuF1DCryUCr9xGa48tryDJ39rZw1a
 va17Zw1UW3WrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

For repr_vf_vsi_id, use the primary VSI id directly instead of
falling back to the DPDK VSI id when the kernel VSI id is invalid.
The kernel side guarantees the primary VSI id it provides is always
valid in any scenario, so the fallback ternary is unnecessary.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_switchdev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_switchdev.c b/drivers/net/sxe2/sxe2_switchdev.c
index d0304ccc94..466182c55c 100644
--- a/drivers/net/sxe2/sxe2_switchdev.c
+++ b/drivers/net/sxe2/sxe2_switchdev.c
@@ -324,10 +324,7 @@ int32_t sxe2_switchdev_repr_private_data_init(struct rte_eth_dev *dev,
 		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
 
 	repr_priv_data->repr_vf_vsi_id =
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id !=
-		SXE2_INVALID_VSI_ID ?
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].kernel_vsi_id :
-		parent_adapter->repr_ctxt.repr_vf_id[repr_id].dpdk_vsi_id;
+		repr_priv_data->repr_vf_primary_vsi_id;
 
 	adapter->repr_priv_data = repr_priv_data;
 	goto l_end;
-- 
2.52.0

