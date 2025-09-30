Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA131CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1316A40ED3;
	Tue, 30 Sep 2025 09:06:18 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id D20F9402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:34 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-7a97ed209cfso46763736d6.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192654; x=1759797454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=U+ulww2RB/3mKKHm91JNFbKwB+NQTJnVMzxvvLH4MZXZoRO8O/tddMCX5/KQsAmfAi
 CJ0NzJpjm2QZZCatpVbTJVoer4z+DZI3ZPhdp2JauoHMh2alSMmh2mww7fLHnVzDD6no
 wx3wijPGdWylIoEQ8Ji0OeWBdEGv0d1JWjeW+3o9tw3ErqQL598M+X6yjjtQHajTPbWU
 lOTFW7hwSjaSzB7vEtivE6GKxrWtdURnS009yySO8s5dVqHAQnjofqNvh+GqxGLj4EG6
 AdR5ciJOp2MrEsPGxn+5J6eUQ8TIoVesB1CNV0/WM3Ve5ihZtTUz+Rn2tF51vHQl/xKK
 KtvA==
X-Gm-Message-State: AOJu0YzNReLA8sl6xYJ04yULeVFV65uzZiMal9YsYGaFMCEXR72hU1Cx
 9VBxY+5W1KGlfzaekG8tLL3DYlwK9MinhH+gvbHxPF7icMPKn1DDNSM1dqMcLENCMaydbwXX3LD
 cW6xxg5jVklowrAgOC6VnQoA7lISQAn2rIQu26ZownKN/08lN1o6HMgiY3yYtcATXp6v0DzGpqm
 Li2BmYA78VadmsvKAyO3ioFhh2j5ldPilQSzilnZETK3pnuQJnLiwghTf0xefqX+6VHoDLxg==
X-Gm-Gg: ASbGncsSMNaYYEaxBAJlQOs1Z2/hJqEh+mDXXnnCWS12TlmC1T1OuZ5m/8RV8nj5ZGV
 sSckfEHHYV7IMxZIe3T1pBeSyNfaYtfmeCKb5yu+GN1upVhDD3wBbnBAk/4LfwkO0bYnKiEwVaz
 Vz0FwguCo3RBeP65YP/UW9oB7E3FLIDCvG/pfe3yJGubnmyHXWLOonk4GbB8PNDr1V4V0leuInu
 kdoawCZTzRMtI8X5ltEWVH+FHyFEb3bGgAC6Jr5oP6xUxXLxblHYq2d4lxD8Omp9N5MBxXsX1rN
 ii7mk9LgoaFY2OACvmnFK/qgaiUs+2hknSohIxUoBHL0XqgVj0xLIldC+KKwIgmj3YP8TTJhoel
 72xB9RglNGE8TT18AFxHv4k3PS+qX8oRqVYZ+5qIi1b3luLrh3TaiFCVtSkzrkNEjnAwyXngxeB
 asNQaflJ8=
X-Google-Smtp-Source: AGHT+IHQpIkavQJ+usXf/8Ca1CYEVNKMGTel6cjOCsP58NFUUyUESHarfmckug2kIt7tqKCZIfG3y4NHAhXC
X-Received: by 2002:a05:6214:224d:b0:79b:2d66:6888 with SMTP id
 6a1803df08f44-869afd4cbb8mr33229606d6.29.1759192654160; 
 Mon, 29 Sep 2025 17:37:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-801325cb121sm9079526d6.6.2025.09.29.17.37.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b55443b4110so3456206a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192652; x=1759797452; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=TfPUyvrBFcv4Umvq0ijsKBdoAUgNkU+q6zq5GB2mQMIAjTSYPXIDgAUz+kMroW7yiV
 9KTqgDvNayicQWfZC7cIsISq+EEcmV28mXyVYm7lTITkJGOf8f9CiA7BEU2M3tZPS2s7
 P1OkAwQ4NxT/9jd7xVNOoPfeh+8UWBITGyTqc=
X-Received: by 2002:a05:6a21:3296:b0:2b5:9c2:c584 with SMTP id
 adf61e73a8af0-31772a179dcmr2757744637.26.1759192652528; 
 Mon, 29 Sep 2025 17:37:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:3296:b0:2b5:9c2:c584 with SMTP id
 adf61e73a8af0-31772a179dcmr2757713637.26.1759192651964; 
 Mon, 29 Sep 2025 17:37:31 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:31 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 41/54] net/bnxt: fix rss configuration when set to none
Date: Mon, 29 Sep 2025 20:35:51 -0400
Message-Id: <20250930003604.87108-42-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

