Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B3C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 932694027D;
	Thu, 27 Aug 2026 23:45:26 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 421CE40150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:45:25 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so3415265ad.1
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787867124;
 x=1788471924; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rDtRid2adUZdGzTwZiSbf4SUDGNS94qX7v/5dZabbhE=;
 b=G/JOdyuePeRSYbI/FFokMXjps1RvQSeKOonmWYT0Wwl877FrhUXWmhDCiD6dDJADZ9
 sl68ohUuovqMZ5Ujp90A7LIQntQIpJ3AZ8LMzvaQ5ocOOXmcmpmfDP6PPoVc0I0Zlmpp
 TqS5lRWajbnjrsppIW5IGe7xp2OrWLKA1yZ8hcIe/mHmKDDQzXaiK1UoITE1T+Sy1Njo
 nNZDphO5B4Oot//r1VjyMz3Tn6tf3iGJ6UKT8/E4Wvrhgq+8ucHk+uICb3npNbOwHzHP
 OIogmiaJwoqU96TnQGuPniFZXnHk4uMNacZguJLxPAO68ojQQZHp2N2+gCObW3Y3RqA9
 qLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787867124; x=1788471924;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rDtRid2adUZdGzTwZiSbf4SUDGNS94qX7v/5dZabbhE=;
 b=ZwPf10Iaits6J6+Rq11Rb3iVn3xt6TiKmgV2QHQNXuZpIIJ8OrWa5rhPxjNHU58SXB
 0GynbNTfifz7usLzhIe+twAk6pwNXLDV1C+UdJRy5kYlbOYvBTAS3CYocKV78ILBd/hr
 DjodNIA16quFbAKXAJtnvg29Z92iZ0TfnGOOhGvf6PxOEBFszuZWi34zaJZ8sMK/XaKV
 a2vuOJowl/TcikSxm8lr4deZWfOq+P49uaqbwDH0XKyMIJdLcareHIRmM5wC2BvV+nOk
 hVgMQi/3+H4PXEvKF52fl90G5JJXz8iDyFK7FNzTWAotc3dIWhpe0srPDXOGMQMAqDo9
 ReQQ==
X-Gm-Message-State: AFuF++nCPruTg2ljYiHWCr8w6jJ/O9Eqtfqi7G43g6vnPAvFOQiD5MEp
 TWgfn2FwcxYwujkh4bejRpeJPltfcSYvb1phkDUdercBbrbRuXpw0tG7iWkJzw/Nb8w=
X-Gm-Gg: AR+sD122EO50vT3y1nKw+Qv2z022VcZfq0bKOO0zUTfUzCbNqoKG5xy3EydvquJeBZK
 hIXbwWG3F9hbDsk6v+3AEWo6zU1dcznW+3eds5ZwRHQhMGcvQbQbq1ma2dWJbVosPx8PcbtWKJA
 zhKOfTI3Jsgun4vSMgK7pbtCO8kOC29KY9cfISgrSkbRpBt8pgBUgrcDmPIeAfwR5UlbJx4ROvP
 ysi9r+2H9mrpWfnIrme2Rz63hi1yK12Yb71KDVovZY0MPc8msx02igQEM8q48omrFbayPBXDeuv
 cL/N/H0rrJJyzbi3MOAMrHnXqJRh4iE4t6tUCyHDHbkkaxJUOGdNNywCthNl+yKFb5liCfnRdkJ
 L8mdogGwMdsOE9/dGfjBU9Kxq7vbHT7iFdoTZOh1Fv6syvrC9CqUJaug4wg7FhG5TiXPQdnmaDE
 QLLuDKYIE1XT1bsHxirQXtu3PTFRF0i0DE1DiJA2qtUgq/PAlYMo35v5SdO3Y2dUZWVmcfOm22Y
 yPv6b91fUg2WSdNdYwG/e4F2/ww4xO4YKKXpJxj
X-Received: by 2002:a17:902:d483:b0:2d7:4b42:9352 with SMTP id
 d9443c01a7336-2d74dca231amr32086625ad.3.1787867124310; 
 Thu, 27 Aug 2026 14:45:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d63bb23sm23350874eec.7.2026.08.27.14.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:45:24 -0700 (PDT)
Date: Thu, 27 Aug 2026 14:45:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, aman.deep.singh@intel.com
Subject: Re: [RFC PATCH v3 1/1] ethdev: add Tx timestamp slot management APIs
Message-ID: <20260827144512.10cf0616@phoenix.local>
In-Reply-To: <20260827122200.339388-2-rajesh3.kumar@intel.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
 <20260827122200.339388-1-rajesh3.kumar@intel.com>
 <20260827122200.339388-2-rajesh3.kumar@intel.com>
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

On Thu, 27 Aug 2026 17:51:59 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> Extend ethdev timesync with a capability model for selecting between
> shared-register and per-packet Tx timestamping.
> 
> Add public and PMD interfaces to query timestamp capabilities, allocate
> timestamp slots, retrieve timestamps asynchronously, and release slots.
> Slots have port-global scope and can be used across Tx queues.
> 
> Add a dual-domain timestamp structure for reporting adjusted PHC time
> and raw hardware time independently through validity flags.
> 
> Add APIs to register and unregister the mbuf dynamic field and dynflag
> used to pass slot handles to the Tx datapath. Add helpers to associate
> a slot handle with an mbuf before transmission.
> 
> Keep the legacy Tx timestamp API for shared-register hardware and provide
> a compatibility alias for the mbuf stamping helper.
> 
> Document the timestamp capability model, slot lifecycle, and application
> workflow.
> 
> Signed-off-by: Rajesh Kumar <rajesh3.kumar@intel.com>
> ---

