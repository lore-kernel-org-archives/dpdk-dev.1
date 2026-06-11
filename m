Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A709FCD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F6EC433B2;
	Thu, 11 Jun 2026 23:21:26 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 71E374025F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:24 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304cf518c9dso571927eec.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212883;
 x=1781817683; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTLaBYJ7NwBSWNsNj5DYMuanf/1rTlYDZl9e5pyT2oc=;
 b=m7HcwRRnyX7m8jRx6m5yxA2sQlGP3QNlI+NkOvnTBO/GwhXpJ63zA3CAV07QPhCnmq
 gnLdhCI5B22BSItcH+wkRNrzeI5iOv/MiKFdQfhQC5cJxpneWvhBmXX3tIfYo6iLyIP+
 hmqQTdiUWVan9BmduEdlUlTEG1JcvBXpLeENOOlQbX1HFUVLkORcqekIRBu8XgWzvb/z
 dt9aKB1qD4u4OoSg+w21yyWHGjwHHNd6K2JzCQlvvjPO3hZgRhxivpV9gOtaOwKuTo84
 GQ2ziWln3lBFyjabRyTA6ZVmbo4vpaXp/O4hE8xl/m8ibCBxFEwYXR7oHKT0Y6B5O9md
 ejXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212883; x=1781817683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTLaBYJ7NwBSWNsNj5DYMuanf/1rTlYDZl9e5pyT2oc=;
 b=bx5+9MZi9jEtmJfvwvA0RkV13A4nfs26Ec4NYSNY3AJvqvFNxGgsBJXfRfibp5CcYA
 y3Zw3vbdbtAhCsU6L7rky47yVxExPW5e2p4HjpS4zxDL+1VvgppwGEJDeWmpEdWQwRlA
 wGVzwKnDaZZcJ8aAZQnv48IGyarQyHszi07mkDZbzuKTcn4cMyu30FqPtKd6VUypfS5M
 OWMzXQfdWie/jkhbNxkpyjWqhmXT0K2FEYCMOgKlFRQMqCfvmZESw2sqckouFt/CyAXG
 AACiWejug8PBcLq9LhWnFFGVr09ieL3HYwJFDhPztOAS4XrC6q3OjiOOEJJhgBcnh8+u
 qPzA==
X-Gm-Message-State: AOJu0YxC6wLYK2GiceAMbh6sFj9s6St0AL9HcUs5hPje1Oif1ETJW//1
 fuOhuxRbws2VlZEvoFsPU4shh57szooOvduUr3z6gIhkL9iRih074CL1EHqCLaGIv/vPr6upVgo
 0lRu7
X-Gm-Gg: Acq92OGJI81kl6OL0Y6conAx4u/ZbyLdxV1GDOFgWhAetPlqRfa9XMWZM4m1rVhmLCO
 Hi9olreyvynYiV1j6awUo9UHxON1it/bqy13P3KZanJZUXqtJENEJ/TLlNxOeJ5ZmLIBSqP0dtm
 93f9ehCzATQ09DxLUy04RLGJSPItL3S2UBy1EnbeQk8ueR/K1UTqdxmhhxhQMF/kH0SQAlDdzj8
 SisgqtXhNUl3/XokJJFVAUzfj1WLTaEITe/NMyQ/PtG/6eMmOHaztRzdnXE7kh7oVlbra/xxE+r
 8YQ0r24nhPw7Wkkxc1sPT5TRVdiIcXHkXevfzeqS44DrY7bDeuUubsJqs2mu8IXd5GAtLbGcdIM
 p2hSC/XDA6Mo7NBvmg0QjMIoPfvbPoZVmsp9buWvZE1X5ZlY9VWwxJdXLfGH45iCrWiqS7XPu1T
 S/vRtN4Njc0kDZ46S19KYGc0jH+4BnQWl9cV48oXEr5zqlj1cQAh1cIV2AyHPc10ILHx4tiRQo
X-Received: by 2002:a05:7301:e2b:b0:304:d835:27f with SMTP id
 5a478bee46e88-30820056b66mr25900eec.22.1781212883412; 
 Thu, 11 Jun 2026 14:21:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH 01/15] doc: cleanups to bbdev sample application
Date: Thu, 11 Jun 2026 14:18:40 -0700
Message-ID: <20260611212119.1026721-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611212119.1026721-1-stephen@networkplumber.org>
References: <20250216230903.124496-1-nandinipersad361@gmail.com>
 <20260611212119.1026721-1-stephen@networkplumber.org>
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

Semi-automated cleanup of wording of bbdev sample guide.

Refactored the bbdev sample application documentation for better clarity:
- Simplified the overview section with clearer flow description
- Improved formatting of command-line options using definition list
- Clarified hardware/software device requirements
- Enhanced example command explanation with bullet points
- Fixed grammatical issues and improved readability

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/bbdev_app.rst | 69 +++++++++++++-------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/doc/guides/sample_app_ug/bbdev_app.rst b/doc/guides/sample_app_ug/bbdev_app.rst
index a699e8a61d..00bbd1aa27 100644
--- a/doc/guides/sample_app_ug/bbdev_app.rst
+++ b/doc/guides/sample_app_ug/bbdev_app.rst
@@ -14,14 +14,13 @@ Overview
 --------
 
 The Baseband device sample application performs a loop-back operation using a
