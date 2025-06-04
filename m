Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F3C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 10:13:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C97A5427CA;
	Wed,  4 Jun 2025 12:13:19 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DB39F4042E
 for <dev@dpdk.org>; Wed,  4 Jun 2025 12:13:17 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553NVmjZ018966;
 Wed, 4 Jun 2025 03:13:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
 CQHDS5+HgJAouIVQBhqAFEIPmsXj5ilcfw4jU2By+M=; b=FItApRsFc8nOQrC7V
 bulojVVt/kpxNGP4ASKAr+ZoweK1o0E3HTO1oEqDH1KaIZg+y7T/OMBa7bAckrND
 YbNmTQO+Y+hj5tThq2OZRUDpQj7ytX3F1BAPOsXCGoP0OjisNderjK++Jb20m9Vc
 Ju20d/Co+NKIC6Uail0weETID8Cbmq8rWo7LlcB1Stqb75/gwtDZiKQ+eXQQIOi5
 Rl8ftAvMXgDQHyTJC/ScBHLXS0yIcAa5Zki0NNdOFjuoOYN49J+iJOnYhFU7q4Tz
 BJi/Yu57Z7Kmi9SY6WYLzC0mx3BFF8kjO0+t0Ch1ndPMo85D3ORRERzBxL8TYSG4
 LzqwQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 472at514f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 03:13:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 03:13:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Jun 2025 03:13:10 -0700
Received: from cavium-PowerEdge-R640.. (unknown [10.28.36.207])
 by maili.marvell.com (Postfix) with ESMTP id 219E03F7080;
 Wed,  4 Jun 2025 03:13:06 -0700 (PDT)
From: Nitin Saxena <nsaxena@marvell.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Robin Jarry <rjarry@redhat.com>,
 Christophe Fontaine <cfontain@redhat.com>
CC: <dev@dpdk.org>, Nitin Saxena <nsaxena16@gmail.com>
Subject: [PATCH v10 2/7] graph: add feature arc registrations
Date: Wed, 4 Jun 2025 15:42:29 +0530
Message-ID: <20250604101259.4181992-3-nsaxena@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604101259.4181992-1-nsaxena@marvell.com>
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250604101259.4181992-1-nsaxena@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 4NUeY_2_PoDf9cK6FV-IBDLGBheMwtMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA3NiBTYWx0ZWRfX+aRRHcRNA0iM
 0YpKF0r2UH8SrKsw3Yo1KcITgJla8A3XTpdMvEKaiPiO5+8SE+Gqtye6szRAl+g8WyAgMr7nIif
 V1B/0Ej1I+yXvHbumjJdkmJvwntln3gtdUbTt7hlsk2uLC/c1Uo0k1oJmMlXTauTuLRvhSqiYnJ
 /IthbB/3SDo7yjRgx/P2sSrw0Ruzmmvjxdk1IJhy78G/lU4dNmgCwLLcarElGBoOYTz7aQPAdEm
 zo/wsWfdax1atLUIs8IKBxGZutySW4D191TdUU4sNDH1yPI4zLlrwOlDh4Kgn85eoDvNlCf8ZGQ
 eQXapD2ihbXtK5SfsLKMek8wGMiRtx1/1fSMU2gHO5V5j0BOEPMtqS0Yq4+Y5Zdz9EU+qYx955n
 23s/Yaj6j/Vu0xU0MeP0CnO1x8VDI3A+M4A/rdgPjb1ERvsf/85KxjnSos1p6aXT9iNkhdTk
X-Authority-Analysis: v=2.4 cv=F9dXdrhN c=1 sm=1 tr=0 ts=68401c37 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VQ9ene8lAAAA:8 a=L3Y5zZzAAAAA:8
 a=GqZI9gvVAAAA:8 a=SSmOFEACAAAA:8 a=M5GUcnROAAAA:8
 a=Hf6uRemhBz85_QEdVXwA:9 a=QEXdDO2ut3YA:10 a=5kMfGx23w8a0v5ansn-_:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4NUeY_2_PoDf9cK6FV-IBDLGBheMwtMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
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

This patch defines RTE_GRAPH_FEATURE_ARC_REGISTER() and
RTE_GRAPH_FEATURE_REGISTER() constructors and associated APIs with
programming guide.

Signed-off-by: Nitin Saxena <nsaxena@marvell.com>
---
 doc/api/doxy-api-index.md                   |   1 +
 doc/guides/prog_guide/graph_lib.rst         | 289 +++++++++++
 doc/guides/prog_guide/img/feature_arc-1.svg | 269 +++++++++++
 doc/guides/prog_guide/img/feature_arc-2.svg | 511 ++++++++++++++++++++
 doc/guides/rel_notes/release_25_07.rst      |   7 +
 lib/graph/graph_feature_arc.c               |  36 ++
 lib/graph/meson.build                       |   2 +
 lib/graph/rte_graph_feature_arc.h           | 270 +++++++++++
 8 files changed, 1385 insertions(+)
 create mode 100644 doc/guides/prog_guide/img/feature_arc-1.svg
 create mode 100644 doc/guides/prog_guide/img/feature_arc-2.svg
 create mode 100644 lib/graph/graph_feature_arc.c
 create mode 100644 lib/graph/rte_graph_feature_arc.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 5c425a2cb9..a7bdbf892c 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -214,6 +214,7 @@ The public API headers are grouped by topics:
     [table_wm](@ref rte_swx_table_wm.h)
   * [graph](@ref rte_graph.h):
     [graph_worker](@ref rte_graph_worker.h)
+    [graph_feature_arc](@ref rte_graph_feature_arc.h)
   * graph_nodes:
     [eth_node](@ref rte_node_eth_api.h),
     [ip4_node](@ref rte_node_ip4_api.h),
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/gr=
aph_lib.rst
index dc6c8c0712..191c8e8a0b 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -559,3 +559,292 @@ on success packet is enqueued to ``udp4_input`` node.

 Hash lookup is performed in ``udp4_input`` node with registered destinatio=
n port
 and destination port in UDP packet , on success packet is handed to ``udp_=
user_node``.
+
+Graph feature arc
+-----------------
+Introduction
+~~~~~~~~~~~~
+Graph feature arc is an abstraction to manage more than one network protoc=
ols(or
+features) in a graph application with
+
+* Runtime network configurability
+* Overloading of default node packet path
+* Control/Data plane synchronization
+
+.. note::
+
+   Feature arc abstraction is introduced as an optional functionality to t=
he
+   graph library. Feature arc is a ``NOP`` to application which skips
+   :ref:`feature arc initialization<Feature_Arc_Initialization>`
+
+Runtime network configurability
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Feature arc facilitates to enable/disable protocols at runtime from control
+thread.  In fast path, it provides APIs to steer packets across nodes of t=
hose
+protocols which are enabled from control thread.
+
+Feature arc uses ``index`` object to enable/disable a protocol which is ge=
neric
+to cater all the possibilities of configuring a protocol. Examples of ``in=
dex``
+object are interface index, route index, flow index, classification index =
etc.
+
+Runtime configuration of one ``index`` is independent of another ``index``
+configuration. In other words, packet received on an interface0 are steered
+independent from packets received on interface1. Both interface0 and inter=
face1
+can have separate sets of protocols enabled at the same time.
+
+Feature arc also provides mechanism to express ``protocol sequencing order=
``
+for packets. If more than one protocols are active in a network layer, pac=
kets
+may be required to be steered among protocol nodes in a specific order. For
+example: in a typical firewall IPv4, IPsec and IP tables may be enabled at=
 the
+same time in IP layer. Feature arc provides mechanism to express sequence
+order in which protocol nodes are to be traversed by packets received/sent=
 on
+an interface.
+
+Default node packet path overloading
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Each network function has defined node packet path. As an example, IPv4 ro=
uter
+as a forwarder includes nodes performing - packet ingress, ethernet recept=
ion,
+IPv4 reception, IPv4 lookup, ethernet rewrite and packet egress. Feature a=
rc
+provides application to overload default node path by providing hook
+points(like netfilter) to insert out-of-tree or another protocol nodes in
+packet path.
+
+Control/Data plane synchronization
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Feature arc does not stop worker cores for any runtime control plane updat=
es.
+i.e. any feature(protocol) enable/disable at runtime does not stop worker
+cores. Control plane feature enable/disable APIs also provides RCU mechani=
sm,
+if needed.
+
+When a feature is enabled in control plane, certain resources may be alloc=
ated
+by application specific to ``[feature, index]``. For example when IPsec is
+enabled either on an interface(policy based IPsec) or route(route based IP=
sec),
+a security association(SA) would be allocated/initialized and attached to
+interface/route. Feature arc APIs are provided to pass SA from control thr=
ead
+to worker threads for applying it(SA) on packets received/sent via
+interface or SA tunnel route.
+
+Furthermore, when IPsec gets disabled for same ``[feature, index]`` in lat=
er
+point of time, cleanup would be required to free resources associated with=
 SA.
+Cleanup can only be done in control thread when it ensures that no worker
+thread is using the SA. For this usecase, application can use RCU mechanism
+provided with enable/disable APIs. See :ref:`notifier_cb<Feature_Notifier_=
Cb>`.
+
+Objects
+~~~~~~~
+Feature
+^^^^^^^
+Feature is analogous to a protocol.
+
+.. _Feature_Nodes:
+
+Features nodes
+^^^^^^^^^^^^^^
+A feature node is a node which performs specific feature processing in a g=
iven
+network layer. Feature nodes incorporates fast path feature arc APIs in th=
eir
+``process()`` function and are part of a unique arc.
+
+Not all nodes in graph required to be made feature nodes.
+
+.. _Start_Node:
+
+Start node
+^^^^^^^^^^
+A node through which packets enters feature arc path is called ``Start nod=
e``.
+It is a node which provides a hook point to overload node packet path. Each
+feature arc object has unique ``start node``. It can be a new node or any
+existing node in a graph. Start node is not counted as a feature node in a=
n arc.
+
+.. _End_Feature_Node:
+
+End feature node
+^^^^^^^^^^^^^^^^
+An end feature node is a feature node through which packets exits feature =
arc
+path.  It is required for exiting packets, from feature arc path, which are
+getting processed by feature node which is getting disabled at runtime in
+control thread. It is always the last feature node in an arc. As an except=
ion
+to other feature nodes, this node does not uses any feature arc fast path =
APIs
+
+Feature arc
+^^^^^^^^^^^
+
+.. _Figure_Arc_1:
+
+.. figure:: img/feature_arc-1.*
+   :alt: feature-arc-1
+   :width: 350px
+   :align: center
+
+   Feature arc representation
+
+A ordered list of feature nodes in a given network layer is called as feat=
ure arc.
+It consists of three objects:
+
+- :ref:`Start node<Start_Node>`
+- :ref:`End feature node<End_Feature_Node>`
+- :ref:`Zero or more feature nodes<Feature_Nodes>`
+
+In order to :ref:`create<Feature_Arc_Registration>` a feature arc object o=
nly
+``start node`` and ``end feature node`` is required. Once created, feature
+nodes can be :ref:`added<Feature_Registration>` to the arc.
+
+Feature data
+^^^^^^^^^^^^
+It is a fast path object which hold information to steer packets across no=
des.
+
+Programming model
+~~~~~~~~~~~~~~~~~
+
+Arc/Feature Registrations
+^^^^^^^^^^^^^^^^^^^^^^^^^
+Feature arc and feature registrations happens using constructor based macr=
os.
+While feature arc registration creates a feature arc object, the feature
+registration adds provided node to a feature arc object.
+
+.. note::
+
+   During registration, no memory is allocated associated with any feature=
 arc.
