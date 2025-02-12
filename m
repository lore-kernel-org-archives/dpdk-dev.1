Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21F6C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 07:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55B6C40269;
	Wed, 12 Feb 2025 08:53:14 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id BD7D640263
 for <dev@dpdk.org>; Wed, 12 Feb 2025 08:53:13 +0100 (CET)
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 2FC9B1C39B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 08:53:13 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 147981C39A; Wed, 12 Feb 2025 08:53:13 +0100 (CET)
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 754701C2C7;
 Wed, 12 Feb 2025 08:53:11 +0100 (CET)
Message-ID: <357fc914-dc3c-489f-b7c3-8388317c39be@lysator.liu.se>
Date: Wed, 12 Feb 2025 08:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/32] event/dsw: replace memcpy with assignment
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-9-stephen@networkplumber.org>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20250208203142.242284-9-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

On 2025-02-08 21:22, Stephen Hemminger wrote:
> Prefer structure assignment over memcpy.
> Found by cocci/struct_assign.cocci
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/event/dsw/dsw_event.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/event/dsw/dsw_event.c b/drivers/event/dsw/dsw_event.c
> index e68fb19890..399d9f050e 100644
> --- a/drivers/event/dsw/dsw_event.c
> +++ b/drivers/event/dsw/dsw_event.c
> @@ -1078,8 +1078,7 @@ dsw_port_stash_any_migrating_events(struct dsw_port *port,
>   			offset++;
>   		} else if (offset > 0) {
>   			struct rte_event *out_event = &events[i - offset];
> -			rte_memcpy(out_event, in_event,
> -				   sizeof(struct rte_event));
> +			*out_event = *in_event;
>   		}
>   	}
>   

Acked-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

