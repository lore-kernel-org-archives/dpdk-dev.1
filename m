Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEF3C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5327442D9D;
	Sun, 18 Jan 2026 20:14:27 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id EF82342D26
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:24 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so5296265a12.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763664;
 x=1769368464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPIb96oVwaZt3kLEdSG6WT1jK0ZdmENEbD6xiJzZ8gE=;
 b=xAnNVv9TCY+mTEVWqkT7KeuWQxyr9xGvX5CDdaojBSftndQOKIpKmgcQ8Mi4FmSQbh
 1vfB/YZLcG/D1VMNYZBw6OB9hFiqK4OTv7DaH+1ry0RXLrlLDIfyvDsv3SKygadvHkd3
 YkotchY4s7b+nN6zpJUdZJKq1BxtVT5KCg6xQe5tlObtpvN6g19oq+ZQyjhiAMo95awD
 K4cTCkoK+D6AtFJMWVDIRgrRyEJRySS+u2W9rFrr84YGHNSfFh+nfblwGisoinzx61t4
 zn4BE+lcjd+IyGER1v8ao6L+wmNPAgR/cnWKoCrKhwi9c30XU3ncAPuz6j87eps97KIq
 Rjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763664; x=1769368464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fPIb96oVwaZt3kLEdSG6WT1jK0ZdmENEbD6xiJzZ8gE=;
 b=SmQHlIbnf4ZxkU4HHVcxpHSP3FHrdZO3lwtjH3pzOQR+pWshEBQOZOwlB6bLwl8tEu
 RD8+EZjlwvb1CKdlIHr3lvCrAFrOV9xBlGdoFGAsPUqVDAjfk9s6U4n6bv0xt+vUnBFn
 OuPEeru7Zv/9jHKAD88D69D2wvMwSzztDHBddWlkAcM+RtRZ8X1hWmZc1I2UUApJR7Ym
 WYzqc4tg2TSmrW5+YbZE9Qr+7sP6X5OOj1XfLOlEAvQf8osQM4CBrNHoXKUCmVEiSNmZ
 F6LfnRl7PKHyMAQ+z/TbQwI10umBXXgCcUtkb0EKIkQ+vGGDPtrAZ7G42PUcTtThgE9R
 PtMg==
X-Gm-Message-State: AOJu0YymRga4azp3l2uIy45Cy3SLwgj6uq4pKgQvnFuBHo0yf4u7AF3P
 d4k1O9uXe5GAeUtzCObx7yrA+uBLsvfNsYHcSuyw7gY4NT8njwVFhJCDu6V1O1ex34fl8mqzdDb
 obi22
X-Gm-Gg: AY/fxX4KVnuQLBxeaqjR/5o65oNg8zoa78LFvwftjwt521Xdop68YK++WluEDsP1biZ
 V7x6fj5tWVkftXmTLdG9hUIXU/xXmB8kByYnNIzHBa2SEN+qcKJqiz3i5Payy8wQDCWhstGOC8B
 AInwVIvTYkfKWiy2uMNgDbbCYjvbl/jAd2RNnM+rAnq1mmNyZcmRm4r7dQoMtE2cR+yeiPYXELK
 eshFsCJFnZExwsswrgcXdlGPb+ILOxKqXh09K/havo7p12A2z3vXnpAmbQbQ6Q9Z+fYvcaK/G0A
 HKWISPYvcnByc+pZqjyl+oKdf5ACIGawGOSniuQUzVMmNj2e9RF0KU7cmRLWRsLeAi70rL9Do6r
 cHNl2CC0S4Zy+F4cDtsPJK3LH5/UUjmUf5AdNITj0glLt4v9SODqIg0kVbUNT2o2GYOSrk7p6TI
 ugfmgoU9CHNcBTo5iGVITao6+YovafzBLRHPKEDfp8fasSMnx/eA==
X-Received: by 2002:a17:907:743:b0:b83:8fc:c64b with SMTP id
 a640c23a62f3a-b879300a356mr753923466b.38.1768763664440; 
 Sun, 18 Jan 2026 11:14:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 36/54] doc: correct grammar in mldev library guide
