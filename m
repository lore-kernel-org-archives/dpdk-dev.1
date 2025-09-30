Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC81CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85FD541153;
	Tue, 30 Sep 2025 09:06:33 +0200 (CEST)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id 93A50402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:48 +0200 (CEST)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-36af61f2946so3087798fac.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192668; x=1759797468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=I2cC/yL/4n8YI+akaXND/6f6rNI0gVyHT7kR09vLxTwrR+p2v+nCSpC3QVUBbUy9FB
 f+tWEnvz5QwroZFgnX962dvz4epTEWmOdR9QjCpeQspEv3a+qqeqpgevwgIdE01jcQmU
 4WZNuk3D9a7UTjo7DD75KJ/aixXJ5AYgLtQJRNXRbE9ElpWjVhKoOjV44sbxfB7DGOLK
 u/rqjeLNsB+IeYQeczcJn2ECfV63mlD08k0NvS5/R//usvv6NGksMD5IfzZ/qEa9UY7s
 REwHpTRJjhG4Hxv1+qt4G/wmRMRztWRSYQ61zfn3bzbpw/89tmF5eNEdsRNcWueUpaL1
 FExQ==
X-Gm-Message-State: AOJu0YygP2SByI72hTCCoSD0+CqiCsKvhvacLeVZ+NZfMXaiDhDr2J8r
 lD4w4OAnFhVJuXZAYqAuiyjTlkmztU8CJKAtmQT5ynC8wrL+8szrhOZvsaesPa6c/DJ720IcodD
 B4Es+PuVDXv9Ru4tLTcEm5laWzXpNpPF3ZIgJv/8HMOyU0UKYSPHCh50DmNuxbasxSW4y2HSohM
 DndfSPPh6XXstRTb3YXrTXAI33C/yI4wseHlVdXJzHRtig/tdCbGL9GaplrxRZuZTPCZjP0w==
X-Gm-Gg: ASbGncueBt3fV+vohralhDiqOpv7aqRn90Dn6DCrVmg8XkCfohdR8YYujIxe6ciTJ8I
 OVv37jg8GGuLLvmzWvnoCEJYsunEzO1DTTdMtmBPb8f4q5/xYCxQmiuRkqswt4ohwFO3aGIW8io
 EgbvCi5GfDu1kxq2fYey4GD2tIIsU4C3R0jIn0xdKd400pv2NzrVvOCQ0Wcr+TPH1UfwSmTwC3G
 VXFkHl9xCsgtXoimmk7stkSeufqw5R/WEi4RDFmdJDNfBEG5Mdp9x7zUEs9OIYREo862w3c8EX3
 cNJtKzdn23dMaYCOweOdAFIIzAkbEermrMyqrfGuf9h8M+L1Zz5wEFvXG/gnAXjRh2z/njxbtJe
 LI3tygKV+qdYb7bHrRE1acb0btgFUDoGZymMxQY/J81ITKTTugHGmtiMZiyH67Zn2EnrAUDPwMA
 m2m6N+S0I=
X-Google-Smtp-Source: AGHT+IELyTCh30z2WLTJEIe8M6k8Hh8gV9/5L5vlzbjz64XYwZEZKOJHjY3nfp2qxBS8GKLRIhYiUUa9KwY/
X-Received: by 2002:a05:6870:3c8d:b0:347:3865:83b0 with SMTP id
 586e51a60fabf-38cadf75decmr1554910fac.3.1759192667819; 
 Mon, 29 Sep 2025 17:37:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3636f0b17cbsm1076615fac.0.2025.09.29.17.37.46
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-78108268ea3so3830021b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192665; x=1759797465; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=Fkl187MS1ZnZbbeQVL7B/UVEXwd0pR0/XWygIHtVByqExo4yYkExmo+EuZmYmVTrQO
 jBlYDZo30NBYEQwB/d9ImMJP6Qdoph7NFr6XJ8PdPAtJQYbfYJaT+9e0fKIed3I1IqZc
 TqmzWq9XcXH5CMLdRIB9NeNM4leph32wWeAK4=
X-Received: by 2002:a05:6a21:9203:b0:248:7e43:b6b3 with SMTP id
 adf61e73a8af0-317647b6140mr2770734637.9.1759192665350; 
 Mon, 29 Sep 2025 17:37:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:9203:b0:248:7e43:b6b3 with SMTP id
 adf61e73a8af0-317647b6140mr2770698637.9.1759192664784; 
 Mon, 29 Sep 2025 17:37:44 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:44 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 50/54] net/bnxt/tf_core: fix truflow PF init failure on sriov
 disabled
Date: Mon, 29 Sep 2025 20:36:00 -0400
Message-Id: <20250930003604.87108-51-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

When sriov is disabled and running DPDK on PFs fix invalid max VF
check during table scope creation.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 878f62c115..c06099af12 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -1210,7 +1210,8 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				return rc;
 
 			if (fid > max_vf) {
-				PMD_DRV_LOG_LINE(ERR, "fid out of range %d", fid);
+				PMD_DRV_LOG_LINE(ERR, "%s fid out of range %d",
+						 __func__, fid);
 				return -EINVAL;
 			}
 
@@ -1419,16 +1420,7 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED && is_pf) {
 		uint16_t pool_cnt;
-		uint16_t max_vf;
 
-		rc = tfc_bp_vf_max(tfcp, &max_vf);
-		if (rc)
-			return rc;
-
-		if (fid > max_vf) {
-			PMD_DRV_LOG_LINE(ERR, "invalid fid 0x%x", fid);
-			return -EINVAL;
-		}
 		rc = tbl_scope_tpm_fid_rem(tfcp, fid, tsid, &pool_cnt);
 		if (rc) {
 			PMD_DRV_LOG_LINE(ERR, "error getting tsid(%d) pools status %s",
-- 
2.39.5 (Apple Git-154)

