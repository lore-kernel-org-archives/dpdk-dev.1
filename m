Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA9BCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 19:03:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C1404113C;
	Tue, 21 Oct 2025 21:03:02 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id BF4AE40F35
 for <dev@dpdk.org>; Tue, 21 Oct 2025 21:03:00 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-87a092251eeso2634666d6.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073380; x=1761678180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5pyhTRQoTWuJoAeyIp2Z0nbbuUXiOFFlrmWnZcPVfJs=;
 b=qFm3PkKFgfe6wrb5h2Cb4FAYH/vv3BbmHfzRtzKYNqWj3165MKvdXwBvp/sCxG6Fdx
 KdNMX9qKur3zPYCNXNzHXy70SYcJ99Pa5fD8gJWzU3rQJdv0exFtqb8LAN+pjQ+AhqkA
 KoxphNti+HHX+K1ebmmBcrDxlD0cnDg7JAMwRO0xhftQwvGYoJfVjkonYR8Xy7gQhv2s
 90s8ymHbc0b0eBLIxZUzwAqdG2yHqeN5cVsWvdgFfqWoDQVxw3l7nNUDKSra+Lsfwjjw
 Lsl++jA8AJ2GdcInHJTc4sWSs5YQAm0I3w2rAWXcmoVF3hI36mGteIcAuUpgmfhyHd34
 OBKw==
X-Gm-Message-State: AOJu0YxzhVI0d97SmM+AlvbMHW7rVJQ4uJ6SLsKJSjTxUwkmBG0QPGOO
 YuOmwF1SV7sWAh/0HDOcxd9dI74Yajq9yn3CBEDR6PmO3QyQMQS+ltUuDOPThA9RC/EOwt29UZJ
 sCqC5D1W8K5zmBb+fcuGCUVYvEWsQWK6APMf3obNbp+GGsaMEuKxAiChTXgr87KwNUN1NVdWL/e
 7EUrSG3TPHDgxaHJNcdmC8FJRDHYePQbE4TMzQWcqMyCalTb+VZt+HmrPLqsj8kEnpx1SyUQ==
X-Gm-Gg: ASbGnctpYHF9H/wR7gmDOg2nUswjdfwjhKRQh4eLociq0jKXWQiU2X54NN0/C9eTBvr
 DfCX1qra1GtVpIprzQ3J8noQDajzmtSLMwX0HyKinj+/OyCvVODvDH5uHiZfAoKJhMAqaGYHonc
 vC1Qlm09LLIxK4KKhyopj4lIKMBkScz/4K1RnPGuJSxp5VLnf+89ibVb/T3zY5PmYBDPjh/IPEr
 GIeXDIHqosYuCF8E1XOtA4QJyPHF+YBE2QEVvWocGIIp8dslYGxgvTuN6L0ZLPD2v+I1c2xT4MK
 y7M+3BKnqF0FIdk0Qzksn+0QgLNMdpX5MrQubX9xOY15DSNSRsF2N5LjIWxCrSYdrPqmiZL5So7
 RKIXpRcPp9u0DaTTTbGMV/TUJBxWFPfbOJX1Gxv4tqVclih8wZvs9C+tC6MZgxwJ6S6xEhq0uZ9
 ++zBEwE84OJTc3WN6JrUQYVxVmTGhLMcNPxFQD
X-Google-Smtp-Source: AGHT+IEhtc49V59yzCPu5tNnZylQ4dme9Gkv6LchetRT/JiV/UMMeT/wAO7Xi4pRvKWas3AqLJgjZ4vSRCZI
X-Received: by 2002:a05:6214:2a4d:b0:7e6:7392:f7df with SMTP id
 6a1803df08f44-87df66f3eefmr11082276d6.6.1761073379955; 
 Tue, 21 Oct 2025 12:02:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87cf54cbeabsm13899476d6.32.2025.10.21.12.02.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:02:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-780f9cc532bso185499b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073378; x=1761678178; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pyhTRQoTWuJoAeyIp2Z0nbbuUXiOFFlrmWnZcPVfJs=;
 b=aBptaKIZ1FUuDghjyc1yIxwYOeK9l1Im+rtdJcUYEuHFbciJDbjikP9Xkq/oSeHrMH
 GtjmnxpGe7p6to0zhrPofV+L8DH+GItT+BkFrqmEqNmlvfHb0ujmb0l/dgxs5XwHjjZs
 B440JqPPM/2LRJqx2bcf3rMGomanC16RBpdNE=
X-Received: by 2002:a05:6a00:69b8:b0:77e:4534:7f1c with SMTP id
 d2e1a72fcca58-7a264716a28mr706243b3a.0.1761073378379; 
 Tue, 21 Oct 2025 12:02:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:69b8:b0:77e:4534:7f1c with SMTP id
 d2e1a72fcca58-7a264716a28mr706200b3a.0.1761073377632; 
 Tue, 21 Oct 2025 12:02:57 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f256dsm12011019b3a.50.2025.10.21.12.02.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 12:02:57 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v4 56/57] net/bnxt: add support for truflow promiscuous mode
Date: Tue, 21 Oct 2025 15:01:57 -0400
Message-Id: <20251021190158.74064-4-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021190158.74064-1-manish.kurup@broadcom.com>
References: <20251021190158.74064-1-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The truflow application support promiscuous mode to enable
or disable receiving the packets with unknown destination mac addresses.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 7a2dd08951..3c618c6e82 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2161,9 +2161,15 @@ static int bnxt_promiscuous_enable_op(struct rte_eth_dev *eth_dev)
 	old_flags = vnic->flags;
 	vnic->flags |= BNXT_VNIC_INFO_PROMISC;
 	rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, vnic, 0, NULL);
-	if (rc != 0)
+	if (rc != 0) {
 		vnic->flags = old_flags;
-
+		return rc;
+	}
+	rc = bnxt_ulp_promisc_mode_set(bp, 1);
+	if (rc != 0) {
+		vnic->flags = old_flags;
+		rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, vnic, 0, NULL);
+	}
 	return rc;
 }
 
@@ -2185,6 +2191,11 @@ static int bnxt_promiscuous_disable_op(struct rte_eth_dev *eth_dev)
 	if (bp->vnic_info == NULL)
 		return 0;
 
+	if (bnxt_ulp_promisc_mode_set(bp, 0)) {
+		PMD_DRV_LOG_LINE(ERR, "Unable to disable promiscuous mode");
+		return -EINVAL;
+	}
+
 	vnic = bnxt_get_default_vnic(bp);
 
 	old_flags = vnic->flags;
-- 
2.39.5 (Apple Git-154)

