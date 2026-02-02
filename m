Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DB3E7DF05
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 16:58:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2794027D;
	Mon,  2 Feb 2026 17:58:36 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 551E44026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 17:58:35 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so2918273f8f.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770051515;
 x=1770656315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZ9mmD7qm75c46Jq9gew4mbwgyZZ+uFiPgH0BLO9sYw=;
 b=EnZ2JGtX43RM/2ZrYw+HJk6nyOkcbPKiUJgacOD79eCXETxmAxJMU+AeCeRSvDFSFN
 MXHvKlt1hnrUcilRzxCHYokonMT6Q9AUEayabarGZ4ew112I7g+6Rk9bTL19x0Qc9tU+
 AxfXpIhOpU3KcCNcpBwVmT2UiLKSZkrRFJrqBYXR9YcLGfZ2/YScpMQYlrJWk7+nKhE+
 jA/v1TjRKELDotWotC5zo2JkZJk4XswvLOHtzGnxJEN63hRcR6nZGQ5roNzbAWWh4G4+
 wWSNfAYwjSCLAxpl2KShoVIEZHoo0EZVOR9/GptAyBBfTwCdeD/g6OFZTZWm/AqoPZ24
 X2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770051515; x=1770656315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wZ9mmD7qm75c46Jq9gew4mbwgyZZ+uFiPgH0BLO9sYw=;
 b=iG2IivoedC37/5T9t0PxQu5WMhA2ecQlw6eNzwGQolKkW9CfHHkvhzSrel7ALcSPd0
 aa/Iw56NPmC6KNKLO4j7NvF3TIQH1yaCK2iXkyzQ8PWaz87jT7KRIdM47LDKvIbWO+AF
 rr4K8qOkOec1cQCK84kJXT4wHBU1R6+e/uJcSlZNkSstDq6nysbMyqxSurMp3TEFFPPe
 /54Y0afpmv9QQXeaKSJ2teuPsKEoWPhudtVoN6L+aPhMhw1l2S3/onKF+8CTrdNKZ9OO
 FZDll7wAXBKTACUz6D+Vduv25n6JIyFMQES9JBr9OFXDKtt6b1Tq1PRjaxXMegZdEWZP
 SkEA==
X-Gm-Message-State: AOJu0Yz8gN3cqu42ijmJ9oJipk5un3L8fm5OeqctMrr9sKqM0eJ2uIJP
 wvcTjc67iDxk+1cYbHuzu8eeEzIaUNgN1XmcjvuTpiYNYv469LkLEec5OnYLAmMyoww=
X-Gm-Gg: AZuq6aKipeH2HSZrXvx9KskSrEmtBnFS7JH2HpSlLW4YvPOI+qyklnVSjvzhZNzCvkA
 G2+ML4FFQkAjU6TmFYxlUQsAyVy4UpLo7UoU+W4ZmVla3JS+FcAjcEw9T5zkDWIwP/0fgkFWvFc
 uZsXHDSqZtZIqBB2D3TMWjLMiOSAe5z8kmY85sGxL1bLqm/+b/LfUsZ4BMHThZZRhyiREmkdZUt
 MEUAKyo9UoLWgvNVZPs8EeCL3mSaGylYhf1PE4BsUYLvnjmB25cT1ks90TmI26ujQYMSpZuBMSy
 dPMipCBsWKDpR8QFFS25ugGWuEWZatQrbuCXfVSKEteEZVo29pOnrjiifIIFXQZoOGjW4ePZQEa
 RoSFu6KOVt2kKWcMPerrr99ORDDtTPA9KQYuYwMAr7qEcnBQl9/kV5W5kpbm3wzj4vTYyyGSCyv
 aZV95ASXOf1rhRdwgKv/tm+e0Pi7ZzLksyy0U0QGiaNqttA/Ks7kjcyDwt6Dn+/HA=
X-Received: by 2002:a05:6000:601:b0:435:9d70:f2a6 with SMTP id
 ffacd0b85a97d-435f3abc64cmr17914806f8f.63.1770051514687; 
 Mon, 02 Feb 2026 08:58:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322dc7sm45548198f8f.37.2026.02.02.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 08:58:34 -0800 (PST)
Date: Mon, 2 Feb 2026 08:58:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [REVIEW] net/af_packet: software checksum
Message-ID: <20260202085829.5f44453e@phoenix.local>
In-Reply-To: <CAFn2buADZwWCy0HX3sVnrvwSXri1jG2LXSu7XwWc_R_5rrjCRw@mail.gmail.com>
References: <20260128191032.78916-5-scott.k.mitch1@gmail.com>
 <697a8646.df0a0220.20404.ed58@mx.google.com>
 <CAFn2buADZwWCy0HX3sVnrvwSXri1jG2LXSu7XwWc_R_5rrjCRw@mail.gmail.com>
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

On Sun, 1 Feb 2026 23:55:21 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> Will resolve comments in v4.
> 
> Also I've noticed the AI feedback often has paragraphs that end with
> "this is fine". Is there any way to suppress those as they take time
> to read/parse/understand?

I have been playing "whack-a-mole" to suppress these.
There are magic words to say in the AI prompt that help but nothing
seems to completely eliminate the "never mind" feedback.
