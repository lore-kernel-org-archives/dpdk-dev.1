Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C0606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=UU+xffyi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13E8440B91;
	Fri, 30 Oct 2026 15:47:56 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTPS id 9F5B240285;
 Fri, 30 Oct 2026 15:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=p8z8eoIn9ljkcRoFq9hJlN47t+mxZamkx+UTzgmL2zU=;
 b=UU+xffyifioX8oNifcQ1G6RJigqrWY1K6Cl6g5Yd/5cNt+VZ81luW8z8YOgSbG
 pgfqOalUd2NlEdyyEw8nd4vasRSeX4//bdAjN1M2TjbDz1wbCBxLrXwW538vAndH
 s+K3/0cZHw4M68F15U//f6nCjWqoZILlQp384zRB9RIrI=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Subject: [PATCH v5 04/28] net/hinic3: fix VXLAN VNI spec and mask write
Date: Fri, 30 Oct 2026 22:47:08 +0800
Message-ID: <20261030144733.2120-5-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWxAFy3XrW5CFyxGw47XFb_yoW8XF1xpF
 4UG3yDXr4vqFW5Cwnrtw1fAFyYg3s7Jay3CFyDCa4ayryUZryxC3yfG3y2krnxKr1kJFyS
 yF4UCr4qy3Z0qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7SdgUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBeEjmrkrhdZNQAA3y
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

