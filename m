Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A489CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28D6440DD3;
	Tue, 30 Sep 2025 09:05:42 +0200 (CEST)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 46935402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:51 +0200 (CEST)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-42d7b620348so1380375ab.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192610; x=1759797410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tG5Na/fogn9Ok5ZrBXJdy+bDvZYRR8UTEo3Vhj9VXlU=;
 b=wN6HwJQzD6ZiBldr8Dg01fHn6c7IiP4CsG92g4nAoU+6luKZsy0i+aXvUIPYCBIHRn
 0HGSbTGAnartRFp09gmvXAmUQwZ25tGU48EwSVbVmCdbj+ORHJaZ9lX6/l0K5Mv8gsRq
 NH6qCMNL47GqjUjS8Vh8RkXed3+Fz5q84wJV5q9r7CxS8BO0ZzTy+6YNroSf3ongwPDb
 k2KJJ3Olkydw96SIE7+cGy+LnwxRUulscxC1J0VqoiHFDCL6VtmCPsSueV9lMwMZBCRO
 b4f+DlVS04TFCW/43IDBBn3jbkHW8fx8vByolEIZhtuMFEH906rjQ3mpgwIx6OqwEPcD
 903w==
X-Gm-Message-State: AOJu0YzLDAd1OWKzmhBZkAcfueSazdQawdMBfSFH35pm8+mqlqHt4GoK
 /wjI+zEIbd0g3HqKIwB+kBbV5E0uo3beBu4Q9+v2GYg6bxp9OMsp815H9p06DiY5MFdr+JpgedG
 T2JEROAaOZx5Ibp+Qc9PvcBgMGAIrBVXDJ1Mz+jFHlmQcDiaMrgVLV99CimvSLu2YYrFEF5R10w
 ZDUso3WPMCU8Uu9B9Ew9VrlTIJPeopt7SJA+35rzEUv0b/cWZPQRJLz7DAIGO2oyfUAUFpNA==
X-Gm-Gg: ASbGncsp/fcYTG2vyq4HkHCLxNqNP9trKfNw+KDRdNm3C4RjFTT4Fm/pphIAiLPAW8l
 yxTTXmSotMA/v0Rw/mvYiGRZ/dCf+8qkmmnNuZvZK9NGI8GvUfoG+5vxODZBLr3LUq0I0f2luDs
 cB/NDLpmdq2ds88/Z9HxC4g2miVblXrHvpHjpXoU7+QSdBP9vA/2V0ipZmRK/V8OlkmIDzv+ryr
 Yh3vZx8YMqCkP9/7xYCTgwXqfper5xaIs/bQ4EyORqs19FVnJtIIky+kbs/w9IzuQNevrofnGKM
 Unb5YtAbxUCer3y7+ZbmzQb+qzN93jo2VnUdcNVd1tkgl70vlJRCVWcZ60zU26vZhIhGitq3JHT
 yPZxbE85ZIQ5undw/Vrnz7D8aBq3N4MSYokn+qyfqauRm1G3bJJ/Bm0m5d16GQ6ZFM2hJrLvBIX
 td0w==
X-Google-Smtp-Source: AGHT+IEMTpLk89ceJMGJ7anInm3Mz5V7iCrtnEuB0mRgdkT3tJ6Q0hb1z9zsr6MHJO17K3zKFuZvFOc4FUnO
X-Received: by 2002:a05:6e02:18c5:b0:424:866:ec6d with SMTP id
 e9e14a558f8ab-425955d4f26mr303803665ab.12.1759192610538; 
 Mon, 29 Sep 2025 17:36:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-56a6430800bsm749907173.1.2025.09.29.17.36.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-77e7808cf4bso3207145b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192607; x=1759797407; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG5Na/fogn9Ok5ZrBXJdy+bDvZYRR8UTEo3Vhj9VXlU=;
 b=XuFG1uWLWYMetkaRWa7i2Tot7lqtcvCJsMXeFNCdP+JJ4eMCqrS9ZUYmQvI0GNWm/O
 iKnjevBmPEcmkfg7US6ooWxxTo8R2yMe76oNeQ0Y3jzP0/yCz3OIkaP9ByF+2TbDX0rd
 tKPvvgnRLiORxkB7fxW5EKsNFljbZkd8r/OOQ=
X-Received: by 2002:a05:6a21:99aa:b0:2e3:dd60:913d with SMTP id
 adf61e73a8af0-2e7c1bc5623mr21844311637.21.1759192607681; 
 Mon, 29 Sep 2025 17:36:47 -0700 (PDT)
X-Received: by 2002:a05:6a21:99aa:b0:2e3:dd60:913d with SMTP id
 adf61e73a8af0-2e7c1bc5623mr21844281637.21.1759192607087; 
 Mon, 29 Sep 2025 17:36:47 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:46 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH 13/54] net/bnxt/tf_ulp: increase shared pool size to 32
Date: Mon, 29 Sep 2025 20:35:23 -0400
Message-Id: <20250930003604.87108-14-manish.kurup@broadcom.com>
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

Increased the shared pool size for table scopes from 8 to 32.
So that 32 instances of application can be created.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 55adceb59f..af3e82a6a7 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -373,7 +373,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
 		if (!BNXT_PF(bp)) {
 			shared = true;
-			max_pools = 8;
+			max_pools = 32;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

