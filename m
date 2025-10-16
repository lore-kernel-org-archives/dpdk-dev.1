Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4F6CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 09:46:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10F8441109;
	Thu, 16 Oct 2025 11:46:42 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mails.dpdk.org (Postfix) with ESMTP id 8AE1140E42;
 Thu, 16 Oct 2025 11:46:40 +0200 (CEST)
Received: from loongson.cn (unknown [10.40.64.71])
 by gateway (Coremail) with SMTP id _____8DxLvD+vvBoM9MWAA--.48877S3;
 Thu, 16 Oct 2025 17:46:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.64.71])
 by front1 (Coremail) with SMTP id qMiowJBxysDyvvBofM7pAA--.34116S2;
 Thu, 16 Oct 2025 17:46:38 +0800 (CST)
From: Min Zhou <zhoumin@loongson.cn>
To: thomas@monjalon.net, probb@iol.unh.edu, maobibo@loongson.cn,
 zhoumin@loongson.cn
Cc: dev@dpdk.org,
	ci@dpdk.org
Subject: [PATCH v1] maintainers: update for LoongArch
Date: Thu, 16 Oct 2025 17:09:48 +0800
Message-Id: <20251016090948.836029-1-zhoumin@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxysDyvvBofM7pAA--.34116S2
X-CM-SenderInfo: 52kr3ztlq6z05rqj20fqof0/1tbiAQERAWjwiSsEkwACs-
X-Coremail-Antispam: 1Uk129KBj9xXoWrWF1Duw17Jry7tr1DKF4DAwc_yoWxXFX_WF
 W7Jws3Xr18JFy5J3sYqFZ5t3Waqw4xAF45C3ZrJ3ykJayUt398Kr1vywn2k3WayrWxCrsx
 Xay3Kry3ur12qosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1MKZJUUUUU==
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

Update maintainers for LoongArch architecture.

Signed-off-by: Min Zhou <zhoumin@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..7abe482e7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -320,7 +320,7 @@ F: examples/*/*_neon.*
 F: examples/common/neon/
 
 LoongArch
-M: Min Zhou <zhoumin@loongson.cn>
+M: Bibo Mao <maobibo@loongson.cn>
 F: config/loongarch/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_loongarch.rst
 F: lib/eal/loongarch/
-- 
2.27.0

