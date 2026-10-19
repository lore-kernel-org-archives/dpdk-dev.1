Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0A606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wT7e0hTp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 202C640609;
	Tue, 20 Oct 2026 09:40:23 +0200 (CEST)
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mails.dpdk.org (Postfix) with ESMTP id 05E1540297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:20:07 +0200 (CEST)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93dd3c3badbso606019785a.2
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792441206; x=1793046006; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mQwL/kNXkYRNq6ZikmOTKukRZDDFkIqhWew2GoUcz44=;
 b=wT7e0hTpk2R7TchIAzxEVpdEIISOC4LyxKyVov+2zuymnF5dmUFuUomITGkdhcUUS4
 QRais/2leOQ6j83jb66UrBdWARVgRTZb0zbnW7S5+niHox47YXww4tWFifibV6JATFFd
 SgWsqfrRmciIzJEKX1WUYMIkU82XJsZpl6eopQqu32A5L2Q9yAIzV7m4JjQQuKrHi8wB
 gNHBtsqBnE3oqX1do8E697a7pv9TTuvZ10CD9oiNbm3TiU3sfJCRzqhUJKTPB+Upsn1p
 rsim8h0HkmGX2GVzuryHA3SYJyI5AzwyEpcfdB8uLO6sRJivf9waDp2E6t+6BEwyzX7q
 42DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792441206; x=1793046006;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQwL/kNXkYRNq6ZikmOTKukRZDDFkIqhWew2GoUcz44=;
 b=JoulkONrpfSrVrH2WRUpOvD32gVcN9O4+W0tlPgkFE0jH772SZpmriUBKT8XhtZ4EY
 TWYyk5RCsvy5J8ZH1uX5BxGpu5HVrjHVc72rf70jj5BQltEfr0Sfvdc17aTHIegq3I1V
 uheHPmOChN4jifon2ZIv8eDYoOQck0lF7PqIJb0970A5FR8FvZxpkFJf8sgsuxOpB2vl
 Lz0PClHatFpHIWtBQAuRdWqMoR0Q0VoEk0zmUYiyEDf0ai0iWcjI+MjyDF9+prHSh7G/
 G4EhHt9zMgnZo766QVTFWlaVyb/dlZzodnawhYwauuEpK4syXBYMsny23GLA8h+TnXDw
 vL6g==
X-Gm-Message-State: AFq9FYKjLp/j2MQ7DKRzSfAxL44ezK75sSq0tPVXXpGoBl2jiYkyUMLW
 2hv2l50vlgN5+BAgtgHQQU/w/vw4AxKsd0Pkf0qnLO6dxjZdqot5Bdxz+oLLh4kF3yWC6GA3UMa
 x99dVohKjxJUvw4xN+VzyaW948qQaSv+QxY+jTdbGWpbhnTME54K70o40CGcNNScxdDoXD9eYIJ
 Dpcy9MhYJjIf7RVDJxKwhVUyo67M4h
X-Received: from qvbl19.prod.google.com ([2002:a0c:e093:0:b0:91b:6948:537])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2844:b0:93a:2150:ec06
 with SMTP id af79cd13be357-93f29d24c2cmr1444410885a.31.1792441205844; Mon, 19
 Oct 2026 13:20:05 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:20:03 -0400
In-Reply-To: <cover.1792439728.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019022824.189319-1-rnwolfe@google.com>
 <cover.1792439728.git.rnwolfe@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <521e84cc1c795a8430f66ee5bb2c1d99342c4ba7.1792439728.git.rnwolfe@google.com>
Subject: [PATCH v2 1/2] net/gve: advertise Rx scatter in GQI queue format
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org
Cc: joshwash@google.com, stephen@networkplumber.org, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:40:21 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since jumbo frame support for GQI, a frame that does not fit in one Rx
buffer arrives as several descriptors with GVE_RXF_PKT_CONT set on all
but the last, and gve_rx_burst() chains them into one multi-segment
mbuf. The driver never reports RTE_ETH_RX_OFFLOAD_SCATTER, though, so
an application that enables multi-segment receive only when the port
claims it treats every packet as one segment. VPP is one: it masks its
requested Rx offloads with rx_offload_capa, so on a GQI gVNIC it never
sets its multi-segment flag, reads only the first buffer of a jumbo
frame and drops it as malformed. With 4 KB buffers that caps the usable
MTU near 4000 bytes on a VPC whose MTU is 8896.

Report SCATTER for GQI only. The DQO Rx path is not touched by this
patch.

Fixes: 496d4d2c8b54 ("net/gve: support jumbo frame for GQI")
Cc: stable@dpdk.org

Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 .mailmap                         | 1 +
 doc/guides/nics/features/gve.ini | 1 +
 drivers/net/gve/gve_ethdev.c     | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..87c544947c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1477,6 +1477,7 @@ Ruifeng Wang <ruifeng.wang@arm.com>
 Rupesh Chiluka <rchiluka@marvell.com>
 Rushil Gupta <rushilg@google.com>
 Ryan E Hall <ryan.e.hall@intel.com>
+Ryan Wolfe <rnwolfe@google.com>
 Sabyasachi Sengupta <sabyasg@hpe.com>
 Sachin Saxena <sachin.saxena@nxp.com> <sachin.saxena@oss.nxp.com>
 Sagar Abhang <sabhang@brocade.com>
diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index 9f3835edf6..5566511b6b 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -7,6 +7,7 @@
 Speed capabilities   = Y
 Queue start/stop     = Y
 MTU update           = Y
+Scattered Rx         = P
 TSO                  = Y
 RSS hash             = Y
 RSS key update       = Y
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 3c8d1a76e4..92a5a7679f 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -897,6 +897,11 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
+	/* GQI receives a frame larger than one Rx buffer as a chain of
+	 * buffers (gve_rx_burst follows GVE_RXF_PKT_CONT).
+	 */
+	if (gve_is_gqi(priv))
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SCATTER;
 	if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED &&
 	    priv->nic_ts_report_mz != NULL)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
-- 
2.56.0.218.g1ec904b173-goog

