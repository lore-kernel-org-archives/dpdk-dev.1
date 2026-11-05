Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF283606A33A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNpv5ugO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43D8D427D8;
	Thu,  5 Nov 2026 21:07:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 3D6CF427BB
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793909234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UMVFaMSBsh+8kmjv3PRnIMaQhdS9scIZfTRJPqaItz4=;
 b=PNpv5ugObAF98oeiWG529bFXhpbXAiszcHf1y9wcX8CKinjmvvWjvKAclk8wNVqKHeCGI+
 fKEmu0VYu4f/z9gHnjPKZ3an+S5sLWHo1mruay3zWRlqfQmys/N27OBEVpcXNgfoAApSOh
 4LQhBtBWWUkiISr1foL38p1wnHjrY5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-7kGv-ytGMwKRD7fkwQjlmQ-1; Thu, 05 Nov 2026 15:07:10 -0500
X-MC-Unique: 7kGv-ytGMwKRD7fkwQjlmQ-1
X-Mimecast-MFC-AGG-ID: 7kGv-ytGMwKRD7fkwQjlmQ_1793909229
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4903fc8537aso1487245f8f.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909229; x=1794514029;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMVFaMSBsh+8kmjv3PRnIMaQhdS9scIZfTRJPqaItz4=;
 b=z3bfZ1aXG39at671kKbuYiBeAQQMrhjuHiCI/nhoEcsrthoaVfd8Vu6rVUeGgZT6Ls
 nKasTwrOWWpfrn5EHW6V2PUTes1F+ruM973f95fzU4Mjn9j0bAZGmcBqeAR9j7pXLxkx
 Xt7zwxQMoyNwFhhWuKAAmATKXG0rfCeCfj0flFuB6KVon4i+aAR9OkkcQpM0GvLzm6Qk
 7cGzKiikZC0ymEdFEPxleIIB0PNuIS255xwoeGfenGJecQLM2ag6cmJjWrjadfiFjvf/
 ZR62y0/jLQotozw1YTl8PhyT+d3L0o5JYORraLr6s6vTlzzy68NhD5/hIfinTsfuhXcw
 Qehw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpLoVF5WtWs57TS74ZrOFoKZDuc4qSrPXF8Y2lSNMuzB9hgtF5KfVF8P4Z88ClfnFA+Pc=@dpdk.org
X-Gm-Message-State: APuU4Z/Q5XUX+KUyvkZi1sAQJuifjR38xncE0IhYgaDsZgELe3ol0mWi
 ZDlgcG8i70Ze1Abz6AsiU48sy5Ih+5LOOt+iPKeTlm9/FoGUI+cpxwg1fvKZQODBDl3l3MKMr58
 L9wTHJ1wpY7nf2WUuDkkNYUMW25NGThRilj6MRnFxxxP9
X-Gm-Gg: AYBFou3AJwp1ooFzeLIliDb2bEAvFzVp0caXH6xGGb998ML1O8i4vSZRDuNyt4CDhjP
 2ABmcHyOttsEZrjpgRCOft5kKvDxj+nZpT29xnVLFi/a5gXoOPTAmm+aM3tSKEmi/XNzTvXLLOM
 ugOiG82U9300E+Y8RmLIKcQz0Rw6U1pOce7Rkv2HHofWy8kyNSsSUMxXU3axrt9bor8FGJDTAuU
 AS3AyIHYMZ0N4MGBE5rMrKGoaMbDWxFUGv65LjFR00ACu2hQ2i1alu9+puYokse1jJL6NK3v1vS
 Kg8FbFsMCxy5J7yOzqmnM4cJ9+cT4en8W3VE7DFeyyMwEQWi0DaNQGY3elFxVmL2eo0z5Z6G7x0
 RbzaYKMNxzI4/MUXkpx14/GOaUuwyBujE0fLghiqFtkk8GelFdYE2Xkg9AOZf6UKtB2ZP03lFB2
 aitZEAPrUlgdkU/It/UbWSc4chvr4JaY192yt7O8rbTQQNVUr2VeV4WOGS1HTb4OCuoj3XDQqES
 BcCvV1QENRsYwJNB/vefgpZreum6LTxs/puRStXpfFghJmOnzG2Lw/XGxbus+LlKwCzpfSZAg==
X-Received: by 2002:a05:600c:4fc9:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4b6e017053fmr3160495e9.23.1793909228886; 
 Thu, 05 Nov 2026 12:07:08 -0800 (PST)
X-Received: by 2002:a05:600c:4fc9:b0:4a2:d99:3171 with SMTP id
 5b1f17b1804b1-4b6e017053fmr3160155e9.23.1793909228443; 
 Thu, 05 Nov 2026 12:07:08 -0800 (PST)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6df5eab6esm4477625e9.1.2026.11.05.12.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 12:07:07 -0800 (PST)
Message-ID: <91c80bb3-a158-4a33-9a0e-9561b10dcfca@redhat.com>
Date: Thu, 5 Nov 2026 21:07:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] baseband/acc: fix queue depth computation error
To: Hernan Vargas <hernan.vargas@intel.com>, dev@dpdk.org,
 gakhil@marvell.com, trix@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com, stable@dpdk.org
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
 <20261103172902.4152956-3-hernan.vargas@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20261103172902.4152956-3-hernan.vargas@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t-4wmw7KvrJhZtRhAR1EriXFYvJtynNOQXKyog4RUn0_1793909229
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/26 6:28 PM, Hernan Vargas wrote:
> Fix to the computation of available dequeue size.
> Protects notably for possible negative scenarios when dequeuing
> descriptors.
>
> Fixes: e640f6cdfa84 ("baseband/acc200: add LDPC processing")
> Cc: stable@dpdk.org
>
> Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
> ---
>   drivers/baseband/acc/acc_common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

