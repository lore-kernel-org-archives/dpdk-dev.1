Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9930C5518F
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 08:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A11C440144;
	Tue,  4 Aug 2026 10:13:30 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id B72F0400D7
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831208;
 bh=LjeFuv3+WFujEH+iopkNLjBOV1Xzrawwiqjtr1MGJsk=;
 h=From:To:Cc:Subject:Date:From;
 b=gC091cJP0MVpPv/ZfmAHDsf2cDIWpdYDSR4mMH4DHuLX+fTX6b+gPxLiUwMLQZyJP
 BkhOV2uh/AKAC9jHd+BIouHKl/C1teYdARoZ1OwhwdYTH0Z8ouu/ydfweD+75SKS9Y
 hYml0RHJs8pfV4WkQw+fNpPNmegxRHoJkRpTRpFjA4m0bGdK+2ym+nS7wK9KOM7H8b
 0tZnay4CMubNUXeHqM1D+eb03IoHVTr5OmbgFrI5LLRbih3cTw1ymdRw1GjxlloM7m
 1lmLMAMr0rQ7SQIviR63CyyGReUJ3pAKYYak96jkKBElacftkZjixzEzMonxQtDGI4
 xAYzb7p9qJf5w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 2FC26F18D
 for <dev@dpdk.org>; Tue,  4 Aug 2026 10:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831208;
 bh=LjeFuv3+WFujEH+iopkNLjBOV1Xzrawwiqjtr1MGJsk=;
 h=From:To:Cc:Subject:Date:From;
 b=gC091cJP0MVpPv/ZfmAHDsf2cDIWpdYDSR4mMH4DHuLX+fTX6b+gPxLiUwMLQZyJP
 BkhOV2uh/AKAC9jHd+BIouHKl/C1teYdARoZ1OwhwdYTH0Z8ouu/ydfweD+75SKS9Y
 hYml0RHJs8pfV4WkQw+fNpPNmegxRHoJkRpTRpFjA4m0bGdK+2ym+nS7wK9KOM7H8b
 0tZnay4CMubNUXeHqM1D+eb03IoHVTr5OmbgFrI5LLRbih3cTw1ymdRw1GjxlloM7m
 1lmLMAMr0rQ7SQIviR63CyyGReUJ3pAKYYak96jkKBElacftkZjixzEzMonxQtDGI4
 xAYzb7p9qJf5w==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 1535AF0C6; Tue,  4 Aug 2026 10:13:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785831206;
 bh=LjeFuv3+WFujEH+iopkNLjBOV1Xzrawwiqjtr1MGJsk=;
 h=From:To:Cc:Subject:Date:From;
 b=MZwH81gO2QoBnBoKkFHBSOBJait5P2wcqK+8HVlbVbbbn19TMemIB32SUPa+rDrvS
 JeDa6p07svRZLjhgqyUrFiFmsTf2m+lePt/TiBJ0bW/o2ORXFZolhWIWe1VWj2CabB
 R7JvZJlQg9kSyeSHH573bK2aoN5GfSZGaX4GPuYt0jobeliF9dNggVA/dvRP6GF/wg
 DHy6ljpN/iHQQLWeJ/ojgjDSk6ZROlAxb/2vk8LWwjte5zM+QWznDKWJcMMSOd6QYS
 FupGf0n3VUW8w4u+mu+JoRCqDfLf1Ri2dzQuB+doNr33rwhek09XlAOelTyzB1Oxhl
 XWr6htlKunlvQ==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 0D129F189;
 Tue,  4 Aug 2026 10:13:25 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: stephen@networkplumber.org, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, sriram.yagnaraman@ericsson.com
Cc: dev@dpdk.org, bingz@nvidia.com, rasland@nvidia.com,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 0/5] fix and complete the eCPRI header
Date: Tue,  4 Aug 2026 10:13:14 +0200
Message-ID: <20260804081319.1869087-1-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

The objective of this series is to make rte_ecpri.h a complete and
correct description of the eCPRI V2.0 message headers, usable for
parsing and building messages, and not only for matching on a few
header fields with rte_flow, which is what it was added for.

The first two patches fix wire format bugs in rte_ecpri.h: missing
fields in the One-Way Delay Measurement message header, and padding in
the Remote Reset one. Both change struct sizes, hence the release note
entries and the lack of a stable tag.

The rest completes the eCPRI V2.0 coverage of the header.

Mattias Rönnblom (5):
  net: fix eCPRI delay measurement message header
  net: fix eCPRI remote reset message header size
  net: add missing eCPRI message field values
  net: allow byte swapping eCPRI remote memory access
  net: add eCPRI IWF message headers

 doc/guides/rel_notes/release_26_11.rst |   8 ++
 lib/net/rte_ecpri.h                    | 164 +++++++++++++++++++++++--
 2 files changed, 159 insertions(+), 13 deletions(-)

-- 
2.43.0

