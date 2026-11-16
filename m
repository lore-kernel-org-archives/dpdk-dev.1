Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B7606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 14:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=brsp5FIq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D2F40294;
	Mon, 16 Nov 2026 15:17:49 +0100 (CET)
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 1BD7840150;
 Mon, 16 Nov 2026 15:17:49 +0100 (CET)
Received: from [192.168.0.40] (unknown [37.228.226.247])
 by smtp01-ext2.udag.de (Postfix) with ESMTPA id CEDCCE0621;
 Mon, 16 Nov 2026 15:17:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1794838668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2iBQgMDFjZlgkAyteR60DMy8oQ7o71PQO6Xguv3TDKI=;
 b=brsp5FIq8orHdf7VXT8AvJlH/SvqXuS9f2uzIlcoyfI1hJEisk9wgTuEFDzet11lz+aTwj
 mi0GXVBqEKsGZD8blWRqmjQou2aWj4qmpBIGeUp4RMUEicF0/81oFrJBIZUULey6EitXSD
 qt2eFGPLwMQBPXHej0uiIJgqz4GYZrjxQCC/2XzIRcdEJcwWHwU0UxUAob4xxlIowNso5g
 7VGnKUx3N02Dz2lkbVkncnvRscFVxuNkKZb/fqAIAaeIgAve3CUwJ6w493dhKicY02BzKW
 ZYJUaMz7JOLW5/IqvdgyN+6r1uR5FjTyZpaPsz3GLAXaEXye0sFC517NZftveg==
Authentication-Results: smtp01-ext2.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
Message-ID: <13f69bf5-43a7-4433-abf2-65b87e60f8a2@dressler.pro>
Date: Mon, 16 Nov 2026 14:17:46 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/af_packet: fix accidental fanout group ID reuse
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, stable@dpdk.org
References: <20261110190626.519592-1-frank@dressler.pro>
 <20261111104536.248312-1-frank@dressler.pro>
Content-Language: en-US
In-Reply-To: <20261111104536.248312-1-frank@dressler.pro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_PRO_TLD,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, this patch has been marked “Changes Requested” in Patchwork but I 
cannot find a request. Is there anything I need to do?

- List: 
https://inbox.dpdk.org/dev/20261111104536.248312-1-frank@dressler.pro/
- Patchwork: 
https://patches.dpdk.org/project/dpdk/patch/20261111104536.248312-1-frank@dressler.pro/

On 11/11/26 10:45, Frank Dressler wrote:
> This fix ensures that the queues of an AF_PACKET vdev do not
> accidentally join an already existing fanout group in the same netns.
> Joining such a group would make each member receive only a fraction of
> the packets.
> 
> It sets the PACKET_FANOUT_FLAG_UNIQUEID flag for the first queue which
> asks the kernel to allocate a new, unique fanout group ID, then asks the
> kernel for that queue's fanout configuration which includes this
> generated ID but not the flag anymore (the flag is ephemeral) and then
> uses it for subsequent queues to make them join the same fanout group.
> 
> The bug exists since the PMD's introduction in 2014:
> 
>    # 2014 DPDK:
>    $ git show 364e08f2bb:lib/librte_pmd_af_packet/rte_eth_af_packet.c |
>        grep getpid
>      fanout_arg = (getpid() ^ (*internals)->if_index) & 0xffff;
> 
>    # v26.07:
>    $ git show v26.07:drivers/net/af_packet/rte_eth_af_packet.c |
>        grep getpid
>      return (getpid() ^ if_index) & 0xffff;
> 
> The chance for a collision might look low initially as it requires PIDs
> to be equal mod 65536. But the chance is high for applications running
> in containers having individual pidns but a shared netns, which can be
> the case in a k8s pod, or also with manually started containers, e.g.
> `--network ns:<path>` in Podman. The individual pidns increase the
> chance of different processes having the same PID.
> 
> To quickly reproduce the issue, you can start multiple AF_PACKET DPDK
> applications with qpairs greater than 1, prefixing them with
> `unshare --fork -p` to have each one get the same PID as if they were
> executed in a container. Each one then only receives a fraction of
> the traffic.
> 
> The used UNIQUEID fanout flag is available since Linux v4.12, while DPDK
> currently requires Linux v5.4 or newer. The change is also compatible
> with RHEL 8.
> 
> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Frank Dressler <frank@dressler.pro>
> ---
> v2:
> - remove unnecessary getsockopt length check
> 
>   drivers/net/af_packet/rte_eth_af_packet.c | 27 +++++++++++++++--------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
> index 44f82c0309..fb75bdc6fe 100644
> --- a/drivers/net/af_packet/rte_eth_af_packet.c
> +++ b/drivers/net/af_packet/rte_eth_af_packet.c
> @@ -839,12 +839,6 @@ open_packet_iface(const char *key __rte_unused,
>   
>   #define PACKET_FANOUT_INVALID -1
>   
> -static int
> -get_fanout_group_id(int if_index)
> -{
> -	return (getpid() ^ if_index) & 0xffff;
> -}
> -
>   static int
>   get_fanout_mode(const char *fanout_mode)
>   {
> @@ -877,11 +871,11 @@ get_fanout_mode(const char *fanout_mode)
>   }
>   
>   static int
> -get_fanout(const char *fanout_mode, int if_index)
> +get_fanout(const char *fanout_mode)
>   {
>   	int load_balance = get_fanout_mode(fanout_mode);
>   	if (load_balance != PACKET_FANOUT_INVALID)
> -		return get_fanout_group_id(if_index) | (load_balance << 16);
> +		return load_balance << 16;
>   	else
>   		return PACKET_FANOUT_INVALID;
>   }
> @@ -996,11 +990,12 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
>   	sockaddr.sll_protocol = htons(ETH_P_ALL);
>   	sockaddr.sll_ifindex = (*internals)->if_index;
>   
> -	fanout_arg = get_fanout(fanout_mode, (*internals)->if_index);
> +	fanout_arg = get_fanout(fanout_mode);
>   	if (fanout_arg == PACKET_FANOUT_INVALID) {
>   		PMD_LOG(ERR, "Invalid fanout mode: %s", fanout_mode);
>   		goto error;
>   	}
> +	fanout_arg |= PACKET_FANOUT_FLAG_UNIQUEID << 16;
>   
>   	/*
>   	 * Set the flag opportunistically if multiple queues are requested.
> @@ -1142,6 +1137,20 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
>   					name, pair->value);
>   				goto error;
>   			}
> +
> +			/* read back the fanout arg so later queues join the same fanout group */
> +			if (q == 0) {
> +				socklen_t fanout_arg_len = sizeof(fanout_arg);
> +				rc = getsockopt(qsockfd, SOL_PACKET, PACKET_FANOUT, &fanout_arg,
> +						&fanout_arg_len);
> +				if (rc == -1) {
> +					PMD_LOG_ERRNO(ERR,
> +						"%s: could not get PACKET_FANOUT "
> +						"on AF_PACKET socket for %s",
> +						name, pair->value);
> +					goto error;
> +				}
> +			}
>   		}
>   	}
>   

