Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B60D1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA234060A;
	Mon, 26 Jan 2026 19:08:22 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id A2ACE400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:18 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so2850309f8f.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450898;
 x=1770055698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=BSx/3+rMmdwaT/6JKwzNP1wczNTL0vGWQYiDZIqXPN0GSJ80ypOpAybcHq6txlIqni
 /M6ixMwcP8c3aNCRvHbR/2EDTj4ji+TaV7LNkE6taQx50skFd9ttAGR69wI52Ay64Ab0
 0dM8VbPOkU16COfTXFVV14F19P8CBVuPMTP9nMZJEe9zFUAiABHFcCLm1YHDhlh66xDG
 hTZuoU9rqfoIN9A0qjsZycy6Our0vNZ8K/HQKgH1Z+NhHg7qxSTMY45Kn0hwC7R3RLSK
 rB80sm3pKU+CsVUEOxOr6jm+Leh8/JsFcpsm6omW4TgPUDmz4RtBnPwbxRQXz+qaCGlA
 lplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450898; x=1770055698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=hgFnY3dzKsKoFZ204hRxHrMSGurLqkkhY07qD8Zuizy7DtVjVwDPPAh+ok9i1So18Z
 tc+HDzuROOFZh+43aVEL/w28UAN0Qiv09BNiFE5a9nTXy12ODoh4fpwr0Ue+49TWyQ3T
 jGJhUidcX+PK7ImP6PM7Fw8c6bGqTghxeBlKmylz9mcyF1Xy0ZZB4n0Dv2jnl9Sxqc2o
 NhBc1adePTEpkH64q7mHTVFxKw1NTEyTGbVlkovEj6LLP0bp6qAqQUKmhwKvgQWRFfoo
 sj4iXYM/iotPIrfzVGK42XzUL+DK8GjTEPbHB/s6V3HYSluikAOmfcQoeN1bTPCj8Rlp
 VXPQ==
X-Gm-Message-State: AOJu0YySD32OdSaftcqB0oSPdrwQrPDMDgOV17kb38hX7RwycQ5ki74/
 646B5W23gKUV+PkaGppZsgeawcSk2aKaWVdWEvgychHDb7wNV1vBUiqDRvCGTSy5JeGHOrtrL6s
 EWuE1
X-Gm-Gg: AZuq6aLrUGuDPJoqN+lx6ZcR1M6ALwyp2Qp17kvF//FTL/Duhzia/GL4BzbtTF34iO8
 or1aLmrRd6KsSJ7vUyKm5l4qDwodn64hRtAOSAY8aPphcf0UsfkzXgMS7wTKcc1tjAp6Fgw9bOY
 YVb3J3EyzJkhWwMimf5kjlyetSbb4J06qJdqPcQgNAeSTTJSmuTIgI+WtxeQmkUkB1buL5qsFZa
 AoDS+vqzqMRGZVlRMJsLilzNf8NGunn16OP8sGQPkuP/vhmDx8UHj/u0ZlDVMzHWAdJchO9SU7P
 66xS0Z3hXD+MuyH8oQ+W7/fuccCcwpaEdEEsWWOijPdSClULacx1Zt37MUSgCO/06dYdmvKN17/
 hNc3s4EQc8H9B2dd/e7YEN5g7QmGRnMWXHS3uG3ow7fOaeYiYq6pbyCpTbY9GXeC7lYCbm7+YuL
 md4ym0V8L4HMvgmSYBY00CnUCUPZAXOYqgzIqolWy4kCOibmZx2w==
X-Received: by 2002:a05:6000:2c05:b0:42b:4247:b077 with SMTP id
 ffacd0b85a97d-435ca1ada09mr8852342f8f.41.1769450898264; 
 Mon, 26 Jan 2026 10:08:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 04/13] net/pcap: remove unnecessary casts
Date: Mon, 26 Jan 2026 10:06:41 -0800
Message-ID: <20260126180807.100891-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

The function rte_zmalloc returns void * so cast is unnecessary.

Correct the indentation in that code. Not really worth backporting.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index d09ba5abe9..0177cbc7df 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1221,9 +1221,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
+	pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 
 	if (pp == NULL) {
 		PMD_LOG(ERR,
@@ -1591,10 +1590,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
+		pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+				 RTE_CACHE_LINE_SIZE);
 
 		if (pp == NULL) {
 			PMD_LOG(ERR,
-- 
2.51.0

