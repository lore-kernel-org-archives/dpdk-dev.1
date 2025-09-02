Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281E3CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:45:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC9A6402BD;
	Tue,  2 Sep 2025 12:45:00 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 671D2402B2;
 Tue,  2 Sep 2025 12:44:59 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7726c7ff7e5so782058b3a.3; 
 Tue, 02 Sep 2025 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756809898; x=1757414698; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lWPycfEhwZ7MST81hkCOD0H4ZN+C87jpQXfREqQpbBo=;
 b=kN9nthxEkrjEJAGFXAdsvUlKC9hi2kKPAaompIZ3csUmO2pTbpgdYNsEkOFAlSE2np
 MVbn4vLItdHKxa2chTT/3oIQTw1do5fIVKN8Bf1fGfxuY+D+CSEZn9vaBEsTrr67Vhw3
 ZzSoSJDHuJMFuSJU/XHSCmHqMbXWs+C0jWtyTJNjLR6V02v2n59nJB3AVGnHr8/cQo3R
 7gUVGEkOvlhPRjqswp67AUGs6LwtxRzZrrUweInpanV2A69FYquKc1hmmBq7INv5GMs5
 sqR8xyZMhxpe5+J5nl2XMkFJmgD5udQ4E/m0EaVIblAohVDmc07L9d4AhdMvw6k27KKs
 BiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809898; x=1757414698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lWPycfEhwZ7MST81hkCOD0H4ZN+C87jpQXfREqQpbBo=;
 b=FFKOvdy2kT1iBLVzQPURuXGjUtkXLzcaTpoIiOghNwL8CWbtJ/jNXjPhVszX2wI+xu
 idw+qzm5dRYCPccspg4zdAjynR65b6Na2SK534lrUSGnFswmHJxhcCTu7PC7wq22qa8J
 2FlIGz6ZigbPLjsr9iMp1ofKZCkXCpBwnqWeqtLNUGh0Pcv7z+7bvVP0cs/20zPS8d5s
 jQtdHUcl26Hn4cglob7n/54kzDDP6UG23GduRUZkRj8obaw14jSKjd0zy4TIvt6SI3S+
 Av4uOu/kOClUedo3HzXROICBwr0DImATqCkOV4hdy8WaZeyJuCXiHG1VOXOnKWtcv5cf
 UApA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb27lrQZl1tALi4mY2PKJiMAKcq896kggX9SUzkEQ7CVwTy53+UqBCIiyaUFhOyVGAC5ENu7M=@dpdk.org
X-Gm-Message-State: AOJu0Yxn7AyXV4Wq3kv9NwESu1sVLnNB4gamEwaYX2FFQQHwYlhJk7Hr
 22qBhWs24d0+9W82z2Vi3lRMblx8noy2YqOKl0zIykvE4p9DoScQWmSl
X-Gm-Gg: ASbGncut0NRZUvJMoaNjA4Mb+I8u3LTEMuZCW4fs2ugrDURWBE59v9qIze4/l+yk8c7
 cUkd79BdluY2+P1rO8VWotFUL0dGe1GbuRTrJIlqQE2vzVoE38XJ+B8vlKP1EG9pqkWwWOVVyYk
 gIKLh73K1M5ed0WfqTbW+XHZ/CCuqPfg8hoxBWcxPs1b5t+zjIzBo0UdlykOq2tiwd3bgA0eovs
 zeemn0W4aD+olEtfkLhF9FSznceLnsR35Tp6tW4ngU+jC3WE1uPNO8TWtEJ/b8w1eCOr4FAwabH
 2qKnuCvD7b+1I+pcsPYmospBjG18OWALe8M0Ls4+rTzyxERMVKFaX6h0hzGEw8SFaTvz5xI2YV/
 CkVltZ1bI/OY7Uzav910Haa2PhQ==
X-Google-Smtp-Source: AGHT+IEYSN8a957f63cVy2xaqcA5BMO43JSTI1WH6DL/q5teQnVOGHwqcvbcJ28ULaAAIKr0puGTQg==
X-Received: by 2002:a05:6a20:938c:b0:243:a000:5be3 with SMTP id
 adf61e73a8af0-243d6dce65emr16971278637.8.1756809898404; 
 Tue, 02 Sep 2025 03:44:58 -0700 (PDT)
Received: from tp-client.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd073c207sm11444590a12.18.2025.09.02.03.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:44:57 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: kumaraparamesh92@gmail.com,
	hujiayu.hu@foxmail.com
Cc: dev@dpdk.org, stable@dpdk.org,
 Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Subject: [PATCH] gro: fix payload corruption in coalescing packets
Date: Tue,  2 Sep 2025 10:44:51 +0000
Message-Id: <20250902104451.81876-1-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.34.1
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

In the current implementation when cmp is larger than 0,
the new packet is appended to the original packet. However
the code is operating on the trailing packet to update the tcp flags
which ends up corrupting the payload of the trailing packets.

Fixes: 547f29435769 ("gro: fix reordering of packets")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
---
 lib/gro/gro_tcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gro/gro_tcp.h b/lib/gro/gro_tcp.h
index e9be7b95d1..43383e47e0 100644
--- a/lib/gro/gro_tcp.h
+++ b/lib/gro/gro_tcp.h
@@ -133,7 +133,7 @@ merge_two_tcp_packets(struct gro_tcp_item *item,
 	pkt_head->nb_segs += pkt_tail->nb_segs;
 	pkt_head->pkt_len += pkt_tail->pkt_len;
 	if (tcp_flags != RTE_TCP_ACK_FLAG) {
-		tcp_hdr = rte_pktmbuf_mtod_offset(pkt, struct rte_tcp_hdr *,
+		tcp_hdr = rte_pktmbuf_mtod_offset(pkt_head, struct rte_tcp_hdr *,
 						l2_offset + pkt_head->l2_len + pkt_head->l3_len);
 		tcp_hdr->tcp_flags |= tcp_flags;
 	}
-- 
2.34.1

