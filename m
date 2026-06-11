Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B88CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 202E8433E4;
	Thu, 11 Jun 2026 23:21:36 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 9FF2D433D1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:32 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso906287eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212892;
 x=1781817692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3S8UvmG+6zm7S91CddaBYzOBQ0R8FO3nYtf0nCA2Lk=;
 b=D9ZO7O0fYMKtK/9KRzeZu5u8/T+7fyLnZvdcfOAWo9ryFbgrkWPIceU5k92qVlGPSS
 +Ap3Uvh0y4DVCayJlLr4af5K0dD+Uj8Il6lcUjHueK5XNlvzGCYlnvMCI1AZg6BS3BG8
 5+saXl8bQ+lP4SrKhYRoB19exCoT3PJI1K6ZEZv7w05pTHjLP+3C/8layQK2ZUzFY15P
 9cg5If77OBw5OhoteuNSYEHGVAqR5P5VV4xfBNjPeJdQ1Q7vj/Y5Jd8HcNTpYBZnNdpK
 /DxRgmeUp6q/7rwnURKXtWu7W3/TYOyKg8uOBQNJV8rIICZapaHjZdo1UUY5GP4qOuC2
 UvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212892; x=1781817692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p3S8UvmG+6zm7S91CddaBYzOBQ0R8FO3nYtf0nCA2Lk=;
 b=PEW/kqIacztqHzQBjbQQ0pDKt5AlT6xpes8j/jLsUPSoNNklCw76SqR+9BN5g3u18R
 Yo9jsO6Vfdpcu0yLviukvVyMUIAPe6U8liJ08hymDlxm1Q0Z/+ljcK1vj0SMF1BW+93o
 M/o+drr9u+MRS+GXmDi4SyYFiFcBfZycXvp1rcq+ZAC4oCGfnb9HlqEF6O+jxFAz6ZW8
 6vt6QEA/0vTVx4m3Wbp6g+jKcDl20O6GeBAv+8XSxLccp+Be6hafkAwXIwzjJIzt7uFO
 nNE5GQ+/6CHShc/JARXnzCv0Uh6zyD4ykJa9s3uD5pEm60cgiO7ZyW3ri9q7kIRvNMZD
 K93w==
X-Gm-Message-State: AOJu0YyYftCiABNh2MysMr5e2ngG9Yae0RESQzAhbtMrqsbNu0gP9bFs
 RUm4aF2aU/ZB7Bku9Ec1fLAFcYb15UvhYNtXRgcqjjDdZWEOd/zfGmegXuL/G+chPe6VKI/StNx
 X23z1
X-Gm-Gg: Acq92OHoVuFBOTH28I0UW/Y5GEuvkMHALpkmCcAJpfoDxUXTblpkiqzc2WC6jKJZ/Pt
 jajaGDJj3jdVxyr5xWXNqQxIn8QEF5GvI7j2MT7m7/BjX4J5CgYJyrx8WAQ7Lm8cJkqGUg/I6e/
 rDq9ubNNs7032hGol3afcpZYEtgQBAp/O/hfmht0Fi3umya17hwfrOE0iZz4TQC0ht53NUb1q2x
 uvjXgAyjQYAFR7YXetRnyGCGGtjrFYrXdIgSZGuMenKMo3fWWWoKXhrxcdddoFQ1BBaNLtGSrDw
 YbAOT3EeKB8XvLL5v30xCeTStxJo7zebAxyGxjAziQk6bo2Qo0usA5efDsAUu02Lp/NU12mhVLt
 KJ9/QWXTC8tA8LZf3qQ+kk1Nl42KjqJFvG9A59ghNdvlMJRlfTsgkjBAXnl/Ff8+m5BcgnI08xl
 kXr9FvobQCpu4rlltKU3xqpzN4xH/rzQrML12tqx1qErnpn17ck2/IWMzXka4zKA==
