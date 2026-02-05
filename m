Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE57ECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:53:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 607F8427BA;
	Thu,  5 Feb 2026 18:53:14 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 6C37A427BD
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:53:12 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso13013035e9.2
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770313992;
 x=1770918792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDgaq8HQoLp/mNwPuerXrJihfXFTgJQRezRhI0w2sfQ=;
 b=ma1hjG4MSCE49QoE0uAVz3sPibl5LkghPZOGgV3S3yxSoAPoL4fbncmjcb9rW5gD6E
 Ay3uI6bKb5eMjlAFdDxrO2ynRfIcizhVNH22ivzTaJHXPKpLY0yDSqypNdvx9yKMulgX
 4EYn6/sUDj7ts/2TjnjRcbBiPzBLyP4iU5TiQMNtcgdKm2UKP0p5+3h4XDJ0zs2/5JkV
 sT7Bp+xLwoV4oEplENtEe7BTz1RYtC+UO4HjIfOgjMdFjWbvN/k1WPmhJSEzle51PP3y
 fZJ64bRKbBeUF+XWQg27nrqI1cbWBUk6Oo3DvtJlUtI4X3EQA8yXEtGGnxisaIgMLuch
 WK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770313992; x=1770918792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jDgaq8HQoLp/mNwPuerXrJihfXFTgJQRezRhI0w2sfQ=;
 b=J/+XaJE5jyG/d/9GHW3lQ57QZaBs+Fe6G+DiNbav2YuYrmMGd1hYTa8yoSLzknQvIb
 UzJ7N94vpxGXOxRfMMpc95NyOzeoBvYCDETTm5hc3sWvLYOkLxpwxpGmLmCu/8QZPB8G
 9qlKysVC5UcPIHRhE7OIO9Tog89Fs1Qxfn9c9qgG+/Ue5pRj3Yo6x/jJRHTVnPzSdrMT
 RJjdN3XAXc5XoMiLsuATYwGLhvcBF9XPAseydh0j4G08HPVLbZ7KZsWQTduiT+HL78Yz
 JUbeio2YKHTRM4waqGVFP+79Sm3ZZfCviK6l1iZQdGmYdmjFEV1vySp+s5BexbaBCG0V
 68tw==
X-Gm-Message-State: AOJu0Yzxz4E/13cbSEsDuochckqOvF/G0Pb/YDlHc1LHvOFYxUV/yUtR
 5i/mrXa29wwnBKRg8b0ovV6UcFQvAwM28Vp/g87o+Jac1sssFT1Bepf/awa9NDGZiDNj6ljBjxB
 DT3g1
X-Gm-Gg: AZuq6aI4DB/oGtlHy5OoniQbZDLcqK2nAM4VODHj/eHjhKXr6T76HmUJflLQQkqMjHD
 C2NPaLV+DFLAsuAPPCiSGXaIpbqo2h7N3tYOWURnKsWcOCSGKSpIW+dfxklp3KX2USFCCW74fIF
 P37w1m2l91i6p/R6BO4nBqgQJAB2cjWS3Yrt8cz5QLxHKTO3tcu2OMKVov/RutkTh0BqVgtuIyg
 zFS/JkQBXiumkUYuV/Ui7Dfcw7H7+JovSvMF/7umH6oCI3b5Ho50GixPaWuOo/b2neKxK5Y8v3/
 GhudFQ62PCUJG7mTMcbfKR8xGo/g2O/n46wqU1UiiqfVCooKRr/GG64VhMNv9yj4DxD8/ISH3L4
 d35stLDTD87WRM8GPTMPMWXN2Kh8Scu0vz29eWsk0kpvIRQiqvZFeY66ggJAjTC9nnBwkhJW3Yu
 nzJxWFP6o3rE4i0UK4rrKVOJF3D7dZXz46J1JDga2laJOhvfv0Lw==
X-Received: by 2002:a05:600c:4450:b0:47e:e72b:1fce with SMTP id
 5b1f17b1804b1-4832032f5d0mr2656865e9.37.1770313992010; 
 Thu, 05 Feb 2026 09:53:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e1099sm667185e9.6.2026.02.05.09.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:53:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v8 6/6] MAINTAINERS: add section for AI review tools
Date: Thu,  5 Feb 2026 09:51:37 -0800
Message-ID: <20260205175255.652963-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175255.652963-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260205175255.652963-1-stephen@networkplumber.org>
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
index 5683b87e4a..a30f08974e 100644
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

