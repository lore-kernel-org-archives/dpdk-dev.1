Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5647ACA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1030940615;
	Mon,  5 Oct 2026 22:25:20 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id ED24C402C4
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:17 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc7cc8aafe6so46118a12.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231916; x=1791836716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LHJaN3hn16OIKXPLRJ4KduLyPXsPURAs3AbfLVlJ3wU=;
 b=ZckVQjn9Q2X7KGDxRRZARU+wAF/eerGa7MfM+ATzhTOpa48KH35Gz4qrG7n8X/Kiqk
 Xud4sKGphxzpJptoquOUxY9xgXgkZdft2n00DpN18XX3ZfkBU9HysG4wK8il4kslNnJn
 qggLlkSRc1EUJHinzZXMYuT23H0zkhmsKk0Dj2N+suGZvWAoX+o8HskuYPBRcg8zQv25
 dJNYNKrTsVsx9f+d3WwSDd/+YqeGfH+40I/W4oOnJ60vJMkrEbXOzcKlqITnusv6RIED
 QZzudVLRl7eVBZjKSqnMOIhHmeS+vrxzj7MEqJLpRwVHzU0GAwGCVtpCT1kOTR9lh8/o
 6JqQ==
X-Gm-Message-State: AFuF++me98bc/nfRgzoWJbFF3NHYX5MwIIQ2zw6vFC6CT1y78iQoO93m
 N8pRQ0Qt9XLqvmPPKo/78/b4H+YvJ3N4TQMVICW2NIXTD5VOmL9h2PAQBu66tRu1HqW3fiy8bc4
 7tV/HbxnwS6keHX/8S8WYmZPrcPoK+ap+OX/DCWtCi/kBzERN/DNr1fWaZmI0Bh0vOpXV9mnxB5
 tCyB2QbcPDLKciPS/Ic5tlfGAHAdT2Cd4IeihQnqsD5iY4q61hwMKleqbnN2yWxw0CsfWbQw==
X-Gm-Gg: AYBFou1Xz5Ko/cBxrlzben2Ui67YNEs5j9V9YFd+x7BZFfO4r8zeQo5G0bKmwfl+aDg
 5hCyp2JrcE0wE4uWxFc3rFy1Ib6Nqjp2khYv2gfpApNxZtWaE3PLx0HS/NL8ue3mpk8ofIlkk+Q
 cgoRIEyCfwItN83Io1VxgO/bSxfWClv+t3xcdDgn+ZEofnF6uLgW+QMIOTbaHpq5MxEXxPicGvS
 tn6wdjWoipWFhq4VefvPfu9JjR4QrSmtsm892S48O5Ae8khbr4FxQ781SUMqRhw8DxCWl+vK9bG
 OBKA2bNAJsM9aQXJfJwF9Kgx1Vo5k5pBmWYvBb+MtpUKYpIwXaR/XS5HJdTfKOGO+YgO+vRXl+W
 Z6Wzx/7ZZxJ4KVu0WPNf4i+RFufMnTceQ+ay35jWiY0f3KHOgJy4TFpA2yfMuY0uENZLGdNzoo6
 OJY92dSWsbQ9xCcw9NyOowtYZS+ojV60wOqZ257g==
X-Received: by 2002:a05:6a21:9786:b0:3e0:a809:76cc with SMTP id
 adf61e73a8af0-3e0bd145987mr10529777637.70.1791231915580; 
 Mon, 05 Oct 2026 13:25:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-ccb754fbaaesm1691047a12.13.2026.10.05.13.25.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9123be39eeaso52891636d6.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231913; x=1791836713; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LHJaN3hn16OIKXPLRJ4KduLyPXsPURAs3AbfLVlJ3wU=;
 b=T4TsTI1j+F7SD48ff6oeCr23fvjmN9Xy9EEIZ2bYUxtPM4yZ9E4XtI0K6UxKQsUUaf
 4JfQaTO8PGzhSpAd+U/3s9EsruqH5hDZ5WaSU41W8kLoV7Y89a3UfTkIGvsvQ2RlFdTa
 WREBLoCUt1IGrPoa9RrGbZK3ZmW2S7QM1vwFI=
