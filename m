Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD64CC02194
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C8EB42DAC;
	Fri, 31 Jan 2025 13:59:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BE31C427E9
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328371; x=1769864371;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NW71GpmGx7pj0ntlN6zQ65SKLok57O89+sZRSHtbXG0=;
 b=YhiektkLP+s+cn3tN2xktnWUMWvSq4Q3zcCZrX3+jjfgW3CBsEof12O2
 14cC6P7upkQheudx3+hRs7YPYeExiZn5ol7nfcYZnt5bUj9KslQvALNEN
 dfzx76ZjRbndXDiQb0AZg0qDiq6LdhqR0kwPQEIGHuaRkEzJ1QbZgUeQI
 rGhowlNSQDDQpKzk5QSWIp/4ygZh/tepmgj9BH2+plH+kNnDaYQb3oPJm
 /96AGji+kpqCR7cXCYpTccugpFdu5kEqKGerRS7zfrTCTW2d5QatwdDv4
 uPRkS5hx/vEBNfbB9ol/tO3HNSU20qplDGMQSq1V1wfp7OMn+7RseKIY+ A==;
X-CSE-ConnectionGUID: csZem8YsQLG09enFHeq9sA==
X-CSE-MsgGUID: b5dS6ePjSB2c2iXQLFvcZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315620"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:31 -0800
X-CSE-ConnectionGUID: fAf+BkKgRY6OJJM2W1BSqg==
X-CSE-MsgGUID: liOmoj3CRmCxBeZa9mw64w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503359"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 08/42] net/e1000/base: add misc definitions for i225
Date: Fri, 31 Jan 2025 12:58:21 +0000
Message-ID: <b1913b91e4262d728cf24855d1c9c43d52a5bd41.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

Add in various miscellaneous definitions (Rx/Tx, RSS, etc.) for i225
series NICs. This is mostly identical to IGC driver, with some minor
differences due to the way IGC driver was originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 107 +++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h    |  59 ++++++++++
 drivers/net/intel/e1000/base/e1000_regs.h    |  30 ++++++
 3 files changed, 196 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index a32100195a..44d6888824 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -188,6 +188,15 @@
 #define E1000_RCTL_BSEX		0x02000000 /* Buffer size extension */
 #define E1000_RCTL_SECRC	0x04000000 /* Strip Ethernet CRC */
 
+#define E1000_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
+#define E1000_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
+
+/* Transmit Scheduling */
+#define E1000_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
+#define E1000_TQAVCTRL_ENHANCED_QAV	0x00000008
+
+#define E1000_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
+
 /* Use byte values for the following shift parameters
  * Usage:
  *     psrctl |= (((ROUNDUP(value0, 128) >> E1000_PSRCTL_BSIZE0_SHIFT) &
@@ -594,6 +603,8 @@
 #define E1000_IMS_VMMB		E1000_ICR_VMMB    /* Mail box activity */
 #define E1000_IMS_RXSEQ		E1000_ICR_RXSEQ   /* Rx sequence error */
 #define E1000_IMS_RXDMT0	E1000_ICR_RXDMT0  /* Rx desc min. threshold */
+#define E1000_QVECTOR_MASK	0x7FFC		/* Q-vector mask */
+#define E1000_ITR_VAL_MASK	0x04		/* ITR value mask */
 #define E1000_IMS_RXO		E1000_ICR_RXO     /* Rx overrun */
 #define E1000_IMS_RXT0		E1000_ICR_RXT0    /* Rx timer intr */
 #define E1000_IMS_TXD_LOW	E1000_ICR_TXD_LOW
@@ -626,6 +637,7 @@
 #define E1000_ICS_LSC		E1000_ICR_LSC       /* Link Status Change */
 #define E1000_ICS_RXSEQ		E1000_ICR_RXSEQ     /* Rx sequence error */
 #define E1000_ICS_RXDMT0	E1000_ICR_RXDMT0    /* Rx desc min. threshold */
+#define E1000_ICS_DRSTA		E1000_ICR_DRSTA     /* Device Reset Aserted */
 
 /* Extended Interrupt Cause Set */
 #define E1000_EICS_RX_QUEUE0	E1000_EICR_RX_QUEUE0 /* Rx Queue 0 Interrupt */
