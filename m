Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066CDCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:15:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DAD8402AE;
	Fri, 10 Oct 2025 00:15:23 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 1E86E4027A
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:22 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-27d2c35c459so10555405ad.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048121; x=1760652921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pe0x3Whxiu5wBpiNXotThqNfqBYV2gNWYO001+aguvE=;
 b=lM2FOoXWPDiZ26gsTc9GiuqKscgxxHzIAktMKUgLLUC5U6ZAXdHguu16fLYiVnUL8D
 4M0xb7hnUwI1Ee0DIozyI3OUuCBXA/PpQ6Hu5mRKASHs8UClqx3s10RbauZm+l7lwGCm
 Td3LATyNRiWfhgw+0VrXw4PkQmmw1JG5ME4W4ujZdol05QZyBFbTIJoC+DKc2n0eepF5
 Jx2B9t9qjx2tUXZQOHLK/7aS3i45nX6svMtsTwTgCeKMlEJq3BRPM02ZcGl8TcKF94XC
 Nh3UlYjUiPbb2FlNtNa/fAkPmj7ADal6tk/USF1AyDjT0Q2tsBfXLH6etWKOpfk6oWDx
 p1vw==
X-Gm-Message-State: AOJu0YwAbx9vo46N3bCfrpFZ7nChnKZ2xcUfBwPM7jYJ4EKUNIfEAbHL
 prZ8w5SOJ2A2HTWTxuUT1YBBQD+Naf2ZfzEO/9PrrQE8HrIjeZzqP+O2QJMuB/9ka9FLXHro+A4
 XCe0EwXi1LePa+/ovSBXjP9S7T58kUPIAMhcKA1BJ+c+gV6Vz5rJbb1zuUo6yLewr7x5WhRqfVu
 SuPygy2Yct2HqvOXhOpDQ8MaYIi2Ylke0Hhp2OrnCV/NlK6zkmSDD2RNSE0TQMjLY6YYjOtw==
X-Gm-Gg: ASbGncthNxIgfvDw4n/aQBjxsTMg6UsYf1WGZe8+NT35MX0FUee3QhiP0J7DNo0AQyB
 bBG3KH70ICevmgDGn7JzESIdUN+d0y/jGLzn4seV6WXfpnJGe+kkiv0WU8J6XZpnURRH5MCxVdK
 iBgjJg0WkKDrnrrR0zS35BPxQ1Ny2m9FbXNsLH0nSxHleGccuw274TTGykqj3oFs/WB0D1tqchj
 kv7ZE00QZCYoFZrTbZiGSGcpDv0RzBNjvEToEsMSkKJVABKlzp/sn4JuRabJwt0kmdOGYHL9VXz
 0d6bzspZcg0eGpdmpeNH+BiDdLzSufmVSrNcgqcnBh/xO2Oi3g2kYVMHPacImEBUeZO37zvIkiD
 t+rnawTitdhxlVA6phR0jlb1d86T+X4jBcuA/FsYRQ6fHHzKiCipSJIPuVBTjkEjdFWdtQ8nvHR
 VJFW/Bg0A=
X-Google-Smtp-Source: AGHT+IHkxZQiEsT2tmrU2xd8MS5L/uJ+sdWDwt6I//DGk4aZhq1LYLy25RHrCh35LWMbYSs0+cSjvLHbHCgF
X-Received: by 2002:a17:903:1aa3:b0:269:9adf:839 with SMTP id
 d9443c01a7336-290272b3357mr116970935ad.19.1760048120992; 
 Thu, 09 Oct 2025 15:15:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034eee5f0sm3374935ad.34.2025.10.09.15.15.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4de36c623f6so56398581cf.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048119; x=1760652919; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe0x3Whxiu5wBpiNXotThqNfqBYV2gNWYO001+aguvE=;
 b=XGYdnWTmkAcc0en7GLbdRce0LXSmFD7ruPinXoL+aWJXniU4rUvvjUp1fPnRJ7w7tI
 KXRLMpJQ0u/VETvRZNWmZi5qetKQpOp34f7Y7eJEUcZgCZzepNoMiohzE56B5RfPulkI
 FDjYYV2lzxdL2Vb6m+q6JnW8cIrmtn5YMkmco=
X-Received: by 2002:a05:622a:348:b0:4b1:103b:bb6b with SMTP id
 d75a77b69052e-4e6ead63408mr114217641cf.61.1760048119388; 
 Thu, 09 Oct 2025 15:15:19 -0700 (PDT)
X-Received: by 2002:a05:622a:348:b0:4b1:103b:bb6b with SMTP id
 d75a77b69052e-4e6ead63408mr114217171cf.61.1760048118932; 
 Thu, 09 Oct 2025 15:15:18 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:18 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Smitha Pisupati <smitha.pisupati@broadcom.com>,
 manish.kurup@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 12/54] net/bnxt/tf_ulp: add support for special vxlan
Date: Thu,  9 Oct 2025 18:10:47 -0400
Message-Id: <20251009221129.28256-13-manish.kurup@broadcom.com>
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

From: Smitha Pisupati <smitha.pisupati@broadcom.com>

Some special vxlan packets have extra padding bytes between
the vxlan header and inner eth header. Thor2 is required to
forward those packets as is, and not drop them.

To make this possible, following changes were made:
1. Don't check on the l2 header type in the default template
2. Based on a feature bit called special_vxlan, enable the support
to pass the special packets. With feature bits disabled, normal vxlan
should still pass.

Signed-off-by: Smitha Pisupati <smitha.pisupati at broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index c8b6f544ca..08934eac3f 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1069,7 +1069,6 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 #else
 	uint64_t bit = 0;
 #endif
-
 	*out_bits = 0;
 	if ((feat_bits | bit) != feat_bits) {
 		BNXT_DRV_DBG(ERR, "Invalid TF feature bit is set %" PRIu64 "\n",
@@ -1090,6 +1089,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Multi Tunnel Flow Feature is enabled\n");
 	if (bit & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)
 		BNXT_DRV_DBG(ERR, "Multi Instance Feature is enabled\n");
+	if (bit & BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN)
+		BNXT_DRV_DBG(ERR, "Special VXLAN Feature is enabled\n");
+
 
 	*out_bits =  bit;
 	return 0;
-- 
2.39.5 (Apple Git-154)

