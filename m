Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FADECCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82A2640663;
	Fri, 10 Oct 2025 00:15:46 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id ACDFC406B6
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:45 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3381f041d7fso2866414a91.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048145; x=1760652945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSha/rHfhVpqMCkemzhzJt9MKBZNA3cJ/ALQp5n7hHk=;
 b=PWV/r0RjMmC80qxgFzo9wdoG4LmXJ+IAcWAq00Davkw/6vzGZUdxaLkVVDq79aC6aK
 Cky7rEBmDQs9BVU/W3YzPT23QE4zS24r8w28nqaIRC4ACvn501qV81QYvBVswnEGFBlN
 IEF/tbMPInZRmRGhhCp2j3sc3j6SkvFZ/eTUO+WZklk3SKSq+sNOI5Qh9MBAlsbYDVXW
 KjgeqpthXw/GHvggQJl/Z0VwY/JOGLvpqLsQZK15SmQ67glg5uRYOoOEEPuWE1XqrkC5
 ZWZJsV1q/3aIlABu9BwGVZTwVgdz7k/+b+VRppdUeok4ECAOnCffwyh5UdY15eBDzp3s
 gwnA==
X-Gm-Message-State: AOJu0YzLv6xO+JPiyPZhcdLSK/F7hS1hXkl8/bNMD279026aB02HSXlK
 BIfKstkuRSbr5LyIxzT3HoHkrFA8NanLb7euPls8Vh3iWXyoFXzwZ3aMwe//AoPxBZvMomMvjGj
 cnUr/2acZxadzDbPS7B/Y07E6nilhttxUdHGh0n/vMOC0NH8H6MUaymbcR3hPYmve2ipg0lkQK2
 7993XDdxBt/0zwQ1gt248L269WrgX25wyeZNvDSnuTH/FV12c7QvW+PNdkM2jIiCTyQAQJqg==
X-Gm-Gg: ASbGncsZjzTQw3VC72ALyhILz7CHrPd79jqKcJtftLvpDZyRthmdvM4qVz4DiVzuQjF
 n0aV4/Uxy3XYhrc3WQFSzKLZ3UKp4t4twZaqlBarxXLKouIs+IzPbnwsT1HTQTaTEGyiQbojjiY
 SJJKBpeKzyIsFopvwVYSfm6dNrYcCu9m0DXhZ9YqkjOQ7cqOTAGHGhdANu2+xHqfPEqQv4NHGhp
 B696YF5VcaVN0T0BoJ6D2M9qJEX9AwSJg+ggRKSP5s2spkmwM/m0FCnCQ/RWCvldaAyqIXvqFHl
 tb+Q0G7FECRcDLVFR9qRIUyRoqz5RLxhoUmfq1HccZpqNxvgRkOgEo4ZfW3CFCYyECkDAXAuf5C
 M6WD17QvlogD028LQ/iVN59U8iQC0+pEVADxph828pmPZ7IBmaj2oOROKGpPDOp2i6zhwDiOACE
 AdAl9RR64=
X-Google-Smtp-Source: AGHT+IGRFWgPbiK0IL1L4eDByRAn1C/pYMiZUHrR/qHaFQ5p3nROsHyjoqGFWlJcWAxqvMz51XxulR/eHSbN
X-Received: by 2002:a17:90b:4b8e:b0:32d:e309:8d76 with SMTP id
 98e67ed59e1d1-33b516fc477mr11612860a91.10.1760048144705; 
 Thu, 09 Oct 2025 15:15:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b626eab8asm58796a91.8.2025.10.09.15.15.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7fa235e330dso45726106d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048143; x=1760652943; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSha/rHfhVpqMCkemzhzJt9MKBZNA3cJ/ALQp5n7hHk=;
 b=BNSGe+QHXZWTOW+cSiL9468MrXhzFFn9lcAmQPTBE2w5568GnXTR3fLeeitQeJJaDt
 hEX8XlY8we6t5/wcL6Kg4vkrSN9DKQ4MhlDHk82zqTIH4iyMMgwXs6U8/T40FnxWqRlW
 eDgFOisZXsfUllrkicy+YXGHXEApgbl49+JU4=
X-Received: by 2002:a05:6214:1ccf:b0:86c:a297:9c97 with SMTP id
 6a1803df08f44-87a052877b1mr211409646d6.18.1760048142935; 
 Thu, 09 Oct 2025 15:15:42 -0700 (PDT)
X-Received: by 2002:a05:6214:1ccf:b0:86c:a297:9c97 with SMTP id
 6a1803df08f44-87a052877b1mr211409046d6.18.1760048142238; 
 Thu, 09 Oct 2025 15:15:42 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:41 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 19/54] net/bnxt: fix max VFs count for thor2
Date: Thu,  9 Oct 2025 18:10:54 -0400
Message-Id: <20251009221129.28256-20-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