@@ -778,6 +790,75 @@
 #define E1000_TIMINCA_INCPERIOD_SHIFT	24
 #define E1000_TIMINCA_INCVALUE_MASK	0x00FFFFFF
 
+/* Time Sync Interrupt Cause/Mask Register Bits */
+#define TSINTR_SYS_WRAP	(1 << 0) /* SYSTIM Wrap around. */
+#define TSINTR_TXTS	(1 << 1) /* Transmit Timestamp. */
+#define TSINTR_TT0	(1 << 3) /* Target Time 0 Trigger. */
+#define TSINTR_TT1	(1 << 4) /* Target Time 1 Trigger. */
+#define TSINTR_AUTT0	(1 << 5) /* Auxiliary Timestamp 0 Taken. */
+#define TSINTR_AUTT1	(1 << 6) /* Auxiliary Timestamp 1 Taken. */
+
+#define TSYNC_INTERRUPTS	TSINTR_TXTS
+
+/* Split Replication Receive Control */
+#define E1000_SRRCTL_TIMESTAMP		0x40000000
+#define E1000_SRRCTL_TIMER1SEL(timer)	(((timer) & 0x3) << 14)
+#define E1000_SRRCTL_TIMER0SEL(timer)	(((timer) & 0x3) << 17)
+
+/* Sample RX tstamp in PHY sop */
+#define E1000_TSYNCRXCTL_RXSYNSIG	0x00000400
+
+/* Sample TX tstamp in PHY sop */
+#define E1000_TSYNCTXCTL_TXSYNSIG	0x00000020
+
+/* TSAUXC Configuration Bits */
+#define TSAUXC_EN_TT0	(1 << 0)  /* Enable target time 0. */
+#define TSAUXC_EN_TT1	(1 << 1)  /* Enable target time 1. */
+#define TSAUXC_EN_CLK0	(1 << 2)  /* Enable Configurable Frequency Clock 0. */
+#define TSAUXC_ST0	(1 << 4)  /* Start Clock 0 Toggle on Target Time 0. */
+#define TSAUXC_EN_CLK1	(1 << 5)  /* Enable Configurable Frequency Clock 1. */
+#define TSAUXC_ST1	(1 << 7)  /* Start Clock 1 Toggle on Target Time 1. */
+#define TSAUXC_EN_TS0	(1 << 8)  /* Enable hardware timestamp 0. */
+#define TSAUXC_EN_TS1	(1 << 10) /* Enable hardware timestamp 0. */
+
+/* SDP Configuration Bits */
+#define AUX0_SEL_SDP0	(0u << 0)  /* Assign SDP0 to auxiliary time stamp 0. */
+#define AUX0_SEL_SDP1	(1u << 0)  /* Assign SDP1 to auxiliary time stamp 0. */
+#define AUX0_SEL_SDP2	(2u << 0)  /* Assign SDP2 to auxiliary time stamp 0. */
+#define AUX0_SEL_SDP3	(3u << 0)  /* Assign SDP3 to auxiliary time stamp 0. */
+#define AUX0_TS_SDP_EN	(1u << 2)  /* Enable auxiliary time stamp trigger 0. */
+#define AUX1_SEL_SDP0	(0u << 3)  /* Assign SDP0 to auxiliary time stamp 1. */
+#define AUX1_SEL_SDP1	(1u << 3)  /* Assign SDP1 to auxiliary time stamp 1. */
+#define AUX1_SEL_SDP2	(2u << 3)  /* Assign SDP2 to auxiliary time stamp 1. */
+#define AUX1_SEL_SDP3	(3u << 3)  /* Assign SDP3 to auxiliary time stamp 1. */
+#define AUX1_TS_SDP_EN	(1u << 5)  /* Enable auxiliary time stamp trigger 1. */
+#define TS_SDP0_EN	(1u << 8)  /* SDP0 is assigned to Tsync. */
+#define TS_SDP1_EN	(1u << 11) /* SDP1 is assigned to Tsync. */
+#define TS_SDP2_EN	(1u << 14) /* SDP2 is assigned to Tsync. */
+#define TS_SDP3_EN	(1u << 17) /* SDP3 is assigned to Tsync. */
+#define TS_SDP0_SEL_TT0	(0u << 6)  /* Target time 0 is output on SDP0. */
+#define TS_SDP0_SEL_TT1	(1u << 6)  /* Target time 1 is output on SDP0. */
+#define TS_SDP1_SEL_TT0	(0u << 9)  /* Target time 0 is output on SDP1. */
+#define TS_SDP1_SEL_TT1	(1u << 9)  /* Target time 1 is output on SDP1. */
+#define TS_SDP0_SEL_FC0	(2u << 6)  /* Freq clock  0 is output on SDP0. */
+#define TS_SDP0_SEL_FC1	(3u << 6)  /* Freq clock  1 is output on SDP0. */
+#define TS_SDP1_SEL_FC0	(2u << 9)  /* Freq clock  0 is output on SDP1. */
+#define TS_SDP1_SEL_FC1	(3u << 9)  /* Freq clock  1 is output on SDP1. */
+#define TS_SDP2_SEL_TT0	(0u << 12) /* Target time 0 is output on SDP2. */
+#define TS_SDP2_SEL_TT1	(1u << 12) /* Target time 1 is output on SDP2. */
+#define TS_SDP2_SEL_FC0	(2u << 12) /* Freq clock  0 is output on SDP2. */
+#define TS_SDP2_SEL_FC1	(3u << 12) /* Freq clock  1 is output on SDP2. */
+#define TS_SDP3_SEL_TT0	(0u << 15) /* Target time 0 is output on SDP3. */
+#define TS_SDP3_SEL_TT1	(1u << 15) /* Target time 1 is output on SDP3. */
+#define TS_SDP3_SEL_FC0	(2u << 15) /* Freq clock  0 is output on SDP3. */
+#define TS_SDP3_SEL_FC1	(3u << 15) /* Freq clock  1 is output on SDP3. */
+
+#define E1000_CTRL_SDP0_DIR	0x00400000  /* SDP0 Data direction */
+#define E1000_CTRL_SDP1_DIR	0x00800000  /* SDP1 Data direction */
+
+/* Extended Device Control */
+#define E1000_CTRL_EXT_SDP2_DIR	0x00000400 /* SDP2 Data direction */
+
 /* ETQF register bit definitions */
 #define E1000_ETQF_1588			(1 << 30)
 #define E1000_FTQF_VF_BP		0x00008000
