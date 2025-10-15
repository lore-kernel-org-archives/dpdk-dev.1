Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BE0CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DE91410EE;
	Wed, 15 Oct 2025 11:05:12 +0200 (CEST)
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com
 [209.85.222.97]) by mails.dpdk.org (Postfix) with ESMTP id B93AB410EA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:10 +0200 (CEST)
Received: by mail-ua1-f97.google.com with SMTP id
 a1e0cc1a2514c-91bdf1a4875so1333384241.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519110; x=1761123910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=W1R2Ydewnr0w0QaDw+szXXG3Ee1TRNfrFe6Z4Nep900hAq9UlNYwhzHhx3hUCzqUSL
 J1SRGHLiszc5bHDH0DQC7AIAsDqDykOtRUoQUVWYGAYYz58NhkR0ekoX5LmDnAEfXVYz
 +hf7T1jYGS4wHYZFRzcAq/S6IWSvP8GUqsvIIHxDzpowkbEHcBI20R69wTNI+BorIu67
 Wrmie0PwEzOdQ3f4QeUCO3R58LYy2V+ol//jyIh/ayfkKgZm320piOt6tj/mpK0BTSrZ
 ZnyGo9aay46kPMmaYXgdCLpCRiUUbr3deUQY3RL4j/P7PdWG+9uy4+6CYL5iM7mk85Ku
 eRig==
X-Gm-Message-State: AOJu0YwLl7a8ranTbrtbyB0cbjx+WlPtpvZMy4/9kGUDtdb3WcFuCL0C
 zYAzkqwzKhopEyJ4uOinNwCpcWM0t1ouSNrh1rLl+7YGunBZhlO/qv2lMfgieGGduZkzCt0wj0Y
 W5adqdvXCP3YAh59jw+Rmy+AXj9OQXtnxaLAU2azOJmU108B6Qc+bxzlKPu9Nn+NxW0JERGgrP7
 RO9qIjXDkp70e6IESZgBUW3mSuZqGpkuzGr/Geb0pMbFKZ+H4hXOFTCGLgVgLzstUU6L6dLw==
X-Gm-Gg: ASbGncumtMScIoFBjcOMMx2p1jFDRAyOiRalp+ebAkvgKuUKgyXAX3xRkZMtNaxJqze
 0A8R7ieKqf3aSqChQQxXTJb/cfQFpS/F2R5ibDI1otPZSEozwoN8q9FINtmTfLgKniJw/lBi1TV
 7blUOn8HL/7vSIHtosiw4s0SAJ4R6srkVt8bcBFaJZqoo+NOo/YD8KGG0OOahv1XoPsel3+kM2t
 GacV9V9/7uCuoUEPOjptQaypyvHmbolt32P5GjpIFo8qkD5rAQzz4UiBLRWBVvPvfyzzDOgF7Q5
 5t7N/8Cwke2a0UIqaPdbwiMvY2MUp7M0RJDpcK2OEPXfNB6JYRIXN5i+BTRKSAuTD8JjtOORVFi
 0S7Kha4iQHH1qpucvIVJDZ1Wyz3KZBw91lEAkqu5hY/i67P0viWDoWZBgI+6dxAUZoUB2WMxsSr
 Tpcw==
X-Google-Smtp-Source: AGHT+IF733mri0uxHHUmJ/9DSzuyUXZ1t/+NvokQp9sLwsNB18oK55dFDipERqe+/nbvqiyYXlteydMdWdqd
X-Received: by 2002:a05:6102:50a9:b0:5d5:f6ae:38d4 with SMTP id
 ada2fe7eead31-5d5f6ae3ce0mr7149260137.41.1760519109823; 
 Wed, 15 Oct 2025 02:05:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-554d7fc3c57sm1738697e0c.3.2025.10.15.02.05.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso16651702a12.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519107; x=1761123907; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=KtXFEHoPrtsDANLPr7rLo1CVt2B/BuANj0DIAiCj1yMwI7SU93otRVkZfPDENwEQHp
 CQYNgEIoBVev5xQG3hgSHJE/heJKw3Fao/Oy9Lxz3DOvPCxVZjctltnlJ0tChX4wZGuz
 sqrN/VsbtXm6OAbOM6evKd0a1L72gk6Zo6nGg=
X-Received: by 2002:a05:6a20:3ca7:b0:2c6:2c4c:fb17 with SMTP id
 adf61e73a8af0-32da84ede62mr36907213637.57.1760519107671; 
 Wed, 15 Oct 2025 02:05:07 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca7:b0:2c6:2c4c:fb17 with SMTP id
 adf61e73a8af0-32da84ede62mr36907162637.57.1760519107077; 
 Wed, 15 Oct 2025 02:05:07 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:06 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v3 40/54] net/bnxt: fix stats collection when rx queue is not
 set
Date: Wed, 15 Oct 2025 05:00:10 -0400
Message-Id: <20251015090024.32250-41-manish.kurup@broadcom.com>
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

When rx queue is not started and the stats context id is not
allocated then skip the stats collection.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 9d7cdf925d..697f9ad9fe 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -656,6 +656,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (!rxq->rx_started)
 			continue;
 
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
+
 		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
 					      &ring_stats, true);
 		if (unlikely(rc))
@@ -717,6 +720,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 
 		if (!rxq->rx_started)
 			continue;
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
 
 		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
 					  &ring_stats, true);
-- 
2.39.5 (Apple Git-154)