+   Actual memory allocation, object creation and connecting of nodes via e=
dges
+   corresponding to all registered feature arcs happens as part of
+   :ref:`feature arc initialization<Feature_Arc_Initialization>`.
+
+.. _Feature_Arc_Registration:
+
+Feature arc registration
+************************
+A feature arc object creation require ``feature arc registration``. Once
+registered, feature arc is created as part of
+:ref:`initialization<Feature_Arc_Initialization>`. A feature arc is regist=
ered
+via ``RTE_GRAPH_FEATURE_ARC_REGISTER()``. An arc shown in
+:ref:`figure<Figure_Arc_1>` can be registered as follows:
+
+.. code-block:: c
+
+    /* Existing nodes */
+    RTE_NODE_REGISTER(Node-A);
+    RTE_NODE_REGISTER(Node-B);
+
+    /* Define End feature node: Node-B*/
+    struct rte_graph_feature_register Node-B-feature =3D {
+        .feature_name =3D "Node-B-feature",
+        .arc_name =3D "Arc1",
+        .feature_process_fn =3D nodeB_process_fn(),
+        .feature_node =3D &Node-B,
+    };
+
+    /* Arc1 registration */
+    struct rte_graph_feature_arc_register arc1 =3D {
+        .arc_name =3D "Arc1",
+        .max_indexes =3D RTE_MAX_ETHPORTS,
+        .start_node =3D &Node-A,
+        .start_node_feature_process_fn =3D nodeA_feature_process_fn(),
+        .end_feature_node =3D &Node-B-feature,
+    };
+
+    /* Call constructor */
+     RTE_GRAPH_FEATURE_ARC_REGISTER(arc1);
+
+.. note::
+
+   Feature arc can also be created using ``rte_graph_feature_arc_create()`=
` API as well
+
+.. _Feature_Registration:
+
+Feature registration
+********************
+A feature registration means defining a feature node which would be added =
to a
+unique ``arc``. A feature nodes needs to know ``arc name`` to which it wan=
ts to
+connect to. Registration happens via ``RTE_GRAPH_FEATURE_REGISTER()``.
+
+A ``Feature-1`` shown in :ref:`figure<Figure_Arc_1>` can be registered as =
follows:
+
+.. code-block:: c
+
+    /* Existing node */
+    RTE_NODE_REGISTER(Feature-1);
+
+    /* Define feature node: Feature-1 */
+    struct rte_graph_feature_register Feature-1 =3D {
+        .feature_name =3D "Feature-1",
+        .arc_name =3D "Arc1",
+        .feature_process_fn =3D feature1_process_fn(),
+        .feature_node =3D &Feature-1,
+    };
+
+    /* Call constructor */
+    RTE_GRAPH_FEATURE_REGISTER(Feature-1);
+
+.. note::
+
+   A feature node can be out-of-tree application node which is willing to
+   connect to an arc defined by DPDK in-built nodes. This way application =
can
+   hook it's node to standard node packet path.
+
+Advance parameters
+``````````````````
+.. _Figure_Arc_2:
+
+.. figure:: img/feature_arc-2.*
+   :alt: feature-arc-2
+   :width: 550px
+   :align: center
+
+   Feature registration advance parameters
+
+Feature registration have some advance parameters to control the feature n=
ode.
+As shown in above figure, ``Custom Feature`` and ``Feature-2`` nodes can be
+added to existing arc as follows:
+
+.. code-block:: c
+
+    /* Define feature node: Custom-Feature */
+    struct rte_graph_feature_register Custom-Feature =3D {
+        .feature_name =3D "Custom-Feature",
+        .arc_name =3D "Arc1",
+            ...
+            ...
+            ...
+        .notifier_cb =3D Custom-Feature_notifier_fn(),  /* Optional notifi=
er function */
+        .runs_after =3D "Feature-1",
+    };
+
+    /* Define feature node: Feature-2 */
+    struct rte_graph_feature_register Feature-2 =3D {
+        .feature_name =3D "Feature-2",
+        .arc_name =3D "Arc1",
+            ...
+            ...
+            ...
+        .override_index_cb =3D Feature-3_override_index_cb(),
+        .runs_after =3D "Feature-1",
+        .runs_before =3D "Custom-Feature",
+    };
+
+runs_after/runs_before
+......................
+These parameters are used to express the sequencing order of feature nodes=
.  If
+``Custome Feature`` needs to run after ``Feature-1`` it can be defined as =
shown
+above. Similarly, if ``Feature-2`` needs to run before ``Custome-Feature``=
 but
+after ``Feature-1`` it can be done as shown above.
+
+.. _Feature_Notifier_Cb:
+
+notifier_cb()
+.............
+If non-NULL, every feature enable/disable in control plane will invoke the
+notifier callback on control thread. This notifier callback can be used to
+destroy resources for ``[feature, index]`` pair during ``feature disable``
+which might have allocated during feature enable.
+
+notifier_cb() is called, at runtime, for every enable/disable of ``[featur=
e,
+index]`` from control thread.
+
+override_index_cb()
+....................
+A feature arc is :ref:`registered<Feature_Arc_Registration>` to operate on
+certain number of ``max_indexes``. If particular feature like to overload =
this
+``max_indexes`` with a larger value it can do so by returning larger value=
 in
+this callback. In case of multiple features, largest value returned by any
+feature would be selected for creating feature arc.
+
+.. _Feature_Arc_Initialization:
diff --git a/doc/guides/prog_guide/img/feature_arc-1.svg b/doc/guides/prog_=
guide/img/feature_arc-1.svg
new file mode 100644
index 0000000000..1c6b83f18f
--- /dev/null
+++ b/doc/guides/prog_guide/img/feature_arc-1.svg
@@ -0,0 +1,269 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+<!-- SPDX-License-Identifier: BSD-3-Clause -->
+<!-- Copyright(C) 2025 Marvell International Ltd. -->
+<svg
+   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
+   xmlns:cc=3D"http://creativecommons.org/ns#"
+   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:svg=3D"http://www.w3.org/2000/svg"
+   xmlns=3D"http://www.w3.org/2000/svg"
+   id=3D"svg4977"
+   version=3D"1.1"
+   overflow=3D"hidden"
+   xml:space=3D"preserve"
+   height=3D"1455"
+   width=3D"1995"><metadata
+     id=3D"metadata4983"><rdf:RDF><cc:Work
+         rdf:about=3D""><dc:format>image/svg+xml</dc:format><dc:type
+           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" /><dc:t=
itle></dc:title></cc:Work></rdf:RDF></metadata><defs
+     id=3D"defs4981" /><g
+     id=3D"g4975"
+     transform=3D"translate(-637 -359)"><path
+       id=3D"path4901"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B5E2"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M640.5 543.5C640.5 460.657 788.917 393.5 972 393.5 1155.08 393=
.5 1303.5 460.657 1303.5 543.5 1303.5 626.343 1155.08 693.5 972 693.5 788.9=
17 693.5 640.5 626.343 640.5 543.5Z" /><text
+       id=3D"text4903"
+       transform=3D"matrix(1 0 0 1 831.669 574)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Node</text>
+<text
+       id=3D"text4905"
+       transform=3D"matrix(1 0 0 1 1028.75 574)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text4907"
+       transform=3D"matrix(1 0 0 1 1056.25 574)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">A</text>
+<path
+       id=3D"path4909"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B5E2"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M640.5 1660.5C640.5 1577.66 788.917 1510.5 972 1510.5 1155.08 =
1510.5 1303.5 1577.66 1303.5 1660.5 1303.5 1743.34 1155.08 1810.5 972 1810.=
5 788.917 1810.5 640.5 1743.34 640.5 1660.5Z" /><text
+       id=3D"text4911"
+       transform=3D"matrix(1 0 0 1 831.669 1691)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Node</text>
+<text
+       id=3D"text4913"
+       transform=3D"matrix(1 0 0 1 1028.75 1691)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text4915"
+       transform=3D"matrix(1 0 0 1 1056.25 1691)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">B</text>
+<path
+       id=3D"path4917"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B050"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M1303.5 1132.5C1303.5 1049.66 1452.14 982.5 1635.5 982.5 1818.=
86 982.5 1967.5 1049.66 1967.5 1132.5 1967.5 1215.34 1818.86 1282.5 1635.5 =
1282.5 1452.14 1282.5 1303.5 1215.34 1303.5 1132.5Z" /><text
+       id=3D"text4919"
+       transform=3D"matrix(1 0 0 1 1455.56 1159)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Feature </text>
+<text
+       id=3D"text4921"
+       transform=3D"matrix(1 0 0 1 1728.84 1159)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text4923"
+       transform=3D"matrix(1 0 0 1 1774.1 1159)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">1</text>
+<path
+       id=3D"path4925"
+       fill=3D"#63666A"
+       d=3D"M977.875 693 977.875 1475.28 964.125 1475.28 964.125 693ZM991.=
625 1468.41 971 1509.66 950.375 1468.41Z" /><path
+       id=3D"path4927"
+       fill=3D"#003967"
+       d=3D"M972.869 690.347 998.093 701.303 995.354 707.609 970.13 696.65=
3ZM1017.01 709.52 1042.23 720.476 1039.49 726.782 1014.27 715.826ZM1061.15 =
728.693 1086.37 739.649 1083.64 745.955 1058.41 734.999ZM1105.29 747.866 11=
30.52 758.822 1127.78 765.127 1102.55 754.172ZM1149.43 767.039 1174.66 777.=
995 1171.92 784.3 1146.69 773.344ZM1193.57 786.211 1218.8 797.167 1216.06 8=
03.473 1190.83 792.517ZM1237.71 805.384 1262.94 816.34 1260.2 822.646 1234.=
98 811.69ZM1281.86 824.557 1307.08 835.513 1304.34 841.819 1279.12 830.863Z=
M1326 843.73 1351.22 854.686 1348.48 860.992 1323.26 850.036ZM1370.14 862.9=
03 1395.36 873.859 1392.62 880.165 1367.4 869.209ZM1414.28 882.076 1439.5 8=
93.032 1436.76 899.338 1411.54 888.382ZM1458.42 901.249 1483.64 912.205 148=
0.9 918.511 1455.68 907.555ZM1502.56 920.422 1527.78 931.378 1525.04 937.68=
4 1499.82 926.728ZM1546.7 939.595 1571.92 950.551 1569.18 956.857 1543.96 9=
45.901ZM1590.84 958.768 1615.56 969.504 1612.82 975.81 1588.1 965.074ZM1615=
.46 958.219 1635.21 981.786 1604.51 983.442Z" /><path
+       id=3D"path4929"
+       transform=3D"matrix(-1 0 0 1 1635.21 1282.5)"
+       fill=3D"#003967"
+       d=3D"M1.11695-3.25097 27.1247 5.68467 24.8908 12.1866-1.11695 3.250=
97ZM46.6306 12.3864 72.6383 21.322 70.4044 27.824 44.3967 18.8883ZM92.1442 =
28.0238 118.152 36.9594 115.918 43.4613 89.9103 34.5257ZM137.658 43.6611 16=
3.666 52.5968 161.432 59.0987 135.424 50.1631ZM183.171 59.2985 209.179 68.2=
341 206.945 74.7361 180.937 65.8004ZM228.685 74.9359 254.693 83.8715 252.45=
9 90.3734 226.451 81.4378ZM274.199 90.5732 300.206 99.5089 297.972 106.011 =
271.965 97.0752ZM319.712 106.211 345.72 115.146 343.486 121.648 317.478 112=
.713ZM365.226 121.848 391.234 130.784 389 137.286 362.992 128.35ZM410.739 1=
37.485 436.747 146.421 434.513 152.923 408.505 143.987ZM456.253 153.123 482=
.261 162.058 480.027 168.56 454.019 159.625ZM501.767 168.76 527.774 177.696=
 525.54 184.198 499.533 175.262ZM547.28 184.397 573.288 193.333 571.054 199=
