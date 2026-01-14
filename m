Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B00D3CC82
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C78741133;
	Wed, 14 Jan 2026 23:25:33 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 7FAA741132
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:31 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so2233835e9.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429531;
 x=1769034331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJiF/Iu3Kn3esW9H0oz0QY2mIYvdcOqWns+ejqCafbo=;
 b=vAj2m19Qyz/V6UvSiVgssHgrdrB7O5zjtie1VX0Tej8F6/d8qxlfRQhvVGnmYcj7dA
 LTZOgSE9DTrgYMJST6Tj7+/lz4m0Lbv9mNr9uFYj2P6V8ovXhCpmvMNE6SzKlq20nEeq
 9moyf6sQH+GEE40L0hL8D7uqEEamuK8ZJUgav9+GB/r+c6ErAzvwqOrQU6EZovy2r0BQ
 budn79qQyitBJCZNRCO2O23K5piCCP+ULVbsuLLZk8aIlTUxZC3cESUU5vdkvkhtV/Km
 qUkev9Y4AewFugdAPeUQUhVZmUUJ4GspWaA2smI5+5S0LHCj4G58AU9U39W7+0QpzuaG
 JYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429531; x=1769034331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NJiF/Iu3Kn3esW9H0oz0QY2mIYvdcOqWns+ejqCafbo=;
 b=j/WUlMYhtbNdQqLl/txq2I4T66rpLC1CkbOkDI8gQEPOKPHZo9NdRZS+deNQfrDGL6
 Mq6V0twIiC8y3OxpRi5BpLIyotNwCs3wLdV10ZsxFi2IjlFvyGZLSTUtuIjicoc6R/Ru
 SQbXSxVsNqaEeq7vL7ELzmFuMTWnTJLqXAuu4q3KjVQsuJMkOXQeVCjJCrfoClmzF/rx
 JHSBhNgPV9h0kQ2hykOEGXyNcxi//bUTNgHKdmryMz8VrS4YOdDAp+KSzWHXt1ki3TBf
 P0Y2jaJe5EIEeots408kdA1NjCWp+xyjNq6bLXHomNBT2sUhL9thOFOFl79LV+iYnAP9
 eNpA==
X-Gm-Message-State: AOJu0YwuAn1pdAA3smYcbLRjbvKUMvHtvRNhNub8J/NOKFmx8YVK7SDz
 0FeE5EOlseGHqoq8AZYNFPSc/7sUwJE21dY0lKDiyAfL19Et+Atn3tWl8pZffOGuUSrJFloDap/
 jEsir
X-Gm-Gg: AY/fxX7RnE5RUKTjZbuUTRP3ki45Hs11VQyikI/1aa/ZewP320JVrAsiX8kF6cx41Xv
 sTGZjnt8nynaIgaKr2e+kEdUHbTApNzGhVRBcw+o4kY/pVZzcP48thdyQsZPWjDnZCFy71tetbC
 pWdEZECBkzCNCZ5rbfVsVc483BqN6t1Ii43v3lpE/56NNK1IF6JBPQR7haJ+0mYfSwakO5+eSVG
 0XWuDTUrSWhZjXmLtCmXpQBczzGn5jk3NLaAzAPv1rsgrhUStmdxwdnd/fmVJUSIFQ8fIu4PQJ2
 bpxuwHgQRt4UWVd51L9/DiKXp4ufHNUTvwDkwE2rE3cTSiBMZb+JViiRL0GoUEuORtwBwskVcIF
 zsowgeObcRgbsCH1y7tL4mVyQ9nS6czl89NcrMBAJVlRkgp+INF0VA4LiP99knF8gy+kcshG2QK
 jcUUnKc3+9oZ3PwON1HzBRYM+mvIee2a5NWndkgTK0hLZDgDLv2g==
X-Received: by 2002:a05:600c:4e55:b0:47a:829a:ebb with SMTP id
 5b1f17b1804b1-47ee33948c6mr47131775e9.19.1768429531005; 
 Wed, 14 Jan 2026 14:25:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 16/29] doc/guides: improve DMA sample app guide
Date: Wed, 14 Jan 2026 14:21:57 -0800
Message-ID: <20260114222458.87119-17-stephen@networkplumber.org>
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

