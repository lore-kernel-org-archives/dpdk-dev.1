Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BCAC5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0EB440658;
	Fri, 14 Aug 2026 22:20:43 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 07AF440616
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:43 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so14988965ad.1
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738842;
 x=1787343642; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1X3QZdUA3FJove4fTYhV5A2HuZVltk7B7T9g4DKm1jY=;
 b=st2/jiLDXIR9wq1sL9tNrcb4slJi3OQhbJbupmGCjERIWKGCc2E7rEuv2MFxpie+vR
 QM3HfuC+O19i479YP4GvVra6/MIa7/0MKgTdmVPPiwjEwBdzmjHBtAdVRGbbOnHxORKb
 byySGWGIzbvvWQONLkIkCpu8YCQyxMlF8jGC081RHKUT7J0XqeFfXDcq+LHITO07nw1g
 MqWhFkeucC2grY4Cej7N/Zp1w8zzrLejt2hVywP7pU12vy5D7qRwCDt9r9H/KpLMEhDv
 lJBYU6H8L57nqR3xdqr7yVE9PbU3bNckN2RB2Rvqe/ZQZ5c6WKrCRmsX/U29LjhV+yDE
 +TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738842; x=1787343642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1X3QZdUA3FJove4fTYhV5A2HuZVltk7B7T9g4DKm1jY=;
 b=iRxIdbLaVkoQK6mQzjluuTvIa/4GMEBRiPYN92eXvmbJtNq1qfoxW/oFjwAUCgUSM7
 DkHB83REIcStPGWSyocymsmW38gMpZVlnS3vqBVCasuqKntNEKJ5poYpKQHKfpsv2/EV
 Ked9czm8sSHlHVzxCWGO4Psin0uu2HdJDby6sAajv0juQBD3jq/vn+7cM6xFdw2Jz0IK
 kkIK0Fl9maEybh7NCoIE9zMwgNRtIGD4x7v8Gif0McfYgmWGnGb/6b/qMlwN6ZbZYmzb
 RiA8AZVKcfQrNczlBbvmKCdij8Zdl024a6oLNt03bF5EnB0FzE/2G/5b5fh1LonYam80
 0UJg==
X-Gm-Message-State: AOJu0YwOL0IRFsxAa/cl61E2193dqbWjDRV0IEIIF8bqdegad4mDkDrD
 4wR4dK4wIN6aXUSlCh8qEVZNdVWXFgI0vEP96qjIFieF91gdd2B5Kf6TX5dCx2d/iHRVKbjWv+T
 wgCnD
X-Gm-Gg: AR+sD11TxYXRC8HAwDSWgb+DZZhg9IVJK+3lA/h/NciXK836xx7xxZh6FcfGnxacXKO
 XC2IwSKPU0DoHtG2bYink1fjSJDxNyX5pXFFJjMPlOCvpXx63wH4UDGMsIHR22VGaKbAZnoGbbw
 YHJ8lqWtbgZme2T9tGrpar9bzpmmBtEqm4wFHJscFWfqs1ptr9jMqSpjt565cRFPPkL/bSxC374
 l3VQmDzOZE1gPy1C+1AsdIB1cv8ibUIMXyGtWKqW6r0hP9mr95NZLnPMT0vcwcvroedEGNoxvkO
 RPyPy0fBSGGsA2iLIPLKx4drmGkC1e+Kew4dakWoiUi353UWK1lgJjiOe0ZE+rpw5sZLmC3FbCi
 cIsgYY0Tpw5qKJr8vpmdaZMMNU8OiYH7PdC7dnRE6Ipvo+oCnRgkPMw+nz2da19OxqbfCvN7CGf
 aWy8V5KL4qMTgB1XHeOwGMjuAQa1hwZSjUgAAUAdFx4ObTcFhi8U0LHPHcmgaJCHlyzwo0dNHX8
 zZ/VKkDlQnNuDiUavLVWUkwUe7DSf4Ob4l26g==
X-Received: by 2002:a17:90b:2d92:b0:36b:77b9:5c8c with SMTP id
 98e67ed59e1d1-3933babae61mr10160312a91.17.1786738842128; 
 Fri, 14 Aug 2026 13:20:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v4 13/16] net/ntnic: fix Tx errors reported as Rx queue errors
Date: Fri, 14 Aug 2026 12:46:09 -0700
Message-ID: <20260814194757.329424-14-stephen@networkplumber.org>
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
rx_qN_errors xstat. The Tx loop fills it with the Tx error count and the
Rx loop never sets it, so rx_qN_errors is purely a Tx counter.

Tx errors are already counted in oerrors, so drop the assignment.

Fixes: effa04693274 ("net/ntnic: add statistics")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/ntnic_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..bee34d20d7 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -209,7 +209,6 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 		if (qstats != NULL && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
 			qstats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
 			qstats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
-			qstats->q_errors[i] = internals->txq_scg[i].err_pkts;
 		}
 		tx_total += internals->txq_scg[i].tx_pkts;
 		tx_total_b += internals->txq_scg[i].tx_bytes;
-- 
2.53.0

