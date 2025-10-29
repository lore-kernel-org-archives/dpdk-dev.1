Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E82CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:10:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F30C40BA0;
	Wed, 29 Oct 2025 17:09:13 +0100 (CET)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id 404094066E
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:09:11 +0100 (CET)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-3c97813e788so74362fac.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754150; x=1762358950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=emkINCjZt1HOk3rUl426ak2jojmDNpONhrSRGbMIzvY=;
 b=VRbatzJLqDfEMGol2bjFbZZqejHo1s2gSq5+Urn8ntCAN9Th8HUCcZIUmcvGrDXaCI
 o+/FoGdxt5CPxgkO5LWkLO4cn+wqfWPNmTvfM6Z+uljtaPbRSGl82VlH6A+9cFt3XAbG
 6dm1jjH7rbDk37aGNvy+6tFyxmyawvJVFKlNxkl8UL6NOuQHkSwJtl9d0S567ldRN9FM
 I8RHUKxplQu1jcgJ3POlnpDp1JFfOEPXpbzJvsO26O7VfhoNscXwWEdXDxpo/OekgTTD
 kBGwt/NEplYS4dJTuJfSKM0GCUp3ZZ3wTptcZaf8y+GvDuMPRKXI9yr0O5gElCauIthA
 Ng7Q==
X-Gm-Message-State: AOJu0YwuK81dm6FBiUUipWwU+OftNdzIwO1ufCYgrGtb2ui2plSf55As
 ld0ASADpPJeuJ8/41cHfLXYG1TUOF+hibepQr4iQzXCfCuL2izyFi6usGV6r7D1+8bfadznZGXX
 aeBQQLa2bjUdcCTmYRYc1786qjvA4mqeXyOT8ZywfjC3wwVtC8GD6zsYkCaOEsPlmV3E6txhxqA
 hpJ6a2x/HaQJU6yX2vFnCKrU/OyGTFMRxT+cGpPgcDrT7/g+xMI2iUHHGj1C1bpPWbq0nI6w==
X-Gm-Gg: ASbGncs1z4Y65mhd9/mLjTfBl9jr9YBzg02YdQsL9M3Z3P3B7pGv1meL8QWNN9eueJ5
 sJ1o4n32mAVy5c9shQE/OUY5jsJrYtdPICWWCAzS7CSnG+4G4KkS4J81ViDqhwFKk5OjC8zRVZi
 L4IbECJ/4kyNiI8299sQ/PRaV0QKmsLFP4txwJ+wGvmfPRcJOjI0isN/N/s8WOeBsx7zEYKC+nT
 Cz+By7syvd47zV/K6aiQXUhZvRU0gZywiXJoClmJh86A4/ReaBrfFGOq2zc22nZ4VjstjxnlVPf
 9OTzyPNF75GGdUFaFJwqtcfgYa+rU213fZSHtzPFvIl6EYZNv7HHplHia7jYH16kjj21WppC5HI
 3pPoKex2TDfWPG26HRmRYbLiA0Uji6MV7jEY/Rbf586jleXrdC6eV1zLGnfShXtTfOCmWuPezoB
 aLwyPY+IKWxJVPleeX45B6SPMPfkKUMTlt2D1X
X-Google-Smtp-Source: AGHT+IFSMaiFqb6v9zcTH4nFM/dIHoPMJObLDOJFdyiLyrC7N37OxgfOJSYYtyhLq8wUqAHdy7IJYwDzsjT3
X-Received: by 2002:a05:6870:d607:b0:3d2:231c:2d50 with SMTP id
 586e51a60fabf-3d7481a5464mr1719608fac.24.1761754150569; 
 Wed, 29 Oct 2025 09:09:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e21f2633sm1300111fac.2.2025.10.29.09.09.10
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:09:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a24116e89eso456878385a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754149; x=1762358949; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emkINCjZt1HOk3rUl426ak2jojmDNpONhrSRGbMIzvY=;
 b=M47QAlfitNFqICe+TU0n/M+d4YVxRbODHqEjnsJG4BzdiS+ezy2QLoeeNWW8cHESha
 zwLZh/eNTrRzOSCxuqNUWcePx97kf447Gxdb1IpgndWZYBmDUhfCiXtifrutXbGs/0ZO
 GIQKaFqYUaWqu4hnyp/CEkGP2s4zStg/wcTkU=
X-Received: by 2002:a05:620a:44c5:b0:89e:cd17:1f4c with SMTP id
 af79cd13be357-8aa2f5a92e4mr10782485a.79.1761754149212; 
 Wed, 29 Oct 2025 09:09:09 -0700 (PDT)
X-Received: by 2002:a05:620a:44c5:b0:89e:cd17:1f4c with SMTP id
 af79cd13be357-8aa2f5a92e4mr10758085a.79.1761754147000; 
 Wed, 29 Oct 2025 09:09:07 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.09.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:09:06 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 22/57] net/bnxt: Cleanup max VF calculation for thor2
Date: Wed, 29 Oct 2025 12:06:37 -0400
Message-Id: <20251029160712.58519-23-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The number of max VFs per PF is 128 for THOR2.
Correctly calculated the VNIC hash table creation if the number
of max vnics is less than 8.

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

