Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96802C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F1140E48;
	Mon, 14 Sep 2026 07:51:21 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id D3E8040BA6
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:20 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2713639a91.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365080;
 x=1789969880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqB2WtN5WDpIqO4yfC0SCIP6pXs4RfveXoGZ1yeKgU4=;
 b=SbdUkoQ99jUnx9wQNNa4AkWHhhld/jtnq0Nl8jURw0Ko4GoLWJQeEvW2DRyh5MDwuM
 SEJTqgEG5Dtg9p3W9xUrc+8yQ3v0gG8ofHHTNuNZQ8nwdHYKQTMpAZbyArm6f2qVtj6C
 loeJA9SnJ+vdU29aeHDM/O1+LrMJPlZn+3QzXFh/g8dEwFEZDhleYkhje2lYzmuvL0PI
 TCvCiSnrKxWfhMLi/soZl17IyBbw2nxsEL9Hwd64fee+6AsPKxSRVIGs5XzyIptjY9By
 xu24gO2HJOs1FOue0fOgEDq3ykwkRcY7EdMyja0yqBlTx8S7DLeWD8UfV3D4yEzA0UsT
 mKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365080; x=1789969880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqB2WtN5WDpIqO4yfC0SCIP6pXs4RfveXoGZ1yeKgU4=;
 b=VjexQkC/38LE5uVdbos0beHmSFbS98MVq9yjnTKyepQsZwh13ThZ4iSWEmwG6fiaor
 eq8gw9HR2cWy38PxRtHYcX8pCDDzSbrCawvBkc1WqVw6Can3l4YxYdTpQT0jeLkTAJ0J
 jJ3hpHVEmyJO9CegDbX8o2RZaCC7ZYD8nk7XydKtM5aK0uT3H6+sOlxduQmQtsc8q+6f
 bG9pz2SVMQ/3QkccqisiNbEymUeaHBHd+BjoSf16cxgmd3cOQMTA6gZobDwsvVQUInBe
 fIuwMIwdhjuJsFq/xZiINzpcNZvxpxsjX59ooXX+7/61Cg2VSPeRSlO45nqBbdWtQq1n
 8xQg==
X-Gm-Message-State: AFuF++mVavV5KXSv3w40dXOZA6I6hWgR+VNRwv72xdzJHM+HIjE6V4DT
 59Ri+UWMOtolc7zlP52BLm7xFfGvXb8jNx49vW5I6IDqywKaj99YU6zhCGNGhDxaJVSwPcQjvuD
 RW0YzdEU=
X-Gm-Gg: AYBFou31MsAvrF8/TjtuQTN/Srq3kyDAD+TASWzGse3VLyZiV4TlcaDZa8TsDQvpZvT
 WFuPGRy1PFEArDFOpNi8PRRZoRdW7Y8qlwJAqFYhHXEO3phXsqOH4DnA4ev4KGfm8kj13+s8Yg0
 ScXH1YnKx3rgdMUvO2h/2XnI/TmP7aeKCvigpQEtttQ3KjdxpGoDue1q2SGE8DwP9LotIlULhPr
 Tv1iwRnv3Z6hzh6MpOvLFdl9fRDxmgvmOMxUjEGcKDZ626pznqzuinNVyber2K5TnQRRIrCoI0e
 JOjwi8b6+9+DCtV1Om33Zl142Hgeycr5aUTthUi/4feYj23/1Z8IncrfyO7TULMHRH5kaceGOcC
 blu4lvtTQ3vOMtRlYVDKYqGD4IWknRHEZSr36Pw3aEQ4yah7zqwyTSNbdeQU0BtstJtBTBMKnp9
 3tJlw5VUovrTD01lES3yY6z+WbbRV69E2XbJOo7OXt2V/v1JeYcljo6UtI0/vLtCfHb+3Jo01cr
 2f9it6uBMjRv2LHhpQ9RaWqPqhsMYVHR68HFSyBmjEnnAm+
X-Received: by 2002:a17:90b:5387:b0:398:c794:ca26 with SMTP id
 98e67ed59e1d1-39dec13af7fmr2733667a91.25.1789365079984; 
 Sun, 13 Sep 2026 22:51:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH 35/62] net/thunderx: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:06 -0700
Message-ID: <20260914054912.755403-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

nicvf_parse_devargs() uses atoi() on the skip_data_bytes value, which
cannot report an error, so a malformed value is silently taken as zero
and the argument is quietly ignored rather than rejected.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/nicvf_ethdev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 6e34da7c3c..7061def01a 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <assert.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -2161,9 +2162,17 @@ nicvf_set_first_skip(struct rte_eth_dev *dev)
 
 	for (i = 0; i != kvlist->count; ++i) {
 		const struct rte_kvargs_pair *pair = &kvlist->pairs[i];
+		uint64_t val;
 
-		if (!strcmp(pair->key, SKIP_DATA_BYTES))
-			bytes_to_skip = atoi(pair->value);
+		if (strcmp(pair->key, SKIP_DATA_BYTES))
+			continue;
+
+		if (rte_kvargs_to_uint(pair->value, 0, INT_MAX, &val) < 0) {
+			PMD_INIT_LOG(ERR, "skip_data_bytes is not a valid number");
+			ret = -EINVAL;
+			goto exit;
+		}
+		bytes_to_skip = val;
 	}
 
 	/*128 bytes amounts to one cache line*/
-- 
2.53.0

