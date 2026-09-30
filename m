Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F691CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33F0742F69;
	Thu,  1 Oct 2026 00:44:27 +0200 (CEST)
Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com
 [74.125.227.146])
 by mails.dpdk.org (Postfix) with ESMTP id 197E142F51
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:26 +0200 (CEST)
Received: by mail-pj2-f18.google.com with SMTP id
 98e67ed59e1d1-3a4c276e1c7so708176a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808265;
 x=1791413065; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xLPm7t7KMuBTVWw5952p6vaxvJ8B3+9NwoHqF8bnKJ4=;
 b=GQ9eucJpBeXfpHiaJvqA1FgXGz2z7RblwgNTZCQ+Nwnw8PhNrPvFCkcqNAJnNewkzB
 dzKMPhUh1ryamWzyrijtKDmZe07c0D6f+yM4x0FNJR0T/TGwA7vS60e/e5oYJQELWY0M
 AyfH+F0N0BiIo4I4PsNavmyPd8t0EfFOTaxBw4YmEVJCorE8SZW7bwUJNBOUAR2ImyZ/
 XUNxMMbaHCeSC3f3XZdLSbVO7XDP6HUK+8K6vHkfw+1vsXmSSlfypcCUfzwP5ml4F1tS
 E4REsJPiShvCN3/RkJoziqNlZp/+68Wm4bTwUma3JdUsO+AXLmKqI71BTkCGmlzCJ+4Z
 Z6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808265; x=1791413065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xLPm7t7KMuBTVWw5952p6vaxvJ8B3+9NwoHqF8bnKJ4=;
 b=Eml5LoYpe71Qju2RLoQz0OjPbb1S30hznDOMxIJ0NXG4acR4xbCSSdOLLRkLxO5BEm
 BjYyuwdcvnI35G6sdmdp3a6RavWhK4j0IjD99yIQoCQohxPGl6W9jhqLqegewKKnGjsh
 Y5w37jArC0f0cYnVEdKt0No6Oqg9PUp/XbXg/InMH+74sIUSTnXz/WPLb2pVQfxvRqU8
 9K0fZaNX+vxJxCPObtwpQJKKZoR1FD15ANOorrJcCTnLQERWB0cPhqLEUn34sWqROCG0
 n4sxJzwvaoRgGGBLEoatYhvTg8CvXila9Ms1XfKYRklVAs6EpBUWfFP2/Ij/C05MhbB6
 SZ6w==
X-Gm-Message-State: AFq9FYJutjnXSHSHJgrMpE6/jX3nscyro/lyRPirOKm/mAj2qQSQC5pr
 6J4UOtHgeWgbShpdBPJQwm03yajZipdiIYqM6tPsohTGTnAgAEwNo/z1kvBgkFwXs/GayHbVxAE
 wegSlfrI=
X-Gm-Gg: AYBFou2DCMQI4bzn1RPN/ut0x6VOBIrvKr6GcId/0odGhKUxcZEybrwKOeEKgPio5F2
 iO+X8IrCj4ILn0Mf/rsI87NaMiV7FHkLFSkH9xHEeD7mg9DzsAoZKIoXjUn3n0HrxQrUzGeY07a
 +WJqdzF250NIa+DeE2ADxR+JGsD/siSgexA6ulIZXs2van/9n2mGJHRrnAoaFU75nQcYZ6rpnh7
 MPogUhzMlUI6RUB7scJhpWieGtlgaprQk3UTXZU0HC05aNBX0crytlSWFtdLbQeK4qPG9ThKhWc
 UkvEnuY8AI+iEeIwOkKH0GBYpmAI5Fj19nwsAhbQkNZ5o3aLIrcarbq/85k+UZxSNJbuehZp6du
 uNbStOiqybRgk/vI9ATh3f8CWpEPMOSvTNc3I5uHBB1VKbsKdoxiprrbJE0kuuYB2+Gzs695CFd
 AbMhACmbJHwFfRSMEMMUduCBzgrmKJ19s37CnG+QaK/lNHdbY8R2Ufpqd4oq+IUWqXkJds1Mvkx
 +cBPb4JC0TsMgbhYgUEyri0Z0aoFy4X9bptB0pYjpGrdvTe
