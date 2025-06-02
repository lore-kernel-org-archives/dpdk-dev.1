Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D59C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:38:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88A4540668;
	Mon,  2 Jun 2025 08:38:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id ED6DE40616
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:38:15 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551MEgOw028737;
 Sun, 1 Jun 2025 23:38:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 Sea0TRM2hjI4q3kAuSn+Z2JHpfpLb39iGJ6tyqyASw=; b=k/3H4TFffOqpOtRsE
 vO+1TQLdgEt5UPQWURZh0cbCMhyfURtA1aN5nsnWjDPbNCCEoofbOc4QkvRfi41t
 wpRxgjHLkQKFMKpnttLgM9p/YRtRep+2ijyF/z14QLW+bUgEcuQGZzL2J0bxjBWd
 lSVzHsoTacBN0K92b1iZ7v9VTarZWFt9/APt53kRD4OETTvdxfK+eXqFMELJDrdV
 ylm1iDGeXM1HK8yPXGN24THGlPYt6QLTzukf/rnXkjq8SmC/C9bP7J29Ok3moTUt
 JQsV1AjEizvneJ4/lKwMMFLannzG0/UwtYxoYMncYe/fEJKXNvg092JAvaqfmo2r
 8d3Cw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 470ye00n9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:38:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:38:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:38:13 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id B72FD3F704B;
 Sun,  1 Jun 2025 23:38:10 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 14/14] doc: add FIB nodes in graph guide
Date: Mon, 2 Jun 2025 12:06:39 +0530
Message-ID: <20250602063639.198550-15-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX5qhdau3J3CPz
 pskO5KE4c7uW/dUMCcl9Rd15DIUQ9JA/sOrs/vlo/nLmdPuWsMY3TquZwh+BoCRJKT2ChQz8gZa
 xQq3BUaX8ohgq1PrykWXH5cwAXBnS16Bj+uWfdLuinCzBx3JTDWhTHqQ8Uf6iLr+9JWY5h0Ui41
 WSKKW7qcojHCRVTbS/Hqtg5m2UCKcD3g1Q+xmI35Jrv7Jd0/eGo5WlqyrRw5O2X8oD0wgopfSyN
 niL2sl4/TrO11tcIkX0K6T8o0L9mSqTlT/teJ6NvYEHgX0Fw3uH6zdnGmhR0zGgKa56c1/IWNg1
 UsmcSeYhI+G6KkcSHHhFWASBxOvKZFvKrHmswTIAbYChEERctYCRfVIcp8m8a5ggJUZ4vdvdkJM
 cCh81c0Lb4OdoIfghIrXRDqzZJuawF8EBMmdSUf9Pr8yLHw0/Ka9hcdhMynbasjOgkMfrio7
X-Authority-Analysis: v=2.4 cv=Iv8ecK/g c=1 sm=1 tr=0 ts=683d46d7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=SSmOFEACAAAA:8 a=M5GUcnROAAAA:8 a=nQU0pW8VkhwdWRs5Y0IA:9
 a=APKg38VUWEZJ8mz5:21 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: WBGD-jTVWMDJtuzXeGwEtjreXswRTK89
X-Proofpoint-GUID: WBGD-jTVWMDJtuzXeGwEtjreXswRTK89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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

Adds the ip4_lookup_fib and ip6_lookup_fib nodes in inbuilt nodes section
of graph guide.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 doc/guides/prog_guide/graph_lib.rst           |  32 ++++
 .../img/graph_inbuilt_node_flow.svg           | 150 +++++++++---------
 2 files changed, 108 insertions(+), 74 deletions(-)

diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index dc6c8c0712..7b5c93f73f 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -458,6 +458,22 @@ On LPM lookup failure, objects are redirected to pkt_drop node.
 To achieve home run, node use ``rte_node_stream_move()`` as mentioned in above
 sections.
 
