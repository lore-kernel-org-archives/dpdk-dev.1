Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CC4C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 135A140E4D;
	Sun, 18 Jan 2026 20:13:52 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 06E9940DC9
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:50 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-652fec696c9so6406660a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763629;
 x=1769368429; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKqtwFd9FRY9qHbu+78H+jfKAnv3rUfL7B0UEvvop70=;
 b=yeSn8APKIN/7lYSLbYKhhjwLNyCO8lhEsCLQYUk78hZsSLGAj7+6yAYR5OvXR/OenE
 OIxl81RKgUYgJ50uhEjHFEb44kgBZT83idhxa2JENHEdPadmg0qdFfKP7srOP3YmthMF
 tPNP7NronQGd64vxEomTMW7e/iuaAlIG3/Mkd0L20FI+7uZq5uo7wNlcLIhOE9vNySHH
 nwDVSPUY8abwEjGE2808zkY5/UWUTL5P4StFN43yoIqAOoZqFAzk6tprhBSyx7UxLGGI
 DX5VXEYK2GhH5adBpWO9ESKpW1PC1Yvp3Cspzd84XlkJLOTynK97aRRVlTpk1TjD5veX
 9QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763629; x=1769368429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKqtwFd9FRY9qHbu+78H+jfKAnv3rUfL7B0UEvvop70=;
 b=i/45TDbV7Gg7LgTOmCXOi6GQTwPARkaFf3Xbk1QGIP5Uy/FVszFnC1nuuRjpFLB5MD
 W3HyzxNEWxZ+RpvzPnteGxzlOBAcAfECEAW0e7azBH2eF1TtlfiWs/T+raOrYRs0941D
 MHl1Ex8rFFaRUEnix9DrIGqE3lmx+LqWDyu/ti60l/fRFRp0ViAxis6gED2hNDD11mJt
 DEYAy43sQgdhFc1LYodHyenJoDsEBhMIrrSE83zCG+x4j2yDCGcm5HlvJX6kuGpnljKy
 J77gch+Cb4Cvb4GrUsojFiSa3aTQc35MMV5Owr3C6sirNAjEcfX96gViaBTjQA/fLafs
 svrw==
X-Gm-Message-State: AOJu0YwVt8H0MYPezuo7fZdgKw574WBtNv1+U3zwQOr+RQl9zWSlhQIK
 TRqgcM8gTAXS+kEg8452QfovFVa6+aXRy7Of1bTq2uo0K/YsXJiXIKpszzj0HJOwUsQSY5rj6C4
 mvB0v
X-Gm-Gg: AY/fxX7k42HbUjKifUF4dOyFMGot8x50Rk6I1YVpXryK+yULlNhGtfrdN+WN1cRvt9w
 9LrIXO2S8etf2q79iXwrkst4QjDmTa94D3gDo34LnYxLE1A2ulLyohnYPHr/TifFsWnB4KDijd5
 xhiTIciVFQy19/uFIX03h/DP3xa2qkdggy8AKXXkPulmakErVfmHHTm61mGBST2FY0Tl+acB58R
 YiUlkuxec0MWX5r2R7EJANdWLNQrepmmifXxGR+pF6Q/imuDXwG+066bP5PzL9oxcGvtFFO9kv2
 QeI7iYVEd3Xqm5YyTII/p0ynqKWrYFT4DrRpzbt2dbGnVuCh5l3jhWm9ZAx1q8BN0e4PV6TGzVa
 N5SqDaCDA3VEY0zMPMSKlW6/8TeWxF5VpsodEc0O4mRgWjVoccvFaDRVOyT4FYuSFwhMXBo2wzY
 WJlcj4Y8BE5cuLpZ2WbINOiZ9Xu+Z9BLdd4wcvubcWBClRA7QhnkJQPHir+65g
X-Received: by 2002:a17:907:961d:b0:b87:3174:9bdd with SMTP id
 a640c23a62f3a-b8792dc8011mr833837266b.28.1768763629558; 
 Sun, 18 Jan 2026 11:13:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 13/54] doc: correct grammar and typos in cryptodev guide
