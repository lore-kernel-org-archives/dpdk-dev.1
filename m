Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F7CD46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:47:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32E86409FA;
	Wed, 28 Jan 2026 20:47:34 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id F41D240693
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:30 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so192444f8f.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629650;
 x=1770234450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/3Btw9KcZGUfi1eOgAwgjuczhHgnDlvzG5ZyIqRMAI=;
 b=dGKTGMV80ayIZ2djIpYw/euq/RVtDpXT7vFAsIWi3BkhUkruhJimE/epDhqeDMb72j
 4qz/sEOKEvFE7Le///khu92xEpWp9c9uZuTn3xY/jXoX7qm56BknMyio0eOVouAMkQUL
 TWPykKb15iaBMK/SYfmh3liysACxSIGXZTobpVvJpMI4wt/+XbwIwOc0syMnMVL2UjaF
 892MDdWlMkDalVEK7bumaG36NPCqJs88NHf56ZrjF0ttMMKIeyQcsEKgeHc/DFqUWquQ
 udHJQ6jWr9l3cYZxclSXIS2VCOwtIlLLGhXCbkJwip5imxoV0qH4ZKvbv1sV4Z6wXicp
 l2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629650; x=1770234450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/3Btw9KcZGUfi1eOgAwgjuczhHgnDlvzG5ZyIqRMAI=;
 b=cqIxYWEFhaKxdVJOyEgBBf7ax6j41K0jHlW7NCbxWf141GhcAu1FZZoJaM4M8Icv8c
 +ymQmpTZ9Zcy9iATE2lJcc7SkvcB1s3/eNKMR4hIOsCogVenkWw9fTgFUQehLLg/XljS
 JxDkRBtTZAREBkutdxW4d70utNIbL24ZO5DT8OgrR8wmIS/JIIjj+i5iX4r8ns3schcJ
 13P2/757IVC9f3hWu3eMrPYPIRVCLMKJmpOYcKHqejQ1jgz58Ofq4jUafvmsObXwMsbm
 xLFIbtYfsnTbK7YDPImAyNVzByw3mcJ60hZty0uSBDJ4PwBT4oipXVPIgZopIu3rcYiU
 rPyg==
X-Gm-Message-State: AOJu0YznyNB4eGmeyo+MeiiQZzmVs6cqOXhOE8/q30CWIgccXZadFN7y
 eP0qxDCB+RBAKNmAsD7UwusCSu8WOpS0gpSwjUXJrAEL0WpdrxMhNZSWOj7VCO9IO2PLTXqQQ3A
 Pqx/h
X-Gm-Gg: AZuq6aI0BIi8fbeIT/KfvvmOqNw/9Kihf/X09ZVX6POczGQtbO5UaWsW522xN4KegwA
 WITrhlBjkzn9LjIyt4RFchVHQw0nY5CZJcDy+/CmPpkCr2hD/ROENrknqFm8Z0XHa2l4KcTZOWb
 Lc9CVHRKDdjcSPJseY0/B2csDWrE32ckIUFbkdCbaptCg3z88/89pdLMvJuueh50ngPJR3Mp/yk
 +a55hbaLnMXTnidMvNd2UME3Usygq2fekmvNw70agajUkfod387uCl3PBy7YglQ00PzCoESX5LJ
 qJe5A9kdE2JoLxx5gfoS3oLgcR6DJmkukYQZNyKIKYDzXpu9WAXMIETh2sxE+F8cs8gPaHur6Cp
 TmPhBAS/nVRdi9WoGrYqh/fkj4V0WCqUhtm8HP1ptkDUISMzl88pTkGHjwxFUwb3SVrj1uhpyGX
 ZBX1D8h+bi7FeCebseqBXZddT1CUAv7pCAe4enNj6RqlsPdjT5HQ==
X-Received: by 2002:a05:6000:2084:b0:429:c851:69ab with SMTP id
 ffacd0b85a97d-435dd1d928amr8739573f8f.55.1769629650420; 
 Wed, 28 Jan 2026 11:47:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>
Subject: [PATCH v2 2/8] doc: correct grammar in flow guide
Date: Wed, 28 Jan 2026 11:46:01 -0800
Message-ID: <20260128194722.480862-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128194722.480862-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
 <20260128194722.480862-1-stephen@networkplumber.org>
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

