Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5701260A2614
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=tBiDekY3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 158C140283;
	Tue, 20 Oct 2026 15:45:22 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id C584040150
 for <dev@dpdk.org>; Tue, 20 Oct 2026 15:45:20 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1069767a12.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792503920;
 x=1793108720; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uaZcxwHkNklPvkgsn56Z8G5buKaVyFTeqXs5ELmUxa0=;
 b=tBiDekY354Lh22tcc1Sl6JFuVt+uWVJkvNSt3qGoyoPEt9kVAxjWOgOXCv8v5AfSUl
 LW8EX2VYJxng97o8pZN+Pkxr1h6tf21ndIbrFOjA0eLBG7FIwG9rNIyL9NVtXZPpIgSL
 bhMAVFwpBrbTm9x6kaxU9/NQC7VReHHPo5rwPJv/dys7Buqtj/OJWMng2k/GZpftgKI0
 M1WTacxdFEg4SqIqlD58AIoYK8ODWS8x1Io9etnXXHqL9I926c3GTrzthNSMANy1DbPu
 w0OwYwdHFZIcG1kUmB2g6UJFz3mCTtVMZIyGrOzRPvdR3iOYhp3Nlgvk4pgvGs0fQLR9
 KwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792503920; x=1793108720;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uaZcxwHkNklPvkgsn56Z8G5buKaVyFTeqXs5ELmUxa0=;
 b=ccFZOxSFp1gNAAljtyw+sL/qnzbngyPgiW+Mec7xvp6ssdPBxrTF7VVGX/ZStxpL7N
 2/YNm4WpNvBdv2KKWJvr/v7tr1d+2ycGmyQpKjxH9cMn4uw8/c8cB79xO+K8+mtUQ3jT
 STukXuZKCY+LTGyFDEZ3W9Vhk0ZKlAqm7fSS3jGA5/fSg0l3wsAXfCEpuXRXgN7B2G++
 wBsKdtmmBaThUgheccQ5Zzi5wO2g2MW82nd4eaENYSgvpZSoKczBlhwBtL01uzIllT3M
 Ib2Qoci3U/olAMIeOOOmRzwq2TKOI8oiIxBfdvKjnfBB0b1/50wfMKuFm4DDlmOOE0/a
 VeOw==
X-Gm-Message-State: AFq9FYL8RvL9c+WXR1ocq5HBmegKir+H031bCnukZb7e5ldrk6xt6n9B
 gKxchtL7pgk92gDonht+2XxnZaklj0Z0Xnn10qtxTr01bbHwpU6iWDWm1azLGcGbmGQ=
X-Gm-Gg: AYBFou3ZsrxNOgH+CXRuWRr5NykxsZyy0ZfitqBCuPFlpS9MtJOwuOY2oH4WhMzz0BJ
 ElJF912GJLeeSFpRumMULoBXngA0bvtQuaSSvIeRJJ6KKN1G6McB8azS7/gL3f3K2i/NNUE9Oig
 CIogXxwG5N8SX3kHR4NWdDyZdtqeEG7QWBcCrMWKfr5z0o8T3WP8r9ECHLOmOF0CSmA31poSSjn
 KEnjBYUimB6sS+0d9P8mVWSI+xVGAF4ij3LHG3enHQJ+X4CtFqeyrT6ByHSrjQB1gViptBJeUtS
 hZZ485cdielmMTICEeLoJSY1bjX3fnvTcHBkeBKG/kQG5P8W7mOfLcHOW/Rp+4hscJYjo5nxSgD
 2biTaOnmnd4tXYdDhtr4VcYjQKTGgb4ShJXXAFxONelJBX9UooCfuebLZEbWtKmLq01TJIX2wuL
 D/wpVyPEzPVTJw95WKsfd7OCTiTgRYPdpsgnbMf58x6pmT1c+95K8dJ+rseQPjnHCnbXcQLTXh+
 JH5Q6E5mvM+yOnyWOVrFjRHyalN6WJ4tauIyd+s
X-Received: by 2002:a17:90a:dfc8:b0:3ad:6738:db14 with SMTP id
 98e67ed59e1d1-3ad6738dc0amr2047478a91.55.1792503919727; 
 Tue, 20 Oct 2026 06:45:19 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad5d4004cbsm3706133a91.3.2026.10.20.06.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:45:19 -0700 (PDT)