.835 545.046 190.899ZM592.794 200.035 618.802 208.97 616.568 215.472 590.56=
 206.537ZM638.307 215.672 643.152 217.337 640.918 223.839 636.073 222.174ZM=
642.168 206.094 663.708 228.034 633.232 232.102Z" /><text
+       id=3D"text4931"
+       transform=3D"matrix(-1.83697e-16 -1 1 -1.83697e-16 943.025 1309)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Static Packet  Path</text>
+<text
+       id=3D"text4933"
+       transform=3D"matrix(-1.83697e-16 -1 1 -1.83697e-16 1009.03 1200)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 0</text>
+<text
+       id=3D"text4935"
+       transform=3D"matrix(0.916122 0.4009 -0.4009 0.916122 1103.93 809)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 1</text>
+<text
+       id=3D"text4937"
+       transform=3D"matrix(1 0 0 1 1522.09 429)"
+       font-size=3D"55"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Start Node</text>
+<text
+       id=3D"text4941"
+       transform=3D"matrix(1 0 0 1 1618.96 1583)"
+       font-size=3D"55"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">End Feature</text>
+<text
+       id=3D"text4943"
+       transform=3D"matrix(1 0 0 1 1671.66 1649)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Node</text>
+<text
+       id=3D"text4945"
+       transform=3D"matrix(1 0 0 1 2196.79 1078)"
+       font-size=3D"55"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Feature</text>
+<text
+       id=3D"text4947"
+       transform=3D"matrix(1 0 0 1 2230.59 1144)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Node</text>
+<path
+       id=3D"path4949"
+       transform=3D"matrix(-1 0 0 1 1486.34 450.5)"
+       fill=3D"#63666A"
+       d=3D"M0.259414-0.510821 162.664 81.9641 162.145 82.9858-0.259414 0.=
510821ZM164.544 68.1399 182.837 92.8515 152.092 92.6593Z" /><path
+       id=3D"path4951"
+       transform=3D"matrix(-1 0 0 1 1537.94 1604.5)"
+       fill=3D"#63666A"
+       d=3D"M0.133795-0.557075 212.291 50.3976 212.023 51.5117-0.133795 0.=
557075ZM210.911 36.5145 234.44 56.3064 204.489 63.2541Z" /><path
+       id=3D"path4953"
+       transform=3D"matrix(-1 0 0 1 2159.31 1099.5)"
+       fill=3D"#63666A"
+       d=3D"M0.0965444-0.564724 169.317 28.3649 169.124 29.4944-0.0965444 =
0.564724ZM167.019 14.6039 191.809 32.7914 162.385 41.7106Z" /><path
+       id=3D"path4955"
+       transform=3D"matrix(-1 0 0 1 1737.41 724.5)"
+       fill=3D"#63666A"
+       d=3D"M0.229683-0.524861 295.142 128.531 294.683 129.581-0.229683 0.=
524861ZM296.226 114.622 315.907 138.243 285.201 139.815Z" /><text
+       id=3D"text4957"
+       transform=3D"matrix(1 0 0 1 1833.68 703)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Packet path gets activated in </text>
+<text
+       id=3D"text4959"
+       transform=3D"matrix(1 0 0 1 1865.62 769)"
+       text-decoration=3D"underline"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Node</text>
+<text
+       id=3D"text4961"
+       transform=3D"matrix(1 0 0 1 1996.25 769)"
+       text-decoration=3D"underline"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text4963"
+       transform=3D"matrix(1 0 0 1 2014.58 769)"
+       text-decoration=3D"underline"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">A</text>
+<text
+       id=3D"text4965"
+       transform=3D"matrix(1 0 0 1 2064.68 769)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">when Feature</text>
+<text
+       id=3D"text4967"
+       transform=3D"matrix(1 0 0 1 2399.83 769)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text4969"
+       transform=3D"matrix(1 0 0 1 2418.17 769)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">1 is </text>
+<text
+       id=3D"text4971"
+       transform=3D"matrix(1 0 0 1 1898.42 835)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">enabled on </text>
+<text
+       id=3D"text4973"
+       transform=3D"matrix(1 0 0 1 2184.3 835)"
+       text-decoration=3D"underline"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">an interface</text>
+</g></svg>
diff --git a/doc/guides/prog_guide/img/feature_arc-2.svg b/doc/guides/prog_=
guide/img/feature_arc-2.svg
new file mode 100644
index 0000000000..990c96f306
--- /dev/null
+++ b/doc/guides/prog_guide/img/feature_arc-2.svg
@@ -0,0 +1,511 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+<!-- SPDX-License-Identifier: BSD-3-Clause -->
+<!-- Copyright(C) 2025 Marvell International Ltd. -->
+<svg
+   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
+   xmlns:cc=3D"http://creativecommons.org/ns#"
+   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
+   xmlns:svg=3D"http://www.w3.org/2000/svg"
+   xmlns=3D"http://www.w3.org/2000/svg"
+   id=3D"svg152"
+   version=3D"1.1"
+   overflow=3D"hidden"
+   xml:space=3D"preserve"
+   height=3D"1483"
+   width=3D"3471"><metadata
+     id=3D"metadata158"><rdf:RDF><cc:Work
+         rdf:about=3D""><dc:format>image/svg+xml</dc:format><dc:type
+           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" /><dc:t=
itle></dc:title></cc:Work></rdf:RDF></metadata><defs
+     id=3D"defs156" /><g
+     id=3D"g150"
+     transform=3D"translate(-637 -331)"><path
+       id=3D"path2"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B5E2"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M640.5 543.5C640.5 460.657 788.917 393.5 972 393.5 1155.08 393=
.5 1303.5 460.657 1303.5 543.5 1303.5 626.343 1155.08 693.5 972 693.5 788.9=
17 693.5 640.5 626.343 640.5 543.5Z" /><text
+       id=3D"text4"
+       transform=3D"matrix(1 0 0 1 831.669 574)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Node</text>
+<text
+       id=3D"text6"
+       transform=3D"matrix(1 0 0 1 1028.75 574)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text8"
+       transform=3D"matrix(1 0 0 1 1056.25 574)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">A</text>
+<path
+       id=3D"path10"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B5E2"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M640.5 1660.5C640.5 1577.66 788.917 1510.5 972 1510.5 1155.08 =
1510.5 1303.5 1577.66 1303.5 1660.5 1303.5 1743.34 1155.08 1810.5 972 1810.=
5 788.917 1810.5 640.5 1743.34 640.5 1660.5Z" /><text
+       id=3D"text12"
+       transform=3D"matrix(1 0 0 1 831.669 1691)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Node</text>
+<text
+       id=3D"text14"
+       transform=3D"matrix(1 0 0 1 1028.75 1691)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text16"
+       transform=3D"matrix(1 0 0 1 1056.25 1691)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">B</text>
+<path
+       id=3D"path18"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B050"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M1303.5 1132.5C1303.5 1049.66 1452.14 982.5 1635.5 982.5 1818.=
86 982.5 1967.5 1049.66 1967.5 1132.5 1967.5 1215.34 1818.86 1282.5 1635.5 =
1282.5 1452.14 1282.5 1303.5 1215.34 1303.5 1132.5Z" /><text
+       id=3D"text20"
+       transform=3D"matrix(1 0 0 1 1455.56 1159)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Feature </text>
+<text
+       id=3D"text22"
+       transform=3D"matrix(1 0 0 1 1728.84 1159)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text24"
+       transform=3D"matrix(1 0 0 1 1774.1 1159)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">1</text>
+<path
+       id=3D"path26"
+       fill=3D"#63666A"
+       d=3D"M974.937 693.5 974.938 1487.24 968.063 1487.24 968.062 693.5ZM=
985.25 1482.66 971.5 1510.16 957.75 1482.66Z" /><path
+       id=3D"path28"
+       fill=3D"#003967"
+       d=3D"M972.869 690.347 998.093 701.303 995.354 707.609 970.13 696.65=
3ZM1017.01 709.52 1042.23 720.476 1039.49 726.782 1014.27 715.826ZM1061.15 =
728.693 1086.37 739.649 1083.64 745.955 1058.41 734.999ZM1105.29 747.866 11=
30.52 758.822 1127.78 765.127 1102.55 754.172ZM1149.43 767.039 1174.66 777.=
995 1171.92 784.3 1146.69 773.344ZM1193.57 786.211 1218.8 797.167 1216.06 8=
03.473 1190.83 792.517ZM1237.71 805.384 1262.94 816.34 1260.2 822.646 1234.=
98 811.69ZM1281.86 824.557 1307.08 835.513 1304.34 841.819 1279.12 830.863Z=
M1326 843.73 1351.22 854.686 1348.48 860.992 1323.26 850.036ZM1370.14 862.9=
03 1395.36 873.859 1392.62 880.165 1367.4 869.209ZM1414.28 882.076 1439.5 8=
93.032 1436.76 899.338 1411.54 888.382ZM1458.42 901.249 1483.64 912.205 148=
0.9 918.511 1455.68 907.555ZM1502.56 920.422 1527.78 931.378 1525.04 937.68=
4 1499.82 926.728ZM1546.7 939.595 1571.92 950.551 1569.18 956.857 1543.96 9=
45.901ZM1590.84 958.768 1615.56 969.504 1612.82 975.81 1588.1 965.074ZM1615=
.46 958.219 1635.21 981.786 1604.51 983.442Z" /><path
+       id=3D"path30"
+       transform=3D"matrix(-1 0 0 1 1400.55 1238.5)"
+       fill=3D"#003967"
+       d=3D"M1.84062-2.90319 25.0662 11.8217 21.3849 17.6281-1.84062 2.903=
19ZM42.4853 22.8654 65.7109 37.5903 62.0297 43.3967 38.8041 28.6718ZM83.130=
1 48.634 106.356 63.359 102.674 69.1653 79.4488 54.4404ZM123.775 74.4026 14=
7 89.1276 143.319 94.934 120.094 80.209ZM164.42 100.171 187.645 114.896 183=
.964 120.703 160.738 105.978ZM205.064 125.94 228.29 140.665 224.609 146.471=
 201.383 131.746ZM245.709 151.708 268.935 166.433 265.253 172.24 242.028 15=
