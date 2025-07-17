Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355F0C83F38
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 22:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 689014066A;
	Fri, 18 Jul 2025 00:09:49 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id A17B04066C
 for <dev@dpdk.org>; Fri, 18 Jul 2025 00:09:47 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id DF8311D00113;
 Thu, 17 Jul 2025 18:09:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 18:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1752790186; x=
 1752876586; bh=A0XJX2IIxFciNt/yAssQifTlAXexWGPbRwSqV3LYccM=; b=Z
 dZKLnvV23DgRNWzR6+16AdqeJ/R+exUDlIzF27xF9Ylh/9eOqLyxB8dteYtfx+Py
 s1w6aM2LjCrAwlLQEM+9YB9B5dE1UvavNYxMANoZV1Edkfl9mFewpHbeePu2i9Cw
 dinkoVSvPCtCfqY0bAo9cQwnyd7hPPzGot5tKLbikdA7lK/UWwG5YHdCoeun8F8N
 dEk4A2PXXqBU3Q/k7FIaNmH3X/z+wTayZWLU5augtNfDNp1vBmYVhikhtteMPNrr
 tfqW9OnNbfUb3ycaX6icrd/X1x2G6lIVB2gSeoFuI6xfFox2zvPBmM5G/TEyA3Am
 MIlUqQ+dTrthB57UBtWSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1752790186; x=1752876586; bh=A
 0XJX2IIxFciNt/yAssQifTlAXexWGPbRwSqV3LYccM=; b=Y09aV7w3P8Dyz4KX9
 iYHXch5z3NX5O2OkbiDYXfZsrAylon22cLyCi+VoKD33NCi9kXaxX1JoQnTPzqKy
 B/TcUq8vIUMWbU8VWi2uZ55mSgezyUp8RFlQLJOJp+IadeMTgUKa9WvaCfxAkP/x
 kiE55u6SpXu3rUsDXTSk/HAN33BtSpccZJKKZzv7FPqtkjJDkR/cgN34ZbjTPFAd
 SdkPQtDdr6vlw8wzzxN2o8Rn/dm0QscCxtD3yReyHjK7paTt/DlBPbKQ5Gg4+Fo6
 EIXNlOt4Q9TUgr1+OytiLkP8lhz1YQ0FDU0rhGLbRyHrxJzu5lHc4NcoqJodNphG
 5puaQ==
X-ME-Sender: <xms:qnR5aAovN_SZ7pEi3CaWji2LEO4sM8iBH_npeiCZQ_lKOX5li9_jhQ>
 <xme:qnR5aORe1AwamiNzjcDPRk_iKAMyY0BEjQXsPL5z39gEkegJpC9CRbBGYFtQcZWtZ
 UibLq5OzlkC-pvRTg>
X-ME-Received: <xmr:qnR5aC06RgRCGzkMrMbsyFmxq7D6ZR4Zf9zLjw71KWDzKmnp-RdM15mdyJetHtxRErpssunPJbY88a3n4sDZWDYrk61fDZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepuddtieegudevhfdvleetteegvdejtdeglefhveejjeehffefieeuudel
 ffejheevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhn
 rdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihgu
 ihgrrdgtohhmpdhrtghpthhtohepughsohhsnhhofihskhhisehnvhhiughirgdrtghomh
 dprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphht
 thhopegsihhnghiisehnvhhiughirgdrtghomhdprhgtphhtthhopehorhhikhgrsehnvh
 hiughirgdrtghomhdprhgtphhtthhopehsuhgrnhhmihhnghhmsehnvhhiughirgdrtgho
 mhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:qnR5aCDxMyUW_8SfrFTdBOsjAjxBdV_bWDrMEQyI_kNGz78-iwyq4g>
 <xmx:qnR5aGiIKQD2N5RDzo3L6ITMsCRkps5LGtlFGBgA4FCJsNmU1NM_lg>
 <xmx:qnR5aMMSW3pLr9Z4Nvzojh1au7xBYj4z4Pgo9zFQdL9DvPZRTAoYdw>
 <xmx:qnR5aO8sHjJttY0jJ7dRd4zdipfkDBdtClg-hSE7k3w7QTmCuK7x8Q>
 <xmx:qnR5aFs7HNihor_LD359EnQaiNEnrhvoDecZQxm5a9tu-gLKqf9tclsm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 18:09:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Maayan Kashani <mkashani@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 4/4] doc: add testpmd command examples in mlx5 guide
Date: Fri, 18 Jul 2025 00:05:44 +0200
Message-ID: <20250717220912.376503-5-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250717220912.376503-1-thomas@monjalon.net>
References: <20250717220912.376503-1-thomas@monjalon.net>
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

