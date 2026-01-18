Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD30C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF748410E8;
	Sun, 18 Jan 2026 20:14:00 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 199F8410D4
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:13:59 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8765be29d6so525867266b.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763639;
 x=1769368439; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBSJbenmR3Oblgf1eRPTZANEGvlJrXXXPy0iBWXFdeM=;
 b=CFI0TNbqWRWeRZ4lYjr5rDfsT/TaGYIK7Y/Ut7PzDiP2CBV6cPFx4vCO4NNfqIhLev
 Jgw+70tIvAQTJ+7mceBIpTrILJEflA5g+DMZrKL3WzJwRt3Lw5lni7XZPeWJW6EZWug7
 yadMS8OpY80LtiU31u5qQ7qde1kSmNFakclUJzFwMIUr8pnC1dO/JX9NnNLOBFst3g0h
 y/E+/ue5EFvGX4rC46HpNOHtH15oIIcptFTXcJl60/ORMxwbiYUA4Ne/VTZlWu8kzahQ
 zvApCpoBQNWRBbOww/TzyyZ7eGvK+n7hFkdPhl8WHExnFXQGTbxQo7rdkSsh9s+E7OAQ
 1WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763639; x=1769368439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MBSJbenmR3Oblgf1eRPTZANEGvlJrXXXPy0iBWXFdeM=;
 b=vIyucHIvgUnwL6KwVtzgDPLsu5K5k2asp0qFgzLAUtW4tb0smxxbvpKAUEbrxDh+gF
 wByD43Os5OsdH1MaV7mWSc4vgr4wbdBVSks2mTl8yLr6EtqvPodf8oaZUbNfFVl8V90w
 206eGdGrBO9Nsyhd1nBxrO8Xe8dZYKGK955py3mcA/CrL1SMe0GPtUKPf9YpXnURZYO7
 mEpOfP/jK1B0HWnkKG3NslC5QQzTlemodj3fQajBEvpU6s1Ny4jOn41aIQwx9XVtiHqL
 7+1qednmec/Dhsxrqivg8YXdvjUv714ZdAQtstaFvXOSiwYbQyhy7mo6jZn9bcDwvRcY
 Rz4Q==
X-Gm-Message-State: AOJu0YwlHo5+kNEeZPz6fHk1pnTR4mzHdR/uJWef8BFZALs4ixNdjwg0
 ksFcC7UcchCFEdEbe6UgOSYdut1sRo/Bo6lSP+9HJz34mig4jC10MtTCzE+EEBRQ1h/6F++cs1L
 ocv1/
X-Gm-Gg: AY/fxX63ATzRAiPFpWqsEWZ5t9fuBkl1tEPqzfxty6TJCgkvOO8rc325FvsFbOb7rEs
 A+XjF91PYUsL4vTfxbEQaNyr9e2Lks1v3XpdC27VToz775lZ5HpcojdDWtCFTTLb8/zURowjHre
 yl7saMgJUX2XfOqahSyby64tDseoB1Zf8RimxJo1GyOGux81tI2CPFsiTSdJCpmwB6FD3XJ22T/
 QrHE8FTKyZaXYIV1woeJUlAQY57tli4voqicQimnTbNPEkwazbRZwV3az5j+VD8Uqs8iRbBaXs9
 F0G8Ug5w1H5ambj89uxs5c0L/TuP2aNDegtsqTvDrOJwLLJZaIX24aasBErBXNPYldX8wae9MSU
 +fgg5BDWIAiT3ej4F/9jljRQXkElmzElHD8myUhKUZ3OImNz3vc2tyVXvYp2ZhCgRg/5rxTbSEH
 qFdcphYCF0KdJ+vCXJmS4DN7Hmz6rnUlaSm/Sbb2CWLq6LvftfIQ==
X-Received: by 2002:a17:907:e114:b0:b87:9f87:7511 with SMTP id
 a640c23a62f3a-b879f8786d9mr405032066b.55.1768763638559; 
 Sun, 18 Jan 2026 11:13:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 19/54] doc: correct grammar in GRO guide
Date: Sun, 18 Jan 2026 11:10:22 -0800
Message-ID: <20260118191323.241013-20-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "is in charge of process" to "is in charge of processing"
- Change "which process N packets" to "which processes N packets"
- Change "existed packets" to "existing packets"
- Change "require our algorithm is" to "require that our algorithm is"
- Change "If find" to "If it finds" and "If can't find" to "If it cannot
  find"
