Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C50CD6E64
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5C2340A8A;
	Tue,  2 Jun 2026 17:53:04 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 457DB4066B
 for <dev@dpdk.org>; Tue,  2 Jun 2026 17:52:50 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAB3HtdK_B5q0IJyAA--.6815S22;
 Tue, 02 Jun 2026 23:52:48 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v6 20/20] net/sxe2: update sxe2 feature matrix docs
Date: Tue,  2 Jun 2026 23:52:39 +0800
Message-ID: <20260602155240.1002602-21-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260602155240.1002602-1-liujie5@linkdatatechnology.com>
References: <20260602055414.630859-21-liujie5@linkdatatechnology.com>
 <20260602155240.1002602-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3HtdK_B5q0IJyAA--.6815S22
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr18JFyfGw1DXFW7Aw1UZFb_yoW8CFyUpw
 4DAayYqr1fJa17ZrnIy3WUJrWYyrWvya909rZ7GFy3KFyjgr40vw4aya40qF1Dt3s7Z34Y
 q3Wftr9I9r1UZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIx
 AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU
 =
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
 doc/guides/nics/features/sxe2.ini | 69 +++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/doc/guides/nics/features/sxe2.ini b/doc/guides/nics/features/sxe2.ini
index 09ba2f558c..c1b4fcb68b 100644
--- a/doc/guides/nics/features/sxe2.ini
+++ b/doc/guides/nics/features/sxe2.ini
@@ -7,17 +7,86 @@
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
+gre                  = Y
+geneve               = Y
+vxlan_gpe            = Y
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
+port_id              = Y
-- 
2.52.0