7.515ZM286.354 177.477 309.579 192.202 305.898 198.008 282.672 183.283ZM326=
.998 203.246 350.224 217.971 346.543 223.777 323.317 209.052ZM367.643 229.0=
14 390.869 243.739 387.188 249.546 363.962 234.821ZM408.288 254.783 411.537=
 256.843 407.856 262.649 404.607 260.589ZM413.188 245.68 429.052 272.017 39=
8.464 268.905Z" /><text
+       id=3D"text32"
+       transform=3D"matrix(-1.83697e-16 -1 1 -1.83697e-16 961.015 1340)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Static Packet</text>
+<text
+       id=3D"text34"
+       transform=3D"matrix(-1.83697e-16 -1 1 -1.83697e-16 961.015 945)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Path</text>
+<text
+       id=3D"text36"
+       transform=3D"matrix(-1.83697e-16 -1 1 -1.83697e-16 1040.01 1221)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 0</text>
+<text
+       id=3D"text38"
+       transform=3D"matrix(0.916122 0.4009 -0.4009 0.916122 1100.07 807)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 1</text>
+<path
+       id=3D"path40"
+       fill-rule=3D"evenodd"
+       fill=3D"#A6A6A6"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M3429.5 1088C3429.5 1004.88 3577.92 937.5 3761 937.5 3944.08 9=
37.5 4092.5 1004.88 4092.5 1088 4092.5 1171.12 3944.08 1238.5 3761 1238.5 3=
577.92 1238.5 3429.5 1171.12 3429.5 1088Z" /><text
+       id=3D"text42"
+       transform=3D"matrix(1 0 0 1 3583.93 1068)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Custom </text>
+<text
+       id=3D"text44"
+       transform=3D"matrix(1 0 0 1 3891.02 1068)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">=E2=80=93</text>
+<text
+       id=3D"text46"
+       transform=3D"matrix(1 0 0 1 3618.31 1167)"
+       font-size=3D"83"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Feature</text>
+<path
+       id=3D"path48"
+       fill=3D"#003967"
+       d=3D"M971.811 690.076 999.198 692.567 998.576 699.413 971.189 696.9=
23ZM1019.74 694.434 1047.13 696.924 1046.5 703.771 1019.12 701.281ZM1067.67=
 698.792 1095.05 701.282 1094.43 708.129 1067.04 705.639ZM1115.59 703.15 11=
42.98 705.64 1142.36 712.487 1114.97 709.996ZM1163.52 707.507 1190.91 709.9=
97 1190.28 716.844 1162.9 714.354ZM1211.45 711.865 1238.83 714.355 1238.21 =
721.202 1210.83 718.712ZM1259.38 716.223 1286.76 718.713 1286.14 725.56 125=
8.75 723.07ZM1307.3 720.581 1334.69 723.071 1334.07 729.917 1306.68 727.427=
ZM1355.23 724.938 1382.62 727.428 1381.99 734.275 1354.61 731.785ZM1403.16 =
729.296 1430.54 731.786 1429.92 738.633 1402.53 736.143ZM1451.08 733.654 14=
78.47 736.144 1477.85 742.991 1450.46 740.5ZM1499.01 738.011 1526.4 740.502=
 1525.78 747.348 1498.39 744.858ZM1546.94 742.369 1574.33 744.859 1573.7 75=
1.706 1546.32 749.216ZM1594.87 746.727 1622.25 749.217 1621.63 756.064 1594=
.24 753.574ZM1642.79 751.085 1670.18 753.575 1669.56 760.421 1642.17 757.93=
1ZM1690.72 755.442 1718.11 757.932 1717.49 764.779 1690.1 762.289ZM1738.65 =
759.8 1766.04 762.29 1765.41 769.137 1738.03 766.647ZM1786.58 764.158 1813.=
96 766.648 1813.34 773.495 1785.95 771.004ZM1834.5 768.515 1861.89 771.006 =
1861.27 777.852 1833.88 775.362ZM1882.43 772.873 1909.82 775.363 1909.19 78=
2.21 1881.81 779.72ZM1930.36 777.231 1957.74 779.721 1957.12 786.568 1929.7=
3 784.078ZM1978.28 781.589 2005.67 784.079 2005.05 790.925 1977.66 788.435Z=
M2026.21 785.946 2053.6 788.436 2052.98 795.283 2025.59 792.793ZM2074.14 79=
0.304 2101.53 792.794 2100.9 799.641 2073.52 797.151ZM2122.07 794.662 2149.=
45 797.152 2148.83 803.999 2121.44 801.509ZM2169.99 799.019 2197.38 801.51 =
2196.76 808.356 2169.37 805.866ZM2217.92 803.377 2245.31 805.867 2244.69 81=
2.714 2217.3 810.224ZM2265.85 807.735 2293.24 810.225 2292.61 817.072 2265.=
23 814.582ZM2313.78 812.093 2341.16 814.583 2340.54 821.43 2313.15 818.939Z=
M2361.7 816.45 2389.09 818.94 2388.47 825.787 2361.08 823.297ZM2409.63 820.=
808 2437.02 823.298 2436.4 830.145 2409.01 827.655ZM2457.56 825.166 2484.95=
 827.656 2484.32 834.503 2456.94 832.013ZM2505.49 829.523 2532.87 832.014 2=
532.25 838.86 2504.86 836.37ZM2553.41 833.881 2580.8 836.371 2580.18 843.21=
8 2552.79 840.728ZM2601.34 838.239 2628.73 840.729 2628.1 847.576 2600.72 8=
45.086ZM2649.27 842.597 2676.65 845.087 2676.03 851.934 2648.64 849.443ZM26=
97.19 846.954 2724.58 849.445 2723.96 856.291 2696.57 853.801ZM2745.12 851.=
312 2772.51 853.802 2771.89 860.649 2744.5 858.159ZM2793.05 855.67 2820.44 =
858.16 2819.81 865.007 2792.43 862.517ZM2840.98 860.028 2868.36 862.518 286=
7.74 869.364 2840.35 866.874ZM2888.9 864.385 2916.29 866.875 2915.67 873.72=
2 2888.28 871.232ZM2936.83 868.743 2964.22 871.233 2963.59 878.08 2936.21 8=
75.59ZM2984.76 873.101 3012.14 875.591 3011.52 882.438 2984.14 879.947ZM303=
2.68 877.458 3060.07 879.949 3059.45 886.795 3032.06 884.305ZM3080.61 881.8=
16 3108 884.306 3107.38 891.153 3079.99 888.663ZM3128.54 886.174 3155.93 88=
8.664 3155.3 895.511 3127.92 893.021ZM3176.47 890.532 3203.85 893.022 3203.=
23 899.869 3175.84 897.378ZM3224.39 894.889 3251.78 897.379 3251.16 904.226=
 3223.77 901.736ZM3272.32 899.247 3299.71 901.737 3299.09 908.584 3271.7 90=
6.094ZM3320.25 903.605 3347.64 906.095 3347.01 912.942 3319.63 910.452ZM336=
8.18 907.963 3395.56 910.453 3394.94 917.299 3367.55 914.809ZM3416.1 912.32=
 3443.49 914.81 3442.87 921.657 3415.48 919.167ZM3464.03 916.678 3491.42 91=
