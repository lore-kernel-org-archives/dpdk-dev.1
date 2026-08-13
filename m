Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CEFC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AED8427DF;
	Thu, 13 Aug 2026 19:23:12 +0200 (CEST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by mails.dpdk.org (Postfix) with ESMTP id F2E86427DF
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:10 +0200 (CEST)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso96069a91.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641790; x=1787246590; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+bxFrx7/Xsx9MGsn6ghwapsEbJyPUUGk+jRIX3z8pYA=;
 b=nMLIRN4LhMEWwuSadDe3/NMegpvvTZKhed/eyBb8rHYMeCDOKjPkmEWKLW0vy7Sljs
 DR96C+0wTbmDcnvNKqs4+i0XozrAbGLvNrFqKJsAhffgTjkXymahHFz9ZP5pnh7pxJeU
 kqtmTKQjjAd/7QXufSSDWk/PVU7dFrNsnp/rC/9s40dlxpDPSV2/LqIPp6tTQrlyAZuU
 i6jekRFKUo/EWDm9GDGh98PcVwL0wBq2xeYye4QMrvmSALV9S2ZlgZcGAed/FUO372Pz
 QszBLdDIr9gdgZXPIZ0YbCMRR21q96l65TsrVcoV9VJA2aOf8aAKvuMn0KTEs+x+C2kW
 Exhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641790; x=1787246590;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+bxFrx7/Xsx9MGsn6ghwapsEbJyPUUGk+jRIX3z8pYA=;
 b=j+snl7yo+iRby+uG2Bqs90KTZfG+EiCc+2RJ48Qta/6RFfPU45FxF95N/DXaJ5PNWf
 WrJAwCftPQJyUY4yQLgoDLfpjT1VDVdZDk2A8IyKyzaQV2C/vzn06TrZjzSqs7vdkQnd
 fP7dGqolEgrHz7i7ICDUl9a79dsT/9IDswtF6SponwPXhMeLg/fWK/ppqH9Hz/fyJGgY
 7tf8OdlGtS1MDfP76Siq4YDlOiCiy8QWDtKVGCZRu4fhZN1IyollBqWDGtMC/6HN3MSK
 c/x9fRvCS4BdpUfw5A5o9hGkdr6IY0jfEQrGBZViY7n6xXFzsyDLS8PhXEoSjaE6oLYZ
 lUYw==
X-Gm-Message-State: AOJu0YwxEOUX5jcd9EpSjODKt6J2Xca5x/kTo+snSCD2X28tpvH5CTl/
 sMii4e8KbohVuvO65fMyPwEKRMJTm/Ombtw/gaM841gnwFnJ1E4KbkMmIpVIpFFk6y7uiehMdPx
 /HixD5QfuqiGpUw==
X-Received: from pjes1.prod.google.com ([2002:a17:90a:741:b0:38e:ba48:b0cc])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c51:b0:38e:11ba:992c with SMTP id
 98e67ed59e1d1-3931e23f32dmr7442165a91.12.1786641789912; 
 Thu, 13 Aug 2026 10:23:09 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:36 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-12-joshwash@google.com>
Subject: [PATCH v2 11/14] net/ena: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Shai Brandes <shaibran@amazon.com>, Evgeny Schemeilin <evgenys@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ena/base/ena_eth_com.h   | 4 ++--
 drivers/net/ena/base/ena_plat_dpdk.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index f773699467..4c82415181 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -160,8 +160,8 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 
 	if (num_descs > llq_info->descs_num_before_header) {
 		descs_after_first_entry = num_descs - llq_info->descs_num_before_header;
-		num_entries_needed += DIV_ROUND_UP(descs_after_first_entry,
-						   llq_info->descs_per_entry);
+		num_entries_needed += RTE_DIV_ROUND_UP(descs_after_first_entry,
+						       llq_info->descs_per_entry);
 	}
 
 	ena_trc_dbg(ena_com_io_sq_to_ena_dev(io_sq),
diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index c84420de22..9c8a96c918 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -304,7 +304,6 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 			rte_write64_relaxed(*from, to);			       \
 	} while(0)
 
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 
 #define ENA_FFS(x) ffs(x)
 
-- 
2.55.0.691.gc56d675ccc-goog