@@ -1415,6 +1496,8 @@
 #define GG82563_PHY_INBAND_CTRL		GG82563_REG(194, 18) /* Inband Ctrl */
 
 /* MDI Control */
+#define E1000_MDIC_DATA_MASK	0x0000FFFF
+#define E1000_MDIC_INT_EN		0x20000000
 #define E1000_MDIC_REG_MASK	0x001F0000
 #define E1000_MDIC_REG_SHIFT	16
 #define E1000_MDIC_PHY_MASK	0x03E00000
@@ -1425,6 +1508,14 @@
 #define E1000_MDIC_ERROR	0x40000000
 #define E1000_MDIC_DEST		0x80000000
 
+#define E1000_N0_QUEUE -1
+
+#define E1000_MAX_MAC_HDR_LEN	127
+#define E1000_MAX_NETWORK_HDR_LEN	511
+
+#define E1000_VLANPQF_QSEL(_n, q_idx)	((q_idx) << ((_n) * 4))
+#define E1000_VLANPQF_VALID(_n)		(0x1 << (3 + (_n) * 4))
+#define E1000_VLANPQF_QUEUE_MASK	0x03
 #define E1000_VFTA_BLOCK_SIZE	8
 /* SerDes Control */
 #define E1000_GEN_CTL_READY		0x80000000
@@ -1562,6 +1653,21 @@
 #define E1000_INVM_AUTOLOAD		0x0A
 #define E1000_INVM_PLL_WO_VAL		0x0010
 
