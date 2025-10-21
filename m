Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DFCCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46E9840EE3;
	Tue, 21 Oct 2025 19:52:56 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id 213A240E38
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:52 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-6360397e8c7so6031372d50.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069171; x=1761673971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSha/rHfhVpqMCkemzhzJt9MKBZNA3cJ/ALQp5n7hHk=;
 b=ScKrb1YjSKD4ekVyP2e8D6IBMfYhCOEEuHXdbc95Z+ljtw/PPcFMM/YtvLhg4/3Ehk
 clyMnlpOEbv6fmuFOkSvRbUuxddP/PDQCFeQ598KwOvoflLo0OROTWulKpdCnMBJmRuM
 mB/Zz42mzqu92sKmvPB/EGpBj5pXPDm+R21Jaoix/biQxD5IUK8TW3gCKZcs1U1mJwC8
 5u/0A7Fca5nc+pjjsNYKK38yCEw54QKNhZ8DbgZPlyyfp7xH8odRcqpcZXwwd9btXW3c
 LIs3iEImWRpdg8IoHdyih4P6gGaLnFelniFj5xVpkwhzmxEis7IlbqoDz4BECOZ7zEZQ
 thTg==
X-Gm-Message-State: AOJu0Yxg11rWTXlsfc72m3svFRV6Xa76pQwkSKIwFhNo+jkKg4JB4t5X
 hknL9jlM9fp8VHy5dFyxIwaQlaAFDVqGx+IdCcbu88KOFfebzV57phPRhIY12PWl2hUcLC6paec
 6HLKwRLBP2fSp+7HOFVmaukG3N3a9DIdBGOuZ0kD/ZtjcYCJ8ewcDsCLci5xEyU9oXY939mz8M+
 6LJ1f4RWXlrjIOmMZbsBHbdGHDexPgizGaZYgvd/FNaGSeUWPPyYFpyHhWE8mKiTUNDkQwQQ==
X-Gm-Gg: ASbGncsN0Tur/tZp3p6O03xsQeghjOMVAXsrl19XVylYyPUfikk2Hwbpkxc86yS4m9u
 0NukWdROOGzwmzawwutJPZLJShEJcNJeUYe5p/e4ijX6ltbH6NdXga0gI+FYjrqMUBnnJRygIhi
 F0kqPE1YI5SENxaMpNBUYPe6riBAqg22O+SaVN0SLx7q8qCQmkggZUx18qDjm0eJCNq6zbrfdnw
 m8eRRK8/LsPLs3u31w+qxrpuMCUsCeV0w+68vQAAYG98KZQNUYotu/Kec1uOdzp0HUzkbIVYEuS
 Nr/XflHBQNwo6MRRgI00LaUniySfoj0cHUU0VreisnAZz25uaO7kxygO8Qjipq/GBkxQDFQYo5W
 G0o8uanoOwM90JaxD/jVTNLYKhv2a9vrHOG9nZ8kRxIdbjO373RJu/AtdEkDUO/BpOZgCIUdHJG
 in/G/XpJYqEzHbWnvVu3K7uh9mXkQxZyu68Q==
X-Google-Smtp-Source: AGHT+IGeogtm/8r9oo14C+Bze8M2j3ghupKFltdc4oBdB56Okl5B3pgr2rXag4SOzqipbNmaD8xgztpg24tY
X-Received: by 2002:a05:690e:130d:b0:63e:217e:6758 with SMTP id
 956f58d0204a3-63e217e693cmr10702772d50.52.1761069171399; 
 Tue, 21 Oct 2025 10:52:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-63e26683cd2sm853064d50.4.2025.10.21.10.52.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-290cd61855eso46310075ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069169; x=1761673969; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSha/rHfhVpqMCkemzhzJt9MKBZNA3cJ/ALQp5n7hHk=;
 b=hCjRNRjLHwqZhLkNWGAS8Zp0toeIs/Xt5Quz/m+tshI0O+gta+SUOHfRicOlIyRKkR
 cyNbWhqKcpMB3cJQaRvMJ1fZMrY2/1YHS5N8945z2GAmogX3UpK8tNfJiibJcMBdCRzi
 deV+hTO92d13cqQhtJ9pX+mRwAAM9wUvXLjV4=
