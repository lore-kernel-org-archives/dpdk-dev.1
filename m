Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934B9D46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBE8740A8A;
	Wed, 28 Jan 2026 20:47:40 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 3D3C740A77
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:36 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-435903c4040so185441f8f.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629656;
 x=1770234456; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9H6bOZyKhCAiSBJ2NERsj9bm7WTswbGQvkD5/aWgGHQ=;
 b=TmuMrpLbgVvy2FLyZ1T7HQxQXfjD4+Kwe1l52BKbWMw05rS+EsYqi6ouO0I9gSvuie
 CYGHPH0+q3f6Ia1jYc/wANkcqtpR4CHpd2Cacwr2mbgZuIB3PkelvfOI2wKfc/shiUcs
 hZutAcB76mQ0iYadkoKvAzVKGHBCF4tHMRDSOkDnTvaq8dKOIQujPmmInK55Dsa3GwjS
 /XMP5yKSrjmRl7U4WBvpNsgndlBLBMSZ31OpG0H8QRJoCnpoKQUjGzkH288c12rXwxaH
 ypJdnW4yCnYJLWHD1qOUAQEYRsc7hKEq8+fD2s0RBnlWblVPx1NGbBYwXpMu0aeBzSZ9
 2wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629656; x=1770234456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9H6bOZyKhCAiSBJ2NERsj9bm7WTswbGQvkD5/aWgGHQ=;
 b=A1zgQaujYAmcObUZCb4sYWAEFxo5s4HZ+uY7gNa7ILRTSx8ZuLNTLSj+H904mrMzH6
 VSWjD2rbaDk0CEeCXmsmPANXtuSOFAuKUPYqhiXUbZSHrIS7Ck2gW8vZAgxL5Hr6FZFz
 OhousLlSkUfj0fZQJs3SnG2hwbBcSR3jqlheSxABHDc7vuVxlNJerBkOVvmaScMUFNbJ
 Pvog0oMuVAj7hcIF4zoFBEFj5FbjePLHIi3w0HlIMZzfYTQa1MPk8Q2k/Jl7oPMrEBp6
 +sDv/ydP8VSop3Yh2v5YH/zN4g7DVJkJnGUb08+2BxceArSa2LGrUM1thH+/mI6LGSR7
 jv1w==
X-Gm-Message-State: AOJu0YzhRD6hcHltHzg/3o6gIyQuCMpflLKx/lJjlGemORmWeQnhCDJ6
 OcqtlVoZp9P0yaYjAsSIrYeh7epdF4ob0VJWTbcf9jrT3ifyT4qH4zMxPfFZAMKgkGJNROrpr1a
 2R8Tr
X-Gm-Gg: AZuq6aL6NKbyJiZp0OOGNPqO0V4Od1/5unoxecaKYleiI8ItHFCxYEBeSvrt1raP4Kh
 ohIZqPrdeeS6lHl3HhxGHcZRfKvvVcKzM5JVpfYqqOWIktt6pmtGeW00RhAfTxdZ20Q3CezwtBV
 ZN0rp1WX2PRRBf2wiiBv0MdVmP8jL8AcwVwoDpKjwtpxOUiAnmsCMmcUWwfi2TSV1W/1+rmnEm8
 qwH5Ic/kFTIl9a4fnE8hqXJvjmy1TfG7IBqPbLRjmZEy+CF3ZAvV3ZhZo2LFz+l6y+QVpUiGryM
 UoQzbXX8apUNVEXo8eodvHRHsOwL+FMFpEJ+ciTZvCptIdoXfwVw9QMQb5upAp1JE1DkpUg6Zok
 AFxPg217eFqur81jNiuR3hMstjdMSZVhQsbfLXA3Kxr+CZEQph4CQbJnmmIwzL9V93FDxpX4GNy
 Vxztb8Js4pMUpEmc03mG7UMcZ5+QWCwn3EDh/JIafChQlbTODSkQ==
X-Received: by 2002:a5d:5f49:0:b0:435:960c:5284 with SMTP id
 ffacd0b85a97d-435dd0b36d7mr10030953f8f.29.1769629655797; 
 Wed, 28 Jan 2026 11:47:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 5/8] doc: correct typos in traffic management guide
Date: Wed, 28 Jan 2026 11:46:04 -0800
Message-ID: <20260128194722.480862-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

Two documentation issues corrected:
- Remove errant asterisk from "Head Drop*"
- Remove duplicate phrase in WRED algorithm description

Correct spelling error: "Weighed" to "Weighted" for consistency with
standard industry terminology (Weighted Fair Queuing).

