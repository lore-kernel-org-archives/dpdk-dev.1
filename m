Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB7C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 680D240A7F;
	Wed,  5 Feb 2025 17:25:17 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id AF93C40669
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:10 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f9c69aefdbso3564037a91.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772710;
 x=1739377510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0dvoHm/iI5DjcPcNDwGHDc3HdVJCtsbFCJCmrvlmTQ=;
 b=d2zDa5iCwk2vONN18PQ80Rnmlijglf6TgO0CBsHdKLZXfumXzSYQ8BsHLnJLGn8Y7U
 1lFIknViBQFGaejspQUbpAZHnpf/Bt8mYEPdl0h1zyD7+aLAscC5Nv3MwsxIfcRaVs17
 JuNYVk/n8COljVmiyyjIeYCFWgt2SFP4MQf5I0iVkgjjWae2MZonFMRfyHJ2wItZzAE4
 5dQ3q58icXfWNknay9QcGedAZuKNm9ekXJtzWa4d6Vrdqblh1SrZNrKMCdbvfjO4f7qy
 abPpvtcijGws3kyVa0e+52QJzw+vrBQBPczZbO/++YDivd0wDd6arYQmfrol7IaPZs7F
 MFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772710; x=1739377510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0dvoHm/iI5DjcPcNDwGHDc3HdVJCtsbFCJCmrvlmTQ=;
 b=qd++MOwrhLMGZhrQv8K6J8jqhHMMF+SHyae+WMcVcuu+EdyW0SvzKwFspfW1BRLeg0
 tBtMAiOmdbuZvs3GvhItgvUciiFfhpilXH/yNOf/hEAZAJ1aDbgNJojQoTJwu50u+tzq
 9MOh5hT9VR9TgBJyWaKLwgcAlUhYfksN4U2Pi4W8ct1HnY4RU+BxO2j+XEOc0JacfFOL
 QbNKWtm5mWZC+D3Scrjy6BVmJWRRBZ9FDYU6GOxfjQglhv4OfEtrJUCsEoBTYdyTAUSN
 /6lvDr8s5L1ECPbA/nZIJ7lS0OkADLvvX9Yxit8oMJWRi+IXucjI/OuZb80xAn9T1N46
 VxFg==
X-Gm-Message-State: AOJu0YyKQ5AKKfyECxlgHoOyO5ccw41wzXZnQaFcOyyD3xgJo8awifbm
 XnbhkJ5NGjNW6mS+RuM9gWNbNU4YqdUgkSj7xwCB7MfD26ZptH5oF1xnS5iJyxA7R+VDRksSs6v
 N
X-Gm-Gg: ASbGncu1Npg6AviFUbByVQmJfqdR4wJUXFsMoSfMNbv3nAQLuNyl27xVQbW2/5YZRj3
 9I4EQB6JYu+mzgEip3bEOu2cKQDCq8iYIj+hI+29uCtpE/QmTfk+v4zp1pVxihYJ24dPagxd0eB
 V7X4iQtkkfsAPvmqmFxVUsMOc29AZG+nKauE8shMpW1qeqDERKOO/F7M5dNpqaA++tzBzNSuJAE
 6guABhzBmhCJ6DMgwRMqHrpvSyBPgE+DhOK2ZfHhUBAVYajGRXsqNXMKy3JtZLnueNw4su4F6yy
 zD6lUpT3RTRCVb9sCQVg41xXey+k0nmME9q75co1SHIkQNDxPOuBA6avXoROaFVRMNSg
X-Google-Smtp-Source: AGHT+IEEZ7zQhDg5xJmGxZwFSJuyGEZkPujNmKDPtxp1ZLWG0EvQFKzBdIVPeptZI91MQmKc4hCowg==
X-Received: by 2002:a17:90a:d410:b0:2f2:8bdd:cd8b with SMTP id
 98e67ed59e1d1-2f9e084a275mr5303820a91.29.1738772709757; 
 Wed, 05 Feb 2025 08:25:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 cloud.wangxiaoyun@huawei.com, stable@dpdk.org,
 Ziyang Xuan <xuanziyang2@huawei.com>