+/* Proxy Filter Control Extended */
+#define E1000_PROXYFCEX_MDNS		0x00000001 /* mDNS */
+#define E1000_PROXYFCEX_MDNS_M		0x00000002 /* mDNS Multicast */
+#define E1000_PROXYFCEX_MDNS_U		0x00000004 /* mDNS Unicast */
+#define E1000_PROXYFCEX_IPV4_M		0x00000008 /* IPv4 Multicast */
+#define E1000_PROXYFCEX_IPV6_M		0x00000010 /* IPv6 Multicast */
+#define E1000_PROXYFCEX_IGMP		0x00000020 /* IGMP */
+#define E1000_PROXYFCEX_IGMP_M		0x00000040 /* IGMP Multicast */
+#define E1000_PROXYFCEX_ARPRES		0x00000080 /* ARP Response */
+#define E1000_PROXYFCEX_ARPRES_D	0x00000100 /* ARP Response Directed */
+#define E1000_PROXYFCEX_ICMPV4		0x00000200 /* ICMPv4 */
+#define E1000_PROXYFCEX_ICMPV4_D	0x00000400 /* ICMPv4 Directed */
+#define E1000_PROXYFCEX_ICMPV6		0x00000800 /* ICMPv6 */
+#define E1000_PROXYFCEX_ICMPV6_D	0x00001000 /* ICMPv6 Directed */
+#define E1000_PROXYFCEX_DNS		0x00002000 /* DNS */
 
 /* Proxy Filter Control */
 #define E1000_PROXYFC_D0		0x00000001 /* Enable offload in D0 */
@@ -1572,6 +1678,7 @@
 #define E1000_PROXYFC_IPV4		0x00000040 /* Directed IPv4 Enable */
 #define E1000_PROXYFC_IPV6		0x00000080 /* Directed IPv6 Enable */
 #define E1000_PROXYFC_NS		0x00000200 /* IPv6 Neighbor Solicitation */
