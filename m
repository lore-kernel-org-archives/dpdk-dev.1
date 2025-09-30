Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C29CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4677D40A7F;
	Tue, 30 Sep 2025 09:05:15 +0200 (CEST)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 28095402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:39 +0200 (CEST)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-b553412a19bso3767454a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192598; x=1759797398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wMqWzkpqP9CDU6QHvkbsbsQCjyfYfkeAC+XgnmyMsa0=;
 b=R1X1Cav3b22trmRMtOI5Nq2UFJsoc64JF/WqZqP50oPhCIjSW7oC6/mu1gk5yq06ke
 f06qClRCnbhWTHQsCBFrG9z+4ag9/WRUjVz2A28N1DZmdW6UqqIFDgieOJVldnBf6Ifw
 tYTiwYnIKzHp6Rec6RIOXUAoL7xGs1P0W/4AaagdAaswsorUEhoX1QVVxaI97gN6Xw68
 OJu5mNzddgPc+9TezOsWjCDNcy9NTGT8MZM7Fa4f0aOtIetAHlLrn7Oyspw49LGDbbKA
 t77gw3yhblgfoK996vIQMrTVVmDhKWmbp5iQq4d7JDP2bFVLHU+t8ve9e6b8P+bXbAPW
 +gaA==
X-Gm-Message-State: AOJu0Yx2yk0+P1VYdfsc6E7Pc2xcxkBOqrXzHDs534ExGl4R4RJEWce1
 i0caJDXwn8FswYjLI3eubvd1Ola9ROLNRFFyXVWk23+Od6J5l5dpDnT5Tq2dAMpOzBjOw3mP1Wq
 sEgqPYkuow8iQUuqCygGoiDYQRnAOKlSBktJ6hqULgbl0n+w/c20LU21Upp7A5wygtTwsBHGmwW
 HiUEsu8JkMSnw69jtTdUVGr77mnmh8Bkl/uDbp5KhNEfSuMIxXFAP1fCNkrTBAL7kzkbMbcA==
X-Gm-Gg: ASbGnctK7HqUMG3N2JUXPLjMS3/XN/jayng5NZaLwfgjO5QTk7baivH6rSyrJT6dZJb
 oISvl8ba9tEL2diL1uEL2BCxSFVUhRJkB5xdVO1Pjg8PX/hvoKG3WosgCDycQQYikYQ4PdIGmjv
 ZOMZK95qu+s439B8kZZ83l1SM7PqktFFUoJxHz1sA+bujcn8a4WiXpbGgm8udGEkXACbcki5OPa
 0mEGRnQz2lLdcw4DAt/lNCoMOkfrwYUEBNMRRlZjYv0bQH0woMPEraT/+dx8+bNz5zQnXcOKFoE
 9jHTgXE3lxvP/yFqUBTtlQjJ9h4tAQ9Jwrkt8fhK3hxch0qYQ2TVJgabnOE1RqikgOmt2pt+C0F
 RVe0xeqeluN7EsakIzC/ZCTF90Ic8i+wATJVnTFHxUTWGL+B9xL7gRYFKzhGv4DaoYDFnlpcEaV
 64HXSFQCw=
X-Google-Smtp-Source: AGHT+IF2px9X5zh7Gkxnqa2SBpgLNA7kC5bS6Ad/aVP2doVJWKyCfXfxG4bdPSKGjDjZFPNgxr8B2fnwYtmd
X-Received: by 2002:a17:902:e54b:b0:26d:e984:8157 with SMTP id
 d9443c01a7336-27ed4a08e9emr176206165ad.8.1759192598250; 
 Mon, 29 Sep 2025 17:36:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27eec81e1f8sm8635725ad.50.2025.09.29.17.36.37
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77e7808cf4bso3206978b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192596; x=1759797396; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMqWzkpqP9CDU6QHvkbsbsQCjyfYfkeAC+XgnmyMsa0=;
 b=C92JXTfy14TAcrCUHPe1MImWbaP+H9JHPQbr5MxEA1H2eSLeJeebajwDoRVUU9nmAZ
 0pvXbtd5L/2xCFHuf+2uX3/+XMvNpUlPJPIahfQZU5DuhYeokyxGHTjDMgBoWb6i272d
 Jaep4QXyW+8L7HqoBWWtFaMqqUDktwWntO5Os=
X-Received: by 2002:a05:6a21:6d98:b0:2b5:9c2:c579 with SMTP id
 adf61e73a8af0-2e7d37f2d92mr22302872637.54.1759192596259; 
 Mon, 29 Sep 2025 17:36:36 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d98:b0:2b5:9c2:c579 with SMTP id
 adf61e73a8af0-2e7d37f2d92mr22302830637.54.1759192595534; 
 Mon, 29 Sep 2025 17:36:35 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:35 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 06/54] net/bnxt/tf_core: fix the miscalculation of the lkup
 table pool
Date: Mon, 29 Sep 2025 20:35:16 -0400
Message-Id: <20250930003604.87108-7-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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

From: Jay Ding <jay.ding@broadcom.com>

The size of the lkup table pool should include the static
bucket. The miscalculation casues crash with big number of
offloaded flows.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 10149a3963..88863ed6ad 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -941,8 +941,7 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 			break;
 
 		rc = calc_pool_sz_exp(&parms->lkup_pool_sz_exp[dir],
-				      parms->lkup_rec_cnt[dir] -
-				      (1 << parms->static_bucket_cnt_exp[dir]),
+				      parms->lkup_rec_cnt[dir],
 				      parms->max_pools);
 		if (rc)
 			break;
@@ -1290,6 +1289,7 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 					valid, parms->max_pools);
 		}
 	}
+
 	return rc;
 cleanup:
 	for (dir = 0; dir < CFA_DIR_MAX; dir++) {
@@ -1632,7 +1632,7 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 				goto cleanup;
 			}
 			/* Create lkup pool CMM instance */
-			qparms.max_records = mem_cfg.rec_cnt;
+			qparms.max_records = mem_cfg.rec_cnt - mem_cfg.lkup_rec_start_offset;
 			qparms.max_contig_records = pi.lkup_max_contig_rec;
 			rc = cfa_mm_query(&qparms);
 			if (rc != 0) {
@@ -1653,7 +1653,8 @@ int tfc_tbl_scope_cpm_alloc(struct tfc *tfcp, uint8_t tsid,
 			/* override the record size since a single pool because
 			 * pool_sz_exp is 0 in this case
 			 */
-			tfc_cpm_set_pool_size(pi.lkup_cpm, mem_cfg.rec_cnt);
+			tfc_cpm_set_pool_size(pi.lkup_cpm,
+					      mem_cfg.rec_cnt - mem_cfg.lkup_rec_start_offset);
 
 			/* Store CMM instance in the CPM for pool_id 0 */
 			rc = tfc_cpm_set_cmm_inst(pi.lkup_cpm, pool_id, cmm_lkup);
-- 
2.39.5 (Apple Git-154)

