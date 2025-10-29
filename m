Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672D7CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FDD440693;
	Wed, 29 Oct 2025 17:08:48 +0100 (CET)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 3B74840659
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:44 +0100 (CET)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b6ce806af3eso6860286a12.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754123; x=1762358923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7NAPWS51HWGuSNmuo3l+1+zDhh/tXlPyRTxMFheaAUA=;
 b=Wz3JP6MLMnHQu1VX0vgeP/DDqtW9f39DBg2WXdKLyZARjp4WZon8Xv+qU27l6DaeSF
 p6NfnWFUZgv9zRm3qt1JhfSTqOmKT7KjrV2chuNHgxulu3hux0nRag1BECE1PuTY4VIf
 typNtL3oekN5Wd3Q6pXTJxd6f2QUBwp4YSgcdnkTNcPOSjz6QAlbU9MdPwCTubMbqAwN
 1EvxuIf0FavVkggzbqHJ2CUPADkwfrzIQWCH1eBYIAd7Xa8mceELi0K029MWNkLfaZrn
 JOyMRooymsHW3kMVhKQApZRYtQ9bS50JVOw87xkz1iqXGCDN8zNHEy9T5QTaQFMIMo88
 gRiQ==
X-Gm-Message-State: AOJu0YwmEE1COlQyXKn8qU27vVweZkHQG/dSYHTD+oBv7op64Yk+QErD
 8VFcdJoBAcmg+FHrlHTcm/2OzQuUYE6Slv8bPUnxd7FNki9UCUPyqTkLv3v5KqZAzLQhGLt7CDi
 6HBQEGRU1COs8GZyYfLojVXxHaIGFcJ8dL+PMR4k1jYIC0kIgzZqVxDxjjQazjwUnFvxna4F+Lu
 KoWbaBmOxS9nFBKxo78Q8ASKrpOeDkdxGp+GkR9fuAF4YCdr9+i8yHeC4+qk7jTZj+yRbbpQ==
X-Gm-Gg: ASbGncvQ65h8okyQKr/8a0nhHf8GJLI/Mr8T1H6XtK248icEgb+uoqCVUeFYzlyzr3F
 Y4/QUv1y82BcDVaeqo2c8kEkip9x9eOfds+rwATYojELU92nw9450of899LQ4HNzgibIPyK0wG9
 ICGUiq6SCHzEidVcDfUJpNW95C69hgWPElI+zPsZBhawhv0wReKHzs4FlduwddsinnxNrMkFG2Q
 peTZd4wXy/UfPv7baEDx99uknxYw9S8DiHADjS5SLwX0jVNurNJ3ZHfmwiS6ddH3Z2cpN3x8s1G
 fsG5aMCWwx8BRjM2biFKV9xrc0cCuOZKVStYEtgZCRyCXBJZOOlITxo9/CX/eSwG6kqqpxjcnks
 1xFsFxPLfW4ngnQ4hoLPo+Q6fi6+5ocwsRFRISiU3oGnndy8rPCQ2SecLX9KFQFi6aJr+NbkH6g
 8js1bJLgVjM5U5PqZYN5wyTFqq7QU7UUU2lhH6
X-Google-Smtp-Source: AGHT+IFFGZ9plA6XJCKNZrnMHBa+I2joANDUL61g3v3v2qPUzrYiJ3MqKaOA6L9wtZosMzUyAERm3+74N02c
X-Received: by 2002:a17:903:2f92:b0:292:39b4:e785 with SMTP id
 d9443c01a7336-294dee537c0mr45135415ad.26.1761754123169; 
 Wed, 29 Oct 2025 09:08:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498d409easm13626695ad.41.2025.10.29.09.08.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a27ed89773so1143627885a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754121; x=1762358921; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NAPWS51HWGuSNmuo3l+1+zDhh/tXlPyRTxMFheaAUA=;
 b=YRUYjEQnoaoX514Cnx9PT3ObjVa23SRIlD6pKFZBN+kGzb8CA0Ql1w6E8CoPtidR7u
 g4tieOqD9P64nJCWCsuomzWTxMD8C1vjn9y4tay3AMdIZF1xLm/AOtTL1dydFGuTyLgB
 zgEFbWJeoWlECk9DRwfAqFBvM0P4WLyR8OoTQ=
