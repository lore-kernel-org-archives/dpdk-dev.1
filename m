Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B974D46BF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 19:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4787240A70;
	Wed, 28 Jan 2026 20:47:35 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 07C684069F
 for <dev@dpdk.org>; Wed, 28 Jan 2026 20:47:32 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so148653f8f.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769629652;
 x=1770234452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cTcl/t650GnTyT0NhhVMWppsXK1agOlU8l8XLWxMQc8=;
 b=SulZOKlAUJYxEO6vEqN4PBsJtL07rumn2lFpfRsvo9bvV18xy3ZKs5CmAwXMWrXkd0
 3u65sPBj8db1b++ZfBL0+qXR+hhKkZMJ1PQkNi/prbhI9KNmOfqBM9BPoA4Li00/+T88
 oYJ4mVGT6hWLxksM1EJ1lE35dELv0pCBkyWF1CGo/O5igTjpjh0oJ1f8tsbrN6PUbVNg
 cZui6JpvZZN+5hl9QkNh04XwQhfaBN6hUnh8Y1nBg+E556JPQjIiHTY/oCrvE6uKvJg0
 X3BvkqCPjRHbRYxXOJ+tNfQrMjVLK9Wqr8OMO5gMnKNGZ4Fq7hwvj5rznFOdU/eWk4Lv
 ObIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629652; x=1770234452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cTcl/t650GnTyT0NhhVMWppsXK1agOlU8l8XLWxMQc8=;
 b=Ljdy9eARh9mDmK+T4T3tCQ1RKzk+nJ49Nszg6YgXEwW8Jw3NCX4FE7OUSoW2XmGEMq
 xiikzEslAI0wHho0kDUuW4T7eWQfRZG6gW169i83NwkKaBzlzv0qp0PV5+0jOgsLZ/Mm
 3Qnl0emqJiRZsmk1xFGKwdyej/etuScdRGPm7N5sBngYVc/FjrI+hGyI8J3bXDfpR0io
 8IGzHlOaD1E77AO69c3LSzTnAzbwXY+fgTjOB9YgCZ58leqgM5HifdHoAt1nDoK+l3ca
 o5MYdVl8WMOdb/MXPdtHXYww+DQoFeP1iMRig4ZcYpUrxsL1fr+qosFL6J8DtDx9Xu4A
 8vew==
X-Gm-Message-State: AOJu0YyalTMBWXJYXvHMy7eLdG6I3HmTOp1PoeQvj0ndKwbyMhvrn2Tp
 Ns2Y/c6eWVU1Eb7PC9DKpBSSsM+bMpd3zOqbasz32cxmUpllZ7oES7KCsjbS0P3oGlhnZ1mN5Nx
 EVyVs
X-Gm-Gg: AZuq6aKPdhkRYzHWYZUhKeUE3qefAt8paIC2THu0+zmRAxywPwCz98gcc167gquD/bw
 IYcI7u4ITW+rHVntoIgbCn6phJdsBbb/sXe3DNTzAMDpaSGmEX+pcPcH4fiZ9KlhEQ74USC3L6D
 bFfZDuaPEC+yZ3ATrF6XY8RDUlJNTcMybA6T0rgO3mqEkyN7iWfxeg8RRySnhwohPj7j+sJsm62
 UlDxkNCyM6fOkeQvRizSjGpPRzzqKEnFZQvVoQAbI/2Sp5eputTmMLGjTfsGmRaw/qKYKUMbnDC
 YFE/3NP3ccBNLox3q/BFPHbNzkKJ0qzBE8bSsuj7Nopyx2Yedy8zSiHioD9PJLRfunm2MGWho6W
 LqQWsitAOdtWss0jJmbcF1dAG+cf50n6yOx/gBMrWzAiFEWHGDTVrga11N0Pppkq0hR/7ztkDYg
 J+zybSTlItKY4wGbTF5MWMYbDAbi6CBiayh4b5O843D2P1hKE8+A==
X-Received: by 2002:a5d:5f43:0:b0:435:8ec5:d27b with SMTP id
 ffacd0b85a97d-435dd05c937mr10350827f8f.26.1769629652218; 
 Wed, 28 Jan 2026 11:47:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354205sm9601438f8f.41.2026.01.28.11.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:47:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v2 3/8] doc: correct grammar in QoS framework guide
Date: Wed, 28 Jan 2026 11:46:02 -0800
Message-ID: <20260128194722.480862-4-stephen@networkplumber.org>
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

Add missing article "a" in phrase "As result" which should be
"As a result" in four locations including table cell descriptions.

Improve readability and correct grammatical issues:
- Correct missing word "The" in dropper description
- Add missing article in EWMA filter description
- Correct run-on sentence in traffic metering section
- Improve clarity of color aware mode explanation
- Correct inconsistent hyphenation in "run-time"

