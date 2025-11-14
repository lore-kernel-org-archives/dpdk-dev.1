Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD42CE8D79
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 18:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E56410D3;
	Fri, 14 Nov 2025 19:59:49 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0CC1140EE2
 for <dev@dpdk.org>; Fri, 14 Nov 2025 19:59:47 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4ed82ee9e57so28551631cf.0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 10:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763146786; x=1763751586; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JLiiSCZxyIUwz2J/t5bfgpp2BlJfZIzH5bGmAM70+ec=;
 b=R+K0J2hbF23D691CCwGq5fL80L4NDBvj9e8OeHv8iuCm1Mn8+s6HBr4Qi9qty/Fz02
 wDv7pQj2Zhw5logIyeY8LrhuChtHyWQsUIabPcJEkiLTahnu9CyEKeGEPfPf1WcsOovW
 lvCpduhX4CGpwOqBxeeEbKj+IiG891PWagpMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763146786; x=1763751586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLiiSCZxyIUwz2J/t5bfgpp2BlJfZIzH5bGmAM70+ec=;
 b=O1wdhK2yJvb8Fj2LduiVArNgOL9hsCgacdkMFysogn7PaSWB80PbAmzScjl0QHJgoc
 XwYfdkmXb43Fm+K1YeAwGDOVgEKm1tPfoPXzYGmWPZd/NZb9JqQLT5WbOps2hKWvhLdV
 rTesbvdT+wTgpyotJuSpCBA1WJHozrVz2/VtrEc893WYsI2eYI0sMe9MwumY3W5fe29f
 6YZKhHSHftib/UteuqCHdLLyaaUtyUBL+35L/Zc5OSW2118JULL9/kn7k9wL68tyBLUK
 PUSgPmtfIHA7xBE7lAkftBqBBNzCI59YJ5GgTLsi/zRE5A1ubafTUIL4Wr3KeJdpxx7p
 JhdQ==
X-Gm-Message-State: AOJu0YzTFw4Nhbnob5lBN5CAdEbYTZrn+AcbU9NXXtu7Gn/gUbwj44Z7
 DtDG3ocx/oOmsfFSMvuU3TFM5gNU42L8cswWWsej9bVn66UCUWYC/mxKS1bzNzNE1qY=
X-Gm-Gg: ASbGnctIjL+5KLlqkyiIRgMQvLD6I+eZ0m88jYkqM81TED5RNVGvkzQxd81NMMjyNPh
 z59J2B5JPloZHji/BFRSelVDi9YslcRLv6lVDjkOaPPIZX995Pll2BItJOjYt7FEINU5S3Vpvh7
 I+PmPPn89U0tDRQruAiw3AIQyJi72vHsGRmYlo5UeqYxJQRaWTWa0yf/ni84nvaoAtWKIwknrAu
 R0gbsSvsIxYuIhcn7iGK8Xy+rqQ5c0FpPvNJvghWyWY5HBfacuewbU9//nRaPaJrLZUCmgNgo9w
 ZIeE0i3DFGyVxnnbDvgeuq91QZpQXB6JfcVQejNP2SRnuUcUBz06i9qrNwehmFA01zESF5ghmg+
 CTKggVbuXl2ERsFizGIbnjhtt/wcQbtaeZ406bFPeTL9VNxkYqQQ/+3NqBnmL/Km89li0zPOObI
 eGXaleefstAwUy6Q==
X-Google-Smtp-Source: AGHT+IE51E9Hjl94LvLLziyK2X6CcREOFRxQclNOfcufK3ZdLKlbwzVY4/InBfyK09pAXYjzfnFVMg==
X-Received: by 2002:a05:622a:13ca:b0:4ed:1af6:2304 with SMTP id
 d75a77b69052e-4edf2113112mr50788681cf.61.1763146786213; 
 Fri, 14 Nov 2025 10:59:46 -0800 (PST)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-882862d04e1sm36402346d6.7.2025.11.14.10.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:59:45 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: update dts.rst with current API status
Date: Fri, 14 Nov 2025 13:59:44 -0500
Message-ID: <20251114185944.337957-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.51.0
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

Rewrite the section of dts.rst outlining use of the DTS
framework in writing test suites to properly reflect
the current state of the DTS API and how to use it.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index f0abfdcb7a..195e8f752a 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -503,20 +503,19 @@ Leveraging the DTS framework in writing testsuites
 
 One should avoid directly importing DTS framework code to their testsuites where possible.
 Instead, for performing common processes required in testsuites,
-one should use (or add to) the list of methods provided in the ``Testsuite`` class
-(the base class of all testsuites).
+one should use (or add to) the list of methods provided in the ``api`` module.
 
 For instance, for sending a list of packets,
 one should work through the packet transmitting function
-already made available in the ``TestSuite`` class,
+already made available in the ``api`` module,
 instead of directly importing the DTS traffic generator class
 and using that class in one's testsuite implementation.
 It is also acceptable to import and instantiate classes for various DPDK applications.
 For instance, writing a testsuite for a simple packet forwarding operation
-would involve importing the DTS ``TestPmd`` class,
+would involve importing the DTS ``TestPmd`` class from the ``api`` module,
 instantiating ``TestPmd``, calling ``TestPmd``'s ``start()`` method,
 and then sending traffic via one of the traffic transmitting functions
-exposed in the ``Testsuite`` class.
+exposed in the ``api`` module.
 
 Test Case Verification
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.51.0

