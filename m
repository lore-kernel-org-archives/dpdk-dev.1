Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FADCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 04:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 580A640674;
	Thu, 21 May 2026 06:20:54 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 1D6CB4042F
 for <dev@dpdk.org>; Thu, 21 May 2026 06:20:51 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2f0d3e07e30so19373902eec.0
 for <dev@dpdk.org>; Wed, 20 May 2026 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779337250;
 x=1779942050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b73O2TXTVv19quefI4cAAQ2+gs3VWZJKaHhhmrw6wqI=;
 b=soL1yt08qRyWY/1rNkwj8e3iNlc5sYGfjvMDALBAgFGM67IA8SIzdNod4gTP2qd9zj
 V+lAdDx2HafnasyeAKe0x0u0XYIQsc5UXqn/HKQ/BhEMVw9Jzr/DmjEBkPgfReYy7o39
 /OvouVOenhs8C1XDtZfdq8mTlpRWNAqMWUU6u0WudynAOIzIiphhGTHhW5n+K9yzTtO2
 6Brg8uc7Rh0B7g1olTB/0xQNyfAsPyJgYvD1h9qYNqElvPR2sMZkeGfXiL2u1IILoVYs
 PdasWRa75+SKJjG90cXu3SMHc4bM5gro38ZxEvdvrduMrWBiLGG6Abutinko4R3mz98P
 kS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779337250; x=1779942050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b73O2TXTVv19quefI4cAAQ2+gs3VWZJKaHhhmrw6wqI=;
 b=AWcXogO6dAGwYNaC8qsJRotIbbcQX0Zgl08UPkCl4jXxpHBYhBCEfCxQmtBOsgBJYL
 ZHO7NKeTainr8+8/GNXsMo53SUxBSoPg7l6gHsBinddTzAMfE5mffD78LiC6bojMi16z
 7Uk/wyShpjKnY5HKIVlpj0R3Te+AW58HB85Z3wiOnq0N/43qF0Le7aXQ2JdJRMSwEnYv
 VGFOE/s+xb4Eb/Mj/bTHqDKX/CROejZujh/GiYNC46+N/P5lHMf6H2Tb7WNj+jrVrevq
 1I/wccHMk5lTJ1nQogpC28zexEGam2u2fZPzah0W2/41wwEzgPKuNZu9nHsHnEHoo9Jp
 i2dw==
X-Gm-Message-State: AOJu0YzJaXnbQ9xy9xzNO/4lEXxVQE7Ny8YdFBAcnbkFfRGllQ3lOD1w
 SprDziC0KUlVqjRk6Vn08puL0EzWys7HoXS2PkDV9Q14mt5Wi4/QvMg0qyt/lRC0N5SiPuw9BqF
 DxzvD
X-Gm-Gg: Acq92OE3I+CDuzfqq51kPcCDVJEbbssOLETA7Y19lW0gnt/rxap4GKy4Pdcrtj3gn8m
 HCiIE4gbNMQGt8+WZWr4tqn33AOjOsG3BNufSSAV/8DFjAsoIs9qS6ZbDsKSGVsYfvi6LAgv2Ec
 kkMdid0SctUgS5lygWgd69oBIDMyejFskCmWcOtgcxzS4j/tydhM5V+TFVtDS7tkfeC5ysysI4g
 gmhaWVl4SxLPg9YtV+vBHoQOr4gxzWN1c1+65ChiNDb9xehMH4c1c2CVUmblmKoaCbCPT7loL/M
 x3BDZ5AOThEFx3/7Wi/wJHi88G/dcxvg8/SS53WjOubRPtRCj1JI+PL0Q+uo9tIm2ZhW+h3BMGq
 0QEvujTv/31ATvoty/TkWR+KiUByq5s6jfPtiWcVFG2/iXS8/o/ABIuvw+0jFNQoilanDkqWBhp
 Yi+zcd5CP/aDCvKXYL+A2/ydJ5jVaWJCdSB5lpqJyGEzbB6HXapgNhQsMxfCKrtg==
X-Received: by 2002:a05:7301:2a0d:b0:2da:b77a:d7a0 with SMTP id
 5a478bee46e88-3042f4540dcmr742639eec.9.1779337250140; 
 Wed, 20 May 2026 21:20:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e686sm24347748eec.5.2026.05.20.21.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 21:20:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>
Subject: [RFC 4/7] net/zxdh: work around GCC bitfield uninit false positive
Date: Wed, 20 May 2026 21:17:04 -0700
Message-ID: <20260521042043.1590536-5-stephen@networkplumber.org>
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

GCC's -Wmaybe-uninitialized analysis cannot follow struct
initialization through bitfield reads. The warning is currently
masked by inline assembly elsewhere limiting analysis depth; it
surfaces once the EAL atomic and spinlock primitives switch to
compiler intrinsics.

Replace the struct initializer with an explicit memset() so the
full-width initialization is visible to the analyzer.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85301
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
index 4b01daf37a..8f88181a3f 100644
--- a/drivers/net/zxdh/zxdh_msg.c
+++ b/drivers/net/zxdh/zxdh_msg.c
@@ -728,13 +728,15 @@ zxdh_bar_chan_sync_msg_reps_get(uint64_t subchan_addr,
 int
 zxdh_bar_chan_sync_msg_send(struct zxdh_pci_bar_msg *in, struct zxdh_msg_recviver_mem *result)
 {
-	struct zxdh_bar_msg_header msg_header = {0};
+	struct zxdh_bar_msg_header msg_header;
 	uint16_t seq_id = 0;
 	uint64_t subchan_addr = 0;
 	uint32_t time_out_cnt = 0;
 	uint16_t valid = 0;
 	int ret = 0;
 
+	memset(&msg_header, 0, sizeof(msg_header));
+
 	ret = zxdh_bar_chan_send_para_check(in, result);
 	if (ret != ZXDH_BAR_MSG_OK)
 		goto exit;
-- 
2.53.0

