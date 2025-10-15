Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F980CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:03:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2CAC40696;
	Wed, 15 Oct 2025 11:03:47 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id D6A4C40276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:03:46 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-938de0df471so574882239f.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519026; x=1761123826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pe0x3Whxiu5wBpiNXotThqNfqBYV2gNWYO001+aguvE=;
 b=AvRUyjGt/pnd7Nfa5oUo6zOrtfzQe9w282e5SMjUfH7UqbxLoPsGF0iDpzhz8HcF0P
 CHFt411E7mCoIbWkYBpKrAyH53kKGBKXKiiL3JfNmoo5Ec7KnjhIPgM5xDMQ+XESmXMe
 TMs7UPWIz6sOcK7PMFQB9w9mTQwUiqyZeFgsfxqDmy+z/L+e896b5ur3X4/fIXlYXFBU
 3pMbipPD1HRdv3nN+6HA1jt2gKGioVnBK6xRwZ7dLzY5IF/9Ss3fnpf2W82FBoNtjTFo
 84NAj849QnsQg6mr2uMHG7YzhNFxRL9YPLpqYm1XusxHvlVzmMW5QIix5TKUCbVI6UnM
 cnAA==
X-Gm-Message-State: AOJu0YxnUwVAYeHrt8rmzY9qw6XFiI+aKyqBg0sWLYqf92GpY7rWhJzu
 vWPMO7WJi0a8laO9/njSHHbbZIcNlWfPoUzOSE+iHO/pP19Fn7x4PALms/21XouphzYgc1+VBLe
 BGh1gW06pkxGb+cReHahXlfvvrz066l6EJJqCLOjunB9AEht1zqs8+94by1qrRaasbq2/A8kwZ1
 Q+9S4Ubtlvr6DhT4vIlW3cyBbABQD+8KkwrH7d4R/soUzQrzLbiFXb7PTrZbMVbb7SHGhvnA==
X-Gm-Gg: ASbGncvRc7ojcNp1GNV8sF+inzr68AibLEyeMjux4HhEGiNjl3GwLZqRaKEx/GXNVJ6
 Z1SFhlg1ZX4HbAUh1EB4kKBAPGP+bpwp8oTqEjE9YsA/WvuFljt5sv+bfxOUlem60kLdVP7aUG3
 lMPfAM1UBj+ZCrTnvI5lh1fczjJpeaypaB9erFDrTn9DsCPssQ5RF1uIaEb6k90Ix/GHAihfkvo
 34GigsPVYQhEH9Yg+RDtLz959Pw2cu1oZX6nYi3Kzjb0GdzajMA/KvtNjaUtvNOMbzpFiskkqcx
 s4e25tNu2eZ3rDY/XCmLpgAg6SO9dIFZqGtu6lo1b6IcKNpff4O/0hl9UlnqsImyI70mEINFtwH
 Z6h9d7GnJFeappss5jhgEWrOmXX0AqVujpmMgWRhWZpgb87SW+8FbQ2EoseOrU0ewe7Xe+KXv8Q
 9UaA==
X-Google-Smtp-Source: AGHT+IECmLTlbp6IftMkg38q8Bwp29WE8sulb3jj/+MYjBg23gufJFKfhuKsCcknKuU8gTWWVkKjkt8pButT
X-Received: by 2002:a05:6e02:19cf:b0:430:aec5:9bf3 with SMTP id
 e9e14a558f8ab-430aec59e6fmr8672905ab.30.1760519026088; 
 Wed, 15 Oct 2025 02:03:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-58f71469861sm1284574173.23.2025.10.15.02.03.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:03:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7810af03a63so17894330b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519024; x=1761123824; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe0x3Whxiu5wBpiNXotThqNfqBYV2gNWYO001+aguvE=;
 b=BVxbXqG9dIub3im9eh4TKmGqoXXRupgqVyvpGExDFTIaOW/6ijpCELoifpAy27LDvt
 9CkVyGZlsjzvWo2O+pf33AUc4yqyzSmlbfqqXbFwy6GRAJ0elVk66uXKWTwQJpVLquy9
 k5kTAOVMIUzml8Zu17ze7Wpy1f3Fclhaep6nk=
X-Received: by 2002:a05:6a00:2e13:b0:781:1771:c12c with SMTP id
 d2e1a72fcca58-7938269d8b7mr34992833b3a.0.1760519024131; 
 Wed, 15 Oct 2025 02:03:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e13:b0:781:1771:c12c with SMTP id
 d2e1a72fcca58-7938269d8b7mr34992784b3a.0.1760519023443; 
 Wed, 15 Oct 2025 02:03:43 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.03.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:03:43 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Smitha Pisupati <smitha.pisupati@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 12/54] net/bnxt/tf_ulp: add support for special vxlan
Date: Wed, 15 Oct 2025 04:59:42 -0400
Message-Id: <20251015090024.32250-13-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

