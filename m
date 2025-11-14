Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF00CCE8D79
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 18:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43F0C4111C;
	Fri, 14 Nov 2025 19:52:48 +0100 (CET)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id 793FF410FD
 for <dev@dpdk.org>; Fri, 14 Nov 2025 19:52:46 +0100 (CET)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-7ad1cd0db3bso2076045b3a.1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763146365;
 x=1763751165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zaz5hrgCnNp873lhNmZ9Pm/5apsXNL+UG/H1WiUC1hA=;
 b=ABZn755X18F35NFDS9U3NrI1YqBzaPYRHUvB/4LtgKhjRotoX71vM971CPRfXQsjl3
 BW8ElsNu6nCYh78fe4iQDeN6d/QPjG5MmARtVp0I0JIDIpFkVwS2/VaDHuroX6seGkc3
 zl2e2+s2zozferS3Z+3C9sXkN5b0aA/DRe+RptJKb2oH9ocTJTKru4fujhUbjRhjDA1G
 pG0vWtgzZrJYWMGmjuIEvYWTpLIICRFN9dd4DGqUwR4ysnmpQBz5tqlb+/84mz7cJUUo
 wvtB5Jb3zM4Jnasfz9GUH9EwF3qQAt/IAyZAikoU0Y/k7Hix8fVESUmd7S9fWKq5rFrL
 F9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763146365; x=1763751165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zaz5hrgCnNp873lhNmZ9Pm/5apsXNL+UG/H1WiUC1hA=;
 b=Anj7bZsg1HjMQgQ9Rg5kxZGgT/u+bSEFjQBWHB+DM5KW5SaVciWR2q7qDPEXo1q1o8
 rnZYaHIPCAdymyZHyHIxH0rvKp8DEVoZ6l+kHB5lH9xh+WLC6iKE8kuGz9X4H8wg6dSF
 OfV/Oue8f8ZqV6RCoKeYVfCBxc06Qpf+2G5PSG2vzATXmVU3tBg+5PYRxQUZ4xBPlT7k
 nyeHszqYsXNRER7h/VhSR1cM4m0YyW4WbdRl4yxwRkmzOhGbefA9NSFNEs8KfO2COL3H
 0/WGqzhYo0pJN39jzLap1DG1D948Mz2hS4DJXnB08tO5d4NGOhD189oqJRLF88/qRE+Z
 YatA==
X-Gm-Message-State: AOJu0YyPbLR5XCS2etRi2TQDBXVLz0H0fQXc8Bqgn0Yj6hH5C+OJUJhF
 Ko0qR0vgxKiiVwQ0jwVUpXh+JG5nZTDzAWjTMu/mw7IGtgTrj9jgAp+rM0NW9fljQaG099bCju3
 K6pFU
X-Gm-Gg: ASbGnct4PhtPrOv8kbVskBM91LJs5SAy9eQw+iTDVPDiKisUsCWW3HoQecJ7zjb+tmQ
 pRsCV9SjDW8C8HAuPSUKBVhR9ObFO0VV4T2jG+OXrUVQIBSsXUh1K1PQkVkd83bz2MVeodG237x
 LVkCBkA7Zp+VXy3Pk9UT7yaMP3o9Jel7NCxrl/cdspHU6/msV3CjM4U7PVIhTzYO+g4xJPZ24S7
 nfqXCrLBqf256QP+60NPutibory8TSrcgUkX/5RJiInw6BL98bJjKy+yFIZZEOPTD+/oEAO3fRB
 Er5C4RJRm/oGddAmmMNnmVGmjkHPxBvm6S7mpOufb0wV2Ajb5gP2NoBvHEEZQWMPF/FYE9EbR5s
 1e6BXF/V1ify6vm4aacPZdxPUOLs03uIYnXje9h5JTF24jjqFmDf3Ia3v93pSjqtTuedxZS6yHE
 GSIQsXRciPuodah3HbsKxaf/4nqOtLgLRYQiHdaaKjIFYq+hBDCw==
X-Google-Smtp-Source: AGHT+IGQWMsc4nc/fgzaWcTnawhY3cvj0blV2G5axkRvYwFHHAfaIyaQTJMPuRI0caw3lJF0bMXvyQ==
X-Received: by 2002:a05:7022:2398:b0:11b:1e43:1c75 with SMTP id
 a92af1059eb24-11b41211172mr1662068c88.29.1763146365269; 
 Fri, 14 Nov 2025 10:52:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b06088604sm13188482c88.7.2025.11.14.10.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:52:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Mike Baucom <michael.baucom@broadcom.com>
Subject: [PATCH] net/bnxt: fix unintialized warning
Date: Fri, 14 Nov 2025 10:52:40 -0800
Message-ID: <20251114185240.1363648-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With gcc-16 it inlines a lot more code and creates a warnings
where it thinks it might be manipulating bits that are not set.
It looks like this is because the bits in control word (cword)
in theory could be larger than the variable. Should not
be possible because wc_ctl_size_bits is only set to 3, 16, or 32
but that happens outside of the scope of these functions.

Resolve by adding bounds check which compiler sees and knows
the loop will only see those bits.

In function ‘ulp_bs_push_msb’,
    inlined from ‘ulp_blob_push’ at ../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from ‘ulp_blob_push_32’ at ../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from ‘ulp_mapper_wc_tcam_tbl_dyn_post_process’ at ../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2487:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: ‘cword’ may be used uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function ‘ulp_mapper_wc_tcam_tbl_dyn_post_process’:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2443:18: note: ‘cword’ declared here
 2443 |         uint32_t cword, i, rc;
      |                  ^~~~~

Bugzilla ID: 1821
Fixes: 3fe124d2536c ("net/bnxt: support Thor platform")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     | 5 +++++
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 0ff952950b..960cdda311 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -2446,6 +2446,11 @@ ulp_mapper_wc_tcam_tbl_dyn_post_process(struct bnxt_ulp_device_params *dparms,
 
 	slice_width = dparms->wc_slice_width;
 	clen = dparms->wc_ctl_size_bits;
+	if (clen > 32) {
+		BNXT_DRV_DBG(ERR, "Key size bits %d too large\n", clen);
+		return -EINVAL;
+	}
+
 	max_slices = dparms->wc_max_slices;
 	blen = ulp_blob_data_len_get(key);
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index f99698a1d8..2d89f10d5e 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -90,6 +90,10 @@ ulp_mapper_tfc_wc_tcam_post_process(struct bnxt_ulp_device_params *dparms,
 
 	slice_width = dparms->wc_slice_width;
 	clen = dparms->wc_ctl_size_bits;
+	if (clen > 32) {
+		BNXT_DRV_DBG(ERR, "Key size bits %d too large\n", clen);
+		return -EINVAL;
+	}
 	max_slices = dparms->wc_max_slices;
 	blen = ulp_blob_data_len_get(key);
 
-- 
2.51.0

