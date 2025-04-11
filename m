Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC7CC369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 20:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BFD040DD1;
	Fri, 11 Apr 2025 22:09:50 +0200 (CEST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53]) by mails.dpdk.org (Postfix) with ESMTP id 36E9E4025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 22:09:49 +0200 (CEST)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-549b116321aso2804036e87.3
 for <dev@dpdk.org>; Fri, 11 Apr 2025 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744402188; x=1745006988; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j/HP47G2ZKaiGQW4WXA7XBibNV/fikcN9OIbDCZEPzI=;
 b=USo27WQoR4+z5Y4DZsznC1RR/SyDkwHBOHm+eeScur8/EjU5NptMOIqwunNNFV/N1D
 zQXw3phjwmMYzuDNxYozcRy86wcBJg6V8xqXV3OaJuEVnUNDWszxoaShbUQG6hC9JYOb
 J8SmbUuF3mu9zNPiXNc9bXZ7WBQx1ObT3havBhcOY8zYwWDh7/Eufr3DT6fRwcydaoEg
 0q6+ggBBB6x8+S/BF9mpIESzfSgRynTwHs0q8TquPLHbQOfAlaDB89DeAMAfosZ/VkTO
 TCPExkeIUTvbK3qPiAE5Ex6ZyyX14zZCkCaQDmde9h3yHjIkurIGG8qUR+JThRK1dLbq
 eSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744402188; x=1745006988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j/HP47G2ZKaiGQW4WXA7XBibNV/fikcN9OIbDCZEPzI=;
 b=prxIegJRoxp1UQsw02I/4K3r9pv8XlLeSSs6qSuudr7465B7Ff1NQFPuiveXc5xM6B
 mEbXVEs+5u/CvXmA0VUL7zaffxswmE4I6KDGRapUY54huB8XVrZlRZJ+tgBLD2iSkTin
 j8xRt17bgkI0AupmE73vumeouB9PGmtw3OwrkgAaLoxVf2QXUEXlYCcnGjEdRTxRqbLY
 NJ++I1eIKj+ds5iJL1P0v1+3NLAxA85Xgb6/LMKIBntID7CAczF1dbikEQqDJMTppWP8
 izU9L5fp6IxA7X8jPfPfJd6jq2ZWPyq2gRMF0ftUtaXVaC9udgoLDg9H82GKT+Rbcmch
 dCyQ==
X-Gm-Message-State: AOJu0Yz0ue0BPBeGLOrWLX71xwi3V3VoLouMUGyTr6fPHv7QEE2KeH3H
 8qAD4TbW12JBGBgfSDRwKJFgXxHSzeNLHIzsPlzcWoE7CHWzBbGx
X-Gm-Gg: ASbGncvwN4v4fJ+OioUjgY9iNfSFTNGzC9X426UjsSWYWO36bbUJ9bpZZcPA3/FzPVq
 sbPZXPFcfWoCOiRGA+OQtsN8jtZXPNInnTPWHgpwBUkzdQ62zvDzVRb8hz2t1+NmpDKeP0gUtul
 YKMUFj8lsZl5AYuKrPbXGUhVzzZiezuEMObOOe5lcMn6mumLsIAql9ybhUsj+lUMJb3/9UWVbLu
 N3WcFjLhuddW/pzj6SNTgKAdYnGtRIzb7ocB/r0w86q2FNnnaeauglQnJNuYEN6qiYnt/GNC2gA
 48TgTUbxxhTkdrFVO7Qdothko65uoF7BUZE4RShvYD4D4rMHJMIOq0iFi+WzWSZ+GrnxY2SrbaN
 JrP3fBXuc67BcLCFpGpazaA==
X-Google-Smtp-Source: AGHT+IGxvq4hrar87fgFu51J6NAXCJZGcpxzMThHyWKgZvhZzPV0i64ixpgkB1SzFAEbpFLYkFm7uw==
X-Received: by 2002:a05:6512:3da5:b0:549:39ca:13fc with SMTP id
 2adb3069b0e04-54d452d53f9mr1333303e87.49.1744402188430; 
 Fri, 11 Apr 2025 13:09:48 -0700 (PDT)
Received: from [192.168.88.232] (broadband-109-173-43-194.ip.moscow.rt.ru.
 [109.173.43.194]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d3d256ab8sm502914e87.105.2025.04.11.13.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 13:09:47 -0700 (PDT)
Message-ID: <9604c53f-38b1-4f9c-9844-ec3228c02315@gmail.com>
Date: Fri, 11 Apr 2025 23:09:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] usertools: parse strings from PE images
To: Andre Muezerie <andremue@linux.microsoft.com>,
 Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744400374-26620-4-git-send-email-andremue@linux.microsoft.com>
Content-Language: en-US
From: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
In-Reply-To: <1744400374-26620-4-git-send-email-andremue@linux.microsoft.com>
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
> diff --git a/usertools/dpdk-pmdinfo.py b/usertools/dpdk-pmdinfo.py
> index 9189a2fdbc..77789c979c 100755
> --- a/usertools/dpdk-pmdinfo.py
> +++ b/usertools/dpdk-pmdinfo.py
> @@ -40,6 +40,12 @@
>   import elftools
>   from elftools.elf.elffile import ELFError, ELFFile
If `elftools` is not needed on Windows it should not be imported,
otherwise we'd have a bogus system requirement.
