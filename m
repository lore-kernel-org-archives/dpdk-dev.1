Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF73CD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DE574066E;
	Sat, 20 Jun 2026 04:31:45 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id EA6BE4025A
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:42 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7fdbd0960b9so23159457b3.3
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922702;
 x=1782527502; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=nGlZ13nZKK/CJgUodeXFporsGXqxpzBLeWZWbOAbIq/Ka8R8Nhg0CzxW8YnHuIZh9l
 zUCIVqApHR0MVtkdush4U2OaT7fkom413Ji+9dYWONQLD2hW09R3FzhTkQC5SbrF3wc4
 AGtFJsDTt48GbQfVCjN9h++h/1Wd5XjSUPVcu/cxHb4MXDqmVly/JA8OxBKoF3vpV6CY
 Uc+ZVVJEdSv3ko/Sw3DxG+vyop3soFjwJ2RV+Xnx0UEsCtboSZk0Zbeuix2aYfVuN00U
 afDCYQxRT9HT37G8LpF4fXYGOEFtebjLnUDQNE/NgMrsO3rO7Kprqvc51BViXYkJEppj
 CXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922702; x=1782527502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=sutt99lVg1l2YPF4ylv+/ZDZEdr3cRESh3xhw7Q2L9QSLiWTDm0I8eqYVD2CGsoKJ7
 qqkHnvcR23zSuleG9zkhUTt+BigWh3TZmX7Jb4ELIQIMC1XUXtZGbC+LEqGTizZsGig6
 opbdi1AKazk+MkLsC9MnKmTZWaviq2o7f+59lltKdOTfrDbDe7k+3js8KETa5ntpBpqx
 Az/hRvUHFJCIead9w6CGt84c17iEYiYwmf8xKvsll8c+9IRtJ3zeE8eLymsK+T4IWO6B
 304BEp8oKImq1vw2mvLRob1XukRTXhPbPd6MVgmYLjaYGoKBcq+YZHP/X7HhDUoxTSPn
 nLsw==
X-Gm-Message-State: AOJu0Yy8YL+UxhxvzddcKqAk/9EKpLU1t0sROP/DBhGcHKGDAqOzcvpB
 EOHewIP0oxo0aHQpIyuj81yFMXYZfS/ulOtIpZuI1ECekAg2k6YxtTbsyIjvQw0hwXkLzUzfcjv
 UHts/
X-Gm-Gg: AfdE7clpO9vGhWpaLVmIZaa/RhkV9UVIbjtjxDZatFc2TK3R0LJykExitlia9xYbc7F
 EL5HR4IqjRD63yIx2QMh7tX2cxXd5m9nNM6WEdhp4ysJNJtOIszuT+NEK+dPyzHTkQU1cFep65u
 MeMbL1CZYyQdu9ucmVkNbEbOviH0VixHVQ7u3IF956Y8FaFnpo1Hgks2zS2TjLY57o99EuAUm4q
 QinGf6LnwTwqS+8xgr9Q8GIQehnUiRVfyb2Y6Q0b3rapqzZGRRAFIYTHMsJUyg/QHj4yX2etma+
 Ot5Ai5vwsyLHYI2h3ar3prF8tONxRY5CT6hg9/PKcpetInMWfUnwzWXLPFMx1x3xRUmydTsvh0r
 t208luQu9TmxJq+ax+QAcmiiZkaoDwD5fwh4rAXY/3nCb86HRTgd7dw3GrC/DEzza9EALX3F8IO
 rzVyVTxm81uVcGq/8kyfxXaQLSeqF99dFjGGCLW/zoDE+eOyB9zJI=
X-Received: by 2002:a05:690c:a87:b0:7ec:59e7:459d with SMTP id
 00721157ae682-8013833ccc3mr64282097b3.37.1781922702243; 
 Fri, 19 Jun 2026 19:31:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v5 03/24] net/nbl: remove unused rte_atomic16 field
Date: Fri, 19 Jun 2026 19:28:28 -0700
Message-ID: <20260620023134.42877-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

