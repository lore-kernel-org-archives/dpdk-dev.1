Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3FD3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EA5B427A7;
	Wed, 14 Jan 2026 23:25:56 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 6D1FC4279A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:53 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso2679875e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429553;
 x=1769034353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhnP3nwX/Y2IPFjYXQEbJqdoHjUcteFvWRfYI4Absgk=;
 b=Gftn0YRxT06IDGVt4FEkUxlHWjYi09exaQyWCALOgNHSmh1u2+PVDlaXqHVnyQMS6u
 ThEyol/GN0qSZzTpHSzTJCx2cUnbsexmPWff1tQgZCIurAaTDW/pHpNM8Acq/NZov7uf
 P5ceV/bbr0eN8lU/1nh3+CSsiZV4+rd7Vj4W1wu0YDftPiBsRsWQWVE1/hINX6gK39eR
 0yUvmigQrUp8HEdkhylhug64+vByDBPxDhnsbZKdCKxXWB19w8LgYujimgWF9ox4xVSc
 1bzaySxiA8bQPj2XUJXU2Za90+cH8EsDgTHOwxRIy7g0AOFX3/339YErUn17a0Vi8JNQ
 yr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429553; x=1769034353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lhnP3nwX/Y2IPFjYXQEbJqdoHjUcteFvWRfYI4Absgk=;
 b=ZdmzFhaHbrq5l/nMzklF8yjy/Fjd+z3s7b9HEUgAfYsuy7b+BtatZN7MVbh11i2wks
 8/x7j1QIi/2PKVkiBzzNiNm1McY9f3z/D55UdGDKgufgc1HMc04ogaZ9LfDzl8oVWkKh
 EzIkOqYrJ/HJXAdXfFWdBY2s0SGyfkrD2kqAOlP0scIcCkYjen/0FJQtNTwiwXLUiGVo
 I0areJF7JtORzoal8OEJxF8kGdJ9iUeZ9LltmdxPEDZc5ZTVM2PmfBuaxTaW0ykJcmrh
 ZNqx6c9r2u5f73aNwAMnt6D9URI73h+yRuaU+rmakECQFDJ7rukUE6sVogn9K6lF5pCo
 UWZw==
X-Gm-Message-State: AOJu0YxGigL3NIITtGwgENZa6F5dCED0A+NSn3OkfHTKMnf18AUW2p1n
 Wlu7uVeKAtlSRLPhM714J9hWpQ6Dg7FmoF2Hgm4Hj06h0Mv18IB8vhA6zGCu6a/DUeLRPhbtGCY
 yh3D7
X-Gm-Gg: AY/fxX4nenxopAUvArIBgFI/K/F02Er0khKyxrqndHHyVfZ7Nhq9XTgL1CnLt8rqS1/
 j35nTwh29wa+PqR3epQ3BM2Z5OxdL1kBTrbqtjbTfsU7V7VjDqTa9k1/zFFw5ZlbIAM2oXz2ymx
 SXK4lcc5kxMEfexCnhRRrFLjpgpZlK3J2I96CAlQTwPr4Bh6149ArbfhE6Y5BFsIpQ4JwDsgBBx
 1KOxPtSsSWkwyFgEOapCW8YiwKL+PRrxH656xwe2Y+XzhAyt1iTbBx7lEm1nXm6Bqqt/SsdpUiG
 /VqfuHFPDjsO1fgGpkevaL6WPrTQ1d3Je9pMeGaSc7Bgq3qgIsTGdcAwahEq3VbHPr+FBheuCef
 ZTvLg48liUaovvHP39v/C5FgcyXk6lWmN3h/0/2HCZA4Rincde2Uz793PVA8D2oACaJNOgnNFmW
 WjBORFry1xXY7+3rfbjqOU8iotcz9xDyZOf4NHEJLIGdiDMQW3ow==
X-Received: by 2002:a05:600c:674a:b0:477:b734:8c52 with SMTP id
 5b1f17b1804b1-47ee47ca2d4mr41086235e9.14.1768429552907; 
 Wed, 14 Jan 2026 14:25:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 28/29] fix ipsec gw
Date: Wed, 14 Jan 2026 14:22:09 -0800
Message-ID: <20260114222458.87119-29-stephen@networkplumber.org>
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

---
 doc/guides/sample_app_ug/ipsec_secgw.rst | 183 ++++++++++++-----------
 1 file changed, 94 insertions(+), 89 deletions(-)

diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index ff08343061..1ce2353aee 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -11,30 +11,35 @@ application using DPDK cryptodev framework.
 Overview
 --------
 
