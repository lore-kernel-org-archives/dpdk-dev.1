Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580C7C9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 17:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CA8142E81;
	Wed, 23 Sep 2026 19:02:45 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id CFDAB4027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 19:02:42 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747f05ffdso5757925ad.1
 for <dev@dpdk.org>; Wed, 23 Sep 2026 10:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790182962;
 x=1790787762; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VqJ/1LJnRuxibxFY6Y1gCj3YuXLnVPLU1T9NRPjIpaY=;
 b=VCOWGUK9/CtX1kbZ+BbhR3sxRC4dUKVNRZK2NK5y56+BmvBJbQ1l1N0CE+tG0z5Mkm
 AD5sBbW9iTg2K1Gove7YGJfARlCZBf01IY5pWEauuz72hVezSHTNBuu1ChCQOjKXWV0R
 tukKWVlPDq7lOlApkac65wrFu9OY9Sj/QfQGTimiGeGWVNOWf3apGc4oy8hzdfcZzkHq
 8rzRYY78lcuzHYi8DJrStAHngsUzCaSaoiPa4g/QQ+UlFSwftAJsfTZdQpkuAOTyEnVN
 Y/4RZErYeZc6smgn+Fq1gxAIuDNWCdb7Sn62S6BWNZaM7JDnTxj4HvaXyMwZaNelILsC
 DZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790182962; x=1790787762;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VqJ/1LJnRuxibxFY6Y1gCj3YuXLnVPLU1T9NRPjIpaY=;
 b=0rc4Ob7eeTol2hahtYD024AE8W7NMlnQIBIfrl6XvWmy76GVLtYmQrTty4MTqgb+cw
 CDSlzN/Ok2tCm99tgsNOJmkDEAAE6F9NPyPA5RTPT+2azhpGQr9xOnIbqhycikP+5HQV
 qeMAuBtXZiCdTrAwLkFWJ06X2Gm0PMXcFBJWqOGNuDZ7PGJm80gsHMc5oScd+U372HXo
 zVB2GCO/Gpe+dRnUjMrXWWDAMEnd9qWtf087NMO29G3VOcPZdvb2oBkIlB/h7mMJPCNL
 0ls7hZXPRX8/25a7rk910QZgOioxwXAlIFWCVYfFj9eVxiW1NEPRPv4Xb4B3G/7y//1g
 /aZw==
X-Gm-Message-State: AFuF++lNTY1kbQv88ft7SbaESDg9KEeiaNsAPNzWVr7ySavo6h+EZEuD
 uyfGRutw779GGdZSeFDAXi3h6pCbvO1F4TJw19ZyLCrpHVe7US/XFOu0Z26Dk4nTJqE=
X-Gm-Gg: AYBFou2+YncHq02EAOWidsW53B+rLj+HLKT2fnsdVr8lYSNXU5Z3b4Y7lJdEJwIN2pA
 gA3Annj2pYAbEQJ0snsbNSE+IOKrk4bSvq3rY+rxnOq3z6gbOTQX8O1gK1UViOBe3I1LnLfH/8a
 yy+7gDv4M2b7UmRNcT2HHC6/OTHQ5zmz6Xy6QnUUru9OMTR/uwyR4oioh29U7J7LOnNq2ohfrzK
 6ISxdtNT0W+Hmk9+l094NhvYjljzmDeWXIuE48qh8BkFAGLyAXncmweN5icfMJlLuMiMfDBhDvo
 IsEQMEWwX/KxAsHoPUXv+vVeJJCRSkAtkPE1wrzgMOV/CA6cZvAiWU7TQcSqqly8zGi1zxWGvGP
 pTsDPAHy2T9OFN/ogfUIN0yGu7Sxl0EnSKnQWCFiTIpLHlTnTHp1Hz0S7KV6kQIQDI0bi8hp6Qe
 z7u12ywG+UFMYtrUu+gYXcFB6TjUNxzg38RZFM1GGVwTR/GMf9oIIS7z0XqHwkt0MGBq55cqebt
 c2nCXAYW16EV8Hs0LFZmx8pwQk8uea3kGeB3QtGcASVJQkCcos=
