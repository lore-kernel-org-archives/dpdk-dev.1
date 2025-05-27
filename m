Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F776C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 19:24:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 154904028F;
	Tue, 27 May 2025 21:24:19 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id C7BB84028D;
 Tue, 27 May 2025 21:24:17 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4766631a6a4so36130141cf.2; 
 Tue, 27 May 2025 12:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748373857; x=1748978657; darn=dpdk.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slNCuezi0D7XZrujwgpag20bZsgmt4bhzwN5n+xzTRs=;
 b=FFeWTcI3IYRNNNj9hf65ccc8iEFODaLX31D9AMdB3vKSl86uX0a+MGdbPrUcVHgwxD
 gcyb/chQ+h3YJK0DH4i2v9nOdvcxRooAUF97ccpMjq5/In1m19426GvOwpUjs22KrU+G
 T/fuR/U9y+Dwn800RZh//cHYfUiP8J5v0VypXf7wyjgfN/gv2cJC+j2xLpaWt1Sy9o4J
 kmRwaapZM/y/D5o4pwuS5w+JURoGubyocAS23w+NhhOoP7Q3KgvXWZTsySPuT0XnITIz
 jwxo4jeX5AxhhRAZ+UhQzYo/364+KjtaOW8plPgf174Q4bIpeZrMsshLRqt7DlU9h77V
 CehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748373857; x=1748978657;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=slNCuezi0D7XZrujwgpag20bZsgmt4bhzwN5n+xzTRs=;
 b=kVWJEadKrbdweDUwttrGZsHBmlhLbchh+Tdna/aMLAyO7nxRXEkW5rL9m0FavRXMOm
 Rsl/0LpRPxK7cLnwOsq9ax7HYvz5C8Bv6OsXVxFAv/iyNvaVkPPawT8MV1x9ELi29dfa
 jRs1kj7wvlBx06eAvvB9Wi9pljtmmxi5NqJxjWlqsH2eWM30yzARByaz5S54Bg2cxGKO
 +6GRx4SKqo/rYTCh5y/6+GBOqOPCQcI4KGJNLlclOySIsGBeEOcXS0crTAOKKB4iY2Db
 9KncJ4SdKKcSVy8Xu1VI2jgCmMkkX7AfGWJZmXXkoMjbtxMTcMwKUHNfl9DYI/HRyRai
 E2Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCjHpaF47Y+NVKkFPI/JQN7vvwpFg4yAa73w8UUbVirPTNEcFqjuBpzCVKwqcWc0vuuuieH7Y=@dpdk.org
X-Gm-Message-State: AOJu0YwyzFk1kjZHRburpf1itIb7py8nusiCG4oF0GVVGJ+MX8+15JAJ
 XbEKuqY87nSpTRTSsR30blXo6lN8QnpN2/zBse909mrH2hTeIihqKElB
X-Gm-Gg: ASbGncvxsPIT9aeLjd4ivFCR0rp7sdvNdrR6bC5++fzq903tPwhcxNL4LIndrU7hj7d
 HfGe4q34QvHnha5jUNQ+v0x89LWoREPGWz+i9XZvCk2XfEtTtrxDfz0zdR0I5aeAOArLoWTl/1g
 3ZibxxE78GbXjpMpbzvqddk3u0ZdSmmTcu6VFsiRdv7t0ySX5wHvTaBxegO7bQ3Cx/8ayFXFa2H
 pAsv7T4Bzim3M/G1x2K+i+tQyhCAMJ6A+vAKyuMfwUSKF5GXZETmjHMY4ZrXPsCWmA6KDxbGKQ+
 w1ITKTW3rbZ/M/4Xqx/JoQp6zy/7Fo4cBMqmLdzycDpkhb3whVbjM2uxMb2ZfG7pQSJ2uJdjJV/
 ThGfs+Qq3k/zx/xHmjllLIdo9
X-Google-Smtp-Source: AGHT+IFJl8kGXp2uV40EWZibRK1MI6Ns6j1K2dnVv6qs/DyC48FUXLgYPE/M/ZkwMuzWCK0/4ypP9A==
X-Received: by 2002:a05:622a:610a:b0:476:903a:b7f0 with SMTP id
 d75a77b69052e-49f480c95c2mr212877651cf.49.1748373856944; 
 Tue, 27 May 2025 12:24:16 -0700 (PDT)
Received: from [10.249.152.235] (nat-216-240-30-23.netapp.com. [216.240.30.23])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f925fdd1sm284391cf.12.2025.05.27.12.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 12:24:16 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------3QkkKE0lD0empIQig5ntmjkN"
Message-ID: <73ac3428-f8bd-4473-a451-97646c6fd18e@gmail.com>
Date: Tue, 27 May 2025 20:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/virtio: add request check on request side
To: Radu Nicolau <radu.nicolau@intel.com>, Jay Zhou
 <jianjay.zhou@huawei.com>, Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org
References: <20250523140450.75543-1-radu.nicolau@intel.com>
Content-Language: en-US
From: "Zhang, Fan" <fanzhang.oss@gmail.com>
In-Reply-To: <20250523140450.75543-1-radu.nicolau@intel.com>
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

This is a multi-part message in MIME format.
--------------3QkkKE0lD0empIQig5ntmjkN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/23/2025 3:04 PM, Radu Nicolau wrote:
> Add same request checks on the request side.
>
> Fixes: b2866f473369 ("vhost/crypto: fix missed request check for copy mode")
> Cc:roy.fan.zhang@intel.com
> Cc:stable@dpdk.org
>
> Signed-off-by: Radu Nicolau<radu.nicolau@intel.com>
> ---
Acked-by: Fan Zhang <fanzhang.oss@gmail.com>
--------------3QkkKE0lD0empIQig5ntmjkN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/23/2025 3:04 PM, Radu Nicolau
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250523140450.75543-1-radu.nicolau@intel.com">
      <pre wrap="" class="moz-quote-pre">Add same request checks on the request side.

Fixes: b2866f473369 ("vhost/crypto: fix missed request check for copy mode")
Cc: <a class="moz-txt-link-abbreviated" href="mailto:roy.fan.zhang@intel.com">roy.fan.zhang@intel.com</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable@dpdk.org">stable@dpdk.org</a>

Signed-off-by: Radu Nicolau <a class="moz-txt-link-rfc2396E" href="mailto:radu.nicolau@intel.com">&lt;radu.nicolau@intel.com&gt;</a>
---
</pre>
    </blockquote>
    Acked-by: Fan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:fanzhang.oss@gmail.com">&lt;fanzhang.oss@gmail.com&gt;</a><span
    style="white-space: pre-wrap">
</span>
  </body>
</html>

--------------3QkkKE0lD0empIQig5ntmjkN--
