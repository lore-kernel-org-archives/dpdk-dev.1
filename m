Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D2ECA0FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 22:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD61F40288;
	Wed, 10 Sep 2025 00:43:01 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 631DD40261
 for <dev@dpdk.org>; Wed, 10 Sep 2025 00:43:00 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45dec601cd3so16471745e9.2
 for <dev@dpdk.org>; Tue, 09 Sep 2025 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757457779;
 x=1758062579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEu6jLwZYjGClBLyDDE2UrWNTHWYxUgi5EQpx3o0svM=;
 b=LJW8HbHGLQe3LSsHh0dOoeK+JXE9PYRw9yw37CeODuxJgm6EiusNrBHHmQ1YZKyXkJ
 +AlhYBxJdQDQGaUPxjtr3vGnL6cayz89cSn5qs/QQbrJ1Jq4ER+Csdy3my/03mOhWLt9
 FgR8gwcle4sxBB1kIY7aYpjFpQ/YqSbj/vfkmhwBbtwbpddNh9Vz+7geGDmnIuLDWbrO
 SsZVezrl12jYblNxEJX4hc66BubxgU0HgRWy+CR/lhzUpjTcJ3U61/TOKlJ+E+cm0XNK
 ww6whyzPP5yIPSqZyF42kaQtON+d76ZLMZ818KT7QjHGUjtBjGPFFS5HaK51nt3QCb5N
 ltWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757457779; x=1758062579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEu6jLwZYjGClBLyDDE2UrWNTHWYxUgi5EQpx3o0svM=;
 b=ExoRNVjleKftUT1It1z4q4TMZKzg9ydR5MGdo+yre0937bX8iCq7EMve9Zgovrrbme
 PncyZFNW/v8e26mbRq08/W0PUyIxPuIo+fJihf7grWexShmeof0hcgfCtS0GH32JEaBX
 lU407KHnKMhpk1uNoDaF34imSixb2MoHPB0m9nlp0aQZR58C3zUIMhytehPuMfbeL6Md
 fMlzOKFoVcsJX1wEcv4AeJXQcg6clSHzInkf9aC12U/wf1vs0PAfabW7thN5IV6hNw9V
 wik/cRLxYvaouQNa3tFyZY9jcEc3v03XXOzFPJej7Lp+IxbMO8XiRRJpTBPdCIy9k0ip
 41GQ==
X-Gm-Message-State: AOJu0YznxFobJ9e3KK9p75qbHDRVl/inxOQfrTGcT2+K8ozjKWJZ5sAl
 7E2MVJgyBVRskkVQFAyQW09y9v4U50+xg9dFB6thipRVOYC4eU/TK9D/csevhSLPS1Q=
X-Gm-Gg: ASbGnct9++3Izl24obwp2EaV1S3l0eEAZB5M1TFoiLPYN8OauxtmPLA+HLP6C0tXGXp
 brJ32E28cuRhSMMmox6YI05jC0Ak0qxURkfMxx2VkpzW+V4YSoT/LOaP/AJadO6rQ9G1aOSmXi7
 6lq+rRWcXFsETstCSYbtkBF92PlELLJxhzKI/qlzvPj4GREhbfEnc89eE4mgx18DeW0MSFQO7hr
 Y525N7ASLCRM9zzcxr6ZxZqUsJuCEiJXcc86XQB+ArjUb+o8eGbOGDo8woM/echHLAfOSl46vkA
 igLCUrxMOQD/BPol7EhfpFU262iSNUmdaNJukOdbLZEl2hsFrN/+u2D9T1BGZ8I5/xFltoZJUXW
 vcVm1FV1ZUgu4CGy7MaKJRuX1KYO2ZLLlNE6RRwAeT+NvwY+KM6MEQDKfDIGeA4ZjHmD/dTmuPe
 U=
X-Google-Smtp-Source: AGHT+IGU+j+HteX9pngnWnXpvpv9Df7mtHaae8Ldrd0QmTem29OkMpuX/e09hvE4cpADfM1i+/zCmQ==
X-Received: by 2002:a05:600c:46ca:b0:45d:d197:fecf with SMTP id
 5b1f17b1804b1-45ddde31722mr126390625e9.0.1757457779423; 
 Tue, 09 Sep 2025 15:42:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df823098fsm3803505e9.21.2025.09.09.15.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:42:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 15:42:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [V9 00/17] add-hinic3-PMD-driver