Improve the DMA sample application documentation:
- use Tx/Rx instead of TX/RX per DPDK style
- use "software" and "hardware" instead of SW/HW abbreviations
- add missing articles and fix punctuation
- use consistent option formatting with leading dash
- fix grammatical errors throughout

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/dma.rst | 104 +++++++++++++++----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/doc/guides/sample_app_ug/dma.rst b/doc/guides/sample_app_ug/dma.rst
index 9605996c6c..d59af45e7c 100644
--- a/doc/guides/sample_app_ug/dma.rst
+++ b/doc/guides/sample_app_ug/dma.rst
@@ -15,14 +15,14 @@ copy application.
 
 Also, while forwarding, the MAC addresses are affected as follows:
 
-*   The source MAC address is replaced by the TX port MAC address
+*   The source MAC address is replaced by the Tx port MAC address
 
-*   The destination MAC address is replaced by  02:00:00:00:00:TX_PORT_ID
+*   The destination MAC address is replaced by 02:00:00:00:00:TX_PORT_ID
 
-This application can be used to compare performance of using software packet
+This application can be used to compare the performance of using software packet
 copy with copy done using a DMA device for different sizes of packets.
-The example will print out statistics each second. The stats shows
-received/send packets and packets dropped or failed to copy.
+The example prints out statistics each second. The stats show
+received/sent packets and packets dropped or failed to copy.
 
 Compiling the Application
 -------------------------
@@ -36,7 +36,7 @@ Running the Application
 -----------------------
 
 In order to run the hardware copy application, the copying device
-needs to be bound to user-space IO driver.
+needs to be bound to a user-space I/O driver.
 
 Refer to the :doc:`../prog_guide/dmadev` for information on using the library.
 
@@ -49,25 +49,25 @@ The application requires a number of command line options:
 
 where,
 
-*   p MASK: A hexadecimal bitmask of the ports to configure (default is all)
+*   -p MASK: A hexadecimal bitmask of the ports to configure (default is all)
 
-*   q NQ: Number of Rx queues used per port equivalent to DMA channels
+*   -q NQ: Number of Rx queues used per port equivalent to DMA channels
     per port (default is 1)
 
-*   c CT: Performed packet copy type: software (sw) or hardware using
+*   -c CT: Performed packet copy type: software (sw) or hardware using
     DMA (hw) (default is hw)
 
-*   s RS: Size of dmadev descriptor ring for hardware copy mode or rte_ring for
+*   -s RS: Size of DMAdev descriptor ring for hardware copy mode or rte_ring for
     software copy mode (default is 2048)
 
 *   --[no-]mac-updating: Whether MAC address of packets should be changed
     or not (default is mac-updating)
 
-*   b BS: set the DMA batch size
+*   -b BS: Set the DMA batch size
 
-*   f FS: set the max frame size
+*   -f FS: Set the max frame size
 
-*   i SI: set the interval, in second, between statistics prints (default is 1)
+*   -i SI: Set the interval, in seconds, between statistics prints (default is 1)
 
 The application can be launched in various configurations depending on the
 provided parameters. The app can use up to 2 lcores: one of them receives
@@ -75,22 +75,22 @@ incoming traffic and makes a copy of each packet. The second lcore then
 updates the MAC address and sends the copy. If one lcore per port is used,
 both operations are done sequentially. For each configuration, an additional
 lcore is needed since the main lcore does not handle traffic but is
-responsible for configuration, statistics printing and safe shutdown of
+responsible for configuration, statistics printing, and safe shutdown of
 all ports and devices.
 
 The application can use a maximum of 8 ports.
 
 To run the application in a Linux environment with 3 lcores (the main lcore,
-plus two forwarding cores), a single port (port 0), software copying and MAC
-updating issue the command:
+plus two forwarding cores), a single port (port 0), software copying, and MAC
+updating, issue the command:
 
 .. code-block:: console
 
     $ ./<build_dir>/examples/dpdk-dma -l 0-2 -n 2 -- -p 0x1 --mac-updating -c sw
 
 To run the application in a Linux environment with 2 lcores (the main lcore,
-plus one forwarding core), 2 ports (ports 0 and 1), hardware copying and no MAC
-updating issue the command:
+plus one forwarding core), 2 ports (ports 0 and 1), hardware copying, and no MAC
+updating, issue the command:
 
 .. code-block:: console
 
