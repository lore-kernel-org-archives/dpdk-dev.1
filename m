Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7FCD6E7E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:36:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C95A40695;
	Sat,  6 Jun 2026 01:35:33 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id A60B940671
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:31 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 52523EC01A5;
 Fri,  5 Jun 2026 19:35:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Fri, 05 Jun 2026 19:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702531; x=
 1780788931; bh=kTPm3AqiLw27SmDYWwaVxbiK+rzsnajsq2ki3z1HN2s=; b=p
 vSZQkGCz2oJrX/spscnmCxVHlcGEiNg11GQ5wu9GpTjQqjaK3vjtXXK9rqj8YIte
 PC5p+moKk20lNyxpOQHbYb5R6ReDsQDFEHJ2ZRAmOHkeQHp5f98vq0hHffB61D19
 u7d6mlHXqacRXyNmkqxWrqpBYVxqTen9RPQ0ylMWqeAOyz3uVyutkW6x/iOmRWxH
 UueFumY8c7ZwTa3b2T89MP5SQ/HzbdfO5iLyZTPDyCO4rnK2tc7hfe/gIrTZSuvv
 VdFlXGy9UlFnW8fJhsDbux6MhXi8UbgQAXb9tyb6iUzKvYOEe+h5qfJAnr98DuG4
 7BB501nZmqGUadBP2CmPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702531; x=1780788931; bh=k
 TPm3AqiLw27SmDYWwaVxbiK+rzsnajsq2ki3z1HN2s=; b=LLY3YlNp9ck6P6ovK
 fIdW1FLDBDSh1298XOyIVOZEa+2psDCmkO0HmwRKjcFq2XEXKUer7UkbMI6ifqTe
 Ghuki1yX+cAsT9dYU6gp+qh6jWZZmEGL9nP15LsDL2gNWgLZDzsUsVxLYPpIv8ml
 Mlf531Y9PTLXzMQ4JUvbfzqKpLjldO41Y8BGcNK5bnvd/+WiBszyr4DXcNRmIecc
 Ve2Koz6wRXbGz3IqNYeEPUtEv2F2pgfBYwVldYLtlSOy2QxMv+uWnjon+/SW7bA6
 2w9zTvJ+3UXQIrXBQbCMhss28TvX7XSUgXmgK9cKx0SS1tP23b6jbEemTERucAZo
 lpocQ==
X-ME-Sender: <xms:Q10jalwehiNlH6rIqpJnrt9oFYysAXY8TGyeDbgBxSveFWBIymeYvg>
 <xme:Q10jalYWw24mJRubBIBEJagTD8VN_uNUrtGGlYF4Dm5XXeQP7q-VP6GahxY_rrGr3
 2B2wVfnf2FDQn9L8O-5v58E4hBEaalQEq4obeyc_k_jYBp9dysjRg>
X-ME-Received: <xmr:Q10janTQPAhJf4718L5vAj9ARe1YAvGAc6AS5jvkKahNARGFr-e_luuUfsq0KrrsVJZ1sD45mWTc4pENryL5Ljb8WeXWvHI>
X-ME-Proxy-Cause: dmFkZTF8TioU96Tq8QejfEYWkQIUsOFAOK0FW7DC0LiMj/WHoJBthbNIYQLZhbAbsRQFO2
 lhUgktCKGre+6Hnm7PQXDfi1me7GJ21rd3W+s+oTHe2orhprMWu2vu6WchUqxiyReLNIP/
 h3ejxiJXKpjK7apdIpmRIiSOfY1fUBhqsQ0e82bQFHzyD22eDCAo38hZuDD/ypb4Oztk6q
 OeXfKEwFSxXbs9e3Sev8qr5ihJ1wJqhq/BCqlbt+MotFGfBijxQCyHb3Pfm3eEogn9mTf7
 rZwf/OFQ2wp3HTDchj9Os4Lo4khXvPNfnxTbVv7CQBS9l+7W8MnadGcXfmGvlq8RLz+3hA
 wkP70XmtnYFW4nPKVdp42e1RozJW4o1DTpxDKO/iIqYU0NRAfKa8WWM2Pe9FdQRKHpA1gR
 gnyzQhpF1R+bS4MgXDAq7fWDzfSf4Eg7VYFDkJp0KJh/tnTnZ+do2Z+QPdQ3TFIz5+mNtj
 Uf8WzqDPj+xINahGcpZhXTclJspvHErsstDP4UjmEiu+1BHRryfvPPRsiigC4reawWpgoe
 8ghVHGYi193whNAlg4mwDqn8QyBqaesz+fLsl7Jmd8TbVy2gTguxdXyuSe4XrZpI238qKx
 P9bbem1h7rFxbh0J0QtTksgtqhmOnwedOanZmo8H5Zl30LpaHsarSsdjx+SA
