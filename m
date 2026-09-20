Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF1DC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8344F40E0A;
	Sun, 20 Sep 2026 20:14:31 +0200 (CEST)
Received: from mail-pj2-f24.google.com (mail-pj2-f24.google.com
 [74.125.227.152])
 by mails.dpdk.org (Postfix) with ESMTP id 2F4DD40ED1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:22 +0200 (CEST)
Received: by mail-pj2-f24.google.com with SMTP id
 d9443c01a7336-2dd77300816so6799435ad.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928061;
 x=1790532861; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b9Yi6lN7wQoSN/Gyv4lYo23zWVZE4Tyl7A3PnPqhYZE=;
 b=AJLHnwVpwLj3JiXUCRUB2kXd1ML9uHoikGuKIuJycI4VaK5cXsA49T5TZbuA+eEXL0
 N173LZqPofoIXlVenQndQt662CvJyavWhg1U2EamK7GoGLDXSTuYqBLQCuFmXBX469DN
 tlZuU5jm1oZB4Vnok4FWg0LFpSY03eZcbLdu/qCeclQdNmTG5GVGrT6pLQ0y6LpR3hE/
 2lel9Ooi+pW3sL0yjWIeN9+oG+ks44EAawR4ly6spGiaaKOgI3bkGxE0aaKIlPAOd7d3
 NGgppvz4ZKpf4robtfvQnFCfdbsUwkdfsCzG/Q5vJ8I6zg23uVUsfUeE0bUajisRgIzJ
 McDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928061; x=1790532861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b9Yi6lN7wQoSN/Gyv4lYo23zWVZE4Tyl7A3PnPqhYZE=;
 b=uM41Pu/IPjad3mDF7L0JOMs/hnkmkgz2afHVZ5m9EttITWGsuKxS/sEzTlfBTgs7lf
 yQjlfaIPra/ZBXNxAUrpPkzLGCtrycVYxoJvGSvk0rVw5yZr4pvG2LPpDBUasohwyXOm
 ykav6F/hVF60sQn6HQ96/cY4xHhm3hvew5cIAZKM2UTKAHpLJrrnt1Vzhq1I160yly3C
 IjobVr8JNVIkI1dth+juA7OR/vcKU90pf9suhfBm0PgEui+kUb+tcjBTXRvO9zC3TGrq
 vojkjKvgebBWVU12R2AqHLv8S7XsLFI85ZlRJQ2crpPzDY0zarDQQhZGcora9HC7jXPH
 ijcw==
X-Gm-Message-State: AFuF++lS020p1QFIJpGesrIZxW3sU8cVmwLuNh9Yy4d2FDXG4FXpbDOy
 QjkD3aNGFR+UENUPnu6vAQOBSYzbPlaWsNjbvfiQEwQJXrjCLV6SS4UIx95+iytlSSnszjVQu3u
 FUEep
X-Gm-Gg: AYBFou0VZp9rHv74lTW28CswlkPcWGysJ44P9hvnnva/NdMEUeY15rdqTv6+05uiem2
 ltkOrE3ybWAx1rj60eoiyZqXmYWWh/pziv9+oI83OO2jN8JpQGebzHdtrfOG60WJSr3QibwJeZI
 0bJWKmmrCVSnXPDsjMX6Hz1onfW8vs4SgOc9NoReonKJtmTa1PeB1X7woaqkDUVEf8ulzc5W36+
 kFsmzi2JtjAmx7NkC7CczpBb4l8Xemxe8GSirqm53kcwZ9UhUA+kyOJN63+wTomL/H0VeODKSDu
 cJXqwJCK9silH3A23+kTIvmXHKr6XQkdl4pArbZDguULyJ0GBrG+IYF3dBncJWx6dK3HsTfe/sW
 AyOWQIXQqIAW/8t2XMay74NZoxbl8EDTQZnksyHV6Cx4c2yQHt/SZwAGhF2fEajkLS8crJwRsxW
 N8zomUVCERyia8r2cL/ZkLzsw+zZKmt47jaARun0VwZY9Wi78rZdxa82kV3ZoCfg96MIaquqhGy
 uZ0SCQ0P2Nqu2O+DDtBMMZ/kszpYgjjTlLPbg==
X-Received: by 2002:a17:90b:2744:b0:39e:2192:f81e with SMTP id
 98e67ed59e1d1-39e554cea27mr8886289a91.7.1789928061353; 
 Sun, 20 Sep 2026 11:14:21 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 27/33] net/netvsc: replace SMP barrier in RNDIS response
Date: Sun, 20 Sep 2026 11:10:19 -0700
Message-ID: <20260920181347.747210-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Publishing the copied response before clearing the pending id is
release ordering. The following cmpset is a full barrier today, but
keep the explicit fence so the ordering survives when cmpset is
converted to a release compare exchange.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_rndis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 7c54eebcef..d1142fa1dd 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -357,7 +357,7 @@ void hn_rndis_receive_response(struct hn_data *hv,
 	memcpy(hv->rndis_resp, data, len);
 
 	/* make sure response copied before update */
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	if (rte_atomic32_cmpset(&hv->rndis_pending, hdr->rid, 0) == 0) {
 		PMD_DRV_LOG(NOTICE,
-- 
2.53.0

