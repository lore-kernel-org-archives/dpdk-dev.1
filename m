Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B1CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6C7240DCE;
	Wed, 29 Oct 2025 17:24:42 +0100 (CET)
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com
 [209.85.160.226])
 by mails.dpdk.org (Postfix) with ESMTP id F1A0140DD8
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:24:40 +0100 (CET)
Received: by mail-qt1-f226.google.com with SMTP id
 d75a77b69052e-4eba6e28d06so34995231cf.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755080; x=1762359880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5pyhTRQoTWuJoAeyIp2Z0nbbuUXiOFFlrmWnZcPVfJs=;
 b=L7+n77LUorCGdZm+7xJNpAVxZvMCEOGj/6e6tisTy+QNNvsBMvMvrp5KXfVg2hCfz2
 fytqQNkOJjdvBaCW0vjfnBzifdvx+2N55U9KrbLwlRXzvfe2u7ms5WniVU/teWKfOGlL
 7TPeIIRJ32dDtZBPe4l7t+UxjIVngGwa0FaLDGt7ju8M0kP8Zy529G3ClK9bfZLAqIVu
 hz0OLLFP76wukF1fHNsW27u+QisHhHFvZb2J2kZdzjGF76A6Gsuw1zZvoMyhwnwtlUvw
 Qz747ygKYXH7pGsBKWg0wp5qLGTdaqpFyDhVtuM5aliUsSHaxZt+H5P8SeczdjBryT9u
 G6og==
X-Gm-Message-State: AOJu0Ywq/j0o4qbjy8Tvihu6Ua1SfzpWXfdNVL0uouRJ6W1EvLR7bQj4
 6tasdC5gNerI+WtohUHHPtxeZyH06myH/5YAX2MzeM+de1vZdQ3aCKLzns+P+DLThiHFFiDpTto
 pCHImRczS1ljQYEivO6YJK8DzzxzVvYV6OQi8yjkPWlFIRys5CMrsC9Eb01Eve5yaP01kHr/mG2
 5Y7pDgsnBSdIZbsVOyXmSQYGnfGKwaOVpn6HZe4TMpcEhTOYsCes6KTFdpdAeWD2+sQCPR+g==
X-Gm-Gg: ASbGncu4LuNeYi0JDUm+J7ZaaO5lWHSCP15dRkKibfu4ywoQ7WAqC++cmdlYrHv8URS
 88Db/b+AM0n4aJSaxyM9BmC42sDDD+P36n3MuUH9WMhkevuSr6Zwwvbn9dfGBlSenhJJT/oh47n
 t2ddipkpzvV0gRb2pycs9GTTTATDnJ7CFJ+ymdQ6qXki99c+hUpdfAkq5NckT233KsleCjXlN6l
 PFi7aJllSfvXFXbVNHfgCvhaKJL1vyhTp0XdnwD+ZIj2Id8/QnDQlNQVNrPK/bEozaCi0ZIFd8c
 QKdMmJdFgq5Mqbl0aISBpljmtWRR2HFKgK6kVg5+uCXLMugzAouCcJsHxbflss3hm/W26JCRRQs
 rI5R1cXUPISmJPRgGbfkLZv8MYPab3oDGqkXq/qktboxrROYlDyCoyfmBdggAGvJcb2YmYcLsxx
 aPLQrf0dtMAm5+g2c3J23bcsyn8M1Y/H5dhbmM
X-Google-Smtp-Source: AGHT+IG5cDQ9CVh0UNQtZdgRnFHctVYNaqYccqNSN3Htxxms8CMndA4P2jil4uO1NIPMtvmVUrUedC8+9ERG
X-Received: by 2002:a05:622a:411a:b0:4b5:e8ae:2c4f with SMTP id
 d75a77b69052e-4ed15c7ab32mr44295041cf.51.1761755080295; 
 Wed, 29 Oct 2025 09:24:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-4eba37d6f4dsm2977611cf.2.2025.10.29.09.24.40
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:24:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a27ed89773so1148473485a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755079; x=1762359879; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pyhTRQoTWuJoAeyIp2Z0nbbuUXiOFFlrmWnZcPVfJs=;
 b=gsrjrAQ4bSxMrlNqWEk6PQa5loc+/dFF2AzmZwz81S51rS2rqo/hyFHE+rKio8m1wV
 shErn5v3DAdZhk2AGv7l9RUzGp0Bes3+dCBixd37J98zdta0n/ptTnrZyHgrG+t7Mky/
 NaJdKgQAI+pnftVY8bTq5Z+5gGr9KvXsRQCAk=
X-Received: by 2002:a05:620a:46a3:b0:8a5:7b51:f93 with SMTP id
 af79cd13be357-8a8e6954c06mr479061585a.68.1761755079188; 
 Wed, 29 Oct 2025 09:24:39 -0700 (PDT)
X-Received: by 2002:a05:620a:46a3:b0:8a5:7b51:f93 with SMTP id
 af79cd13be357-8a8e6954c06mr479054585a.68.1761755078509; 
 Wed, 29 Oct 2025 09:24:38 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.24.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:24:38 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v5 56/57] net/bnxt: add support for truflow promiscuous mode
Date: Wed, 29 Oct 2025 12:07:11 -0400
Message-Id: <20251029160712.58519-57-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

