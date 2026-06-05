Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDBBCD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 22:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D364E40668;
	Sat,  6 Jun 2026 00:45:23 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 0E792402DD
 for <dev@dpdk.org>; Sat,  6 Jun 2026 00:45:21 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3075ce9c05aso4203611eec.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780699520;
 x=1781304320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afhshM6iaCv7oYTNmPZ6o13ZeDwTxflG+VxU4LV51NM=;
 b=KeyLKQRRT+DjGmQm0aK5TIe2/MFuO4ovN6bg2bBg67wyjffI8JXqlkJqZOtca2UUjG
 /TRsugE4xSyMhh9LAP1Kk8EBtOak9qVSx1oPW1s8kd46l1KDhO1V7lOoHgqCIgfyWESa
 dJRe4q+BATDvIyoj6fPLk2rN4dUaV8ssCusfTLF75LvI7XWfzw1H+w4mOvsKbh4SOTkh
 lViorehgwzcRIkB34YSR6VzHVSfEbFpmjJRKXekTrkU2+yfs82v2MxsSeRxB6sDPxTNl
 Bxw4GNVveVzrjVt6vzPz55fUDsoEWfE8mN2Hdg0wrm7K7Qi3f0YL1tW8Osl3pMtHvn/T
 mk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780699520; x=1781304320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=afhshM6iaCv7oYTNmPZ6o13ZeDwTxflG+VxU4LV51NM=;
 b=kYQL1Vrh/dJsI/8zV/CE9s/EJXFYG2dvCJBw4bunhqgxzKTxTGy4yZTGR/EmqXT0wY
 TNHcgevN6+xNbX2zi7WLTqluEvnrvG/hmwa4zIBwt9xG01ekvyB8PhIVlp3y3n0V6S/y
 AqDSZjuT6DHdbz4rUl68nuPCldqEcgjjryspRWh+1YjGMz6pB1ptYW+pg3SDW6qpQkqa
 MEtwGCN/Ui5HpHzDalwCVwjMc+ZdxH4hor3sXzwwOeRKp0ZCc/5Fxsb5BW3VclJRZ3Kv
 AovQyyjjCO9yx3xZHchErQocCUEUBGkWPd07E/nclG/xQCTcSsfoEBr3LBweCRepxq79
 qXAQ==
X-Gm-Message-State: AOJu0YzyGIMgw1pYxiXlycL/yTb86Z0uDgmbIXzCQSL1DskizM3YXHAy
 gKxv7w0+AHJk2uyaVeRNr9+yw9gMOtDTE8CNKy6JK+pTZ6KkEymV/y+rAWcmi8/96GdX8ArFgNr
 PLWsQ
X-Gm-Gg: Acq92OHrQt+w9lmgQgjrvfOudR1WZpElFFwpmczZ5CofNPnnwoQbHeD/lKYo1JPkPbj
 abAbqE47jw5UPY/+N5vevThuWpe1No1XppZjsrxbIN8NG2TcG/abpW+PwylVnzAIJO0lBJOJ/fm
 /gggAJ2YVOrH5q5zFMpiz8KAhm+uMhbRG3W+wRrJOAZIQ5ofNg3nksPqpBCWajKqjsWtXPlVIvs
 arwro7NS9jhOdbL7F77/2J+8fDANvfJUA3IYSKj56pIBj1ET4ugLup608aSuekq3gE7Y0tMiykE
 rJf6zvl6oKG+TWZmO+XGHrRMOkisOAUo4v+L1uZmuINFfdNJc4Cpz9gEcGuM8I2p4euVPcNByUL
 5GvLigZYJubokJqxMXJ67b4+eyuZV5FRxULs2N/GYL+L75uWuq63hdcUzI0fRKeL5OzzU8gN0RE
 jUq8AnrB94+VGov3yKDT12MYgBWR/ahOP3gj1+8TdtqCfZ8QzD7MpfhiXVK54Q1UQqsssCHR04
X-Received: by 2002:a05:7300:d4ce:b0:307:3a6c:e708 with SMTP id
 5a478bee46e88-3077aeed393mr3009351eec.5.1780699520093; 
 Fri, 05 Jun 2026 15:45:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df8076csm9681306eec.29.2026.06.05.15.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 15:45:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 2/2] common/cnxk: fix thread-unsafe NIX telemetry parsing
Date: Fri,  5 Jun 2026 15:44:40 -0700
Message-ID: <20260605224514.651081-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605224514.651081-1-stephen@networkplumber.org>
References: <20260605224514.651081-1-stephen@networkplumber.org>
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

cnxk_nix_tel_handle_info_x() backs the /cnxk/nix/{rq,cq,sq}/{info,ctx}
telemetry commands and parsed its "<pcidev>,<queue_id>" parameter with
strtok(), which keeps non-reentrant state and races when telemetry
callbacks run on per-connection threads.

