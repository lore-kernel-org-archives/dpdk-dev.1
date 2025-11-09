Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752F1CCFA13
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 14:43:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AB3A40268;
	Sun,  9 Nov 2025 15:43:15 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 0A04F400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 15:43:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 6860C87
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1762699393;
 bh=MAzgvf3K1MUu+ujZbzfqR7wmR9y50ow34fVh2tfOxLA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DejSsBNT4mCclM3viBR6it2/Cw7Jrj+Zz5mtsWEUp65wZSFH2/Wu/MJPZBV+rSj4S
 aJqvA/eflqL6J2X91lewN02ZdJUswnpmiGl/fiWzLLth5UFuuV5qgTxGUJ5mJKO125
 Q1+Dd8Yr8nNjL7V/trOWR7DsWXaeFtv9e7wd4F5c=
Received: from [192.168.1.42] (unknown [188.170.87.245])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 6860C87;
 Sun,  9 Nov 2025 17:43:13 +0300 (MSK)
Message-ID: <7b714280-10eb-41b3-91b3-9d921dc251d4@oktetlabs.ru>
Date: Sun, 9 Nov 2025 17:43:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/44] ethdev: replace use of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
 <20251103164915.101713-11-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20251103164915.101713-11-stephen@networkplumber.org>
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

On 11/3/25 19:47, Stephen Hemminger wrote:
> Use rte_bsd_queue.h instead.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

