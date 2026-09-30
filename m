Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C572CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A9642E6A;
	Thu,  1 Oct 2026 00:43:57 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 6C9DC42DD6
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:53 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so2866363a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808232;
 x=1791413032; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhRq59k12zTMRFLNUpvq0zS183zGa3EeTpW/mN/RCwg=;
 b=sA4hiJCsJ7syY4qxfpH94fbgqqygasNKE1+87ZTmdC5h19KF7eW+t6XTZK2prIrwcW
 XiS1DQhAXJmzyMhcyva02MZNvd+Qvwxes4FMKQQNa/qTdS0TzZkxplktV/jXAvRspnjP
 Wjn+k3Hw3lBK5bPheXMzwbiFy9gI4OJYm3uphb05cEMe7lk8Aps14brwt7CAwcNXyjW6
 Mo1vHN1xhGdSTPRW2eDi+e7aBFZF2JuYHmZHymsXGAJXYXywLD5mivbVZi9jywgxMXVB
 z3mUldQ33nFhEj6QvscC7R3e9TjTNPNHInuxppEPF2bbMN4LbjqMGtJMUCSUZs/m/S5/
 fVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808232; x=1791413032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhRq59k12zTMRFLNUpvq0zS183zGa3EeTpW/mN/RCwg=;
 b=nbxRMHFvhcKfZ4KJacLUy6ZPr/sKFSRDfI+hPyyZJMMjL8RdyVQpEbRX7oMIy5sBwF
 v7LdXYofpGzKZ5jHWUXtaS7eb+yvoIi6s8c+kEmEPx2rZwfNsFWPC1cKy5wP0StLqwcm
 AHIi5KjAXjEtS4qdF15Dn8y87dfLmVEemZrsotorAIaf3xgjZxLc1tFFDiGYC+10Oa60
 Bfd7xJyfqtauyvKaxhyeKz7I7/brH/RGIDJW5jKehGdH458YF4ANa8xP1vKWA82Gh0J4
 zeVGCZehWesTowHLndSXjvUsHxrchy2X1W9P/KW36Dqkdc6jZcNSqKezKLIn0efijR0m
 fKEQ==
X-Gm-Message-State: AFq9FYI/Fe8NCUEOEJV7t1ie7Kl8Ih1dq4ofxtDJxq1+ezCdeHIPbfJy
 aamsdjuGiGBm2ycMv0RJ8Qj2EwJDSQQgupl/fSlb8G35hobPE216I+ZmMR76qS543RFanUC30EL
 eRQh+
X-Gm-Gg: AYBFou1/YV6tVVA3l+dRM90kB9eYOcBIwoQKhqkmX44WmIlRiWcyaSSCtovn8lWBUom
 60obbjCmQiY9pRK0KVgEd6TfDJz/UzPdobHkGcNiijz20pecy+2s169KsJj4PUE51AXjhkiEVUe
 5Z0kRvbHQoWuYrLi3Bf+m8f/GeMo8M+0b7AW9NPqiudBZJEOaNGxLF6dK7+yC7hWqUyIGkrk3NV
 9BQdq9UgUzaJ4CQKaSse5B8qKRSyPJ/Zw7EOM0nrrBFKQ2Ul8BSu9ZPx55rFPtu+pvLZ94HGwzm
 Zh2Xos3ugd7JdG5Iw95xpHLn2dE75BgXortJFtXVjZxvF4TuPlpgTVhLD/nnPieU7K/MzV3wUzb
 OEb4D6Nq9kHzwJ3lK9+zD1SE2tUSfpS7RGlRBy7DkB8Z/ShxztMP8vAfy3jg0leUTIQ5Mfo0AID
 fl3z51J5RK9L23VXkYMnFs95CEo4gp6s8h9bpNbrDuwYfMSeHIZbjjhnqPq4DGSThLTOl8dJt6F
 ojyOVG5/WI+yVjhdTzxTb27ZRzh+cX5AvdB/A==
X-Received: by 2002:a17:90b:1c01:b0:3a4:aee8:76ee with SMTP id
 98e67ed59e1d1-3a4d1793dfdmr2303907a91.40.1790808232545; 
 Wed, 30 Sep 2026 15:43:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 10/65] dma/skeleton: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:28 -0700
Message-ID: <20260930224340.58580-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

The lcore argument is converted with atoi(), which validates nothing:
a malformed value such as "abc" becomes zero, and the range check that
follows only catches a value which happens to land outside it.

Use rte_kvargs_to_int() with the lcore range, and log the key and the
range when it does not fit.

The parsing function returns void and probe does not fail on a bad
argument, which is left alone here: an unusable lcore still falls back
to the default. Only the "Parse lcore_id" message is now skipped when
the conversion failed, since it reported a value which had not been
parsed at all.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/skeleton/skeleton_dmadev.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
index e287802eb9..44158d5a7f 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.c
+++ b/drivers/dma/skeleton/skeleton_dmadev.c
@@ -638,19 +638,24 @@ skeldma_destroy(const char *name)
 }
 
 static int
-skeldma_parse_lcore(const char *key __rte_unused,
+skeldma_parse_lcore(const char *key,
 		    const char *value,
 		    void *opaque)
 {
-	int lcore_id;
+	int64_t lcore_id;
+	int ret;
 
-	if (value == NULL || opaque == NULL)
+	if (opaque == NULL)
 		return -EINVAL;
 
-	lcore_id = atoi(value);
-	if (lcore_id >= 0 && lcore_id < RTE_MAX_LCORE)
-		*(int *)opaque = lcore_id;
+	ret = rte_kvargs_to_int(value, 0, RTE_MAX_LCORE - 1, &lcore_id);
+	if (ret < 0) {
+		SKELDMA_LOG(ERR, "Invalid %s, must be 0..%u", key,
+			    RTE_MAX_LCORE - 1);
+		return ret;
+	}
 
+	*(int *)opaque = lcore_id;
 	return 0;
 }
 
@@ -673,9 +678,9 @@ skeldma_parse_vdev_args(struct rte_vdev_device *vdev, int *lcore_id)
 	if (!kvlist)
 		return;
 
-	(void)rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
-				 skeldma_parse_lcore, lcore_id);
-	SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
+	if (rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
+			       skeldma_parse_lcore, lcore_id) == 0)
+		SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
 
 	rte_kvargs_free(kvlist);
 }
-- 
2.53.0

