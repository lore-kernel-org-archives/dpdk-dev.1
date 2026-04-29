Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4F3FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 15:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C7D3402EE;
	Wed, 29 Apr 2026 17:37:10 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id CC39A400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 17:37:08 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c726f46baso16630025c88.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777477028;
 x=1778081828; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLlgeTc4S+QCJ2MN+hLURRFA56X31lVq8IGxOIyE108=;
 b=fd9CYNK1trRD/AOYMEbXRJCdC+XCaXSrXOkl3b07tNrYucUSofj+dNE4QY7rCXoted
 qonR+kzOz8jP/kvlepoChUDF/E9ruBW1vKGBBPa9pClbvHic+Pi7w7ChYECFe8lqjRar
 Tligy9/0ZfSJcZu542baRB9RLLY+KdsawciWSjsf+HSqoGAXp3f50pWQoXVVuY6hNK/E
 dDkn5ZMtKrHcGboH4kpALQxX7Pn7F+Pn7DtCxOLUmxg5F7QtxRG1dnM9Ujn40UcXlHVS
 iKA0PSQ8AnnBIIy5Mzs/QOYF611C6OH5W9Jy+pJ2zPNnONmxsiFRHE8Cx/E1xaVZ+gsv
 FcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777477028; x=1778081828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLlgeTc4S+QCJ2MN+hLURRFA56X31lVq8IGxOIyE108=;
 b=I18ooo6r8J3RtNcXmQqmdXbazwG3Dh/VI1V2apvS2czbYO2Yw35zrM2tFkjbRK2E8/
 bsHFygI0nBxgyNl1t/ygQEihfTi64iF1cLTVY3v0Z54oG2qz0tUa6vR7tAyUn5PP83fI
 w4LhK803hH1Ad0z/1hKnk8C7PWKz5Dz+hvnf7Sm/dKGnoUv5ucd/kStSeCfOyi0Y+tEp
 6653UHvpziaN3npEF3wpIkXwqtDQA6NjTmDv4HnijfOiy5207sPHRpEmiBSVjP0shJTW
 DRJDFmNdhGgvSIGLpM+cxN6ZzyYEL+PNv+8MEHMXZWIjMV0M0hBdIuTriQb47wOgPtP8
 PE5A==
X-Gm-Message-State: AOJu0Yyh11ebvtMVTMZT8XT5zvhdRoYYn99eqMNEVoGpwujqLDNq6PBM
 jYyT7+rxx0i/MHRJ9hAm5G1g3d7jCmAIdRSFSjnQpAhG7WgXa1zWdbckRYm5P1aVssU=
X-Gm-Gg: AeBDieuXpwOz0Grju26pVmzipq2Y6tWHuuLz5mLx1mYbeQR/bBlRIZFiK058NsPyoln
 fY1jDCe6xCB/29JtBPcZml8Zh8zJ/ed+WEBYkeHfwpF2baCeuCELsaL2/p6Rtc/CSO9wdrYFafE
 CiTOZLPMi1MUdq2sAyD42Cu89Njta/gTAh/yZA48xyZQoU0oO/zswigfzdkn60GQ/Jq5/fnFQtt
 uLnzDs713emIJueUeNNF26IFKH2qV1Z+Mb8xGv4ee+1qPbvbha8QMXEcvWNnT94Hrog/iolgkq7
 nHtEcnNrcJQ+NEsub1dsp7UxFksNJRU8iXW6JpZmiIlHmW5YLh6Vqp9eyQhTs82f4c2Z4+it/dc
 nDXDXJZFDzi+CqBU+tOXeo9yLdTSnTc5tkFB7xMrEF/CH3odgxoncLMukFWYPkVicD9xytI1eUd
 0vQgQAhwTBxgc80xxDO/O8rM/Eb17G3ztU9oeE0ajuEdSYaA==
X-Received: by 2002:a05:7022:e04:b0:119:e56c:18b1 with SMTP id
 a92af1059eb24-12ddd9977aemr3941230c88.25.1777477027296; 
 Wed, 29 Apr 2026 08:37:07 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de326a583sm3513354c88.14.2026.04.29.08.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:37:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:37:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [RFC v2 0/6] introduce PTP protocol library and software relay
Message-ID: <20260429083704.5ea3d78c@phoenix.local>
In-Reply-To: <cover.1777413123.git.rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <cover.1777413123.git.rajesh3.kumar@intel.com>
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

On Wed, 29 Apr 2026 03:58:31 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> This series introduces a new DPDK library (lib/ptp) for IEEE 1588-2019
> PTP protocol packet processing and a companion example application
> (ptp_tap_relay_sw) that demonstrates its usage.
> 
> Motivation
> ----------
> Several DPDK applications need to classify and manipulate PTP packets
> (e.g. ptpclient, ptp_tap_relay, custom Transparent Clocks). Today each
> application re-implements its own PTP header parsing and correctionField
> handling. A shared library avoids duplication and provides a tested,
> standards-compliant foundation.


It would be great to have this, though not sure who would use it now.

AI review spotted some things.

Reviewed v2 of the PTP library series. Findings below.
Patch 1/6 (lib/ptp):

RTE_PTP_ETHERTYPE 0x88F7 duplicates RTE_ETHER_TYPE_1588 already in lib/net/rte_ether.h. Use the existing constant or alias to it.
Comment on the version byte says "reserved (4) | versionPTP (4)"; IEEE 1588-2019 redefined the upper nibble as minorVersionPTP.

Patch 2/6 (prog guide):

The guide declares rte_ptp_hdr_get(const struct rte_mbuf *m) but the header has it non-const. Fix the doc, or split into const and non-const variants since the function returns a writable interior pointer.

Patch 3/6 (ptp_tap_relay_sw):

The standalone Makefile is missing CFLAGS += -DALLOW_EXPERIMENTAL_API. All three rte_ptp_* APIs the relay uses are __rte_experimental, so make-based builds will warn or fail under -Werror. meson is fine because meson.build sets allow_experimental_apis = true. Match examples/ptpclient/Makefile.
relay_burst() calls rte_ptp_classify() and then rte_ptp_hdr_get() on every event packet, parsing it twice. The prog guide added in 2/6 explicitly tells callers to use rte_ptp_hdr_get() once and then rte_ptp_msg_type(hdr). The reference example should follow its own guidance.
Minor: stats.corrections is updated via the global while the other counters are passed in by pointer. Inconsistent.

Patch 4/6 (sample app guide):

Limitations section claims L2-only and PTPv2-only, but the relay uses lib/ptp classification which handles VLAN/QinQ/UDPv4/UDPv6 with no version filter. Reword to "tested with L2 PTP" or drop the restriction.

Patch 5/6 (test_ptp.c):

Several correction tests dereference the rte_ptp_hdr_get() return without TEST_ASSERT_NOT_NULL: test_ptp_correction_zero, test_ptp_correction_known, and the four test_ptp_add_correction_* tests. test_ptp_two_step and test_ptp_seq_id get this right.
No coverage for IPv4 with options (IHL > 5). The library's offset += ihl path is exercised by no test.

Patch 6/6: no issues.