Correct various issues in the QoS framework documentation:
- Correct "an so on" to "and so on"
- Correct "weights weights" duplicate word
- Correct duplicate "the" in token bucket operations description
- Correct "Pipelevel" to "Pipe level" for consistency
- Correct "out performs" to "outperforms"
- Correct "They could made" grammar error to "They could be made"
- Correct inconsistent spacing in section references
- Update hardcoded section numbers to use proper internal references

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../prog_guide/ethdev/qos_framework.rst       | 59 ++++++++++---------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index 1144037dfa..0f61264ccc 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -189,7 +189,7 @@ The functionality of each hierarchical level is detailed in the following table.
    |   |                    |                            |     called Best Effort (BE), has 4 queues.                    |
    |   |                    |                            |                                                               |
    |   |                    |                            | #.  Queues of the lowest priority TC (BE) are serviced using  |
-   |   |                    |                            |     Weighted Round Robin (WRR) according to predefined weights|
+   |   |                    |                            |     Weighted Round Robin (WRR) according to predefined        |
    |   |                    |                            |     weights.                                                  |
    |   |                    |                            |                                                               |
    +---+--------------------+----------------------------+---------------------------------------------------------------+
@@ -368,7 +368,7 @@ The expected drop in performance is due to:
 
 #.  Need to make the queue and bitmap operations thread safe,
     which requires either using locking primitives for access serialization (for example, spinlocks/ semaphores) or
-    using atomic primitives for lockless access (for example, Test and Set, Compare And Swap, an so on).
+    using atomic primitives for lockless access (for example, Test and Set, Compare And Swap, and so on).
     The impact is much higher in the former case.
 
 #.  Ping-pong of cache lines storing the shared data structures between the cache hierarchies of the two cores
