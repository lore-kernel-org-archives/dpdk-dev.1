Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58C606A320
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=U89aNKzY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0626E406B4;
	Tue, 20 Oct 2026 09:00:05 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id A229D4067C
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:59:56 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2e608cd460eso16043385ad.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479596; x=1793084396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sTvTsAOLLDw5LO4GGIUQlHZGpsGBw1rfB+aUMX4qPO4=;
 b=pU2vNRa2H2OirRG2SKFRYF0IcJzgusqaWO92WKCDZPnmd84fF6y++kOGAAXuluya8E
 1Rt9m86poVEcLJP2zjMqwPXxmYIU/JQcVoM+qkAb7Jg3DiOF1k6MOVz+JA/KtdgOgJPw
 aRxDhtms0T2e5JFW5bUhEchSUNoEhTBQsOvhZVCLIzlpVCRYbzS52kHMLJSPZHd7vqly
 3Ab8wxnxJlZtB+Ow+DKfsJUlvdgLemF+w6umKW8bemzU9oPJf2DwuVmt1CJxAk1KVz5S
 16gfpWlIFBWOloMUwUCki6yJmp0u5TX0xCVJgzgsKXn4tQBV7C79YaJPxJ6N44yoeiYX
 kY+w==
X-Gm-Message-State: AFq9FYJZLxpHC4DXB1oRuTZKdRX2wFPiJTjUpiItLiKUovPc28upCkPj
 2LDNEogI3TzGtHTTsnCLDRc/c8pB1O5sZ9jOLlblVDpWXjQTlTbRmAURDcKGXQLx3xwYPzJtZ+B
 hWfSWsyJX0WnbaX900Cj/o61GcmUbdVdJoK2wC8v79Pt/NL6hn+MmPV0igGzL6+jUufv2ej/k40
 RMu1wROipMDUDmPJPQChU1uGvtqgsLhs1zalLYjZ/aTQepQjm40OZ5YarOVPgOM7HXqvtcTw==
X-Gm-Gg: AYBFou11Vns99pVPpgCW+0mgT3p9Y25oyF/m6gdKXm0NtMgEjUNTEXNHnjPlf7xb2j7
 bUt/Ugqa0mcwAhAmNIxSon3Z/0ZkqlD6HEB9emuw07ZFHKXEXYA79fUxadKgvNsUuZecWDUCXE1
 2nnxOnBdpmvUH/KvlX240NzLKZWVUE2EgdSXVGdrfENGTixWP7CZxhAwFCU4m1bPJ3O1uSVKpaX
 Dhpvfp4I4xa8pE1odNwImWmDS1cNqqQ8cu3IzMmKdMd5Zvt9pVktoxeogReeQE3HzMbkJyZcj2T
 5KG5wRKGWMZk9aIpjPwAsYuGYb1DpI2tU0RTGvweLjzm9LgtdTZnYhPDgwQFpRn1WCF8WYJ3IRc
 ByKtnQ8Tyng6q/PO1LRKNutV0UR/434LysqGGNEMw/sFwjyNiV49sb2FR244SrHJ5qzGw2LezK8
 4GUDldr7tfO7/wtTIhrHPeyATHxmlIy7V4zO08mA==
X-Received: by 2002:a17:90b:3b8e:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3aceebc55efmr7705240a91.16.1792479595659; 
 Mon, 19 Oct 2026 23:59:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ad273c2779sm1947589a91.5.2026.10.19.23.59.55
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:59:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb6391e89so661083785a.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479594; x=1793084394; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sTvTsAOLLDw5LO4GGIUQlHZGpsGBw1rfB+aUMX4qPO4=;
 b=U89aNKzYQuS4d0hexq3OfRoebOgkzu0YhPul9wh4myqsEhn4LDglYEdN8nlXF9kLgJ
 6mcyr/PWv2ZsewlNCpVjnnwPaJh/QRTT9vae/UGwIJ0X4XzG1cHzGx5joNmsmiWsjX+6
 GMfLuaYREcWoJZPWSdRPZPBZ3Xov1FykNsH4c=
X-Received: by 2002:a05:620a:4416:b0:93b:d79a:c462 with SMTP id
 af79cd13be357-93f29d95c80mr1591881385a.58.1792479594321; 
 Mon, 19 Oct 2026 23:59:54 -0700 (PDT)
X-Received: by 2002:a05:620a:4416:b0:93b:d79a:c462 with SMTP id
 af79cd13be357-93f29d95c80mr1591879385a.58.1792479593720; 
 Mon, 19 Oct 2026 23:59:53 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f4b058148sm154028885a.14.2026.10.19.23.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:59:53 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH v2] net/bnxt/tf_ulp: check EM key pad result
Date: Tue, 20 Oct 2026 01:59:51 -0500
Message-Id: <20261020065951.1068097-1-manish.kurup@broadcom.com>
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

ulp_mapper_tfc_em_tbl_process() pads the EM key to a record boundary
with ulp_blob_pad_push() but ignores its return value. The function
returns -1 and leaves the write index unchanged when the requested
pad does not fit in the blob, so with a long dynamic key the key was
used without its padding. The key length computed afterwards, and the
position at which the result is appended, are then wrong, and a
malformed EM entry is sent to the hardware.

Check the return value and fail the flow with -EINVAL, as the other
ulp_blob_pad_push() callers in the mapper already do.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Split out of "net/bnxt: fix multiple truflow defects" (one fix per
  patch); this is the EM key pad check in ulp_mapper_tfc.c.
* Rewrote the commit message: ulp_blob_pad_push() does not overrun the
  blob, it fails without advancing the write index, and the failure
  was being ignored.
* Use unlikely() and BNXT_DRV_DBG() like the rest of the file.

 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 2cba6fffa8..7ace08838f 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -519,7 +519,10 @@ ulp_mapper_tfc_em_tbl_process(struct bnxt_ulp_mapper_parms *parms,
 		align_len_bits = dparms->em_blk_align_bits - key_len;
 	}
 
-	ulp_blob_pad_push(&key, align_len_bits);
+	if (unlikely(ulp_blob_pad_push(&key, align_len_bits) < 0)) {
+		BNXT_DRV_DBG(ERR, "Failed to pad EM key\n");
+		return -EINVAL;
+	}
 	key_len = ULP_BITS_2_BYTE(ulp_blob_data_len_get(&key));
 	ulp_blob_perform_byte_reverse(&key, key_len);
 	/* Create the result data blob */
-- 
2.31.1

