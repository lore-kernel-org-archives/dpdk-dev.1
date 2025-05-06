Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A88EC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 22:31:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D7EF4025D;
	Wed,  7 May 2025 00:31:17 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51]) by mails.dpdk.org (Postfix) with ESMTP id 943FC4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 00:31:15 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5498d2a8b89so7627350e87.1
 for <dev@dpdk.org>; Tue, 06 May 2025 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746570675; x=1747175475; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1nqh3T8qkcJHCJHq4eO5lfvEF9yrtxBHOU6XcAMEcDg=;
 b=Tnu/NxB39nmfZLnyNDyRk9q4aNpKK48SiQ4h/hkMLsjLwBZU5/sgKncwMWvYkgoeJo
 DNEGoHAJX4I+x2g0sUXr0Eg4Mzq8oS0TNDDHw9aUxmN0zzqiMtphGhM3JJlav1WVzOuZ
 e9OUPgOuRMlFzXxa7Z/jOXukunOCWzWT/QnSZKZx/k2S1wJehCMz8mriITV378IPT9qm
 WV02toSjPjQ8TxAmkEKqbmRzNnVcItBb3JLth3bXR6C/Ugg2hT4qs9txPWPNQZqK4eEu
 lijr0bcCF6JRAIv8hFsZaeJJN68JOO8OOgmACZNfX1IJGaavooeuEpKJ9/xbZCJ2/65s
 xbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746570675; x=1747175475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1nqh3T8qkcJHCJHq4eO5lfvEF9yrtxBHOU6XcAMEcDg=;
 b=rSgrLr9LgpJ5bOMAWlIciCo67BO8LRfSZ9hl3YwFopfArHc5XFMobronrKvbgk2T4U
 8CEUeg5ApwYPgPV2JLoSnEUZyKSqRoPbeLPNE058j/4Y64Ep7/lKY7ETYQ3XJlsp5GrE
 ttGahHYgBUyCTZhfYry7m3UWNcawroMF0yuTsZiMn76ELUZMPIEQ5zs3Vhr2xGhb93VH
 rml8MX1iSuA0kvzm6OeQAiL/9aTWQKLYy5a/ImjFDv0QBecUvVWCSB+2bnA5dpsX4uPe
 b+Z8Q7CbRaGNyx9F75OJqj4QnLunaNQv8rvx1psowpheYIUSTQFQGocEjreVHk7Tt3MY
 PEqQ==
X-Gm-Message-State: AOJu0YyjLoQMJbPimL3OsNPJNVsqcv6rhUxlxS0CE74GSsN3nJphfN0Y
 unDwZyJ21yJh6qJ075kIGI1Hy3zFjlFO449h6bjEe6Yjt4/VaJ56
X-Gm-Gg: ASbGncu3JvirFu+Ox47x2MkwJd2WSmNBzbqX1TYZt0KJo29Uelq7QduhF6yM468b1Vg
 P2ysMwdqQ0CmtwRV2J9re/PBseek3AB+Ti4lpdzxdaiMzXWyZte33/hTQlOFNFOelpQRw4qESzU
 7k1VUbdQepdZhYIkWo9AIZMJ+XuQVJDKMPc+vCY6XFGZR8YxnymwbCmf/c9gW1+qQt5Zf5+554m
 Bs+l/Os5rErviY0cyESpZOQNbvNSoEHmlq5kXTdF9hvjt6r2xkhvW9A9YSrMqBWuFcWY8LKvFi2
 +G3WNG7zcQG6v4/42ZGPXQbKSmlwVw1olRYmMHnOMKFr+WM/ea0sCChgMEQU1Cs8SDKtsncwh3W
 GIJJgTLeqCFERjeG3uwtXmmbk7kDV5PAG
X-Google-Smtp-Source: AGHT+IHu6tZvYpIVlniV5WygO3vWXSq+iJBemgm/mIWwgrR1xNepzqIVhE2sNN76uuycb65CsUhkag==
X-Received: by 2002:a05:6512:131c:b0:542:28b4:23ad with SMTP id
 2adb3069b0e04-54fb95f706bmr421239e87.16.1746570674497; 
 Tue, 06 May 2025 15:31:14 -0700 (PDT)
Received: from [192.168.88.232] (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54ea94f69a1sm2140073e87.230.2025.05.06.15.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 15:31:13 -0700 (PDT)
Message-ID: <8d13b4fd-6dee-4845-8bb5-72a410b61af8@gmail.com>
Date: Wed, 7 May 2025 01:31:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746569662-11532-1-git-send-email-andremue@linux.microsoft.com>
 <1746569662-11532-2-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <1746569662-11532-2-git-send-email-andremue@linux.microsoft.com>
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

On 07.05.2025 01:14, Andre Muezerie wrote:
> When compiling drivers on Windows, instances have been seen where a
> temporary directory fails to get cleaned up due to
> ERROR_SHARING_VIOLATION (32).
>
> Code inspection did not reveal problems with the DPDK code and scripts,
> and this issue was only seen on Windows. Adding a 1 second sleep before
> cleaning up the temporary directory seems to be effective, but to
> guarantee that this break does not happen anymore, flag
> "ignore_cleanup_errors" is set to "True".

This paragraph needs an update.

> --- a/buildtools/gen-pmdinfo-cfile.py
> +++ b/buildtools/gen-pmdinfo-cfile.py
> @@ -5,17 +5,15 @@
>   import os
>   import subprocess
>   import sys
> -import tempfile
>   
> -_, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
> -with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
> -    paths = []
> -    for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
> -                               check=True).stdout.decode().splitlines():
> -        if os.path.exists(name):
> -            paths.append(name)
> -        else:
> -            subprocess.run([ar, "x", os.path.abspath(archive), name],
> -                           check=True, cwd=temp)
> -            paths.append(os.path.join(temp, name))
> -    subprocess.run(pmdinfogen + paths + [output], check=True)
> +_, tmp_root, ar, tmp_dir, archive, output, *pmdinfogen = sys.argv
No need for `tmp_root` anymore: it was required to put temporary files 
inside the build directory, but `@PRIVATE_DIR@` is already there.
