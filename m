Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06175CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 654AC40664;
	Tue, 13 Oct 2026 19:16:07 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id 6EB0E4065A
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:06 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cc4ca696de6so1742885a12.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911765; x=1792516565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xuHNwHr8O+gbfxL0zrw2uW5JSzLMjRc3TXXXA83ueKQ=;
 b=BqQMR5MT5AsIA8AA7aBVZW8QiBrhse6ArHsZvuot7FHKF9tlC++DZbu+18XZ+qt3Hk
 DA0ev7dU2JpFoihMNjlE3EHpuRra6rNdaXbz6iXpYLUn67vWd3w5cbzeykNTA5RXugjJ
 p3d1Lk5AbW63F1bUqGCJkNAnvlbip0aNMuq1WOsh2OCrS3/N7+2WbVuJQAziP/kNmjEK
 5rTcnFSMZIm/QAIW2dZZ/W/Pq31Qmh59SQv/iPwvXKwQAMcm6oR8zfrP7dKVGbHSXHdY
 qbjBFBBRlkGqHvpX4Qc0vbnl2zvJe6hdTcpCFNU3n3P4ikjWYiDa6gCsYjF5YWtAvuD3
 oVDw==
X-Gm-Message-State: AFq9FYJmjE3h7JW2fjqreK23sae3vVvLZB/i2BxNyJoUYyWSuQqyhWhh
 3N7nob8zl9wneIpDfp4ZknsLW7yBlGQ6DhqL8q4Vshl5i5ZIZc3zPLtGwxoejTHsRlqX/LmPpsn
 lxVo4DIR4gAfsgnWOu/Y/xozZ55mnQxxsjssPyJr7Q8qOAZkJAk/HFaDP/Mh9K9BMRt3Ye3xE+X
 0VkKfQ4VMlXgnVLUzrUIEgMBPAiTwJJ3ZJWqhmyg0nNgMDBa6xJmntqNIkbWCxzH8O7+uyTJRcI
 V46sa9lb3Cs
X-Gm-Gg: AYBFou3JUjcXvydgzNlPKEeJprZUmuJBONqzO0IpV7KKk9H1o7MQvm+VoIcxrnSHX24
 PkTeHPQ2oejRvB8YsVJJ+PmQnqsdk2W7Nwm/BJwKkwAp3N96P8isCRZ/AQf8kE4xfjUPJqi0+4H
 1C4rhNI/38R5YSjq10mOEaEtyqBkYpJYSYaEBeSmc+JnerKxyj2mWbzCopnERWY8VcMMcYCHFGr
 N17V9yV37F7uMqnEUkzftt24McOm1mPtkGEI6D9muphGeJP/2zaGpczW0bTEnTrJhtB2DPLyGQ/
 LzheU9k6yHPYGN9jpWKk9nFe7FQ2YWJ9IbMgjMpndVYS+COsrXN35nFQx3ulLvzPRzhyRPY04hu
 jhnzCqciKVTmlbQTELCjsyNrr24eGjVyl8O3RcFowjf41IQelePUc/FjnlX+Q0JQCnpUe7IhrZ7
 BC2L+uPMTbqJW/3qRV9dPOuSnJvqvw3AznDad4Np7fT0Jlbjalfg0f
X-Received: by 2002:a17:90b:544f:b0:3a7:8c68:6446 with SMTP id
 98e67ed59e1d1-3ab3acf5d75mr10791092a91.63.1791911765447; 
 Tue, 13 Oct 2026 10:16:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ac5f1ee024sm127786a91.0.2026.10.13.10.16.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so30498986d6.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911764; x=1792516564; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xuHNwHr8O+gbfxL0zrw2uW5JSzLMjRc3TXXXA83ueKQ=;
 b=fSCJts+OZXg2T/bBOAf7bbcWWeCokPM66eiiLjJn26yhwFiBdV2Iai0hX6/CdCII0T
 qBwV36VXauCCfa7RgSDiE/u8B61uCCZqRxWXHZrU2x08EClvr6E55An5P0o9VWuptn/g
 hPtg7H+RV/xXec+yGdz6wJHjO+7yfnHtq0BQg=
