Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67332CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE1340E34;
	Fri, 10 Oct 2025 00:16:31 +0200 (CEST)
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com
 [209.85.160.99]) by mails.dpdk.org (Postfix) with ESMTP id 16E3E40E2D
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:29 +0200 (CEST)
Received: by mail-oa1-f99.google.com with SMTP id
 586e51a60fabf-3799fc8ada6so493768fac.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048188; x=1760652988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=pyoTFztxU2DZPVbDB0B8lzDi2kFRI63qj0NZy+h4ibHeEOn4HTist7rk14NvxHiRT8
 7+tQuS+RCyuhWgG8LHOuY27CFDPSYO/NsnQ/9kcZqPD1yQfiCbPZRzJOARYll6fFfQGj
 B3t768c46ZcMNw4SwdQ4y95mQvH5LG7FqF9MWFArB6W6V9rLGA6pXbrxlBAk/R762KRL
 TTQlisu+u7gZqSNXoA/vxJrO36mZz4YTFDejwc8MRcwSyUE6J9y8JsSK86ua8ppKIPPU
 e7hp0RnRdoZD1pp3CJRVZNDWTup7XasSLJONjAvbzXKIFo44OuPj9qNnJ9G2GqZE8x9a
 x+Ww==
X-Gm-Message-State: AOJu0YyvCQmzVFRzBMYGrQ1IxwOd6wx0dMZsWNZ449xQxq7qmdpZP9BU
 sOunfzvf69sqayK/x4zqxhdirkkJI0Ujn6EXthQYExYMPeO+NeaHsgE6GeTXz/5/YFUap4PrWme
 /12EIdkWDNDs3kysYYO6eSQj9LczZGPsNXv5301uvkmKgXPw2cB0gnRLlzi5w40LVZhKGJAWwAZ
 IUY8kQbvepXe5E4ct4y9F6PGIZJBWUtSq95nzUF5W42F9WBfiIVt1C4G1t7ZZ3IOdPD2fzAg==
X-Gm-Gg: ASbGnct5nyVs7R9pfkOwi8LyRmBZGG+I3SrATF7zxfs9ogUqeuvmPQU0CwuDhjrhr9I
 W1Xa/qIH90N976yv6GMoCFCB31qMJTzfxLZo/uSlERLPJCsOG077TgDPHxXX8irs3QnTNhLPj1v
 iXJEjC/4b2dWrjaFM/j8j1rhMiv2SZrrhCfel0yCkzhOTOiYdMyBiSoahGow0kGUo/yAQQimcso
 xfil9RUvljVb3Cc/SCDkH9m0tBZ4FF8PctXJA6kVfbymZoo1DkQEOmbnwh/jUQWM+3fcM1rWyae
 eUAiWpiXzfYSAqptEWR9UnWAmNhxdsYpuVLdXBUxNEU++gyQT+Lsmh1JX2uQLNz6FP1G1dkThnN
 cZMYilk3W9NZ5J9ZmUS6EUdQoKSAroW24G2c6hrl3fBZvy/VOBYxXxcGUo9pFg0VBlqjlIowQeJ
 uKOq0D7/E=
X-Google-Smtp-Source: AGHT+IGGg+N41XQlcihH/Z8A5tBfUGMG5iqys+dbNLdyTuIjKYRROFeZ3HDs/T40W54P+v8rOhPPnXyBBBbW
X-Received: by 2002:a05:6870:658f:b0:315:ac2f:f04d with SMTP id
 586e51a60fabf-3c0f3db21e6mr4019667fac.7.1760048188338; 
 Thu, 09 Oct 2025 15:16:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8e8ae17sm62989fac.14.2025.10.09.15.16.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78eb8a9d229so42244576d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048187; x=1760652987; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=OaxBs0jsKjcSFIF7DErIuEDbG56RjedxlUtuir+7ArGVMb3D12Dyz1j+rEfvxboHFC
 d0VtlkoQQIXFVCatv3G/54k3Tfv68yPh1fANlCXbc1gMvwdsXDL7jpnv3POHX95/W1ED
 t/fgDcmpS797maLQ15UG+MimlIibv8GfQc2Vk=
X-Received: by 2002:a05:6214:2a4f:b0:7fb:ed4f:588 with SMTP id
 6a1803df08f44-87b2106567bmr128992646d6.18.1760048187071; 
 Thu, 09 Oct 2025 15:16:27 -0700 (PDT)
X-Received: by 2002:a05:6214:2a4f:b0:7fb:ed4f:588 with SMTP id
 6a1803df08f44-87b2106567bmr128992336d6.18.1760048186487; 
 Thu, 09 Oct 2025 15:16:26 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:26 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 41/54] net/bnxt: fix rss configuration when set to none
Date: Thu,  9 Oct 2025 18:11:16 -0400
Message-Id: <20251009221129.28256-42-manish.kurup@broadcom.com>
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

If the rss hash type is set to none and the ports are stopped and
started again, the check for rss hash type was not allowing the
bnxt driver to populate the correct rx rings in the vnic rss list.
This causes the subsequent calls to rss configuration fail since
the rss list is not configured and have stale data causing the
firmware to reject the rss configuration.

The rss hash type of none should not be ignored during configuration,
it is a valid configuration and should be applied. When rss hash
type is none, the rss context is disabled and there should be no
rss algorithm applied to the incoming traffic.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 00b02821c9..939f35e3da 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6331,7 +6331,7 @@ int bnxt_vnic_rss_configure(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
 		return 0;
 
-	if (!(vnic->rss_table && vnic->hash_type))
+	if (vnic->rss_table == NULL)
 		return 0;
 
 	if (BNXT_CHIP_P5_P7(bp))
-- 
2.39.5 (Apple Git-154)

