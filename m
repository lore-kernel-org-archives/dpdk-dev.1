Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2A9ECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:58:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C1C427B6;
	Thu,  5 Feb 2026 18:58:12 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 78863427B0
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:58:11 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1096404f8f.3
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314291;
 x=1770919091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxvPPd4bd55x+NbWJQqIvP18G0vMyw3W7XSlCufR1SI=;
 b=RA8HWTMGgULirQFyd/S5TWZY0vniO2r98YCth1+i8xuNhNaXFjDpc5ri2GVb+u5LrG
 yuW+vOSKDPvebGWEacVK7yK3Yip4kekhOlbPGU+2KUnZEJgxuPP/YxdeF+266hMHfxY8
 Zke+JQYlqtA6jJ+e3JgS39Kc5XWaotc2VgmF4KiN51bzZHUlqwpMXJE1XVwyB88wni03
 OrOwzMXBlNLE2fLJTmR1vpfRcgV+SMLETDuKjcwm1mDAQ/9vUepe5cjdhmqA5C/BWnI1
 bA89jWyD+V1oBZOXUTzs/mMyCdBP5nAylIlIAPeFy/nCy/uas+bTTfyUGLw49galOB5W
 jZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314291; x=1770919091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oxvPPd4bd55x+NbWJQqIvP18G0vMyw3W7XSlCufR1SI=;
 b=HNCw1+Ba6EqSkOP+I3w9dATGrqPsnC2xFM3AXye4pcVDsvZFTppeG49vq6Yb8cppxq
 c2xZS+ATke49Z40nIxqgfoqxfE+xKK14ieOZdMAigTINRnQ6PL2HbZ/mvdNjYdIZ3Ki/
 XE815g9+IQIPsG/ljWbpj9UfX5CpQf0lSE7kteqAsdKS7T9mSVV0Jiga/XSGqQwR4Gpo
 5x2xIG+VXadCW9pcoFbC5sOg3R/LAOq51jcES9bGN/GQv3mzZBE2P+lnFzj4FaPRZ//r
 Zl7vOB2R0YmsgfsIQAl79YomrQBhaw0Px6S5e/Cnlf/tumJssRXTPH5z0wHJ3cxrvfmB
 7G0w==
X-Gm-Message-State: AOJu0YwAxwXb32h5/sw/EzrtZzw9hm8vV131YMTOkGZH9gWb78hA2g/v
 3K35PLMcSmmJn64vz3qfhH8B1Yr/Pb0ng0mUsUk76nQRCRyItzBDfybvrn1biJHbHjWCy4IqP9Z
 CUVpI
X-Gm-Gg: AZuq6aK/0aTqKaxRZ76+DZfiyekqkmRs0Ej4gzfubIAiqLSr43TdocgmZ2Rm6s/NDH2
 hKArfDuJrR+WVYa3AZkPB9NKk33YvTJDVKgzTh/Q1N1hwvbti4gdmtr/gFkLjsPyjcXN4+m+nNz
 VjUzSJ5cqH82HBS715oLQG41fGbYoJ27pkEWUcOQxaSqiDdMDAgnmMyMK+fPoxsu8a2IeM98DL+
 Q949osH45k6YNQOVEZc00hxn/g6t9B6Mlb3P3hPQ5+otLmC2+hsHU5K7z7FCO/HnXkQ1Q7e/PMB
 MWIrrUVaCpdId38ame4wqyWn8wypXBnvSTv8VyGRa10k76JPFo0Q9QTf16jnNA2TBY8dN0Syqdt
 QLgZLe5qtCgmqniq3HbQsHwtjyoUyZ87xcV52NXjbLz2vgPcCPb2sfv3GvIS2i5qqxEbvmDHJ5W
 PLgNagwPJpYHURO4ETfH+c4McCPrg7hVSyS4c+yf++TTZ2Z8Tu3g==
X-Received: by 2002:a5d:64c7:0:b0:435:db95:c2d3 with SMTP id
 ffacd0b85a97d-43629386506mr110666f8f.36.1770314291011; 
 Thu, 05 Feb 2026 09:58:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:58:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Erez Shitrit <erezsh@nvidia.com>, Alex Vesker <valex@nvidia.com>
Subject: [PATCH v6 6/6] net/mlx5: fix LTO stringop-overflow warning
Date: Thu,  5 Feb 2026 09:55:58 -0800
Message-ID: <20260205175750.653353-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
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

When LTO inlines mlx5dr_action_prepare_decap_l3_data() into
its callers, GCC sees the 64-byte stack buffer 'mh_data' but
cannot prove num_of_actions is bounded, producing a false
-Wstringop-overflow warning.

Add __rte_assume(num_of_actions <= DECAP_L3_NUM_ACTIONS_W_VLAN)
so GCC can verify the loop stays within buffer bounds.

Bugzilla ID: 1710
Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/hws/mlx5dr_action.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index b35bf07c3c..afb638250d 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -3620,6 +3620,17 @@ mlx5dr_action_prepare_decap_l3_data(uint8_t *src, uint8_t *dst,
 	uint8_t *e_src;
 	int i;
 
+	/*
+	 * When LTO inlines this into mlx5dr_action_handle_tunnel_l3_to_l2(),
+	 * GCC sees the 64-byte mh_data buffer but cannot prove num_of_actions
+	 * is bounded, causing false -Wstringop-overflow warnings.
+	 *
+	 * Valid num_of_actions values are DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6)
+	 * or DECAP_L3_NUM_ACTIONS_W_VLAN (7). This check gives GCC the proof
+	 * it needs that the loop iterations stay within buffer bounds.
+	 */
+	__rte_assume(num_of_actions <= DECAP_L3_NUM_ACTIONS_W_VLAN);
+
 	/* num_of_actions = remove l3l2 + 4/5 inserts + remove extra 2 bytes
 	 * copy from end of src to the start of dst.
 	 * move to the end, 2 is the leftover from 14B or 18B
-- 
2.51.0

