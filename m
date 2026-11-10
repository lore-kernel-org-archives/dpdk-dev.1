Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA6606A325
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 01:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 778D140283;
	Tue, 10 Nov 2026 02:10:18 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 76A0B4027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 02:10:17 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 3ADF74D223; Tue, 10 Nov 2026 02:10:17 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2101] soring: stringop warnings on LTO build
Date: Tue, 10 Nov 2026 01:10:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
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
Message-ID: <bug-2101-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2101

            Bug ID: 2101
           Summary: soring: stringop warnings on LTO build
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Build with LTO fails:
FAILED: [code=3D1] app/dpdk-test=20
cc  -o app/dpdk-test app/dpdk-test.p/test_commands.c.o
app/dpdk-test.p/test_test.c.o app/dpdk-test.p/test_process.c.o
app/dpdk-test.p/test_packet_burst_generator.c.o
app/dpdk-test.p/test_sample_packet_forward.c.o
app/dpdk-test.p/test_virtual_pmd.c.o app/dpdk-test.p/test_test_acl.c.o
app/dpdk-test.p/test_test_alarm.c.o app/dpdk-test.p/test_test_argparse.c.o
app/dpdk-test.p/test_test_atomic.c.o app/dpdk-test.p/test_test_barrier.c.o
app/dpdk-test.p/test_test_bitcount.c.o app/dpdk-test.p/test_test_bitmap.c.o
app/dpdk-test.p/test_test_bitops.c.o app/dpdk-test.p/test_test_bitset.c.o
app/dpdk-test.p/test_test_bitratestats.c.o app/dpdk-test.p/test_test_bpf.c.o
app/dpdk-test.p/test_test_bpf_validate.c.o
app/dpdk-test.p/test_test_byteorder.c.o app/dpdk-test.p/test_test_cfgfile.c=
.o
app/dpdk-test.p/test_test_cksum.c.o app/dpdk-test.p/test_test_cksum_perf.c.o
app/dpdk-test.p/test_test_cmdline.c.o
app/dpdk-test.p/test_test_cmdline_cirbuf.c.o
app/dpdk-test.p/test_test_cmdline_etheraddr.c.o
app/dpdk-test.p/test_test_cmdline_ipaddr.c.o
app/dpdk-test.p/test_test_cmdline_lib.c.o
app/dpdk-test.p/test_test_cmdline_num.c.o
app/dpdk-test.p/test_test_cmdline_portlist.c.o
app/dpdk-test.p/test_test_cmdline_string.c.o
app/dpdk-test.p/test_test_common.c.o app/dpdk-test.p/test_test_compressdev.=
c.o
app/dpdk-test.p/test_test_cpuflags.c.o app/dpdk-test.p/test_test_crc.c.o
app/dpdk-test.p/test_test_cryptodev.c.o
app/dpdk-test.p/test_test_cryptodev_asym.c.o
app/dpdk-test.p/test_test_cryptodev_blockcipher.c.o
app/dpdk-test.p/test_test_cryptodev_crosscheck.c.o
app/dpdk-test.p/test_test_cryptodev_security_ipsec.c.o
app/dpdk-test.p/test_test_cryptodev_security_pdcp.c.o
app/dpdk-test.p/test_test_cryptodev_security_tls_record.c.o
app/dpdk-test.p/test_test_cycles.c.o app/dpdk-test.p/test_test_debug.c.o
app/dpdk-test.p/test_test_devargs.c.o app/dpdk-test.p/test_test_dispatcher.=
c.o
app/dpdk-test.p/test_test_distributor.c.o
app/dpdk-test.p/test_test_distributor_perf.c.o
app/dpdk-test.p/test_test_dmadev.c.o app/dpdk-test.p/test_test_dmadev_api.c=
.o
app/dpdk-test.p/test_test_eal_flags.c.o app/dpdk-test.p/test_test_eal_fs.c.o
app/dpdk-test.p/test_test_efd.c.o app/dpdk-test.p/test_test_efd_perf.c.o
app/dpdk-test.p/test_test_errno.c.o app/dpdk-test.p/test_test_ethdev_api.c.o
app/dpdk-test.p/test_test_ethdev_flow_conv.c.o
app/dpdk-test.p/test_test_ethdev_link.c.o
app/dpdk-test.p/test_test_ethdev_module_eeprom.c.o
app/dpdk-test.p/test_test_event_crypto_adapter.c.o
app/dpdk-test.p/test_test_event_dma_adapter.c.o
app/dpdk-test.p/test_test_event_eth_rx_adapter.c.o
app/dpdk-test.p/test_test_event_eth_tx_adapter.c.o
app/dpdk-test.p/test_test_event_ring.c.o
app/dpdk-test.p/test_test_event_timer_adapter.c.o
app/dpdk-test.p/test_test_event_vector_adapter.c.o
app/dpdk-test.p/test_test_eventdev.c.o
app/dpdk-test.p/test_test_external_mem.c.o
app/dpdk-test.p/test_test_fbarray.c.o app/dpdk-test.p/test_test_fib.c.o
app/dpdk-test.p/test_test_fib6.c.o app/dpdk-test.p/test_test_fib6_perf.c.o
app/dpdk-test.p/test_test_fib_perf.c.o
app/dpdk-test.p/test_test_func_reentrancy.c.o
app/dpdk-test.p/test_test_graph.c.o
app/dpdk-test.p/test_test_graph_feature_arc.c.o
app/dpdk-test.p/test_test_graph_perf.c.o app/dpdk-test.p/test_test_hash.c.o
app/dpdk-test.p/test_test_hash_functions.c.o
app/dpdk-test.p/test_test_hash_multiwriter.c.o
app/dpdk-test.p/test_test_hash_perf.c.o
app/dpdk-test.p/test_test_hash_readwrite.c.o
app/dpdk-test.p/test_test_hash_readwrite_lf_perf.c.o
app/dpdk-test.p/test_test_interrupts.c.o app/dpdk-test.p/test_test_ipfrag.c=
.o
app/dpdk-test.p/test_test_ipsec.c.o app/dpdk-test.p/test_test_ipsec_perf.c.o
app/dpdk-test.p/test_test_ipsec_sad.c.o app/dpdk-test.p/test_test_kvargs.c.o
app/dpdk-test.p/test_test_latencystats.c.o
app/dpdk-test.p/test_test_lcore_var.c.o
app/dpdk-test.p/test_test_lcore_var_perf.c.o
app/dpdk-test.p/test_test_lcores.c.o app/dpdk-test.p/test_test_link_bonding=
.c.o
app/dpdk-test.p/test_test_link_bonding_mode4.c.o
app/dpdk-test.p/test_test_link_bonding_rssconf.c.o
app/dpdk-test.p/test_test_logs.c.o app/dpdk-test.p/test_test_lpm.c.o
app/dpdk-test.p/test_test_lpm6.c.o app/dpdk-test.p/test_test_lpm6_perf.c.o
app/dpdk-test.p/test_test_lpm_perf.c.o app/dpdk-test.p/test_test_malloc.c.o
app/dpdk-test.p/test_test_malloc_perf.c.o app/dpdk-test.p/test_test_mbuf.c.o
app/dpdk-test.p/test_test_mcslock.c.o app/dpdk-test.p/test_test_member.c.o
app/dpdk-test.p/test_test_member_perf.c.o app/dpdk-test.p/test_test_memcpy.=
c.o
app/dpdk-test.p/test_test_memcpy_perf.c.o app/dpdk-test.p/test_test_memory.=
c.o
app/dpdk-test.p/test_test_mempool.c.o
app/dpdk-test.p/test_test_mempool_perf.c.o
app/dpdk-test.p/test_test_memzone.c.o app/dpdk-test.p/test_test_meter.c.o
app/dpdk-test.p/test_test_metrics.c.o
app/dpdk-test.p/test_test_mp_secondary.c.o
app/dpdk-test.p/test_test_net_ether.c.o app/dpdk-test.p/test_test_net_ip6.c=
.o
app/dpdk-test.p/test_test_pcapng.c.o app/dpdk-test.p/test_test_pdcp.c.o
app/dpdk-test.p/test_test_pdump.c.o app/dpdk-test.p/test_test_per_lcore.c.o
app/dpdk-test.p/test_test_pflock.c.o app/dpdk-test.p/test_test_pie.c.o
app/dpdk-test.p/test_test_pmd_af_packet.c.o
app/dpdk-test.p/test_test_pmd_memif.c.o app/dpdk-test.p/test_test_pmd_pcap.=
c.o
app/dpdk-test.p/test_test_pmd_perf.c.o app/dpdk-test.p/test_test_pmd_ring.c=
.o
app/dpdk-test.p/test_test_pmd_ring_perf.c.o
app/dpdk-test.p/test_test_pmd_tap.c.o app/dpdk-test.p/test_test_pmu.c.o
app/dpdk-test.p/test_test_power.c.o app/dpdk-test.p/test_test_power_cpufreq=
.c.o
app/dpdk-test.p/test_test_power_intel_uncore.c.o
app/dpdk-test.p/test_test_power_kvm_vm.c.o
app/dpdk-test.p/test_test_prefetch.c.o
app/dpdk-test.p/test_test_ptr_compress.c.o
app/dpdk-test.p/test_test_rand_perf.c.o app/dpdk-test.p/test_test_rawdev.c.o
app/dpdk-test.p/test_test_rcu_qsbr.c.o
app/dpdk-test.p/test_test_rcu_qsbr_perf.c.o
app/dpdk-test.p/test_test_reassembly.c.o
app/dpdk-test.p/test_test_reassembly_perf.c.o
app/dpdk-test.p/test_test_reciprocal_division.c.o
app/dpdk-test.p/test_test_reciprocal_division_perf.c.o
app/dpdk-test.p/test_test_red.c.o app/dpdk-test.p/test_test_reorder.c.o
app/dpdk-test.p/test_test_rib.c.o app/dpdk-test.p/test_test_rib6.c.o
app/dpdk-test.p/test_test_ring.c.o
app/dpdk-test.p/test_test_ring_hts_stress.c.o
app/dpdk-test.p/test_test_ring_mpmc_stress.c.o
app/dpdk-test.p/test_test_ring_mt_peek_stress.c.o
app/dpdk-test.p/test_test_ring_mt_peek_stress_zc.c.o
app/dpdk-test.p/test_test_ring_perf.c.o
app/dpdk-test.p/test_test_ring_rts_stress.c.o
app/dpdk-test.p/test_test_ring_st_peek_stress.c.o
app/dpdk-test.p/test_test_ring_st_peek_stress_zc.c.o
app/dpdk-test.p/test_test_ring_stress.c.o app/dpdk-test.p/test_test_rwlock.=
c.o
app/dpdk-test.p/test_test_sched.c.o app/dpdk-test.p/test_test_security.c.o
app/dpdk-test.p/test_test_security_inline_macsec.c.o
app/dpdk-test.p/test_test_security_inline_proto.c.o
app/dpdk-test.p/test_test_security_proto.c.o
app/dpdk-test.p/test_test_seqlock.c.o
app/dpdk-test.p/test_test_service_cores.c.o
app/dpdk-test.p/test_test_soring.c.o
app/dpdk-test.p/test_test_soring_mt_stress.c.o
app/dpdk-test.p/test_test_soring_peek_stress.c.o
app/dpdk-test.p/test_test_soring_stress.c.o
app/dpdk-test.p/test_test_spinlock.c.o app/dpdk-test.p/test_test_stack.c.o
app/dpdk-test.p/test_test_stack_perf.c.o
app/dpdk-test.p/test_test_string_fns.c.o app/dpdk-test.p/test_test_tailq.c.o
app/dpdk-test.p/test_test_telemetry_data.c.o
app/dpdk-test.p/test_test_telemetry_json.c.o
app/dpdk-test.p/test_test_thash.c.o app/dpdk-test.p/test_test_thash_perf.c.o
app/dpdk-test.p/test_test_threads.c.o app/dpdk-test.p/test_test_ticketlock.=
c.o
app/dpdk-test.p/test_test_timer.c.o app/dpdk-test.p/test_test_timer_perf.c.o
app/dpdk-test.p/test_test_timer_racecond.c.o
app/dpdk-test.p/test_test_timer_secondary.c.o
app/dpdk-test.p/test_test_trace.c.o app/dpdk-test.p/test_test_trace_perf.c.o
app/dpdk-test.p/test_test_trace_register.c.o app/dpdk-test.p/test_test_vdev=
.c.o
app/dpdk-test.p/test_test_version.c.o -Wl,--fatal-warnings -Werror -flto=3D=
auto
-Wl,--as-needed -Wl,--no-undefined -Wl,-O1 -Wl,--whole-archive
-Wl,--start-group lib/librte_node.a lib/librte_graph.a lib/librte_pipeline.a
lib/librte_table.a lib/librte_pdump.a lib/librte_port.a lib/librte_fib.a
lib/librte_pdcp.a lib/librte_ipsec.a lib/librte_vhost.a lib/librte_stack.a
lib/librte_security.a lib/librte_sched.a lib/librte_reorder.a lib/librte_ri=
b.a
lib/librte_mldev.a lib/librte_regexdev.a lib/librte_rawdev.a lib/librte_pow=
er.a
lib/librte_pcapng.a lib/librte_member.a lib/librte_lpm.a
lib/librte_latencystats.a lib/librte_jobstats.a lib/librte_ip_frag.a
lib/librte_gso.a lib/librte_gro.a lib/librte_gpudev.a lib/librte_dispatcher=
.a
lib/librte_eventdev.a lib/librte_efd.a lib/librte_dmadev.a
lib/librte_distributor.a lib/librte_cryptodev.a lib/librte_compressdev.a
lib/librte_cfgfile.a lib/librte_bpf.a lib/librte_bitratestats.a
lib/librte_bbdev.a lib/librte_acl.a lib/librte_timer.a lib/librte_hash.a
lib/librte_metrics.a lib/librte_cmdline.a lib/librte_pci.a lib/librte_ethde=
v.a
lib/librte_meter.a lib/librte_net.a lib/librte_mbuf.a lib/librte_mempool.a
lib/librte_rcu.a lib/librte_ring.a lib/librte_eal.a lib/librte_pmu.a
lib/librte_telemetry.a lib/librte_argparse.a lib/librte_kvargs.a
lib/librte_log.a drivers/librte_common_cpt.a drivers/librte_common_dpaax.a
drivers/librte_common_ionic.a drivers/librte_common_octeontx.a
drivers/librte_bus_auxiliary.a drivers/librte_bus_cdx.a
drivers/librte_bus_dpaa.a drivers/librte_bus_fslmc.a drivers/librte_bus_ifp=
ga.a
drivers/librte_bus_pci.a drivers/librte_bus_platform.a
drivers/librte_bus_uacce.a drivers/librte_bus_vdev.a drivers/librte_bus_vmb=
us.a
drivers/librte_common_cnxk.a drivers/librte_common_mlx5.a
drivers/librte_common_nfp.a drivers/librte_common_nitrox.a
drivers/librte_common_qat.a drivers/librte_common_sfc_efx.a
drivers/librte_common_sxe2.a drivers/librte_common_zsda.a
drivers/librte_mempool_bucket.a drivers/librte_mempool_cnxk.a
drivers/librte_mempool_dpaa.a drivers/librte_mempool_dpaa2.a
drivers/librte_mempool_octeontx.a drivers/librte_mempool_ring.a
drivers/librte_mempool_stack.a drivers/librte_dma_ae4dma.a
drivers/librte_dma_cnxk.a drivers/librte_dma_dpaa.a drivers/librte_dma_dpaa=
2.a
drivers/librte_dma_hisi_acc.a drivers/librte_dma_hisi_pciep.a
drivers/librte_dma_idxd.a drivers/librte_dma_imx_edma5.a
drivers/librte_dma_ioat.a drivers/librte_dma_odm.a
drivers/librte_dma_skeleton.a drivers/librte_net_af_packet.a
drivers/librte_net_af_xdp.a drivers/librte_net_ark.a
drivers/librte_net_atlantic.a drivers/librte_net_avp.a
drivers/librte_net_axgbe.a drivers/librte_net_bnx2x.a drivers/librte_net_bn=
xt.a
drivers/librte_net_bond.a drivers/librte_net_cnxk.a drivers/librte_net_cxgb=
e.a
drivers/librte_net_dpaa.a drivers/librte_net_dpaa2.a drivers/librte_net_ena=
.a
drivers/librte_net_enetc.a drivers/librte_net_enetfec.a
drivers/librte_net_enic.a drivers/librte_net_failsafe.a
drivers/librte_net_gve.a drivers/librte_net_hinic.a drivers/librte_net_hini=
c3.a
drivers/librte_net_hns3.a drivers/librte_net_e1000.a drivers/librte_net_fm1=
0k.a
drivers/librte_net_i40e.a drivers/librte_net_iavf.a drivers/librte_net_ice.a
drivers/librte_net_idpf.a drivers/librte_net_ipn3ke.a
drivers/librte_net_ixgbe.a drivers/librte_net_cpfl.a drivers/librte_net_ion=
ic.a
drivers/librte_net_mana.a drivers/librte_net_memif.a drivers/librte_net_mlx=
4.a
drivers/librte_net_mlx5.a drivers/librte_net_nbl.a drivers/librte_net_netvs=
c.a
drivers/librte_net_nfb.a drivers/librte_net_nfp.a drivers/librte_net_ngbe.a
drivers/librte_net_ntnic.a drivers/librte_net_null.a
drivers/librte_net_octeontx.a drivers/librte_net_octeon_ep.a
drivers/librte_net_pcap.a drivers/librte_net_pfe.a drivers/librte_net_qede.a
drivers/librte_net_r8169.a drivers/librte_net_ring.a drivers/librte_net_rnp=
.a
drivers/librte_net_sfc.a drivers/librte_net_softnic.a drivers/librte_net_sx=
e2.a
drivers/librte_net_tap.a drivers/librte_net_thunderx.a
drivers/librte_net_txgbe.a drivers/librte_net_vdev_netvsc.a
drivers/librte_net_vhost.a drivers/librte_net_virtio.a
drivers/librte_net_vmxnet3.a drivers/librte_net_xsc.a drivers/librte_net_zx=
dh.a
drivers/librte_raw_cnxk_bphy.a drivers/librte_raw_cnxk_gpio.a
drivers/librte_raw_cnxk_rvu_lf.a drivers/librte_raw_dpaa2_cmdif.a
drivers/librte_raw_gdtc.a drivers/librte_raw_ifpga.a drivers/librte_raw_ntb=
.a
drivers/librte_raw_skeleton.a drivers/librte_crypto_bcmfs.a
drivers/librte_crypto_caam_jr.a drivers/librte_crypto_ccp.a
drivers/librte_crypto_cnxk.a drivers/librte_crypto_dpaa_sec.a
drivers/librte_crypto_dpaa2_sec.a drivers/librte_crypto_ionic.a
drivers/librte_crypto_ipsec_mb.a drivers/librte_crypto_mlx5.a
drivers/librte_crypto_nitrox.a drivers/librte_crypto_null.a
drivers/librte_crypto_octeontx.a drivers/librte_crypto_openssl.a
drivers/librte_crypto_scheduler.a drivers/librte_crypto_virtio.a
drivers/librte_compress_isal.a drivers/librte_compress_mlx5.a
drivers/librte_compress_nitrox.a drivers/librte_compress_octeontx.a
drivers/librte_compress_zlib.a drivers/librte_regex_mlx5.a
drivers/librte_regex_cn9k.a drivers/librte_ml_cnxk.a drivers/librte_vdpa_if=
c.a
drivers/librte_vdpa_mlx5.a drivers/librte_vdpa_nfp.a drivers/librte_vdpa_sf=
c.a
drivers/librte_event_cnxk.a drivers/librte_event_dlb2.a
drivers/librte_event_dpaa.a drivers/librte_event_dpaa2.a
drivers/librte_event_dsw.a drivers/librte_event_octeontx.a
drivers/librte_event_opdl.a drivers/librte_event_skeleton.a
drivers/librte_event_sw.a drivers/librte_baseband_acc.a
drivers/librte_baseband_fpga_5gnr_fec.a drivers/librte_baseband_fpga_lte_fe=
c.a
drivers/librte_baseband_la12xx.a drivers/librte_baseband_null.a
drivers/librte_baseband_turbo_sw.a drivers/librte_power_acpi.a
drivers/librte_power_amd_pstate.a drivers/librte_power_amd_uncore.a
drivers/librte_power_cppc.a drivers/librte_power_intel_pstate.a
drivers/librte_power_intel_uncore.a drivers/librte_power_kvm_vm.a
-Wl,--no-whole-archive -Wl,--no-as-needed -Wl,--undefined-version -pthread =
-lm
-ldl -lnuma -lfdt -Wl,-rpath,XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-Wl,--export-dynamic /usr/lib/x86_64-linux-gnu/libz.so
-Wl,-rpath,/usr/local/lib /usr/local/lib/libpcap.so
/usr/lib/x86_64-linux-gnu/libarchive.so /usr/lib/x86_64-linux-gnu/libjansso=
n.so
/usr/lib/x86_64-linux-gnu/libelf.so /usr/lib/x86_64-linux-gnu/libbpf.so
/usr/lib/x86_64-linux-gnu/libmlx5.so /usr/lib/x86_64-linux-gnu/libibverbs.so
-lIPSec_MB /usr/lib/x86_64-linux-gnu/libcrypto.so
/usr/lib/x86_64-linux-gnu/libxdp.so /usr/lib/x86_64-linux-gnu/libmana.so
/usr/lib/x86_64-linux-gnu/libmlx4.so /usr/lib/x86_64-linux-gnu/libfdt.so -l=
nfb
-lrt -lIPSec_MB /usr/lib/x86_64-linux-gnu/libisal.so -le_smi64 -Wl,--end-gr=
oup
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 128 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 160 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 192 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 224 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 256 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 288 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 320 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 352 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 384 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 416 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 448 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
76:3,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:154:18: note: at offset 480 into destination obje=
ct
=E2=80=98acquired_objs=E2=80=99 of size 128
  154 |         uint32_t acquired_objs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 128 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 160 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 192 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 224 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 256 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 288 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 320 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 352 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 384 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 416 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 448 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
