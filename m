Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B1606B2CB
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SbjGtX46
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08CF1427DA;
	Fri, 13 Nov 2026 17:05:54 +0100 (CET)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 2C1DA4028E
 for <dev@dpdk.org>; Fri, 13 Nov 2026 15:23:06 +0100 (CET)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso1743745e87.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794579785; x=1795184585; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w1XrjAcBlxWKaCJlU/GKg3RQzDokGtfu6Bo/8TPrKCQ=;
 b=SbjGtX46u+jgE1Yf0SGZTtyUU8IdOh7b5x5hpeW3AaFvyJ7XFHATLOG+G09IFue1QS
 gvrH/hGNXJrC2h8MSPEaAW8Ri6KpKJsT3Dnf21Qh/S4nHJUhS0uEBdeEcaNHKtJHELTx
 hL/cplZ5iSdzLpaJKHv8bUm+4QBnLYQrsbgXqM8q3B+ibO9OYxgxyKB0oYC1kyQF4ZbL
 vMPg4Qamu28gMY5EUFK/kQ5z2x8dki1CHCs6LObjMiriZsc3hA2fHqJSHB/hwDlBpcpw
 6mK1XV8XHTVNoktlVU2eBYGlH253O2zC0o7GKsH3HOnF0/h4V9Xgh1fY2X9JkAcJC0mI
 QsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794579785; x=1795184585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w1XrjAcBlxWKaCJlU/GKg3RQzDokGtfu6Bo/8TPrKCQ=;
 b=YKQ1QoENyyZE2FAHtGDz6E4cxicKf9N4CRdOY63/yCdthAY6/j1Wu924iDH09T3qYP
 YmES+bR3giipTCrFzYp3ArOpon9sUFsAm09q2YtlaA9rtua0pMNA8TlMM56C2p/4T3nS
 tky2UKflr7z2H0nJS5k+cwzt+DlZbbuhXIxUscUywKMSbuMCC5N2NJC7cvoul3g1YMRs
 TrLipErAcGDy9xsRI9+R/AX4heKC3kiZ6u9CMotJTwbhkEJGBWau54paRNMBTI9ztlVN
 JT1V/fCBHOEg8kpzvml3h7GU3ygG/7WglucRfEht8eTkuzBGJLtXQSGP+00ybe7L4KHx
 NlBg==
X-Gm-Message-State: APuU4Z8HeUQ1RO1sa3UCwxO1lb46xVmxJ1GnbmbNSHn1UT9Go4GuM7d5
 4S2GEjt+ZpCeu0rpHLvn4cDNRBC0oINVmgpQL/EKPxedrfilYUt/CP/b
X-Gm-Gg: AYBFou2rJKorxGJZqirz4Jx+bO8729romEHtN+n7q6Gxp+aXge9E6YWPxsSKdDyLezg
 bSrx11GoJ7p0CZdVP8M+5nhslzsLPtoqy4kujrmeRWnq5iiWyM2iqDufjOCiX/CHao0hMpBWQwn
 Kd/XrNUpJdxT2e4ROOTKGrPjuAN0RwMapWuxT0NRhyyvZMcpWSzb4q4ciX38awLwIT8CkRjKX6S
 ++G/81MhY/sIX11RLV+tYzGCmurbPgvbxk9YDt8Po38lnU9uH2YWBIHXkyupzgzhkErk96sqBpW
 WZzV6+zqHt22ircVDGmWnG7f2itpLF9Y9TeJZNtMRa1psGyI+h0xIIpp5sF9ySuJge/zsWLWfvk
 H+u/4Awh4jgUktwaZ+YzqB/7tZVU3NnCwd2vDuE96lm6kwtkBEE7iQb1C8DVe++a9LpqU+P6wuz
 DQ2JL6PwfReUjT/oqSCK+R5EqJzUIv4SuEyD5MpX4S3KcPfz/bMQiovkFJleuUcKzl9JbNiDWSO
 8aPna0SQma+7Lr8DhGZ5v6NP5HPvJcNt+ZfRQFSD2I0b/wUvj6pL/TfM+enZpm3z+JFenLTH/Oa
 QoFfTN1pkHkIqxdS2pHjYrqpH7NdtUDq0NJT1mUk+/z9xZWx
X-Received: by 2002:a05:6512:3c9f:b0:5bf:b8f1:816c with SMTP id
 2adb3069b0e04-5c170a0bb31mr1180190e87.19.1794579785143; 
 Fri, 13 Nov 2026 06:23:05 -0800 (PST)
Received: from localhost.localdomain ([85.172.76.155])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c171356420sm819353e87.68.2026.11.13.06.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 06:23:04 -0800 (PST)
From: Bulatov Mark <ms.bulatov7@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Mark Bulatov <ms.bulatov7@gmail.com>
Subject: [PATCH] net/nfp: fix uninit local var in nfp_pre_tun_table_check_del
Date: Fri, 13 Nov 2026 17:22:07 +0300
Message-Id: <20261113142207.5537-1-ms.bulatov7@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mark Bulatov <ms.bulatov7@gmail.com>

If the search fails, it leads to a null pointer dereference when attempting
to initialize nfp_mac_idx.

Fix this by adding a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d3c33bdf1f ("net/nfp: prepare for IPv4 UDP tunnel decap flow action")
Cc: stable@dpdk.org

Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
---
 drivers/net/nfp/flower/nfp_flower_flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/nfp/flower/nfp_flower_flow.c b/drivers/net/nfp/flower/nfp_flower_flow.c
index ad0fe9a8ef..b70f24c1fb 100644
--- a/drivers/net/nfp/flower/nfp_flower_flow.c
+++ b/drivers/net/nfp/flower/nfp_flower_flow.c
@@ -3828,6 +3828,13 @@ nfp_pre_tun_table_check_del(struct nfp_flower_representor *repr,
 	}
 
 	nfp_flow_meta = nfp_flow->payload.meta;
+
+	if (find_entry == NULL) {
+		PMD_DRV_LOG(ERR, "Pre-tunnel table search failed.");
+		ret = -EINVAL;
+		goto free_entry;
+	}
+
 	nfp_mac_idx = (find_entry->mac_index << 8) |
 			NFP_FLOWER_CMSG_PORT_TYPE_OTHER_PORT |
 			NFP_TUN_PRE_TUN_IDX_BIT;
-- 
2.39.5

