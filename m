Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A121E909AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 15:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BED874066C;
	Tue, 17 Feb 2026 16:06:47 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 2D01940657
 for <dev@dpdk.org>; Tue, 17 Feb 2026 16:06:45 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso37334065e9.3
 for <dev@dpdk.org>; Tue, 17 Feb 2026 07:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771340805;
 x=1771945605; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0WojMkyC3l6NsGTcQfiUeeBxi3OItZ6r1qGQuT4Sgk=;
 b=ffS4Dllqst3MAAZ58B0tPGUTtTW8fBq4tmwez01sOO+XNYGH9xX46m6sRKiNqSfefn
 HlauX4R5UF4yRqVNNNyIMwWctZWu4KCzPYL9L4ioIaNfGBLRw8kW51ilII/S1r2pE0EQ
 j0B9Y+vwu8E6/0ErGehbF9RRaGh8YumVtuyrDj0vpiVSFiEtZFHjobEtun8vKoPCYFNN
 jcJqnE4sV6EyFya176a6kKTDGo19MvDBvySDXCq6E7BFOmqmZjbGOagU9xlHxIOaqi1S
 9Jbg2W27nbQeo6mQHrsQPSsz7hW3RNTj3ySFWsNFPlsTu4B0nHl9hKpuJK7aricgUk57
 mE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771340805; x=1771945605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l0WojMkyC3l6NsGTcQfiUeeBxi3OItZ6r1qGQuT4Sgk=;
 b=wFKna2vtRcUT6KfdBrxpdfIeRgvv7uasd0MVEpUXgt9hNMsgr2As+eHoKIyq2TtrFp
 4qEQn81OY2GjtSZwLCHh4oJ4Qz520kIhsSd60mgVIg8RwmwHmUVic/q7QRBw6PsXa65I
 K7O3nILNjwipnBjr3wqk0h9SKtH9R3EB7f6dYtKF4SjkRcPwLWvXMiOkgoXC1ZD8hma7
 gPZh9iZP/z2qwynz6EMCw1Nd4KpO+9hokulJIv102axTSwVhxLQhLYbcdXlrC193SkH+
 Z24OZ97o02sxs1R4MH/DGTROVs6oR0H/3OcJcd5UGkWVQ3Ko+7ckIrviHlr0/LQLbqfi
 0+gw==
X-Gm-Message-State: AOJu0Yz+f7M6AVk8LE0/72W60DvE1VmZxkXoralRxA4/OMCTg49wSdyO
 j2eZYNgckQWmLkDUcsMcQ6SVAwJ1sBK+8SWO7WJEwXji/X4aIKMrHkPV1oxa6MaHWfLWdBX+Twg
 YF8Hn
X-Gm-Gg: AZuq6aJKCffj/iZI7DIInmlxX4hnrbhmVZ20xF3We4Bhvh2aY5b14uSvlVVc9aHSt9T
 y4a6n9g6aTvR0B5czQR2LHfDnRMEEcb6gGltjFmKk2fr1p+3zoE5jZvq0SuUuSqIBEYM6wpLW/F
 pmILBhCPC60d5Nlh28p10L6sdUTb7tDufnSCGkmDyXaUwn+3p+uvutQrvqpDhiminW/FQauL3Wh
 olytjxE+eGxDC77GEW6DvwKF44vsT5C61Xo0AmvMj/qGYZdkgYYN9hIbAz+B37STUOpTAA9PBSF
 Ku/5sHkPiRcJMpR3bTpS/aFodqhmvc7FNwU8X5EueKn68C7hFYVU8DyWhlCeLSivVtQDi69YAGg
 iKUHCZn7Qfmjpde00Mp+GieaeRja37yDdPgtYWEJ7tuBJY0Bc3zoQJ2zwdgyrc1+Qjs74GW+Z5v
 GAF7hVUuoABDF/CvX6znGUOMc0EiAkAdn0rpa+OKUcqzhHWH0R54v/XwsUHLlUlg==
X-Received: by 2002:a05:600c:3e06:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-48379bac81dmr182982685e9.8.1771340804655; 
 Tue, 17 Feb 2026 07:06:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6ba57sm28492012f8f.15.2026.02.17.07.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:06:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFT 2/4] net/mlx5: fix counter leak in hairpin queue setup
Date: Tue, 17 Feb 2026 07:05:00 -0800
Message-ID: <20260217150635.134031-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217150635.134031-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
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

When rxq_obj_modify_counter_set_id() fails in
mlx5_enable_per_queue_hairpin_counter(), the freshly allocated DevX
queue counter object is not destroyed before returning.  Destroy it
on the error path.

Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 4d3bfddc36..d533ce41e1 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3704,6 +3704,8 @@ mlx5_enable_per_queue_hairpin_counter(struct rte_eth_dev *dev, uint64_t id)
 	if (ret) {
 		DRV_LOG(ERR, "failed to modify rq object for port %u"
 			"%s", priv->dev_data->port_id, strerror(rte_errno));
+		mlx5_devx_cmd_destroy(rxq->q_counter);
+		rxq->q_counter = NULL;
 		return ret;
 	}
 
-- 
2.51.0

