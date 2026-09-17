Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840E7C982D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:21:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32EC842FD7;
	Thu, 17 Sep 2026 19:21:30 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id CB52242FD1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 19:21:26 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-8674704dab1so1443141b3a.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789665686;
 x=1790270486; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x6pxa1PhGsEYeoW+blv7rrusX8gBXxgsyfTJTv1ZC9A=;
 b=cKfT9yYOGJ55XYcqykuescII/QLGxCWQgiAt5Kd0KntH13EfrQrcUL4iJPFF7EIqPJ
 06qh8TyU3r0zCtVYrnsPjh5uS4l5TmnK6B9cZiYOHL5S4JojBWt+trwBhVE/ZYtLHgxc
 GaE4MX6vQ0T2w/ADopdRnU1jiN91cId7iQiGL+3meHZvnJ6DvMRx6ilACMcXwZ0OR2/P
 tvY90OTsJkpUeMAVPZHyUYr9ZUqz7OM+XzKDktAsUfqVGixapUSLTYiPS0+BLKceYWAY
 zvpJWEM5/5E7Qx6aPDI714nMOApwoeeROvTRdns0s5G5FSuVrFKOGci/N+kMA/qefzxX
 HSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665686; x=1790270486;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x6pxa1PhGsEYeoW+blv7rrusX8gBXxgsyfTJTv1ZC9A=;
 b=k4fZRaJeaHgEjMRX5NmKeheCrgTo+aSFRQh+77adsHicZLLcy/EqR8eX3Pmo3/32BR
 XEo6wcLpecsGfcTqm1nogfer514L2kMivjYDpSQCgk87x4EoPH4OsGJgoW2kK1Jmy7BA
 QRrOLBA/BhiCwRLB78zfJD8tfJn/G6FwXXQ9Yt/bXH1LFvitH7Rf0IRkNFhKyYuDKasC
 48ZtffC1f+mMfaQo1tCiJtHJ3DE2AuT7YtZm8pWwjYVf0XJju+8/Bbot4elS48gjdg0C
 3kFHBGc0r6f5wqwMUI45SpPC+Fw/VeEa9Ua8o0aj4OYajE2ebQgpg9SWue4WFICb6h8z
 /N1w==
X-Gm-Message-State: AFuF++mUXsqNYwI5GBsThEzW8K2h+nrSMOQkCEcIJuOG+FSS0UcEK1E9
 baxD3xxy9I5j0xYWFEvgTTalq9whOeK3nxvj4U42lDgOmPMF9iaMdUbI8MfnqRs6AfXM+OEWkqE
 G643w+wo=
X-Gm-Gg: AYBFou3eYnZhGNi3vMzjezj/DAYDjT2WqrJ72wJkVdVH5GKEwUfZtTa58ZJ6PpbSdGx
 UYUW8bgT7PhOn8mgcapGKLPFfDWq1yjY9KXe+C/8YqxLl2fUSmZqgnBgS9/CY+9VX8f+7Qp8XIj
 RBzF4Ie8sa+5qT40f5IVdZ+DzVdS3WGrex+4CW6hNu7ogd6TLLQeJb8CA4C75UJMigiY1Xc9gse
 xMbDHm1nswFR474w74Zo9lrl6g9CDxn/s3DdCTwrepJEaSbuRujYdaTGSYHffBnZWsBAKolwLNQ
 6+7ZuChhQsMltsfa2yjB1hDgk9ah9E2jx+mB33O29Unb/yzBkpdJDKBHksgGNKpPMHcGr8iKxyq
 yCRvJEVE1GWLjG4rmVRsr47orX63wVfZrgwLu9IWIMk49mQ7O0BKSGdIddqQevukGhMpCY3+GsC
 P0TX8Op5Bx/0ynISIFHiF9IqNAeKcL9LNmU9Jxq/elcDx1+ks+Z4XKGdg+0SZ2MTvYcB/DADhg6
 i5rmRd6d/jmyNfn2M7hQ0b1kNDgEjJdH7FL3w==
X-Received: by 2002:a05:6a00:3918:b0:86a:7134:b0df with SMTP id
 d2e1a72fcca58-8723e219a42mr14642015b3a.23.1789665684937; 
 Thu, 17 Sep 2026 10:21:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87379a2e079sm1447408b3a.31.2026.09.17.10.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:21:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Tomasz Duszynski <tduszynski@marvell.com>, Wei Hu <weh@microsoft.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Liang Ma <liangma@bytedance.com>,
 Peter Mccarthy <peter.mccarthy@intel.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>, Gaetan Rivet <grive@u256.net>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 Martin Spinler <spinler@cesnet.cz>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jie Liu <liujie5@linkdatatechnology.com>,
 Maciej Czekaj <mczekaj@marvell.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran <ran.ming@zte.com.cn>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Marat Khalili <qm2k21@gmail.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Elena Agostini <eagostini@nvidia.com>,
 Volodymyr Fialko <vfialko@marvell.com>
Subject: [PATCH 3/6] build: use rte_queue.h instead of sys/queue.h
Date: Thu, 17 Sep 2026 10:19:41 -0700
Message-ID: <20260917172116.660120-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917172116.660120-1-stephen@networkplumber.org>
References: <20260917172116.660120-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace every direct include of <sys/queue.h> with <rte_queue.h> and
remove the Windows stub left by the previous commit, so that all
platforms get the same set of list macros.

