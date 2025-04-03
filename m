Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A82C3601E
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 00:13:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDB844029A;
	Thu,  3 Apr 2025 02:13:46 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id A77594014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 02:13:45 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 78224464EC; Thu,  3 Apr 2025 02:13:45 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1689] [24.11] dpdk_pdump and dumppcap does not work
Date: Thu, 03 Apr 2025 00:13:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: kanikamago@microsoft.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1689-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17436392250.0aEe9.1555077
Content-Transfer-Encoding: 7bit
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


--17436392250.0aEe9.1555077
Date: Thu, 3 Apr 2025 02:13:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1689

            Bug ID: 1689
           Summary: [24.11] dpdk_pdump and dumppcap does not work
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: kanikamago@microsoft.com
  Target Milestone: ---

Created attachment 308
  --> https://bugs.dpdk.org/attachment.cgi?id=3D308&action=3Dedit
Coredump

Primary application is run with following params: - -a $PCI
--vdev=3Dnet_vdev_netvsc0,iface=3D$IFNAME=20
Secondary application is run as ./dpdk-pdump -- --pdump
'port=3D1,queue=3D*,rx-dev=3D/home/dpdkworker/rx.pcap,tx-dev=3D/home/dpdkwo=
rker/tx.pcap'


Issue: Application cannot start with EAL: cannot initialize tailq:
VFIO_CDX_RESOURCE_LIST.=20
Find full Failure message in attachment (coredump_pdump_issue.png)

DPDK is statically compiled into application, and following libs are exclud=
ed
to tame the size of executable.

