Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8995606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=wPLLv8Ug
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 845E240270;
	Tue, 20 Oct 2026 10:01:55 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 8CB2C40144;
 Tue, 20 Oct 2026 10:01:53 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-59.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-59.yp-c.yandex.net)
 by forward501d.mail.yandex.net (postfix) with ESMTPS id AD63B813DB;
 Tue, 20 Oct 2026 11:01:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59 with ESMTPSA id
 l1V2WLfdvCg0-f7oTNCJ1; Tue, 20 Oct 2026 11:01:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792483310; bh=L+umtYbF+13Z5SYQtRH/nfFQmSwsJbxg8fYsm7l1yZA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wPLLv8UgQxQ7bzjMaFAsetocrtfF17yjLk5X4OS8GvvY2bif97jero6d9a0B+bNaY
 GufUZKT1kJO0porxZwKMLGjthTehBZ3hIQoDOS+Vwanf6ToQ82KehuF6YRg4KNN4UJ
 JvjxbMHdtMcSGkK3wKbQ3fDjtVxLDozsF4UUGrZ4=
Authentication-Results: mail-nwsmtp-smtp-production-main-59;
 dkim=pass header.i=@yandex.ru
Message-ID: <6ccde5ff-f81c-4c2c-8bc6-e2ef64035129@yandex.ru>
Date: Tue, 20 Oct 2026 09:01:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ip_frag: fix IPv6 fragmentation of short packets
To: Alexey Simakov <bigalex934@gmail.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20261019101333.71145-1-bigalex934@gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20261019101333.71145-1-bigalex934@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1




> rte_ipv6_fragment_packet() does not check that the first mbuf segment
> is large enough to hold the IPv6 header, unlike the IPv4 version,
> which validates data_len against the header length.
>
> With data_len < 40, in_seg_data_pos starts past the end of the
> segment, the expression (in_seg->data_len - in_seg_data_pos)
> underflows and the loop never advances to the next segment, so it
> keeps producing fragments and writing past the end of pkts_out.
>
> Reject such packets with -EINVAL, as rte_ipv4_fragment_packet() does.
>
> Fixes: 0aa31d7a5929 ("ip_frag: add IPv6 fragmentation support")
> Cc: stable@dpdk.org
>
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>   lib/ip_frag/rte_ipv6_fragmentation.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
> index c81f2402e3..fac72f84d2 100644
> --- a/lib/ip_frag/rte_ipv6_fragmentation.c
> +++ b/lib/ip_frag/rte_ipv6_fragmentation.c
> @@ -89,6 +89,14 @@ rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
>   	    unlikely(mtu_size < RTE_IPV6_MIN_MTU))
>   		return -EINVAL;
>   
> +	/*
> +	 * Check that the first segment is big enough to hold the IPv6
> +	 * header; otherwise in_seg_data_pos starts past its end, the
> +	 * difference below underflows and the loop never terminates.
> +	 */
> +	if (unlikely(pkt_in->data_len < sizeof(struct rte_ipv6_hdr)))
> +		return -EINVAL;
> +
>   	/*
>   	 * Ensure the IP payload length of all fragments (except the
>   	 * last fragment) are a multiple of 8 bytes per RFC2460.

Acked-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>

