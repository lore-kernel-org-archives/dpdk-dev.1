Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80395CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:17:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDBE940297;
	Wed, 29 Oct 2025 17:17:58 +0100 (CET)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id 0B9A940150
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:17:58 +0100 (CET)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-3c9a42d6349so154555fac.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754677; x=1762359477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZxPBHD4ONfGrqgOQPscQZB61SGsc7QmNvaWb+9fsf8=;
 b=UExWPCVAF9sUipbbQbyceuKu3NmCrc8OXnAtk3BSzLj64f8MTLyp35/nI6jmT4Fqq8
 GjuWFhbJZr+x+NTlI1c3Ae0ZIKPXg5tro1k5T/ELe+lFP44M+G7iKmu/w4LyMr5O4hu6
 +UFRj5vvVENH2q15/veA33BycEuB9bGJSpM0zcCAJAxaUpbiBe2qs/+bHXd56Vt7BnYz
 G6ckYEfyYMilQ2l2ng/igXlWPvcOOOgryqsAtCbv9Q111T7PkX69LQsRUOrEBoFZlIAJ
 BUqkLep4C5TZStb2QQIAzlOX5wyPl/MxqE8QLYoGRaR1aMl8F9ksdszWolW0HZ6rVOqW
 4UTA==
X-Gm-Message-State: AOJu0YwUoEyBqs3+nNS5DNlYgOH9g6RWA7Piv8i+KA0Fh21jaFNeIfR1
 NKvgl9MNg0ZPKjwvAlb/bknbnerGU9yGcU8N1RIqR/73VWBztRR2O84SCZvhwWLkl/dQO263u8O
 q1HEUxkixcADVQbMIh1k03DOcxhcYTtXYMeXTO6f9uaZoqWgbpuVoyA8vV01K+2BL70N/w6wAz2
 jHH5ATYm+nrX8xy5K0++0MPK1TGTVRmM9zqOfNiO2z14Lywwtoe52qEOYbHoSBeVckJ5sX7A==
X-Gm-Gg: ASbGnctIFDKiA6dXF4dSJvNepe6YIMDRJWfu7N1UENCN646DMgEqgJF17r2c1YZmmVe
 l5ojtdtCBMooAzB6e4F64cxeFPHCz0FP1Z8zOwK4DHhyBbUBRI0mdRtZomKN3mHvOddGPiXpb+2
 MrxK19hL+fql8ZjW/NhKCTVsqfVDmEK7gnrE8cImqCxJMAiQ9A/8mXyCfDqr16zI2oxv9aCfQE2
 d2RJQU/WNVWeWng1qdRAwXnut/6jvulVPkmOmhd68UDv+R1UM70JrdHTuV0+9inhHnjxrJ1qy5V
 S17bVgW5kBAYF4PXEcaeojHaYVtZJZpcKvRCK+tg/FPL4V/3H5s3Cvmjin0gytLvuRVd+beFNJx
 H2wHEWbgUW9PqoZDT8STz6G+94R/so4yuVB68LgO3nl5QlNsKcVfWYBOxkWlwHlsFUuKnZ+YK4D
 HMAo4Fv9oAVtU4UUsSjYP7YikvKirXcFGJkvwm
X-Google-Smtp-Source: AGHT+IG71l+gfVUOMxLzyLP+u4Wg7XkHD5kd9NFc7HBPQEhSg0moL6ux50uohnwQQNMymqDo7zuUR7a3tSIC
X-Received: by 2002:a05:687c:20d3:b0:3d1:b17b:2549 with SMTP id
 586e51a60fabf-3d745d992d2mr1702826fac.15.1761754676065; 
 Wed, 29 Oct 2025 09:17:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e290e020sm1204733fac.7.2025.10.29.09.17.55
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:17:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-86df46fa013so1983703385a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754675; x=1762359475; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZxPBHD4ONfGrqgOQPscQZB61SGsc7QmNvaWb+9fsf8=;
 b=CYCBIpjsFC4Xnwc7T9Q4sSxJMedEOp5GI2XGvmqkKV6P/qnRTntS2hbs3+5JMLcYoA
 y+PsOGrWpeSzmPj9G2YNjIlOHAs8Rg/qWv+tqrVL8Feq3tAXVXzu0a7jDfKJ7gwRGL39
 mtv8u2LOyCa3nyIdg3g5XHi6VoYsTJFh6jQqg=
X-Received: by 2002:a05:620a:46a4:b0:891:d993:1bdb with SMTP id
 af79cd13be357-8a8e6087428mr426780685a.86.1761754674692; 
 Wed, 29 Oct 2025 09:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:891:d993:1bdb with SMTP id
 af79cd13be357-8a8e6087428mr426774685a.86.1761754674070; 
 Wed, 29 Oct 2025 09:17:54 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.17.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:17:53 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v5 24/57] net/bnxt/tf_ulp: Cleanup devargs argument parsing
 code
Date: Wed, 29 Oct 2025 12:06:39 -0400
Message-Id: <20251029160712.58519-25-manish.kurup@broadcom.com>
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

From: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>

For Thor2 if any of the ports are attached on testpmd without
"mpc=1" argument, code flow will not initialize core mpc
structure which can lead to seg fault in bnxt_mpc_send while
accessing tx queues. Adding a NULL conditional check for the
MPC member of the bp structure.

Signed-off-by: Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
---
 drivers/net/bnxt/bnxt_mpc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
index 2582b50782..ff2f0d7043 100644
--- a/drivers/net/bnxt/bnxt_mpc.c
+++ b/drivers/net/bnxt/bnxt_mpc.c
@@ -719,10 +719,20 @@ int bnxt_mpc_send(struct bnxt *bp,
 		  bool batch)
 {
 	int rc;
-	struct bnxt_mpc_txq *mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
+	struct bnxt_mpc_txq *mpc_queue;
 	int retry = BNXT_MPC_RX_RETRY;
 	uint32_t pi = 0;
 
+	/*
+	 * TODO: This condition check is added to avoid
+	 * segmentation fault in case mpc argument is
+	 * missing in dev-args. Fix this by removing
+	 * mpc argument from dev args.
+	 */
+	if (!bp->mpc)
+		return -1;
+	mpc_queue = bp->mpc->mpc_txq[in_msg->chnl_id];
+
 	if (out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_SHORT &&
 	    out_msg->cmp_type != CMPL_BASE_TYPE_MID_PATH_LONG)
 		return -1;
-- 
2.39.5 (Apple Git-154)

