Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1929C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 20:41:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F44F4021E;
	Mon, 14 Jul 2025 22:41:06 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id E7AE64013F
 for <dev@dpdk.org>; Mon, 14 Jul 2025 22:41:04 +0200 (CEST)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7d3f192a64eso469036285a.2
 for <dev@dpdk.org>; Mon, 14 Jul 2025 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752525664;
 x=1753130464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvHw61IBgMiSymwkNe8Rfj1DyCT5FlxNcGOYNdu7BWo=;
 b=PgJYVL70WlocHsm2KH7cQRCW9FrIkmnql2TYf3BKqiHtdx89+wJTWio7u+gUFu6buJ
 pSJ04QWFIOx0y4rTbG9AvkxpEMe+B1udMOllPCjhdpwfTT5VvO6itRAPKGRsLmXgALKS
 3iUKQ4WgS+NpsN2IQVlMWm1tpkBv6vMWy7zdD3i4x4vaEzgxsYGOS2Ssoh72W3oTWSq3
 TwP5h3+nmWk/D8uPxw9cOXCxxt9D6vNXn5GGs1rSYkA5tAHwlgSKCc4R2AHMLhh6wBR/
 uGE8Ve4jJfWsn6OwMpG3tPwiGjxMT3WvkHh3DyveouGo9mHKXtYEDEXzR1so+lEDoo3D
 rdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752525664; x=1753130464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvHw61IBgMiSymwkNe8Rfj1DyCT5FlxNcGOYNdu7BWo=;
 b=EVxYwQENIfysGFFXPJOzUHlFmJAiznEuNu3AKZ5DXskonPo/Oh2VQE8DZK5+P+/o3w
 t4CwTXwa7yQi53IaXmt1S+5ekJIqaVdhDxozoxxhEDpenbmirwHkIEbwz39KTA5Fqukx
 sFWNyABtdx6DIo7oVzjaljlfgLIlc0eOpGMc0nk2yqRjXNtZhoX4VtIaII5f2Sf9cax6
 ZC/kFphJ1VfquPC5naPuSLsutcBWPdBLkEijRZtQZ+PNUl6GB0GuEw5UqjukBkqaA5Nc
 lpcv5pZsb3TOV41TFxUcOVe9gggusYOkZJ9+99GuilY4aAvz5Q0Q+UPUf2KPuzTyeCAe
 Mfow==
X-Gm-Message-State: AOJu0YyjceFBzQnHnk6mV42dO15W2KvgPfKLrZt2E83f5N2t0fKfmvUb
 6eiB1xCiEapwRa4Ya8tXpQWhLDuwntp2FsPlAk4As6TBAICEiCCmmtn0yTkKMzUECM0=
X-Gm-Gg: ASbGncuPLFTdrBDXMWFqU9ivWFMWoes6jrCrLQefXkL4yBJX9vzsaL3fqmc6Ry1GWRY
 ntY3fpyaJCNV4ozUbcjj9+aBAqs6sjfygPZSmHZ6w9I/QZWfqySAY0A9iBX0nwVza1s1vngPVNc
 1/XBa50XVewLYQxwkF3TtNZ1QmnPd1r/+XEa9r/Wh6Jwkm3m7LDU4yKWBm2qM0UouGfqCxKrSVb
 0wVk2uz9gWSuOwzO5YMJyxoA9C+tplf3jsuvXt39pzmOtf8wNIZSoo1AdzjsEaglYaZk2a45/Ri
 4etIk6Lwzsv8fxAH0fJWa6mdKhrOlQTm2k8PggfMZPWsVkOQNzSsIyGGrQTUxXeoNgjFGh2XMwg
 4FGFa5E9z4YolWmfSk5VOhYh//QQTWPqCVMBQlFkXs5UV+hdye2KXQjiVlxkCXFYRyPAwyQs76d
 Q=
X-Google-Smtp-Source: AGHT+IGzZj8XX15LAKVjxWCPNk8nHjt7JtCkvypr1As3heMjaWLXuK3yZPB0FRKRYV4w9vnabaVFKA==
X-Received: by 2002:a05:620a:d48:b0:7e0:6aa7:386 with SMTP id
 af79cd13be357-7e06ab649b8mr1178685885a.19.1752525663944; 
 Mon, 14 Jul 2025 13:41:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7dcde32bfefsm550491385a.53.2025.07.14.13.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 13:41:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 13:41:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pravin Pathak <pravin.pathak@intel.com>
Cc: dev@dpdk.org, jerinj@marvell.com, bruce.richardson@intel.com
Subject: Re: [PATCH v1] mailmap: add new email to DPDK
Message-ID: <20250714134100.7c1cdef3@hermes.local>
In-Reply-To: <20250714191141.1243467-1-pravin.pathak@intel.com>
References: <20250714191141.1243467-1-pravin.pathak@intel.com>
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

On Mon, 14 Jul 2025 14:11:41 -0500
Pravin Pathak <pravin.pathak@intel.com> wrote:

> Adding new mail for DPDK contribution
> 
> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index c7d55c7386..c81e745ce7 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1240,6 +1240,7 @@ Prateek Agarwal <prateekag@cse.iitb.ac.in>
>  Prathisna Padmasanan <prathisna.padmasanan@intel.com>
>  Praveen Kaligineedi <pkaligineedi@google.com>
>  Praveen Shetty <praveen.shetty@intel.com>
> +Pravin Pathak <pravin.pathak.dev@gmail.com>
>  Pravin Pathak <pravin.pathak@intel.com>
>  Prince Takkar <ptakkar@marvell.com>
>  Priyalee Kushwaha <priyalee.kushwaha@intel.com>

No, that is not how this file works.
Add additional email to existing entry, not a new line.
