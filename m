Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D67FCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93C2442E5B;
	Thu,  1 Oct 2026 00:43:59 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id D5D01427A7
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:56 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so2074034a12.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808236;
 x=1791413036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CmTPFHnSyhzxJ57Fz/492boTQpob9X7I9uaVcIVOUuY=;
 b=R3nZD9IUb7vCYrClLTybxqZy0fdfcTIEXYnr/c3OXFhOO/39B2xX+JlWOldyl4b76r
 7jIYeNSiGIY4wGv/T/feK4YKZkfRc77QiwlmLCpDqf270BYffdpFjWDbnFM0gXm0uk5y
 8tY+gyjcffgXPlsrDuA1kNJ6B0MgWvOlMg2cWGk1KjfZJjYTdGvKtwU+knbOKVf98dBk
 dW+Nn4pCQg31W4uYRKoOKGCUtKtYBNwVZ9IZNc4orzWAW/H0fUdvHS6gXgMWXX2VZdMM
 84BZJhtXlq9NCeiMYmoZOxxmwtVc9CGFkJJkqaHliddghbAQ9wFGAAyQkfxho+6uk3gS
 62FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808236; x=1791413036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CmTPFHnSyhzxJ57Fz/492boTQpob9X7I9uaVcIVOUuY=;
 b=Dw3aESH2lBXMt6ixo7QGiOs8giWjUKPcB7oawgSFN6/PEgYPEYSh/saAY1Lq89rjuA
 bH6thr5u3wzxV32yybdQiczcd7VzRo6hVv7+Ti2OeHLJHWIgESWUNJ9Mp3vNqGyPy9FI
 TfdnYt6Z8VklorrvGZs5Rh9+0Zt8pcrKj0G/EPfpRh62l+3W9m0igLMxUqJFIGChzyYv
 KSZUsoXa3hXn4l1V3cmTEtzu8ZqCPKVpKfvsKbAuVRyABYtYx36rpBL8KpSqNBRlwWor
 5B+oTQhcCO/kOwkDzlqenOlFXKzoMcCQgtTHG3fCSmI2p51pRD5KrEDBfo36hrRReCqJ
 NnJw==
X-Gm-Message-State: AFq9FYLA4KqKr4xgjVgwy7FVKp13ljSYqyPkiqnk3d8VLcoltm0/Xh+1
 8Cumih4pZqOt9v7gW5dBISlEnf1OKOyU5+edHMhbHXWe473GG4GjOLqMCoWmEpRyo9MfafoV0EU
 cQMKl
X-Gm-Gg: AYBFou2JUVg/rPbZCTxrfYgLLviaaI3i9fZcWtD/l2FqfQdz7qECxq1I/Av00knLjSx
 psTcZacVt8lbI/mUCOOvTcLuX6PJYUQF+WPSPlhNDOxCkSHGKQmuZyMXwTBcx1KXoMAMoasz+vb
 yQCUzTHQZWKnrJzq3wwt64D/yZU+ykcdV9H/od7i2uYN0ZkzSd8+ENlHu93eE6jhv3tqvzVjT0I
 +6XCcJgKOiQ4OZ9gDZhljPU7Nzm9esQqLjx35SbYxn34hkDwx4cX+2ss/G2X5DGy4M3A6HoS+OX
 S9VPQkg1BoEpAsJDHAu+E+xrFCsIIWqaohPKUSyRcPil82v3ygQzgpQ7nuV/pvOvlfdUhuX0rR4
 aLOu+TrgWeKO3x1U3MoIL96NdBandf68SmBWUp0FAqBb/aSj8lHfSTotEZynJMzmA3eNN2es0Pq
 ETiJOP5y6h3eeEfuKU4i+xKzYfaR3Hx4kI8wmifBuQ2i3Gu4WjqeirfYz6iOEqKTayLy/aJmfEt
 41aNov1Himxo983EryQQPuqC0PdZj6tTMhxTg==
X-Received: by 2002:a17:90a:297:b0:3a4:d883:3edf with SMTP id
 98e67ed59e1d1-3a4d8835ff0mr1230491a91.9.1790808235919; 
 Wed, 30 Sep 2026 15:43:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Amr Mokhtar <amr.mokhtar@intel.com>
Subject: [PATCH v3 12/65] baseband/null: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:30 -0700
Message-ID: <20260930224340.58580-13-stephen@networkplumber.org>
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

parse_u16_arg() does not check the end pointer, so "max_nb_queues=foo"
is silently taken as zero.

It was used for socket_id as well, which is an int rather than a
uint16_t, so parsing it wrote only two of the four bytes. Use
rte_kvargs_handle_socket_id() for that argument.

As in turbo_sw, the open coded range check only tested the upper bound,
so a negative socket id was accepted. The helper checks both ends, so
the check is removed.

Bugzilla ID: 2041
Fixes: 7dc2b1589440 ("bb/null: add null base band device driver")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/null/bbdev_null.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index cfa1790126..fc23a84f32 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -202,25 +202,6 @@ dequeue_enc_ops(struct rte_bbdev_queue_data *q_data,
 	return nb_dequeued;
 }
 
-/* Parse 16bit integer from string argument */
-static inline int
-parse_u16_arg(const char *key, const char *value, void *extra_args)
-{
-	uint16_t *u16 = extra_args;
-	unsigned int long result;
-
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-	errno = 0;
-	result = strtoul(value, NULL, 0);
-	if ((result >= (1 << 16)) || (errno != 0)) {
-		rte_bbdev_log(ERR, "Invalid value %lu for %s", result, key);
-		return -ERANGE;
-	}
-	*u16 = (uint16_t)result;
-	return 0;
-}
-
 /* Parse parameters used to create device */
 static int
 parse_bbdev_null_params(struct bbdev_null_params *params,
@@ -237,20 +218,14 @@ parse_bbdev_null_params(struct bbdev_null_params *params,
 			return -EFAULT;
 
 		ret = rte_kvargs_process(kvlist, bbdev_null_valid_params[0],
-					&parse_u16_arg, &params->queues_num);
+					rte_kvargs_handle_u16, &params->queues_num);
 		if (ret < 0)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist, bbdev_null_valid_params[1],
-					&parse_u16_arg, &params->socket_id);
+					rte_kvargs_handle_socket_id, &params->socket_id);
 		if (ret < 0)
 			goto exit;
-
-		if (params->socket_id >= RTE_MAX_NUMA_NODES) {
-			rte_bbdev_log(ERR, "Invalid socket, must be < %u",
-					RTE_MAX_NUMA_NODES);
-			goto exit;
-		}
 	}
 
 exit:
-- 
2.53.0

