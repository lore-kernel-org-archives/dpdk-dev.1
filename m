Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB5C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14B9B406B8;
	Wed,  5 Feb 2025 18:20:18 +0100 (CET)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46]) by mails.dpdk.org (Postfix) with ESMTP id 092164066C
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:16 +0100 (CET)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-5fc0c06e1deso3406682eaf.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776015; x=1739380815; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O85u+27WVnGagTl4sTWvq49mCi5oT6PwWx/mi9+I9+g=;
 b=TDTlphgponTIiKzcFpMA3RV8XsH9679+4HDai/NEhOH/02LLkneFxnwLhgXIB/cux5
 K22zSbJgioGRankeyrOWnMUmt8UYTLf3av6h7OZhp4R5GRTVmg5Eg/IVZI0387c0gkEX
 s07ely5kim/88OfyC6LkuyXa5KHQzEF4Md4xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776015; x=1739380815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O85u+27WVnGagTl4sTWvq49mCi5oT6PwWx/mi9+I9+g=;
 b=OAK+0QrUPHF79oCP0E7iKUJvmO6HtNKb9vyCGgchSgjyHIncVWJhi0263Cf8y99g/j
 5jfXp+l8eGmolr1jfT7IdHzqIpdLUa6OpIIu90vvSd9Ku1kJ0p+1D8PGXd0GAYIK+gSK
 En/pdeZyYCOGlpf73a2mG0gmPUa58aPqoIAqwBh/v4+8DFrOh3HVlQLONc2R/UTtfVFv
 nJSZLNP9XfjbHom9p5UVR+00miO81wtb6lqzD4OdW30x3a14Gm9JkQCsAQb3NFyWkeqD
 wl96tIQM0bDrdzvFFK8OjHo6n1nWRJWXe88DUADt40NaONgdCWHqPPUXIDK+Pl03gJX7
 nAgQ==
X-Gm-Message-State: AOJu0Yyc/p05uuJ46Zbp5KYDhB8idKw6RnBvEsM4YLU0bpa+uYrGMVwp
 1fvsGnE8jgzCZ/3UAcEn7JfBRY6OICBLroqVs6eEVdZoQkxqaEr9UubJTXNYaGip1NkzXt16jUU
 AmTFoKb+Oi2cSpYgKMbVwHqZSDG745o0pRi9k2E5qy91kryhaV0Bcbl7esakjeRjZJLp0mBptr2
 rJSq9ohHvuZtOnrwACRMcIIPlXiJST
X-Gm-Gg: ASbGncsancGs2l94tamUeiA3e+5XloLsRjN6KKMz+gbEwCM0RmTtxkWKchGwHP3udeB
 wEbCNHkh1LOV5P6fXWRa/LupVs2HSamQCgBXCo2/TeZS4+yBTbu8XVJXWsuFTJ7t5ggjQFREg/b
 WCRjsByxHbx5MjNbku4ywApI9DpsI7IIn6qaMw2mJlNy7UgucNkF551sajudOEVMA2aTp86Jn4h
 eLdlaNSD/QS0nAGKLuJvucHXhvKhQ0YNnED8XLhLo6O4zr18lzy/BCY9NxDdHeryWxmXX34mMqJ
 zy39e2W+5Vxx9mktheMiT6dKXts3GFWt5IIwblrQ7iA84LmDukrH0g6mFwml0k07b1IjsPeGSnl
 3mPJeY5j/
X-Google-Smtp-Source: AGHT+IE/LDrTMRXefw2ov4zhT2g/2ARVxAO31ZYHSgYEdsOzqI8rH7iuTFsT0DWYZ2ae79ZH2ejsOQ==
X-Received: by 2002:a05:6820:2787:b0:5fa:6805:645b with SMTP id
 006d021491bc7-5fc479cbc96mr2751736eaf.6.1738776015086; 
 Wed, 05 Feb 2025 09:20:15 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:14 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>,
 stable@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 05/11] net/bnxt/truFlow: Fix seg fault when rep are re-attached
Date: Wed,  5 Feb 2025 09:19:58 -0800
Message-Id: <20250205172004.50395-6-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

When the PCI port is detached using the testpmd command,
as part of cleanup testpmd removes resources of parent
port and all the children's ports and calls the driver specific
pci_remove API with the parent rte ethdev to clean-up ethdevs.
For the bnxt driver, a condition to check type of ethdev is added
in bnxt_pci_remove and based on the condition relevant
ethdev is removed (VF/PF or VFR). As the RTE layer always
calls PCI remove with the parent ethdev, the bnxt_pci_remove
never frees children (VFRs) ethdev. As, these ethdevs were not
freed it gives spurious status in re-allocation check(when pci
port attach command is executed) and when RTE layers tries to
access interrupt specific info from the ethdev due to uninitialized
members it access NULL pointer which results in seg fault. The fix
is made in bnxt_pci_remove to clean ethdev for parent (PF/VF) along
with children (VFRs).

Fixes: 322bd6e70272 ("net/bnxt: add port representor infrastructure")
Cc: stable@dpdk.org
Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b18247feb2..144d4377bd 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6993,6 +6993,8 @@ static int bnxt_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 static int bnxt_pci_remove(struct rte_pci_device *pci_dev)
 {
 	struct rte_eth_dev *eth_dev;
+	uint16_t port_id;
+	int rc = 0;
 
 	eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
 	if (!eth_dev)
@@ -7002,14 +7004,20 @@ static int bnxt_pci_remove(struct rte_pci_device *pci_dev)
 			   * +ve value will at least help in proper cleanup
 			   */
 
-	PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d pci remove", eth_dev->data->port_id);
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		if (rte_eth_dev_is_repr(eth_dev))
-			return rte_eth_dev_destroy(eth_dev,
-						   bnxt_representor_uninit);
-		else
-			return rte_eth_dev_destroy(eth_dev,
-						   bnxt_dev_uninit);
+		RTE_ETH_FOREACH_DEV_OF(port_id, &pci_dev->device) {
+			PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d pci remove", port_id);
+			eth_dev = &rte_eth_devices[port_id];
+			if (eth_dev->data->dev_flags & RTE_ETH_DEV_REPRESENTOR)
+				rc = rte_eth_dev_destroy(eth_dev,
+							 bnxt_representor_uninit);
+			else
+				rc = rte_eth_dev_destroy(eth_dev,
+							 bnxt_dev_uninit);
+			if (rc != 0)
+				return rc;
+		}
+		return rc;
 	} else {
 		return rte_eth_dev_pci_generic_remove(pci_dev, NULL);
 	}
-- 
2.39.5 (Apple Git-154)

