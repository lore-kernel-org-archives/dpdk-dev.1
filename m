Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E17C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D7E40616;
	Fri, 14 Aug 2026 22:20:49 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id EC7074014F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:47 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1709683a91.3
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738847;
 x=1787343647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IehSravqjWTjUhdjD95SSmcPASHMBFUi9+H9ZoDY/7A=;
 b=NPmCE27nC/VY6lkYeUt7M/Q4gYzddOjcu7dWGmJLGrbE80ZtHAxcJMCW3qH1RYtAaB
 CM/KsPypUAP/W6z0MPD1hBcpb/I1phKQhe0pG0nArWGZnjvl2ysMiNif0uXto+OkI5Hm
 n4f7zsry8/vQ3/CreMNygP6RlULjJY6WCnDKhWyqvdD9hK/OikX997NPUGVp3xdjFrSL
 ZvvQZ33cWYUdd56CEYFZ72472eekkW6dsAbvCKtrwJ864S5cRjXCWnsym6iah/d41VsX
 YmgeT6bqhQgTUM4hZYIVqR084K1Byw7n3v/EhK2YLgq0YP5JBJoWJL+Y9d+hBnLaWOkG
 gELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738847; x=1787343647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IehSravqjWTjUhdjD95SSmcPASHMBFUi9+H9ZoDY/7A=;
 b=ek5VFJyU1Z+VG8NxXKBvHdiYqPoX9/7ouZZ2aAbJ03a5HTE3C9UqHoUynTxT808USN
 lMLQjztE/X1+TwCsNBWsjQ9+oqit1FNCzrkMNV2T+NYywdyWONEy7nvFLsmZuNhOUQTa
 /Vgt+yfxl1Nd5DWFrjck7QMUoVXzQRWob/Io2AbYkh+6RywA2Bv0dwqC3bGtjnBsDm1W
 fZsaM8s9ewcrlliXO8O8PlETuQA+wjxmwviaLOSHtuh+9+g2AI0aZFwlrR1IWVPZfkek
 AIjNEyFfeBfGjjSalt5WQtnAFULjhJTNFy2okoqOzgWhZWo4g78lMO3tpmeCv2dgAjjj
 68xA==
X-Gm-Message-State: AOJu0YwFXUwRBAIypDXzBsdTcsWdLDmhdpW6Daj8LK0kcjTUUqgnz6pM
 VyH1d4OLKe0nY6gFhzw1GgQMefjXETVUWf8RAgc70jsriYHPjgp7zndaY4l4ZnV62sYNGYDjVIE
 qWbdj
X-Gm-Gg: AR+sD11e8d65sTCCmfE/+iqsT4rvL5i8G6j0OhH7uWcPN3jquiATDjWSar/xn9Efjfn
 z79um3TASTc57AZ31We0XM+fe3SFAWwMuKSQYlWRc4S006o72gUngAuxJwXBqbTI74ufwg5LIeo
 AoDbe+KYhZ7omTBtgPSVA8l7RynEXRSXa1RmaSpSxdMsYEf6Lm6VREJIFFyyRHAYA/3pMJ/F3JU
 UCTrL9ipHgK6+mNmRu2lUvDKiiFCmP9PwfsXif3LrZB4FMwbPssLNG/vXDgQCGKNdOnmsBhHDXI
 ppw2ECH5qxhHJOGGFRVBMcBIm3+5z8cGSTE2evubgYKdAC95KowxFbGqiqsiVhGCRqpKgef+cMO
 YJCoF2ZEcSDgO7bsnluYsRS1jyQ3uwKbnsfXmlYIcb7LiOr2BHIVNdQZLoIgOVFR/+bbsXUAQiF
 KaFKW0bqfup4mOomYoXWfZBnYG1DUEH3s2JaMoEm8c2PUx6jIYXLdplc9UF5PLnTBkPgcrpiKPb
 oSKMT67G2GjL16k+dzGjFmnRh8=
X-Received: by 2002:a17:90b:498f:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3933e5d333bmr9476012a91.13.1786738847090; 
 Fri, 14 Aug 2026 13:20:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH v4 14/16] net/xsc: fix Tx errors added to Rx queue errors
Date: Fri, 14 Aug 2026 12:46:10 -0700
Message-ID: <20260814194757.329424-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

q_errors counts received packets dropped, and is reported as the
rx_qN_errors xstat. The Rx loop fills it correctly, then the Tx loop
adds the Tx error count, so rx_qN_errors reports both.

Tx errors are already counted in oerrors, so drop the assignment.

Fixes: c80ab1a551cc ("net/xsc: support basic statistics")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/xsc/xsc_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 39a67ff8cd..505f973d66 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -614,7 +614,6 @@ xsc_ethdev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		if (qstats != NULL && idx < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[idx] += txq->stats.tx_pkts;
 			qstats->q_obytes[idx] += txq->stats.tx_bytes;
-			qstats->q_errors[idx] += txq->stats.tx_errors;
 		}
 		stats->opackets += txq->stats.tx_pkts;
 		stats->obytes += txq->stats.tx_bytes;
-- 
2.53.0