Date: Tue, 20 Oct 2026 06:45:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Jun Yang <jun.yang@nxp.com>
Subject: Re: [PATCH v12-S2 10/11] net/dpaa2: remove unused soft parser driver
Message-ID: <20261020064517.370bd9aa@phoenix.local>
In-Reply-To: <20261016070339.3011744-11-prashant.gupta_3@nxp.com>
References: <20261015092513.2427856-1-prashant.gupta_3@nxp.com>
 <20261016070339.3011744-1-prashant.gupta_3@nxp.com>
 <20261016070339.3011744-11-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 12:33:38 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> From: Jun Yang <jun.yang@nxp.com>
> 
> The DPAA2 soft parser (SP) byte code has to be installed by the boot
> firmware before Linux starts; the WRIOP parser cannot be reprogrammed once
> the MC is up. Loading an SP image at run time from the PMD therefore never
> took effect, so the loader and its DPNI_SS_INGRESS plumbing were dead
> code and are removed.
> 
> The rte_flow VXLAN and eCPRI pattern items were only ever accepted while
> an SP image was believed to be loaded. With the SP gone they are rejected
> by dpaa2_dev_verify_patterns() before the configure switch is reached, so
> their handlers dpaa2_configure_flow_vxlan() and
> dpaa2_configure_flow_ecpri(), the switch cases that call them, the mask
> descriptors and the VXLAN_HF_VNI helper are removed as well. The eCPRI item
> is also removed from the dpaa2 feature matrix so that the documented
> capabilities match the code.
> 
> Signed-off-by: Jun Yang <jun.yang@nxp.com>
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
> ---

Sigh. AI review said "I am sorry last review was wrong.."

Subject: Re: [PATCH v13-S2 00/10] net/dpaa2: ...

Series applies cleanly to 26.11-rc1 and every commit builds with
-Dwerror=true. Feature matrix now matches the code. v12 comments on
patches 1, 7, 9 and 10 are addressed.

One problem left, in patch 6.

Still needs a separate fix, outside this series:
dpaa2_flow_item_convert() allocates num items and writes num + 1
(the END marker).


Patch 06/10 net/dpaa2: set default flow miss action per device

Error:
  My v12 comment got the mechanism wrong. priv->nb_rx_queues is the
  DPNI hardware count (num_rx_tcs * num_queues), not the application's
  queue count, so dist_size - 1 is always a valid FS flow id. The
  problem is that the queue may not be set up.

  Rx queue i maps to tc = i / dist_size, flow = i % dist_size, and
  dpni_set_queue() and the taildrop setup only run in
  dpaa2_dev_rx_queue_setup(). On a 16-queue DPNI where the application
  configures 4 Rx queues, unmatched frames go to flow 15. Nothing polls
  that FQ and it has no taildrop, so frames pile up and hold buffers
  until the pool runs out and Rx stops on every queue. The old default
  of 0 was always polled.

  Use the last queue the application actually configured in this TC:

	uint16_t nb_rxq = priv->eth_dev->data->nb_rx_queues;
	uint16_t first = tc_id * dist_size;

	tc_cfg.enable = true;
	tc_cfg.fs_miss_flow_id = nb_rxq > first ?
		RTE_MIN(dist_size, nb_rxq - first) - 1 : 0;

Warning:
  Release note says the miss flow id "defaults to the lowest-priority
  flow of the device". An FS flow id is a queue index within the TC,
  not a priority. Say which queue gets unmatched frames, e.g.:

	The flow steering miss queue now defaults to the last Rx queue
	configured in the traffic class.

Patch 09/10 net/dpaa2: parse tunnel and fragmented packet types

Info:
  DPAA2_PKT_TYPE_IPV4_ICMP is now (0x0003 | DPAA2_PKT_TYPE_IPV4_FRAG),
  which reads as if ICMP were a fragment. The value is the same either
  way; write it as (0x0003 | DPAA2_PKT_TYPE_IPV4), and the same for
  IPv6.

Patch 01/10 net/dpaa2: fix integer overflow in CCSR region mapping

Info:
  PAGE_SIZE and PAGE_MASK in dpaa2_recycle.c are now unused.
