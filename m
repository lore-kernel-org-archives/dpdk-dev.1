Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58010A1E62
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75257427DB;
	Thu, 26 Mar 2026 11:37:10 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0CEA040E1E
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:37:09 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E6A134ADA7; Thu, 26 Mar 2026 11:37:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1914] Inconsistent dpaa2 driver remove callback
 error reporting
Date: Thu, 26 Mar 2026 10:37:08 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1914-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1914

            Bug ID: 1914
           Summary: Inconsistent dpaa2 driver remove callback error
                    reporting
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: ktraynor@redhat.com
  Target Milestone: ---

For dpaa2 drivers, a return value is expected for the remove function.

struct rte_dpaa2_driver {
        TAILQ_ENTRY(rte_dpaa2_driver) next; /**< Next in list. */
        struct rte_driver driver;           /**< Inherit core driver. */
        uint32_t drv_flags;                 /**< Flags for controlling
device.*/
        enum rte_dpaa2_dev_type drv_type;   /**< Driver Type */
        rte_dpaa2_probe_t probe;
        rte_dpaa2_remove_t remove; <--------
};

typedef int (*rte_dpaa2_remove_t)(struct rte_dpaa2_device *dpaa2_dev);

On error, rte_dpaa2_remove and cryptodev_dpaa2_sec_remove callbacks return =
an
error.

However, dpaa2_qdma_remove callback logs the error and returns success.

In the current code, return value is not checked in fslmc_bus_unplug and if=
 it
failed, it clears the driver reference and incorrectly logs that it was
unplugged.

In fslmc_close_iodevices the return value only impacts logging.

The remove callback return values should be made consistent, and return che=
ck
added to fslmc_bus_unplug.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
