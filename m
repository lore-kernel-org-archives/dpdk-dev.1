Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC229CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 314B440616;
	Wed, 14 Oct 2026 14:23:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 72D6640430;
 Wed, 14 Oct 2026 14:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791980621; x=1823516621;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gykuHP51qnrGEnR9QiZCuaUorwhPIW3tIhN8jAEQHSU=;
 b=Va5SJWZlIzKSAiQOBHsefOGaYq8srwgp8f6UMJwS3aPrRHUP7pHCmY0Z
 rhJ3kChHlC3LcVc9D8d6A7qW4SgmjJee/BxOtoJxeDMpoDsglz84tLI6I
 Hycum08TQC74YGFNfuWDHig+BwlrC0DpR7UsP7FTdUtrGrbwV/g2rT+XH
 UWvd36zV60VwJbrxpikmLAf3tgIxY5tq/s+NnJ0LxjARFfaAO1gYJzTz8
 ZSqkRgnxhX9FINJMkEkywOnw/JjGlmChiLueg2clqLFfo8NmwI4o4E+uF
 6AcCxcuSB6VAv/C0q6rwtdodRR7wZ+pyANcHl9ndc55F4DmIIkhkhXkcf A==;
X-CSE-ConnectionGUID: 54SujwLhT3GbVL2vyd+wCg==
X-CSE-MsgGUID: OIKyL+VxRsaewOJglISJqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="717313"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="717313"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 05:23:41 -0700
X-CSE-ConnectionGUID: +4VZSVqXQrevZLrZMR63Jw==
X-CSE-MsgGUID: /392dUx1TaKThmt6vfjdfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1524809"
Received: from mtldev4.igk.intel.com ([10.123.233.187])
 by fmviesa002.fm.intel.com with ESMTP; 14 Oct 2026 05:23:37 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, marek.kasiewicz@intel.com, stable@dpdk.org,
 Jingjing Wu <jingjing.wu@intel.com>, Saurabh Singhal <saurabhs@arista.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH] net/iavf: fix interrupt callback race on close
Date: Wed, 14 Oct 2026 12:24:27 +0000
Message-ID: <20261014122427.631805-1-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

iavf_dev_close() unregisters iavf_dev_interrupt_handler() with
rte_intr_callback_unregister() and ignores the result. That call
returns -EAGAIN, and leaves the callback registered, while the
interrupt thread is running a callback of the same source.

Close hits that window. It sends virtchnl commands (RSS, promiscuous
mode, flows), and iavf_dev_interrupt_handler() handles each response.
The handler clears the pending command before it returns, so the
thread waiting in iavf_wait_for_msg() can go on to the unregister
while the interrupt thread is still inside the callback. This is
likely when the two threads share a CPU.

Two failures follow:
- The interrupt thread resumes the callback after
  rte_eth_dev_release_port() has set dev->data to NULL, and
  iavf_handle_virtchnl_msg() dereferences it: segmentation fault.
- The callback returns, but its source stays registered after the
  port is closed. At rte_eal_cleanup(),
  pci_vfio_unmap_resource_primary() closes the interrupt eventfd, and
  the next rebuild of the epoll set aborts the process:
    EAL: PANIC in eal_intr_thread_main():
    Error adding fd 49 epoll_ctl, Bad file descriptor

Use rte_intr_callback_unregister_sync(), as ice_dev_close() does. The
iavf_dev_init() error path has the same pattern; fix it too.

The sync variant waits for a running callback to return. It would
spin forever only if called from iavf_dev_interrupt_handler() itself,
and that handler never closes or re-initializes the port: it hands PF
events and resets to the iavf-event thread with iavf_dev_event_post().
A close from any other interrupt thread callback, such as an alarm,
returns at once, because the iavf source is not active then.

Fixes: 22b123a36d07 ("net/avf: initialize PMD")
Fixes: e35a5737a746 ("net/iavf: unregister interrupt handler before FD close")
Cc: stable@dpdk.org

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 6cf12ec34f..be4b491859 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3178,8 +3178,8 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 		rte_intr_disable(pci_dev->intr_handle);
 
 		/* unregister callback func from eal lib */
-		rte_intr_callback_unregister(pci_dev->intr_handle,
-					     iavf_dev_interrupt_handler, eth_dev);
+		rte_intr_callback_unregister_sync(pci_dev->intr_handle,
+						  iavf_dev_interrupt_handler, eth_dev);
 	}
 	iavf_phc_sync_alarm_stop(eth_dev);
 	rte_eal_alarm_cancel(iavf_dev_alarm_handler, eth_dev);
@@ -3275,8 +3275,8 @@ iavf_dev_close(struct rte_eth_dev *dev)
 		rte_intr_disable(intr_handle);
 
 		/* unregister callback func from eal lib */
-		rte_intr_callback_unregister(intr_handle,
-					     iavf_dev_interrupt_handler, dev);
+		rte_intr_callback_unregister_sync(intr_handle,
+						  iavf_dev_interrupt_handler, dev);
 	}
 	iavf_phc_sync_alarm_stop(dev);
 	rte_eal_alarm_cancel(iavf_dev_alarm_handler, dev);

base-commit: b39ee12b030f49c524b9d8c350a0f4b04141ccf9
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

