Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64E6C982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE63E4331E;
	Fri, 18 Sep 2026 20:30:33 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id E1EA640656
 for <dev@dpdk.org>; Fri, 18 Sep 2026 20:30:31 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so907407a12.0
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789756231; x=1790361031; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHQV8WKj7MTc59ROXa6jyF4Xd2W4BHY2UZh20CI58uc=;
 b=mOlNAhPA+Kd4DyAj8mmrjbaiCZOd5ZKIC2k6Xy54baM7CvTyJhpCdSWt5HxBoq2hTj
 oESjaOmpeXJ70/u4Ye4UBJyVL+/bu/drh+GxDV+WqirUHcHavRVuJwxQUuDX2MciohPf
 P0GUkzq57cgtX0Szbcl9H5xoAXUT41HRp9puPWQiviYtRbBCmTZaj8+6nv8vhebA1QzD
 LHXwY9KsuN1eyIcYqFHwokseFeEWYD+2JofN67N9ZlFSZQhnhqrR2UHoW7zKnOLQnRW0
 zSxto98E4a10kWgRv/plfornaBf6mwkGg4SAqPUHRNh+VP3wiFebNX+TWvYShfPvUIjB
 cY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756231; x=1790361031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHQV8WKj7MTc59ROXa6jyF4Xd2W4BHY2UZh20CI58uc=;
 b=zP7X/KSl0591lZK9uX4kmXb0lDyqjSFe1yYxFhWny2PcwKWdsdDaiXtq0b5Mxp/AsR
 /dwz0AI0dT3RKCwSi5LwQQ7iNFG/rz4GFUYxB5IGOqOwUOBMzoDk8qq6IYwmF9tCQP4p
 pzpT/alQ2HQ82E3bop3lioyhMupki8m3+BKfJCUYKf/yVzHLU/b2bQMFpApE32mHrT6l
 L6GxE6awKYm4ehyGDd4c6Hw1DHb4cICyPKWD210M1Nffx/HMm2jlpGXt3ZuB3CJLB0oA
 WL1vjMA8xZpFxLty9jZ6kugRBMo3c8hPjAhkvbxHQQfVOTWGzFQz6DeTU0J7UFDySsxX
 jdPA==
X-Gm-Message-State: AFuF++k3mVni6R2hP+nmFSxYwGIIWIqf/mx96G2qwvuTtuT+2vLTJqA9
 hIs9wKUz6qbuUauTKoWcy7fimqkKZN2jsHmFgKLo8R5745rmrgfv7IXc
X-Gm-Gg: AYBFou3ivDWgurh8y2MAylE2lSfe5X+pmnfoJGeqcRaAoXDtARbdCwgIXwAr4O5rKBo
 XZxoeO9YRH9RSxULacJC/sWJqQ3tugf879jFjsxnQnPxJhNIlqML3gRzQceorudKylPwZ+v+iCO
 go76RTR42iBbNBBLjXacgwRnQaeXrjNadpBqupVprhg0zqtuAJB9tWX2qEwswCB6dIHsh5UFl8Q
 2/1Iu3ZrCol9+F/0Ezwv9g59SUDN+To7OTVOqITk2CI7EZykeuwlHTvfD2uYlRrw++/H9VHGf17
 eEYG4Vjrjwjch9DbQfiXvzcxPaVUZn2WoWKgAXpPE6Kci9iCR+hAFJ2yjdUEOg/mxiPEmNRQ0Y2
 9HGqMIGYApr+nW2/s1VklIg4lOjbXiCBLymJ3qamPMiXGarhdI3jJ0O7dLa/AJA40q0rpObRAzl
 Wo4gFBJsNDs6YUyWqlmrjcEaEYreJVhmYZ6JsoYxuA374MPrq0PPcm8omwQREAFN8KwvmjCDfRX
 uI0u1xgdBMuo/UV7w==
X-Received: by 2002:a17:90b:2cc5:b0:39d:f064:3a76 with SMTP id
 98e67ed59e1d1-39e54b8e9f0mr6418027a91.15.1789756230949; 
 Fri, 18 Sep 2026 11:30:30 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d4c0dsm397209eec.29.2026.09.18.11.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:30:30 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v4 1/3] net/txgbe: fix L2 tunnel error on flow create
Date: Sat, 19 Sep 2026 02:30:09 +0800
Message-ID: <20260918183012.42520-2-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918183012.42520-1-zhtfdev@gmail.com>
References: <20260917153242.29315-1-zhtfdev@gmail.com>
 <20260918183012.42520-1-zhtfdev@gmail.com>
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

txgbe_flow_create() continues to RSS parsing when L2 tunnel filter
add fails. An E-tag VF/PF rule cannot match RSS, so the original
error is overwritten.

Fail the create on L2 add failure, same as ethertype and SYN.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index eaeb973c91..76191a7c2d 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3449,6 +3449,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 			return flow;
 		}
+		goto out;
 	}
 
 	memset(&rss_conf, 0, sizeof(struct txgbe_rte_flow_rss_conf));
-- 
2.53.0

