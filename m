Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28441C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E41CD40B91;
	Thu, 20 Aug 2026 07:24:14 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 56F5140B8F
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:13 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso10253735ad.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203452;
 x=1787808252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N3wL0wiWRjbBjJM8/UvNqTovPAHCu6AN36OK4sZ2dqc=;
 b=NmqgF5/B21gNqgt3lrBecZJbKlcxBRnQXpG8xEnvpjz6NyfQYRBDDhYu7UqKdaMA6T
 h+eP3yP2Iy0/7yQJybvojx2yQL9zaN9d3r4co0W5b58dwo/5HQahoBn2ISBBxCPvWytr
 yfHTL2KYxLXvuwGNa5/337rH+Z4C4lrdLh5RARJxyelforIDYDFbrIU4xD9bJ9jfbwHU
 d4COk9taSxa65QNs8Nymj8AjaPiwhq0sPAyczdiOwEhM/DRenkbluWOyL8zq8+LUwbWe
 CiubpJidRImBHuBcFcRC9HhLDszvP1n2clEZHiPmBtEfpamb/yYvbN9uImAocatDYRnm
 Fcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203452; x=1787808252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N3wL0wiWRjbBjJM8/UvNqTovPAHCu6AN36OK4sZ2dqc=;
 b=ZV6wqCoCGjR1IZ6fKtFdgcnp4tHsVpQbRMqt1n/Jxp4skZiArCEZ9ym2TobEGYU7p5
 QVBZkCIiVYRKAUW4bGH7ECxghSKPsIaB6w1KX+xewxTD6j3vpNycDOcgkJ8WUophNf+5
 cnbSuYmm0v6gdYlbOiHMUahf3eqf1UOFoTcTPn/L8DsXJ55Kgu8u5K5us+srG/FSB9/+
 QydF7kC78cdR2mUa+AF/P8wZcQjB37UnvA1F28V5tK+IXsvXUjdA+LjI4NZ1e3IZWteY
 s70nQpBGuIhesLGH2YuMOVjTToFAZhwt2WE5mqrUaRhtrRlXx/V7JV8YmwX1bgP/1MRq
 2NAg==
X-Gm-Message-State: AFuF++nly9PRjonc3rVaTkDdnRCPPEvV69injjMEz98bfya85LB8j20U
 nYsqUZys0RxtOOYThWpXhZmomyDgkYCKYzHHtrr9aex1JmhCdYoGBNyBfBz+F317vYx8m6AJ4kd
 0jF5g
X-Gm-Gg: AR+sD11VN3TK4LIkm4lfNMla5qvsa3RMyaXt3Ok4IDUDncbVoG8lk1+EV9BvhuApAEH
 dvgk43BOSQAM55D+L89Xd89m0RdI++dO0jRI9xxIHGrcwq1Q2k1Vy8Yvvz+lkT9n2T7u5kjDZK+
 K2xWJJ95NKBS44o8seEq1pf1sLdYcQ61WFssTxUTCqtS0+LStEj7YhCoGM63AU1mPvrhiy/nodM
 POZ+cO08j/ljvNyQ0mScNMXVrkZhLQlsr/AkQcHCN6Gr84NNAWZNWbeHt+vKNnVXpFkyIxS3jAv
 CxOcHM25eRTuDkH8YaYie8XIFux8kPeIqKm9h5lzmbXWzFlG1QCDR+OtDe0p7ktFQi7yMI1SL0w
 XSSRv+gnNItzLARtzu53z5+f6dM0WXsY4rb1b1M6AvZCYGL8Hk3S2NXEBXq0IAl401TSnp99+ft
 gYD5yml93GnzxCL6D//XHjSDMcvk1Wwtjsy4smQUUh800iAHGBd8rQIcFLlbKH+I/Kmyzi/nu72
 fLjfkFAb4Tmk/zqEb3MnJ5sX4kIRt2xrqVajA==
X-Received: by 2002:a17:90b:4d81:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-39580a7c832mr18791522a91.7.1787203452306; 
 Wed, 19 Aug 2026 22:24:12 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>
Subject: [PATCH 18/61] net/avp: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:08 -0700
Message-ID: <20260820052251.1453273-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/avp/avp_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index 8af6c45381..026f45c688 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -249,7 +249,7 @@ avp_dev_process_request(struct avp_dev *avp, struct rte_avp_request *request)
 	while (avp_fifo_get(avp->resp_q, (void **)&resp_addr, 1))
 		PMD_DRV_LOG_LINE(DEBUG, "Discarding stale response");
 
-	rte_memcpy(avp->sync_addr, request, sizeof(*request));
+	memcpy(avp->sync_addr, request, sizeof(*request));
 	count = avp_fifo_put(avp->req_q, &avp->host_sync_addr, 1);
 	if (count < 1) {
 		PMD_DRV_LOG_LINE(ERR, "Cannot send request %u to host",
@@ -286,7 +286,7 @@ avp_dev_process_request(struct avp_dev *avp, struct rte_avp_request *request)
 	}
 
 	/* copy to user buffer */
-	rte_memcpy(request, avp->sync_addr, sizeof(*request));
+	memcpy(request, avp->sync_addr, sizeof(*request));
 	ret = 0;
 
 	PMD_DRV_LOG_LINE(DEBUG, "Result %d received for request %u",
-- 
2.53.0

