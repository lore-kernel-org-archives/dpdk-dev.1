Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D96CA5FDD
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 07:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C614026A;
	Sat,  3 Oct 2026 09:25:44 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 37C344003C
 for <dev@dpdk.org>; Sat,  3 Oct 2026 09:25:44 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6acb0fb5945so308218a12.3
 for <dev@dpdk.org>; Sat, 03 Oct 2026 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791012344; x=1791617144; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OOXCAmlttTw8V4pHGyF3Z6eiW0IWbh9tKQ8t+488F8Q=;
 b=Pabtl4QQKuN1X6dtFqaYWAlXp0l/H+XzLxrRgV5eLEnL2D0nuyZkyd9mXWZeHIe2qR
 7QrQn2DsvmVaOejTwy8ECuHy1PL1LUJZxDvwwJ/hTm1khAs4ZZ/QAlZFYvxwsHab9kx9
 GyD2OAOxvqrSLKsxGFTQCCptje8sRcT3VASrT45oIUKfZ9CrSL4Wl4UO1Vmlj6HIUPgc
 gtSxzfu0P7onj/aK0Xof70IufcvIc1L4TFgI8jLWuK9HUtNTKb+9yAwsCYlwlbafKV37
 orTyorIo1ioc6vJ1ocEmCPSr/vicJ+cyRZhEA3q5VHpO1z6C5lrLCpBFWMOM3oJOVhN+
 iHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791012344; x=1791617144;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OOXCAmlttTw8V4pHGyF3Z6eiW0IWbh9tKQ8t+488F8Q=;
 b=tNmvLfCUSZ6POFuaZ85D33zaABGx9x4Sf1CVXITPW+DIIsGFbZybMedKLIVZjxiBhm
 OXthYDzsVHTVEu851qzf/qPhhpUwM/3CFhIMRrmZlC/RAKalxTx2id04q0EJu7VeRA6z
 S9U65T/Y/1IhTbXZ8nsJ+TegFfKrfIc9KTos+LHt3LpqGI3lv1jOwb/e5TG93yXaIlPU
 8noR6Z2Go3j2U67CSrqR/FRKOXwFF75UI1ANcuLCyUIOWjt5I1Zo+/k1ckLttIU0391J
 KefqxIFkDI/PzRktuGbyKzuawFs1i8/roiNTdMS3FzNAlxjH3o6N76E7qxLos8O1/X8k
 H5ug==
X-Forwarded-Encrypted: i=1;
 AKwUvByd2Y88SH2gUY6feYWdRTHQDtfblwDvOYerG6NLjs1YbkxlxyxOM9a27SJqhB2Tv4igZa8=@dpdk.org
X-Gm-Message-State: AFq9FYJXQmZfVEH1b+vofSHJcyAbyHnHh6/lKpMwrp5wH0ZQECfzgN5E
 3cCvD3sVkQaaiOhzQRIYB0G+Xtunwl6BU6mNYdLjgeSMt4QxBIh9IKnKIaJckFD7HFs=
X-Gm-Gg: AYBFou179gWZ8yEjyiAYZHEY4fku9Dux3VztZXeOIrhkAtdKMPmf/9mDwZBh29Zi5ZX
 KoyvvX54Daa0h2lCt5zzciwqKX9798D/m4EIlU0H1bC8+AyecXUehhyA4vPsRBZO/x/JdCNYNYt
 IC63ERp55DH6j4IrRov5/w/8q/uTpp5WXrJBtKquDcWDGu30wxISZNzxmIcrlbkn5lv61BKzuSW
 6M39pA+1WuRPkuTguaINJ8SPCXxahLk02oxpai7yZ5SxDVuBax0t7+z4o+KM5z58WsjVimePGsK
 IEzB+Txq7qsxxNeMkPsxnYE26BoSChT2yHQ4BBoBoMkiPerGoqUblXUQpdO73m1X3uzyM+pIPus
 g6MHhgMlSnZasTWtCb/QDUw0buh9OdPCpFzmkdq7M1XvLXJIHXJ1yAZny48tnPE/k+U6PfXS7GS
 R8XmvcPn1eUx79raAMhEVAHqGzMTgf42YJ/gJxLsKfEL+U5q8RDdS2vvfmBprIcTD0DZA=
X-Received: by 2002:a05:6402:23cc:b0:6ac:686b:f7f4 with SMTP id
 4fb4d7f45d1cf-6afad8cd90emr1436567a12.12.1791012343404; 
 Sat, 03 Oct 2026 00:25:43 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.33.169])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6afb021af56sm526747a12.31.2026.10.03.00.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 00:25:42 -0700 (PDT)
Message-ID: <0ac0e7cc-f75a-4f97-a333-070532da1969@gmail.com>
Date: Sat, 3 Oct 2026 08:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: remove unneeded null check before free
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
References: <20261002171707.928034-1-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261002171707.928034-1-stephen@networkplumber.org>
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

On 02/10/2026 18:17, Stephen Hemminger wrote:
> Found by devtools/null_free.cocci.

nit: should the commit message quote specific coccinelle output being 
fixed?

> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>   app/test/test_cksum.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
> index 73f2511731..d94539820a 100644
> --- a/app/test/test_cksum.c
> +++ b/app/test/test_cksum.c
> @@ -320,8 +320,7 @@ test_l4_cksum_mbuf_chain(struct rte_mempool *pktmbuf_pool, const char *pktdata,
>   	return 0;
>   
>   fail:
> -	if (m_hdr)
> -		rte_pktmbuf_free(m_hdr);
> +	rte_pktmbuf_free(m_hdr);
>   
>   	return -1;
>   }

Acked-by: Marat Khalili <qm2k21@gmail.com>

