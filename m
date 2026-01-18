Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE83C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37E742E24;
	Sun, 18 Jan 2026 20:14:35 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 6AF6A42DCE
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:32 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so852478266b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763672;
 x=1769368472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEZNgmk7wI4jmUyAYoJpR+uD7GPqBxCmtubdibLnCrU=;
 b=XA86n8f/VHytsyx5+hoJLX0gA1OmlSmhjOl8u8C6GGA22pLk7v8eoXv3V9v3UBnv5U
 4LCrksLLQvUWYX2YNs3XGvpq1SXy9Oj9vCfiSIoCm5MdG/TK96TZ7S/JDl1FbrkZlaob
 q699iIr2rHIAxhXTzVdnnhuK2ruChH1nBHNIDfPTH0bFsNe+rjVvUNVpL98JF7UwkLxy
 m6cXYz+4iv5szdfcACIMHb2QCNzdm+Dk5QZ3EzrQ5EIsfEcjwWDHTblRzD9seaJtgNAZ
 Bs1umIO72WdxUyDUnrD3Ou4qC+iHOB2lwDOpApDApRwIfkjUUfj94Kbzqgb06c5UkAZd
 1Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763672; x=1769368472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEZNgmk7wI4jmUyAYoJpR+uD7GPqBxCmtubdibLnCrU=;
 b=CsCFIeKA9Z4TxJS2nJALkiAPu9hAv0dl+kQFP2/TC8EPSsWMhXvKXJEk/bWvJK1bNB
 QOOLpo1cwsW6C8iQlGVaPtnYjYXx3lTLQkgJ8pwigp+rG38tqgdupwLjvnYG18jhi+r1
 +by1yNIOqHsh2nYR985yqJWb7ffSHStDAd6g6oDZ7KcMv/XiqeD1lvqkYZwREqQ400y6
 vDcRSiFuQYvLjSIq/kV3iFA4sCpau5Pch9tFfqMdpFusC7nzBQa0E4ZLiTggaWDqM60h
 N21AEwfYxqfYrTbiKkpeUzDB7jUrwmTqqeJHsXGZTD5QMryTJoCvHKc51+9OsKbZ9IE6
 IWXw==
X-Gm-Message-State: AOJu0YwTV9Qa97AfYYHwPS30JWy8k8q3/lHcc9NVvjyGQouB0xb8vTE4
 nvn3RiOevWYmCFElXePzed0EpUuBKI6iXZBt07s2tGxxQtoyVXaFK5vA050MkH8H2Xly/rDG+96
 5+jM0
X-Gm-Gg: AY/fxX7ygkkv4y/7hoHIGSoL7CHZqMnZ7A5Du9hhM2vjq6QNKEwr6rXC8dc8cS3oC8u
 7xF00ui25DLCDpVedH0Hw6B1Bsz0IwB+d2Vusu22/xilRCQeR2wBZUXWBkt6EolAVfL+5JrQCki
 bLaRiVxBGLcSqZINRoCbif02emFbfDIK7msedA4E78Z2V6PgZNNraO1/NCdH7ffu932mwKRWKio
 oudEtybJG7cyAUTXewRIbYcuoR9bKxywTGwGQgXENFlRj7haG3UUegIOOJGy92oynW5+WjPbINj
 shLCYz+PxQQ29061NpBLvserSJM04UC+lclYgxJEKQTzgn4PJZn2PAorQ6KObwRAfeDQSELlsFE
 v6gHQjnURfcERDV24oQfd1xfJioU3qlx8+oJYv/DANvMEDKX/kYqU+cEQ2/gD1UQtGu2CJ2BBaO
 kt2At+kR5ZrVvbzln0aSClxTW4ij1W+4JTCNtbNJu7NfeTw7b6H53HRzU/gfOn
X-Received: by 2002:a17:907:26c7:b0:b87:124c:5f65 with SMTP id
 a640c23a62f3a-b87930408e9mr840037266b.51.1768763671962; 
 Sun, 18 Jan 2026 11:14:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 41/54] doc: correct grammar in packet framework guide
Date: Sun, 18 Jan 2026 11:10:44 -0800
Message-ID: <20260118191323.241013-42-stephen@networkplumber.org>
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

Correct various issues in the packet framework documentation:

- add missing article "a" in "As a result of lookup"
- fix incomplete sentence "described in." to "described below."
- fix confusing mirror/main copy swap description that had
  duplicate text and fix subject-verb agreement

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/packet_framework.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/prog_guide/packet_framework.rst b/doc/guides/prog_guide/packet_framework.rst
index 17010b07dc..cacda9add2 100644
--- a/doc/guides/prog_guide/packet_framework.rst
+++ b/doc/guides/prog_guide/packet_framework.rst
@@ -34,7 +34,7 @@ as well as providing libraries of reusable templates for the commonly used pipel
 
 The pipeline is constructed by connecting the set of input ports with the set of output ports
 through the set of tables in a tree-like topology.
-As result of lookup operation for the current packet in the current table,
+As a result of lookup operation for the current packet in the current table,
 one of the table entries (on lookup hit) or the default table entry (on lookup miss)
 provides the set of actions to be applied on the current packet,
 as well as the next hop for the packet, which can be either another table, an output port or packet drop.
@@ -106,7 +106,7 @@ Port Interface
 Each port is unidirectional, i.e. either input port or output port.
 Each input/output port is required to implement an abstract interface that
 defines the initialization and run-time operation of the port.
-The port abstract interface is described in.
+The port abstract interface is described below.
 
 .. _table_qos_20:
 
@@ -1128,7 +1128,7 @@ Mechanisms to share the same table between multiple threads:
 
 #.  **Single writer thread performing table entry add/delete operations and multiple reader threads that perform table lookup operations with read-only access to the table entries.**
     The reader threads use the main table copy while the writer is updating the mirror copy.
-    Once the writer update is done, the writer can signal to the readers and busy wait until all readers swaps between the mirror copy (which now becomes the main copy) and
+    Once the writer update is done, the writer can signal to the readers and busy wait until all readers swap between the main copy (which now becomes the mirror copy) and
     the mirror copy (which now becomes the main copy).
 
 Interfacing with Accelerators
-- 
2.51.0

