Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D463BC982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F17640E4C;
	Mon, 21 Sep 2026 04:17:08 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id CFCBB40291
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:17:04 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so652756a91.2
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957024; x=1790561824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uF+BcsQsd5BPXnZ5by6cN1lP7pM14JDeynW+GnrK35U=;
 b=vQqtgm2uX2nrGHk5oB1ISWJ+lF1d8Woq0dADmgXI1R6EL7mZ+9mZLymCIe1jbky8Y4
 soMz9rgbFVrr/E5GsLn7TlLQoBz7HtXc/u1phuWoe3qVEManov41gcFRJOA2VxkUdQVc
 mE5eIVDPdAUv1cd0xPzLBacve45Enf4OfbFVotsBWuheOMopzaBDYD971/JbQ7eXFXow
 Yy6SEtncwU67uX9Dxi7v3TCSycRt2QGkLo4bBLQdgFag3PvfhxVwknN9mJFhLKkelZwU
 H/PZIIx4+fGQJSvLIk3uRQf1imD//nfes/d0Ujcq/014Y2G+CxM4s5h1mDdTZpU/4cHx
 Mt7A==
X-Gm-Message-State: AFuF++lZAR9Pta9x1T4QxBgO51RoaXKClDrMFKa6Ae2GWfiwwje1xDUA
 f/W9TRQrYbu/Pwdy1Hf4t/FmH4wqczXCKpEezSxbZUnFrZEOhU2pB0sqdkmE3GwZS3qylfV7Mfg
 etjq1/WsR/ntxdzP5Nk7+DOxMhUo9tTmVk/BmulBOaxg6jDpQX3yGvtcicvra5ajvJJXHFMsmsu
 QZZGM7saR1f1yKvnHlawcC31ql0cyPTOGNzXEpDUWYJ0L1fecZeBAdnc8ASBTyzuxik9pQ62KH0
 eON6LXo0Djg
X-Gm-Gg: AYBFou2rCfNVDvAdX5947uzslwAqZ4dFLVfuySTRB+S4fxb7A8PWVX+DY0cYIhQAOfQ
 w0HH1D3vyWdv3Q4pztk019Z2hqxG9sAtTApUhgVvGl+4/voT6gN74zGyrrBt0PTq5052k3Axr0D
 9PGfBQSxhJgrDJ7X92sIZmTAjDDnuKcjnBNuOp/eEFWADBRAukyb3o8TCtXAcOAHGFg889Zfzld
 pKI2zSKJDT+V/QE2xUyaJbZfJs7nrdlnqhzzimis5FSG0dZ2BnwJ+TqCeDnY1V3MMlOIumMgZAK
 Tkjc96QAOsgjP0txaaHqQicpXJHXTtTiIGAULcYmkKQf86IrOfTXvmj5DKoaiRmQ7V8YOMmuK5Y
 sNbJsDB2AXmqeCNjVwi3fHLIb/8zKbFHuoTaoo6d6tK4yWfhQZNuB/tOqwRZkss+t3+KwqEjxO4
 gAhfpPXQgiB0Dg4solM+1/7wjP/mftbdmxz+HEnyX/Ech6ekVZYg==
X-Received: by 2002:a17:90b:448e:b0:3a0:22bd:6ee5 with SMTP id
 98e67ed59e1d1-3a022bd8582mr6880689a91.14.1789957023770; 
 Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a02de1d995sm3202304a91.5.2026.09.20.19.17.03
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc4fc935a11so2155264a12.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957022; x=1790561822; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uF+BcsQsd5BPXnZ5by6cN1lP7pM14JDeynW+GnrK35U=;
 b=T5x9Aa9EAyR/pDjuiFzpn+b/dpgZqsixnLaoEUfgm1JGvxki/cordAVirWRzoxZw54
 0suuVhQNc6B9WT8LcRWE0kxEVd8RloZTMmbpn2AjbE03PNhe+9XbmFrW9cu7vC582Ldn
 mmQ7FATuK3QjHpz28qh5SbPa6W2A0A/DVQq8k=
X-Received: by 2002:a17:90b:1a8d:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-39e6a810c60mr8448029a91.36.1789957021948; 
 Sun, 20 Sep 2026 19:17:01 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8d:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-39e6a810c60mr8448003a91.36.1789957021336; 
 Sun, 20 Sep 2026 19:17:01 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm18536753eec.30.2026.09.20.19.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:17:00 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v2 3/5] net/bnxt: fix use-after-free in VNIC filter cleanup
Date: Sun, 20 Sep 2026 20:20:00 -0600
Message-ID: <20260921022002.1033815-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

STAILQ_FOREACH()'s own advance step dereferences the current node's
next field after the loop body runs. The loop body here frees that
same node (bnxt_free_filter()) before the macro dereferences it on
the next iteration, so the filter list walk in
bnxt_clear_hwrm_vnic_filters() reads freed memory to find the
following entry.

Walk the list with STAILQ_FIRST()/STAILQ_REMOVE_HEAD() instead,
removing each filter from the list before freeing it so nothing is
dereferenced after being freed.

Fixes: 20ef524432dd ("net/bnxt: set L2 filters")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 765aa7c452..99539d3705 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -3593,9 +3593,10 @@ bnxt_clear_hwrm_vnic_filters(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	struct bnxt_filter_info *filter;
 	int rc = 0;
 
-	STAILQ_FOREACH(filter, &vnic->filter, next) {
+	while (!STAILQ_EMPTY(&vnic->filter)) {
+		filter = STAILQ_FIRST(&vnic->filter);
 		rc = bnxt_clear_one_vnic_filter(bp, filter);
-		STAILQ_REMOVE(&vnic->filter, filter, bnxt_filter_info, next);
+		STAILQ_REMOVE_HEAD(&vnic->filter, next);
 		bnxt_free_filter(bp, filter);
 	}
 	return rc;
-- 
2.47.3

