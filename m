Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19D606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 16:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCAE040151;
	Thu, 19 Nov 2026 17:46:08 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 1872B400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 17:46:08 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EEB1C4D57F; Thu, 19 Nov 2026 17:46:07 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2149] net/axgbe: AN state machine and PHY mode
 change run in EAL interrupt thread
Date: Thu, 19 Nov 2026 16:46:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
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
Message-ID: <bug-2149-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2149

            Bug ID: 2149
           Summary: net/axgbe: AN state machine and PHY mode change run in
                    EAL interrupt thread
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Found while reviewing latest axgbe changes. The problem with busy waiting
in interrupt thread is that it will then block all other interrupts from
occurring from other devices.


The axgbe interrupt callback runs the full autonegotiation state
machine, including PHY mode changes, directly on the EAL interrupt
thread. That path busy-waits on firmware and hardware for hundreds of
milliseconds, and up to several seconds on timeout.

Call path:

  axgbe_dev_interrupt_handler()              axgbe_ethdev.c:316
    pdata->phy_if.an_isr()
      axgbe_an73_isr()                       axgbe_mdio.c:660
        pthread_mutex_lock(&pdata->an_mutex)
        axgbe_an73_state_machine()
          axgbe_an73_incompat_link()
            axgbe_switch_mode() -> phy_impl.set_mode()
              axgbe_phy_perform_ratechange()  axgbe_phy_impl.c:1561
                mailbox poll: rte_delay_us(1500) x 500 (750 ms max)
                axgbe_rx_adaptation(): rte_delay_ms(200)

PHY access from this context also goes through
axgbe_phy_get_comm_ownership(), which polls the hardware I2C/MDIO
mutex with rte_delay_us(100) for up to 5 seconds while holding
phy_mutex.

Impact:

- The EAL interrupt thread is shared across all devices. While axgbe
  is busy-waiting, LSC/RMV/mailbox interrupts for every other port and
  PMD in the process are stalled.
- EAL alarm callbacks are dispatched from the same thread and are
  delayed the same way.
- Application threads calling link_update/dev_start block on an_mutex
  for the same duration.

The Linux amd-xgbe driver, which this PMD is derived from, does not do
this work in the ISR. It defers it with
queue_work(pdata->an_workqueue, &pdata->an_irq_work). The DPDK port
collapsed that into the interrupt callback.

Suggested fix:

The interrupt callback should only read and clear the AN interrupt
status into pdata->an_int and wake a per-port control thread
(rte_thread_create_internal_control) that runs the state machine and
mode change. That matches the Linux design and keeps the existing
mutexes meaningful (AN worker vs application control path).

Deferring with rte_eal_alarm_set() is not sufficient, since alarms run
on the same EAL interrupt thread.

Other PMDs whose interrupt callbacks reach rte_delay_* in PHY or
firmware code probably have the same problem and should be audited.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
