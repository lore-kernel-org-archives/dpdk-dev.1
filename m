Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA98CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F5EC40272;
	Tue, 13 Oct 2026 11:02:25 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id E7447400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:02:23 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 6AEBF1D0006F
 for <dev@dpdk.org>; Tue, 13 Oct 2026 05:02:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791882143;
 x=1791968543; bh=H0LX49W1W+WEpXqLvBxMhZbMDVvvy9QDGANNfnEhiNg=; b=
 ZR8ZXjpsUPej6vP9w5gmT26V3RfWrbugTHz2eiXoRtc/7jE3M6UHiwq3E90aULex
 xG0u6BZq217adBMs81MCA2YEELANpA+a/nCYdQbU7uxduJ2VNRrt++9Io358cv9i
 PtZ51RVbp/t8Gu9YmjxHxyWTltXy0hW/t5ztH/BZK98iCutDIby+ZS+gis5dT17F
 sKMAlT9B1FYRYMs1wcxBYj8RzNQ/WGxWxcjKtAVd4qTohr7Mg1MCtKhWZmJQEQ6E
 6kbGH1MznPRaHLc9spXYCia/2vYldGWRRCEwoSQFDO7gvCT+xOcme/Ec30eiHpAs
 2/Xqfjgo7lacDyuoL1SEUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791882143; x=
 1791968543; bh=H0LX49W1W+WEpXqLvBxMhZbMDVvvy9QDGANNfnEhiNg=; b=V
 w1530ljLhEVflxBfu6QHw+XrsSCLspWH8EjwbLFxRTtbSqk/Q2soEDo+aWk+pJSG
 iNqIjSjHTgjlTbjnB+k1vVk68DkCT2psxPhlFM8tMjX8rBCvB+G0vqaSOkPKrfgG
 YRVo9Iq3KNARFcOnFOIJ6VzYMK2Hc28EiSc0Hl7CvsShtGNLI6XZI4kvx5gBFdzS
 XlCFl+kwUGoEgNhLcqxR6z+wwtrdjmqs50g2j5cQJGySDHP8IkQQ+XYoa3qy5j+t
 Qu4/HuhBkk41kB1us5YxO1u1zKmVGFLCyR8BWL8E++uiBO9q4LzIjFNe4xKF7LTb
 nkyBZYDlhyDegGQ9Qp0/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791882143; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:egik6uVprwf1BqUY0XnUnrBLxENVsQ9V1uuJYzTgO2O9mCL
 qOMEEfEbbi7Mmkc3mmyDYwyQpEKaqPoynwipzBRyiJUDdleDgR1+6/Slhn5/NYcp
 nnuvwcdYympmAgYKTL9iyNaFOEpz1C61Pu71aXacrUZ2d4MGJTnhXUhR2gnldvui
 Q6TBDBM1xFAxivNWbIDLO2xtMOzfXE9Tt2IcGvEWoHjP0zUPI/uQNoxoEZudVGuo
 XewWVY8xt4rHT+a95u5gM2COKarhm9Pc3xyQe8xk7TFn/PgVt/8mLJZrLPg4m0ZE
 SEWuW7p4DG0yIJ9nzhmwpwQtKMhZAmBzO9xncow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:WnRkjlkrWvrJ6/iBYdrx928RAnxRKAzXrbdTZeiWp/c=:Ivtj+MpAiNwwvEAPSNtr7OQ/TIXbRkS2/GPdkOmkgZU=;
X-ME-Sender: <xms:n_PNas7fTxQRkhnJWdm9k-wgfXR1bT64faVNJy4G2QmXjhXdcnEl1Q>
 <xme:n_PNao19Le50G0joCFxK9yPTByhX8mXoDl8qNHwN5LQT-IZDMrCFKIftTOVSo-Pt4
 QKRHbr9MqWkbY0j-85HfqJ1jPRLnqwhRODDIOk3bDI7oTXPMVqjJ_w>
