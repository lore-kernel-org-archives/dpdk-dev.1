Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD14C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABBB340B9D;
	Sun, 20 Sep 2026 20:14:07 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 054BE40A77
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:01 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so968046a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928040;
 x=1790532840; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQJvXPIJdThjqE+OMO+jQBBH//k+EggFVfM+FlEMp7Q=;
 b=HrorLdB/DQft1Eof55vTETs6W7RqUcYpfaaV8DAgbrX2BMVe8A0QC4c5txCa2wmYfv
 mSAZ/evPnLX8Zai2ZQivT3eMdu/rKjnVlBclSn607Y+oHfcnwS1CvylwClB57hfuNa3k
 2+3F8OvqrkXhv6s83y8tzyc8S//TiZj2w5EnVZt0ONhVMIRsuOP0rtwS9vo1Fs+Cq0Q5
 qg7jpAERMhT+uwlct7F5cPtXZ3VeXmqx4HnuvHAN0cThXF3f8xUtx2CU/36u1Wybk8i6
 58fEfmTABctRKWIwuir/J3ysLVNHAAGgudsvZO6HyiuMvKRKvs93EZulvdf+p+52vjQs
 OLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928040; x=1790532840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GQJvXPIJdThjqE+OMO+jQBBH//k+EggFVfM+FlEMp7Q=;
 b=N7yw6w4hc51mkcytqQinnJhG4KZ6KAduThpPRXLEoLk3G5+GhaVRrWnyqOmZNsGj6x
 wg9kCsHCMzox/Y/6lsCS4/P2d+iFfC7Yj1SmnAqIyio3ovIGlgB0GVIrQICa0TXbBfLP
 2B7fOZANweeFDy4ae6iikx3cSVNysKBHkoPpX6nTnQJv5j+dgkm6gsZNKQIJeO+YqJ1I
 rSMTIiyjmzJLqLKXVY0w70xIUqhxkx7wdWFvUJVShFLHWa/FFoabsAfCaYQmM5OLTXoF
 Dp0NcnmjjKFyGewpvbWcRKN508FfFQMrRys7IPBzEE2QFe3A2rzwIpGWFIrFVIj97+Hn
 DVrQ==
X-Gm-Message-State: AFuF++n/YgayYrc+6OqdsOc2rD89Dvz6xbvMILBTZADR2hlBu2YDiL8+
 VkBQze910Fc6r9p+OaZIMHDXUcErC3FqkvJQ1QEvMAJoWRI8htA2UmhdFTOeuJJk0zZLLhL2iC3
 E0vvU
X-Gm-Gg: AYBFou09+e3tI+QVY7JSHYjrKl38JJJQ0C55Ga9yEUdnYdieilM9G6mizPEquizl5PK
 3aATtHHjdQF/t4vn3rn374D1yOaLTeNgekX+UQ2LTf/mLC3yKjFjDq5GDgr7116Lpb5reUbtff7
 mmqKr8ZYq259dVJX9bGW8gvd/IReeMRdJqwPlVEhdgrZV1Cwar/L7jI8ldHdB6wQsUQCFzR89cb
 lHeEa2372J9+tKAdXdC5yfAOWQzYgv+lW5lH/EdTOjk7bzKS/66GpMUcmR6Z16YYS76HPgQsToJ
 sBBoEpfLF3YILrK0QhcavAhb7+5l7WAYTvmFkSy4wqubaRxmoBss4oEFVSg4vcYa4i/wk8uHauO
 /y7yBfBwwwR94vviN2LIiNEYwWwzsIWMb1I8LwxMsmQ4fZne6m9le5c4ZIyzwJnrIsXZqSRcUWj
 8IGQNS8x1iC0ge9PYYrWUdFKT+d2ybxkpjxKW+WQI30C9nfwwaep7XjQmes00dvBUdFopObH4sR
 SpJg1/rVwSTeS2/LoGmVJCocjQ751ZevUXwb8ZfVh+lqjQJ
X-Received: by 2002:a17:90b:398c:b0:3a0:40bb:edb6 with SMTP id
 98e67ed59e1d1-3a040bbf4femr1356428a91.2.1789928040051; 
 Sun, 20 Sep 2026 11:14:00 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:13:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v2 07/33] net/hinic: replace rte_smp_rmb
Date: Sun, 20 Sep 2026 11:09:59 -0700
Message-ID: <20260920181347.747210-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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
 drivers/net/hinic/base/hinic_pmd_cmdq.c | 3 ++-
 drivers/net/hinic/base/hinic_pmd_mgmt.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic/base/hinic_pmd_cmdq.c b/drivers/net/hinic/base/hinic_pmd_cmdq.c
index 1816636c34..57af522f6a 100644
--- a/drivers/net/hinic/base/hinic_pmd_cmdq.c
+++ b/drivers/net/hinic/base/hinic_pmd_cmdq.c
@@ -825,7 +825,8 @@ static int cmdq_sync_cmd_direct_resp(struct hinic_cmdq *cmdq,
 		goto cmdq_unlock;
 	}
 
-	rte_smp_rmb();	/* read error code after completion */
+	/* read error code after completion */
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
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