In function =E2=80=98__rte_ring_dequeue_elems_128=E2=80=99,
    inlined from =E2=80=98__rte_ring_do_dequeue_elems=E2=80=99 at
../lib/ring/rte_ring_elem_pvt.h:273:3,
    inlined from =E2=80=98soring_acquire=E2=80=99 at ../lib/ring/soring.c:5=
79:4,
    inlined from =E2=80=98rte_soring_acquirx_bulk=E2=80=99 at ../lib/ring/s=
oring.c:741:9,
    inlined from =E2=80=98test_soring_stages=E2=80=99 at ../app/test/test_s=
oring.c:186:14:
../lib/ring/rte_ring_elem_pvt.h:244:25: error: writing 32 bytes into a regi=
on
of size 0 [-Werror=3Dstringop-overflow=3D]
  244 |                         memcpy((obj + i), (const void *)(ring + idx=
),
32);
      |                         ^
../app/test/test_soring.c: In function =E2=80=98test_soring_stages=E2=80=99:
../app/test/test_soring.c:155:18: note: at offset 480 into destination obje=
ct
=E2=80=98acquired_rcs=E2=80=99 of size 128
  155 |         uint32_t acquired_rcs[32];
      |                  ^
lto1: all warnings being treated as errors
make: *** [/tmp/ccls3Hk8.mk:120: /tmp/ccN5iSOB.ltrans59.ltrans.o] Error 1
make: *** Waiting for unfinished jobs....
lto-wrapper: fatal error: make returned 2 exit status
compilation terminated.
/usr/bin/x86_64-linux-gnu-ld.bfd: error: lto-wrapper failed
collect2: error: ld returned 1 exit status
[3942/3976] Linking target app/dpdk-testpmd


The problem is with LTO, gcc inlines rte_soring_acquirx_bulk() into
test_soring_stages(). The element copy switches on the runtime
r->esize, so the 16-byte copy path stays live and gcc reports
-Wstringop-overflow writing into the 32 x uint32_t stack arrays.
That path is never taken since the ring is created with 4 byte
elements and metadata.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
