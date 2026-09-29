Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D75CCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2737542F09;
	Tue, 29 Sep 2026 18:39:35 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 74BD242EAB
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:42 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so1990905b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699921;
 x=1791304721; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xLPm7t7KMuBTVWw5952p6vaxvJ8B3+9NwoHqF8bnKJ4=;
 b=sw4shRLfKvu2PHpZnrunJiUaagJJi8qUZOVwS3NR+4Mhk57YaLeGMv1LTFRLIDsZqL
 SPT/vFH+LEqSso/j6a5qx90dOGcNOqwH609+yI7hcUvaVMistJGlMPYdbDavHS16szEd
 T+ydo136knowv3QchMLvYx8UOuTqpqELd+MMDmhfb8qbo53a9sQ4iLrsQF6oidDGBpGM
 3LBg+eN7EsKxi5fF5LPDSoOnC9Bt4+PU/Onn4Ennnzw9m7kL9/zYfumZbHny4w8NAnV3
 Xm+ZtrTJYPObnAvmPlEnYdCZe/w+RkvS/FdVl7hQFY/5slj4p4VcckIDRNV4VfHBuAbc
 vcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699921; x=1791304721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xLPm7t7KMuBTVWw5952p6vaxvJ8B3+9NwoHqF8bnKJ4=;
 b=mfbHymZvPde6rTnlKIv/m5ZKmD6wCKWKwZSSf1NoyIFKd0YRghVDOpoJazQm+xEIXg
 XPSwhz5OJVxkLQZ8Fg6VxrOAKtbRc5vEN3obWYgK0UcBwLDFvGu/B1zb3lhS0nAD8B6X
 U0kIBrGKg1KfUnB9l3Ok8z+pSx4PCfZGKmJQJuZ06aUa22Hn6CKybw+tZitwv26X4I+d
 DcOvxorXOxsjGIGtv0fizLTWyi0EJLw+BJPYCGYhscFaR5wqbsnaOeC45x84Z4yUzANP
 2oxSiDuzag4Vgf4GigLgcHWMGhBgsaw8c3paHEDgyHmX5ZS/svxTnbEFTbInSDdviv5h
 pPMg==
X-Gm-Message-State: AFuF++lvJCP5N95NzZQCAB56Aoww6ny48JPIeHTeLxh3wZ/10aSC6Nki
 fC0Tj8Nf/DQh1E3mMAaU/c1WUKpF0jqRfPATx6dt/D+rjEH1vf1odVoGqgJr1uAsw7sKNE1zh2G
 Z87S9MB0=
X-Gm-Gg: AYBFou2eAEwgv8zb8452VUmiJu8ktyppcwUJURA1LMJRjNp6ppTqT7JRav0AzZP+s0C
 /cU1eX9jcADdMt+Ace9NuJteyz19IOTlGpA/NHlSWkeFOp5zZmnqH3wXy12CnhXLRJmhPamSt0T
 h62ZEeqrr34oOtQzDXA64Kv60MiD9uIj7vNFtRQKJxqoJkMqNqNS6i57CgxsYIoO35xjR2FUll2
 9RfyyNawnnyORprm4ogXpeUiAKsd1zhZ1T/6yE/q8XKVEWdazUzFy7FU6MjD5T2KL+Lfu+5nyIh
 y7nSfit9/zMwvZdUf0Q5lZFpSY6siTefanctaRhYcpH29IBkibe/qVnuHcmc0RruSM2fG/TYIK6
 QsgWq3g2k/DdEOyzpM73i/irZce8tad5uA/lewUMxNd2rGzIBypvR/GQtIPpdr2IKTwChBc8iAB
 CPJolhf4vJlYmEndH0XwIbCQz7jycRpFBZcZ5v97JohyFQ/bH9vaMgF+ogf3lAv0N6itMx6q68r
 9vlWB0o/aV7VkIaiQFuIdEPyqyi/S73LTOi8A==
X-Received: by 2002:a05:6a00:2991:b0:882:d8c4:17c9 with SMTP id
 d2e1a72fcca58-882d8c423bbmr6216723b3a.23.1790699921641; 
 Tue, 29 Sep 2026 09:38:41 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH v2 37/61] net/xsc: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:40 -0700
Message-ID: <20260929163800.1108305-38-stephen@networkplumber.org>
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

