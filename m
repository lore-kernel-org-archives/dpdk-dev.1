Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21601C982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:57:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3791340EE3;
	Mon, 21 Sep 2026 04:57:47 +0200 (CEST)
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com
 [209.85.167.225])
 by mails.dpdk.org (Postfix) with ESMTP id 9A6DE40E4C
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:57:46 +0200 (CEST)
Received: by mail-oi1-f225.google.com with SMTP id
 5614622812f47-4c0cd10d56fso2235430b6e.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959466; x=1790564266;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4MrpNE21E8si6mxP8KSQox8Pc8b6gu8il6ObRquZNG8=;
 b=p1yLYNc6dmT9/GqbBnarcpTICTvpqg5aRvs1X4OpEs2FG7p+aHbVyABBumsBp+jSJm
 InNMlkmpg6OQ1j0Vyap+5WWiZ086DUIktRxfniVnh6jrEuDSd/BAJ3ikQ3JE7WOmSnSa
 jlwHuufUjtkhfMnDaz/U/L0N6O6ZCFYj3c/XWNarIy/BmJHKpkGF20wUcNwGMnNRN4X3
 4GNN6kKDvOUyEVl8MPjqbPXob+Bu4TDc4V5Fyn4/OWinAyK7+eoUGQqKANXSTdc/EDO4
 GAYKl+LLfjuvY+g4RjN2EaGdypYomBkfMXdlHE7oPQcUjDD2JdpP8tAFG8xJczjblkPA
 /e9g==
X-Gm-Message-State: AFuF++nhpmD7JMkfQpBh/y5VQnhkQfUUJQ/+rJ8hFEL4SE/9E6o817wK
 IEznFbpXYsSiVqe02Gz3gEZlP1UwL+9FacvN0Zw8YxH4TsZxIPKBb0QPRVFV/ZBpIuE2QpbrpzH
 4GmXSD52IEo79Dz3oo8TFT1ce4zU15I8RmofF1Ak1rWEyJA6kpWA41vc7bvlhhLCXoSt+f5jOM7
 X5cLk6k8gFrczKo1z40XZl+PDMan0YBtVk6L8PKPtIIUKsKT5AUwQ1M43AQLtYOzQV0p/ebgnCT
 8oBuVmMtXVL
X-Gm-Gg: AYBFou2oPOV2YVqewSj8Eb8XnOsBTCEVX+d1buaBw0kBup91PRD+6jNTk5g35gnT8qS
 6FPO5+M7Nlq9zHI/i7iKx4SRZMh82BQAHKx/4hwlersUtwpQnGjGuskTC6/3/sqBXWoD+tcuMKr
 npAlgHgfnWFY7f6ToRyRU4zsl0yQKK3g4XdRs0NjyA+tU87cP+VtEa2BzwWU1i1Jr7w9doFpmdm
 olbOrFvnsRAMPj5E4whQo+zcaUTCXUCPhA2jCuYacckJN7CJ7Y7WOvFE9kzigEJbV2hl+kBwI5u
 Wev2H7Z3trNGUPaJfJ42XejHFWzHZMdrMANMKeCE37vdGxbva4tyksGMFcx4tlv/IZagsO1uziz
 qrkzwwC8BamaKh8/TRyK+d179CznG2rtlhb3sF62oxGTq4EpLfZxn8mOutXjyg7iKwJVM06co3Z
 GbEZaLPVzikTH9wWE9gZA832JzRHu/U4RFFRbXVWZuidBPOQiG/w==
X-Received: by 2002:a05:6808:1705:b0:4af:aaca:7be3 with SMTP id
 5614622812f47-4cb6870a38dmr10673954b6e.12.1789959465734; 
 Sun, 20 Sep 2026 19:57:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-8107b12c50csm3583198a34.2.2026.09.20.19.57.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:57:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e18af9f48so3892361a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959464; x=1790564264; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4MrpNE21E8si6mxP8KSQox8Pc8b6gu8il6ObRquZNG8=;
 b=FjA4FziWJuF3t0aPH1fJtnjdujw+cm3Nk09LQHQ+Z20GldFb1R5XzupDWVP/rKpyl7
 MAP53FeHva5TZibk06E2k+3ZZT//pqZK+gNPxELdv+HLFT8BKNkK3OgJvRWweWrcr/AB
 6AQCFh+d7mfkLzrcUVy//kBd/YZ1kksMfjjUo=
X-Received: by 2002:a17:90b:5806:b0:39d:e78d:32d2 with SMTP id
 98e67ed59e1d1-39e35e4bd9bmr16776735a91.13.1789959464025; 
 Sun, 20 Sep 2026 19:57:44 -0700 (PDT)
X-Received: by 2002:a17:90b:5806:b0:39d:e78d:32d2 with SMTP id
 98e67ed59e1d1-39e35e4bd9bmr16776717a91.13.1789959463434; 
 Sun, 20 Sep 2026 19:57:43 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a6e5sm15477076eec.7.2026.09.20.19.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:57:43 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: handle mpc ring creation failure
Date: Sun, 20 Sep 2026 21:00:47 -0600
Message-ID: <20260921030047.1034742-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

bnxt_dev_start_op() only logged at DEBUG level when bnxt_mpc_open()
failed and continued port initialization. Later action-record
updates then dereference the un-allocated MPC ring state and
segfault. Log at ERR level and abort initialization instead.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8e8ead8f61..8f629ec0e8 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1874,8 +1874,10 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 		goto error;
 
 	rc = bnxt_mpc_open(bp);
-	if (rc != 0)
-		PMD_DRV_LOG_LINE(DEBUG, "MPC open failed");
+	if (rc != 0) {
+		PMD_DRV_LOG_LINE(ERR, "MPC open failed rc:%d", rc);
+		goto error;
+	}
 
 	rc = bnxt_alloc_prev_ring_stats(bp);
 	if (rc)
-- 
2.47.3

