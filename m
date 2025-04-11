Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0B4C369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 20:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E946740B92;
	Fri, 11 Apr 2025 22:07:17 +0200 (CEST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by mails.dpdk.org (Postfix) with ESMTP id 626164025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 22:07:16 +0200 (CEST)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-30db3f3c907so23113761fa.1
 for <dev@dpdk.org>; Fri, 11 Apr 2025 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744402036; x=1745006836; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ebp6w72FlVEW049i/+KaxzHd7Y3F2c+TxEQLvChhhFU=;
 b=YowicIVkcNqHWWUpRlY5TOdNl/2sqFKnWk7Z8fP2ojrBHu8bpJaW49Ir71T2p2mZo0
 7D4HpSL18/nJ6/fdAF1LWaqfcezE2KUuc7mRAS5Rqp9GUwT0CtlxpfH8zjCDEi8p7NEA
 dSj1eQZ5cvocKszQI+YF9ufzUXBFsvza0nUan5IuVtAzeGxVaud3D9SeqAi4wJfewglm
 UrsPwbMZSKrrIKjrCxQp9/DdJr5rjFZaStzf02wiBe0/dK4ZW/BY+jIvVpWCbLgD0YnJ
 5vj03bG8ayAIvZLBlEnLz979nY1/UNYFFrleq386LygNCKfPtRHa92wOhA19YrFiabEf
 S7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744402036; x=1745006836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ebp6w72FlVEW049i/+KaxzHd7Y3F2c+TxEQLvChhhFU=;
 b=An9J5ATUDMinXYOoesgbPVupaYVz0MghL1cfzVwVsbo56KQiCW19L0ckykpAXlliff
 ZdeglDKnsrScYkSb2pVarBz8cUq4wyT419DqrGyhfTUygLCIeqzdS6qJW6b7yDeaxzp0
 doQLmmW/Va2pdOhCCvCl4/DconMuOOxk5fu1rSgAOvzMuN5Gyek0doCyhN+yiLy97K5M
 imnP08JpcKHo63cVfRq1Vkm9umBzICNi7D2paKieTj3KtXvl/06X9BRToZo01zLzZ/SF
 RVDx3/Nzxgc3s8pf2bEx1HF7+Gxwsqep1IElJRJ65sSHNE35/zaMsL9H7EG4AeP9N9QM
 0YoQ==
X-Gm-Message-State: AOJu0Yz0nZIJdv9ka8mhPkczZbrVm0Sa4uYg9h+iAzpuDMhTU17wGKG7
 A14k+joa7ylo0qqHeZb5VRNikoaJHHYMnyB7VeM2qJKXOTAVcLg8
X-Gm-Gg: ASbGncsx563cQ82+cvfGLWxAcWWSYO51m7fGRa/rHXmeq/gUgGl7PmurTGTWd1bsw1e
 h3/btUBeQT8pv2cCkIlvKxeMANYeXAOpsePMZqaB8F2OsHMOww55fck2YMwVbqOW8DhU4T2yiDu
 WdYZvbPJeNJ+VErJRlTSNkxy2MCXkbm0vHJv/XZND5UsR34444MYmFLLbJznQv/eWc12sV0GoLI
 a+suA6JgzXr05YLsjDQNDCnz7RPSuKWra6PYsDskasa6t1CbuaykbmRO2P4wN0f2B/L4mDODgZL
 x+/iTAu4dzPUo2bern+pztMA41TI+LCgOdiIIZArGcODjsnmyXNPMnhcduBfof6o+kQi1Xqam5H
 hLsY3zUbW7On1QnceZ10rBQ==
X-Google-Smtp-Source: AGHT+IGHermqFUire2K6rScRkz+K1A79vd1UEjmdtQe6Dh8zwxgAH3GTnRxNu1wwsrwgBKi3cBbkzA==
X-Received: by 2002:a05:651c:542:b0:30b:d44d:e76a with SMTP id
 38308e7fff4ca-31049a7ff06mr16002591fa.25.1744402035376; 
 Fri, 11 Apr 2025 13:07:15 -0700 (PDT)
Received: from [192.168.88.232] (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30f465f84e5sm8714201fa.105.2025.04.11.13.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 13:07:14 -0700 (PDT)
Message-ID: <981076cf-811e-401b-8b46-4a930b659737@gmail.com>
Date: Fri, 11 Apr 2025 23:07:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] buildtools: use macro to embed information in binaries
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744400374-26620-3-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <1744400374-26620-3-git-send-email-andremue@linux.microsoft.com>
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

On 11.04.2025 22:39, Andre Muezerie wrote:
> buildtools/meson.build was updated to require Python module "pefile" on
> Windows. This module is used to parse symbols on Windows images. Windows
> images are in PE format (opposed to ELF on Linux).

It is not used on build stage and thus is not needed.
There is no documentation on `dpdk-pmdinfo` requirements
in `doc/guides/tools/pmdinfo.rst` or `guides/linux_gsg/sys_reqs.rst`,
so you can either just drop this part or document requirements in patch 3/4.

> diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
> index 5fbd51658a..9b4c2c48f8 100644
> --- a/buildtools/gen-pmdinfo-cfile.py
> +++ b/buildtools/gen-pmdinfo-cfile.py
> @@ -10,7 +10,11 @@
>   _, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
>   with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
>       paths = []
> -    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
> +    if ar == 'lib':
> +        ar_options = ['/LIST', '/NOLOGO']
> +    else:
> +        ar_options = ['t']
> +    for name in subprocess.run([ar] + ar_options + [archive], stdout=subprocess.PIPE,
>                                  check=True).stdout.decode().splitlines():

Nit: I suggest renaming 'ar' to 'archiver' to avoid confusion with 
specifically 'ar'.
Previously this variable could only refer to 'ar' flavors.

