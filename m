Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1546DCA5FCE
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 18:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3974640144;
	Thu,  1 Oct 2026 20:50:27 +0200 (CEST)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by mails.dpdk.org (Postfix) with ESMTP id C5DC9400D5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 20:50:25 +0200 (CEST)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so36393365e9.1
 for <dev@dpdk.org>; Thu, 01 Oct 2026 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790880625; x=1791485425; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A4K8st2FH8kLDIQgp/ClicLqJAa8dOo3qoi0RePgtKk=;
 b=LnvN7xSlqy4nVJqW9hL9Buh8WKZ52YKF3bVI3S/G/3vSPOCHRMLuhpeDnPoLe+noPh
 CXP2QzMOHnpP7fSWLaqj7hjDgrIiPLt3VaejimjfbQ+arCX0YUsGXWrv3NGvzbpy1fpF
 1AC5K3xdQE95H68gaiwTu2q5HmLsqi3c8J8K/QGIZysTqdtOrJL8xkPkzKGZuPF3uQB5
 oDZSWSgFiOUKJJn+chVfEvjM/fPyIXqOeWUauBk5+P9Qh9VwALWkp9obJmdT9S8Dtz0y
 pjHYyUBBaLhOGHXQXxhCulRgBrUoA1JOfJ+LEhfmC2xnl0e5lfAU/yJuuWyHlfVzbCvG
 FRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790880625; x=1791485425;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A4K8st2FH8kLDIQgp/ClicLqJAa8dOo3qoi0RePgtKk=;
 b=ThL39+0LTCrRsJLOsj1lkmHo/jSrCTNekG4xzxuw2WJVfniE4/7yLS+A8ivVYcUnaB
 YtV+iWztUMUCFhl1PhIgBqkd4iUm6KDFN18XVSFJXdW5yh9rS69kw4EiPFMlnKNLA528
 b7+c1vk+XQwrhXIcfRRjt4ZYBPjqgvS6gZoSqPKztynUP00vmJOQB42O8lmAVirTQYN5
 p39hbAlMmVKJLZHVPSZZk4zFWjR6NBtePTGRxP2ZXoz/V4koZtHY5GHGRgU2TqYfnyDn
 kWgExrxD61+/Ma8DK7eHZVctLa4q0sOFax7kVcTTmcylOME0rHzxF6MK9Xu4V9f3lWl3
 8g7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBybuW70V+gDsTvUQ7YucCi3TZW0GPFRocKMN51O+Tq/W1NoPb3t1v+FWrTVPe2cg8Q90mM=@dpdk.org
X-Gm-Message-State: AFuF++nJbPH1i71CkQtou0tiAEfMbgtdK+YUIVTcaj430SqqTh5YZe42
 RLt8Bi1rtDd1oRSdh5EnVv/23LC5EdDv/U+kF1EZCq/ru+WsGzdk50q4
X-Gm-Gg: AYBFou0AoLLKre61nVrtyfsMCrsb604nQ67Abw9xIpYeEeYDKql07NkQVSmNkuPpEBi
 ICGzNNr0InMDMq2+7p3Zf1ESwAtDNkGqU5Ze2Nl/ExTGn2Uhu4vQjGPRVnCNtdtcxRhtLiNW8Ms
 t4x4P/6X5hv/DYQOfHSXAoVF0UYMygHcsjzizk/z7JF78W2sSgvcfFG99fzz/kvlmLVF3C4koQz
 +4I3Ob6zV6/2SSDhmkcHzmr3aA8ewhX68K5ezeLej84fZErGAVdYwA5HT5HB5CvK4hsvSdgSY9D
 I1M+rkykVs3bzxjdAtQRz49IVx48hqgfvsJeNOeNTtRJiOvlruigZuuNrWeies1H6cXKdDpejSf
 BxU6pvIp0B8WzNN1CF+ElzpDfdryBXCVdJuxyqWu00DzzrXXQT14kKpBJvIUpb+hMlMHTvHLNBu
 +W9UoywJDngfafPVqVPsN9nc46ujhAXA73DKEpp/21rfMTTObXVzglYaU1uiZOmtIkHDobD8KII
 ObFBw==
X-Received: by 2002:a05:600c:4e43:b0:4a0:53e:b7d6 with SMTP id
 5b1f17b1804b1-4a02759579amr9765205e9.16.1790880625103; 
 Thu, 01 Oct 2026 11:50:25 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.33.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104417sm187676f8f.27.2026.10.01.11.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 11:50:24 -0700 (PDT)
Message-ID: <8b97c8a0-7135-4613-a012-6bde4529e089@gmail.com>
Date: Thu, 1 Oct 2026 19:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] app/rpcapd: remote pcap daemon
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Reshma Pattan <reshma.pattan@intel.com>, dev@dpdk.org
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20261001025853.319860-1-stephen@networkplumber.org>
 <20261001025853.319860-3-stephen@networkplumber.org>
Content-Language: en-US, en-GB
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261001025853.319860-3-stephen@networkplumber.org>
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

Two non-critical nits inline.

On 01/10/2026 03:35, Stephen Hemminger wrote:
> +static void
> +parse_bind_addr(void)
> +{
> +	struct addrinfo hints = {
> +		.ai_family   = bind_family,
> +		.ai_socktype = SOCK_STREAM,
> +		.ai_flags    = AI_NUMERICHOST | AI_PASSIVE,
> +	};
> +	struct addrinfo *res;
> +	int rc;
> +
> +	/* Loopback by default; the wildcard address is not a safe default. */
> +	if (bind_addr == NULL)
> +		bind_addr = (bind_family == AF_INET6) ? "::1" : "127.0.0.1";
When neither `bind_addr` nor `bind_family` are specified, can we bind to 
all local addresses (127.0.0.1, ::1) that exist in the system? Or at 
least to the first of them that exists, to improve the user experience 
on IPv6-only systems a little?
> +
> +	rc = getaddrinfo(bind_addr, NULL, &hints, &res);
> +	if (rc != 0)
> +		rte_exit(EXIT_FAILURE, "Invalid bind address '%s': %s\n",
> +			 bind_addr, gai_strerror(rc));
> +	memcpy(&listen_addr, res->ai_addr, res->ai_addrlen);
> +	listen_addrlen = res->ai_addrlen;
> +	freeaddrinfo(res);
> +}
// ...
> +/* Largest snaplen a client can be given. */
> +#define DEFAULT_SNAPLEN		RTE_MBUF_DEFAULT_DATAROOM

The naming is not optimal, it's upper limit not default.