9.168 3490.8 926.015 3463.41 923.525ZM3511.96 921.036 3539.34 923.526 3538.=
72 930.373 3511.34 927.882ZM3559.89 925.393 3587.27 927.884 3586.65 934.73 =
3559.26 932.24ZM3607.81 929.751 3630.27 931.793 3629.65 938.64 3607.19 936.=
598ZM3626.64 921.108 3652.78 937.292 3624.15 948.495Z" /><text
+       id=3D"text50"
+       transform=3D"matrix(0.993978 0.109578 -0.109578 0.993978 1324.46 70=
4)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 3</text>
+<path
+       id=3D"path52"
+       fill-rule=3D"evenodd"
+       fill=3D"#00B050"
+       stroke-miterlimit=3D"8"
+       stroke-width=3D"6.875"
+       stroke=3D"#212322"
+       d=3D"M2326.5 1136.5C2326.5 1053.66 2475.14 986.5 2658.5 986.5 2841.=
86 986.5 2990.5 1053.66 2990.5 1136.5 2990.5 1219.34 2841.86 1286.5 2658.5 =
1286.5 2475.14 1286.5 2326.5 1219.34 2326.5 1136.5Z" /><text
+       id=3D"text54"
+       transform=3D"matrix(1 0 0 1 2478.16 1163)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">Feature </text>
+<text
+       id=3D"text56"
+       transform=3D"matrix(1 0 0 1 2751.44 1163)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">-</text>
+<text
+       id=3D"text58"
+       transform=3D"matrix(1 0 0 1 2796.7 1163)"
+       font-size=3D"73"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#FFFFFF">2</text>
+<path
+       id=3D"path60"
+       fill=3D"#003967"
+       d=3D"M972.27 690.15 999.071 696.312 997.53 703.012 970.73 696.85ZM1=
019.17 700.934 1045.97 707.096 1044.43 713.796 1017.63 707.634ZM1066.07 711=
.717 1092.87 717.88 1091.33 724.58 1064.53 718.417ZM1112.97 722.501 1139.77=
 728.663 1138.23 735.363 1111.43 729.201ZM1159.88 733.285 1186.68 739.447 1=
185.14 746.147 1158.33 739.985ZM1206.78 744.069 1233.58 750.231 1232.04 756=
.931 1205.24 750.769ZM1253.68 754.853 1280.48 761.015 1278.94 767.715 1252.=
14 761.553ZM1300.58 765.636 1327.38 771.799 1325.84 778.499 1299.04 772.336=
ZM1347.48 776.42 1374.28 782.582 1372.74 789.282 1345.94 783.12ZM1394.38 78=
7.204 1421.18 793.366 1419.64 800.066 1392.84 793.904ZM1441.28 797.988 1468=
.08 804.15 1466.54 810.85 1439.74 804.688ZM1488.18 808.772 1514.98 814.934 =
1513.44 821.634 1486.64 815.472ZM1535.08 819.555 1561.89 825.718 1560.34 83=
2.418 1533.54 826.255ZM1581.99 830.339 1608.79 836.501 1607.25 843.201 1580=
.45 837.039ZM1628.89 841.123 1655.69 847.285 1654.15 853.985 1627.35 847.82=
3ZM1675.79 851.907 1702.59 858.069 1701.05 864.769 1674.25 858.607ZM1722.69=
 862.691 1749.49 868.853 1747.95 875.553 1721.15 869.391ZM1769.59 873.474 1=
796.39 879.637 1794.85 886.337 1768.05 880.175ZM1816.49 884.258 1843.29 890=
.42 1841.75 897.121 1814.95 890.958ZM1863.39 895.042 1890.19 901.204 1888.6=
5 907.904 1861.85 901.742ZM1910.29 905.826 1937.1 911.988 1935.55 918.688 1=
908.75 912.526ZM1957.2 916.61 1984 922.772 1982.46 929.472 1955.66 923.31ZM=
2004.1 927.393 2030.9 933.556 2029.36 940.256 2002.56 934.094ZM2051 938.177=
 2077.8 944.339 2076.26 951.04 2049.46 944.877ZM2097.9 948.961 2124.7 955.1=
23 2123.16 961.823 2096.36 955.661ZM2144.8 959.745 2171.6 965.907 2170.06 9=
72.607 2143.26 966.445ZM2191.7 970.529 2218.5 976.691 2216.96 983.391 2190.=
16 977.229ZM2238.6 981.312 2265.4 987.475 2263.86 994.175 2237.06 988.013ZM=
2285.5 992.096 2312.31 998.258 2310.76 1004.96 2283.96 998.796ZM2332.41 100=
2.88 2359.21 1009.04 2357.67 1015.74 2330.87 1009.58ZM2379.31 1013.66 2406.=
06 1019.81 2404.52 1026.52 2377.77 1020.36ZM2403.91 1008.74 2427.62 1028.3 =
2397.74 1035.54Z" /><path
+       id=3D"path62"
+       transform=3D"matrix(-1 0 0 1 2658.15 1286.5)"
+       fill=3D"#003967"
+       d=3D"M0.62373-3.38044 27.6672 1.6094 26.4198 8.37028-0.62373 3.3804=
4ZM47.9499 5.35178 74.9934 10.3416 73.7459 17.1025 46.7024 12.1127ZM95.276 =
14.084 122.32 19.0738 121.072 25.8347 94.0286 20.8449ZM142.602 22.8162 169.=
646 27.8061 168.398 34.5669 141.355 29.5771ZM189.928 31.5484 216.972 36.538=
3 215.724 43.2991 188.681 38.3093ZM237.254 40.2806 264.298 45.2705 263.051 =
52.0314 236.007 47.0415ZM284.581 49.0129 311.624 54.0027 310.377 60.7636 28=
3.333 55.7737ZM331.907 57.7451 358.95 62.7349 357.703 69.4958 330.659 64.50=
6ZM379.233 66.4773 406.276 71.4671 405.029 78.228 377.985 73.2382ZM426.559 =
75.2095 453.603 80.1994 452.355 86.9602 425.312 81.9704ZM473.885 83.9417 50=
0.929 88.9316 499.681 95.6925 472.638 90.7026ZM521.211 92.674 548.255 97.66=
38 547.008 104.425 519.964 99.4348ZM568.538 101.406 595.581 106.396 594.334=
 113.157 567.29 108.167ZM615.864 110.138 642.907 115.128 641.66 121.889 614=
.616 116.899ZM663.19 118.871 690.233 123.86 688.986 130.621 661.942 125.631=
ZM710.516 127.603 737.56 132.593 736.312 139.354 709.269 134.364ZM757.842 1=
36.335 784.886 141.325 783.638 148.086 756.595 143.096ZM805.168 145.067 832=
.212 150.057 830.964 156.818 803.921 151.828ZM852.494 153.799 879.538 158.7=
89 878.29 165.55 851.247 160.56ZM899.82 162.532 926.864 167.522 925.617 174=
.282 898.573 169.293ZM947.147 171.264 974.19 176.254 972.943 183.015 945.89=
9 178.025ZM994.473 179.996 1021.52 184.986 1020.27 191.747 993.225 186.757Z=
M1041.8 188.728 1068.84 193.718 1067.59 200.479 1040.55 195.489ZM1089.12 19=
7.461 1116.17 202.45 1114.92 209.211 1087.88 204.221ZM1136.45 206.193 1163.=
49 211.183 1162.25 217.943 1135.2 212.954ZM1183.78 214.925 1210.82 219.915 =
1209.57 226.676 1182.53 221.686ZM1231.1 223.657 1258.15 228.647 1256.9 235.=
408 1229.86 230.418ZM1278.43 232.389 1305.47 237.379 1304.23 244.14 1277.18=
 239.15ZM1325.76 241.122 1352.8 246.111 1351.55 252.872 1324.51 247.883ZM13=
73.08 249.854 1400.13 254.844 1398.88 261.605 1371.83 256.615ZM1420.41 258.=
586 1429.74 260.308 1428.49 267.068 1419.16 265.347ZM1427.1 249.334 1451.65=
 267.846 1422.11 276.378Z" /><path
+       id=3D"path64"
+       transform=3D"matrix(-1 0 0 1 3760.78 1238.5)"
+       fill=3D"#003967"
+       d=3D"M0.422723-3.41141 27.714-0.0296238 26.8685 6.79319-0.422723 3.=
41141ZM48.1824 2.50672 75.4737 5.8885 74.6283 12.7113 47.337 9.32953ZM95.94=
22 8.42484 123.233 11.8066 122.388 18.6294 95.0967 15.2477ZM143.702 14.343 =
170.993 17.7248 170.148 24.5476 142.856 21.1658ZM191.462 20.2611 218.753 23=
.6429 217.907 30.4657 190.616 27.0839ZM239.221 26.1792 266.513 29.561 265.6=
67 36.3838 238.376 33.002ZM286.981 32.0973 314.272 35.4791 313.427 42.3019 =
286.136 38.9202ZM334.741 38.0155 362.032 41.3972 361.187 48.2201 333.895 44=
.8383ZM382.501 43.9336 409.792 47.3154 408.946 54.1382 381.655 50.7564ZM430=
.26 49.8517 457.552 53.2335 456.706 60.0563 429.415 56.6745ZM478.02 55.7698=
 505.311 59.1516 504.466 65.9744 477.175 62.5927ZM525.78 61.688 553.071 65.=
0697 552.226 71.8926 524.934 68.5108ZM573.539 67.6061 600.831 70.9879 599.9=
85 77.8107 572.694 74.4289ZM621.299 73.5242 648.59 76.906 647.745 83.7288 6=
20.454 80.347ZM669.059 79.4423 696.35 82.8241 695.505 89.6469 668.213 86.26=
52ZM716.819 85.3605 744.11 88.7423 743.264 95.5651 715.973 92.1833ZM764.578=
 91.2786 791.87 94.6604 791.024 101.483 763.733 98.1014ZM812.338 97.1967 83=
9.629 100.579 838.784 107.401 811.493 104.02ZM860.098 103.115 887.389 106.4=
97 886.544 113.319 859.253 109.938ZM907.858 109.033 935.149 112.415 934.304=
 119.238 907.012 115.856ZM955.617 114.951 982.909 118.333 982.063 125.156 9=
54.772 121.774ZM1003.38 120.869 1030.67 124.251 1029.82 131.074 1002.53 127=
.692ZM1051.14 126.787 1078.43 130.169 1077.58 136.992 1050.29 133.61ZM1098.=
9 132.705 1126.19 136.087 1125.34 142.91 1098.05 139.528ZM1146.66 138.624 1=
173.95 142.005 1173.1 148.828 1145.81 145.446ZM1194.42 144.542 1221.71 147.=
924 1220.86 154.746 1193.57 151.365ZM1242.18 150.46 1269.47 153.842 1268.62=
 160.664 1241.33 157.283ZM1289.94 156.378 1317.23 159.76 1316.38 166.583 12=
89.09 163.201ZM1337.7 162.296 1364.99 165.678 1364.14 172.501 1336.85 169.1=
19ZM1385.45 168.214 1412.75 171.596 1411.9 178.419 1384.61 175.037ZM1433.21=
 174.132 1460.51 177.514 1459.66 184.337 1432.37 180.955ZM1480.97 180.051 1=