X-Received: by 2002:a17:903:2290:b0:269:8d85:2249 with SMTP id
 d9443c01a7336-290d14e83a7mr205114035ad.22.1761069169685; 
 Tue, 21 Oct 2025 10:52:49 -0700 (PDT)
X-Received: by 2002:a17:903:2290:b0:269:8d85:2249 with SMTP id
 d9443c01a7336-290d14e83a7mr205113615ad.22.1761069169032; 
 Tue, 21 Oct 2025 10:52:49 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 22/57] net/bnxt: fix max VFs count for thor2
Date: Tue, 21 Oct 2025 13:50:14 -0400
Message-Id: <20251021175049.46092-23-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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

The number of max vfs per pf is 128 for thor2.
Fixed the vnic hash table creation if the number of max vnics is less
than 8.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt.h      |  2 ++
 drivers/net/bnxt/bnxt_vnic.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 00bdb53215..90352d537c 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -260,8 +260,10 @@ struct bnxt_pf_info {
 #define BNXT_MAX_VFS(bp)	((bp)->pf->max_vfs)
 #define BNXT_MAX_VF_REPS_P4     64
 #define BNXT_MAX_VF_REPS_P5     256
+#define BNXT_MAX_VF_REPS_P7     128
 #define BNXT_MAX_VF_REPS(bp) \
 				(BNXT_CHIP_P5(bp) ? BNXT_MAX_VF_REPS_P5 : \
+				BNXT_CHIP_P7(bp) ? BNXT_MAX_VF_REPS_P7 : \
 				BNXT_MAX_VF_REPS_P4)
 #define BNXT_TOTAL_VFS(bp)	((bp)->pf->total_vfs)
 #define BNXT_FIRST_VF_FID	128
diff --git a/drivers/net/bnxt/bnxt_vnic.c b/drivers/net/bnxt/bnxt_vnic.c
index 7b028f2ee5..637e9b9aa4 100644
--- a/drivers/net/bnxt/bnxt_vnic.c
+++ b/drivers/net/bnxt/bnxt_vnic.c
@@ -16,6 +16,11 @@
 #include "hsi_struct_def_dpdk.h"
 #include "bnxt_hwrm.h"
 
+#ifndef RTE_HASH_BUCKET_ENTRIES
+/* it is defined in lib/hash/rte_cuckoo_hash.h */
+#define RTE_HASH_BUCKET_ENTRIES     8
+#endif /* RTE_HASH_BUCKET_ENTRIES */
+
 /* Macros to manipulate vnic bitmaps*/
 #define BNXT_VNIC_BITMAP_SIZE	64
 #define BNXT_VNIC_BITMAP_SET(b, i)	((b[(i) / BNXT_VNIC_BITMAP_SIZE]) |= \
@@ -978,6 +983,12 @@ int32_t bnxt_vnic_queue_db_init(struct bnxt *bp)
 	hash_tbl_params.name = hash_tbl_name;
 	hash_tbl_params.entries = (bp->max_vnics > BNXT_VNIC_MAX_SUPPORTED_ID) ?
 		BNXT_VNIC_MAX_SUPPORTED_ID : bp->max_vnics;
+
+	/* if the number of max vnis is less than bucket size */
+	/* then let the max entries size be the least value */
+	if (hash_tbl_params.entries <= RTE_HASH_BUCKET_ENTRIES)
+		hash_tbl_params.entries = RTE_HASH_BUCKET_ENTRIES;
+
 	hash_tbl_params.key_len = BNXT_VNIC_MAX_QUEUE_SZ_IN_8BITS;
 	hash_tbl_params.socket_id = rte_socket_id();
 	bp->vnic_queue_db.rss_q_db = rte_hash_create(&hash_tbl_params);
-- 
2.39.5 (Apple Git-154)

