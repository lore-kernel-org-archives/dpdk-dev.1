Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A02E7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3440640A82;
	Mon,  9 Feb 2026 20:51:13 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id C7E8B40A6B
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:51:11 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-483337aa225so8912305e9.2
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770666671;
 x=1771271471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDgaq8HQoLp/mNwPuerXrJihfXFTgJQRezRhI0w2sfQ=;
 b=eiRYsri0TBOT3CSIqq8NsgL6TgCM9a06hWSGOVQ2oLLKGUoSx1mKmDAQgQvl5NuXMr
 QizTzgvy5/Y0r6U/BHhETa7qaTOB1Y2lbf5Nmz3tHQ0U/myK5CNgLX3rPvQoHocHzox4
 /HVk4xVNKhC/xEdQu0Y0xNz1quxjWuVI1Ad2+TZXXhwiOpf0d8HXMHTrRSrlog8GSOhG
 EQ3CTXk1ei8K7cXWc1OPM4s136MMmWvPs6uDFrckinQ/ZNRyxdx85ZazawdHP0CpKEgv
 HH0+oVcphQWoj0Qk5AiKvPpWzZ/zkc1wrku8I/Zcs0nJnsa2m76ZsFcNfH64tAz4WvgX
 uhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666671; x=1771271471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jDgaq8HQoLp/mNwPuerXrJihfXFTgJQRezRhI0w2sfQ=;
 b=RZJYay0Tkc/i78d6/irLY/BHDWhhYkZkllaBtgeTYoMxHoq86KAW2p+lVOBy06k9LP
 aV2nEJIjhNYw2mc+nx4RONXnWC0Kk0z6ukFKplLqB6GzsoqVtVOuRSu99ZibTU9+VeZW
 5ZbvCYo3oxD9/1k2Ug7wkNZIzyayEWLReJJNcXn/TQNpoXOaunmLTS1TSpc7UCiJtAJ4
 Cmwc1/Bv9Cv8HL/J0Tr4+U/QhYlvzh8AV7NSTiuNkr8QleRnHo3ev9dnxU1L32IniMNW
 V5f/zNClSRjDfN6aLuHHRIBrzYtDgQOBELoCFpBBPQOzeVesqlEyPDg62dWdLAqUiCtJ
 ULoA==
X-Gm-Message-State: AOJu0YxI+s6fu3udbdOa6OY7tu3c6RbQonbbabwVlvctVZT2aOvu3p9v
 M0mMN5nG3IfzjTJTMoFNLQhGEIvwC2IhZZ/RQrntC/snAhVHFV4pHXgAMEKd/ulA5Ez0hQuBRiK
 joX9D
X-Gm-Gg: AZuq6aL+CGgZdhvB7TIIS//wtDrGxSsuPCSaMoY6anjnnEDfvmdQWXdXGMVbjs3KWz7
 r6bii5SXADOjLWAiAoIwx4Lds4FCGBfSlQmaXYw5pLcvLijh9B2ubBpaTlhw905HNT8dYxsrn1w
 RbeMzgJ8gMGOfxQKzfHHaEK6NpfMYN68ptXKIz8Bl/9jIl32UgrRZWh+yxc/iwKrft99f9ofhwS
 5pSF1wmL9xYr87pDHNEt6R7N2Z+JZ0cRj6QG92EM5oaSLFXZ0WPkdwvBvfYtL5043Lhf0BQJPRs
 ifxVGvtren+0PiBMVOgDQDmLzZ0HTLaf8tMplRCoDkHHR+31pKRh+rVHmfg09PkmeXht2kmYiNw
 ccAD64/ctUeQpgyCNLMGLzNBZQzC0+oo+Br+dEsP88pTlL7k0YE8aQo2xiCG8s8wjd94wm4qLb1
 Bh+DGMdwmtbuwU1xS951f9ZGUPz3gldzZUuR5xwaat+xn+vHn+gw==
X-Received: by 2002:a05:600c:528b:b0:477:2f7c:314f with SMTP id
 5b1f17b1804b1-483201e25b5mr167076995e9.10.1770666671327; 
 Mon, 09 Feb 2026 11:51:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm10178345e9.3.2026.02.09.11.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:51:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v8 6/6] MAINTAINERS: add section for AI review tools
Date: Mon,  9 Feb 2026 11:48:54 -0800
Message-ID: <20260209195055.142484-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209195055.142484-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260209195055.142484-1-stephen@networkplumber.org>
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

