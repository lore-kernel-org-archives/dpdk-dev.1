Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FBDCC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD88840A75;
	Wed, 14 Oct 2026 00:35:04 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 0AB9B40687
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:02 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so18463555ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930901;
 x=1792535701; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQJvXPIJdThjqE+OMO+jQBBH//k+EggFVfM+FlEMp7Q=;
 b=OKYmLKTSGLQxjE2bT1B6u+g4efV9hIqAqdf2Lk31nny4NQ0o8NnzV2MRvkrEPFTMsH
 ccKLmVFNJqb8+s3R9ckx3WbpXAs/QNb5EmaBvMjdIOdKyyWQ/gbn+4LGr3USTnNOoQ9t
 RS0ydqokhBPZ3/ZzJSA+Duv5AnBG66t+WaJnLbvdQe3ngEhxTV2mvdbHZGsbsFRBgY2U
 Y1kFf/yH3DqIlGwCNfCl3jPvfQylTsjPdGnrzF3g9/MmN6N03okYGLEAwdHeuBAMli0v
 lVlUTTeyJWD2kxsyfzcJimtdjknMin3UvHzP0LdqCjVPlb3PLpy3bA23IgynxnQVEg49
 JegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930901; x=1792535701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GQJvXPIJdThjqE+OMO+jQBBH//k+EggFVfM+FlEMp7Q=;
 b=GiVoTf+Nv3dsN8AKwhDRHSuo8JdMv6B0Q3SNogjLhopc6foSHwZsDqR2R++XAduSbM
 WPbghiPsWkM1kzVgYtqyLAz2sKrBli2E8EIRNbzo36evRVDb/BWMigh7fUo0KNNMWAXJ
 utz8vjs7lisrooNCVsj7kolTqP54Uxgi40dh4z+lPotUaMVlFFheDL0woFZjMCJOQrEe
 6VIKqOk1NeBrN5NV2bpInQqcc7z41wBTN+9PdgLy+7riOmSf4tg2WocUruPDvcRzXQdK
 ltemC1f59Nya9Uh4UKgVxt0XCCNX8XeHip4vd2+gEnoEEZ+ma5I7kzKeQbUqylfmvz0z
 SMsg==
X-Gm-Message-State: AFq9FYKLiEU78eci2cbyXMCbgPVUE6zEYNFE3tsIjEj++Kv1DTKQYuLR
 NIcQj93nnkWy82c7+9CE9j+rQrF0gtBiAuWKtUh2ffnAnq5TPWjbAM6neuaOYHCvFhTuX0laN3b
 NJQ2b2a4=
X-Gm-Gg: AYBFou0EOl7VZbLmOkgQ8pOcm+8zX1cufdQkSvpAB13d0H2RyKCweUwzWa1r1M3DVCL
 sRNDBIOIi3XAVSA4OYF2VfxF3ZY0tLCPkZnkllM7XrdNNZn4stl9TA0QBptZmNCnmfYpjNceWh4
 duny+CKR1sW87DWQdPe6ec31PMHeoaMn7y6M6eM9Ja2oKWNADBClNthMxTBcJTXlHeMalhiCrlI
 5XyYe7nwcgjh3A630A+tE9ohKzprn5ejDf1KEnH6KiDmkqx0bQxpUA/MhZ5oN5WVV7ijkysQV5b
 +UFoNkajODGP6TiwE6fnOlt7juKr/8TMz8ZOhDx6acZF+94hAaPAySCwmsI19yxSsOsYFNdf5p5
 EFz7qrnyFlk6V4wHWim8633fFW4sCQxt8xg+mEq/Y3/pP3VNx8ycbD47vZ8S8vX0CpR6qs8ZQVt
 xENWQ+GN/khkmufsuAXr4OAuD1ny+F2eBQLmEfM3Ck6j7GtklbvA8AtWm4yAAJnxKaXIkwDpfbx
 djLvdqlxiShCWmcjLTkuCaLY+FBR2oHTdV/Qg==
X-Received: by 2002:a17:903:32c2:b0:2e8:30dd:523d with SMTP id
 d9443c01a7336-2e8429a739emr131619265ad.13.1791930901121; 
 Tue, 13 Oct 2026 15:35:01 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v4 07/29] net/hinic: replace rte_smp_rmb
Date: Tue, 13 Oct 2026 15:22:20 -0700
Message-ID: <20261013222410.2257622-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

