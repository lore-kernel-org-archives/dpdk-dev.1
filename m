Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74686D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F2EB42788;
	Wed, 14 Jan 2026 23:25:44 +0100 (CET)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67]) by mails.dpdk.org (Postfix) with ESMTP id 085D142791
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:43 +0100 (CET)
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso3339015e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429543;
 x=1769034343; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dc6lwQocpixqdmDbO8cME7/nOsgcBYHI9FyUkTQa7Kg=;
 b=hoQrcPCUzv6K/pwgWCvenhRAHito1b4vULMNL7E1Jh5cv0cJxbOAo+eUbTNOxujIqx
 eEcm21lpxQM705Z7yY96dJdhMnDFanGUXb4qfRCKUn5ybwFp15foF5ZJ6JQ0c8zjolyS
 BwyPIsuka1tGoy3QES7FvcYmjwbVSmfCUGcsYwgJWE7oO5RWceNjq/kunihq2gvmtyEv
 rq0NdlNw6EHc62CUMYImn58v12g/Hqch6Mdw168xFQUSHaI79r9jkJXJklWgM0/+YvwY
 X044jpMem8x+myJi+in0EmodcZJPcwJulJ51csZ10Oh2UtbXDWe9eUhwxt5a5JRpatxb
 zzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429543; x=1769034343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dc6lwQocpixqdmDbO8cME7/nOsgcBYHI9FyUkTQa7Kg=;
 b=ECuaSSF1VDn5trHL/uL7blMUFrAA+pQpsmz+Y9ahkTsIbT73naEUq2Jqv2WAUIefv2
 fpzO5GRCUiCmhcHcAkYSvuwwvt4gKoFjcEqBtStVc7i0cKajgg3jqwTs6JX0ARG0tTOm
 qa4Euiviu+cNGE33VfgssiOgVQnbgPAzJATS6gBRooNbtlXcsZt7gkLP9LoZmzMqaHgh
 ogwv+xO7OJQYNZjqSoNSj8Ki1JSOFufjNCwUoWvo5JSZQhPCZVyKbLlHL5wq7wsJY41c
 grHufGb2q2ym4B/foEz0u5r5X43kDP2XCBGMJ3iluy8j6jrcJ2NqmK9i/qv3fq7dB6Lr
 sXxA==
X-Gm-Message-State: AOJu0YzyhGnHGX8cFYeJcEFqt9MxdlSio4tNWMK1Wzb9VTv1ysesoF5H
 dZNJnAzMzZ2yblXu/bV/AbBIpXPb02+AarSdK9YIuCdN3fkrx1KiQwRH7jjC0CieEWzD6XfatjN
 zgdKw
X-Gm-Gg: AY/fxX7K4wWCiZQM6tNhsHfd+lnd2UzfBsZnuB1WSJXLjB9u8jStZ5+fAYE9GOhZG+d
 lGu0eEKhTWIgqA6zehW7xgPIhQ6EhuLDxo/iTyz01M+lwFAz3H6yGqL2/uMO0yeYS3C2pD5SsvH
 pSbGqeiPeUhfXZ8qaTZTIWOREiAG7HoKdUtDgjr8Bt32K5zEu9p1PIlJuMB0i1RZNK0pbK13odq
 JWp0GtbsDUaMHeZpefvggbVB/bMDu4z19nPE9a2rOoh16aEICUYgtSCE7fRcBCe/eQYeCiCUomm
 kVjnPeyLxQG8cem9Le9gW3R0oRHluNaNhF4I2I8SicM2gk+KYDoEJBqIXoVdhMXKwnkfEtWlXJe
 Z1SFOD7eW9b1qmqi0DKaa9cN7rWFXFEIrqlEHj3B9YucdB6A/qukowPyK3SeU88fj9mZ9A8D1/c
 +SpxWxN6gbnuIEU3Bu8wMzptbxDj09snm0vFSOI9fTv2VsfpyjZTA3qE9TVtgQ