-This application demonstrates the implementation of a Security Gateway
-(not fully IPsec-compliant; see the Constraints section) using DPDK, based
-on RFC4301, RFC4303, RFC3602, and RFC2404.
+The application demonstrates the implementation of a Security Gateway
+(not IPsec compliant, see the Constraints section below) using DPDK based on RFC4301,
+RFC4303, RFC3602 and RFC2404.
 
-Currently, DPDK does not support Internet Key Exchange (IKE), so Security Policies
-(SP) and Security Associations (SA) must be configured manually. SPs are implemented
-as ACL rules, SAs are stored in a table, and routing is handled using LPM.
+Internet Key Exchange (IKE) is not implemented, so only manual setting of
+Security Policies and Security Associations is supported.
 
-The application classifies ports as *Protected* or *Unprotected*, with traffic
-received on Unprotected ports considered Inbound and traffic on Protected ports
-considered Outbound.
+The Security Policies (SP) are implemented as ACL rules, the Security
+Associations (SA) are stored in a table and the routing is implemented
+using LPM.
 
-It supports full IPsec protocol offload to hardware (via crypto accelerators or
-Ethernet devices) as well as inline IPsec processing by supported Ethernet
-devices during transmission. These modes can be configured during SA creation.
+The application classifies the ports as *Protected* and *Unprotected*.
+Thus, traffic received on an Unprotected or Protected port is consider
+Inbound or Outbound respectively.
 
-For full protocol offload, the hardware processes ESP and outer IP headers,
-so the application does not need to add or remove them during Outbound or
-Inbound processing.
+The application also supports complete IPsec protocol offload to hardware
+(Look aside crypto accelerator or using ethernet device). It also support
+inline ipsec processing by the supported ethernet device during transmission.
+These modes can be selected during the SA creation configuration.
 
-In the inline offload mode for Outbound traffic, the application skips the
-LPM lookup for routing, as the SA specifies the port for forwarding. Security
-parameters are configured only on the specified port, and sending packets
-through other ports may result in unencrypted packets being transmitted.
+In case of complete protocol offload, the processing of headers(ESP and outer
+IP header) is done by the hardware and the application does not need to
+add/remove them during outbound/inbound processing.
+
+For inline offloaded outbound traffic, the application will not do the LPM
+lookup for routing, as the port on which the packet has to be forwarded will be
+part of the SA. Security parameters will be configured on that port only, and
+sending the packet on other ports could result in unencrypted packets being
+sent out.
 
 The Path for IPsec Inbound traffic is:
 
@@ -59,70 +64,70 @@ The Path for the IPsec Outbound traffic is:
 
 The application supports two modes of operation: poll mode and event mode.
 
