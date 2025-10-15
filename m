Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEBCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C507140ED0;
	Wed, 15 Oct 2025 11:05:14 +0200 (CEST)
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by mails.dpdk.org (Postfix) with ESMTP id E6ABF410ED
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:12 +0200 (CEST)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-7817c2d90d0so2278297b3.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519112; x=1761123912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=GlI5auGkeeFoU6sLGPsTwPEa0bWetKpDX9AiBttZa1c5eekoDCfw376L+itczS3Hqm
 lWrtf7RRTO6aZXmLYZ2vh2mRfqPk0WwGn/YG1VR82q+NmvgzDxrqjxVDk9GPR/hJRvZv
 6Xdhu/mCoAPuTLVllmnR+iuHOfKMnxJQi0Aclhju9t5tg1HaiO8KJRsClBfuBx0T0zmP
 zs1HaLfJs6k1n/AptXueLTihSxWPCPKtWm4RUKQA7vwHRQZY0Kp7EpZIfqGOHlNAZwxo
 iBnWlTo5Np6aMVvL8Su5X+c5ENvMc9/IANHoJXX6iANeF7ICjjvSezENYdQvaHfA6XJG
 Bgxg==
X-Gm-Message-State: AOJu0Yx+YEg0x+zW7FYWHnLzVjGvb2IQaJbkP25OjR9yt3jjpu6yWMs0
 vqN0JT+su5Vox96qRjCc4O4mNOfQ2Xe7g1xE7cmWCCcl8SysVj6f4u0+LBC1erQmYx82oy1+qgy
 pDKxWaEY0KxowB/hCRmCx3xDi5RkGFYVxd0dI+fJg1q7FUdCBTEqZhaFowRgESGnE/T4z+egIAX
 tKm6l8022F+T3363qnTuJ/rIuRZkfrX+yOkbaIhZIkHmVgwmwdI1qpITJGLXPJITmXJ1m9Uw==
X-Gm-Gg: ASbGncsI5rJVEswXZAY1R2zjF2YIVNg0ZXlE4+I3OsJsU2NMIVkCnLiejE3ADxJicDk
 5oPoKGsbeFZuDMhReAtwf7IKkc9IhBuoC27LYM++OKZBZ4mOs9PCzbhBiDwolrOyNPoO/KNKLge
 MurnBB5ZSkvwv926FICm7WIt1e1TQuETABYKaSkea/j43y082WGD1j6h/YaIoOxg5AcWs7tSxXy
 NojZdPww3Op4ZWylNdET1o4ya9eIH34gf2j+M5SuBvNfu47hPtAtKevytg2sS3ajZoDQr8/A2MV
 o7mYWGBiM+80lnC0rV21YjnDCG1WLRc9hjAhfQGKH7dohzLq6XxuqvqK3SLTwH5iiTQpXNGHyBA
 xgXbgJcrIrZdpu9gJC1wgjP+/amwbgN3sDnfTC1AO23ZmldWspNSH+HsF8JPCNEPIXCa5NCTj1q
 f3hw==
X-Google-Smtp-Source: AGHT+IE/fv91fpIMPLhI5d41tqbmxsgYNb0YuyJJXTyje2KSFanvgC/4cb4mUak8UcGp8L2Q5DvUnuUGjKQj
X-Received: by 2002:a05:690c:d17:b0:737:523a:f7f5 with SMTP id
 00721157ae682-780e1769d62mr267747637b3.35.1760519112002; 
 Wed, 15 Oct 2025 02:05:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-781c60e6e16sm82137b3.0.2025.10.15.02.05.11
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-780fb254938so8425133b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519110; x=1761123910; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=EQXc4i0LQhE8sU+217VxvIycgXMPkbaeghgPtJq3cADNOn72yhLcWD1f06uo1PF3aX
 fTDoCTqP5PpAcg3HLWdWEg8oIpC1/Im0zk8zQ3taS5HHXhmsoDLlJDs1T2YkI7X4medx
 8axxs+5T0YRR2dorsG7+3+yT7ZmTCu6n5C9V0=
X-Received: by 2002:a05:6a00:4c99:b0:781:2740:11b2 with SMTP id
 d2e1a72fcca58-79387efb043mr28900440b3a.25.1760519110220; 
 Wed, 15 Oct 2025 02:05:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c99:b0:781:2740:11b2 with SMTP id
 d2e1a72fcca58-79387efb043mr28900397b3a.25.1760519109600; 
 Wed, 15 Oct 2025 02:05:09 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:09 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 41/54] net/bnxt: fix rss configuration when set to none
Date: Wed, 15 Oct 2025 05:00:11 -0400
Message-Id: <20251015090024.32250-42-manish.kurup@broadcom.com>
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

If the rss hash type is set to none and the ports are stopped and
started again, the check for rss hash type was not allowing the
bnxt driver to populate the correct rx rings in the vnic rss list.
This causes the subsequent calls to rss configuration fail since
the rss list is not configured and have stale data causing the
firmware to reject the rss configuration.

The rss hash type of none should not be ignored during configuration,
it is a valid configuration and should be applied. When rss hash
type is none, the rss context is disabled and there should be no
rss algorithm applied to the incoming traffic.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 00b02821c9..939f35e3da 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6331,7 +6331,7 @@ int bnxt_vnic_rss_configure(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
 		return 0;
 
-	if (!(vnic->rss_table && vnic->hash_type))
+	if (vnic->rss_table == NULL)
 		return 0;
 
 	if (BNXT_CHIP_P5_P7(bp))
-- 
2.39.5 (Apple Git-154)