+#define E1000_PROXYFC_NS_DIRECTED	0x00000400 /* Directed NS Proxy Ena */
 #define E1000_PROXYFC_ARP		0x00000800 /* ARP Request Proxy Ena */
 /* Proxy Status */
 #define E1000_PROXYS_CLEAR		0xFFFFFFFF /* Clear */
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index d9e02383c3..a6fa2cfbe7 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -43,12 +43,71 @@ s32 e1000_set_eee_i225(struct e1000_hw *hw, bool adv2p5G, bool adv1G,
 #define NVM_LED_1_CFG_DEFAULT_I225	0x0184
 #define NVM_LED_0_2_CFG_DEFAULT_I225	0x200C
 
+#define E1000_MRQC_ENABLE_RSS_4Q		0x00000002
+#define E1000_MRQC_ENABLE_VMDQ			0x00000003
+#define E1000_MRQC_ENABLE_VMDQ_RSS_2Q		0x00000005
+#define E1000_MRQC_RSS_FIELD_IPV4_UDP		0x00400000
+#define E1000_MRQC_RSS_FIELD_IPV6_UDP		0x00800000
+#define E1000_MRQC_RSS_FIELD_IPV6_UDP_EX	0x01000000
 #define E1000_I225_SHADOW_RAM_SIZE		4096
 #define E1000_I225_ERASE_CMD_OPCODE		0x02000000
 #define E1000_I225_WRITE_CMD_OPCODE		0x01000000
 #define E1000_FLSWCTL_DONE			0x40000000
 #define E1000_FLSWCTL_CMDV			0x10000000
 
+/* SRRCTL bit definitions */
+#define E1000_SRRCTL_BSIZEHDRSIZE_MASK		0x00000F00
+#define E1000_SRRCTL_DESCTYPE_LEGACY		0x00000000
+#define E1000_SRRCTL_DESCTYPE_HDR_SPLIT		0x04000000
+#define E1000_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS	0x0A000000
+#define E1000_SRRCTL_DESCTYPE_HDR_REPLICATION	0x06000000
+#define E1000_SRRCTL_DESCTYPE_HDR_REPLICATION_LARGE_PKT 0x08000000
+#define E1000_SRRCTL_DESCTYPE_MASK		0x0E000000
+#define E1000_SRRCTL_DROP_EN			0x80000000
+#define E1000_SRRCTL_BSIZEPKT_MASK		0x0000007F
+#define E1000_SRRCTL_BSIZEHDR_MASK		0x00003F00
+
+#define E1000_RXDADV_RSSTYPE_MASK	0x0000000F
+#define E1000_RXDADV_RSSTYPE_SHIFT	12
+#define E1000_RXDADV_HDRBUFLEN_MASK	0x7FE0
+#define E1000_RXDADV_HDRBUFLEN_SHIFT	5
+#define E1000_RXDADV_SPLITHEADER_EN	0x00001000
+#define E1000_RXDADV_SPH		0x8000
+#define E1000_RXDADV_STAT_TS		0x10000 /* Pkt was time stamped */
+#define E1000_RXDADV_ERR_HBO		0x00800000
+
+/* RSS Hash results */
+#define E1000_RXDADV_RSSTYPE_NONE	0x00000000
+#define E1000_RXDADV_RSSTYPE_IPV4_TCP	0x00000001
+#define E1000_RXDADV_RSSTYPE_IPV4	0x00000002
+#define E1000_RXDADV_RSSTYPE_IPV6_TCP	0x00000003
+#define E1000_RXDADV_RSSTYPE_IPV6_EX	0x00000004
+#define E1000_RXDADV_RSSTYPE_IPV6	0x00000005
+#define E1000_RXDADV_RSSTYPE_IPV6_TCP_EX 0x00000006
+#define E1000_RXDADV_RSSTYPE_IPV4_UDP	0x00000007
+#define E1000_RXDADV_RSSTYPE_IPV6_UDP	0x00000008
+#define E1000_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
+
+/* RSS Packet Types as indicated in the receive descriptor */
+#define E1000_RXDADV_PKTTYPE_ILMASK	0x000000F0
+#define E1000_RXDADV_PKTTYPE_TLMASK	0x00000F00
+#define E1000_RXDADV_PKTTYPE_NONE	0x00000000
+#define E1000_RXDADV_PKTTYPE_IPV4	0x00000010 /* IPV4 hdr present */
+#define E1000_RXDADV_PKTTYPE_IPV4_EX	0x00000020 /* IPV4 hdr + extensions */
+#define E1000_RXDADV_PKTTYPE_IPV6	0x00000040 /* IPV6 hdr present */
+#define E1000_RXDADV_PKTTYPE_IPV6_EX	0x00000080 /* IPV6 hdr + extensions */
+#define E1000_RXDADV_PKTTYPE_TCP	0x00000100 /* TCP hdr present */
+#define E1000_RXDADV_PKTTYPE_UDP	0x00000200 /* UDP hdr present */
+#define E1000_RXDADV_PKTTYPE_SCTP	0x00000400 /* SCTP hdr present */
+#define E1000_RXDADV_PKTTYPE_NFS	0x00000800 /* NFS hdr present */
+
+#define E1000_RXDADV_PKTTYPE_IPSEC_ESP	0x00001000 /* IPSec ESP */
+#define E1000_RXDADV_PKTTYPE_IPSEC_AH	0x00002000 /* IPSec AH */
+#define E1000_RXDADV_PKTTYPE_LINKSEC	0x00004000 /* LinkSec Encap */
+#define E1000_RXDADV_PKTTYPE_ETQF	0x00008000 /* PKTTYPE is ETQF index */
+#define E1000_RXDADV_PKTTYPE_ETQF_MASK	0x00000070 /* ETQF has 8 indices */
+#define E1000_RXDADV_PKTTYPE_ETQF_SHIFT	4 /* Right-shift 4 bits */
+
 /* LED Control */
 #define E1000_GLOBAL_BLINK_MODE	0x00000020 /*Blink at 200 ms on and 200 ms off.*/
 #define E1000_LED1_MODE_MASK	0x00000F00
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 3a4779f80b..b30419d712 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -271,6 +271,8 @@
 				 (0x054E0 + ((_i - 16) * 8)))
 #define E1000_RAH(_i)		(((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
 				 (0x054E4 + ((_i - 16) * 8)))
