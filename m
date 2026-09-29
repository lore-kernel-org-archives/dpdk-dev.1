Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BFCCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 861A242EA6;
	Tue, 29 Sep 2026 18:39:28 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id D337642E49
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:35 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88582e2153eso764491b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699915;
 x=1791304715; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apwhLJ32drFL8qKYRVIJOeVb/PYvyotSN8GvkDwERmw=;
 b=Np1DpN4GyKoVg4OMC7Gep3tewDl/SZF7oapF17O2Ewaj71qfSSLgTlt+1Uv74kkqLO
 KDkCoWSEl03w6qoP1AgSWzbnjY9u3hGRhtwOdmOWlOVW2b+fYoHtPusdKOeZPHJ6OYUL
 HvhkZBWOP1SyKh3R/8ne48fV3kjurA7qSR1GCkk1iZ28G50w5X2ywLI6M6dMxwZrnRAv
 b7XQtejVxewBMYGvcQSnluZXiJXY5QPYLrbkCYf58wpGC9tvZoP5HO9Sm/mgI1UZEFKZ
 7vDvkiF5X+Xq2NmVBzQDX8/I9BdINaHOmP2fQvTwqttwLrqTr5cGzyd/Y3spmI/oDPww
 RMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699915; x=1791304715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=apwhLJ32drFL8qKYRVIJOeVb/PYvyotSN8GvkDwERmw=;
 b=BtACz1hgL64Kw2yOj+W7rFeM0UsH+oFGGICtGUYNoXq495VtSjfO9YQl8FsuK1X1G2
 QHqLHfMzlJqB9nz9s3CzJ493/E1h4g1/Gg/XqoiVia8a0US+cDCqhxDxSI7Bi9ur7xLV
 Vlu9qaZBpLiUzRQElE7GWm7dvYtuOpsFT/R6U8TrcAtpSWQy/OO1Ok5IkcPX7l2UbExZ
 QJ3IeQCUCuPKKGjbRjWoNrgqbritrOq84tPohM2BpcZJRXVMZPiJLmUXL2ONczvq3lyL
 UAi6ztAkdCx0UFJjnb/ioxoRGIjpmhDivhYhqzSox/K+HHq41oCfZh4ywnLceAyz7x7M
 1NTA==
X-Gm-Message-State: AFuF++kn3rFAvsRb81RHPqmmGR3vm84QdAliaXFqGj+tySnT7mjvvkkl
 vcaHE+S0ojg5Xsae6GoSmiK3RyGncVIop/EK5Tf/vukuttKl71RyCloB9avr8z9vV8qB+0GkTf8
 p7ZbcYoE=
X-Gm-Gg: AYBFou3BlJ560qVzd0uRNIaba9HIiL3ehuRDwinzap4lGWT6Xrs7CftRZ0iUKEHN4mu
 K7p5W/VUIJWybSTzOR6uHHMKb83QvEy3SGSO4xCQ9ZGS2ltPU8F19kGF0ZKrXvb6ibUEjFiN7UX
 dZBHbGSVYKNKZe0qzUXjv2WeNNNIF/9JytGlkoT1SjWYFsgJAE3Or8KLt3rrX4cRZMZCREVGbzw
 P/BhtJ3LfgPPflBBJcjT/tctKd42Gzc1SAFUe6pTpsh97TNJbJIcyluuUxv4kDUbUQwZ+nClfq3
 3ZRWL5niXd34T9m7XSY62s5M7g1jklIHQ7bGvxZL/rOqcvi0f2AV0l09Lf6BSoSu1X2KOwsLKbt
 fXwO31Y5+kfOhDgFcBBbrvUqI4B2f48pJz+xUC1mE8K6AOm/YqX1w2mrVsp0cNDMENjQHQQiDcB
 axpW9t62OnFHnofZ2ky4IbtsGZ8rPsU+jPr7rXITAptAaNWhh8a45YgMDaRP47d4iKDQVyWZJzC
 9LOw+UDrKUzEw3DEG1mQJC0/tMOrN4p8wliyA==
X-Received: by 2002:a05:6a00:414b:b0:878:34d7:6a30 with SMTP id
 d2e1a72fcca58-87e9ea6226bmr12486300b3a.36.1790699914948; 
 Tue, 29 Sep 2026 09:38:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>
Subject: [PATCH v2 30/61] net/octeontx: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:33 -0700
Message-ID: <20260929163800.1108305-31-stephen@networkplumber.org>
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

parse_integer_arg() uses atoi(), which cannot report an error, so a
malformed value such as "abc" becomes zero and the negative check never
fires.

It also stores through an int pointer, while the caller passes
&params->nr_port, which is a uint8_t and the only member of a
struct octeontx_vdev_init_params on the stack. Parsing nr_port
therefore wrote three bytes past the field.

Use rte_kvargs_handle_u8(), which both validates the value and matches
the width of the field.

Bugzilla ID: 2036
Fixes: f7be70e5130e ("net/octeontx: add net device probe and remove")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/octeontx/octeontx_ethdev.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index e4dca30d9d..d2ad9a7d04 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -65,22 +65,6 @@ RTE_LOG_REGISTER_SUFFIX(otx_net_logtype_mbox, mbox, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(otx_net_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(otx_net_logtype_driver, driver, NOTICE);
 
-/* Parse integer from integer argument */
-static int
-parse_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	int *i = (int *)extra_args;
-
-	*i = atoi(value);
-	if (*i < 0) {
-		octeontx_log_err("argument has to be positive.");
-		return -1;
-	}
-
-	return 0;
-}
-
 static int
 octeontx_parse_vdev_init_params(struct octeontx_vdev_init_params *params,
 				struct rte_vdev_device *dev)
@@ -106,7 +90,7 @@ octeontx_parse_vdev_init_params(struct octeontx_vdev_init_params *params,
 
 		ret = rte_kvargs_process(kvlist,
 					OCTEONTX_VDEV_NR_PORT_ARG,
-					&parse_integer_arg,
+					rte_kvargs_handle_u8,
 					&params->nr_port);
 		if (ret < 0)
 			goto free_kvlist;
-- 
2.53.0

