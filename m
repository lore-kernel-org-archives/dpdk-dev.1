Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073D1CA9EC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 23:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B99AD40279;
	Tue, 13 Oct 2026 01:19:16 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id E4B7F40279
 for <dev@dpdk.org>; Tue, 13 Oct 2026 01:19:14 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cd61a2dfd7aso3940a12.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 16:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791847154; x=1792451954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kL+VlcHIzyG+0BpE+RaXryEjLqYt1kPq1tGomLDIWZo=;
 b=a5cc54oIsnpg84yx/FrujC60jWJ3okk0QHJHxHOkvlDut6FYuahGs4JfuAqQCPcD6G
 4MXMT4vL+zk28AfrpQ4SR2dK/Ha64zq03oqv0MtYu+fIvXRZqQo1k+Hwz9rNyA5afzBF
 uROwnw3tCjzRxVlr0go5INUVXNnNv5JjnL6Jw1gv9WC8Xt5ob1s1lxmbgmixh0pD8Bdy
 xnw5Uay2R44NUXhovFdY9arlJSsZcRqTP9zIJ08rsagw6rNvtkavcPOAw4LfFZ8FRYfN
 TJlLwyHRE4YRIAJq+8410O6JxIyNuosRwhSChpBtdmwyUXH42YBn5JeMWEXnQmzX8qCZ
 FTZQ==
X-Gm-Message-State: AFq9FYJIJuJnx3LyIpuQsrWQjJQb9G8dQXeNwdfcTpHJNDF9rweH9k1e
 7/rV2I3sd/6BZDFuyCBKgImlo/PGfGzlP2/8FAtAPGHng8dpilOSNRqh0jZkXdnJOBvYWgy9Mpy
 QDokm2SMUfzkYaI5KWOzAalMddyzql6CSvCHMjemzKPu0koiNdTnCWnlOip39o6abUjc4f5bE6q
 xCzNcbaSd7GP2THeNWuC83wabHWFHJU+raaQYSw5bjEWmwDSvpHX5kHfXT/aFeaP70QF+pXVbJh
 Q2pJIET3lpD
X-Gm-Gg: AYBFou0lBVzqeDLvqEI02o3RsF62afOZ2LXRCCZ24Asfuu/fF7R0uWHhCXUHPR8XjTp
 Y6a6TaXqoIK9R29DakTo0Ade2Wv+jwD2zhUGhsKYxmcy0SNVT2/niaqKftdnHTmAcdDXpCM22xD
 B7WKPi40kHMnQuodNIUA7wxOcO+XIXC+UsWXSfqaDasrLN6UU7cedaVm/lGUuOrGZ9skNrx5/Bb
 tkxkFIxwWDNhi+B+EDEk6X0eeUgI//vgMdmaGQusARW5Z+9O9WhcyMfnITPtNFoE7m3MCWAAyTs
 rTa4CGd7N7XaMyHR5tq6qQysrTKmqoYYWjpRpFAYQYCaExOfB/8ZXQw8cFiP/QkLK/jGfHbMISO
 wG1zBGqHvx7+hr482kEpvsmiOwcumtd1Rb2RmP6RfNRW1U1OavnodKE3bzq+a+yLrkrbCkNqTYA
 KdKA3JSmJwd09ybMyZ6/Y4oHmPHw1CujQyhJdbbLzfjPEC20+w/i43
X-Received: by 2002:a17:90b:268f:b0:3a4:6e84:e7f6 with SMTP id
 98e67ed59e1d1-3ab3a32cbadmr9009247a91.5.1791847153679; 
 Mon, 12 Oct 2026 16:19:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ab3780a473sm6630187a91.4.2026.10.12.16.19.13
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2026 16:19:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53390e79a19so41860611cf.0
 for <dev@dpdk.org>; Mon, 12 Oct 2026 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791847152; x=1792451952; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kL+VlcHIzyG+0BpE+RaXryEjLqYt1kPq1tGomLDIWZo=;
 b=fxCf9vSuRinsPmoqDyVYhOpF8BJM0IcJs64X6c0Qqyvd3gh8010cZijCAPeR6OGnRv
 n0PR3zllJToToexqNQIYwVJ1PbpMNXMffxMUmXyUIT1BRO+IxOY5b5f4Vfhz3hEC7aWF
 9W2adFrzjGK7Ckov5xKyyO9bhmvV9wLTmZdWg=
X-Received: by 2002:a05:622a:598c:b0:535:922:ff3 with SMTP id
 d75a77b69052e-5359fb87d6fmr193527161cf.48.1791847152403; 
 Mon, 12 Oct 2026 16:19:12 -0700 (PDT)
X-Received: by 2002:a05:622a:598c:b0:535:922:ff3 with SMTP id
 d75a77b69052e-5359fb87d6fmr193526801cf.48.1791847151965; 
 Mon, 12 Oct 2026 16:19:11 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b97c4a7cesm10322176d6.48.2026.10.12.16.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 16:19:11 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: validate pool index in pool manager APIs
Date: Mon, 12 Oct 2026 17:22:55 -0600
Message-ID: <20261012232255.441896-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005202536.18083-1-manish.kurup@broadcom.com>
References: <20261005202536.18083-1-manish.kurup@broadcom.com>
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

Validate the pool index in the pool manager APIs so that it cannot go
out of bounds when setting or getting data from the table-scope pool
manager.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
 - Use %u for the new log messages instead of PRIu16, and drop the <inttypes.h> include that is no longer needed

 drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c b/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c
index 790b6c7e420..b143d045e15 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/tpm/cfa_tpm.c
@@ -119,6 +119,12 @@ int cfa_tpm_free(void *tpm, uint16_t pool_id)
 		return -EINVAL;
 	}
 
+	if (pool_id >= ctx->max_pools) {
+		CFA_LOG_ERR("pool_id (%u) out of range (max %u)\n",
+			    pool_id, ctx->max_pools);
+		return -EINVAL;
+	}
+
 	if (ctx->fid_tbl[pool_id] != CFA_INVALID_FID) {
 		CFA_LOG_ERR("A function (%d) is still using the pool (%d)\n",
 			    ctx->fid_tbl[pool_id], pool_id);
@@ -137,6 +143,12 @@ int cfa_tpm_fid_add(void *tpm, uint16_t pool_id, uint16_t fid)
 		return -EINVAL;
 	}
 
+	if (pool_id >= ctx->max_pools) {
+		CFA_LOG_ERR("pool_id (%u) out of range (max %u)\n",
+			    pool_id, ctx->max_pools);
+		return -EINVAL;
+	}
+
 	if (!ba_inuse(ctx->pool_ba, pool_id)) {
 		CFA_LOG_ERR("Pool id (%d) was not allocated\n", pool_id);
 		return -EINVAL;
@@ -163,6 +175,12 @@ int cfa_tpm_fid_rem(void *tpm, uint16_t pool_id, uint16_t fid)
 		return -EINVAL;
 	}
 
+	if (pool_id >= ctx->max_pools) {
+		CFA_LOG_ERR("pool_id (%u) out of range (max %u)\n",
+			    pool_id, ctx->max_pools);
+		return -EINVAL;
+	}
+
 	if (!ba_inuse(ctx->pool_ba, pool_id)) {
 		CFA_LOG_ERR("Pool id (%d) was not allocated\n", pool_id);
 		return -EINVAL;
-- 
2.47.3

