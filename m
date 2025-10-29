Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC8CCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BD264042F;
	Wed, 29 Oct 2025 16:17:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9E19A402D2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 16:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761751037; x=1793287037;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ud5GvwLEd1KUZSRsW/a1kDBKOiDJ1oEbheLP9zeshnU=;
 b=B8OT31At/D++R7wzpqHm+Fh+190oQ6JGnqR4fwKTiK+chs9OfVxnHvsm
 gftBboRlLDqKEDsghz5uXQhesJxnX3gabxFxdKQ5yscJg9bBrxoqsZICM
 Kfl32/rUDYW3ONQpq69UZ1IKtye5FUqSjfFu6HQx4urCzK/v0S8XJSp6Z
 EfirXMEnfnzgPdYdFGx5dRTF5SkkR5emem1EAwDyqT3BVzy2mC6Pzr9wm
 MXYjUKp3yUEQ6udiy9i/X02xiqtTe4qfC6HSTcfURZ/AfIn+nGVoXoHf5
 5H7BdBhn/oDA+GUTaMvGzbzOclQ9lLiSwkx7R+XmfiGbuQijdElLuQEgN w==;
X-CSE-ConnectionGUID: o8O62ZioT6+SRJDfb8t06g==
X-CSE-MsgGUID: k3naYQlKQBKZjH7z1GZMjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63970897"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="63970897"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:17:16 -0700
X-CSE-ConnectionGUID: BdCEK031QfyEEadey8cnpA==
X-CSE-MsgGUID: zUyf/K/gTzaIFUE8wHaYFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="185617098"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 08:17:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: vladimir.medvedkin@intel.com
Subject: [PATCH v1 1/1] doc/ice: document protocol agnostic filtering
Date: Wed, 29 Oct 2025 15:17:14 +0000
Message-ID: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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
---
 doc/guides/nics/ice.rst | 143 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 10 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..cb06abcdbc 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -506,20 +506,143 @@ For each engine, a list of supported patterns is maintained in a global array
 named ``ice_<engine>_supported_pattern``. The Ice PMD will reject any rule with
 a pattern that is not included in the supported list.
 
+Protocol Agnostic Filtering
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 One notable feature is the ice PMD's ability to leverage the Raw pattern,
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
+enabling protocol-agnostic flow offloading. This feature allows users to create
+flow rules for any protocol recognized by the hardware parser, by manually
+specifying the raw packet structure. Therefore, flow offloading can be used even
+in cases where desired protocol isn't explicitly supported by RTE_FLOW interface.
+
+Raw Pattern Components
+++++++++++++++++++++++
+
+Raw patterns consist of two key components:
+
+**Pattern Spec**
+  An ASCII hexadecimal string representing the complete packet structure that defines
+  the packet type and protocol layout. The hardware parser analyzes this structure
+  to determine the packet type (PTYPE) and identify protocol headers and their offsets.
+  This specification must represent a valid packet structure that the hardware
+  can parse and classify. If the hardware parser does not support a particular protocol
+  stack, it may not correctly identify the packet type.
+
+**Pattern Mask**
+  An ASCII hexadecimal string of the same length as the spec that determines which specific
+  fields within the packet will be extracted and used for matching. The mask controls
+  field extraction without affecting the packet type identification.
+
+It is important to note that raw pattern must be the only flow item in the flow item list.
+
+Generating Raw Pattern Values
++++++++++++++++++++++++++++++
+
+To create raw patterns, follow these steps:
+
+1. **Verify parser support**: Confirm that the hardware parser supports the protocol
+   combination needed for the intended flow rule. This can be checked against
+   the documentation for the DDP package currently in use.
+
+2. **Build the packet template**: Create a complete, valid packet header with all
+   necessary sections (Ethernet, IP, UDP/TCP, etc.) using the exact field values
+   that need to be matched.
+
+3. **Convert to hexadecimal**: Transform the entire header into a continuous
+   ASCII hexadecimal string, with each byte represented as two hex characters.
+
+4. **Create the extraction mask**: Generate a mask of the same length as the spec, where set bits
+   would indicate the fields used for extraction/matching.
+
+VPP project's `flow_parse.py` script can be used to generate packet templates and masks for raw patterns.
+This tool takes a human-readable flow description and outputs the corresponding ASCII hexadecimal spec and mask.
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
+   Ensure the spec represents complete protocol headers, as the hardware parser processes
+   fields at 16-bit boundaries. Incomplete or truncated headers may result in unpredictable
+   field extraction behavior.
+
+Action Support and Usage
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+After constructing the raw pattern spec and mask, they can be used in the flow API with pattern type "raw".
+
+The following is an example of a minimal Ethernet + IPv4 header template. Source and destination IPv4 addresses are
+part of the match key; all other fields are ignored.
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
+To direct matching packets to a specific queue, and set mbuf FDIR metadata:
+
+.. code-block:: console
+
+   flow create 0 ingress pattern raw \
+     pattern spec 00000000000100000000000208004500001c000000000011000001010101020202020000000000080000 \
+     pattern mask 0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000 / end \
+     actions queue index 3 mark id 3 / end
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
+**Limitations**
 
 Currently, raw pattern support is limited to the FDIR and Hash engines.
 
+.. note::
+
+   **DDP Package Dependency**: Raw pattern functionality relies on the loaded
+   DDP package to define available packet types and protocol parsing rules.
+   Different DDP packages (OS Default, COMMS, Wireless) may support different
+   protocol combinations and PTYPE mappings.
+
 Traffic Management Support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3

