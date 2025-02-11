Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8A0C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:24:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A8144066F;
	Tue, 11 Feb 2025 17:24:42 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id D11404066A
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:40 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so7554272a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291080;
 x=1739895880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSW4YnSURPBYzTkV7bC4RFJyfEnneI3shOhxZvcUwkI=;
 b=RGo9u0BgWLiln5BDcCRx4/uJEHsh/d+My86gvUrlv7EnJA3aBaki+NC1eQ3bslh2i6
 x+sQYl8qgywPtzIRnWG+AdXGokBtWwF0u2sbiCRomsCt1fpIq/kJALpGcYMCmQPBCtmq
 actKhilDt8mc9Z0jmpegDK+GbxMZl82eweUhX4CbyVKdbzSIqmk31qIO5QN92F2cfd+4
 sRuyGjZzViqDw2NHURMFvQSRyM/+ce0Si2qMafgfUSFo+HMeSprw96WqtmyS6/qAC1Dm
 DUPkZqvQ8Gloc15YQCwezZt0R6Vz26hqcUta5jQwFOpt62a+4SXCghfJz5LHqX1wfYXl
 n8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291080; x=1739895880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSW4YnSURPBYzTkV7bC4RFJyfEnneI3shOhxZvcUwkI=;
 b=wx98057/x8nO3gZjhyhpWaZwuMb0bO9737vQA+3aJCTlJjwCefX82ILtwNahUiTW/V
 wMsWbGnP1mCr+XSVxggA2HUZghBxfU7sgFKHXBlHaaaMMAJxbMPItaS7UyxMUF9YvfpJ
 grO+5NryTTpSewhAxFRxihXCL1VVmwrBOfBHZI/jnyZe1PYlmrzp2h2v32L79cJMBXdU
 KiKJaOd2ZXoMDQmq1Fiprkk4lWGuxvtdBsFZbd22cCEl/xX9QLiSyF6bTWONET+lNGnL
 nmH9nNpL5i9cvgv0UzHW8yph3FaDMA94gtdlPIO6QG8j3Dz6OT9OGOC/+B0vtQ1SYjwR
 wBIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxvcqnWI24b3R1Yx8bYiRr2i8X4d+5honSVsKH2viO23ULbrFDtSi45sgPRfgkz/Yu2ww=@dpdk.org
X-Gm-Message-State: AOJu0Yypjr/KiqlnXw72DuFMuSAIQJFFtss+3HM2ixcqHcl180HnHyfi
 bQAG09EDalV3PXSGHefermQjrvvZ6GJLI8z30KX6GCH7riwtc5obp02sgoKaN8M=
X-Gm-Gg: ASbGncvLh/JFofy6920VS+yOhmsHXYE1BONBR3Y6CTty77bwnEPDpunmb07ObR2AGtw
 R8iXJbYCugpbjr7juziHxXObZue6nNax+SHDwzUu/BAhKjlksXaHLeJN2aeS+0iCis00i3za4IQ
 4Ij/hOGHFPx4e65nzJyeQLO1oA91FVTv6l/LvZqTp3hHhGzwp6sTBMUZQlrryVoY9nfgWA23OpQ
 PcKm0gGRm5Lo6nMXZ3H7wQGw5+5djdtSBiaG2e9mAfCDpIt7wNApV01Bxbu498IbOsv6xvnOG+T
 lx/Rjc1DMLMBkqWGL5cw5yJavHs/F0GxZ/fxm+34bB20Pnb0RPDuhDF3HsxCVCh7CaS5
X-Google-Smtp-Source: AGHT+IGorHnPCozbuzYsZAQvqWwJIRaoImgILAeEyF1CGCCQyCfpVgIPVLkBTt07+dsXz2bUesQulQ==
X-Received: by 2002:a17:90a:d643:b0:2fa:20f4:d27f with SMTP id
 98e67ed59e1d1-2fa9ee31752mr5413468a91.32.1739291080000; 
 Tue, 11 Feb 2025 08:24:40 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:39 -0800 (PST)
Date: Tue, 11 Feb 2025 07:35:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 12/28] net/rnp: add support link update operations
Message-ID: <20250211073503.78f084ff@hermes.local>
In-Reply-To: <1739263818-59770-13-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-13-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 16:50:02 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> static int
> +rnp_mbx_fw_reply_handler(struct rnp_eth_adapter *adapter,
> +			 struct rnp_mbx_fw_cmd_reply *reply)
> +{
> +	struct rnp_mbx_req_cookie *cookie;
> +
> +	RTE_SET_USED(adapter);
> +	/* dbg_here; */
> +	cookie = reply->cookie;
> +	if (!cookie || cookie->magic != RNP_COOKIE_MAGIC) {
> +		RNP_PMD_ERR("[%s] invalid cookie:%p opcode: "
> +				"0x%x v0:0x%x",
> +				__func__,
> +				cookie,
> +				reply->opcode,
> +				*((int *)reply));

Don't break messages across lines in source. It makes it harder to search.
You don't need __func__, it is already being added by the macro.

> +		return -EIO;
> +	}
> +	if (cookie->priv_len > 0)
> +		rte_memcpy(cookie->priv, reply->data, cookie->priv_len);

Use memcpy instead of rte_memcpy in all new code.

> +
> +	cookie->done = 1;
> +	if (reply->flags & RNP_FLAGS_ERR)
> +		cookie->errcode = reply->error_code;
> +	else
> +		cookie->errcode = 0;
> +
> +	return 0;
> +}
