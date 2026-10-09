Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75C0CA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 13:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A34FD4025F;
	Fri,  9 Oct 2026 15:26:15 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 571234025A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 15:26:13 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id C2A29EC09A7
 for <dev@dpdk.org>; Fri,  9 Oct 2026 09:26:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 09 Oct 2026 09:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791552372;
 x=1791638772; bh=jJxacuwA5JI/FFFjIxEGgyvXlek0Di+INAZf8dCg9ME=; b=
 jUG2VpUG04kFAmZA5tcCmgLKwKuflLjAADxWKDbvURsBe8i36zJkAu8Y31zpdeMS
 AOTL82PvbC00NXvedu/uG1+pq+gODw/0WQNbUKPa/pRu2zh3fJtAyrBZ7rEFCMfV
 EnvF8cVd8ZTwg2UsZJio0sDUTmSL8+3XtSfNb1BDV274cFRQ08tOU2K5EZ9YVVyO
 E3BzNOznY7Nm0ZvJ9Up+sH7QEpiiBSnPm8FSAPmKDLa2d0/oKUysAdeGTW9c5wnO
 Nc3b8jxufTydtDMIB8o91DEEKlqAPmXvyLvnZkQatSZhbJbYwjojExtyQOWYz7NM
 oDoEIEAiNxP1sro4dabrug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791552372; x=
 1791638772; bh=jJxacuwA5JI/FFFjIxEGgyvXlek0Di+INAZf8dCg9ME=; b=V
 xggiOJfZ2jwBxfbbX/PGUcNd/nh0JMUu8TNsmb4dttUCXZ2n9GilJzcsTdFMOTGq
 4uGpjFHdFPx7Bl8Pc+q8G1clsv1OAGlqFvDGUOeEnqow/HZqoMtH1WasjRkB4zX6
 Y1W+mn6NOT9aPRdiv9jpGPuQLb1SShD47dSjy4rqkPdem/mukqrAKLuE2KQ+cd1G
 9bA4cl4YHn1juoXzi8T78vq2ZWjJK5oy2evmSLxwMQ4OPonhh5SqwuLOSJztsMrg
 o4y/q0Tr90cbt1Y9XYfpuluFZ0HqmnNT3SeOee40oXFZYivSF+YbUinXIDBwScIL
 bBUiE1WA4P/VL6l/o9B1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791552372; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:MEIdeHDtaP9DmopMqG+Zu0hSlMwd8nNZIqeCsE1wq1Q2AAp
 +UpkkVPwWMYqsrGw3IA3ZNfMmdXitCl0z7sfBs3AmsPwA029sBErYLxm8Igexw4u
 7qMdvWILmQvN1d/cvc9yzsCy2Uk94YmzQqjQf8HFJHpFC20TGA9aE+1ro9JXRAep
 SJi0JDS5x7hKDgbJsgtw2TwrwtY68DzBlRvYdH5vYBAcG+AtXSpcMDRU4328PZlH
 zx7Bws8inzp+c5FnS53iiLfggBWAeBJnkJ6raMpKc1by0LENUMcOqNcSSP+g7wNI
 1E0BR3FEHhDOA/Hd/wCNYC7RwA8x9BsL+yTIZwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:rbpGNpsIC68hP0CotB/wYpcrMFwPkgZcziuuMg3Ino0=:xYKbBppxl2GbRQcg71QNsScZ1fbevT8qJKuZy8NJEJ0=;
X-ME-Sender: <xms:c-vIagB5NWlMw44Sc5anJK8WXLAw0AVrf3dsyakaR37YJRYV6eo6mw>
 <xme:c-vIarfedmZMQXA6eM2TV2hJQUxjaUuVkGFCGDPujc8YLNw9O7Dc9coTAhkB7TAZx
 5_UZZEAUSaiMGq_MBS4IUNOUPeMV-8Ey6PPYQQ22hJqs_XldNgjT-w>
