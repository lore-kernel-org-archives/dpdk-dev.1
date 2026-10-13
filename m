Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2654BCC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E7F340E13;
	Wed, 14 Oct 2026 00:35:21 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id E0B4940BA5
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:18 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e61ac64ec3so30081365ad.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930918;
 x=1792535718; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=wnG5jENK5319wwFcj0qSw6QCse8fGxrQUaJPzCb/j7TDGmAvakmcxJbk5wa4ekdiud
 zaBvAV5Qf8EIo/0jvyLvLSlXHTeN/2zM/RGzjF/0WZn6y4fpOzDJCWmkVWUQ5ryQwONs
 6Lt1oVXTI2iVsb1V8xAX8K92VSiieeaLJin4MxUh1oIYXhss8dRNQ+b2dg9vwRh5Ln9c
 2NdxQBi8GeSWo3ENv5WCfu5sdt/JJX6tGWY0+vjlIs/8/0o8CDYViQ+n5atPNzH8waUH
 Uu5eKIDdcdXiwANpxLsRT4VwENTVpzVgMJOw1o1BRNurCnM3UhA25aGPYMRODBcgBp72
 EWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930918; x=1792535718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R0loivXVo8l9F0YQCf77CZoaGjbXU6pgC2D2lRoUWwI=;
 b=jfqN92/mDOK8Za67Ls8rvvC6rumEUsn0vHnkIs4fptz8FyRfL9Ci6SfUbTpvHsLeuv
 jVhqb7G9kDthWWn/rCvjvEUDed2e07/IJOx56lerCqC6DBHGuUHsLqm/54COf/s2GiWy
 UqbZ2w2vslWScqbrDD0vSAjYQhpP+TE+VDyjO5IIAnvvj77PqWgo6fJZTgPKwi81iV1Q
 +k3EC2/NOhCDdcoNdNnn6QnXFJ5cvt/Yx5qrZofbQxL2LxZYsuQZGoLZdDX4nM97gdDU
 1hserKVi3S7am/YRorb+UGqLLV8s0ZiT6i90ubA6sVZd7PTy30QgNt3xMhweXxCpnaD2
 J1Bg==
X-Gm-Message-State: AFq9FYIGdzF5HnafO6G7Fsx/EuiCGR1iyBc3taINM4p7/vpn8uOdv+G1
 cPxR4JBr87F+UQXgI2twKjs2WYSkQWFs0F3s4j/eMeCevj2RFoEQ/2XxUAaZNJucSSIKazA2o1p
 9yFUF8rw=
X-Gm-Gg: AYBFou0CzUwwVPpOe1ljBIvNsdfA2nfvUwbbrTzueOIaWrfv2cZSwMx5vNSSc2p9oUm
 EC01sb3fn4G+Byszrf9MCrXckvH8tjRGI7fKTGpDw6my1rTfyh/TYOQTDOl16CF99nCgGYCu1OK
 fXdiT7rIHQToRE6MHCdM72xshdTiwxSbPRGWDkNFHoCs5mqEeMS+aapQEpikIbQhgi6q/kGABLS
 ooapQJhofL0VhtMfcf+3Bnx1xhEuHAbsYBdyhnLhEaHJZEiI0rgDZ7sHDJAH4SHxnkU381oPGiH
 4IFQA0B6Jj9Slfa3C1XJ3g3KWSmMd5+9LUUIPbg4mXPl6MBjfBSgExSYQz60T/6go8eWg/bSoN2
 89y2GdjskPMuc7+/+IMxWbu92715O9JQQm7t0cLp88CfgRlBl8/gqqLWU/B8HsbZMWfMIWQcJAS
 awEvManO8cWA0cjteEYHFi/Ahpn1C35P26XiWuKfpEixrxaD+lfX4Jhn8jBr1MWO+IbyRt2w1/i
 gS1MOumatpVvfOoA49IPUYXDk9tz6xh98h1nQ==
X-Received: by 2002:a17:903:2b0f:b0:2d7:f0:896b with SMTP id
 d9443c01a7336-2e842aa5bbemr119304595ad.13.1791930918056; 
 Tue, 13 Oct 2026 15:35:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 21/29] common/octeontx: remove redundant barrier in mbox
Date: Tue, 13 Oct 2026 15:22:34 -0700
Message-ID: <20261013222410.2257622-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