X-Received: by 2002:a17:902:fdac:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2df69d33d29mr29034285ad.4.1790182960148; 
 Wed, 23 Sep 2026 10:02:40 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a603828sm14575915ad.77.2026.09.23.10.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:02:39 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:02:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, Shepard Siegel <shepard.siegel@atomicrules.com>, Ed
 Czeck <ed.czeck@atomicrules.com>, John Miller
 <john.miller@atomicrules.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>, Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Praveen Shetty <praveen.shetty@intel.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Amit Bernstein
 <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>, Gagandeep Singh
 <g.singh@nxp.com>, Vanshika Shukla <vanshika.shukla@nxp.com>, John Daley
 <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>, Gaetan Rivet
 <grive@u256.net>, Joshua Washington <joshwash@google.com>, Xiaoyun Wang
 <cloud.wangxiaoyun@huawei.com>, Feifei Wang <wangfeifei40@huawei.com>,
 Xingui Yang <yangxingui@huawei.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Rosen Xu <rosen.xu@altera.com>, Wei Hu
 <weh@microsoft.com>, Jakub Grajciar <jgrajcia@cisco.com>, Matan Azrad
 <matan@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Zyta Szpak
 <zyta@marvell.com>, Liron Himi <lironh@marvell.com>, Dimon Zhao
 <dimon.zhao@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam
 Chen <sam.chen@nebula-matrix.com>, Martin Spinler <spinler@cesnet.cz>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Christian Koue Muf <ckm@napatech.com>, Serhii Iliushyk
 <sil-plv@napatech.com>, Vamsi Attunuru <vattunuru@marvell.com>, Devendra
 Singh Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>,
 Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>,
 Wenbo Cao <caowenbo@mucse.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Jie Liu <liujie5@linkdatatechnology.com>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Chenbo Xia
 <chenbox@nvidia.com>, Jochen Behrens <jochen.behrens@broadcom.com>, Renyong
 Wan <wanry@yunsilicon.com>, Na Na <nana@yunsilicon.com>, Rong Qian
 <qianr@yunsilicon.com>, Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei
 Xu <xudw@yunsilicon.com>, Junlong Wang <wang.junlong1@zte.com.cn>, Ming Ran
 <ran.ming@zte.com.cn>
Subject: Re: [PATCH 3/3] doc: simplify NIC feature matrices
Message-ID: <20260923100235.0be3d07e@phoenix.local>
In-Reply-To: <20260923032502.770744-4-thomas@monjalon.net>
References: <20260923032502.770744-1-thomas@monjalon.net>
 <20260923032502.770744-4-thomas@monjalon.net>
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

On Wed, 23 Sep 2026 05:20:51 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> Remove rows which are not useful in the NIC feature overview:
> documentation availability, basic stats and link status.
> The last two are always implemented so they are not really useful
> in the matrix but their description are kept in features.rst.
> 
> Merge Rx/Tx variants when the support is identical:
> descriptor status and runtime queue setup.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Correction to previous mail, spotted by AI:

Rx timestamp does have a row. The problem is that its features.rst
entry is stale: it cites RTE_MBUF_F_RX_TIMESTAMP and mbuf.timestamp,
and neither exists (the field became a dynamic field in 20.11). The
offloads that actually have no row are Tx MULTI_SEGS (45 drivers), the
tunnel TSO flags (VXLAN in 14 drivers, GENEVE 12, GRE 9, IPIP 6, IP/UDP
3 each) and SEND_ON_TIMESTAMP (3 drivers).

And AI audit of current features said:

Ran 41 commands, searched the web, searched past chats

Audited main at a1ff3ac (2026-09-15). I couldn't find the pending simplification series on the list, so everything below is measured against main. Driver counts come from grepping drivers/net for flag references and .op = assignments.

1. Offloads with no matrix row

    TX_OFFLOAD_MULTI_SEGS: 53 drivers. This is the Tx counterpart of Scattered Rx and has no row.
    Tunnel TSO has no row: VXLAN_TNL_TSO (17 drivers), GENEVE_TNL_TSO (15), GRE_TNL_TSO (12), IPIP_TNL_TSO (9), UDP_TNL_TSO (3), IP_TNL_TSO (3).
    UDP_TSO (12 drivers) appears only in the TSO [provides] line. The [uses] line lists only TCP_TSO.
    TX_OFFLOAD_SEND_ON_TIMESTAMP: 4 drivers, no row.
    DEV_CAPA_FLOW_RULE_KEEP (18) and FLOW_SHARED_OBJECT_KEEP (2): no row.
    RX_OFFLOAD_VLAN_EXTEND (17) is in VLAN offload [uses] but not [provides]. KEEP_CRC has no [provides] line either.

2. dev_ops with no row (driver count in parens)

    dev_set_link_up/down (37)
    rx_queue_count (24) is parked in "Other", yet tx_queue_count has a row with one user (cnxk).
    tx_pkt_prepare (22) is also in "Other".
    dev_reset (16)
    mtr_ops_get (7): rte_tm has a row, rte_mtr does not.
    Smaller ones: hairpin_*, representor_info_get, recycle_rxq_info_get, speed_lanes_*, rx_metadata_negotiate, rx_queue_avail_thresh_*, count_aggr_ports/map_aggr_tx_affinity, xstats_enable/disable, eth_rx/tx_descriptor_dump.
    Rate limitation is missing get_queue_rate_limit (added in 26.11; ice, mlx5).
    Congestion management is missing cman_config_init.