Lots of feedback for AI review that needs addressing (Claude Fable).
Also a feature like this needs some form of test coverage. Perhaps
mocking up something in null PMD or related.

Review of [RFC PATCH v3 1/1] ethdev: add Tx timestamp slot management APIs

Applied cleanly to current main and read post-apply. No build
performed (meson not available here); nothing in the diff looks like
it would fail to compile.

Errors:

1. Documentation and Doxygen claim rte_eth_timesync_enable() registers
   the dynfield/dynflag automatically. It does not. The patch does not
   touch rte_eth_timesync_enable(); post-apply it still just calls the
   PMD op. So the .. note:: in timesync.rst ("registers the dynamic
   field automatically ... Call ... explicitly only if creating
   mempools before enabling timesync") and the same statement in the
   header Doxygen for rte_eth_timesync_tx_slot_dynfield_register() are
   false. An application that follows the doc and relies on
   timesync_enable will get -ENOTSUP from stamp_mbuf (or worse, a late
   registration that fails after pools are created). Either add the
   call in rte_eth_timesync_enable() or drop the claim; given the
   "must register before pool create" constraint, dropping the claim
   and making the explicit call mandatory is the safer contract.

2. Commit message says "provide a compatibility alias for the mbuf
   stamping helper". No such alias exists in the diff. Either the
   alias was dropped between v2 and v3 and the message is stale, or
   it is missing. Fix one or the other.

3. Dead macros referencing a nonexistent structure:
     RTE_ETH_TIMESYNC_TX_TIMESTAMP_SLOT_INFO_MAX_VALID
     RTE_ETH_TIMESYNC_TX_TIMESTAMP_SLOT_INFO_FREE_VALID
   Doxygen says they are valid bits for
   rte_eth_timesync_tx_timestamp_slot_info.max_slots / .free_slots,
   but that struct is not defined anywhere. Leftover from an earlier
   revision; remove them.

4. The PMD contract is incomplete: the datapath needs the dynfield
   offset and dynflag bit, but they are file-static in rte_ethdev.c
   with no accessor in ethdev_driver.h. A PMD is forced to do its own
   rte_mbuf_dynfield_lookup()/dynflag_lookup() by name, which then
   cannot observe rte_eth_timesync_tx_slot_dynfield_unregister()
   resetting the library-side cache. So the documented behaviour that
   after unregister "PMD Tx datapaths fall back to port-level legacy
   mode" cannot actually happen: the PMD keeps testing the dynflag it
   looked up, and mbufs stamped before unregister still carry it.
   Either export an internal accessor (offset + flag) in
   ethdev_driver.h that PMDs must use, or drop the unregister API and
   its fallback claim. As written, the unregister function only
   changes library-local state and cannot deliver what its Doxygen
   promises.

Warnings:

5. rte_ethdev.h Doxygen for rte_eth_timesync_tx_slot_dynfield_unregister
   refers to "the port-level ptp_tx_index". That is an Intel driver
   internal, not an ethdev concept; a generic header should not
   reference it.

6. rte_eth_timesync_tx_timestamp_stamp_mbuf() calls
   rte_eth_timesync_tx_slot_dynfield_register() on every invocation.
   Post-registration this is just an int compare, but it also means
   the first stamp_mbuf call can silently register the dynfield after
   pools exist, which the register() Doxygen says may fail. It is also
   inconsistent with the "-ENOTSUP after unregister" contract: after
   unregister, stamp_mbuf will simply re-register (lookup succeeds)
   and go on working. Do the offset check inline and return -ENOTSUP
   if the offset is < 0 rather than re-registering.

7. Slot handles are uint32_t, but rte_eth_timesync_tx_ts_caps has no
   way to express the free-slot count, and slot_release() has no
   documented behaviour for double-release or release of a slot whose
   timestamp was never read. For an RFC that is acceptable, but the
   PMD contract section in timesync.rst should say what a PMD must do
   for an invalid or already-free slot_id (-EINVAL is the obvious
   answer, and the ethdev wrapper could enforce slot_id < max_slots
   if caps are cached).

8. Release notes and header call these experimental, but the new
   eth_dev_ops members are inserted in the middle of struct
   eth_dev_ops rather than at the end. eth_dev_ops is internal so
   this is not an ABI issue, but the ordering in the struct
   (alloc, get_capabilities, read_slot, release) does not match the
   typedef order or the order in features.rst
   (get_capabilities, alloc, read_slot, release). Make them consistent.

9. features.rst adds the ops and API names, but there is no PMD
   implementing them in this series and no testpmd hook or unit test
   exercising the new API. Per contributing guidelines a new ethdev
   API needs at least one driver implementation and a testpmd hook
   before it can be merged out of RFC.

Info:

10. timesync.rst: the "Clock Management & Control", "Rx Timestamp
    Extraction Workflow" and "PMD Implementation Requirements"
    sections use bullet lists with bold term + description; RST
    definition lists would render better. Several lines in the .rst
    are well over 100 columns; wrap at sentence boundaries.

11. In rte_eth_timesync_tx_slot_dynfield_register(), the inner
    braced block for flag_bit is unusual style in DPDK; declare
    flag_bit at function top or at point of use without the block.

12. Blank line separating the slot_release function from the
    "Internal process-local cache" comment is missing; there is a
    double blank line before stamp_mbuf.
