Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF04C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBE9840DCD;
	Fri, 21 Aug 2026 21:30:10 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 6A9EF40E22
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:09 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1768978b3a.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340608;
 x=1787945408; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RgA4QePcMQ8C7JK6UHxAr/CR7xd/7CLOiIO0EVbO2Tw=;
 b=WGXXHMtOYrLOhPAv+UzBoWkoSUt7Hp+RTMjpnH0OBGe2/D9cIGZP6QotlcWpyfVkst
 /Z7nI/0d+2Vp2U2SItcH2P08rEyOZ3pgNlxaSs7zxHPuAtZDD+crf35hSfltCXryjPha
 EyZGGhbjrWVLxalQYss5kW1sBYOE/ic5fMyr/jlcYVZFoErShZvb4MFVa+gfkMXk3nyi
 +sWw/wNSv1QWmyUD0V+V8vIMJgdt5ovyqjPn/Ur1mgfuHraYgCn02xuMSXvEDEH/mPlt
 TdxuR/aiKegXHIQqIpSd8WtfWAU6tupDgmG38yhkQDFHjoQbhDO6NX5LkGcETs6FaDFV
 jFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340608; x=1787945408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RgA4QePcMQ8C7JK6UHxAr/CR7xd/7CLOiIO0EVbO2Tw=;
 b=o21qtPjQHcgttS6PBaB6NbjhZDvmz+HrWcxSghj83o0ws6SyMQ0E2Tgtk8SaxFTVs2
 6i5gBGRNCi2aqusm2rQz3DRt32mNYIts09+5jKXeOuSjqGVLseUQ0EGLW343auQ5Ebn3
 Z0E/dhy/QgujcvdfUCXEOjliW9vFb0Df0OBIug6OmBZQ3w47I+Rm8E3PFc3dLV6Qxk1K
 f5t7D7f6pDdOZln+QAGFzGqDMdLTFmb+KdAScjuIiURofTfJn2amXR/4Xgvev6tfY4R3
 kJYxhzyDkgbXLL7W9ZUUM1qCRbyBian7AwaVLJLXXz/8LgF0DAPOsL9T3SfQYwFsxe0T
 lrVA==
X-Gm-Message-State: AFuF++mb2uIIgNsos9YNOJCfwl7WcWhcYdFs3wB8bfGvQ8afp63bDNIn
 lJZRr8pLq2OBUrbUKIa+33g7KBNXGPRnZt3K8g7dQQmRglfBT8LJFqHas6sDVLCVQTmPMGussLJ
 6u6bvQ0M=
X-Gm-Gg: AR+sD10GtZ2agWHpXXCSEdet/H3gH/5wY6qlJw+mUr/wv+rriA5ILakVmKxTtxs/SYh
 RxAQAnd39ovCg06whzPEaFJIlXRyk/o+dmsCFA25JrIPRa1+RrJYnuR3X6eTC2a5u/jDCBfICK6
 YAXMe7kAaxhJNaH94E1KMxxF/mvWzYDGXhA9Z00YT5YZ8kCNextAudmpRYivPORVV/9VtP9e7SF
 NY7uwQUu1Mdq6P0hdZgBID70Ga15+dhj4pbB0/7v2Tg2pMiZwqlQI7fcdHSvjJ9RLA7DlMev9xE
 2YEuXQbpyp0KJpa82H3pTRkc09jYw7HasWU2PzwzR84snZnLyVILyYc8coLkzrtQz4Oi2sirODX
 duUijWrVG3/nh4fZLx02dDtJgCtZKUCgH5XVw5aaHVuxN9VdaGVGNUOD3aDv688BumwLby7OWS2
 NLkt0S2iy124j1ItfDUVUOm9/oPUlVhanwbGOvITD2vq8sRVi0BDfQA984ETyuZ6MREz1zKD2Fs
 u45cWyaQMAds3aVdy8yQszC3f4=
X-Received: by 2002:a05:6a00:348b:b0:848:4424:2b8e with SMTP id
 d2e1a72fcca58-851f9a8fb96mr14202011b3a.3.1787340608600; 
 Fri, 21 Aug 2026 12:30:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 37/68] net/hns3: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:32 -0700
Message-ID: <20260821192646.146382-38-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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
 drivers/net/hns3/hns3_fdir.c | 2 +-
 drivers/net/hns3/hns3_flow.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hns3/hns3_fdir.c b/drivers/net/hns3/hns3_fdir.c
index 50572ae430..86dba4eb2e 100644
--- a/drivers/net/hns3/hns3_fdir.c
+++ b/drivers/net/hns3/hns3_fdir.c
@@ -1066,7 +1066,7 @@ int hns3_fdir_filter_program(struct hns3_adapter *hns,
 		return -ENOMEM;
 	}
 
-	rte_memcpy(&node->fdir_conf, rule, sizeof(struct hns3_fdir_rule));
+	memcpy(&node->fdir_conf, rule, sizeof(struct hns3_fdir_rule));
 	ret = hns3_insert_fdir_filter(hw, fdir_info, node);
 	if (ret < 0) {
 		rte_free(node);
diff --git a/drivers/net/hns3/hns3_flow.c b/drivers/net/hns3/hns3_flow.c
index f2d1e4ec3a..f7e4d339d3 100644
--- a/drivers/net/hns3/hns3_flow.c
+++ b/drivers/net/hns3/hns3_flow.c
@@ -2588,8 +2588,8 @@ hns3_flow_query(struct rte_eth_dev *dev, struct rte_flow *flow,
 			}
 			rss_conf = (struct rte_flow_action_rss *)data;
 			rss_rule = (struct hns3_rss_conf_ele *)flow->rule;
-			rte_memcpy(rss_conf, &rss_rule->filter_info.conf,
-				   sizeof(struct rte_flow_action_rss));
+			memcpy(rss_conf, &rss_rule->filter_info.conf,
+			       sizeof(struct rte_flow_action_rss));
 			break;
 		default:
 			return rte_flow_error_set(error, ENOTSUP,
-- 
2.53.0

