Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDEEE4997
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7648440663;
	Tue, 30 Dec 2025 19:58:54 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 082674065A
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:53 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so1793246566b.0
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121132;
 x=1767725932; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P37npRTep3PoQFq204aaPKIKOHXxQ26qqvdTQUAXl3k=;
 b=KDC/HymE44BuftqZHpkDT2wnS7IVZFnSaqhMFUnVkNpxgL9JW5A/eCY3clkvqy9PRv
 SiVqgCIk1cmo2z5rxKoLvEfqON3/Hc3YSwQ7PM4WEJDoTnCn1FC8mavark00bhz+WbZX
 uACX1OSmYS7wjXRnGQcr4usL5W9cxR3Y8O86DrSCBpvorQhkobVd3DlDpfu6FDOcJUfc
 NWbk615ECK17BAjzCv4pjcQ8NNT8DpjV8K4WJbpvrlgKNL+ZmWlxI7AgX/lqvreYWCnr
 RVSKvd8kZAh9eS6rgxUaQUHLxr4uH/1+6rF8fLubn8a0x5MNUbXT/bYRMUBuIhbUQeEn
 /21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121132; x=1767725932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P37npRTep3PoQFq204aaPKIKOHXxQ26qqvdTQUAXl3k=;
 b=mcLUSyK+IqzLAG1mr9qNZiT8pZHHbCWaKhuCN73oqRYO10FRp40rDSMRf3V/J1e4xr
 eruZg5ZAMfdAdC+eiAmJb9I3hmZK/axhB7dgKhsWdMeTucRNU5R7DwacUohOeswHc1ey
 lmn4UtlrChEplNeHlcOrMhcMZGosFw13Ikns5KxWsHTx/JHMNYd6djRRuivF8Gu+8qSS
 8LiFYSFkSU3LFL/dNrPx6UfdTJO4oaUnGzsTYE9hmTzMFNMCxmIJ8C7hU8wRafQv/jHc
 7Y2NDh8fNn/Sj0L+bGDx2hUq2pgekxe8HEssviOJAk/RnrX5Pk8rgJx8c5h18nTgtf/g
 iSfg==
X-Gm-Message-State: AOJu0YyfV12AUCXebWJQG+FOvBm1e2gRedzASrTs92YmOy7pUm6xxwDP
 jq7RK9rPmFXXMPup4TU74xYQSegfPrwiTlt/ePn/VkqWIc0eC86sXIp2GnAsTYJmO6wUEi1f7+d
 eMNTpTsA=
X-Gm-Gg: AY/fxX5Z/WKdbih2l2VK1DpARUfnNjmah+7JAj0QnhY0qcrjClTTvNeu5SogY78+fyy
 WJp7dyRrfVjK0QROFgrkzsvsSgfsVIR3WiY04ldOR3AlRLh1SCN31MnzokT7AuvALxgPzV3gWAw
 RG7OM/VjYal/mt0oOAxlfHgPPxeOoMLxLcuUg+kEvU9avnOW9uRx9YWYs1+5ODmVK/siRvxQ88N
 Dnf0KKylPerBcrB93hg9LNvIOoKnvjjfjU6QcEPIKYhQ6BVWI9V+MMGy6jBnAon/sxzq4CMDaVF
 +XFy2gyQYUB2yloioPzibW/h/37TFlvnxkSqztS84ZD3RIeiSNMPQbvd3kianWVXC2/hih328T4
 AxFPnaCaF3tfSgEDbb4lAv1GduwcpUD/+9cI5IFeI3vptqapYrLTcCFzxI2ACeT4u189UVt4zUK
 QRh2NAD3l52yk7U6rQ+rMyuFCg+szSomZMmE9vZAZDdPCg2lFJOQ==
X-Google-Smtp-Source: AGHT+IGNT7JCR2ZBRk3SbNbyIn4ncU2sy4Ua2BMycx9rD9sZUeOpMaZRTTDuz3r7AdRpaKd1E2bPow==
X-Received: by 2002:a17:906:c109:b0:b80:325d:99e2 with SMTP id
 a640c23a62f3a-b803705ddb6mr3827548266b.33.1767121132535; 
 Tue, 30 Dec 2025 10:58:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Mike Baucom <michael.baucom@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 5/7] net/bnxt: fix uninitialized warning
Date: Tue, 30 Dec 2025 10:55:13 -0800
Message-ID: <20251230185837.301163-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
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
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
Note: same patch is already queued in broadcom-next
included here so next-net can do Gcc-16 builds

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

