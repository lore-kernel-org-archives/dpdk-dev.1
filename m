Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE43CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C603C4042C;
	Wed, 14 Oct 2026 17:09:44 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 1FD7F40144;
 Wed, 14 Oct 2026 17:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=p8z8eoIn9ljkcRoFq9hJlN47t+mxZamkx+UTzgmL2zU=;
 b=HD66M1BmzZpWZdalIR49EfgL3P21ghsmiuiGx7zifDNNrcnvq6FYMjgKWhZ76U
 6RZFFB1NAIOEHonJZCjl3+PYhMXCj5nVFbVkSNKP0FMUnIqfpdiJO+gsmFUPrhts
 ZtmzMIdowlyIjYB+L9bZBprg3/tBG3P2Nv6hKNet+CYro=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v2 03/26] net/hinic3: fix VXLAN VNI spec and mask write
Date: Wed, 14 Oct 2026 23:08:59 +0800
Message-ID: <20261014150923.838-4-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWxAFy3XrW5CFyxGw47XFb_yoW8XF1xpF
 4UG3yDXr4vqFW5Cwnrtw1fAFyYg3s7Jay3CFyDCa4ayryUZryxC3yfG3y2krnxKr1kJFyS
 yF4UCr4qy3Z0qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7CztUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBWCjGrPmzUckgAA3q
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

The VXLAN parser writes the flow item spec into key_mask and never
populates the mask, so VNI matches against a wrong value. Store the spec
into key_spec and the mask into key_mask.

Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
Cc: stable@dpdk.org

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/hinic3_flow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_flow.c
index 453b4369b3..1f686d4675 100644
--- a/drivers/net/hinic3/hinic3_flow.c
+++ b/drivers/net/hinic3/hinic3_flow.c
@@ -967,6 +967,7 @@ hinic3_flow_fdir_vxlan(struct rte_flow_error *error,
 {
 	const struct rte_flow_item_vxlan *spec_vxlan, *mask_vxlan;
 	uint32_t vxlan_vni_id = 0;
+	uint32_t vxlan_vni_id_mask = 0;
 
 	spec_vxlan = (const struct rte_flow_item_vxlan *)flow_item->spec;
 	mask_vxlan = (const struct rte_flow_item_vxlan *)flow_item->mask;
@@ -990,8 +991,11 @@ hinic3_flow_fdir_vxlan(struct rte_flow_error *error,
 	}
 
 	memcpy(((uint8_t *)&vxlan_vni_id + 1), spec_vxlan->vni, 3);
-	filter->fdir_filter.key_mask.tunnel.tunnel_id =
+	filter->fdir_filter.key_spec.tunnel.tunnel_id =
 		rte_be_to_cpu_32(vxlan_vni_id);
+	memcpy(((uint8_t *)&vxlan_vni_id_mask + 1), mask_vxlan->vni, 3);
+	filter->fdir_filter.key_mask.tunnel.tunnel_id =
+		rte_be_to_cpu_32(vxlan_vni_id_mask);
 	return 0;
 }
 
-- 
2.33.0