X-Received: by 2002:a05:620a:4412:b0:862:3e8d:e4ec with SMTP id
 af79cd13be357-8a8e6954aebmr472752285a.60.1761754121346; 
 Wed, 29 Oct 2025 09:08:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4412:b0:862:3e8d:e4ec with SMTP id
 af79cd13be357-8a8e6954aebmr472746885a.60.1761754120732; 
 Wed, 29 Oct 2025 09:08:40 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:40 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v5 13/57] net/bnxt/tf_core: table scope free cleanup
Date: Wed, 29 Oct 2025 12:06:28 -0400
Message-Id: <20251029160712.58519-14-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

Removed the additional call to free the table scope memory. Also
corrected the scope size check which should be power of 2.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 13 ++++---------
 drivers/net/bnxt/tf_core/v3/tfc_util.c      |  6 ++++++
 drivers/net/bnxt/tf_core/v3/tfc_util.h      |  3 +++
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index b01bf8d42a..60b8289805 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -926,8 +926,7 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
-	if (parms->max_pools != 1 && parms->max_pools !=
-	    (uint32_t)(1 << next_pow2(parms->max_pools))) {
+	if (is_pow2(parms->max_pools)) {
 		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
 			    __func__, parms->max_pools);
 		return -EINVAL;
@@ -1044,8 +1043,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		return -EINVAL;
 	}
 
-	if (parms->max_pools != 1 && parms->max_pools !=
-	    (1 << next_pow2(parms->max_pools))) {
+	if (is_pow2(parms->max_pools)) {
 		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
 			    __func__, parms->max_pools);
 		return -EINVAL;
@@ -1541,11 +1539,8 @@ int tfc_tbl_scope_fid_rem(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	/*
 	 * Check if any table has memory configured and, if so, free it.
 	 */
-	rc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid, CFA_DIR_RX, CFA_REGION_TYPE_LKUP,
-				&local, &mem_cfg);
-	/* If mem already freed, then local is set to zero (false). */
-	if (rc == 0 && local)
-		(void)tfc_tbl_scope_mem_free(tfcp, fid, tsid);
+	(void)tfo_ts_get_mem_cfg(tfcp->tfo, tsid, CFA_DIR_RX,
+				 CFA_REGION_TYPE_LKUP, &local, &mem_cfg);
 
 	rc = tfo_ts_set(tfcp->tfo, tsid, false, CFA_APP_TYPE_INVALID,
 			false, 0);
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.c b/drivers/net/bnxt/tf_core/v3/tfc_util.c
index d3229bd104..91ad3ad657 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.c
@@ -220,6 +220,12 @@ uint32_t prev_pow2(uint32_t x)
 	return x == 1 ? 0 : (BITS_IN_VAR(x) - 1 - __builtin_clz(x - 1));
 }
 
+/* returns 0 if power of 2 */
+int32_t is_pow2(uint32_t x)
+{
+	return (x != 0 && ((x - 1) & x)) ? -1 : 0;
+}
+
 uint32_t roundup32(uint32_t x, uint32_t y)
 {
 	return ((x + y - 1) / y) * y;
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_util.h b/drivers/net/bnxt/tf_core/v3/tfc_util.h
index 7d33947d1d..5114517792 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_util.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_util.h
@@ -110,6 +110,9 @@ uint32_t tfc_getbits(uint32_t *data, int offset, int blen);
  */
 uint32_t next_pow2(uint32_t x);
 
+/* returns 0 if power of 2 */
+int32_t is_pow2(uint32_t x);
+
 /*
  * Calculate the largest power of 2 that is less than x.  The return value is
  * the exponent of 2.
-- 
2.39.5 (Apple Git-154)