-* In the poll mode, a core receives packets from statically configured list
-  of eth ports and eth ports' queues.
-
-* In event mode, a core processes packets as events. After processing, the
-core submits the packets back to an event device, enabling multicore scaling
-and hardware-assisted scheduling by leveraging the capabilities of the event
-device. The event mode configuration is predefined, where all packets arriving
-at a specific Ethernet port are directed to the same event queue. All event
-queues are mapped to all event ports, allowing any core to receive traffic
-from any port. Since event devices can have varying capabilities, worker threads are designed
-differently to optimize performance. For instance, if an event device and Ethernet
-device pair includes a Tx internal port, the application can use `rte_event_eth_tx_adapter_enqueue`
-instead of the standard `rte_event_enqueue_burst`. A thread optimized for a device
-pair with an internal port may not work effectively with another pair. The infrastructure
-for event mode is designed to support multiple worker threads
-while maximizing the performance of each type of event device without impacting
-existing paths or use cases. The worker thread selection depends on the operating
-conditions and the capabilities of the underlying devices.
-
-  **Currently the application provides non-burst, internal port worker threads.**
-  It also provides infrastructure for non-internal port,
-  however does not define any worker threads.
-
-  Event mode also supports event vectorization. The event devices, ethernet device
-  pairs which support the capability ``RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR`` can
-  aggregate packets based on flow characteristics and generate a ``rte_event``
-  containing ``rte_event_vector``.
-  The aggregation size and timeout can be given using command line options vector-size
-  (default vector-size is 16) and vector-tmo (default vector-tmo is 102400ns).
-  By default event vectorization is disabled and it can be enabled using event-vector
-  option.
-  For the event devices, crypto device pairs which support the capability
-  ``RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR`` vector aggregation
-  could also be enabled using event-vector option.
-
-Additionally, the event mode introduces two submodes of processing packets:
-
-* Driver submode: This submode has bare minimum changes in the application to support
-  IPsec. There are no lookups, no routing done in the application. And for inline
-  protocol use case, the worker thread resembles l2fwd worker thread as the IPsec
-  processing is done entirely in HW. This mode can be used to benchmark the raw
-  performance of the HW. The driver submode is selected with --single-sa option
-  (used also by poll mode). When --single-sa option is used in conjunction with event
-  mode then index passed to --single-sa is ignored.
-
-* App submode: This submode has all the features currently implemented with the
-  application (non librte_ipsec path). All the lookups, routing follows existing
-  methods and report numbers that can be compared against regular poll mode
-  benchmark numbers.
+*  In the poll mode a core receives packets from statically configured list
+   of eth ports and eth ports' queues.
+
+*  In the event mode a core receives packets as events. After packet processing
+   is done core submits them back as events to an event device. This enables
+   multicore scaling and HW assisted scheduling by making use of the event device
+   capabilities. The event mode configuration is predefined. All packets reaching
+   given eth port will arrive at the same event queue. All event queues are mapped
+   to all event ports. This allows all cores to receive traffic from all ports.
+   Since the underlying event device might have varying capabilities, the worker
+   threads can be drafted differently to maximize performance. For example, if an
+   event device - eth device pair has Tx internal port, then application can call
+   rte_event_eth_tx_adapter_enqueue() instead of regular rte_event_enqueue_burst().
+   So a thread which assumes that the device pair has internal port will not be the
+   right solution for another pair. The infrastructure added for the event mode aims
+   to help application to have multiple worker threads by maximizing performance from
+   every type of event device without affecting existing paths/use cases. The worker
+   to be used will be determined by the operating conditions and the underlying device
+   capabilities.
+   **Currently the application provides non-burst, internal port worker threads.**
+   It also provides infrastructure for non-internal port
+   however does not define any worker threads.
+
+   Event mode also supports event vectorization. The event devices, ethernet device
+   pairs which support the capability ``RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR`` can
+   aggregate packets based on flow characteristics and generate a ``rte_event``
+   containing ``rte_event_vector``.
+   The aggregation size and timeout can be given using command line options vector-size
+   (default vector-size is 16) and vector-tmo (default vector-tmo is 102400ns).
+   By default event vectorization is disabled and it can be enabled using event-vector
+   option.
+   For the event devices, crypto device pairs which support the capability
+   ``RTE_EVENT_CRYPTO_ADAPTER_CAP_EVENT_VECTOR`` vector aggregation
+   could also be enable using event-vector option.
+
+Additionally the event mode introduces two submodes of processing packets:
+
+*  Driver submode: This submode has bare minimum changes in the application to support
+   IPsec. There are no lookups, no routing done in the application. And for inline
+   protocol use case, the worker thread resembles l2fwd worker thread as the IPsec
+   processing is done entirely in HW. This mode can be used to benchmark the raw
+   performance of the HW. The driver submode is selected with --single-sa option
+   (used also by poll mode). When --single-sa option is used in conjunction with event
+   mode then index passed to --single-sa is ignored.
+
+*  App submode: This submode has all the features currently implemented with the
+   application (non librte_ipsec path). All the lookups, routing follows existing
+   methods and report numbers that can be compared against regular poll mode
+   benchmark numbers.
 
 Constraints
-~~~~~~~~~~~
+-----------
 
 *  No IPv6 options headers.
 *  No AH mode.
 *  Supported algorithms: AES-CBC, AES-CTR, AES-GCM, 3DES-CBC, DES-CBC,
    HMAC-SHA1, HMAC-SHA256, AES-GMAC, AES_CTR, AES_XCBC_MAC, AES_CCM,
    CHACHA20_POLY1305 and NULL.
-*  Each SA must be handled by a unique lcore (*1 RX queue per port*).
+*  Each SA must be handle by a unique lcore (*1 RX queue per port*).
 
 Compiling the Application
 -------------------------
 
-To compile the sample application, see :doc:`compiling`.
+To compile the sample application see :doc:`compiling`.
 
 The application is located in the ``ipsec-secgw`` sub-directory.
 
@@ -165,7 +170,7 @@ Where:
 
 *   ``-j FRAMESIZE``: *optional*. data buffer size (in bytes),
     in other words maximum data size for one segment.
