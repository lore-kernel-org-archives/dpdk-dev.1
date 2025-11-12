Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37511CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 11:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DF9A402A7;
	Wed, 12 Nov 2025 12:34:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 6DB3140281
 for <dev@dpdk.org>; Wed, 12 Nov 2025 12:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762947256; x=1794483256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6HcGEa5DUjiy57VzgqQfW4xbIEwvVM5/EzWXuUBta/I=;
 b=bBS0646QYkwfw9kkh7u+PXUBPOUhqfoEQKSrqm5UrncaYaHfQwnMULJW
 TZgSyFWE+odD2wVvm5XediIiOlgyqnJnc9P8L37ab9jbfzJfsdu9o9ncs
 iGCGouTbpGdIMzMg4o1k3zYnqn6spT0ZFjLaNcpIte2D4d20iZ4DnTL8s
 uZijadSSsKnN9O3KezzLXKvTXrws121Q8TLnFQgj9GkcmuqMmK2i/JZuX
 2Gy5H6Gc6sVISSS9yhm+2ugiqKKGoKhgDFm2VQ6IZpq+T4e+q+zXaY8bj
 NtufW74jFTDMlv4Rprj7FMWvAJbYuAki3MIT3NQuhDhXd4p4e4FH5xWaE A==;
X-CSE-ConnectionGUID: JYpCDLd1SoWnOIX985h/QQ==
X-CSE-MsgGUID: NFXwRR3KROa8Eir7KFtpPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64211236"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64211236"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 03:34:14 -0800
X-CSE-ConnectionGUID: 8fruEDJGQ0OFNVhyoBDNuQ==
X-CSE-MsgGUID: 63z+QkP6TlK7HsUTRh/dLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="193444087"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 03:34:12 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: vladimir.medvedkin@intel.com
Subject: [PATCH v2 1/1] doc/ice: document protocol agnostic filtering
Date: Wed, 12 Nov 2025 11:34:12 +0000
Message-ID: <5d6aa3eed2827e1f7c8e07c1e344e232f010f0e4.1762947241.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
References: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
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

Current documentation for protocol agnostic filtering for ICE driver is a
bit terse and relies on a lot of assumed knowledge. Document the feature
better and make all of the assumptions explicit.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---

Notes:
    v2:
    - Reformat lines to have complete sentences per line
    - Added C implementation for testpmd examples
    - Added link to packetforge script

 doc/guides/nics/ice.rst | 222 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 211 insertions(+), 11 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 6cc27cefa7..ffa11cf066 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -624,20 +624,220 @@ For each engine, a list of supported patterns is maintained in a global array
 named ``ice_<engine>_supported_pattern``. The Ice PMD will reject any rule with
 a pattern that is not included in the supported list.
 
