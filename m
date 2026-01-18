Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC834C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2D2841149;
	Sun, 18 Jan 2026 20:14:03 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 0445C41141
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:02 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-655af782859so4675755a12.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763641;
 x=1769368441; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drv2hF5A+YV6ze+T5jRd2Y1KZPU8+IW8jnITVCwPja8=;
 b=CWHx1b6XhwGeQKykwa2TM/k1CjNJzoliZz79/YG/7TxPJ3f6B7CLwSgj0tKOPi6dOt
 EBB3PtQ4jGfcTHAGFUM9RgbwSqNvJXbNMbB1Nt/mDTRKsGgH0UKIHY8Eys/jGxNEaZf/
 xUWwqC8FLlUHUx+eVofgCGfA19ga8ciQLWaYw20t7FlwjVEx7nR9gsJu4CGQETRty9aV
 vNCMHhHbCWBL2htxrEErUW62YUdvRrR1e/sLrqikQIDHBNlh7VEGyUiLQ1PHFlx3+PUu
 TGTeDukL986+0DlL/m0NfgcxhqaP3MssHsuX/Xq71NQPDhZOZDYBlTEWrsZo7MaXKcOr
 5exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763641; x=1769368441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=drv2hF5A+YV6ze+T5jRd2Y1KZPU8+IW8jnITVCwPja8=;
 b=I6g0WW0WoUzHXpxMQ2KSorX/ZBp1WYOJoEJ4mPNZ9c402veh5S3JwrNAj6JMU8oavy
 U8DL6hyedqGNAxwZ51r4boSy0cnKslmNcwUmIUl7lMlHwR7X8sE/MtnGnK242rp9DZPN
 3KoQ28ODJFZvSaCNYY+OcifGWn6BZOFsgH5bD6q4CHx5XgNE6tdJaRVYj+kZh1A12VxY
 WWtHxu3xYEAnamgRZibpaGx3QtNg9UdCi+7cg+7jFvu9FzKrLspKGlCyOk2LVuvilnN5
 32kuro+t+hfdf37yOD6/hoZRv5h8I45SAnvHesMkr7zIHZjPcQC0Vtfv6boYMuR4b5N0
 /kNg==
X-Gm-Message-State: AOJu0YxDyMUpikJNsxJgPJ+IrqVE0yEzlAwATvEC19HekfocPoZpuvEb
 aI+qGHlRTOqEB2cfJNalRN4hacnb0Rapp/J2DUKv5KUNiUyeqdp4YJDJHgRsXrOOtlW0mPds+n+
 AFGbv
X-Gm-Gg: AY/fxX7GfS7gNrZP8CN6/2qJz1kt3WBbRSauCM6mqsHIsNAHArWX51jVg/1bm0yBZqe
 ljqH6GbxOraXGVOdQCdsnIUxYwaj2Ps/DUKJX/KiXil+soIJppGMNPIU7WoczdUb1rjwXLX7pnQ
 Kx1yWEmar6KWLasK5WPBvv3x3dQ4GR/9VfgaeCii1kkvNjXF/BxYbkczbONAO/cV9p6jQhrcrlT
 3m+Rvyd2oxXlQosFAiR0swFwmIgmqsHdb3JtkWS/K2mSaw/iywnJdeo9hqa1T/zefzQgmiK6IG5
 Qu+hX/0Icfn6kdxDeZoX9kelLGBqA7LhJHRsO7sxZUv8IdBKTwYXlm3DCBz3rHGb/jEECFY9wlz
 69WiG7uaG27J5SOuDlFXtV0APj7I4VHd1tQXe8xwgTEiJS6VSuxLad8SlkK86gMC4xevvJPYCN8
 Sbo6KuJj8+duofjCQj7/6EOeGHcmX92MOZlUBv40kgx+T9UqUwSSzPKm8o9Y59
X-Received: by 2002:a17:906:4fd2:b0:b43:b7ec:b8a1 with SMTP id
 a640c23a62f3a-b8792f94f24mr762902366b.24.1768763641539; 
 Sun, 18 Jan 2026 11:14:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 21/54] doc: correct typos and grammar in graph guide
Date: Sun, 18 Jan 2026 11:10:24 -0800
Message-ID: <20260118191323.241013-22-stephen@networkplumber.org>
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
- Remove trailing hyphen from bullet point
- Change "detached to a graph" to "detached from a graph"
- Change typo "edege" to "edge" (two occurrences)
- Change typo "feilds" to "fields"
- Change "attach" to "attaches" and "create" to "creates"
- Change "with custom port with and" to "with custom port and"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/graph_lib.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 8409e7666e..8e3fd227d3 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -37,7 +37,7 @@ Advantages of Graph architecture
   caches misses.
 - Exploits the probability that most packets will follow the same nodes in the
   graph.
-- Allow SIMD instructions for packet processing of the node.-
+- Allow SIMD instructions for packet processing of the node.
 - The modular scheme allows having reusable nodes for the consumers.
 - The modular scheme allows us to abstract the vendor HW specific
   optimizations as a node.
@@ -92,7 +92,7 @@ fini():
 ^^^^^^^
 
 The callback function will be invoked by ``rte_graph_destroy()`` on when a
-node gets detached to a graph.
+node gets detached from a graph.
 
 Node name:
 ^^^^^^^^^^
@@ -1095,17 +1095,17 @@ This node is an intermediate node that does udp destination port lookup for
 the received ipv4 packets and the result determines each packets next node.
 
 User registers a new node ``udp4_input`` into graph library during initialization
-and attach user specified node as edege to this node using
-``rte_node_udp4_usr_node_add()``, and create empty hash table with destination
-port and node id as its feilds.
+and attaches user specified node as edge to this node using
+``rte_node_udp4_usr_node_add()``, and creates empty hash table with destination
+port and node id as its fields.
 
-After successful addition of user node as edege, edge id is returned to the user.
+After successful addition of user node as edge, edge id is returned to the user.
 
 User would register ``ip4_lookup`` table with specified ip address and 32 bit as mask
 for ip filtration using api ``rte_node_ip4_route_add()``.
 
-After graph is created user would update hash table with custom port with
-and previously obtained edge id using API ``rte_node_udp4_dst_port_add()``.
+After graph is created user would update hash table with custom port and
+previously obtained edge id using API ``rte_node_udp4_dst_port_add()``.
 
 When packet is received lpm look up is performed if ip is matched the packet
 is handed over to ip4_local node, then packet is verified for udp proto and
-- 
2.51.0

