Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2C3CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DA1B40E44;
	Tue, 21 Oct 2025 20:57:52 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 16A6840E44
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:51 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2907948c1d2so64339415ad.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073070; x=1761677870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=wlaUsZhbY3Cm2eD+Rzp2x0B7ws3vqdd22IBmy7WzVt3SwPnk2A2aCTDoy7IbEHCNGC
 QDoCGtnacSG2aJRHtLECRYHmOroKbWLHzr114zh0KCaGWXrlk/xAUJEr2Eg3Ur0bx6zR
 gEL0sh3oLaRbLPZ/iEgpEnTffCLwxCGnUcgU4mJkIspwHJVg3nuGdKOQRhsU7KGPlf3U
 CC0242CliXbDQMy4msCdvC2G1bg8BdTXzIgo3vQ41wuLp1G0RG/nP1tRr0OSWlwyjzHn
 izZXTAx4PYXTlhHvWbFZSedTsNYtjEkMCxIhtP06fnntdp3z+L2mh3NlMRa8YyqAGPjt
 93UQ==
X-Gm-Message-State: AOJu0Ywp27nLP18xQrfiOqwZHTSKMmkTnTVZTycXFeARfEp27zOGUAUT
 ipHlQe/aWQupUpd5vJO9w0GgrDWDt/grGExthQYF94PF4svdCh6ZDsfzwyFcDysRwseBgFjbGJk
 LqRG1179uTdFstYNuA1S8k4BUxtpN4FfJI9OmBoXM8TgrlA4j7aY/ddXb5XsQUXnfUJ/AvULqRZ
 PnnNznk1JJmp7+U95NOMw6FUBjlRlp2ZmoBEI5ZUTVcXI3AoCyW9//4GqBUyYYg8zLm/rhXA==
X-Gm-Gg: ASbGncu6ZuS4vGuJoSj4T6ptjdxDcaDjI/n2z4YSk+JmSYNu03z8vYVWVRbwhd+IwB6
 Bp3rO4HCld6InqrHSA9naY1+/2Cjq/s5aQyYOqLK9j0pL6HWcRmtQrHD0Rw4Ti0g0Ef5WQSQLCb
 K/rCuqljhDXsPc82rt+63t02MwuSgPf9dt6LSr0zv9tHbmw3ETPjGLmyLuNXBQH9+5OVYi6fmGT
 OLPTRTIeL1M87JtjFcpr5VQCuvEDTOPQC+XHZ+BkqFbMhqdfQemkjpIbFmUAtwedS3YiO7R2+qb
 Gls6mry9cKCIdZU5QzHnbkOiKpW0Spv3HyVpb6p/9Qo716sbVSqGyRhFSzDQwWJQE26nc4qezr6
 wStFXfRs4leiWFDeFhqpA51DhCF+s9PF7E4+EPv4oPrh8WLTNAfMlzVC7MAa0lHbziw6gpcCb37
 lut9V27CnY41qOCUJCQUpDtGUMqLdC618bWg==
X-Google-Smtp-Source: AGHT+IGHBTli/IIIH6FcZ0WIYGJkzEWeb0G1WnbDbv/QZAulhzXW+2/dg5hIOs5hSVfeu0dkfnP6TuHoaAWy
X-Received: by 2002:a17:903:298b:b0:282:ee0e:5991 with SMTP id
 d9443c01a7336-290caf831f8mr232871855ad.30.1761073069739; 
 Tue, 21 Oct 2025 11:57:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29246feeae8sm13872245ad.3.2025.10.21.11.57.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-272b7bdf41fso72015585ad.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073068; x=1761677868; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=WA+XXt1zgorIsSxVmMo1fYWjg0CGxzJIzyydyQUu6eLBKPGyYY0TJdZ02lphPiGV71
 wVSpc3vW+rsZwCUYyR4rYbT2HQpqh/gYC/XW8++qALVHucnyrf4UybhwUxr03ieK2NRS
 lk4sep7jVg8RyZfnF/c8EDqPwia8Gnb03E6ow=
X-Received: by 2002:a17:903:98b:b0:27e:ef27:1e47 with SMTP id
 d9443c01a7336-290caf84612mr225849525ad.31.1761073067847; 
 Tue, 21 Oct 2025 11:57:47 -0700 (PDT)
X-Received: by 2002:a17:903:98b:b0:27e:ef27:1e47 with SMTP id
 d9443c01a7336-290caf84612mr225849275ad.31.1761073067401; 
 Tue, 21 Oct 2025 11:57:47 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:47 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Ning Wang <ning-nw.wang@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v4 39/57] net/bnxt: avoid iova range check when external
 memory is used
Date: Tue, 21 Oct 2025 14:56:43 -0400
Message-Id: <20251021185701.71881-8-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

The function checks if the iova is in the valid range. But this check
is not relevant to external memory; avoid it when external memory is
in use.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Ning Wang <ning-nw.wang@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index f88e214790..27758898b0 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -221,8 +221,9 @@ static int bnxt_invalid_mbuf(struct rte_mbuf *mbuf)
 	if (unlikely(rte_mbuf_check(mbuf, 1, &reason)))
 		return -EINVAL;
 
-	if (unlikely(mbuf->buf_iova < mbuf_size ||
-		     (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size)))
+	if (unlikely(!(mbuf->ol_flags & RTE_MBUF_F_EXTERNAL) &&
+		     (mbuf->buf_iova < mbuf_size ||
+		      (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size))))
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5 (Apple Git-154)

