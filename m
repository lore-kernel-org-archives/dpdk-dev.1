Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D993C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A24A40E2C;
	Wed, 29 Jul 2026 19:57:55 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 03D2C40A72
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:47 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso12947925ad.3
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347866;
 x=1785952666; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b9Yi6lN7wQoSN/Gyv4lYo23zWVZE4Tyl7A3PnPqhYZE=;
 b=nnaIfQ8XRpC65UNQdqtBwLdc9powzYhrZh/zqtOT1msSEiGCgJ5r7dkRXKl164+PX2
 lxw6obCTAq3j2j1zda2+isGPzFkswtFvgITnYY9kKDDNdDqg2HQfJq53DxleQbp+o3DA
 +hcGnqCRfOcXicF930LmHcsCPqik/XndBKxgCDIc8/+KqXoqxrdFMD05S21bH8MF4Tgs
 PmrkAeaztDLKnPJF5St9TLihPkpmppFQgqt0xBolFyK0FnzORpH9ih60DiEJg6Nx+OSL
 uQAY8xfejwymLBOcw78+65NlPvtPQCcpXcFs4olC0OVMoeIvBdFThnC/SRLB9N+KLPRP
 /igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347866; x=1785952666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b9Yi6lN7wQoSN/Gyv4lYo23zWVZE4Tyl7A3PnPqhYZE=;
 b=TpRHoRRzPzwq4HiiRTPXVVnzaC6leDfEF+vOPPomVEDsrduVavgehjh6dTr67phC6D
 RJBz9m2VADv7cEc7LkI9YTDsUHdDk36r4mGH4uKIA7GeblJvgWA7BGZvy+7eHR0sb95w
 3W0g1TzYbT1iQ5wv1op+z1Uv0yY8+kF1VXB8U1gNN0sNLD/FYis92hRuGw3uxZLZrOtV
 mqiLxG6yPYI9xO6qKAxTx0iUgzjF24AzpDotN43msgaULe4Y2uWTGZpHKaQyXNmBBBPF
 v1h/aLxYxtXVcSUvpIqFcEJC9tOCg+C7VrD92Xhdzv28l7aGOILpbCAEgFGA0S941hQv
 8h2Q==
X-Gm-Message-State: AOJu0Yy2MNjihKCnGLM0OCQsXmTXp3KL8BAxh2QnQUkTnnm1HTeXysZj
 7g1dZ0wpnF+jwptrmlCdleLj+xF/yYlkN6Cg6T/dRHzI7gzj4m+43A7mXAoUfPK/bUEm5jxC5EC
 GCz63
X-Gm-Gg: AR+sD12leu6qjryxf4+UiBB+2Xmv5nFt0gsQLEeMTQmUTwsHqDnpcgsmTP6tZYtGH4A
 k6pf5iLmGqL6LPsToswHBYYSrRvdCZYq0A/EXukZ6YalCRIGPJx3k6aDp47WYnePcPXoIVwFh3o
 wjT2mkz2WXKFQFTCOpNMjSYL7UquuGx2kiefl9/6r+Pb8lVAI4WywFSfr1ntHqYy1/bEa2y6Ujf
 D7DpHwyZfFdyW7qc7gx6XTKGGDP/o7Z4cjLcz+eYp7nIjgNlyze5anspjbGm9wZpUiTUxaRt0cA
 RMdsUnS/W5JdlAm9xaL55k1GbLqtJlSzlXF8qxpgWS2TKacZHVtKYOpHYwpwbVK/Gblqmj+YUM5
 sUKDxrLUHegUCbq670C/CRHHrCvDDkxx5q/prS6jBSWAQ/hVYv2IdM4qHfSRSh4bql3htwG4EBc
 lzzPdKEqdWs+RS3dMWai4F0fXXAzTHQeY+IWkCeS0u8BwZ9EksPjuvzQxABR73jmvK+mhxWKdr5
 gD5RR83vuqjxBZ5H/tBI6AKrmk=
X-Received: by 2002:a05:6a21:7706:b0:3bf:7498:9cd1 with SMTP id
 adf61e73a8af0-3c8ba5d8aecmr9399378637.45.1785347866159; 
 Wed, 29 Jul 2026 10:57:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [RFC 26/32] net/netvsc: replace SMP barrier in RNDIS response
Date: Wed, 29 Jul 2026 10:54:19 -0700
Message-ID: <20260729175715.165120-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