- Change "can't merge" to "cannot merge"
- Change "doesn't support to process" to "doesn't support processing"
- Change "just supports to process the packet" to "only supports
  processing packets"
- Change "before call GRO APIs" to "before calling GRO APIs"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../generic_receive_offload_lib.rst           | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/doc/guides/prog_guide/generic_receive_offload_lib.rst b/doc/guides/prog_guide/generic_receive_offload_lib.rst
index f2b5ff9eed..66e07d47f4 100644
--- a/doc/guides/prog_guide/generic_receive_offload_lib.rst
+++ b/doc/guides/prog_guide/generic_receive_offload_lib.rst
@@ -17,7 +17,7 @@ Overview
 --------
 
 In the GRO library, there are many GRO types which are defined by packet
-types. One GRO type is in charge of process one kind of packets. For
+types. One GRO type is in charge of processing one kind of packets. For
 example, TCP/IPv4 GRO processes TCP/IPv4 packets.
 
 Each GRO type has a reassembly function, which defines own algorithm and
@@ -47,7 +47,7 @@ Lightweight Mode API
 ~~~~~~~~~~~~~~~~~~~~
 
 The lightweight mode only has one function ``rte_gro_reassemble_burst()``,
-which process N packets at a time. Using the lightweight mode API to
+which processes N packets at a time. Using the lightweight mode API to
 merge packets is very simple. Calling ``rte_gro_reassemble_burst()`` is
 enough. The GROed packets are returned to applications as soon as it
 finishes.
@@ -69,7 +69,7 @@ Secondly, applications use ``rte_gro_reassemble()`` to merge packets.
 If input packets have invalid parameters, ``rte_gro_reassemble()``
 returns them to applications. For example, packets of unsupported GRO
 types or TCP SYN packets are returned. Otherwise, the input packets are
-either merged with the existed packets in the tables or inserted into the
+either merged with the existing packets in the tables or inserted into the
 tables. Finally, applications use ``rte_gro_timeout_flush()`` to flush
 packets from the tables, when they want to get the GROed packets.
 
@@ -98,7 +98,7 @@ challenges in the algorithm design:
 - packet reordering makes it hard to merge packets. For example, Linux
   GRO fails to merge packets when encounters packet reordering.
 
-The above two challenges require our algorithm is:
+The above two challenges require that our algorithm is:
 
 - lightweight enough to scale fast networking speed
 
@@ -114,13 +114,13 @@ key-based algorithm. Packets are classified into "flows" by some header
 fields (we call them as "key"). To process an input packet, the algorithm
 searches for a matched "flow" (i.e., the same value of key) for the
 packet first, then checks all packets in the "flow" and tries to find a
-"neighbor" for it. If find a "neighbor", merge the two packets together.
-If can't find a "neighbor", store the packet into its "flow". If can't
+"neighbor" for it. If it finds a "neighbor", merge the two packets together.
+If it cannot find a "neighbor", store the packet into its "flow". If it cannot
 find a matched "flow", insert a new "flow" and store the packet into the
 "flow".
 
 .. note::
-        Packets in the same "flow" that can't merge are always caused
+        Packets in the same "flow" that cannot merge are always caused
         by packet reordering.
 
 The key-based algorithm has two characters:
@@ -199,15 +199,15 @@ GRO Library Limitations
 - GRO library uses MBUF->l2_len/l3_len/l4_len/outer_l2_len/
   outer_l3_len/packet_type to get protocol headers for the
   input packet, rather than parsing the packet header. Therefore,
-  before call GRO APIs to merge packets, user applications
+  before calling GRO APIs to merge packets, user applications
   must set MBUF->l2_len/l3_len/l4_len/outer_l2_len/outer_l3_len/
   packet_type to the same values as the protocol headers of the
   packet.
 
-- GRO library doesn't support to process the packets with IPv4
+- GRO library doesn't support processing packets with IPv4
   Options or VLAN tagged.
 
-- GRO library just supports to process the packet organized
+- GRO library only supports processing packets organized
   in a single MBUF. If the input packet consists of multiple
   MBUFs (i.e. chained MBUFs), GRO reassembly behaviors are
   unknown.
-- 
2.51.0

