Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB5CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 21:22:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC8DC433CA;
	Thu, 11 Jun 2026 23:21:30 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 40F71433C3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 23:21:28 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-307263ad0cbso583533eec.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 14:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781212887;
 x=1781817687; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cjt6R+DtLGNXRX3OyouVBfffvJQ/x/1K/38OpNVSNI=;
 b=FZcu7bGzylD3AR7XMj646jTM/0/vDSvZURHrwUeY8OiHmIKe7r/07oYxljOB+h7epg
 Mx/vFb5LbroMykIfZPNqkY9xc70UXjWdZYihMwbA+Da7R91C5OYrbbkJL51cmUvHF4pb
 a0wnbVqWlg99UX7qp68r40UH666Xn6i4jFGh/CN1wtm5UIxrLEpltdPUwAHEAzh1rOZ/
 eWgMgXdROO+qt9oatO06uvqXz1aa+M/hvznZgq4bwErivIEozNTEGgT8hYIs0m3sosFI
 qVh/rJZmJMpKXGOENH69vGSwFQJNT8OKPtXiv0bLKAqT53JvetsLS2NCa3RyBmVi6C69
 M3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212887; x=1781817687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Cjt6R+DtLGNXRX3OyouVBfffvJQ/x/1K/38OpNVSNI=;
 b=jdMLdkxR+GBjG62Ojk/bgwULRDV7cIIhWT4TgWZAQJ4y4Zpo0JKVH5TyEORcHoxu4F
 iBp5zPl5m8YEnR9wfoRTfm4HiJTjL8rtntXwGq7hcD+IArSDl935cHwJh3uAaSsqa5+1
 xtszj/3YPEVLuS0pTJfWNfRDopWHBdUnQ0K7YANQK3yk7w8aWabMFB3V0loa/BWbcxLj
 Q+DrWrAIZEzgy73mcJA5wj9hRnWl6pDFv61AMPxcs9advFXRtm3wkd9adwfb83s8bKVg
 Qup/lN5TUSBQ13L9TPyCoY4EAB4wWxp1DoPYBZZufWNgkjejTXBkokrFre3WAY5I+kZH
 vxow==
X-Gm-Message-State: AOJu0YyXsGQIVr4RBL4a6ad1b+RRan7gWJNVHqXDIpmTimQcNb0EO57l
 FKDWl4/gqr2jtZoTr7ej7q1CApwiP12sRS/Uruj5CgT5HcttZuUhCqzyV7NbV/aI0OixFC5zpZ2
 wOjKV
X-Gm-Gg: Acq92OHmd29J7S34dwt1l9gTUyEv4Y6ON9hl1VOzjzSADTsCZnSCjAFKZXY5JzJQTF4
 coSa5zUU2hVC4b9qGGQQUeEDKTM7xYXpAWuJgaXHiC0NGo1EGtHOWQ0YQht/ksVNm9zj4UQ/Kg9
 ZAyH7Hpxw0JL/GC+izj9lDbZbryxsFfkg5gndQyXNFlj5qUqUGiCBKcWXkGZYASh/vI7jT8IggE
 z1JXIvvtrmBZrikgyymTQJN9zl3fIzGSe2uhB9q2ZDbW/H6Z6G05P8dv8ofzwGhCOHtSSdHtAE/
 mShNKm+wuRTiwxUZN7ntzmZ0PxAjq/B8TJTPxyrBOmMV2mB3gAjPzBJN+HeA4855KSO7Mumlv6w
 r6sS+2P2c6xE33dsdD7vmrNKXWsp0cqDA+DB1gIElupiALbhckoybuHJmyt8X7ZE9d9yG5eNKiE
 V0BeE0d/2Tqu6MupKtolH7vCtKeTsRxoBaekLCjoRofJicKC4JhPFmpd6eEJ/OmA==
X-Received: by 2002:a05:7300:7305:b0:2d9:5cd9:b8ff with SMTP id
 5a478bee46e88-3081ff4b302mr47249eec.6.1781212887131; 
 Thu, 11 Jun 2026 14:21:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm546238eec.28.2026.06.11.14.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:21:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 05/15] doc: improve clarity and consistency in DMA sample app
 guide
Date: Thu, 11 Jun 2026 14:18:44 -0700
Message-ID: <20260611212119.1026721-6-stephen@networkplumber.org>
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

