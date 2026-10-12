Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D7CA9ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 16:35:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EA7A40272;
	Mon, 12 Oct 2026 18:35:30 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 02E574026D
 for <dev@dpdk.org>; Mon, 12 Oct 2026 18:35:28 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so831536a91.2
 for <dev@dpdk.org>; Mon, 12 Oct 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791822928;
 x=1792427728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q+AmqAis5OME/axUutkKKjDJkdM4JzVqVSPFLpM8dP0=;
 b=BLgiyYZgThhovWr4fk3bLvSzthiEtf1EXpPuoS/fyS0dYmAqqTC6ZZATBZmSj1qgho
 x52JIgB2z6MIMU/5hLqvZM+du5/VKthDEaE6mkvR98QPjuTqB5uL0x2fSjVfJCvrxEqZ
 c939LKFjQFduQSMXOgEFbY1+1hd35gXPLxfKC1ehHPyIwkCM+P6aiZDa8yD+A/AY3P6r
 1nb5d70EP5m/g4hN31MYaSQ5Yx18wPTFgEuZdImGoonS2rSKBozDS813UxfnUa5zZPK3
 Yi24XWTWv4eHRIyKnDvgBeIy53eG1z6GhZgZoGabmCKsf3LKhPR4o0lSLovcCD2a9uVe
 IwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791822928; x=1792427728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+AmqAis5OME/axUutkKKjDJkdM4JzVqVSPFLpM8dP0=;
 b=RrzJDmxXERTM+WPWR3KzAfKJp+Nb8BKG6+9yAFEIDpPUJwIqr7XStsCBI7G+PnJL4i
 SvV50qDeo5xVWHrr8EQEMmDOEdOm4NN/Tn4TjPoK/hMAeRKqtgjN4zPQDpZw/9bFQWoN
 vSxjx3LrmMutDEH83/wBP5I5ErJoVixuJgDFC13Q6ZYoNVyaUB002HkTTMXE4883ncNp
 wwXJEzBdwynOHCOk2bM/Jr0Oam+ArIym+1b7whroe4uAPA4sYyfoFFZ04i6LeJBrYPpH
 neRu1gVYmSW/P3pOfq5oy5N2uR1DNvB60JFYQVFGqz+Ww4MWcxZoV+xNbxjziGntWPln
 x5GA==
X-Gm-Message-State: AFq9FYIAMUTNbCuhFMYV4jM9MWtSQQ2RVd457bD2bICmMxrRNvNs92tA
 V7/tKjE4SiDTEkvJd/j4N4ImaS9dxZB4YKfJFoRRNI5qkoOEsyvjKHYlZutepOB+YhQI8QkUsku
 xXp2tuL4=
X-Gm-Gg: AYBFou3da3RCXlNdaFlaRN/4zEW4vDAOBfwLaxDq33jlHupAHUSiwgN5pLeiEjDQtSL
 xpZobSczbOuehWXFCkjxGxqVMk7XiRgmrHxVwr1/U/YXqD2yLqyOe36LpRSX6muFKEemKGJLQUR
 pIFmP77NUktyzJWtPEhcBlsLSd6DZUe6ycpUpnW1jObhYmv7CdPaEbMg89v8ZvlQoY6SXGo5JiB
 Jx3hZN1L090ZUMi70idVM1Fpx+oNFl1DJooHyl5Nzp+kAaS4s4XVDwuJOMj7CKcTswRy2db29/M
 wcg9Xpez7djuwLkh2Jd1hWNo6Z4QT84RnYXpp3BJk8lDj/yED0lyDhy7un19Wh20B5dGvpllxBF
 Wj6xuNIzoPnEYPFdMXBAZVLfvcU8c/iMam2JZdWHQUsmIHxKDjMKNEQDmE2XvbLBINq82r5JxSj
 oEcYHDPf+NVYtcsRDMWYybfo8xgxque8xo7q8yo5g6cbEr9bD2MRHyw6dJO0O5BJckw1H1NjIDI
 hxaRCsgTDQziNmtZ8CjmycVPXx1jL4fQZSAQQ==
X-Received: by 2002:a17:90b:4b0c:b0:3a4:9a7a:360 with SMTP id
 98e67ed59e1d1-3ab3a9550famr9217903a91.29.1791822927822; 
 Mon, 12 Oct 2026 09:35:27 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da04d46asm4619275a12.30.2026.10.12.09.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:35:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kamil Vojanec <vojanec@cesnet.cz>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Alexander Kozyrev <akozyrev@nvidia.com>
Subject: [RFT] net/mlx5: fix out-of-bounds stride index in vector Rx
Date: Mon, 12 Oct 2026 09:34:32 -0700
Message-ID: <20261012163431.267207-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The vectorized MPRQ path uses the software counter consumed_strd as the
stride index, resetting it only when it equals strd_n. The per-packet
stride count comes from pkt_len, which may not match the strides the
device consumed, so under load consumed_strd can drift past strd_n. The
stale index then makes mprq_buf_to_pkt() read buf->shinfos[] and the
stride offset out of bounds, corrupting mbuf metadata or accessing past
the buffer.

Drop the packet and realign to the next WQE when the stride index would
leave the buffer.

Bugzilla ID: 1369
Fixes: 0f20acbf5eda ("net/mlx5: implement vectorized MPRQ burst")
Cc: stable@dpdk.org

Reported-by: Kamil Vojanec <vojanec@cesnet.cz>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
This patch looks right, it was generated by Claude based on
the bug report. I don't have mlx5 or any way to reproduce
original problem.

 drivers/net/mlx5/mlx5_rxtx_vec.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 79e92811d5..eebce160fd 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -232,6 +232,20 @@ rxq_copy_mprq_mbuf_v(struct mlx5_rxq_data *rxq,
 		}
 		strd_cnt = (elts[i]->pkt_len / strd_sz) +
 			   ((elts[i]->pkt_len % strd_sz) ? 1 : 0);
+		/* Drop and realign if the stride index drifted past the
+		 * buffer, rather than letting mprq_buf_to_pkt() index
+		 * past shinfos[] and the stride region (bug 1369).
+		 */
+		if (unlikely(rxq->consumed_strd + strd_cnt > strd_n)) {
+			rxq->consumed_strd = strd_n;
+			rte_pktmbuf_free_seg(elts[i]);
+#ifdef MLX5_PMD_SOFT_COUNTERS
+			rxq->stats.ipackets -= 1;
+			rxq->stats.ibytes -= elts[i]->pkt_len;
+#endif
+			++rxq->stats.idropped;
+			continue;
+		}
 		rxq_code = mprq_buf_to_pkt(rxq, elts[i], elts[i]->pkt_len,
 					   buf, rxq->consumed_strd, strd_cnt);
 		rxq->consumed_strd += strd_cnt;
-- 
2.53.0

