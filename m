Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A4D2ECEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2448240673;
	Mon, 19 Jan 2026 23:46:14 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id B9E3A40673
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:46:12 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so26094095e9.1
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862772;
 x=1769467572; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvLVZyq2iZSb6LEJzDCscM57pNWSCSd5WF0DON4D53w=;
 b=S5VDKsVXi+QRoVDAMUclUhWUiuMHCwFUxYtjnOQpNqKzVQ5HBXS4IqtMagoztnqcoa
 ne0p7yaknUuOjqUsaW34sznL3HPIGCA0aGaTqI8IAjL7gDi7+YUjXwQIlBAHrQQ2zdgc
 jCqsVwhz2Flsoxwd8zTkQw6Mbl40DP1axgB12FcnAjB96djr50KgXucUYOcxJZydbF3l
 tQLuZdVkzHMGstLkOtsFWu9Gv5cSmu+d64rnIw5WpUshjswjM0oMJ5UgR3j9m/GsD1t5
 K93/4gyj6B965UloVXeT8JTO58OmICZrKeeTDGao6nYEKGBKVwCw3K52Mf7YetPaM+jG
 CF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862772; x=1769467572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvLVZyq2iZSb6LEJzDCscM57pNWSCSd5WF0DON4D53w=;
 b=eeoeyVWUxAi7LMA200lyEDK9tkkdH0k31TmATYhLUq8lY8zxHgewG/hh1KFOOM7j1r
 3P0e9b9ASO6vthySDkJ5VymebeztKUHB7KA5PzMoQlUjyKzMq4e8GAWFme+0Z2LBgOA8
 8+JEiAwhfn27QbyE4lSAXXarvVD3IARsc2LkaNig25gBIji3AQPOWvddMiY4c4I6DeCV
 PDtQLBGcNzMM0cl6iEFDyZp9dkmKWAeGmzFKQmeA2ehiuWu9p9ta6CthUFUrwEoQ2IRU
 /j4zDnOG8FudeBb/rmcxaPqnA9o+pDXZryCReTAteMRgNiASvr5KEgJCZGRMeelNjggN
 RIIQ==
X-Gm-Message-State: AOJu0YwdsCGn0N04iWl4e3Jab4cII8uUkTuPHMHhTz8P8SGkuzx28sOL
 qztI4gqRoTC1dkvi85uIqHUS1mHI4CFJcyCWJQuNj/aW0tmQZCSXYMqe4rdJEiiSa365sgda8U1
 q/yVT
X-Gm-Gg: AY/fxX4UzPPhQ3UPNWHS9KAuqC2NMwan2LgMFfbf2ITdenE0vd1GpsBmAFWL04hKnlW
 DmSPWUT5Nf4uwEyOPAwWG21BDrE4SoEOPcj3jort/re7y4UwHuNU5MklvVh05JRoFAtt/qrszn3
 WYrYdopEmcvEK/LQalSIy6wV7pF68FOuwyb8Xk0GYutbuSV1nJ9JPkfauSBRnx/l3EUyuX2saoX
 DfsscNA3k7wOY+/9C+9Yp4LBoLC2atUB4nZONemEIdMYpgRAwLtQGyh1Et8ywQ0TTcRKoZptfjA
 5QkwdBMmYnCY0Ugj3dDwUDSnMb+rh7Hv8c0gFwO3j7yVOZh3qJWtFLgUkr3w7Sd63R8uhvamAof
 bpnX4+cy/Vm+UMT/biWDlI2Cq78VekRUXtHIh4Rm/G7OvgJcmDUlYXcGkMUoY5wvMXUhuVIm4Zi
 zzfLKlP2o/IUmFfD/KTygj6p4BZ0R7hT09n4VoR1qCqbnkg11AkA==
X-Received: by 2002:a05:600c:1c05:b0:47e:e952:86ca with SMTP id
 5b1f17b1804b1-4801e2f28edmr143587105e9.2.1768862772357; 
 Mon, 19 Jan 2026 14:46:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:46:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Alex Vesker <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH v4 5/6] net/mlx5: fix LTO false positive stringop-overflow
 warning
Date: Mon, 19 Jan 2026 14:44:12 -0800
Message-ID: <20260119224553.226243-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119224553.226243-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260119224553.226243-1-stephen@networkplumber.org>
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

