Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA9CA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:38:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E976740BA2;
	Fri,  9 Oct 2026 01:37:41 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id C6F4040B8C
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:39 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8875d220446so1898996b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502659;
 x=1792107459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=M/dGZQpeB9bSTpFqQhzRBJq6/hYa8xL+JXCTOhSY6kep2CYMDWpU3PcFZn4zWmrZEJ
 D2Zali2FdwlYd+KvWaFTjAeByRGwlk3tNSIghIRUY1WAsKZ8k8jRNP78AmUcMSvtfsGJ
 3VVXf0SOr/6/brHPZbbO7CuZO6fX/YMrCon+l07j3SXO5lhOTFRbQAjCwXNV0PU0uQI8
 9jZBiccaLBTyOYl9OdcVZZZv+9ttnlA+iM0ciUhP4q9ubes8K9gHpJREY4DfzXJXUsdp
 O3lIgiP7FnES2qzmiHmHoiHH0u/eThmK8867lD6djVTDZDsIGmscGjBzNU6RD66zw2QC
 WJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502659; x=1792107459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=kUJraaieaBUZDt8rspo/dYNq0zKBNjU/2KTDZXbTz0BTr3lbPQeln9fAO2ke7e0pbn
 SOXxSsJ4h+PK2k4Wk/kvxJM05/yz18OLVMk+8HIazOic2gqyWH7BVBWIIiq5Hp85WiY2
 lcAVxqbIYFMTlUQAfqQcwpwGnDcUoO8D3M17sPiw6JCGvOZEt6YhoGD//WSDC11mnVhG
 p2JUj9p24kp48+zZ+RdRl44qes2pFxbKDuar0tLbmbEfj42CEDZxK11CerkSXhitk47X
 GfRB0QQmXJ2b2paN0bqbTs5xgR4bTp3dZ2+gxoep2IQBeMg6rxRzeDr6bVgu/jI0iUfX
 VVdA==
X-Gm-Message-State: AFq9FYIXxH4+nGGbKs6luQ/1WpuNR2MNMEOTucEipDWqPlBwP6Ucyiho
 OUi++xmrQH8WgFLXVBZ7pr/MjuKU5cp4M/Wl00RiTaIsTAAbNU16ZPeZKbbHI4e92J++UtBiSUv
 Lrq09q9c=
X-Gm-Gg: AYBFou2IvsHOcqIPhNCLAg84zOQvgD+mY4hXDhayQYYIeZhkzVYrkZxbYAxGqA50+ze
 zlx+wf7dNwMvbni/XTKiiVuL11d8oWJXybS8e3BmRpxkl0s4JXyfZZ54rIrsDmGaw7XT4MkJTDV
 ibQeU+Ev258PYNYtfIYov0n+kkthTuHAxoYFB2tQajjbJdfyBn7Rlothl/O4IcKuOxahmUD/4Nk
 qunkyE1IGvJ66HDHspP8HtxigfjGy0gPVZqxs3AV6enxZ9GYmG81d/9pqCozoow45gzpsNudvU2
 zO3Blm/uyMe4Unt/ecrQMHvG8ZQaezjxsfxG5rW4DnVzshf9gK9r/KM39Tq2sIOvOrAOLf7Ledm
 EL8Au2ZaBE/ghFiUni9TRcXt9P7tZvXPkbwxy5Eu/ktzmolQPyvwQYqpY6xqLQXyZxSUWTJHZoJ
 66XutDUVDgOLGh1BuTozk33sX+u2589RDmSQdMyx5h59A0NfRAFjenwEsxUdyb7NywyZpbu52H4
 12JVBxGV55I+ka+tZhytYEoWGQBfceURdPBTEA=
X-Received: by 2002:a05:6a00:2283:b0:878:34e7:9a40 with SMTP id
 d2e1a72fcca58-897c78de091mr45165b3a.57.1791502658865; 
 Thu, 08 Oct 2026 16:37:38 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 21/29] common/octeontx: remove redundant barrier in mbox
Date: Thu,  8 Oct 2026 16:35:14 -0700
Message-ID: <20261008233649.1260843-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The SMP write barrier between writing the mailbox header and ringing
the mailbox register is redundant: rte_write64() begins with
rte_io_wmb(), which already orders the header write before the
trigger, and does so against the device rather than only within the
inner shareable domain.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/octeontx/octeontx_mbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/common/octeontx/octeontx_mbox.c b/drivers/common/octeontx/octeontx_mbox.c
index 9e0bbf453f..8b0da3a98e 100644
--- a/drivers/common/octeontx/octeontx_mbox.c
+++ b/drivers/common/octeontx/octeontx_mbox.c
@@ -113,8 +113,10 @@ mbox_send_request(struct mbox *m, struct octeontx_mbox_hdr *hdr,
 
 	/* Write the msg header */
 	rte_write64(new_hdr.u64, ram_mbox_hdr);
-	rte_smp_wmb();
-	/* Notify PF about the new msg - write to MBOX reg generates PF IRQ */
+	/* Notify PF about the new msg - write to MBOX reg generates PF IRQ.
+	 * rte_write64() issues rte_io_wmb() which orders the header write
+	 * before the trigger; no separate barrier is needed.
+	 */
 	rte_write64(0, m->reg);
 }
 
-- 
2.53.0

