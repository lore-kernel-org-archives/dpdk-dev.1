Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B45CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 16:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 922D24029E;
	Wed, 27 Aug 2025 18:12:16 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 97D7540292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 18:12:15 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso41614665e9.0
 for <dev@dpdk.org>; Wed, 27 Aug 2025 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756311135;
 x=1756915935; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPIcIy0viyK7HYW7/WyCPNUuJvtZ3h8ajoNGBviI40E=;
 b=gQO4hKrkKxPAbQNhVZdDvgjHHcuQ4+w+S4oV4F3vcjZSPe8uFYKBl1NOjDQXwE1uLa
 iZRFJEx1TtcW7LsHsuYaAVcSJyKM8s3kJXyLZi9jO/n9SlSYmHcTp8WxhRx2+UlJvgPE
 6eWMWOC6mNcNebLkHztNZe+cS6fo4DcdF5mNYOX1F+4HQ1F5ZHqBdotNkO3wfKWmmluQ
 4Oez2fuTQIjG5KlskhPbvcGLspxduZRkL56Hhj1APaqJa31aT+qsm7Vr/OY7/OotsBx+
 oql6AWTDb0IxNLAHdUF5+r2+/FfB5ueZX4hqgPi2oPTOrDQX2ix2M6UvVSc27vhJBeB3
 nHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756311135; x=1756915935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPIcIy0viyK7HYW7/WyCPNUuJvtZ3h8ajoNGBviI40E=;
 b=ZtRCaA+RzzxA9WSf2R/t8NsMtiQYxbvyI2Q5b1l86p+VwcpiSGHq2zcD2VTUOdUzap
 KkZ/rA3rnfoemH3fZKP6fbgi8uZnUJITK98kOLhJ/YD9ZS8YCwgBggd67BrTaEUUC4Ix
 dIZTYH/q1X+PCBqNBnaC2tuiAB6p39vRVCcXOHAGgQ1qLiOSqtJ+1hELGMI9eYOGvJtq
 9rBQWg1VOCEx82YBbZHx7objW3daoCh7y9TTV3htpdWyTllnxnOuFZdi6icPze2xmNXX
 l6K2+LFcQWeOd2c4MjpH2R1Oi8XrzYoA5uyPnLwgQjgGzr1T/TQPr2GxIBnS2NckNTRf
 sRTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQoaFYfDywAuOrkWeidMJ9KnelGw1ukobgK6yPKBhkaHHPutKOC9k9P+F41wA27cMAw9I=@dpdk.org
X-Gm-Message-State: AOJu0YwdWpdzquQwfEbYPEFDCbmyaB8lP+7qYGw7GaCYaRz108YPE/8G
 PPjXl8dtffOns8szt0IU/cH0/0hBks4fKaZSx8K12V6R7jnEs5h9jCMFIMNTd5gcLEs=
X-Gm-Gg: ASbGnctnd4Y/ez4T9GPw+I17sMbX5DLuQkB6Zq392nMmVy20DJkByjSZpMU3S9twLu+
 9x8TCblvjtznpFMp+GT15cgdJtUPqOowjYJepm8sS+wWdevL43zEaMsbtl12iFmSZ+trPkq2Zcp
 gSC9+M9DoCN4G2nSY5RP1XRWvfag6kwOMRsw3d5NvBTY/TGyKMqyetx5laz96eGerkZzrB2WjQP
 itMVh4KIeUbRZ+E6ZTjvhuNZcZa+OdbMo13bUMhYbUIMiUhL+8fK4V5I1gXHDDR7JxXkUWpM1rn
 tlhaRaYztAI06L69ZfpPi7IhbA/fjV1dhgu1VTgjccVZa5Xa8TX6u9WjmR3oiGPatK466T2qXK8
 6jQ1JDOhmqqLachcpFCvjIsHvhLr2zSLl8dZnWJsrO3OolbG66AQppomazOfjDw7Fi33RBjYVQl
 4=
X-Google-Smtp-Source: AGHT+IH8+7H6gSHUAOu4Wx7/AVqqpsMiE/S+x+LtKkOeAeT40D7guIJD8VQpFuXNdQNDcyMhkfl2Eg==
X-Received: by 2002:a05:600c:c48f:b0:459:dfa8:b854 with SMTP id
 5b1f17b1804b1-45b5fbee605mr101244655e9.5.1756311134965; 
 Wed, 27 Aug 2025 09:12:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d61bfsm39135875e9.6.2025.08.27.09.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:12:14 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:12:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, <dev@dpdk.org>, Tyler Retzlaff
 <roretzla@microsoft.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Message-ID: <20250827091210.3c024a85@hermes.local>
In-Reply-To: <aK8qYCquuQyhrM5u@bricha3-mobl1.ger.corp.intel.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250818093416.057aad97@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE53@smartserver.smartshare.dk>
 <e9017361-f29b-45da-a1b0-cc745b8c906f@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE79@smartserver.smartshare.dk>
 <aK8qYCquuQyhrM5u@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 27 Aug 2025 16:55:12 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > This library (header file) is generic, and has zero interaction with the hardware and OS, so it's not an environment abstraction.
> > The EAL has become a dump for "everything else" that isn't an individual library with its own subdirectory of the /lib directory.
> > IMO, it would be nice if we could separate generic utility libraries from the EAL.
> >  
> We could start fairly easily by extracting out generic utility headers, no?

Vendoring OS headers is a bad, bad idea.
