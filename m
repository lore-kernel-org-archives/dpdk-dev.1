Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA2CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 09:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4082B4025F;
	Mon,  1 Jun 2026 11:22:29 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id B51AF4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 11:22:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 2953566
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1780305747;
 bh=+FILU1w/jHDtNWyazcCPSccqT9ibERTaAAd9rE2JwYo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=qJzy7+kETnV5jDIKlErpHAY1vv73PxRyW3iF2zcN15rC2pB6c4a3HYRGy6CGaepkU
 ncbxQehI71oYC8gs+rd3YybYYIUp5X0JVcIXM02UWfVvTlg3BNk+fHoxwF+9E5prpU
 st8DqbkyKL6XQnZXkCpjapI4Qn6Yj3CBq4+GJMZU=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 2953566;
 Mon,  1 Jun 2026 12:22:27 +0300 (MSK)
Message-ID: <5e69b696-2004-4220-9ce4-9e729dd1ffc5@oktetlabs.ru>
Date: Mon, 1 Jun 2026 12:22:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/27] net/sfc: replace rte_atomic with stdatomic
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
 <20260526232542.620966-12-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20260526232542.620966-12-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/27/26 2:24 AM, Stephen Hemminger wrote:
> The rte_atomicNN functions are deprecated and need to be replaced.
> Use stdatomic for the restart required flag.
> Use existing ethdev helper to set link status.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