This has to be done in one step rather than one subsystem at a time.
Both headers use the same multiple inclusion guard, deliberately, so
that this header and a system <sys/queue.h> pulled in by an application
suppress each other instead of defining the same macros twice. The
consequence in tree is that a single remaining direct include, whether
in the file itself or reached through another header, silently turns
rte_queue.h into a no-op for that whole translation unit.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c                                    |  2 +-
 app/proc-info/main.c                                  |  2 +-
 app/test-bbdev/main.h                                 |  2 +-
 app/test-cmdline/cmdline_test.c                       |  2 +-
 app/test-eventdev/evt_test.c                          |  2 +-
 app/test-eventdev/evt_test.h                          |  2 +-
 app/test-mldev/ml_test.h                              |  2 +-
 app/test-pipeline/config.c                            |  2 +-
 app/test-pipeline/init.c                              |  2 +-
 app/test-pipeline/main.c                              |  2 +-
 app/test-pipeline/runtime.c                           |  2 +-
 app/test-pmd/5tswap.c                                 |  2 +-
 app/test-pmd/cmdline.c                                |  2 +-
 app/test-pmd/config.c                                 |  2 +-
 app/test-pmd/csumonly.c                               |  2 +-
 app/test-pmd/flowgen.c                                |  2 +-
 app/test-pmd/hairpin.c                                |  2 +-
 app/test-pmd/icmpecho.c                               |  2 +-
 app/test-pmd/iofwd.c                                  |  2 +-
 app/test-pmd/macfwd.c                                 |  2 +-
 app/test-pmd/macswap.c                                |  2 +-
 app/test-pmd/noisy_vnf.c                              |  2 +-
 app/test-pmd/parameters.c                             |  2 +-
 app/test-pmd/rxonly.c                                 |  2 +-
 app/test-pmd/testpmd.c                                |  2 +-
 app/test-pmd/testpmd.h                                |  2 +-
 app/test-pmd/txonly.c                                 |  2 +-
 app/test/commands.c                                   |  2 +-
 app/test/test.c                                       |  2 +-
 app/test/test.h                                       |  2 +-
 app/test/test_atomic.c                                |  2 +-
 app/test/test_cmdline_lib.c                           |  2 +-
 app/test/test_func_reentrancy.c                       |  2 +-
 app/test/test_hash.c                                  |  2 +-
 app/test/test_hash_functions.c                        |  2 +-
 app/test/test_link_bonding.c                          |  2 +-
 app/test/test_link_bonding_mode4.c                    |  2 +-
 app/test/test_link_bonding_rssconf.c                  |  2 +-
 app/test/test_logs.c                                  |  2 +-
 app/test/test_malloc.c                                |  2 +-
 app/test/test_mbuf.c                                  |  2 +-
 app/test/test_mcslock.c                               |  2 +-
 app/test/test_mempool.c                               |  2 +-
 app/test/test_mempool_perf.c                          |  2 +-
 app/test/test_memzone.c                               |  2 +-
 app/test/test_mp_secondary.c                          |  2 +-
 app/test/test_per_lcore.c                             |  2 +-
 app/test/test_pflock.c                                |  2 +-
 app/test/test_ring.c                                  |  2 +-
 app/test/test_rwlock.c                                |  2 +-
 app/test/test_soring.c                                |  2 +-
 app/test/test_spinlock.c                              |  2 +-
 app/test/test_tailq.c                                 |  2 +-
 app/test/test_ticketlock.c                            |  2 +-
 app/test/test_timer.c                                 |  2 +-
 drivers/bus/auxiliary/auxiliary_common.c              |  2 +-
 drivers/bus/auxiliary/private.h                       |  2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h                  |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c              |  2 +-
 drivers/bus/ifpga/ifpga_bus.c                         |  2 +-
 drivers/bus/pci/bsd/pci.c                             |  2 +-
 drivers/bus/pci/pci_common.c                          |  2 +-
 drivers/bus/pci/pci_params.c                          |  2 +-
 drivers/bus/pci/windows/pci.c                         |  2 +-
 drivers/bus/pci/windows/pci_netuio.c                  |  2 +-
 drivers/bus/platform/platform.c                       |  2 +-
 drivers/bus/vdev/vdev.c                               |  2 +-
 drivers/bus/vmbus/vmbus_common.c                      |  2 +-
 drivers/common/cnxk/roc_bphy_irq.c                    |  1 -
 drivers/common/cnxk/roc_npc.h                         |  2 --
 drivers/common/cnxk/roc_platform.h                    |  1 +
 drivers/common/mlx5/mlx5_common_mr.h                  |  2 +-
 drivers/crypto/bcmfs/bcmfs_device.c                   |  2 +-
 drivers/crypto/bcmfs/bcmfs_device.h                   |  2 +-
 drivers/crypto/ccp/ccp_crypto.c                       |  2 +-
 drivers/crypto/ccp/ccp_dev.c                          |  2 +-
 drivers/event/dlb2/dlb2_selftest.c                    |  2 +-
 drivers/event/opdl/opdl_test.c                        |  2 +-
 drivers/event/sw/sw_evdev_selftest.c                  |  2 +-
 drivers/net/axgbe/axgbe_common.h                      |  2 +-
 drivers/net/bnx2x/bnx2x_ethdev.h                      |  2 +-
 drivers/net/bnxt/bnxt.h                               |  2 +-
 drivers/net/bnxt/bnxt_filter.c                        |  2 +-
 drivers/net/bnxt/bnxt_flow.c                          |  2 +-
 drivers/net/bnxt/bnxt_vnic.h                          |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h                    |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c              |  2 +-
 drivers/net/bonding/eth_bond_private.h                |  2 +-
 drivers/net/bonding/rte_eth_bond_flow.c               |  2 +-
 drivers/net/cxgbe/cxgbe_ethdev.c                      |  2 +-
 drivers/net/cxgbe/cxgbe_main.c                        |  2 +-
 drivers/net/cxgbe/sge.c                               |  2 +-
 drivers/net/dpaa2/dpaa2_flow.c                        |  2 +-
 drivers/net/dpaa2/dpaa2_mux.c                         |  2 +-
 drivers/net/dpaa2/dpaa2_ptp.c                         |  2 +-
 drivers/net/enic/enic.h                               |  2 +-
 drivers/net/failsafe/failsafe_flow.c                  |  2 +-
 drivers/net/failsafe/failsafe_private.h               |  2 +-
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c         |  2 +-
 drivers/net/intel/e1000/e1000_ethdev.h                |  2 +-
 drivers/net/intel/e1000/em_ethdev.c                   |  2 +-
 drivers/net/intel/e1000/em_rxtx.c                     |  2 +-
 drivers/net/intel/e1000/igb_ethdev.c                  |  2 +-
 drivers/net/intel/e1000/igb_flow.c                    |  2 +-
 drivers/net/intel/e1000/igb_rxtx.c                    |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.h                  |  2 +-
 drivers/net/intel/i40e/i40e_fdir.c                    |  2 +-
 drivers/net/intel/i40e/i40e_flow.c                    |  2 +-
 drivers/net/intel/i40e/i40e_hash.c                    |  2 +-
 drivers/net/intel/i40e/i40e_pf.c                      |  2 +-
 drivers/net/intel/i40e/i40e_rxtx.c                    |  2 +-
 drivers/net/intel/iavf/iavf.h                         |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c                  |  2 +-
 drivers/net/intel/iavf/iavf_fdir.c                    |  2 +-
 drivers/net/intel/iavf/iavf_fsub.c                    |  2 +-
 drivers/net/intel/iavf/iavf_generic_flow.c            |  2 +-
 drivers/net/intel/iavf/iavf_hash.c                    |  2 +-
 drivers/net/intel/iavf/iavf_rxtx.c                    |  2 +-
 drivers/net/intel/ice/base/ice_osdep.h                |  2 +-
 drivers/net/intel/ice/ice_acl_filter.c                |  2 +-
 drivers/net/intel/ice/ice_dcf.c                       |  2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c                |  2 +-
 drivers/net/intel/ice/ice_generic_flow.c              |  2 +-
 drivers/net/intel/ice/ice_hash.c                      |  2 +-
 drivers/net/intel/ice/ice_switch_filter.c             |  2 +-
 drivers/net/intel/idpf/base/idpf_osdep.h              |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h              |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_flow.c                |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c                |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h                |  2 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c                  |  2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c                  |  2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c                  |  2 +-
 drivers/net/memif/memif_socket.h                      |  2 +-
 drivers/net/memif/rte_eth_memif.h                     |  2 +-
 drivers/net/mlx4/mlx4.h                               |  2 +-
 drivers/net/mlx4/mlx4_flow.c                          |  2 +-
 drivers/net/mlx4/mlx4_flow.h                          |  2 +-
 drivers/net/mlx4/mlx4_mr.h                            |  2 +-
 drivers/net/mlx4/mlx4_rxtx.h                          |  2 +-
 drivers/net/mlx5/hws/mlx5dr_internal.h                |  2 +-
 drivers/net/mlx5/linux/mlx5_verbs.c                   |  2 +-
 drivers/net/mlx5/mlx5.h                               |  2 +-
 drivers/net/mlx5/mlx5_devx.c                          |  2 +-
 drivers/net/mlx5/mlx5_driver_event.c                  |  2 +-
 drivers/net/mlx5/mlx5_flow.c                          |  2 +-
 drivers/net/mlx5/mlx5_flow.h                          |  2 +-
 drivers/net/mlx5/mlx5_flow_dv.c                       |  2 +-
 drivers/net/mlx5/mlx5_flow_verbs.c                    |  2 +-
 drivers/net/mlx5/mlx5_rx.h                            |  2 +-
 drivers/net/mlx5/mlx5_rxq.c                           |  2 +-
 drivers/net/mlx5/mlx5_rxtx.h                          |  2 +-
 drivers/net/mlx5/mlx5_tx.h                            |  2 +-
 drivers/net/nfb/nfb_ethdev.c                          |  2 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c                     |  2 +-
 drivers/net/ngbe/ngbe_rxtx.c                          |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c                      |  2 +-
 drivers/net/qede/qede_ethdev.h                        |  2 +-
 drivers/net/sfc/sfc_dp.c                              |  2 +-
 drivers/net/sfc/sfc_dp.h                              |  2 +-
 drivers/net/softnic/rte_eth_softnic_internals.h       |  2 +-
 drivers/net/sxe2/sxe2_flow.c                          |  2 +-
 drivers/net/tap/rte_eth_tap.h                         |  2 +-
 drivers/net/tap/tap_flow.c                            |  2 +-
 drivers/net/thunderx/base/nicvf_bsvf.h                |  2 +-
 drivers/net/thunderx/nicvf_ethdev.c                   |  2 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c                   |  2 +-
 drivers/net/txgbe/txgbe_fdir.c                        |  2 +-
 drivers/net/txgbe/txgbe_flow.c                        |  2 +-
 drivers/net/txgbe/txgbe_rxtx.c                        |  2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c                 |  2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c                  |  2 +-
 drivers/net/vmxnet3/vmxnet3_rxtx.c                    |  2 +-
 drivers/net/zxdh/zxdh_flow.c                          |  2 +-
 drivers/net/zxdh/zxdh_flow.h                          |  2 +-
 drivers/net/zxdh/zxdh_mtr.h                           |  2 +-
 drivers/raw/ifpga/base/opae_hw_api.h                  |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.h                         |  2 +-
 drivers/vdpa/sfc/sfc_vdpa.c                           |  2 +-
 drivers/vdpa/sfc/sfc_vdpa.h                           |  2 +-
 examples/bbdev_app/main.c                             |  2 +-
 examples/bond/main.c                                  |  2 +-
 examples/cmdline/main.c                               |  2 +-
 examples/cmdline/parse_obj_list.h                     |  2 +-
 examples/flow_filtering/main.c                        |  2 +-
 examples/helloworld/main.c                            |  2 +-
 examples/ip_fragmentation/main.c                      |  2 +-
 examples/ip_pipeline/action.h                         |  2 +-
 examples/ip_pipeline/cryptodev.h                      |  2 +-
 examples/ip_pipeline/link.h                           |  2 +-
 examples/ip_pipeline/mempool.h                        |  2 +-
 examples/ip_pipeline/pipeline.h                       |  2 +-
 examples/ip_pipeline/swq.h                            |  2 +-
 examples/ip_pipeline/tap.h                            |  2 +-
 examples/ip_pipeline/tmgr.h                           |  2 +-
 examples/ip_reassembly/main.c                         |  2 +-
 examples/ipsec-secgw/ipsec-secgw.c                    |  2 +-
 examples/ipv4_multicast/main.c                        |  2 +-
 examples/l2fwd-crypto/main.c                          |  2 +-
 examples/l2fwd-event/l2fwd_common.h                   |  2 +-
 examples/l2fwd-keepalive/ka-agent/main.c              |  2 +-
 examples/l2fwd-keepalive/main.c                       |  2 +-
 examples/l2fwd-macsec/main.c                          |  2 +-
 examples/l2fwd/main.c                                 |  2 +-
 examples/l3fwd-graph/main.c                           |  2 +-
 examples/l3fwd-power/main.c                           |  2 +-
 examples/l3fwd/l3fwd_em.c                             |  2 +-
 examples/l3fwd/l3fwd_lpm.c                            |  2 +-
 examples/l3fwd/main.c                                 |  2 +-
 examples/link_status_interrupt/main.c                 |  2 +-
 .../multi_process/client_server_mp/mp_client/client.c |  2 +-
 .../multi_process/client_server_mp/mp_server/init.c   |  2 +-
 .../multi_process/client_server_mp/mp_server/main.c   |  2 +-
 examples/multi_process/hotplug_mp/main.c              |  2 +-
 examples/multi_process/simple_mp/main.c               |  2 +-
 examples/multi_process/symmetric_mp/main.c            |  2 +-
 examples/server_node_efd/efd_node/node.c              |  2 +-
 examples/server_node_efd/efd_server/init.c            |  2 +-
 examples/server_node_efd/efd_server/main.c            |  2 +-
 examples/service_cores/main.c                         |  2 +-
 examples/timer/main.c                                 |  2 +-
 examples/vhost/main.h                                 |  2 +-
 examples/vm_power_manager/channel_manager.c           |  2 +-
 examples/vm_power_manager/channel_monitor.c           |  2 +-
 examples/vm_power_manager/main.c                      |  2 +-
 examples/vmdq/main.c                                  |  2 +-
 examples/vmdq_dcb/main.c                              |  2 +-
 lib/acl/rte_acl_osdep.h                               |  2 +-
 lib/bbdev/rte_bbdev.c                                 |  2 +-
 lib/bpf/bpf_load_elf.c                                |  2 +-
 lib/bpf/bpf_pkt.c                                     |  2 +-
 lib/cryptodev/cryptodev_pmd.c                         |  2 +-
 lib/cryptodev/rte_cryptodev.c                         |  2 +-
 lib/distributor/rte_distributor.c                     |  2 +-
 lib/distributor/rte_distributor_single.c              |  2 +-
 lib/eal/common/eal_common_bus.c                       |  2 +-
 lib/eal/common/eal_common_class.c                     |  2 +-
 lib/eal/common/eal_common_dev.c                       |  2 +-
 lib/eal/common/eal_common_options.c                   |  2 +-
 lib/eal/common/eal_common_tailqs.c                    |  2 +-
 lib/eal/common/eal_common_trace.c                     |  2 +-
 lib/eal/common/eal_private.h                          |  2 +-
 lib/eal/common/malloc_elem.c                          |  2 +-
 lib/eal/common/malloc_heap.c                          |  2 +-
 lib/eal/common/malloc_heap.h                          |  2 +-
 lib/eal/common/rte_malloc.c                           |  2 +-
 lib/eal/freebsd/eal.c                                 |  2 +-
 lib/eal/freebsd/eal_interrupts.c                      |  2 +-
 lib/eal/freebsd/eal_thread.c                          |  2 +-
 lib/eal/freebsd/include/rte_os.h                      |  2 +-
 lib/eal/linux/eal_alarm.c                             |  2 +-
 lib/eal/linux/eal_interrupts.c                        |  2 +-
 lib/eal/linux/include/rte_os.h                        |  2 +-
 lib/eal/windows/eal_alarm.c                           |  2 +-
 lib/eal/windows/include/sys/queue.h                   | 11 -----------
 lib/efd/rte_efd.c                                     |  2 +-
 lib/ethdev/ethdev_private.h                           |  2 +-
 lib/ethdev/rte_ethdev.c                               |  2 +-
 lib/fib/rte_fib.c                                     |  2 +-
 lib/fib/rte_fib6.c                                    |  2 +-
 lib/gpudev/gpudev.c                                   |  2 +-
 lib/graph/graph_private.h                             |  2 +-
 lib/hash/rte_cuckoo_hash.c                            |  2 +-
 lib/hash/rte_fbk_hash.c                               |  2 +-
 lib/hash/rte_thash.c                                  |  2 +-
 lib/ip_frag/ip_frag_common.h                          |  2 +-
 lib/log/log.c                                         |  2 +-
 lib/lpm/rte_lpm.c                                     |  2 +-
 lib/lpm/rte_lpm6.c                                    |  2 +-
 lib/mbuf/rte_mbuf_dyn.c                               |  2 +-
 lib/mempool/rte_mempool.c                             |  2 +-
 lib/pipeline/rte_swx_ctl.c                            |  2 +-
 lib/pipeline/rte_swx_pipeline_internal.h              |  2 +-
 lib/pmu/pmu.c                                         |  2 +-
 lib/reorder/rte_reorder.c                             |  2 +-
 lib/rib/rte_rib.c                                     |  2 +-
 lib/rib/rte_rib6.c                                    |  2 +-
 lib/ring/rte_ring.c                                   |  2 +-
 lib/stack/rte_stack.c                                 |  2 +-
 lib/vhost/fd_man.h                                    |  2 +-
 lib/vhost/socket.c                                    |  2 +-
 lib/vhost/vdpa.c                                      |  2 +-
 lib/vhost/vhost.h                                     |  2 +-
 283 files changed, 280 insertions(+), 293 deletions(-)
 delete mode 100644 lib/eal/windows/include/sys/queue.h

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..8869c1e974 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -17,7 +17,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/types.h>
 #include <sys/utsname.h>
 #include <time.h>
diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 5925bbb765..4ad19456c0 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -9,7 +9,7 @@
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <unistd.h>
diff --git a/app/test-bbdev/main.h b/app/test-bbdev/main.h
index dc10a505d1..bcaee46317 100644
--- a/app/test-bbdev/main.h
+++ b/app/test-bbdev/main.h
@@ -6,7 +6,7 @@
 #define _MAIN_H_
 
 #include <stddef.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_hexdump.h>
diff --git a/app/test-cmdline/cmdline_test.c b/app/test-cmdline/cmdline_test.c
index 21b4a4278d..4d2555e24a 100644
--- a/app/test-cmdline/cmdline_test.c
+++ b/app/test-cmdline/cmdline_test.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test-eventdev/evt_test.c b/app/test-eventdev/evt_test.c
index 72d6228bc3..1ca8062296 100644
--- a/app/test-eventdev/evt_test.c
+++ b/app/test-eventdev/evt_test.c
@@ -4,7 +4,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "evt_test.h"
 
diff --git a/app/test-eventdev/evt_test.h b/app/test-eventdev/evt_test.h
index ad3f531dcf..25ab3a4e85 100644
--- a/app/test-eventdev/evt_test.h
+++ b/app/test-eventdev/evt_test.h
@@ -7,7 +7,7 @@
 
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_eal.h>
 
diff --git a/app/test-mldev/ml_test.h b/app/test-mldev/ml_test.h
index f35fa8aadb..1099c8dcf1 100644
--- a/app/test-mldev/ml_test.h
+++ b/app/test-mldev/ml_test.h
@@ -8,7 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test-pipeline/config.c b/app/test-pipeline/config.c
index daf838948b..e7806a6a32 100644
--- a/app/test-pipeline/config.c
+++ b/app/test-pipeline/config.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/init.c b/app/test-pipeline/init.c
index 558f0e428d..1701c613c9 100644
--- a/app/test-pipeline/init.c
+++ b/app/test-pipeline/init.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pipeline/main.c b/app/test-pipeline/main.c
index e5efafdf28..fac4f880c4 100644
--- a/app/test-pipeline/main.c
+++ b/app/test-pipeline/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <signal.h>
 #include <errno.h>
diff --git a/app/test-pipeline/runtime.c b/app/test-pipeline/runtime.c
index 752f783370..55654d71b7 100644
--- a/app/test-pipeline/runtime.c
+++ b/app/test-pipeline/runtime.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/app/test-pmd/5tswap.c b/app/test-pmd/5tswap.c
index 8e8de2557a..ad212982af 100644
--- a/app/test-pmd/5tswap.c
+++ b/app/test-pmd/5tswap.c
@@ -8,7 +8,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 10ee7c5179..f0a2b5a2b3 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13,7 +13,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_byteorder.h>
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index aa03eb99cc..0264b57b3b 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -13,7 +13,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index c841651756..7471ba1f7a 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/flowgen.c b/app/test-pmd/flowgen.c
index 8dac7b9209..d24b6fb279 100644
--- a/app/test-pmd/flowgen.c
+++ b/app/test-pmd/flowgen.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/hairpin.c b/app/test-pmd/hairpin.c
index 5e6b37974e..2793b3698c 100644
--- a/app/test-pmd/hairpin.c
+++ b/app/test-pmd/hairpin.c
@@ -8,7 +8,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "testpmd.h"
 
diff --git a/app/test-pmd/icmpecho.c b/app/test-pmd/icmpecho.c
index c87b7a80df..a9ada63b9c 100644
--- a/app/test-pmd/icmpecho.c
+++ b/app/test-pmd/icmpecho.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/iofwd.c b/app/test-pmd/iofwd.c
index ba06fae4a6..de28cb52a1 100644
--- a/app/test-pmd/iofwd.c
+++ b/app/test-pmd/iofwd.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/macfwd.c b/app/test-pmd/macfwd.c
index d19ace7395..ad2efb08e8 100644
--- a/app/test-pmd/macfwd.c
+++ b/app/test-pmd/macfwd.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/macswap.c b/app/test-pmd/macswap.c
index 57f77003fe..a000e2db6a 100644
--- a/app/test-pmd/macswap.c
+++ b/app/test-pmd/macswap.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/noisy_vnf.c b/app/test-pmd/noisy_vnf.c
index 81d1187cfe..060e3c25b1 100644
--- a/app/test-pmd/noisy_vnf.c
+++ b/app/test-pmd/noisy_vnf.c
@@ -12,7 +12,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 0032ea4e25..8bcaaf74be 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -13,7 +13,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <stdint.h>
diff --git a/app/test-pmd/rxonly.c b/app/test-pmd/rxonly.c
index 315f9286cd..cf568742a1 100644
--- a/app/test-pmd/rxonly.c
+++ b/app/test-pmd/rxonly.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index cab2fa1556..506ace6998 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -16,7 +16,7 @@
 #include <errno.h>
 #include <stdbool.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <stdint.h>
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 083171853c..657dd341f4 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -21,7 +21,7 @@
 #include <cmdline.h>
 #include <cmdline_parse.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #ifdef RTE_HAS_JANSSON
 #include <jansson.h>
 #endif
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index a4acb85d29..4f62ff76a4 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/app/test/commands.c b/app/test/commands.c
index 497d8e9952..516297e411 100644
--- a/app/test/commands.c
+++ b/app/test/commands.c
@@ -10,7 +10,7 @@
 #include <stdlib.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test.c b/app/test/test.c
index c610c3588e..eb992c2409 100644
--- a/app/test/test.c
+++ b/app/test/test.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <cmdline_rdline.h>
 #include <cmdline_parse.h>
diff --git a/app/test/test.h b/app/test/test.h
index b29233bb32..311505170e 100644
--- a/app/test/test.h
+++ b/app/test/test.h
@@ -12,7 +12,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_bitops.h>
 #include <rte_common.h>
diff --git a/app/test/test_atomic.c b/app/test/test_atomic.c
index 2a4531b833..31a3f48614 100644
--- a/app/test/test_atomic.c
+++ b/app/test/test_atomic.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_common.h>
diff --git a/app/test/test_cmdline_lib.c b/app/test/test_cmdline_lib.c
index 87c1059366..20200cafaa 100644
--- a/app/test/test_cmdline_lib.c
+++ b/app/test/test_cmdline_lib.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test/test_func_reentrancy.c b/app/test/test_func_reentrancy.c
index ce55ab991e..bd2ecd0597 100644
--- a/app/test/test_func_reentrancy.c
+++ b/app/test/test_func_reentrancy.c
@@ -9,7 +9,7 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 640a33e16c..16316b1b0b 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -8,7 +8,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_malloc.h>
diff --git a/app/test/test_hash_functions.c b/app/test/test_hash_functions.c
index 70820d1f19..890108138f 100644
--- a/app/test/test_hash_functions.c
+++ b/app/test/test_hash_functions.c
@@ -8,7 +8,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_cycles.h>
 #include <rte_random.h>
diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771a..57cf1f775b 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -11,7 +11,7 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <pthread.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/time.h>
 
 #include <rte_cycles.h>
diff --git a/app/test/test_link_bonding_mode4.c b/app/test/test_link_bonding_mode4.c
index ff13dbed93..b806a2639f 100644
--- a/app/test/test_link_bonding_mode4.c
+++ b/app/test/test_link_bonding_mode4.c
@@ -10,7 +10,7 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <rte_cycles.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_byteorder.h>
 #include <rte_common.h>
diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bonding_rssconf.c
index 693b0ccd12..239677e4d1 100644
--- a/app/test/test_link_bonding_rssconf.c
+++ b/app/test/test_link_bonding_rssconf.c
@@ -10,7 +10,7 @@
 #include <inttypes.h>
 #include <errno.h>
 #include <rte_cycles.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_byteorder.h>
 #include <rte_common.h>
diff --git a/app/test/test_logs.c b/app/test/test_logs.c
index 375b06a1b7..0301a8657a 100644
--- a/app/test/test_logs.c
+++ b/app/test/test_logs.c
@@ -5,7 +5,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdarg.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_log.h>
 #include <rte_memory.h>
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index da868c8091..319e724dbd 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -13,7 +13,7 @@
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <sys/mman.h>
 #endif
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_mbuf.c b/app/test/test_mbuf.c
index db23259745..808bb1cd4c 100644
--- a/app/test/test_mbuf.c
+++ b/app/test/test_mbuf.c
@@ -12,7 +12,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_errno.h>
diff --git a/app/test/test_mcslock.c b/app/test/test_mcslock.c
index b182da72f1..303e910809 100644
--- a/app/test/test_mcslock.c
+++ b/app/test/test_mcslock.c
@@ -7,7 +7,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..2ad52d6469 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -9,7 +9,7 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_eal_paging.h>
diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index e164eca788..ebd9cd7b9b 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -10,7 +10,7 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 8712690561..a90ef9a41a 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_random.h>
 #include <rte_cycles.h>
diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index d89419c253..60638c4501 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -10,7 +10,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
index 6e7ba072fd..ffb14c8212 100644
--- a/app/test/test_per_lcore.c
+++ b/app/test/test_per_lcore.c
@@ -4,7 +4,7 @@
 
 #include <stdio.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/app/test/test_pflock.c b/app/test/test_pflock.c
index 4164a42789..a42952a882 100644
--- a/app/test/test_pflock.c
+++ b/app/test/test_pflock.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <string.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index 015623659f..9f9f241967 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -10,7 +10,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_rwlock.c b/app/test/test_rwlock.c
index a2f37add34..29aac6a588 100644
--- a/app/test/test_rwlock.c
+++ b/app/test/test_rwlock.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <string.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_soring.c b/app/test/test_soring.c
index 8ae63aa78e..33e1490690 100644
--- a/app/test/test_soring.c
+++ b/app/test/test_soring.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_log.h>
diff --git a/app/test/test_spinlock.c b/app/test/test_spinlock.c
index a2ac5df427..f9c59ba4b3 100644
--- a/app/test/test_spinlock.c
+++ b/app/test/test_spinlock.c
@@ -7,7 +7,7 @@
 #include <inttypes.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/app/test/test_tailq.c b/app/test/test_tailq.c
index 34bde52c03..013617736e 100644
--- a/app/test/test_tailq.c
+++ b/app/test/test_tailq.c
@@ -7,7 +7,7 @@
 #include <stdarg.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_eal.h>
 #include <rte_string_fns.h>
diff --git a/app/test/test_ticketlock.c b/app/test/test_ticketlock.c
index 22d17e259b..359984c2b8 100644
--- a/app/test/test_ticketlock.c
+++ b/app/test/test_ticketlock.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <rte_common.h>
diff --git a/app/test/test_timer.c b/app/test/test_timer.c
index c936843ddc..1e24377f56 100644
--- a/app/test/test_timer.c
+++ b/app/test/test_timer.c
@@ -91,7 +91,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <math.h>
 
 #include <rte_common.h>
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 016d124f0b..ce7ba19be6 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -8,7 +8,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_interrupts.h>
diff --git a/drivers/bus/auxiliary/private.h b/drivers/bus/auxiliary/private.h
index 282ad94618..f65e7dabf5 100644
--- a/drivers/bus/auxiliary/private.h
+++ b/drivers/bus/auxiliary/private.h
@@ -7,7 +7,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <bus_driver.h>
 
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 44f81cf662..9b3bdea2de 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -17,7 +17,7 @@
 #include <stdlib.h>
 #include <limits.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdint.h>
 #include <inttypes.h>
 
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e17050b625..9dbf5f413e 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -17,7 +17,6 @@
 #include <signal.h>
 #include <pthread.h>
 #include <sys/types.h>
-#include <sys/queue.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -26,6 +25,7 @@
 #include <sys/syscall.h>
 
 #include <eal_export.h>
+#include <rte_queue.h>
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 79d1c3778f..0492200cba 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <unistd.h>
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index c6df31d486..49874770fb 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -15,7 +15,7 @@
 #include <errno.h>
 #include <dirent.h>
 #include <limits.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/mman.h>
 #include <sys/ioctl.h>
 #include <sys/pciio.h>
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index dc8db80d3b..d79bca51db 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -9,7 +9,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <eal_export.h>
 #include <rte_errno.h>
 #include <rte_interrupts.h>
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index 6cbd98b4c8..c1e11c9c04 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -2,7 +2,7 @@
  * Copyright 2018 Gaëtan Rivet
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <bus_driver.h>
 #include <rte_bus_pci.h>
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index 7b51301d1e..6389fe9baf 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -2,7 +2,7 @@
  * Copyright 2020 Mellanox Technologies, Ltd
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_windows.h>
diff --git a/drivers/bus/pci/windows/pci_netuio.c b/drivers/bus/pci/windows/pci_netuio.c
index 346b2f4c0a..390a0fe16e 100644
--- a/drivers/bus/pci/windows/pci_netuio.c
+++ b/drivers/bus/pci/windows/pci_netuio.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_windows.h>
 #include <rte_errno.h>
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 90d865a8df..ff90cae0b6 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -10,7 +10,7 @@
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <bus_driver.h>
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 02d719a44d..04702a7270 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -8,7 +8,7 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_os_shim.h>
 #include <eal_export.h>
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 4c64856abb..62df339af1 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -7,7 +7,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <fcntl.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/mman.h>
 
 #include <eal_export.h>
diff --git a/drivers/common/cnxk/roc_bphy_irq.c b/drivers/common/cnxk/roc_bphy_irq.c
index 7b39b61537..b136d1b885 100644
--- a/drivers/common/cnxk/roc_bphy_irq.c
+++ b/drivers/common/cnxk/roc_bphy_irq.c
@@ -5,7 +5,6 @@
 #include <pthread.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
 #include <unistd.h>
 
 #include "roc_api.h"
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index a7254f35ca..3814340d2c 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -5,8 +5,6 @@
 #ifndef _ROC_NPC_H_
 #define _ROC_NPC_H_
 