Subject: [PATCH v3 11/19] net/hinic: fix flow type bitmask overflow
Date: Wed,  5 Feb 2025 08:23:12 -0800
Message-ID: <20250205162448.161161-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The type mask is 64 bit value, doing a shift of literal 1 (32 bit)
will result in int type (32 bit) and cause truncation.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/
Fixes: f4ca3fd54c4d ("net/hinic: create and destroy flow director filter")
Cc: cloud.wangxiaoyun@huawei.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/hinic_pmd_flow.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/hinic/hinic_pmd_flow.c b/drivers/net/hinic/hinic_pmd_flow.c
index 8fdd5a35be..6b1ca6ff88 100644
--- a/drivers/net/hinic/hinic_pmd_flow.c
+++ b/drivers/net/hinic/hinic_pmd_flow.c
@@ -1979,8 +1979,8 @@ static int hinic_lookup_new_filter(struct hinic_5tuple_filter *filter,
 		return -EINVAL;
 	}
 
-	if (!(filter_info->type_mask & (1 << type_id))) {
-		filter_info->type_mask |= 1 << type_id;
+	if (!(filter_info->type_mask & (UINT64_C(1) << type_id))) {
+		filter_info->type_mask |= UINT64_C(1) << type_id;
 		filter->index = type_id;
 		filter_info->pkt_filters[type_id].enable = true;
 		filter_info->pkt_filters[type_id].pkt_proto =
@@ -2138,7 +2138,7 @@ static void hinic_remove_5tuple_filter(struct rte_eth_dev *dev,
 	filter_info->pkt_type = 0;
 	filter_info->qid = 0;
 	filter_info->pkt_filters[filter->index].qid = 0;
-	filter_info->type_mask &= ~(1 <<  (filter->index));
+	filter_info->type_mask &= ~(UINT64_C(1) << filter->index);
 	TAILQ_REMOVE(&filter_info->fivetuple_list, filter, entries);
 
 	rte_free(filter);
@@ -2268,8 +2268,8 @@ hinic_ethertype_filter_insert(struct hinic_filter_info *filter_info,
 	if (id < 0)
 		return -EINVAL;
 
-	if (!(filter_info->type_mask & (1 << id))) {
-		filter_info->type_mask |= 1 << id;
+	if (!(filter_info->type_mask & (UINT64_C(1) << id))) {
+		filter_info->type_mask |= UINT64_C(1) << id;
 		filter_info->pkt_filters[id].pkt_proto =
 			ethertype_filter->pkt_proto;
 		filter_info->pkt_filters[id].enable = ethertype_filter->enable;
@@ -2289,7 +2289,7 @@ hinic_ethertype_filter_remove(struct hinic_filter_info *filter_info,
 		return;
 
 	filter_info->pkt_type = 0;
-	filter_info->type_mask &= ~(1 << idx);
+	filter_info->type_mask &= ~(UINT64_C(1) << idx);
 	filter_info->pkt_filters[idx].pkt_proto = (uint16_t)0;
 	filter_info->pkt_filters[idx].enable = FALSE;
 	filter_info->pkt_filters[idx].qid = 0;
@@ -2355,7 +2355,7 @@ hinic_add_del_ethertype_filter(struct rte_eth_dev *dev,
 		if (i < 0)
 			return -EINVAL;
 
-		if ((filter_info->type_mask & (1 << i))) {
+		if ((filter_info->type_mask & (UINT64_C(1) << i))) {
 			filter_info->pkt_filters[i].enable = FALSE;
 			(void)hinic_set_fdir_filter(nic_dev->hwdev,
 					filter_info->pkt_type,
-- 
2.47.2