Message-ID: <20250909154249.13633bb7@hermes.local>
In-Reply-To: <20250909073157.14968-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250909073157.14968-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue,  9 Sep 2025 15:31:28 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> v9:
> -resolve type conflict issue
> 
> v8:
> -resolve CI compile error
> -modify mbox section
> 
> v7:
> -remove unused-functions
> 
> v6:
> -modify based on community comments
> -remove mml files
> 
> v5:
> -fix build err
> 
> v4: 
> -solve patch application conflict issue 
> 
> v3:
> -fix checkpatchs errors issue
> 
> v2:
> -modify CI compile errors
> 
> v1:
> -modify community comments and compile issues
> -remove the compilation flags in the meson build
> -remove (void) cur_link_machine_state
> -remove '*** BLURE HERE ***' in cover letter
> 
>  .mailmap                                   |    4 +-
>  MAINTAINERS                                |    6 +
>  doc/guides/nics/features/hinic3.ini        |   60 +
>  doc/guides/nics/hinic3.rst                 |   47 +
>  doc/guides/nics/index.rst                  |    1 +
>  doc/guides/rel_notes/release_25_11.rst     |    4 +
>  drivers/net/hinic3/base/hinic3_cmd.h       |  156 +
>  drivers/net/hinic3/base/hinic3_cmdq.c      |  972 +++++
>  drivers/net/hinic3/base/hinic3_cmdq.h      |  230 ++
>  drivers/net/hinic3/base/hinic3_compat.h    |  144 +
>  drivers/net/hinic3/base/hinic3_csr.h       |  108 +
>  drivers/net/hinic3/base/hinic3_eqs.c       |  710 ++++
>  drivers/net/hinic3/base/hinic3_eqs.h       |   98 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.c    |  194 +
>  drivers/net/hinic3/base/hinic3_hw_cfg.h    |  117 +
>  drivers/net/hinic3/base/hinic3_hw_comm.c   |  449 +++
>  drivers/net/hinic3/base/hinic3_hw_comm.h   |  365 ++
>  drivers/net/hinic3/base/hinic3_hwdev.c     |  558 +++
>  drivers/net/hinic3/base/hinic3_hwdev.h     |  183 +
>  drivers/net/hinic3/base/hinic3_hwif.c      |  741 ++++
>  drivers/net/hinic3/base/hinic3_hwif.h      |  144 +
>  drivers/net/hinic3/base/hinic3_mbox.c      | 1225 +++++++
>  drivers/net/hinic3/base/hinic3_mbox.h      |  181 +
>  drivers/net/hinic3/base/hinic3_mgmt.c      |  355 ++
>  drivers/net/hinic3/base/hinic3_mgmt.h      |  112 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c   | 1795 ++++++++++
>  drivers/net/hinic3/base/hinic3_nic_cfg.h   | 1530 ++++++++
>  drivers/net/hinic3/base/hinic3_nic_event.c |  407 +++
>  drivers/net/hinic3/base/hinic3_nic_event.h |   38 +
>  drivers/net/hinic3/base/hinic3_wq.c        |  140 +
>  drivers/net/hinic3/base/hinic3_wq.h        |  109 +
>  drivers/net/hinic3/base/meson.build        |   50 +
>  drivers/net/hinic3/hinic3_ethdev.c         | 3782 ++++++++++++++++++++
>  drivers/net/hinic3/hinic3_ethdev.h         |  164 +
>  drivers/net/hinic3/hinic3_fdir.c           | 1379 +++++++
>  drivers/net/hinic3/hinic3_fdir.h           |  398 ++
>  drivers/net/hinic3/hinic3_flow.c           | 1501 ++++++++
>  drivers/net/hinic3/hinic3_flow.h           |  196 +
>  drivers/net/hinic3/hinic3_nic_io.c         |  806 +++++
>  drivers/net/hinic3/hinic3_nic_io.h         |  171 +
>  drivers/net/hinic3/hinic3_rx.c             | 1067 ++++++
>  drivers/net/hinic3/hinic3_rx.h             |  353 ++
>  drivers/net/hinic3/hinic3_tx.c             | 1024 ++++++
>  drivers/net/hinic3/hinic3_tx.h             |  313 ++
>  drivers/net/hinic3/meson.build             |   31 +
>  drivers/net/meson.build                    |    1 +
>  46 files changed, 22418 insertions(+), 1 deletion(-)
>  create mode 100644 doc/guides/nics/features/hinic3.ini
>  create mode 100644 doc/guides/nics/hinic3.rst
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_compat.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_csr.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_eqs.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_hwif.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_cfg.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_nic_event.h
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_wq.h
>  create mode 100644 drivers/net/hinic3/base/meson.build
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.c
>  create mode 100644 drivers/net/hinic3/hinic3_ethdev.h
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.c
>  create mode 100644 drivers/net/hinic3/hinic3_fdir.h
>  create mode 100644 drivers/net/hinic3/hinic3_flow.c
>  create mode 100644 drivers/net/hinic3/hinic3_flow.h
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.c
>  create mode 100644 drivers/net/hinic3/hinic3_nic_io.h
>  create mode 100644 drivers/net/hinic3/hinic3_rx.c
>  create mode 100644 drivers/net/hinic3/hinic3_rx.h
>  create mode 100644 drivers/net/hinic3/hinic3_tx.c
>  create mode 100644 drivers/net/hinic3/hinic3_tx.h
>  create mode 100644 drivers/net/hinic3/meson.build
> 