508.27 183.432 1507.42 190.255 1480.13 186.873ZM1528.73 185.969 1556.03 189=
.35 1555.18 196.173 1527.89 192.791ZM1576.49 191.887 1603.78 195.269 1602.9=
4 202.091 1575.65 198.71ZM1624.25 197.805 1651.54 201.187 1650.7 208.009 16=
23.41 204.628ZM1672.01 203.723 1699.3 207.105 1698.46 213.928 1671.17 210.5=
46ZM1719.77 209.641 1747.06 213.023 1746.22 219.846 1718.93 216.464ZM1767.5=
3 215.559 1794.82 218.941 1793.98 225.764 1766.69 222.382ZM1815.29 221.477 =
1842.58 224.859 1841.74 231.682 1814.45 228.3ZM1863.05 227.395 1890.34 230.=
777 1889.5 237.6 1862.21 234.218ZM1910.81 233.314 1938.1 236.695 1937.26 24=
3.518 1909.97 240.136ZM1958.57 239.232 1985.86 242.613 1985.02 249.436 1957=
.73 246.054ZM2006.33 245.15 2033.62 248.532 2032.78 255.354 2005.49 251.973=
ZM2054.09 251.068 2081.38 254.45 2080.54 261.273 2053.25 257.891ZM2101.85 2=
56.986 2129.14 260.368 2128.3 267.191 2101 263.809ZM2149.61 262.904 2176.9 =
266.286 2176.06 273.109 2148.76 269.727ZM2197.37 268.822 2224.66 272.204 22=
23.82 279.027 2196.52 275.645ZM2245.13 274.74 2272.42 278.122 2271.58 284.9=
45 2244.28 281.563ZM2292.89 280.659 2320.18 284.04 2319.34 290.863 2292.04 =
287.481ZM2340.65 286.577 2367.94 289.958 2367.09 296.781 2339.8 293.399ZM23=
88.41 292.495 2415.7 295.877 2414.85 302.699 2387.56 299.318ZM2436.17 298.4=
13 2463.46 301.795 2462.61 308.618 2435.32 305.236ZM2483.93 304.331 2511.22=
 307.713 2510.37 314.536 2483.08 311.154ZM2531.69 310.249 2531.97 310.284 2=
531.12 317.107 2530.84 317.072ZM2528.68 299.485 2554.28 316.512 2525.29 326=
.776Z" /><text
+       id=3D"text66"
+       transform=3D"matrix(0.974105 0.226098 -0.226098 0.974105 1319.22 82=
0)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 2</text>
+<text
+       id=3D"text68"
+       transform=3D"matrix(1 0 0 1 1572.39 1639)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">First Feature</text>
+<text
+       id=3D"text70"
+       transform=3D"matrix(1 0 0 1 1505.08 1716)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">For Interface </text>
+<text
+       id=3D"text72"
+       transform=3D"matrix(1 0 0 1 1884.92 1716)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">=E2=80=93</text>
+<text
+       id=3D"text74"
+       transform=3D"matrix(1 0 0 1 1938.2 1716)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">0,1</text>
+<path
+       id=3D"path76"
+       fill=3D"#63666A"
+       d=3D"M1764.3 1561.88 1643.18 1304.21 1647.32 1302.26 1768.45 1559.9=
3ZM1634.76 1313.24 1635.5 1282.5 1659.64 1301.54Z" /><path
+       id=3D"path78"
+       fill=3D"#63666A"
+       d=3D"M1967.54 1129.06 1995.04 1129.38 1994.96 1136.26 1967.46 1135.=
94ZM2015.66 1129.62 2043.16 1129.94 2043.08 1136.82 2015.58 1136.5ZM2063.78=
 1130.18 2091.28 1130.5 2091.2 1137.38 2063.7 1137.06ZM2111.91 1130.74 2139=
.4 1131.06 2139.32 1137.94 2111.83 1137.62ZM2160.03 1131.3 2187.53 1131.62 =
2187.45 1138.49 2159.95 1138.17ZM2208.15 1131.86 2235.65 1132.18 2235.57 11=
39.05 2208.07 1138.73ZM2256.27 1132.42 2283.77 1132.74 2283.69 1139.61 2256=
.19 1139.29ZM2299.05 1122.6 2326.39 1136.67 2298.73 1150.1Z" /><text
+       id=3D"text80"
+       transform=3D"matrix(1 0 0 1 2008.67 1117)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 1 </text>
+<text
+       id=3D"text82"
+       transform=3D"matrix(1 0 0 1 2307.19 1624)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Next Feature to Feature</text>
+<text
+       id=3D"text84"
+       transform=3D"matrix(1 0 0 1 3021.04 1624)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text86"
+       transform=3D"matrix(1 0 0 1 3042.24 1624)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">1</text>
+<text
+       id=3D"text88"
+       transform=3D"matrix(1 0 0 1 2493.66 1701)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">for Interface</text>
+<text
+       id=3D"text90"
+       transform=3D"matrix(1 0 0 1 2834.55 1701)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text92"
+       transform=3D"matrix(1 0 0 1 2855.74 1701)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">0</text>
+<path
+       id=3D"path94"
+       fill=3D"#63666A"
+       d=3D"M2690.94 1546.47 2659.26 1309.52 2663.81 1308.91 2695.48 1545.=
86ZM2648.51 1315.58 2658.5 1286.5 2675.77 1311.94Z" /><text
+       id=3D"text96"
+       transform=3D"matrix(1 0 0 1 3080.93 1096)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 0</text>
+<path
+       id=3D"path98"
+       transform=3D"matrix(1 0 0 -1 2990.5 1125.64)"
+       fill=3D"#63666A"
+       d=3D"M0.219926-3.43046 27.6636-1.67105 27.2237 5.18986-0.219926 3.4=
3046ZM48.2463-0.351496 75.69 1.40791 75.2501 8.26883 47.8065 6.50942ZM96.27=
28 2.72747 123.716 4.48687 123.277 11.3478 95.8329 9.58838ZM144.299 5.80643=
 171.743 7.56583 171.303 14.4267 143.859 12.6673ZM192.326 8.88539 219.769 1=
0.6448 219.329 17.5057 191.886 15.7463ZM240.352 11.9644 267.796 13.7238 267=
.356 20.5847 239.912 18.8253ZM288.378 15.0433 315.822 16.8027 315.382 23.66=
36 287.939 21.9042ZM336.405 18.1223 363.848 19.8817 363.409 26.7426 335.965=
 24.9832ZM384.431 21.2012 411.875 22.9606 411.435 29.8216 383.991 28.0622ZM=
412.357 12.6579 438.921 28.1391 410.598 40.1016Z" /><text
+       id=3D"text100"
+       transform=3D"matrix(1 0 0 1 3280.81 1634)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Next Feature to Feature</text>
+<text
+       id=3D"text102"
+       transform=3D"matrix(1 0 0 1 3994.67 1634)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text104"
+       transform=3D"matrix(1 0 0 1 4015.87 1634)"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">1</text>
+<text
+       id=3D"text106"
+       transform=3D"matrix(1 0 0 1 3480.19 1711)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">for Interface</text>
+<text
+       id=3D"text108"
+       transform=3D"matrix(1 0 0 1 3821.08 1711)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text110"
+       transform=3D"matrix(1 0 0 1 3839.41 1711)"
+       font-size=3D"55"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">1</text>
+<path
+       id=3D"path112"
+       transform=3D"matrix(1 0 0 -1 3666.5 1556.2)"
+       fill=3D"#63666A"
+       d=3D"M2.19695-0.652044 89.9684 295.078 85.5745 296.382-2.19695 0.65=
2044ZM99.6489 287.424 94.2918 317.699 73.2856 295.248Z" /><path
+       id=3D"path114"
+       fill=3D"#63666A"
+       d=3D"M1867.07 1025.81 1867.42 1018.62 1868.49 1011.28 1870.26 1003.=
97 1872.27 997.989 1878.79 1000.18 1876.82 1006.02 1876.91 1005.73 1875.21 =
1012.74 1875.27 1012.43 1874.25 1019.45 1874.28 1019.12 1873.93 1026.15ZM18=
81.7 978.819 1883.97 975.115 1888.98 968.018 1894.59 960.969 1898.61 956.43=
7 1903.75 960.998 1899.8 965.462 1899.91 965.323 1894.42 972.222 1894.54 97=
2.063 1889.65 978.99 1889.77 978.808 1887.55 982.418ZM1913.37 941.594 1914.=
93 940.127 1922.84 933.284 1931.3 926.497 1934.85 923.839 1938.97 929.343 1=
935.46 931.966 1935.55 931.895 1927.19 938.606 1927.29 938.525 1919.48 945.=
281 1919.58 945.188 1918.07 946.609ZM1951.82 911.768 1959.83 906.488 1970.3=
7 899.942 1975.26 897.066 1978.75 902.994 1973.89 905.849 1973.96 905.805 1=
963.5 912.303 1963.58 912.254 1955.6 917.508ZM1993.34 886.825 2004.89 880.7=
19 2017.33 874.457 2017.91 874.18 2020.88 880.379 2020.34 880.642 2020.39 8=
80.613 2008.01 886.844 2008.07 886.812 1996.55 892.902ZM2036.62 865.351 204=
3.57 862.173 2057.34 856.155 2061.9 854.247 2064.55 860.591 2060.01 862.488=
 2060.06 862.466 2046.35 868.46 2046.4 868.437 2039.48 871.603ZM2081.04 846=
.419 2086.12 844.388 2101.11 838.643 2106.81 836.551 2109.18 843.005 2103.5=
1 845.089 2103.55 845.072 2088.6 850.799 2088.65 850.78 2083.59 852.803ZM21=
26.26 829.558 2132.27 827.446 2152.4 820.792 2154.55 827.32 2134.45 833.964=
 2134.52 833.942 2128.55 836.044ZM2172.11 814.467 2198.42 806.467 2200.42 8=
13.044 2174.11 821.045ZM2218.36 800.882 2234.13 796.472 2244.98 793.688 224=
6.69 800.347 2235.88 803.122 2235.95 803.103 2220.21 807.503ZM2264.95 788.5=
58 2270.62 787.103 2291.76 782.131 2293.34 788.824 2272.23 793.788 2272.3 7=
93.771 2266.66 795.217ZM2311.92 777.466 2338.81 771.695 2340.25 778.417 231=
3.36 784.188ZM2359.09 767.584 2386.08 762.324 2387.39 769.072 2360.4 774.33=
2ZM2406.45 758.735 2426.94 755.133 2433.62 754.084 2434.69 760.876 2428.04 =
761.92 2428.1 761.91 2407.64 765.506ZM2453.99 750.883 2468.18 748.653 2481.=
26 746.839 2482.2 753.649 2469.16 755.459 2469.22 755.45 2455.06 757.674ZM2=
501.69 744.003 2510.12 742.833 2529.03 740.551 2529.85 747.376 2510.97 749.=
655 2511.03 749.647 2502.63 750.813ZM2549.51 738.08 2552.66 737.699 2576.92=
 735.21 2577.62 742.049 2553.39 744.535 2553.45 744.529 2550.33 744.905ZM25=
