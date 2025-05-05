Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B48C3ABB9
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 22:47:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 729B74025D;
	Tue,  6 May 2025 00:47:08 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51]) by mails.dpdk.org (Postfix) with ESMTP id 7691C4003C
 for <dev@dpdk.org>; Tue,  6 May 2025 00:47:07 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-54addb5a139so5586541e87.0
 for <dev@dpdk.org>; Mon, 05 May 2025 15:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746485227; x=1747090027; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PXN9Uh5afi+KYKaDgb8LxSR0IO8QoZAQtPGstt/8ams=;
 b=TG9ICDdH9p6pwVY1b+ykthL05e8+hnSmyJ1WkW7yxDd8pEekyW7HBhCu3PxPjsXq1K
 Ay31kmEBcfM9nWtgCJBpXQJL2e1INnWCW1euuMwYe7qP0kCQB4xL2JrjytVnzl6FKfea
 eMCTJwGtdI03QkuozRMhLWzqq5CejzCy5fFvBTqHpAFaj69wzDIKQIsWKUWIJ4Y5iMAP
 W+d4aLEpSOxROLs3vCUJypYyCS9DYURff1LpSAgtOro7+YOvUFQle8dKni0bmjwOL4Ch
 isq1sfEC5TwJhlQrd2KeY5Zj0KZC1RuLC8entqBlCxrxx1rJSeXG/YM6hAve9FXfaXNG
 c6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746485227; x=1747090027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXN9Uh5afi+KYKaDgb8LxSR0IO8QoZAQtPGstt/8ams=;
 b=oU7LTsXXdaJkgYN8xhY0Kg1HZsIp+BhPNLxme6hIinl8aRRHbyHCL9aVDaGtJxSTio
 dCfVfOweWUgc2d1yqrcpXVRruAGCKuPxk6TX/b2TDn40Dt+eoms+omk3HWwyIYdB5bag
 VDCF49ubQUz8lGBxOaynkgykocuNeDG6FEHzI9StgtLQjt4JCf7KpJw4z81Kj09wgwdb
 1m5k7dRZaxXO5F6ipr59YsAqn6yzBI9vxg69b6xwujfec2DF7o8vghxHWR8TP/KxCJSG
 T+wTX1eVFz6xSuJ7TwPO7QvT3BFR261Ra1OceyzLKfRu5jdktDIBksgq4C2qhBOxurcT
 MDDQ==
X-Gm-Message-State: AOJu0YxBP5vyQkn9Bi9nyBHk2rj/Zj8Sw1d/HBoeGkeAkBhkoYQuh/9k
 7hQDoH4YuiFMxU0e+3ShSQL8iueOiBdf0Z+X0DAKcQ0Ni6S4Qul0
X-Gm-Gg: ASbGncty2pVp1gXHuwZA0DG51yOwSeZM1PG64vz9UH4Js1WmV7yyLP0zmZU343/EH+w
 9+0fIfnsSW3FG3/VLiYC7Ycd/CFchzZTF5qUyn7Z9flwkYCDBvdWyh3iaZdwVYRf5XWrSweU+DA
 tg+5XDNyoG7Y6Pw6cNS+D0VLesnyZqdsncE24Sx0n61VUr7ewjR3Ca9CFI6C6afI70NtDy8nrUc
 DbvYDJLibsg7eUVPYR2cafdnFn0wGcJOkiW+8I4KFxhJc2O4Fg/RsHNQUqTyfHivVhy0gabX3OC
 yPMihBpfc8eSAOhN7d1tQPSEiiGzvX+OwBJqhzhdc6Xlnoq6VxvnYjn92pQjACKgL3bXW3Q1Ri5
 VOD7hAwUkeX16EU7PY+WUWQ==
X-Google-Smtp-Source: AGHT+IELr+eJD8G0lIi93gZc/78aiT742JkFTNd8vcuLGm4f0TmJH8RAVu7kDhqqdFEzB2BmPgpCnQ==
X-Received: by 2002:a05:6512:224b:b0:54d:6e19:ba9a with SMTP id
 2adb3069b0e04-54f9f872c79mr2066662e87.29.1746485226308; 
 Mon, 05 May 2025 15:47:06 -0700 (PDT)
Received: from [192.168.88.232] (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ea94bf1b3sm1835915e87.75.2025.05.05.15.47.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 15:47:04 -0700 (PDT)
Message-ID: <34050120-4370-4cbb-aeb2-c6956896cde6@gmail.com>
Date: Tue, 6 May 2025 01:47:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746474405-5056-2-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <1746474405-5056-2-git-send-email-andremue@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Andre,

On 05.05.2025 22:46, Andre Muezerie wrote:
> When compiling drivers on Windows, instances have been seen where a
> temporary directory fails to get cleaned up due to
> ERROR_SHARING_VIOLATION (32).
>
> Code inspection did not reveal problems with the DPDK code and scripts,
> and this issue was only seen on Windows. Adding a 1 second sleep before
> cleaning up the temporary directory seems to be effective, but to
> guarantee that this break does not happen anymore, flag
> "ignore_cleanup_errors" is set to "True".
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>   buildtools/gen-pmdinfo-cfile.py | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
> index 5fbd51658a..2ddbdb9502 100644
> --- a/buildtools/gen-pmdinfo-cfile.py
> +++ b/buildtools/gen-pmdinfo-cfile.py
> @@ -6,9 +6,10 @@
>   import subprocess
>   import sys
>   import tempfile
> +import time
>   
>   _, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> -with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
> +with tempfile.TemporaryDirectory(dir=tmp_root, ignore_cleanup_errors=True) as temp:
>       paths = []
>       for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
>                                  check=True).stdout.decode().splitlines():
> @@ -19,3 +20,10 @@
>                              check=True, cwd=temp)
>               paths.append(os.path.join(temp, name))
>       subprocess.run(pmdinfogen + paths + [output], check=True)
> +
> +    if os.name == "nt":
> +        # Instances have been seen on Windows where the temporary directory fails to get cleaned
> +        # up due to ERROR_SHARING_VIOLATION (32).
> +        # The sleep below is a mitigation for that issue, while ignore_cleanup_errors=True avoids
> +        # failures when the issue is hit despite the mitigation.
> +        time.sleep(1)

Not fond of this timing hack at all.
Meson 0.51 (minimum requirement is 0.57) introduced |@PRIVATE_DIR@ for 
custom_target() [1].
Can we use it to get rid of tempfile.TemporaryDirectory?

drivers/meson.build:
     custom_target(command: [pmdinfo, '@PRIVATE_DIR@', ...], ...)

buildtools/gen-pmdinfo-cfile.py:
     _, temp, ..., *pmdinfogen = sys.argv
     for name in subprocess.run([ar, "t", ...):
        ...
        subprocess.run([ar, "x", ...], cwd=temp)
        ...
|

|[1]: https://mesonbuild.com/Reference-manual_functions.html#custom_target
|

