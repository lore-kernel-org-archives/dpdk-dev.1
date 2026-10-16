Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE0FCCF2C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 18:06:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9833440291;
	Fri, 16 Oct 2026 20:06:32 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 4F8074026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 20:06:31 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so219086a91.2
 for <dev@dpdk.org>; Fri, 16 Oct 2026 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792173990;
 x=1792778790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EZnHJBy+K6msiM4w4Mr2eyFlhQXUWD9ejNK6063Phgs=;
 b=aUgZ8ML+wPABM5s7p2YPa7zZWG9glWp3Gbn4GQqL21JPi3XYp3Xs3iJZ4GMqW7Akoc
 fXLk4shlW+vdf++cVFr4bVD8gEB6O3C4k/cThL7yiHSMTErG/7E0GzC01pEsxBwG8L+p
 ul1Z0NHW6opjjjSaqszVEs9hO7S+AuiasDiDsGYi0AO7WwDzUOSHD1C/KPPZXFohdAPC
 lriiTgY794aYTn1KCcEdxX8XX9uB6MRLO0RXkOSYqq0K29GkwNDohUyz02iclXhG23iS
 kdMPa5sVBzZlDYtkNRBkFx9i7PGmp/r4CeD0cT63bOwkkH8gbZsbm4XHnhOW9wfPRkGn
 IYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792173990; x=1792778790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZnHJBy+K6msiM4w4Mr2eyFlhQXUWD9ejNK6063Phgs=;
 b=a9UItRcGX8rdARCVxVnOMibbgDtoPMD13qPWtgD4i3Kdxi+7Eqi9vMN+dvfF5fUTKX
 eoOrCpRGBNYQFcQHWKy0LytmlacjnyifY/WdeQ8/XSe1u3Vmhj2kOvXDlF4tWqQBsDlv
 +vYCV895Y7NbewORL/p02s/svjFGTfnfgaePSiGX1c19LwTc6cx60SZQG/+zcQCzTZZ2
 ifiVY2+zQ+H5dN3Rk9ZoaMXhjk0zZ7IkYHMXKaua53HwTuSVm+J4FfYzE2ZXlseW9/8+
 C8+qqD5EfFT6r2vbBHXVzXpmL//b7ImaQACuYccahVytmL4mlFBE1QYlr0yLy1WRVeFD
 Uxpw==
X-Gm-Message-State: AFq9FYI4v+Ad9JhOsjMJKNEO6e5S0k6Agv+rdPY4EYIgqCtPOHC8gvnS
 s2jBZm/6idGS+L/cyFaGAVpqvLztjgaCpPGMJ9BUX2a2xrE4syV1MwU3u/fE/oEPf4j3Z/Q6SKl
 Z1IT7I7g=
X-Gm-Gg: AYBFou3lrgvRwwvLPWkjdwaovdUcpdpNklhUv9igScgSo1EAM0SWIGNY20gTTO6sdmE
 mdqvk//mczegja91Cd8giUrW+zgBO3PenvofkKE8b4jHMWktv423R1vJZ1KslM6T7odFReW2Hdg
 DLYVbsLBWh2yvYIkTKsf+K6Yd0GzN9Uv2t+X6NzxSRNF/LEQyo8N51DT0JSA+Y/r4AJcyM1i5uI
 jRfjwqdekl34jUU8QlL3K/61UTLm1ryW846zIl4aVJSEvzxwnqqMqZc72oYPc1WHGf/VzBqtWZ2
 KAEmvPWXHs0gAE0jEaw7Rlg63TawoPY8VwJtWOH5jf2OocAbz8UOqs7jlzpR4wBZg39wLj08WrC
 jl9/XUNWV7Ja3Z6siViGR4C8bgyto97CKizv1Io0xuJ7QR3BUjXoGpO4ArACxBoUfBq6TRyPu0j
 JpVKo0SJExvoqEo98BTfrBS1LRzf5xb2pNMs8czAW7yPz6J08b9WeZ5ScbGZVESqcqzVXtS13nb
 8RGqTLfr6dZpBQG/DawZxeKrsrspQSXdnS6jw==
X-Received: by 2002:a17:90b:35d1:b0:3a2:b16d:928b with SMTP id
 98e67ed59e1d1-3acef3d95ecmr555371a91.46.1792173989547; 
 Fri, 16 Oct 2026 11:06:29 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4972fe6sm5163183a91.15.2026.10.16.11.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:06:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH] net/dpaa: make mac_idx static
Date: Fri, 16 Oct 2026 11:06:24 -0700
Message-ID: <20261016180624.3507846-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This array is only used in this file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa/dpaa_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 05c1c1c065..f77f9f333b 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -34,7 +34,7 @@ return &scheme_params->param.key_ext_and_hash.extract_array[hdr_idx];
 /* FMAN mac indexes mappings (0 is unused, first 8 are for 1G, next for 10G
  * ports).
  */
-const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};
+static const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};
 
 /* FM global info */
 struct dpaa_fm_info {
-- 
2.53.0

