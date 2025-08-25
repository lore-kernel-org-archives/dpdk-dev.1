Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A8CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 06:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A961B4025E;
	Mon, 25 Aug 2025 08:48:56 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 71C644025A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:48:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 7806340
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1756104534;
 bh=MR49AVyjU/IXVkQow/ivAVV+J4HAH1jxJ0w0XsOF/X4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lBn7Fgr/Lh9QnshlLVXycyhFH+e/dH2QhW6DTPS6bMQ0NRI2Aqddk+DM8kOPBmSow
 tSLl6ZEoSTBfCqbEgSWU01UEnTVz/lZqlD0etKzR9XNYM8HJBWRRmPazjs9Pk5wVxM
 OHL9oh9IXtyt286WaX1KQz6ZCTGg2rAPAgrfqZSM=
Received: from [192.168.1.42] (unknown [188.170.78.15])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 7806340;
 Mon, 25 Aug 2025 09:48:54 +0300 (MSK)
Message-ID: <d9fc1895-1563-4fe6-8605-f263620e5fce@oktetlabs.ru>
Date: Mon, 25 Aug 2025 09:48:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/43] ethdev: replace use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
 <20250825034126.12046-11-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250825034126.12046-11-stephen@networkplumber.org>
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

On 8/25/25 06:38, Stephen Hemminger wrote:
> Use rte_bsd_queue.h instead.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

