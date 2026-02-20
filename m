Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C1EC53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:04:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44FFB40653;
	Fri, 20 Feb 2026 06:04:21 +0100 (CET)
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by mails.dpdk.org (Postfix) with ESMTP id 1AA66402E2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:17 +0100 (CET)
Received: by mail-qk1-f195.google.com with SMTP id
 af79cd13be357-8c70ab3b5fcso234391185a.2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563856;
 x=1772168656; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoeCKh+oi72zMTrFwuM28at55S466RG7Q9BDFLcGKqs=;
 b=ot38nHCfSpQU5AtIKv/o8Iu61ySV0iubg4onH2hc7jWTdbFNaQR2tT0oBQXF9C9929
 VHwqiYiZs7rAYMzGcR5ScBoS93RXQZerD6mGNqAIalVaJDBBO3BH+6gl18Ik0o6f0Uox
 Ke6DO07dYHJVzB2nR0FjlX9Yr65/IPbxloGj++9YjxNsbV4bdqCoCTqkMLx0Xte84Jls
 gGgnlwGeY5enxxRk689c5bslu5bQm4ehbi2TfqKnvdzPiFncx01QPnKHcAFFvbAV6TqZ
 5ax1C6U0Dctju/WkCjbRa6RqonnDqvyGqlLf+AlphJmEl0fuuHa5Q9lTMjrwLtTxppbf
 9p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563856; x=1772168656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QoeCKh+oi72zMTrFwuM28at55S466RG7Q9BDFLcGKqs=;
 b=iqVBtDhg+cMV9cwYCvIv3Z7hDlwfl8tyw35sfJP6MLun+BQ9XNJfIBthZsNw5FRAr2
 +cQkqgrmTy36Yd+gEpHEtSDpzbe8tlyLLa2Rbbi1YXYoKXh4HWnXXCFFiuc6faPI77or
 Z03PZh/FTVuN5nciNv/txOBd3ZbxmoerOIDdJIoJ57ssCPSLPgqgH6Nfpou1ygmy/KHB
 SW2TNjtPBFIt/zq0ANnPBosuXbt/yuRlFGRCmzodTMWHpqot0SYZrbEPpKMYS09uTKFH
 Y65pg+lmO5dU0w6jTApU1XUl23+AgVmljkesPbD0zn0Yl/u2mX707bB1MdGIpRgs/aDm
 v/Lw==
X-Gm-Message-State: AOJu0YxFevAjpWyxwXOly+E8jmma+OrhClsHNGhYmVBbx2pf09TONLtv
 /vyoyNW2Qogs0Q+K53QeYzawEvIq/tDA+iVHsARf+yOnaY37OVfkWxwL9aTcocHWdMSj8sdfK8G
 kRcFbX4w=
X-Gm-Gg: AZuq6aKSyI9yqkpQRFuMsgkVch3R2L0wV7GlEmq4zn0MPUxw/S5fOtuI2ipXJvmbb7P
 cIKeW21Upx+O+dD6yKuKXLqZyss2EZ7zPqDUG0BeHxnO9fMoQASWLiOVbcq9F4tsn1j8TGYPwjo
 0pK12XaLzluSNwDARUnRuLF8NhZ7OVyfTIct7uLyTv3IOJ3Xjy1LoN1DpUC7tD7F3S7aAtewK4u
 uSrmlSQ3lWY3m6/cazapoX7QlbDHlu2e4MbHQMo9dlqyg0UqYTov2h7GF17VZXfXvkPZ2v/GNtY
 uqx0eilwqDpg9V/voXXBbofvd2fJkeVexjJ40z4D4MgG1p9OoryhoZYVe3SxOVCtgDSzFOvBREt
 4Su4wUmZcukepzffAQyrVhXu3FAvRtJkc9AZ9Dg8jDkZV+cnijo6PH22B6QqTMTxqDhB+uuWaB4
 29K9MJzYzeCnUp6ckt2SJa6dzZDQB4y9dz5FbmpGVgHczYOPEJhuZ5EvkgR39xhg==
X-Received: by 2002:a05:620a:2585:b0:85c:bb2:ad9c with SMTP id
 af79cd13be357-8cb4bff0d67mr2615040685a.53.1771563856394; 
 Thu, 19 Feb 2026 21:04:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 03/10] net/tap: clarify TUN/TAP flag assignment
Date: Thu, 19 Feb 2026 21:02:05 -0800
Message-ID: <20260220050409.1571022-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

Add parentheses in the ternary expression that relied on operator
precedence between '?:' and '|'. No functional change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index aa236cf967..e06e1ca079 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -155,7 +155,8 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	 * to check if a received packet has been truncated.
 	 */
 	ifr.ifr_flags = (pmd->type == ETH_TUNTAP_TYPE_TAP) ?
-		IFF_TAP : IFF_TUN | IFF_POINTOPOINT;
+		IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);
+
 	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
 
 	fd = open(TUN_TAP_DEV_PATH, O_RDWR);
-- 
2.51.0

