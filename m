Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF66606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=EhcyIyHO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86AC340A6F;
	Tue, 20 Oct 2026 09:00:09 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id BFEAD40270
 for <dev@dpdk.org>; Tue, 20 Oct 2026 09:00:04 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso23643195ad.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 00:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479604; x=1793084404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMGtvxydfI/46C8Cq36l8kgyT3XFaxs9hCTvFXpcUFc=;
 b=mKWY8aYgyOl2U7z9XroyAVccpwd9BswhIl38qOzv4Wn2ZI6z1K6uKzx437gz3OjyuV
 P9fGiR9Sb4YI0k4QWDmYZ8Z+Nrty8WHcwNDYpho9CGqnUbwsTMl4DvQkt1ySkNVU+Nno
 1J3bpJ6TuHcDdRC53ZkdmBZJDDK6z0lILBl9t/Pqk2wh5qjsyq+grlJQcd7+bfmYDR/J
 Zmq4FhX4jkcnyjPKKoiXSC8qRIplz4t4jokN1/wCBpBcTSmo5iYmRS7Y+oP5Avvki4+r
 BS3RGVmI8e8EYyeDuKvyGOdd7YjWg4D+JWEpwl984jym95Y6N5YCATpnBMuAOvj6B2H0
 SV2g==
X-Gm-Message-State: AFq9FYLwMjDdpR6Z+1MOaIjs6UUojf0Hp5v/37Dhi9+fRZUu6l61i4W7
 BbIx5Yef9HiBNPVue9CpoWUsfL/iQNFLdLOBVF7ZsPNCJ2MFJtTRi1nT+CSYStILPNOudl8qevt
 zkdglP7J9gfat+fNg2I/VwsOZTKtSq86s8uAOPwZewGstiHB/5k3JuL5JtAFfUkVzeQoHs+5kjC
 QFoBBkT9gIbxwMdRXJ8XU3Gg0TidVogS00cLL8Ghr/6kBd19ycsHH02oNSnZCd5viUoWmEHg==
X-Gm-Gg: AYBFou2UvDsh18ZagBkZEilCMPpzqzTi+RX355HmFQX+NQYOFB8J08bQqlVIi1qyko8
 2FjTbDlEtFPzw+8ZKuHcFlCi/AVN6DDrjJ+dDQJ0PckEFX0oTQcZk979fiEIbepWcNjYDYG1CMp
 F4bhpAHhhQFq6wC5btMafu2gGFZnnfbk3NUHJF6Yh74IKZRB1DqF/b6ffRuKUYpXoCxgtM9efYO
 z99hNnKfpqa/3il/Yl+fLgS+ZwPl8M7r5xd8KOFbzyp6NhznVHltWeglIr/FgI5T3AZ/u2fkiOh
 U0GCbFIaayl0Co/T8QNJlTgbbYjKQ1+9yo0Rwsa3FLLoLaoNfrY2SI9n/k+vlW3OAkvFE/9WasS
 XBCIFbJ+cBF7rWG/HtJkATm2NPzqC0HvcG3drhWwkVVZtBlvOpCxYuTxi3x9Z55mRL1TL/K6blw
 68cxOZh5vD5acQbWLOx+HsmlQuVjhZPF2zLXDrGA==
X-Received: by 2002:a17:90b:5487:b0:3ac:9c37:9426 with SMTP id
 98e67ed59e1d1-3acef0c8743mr9474964a91.31.1792479603831; 
 Tue, 20 Oct 2026 00:00:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ad676aa71csm980849a91.6.2026.10.20.00.00.03
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Oct 2026 00:00:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-18eb2616974so165940c88.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479602; x=1793084402; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMGtvxydfI/46C8Cq36l8kgyT3XFaxs9hCTvFXpcUFc=;
 b=EhcyIyHO8YSR6lRuwhFBuZn9352XC8NrS1sxG/hX/owMs8OSOkKhxXlWDiIafjcURG
 Eq+blFR2U7ZcMEdPROyicm7azpp+xvhmq8YSCdXPGwqqDFzDdXYAOBqnb9LUqWltlwhG
 sKLXAJ7twMyg8Lmjuy7DyNIBt9tgCOc8JRbBk=
X-Received: by 2002:a05:7022:e883:b0:18c:e014:6f1d with SMTP id
 a92af1059eb24-18ce0146febmr3814355c88.1.1792479602164; 
 Tue, 20 Oct 2026 00:00:02 -0700 (PDT)
X-Received: by 2002:a05:7022:e883:b0:18c:e014:6f1d with SMTP id
 a92af1059eb24-18ce0146febmr3814298c88.1.1792479601383; 
 Tue, 20 Oct 2026 00:00:01 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831996071csm34842790c88.9.2026.10.19.23.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 00:00:00 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, farah.smith@broadcom.com, stable@dpdk.org
Subject: [PATCH v2] net/bnxt/tf_core: fix TPM pool create error return
Date: Tue, 20 Oct 2026 01:59:57 -0500
Message-Id: <20261020065957.1068206-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005151720.1706054-1-manish.kurup@broadcom.com>
References: <20261005151720.1706054-1-manish.kurup@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tbl_scope_pools_create() can return success after a failure. When
rte_zmalloc() fails for a pool manager, rc is still 0 from the
previous step, so the function jumps to cleanup and returns 0. For
the other failures, the cleanup loop assigns the results of
cfa_tim_tpm_inst_get() and cfa_tim_tpm_inst_set() to rc, replacing
the error that caused the cleanup.

Callers then carry on with a table scope that has no pool managers.

Return -ENOMEM when the allocation fails, and keep the original
error across the cleanup.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Split out of "net/bnxt: fix multiple truflow defects" (one fix per
  patch); this is the tbl_scope_pools_create() error return fix.
* Dropped the tpms[][] = NULL change, which was a no-op. Fix the actual
  problem instead: the function could return success after a failure.
* Rewrote the commit message.

 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 0a5dce43fa..a761d9bdeb 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -574,6 +574,7 @@ static int tbl_scope_pools_create(struct tfc *tfcp, uint8_t tsid,
 				  struct tbl_scope_pools_create_parms *parms)
 {
 	int rc;
+	int err;
 	int dir;
 	enum cfa_region_type region;
 	uint32_t tpm_db_size;
@@ -614,8 +615,10 @@ static int tbl_scope_pools_create(struct tfc *tfcp, uint8_t tsid,
 	for (region = 0; region < CFA_REGION_TYPE_MAX; region++) {
 		for (dir = 0; dir < CFA_DIR_MAX; dir++) {
 			tpms[dir][region] = rte_zmalloc("TPM", tpm_db_size, 0);
-			if (tpms[dir][region] == NULL)
+			if (tpms[dir][region] == NULL) {
+				rc = -ENOMEM;
 				goto cleanup;
+			}
 
 			rc = cfa_tpm_open(tpms[dir][region], tpm_db_size, parms->max_pools);
 			if (rc)
@@ -637,6 +640,8 @@ static int tbl_scope_pools_create(struct tfc *tfcp, uint8_t tsid,
 	return rc;
 
  cleanup:
+	/* Keep the error that got us here; the calls below overwrite rc */
+	err = rc;
 	if (tim) {
 		for (region = 0; region < CFA_REGION_TYPE_MAX; region++) {
 			for (dir = 0; dir < CFA_DIR_MAX; dir++) {
@@ -666,7 +671,7 @@ static int tbl_scope_pools_create(struct tfc *tfcp, uint8_t tsid,
 		}
 	}
 
-	return rc;
+	return err;
 }
 
 /**
-- 
2.31.1

