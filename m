Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E9D0D17C
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 00:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7781A4028C;
	Thu,  8 Jan 2026 01:09:11 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 68FAF40261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 01:09:10 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so21268305e9.3
 for <dev@dpdk.org>; Wed, 07 Jan 2026 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767830950;
 x=1768435750; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ockdHHOBPTAZwIPGFiJIdHnWZCVO/ok7CHfr5k+/AoQ=;
 b=r3OfCJfjR7rRoLArvP5zgScUUOowdYAkDIm0l6SPRSutQ+2/AbmQcDxCiGMBLRu/C+
 33okQCjYMp7OepjA8p1UJFi42qMxEfvpwVtch4tZ9zm7+wI9xIdGDBfkLRveLRbkhyQD
 EPiRXgRGfsNQhEhB8C8wGE7RBudJpOEFtymXqE3PDQBxHm5xSfKgm50ymgAxJUVK/M6O
 RrTDs03acCXLs60Rx8mL7DlbHmFhD97OQHgIw/i21Y3YL05Hu/2fwg5KLG5SPGe+Y2L9
 LFy3wSSZO4hdC6LMXffN/wwD3kzFNFZTFMe8aCN8oLTdDVHC4ibkX/e799DYB67g2hT6
 t3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767830950; x=1768435750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ockdHHOBPTAZwIPGFiJIdHnWZCVO/ok7CHfr5k+/AoQ=;
 b=Yp/mkchtTPXuEa7N3ei89mk5redS1TgG0l54hvqoNI5Jy2cS6UY4nOBfnbJI0Zd1dT
 qVhul0fMw95c2ENxlP1BJmo8MtdJk5avYUX2YptvElA/j0JL5s36MgIvWG04VBBHV4Cm
 +DUA1pMk6xpJhFeCwDnWckCV9EPZMoQ8H8NoJmyTdmE0nXSyziyS9+cIG3mGl4g0aAxb
 hl0m2MnDvs3lGDJb+5ms0dlpOBuMLhaQyTQUH04FvUb/CM6itufpbpZ6E9wHUNU7XadF
 hgVByPoUGPonzkHi4w5oWcOtKO+f4cpazdmrTSlFQwQodURW6n6x+HCyy+O6cG41wskR
 rNQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX07CJUi9pRlV5G9XgzGUsfOX/boS3TSupXjw6E3jnfMATPaG9CYcoSqoD22Io36exvzQc=@dpdk.org
X-Gm-Message-State: AOJu0Yxbm/olYU5tGyG/mTz0+g7TrFXdPoakcrKybaE05uoZ9ehPIrdB
 DKYKMRgZ+zaJndSMmp81kPeUNRXergeoj4PUCwGcKTV12uO2W0gHKCd006XZu32dxUI=
X-Gm-Gg: AY/fxX6J4DCptNjDFE4xE+mnkOA/qo99KYuy2w6ScYwgBzsJxLkxe8xBSQcFphA+iR+
 RSK7B7fLhlFvkYLbFdICvHIUgzGXUeBczVXvVIELyZ2eboyDD6xRhu0VQf29b/qGcF3AMt7w7eL
 EFQgQ6LH3sUooJG4LQsfA3xrtd+AFm3TtNwhVFxOgu7RoGemQn/ZKnRryJ3YXZZN/aRaEfPy2DQ
 OuZ19CrVOSspyFxGGk82ue7OSYHhsxyzAwmULo/7oulK/NFQn8Y4LHOMm2UdK8T75wFm1zNfIAI
 H6Awa5KGy15N+ICXayeZYhM2oH9mLxXbMusxjfXHjWGU/t5dNhrTvmUymvxAUs08aR16xxu3xI6
 ej1jgCMA4g/L+gTDxdI/ulk+c5Y8rlS3kE80/qh7CGOM1m1QfkOr9wA8bRmUq23Ee4ajcU923kG
 U3qfz3gAWY01KBWDxk4ag8bx7wZA4Sc3+IJGW219jvB8NoYtPXfYPkrKYxrpUbiRQ=
X-Google-Smtp-Source: AGHT+IEoLpCnExQzUgY6vPD3HQBC3u2ki5amxh42ArZiVfc8AkZvNg71c2hh7rRR0gkZfWoqfrZIgQ==
X-Received: by 2002:a05:600c:4713:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47d84b5b43dmr56728295e9.30.1767830949796; 
 Wed, 07 Jan 2026 16:09:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6ef885sm122380805e9.9.2026.01.07.16.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 16:09:09 -0800 (PST)
Date: Wed, 7 Jan 2026 16:09:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org
Subject: Re: [PATCH v3] net: optimize raw checksum computation
Message-ID: <20260107160904.0d4c74cd@phoenix.local>
In-Reply-To: <CAFn2buCtACWQZd_EY2Y_k0KS6OQN-8BQmSghtH1CMC7afONs+w@mail.gmail.com>
References: <20260107170415.80275-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65630@smartserver.smartshare.dk>
 <CAFn2buCtACWQZd_EY2Y_k0KS6OQN-8BQmSghtH1CMC7afONs+w@mail.gmail.com>
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

On Wed, 7 Jan 2026 17:28:41 -0500
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> (sorry missed this in my last response). I tried this and a few other
> options (compound literal with each field explicitly initialized,
> zero/empty initializer) the only code solution that removed the
> warning was an explicit memset(0), but this also modified the
> assembly. Safest option is to use memset (with some runtime cost) and
> a fallback is to add the zero initializer "just in case the
> compiler/target-architecture requires it" and add `#pragma GCC
> diagnostic ignored "-Wmaybe-uninitialized"` for now to suppress
> warning. I'll push the second option in my next patch and we can
> discuss/adjust accordingly.


No pragma's please. The compiler is usually right.
