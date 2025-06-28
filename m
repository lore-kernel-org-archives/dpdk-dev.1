Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D767C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Jun 2025 15:04:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F10340277;
	Sat, 28 Jun 2025 17:04:36 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id D0D5340144
 for <dev@dpdk.org>; Sat, 28 Jun 2025 17:04:34 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4a58e0b26c4so13706551cf.3
 for <dev@dpdk.org>; Sat, 28 Jun 2025 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751123074;
 x=1751727874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVYOmRuySdjsc/7lwiSA//w6uWzc5XX0biROjw0kgqs=;
 b=YKsHRqmK9QkquZNdl7YTwZDgXGwJqDBt+w4bxJHVUyEAMHWPK0DsJ8FDOu2kKvXn0w
 j1X41qGnADk5tqeH0lT3CJEd6lxfuIh53NzrZ8hp7J8JlWAZj3Ch/2q3cxWHm0ZNplfZ
 sBOpdM7yQA14Jt+WFqPMm5X7u5YYZGq0R8Sx6bwjTLqJySi1F1gptuxgzLSsMqh0B+Hn
 tvqU3acYtgTXOY7v++VtTtrQOnTjV1JWuMr6RCC/1mt54UW3So7LuKkYZxClgZBlZWXF
 PVFvah9daEqhwslBPhGbbo4EaefmaMn7mdm6criwp5eHdlJYRc/K1nRMPqZ+CLj+ZomH
 eIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751123074; x=1751727874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVYOmRuySdjsc/7lwiSA//w6uWzc5XX0biROjw0kgqs=;
 b=cxg/9wyZILmnaGyUS/o/oRsMtv4QwbKWQKSJYOx24jqY47WWInOcIk5SqF5RVpl/Cp
 y0R0afLDo+4/OY5KIhU8KkwJrSMbasEYSFMEb5EqbTw1LubyQzNjtNaoCvUFeZqoR3yJ
 P5ttF4QV6rwaJI7UXMYVZS74ag6mCKpR5vwhO+y5BIICpqLpe5RIphdTO4HOae/pva5T
 /S2kwUseEoE5ZN3iEjQcqLZFelAHyPD7FiArlPa4p+Cw+eM3kFM+MKnd3J1PW1GL1Eys
 xCm6b29VjZ8RRJQSuqT3hwd/PyEW9bJyK+jU9DtVUAIq2OL1mgF3QQy1S7ZH7UKWyx8N
 sVgg==
X-Gm-Message-State: AOJu0YwW/+PezphogPuZ/qY07gCmj3Yee1bd6F87lEfvBralUg0F5IJi
 SrX6eLCnRa3uJye3fwGtvrFfnlcqLSVMPPIut9NeCO4ZWX2p2hqrq2mVK2+fbigvDFc=
X-Gm-Gg: ASbGncuknrKcgQfTt/vVsHwrfqfADvfyA6/R+cQJwLLqjxZqhE7wF4a8fee2huwUug3
 BxIyKkOxXJ3CSN3DdmV0Q+8GCnni3a3lTwt8FyrgZ2URpvcd49aNXfTS479oKXW/mgXSbVLCi/c
 2acHsZ955BqNeVenof2qD04dEqcnzIWUtjvbutZzwUI8ykJTuz3Oqlt8tkYYuJynOfoFivUH0rU
 CxQuueUh08laHcdyQ6FtGq5HmA/mVyfk3PRaWhH411vNcuee/FH1wCzNQX8Drhjiig9koO81G8A
 mVmT7m+fbysNQCgApl9P2afIh43NcE/YYs4yDUcudlU+RgfHAm6LcjEzcVAYYv8SZ+ibBqkylfo
 HYU370vY9UZdOag7Wuog77nqSaQP9AjYW07grZAFD7F7IIzh8oQ==
X-Google-Smtp-Source: AGHT+IElymBLZ8LNA2bG5RhFaKAm38OtRbU2sD5jtTY6GhNu3Rqcuh7zxSurGYRyiapWJq3/I5kNNw==
X-Received: by 2002:a05:622a:513:b0:4a7:bf5c:42d9 with SMTP id
 d75a77b69052e-4a7fc9f410amr133377241cf.16.1751123074008; 
 Sat, 28 Jun 2025 08:04:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc55c62bsm30162061cf.46.2025.06.28.08.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Jun 2025 08:04:33 -0700 (PDT)
Date: Sat, 28 Jun 2025 08:04:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, gongfan1@huawei.com, Yi Chen <chenyi221@huawei.com>, Xin
 Wang <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [V3 18/18] drivers/net: add hinic3 PMD build and doc files
Message-ID: <20250628080431.3e52eb1f@hermes.local>
In-Reply-To: <20250628072552.1311-19-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250628072552.1311-1-wff_light@vip.163.com>
 <20250628072552.1311-19-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 28 Jun 2025 15:25:41 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

>  # The driver runs only on arch64 machine, remove 32bit warnings
>  if not dpdk_conf.get('RTE_ARCH_64')
>      extra_flags += [
> -        '-Wno-int-to-pointer-cast',
> -        '-Wno-pointer-to-int-cast',
> +            '-Wno-int-to-pointer-cast',
> +            '-Wno-pointer-to-int-cast',
>      ]
>  endif

Indentation was ok before. Don't need this.
No need to send new version about it though.