@@ -126,7 +126,7 @@ function. The value returned is the number of parsed arguments:
     :dedent: 1
 
 
-The ``main()`` also allocates a mempool to hold the mbufs (Message Buffers)
+The ``main()`` function also allocates a mempool to hold the mbufs (Message Buffers)
 used by the application:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -146,10 +146,10 @@ The ``main()`` function also initializes the ports:
     :end-before: >8 End of initializing each port.
     :dedent: 1
 
-Each port is configured using ``port_init()`` function. The Ethernet
+Each port is configured using the ``port_init()`` function. The Ethernet
 ports are configured with local settings using the ``rte_eth_dev_configure()``
-function and the ``port_conf`` struct. The RSS is enabled so that
-multiple Rx queues could be used for packet receiving and copying by
+function and the ``port_conf`` struct. RSS is enabled so that
+multiple Rx queues can be used for packet receiving and copying by
 multiple DMA channels per port:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -159,7 +159,7 @@ multiple DMA channels per port:
     :dedent: 1
 
 For this example, the ports are set up with the number of Rx queues provided
-with -q option and 1 Tx queue using the ``rte_eth_rx_queue_setup()``
+with the -q option and 1 Tx queue using the ``rte_eth_rx_queue_setup()``
 and ``rte_eth_tx_queue_setup()`` functions.
 
 The Ethernet port is then started:
@@ -188,8 +188,8 @@ After that, each port application assigns resources needed.
     :end-before: >8 End of assigning each port resources.
     :dedent: 1
 
-Ring structures are assigned for exchanging packets between lcores for both SW
-and HW copy modes.
+Ring structures are assigned for exchanging packets between lcores for both software
+and hardware copy modes.
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
     :language: c
@@ -198,7 +198,7 @@ and HW copy modes.
     :dedent: 0
 
 
-When using hardware copy each Rx queue of the port is assigned a DMA device
+When using hardware copy, each Rx queue of the port is assigned a DMA device
 (``assign_dmadevs()``) using DMAdev library API functions:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -210,8 +210,8 @@ When using hardware copy each Rx queue of the port is assigned a DMA device
 
 The initialization of hardware device is done by ``rte_dma_configure()`` and
 ``rte_dma_vchan_setup()`` functions using the ``rte_dma_conf`` and
-``rte_dma_vchan_conf`` structs. After configuration the device is started
-using ``rte_dma_start()`` function. Each of the above operations is done in
+``rte_dma_vchan_conf`` structs. After configuration, the device is started
+using the ``rte_dma_start()`` function. Each of the above operations is done in
 ``configure_dmadev_queue()``.
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -225,16 +225,16 @@ statistics is allocated.
 
 Finally, the ``main()`` function starts all packet handling lcores and starts
 printing stats in a loop on the main lcore. The application can be
-interrupted and closed using ``Ctrl-C``. The main lcore waits for
-all worker lcores to finish, deallocates resources and exits.
+interrupted and closed using ``Ctrl+C``. The main lcore waits for
+all worker lcores to finish, deallocates resources, and exits.
 
-The processing lcores launching function are described below.
+The processing lcore launching functions are described below.
 
 The Lcores Launching Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-As described above, ``main()`` function invokes ``start_forwarding_cores()``
-function in order to start processing for each lcore:
+As described above, the ``main()`` function invokes ``start_forwarding_cores()``
+in order to start processing for each lcore:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
     :language: c
@@ -243,8 +243,8 @@ function in order to start processing for each lcore:
     :dedent: 0
 
 The function launches Rx/Tx processing functions on configured lcores
-using ``rte_eal_remote_launch()``. The configured ports, their number
-and number of assigned lcores are stored in user-defined
+using ``rte_eal_remote_launch()``. The configured ports, their number,
+and number of assigned lcores are stored in the user-defined
 ``rxtx_transmission_config`` struct:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -253,7 +253,7 @@ and number of assigned lcores are stored in user-defined
     :end-before: >8 End of configuration of ports and number of assigned lcores.
     :dedent: 0
 