Most of this driver is fine, a few more things.


  1. Since DPDK applications are often statically linked, drivers should make sure
     that all global symbols have the same prefix. For this driver I see:

$ nm ./build/drivers/librte_net_hinic3.a | grep ' [TDB] '  | grep -v hinic3
00000000000000e0 T cfg_mbx_vf_proc_msg
0000000000000040 T pf_handle_mgmt_comm_event
0000000000000030 T vf_handle_pf_comm_mbox
0000000000000310 T get_port_info

  2. Don't use rte_memcpy() for simple fixed size copies. For this driver replace
     all use of rte_memcpy with memcpy which has more checking

  3. Why is a cast needed here?
	rx_free_thresh = (uint16_t)((rx_conf->rx_free_thresh)
				       ? rx_conf->rx_free_thresh
				       : HINIC3_DEFAULT_RX_FREE_THRESH);
     Probably just need to add u here:
	:#define HINIC3_DEFAULT_RX_FREE_THRESH 32u
     Casts are the enemy of compiler checking.

  4. Prefer that messages not be broken across lines, it makes it harder
     to search source for where error message is. Don't worry if format line is
     a little long.

     Instead:
		if (err || out_param != 0) {
			PMD_DRV_LOG(ERR,
				    "Set SQ ctxts failed, err: %d, out_param: %" PRIu64,
				    err, out_param);

			err = -EFAULT;
			break;
		}
     Same extra line breaks elsewhere.

  5. Please fix these warnings, instead of stifling them.

# The driver runs only on arch64 machine, remove 32bit warnings
if not dpdk_conf.get('RTE_ARCH_64')
    extra_flags += [
            '-Wno-int-to-pointer-cast',
            '-Wno-pointer-to-int-cast',
    ]
endif


   6. Having to add meson instructions for static library() seems like something
      that could be fixed elsewhere.  Why is this in base/meson.build.

   7. The code in hinic3_dev_rx_queue_start() is checking that rq_id < dev->data->nb_rx_queues.
      But this condition is already checked in ethdev layer via eth_dev_validate_rx_queue.
      Same useless check in hinc3_dev_rx_queue_stop() and hnic3_dev_tx_queue_stop().
      And in hinc3_dev_rx_queue_intr_enable/disable

   8. Don't stub out rx_queue_count, rx_descriptor_status, and tx_descriptor_status
      If driver doesn't implement these, leave it NULL. Ethdev fills in a dummy operation for you.

   9. Don't log things exposed by API at INFO level.
      For example, probe or set_lro. Put at DEBUG level.

  10. Driver features says it has "CRC offload". The documentation is confusing
      but driver must support KEEP_CRC for this.

  11. Driver says it supports ptypes, but it does not (see ptypes_get).

  12. Why does hinic3_xstats_cal_num return a signed value? Looks like it should be
      unsigned. Then can take off cast in xstats_get().

  13. When handling regular stats_get() best to count all queues even if queue
      is larger than RTE_ETHDEV_QUEUE_STATS_CNTRS.  Just don't fill in per-queue value for those
      queues. Discards don't count as input packets. Also extra paren here.

   13, Why does reading stats clear rx_mbuf_alloc_failed? That should be cleared in reset.

Something like this maybe:
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index b83e632d54..75d7ac3ca2 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2644,9 +2644,7 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 {
 	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
 	struct hinic3_vport_stats vport_stats;
-	struct hinic3_rxq *rxq = NULL;
-	struct hinic3_txq *txq = NULL;
-	int i, err, q_num;
+	int err;
 	uint64_t rx_discards_pmd = 0;
 
 	err = hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);
@@ -2656,25 +2654,23 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 		return err;
 	}
 
-	dev->data->rx_mbuf_alloc_failed = 0;
-
 	/* Rx queue stats. */
