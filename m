Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B3D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C81DB42708;
	Wed, 14 Jan 2026 23:25:37 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 6AB5842670
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:36 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so2810425e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429536;
 x=1769034336; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EIU2VfPaBd321rBTKSKqR7sYl/DQ4eUVAAiX1RduK8=;
 b=v1fHi9yGgIm09+fYrnF86wu5kAZozN3y2P4GVwXPt7ta2BtXKGkkDGZ4cg9oymzTa+
 oEUptDpFxNz3tTUwfJhpcCPRNBGGKhbbhzYrFcJQSGwMZ1oHX7weGhNcJYWpQMFwb4Wx
 811k6ysB0d1gT740B7kI0WsmdrEOOD4W8mk2q4SKu/PG+KLps6Fe15IA/APiM7AcKexe
 KcqEBNlT1eL0ithm5FRK4vnESc2wNTNHpVgSz079spbDtmPNq6+rDbEALEjpnX4ncawg
 1WRPXIbP7rYvEtsU5+VBEM2R7ilB9vXe3LJjRPQOms9ad3k6Y+YAAccNaseH98xWCXa6
 YnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429536; x=1769034336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1EIU2VfPaBd321rBTKSKqR7sYl/DQ4eUVAAiX1RduK8=;
 b=FC76fqzXvroo1BIC3FlFSq15FV2oHcMOZbUerMexNaoSwPeT8oMctFvTt8rmEC7GiE
 IG+afgVf5TXtfCVXF+Tqc7/8Qe/P1mXRTk91iRWIaRvyaMstLXAl/nASg2FHWdhjxSAT
 AqMDT14MDda/yP7eOkFYINDlcHuQqpyWSRhAHrRZ0SEvq/+KXDQa0t9UszYCWHc4SP2F
 twlNVf+3Cm2WYbnMk45ls86kAXAn0Wc/ws+Cl0BewJxOM7Ht5AM6a3Tne/5Br+5lnLqz
 FRe/vhq0tGgeRZrZSgLHC1x8F8PcYTylyVw2TeG03VyklUrzem6S6ReBhlariP+B4PHO
 956w==
X-Gm-Message-State: AOJu0YyF4ZHFzBcoXTCQPxS+jVqYB3YfuN7KEslOIzuQ4imifh9I4eCV
 qq05p8E0e6M1LMtzGIAgUjMJwbxmfY00WLQOtxtbt/F+7bcjl7pXwvNNnZ1oXmI8kqDKiUjqp4T
 88tH3
X-Gm-Gg: AY/fxX4ZJW4JkvsTJlnE54ODObAJuNXOdUOy96Ar1i2mimGd7CLglg1A7JnCoT3JsN0
 BoQaqWkzIf/5eumArY4XqMh77lguIoq5cWB/pvbMcKeZV6qdKrYlx4Ny69evDqsXAbTHsD+Snfn
 quH2pcABIf7k6k4JCcPc+kUC/vDISNWNv4xHJ7UnEtvsslg5qeL+Tve9qjh+fCvbcdn5uJlZKZL
 0SYSZzi+H/LiEiK5i2DIx3xv+7CYPTQSwP/0NsmPw3ecNxabjHGzqVPQ109PVdhqiux0FMRNDoF
 K/rD9qf4zm2FYmhBONJ7xA9M3BKEtB/8fOQk5kEP7XX0NF/s/yco3Nx3eP28big3ZJQA+cuYFb/
 cjwx9QS56Vu0fC2vrwjB8XclJ7tKx+DNdZr7SjCbFk/z/xZcBMXh9KovDgfjkgw5MapKNg/N6HL
 S8Br5zeYoG7eM4DXkQSD8VBtWvvVD+1prmjm6rHp/W/xiGa24+nA==
X-Received: by 2002:a05:600c:c16a:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-47ee3311616mr44689185e9.12.1768429535893; 
 Wed, 14 Jan 2026 14:25:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 19/29] doc/guides: improve sample applications introduction
Date: Wed, 14 Jan 2026 14:22:00 -0800
Message-ID: <20260114222458.87119-20-stephen@networkplumber.org>
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

Improve the sample applications introduction documentation:
- use consistent title capitalization in cross-references
- replace contractions with full forms
- use I/O instead of IO
- fix punctuation and grammar

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/intro.rst | 54 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/doc/guides/sample_app_ug/intro.rst b/doc/guides/sample_app_ug/intro.rst
index a19c0b8c13..25a15966db 100644
--- a/doc/guides/sample_app_ug/intro.rst
+++ b/doc/guides/sample_app_ug/intro.rst
@@ -4,8 +4,8 @@
 Introduction to the DPDK Sample Applications
 ============================================
 
-The DPDK Sample Applications are small standalone applications that
-demonstrate various features of DPDK. They can be considered as a cookbook of
+The DPDK sample applications are small standalone applications that
+demonstrate various features of DPDK. They can be considered a cookbook of
 DPDK features. Users interested in getting started with DPDK can take the
 applications, try out the features, and then extend them to fit their needs.
 
@@ -14,8 +14,8 @@ Running Sample Applications
 ---------------------------
 
 Some sample applications may have their own command-line parameters described in
-their respective guides. However, they all also share the same EAL parameters.
-Please refer to :doc:`EAL parameters (Linux) <../linux_gsg/linux_eal_parameters>`
+their respective guides. However, they also all share the same EAL parameters.
+Refer to :doc:`EAL parameters (Linux) <../linux_gsg/linux_eal_parameters>`
 or :doc:`EAL parameters (FreeBSD) <../freebsd_gsg/freebsd_eal_parameters>` for
 a list of available EAL command-line options.
 
