Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B0EC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:23:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB9BB4067A;
	Mon, 16 Jun 2025 18:23:03 +0200 (CEST)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51]) by mails.dpdk.org (Postfix) with ESMTP id A8C8F40677
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:23:02 +0200 (CEST)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-72c27166ab3so3460818a34.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750090982;
 x=1750695782; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IkkQgjqP6yZ2V3SO/KYF14r3DfNUfihQMWb+OZd558=;
 b=cbTwb9iqKt2xTLPJ4cncQsgMKJUnTxLw9fi3B24tbIcCNAS4hCunQlyyW7W82/Tz8q
 cZUHyi0MGs0wNPlArUoyZUITCmcKLXZ6OuV68yqV52uz2eawzEOMvRk+dIznltRQncM1
 r2wTBWViEqp7oNBOeI7k3tWl3H1ce1vZCs561RK4yLJI+mTvgiTHYLMdTm2umQ2GyyP7
 bLrTNbOYyoaZQAydmv9F7r185xBF0juHSYSS9WiyjV/4/X/gSuH4rQXv4sYBIIfSuCPt
 b1miSAB3HbK+3+99E/Pz+n8BgdK1VABCu19QzFKbZWNLDyUWvdpLzIgMBLKSba3JOu2R
 g6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090982; x=1750695782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IkkQgjqP6yZ2V3SO/KYF14r3DfNUfihQMWb+OZd558=;
 b=hAo3JyDaXpKdAuU1YpdOULlG2JqQzLaJPclPgbxvT7bBSAt6mS8ebp+wYteVerxp/G
 KmsZ3e0VTkb1Ut8+DFaBQWCXhftKxeg7oBUo16ekxN12x4eXxy+op29AhCgybuUQ2jLi
 9Wvjdcp8APJ4qU7qtYUZe6kw6cC+wrk20LmLXekvqY0+WefidaLUqzA+U9NS7U/WXNmn
 lBIRH6TBtBdr0hObBd+TdCK+3LcHzWGAtHk/obCB4qSYuNAM3gS3IV2VmSLNaCX0Ngrj
 wofg8HjZ3Is4FSV7cZjuKwq1hNjBvMnAX5xa/ywULLfBOz3jOYKlZ4S11t/hgkPyQfkw
 yZpw==
X-Gm-Message-State: AOJu0Ywp9dbCLpz4zJp/OYynaQVvLcv+5UUPQt4bNzyDkSVzZx3i7FaK
 5yqSNefTOuqt15gIe/0w3q7rqPRxL1wns/8VZOx8KsB7avQtRfv8HyW2PtVjfL/D6rg=
X-Gm-Gg: ASbGncslIR4lais95VYnpcdJdigApSQb27E2pkXQn0/auQSx1vv1LCl+9KLEV7dxW4f
 at5YfXKsrkO/IIAGMY97+KvFD8vR007NZMm3bgyLGg97vFfpvXKtzUCqDfzcMvHMUooPTtVy82K
 abcAMZ3DphckZjD31uapj0y/ss8DgpYqy0DmEw9K4I5UOx6zSWeHOLiqpMWAgicoJ9saGEJtl/i
 gReapxCTBpP3qNONxMYra2nlxE5ieMi8rb8EBFRRvheWBZ6vh8LW5UUQT8miMNroUvuzCFa9IlU
 zcCK3IlqxeMVoUclpKM904SM+gpzCYkatufdUs4nloy5ac9DfY93AOrR8+j9GQzwITzdtlBu6Zh
 qd94YlPuDolrmGzy2BDmmMXWLBpIdkOZah4+4ZCY=
X-Google-Smtp-Source: AGHT+IGFn5zmhxl25IZ2LyuAIfn0+ptuZ2FP5C5LhG5ikjEwQDnZJKhfTiDjpZSDB+kTZGTGXifaqw==
X-Received: by 2002:a05:6830:3747:b0:72b:8326:f0c7 with SMTP id
 46e09a7af769-73a364427edmr6722949a34.28.1750090981929; 
 Mon, 16 Jun 2025 09:23:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a2855872fsm1242876a34.69.2025.06.16.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:23:01 -0700 (PDT)
Date: Mon, 16 Jun 2025 09:16:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 1/3] net/zxdh: modify some MAC config issues
Message-ID: <20250616091658.1f87ee11@hermes.local>
In-Reply-To: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
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

On Sat,  7 Jun 2025 10:30:18 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> modify some mac config issues,
> which were discovered during the testing process.

This sounds like you fixed one or more bugs.
In which case patch should be sent with the Fixes: tag
so that stable maintainers know if it should be backported.

