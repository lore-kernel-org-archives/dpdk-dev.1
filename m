Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F3CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 19:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BC3D4029E;
	Sat, 30 Aug 2025 21:57:24 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 50CEF40276
 for <dev@dpdk.org>; Sat, 30 Aug 2025 21:57:23 +0200 (CEST)
Received: from debian (unknown [78.109.76.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 753FAE027F;
 Sat, 30 Aug 2025 23:57:22 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 753FAE027F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756583843;
 bh=zD2HG1f1ZRZSeQHe69M2pQcGWM2QZ7LsFD2SL/rOf04=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=bGvcKGN8TN5TjrM96YrL5mlUlSUQ4kmlZSYOUGgMpRx11ZVNjg+IQgMyyfXrJ3pPV
 x1UuTpJr+Q+kjA6lMimVLbIYCU0YVLbqx6FT0yIuzpTtLzmwotz+7O2JzRMXj7dWGv
 4rA5WA/wZorpQR1VSipuk1W1tPiQYwUO7Nt4GZA1sOzwrS8un1NRlQsFxExuxsy4gc
 yYpBfyKgU6HlIAWKr36p0IzQDdfC6osheo0ruPCkI5OryKCHiOJsUJWP8amTpoPyuP
 OJw6RTNHWYPA4I6p3maJJpIigUFMKXfK1wBqXz86eT7Bo9F0x1HeI9CPG7jVqZNfeo
 TxVJ2h60jPRsw==
Date: Sat, 30 Aug 2025 23:57:20 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 1/6] ethdev: extend and refactor DCB configuration
In-Reply-To: <20250830171706.428977-2-vladimir.medvedkin@intel.com>
Message-ID: <3727304d-4ee7-43e9-a5c5-caeb4ccc9b10@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-2-vladimir.medvedkin@intel.com>
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

> +	/** Traffic class each UP mapped to.
> +	 *  Rx packets VLAN UP for Rx configuration
> +	 *  Rx PFC Pause frames UP for Tx configuration

Is this confined to VLAN? Can the UP come from other headers of the packet?
I apologise in case my question is wrong.

Thank you.
