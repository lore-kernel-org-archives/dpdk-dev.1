Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7315CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 467FD43262;
	Thu,  1 Oct 2026 00:44:47 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id 47E634300B
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:43 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4c276e1c7so708233a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808282;
 x=1791413082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jnZo+hvqBlg2VdlmHakxJKIQ9hf0r/SuePtUe8eV9o8=;
 b=Dt60mgwNOi2go0xKliXjm4L8vR0wmIsxCUBjPm0ifuH3KKtSGvxaKqnHBght2nLYvA
 DhqMTx5VMLs0s86dE2Iw8/6A6PhzAtinlSsUnDY0XT55HctXmh+MWe4gSXDnYTZcK+5V
 3+SrUBsjCMCbEa0z/plTBS6VyT9n2VwvEJyAevJJ/9P2uhAst2Ij5x2uKi5zEJMqJ7Mu
 9t8/Y3/jOpE8sGo6OOqL08HRgGTmQ95gWoKwzdFLjJW2ZOiyWhFKjtuTAWOkjv7tj7Ve
 ykyvy/9atynB+oR4FMMc/PIqroacEPDOCHomEJO/kUyErvN6ASCIMi6UQTf7pbfOqA/g
 Ns7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808282; x=1791413082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jnZo+hvqBlg2VdlmHakxJKIQ9hf0r/SuePtUe8eV9o8=;
 b=DA+ERi2p1mUpwbM/7QEWKBYQFUhi1qhUMxYPdwTn7EMopJQwRLG/iKlxyAVkrbeULH
 9jgMhlDNszWfXK3nS6F51FEg2eJCvY4x6YwSvvSP5YBwWKe6m3T4+5jv1DSJCiP6JrUh
 kQi7yoRquxQts5Vw3Gd+KbwGT6pFzbpH4N41cWRbylVvM+Gt2EZl4pxwSBgYTAJT2zaO
 uMvoXw96MOAXLsQvnMNHfZHsuMeNqiGIIdpgv8np/CSuKup2Wk30z3DIoSNP28y5IQaE
 vq/gjJU3ZTUeFihCiHpDkBFQjTGElw286Ai/38/TOX7OQILGGs6msMNPxfJNn4Pqqync
 nOag==
X-Gm-Message-State: AFq9FYI9FPzJYay+iGyBmhshkiqg0cRSbSdcGo6pkt83HPcfji7pwmJ9
 Y1QOpKd/KyT0dueIOpXhrRstnYfssYTXDV91BEIDoorw3oR68AG8MCdc06waDKSRppJgkQqp4L3
 2CxuJGng=
X-Gm-Gg: AYBFou0yo6lIA/okBarpzO9LulsIQHCq7ZAWiQSRX8ufjZ81ozpk87fmVo+oGtSRiHq
 y7bUNaWiN6f/rsN635t9Sjxlej94q9fjeOQMix6S/u6BRcEAAXlrOeDA6SXs9m/q85aWCAQUXpG
 1dl3bp1y/l+f8VYRY+9FH+PYIPt996Hd4mO4T/19aiF1f0FT2PIWeGqPk0LfpAZ1fK2VRn5nWAF
 /v77vFfnaUTthKPoRDzbWNljznszPrrWj+5wWJkdg2nngnIz4KS5JdXtyGRGjxNtkA4Ran5Gga5
 eq08XFk+OHiUnilY8jBtbljt7sVvqVvBC9nyFtcHAzA3HG2QqB5WZ0A4M1h4gARge2S4yKAOCCS
 3fVWhDMYodRU+Q/3W2iEwyfs5kaGkt95zrTG62dOuVohXEm3a7Hslgb28NYZCUWHEpC0WXtgwp7
 4rHdhegXdH6UZ+0do3K9ZZIwoBGu3rppJzH4aKzJfcxcPBfC8dHSrIuILMPnp3f+TrHDkGpwj0J
 DLfQBlBYpVOVZfB5fNPpOuIS/duTlkiK0hQlw==
X-Received: by 2002:a17:90b:5805:b0:3a4:cb54:169d with SMTP id
 98e67ed59e1d1-3a4d195e1aemr1327966a91.62.1790808282445; 
 Wed, 30 Sep 2026 15:44:42 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Akhil Goyal <gakhil@marvell.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v3 56/65] baseband/la12xx: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:14 -0700
Message-ID: <20260930224340.58580-57-stephen@networkplumber.org>
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

parse_u16_arg() stored through a uint16_t pointer and parse_integer_arg()
through a uint32_t pointer, but both device arguments are 8 bit fields:
queues_num is a uint8_t and modem_id an int8_t, and they are adjacent in
struct bbdev_la12xx_params. Parsing either argument therefore wrote past
the field and corrupted its neighbour.

