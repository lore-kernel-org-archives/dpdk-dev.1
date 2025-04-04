Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED74EC36010
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 07:37:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7AFC40E35;
	Fri,  4 Apr 2025 09:37:38 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 863F840DD7
 for <dev@dpdk.org>; Fri,  4 Apr 2025 09:37:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru A806741
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1743752256;
 bh=A/wf9PkWXryldg+Tq7WOguc+u6sZKvHxmHH9r4ivzc8=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=yQGv5zGQuHy+2J+pOv5J6LSKukMyvWU5+XNGT+dLXrPBD5qQ/Eei686r4esn5xtOg
 tJsLeaG4oZL7UAkuX1/aF03W9FCdACvZ7648ttLCja2ONwBARSGVZstzkw/O90YNk6
 IqRP4hOqun0gdsqj4LjWx2To+He8Y5TEZaAya/XQ=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id A806741;
 Fri,  4 Apr 2025 10:37:36 +0300 (MSK)
Message-ID: <0854c6f8-7701-4c60-82e9-0c6ad99aef60@oktetlabs.ru>
Date: Fri, 4 Apr 2025 10:37:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/10] net/sfc: replace use of rte_mbuf_sanity_check
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
 <20250402232441.440346-4-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250402232441.440346-4-stephen@networkplumber.org>
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

On 4/3/25 02:23, Stephen Hemminger wrote:
> Renamed to rte_mbuf_verify.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Thanks Stephen,
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

