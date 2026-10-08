Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998ACA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F02A340679;
	Fri,  9 Oct 2026 01:37:02 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0D1014042F
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:00 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-887beafb714so2014479b3a.1
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502619;
 x=1792107419; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQJvXPIJdThjqE+OMO+jQBBH//k+EggFVfM+FlEMp7Q=;
 b=KuqzL2cDpMvsRPXZBdOpgXJMrsPyOCICGmplAF/8tCGapE8p51LOCJpkXJVFkHPav9
 NMXZpYFNOMk9Xjq5BwKS8tuRl6fY8bVfw45nZam2C5JfFxllnkXXJC1Ux6DwAvWKoohM
 l5uzfEiARl7wYHOV18QCWg4sRI6CwWpel4892LSB4mbAoeMTVvANhavImUw8dnyKDPYF
 iJjaeNDi10Pwxepv0TF0qbk/D+n8X3W5wGgre1Iq0s13k5ZsEVe97TMPlO9MXdJk8CzC
 VEuSkoisAoW6Wo/LQvChomaP6hI8Y8Hac2A/UhUQMThl8MSalYfsHQME24d1n6wfe0yH
 yoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502619; x=1792107419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GQJvXPIJdThjqE+OMO+jQBBH//k+EggFVfM+FlEMp7Q=;
 b=Fp5fUEYr/5frNPFrNWy2nxYfF12bZOWZvCAQu3MUbQ0Oi5aZAGp0iIIMeZCU2FGJAv
 +AR1bdA9M6H3txwTloz4vsnvv2f0XvP/tTpQQFTMS66A3fsOnAv1/rNE/+AIbSDgeFaw
 sH0VimhPTMHaz8lbaxRhnetLS3WABXPxkLiQe803fLGjG+IpKuICy9OQey0YjsdfratB
 RBdANDQuJfH0akBdVuUeziWFgtzdPrMBjUIlDIIIvEE08nNzURAG8FqybZrdgtFE1RTQ
 3ktSlyUdxqwOsEeTnqaQSiNKN6tCscrnxDT/E+h33AJ16LfmaQB5yZTyGiKQFPvn0uTp
 G0dw==
X-Gm-Message-State: AFq9FYJhPxJ0c9XTDuXROr9359Z1iTIWgHlg0RxiZ8L/Tb8vxxVyJrYr
 2wiZK0bG+cansTQjRjsDV6MlcaECQzT0DCcK3XIx2SlS7ul+Bsx3nF+rnrEgco9kNTkXnoM2rDF
 r3u/GT9o=
X-Gm-Gg: AYBFou0uOk8kkcteOnvJuMCVF3+MlogsEwEhVqmv1oWxyeQHfRMHv41pK6Luzl/D/DB
 k8h5HItiKFsU+cztfZPp7gkchZUi4jslljOvYGJFYlp027CGjbwbr4GxpmOeln5pMnfPf0ke5Ay
 qk8hGUiQKQ11+SbH2YxofBusf3rktp7EylA9tarersvHtys6QmIpLYOH01B7KLXSd5idwnPc542
 nD3b4iKzMLxugEG/RxrLs33qbDBagsNXi5t8+OkohhNOWJONsB04bIAO4bP73ayHPPoJuXg6e6n
 HTDzcMvxDrRXGdyAg3dCCaljA0vsAp66XJibDAsNlZwiv5LYHX4CQXWXZVDHU332T3bkZl7AQUI
 JtZbqirdSnqkwhf1EHMwcUmwjh0jR5lnHrS0Wk1auuFI9o6djhOeSa4wP+LKrVA+xJXtm+SN83B
 w1moEOrADT05piRUpWdB2+nY70yVQzfHz/n5J3mbtZEckSEtFveH6V48Yq1YJI/YsPhmp3DfNRs
 ZG6JK8x25WtwMFSPetJJCd7iTrrXeA11ep2zA==
X-Received: by 2002:a05:6a00:23d2:b0:886:4ca4:a3e9 with SMTP id
 d2e1a72fcca58-897c43df680mr70946b3a.3.1791502619214; 
 Thu, 08 Oct 2026 16:36:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v3 07/29] net/hinic: replace rte_smp_rmb
Date: Thu,  8 Oct 2026 16:35:00 -0700
Message-ID: <20261008233649.1260843-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

