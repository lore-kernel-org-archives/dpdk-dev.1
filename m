Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25603CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 20:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28F224065D;
	Wed,  3 Jun 2026 22:00:41 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id 06FB4402B6
 for <dev@dpdk.org>; Wed,  3 Jun 2026 22:00:40 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-8ccf0fa0aacso74983876d6.2
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780516839; x=1781121639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GflDDq4bN9JyZWiNch7ZnxwEhtupu76oxdcRQM+ou+g=;
 b=PusK52brgYC1xpPAWbaPGTF/3LQPrlcYlkVL0L3Nt8QVcBf5mxyPar1QUeiuGbM/FL
 f7vVoz8y/lyBxNCmG89Q0lm6R6N7nBhMtivsBuPSH27Bho/lrOO6lnI2dzcwRAxaNHru
 NeRKEf3N5/3q5cEwUI/3vIcTKn9+Nmyg4vlltJ/DosCQLx41V2KN5gFf5nQJ6yqG7fZ5
 n8a+7JnzVMA0YxTFVHIl8SCrUnuYRfmIHfOr3kobezgOkCZKOIPfgpQqppTcIQ8TZGp3
 RCBbAX95f/7/YKDzGBEy2ILWuuDte7R3XyBJgoCFbdxXgqsdQdT8rKqSHmY4yMuLKV/I
 d8iQ==
X-Gm-Message-State: AOJu0Yx3V2S+wXN/e3xCzwukPOQNzuZSXMJp3tq+Rzurtj+Mz5aVpSxg
 Kx5HFHPiOUTiw/qGFDUVPG/Wug5xROwLFkZZRFaNrnTY0JE5XuModWvOnTGD9mnrRQOBAE0GZ9u
 l6rQqTVlxN/61+WoQOCmCxz3TSTLrkggSs90mYen4sdeGUd0aU/Pfu5Xga4pMSUt/zwIHvFpR32
 pl1q6HzT+yNykD+ZqfCDjpyWRjk6yzXlu+FtEc/2zBg38F3dpix3NTkXZ7QmDYJsAMmE1Ap1zaR
 K/wFBKH+59K
X-Gm-Gg: Acq92OGosNDzjGguOkbB8bOTGe5uKBJpcP1a/mnnRNHAZeTIQ25ga5jMrYPdw6znLbq
 pmMYPGW+7CJJ6STkMSFiJRoI4pKpGUwye5Li7ZgF5BwCNL/ZCWp1S4INhfge9CLoCtD6brHKweb
 mzncYcSmaXM0ZAuE0xF9S/H6nstNe/6JlIlXiLWrJcil04jXOmSNugOJ91AeXYbFI9Cyfth/bgU
 81wnkAxh+pO2KdX0r0EM2DIGYHrKa4VxH05T93YGyc7Hs8L5LVBVccEDOh3qinzQ+x+gtstqyZs
 p1rN4azeF5aInMk0neyYBQ/wz1Spp2jLVSIFyKzscSeFc9ulACXDW0NId1fbwVMBf0NcQOldtIh
 a9py8wBdRcjW9lIojuqqPIoQVPecRF0ltN0YNU+KbLPfZZUT/nIevA3S+iYWoTddYA6yGHseBkw
 3MTRlJb5YJKxQprCOKqHrQfWlp4sSiBtO+SFB+Vy8LFNXAwQ9JnYMwN6fdMcvG+Yml+SWBMd551
 6BpCZbRIA==
X-Received: by 2002:a05:6214:212f:b0:8ac:b258:71d1 with SMTP id
 6a1803df08f44-8cecde9df95mr73112276d6.3.1780516821500; 
 Wed, 03 Jun 2026 13:00:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8cecce2802dsm1542526d6.18.2026.06.03.13.00.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:00:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91577337648so177302285a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780516820; x=1781121620; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GflDDq4bN9JyZWiNch7ZnxwEhtupu76oxdcRQM+ou+g=;
 b=Kn68dzlrmFeXjpGUE/MA7gcPdUs5HxbqOxD9DDg3kalWXnSw0EcYOrrl3W006h2lXm
 17eyF3Xlw924psBCXT71zpH39k2lfSgCzLpFX6O5RpBg1E4uAm16KQpzncmczGEe/9rh
 xSNlW30E2EdS5NGTqgsi3Tp2uUHNVvcut4920=
X-Received: by 2002:a05:620a:4621:b0:912:671b:d09b with SMTP id
 af79cd13be357-9158a6df52dmr827368185a.24.1780516819975; 
 Wed, 03 Jun 2026 13:00:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:912:671b:d09b with SMTP id
 af79cd13be357-9158a6df52dmr827347985a.24.1780516818867; 
 Wed, 03 Jun 2026 13:00:18 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a21f871sm345897785a.12.2026.06.03.13.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:00:18 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 4/4] net/bnxt: fix RSS hash mode configuration for VFs
Date: Wed,  3 Jun 2026 14:02:07 -0600
Message-ID: <20260603200207.1996868-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Fixed VFs attempting global RSS configuration which is not
permitted by firmware. VFs (including trusted VFs) must use
per-VNIC RSS configuration with actual vnic_id and rss_ctx_idx
values.

Fixes: 8b9adaf0da6b ("net/bnxt: support RSS on ESP and AH headers")
Cc: stable@dpdk.org
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0c82935de9..afc948ac29 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -2970,8 +2970,22 @@ bnxt_hwrm_vnic_rss_cfg_hash_mode_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic
 		req.hash_mode_flags = BNXT_HASH_MODE_INNERMOST;
 	else
 		req.hash_mode_flags = vnic->hash_mode;
-	req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
-	req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
+
+	/* VFs must use actual vnic_id for per-VNIC configuration.
+	 * PFs can use INVALID vnic_id for global configuration.
+	 * This is because VFs don't have permission to configure
+	 * global hash mode, even if they're trusted.
+	 */
+	if (BNXT_VF(bp)) {
+		req.vnic_id = rte_cpu_to_le_16(vnic->fw_vnic_id);
+		req.rss_ctx_idx = rte_cpu_to_le_16(vnic->fw_grp_ids[0]);
+		PMD_DRV_LOG_LINE(DEBUG, "VF using per-VNIC RSS config (vnic_id=%u)",
+				 vnic->fw_vnic_id);
+	} else {
+		req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
+		req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
+		PMD_DRV_LOG_LINE(DEBUG, "PF using global RSS config");
+	}
 
 	PMD_DRV_LOG_LINE(DEBUG, "RSS CFG: Hash level %d", req.hash_mode_flags);
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req),
-- 
2.47.3