Enhanced the DMA sample application documentation:
- Simplified MAC address modification description using bullet points
- Improved grammar and readability throughout
- Standardized terminology (DMAdev, Tx/Rx port formatting)
- Fixed article usage and clarified technical explanations
- Enhanced sentence structure for better flow
- Corrected minor grammatical issues and typos

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/dma.rst | 60 +++++++++++++++-----------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/doc/guides/sample_app_ug/dma.rst b/doc/guides/sample_app_ug/dma.rst
index 9605996c6c..484fe27d92 100644
--- a/doc/guides/sample_app_ug/dma.rst
+++ b/doc/guides/sample_app_ug/dma.rst
@@ -13,16 +13,15 @@ This sample is intended as a demonstration of the basic components of a DPDK
 forwarding application and an example of how to use the DMAdev API to make a packet
 copy application.
 
-Also, while forwarding, the MAC addresses are affected as follows:
+While forwarding, the application modifies MAC addresses:
 
-*   The source MAC address is replaced by the TX port MAC address
+*   Source MAC address: replaced with the Tx port MAC address
+*   Destination MAC address: replaced with ``02:00:00:00:00:TX_PORT_ID``
 
-*   The destination MAC address is replaced by  02:00:00:00:00:TX_PORT_ID
-
-This application can be used to compare performance of using software packet
-copy with copy done using a DMA device for different sizes of packets.
-The example will print out statistics each second. The stats shows
-received/send packets and packets dropped or failed to copy.
+This application can be used to compare the performance of using software packet
+copy versus DMA device copy for different packet sizes.
+The application prints statistics at a configurable interval.
+The statistics show received/sent packets and packets dropped or failed to copy.
 
 Compiling the Application
 -------------------------
@@ -35,7 +34,7 @@ The application is located in the ``dma`` sub-directory.
 Running the Application
 -----------------------
 
-In order to run the hardware copy application, the copying device
+To run the hardware copy application, the copying device
 needs to be bound to user-space IO driver.
 
 Refer to the :doc:`../prog_guide/dmadev` for information on using the library.
@@ -54,10 +53,10 @@ where,
 *   q NQ: Number of Rx queues used per port equivalent to DMA channels
     per port (default is 1)
 
-*   c CT: Performed packet copy type: software (sw) or hardware using
+*   c CT: Packet copy type: software (``sw``) or hardware using
     DMA (hw) (default is hw)
 
-*   s RS: Size of dmadev descriptor ring for hardware copy mode or rte_ring for
+*   s RS: Size of DMAdev descriptor ring for hardware copy mode or rte_ring for
     software copy mode (default is 2048)
 
 *   --[no-]mac-updating: Whether MAC address of packets should be changed
@@ -71,9 +70,9 @@ where,
 
 The application can be launched in various configurations depending on the
 provided parameters. The app can use up to 2 lcores: one of them receives
-incoming traffic and makes a copy of each packet. The second lcore then
+incoming traffic and makes a copy of each packet, and the second lcore
 updates the MAC address and sends the copy. If one lcore per port is used,
-both operations are done sequentially. For each configuration, an additional
+both operations are performed sequentially. For each configuration, an additional
 lcore is needed since the main lcore does not handle traffic but is
 responsible for configuration, statistics printing and safe shutdown of
 all ports and devices.
@@ -89,7 +88,7 @@ updating issue the command:
     $ ./<build_dir>/examples/dpdk-dma -l 0-2 -n 2 -- -p 0x1 --mac-updating -c sw
 
 To run the application in a Linux environment with 2 lcores (the main lcore,
-plus one forwarding core), 2 ports (ports 0 and 1), hardware copying and no MAC
+plus one forwarding core), 2 ports (ports 0 and 1), hardware copying, and no MAC
 updating issue the command:
 
 .. code-block:: console
@@ -146,7 +145,7 @@ The ``main()`` function also initializes the ports:
     :end-before: >8 End of initializing each port.
     :dedent: 1
 
-Each port is configured using ``port_init()`` function. The Ethernet
+Each port is configured using the ``port_init()`` function. The Ethernet
 ports are configured with local settings using the ``rte_eth_dev_configure()``
 function and the ``port_conf`` struct. The RSS is enabled so that
 multiple Rx queues could be used for packet receiving and copying by
@@ -198,7 +197,7 @@ and HW copy modes.
     :dedent: 0
 
 