-	q_num = (nic_dev->num_rqs < RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			? nic_dev->num_rqs
-			: RTE_ETHDEV_QUEUE_STAT_CNTRS;
-	for (i = 0; i < q_num; i++) {
-		rxq = nic_dev->rxqs[i];
+	for (unsigned i = 0; i < nic_dev->num_rqs;  i++) {
+		struct hinic3_rxq *rxq = nic_dev->rxqs[i];
+
 #ifdef HINIC3_XSTAT_MBUF_USE
 		rxq->rxq_stats.rx_left_mbuf_bytes =
 			rxq->rxq_stats.rx_alloc_mbuf_bytes -
 			rxq->rxq_stats.rx_free_mbuf_bytes;
 #endif
 		rxq->rxq_stats.errors = rxq->rxq_stats.csum_errors +
-					rxq->rxq_stats.other_errors;
+			rxq->rxq_stats.other_errors;
 
-		stats->q_ipackets[i] = rxq->rxq_stats.packets;
-		stats->q_ibytes[i] = rxq->rxq_stats.bytes;
-		stats->q_errors[i] = rxq->rxq_stats.errors;
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = rxq->rxq_stats.packets;
+			stats->q_ibytes[i] = rxq->rxq_stats.bytes;
+			stats->q_errors[i] = rxq->rxq_stats.errors;
+		}
 
 		stats->ierrors += rxq->rxq_stats.errors;
 		rx_discards_pmd += rxq->rxq_stats.dropped;
@@ -2682,15 +2678,14 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 	}
 
 	/* Tx queue stats. */
-	q_num = (nic_dev->num_sqs < RTE_ETHDEV_QUEUE_STAT_CNTRS)
-			? nic_dev->num_sqs
-			: RTE_ETHDEV_QUEUE_STAT_CNTRS;
-	for (i = 0; i < q_num; i++) {
-		txq = nic_dev->txqs[i];
-		stats->q_opackets[i] = txq->txq_stats.packets;
-		stats->q_obytes[i] = txq->txq_stats.bytes;
-		stats->oerrors += (txq->txq_stats.tx_busy +
-				   txq->txq_stats.offload_errors);
+	for (unsigned int i = 0; i < nic_dev->num_sqs; i++) {
+		struct hinic3_txq *txq = nic_dev->txqs[i];
+
+		stats->oerrors += txq->txq_stats.tx_busy + txq->txq_stats.offload_errors;
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = txq->txq_stats.packets;
+			stats->q_obytes[i] = txq->txq_stats.bytes;
+		}
 	}
 
 	/* Vport stats. */
@@ -2698,22 +2693,21 @@ hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)
 
 	stats->imissed = vport_stats.rx_discard_vport + rx_discards_pmd;
 
-	stats->ipackets =
-		(vport_stats.rx_unicast_pkts_vport +
-		 vport_stats.rx_multicast_pkts_vport +
-		 vport_stats.rx_broadcast_pkts_vport - rx_discards_pmd);
+	stats->ipackets = vport_stats.rx_unicast_pkts_vport +
+		vport_stats.rx_multicast_pkts_vport +
+		vport_stats.rx_broadcast_pkts_vport;
 
-	stats->opackets = (vport_stats.tx_unicast_pkts_vport +
-			   vport_stats.tx_multicast_pkts_vport +
-			   vport_stats.tx_broadcast_pkts_vport);
+	stats->opackets = vport_stats.tx_unicast_pkts_vport +
+		vport_stats.tx_multicast_pkts_vport +
+		vport_stats.tx_broadcast_pkts_vport;
 
-	stats->ibytes = (vport_stats.rx_unicast_bytes_vport +
-			 vport_stats.rx_multicast_bytes_vport +
-			 vport_stats.rx_broadcast_bytes_vport);
+	stats->ibytes = vport_stats.rx_unicast_bytes_vport +
+		vport_stats.rx_multicast_bytes_vport +
+		vport_stats.rx_broadcast_bytes_vport;
 
-	stats->obytes = (vport_stats.tx_unicast_bytes_vport +
-			 vport_stats.tx_multicast_bytes_vport +
-			 vport_stats.tx_broadcast_bytes_vport);
+	stats->obytes = vport_stats.tx_unicast_bytes_vport +
+		vport_stats.tx_multicast_bytes_vport +
+		vport_stats.tx_broadcast_bytes_vport;
 	return 0;
 }
 
@@ -2735,6 +2729,8 @@ hinic3_dev_stats_reset(struct rte_eth_dev *dev)
 	int qid;
 	int err;
 
+	dev->data->rx_mbuf_alloc_failed = 0;
+
 	err = hinic3_clear_vport_stats(nic_dev->hwdev);
 	if (err)
 		return err;


