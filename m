Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D2CCA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 Aug 2025 00:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8FE140292;
	Sun, 31 Aug 2025 02:56:04 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 533FE40263
 for <dev@dpdk.org>; Sun, 31 Aug 2025 02:56:03 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-327f8726b95so1529800a91.0
 for <dev@dpdk.org>; Sat, 30 Aug 2025 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756601762; x=1757206562; darn=dpdk.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3t6M1mgJhn7ba6cg4XIjjhTRypLJKTR6YYO4lohIeH8=;
 b=fj82wurPqx6zoEPsmBPMCXp/3fJt2lDQ+LVl1Bea3Lh3YwJOupdEYDKjBMra1MMw0r
 0HcpBDMH2C0bqH/8c80+z+iNyYBz9CGpqpEGBzk3Z7+5WaVmTluYM8+DW/X9ikkEMR9A
 i89Z63e2NL9ucjXnNogSegynlAT26KP7gnvArgdADHpDZUhMV735uR2VMg0H2bB7bJrk
 8ribdIeN/trO80oslQro23UZB4Hw4IKkWEUvi+YahvmoQdiGhO6kj1TFP530uDVV4Dg2
 Q7BXY6PXm8smc3H85jw21Jsf8SCTGxHu3dN3g10x9RCxWpedLmN6tBJPAtaja6sBT3BJ
 dcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756601762; x=1757206562;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3t6M1mgJhn7ba6cg4XIjjhTRypLJKTR6YYO4lohIeH8=;
 b=k12RPnXo+xnxVsk5bQSQVeQAers7i8s5W8vlRHF0JeWaxMzpWpNm6bQTHIeC2pCt1A
 sYNwymbcWxlDoZeXQHBodmGj473x0NYkABC6zAzN3hrZn+ng088QwhJGeKFQYxJL7nJ5
 PF7fLIWdyFtsAvJKxMRL2QuB8ivLTrQ0O6o/AincXhic8Jeo94NzFP/l4vOplgiiaJiV
 EqSd/XaAR5LcAkBBfG2h/yk72bfrO4q1fdXIC8HZdWI5XyP1eHJqNqnAXvwcoOFuhwXw
 WHGm6it86LjWBTH92TaYsw9hxlV4wRKqFoAsvM3AUbjjsYNAZy+LHbVSv/dOd96Sl2EE
 RbSA==
X-Gm-Message-State: AOJu0Yxr8w31qRpr1PgAQTR664gei29vCyvABUNiRvPhWDkk8is3uDcJ
 Qt985JLw1aZZp9cLGalsEJ7IoEPxTx/8yIA79QLLRsgTnDFQaVA2fARu
X-Gm-Gg: ASbGncvJCo7kT5wS/q4H9IS7eJ+xSYJLJh4CHfyKblqlQObMaHn/I3NeHHzKNMFxb/K
 GlKiqgKwlrtXbqeBjTMB38EXxLWMMGPPC45YDhvc4TProc1rVdfwIqLEsDZo9Y7YhhCztGoEVYD
 BDwV4c1J+D/GeSENhvr/LptQ16xmM4aktPa61dDPvpBNfe0V1G+JCOYb5uIph3Mt/YDJuB8uqrO
 fokhAesWkq7HfC5AB85AObgKrY58A4NubNCvJjTeNnp7llUZ3eho45GxhNfb0pJXMwz6OnMLTrn
 2sxVZyVH+CgXLzcL5VxO+uULTkIzvk51rr/RTJOAQhTIhuYicopvFjvjw6bFqHZMrtyVfk6jBgw
 TLvnpS0Do1lZpUbN5cuHRP8ftCrB6a9OXwjfi+6zraasIAyDRzvRC59Ui/w==
X-Google-Smtp-Source: AGHT+IEH80tWtiHs35wN7iC+hcbvOCMWjxegDRALXhCZt/kU/o3IhJ58+oquBirhcdHW/xEdW0x1rg==
X-Received: by 2002:a17:90b:3c0f:b0:31f:ecf:36f with SMTP id
 98e67ed59e1d1-3280d2ba78bmr5531512a91.1.1756601762236; 
 Sat, 30 Aug 2025 17:56:02 -0700 (PDT)
