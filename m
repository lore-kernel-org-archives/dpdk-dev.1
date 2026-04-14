Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8844AF9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5567D40696;
	Tue, 14 Apr 2026 18:10:26 +0200 (CEST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id 9121D402EE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:23 +0200 (CEST)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d4be94eeacso6098904a34.2
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183022;
 x=1776787822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=aWymNBZmxVjBVBZCroPLUpl8lDhT2gg1G0ipiltoqc87oWuN3ga+QZJtQESOnhZgPI
 5cWm+0SRtLbfmtOv42XGu+lIE4EnRRLrIzMCVGmw89F5FaDzenqlp1dpYUT4AHpFHjtL
 UI5Q6YGuS3fhz1ol/tKe43xeunEe0rnN4Ra1Sd1ssNXQCIXhHqSL2R/lv1oh3gH5LHQ6
 w2btgkUfMgHcXVNweegReT/sq/Q+EPTvEnDDIOUoVGNNknr6zAtI8opXnptDVOaFiXMm
 7vZTUjbLClVwpkpulgcOxZYbh/dZs9LNO/mnz90x9VDEsYd8jCZb78BTwwD//7YhpXvL
 MogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183022; x=1776787822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=dAIIhkeNB7xOrIoCgl0aUbeMLXNG8GZDIpG1bm/ZjVwAGqoadHRN+5SzjG7IkROyfz
 t0ztYtOB+IMPRd22fsYYzDS9YX+ujPM+N5eC3EqzdEv0QifQ5E9aO7N1fhEKjiuBnu6r
 wH73fdyHIfX1lvg6nQo+wHFhC7TsUNVGewylPpKd1OdItbEjyhPnxOoTtsJzx6O1ylS3
 5u2ulp8o70iYiLgcVZDHb4k75lazbqgzPapK6peKSVp+NCk48lWxAfOxPOjfMcdAB7FW
 3007WK80Z3QgMI0FKOJS88yfjVedL1maISG2H8c3dT9OqKTiBKlcq0UxNQPgjsMwlWOn
 XrAg==
X-Gm-Message-State: AOJu0Yy4ErV+ln/4vKBJTGAxy48ETNiaTtnlM2kaDVeG2v5ybrpo1hJ7
 agmFPpSO1ovgN5uRk0ha1git/60/C41A9aLcHoAbjx8vhpw6HneQoHK/2SXdO3pkEv5kGJiyr5I
 Aqq1m
X-Gm-Gg: AeBDiev07p0d0L564QilrWOhnHJxiqF8Gu3Sc9xfrSKIm41pDv8uL6Zv547zCiOulrO
 +RRIC7FWz4dzkSzJkCNhRmXj3RFAqFe81Hdha0zZ5mohNMyHxwqDB5UaW23wQv7gVnziGTV+r1k
 1/2Peeh7RPlS2aU+OOWBcXAOGLMKpEdlfpv/G6TrnsC+q+9TneMHnC34actTdHDuVw7QZpDrT2z
 MmSgLcElbLsyz86J0cabKRDXvgRPEKDrZN6nzyOscWzEB5mdn04aGyQ3m5OqePYjk60tk/HG64Y
 Lswk+zRz8V0oY2W5Jm1Hwt/UBuIwnwhW6+eFrybXpmym6siP9x0f+2ONzMTd+YZAet6eRbI90sJ
 ZVNSK84X1JOzDDVXinHcdKzabaYCaTfbWVMSnvlJyLMlv59eJ9ImyVUb4os0TCn/subWqgUiq5a
 U8XHfqrTeuIyT98XHNB0eIt5wx7AVe+HVzofw2zX2IzEg=
X-Received: by 2002:a05:6820:2d04:b0:67e:fbc:de68 with SMTP id
 006d021491bc7-68be643588fmr9731523eaf.26.1776183022630; 
 Tue, 14 Apr 2026 09:10:22 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v22 07/24] net/pcap: advertise Tx multi segment
Date: Tue, 14 Apr 2026 09:07:58 -0700
Message-ID: <20260414161011.756101-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

The driver supports multi-segment transmit, but the did not set
the offload flag. Therefore applications would not know about
that capability.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 724b7a9038..ebc96fafe5 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -753,6 +753,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.53.0

