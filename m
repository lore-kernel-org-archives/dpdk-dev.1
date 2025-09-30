Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C4CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6FAC410F6;
	Tue, 30 Sep 2025 09:06:27 +0200 (CEST)
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com
 [209.85.166.227])
 by mails.dpdk.org (Postfix) with ESMTP id 55A35402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:46 +0200 (CEST)
Received: by mail-il1-f227.google.com with SMTP id
 e9e14a558f8ab-42791510fe3so16236115ab.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192665; x=1759797465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=WB5Xl6G9ftdo709NVwo94/9p9XkgoIpSae9wecjIhateqD+IqA9S6PyFwRRUK58Sh5
 yhTNljgnUaLRX7Bw5pYIHSyFUDERLuTRvM6EZ9Pw+yez/MJ5FPaNOif/Dw0lI6XB7MjG
 PcvebeR+FNw2Z7bqWS2+YJZ6RxGjFpPhCNiKytDDdAFrh9B+1muw51sZsctblf/TR0gG
 mgSE0gGl7tJMsacmu9X5ixDS07Zb3DLqOR5WOgg82QgmHQVGq71VawXSr6K86SKdL5JC
 qwmIPoW/VQNRaifegGKozbTaZhK9+NJyeEpHG2MvEfI8t+ZIC1FnKAX7UiImN8bYM1z4
 kUDA==
X-Gm-Message-State: AOJu0YwE6cASBuhzWfhyb3pk5WYKGPxceJLUo0pTmI9Soky6CpkKg/Gw
 f9M0pyrMtcYKTup2gGfEGdtUrEgzu4UnEAkHvzA+UDRktLlky65erRfmiXZ24WPKvdFHd3y5XmG
 MXlC5Mit20Ynq6N+o0zk8aNHCTIKhJpOFEFhrYBZ4arSkTeZuDlcowOQUW687okKvtOYC9v8Ypy
 yzIzJQlzRmUsCbOfnQv+wPzKgNIHamo7W5+XiPFrd3x1MKlFVv2XeuOlsRtGnvKNWKwO5EsQ==
X-Gm-Gg: ASbGnctkkEAqKjSqCcNd/uhxF6hKrQeOtptSejdfJ7+8AXQ5sxL7AlOy6JD255ILqeg
 Nn3HFe2Ven96IM6D9zVzIWtfUX0B+Io/alY5aXyNKbyrgBNivx/fcboG6O7RlnKH6stBhKQ6GXH
 XJgo7NeTLFX0dabzrN2jKpH9rWBOq99YPfDaFA5KsvLSbsW734Bvx8kBCKff42UNSOIV/RkLjbC
 7vT1o8thD99ZPrS9DHuEmBAjtN38Jq4YuEvAnt1vbdCb7smUksIeWeECyczolOwFXgZFXrfApIb
 8RTiR9bK5BxIRCTtspaEQOw26ucTfh07jV8HeFp+Jhfk75mzZTdlqWknyoc5tmFNw0Njbo12yuE
 wehorygGsnn8lTEFih3VZXbAMdmKkk9kZoSykbI0ABnH4w/lfhuDIqOfDhKiwxQm6uCb3p1oPxb
 AKTA==
X-Google-Smtp-Source: AGHT+IE7F/0WzQ8GR3YRBbuvWVwLh+yaO2IXfl9TkYlvJhrRyItXneo7TjKh3OlRFdBAStLq/flmo6tnspu8
X-Received: by 2002:a05:6e02:219b:b0:425:849c:52fa with SMTP id
 e9e14a558f8ab-42d1113ba2bmr34613045ab.15.1759192665562; 
 Mon, 29 Sep 2025 17:37:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-5720ce3fa2fsm359564173.36.2025.09.29.17.37.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-286a252bfc2so20174735ad.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192664; x=1759797464; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvS+FBXH1FRh3vHO7G2s15zuIFAFRxuCaMiRd4HPuA4=;
 b=cWHhAD/1zVy5SUGON3c1+P3YQkhupX3w1LSbX/ooNRgfQkquWkGs9C/eusbhJ2ZugW
 zSclTUWFl2w+hGOGoGtgiYaKfgV6Q+B2ywt9lO8aEk4XqyhVmNRfhwuOmCCv5tZZ1K1S
 q4fpcfcwFvbwt5geD1f/QV5PV/GCnX+ZesmDM=
X-Received: by 2002:a17:903:37c3:b0:274:506d:7fcc with SMTP id
 d9443c01a7336-28d16d654cbmr28533185ad.6.1759192663757; 
 Mon, 29 Sep 2025 17:37:43 -0700 (PDT)
X-Received: by 2002:a17:903:37c3:b0:274:506d:7fcc with SMTP id
 d9443c01a7336-28d16d654cbmr28532875ad.6.1759192663169; 
 Mon, 29 Sep 2025 17:37:43 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:42 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 49/54] net/bnxt/tf_core: remove excessive debug logging
Date: Mon, 29 Sep 2025 20:35:59 -0400
Message-Id: <20250930003604.87108-50-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change removes a debug message of questionable usefulness
that can spam the terminal if more than 5K flows are created.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 47870747e1..3fe4dbe3fe 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -1012,13 +1012,7 @@ int tfc_mpc_batch_end(struct tfc *tfcp,
 
 			count--;
 
-			if (j != start_index) {
-				PMD_DRV_LOG_LINE(INFO,
-						 "%s: OOO comp. Opq Exp:%d Got:%d j:%d",
-						 __func__,
-						 batch_info->comp_info[j].opaque,
-						 opaque, j);
-			} else {
+			if (j == start_index) {
 				start_index++;
 
 				while (count &&
-- 
2.39.5 (Apple Git-154)

