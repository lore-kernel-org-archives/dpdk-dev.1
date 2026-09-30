Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD3CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE27642F08;
	Thu,  1 Oct 2026 00:44:18 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id D9CA042EF0
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:16 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so4299499a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808256;
 x=1791413056; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apwhLJ32drFL8qKYRVIJOeVb/PYvyotSN8GvkDwERmw=;
 b=KKXCbT4woaySI8hNs7lr0ccg2W60qLdhzxP7MJ1D7KHvHl70CPwFz66vBCrAM1JSY0
 cpJ7vIoRLE08WH1g+9NV5mrLt0K8kl/FfNzx65uiqDNS27hyZRZAW+1xDHT+txSIva3E
 4uSF2/3sC61tcUpYlVnrgR2iwG0JhckfQnhXnT3y9B3ypZU8kOGaiKr1F4/hGtJfdY3g
 mUzQb9PcEV3jLcv2MYQ1tMABglat7FX9cO+t0xT6r50Lxq4Fe77xljm1qH37PjlBUsZe
 fqdXuErlMEpKEqJXegi754o9upEBVKWFF+d/EDD0t8P8qkALl7CeZNvfnKpKliSdcK2S
 r0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808256; x=1791413056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=apwhLJ32drFL8qKYRVIJOeVb/PYvyotSN8GvkDwERmw=;
 b=yvEONeR2JPW+aLTR6aAHXrxd4DYH+YKoMlWRENlL/Iu8/2yDlKP0dPPvLs9Br8z4Mk
 qhc8n46AVeEiy5113go71oDzX/A/DK159jkY0PTFFSzFCazG8tvQeULIMtageFgKAj61
 VEALwYSpOpecAg7OVeGoLU8YrZHxSFOroAFYNqWxi0SwPF0GzRmVc3J0+U0Z20LZpEr/
 KFX4otT38H3PFp9R5oaFWEBpSaAuLbli98WEQWRTaHw7v1iPLLmPI6+ur74B0uet9HEI
 Z6vqXEOZ+3dEZ+gFcKHP2vCo4ZK0HKeAdbWHNH+RvR8A/Vb8mFyFZ6vBDbp+VYCRrmy1
 9aAg==
X-Gm-Message-State: AFq9FYIeSEpKH98RgyLuAZ/8o+a7/WcmrTZswSBBCQmwVGjHscyZKlNr
 LbrJEKbs3xt8Qc8Ejuv1Oe2Tfr1UhpoPWSkrKBqY0kJZvm5rzJ4b6UJW8Jw2HgWPEMvbts4ZyIZ
 Nds/6E2U=
X-Gm-Gg: AYBFou2pOkpVPcAlpi3tFCaiBsDjg87gjF+3kGbQFTXWmtW7wsIsavv59nHXElt6P4Q
 jwcHi73bYVLs7SuY6BSBNyQbj3XUww2eUfOIaH2swkReOuCAoFgdYajURTYPOUq+Pq2qPDoT1xK
 4ixiel1VT964xfpyJ/QYunptZSoAiZr1lAk7fH8sLRz3t3RSoEUWlY1xOmVyUZnZxdp8NhUDT6n
 zvHxiuAM0JtmBSelBoq25iF7WbWFQlVjlvGOBiL9DkSgtPJ4grFG4OxWgG059uLkWlLlVQAFMTg
 1ANBqxgo74mfjyojOhJSHtskYF/Nx+EGcurOzvgUHe9DBDB3bVd2S5q5pI+3+EvW96Wb/fikxcU
 syxuRpUN9eeRgO5lDlCWjvgxnedB4FsnPnNfJA/ata06iLjehUMqnAAhVN66S5l2Nu24m8GhW0d
 oUd/f3Kvc0szIUztXPJuJN5DMKtxUqNkXhbKzBDt2bnw3lOUCAkRBuH/Q299pXT8LyRsnZDOkr3
 hlEW0KqaqUhb+onrqky5yT6Wiyg9CDxO3yIaQ==
X-Received: by 2002:a17:90b:28d0:b0:3a4:fe48:d412 with SMTP id
 98e67ed59e1d1-3a4fe48e5eamr83295a91.30.1790808256005; 
 Wed, 30 Sep 2026 15:44:16 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v3 31/65] net/octeontx: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:49 -0700
Message-ID: <20260930224340.58580-32-stephen@networkplumber.org>
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