-#include <sys/queue.h>
-
 enum roc_npc_item_type {
 	ROC_NPC_ITEM_TYPE_VOID,
 	ROC_NPC_ITEM_TYPE_ANY,
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index ac4f76473f..24f0c41cbf 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -20,6 +20,7 @@
 #include <rte_malloc.h>
 #include <rte_memzone.h>
 #include <rte_pci.h>
+#include <rte_queue.h>
 #include <rte_seqcount.h>
 #include <rte_spinlock.h>
 #include <rte_string_fns.h>
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index 5fb931a1b5..17faaf77ec 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -8,7 +8,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 
 #include <rte_compat.h>
diff --git a/drivers/crypto/bcmfs/bcmfs_device.c b/drivers/crypto/bcmfs/bcmfs_device.c
index 46522970d5..fc2fa42bab 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.c
+++ b/drivers/crypto/bcmfs/bcmfs_device.c
@@ -6,7 +6,7 @@
 #include <dirent.h>
 #include <stdbool.h>
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_malloc.h>
 #include <rte_string_fns.h>
diff --git a/drivers/crypto/bcmfs/bcmfs_device.h b/drivers/crypto/bcmfs/bcmfs_device.h
index 610454dd5e..2c04fbadd4 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.h
+++ b/drivers/crypto/bcmfs/bcmfs_device.h
@@ -6,7 +6,7 @@
 #ifndef _BCMFS_DEVICE_H_
 #define _BCMFS_DEVICE_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_spinlock.h>
 #include <bus_vdev_driver.h>
diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index b07a786d8e..f61fa5f4f3 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -9,7 +9,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <openssl/sha.h>
diff --git a/drivers/crypto/ccp/ccp_dev.c b/drivers/crypto/ccp/ccp_dev.c
index 5088d8ded6..21e5efbb03 100644
--- a/drivers/crypto/ccp/ccp_dev.c
+++ b/drivers/crypto/ccp/ccp_dev.c
@@ -7,7 +7,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/types.h>
 #include <sys/file.h>
 #include <unistd.h>
diff --git a/drivers/event/dlb2/dlb2_selftest.c b/drivers/event/dlb2/dlb2_selftest.c
index 87d98700c9..f37a35b97d 100644
--- a/drivers/event/dlb2/dlb2_selftest.c
+++ b/drivers/event/dlb2/dlb2_selftest.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/event/opdl/opdl_test.c b/drivers/event/opdl/opdl_test.c
index 9b0c4db5ce..0c07d36b55 100644
--- a/drivers/event/opdl/opdl_test.c
+++ b/drivers/event/opdl/opdl_test.c
@@ -8,7 +8,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_memzone.h>
diff --git a/drivers/event/sw/sw_evdev_selftest.c b/drivers/event/sw/sw_evdev_selftest.c
index a2ce14051c..6f935fb495 100644
--- a/drivers/event/sw/sw_evdev_selftest.c
+++ b/drivers/event/sw/sw_evdev_selftest.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_common.h
index 842077d972..51dfa51a2f 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -10,7 +10,7 @@
 
 #include <stdbool.h>
 #include <limits.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/drivers/net/bnx2x/bnx2x_ethdev.h b/drivers/net/bnx2x/bnx2x_ethdev.h
index fa1c3ba955..e69ab03c6d 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.h
+++ b/drivers/net/bnx2x/bnx2x_ethdev.h
@@ -8,7 +8,7 @@
 #ifndef PMD_BNX2X_ETHDEV_H
 #define PMD_BNX2X_ETHDEV_H
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/param.h>
 #include <sys/user.h>
 #include <sys/stat.h>
diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 336de75da0..2a5ebf8eb9 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -9,7 +9,7 @@
 #include <inttypes.h>
 #include <stdbool.h>
 #include <pthread.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_pci.h>
 #include <bus_pci_driver.h>
diff --git a/drivers/net/bnxt/bnxt_filter.c b/drivers/net/bnxt/bnxt_filter.c
index 0225215dae..a4df485965 100644
--- a/drivers/net/bnxt/bnxt_filter.c
+++ b/drivers/net/bnxt/bnxt_filter.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_byteorder.h>
 #include <rte_log.h>
diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..a657f33f29 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_log.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/bnxt/bnxt_vnic.h b/drivers/net/bnxt/bnxt_vnic.h
index 5a4fd4ecb7..30d05d86f5 100644
--- a/drivers/net/bnxt/bnxt_vnic.h
+++ b/drivers/net/bnxt/bnxt_vnic.h
@@ -6,7 +6,7 @@
 #ifndef _BNXT_VNIC_H_
 #define _BNXT_VNIC_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdbool.h>
 #include <rte_hash.h>
 
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
index afd883df2c..40f1d8798f 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.h
@@ -8,7 +8,7 @@
 
 #include <inttypes.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "rte_version.h"
 #include "rte_ethdev.h"
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index 7f6a84e699..25ae45a3c7 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -4,7 +4,7 @@
  */
 
 #include <math.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_log.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/bonding/eth_bond_private.h b/drivers/net/bonding/eth_bond_private.h
index 378bbba4e6..1b7e771a33 100644
--- a/drivers/net/bonding/eth_bond_private.h
+++ b/drivers/net/bonding/eth_bond_private.h
@@ -6,7 +6,7 @@
 #define _ETH_BOND_PRIVATE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <ethdev_driver.h>
 #include <rte_flow.h>
diff --git a/drivers/net/bonding/rte_eth_bond_flow.c b/drivers/net/bonding/rte_eth_bond_flow.c
index 5d0be5caf5..b2a7d397c3 100644
--- a/drivers/net/bonding/rte_eth_bond_flow.c
+++ b/drivers/net/bonding/rte_eth_bond_flow.c
@@ -4,7 +4,7 @@
 
 #include <stddef.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_errno.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 82e67eeff1..61b3a4ce17 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/cxgbe/cxgbe_main.c b/drivers/net/cxgbe/cxgbe_main.c
index 2ed21f2d66..33ac2ef5c2 100644
--- a/drivers/net/cxgbe/cxgbe_main.c
+++ b/drivers/net/cxgbe/cxgbe_main.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..c275dee697 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 2e44bff766..e3a527813b 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -2,7 +2,7 @@
  * Copyright 2018-2022 NXP
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 9bb1bbca38..dd05253d33 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -2,7 +2,7 @@
  * Copyright 2018-2021,2023 NXP
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..067aac1a25 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -2,7 +2,7 @@
  * Copyright 2019, 2023 NXP
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/enic/enic.h b/drivers/net/enic/enic.h
index 87f6b35fcd..fbd1acf456 100644
--- a/drivers/net/enic/enic.h
+++ b/drivers/net/enic/enic.h
@@ -21,7 +21,7 @@
 #include "enic_res.h"
 #include "cq_enet_desc.h"
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <rte_spinlock.h>
 
 #define DRV_NAME		"enic_pmd"
diff --git a/drivers/net/failsafe/failsafe_flow.c b/drivers/net/failsafe/failsafe_flow.c
index 707e6c63b5..5baa11460f 100644
--- a/drivers/net/failsafe/failsafe_flow.c
+++ b/drivers/net/failsafe/failsafe_flow.c
@@ -5,7 +5,7 @@
 
 #include <stddef.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_errno.h>
 #include <rte_malloc.h>
diff --git a/drivers/net/failsafe/failsafe_private.h b/drivers/net/failsafe/failsafe_private.h
index babea6016e..82edf588a1 100644
--- a/drivers/net/failsafe/failsafe_private.h
+++ b/drivers/net/failsafe/failsafe_private.h
@@ -7,7 +7,7 @@
 #define _ETH_FAILSAFE_PRIVATE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <pthread.h>
 
 #include <rte_atomic.h>
diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
index f42156e28f..fbcb9d4d60 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/e1000_ethdev.h b/drivers/net/intel/e1000/e1000_ethdev.h
index 0907c7c259..efe88e72fe 100644
--- a/drivers/net/intel/e1000/e1000_ethdev.h
+++ b/drivers/net/intel/e1000/e1000_ethdev.h
@@ -6,7 +6,7 @@
 #define _E1000_ETHDEV_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_flow.h>
 #include <rte_time.h>
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index c02d09e500..6e233ffbd7 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index f9665127df..95813c17ee 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 524c030be6..37a25c805f 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/igb_flow.c b/drivers/net/intel/e1000/igb_flow.c
index ca76bf5ae4..ee766f2c77 100644
--- a/drivers/net/intel/e1000/igb_flow.c
+++ b/drivers/net/intel/e1000/igb_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/e1000/igb_rxtx.c b/drivers/net/intel/e1000/igb_rxtx.c
index 4fda5d57a0..e3e1ad2ffc 100644
--- a/drivers/net/intel/e1000/igb_rxtx.c
+++ b/drivers/net/intel/e1000/igb_rxtx.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 9d9bde6aeb..b2411adc64 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -6,7 +6,7 @@
 #define _I40E_ETHDEV_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_time.h>
 #include <rte_kvargs.h>
diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 8a233f8a97..6ae013f5f5 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 6eb85a7d0d..6cb5219a80 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2016-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_hash.c b/drivers/net/intel/i40e/i40e_hash.c
index 6a23e2bf7f..f24b7540f0 100644
--- a/drivers/net/intel/i40e/i40e_hash.c
+++ b/drivers/net/intel/i40e/i40e_hash.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index c76e035a42..cd6a9606c3 100644
--- a/drivers/net/intel/i40e/i40e_pf.c
+++ b/drivers/net/intel/i40e/i40e_pf.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index e29fcff661..81fcae09a6 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -10,7 +10,7 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..1701a0c18e 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -5,7 +5,7 @@
 #ifndef _IAVF_ETHDEV_H_
 #define _IAVF_ETHDEV_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_kvargs.h>
 #include <rte_tm_driver.h>
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..9add20e8df 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3,7 +3,7 @@
  */
 
 #include <ctype.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdalign.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index ea620863ca..b6cc7b6b0a 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 19ae0e2dc2..5e215b19bd 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2022 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 92ca20031c..38c1261bd9 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 9515094402..f72ab89356 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4f2ffe6188..0d2c51b17e 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -10,7 +10,7 @@
 #include <stdarg.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index 5d92cf5aa4..a407ec2df5 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -10,7 +10,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdbool.h>
 
 #include <rte_common.h>
diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 30ff1254c9..ce9f29281a 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 3b635c0822..89e438d8ac 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index c78b290b0d..afb4f0a195 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -4,7 +4,7 @@
 
 #include <errno.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 76b3800545..23076b23d9 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 7a9a4f1a04..054c1532d3 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 6f5af03f6a..2d1dfa7d7f 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
index 67bc33f2e6..207eefd100 100644
--- a/drivers/net/intel/idpf/base/idpf_osdep.h
+++ b/drivers/net/intel/idpf/base/idpf_osdep.h
@@ -10,9 +10,9 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
 #include <stdbool.h>
 
+#include <rte_queue.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
 #include <rte_memzone.h>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
index 3b8026114d..c9a49db840 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
@@ -11,7 +11,7 @@
 #include <limits.h>
 #include <net/if.h>
 #include <netinet/in.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_flow_driver.h>
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_flow.c b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
index 941d2921fb..3ee089a416 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_flow.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2019 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..a5df67b9be 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5d3243cb4d..23a17b0655 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -7,7 +7,7 @@
 
 #include <stdint.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "base/ixgbe_type.h"
 #include "base/ixgbe_dcb.h"
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b32dc54287..9c5d35c58a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_interrupts.h>
 #include <rte_log.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6868893d46..b3c4b10e75 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2016 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe..1cfa71f80a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3,7 +3,7 @@
  * Copyright 2014 6WIND S.A.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/memif/memif_socket.h b/drivers/net/memif/memif_socket.h
index b0decbb0a2..f1b262b41d 100644
--- a/drivers/net/memif/memif_socket.h
+++ b/drivers/net/memif/memif_socket.h
@@ -5,7 +5,7 @@
 #ifndef _MEMIF_SOCKET_H_
 #define _MEMIF_SOCKET_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/un.h>
 
 /**
diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_eth_memif.h
index 9c7a3a93f0..a457ae4011 100644
--- a/drivers/net/memif/rte_eth_memif.h
+++ b/drivers/net/memif/rte_eth_memif.h
@@ -5,7 +5,7 @@
 #ifndef _RTE_ETH_MEMIF_H_
 #define _RTE_ETH_MEMIF_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <ethdev_driver.h>
 #include <rte_ether.h>
diff --git a/drivers/net/mlx4/mlx4.h b/drivers/net/mlx4/mlx4.h
index f68eeb991a..fd93ec1c19 100644
--- a/drivers/net/mlx4/mlx4.h
+++ b/drivers/net/mlx4/mlx4.h
@@ -8,7 +8,7 @@
 
 #include <net/if.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_flow.c b/drivers/net/mlx4/mlx4_flow.c
index b520664d95..ec30e6ba81 100644
--- a/drivers/net/mlx4/mlx4_flow.c
+++ b/drivers/net/mlx4/mlx4_flow.c
@@ -14,7 +14,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_flow.h b/drivers/net/mlx4/mlx4_flow.h
index 5e82df6bd6..c397df8561 100644
--- a/drivers/net/mlx4/mlx4_flow.h
+++ b/drivers/net/mlx4/mlx4_flow.h
@@ -7,7 +7,7 @@
 #define RTE_PMD_MLX4_FLOW_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_mr.h b/drivers/net/mlx4/mlx4_mr.h
index 56dd73ff19..4f78551909 100644
--- a/drivers/net/mlx4/mlx4_mr.h
+++ b/drivers/net/mlx4/mlx4_mr.h
@@ -8,7 +8,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_rxtx.h b/drivers/net/mlx4/mlx4_rxtx.h
index 70f3cd8680..b189c08262 100644
--- a/drivers/net/mlx4/mlx4_rxtx.h
+++ b/drivers/net/mlx4/mlx4_rxtx.h
@@ -7,7 +7,7 @@
 #define MLX4_RXTX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx5/hws/mlx5dr_internal.h b/drivers/net/mlx5/hws/mlx5dr_internal.h
index 3c27206043..084b8608b4 100644
--- a/drivers/net/mlx5/hws/mlx5dr_internal.h
+++ b/drivers/net/mlx5/hws/mlx5dr_internal.h
@@ -6,7 +6,7 @@
 #define MLX5DR_INTERNAL_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
 #pragma GCC diagnostic ignored "-Wpedantic"
diff --git a/drivers/net/mlx5/linux/mlx5_verbs.c b/drivers/net/mlx5/linux/mlx5_verbs.c
index 103a03bd1a..a73e44a208 100644
--- a/drivers/net/mlx5/linux/mlx5_verbs.c
+++ b/drivers/net/mlx5/linux/mlx5_verbs.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "mlx5_autoconf.h"
 
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 27e6f4e31a..87d7346a00 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -10,7 +10,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <limits.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_pci.h>
 #include <rte_ether.h>
diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 4b30a4fade..8e783666ad 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -7,7 +7,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_malloc.h>
 #include <rte_common.h>
diff --git a/drivers/net/mlx5/mlx5_driver_event.c b/drivers/net/mlx5/mlx5_driver_event.c
index 89e49331c8..033b7ffd49 100644
--- a/drivers/net/mlx5/mlx5_driver_event.c
+++ b/drivers/net/mlx5/mlx5_driver_event.c
@@ -4,7 +4,7 @@
 
 #include "mlx5_driver_event.h"
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index b0eac185b5..bd0525c98e 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index 3415b4722e..0dc8696d44 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -8,7 +8,7 @@
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_alarm.h>
 #include <rte_mtr.h>
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 58ebcf87eb..0866b425b4 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -2,7 +2,7 @@
  * Copyright 2018 Mellanox Technologies, Ltd
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/drivers/net/mlx5/mlx5_flow_verbs.c b/drivers/net/mlx5/mlx5_flow_verbs.c
index bb240d38d9..4aa02e6863 100644
--- a/drivers/net/mlx5/mlx5_flow_verbs.c
+++ b/drivers/net/mlx5/mlx5_flow_verbs.c
@@ -3,7 +3,7 @@
  */
 
 #include <netinet/in.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdalign.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/drivers/net/mlx5/mlx5_rx.h b/drivers/net/mlx5/mlx5_rx.h
index cd48ee37ef..983660bee3 100644
--- a/drivers/net/mlx5/mlx5_rx.h
+++ b/drivers/net/mlx5/mlx5_rx.h
@@ -7,7 +7,7 @@
 #define RTE_PMD_MLX5_RX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 25dba7f4d9..4f58cded68 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -8,7 +8,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <fcntl.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_mbuf.h>
diff --git a/drivers/net/mlx5/mlx5_rxtx.h b/drivers/net/mlx5/mlx5_rxtx.h
index 3fa9245769..021a0b4f75 100644
--- a/drivers/net/mlx5/mlx5_rxtx.h
+++ b/drivers/net/mlx5/mlx5_rxtx.h
@@ -8,7 +8,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 682dc07718..35c4e79c2d 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -7,7 +7,7 @@
 #define RTE_PMD_MLX5_TX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index ba7c849a4b..9ad93c6766 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -5,7 +5,7 @@
  */
 
 #include <ctype.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <eal_export.h>
 #include <rte_tailq.h>
 
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index c440e02369..f4cade6881 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index a1389de9c0..0185a69dc1 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <stdint.h>
 #include <rte_ethdev.h>
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..cee77d85ac 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -13,7 +13,7 @@
 #include <ethdev_pci.h>
 #include <rte_kvargs.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "rte_spinlock.h"
 #include "ntlog.h"
diff --git a/drivers/net/qede/qede_ethdev.h b/drivers/net/qede/qede_ethdev.h
index 3015c18504..96ee713af7 100644
--- a/drivers/net/qede/qede_ethdev.h
+++ b/drivers/net/qede/qede_ethdev.h
@@ -8,7 +8,7 @@
 #ifndef _QEDE_ETHDEV_H_
 #define _QEDE_ETHDEV_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_ether.h>
 #include <ethdev_driver.h>
diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..b3b2f153b6 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -7,7 +7,7 @@
  * for Solarflare) and Solarflare Communications, Inc.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdalign.h>
 #include <string.h>
 #include <errno.h>