97.5 733.13 2624.9 730.813 2625.48 737.664 2598.08 739.98ZM2645.52 729.185 =
2672.96 727.365 2673.42 734.224 2645.98 736.045ZM2693.62 726.19 2721.08 724=
.875 2721.41 731.742 2693.94 733.057ZM2741.76 724.16 2769.25 723.361 2769.4=
5 730.233 2741.96 731.032ZM2789.94 723.116 2815.78 722.863 2817.49 722.875 =
2817.45 729.749 2815.76 729.738 2815.82 729.738 2790.01 729.991ZM2838.12 72=
3.017 2860.13 723.169 2865.66 723.283 2865.52 730.156 2860.01 730.043 2860.=
06 730.044 2838.07 729.892ZM2886.28 723.705 2904.38 724.076 2913.82 724.394=
 2913.59 731.265 2904.17 730.948 2904.22 730.949 2886.14 730.579ZM2934.43 7=
25.09 2948.46 725.563 2961.96 726.194 2961.64 733.061 2948.16 732.432 2948.=
21 732.433 2934.2 731.961ZM2982.56 727.157 2992.28 727.611 3010.06 728.671 =
3009.65 735.533 2991.9 734.476 2991.94 734.478 2982.24 734.024ZM3030.65 729=
.897 3035.76 730.202 3058.13 731.82 3057.63 738.677 3035.28 737.06 3035.33 =
737.063 3030.24 736.76ZM3078.7 733.307 3078.8 733.315 3106.14 735.64 3105.5=
6 742.49 3078.24 740.167 3078.28 740.17 3078.2 740.164ZM3126.73 737.46 3154=
.1 740.137 3153.43 746.98 3126.06 744.302ZM3174.65 742.296 3201.99 745.322 =
3201.23 752.155 3173.9 749.129ZM3222.5 747.831 3244.91 750.607 3249.83 751.=
283 3248.9 758.094 3243.99 757.421 3244.04 757.427 3221.66 754.654ZM3270.26=
 754.089 3284.49 756.043 3297.53 758.016 3296.5 764.813 3283.48 762.844 328=
3.53 762.851 3269.33 760.9ZM3317.92 761.1 3323.12 761.886 3345.11 765.531 3=
343.99 772.314 3322.02 768.673 3322.07 768.68 3316.89 767.898ZM3365.5 768.9=
83 3392.56 773.88 3391.33 780.645 3364.27 775.748ZM3412.86 777.806 3432.45 =
781.666 3439.87 783.257 3438.43 789.979 3431.04 788.394 3431.09 788.406 341=
1.53 784.551ZM3460.04 787.579 3466.42 788.945 3486.91 793.718 3485.35 800.4=
14 3464.89 795.648 3464.95 795.661 3458.6 794.301ZM3507.01 798.523 3514.75 =
800.443 3530.13 804.42 3533.71 805.389 3531.92 812.026 3528.35 811.062 3528=
.39 811.071 3513.05 807.103 3513.08 807.111 3505.36 805.196ZM3553.64 810.86=
9 3559.7 812.577 3573.87 816.753 3580.09 818.669 3578.07 825.239 3571.87 82=
3.33 3571.91 823.342 3557.77 819.178 3557.81 819.189 3551.77 817.487ZM3599.=
8 824.913 3600.96 825.287 3613.84 829.641 3625.89 833.912 3623.59 840.391 3=
611.57 836.129 3611.62 836.146 3598.78 831.808 3598.82 831.823 3597.69 831.=
457ZM3645.28 841.269 3649.75 843.025 3660.77 847.587 3670.76 851.959 3668 8=
58.257 3658.04 853.898 3658.11 853.926 3647.15 849.389 3647.21 849.413 3642=
.77 847.669ZM3689.52 860.9 3690.83 861.548 3699.81 866.289 3708.27 871.071 =
3713.79 874.438 3710.21 880.308 3704.74 876.97 3704.83 877.027 3696.47 872.=
297 3696.56 872.346 3687.66 867.65 3687.74 867.692 3686.47 867.064ZM3731.16=
 886.32 3736.55 890.61 3742.19 895.601 3747.24 900.64 3751.56 905.593 3746.=
37 910.111 3742.13 905.247 3742.3 905.421 3737.41 900.539 3737.56 900.68 37=
32.06 895.818 3732.2 895.935 3726.88 891.701ZM3764.7 906.97 3761.07 937.5 3=
738.83 916.273Z" /><text
+       id=3D"text116"
+       transform=3D"matrix(0.998741 -0.050158 0.050158 0.998741 2571.92 79=
3)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 0</text>
+<text
+       id=3D"text118"
+       transform=3D"matrix(1 0 0 1 1933.46 420)"
+       text-decoration=3D"underline"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Interface</text>
+<text
+       id=3D"text120"
+       transform=3D"matrix(1 0 0 1 2199.86 420)"
+       text-decoration=3D"underline"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text122"
+       transform=3D"matrix(1 0 0 1 2221.06 420)"
+       text-decoration=3D"underline"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">0</text>
+<text
+       id=3D"text124"
+       transform=3D"matrix(1 0 0 1 1842.64 497)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Enabled Features</text>
+<text
+       id=3D"text126"
+       transform=3D"matrix(1 0 0 1 2828.07 412)"
+       text-decoration=3D"underline"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Interface</text>
+<text
+       id=3D"text128"
+       transform=3D"matrix(1 0 0 1 3094.47 412)"
+       text-decoration=3D"underline"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">-</text>
+<text
+       id=3D"text130"
+       transform=3D"matrix(1 0 0 1 3115.67 412)"
+       text-decoration=3D"underline"
+       font-size=3D"64"
+       font-weight=3D"700"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">1</text>
+<text
+       id=3D"text132"
+       transform=3D"matrix(1 0 0 1 2737.25 489)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">Enabled Features</text>
+<path
+       id=3D"path134"
+       transform=3D"matrix(-1 0 0 1 1993.37 532.5)"
+       fill=3D"#63666A"
+       d=3D"M0.513174-0.254726 224.189 450.366 223.163 450.875-0.513174 0.=
254726ZM233.954 440.402 233.865 471.148 209.322 452.629Z" /><path
+       id=3D"path136"
+       fill=3D"#63666A"
+       d=3D"M2095.86 523.058 2640.92 971.389 2640.19 972.274 2095.14 523.9=
43ZM2645.75 958.301 2658.26 986.389 2628.28 979.539Z" /><path
+       id=3D"path138"
+       transform=3D"matrix(-1 0 0 1 2834.66 536.5)"
+       fill=3D"#63666A"
+       d=3D"M0.307156-0.48362 857.122 543.695 856.508 544.663-0.307156 0.4=
8362ZM860.318 530.115 876.16 556.465 845.574 553.329Z" /><path
+       id=3D"path140"
+       fill=3D"#63666A"
+       d=3D"M2990.87 529.062 3509.46 966.033 3508.73 966.91 2990.13 529.93=
8ZM3514.45 953.003 3526.62 981.238 3496.73 974.033Z" /><path
+       id=3D"path142"
+       fill=3D"#63666A"
+       d=3D"M2381.7 431.962 3739.81 929.039 3739.42 930.115 2381.3 433.038=
ZM3740.03 915.088 3761.13 937.452 3730.58 940.913Z" /><text
+       id=3D"text144"
+       transform=3D"matrix(0.838284 -0.545233 0.545233 0.838284 1136.13 14=
61)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 2 </text>
+<text
+       id=3D"text146"
+       transform=3D"matrix(0.98675 -0.162247 0.162247 0.98675 2069.25 1383=
)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 0 </text>
+<text
+       id=3D"text148"
+       transform=3D"matrix(0.994324 -0.106397 0.106397 0.994324 2994.86 13=
16)"
+       font-size=3D"64"
+       font-weight=3D"400"
+       font-style=3D"italic"
+       font-family=3D"Arial,Arial_MSFontService,sans-serif"
+       fill=3D"#212322">edge =3D=3D 0 </text>
+</g></svg>
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/=
release_25_07.rst
index 6b070801de..9740274a16 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -78,6 +78,13 @@ New Features

   See the :doc:`../cryptodevs/zsda` guide for more details on the new driv=
er.

+* **Added feature arc abstraction in graph library.**
+
+  Feature arc helps ``rte_graph`` based applications to manage multiple ne=
twork
+  protocols/features with runtime configurability, in-built node-reusabili=
ty
+  and optimized control/data plane synchronization.
+
+  See section ``Graph feature arc`` in :doc:`../prog_guide/graph_lib` for =
more details.

 Removed Items
 -------------
diff --git a/lib/graph/graph_feature_arc.c b/lib/graph/graph_feature_arc.c
new file mode 100644
index 0000000000..6135b262d5
--- /dev/null
+++ b/lib/graph/graph_feature_arc.c
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#include <rte_graph_feature_arc.h>
+#include <eal_export.h>
+#include "graph_private.h"
+
+/* global feature arc list */
+static STAILQ_HEAD(, rte_graph_feature_arc_register) feature_arc_list =3D
+					STAILQ_HEAD_INITIALIZER(feature_arc_list);
+
+/* global feature arc list */
+static STAILQ_HEAD(, rte_graph_feature_register) feature_list =3D
+					STAILQ_HEAD_INITIALIZER(feature_list);
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_arc_register, 25.07);
+void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_registe=
r *reg,
+				      const char *caller_name, int lineno)
+{
+	RTE_SET_USED(caller_name);
+	RTE_SET_USED(lineno);
+	/* Do not validate arc registration here but as part of rte_graph_feature=
_arc_init() */
+	STAILQ_INSERT_TAIL(&feature_arc_list, reg, next_arc);
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_graph_feature_register, 25.07);
+void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
+				  const char *caller_name, int lineno)
+{
+	RTE_SET_USED(caller_name);
+	RTE_SET_USED(lineno);
+
+	/* Add to the feature_list*/
+	STAILQ_INSERT_TAIL(&feature_list, reg, next_feature);
+}
diff --git a/lib/graph/meson.build b/lib/graph/meson.build
index 0cb15442ab..1b2f493037 100644
--- a/lib/graph/meson.build
+++ b/lib/graph/meson.build
@@ -17,8 +17,10 @@ sources =3D files(
         'graph_pcap.c',
         'rte_graph_worker.c',
         'rte_graph_model_mcore_dispatch.c',
+        'graph_feature_arc.c',
 )
 headers =3D files('rte_graph.h', 'rte_graph_worker.h')
