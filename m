Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63094CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 542B94066A;
	Thu, 21 May 2026 06:20:56 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 4563940666
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:53 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2f00a567cfaso3430990eec.0
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337252;
 x=1779942052; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=hcBih7Aw0x93DL8cVGxNZjmxmcHHM0P18BVwUT/aEyC9mTyjrSQpxQdMO5VwiTZGfr
 QkNpAZ+tvM4bAIArLSHj+pU2MIzrpi7H+kUJJyn3EsVNGd7Ifj45ElVvUsgizPqkM8lE
 vXhJ1x+M/vnxJX0Wd/WrV3IB1Qq/zuR7tgWRD76QNeiFLN7nqLkaj4OTWWWlbKV+esQi
 4iAsAO9H4qrecJgRP4T7A6F+Wl2D1ejGdsgjgsJKXLyYhQ2UKtlZw8OxmunCr8OZGoQI
 /bBGyqZHBl0D0T3bteyZnoUWsegvGaSEjlxtOzUTh5Ge8ltAZGByMeNvEW1T5+SvLAxn
 Pn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337252; x=1779942052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=V1WrsnnueC6LkUyCITSmZkMgaoV/h+cwBSh4bOnBSPzO5qjl1EfDd1Aaa2NAB4K8Xz
 GEwLlUzBk4KkCQg8T6WmJGszakMNn88rWXqZbqdFlPojjRw9OJGrIJMiOEAF0Wn+UuQx
 xxSiHsPPlh9VuBOUzphZC88Pz0Md7zt2qomYlco5zC/WSlJ9wmvK7V9w4Hdwlw21wB8S
 YAS5hjmi6NMHZ6I4W+YZtkFgOZix2JXyP/uUBuvWG2Y79t0CAyyOF0DTNvepQflmjB97
 +m+JvKHzUmJq3TqPJXiLHx1M0qXXWfhvpnb/voALHMPkDBdxDj1J4FQVZp+4qpphKfZm
 DJxQ==
X-Gm-Message-State: AOJu0YzcInZz/BZo4v8FJpfWal0mpcl8vIAz2Ri5+ZcVdfNCtrd7SFoR
 U2ZpupWeC3U3pzsV0O4xYCgEaRUHUVfXbUpz8muL5ZqQCbe1t1Dce8vZiuI6ZV9/0y3sRCufOdn
 fJMfF
X-Gm-Gg: Acq92OG/NDkvcB8a/9ySx1GvowjHXbzSdWYzgAxNlAv/x2mx4ytwBfG94gl/ErbLE4C
 8IQAmFrVh98JQso6Mr2drOGJGeupVFj04odt1XBuT4n3QIKcCLLQIPcWJNz8Ol7yArMGdybCJnA
 K3hBGv/E+grItBYpie9i7AvV4qE/EJEd2nsRhGMIfeXulohZbV0ekh6mWWXpgT1mrnV2uaBC8RD
 lavdvNfnvCP2FB11qO0F6R5nTKQNsxA75RvGYK72QHhsQJn405YFi4jhtQRB/0UllhnzG8PUbEo
 Atnpi7NiobDZ6W7UOm21MlUEtNx2OoMtB01ovgjW8TVrwCiB5+O4bAS4zmvbAxVfzfI5drxDKW2
 sxpwx5Ppgj6XSNTpTUfZ9n5bMxYivAooKPsk6WSvN5HLI4iOE9ZeZ0g+i12VMe+A+z8hswdvCbB
 Sv3xD9YMatRy1iFeK07rXDJRBgmnpmZgTcoAIoQNMI7T9b8+E8VndbxFex/IkM0A==
X-Received: by 2002:a05:7300:818b:b0:2c6:67b6:3acc with SMTP id
 5a478bee46e88-30430f5b4dcmr515937eec.15.1779337252354; 
 Wed, 20 May 2026 21:20:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [RFC 6/7] net/nbl: remove unused rte_atomic16 field
Date: Wed, 20 May 2026 21:17:06 -0700
Message-ID: <20260521042043.1590536-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

