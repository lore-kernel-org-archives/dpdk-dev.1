Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F9C88E75
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:23:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D75E942DE4;
	Fri, 18 Sep 2026 05:23:58 +0200 (CEST)
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com
 [209.85.221.225])
 by mails.dpdk.org (Postfix) with ESMTP id AAD9242759
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:23:57 +0200 (CEST)
Received: by mail-vk1-f225.google.com with SMTP id
 71dfb90a1353d-5c99b575e12so84211e0c.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701837; x=1790306637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vt82SvRn2cRRKaYhU8kiR8TQp2A4MNnqYPXc47RNH7w=;
 b=jny/4yshnkik3hNx4Aq/lgNH2AsWPFbtvGNdQL/kAemONxrRxPPkFlkW53b88vveXC
 Zc+wUNZ3NYqXZClgcWZ8IzOJLxrTChxEn7LZ/6gRHSIRxg3hBybRXTp3UkC3/GjvEUQg
 7NrtrT2eUfju7ix6M5c828BqKGkanobX3RXP2J5lQQPiTEsQcoXAMSAbzwbZu/RdCZ7W
 S+Bqo81fKVmvqrpy8xv4rlD5yQCMnb4OsWFOda4LwW5w+D8g4tvKI6Gqb2uKwNhiSYPH
 XQ6JvHGFf4wnnCwEUYY/hjCt2ShA8gZ3soq+2+Ws2g6Pk1UVO63NHt3p9J2RbndVhdji
 YF3A==
X-Gm-Message-State: AFuF++kG9cvtb79VMDED8iTETpqCp0FNfx7c0W+rYNurnKCb5JvF3n5N
 5NVVoOSMsb4UHm5719lEVUNAZO7jD5MyFk+jtguvNOG24P9Hfi22F7e42M1/Jn2HKorfWWlPQQY
 TUP8Yz51zgvQkX0+XkRndJTP/Bsh1r9JwH+BMzrBSCS7btlBJuNtWXvaVn6mYK1ulyud1s7yYe2
 J6zVSAT3UJtTsFERdq186aDJmhnkmsr83ve2p7fL786YTUCyuq3+vrZO2R0FB/1xe0brRNwuXfx
 1iG0gXDJstv
X-Gm-Gg: AYBFou2EmEl/rh+D1lSBe/HbNXVRyHup2NF5ZHbN9scE7rHuQyMVtUudhXJtOjkVFwf
 Qjuz7pnxpBRkJSmr5hvQoZwiwO5Z4tJJ5mN7WVR7pqozrN5AdUkTRU5k7lY9cLALrVqoElEAQ3e
 f9KQv60Z1I35uSfsUEx50cs3sFrxOw/535yMwfcswsQOA4iO0miRovcWBZ88moTwP03Jt1gGcrc
 mY05Dpe0DVm5lZ3lzIPSSWadHfIDgoBIRPHfbQbIw6M/8vKItnSRlzlwcWx+PTQliLVJQ0xD5kr
 mOYXjSBnuuKvvI8CgfCk7ruXWKwNW8eKJ24WxP8JHbxZG20JKWiAP9XOObpBC/Qbv36g4er8LlV
 iLdtWOaTy/Q9kquNhuUGDLJh8Sc3MgJvFlKuxu9g1eNS5jZDXttdJ8NB4/wBzkoJIgnPPBWAPcl
 LOb3r/3kR+4V+U6+nGR4xeVmPlUsKN9jNsRMsZDQykflrdrBuwMw==
X-Received: by 2002:a05:6122:8c5:b0:5c8:2a47:b111 with SMTP id
 71dfb90a1353d-5c9b58bee96mr559063e0c.3.1789701836938; 
 Thu, 17 Sep 2026 20:23:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c9b8067c32sm219504e0c.0.2026.09.17.20.23.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:23:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so5433925ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701836; x=1790306636; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vt82SvRn2cRRKaYhU8kiR8TQp2A4MNnqYPXc47RNH7w=;
 b=GcoX6crvfPENJqCTwaGS2uuKBWB4ekJaJvPgWg5qUrOW1v6qPRlIR6ehLZPFglz2W0
 x39IdJFQDp4tA1/Lwgw89Krt9xiSB2x9+DUnX5zkQX68UhSgspwmvv5tfaHwvt5bbxR6
 vOIZ0obury5H3ZUH5EpIDUYjH7ktBRPTxunaw=
X-Received: by 2002:a17:903:2343:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2ddb1ab24edmr27227615ad.5.1789701835736; 
 Thu, 17 Sep 2026 20:23:55 -0700 (PDT)
X-Received: by 2002:a17:903:2343:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2ddb1ab24edmr27226825ad.5.1789701835078; 
 Thu, 17 Sep 2026 20:23:55 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b0293sm543856eec.24.2026.09.17.20.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:23:54 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org, Dakota Sicher <dakota.sicher@broadcom.com>
Subject: [PATCH] net/bnxt: fix flow create segfault
Date: Thu, 17 Sep 2026 21:27:01 -0600
Message-ID: <20260918032701.763364-1-Mohammad-Shuab.Siddique@broadcom.com>
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

When creating a flow that requires a destination queue but none is
specified in the flow create command, find_matching_vnic() returns
NULL and the code falls through to insert the new filter into
vnic->filter, dereferencing the NULL vnic and causing a segfault.

Check for a NULL vnic and reject the flow create with a clear error
instead of crashing.

Fixes: 59119d49529e ("net/bnxt: fix flow create when RSS is disabled")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..0a2899fbbd 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -2148,6 +2148,13 @@ bnxt_flow_create(struct rte_eth_dev *dev,
 	}
 
 	vnic = find_matching_vnic(bp, filter);
+	if (!vnic) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Missing destination action for flow.");
+		bnxt_clear_one_vnic_filter(bp, filter);
+		goto free_filter;
+	}
 done:
 	if (!ret || update_flow) {
 		flow->filter = filter;
-- 
2.47.3