+ip4_lookup_fib
+~~~~~~~~~~~~~~
+This node is an intermediate node that does FIB lookup for the received
+ipv4 packets and the result determines each packets next node.
+
+On successful FIB lookup, the result contains the ``next_node`` id and
+``next-hop`` id with which the packet needs to be further processed.
+
+On FIB lookup failure, objects are redirected to pkt_drop node.
+``rte_node_ip4_fib_route_add()`` is control path API to add ipv4 routes.
+To achieve home run, node use ``rte_node_stream_move()`` as mentioned in above
+sections.
+
+This node is used only when lookup mode is given as FIB in the application.
+Otherwise, the ip4_lookup node is used by default which does LPM lookup.
+
 ip4_rewrite
 ~~~~~~~~~~~
 This node gets packets from ``ip4_lookup`` node with next-hop id for each
@@ -487,6 +503,22 @@ On LPM lookup failure, objects are redirected to ``pkt_drop`` node.
 To achieve home run, node use ``rte_node_stream_move()``
 as mentioned in above sections.
 
+ip6_lookup_fib
+~~~~~~~~~~~~~~
+This node is an intermediate node that does FIB lookup for the received
+IPv6 packets and the result determines each packets next node.
+
+On successful FIB lookup, the result contains the ``next_node`` ID
+and `next-hop`` ID with which the packet needs to be further processed.
+
+On FIB lookup failure, objects are redirected to ``pkt_drop`` node.
+``rte_node_ip6_fib_route_add()`` is control path API to add IPv6 routes.
+To achieve home run, node use ``rte_node_stream_move()`` as mentioned in
+above sections.
+
+This node is used only when lookup mode is given as FIB in the application.
+Otherwise, the ip6_lookup node is used by default which does LPM lookup.
+
 ip6_rewrite
 ~~~~~~~~~~~
 This node gets packets from ``ip6_lookup`` node with next-hop ID
diff --git a/doc/guides/prog_guide/img/graph_inbuilt_node_flow.svg b/doc/guides/prog_guide/img/graph_inbuilt_node_flow.svg
index 7c451371a7..f654d581e0 100644
--- a/doc/guides/prog_guide/img/graph_inbuilt_node_flow.svg
+++ b/doc/guides/prog_guide/img/graph_inbuilt_node_flow.svg
@@ -1,7 +1,7 @@
 <?xml version="1.0" encoding="UTF-8" standalone="no"?>
 <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
  "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
-<!-- Generated by graphviz version 8.0.5 (0)
+<!-- Generated by graphviz version 2.43.0 (0)
  -->
 <!-- SPDX-License-Identifier: BSD-3-Clause -->
 <!-- Copyright(C) 2023 Marvell International Ltd. -->
@@ -20,6 +20,8 @@ digraph dpdk_inbuilt_nodes_flow {
     pkt_drop [color="cyan"]
     kernel_tx [color="blue"]
     pkt_cls [color="red"]
+    ip4_lookup [label="ip4_lookup / ip4_lookup_fib"]
+    ip6_lookup [label="ip6_lookup / ip6_lookup_fib"]
 
     ethdev_rx -> pkt_cls
     kernel_rx -> pkt_cls
@@ -48,58 +50,58 @@ digraph dpdk_inbuilt_nodes_flow {
  -->
 <!-- input nodes -->
 <!-- Title: dpdk_inbuilt_nodes_flow Pages: 1 -->
-<svg width="631pt" height="437pt"
- viewBox="0.00 0.00 630.95 437.00" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
+<svg width="777pt" height="437pt"
+ viewBox="0.00 0.00 776.95 437.00" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
 <g id="graph0" class="graph" transform="scale(1 1) rotate(0) translate(4 433)">
 <title>dpdk_inbuilt_nodes_flow</title>
-<polygon fill="white" stroke="transparent" points="-4,4 -4,-433 626.95,-433 626.95,4 -4,4"/>
+<polygon fill="white" stroke="transparent" points="-4,4 -4,-433 772.95,-433 772.95,4 -4,4"/>
 <!-- ethdev_rx -->
 <g id="node1" class="node">
 <title>ethdev_rx</title>
-<ellipse fill="none" stroke="green" cx="261.95" cy="-411" rx="56.59" ry="18"/>
-<text text-anchor="middle" x="261.95" y="-407.3" font-family="Times,serif" font-size="14.00">ethdev_rx</text>
+<ellipse fill="none" stroke="green" cx="317.95" cy="-411" rx="56.59" ry="18"/>
+<text text-anchor="middle" x="317.95" y="-407.3" font-family="Times,serif" font-size="14.00">ethdev_rx</text>
 </g>
 <!-- pkt_cls -->
 <g id="node6" class="node">
 <title>pkt_cls</title>
-<ellipse fill="none" stroke="red" cx="261.95" cy="-338" rx="42.79" ry="18"/>
-<text text-anchor="middle" x="261.95" y="-334.3" font-family="Times,serif" font-size="14.00">pkt_cls</text>
+<ellipse fill="none" stroke="red" cx="317.95" cy="-338" rx="42.79" ry="18"/>
+<text text-anchor="middle" x="317.95" y="-334.3" font-family="Times,serif" font-size="14.00">pkt_cls</text>
 </g>
 <!-- ethdev_rx&#45;&gt;pkt_cls -->
 <g id="edge1" class="edge">
 <title>ethdev_rx&#45;&gt;pkt_cls</title>
-<path fill="none" stroke="black" d="M261.95,-392.81C261.95,-384.79 261.95,-375.05 261.95,-366.07"/>
-<polygon fill="black" stroke="black" points="265.45,-366.03 261.95,-356.03 258.45,-366.03 265.45,-366.03"/>
+<path fill="none" stroke="black" d="M317.95,-392.81C317.95,-384.79 317.95,-375.05 317.95,-366.07"/>
+<polygon fill="black" stroke="black" points="321.45,-366.03 317.95,-356.03 314.45,-366.03 321.45,-366.03"/>
 </g>
 <!-- kernel_rx -->
 <g id="node2" class="node">
 <title>kernel_rx</title>
-<ellipse fill="none" stroke="green" cx="53.95" cy="-178" rx="53.89" ry="18"/>
-<text text-anchor="middle" x="53.95" y="-174.3" font-family="Times,serif" font-size="14.00">kernel_rx</text>
+<ellipse fill="none" stroke="green" cx="142.95" cy="-178" rx="53.89" ry="18"/>
+<text text-anchor="middle" x="142.95" y="-174.3" font-family="Times,serif" font-size="14.00">kernel_rx</text>
 </g>
 <!-- kernel_rx&#45;&gt;pkt_cls -->
 <g id="edge2" class="edge">
 <title>kernel_rx&#45;&gt;pkt_cls</title>
-<path fill="none" stroke="black" d="M74.75,-194.8C112.31,-223.33 191.45,-283.45 233.8,-315.62"/>
-<polygon fill="black" stroke="black" points="231.92,-318.59 242,-321.85 236.16,-313.01 231.92,-318.59"/>
+<path fill="none" stroke="black" d="M144.85,-196.26C147.86,-216.03 155.42,-248.32 173.95,-269 199.67,-297.7 240.08,-315.31 271.55,-325.4"/>
+<polygon fill="black" stroke="black" points="270.84,-328.84 281.43,-328.41 272.89,-322.14 270.84,-328.84"/>
 </g>
 <!-- ethdev_tx -->
 <g id="node3" class="node">
 <title>ethdev_tx</title>
-<ellipse fill="none" stroke="magenta" cx="347.95" cy="-91" rx="55.79" ry="18"/>
-<text text-anchor="middle" x="347.95" y="-87.3" font-family="Times,serif" font-size="14.00">ethdev_tx</text>
+<ellipse fill="none" stroke="magenta" cx="442.95" cy="-91" rx="55.79" ry="18"/>
+<text text-anchor="middle" x="442.95" y="-87.3" font-family="Times,serif" font-size="14.00">ethdev_tx</text>
 </g>
 <!-- pkt_drop -->
 <g id="node4" class="node">
 <title>pkt_drop</title>
-<ellipse fill="none" stroke="cyan" cx="404.95" cy="-18" rx="51.99" ry="18"/>
-<text text-anchor="middle" x="404.95" y="-14.3" font-family="Times,serif" font-size="14.00">pkt_drop</text>
+<ellipse fill="none" stroke="cyan" cx="499.95" cy="-18" rx="51.99" ry="18"/>
+<text text-anchor="middle" x="499.95" y="-14.3" font-family="Times,serif" font-size="14.00">pkt_drop</text>
 </g>
 <!-- ethdev_tx&#45;&gt;pkt_drop -->
 <g id="edge14" class="edge">
 <title>ethdev_tx&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M361.45,-73.17C368.55,-64.33 377.39,-53.33 385.23,-43.55"/>
-<polygon fill="cyan" stroke="cyan" points="388,-45.69 391.53,-35.71 382.54,-41.31 388,-45.69"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M456.45,-73.17C463.55,-64.33 472.39,-53.33 480.23,-43.55"/>
+<polygon fill="cyan" stroke="cyan" points="483,-45.69 486.53,-35.71 477.54,-41.31 483,-45.69"/>
 </g>
 <!-- kernel_tx -->
 <g id="node5" class="node">
@@ -110,156 +112,156 @@ digraph dpdk_inbuilt_nodes_flow {
 <!-- kernel_tx&#45;&gt;kernel_rx -->
 <g id="edge16" class="edge">
 <title>kernel_tx&#45;&gt;kernel_rx</title>
-<path fill="none" stroke="red" stroke-dasharray="5,2" d="M53.95,-232.81C53.95,-224.79 53.95,-215.05 53.95,-206.07"/>
-<polygon fill="red" stroke="red" points="57.45,-206.03 53.95,-196.03 50.45,-206.03 57.45,-206.03"/>
+<path fill="none" stroke="red" stroke-dasharray="5,2" d="M73.7,-234.24C85.83,-224.57 101.55,-212.02 114.95,-201.33"/>
+<polygon fill="red" stroke="red" points="117.31,-203.93 122.94,-194.96 112.94,-198.46 117.31,-203.93"/>
 </g>
 <!-- pkt_cls&#45;&gt;pkt_drop -->
 <g id="edge15" class="edge">
 <title>pkt_cls&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M304.77,-335.88C400.4,-332.2 622.95,-316.71 622.95,-252 622.95,-252 622.95,-252 622.95,-90 622.95,-56.33 527.72,-36.15 463.14,-26.34"/>
-<polygon fill="cyan" stroke="cyan" points="463.46,-22.85 453.06,-24.85 462.44,-29.77 463.46,-22.85"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M359.57,-333.53C471.21,-323.65 768.95,-293.43 768.95,-252 768.95,-252 768.95,-252 768.95,-90 768.95,-47.3 640.63,-29.71 561.24,-22.92"/>
+<polygon fill="cyan" stroke="cyan" points="561.11,-19.4 550.86,-22.07 560.54,-26.37 561.11,-19.4"/>
 </g>
 <!-- pkt_cls&#45;&gt;kernel_tx -->
 <g id="edge5" class="edge">
 <title>pkt_cls&#45;&gt;kernel_tx</title>
-<path fill="none" stroke="blue" d="M219.14,-335.96C164.86,-333.64 75.77,-326.15 54.95,-302 49.6,-295.81 48.06,-287.4 48.24,-279.24"/>
-<polygon fill="blue" stroke="blue" points="51.73,-279.54 49.23,-269.24 44.76,-278.84 51.73,-279.54"/>
-<text text-anchor="middle" x="107.45" y="-290.8" font-family="Times,serif" font-size="14.00">exception pkts</text>
+<path fill="none" stroke="blue" d="M275.65,-334.79C200.84,-330.45 51.54,-319.65 35.95,-302 29.84,-295.09 31.24,-285.97 35.22,-277.4"/>
+<polygon fill="blue" stroke="blue" points="38.4,-278.88 40.31,-268.46 32.32,-275.42 38.4,-278.88"/>
+<text text-anchor="middle" x="88.45" y="-290.8" font-family="Times,serif" font-size="14.00">exception pkts</text>
 </g>
 <!-- ip4_lookup -->
 <g id="node7" class="node">
 <title>ip4_lookup</title>
-<ellipse fill="none" stroke="black" cx="261.95" cy="-251" rx="60.39" ry="18"/>
-<text text-anchor="middle" x="261.95" y="-247.3" font-family="Times,serif" font-size="14.00">ip4_lookup</text>
+<ellipse fill="none" stroke="black" cx="317.95" cy="-251" rx="135.38" ry="18"/>
+<text text-anchor="middle" x="317.95" y="-247.3" font-family="Times,serif" font-size="14.00">ip4_lookup / ip4_lookup_fib</text>
 </g>
 <!-- pkt_cls&#45;&gt;ip4_lookup -->
 <g id="edge3" class="edge">
 <title>pkt_cls&#45;&gt;ip4_lookup</title>
-<path fill="none" stroke="black" d="M261.95,-319.8C261.95,-308.16 261.95,-292.55 261.95,-279.24"/>
-<polygon fill="black" stroke="black" points="265.45,-279.18 261.95,-269.18 258.45,-279.18 265.45,-279.18"/>
-<text text-anchor="middle" x="277.45" y="-290.8" font-family="Times,serif" font-size="14.00">ipv4</text>
+<path fill="none" stroke="black" d="M317.95,-319.8C317.95,-308.16 317.95,-292.55 317.95,-279.24"/>
+<polygon fill="black" stroke="black" points="321.45,-279.18 317.95,-269.18 314.45,-279.18 321.45,-279.18"/>
+<text text-anchor="middle" x="333.45" y="-290.8" font-family="Times,serif" font-size="14.00">ipv4</text>
 </g>
 <!-- ip6_lookup -->
 <g id="node8" class="node">
 <title>ip6_lookup</title>
-<ellipse fill="none" stroke="black" cx="492.95" cy="-251" rx="60.39" ry="18"/>
-<text text-anchor="middle" x="492.95" y="-247.3" font-family="Times,serif" font-size="14.00">ip6_lookup</text>
+<ellipse fill="none" stroke="black" cx="605.95" cy="-251" rx="135.38" ry="18"/>
+<text text-anchor="middle" x="605.95" y="-247.3" font-family="Times,serif" font-size="14.00">ip6_lookup / ip6_lookup_fib</text>
 </g>
 <!-- pkt_cls&#45;&gt;ip6_lookup -->
 <g id="edge4" class="edge">
 <title>pkt_cls&#45;&gt;ip6_lookup</title>
-<path fill="none" stroke="black" d="M293.1,-325.54C332.57,-311.01 400.93,-285.86 446.54,-269.07"/>
-<polygon fill="black" stroke="black" points="448.02,-272.26 456.2,-265.52 445.61,-265.69 448.02,-272.26"/>
-<text text-anchor="middle" x="407.45" y="-290.8" font-family="Times,serif" font-size="14.00">ipv6</text>
+<path fill="none" stroke="black" d="M352.11,-326.92C399.09,-313.05 484.45,-287.86 543.12,-270.54"/>
+<polygon fill="black" stroke="black" points="544.42,-273.81 553.02,-267.62 542.44,-267.09 544.42,-273.81"/>
+<text text-anchor="middle" x="495.45" y="-290.8" font-family="Times,serif" font-size="14.00">ipv6</text>
 </g>
 <!-- ip4_lookup&#45;&gt;pkt_drop -->
 <g id="edge7" class="edge">
 <title>ip4_lookup&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M258.85,-232.91C253.68,-198.83 247.1,-121.54 282.95,-73 299.1,-51.12 326.1,-37.95 350.6,-30.11"/>
-<polygon fill="cyan" stroke="cyan" points="351.6,-33.46 360.19,-27.26 349.61,-26.75 351.6,-33.46"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M322.89,-232.88C335.16,-190.88 366.75,-85.24 377.95,-73 396.35,-52.86 423.64,-39.83 447.75,-31.62"/>
+<polygon fill="cyan" stroke="cyan" points="449.04,-34.88 457.5,-28.49 446.91,-28.21 449.04,-34.88"/>
 </g>
 <!-- ip4_rewrite -->
 <g id="node9" class="node">
 <title>ip4_rewrite</title>
-<ellipse fill="none" stroke="black" cx="347.95" cy="-178" rx="63.89" ry="18"/>
-<text text-anchor="middle" x="347.95" y="-174.3" font-family="Times,serif" font-size="14.00">ip4_rewrite</text>
+<ellipse fill="none" stroke="black" cx="442.95" cy="-178" rx="63.89" ry="18"/>
+<text text-anchor="middle" x="442.95" y="-174.3" font-family="Times,serif" font-size="14.00">ip4_rewrite</text>
 </g>
 <!-- ip4_lookup&#45;&gt;ip4_rewrite -->
 <g id="edge6" class="edge">
 <title>ip4_lookup&#45;&gt;ip4_rewrite</title>
-<path fill="none" stroke="black" d="M281.46,-233.89C292.92,-224.42 307.6,-212.31 320.25,-201.87"/>
-<polygon fill="black" stroke="black" points="322.73,-204.36 328.21,-195.29 318.27,-198.96 322.73,-204.36"/>
+<path fill="none" stroke="black" d="M347.25,-233.35C365.11,-223.21 388.07,-210.17 407.02,-199.41"/>
+<polygon fill="black" stroke="black" points="408.99,-202.31 415.96,-194.33 405.53,-196.23 408.99,-202.31"/>
 </g>
 <!-- ip4_local -->
 <g id="node11" class="node">
 <title>ip4_local</title>
-<ellipse fill="none" stroke="black" cx="176.95" cy="-178" rx="51.19" ry="18"/>
-<text text-anchor="middle" x="176.95" y="-174.3" font-family="Times,serif" font-size="14.00">ip4_local</text>
+<ellipse fill="none" stroke="black" cx="271.95" cy="-178" rx="51.19" ry="18"/>
+<text text-anchor="middle" x="271.95" y="-174.3" font-family="Times,serif" font-size="14.00">ip4_local</text>
 </g>
 <!-- ip4_lookup&#45;&gt;ip4_local -->
 <g id="edge17" class="edge">
 <title>ip4_lookup&#45;&gt;ip4_local</title>
-<path fill="none" stroke="black" d="M242.66,-233.89C231.17,-224.29 216.41,-211.96 203.79,-201.42"/>
-<polygon fill="black" stroke="black" points="205.78,-198.53 195.86,-194.8 201.29,-203.9 205.78,-198.53"/>
+<path fill="none" stroke="black" d="M306.81,-232.81C301.33,-224.35 294.61,-213.98 288.54,-204.61"/>
+<polygon fill="black" stroke="black" points="291.35,-202.52 282.98,-196.03 285.48,-206.32 291.35,-202.52"/>
 </g>
 <!-- ip6_lookup&#45;&gt;pkt_drop -->
 <g id="edge11" class="edge">
 <title>ip6_lookup&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M524.51,-235.44C540.02,-226.46 557.22,-213.31 565.95,-196 573.15,-181.71 572.55,-174.57 565.95,-160 540.59,-104.08 480.88,-61.6 441.74,-38.51"/>
-<polygon fill="cyan" stroke="cyan" points="443.16,-35.29 432.75,-33.34 439.67,-41.36 443.16,-35.29"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M630.47,-233.24C642.05,-223.81 654.68,-210.93 660.95,-196 667.14,-181.25 667.55,-174.57 660.95,-160 635.59,-104.08 575.88,-61.6 536.74,-38.51"/>
+<polygon fill="cyan" stroke="cyan" points="538.16,-35.29 527.75,-33.34 534.67,-41.36 538.16,-35.29"/>
 </g>
 <!-- ip6_rewrite -->
 <g id="node10" class="node">
 <title>ip6_rewrite</title>
-<ellipse fill="none" stroke="black" cx="492.95" cy="-178" rx="63.89" ry="18"/>
-<text text-anchor="middle" x="492.95" y="-174.3" font-family="Times,serif" font-size="14.00">ip6_rewrite</text>
+<ellipse fill="none" stroke="black" cx="587.95" cy="-178" rx="63.89" ry="18"/>
+<text text-anchor="middle" x="587.95" y="-174.3" font-family="Times,serif" font-size="14.00">ip6_rewrite</text>
 </g>
 <!-- ip6_lookup&#45;&gt;ip6_rewrite -->
 <g id="edge10" class="edge">
 <title>ip6_lookup&#45;&gt;ip6_rewrite</title>
-<path fill="none" stroke="black" d="M492.95,-232.81C492.95,-224.79 492.95,-215.05 492.95,-206.07"/>
-<polygon fill="black" stroke="black" points="496.45,-206.03 492.95,-196.03 489.45,-206.03 496.45,-206.03"/>
+<path fill="none" stroke="black" d="M601.59,-232.81C599.53,-224.7 597.03,-214.84 594.73,-205.78"/>
+<polygon fill="black" stroke="black" points="598.11,-204.86 592.26,-196.03 591.33,-206.58 598.11,-204.86"/>
 </g>
 <!-- ip4_rewrite&#45;&gt;ethdev_tx -->
 <g id="edge8" class="edge">
 <title>ip4_rewrite&#45;&gt;ethdev_tx</title>
-<path fill="none" stroke="green" d="M347.95,-159.8C347.95,-148.16 347.95,-132.55 347.95,-119.24"/>
-<polygon fill="green" stroke="green" points="351.45,-119.18 347.95,-109.18 344.45,-119.18 351.45,-119.18"/>
+<path fill="none" stroke="green" d="M442.95,-159.8C442.95,-148.16 442.95,-132.55 442.95,-119.24"/>
+<polygon fill="green" stroke="green" points="446.45,-119.18 442.95,-109.18 439.45,-119.18 446.45,-119.18"/>
 </g>
 <!-- ip4_rewrite&#45;&gt;pkt_drop -->
 <g id="edge9" class="edge">
 <title>ip4_rewrite&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M370.32,-161.1C385.53,-148.83 404.37,-130.37 412.95,-109 421.04,-88.82 418.02,-64.12 413.56,-45.7"/>
-<polygon fill="cyan" stroke="cyan" points="416.9,-44.66 410.91,-35.93 410.15,-46.49 416.9,-44.66"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M465.32,-161.1C480.53,-148.83 499.37,-130.37 507.95,-109 516.04,-88.82 513.02,-64.12 508.56,-45.7"/>
+<polygon fill="cyan" stroke="cyan" points="511.9,-44.66 505.91,-35.93 505.15,-46.49 511.9,-44.66"/>
 </g>
 <!-- ip6_rewrite&#45;&gt;ethdev_tx -->
 <g id="edge12" class="edge">
 <title>ip6_rewrite&#45;&gt;ethdev_tx</title>
-<path fill="none" stroke="green" d="M466.35,-161.41C442.8,-147.6 408.27,-127.36 382.57,-112.3"/>
-<polygon fill="green" stroke="green" points="384.28,-109.24 373.88,-107.21 380.74,-115.28 384.28,-109.24"/>
+<path fill="none" stroke="green" d="M561.35,-161.41C537.8,-147.6 503.27,-127.36 477.57,-112.3"/>
+<polygon fill="green" stroke="green" points="479.28,-109.24 468.88,-107.21 475.74,-115.28 479.28,-109.24"/>
 </g>
 <!-- ip6_rewrite&#45;&gt;pkt_drop -->
 <g id="edge13" class="edge">
 <title>ip6_rewrite&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M485.15,-159.86C473.93,-135.7 452.15,-90.48 429.95,-54 427.97,-50.75 425.78,-47.4 423.55,-44.13"/>
-<polygon fill="cyan" stroke="cyan" points="426.28,-41.92 417.67,-35.75 420.55,-45.94 426.28,-41.92"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M580.15,-159.86C568.93,-135.7 547.15,-90.48 524.95,-54 522.97,-50.75 520.78,-47.4 518.55,-44.13"/>
+<polygon fill="cyan" stroke="cyan" points="521.28,-41.92 512.67,-35.75 515.55,-45.94 521.28,-41.92"/>
 </g>
 <!-- ip4_local&#45;&gt;pkt_drop -->
 <g id="edge18" class="edge">
 <title>ip4_local&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M191.02,-160.51C195.47,-154.86 200.21,-148.35 203.95,-142 225.57,-105.29 209.02,-81.03 241.95,-54 257.83,-40.96 306.22,-31.62 346.19,-25.89"/>
-<polygon fill="cyan" stroke="cyan" points="346.72,-29.35 356.14,-24.51 345.75,-22.41 346.72,-29.35"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M286.02,-160.51C290.47,-154.86 295.21,-148.35 298.95,-142 320.57,-105.29 304.02,-81.03 336.95,-54 352.83,-40.96 401.22,-31.62 441.19,-25.89"/>
+<polygon fill="cyan" stroke="cyan" points="441.72,-29.35 451.14,-24.51 440.75,-22.41 441.72,-29.35"/>
 </g>
 <!-- udp4_input -->
 <g id="node12" class="node">
 <title>udp4_input</title>
-<ellipse fill="none" stroke="black" cx="126.95" cy="-91" rx="63.09" ry="18"/>
-<text text-anchor="middle" x="126.95" y="-87.3" font-family="Times,serif" font-size="14.00">udp4_input</text>
+<ellipse fill="none" stroke="black" cx="221.95" cy="-91" rx="63.09" ry="18"/>
+<text text-anchor="middle" x="221.95" y="-87.3" font-family="Times,serif" font-size="14.00">udp4_input</text>
 </g>
 <!-- ip4_local&#45;&gt;udp4_input -->
 <g id="edge19" class="edge">
 <title>ip4_local&#45;&gt;udp4_input</title>
-<path fill="none" stroke="black" d="M167.07,-160.21C159.99,-148.18 150.33,-131.75 142.26,-118.03"/>
-<polygon fill="black" stroke="black" points="145.06,-115.89 136.97,-109.05 139.03,-119.44 145.06,-115.89"/>
-<text text-anchor="middle" x="177.45" y="-130.8" font-family="Times,serif" font-size="14.00">udpv4</text>
+<path fill="none" stroke="black" d="M262.07,-160.21C254.99,-148.18 245.33,-131.75 237.26,-118.03"/>
+<polygon fill="black" stroke="black" points="240.06,-115.89 231.97,-109.05 234.03,-119.44 240.06,-115.89"/>
+<text text-anchor="middle" x="272.45" y="-130.8" font-family="Times,serif" font-size="14.00">udpv4</text>
 </g>
 <!-- udp4_input&#45;&gt;pkt_drop -->
 <g id="edge21" class="edge">
 <title>udp4_input&#45;&gt;pkt_drop</title>
-<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M154.75,-74.82C169.08,-67.56 187.05,-59.32 203.95,-54 250.51,-39.35 305.19,-30.33 345.76,-25.12"/>
-<polygon fill="cyan" stroke="cyan" points="346.26,-28.59 355.75,-23.88 345.4,-21.64 346.26,-28.59"/>
+<path fill="none" stroke="cyan" stroke-dasharray="5,2" d="M249.75,-74.82C264.08,-67.56 282.05,-59.32 298.95,-54 345.51,-39.35 400.19,-30.33 440.76,-25.12"/>
+<polygon fill="cyan" stroke="cyan" points="441.26,-28.59 450.75,-23.88 440.4,-21.64 441.26,-28.59"/>
 </g>
 <!-- udp_user_node -->
 <g id="node13" class="node">
 <title>udp_user_node</title>
-<ellipse fill="none" stroke="black" cx="126.95" cy="-18" rx="79.89" ry="18"/>
-<text text-anchor="middle" x="126.95" y="-14.3" font-family="Times,serif" font-size="14.00">udp_user_node</text>
+<ellipse fill="none" stroke="black" cx="221.95" cy="-18" rx="79.89" ry="18"/>
+<text text-anchor="middle" x="221.95" y="-14.3" font-family="Times,serif" font-size="14.00">udp_user_node</text>
 </g>
 <!-- udp4_input&#45;&gt;udp_user_node -->
 <g id="edge20" class="edge">
 <title>udp4_input&#45;&gt;udp_user_node</title>
-<path fill="none" stroke="black" d="M126.95,-72.81C126.95,-64.79 126.95,-55.05 126.95,-46.07"/>
-<polygon fill="black" stroke="black" points="130.45,-46.03 126.95,-36.03 123.45,-46.03 130.45,-46.03"/>
+<path fill="none" stroke="black" d="M221.95,-72.81C221.95,-64.79 221.95,-55.05 221.95,-46.07"/>
+<polygon fill="black" stroke="black" points="225.45,-46.03 221.95,-36.03 218.45,-46.03 225.45,-46.03"/>
 </g>
 </g>
 </svg>
-- 
2.25.1

