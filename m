Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450D7C36010
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Apr 2025 00:35:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BAF14060C;
	Sat,  5 Apr 2025 02:35:47 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8F0E44029E
 for <dev@dpdk.org>; Sat,  5 Apr 2025 02:35:45 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id EB6322027DF8; Fri,  4 Apr 2025 17:35:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB6322027DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1743813344;
 bh=D1fEFpf8PEyGMh2OMGcrsHwbi2g83KuBMrjRbwB1Wfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uo3panWFjDpZE9Ss9qB+SyqoKyeuc25plgB/h6zshRHWhXPOt3pSJgtSpAGbEjiH9
 e+tawa8jPl0pc0b6IOg/Hf0rnUiByI1KGrpwON6ARRvKXBPtaaQou6162rih0Mw7d2
 YxbPYkhBlgqnYR/EEZMq1UV3m45IiUbY27lV2Kug=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3 2/6] net/netvsc: introduce get_vmbus_device to get the
 vmbus device
Date: Fri,  4 Apr 2025 17:35:34 -0700
Message-Id: <1743813338-28238-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
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