diff --git a/drivers/net/sfc/sfc_dp.h b/drivers/net/sfc/sfc_dp.h
index 545f0f32bf..fa88e0455a 100644
--- a/drivers/net/sfc/sfc_dp.h
+++ b/drivers/net/sfc/sfc_dp.h
@@ -11,7 +11,7 @@
 #define _SFC_DP_H
 
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_pci.h>
 
diff --git a/drivers/net/softnic/rte_eth_softnic_internals.h b/drivers/net/softnic/rte_eth_softnic_internals.h
index d3975dad10..77af9ddb1f 100644
--- a/drivers/net/softnic/rte_eth_softnic_internals.h
+++ b/drivers/net/softnic/rte_eth_softnic_internals.h
@@ -7,7 +7,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 63cfc36968..f76effe7ff 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -2,7 +2,7 @@
  * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 #include "sxe2_ethdev.h"
 #include "sxe2_flow.h"
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index f53a5ad077..74fe072c4b 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -6,7 +6,7 @@
 #ifndef _RTE_ETH_TAP_H_
 #define _RTE_ETH_TAP_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/uio.h>
 #include <inttypes.h>
 #include <limits.h>
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index a9d8e09562..2915f6da9e 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -6,7 +6,7 @@
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/resource.h>
 
 #include <rte_byteorder.h>
diff --git a/drivers/net/thunderx/base/nicvf_bsvf.h b/drivers/net/thunderx/base/nicvf_bsvf.h
index 4c7615ca99..5496353ef1 100644
--- a/drivers/net/thunderx/base/nicvf_bsvf.h
+++ b/drivers/net/thunderx/base/nicvf_bsvf.h
@@ -5,7 +5,7 @@
 #ifndef __THUNDERX_NICVF_BSVF_H__
 #define __THUNDERX_NICVF_BSVF_H__
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 struct nicvf;
 
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 6e34da7c3c..81898cc663 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -12,7 +12,7 @@
 #include <stdarg.h>
 #include <inttypes.h>
 #include <netinet/in.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_alarm.h>
 #include <rte_branch_prediction.h>
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 341f62bc75..4018955e3f 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 67f586ffc7..be0007dc99 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <rte_malloc.h>
 
 #include "txgbe_logs.h"
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 1bb0d3978c..38e6df6ec5 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
 #include <rte_flow.h>
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 794ba041a4..bc3b2d809e 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index d70da6c7c1..490abddd24 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -19,7 +19,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/socket.h>
 #include <unistd.h>
 
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index b7cf217724..6d24460578 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdalign.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/vmxnet3/vmxnet3_rxtx.c b/drivers/net/vmxnet3/vmxnet3_rxtx.c
index 552b8a9823..e9a30592b3 100644
--- a/drivers/net/vmxnet3/vmxnet3_rxtx.c
+++ b/drivers/net/vmxnet3/vmxnet3_rxtx.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2015 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/drivers/net/zxdh/zxdh_flow.c b/drivers/net/zxdh/zxdh_flow.c
index 56ac34c6e3..c138712635 100644
--- a/drivers/net/zxdh/zxdh_flow.c
+++ b/drivers/net/zxdh/zxdh_flow.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2025 ZTE Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/zxdh/zxdh_flow.h b/drivers/net/zxdh/zxdh_flow.h
index adbc6b2a15..d0c898a014 100644
--- a/drivers/net/zxdh/zxdh_flow.h
+++ b/drivers/net/zxdh/zxdh_flow.h
@@ -7,7 +7,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_arp.h>
 #include <rte_common.h>
diff --git a/drivers/net/zxdh/zxdh_mtr.h b/drivers/net/zxdh/zxdh_mtr.h
index 3efcb6b591..0d0855cf39 100644
--- a/drivers/net/zxdh/zxdh_mtr.h
+++ b/drivers/net/zxdh/zxdh_mtr.h
@@ -7,7 +7,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <rte_mtr.h>
 
 #include "zxdh_np.h"
diff --git a/drivers/raw/ifpga/base/opae_hw_api.h b/drivers/raw/ifpga/base/opae_hw_api.h
index 57750022dd..c1c7af5511 100644
--- a/drivers/raw/ifpga/base/opae_hw_api.h
+++ b/drivers/raw/ifpga/base/opae_hw_api.h
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "opae_osdep.h"
 #include "opae_intel_max10.h"
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.h b/drivers/vdpa/mlx5/mlx5_vdpa.h
index 06155d2405..a873af39e7 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.h
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.h
@@ -6,7 +6,7 @@
 #define RTE_PMD_MLX5_VDPA_H_
 
 #include <linux/virtio_net.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #ifdef PEDANTIC
 #pragma GCC diagnostic ignored "-Wpedantic"
diff --git a/drivers/vdpa/sfc/sfc_vdpa.c b/drivers/vdpa/sfc/sfc_vdpa.c
index eda111954f..1d1d89490b 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.c
+++ b/drivers/vdpa/sfc/sfc_vdpa.c
@@ -5,7 +5,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <pthread.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_devargs.h>
diff --git a/drivers/vdpa/sfc/sfc_vdpa.h b/drivers/vdpa/sfc/sfc_vdpa.h
index 2b843e563d..96b8df42be 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.h
+++ b/drivers/vdpa/sfc/sfc_vdpa.h
@@ -6,7 +6,7 @@
 #define _SFC_VDPA_H
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <bus_pci_driver.h>
 
diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 5ac70dab59..e208c187eb 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -10,7 +10,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <unistd.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <ctype.h>
 #include <errno.h>
diff --git a/examples/bond/main.c b/examples/bond/main.c
index 99359cd6fb..123c148ee8 100644
--- a/examples/bond/main.c
+++ b/examples/bond/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/socket.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/examples/cmdline/main.c b/examples/cmdline/main.c
index c04a782507..ebf9f470f7 100644
--- a/examples/cmdline/main.c
+++ b/examples/cmdline/main.c
@@ -8,7 +8,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <cmdline_rdline.h>
 #include <cmdline_parse.h>
diff --git a/examples/cmdline/parse_obj_list.h b/examples/cmdline/parse_obj_list.h
index 1223ac1e8b..befe0673d7 100644
--- a/examples/cmdline/parse_obj_list.h
+++ b/examples/cmdline/parse_obj_list.h
@@ -10,7 +10,7 @@
 /* This file is an example of extension of libcmdline. It provides an
  * example of objects stored in a list. */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <cmdline_parse.h>
 #include <cmdline_parse_string.h>
 
diff --git a/examples/flow_filtering/main.c b/examples/flow_filtering/main.c
index f2124881a0..fb2d715ec6 100644
--- a/examples/flow_filtering/main.c
+++ b/examples/flow_filtering/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/helloworld/main.c b/examples/helloworld/main.c
index 4f9a550a67..aa93796706 100644
--- a/examples/helloworld/main.c
+++ b/examples/helloworld/main.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
diff --git a/examples/ip_fragmentation/main.c b/examples/ip_fragmentation/main.c
index 132550e497..82af653262 100644
--- a/examples/ip_fragmentation/main.c
+++ b/examples/ip_fragmentation/main.c
@@ -9,7 +9,7 @@
 #include <sys/types.h>
 #include <sys/param.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/ip_pipeline/action.h b/examples/ip_pipeline/action.h
index cde17e69a3..4cf9142711 100644
--- a/examples/ip_pipeline/action.h
+++ b/examples/ip_pipeline/action.h
@@ -5,7 +5,7 @@
 #ifndef _INCLUDE_ACTION_H_
 #define _INCLUDE_ACTION_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_port_in_action.h>
 #include <rte_table_action.h>
diff --git a/examples/ip_pipeline/cryptodev.h b/examples/ip_pipeline/cryptodev.h
index d00434379e..eef1080627 100644
--- a/examples/ip_pipeline/cryptodev.h
+++ b/examples/ip_pipeline/cryptodev.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_SYM_C_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_cryptodev.h>
 
diff --git a/examples/ip_pipeline/link.h b/examples/ip_pipeline/link.h
index 34ff1149e0..31d21fc601 100644
--- a/examples/ip_pipeline/link.h
+++ b/examples/ip_pipeline/link.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_LINK_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "common.h"
 
diff --git a/examples/ip_pipeline/mempool.h b/examples/ip_pipeline/mempool.h
index bd46a11ca0..43b890366d 100644
--- a/examples/ip_pipeline/mempool.h
+++ b/examples/ip_pipeline/mempool.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_MEMPOOL_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_mempool.h>
 
diff --git a/examples/ip_pipeline/pipeline.h b/examples/ip_pipeline/pipeline.h
index 89696480fc..1a9842428c 100644
--- a/examples/ip_pipeline/pipeline.h
+++ b/examples/ip_pipeline/pipeline.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_PIPELINE_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_pipeline.h>
 #include <rte_table_action.h>
