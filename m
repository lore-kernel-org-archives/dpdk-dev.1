Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5C9CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 21:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4DDE402B6;
	Fri, 19 Jun 2026 23:43:42 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id A0D094028F
 for <dev@dpdk.org>; Fri, 19 Jun 2026 23:43:41 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-13986d61b4fso2966546c88.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781905420;
 x=1782510220; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dvHgBkNAKwaJ8PdyPF7k7DhnIQAvSTb4mpbcBX2NksI=;
 b=yHgokFIbDDTluIDZwAVi7DkLYzJEiRKiVVws3qI4qw4I+UwkuJejwHw8aBp5hT/plA
 Rf6H5paPs5WhhrVuS3jwSJ+oWatO+ZwMwlmUAEnPwSJ3bJEodXOBu8YUm5F1aZ4pU6OV
 eBjrHWf5W1+GK88UthfTCm/8TR1bOJKZJfVzE2583M60Hm4qa6SltjHsJ+E09emR2K4V
 EU75Gp/K5w9ji0aU4RjQSIZpagqv29tXPgB/57mF2YIYM4PsM79OubsnGav2Tgdfk3Ha
 x9w4bsldFeyV4NfhxV62BNStptfvK0Y8wLHZEHn2n0hz3fRm9mI9g+SaRjkHqWFV2P5C
 B4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781905420; x=1782510220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dvHgBkNAKwaJ8PdyPF7k7DhnIQAvSTb4mpbcBX2NksI=;
 b=hlADgERqlQGDtTf+Jx0ABXfFoYnB0gUeMFBfqlm1NXlbh3Kk5K8dmoY5KSgoZhV6PT
 n4a4/sHaIdoiovVrJHJmb+kQzOAOuMi/KXkvJf+ceDSQFfR7TbXslNoIDnq12IekZULq
 vnWhIchtQecNX6gRAUAkjZPA/yZr0FfQ9zPjTdP7Y1/2jHI5A18eMGMFyG9vzIVrKXTe
 RE/aeUVIrjh6DqrLFjnwDffBsswZhy2u9sep6AraIyyWoMfimUBXUci6dCXVG7xdwAFY
 HqFCfbDZOjS2Cwn4q9AdkCfLOjFbtCsCA+MVb69HEpi11SfbKLPDjkKrLHU74KPb+nf+
 1BUA==
X-Gm-Message-State: AOJu0Yzy3I15G/mIIxOG36zPxYhVjLtHO/n/4Oz1X2EQpJnpwssXVuq+
 bSTsPnDPz8VfxPcCMxdMzcD789ktHWHOv8sOddrHGNgLstZ4nSz9YpLxpnnXVKDHEj4=
X-Gm-Gg: AfdE7clDyznZqyv1DXhhIclknY6MFROnRXsRH7SSWi3bo1jW694dCFHF0KjCUTFV00V
 nLYuRSu5disSK4oCzMiC2eo0opMY5/vH8PdFwGPZGTn4dB7z5q3X5Q0yE8tMFfQj15dntxgeRF0
 w5VHfajnlSBK4hBa4bY1bD5wQ6gHZdSnqnMnOg91PNK4cdNq+Tpp1h/9gMz2wbSmieTCjV3NiOU
 cdQhHz/KTK7oTdNp8m0ArwsUVpVHEpYZ14GP254jVTMU6HNlW8i+vwnK1PUXax33U/4IT+2TnbN
 YNSv/CsjyS6w4dyZL/ekTUbb2mStCIiKyIhtSA6T9JJC3sGuOS37ORAVFkHOBWzI9Qf9veQKjZ8
 gvhg+KrWLaGbqQcFs5hAq6gJEfjB/GviybCRKzovEScSJQfxsAtvsWbR3ycDVG3P0YFfLRuqBCN
 QxAx4NcYLji3TpylwcLutKlQT63Hsaf8iqI2nCRBYQUfnwccnZU3KOHg==
X-Received: by 2002:a05:7022:e995:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-139a2035cf9mr2939586c88.6.1781905420141; 
 Fri, 19 Jun 2026 14:43:40 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcc5f14sm642910c88.6.2026.06.19.14.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 14:43:39 -0700 (PDT)
Date: Fri, 19 Jun 2026 14:43:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH 00/10] NXP ENETC driver related changes
Message-ID: <20260619144336.1f9c46f2@phoenix.local>
In-Reply-To: <20260619184427.522518-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
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

On Sat, 20 Jun 2026 00:14:17 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> ENETC driver related changes series
> 
> Gagandeep Singh (8):
>   net/enetc: fix TX BD structure
>   net/enetc: fix TX BDs flag overwrite issue
>   net/enetc: fix queue initialization
>   net/enetc: support ESP packet type in packet parsing
>   net/enetc: update random MAC generation code
>   net/enetc: add option to disable VSI messaging
>   net/enetc: add devargs to control VSI-PSI timeout and delay
>   net/enetc4: add cacheable BD ring support with SW cache maintenance
> 
> Vanshika Shukla (2):
>   net/enetc: support scatter-gather
>   net/enetc: set user configurable priority to TX rings
> 
>  drivers/net/enetc/base/enetc_hw.h |  13 +-
>  drivers/net/enetc/enetc.h         |  28 +-
>  drivers/net/enetc/enetc4_ethdev.c | 123 +++++++--
>  drivers/net/enetc/enetc4_vf.c     | 159 ++++++++++--
>  drivers/net/enetc/enetc_ethdev.c  |  26 +-
>  drivers/net/enetc/enetc_rxtx.c    | 411 ++++++++++++++++++++++++++----
>  6 files changed, 649 insertions(+), 111 deletions(-)
> 