X-Received: by 2002:a05:6214:240d:b0:91b:9136:d30a with SMTP id
 6a1803df08f44-91b9136d6dbmr74535166d6.10.1791911764029; 
 Tue, 13 Oct 2026 10:16:04 -0700 (PDT)
X-Received: by 2002:a05:6214:240d:b0:91b:9136:d30a with SMTP id
 6a1803df08f44-91b9136d6dbmr74533846d6.10.1791911762684; 
 Tue, 13 Oct 2026 10:16:02 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97bce2b8sm30357826d6.37.2026.10.13.10.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:16:01 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Joseph Wong <joseph.wong@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: add bounds checks for FW-supplied IDs
Date: Tue, 13 Oct 2026 11:19:44 -0600
Message-ID: <20261013171944.452376-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005235034.26923-1-manish.kurup@broadcom.com>
References: <20261005235034.26923-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Joseph Wong <joseph.wong@broadcom.com>

In ulp_port_db_port_update(), firmware supplies IDs (drv_func_id,
vf_func_id, phy_port_id) which are used as array indices. Add
strict bounds checking to prevent out of bounds memory accesses.

Fixes: 45e8e1d406b7 ("net/bnxt: enhance port DB")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
 - Fixes tag corrected to 45e8e1d406b7; the previous three tags did not introduce the unchecked indexing
 - Use %u for the unsigned values in the new log messages
 - Check phy_port_id before the parent vnic and MAC address updates

 drivers/net/bnxt/tf_ulp/ulp_port_db.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_port_db.c b/drivers/net/bnxt/tf_ulp/ulp_port_db.c
index 69077717253..e41b9bf4b43 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_port_db.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_port_db.c
@@ -159,6 +159,11 @@ int32_t	ulp_port_db_port_update(struct bnxt_ulp_context *ulp_ctxt,
 	intf->drv_func_id = bnxt_pmd_get_fw_func_id(port_id,
 						BNXT_ULP_INTF_TYPE_INVALID);
 
+	if (intf->drv_func_id >= BNXT_PORT_DB_MAX_FUNC) {
+		BNXT_DRV_DBG(ERR, "Invalid drv_func_id %u", intf->drv_func_id);
+		return -EINVAL;
+	}
+
 	func = &port_db->ulp_func_id_tbl[intf->drv_func_id];
 	if (!func->func_valid) {
 		func->func_svif = bnxt_pmd_get_svif(port_id, true,
@@ -180,6 +185,11 @@ int32_t	ulp_port_db_port_update(struct bnxt_ulp_context *ulp_ctxt,
 		intf->vf_func_id =
 			bnxt_pmd_get_fw_func_id(port_id, BNXT_ULP_INTF_TYPE_VF_REP);
 
+		if (intf->vf_func_id >= BNXT_PORT_DB_MAX_FUNC) {
+			BNXT_DRV_DBG(ERR, "Invalid vf_func_id %u", intf->vf_func_id);
+			return -EINVAL;
+		}
+
 		func = &port_db->ulp_func_id_tbl[intf->vf_func_id];
 		func->func_svif =
 			bnxt_pmd_get_svif(port_id, true, BNXT_ULP_INTF_TYPE_VF_REP);
@@ -198,6 +208,11 @@ int32_t	ulp_port_db_port_update(struct bnxt_ulp_context *ulp_ctxt,
 			func->table_scope = tsid;
 	}
 
+	if (func->phy_port_id >= port_db->phy_port_cnt) {
+		BNXT_DRV_DBG(ERR, "Invalid phy_port_id %u", func->phy_port_id);
+		return -EINVAL;
+	}
+
 	/* When there is no match, the default action is to send the packet to
 	 * the kernel. And to send it to the kernel, we need the PF's vnic id.
 	 */
-- 
2.47.3

