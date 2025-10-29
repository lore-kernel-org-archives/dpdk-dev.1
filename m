Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB09CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:24:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5859940DCF;
	Wed, 29 Oct 2025 17:24:40 +0100 (CET)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id AC8014066C
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:24:30 +0100 (CET)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-3c972dec6easo82711fac.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755070; x=1762359870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZspuy+WwQ1mXVYipXVVhGQRPCydy5QTOQxqmX897tU=;
 b=gNdghDW0FVyVApnC+Qy0HwmsczSCgl9zfw2y82NzEEAi4Eqfgl3W/IVvNPqXl+P0mJ
 TqzKASvYJT/qsiYOjQCjRywS0MNxA4dr03cBOJKeCqrhktlGaAaswlo0f1QPqW4iXdTm
 0ur+UM9cBaoP/5iDClcLMdlkmDhWuuBo7Uxx8x2wt3FxmckfV6hPsA1ehT9YfAF9sFpO
 HIbBtehWgC2Xy/6mhgB8qHWmS+5cmi99PT1Aj7E9v9ubrMVYXXywmt2RUpUBuRvF1B5h
 x7d6yTZXRO+zJLIj8rXQ4AS5toLaMNXqP0eMdlD4JJGWFEhrRmNm5+L0fZgGKslEw5iX
 HEAQ==
X-Gm-Message-State: AOJu0YzHI213LDgB+WTXjyIPoIZwd6Y/BYuD6SAR6cubbtS1wy6AXBjr
 MtGZVisEV+A7Y3CkEN4A2hkHIRb8CpxHsfWr7eK6xduDz8fFpH475QXIlp8jNuFfp3Po/HrVQRj
 oUB3Kr4dB3ckicCchmoT6XHQQdseXt6Pin6/UHb9cshrTnizT83gY5hVXDndzFXDB1eUkVJjq0P
 ufWZNoqWLq2+MAjAHKRzalGsoEjZ/C2zevZmUcfiO+G3ag/dD+7DAYDkn11B5thImaTcAckg==
X-Gm-Gg: ASbGncujLXCNBti/VfmFz+Sshj62vnWzG8F3QX9UaBr8upHo2snvqqfrFb4mXcjG6Bv
 4b2ebsUUAJ1e7DObg0CKJSAGGNemvumzoPgWxK71o70ZY7IqDyORqoFSajOb5fSIvInmZ7wEbbt
 DgD+H+RGWTHKBHR4LQ+R7MH2IkoYy+oyDrcC+UiZ1S/Icq1VynoOisFFLjix/AyCG1Pj3RrAbCg
 AvTkpkXtLN+MTWlRBvHP22d7eEEydfy2Q8qWURAKZRt9xnWKikVH6hL5dKcip7TfYo1wmG80As3
 KIrKf634DHndGmllUkz7INpW09T5OHAXrortyHrCRIOWHgVJUhuxIaFMQwCOI9kLgLkOQDtYj63
 2VlNYQYOE9ivr1ZwnDh0zrVbVzk5BKZIdvFfnHvk5byfmeEEkF3gJQlmO9pMoQCs03BH/63/5uH
 5ctE0UWWpkK/23ctNQBZYH6VtQtTCBsQ3cVy+M
X-Google-Smtp-Source: AGHT+IFmA+ZiUNN4tQCobRUfu5sXlTnbd2LnK4hD9/gEjgyG1aPKUkRFx6hm9BWzj8A/Lu0u4gzKDaJYjEQx
X-Received: by 2002:a05:6870:3b14:b0:33f:dc6b:ba35 with SMTP id
 586e51a60fabf-3d747d4751bmr1708090fac.36.1761755069889; 
 Wed, 29 Oct 2025 09:24:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-654ef28e92fsm281319eaf.5.2025.10.29.09.24.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:24:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4eba90c163cso109396511cf.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755068; x=1762359868; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZspuy+WwQ1mXVYipXVVhGQRPCydy5QTOQxqmX897tU=;
 b=DUwlioH/OJLcyjZhIXcFVoMkL7ryhaO1keajZB7vphuJqU3uT11bvKQCCNkQpQ2+SH
 7N6HxqeUz4h91Hyc9kJ+Kh7t2ha8cRn9Nx6ap+jOPV625soA8gEjIE8/Vmnyaj6VrOZg
 cQkMEi5X6/k9keJEj8JKY8WbJJJ8HCJdpm0c4=
X-Received: by 2002:a05:622a:908:b0:4e8:b979:c7ca with SMTP id
 d75a77b69052e-4ed15b58acamr49641741cf.18.1761755068612; 
 Wed, 29 Oct 2025 09:24:28 -0700 (PDT)
X-Received: by 2002:a05:622a:908:b0:4e8:b979:c7ca with SMTP id
 d75a77b69052e-4ed15b58acamr49641161cf.18.1761755067968; 
 Wed, 29 Oct 2025 09:24:27 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.24.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:24:27 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v5 55/57] net/bnxt/tf_ulp: add feature bit rx miss handling
Date: Wed, 29 Oct 2025 12:07:10 -0400
Message-Id: <20251029160712.58519-56-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

From: Shahaji Bhosle <shahaji.bhosle@broadcom.com>

Added a new feature bit to all applications to send the miss
packets to parent PF.

Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h       | 9 ++++++++-
 drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 84d0315399..bd160e2db9 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1039,11 +1039,16 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 	uint64_t bit = 0;
 #endif
 	*out_bits = 0;
+
 	if ((feat_bits | bit) != feat_bits) {
 		BNXT_DRV_DBG(ERR, "Invalid TF feature bit is set %" PRIu64 "\n",
 			     bit);
 		return -EINVAL;
 	}
+
+	if (!bit)
+		return 0;
+
 	if ((bit & BNXT_ULP_FEATURE_BIT_PARENT_DMAC) &&
 	    (bit & BNXT_ULP_FEATURE_BIT_PORT_DMAC)) {
 		BNXT_DRV_DBG(ERR, "Invalid both Port and Parent Mac set\n");
@@ -1068,8 +1073,10 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Non VFR Feature is enabled");
 	if (bit & BNXT_ULP_FEATURE_BIT_UNICAST_ONLY)
 		BNXT_DRV_DBG(ERR, "Unicast only Feature is enabled");
-
+	if (bit & BNXT_ULP_FEATURE_BIT_RX_MISS_SEND_TO_PF)
+		BNXT_DRV_DBG(ERR, "Rx miss send to parent PF Feature is enabled");
 	*out_bits =  bit;
+
 	return 0;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index 4e9b11e437..6a2d31cf8d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -915,7 +915,9 @@ enum bnxt_ulp_feature_bit {
 	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040,
 	BNXT_ULP_FEATURE_BIT_GLOBAL_TBL_SCOPE = 0x00000080,
 	BNXT_ULP_FEATURE_BIT_NON_VFR_MODE = 0x00000100,
-	BNXT_ULP_FEATURE_BIT_UNICAST_ONLY = 0x00000200
+	BNXT_ULP_FEATURE_BIT_UNICAST_ONLY = 0x00000200,
+	BNXT_ULP_FEATURE_BIT_REDIRECT_ONLY = 0x00000400,
+	BNXT_ULP_FEATURE_BIT_RX_MISS_SEND_TO_PF = 0x00000800
 };
 
 enum bnxt_ulp_flow_dir_bitmask {
-- 
2.39.5 (Apple Git-154)