+headers +=3D files('rte_graph_feature_arc.h')
 indirect_headers +=3D files(
         'rte_graph_model_mcore_dispatch.h',
         'rte_graph_model_rtc.h',
diff --git a/lib/graph/rte_graph_feature_arc.h b/lib/graph/rte_graph_featur=
e_arc.h
new file mode 100644
index 0000000000..56d8f2f34c
--- /dev/null
+++ b/lib/graph/rte_graph_feature_arc.h
@@ -0,0 +1,270 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell International Ltd.
+ */
+
+#ifndef _RTE_GRAPH_FEATURE_ARC_H_
+#define _RTE_GRAPH_FEATURE_ARC_H_
+
+#include <assert.h>
+#include <errno.h>
+#include <signal.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_compat.h>
+#include <rte_debug.h>
+#include <rte_graph.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * @file
+ *
+ * rte_graph_feature_arc.h
+ *
+ * Define APIs and structures/variables with respect to feature arc
+ *
+ * - Feature arc(s)
+ * - Feature(s)
+ *
+ * In a typical network stack, often a protocol must be first enabled in
+ * control plane before any packet is steered for its processing in the
+ * dataplane. For eg: incoming IPv4 packets are routed only after a valid =
IPv4
+ * address is assigned to the received interface. In other words, often pa=
ckets
+ * received on an interface need to be steered to protocol not based on the
+ * packet content but based on whether the protocol is configured on the
+ * interface or not.
+ *
+ * Protocols can be enabled/disabled multiple times at runtime in the cont=
rol
+ * plane. Protocols enabled on one interface may not be enabled on another
+ * interface.
+ *
+ * When more than one protocols are present at a networking layer (say IPv=
4,
+ * IP tables, IPsec etc), it becomes imperative to steer packets (in datap=
lane)
+ * across each protocol processing in a defined sequential order. In ingre=
ss
+ * direction, stack decides to perform IPsec decryption first before IP
+ * validation while in egress direction IPsec encryption is performed afte=
r IP
+ * forwarding. In the case of IP tables, users can enable rules in any
+ * protocol order i.e. pre-routing or post-routing etc. This implies that
+ * protocols are configured differently at each networking layer and in ea=
ch
+ * traffic direction.
+ *
+ * A feature arc represents an ordered list of features/protocols nodes at=
 the
+ * given networking layer and in a given direction. It provides a high lev=
el
+ * abstraction to enable/disable features on an index at runtime and provi=
de a
+ * mechanism to steer packets across these feature nodes in a generic mann=
er.
+ * Here index corresponds to either interface index, route index, flow ind=
ex or
+ * classification index etc. as it is deemed suitable to configure protoco=
ls at
+ * the networking layer. Some typical examples of protocols which are
+ * configured based on
+ *
+ * - Interface Index (like IPv4 VRF, Port mirroring, Port based IPsec etc)
+ * - Routes Index (like Route based IPsec etc)
+ * - Flow index (like SDN)
+ * - Classification Index (like ACL based protocol steering)
+ *
+ * Feature arc also provides a way to steer packets from in-built DPDK *fe=
ature
+ * nodes* to out-of-tree *feature nodes* and vice-versa without any code
+ * changes required in DPDK in-built node's fast path functions. This way =
it
+ * allows application to override default packet path defined by in-built =
DPDK
+ * nodes.
+ *
+ * Features enabled on one index may not be enabled on another index hence
+ * packets received on an interface "X" should be treated independently fr=
om
+ * packets received on interface "Y".
+ *
+ * A given feature might consume packet (if it's configured to consume) or=
 may
+ * forward it to next enabled feature. For instance, "IPsec input" feature=
 may
+ * consume/drop all packets with "Protect" policy action while all packets=
 with
+ * policy action as "Bypass" may be forwarded to next enabled feature (wit=
h in
+ * same feature arc)
+ *
+ * A feature arc in a graph is represented via *start_node* and *end_node*.
+ * Feature nodes are added between start_node and end_node. Packets enter
+ * feature arc traversal via start_node while they exits from end_node. Pa=
ckets
+ * steering from start_node to feature nodes are controlled in control pla=
ne
+ * via rte_graph_feature_enable()/rte_graph_feature_disable().
+ *
+ * This library facilitates rte graph based applications to implement stack
+ * functionalities described above by providing "edge" to the next enabled
+ * feature node in fast path
+ *
+ */
+
+/** feature notifier callback called when feature is enabled/disabled */
+typedef void (*rte_graph_feature_change_notifier_cb_t)(const char *arc_nam=
e,
+						       const char *feature_name,
+						       rte_node_t feature_node_id,
+						       uint32_t index,
+						       bool enable_disable,
+						       uint16_t app_cookie);
+
+/** cb for overriding arc->max_indexes via RTE_GRAPH_FEATURE_REGISTER() */
+typedef uint16_t (*rte_graph_feature_override_index_cb_t)(void);
+
+/**
+ *  Feature registration structure provided to
+ *  RTE_GRAPH_FEATURE_REGISTER()
+ */
+struct rte_graph_feature_register {
+	/**
+	 * Pointer to next registered feature in the same arc.
+	 */
+	STAILQ_ENTRY(rte_graph_feature_register) next_feature;
+
+	/** Name of the arc which is registered either via
+	 * RTE_GRAPH_FEATURE_ARC_REGISTER() or via
+	 * rte_graph_feature_arc_create()
+	 */
+	const char *arc_name;
+
+	/** Name of the feature */
+	const char *feature_name;
+
+	/**
+	 * Node id of feature_node.
+	 *
+	 * Setting this field can be skipped if registering feature via
+	 * RTE_GRAPH_FEATURE_REGISTER()
+	 */
+	rte_node_t feature_node_id;
+
+	/**
+	 * Feature node process() function calling feature fast path APIs.
+	 *
+	 * If application calls rte_graph_feature_arc_init(), node->process()
+	 * provided in RTE_NODE_REGISTER() is overwritten by this
+	 * function.
+	 */
+	rte_node_process_t feature_process_fn;
+
+	/**
+	 * Pointer to Feature node registration
+	 *
+	 * Used when features are registered via
+	 * RTE_GRAPH_FEATURE_REGISTER().
+	 */
+	struct rte_node_register *feature_node;
+
+	/** Feature ordering constraints
+	 * runs_after: Name of the feature which must run before "this feature"
+	 * runs_before: Name of the feature which must run after "this feature"
+	 */
+	const char *runs_after;
+	const char *runs_before;
+
+	/**
+	 * Allow each feature registration to override arc->max_indexes
+	 *
+	 * If set, struct rte_graph_feature_arc_register::max_indexes is
+	 * calculated as follows (before calling rte_graph_feature_arc_create())
+	 *
+	 * max_indexes =3D rte_graph_feature_arc_register:max_indexes
+	 * FOR_EACH_FEATURE_REGISTER(arc, feat) {
+	 *   rte_graph_feature_arc_register:max_indexes =3D max(feat->override_in=
dex_cb(),
+	 *                                                    max_indexes)
+	 */
+	rte_graph_feature_override_index_cb_t override_index_cb;
+
+	/**
+	 * Callback for notifying any change in feature enable/disable state
+	 */
+	rte_graph_feature_change_notifier_cb_t notifier_cb;
+};
+
+/** Feature arc registration structure */
+struct rte_graph_feature_arc_register {
+	STAILQ_ENTRY(rte_graph_feature_arc_register) next_arc;
+
+	/** Name of the feature arc */
+	const char *arc_name;
+
+	/**
+	 * Maximum number of features supported in this feature arc.
+	 *
+	 * This field can be skipped for feature arc registration via
+	 * RTE_GRAPH_FEATURE_ARC_REGISTER().
+	 *
+	 * API internally sets this field by calculating number of
+	 * RTE_GRAPH_FEATURE_REGISTER() for every arc registration via
+	 * RTE_GRAPH_FEATURE_ARC_REGISTER()
+	 */
+	uint16_t max_features;
+
+	/**
+	 * Maximum number of indexes supported in this feature arc
+	 * Memory is allocated based on this field
+	 */
+	uint16_t max_indexes;
+
+	/** Start node of this arc */
+	struct rte_node_register *start_node;
+
+	/**
+	 * Feature arc specific process() function for Start node.
+	 * If application calls rte_graph_feature_arc_init(),
+	 * start_node->process() is replaced by this function
+	 */
+	rte_node_process_t start_node_feature_process_fn;
+
+	/** End feature node registration */
+	struct rte_graph_feature_register *end_feature;
+};
+
+/** constructor to register feature to an arc */
+#define RTE_GRAPH_FEATURE_REGISTER(reg)                                   =
              \
+	RTE_INIT(__rte_graph_feature_register_##reg)                             =
       \
+	{                                                                        =
       \
+		__rte_graph_feature_register(&reg, __func__, __LINE__);                 \
+	}
+
+/** constructor to register a feature arc */
+#define RTE_GRAPH_FEATURE_ARC_REGISTER(reg)                               =
              \
+	RTE_INIT(__rte_graph_feature_arc_register_##reg)                         =
       \
+	{                                                                        =
       \
+		__rte_graph_feature_arc_register(&reg, __func__, __LINE__);             \
+	}
+
+/**
+ * @internal
+ *
+ * function declaration for registering arc
+ *
+ * @param reg
+ *      Pointer to struct rte_graph_feature_arc_register
+ *  @param caller_name
+ *      Name of the function which is calling this API
+ *  @param lineno
+ *      Line number of the function which is calling this API
+ */
+__rte_experimental
+void __rte_graph_feature_arc_register(struct rte_graph_feature_arc_registe=
r *reg,
+				      const char *caller_name, int lineno);
+
+/**
+ * @internal
+ *
+ * function declaration for registering feature
+ *
+ * @param reg
+ *      Pointer to struct rte_graph_feature_register
+ * @param caller_name
+ *      Name of the function which is calling this API
+ * @param lineno
+ *      Line number of the function which is calling this API
+ */
+__rte_experimental
+void __rte_graph_feature_register(struct rte_graph_feature_register *reg,
+				  const char *caller_name, int lineno);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
--
2.43.0

