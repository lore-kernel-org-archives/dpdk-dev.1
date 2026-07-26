Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3F3C531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 17:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2C9840269;
	Sun, 26 Jul 2026 19:01:47 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 3E09440150
 for <dev@dpdk.org>; Sun, 26 Jul 2026 19:01:46 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-381b831d535so2400104a91.0
 for <dev@dpdk.org>; Sun, 26 Jul 2026 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785085305;
 x=1785690105; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3CtWPuciCTKQp4ybK+gcV7nzLC1zD0Ffnqbt35/9mNY=;
 b=GgdfRa71NXedOzu6fyt+dOTZOZfVw0zR574CN1oAyynL/uqTi1LH6q7ZFNzRJdqva9
 flvCCNCi5nbGNtxXDTBaMOaj6pYFQCWjmOGsHsSji9insaB7Qet0F/56VLT1hp4NSTYM
 31Y+qA2go4+MqW+RejhA3iwFwSObaXB8kmMNMRtWNW2o+lwH1FjB96H+PBRfFNQ91PiK
 F5PrTVtYpb3Etqh9nmN3wDxwyJFEn3uocElOTszbu9qjnZ4+2bUiiPCSRMU9r3AUGj4x
 dziGiYh1cXCvVBsat0cx5DrBXlhK0HxdYVuEFsDmtLYGLueArVz1+OhoHNHpJ195+LW/
 5Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785085305; x=1785690105;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3CtWPuciCTKQp4ybK+gcV7nzLC1zD0Ffnqbt35/9mNY=;
 b=gQInOPVdtSOd2bFX9cm16HrJrRyKS6FuB+o1jxaPsbrCUGOJJBuJMnkng/0skF5Rq0
 fSDzgBeOmbBZt/SbMJ5Ik7RJNHGJJFoX/Fr7LGflijdzqbYAI5lm+9I4UkGzt1BSD3S6
 Z/lXcJDEkaJwT+uumASThjEMhBaYLTNm31peqd0svmB9DEId1+MHrFG64duS49sptCKf
 9YHM1drhhMAIYE6pHry1xEJUZNEcuurDuzi8sx76Hfi924dORx3Ica9sJBgmHQTRgRhx
 0DKjZXxtklSokPnle0dZYAGF/IIVuniyzctvDvmx0fEt0+pW3iySNmtR0qUSGO8q5i7m
 pBRA==
X-Gm-Message-State: AOJu0Yxj5mpPhIX2Mlm/1q9OxERIjsXn0uUf7asV1AYsMk+uEVvAMB1v
 Jfa2Ljn+20XugSxLzbnt7fi6WknlmKlScFZ/rBMkT8L95VYkErARWA5lYywrMIvnjPw=
X-Gm-Gg: AR+sD10/xko6bD6rC8UxYy8jsGZMt1OL0Tm28/CEjuYFyyJvl7gA5B5RGf3pWsQtfTd
 7fcwf5cC316NkYqFnwZIQMx9bH4tM9XGKPf4bbWaH3CEGgUknLba0K58QUS7ftjkjq+iE7ClqmY
 4S4jqJNmdpMGgU7G/kMngSSRYzdfThe/9534eEuWVv9YqnlSXdNUeT2xM5RJk+hvpLmw5t3C5ay
 iWMKHZaTe7rHUV+Dr3gz8jWpOMusp2luHL2RMfHD1vdcEdJmqg82s/uhfqFUcpQKhQ0feWrt7wi
 bVpugQ/kAU7xUnCHXnt+Fk8ralmHD5heRF4yKjv3b4Nhv0SNRlM7EvyyEEca722INOUXKQi5CjU
 nlGcwUsBjjD9+tLDG2IZcZ4bQCIZIUWTSqJyg9Xgumk9nnOP1lcbC3z4lVEi6k5pqPiQwNeTmUv
 UFdIeHcULFfJUi47B09I+Rf/C8Z/ejSTrMi9a8SbjEcjg=
X-Received: by 2002:a17:90b:3c02:b0:384:5b5b:3465 with SMTP id
 98e67ed59e1d1-38f29780558mr5882003a91.29.1785085305028; 
 Sun, 26 Jul 2026 10:01:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm23300649eec.29.2026.07.26.10.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 10:01:44 -0700 (PDT)
Date: Sun, 26 Jul 2026 10:01:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mark Blasko <blasko@google.com>
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, joshwash@google.com, jtranoleary@google.com
Subject: Re: [PATCH v3 1/2] net/af_xdp: add af_xdp rx metadata and dynamic
 timestamping support
Message-ID: <20260726100141.6dd2fa86@phoenix.local>
In-Reply-To: <20260721121129.2911774-2-blasko@google.com>
References: <20260623215325.814776-1-blasko@google.com>
 <20260721121129.2911774-1-blasko@google.com>
 <20260721121129.2911774-2-blasko@google.com>
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

On Tue, 21 Jul 2026 12:11:27 +0000
Mark Blasko <blasko@google.com> wrote:


