Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA68606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73CF14064C;
	Wed, 18 Nov 2026 10:20:07 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTPS id 082F440298;
 Wed, 18 Nov 2026 08:38:48 +0100 (CET)
X-QQ-mid: esmtpgz11t1794987519t8f71d237
X-QQ-Originating-IP: WfRXEGnJD2Jja+nUeu+S+L5gDNdxDxL5/58NHwSDqI4=
Received: from localhost.localdomain ( [111.198.29.174])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Nov 2026 15:38:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18306010817556226926
EX-QQ-RecipientCnt: 7
From: Wenfeng Liu <liuwf@ysxt.com.cn>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: Wenfeng Liu <liuwf@ysxt.com.cn>, dev@dpdk.org, stable@dpdk.org,
 skoteshwar@marvell.com, thomas@monjalon.net
Subject: [PATCH] net/virtio: fix MAC table update with empty slots
Date: Wed, 18 Nov 2026 02:37:24 -0500
Message-ID: <1781A9C027C64C23+20261118073746.3490800-1-liuwf@ysxt.com.cn>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:ysxt.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MQ7i6Ib+DYfjqCWEQ1X9r69Y3ihZm9i4Qs5Bzxfs81Cdzq3PGcwNskw5
 Xy2vnX8d58T5tECvwAu414oH+h0ed/HNjtTN+l5meyJVu3B2DMdDhkGpWdUUP4C4gn6AqZ7
 JAYtH79Zr6AY0VgdIVps+SihO0KVFSU0VpTwGDo3QxdaHIkZincNqiaarw+OSsHpulhhufP
 vu5ehxQrUq5QperGppbArqL73CL1CdZhPmh31KmxgC2E556NE+rmIS9BO07kkFUnYReUlvL
 cFERLn5XBmRZh7ajFi+siXpgvzsTwOPVvGgVKE0eCRY9OM9WCdH93lJ82ybXgcUvxzcnmma
 W2OwfgpW/wdJFjKGyJcRae3vjZeSt9SZH6/DW6sXM9RlboTSboeUbp2ZPysdZz5o5daCvaN
 9z0eyPLgWB2wxKQ3T4UyEzXBsrDP7u96TE7dmz9LMj4mVDAGpBp5F+eaKDuCZKJrMdBKoVU
 G/sfcZpH4IvY+Zot00dx1oM2W2N95+jOiHTfC1LjyyWwLg8PwGNT+3Vq2+9/cPwq+X3u25M
 DOPaAUGIOJu5Ds6FODxc7LbyCNIoivHxBZCjCdALkPjN3SSA60rvrWcsizZwqdQzM8fV9xt
 3n6iuSz21vZj2H+lXjpe1JR3sV+ZssVGs0ljSkG+Z28IndsY5eSsXOwSNrjLFoiLHryXEn7
 GrE//2tdosR3pOGdIfp6gWH3fqu5mf2C8QwhCVpNCVZv4SEvLqJgLKE3x7F/m1DmwSeeP/x
 LgjUIN+RjCR0+qwB1oMaT62ZvZV3TZbcaUME2aG1KHTQACEjmwH8dzV3zFprTe6owwwMeMe
 2gSu1gzhLUFBTP714YusU2FR3Hg7yj5lBDzPiZ1tDVlOc3JdjUInssMDA+NAfjsCnJxjnPW
 tp2dST1nZMGCkU5l9A83vK8lmQAURBPvcCrrMGpjaezJP2QW3xHD44UnSrLjTh3f/vWu2vM
 9Dr17wE9ChScjkriS+yHCAeC/NdLIEmU/VT+6luqpXuLp08wnIMx2dWAllxPrdAkBjaxxBf
 vpue8GyYGwCIJnljJkLJzHLPcW85PmoHRhaIHnxg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Removing a MAC address clears its slot without compacting the address
array. When adding another address, stopping at the first empty slot
omits any valid addresses after it from the control MAC table.

For example, add addresses A, B and C, remove A and B, then add D. D fills
the first empty slot, but C is still beyond the remaining empty slot and
is omitted from the table sent to the device. With MAC filtering enabled,
traffic to C can then be dropped even though C remains in the ethdev
address array.

Scan the complete array and only copy nonzero MAC addresses into the
control table, preserving entries after empty slots without sending
zero addresses.

Fixes: 7698e655516c ("net/virtio: fix MAC table update")
Cc: stable@dpdk.org

Signed-off-by: Wenfeng Liu <liuwf@ysxt.com.cn>
---
Validation:
- Replayed the upstream ethdev MAC add/remove and virtio table-building
  functions with AddressSanitizer and a mock control-command receiver.
  Three sparse-table cases fail before the fix and all four cases pass
  after it (dense, sparse unicast, sparse multicast, and last-slot).
- Built the virtio PMD static/shared libraries on x86_64 with GCC 14 in
  both debug and release configurations.
- The driver fix applies to 22.11.11 and passes the same replay there.
- No real virtio guest packet-forwarding test has been performed.

 .mailmap                           |  2 +-
 drivers/net/virtio/virtio_ethdev.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index a7f57978..b645a2b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1863,7 +1863,7 @@ Weiyuan Li <weiyuanx.li@intel.com>
 Wen Chiu <wchiu@brocade.com>
 Wen-Chi Yang <wolkayang@gmail.com>
 Wenbo Cao <caowenbo@mucse.com>
-Wenfeng Liu <liuwf@arraynetworks.com.cn>
+Wenfeng Liu <liuwf@ysxt.com.cn> <liuwf@arraynetworks.com.cn>
 Wenjie Li <wenjiex.a.li@intel.com>
 Wenjie Sun <findtheonlyway@gmail.com>
 Wenjing Qiao <wenjing.qiao@intel.com>
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index f2302089..1e04427b 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -934,12 +934,14 @@ virtio_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 	for (i = 0; i < VIRTIO_MAX_MAC_ADDRS; i++) {
 		const struct rte_ether_addr *addr
 			= (i == index) ? mac_addr : addrs + i;
-		struct virtio_net_ctrl_mac *tbl
-			= rte_is_multicast_ether_addr(addr) ? mc : uc;
 
-		if (rte_is_zero_ether_addr(addr))
-			break;
-		memcpy(&tbl->macs[tbl->entries++], addr, RTE_ETHER_ADDR_LEN);
+		if (!rte_is_zero_ether_addr(addr)) {
+			struct virtio_net_ctrl_mac *tbl =
+				rte_is_multicast_ether_addr(addr) ? mc : uc;
+
+			memcpy(&tbl->macs[tbl->entries++], addr,
+				RTE_ETHER_ADDR_LEN);
+		}
 	}
 
 	return virtio_mac_table_set(hw, uc, mc);

base-commit: c6d273ce156cc48ef90e64e93a2bba80c9d36345
-- 
2.52.0