@@ -32,8 +32,8 @@ examples are highlighted below.
 * :doc:`Hello World<hello_world>`: As with most introductions to a
   programming framework, a good place to start is with the Hello World
   application. The Hello World example sets up the DPDK Environment Abstraction
-  Layer (EAL), and prints a simple "Hello World" message to each of the DPDK
-  enabled cores. This application doesn't do any packet forwarding, but it is a
+  Layer (EAL) and prints a simple "Hello World" message to each of the DPDK
+  enabled cores. This application does not do any packet forwarding, but it is a
   good way to test if the DPDK environment is compiled and set up properly.
 
 * :doc:`Basic Forwarding/Skeleton Application<skeleton>`: The Basic
@@ -41,25 +41,25 @@ examples are highlighted below.
   basic packet forwarding with DPDK. This allows you to test if your network
   interfaces are working with DPDK.
 
-* :doc:`Network Layer 2 forwarding<l2_forward_real_virtual>`: The Network Layer 2
-  forwarding, or ``l2fwd`` application does forwarding based on Ethernet MAC
+* :doc:`Network Layer 2 Forwarding<l2_forward_real_virtual>`: The Network Layer 2
+  forwarding, or ``l2fwd`` application, does forwarding based on Ethernet MAC
   addresses like a simple switch.
 
-* :doc:`Network Layer 2 forwarding<l2_forward_event>`: The Network Layer 2
-  forwarding, or ``l2fwd-event`` application does forwarding based on Ethernet MAC
-  addresses like a simple switch. It demonstrates usage of poll and event mode
-  IO mechanism under a single application.
+* :doc:`Network Layer 2 Forwarding with Event Mode<l2_forward_event>`: The Network
+  Layer 2 forwarding, or ``l2fwd-event`` application, does forwarding based on
+  Ethernet MAC addresses like a simple switch. It demonstrates usage of poll and
+  event mode I/O mechanisms under a single application.
 
-* :doc:`Network Layer 3 forwarding<l3_forward>`: The Network Layer3
-  forwarding, or ``l3fwd`` application does forwarding based on Internet
-  Protocol, IPv4 or IPv6 like a simple router.
+* :doc:`Network Layer 3 Forwarding<l3_forward>`: The Network Layer 3
+  forwarding, or ``l3fwd`` application, does forwarding based on Internet
+  Protocol (IPv4 or IPv6) like a simple router.
 
-* :doc:`Network Layer 3 forwarding Graph<l3_forward_graph>`: The Network Layer3
-  forwarding Graph, or ``l3fwd_graph`` application does forwarding based on IPv4
-  like a simple router with DPDK Graph framework.
+* :doc:`Network Layer 3 Forwarding Graph<l3_forward_graph>`: The Network Layer 3
+  forwarding Graph, or ``l3fwd_graph`` application, does forwarding based on IPv4
+  like a simple router using the DPDK Graph framework.
 
-* :doc:`Hardware packet copying<dma>`: The Hardware packet copying,
-  or ``dmafwd`` application demonstrates how to use DMAdev library for
+* :doc:`Hardware Packet Copying<dma>`: The hardware packet copying,
+  or ``dmafwd`` application, demonstrates how to use the DMAdev library for
   copying packets between two threads.
 
 * :doc:`Packet Distributor<dist_app>`: The Packet Distributor
@@ -70,27 +70,27 @@ examples are highlighted below.
   multi-process application shows how two DPDK processes can work together using
   queues and memory pools to share information.
 
-* :doc:`RX/TX callbacks Application<rxtx_callbacks>`: The RX/TX
+* :doc:`Rx/Tx Callbacks Application<rxtx_callbacks>`: The Rx/Tx
   callbacks sample application is a packet forwarding application that
   demonstrates the use of user-defined callbacks on received and transmitted
-  packets. The application calculates the latency of a packet between RX
-  (packet arrival) and TX (packet transmission) by adding callbacks to the RX
-  and TX packet processing functions.
+  packets. The application calculates the latency of a packet between Rx
+  (packet arrival) and Tx (packet transmission) by adding callbacks to the Rx
+  and Tx packet processing functions.
 
 * :doc:`IPsec Security Gateway<ipsec_secgw>`: The IPsec Security
   Gateway application is a minimal example of something closer to a real world
   example. This is also a good example of an application using the DPDK
   Cryptodev framework.
 
-* :doc:`Precision Time Protocol (PTP) client<ptpclient>`: The PTP
+* :doc:`Precision Time Protocol (PTP) Client<ptpclient>`: The PTP
   client is another minimal implementation of a real world application.
   In this case, the application is a PTP client that communicates with a PTP
   time transmitter to synchronize time on a Network Interface Card (NIC) using the
-  IEEE1588 protocol.
+  IEEE 1588 protocol.
 
 * :doc:`Quality of Service (QoS) Scheduler<qos_scheduler>`: The QoS
   Scheduler application demonstrates the use of DPDK to provide QoS scheduling.
 
 There are many more examples shown in the following chapters. Each of the
-documented sample applications show how to compile, configure and run the
+documented sample applications shows how to compile, configure, and run the
 application, as well as explaining the main functionality of the code.
-- 
2.51.0

