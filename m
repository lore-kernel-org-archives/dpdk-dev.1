Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB23C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 02:56:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EA2E40281;
	Thu, 13 Aug 2026 04:56:14 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id D6F794026E
 for <dev@dpdk.org>; Thu, 13 Aug 2026 04:56:12 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso16361165ad.3
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786589772;
 x=1787194572; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UAL76M5PeBtH2cLnxzZk7w9GZZESwLjrU8HisvFNX3M=;
 b=ouOZN4bibCLJ70btK3ql7DMyy5oU7dzbFCnVpLFh2gv+z9CZx0luYqXYlK5du6wLYL
 uaAuBESWwWm6TAOJGy2bk9vfW2ebK7A3IRy4T+I3JrRdN3+Tvpm365OlSJpdCIprrUnL
 FxsMmzh2SYNatEKU+KEBdWfY5KxLDUdmTCEXV2X7DNQtInrtw/PGX5RkFUX11LBgYJlP
 rckKtp7TeOXPSdEb+pmyJyjqpUr2B/ssbNeKjh5j9Pq3pNDE8dyNs0dG/fyoIMzuMm4u
 l63+/tdVv0nRKCB9Y4039Au+/W3RWis3xAFJoiW1X0bDPm8E0EQupOXrWCV1k3JtAP4k
 sNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786589772; x=1787194572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UAL76M5PeBtH2cLnxzZk7w9GZZESwLjrU8HisvFNX3M=;
 b=YlR1yUi2u0UvcE99eJOS4L62lmZ4MGMRuhiuZhiq+ikRN1UyX1BMVcL3xJj4HtJpvY
 upqq5Q5jt4kLOeuVemlCIDXWvcmWrHeSbsRvkmLujovQ0aMzix8VUAqbUjwdSaU0fzG2
 IYvmiox4btDRDnhwJsRHVAiu4Xf65WEb87bTqTKl+I1WRRedPgM1FpxERSVj1A+SVSfe
 tiRb/brZ7rfci4MmxKPlqW6PcaWGoF6qOAGkY0r3kBTiOtU3UGBZq4gmDjJYFhWz/lKb
 6tIqyLegapf0If07jiqmRLB0/Iz8b5HJRRCFbWSgNTM50tUndao/leQ+tKl5N/0/Ji9J
 csIg==
X-Gm-Message-State: AOJu0YyRqw7Lfq9cPM9vIGiIKjoBLC78j8eQIHyFsHeTNuOOPI+wt/Mi
 yw8LF4ZknYg4U2RbHWtVm0my82BlBHPDZV7TbCZ6BRZ26X7wR0MnY6oPfdYdDi2unLI=
X-Gm-Gg: AR+sD12SMRz3k22R+4jRxq1A6qDZbcFBAi4TLmz3PlglRFJVa3w3T6NSdn10mAUofnI
 vCIPCYpxMbI8IVty5xoNdAFpsUgBWDSp/fG637RobBbTZ+/1UHI+cVjUoooUD1JRZeZ7uv0T09j
 dkvG7k/WK7fcIxmOIn0lQrjh/ljsdfOiJLVfsIisb4/2gTyR8FlbRr9odflRxYdOX+P8KwDbpvy
 P68BgUgKerpgGgXy5OZ/50JeIX2B0lmRx0JMeqxVopTPxe/E5gIMAXNOBlRjEOtAdqzEVtZv6uJ
 H5VU80rENXl5GIdcpefLivSUVN6FE9U27FfJLJUdIg8KtchAlxUSIcEdA7JKpFfKLLbcmSDB/gk
 hOLb7ximjYVagXgGRHOVpkIrbrkZ68t2d3319RUsD4NBfFXFaXSFZAxwWIecO9gZX+iSP6a+MV9
 Vf4Keow4rr8Dm4v69fTM4mEYQOtvirnerwDjX24AKEqGfm4enbYraFlIwa+12F0WPNBZ2GZ+YnH
 PPFlVzWigjPXje5zkiBplFTl+wgNw==
X-Received: by 2002:a05:6a20:7486:b0:3c3:8d4c:6673 with SMTP id
 adf61e73a8af0-3cc554929dbmr3298446637.37.1786589771513; 
 Wed, 12 Aug 2026 19:56:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ec08284f4sm2119913eec.31.2026.08.12.19.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:56:11 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:56:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com,
 joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v5 0/2] net/af_xdp: add Rx timestamping and read_clock
 support
Message-ID: <20260812195600.3ab13287@phoenix.local>
In-Reply-To: <20260812233637.1968454-1-blasko@google.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260812233637.1968454-1-blasko@google.com>
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

On Wed, 12 Aug 2026 23:36:34 +0000
Mark Blasko <blasko@google.com> wrote:

> This patch series introduces support for dynamic RX timestamping and
> clock querying in the AF_XDP Poll Mode Driver.
> 
> The first patch introduces three new vdev devargs to specify
> layout-agnostic metadata offsets and bitmasks for extracting hardware
> RX timestamps from XDP metadata into the mbuf dynamic timestamp field.
> 
> The second patch implements the read_clock ethdev operation, querying
> ethtool for the interface's PTP Hardware Clock index at start and using
> clock_gettime to query the NIC hardware clock time.
> ---

