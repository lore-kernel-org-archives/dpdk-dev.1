Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772A7CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:35:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3853A4065E;
	Wed,  3 Jun 2026 20:34:59 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 3F1F9402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:34:58 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-36babe2c4bdso3825112a91.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780511697; x=1781116497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GflDDq4bN9JyZWiNch7ZnxwEhtupu76oxdcRQM+ou+g=;
 b=nmviU9ocQ0QjcUoXYChpNgJPrx8THZK57h8Z+6FyATqFeN9pN6pMjvErQySP4SIDHb
 6rY030ON25M6PRf//eKdq3ceLMlolnEHfVfw2MtdJmypNEY74buT/syqaCCkrHTzsft0
 s3rg3JwWNk0DfdxziCVEDNR0wRL3AXQeWOU1k2bOlLhbmhV3Kbf5dN9F6nUmMZrZJ7wg
 qLTRHejKlJ9KDvHvIy5g+4AtxYnrmTQtGDrVn5ys9xJb6DbZ67TE++sHnpnLVTJiczIF
 6Ec3HLTfLhYbM96Hr4TOy2XgMhmpuOBtUSmIkCgSMf+TfFzJMYHUDkPnt5HCbN3Sa2C/
 Ztgg==
X-Gm-Message-State: AOJu0Ywfx1/bCQEujQ4Z6FsRZF4iqBL6PvGINLkLhoa2H/9sXVtvUcoG
 0qxF1w0u68SqmQs/Nv3Ul7aRYvBEzILNmSIV0jDADhAIXTCeFAUVJfLuCoFfLKJDusb6mY9H8HQ
 3EcGZXQnAXWPouaPQLfiJtw7lJhsuiwBhZWC1jq5BPVa8VdPo7/WdkIllJCe5KvdGyGjB0Hed2G
 Lz5Su0lU446jq3LX3X2hSUt/ih1vRi5Eov4ysAQiqUoOCMbNF9pxMzP12Fr3nnez5ZU4zxCDIc6
 SJ0/RX6dEWE
X-Gm-Gg: Acq92OFecQfeePxV8ZZklsn5JOLTf6O9ag9kfohfj+EL41irOQQf6jmr5CvpnbTz3pO
 iqE1e6mOkmFS382UE4uP48oP1mc43d6FtNHoJsxksal91aHFcmNWIZMEwxAZhDb7fxFhi1hFurf
 aQHSesQxOohdIVbfeVe1MFYi/0wzXtt8lkBvxQXRQ5nFEw13tKlc663LdIbmL3Rwf3FWu4RMRDS
 1YMCQC09ZifGNynkYv9CQFmXmJRApTBssIxTwe9Efs/Sy5eKNH5c3ZqxC8fmH3X8Z8U6cuTCsgX
 v/rBcNnRD8w54LQRNTpu53fQB7eMN05CE1TgeXbixZy/lLEae4p5zEqKzBjyVHRYjIDPCBKJbE+
 +sP4+eroZXFuIQq757plF6ZbQpYy4u8J/ZI+cBR5PkJmgOxXvXAdxAVdxbbquGKth0UEQl7Jk0e
 tX6kdYDeZweyoXXeGTtTFXLflE7a7GODTXNm5Z8ILQkAQuUcOO20XrCAfBuiDQ/Tx3yQPMSuWM1
 ND0lRkdgv1i
X-Received: by 2002:a17:90b:3c86:b0:369:223a:cb60 with SMTP id
 98e67ed59e1d1-36e30e109admr4200320a91.8.1780511697064; 
 Wed, 03 Jun 2026 11:34:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36f6ff6bc5asm41987a91.8.2026.06.03.11.34.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 11:34:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5177f07eb05so20278241cf.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780511696; x=1781116496; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GflDDq4bN9JyZWiNch7ZnxwEhtupu76oxdcRQM+ou+g=;
 b=EDeIZeOX0cgwsZ0Lk0R2E9CpGw/ULveSkxH3otyCM4/zzdtRkZ92HHHkzdsMFJUFFH
 lFVThmBkNmHyqKWsy37uLgwzMEnqxG7/+yKJCLoU5Kjbr//33p1Y07ufqlsh/Za2HuOh
 0Ml6qj0QSoACBNHcY9sHBHHwMtEru5hP0jd6Y=
X-Received: by 2002:a05:622a:4a17:b0:517:5b22:f4ac with SMTP id
 d75a77b69052e-517851bd110mr23180221cf.5.1780511695871; 
 Wed, 03 Jun 2026 11:34:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4a17:b0:517:5b22:f4ac with SMTP id
 d75a77b69052e-517851bd110mr23179551cf.5.1780511695327; 
 Wed, 03 Jun 2026 11:34:55 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdb5e92sm27671186d6.11.2026.06.03.11.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 11:34:54 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: fix RSS hash mode configuration for VFs
Date: Wed,  3 Jun 2026 12:36:45 -0600
Message-ID: <20260603183645.1993020-1-Mohammad-Shuab.Siddique@broadcom.com>
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

