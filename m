Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D86CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3704742F41;
	Tue, 29 Sep 2026 18:40:01 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 2191D42EBE
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:49 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-8807e5b8fa9so2687394b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699928;
 x=1791304728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z77dx+/wuhXRMqTry3UqtMfEi2KvoL8zNkMtY74lkdE=;
 b=QE3sEUGYrClf3j9fbdZUd4z0CnuJ+/MsCuID4HI+Om4dzr4c9h6Mst5GRKOpNxVOQL
 XgczP49TpajHcu/yvHfIpuHS8CKqeZ9h+J0wKHRCEp01l6NbaMDpdSMmlj8Hoh70tNJp
 ko8kE5n2dLGpoZYhRxq0LA5DJegY5LjPWCX1hLDZ6vHjgHuD4cGfMLVxNt7UyfV1s7Vn
 /aUznqC/u34bthbile7KGuCTfQs8ISy6s2QYpQH6vddfU5mXELjdmndDWRBFh3IH/bFD
 4WOOh2aT7F45YVwbfan9rV7tQE6f9I7g4G7Bih5tjmc3BGWuDbI2aBKUY86bPo/geHFK
 miOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699928; x=1791304728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z77dx+/wuhXRMqTry3UqtMfEi2KvoL8zNkMtY74lkdE=;
 b=1Obk2O4E7SbRDpad8/W+0GuZ42mvUe0enlMyo4aaX7e7LYeuOo6w+Lm+YkB9G4EdHu
 GOyGG8+Rm1/qf9Fg7Gk+ZdXL4J5eNz0MZXuchrWp91KW6nT1P4BDcQdl74+CzHdWRm/+
 9chMRhr47HWlRi/9zNtQ81OOEL4fB0ckSkyMWU7FL2ZJCRLAjwg6oE+t7yHWKiHMLGJw
 ueEpq+vdZ4rQw4xy+h/kIRRBOhtHdJGItQatGervPhEgtZSHy66P7jTOFQNeZRROaRqh
 8Y0Ms2XV0qKdd5Dm+mpHR4u7IGPKTu/m5lA2TrDuZ0DGlZMhbJd50Djy01xn2odX73Su
 LYFQ==
X-Gm-Message-State: AFuF++nOwqX9oieGNwAckNH+RINKR46TH5+0ehu+W2w8cV9rPTDUml/5
 28VXR5VQ5/tfZHePKiJTzCKWle3VmY//h4TGlYSHCpb8hOmcfvbZWeoQCWtmN7a4sS+4YCqiBYN
 +taDFNPI=
X-Gm-Gg: AYBFou18aiM5+332hGGNQSUcKqUDp82CCnAQgnUOmcVeugykVLaas0A8a2X1IeQ+5OQ
 hEg8maXo7IT/F5Uk8itNsT18sibbttdbm3JDzHDBdP7yPjZmO+5ovxLr+6k4IvdkNCOEUkxOAT4
 nInFbc+CqoJJrqoKcNUNZXGby/d1uUzn4zwpLWvSRARVApAurgbG/4BPsig5/9SYr5cwNF/5Y1t
 qbx+NRFwgM9C8rK7njxnKJJvLv9e7ZKasxXDCarXX12OliFWDfs36uQ2O6Gqwt8termUQ87oZI6
 gbbaM714BSbbFazAATh+e9M0/vt3O0+HKWAVGNEiheWxeEpdFCkDjqFUWwHB5qjnfxgmlUZGNnb
 zEfz+BuTC8/AGu3w/upKAhX5WT2AWmhi8cnNz+f8d2mg5rKdzPfXK3rPNe2o55/WxrTUy4M43O8
 1EF0S6I0EUoeU6GvQcR3Omucoe6eXRmku2Lb1r7k63+bwOL8p1elqqCHiceQ6IFOv//NSSRQvkT
 JFi7x2kDrKgTVNLxpnro1x9p6LoD5mnOvw8YmQ=
X-Received: by 2002:a05:6a00:883:b0:881:8784:95ca with SMTP id
 d2e1a72fcca58-881878498cfmr8244116b3a.33.1790699928266; 
 Tue, 29 Sep 2026 09:38:48 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Lance Richardson <lance.richardson@broadcom.com>
Subject: [PATCH v2 45/61] net/bnxt: propagate devargs parsing errors
Date: Tue, 29 Sep 2026 09:36:48 -0700
Message-ID: <20260929163800.1108305-46-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

