Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A21CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C832940E3E;
	Fri, 10 Oct 2025 00:16:28 +0200 (CEST)
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com
 [209.85.217.99]) by mails.dpdk.org (Postfix) with ESMTP id 5057340E20
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:27 +0200 (CEST)
Received: by mail-vs1-f99.google.com with SMTP id
 ada2fe7eead31-5c7fda918feso1703519137.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048186; x=1760652986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=myQy32WAZeecXW1tb/sWK3cNW/dXbCokC3sUlURed/UU4k1ITgS1SZ0WU/d2LW/5l4
 1klqYGKLENsTIz9HQbDWMJtdnxYAi+QMiUaY5Nie79ZCdzlyslfH+BrALip/VWPPncBw
 mJ6khX0s5bJ6ICWvB00hOf3TjYlPB7I3IFczsCAxVFMZMBgo53Cxndq3uHgul3aL7ycZ
 ebpsuaqyusFXteF9sDTvcuPccyvTr1XvbssQjEPEm9BQf1mj0bGdFghM944KNPylkPmt
 RkEUy6vq1r0mZH7YAgyO5cqkWLs7w8DcOazkBRCRAMwjyQ/ddDLrrepLrkuWpzalQSkg
 YBXQ==
X-Gm-Message-State: AOJu0YzN09Df0+KfAwpRu35BZb0Ip5SWgAr4vPxEAzs162Kvm6J6YImP
 EYp+losuQbnn7rMkp0TD7fxlukyRK14o1JYOD03lVJi+m0C4hhlaNyO0B2wGhxc9IyiQFZY8yVP
 xKu3tnhf+uj9T5yvwBtjQ3lyaybi5TOseTvNc2MNZyZeHDD2EBDQ252WM50eJr8eg3ATzAhfsTC
 yUa1pa4GOsMEkrlFSAwtvvxx/HO6Ye28BGGeQVMt7xQgmQEG8hLykusBYmoI0JhvYKiNU+tw==
X-Gm-Gg: ASbGncsJZ1EuRTV6oc9Mtn6HXvBNfFtDiq8QCJcLkW3OXinSoyfHK1jGq8SzndRDdvt
 H2aYrA0dfgZd4s/RTqUyEWT/ghNcyCcGYJKmr5e1aZgmnp1q/Va5x3CTFoiYOLNk3Lv7pIkLXk+
 4jUBrh7tlEwISR2TMY2cT+UQDiIXwkUoi85dLD97JvldZhEjoIqArJRFANj8ppwW+fycEuf4TjV
 AORV2LWAdFHPBv54NvvnYWx3vIDnSdKDbJmqSoS7XjwYJ8PAXkB9blHCGVCgJKM6D4hge6tYpk/
 9BxOHLx/5H/FtLFj9dQPJBuPMouqFRefB2g/OpnQQ3HO4uVuMbhUhoBonA5fBib+J7Mdz/DS8Q0
 36iPh2f32m6rvmz4ZqVMfdjnXXqI3i0oUSpgpQmJvH9ufEuD+JLt9W+54uD3lz2WHcYgL7ffEKp
 5qVo2uKdU=
X-Google-Smtp-Source: AGHT+IHhkal0l/RR0kMB8fsjttMRuJRAKzbSYXqb1NJ70bDxP6tstSb5IWC9tMGf/Z6wQKdJ4Nezsu23WUcQ
X-Received: by 2002:a05:6102:5488:b0:5d5:f6ae:38f0 with SMTP id
 ada2fe7eead31-5d5f6ae3d4amr1541964137.39.1760048186663; 
 Thu, 09 Oct 2025 15:16:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-930bf794a67sm13573241.7.2025.10.09.15.16.25
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-883feb13e83so601310985a.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048185; x=1760652985; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=JBhlSEIFqJmXpHjWnkutg9B9HhmiXNWkqUb1MXF9QJ2W6W2SLW/cjhuJUhfjEJ0HBz
 d+J3mkKvqaHk8U3sybTvqENSlD2rt5JEtcGD0Vd1wNxPUQYZlzlvHgGZWTNlMHJAh7sb
 TDyF4A9WhYRne6OUmDWKZmR2YoXO6Vms1PO1s=
X-Received: by 2002:a05:6214:acf:b0:780:dff3:27ae with SMTP id
 6a1803df08f44-87b2103c554mr139402706d6.7.1760048184888; 
 Thu, 09 Oct 2025 15:16:24 -0700 (PDT)
X-Received: by 2002:a05:6214:acf:b0:780:dff3:27ae with SMTP id
 6a1803df08f44-87b2103c554mr139402306d6.7.1760048184365; 
 Thu, 09 Oct 2025 15:16:24 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:24 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v2 40/54] net/bnxt: fix stats collection when rx queue is not
 set
Date: Thu,  9 Oct 2025 18:11:15 -0400
Message-Id: <20251009221129.28256-41-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

When rx queue is not started and the stats context id is not
allocated then skip the stats collection.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 9d7cdf925d..697f9ad9fe 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -656,6 +656,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (!rxq->rx_started)
 			continue;
 
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
+
 		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
 					      &ring_stats, true);
 		if (unlikely(rc))
@@ -717,6 +720,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 
 		if (!rxq->rx_started)
 			continue;
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
 
 		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
 					  &ring_stats, true);
-- 
2.39.5 (Apple Git-154)

