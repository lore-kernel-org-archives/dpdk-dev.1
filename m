Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3F8CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8343B40A6F;
	Mon,  5 Oct 2026 17:17:04 +0200 (CEST)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by mails.dpdk.org (Postfix) with ESMTP id EAFF640A84
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:02 +0200 (CEST)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-93e538a9703so105816785a.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213421; x=1791818221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zSkMpKRfZtOfeyd1BkeOqOnwh02cMV6Mrt7cFfn7RAY=;
 b=RYAmvFWUUwnusmMs/wO89RA29iEluaxhxj35GfPyHzAYCpogJ23jUcXNAAopcBo+99
 nmrsJMYxz038OyedpGnLqmGMxQmSc8v3Yl0yA7/IB2wWxvf3i3bDpw7CbNEjNnMa7aC6
 rRaSVWhrMc8Xn9lT9Cbfm9hojwZ3QNXAPaYz75ysuY+6Lm0yqfiFEG0QRMu1WuFysxK6
 WaKXKIFvna9xAhlC1YuU0C0r90txeenwTIaiTe9+vu/5P2tUu4f5ytTYwbuGLOrS2GfY
 Ih0mJrKODKQgLj9ui8As6MbO0osMkfPMzXWLOuQgUF3/6jOwa0yeMiC0TUckIhV/X2S0
 Koqg==
X-Gm-Message-State: AFuF++nPEk+08Im6wxWmS/2OIbCErjMpedw99eyqMDxE7DsLp2MzfUwc
 yqw2W0fh3E/wU7A/9sPpUjvenFf7C/rTkvnaUFuV/aWQkqZvK8odz4io+Q9uSsunQLTqexcMUxF
 WvjA1TBk0e89Y7ZFmbJOUPqKXUUCb+XFuqNQ+kGAJgRUXBCzp5swbLFEKGc6irSmlh6OpnKevIx
 667pD7Xo9UmjLR93z40KRVIQ/nCdfF95nur8V7Ynuew7jHa1i/PqOWr14mQlaaosjC6gpKnA==
X-Gm-Gg: AYBFou2Ym5VOvHekpo/aNVSePU29EWVWEVSB3rWpr57RX8AjlXYpnPvkbBaMqeyNrCo
 9uJuX7ZRt9uyNMsv1U6zjk1aEdPCL3pS1Q4HLWJL4qYwP21LJscr6VJr8kvfYAFeJzjVhKKO/rP
 PgPmbTZRGMLEL1UtDaheJ3pJS/fCTnq++3h1RFwW01jODjxxsBqBtw9nACun19vAj2Pr+nL2yUp
 GSzf7W12j3ABMJzj7Am3YGPi15k39Z6WKlQyDTnz2NqzhjA+pwu5ayZaCglSWJyCTfQciGaFD1T
 QYvdyMqdJ5AIeQgpTNshmKMXKUjlLqqYsPGraE5pRxEDgt9GPVEM51sHj6jEqL7FmXKgN2kfnrU
 FOE9RfrxYoNO4ZDSiT2YWhsoUKcq0vQxEdLSbc8mRd6vz8XTT6Wsgo2P2jsmP7cXQP6GAOmO0zz
 qQsoBhIvW8JNcz4kL4DesZ7loCxIXTiBO5U7dDMw==
X-Received: by 2002:a05:620a:1a16:b0:93a:51:2310 with SMTP id
 af79cd13be357-93ce7a8564dmr1911059685a.1.1791213421193; 
 Mon, 05 Oct 2026 08:17:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93cca2d9c1dsm420080185a.8.2026.10.05.08.17.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so294213685a.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213420; x=1791818220; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zSkMpKRfZtOfeyd1BkeOqOnwh02cMV6Mrt7cFfn7RAY=;
 b=QQMA5O5jlPVcB6a3IT91Q4BRWTOldK2AoqzE782yYdcJz4O4nGIksxlME7X6+3Sosz
 IRdA8rmI5f2yXy/p033ZMNG3onEXxoI7Ozcm1zxqNgEgHdKCLK0KYIXyk6XhLPwToScz
 rZew7sS4KMpY+ytbXHc09XRSl7Dn1/LS64mT8=
X-Received: by 2002:a05:620a:3188:b0:93b:d7a4:9d4d with SMTP id
 af79cd13be357-93cf19edb9bmr1977819785a.32.1791213419684; 
 Mon, 05 Oct 2026 08:16:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:93b:d7a4:9d4d with SMTP id
 af79cd13be357-93cf19edb9bmr1977813385a.32.1791213418971; 
 Mon, 05 Oct 2026 08:16:58 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca1a7b37sm895304985a.9.2026.10.05.08.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:16:58 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 stable@dpdk.org, Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH] net/bnxt: fix out-of-bounds read in TCAM get
Date: Mon,  5 Oct 2026 10:16:55 -0500
Message-Id: <20261005151655.1705915-1-manish.kurup@broadcom.com>
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

A missing return after a buffer size check allowed execution to fall
through into memcpy calls using firmware-controlled lengths, causing
an out-of-bounds read from the response buffer and potential overflow
of the caller's key, mask, and remap buffers.

Fix by returning immediately on error before any data is copied out.

Also validate that firmware-reported sizes are consistent with the
fixed-size response data array before copying, and ensure firmware
response sizes are converted to host byte order before use. Cast
result_size to size_t in the new bounds check to match key_size and
avoid a -Wsign-compare warning against the size_t from sizeof().

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_msg.c | 28 ++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index cf72d09184..df11910dc3 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -1154,18 +1154,28 @@ tfc_msg_tcam_get(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_TCAM_GET,
 					 &req, sizeof(req), &resp, sizeof(resp));
 
-	if (rc ||
-	    *key_size < rte_le_to_cpu_16(resp.key_size) ||
+	if (rc)
+		return rc;
+
+	if ((size_t)rte_le_to_cpu_16(resp.key_size) * 2 +
+	    (size_t)rte_le_to_cpu_16(resp.result_size) > sizeof(resp.dev_data)) {
+		rc = -EINVAL;
+		PMD_DRV_LOG_LINE(ERR, "%s: FW sizes exceed TCAM bounds, rc:%d",
+				 __func__, rc);
+		return rc;
+	}
+	if (*key_size < rte_le_to_cpu_16(resp.key_size) ||
 	    *remap_size < rte_le_to_cpu_16(resp.result_size)) {
-		PMD_DRV_LOG_LINE(ERR, "Key buffer is too small, rc:%s",
-				 strerror(EINVAL));
 		rc = -EINVAL;
+		PMD_DRV_LOG_LINE(ERR, "%s: Caller buffer too small, rc:%d",
+				 __func__, rc);
+		return rc;
 	}
-	*key_size = resp.key_size;
-	*remap_size = resp.result_size;
-	memcpy(key, &resp.dev_data[0], resp.key_size);
-	memcpy(mask, &resp.dev_data[resp.key_size], resp.key_size);
-	memcpy(remap, &resp.dev_data[resp.key_size * 2], resp.result_size);
+	*key_size = rte_le_to_cpu_16(resp.key_size);
+	*remap_size = rte_le_to_cpu_16(resp.result_size);
+	memcpy(key, &resp.dev_data[0], *key_size);
+	memcpy(mask, &resp.dev_data[*key_size], *key_size);
+	memcpy(remap, &resp.dev_data[*key_size * 2], *remap_size);
 
 	return rc;
 }
-- 
2.31.1