X-Received: by 2002:a05:6214:19c2:b0:919:85a3:313e with SMTP id
 6a1803df08f44-91985a33f91mr15241846d6.17.1791231912963; 
 Mon, 05 Oct 2026 13:25:12 -0700 (PDT)
X-Received: by 2002:a05:6214:19c2:b0:919:85a3:313e with SMTP id
 6a1803df08f44-91985a33f91mr15241116d6.17.1791231912199; 
 Mon, 05 Oct 2026 13:25:12 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0c17b8esm94104046d6.43.2026.10.05.13.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:11 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: add response bounds checks for TruFlow messages
Date: Mon,  5 Oct 2026 15:25:07 -0500
Message-Id: <20261005202507.17770-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Farah Smith <farah.smith@broadcom.com>

Add explicit input validation against fixed response data buffer
sizes in TruFlow message getters. This prevents potential stack
over-reads if a caller passes a requested size exceeding the local
response buffer size.

Add the same guard to tf_msg_get_tbl_entry(), tf_msg_get_global_cfg(),
and tf_msg_get_if_tbl_entry() - each copies firmware response data
into a caller buffer using a caller-supplied size without first
checking that size against the local, fixed-size response buffer.
Also use the caller's own size value directly for the final memcpy
in tf_msg_get_global_cfg() and tf_msg_get_if_tbl_entry() instead of
a re-derived field, avoiding any possible mismatch between the two.

Fixes: e2a002d88c44 ("net/bnxt: update RM to support HCAPI only")
Fixes: a11f87d3b2ca ("net/bnxt: add global config set and get functions")
Fixes: 37ff91c158a3 ("net/bnxt: add SRAM manager model")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/tf_msg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index 645a4b1e66..aab8d05d81 100644
--- a/drivers/net/bnxt/tf_core/tf_msg.c
+++ b/drivers/net/bnxt/tf_core/tf_msg.c
@@ -1406,6 +1406,9 @@ tf_msg_get_tbl_entry(struct tf *tfp,
 	struct tf_session *tfs;
 	uint32_t flags = 0;
 
+	if (size > sizeof(resp.data))
+		return -EINVAL;
+
 	/* Retrieve the session information */
 	rc = tf_session_get_session_internal(tfp, &tfs);
 	if (rc) {
@@ -1493,6 +1496,9 @@ tf_msg_get_global_cfg(struct tf *tfp,
 	struct tf_dev_info *dev;
 	struct tf_session *tfs;
 
+	if (params->config_sz_in_bytes > sizeof(resp.data))
+		return -EINVAL;
+
 	/* Retrieve the session information */
 	rc = tf_session_get_session_internal(tfp, &tfs);
 	if (rc) {
@@ -1552,7 +1558,7 @@ tf_msg_get_global_cfg(struct tf *tfp,
 	if (params->config)
 		tfp_memcpy(params->config,
 			   resp.data,
-			   resp_size);
+			   params->config_sz_in_bytes);
 	else
 		return -EFAULT;
 
@@ -1746,6 +1752,9 @@ tf_msg_get_if_tbl_entry(struct tf *tfp,
 	struct tf_dev_info *dev;
 	struct tf_session *tfs;
 
+	if (params->data_sz_in_bytes > sizeof(resp.data))
+		return -EINVAL;
+
 	/* Retrieve the session information */
 	rc = tf_session_get_session(tfp, &tfs);
 	if (rc) {
@@ -1790,7 +1799,7 @@ tf_msg_get_if_tbl_entry(struct tf *tfp,
 	if (rc != 0)
 		return rc;
 
-	tfp_memcpy(&params->data[0], resp.data, req.size);
+	tfp_memcpy(&params->data[0], resp.data, params->data_sz_in_bytes);
 
 	return 0;
 }
-- 
2.31.1

