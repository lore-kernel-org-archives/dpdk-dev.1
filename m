Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC1CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 20:49:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7554B4060C;
	Sat, 30 Aug 2025 22:49:19 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1770A40276
 for <dev@dpdk.org>; Sat, 30 Aug 2025 22:49:18 +0200 (CEST)
Received: from debian (unknown [78.109.76.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 43E7EE0689;
 Sun, 31 Aug 2025 00:49:16 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 43E7EE0689
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756586956;
 bh=Ku3UL5mTV14HMEElzNghWyH6nJkZgfTjIKdJ9Nur188=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=kscoDdOO4el81PGV/nxqihPtZJ8s+z0cC7XxzYIbBZyt/7TTBG/tHeq9OYpAjLZmp
 xFojcaJ0Nq5O/uM2FjYhA03Lw0WLRhIMGt8kaQqBV/Zh5Q0G5HLBvx5uNKMck9ES6F
 lwDHXHCBurE6d93DXsGHauY7pMGEC6hy+YgR/iD8iLV+FrIlROP6K01oI+KiRLPyjZ
 bZb/6Sf1l0IILDZL9XcYdBd58xSkj2pAEDEZLWQye4/TU4bN25pphrY6sXdlrriPXl
 TXZJ3evRWpZpAwtWHDvWD52s8Q+jMS2x6JPjXCLf4Yy7eC2JnGLWQ5iOyd+oDLLiXG
 m2SFWTxX2o8cQ==
Date: Sun, 31 Aug 2025 00:49:15 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 5/6] ethdev: remove dcb_capability_en from rte_eth_conf
In-Reply-To: <20250830171706.428977-6-vladimir.medvedkin@intel.com>
Message-ID: <6fb0e54b-b1dc-f965-d773-51727ee796ad@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-6-vladimir.medvedkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:

> -#define RTE_ETH_DCB_PFC_SUPPORT     RTE_BIT32(1) /**< Priority Flow Control support. */

Sorry, I now see [0/6] explains other drivers have not been taken care of yet.
