Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AACBCCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA02410DC;
	Tue, 21 Oct 2025 20:58:09 +0200 (CEST)
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com
 [209.85.166.228])
 by mails.dpdk.org (Postfix) with ESMTP id D61504064A
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:07 +0200 (CEST)
Received: by mail-il1-f228.google.com with SMTP id
 e9e14a558f8ab-430c17e29d9so26853125ab.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073087; x=1761677887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=p34PxQcWZccGV+WKZNXrsgmM2EjbUH6j4isy6/akIgIXIEHFS0mpGTp3BgLIpuz30s
 JmstSCJnAyFKE5BvrzXl6RqefTvtsfZ5/C0FKf71PLKTcY+98w5ixwNIimjcFtLx1Daf
 CI9GDZfTPA8hiy6epPMil5DkM1R2s0yBMfLNbb7LlKhfbqX+oINSuBKrKIdZUCt/d/jk
 xqLg33nydU9JbbcEV/9fNw35HZVvg4vmHLUVSxEpHwH5qtleVEDaliPAHUy7S8EOYOO7
 ZIegWrFDk2jzV3RKbQCjXsj8J3q8ifAoBYqy76E5MIujnTBsphSv6vz6GggVmLP7vWT3
 RlGw==
X-Gm-Message-State: AOJu0YzocdFdXull5G5+adGaTHczU8A9uO1CcZie/wAiOxjCrXcESpg1
 uGHFYpRM0eKf2epOHT2lCArkXZp0hlpc/278l7mM5lYaKgHY2ceS2QCwXpTUH3gcz2U7qqQ7Jc4
 6Kgj3q4/7nG7diDSgC7CbEsq8Mkqd2H3SzjFp78EvTdAJsOt7EzN+FNaYMvpB6fqM9g6JTQqxJf
 UnT5xjpoUNzw40Te/e7tmpaVhOoon8ZpwAfg0q+63A7wzsygNJ/g845gs4XnTNE4uM5l9a5A==
X-Gm-Gg: ASbGncujUB4QIVZbPB1qQakUw7jo/6J2jh5LNpUF6I0PqzVfYID4nf8fjta3FBjNMo3
 US7z9oKl3Qht48YxpecFz2iDYPpJ/W7q4eVA8xvofKcs58gW6WSVkztzS0Lrg7A030gQwe/DhDM
 ppzHz2FoItqKYJ0juNMjwMaGkkkHsTVs3COe+Bd75hHc8tFykVEO9WPNiLnVp0FZdMOecqOpAiO
 LwcK29TH2ZIUq2r/fTtvPiocMqFqm51awWk/ywe+hSE7+m+H7ujI6XnCQqeLet+9O9jv5gpVSsr
 IIitmXkFMai/7Gh9ZOEU4p3AJznovqKqjRWGWWR9PZ6i4K2NMQUC1kY9ljj+ShO6fWi9wRA57Y3
 LRdEUIOIx4x7mVsikIAeXSQIoF1Gb9fCGbVFYR+aehjNZOjo1l+NelqNYcdCSp0jKl5fpG2BwWt
 qu05D9BLCduqffc8M14So/MDowyoEINyR4RA==
X-Google-Smtp-Source: AGHT+IGBFx4SLom1PVHH0lFqdxqPDn2akggSE5qSXR3Z/RDTFiHbYzwb1WQxIokiMS9pELZERJENMkqIMdVT
X-Received: by 2002:a05:6e02:2511:b0:430:adfa:e4f6 with SMTP id
 e9e14a558f8ab-430c52b5b2cmr239300875ab.20.1761073087062; 
 Tue, 21 Oct 2025 11:58:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430d071613csm12145325ab.10.2025.10.21.11.58.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-277f0ea6ee6so63161615ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073085; x=1761677885; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=FZv6vWtvJzMDuxDFw7ediHvuu36s1X8I/JKCmEh4ncqeJX7UOkDCsJxqLB3FnRelgb
 2TnJi21WxFvJuLnW/DNdHvQrmbq2YgL3SsAAeraFezqRT8r+3TMPdvs3k8QXKoMsLldy
 cTXEGDOvUyR2pZtftJIZhJOVYoR19Dgk8WdCI=
X-Received: by 2002:a17:902:d485:b0:28e:c75e:61d9 with SMTP id
 d9443c01a7336-290caf83210mr228276725ad.38.1761073085238; 
 Tue, 21 Oct 2025 11:58:05 -0700 (PDT)
X-Received: by 2002:a17:902:d485:b0:28e:c75e:61d9 with SMTP id
 d9443c01a7336-290caf83210mr228275475ad.38.1761073083238; 
 Tue, 21 Oct 2025 11:58:03 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:02 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v4 43/57] net/bnxt: fix stats collection when rx queue is not
 set
Date: Tue, 21 Oct 2025 14:56:47 -0400
Message-Id: <20251021185701.71881-12-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

When rx queue is not started and the stats context id is not
allocated then skip the stats collection.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 9d7cdf925d..697f9ad9fe 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -656,6 +656,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (!rxq->rx_started)
 			continue;
 
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
+
 		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
 					      &ring_stats, true);
 		if (unlikely(rc))
@@ -717,6 +720,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 
 		if (!rxq->rx_started)
 			continue;
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
 
 		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
 					  &ring_stats, true);
-- 
2.39.5 (Apple Git-154)

