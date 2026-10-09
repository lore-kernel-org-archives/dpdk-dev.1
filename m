Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBEFCA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 19:09:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E29440274;
	Fri,  9 Oct 2026 21:09:49 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 304CE4026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 21:09:49 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ab3260b2cdso685250a91.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791572988;
 x=1792177788; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ed/p9sG0k6/w33v4zmBhPF+LTZ9NrUp2wOS6Rn6c4h0=;
 b=qNYuSWESrljmF9mT1HRZ02EWYyktGMwhFmBfaRlBCSrzNi/r335NyuZqQp6kvgGVI4
 MTO3nM6bc5KmyoYXFpBKatFBLzzuRpwqeUwA+aX8Icvx/6sumg7NX88TJDrJLTflDj2b
 csxf4VcKKGODv8d95A6pjsMv0S75u2OqMPSLru1I2RAofSghFWcjOCLjIV5BEjE9p/e0
 Fsz8LoPhqKfrN8FNiPVVqIOBQUXM4lpRCfjmAUqHy4GjjXT7kCH40Uoq81XXYHoQ4Qc2
 v2k0GbdrJgs63lnv86jEgw/aFoLGugVKyHS80+jrm90Y6+XyGSO7WVBt2l5dYNQFMkBO
 xCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791572988; x=1792177788;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ed/p9sG0k6/w33v4zmBhPF+LTZ9NrUp2wOS6Rn6c4h0=;
 b=SJNjTJzg7GF64fDX0N8Xoui4YC70aG4jyPDSlCKGY1zFAMNnK+IoHedhBZhme1QMBA
 RNDRntTYu1DtuFLuCRxxEPHw0sRa+TjnuyK9lAcGII7VoR7qn0r2ARY9u2S45HO1eRzx
 gXSbHGnkxg86yVykit6FiXvs2yynYlMFH6VZVJ+FtdIxSpn0ccVxUeVqydjstcir3Ms4
 4+wYefVcsG0g5hKNNyKx8Z9XHc/FrdIKB7R+KlwHqIvgFNx2A0i5fH2u2qOGiY6k9bnF
 8XFRxz/qmZ3MqyJRyjeDTaqlfRpEAT1nxDhAzhN8oIn33wvNtBGLwb7P13LAMl/+Mff6
 WXsg==
X-Gm-Message-State: AFq9FYI7q9ESXII6FSlYRC8RDgExTs/bRKxgj9jtt9BsG9gsY3Sn0iuz
 Taxo1ovNvwjyjj8DF4rNLkMjASl8QwYT76raP+Yh8OWHZRuEWjDrvsyT2vDvaIxoorg=
X-Gm-Gg: AYBFou25ofq1JkmpgEHMWME9UhzKwOl0gbWUeaVpUaLhCY+29F3rjkYbt6pxruB4KWl
 0BCUaKq94b/wqQCmUpT0edVvgNg4UOgk8jblQi7RNDCN5bb/X02Ely1I4RLxOrdIWl13t8cEJCS
 wRh02wGZ1Z0lEFrd3tzZ9FdHJsKjYQU3k6ZTyoHgsBU4gQx/6Bh+ibCjaiuKAsjbLxN4q7EpYtX
 R2+5szDbXV8u3cZhTv4axTRjyRgyeq1nK60+S2fir1+fgBMVtEaDDeJNpTnFDrTTRDUcQHZC/mr
 rNUMY/USCanzAHvp4Rp21vZZFx4yzr4WvRtOX6GWGrxW0CklLddFJgAsSk5PyNd3QyhOplNbwtd
 zspzUKb4af8S5t02lw6QAbdUIzH735Xi4cWycff1/n5yqiJXE8YDDFsGk0epksEcaQdpfa1U1A1
 XbdE/DHuCnU90uA25gCPBna+mKlQq8JMppGXliTGjh/QdizVSWs+anZqTsCV2TuNXxn0s3i8GEE
 QsXINGPWC7RMVGgJ9OR5xgA4lV7u8TJR2rsBOcJrQ==
X-Received: by 2002:a17:90b:3c08:b0:3a4:d338:4156 with SMTP id
 98e67ed59e1d1-3ab3ae6ae4amr2247361a91.52.1791572988093; 
 Fri, 09 Oct 2026 12:09:48 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab32d5a429sm2871785a91.0.2026.10.09.12.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:09:47 -0700 (PDT)
Date: Fri, 9 Oct 2026 12:09:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8-S2 00/13] net/dpaa2 updates
Message-ID: <20261009120930.6f8d20e8@phoenix.local>
In-Reply-To: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
References: <20261007060227.219835-1-prashant.gupta_3@nxp.com>
 <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
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

On Fri,  9 Oct 2026 16:18:47 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This is the second of four series upstreaming the missing NXP dpaa2
> driver changes. It does not depend on series 1 and can be applied
> independently.
> 
> Changes in v8:
> - Address review comments for meter and policing support.
> - Add meter resource cleanup during device close.
> - Add policing capability checks.
> - Validate burst size ranges before hardware programming.
> - Fix software/hardware state consistency on profile/policy updates.
> - Clarify and guard default flow-miss handling.
> - Use standard FDIR reporting for flow-steered packets.
> - Document and gate minimum DPNI version for 24-byte flow keys.
> - Fold parser fixups into originating patches.
> - Remove unused VXLAN offset helper following soft parser removal.
> - Update release notes placement and content.


Although review of S1 was clean and now in next-net, the second part
still has open issues:

Review: [PATCH v8-S2 00/13] net/dpaa2 updates

Applies on top of v7-S1. Most v7 comments are addressed (mtr deinit,
policing check, update ordering, FDIR_ID, key size gating, miss
flow note). Remaining items below.


[PATCH 05/13] net/dpaa2: support meter and policing

Error: the burst size check in dpaa2_mtr_profile_add() is pasted
twice. Remove one copy.

Warning: meter_create still drops meter_lock around
dpaa2_mtr_hw_program(). If control operations can be concurrent,
there is a race here; if not allowed, what is the point of
meter_lock? Either hold it across check, program and insert, or
drop the lock.

Info: fsl_dpni.h removes DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS but
leaves its comment ("Do NOT reset counters generally for policer
update") and an extra blank line where the _v1 prototype was.
Remove both.


Release notes (05/13, 07/13)

Error: not changed from v7. The "Updated NXP DPAA2 net driver"
block is still above the "New Features" heading, duplicates the
existing "Updated NXP DPAA2 ethernet driver" entry, and still lists
"Tx queue based flow control" and "software parser based packet
dump", which this series does not add (12/13 removes the soft
parser). Move the meter and miss flow bullets into the existing
entry under New Features:

* **Updated NXP DPAA2 ethernet driver.**

  ...
  * Added support for traffic metering and policing (rte_mtr API).
  * Removed ``DPAA2_FLOW_CONTROL_MISS_FLOW`` environment variable.
    Use the rte_flow API to steer unmatched frames.


[PATCH 10/13] net/dpaa2: restructure dpaa2 parser processing

Warning: the new code in dpaa2_rxtx.c is indented with spaces
(about 100 lines, e.g. dpaa2_dev_rx_mbuf_sched_set()). Use tabs.

Warning: the commit message is stale. It still says "Restore Rx
timestamp" and "Drop RTE_MBUF_F_RX_FDIR", but timestamp is already
handled at 08/13 and the code now sets RX_FDIR | RX_FDIR_ID. Drop
both bullets. Also rename dpaa2_dev_rx_mbuf_sched_set(), it no
longer calls rte_mbuf_sched_set(); dpaa2_dev_rx_flc_info() or
similar.
