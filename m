Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26BCCC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A1C740374;
	Tue, 13 Oct 2026 19:15:57 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id 70AF540269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:15:55 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cc1cf287ef8so1740357a12.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911754; x=1792516554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+TrNfg5qtgmqkA4X1nD5OMjC2bne+8T5dP6j1yyMivQ=;
 b=qvc1VdYdLnB30xiCbGRXMudxeOLvSEPzATpw1U1eQzQTjX5sA+KFBH9OlUl6Oa5mY/
 qKccsdA5+5azgoOtfy9gDDo3bDwNd8b9s0mABnMHp4otT3BVMmlUCgnLEuFCW9Z3l04g
 CU8744T4MrbTAYwFUhaLteinGzrJoleKwNYd4psS8M3omZB1t/1BozEJbO6oR5n5UaX/
 T+jvEj6bUsvrb6iRseF2gzgcxnOYiHXtCHb/jEoErLYHIBL8jFr9Ia56NPfOoWt2ssrV
 yoowQMB06WJG9kgaqMCZN+Ft7d7Fz7fW3be2H1NSm6QSUTRV1aFOhk39s8uVXjmsQsmb
 E19w==
X-Gm-Message-State: AFq9FYJA/i9f1QI42Uuv8EHIJ6ikaESoVShoYgit1j5+oOxgpX1J/9S6
 hdxDYdnYClt30hnerffH0uN96whyw296HVX3EE7IgjaRfhXkz5hSDwUDAn+HSPRM85Rhz1CDKL5
 tU5h31LCVyFEncw7fMPPStLJM3TmrHlqy6cFKessLvB8R/O9+VUg5YeWAmSguxHoteUFHkkNM1L
 0IjNDsSU/MMzNQ397Du6JnIDq0iF0FWN9sd6GNsWPg01Uysp1DGwg1nWzMPcqX31erU5A+zpKSu
 i/fXamvamV1
X-Gm-Gg: AYBFou1hR4FbAUiMizLl1chcY+DnervyUWJun4vjpDUNpTsnpnPr14sYUxe7TtcSqIt
 O78CEh6TGrxXrEZuC2zKeystkh0aGe29KCdzuGNfZPBcjsHsto+PK0DCQjAm0mCoPQIB9OFSV1k
 7xQVcOf2U2rks2KFns3MBS2+1KFzYb6Mfv81HFPhNzn+3LFNWlIZD+4qA7XzJdkmLdhXTG1JLzJ
 KHdXwOLCbbAQoyGYFcf5hjQ2bbv2Tv+LmOxCACfgLhtds+bevalQFzVDwVp7C41X+zgXqqYDzOJ
 lDk2wPsMaskTlRGIu7izGcrSk8qzpChQhvteGf8/huDUzIT1Xwp9ndTWhTzOydAb0jgEUEwKKq7
 D9naUzkBDVnLwbVMHaxC4W2CQXm3aMXxdYl1iBkcWcMasd8UtsOE4UdlMHWXbLzkU4Lwhb2tiTd
 HwV+hVaBRvAhZP16Ft+e5oegq/Ta16ZD7H06Ag/ibe4tmgi/hOhm0j
X-Received: by 2002:a17:90b:4d88:b0:3a4:a850:6982 with SMTP id
 98e67ed59e1d1-3ab3a7786e4mr11780450a91.26.1791911754087; 
 Tue, 13 Oct 2026 10:15:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ac601ac2acsm102583a91.5.2026.10.13.10.15.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:15:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e834ff4d0so891667185a.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911753; x=1792516553; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+TrNfg5qtgmqkA4X1nD5OMjC2bne+8T5dP6j1yyMivQ=;
 b=BJ+u6UkxgcZRtSi+mYi88lwVsnKstnPsyKoVvc36KzxK9h45Hp313QIeymuIqpXR1f
 CObiYezpBaGBnmT2o+QTg0WyLg97Uxxd/ekjhBSUwqkv1Ikv9Eyz3D1s0pbjKhl0oVVB
 lShRr1sTQV7o+Y3qmbnVqpNg8+VqlXq2gfuGk=
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id
 af79cd13be357-93ec12d0818mr1504192985a.79.1791911752837; 
 Tue, 13 Oct 2026 10:15:52 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d6:20b0:93e:c12c:fbc2 with SMTP id
 af79cd13be357-93ec12d0818mr1504185785a.79.1791911752098; 
 Tue, 13 Oct 2026 10:15:52 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef508c857sm280623085a.38.2026.10.13.10.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:15:51 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Farah Smith <farah.smith@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: add response bounds checks for TruFlow messages
Date: Tue, 13 Oct 2026 11:19:34 -0600
Message-ID: <20261013171934.452337-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005202507.17770-1-manish.kurup@broadcom.com>
References: <20261005202507.17770-1-manish.kurup@broadcom.com>
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

Fixes: dba3ca8b304f ("net/bnxt: support TruFlow core table scope")
Fixes: a11f87d3b2ca ("net/bnxt: add global config set and get functions")
Fixes: f3502f5cd281 ("net/bnxt: implement IF tables set and get")
Cc: stable@dpdk.org

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
 - Correct the Fixes tags: the previous ones did not introduce the code being fixed
 - No code change

 drivers/net/bnxt/tf_core/tf_msg.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index 645a4b1e669..aab8d05d817 100644
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
2.47.3