-baseband device capable of transceiving data packets.
-A packet is received on an ethernet port -> enqueued for downlink baseband
-operation -> dequeued from the downlink baseband device -> enqueued for uplink
-baseband operation -> dequeued from the baseband device -> then the received
-packet is compared with the baseband operations output. Then it's looped back to
-the ethernet port.
+baseband device capable of performing encoding and decoding operations.
+A packet is received on an Ethernet port, enqueued for downlink baseband
+operation, dequeued from the downlink baseband device, enqueued for uplink
+baseband operation, dequeued from the baseband device, compared with the
+expected output, and then transmitted back to the Ethernet port.
 
-*   The MAC header is preserved in the packet
+The MAC header is preserved in the packet throughout the loop-back operation.
 
 Limitations
 -----------
@@ -33,7 +32,7 @@ Compiling the Application
 
 DPDK needs to be built with ``baseband_turbo_sw`` PMD enabled along
 with ``FLEXRAN SDK`` Libraries. Refer to *SW Turbo Poll Mode Driver*
-documentation for more details on this.
+documentation for more details.
 
 To compile the sample application see :doc:`compiling`.
 
@@ -48,40 +47,41 @@ The application accepts a number of command line options:
     $ ./<build_dir>/examples/dpdk-bbdev [EAL options] -- [-e ENCODING_CORES] /
     [-d DECODING_CORES] [-p ETH_PORT_ID] [-b BBDEV_ID]
 
-where:
+Where:
+
+``-e ENCODING_CORES``
+   Hexadecimal bitmask specifying lcores for encoding operations (default: 0x2).
+
+``-d DECODING_CORES``
+   Hexadecimal bitmask specifying lcores for decoding operations (default: 0x4).
 
-* ``e ENCODING_CORES``: hexmask for encoding lcores (default = 0x2)
-* ``d DECODING_CORES``: hexmask for decoding lcores (default = 0x4)
-* ``p ETH_PORT_ID``: ethernet port ID (default = 0)
-* ``b BBDEV_ID``: BBDev ID (default = 0)
+``-p ETH_PORT_ID``
+   Ethernet port ID (default: 0).
 
-The application requires that baseband devices is capable of performing
-the specified baseband operation are available on application initialization.
-This means that HW baseband device/s must be bound to a DPDK driver or
-a SW baseband device/s (virtual BBdev) must be created (using --vdev).
+``-b BBDEV_ID``
+   Baseband device ID (default: 0).
 
-To run the application in linux environment with the turbo_sw baseband device
-using the allow option for pci device running on 1 encoding lcore and 1 decoding lcore
-issue the command:
+The application requires that baseband devices are capable of performing
+the specified baseband operations at initialization time. Hardware baseband
+devices must be bound to a DPDK driver, or software baseband devices (virtual
+BBdev) must be created using the ``--vdev`` option.
+
+To run the application in a Linux environment with the turbo_sw baseband device,
+using one encoding lcore and one decoding lcore:
 
 .. code-block:: console
 
     $ ./<build_dir>/examples/dpdk-bbdev --vdev='baseband_turbo_sw' -a <NIC0PCIADDR> \
     -l 3,4,5 --numa-mem=2,2 --file-prefix=bbdev -- -e 0x10 -d 0x20
 
-where, NIC0PCIADDR is the PCI address of the Rx port
-
-This command creates one virtual bbdev devices ``baseband_turbo_sw`` where the
-device gets linked to a corresponding ethernet port as allowed by
-the parameter -a.
-3 cores are allocated to the application, and assigned as:
-
- - core 3 is the main and used to print the stats live on screen,
+Where ``NIC0PCIADDR`` is the PCI address of the Ethernet port.
 
- - core 4 is the encoding lcore performing Rx and Turbo Encode operations
+This command creates one virtual BBdev device (``baseband_turbo_sw``) and
+allows access to the specified Ethernet port. Three cores are allocated:
 
- - core 5 is the downlink lcore performing Turbo Decode, validation and Tx
-   operations
+- Core 3: Main lcore, prints statistics to screen
+- Core 4: Encoding lcore, performs Rx and Turbo Encode operations
+- Core 5: Decoding lcore, performs Turbo Decode, validation, and Tx operations
 
 
 Refer to the *DPDK Getting Started Guide* for general information on running
@@ -91,9 +91,8 @@ Using Packet Generator with baseband device sample application
 --------------------------------------------------------------
 
 To allow the bbdev sample app to do the loopback, an influx of traffic is required.
-This can be done by using DPDK Pktgen to burst traffic on two ethernet ports, and
-it will print the transmitted along with the looped-back traffic on Rx ports.
-Executing the command below will generate traffic on the two allowed ethernet
+This can be done using DPDK Pktgen to generate traffic on Ethernet ports.
+Executing the command below will generate traffic on the allowed Ethernet
 ports.
 
 .. code-block:: console
@@ -111,5 +110,5 @@ where:
 * ``-P``: PROMISCUOUS mode
 
 
-Refer to *The Pktgen Application* documents for general information on running
+Refer to *The Pktgen Application* documentation for general information on running
 Pktgen with DPDK applications.
-- 
2.53.0

