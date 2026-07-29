Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B70C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F1824066C;
	Wed, 29 Jul 2026 19:57:31 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 90E5E4067C
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:26 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cace91f112so15696575ad.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347846;
 x=1785952646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RGgfEpJxd1+Zpvo0ia3ezmSYRCbxOIjYK5+bbN9LZ0k=;
 b=mdl2Nuhn8zNOk25lzrf4Xuo2Pm2cRuwxN87CfpZ/u77149dQ+g6M8pmvLAf0Hr5sGL
 lM1TAZuw70wXNRAnE5JmB/bEGb0ngSWuiMLblEaqFD8O2kGQ1Lrv4mY7hl+i+vgHCJt9
 vrywo+Mn1Yh7KNBXHVdykHgDm7E4UygS0qMiZ4e3n9pHIgkt1p5wOGZ5RK+FuxWBGHSh
 vTCiI7Q5bhCiFlABbmqMpWLe8bJFcjK4NuctCwufxyAQ6w5yTJdNOPAQxHdCEX3G1Kpq
 M3ubsbGRYZc1J2MY5MsW6IAOnJNo3dllEt92AJtsDPLo9K+XQjRxQu+hcmxP4QajTTio
 h3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347846; x=1785952646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RGgfEpJxd1+Zpvo0ia3ezmSYRCbxOIjYK5+bbN9LZ0k=;
 b=j6hMuWsxQYmTGCE6GtdtDklaf1I8c5yUp05vYy9/rh2O2QmThYYAhQBbnt0r5KX4la
 fcWVBj3DZ0C6+8TGnBDufPQbSEzmU9yWiSi7emGmNewmatQKIGGqItfRRn4OtO2pXzyv
 5l7t8hOzAgWjtWOJIEwDK0diQ8R324zx0un+p1BXowQ+3U2gTWDw5tjeswfBaDmxbsqr
 tN0PmAIxKm4YOZwLfsDgM0udA5H7++geZyOnhBTDZBFYOiqjLA2GaOVJuzSamjpj2sv8
 6zboxMasGkKB0tZeBSmklXmFNJgSG1ob/fUSn6JGo8fktqyNtZiMPuOqLk8i8Q+YebZ0
 JYVA==
X-Gm-Message-State: AOJu0YwpYfPhgefENzTrp4D8yv18aumId5vNWNBZQtkNuQBNDfng2Mks
 2hClMSZ6EisZIZQAFkQ0ImddZOYkhpixFw0jHj6NmPiXVUkMl6g2HXOMgY91jM21tzx5pzlm9bE
 9PN+A
X-Gm-Gg: AR+sD11nG3q4O7JieK36gRkruHr1bouH3sg28M+EvSRwkMPsMttQXZZeG0WaUU2X5vO
 QfcYxYyw21ZpPvZN6Qnar2+6cz1Tdh5k9mX4tTKK0BIBEkNso7tbfECSDNZQezq6hET9/20zWQg
 B9cW9hnWAUoWs500Z6flBmxQIx1pzBuwPup0PLYf0RzWXCSd56+RFdfQDy742A6d0uxahI3rpuM
 h1hMm5b3XKWhy7e4kxgSEvjxnVYDllRmrSaB8YoR1GhlbUvJS6D9UR+Y+qK+VFoYzm6DD0mluya
 1cJLIbjck+je1Cq+VJHr0+Je2Hc43hUPqidYcKKPicUwd6u3iwPNyoRyTPwO6pGN+cggh6S8EiG
 FY7alqgM9EvHhs3VSxLVQHqkjdDYpPCB0LWiyfVGUjDPBk+bn8ZQ7YiwpagXMXwM4sFTi5gb5FX
 9DF5Y1djPe/ZuyLSJNKOkrgsepmdeIauJC5W6Yp8OBi95ovs5GfgOwXgVxP3D/mCWw2agtM+lnL
 DyLqhpyqI4JvBZD6iIOJy7lRU4=
X-Received: by 2002:a17:903:98c:b0:2ca:ed41:d331 with SMTP id
 d9443c01a7336-2d015dc69e1mr81784185ad.45.1785347845761; 
 Wed, 29 Jul 2026 10:57:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [RFC 07/32] net/hinic: replace rte_smp_rmb
Date: Wed, 29 Jul 2026 10:54:00 -0700
Message-ID: <20260729175715.165120-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace deprecated rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/base/hinic_pmd_cmdq.c | 2 +-
 drivers/net/hinic/base/hinic_pmd_mgmt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_pmd_cmdq.c b/drivers/net/hinic/base/hinic_pmd_cmdq.c
index 1816636c34..0c805e1528 100644
--- a/drivers/net/hinic/base/hinic_pmd_cmdq.c
+++ b/drivers/net/hinic/base/hinic_pmd_cmdq.c
@@ -825,7 +825,7 @@ static int cmdq_sync_cmd_direct_resp(struct hinic_cmdq *cmdq,
 		goto cmdq_unlock;
 	}
 
-	rte_smp_rmb();	/* read error code after completion */
+	rte_atomic_thread_fence(rte_memory_order_acquire);	/* read error code after completion */
 
 	if (out_param) {
 		wqe_lcmd = &curr_wqe->wqe_lcmd;
diff --git a/drivers/net/hinic/base/hinic_pmd_mgmt.c b/drivers/net/hinic/base/hinic_pmd_mgmt.c
index 6ecca407a1..f1a0b15c21 100644
--- a/drivers/net/hinic/base/hinic_pmd_mgmt.c
+++ b/drivers/net/hinic/base/hinic_pmd_mgmt.c
@@ -459,7 +459,7 @@ hinic_pf_to_mgmt_sync(struct hinic_hwdev *hwdev,
 		goto unlock_sync_msg;
 	}
 
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 	if (recv_msg->msg_len && buf_out && out_size) {
 		if (recv_msg->msg_len <= *out_size) {
 			memcpy(buf_out, recv_msg->msg,
-- 
2.53.0

