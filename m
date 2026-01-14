Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A4D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21BE040E2A;
	Wed, 14 Jan 2026 23:25:09 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 207B540E21
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:07 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso604695e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429507;
 x=1769034307; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTCe801zeteOgrr93+hOzRMmDVZYQLdANAcGue6sNtE=;
 b=HgKF1/iUK6l3OPmLPz7DSQ0nPXnKl2ZzRq+j2mUV5U40npIXY/BujC76NaHaMAQFSo
 rIxUpxV0pqPNkM76u9jUoPzaWqiqKA2J3WdG1usWybxgVz8LHSsnJBnW/ljfLYTvyLO9
 sXaurdS4IVbyV1e78mPtFzlyVPUDtyfsBKdL9ks+iUK0yIi581iCYD3l28XyP37q+AcU
 4h4FJo4ppdyDygRnNF8+41qKv7RXQZP+yF8ZCWwbyVr4dnvcI6ePMWJ6of7oNHCpHZGm
 TyGUdfm2U+QURb++izRe1SQlLG/Sak8pRCc8nky/r5EHI0E1Paoxs/JhhvlQ1P0abDYb
 I1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429507; x=1769034307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wTCe801zeteOgrr93+hOzRMmDVZYQLdANAcGue6sNtE=;
 b=ZKRmRt9DdsAnDtc4izP8Fj8FqDt1wY9pRo0bSizeLjz23h4I6Jtn0bCfX1vF4CQebc
 9vFMzPXOl7oZVozGlWLXqH+G0YvLC+43WuJNcx0KiYJ11gbZobrLWRfFDJFB+DTb9up9
 k7FLf5knPbTNkFT5xydy6wOmPq3VXoz3lOzGkyihrihFpUOV13rX7nW7Lf58EU/++74m
 iLm8bsiaZ31lZ4p22JOp/Ucu5uXfmvoG59/3Gt9RgpOOB/A8xuyseqNB3FsKP8draIsf
 7pFgkXFclfr4wftfFZws7sTaxdd4ofYuawK6M+m2FgmJCw3eZSY0X65VRffPvEBdIGag
 EI2w==
X-Gm-Message-State: AOJu0YyPOeEVo4Q5TTJxAfpdeYLZE6pWj+Zt95YTKxh/qClJyI3K79qw
 /evYE1uQiusbT5/99KlFFbXKEgX93FiDuTh5aoipzW0MaNy1YL+roGH2W40oXZfiQ18kIFoLhXq
 xHnA99J4=
X-Gm-Gg: AY/fxX4nXaib62AZig6VgB4yWnVRQYZ3BdY0SfXvF7Qngbb4tlBSivMLvLm5icxhJYG
 8/sUv/IjYni1/eKF4uv2p2zXVZyGbbhPwCztFibynpRGNjRqg4HnK6e0lMbkPsA39ZPsz1ena9U
 f0CYasRgOqdlmcpGDG884bCNsL0zSlGbrFhLHnTsJjFzPaFVDbrbllFkCOPWSK4g3htcuwwV8AT
 5aiU/xu2z/Kqm2HW9mNa93h46mp3ML0WZmA/t+AxPkKMoI3yIkgUdBZxHx3tlgoX7Ac6uzV2PMW
 RsylN/WC+dKo4QQ4RENXKb5cv0EwuLEu2vOOSMFOykyj71OYo/E2IXOIlB6fEcfDcxq7lm9IGRr
 V5X4O9m/MlEWnXwCB1Q/bLZF0A1G+ZtwkaG4ZZjuQHj5sNLJIeKv3Fyopw3btSSHlS4mExlgQTp
 PZLlF67NVgNw4Hw0n/rRkcj28n5cS8WmqdW8Z+5xjGayy9vrupew==
X-Received: by 2002:a05:600c:8215:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-47ee8c29176mr27709115e9.8.1768429506693; 
 Wed, 14 Jan 2026 14:25:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH 02/29] examples/packet_ordering: correct documentation errors
Date: Wed, 14 Jan 2026 14:21:43 -0800
Message-ID: <20260114222458.87119-3-stephen@networkplumber.org>
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

Address grammar and clarity issues in packet ordering sample documentation:
- Change "enables output the" to "enables output of the"
- Clarify port mask description from "either 1 or even enabled port
  numbers" to "either 1 or an even number of enabled ports"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/packet_ordering.rst | 23 +++++++++++---------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/doc/guides/sample_app_ug/packet_ordering.rst b/doc/guides/sample_app_ug/packet_ordering.rst
index f96c0ad697..057dd932d4 100644
--- a/doc/guides/sample_app_ug/packet_ordering.rst
+++ b/doc/guides/sample_app_ug/packet_ordering.rst
@@ -4,29 +4,29 @@
 Packet Ordering Application
 ============================
 
-The Packet Ordering sample app simply shows the impact of reordering a stream.
-It's meant to stress the library with different configurations for performance.
+The Packet Ordering sample application shows the impact of reordering a stream.
+It is meant to stress the library with different configurations for performance.
 
 Overview
 --------
 
 The application uses at least three CPU cores:
 
-* RX core (main core) receives traffic from the NIC ports and feeds Worker
+* The RX core (main core) receives traffic from the NIC ports and feeds Worker
   cores with traffic through SW queues.
 
-* Worker (worker core) basically do some light work on the packet.
-  Currently it modifies the output port of the packet for configurations with
+* The Worker (worker core) does some light work on the packet.
+  Currently, it modifies the output port of the packet for configurations with
   more than one port enabled.
 
-* TX Core (worker core) receives traffic from Worker cores through software queues,
+* The TX Core (worker core) receives traffic from Worker cores through software queues,
   inserts out-of-order packets into reorder buffer, extracts ordered packets
   from the reorder buffer and sends them to the NIC ports for transmission.
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``packet_ordering`` sub-directory.
 
@@ -36,6 +36,9 @@ Running the Application
 Refer to *DPDK Getting Started Guide* for general information on running applications
 and the Environment Abstraction Layer (EAL) options.
 
+Explanation
+-----------
+
 Application Command Line
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -50,12 +53,12 @@ The -l EAL corelist option has to contain at least 3 CPU cores.
 The first CPU core in the core mask is the main core and would be assigned to
 RX core, the last to TX core and the rest to Worker cores.
 
-The PORTMASK parameter must contain either 1 or even enabled port numbers.
+The PORTMASK parameter must contain either 1 or an even number of enabled ports.
 When setting more than 1 port, traffic would be forwarded in pairs.
 For example, if we enable 4 ports, traffic from port 0 to 1 and from 1 to 0,
 then the other pair from 2 to 3 and from 3 to 2, having [0,1] and [2,3] pairs.
 
-The disable-reorder long option does, as its name implies, disable the reordering
+The disable-reorder long option, as its name implies, disables the reordering
 of traffic, which should help evaluate reordering performance impact.
 
-The insight-worker long option enables output the packet statistics of each worker thread.
+The insight-worker long option enables output of the packet statistics of each worker thread.
-- 
2.51.0

