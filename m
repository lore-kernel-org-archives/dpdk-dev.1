Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D668BD2629A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 788A0415D7;
	Tue, 20 Jan 2026 20:54:39 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id AF3DF41101
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:36 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so67683205e9.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938876;
 x=1769543676; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvLVZyq2iZSb6LEJzDCscM57pNWSCSd5WF0DON4D53w=;
 b=BAd2mrdSUj7NtkUpqCaPGRXJuSktB0qE5KNw/3RyKtGp2hLf/0J37ixfoRWWf8wN/M
 SpkUwzxYE9BKMWue1TEgI5Q8cyIdF0v4s+KGcIrhnfFKMKOHm70y+LJD/0eaZcjIkeBH
 i+zR8SCYbDfFM7v714MXdYIckTtUUWT7O8uzst32/KMms4gFOmfKw2X0HIC8aPc8Ob8q
 06Lz5HAukwCp2oVEQVjz/ALYaR6ZpACx1jtAKi3zRLmWTkLuij6qesZJsFf7Da6nWS1U
 bY3HhRxLgpzPmN9DvCpdIrYa33ZAYnpKPnfuz+4ArQU71znfMqJ0DZJ2DYesQcp8LIVn
 JrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938876; x=1769543676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvLVZyq2iZSb6LEJzDCscM57pNWSCSd5WF0DON4D53w=;
 b=osqVDSvKd96Zrg5pvnXXw065hIGHakJkBTFx4/V24Y+gd99CjaTfVKlnU8n63t0K+N
 YbmM9fjELbH5J4O2YsjRBTqAPDJNxxcpvPiuNHacQSrcfiT5yj+XtN+9Jaj9RccMO1VC
 wAuDPmWQ/oROLJOrKr25eMzBN4IPS9pLJWzViNFoEIeKAKrUs1TSMebrNEcvqZCNPS+2
 1ZSkT+UQsHA+B2y+U+FmuxUKV5GTN3FNipYjoNvZezphHgH1VDCF9uqyCL4YjrmTXPBO
 xynDaB01UzZeT5LQYceyE3BXTz3VrfdL+F2AlL2X6oI2RRk6DTxG909eNnahUGEJYYQv
 /U2w==
X-Gm-Message-State: AOJu0YzJGTKuqCI7xIsrtOMTm7NJOjHqWSUXNZH8Dh6Fnu4itDSU+ltN
 uQ6V0sTE/Gam9LrHYkOgp7WytdYVpuyN6tMLRBS6Lrdc/28X60vmfFp082fnykKAUbv9ufCRbry
 XTQwZ
X-Gm-Gg: AY/fxX4HJLlYmrKFEkRk0B3m7fthE4TOogRVWh6C6jd6XJkcpfByhMHZzwZTeouc7ED
 +weOju2mLu/4/hEv8jyalcK/er9YrbSOphamUcolMCjKvIgW3dgW5QARdawvFfL3MPB0fwGTeHG
 Gbgzd/aAvZdvFXVpmL9UYqcxmkZQa3ilktvSjZhKLOOIrm9fKNslUkPrNcZiSo5Rtwqc2iVgT82
 LhODGyJr4k4XNv7596HU9GVzsXNOoZa4dNttbeeEBbcpwpr3BFcBwiss02GGv1UqotXRPhUVk6X
 mpV+e1TA4vxImRgu+rTg/xTi2p4zr4SIXAiABSKF24u5Mq5wtdM+vzMSiyuItSf7LVixAnRZv4N
 IqORbamY8UUa2yGN5rY5VZlLl96XZQCA2UVY78yeRaeYvO8essnOF1BsAaOSt4mMb8YewKuQr+C
 Qc/FI49sBQHIR+xM/dz8qpQMrIpK+DRZNzfll0nwInBi9P3H/wMQ==
X-Received: by 2002:a05:600c:1388:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-480409ca767mr32076615e9.3.1768938876262; 
 Tue, 20 Jan 2026 11:54:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Erez Shitrit <erezsh@nvidia.com>, Alex Vesker <valex@nvidia.com>
Subject: [PATCH v5 5/6] net/mlx5: fix LTO stringop-overflow warning
Date: Tue, 20 Jan 2026 11:52:10 -0800
Message-ID: <20260120195418.466318-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
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

Bugzilla ID: 1710
Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")
Cc: stable@dpdk.org

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

