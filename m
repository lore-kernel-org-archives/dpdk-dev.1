Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF7C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 21:34:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C6D40674;
	Tue, 29 Jul 2025 23:34:28 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 7EEEB4060F
 for <dev@dpdk.org>; Tue, 29 Jul 2025 23:34:26 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so1596575e9.1
 for <dev@dpdk.org>; Tue, 29 Jul 2025 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753824866;
 x=1754429666; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LLzo9UXSUvyQAPL4qtR97U/Lx+nnnsAv7IpYn8nnA3k=;
 b=r9cWOCEke6W0oSZ04+1V07cd1kMjP4nPY1jEY6TTQ9UmaF8dSywD18dMOkVyyWEkNb
 Gs2xvQ11VrIQK+Rvd/J7lEOcx5kmkQeNRZwmH1YJJ6qxOVeqHcxAH8+Q6dJmcHfblDQm
 GDTVjb9MtpaovsM+zHHnsCmPDIiobp50EdgA35yAS26A4OcKSuR8nS10RaUQyQPluB4v
 cU5L2mhuzpQ417BvXWco3eGqO4oxhTyC12VFdbm38B6/kGgGUE6hBsmq5tFtYruvxvqY
 tIibo1GSd1vULJobLRlLsSCT75oBtswo0uf2hb/dyS/5Sp3RnmkOeGhEACvmUx66WZuL
 y0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753824866; x=1754429666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLzo9UXSUvyQAPL4qtR97U/Lx+nnnsAv7IpYn8nnA3k=;
 b=FQ8ibCXUmA1H8n++tj4/I6w4FWzckqhqkzY1WgFDw2nyM9Y2Vk3DDnEzkjM2HYjJ1M
 7fmu5aSA1dSfcbf4ajdqsxuJcMWX6YdsuyXnhcuAee77hqN7M7dkAGGEEQMiNzJ8ir+5
 JPZ/uE8YP1RtLJyhzePDoajEyBHOzUU36GIHvLwnAWM03YtORPK6Dp6wdtClcRZFouUW
 Pt14hZcSwuJocb8SsX3mtf/kIyg3ETjYVL9GrvCATQxRazX//1H28m7t++/z0VfoRHFp
 UZH3ob+T7M7eQCqZPM0PhF3ujRv6ncsXh087DVsO6YV9uf6/t4IBzBciNVABwXKKC9nD
 VELg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzvzBMbsGgDUUk5cShbfJirHcVoE+IBQaN0QpAWbEf57qkBGyu3FnOq3O7Xd8gWZGKOX4=@dpdk.org
X-Gm-Message-State: AOJu0YyOLTjZt96L+CsEP98eleTxo58ROlwe5uOUp/6CDjnaFbrJ0OpN
 s4R6CLz5APh0/OIgdQdFbwFVU/e5ACmp6iSahfMI95pQYpVYyZl04a5IwYZHw2vrxFE=
X-Gm-Gg: ASbGnctlDYAhDH0E88QI+oNWmgrmlr3ca0Kz2hEeT8vVoywu8IqVhOTs9pS8/LqMfq1
 CkD/Dlq4/0FGW+E8vBsSnX5WiVLC3QSLMEJYAguy5TuqfXTsrnW2C3pgGvD3CzCadS6hlu0fWD3
 j6IIluVQImYJW5A02xOWF1n4jaUoUk+bfLbhHWpG/sn/ZrzvLLqzSdFJrw5svzZL5SXgHe0kunx
 mHXwswYaRjo934KtBiN5FXS4qGh8cOPhjfaeq9CHyZ1hN5XYxET1XrTxRApPW2qxdjf8NXuKjZ2
 HkzEOMkgy3a2XxX7peWMTpubWSr6iqctOl4StjuWchwkxr7IGUTGjQhDfJ4vjPjZ32NdB0Iz/SH
 7OmQRAF44JqmUWQljgnn88y58H1S6pN9DniIKoIc7vshdiENLzvaF4LpvLPBelfvcpFMeiDt9vS
 8=
X-Google-Smtp-Source: AGHT+IFM6SSlXZtebJ9rsHhi1dlgov2HPPmNTlr/DLdplV9cQHek6R2aCqtj0IJH5DzHsvF5DJtJVw==
X-Received: by 2002:a05:600c:3b23:b0:456:117b:94bc with SMTP id
 5b1f17b1804b1-45892bc58aemr12259935e9.17.1753824865727; 
 Tue, 29 Jul 2025 14:34:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78084f79csm11957058f8f.71.2025.07.29.14.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 14:34:24 -0700 (PDT)
Date: Tue, 29 Jul 2025 14:34:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] [PATCH v4] lib/ethdev: fix segfault in secondary
 process by validating dev_private pointer
Message-ID: <20250729143420.0fd7b627@hermes.local>
In-Reply-To: <20250729054229.3537412-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250728144552.361c17e4@hermes.local>
 <20250729054229.3537412-1-14pwcse1224@uetpeshawar.edu.pk>
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

On Tue, 29 Jul 2025 01:42:29 -0400
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> Hi Stephen,
> 
> Many Thanks for the feedback.
> I have addressed all the comments on the patch, I have removed the unnecessary check in ethdev, the only one check in rte_ethdev seems to be a neccessary one, as without it, it can still generate segfault while secondary exists after primary.
> 
> Best regards,
> Khadem

Did a bunch more testing, and the problem is much deeper than your initial observation.

If primary process exits, the data structures all over secondary process are complete
garbage. Lots of use after free, linked lists that point to freed data ...

The root cause is that when secondary process starts, it requests current device
state (buses, devices, etc) from primary. When primary process exits it removes
all devices; but there is no mechanism to tell secondary!

For now, the only thing I can think of is to have the secondary process monitor
in testpmd do an immediate exit, no cleanups.