diff --git a/examples/ip_pipeline/swq.h b/examples/ip_pipeline/swq.h
index c8440ee3cd..a31f839272 100644
--- a/examples/ip_pipeline/swq.h
+++ b/examples/ip_pipeline/swq.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_SWQ_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_ring.h>
 
diff --git a/examples/ip_pipeline/tap.h b/examples/ip_pipeline/tap.h
index 0dce72fe3c..326e0cebe1 100644
--- a/examples/ip_pipeline/tap.h
+++ b/examples/ip_pipeline/tap.h
@@ -5,7 +5,7 @@
 #ifndef _INCLUDE_TAP_H_
 #define _INCLUDE_TAP_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include "common.h"
 
diff --git a/examples/ip_pipeline/tmgr.h b/examples/ip_pipeline/tmgr.h
index 1994c55bcc..8d41e982cf 100644
--- a/examples/ip_pipeline/tmgr.h
+++ b/examples/ip_pipeline/tmgr.h
@@ -6,7 +6,7 @@
 #define _INCLUDE_TMGR_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_sched.h>
 #include <rte_red.h>
diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 0814d47a66..ef6618b42b 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/ipsec-secgw/ipsec-secgw.c b/examples/ipsec-secgw/ipsec-secgw.c
index eba7560c9b..4de40b306d 100644
--- a/examples/ipsec-secgw/ipsec-secgw.c
+++ b/examples/ipsec-secgw/ipsec-secgw.c
@@ -12,7 +12,7 @@
 #include <netinet/ip.h>
 #include <netinet/ip6.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <signal.h>
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1cb621cb8b..30313fdf6a 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index 84399463da..4542e3029d 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-event/l2fwd_common.h b/examples/l2fwd-event/l2fwd_common.h
index 53774e0fe6..af3388101d 100644
--- a/examples/l2fwd-event/l2fwd_common.h
+++ b/examples/l2fwd-event/l2fwd_common.h
@@ -11,7 +11,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-keepalive/ka-agent/main.c b/examples/l2fwd-keepalive/ka-agent/main.c
index b8a755dbd5..94bb72ffbc 100644
--- a/examples/l2fwd-keepalive/ka-agent/main.c
+++ b/examples/l2fwd-keepalive/ka-agent/main.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/wait.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <time.h>
diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index 889274ddae..def3cb25c2 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <netinet/in.h>
 #include <setjmp.h>
 #include <stdarg.h>
diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..afb83e50ab 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/l2fwd/main.c b/examples/l2fwd/main.c
index 1c4a89ae90..8ea8b01c14 100644
--- a/examples/l2fwd/main.c
+++ b/examples/l2fwd/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 5f89286dce..98c4281a9e 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -15,7 +15,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <rte_branch_prediction.h>
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 705cab8f2d..5c232b74ee 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
index d8748a0edd..9191d8c3d3 100644
--- a/examples/l3fwd/l3fwd_em.c
+++ b/examples/l3fwd/l3fwd_em.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
index 2d2651e750..70cf24c2a4 100644
--- a/examples/l3fwd/l3fwd_lpm.c
+++ b/examples/l3fwd/l3fwd_lpm.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index 6866811526..f370553fb9 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -8,7 +8,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdarg.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/examples/link_status_interrupt/main.c b/examples/link_status_interrupt/main.c
index b5fac31400..10cfb58a52 100644
--- a/examples/link_status_interrupt/main.c
+++ b/examples/link_status_interrupt/main.c
@@ -8,7 +8,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <sys/types.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <setjmp.h>
 #include <stdarg.h>
 #include <ctype.h>
diff --git a/examples/multi_process/client_server_mp/mp_client/client.c b/examples/multi_process/client_server_mp/mp_client/client.c
index 087c38ef73..5e32350925 100644
--- a/examples/multi_process/client_server_mp/mp_client/client.c
+++ b/examples/multi_process/client_server_mp/mp_client/client.c
@@ -7,7 +7,7 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/examples/multi_process/client_server_mp/mp_server/init.c b/examples/multi_process/client_server_mp/mp_server/init.c
index f3b9b49380..b20e2034c5 100644
--- a/examples/multi_process/client_server_mp/mp_server/init.c
+++ b/examples/multi_process/client_server_mp/mp_server/init.c
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
diff --git a/examples/multi_process/client_server_mp/mp_server/main.c b/examples/multi_process/client_server_mp/mp_server/main.c
index 691d453d0e..68c0682969 100644
--- a/examples/multi_process/client_server_mp/mp_server/main.c
+++ b/examples/multi_process/client_server_mp/mp_server/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <errno.h>
 #include <signal.h>
 
diff --git a/examples/multi_process/hotplug_mp/main.c b/examples/multi_process/hotplug_mp/main.c
index d668580784..e84edd6674 100644
--- a/examples/multi_process/hotplug_mp/main.c
+++ b/examples/multi_process/hotplug_mp/main.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <errno.h>
 #include <termios.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <cmdline_rdline.h>
 #include <cmdline_parse.h>
diff --git a/examples/multi_process/simple_mp/main.c b/examples/multi_process/simple_mp/main.c
index d73d1358ff..d272f21a01 100644
--- a/examples/multi_process/simple_mp/main.c
+++ b/examples/multi_process/simple_mp/main.c
@@ -22,7 +22,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <termios.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index 7314a9c6ea..fd905da085 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -19,7 +19,7 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <getopt.h>
 #include <signal.h>
 #include <inttypes.h>
diff --git a/examples/server_node_efd/efd_node/node.c b/examples/server_node_efd/efd_node/node.c
index fc2aa5ffef..f91c5ae075 100644
--- a/examples/server_node_efd/efd_node/node.c
+++ b/examples/server_node_efd/efd_node/node.c
@@ -7,7 +7,7 @@
 #include <inttypes.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdlib.h>
 #include <getopt.h>
 #include <string.h>
diff --git a/examples/server_node_efd/efd_server/init.c b/examples/server_node_efd/efd_server/init.c
index 9a20831a0d..2789913594 100644
--- a/examples/server_node_efd/efd_server/init.c
+++ b/examples/server_node_efd/efd_server/init.c
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <inttypes.h>
diff --git a/examples/server_node_efd/efd_server/main.c b/examples/server_node_efd/efd_server/main.c
index 70a7372d4a..0dc57ef414 100644
--- a/examples/server_node_efd/efd_server/main.c
+++ b/examples/server_node_efd/efd_server/main.c
@@ -9,7 +9,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <errno.h>
 #include <sys/types.h>
 #include <netinet/in.h>
diff --git a/examples/service_cores/main.c b/examples/service_cores/main.c
index 9f52082254..be86cb04e2 100644
--- a/examples/service_cores/main.c
+++ b/examples/service_cores/main.c
@@ -7,7 +7,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_launch.h>
diff --git a/examples/timer/main.c b/examples/timer/main.c
index a349846c7c..89c97276b2 100644
--- a/examples/timer/main.c
+++ b/examples/timer/main.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_memory.h>
diff --git a/examples/vhost/main.h b/examples/vhost/main.h
index c986cbc5a9..c85018dce4 100644
--- a/examples/vhost/main.h
+++ b/examples/vhost/main.h
@@ -5,7 +5,7 @@
 #ifndef _MAIN_H_
 #define _MAIN_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_ether.h>
 #include <rte_pci.h>
diff --git a/examples/vm_power_manager/channel_manager.c b/examples/vm_power_manager/channel_manager.c
index 339c7fbb93..e162fe5da6 100644
--- a/examples/vm_power_manager/channel_manager.c
+++ b/examples/vm_power_manager/channel_manager.c
@@ -10,7 +10,7 @@
 #include <dirent.h>
 #include <errno.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
diff --git a/examples/vm_power_manager/channel_monitor.c b/examples/vm_power_manager/channel_monitor.c
index 01590826e5..e2e12754f6 100644
--- a/examples/vm_power_manager/channel_monitor.c
+++ b/examples/vm_power_manager/channel_monitor.c
@@ -13,7 +13,7 @@
 #include <fcntl.h>
 #include <sys/types.h>
 #include <sys/epoll.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/time.h>
 #include <sys/socket.h>
 #include <sys/select.h>
diff --git a/examples/vm_power_manager/main.c b/examples/vm_power_manager/main.c
index d6f18187a7..3ac19a6526 100644
--- a/examples/vm_power_manager/main.c
+++ b/examples/vm_power_manager/main.c
@@ -12,7 +12,7 @@
 #include <signal.h>
 #include <errno.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_eal.h>
diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 8c9d885090..a005a31190 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/examples/vmdq_dcb/main.c b/examples/vmdq_dcb/main.c
index d6f7b632b9..48d3c9bb00 100644
--- a/examples/vmdq_dcb/main.c
+++ b/examples/vmdq_dcb/main.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/lib/acl/rte_acl_osdep.h b/lib/acl/rte_acl_osdep.h
index b2c262dee7..3cf8acabdd 100644
--- a/lib/acl/rte_acl_osdep.h
+++ b/lib/acl/rte_acl_osdep.h
@@ -21,7 +21,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /*
  * Common defines.
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index ea644c1f9b..e0ba5b0770 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -5,7 +5,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index cb33923631..ab8c1c1059 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -17,7 +17,7 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <fcntl.h>
 
 #include <libelf.h>
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..826e28810a 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -7,7 +7,7 @@
 #include <errno.h>
 #include <stdint.h>
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/cryptodev/cryptodev_pmd.c b/lib/cryptodev/cryptodev_pmd.c
index d79d561bf6..ded6cf908c 100644
--- a/lib/cryptodev/cryptodev_pmd.c
+++ b/lib/cryptodev/cryptodev_pmd.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <dev_driver.h>
 #include <eal_export.h>
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 829a5d0846..7952ba8fb0 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2015-2020 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/lib/distributor/rte_distributor.c b/lib/distributor/rte_distributor.c
index dde7ce2677..5f858a23d0 100644
--- a/lib/distributor/rte_distributor.c
+++ b/lib/distributor/rte_distributor.c
@@ -5,7 +5,7 @@
 #include <stdalign.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <string.h>
 #include <eal_export.h>
 #include <rte_mbuf.h>
diff --git a/lib/distributor/rte_distributor_single.c b/lib/distributor/rte_distributor_single.c
index d4b3e12648..41d5c42c05 100644
--- a/lib/distributor/rte_distributor_single.c
+++ b/lib/distributor/rte_distributor_single.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <rte_mbuf.h>
 #include <rte_memzone.h>
 #include <rte_errno.h>
diff --git a/lib/eal/common/eal_common_bus.c b/lib/eal/common/eal_common_bus.c
index 067e7a8b67..20bae99ddc 100644
--- a/lib/eal/common/eal_common_bus.c
+++ b/lib/eal/common/eal_common_bus.c
@@ -4,7 +4,7 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <bus_driver.h>
 #include <rte_debug.h>
diff --git a/lib/eal/common/eal_common_class.c b/lib/eal/common/eal_common_class.c
index 0f10c6894b..b02956118d 100644
--- a/lib/eal/common/eal_common_class.c
+++ b/lib/eal/common/eal_common_class.c
@@ -4,7 +4,7 @@
 
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_class.h>
 #include <rte_debug.h>
diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index b43b0a4bb3..bfa54fb02d 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -6,7 +6,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <bus_driver.h>
 #include <rte_class.h>
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..9c5d6df36f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -10,7 +10,7 @@
 #include <limits.h>
 #include <errno.h>
 #include <getopt.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <dlfcn.h>
 #include <libgen.h>
diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index fe3ced21c7..150fc4c2a8 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -2,7 +2,7 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdio.h>
 #include <string.h>
 
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index a76dff0017..dcb28ee0fe 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -5,7 +5,7 @@
 #include <stdlib.h>
 #include <fnmatch.h>
 #include <pthread.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <regex.h>
 
 #include <rte_common.h>
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 6340bab8be..501c6daa95 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -8,7 +8,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <dev_driver.h>
 #include <rte_bitset.h>
diff --git a/lib/eal/common/malloc_elem.c b/lib/eal/common/malloc_elem.c
index 452b119c20..688c80d48f 100644
--- a/lib/eal/common/malloc_elem.c
+++ b/lib/eal/common/malloc_elem.c
@@ -6,7 +6,7 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_eal.h>
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 39240c261c..f9c56a2fb3 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -6,7 +6,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_memory.h>
 #include <rte_errno.h>
diff --git a/lib/eal/common/malloc_heap.h b/lib/eal/common/malloc_heap.h
index dfc56d4ae3..1b96f027d2 100644
--- a/lib/eal/common/malloc_heap.h
+++ b/lib/eal/common/malloc_heap.h
@@ -6,7 +6,7 @@
 #define MALLOC_HEAP_H_
 
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_malloc.h>
 #include <rte_spinlock.h>
diff --git a/lib/eal/common/rte_malloc.c b/lib/eal/common/rte_malloc.c
index 388e5a63b6..e779581530 100644
--- a/lib/eal/common/rte_malloc.c
+++ b/lib/eal/common/rte_malloc.c
@@ -6,7 +6,7 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_errno.h>
 #include <rte_memcpy.h>
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 8b1ba5b99b..1b48dd5459 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -17,7 +17,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/stat.h>
 
 #include <rte_common.h>
diff --git a/lib/eal/freebsd/eal_interrupts.c b/lib/eal/freebsd/eal_interrupts.c
index bb2bc529f2..fe48465e5d 100644
--- a/lib/eal/freebsd/eal_interrupts.c
+++ b/lib/eal/freebsd/eal_interrupts.c
@@ -5,7 +5,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/event.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <eal_export.h>
diff --git a/lib/eal/freebsd/eal_thread.c b/lib/eal/freebsd/eal_thread.c
index 7ed76ed796..6b33dac339 100644
--- a/lib/eal/freebsd/eal_thread.c
+++ b/lib/eal/freebsd/eal_thread.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <sched.h>
 #include <pthread_np.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/thr.h>
 
 #include <rte_debug.h>
diff --git a/lib/eal/freebsd/include/rte_os.h b/lib/eal/freebsd/include/rte_os.h
index 94b9275beb..ddc3b4fd2e 100644
--- a/lib/eal/freebsd/include/rte_os.h
+++ b/lib/eal/freebsd/include/rte_os.h
@@ -12,7 +12,7 @@
 
 #include <pthread_np.h>
 #include <stdlib.h>            /* Declares alloca() */
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* These macros are compatible with system's sys/queue.h. */
 #define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index a1433eb867..da5aa44154 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -6,7 +6,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <pthread.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/time.h>
 #include <sys/timerfd.h>
 
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 4cfaeba7fe..10ef85896d 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -7,7 +7,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
diff --git a/lib/eal/linux/include/rte_os.h b/lib/eal/linux/include/rte_os.h
index 20eff0409a..3c87f52b33 100644
--- a/lib/eal/linux/include/rte_os.h
+++ b/lib/eal/linux/include/rte_os.h
@@ -12,7 +12,7 @@
 
 #include <alloca.h>
 #include <sched.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 /* These macros are compatible with system's sys/queue.h. */
 #define RTE_TAILQ_HEAD(name, type) TAILQ_HEAD(name, type)
diff --git a/lib/eal/windows/eal_alarm.c b/lib/eal/windows/eal_alarm.c
index 0b11d331dc..1e4a5b0d1b 100644
--- a/lib/eal/windows/eal_alarm.c
+++ b/lib/eal/windows/eal_alarm.c
@@ -4,7 +4,7 @@
 
 #include <stdatomic.h>
 #include <stdbool.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_alarm.h>
diff --git a/lib/eal/windows/include/sys/queue.h b/lib/eal/windows/include/sys/queue.h
deleted file mode 100644
index 0da00d46d7..0000000000
--- a/lib/eal/windows/include/sys/queue.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2026 Stephen Hemminger
- */
-
-/*
- * Windows has no system <sys/queue.h>. The bundled copy has moved to
- * <rte_queue.h>; this stub keeps the existing includes working until they
- * are converted, and is removed in the following commit.
- */
-
-#include <rte_queue.h>
diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 4dfc0ec9a4..34b9585cb8 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -7,7 +7,7 @@
 #include <stdlib.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_cpuflags.h>
diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index 41a0ebe268..a483281cdf 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -5,7 +5,7 @@
 #ifndef _ETH_PRIVATE_H_
 #define _ETH_PRIVATE_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..49e74aa880 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -9,7 +9,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <bus_driver.h>
 #include <eal_export.h>
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..92b24749b0 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -5,7 +5,7 @@
 
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 770becdb61..c6749b034a 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -5,7 +5,7 @@
 
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 4a2335834c..b44f92a04c 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_eal.h>
diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h
index 26cdc66371..527a283d7d 100644
--- a/lib/graph/graph_private.h
+++ b/lib/graph/graph_private.h
@@ -6,7 +6,7 @@
 #define _RTE_GRAPH_PRIVATE_H_
 
 #include <inttypes.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_eal.h>
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 5d495ae973..f976db6845 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/hash/rte_fbk_hash.c b/lib/hash/rte_fbk_hash.c
index 45d4a13427..fd8270984f 100644
--- a/lib/hash/rte_fbk_hash.c
+++ b/lib/hash/rte_fbk_hash.c
@@ -7,7 +7,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_cpuflags.h>
diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index fcd41248b9..5ffd2074f6 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdalign.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_thash.h>
diff --git a/lib/ip_frag/ip_frag_common.h b/lib/ip_frag/ip_frag_common.h
index 34be5bb6ab..fdc4ba043a 100644
--- a/lib/ip_frag/ip_frag_common.h
+++ b/lib/ip_frag/ip_frag_common.h
@@ -5,7 +5,7 @@
 #ifndef _IP_FRAG_COMMON_H_
 #define _IP_FRAG_COMMON_H_
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_common.h>
 #include <rte_tailq.h>
diff --git a/lib/log/log.c b/lib/log/log.c
index 8ad5250a13..47a0a5bc74 100644
--- a/lib/log/log.c
+++ b/lib/log/log.c
@@ -11,7 +11,7 @@
 #include <errno.h>
 #include <regex.h>
 #include <fnmatch.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <eal_export.h>
diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 0d1afe0ca1..e97a535929 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..2e696faec9 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -6,7 +6,7 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..73c5924153 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -3,7 +3,7 @@
  */
 
 #include <stdalign.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <stdint.h>
 #include <limits.h>
 
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 817e2b8dc1..57fd282970 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -12,7 +12,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index d24764cbbe..a96546c1eb 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -5,7 +5,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdio.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 
 #include <eal_export.h>
diff --git a/lib/pipeline/rte_swx_pipeline_internal.h b/lib/pipeline/rte_swx_pipeline_internal.h
index f527857861..543ece261d 100644
--- a/lib/pipeline/rte_swx_pipeline_internal.h
+++ b/lib/pipeline/rte_swx_pipeline_internal.h
@@ -6,7 +6,7 @@
 
 #include <inttypes.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <rte_bitops.h>
 #include <rte_byteorder.h>
diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index e4d4f146d1..d372ecf4f1 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -8,7 +8,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <sys/ioctl.h>
 #include <sys/syscall.h>
 
diff --git a/lib/reorder/rte_reorder.c b/lib/reorder/rte_reorder.c
index af5a6d9f01..511b8d502e 100644
--- a/lib/reorder/rte_reorder.c
+++ b/lib/reorder/rte_reorder.c
@@ -4,7 +4,7 @@
 
 #include <stdalign.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..1a5fb8b927 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -5,7 +5,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 918ddbdfd3..30c14eb2ef 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -5,7 +5,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_eal_memconfig.h>
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index 10b52dc679..60b1ebf716 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -13,7 +13,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_common.h>
diff --git a/lib/stack/rte_stack.c b/lib/stack/rte_stack.c
index 4c78fe4b4b..c8660fc1cc 100644
--- a/lib/stack/rte_stack.c
+++ b/lib/stack/rte_stack.c
@@ -4,7 +4,7 @@
 
 #include <stdalign.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <eal_export.h>
 #include <rte_string_fns.h>
diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
index ed2109f3c8..aa63ad466d 100644
--- a/lib/vhost/fd_man.h
+++ b/lib/vhost/fd_man.h
@@ -6,7 +6,7 @@
 #define _FD_MAN_H_
 #include <pthread.h>
 #include <poll.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 struct fdset;
 
diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 70e582a18d..6e3c1aeaae 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -10,7 +10,7 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <errno.h>
 #include <fcntl.h>
 
diff --git a/lib/vhost/vdpa.c b/lib/vhost/vdpa.c
index bc2dd8d2e1..4f2b7e0013 100644
--- a/lib/vhost/vdpa.c
+++ b/lib/vhost/vdpa.c
@@ -8,7 +8,7 @@
  * Device specific vhost lib
  */
 
-#include <sys/queue.h>
+#include <rte_queue.h>
 
 #include <dev_driver.h>
 #include <eal_export.h>
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index ee61f7415e..e405b68e4e 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -8,7 +8,7 @@
 #include <stdio.h>
 #include <stdbool.h>
 #include <stdlib.h>
-#include <sys/queue.h>
+#include <rte_queue.h>
 #include <unistd.h>
 #include <linux/virtio_net.h>
 #include <sys/socket.h>
-- 
2.53.0

