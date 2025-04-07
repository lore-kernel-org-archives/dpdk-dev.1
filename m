Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F7C369A1
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 22:45:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F5B840E1F;
	Tue,  8 Apr 2025 00:45:13 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4401B40E1E
 for <dev@dpdk.org>; Tue,  8 Apr 2025 00:45:11 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 8315E2113E75; Mon,  7 Apr 2025 15:45:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8315E2113E75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1744065910;
 bh=D1fEFpf8PEyGMh2OMGcrsHwbi2g83KuBMrjRbwB1Wfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R3HTwOD1xC7e1UzvS6Z0w/5kFZjkTaPjEaadWVLc+YIR+Ui6KEiU7/BCFlTdxy9HX
 sCEmfhZuE+ro9j2u/V4LevM4XbWKOoxh76+7/TfJhZdidUjv+GCMzAsD+ehmjr15ai
 wvMhxSphrL2J91fVb2kPjrgpmWS2tENhSA+17toA=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v4 2/6] net/netvsc: introduce get_vmbus_device to get the
 vmbus device
Date: Mon,  7 Apr 2025 15:45:00 -0700
Message-Id: <1744065904-18455-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744065904-18455-1-git-send-email-longli@linuxonhyperv.com>
References: <1744065904-18455-1-git-send-email-longli@linuxonhyperv.com>
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

From: Long Li <longli@microsoft.com>

Introduce a function get the vmbus device from hn_data. For secondary
process, the vmbus device is in eth_dev's private region.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_nvs.c | 15 +++++++++++++++
 drivers/net/netvsc/hn_nvs.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/netvsc/hn_nvs.c b/drivers/net/netvsc/hn_nvs.c
index 7db82af9f3..fd20e3d06d 100644
--- a/drivers/net/netvsc/hn_nvs.c
+++ b/drivers/net/netvsc/hn_nvs.c
@@ -44,6 +44,21 @@ static const uint32_t hn_nvs_version[] = {
 	NVS_VERSION_1
 };
 
+struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv)
+{
+	struct rte_vmbus_device *vmbus = hv->vmbus;
+
+	/* For secondary process, vmbus is in the eth_dev private */
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		struct rte_eth_dev *dev = &rte_eth_devices[hv->port_id];
+		struct hn_nvs_process_priv *process_priv = dev->process_private;
+
+		vmbus = process_priv->vmbus_dev;
+	}
+
+	return vmbus;
+}
+
 static int hn_nvs_req_send(struct hn_data *hv,
 			   void *req, uint32_t reqlen)
 {
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index 3950749359..0d8fe27b65 100644
--- a/drivers/net/netvsc/hn_nvs.h
+++ b/drivers/net/netvsc/hn_nvs.h
@@ -221,6 +221,8 @@ void	hn_nvs_handle_vfassoc(struct rte_eth_dev *dev,
 			      const struct vmbus_chanpkt_hdr *hdr,
 			      const void *data);
 
+struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv);
+
 static inline int
 hn_nvs_send(struct vmbus_channel *chan, uint16_t flags,
 	    void *nvs_msg, int nvs_msglen, uintptr_t sndc,
-- 
2.34.1

