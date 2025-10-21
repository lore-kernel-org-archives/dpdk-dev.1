Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7ECCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:52:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55F1940E2E;
	Tue, 21 Oct 2025 19:52:35 +0200 (CEST)
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com
 [209.85.210.225])
 by mails.dpdk.org (Postfix) with ESMTP id DE7FA40E2E
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:34 +0200 (CEST)
Received: by mail-pf1-f225.google.com with SMTP id
 d2e1a72fcca58-78af743c232so4651742b3a.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069154; x=1761673954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GzekxNyUcsEw9z0bweNDDxSTCPYFlqWpXwNtzxb1rtQ=;
 b=t8ybbGBAEVcDciXmdNGB3UhdoAEL+BEJA0UCA0y/yDAPbuhDlkuet5L0GNrxGQkRsK
 zDN+p/j0MkV+L3A4FiMTUkAufXa8EQntdKwx57XtmQCSzwPNCxQeLhULZrXEB94uWRH4
 lXRsBtHcMbeP2VI0Ykavng6VNor5vXjNN+Xhgraka47kolp6zN4LMg2vBTkIgegZnTlw
 WYgzcSBLyDaGeRNYUFf+l1uhE8SB/Lj00x499lA/zTWqXFLYk9OahjViWNBNAVkYipiU
 4XjXuCWareA9jedmjBpNw4Cn3APhYANLgFp2zpi4LxfTaKYRqTFiBAn7ceTV1IyUKrSv
 QjRA==
X-Gm-Message-State: AOJu0Yy5/WMgNJzCkUCwDOV+oifYek1jQcKWvr0bmZ6FnP6jhuW31DIr
 cM+JmjVzNBcZ+TAfX1xdH/HZoO9lMRWdGPcVBwCWjuJkQhtaBB4tbQ7y9G2maJVrRzG8yC0lYsP
 xOpY1i5Lq/bRWj7/Qmznw7fmd9/z5Lb0vbjFBTtElxdjdvsmew3SKjmTUNFg1QhV30jSzAB+Qkr
 Smu/ZkQmceA8/ZAejkbBeXpGv7q6GY/DJpD2ubV6Xc6ECSbh4/E9ES/O/owlPrIET51Ptleg==
X-Gm-Gg: ASbGnctQTSi5B9Y9Pj9SRN0vUTvi21LIvjs2+m4WqL7vxuEE9XLNww25uRymzWaigdW
 2ISTBGPcQSh9rQXYjHfVzOWeMDUyD7jPkFDyddfthJKd37XsYLxbRfGH6liRtVOOaRCTEknj++I
 8DS1yP6en+X+Wj2Ct1ZWhbm/IE9XAHkjbnLjX3jx8dNDUpE4Kbwvvn6ycn1s34gsTVzeLoGPC7z
 et03wsx+xiOTpKfBXAcq5ju0D8fGGkCv90kez8tcj8yvviCgKv2SfLVlnFgNkBqHWFuDYh6kE3V
 dzE20tC+z/KZaDEvJbaoK+Hb4qdoRkO/lO045Wp+BgBuXBKwfj9O8vQeT5GqRUbqgqoaTbUTWm0
 mT2cvpQHgvl/nxHkcyCzLPfsn3k+UPAQyvv4rj2fok/OAdnMj333eexXFvICgFL0pCH/VM4dWyp
 O5+t2m2uxcgjc3IY1gYWzeSP6u16X/yClhXA==
X-Google-Smtp-Source: AGHT+IFx491TXx7Q9dOSgdSbJDaQRxOtxqPU8e2Fvz+U6vYzBbqRw9VB56JD4Zqrddfg6K7e2RVY92X0Hbfl
X-Received: by 2002:a05:6a00:2182:b0:781:17fb:d3ca with SMTP id
 d2e1a72fcca58-7a220ab5260mr24923912b3a.15.1761069153998; 
 Tue, 21 Oct 2025 10:52:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7a22fd1c0c8sm1680193b3a.0.2025.10.21.10.52.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-290e4fade70so44106365ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069152; x=1761673952; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzekxNyUcsEw9z0bweNDDxSTCPYFlqWpXwNtzxb1rtQ=;
 b=GgfMJxRGPKlhbquCI/L3BgrPDG47j5+gDSGNpcMdre+LnD34GdnEfrvQ753BgP+Qzs
 dxHaeZwoT7ZpptDjR8dggHGT65+dSi/OBid2xRjMAzPHuZ8nzedLuhAiexUWZ3Vasn95
 fVaZjc/Fw5Daj/+WY+N8ahUBW9hGP5kqKRTsY=
X-Received: by 2002:a17:902:f605:b0:26e:62c9:1cc4 with SMTP id
 d9443c01a7336-290c9c89da2mr201149405ad.4.1761069151686; 
 Tue, 21 Oct 2025 10:52:31 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:26e:62c9:1cc4 with SMTP id
 d9443c01a7336-290c9c89da2mr201148995ad.4.1761069150929; 
 Tue, 21 Oct 2025 10:52:30 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Smitha Pisupati <smitha.pisupati@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 15/57] net/bnxt/tf_ulp: add support for special vxlan
Date: Tue, 21 Oct 2025 13:50:07 -0400
Message-Id: <20251021175049.46092-16-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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