X-Received: by 2002:a05:7300:6417:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-3081ff64166mr48692eec.3.1781212891344; 
 Thu, 11 Jun 2026 14:21:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 09/15] doc: improve IP reassembly, IPsec, multicast,
 and keep-alive
Date: Thu, 11 Jun 2026 14:18:48 -0700
Message-ID: <20260611212119.1026721-10-stephen@networkplumber.org>
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

Updated multiple networking sample application guides:

ip_reassembly.rst:
- Enhanced fragment reassembly process descriptions
- Improved command-line parameter documentation
- Fixed formatting and terminology consistency

ipsec_secgw.rst:
- Restructured configuration file format sections
- Improved security association descriptions
- Enhanced clarity of IPsec gateway operations

ipv4_multicast.rst:
- Simplified multicast forwarding explanations
- Fixed formatting in code examples
- Improved readability of routing descriptions

keep_alive.rst:
- Enhanced keep-alive mechanism descriptions
- Fixed minor formatting issues

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ip_reassembly.rst  |  57 ++++++-----
 doc/guides/sample_app_ug/ipsec_secgw.rst    | 108 ++++++++++----------
 doc/guides/sample_app_ug/ipv4_multicast.rst |  26 ++---
 doc/guides/sample_app_ug/keep_alive.rst     |  12 +--
 4 files changed, 105 insertions(+), 98 deletions(-)

diff --git a/doc/guides/sample_app_ug/ip_reassembly.rst b/doc/guides/sample_app_ug/ip_reassembly.rst
index 04b581a489..02ed9f0472 100644
--- a/doc/guides/sample_app_ug/ip_reassembly.rst
+++ b/doc/guides/sample_app_ug/ip_reassembly.rst
@@ -4,15 +4,15 @@
 IP Reassembly Sample Application
 ================================
 
-The L3 Forwarding application is a simple example of packet processing using the DPDK.
-The application performs L3 forwarding with reassembly for fragmented IPv4 and IPv6 packets.
+The IP Reassembly application is a simple example of packet processing using the DPDK.
+The application performs L3 forwarding with reassembly of fragmented IPv4 and IPv6 packets.
 
 Overview
 --------
 
 The application demonstrates the use of the DPDK libraries to implement packet forwarding
 with reassembly for IPv4 and IPv6 fragmented packets.
-The initialization and run- time paths are very similar to those of the :doc:`l2_forward_real_virtual`.
+The initialization and run-time paths are very similar to those of the :doc:`l2_forward_real_virtual`.
 The main difference from the L2 Forwarding sample application is that
 it reassembles fragmented IPv4 and IPv6 packets before forwarding.
 The maximum allowed size of reassembled packet is 9.5 KB.
@@ -21,11 +21,11 @@ There are two key differences from the L2 Forwarding sample application:
 
 *   The first difference is that the forwarding decision is taken based on information read from the input packet's IP header.
 
-*   The second difference is that the application differentiates between IP and non-IP traffic by means of offload flags.
+*   The second difference is that the applications differentiate between IP and non-IP traffic by means of offload flags.
 
 The Longest Prefix Match (LPM for IPv4, LPM6 for IPv6) table is used to store/lookup an outgoing port number,
-associated with that IPv4 address. Any unmatched packets are forwarded to the originating port.
-
+associated with that IPv4 address.
+Any unmatched packets are forwarded to the originating port.
 
 Compiling the Application
 -------------------------
@@ -46,15 +46,20 @@ The application has a number of command line options:
 
 where:
 
-*   -p PORTMASK: Hexadecimal bitmask of ports to configure
+``-p PORTMASK``
+    Hexadecimal bitmask of ports to configure
 
-*   -q NQ: Number of RX queues per lcore
+``-q NQ``
+    Number of RX queues per lcore
 
-*   --maxflows=FLOWS: determines maximum number of active fragmented flows (1-65535). Default value: 4096.
+``--maxflows=FLOWS``
+    Determines the maximum number of active fragmented flows (1-65535).
+    Default value: 4096.
 