3. Rows that are always present or not really per-driver

    Basic stats: 74 of 75 drivers claim it, and features.rst itself says it applies to all drivers. The one exception, enetfec, does implement stats_get, so its .ini is simply wrong.
    Extended stats: ethdev synthesizes basic xstats (and per-queue ones with AUTOFILL) for every driver, so rte_eth_xstats_get() works without xstats_get. The row really means "has driver-private counters".
    Stats per queue: the definition is stale. The q_* fields were removed from rte_eth_stats in 25.11, and queue stats mapping was removed in 26.11. Per-queue stats now come through the qstats arg of stats_get plus RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS, and the claims don't track that:
        Set AUTOFILL but don't claim: axgbe, dpaa2, ena, memif, mvpp2, sxe2, tap, vhost.
        Claim without AUTOFILL: cnxk, cxgbe, hns3, rnp, txgbe, virtio, zxdh.
    Link status: effectively mandatory, since rte_eth_link_get() returns -ENOTSUP without link_update. ark, enetfec and nbl implement it but don't claim it.
    CRC offload: the text says stripping is assumed, so the row can only usefully mean KEEP_CRC. Ten drivers claim it with no KEEP_CRC reference in source: cxgbe, enic, fm10k, hinic, hinic3, ipn3ke, mvneta, mvpp2, octeontx, thunderx.
    Doc rows: every column already has a guide, yet only 37 claim Usage doc. Design doc (2 drivers) and Perf doc (1) are dead rows.
    OS/arch rows: hand-maintained and derivable from meson. rv64 and LoongArch64 are claimed by ixgbe only, while only 28 net drivers have any arch gating at all.

4. features.rst errors

    The Inner L3/L4 checksum sections actually document OUTER_IPV4_CKSUM, OUTER_UDP_CKSUM and RX_OUTER_*. The rows are misnamed.
    Timestamp offload references RTE_MBUF_F_RX_TIMESTAMP and mbuf.timestamp, both gone since 21.02. The current mechanism is rte_mbuf_dyn_rx_timestamp_register().
    Flow control names the op priority_flow_ctrl_queue_configure; the real op is priority_flow_ctrl_queue_config. PFC is also folded into link flow control rather than having its own row.
    Tx queue count is tagged as an eth_dev_ops member, but it's a fast-path rte_eth_dev member. Scattered Rx has the same problem with rx_pkt_burst.
    IP reassembly uses [provides] eth_dev_ops instead of [implements]. No driver claims the row, yet cnxk (cn10k, cn20k) implements it.
    The rv64 section sits under the _nic_features_x86-32 anchor, and x86-32 has no anchor of its own.
    Section order diverges from default.ini. Runtime queue setup, Burst mode info and Power mgmt sit after Perf doc.
    The row name "Power mgmt address monitor" doesn't match its section heading.
    Nits: trailing comma after buffer_split_supported_hdr_ptypes_get, and missing () on rte_eth_dev_rss_hash_update.

5. .ini claims vs driver code

Claimed, but the op is absent:

    Queue start/stop: dpaa2, hinic, mlx4, nfp.
    ipn3ke: 13 rows. The representor ops only cover about 30 basic ops.
    Unicast MAC filter: avp, nbl.
    Multicast MAC filter: fm10k (base code only).
    One row each:
        nfb: Extended stats.
        r8169: Flow control.
        sxe2: Timesync.
        thunderx: Allmulticast.
        xsc: RSS reta update.
        hinic3: Packet type parsing.
        igb: DCB.
    virtio, mvpp2 and zxdh claim Multicast MAC filter via mac_addr_add, not set_mc_addr_list. That's a definition ambiguity rather than a driver bug.

Implemented, but not claimed (drivers with a single .ini only):

    i40e: MTU update, Free Tx mbuf on demand, EEPROM dump, Registers dump, LED.
    axgbe: 10 rows, including MTU, Timesync, xstats and Registers dump.
    netvsc: Multicast MAC, RSS reta/key, Rx/Tx descriptor status, Packet type parsing.
    nfp: Burst mode info, Extended stats, FW version.
    vmxnet3: Rx interrupt, RSS reta update, FW version.
    zxdh: Rx interrupt, RSS key update, Packet type parsing.

Other gaps

    bonding, null, ring and softnic implement eth_dev_ops but have no .ini, so they're absent from the matrix.
    38 .ini files are out of default.ini order. conf.py doesn't check order.
    check-doc-vs-code.sh only covers rte_flow items and actions. Most of section 5 could be a mechanical check.