X-Received: by 2002:a05:600c:35c6:b0:47d:900e:c646 with SMTP id
 5b1f17b1804b1-47ee32e9818mr62521375e9.8.1768429541942; 
 Wed, 14 Jan 2026 14:25:41 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 22/29] doc/guides: improve IPsec security gateway guide
Date: Wed, 14 Jan 2026 14:22:03 -0800
Message-ID: <20260114222458.87119-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the IPsec security gateway sample application documentation:
- restructure sections as subsections for consistency
- fix aead_algo syntax documentation (was incorrectly cipher_algo)
- fix "Example SP rules" to "Example Routing rules"
- replace "bigger then" with "bigger than"
- fix "depeneds" typo
- improve grammar and clarity throughout

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ipsec_secgw.rst | 125 +++++++++++------------
 1 file changed, 60 insertions(+), 65 deletions(-)

diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 7319505fe9..ff08343061 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -11,35 +11,30 @@ application using DPDK cryptodev framework.
 Overview
 --------
 
-The application demonstrates the implementation of a Security Gateway
-(not IPsec compliant, see the Constraints section below) using DPDK based on RFC4301,
-RFC4303, RFC3602 and RFC2404.
+This application demonstrates the implementation of a Security Gateway
+(not fully IPsec-compliant; see the Constraints section) using DPDK, based
+on RFC4301, RFC4303, RFC3602, and RFC2404.
 
-Internet Key Exchange (IKE) is not implemented, so only manual setting of
-Security Policies and Security Associations is supported.
+Currently, DPDK does not support Internet Key Exchange (IKE), so Security Policies
+(SP) and Security Associations (SA) must be configured manually. SPs are implemented
+as ACL rules, SAs are stored in a table, and routing is handled using LPM.
 
-The Security Policies (SP) are implemented as ACL rules, the Security
-Associations (SA) are stored in a table and the routing is implemented
-using LPM.
+The application classifies ports as *Protected* or *Unprotected*, with traffic
+received on Unprotected ports considered Inbound and traffic on Protected ports
+considered Outbound.
 
-The application classifies the ports as *Protected* and *Unprotected*.
-Thus, traffic received on an Unprotected or Protected port is consider
-Inbound or Outbound respectively.
+It supports full IPsec protocol offload to hardware (via crypto accelerators or
+Ethernet devices) as well as inline IPsec processing by supported Ethernet
+devices during transmission. These modes can be configured during SA creation.
 
-The application also supports complete IPsec protocol offload to hardware
-(Look aside crypto accelerator or using ethernet device). It also support
-inline ipsec processing by the supported ethernet device during transmission.
-These modes can be selected during the SA creation configuration.
+For full protocol offload, the hardware processes ESP and outer IP headers,
+so the application does not need to add or remove them during Outbound or
+Inbound processing.
 
-In case of complete protocol offload, the processing of headers(ESP and outer
-IP header) is done by the hardware and the application does not need to
-add/remove them during outbound/inbound processing.
-
-For inline offloaded outbound traffic, the application will not do the LPM
-lookup for routing, as the port on which the packet has to be forwarded will be
-part of the SA. Security parameters will be configured on that port only, and
-sending the packet on other ports could result in unencrypted packets being
-sent out.
+In the inline offload mode for Outbound traffic, the application skips the
+LPM lookup for routing, as the SA specifies the port for forwarding. Security
+parameters are configured only on the specified port, and sending packets
+through other ports may result in unencrypted packets being transmitted.
 
 The Path for IPsec Inbound traffic is:
 
@@ -64,27 +59,27 @@ The Path for the IPsec Outbound traffic is:
 
 The application supports two modes of operation: poll mode and event mode.
 
-* In the poll mode a core receives packets from statically configured list
+* In the poll mode, a core receives packets from statically configured list
   of eth ports and eth ports' queues.
 
