Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C861C369B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 08:56:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1E7A402C5;
	Mon, 14 Apr 2025 10:56:12 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 09FD1402A9
 for <dev@dpdk.org>; Mon, 14 Apr 2025 10:56:11 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E6751114015A;
 Mon, 14 Apr 2025 04:45:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 04:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm2; t=1744620344; x=1744706744; bh=rO5tqFxhHfzLh8/48szVC
 0EGjfwirLyD2VRrerwqHiA=; b=aMB8374JrvGtQDdo1RT2NnGzNeyAceKxo2nuI
 CC3QPIiPeA0pQnlDHjhcOTqZDttpiOs/xbkTsVz+mODmYi1JVSSW8LiGtyQIB0/v
 YpwzhpRw1up3BXXWH+O6KkO9flpcY/N7B9GU+Un1dCD5zDNa+dUFH746uDKB4Lk3
 UQ+je3Hm2ko0XxjRV1Dfg3yqBNfIVAMzECyxoUv6QWvRgHcbbtKdPc+Be4o6g4g3
 woUUFt+eVqvjq+tazBgFu983bDYq8DWSGj8MosNiTTaGNO2IYdmpIcwoSqcL9Jrl
 SdgeOdKat5f0kQ16B9DWJDEoJJxWPBl/V1/kKGuw8fhG5ofBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1744620344; x=1744706744; bh=rO5tqFxhHfzLh8/48szVC0EGjfwirLyD2VR
 rerwqHiA=; b=II3/KaVjF503WKgOWI8zR8xZSgq0rwKseYLNnSCIaz3gSxzvVHA
 TEtAexKvZUrDUlOa4UfWc3jSYAMdQOW3O2cQn5gCaoDoiQeOALCv8GROUdPotav7
 mVvsWAvFrXy3GL3Up6OSExMYcrQQFUHtHHLVHOmai+1OKBpthFTS39fjwLG334jq
 zYMUaKfBbtCYfTL51ye/FhAPdgHvq3d8wISso5AJarpdXGUz6tiSSByLAAuDPptM
 3DdihAGZtn1FznVZOc/qElTQWycX+tKf8gbzyS98Y4dqY5oP8KK9BMJwuGsRL82Q
 EQs/lFBa0CseZycpdo/v7/6K2jiIU6252fw==
X-ME-Sender: <xms:OMv8Z3qG77xCM4NZ-K68Fnh-klu60tTd-2PT-GGZX-SHj6_BITP7MQ>
 <xme:OMv8Zxr6O7F_OrtfZK2qjy7f15yrpZZmv9G0wkBr7s6wlN0c1nU1Iyo3cc2vYFulR
 pajty8XL1HgS-CHmA>
X-ME-Received: <xmr:OMv8Z0MxlWwNZLb_fKJE8NFZ9-0K-SyfXMrFxKkG8IVgY3FNEE-zjNISx0jve6DiIxZj1cVohiHy95t2p4RyzCdELuYz9X4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtudduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 fufffkofgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhho
 nhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpe
 dvledvudehvdduudevuedvveehgeduleegiefgjeehudehtddtgeduffejiefhgfenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrsh
 esmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:OMv8Z66Xbw4wkk1SRDB9W1yMMs9z4_be6CAd2q98UKBoGODSe50itA>
 <xmx:OMv8Z26tdVwcWKfA7qkhTYEwE2usDY3rylMKqzYOaUOprXzQ5ZWJlw>
 <xmx:OMv8ZyhIOt5zyGLOo6ok32Ghw36SvKYrkosnD83Uux4yWlo7pnhwRA>
 <xmx:OMv8Z446IqOWZQ-W54WYyP0H0cpHAzcYNX1Ud-ZPAQvoARG5Pi6JjQ>
 <xmx:OMv8Z9Y-YH67UbXRevsThfCHWb9ylF1412rDenTPlQn1zyvSCc7Bioyx>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Mon, 14 Apr 2025 04:45:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH] doc: reduce index depth of most guides
Date: Mon, 14 Apr 2025 10:45:30 +0200
Message-ID: <20250414084531.1759703-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

The guides having a diverse list of multiple drivers or tools
are easier to browse with an index limited
to the first headings (depth 1).

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/bbdevs/index.rst        | 2 +-
 doc/guides/compressdevs/index.rst  | 2 +-
 doc/guides/cryptodevs/index.rst    | 2 +-
 doc/guides/dmadevs/index.rst       | 2 +-
 doc/guides/eventdevs/index.rst     | 2 +-
 doc/guides/faq/index.rst           | 2 +-
 doc/guides/gpus/index.rst          | 2 +-
 doc/guides/howto/index.rst         | 2 +-
 doc/guides/mempool/index.rst       | 2 +-
 doc/guides/mldevs/index.rst        | 2 +-
 doc/guides/nics/index.rst          | 2 +-
 doc/guides/platform/index.rst      | 2 +-
 doc/guides/rawdevs/index.rst       | 2 +-
 doc/guides/regexdevs/index.rst     | 2 +-
 doc/guides/sample_app_ug/index.rst | 2 +-
 doc/guides/tools/index.rst         | 2 +-
 doc/guides/vdpadevs/index.rst      | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/doc/guides/bbdevs/index.rst b/doc/guides/bbdevs/index.rst