Date: Sun, 18 Jan 2026 11:10:39 -0800
Message-ID: <20260118191323.241013-37-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct various grammar and style issues in the ML device library
documentation:

- fix subject-verb agreement for "API which supports"
- use compound word "Workflow" instead of "Work flow"
- fix parallel construction for model load and start
- use plural "feature sets"
- rewrite grammatically broken sentence about rte_ml_dev_info_get
- add missing article before "number of queue pairs"
- use consistent terminology "operations" not "packets"
- fix malformed sentence about dequeue API format
- add missing word "with" in quantize section

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/mldev.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/prog_guide/mldev.rst b/doc/guides/prog_guide/mldev.rst
index 61661b998b..094a67cbdb 100644
--- a/doc/guides/prog_guide/mldev.rst
+++ b/doc/guides/prog_guide/mldev.rst
@@ -6,7 +6,7 @@ Machine Learning (ML) Device Library
 
 The Machine Learning (ML) Device library provides a Machine Learning device framework for the management and
 provisioning of hardware and software ML poll mode drivers,
-defining an API which support a number of ML operations
+defining an API which supports a number of ML operations
 including device handling and inference processing.
 The ML model creation and training is outside of the scope of this library.
 
@@ -16,7 +16,7 @@ The ML framework is built on the following model:
 
 .. figure:: img/mldev_flow.*
 
-   Work flow of inference on MLDEV
+   Workflow of inference on MLDEV
 
 ML Device
    A hardware or software-based implementation of ML device API
@@ -28,7 +28,7 @@ ML Model
    required to make predictions on live data.
    Once the model is created and trained outside of the DPDK scope,
    the model can be loaded via ``rte_ml_model_load()``
-   and then start it using ``rte_ml_model_start()`` API function.
+   and then started using ``rte_ml_model_start()`` API function.
    The ``rte_ml_model_params_update()`` can be used to update the model parameters
    such as weights and bias without unloading the model using ``rte_ml_model_unload()``.
 
@@ -79,9 +79,9 @@ Each device, whether virtual or physical is uniquely designated by two identifie
 Device Features and Capabilities
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-ML devices may support different feature set.
-In order to get the supported PMD feature ``rte_ml_dev_info_get()`` API
-which return the info of the device and its supported features.
+ML devices may support different feature sets.
+To get the supported PMD features, use the ``rte_ml_dev_info_get()`` API,
+which returns the info of the device and its supported features.
 
 
 Device Configuration
@@ -106,7 +106,7 @@ maximum size of model and so on.
 Configuration of Queue Pairs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Each ML device can be configured with number of queue pairs.
+Each ML device can be configured with a number of queue pairs.
 Each queue pair is configured using ``rte_ml_dev_queue_pair_setup()``
 
 
@@ -162,9 +162,9 @@ to specify the device queue pair to schedule the processing on.
 The ``nb_ops`` parameter is the number of operations to process
 which are supplied in the ``ops`` array of ``rte_ml_op`` structures.
 The enqueue function returns the number of operations it enqueued for processing,
-a return value equal to ``nb_ops`` means that all packets have been enqueued.
+a return value equal to ``nb_ops`` means that all operations have been enqueued.
 
-The dequeue API uses the same format as the enqueue API of processed
+The dequeue API uses the same format as the enqueue API,
 but the ``nb_ops`` and ``ops`` parameters are now used to specify
 the max processed operations the user wishes to retrieve
 and the location in which to store them.
@@ -193,7 +193,7 @@ from a higher precision type to a lower precision type and vice-versa.
 ML library provides the functions ``rte_ml_io_quantize()`` and ``rte_ml_io_dequantize()``
 to enable data type conversions.
 User needs to provide the address of the quantized and dequantized data buffers
-to the functions, along the number of the batches in the buffers.
+to the functions, along with the number of batches in the buffers.
 
 For quantization, the dequantized data is assumed to be
 of the type ``dtype`` provided by the ``rte_ml_model_info::input``
-- 
2.51.0