AI still reports some things that should be addressed.
I can fixup the long lines and check-git-log complaints if needed.


Patch 1/2: net/af_xdp: add af_xdp rx metadata and dynamic timestamping
 
Warning: rx_queue_offload_capa still claims a per-queue capability the
driver does not implement.
 
	if (internals->rx_timestamp_offset >= 0) {
		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
		dev_info->rx_queue_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
	}
 
  eth_rx_queue_setup() still takes rx_conf as __rte_unused and derives
  rx_timestamp_enabled solely from dev_conf.rxmode.offloads.  An
  application that enables the offload per queue rather than port-wide
  gets a silent no-op: no dynfield write, no SIOCSHWTSTAMP, no error.
  doc/guides/nics/features.rst is explicit that "Timestamp offload"
  [uses] rte_eth_rxconf as well as rte_eth_rxmode, so claiming it in
  af_xdp.ini implies honouring rx_conf->offloads.  Either OR
  rx_conf->offloads into the condition, or drop rx_queue_offload_capa.
 
Warning: eth_af_xdp_enable_hw_timestamping() still treats any
pre-existing filter as good enough.
 
	ret = ioctl(fd, SIOCGHWTSTAMP, &ifr);
	if (ret == 0) {
		if (config.rx_filter != HWTSTAMP_FILTER_NONE) {
			close(fd);
			return 0;
		}
	}
 
  If the netdev is already set to a narrow filter -- ptp4l leaves
  HWTSTAMP_FILTER_PTP_V2_EVENT, for instance -- most packets carry no
  valid timestamp, but the PMD reports the offload as active.  With no
  validity mask configured it then copies whatever is in the metadata
  area into every mbuf and sets RTE_MBUF_F_RX_TIMESTAMP, which is worse
  than reporting nothing.  Accept only HWTSTAMP_FILTER_ALL and
  HWTSTAMP_FILTER_SOME, or at minimum log the filter that was found so
  the mismatch is diagnosable.
 
  Related: config.flags = 0 on the line below discards the flags read
  back by SIOCGHWTSTAMP.
 
Warning: doc/guides/nics/features/af_xdp.ini entry is in the wrong
place.  The order in the .ini files has to match default.ini, where
"Timestamp offload" sits between "Promiscuous mode" and "Basic stats".
It is currently immediately after "Link status".
 
Warning: parse_hex_arg() does not validate the conversion.
 
	unsigned long val = strtoul(value, &end, 16);
	if (val > UINT8_MAX) {
 
  end is passed to strtoul() and then never looked at, and errno is
  neither cleared nor checked.  "=junk" silently yields 0 and "=0x1zz"
  silently yields 1.  The zero case is caught later only when a validity
  offset was also given.  Checking end != value && *end == '\0' is two
  lines.  parse_integer_arg() above has the same gap, so if you would
  rather fix both in one place that is fine by me.
 
Info: "RX" should be "Rx" per devtools/words-case.txt, in the
af_xdp.rst sentence about the 64-bit timestamp and in the release notes
entry.
 
Info: the accepted ranges are not documented.  probe rejects a
timestamp offset outside 8..256 and a validity offset outside 1..256,
but af_xdp.rst does not say so, and the lower bound on the timestamp
offset in particular is non-obvious.  Worth one sentence per argument.
 
Info: nothing rejects a validity offset that lands inside the eight
timestamp bytes.  The example was fixed in v5, but
xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=4 is still accepted
and cannot be what anyone meant.  A check at probe would be cheap.
 
Info: the CAP_NET_ADMIN and HWTSTAMP_FILTER_ALL paragraph is appended
to the xdp_meta_rx_ts_valid_mask subsection but describes behaviour of
all three arguments.  It reads as if it applied only to the mask.
 
Info: errno is read after close() in
eth_af_xdp_enable_hw_timestamping().
 
	ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
	close(fd);
 
	if (ret < 0)
		return -errno;
 
  close() may overwrite errno.  Save it before closing.
 
Info: the zc and cp paths express the same computation two different
ways (rte_pktmbuf_mtod_offset() vs manual (char *)pkt - off).  A small
static inline taking a base pointer would keep them from drifting.
 
 
Patch 2/2: net/af_xdp: add read_clock support to AF_XDP PMD
 
Info: the ptp_fd cleanup in eth_dev_close() still sits above the "out:"
label, so it is skipped on the path that does
 
	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
		goto out;
 
  and "out:" then frees process_private with the fd still in it.  This
  is unreachable today because the secondary installs dummy burst
  functions and never starts, but the patch does initialise ptp_fd in
  the secondary probe path, which implies otherwise.  Moving the close
  below "out:" and before rte_free() makes the pairing obvious and
  costs nothing.
 
Info: the PTP device is opened on every dev_start regardless of whether
the application will ever call rte_eth_read_clock(), and a failure is
logged at WARNING.  On a PTP-capable NIC without permission to open
/dev/ptpX that is a warning on every start for applications that do not
use the feature.  INFO or DEBUG would be quieter, and the -ENOTSUP from
read_clock still tells anyone who cares.
 
