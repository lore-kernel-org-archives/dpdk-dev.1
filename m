Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0B9CD6E61
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F24D840A71;
	Mon,  1 Jun 2026 10:50:14 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 2C54840650
 for <dev@dpdk.org>; Mon,  1 Jun 2026 10:50:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXcNezRx1qUzY4Ew--.22307S22;
 Mon, 01 Jun 2026 16:50:00 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 20/20] net/sxe2: update sxe2 feature matrix docs
Date: Mon,  1 Jun 2026 16:49:50 +0800
Message-ID: <20260601084950.269887-21-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260601084950.269887-1-liujie5@linkdatatechnology.com>
References: <20260601063007.230097-21-liujie5@linkdatatechnology.com>
 <20260601084950.269887-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXcNezRx1qUzY4Ew--.22307S22
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18JFyfGw1DXFW7Aw1UZFb_yoW8CrWfpw
 4DAFWYqr1fJay7Zrsaya1UGr45ZrWvya909rZ7GFy3KF1jgr40v3yava40qF1Dt3s3Z34Y
 qa4ftr9I9r1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8
 Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
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

Update the sxe2.ini feature sheet to accurately reflect the recently
implemented hardware capabilities in the sxe2 PMD.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 doc/guides/nics/features/sxe2.ini | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/doc/guides/nics/features/sxe2.ini b/doc/guides/nics/features/sxe2.ini
index 09ba2f558c..f697d940b4 100644
--- a/doc/guides/nics/features/sxe2.ini
+++ b/doc/guides/nics/features/sxe2.ini
@@ -7,17 +7,83 @@
 ; is selected.
 ;
 [Features]
+Speed capabilities   = Y
+Link status          = Y
+Link status event    = Y
+Rx interrupt         = Y
 Fast mbuf free       = P
 Free Tx mbuf on demand = Y
 Burst mode info      = Y
 Queue start/stop     = Y
+Power mgmt address monitor = Y
 Buffer split on Rx   = P
 Scattered Rx         = Y
+Traffic manager      = Y
 CRC offload          = Y
+VLAN offload         = Y
+QinQ offload         = P
 L3 checksum offload  = Y
 L4 checksum offload  = Y
+Timestamp offload    = P
+Inner L3 checksum    = P
+Inner L4 checksum    = P
 Rx descriptor status = Y
 Tx descriptor status = Y
+MTU update           = Y
+Scattered Rx         = Y
+TSO                  = P
+Promiscuous mode     = Y
+Allmulticast mode    = Y
+Unicast MAC filter   = Y
+RSS hash             = Y
+RSS key update       = Y
+RSS reta update      = Y
+VLAN filter          = Y
+Inline crypto        = Y
+Packet type parsing  = Y
+Timesync             = Y
+Basic stats          = Y
+Extended stats       = Y
+FW version           = Y
+Module EEPROM dump   = Y
+Multiprocess aware   = Y
 Linux                = Y
 x86-32               = Y
 x86-64               = Y
+
+[rte_flow items]
+ah                   = Y
+any                  = Y
+arp_eth_ipv4         = Y
+esp                  = Y
+eth                  = P
+gtpu                 = Y
+gtp_psc              = Y
+icmp                 = Y
+icmp6                = Y
+ipv4                 = Y
+ipv6                 = Y
+ipv6_frag_ext        = Y
+l2tpv3oip            = Y
+nvgre                = Y
+pfcp                 = Y
+pppoed               = Y
+pppoes               = Y
+pppoe_proto_id       = Y
+raw                  = Y
+sctp                 = Y
+tcp                  = Y
+udp                  = Y
+vlan                 = P
+vxlan                = Y
+
+[rte_flow actions]
+count                = Y
+drop                 = Y
+mark                 = Y
+passthru             = Y
+port_representor     = Y
+queue                = Y
+represented_port     = Y
+rss                  = Y
+send_to_kernel       = Y
-- 
2.52.0