parse_u16_arg() did nothing beyond a range checked store, so drop it and
pass rte_kvargs_handle_u8() directly, which also gives queues_num the
width it actually has.

The modem id keeps a handler of its own. parse_integer_arg() rejected
both ends of the range, and a plain rte_kvargs_handle_i8() would accept
anything down to -128 while the caller only checks the upper bound, so
"modem=-5" would be stored and only fail later in open_ipc_dev(). The
new handler bounds it to -1..LA12XX_MAX_MODEM-1, keeping -1 which
la12xx_bbdev_create() uses to mean "derive the modem id from the device
id", and replaces the caller's upper bound check.

The handler now rejects an out of range modem id, where the old check
did a "goto exit" with ret still zero. The probe also checks the result
of parse_bbdev_la12xx_params(), which it used to discard, so a bad modem
id or queue count now fails the probe instead of only being logged.

Fixes: ee36ba0f3042 ("baseband/la12xx: add devargs option for max queues")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/la12xx/bbdev_la12xx.c | 60 +++++++++-----------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 1116dacc4b..b9199189e7 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -912,44 +912,25 @@ setup_la12xx_dev(struct rte_bbdev *dev)
 	return ret;
 }
 
-static inline int
-parse_u16_arg(const char *key, const char *value, void *extra_args)
-{
-	uint16_t *u16 = extra_args;
-
-	uint64_t result;
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-	errno = 0;
-	result = strtoul(value, NULL, 0);
-	if ((result >= (1 << 16)) || (errno != 0)) {
-		rte_bbdev_log(ERR, "Invalid value %" PRIu64 " for %s",
-			      result, key);
-		return -ERANGE;
-	}
-	*u16 = (uint16_t)result;
-	return 0;
-}
-
-/* Parse integer from integer argument */
+/*
+ * Parse the modem id.
+ *
+ * A dedicated handler is needed because -1 is meaningful here: it leaves the
+ * modem id unset, and la12xx_bbdev_create() then derives it from the device
+ * id. rte_kvargs_handle_i8() alone would also accept anything down to -128.
+ */
 static int
-parse_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
+parse_modem_id(const char *key, const char *value, void *extra_args)
 {
-	int i;
-	char *end;
-
-	errno = 0;
+	int64_t modem_id;
 
-	i = strtol(value, &end, 10);
-	if (*end != 0 || errno != 0 || i < 0 || i > LA12XX_MAX_MODEM) {
-		rte_bbdev_log(ERR, "Supported Port IDS are 0 to %d",
-			LA12XX_MAX_MODEM - 1);
+	if (rte_kvargs_to_int(value, -1, LA12XX_MAX_MODEM - 1, &modem_id) < 0) {
+		rte_bbdev_log(ERR, "Invalid %s, must be -1..%u", key,
+				LA12XX_MAX_MODEM - 1);
 		return -EINVAL;
 	}
 
-	*((uint32_t *)extra_args) = i;
-
+	*(int8_t *)extra_args = modem_id;
 	return 0;
 }
 
@@ -970,20 +951,16 @@ parse_bbdev_la12xx_params(struct bbdev_la12xx_params *params,
 			return -EFAULT;
 
 		ret = rte_kvargs_process(kvlist, bbdev_la12xx_valid_params[0],
-					&parse_u16_arg, &params->queues_num);
+					rte_kvargs_handle_u8, &params->queues_num);
 		if (ret < 0)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist,
 					bbdev_la12xx_valid_params[1],
-					&parse_integer_arg,
+					parse_modem_id,
 					&params->modem_id);
-
-		if (params->modem_id >= LA12XX_MAX_MODEM) {
-			rte_bbdev_log(ERR, "Invalid modem id, must be < %u",
-					LA12XX_MAX_MODEM);
+		if (ret < 0)
 			goto exit;
-		}
 	}
 
 exit:
@@ -1062,6 +1039,7 @@ la12xx_bbdev_probe(struct rte_vdev_device *vdev)
 	};
 	const char *name;
 	const char *input_args;
+	int ret;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1073,7 +1051,9 @@ la12xx_bbdev_probe(struct rte_vdev_device *vdev)
 		return -EINVAL;
 
 	input_args = rte_vdev_device_args(vdev);
-	parse_bbdev_la12xx_params(&init_params, input_args);
+	ret = parse_bbdev_la12xx_params(&init_params, input_args);
+	if (ret < 0)
+		return ret;
 
 	return la12xx_bbdev_create(vdev, &init_params);
 }
-- 
2.53.0

