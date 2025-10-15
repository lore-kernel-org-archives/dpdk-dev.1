Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B783CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 878CE40BA0;
	Wed, 15 Oct 2025 11:01:34 +0200 (CEST)
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com
 [209.85.166.227])
 by mails.dpdk.org (Postfix) with ESMTP id AB7DE409FA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:33 +0200 (CEST)
Received: by mail-il1-f227.google.com with SMTP id
 e9e14a558f8ab-42f95010871so24023525ab.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518893; x=1761123693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=wXKXOFbV/UHGBDsE9LmT1ZdmYUpyVpUQNlxAhdrMs/rE9kTFaPbDJboG4ZPSu595m0
 pJYgKlGcvewqMVa/833s4EI6oH2VWQPq7yIW0hb11MY9/eyvDwZ20SCvhst5iSldZrji
 nR5cpGu6hRf4vnUcm/pLW0LmSP0cHTyz6H20mtUIm8KPUqkqR61ePOICcs7D/ZvnpvA6
 d1kxPd+FBqR485Qydl5bsrdLrZ/y07yRhpxseQvzyEaLykH66ymAuofpkWjiZqzWylfg
 toj7X5GN59QM7yBdOfaC1kjN6pIhHPsAYgPooFcxlF6Yixk8BJwK596kE9gX9yE7KX6j
 2pRQ==
X-Gm-Message-State: AOJu0Yy7BHwqYtB2QBCqzTj9r0YMSNDClixGIhSslDNZJN5eQaeMweyM
 xJY+w891hI0jVNCZs7HtR8+4j7GbNL7JpW7quFdon8XC9Qysh4i8jpHBhgVg6Cte/wuWdU/zOZw
 G37WDgyqlPXmMGkSlVIwPYGUuALkvTz5aw1kjTdc02ZJfxz8mXsI3N3sEo5iHnfb0a8aLKTEbz4
 iJx3+mdGcpSld4WI28/GUULobzFOJ8hMKK9cR0sdEBHahU8CwIT7WpY0LwvaDqC9vb4Uu9pQ==
X-Gm-Gg: ASbGncs2Vc7pSdxacnjInYWf6Y2QivaHWafCSuf2OrLHambXtlIBWhBYZJbXGJbdG1P
 g4xmf9/ACyvicopPK5RmxbaFRcF37CzLurbtsu+9c41CrRD01wijJavmtfti3AY/3qLsk/ZHDm5
 Ucway/kWA71pHCBeM+kmYLyW6imEhAXn7kRVy3tZCo34QvVRBnyE5IdlziCPbGbeDqjoPHPCBtS
 l57pPhF3YxzsDXcZVQh19p2yqafQoCS3jrg4s2msE+esFLiGzaclAXH5ooXKcDD7Dwb16yAjfLI
 KH7cU4Km+vAPMziJ1yef/V/inyG6p+Dwd0TqhEW/pko9EHZCgGaeQx0DLc0rmi7FNguBq/WruNQ
 qqAN5O1xl0PL7dx8Mt/rgiDpbc9gGFtCK4gJ0VeWXNVGq7RYsl+/nxQSpL4anWe3BZCndjkVcye
 I=
X-Google-Smtp-Source: AGHT+IG4Pb36YiVJBboNMq33iVeq6Lyko7p1KCwR1PtcsKUDLHDoeqTlRay1aIeADhOBrWnMH+LWUVmD6vJE
X-Received: by 2002:a05:6e02:1646:b0:42d:7dea:1e04 with SMTP id
 e9e14a558f8ab-42f873fb8efmr280633255ab.25.1760518892925; 
 Wed, 15 Oct 2025 02:01:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f71e1f909sm1260370173.42.2025.10.15.02.01.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7900f597d08so8780229b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518890; x=1761123690; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLcMuE229SguVXhaiCprOxk0FY+Emi5s4rMOuCgVCJ0=;
 b=DFvChgwnjf/4FFza0PLNXlSrA65WLGsgDlTyJmEM54dnfHUhCU51nl4iGrEPKzDry5
 UQ9oGsMDnMzQmmoyQ41Jo2QK1e4EFoEKveM1wjJBsLpAx28q+0VBwm5UlGx13XNn+466
 /64h8VX99T/fl2tg1ceZirZv/OsBNN5THbBjo=
X-Received: by 2002:a05:6a00:23d5:b0:781:1f5e:8bc5 with SMTP id
 d2e1a72fcca58-79387829439mr36602436b3a.18.1760518890010; 
 Wed, 15 Oct 2025 02:01:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:23d5:b0:781:1f5e:8bc5 with SMTP id
 d2e1a72fcca58-79387829439mr36602379b3a.18.1760518889301; 
 Wed, 15 Oct 2025 02:01:29 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:28 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v3 10/54] net/bnxt/tf_core: fix table scope free
Date: Wed, 15 Oct 2025 04:59:40 -0400
Message-Id: <20251015090024.32250-11-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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
fixed the scope size check which should be power of 2.

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

