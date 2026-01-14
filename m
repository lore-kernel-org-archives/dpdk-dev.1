Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E468D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B57C540E3E;
	Wed, 14 Jan 2026 23:25:35 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id C02FB415D7
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:34 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so3127905e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429534;
 x=1769034334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouuUkfxgZRQo87AFu2oyW4Xq9xbd/SRC0s56rb8/n5U=;
 b=Hkm53mwalrEiVDdD5K44enFHgc+fAdZfNDSE0Rq8wccsDnXP+h9rElxLE9AXVjJUEj
 dYGer0cWAstotMzsCZSin93X0qzqUFwGi8yTaeCjjFvSsBUjGaW2DMtvBzkIZK43G4JV
 HZz9pD3F5JRsPENslN3br+mOODxUT4/8LMZLbv4pnKvz4a6nmWfJZgYVzHcKmo6x8paq
 iqABUnjefJx/l9NTxsofPue+USl+i5EHzukoBiXzP624AuciwcXssiLqs8PbpMY/zaNw
 YjO/fL0AiNsYS0gUHU3MQ9um7j1fnosrkF60N6DGpDu/sGXPsfO+jWHWEdkWGVkU4ARu
 v1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429534; x=1769034334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ouuUkfxgZRQo87AFu2oyW4Xq9xbd/SRC0s56rb8/n5U=;
 b=j8xnZVCRxxUk1TS2/MRTLxdAKDXGx+87tWKRXwy3iQ4hVVaDgWeSonY4gvxHcuOPav
 OrykTDU5kzLvrRwDmHOn8rg+icnjnSnk4lJ6oD+eoy1TXs8RaXQWbzcv0JNw/dKx+rwP
 DG1cKPVh4rVo+B0Y7UXR4aJzRml2MNlwZJ5JzPDSfsSKhibMhJAo/CNya/yeFx0lbn/B
 uzfetEUUr/52VL4+6HLMHSKtcaFYGp4VuJbIzKtVt8j30+X4FjDw8y6hVfJHicZtdlYm
 6hO9ROXyqoa3tXY3dG616xo6KpuewovU0urDSb7SCY2WFau/++CR6piB3Q87FfoXWzR4
 xlZg==
X-Gm-Message-State: AOJu0YxC+j6OkfA+QAf2ODAc7q9TJjhzL+Aha3/toRiAS/6qKwPDzWI8
 jCfgMF9yfS/QBtiZpua1Ky30YVmDxsjUpRYeEkQ8S3t2mjTuZaiOsQsybk5o5U8TEHb3/RXEIpq
 yMeQ5
X-Gm-Gg: AY/fxX7q99PFrPOQq2NNZUEUPnNBgiXw+NyCvH2d4McopE6nR/+e6TCP8iQ/N/evLhC
 Lx6se5ZrjYWNlSpDTW7LV53HielA7IKgWLfBrc1Z7obeJ63nRH5e2gMRQewiEgB3HbEZV0/fD/O
 ldmpWZdWn07+uFpSZJXncY1SE/ctaA8is80WMvfzUHb91JhUy+zmxooUUxFb5RVe0bXZC1yMwpB
 AxIgahsegoXvz2VS1H2ZIFF6w/XUyyXyCtOi89euhNqfi2edqgXkipLZYrlXzcVebNWUU7GUpPx
 X3qmDnoaX2C7+cWcK2fqdanQUpyu6hIkewKmdlVGnwSrbAptECnTAjKfCBF85pWH3OswNbo2VRO
 WKubwgqWRZ7O+n+8eOqXnQk92KXwYuKQhpfX5xFwe2vWyr6fX/hhUgwxjgG2h1sV4vgulYofv35
 3Jqtpzd6fsmlhbVlDz7qRJfxjd+Hk/juuSvqWwAvQEPGrEhyzyPQ==
X-Received: by 2002:a05:600c:3f16:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-47ee32fd19emr50198695e9.10.1768429534361; 
 Wed, 14 Jan 2026 14:25:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 18/29] doc/guides: improve Hello World sample app guide
Date: Wed, 14 Jan 2026 14:21:59 -0800
Message-ID: <20260114222458.87119-19-stephen@networkplumber.org>
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

Improve the Hello World sample application documentation:
- capitalize Linux consistently
- fix "helloworld" to "Hello World" in description
- add missing articles and commas

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/hello_world.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/sample_app_ug/hello_world.rst b/doc/guides/sample_app_ug/hello_world.rst
index 5bfd4b3fda..8f22bb2260 100644
--- a/doc/guides/sample_app_ug/hello_world.rst
+++ b/doc/guides/sample_app_ug/hello_world.rst
@@ -9,25 +9,25 @@ Overview
 --------
 
 The Hello World sample application is an example of the simplest DPDK application that can be written.
-The application simply prints an "helloworld" message on every enabled lcore.
+The application simply prints a "Hello World" message on every enabled lcore.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``helloworld`` sub-directory.
 
 Running the Application
 -----------------------
 
-To run the example in a linux environment:
+To run the example in a Linux environment:
 
 .. code-block:: console
 
     $ ./<build_dir>/examples/dpdk-helloworld -l 0-3
 
-Refer to *DPDK Getting Started Guide* for general information on running applications
+Refer to the *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
 
 Explanation
@@ -46,7 +46,7 @@ This is done in the main() function using the following code:
     :start-after: Initialization of Environment Abstraction Layer (EAL). 8<
     :end-before: >8 End of initialization of Environment Abstraction Layer
 
-This call finishes the initialization process that was started before main() is called (in case of a Linux environment).
+This call finishes the initialization process that was started before main() is called (in the case of a Linux environment).
 The argc and argv arguments are provided to the rte_eal_init() function.
 The value returned is the number of parsed arguments.
 
-- 
2.51.0