list(
    REMOVE_ITEM
    DPDK_STATIC_LDFLAGS
-l:librte_baseband_acc100.a -l:librte_baseband_fpga_5gnr_fec.a
-l:librte_baseband_fpga_lte_fec.a -l:librte_baseband_null.a
-l:librte_baseband_turbo_sw.a
-l:librte_bus_dpaa.a -l:librte_bus_fslmc.a -l:librte_bus_ifpga.a
-l:librte_common_cpt.a
 -l:librte_common_dpaax.a -l:librte_common_iavf.a -l:librte_common_octeontx=
.a
-l:librte_common_octeontx2.a
-l:librte_compress_octeontx.a -l:librte_crypto_bcmfs.a
-l:librte_crypto_caam_jr.a
-l:librte_crypto_ccp.a -l:librte_crypto_dpaa_sec.a -l:librte_crypto_dpaa2_s=
ec.a
-l:librte_crypto_nitrox.a=20
-l:librte_crypto_octeontx.a -l:librte_crypto_octeontx2.a -l:librte_event_dp=
aa.a
-l:librte_event_dpaa2.a
-l:librte_event_dsw.a -l:librte_event_octeontx.a -l:librte_event_octeontx2.a
-l:librte_mempool_dpaa.a
-l:librte_mempool_dpaa2.a -l:librte_mempool_octeontx.a
-l:librte_mempool_octeontx2.a -l:librte_net_ark.a
-l:librte_net_atlantic.a -l:librte_net_avp.a -l:librte_net_axgbe.a
-l:librte_net_bnx2x.a -l:librte_net_bnxt.a
-l:librte_net_bond.a -l:librte_net_cxgbe.a -l:librte_net_dpaa.a
-l:librte_net_dpaa2.a -l:librte_net_ena.a
-l:librte_net_enetc.a -l:librte_net_enic.a -l:librte_net_fm10k.a
-l:librte_net_hinic.a -l:librte_net_hns3.a -l:librte_net_i40e.a
-l:librte_net_iavf.a -l:librte_net_ice.a
-l:librte_net_igc.a -l:librte_net_liquidio.a -l:librte_net_memif.a
-l:librte_net_nfp.a
-l:librte_net_octeontx.a -l:librte_net_octeontx2.a -l:librte_net_pfe.a
-l:librte_net_qede.a
-l:librte_net_sfc.a -l:librte_net_thunderx.a -l:librte_net_txgbe.a
-l:librte_raw_dpaa2_cmdif.a
-l:librte_raw_dpaa2_qdma.a -l:librte_raw_octeontx2_dma.a
-l:librte_raw_octeontx2_ep.a
-l:librte_net_ntnic.a -l:librte_regex_octeontx2.a -l:librte_raw_cnxk_bphy.a
-l:librte_raw_cnxk_gpio.a -l:librte_raw_cnxk_rvu_lf.a=20
-l:librte_raw_cnxk_rvu_pf.a -l:librte_regex_cn9k.a -l:librte_net_zxdh.a
-l:librte_net_vmxnet3.a
-l:librte_net_octeon_ep.a -l:librte_net_r8169.a -l:librte_net_cpfl.a
-l:librte_net_cxgbe.a -l:librte_net_dpaa.a=20
-l:librte_net_dpaa2.a -l:librte_net_enetfec.a -l:librte_net_gve.a
-l:librte_net_idpf.a -l:librte_net_ionic.a
-l:librte_dma_dpaa.a -l:librte_dma_dpaa2.a -l:librte_event_cnxk.a
-l:librte_baseband_la12xx.a
-l:librte_common_cnxk.a -l:librte_dma_cnxk.a -l:librte_common_idpf.a
-l:librte_common_ionic.a  -l:librte_mempool_cnxk.a
-l:librte_crypto_cnxk.a  -l:librte_crypto_ionic.a -l:librte_net_cnxk.a
-l:librte_ml_cnxk.a -l:librte_net_softnic.a -l:librte_dma_odm.a
-l:librte_event_dlb2.a -l:librte_event_opdl.a -l:librte_event_skeleton.a
-l:librte_event_octeontx.a -l:librte_dma_skeleton.a -l:librte_raw_skeleton.a
-l:librte_dma_hisilicon.a -l:librte_dma_idxd.a -l:librte_dma_ioat.a
-l:librte_compress_nitrox.a -l:librte_compress_zlib.a=20
-l:librte_common_qat.a -l:librte_common_sfc_efx.a -l:librte_common_nfp.a
-l:librte_baseband_acc.a -l:librte_vdpa_nfp.a
-l:librte_vdpa_ifc.a -l:librte_vdpa_sfc.a -l:librte_net_e1000.a
-l:librte_net_ixgbe.a
-l:librte_bus_cdx.a -l:librte_bus_uacce.a -l:librte_common_nitrox.a
-l:librte_raw_ntb.a



To debug we recompiled application with no lib exclusions, and reran, the p=
dump
and dumppcap applications could start and capture packet, but when terminat=
ed
they caused primary application to terminate and exited with output as in
attached image pdump_issue_no_exclusions.png

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17436392250.0aEe9.1555077
Date: Thu, 3 Apr 2025 02:13:45 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - [24.11] dpdk_pdump and dumppcap does not work"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1689">1689</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[24.11] dpdk_pdump and dumppcap does not work
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>24.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>major
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>kanikamago&#64;microsoft.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D308" name=3D"attach_308" title=3D"Coredump">attachm=
ent 308</a> <a href=3D"attachment.cgi?id=3D308&amp;action=3Dedit" title=3D"=
Coredump">[details]</a></span>
Coredump

Primary application is run with following params: - -a $PCI
--vdev=3Dnet_vdev_netvsc0,iface=3D$IFNAME=20
Secondary application is run as ./dpdk-pdump -- --pdump
'port=3D1,queue=3D*,rx-dev=3D/home/dpdkworker/rx.pcap,tx-dev=3D/home/dpdkwo=
rker/tx.pcap'


Issue: Application cannot start with EAL: cannot initialize tailq:
VFIO_CDX_RESOURCE_LIST.=20
Find full Failure message in attachment (coredump_pdump_issue.png)

DPDK is statically compiled into application, and following libs are exclud=
ed
to tame the size of executable.

list(
    REMOVE_ITEM
    DPDK_STATIC_LDFLAGS
-l:librte_baseband_acc100.a -l:librte_baseband_fpga_5gnr_fec.a
-l:librte_baseband_fpga_lte_fec.a -l:librte_baseband_null.a
-l:librte_baseband_turbo_sw.a
-l:librte_bus_dpaa.a -l:librte_bus_fslmc.a -l:librte_bus_ifpga.a
-l:librte_common_cpt.a
 -l:librte_common_dpaax.a -l:librte_common_iavf.a -l:librte_common_octeontx=
.a
-l:librte_common_octeontx2.a
-l:librte_compress_octeontx.a -l:librte_crypto_bcmfs.a
-l:librte_crypto_caam_jr.a
-l:librte_crypto_ccp.a -l:librte_crypto_dpaa_sec.a -l:librte_crypto_dpaa2_s=
ec.a
-l:librte_crypto_nitrox.a=20
-l:librte_crypto_octeontx.a -l:librte_crypto_octeontx2.a -l:librte_event_dp=
aa.a
-l:librte_event_dpaa2.a
-l:librte_event_dsw.a -l:librte_event_octeontx.a -l:librte_event_octeontx2.a
-l:librte_mempool_dpaa.a
-l:librte_mempool_dpaa2.a -l:librte_mempool_octeontx.a
-l:librte_mempool_octeontx2.a -l:librte_net_ark.a
-l:librte_net_atlantic.a -l:librte_net_avp.a -l:librte_net_axgbe.a
-l:librte_net_bnx2x.a -l:librte_net_bnxt.a
-l:librte_net_bond.a -l:librte_net_cxgbe.a -l:librte_net_dpaa.a
-l:librte_net_dpaa2.a -l:librte_net_ena.a
-l:librte_net_enetc.a -l:librte_net_enic.a -l:librte_net_fm10k.a
-l:librte_net_hinic.a -l:librte_net_hns3.a -l:librte_net_i40e.a
-l:librte_net_iavf.a -l:librte_net_ice.a
-l:librte_net_igc.a -l:librte_net_liquidio.a -l:librte_net_memif.a
-l:librte_net_nfp.a
-l:librte_net_octeontx.a -l:librte_net_octeontx2.a -l:librte_net_pfe.a
-l:librte_net_qede.a
-l:librte_net_sfc.a -l:librte_net_thunderx.a -l:librte_net_txgbe.a
-l:librte_raw_dpaa2_cmdif.a
-l:librte_raw_dpaa2_qdma.a -l:librte_raw_octeontx2_dma.a
-l:librte_raw_octeontx2_ep.a
-l:librte_net_ntnic.a -l:librte_regex_octeontx2.a -l:librte_raw_cnxk_bphy.a
-l:librte_raw_cnxk_gpio.a -l:librte_raw_cnxk_rvu_lf.a=20
-l:librte_raw_cnxk_rvu_pf.a -l:librte_regex_cn9k.a -l:librte_net_zxdh.a
-l:librte_net_vmxnet3.a
-l:librte_net_octeon_ep.a -l:librte_net_r8169.a -l:librte_net_cpfl.a
-l:librte_net_cxgbe.a -l:librte_net_dpaa.a=20
-l:librte_net_dpaa2.a -l:librte_net_enetfec.a -l:librte_net_gve.a
-l:librte_net_idpf.a -l:librte_net_ionic.a
-l:librte_dma_dpaa.a -l:librte_dma_dpaa2.a -l:librte_event_cnxk.a
-l:librte_baseband_la12xx.a
-l:librte_common_cnxk.a -l:librte_dma_cnxk.a -l:librte_common_idpf.a
-l:librte_common_ionic.a  -l:librte_mempool_cnxk.a
-l:librte_crypto_cnxk.a  -l:librte_crypto_ionic.a -l:librte_net_cnxk.a
-l:librte_ml_cnxk.a -l:librte_net_softnic.a -l:librte_dma_odm.a
-l:librte_event_dlb2.a -l:librte_event_opdl.a -l:librte_event_skeleton.a
-l:librte_event_octeontx.a -l:librte_dma_skeleton.a -l:librte_raw_skeleton.a
-l:librte_dma_hisilicon.a -l:librte_dma_idxd.a -l:librte_dma_ioat.a
-l:librte_compress_nitrox.a -l:librte_compress_zlib.a=20
-l:librte_common_qat.a -l:librte_common_sfc_efx.a -l:librte_common_nfp.a
-l:librte_baseband_acc.a -l:librte_vdpa_nfp.a
-l:librte_vdpa_ifc.a -l:librte_vdpa_sfc.a -l:librte_net_e1000.a
-l:librte_net_ixgbe.a
-l:librte_bus_cdx.a -l:librte_bus_uacce.a -l:librte_common_nitrox.a
-l:librte_raw_ntb.a



To debug we recompiled application with no lib exclusions, and reran, the p=
dump
and dumppcap applications could start and capture packet, but when terminat=
ed
they caused primary application to terminate and exited with output as in
attached image pdump_issue_no_exclusions.png
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1689">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17436392250.0aEe9.1555077--
