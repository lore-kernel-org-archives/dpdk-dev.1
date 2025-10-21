Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D94CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:53:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0A7B40E5E;
	Tue, 21 Oct 2025 19:52:59 +0200 (CEST)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by mails.dpdk.org (Postfix) with ESMTP id 7980E40ED9
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:56 +0200 (CEST)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-8909f01bd00so673159985a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069176; x=1761673976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=u3v3jh/0GjIM9ipb3KzrPwkap6ER4xAv34bvCu4peBanvYJoaQlbcnwDG8FIvcLBfG
 sWOXwh78HOPsmLhgAGA3H6RfskwALcOihQ0AC1+B1ZubRVxhgn99cte9epaOfOdT0Sd0
 MhcfvHwONBLrcgH3nOInvUMjKXPZ1n57ULDRib9pQieHqpHGOMDnlCmCqquhm/HTIfXR
 lJ5ERwHetrdv3evnBagkAyfaKZ6+cW/VJmaB4O1eeoAHZkE0Ybni05wcWIw4nfWnZNG7
 TJ2eu3lG04pF93FP3uk2NHmt/p+95fMLJGFAYrv1Rp/hLUF486+O5Z9QqKZsKltTPKCP
 I+xg==
X-Gm-Message-State: AOJu0Yyqq9kQZ7qfdf+BNX0FP7A06rAmDJ4Y83fgcsXpFECh37BM9xmI
 0fbAptA5sTrKyAf6BPSjuJKR/Wz52PGEWYVEp1CblN5S+nu/rLYJE7fN/bxrdmnJjUFbSzpF8Km
 vWxrhSNn2/p4NBzXeIy8mSU4rG3VxllVtFDemDPVpXE1atu2B+DyDUqGcjAP4CVeWurljEv2L3R
 To5T9AMLp55aUZQTAWbFpU5NtNvrJpXVpcdt3nZ3B6F/qYHqRYHOSOx9OxtdumRq3ZqOmqfw==
X-Gm-Gg: ASbGncs6G5uGPu258bNau0kDST/8wo8G0AjW6aAw/BjHKwUfpu6RtIv36e0Uns682eV
 Azs0DLRr8TfIUMRlMGsQjVPemka7xydRnnI/Apads9nIh/P0qh4jgq2PKOjwD96kfMXU9Nup6mw
 jc4+QI1tj+D0VFVai0AZx6SyG3J7IU19idyKY29Nhs6hOP1K5v6x+XRNe/AYY7JRpYiqQwReADP
 QYqqURRzeqaapk9SA5D0zlmvOkaQXl3wVznlkzj51bbagblyPutni87kHSTTldx9EzpwoDUNxxQ
 Zq+57CJ53VIl4MeydJufpFC4GJrKGG7Hkq9AksGR18K0NEvUVBfvYgefTmtKGt4RzgifT74wMq8
 KzaNAPp80c3JLnU+vJj9olPfAJLlIrNZfYFyiTCZic9qziozsakyn/Qp/6H89GRVAUAIaoJwled
 GJIR6cZTd8rCP4UXg0saaX8y3tF2+i6/MBrw==
X-Google-Smtp-Source: AGHT+IF9O6yvVQ013djQtO+75E4Mevf9KhAHWB9R6rgXZhHfxC1Wv8Hk54FckPrYElTOVUUUbzbLWQySPxxJ
X-Received: by 2002:a05:620a:4806:b0:88e:75f8:1e4a with SMTP id
 af79cd13be357-8906e2ca673mr2049441285a.11.1761069175684; 
 Tue, 21 Oct 2025 10:52:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-891cf3918d1sm128648685a.3.2025.10.21.10.52.55
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-290b13e3ac0so56933105ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069174; x=1761673974; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AC4lRdOLtLVMIYfNCDOJAsZu0pn1+BKzrGcc4bgyX4=;
 b=P0AknuRnUuiyz4vQ5D805k8lS36axEQmx6FZPlRoyOHWZRTpEPEq/dGDiIJWgFLQMP
 f0AAOl+rY1AotNv1xLg/tZhDwe9ZRUeaISQBnS+UGe7UxpjqNVo3FGoHNk5Z5E0ucUnS
 QEWw6wJSWyXIi5uvKEjn22QBUXMLs8vWRgPJ4=
X-Received: by 2002:a17:903:4b0d:b0:250:643e:c947 with SMTP id
 d9443c01a7336-290ca30e401mr223806755ad.28.1761069174213; 
 Tue, 21 Oct 2025 10:52:54 -0700 (PDT)
X-Received: by 2002:a17:903:4b0d:b0:250:643e:c947 with SMTP id
 d9443c01a7336-290ca30e401mr223806265ad.28.1761069173447; 
 Tue, 21 Oct 2025 10:52:53 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:53 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sangtani Parag Satishbhai <parag-satishbhai.sangtani@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH v4 24/57] net/bnxt/tf_ulp: fix seg fault when devargs argument
 missing
Date: Tue, 21 Oct 2025 13:50:16 -0400
Message-Id: <20251021175049.46092-25-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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
accessing tx queues. Fix it by adding NULL conditional check for
mpc member of bp structure.

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

