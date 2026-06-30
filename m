Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A442C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 00:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B5F04021E;
	Tue, 30 Jun 2026 02:19:50 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8218240150
 for <dev@dpdk.org>; Tue, 30 Jun 2026 02:19:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9920D4B7C1; Tue, 30 Jun 2026 02:19:47 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1961] Rx timestamp no rollover indication
Date: Tue, 30 Jun 2026 00:19:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1961-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1961

            Bug ID: 1961
           Summary: Rx timestamp no rollover indication
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: enhancement
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Each PMD has its own internal hardware counter for receive timestamps. But =
this
counter can and will roll over so using it for things like packet capture is
impossible with current API's. Need something more complete and richer than
existing read_clock API.

AI analysis showed:

  The Rollover Problem

  Hardware timestamps typically use a fixed-width counter that wraps around:
  - 32-bit counter at 1GHz =3D rollover every ~4.3 seconds
  - 40-bit counter at 1GHz =3D rollover every ~18 minutes
  - 48-bit counter at 1GHz =3D rollover every ~3.3 days

  Without knowing the counter width, you can't detect or handle rollovers
correctly!

  Current API Limitations

  The read_clock operation only returns:
  int rte_eth_read_clock(uint16_t port_id, uint64_t *clock);

  This doesn't tell you:
  1. Counter bit width - Is it 32, 40, 48, or 64 bits?
  2. Rollover period - How often does it wrap?
  3. Clock frequency - Needed to calculate rollover time
  4. Timestamp format - Raw counter vs scaled nanoseconds

  What's Needed for Robust Packet Capture

  struct rte_eth_timestamp_info {
      uint64_t frequency_hz;     /* Clock frequency */
      uint8_t  counter_bits;     /* Actual counter width (32/40/48/64) */
      uint64_t rollover_nsec;    /* Rollover period in nanoseconds */
      uint64_t current_value;    /* Current counter reading */
      enum {
          RTE_TS_FORMAT_RAW_COUNTER,
          RTE_TS_FORMAT_NANOSECONDS,
          RTE_TS_FORMAT_PTP_TIME
      } format;
  };

  Real-World Impact on Packet Capture

  Without rollover information, packet capture tools face impossible choice=
s:

  Problem 1: Undetected Rollover

  /* Packet 1: timestamp =3D 0xFFFFFFF0 (near max for 32-bit) */
  /* Packet 2: timestamp =3D 0x00000010 (rolled over) */
  /* Without knowing it's 32-bit, this looks like time went backwards! */

  Problem 2: Incorrect Delta Calculation

  /* If you assume 64-bit but it's actually 40-bit: */
  delta =3D pkt2_ts - pkt1_ts;  /* Huge negative or wrong positive value */

  Problem 3: Can't Maintain Absolute Time

  /* Need to track rollovers to maintain wall-clock correlation: */
  absolute_time =3D (rollover_count * rollover_period) + current_timestamp;
  /* But without knowing rollover_period, this is impossible */

  Specific Driver Issues

  Looking at actual implementations:

  - Intel E810 (ice): 40-bit counter @ 812.5MHz =3D ~22 minute rollover
  - Intel 700 series (i40e/iavf): 48-bit counter, but what frequency?
  - Mellanox: Various counter widths depending on firmware
  - Broadcom: Often 48-bit, but frequency varies

  None of this is exposed through the API!

  Proposed API Enhancement

  /* Better API for timestamp capabilities */
  int rte_eth_timestamp_info_get(uint16_t port_id,=20
                                  struct rte_eth_timestamp_info *info);

  /* Helper to handle rollover */
  uint64_t rte_eth_timestamp_normalize(uint16_t port_id,
                                       uint64_t hw_timestamp,
                                       uint64_t *rollover_count);

  This would let packet capture tools:
  1. Detect and handle rollovers correctly
  2. Maintain accurate absolute timestamps across rollovers
  3. Generate proper pcap timestamps even for long captures
  4. Warn users about rollover limitations

--=20
You are receiving this mail because:
You are the assignee for the bug.=