-* In the event mode a core receives packets as events. After packet processing
-  is done core submits them back as events to an event device. This enables
-  multicore scaling and HW assisted scheduling by making use of the event device
-  capabilities. The event mode configuration is predefined. All packets reaching
-  given eth port will arrive at the same event queue. All event queues are mapped
-  to all event ports. This allows all cores to receive traffic from all ports.
-  Since the underlying event device might have varying capabilities, the worker
-  threads can be drafted differently to maximize performance. For example, if an
-  event device - eth device pair has Tx internal port, then application can call
-  rte_event_eth_tx_adapter_enqueue() instead of regular rte_event_enqueue_burst().
-  So a thread which assumes that the device pair has internal port will not be the
-  right solution for another pair. The infrastructure added for the event mode aims
-  to help application to have multiple worker threads by maximizing performance from
-  every type of event device without affecting existing paths/use cases. The worker
-  to be used will be determined by the operating conditions and the underlying device
-  capabilities.
+* In event mode, a core processes packets as events. After processing, the
+core submits the packets back to an event device, enabling multicore scaling
+and hardware-assisted scheduling by leveraging the capabilities of the event
+device. The event mode configuration is predefined, where all packets arriving
+at a specific Ethernet port are directed to the same event queue. All event
+queues are mapped to all event ports, allowing any core to receive traffic
+from any port. Since event devices can have varying capabilities, worker threads are designed
+differently to optimize performance. For instance, if an event device and Ethernet
+device pair includes a Tx internal port, the application can use `rte_event_eth_tx_adapter_enqueue`
+instead of the standard `rte_event_enqueue_burst`. A thread optimized for a device
+pair with an internal port may not work effectively with another pair. The infrastructure
+for event mode is designed to support multiple worker threads
+while maximizing the performance of each type of event device without impacting
+existing paths or use cases. The worker thread selection depends on the operating
+conditions and the capabilities of the underlying devices.
+
   **Currently the application provides non-burst, internal port worker threads.**
-  It also provides infrastructure for non-internal port
+  It also provides infrastructure for non-internal port,
   however does not define any worker threads.
 
   Event mode also supports event vectorization. The event devices, ethernet device
@@ -97,9 +92,9 @@ The application supports two modes of operation: poll mode and event mode.
   option.
   For the event devices, crypto device pairs which support the capability
   ``RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR`` vector aggregation
-  could also be enable using event-vector option.
+  could also be enabled using event-vector option.
 
-Additionally the event mode introduces two submodes of processing packets:
+Additionally, the event mode introduces two submodes of processing packets:
 
 * Driver submode: This submode has bare minimum changes in the application to support
   IPsec. There are no lookups, no routing done in the application. And for inline
@@ -115,19 +110,19 @@ Additionally the event mode introduces two submodes of processing packets:
   benchmark numbers.
 
 Constraints
------------
+~~~~~~~~~~~
 
 *  No IPv6 options headers.
 *  No AH mode.
 *  Supported algorithms: AES-CBC, AES-CTR, AES-GCM, 3DES-CBC, DES-CBC,
    HMAC-SHA1, HMAC-SHA256, AES-GMAC, AES_CTR, AES_XCBC_MAC, AES_CCM,
    CHACHA20_POLY1305 and NULL.
-*  Each SA must be handle by a unique lcore (*1 RX queue per port*).
+*  Each SA must be handled by a unique lcore (*1 RX queue per port*).
 
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ipsec-secgw`` sub-directory.
 
@@ -170,7 +165,7 @@ Where:
 
 *   ``-j FRAMESIZE``: *optional*. data buffer size (in bytes),
     in other words maximum data size for one segment.
-    Packets with length bigger then FRAMESIZE still can be received,
+    Packets with length bigger than FRAMESIZE still can be received,
     but will be segmented.
     Default value: RTE_MBUF_DEFAULT_BUF_SIZE (2176)
     Minimum value: RTE_MBUF_DEFAULT_BUF_SIZE (2176)
@@ -244,8 +239,8 @@ Where:
     Default value: 0.
 
 *   ``--mtu MTU``: MTU value (in bytes) on all attached ethernet ports.
