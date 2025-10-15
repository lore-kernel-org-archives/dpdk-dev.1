Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38005CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28C5740EE2;
	Wed, 15 Oct 2025 11:05:36 +0200 (CEST)
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com
 [209.85.160.99]) by mails.dpdk.org (Postfix) with ESMTP id C136C40E0F
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:34 +0200 (CEST)
Received: by mail-oa1-f99.google.com with SMTP id
 586e51a60fabf-3627a1979a0so4214893fac.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519134; x=1761123934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=cZPfhqJXYI/2+mFIreWGv+zJgxMi27B9273/0K4TQNVOvhGRZRQR55n/E1sAMCd741
 dTBIqSePfHrJeYZyUco+c92bNDiQHYodhGsPlzuZV74SwPd8cTdzWHJRlGEE9FhIQSl5
 BnNs9cfHKS7NPc+Su+cdlmErxeZBWBdnOWEUKgnutoSvEVSDDFl0MvbJR+CXPxIMVwL5
 78L6cDWcUOF3XeVUZ5PaVqO04/9fZtGeV8OmTuU8qz+seh0dqU7BEBXMhTznQ6nZF0ja
 BOUlH3OEor1SW1KJcC/XJTX7W7BjZOfYau9FW7iM2B2FbBbPUdhl+L82DNZVuA4gljln
 vADA==
X-Gm-Message-State: AOJu0YzBngRIolSOjpQHC2TmYgDiSfk4/UPlACjih1YigvluqSdYL1Gk
 6kK9B05+NnfOF2HI5E4b4IFbaqDB9a3Gopk5FR/vNSzN1trH/Wr3KFAsyB9HaEjh6N6bFvKIcwL
 YGhf3b2zuZ9R58sW3/Oa1GH0hHJA5oviaDz7TPp1XGn+3d1clkKDDfLjHbYAvBR28VP93mJd/ht
 eopaeDPZRGMp2AV9LXN1Rb9+54xSc6Nu2Kujt2lf/ucfytdPuuFG5IUoXAPZqL1ix1sxZ9rQ==
X-Gm-Gg: ASbGnctvfasMB6LZMHSMOnGgN5z1Cv+SLWYkCLww8EwvwXS/quu8KLCKmpL64KOADq8
 2NSvJOhZmmkz+s4OHhKQHm5ZUc/GnvcLiv0MgdOvc0xLvKm5BDlmONC6f0E0VVGkuReCF3XoTXw
 o6W4/VzKIdL4A32vXtpZFaq6x4OGJHOWNnwO8ojW5B6hKR8TfqHQrUzvGi25tAQEUQB4c4QCXmz
 TeLbIrP8n77/rFFDj2Niqxxb/oB/TEOG1tCUHZo9IgApLvQT6lIlKpiZDK/5JGtubUoksUWc2G4
 2t+x8Wrbzx043aolRodDc9WBxg12n0ROmDx+alohh1FxFWpmyXANoBM9eq2gMp9mevqFfScyZCc
 VibsYhvhLAyqSMRA6fvF65L3r+glJmlk3BWjUnhf7bNh15yPp/ol1/v6qmtc9rxEhf9UHHH4Q
X-Google-Smtp-Source: AGHT+IFIwVdPy3e4wUvu3gX3liJBXGzanIFRZlJi1ReFy0hNifGH9KtcN6VQA9Td7kUZJGvb4zWNdsIVzO5x
X-Received: by 2002:a05:6870:70a7:b0:381:e796:fbdd with SMTP id
 586e51a60fabf-3c0f8db730dmr15680238fac.35.1760519133962; 
 Wed, 15 Oct 2025 02:05:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8e8e6f1sm1282844fac.13.2025.10.15.02.05.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-339ee7532b9so27588587a91.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519131; x=1761123931; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=MfY7ZnDJKN8uVHiDbs7yOMncpAa6CZ3q3vzR1lHqjuChgktWKa2dFJkrOcE6a0skf+
 H8Kv/xh86OC1fKSW8zXFBT9LO70sP4k/LTa74MmQjWGoHnwp+7VYfyES/Ogt2xpMGyaa
 2OvVvVjeqRDFXT6bizpysJqwiW/Jz8sXlVcok=
X-Received: by 2002:a17:90b:4d06:b0:336:bfce:13c9 with SMTP id
 98e67ed59e1d1-33b513757a6mr37255459a91.20.1760519131324; 
 Wed, 15 Oct 2025 02:05:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:336:bfce:13c9 with SMTP id
 98e67ed59e1d1-33b513757a6mr37255386a91.20.1760519130398; 
 Wed, 15 Oct 2025 02:05:30 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 49/54] net/bnxt/tf_core: remove excessive debug logging
Date: Wed, 15 Oct 2025 05:00:19 -0400
Message-Id: <20251015090024.32250-50-manish.kurup@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change removes a debug message of questionable usefulness
that can spam the terminal if more than 5K flows are created.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 47870747e1..3fe4dbe3fe 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -1012,13 +1012,7 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 
 			count--;
 
-			if (j != start_index) {
-				PMD_DRV_LOG_LINE(INFO,
-						 "%s: OOO comp. Opq Exp:%d Got:%d j:%d",
-						 __func__,
-						 batch_info->comp_info[j].opaque,
-						 opaque, j);
-			} else {
+			if (j == start_index) {
 				start_index++;
 
 				while (count &&
-- 
2.39.5 (Apple Git-154)

