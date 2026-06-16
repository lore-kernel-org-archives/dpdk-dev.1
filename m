Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16347CD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 14:07:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CEED40289;
	Tue, 16 Jun 2026 16:07:45 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id CFDB240289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 16:07:43 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1384eb94d20so8546309c88.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781618863;
 x=1782223663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zicpUuLc97+7rMG/+chu5RC4dppetltExl+H42q2OvU=;
 b=wMvlf5tSuYKfR5aoWyg+LBlztSb/cx1q2yxWsEWHyUlWnmJHWb/dkgYj1gZ6cT0pjW
 9jnyxa+MgO7HHqD1ljgI9m2pEi9EaehDhSob8sKOEghjpy0yCqBloQSkIIzAIo33cL7a
 4WcnLnAzQbmHcx+O3K0RAgepYWpblXU3FfBhXIZdtGsYAX+gsEnbuVCaKnNxfL0TDrBH
 GqbuBmK3NHKrSJ0TYvOYn5a6QOhYknVTJP8ipA7f3gsUS7I8ZyLG0etT3yvKl6Y2gEzC
 7nuoQfkUwUtJcHyYXOH/RKbeqF16znMvOh5ctw7CcjbebPNsQG/eOjTKRY/iS4Ok86NA
 mnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618863; x=1782223663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zicpUuLc97+7rMG/+chu5RC4dppetltExl+H42q2OvU=;
 b=flTDfCrPURlKV97ZG1aGEnMAfkmYjMLYdXgqNMPqpnAbynywAbuFk+syggHxfp7XgV
 KZv6BceNtBKHF/2+XjdztrxDUtKUKA+Vp3zWv+oXHSrlfSSI4pOd12PMyEWZl00Odh5W
 ruQsxUTWEtGKeL2vGmT1zhVvM7JYw6xAE0aZ9HT0zNvpfHPXrtPwVNLX3gWEHom0JLhf
 1k/J2dtMh9w06j3kufywjtfSeXzMlSr1sYLbIa/GlHShvvoAf3K9yCqbx4ghlPai0+Zv
 ngVAWLVQfoLFtYt+zBUelbkjT2+GW4gL5uQCxPn2fq/bHqIZpcXhhnrzbkjZnfakv1d1
 KHTQ==
X-Gm-Message-State: AOJu0Yy7wSq29I6HjtKRq+DGj3r2TtN3Fsrm9qOLklQh6XnDUUb7edAG
 ybC3kuaoyT4Q1ESnRSNyohwQvVTbBPxRtzaP+t2F+ePVtiFdzjybezgsjIynYdlhkp8=
X-Gm-Gg: Acq92OGZtJh+ubmuV1WuRshrwIQfqy8M012jrlX/ibkinEDP5tba1fN2XPMj6G52e4r
 2c2QCuXxMVwtLP/c9xprofbkmUIQuv6m3ieNiH7tdK7hjLTRALdpb90PVIHNd+3QozHJtxvR1f7
 hLhJULJtLpvXwtcdAy115sMhxT+U47F+2O9aaiU7GQbOspJ2vS81EKgbeyfdwnyTrOP4PmtZbe6
 cILpn9ovUWaJzVzbqpIeShdil+IchiZwa3YCjOSv+0TFyh6YL8+xTwxwJjrbdSGMV/09nocrvF/
 vFU+TrIx7AUuOTSlRdFrsT4FDNZKg6l0JlOgvUQOMtk94eTpBz88VMjlgAvxSacZ7GXbXUfNps7
 8lYTNmPXCZirg9H15lhnbYeHu/vpchlhbEQ1JdHlHU+P8WEujbsrehUKSf5MchhhAO7fKN6NZ48
 JwL8yoCaiX0IgruPy/AXTx/kcZeJ/vgLUi1v4g/izJE+O3LTho/v0cmxZbNXWqNb7t8c6uCOiLB
 2I=
X-Received: by 2002:a05:7022:68a4:b0:138:14dd:16c6 with SMTP id
 a92af1059eb24-1386f3a02a0mr7860311c88.34.1781618862229; 
 Tue, 16 Jun 2026 07:07:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b91a4c7sm13458705c88.8.2026.06.16.07.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:07:41 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:07:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Sunil Kumar Kori
 <skori@marvell.com>, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>
Subject: Re: [PATCH 2/2] ethdev: return 0 from dummy queue count
Message-ID: <20260616070738.10dab11b@phoenix.local>
In-Reply-To: <20260616094259.686555-3-maxime@leroys.fr>
References: <20260616094259.686555-1-maxime@leroys.fr>
 <20260616094259.686555-3-maxime@leroys.fr>
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

On Tue, 16 Jun 2026 11:42:58 +0200
Maxime Leroy <maxime@leroys.fr> wrote:

> The dummy rx_queue_count/tx_queue_count callback returned -ENOTSUP. On a
> port that is not started (freshly allocated, or stopped once the fast-path
> ops are reset to dummies) there are no packets queued, so the truthful
> answer is 0, not an error: querying the count is not an unsupported
> operation. This also matches the dummy Rx/Tx burst, which reports 0
> packets.
> 
> A poll-mode worker checking rte_eth_rx_queue_count() across a concurrent
> port stop then sees an empty queue instead of a negative error.
> 
> Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> Cc: stable@dpdk.org
> 
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
