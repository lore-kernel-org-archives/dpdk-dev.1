Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7872FC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 13:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95A8C4026F;
	Fri,  3 Jul 2026 15:13:12 +0200 (CEST)
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com
 [209.85.215.201])
 by mails.dpdk.org (Postfix) with ESMTP id 218FF4003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 15:13:11 +0200 (CEST)
Received: by mail-pg1-f201.google.com with SMTP id
 41be03b00d2f7-c860544c077so1476270a12.3
 for <dev@dpdk.org>; Fri, 03 Jul 2026 06:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783084390; x=1783689190; darn=dpdk.org;
 h=content-type:cc:from:subject:message-id:mime-version:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sY5KZ7Rs3FAb81r5EhFZB5Q2j6FGa/KREoD45/Ipi+w=;
 b=VrbcwIuopRMEKvGuEevod6AaBIZkmG0Y3VANCEANZhebiZwji1vv5VgUF33JnFDLOY
 JJIfZwdZzF+F4zXHp8BpAZoX6v5x33bJHNK5i825ySY/Q1CVQPAIv2X42m5LWCDcdGqW
 GGqTmurM2GX7FEIjhKc1Y7uTR8vNMb7nTwNGmLvmDgEykuzVZSiJd2PFBzF05RIRZCyz
 wAhrYbpHzzUuAunCF4fS+w8tdUa4H5cPwdqd4FmnhFT32g+RM+t6SID1wY9iX9KeO9k5
 jnliVrl8J2O61HKiZRnHpXZxym6PCNbSkiTaFsLxBFBsQWLTS2vW925bBaBDpX4Q2Er8
 EKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783084390; x=1783689190;
 h=content-type:cc:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sY5KZ7Rs3FAb81r5EhFZB5Q2j6FGa/KREoD45/Ipi+w=;
 b=d3q3Hm9xtcoBa1NnDiBzro6cubXCx/IMphIBYRmb9WkMgr7ZUU8/zsUrTUmAecgDcE
 nMlsw6xKzq4azOfb95RLvCPAJYqvGtXFNNRKvoHyM9vVsbR8fUezGvBxf/zGsQG3Xm7Z
 /blnbmhEFc/Akjp3jhHENJfE4C0IboZbKAttE2jw3Qb8zwWjLS6GKDS9M5lS5djERzHH
 pTpjlLhVAn8WDCLPcPbJg6S/Py+MuuCdiOcTY6qznKjzMkdA+okhB8m3aQlk4MCpyoX/
 DKzg7d/fEFVbVFO2JQmE7HtLlXt8TGfVINmvk5XB5WhQeoeaRVPCWMviGXxZ4a9MgsPq
 tkSA==
X-Gm-Message-State: AOJu0Yy5E9ENDZGw8flnwWtRwjWE7dIX6CcjhtCdLmDrosX29O29sycY
 hkQbw5dYlzNzuUr9JmkZzHaeTbnd74z9wv5eA6YyCGUyCrcCpK2D6FZWt8U12+8b0aBY8zxdyX/
 dYCM/lyKyrmTLGgL75OyhpBDRJcv7g+HsjO7BvZnVqAB/008/ZkZICzDnY+U/pHARrktz0nqo/5
 CtWWbPgsijBUk3N4HO/DkAr2K0fxdUdPArPg==
X-Received: from pgn38.prod.google.com ([2002:a63:d66:0:b0:c99:5ef4:543])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:38c:b0:3b2:a809:ffe with SMTP id
 adf61e73a8af0-3bff407cf6dmr11041754637.14.1783084389682; 
 Fri, 03 Jul 2026 06:13:09 -0700 (PDT)
Date: Fri,  3 Jul 2026 06:12:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260703131308.2507403-1-joshwash@google.com>
Subject: [PATCH v2 0/9] Stability fixes for GVE
From: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

This patch series consists of mostly unrelated fixes in the GVE driver.

Joshua Washington (9):
  net/gve: clear out shared memory region for stats report
  net/gve: delay adding mbuf head to software ring
  net/gve: copy data to QPL buffer when mbuf read does not
  net/gve: validate buf ID before processing Rx packet
  net/gve: set mbuf to null in software ring after use
  net/gve: free ctx mbuf if packet dropped after first segment
  net/gve: increase range of DMA memzone ids to 64 bits
  net/gve: don't reset ring size bounds to default on reset
  net/gve: restrict max ring size in GQ QPL to 2K

 drivers/net/gve/base/gve_adminq.c | 12 ++++++--
 drivers/net/gve/base/gve_osdep.h  |  4 +--
 drivers/net/gve/gve_ethdev.c      |  8 ++++--
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_rx.c          |  3 ++
 drivers/net/gve/gve_rx_dqo.c      |  6 ++++
 drivers/net/gve/gve_tx.c          | 46 ++++++++++++++++++-------------
 7 files changed, 53 insertions(+), 27 deletions(-)

---
v2:
  * Remove unused definition

--
2.55.0.rc0.799.gd6f94ed593-goog