X-ME-Received: <xmr:c-vIavKFosVMLQCcM5lSyVdZ9OOm0gdXhDV_S6BCGwUxT2B3x-bUEV8vt5o53XLIbc4hsxZ8k9GO-H5i8VKmE38>
X-ME-Proxy-Cause: dmFkZTGxqcrjhSALzyNtBzu23JS+nXecuUieku8YG7h9M8C8JL/Gihha8yQH5I5IFaJqx7
 Sav1uGPy5MzsPh/vaOEd/lAFZ7GjQ/sh5RAyVxLkQc2R1NhFK1TpFpQShHyMhAAWNPFSYO
 XCV/UAYxTHBcnFzkG6nF2gr3ng6N/AC6asd29iT2lrYqbp2WI3WkwNb6/ghE/TLeafWDgh
 agBzyRVrQBLumtwI2OPWjCmDY68ejYYtGcGV0UlBUxgSFxGkZif1wEHO+u2VyCJbjhCx0P
 efjkgpO7VyJTWq6tMFzwvyjc/0WzkHs5xUQ+EZoXwP6aKX6dP6Bxx0iSZKySyAyCllwoWO
 /ht49aRhljuTWQz5RAqVZo92sCEuZBwxTwnQx3SiaipEBOWt2vqY44RZBYQDhMDf/VJKk9
 IKoG7wz7xWkQSWib4jnaUGE60vl+VbBWBCYsQm9WcrwyzdqJaTgsa2wKezYDwPWSGsrIZK
 NV0f5dnODEqA3xtkNLDH9s6NOFIx4hqkxsfrvbHXRTYb3NVZlX5iH4qdbOKpXD5TJ2LuK9
 LnAvTPSeI0vYClRN0G9fY27gCOhdv1GcDrXoKGDogEB3IdQJQJEhY/2c88QJy67I4oIV4a
 Nm3xgoO3OtAiFIg1aifZghvGRfuoF2MFX4s4MmnSpnLzBPGLGJLogAehnbvQ
X-ME-Proxy: <xmx:c-vIam21E3mzFu1KDWqTD93DqH8uG8uw7L0tc0w21Ri8p9FxDYrWLg>
 <xmx:c-vIahiIo1FWF-gEheIkdpEUpvx_8X07MlDKt-2r3dK7OJNsu6tQVw>
 <xmx:c-vIavXx89hQH2euBQC5_d6RQvYwikyWr5jgOeWDIZd7axB_W5OGCA>
 <xmx:c-vIaoXykXV9ukHPjilrAj0R4PaOmnxEaXxX_QWeDDS_o6KnLxp5gA>
 <xmx:dOvIarl7vvcqVVj4YgugSF5LHzv6KpFBP_7QD_-f7eryql4tyfsIBCqf>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 09:26:10 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Ori Kam <orika@nvidia.com>
Subject: Re: [PATCH v6 02/25] ethdev: add flow graph API
Date: Fri, 09 Oct 2026 15:26:08 +0200
Message-ID: <-r-TpSN7RLOHeQnDOR9Fag@monjalon.net>
In-Reply-To: <e268ba869b9bdb319d3fd104c3e811f5235cda8f.1791543154.git.anatoly.burakov@intel.com>
References: <e268ba869b9bdb319d3fd104c3e811f5235cda8f.1791543154.git.anatoly.burakov@intel.com>
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

09/10/2026 12:58, Anatoly Burakov:
> This commit adds a flow graph parsing API. This is a helper API intended to
> aid ethdev drivers in implementing rte_flow parsers, as common usages map
> to graph traversal problem very well.
> 
> Features provided by the API:
> - Flow graph, edge, and node definitions
> - Graph traversal logic
> - Declarative validation against common flow item types
> - Per-node validation and state processing callbacks
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  doc/guides/prog_guide/ethdev/flow_graph.rst | 750 ++++++++++++++++++++
>  doc/guides/prog_guide/ethdev/index.rst      |   1 +
>  doc/guides/rel_notes/release_26_11.rst      |   5 +
>  lib/ethdev/flow_graph.c                     | 273 +++++++
>  lib/ethdev/flow_graph.h                     | 149 ++++

This is a driver helper and you use it in some Intel drivers,
so I believe it is useful for you.
Let's merge it and see how it is useful for other drivers.
If something need to be rearranged, I assume it will be possible.

Thank you



