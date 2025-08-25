Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D367CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 06:55:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 487E04025E;
	Mon, 25 Aug 2025 08:55:58 +0200 (CEST)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 447284025A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 08:55:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 77EC040
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1756104956;
 bh=7czdVXjkoDNtMs4aYUkNVl+JtFX/yo8CGabNCxl4Ik4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rmn7r/Lm8jW0hF/xY/z1kBa1hlcuuMu0LXdsQ+F4dirwFw9S5lRHUEnz+GWh5k24r
 2eWifCHE5yF69UomsRr9DbYhdJWMidVutHLpy7whZUt+5N6WLR9Sew+z4kh14NpOD/
 rgSQ6VDnLK0gB1PD8I6xHlOVr8giecjCK23D9ALA=
Received: from [192.168.1.42] (unknown [188.170.78.15])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 77EC040;
 Mon, 25 Aug 2025 09:55:55 +0300 (MSK)
Message-ID: <f38199c6-34bf-4288-996e-d43619863c1c@oktetlabs.ru>
Date: Mon, 25 Aug 2025 09:55:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/43] test: remove unnecessary inclusion of sys/queue.h
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>, Sameh Gobriel
 <sameh.gobriel@intel.com>, Chas Williams <3chas3@gmail.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
 <20250825034126.12046-4-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
In-Reply-To: <20250825034126.12046-4-stephen@networkplumber.org>
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
> Those macros are not directly in most of the test code.
> Replace with rte_bsd_queue.h
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

Nice cleanup since include is not really required in the most of these 
cases. Thanks.
