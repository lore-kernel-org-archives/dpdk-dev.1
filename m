Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BCDC5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D12E9402E7;
	Fri, 14 Aug 2026 22:20:10 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 9B6114013F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:09 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2060816a91.3
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738809;
 x=1787343609; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7AxFmUcGxix1vMn+PXUzjSr+UBJcOAMb6q9tg+CsvQg=;
 b=oJ0o3LNKGGeLvPjPUVUc+eQAhhIZO+2d9cM+IKQBxK0Eixbn8ynnN47VqvXBeFjUGp
 DDloEmh843GV8U23N9Z6sWNR9po5Ke06mfTtnk9dm96+GEVhAmuUggvzP2clZ2ban8w9
 iBQM75lo9x/OM6evQIKUD9HSHX9fvrZs8RBg+t75f+2f7XeNGgDgHdMwDb33y1RZUG3T
 ovsoamRttTZa7OgTsiA+eViM2txy1R+4Sij1iPc6sSe7WvooCIc2jw50pbZiCUcQgu1r
 qHTA9/uXTvimDfcLfyet+rZSZ8AuMJbWtxJA3HcwYLYvh2VSZyjye45YljggidDZ+Q/F
 e5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738809; x=1787343609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7AxFmUcGxix1vMn+PXUzjSr+UBJcOAMb6q9tg+CsvQg=;
 b=kB/7nJ3m8dPZl82gkABgm9EdqyfBQeXFTDFCVuhRxr/5Dawxrmaxv8kps+5QwT8RyU
 ULnOjhTa6g/uaM0rr0LS2rxtjhGF1eHJ90z1HUvOhq09mMYPWa9AiHnWlgtdy98gij6M
 5LKFMMUyspZMY1JiR5casX1OUAz62BSgmbgAbHrCyvifRAN7XKurIUxu/KuyFtAno3xz
 rieGhDKca6pY7HO4YX7b3GYwOGG07a58D4CoolDklSuFOzS9AWX2PAT6RNDEqH/p6Jb3
 nGYQ5wfD8fPqrvIYw6CwF8Worgr5wrFaGZfQTCcEifeUjbpiAC903shgOcM7wD29zyJt
 eW9w==
X-Gm-Message-State: AOJu0YzmnstMxrHq08ID7vuwn3c0WgMhoni5guF70jlU+K3Pnw/BxxAl
 MG7kFgR2jT4hTtyBjz7JqlhkG8v0k4Lm/54CCQq3x/KokQi7IBSA7g4U37cbpmZwwXHkiUEy5OW
 mGXeE
X-Gm-Gg: AR+sD10rUTdlnSIl6M1vNDuW35Xe1O4u10cEqk5NlT/4DVUJGS+Um3WfRVz3+38VU3h
 g9RMR5FFznuZKQggfqhWGI+aTBIXfu8Se74d8TGGpxAqhkTHgN0bfWTN+b0pdq061yzeQ11BHxE
 /ECBWCvrIOZqixNPnhshaxpTPfXNsw/iFygMyWfbVl/W7UdkvCXeMIRY7oTt+PPNCEM9RSwHUaR
 dhlN4cNDGR4NEcDBsGw6fJ1oAZFYQoN2gofyRgYx8kbnQ+XBCg8bE66DkhtxkGyO6E0vCbTy2mW
 lNQTfTBDfaqcvAvQIdubMKGRUXESEh7nO79URMjKoRtIADP4IZ6Dbj69Gei4cLon9pdUH+A6Cm+
 KH01D1dpF0LMW48ILXtKGd3TxzI34cySODFa/2PffAJN4UUxeY7tx5eX+H+1ul4AWi+VrNB1snN
 d8FCZmBL63VEUprKOjh3AQr0UvXE6ijfBEA+R1Fi6/DWpAX3Oh5FRI/eWfKNaO3yIRhGklmCYci
 5xBdEyFeaph2awFHKIC6RT9dKQ=
X-Received: by 2002:a17:90b:384b:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-3933ba90e38mr8765214a91.17.1786738808670; 
 Fri, 14 Aug 2026 13:20:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 04/16] net/cnxk: fix Tx drops added to Rx queue errors
Date: Fri, 14 Aug 2026 12:46:00 -0700
Message-ID: <20260814194757.329424-5-stephen@networkplumber.org>
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
rx_qN_errors xstat. The Tx branch assigns the Tx drop count and the Rx
branch adds to it, so rx_qN_errors reports both. Stat indexes with only
a Tx mapping hold Tx drops alone.

Tx drops are already counted in oerrors, so drop the assignment and
store the Rx drop count directly.

Fixes: 58ae74244c90 ("ethdev: remove queue stats from basic stats structure")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cnxk_stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/cnxk/cnxk_stats.c b/drivers/net/cnxk/cnxk_stats.c
index d57659ef51..6c812bd732 100644
--- a/drivers/net/cnxk/cnxk_stats.c
+++ b/drivers/net/cnxk/cnxk_stats.c
@@ -45,7 +45,6 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 					goto exit;
 				qstats->q_opackets[i] = qstats_data.tx_pkts;
 				qstats->q_obytes[i] = qstats_data.tx_octs;
-				qstats->q_errors[i] = qstats_data.tx_drop_pkts;
 			}
 
 			if (dev->rxq_stat_map[i] & (1U << 31)) {
@@ -55,7 +54,7 @@ cnxk_nix_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
 					goto exit;
 				qstats->q_ipackets[i] = qstats_data.rx_pkts;
 				qstats->q_ibytes[i] = qstats_data.rx_octs;
-				qstats->q_errors[i] += qstats_data.rx_drop_pkts;
+				qstats->q_errors[i] = qstats_data.rx_drop_pkts;
 			}
 		}
 	}
-- 
2.53.0