X-ME-Received: <xmr:n_PNaqeZL1pEiftgQMQNMs5WD37dKmH8RwCHocAIobcacTuZHPnTVOZ9gJZFphwPHPfVtgq9cm5naMuAwDZ-t7E>
X-ME-Proxy-Cause: dmFkZTGSpcHu1GFAczrsWUGgQZnBUXbwL2k6nLkDNgy1KX/l9tvCi8Ki10NDfsIJKZUweO
 hjT6GvDY35LDofopphOfeyMuUlZPw3fzma7GrbKoWrX1gLB3rfIUkOoLPd81M5pDUEDCje
 ovJQoECIAdjo6dJh3XLd0QzSU82vDSB04hLa0zcfow3yBf7kSknhsVZWLjFm56Dr+K1PBz
 Ic27p1yGhkBrawb3MOGtkGn4+kXXaywOSF/GvoMDwBMbq0LfgqSeVHWotZUpx0YDLpADvu
 tDgmDdmqusXwxdylz6x67C8Cp7JApPvgSCJCFtTZUHq29NbEaSc9TFmN1FdTjaqkY97GEs
 d5kbg8Qt0+ZvLpMV+677c+2HqPnKDD58POdoh/PJRAc5nYA3sGRLee6KNtPPSJwoPd9KiX
 /R1TrBXNSGlFOBZrtz3AD28Q/JC/3mvANP/v9W1cuiti1eyKghxIPCyqJlXr2aE47+17QV
 QEKeNFIQjvOvqa6wDyG+LLZinQ4fX94UG8+ItER1TABrbHcO9lwvGmnqGoIi5CdWouBRCZ
 OFobE/g+Jrfm2RMG0EaQFNgbn0qH31l1GEwRoprETEEXBl6h5fYkxCpjndLFEaMSLR1Vy6
 ghGeDSe4trN9pP2IIMbQr67Yj/6gTec7kLthdW0k8S8mtIJaNITo2qjj3W3Q
X-ME-Proxy: <xmx:n_PNamd6EqEFWjrsw0Pi1y4cTlnL9-kFwHt5ZQeNMAOmjcEUnISFXg>
 <xmx:n_PNatyDDkN29wF3Vv4nZyTVbqDw8bE92oXkKSd9cDEtz4XTUuJhaA>
 <xmx:n_PNat86JX3QDEdxRtNT9hZv2iniadoRorlY7tXkf0OnhbBACr36jw>
 <xmx:n_PNalg_B6suK3TKFi22riV-0QGzw4NnGwD65UAuZID2PyqrQxEsLg>
 <xmx:n_PNan0qF0U-xNzqOCZtidG2X9NehsdUzJvJGYdPy4OV7U0mv_k3CM2W>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 05:02:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v2 2/3] eal: increase memzone name size to 64
Date: Tue, 13 Oct 2026 11:02:20 +0200
Message-ID: <nOwddlJXR9OIFrDxjU8jSA@monjalon.net>
In-Reply-To: <20260922155249.3115271-3-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20260922155249.3115271-1-stephen@networkplumber.org>
 <20260922155249.3115271-3-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

22/09/2026 17:52, Stephen Hemminger:
> Memzone names are limited to 31 characters, and ring, mempool and
> stack names lose the length of their prefixes on top of that.
> A mempool name is limited to 25 characters, which leaves little room
> for libraries such as rib and fib that derive names from the name
> given by the application.
> 
> Increase RTE_MEMZONE_NAMESIZE to 64. The derived ring, mempool,
> stack and RCU defer queue sizes follow.
> 
> Reorder struct rte_ring and struct rte_mempool so the larger name
> does not push datapath fields into another cache line.
> 
> For rte_ring, flags and the size fields come first, followed by the
> memzone pointer and the name. The cache alignment moves from the
> first field to the structure itself. struct rte_ring grows by one
> cache line.
> 
> For rte_mempool the fields used in the datapath are gathered at the
> start: pool_data/pool_id, local_cache, ops_index and cache_size.
> The remaining fields, along with pool_config, mz and name, follow.
> Previously local_cache and ops_index were in the second cache line.
> struct rte_mempool stays 192 bytes.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  doc/guides/rel_notes/release_26_11.rst | 21 +++++++++++++++++++
>  lib/eal/include/rte_memzone.h          |  2 +-
>  lib/mempool/rte_mempool.h              | 29 +++++++++++++-------------
>  lib/ring/rte_ring_core.h               |  9 ++++----
>  4 files changed, 41 insertions(+), 20 deletions(-)

Please rebase on top of mempool changes in main.