Split the parameter with strchr() and parse the queue id with strtoul().
While here, copy the full parameter (the length was capped at
PCI_PRI_STR_SIZE + 1, truncating the id for longer device addresses) and
reject non-numeric or out-of-range ids instead of letting strtol() alias
them to queue 0.

Fixes: af75aac78978 ("common/cnxk: support telemetry for NIX")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/cnxk_telemetry_nix.c | 80 +++++++++---------------
 1 file changed, 30 insertions(+), 50 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_telemetry_nix.c b/drivers/common/cnxk/cnxk_telemetry_nix.c
index abeefafe1e..82a146c139 100644
--- a/drivers/common/cnxk/cnxk_telemetry_nix.c
+++ b/drivers/common/cnxk/cnxk_telemetry_nix.c
@@ -1015,76 +1015,56 @@ cnxk_nix_tel_handle_info_x(const char *cmd, const char *params,
 			   struct plt_tel_data *d)
 {
 	struct nix_tel_node *node;
-	char *name, *param;
 	char buf[1024];
+	char *comma, *end;
+	unsigned long qid;
 	int rc = -1;
 
-	if (params == NULL || strlen(params) == 0 || !isdigit(*params))
-		goto exit;
+	if (params == NULL || !isdigit((unsigned char)params[0]))
+		return -1;
 
-	plt_strlcpy(buf, params, PCI_PRI_STR_SIZE + 1);
-	name = strtok(buf, ",");
-	if (name == NULL)
-		goto exit;
+	plt_strlcpy(buf, params, sizeof(buf));	/* was PCI_PRI_STR_SIZE + 1 */
 
-	param = strtok(NULL, "\0");
+	/* params is "<pcidev_name>,<queue_id>" */
+	comma = strchr(buf, ',');
+	if (comma == NULL || !isdigit((unsigned char)comma[1]))
+		return -1;
+	*comma = '\0';
 
-	node = nix_tel_node_get_by_pcidev_name(name);
-	if (!node)
-		goto exit;
+	errno = 0;
+	qid = strtoul(comma + 1, &end, 10);
+	if (errno != 0 || (*end != '\0' && *end != ','))
+		return -1;
+
+	node = nix_tel_node_get_by_pcidev_name(buf);
+	if (node == NULL)
+		return -1;
 
 	plt_tel_data_start_dict(d);
 
 	if (strstr(cmd, "rq")) {
-		char *tok = strtok(param, ",");
-		int rq;
-
-		if (!tok)
-			goto exit;
-
-		rq = strtol(tok, NULL, 10);
-		if ((node->n_rq <= rq) || (rq < 0))
-			goto exit;
-
+		if (qid >= node->n_rq)
+			return -1;
 		if (strstr(cmd, "ctx"))
-			rc = cnxk_tel_nix_rq_ctx(node->nix, rq, d);
+			rc = cnxk_tel_nix_rq_ctx(node->nix, qid, d);
 		else
-			rc = cnxk_tel_nix_rq(node->rqs[rq], d);
-
+			rc = cnxk_tel_nix_rq(node->rqs[qid], d);
 	} else if (strstr(cmd, "cq")) {
-		char *tok = strtok(param, ",");
-		int cq;
-
-		if (!tok)
-			goto exit;
-
-		cq = strtol(tok, NULL, 10);
-		if ((node->n_cq <= cq) || (cq < 0))
-			goto exit;
-
+		if (qid >= node->n_cq)
+			return -1;
 		if (strstr(cmd, "ctx"))
-			rc = cnxk_tel_nix_cq_ctx(node->nix, cq, d);
+			rc = cnxk_tel_nix_cq_ctx(node->nix, qid, d);
 		else
-			rc = cnxk_tel_nix_cq(node->cqs[cq], d);
-
+			rc = cnxk_tel_nix_cq(node->cqs[qid], d);
 	} else if (strstr(cmd, "sq")) {
-		char *tok = strtok(param, ",");
-		int sq;
-
-		if (!tok)
-			goto exit;
-
-		sq = strtol(tok, NULL, 10);
-		if ((node->n_sq <= sq) || (sq < 0))
-			goto exit;
-
+		if (qid >= node->n_sq)
+			return -1;
 		if (strstr(cmd, "ctx"))
-			rc = cnxk_tel_nix_sq_ctx(node->nix, sq, d);
+			rc = cnxk_tel_nix_sq_ctx(node->nix, qid, d);
 		else
-			rc = cnxk_tel_nix_sq(node->sqs[sq], d);
+			rc = cnxk_tel_nix_sq(node->sqs[qid], d);
 	}
 
-exit:
 	return rc;
 }
 
-- 
2.53.0