-One notable feature is the ice PMD's ability to leverage the Raw pattern,
-enabling protocol-agnostic flow offloading. Here is an example of creating
-a rule that matches an IPv4 destination address of 1.2.3.4 and redirects it to
-queue 3 using a raw pattern::
-
-  flow create 0 ingress group 2 pattern raw \
-  pattern spec \
-  00000000000000000000000008004500001400004000401000000000000001020304 \
-  pattern mask \
-  000000000000000000000000000000000000000000000000000000000000ffffffff \
-  end actions queue index 3 / mark id 3 / end
+Protocol Agnostic Filtering
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+One notable feature is the ice PMD's ability to leverage the Raw pattern, enabling protocol-agnostic flow offloading.
+This feature allows users to create flow rules for any protocol recognized by the hardware parser, by manually specifying the raw packet structure.
+Therefore, flow offloading can be used even in cases where desired protocol isn't explicitly supported by RTE_FLOW interface.
+
+Raw Pattern Components
+++++++++++++++++++++++
+
+Raw patterns consist of two key components:
+
+**Pattern Spec**
+  An ASCII hexadecimal string representing the complete packet structure that defines the packet type and protocol layout.
+  The hardware parser analyzes this structure to determine the packet type (PTYPE) and identify protocol headers and their offsets.
+  This specification must represent a valid packet structure that the hardware can parse and classify.
+  If the hardware parser does not support a particular protocol stack, it may not correctly identify the packet type.
+
+**Pattern Mask**
+  An ASCII hexadecimal string of the same length as the spec that determines which specific fields within the packet will be extracted and used for matching.
+  The mask control field extraction without affecting the packet type identification.
+
+.. note::
+   Raw pattern must be the only flow item in the flow item list.
+
+Generating Raw Pattern Values
++++++++++++++++++++++++++++++
+
+To create raw patterns, follow these steps:
+
+1. **Verify parser support**: Confirm that the hardware parser supports the protocol combination needed for the intended flow rule.
+   This can be checked against the documentation for the DDP package currently in use.
+
+2. **Build the packet template**: Create a complete, valid packet header with all necessary sections (Ethernet, IP, UDP/TCP, etc.) using the exact field values that need to be matched.
+
+3. **Convert to hexadecimal**: Transform the entire header into a continuous ASCII hexadecimal string, with each byte represented as two hex characters.
+
+4. **Create the extraction mask**: Generate a mask of the same length as the spec, where set bits would indicate the fields used for extraction/matching.
+
+VPP project's `flow_parse.py` script can be used to generate packet templates and masks for raw patterns.
+This tool takes a human-readable flow description and outputs the corresponding ASCII hexadecimal spec and mask.
+This script can be found under ``extras/packetforge`` in `VPP project <https://github.com/FDio/vpp/blob/master/extras/packetforge/flow_parse.py>`_.
+
+Example usage:
+
+.. code-block:: console
+
+   python3 flow_parse.py --show -p "mac()/ipv4(src=1.1.1.1,dst=2.2.2.2)/udp()"
+
+Output:
+
+   {'flow': {'generic': {'pattern': {'spec': b'00000000000100000000000208004500001c000000000011000001010101020202020000000000080000',
+   'mask': b'0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000'}}}}
+
+.. note::
+   Ensure the spec represents complete protocol headers, as the hardware parser processes fields at 16-bit boundaries.
+   Incomplete or truncated headers may result in unpredictable field extraction behavior.
+
+Action Support and Usage
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+After constructing the raw pattern spec and mask, they can be used in the flow API with pattern type "raw".
+
+The following is an example of a minimal Ethernet + IPv4 header template.
+Source and destination IPv4 addresses are part of the match key; all other fields are ignored.
+
+Spec (packet template):
+  000000000001              Destination MAC (6 bytes)
+  000000000002              Source MAC (6 bytes)
+  0800                      EtherType = IPv4
+  4500001c0000000000110000  IPv4 header, protocol = UDP
+  01010101                  Source IP = 1.1.1.1
+  02020202                  Destination IP = 2.2.2.2
+  0000000000080000          UDP header
+
+Mask:
+  000000000000              Destination MAC (ignored)
+  000000000000              Source MAC (ignored)
+  0000                      EtherType (ignored)
+  000000000000000000000000  IPv4/UDP header (ignored)
+  ffffffff                  Source IP (match all 32 bits)
+  ffffffff                  Destination IP (match all 32 bits)
+  0000000000000000          UDP header (ignored)
+
+This spec will match any non-fragmented IPv4/UDP packet whose source IP is 1.1.1.1 and destination IP is 2.2.2.2.
+
+Currently, the following actions are supported:
+
+- **mark**: Attaches a user-defined integer value to matching packets. Can be specified together with another action.
+
+- **queue**: Directs matching packets to a specific receive queue.
+
+- **drop**: Discards matching packets at the hardware level.
+
+- **rss**: Enables Receive Side Scaling (RSS) for matching packets.
+
+Constraints:
+  * For RSS, only the global configuration is used; per-rule queue lists or RSS keys are not supported.
+
+To direct matching packets to a specific queue, and set mbuf FDIR metadata in:
+
+.. code-block:: console
+
+   flow create 0 ingress pattern raw \
+     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
+     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
+     actions queue index 3 mark id 3 / end
+
+Equivalent C code using the ``rte_flow`` API:
+
+.. code-block:: c
+
+   /* Hex string for the packet spec (Ethernet + IPv4 + UDP header) */
+   static const uint8_t raw_pattern_spec[] = {
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x01,  /* Destination MAC */
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x02,  /* Source MAC */
+       0x08, 0x00,                          /* EtherType: IPv4 */
+       0x45, 0x00, 0x00, 0x1c, 0x00, 0x00, 0x00, 0x00,
+       0x00, 0x11, 0x00, 0x00,              /* IPv4 header, protocol UDP */
+       0x01, 0x01, 0x01, 0x01,              /* Source IP: 1.1.1.1 */
+       0x02, 0x02, 0x02, 0x02,              /* Destination IP: 2.2.2.2 */
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00  /* UDP header */
+   };
+
+   /* Mask indicating which fields to match (source and destination IPs) */
+   static const uint8_t raw_pattern_mask[] = {
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x00,  /* MAC addresses - ignored */
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+       0x00, 0x00,                          /* EtherType - ignored */
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+       0x00, 0x00, 0x00, 0x00,              /* IPv4/UDP headers - ignored */
+       0xff, 0xff, 0xff, 0xff,              /* Source IP - match all bits */
+       0xff, 0xff, 0xff, 0xff,              /* Destination IP - match all bits */
+       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  /* UDP - ignored */
+   };
+
+   struct rte_flow_item_raw raw_spec = {
+       .length = sizeof(raw_pattern_spec),
+       .pattern = raw_pattern_spec,
+   };
+
+   struct rte_flow_item_raw raw_mask = {
+       .length = sizeof(raw_pattern_mask),
+       .pattern = raw_pattern_mask,
+   };
+
+   struct rte_flow_attr attr = {
+       .ingress = 1,
+   };
+
+   struct rte_flow_item pattern[] = {
+       {
+           .type = RTE_FLOW_ITEM_TYPE_RAW,
+           .spec = &raw_spec,
+           .mask = &raw_mask,
+       },
+       {
+           .type = RTE_FLOW_ITEM_TYPE_END,
+       },
+   };
+
+   struct rte_flow_action actions[] = {
+       /* direct flow to queue index 3 */
+       {
+           .type = RTE_FLOW_ACTION_TYPE_QUEUE,
+           .conf = &(struct rte_flow_action_queue){ .index = 3 },
+       },
+       /* write id into mbuf FDIR metadata */
+       {
+           .type = RTE_FLOW_ACTION_TYPE_MARK,
+           .conf = &(struct rte_flow_action_mark){ .id = 3 },
+       },
+       {
+           .type = RTE_FLOW_ACTION_TYPE_END,
+       },
+   };
+
+   struct rte_flow_error error;
+   struct rte_flow *flow = flow = rte_flow_create(port_id, &attr, pattern, actions, &error);
+
+To use masked bits (IPv4 source/destination addresses) to distribute such packets via RSS:
+
+.. code-block:: console
+
+   flow create 0 ingress pattern raw \
+     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
+     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
+     actions rss / end
+
+Equivalent C code using the rte_flow API:
+
+.. code-block:: c
+
+   /* Use the same structures and code as above, only actions change */
+
+   struct rte_flow_action actions[] = {
+       {
+           .type = RTE_FLOW_ACTION_TYPE_RSS,
+           /* Use NULL conf for default RSS configuration */
+       },
+       {
+           .type = RTE_FLOW_ACTION_TYPE_END,
+       },
+   };
+
+**Limitations**
 
 Currently, raw pattern support is limited to the FDIR and Hash engines.
 
+.. note::
+
+   **DDP Package Dependency**: Raw pattern functionality relies on the loaded DDP package to define available packet types and protocol parsing rules.
+   Different DDP packages (OS Default, COMMS, Wireless) may support different protocol combinations and PTYPE mappings.
+
 Traffic Management Support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3