+#define E1000_VLANPQF		0x055B0  /* VLAN Priority Queue Filter VLANPQF */
+
 #define E1000_SHRAL(_i)		(0x05438 + ((_i) * 8))
 #define E1000_SHRAH(_i)		(0x0543C + ((_i) * 8))
 #define E1000_IP4AT_REG(_i)	(0x05840 + ((_i) * 8))
@@ -492,6 +494,17 @@
 #define E1000_IP6AT	0x05880  /* IPv6 Address Table - RW Array */
 #define E1000_WUPL	0x05900  /* Wakeup Packet Length - RW */
 #define E1000_WUPM	0x05A00  /* Wakeup Packet Memory - RO A */
+#define E1000_WUPM_EXT	0x0B800  /* Wakeup Packet Memory Extended - RO Array */
+#define E1000_WUFC_EXT	0x0580C  /* Wakeup Filter Control Extended - RW */
+#define E1000_WUS_EXT	0x05814  /* Wakeup Status Extended - RW1C */
+#define E1000_FHFTSL	0x05804  /* Flex Filter Indirect Table Select - RW */
+#define E1000_PROXYFCEX	0x05590  /* Proxy Filter Control Extended - RW1C */
+#define E1000_PROXYEXS	0x05594  /* Proxy Extended Status - RO */
+#define E1000_WFUTPF	0x05500  /* Wake Flex UDP TCP Port Filter - RW Array */
+#define E1000_RFUTPF	0x05580  /* Range Flex UDP TCP Port Filter - RW */
+#define E1000_RWPFC	0x05584  /* Range Wake Port Filter Control - RW */
+#define E1000_WFUTPS	0x05588  /* Wake Filter UDP TCP Status - RW1C */
+#define E1000_WCS	0x0558C  /* Wake Control Status - RW1C */
 /* MSI-X Table Register Descriptions */
 #define E1000_PBACL	0x05B68  /* MSIx PBA Clear - Read/Write 1's to clear */
 #define E1000_FFLT	0x05F00  /* Flexible Filter Length Table - RW Array */
@@ -603,6 +616,14 @@
 #define E1000_RXMTRL	0x0B634 /* Time sync Rx EtherType and Msg Type - RW */
 #define E1000_RXUDP	0x0B638 /* Time Sync Rx UDP Port - RW */
 
+#define E1000_QBVCYCLET	0x331C
+#define E1000_QBVCYCLET_S 0x3320
+#define E1000_STQT(_n)	(0x3324 + 0x4 * (_n))
+#define E1000_ENDQT(_n)	(0x3334 + 0x4 * (_n))
+#define E1000_TXQCTL(_n)	(0x3344 + 0x4 * (_n))
+#define E1000_BASET_L	0x3314
+#define E1000_BASET_H	0x3318
+
 /* Filtering Registers */
 #define E1000_SAQF(_n)	(0x05980 + (4 * (_n))) /* Source Address Queue Fltr */
 #define E1000_DAQF(_n)	(0x059A0 + (4 * (_n))) /* Dest Address Queue Fltr */
@@ -701,4 +722,13 @@
 #define E1000_LTRMINV	0x5BB0 /* LTR Minimum Value */
 #define E1000_LTRMAXV	0x5BB4 /* LTR Maximum Value */
 
+/* IEEE 1588 TIMESYNCH */
+#define E1000_TRGTTIML0	0x0B644 /* Target Time Register 0 Low  - RW */
+#define E1000_TRGTTIMH0	0x0B648 /* Target Time Register 0 High - RW */
+#define E1000_TRGTTIML1	0x0B64C /* Target Time Register 1 Low  - RW */
+#define E1000_TRGTTIMH1	0x0B650 /* Target Time Register 1 High - RW */
+#define E1000_FREQOUT0	0x0B654 /* Frequency Out 0 Control Register - RW */
+#define E1000_FREQOUT1	0x0B658 /* Frequency Out 1 Control Register - RW */
+#define E1000_TSSDP	0x0003C  /* Time Sync SDP Configuration Register - RW */
+
 #endif
-- 
2.43.5

