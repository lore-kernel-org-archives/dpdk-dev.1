Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ACCD3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AB784067D;
	Wed, 14 Jan 2026 23:25:21 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 754DE40EE4
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:20 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so1734975e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429520;
 x=1769034320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQwZTqUIZzAtQxNoNXm1It9dNvmisGv8RHRoia0chzk=;
 b=TgVOfCX9AwKN0FeBX7TSphUNEKnZ68sCZW/Pu06J0HqZRTWjOleggJYhuciQyPWfqZ
 NE7lthXPrBLHbP7oa/cCEBu9oUjFljofrQb1wNKFkO2lkZJj6lVM/YW34WxnOHx1oXrW
 6Hfm6ddoIBAdrDYmvqzxCvT2xUn7uvcUjKlJGsiy6hXi0G1jCYVM41tpsWY5JJRG9A6A
 J16yBd+PT/sVRs+x361Um1pJUWxBHW7Z2GEl557Srxgn8H9jHEqFifanoHNuNdAeqk/m
 L+MdrgD8LJOb5XafAnHpHK1bB3ob7kZExQwRmK46nD/MYnWS71anE5Yp0Mnk9xo8Df0T
 OETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429520; x=1769034320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TQwZTqUIZzAtQxNoNXm1It9dNvmisGv8RHRoia0chzk=;
 b=DKDm9GJM9jczl8vkoBPr9rrAzoWs/GdIOn2Xw/ebeyOGikudqYgSXe6zH59rX17CIV
 fz/6jR2sNYvMOJqCtTxCLc5HemfSQB4C99ZfAaAyYYDQkAj7p0AqZK09OtJ7FXoBlTC9
 0svU5lzpb2aPkJxNVF1tXgRq5nfw8i87ZQX25gfBziDEmZBi8VVbBvIzbhiIBg7vxzba
 1qVyYe0T93zduu0l3sJRameJPT3S7xpNd6OFEJeorVGW28d7eK5xk7NIQakN1v0CKdjv
 +LtUArL/GUamUToj/kQM1JjP+Dx7NyZzXFh0ZZmAjh6E/iBcnMDpK1W6PzW/MXDwUdmg
 UjDA==
X-Gm-Message-State: AOJu0YzNRHy2C+E8Ar+IqwK7SETOFZp6F32YdUNvRpuFFVk6rqit/Jz8
 koBJrGJSRPnVP2p+Sr7Fu8wVjF+mfrK4e82Svgu8gbDKL0M7BhTGeSINuVbTWRzmDnFBeTOa6qC
 uyAnOndI=
X-Gm-Gg: AY/fxX4x1tiTqLvsi7tnan0NLG/lt4OiN+4G1fMcWgrrVebKsnvh4UA6KVoVH9NCyXb
 pwVf1NGte07d27tmt8uo30ZuYdVUIrMiq2Z+E0BAikpBdTd/OQdlpoHT6IzewlaUVui+MCNzsgk
 dudxdnbIttT+ebVhFlO9QM6Notu4upSP3GOpMpCmWf35lELbv+yRxTlUHTGH8bRnq2Jf+uasfSh
 w3+ABkBTZkgoUaNbkEzVePzuS2gnLHZwywvfTtTSuODC61wuDScWJ9E4nDeTITG2D3eZZN/dnk8
 07EY7Tcwn48pewDLGqgajpHmlp+cXRHgS5hu8Y5xSt6/vNTbEgnw/bh9w2nyzOGx2eiK0e1dP2h
 kG9pi5GINDL0hQlHYIITaOSbDEO9BknByaD0pwen92Tqdy562xeTWBxfccwMQvcyF/5rcdNGso0
 gcAbQ4T0LMi9cvj6EKtJLraSJWd+FNUcL1Bv29aQemynB4XBp6Xw==
X-Received: by 2002:a05:600c:5490:b0:47e:e20e:bba4 with SMTP id
 5b1f17b1804b1-47ee3356e79mr46902825e9.18.1768429520059; 
 Wed, 14 Jan 2026 14:25:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 10/29] examples/test_pipeline: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:51 -0800
Message-ID: <20260114222458.87119-11-stephen@networkplumber.org>
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

Address minor issues in test pipeline sample documentation:
- Add missing period after doc reference
- Correct typo: "Lpmcore B" to "core B"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/test_pipeline.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 818be93cd6..40c530af57 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -30,7 +30,7 @@ The application uses three CPU cores:
 
 Compiling the Application
 -------------------------
-To compile the sample application see :doc:`compiling`
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``dpdk/<build_dir>/app`` directory.
 
@@ -149,7 +149,7 @@ For hash tables, the following parameters can be selected:
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | At run time, core A is creating the following lookup  |
    |       |                        |                                                          | key and storing it into the packet meta data for      |
-   |       |                        |                                                          | Lpmcore B to use for table lookup:                    |
+   |       |                        |                                                          | core B to use for table lookup:                    |
    |       |                        |                                                          |                                                       |
    |       |                        |                                                          | [destination IPv4 address, 28 bytes of 0]             |
    |       |                        |                                                          |                                                       |
-- 
2.51.0