Received: from [192.168.31.142] ([125.120.234.137])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327da8e7186sm6966369a91.16.2025.08.30.17.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 17:56:01 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------1bvPp660WTz2z0xH6vzzPGE4"
Message-ID: <4699661b-3c78-4be6-a743-5f02f3da7e7c@gmail.com>
Date: Sun, 31 Aug 2025 08:55:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20250829125734.7fd3aae2@hermes.local>
From: Moses Young <mosesyyoung@gmail.com>
In-Reply-To: <20250829125734.7fd3aae2@hermes.local>
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
--------------1bvPp660WTz2z0xH6vzzPGE4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/30/2025 3:57 AM, Stephen Hemminger wrote:
> On Fri, 29 Aug 2025 22:49:52 +0800
> Yang Ming<mosesyyoung@gmail.com> wrote:
>
>> The current implementation hardcodes the socket file path to
>> /var/tmp, which has two issues:
>>
>> 1. Hardcoding absolute paths is not good practice.
>> 2. /var/tmp may not be writable in containerized or restricted
>>     environments (e.g. when the filesystem is mounted read-only).
>>
>> This patch replaces the hardcoded path with a socket file name
>> (MLX5_SOCKET_FNAME) located in the DPDK runtime directory
>> returned by rte_eal_get_runtime_dir(). This ensures the socket
>> file can be created in both normal and containerized
>> environments, while maintaining uniqueness by appending the
>> process ID.
>>
>> Acked-by: Dariusz Sosnowski<dsosnowski@nvidia.com>
>>
>> Signed-off-by: Yang Ming<mosesyyoung@gmail.com>
>> ---
> Rather driver specific logging, why is there not a way in EAL log
> library to ope a diagnostic dump.

Hi,

Thanks for your comment. This patch is mainly an adaptation for
our product, which runs in container environments with read-only
filesystems. The goal is simply to remove the hard-coded /var/tmp
path while keeping backward compatibility with existing test cases.

I agree that having a generic EAL facility for diagnostic dumps
would make sense in the longer term. However, I believe such
further development should be handled by the mlx5 driver
maintainers (Mellanox/NVIDIA), while this patch focuses only on
the immediate portability fix.

Brs,
Yang Ming
--------------1bvPp660WTz2z0xH6vzzPGE4
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
    <div class="moz-cite-prefix">On 8/30/2025 3:57 AM, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250829125734.7fd3aae2@hermes.local">
      <pre wrap="" class="moz-quote-pre">On Fri, 29 Aug 2025 22:49:52 +0800
Yang Ming <a class="moz-txt-link-rfc2396E" href="mailto:mosesyyoung@gmail.com">&lt;mosesyyoung@gmail.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The current implementation hardcodes the socket file path to
/var/tmp, which has two issues:

1. Hardcoding absolute paths is not good practice.
2. /var/tmp may not be writable in containerized or restricted
   environments (e.g. when the filesystem is mounted read-only).

This patch replaces the hardcoded path with a socket file name
(MLX5_SOCKET_FNAME) located in the DPDK runtime directory
returned by rte_eal_get_runtime_dir(). This ensures the socket
file can be created in both normal and containerized
environments, while maintaining uniqueness by appending the
process ID.

Acked-by: Dariusz Sosnowski <a class="moz-txt-link-rfc2396E" href="mailto:dsosnowski@nvidia.com">&lt;dsosnowski@nvidia.com&gt;</a>

Signed-off-by: Yang Ming <a class="moz-txt-link-rfc2396E" href="mailto:mosesyyoung@gmail.com">&lt;mosesyyoung@gmail.com&gt;</a>
---
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Rather driver specific logging, why is there not a way in EAL log
library to ope a diagnostic dump. </pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">Hi,</span></p>
    Thanks for your comment. This patch is mainly an adaptation for<br>
    our product, which runs in container environments with read-only<br>
    filesystems. The goal is simply to remove the hard-coded /var/tmp<br>
    path while keeping backward compatibility with existing test cases.<br>
    <br>
    I agree that having a generic EAL facility for diagnostic dumps<br>
    would make sense in the longer term. However, I believe such<br>
    further development should be handled by the mlx5 driver<br>
    maintainers (Mellanox/NVIDIA), while this patch focuses only on<br>
    the immediate portability fix.<br>
    <br>
    Brs,<br>
    Yang Ming
  </body>
</html>

--------------1bvPp660WTz2z0xH6vzzPGE4--