-When using hardware copy each Rx queue of the port is assigned a DMA device
+When using hardware copy, each Rx queue of the port is assigned a DMA device
 (``assign_dmadevs()``) using DMAdev library API functions:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -220,7 +219,7 @@ using ``rte_dma_start()`` function. Each of the above operations is done in
     :end-before: >8 End of configuration of device.
     :dedent: 0
 
-If initialization is successful, memory for hardware device
+If initialization is successful, memory for the hardware device
 statistics is allocated.
 
 Finally, the ``main()`` function starts all packet handling lcores and starts
@@ -228,7 +227,7 @@ printing stats in a loop on the main lcore. The application can be
 interrupted and closed using ``Ctrl-C``. The main lcore waits for
 all worker lcores to finish, deallocates resources and exits.
 
-The processing lcores launching function are described below.
+The processing lcore launching functions are described below.
 
 The Lcores Launching Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -259,10 +258,10 @@ corresponding to ports and lcores configuration provided by the user.
 The Lcores Processing Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-For receiving packets on each port, the ``dma_rx_port()`` function is used.
-The function receives packets on each configured Rx queue. Depending on the
+The ``dma_rx_port()`` function receives packets on each port.
+It receives packets on each configured Rx queue. Depending on the
 mode the user chose, it will enqueue packets to DMA channels and
-then invoke copy process (hardware copy), or perform software copy of each
+then invoke the copy process (hardware copy), or perform software copy of each
 packet using ``pktmbuf_sw_copy()`` function and enqueue them to an rte_ring:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -271,13 +270,13 @@ packet using ``pktmbuf_sw_copy()`` function and enqueue them to an rte_ring:
     :end-before: >8 End of receive packets on one port and enqueue to dmadev or rte_ring.
     :dedent: 0
 
-The packets are received in burst mode using ``rte_eth_rx_burst()``
-function. When using hardware copy mode the packets are enqueued in the
-copying device's buffer using ``dma_enqueue_packets()`` which calls
+Packets are received in burst mode using the ``rte_eth_rx_burst()``
+function. When using hardware copy mode, packets are enqueued in the
+DMA device buffer using ``dma_enqueue_packets()``, which calls
 ``rte_dma_copy()``. When all received packets are in the
 buffer, the copy operations are started by calling ``rte_dma_submit()``.
-Function ``rte_dma_copy()`` operates on physical address of
-the packet. Structure ``rte_mbuf`` contains only physical address to
+The ``rte_dma_copy()`` function operates on the physical address of
+the packet. The ``rte_mbuf`` structure contains only the physical address to the
 start of the data buffer (``buf_iova``). Thus, the ``rte_pktmbuf_iova()`` API is
 used to get the address of the start of the data within the mbuf.
 
@@ -287,12 +286,11 @@ used to get the address of the start of the data within the mbuf.
     :end-before: >8 End of receive packets on one port and enqueue to dmadev or rte_ring.
     :dedent: 0
 
-
-Once the copies have been completed (this includes gathering the completions in
+Once the copies have been completed (which includes gathering the completions in
 HW copy mode), the copied packets are enqueued to the ``rx_to_tx_ring``, which
 is used to pass the packets to the Tx function.
 
-All completed copies are processed by ``dma_tx_port()`` function. This function
+All completed copies are processed by the ``dma_tx_port()`` function. This function
 dequeues copied packets from the ``rx_to_tx_ring``. Then, each packet MAC address is changed
 if it was enabled. After that, copies are sent in burst mode using ``rte_eth_tx_burst()``.
 
@@ -306,7 +304,7 @@ if it was enabled. After that, copies are sent in burst mode using ``rte_eth_tx_
 The Packet Copying Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-In order to perform SW packet copy, there are user-defined functions to the first copy
+To perform software packet copy, the user-defined functions first copy
 the packet metadata (``pktmbuf_metadata_copy()``) and then the packet data
 (``pktmbuf_sw_copy()``):
 
@@ -319,5 +317,5 @@ the packet metadata (``pktmbuf_metadata_copy()``) and then the packet data
 The metadata in this example is copied from ``rx_descriptor_fields1`` marker of
 ``rte_mbuf`` struct up to ``buf_len`` member.
 
-In order to understand why software packet copying is done as shown
+To understand why software packet copying is performed as shown
 above, please refer to the :doc:`../prog_guide/mbuf_lib`.
-- 
2.53.0

