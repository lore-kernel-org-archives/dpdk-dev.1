Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5761FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 22:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E5D94065A;
	Mon,  9 Jun 2025 00:48:55 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 9DFE64026B
 for <dev@dpdk.org>; Mon,  9 Jun 2025 00:48:53 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4a58e0b26c4so62834951cf.3
 for <dev@dpdk.org>; Sun, 08 Jun 2025 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749422933;
 x=1750027733; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb5mfcizw6h4vH7XeU2Wxq6hoT4/inIZEHPriXG7T/s=;
 b=jylyQDhBXRGz7ROTm8IU9vbHyXoRy5BdF48ZF2zFrmm6cW5D3rBWRzje9M+wClMteQ
 E0VnpyPpkE5S+vcHKVyuJ7dTdz0AnQQWZ5TiugC6k2UJqXjCH6CaUD0eX4j2qSMX75zD
 F0Y1bSgVP0BziTf72VGvNJY89S/x1XLLf3d2TneLLNGfBK3Jy7nYRONKcKcEqD01tF74
 XZ4ESBD56DsLyelXWsAES1ta7Os9NEP09OJ7b7yAjwuGrC/cpVOCbISq715ELnyZS6kH
 aWEDGiYawZYiiXO+s1ih6t1YuUYVOgeYEcc1DMhW0R88KsfoAII0Z2HoFCjZm2ciQYBY
 sNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749422933; x=1750027733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb5mfcizw6h4vH7XeU2Wxq6hoT4/inIZEHPriXG7T/s=;
 b=C6Lz9tuXGsoqEwBn+qAmJM1jLhtTogmzWLGhkERZJxYHQipIAmYbCludgw6NrDTiVE
 pG7SDmlASyZDUdT7YQHnwH/5LBc38lLfBmBiDt654BrqPJ+ftMj+dfex/QcjGuFAUmzC
 JBISMh5D1fJjbo0j06Xbbho+cAVVK/gWmcM5TqI79ydeBApP+6fG3jHj68ZDjkXStXvw
 /nz9RKQ9BcM2gULpcB36nr2GPMMiSPvHVxZo8C/5UUZtLnVeSvFBZmd9CWs2hDdTQKZK
 611bpa/tp5Z3wb/4cAAHkUwnYQyYdGkuuzR2uoFSNQLSqJoMOvfbv9umpM1MoerLiycg
 hjdA==
X-Gm-Message-State: AOJu0Yzk53/DrAMDvY4QhK1WApE8RbF9Ci+g0AmKi6i8eSTCNlteeBBP
 cn5epDGmq8RXaWugK42kbKHSCC5Yr/C0LddYJjUl6arQAr1eVvZ7HY23XODmMzyLyeY=
X-Gm-Gg: ASbGncsd+OIP8HltI+yidOcE65hXWGTaMxUwlLsGpc1EFituWi5bQSu+ui3KiU7+9tN
 PlvvX76hW7qYBd+DfhLEJf6GjvyZNQO/RedQNdfrxeiyPLm0K0lVDM5enasvW9ZmR1ZUOaVziZK
 chv+eIWTe/T5VKRpAJoRf2xaH1Lz1/lBMyCVQ2xswti1CzIzSvK/y5VC11x8rJElQKmUgJ/dCUL
 CiCqA9eKu1UF6JVj0KjSH5KtsWdKjQxYQhv/7X8I+wMOG5RchB4d+0o7HC+uwsVL1Nr9XM9BBGv
 sl4qaTBpO2GuZrGtSsaoNfwFPfOS5X1KN5UE4aekBtIgkwUQvtQQL27tbTR+voodc2qs7sFrjzJ
 DFS5W2V1X2zUWhtyzO8+hRvrsigqg5V3KGY+8MSs=
X-Google-Smtp-Source: AGHT+IF0TPHMISw5NLFchzY6Ndw+k4Xp9Ti1efRmDyXqhR9DYrhAZITpWyah0iL12hB6PC3BaIPxyg==
X-Received: by 2002:a05:622a:114d:b0:4a2:719b:1238 with SMTP id
 d75a77b69052e-4a5b9a268f6mr200056131cf.12.1749422932919; 
 Sun, 08 Jun 2025 15:48:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61116bd39sm48207031cf.30.2025.06.08.15.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 15:48:52 -0700 (PDT)
Date: Sun, 8 Jun 2025 15:19:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Schneide <schneide@qti.qualcomm.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Reshma Pattan
 <reshma.pattan@intel.com>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the
 interface block
Message-ID: <20250608151909.0a8a01d2@hermes.local>
In-Reply-To: <20250606215208.389096-1-schneide@qti.qualcomm.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <20250606215208.389096-1-schneide@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri,  6 Jun 2025 15:52:08 -0600
Schneide <schneide@qti.qualcomm.com> wrote:

> diff --git a/lib/pcapng/rte_pcapng.h b/lib/pcapng/rte_pcapng.h
> index 48f2b57564..9880d415c4 100644
> --- a/lib/pcapng/rte_pcapng.h
> +++ b/lib/pcapng/rte_pcapng.h
> @@ -71,6 +71,8 @@ rte_pcapng_close(rte_pcapng_t *self);
>   *  The handle to the packet capture file
>   * @param port
>   *  The Ethernet port to report stats on.
> + * @param link_type
> + *=C2=A0=C2=A0 The link type (e.g., DLT_EN10MB)

Emacs shows use of tab in the doc book comment, which is wrong.