Date: Sun, 18 Jan 2026 11:10:16 -0800
Message-ID: <20260118191323.241013-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Correct several documentation issues:
- Change possessive forms: "device's queue pair", "queue pair's resources"
- Change typo "the same other different" to "the same or different"
- Change "PMDs supports" to "PMDs support"
- Change "Queues Pair" to "Queue Pair" in section title
- Change "library support NUMA" to "library supports NUMA"
- Change "Global devices features" to "Global device features"
- Remove extra space in "are defined"
- Change "Sessions typically stores" to "Sessions typically store"
- Change "a optimal" to "an optimal"
- Add required blank line before bullet list

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/cryptodev_lib.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/doc/guides/prog_guide/cryptodev_lib.rst b/doc/guides/prog_guide/cryptodev_lib.rst
index f0ee44eb54..dcf3323c9e 100644
--- a/doc/guides/prog_guide/cryptodev_lib.rst
+++ b/doc/guides/prog_guide/cryptodev_lib.rst
@@ -108,9 +108,9 @@ parameters for socket selection and number of queue pairs.
 Configuration of Queue Pairs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Each Crypto devices queue pair is individually configured through the
+Each Crypto device's queue pair is individually configured through the
 ``rte_cryptodev_queue_pair_setup`` API.
-Each queue pairs resources may be allocated on a specified socket.
+Each queue pair's resources may be allocated on a specified socket.
 
 .. code-block:: c
 
@@ -127,14 +127,14 @@ Each queue pairs resources may be allocated on a specified socket.
 
 The field ``mp_session`` is used for creating temporary session to process
 the crypto operations in the session-less mode.
-They can be the same other different mempools. Please note not all Cryptodev
-PMDs supports session-less mode.
+They can be the same or different mempools. Please note not all Cryptodev
+PMDs support session-less mode.
 
 
-Logical Cores, Memory and Queues Pair Relationships
+Logical Cores, Memory and Queue Pair Relationships
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The Crypto device Library as the Poll Mode Driver library support NUMA for when
+The Crypto device Library as the Poll Mode Driver library supports NUMA for when
 a processor’s logical cores and interfaces utilize its local memory. Therefore
 Crypto operations, and in the case of symmetric Crypto operations, the session
 and the mbuf being operated on, should be allocated from memory pools created
@@ -161,7 +161,7 @@ Device Features and Capabilities
 ---------------------------------
 
 Crypto devices define their functionality through two mechanisms, global device
-features and algorithm capabilities. Global devices features identify device
+features and algorithm capabilities. Global device features identify device
 wide level features which are applicable to the whole device such as
 the device having hardware acceleration or supporting symmetric and/or asymmetric
 Crypto operations.
@@ -191,7 +191,7 @@ Device Operation Capabilities
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Crypto capabilities which identify particular algorithm which the Crypto PMD
-supports are  defined by the operation type, the operation transform, the
+supports are defined by the operation type, the operation transform, the
 transform identifier and then the particulars of the transform. For the full
 scope of the Crypto capability see the definition of the structure in the
 *DPDK API Reference*.
@@ -936,9 +936,9 @@ Session and Session Management
 
 Sessions are used in asymmetric cryptographic processing to store the immutable
 data defined in asymmetric cryptographic transform which is further used in the
-operation processing. Sessions typically stores information, such as, public
+operation processing. Sessions typically store information, such as, public
 and private key information or domain params or prime modulus data i.e. immutable
-across data sets. Crypto sessions cache this immutable data in a optimal way for the
+across data sets. Crypto sessions cache this immutable data in an optimal way for the
 underlying PMD and this allows further acceleration of the offload of Crypto workloads.
 
 Like symmetric, the Crypto device framework provides APIs to allocate and initialize
@@ -993,6 +993,7 @@ public generation. Also, currently API does not support chaining of symmetric an
 asymmetric crypto xforms.
 
 Each xform defines specific asymmetric crypto algo. Currently supported are:
+
 * RSA
 * Modular operations (Exponentiation and Inverse)
 * Diffie-Hellman
-- 
2.51.0