Clarify several sections of the generic flow API documentation
for better readability and technical accuracy. Fix terminology
to use consistent DPDK conventions and improve explanations
of complex concepts like transfer flows, indirect actions,
and template tables.

Changes:
- Remove duplicate article "an" in phrase "a single an item".
- Replace "can not" with "cannot" throughout document
- Clarify that transfer flows use PORT_REPRESENTOR and
  REPRESENTED_PORT items instead of direction attributes
- Improve explanation of indirect action persistence behavior
- Fix grammar in flow isolated mode section
- Standardize terminology for "ethdev" vs "port ID"
- Clarify template table specialization description
- Fix minor punctuation and spacing issues

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/flow_offload.rst | 58 ++++++++++---------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/flow_offload.rst b/doc/guides/prog_guide/ethdev/flow_offload.rst
index 1cd904e1ee..d5cca86c82 100644
--- a/doc/guides/prog_guide/ethdev/flow_offload.rst
+++ b/doc/guides/prog_guide/ethdev/flow_offload.rst
@@ -109,7 +109,7 @@ However, ``rte_eth_dev_configure()`` may fail if any rules remain,
 so the application must flush them before attempting a reconfiguration.
 Keeping may be unsupported for some types of rule items and actions,
 as well as depending on the value of flow attributes transfer bit.
-A combination of a single an item or action type
+A combination of a single item or action type
 and a value of the transfer bit is called a rule feature.
 For example: a COUNT action with the transfer bit set.
 To test if rules with a particular feature are kept, the application must try
@@ -198,15 +198,15 @@ Attribute: Transfer
 ^^^^^^^^^^^^^^^^^^^
 
 Instead of simply matching the properties of traffic as it would appear on a
-given DPDK port ID, enabling this attribute transfers a flow rule to the
+given ethdev, enabling this attribute transfers a flow rule to the
 lowest possible level of any device endpoints found in the pattern.
 
 When supported, this effectively enables an application to reroute traffic
 not necessarily intended for it (e.g. coming from or addressed to different
 physical ports, VFs or applications) at the device level.
 
-In "transfer" flows, the use of `Attribute: Traffic direction`_ in not allowed.
-One may use `Item: PORT_REPRESENTOR`_ and `Item: REPRESENTED_PORT`_ instead.
+In "transfer" flows, the use of `Attribute: Traffic direction`_ is not allowed.
+Use `Item: PORT_REPRESENTOR`_ and `Item: REPRESENTED_PORT`_ instead.
 
 Pattern item
 ~~~~~~~~~~~~
@@ -535,11 +535,11 @@ Item: ``PORT_ID``
 ^^^^^^^^^^^^^^^^^
 
 This item is deprecated. Consider:
- - `Item: PORT_REPRESENTOR`_
- - `Item: REPRESENTED_PORT`_
 
-Matches traffic originating from (ingress) or going to (egress) a given DPDK
-port ID.
+- `Item: PORT_REPRESENTOR`_
+- `Item: REPRESENTED_PORT`_
+
+Matches traffic originating from (ingress) or going to (egress) a given ethdev.
 
 Normally only supported if the port ID in question is known by the
 underlying PMD and related to the device the flow rule is created against.
@@ -566,7 +566,7 @@ Item: ``MARK``
 Matches an arbitrary integer value which was set using the ``MARK`` action in
 a previously matched rule.
 
-This item can only specified once as a match criteria as the ``MARK`` action can
+This item can only be specified once as a match criteria as the ``MARK`` action can
 only be specified once in a flow action.
 
 Note the value of MARK field is arbitrary and application defined.
@@ -2058,11 +2058,11 @@ Action: ``PF``
 ^^^^^^^^^^^^^^
 
 This action is deprecated. Consider:
- - `Action: PORT_REPRESENTOR`_
- - `Action: REPRESENTED_PORT`_
 
-Directs matching traffic to the physical function (PF) of the current
-device.
+- `Action: PORT_REPRESENTOR`_
+- `Action: REPRESENTED_PORT`_
+
+Directs matching traffic to the physical function (PF) of the current device.
 
 - No configurable properties.
 
