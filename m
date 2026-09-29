Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A6ACA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1695842EF1;
	Tue, 29 Sep 2026 18:39:58 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 9435942EB9
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:46 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-87fd84c0bfeso1794805b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699926;
 x=1791304726; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8pg9kEP/PlSLwqZBqgULj4i9AdBbVQ8PpmHj052Vtpk=;
 b=fIanphodIeS0Mzz1RHNcezNEXXWLCCVJSH41k27pEv68v7cG8eb3IaV9dNWE2pcgp6
 Xrs7CNtrF/60B/BL0iZfp1756Obpvn6wArUIyzrhl9h5BRiHexPEE0pzsq3+QBcnO59H
 /NXqMjT8y/tXnkMNL5TDbXImaqLNtR2CeSrx9Fmx4zwIIA1ijOYzEgczf6xVqzK1A4vt
 +c9n65LMaIel+U9Cw9Gk3muNaQeJB22UzuYj44zn9Fb5uhhwBYNp7O2rxrXt2fm+NzAF
 oLy19yMFctV0PEgzjqO1holFUVoQIj40Jgx7X5vA3JA0SsemzFMacFQ1s0HcpBREF+gO
 nLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699926; x=1791304726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8pg9kEP/PlSLwqZBqgULj4i9AdBbVQ8PpmHj052Vtpk=;
 b=AApidsBeT2ziHAibFAUjrAntJt8LLlVvdYvChphyZiUAtmIDlzT6XpKRpawbSCBSLK
 yRW+jT/oYmttXpGyYJ7AhDryf5fWVntmviynGuuqnBhOuwpftGODsUIfPJLkni3knfUv
 SZQrfa/zJmoSYg4IASMtfPJhbhSS0IwmHHQHEfWLj9Lk4NfjfCJaNuFeDg52b0BvRO3S
 Foc2uD2tuns2D06T46ZEVfmzR1zMmy+m4zm94hHNZ1QG0lQ+7baNQEqrtRvYcGRFQ9fS
 F071zGsRU0VzxWtbl9HSeY9UGVlwzHNQAM91TP8FVE/OgeDsYcHM6MU7eMSWkatctDUc
 Nx+w==
X-Gm-Message-State: AFuF++mV5gkGo47v6RbwGDphssyo8SqS7DNzUx+xo4/PkyZaGdNgPHEn
 NcFH1TWKX0OtZJKzxpQhrtVXFR55Ta2L0c3hm9enKq3uTslA3JXB6iSTiZgsVi/FoxkfmPUvdcP
 m02uWBRI=
X-Gm-Gg: AYBFou0UxMitjQvRrPB/uRCixxMvh+/yKXfP2eQkSr3biXz/C8MmacOWE/Tr1qfoNcC
 tyQhAZxde8Yf4uTN43kEtddxUa/surRhs56DsJ5FMlI/pDCluDrqdzr4pMX0VuhYQMFixh6W6rO
 f3oI7G6gPFrZWXRrT9yB2qEhrSTYQRUtVpnZUSnnHSB5Pgu5MHZ7En93ddQ81O+iYdKImL23TPL
 AiUXABZzac8M9oqcwt7kEeEt7dIhXZDDaK2mI4TElOehnXvculW+hTj/WSZXUaKep3ULxf0hEfq
 XF2jjSQF6TrUvV1w2fgGTgaVcbKaftGcjugLGhGxc7+L8AX7xyYM8a5Dp1YiCOTKehSLwqpBh86
 IrAGR5Jfu7hVmqEFRnO4uC6LkZ8DHG6/6REQ5fNPuxy+KipN0Hzo/NzhRpbh/vPNc7IZ+XTlIEJ
 cU2DEBUJdyKfq0i/Qeq//9J6gIYIpqQxei4iwGJ1+sxe9qIFW/NY3ovcInouQw9kVc6e+mW4Wtt
 ZXUaoy7d97YuJSL7i9R/vVyc/BksLp3R9z3CA==
X-Received: by 2002:a05:6a00:298a:b0:882:a8cd:c2f6 with SMTP id
 d2e1a72fcca58-882a8cdc785mr5745948b3a.50.1790699925769; 
 Tue, 29 Sep 2026 09:38:45 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 42/61] drivers/crypto: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:45 -0700
Message-ID: <20260929163800.1108305-43-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

The dump mode handlers use atoi(), which cannot report an error, so a
malformed value is silently taken as zero, which disables dumping
entirely rather than being rejected.

Out of range values keep being clamped to the full dump level, as
before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 15 ++++++++++++---
 drivers/crypto/dpaa_sec/dpaa_sec.c          | 17 +++++++++++++----
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..93e92af6a7 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4342,13 +4342,22 @@ check_devargs_handler(const char *key, const char *value,
 	if (!strcmp(key, "drv_strict_order")) {
 		priv->en_loose_ordered = false;
 	} else if (!strcmp(key, "drv_dump_mode")) {
-		dpaa2_sec_dp_dump = atoi(value);
-		if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_FULL_DUMP) {
+		uint64_t val;
+
+		if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0) {
+			DPAA2_SEC_WARN("WARN: invalid value \"%s\" for \"%s\"",
+				       value, key);
+			return -EINVAL;
+		}
+
+		if (val > DPAA2_SEC_DP_FULL_DUMP) {
 			DPAA2_SEC_WARN("WARN: DPAA2_SEC_DP_DUMP_LEVEL is not "
 				      "supported, changing to FULL error"
 				      " prints");
-			dpaa2_sec_dp_dump = DPAA2_SEC_DP_FULL_DUMP;
+			val = DPAA2_SEC_DP_FULL_DUMP;
 		}
+
+		dpaa2_sec_dp_dump = val;
 	} else
 		return -1;
 
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index c53ee70853..3feb752bcd 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3625,16 +3625,25 @@ dpaa_sec_uninit(struct rte_cryptodev *dev)
 }
 
 static int
-check_devargs_handler(__rte_unused const char *key, const char *value,
+check_devargs_handler(const char *key, const char *value,
 		      __rte_unused void *opaque)
 {
-	dpaa_sec_dp_dump = atoi(value);
-	if (dpaa_sec_dp_dump > DPAA_SEC_DP_FULL_DUMP) {
+	uint64_t val;
+
+	if (rte_kvargs_to_uint(value, 0, UINT8_MAX, &val) < 0) {
+		DPAA_SEC_WARN("WARN: invalid value \"%s\" for \"%s\"",
+			      value, key);
+		return -EINVAL;
+	}
+
+	if (val > DPAA_SEC_DP_FULL_DUMP) {
 		DPAA_SEC_WARN("WARN: DPAA_SEC_DP_DUMP_LEVEL is not "
 			      "supported, changing to FULL error prints");
-		dpaa_sec_dp_dump = DPAA_SEC_DP_FULL_DUMP;
+		val = DPAA_SEC_DP_FULL_DUMP;
 	}
 
+	dpaa_sec_dp_dump = val;
+
 	return 0;
 }
 
-- 
2.53.0