@@ -621,7 +621,7 @@ The token bucket generic parameters and operations are presented in :numref:`tab
    |   |                        | while the bucket is full are dropped.                                        |
    |   |                        |                                                                              |
    +---+------------------------+------------------------------------------------------------------------------+
-   | 3 | Credit consumption     | As result of packet scheduling, the necessary number of credits is removed   |
+   | 3 | Credit consumption     | As a result of packet scheduling, the necessary number of credits is removed |
    |   |                        | from the bucket. The packet can only be sent if enough credits are in the    |
    |   |                        | bucket to send the full packet (packet bytes and framing overhead for the    |
    |   |                        | packet).                                                                     |
@@ -681,7 +681,7 @@ where, r = port line rate (in bytes per second).
    +---+-------------------------+-----------------------------------------------------------------------------+
    | 2 | Credit update           | Credit update options:                                                      |
    |   |                         |                                                                             |
-   |   |                         | *   Every time a packet is sent for a port, update the credits of all the   |
+   |   |                         | *   Every time a packet is sent for a port, update the credits of all       |
    |   |                         |     the subports and pipes of that port. Not feasible.                      |
    |   |                         |                                                                             |
    |   |                         | *   Every time a packet is sent, update the credits for the pipe and        |
@@ -716,7 +716,7 @@ where, r = port line rate (in bytes per second).
    |   |                         | *   tb_time += n_periods * tb_period;                                       |
    |   |                         |                                                                             |
    +---+-------------------------+-----------------------------------------------------------------------------+
-   | 3 | Credit consumption      | As result of packet scheduling, the necessary number of credits is removed  |
+   | 3 | Credit consumption      | As a result of packet scheduling, the necessary number of credits is removed|
    |   |  (on packet scheduling) | from the bucket. The packet can only be sent if enough credits are in the   |
    |   |                         | bucket to send the full packet (packet bytes and framing overhead for the   |
    |   |                         | packet).                                                                    |
@@ -805,7 +805,7 @@ as described in :numref:`table_qos_10` and :numref:`table_qos_11`.
    |   |                          | }                                                                          |
    |   |                          |                                                                            |
    +---+--------------------------+----------------------------------------------------------------------------+
-   | 3 | Credit consumption       | As result of packet scheduling, the TC limit is decreased with the         |
+   | 3 | Credit consumption       | As a result of packet scheduling, the TC limit is decreased with the       |
    |   | (on packet scheduling)   | necessary number of credits. The packet can only be sent if enough credits |
    |   |                          | are currently available in the TC limit to send the full packet            |
    |   |                          | (packet bytes and framing overhead for the packet).                        |
@@ -1042,7 +1042,7 @@ The highest value for the watermark is picked as the highest rate configured for
    |     |                                 |                                                    |
    |     |                                 | }                                                  |
    |     |                                 |                                                    |
-   |     |                                 | **Pipelevel:**                                     |
+   |     |                                 | **Pipe level:**                                    |
    |     |                                 |                                                    |
    |     |                                 | if(pipe_period_id != subport_period_id)            |
    |     |                                 |                                                    |
@@ -1163,7 +1163,7 @@ Droppers
 
 The purpose of the DPDK dropper is to drop packets arriving at a packet scheduler to avoid congestion.
 The dropper supports the Proportional Integral Controller Enhanced (PIE), Random Early Detection (RED),
-Weighted Random Early Detection (WRED) and tail drop algorithms.
+Weighted Random Early Detection (WRED), and tail drop algorithms.
 :numref:`figure_blk_diag_dropper` illustrates how the dropper integrates with the scheduler.
 The DPDK currently does not support congestion management
 so the dropper provides the only method for congestion avoidance.
@@ -1175,7 +1175,7 @@ so the dropper provides the only method for congestion avoidance.
    High-level Block Diagram of the DPDK Dropper
 
 
-The dropper uses one of two congestion avoidance algorithms:
+The dropper uses one of the following congestion avoidance algorithms:
    - the Random Early Detection (RED) as documented in the reference publication.
    - the Proportional Integral Controller Enhanced (PIE) as documented in RFC8033 publication.
 
@@ -1196,7 +1196,7 @@ In the case of severe congestion, the dropper resorts to tail drop.
 This occurs when a packet queue has reached maximum capacity and cannot store any more packets.
 In this situation, all arriving packets are dropped.
 
-The flow through the dropper is illustrated in :numref:`figure_flow_tru_dropper`.
+The flow through the dropper is illustrated in :numref:`figure_flow_tru_dropper`,
 The RED/WRED/PIE algorithm is exercised first and tail drop second.
 
 .. _figure_flow_tru_dropper:
@@ -1205,7 +1205,7 @@ The RED/WRED/PIE algorithm is exercised first and tail drop second.
 
    Flow Through the Dropper
 
-The PIE algorithm periodically updates the drop probability based on the latency samples.
+The PIE algorithm periodically updates the drop probability based on latency samples.
 The current latency sample but also analyze whether the latency is trending up or down.
 This is the classical Proportional Integral (PI) controller method, which is known for
 eliminating steady state errors.
@@ -1226,7 +1226,7 @@ The use cases supported by the dropper are:
 
 *   *    Mark empty (record the time at which a packet queue becomes empty)
 
-The configuration use case is explained in :ref:`Section2.23.3.1 <Configuration>`,
+The configuration use case is explained in :ref:`Section 2.23.3.1 <Configuration>`,
 the enqueue operation is explained in  :ref:`Section 2.23.3.2 <Enqueue_Operation>`
 and the mark empty operation is explained in :ref:`Section 2.23.3.3 <Queue_Empty_Operation>`.
 
@@ -1262,7 +1262,7 @@ The meaning of these parameters is explained in more detail in the following sec
 The format of these parameters as specified to the dropper module API
 corresponds to the format used by Cisco* in their RED implementation.
 The minimum and maximum threshold parameters are specified to the dropper module in terms of number of packets.
-The mark probability parameter is specified as an inverse value, for example,
+The mark probability parameter is specified as an inverse value; for example,
 an inverse mark probability parameter value of 10 corresponds
 to a mark probability of 1/10 (that is, 1 in 10 packets will be dropped).
 The EWMA filter weight parameter is specified as an inverse log value,
@@ -1278,7 +1278,7 @@ A PIE configuration contains the parameters given in :numref:`table_qos_16a`.
    | Parameter                | Minimum | Maximum | Default          |
    |                          |         |         |                  |
    +==========================+=========+=========+==================+
-   | Queue delay reference    | 1       | uint16  | 15               |
+   | Queue delay reference    | 1       | uint16_t| 15               |
    | Latency Target Value     |         |         |                  |
    | Unit: ms                 |         |         |                  |
    +--------------------------+---------+---------+------------------+
@@ -1286,7 +1286,7 @@ A PIE configuration contains the parameters given in :numref:`table_qos_16a`.
    | Unit: ms                 |         |         |                  |
    +--------------------------+---------+---------+------------------+
    | Tail Drop Threshold      | 1       | uint16  | 64               |
-   | Unit: bytes              |         |         |                  |
+   | Unit: number of packets  |         |         |                  |
    +--------------------------+---------+---------+------------------+
    | Period to calculate      | 1       | uint16  | 15               |
    | drop probability         |         |         |                  |
@@ -1294,8 +1294,9 @@ A PIE configuration contains the parameters given in :numref:`table_qos_16a`.
    +--------------------------+---------+---------+------------------+
 
 The meaning of these parameters is explained in more detail in the next sections.
-The format of these parameters as specified to the dropper module API.
-They could made self calculated for fine tuning, within the apps.
+The format of these parameters is specified to the dropper module API
+and can be fine-tuned within applications.
+They could be made self-calculated for fine tuning within the apps.
 
 .. _Enqueue_Operation:
 
@@ -1316,7 +1317,7 @@ decision is the output value and the remaining values are configuration paramete
 EWMA Filter Microblock
 ^^^^^^^^^^^^^^^^^^^^^^
 
-The purpose of the EWMA Filter microblock is to filter queue size values to smooth out transient changes
+The purpose of the EWMA filter microblock is to filter queue size values to smooth out transient changes
 that result from "bursty" traffic.
 The output value is the average queue size which gives a more stable view of the current congestion level in the queue.
 
@@ -1426,7 +1427,7 @@ These approaches include:
 
 *   Large look-up table (76 KB)
 
-The method that was finally selected (described above in Section 26.3.2.2.1) out performs all of these approaches
+The method that was finally selected (described above in Section 26.3.2.2.1) outperforms all of these approaches
 in terms of run-time performance and memory requirements and
 also achieves accuracy comparable to floating-point evaluation.
 :numref:`table_qos_17` lists the performance of each of these alternative approaches relative to the method that is used in the dropper.
@@ -1700,7 +1701,7 @@ The arguments passed to the enqueue API are configuration data, run-time data,
 the current size of the packet queue (in packets) and a value representing the current time.
 The time reference is in units of bytes,
 where a byte signifies the time duration required by the physical interface to send out a byte on the transmission medium
-(see Section 26.2.4.5.1 "Internal Time Reference" ).
+(see `Internal Time Reference`_).
 The dropper reuses the scheduler time stamps for performance reasons.
 
 Empty API
@@ -1720,7 +1721,7 @@ Traffic Metering
 The traffic metering component implements the Single Rate Three Color Marker (srTCM) and
 Two Rate Three Color Marker (trTCM) algorithms, as defined by IETF RFC 2697 and 2698 respectively.
 These algorithms meter the stream of incoming packets based on the allowance defined in advance for each traffic flow.
-As result, each incoming packet is tagged as green,
+As a result, each incoming packet is tagged as green,
 yellow or red based on the monitored consumption of the flow the packet belongs to.
 
 Functional Overview
@@ -1739,12 +1740,12 @@ with the two buckets sharing the same token update rate:
 The trTCM algorithm defines two token buckets for each traffic flow,
 with the two buckets being updated with tokens at independent rates:
 
-*   Committed (C) bucket: fed with tokens at the rate defined by the Committed Information Rate (CIR) parameter
+*   Committed (C) bucket: fed with tokens at the rate defined by Committed Information Rate (CIR) parameter
     (measured in bytes of IP packet per second).
     The size of the C bucket is defined by the Committed Burst Size (CBS) parameter (measured in bytes);
 
-*   Peak (P) bucket: fed with tokens at the rate defined by the Peak Information Rate (PIR) parameter
-    (measured in IP packet bytes per second).
+*   Peak (P) bucket: fed with tokens at the rate defined by Peak Information Rate (PIR) parameter
+    (measured in bytes of IP packet per second).
     The size of the P bucket is defined by the Peak Burst Size (PBS) parameter (measured in bytes).
 
 Please refer to RFC 2697 (for srTCM) and RFC 2698 (for trTCM) for details on how tokens are consumed
@@ -1755,7 +1756,7 @@ Color Blind and Color Aware Modes
 
 For both algorithms, the color blind mode is functionally equivalent to the color aware mode with input color set as green.
 For color aware mode, a packet with red input color can only get the red output color,
-while a packet with yellow input color can only get the yellow or red output colors.
+while a packet with yellow input color can only get yellow or red output colors.
 
 The reason why the color blind mode is still implemented distinctly than the color aware mode is
 that color blind mode can be implemented with fewer operations than the color aware mode.
@@ -1766,12 +1767,12 @@ Implementation Overview
 For each input packet, the steps for the srTCM / trTCM algorithms are:
 
 *   Update the C and E / P token buckets. This is done by reading the current time (from the CPU timestamp counter),
-    identifying the amount of time since the last bucket update and computing the associated number of tokens
-    (according to the pre-configured bucket rate).
+    identifying the amount of time since the last bucket update, and computing the associated number of tokens
+    according to the pre-configured bucket rate.
     The number of tokens in the bucket is limited by the pre-configured bucket size;
 
 *   Identify the output color for the current packet based on the size of the IP packet
-    and the amount of tokens currently available in the C and E / P buckets; for color aware mode only,
+    and the amount of tokens currently available in the C and E / P buckets. For color aware mode only,
     the input color of the packet is also considered.
     When the output color is not red, a number of tokens equal to the length of the IP packet are
-    subtracted from the C or E /P or both buckets, depending on the algorithm and the output color of the packet.
+    subtracted from the C or E / P or both buckets, depending on the algorithm and the output color of the packet.
-- 
2.51.0

