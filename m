Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AF7C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07A9D40ED1;
	Mon, 14 Sep 2026 07:51:36 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1BDAA4069F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:33 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d715f4a587so41364835ad.2
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365092;
 x=1789969892; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xLPm7t7KMuBTVWw5952p6vaxvJ8B3+9NwoHqF8bnKJ4=;
 b=TJcEf/v+2P8fxlT6EI4VecCkm9cKZmz++icwjm+EGwvv/MT1f5w6E/fBDBnOfqH4Sg
 JfVhnKCL099doVU6eiGEFAIlgOqkXDKYDoOsm3v3JlbPPnVgRJV2RTvkUchMy6Q7jtic
 r7BBy8PLiuNWa2RQXXxKVfzHUAQ6eXWdEAet9x5sOe/oZT+AfT+LMajMhHJnGzgIp5JI
 Bx+DFxdOtspltDeuEHW3OL9mYHUH0b38AVkchWzSRvRJlH/ALFgt3VgN+gIctyueHFU8
 BzvpCdRMe34rqUvSM+HdgMcDrgKR11Ow2L/NBcbdQhQjcD3fuH/LOJUjMxWDd2DcX0jj
 VC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365092; x=1789969892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xLPm7t7KMuBTVWw5952p6vaxvJ8B3+9NwoHqF8bnKJ4=;
 b=l2kjs+LFwQECVh2u1/T0HKSKKm701JQMpAFMrXbZoL/POAPdc9jFg5nSBCnj4sYtfZ
 4rJjnIFHNLb9BDh8hUqhvopVXsRLg6znxpev9rxD6B5Y0BWkOlnB6xa0LM2eBKDKh8Qc
 euaae4CAu+qt1w7eTOv/yDQU7hHZ+ZRnIAooejCTPstlhHbsALs4LqvAtZlNCxJ3IucJ
 Mb6IFDDnZgf647k6v9EfTL3cPA7tbjYwk+vh2Alz02DVT6yyHdsHwSAjs2q00CWJvKXb
 CYpfvFh13VNHrKIb4MGWIypWm9O5APFOSwRjXviAuCawUjBBigCvnltwiVeaiDfIVU8E
 LlLQ==
X-Gm-Message-State: AFuF++lD+FO0/6o0ZC9dppJR65nWtzeJi28jRUKVATKBMgMwhqgHpER+
 Cj8jp2D+ohDuEYgr0JXw2+8YeXLcnufAJ0m979Iyyog8ooTIfqWDwjlEoM754VyY2EXUTUf4De+
 CsT8gEBI=
X-Gm-Gg: AYBFou0RC87I83D+mjTZCoZG3NXQQ56ITl0OaLmGTuDHcfw3uQiz1K7gJWPMK1nzHFv
 fwgr+bKLCnHZ3RCUg8Emyph7Vtl8Id++J9jfZJV5+qGJ2uhuzhA03ch8tuZsFvUGK6js0MMAvxu
 fgcSariKZRdfi51p7EQTj09WVpUgpJwEIZ+7wBXMGqVDKjJ+GHk0ErszBdAJZBRFjwfdrP/qDB6
 abXHQ4s4j7zAmcnKSot6dSEF8wBvQvNLhRw5jq8LRGbwiuh1hxrcPCnAqpF4X2ncdcgUFk/iXC5
 UMPhwX2vQD0L/MW+5uFWs1Qn08SpiyHiEKurV2Yob92pkYPjNzfgd5OV4oywCoezxen55M5KuPK
 1prj06hTioz8WDi4qAXyJX6JyKH/P/2IKbp8Gjiz8zNm1SP9S1e0MaaeRI1iBINNo70eaAWRH2s
 s5cTZWiy6S5r/yLRzZyNOR3XU0v3oD3fLYhIKDMziC83/5pJ9yiFbq6nDfZRAbnueigCFuY6nF/
 x0sPu9oecpWpm1kz1+DeoDhOMih4G2xJoJZkA==
X-Received: by 2002:a17:90b:5810:b0:39b:370e:c807 with SMTP id
 98e67ed59e1d1-39dec09871fmr2572020a91.17.1789365092114; 
 Sun, 13 Sep 2026 22:51:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>,
 Rong Qian <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>,
 Dongwei Xu <xudw@yunsilicon.com>
Subject: [PATCH 38/62] net/xsc: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:09 -0700
Message-ID: <20260914054912.755403-39-stephen@networkplumber.org>
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

