Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD4CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 13:38:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 421AC4042E;
	Thu, 21 May 2026 15:38:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B93D9402B0
 for <dev@dpdk.org>; Thu, 21 May 2026 15:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779370733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Wmf5xTHnQzEYvggrRQvSIF9cMi9sbGfB3L0DyvA1ZbM=;
 b=NlnSIEmsey0ApAZLOEIrBMrc3NaqjpIZudE2VXkqEVbJCynDjJTc0ckujEAOchHu4eP4gV
 bdWuqcOXoig0FVzMUBOKqGTrrER9xwnfZaxCxmc4w1JzjyDDGKlTjdSvEenz0O+ZQBWdbY
 3K7tJOx/112DEMlihSgVr5x4hCqZtaA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-6f5ymIAgPYO06ourQIagOg-1; Thu, 21 May 2026 09:38:45 -0400
X-MC-Unique: 6f5ymIAgPYO06ourQIagOg-1
X-Mimecast-MFC-AGG-ID: 6f5ymIAgPYO06ourQIagOg_1779370725
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fe3e73da6so29697925e9.2
 for <dev@dpdk.org>; Thu, 21 May 2026 06:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370724; x=1779975524;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wmf5xTHnQzEYvggrRQvSIF9cMi9sbGfB3L0DyvA1ZbM=;
 b=UnQlnYg0tst6fVuL1e9zicGVdh+0vx1lRjyZTRubhK1kFEz0M6IF+eu2uBQl9WqXEz
 Kg/AiVXD6riLsZmCJQkwqt9kgU0SJRF+KcekIlQ1jCs82ZrIX70ZdAwJ0K1dJS7otYuy
 kfveTKauHP+YqVvglH6IWjnbl7tKPpmDSNBcRZ/u5YGxPoHMusrN4puy76fEUCiUV2kZ
 AStqUtcJdEwt8zEMFjT8FNc0jGvcZXdFvmGjAS1ItOrEPe7sr2F9S8yAXqy8rpjZhaFR
 pZgCbbseAPD64ukJmZJ5snMJEj1F13UV1GjLvVQszwlP1jnzRoTFp4qYXc9CCL0dqP6g
 C04A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MeRWX/ZV2rvbUMQd1XgRfd31P7TrgB41+U2K59AHPdZWz6y9oc23LtHgbYCHlWmb/5BI=@dpdk.org
X-Gm-Message-State: AOJu0YxeOLNFbCWHuE/EZpJrbQifreuR0pYr6b/l+rzuFDFW4Vu5WIuC
 UutIbYTrOALcv5lINRkmF9hthlYVpYlTlD40q0DORbJuUzNX7v9XuzmGkDPqP3mzIPuIVOaBzM9
 JqCVbYUs0SygT8SH6Dj4+84ybb80wFZzMiWda7wl7U8fs
X-Gm-Gg: Acq92OGdCxXMJw9VDlluz+YTwJzEE+iCOxwCuBc3kL5RvYGsyM3X+52puxvT5HnWG3X
 +QoZCpqKR6sLy3HDEqJQoGVlQlrAmn1b2ma13qIqsoqcFd2LFPQmv1259kSHbIR9fOAsCwtBqGj
 09HWBmwaAQd2BXW/noY0BHiH3DMYkgkP9Rcuak2wJDuncmZMWGeqz28ac9y0E4fMXK+TmA49f/O
 keqEW/8DsqrzfAXGWk4AQj16UlHxeFtOQGy5XJoddgobUDF94lvge4U7fAKoFXUmLQoU2kUKv1d
 AVcmbNRO96nz2+LRopM+5xAW6HripDs02E8DsesqtHtW9/GqAQv5x1j6jWZgDuZIsfIoShQSRNj
 I2snzVaCAlMi1c+5xigykCg==
X-Received: by 2002:a05:600c:848d:b0:48a:93d2:60d2 with SMTP id
 5b1f17b1804b1-49035fb92c1mr45120945e9.0.1779370724519; 
 Thu, 21 May 2026 06:38:44 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:48a:93d2:60d2 with SMTP id
 5b1f17b1804b1-49035fb92c1mr45120605e9.0.1779370724111; 
 Thu, 21 May 2026 06:38:44 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.129.88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c595e6sm28703735e9.1.2026.05.21.06.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 06:38:43 -0700 (PDT)
Message-ID: <0fc8a941-58ed-4901-8310-44c3a8d4b049@redhat.com>
Date: Thu, 21 May 2026 14:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk v5 2/5] net: support multiple stacked VLAN tags
To: Robin Jarry <rjarry@redhat.com>, dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>
References: <20260422102814.645299-2-rjarry@redhat.com>
 <20260518132712.70913-8-rjarry@redhat.com>
 <20260518132712.70913-10-rjarry@redhat.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20260518132712.70913-10-rjarry@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2dujfkX5eDw10AlSqKJG8T4UItbRpW28XbyO4BSRbEU_1779370725
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 5/18/26 2:27 PM, Robin Jarry wrote:
> The VLAN and QinQ code paths in rte_net_get_ptype handle at most two
> tags with duplicated logic. Replace them with a single loop that
> consumes all consecutive VLAN/QinQ headers regardless of depth.
> 
> Bugzilla ID: 1941
> Suggested-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  lib/net/rte_net.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index c70b57fdc0f8..d3cded961fb5 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -349,29 +349,26 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>  	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4))
>  		goto l3; /* fast path if packet is IPv4 */
>  
> -	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> +	if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) ||
> +		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ))) {
>  		const struct rte_vlan_hdr *vh;
>  		struct rte_vlan_hdr vh_copy;
>  
> -		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> -		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> -		if (unlikely(vh == NULL))
> -			return pkt_type;
> -		off += sizeof(*vh);
> -		hdr_lens->l2_len += sizeof(*vh);
> -		proto = vh->eth_proto;
> -	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
> -		const struct rte_vlan_hdr *vh;
> -		struct rte_vlan_hdr vh_copy;
> +		if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN))
> +			pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> +		else
> +			pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> +
> +		do {
> +			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> +			if (unlikely(vh == NULL))
> +				return pkt_type;
> +			off += sizeof(*vh);
> +			hdr_lens->l2_len += sizeof(*vh);
> +			proto = vh->eth_proto;
> +		} while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
> +			proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ));
>  
> -		pkt_type = RTE_PTYPE_L2_ETHER_QINQ;
> -		vh = rte_pktmbuf_read(m, off + sizeof(*vh), sizeof(*vh),
> -			&vh_copy);
> -		if (unlikely(vh == NULL))
> -			return pkt_type;
> -		off += 2 * sizeof(*vh);
> -		hdr_lens->l2_len += 2 * sizeof(*vh);
> -		proto = vh->eth_proto;
>  	} else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
>  		(proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {

David's code snipped earlier in the thread suggested that this should be
change from an 'else if' to an 'if'. It seems to make sense to have it
as an 'if', not sure if it was deliberate to remove. Though it might not
be really part of this patch.

-       } else if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
+       if ((proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLS)) ||
                (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_MPLSM))) {
                unsigned int i;


>  		unsigned int i;