-    Packets with length bigger than FRAMESIZE still can be received,
+    Packets with length bigger then FRAMESIZE still can be received,
     but will be segmented.
     Default value: RTE_MBUF_DEFAULT_BUF_SIZE (2176)
     Minimum value: RTE_MBUF_DEFAULT_BUF_SIZE (2176)
@@ -239,8 +244,8 @@ Where:
     Default value: 0.
 
 *   ``--mtu MTU``: MTU value (in bytes) on all attached ethernet ports.
-    Outgoing packets with length bigger than MTU will be fragmented.
-    Incoming packets with length bigger than MTU will be discarded.
+    Outgoing packets with length bigger then MTU will be fragmented.
+    Incoming packets with length bigger then MTU will be discarded.
     Default value: 1500.
 
 *   ``--frag-ttl FRAG_TTL_NS``: fragment lifetime (in nanoseconds).
@@ -255,7 +260,7 @@ Where:
      via Rx queue setup.
 
 *   ``--vector-pool-sz``: Number of buffers in vector pool.
-    By default, vector pool size depends on packet pool size
+    By default, vector pool size depeneds on packet pool size
     and size of each vector.
 
 *   ``--desc-nb NUMBER_OF_DESC``: Number of descriptors per queue pair.
@@ -372,11 +377,11 @@ For example, something like the following command line:
 
 
 Configurations
-~~~~~~~~~~~~~~
+--------------
 
 The following sections provide the syntax of configurations to initialize
 your SP, SA, Routing, Flow and Neighbour tables.
-Configurations will be specified in the configuration file to be passed to
+Configurations shall be specified in the configuration file to be passed to
 the application. The file is then parsed by the application. The successful
 parsing will result in the appropriate rules being applied to the tables
 accordingly.
@@ -385,11 +390,11 @@ accordingly.
 Configuration File Syntax
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As mentioned in the overview, the Security Policies are ACL rules.
-The application parses the rules specified in the configuration file and
+As mention in the overview, the Security Policies are ACL rules.
+The application parsers the rules specified in the configuration file and
 passes them to the ACL table, and replicates them per socket in use.
 
-The following sections contain the configuration file syntax.
+Following are the configuration file syntax.
 
 General rule syntax
 ^^^^^^^^^^^^^^^^^^^
@@ -420,7 +425,7 @@ The SP rule syntax is shown as follows:
     <proto> <sport> <dport>
 
 
-where each option means:
+where each options means:
 
 ``<ip_ver>``
 
@@ -535,7 +540,7 @@ The SA rule syntax is shown as follows:
     <mode> <src_ip> <dst_ip> <action_type> <port_id> <fallback>
     <flow-direction> <port_id> <queue_id> <udp-encap> <reassembly_en>
 
-where each option means:
+where each options means:
 
 ``<dir>``
 
@@ -628,7 +633,7 @@ where each option means:
    * *aes-192-gcm*: AES-GCM 192-bit algorithm
    * *aes-256-gcm*: AES-GCM 256-bit algorithm
 
- * Syntax: *aead_algo <your algorithm>*
+ * Syntax: *cipher_algo <your algorithm>*
 
 ``<aead_key>``
 
@@ -842,7 +847,7 @@ The Routing rule syntax is shown as follows:
     rt <ip_ver> <src_ip> <dst_ip> <port>
 
 
-where each option means:
+where each options means:
 
 ``<ip_ver>``
 
@@ -885,7 +890,7 @@ where each option means:
 
  * Syntax: *port X*
 
-Example Routing rules:
+Example SP rules:
 
 .. code-block:: console
 
@@ -907,7 +912,7 @@ The flow rule syntax is shown as follows:
     flow <mark> <eth> <ip_ver> <src_ip> <dst_ip> <port> <queue> \
          <count> <security> <set_mark>
 
-where each option means:
+where each options means:
 
 ``<mark>``
 
@@ -1034,7 +1039,7 @@ The Neighbour rule syntax is shown as follows:
     neigh <port> <dst_mac>
 
 
-where each option means:
+where each options means:
 
 ``<port>``
 
@@ -1138,7 +1143,7 @@ It then tries to perform some data transfer using the scheme described above.
 Usage
 ~~~~~
 
-In the ipsec-secgw/test directory run:
+In the ipsec-secgw/test directory run
 
 /bin/bash run_test.sh <options> <ipsec_mode>
 
@@ -1171,4 +1176,4 @@ Available options:
 *   ``-h`` Show usage.
 
 If <ipsec_mode> is specified, only tests for that mode will be invoked. For the
-list of available modes, please refer to run_test.sh.
+list of available modes please refer to run_test.sh.
-- 
2.51.0