The AI review shows some thing that need to be addressed before merging.

[PATCH 04/10] net/enetc: support ESP packet type

Info: enetc_supported_ptypes_get() adds RTE_PTYPE_TUNNEL_ESP and a
trailing RTE_PTYPE_UNKNOWN. *no_of_elements is RTE_DIM(ptypes), so the
0 entry is counted (not used as a sentinel). It is filtered out by the
mask test in rte_eth_dev_get_supported_ptypes(), so harmless, but the
RTE_PTYPE_UNKNOWN line is unnecessary and should be dropped.


[PATCH 06/10] net/enetc: support scatter-gather

Warning: scatter Rx reassembly state (first_seg/cur_seg) is held in
local variables and reset on every call. rx_frm_cnt only advances on
the F bit, so work_limit won't cut a frame, but the
"!(bd_status & LSTATUS_R)" break can exit mid-frame if HW has written
the leading segments of a multi-segment frame but not yet the segment
carrying F. On the next call first_seg is NULL again, next_to_clean has
already advanced past the consumed leading segments, and those mbufs
are leaked while the tail segments are mis-assembled as a new frame.
Persist the partial chain across bursts in the ring (e.g.
rx_ring->pkt_first_seg / pkt_last_seg) instead of locals. (Same pattern
is reproduced in enetc_clean_rx_ring_cacheable in patch 10.)

Warning: enetc4 now advertises RTE_ETH_RX_OFFLOAD_SCATTER and
RTE_ETH_TX_OFFLOAD_MULTI_SEGS (VF) but doc/guides/nics/features/
enetc4.ini is not updated (Scattered Rx / Multi segment rows).

Info: the VF dev_info now advertises L3/L4 RX checksum offload, but
enetc_dev_rx_parse() unconditionally sets
RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD and never
reports *_BAD. With the offload now advertised, an application relying
on it will never see a bad-checksum indication.

Info: dccivac(data + (data_len - 1)) / dcbf(data + (seg_len - 1))
underflow to data-1 when the segment length is 0 (uint16_t promotes to
int). The preceding loop already covers the final cache line, so the
extra op is redundant as well as unsafe for len==0.


[PATCH 07/10] net/enetc: add option to disable VSI messaging

Warning: new devarg "enetc4_vsi_disable" is registered but not
documented in doc/guides/nics/enetc.rst.


[PATCH 08/10] net/enetc: add devargs to control VSI-PSI timeout/delay

Warning: new devargs "enetc4_vsi_timeout" / "enetc4_vsi_delay" are not
documented in doc/guides/nics/enetc.rst.


[PATCH 09/10] net/enetc: set user configurable priority to TX rings

Error: hw->txq_prior is allocated in parse_txq_prior() with
rte_zmalloc() but never freed. It leaks on dev_close / re-probe. Free
it in the close/uninit path (and note it is re-allocated every time the
handler runs, so a repeated key would leak the prior allocation too).

Warning: txq_prior is control-path, CPU-only data; rte_zmalloc()
consumes hugepage memory unnecessarily. Use calloc()/malloc().

Warning: the parsed value is OR'd straight into TBMR:
	tx_en |= priv->hw.txq_prior[tx_ring->index];
with no mask. ENETC_TBMR_EN is BIT(31) and there is no TBMR priority
mask defined. A user value with high bits set can corrupt unrelated
TBMR control bits. Mask the input to the valid TBMR priority field.

Info: strdup(value) return is not checked; on failure
strtok(input_str, "|") is called with a NULL first argument, which
resumes from strtok's stale internal state rather than erroring.

Warning: new devarg "enetc4_txq_prior" not documented in
doc/guides/nics/enetc.rst.


[PATCH 10/10] net/enetc4: add cacheable BD ring support with SW cache

Warning: enetc4_dev_hw_init() switches rx_pkt_burst/tx_pkt_burst to the
cache-maintenance variants unconditionally for every enetc4 device
(PF and VF). The commit message scopes this to non-cache-coherent
parts (i.MX95), but the code applies it everywhere, adding dcbf/dccivac
cost on cache-coherent platforms that previously used the _nc fast
path. Gate it on a devarg or coherency/platform check.

Warning: the RX payload invalidation uses dccivac (dc civac =
clean+invalidate). The comment justifies clean-then-invalidate for the
BD ring (refill dcbf leaves BD lines clean), but payload buffers are
not cleaned before being handed to HW. If a payload cache line is dirty
(stale CPU data from a prior use of the mbuf), the clean phase writes
it back over the HW-DMA'd data in DDR before invalidating -> silent RX
corruption on a non-coherent part. Please confirm payload lines can
never be dirty here, or use invalidate-only.

Info: struct enetc_bdr gains "uint64_t bd_base_p" but it is never
referenced anywhere. Remove the dead field.

Info: the 64-bit BD fast copy
	__uint128_t *dst128 = (__uint128_t *)&rxbd_temp;
	*dst128 = *(const __uint128_t *)rxbd;
takes the address of an 8-byte-aligned stack union (rxbd_temp) as
__uint128_t*. That is an under-aligned 128-bit access (UB); aarch64
tolerates it via ldp/stp but it is fragile. Force 16-byte alignment on
rxbd_temp or copy as two u64.


General (series-wide)

Warning: no release notes. The series adds user-visible features
(scatter-gather, cacheable BD ring support, four new devargs) with no
entry in doc/guides/rel_notes/. New driver capabilities and devargs
need release-note coverage.
