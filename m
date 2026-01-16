Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81FD4A605
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 326EF42DD1;
	Fri, 16 Jan 2026 07:47:08 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 8602942DFA
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:47:06 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so3026330a12.0
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546026;
 x=1769150826; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEBpuz0XMWgjRIY+0XwVB4PTikmtUzjKOyAXpCG39hs=;
 b=hHHTqev82YETY7LpZ50wxVHf7f+QXvNrhq8SpzSlRkDupXU356BZh6ClxGHPzwXl7I
 nKNVM28MFfN6NAvlFOgCHFYzA0xXOeIOEXYBVTU4/3zmU7Wxq/QZVgzjR83eqn+j6LNX
 NgWvRZVV3bYD4Vzd6jhnQorXY37BFZMx0+SmY+UTbYq+ISNovHqtwjjv6icqW5g220V1
 U6pVpXFTkGVYcv0qdRwvKjCqn/4NIIP57cHPd8lJ6EksS/uurdHis+XpoK/cLfCsqugn
 YtvQ8dArSfi6m7WcjqzU7/4MqVHbThegfEbnZa6X9+FphA+/QMotj+/Pj5p8eXAoWkaA
 akug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546026; x=1769150826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TEBpuz0XMWgjRIY+0XwVB4PTikmtUzjKOyAXpCG39hs=;
 b=X0s+KIQ5DtJG3eakFt7kmj106XudRzNZ8s8Mdo/9fGz46l4fp/4rU7/shGGze2Xu1B
 v5uVE6g0LOI2jqYF8+T+pqhMRmwCFD8YKfTWow9d7s8Hutvb6hK20/2M7tNus0svUYXI
 C4cY+TZSUSbIpOAHrvgCGBMpPgaa2aFGPUbCrkmzOTLkmnPIhSEvD4cZYRaMAlJGnHVu
 lcin0c6wYwOyLf4ekjUDsjwRXS9jMdmZfbGE2Ha/4mLpJJGUqKuz8U58/Clxha8gwqK2
 4iheIoA75VozeO1AP36ONbsSWbvwN6vSQjEfoPPAVNntgdnsshFK+Z2jBK6crx63mgp0
 7lIA==
X-Gm-Message-State: AOJu0YzTYMtVmmeB3OZPlf+pc2Ji5MCLiZl0K1v51HMA7s6qHPAm13qL
 PXl1DU17PlfgwIpoqoxF2XRJBHBafwXeSva4KCXS7zUbAEdpHAqGwwdZfU3Paz1BvJw5waRO9Dy
 fSS3f
X-Gm-Gg: AY/fxX7jRmWFx7k1YVfMXYmkKyTayOkLK5e5Q7JvgP2rnh97cys5bEtx13h8gbqQGFh
 U7UbDtlChZnn25fyNzet5nDmtxIGr1z31QA3P4os1bShP+h/Va2Nlcj9NUhW0zXl4Z1xGFmi/5Q
 pxd3O/QeBgEYHst8P77Yy7R4hj5mxi/W81iqv5eMKg/9NU9jAK9QUcmXLAcl51kRNh13FWbPPoQ
 ix+f/ftvodqS2Zq5dV9JZxGuWEsEXkSoNbsXBZYULp2t9xyB7faAEHySjz5Vhb1zxlFkHaZf8wP
 G6VvC/C5pPSvJzNNQ/z3AtiYkqS/djsNpMELvo2FpQ5GBRsJcaUId6gmJAu7E72m5mrhg+zBvJk
 icQb9n1pjWzIdQvgQlm0uFLcShgCFx6MIAE+r8hCLeaQaDh9U7xBb+DWaUukGlD1JYb1mXC8zfI
 yxgt12UttqkX99Q40nMMaCLQeTcOhtNdx38rW3hFDJyHtvlJHvGA==
X-Received: by 2002:a17:907:d0d:b0:b87:c13:f334 with SMTP id
 a640c23a62f3a-b8796b85d4dmr136382866b.53.1768546026048; 
 Thu, 15 Jan 2026 22:47:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:47:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 6/6] net/mlx5/hws: fix LTO false positive stringop-overflow
 warning
Date: Thu, 15 Jan 2026 22:46:27 -0800
Message-ID: <20260116064646.224254-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116064646.224254-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
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

When compiling with LTO (Link Time Optimization) enabled, GCC's
interprocedural analysis produces false positive warnings about
potential buffer overflow in mlx5dr_action_prepare_decap_l3_data():

  In function 'mlx5dr_action_prepare_decap_l3_data',
      inlined from 'mlx5dr_action_handle_tunnel_l3_to_l2',
      inlined from 'mlx5dr_action_create_reformat_hws':
  warning: writing 4 bytes into a region of size 0 [-Wstringop-overflow=]
    memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);
  note: at offset [140, 524248] into destination object 'mh_data' of size 64

With LTO, the function chain is fully inlined, giving GCC visibility
into the 64-byte stack buffer 'mh_data'. However, GCC's static analysis
cannot determine that num_of_actions is constrained to either
DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6) or DECAP_L3_NUM_ACTIONS_W_VLAN (7)
by the callers. It assumes worst-case bounds that greatly exceed the
buffer size.

Fix this by adding an explicit bounds check at function entry. The
valid values for num_of_actions are 6 (no VLAN) or 7 (with VLAN),
which produce maximum buffer usage well under 64 bytes:
  - offset 12 + (num_of_actions-3) * 8 + 2 = max 46 bytes for 7 actions

This provides GCC with the proof it needs that subsequent memcpy
operations are safe.

This is not a data path function - it executes only during flow rule
creation, so the additional check has no performance impact.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/hws/mlx5dr_action.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index b35bf07c3c..3b12506577 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -3620,6 +3620,20 @@ mlx5dr_action_prepare_decap_l3_data(uint8_t *src, uint8_t *dst,
 	uint8_t *e_src;
 	int i;
 
+	/*
+	 * Bounds check to help GCC LTO static analysis.
+	 *
+	 * When LTO inlines this into mlx5dr_action_handle_tunnel_l3_to_l2(),
+	 * GCC sees the 64-byte mh_data buffer but cannot prove num_of_actions
+	 * is bounded, causing false -Wstringop-overflow warnings.
+	 *
+	 * Valid num_of_actions values are DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6)
+	 * or DECAP_L3_NUM_ACTIONS_W_VLAN (7). This check gives GCC the proof
+	 * it needs that the loop iterations stay within buffer bounds.
+	 */
+	if (unlikely(num_of_actions > DECAP_L3_NUM_ACTIONS_W_VLAN))
+		return;
+
 	/* num_of_actions = remove l3l2 + 4/5 inserts + remove extra 2 bytes
 	 * copy from end of src to the start of dst.
 	 * move to the end, 2 is the leftover from 14B or 18B
-- 
2.51.0

