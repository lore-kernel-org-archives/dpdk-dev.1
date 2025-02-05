Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC79C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 266DC40B9F;
	Wed,  5 Feb 2025 17:25:50 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id A040F40A80
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:47 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9cd8ecbceso3345148a91.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772747;
 x=1739377547; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3LGmbm/VIgUuKqHEprS43HMDH8COHR0Pe88EqWZ1M0=;
 b=ea9hg1SGdP7EeW9iQWDv2FUGyHp/cxDY18ODfY+WxUOLJVIjlqdkreTda8BF4RaFJ9
 gMhU0RnOKE47txar5o++fPjzdEFQEhDgwMhrW063uWp4+rv3GFNKuZAEKBx4G0Fxg7sm
 mq5giynzprqL/c7VX8fZ0gV+TGt8sn8aIvzXAHHDDsCF80v5//FJ229HVQqsaD1W+Y41
 5HwRtG2Hjho5J+fZq+fnBWRM8Egq/3/8sO6HTy7mPkcmwFF3gBP7VOzrfgSiQlQEHXGh
 jzSopR5lB1cYl680kjW3cB1b7RIIkMtZ5tu0dS4JRRIJxo0eRJv0dLnrfGqnraIHK7es
 pwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772747; x=1739377547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3LGmbm/VIgUuKqHEprS43HMDH8COHR0Pe88EqWZ1M0=;
 b=kVX2LgrrAXLrl/yVi3NGLRNyG6QPC7u5ND0CquNN/kCjXeTTP2mHf3oBZPamoKH77+
 5UujgKalszD1MfJ0LBmfDtldrD9FTCfHdKLPldrQY3g5aBYSrdmMatebNJhfxlK4lPVb
 pBJEGXYyTovoNLo+qAPZMWITDQkID+zaIV1c0SojqTv+RlAyHWvPm0sg0EYTgwOUcPTr
 hyOR3TKp9RbZNPEkiJWg1IMb0Jpz7MdtINZBAwhOKQnNlHolUH3GhQR2tdae+DCc22td
 G3OVtGWNm56GqHJp/YnSJZX64THruuaIWb4yeZJCZRHhJ55tTiu1CZQ88WduDJQk2oJn
 G3Jw==
X-Gm-Message-State: AOJu0Yy3CmnP8izf6natsTYi4WgzULAUFjH773aFkq8zGYkfpUmbLauk
 S0Pvl4oB9yfq8jAHvaXa7l7ih1/Jw7SGx3PLbD+7T4fu6VOT/r7YaUq75pPVfjf5Qwf/HWBXPvn
 m
X-Gm-Gg: ASbGncvptfNgF0G7tTOW6hhj1mUB9mra9ErWzBanpw8ag2hbvh+e/nnpGcJRODm7Av0
 AktAziEdK9f7gOe8P6Ld2mAup0LHmyIP5yGrGcyRB5eM+16MchZX7MhUbFFp0bOsLFaZa+JN8LD
 wNeXw3vOSQPtv4DjqBX7G8Gqa9fimpx4TYMAtnfiWszqrKkOCDFx+0kPThNXdUKNiJ9wVfdmMYi
 tmTQrh01jfJ6tbhQxZSw00RiEfxbg1XpxiIZ6es73FodOmMtu1k4nc++lY0koEAMxxiNsHj9y7j
 ahIounv8aNNWHLamCIm+YUJRSe7lTf97DM/NpUPvdkPMkuOTOY7GFhUTfJxkneZUrhOw
X-Google-Smtp-Source: AGHT+IGZhYLrGfACI0WM4NKtj4XhDdU2iW0H8hxXptxnIcjXSF4RPUDC6ik+k6k/aHXkYlulo9chUw==
X-Received: by 2002:a17:90b:44:b0:2ee:7411:ca99 with SMTP id
 98e67ed59e1d1-2f9e075382dmr4886475a91.1.1738772746823; 
 Wed, 05 Feb 2025 08:25:46 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, nipun.gupta@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v3 16/19] net/dpaa2: fix bitmask truncation
Date: Wed,  5 Feb 2025 08:23:17 -0800
Message-ID: <20250205162448.161161-17-stephen@networkplumber.org>
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

The dqrr_held mask is 64 bit but updates were getting truncated
because 1 is of type int (32 bit) and the result shift of int is of
type int (32 bit); therefore any value >= 32 would get truncated.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: 2d3788631862 ("net/dpaa2: support atomic queues")
Cc: nipun.gupta@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index bfb5542bbc..cad15d8f75 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -933,7 +933,7 @@ dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
 	DPAA2_PER_LCORE_DQRR_SIZE++;
-	DPAA2_PER_LCORE_DQRR_HELD |= 1 << dqrr_index;
+	DPAA2_PER_LCORE_DQRR_HELD |= UINT64_C(1) << dqrr_index;
 	DPAA2_PER_LCORE_DQRR_MBUF(dqrr_index) = ev->mbuf;
 }
 
@@ -1317,7 +1317,7 @@ dpaa2_dev_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				flags[loop] = QBMAN_ENQUEUE_FLAG_DCA |
 						dqrr_index;
 				DPAA2_PER_LCORE_DQRR_SIZE--;
-				DPAA2_PER_LCORE_DQRR_HELD &= ~(1 << dqrr_index);
+				DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dqrr_index);
 				*dpaa2_seqn(*bufs) = DPAA2_INVALID_MBUF_SEQN;
 			}
 
@@ -1575,7 +1575,7 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 		dq_idx = *dpaa2_seqn(m) - 1;
 		qbman_eq_desc_set_dca(eqdesc, 1, dq_idx, 0);
 		DPAA2_PER_LCORE_DQRR_SIZE--;
-		DPAA2_PER_LCORE_DQRR_HELD &= ~(1 << dq_idx);
+		DPAA2_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << dq_idx);
 	}
 	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
 }
-- 
2.47.2

