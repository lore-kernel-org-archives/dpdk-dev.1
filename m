Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB83C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F2744067C;
	Thu, 20 Aug 2026 07:24:55 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 12C3140E0F
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:54 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2018836a91.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203493;
 x=1787808293; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RgA4QePcMQ8C7JK6UHxAr/CR7xd/7CLOiIO0EVbO2Tw=;
 b=JG5nGyXwBAQyiMFiL/jFw6zrCAVjEZDZDeE5259MIjOhj3WXUSwPKnjg8FdcXwk9SS
 rd7NrqXILFDaWZiR1kV3lyoPAe/1pWTXQt4EgS4RJChnb5KswtTCIEa/wVcQ547FJf/i
 dUm4PUlmQFtOCaARUe1WEsbj+xAEBZag1C+Nk02GEVK0Bs0ARkxf7HDIFZTvckLmg9QF
 J2m1Bb2r9mQIS+NRvtsF+BGF3UIrfI8XZty6UZJIxaYRya8uw2r9Ixz2/aJ3y1zOgH/u
 lRAMBrxEH6jv4wL2Xiv8bNJdOKEdm2SM3Ay8Ju/6rjWLtUV4I/kAQTARo+HRUgmv0IzP
 Gbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203493; x=1787808293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RgA4QePcMQ8C7JK6UHxAr/CR7xd/7CLOiIO0EVbO2Tw=;
 b=ajNguusy+zntT0IvGAkPCFP0glx7Adb+ZlU0JKnzjcynlvXcIdcl5slnGBv2nzHjKZ
 lGHoUBKnPD1pJbfZjdRY7634YAgMAc8bCeKq6LhFKfbn1+s9nC66WiGi/3HdX8uIGGf7
 P1Bl76VwBEu33gJ2gz1dZ8qJYm+NlQaIKC2vJdoqUNOd3alSYkQIJFGjqAt0ZcGqs3Xm
 8o+euNOVkNGEforJgTbrvsDi/Dy6+MVLB4v58baLowRv80V5vQoFf8kzBHSYNaohd7dL
 Q/K+gabhfRREDDDK4mNWM3aAhAGmtKYFdDQJDmwyf+0ZQ7Tm9miwIOQvfcBbMSYB07EE
 Uxig==
X-Gm-Message-State: AFuF++kWXxJclay6NHvwHOv+WTmHULM9ewDaQPlMCECRBlSMWaUvb9P3
 MBxcmfO7oYzHF/qce39ZzAMU3SSJfTcKMq5RDjNor1OKX6nfBI1dveAjuMEgd0DK7kLPWCwNfWC
 UyVCQ
X-Gm-Gg: AR+sD12X586AfQX5E0Bk+x5LgO+8p57fyrpOLrdo6n+daHoqi5aSi64HcDt/2g8ikTr
 5mURbOf92s9phOYB+62VTS6G4EL+e1qDDNAYzme1U8KYxpzUWG/azHE38ymAihpstDaGWCBxyWy
 3BI5BnZuu3R4QM41gcNiNyBtEilUDNPFODInqIMZrvb+rOxNy/QvY5TJmqtTJ9Y0Co33QHvfMTC
 yHCQEbje7DYn4FJEmjMhhQiWWzplC7EQ/jIaEshZ4YOriatYcF5CLsVOsnWlIGtJmPn141jFU1C
 WJN7CRCbY0fRJixnOEtrBOaswQNNPBDitWzGnX5cD4eYc1WVaMJKIBp+CBVkTES8d43cJklxq4b
 MjPFf9PaapjHDbzC9fknzlOi3LbDcApbi8o9xGLMd2NmAS1xXRb9I5lZhygctLDAK6NKKIfBNI9
 VYk+ezU0xdoEwJsuL2c8aD9mqbfqoMTGc/3z58wAn5bZPvFb8c9hW76JNKfigi8xSwnQ8EPpCTA
 UIk6c9z9t7v/5SL9G4Tw5qD5rY=
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3958127a5aamr19345202a91.13.1787203493103; 
 Wed, 19 Aug 2026 22:24:53 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 30/61] net/hns3: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:20 -0700
Message-ID: <20260820052251.1453273-31-stephen@networkplumber.org>
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

