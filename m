Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7645CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A601D42FC1;
	Thu,  1 Oct 2026 00:44:36 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id F119742F93
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:33 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so3720125a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808273;
 x=1791413073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z77dx+/wuhXRMqTry3UqtMfEi2KvoL8zNkMtY74lkdE=;
 b=YcMIIUejKRzp6MQyOyBOE/OSS3yCtcKiztKBRQ2SJRmSdoKF0kk7EP37qgHxxxR3kf
 fDCNrUBBSxDvbSwphDXF5858c9pxXQ8XmSUftctsyla8CtpB80TobGdGweeczpPchwCu
 TPSpA543OZg4cjof8jm/hGED4OgjBMOKlfbFnWHYvSt8sroLfYlTA+tEAic90uat9hnh
 hXSowjOez5doFZPAtBDwwQneUYXu5fnLWR0wLZF0MPVqukJ7sE1KsSpJJXZakumK6qA7
 smPsYmr7qApjfcCu2hkx7bJ9SMdBSsML79Hf3QfX5ZfLVCjI9HuSa81RCzEaSrPU7qM8
 3Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808273; x=1791413073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z77dx+/wuhXRMqTry3UqtMfEi2KvoL8zNkMtY74lkdE=;
 b=JvwjVGR/ds6uX7px4JR7bEfV5lVQ6aOE9jZqoF2MZh+DggvVbmNz9Hrpl2dU5AU7iN
 nL4tVkNgfA0ji3tC3Ju7cmc/NPs8EjscXtsVgn9WnaVFspBHjSftZI0wI+g3rFMSPXtx
 9zHVRjdQ/XmWbu0S+CSp4GJuc1CWQnzFpI8UdEH8l2Zl/pYNAiviq5x9XCFgGqb2nRyU
 IhqNFu7pr5bI5J4mr/XYuYkw3XF8fT+YzH7qN330tEpaEyXjzG0QWWH4kaR1VcUt4kVw
 IvtpfjD0Ab/xxSiKsFUBVSnJpHAWp1KhudSYMcXsAvDKivZ38LFGFkauaP9+sIm0MwjZ
 5kQQ==
X-Gm-Message-State: AFq9FYJdn8V+XzEaxS1g11uoD01wgo2LMQvmOUG6KZknY0kh7hIR4lyt
 HvcZbEfkZML0LsFwc/s3jslCab4kezqs1PkYvB1E64jmAuXX8HE3fruSgbyEffd/LZtKgc27ypK
 PXKnAfPM=
X-Gm-Gg: AYBFou3ocDGAcWbXImlQbBDFSzs0etwkQB2ljbcUkE/xV3SMHKNLqcVCwzlGgByfxFr
 04GyFCbZOf+LKEo0/FSFKF5ZQFPcMclztpBd166secifIyEy6nl6Iyb1EyQMfDJEq+nDEDvzGXB
 tpDxhWgfBVNs5EoiXS0iJNqVCsaUYC+Wojn1mOFSzSDUENFrQggSnC8Gvmr+HGSmoU6gki9SNx0
 Q/39DGQDc1dCLxq3UVhpQvXyHAZM0Ineh1LL2zRqHO6KHsLG1tYk/djR669lYB4UDA1218cmhbp
 vMrmn77WgUd7maknGodbO1ZLhOV2QOPbOYyerekf0mH7nZwVyCf3Z3NfhENCU0WQ0eQXSw2X85B
 aLBELrOwg2sDBLblr8QvoDTeKdnyo0/g7vBgMZBcCqd2Pkk9dbKvVwRrIigubBALcfNLQW+whkP
 c4QA3yMRWDzZNlo8iUMC+Ba9qQnsx/gclEYBaSQ63lPz25gZGVppvInQu8CMJDuGp1G1ktlET1M
 7onMYWPCnys57t8+BmAf+wqIH2P9kaCWkIVNg==
X-Received: by 2002:a17:90b:3b4b:b0:3a4:c18c:b8a5 with SMTP id
 98e67ed59e1d1-3a4f6b4cc3cmr499657a91.58.1790808272698; 
 Wed, 30 Sep 2026 15:44:32 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Lance Richardson <lance.richardson@broadcom.com>
Subject: [PATCH v3 46/65] net/bnxt: propagate devargs parsing errors
Date: Wed, 30 Sep 2026 15:41:04 -0700
Message-ID: <20260930224340.58580-47-stephen@networkplumber.org>
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

bnxt_parse_dev_args() placed the "err" label immediately after the last
"goto err", in the middle of the fall-through path, so the jump skipped
nothing. The seven handlers that follow it ran even when an earlier
argument had already failed to parse, and their return values were
discarded, so a bad value in any of them was ignored entirely.

Move the label to just before the kvargs list is freed and check every
handler, so that parsing stops at the first bad argument.

Fixes: 29ce7059e8e7 ("net/bnxt: check kvargs parsing")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_ethdev.c | 42 ++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 2942482579..f09a1df44a 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6359,57 +6359,69 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 	if (ret)
 		goto err;
 
-err:
 	/*
 	 * Handler for "mpc" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,mpc=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
-			   bnxt_parse_devarg_mpc, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_MPC,
+				 bnxt_parse_devarg_mpc, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "app-id" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,app-id=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,
-			   bnxt_parse_devarg_app_id, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_APP_ID,
+				 bnxt_parse_devarg_app_id, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "ieee-1588" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,ieee-1588=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
-			   bnxt_parse_devarg_ieee_1588, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_IEEE_1588,
+				 bnxt_parse_devarg_ieee_1588, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "cqe-mode" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,cqe-mode=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
-			   bnxt_parse_devarg_cqe_mode, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_CQE_MODE,
+				 bnxt_parse_devarg_cqe_mode, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "representor" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,representor=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
-			   bnxt_parse_devarg_representor_mode, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_REPRESENTOR,
+				 bnxt_parse_devarg_representor_mode, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "scalar-mode" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,scalar-mode=1"
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
-			   bnxt_parse_devarg_scalar_mode, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARG_SCALAR_MODE,
+				 bnxt_parse_devarg_scalar_mode, bp);
+	if (ret)
+		goto err;
 
 	/*
 	 * Handler for "app-instance-id" devarg.
 	 * Invoked as for ex: "-a 000:00:0d.0,app-instance-id=1"
 	 * This argument is required for enabling truflow hot upgrade feature.
 	 */
-	rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
-			   bnxt_parse_devarg_app_instance_id, bp);
+	ret = rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
+				 bnxt_parse_devarg_app_instance_id, bp);
 
+err:
 	rte_kvargs_free(kvlist);
 	return ret;
 }
-- 
2.53.0

