Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33EC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:10:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EB614025D;
	Mon, 11 Aug 2025 12:10:04 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 64D51400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:10:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru AE8896B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1754907002;
 bh=EiGS3Mi8lDCtHNLgaHXAYBLhMS0/KFc0dv0je734/Z8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eXFH+WPt4+PwyxnWvPtrCFD9Tcp27+sf0cT0GzjYdd+dl5ik18mRsqBQcJCKUvQCl
 H/TJAg9rnrTdAhGKJioiDxnwtFsYtagE/BC7nNQ+App5uXl40UNW8V06IYFzgRsLEk
 /gdToZEIMJwrKURf1RWlLbrM+AgO+/23uzyDQ2f0=
Received: from [192.168.1.41] (unknown [188.170.86.252])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id AE8896B;
 Mon, 11 Aug 2025 13:10:02 +0300 (MSK)
Message-ID: <7c970819-8572-4f01-8f12-38cd55ae0185@oktetlabs.ru>
Date: Mon, 11 Aug 2025 13:10:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/14] ethdev: allow start/stop from secondary process
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
 <20250808165843.39075-2-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250808165843.39075-2-stephen@networkplumber.org>
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

On 8/8/25 19:55, Stephen Hemminger wrote:
> Before this patch if secondary process called start/stop
> it would only impact the secondary process, the ethdev on the
> primary process was not started.
> 
> With this patch, when start/stop is called from secondary,
> it calls the primary and does the operation there. The design
> is generic, and we can later add queue and other operations
> as needed.
> 
> Bugzilla ID: 73
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

