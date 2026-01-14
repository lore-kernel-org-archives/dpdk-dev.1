Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B6D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B5B2427A1;
	Wed, 14 Jan 2026 23:25:49 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 2D15542795
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:47 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso3339545e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429547;
 x=1769034347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+sTt5Z+BkRlULz1NtVeVvqH6CGg+/whAsrZLM4Tsmo=;
 b=bd/fvXeca/1oPU0FFqcIxNqagVaxJ+5CfJ51VOwlUy9JHNfWAv428M2njzjAXMFnlb
 XCWhwuwzTD0um/XupMPnPteh26Zo+9cq/FObra5pHBu9701Ccv7TfAlP6ksfPsU25vHb
 juiEVEZDUXtNMjS0Rg3FLdOcQSVYPaKfvaQwKKGGYyO2fTlBR18vqvIFdLKfvflPGeH8
 YxxvdQ1U0jEs3MaGJBIZJaydumRcf8f2I9TBioEBYeIVYzldtIdpdWm6t2AXm3M7tDOV
 FrqBvvcjOC7ade2zCyEdRk584IBTCbx17jzKegla01y4gitQgzkJ4m4vYwd07Pg09254
 f51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429547; x=1769034347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F+sTt5Z+BkRlULz1NtVeVvqH6CGg+/whAsrZLM4Tsmo=;
 b=J6KHFDG0NCwh49UhusaD6Q8v2TfSwfJ/onchniWJZNXot3DgnNMIq/MJL1FGQcSoCX
 D/AChBHPhlnMppJLidfsnjtGvpVaOR3kogbyfW5PaMoWl6hmSJRrh/FaLtK0ppmo9IQ5
 OUrh+68KccgB0MjT7k9FKx7fztBz4rW86CuQtyl07v6uqk3GcwwAEEdR0ic3p0saq2y+
 WiKA2+SuEzuX5nIF2dZJ+SKDUubfx20XcW1l5zZuw1t7gTyGo7ZD8LQcY1DNjd8qls86
 sJydy4BC++fwhuwYqFEdbIHDN6ICM1H1C+rg4CQXBpqRb4SaHeVaftpNgPKinhhsUaSz
 kFAQ==
X-Gm-Message-State: AOJu0YwiViY/o9IJ0+35GhIXcf/h8SI3AfKmydQvzmF4PktE+yuXuujT
 onYrBMJUrVZUgHVYAexJgM3MzGGUNdQ1ghuUWxJByHcOUomGuSEge0mQOu/NgaL4FMY6pi9zQdO
 P+5hv
X-Gm-Gg: AY/fxX6qT87XKb1m/F4v6AlmYJ+av7K+PwwlZ9gkFjAm0gG5tHAXErHv9Lkth8ztE5M
 3LpjcsRJ2Jn4d94h1Vy+FGO2+N1ZQl+RhG6de/U5LP28rwg3WRQhkzG6/naq6hhyOhjRuCP9rzo
 LNYLZrR5xvbvSuJShlTgTHG7rVXIh6OtgfX1eTxM7ODFXBS7bUt1LLT2qsuk1H5y/MbRnikJmVA
 ho4JTBtYkGWzGvDeRGQ5JOgfuABkJwuxSfgiDYLY+zg4JMTl6Ezx1unQOXP0fBzmc4u6w/rFXsA
 3XPo/o56STOcWqbI4M8HqqbyyQ4nS+KFbBB2EMOuWIs1QBJCI/uIDIH5q1iqiIRuZXo7pNpVAQm
 bDIoLvwUt4wua2uQtilUORAGnCfAbEQJqpgcsYMXDFiDQOg6UNFKIAE8/5QiZ8ToU1D5cqIAHq2
 jBjeMWxZ+rBR09Hd6UDDA6IFRk638UZWFMpZs3th1nn2Ly6uW00w==
X-Received: by 2002:a05:600c:8217:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-47ee3311593mr48320765e9.10.1768429546812; 
 Wed, 14 Jan 2026 14:25:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 25/29] doc/guides: improve pipeline sample app guide
Date: Wed, 14 Jan 2026 14:22:06 -0800
Message-ID: <20260114222458.87119-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the pipeline sample application documentation:
- rename "Application overview" to "Overview"
- rename "Application stages" to "Explanation"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/pipeline.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/guides/sample_app_ug/pipeline.rst b/doc/guides/sample_app_ug/pipeline.rst
index 2d7c977068..1ea845be2d 100644
--- a/doc/guides/sample_app_ug/pipeline.rst
+++ b/doc/guides/sample_app_ug/pipeline.rst
@@ -4,8 +4,8 @@
 Pipeline Application
 ====================
 
-Application overview
---------------------
+Overview
+--------
 
 This application showcases the features of the Software Switch (SWX) pipeline that is aligned with the P4 language.
 
@@ -93,8 +93,10 @@ When running a telnet client as above, command prompt is displayed:
 Once application and telnet client start running, messages can be sent from client to application.
 
 
-Application stages
-------------------
+Explanation
+-----------
+
+Here is a description of the various stages of the application.
 
 Initialization
 ~~~~~~~~~~~~~~
-- 
2.51.0