X-Received: by 2002:a17:90b:5343:b0:3a4:ba6b:cc24 with SMTP id
 98e67ed59e1d1-3a4d193fc4amr980921a91.58.1790808265059; 
 Wed, 30 Sep 2026 15:44:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH v3 38/65] net/xsc: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:56 -0700
Message-ID: <20260930224340.58580-39-stephen@networkplumber.org>
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

xsc_dev_args_parse() uses atoi() on each value, which cannot report an
error, so a malformed argument is silently taken as zero. For pph_mode
and nic_mode zero is a meaningful setting, so a typo quietly selects a
mode rather than being rejected.

Fold the three copies of the lookup into a helper that range checks the
value and leaves the default in place when it is rejected. The defaults
are now assigned up front so they also apply on error.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/xsc/xsc_dev.c | 50 +++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 478f489516..78a0984295 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -199,34 +199,48 @@ xsc_dev_alloc_vfos_info(struct xsc_dev *xdev)
 	return 0;
 }
 
+/* Parse one optional numeric devarg, leaving the default in place if unset. */
+static void
+xsc_dev_arg_get(struct rte_kvargs *kvlist, const char *key, uint64_t max,
+		int *result)
+{
+	const char *value;
+	uint64_t val;
+
+	value = rte_kvargs_get(kvlist, key);
+	if (value == NULL)
+		return;
+
+	if (rte_kvargs_to_uint(value, 0, max, &val) < 0) {
+		PMD_DRV_LOG(ERR, "Invalid %s \"%s\", using default %d",
+			    key, value, *result);
+		return;
+	}
+
+	*result = val;
+}
+
 static void
 xsc_dev_args_parse(struct xsc_dev *xdev, struct rte_devargs *devargs)
 {
 	struct rte_kvargs *kvlist;
 	struct xsc_devargs *xdevargs = &xdev->devargs;
-	const char *tmp;
+
+	xdevargs->pph_mode = XSC_PPH_NONE;
+	xdevargs->nic_mode = XSC_NIC_MODE_LEGACY;
+	xdevargs->flow_mode = XSC_DEV_DEF_FLOW_MODE;
 
 	kvlist = rte_kvargs_parse(devargs->args, NULL);
 	if (kvlist == NULL)
 		return;
 
-	tmp = rte_kvargs_get(kvlist, XSC_PPH_MODE_ARG);
-	if (tmp != NULL)
-		xdevargs->pph_mode = atoi(tmp);
-	else
-		xdevargs->pph_mode = XSC_PPH_NONE;
-
-	tmp = rte_kvargs_get(kvlist, XSC_NIC_MODE_ARG);
-	if (tmp != NULL)
-		xdevargs->nic_mode = atoi(tmp);
-	else
-		xdevargs->nic_mode = XSC_NIC_MODE_LEGACY;
-
-	tmp = rte_kvargs_get(kvlist, XSC_FLOW_MODE_ARG);
-	if (tmp != NULL)
-		xdevargs->flow_mode = atoi(tmp);
-	else
-		xdevargs->flow_mode = XSC_DEV_DEF_FLOW_MODE;
+	xsc_dev_arg_get(kvlist, XSC_PPH_MODE_ARG,
+			XSC_RX_PPH | XSC_TX_PPH | XSC_VFREP_PPH | XSC_UPLINK_PPH,
+			&xdevargs->pph_mode);
+	xsc_dev_arg_get(kvlist, XSC_NIC_MODE_ARG, XSC_NIC_MODE_SOC,
+			&xdevargs->nic_mode);
+	xsc_dev_arg_get(kvlist, XSC_FLOW_MODE_ARG, INT_MAX,
+			&xdevargs->flow_mode);
 
 	rte_kvargs_free(kvlist);
 }
-- 
2.53.0

