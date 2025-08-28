Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D938C8303F
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 12:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A7854025A;
	Thu, 28 Aug 2025 14:55:55 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 4ED0E400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 14:55:54 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-32326e20aadso1023560a91.2
 for <dev@dpdk.org>; Thu, 28 Aug 2025 05:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756385753; x=1756990553; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vBHS5Amqf7wevVi0QGMRDeGo8qwPqdQa/PTJSeBTppA=;
 b=SmVLew8TaSw6A37ZjFqIYwcfG2d4uGapBszAZCBMFfpueb55kdi7GEUp64gdopYAfz
 BxfUgoPftQS1HG+31GdyqahZjFsmYpWKGNfuOqBKcYTjAIg6HDuJREtjgFiECig1R+X1
 AxD5gL226h1JrxiRloRghMjXYdOHbIuZQERTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756385753; x=1756990553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vBHS5Amqf7wevVi0QGMRDeGo8qwPqdQa/PTJSeBTppA=;
 b=s2CfqSLeRTP3lACwmTzhsejFNta1+DeHAM96CxcyBc59oO00/+PnkZmX55m9uwzydc
 GewdUG1L6evhg3XoPOhaj3SeKYjKrpEDnBS1LJNNJGQGmxbj2mN38pL2y8WhT184HynD
 1U/vWmMkghFAE1HlYRgA6qNqEBJIuCa8artG9lGSlEJAygbMlA0md+iBbHeGDTC3LAq2
 ZCaIounr0OaggY6cELk5gJ3wTdqZXaS8FX3Zfj58YgiFwvPTCKqcMkItJuQ1mjPjds81
 yDhcCRgkNpNxpW9mXClBmSf2Lxu8uQSEkNAxWzuYy3PG1RAR5VlzPsG1pzYs5DTxF02g
 PC6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeOHdz97naBsTcUE6Uaa/O0mY4OQn8njRjM8MFBxpOpbXZdVd5j9rigl1czTD6/8/rnc0=@dpdk.org
X-Gm-Message-State: AOJu0YzBo67eaAk8uPHhjBJ0BH6T4LrCcwk3/uTufbLX7yVDxDinqV/w
 f+S4IrvRRRYKr16P0pg9CjAmpjWQNrHxIuVGdBB5a+jRgcaj5HwBWt5WV37sNkTQELaAqEXqMD/
 CpqKQXquFiG80fuV7uu16QrWqvbK/0JXyTKTqrAvjHQ==
X-Gm-Gg: ASbGnct9yV3t2PVh8TgDK4xpMVEkQOzSdSFluoFyW3UpMUEZDl4vTA7tO+6Lx+5ihDh
 N5eXEcRxhKoPdcCOlnY4hUV2ACyfWBUulzR7q3Yc2VJCJLHtFBOvHFXHmnAuE/DmdV7gSYV+Vl+
 xu+HKBe5eKSrlqNYYGsK0kJeFLPRAWcZlBrQt3vXDHMLqAXHKxhas9IIbPrLjXmOVQ2q9hqq42g
 ufMqe0hd9nBYC1R0hGvYiyenr1Uo3BzToPy1deRrYTnATM2fg==
X-Google-Smtp-Source: AGHT+IE1Dr0sOqDJnSyXNkm+yMeSkA/S1gq80abW6oj+5Aabqnr+42MjnWjVo6dOEBoKFEhC4aRn9XlzMesnkY4QoHo=
X-Received: by 2002:a17:90a:e7cb:b0:327:be52:9675 with SMTP id
 98e67ed59e1d1-327be52992bmr1589541a91.0.1756385753378; Thu, 28 Aug 2025
 05:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250820151215.47742-1-dmarx@iol.unh.edu>
In-Reply-To: <20250820151215.47742-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 28 Aug 2025 08:49:13 -0400
X-Gm-Features: Ac12FXzCJ92B9apf0t-wKEffNKCv_uCC6NSPJGJ4Yu2UorNDZtbRIgA6Qk0DTq0
Message-ID: <CAJvnSUDRc1Q_JMYB1i69t=dByY2L2iEjDagS9auq2JWH3+R=0w@mail.gmail.com>
Subject: Re: [PATCH v1] dts: remove test_ prefix from test case names
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000eb4477063d6c6c47"
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

--000000000000eb4477063d6c6c47
Content-Type: text/plain; charset="UTF-8"

Applied to next-dts, thanks.

--000000000000eb4477063d6c6c47
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Applied to next-dts, thanks.</div>

--000000000000eb4477063d6c6c47--
