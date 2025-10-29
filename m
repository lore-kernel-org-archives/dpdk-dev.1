Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC37CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:09:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E98E6406B6;
	Wed, 29 Oct 2025 17:08:53 +0100 (CET)
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com
 [209.85.210.225])
 by mails.dpdk.org (Postfix) with ESMTP id DB2CA40669
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:49 +0100 (CET)
Received: by mail-pf1-f225.google.com with SMTP id
 d2e1a72fcca58-7a435a3fc57so94001b3a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754129; x=1762358929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GzekxNyUcsEw9z0bweNDDxSTCPYFlqWpXwNtzxb1rtQ=;
 b=TC7/mN+aY5z+KUIOfoAhu4i0hWpxZZQak8ongBrmrLCNp9t51FOPv60X6hSllHQUq+
 9BvodqzZYC0LyRr7G72c97TsXX33OKkQVEMKWvU1UlPQNY62Zn6boy6nCxeiBeZeoU7K
 j8LQZChUAOvL6ZIVh5hUziaQTscQVjAszYMq7iVHP6rmFwldiUdRL+3Zl97r7fLmXDVG
 FcMYoWdz+8RppNMKju30SsVUAjHO04LoVor0zAYtmVfQSy6MssbBEm16wzf0fptDPQoY
 7VHN0MevWi7u9flRlBJcCfaQ3x6yNifpP2na0gv+nmh9RZKBkWc8NCkTci5oLpXAI1X9
 xVbQ==
X-Gm-Message-State: AOJu0YzAiigawT4j0tvC40l90FIVrzMKUJJuKzKQpC1eTZST9UkRqnSh
 UMz13ftEUHjyUhLJzWEyM3bBZ3k+nW21Yh4FGousBP4xEkEKjSwoYHT0JPEo0tne+vLQ0GypbRq
 9/oquC1CO1KXYzd0JGQG5mmyFsPLDMflRb3ypzlcXjfn7Kn7TWi89glUN8tm5VQY/SFm23LqNcz
 4wb0tlmmyJNM8uEqdaC/QfoMOPCjna4LtMPoZCCj1z7x8pcpV+C7w6MhUs2CaR6rifSF4Hzw==
X-Gm-Gg: ASbGncvRkqpQBRGdqdiP21GRy7h36DgP7m4JUK3gAvs0ueX9Ex/vmb8Iw97YRlAve2n
 V6z97iYrD1LeqJNBkMRjOoh5Sz/1QkBk0aMuBwS7S7ImeOSS8oIAorQmTl+eLEYlYrWzv9YONkq
 +CD/diz904hNnWNqJ6SYJsgITp6ydvaEtHEuhORsvGgEBWa8EZZd6cZBRfkqRXvhtTchFN9+SD4
 ykQ4KtnJjaWUTAykuQGIlUugLrJS6MF93vX2dz3tCLpCn/G++2KA4ZHPP/hdtdmaTAAQn2WpJ0Z
 u7o6wjF91QOdUh4ar8+j7FieuteV2d5O0rg4tFVRz3JqYqS21Es2KmFaOzY/4vcf2mZtcGsKoM+
 3exwnz3OPfZmhoTuQw112e8VmUndvnrdcRYDzDiNq6Zy93vuZ1jhzq05gox6fdmUm3znKTX8Qhu
 ArnLr3wezJyoKqTA+RrP5+1piGaJgWIevwI7PB
X-Google-Smtp-Source: AGHT+IHLDoeJoaqHEI1QVQBdBLKqpgBScpllpXznoKblwifB8iI/wNSnTDJh/fTno/BlqL+GU8CNtuEndKl7
X-Received: by 2002:a05:6a20:7291:b0:2b7:e136:1f30 with SMTP id
 adf61e73a8af0-34653e275f5mr4133644637.55.1761754128750; 
 Wed, 29 Oct 2025 09:08:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-b712791546bsm1108750a12.2.2025.10.29.09.08.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8a873657698so458687285a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754127; x=1762358927; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzekxNyUcsEw9z0bweNDDxSTCPYFlqWpXwNtzxb1rtQ=;
 b=Yw3KqbmMaWajCvz2NQ6rNs5yh1AhJV4v3sXLDr++/8+azKGxTFYmGJfch38z32WEd4
 PbM288dayRIGf6xqneQJvf6i5zquk1ElexxHDMoT6LXrUnxQ+slqPSr/hAAQqA6H/YFY
 x2jZKf8ZLEMFl79IVDIPBJezLBcejOLbtlFCw=
X-Received: by 2002:a05:620a:4724:b0:7fd:50bd:193b with SMTP id
 af79cd13be357-8a8e34d4588mr463825285a.14.1761754127138; 
 Wed, 29 Oct 2025 09:08:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4724:b0:7fd:50bd:193b with SMTP id
 af79cd13be357-8a8e34d4588mr463818285a.14.1761754126484; 
 Wed, 29 Oct 2025 09:08:46 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:45 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Smitha Pisupati <smitha.pisupati@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 15/57] net/bnxt/tf_ulp: add support for special vxlan
Date: Wed, 29 Oct 2025 12:06:30 -0400
Message-Id: <20251029160712.58519-16-manish.kurup@broadcom.com>
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

From: Smitha Pisupati <smitha.pisupati@broadcom.com>

Some special vxlan packets have extra padding bytes between
the vxlan header and inner eth header. Thor2 is required to
forward those packets as is, and not drop them.

To make this possible, following changes were made:
1. Don't check on the l2 header type in the default template
2. Based on a feature bit called special_vxlan, enable the support
to pass the special packets. With feature bits disabled, normal vxlan
should still pass.

Signed-off-by: Smitha Pisupati <smitha.pisupati@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 28938070ac..40e7aaa170 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1038,7 +1038,6 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 #else
 	uint64_t bit = 0;
 #endif
-
 	*out_bits = 0;
 	if ((feat_bits | bit) != feat_bits) {
 		BNXT_DRV_DBG(ERR, "Invalid TF feature bit is set %" PRIu64 "\n",
@@ -1059,6 +1058,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
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

