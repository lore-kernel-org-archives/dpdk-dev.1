Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4FCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:08:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7C8A40652;
	Wed, 29 Oct 2025 17:08:08 +0100 (CET)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id CFFAB40652
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:07 +0100 (CET)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so2695ad.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754087; x=1762358887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rdKVlFmqzAxasORQRGenXgj6QBqDBGESOLAMt4N+Qg4=;
 b=XmvncPRf6r3vJ1vieNvGg2B+nb/fSqvv9EtUgV3WGjgcoH6nUr+sF1y5+vVGGQHFKU
 OxM4PoQsc/JfvMo1leiFV6SWY8xncQw21aSj/8RhR4NLw/TBOeism3YFygXFoXnExFK/
 yL66BWMINOydHqM1fLES0Cvol3VliuTfzUOLpN6b1PvCvORVjk5XRTIWEeSRFWUGQWKS
 pFZPQypII95BazQVR0xCE06IpVtH/ssJz9ccxQGKCFM9xSgLvnhNn5AogIgg5TjM5Tb5
 cORxyRlXVA1grwKU1ySy86/W9RNRaU50lQ2/8pBSocf88cBghIZg1D45TROO8/zGt7Fp
 77Hg==
X-Gm-Message-State: AOJu0YzuWjSclexumIbNnHceq4i+XNhZniRI2NlQRYjj6lP7LnbXMDP5
 xj+XiKFZkJQeQUENjOrpGktBbTwESwQ9hqRxVQJy5/o8rXONvgPPqV5hXMSuusqY35Ron/p9fyW
 4fjecjU4Xzb3g36ydJRn3G4Hdw6FmQc4N5PcEjEjffJ66Ez9dJLKWHJfe1XugY3G+Jo5CQ8fi1I
 42NJeEcZEpk9yjY/QzhjJsplXnX4T/Ofxhyed/CmGLtOumo9N3SWI0sod5BS802jSdh5taQA==
X-Gm-Gg: ASbGnctRdqsptIK/NElwjancTw63zlJPTQC+Td090YHz9jWnbV9MWz1U7GigpA0ZBhS
 5y6OFm90t/pTC1AfSpB0/d/U77R3+GZ4NQjpdjXXztv0bQDhX03bDS+sO/vfQm8GHlCt4l8ALAn
 vNK7J/WcvezNF0YYS/alkxAg3qH0Y8J1tAiwwsPI3fcvNGmzDB+9hF1YOAuJ0RrsRRJbU+nY0Jr
 vPTT130gx6hMpA78ox42le8BZXW4/OWzC1eXQGFQExqGlPUuTSfA8DFZUCZAoSBj1dMLV9/m9gv
 fz4P8jnFKBs8cNvdifjqRvg0BqVrPLvkko4/YMTMX11i7OIhAVoOvAZbq31oxvebKqEahJdG0kX
 FNxIIfhBIb6QODQqXNTPhisgaipJiS+/f6OR3P0+jG2lkKj6pBLVf/8oX0zCCuygm++6+QjYDtI
 t85HFsKb+8A6c1emW6b7byaKEsHZx2hjM=
X-Google-Smtp-Source: AGHT+IERMmTJyyb03Z9UvfXukAt9EWnYccu8UxtYg1wkmv+lS5UHGtdMmHPtkwX6g4X0B+mbZ9GLx0DwGvL4
X-Received: by 2002:a17:902:e748:b0:266:9c1a:6def with SMTP id
 d9443c01a7336-294de9fc43dmr42029895ad.0.1761754086396; 
 Wed, 29 Oct 2025 09:08:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498d098dfsm13860115ad.15.2025.10.29.09.08.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a6fc271d46so782967385a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754085; x=1762358885; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdKVlFmqzAxasORQRGenXgj6QBqDBGESOLAMt4N+Qg4=;
 b=AIigzGwd6Fh+LKaLdrmJz9aSbP49+Vz1SpZgTlDEvPMkPRAMNcyl+tEXkAL8yTz6aU
 CiSpqttHAkg7gbYwCB+FUwRKCpOKVgEwU5KKDNyVgWZfDJV9oNhrcFbwhHSGZyFi+7V2
 K4LPWREAMaSxcceVLoe3AM2b6adu91LDZ2uCM=
X-Received: by 2002:a05:620a:2a06:b0:89f:52d:856b with SMTP id
 af79cd13be357-8a8e6c499eemr457393185a.87.1761754084734; 
 Wed, 29 Oct 2025 09:08:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2a06:b0:89f:52d:856b with SMTP id
 af79cd13be357-8a8e6c499eemr457386885a.87.1761754084135; 
 Wed, 29 Oct 2025 09:08:04 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:03 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v5 05/57] net/bnxt: bnxt_rep functions cleanup
Date: Wed, 29 Oct 2025 12:06:20 -0400
Message-Id: <20251029160712.58519-6-manish.kurup@broadcom.com>
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

From: Jay Ding <jay.ding@broadcom.com>

There are some changes made in the 23.11 upstream function
rte_eth_dev_release_port(). The library now sets "eth_dev->data = NULL"
at the end of the routine. This causes a NULL pointer dereference in the
bnxt_rep_link_update_op() and bnxt_vfr_free() routines when it tries to
access the parent dev.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/bnxt_reps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_reps.c b/drivers/net/bnxt/bnxt_reps.c
index bc34e839da..a216aab14e 100644
--- a/drivers/net/bnxt/bnxt_reps.c
+++ b/drivers/net/bnxt/bnxt_reps.c
@@ -299,10 +299,10 @@ int bnxt_rep_link_update_op(struct rte_eth_dev *eth_dev, int wait_to_compl)
 	struct rte_eth_link *link;
 	int rc;
 
-	parent_bp = rep->parent_dev->data->dev_private;
-	if (!parent_bp)
+	if (!bnxt_rep_check_parent(rep))
 		return 0;
 
+	parent_bp = rep->parent_dev->data->dev_private;
 	rc = bnxt_link_update_op(parent_bp->eth_dev, wait_to_compl);
 
 	/* Link state. Inherited from PF or trusted VF */
@@ -542,7 +542,7 @@ static int bnxt_vfr_free(struct bnxt_representor *vfr)
 
 	if (!bnxt_rep_check_parent(vfr)) {
 		PMD_DRV_LOG_LINE(DEBUG, "BNXT Port:%d VFR already freed",
-			    vfr->dpdk_port_id);
+				 vfr->dpdk_port_id);
 		return 0;
 	}
 	parent_bp = vfr->parent_dev->data->dev_private;
-- 
2.39.5 (Apple Git-154)