From: Maayan Kashani <mkashani@nvidia.com>

Adding testpmd command examples to mlx5 guide,
either inline if short enough
or using external links to a GitHub repository hosting tests.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 138 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 63c2770018..f29408eace 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1344,6 +1344,13 @@ is not supported on HW root table.
 In :ref:`HW steering <mlx5_hws>`, the action ``RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL``
 is not supported on guest port.
 
+Example
+^^^^^^^
+
+Usage of ``RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL`` in testpmd::
+
+   testpmd> flow create 0 ingress priority 0 group 1 pattern eth type spec 0x0800 type mask 0xffff / end actions send_to_kernel / end
+
 
 Multiport E-Switch
 ~~~~~~~~~~~~~~~~~~
@@ -1657,6 +1664,11 @@ Limitations
 
 #. Matching on aggregated affinity is supported only in group 0.
 
+Example
+^^^^^^^
+
+See `affinity matching with testpmd`_.
+
 
 .. _mlx5_shared_rx:
 
@@ -2196,6 +2208,15 @@ Limitations
    but only on template tables
    with ``RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG`` specialization.
 
+Examples
+^^^^^^^^
+
+- `RSS`_
+- `RSS IPv6`_
+- `RSS IPv6 in indirect action`_
+- `RSS in flow template`_
+- `RSS with custom hash`_
+
 
 .. _mlx5_flow_queue:
 
@@ -2279,6 +2300,18 @@ Limitations
    to the representor of the source virtual port (SF/VF), while if it is disabled,
    the traffic will be routed based on the steering rules in the ingress domain.
 
+Examples
+^^^^^^^^
+
+- When testpmd starts with a PF, a VF-rep0 and a VF-rep1,
+  the below example will redirect packets from VF0 and VF1 to the wire::
+
+     testpmd> flow create 0 ingress transfer pattern eth / port_representor / end actions represented_port ethdev_port_id 0 / end
+
+- To match on traffic from port representor 1 and redirect to port 2::
+
+     testpmd> flow create 0 transfer pattern eth / port_representor port_id is 1 / end actions represented_port ethdev_port_id 2 / end
+
 
 .. _mlx5_flow_drop:
 
@@ -2339,6 +2372,11 @@ Limitations
    from a template table with a different specialization
    is supported since firmware version xx.43.1014.
 
+Example
+^^^^^^^
+
+See `jump to table index with testpmd`_.
+
 
 .. _mlx5_indirect:
 
@@ -2363,6 +2401,11 @@ Limitations
 #. If an indirect actions list handle is masked,
    the mask will be used in template creation and flow rule.
 
+Example
+^^^^^^^
+
+- `indirect list of encap/decap`_
+
 
 .. _mlx5_meta:
 
@@ -2672,6 +2715,11 @@ Limitations
 #. ``RTE_FLOW_ACTION_TYPE_QUOTA`` cannot be used in the same rule
    with a meter action or ``RTE_FLOW_ACTION_TYPE_CONNTRACK``.
 
+Example
+^^^^^^^
+
+See `quota usage with testpmd`_.
+
 
 .. _mlx5_meter:
 
@@ -2762,6 +2810,12 @@ Limitations
 
 #. The maximal number of HW quota and HW meter objects is ``16e6``.
 
+Examples
+^^^^^^^^
+
+- `meter mark with sync API`_
+- `meter mark with template API`_
+
 
 .. _mlx5_sample:
 
@@ -2815,6 +2869,21 @@ Limitations
 #. For ConnectX-5 trusted device, the application metadata with SET_TAG index 0
    is not supported before ``RTE_FLOW_ACTION_TYPE_SAMPLE`` action.
 
+Examples
+^^^^^^^^
+
+Create an indirect action list with sample and jump::
+
+   testpmd> set sample_actions 1 port_representor port_id 0xffff / end
+   testpmd> flow indirect_action 0 create transfer list actions sample ratio 1 index 1 / jump group 2 / end
+
+E-Switch mirroring: the matched ingress packets are sent to port 2,
+mirror the packets with NVGRE encapsulation and send to port 0::
+
+   testpmd> set nvgre ip-version ipv4 tni 4 ip-src 127.0.0.1 ip-dst 128.0.0.1 eth-src 11:11:11:11:11:11 eth-dst 22:22:22:22:22:22
+   testpmd> set sample_actions 0 nvgre_encap / port_id id 0 / end
+   testpmd> flow create 0 transfer pattern eth / end actions sample ratio 1 index 0 / port_id id 2 / end
+
 
 .. _mlx5_random:
 
@@ -2837,6 +2906,11 @@ Limitations
 
 #. Supported only in template table with ``nb_flows=1``.
 