index 269157d77f..d833bbeff0 100644
--- a/doc/guides/bbdevs/index.rst
+++ b/doc/guides/bbdevs/index.rst
@@ -5,7 +5,7 @@ Baseband Device Drivers
 =======================
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     overview
diff --git a/doc/guides/compressdevs/index.rst b/doc/guides/compressdevs/index.rst
index bab226ffbc..4dcc7d3831 100644
--- a/doc/guides/compressdevs/index.rst
+++ b/doc/guides/compressdevs/index.rst
@@ -6,7 +6,7 @@ Compression Device Drivers
 
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     overview
diff --git a/doc/guides/cryptodevs/index.rst b/doc/guides/cryptodevs/index.rst
index 1e57a9fe86..5ddfc46a63 100644
--- a/doc/guides/cryptodevs/index.rst
+++ b/doc/guides/cryptodevs/index.rst
@@ -6,7 +6,7 @@ Crypto Device Drivers
 
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     overview
diff --git a/doc/guides/dmadevs/index.rst b/doc/guides/dmadevs/index.rst
index ce9f6eb260..15ddaf5192 100644
--- a/doc/guides/dmadevs/index.rst
+++ b/doc/guides/dmadevs/index.rst
@@ -8,7 +8,7 @@ The following are a list of DMA device drivers, which can be used from
 an application through DMA API.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
    :numbered:
 
    cnxk
diff --git a/doc/guides/eventdevs/index.rst b/doc/guides/eventdevs/index.rst
index eed19ad28c..69a5ebf812 100644
--- a/doc/guides/eventdevs/index.rst
+++ b/doc/guides/eventdevs/index.rst
@@ -8,7 +8,7 @@ The following are a list of event device PMDs, which can be used from an
 application through the eventdev API.
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     overview
diff --git a/doc/guides/faq/index.rst b/doc/guides/faq/index.rst
index a9ae9bddd4..191953e940 100644
--- a/doc/guides/faq/index.rst
+++ b/doc/guides/faq/index.rst
@@ -7,7 +7,7 @@ FAQ
 This document contains some Frequently Asked Questions that arise when working with DPDK.
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     faq
diff --git a/doc/guides/gpus/index.rst b/doc/guides/gpus/index.rst
index 4b7a420556..bc82ae3be2 100644
--- a/doc/guides/gpus/index.rst
+++ b/doc/guides/gpus/index.rst
@@ -5,7 +5,7 @@ General-Purpose Graphics Processing Unit Drivers
 ================================================
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
    :numbered:
 
    overview
diff --git a/doc/guides/howto/index.rst b/doc/guides/howto/index.rst
index ee80849e7b..c9117a0fe4 100644
--- a/doc/guides/howto/index.rst
+++ b/doc/guides/howto/index.rst
@@ -5,7 +5,7 @@ HowTo Guides
 ============
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     af_xdp_dp
diff --git a/doc/guides/mempool/index.rst b/doc/guides/mempool/index.rst
index e4b6ee7d31..a731e61587 100644
--- a/doc/guides/mempool/index.rst
+++ b/doc/guides/mempool/index.rst
@@ -8,7 +8,7 @@ The following are a list of mempool PMDs, which can be used from an
 application through the mempool API.
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     cnxk
diff --git a/doc/guides/mldevs/index.rst b/doc/guides/mldevs/index.rst
index 00e7795ec1..754b3d9705 100644
--- a/doc/guides/mldevs/index.rst
+++ b/doc/guides/mldevs/index.rst
@@ -8,7 +8,7 @@ The following are a list of ML device PMDs,
 which can be used from an application through the ML device API.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
    :numbered:
 
    cnxk
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 10a2eca3b0..9f1bf567cb 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -5,7 +5,7 @@ Network Interface Controller Drivers
 ====================================
 
 .. toctree::
-    :maxdepth: 3
+    :maxdepth: 1
     :numbered:
 
     overview
diff --git a/doc/guides/platform/index.rst b/doc/guides/platform/index.rst
index b1ba11df73..d44cbdc8e3 100644
--- a/doc/guides/platform/index.rst
+++ b/doc/guides/platform/index.rst
@@ -7,7 +7,7 @@ Platform Specific Guides
 The following are platform specific guides and setup information.
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     bluefield
diff --git a/doc/guides/rawdevs/index.rst b/doc/guides/rawdevs/index.rst
index 804fa5365a..8d8aae0834 100644
--- a/doc/guides/rawdevs/index.rst
+++ b/doc/guides/rawdevs/index.rst
@@ -8,7 +8,7 @@ The following are a list of raw device PMDs, which can be used from an
 application through rawdev API.
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     cnxk_bphy
diff --git a/doc/guides/regexdevs/index.rst b/doc/guides/regexdevs/index.rst
index 9c88300bff..4f928f919b 100644
--- a/doc/guides/regexdevs/index.rst
+++ b/doc/guides/regexdevs/index.rst
@@ -8,7 +8,7 @@ The following are a list of RegEx (Regular Expression) device drivers,
 which can be used from an application through RegEx API.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
    :numbered:
 
    features_overview
diff --git a/doc/guides/sample_app_ug/index.rst b/doc/guides/sample_app_ug/index.rst
index 21ee35cc8b..e895f692f9 100644
--- a/doc/guides/sample_app_ug/index.rst
+++ b/doc/guides/sample_app_ug/index.rst
@@ -5,7 +5,7 @@ Sample Applications User Guides
 ===============================
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     intro
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 4f4dc8b518..8ec429ec53 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -5,7 +5,7 @@ DPDK Tools User Guides
 ======================
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     hugepages
diff --git a/doc/guides/vdpadevs/index.rst b/doc/guides/vdpadevs/index.rst
index b0191a3a1d..ddbeb6c026 100644
--- a/doc/guides/vdpadevs/index.rst
+++ b/doc/guides/vdpadevs/index.rst
@@ -8,7 +8,7 @@ The following are a list of vDPA (vHost Data Path Acceleration) device drivers,
 which can be used from an application through vhost API.
 
 .. toctree::
-    :maxdepth: 2
+    :maxdepth: 1
     :numbered:
 
     features_overview
-- 
2.47.1

