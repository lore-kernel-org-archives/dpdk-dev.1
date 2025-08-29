Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214BCA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 10:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ECD840263;
	Fri, 29 Aug 2025 12:25:46 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id EB94B4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 12:25:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru C2BE544
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1756463142;
 bh=cjX29GrEcU0ZfqWorLnpEcdLf+LRqsQ1RWlgYGqUxx8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HZuezmhNrSuIcxTQjVPSyutUQ26IvlYjYV2cmINKGhhH0xHHVZ5DJjIl+4/roBt14
 zTFxCzcDwURE5nbX32kkvWZmveYIq6i+tLA/J0rUs2QxjzvQwMjqqXxxVeryx5D47/
 /r8bidt1T1jEV2nmFhBsJOmKtI6Lym7Tjdw5Vnm4=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id C2BE544;
 Fri, 29 Aug 2025 13:25:42 +0300 (MSK)
Message-ID: <c3424ff3-7766-41c3-9a0e-1ed3a153691c@oktetlabs.ru>
Date: Fri, 29 Aug 2025 13:25:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] ethdev: avoid shadowed variable warnings
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>
References: <20250827231528.236172-1-stephen@networkplumber.org>
 <20250827231528.236172-7-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250827231528.236172-7-stephen@networkplumber.org>
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

On 8/28/25 2:14 AM, Stephen Hemminger wrote:
> With shadow warnings enabled there were a couple of cases
> to fix. One was simple reuse of 'ret', other was overlap
> between type and variable name.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

