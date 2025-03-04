Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043A4C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 20:37:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39612402EB;
	Tue,  4 Mar 2025 21:37:43 +0100 (CET)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by mails.dpdk.org (Postfix) with ESMTP id 22C77402DF
 for <dev@dpdk.org>; Tue,  4 Mar 2025 21:37:42 +0100 (CET)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-30b9b1979b9so50023621fa.1
 for <dev@dpdk.org>; Tue, 04 Mar 2025 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741120661; x=1741725461; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8U4wQuBBfGADsMgTBtzinHRf6bYB/PeT18IahVrsqbg=;
 b=YD1nRX2p/7CwnEIwYftmjA7B6EtPIKOq2NvDOiGh/L9I5Wif5DFZXhZKat7d+VJr9e
 kv7rsNV6QfwSvbOqMfisNJ/DvvGzvHdJpOWCm7OGJb/AktuHll34TfSlgMvr2A+6rO3f
 yxSwgimydu/XdV6Kwrgy3EuTiFSSgzjEZFhLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741120661; x=1741725461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8U4wQuBBfGADsMgTBtzinHRf6bYB/PeT18IahVrsqbg=;
 b=mrurmfb3piDVfohc4NR1qMg3Clz1V37gZa0p+T84fMSC15yzGvU1G+U7RqFeIM3gH9
 Ez0JFTTT+RrIG9p976qz3uAUUm71uybobq0lGgqnTConkVbIiopxUOuIbj5zFJPPo1Nl
 NoC8lYYSg/UkAGNALm1OyntYN7/fMrhJ+sjXBpQChocm/o87OGamltEWOOB7gMUT8cqu
 BxhHelpMCdtGXQhSm7mfFi1JOotdGafYFU3Ybs1J/+t6lQLPqo+ioSM0LMQoThUPQvLC
 HU9OcKwlIXQv2naNb3WZJCVqcSUsAvo5VPStqyp7Nk0epjIx+uFPll6QKmxJOBg1d5+h
 OE/A==
X-Gm-Message-State: AOJu0Yx+Rbahm/Irf0i5Ex+FvguBqAjCApfZD88tnrAlh6JmYVWPyLVL
 3v1svWokSIrrhT4HnLxrJQPlD6Sj3kDt1Dc41I311UPaqhR05PFS8CgpHb7683Ak0blIAZOefSr
 U0/8CVzlkYntsZwXMICTaagxNChEBgeomYEGuYw==
X-Gm-Gg: ASbGncsaZpf+Vorasx04R6JpnwKx3AgH3fTf95T24/xRc8mWV2mqp7RFjmZL+i8lAY6
 OqwKQ579uz0AM4iCwPCqpOOP1QP+zqQctuJ0bkfD+lnbYjJTpGJB/an0T0S/zHDQoLD0T2OeVXf
 1L+oWn9hnZjev4CuPbJdoMrFqM4Wd7o99IwMA7GV5+KFqx0oh/7cBq/FXYdVQ4
X-Google-Smtp-Source: AGHT+IEOoA7FoIQPxLm8FCtQLYUOtgyOaWzMWETrzD+XImZLmT/4RBBS7fr+J19WsRPGsxvU5AkeDlcgHEo7dhiJyjw=
X-Received: by 2002:a05:651c:b08:b0:30b:8e06:86a3 with SMTP id
 38308e7fff4ca-30bd7a702e7mr1588611fa.16.1741120661430; Tue, 04 Mar 2025
 12:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
 <20250303145709.126126-7-Luca.Vizzarro@arm.com>
In-Reply-To: <20250303145709.126126-7-Luca.Vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 4 Mar 2025 15:37:24 -0500
X-Gm-Features: AQ5f1JoCJta3CEYuFbFJM229OUu6U4W1ehxWfkZwA1VblfUlocwJBwe1d-AdmRs
Message-ID: <CABD7UXOLUd+zwM6zG4DMeo0RxCE5Ry3R+GxZ+zB32vCOuoJjBQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dts: add per-test-suite configuration
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
Content-Type: text/plain; charset="UTF-8"
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

I like this implementation a lot, it's concise and easy to use.

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