-*   --flowttl=TTL[(s|ms)]: determines maximum Time To Live for fragmented packet.
-    If all fragments of the packet wouldn't appear within given time-out,
-    then they are considered as invalid and will be dropped.
+``--flowttl=TTL[(s|ms)]``
+    Determines the maximum Time To Live for fragmented packets.
+    If all fragments of the packet do not appear within the given timeout,
+    then they are considered invalid and will be dropped.
     Valid range is 1ms - 3600s. Default value: 1s.
 
 To run the example in a Linux environment with 2 lcores (2,4) over 2 ports(0,2)
@@ -69,7 +74,7 @@ with 1 Rx queue per lcore:
     Skipping disabled port 1
     Initializing port 2 on lcore 4... Address:00:1B:21:5C:FF:54, rxq=0 txq=2,0 txq=4,1
     done: Link Up - speed 10000 Mbps - full-duplex
-    Skipping disabled port 3IP_FRAG: Socket 0: adding route 100.10.0.0/16 (port 0)
+    Skipping disabled port 3 IP_FRAG: Socket 0: adding route 100.10.0.0/16 (port 0)
     IP_RSMBL: Socket 0: adding route 100.20.0.0/16 (port 1)
     ...
     IP_RSMBL: Socket 0: adding route 0101:0101:0101:0101:0101:0101:0101:0101/48 (port 0)
@@ -110,7 +115,7 @@ The default l3fwd_ipv6_route_array table is:
     :end-before: >8 End of default l3fwd_ipv6_route_array table.
 
 For example, for the fragmented input IPv4 packet with destination address: 100.10.1.1,
-a reassembled IPv4 packet be sent out from port #0 to the destination address 100.10.1.1
+a reassembled IPv4 packet will be sent out from port #0 to the destination address 100.10.1.1
 once all the fragments are collected.
 
 Explanation
@@ -119,12 +124,12 @@ Explanation
 The following sections provide in-depth explanation of the sample application code.
 As mentioned in the overview section, the initialization and run-time paths
 are very similar to those of the :doc:`l2_forward_real_virtual`.
-The following sections describe aspects that are specific to the IP reassemble sample application.
+The following sections describe aspects that are specific to the IP reassembly sample application.
 
 IPv4 Fragment Table Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-This application uses the :doc:`../prog_guide/ip_fragment_reassembly_lib` library.
+This application uses the IP Fragment and Reassembly Library (:doc:`../prog_guide/ip_fragment_reassembly_lib`).
 The fragment table maintains information about already received fragments of the packet.
 Each IP packet is uniquely identified by triple <Source IP address>, <Destination IP address>, <ID>.
 To avoid lock contention, each Rx queue has its own fragment table.
@@ -144,7 +149,7 @@ Mempools Initialization
 
 The reassembly application demands a lot of mbuf's to be allocated.
 At any given time, up to (2 \* max_flow_num \* RTE_LIBRTE_IP_FRAG_MAX_FRAG \* <maximum number of mbufs per packet>)
-can be stored inside the fragment table waiting for remaining fragments.
+can be stored inside the fragment table, waiting for remaining fragments.
 To keep mempool size under reasonable limits
 and to avoid a situation when one Rx queue can starve other queues,
 each Rx queue uses its own mempool.
@@ -161,8 +166,8 @@ Packet Reassembly and Forwarding
 For each input packet, the packet forwarding operation is done by the l3fwd_simple_forward() function.
 If the packet is an IPv4 or IPv6 fragment, then it calls ``rte_ipv4_reassemble_packet()`` for IPv4 packets,
 or ``rte_ipv6_reassemble_packet()`` for IPv6 packets.
