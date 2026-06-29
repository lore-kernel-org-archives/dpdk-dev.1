Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F49AC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 04:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A22554064E;
	Mon, 29 Jun 2026 06:55:30 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 09FB7400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 06:55:29 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-37cb36ca63bso1164237a91.0
 for <dev@dpdk.org>; Sun, 28 Jun 2026 21:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782708928; x=1783313728; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMVXB12AJDDUpURQmMV1/jhMZr5SF/x+6YFX5meT8bQ=;
 b=Q/WmrfzJi3fWbqtqEMvsEu7KZRTanEjdkw1570l1m58Jw6z7G15Rg9lBt7AyjOCkP1
 Ess2+LhGuMGVu3TbxjQpzzlCIzZDaLz8xwck0730+p1ShiW/cGd8li6IRRtdxq4DGyXa
 6RFlnMOjWfAGD+UT85aBOO7llvOKizQPTqLGdS1oyxy+zCG7QL93dhckQpgJNz3Tix7n
 uSTzTjgcRYdW9E1vtWuKR9jWwqid+NMH7dhLL+DDNEzkZpOeOaER/hnFBw4ilMR3//SB
 E8RLTbYIgCXvzOE8IC11FzFAr7WQglb0ur2bQK1NBnFPM/xQHAkNdDGO3EEpg0yDlC9b
 TzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782708928; x=1783313728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AMVXB12AJDDUpURQmMV1/jhMZr5SF/x+6YFX5meT8bQ=;
 b=j4CxYV+RTiZbKJTfmI2WcJ0Kr8PAM3DzSB0dtddUIZBoBVYnjcJb8LTvqF0zOWUvuP
 URSnLmFfbyjY7zd5mhZtTXPsMUs5u2XwDR1uBh4Bs6PRK2tsE4xTLGGb8l53x8q+8/WT
 JH3kmMzRPy1EnBwTzB5NZp7pkfidpGlBds76KWp8Wc3FZBD2dnuraJ0nWWUDJPuRqvoB
 qvL7gt4uoKb5WpEzXB/+w1ZAKGQmNlOjMOhelioX1M8c9r23nZpIccc6sk+CuNX05vZi
 Bcz/EO1/M71g5dqrouysjNo8VQ9ggK6P7zD1ZfxaO7Pr7p3hrwSI3dV1nEgfBT5zUftY
 y5tQ==
X-Gm-Message-State: AOJu0YyyqTIfrVGk4bSvOvVsY3G4qIKDVgJfbGzvFDQdPne9gQqlySeX
 PEL19/ecZ7VJ0UxTEnv2cm0U3FQIru2YxugDbRaOpWJdiYGj8kb4eEtY
X-Gm-Gg: AfdE7cnDAShp59CWAGvJndD0szcJFVFqBvozusB418v/chRDCDVHjQHl5uuBDOQulje
 K5N/wghpK6zU0MqF1d9shAQoRH8ZsywEQ707aHSD2zcXq6q76h9ZHKZfScQhZId38NRj6k1aykf
 sPo5nB3VZf+gflPNGI7Ri4JABr4vXOnIRD2U6FX9zUVUslWJ863ZnNnyFUQjtWSRdWS7DdC2tsY
 W7mqaTbHlK/0fIDGpdjSwFx4UngPb5QWhSSfnVm+0rNVMbpyycQ8J8nktBX8XijYcmDbGj5V04e
 9aRrfniSHKm55EOyXjr4c02eOMbsq+91+s+UyLchhIRBjcNtuvEzBE4tzAsFRwxSAxRIxjG0JCO
 lbH5Svf8erf0iB5dFBdvLFMmL8wMAs3hJbnKMowxSCBLaIi+t5XSTIdv4XjAkHyesNzoPpeRV/2
 jc07fBYAV6Hg==
X-Received: by 2002:a17:90a:c885:b0:37f:9ce0:af35 with SMTP id
 98e67ed59e1d1-37f9ce0afa9mr6475832a91.32.1782708927993; 
 Sun, 28 Jun 2026 21:55:27 -0700 (PDT)
Received: from peach.. ([240f:6d:285c:1:c9e8:4a97:ed9d:4714])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c99f2905e76sm1079533a12.10.2026.06.28.21.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:55:27 -0700 (PDT)
From: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
To: David Zage <david.zage@intel.com>,
 Song Yoong Siang <yoong.siang.song@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Shuzo Ichiyoshi <deadcafe.beef@gmail.com>, stable@dpdk.org
Subject: [PATCH 2/2] net/e1000: fix igc Tx descriptor ring wrap
Date: Mon, 29 Jun 2026 13:51:14 +0900
Message-ID: <20260629045511.473850-2-deadcafe.beef@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629045511.473850-1-deadcafe.beef@gmail.com>
References: <20260629045511.473850-1-deadcafe.beef@gmail.com>
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

igc_xmit_pkts() reserves two extra descriptors for launch time.
It indexed sw_ring[tx_last + 2] without wrapping the descriptor
index first.

If tx_last is one of the last two descriptors in the ring, this
reads past the software ring. Wrap the index before looking up
last_id.

Fixes: 2e79349dcd07 ("net/e1000: fix igc launch time calculation")
Cc: stable@dpdk.org
Signed-off-by: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
---
 drivers/net/intel/e1000/igc_txrx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
index 1ab8f2079d..d61fdb33a8 100644
--- a/drivers/net/intel/e1000/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -1834,7 +1834,11 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * The "last descriptor" of the previously sent packet, if any,
 		 * which used the last descriptor to allocate.
 		 */
-		tx_end = sw_ring[tx_last + 2].last_id;
+		tx_end = (uint16_t)(tx_last + 2);
+		if (tx_end >= txq->nb_tx_desc)
+			tx_end = (uint16_t)(tx_end - txq->nb_tx_desc);
+
+		tx_end = sw_ring[tx_end].last_id;
 
 		/*
 		 * The next descriptor following that "last descriptor" in the
-- 
2.43.0

