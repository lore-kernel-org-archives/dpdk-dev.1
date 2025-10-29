Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EECCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C96F4066C;
	Wed, 29 Oct 2025 17:24:32 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 5273140667
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:24:15 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3402942e79cso129212a91.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755054; x=1762359854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+oRHAx33OF7DjSmxcix83uRAR8aRjps067V3JfT/i0=;
 b=SeJj3qJHFnAhECcbWP3iFE41xowfVRgoV653NLYlWOe/wPKcY3t2MAwrH4mqzpkKOF
 hsjD7i/gS5bfQdcVw0X+SbljxYRuRaXfJjpa8buMbfEUIocXEFr2dyHeQeEPoTKl9TG+
 tvpsKkqitWUUN8k/fkEQC7xC8d8x1jy10osATlfFpM/ftdPHU6csYQ6LuJAJpF9CvmIf
 FBBVDstc1w3iLSZcQ+sfeVFAY1cRNfeCqBXBFzhebMzVD9qmLZByOx41gYnQWqROgehh
 chJobWIN6q+lh+6lbAhjYR+g6xgQRsM/eAB9mzxLhXJoStJlzl4qkxc2R7ySXxEuOFOU
 oYEQ==
X-Gm-Message-State: AOJu0YzcaZ5yHbKNgVewu+XDQiSLsMsZrWI7BYN3MAJLQs1JT1M8oWcM
 PAiNzXb1LsQehnv/FN9volwFHNECYa//uc+niSIm9BldiBfCqH5ZUCy8+1XSsjYcB/mXK5B1olI
 3re/bx8amb17/LHOIlk6cViRdLKH0llnPClSuFrhitYwR5OgsWmZbTI/udOQZ1m6vwj28rFDMt3
 ROUrrY5kduv9bn4/lKcXZaXk1LirxNLdTD0vh6vBgt1O38iKrFdB5kReQKtl2N7OO8A0ySJg==
X-Gm-Gg: ASbGncsc8fVDccyFA4FvJ0sWXWonfkT6D41Y0dupJTrWoQaihoq3eEN4scF3qpycrOv
 A4ExqEPoiCENs0ncvYuH2n+jAPyFVcEda3kxjz3ba/x3x+fIUeQ44Aym744uT3+jKjh1P2vHJQ2
 uUczK3ZqJdF72cB+SKIglVbclkLvVdC9dOY/W37OLp7h+am224bqEmpD1d/9EAKb3+/Z32+ZzAd
 a5shn0tFCzqPxvigub1pR+8gTtzgI1RNTTDjZN1pCirjcNUdmgZuMHJ3FzCIkVOQprux9yyXjKI
 UAgyNhoJF1isoSXNL3WwKaQBEJOfIgWRp2fBHZj0FXYKdtzZGUh/rCrxu3MCA0fcqlrbWpwZcca
 YTlr6Mb8yutWyDHTucHGmW9v/8XRQ4mRaKfGTGndc3yzs2k6elQ8Q+H3It7VSPONrWKgljQ/pRe
 zJJAgisOicGg+vcaCi9dyZGfq5yOMORQkT6A==
X-Google-Smtp-Source: AGHT+IFIQJSOFNUVUuzVOSyybtq/WqP8hMsa83TNe/+38FZYv+UTsNk48zxvhfjDn6o+pU5sxWjEULR1bX2O
X-Received: by 2002:a17:90b:4c8c:b0:330:84c8:92d0 with SMTP id
 98e67ed59e1d1-3403a283a76mr4037551a91.24.1761755054458; 
 Wed, 29 Oct 2025 09:24:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33fed7cdc27sm1440443a91.5.2025.10.29.09.24.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:24:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a24116e89eso2403485a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755053; x=1762359853; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+oRHAx33OF7DjSmxcix83uRAR8aRjps067V3JfT/i0=;
 b=V2tjXUP6i6ZuGu9Sc4l8o4HptvEPRX4z8HfjkwED0EayHX9zX/PytRcIkNQgYQdC/o
 0YffBIk69BqlkqbVeXzw7QgeRvZ08c6BVShxxDeRBf7YY/xXkLtbIclGvBK4cSHSaT8l
 JXjcwYuKsOuo1U5WyI0fUuNcfgFolz0idfOlI=
X-Received: by 2002:a05:620a:40cb:b0:89f:12af:e55f with SMTP id
 af79cd13be357-8aa2ea09a01mr24348885a.44.1761755052668; 
 Wed, 29 Oct 2025 09:24:12 -0700 (PDT)
X-Received: by 2002:a05:620a:40cb:b0:89f:12af:e55f with SMTP id
 af79cd13be357-8aa2ea09a01mr24342185a.44.1761755051962; 
 Wed, 29 Oct 2025 09:24:11 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.24.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:24:11 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 53/57] net/bnxt/tf_core: truflow SR-IOV PF init cleanup
Date: Wed, 29 Oct 2025 12:07:08 -0400
Message-Id: <20251029160712.58519-54-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

When running DPDK on PFs with SR-IOV disabled, correct the
"invalid max VF check" during table scope creation.

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