-These functions either return a pointer to a valid mbuf that contains a reassembled packet,
-or NULL (if the packet can't be reassembled for some reason).
+These functions return either a pointer to a valid mbuf that contains a reassembled packet,
+or NULL (if the packet cannot be reassembled for some reason).
 Then, ``l3fwd_simple_forward()`` continues with the code for the packet forwarding decision
 (that is, the identification of the output interface for the packet) and
 actual transmit of the packet.
@@ -171,25 +176,25 @@ The ``rte_ipv4_reassemble_packet()`` or ``rte_ipv6_reassemble_packet()`` are res
 
 #.  Searching the fragment table for entry with packet's <IP Source Address, IP Destination Address, Packet ID>
 
-#.  If the entry is found, then check if that entry already timed-out.
+#.  If the entry is found, then check whether that entry has already timed out.
     If yes, then free all previously received fragments,
     and remove information about them from the entry.
 
 #.  If no entry with such key is found, then try to create a new one by one of two ways:
 
-    #.  Use as empty entry
+    #.  Use an empty entry
 
-    #.  Delete a timed-out entry, free mbufs associated with it mbufs and store a new entry with specified key in it.
+    #.  Delete a timed-out entry, free mbufs associated with it, and store a new entry with the specified key in it.
 
-#.  Update the entry with new fragment information and check
-    if a packet can be reassembled (the packet's entry contains all fragments).
+#.  Update the entry with new fragment information and check whether
+    the packet can be reassembled (the packet's entry contains all fragments).
 
     #.  If yes, then, reassemble the packet, mark table's entry as empty and return the reassembled mbuf to the caller.
 
     #.  If no, then just return a NULL to the caller.
 
-If at any stage of packet processing a reassembly function encounters an error
-(can't insert new entry into the Fragment table, or invalid/timed-out fragment),
+If at any stage of packet processing, a reassembly function encounters an error
+(cannot insert new entry into the Fragment table, or invalid/timed-out fragment),
 then it will free all associated with the packet fragments,
 mark the table entry as invalid and return NULL to the caller.
 
diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 7c31c96b7c..8826ffb286 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -11,40 +11,40 @@ application using DPDK cryptodev framework.
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
+Internet Key Exchange (IKE) is not implemented in this example; only manual
+setting of Security Policies and Security Associations is supported.
 
 The Security Policies (SP) are implemented as ACL rules, the Security
-Associations (SA) are stored in a table and the routing is implemented
+Associations (SA) are stored in a table, and the routing is implemented
 using LPM.
 
-The application classifies the ports as *Protected* and *Unprotected*.
-Thus, traffic received on an Unprotected or Protected port is consider
-Inbound or Outbound respectively.
+The application classifies ports as *Protected* or *Unprotected*, with traffic
+received on Unprotected ports considered Inbound and traffic on Protected ports
+considered Outbound.
 
 The application also supports complete IPsec protocol offload to hardware
-(Look aside crypto accelerator or using ethernet device). It also support
-inline ipsec processing by the supported ethernet device during transmission.
-These modes can be selected during the SA creation configuration.
+using crypto acceleration hardware or NIC with crypto acceleration. It also
+supports inline IPsec processing by supported Ethernet devices during
+transmission. These modes can be selected during SA creation.
 
-In case of complete protocol offload, the processing of headers(ESP and outer
-IP header) is done by the hardware and the application does not need to
-add/remove them during outbound/inbound processing.
+In case of complete protocol offload, the processing of headers (ESP and
+outer IP header) is done by the hardware and the application does not need
+to add/remove them during Outbound/Inbound processing.
 
-For inline offloaded outbound traffic, the application will not do the LPM
-lookup for routing, as the port on which the packet has to be forwarded will be
-part of the SA. Security parameters will be configured on that port only, and
+For inline offloaded Outbound traffic, the application does not perform the
+LPM lookup for routing, as the port on which the packet is to be forwarded
+is part of the SA. Security parameters are configured on that port only, and
 sending the packet on other ports could result in unencrypted packets being
 sent out.
 
 The Path for IPsec Inbound traffic is:
 
 *  Read packets from the port.
-*  Classify packets between IPv4 and ESP.
+*  Classify packets as IPv4 or ESP.
 *  Perform Inbound SA lookup for ESP packets based on their SPI.
 *  Perform Verification/Decryption (Not needed in case of inline ipsec).
 *  Remove ESP and outer IP header (Not needed in case of protocol offload).
@@ -64,28 +64,30 @@ The Path for the IPsec Outbound traffic is:
 
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
+* In event mode, a core receives packets as events. After processing,
+  the core submits them back as events to an event device. This enables
+  multicore scaling and hardware-assisted scheduling by making use of
+  the event device capabilities. The event mode configuration is
+  predefined. All packets reaching a given Ethernet port arrive at the
+  same event queue. All event queues are mapped to all event ports,
+  allowing all cores to receive traffic from all ports.
+  Since the underlying event device might have varying capabilities,
+  worker threads can be designed differently to maximize performance.
+  For example, if an event device-Ethernet device pair has a Tx internal
+  port, the application can call ``rte_event_eth_tx_adapter_enqueue()``
+  instead of ``rte_event_enqueue_burst()``. A thread that assumes the
+  device pair has an internal port may not be suitable for another pair.
+  The event mode infrastructure supports multiple worker threads,
+  maximizing performance from every type of event device without
+  affecting existing paths or use cases. The worker to be used is
+  determined by the operating conditions and underlying device
   capabilities.
+
   **Currently the application provides non-burst, internal port worker threads.**
-  It also provides infrastructure for non-internal port
-  however does not define any worker threads.
+  It also provides infrastructure for non-internal ports but does not define any worker threads.
 
   Event mode also supports event vectorization. The event devices, ethernet device
   pairs which support the capability ``RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR`` can
@@ -99,7 +101,7 @@ The application supports two modes of operation: poll mode and event mode.
   ``RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR`` vector aggregation
   could also be enable using event-vector option.
 
-Additionally the event mode introduces two submodes of processing packets:
+Additionally, the event mode introduces two submodes of processing packets:
 
 * Driver submode: This submode has bare minimum changes in the application to support
   IPsec. There are no lookups, no routing done in the application. And for inline
@@ -115,7 +117,7 @@ Additionally the event mode introduces two submodes of processing packets:
   benchmark numbers.
 
 Constraints
------------
+~~~~~~~~~~~
 
 *  No IPv6 options headers.
 *  No AH mode.
@@ -127,7 +129,7 @@ Constraints
 Compiling the Application
 -------------------------
 
-To compile the sample application see :doc:`compiling`.
+To compile the sample application, see :doc:`compiling`.
 
 The application is located in the ``ipsec-secgw`` sub-directory.
 
@@ -354,7 +356,7 @@ where each option means:
 Refer to the *DPDK Getting Started Guide* for general information on running
 applications and the Environment Abstraction Layer (EAL) options.
 
-The application would do a best effort to "map" crypto devices to cores, with
+The application makes a best effort to "map" crypto devices to cores, with
 hardware devices having priority. Basically, hardware devices if present would
 be assigned to a core before software ones.
 This means that if the application is using a single core and both hardware
@@ -377,7 +379,7 @@ For example, something like the following command line:
 
 
 Configurations
---------------
+~~~~~~~~~~~~~~
 
 The following sections provide the syntax of configurations to initialize
 your SP, SA, Routing, Flow and Neighbour tables.
@@ -390,17 +392,17 @@ accordingly.
 Configuration File Syntax
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As mention in the overview, the Security Policies are ACL rules.
-The application parsers the rules specified in the configuration file and
-passes them to the ACL table, and replicates them per socket in use.
+As mentioned in the overview, the Security Policies are ACL rules.
+The application parses the rules specified in the configuration file and
+passes them to ACL table, and replicates them per socket in use.
 
-Following are the configuration file syntax.
+The following sections contains the configuration file syntax.
 
 General rule syntax
 ^^^^^^^^^^^^^^^^^^^
 
 The parse treats one line in the configuration file as one configuration
-item (unless the line concatenation symbol exists). Every configuration
+item (unless line concatenation is used). Every configuration
 item shall follow the syntax of either SP, SA, Routing, Flow or Neighbour
 rules specified below.
 
@@ -711,7 +713,7 @@ where each options means:
  * Port/device ID of the ethernet/crypto accelerator for which the SA is
    configured. For *inline-crypto-offload* and *inline-protocol-offload*, this
    port will be used for routing. The routing table will not be referred in
-   this case.
+   that case.
 
  * Optional: No, if *type* is not *no-offload*
 
@@ -766,7 +768,7 @@ where each options means:
 
  ``<mss>``
 
- * Maximum segment size for TSO offload, available for egress SAs only.
+ * Maximum segment size for TSO offload; available for egress SAs only.
    Currently only supports TCP/IP.
 
  * Optional: Yes, TSO offload not set by default
@@ -1113,7 +1115,7 @@ available.
 Server configuration
 ~~~~~~~~~~~~~~~~~~~~
 
-Two servers are required for the tests, SUT and DUT.
+Two servers are required for the tests: SUT and DUT.
 
 Make sure the user from the SUT can ssh to the DUT without entering the password.
 To enable this feature keys must be setup on the DUT.
@@ -1152,7 +1154,7 @@ It then tries to perform some data transfer using the scheme described above.
 Usage
 ~~~~~
 
-In the ipsec-secgw/test directory run
+In the ipsec-secgw/test directory run:
 
 /bin/bash run_test.sh <options> <ipsec_mode>
 
@@ -1165,7 +1167,7 @@ Available options:
     selected.
 
 *   ``-m`` Add IPSec tunnel mixed IP version tests - outer IP version different
-    than inner. Inner IP version will match selected option [-46].
+    from inner. Inner IP version will match selected option [-46].
 
 *   ``-i`` Run tests in inline mode. Regular tests will not be invoked.
 
@@ -1185,4 +1187,4 @@ Available options:
 *   ``-h`` Show usage.
 
 If <ipsec_mode> is specified, only tests for that mode will be invoked. For the
-list of available modes please refer to run_test.sh.
+list of available modes, please refer to run_test.sh.
diff --git a/doc/guides/sample_app_ug/ipv4_multicast.rst b/doc/guides/sample_app_ug/ipv4_multicast.rst
index 3eb8b95f29..4304be665d 100644
--- a/doc/guides/sample_app_ug/ipv4_multicast.rst
+++ b/doc/guides/sample_app_ug/ipv4_multicast.rst
@@ -63,7 +63,7 @@ where,
 
 *   -p PORTMASK: Hexadecimal bitmask of ports to configure
 
-*   -q NQ: determines the number of queues per lcore
+*   -q NQ: number of queues per lcore
 
 .. note::
 
@@ -125,7 +125,7 @@ Forwarding
 ~~~~~~~~~~
 
 All forwarding is done inside the ``mcast_forward()`` function.
-Firstly, the Ethernet* header is removed from the packet and the IPv4 address is extracted from the IPv4 header:
+Firstly, the Ethernet header is removed from the packet and the IPv4 address is extracted from the IPv4 header:
 
 .. literalinclude:: ../../../examples/ipv4_multicast/main.c
     :language: c
@@ -170,7 +170,7 @@ with the Ethernet address 01:00:5e:00:00:00, as per RFC 1112:
     :start-after: Construct Ethernet multicast address from IPv4 multicast Address. 8<
     :end-before: >8 End of Construction of multicast address from IPv4 multicast address.
 
-Packets are then dispatched to the destination ports according to the portmask associated with a multicast group:
+Packets are then dispatched to the destination ports according to the port mask associated with the multicast group:
 
 .. literalinclude:: ../../../examples/ipv4_multicast/main.c
     :language: c
@@ -190,12 +190,11 @@ Buffer Cloning
 
 This is the most important part of the application
 since it demonstrates the use of zero-copy buffer cloning.
-There are two approaches for creating the outgoing packet.
-Although both are based on the data zero-copy idea,
-there are some differences in the details.
+There are two approaches for creating outgoing packets.
+Both are based on the zero-copy idea, but they differ in implementation details.
 
-The first approach creates a clone of the input packet. For example,
-walk though all segments of the input packet and for each of segment,
+The first approach creates a clone of the input packet:
+walk through all segments of the input packet and for each segment,
 create a new buffer and attach that new buffer to the segment
 (refer to ``rte_pktmbuf_clone()`` in the mbuf library for more details).
 A new buffer is then allocated for the packet header and is prepended to the cloned buffer.
@@ -205,18 +204,19 @@ It simply increments the reference counter for all input packet segments,
 allocates a new buffer for the packet header and prepends it to the input packet.
 
 Basically, the first approach reuses only the input packet's data, but creates its own copy of packet's metadata.
-The second approach reuses both input packet's data and metadata.
+The second approach reuses both the input packet's data and metadata.
 
-The advantage of the first approach is that each outgoing packet has its own copy of the metadata,
+The advantage of the first approach is that each outgoing packet has its own copy of metadata,
 so we can safely modify the data pointer of the input packet.
-That allows us to skip creation if the output packet is for the last destination port
+That allows us to skip packet creation if the output packet is for the last destination port
 and, instead, modify the input packet's header in place.
 For example, for N destination ports, we need to invoke ``mcast_out_pkt()`` (N-1) times.
 
 The advantage of the second approach is that there is less work to be done for each outgoing packet.
 The "clone" operation is skipped completely.
-However, there is a price to pay.
-The input packet's metadata must remain intact. For N destination ports,
+However, there is a price to pay:
+the input packet's metadata must remain intact.
+For N destination ports,
 we need to invoke ``mcast_out_pkt()`` (N) times.
 
 Therefore, for a small number of outgoing ports (and segments in the input packet),
diff --git a/doc/guides/sample_app_ug/keep_alive.rst b/doc/guides/sample_app_ug/keep_alive.rst
index 8ae9d7c689..9353b65e91 100644
--- a/doc/guides/sample_app_ug/keep_alive.rst
+++ b/doc/guides/sample_app_ug/keep_alive.rst
@@ -5,7 +5,7 @@ Keep Alive Sample Application
 =============================
 
 The Keep Alive application is a simple example of a
-heartbeat/watchdog for packet processing cores. It demonstrates how
+heartbeat and watchdog for packet processing cores. It demonstrates how
 to detect 'failed' DPDK cores and notify a fault management entity
 of this failure. Its purpose is to ensure the failure of the core
 does not result in a fault that is not detectable by a management
@@ -19,7 +19,7 @@ The application demonstrates how to protect against 'silent outages'
 on packet processing cores. A Keep Alive Monitor Agent Core (main)
 monitors the state of packet processing cores (worker cores) by
 dispatching pings at a regular time interval (default is 5ms) and
-monitoring the state of the cores. Cores states are: Alive, MIA, Dead
+monitoring the state of the cores. Core states are: Alive, MIA, Dead
 or Buried. MIA indicates a missed ping, and Dead indicates two missed
 pings within the specified time interval. When a core is Dead, a
 callback function is invoked to restart the packet processing core;
@@ -80,16 +80,16 @@ Explanation
 
 The following sections provide explanation of the
 Keep-Alive/'Liveliness' conceptual scheme. As mentioned in the
-overview section, the initialization and run-time paths are very
+Overview section, the initialization and run-time paths are very
 similar to those of the :doc:`l2_forward_real_virtual`.
 
 The Keep-Alive/'Liveliness' conceptual scheme:
 
-* A Keep- Alive Agent Runs every N Milliseconds.
+* A keep-alive agent runs every N milliseconds.
 
-* DPDK Cores respond to the keep-alive agent.
+* DPDK cores respond to the keep-alive agent.
 
-* If a keep-alive agent detects time-outs, it notifies the
+* If a keep-alive agent detects timeouts, it notifies the
   fault management entity through a callback function.
 
 The following sections provide explanation of the code aspects
-- 
2.53.0

