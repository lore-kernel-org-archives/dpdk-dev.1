Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCDC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DF7940EDC;
	Mon, 14 Sep 2026 07:52:01 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 2CD5440E01
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:00 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fe517774so21356745ad.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365119;
 x=1789969919; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jvxup0Pf+WZvs6CpgcOzVj4qs4wV8/j3dtSYTSXeZxc=;
 b=LyJQ/ITRgLAjo+L21TpPuCOi1zEUkmsnlZS/V9rGQshdjRSwj+7EU+GIoFkdcP4NdZ
 mZGFjYxk81iXEBGu5ZyU9agsv7X7lAAP1OgqONcOET483/ZWhqRC4wATkpL8Nh5yJ1cb
 SaaG2SamJSRaou7C44JzujP7WAz8c27HmvaQ1xAy+FqCdUJEn9qmBgS71lJ81Q/aiRvC
 O/9H9Pbo0sBEwak2+RiANuT94fnxAxhHug5MX05Q7Fjwa+h2N9sIwnWbPe03FmNbzLNi
 r3fF3Z358DmN60QfljIQ5FR6L76bkLViAlXXwSa1b0YW9ML6q/jNBKCSPKELIUTJOUou
 bfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365119; x=1789969919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jvxup0Pf+WZvs6CpgcOzVj4qs4wV8/j3dtSYTSXeZxc=;
 b=nLbxx9/ECh+eTewruWspxMxtxmvhh6I0EofVpBBumVJM/wHQmp2EdZXaugZ1sqKCDQ
 M0a4+Gq3a7vAf9ETbeFpRDb+CXYe/KoPASIsmIg4y0Y1qvoivR+IsmBRtEq4ppUBufas
 T4zUfpFObvsRnJoZR2SVgBvQ1MvL50zegF+W0B0T+xqX5iFyKHb832P8Z+CWb09kfw5k
 2Mt37wm8gmZb6A/gKz5GOMXR15wV+4JnJsLnlc2mWWoay0mO8jY7I9feV9HV/Nw2PLDb
 2q5joIWpnvb3GP7mcXS00/dyHJxdIJc8cK7WJZFLVxkpWoo0UFoa/I4sNqWoZmoiJ/T/
 0UEw==
X-Gm-Message-State: AFuF++nBKA0P/dITmapQgMilJjLYBmmMPEYEyf1ioI1RKES7aF2u+55M
 y3oEpvyXUmF8Wz6EixbVq+S3o++8cMGDoeTpoR5xfWtCLt746S6abJ9K/BggxX5DaP44zW8ntrb
 +1m9ee+s=
X-Gm-Gg: AYBFou2uy3zxj/vupCX8jHn0XR8xX9LhHOVo41r87fXWaLDYH2EXtnq/XzkYtXVg7JW
 SPT4gE2vhOGYm3AZPNSUW9j5QYIqusHzt+V60yi4CZBq1KrJnvcKmoBRX8S62uVlhDuIrXB37ZH
 SbloiFX6KI0KV611SPxWSVNBrtYlq65zKbmLQyvF5r89dpD/nAXSauZejV1zQYNyGewgK+/JvjN
 BZH+q91XpqXIFYCR2+icVsARBBk6eFYRjLu+eYOLxDO4e10NrfQ8YKkvugCyfJGWtms0TgiQkgQ
 4O+7u0/+Ig/+dLOQtM3N+LLG0CAUIn/GkqWmFN9La/WWk/GI5UmC55RfVUKYaWnQZsExucYoAey
 9N9HUGJQjhQcqDpWeqeaB+OFohSJlf9J6emzdt/clfaJmxLW80JvuT6UlsfgmatKePUSVOvEOjL
 gvFWPNCP9fQlAyk63pRviVpuBNEW07UlprzvcpJ5SjPvkEAZ12FtJKlHsARXXSbGfo0QutANp7X
 b79xm217nzNrqpMsBzxvblqKMMnbOYG1G9BgA==
X-Received: by 2002:a17:90b:50cc:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39dec1c2074mr3107250a91.16.1789365119209; 
 Sun, 13 Sep 2026 22:51:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Lance Richardson <lance.richardson@broadcom.com>
Subject: [PATCH 46/62] net/bnxt: propagate devargs parsing errors
Date: Sun, 13 Sep 2026 22:47:17 -0700
Message-ID: <20260914054912.755403-47-stephen@networkplumber.org>
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
index 4903f6fb10..816d466354 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -6353,57 +6353,69 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
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

