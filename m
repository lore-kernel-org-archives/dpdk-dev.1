Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3389FCC9A8
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8893B4069F;
	Tue, 10 Mar 2026 02:59:23 +0100 (CET)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52]) by mails.dpdk.org (Postfix) with ESMTP id DB86F40698
 for <dev@dpdk.org>; Tue, 10 Mar 2026 02:59:20 +0100 (CET)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-40ede943bf0so4144872fac.2
 for <dev@dpdk.org>; Mon, 09 Mar 2026 18:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773107960;
 x=1773712760; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gVRilbtEBuiCuBfPvgGSxQx8MO/vNDZx0iQln2wnIY=;
 b=v8k6OQP+7N6V8pxkytIos+StwXR37Hfj72IP1iBDc0pCIo6IrHOyq4L9UsEePqJWAg
 cMvXAPEpGo5o2TfmiUmVMYzz3g6B+cSmCpH1IjSp4zraGbCjI2oQstPbb8ru9bCQwa5+
 f8odMPXloZrYqEzCYN/JzsKU/kgqCY1Oj8OY/Ee1vylCbuVxTPJkHg/W9wRwsjz5cW+Y
 WqM92gieLwfel67LI8rF073BV9MwTMnCsHbdJ50HjjWLVZVGP29VpWG2cjaRdMds6yQm
 neeSrT3HbM1mMBM9ExceK0xuiwFXdhgFoaVVKCb8b/uDiq6iQcOFMvtT0wPOdWwEkQc5
 ivxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773107960; x=1773712760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gVRilbtEBuiCuBfPvgGSxQx8MO/vNDZx0iQln2wnIY=;
 b=F2fjonNHicqyaFgjRvLT+d5VhieZsTGpllGgw5iBYeCx6Uqn88nKwb9TCE4D5LQyqP
 RnbvYrum2rIzETaX3Rh8nUYui0QOYA2ttaK2FC0C/kbgc4axenSJQo+aNB6PTBQfb4GV
 V9pOSLO2OQgyNywVf6aW3aHWBO5KKdS/CItnMuAaaV63lCDDL4H2egGOQNu82YQX9aHy
 UZI75vr7XVv0ASDt3xQPx5CAJ4H+kw/69Uc7fveldf/dWCsLyP0Dk7QOqcVbf/q6OG9z
 JvFs0AlWX36mNJN9v/4Kg1i6TsQPqA39FGHSVuuV4UoE/XWTn3ifgTykREURELlFkH/1
 p4bQ==
X-Gm-Message-State: AOJu0YxH6mnJ1Tce+tP8+kAVw7fPocS9S9guCzx0SG3y0pzfRDa2sNLy
 Kcf2x5vd/2iCVPLjWJY42T2C2UD9fDNEtY5PmyoVHFIGkLpTPzm1MlqAl1LHuwZHus0L6EvtXdL
 4cacOZ/g=
X-Gm-Gg: ATEYQzxnXtS3ZegIeNvpM4Z09unlDqSvEDor2NT6oUyjk8DjWbprYceFzasPVxDxYwF
 MNNi6RzXIiU/sYr6LRDwJcceDLpVn5Zmmd6Pc0hqup7qaBDoqVq3MNjDkvulVTye44jYvBU+/A6
 C241uo2bA8BbOynsdYoh2/0bCvNjB1gjF3ITq2rmsTOJKtdUV0r0eCZI5YfDpLgtG+nfvE/Lhw3
 RqjvLMODvm5vM7nYclm5HNg6JLac74Cz6cmL+eBLOh6g391g235eaLGPgTwO5eCN5PAncbtgzF4
 IWc9kQBz40kDWuOmtan+JpPxwSFG1de9UGypY24bifNnfRBNS9kN1r9PgHhMZPpTnCO7h5MWDXs
 v/RVQkLRMelVQU/3zq8ABVkq8q3wpfRcywKtn+iJ5gFzm2Sl6Uku6GMh/ZUfIK5Eha1G4jvd/Rp
 bPpD5JhiP5USSIrf8bqsq0fsoooyyzim/X
X-Received: by 2002:a05:6870:4e84:b0:417:36a5:23a8 with SMTP id
 586e51a60fabf-41736b47523mr2963034fac.14.1773107960107; 
 Mon, 09 Mar 2026 18:59:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756d4c0e0sm1172716fac.13.2026.03.09.18.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 18:59:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 6/6] MAINTAINERS: add section for AI review tools
Date: Mon,  9 Mar 2026 18:57:26 -0700
Message-ID: <20260310015910.331784-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310015910.331784-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260310015910.331784-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eb8e9dc22..7c1a84274f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
-- 
2.51.0