X-ME-Proxy: <xmx:Q10javy5S0tWyITvUjDyn34Z5tN40KBFs8vTO4oEkCRJKb-e9W1avg>
 <xmx:Q10jah2mkIJTJPTAEeR4r0FzjObuxJyy2-YxRhgjcOlAsPpBfg6Uew>
 <xmx:Q10jal7WsK5lcc1PLZ-QVM-ymn3amewpIBgQ5-1RfgZFgUuuPnVqiQ>
 <xmx:Q10jasXvzBE6r3UCYKSCb4dt_qm9WDu0eXWA83xu636NKC4Wp-y3SA>
 <xmx:Q10jatdOUuYC37CPynoJ3xMPfETVIOlBHpv1KQNyo_OJXgIRa4E1ipBJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:30 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v9 09/10] dts: use specific types for Rx/Tx offloads
Date: Sat,  6 Jun 2026 01:33:49 +0200
Message-ID: <20260605233456.3017423-10-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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

Testpmd Rx and Tx offload parameters only accepted integer masks.
This forced tests to pass enum values through .value
when using RxOffloadCapability or TxOffloadCapability.

Allow these parameters to take either typed offload flags
or raw integer masks,
and convert both forms to the hexadecimal mask
expected by the testpmd command line.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/api/testpmd/config.py        | 11 +++++++++--
 dts/framework/params/__init__.py | 14 ++++++++++++++
 dts/framework/params/types.py    |  5 +++--
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
index 1e59bccd08..f0581843ca 100644
--- a/dts/api/testpmd/config.py
+++ b/dts/api/testpmd/config.py
@@ -19,6 +19,7 @@
     YesNoSwitch,
     bracketed,
     comma_separated,
+    hex_from_flag_or_int,
     hex_from_flag_value,
     modify_str,
     str_from_flag_value,
@@ -26,6 +27,8 @@
 from framework.params.eal import EalParams
 from framework.utils import StrEnum
 
+from .types import RxOffloadCapability, TxOffloadCapability
+
 
 class PortTopology(StrEnum):
     """Enum representing the port topology."""
@@ -577,12 +580,16 @@ class TestPmdParams(EalParams):
     )
     multi_rx_mempool: Switch = None
     rx_shared_queue: Switch | int = field(default=None, metadata=Params.long("rxq-share"))
-    rx_offloads: int | None = field(default=None, metadata=Params.convert_value(hex))
+    rx_offloads: RxOffloadCapability | int | None = field(
+        default=None, metadata=Params.convert_value(hex_from_flag_or_int)
+    )
     rx_mq_mode: RXMultiQueueMode | None = None
 
     tx_queues: int | None = field(default=None, metadata=Params.long("txq"))
     tx_ring: TXRingParams | None = None
-    tx_offloads: int | None = field(default=None, metadata=Params.convert_value(hex))
+    tx_offloads: TxOffloadCapability | int | None = field(
+        default=None, metadata=Params.convert_value(hex_from_flag_or_int)
+    )
 
     eth_link_speed: int | None = None
     disable_link_check: Switch = None
diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
index e6a2d3c903..b5bae9dad9 100644
--- a/dts/framework/params/__init__.py
+++ b/dts/framework/params/__init__.py
@@ -130,6 +130,20 @@ def hex_from_flag_value(flag: Flag) -> str:
     return hex(flag.value)
 
 
+def hex_from_flag_or_int(value: Flag | int) -> str:
+    """Returns a :class:`enum.Flag` or integer value converted to hexadecimal.
+
+    Args:
+        value: An instance of :class:`Flag` or an integer.
+
+    Returns:
+        The value in hexadecimal representation.
+    """
+    if isinstance(value, Flag):
+        return hex_from_flag_value(value)
+    return hex(value)
+
+
 class ParamsModifier(TypedDict, total=False):
     """Params modifiers dict compatible with the :func:`dataclasses.field` metadata parameter."""
 
diff --git a/dts/framework/params/types.py b/dts/framework/params/types.py
index 3c7650474c..a9f3749083 100644
--- a/dts/framework/params/types.py
+++ b/dts/framework/params/types.py
@@ -53,6 +53,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TXRingParams,
     TxUDPPortPair,
 )
+from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
 from framework.params import Switch, YesNoSwitch
 from framework.testbed_model.cpu import LogicalCoreList
 from framework.testbed_model.port import Port
@@ -175,11 +176,11 @@ class TestPmdParamsDict(EalParamsDict, total=False):
     rx_segments_length: list[int] | None
     multi_rx_mempool: Switch
     rx_shared_queue: Switch | int
-    rx_offloads: int | None
+    rx_offloads: RxOffloadCapability | int | None
     rx_mq_mode: RXMultiQueueMode | None
     tx_queues: int | None
     tx_ring: TXRingParams | None
-    tx_offloads: int | None
+    tx_offloads: TxOffloadCapability | int | None
     eth_link_speed: int | None
     disable_link_check: Switch
     disable_device_start: Switch
-- 
2.54.0

