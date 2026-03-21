Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2906108B8FF
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 02:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E15D4402AC;
	Sat, 21 Mar 2026 03:58:30 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 01F434026A
 for <dev@dpdk.org>; Sat, 21 Mar 2026 03:58:29 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2c10a2e2cd1so3300042eec.0
 for <dev@dpdk.org>; Fri, 20 Mar 2026 19:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774061909;
 x=1774666709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tLQOI6+UOJ1NNt1zauh7AXmOnrvb5yJSGS18RveN9o=;
 b=Skm60C5IVuBYF+7/HiChTh0lTg074pA3URYRjbmG1NPNPky9Te9VQUcsKsPo6bKclz
 4LBpB8qLqCYeJpwqFYyfdCOcLZqHwlTgP6OmKe+nxdxg8r4lPJ2EGf6peffdLIoVON2Q
 zYGc6VwhGpkNiy4Nupw6zaEyK0LNwafqjcJ2qYg667xoY6r705ADBUiEN68WwZOoMmEa
 x7w0t/NM9Z2MN4pZ8pCcuuRJN4DsGPJo7LVlrof+mfSxwOQab0ZGJkbEktGbYnAM2gQA
 ijTa/4h4iiNc3uSKuzy8HnhGpGt0oj9wfIbDIho+VVJULiHPLF5yX3QloDPSYqknQtDB
 Qy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774061909; x=1774666709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8tLQOI6+UOJ1NNt1zauh7AXmOnrvb5yJSGS18RveN9o=;
 b=HFoicA9MFkJni0ZqJm0shSk9EIanm8UEmV4EZOMQfJ7/YPwNUryvuc6t0kA8hSKlS2
 12c56NWUz60rQQyQmLL20SIsgbnnA/Hu3mteCy8Xsa/mG6Ck0tB9vSrVj8X0l5hpN/UF
 4ZB4JJ/hbCmrvxky+YE4cSZQ2XExZ4Whr6qcSIuK53IybJ9veA0vTRzqEFji72K/5goF
 l1BnSF8QwFk2h3K2GXXOzPr9AgC231LR5Mjg1jBcSrUpJB0KC1/eEoRgzi8d+P3gZ78i
 7KNSJhMhs8s9IG+yP1B9dN3dZ4pa9B767xEfnBNoi0SgKv/FG49btt4cj3L2wckXnFTH
 tFbQ==
X-Gm-Message-State: AOJu0YysRTLZN/zsyuHS+Eroyr7QlDDqUWszs4Vi/m8Y2u0Lhbn+dCQ2
 jQjTdiMoqzRevemU5qB1rj/uog5WLgdaGKkISLSp/481m0okdry5o7Roy2xMQkuqWPE=
X-Gm-Gg: ATEYQzw4ULR8lAjwpIMDOzF0ANUoGXka0ruia6WLENLnpX5/QP7riAVP4LMeK3HENEU
 yBoRMcKoP/30AXUft+cJWzG8zfPPq1qeMqV//A2olfALb+DBlDs4ppHjLwHScpZ252ZelnAIXxe
 5KYU6NttCYcukg+IU2cO9bVpdlF+FAyYg8m52twHRNYK7WHZPA0ebl4aribYJwlDWanJ7peJ3WJ
 1gHKBWTv1/8qFLIuqOjJaqY3GaEZbA3ZpR5pUTB0pvBLUp/wiK20gk49LzeEGX1vis3KP4OHXzl
 zuVUOc+0605voXzF69kroCAeVr2aVpMlZBiWdbC7d9ObJudG+JtiQnoUeZNtAS6Da5vbFA44nYK
 2eukSiYKQD0xGxFEjA+26IuxOynriXUIlnC3mCD0xJ73BaR6JtkwKXHMaia2SMRGhy/ERr02UKp
 GzOW903ZbN19sEybIDxnopbwE3FZ3rTp8s0OwipV+HJXmtPA==
X-Received: by 2002:a05:7300:d705:b0:2c0:cff4:b456 with SMTP id
 5a478bee46e88-2c1097ab4b0mr3018418eec.29.1774061908868; 
 Fri, 20 Mar 2026 19:58:28 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b31bef1sm7526387eec.26.2026.03.20.19.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 19:58:28 -0700 (PDT)
Date: Fri, 20 Mar 2026 19:58:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v2] net/tap: add software MAC address filtering
Message-ID: <20260320195824.341323ae@phoenix.local>
In-Reply-To: <20260320164523.810401-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260320164523.810401-2-rjarry@redhat.com>
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

On Fri, 20 Mar 2026 17:45:24 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> +	dst = rte_pktmbuf_mtod(mbuf, struct rte_ether_addr *);
> +
> +	if (likely(rte_is_unicast_ether_addr(dst))) {
> +		for (i = 0; i < TAP_MAX_MAC_ADDRS; i++) {
> +			if (rte_is_same_ether_addr(dst, &data->mac_addrs[i]))
> +				return true;
> +		}
> +		return false;
> +	}

Since unused slots are zero, probably need to drop packets with all zero dest.
