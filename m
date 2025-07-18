Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C63C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38C394021F;
	Fri, 18 Jul 2025 17:03:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D6B5440144
 for <dev@dpdk.org>; Fri, 18 Jul 2025 17:03:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752851004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j8CXLA+GtyPwBGQfv7g8WKqoctv8zgMkbv/0kdzJMHY=;
 b=G5TmoXxBtMv4cMEQBpWXP2XYk6/1RAF8/9WFDTnGtXESZy5bdnX06XfzfFR09eRXQNyJLj
 rFx4F5gifzJqyAF6Tpb/MvTtWJTYZDXF312lJg05NLzB4rIXyqRpthPAkW2BX88iO6crXa
 OmjHanUzLCo1AEjnhmqXsm7rqN+o4po=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-T8GxMAkYNIGEEFNu8-XSsQ-1; Fri, 18 Jul 2025 11:03:23 -0400
X-MC-Unique: T8GxMAkYNIGEEFNu8-XSsQ-1
X-Mimecast-MFC-AGG-ID: T8GxMAkYNIGEEFNu8-XSsQ_1752851002
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b61e53eea3so411468f8f.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 08:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752851002; x=1753455802;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j8CXLA+GtyPwBGQfv7g8WKqoctv8zgMkbv/0kdzJMHY=;
 b=YoSby1m40insqlNTMIuAY9Nhr0xEkRQ2gs7Bz0V5cCECiyK2XYAF9w3n6K2uG/Mmdi
 7iKLEWDLZqZzBlg15T2tFExt8pG8CLBp7KWAsy01RPyXh/oRrxCzHmi5h4UY/mLDldFZ
 phmlW0ZeCb6/sttcdj35/D1eyjDMgCWXumpxjoHABah+ScpOSg4OVawfcPAvxiqbzIvv
 Oo/jSC+M/xJIS9EMvuHfsPNll/bdi0/cMHH25P6H1ovYv/ME2r+AXG6w9sJ5KAXnXmiy
 CQzxTq6+zC87DfGd7hSko3zeJao2c7A8EML6UVZqWXApnwkA5BzU0TulYVYJ9IBn928h
 WyOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVnIGVQcqcRLGgdGC3IWLYkLn5HNksnef5Pj+Vow7a/deNA3sKzgfSQQuKNQWS6XQyH28=@dpdk.org
X-Gm-Message-State: AOJu0YwZ7czZz68NKV3cWu+Nza4ejZzbUN9kH20R2Tzxs4ygamyUZPJC
 tzw/siHfj/FX1BX9RLPC3nGQxtfiAVqNKE7CXqS1fbkxtk+tke+qkidUPK2vSC/Mjb8MBzZOvz4
 Thv7W/e7KyomLkuaO6jFwIFqebWbm5URPgCRbHQc7inQg
X-Gm-Gg: ASbGncvm3AKY3egC5TkpLjuJp6hlWGN5Yisv85OgNTrOuXsU0Zba6zvtS/RyrzpbEvK
 HWluUlaxe31Ht53l1SZoBYiO5EkDQRFPfdM3YVjYi5mKg/LsLmSceXLrIiTzYYaL0VghNaJ3LLs
 FLjtI7aPMDZuxGahrSFQO9SRMYpmROlqmGPT/HG1unlEMZun58KH9BLxtjr7lbIE4k0FuswqIfA
 z7f6EyQIxUx08h4ScN8WkTkfmvtgkIBGFAbaUhBAdy9y4f9UJ98usZEqw2tUDrZZaLVgbhPo/6Z
 2Xmx3KAIj7LHPL8MIh/ZoylXxYS67jxHI4pSug6DrQ==
X-Received: by 2002:a05:6000:2308:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3b60e51d196mr8518580f8f.45.1752851001227; 
 Fri, 18 Jul 2025 08:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHlcE+LrqGTuNd2nMuFUzLg85Y17qGAP1VQ73fJy0zDi+9I2w7pIjNnPxOnAaUbOL9OjYlYA==
X-Received: by 2002:a05:6000:2308:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3b60e51d196mr8518526f8f.45.1752851000654; 
 Fri, 18 Jul 2025 08:03:20 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.130.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca5c712sm2139009f8f.79.2025.07.18.08.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 08:03:20 -0700 (PDT)
Message-ID: <0c964d09-7b83-4367-b6cf-6cc05bd64967@redhat.com>
Date: Fri, 18 Jul 2025 16:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/intel: deprecate some SSE paths
To: Ciara Loftus <ciara.loftus@intel.com>, dev@dpdk.org,
 bruce.richardson@intel.com
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
 <20250703143119.1140097-1-ciara.loftus@intel.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <20250703143119.1140097-1-ciara.loftus@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lbWU6z0h5BfagIOi6S-cNItzrvUu-KlsCVfPUnW3-Pg_1752851002
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

On 03/07/2025 15:31, Ciara Loftus wrote:
> The SSE rx and tx paths will be removed from the i40e, iavf and ice
> drivers in the 25.11 release. Each of these drivers have faster vector
> paths (AVX2 and AVX-512) which have feature parity with the soon to be
> removed SSE paths. In environments where AVX2 or AVX-512 are not
> supported, the scalar path will still be used, which also has feature
> parity.
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
> index e2d4125308..0d020c9c1f 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -80,6 +80,13 @@ Deprecation Notices
>    and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
>    will be removed in DPDK 25.11.
>  
> +* net/intel: drivers that have an SSE vector path alongside other vector paths,
> +  namely i40e, iavf and ice, will have their SSE vector paths removed in DPDK 25.11.
> +  Modern x86 systems all support AVX2, if not AVX-512, so the SSE path is no longer
> +  widely used. This change will not result in any feature loss, as the fallback
> +  scalar paths which have feature parity with SSE will be used in the cases where
> +  the SSE paths would have been used.
> +
>  * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
>    should start with relevant protocol header structure from lib/net/.
>    The individual protocol header fields and the protocol header struct

I'm not aware of anyone using hardware that old and relying on SSE, but
it seems a bit short notice for a patch to remove hardware support.

Would it hurt much to give it a longer deprecation so anyone who needs
to prepare by upgrade, or taking 25.11 with support etc. can do that ?