> +xdp_meta_rx_ts_offset
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``xdp_meta_rx_ts_offset`` argument specifies the byte offset of the 64-bit RX
> +timestamp within the XDP metadata headroom area (prepended before packet data).
> +
> +.. code-block:: console
> +
> +    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8
> +
> +xdp_meta_valid_hint_offset
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``xdp_meta_valid_hint_offset`` argument specifies the byte offset of the validity
> +flag byte within the XDP metadata headroom area.
> +
> +.. code-block:: console
> +
> +    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=4
> +
> +xdp_meta_rx_ts_valid_mask
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``xdp_meta_rx_ts_valid_mask`` argument specifies the bitmask (in hex or decimal) used
> +to verify timestamp validity at ``xdp_meta_valid_hint_offset``.
> +
> +.. code-block:: console
> +
> +    --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=4,xdp_meta_rx_ts_valid_mask=0x1
> +

Awkward to have so many new metadata devargs, but I guess if XDP has no metadata standard there
is no better way. Maybe combine into one devarg if all are required?


> +		if (rxq->rx_timestamp_enabled &&
> +		    timestamp_dynfield_offset >= 0) {

You could simplify this if rx_timestamp_enabled was not set unless timestamp_dynfield_offset was known.

> @@ -398,6 +415,29 @@ af_xdp_rx_zc(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  
>  		rte_pktmbuf_pkt_len(bufs[i]) = len;
>  		rte_pktmbuf_data_len(bufs[i]) = len;
> +
> +		if (rxq->rx_timestamp_enabled &&
> +		    timestamp_dynfield_offset >= 0) {
> +			/*
> +			 * Copy timestamp if validity offset is not defined or
> +			 * flag is valid.
> +			 */
> +			if (rxq->rx_timestamp_valid_offset < 0 ||
> +			    (*(uint8_t *)((char *)rte_pktmbuf_mtod(bufs[i], void *) -
> +					  rxq->rx_timestamp_valid_offset) &

Use rte_pktmbuf_mtod_offset() here and below.

More findings from detailed AI review

Review of [PATCH v3 0/2] net/af_xdp: rx timestamping and read_clock

Verified against main at 38f72e5 (26.11.0-rc0).  Driver hunks apply
cleanly; the release notes hunk does not (see 1/2 Warning 6).  Both
patches build with -Dwerror=true, and 1/2 builds standalone, so bisect
is fine.  I also compiled the copy-mode branch by undefining
XDP_UMEM_UNALIGNED_CHUNK_FLAG -- that path is clean too.

The overall approach is sound: XDP metadata does sit immediately below
the packet data in the umem chunk in both zero-copy and copy mode, so
reading backwards from the data pointer is the right mechanism.  The
problems below are about validating the offsets and about where the
PTP fd lives.


Patch 1/2: net/af_xdp: add af_xdp rx metadata and dynamic timestamping

Error 1: metadata offsets are unvalidated, giving an out-of-bounds read
in the Rx fast path.

  xdp_meta_rx_ts_offset and xdp_meta_valid_hint_offset are only checked
  for >= 0 (parse_integer_arg rejects negatives; probe checks the mask
  and the offset/mask consistency).  Nothing bounds them from above,
  and both are used as raw backward pointer arithmetic:

      memcpy(&ts, (char *)pkt - rxq->rx_timestamp_offset, sizeof(ts));

  The window that actually exists is XDP_PACKET_HEADROOM (256) plus the
  umem headroom.  In copy mode xdp_umem_configure() sets
  frame_headroom = 0 and fills the ring with chunk-aligned addresses
  (i * ETH_AF_XDP_FRAME_SIZE), so for chunk 0 any offset above 256
  reads before umem->mz->addr -- outside the memzone.  In zero-copy
  mode an oversized offset walks back through RTE_PKTMBUF_HEADROOM into
  the rte_mbuf header and then past the chunk base.

  The kernel caps metadata at 255 bytes in bpf_xdp_adjust_meta(), so a
  hard upper bound is available.  Reject at probe:

      if (rx_timestamp_offset > XDP_PACKET_HEADROOM) ...
      if (rx_timestamp_valid_offset > XDP_PACKET_HEADROOM) ...

Error 2: xdp_meta_rx_ts_offset of 0-7 silently reads packet data as a
timestamp.

  The read is 8 bytes ending at (data - offset + 8), so the offset must
  be at least sizeof(uint64_t) for the read to stay in the metadata
  area.  offset=0 is accepted today (parse_integer_arg only rejects < 0,
  and eth_dev_start() only rejects < 0), and the PMD then reports the
  first 8 bytes of the Ethernet header as a hardware timestamp with the
  dynflag set.  Require >= 8 for the timestamp offset and >= 1 for the
  valid-hint offset.

Warning 3: changing parse_integer_arg() from base 10 to base 0 silently
changes six existing devargs.

  parse_integer_arg() is shared by start_queue, queue_count,
  shared_umem, force_copy, use_cni and use_pinned_map.  Confirmed
  empirically: strtol("08", &end, 10) is 8, strtol("08", &end, 0) is 0
  with "8" left in end.  end is assigned but never checked, so this is a
  silent misparse rather than an error.  Only the validity mask needs
  hex; please add a separate parse function for it rather than changing
  the shared one, or check *end == '\0' in the same patch.

Warning 4: rx_offload_capa advertises a capability the device may not
have.

  dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP is
  unconditional, but eth_dev_start() returns -EINVAL when
  xdp_meta_rx_ts_offset was not supplied.  eth_dev_configure() accepts
  the offload, so the application only discovers the mismatch at start.
  Advertise it only when internals->rx_timestamp_offset >= 0.  Also use
  |= rather than = so a later offload addition does not clobber this,
  and set rx_queue_offload_capa as well -- features.rst lists both under
  "Timestamp offload".

Warning 5: doc/guides/nics/features/af_xdp.ini is not updated.  Add
"Timestamp offload = Y".

Warning 6: the release notes entry targets doc/guides/rel_notes/
release_26_07.rst.  Main is now 26.11.0-rc0 and 26.07 is closed -- the
hunk no longer applies.  Move the entry to release_26_11.rst.

Warning 7: eth_af_xdp_enable_hw_timestamping() clobbers another
application's Tx timestamping configuration.

  The function reads the current config with SIOCGHWTSTAMP, then
  unconditionally sets config.tx_type = HWTSTAMP_TX_OFF before
  SIOCSHWTSTAMP.  If ptp4l (or anything else) had Tx timestamping on
  while rx_filter was NONE, this turns it off underneath them.  Preserve
  tx_type from the SIOCGHWTSTAMP result.

  Related: the hwtstamp config is never restored on dev_stop or
  dev_close, so the interface is left in HWTSTAMP_FILTER_ALL after the
  DPDK application exits.  Worth either restoring the saved config or
  documenting the side effect explicitly.

Info 8: on socket() failure the function returns -1, and the caller logs
strerror(-rc), which prints "Operation not permitted".  Return -errno.

Info 9: the new ioctl helpers use (caddr_t) casts for ifr_data.  The
existing xdp_get_channels_info() in this file uses (void *).  caddr_t is
a BSD-ism; please match the surrounding code.

Info 10: ops_afxdp_dp (the unprivileged AF_XDP device-plugin path)
shares eth_dev_start, and SIOCSHWTSTAMP needs CAP_NET_ADMIN.  Requesting
the timestamp offload in that mode will fail the start with -EPERM.
Worth a line in af_xdp.rst.


Patch 2/2: net/af_xdp: add read_clock support to AF_XDP PMD

Error 1: ptp_fd is stored in pmd_internals, which is dev_private and
therefore shared memory, but a file descriptor is process-local.

  This driver already has struct pmd_process_private for exactly this
  reason -- rxq_xsk_fds[] lives there, and afxdp_mp_request_fds() /
  afxdp_mp_send_fds() pass those descriptors between primary and
  secondary over SCM_RIGHTS.  af_xdp.ini declares "Multiprocess aware =
  Y", so this is not hypothetical.  Two concrete consequences:

    - A secondary calling rte_eth_read_clock() derives a clockid from a
      descriptor number that is only meaningful in the primary.  It
      either fails or, worse, reads whatever the secondary happens to
      have open at that number.

    - A secondary calling rte_eth_dev_stop() runs
      close(internals->ptp_fd) on an unrelated descriptor in its own
      table, then stores -1 into the shared field, so the primary leaks
      its real PTP fd and read_clock stops working there.

  Move ptp_fd into pmd_process_private, and if secondary read_clock is
  meant to work, extend the existing IPC to pass it.

Warning 2: read_clock is only functional when
RTE_ETH_RX_OFFLOAD_TIMESTAMP is enabled, since the PHC is opened inside
that branch of eth_dev_start().  That couples two independent features:
an application that only wants the PHC time must also enable Rx
timestamp offload, which (per 1/2) reprograms the NIC's hwtstamp filter.
Opening the PHC unconditionally at start would decouple them.

Warning 3: features matrix -- as with 1/2, af_xdp.ini needs "Timestamp
offload = Y".  features.rst lists read_clock as "[related] eth_dev_ops"
under that entry, so the one key covers both patches.

Warning 4: in af_xdp.rst the read_clock subsection is placed under
"Options", where every other ~~~ subsection is a devarg name.
read_clock is a feature, not a devarg -- it belongs in its own section.

Info 5: CLOCKFD and FD_TO_CLOCKID are defined unconditionally with no
driver prefix and no #ifndef guard.  I checked the arithmetic against
the kernel's posix-timers.h definition across a range of descriptor
values and it agrees, so this is only a namespace point -- consider
AF_XDP_FD_TO_CLOCKID or an #ifndef.