-    Outgoing packets with length bigger then MTU will be fragmented.
-    Incoming packets with length bigger then MTU will be discarded.
+    Outgoing packets with length bigger than MTU will be fragmented.
+    Incoming packets with length bigger than MTU will be discarded.
     Default value: 1500.
 
 *   ``--frag-ttl FRAG_TTL_NS``: fragment lifetime (in nanoseconds).
@@ -260,7 +255,7 @@ Where:
      via Rx queue setup.
 
 *   ``--vector-pool-sz``: Number of buffers in vector pool.
-    By default, vector pool size depeneds on packet pool size
+    By default, vector pool size depends on packet pool size
     and size of each vector.
 
 *   ``--desc-nb NUMBER_OF_DESC``: Number of descriptors per queue pair.
@@ -377,11 +372,11 @@ For example, something like the following command line:
 
 
 Configurations
---------------
+~~~~~~~~~~~~~~
 
 The following sections provide the syntax of configurations to initialize
 your SP, SA, Routing, Flow and Neighbour tables.
-Configurations shall be specified in the configuration file to be passed to
+Configurations will be specified in the configuration file to be passed to
 the application. The file is then parsed by the application. The successful
 parsing will result in the appropriate rules being applied to the tables
 accordingly.
@@ -390,11 +385,11 @@ accordingly.
 Configuration File Syntax
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As mention in the overview, the Security Policies are ACL rules.
-The application parsers the rules specified in the configuration file and
+As mentioned in the overview, the Security Policies are ACL rules.
+The application parses the rules specified in the configuration file and
 passes them to the ACL table, and replicates them per socket in use.
 
-Following are the configuration file syntax.
+The following sections contain the configuration file syntax.
 
 General rule syntax
 ^^^^^^^^^^^^^^^^^^^
@@ -425,7 +420,7 @@ The SP rule syntax is shown as follows:
     <proto> <sport> <dport>
 
 
-where each options means:
+where each option means:
 
 ``<ip_ver>``
 
@@ -540,7 +535,7 @@ The SA rule syntax is shown as follows:
     <mode> <src_ip> <dst_ip> <action_type> <port_id> <fallback>
     <flow-direction> <port_id> <queue_id> <udp-encap> <reassembly_en>
 
-where each options means:
+where each option means:
 
 ``<dir>``
 
@@ -633,7 +628,7 @@ where each options means:
    * *aes-192-gcm*: AES-GCM 192-bit algorithm
    * *aes-256-gcm*: AES-GCM 256-bit algorithm
 
- * Syntax: *cipher_algo <your algorithm>*
+ * Syntax: *aead_algo <your algorithm>*
 
 ``<aead_key>``
 
@@ -847,7 +842,7 @@ The Routing rule syntax is shown as follows:
     rt <ip_ver> <src_ip> <dst_ip> <port>
 
 
-where each options means:
+where each option means:
 
 ``<ip_ver>``
 
@@ -890,7 +885,7 @@ where each options means:
 
  * Syntax: *port X*
 
-Example SP rules:
+Example Routing rules:
 
 .. code-block:: console
 
@@ -912,7 +907,7 @@ The flow rule syntax is shown as follows:
     flow <mark> <eth> <ip_ver> <src_ip> <dst_ip> <port> <queue> \
          <count> <security> <set_mark>
 
-where each options means:
+where each option means:
 
 ``<mark>``
 
@@ -1039,7 +1034,7 @@ The Neighbour rule syntax is shown as follows:
     neigh <port> <dst_mac>
 
 
-where each options means:
+where each option means:
 
 ``<port>``
 
@@ -1143,7 +1138,7 @@ It then tries to perform some data transfer using the scheme described above.
 Usage
 ~~~~~
 
-In the ipsec-secgw/test directory run
+In the ipsec-secgw/test directory run:
 
 /bin/bash run_test.sh <options> <ipsec_mode>
 
@@ -1176,4 +1171,4 @@ Available options:
 *   ``-h`` Show usage.
 
 If <ipsec_mode> is specified, only tests for that mode will be invoked. For the
-list of available modes please refer to run_test.sh.
+list of available modes, please refer to run_test.sh.
-- 
2.51.0