Correct grammar and punctuation issues:
- Add comma after "i.e." per standard usage
- Correct "does meet the needs to" to "meets the needs of"
- Add missing space before parenthesis
- Simplify awkward phrasing "In case, when"
- Add missing comma after "etc."
- Correct subject-verb agreement "APIs supports" to "APIs support"
- Remove extra space before comma in "Queuing , etc."

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../prog_guide/ethdev/traffic_management.rst  | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/traffic_management.rst b/doc/guides/prog_guide/ethdev/traffic_management.rst
index c356791a45..91c032f480 100644
--- a/doc/guides/prog_guide/ethdev/traffic_management.rst
+++ b/doc/guides/prog_guide/ethdev/traffic_management.rst
@@ -17,7 +17,7 @@ Main features:
 
 * Part of DPDK rte_ethdev API
 * Capability query API per port, per hierarchy level and per hierarchy node
-* Scheduling algorithms: Strict Priority (SP), Weighed Fair Queuing (WFQ)
+* Scheduling algorithms: Strict Priority (SP), Weighted Fair Queuing (WFQ)
 * Traffic shaping: single/dual rate, private (per node) and
   shared (by multiple nodes) shapers
 * Congestion management for hierarchy leaf nodes: algorithms of tail drop, head
@@ -30,24 +30,24 @@ Main features:
 Capability API
 --------------
 
-The aim of these APIs is to advertise the capability information (i.e critical
+The aim of these APIs is to advertise the capability information (i.e., critical
 parameter values) that the TM implementation (HW/SW) is able to support for the
-application. The APIs supports the information disclosure at the TM level, at
+application. The APIs support the information disclosure at the TM level, at
 any hierarchical level of the TM and at any node level of the specific
-hierarchical level. Such information helps towards rapid understanding of
-whether a specific implementation does meet the needs to the user application.
+hierarchical level. Such information helps for rapid understanding of
+whether a specific implementation meets the needs of the user application.
 
 At the TM level, users can get high level idea with the help of various
 parameters such as maximum number of nodes, maximum number of hierarchical
 levels, maximum number of shapers, maximum number of private shapers, type of
-scheduling algorithm (Strict Priority, Weighted Fair Queuing , etc.), etc.,
+scheduling algorithm (Strict Priority, Weighted Fair Queuing, etc.), etc.,
 supported by the implementation.
 
 Likewise, users can query the capability of the TM at the hierarchical level to
 have more granular knowledge about the specific level. The various parameters
 such as maximum number of nodes at the level, maximum number of leaf/non-leaf
-nodes at the level, type of the shaper(dual rate, single rate) supported at
-the level if node is non-leaf type etc., are exposed as a result of
+nodes at the level, type of the shaper (dual rate, single rate) supported at
+the level if node is non-leaf type, etc., are exposed as a result of
 hierarchical level capability query.
 
 Finally, the node level capability API offers knowledge about the capability
@@ -66,7 +66,7 @@ level/position in the tree. The SP algorithm is used to schedule between
 sibling nodes with different priority, while WFQ is used to schedule between
 groups of siblings that have the same priority.
 
-Algorithms such as Weighed Round Robin (WRR), byte-level WRR, Deficit WRR
+Algorithms such as Weighted Round Robin (WRR), byte-level WRR, Deficit WRR
 (DWRR), etc are considered approximations of the ideal WFQ and are therefore
 assimilated to WFQ, although an associated implementation-dependent accuracy,
 performance and resource usage trade-off might exist.
@@ -109,15 +109,14 @@ They are made available for every leaf node in the hierarchy, subject to
 the specific implementation supporting them.
 On request of writing a new packet into the current queue while the queue is
 full, the Tail Drop algorithm drops the new packet while leaving the queue
-unmodified, as opposed to the Head Drop* algorithm, which drops the packet
+unmodified, as opposed to the Head Drop algorithm, which drops the packet
 at the head of the queue (the oldest packet waiting in the queue) and admits
 the new packet at the tail of the queue.
 
 The Random Early Detection (RED) algorithm works by proactively dropping more
 and more input packets as the queue occupancy builds up. When the queue is full
 or almost full, RED effectively works as Tail Drop. The Weighted RED (WRED)
-algorithm uses a separate set of RED thresholds for each packet color and uses
-separate set of RED thresholds for each packet color.
+algorithm uses a separate set of RED thresholds for each packet color.
 
 Each hierarchy leaf node with WRED enabled as its congestion management mode
 has zero or one private WRED context (only one leaf node using it) and/or zero,
@@ -144,7 +143,7 @@ The TM APIs have been provided to support various types of packet marking such
 as VLAN DEI packet marking (IEEE 802.1Q), IPv4/IPv6 ECN marking of TCP and SCTP
 packets (IETF RFC 3168) and IPv4/IPv6 DSCP packet marking (IETF RFC 2597).
 All VLAN frames of a given color get their DEI bit set if marking is enabled
-for this color. In case, when marking for a given color is not enabled, the
+for this color. When marking for a given color is not enabled, the
 DEI bit is left as is (either set or not).
 
 All IPv4/IPv6 packets of a given color with ECN set to 2’b01 or 2’b10 carrying
-- 
2.51.0