+Example
+^^^^^^^
+
+See `random matching with testpmd`_.
+
 
 .. _mlx5_flex_item:
 
@@ -3018,6 +3092,12 @@ Limitations
 
 #. Encapsulation levels greater than ``2`` are not supported.
 
+Examples
+^^^^^^^^
+
+- `set value`_
+- `copy field`_
+
 
 .. _mlx5_compare:
 
@@ -3057,6 +3137,15 @@ Limitations
 #. The field type ``RTE_FLOW_FIELD_RANDOM`` can only be compared with
    ``RTE_FLOW_FIELD_VALUE``.
 
+Examples
+^^^^^^^^
+
+- `compare ESP to value`_
+- `compare ESP to meta`_
+- `compare meta to value`_
+- `compare tag to value`_
+- `compare random to value`_
+
 
 .. _mlx5_ptype:
 
@@ -3096,6 +3185,11 @@ Limitations
    and ``RTE_PTYPE_L4_FRAG`` during flow rule creation
    will cause unexpected behavior.
 
+Example
+^^^^^^^
+
+See `packet type matching with testpmd`_.
+
 
 .. _mlx5_eth:
 
@@ -3508,6 +3602,18 @@ Limitations
 
 #. L3 VXLAN and VXLAN-GPE tunnels cannot be supported together with MPLSoGRE and MPLSoUDP.
 
+Examples
+^^^^^^^^
+
+- match VXLAN-GPE flags, next protocol, VNI, rsvd0 and rsvd1::
+
+     testpmd> flow create 0 transfer group 0 pattern eth / end actions count / jump group 1 / end
+     testpmd> flow create 0 transfer group 1 pattern eth / ipv4 / udp / vxlan-gpe flags is 12 protocol is 6 rsvd1 is 8 vni is 100 rsvd0 is 5 / end actions count / jump group 2 / end
+
+- `match VXLAN-GBP`_
+
+- `modify VXLAN header`_
+
 
 .. _mlx5_gre:
 
@@ -3770,6 +3876,11 @@ Limitations
 
 #. The maximum supported MPLS headers is 5.
 
+Example
+^^^^^^^
+
+See `matching MPLSoGRE with testpmd`_.
+
 
 .. _mlx5_nsh:
 
@@ -4414,3 +4525,30 @@ Destroy GENEVE TLV parser for specific port::
 
 This command doesn't destroy the global list,
 For releasing options, ``flush`` command should be used.
+
+
+.. links to examples on GitHub:
+
+.. _affinity matching with testpmd: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/items/classification_and_integrity/port_affinity_match.yaml
+.. _RSS IPv6 in indirect action: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/fate/rss_ip6_indirect.yaml
+.. _RSS IPv6: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/fate/rss_ip6.yaml
+.. _RSS: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/fate/rss_simple.yaml
+.. _RSS in flow template: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/actions/fate/rss_basic.yaml
+.. _RSS with custom hash: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/actions/fate/customized_rss_hash.yaml
+.. _jump to table index with testpmd: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/actions/fate/jump_table_index_action.yaml
+.. _indirect list of encap/decap: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/packet_reformat/indirect_raw_encap_decap.yaml
+.. _quota usage with testpmd: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/actions/monitor_diagnostic/quota/quota.yaml
+.. _meter mark with template API: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/actions/monitor_diagnostic/meter/meter_mark.yaml
+.. _meter mark with sync API: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/monitor_diagnostic/meter/meter_mark_no_cfg.yaml
+.. _random matching with testpmd: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/random/random.yaml
+.. _set value: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/packet_reformat/modify_header_src_value.yaml
+.. _copy field: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/actions/packet_reformat/modify_header_src_field.yaml
+.. _compare ESP to value: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/compare/esp_seq_to_value.yaml
+.. _compare ESP to meta: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/compare/esp_seq_to_meta.yaml
+.. _compare meta to value: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/compare/meta_to_value.yaml
+.. _compare tag to value: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/compare/tag_to_value.yaml
+.. _compare random to value: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/compare/random_to_value.yaml
+.. _packet type matching with testpmd: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/classification_and_integrity/ptype_l4_tcp.yaml
+.. _match VXLAN-GBP: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/items/UDP_tunnels/vxlan/vxlan_gbp.yaml
+.. _modify VXLAN header: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_template_async/actions/packet_reformat/vxlan_modify_last_rsvd.yaml
+.. _matching MPLSoGRE with testpmd: https://github.com/Mellanox/dpdk-utest/blob/main/tests/flow_sync/items/MPLS/mpls_o_gre.yaml
-- 
2.47.1