@@ -2080,8 +2080,9 @@ Action: ``VF``
 ^^^^^^^^^^^^^^
 
 This action is deprecated. Consider:
- - `Action: PORT_REPRESENTOR`_
- - `Action: REPRESENTED_PORT`_
+
+- `Action: PORT_REPRESENTOR`_
+- `Action: REPRESENTED_PORT`_
 
 Directs matching traffic to a given virtual function of the current device.
 
@@ -2105,8 +2106,9 @@ rule or if packets are not addressed to a VF in the first place.
 Action: ``PORT_ID``
 ^^^^^^^^^^^^^^^^^^^
 This action is deprecated. Consider:
- - `Action: PORT_REPRESENTOR`_
- - `Action: REPRESENTED_PORT`_
+
+- `Action: PORT_REPRESENTOR`_
+- `Action: REPRESENTED_PORT`_
 
 Directs matching traffic to a given DPDK port ID.
 
@@ -2336,8 +2338,8 @@ VXLAN tunnel as defined in the``rte_flow_action_vxlan_encap`` flow items
 definition.
 
 This action modifies the payload of matched flows. The flow definition specified
-in the ``rte_flow_action_tunnel_encap`` action structure must define a valid
-VLXAN network overlay which conforms with RFC 7348 (Virtual eXtensible Local
+in the ``rte_flow_action_vxlan_encap`` action structure must define a valid
+VXLAN network overlay which conforms with RFC 7348 (Virtual eXtensible Local
 Area Network (VXLAN): A Framework for Overlaying Virtualized Layer 2 Networks
 over Layer 3 Networks). The pattern must be terminated with the
 RTE_FLOW_ITEM_TYPE_END item type.
@@ -2391,7 +2393,7 @@ NVGRE tunnel as defined in the``rte_flow_action_tunnel_encap`` flow item
 definition.
 
 This action modifies the payload of matched flows. The flow definition specified
-in the ``rte_flow_action_tunnel_encap`` action structure must defined a valid
+in the ``rte_flow_action_tunnel_encap`` action structure must define a valid
 NVGRE network overlay which conforms with RFC 7637 (NVGRE: Network
 Virtualization Using Generic Routing Encapsulation). The pattern must be
 terminated with the RTE_FLOW_ITEM_TYPE_END item type.
@@ -2967,10 +2969,10 @@ The indirect action specified data (e.g. counter) can be queried by
    The following description of indirect action persistence
    is an experimental behavior that may change without a prior notice.
 
-If ``RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP`` is not advertised,
-indirect actions cannot be created until the device is started for the first time
-and cannot be kept when the device is stopped.
-However, PMD also does not flush them automatically on stop,
+If the ``RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP`` capability is not advertised,
+indirect actions cannot be created until the device starts for the first time
+and are not kept when the device is stopped.
+However, the PMD also does not flush them automatically on stop,
 so the application must call ``rte_flow_action_handle_destroy()``
 before stopping the device to ensure no indirect actions remain.
 
@@ -3010,7 +3012,7 @@ Indirect API creates a shared flow action with unique action handle.
 Flow rules can access the shared flow action and resources related to
 that action through the indirect action handle.
 In addition, the API allows to update existing shared flow action configuration.
-After the update completes, new action configuration
+After the update completes, the new action configuration
 is available to all flows that reference that shared action.
 
 Indirect actions list expands the indirect action API:
@@ -3020,7 +3022,7 @@ Indirect actions list expands the indirect action API:
   single action only.
   Input flow actions arranged in END terminated list.
 
-- Flow rule can provide rule specific configuration parameters to
+- Flow rules can provide rule-specific configuration parameters to
   existing shared handle.
   Updates of flow rule specific configuration will not change the base
   action configuration.
@@ -3834,8 +3836,8 @@ Group Miss Actions
 ~~~~~~~~~~~~~~~~~~
 
 In an application, many flow rules share common group attributes, meaning they can be grouped and
-classified together. A user can explicitly specify a set of actions performed on a packet when it
-did not match any flows rules in a group using the following API:
+classified together. A user can explicitly specify a set of actions performed on a packet when
+it did not match any flow rules in a group using the following API:
 
 .. code-block:: c
 
-- 
2.51.0

