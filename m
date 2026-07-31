Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFDC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 04:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C86640262;
	Fri, 31 Jul 2026 06:37:55 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id 64B3C40151
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:37:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785472672;
 bh=1qHqeeiKxG2b2FDclcbgZc/QxG3lbBc5Ch5J8M/jSgM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sv2PETBOef0tY5yjt4mRh8HVEqEbYvTkTLf/ke0kFLFOyY6ggyv9JEAP0Yh8UuHNO
 RppMFrxNzvqdTam03TlPUUVvWV4blZ51ZnWdR39bqSvsRWmV9Rub27DWUj15vVv7hd
 sML81g4KrVhy8gkHTEgUymcG20WNeB4WfrENE6F6pghBYOjd+LB6LxCYoWnsub8kSR
 gaH6G9ehLozZdxe/unEZHmVc/2uSYcrfxiSVEizwKovi9/1ZlW2D+xboxs8f7JmBNW
 l1tlr3oQL1jcahlbjnn9pZqoX20H25Ma+pDiYdivwGR3xvT1wB5KS41JblayvE+t7V
 1WidjOmChm4Aw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id C331012E64
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785472672;
 bh=1qHqeeiKxG2b2FDclcbgZc/QxG3lbBc5Ch5J8M/jSgM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sv2PETBOef0tY5yjt4mRh8HVEqEbYvTkTLf/ke0kFLFOyY6ggyv9JEAP0Yh8UuHNO
 RppMFrxNzvqdTam03TlPUUVvWV4blZ51ZnWdR39bqSvsRWmV9Rub27DWUj15vVv7hd
 sML81g4KrVhy8gkHTEgUymcG20WNeB4WfrENE6F6pghBYOjd+LB6LxCYoWnsub8kSR
 gaH6G9ehLozZdxe/unEZHmVc/2uSYcrfxiSVEizwKovi9/1ZlW2D+xboxs8f7JmBNW
 l1tlr3oQL1jcahlbjnn9pZqoX20H25Ma+pDiYdivwGR3xvT1wB5KS41JblayvE+t7V
 1WidjOmChm4Aw==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id A91FF12F0C; Fri, 31 Jul 2026 06:37:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1785472671;
 bh=1qHqeeiKxG2b2FDclcbgZc/QxG3lbBc5Ch5J8M/jSgM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Vd/9tcRXiQidsFk/w6vMWjJTE5tvTa9rq/nLKTiUSOLqxdYP1if2/4sdllsCXYAWi
 poLgW1TN5jC3U2AQqrpYmWu5/ehjtSrC59JwVgM2YhT6ItGGC71CqGYardLukJ2H6F
 692rCcn7Jko6ynI6VcW13VtQTlWcOLGUFK2ZNK1dRCDnj8fAlYasdqRgmFV2f/505Q
 gBOY7s8Z5KGlTmykiNKFt57hp/5eQ+WBmzKrTlYjrLFmapuycwYCYc7Bl5iv4dYYe/
 763FmuyHZS2JFOJHbfs8Ni553hkvJ9RlLD2B/l2tkxFL4ttBeZxn788NibBwxcn764
 TJglRx8fD594w==
Received: from [192.168.1.85] (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 056DB12EAA;
 Fri, 31 Jul 2026 06:37:50 +0200 (CEST)
Message-ID: <3e81a4bb-21d8-44a5-8714-ec8185fe61a6@lysator.liu.se>
Date: Fri, 31 Jul 2026 06:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 24/32] event/dsw: replace SMP barriers with release fences
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260729175715.165120-25-stephen@networkplumber.org>
Content-Language: en-US
From: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
In-Reply-To: <20260729175715.165120-25-stephen@networkplumber.org>
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

On 7/29/26 19:54, Stephen Hemminger wrote:
> All four barriers publish flow table or ring updates before a
> control message enqueue, which is release ordering. All are on the
> migration control path, not per event.
> 
> The fences may in fact be removable: the control messages travel
> through rte_ring, whose producer tail update is itself a release
> store covering the preceding writes. Left in place here to keep
> this a like for like conversion.
> 

I also suspect you can remove some or all of these. Not sure it's worth 
the trouble though.

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   drivers/event/dsw/dsw_event.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/event/dsw/dsw_event.c b/drivers/event/dsw/dsw_event.c
> index 399d9f050e..82d3636b29 100644
> --- a/drivers/event/dsw/dsw_event.c
> +++ b/drivers/event/dsw/dsw_event.c
> @@ -339,7 +339,7 @@ dsw_port_handle_pause_flows(struct dsw_evdev *dsw, struct dsw_port *port,
>   	/* Make sure any stores to the original port's in_ring is seen
>   	 * before the ctl message.
>   	 */
> -	rte_smp_wmb();
> +	rte_atomic_thread_fence(rte_memory_order_release);
>   
>   	dsw_port_ctl_enqueue(&dsw->ports[originating_port_id], &cfm);
>   }
> @@ -821,7 +821,7 @@ dsw_port_move_parallel_flows(struct dsw_evdev *dsw,
>   		}
>   	}
>   
> -	rte_smp_wmb();
> +	rte_atomic_thread_fence(rte_memory_order_release);
>   
>   	dsw_port_end_emigration(dsw, source_port, RTE_SCHED_TYPE_PARALLEL);
>   }
> @@ -1190,7 +1190,7 @@ dsw_port_move_emigrating_flows(struct dsw_evdev *dsw,
>   		    dest_port_id;
>   	}
>   
> -	rte_smp_wmb();
> +	rte_atomic_thread_fence(rte_memory_order_release);
>   
>   	dsw_port_drain_in_ring(source_port);
>   	dsw_port_forward_emigrated_flows(dsw, source_port);
> @@ -1213,7 +1213,7 @@ dsw_port_move_emigrating_flows(struct dsw_evdev *dsw,
>   	/* Flow table update and migration destination port's enqueues
>   	 * must be seen before the control message.
>   	 */
> -	rte_smp_wmb();
> +	rte_atomic_thread_fence(rte_memory_order_release);
>   
>   	dsw_port_ctl_broadcast(dsw, source_port, DSW_CTL_UNPAUSE_REQ,
>   			       source_port->emigration_target_qfs,

Reviewed-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