-The structure is initialized in 'main()' function with the values
+The structure is initialized in the ``main()`` function with the values
 corresponding to ports and lcores configuration provided by the user.
 
 The Lcores Processing Functions
@@ -261,9 +261,9 @@ The Lcores Processing Functions
 
 For receiving packets on each port, the ``dma_rx_port()`` function is used.
 The function receives packets on each configured Rx queue. Depending on the
-mode the user chose, it will enqueue packets to DMA channels and
-then invoke copy process (hardware copy), or perform software copy of each
-packet using ``pktmbuf_sw_copy()`` function and enqueue them to an rte_ring:
+mode the user chose, it either enqueues packets to DMA channels and
+then invokes the copy process (hardware copy), or performs software copy of each
+packet using the ``pktmbuf_sw_copy()`` function and enqueues them to an rte_ring:
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
     :language: c
@@ -271,13 +271,13 @@ packet using ``pktmbuf_sw_copy()`` function and enqueue them to an rte_ring:
     :end-before: >8 End of receive packets on one port and enqueue to dmadev or rte_ring.
     :dedent: 0
 
-The packets are received in burst mode using ``rte_eth_rx_burst()``
-function. When using hardware copy mode the packets are enqueued in the
-copying device's buffer using ``dma_enqueue_packets()`` which calls
+The packets are received in burst mode using the ``rte_eth_rx_burst()``
+function. When using hardware copy mode, the packets are enqueued in the
+copying device's buffer using ``dma_enqueue_packets()``, which calls
 ``rte_dma_copy()``. When all received packets are in the
 buffer, the copy operations are started by calling ``rte_dma_submit()``.
-Function ``rte_dma_copy()`` operates on physical address of
-the packet. Structure ``rte_mbuf`` contains only physical address to
+The ``rte_dma_copy()`` function operates on the physical address of
+the packet. The ``rte_mbuf`` structure contains only the physical address to the
 start of the data buffer (``buf_iova``). Thus, the ``rte_pktmbuf_iova()`` API is
 used to get the address of the start of the data within the mbuf.
 
@@ -289,12 +289,12 @@ used to get the address of the start of the data within the mbuf.
 
 
 Once the copies have been completed (this includes gathering the completions in
-HW copy mode), the copied packets are enqueued to the ``rx_to_tx_ring``, which
+hardware copy mode), the copied packets are enqueued to the ``rx_to_tx_ring``, which
 is used to pass the packets to the Tx function.
 
-All completed copies are processed by ``dma_tx_port()`` function. This function
+All completed copies are processed by the ``dma_tx_port()`` function. This function
 dequeues copied packets from the ``rx_to_tx_ring``. Then, each packet MAC address is changed
-if it was enabled. After that, copies are sent in burst mode using ``rte_eth_tx_burst()``.
+if enabled. After that, copies are sent in burst mode using ``rte_eth_tx_burst()``.
 
 
 .. literalinclude:: ../../../examples/dma/dmafwd.c
@@ -304,9 +304,9 @@ if it was enabled. After that, copies are sent in burst mode using ``rte_eth_tx_
     :dedent: 0
 
 The Packet Copying Functions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-In order to perform SW packet copy, there are user-defined functions to the first copy
+In order to perform software packet copy, there are user-defined functions to first copy
 the packet metadata (``pktmbuf_metadata_copy()``) and then the packet data
 (``pktmbuf_sw_copy()``):
 
@@ -316,8 +316,8 @@ the packet metadata (``pktmbuf_metadata_copy()``) and then the packet data
     :end-before: >8 End of perform packet copy there is a user-defined function.
     :dedent: 0
 
-The metadata in this example is copied from ``rx_descriptor_fields1`` marker of
-``rte_mbuf`` struct up to ``buf_len`` member.
+The metadata in this example is copied from the ``rx_descriptor_fields1`` marker of
+the ``rte_mbuf`` struct up to the ``buf_len`` member.
 
 In order to understand why software packet copying is done as shown
-above, please refer to the :doc:`../prog_guide/mbuf_lib`.
+above, refer to the :doc:`../prog_guide/mbuf_lib`.
-- 
2.51.0

